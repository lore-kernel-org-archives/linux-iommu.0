From: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 3/7] of/irq: Break out msi-map lookup (again)
Date: Tue, 14 Jun 2016 12:01:18 -0500
Message-ID: <CAL_JsqJ4km0dH2PxHma9-cPwC20WR0ejn_14UeV0vBWJ+XLBBg@mail.gmail.com>
References: <cover.1464966939.git.robin.murphy@arm.com>
	<2cbffa9a341edfd10114994f6486f6b08d0c390c.1464966939.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <2cbffa9a341edfd10114994f6486f6b08d0c390c.1464966939.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Jun 3, 2016 at 12:15 PM, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
> The PCI msi-map code is already doing double-duty translating IDs and
> retrieving MSI parents, which unsurprisingly is the same functionality
> we need for the identically-formatted PCI iommu-map property. Drag the
> core parsing routine up yet another layer into the general OF-PCI code,
> and further generalise it for either kind of lookup in either flavour
> of map property.
>
> CC: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> CC: Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> CC: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
>
> v2: No change.
>
>  drivers/of/irq.c       |  70 ++-------------------------------
>  drivers/of/of_pci.c    | 102 +++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/of_pci.h |   8 ++++
>  3 files changed, 114 insertions(+), 66 deletions(-)
>
> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> index e7bfc175b8e1..0c9118d849ee 100644
> --- a/drivers/of/irq.c
> +++ b/drivers/of/irq.c
> @@ -24,6 +24,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_irq.h>
> +#include <linux/of_pci.h>
>  #include <linux/string.h>
>  #include <linux/slab.h>
>
> @@ -586,13 +587,7 @@ static u32 __of_msi_map_rid(struct device *dev, struct device_node **np,
>                             u32 rid_in)
>  {
>         struct device *parent_dev;
> -       struct device_node *msi_controller_node;
> -       struct device_node *msi_np = *np;
> -       u32 map_mask, masked_rid, rid_base, msi_base, rid_len, phandle;
> -       int msi_map_len;
> -       bool matched;
>         u32 rid_out = rid_in;
> -       const __be32 *msi_map = NULL;
>
>         /*
>          * Walk up the device parent links looking for one with a
> @@ -602,71 +597,14 @@ static u32 __of_msi_map_rid(struct device *dev, struct device_node **np,
>                 if (!parent_dev->of_node)
>                         continue;
>
> -               msi_map = of_get_property(parent_dev->of_node,
> -                                         "msi-map", &msi_map_len);
> -               if (!msi_map)
> +               if (!of_property_read_bool(parent_dev->of_node, "msi-map"))

But msi-map is not bool, right? I think we allow bools to have values
for historical reasons, but really bool with a value should be an
error. So don't rely on current behavior.

>                         continue;
>
> -               if (msi_map_len % (4 * sizeof(__be32))) {
> -                       dev_err(parent_dev, "Error: Bad msi-map length: %d\n",
> -                               msi_map_len);
> -                       return rid_out;
> -               }
>                 /* We have a good parent_dev and msi_map, let's use them. */
> +               of_pci_map_rid(parent_dev->of_node, "msi-map", rid_in, np,
> +                              &rid_out);

Seems like this could return an error code and then you could continue
based on the return code. Then you wouldn't be looking up msi-map
twice. Probably could get rid of the !parent_dev->of_node check too.

Rob
