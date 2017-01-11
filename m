From: "Chalamarla, Tirumalesh" <Tirumalesh.Chalamarla-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/1] iommu/arm-smmu: Fix for ThunderX erratum #27704
Date: Wed, 11 Jan 2017 18:49:01 +0000
Message-ID: <BN6PR07MB31868DFFF2645E60E6CF36188E660@BN6PR07MB3186.namprd07.prod.outlook.com>
References: <1484135507-24872-1-git-send-email-tn@semihalf.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6693180377525463394=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1484135507-24872-1-git-send-email-tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "robin.murphy-5wv7dgnIgG8@public.gmane.org" <robin.murphy-5wv7dgnIgG8@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "Kapoor, Prasun" <Prasun.Kapoor-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, "Goutham,
	Sunil" <Sunil.Goutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Akula, Geethasowjanya" <Geethasowjanya.Akula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============6693180377525463394==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR07MB31868DFFF2645E60E6CF36188E660BN6PR07MB3186namp_"

--_000_BN6PR07MB31868DFFF2645E60E6CF36188E660BN6PR07MB3186namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


________________________________
From: Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
Sent: Wednesday, January 11, 2017 3:51 AM
To: will.deacon-5wv7dgnIgG8@public.gmane.org; robin.murphy-5wv7dgnIgG8@public.gmane.org; mark.rutland-5wv7dgnIgG8@public.gmane.org; joro@8=
bytes.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org;=
 linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Goutham, Sunil; Akula, Geethasowjanya; Chala=
marla, Tirumalesh; Kapoor, Prasun; Tomasz Nowicki
Subject: [PATCH 1/1] iommu/arm-smmu: Fix for ThunderX erratum #27704

The goal of erratum #27704 workaround was to make sure that ASIDs and VMIDs
are unique across all SMMU instances on affected Cavium systems.

Currently, the workaround code partitions ASIDs and VMIDs by increasing
global cavium_smmu_context_count which in turn becomes the base ASID and VM=
ID
value for the given SMMU instance upon the context bank initialization.

For systems with multiple SMMU instances this approach implies the risk
of crossing 8-bit ASID, like for CN88xx capable of 4 SMMUv2, 128 context ba=
nk each:
SMMU_0 (0-127 ASID RANGE)
SMMU_1 (127-255 ASID RANGE)
SMMU_2 (256-383 ASID RANGE) <--- crossing 8-bit ASID
SMMU_3 (384-511 ASID RANGE) <--- crossing 8-bit ASID

Since we use 8-bit ASID now we effectively misconfigure ASID[15:8] bits for
SMMU_CBn_TTBRm register. Also, we still use non-zero ASID[15:8] bits
upon context invalidation. This patch adds 16-bit ASID support for stage-1
AArch64 contexts for Cavium SMMUv2 model so that we use ASIDs consistently.

