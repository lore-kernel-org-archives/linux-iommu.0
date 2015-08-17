From: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH v2] iommu/fsl: Really fix init section(s) content
Date: Mon, 17 Aug 2015 15:24:02 +0000
Message-ID: <oy33h1osgy70l0r4sr63xvkm.1439825001779@email.android.com>
References: <1427261328-23798-1-git-send-email-Emilian.Medve@Freescale.com>
	<BN1PR0301MB0627C7EA14ADDAEE45591EABEA770@BN1PR0301MB0627.namprd03.prod.outlook.com>,
	<BL2PR03MB545DF3C789C02ED38841F77E6790@BL2PR03MB545.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3905424593905445394=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <BL2PR03MB545DF3C789C02ED38841F77E6790-AZ66ij2kwaa1tTsckATbNOO6mTEJWrR4XA4E9RH9d+qIuWR1G4zioA@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Madalin-Cristian Bucur <madalin.bucur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============3905424593905445394==
Content-Language: en-GB
Content-Type: multipart/alternative;
	boundary="_000_oy33h1osgy70l0r4sr63xvkm1439825001779emailandroidcom_"

--_000_oy33h1osgy70l0r4sr63xvkm1439825001779emailandroidcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Thanks Madalin.

Joerg,
Can you please pick this patch.

Regards
Varun


-------- Original message --------
From: Bucur Madalin-Cristian-B32716
Date:08/17/2015 8:28 PM (GMT+05:30)
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org,iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org,Sethi Varun-B16395
Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Subject: RE: [PATCH v2] iommu/fsl: Really fix init section(s) content

Patch working on all tested platforms: B4860QDS, P2041RDB,
P3041DS, P4080DS, P5020DS, P5040DS, T1024RDB, T1040RDB,
T2080RDB, T4240QDS.

Tested-by: Madalin Bucur <Madalin.Bucur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

> -----Original Message-----
> From: Sethi Varun-B16395
> Sent: Monday, August 03, 2015 3:29 PM
> To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
> Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Medve Emilian-EMMEDVE1; Bucur Madalin-
> Cristian-B32716
> Subject: RE: [PATCH v2] iommu/fsl: Really fix init section(s) content
>
> Hi Joerg,
> This patch doesn't seem to be applied to the PAMU driver.
>
> Regards
> Varun
>
> > -----Original Message-----
> > From: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org [mailto:iommu-
> > bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org] On Behalf Of Emil Medve
> > Sent: Wednesday, March 25, 2015 10:59 AM
> > To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
> > Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Medve Emilian-EMMEDVE1
> > Subject: [PATCH v2] iommu/fsl: Really fix init section(s) content
> >
> > '0f1fb99 iommu/fsl: Fix section mismatch' was intended to address the
> > modpost warning and the potential crash. Crash which is actually easy t=
o
> > trigger with a 'unbind' followed by a 'bind' sequence. The fix is wrong=
 as
