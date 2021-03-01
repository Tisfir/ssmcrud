package cn.itcrud.domain;

/**
 * @author L.N
 * @creat 2021-02-24-15:19
 */
public class Emp_Dept extends Employee {
    private String dept_name;

    public String getDept_name() {
        return dept_name;
    }

    public void setDept_name(String dept_name) {
        this.dept_name = dept_name;
    }

    @Override
    public String toString() {
        return super.toString()+"Emp_Dept{" +
                "dept_name='" + dept_name + '\'' +
                '}';
    }
}
