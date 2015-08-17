From: Madalin-Cristian Bucur <madalin.bucur@freescale.com>
Subject: RE: [PATCH v2] iommu/fsl: Really fix init section(s) content
Date: Mon, 17 Aug 2015 14:58:24 +0000
Message-ID: <BL2PR03MB545DF3C789C02ED38841F77E6790@BL2PR03MB545.namprd03.prod.outlook.com>
References: <1427261328-23798-1-git-send-email-Emilian.Medve@Freescale.com>
 <BN1PR0301MB0627C7EA14ADDAEE45591EABEA770@BN1PR0301MB0627.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <BN1PR0301MB0627C7EA14ADDAEE45591EABEA770@BN1PR0301MB0627.namprd03.prod.outlook.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: "joro@8bytes.org" <joro@8bytes.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Varun Sethi <Varun.Sethi@freescale.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

Patch working on all tested platforms: B4860QDS, P2041RDB,
P3041DS, P4080DS, P5020DS, P5040DS, T1024RDB, T1040RDB,
T2080RDB, T4240QDS.

Tested-by: Madalin Bucur <Madalin.Bucur@freescale.com>

> -----Original Message-----
> From: Sethi Varun-B16395
> Sent: Monday, August 03, 2015 3:29 PM
> To: iommu@lists.linux-foundation.org; joro@8bytes.org
> Cc: stable@vger.kernel.org; Medve Emilian-EMMEDVE1; Bucur Madalin-
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
> > From: iommu-bounces@lists.linux-foundation.org [mailto:iommu-
> > bounces@lists.linux-foundation.org] On Behalf Of Emil Medve
> > Sent: Wednesday, March 25, 2015 10:59 AM
> > To: iommu@lists.linux-foundation.org; joro@8bytes.org
> > Cc: stable@vger.kernel.org; Medve Emilian-EMMEDVE1
> > Subject: [PATCH v2] iommu/fsl: Really fix init section(s) content
> >
> > '0f1fb99 iommu/fsl: Fix section mismatch' was intended to address the
> > modpost warning and the potential crash. Crash which is actually easy to
> > trigger with a 'unbind' followed by a 'bind' sequence. The fix is wrong as
> > fsl_of_pamu_driver.driver gets added by bus_add_driver() to a couple of
> > klist(s) which become invalid/corrupted as soon as the init sections are
> freed.
> > Depending on when/how the init sections storage is reused
> various/random
> > errors and crashes will happen
> >
> > 'cd70d46 iommu/fsl: Various cleanups' contains annotations that go further
> > down the wrong path laid by '0f1fb99 iommu/fsl: Fix section mismatch'
> >
> > Now remove all the incorrect annotations from the above mentioned
> > patches (not exactly a revert) and those previously existing in the code,
> This
> > fixes the modpost warning(s), the unbind/bind sequence crashes and the
> > random errors/crashes
> >
> > Fixes: 0f1fb99b62ce ("iommu/fsl: Fix section mismatch")
> > Fixes: cd70d4659ff3 ("iommu/fsl: Various cleanups")
> > Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
> > Acked-by: Varun Sethi <Varun.Sethi@freescale.com>
> > Cc: stable@vger.kernel.org
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
> >   * Table for matching compatible strings, for device tree @@ -50,7 +49,7
> @@
> > static struct ome *omt __initdata;
> >   * SOCs. For the older SOCs "fsl,qoriq-device-config-1.0"
> >   * string would be used.
> >   */
> > -static const struct of_device_id guts_device_ids[] __initconst = {
> > +static const struct of_device_id guts_device_ids[] = {
> >  	{ .compatible = "fsl,qoriq-device-config-1.0", },
> >  	{ .compatible = "fsl,qoriq-device-config-2.0", },
> >  	{}
> > @@ -599,7 +598,7 @@ found_cpu_node:
> >   * Memory accesses to QMAN and BMAN private memory need not be
> > coherent, so
> >   * clear the PAACE entry coherency attribute for them.
> >   */
> > -static void __init setup_qbman_paace(struct paace *ppaace, int
> > paace_type)
> > +static void setup_qbman_paace(struct paace *ppaace, int  paace_type)
> >  {
> >  	switch (paace_type) {
> >  	case QMAN_PAACE:
> > @@ -629,7 +628,7 @@ static void __init setup_qbman_paace(struct paace
> > *ppaace, int  paace_type)
> >   * this table to translate device transaction to appropriate corenet
> >   * transaction.
> >   */
> > -static void __init setup_omt(struct ome *omt)
> > +static void setup_omt(struct ome *omt)
> >  {
> >  	struct ome *ome;
> >
> > @@ -666,7 +665,7 @@ static void __init setup_omt(struct ome *omt)
> >   * Get the maximum number of PAACT table entries
> >   * and subwindows supported by PAMU
> >   */
> > -static void __init get_pamu_cap_values(unsigned long pamu_reg_base)
> > +static void get_pamu_cap_values(unsigned long pamu_reg_base)
> >  {
> >  	u32 pc_val;
> >
> > @@ -676,9 +675,9 @@ static void __init get_pamu_cap_values(unsigned
> > long pamu_reg_base)  }
> >
> >  /* Setup PAMU registers pointing to PAACT, SPAACT and OMT */ -static int
> > __init setup_one_pamu(unsigned long pamu_reg_base, unsigned long
> > pamu_reg_size,
> > -				 phys_addr_t ppaact_phys, phys_addr_t
> > spaact_phys,
> > -				 phys_addr_t omt_phys)
> > +static int setup_one_pamu(unsigned long pamu_reg_base, unsigned long
> > pamu_reg_size,
> > +			  phys_addr_t ppaact_phys, phys_addr_t
> > spaact_phys,
> > +			  phys_addr_t omt_phys)
> >  {
> >  	u32 *pc;
> >  	struct pamu_mmap_regs *pamu_regs;
> > @@ -720,7 +719,7 @@ static int __init setup_one_pamu(unsigned long
> > pamu_reg_base, unsigned long pamu  }
> >
> >  /* Enable all device LIODNS */
> > -static void __init setup_liodns(void)
> > +static void setup_liodns(void)
> >  {
> >  	int i, len;
> >  	struct paace *ppaace;
> > @@ -846,7 +845,7 @@ struct ccsr_law {
> >  /*
> >   * Create a coherence subdomain for a given memory block.
> >   */
> > -static int __init create_csd(phys_addr_t phys, size_t size, u32 csd_port_id)
> > +static int create_csd(phys_addr_t phys, size_t size, u32 csd_port_id)
> >  {
> >  	struct device_node *np;
> >  	const __be32 *iprop;
> > @@ -988,7 +987,7 @@ error:
> >  static const struct {
> >  	u32 svr;
> >  	u32 port_id;
> > -} port_id_map[] __initconst = {
> > +} port_id_map[] = {
> >  	{(SVR_P2040 << 8) | 0x10, 0xFF000000},	/* P2040 1.0 */
> >  	{(SVR_P2040 << 8) | 0x11, 0xFF000000},	/* P2040 1.1 */
> >  	{(SVR_P2041 << 8) | 0x10, 0xFF000000},	/* P2041 1.0 */
> > @@ -1006,7 +1005,7 @@ static const struct {
> >
> >  #define SVR_SECURITY	0x80000	/* The Security (E) bit */
> >
> > -static int __init fsl_pamu_probe(struct platform_device *pdev)
> > +static int fsl_pamu_probe(struct platform_device *pdev)
> >  {
> >  	struct device *dev = &pdev->dev;
> >  	void __iomem *pamu_regs = NULL;
> > @@ -1022,6 +1021,7 @@ static int __init fsl_pamu_probe(struct
> > platform_device *pdev)
> >  	int irq;
> >  	phys_addr_t ppaact_phys;
> >  	phys_addr_t spaact_phys;
> > +	struct ome *omt;
> >  	phys_addr_t omt_phys;
> >  	size_t mem_size = 0;
> >  	unsigned int order = 0;
> > @@ -1200,7 +1200,7 @@ error:
> >  	return ret;
> >  }
> >
> > -static struct platform_driver fsl_of_pamu_driver __initdata = {
> > +static struct platform_driver fsl_of_pamu_driver = {
> >  	.driver = {
> >  		.name = "fsl-of-pamu",
> >  	},
> > --
> > 2.3.3
> > _______________________________________________
> > iommu mailing list
> > iommu@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/iommu
