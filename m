From: Ruxandra Ioana Radulescu <ruxandra.radulescu-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [PATCH 1/2] staging: fsl-dpaa2/eth: Fix address translations
Date: Thu, 25 May 2017 12:31:17 +0000
Message-ID: <VI1PR0402MB28477848AE840A1E5C819C3E94FF0@VI1PR0402MB2847.eurprd04.prod.outlook.com>
References: <20170524121328.16984-1-ruxandra.radulescu@nxp.com>
	<59257DB0.8010604@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <59257DB0.8010604-3arQi8VN3Tc@public.gmane.org>
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
To: Laurentiu Tudor <laurentiu.tudor-3arQi8VN3Tc@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: "devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org" <devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org>, "stuyoder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <stuyoder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "agraf-l3A5Bk7waGM@public.gmane.org" <agraf-l3A5Bk7waGM@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Bogdan Purcareata <bogdan.purcareata-3arQi8VN3Tc@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

> -----Original Message-----
> From: Laurentiu Tudor
> Sent: Wednesday, May 24, 2017 3:34 PM
> To: Ruxandra Ioana Radulescu <ruxandra.radulescu-3arQi8VN3Tc@public.gmane.org>;
> gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
> Cc: devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> agraf-l3A5Bk7waGM@public.gmane.org; arnd-r2nGTMty4D4@public.gmane.org; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org;
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; Bogdan Purcareata
> <bogdan.purcareata-3arQi8VN3Tc@public.gmane.org>; stuyoder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; Nipun Gupta
> <nipun.gupta-3arQi8VN3Tc@public.gmane.org>
> Subject: Re: [PATCH 1/2] staging: fsl-dpaa2/eth: Fix address translations
> 
> Hi Ioana,
> 
> Debatable nit inline.
> 
> On 05/24/2017 03:13 PM, Ioana Radulescu wrote:
> > Use the correct mechanisms for translating a DMA-mapped IOVA
> > address into a virtual one. Without this fix, once SMMU is
> > enabled on Layerscape platforms, the Ethernet driver throws
> > IOMMU translation faults.
> >
> > Signed-off-by: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>
> > Signed-off-by: Ioana Radulescu <ruxandra.radulescu-3arQi8VN3Tc@public.gmane.org>
> > ---
> >   drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c | 25
> +++++++++++++++++++------
> >   drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h |  1 +
> >   2 files changed, 20 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
> b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
> > index 6f9eed66c64d..3fee0d6f17e0 100644
> > --- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
> > +++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
> > @@ -37,6 +37,7 @@
> >   #include <linux/interrupt.h>
> >   #include <linux/msi.h>
> >   #include <linux/kthread.h>
> > +#include <linux/iommu.h>
> >
> >   #include "../../fsl-mc/include/mc.h"
> >   #include "../../fsl-mc/include/mc-sys.h"
> > @@ -54,6 +55,16 @@ MODULE_DESCRIPTION("Freescale DPAA2 Ethernet
> Driver");
> >
> >   const char dpaa2_eth_drv_version[] = "0.1";
> >
> > +static void *dpaa2_iova_to_virt(struct iommu_domain *domain,
> 
> if you pass a "struct dpaa2_eth_priv *priv" instead of "iommu_domain"
> you can move the priv->iommu_domain reference in the function and
> slightly simplify the call sites.
 
Fair point, but I'd prefer keeping this function independent of the
Ethernet driver's private data structure. This way, if other (future)
DPAA2 drivers will need a similar function, we can just move it
to a common area instead of duplicating the code.

Thanks,
Ioana