Signed-off-by: Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index a60cded..ae8f059 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -260,6 +260,7 @@ enum arm_smmu_s2cr_privcfg {

 #define TTBCR2_SEP_SHIFT                15
 #define TTBCR2_SEP_UPSTREAM             (0x7 << TTBCR2_SEP_SHIFT)
+#define TTBCR2_AS                      (1 << 4)

 #define TTBRn_ASID_SHIFT                48

@@ -778,6 +779,9 @@ static void arm_smmu_init_context_bank(struct arm_smmu_=
domain *smmu_domain,
                         reg =3D pgtbl_cfg->arm_lpae_s1_cfg.tcr;
                         reg2 =3D pgtbl_cfg->arm_lpae_s1_cfg.tcr >> 32;
                         reg2 |=3D TTBCR2_SEP_UPSTREAM;
+                       if (smmu->model =3D=3D CAVIUM_SMMUV2 &&
+                           cfg->fmt =3D=3D ARM_SMMU_CTX_FMT_AARCH64)
+                               reg2 |=3D TTBCR2_AS;


it shouldn't be cavium specific just set this bet when we enable 16bit ASID=
.


                 }
                 if (smmu->version > ARM_SMMU_V1)
                         writel_relaxed(reg2, cb_base + ARM_SMMU_CB_TTBCR2)=
;

you can add my review by.
--
2.7.4


--_000_BN6PR07MB31868DFFF2645E60E6CF36188E660BN6PR07MB3186namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Arial,Helvetica,sans-serif;" dir=3D"ltr">
<p><br>
</p>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Tomasz Nowicki &lt;=
tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org&gt;<br>
<b>Sent:</b> Wednesday, January 11, 2017 3:51 AM<br>
<b>To:</b> will.deacon-5wv7dgnIgG8@public.gmane.org; robin.murphy-5wv7dgnIgG8@public.gmane.org; mark.rutland-5wv7dgnIgG8@public.gmane.org;=
 joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org<br>
<b>Cc:</b> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm+QpoMPSDrYp@public.gmane.org=
on.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Goutham, Sunil; Akula, Geethasowjanya=
; Chalamarla, Tirumalesh; Kapoor, Prasun; Tomasz Nowicki<br>
<b>Subject:</b> [PATCH 1/1] iommu/arm-smmu: Fix for ThunderX erratum #27704=
</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">The goal of erratum #27704 workaround was to make =
sure that ASIDs and VMIDs<br>
are unique across all SMMU instances on affected Cavium systems.<br>
<br>
Currently, the workaround code partitions ASIDs and VMIDs by increasing<br>
global cavium_smmu_context_count which in turn becomes the base ASID and VM=
ID<br>
value for the given SMMU instance upon the context bank initialization.<br>
<br>
For systems with multiple SMMU instances this approach implies the risk<br>
of crossing 8-bit ASID, like for CN88xx capable of 4 SMMUv2, 128 context ba=
nk each:<br>
SMMU_0 (0-127 ASID RANGE)<br>
SMMU_1 (127-255 ASID RANGE)<br>
SMMU_2 (256-383 ASID RANGE) &lt;--- crossing 8-bit ASID<br>
SMMU_3 (384-511 ASID RANGE) &lt;--- crossing 8-bit ASID<br>
<br>
Since we use 8-bit ASID now we effectively misconfigure ASID[15:8] bits for=
<br>
SMMU_CBn_TTBRm register. Also, we still use non-zero ASID[15:8] bits<br>
upon context invalidation. This patch adds 16-bit ASID support for stage-1<=
br>
AArch64 contexts for Cavium SMMUv2 model so that we use ASIDs consistently.=
<br>
<br>
Signed-off-by: Tomasz Nowicki &lt;tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/iommu/arm-smmu.c | 4 &#43;&#43;&#43;&#43;<br>
&nbsp;1 file changed, 4 insertions(&#43;)<br>
<br>
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c<br>
index a60cded..ae8f059 100644<br>
--- a/drivers/iommu/arm-smmu.c<br>
&#43;&#43;&#43; b/drivers/iommu/arm-smmu.c<br>
@@ -260,6 &#43;260,7 @@ enum arm_smmu_s2cr_privcfg {<br>
&nbsp;<br>
&nbsp;#define TTBCR2_SEP_SHIFT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 15<br>
&nbsp;#define TTBCR2_SEP_UPSTREAM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0x7 &lt;&lt; TTBCR2_SEP_SHIFT)<br>
&#43;#define TTBCR2_AS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (=
1 &lt;&lt; 4)<br>
&nbsp;<br>
&nbsp;#define TTBRn_ASID_SHIFT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 48<br>
&nbsp;<br>
@@ -778,6 &#43;779,9 @@ static void arm_smmu_init_context_bank(struct arm_s=
mmu_domain *smmu_domain,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =
=3D pgtbl_cfg-&gt;arm_lpae_s1_cfg.tcr;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg2 =
=3D pgtbl_cfg-&gt;arm_lpae_s1_cfg.tcr &gt;&gt; 32;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg2 =
|=3D TTBCR2_SEP_UPSTREAM;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smmu-&gt=
;model =3D=3D CAVIUM_SMMUV2 &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; cfg-&gt;fmt =3D=3D ARM_SMMU_CTX_FMT_AARCH64)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg2 |=3D TTBCR2_AS;</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">it shouldn't be cavium specific just set this bet =
when we enable 16bit ASID.</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText"><br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (smmu-&gt;version &gt; ARM_SMMU_V1)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write=
l_relaxed(reg2, cb_base &#43; ARM_SMMU_CB_TTBCR2);</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">you can add my review by.&nbsp;<br>
-- <br>
2.7.4<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BN6PR07MB31868DFFF2645E60E6CF36188E660BN6PR07MB3186namp_--

--===============6693180377525463394==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6693180377525463394==--
