From: KyongHo Cho <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] iommu: exynos: add support for dt based instantiation for
	iommu devices
Date: Fri, 9 Nov 2012 07:36:42 +0900
Message-ID: <CAHQjnOMjMwYVkrXw68Z+NG-YXJ73pS9m2ZHqdTrpg50fc_EQrw@mail.gmail.com>
References: <1352108895-21087-1-git-send-email-rahul.sharma@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3064358144155478802=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1352108895-21087-1-git-send-email-rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Rahul Sharma <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: "jy0922.shim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <jy0922.shim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "sw0312.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <sw0312.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "joshi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <joshi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "prashanth.g-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <prashanth.g-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "s.shirish-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <s.shirish-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============3064358144155478802==
Content-Type: multipart/alternative; boundary=f46d0408394d1d853f04ce037892

--f46d0408394d1d853f04ce037892
Content-Type: text/plain; charset=ISO-8859-1

Hi.

Thank you for your work for exynos-iommu.
Actually I am preparing a design change of exynos-iommu driver including DT
support.
If you are OK, I want to discuss with you about it.

The current exynos-iommu driver needs to be upgraded to make it transparent
to the client drivers.

Thank you.

Cho KyongHo.

On Mon, Nov 5, 2012 at 6:48 PM, Rahul Sharma <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
wrote:
> This patch adds supports DT based intantiation of sysmmu devices.
> It also removes dependency on CONFIG_EXYNOS_DEV_SYSMMU which is
> primarily meant for nont-dt platforms.
>
> This patch is based on "arm/exynos" branch at
> http://git.kernel.org/?p=linux/kernel/git/joro/iommu.git
>
> This patch is having dependency on  linux-samsung-soc patchset named
> "add dt based support for iommu for hdmi"
>
> Signed-off-by: Rahul Sharma <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/iommu/Kconfig        |    2 +-
>  drivers/iommu/exynos-iommu.c |   28 +++++++++++++++++++++++++---
>  2 files changed, 26 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 9f69b56..52dc41f 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -168,7 +168,7 @@ config TEGRA_IOMMU_SMMU
>
>  config EXYNOS_IOMMU
>         bool "Exynos IOMMU Support"
> -       depends on ARCH_EXYNOS && EXYNOS_DEV_SYSMMU
> +       depends on ARCH_EXYNOS
>         select IOMMU_API
>         help
>           Support for the IOMMU(System MMU) of Samsung Exynos application
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 7fe44f8..9079f71 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -25,6 +25,7 @@
>  #include <linux/list.h>
>  #include <linux/memblock.h>
>  #include <linux/export.h>
> +#include <linux/of_platform.h>
>
>  #include <asm/cacheflush.h>
>  #include <asm/pgtable.h>
> @@ -576,6 +577,7 @@ static int exynos_sysmmu_probe(struct platform_device
*pdev)
>         int i, ret;
>         struct device *dev;
>         struct sysmmu_drvdata *data;
> +       struct sysmmu_platform_data *platdata;
>
>         dev = &pdev->dev;
>
> @@ -634,9 +636,21 @@ static int exynos_sysmmu_probe(struct
platform_device *pdev)
>                 }
>         }
>
> +       if(dev->of_node) {
> +               platdata = devm_kzalloc(dev, sizeof(*platdata),
GFP_KERNEL);
> +               if (!platdata) {
> +                       dev_dbg(dev, "memory allocation for pdata
failed\n");
> +                       goto err_irq;
> +               }
> +
> +               platdata->clockname = SYSMMU_CLOCK_NAME;
> +               platdata->dbgname = (char *)dev->of_node->name;
> +               dev->platform_data = platdata;
> +       }
> +
>         if (dev_get_platdata(dev)) {
>                 char *deli, *beg;
> -               struct sysmmu_platform_data *platdata =
dev_get_platdata(dev);
> +               platdata = dev_get_platdata(dev);
>
>                 beg = platdata->clockname;
>
> @@ -670,8 +684,7 @@ static int exynos_sysmmu_probe(struct platform_device
*pdev)
>
>         __set_fault_handler(data, &default_fault_handler);
>
> -       if (dev->parent)
> -               pm_runtime_enable(dev);
> +       pm_runtime_enable(dev);
>
>         dev_dbg(dev, "(%s) Initialized\n", data->dbgname);
>         return 0;
> @@ -693,11 +706,20 @@ err_alloc:
>         return ret;
>  }
>
> +static struct of_device_id iommu_match_types[] = {
> +       {
> +               .compatible = "samsung,exynos5-sysmmu",
> +       }, {
> +               /* end node */
> +       }
> +};
> +
>  static struct platform_driver exynos_sysmmu_driver = {
>         .probe          = exynos_sysmmu_probe,
>         .driver         = {
>                 .owner          = THIS_MODULE,
>                 .name           = "exynos-sysmmu",
> +               .of_match_table = iommu_match_types,
>         }
>  };
>
> --
> 1.7.0.4
>
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu

--f46d0408394d1d853f04ce037892
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi.<br><br>Thank you for your work for exynos-iommu.<br>Actually I am prepa=
ring a design change of exynos-iommu driver including DT support.<br>If you=
 are OK, I want to discuss with you about it.<br><br>The current exynos-iom=
mu driver needs to be upgraded to make it transparent to the client drivers=
.<br>
<br>Thank you.<br><br>Cho KyongHo.<br><br>On Mon, Nov 5, 2012 at 6:48 PM, R=
ahul Sharma &lt;<a href=3D"mailto:rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org">rahul.sharma@sa=
msung.com</a>&gt; wrote:<br>&gt; This patch adds supports DT based intantia=
tion of sysmmu devices.<br>
&gt; It also removes dependency on CONFIG_EXYNOS_DEV_SYSMMU which is<br>&gt=
; primarily meant for nont-dt platforms.<br>&gt;<br>&gt; This patch is base=
d on &quot;arm/exynos&quot; branch at<br>&gt; <a href=3D"http://git.kernel.=
org/?p=3Dlinux/kernel/git/joro/iommu.git">http://git.kernel.org/?p=3Dlinux/=
kernel/git/joro/iommu.git</a><br>
&gt;<br>&gt; This patch is having dependency on =A0linux-samsung-soc patchs=
et named<br>&gt; &quot;add dt based support for iommu for hdmi&quot;<br>&gt=
;<br>&gt; Signed-off-by: Rahul Sharma &lt;<a href=3D"mailto:rahul.sharma@sa=
msung.com">rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org</a>&gt;<br>
&gt; ---<br>&gt; =A0drivers/iommu/Kconfig =A0 =A0 =A0 =A0| =A0 =A02 +-<br>&=
gt; =A0drivers/iommu/exynos-iommu.c | =A0 28 +++++++++++++++++++++++++---<b=
r>&gt; =A02 files changed, 26 insertions(+), 4 deletions(-)<br>&gt;<br>&gt;=
 diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig<br>
&gt; index 9f69b56..52dc41f 100644<br>&gt; --- a/drivers/iommu/Kconfig<br>&=
gt; +++ b/drivers/iommu/Kconfig<br>&gt; @@ -168,7 +168,7 @@ config TEGRA_IO=
MMU_SMMU<br>&gt;<br>&gt; =A0config EXYNOS_IOMMU<br>&gt; =A0 =A0 =A0 =A0 boo=
l &quot;Exynos IOMMU Support&quot;<br>
&gt; - =A0 =A0 =A0 depends on ARCH_EXYNOS &amp;&amp; EXYNOS_DEV_SYSMMU<br>&=
gt; + =A0 =A0 =A0 depends on ARCH_EXYNOS<br>&gt; =A0 =A0 =A0 =A0 select IOM=
MU_API<br>&gt; =A0 =A0 =A0 =A0 help<br>&gt; =A0 =A0 =A0 =A0 =A0 Support for=
 the IOMMU(System MMU) of Samsung Exynos application<br>
&gt; diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu=
.c<br>&gt; index 7fe44f8..9079f71 100644<br>&gt; --- a/drivers/iommu/exynos=
-iommu.c<br>&gt; +++ b/drivers/iommu/exynos-iommu.c<br>&gt; @@ -25,6 +25,7 =
@@<br>
&gt; =A0#include &lt;linux/list.h&gt;<br>&gt; =A0#include &lt;linux/membloc=
k.h&gt;<br>&gt; =A0#include &lt;linux/export.h&gt;<br>&gt; +#include &lt;li=
nux/of_platform.h&gt;<br>&gt;<br>&gt; =A0#include &lt;asm/cacheflush.h&gt;<=
br>&gt; =A0#include &lt;asm/pgtable.h&gt;<br>
&gt; @@ -576,6 +577,7 @@ static int exynos_sysmmu_probe(struct platform_dev=
ice *pdev)<br>&gt; =A0 =A0 =A0 =A0 int i, ret;<br>&gt; =A0 =A0 =A0 =A0 stru=
ct device *dev;<br>&gt; =A0 =A0 =A0 =A0 struct sysmmu_drvdata *data;<br>&gt=
; + =A0 =A0 =A0 struct sysmmu_platform_data *platdata;<br>
&gt;<br>&gt; =A0 =A0 =A0 =A0 dev =3D &amp;pdev-&gt;dev;<br>&gt;<br>&gt; @@ =
-634,9 +636,21 @@ static int exynos_sysmmu_probe(struct platform_device *pd=
ev)<br>&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>&gt; =A0 =A0 =A0 =A0 }<br>=
&gt;<br>&gt; + =A0 =A0 =A0 if(dev-&gt;of_node) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 platdata =3D devm_kzalloc(dev, sizeof(*p=
latdata), GFP_KERNEL);<br>&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!platdata)=
 {<br>&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev, &quot=
;memory allocation for pdata failed\n&quot;);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_irq;<br>&gt; + =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>&gt; +<br>&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 platdata-&gt;clockname =3D SYSMMU_CLOCK_NAME;<br>&gt; + =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 platdata-&gt;dbgname =3D (char *)dev-&gt;of_node-&gt;name;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev-&gt;platform_data =3D platdata;<br>&=
gt; + =A0 =A0 =A0 }<br>&gt; +<br>&gt; =A0 =A0 =A0 =A0 if (dev_get_platdata(=
dev)) {<br>&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 char *deli, *beg;<br>&gt; -=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct sysmmu_platform_data *platdata =3D dev_=
get_platdata(dev);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 platdata =3D dev_get_platdata(dev);<br>&=
gt;<br>&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 beg =3D platdata-&gt;clockname;=
<br>&gt;<br>&gt; @@ -670,8 +684,7 @@ static int exynos_sysmmu_probe(struct =
platform_device *pdev)<br>&gt;<br>
&gt; =A0 =A0 =A0 =A0 __set_fault_handler(data, &amp;default_fault_handler);=
<br>&gt;<br>&gt; - =A0 =A0 =A0 if (dev-&gt;parent)<br>&gt; - =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 pm_runtime_enable(dev);<br>&gt; + =A0 =A0 =A0 pm_runtime_en=
able(dev);<br>&gt;<br>&gt; =A0 =A0 =A0 =A0 dev_dbg(dev, &quot;(%s) Initiali=
zed\n&quot;, data-&gt;dbgname);<br>
&gt; =A0 =A0 =A0 =A0 return 0;<br>&gt; @@ -693,11 +706,20 @@ err_alloc:<br>=
&gt; =A0 =A0 =A0 =A0 return ret;<br>&gt; =A0}<br>&gt;<br>&gt; +static struc=
t of_device_id iommu_match_types[] =3D {<br>&gt; + =A0 =A0 =A0 {<br>&gt; + =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 .compatible =3D &quot;samsung,exynos5-sysmmu&qu=
ot;,<br>
&gt; + =A0 =A0 =A0 }, {<br>&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* end node *=
/<br>&gt; + =A0 =A0 =A0 }<br>&gt; +};<br>&gt; +<br>&gt; =A0static struct pl=
atform_driver exynos_sysmmu_driver =3D {<br>&gt; =A0 =A0 =A0 =A0 .probe =A0=
 =A0 =A0 =A0 =A0=3D exynos_sysmmu_probe,<br>&gt; =A0 =A0 =A0 =A0 .driver =
=A0 =A0 =A0 =A0 =3D {<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0 =A0 =A0 =A0 =A0=3D THIS_MOD=
ULE,<br>&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D =
&quot;exynos-sysmmu&quot;,<br>&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .of_match_=
table =3D iommu_match_types,<br>&gt; =A0 =A0 =A0 =A0 }<br>&gt; =A0};<br>&gt=
;<br>
&gt; --<br>&gt; 1.7.0.4<br>&gt;<br>&gt; ___________________________________=
____________<br>&gt; iommu mailing list<br>&gt; <a href=3D"mailto:iommu@lis=
ts.linux-foundation.org">iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org</a><br>&gt; <a hr=
ef=3D"https://lists.linuxfoundation.org/mailman/listinfo/iommu">https://lis=
ts.linuxfoundation.org/mailman/listinfo/iommu</a><br>
<br>

--f46d0408394d1d853f04ce037892--

--===============3064358144155478802==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3064358144155478802==--
