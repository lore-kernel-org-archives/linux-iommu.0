Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28976C433F5
	for <iommu@archiver.kernel.org>; Fri, 18 Feb 2022 02:55:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B016560B10;
	Fri, 18 Feb 2022 02:55:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tQ95HpANr1BN; Fri, 18 Feb 2022 02:55:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3DAF860AFB;
	Fri, 18 Feb 2022 02:55:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ED0C7C0011;
	Fri, 18 Feb 2022 02:55:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 09F22C000B
 for <iommu@lists.linux-foundation.org>; Fri, 18 Feb 2022 02:55:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DDBA5416E7
 for <iommu@lists.linux-foundation.org>; Fri, 18 Feb 2022 02:55:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RrEv32M7Vd_I for <iommu@lists.linux-foundation.org>;
 Fri, 18 Feb 2022 02:55:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 10617416CD
 for <iommu@lists.linux-foundation.org>; Fri, 18 Feb 2022 02:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1645152950; x=1676688950;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=8tbuvYh0eK0b0TFW+yWYPs3qXHRE9DlvaagIPNoX7vY=;
 b=R3RowHcnOPvb73x559xgD7ePMa7bg1sNEgYRJtOoVaK2VhJ8Q/8SFnsa
 SA8AaGS14+ZgLJ9oozledhQSDChON4h6duhsY8XwmPLzbPm2iEZQ11+s7
 ss/MXzQzJKtXISkZa/PWva0RvLLlOtFCmeoSt6uS0X/TB622XCXj19kdF
 fXljflFLwIqs2CaOclhGXsRDLVZa6/eFSfmBw6fuz5c+bj8OjU24Qiaxv
 6sU1BnJmPpH/AZsc06pAHIMjkO9TFcsyyddf8UdkGhwz3QHHgoJt4pfEh
 dpVt8rrYnmmjB+AiEIZSZvE0g9ghvG+WP2LPNCoLfn4oZrDnRXVcgxaDR w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="250981674"
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; d="scan'208";a="250981674"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2022 18:55:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; d="scan'208";a="682316036"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 17 Feb 2022 18:55:21 -0800
Message-ID: <60d395f4-6103-94fe-9b05-daeaf0b00adb@linux.intel.com>
Date: Fri, 18 Feb 2022 10:53:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] iommu/vt-d: Enable ATS for the devices in SATC table
Content-Language: en-US
To: Yian Chen <yian.chen@intel.com>, David Woodhouse <dwmw2@infradead.org>,
 Ashok Raj <ashok.raj@intel.com>, Sohil Mehta <sohil.mehta@intel.com>,
 Jacob jun Pan <jacob.jun.pan@intel.com>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
References: <20220216193609.686107-1-yian.chen@intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220216193609.686107-1-yian.chen@intel.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Yian,

On 2/17/22 3:36 AM, Yian Chen wrote:
> Starting from Intel VT-d v3.2, Intel platform BIOS can provide
> additional SATC table structure. SATC table includes a list of
> SoC integrated devices that support ATC (Address translation
> cache).
> 
> Enabling ATC (via ATS capability) can be a functional requirement
> for SATC device operation or an optional to enhance device
> performance/functionality. This is determined by the bit of
> ATC_REQUIRED in SATC table. When IOMMU is working in scalable
> mode, software chooses to always enable ATS for every device in
> SATC table because Intel SoC devices in SATC table are trusted
> to use ATS.
> 
> On the other hand, if IOMMU is in legacy mode, ATS of SATC
> capable devices can work transparently to software and be
> automatically enabled by IOMMU hardware. As the result,
> there is no need for software to enable ATS on these devices.
> 
> Signed-off-by: Yian Chen <yian.chen@intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 53 ++++++++++++++++++++++++++++++++++---
>   include/linux/intel-iommu.h |  2 +-
>   2 files changed, 51 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 92fea3fbbb11..58a80cec50bb 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -872,7 +872,6 @@ static bool iommu_is_dummy(struct intel_iommu *iommu, struct device *dev)
>   
>   	return false;
>   }
> -

