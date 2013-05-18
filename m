From: Prathyush K <prathyush-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v6 12/12] iommu/exynos: add debugfs entries for System MMU
Date: Sat, 18 May 2013 10:56:28 +0530
Message-ID: <CAH=HWYMqxC-RVrxkMHqF_Ap1=VvLx3G1vzfb0SPguOwks=-i8A@mail.gmail.com>
References: <003f01cde30b$f2891d30$d79b5790$%cho@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6965342516833795120=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <003f01cde30b$f2891d30$d79b5790$%cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Hyunwoong Kim <khw0178.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Prathyush <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Subash Patel <supash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Linux Samsung SOC <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Rahul Sharma <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============6965342516833795120==
Content-Type: multipart/alternative; boundary=089e0117691f6be10604dcf7570d

--089e0117691f6be10604dcf7570d
Content-Type: text/plain; charset=ISO-8859-1

Hi Mr. Cho,

any update on this patchset? Are you working on v7?

Regards,
Prathyush



On Wed, Dec 26, 2012 at 7:24 AM, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:

> This commit adds debugfs directory and nodes for inspecting internal
> state of System MMU.
>
> Signed-off-by: KyongHo Cho <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/iommu/exynos-iommu.c | 204
> +++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 198 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 9753e0e..78c0eb7 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -26,12 +26,17 @@
>  #include <linux/list.h>
>  #include <linux/memblock.h>
>  #include <linux/export.h>
> +#include <linux/fs.h>
> +#include <linux/seq_file.h>
> +#include <linux/debugfs.h>
>  #include <linux/string.h>
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
>
>  #include <asm/cacheflush.h>
>
> +#define MODULE_NAME "exynos-sysmmu"
> +
>  /* We does not consider super section mapping (16MB) */
>  #define SECT_ORDER 20
>  #define LPAGE_ORDER 16
> @@ -223,6 +228,7 @@ struct sysmmu_drvdata {
>         struct sysmmu_prefbuf pbufs[MAX_NUM_PBUF];
>         int num_pbufs;
>         struct sysmmu_version ver;
> +       struct dentry *debugfs_root;
>         struct iommu_domain *domain;
>         unsigned long pgtable;
>         bool runtime_active;
> @@ -1066,6 +1072,8 @@ static void __init __sysmmu_init_mmuname(struct
> device *sysmmu,
>         }
>  }
>
> +static void __create_debugfs_entry(struct sysmmu_drvdata *drvdata);
> +
>  static int __init exynos_sysmmu_probe(struct platform_device *pdev)
>  {
>         int i, ret;
> @@ -1134,6 +1142,8 @@ static int __init exynos_sysmmu_probe(struct
> platform_device *pdev)
>
>                 data->runtime_active = !pm_runtime_enabled(dev);
>
> +               __create_debugfs_entry(data);
> +
>                 platform_set_drvdata(pdev, data);
>
>                 dev->archdata.iommu = &sysmmu_placeholder;
> @@ -1238,7 +1248,7 @@ static struct platform_driver exynos_sysmmu_driver
> __refdata = {
>         .probe          = exynos_sysmmu_probe,
>         .driver         = {
>                 .owner          = THIS_MODULE,
> -               .name           = "exynos-sysmmu",
> +               .name           = MODULE_NAME,
>                 .pm             = &__pm_ops,
>                 .of_match_table = of_match_ptr(sysmmu_of_match),
>         }
> @@ -1631,6 +1641,8 @@ static struct iommu_ops exynos_iommu_ops = {
>         .pgsize_bitmap = SECT_SIZE | LPAGE_SIZE | SPAGE_SIZE,
>  };
>
> +static struct dentry *sysmmu_debugfs_root; /* /sys/kernel/debug/sysmmu */
> +
>  static int __init exynos_iommu_init(void)
>  {
>         int ret;
> @@ -1642,17 +1654,197 @@ static int __init exynos_iommu_init(void)
>                 return -ENOMEM;
>         }
>
> -       ret = platform_driver_register(&exynos_sysmmu_driver);
> +       ret = bus_set_iommu(&platform_bus_type, &exynos_iommu_ops);
> +       if (ret) {
> +               kmem_cache_destroy(lv2table_kmem_cache);
> +               pr_err("%s: Failed to register IOMMU ops\n", __func__);
> +               return -EFAULT;
> +       }
>
> -       if (ret == 0)
> -               ret = bus_set_iommu(&platform_bus_type, &exynos_iommu_ops);
> +       sysmmu_debugfs_root = debugfs_create_dir("sysmmu", NULL);
> +       if (!sysmmu_debugfs_root)
> +               pr_err("%s: Failed to create debugfs entry, 'sysmmu'\n",
> +                                                       __func__);
> +       if (IS_ERR(sysmmu_debugfs_root))
> +               sysmmu_debugfs_root = NULL;
>
> +       ret = platform_driver_register(&exynos_sysmmu_driver);
>         if (ret) {
> -               pr_err("%s: Failed to register exynos-iommu driver.\n",
> -                                                               __func__);
>                 kmem_cache_destroy(lv2table_kmem_cache);
> +               pr_err("%s: Failed to register System MMU driver\n",
> __func__);
>         }
>
>         return ret;
>  }
>  subsys_initcall(exynos_iommu_init);
> +
> +static int debug_string_show(struct seq_file *s, void *unused)
> +{
> +       char *str = s->private;
> +
> +       seq_printf(s, "%s\n", str);
> +
> +       return 0;
> +}
> +
> +static int debug_sysmmu_list_show(struct seq_file *s, void *unused)
> +{
> +       struct sysmmu_drvdata *drvdata = s->private;
> +       struct platform_device *pdev = to_platform_device(drvdata->sysmmu);
> +       int idx, maj, min, ret;
> +
> +       seq_printf(s, "SysMMU Name | Ver | SFR Base\n");
> +
> +       if (pm_runtime_enabled(drvdata->sysmmu)) {
> +               ret = pm_runtime_get_sync(drvdata->sysmmu);
> +               if (ret < 0)
> +                       return ret;
> +       }
> +
> +       for (idx = 0; idx < drvdata->nsfrs; idx++) {
> +               struct resource *res;
> +
> +               res = platform_get_resource(pdev, IORESOURCE_MEM, idx);
> +               if (!res)
> +                       break;
> +
> +               maj = __sysmmu_version(drvdata, idx, &min);
> +
> +               if (drvdata->mmuname) {
> +                       if (maj == 0)
> +                               seq_printf(s, "%11.s | N/A | 0x%08x\n",
> +                                       drvdata->mmuname[idx], res->start);
> +                       else
> +                               seq_printf(s, "%11.s | %d.%d | 0x%08x\n",
> +                               drvdata->mmuname[idx], maj, min,
> res->start);
> +               } else {
> +                       if (maj == 0)
> +                               seq_printf(s, "N/A | 0x%08x\n",
> res->start);
> +                       else
> +                               seq_printf(s, "%d.%d | 0x%08x\n",
> +                                                       maj, min,
> res->start);
> +               }
> +       }
> +
> +       if (pm_runtime_enabled(drvdata->sysmmu))
> +               pm_runtime_put(drvdata->sysmmu);
> +
> +       return 0;
> +}
> +
> +static int debug_next_sibling_show(struct seq_file *s, void *unused)
> +{
> +       struct device *dev = s->private;
> +
> +       if (dev->parent &&
> +               !strncmp(dev_name(dev->parent),
> +                       MODULE_NAME, strlen(MODULE_NAME)))
> +               seq_printf(s, "%s\n", dev_name(dev->parent));
> +       return 0;
> +}
> +
> +static int __show_master(struct device *dev, void *data)
> +{
> +       struct seq_file *s = data;
> +
> +       if (strncmp(dev_name(dev), MODULE_NAME, strlen(MODULE_NAME)))
> +               seq_printf(s, "%s\n", dev_name(dev));
> +       return 0;
> +}
> +
> +static int debug_master_show(struct seq_file *s, void *unused)
> +{
> +       struct device *dev = s->private;
> +
> +       device_for_each_child(dev, s, __show_master);
> +       return 0;
> +}
> +
> +static int debug_string_open(struct inode *inode, struct file *file)
> +{
> +       return single_open(file, debug_string_show, inode->i_private);
> +}
> +
> +static int debug_sysmmu_list_open(struct inode *inode, struct file *file)
> +{
> +       return single_open(file, debug_sysmmu_list_show, inode->i_private);
> +}
> +
> +static int debug_next_sibling_open(struct inode *inode, struct file *file)
> +{
> +       return single_open(file, debug_next_sibling_show,
> inode->i_private);
> +}
> +
> +static int debug_master_open(struct inode *inode, struct file *file)
> +{
> +       return single_open(file, debug_master_show, inode->i_private);
> +}
> +
> +static const struct file_operations debug_string_fops = {
> +       .open = debug_string_open,
> +       .read = seq_read,
> +       .llseek = seq_lseek,
> +       .release = single_release,
> +};
> +
> +static const struct file_operations debug_sysmmu_list_fops = {
> +       .open = debug_sysmmu_list_open,
> +       .read = seq_read,
> +       .llseek = seq_lseek,
> +       .release = single_release,
> +};
> +
> +static const struct file_operations debug_next_sibling_fops = {
> +       .open = debug_next_sibling_open,
> +       .read = seq_read,
> +       .llseek = seq_lseek,
> +       .release = single_release,
> +};
> +
> +static const struct file_operations debug_master_fops = {
> +       .open = debug_master_open,
> +       .read = seq_read,
> +       .llseek = seq_lseek,
> +       .release = single_release,
> +};
> +
> +static void __init __create_debugfs_entry(struct sysmmu_drvdata *drvdata)
> +{
> +       if (!sysmmu_debugfs_root)
> +               return;
> +
> +       drvdata->debugfs_root =
> debugfs_create_dir(dev_name(drvdata->sysmmu),
> +
> sysmmu_debugfs_root);
> +       if (!drvdata->debugfs_root)
> +               dev_err(drvdata->sysmmu, "Failed to create debugfs
> dentry\n");
> +       if (IS_ERR(drvdata->debugfs_root))
> +               drvdata->debugfs_root = NULL;
> +
> +       if (!drvdata->debugfs_root)
> +               return;
> +
> +       if (!debugfs_create_u32("enable", 0664, drvdata->debugfs_root,
> +                                               &drvdata->activations))
> +               dev_err(drvdata->sysmmu,
> +                               "Failed to create debugfs file
> 'enable'\n");
> +
> +       if (!debugfs_create_x32("pagetable", 0664, drvdata->debugfs_root,
> +                                               (u32 *)&drvdata->pgtable))
> +               dev_err(drvdata->sysmmu,
> +                               "Failed to create debugfs file
> 'pagetable'\n");
> +
> +       if (!debugfs_create_file("sysmmu_list", 0444,
> drvdata->debugfs_root,
> +                                       drvdata, &debug_sysmmu_list_fops))
> +               dev_err(drvdata->sysmmu,
> +                       "Failed to create debugfs file 'sysmmu_list'\n");
> +
> +       if (!debugfs_create_file("next_sibling", 0x444,
> drvdata->debugfs_root,
> +                               drvdata->sysmmu, &debug_next_sibling_fops))
> +               dev_err(drvdata->sysmmu,
> +                       "Failed to create debugfs file 'next_siblings'\n");
> +
> +       if (!debugfs_create_file("master", 0x444, drvdata->debugfs_root,
> +                               drvdata->sysmmu, &debug_master_fops))
> +               dev_err(drvdata->sysmmu,
> +                       "Failed to create debugfs file 'next_siblings'\n");
> +}
> --
> 1.8.0
>
>
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>

--089e0117691f6be10604dcf7570d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Mr. Cho,<div><br></div><div>any update on this patchset=
? Are you working on v7?</div><div><br></div><div style>Regards,</div><div =
style>Prathyush</div><div style><br></div></div><div class=3D"gmail_extra">=
<br>
<br><div class=3D"gmail_quote">On Wed, Dec 26, 2012 at 7:24 AM, Cho KyongHo=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" target=3D"=
_blank">pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
This commit adds debugfs directory and nodes for inspecting internal<br>
state of System MMU.<br>
<br>
Signed-off-by: KyongHo Cho &lt;<a href=3D"mailto:pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org">pu=
llip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org</a>&gt;<br>
---<br>
=A0drivers/iommu/exynos-iommu.c | 204 +++++++++++++++++++++++++++++++++++++=
++++--<br>
=A01 file changed, 198 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c<br=
>
index 9753e0e..78c0eb7 100644<br>
--- a/drivers/iommu/exynos-iommu.c<br>
+++ b/drivers/iommu/exynos-iommu.c<br>
@@ -26,12 +26,17 @@<br>
=A0#include &lt;linux/list.h&gt;<br>
=A0#include &lt;linux/memblock.h&gt;<br>
=A0#include &lt;linux/export.h&gt;<br>
+#include &lt;linux/fs.h&gt;<br>
+#include &lt;linux/seq_file.h&gt;<br>
+#include &lt;linux/debugfs.h&gt;<br>
=A0#include &lt;linux/string.h&gt;<br>
=A0#include &lt;linux/of.h&gt;<br>
=A0#include &lt;linux/of_platform.h&gt;<br>
<br>
=A0#include &lt;asm/cacheflush.h&gt;<br>
<br>
+#define MODULE_NAME &quot;exynos-sysmmu&quot;<br>
+<br>
=A0/* We does not consider super section mapping (16MB) */<br>
=A0#define SECT_ORDER 20<br>
=A0#define LPAGE_ORDER 16<br>
@@ -223,6 +228,7 @@ struct sysmmu_drvdata {<br>
=A0 =A0 =A0 =A0 struct sysmmu_prefbuf pbufs[MAX_NUM_PBUF];<br>
=A0 =A0 =A0 =A0 int num_pbufs;<br>
=A0 =A0 =A0 =A0 struct sysmmu_version ver;<br>
+ =A0 =A0 =A0 struct dentry *debugfs_root;<br>
=A0 =A0 =A0 =A0 struct iommu_domain *domain;<br>
=A0 =A0 =A0 =A0 unsigned long pgtable;<br>
=A0 =A0 =A0 =A0 bool runtime_active;<br>
@@ -1066,6 +1072,8 @@ static void __init __sysmmu_init_mmuname(struct devic=
e *sysmmu,<br>
=A0 =A0 =A0 =A0 }<br>
=A0}<br>
<br>
+static void __create_debugfs_entry(struct sysmmu_drvdata *drvdata);<br>
+<br>
=A0static int __init exynos_sysmmu_probe(struct platform_device *pdev)<br>
=A0{<br>
=A0 =A0 =A0 =A0 int i, ret;<br>
@@ -1134,6 +1142,8 @@ static int __init exynos_sysmmu_probe(struct platform=
_device *pdev)<br>
<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data-&gt;runtime_active =3D !pm_runtime_ena=
bled(dev);<br>
<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 __create_debugfs_entry(data);<br>
+<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 platform_set_drvdata(pdev, data);<br>
<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev-&gt;archdata.iommu =3D &amp;sysmmu_plac=
eholder;<br>
@@ -1238,7 +1248,7 @@ static struct platform_driver exynos_sysmmu_driver __=
refdata =3D {<br>
=A0 =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D exynos_sysmmu_probe,<br>
=A0 =A0 =A0 =A0 .driver =A0 =A0 =A0 =A0 =3D {<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0 =A0 =A0 =A0 =A0=3D THIS_MODULE,<=
br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D &quot;exynos-sy=
smmu&quot;,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D MODULE_NAME,<br=
>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pm =A0 =A0 =A0 =A0 =A0 =A0 =3D &amp;__pm_o=
ps,<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .of_match_table =3D of_match_ptr(sysmmu_of_=
match),<br>
=A0 =A0 =A0 =A0 }<br>
@@ -1631,6 +1641,8 @@ static struct iommu_ops exynos_iommu_ops =3D {<br>
=A0 =A0 =A0 =A0 .pgsize_bitmap =3D SECT_SIZE | LPAGE_SIZE | SPAGE_SIZE,<br>
=A0};<br>
<br>
+static struct dentry *sysmmu_debugfs_root; /* /sys/kernel/debug/sysmmu */<=
br>
+<br>
=A0static int __init exynos_iommu_init(void)<br>
=A0{<br>
=A0 =A0 =A0 =A0 int ret;<br>
@@ -1642,17 +1654,197 @@ static int __init exynos_iommu_init(void)<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;<br>
=A0 =A0 =A0 =A0 }<br>
<br>
- =A0 =A0 =A0 ret =3D platform_driver_register(&amp;exynos_sysmmu_driver);<=
br>
+ =A0 =A0 =A0 ret =3D bus_set_iommu(&amp;platform_bus_type, &amp;exynos_iom=
mu_ops);<br>
+ =A0 =A0 =A0 if (ret) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 kmem_cache_destroy(lv2table_kmem_cache);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err(&quot;%s: Failed to register IOMMU ops=
\n&quot;, __func__);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EFAULT;<br>
+ =A0 =A0 =A0 }<br>
<br>
- =A0 =A0 =A0 if (ret =3D=3D 0)<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D bus_set_iommu(&amp;platform_bus_type,=
 &amp;exynos_iommu_ops);<br>
+ =A0 =A0 =A0 sysmmu_debugfs_root =3D debugfs_create_dir(&quot;sysmmu&quot;=
, NULL);<br>
+ =A0 =A0 =A0 if (!sysmmu_debugfs_root)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err(&quot;%s: Failed to create debugfs ent=
ry, &#39;sysmmu&#39;\n&quot;,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__);<br>
+ =A0 =A0 =A0 if (IS_ERR(sysmmu_debugfs_root))<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 sysmmu_debugfs_root =3D NULL;<br>
<br>
+ =A0 =A0 =A0 ret =3D platform_driver_register(&amp;exynos_sysmmu_driver);<=
br>
=A0 =A0 =A0 =A0 if (ret) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err(&quot;%s: Failed to register exynos-io=
mmu driver.\n&quot;,<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__);<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kmem_cache_destroy(lv2table_kmem_cache);<br=
>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err(&quot;%s: Failed to register System MM=
U driver\n&quot;, __func__);<br>
=A0 =A0 =A0 =A0 }<br>
<br>
=A0 =A0 =A0 =A0 return ret;<br>
=A0}<br>
=A0subsys_initcall(exynos_iommu_init);<br>
+<br>
+static int debug_string_show(struct seq_file *s, void *unused)<br>
+{<br>
+ =A0 =A0 =A0 char *str =3D s-&gt;private;<br>
+<br>
+ =A0 =A0 =A0 seq_printf(s, &quot;%s\n&quot;, str);<br>
+<br>
+ =A0 =A0 =A0 return 0;<br>
+}<br>
+<br>
+static int debug_sysmmu_list_show(struct seq_file *s, void *unused)<br>
+{<br>
+ =A0 =A0 =A0 struct sysmmu_drvdata *drvdata =3D s-&gt;private;<br>
+ =A0 =A0 =A0 struct platform_device *pdev =3D to_platform_device(drvdata-&=
gt;sysmmu);<br>
+ =A0 =A0 =A0 int idx, maj, min, ret;<br>
+<br>
+ =A0 =A0 =A0 seq_printf(s, &quot;SysMMU Name | Ver | SFR Base\n&quot;);<br=
>
+<br>
+ =A0 =A0 =A0 if (pm_runtime_enabled(drvdata-&gt;sysmmu)) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D pm_runtime_get_sync(drvdata-&gt;sysmm=
u);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret &lt; 0)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 for (idx =3D 0; idx &lt; drvdata-&gt;nsfrs; idx++) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct resource *res;<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 res =3D platform_get_resource(pdev, IORESOURC=
E_MEM, idx);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!res)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 maj =3D __sysmmu_version(drvdata, idx, &amp;m=
in);<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (drvdata-&gt;mmuname) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (maj =3D=3D 0)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 seq_printf(s,=
 &quot;%11.s | N/A | 0x%08x\n&quot;,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 drvdata-&gt;mmuname[idx], res-&gt;start);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 seq_printf(s,=
 &quot;%11.s | %d.%d | 0x%08x\n&quot;,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 drvdata-&gt;m=
muname[idx], maj, min, res-&gt;start);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (maj =3D=3D 0)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 seq_printf(s,=
 &quot;N/A | 0x%08x\n&quot;, res-&gt;start);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 seq_printf(s,=
 &quot;%d.%d | 0x%08x\n&quot;,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 maj, min, res-&gt;start);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 if (pm_runtime_enabled(drvdata-&gt;sysmmu))<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put(drvdata-&gt;sysmmu);<br>
+<br>
+ =A0 =A0 =A0 return 0;<br>
+}<br>
+<br>
+static int debug_next_sibling_show(struct seq_file *s, void *unused)<br>
+{<br>
+ =A0 =A0 =A0 struct device *dev =3D s-&gt;private;<br>
+<br>
+ =A0 =A0 =A0 if (dev-&gt;parent &amp;&amp;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 !strncmp(dev_name(dev-&gt;parent),<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MODULE_NAME, strlen(MODULE_NA=
ME)))<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 seq_printf(s, &quot;%s\n&quot;, dev_name(dev-=
&gt;parent));<br>
+ =A0 =A0 =A0 return 0;<br>
+}<br>
+<br>
+static int __show_master(struct device *dev, void *data)<br>
+{<br>
+ =A0 =A0 =A0 struct seq_file *s =3D data;<br>
+<br>
+ =A0 =A0 =A0 if (strncmp(dev_name(dev), MODULE_NAME, strlen(MODULE_NAME)))=
<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 seq_printf(s, &quot;%s\n&quot;, dev_name(dev)=
);<br>
+ =A0 =A0 =A0 return 0;<br>
+}<br>
+<br>
+static int debug_master_show(struct seq_file *s, void *unused)<br>
+{<br>
+ =A0 =A0 =A0 struct device *dev =3D s-&gt;private;<br>
+<br>
+ =A0 =A0 =A0 device_for_each_child(dev, s, __show_master);<br>
+ =A0 =A0 =A0 return 0;<br>
+}<br>
+<br>
+static int debug_string_open(struct inode *inode, struct file *file)<br>
+{<br>
+ =A0 =A0 =A0 return single_open(file, debug_string_show, inode-&gt;i_priva=
te);<br>
+}<br>
+<br>
+static int debug_sysmmu_list_open(struct inode *inode, struct file *file)<=
br>
+{<br>
+ =A0 =A0 =A0 return single_open(file, debug_sysmmu_list_show, inode-&gt;i_=
private);<br>
+}<br>
+<br>
+static int debug_next_sibling_open(struct inode *inode, struct file *file)=
<br>
+{<br>
+ =A0 =A0 =A0 return single_open(file, debug_next_sibling_show, inode-&gt;i=
_private);<br>
+}<br>
+<br>
+static int debug_master_open(struct inode *inode, struct file *file)<br>
+{<br>
+ =A0 =A0 =A0 return single_open(file, debug_master_show, inode-&gt;i_priva=
te);<br>
+}<br>
+<br>
+static const struct file_operations debug_string_fops =3D {<br>
+ =A0 =A0 =A0 .open =3D debug_string_open,<br>
+ =A0 =A0 =A0 .read =3D seq_read,<br>
+ =A0 =A0 =A0 .llseek =3D seq_lseek,<br>
+ =A0 =A0 =A0 .release =3D single_release,<br>
+};<br>
+<br>
+static const struct file_operations debug_sysmmu_list_fops =3D {<br>
+ =A0 =A0 =A0 .open =3D debug_sysmmu_list_open,<br>
+ =A0 =A0 =A0 .read =3D seq_read,<br>
+ =A0 =A0 =A0 .llseek =3D seq_lseek,<br>
+ =A0 =A0 =A0 .release =3D single_release,<br>
+};<br>
+<br>
+static const struct file_operations debug_next_sibling_fops =3D {<br>
+ =A0 =A0 =A0 .open =3D debug_next_sibling_open,<br>
+ =A0 =A0 =A0 .read =3D seq_read,<br>
+ =A0 =A0 =A0 .llseek =3D seq_lseek,<br>
+ =A0 =A0 =A0 .release =3D single_release,<br>
+};<br>
+<br>
+static const struct file_operations debug_master_fops =3D {<br>
+ =A0 =A0 =A0 .open =3D debug_master_open,<br>
+ =A0 =A0 =A0 .read =3D seq_read,<br>
+ =A0 =A0 =A0 .llseek =3D seq_lseek,<br>
+ =A0 =A0 =A0 .release =3D single_release,<br>
+};<br>
+<br>
+static void __init __create_debugfs_entry(struct sysmmu_drvdata *drvdata)<=
br>
+{<br>
+ =A0 =A0 =A0 if (!sysmmu_debugfs_root)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;<br>
+<br>
+ =A0 =A0 =A0 drvdata-&gt;debugfs_root =3D debugfs_create_dir(dev_name(drvd=
ata-&gt;sysmmu),<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sysmmu_debugfs_root);<br>
+ =A0 =A0 =A0 if (!drvdata-&gt;debugfs_root)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(drvdata-&gt;sysmmu, &quot;Failed to c=
reate debugfs dentry\n&quot;);<br>
+ =A0 =A0 =A0 if (IS_ERR(drvdata-&gt;debugfs_root))<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 drvdata-&gt;debugfs_root =3D NULL;<br>
+<br>
+ =A0 =A0 =A0 if (!drvdata-&gt;debugfs_root)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;<br>
+<br>
+ =A0 =A0 =A0 if (!debugfs_create_u32(&quot;enable&quot;, 0664, drvdata-&gt=
;debugfs_root,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 &amp;drvdata-&gt;activations))<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(drvdata-&gt;sysmmu,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;Failed =
to create debugfs file &#39;enable&#39;\n&quot;);<br>
+<br>
+ =A0 =A0 =A0 if (!debugfs_create_x32(&quot;pagetable&quot;, 0664, drvdata-=
&gt;debugfs_root,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 (u32 *)&amp;drvdata-&gt;pgtable))<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(drvdata-&gt;sysmmu,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;Failed =
to create debugfs file &#39;pagetable&#39;\n&quot;);<br>
+<br>
+ =A0 =A0 =A0 if (!debugfs_create_file(&quot;sysmmu_list&quot;, 0444, drvda=
ta-&gt;debugfs_root,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 drvdata, &amp;debug_sysmmu_list_fops))<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(drvdata-&gt;sysmmu,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;Failed to create debugf=
s file &#39;sysmmu_list&#39;\n&quot;);<br>
+<br>
+ =A0 =A0 =A0 if (!debugfs_create_file(&quot;next_sibling&quot;, 0x444, drv=
data-&gt;debugfs_root,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 drvdata-&gt;s=
ysmmu, &amp;debug_next_sibling_fops))<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(drvdata-&gt;sysmmu,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;Failed to create debugf=
s file &#39;next_siblings&#39;\n&quot;);<br>
+<br>
+ =A0 =A0 =A0 if (!debugfs_create_file(&quot;master&quot;, 0x444, drvdata-&=
gt;debugfs_root,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 drvdata-&gt;s=
ysmmu, &amp;debug_master_fops))<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(drvdata-&gt;sysmmu,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;Failed to create debugf=
s file &#39;next_siblings&#39;\n&quot;);<br>
+}<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
1.8.0<br>
<br>
<br>
_______________________________________________<br>
iommu mailing list<br>
<a href=3D"mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org">iommu-cunTk1MwBs9QetFLy7KEm2CgeU+1il2p@public.gmane.org=
ation.org</a><br>
<a href=3D"https://lists.linuxfoundation.org/mailman/listinfo/iommu" target=
=3D"_blank">https://lists.linuxfoundation.org/mailman/listinfo/iommu</a><br=
>
</font></span></blockquote></div><br></div>

--089e0117691f6be10604dcf7570d--

--===============6965342516833795120==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6965342516833795120==--
