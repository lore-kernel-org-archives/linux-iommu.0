From: "Sricharan" <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: RE: [PATCH V3 5/8] iommu: of: Handle IOMMU lookup failure with
	deferred probing or error
Date: Thu, 27 Oct 2016 08:25:43 +0530
Message-ID: <004a01d22ffd$9fd937d0$df8ba770$@codeaurora.org>
References: <1475600632-21289-1-git-send-email-sricharan@codeaurora.org>
	<1475600632-21289-6-git-send-email-sricharan@codeaurora.org>
	<f08e65b4-f755-897c-f776-40f0d6788251@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <f08e65b4-f755-897c-f776-40f0d6788251-5wv7dgnIgG8@public.gmane.org>
Content-Language: en-us
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: 'Robin Murphy' <robin.murphy-5wv7dgnIgG8@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

>> From: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
>>
>> Failures to look up an IOMMU when parsing the DT iommus property need to
>> be handled separately from the .of_xlate() failures to support deferred
>> probing.
>>
>> The lack of a registered IOMMU can be caused by the lack of a driver for
>> the IOMMU, the IOMMU device probe not having been performed yet, having
>> been deferred, or having failed.
>>
>> The first case occurs when the device tree describes the bus master and
>> IOMMU topology correctly but no device driver exists for the IOMMU yet
>> or the device driver has not been compiled in. Return NULL, the caller
>> will configure the device without an IOMMU.
>>
>> The second and third cases are handled by deferring the probe of the bus
>> master device which will eventually get reprobed after the IOMMU.
>>
>> The last case is currently handled by deferring the probe of the bus
>> master device as well. A mechanism to either configure the bus master
>> device without an IOMMU or to fail the bus master device probe depending
>> on whether the IOMMU is optional or mandatory would be a good
>> enhancement.
>>
>> The current iommu framework handles pci and non-pci devices separately,
>> so taken care of both the paths in this patch. The iommu's add_device
>> callback is invoked after the master's configuration data is added in
>> xlate. This is needed because the iommu core calls add_device callback
>> during the BUS_ADD_DEVICE notifier, which is of no use now. Eventually
>> that call has to be removed.
>
>Laurent's signoff seems to have gone missing here.

Ah, preserved his authorship, but missed this. Will add it back.

>
>> Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> ---
>>  drivers/iommu/of_iommu.c  | 47 +++++++++++++++++++++++++++++++++++++++++++----
>>  drivers/of/device.c       |  7 ++++++-
>>  include/linux/of_device.h |  6 ++++--
>>  3 files changed, 53 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
>> index 5b82862..1a5e28b 100644
>> --- a/drivers/iommu/of_iommu.c
>> +++ b/drivers/iommu/of_iommu.c
>> @@ -23,6 +23,7 @@
>>  #include <linux/of.h>
>>  #include <linux/of_iommu.h>
>>  #include <linux/of_pci.h>
>> +#include <linux/pci.h>
>>  #include <linux/slab.h>
>>
>>  static const struct of_device_id __iommu_of_table_sentinel
>> @@ -167,12 +168,29 @@ static const struct iommu_ops
>>  		return NULL;
>>
>>  	ops = of_iommu_get_ops(iommu_spec.np);
>> +
>> +	if (!ops) {
>> +		const struct of_device_id *oid;
>> +
>> +		oid = of_match_node(&__iommu_of_table, iommu_spec.np);
>> +		ops = oid ? ERR_PTR(-EPROBE_DEFER) : NULL;
>
>It would seem even simpler and more convenient to roll this into the end
>of of_iommu_get_ops():

ok, understand. Will move this there.

>
>	if (!ops && of_match_node(&__iommu_of_table, iommu_spec.np))
>		ops = ERR_PTR(-EPROBE_DEFER);
>
>then just fix up the existing !ops checks to !IS_ERR(ops) appropriately.

ok.

>
>> +		return ops;
>> +	}
>> +
>>  	if (!ops || !ops->of_xlate ||
>>  	    iommu_fwspec_init(&pdev->dev, &iommu_spec.np->fwnode, ops) ||
>>  	    ops->of_xlate(&pdev->dev, &iommu_spec))
>>  		ops = NULL;
>>
>> +	if (ops && ops->add_device) {
>> +		ops = (ops->add_device(&pdev->dev) == 0) ? ops : NULL;
>
>This is a really obtuse way of writing
>
>	if (ops->add_device(...))
>		ops = NULL;

ok, will change it this way.

>
>However, given that we're now returning an ERR_PTR, it would be worth
>capturing the return value of add_device and propagating the error back
>up - if the IOMMU driver has refused one of its masters for some reason,
>it probably isn't safe to allow that device to do DMA either way, so we
>ought to prevent it probing at all.
>

ok, will return the err value instead of NULL here.

>> +
>> +		if (!ops)
>> +			dev_err(&pdev->dev, "Failed to setup iommu ops\n");
>
>Given the above, I think this should be more along the lines of "Device
>rejected by IOMMU: %d" with the actual error code as well. It's one of
>those "if you ever see it, you're going to have to debug it" cases, so
>the clearer the better.
>

ok, will reword the print.

>> +	}
>> +
>>  	of_node_put(iommu_spec.np);
>> +
>>  	return ops;
>>  }
>>
>> @@ -183,9 +201,15 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
>>  	struct device_node *np;
>>  	const struct iommu_ops *ops = NULL;
>>  	int idx = 0;
>> +	struct device *bridge;
>> +
>> +	if (dev_is_pci(dev)) {
>> +		bridge = pci_get_host_bridge_device(to_pci_dev(dev));
>>
>> -	if (dev_is_pci(dev))
>> -		return of_pci_iommu_configure(to_pci_dev(dev), master_np);
>> +		if (bridge && bridge->parent && bridge->parent->of_node)
>> +			return of_pci_iommu_configure(to_pci_dev(dev),
>> +						      bridge->parent->of_node);
>
>		else fall through to treating it as a platform device?
>

ha, surely wrong. Will correct this and move it to the of_pci_iommu_configure helper.

>...that's not right. Anyway, this is PCI-specific stuff so should be in
>the PCI-specific helper function.
>
>> +	}
>>
>>  	/*
>>  	 * We don't currently walk up the tree looking for a parent IOMMU.
>> @@ -198,6 +222,14 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
>>  		np = iommu_spec.np;
>>  		ops = of_iommu_get_ops(np);
>>
>> +		if (!ops) {
>> +			const struct of_device_id *oid;
>> +
>> +			oid = of_match_node(&__iommu_of_table, np);
>> +			ops = oid ? ERR_PTR(-EPROBE_DEFER) : NULL;
>> +			goto err_put_node;
>> +		}
>
>Same comment as above. Especially since moving it to of_iommu_get_ops()
>would obviate the duplication.

ok.

>
>> +
>>  		if (!ops || !ops->of_xlate ||
>>  		    iommu_fwspec_init(dev, &np->fwnode, ops) ||
>>  		    ops->of_xlate(dev, &iommu_spec))
>> @@ -207,11 +239,18 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
>>  		idx++;
>>  	}
>>
>> +	if (ops && ops->add_device) {
>> +		ops = (ops->add_device(dev) == 0) ? ops : NULL;
>> +
>> +		if (!ops)
>> +			dev_err(dev, "Failed to setup iommu_ops\n");
>> +	}
>> +
>
>It would be nice to avoid duplicating this as well.

ok, sure, will correct.

Regards,
 Sricharan
