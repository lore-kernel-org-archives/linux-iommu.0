From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: RE: [PATCH 02/13] soc/fsl/bman: map FBPR area in the iommu
Date: Fri, 19 Apr 2019 13:41:38 +0000
Message-ID: <VI1PR04MB5134C8A672CD99F521DBFE7EEC270@VI1PR04MB5134.eurprd04.prod.outlook.com>
References: <20190329140014.8126-1-laurentiu.tudor@nxp.com>
 <20190329140014.8126-3-laurentiu.tudor@nxp.com>
 <b747c418-a495-56e0-c106-a8ec8e82ccb9@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <b747c418-a495-56e0-c106-a8ec8e82ccb9@arm.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Robin Murphy <robin.murphy@arm.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Madalin-cristian Bucur <madalin.bucur@nxp.com>, Roy Pledge <roy.pledge@nxp.com>, Camelia Alexandra Groza <camelia.groza@nxp.com>, Leo Li <leoyang.li@nxp.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "davem@davemloft.net" <davem@davemloft.net>
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

> -----Original Message-----
> From: Robin Murphy <robin.murphy@arm.com>
> Sent: Friday, March 29, 2019 4:51 PM
> 
> On 29/03/2019 14:00, laurentiu.tudor@nxp.com wrote:
> > From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> >
> > Add a one-to-one iommu mapping for bman private data memory (FBPR).
> > This is required for BMAN to work without faults behind an iommu.
> >
> > Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> > ---
> >   drivers/soc/fsl/qbman/bman_ccsr.c | 11 +++++++++++
> >   1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/soc/fsl/qbman/bman_ccsr.c
> b/drivers/soc/fsl/qbman/bman_ccsr.c
> > index 7c3cc968053c..b209c79511bb 100644
> > --- a/drivers/soc/fsl/qbman/bman_ccsr.c
> > +++ b/drivers/soc/fsl/qbman/bman_ccsr.c
> > @@ -29,6 +29,7 @@
> >    */
> >
> >   #include "bman_priv.h"
> > +#include <linux/iommu.h>
> >
> >   u16 bman_ip_rev;
> >   EXPORT_SYMBOL(bman_ip_rev);
> > @@ -178,6 +179,7 @@ static int fsl_bman_probe(struct platform_device
> *pdev)
> >   	int ret, err_irq;
> >   	struct device *dev = &pdev->dev;
> >   	struct device_node *node = dev->of_node;
> > +	struct iommu_domain *domain;
> >   	struct resource *res;
> >   	u16 id, bm_pool_cnt;
> >   	u8 major, minor;
> > @@ -225,6 +227,15 @@ static int fsl_bman_probe(struct platform_device
> *pdev)
> >
> >   	dev_dbg(dev, "Allocated FBPR 0x%llx 0x%zx\n", fbpr_a, fbpr_sz);
> >
> > +	/* Create an 1-to-1 iommu mapping for FBPR area */
> > +	domain = iommu_get_domain_for_dev(dev);
> 
> If that's expected to be the default domain that you're grabbing, then
> this is *incredibly* fragile. There's nothing to stop the IOVA that you
> forcibly map from being automatically allocated later and causing some
> other DMA mapping to fail noisily and unexpectedly. Furthermore, have
> you tried this with "iommu.passthrough=1"?
> 
> That said, I really don't understand what's going on here anyway :/
> 
> As far as I can tell from qbman_init_private_mem(), fbpr_a comes from
> dma_alloc_coherent() and thus would already be a mapped IOVA - isn't
> this the stuff that Roy converted to nicely use shared-dma-pool regions
> a while ago?
> 

Finally found some time to look into this, sorry for the delay. It seems that on the code path taken in our case (dma_alloc_coherent() -> dma_alloc_attrs() -> dma_alloc_from_dev_coherent() -> __dma_alloc_from_coherent()) there's no call into the iommu layer, thus no mapping in the smmu. I plan to come up with a RFC patch early next week so we have something concrete to discuss on.

---
Best Regards, Laurentiu
