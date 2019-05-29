Return-Path: <SRS0=Uk+I=T5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5129CC04E84
	for <iommu@archiver.kernel.org>; Wed, 29 May 2019 02:43:42 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31DE421019
	for <iommu@archiver.kernel.org>; Wed, 29 May 2019 02:43:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31DE421019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id F141223D9;
	Wed, 29 May 2019 02:43:41 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 1273C23D0
	for <iommu@lists.linux-foundation.org>;
	Wed, 29 May 2019 02:41:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 6A84E619
	for <iommu@lists.linux-foundation.org>;
	Wed, 29 May 2019 02:41:01 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	28 May 2019 19:40:59 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
	([10.239.159.136])
	by orsmga004.jf.intel.com with ESMTP; 28 May 2019 19:40:57 -0700
Subject: Re: [PATCH v5 7/7] iommu/vt-d: Differentiate relaxable and non
	relaxable RMRRs
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
	joro@8bytes.org, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, dwmw2@infradead.org, robin.murphy@arm.com
References: <20190528115025.17194-1-eric.auger@redhat.com>
	<20190528115025.17194-8-eric.auger@redhat.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <13a77738-5e85-ea62-aab1-384c75bde8bd@linux.intel.com>
Date: Wed, 29 May 2019 10:34:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190528115025.17194-8-eric.auger@redhat.com>
Content-Language: en-US
Cc: jean-philippe.brucker@arm.com, alex.williamson@redhat.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Development issues for Linux IOMMU support
	<iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi,

On 5/28/19 7:50 PM, Eric Auger wrote:
> Now we have a new IOMMU_RESV_DIRECT_RELAXABLE reserved memory
> region type, let's report USB and GFX RMRRs as relaxable ones.
> 
> We introduce a new device_rmrr_is_relaxable() helper to check
> whether the rmrr belongs to the relaxable category.
> 
> This allows to have a finer reporting at IOMMU API level of
> reserved memory regions. This will be exploitable by VFIO to
> define the usable IOVA range and detect potential conflicts
> between the guest physical address space and host reserved
> regions.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> v3 -> v4:
> - introduce device_rmrr_is_relaxable and reshuffle the comments
> ---
>   drivers/iommu/intel-iommu.c | 55 +++++++++++++++++++++++++++----------
>   1 file changed, 40 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 9302351818ab..01c82f848470 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -2920,6 +2920,36 @@ static bool device_has_rmrr(struct device *dev)
>   	return false;
>   }
>   
> +/*
> + * device_rmrr_is_relaxable - Test whether the RMRR of this device
> + * is relaxable (ie. is allowed to be not enforced under some conditions)
> + *
> + * @dev: device handle
> + *
> + * We assume that PCI USB devices with RMRRs have them largely
> + * for historical reasons and that the RMRR space is not actively used post
> + * boot.  This exclusion may change if vendors begin to abuse it.
> + *
> + * The same exception is made for graphics devices, with the requirement that
> + * any use of the RMRR regions will be torn down before assigning the device
> + * to a guest.
> + *
> + * Return: true if the RMRR is relaxable
> + */
> +static bool device_rmrr_is_relaxable(struct device *dev)
> +{
> +	struct pci_dev *pdev;
> +
> +	if (!dev_is_pci(dev))
> +		return false;
> +
> +	pdev = to_pci_dev(dev);
> +	if (IS_USB_DEVICE(pdev) || IS_GFX_DEVICE(pdev))
> +		return true;
> +	else
> +		return false;
> +}

I know this is only code refactoring. But strictly speaking, the rmrr of
any USB host device is ignorable only if quirk_usb_early_handoff() has
been called. There, the control of USB host controller will be handed
over from BIOS to OS and the corresponding SMI are disabled.

This function is registered in drivers/usb/host/pci-quirks.c

DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_ANY_ID, PCI_ANY_ID,
                         PCI_CLASS_SERIAL_USB, 8, quirk_usb_early_handoff);

and only get compiled if CONFIG_USB_PCI is enabled.

Hence, it's safer to say:

+#ifdef CONFIG_USB_PCI
+	if (IS_USB_DEVICE(pdev))
+		return true;
+#endif /* CONFIG_USB_PCI */

I am okay if we keep this untouched and make this change within a
separated patch.

> +
>   /*
>    * There are a couple cases where we need to restrict the functionality of
>    * devices associated with RMRRs.  The first is when evaluating a device for
> @@ -2934,25 +2964,16 @@ static bool device_has_rmrr(struct device *dev)
>    * We therefore prevent devices associated with an RMRR from participating in
>    * the IOMMU API, which eliminates them from device assignment.
>    *
> - * In both cases we assume that PCI USB devices with RMRRs have them largely
> - * for historical reasons and that the RMRR space is not actively used post
> - * boot.  This exclusion may change if vendors begin to abuse it.
> - *
> - * The same exception is made for graphics devices, with the requirement that
> - * any use of the RMRR regions will be torn down before assigning the device
> - * to a guest.
> + * In both cases, devices which have relaxable RMRRs are not concerned by this
> + * restriction. See device_rmrr_is_relaxable comment.
>    */
>   static bool device_is_rmrr_locked(struct device *dev)
>   {
>   	if (!device_has_rmrr(dev))
>   		return false;
>   
> -	if (dev_is_pci(dev)) {
> -		struct pci_dev *pdev = to_pci_dev(dev);
> -
> -		if (IS_USB_DEVICE(pdev) || IS_GFX_DEVICE(pdev))
> -			return false;
> -	}
> +	if (device_rmrr_is_relaxable(dev))
> +		return false;
>   
>   	return true;
>   }
> @@ -5494,6 +5515,7 @@ static void intel_iommu_get_resv_regions(struct device *device,
>   		for_each_active_dev_scope(rmrr->devices, rmrr->devices_cnt,
>   					  i, i_dev) {
>   			struct iommu_resv_region *resv;
> +			enum iommu_resv_type type;
>   			size_t length;
>   
>   			if (i_dev != device &&
> @@ -5501,9 +5523,12 @@ static void intel_iommu_get_resv_regions(struct device *device,
>   				continue;
>   
>   			length = rmrr->end_address - rmrr->base_address + 1;
> +
> +			type = device_rmrr_is_relaxable(device) ?
> +				IOMMU_RESV_DIRECT_RELAXABLE : IOMMU_RESV_DIRECT;
> +
>   			resv = iommu_alloc_resv_region(rmrr->base_address,
> -						       length, prot,
> -						       IOMMU_RESV_DIRECT);
> +						       length, prot, type);
>   			if (!resv)
>   				break;
>   
> 

Other looks good to me.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
Baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
