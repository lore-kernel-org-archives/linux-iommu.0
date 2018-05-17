From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 01/40] iommu: Introduce Shared Virtual Addressing API
Date: Thu, 17 May 2018 11:02:02 +0100
Message-ID: <96c1e0f0-0aa7-badf-123e-cbb1b05e645e@arm.com>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
	<20180511190641.23008-2-jean-philippe.brucker@arm.com>
	<20180516134150.34fc8857@jacob-builder>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180516134150.34fc8857@jacob-builder>
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
To: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "xuzaibo-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <xuzaibo-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org" <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, "ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "bharatku-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org" <bharatku-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org" <rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "rgummal-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org" <rgummal-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "christian.koenig-5C7GfCeVMHo@public.gmane.org" <christian.koenig-5C7GfCeVMHo@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Jacob,

Thanks for reviewing this

On 16/05/18 21:41, Jacob Pan wrote:
>> + * The device must support multiple address spaces (e.g. PCI PASID).
>> By default
>> + * the PASID allocated during bind() is limited by the IOMMU
>> capacity, and by
>> + * the device PASID width defined in the PCI capability or in the
>> firmware
>> + * description. Setting @max_pasid to a non-zero value smaller than
>> this limit
>> + * overrides it.
>> + *
> seems the min_pasid never gets used. do you really need it?

Yes, the SMMU sets it to 1 in patch 28/40, because it needs to reserve
PASID 0

>> + * The device should not be performing any DMA while this function
>> is running,
>> + * otherwise the behavior is undefined.
>> + *
>> + * Return 0 if initialization succeeded, or an error.
>> + */
>> +int iommu_sva_device_init(struct device *dev, unsigned long features,
>> +			  unsigned int max_pasid)
>> +{
>> +	int ret;
>> +	struct iommu_sva_param *param;
>> +	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
>> +
>> +	if (!domain || !domain->ops->sva_device_init)
>> +		return -ENODEV;
>> +
>> +	if (features)
>> +		return -EINVAL;
> should it be !features?

This checks if the user sets any unsupported bit in features. No feature
is supported right now, but patch 09/40 adds IOMMU_SVA_FEAT_IOPF, and
changes this line to "features & ~IOMMU_SVA_FEAT_IOPF"

>> +	mutex_lock(&dev->iommu_param->lock);
>> +	param = dev->iommu_param->sva_param;
>> +	dev->iommu_param->sva_param = NULL;
>> +	mutex_unlock(&dev->iommu_param->lock);
>> +	if (!param)
>> +		return -ENODEV;
>> +
>> +	if (domain->ops->sva_device_shutdown)
>> +		domain->ops->sva_device_shutdown(dev, param);
> seems a little mismatch here, do you need pass the param. I don't think
> there is anything else model specific iommu driver need to do for the
> param.

SMMU doesn't use it, but maybe it would remind other IOMMU driver which
features were enabled, so they don't have to keep track of that
themselves? I can remove it if it isn't useful

Thanks,
Jean
