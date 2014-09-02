From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [RFC PATCH v2 4/7] iommu: provide helper function to configure an
	IOMMU for an of master
Date: Tue, 02 Sep 2014 21:10:10 +0200
Message-ID: <5768908.PeRFksrdyQ@wuerfel>
References: <1409680587-29818-1-git-send-email-will.deacon@arm.com>
	<1409680587-29818-5-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1409680587-29818-5-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tuesday 02 September 2014 18:56:24 Will Deacon wrote:
> +struct iommu_dma_mapping *of_iommu_configure(struct device *dev)
> +{
> +       struct of_phandle_args iommu_spec;
> +       struct iommu_dma_mapping *mapping;
> +       struct bus_type *bus = dev->bus;
> +       const struct iommu_ops *ops = bus->iommu_ops;

I think it would be best to not even introduce the tight coupling
between bus_type and iommu_ops here, one of the main reasons we
are doing this is to break that connection.

Better put the iommu_ops into the iommu_data pointer that gets looked
up per iommu device.

> +       struct iommu_data *iommu = NULL;
> +       int idx = 0;
> +
> +       if (!iommu_present(bus) || !ops->of_xlate)
> +               return NULL;
> +
> +       /*
> +        * We don't currently walk up the tree looking for a parent IOMMU.
> +        * See the `Notes:' section of
> +        * Documentation/devicetree/bindings/iommu/iommu.txt
> +        */
> +        */
> +       while (!of_parse_phandle_with_args(dev->of_node, "iommus",
> +                                          "#iommu-cells", idx,
> +                                          &iommu_spec)) {
> +               struct device_node *np = iommu_spec.np;
> +               struct iommu_data *data = of_iommu_get_data(np);
> +
> +               if (!iommu) {
> +                       if (!ops->of_xlate(dev, &iommu_spec))
> +                               iommu = data;

I would make the first argument of the of_xlate function the iommu_data,
so the code can find the right instance.

Maybe also add an extra argument at the end that can be used by the
PCI code and potentially other drivers with multiple master IDs
behind one "iommus" property to pass some value identifying which of
the masters is meant.

The format of that is unfortunately bus specific and our platform_bus
really covers a number of different hardware buses (AXI, AHB, OPB, ...)
but the caller should be able to provide the data in the right form
that the iommu understands. I would try using a single u64 argument
as a start, hoping that this covers all the buses we need. At least
it's enough for PCI (bus/device/function) and for AXI (requester-id?).

> +               } else if (iommu != data) {
> +                       pr_warn("Rejecting device %s with multiple IOMMU instances\n",
> +                               dev_name(dev));
> +                       iommu = NULL;
> +               }
> +
> +               of_node_put(np);
> +
> +               if (!iommu)
> +                       break;
> +
> +               idx++;
> +       }
> +
> +       if (!iommu)
> +               return NULL;
> +
> +       mapping = devm_kzalloc(dev, sizeof(*mapping), GFP_KERNEL);
> +       if (!mapping)
> +               return NULL;
> 

I don't think it's safe to use devm_* functions here: this is during
device discovery, and this data will be freed if probe() fails or
the device gets removed from a driver.

	Arnd