> > fsl_of_pamu_driver.driver gets added by bus_add_driver() to a couple of
> > klist(s) which become invalid/corrupted as soon as the init sections ar=
e
> freed.
> > Depending on when/how the init sections storage is reused
> various/random
> > errors and crashes will happen
> >
> > 'cd70d46 iommu/fsl: Various cleanups' contains annotations that go furt=
her
> > down the wrong path laid by '0f1fb99 iommu/fsl: Fix section mismatch'
> >
> > Now remove all the incorrect annotations from the above mentioned
> > patches (not exactly a revert) and those previously existing in the cod=
e,
> This
> > fixes the modpost warning(s), the unbind/bind sequence crashes and the
> > random errors/crashes
> >
> > Fixes: 0f1fb99b62ce ("iommu/fsl: Fix section mismatch")
> > Fixes: cd70d4659ff3 ("iommu/fsl: Various cleanups")
> > Signed-off-by: Emil Medve <Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
> > Acked-by: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > ---
> >  drivers/iommu/fsl_pamu.c | 26 +++++++++++++-------------
> >  1 file changed, 13 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c index
> > abeedc9..2570f2a 100644
> > --- a/drivers/iommu/fsl_pamu.c
> > +++ b/drivers/iommu/fsl_pamu.c
> > @@ -41,7 +41,6 @@ struct pamu_isr_data {
> >
> >  static struct paace *ppaact;
> >  static struct paace *spaact;
> > -static struct ome *omt __initdata;
> >
> >  /*
> >   * Table for matching compatible strings, for device tree @@ -50,7 +49=
,7
> @@
> > static struct ome *omt __initdata;
> >   * SOCs. For the older SOCs "fsl,qoriq-device-config-1.0"
> >   * string would be used.
> >   */
> > -static const struct of_device_id guts_device_ids[] __initconst =3D {
> > +static const struct of_device_id guts_device_ids[] =3D {
> >      { .compatible =3D "fsl,qoriq-device-config-1.0", },
> >      { .compatible =3D "fsl,qoriq-device-config-2.0", },
> >      {}
> > @@ -599,7 +598,7 @@ found_cpu_node:
> >   * Memory accesses to QMAN and BMAN private memory need not be
> > coherent, so
> >   * clear the PAACE entry coherency attribute for them.
> >   */
> > -static void __init setup_qbman_paace(struct paace *ppaace, int
> > paace_type)
> > +static void setup_qbman_paace(struct paace *ppaace, int  paace_type)
> >  {
> >      switch (paace_type) {
> >      case QMAN_PAACE:
> > @@ -629,7 +628,7 @@ static void __init setup_qbman_paace(struct paace
> > *ppaace, int  paace_type)
> >   * this table to translate device transaction to appropriate corenet
> >   * transaction.
> >   */
> > -static void __init setup_omt(struct ome *omt)
> > +static void setup_omt(struct ome *omt)
> >  {
> >      struct ome *ome;
> >
> > @@ -666,7 +665,7 @@ static void __init setup_omt(struct ome *omt)
> >   * Get the maximum number of PAACT table entries
> >   * and subwindows supported by PAMU
> >   */
> > -static void __init get_pamu_cap_values(unsigned long pamu_reg_base)
> > +static void get_pamu_cap_values(unsigned long pamu_reg_base)
> >  {
> >      u32 pc_val;
> >
> > @@ -676,9 +675,9 @@ static void __init get_pamu_cap_values(unsigned
> > long pamu_reg_base)  }
> >
> >  /* Setup PAMU registers pointing to PAACT, SPAACT and OMT */ -static i=
nt
> > __init setup_one_pamu(unsigned long pamu_reg_base, unsigned long
> > pamu_reg_size,
> > -                            phys_addr_t ppaact_phys, phys_addr_t
> > spaact_phys,
> > -                            phys_addr_t omt_phys)
> > +static int setup_one_pamu(unsigned long pamu_reg_base, unsigned long
> > pamu_reg_size,
> > +                     phys_addr_t ppaact_phys, phys_addr_t
> > spaact_phys,
> > +                     phys_addr_t omt_phys)
> >  {
> >      u32 *pc;
> >      struct pamu_mmap_regs *pamu_regs;
> > @@ -720,7 +719,7 @@ static int __init setup_one_pamu(unsigned long
> > pamu_reg_base, unsigned long pamu  }
> >
> >  /* Enable all device LIODNS */
> > -static void __init setup_liodns(void)
> > +static void setup_liodns(void)
> >  {
> >      int i, len;
> >      struct paace *ppaace;
> > @@ -846,7 +845,7 @@ struct ccsr_law {
> >  /*
> >   * Create a coherence subdomain for a given memory block.
> >   */
> > -static int __init create_csd(phys_addr_t phys, size_t size, u32 csd_po=
rt_id)
> > +static int create_csd(phys_addr_t phys, size_t size, u32 csd_port_id)
> >  {
> >      struct device_node *np;
> >      const __be32 *iprop;
> > @@ -988,7 +987,7 @@ error:
> >  static const struct {
> >      u32 svr;
> >      u32 port_id;
> > -} port_id_map[] __initconst =3D {
> > +} port_id_map[] =3D {
> >      {(SVR_P2040 << 8) | 0x10, 0xFF000000},  /* P2040 1.0 */
> >      {(SVR_P2040 << 8) | 0x11, 0xFF000000},  /* P2040 1.1 */
> >      {(SVR_P2041 << 8) | 0x10, 0xFF000000},  /* P2041 1.0 */
> > @@ -1006,7 +1005,7 @@ static const struct {
> >
> >  #define SVR_SECURITY       0x80000 /* The Security (E) bit */
> >
> > -static int __init fsl_pamu_probe(struct platform_device *pdev)
> > +static int fsl_pamu_probe(struct platform_device *pdev)
> >  {
> >      struct device *dev =3D &pdev->dev;
> >      void __iomem *pamu_regs =3D NULL;
> > @@ -1022,6 +1021,7 @@ static int __init fsl_pamu_probe(struct
> > platform_device *pdev)
> >      int irq;
> >      phys_addr_t ppaact_phys;
> >      phys_addr_t spaact_phys;
> > +   struct ome *omt;
> >      phys_addr_t omt_phys;
> >      size_t mem_size =3D 0;
> >      unsigned int order =3D 0;
> > @@ -1200,7 +1200,7 @@ error:
> >      return ret;
> >  }
> >
> > -static struct platform_driver fsl_of_pamu_driver __initdata =3D {
> > +static struct platform_driver fsl_of_pamu_driver =3D {
> >      .driver =3D {
> >              .name =3D "fsl-of-pamu",
> >      },
> > --
> > 2.3.3
> > _______________________________________________
> > iommu mailing list
> > iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> > https://lists.linuxfoundation.org/mailman/listinfo/iommu

--_000_oy33h1osgy70l0r4sr63xvkm1439825001779emailandroidcom_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<div>Thanks Madalin.
<div><br>
</div>
<div>Joerg,</div>
<div>Can you please pick this patch.</div>
<div><br>
</div>
<div>Regards</div>
<div>Varun</div>
<br>
<br>
-------- Original message --------<br>
From: Bucur Madalin-Cristian-B32716 <br>
Date:08/17/2015 8:28 PM (GMT&#43;05:30) <br>
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org,iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org,Sethi Varun-B16395 <br=
>
Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org <br>
Subject: RE: [PATCH v2] iommu/fsl: Really fix init section(s) content <br>
<br>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">Patch working on all tested platforms: B4860QDS, P=
2041RDB,<br>
P3041DS, P4080DS, P5020DS, P5040DS, T1024RDB, T1040RDB,<br>
T2080RDB, T4240QDS.<br>
<br>
Tested-by: Madalin Bucur &lt;Madalin.Bucur-KZfg59tc24xl57MIdRCFDg@public.gmane.org&gt;<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Sethi Varun-B16395<br>
&gt; Sent: Monday, August 03, 2015 3:29 PM<br>
&gt; To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org<br>
&gt; Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Medve Emilian-EMMEDVE1; Bucur Madalin-<br>
&gt; Cristian-B32716<br>
&gt; Subject: RE: [PATCH v2] iommu/fsl: Really fix init section(s) content<=
br>
&gt; <br>
&gt; Hi Joerg,<br>
&gt; This patch doesn't seem to be applied to the PAMU driver.<br>
&gt; <br>
&gt; Regards<br>
&gt; Varun<br>
&gt; <br>
&gt; &gt; -----Original Message-----<br>
&gt; &gt; From: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org [<a href=3D""></a>=
mailto:iommu-<br>
&gt; &gt; bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org] On Behalf Of Emil Medve<br>
&gt; &gt; Sent: Wednesday, March 25, 2015 10:59 AM<br>
&gt; &gt; To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org<br>
&gt; &gt; Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Medve Emilian-EMMEDVE1<br>
&gt; &gt; Subject: [PATCH v2] iommu/fsl: Really fix init section(s) content=
<br>
&gt; &gt;<br>
&gt; &gt; '0f1fb99 iommu/fsl: Fix section mismatch' was intended to address=
 the<br>
&gt; &gt; modpost warning and the potential crash. Crash which is actually =
easy to<br>
&gt; &gt; trigger with a 'unbind' followed by a 'bind' sequence. The fix is=
 wrong as<br>
&gt; &gt; fsl_of_pamu_driver.driver gets added by bus_add_driver() to a cou=
ple of<br>
&gt; &gt; klist(s) which become invalid/corrupted as soon as the init secti=
ons are<br>
&gt; freed.<br>
&gt; &gt; Depending on when/how the init sections storage is reused<br>
&gt; various/random<br>
&gt; &gt; errors and crashes will happen<br>
&gt; &gt;<br>
&gt; &gt; 'cd70d46 iommu/fsl: Various cleanups' contains annotations that g=
o further<br>
&gt; &gt; down the wrong path laid by '0f1fb99 iommu/fsl: Fix section misma=
tch'<br>
&gt; &gt;<br>
&gt; &gt; Now remove all the incorrect annotations from the above mentioned=
<br>
&gt; &gt; patches (not exactly a revert) and those previously existing in t=
he code,<br>
&gt; This<br>
&gt; &gt; fixes the modpost warning(s), the unbind/bind sequence crashes an=
d the<br>
&gt; &gt; random errors/crashes<br>
&gt; &gt;<br>
&gt; &gt; Fixes: 0f1fb99b62ce (&quot;iommu/fsl: Fix section mismatch&quot;)=
<br>
&gt; &gt; Fixes: cd70d4659ff3 (&quot;iommu/fsl: Various cleanups&quot;)<br>
&gt; &gt; Signed-off-by: Emil Medve &lt;Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org&gt;<br>
&gt; &gt; Acked-by: Varun Sethi &lt;Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org&gt;<br>
&gt; &gt; Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org<br>
&gt; &gt; ---<br>
&gt; &gt;&nbsp; drivers/iommu/fsl_pamu.c | 26 &#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-------------<br>
&gt; &gt;&nbsp; 1 file changed, 13 insertions(&#43;), 13 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c =
index<br>
&gt; &gt; abeedc9..2570f2a 100644<br>
&gt; &gt; --- a/drivers/iommu/fsl_pamu.c<br>
&gt; &gt; &#43;&#43;&#43; b/drivers/iommu/fsl_pamu.c<br>
&gt; &gt; @@ -41,7 &#43;41,6 @@ struct pamu_isr_data {<br>
&gt; &gt;<br>
&gt; &gt;&nbsp; static struct paace *ppaact;<br>
&gt; &gt;&nbsp; static struct paace *spaact;<br>
&gt; &gt; -static struct ome *omt __initdata;<br>
&gt; &gt;<br>
&gt; &gt;&nbsp; /*<br>
&gt; &gt;&nbsp;&nbsp; * Table for matching compatible strings, for device t=
ree @@ -50,7 &#43;49,7<br>
&gt; @@<br>
&gt; &gt; static struct ome *omt __initdata;<br>
&gt; &gt;&nbsp;&nbsp; * SOCs. For the older SOCs &quot;fsl,qoriq-device-con=
fig-1.0&quot;<br>
&gt; &gt;&nbsp;&nbsp; * string would be used.<br>
&gt; &gt;&nbsp;&nbsp; */<br>
&gt; &gt; -static const struct of_device_id guts_device_ids[] __initconst =
=3D {<br>
&gt; &gt; &#43;static const struct of_device_id guts_device_ids[] =3D {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { .compatible =3D &quot;fsl,qoriq-d=
evice-config-1.0&quot;, },<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { .compatible =3D &quot;fsl,qoriq-d=
evice-config-2.0&quot;, },<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {}<br>
&gt; &gt; @@ -599,7 &#43;598,7 @@ found_cpu_node:<br>
&gt; &gt;&nbsp;&nbsp; * Memory accesses to QMAN and BMAN private memory nee=
d not be<br>
&gt; &gt; coherent, so<br>
&gt; &gt;&nbsp;&nbsp; * clear the PAACE entry coherency attribute for them.=
<br>
&gt; &gt;&nbsp;&nbsp; */<br>
&gt; &gt; -static void __init setup_qbman_paace(struct paace *ppaace, int<b=
r>
&gt; &gt; paace_type)<br>
&gt; &gt; &#43;static void setup_qbman_paace(struct paace *ppaace, int&nbsp=
; paace_type)<br>
&gt; &gt;&nbsp; {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (paace_type) {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case QMAN_PAACE:<br>
&gt; &gt; @@ -629,7 &#43;628,7 @@ static void __init setup_qbman_paace(stru=
ct paace<br>
&gt; &gt; *ppaace, int&nbsp; paace_type)<br>
&gt; &gt;&nbsp;&nbsp; * this table to translate device transaction to appro=
priate corenet<br>
&gt; &gt;&nbsp;&nbsp; * transaction.<br>
&gt; &gt;&nbsp;&nbsp; */<br>
&gt; &gt; -static void __init setup_omt(struct ome *omt)<br>
&gt; &gt; &#43;static void setup_omt(struct ome *omt)<br>
&gt; &gt;&nbsp; {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ome *ome;<br>
&gt; &gt;<br>
&gt; &gt; @@ -666,7 &#43;665,7 @@ static void __init setup_omt(struct ome *=
omt)<br>
&gt; &gt;&nbsp;&nbsp; * Get the maximum number of PAACT table entries<br>
&gt; &gt;&nbsp;&nbsp; * and subwindows supported by PAMU<br>
&gt; &gt;&nbsp;&nbsp; */<br>
&gt; &gt; -static void __init get_pamu_cap_values(unsigned long pamu_reg_ba=
se)<br>
&gt; &gt; &#43;static void get_pamu_cap_values(unsigned long pamu_reg_base)=
<br>
&gt; &gt;&nbsp; {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 pc_val;<br>
&gt; &gt;<br>
&gt; &gt; @@ -676,9 &#43;675,9 @@ static void __init get_pamu_cap_values(un=
signed<br>
&gt; &gt; long pamu_reg_base)&nbsp; }<br>
&gt; &gt;<br>
&gt; &gt;&nbsp; /* Setup PAMU registers pointing to PAACT, SPAACT and OMT *=
/ -static int<br>
&gt; &gt; __init setup_one_pamu(unsigned long pamu_reg_base, unsigned long<=
br>
&gt; &gt; pamu_reg_size,<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; phys_addr_t ppaact_phys, phys_addr_t<br>
&gt; &gt; spaact_phys,<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; phys_addr_t omt_phys)<br>
&gt; &gt; &#43;static int setup_one_pamu(unsigned long pamu_reg_base, unsig=
ned long<br>
&gt; &gt; pamu_reg_size,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phys_addr_t pp=
aact_phys, phys_addr_t<br>
&gt; &gt; spaact_phys,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phys_addr_t om=
t_phys)<br>
&gt; &gt;&nbsp; {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 *pc;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pamu_mmap_regs *pamu_regs;<b=
r>
&gt; &gt; @@ -720,7 &#43;719,7 @@ static int __init setup_one_pamu(unsigned=
 long<br>
&gt; &gt; pamu_reg_base, unsigned long pamu&nbsp; }<br>
&gt; &gt;<br>
&gt; &gt;&nbsp; /* Enable all device LIODNS */<br>
&gt; &gt; -static void __init setup_liodns(void)<br>
&gt; &gt; &#43;static void setup_liodns(void)<br>
&gt; &gt;&nbsp; {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, len;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct paace *ppaace;<br>
&gt; &gt; @@ -846,7 &#43;845,7 @@ struct ccsr_law {<br>
&gt; &gt;&nbsp; /*<br>
&gt; &gt;&nbsp;&nbsp; * Create a coherence subdomain for a given memory blo=
ck.<br>
&gt; &gt;&nbsp;&nbsp; */<br>
&gt; &gt; -static int __init create_csd(phys_addr_t phys, size_t size, u32 =
csd_port_id)<br>
&gt; &gt; &#43;static int create_csd(phys_addr_t phys, size_t size, u32 csd=
_port_id)<br>
&gt; &gt;&nbsp; {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device_node *np;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const __be32 *iprop;<br>
&gt; &gt; @@ -988,7 &#43;987,7 @@ error:<br>
&gt; &gt;&nbsp; static const struct {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 svr;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 port_id;<br>
&gt; &gt; -} port_id_map[] __initconst =3D {<br>
&gt; &gt; &#43;} port_id_map[] =3D {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {(SVR_P2040 &lt;&lt; 8) | 0x10, 0xF=
F000000},&nbsp; /* P2040 1.0 */<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {(SVR_P2040 &lt;&lt; 8) | 0x11, 0xF=
F000000},&nbsp; /* P2040 1.1 */<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {(SVR_P2041 &lt;&lt; 8) | 0x10, 0xF=
F000000},&nbsp; /* P2041 1.0 */<br>
&gt; &gt; @@ -1006,7 &#43;1005,7 @@ static const struct {<br>
&gt; &gt;<br>
&gt; &gt;&nbsp; #define SVR_SECURITY&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x=
80000 /* The Security (E) bit */<br>
&gt; &gt;<br>
&gt; &gt; -static int __init fsl_pamu_probe(struct platform_device *pdev)<b=
r>
&gt; &gt; &#43;static int fsl_pamu_probe(struct platform_device *pdev)<br>
&gt; &gt;&nbsp; {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device *dev =3D &amp;pdev-&g=
t;dev;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void __iomem *pamu_regs =3D NULL;<b=
r>
&gt; &gt; @@ -1022,6 &#43;1021,7 @@ static int __init fsl_pamu_probe(struct=
<br>
&gt; &gt; platform_device *pdev)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int irq;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phys_addr_t ppaact_phys;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phys_addr_t spaact_phys;<br>
&gt; &gt; &#43;&nbsp;&nbsp; struct ome *omt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phys_addr_t omt_phys;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t mem_size =3D 0;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int order =3D 0;<br>
&gt; &gt; @@ -1200,7 &#43;1200,7 @@ error:<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt;&nbsp; }<br>
&gt; &gt;<br>
&gt; &gt; -static struct platform_driver fsl_of_pamu_driver __initdata =3D =
{<br>
&gt; &gt; &#43;static struct platform_driver fsl_of_pamu_driver =3D {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .driver =3D {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; .name =3D &quot;fsl-of-pamu&quot;,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
&gt; &gt; --<br>
&gt; &gt; 2.3.3<br>
&gt; &gt; _______________________________________________<br>
&gt; &gt; iommu mailing list<br>
&gt; &gt; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org<br>
&gt; &gt; <a href=3D"https://lists.linuxfoundation.org/mailman/listinfo/iom=
mu">https://lists.linuxfoundation.org/mailman/listinfo/iommu</a><br>
</div>
</span></font>
</body>
</html>

--_000_oy33h1osgy70l0r4sr63xvkm1439825001779emailandroidcom_--

--===============3905424593905445394==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3905424593905445394==--