Unnecessary.

>   struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devfn)
>   {
>   	struct dmar_drhd_unit *drhd = NULL;
> @@ -2684,7 +2683,7 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
>   
>   		if (ecap_dev_iotlb_support(iommu->ecap) &&
>   		    pci_ats_supported(pdev) &&
> -		    dmar_find_matched_atsr_unit(pdev))
> +		    dmar_ats_supported(pdev, iommu))
>   			info->ats_supported = 1;
>   
>   		if (sm_supported(iommu)) {
> @@ -4020,7 +4019,42 @@ static void intel_iommu_free_dmars(void)
>   	}
>   }
>   
> -int dmar_find_matched_atsr_unit(struct pci_dev *dev)
> +/* dev_satc_state - Find if dev is in a DMAR SATC table
> + *
> + * return value:
> + *    1: dev is in STAC table and ATS is required
> + *    0: dev is in SATC table and ATS is optional
> + *    -1: dev isn't in SATC table
> + */

Judging the status of the device in table according to the hard coded
return value will make the code hard to read. How about using two
helpers with meaningful names, for example,

bool dmar_find_matched_satc_unit()
bool dmar_ats_required_in_satc()?

> +static int dev_satc_state(struct pci_dev *dev)
> +{
> +	int i, ret = -1;
> +	struct device *tmp;
> +	struct dmar_satc_unit *satcu;
> +	struct acpi_dmar_satc *satc;
> +
> +	dev = pci_physfn(dev);
> +	rcu_read_lock();
> +
> +	list_for_each_entry_rcu(satcu, &dmar_satc_units, list) {
> +		satc = container_of(satcu->hdr, struct acpi_dmar_satc, header);
> +		if (satc->segment != pci_domain_nr(dev->bus))
> +			continue;
> +		for_each_dev_scope(satcu->devices, satcu->devices_cnt, i, tmp)
> +			if (to_pci_dev(tmp) == dev) {
> +				if (satc->flags)

Do you need to check the ATC_REQUIRED bit field?

> +					ret = 1;
> +				else
> +					ret = 0;
> +				goto out;
> +			}
> +	}
> +out:
> +	rcu_read_unlock();
> +	return ret;
> +}
> +
> +int dmar_ats_supported(struct pci_dev *dev, struct intel_iommu *iommu)
>   {
>   	int i, ret = 1;
>   	struct pci_bus *bus;
> @@ -4030,6 +4064,19 @@ int dmar_find_matched_atsr_unit(struct pci_dev *dev)
>   	struct dmar_atsr_unit *atsru;
>   
>   	dev = pci_physfn(dev);
> +	i = dev_satc_state(dev);
> +	if (i >= 0) {
> +		/* This dev supports ATS as it is in SATC table!
> +		 * When IOMMU is in legacy mode, enabling ATS is done
> +		 * automatically by HW for the device that requires
> +		 * ATS, hence OS should not enable this device ATS
> +		 * to avoid duplicated TLB invalidation
> +		 */
> +		if (i && !sm_supported(iommu))
> +			ret = 0;
> +		return ret;
> +	}
> +
>   	for (bus = dev->bus; bus; bus = bus->parent) {
>   		bridge = bus->self;
>   		/* If it's an integrated device, allow ATS */
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 69230fd695ea..fe9fd417d611 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -717,7 +717,7 @@ static inline int nr_pte_to_next_page(struct dma_pte *pte)
>   }
>   
>   extern struct dmar_drhd_unit * dmar_find_matched_drhd_unit(struct pci_dev *dev);
> -extern int dmar_find_matched_atsr_unit(struct pci_dev *dev);
> +extern int dmar_ats_supported(struct pci_dev *dev, struct intel_iommu *iommu);

The dmar_find_matched_atsr_unit() is not used out of iommu.c. Can you
please make a patch to change it to a static one?

>   
>   extern int dmar_enable_qi(struct intel_iommu *iommu);
>   extern void dmar_disable_qi(struct intel_iommu *iommu);

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
