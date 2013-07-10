From: Prathyush K <prathyush-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v7 6/9] clk: exynos5250: add gate clock descriptions of
	System MMU
Date: Wed, 10 Jul 2013 20:18:48 +0530
Message-ID: <CAH=HWYPUJP9NxOgs6Ei+azB5UqiKocMe00+z5i+sD7io8D0g=w@mail.gmail.com>
References: <002e01ce797b$4dc46d20$e94d4760$@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7509866944061832959=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <002e01ce797b$4dc46d20$e94d4760$@samsung.com>
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
Cc: Linux Samsung SOC <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Hyunwoong Kim <khw0178.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Prathyush <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Keyyoung Park <keyyoung.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Subash Patel <supash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Thomas Abraham <thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linux ARM Kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Rahul Sharma <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============7509866944061832959==
Content-Type: multipart/alternative; boundary=089e0158adfe1120a404e12960de

--089e0158adfe1120a404e12960de
Content-Type: text/plain; charset=ISO-8859-1

On Fri, Jul 5, 2013 at 5:59 PM, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:

> This adds gate clocks of all System MMUs and their master IPs
> that are not apeared in clk-exynos5250.c
>
> Signed-off-by: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> CC: Thomas Abraham <thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  .../devicetree/bindings/clock/exynos5250-clock.txt |   28 +++++++++-
>  drivers/clk/samsung/clk-exynos5250.c               |   57
> ++++++++++++++++---
>  2 files changed, 75 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/clock/exynos5250-clock.txt
> b/Documentation/devicetree/bindings/clock/exynos5250-clock.txt
> index 781a627..df49694 100644
> --- a/Documentation/devicetree/bindings/clock/exynos5250-clock.txt
> +++ b/Documentation/devicetree/bindings/clock/exynos5250-clock.txt
> @@ -154,7 +154,33 @@ clock which they consume.
>    dsim0                        341
>    dp                   342
>    mixer                        343
> -  hdmi                 345
> +  hdmi                 344
> +  camif_top            345
> +  smmu_fimc_lite0      346
> +  smmu_fimc_lite1      347
> +  smmu_fimc_lite2      348
> +  smmu_tv              349
> +  smmu_fimd1           350
> +  smmu_2d              351
> +  fimc_isp             352
> +  fimc_drc             353
> +  fimc_fd              354
> +  fimc_scc             355
> +  fimc_scp             356
> +  fimc_mcuctl          357
> +  fimc_odc             358
> +  fimc_dis             359
> +  fimc_3dnr            360
> +  smmu_fimc_isp                361
> +  smmu_fimc_drc                362
> +  smmu_fimc_fd         363
> +  smmu_fimc_scc                364
> +  smmu_fimc_scp                365
> +  smmu_fimc_mcuctl     366
> +  smmu_fimc_odc                367
> +  smmu_fimc_dis0       368
> +  smmu_fimc_dis1       369
> +  smmu_fimc_3dnr       370
>
>  Example 1: An example of a clock controller node is listed below.
>
> diff --git a/drivers/clk/samsung/clk-exynos5250.c
> b/drivers/clk/samsung/clk-exynos5250.c
> index 22d7699..1921d6c 100644
> --- a/drivers/clk/samsung/clk-exynos5250.c
> +++ b/drivers/clk/samsung/clk-exynos5250.c
> @@ -53,12 +53,15 @@
>  #define DIV_PERIC3             0x10564
>  #define DIV_PERIC4             0x10568
>  #define DIV_PERIC5             0x1056c
> +#define GATE_IP_ISP0           0x0C800
> +#define GATE_IP_ISP1           0x0C800
>  #define GATE_IP_GSCL           0x10920
>  #define GATE_IP_MFC            0x1092c
>  #define GATE_IP_GEN            0x10934
>  #define GATE_IP_FSYS           0x10944
>  #define GATE_IP_PERIC          0x10950
>  #define GATE_IP_PERIS          0x10960
> +#define GATE_IP_ACP            0x18800
>  #define SRC_CDREX              0x20200
>  #define PLL_DIV2_SEL           0x20a24
>  #define GATE_IP_DISP1          0x10928
> @@ -100,6 +103,14 @@ enum exynos5250_clks {
>         tzpc2, tzpc3, tzpc4, tzpc5, tzpc6, tzpc7, tzpc8, tzpc9, hdmi_cec,
> mct,
>         wdt, rtc, tmu, fimd1, mie1, dsim0, dp, mixer, hdmi,
>
> +       camif_top, smmu_fimc_lite0, smmu_fimc_lite1, smmu_fimc_lite2,
> +       smmu_tv, smmu_fimd1, smmu_2d,
> +       fimc_isp, fimc_drc, fimc_fd, fimc_scc, fimc_scp, fimc_mcuctl,
> fimc_odc,
> +       fimc_dis, fimc_3dnr,
> +       smmu_fimc_isp, smmu_fimc_drc, smmu_fimc_fd, smmu_fimc_scc,
> +       smmu_fimc_scp, smmu_fimc_mcuctl, smmu_fimc_odc, smmu_fimc_dis0,
> +       smmu_fimc_dis1, smmu_fimc_3dnr,
> +
>         nr_clks,
>  };
>
> @@ -320,19 +331,26 @@ struct samsung_gate_clock exynos5250_gate_clks[]
> __initdata = {
>         GATE(gscl3, "gscl3", "aclk266", GATE_IP_GSCL, 3, 0, 0),
>         GATE(gscl_wa, "gscl_wa", "div_gscl_wa", GATE_IP_GSCL, 5, 0, 0),
>         GATE(gscl_wb, "gscl_wb", "div_gscl_wb", GATE_IP_GSCL, 6, 0, 0),
> -       GATE(smmu_gscl0, "smmu_gscl0", "aclk266", GATE_IP_GSCL, 7, 0, 0),
> -       GATE(smmu_gscl1, "smmu_gscl1", "aclk266", GATE_IP_GSCL, 8, 0, 0),
> -       GATE(smmu_gscl2, "smmu_gscl2", "aclk266", GATE_IP_GSCL, 9, 0, 0),
> -       GATE(smmu_gscl3, "smmu_gscl3", "aclk266", GATE_IP_GSCL, 10, 0, 0),
> +       GATE(smmu_gscl0, "smmu_gscl0", "gscl0", GATE_IP_GSCL, 7, 0, 0),
> +       GATE(smmu_gscl1, "smmu_gscl1", "gscl1", GATE_IP_GSCL, 8, 0, 0),
> +       GATE(smmu_gscl2, "smmu_gscl2", "gscl2", GATE_IP_GSCL, 9, 0, 0),
> +       GATE(smmu_gscl3, "smmu_gscl3", "gscl3", GATE_IP_GSCL, 10, 0, 0),
> +       GATE(camif_top, "camif_top", "aclk266", GATE_IP_GSCL, 4, 0, 0),
> +       GATE(smmu_fimc_lite0, "smmu_fimc_lite0", "camif_top",
> +                                               GATE_IP_GSCL, 12, 0, 0),
> +       GATE(smmu_fimc_lite1, "smmu_fimc_lite1", "camif_top",
> +                                               GATE_IP_GSCL, 13, 0, 0),
> +       GATE(smmu_fimc_lite2, "smmu_fimc_lite2", "camif_top",
> +                                               GATE_IP_GSCL, 14, 0, 0),
>         GATE(mfc, "mfc", "aclk333", GATE_IP_MFC, 0, 0, 0),
> -       GATE(smmu_mfcl, "smmu_mfcl", "aclk333", GATE_IP_MFC, 1, 0, 0),
> -       GATE(smmu_mfcr, "smmu_mfcr", "aclk333", GATE_IP_MFC, 2, 0, 0),
> +       GATE(smmu_mfcl, "smmu_mfcl", "mfc", GATE_IP_MFC, 1, 0, 0),
> +       GATE(smmu_mfcr, "smmu_mfcr", "mfc", GATE_IP_MFC, 2, 0, 0),
>

This should be reversed as seen in 5250. The mfcl's control bit is 2 and
mfcr's control bit is 1.

Why is the parent of the smmu_mfc set as "mfc"? Is this a required
hierarchy in the clocks?
Even I noticed that we need to turn on MFC's clock to be able to access
smmu_mfc's registers.
But I don't think setting mfc as parent of smmu_mfc is the correct solution
since this results in MFC not getting clock gated during video playback.

Beginning of playback:
Turn on SYSMMU:
MFC Sysmmu clock: +1
MFC clock: +1

During video playback, dynamic clock gating of MFC:
Turn on MFC (before frame decode)
MFC Sysmmu clock: +1
MFC clock: +2

Turn off MFC (after frame decode)
MFC Sysmmu clock: +1
MFC clock: +1

End of playback:
Turn off SYSMMU:
MFC Sysmmu clock: 0 (gated)
MFC clock: 0 (gated)

As can be seen, MFC's dynamic clock gating between frames never works since
the sysmmu has already turned on the clock.

A better way is to pass the mmu-master's clock through the device node
(optional parameter).
If the parent device's clock is present in the sysmmu node, we turn ON/OFF
this clock before/after we access any sysmmu registers
E.g. before/after TLB invalidation.

What do you think?

Regards,
Prathyush



>         GATE(rotator, "rotator", "aclk266", GATE_IP_GEN, 1, 0, 0),
>         GATE(jpeg, "jpeg", "aclk166", GATE_IP_GEN, 2, 0, 0),
>         GATE(mdma1, "mdma1", "aclk266", GATE_IP_GEN, 4, 0, 0),
> -       GATE(smmu_rotator, "smmu_rotator", "aclk266", GATE_IP_GEN, 6, 0,
> 0),
> -       GATE(smmu_jpeg, "smmu_jpeg", "aclk166", GATE_IP_GEN, 7, 0, 0),
> -       GATE(smmu_mdma1, "smmu_mdma1", "aclk266", GATE_IP_GEN, 9, 0, 0),
> +       GATE(smmu_rotator, "smmu_rotator", "none", GATE_IP_GEN, 6, 0, 0),
> +       GATE(smmu_jpeg, "smmu_jpeg", "jpeg", GATE_IP_GEN, 7, 0, 0),
> +       GATE(smmu_mdma1, "smmu_mdma1", "none", GATE_IP_GEN, 9, 0, 0),
>         GATE(pdma0, "pdma0", "aclk200", GATE_IP_FSYS, 1, 0, 0),
>         GATE(pdma1, "pdma1", "aclk200", GATE_IP_FSYS, 2, 0, 0),
>         GATE(sata, "sata", "aclk200", GATE_IP_FSYS, 6, 0, 0),
> @@ -462,6 +480,27 @@ struct samsung_gate_clock exynos5250_gate_clks[]
> __initdata = {
>         GATE(dp, "dp", "aclk200", GATE_IP_DISP1, 4, 0, 0),
>         GATE(mixer, "mixer", "aclk200", GATE_IP_DISP1, 5, 0, 0),
>         GATE(hdmi, "hdmi", "aclk200", GATE_IP_DISP1, 6, 0, 0),
> +       GATE(smmu_tv, "smmu_tv", "none", GATE_IP_DISP1, 2, 0, 0),
> +       GATE(smmu_fimd1, "smmu_fimd1", "none", GATE_IP_DISP1, 8, 0, 0),
> +
> +       GATE(smmu_fimc_isp, "smmu_fimc_isp", "none", GATE_IP_ISP0, 8, 0,
> 0),
> +       GATE(smmu_fimc_drc, "smmu_fimc_drc", "none", GATE_IP_ISP0, 9, 0,
> 0),
> +       GATE(smmu_fimc_fd, "smmu_fimc_fd", "none", GATE_IP_ISP0, 10, 0, 0),
> +       GATE(smmu_fimc_scc, "smmu_fimc_scc", "none",
> +                                                       GATE_IP_ISP0, 11,
> 0, 0),
> +       GATE(smmu_fimc_scp, "smmu_fimc_scp", "none",
> +                                                       GATE_IP_ISP0, 12,
> 0, 0),
> +       GATE(smmu_fimc_mcuctl, "smmu_fimc_mcuctl", "none",
> +                                                       GATE_IP_ISP0, 13,
> 0, 0),
> +       GATE(smmu_fimc_odc, "smmu_fimc_odc", "none", GATE_IP_ISP1, 4, 0,
> 0),
> +       GATE(smmu_fimc_dis0, "smmu_fimc_dis0", "none",
> +                                                       GATE_IP_ISP1, 5,
> 0, 0),
> +       GATE(smmu_fimc_dis1, "smmu_fimc_dis1", "none",
> +                                                       GATE_IP_ISP1, 6,
> 0, 0),
> +       GATE(smmu_fimc_3dnr, "smmu_fimc_3dnr", "none",
> +                                                       GATE_IP_ISP1, 7,
> 0, 0),
> +
> +       GATE(smmu_2d, "smmu_2d", "none", GATE_IP_ACP, 7, 0, 0),
>  };
>
>  static __initdata struct of_device_id ext_clk_match[] = {
> --
> 1.7.2.5
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe
> linux-samsung-soc" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--089e0158adfe1120a404e12960de
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><br><div class=3D"gmail=
_quote">On Fri, Jul 5, 2013 at 5:59 PM, Cho KyongHo <span dir=3D"ltr">&lt;<=
a href=3D"mailto:pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" target=3D"_blank">pullip.cho@samsu=
ng.com</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">This adds gate clocks of all System MMUs and their master =
IPs<br>


that are not apeared in clk-exynos5250.c<br>
<br>
Signed-off-by: Cho KyongHo &lt;<a href=3D"mailto:pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" ta=
rget=3D"_blank">pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org</a>&gt;<br>
CC: Thomas Abraham &lt;<a href=3D"mailto:thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" target=
=3D"_blank">thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org</a>&gt;<br>
---<br>
=A0.../devicetree/bindings/clock/exynos5250-clock.txt | =A0 28 +++++++++-<b=
r>
=A0drivers/clk/samsung/clk-exynos5250.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 5=
7 ++++++++++++++++---<br>
=A02 files changed, 75 insertions(+), 10 deletions(-)<br>
<br>
diff --git a/Documentation/devicetree/bindings/clock/exynos5250-clock.txt<b=
r>
b/Documentation/devicetree/bindings/clock/exynos5250-clock.txt<br>
index 781a627..df49694 100644<br>
--- a/Documentation/devicetree/bindings/clock/exynos5250-clock.txt<br>
+++ b/Documentation/devicetree/bindings/clock/exynos5250-clock.txt<br>
@@ -154,7 +154,33 @@ clock which they consume.<br>
=A0 =A0dsim0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0341<br>
=A0 =A0dp =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 342<br>
=A0 =A0mixer =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0343<br>
- =A0hdmi =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 345<br>
+ =A0hdmi =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 344<br>
+ =A0camif_top =A0 =A0 =A0 =A0 =A0 =A0345<br>
+ =A0smmu_fimc_lite0 =A0 =A0 =A0346<br>
+ =A0smmu_fimc_lite1 =A0 =A0 =A0347<br>
+ =A0smmu_fimc_lite2 =A0 =A0 =A0348<br>
+ =A0smmu_tv =A0 =A0 =A0 =A0 =A0 =A0 =A0349<br>
+ =A0smmu_fimd1 =A0 =A0 =A0 =A0 =A0 350<br>
+ =A0smmu_2d =A0 =A0 =A0 =A0 =A0 =A0 =A0351<br>
+ =A0fimc_isp =A0 =A0 =A0 =A0 =A0 =A0 352<br>
+ =A0fimc_drc =A0 =A0 =A0 =A0 =A0 =A0 353<br>
+ =A0fimc_fd =A0 =A0 =A0 =A0 =A0 =A0 =A0354<br>
+ =A0fimc_scc =A0 =A0 =A0 =A0 =A0 =A0 355<br>
+ =A0fimc_scp =A0 =A0 =A0 =A0 =A0 =A0 356<br>
+ =A0fimc_mcuctl =A0 =A0 =A0 =A0 =A0357<br>
+ =A0fimc_odc =A0 =A0 =A0 =A0 =A0 =A0 358<br>
+ =A0fimc_dis =A0 =A0 =A0 =A0 =A0 =A0 359<br>
+ =A0fimc_3dnr =A0 =A0 =A0 =A0 =A0 =A0360<br>
+ =A0smmu_fimc_isp =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0361<br>
+ =A0smmu_fimc_drc =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0362<br>
+ =A0smmu_fimc_fd =A0 =A0 =A0 =A0 363<br>
+ =A0smmu_fimc_scc =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0364<br>
+ =A0smmu_fimc_scp =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0365<br>
+ =A0smmu_fimc_mcuctl =A0 =A0 366<br>
+ =A0smmu_fimc_odc =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0367<br>
+ =A0smmu_fimc_dis0 =A0 =A0 =A0 368<br>
+ =A0smmu_fimc_dis1 =A0 =A0 =A0 369<br>
+ =A0smmu_fimc_3dnr =A0 =A0 =A0 370<br>
<br>
=A0Example 1: An example of a clock controller node is listed below.<br>
<br>
diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk=
-exynos5250.c<br>
index 22d7699..1921d6c 100644<br>
--- a/drivers/clk/samsung/clk-exynos5250.c<br>
+++ b/drivers/clk/samsung/clk-exynos5250.c<br>
@@ -53,12 +53,15 @@<br>
=A0#define DIV_PERIC3 =A0 =A0 =A0 =A0 =A0 =A0 0x10564<br>
=A0#define DIV_PERIC4 =A0 =A0 =A0 =A0 =A0 =A0 0x10568<br>
=A0#define DIV_PERIC5 =A0 =A0 =A0 =A0 =A0 =A0 0x1056c<br>
+#define GATE_IP_ISP0 =A0 =A0 =A0 =A0 =A0 0x0C800<br>
+#define GATE_IP_ISP1 =A0 =A0 =A0 =A0 =A0 0x0C800<br>
=A0#define GATE_IP_GSCL =A0 =A0 =A0 =A0 =A0 0x10920<br>
=A0#define GATE_IP_MFC =A0 =A0 =A0 =A0 =A0 =A00x1092c<br>
=A0#define GATE_IP_GEN =A0 =A0 =A0 =A0 =A0 =A00x10934<br>
=A0#define GATE_IP_FSYS =A0 =A0 =A0 =A0 =A0 0x10944<br>
=A0#define GATE_IP_PERIC =A0 =A0 =A0 =A0 =A00x10950<br>
=A0#define GATE_IP_PERIS =A0 =A0 =A0 =A0 =A00x10960<br>
+#define GATE_IP_ACP =A0 =A0 =A0 =A0 =A0 =A00x18800<br>
=A0#define SRC_CDREX =A0 =A0 =A0 =A0 =A0 =A0 =A00x20200<br>
=A0#define PLL_DIV2_SEL =A0 =A0 =A0 =A0 =A0 0x20a24<br>
=A0#define GATE_IP_DISP1 =A0 =A0 =A0 =A0 =A00x10928<br>
@@ -100,6 +103,14 @@ enum exynos5250_clks {<br>
=A0 =A0 =A0 =A0 tzpc2, tzpc3, tzpc4, tzpc5, tzpc6, tzpc7, tzpc8, tzpc9, hdm=
i_cec, mct,<br>
=A0 =A0 =A0 =A0 wdt, rtc, tmu, fimd1, mie1, dsim0, dp, mixer, hdmi,<br>
<br>
+ =A0 =A0 =A0 camif_top, smmu_fimc_lite0, smmu_fimc_lite1, smmu_fimc_lite2,=
<br>
+ =A0 =A0 =A0 smmu_tv, smmu_fimd1, smmu_2d,<br>
+ =A0 =A0 =A0 fimc_isp, fimc_drc, fimc_fd, fimc_scc, fimc_scp, fimc_mcuctl,=
 fimc_odc,<br>
+ =A0 =A0 =A0 fimc_dis, fimc_3dnr,<br>
+ =A0 =A0 =A0 smmu_fimc_isp, smmu_fimc_drc, smmu_fimc_fd, smmu_fimc_scc,<br=
>
+ =A0 =A0 =A0 smmu_fimc_scp, smmu_fimc_mcuctl, smmu_fimc_odc, smmu_fimc_dis=
0,<br>
+ =A0 =A0 =A0 smmu_fimc_dis1, smmu_fimc_3dnr,<br>
+<br>
=A0 =A0 =A0 =A0 nr_clks,<br>
=A0};<br>
<br>
@@ -320,19 +331,26 @@ struct samsung_gate_clock exynos5250_gate_clks[] __in=
itdata =3D {<br>
=A0 =A0 =A0 =A0 GATE(gscl3, &quot;gscl3&quot;, &quot;aclk266&quot;, GATE_IP=
_GSCL, 3, 0, 0),<br>
=A0 =A0 =A0 =A0 GATE(gscl_wa, &quot;gscl_wa&quot;, &quot;div_gscl_wa&quot;,=
 GATE_IP_GSCL, 5, 0, 0),<br>
=A0 =A0 =A0 =A0 GATE(gscl_wb, &quot;gscl_wb&quot;, &quot;div_gscl_wb&quot;,=
 GATE_IP_GSCL, 6, 0, 0),<br>
- =A0 =A0 =A0 GATE(smmu_gscl0, &quot;smmu_gscl0&quot;, &quot;aclk266&quot;,=
 GATE_IP_GSCL, 7, 0, 0),<br>
- =A0 =A0 =A0 GATE(smmu_gscl1, &quot;smmu_gscl1&quot;, &quot;aclk266&quot;,=
 GATE_IP_GSCL, 8, 0, 0),<br>
- =A0 =A0 =A0 GATE(smmu_gscl2, &quot;smmu_gscl2&quot;, &quot;aclk266&quot;,=
 GATE_IP_GSCL, 9, 0, 0),<br>
- =A0 =A0 =A0 GATE(smmu_gscl3, &quot;smmu_gscl3&quot;, &quot;aclk266&quot;,=
 GATE_IP_GSCL, 10, 0, 0),<br>
+ =A0 =A0 =A0 GATE(smmu_gscl0, &quot;smmu_gscl0&quot;, &quot;gscl0&quot;, G=
ATE_IP_GSCL, 7, 0, 0),<br>
+ =A0 =A0 =A0 GATE(smmu_gscl1, &quot;smmu_gscl1&quot;, &quot;gscl1&quot;, G=
ATE_IP_GSCL, 8, 0, 0),<br>
+ =A0 =A0 =A0 GATE(smmu_gscl2, &quot;smmu_gscl2&quot;, &quot;gscl2&quot;, G=
ATE_IP_GSCL, 9, 0, 0),<br>
+ =A0 =A0 =A0 GATE(smmu_gscl3, &quot;smmu_gscl3&quot;, &quot;gscl3&quot;, G=
ATE_IP_GSCL, 10, 0, 0),<br>
+ =A0 =A0 =A0 GATE(camif_top, &quot;camif_top&quot;, &quot;aclk266&quot;, G=
ATE_IP_GSCL, 4, 0, 0),<br>
+ =A0 =A0 =A0 GATE(smmu_fimc_lite0, &quot;smmu_fimc_lite0&quot;, &quot;cami=
f_top&quot;,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 GATE_IP_GSCL, 12, 0, 0),<br>
+ =A0 =A0 =A0 GATE(smmu_fimc_lite1, &quot;smmu_fimc_lite1&quot;, &quot;cami=
f_top&quot;,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 GATE_IP_GSCL, 13, 0, 0),<br>
+ =A0 =A0 =A0 GATE(smmu_fimc_lite2, &quot;smmu_fimc_lite2&quot;, &quot;cami=
f_top&quot;,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 GATE_IP_GSCL, 14, 0, 0),<br>
=A0 =A0 =A0 =A0 GATE(mfc, &quot;mfc&quot;, &quot;aclk333&quot;, GATE_IP_MFC=
, 0, 0, 0),<br>
- =A0 =A0 =A0 GATE(smmu_mfcl, &quot;smmu_mfcl&quot;, &quot;aclk333&quot;, G=
ATE_IP_MFC, 1, 0, 0),<br>
- =A0 =A0 =A0 GATE(smmu_mfcr, &quot;smmu_mfcr&quot;, &quot;aclk333&quot;, G=
ATE_IP_MFC, 2, 0, 0),<br>
+ =A0 =A0 =A0 GATE(smmu_mfcl, &quot;smmu_mfcl&quot;, &quot;mfc&quot;, GATE_=
IP_MFC, 1, 0, 0),<br>
+ =A0 =A0 =A0 GATE(smmu_mfcr, &quot;smmu_mfcr&quot;, &quot;mfc&quot;, GATE_=
IP_MFC, 2, 0, 0),<br></blockquote><div><br></div><div>This should be revers=
ed as seen in 5250. The mfcl&#39;s control bit is 2 and mfcr&#39;s control =
bit is 1.<br>

</div><div><br></div><div>Why is the parent of the smmu_mfc set as &quot;mf=
c&quot;? Is this a required hierarchy in the clocks?<br></div><div>Even I n=
oticed that we need to turn on MFC&#39;s clock to be able to access smmu_mf=
c&#39;s registers.</div>

<div>But I don&#39;t think setting mfc as parent of smmu_mfc is the correct=
 solution since this results in MFC not getting clock gated during video pl=
ayback.</div><div><br></div><div><div>Beginning of playback:</div><div>

Turn on SYSMMU:</div><div>MFC Sysmmu clock: +1</div><div>MFC clock: +1</div=
><div><br></div><div>During video playback, dynamic clock gating of MFC:</d=
iv><div>Turn on MFC (before frame decode)</div><div>MFC Sysmmu clock: +1</d=
iv>

<div>MFC clock: +2</div><div><br></div><div>Turn off MFC (after frame decod=
e)</div><div>MFC Sysmmu clock: +1</div><div>MFC clock: +1</div><div><br></d=
iv><div>End of playback:</div><div>Turn off SYSMMU:</div><div>MFC Sysmmu cl=
ock: 0 (gated)</div>

<div>MFC clock: 0 (gated)</div></div><div><br></div><div>As can be seen, MF=
C&#39;s dynamic clock gating between frames never works since the sysmmu ha=
s already turned on the clock.</div><div><br></div><div>A better way is to =
pass the mmu-master&#39;s clock through the device node (optional parameter=
).<br>

</div><div>If the parent device&#39;s clock is present in the sysmmu node, =
we turn ON/OFF this clock before/after we access any sysmmu registers</div>=
<div>E.g. before/after TLB invalidation.</div><div><br></div><div>What do y=
ou think?</div>
<div><br></div><div>Regards,</div><div>Prathyush</div><div><br></div><div>=
=A0</div>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">
=A0 =A0 =A0 =A0 GATE(rotator, &quot;rotator&quot;, &quot;aclk266&quot;, GAT=
E_IP_GEN, 1, 0, 0),<br>
=A0 =A0 =A0 =A0 GATE(jpeg, &quot;jpeg&quot;, &quot;aclk166&quot;, GATE_IP_G=
EN, 2, 0, 0),<br>
=A0 =A0 =A0 =A0 GATE(mdma1, &quot;mdma1&quot;, &quot;aclk266&quot;, GATE_IP=
_GEN, 4, 0, 0),<br>
- =A0 =A0 =A0 GATE(smmu_rotator, &quot;smmu_rotator&quot;, &quot;aclk266&qu=
ot;, GATE_IP_GEN, 6, 0, 0),<br>
- =A0 =A0 =A0 GATE(smmu_jpeg, &quot;smmu_jpeg&quot;, &quot;aclk166&quot;, G=
ATE_IP_GEN, 7, 0, 0),<br>
- =A0 =A0 =A0 GATE(smmu_mdma1, &quot;smmu_mdma1&quot;, &quot;aclk266&quot;,=
 GATE_IP_GEN, 9, 0, 0),<br>
+ =A0 =A0 =A0 GATE(smmu_rotator, &quot;smmu_rotator&quot;, &quot;none&quot;=
, GATE_IP_GEN, 6, 0, 0),<br>
+ =A0 =A0 =A0 GATE(smmu_jpeg, &quot;smmu_jpeg&quot;, &quot;jpeg&quot;, GATE=
_IP_GEN, 7, 0, 0),<br>
+ =A0 =A0 =A0 GATE(smmu_mdma1, &quot;smmu_mdma1&quot;, &quot;none&quot;, GA=
TE_IP_GEN, 9, 0, 0),<br>
=A0 =A0 =A0 =A0 GATE(pdma0, &quot;pdma0&quot;, &quot;aclk200&quot;, GATE_IP=
_FSYS, 1, 0, 0),<br>
=A0 =A0 =A0 =A0 GATE(pdma1, &quot;pdma1&quot;, &quot;aclk200&quot;, GATE_IP=
_FSYS, 2, 0, 0),<br>
=A0 =A0 =A0 =A0 GATE(sata, &quot;sata&quot;, &quot;aclk200&quot;, GATE_IP_F=
SYS, 6, 0, 0),<br>
@@ -462,6 +480,27 @@ struct samsung_gate_clock exynos5250_gate_clks[] __ini=
tdata =3D {<br>
=A0 =A0 =A0 =A0 GATE(dp, &quot;dp&quot;, &quot;aclk200&quot;, GATE_IP_DISP1=
, 4, 0, 0),<br>
=A0 =A0 =A0 =A0 GATE(mixer, &quot;mixer&quot;, &quot;aclk200&quot;, GATE_IP=
_DISP1, 5, 0, 0),<br>
=A0 =A0 =A0 =A0 GATE(hdmi, &quot;hdmi&quot;, &quot;aclk200&quot;, GATE_IP_D=
ISP1, 6, 0, 0),<br>
+ =A0 =A0 =A0 GATE(smmu_tv, &quot;smmu_tv&quot;, &quot;none&quot;, GATE_IP_=
DISP1, 2, 0, 0),<br>
+ =A0 =A0 =A0 GATE(smmu_fimd1, &quot;smmu_fimd1&quot;, &quot;none&quot;, GA=
TE_IP_DISP1, 8, 0, 0),<br>
+<br>
+ =A0 =A0 =A0 GATE(smmu_fimc_isp, &quot;smmu_fimc_isp&quot;, &quot;none&quo=
t;, GATE_IP_ISP0, 8, 0, 0),<br>
+ =A0 =A0 =A0 GATE(smmu_fimc_drc, &quot;smmu_fimc_drc&quot;, &quot;none&quo=
t;, GATE_IP_ISP0, 9, 0, 0),<br>
+ =A0 =A0 =A0 GATE(smmu_fimc_fd, &quot;smmu_fimc_fd&quot;, &quot;none&quot;=
, GATE_IP_ISP0, 10, 0, 0),<br>
+ =A0 =A0 =A0 GATE(smmu_fimc_scc, &quot;smmu_fimc_scc&quot;, &quot;none&quo=
t;,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GATE_IP_ISP0, 11, 0, 0),<br>
+ =A0 =A0 =A0 GATE(smmu_fimc_scp, &quot;smmu_fimc_scp&quot;, &quot;none&quo=
t;,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GATE_IP_ISP0, 12, 0, 0),<br>
+ =A0 =A0 =A0 GATE(smmu_fimc_mcuctl, &quot;smmu_fimc_mcuctl&quot;, &quot;no=
ne&quot;,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GATE_IP_ISP0, 13, 0, 0),<br>
+ =A0 =A0 =A0 GATE(smmu_fimc_odc, &quot;smmu_fimc_odc&quot;, &quot;none&quo=
t;, GATE_IP_ISP1, 4, 0, 0),<br>
+ =A0 =A0 =A0 GATE(smmu_fimc_dis0, &quot;smmu_fimc_dis0&quot;, &quot;none&q=
uot;,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GATE_IP_ISP1, 5, 0, 0),<br>
+ =A0 =A0 =A0 GATE(smmu_fimc_dis1, &quot;smmu_fimc_dis1&quot;, &quot;none&q=
uot;,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GATE_IP_ISP1, 6, 0, 0),<br>
+ =A0 =A0 =A0 GATE(smmu_fimc_3dnr, &quot;smmu_fimc_3dnr&quot;, &quot;none&q=
uot;,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GATE_IP_ISP1, 7, 0, 0),<br>
+<br>
+ =A0 =A0 =A0 GATE(smmu_2d, &quot;smmu_2d&quot;, &quot;none&quot;, GATE_IP_=
ACP, 7, 0, 0),<br>
=A0};<br>
<br>
=A0static __initdata struct of_device_id ext_clk_match[] =3D {<br>
<span><font color=3D"#888888">--<br>
1.7.2.5<br>
<br>
<br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe linux-samsun=
g-soc&quot; in<br>
the body of a message to <a href=3D"mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" targe=
t=3D"_blank">majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br>
More majordomo info at =A0<a href=3D"http://vger.kernel.org/majordomo-info.=
html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a><br>
</font></span></blockquote></div><br></div></div>

--089e0158adfe1120a404e12960de--

--===============7509866944061832959==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7509866944061832959==--
