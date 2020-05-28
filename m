Return-Path: <SRS0=4TkS=7K=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB29C433E1
	for <iommu@archiver.kernel.org>; Thu, 28 May 2020 07:02:14 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FFF020899
	for <iommu@archiver.kernel.org>; Thu, 28 May 2020 07:02:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FFF020899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id BC1E324E91;
	Thu, 28 May 2020 07:02:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tRu63SbsNa6I; Thu, 28 May 2020 07:02:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9325C203D6;
	Thu, 28 May 2020 07:02:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 619B6C07FF;
	Thu, 28 May 2020 07:02:11 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A23A5C016F
 for <iommu@lists.linux-foundation.org>; Thu, 28 May 2020 07:02:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 8C2F42078D
 for <iommu@lists.linux-foundation.org>; Thu, 28 May 2020 07:02:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id txgD6m7dJV3U for <iommu@lists.linux-foundation.org>;
 Thu, 28 May 2020 07:02:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by silver.osuosl.org (Postfix) with ESMTPS id 48712203D6
 for <iommu@lists.linux-foundation.org>; Thu, 28 May 2020 07:02:05 +0000 (UTC)
IronPort-SDR: hbP5XG3+ZCJGM+CXmhl2zsVsjNZFgK2feHOYTiUa7zIrOkJ8NGmcgNzWScGcrIQ23R4UJBL9vY
 euiXjO7nM3kQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2020 00:01:52 -0700
IronPort-SDR: QxMrdvgNvNyuSjUzMPCQZ5expSmieD5eAN8q7YlgMDlyceH3tEl4ICoitZLcUX/cnIdOtUOyoV
 tf2gyWM6Yo3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,443,1583222400"; d="scan'208";a="442845507"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.255.30.232])
 ([10.255.30.232])
 by orsmga005.jf.intel.com with ESMTP; 28 May 2020 00:01:49 -0700
Subject: Re: [PATCH v1 2/3] iommu/vt-d: Allocate domain info for real DMA
 sub-devices
To: Jon Derrick <jonathan.derrick@intel.com>, iommu@lists.linux-foundation.org
References: <20200527165617.297470-1-jonathan.derrick@intel.com>
 <20200527165617.297470-3-jonathan.derrick@intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <fd4b5313-efd0-90bf-5841-80a97ce5f652@linux.intel.com>
Date: Thu, 28 May 2020 15:01:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200527165617.297470-3-jonathan.derrick@intel.com>
Content-Language: en-US
Cc: Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org
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

On 2020/5/28 0:56, Jon Derrick wrote:
> Sub-devices of a real DMA device might exist on a separate segment than
> the real DMA device and its IOMMU. These devices should still have a
> valid device_domain_info, but the current dma alias model won't
> allocate info for the subdevice.
> 
> This patch adds a segment member to struct device_domain_info and uses
> the sub-device's BDF so that these sub-devices won't alias to other
> devices.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>

Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
>   drivers/iommu/intel-iommu.c | 19 +++++++++++++++----
>   include/linux/intel-iommu.h |  1 +
>   2 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 1ff45b2..6d39b9b 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -2463,7 +2463,7 @@ static void do_deferred_attach(struct device *dev)
>   	struct device_domain_info *info;
>   
>   	list_for_each_entry(info, &device_domain_list, global)
> -		if (info->iommu->segment == segment && info->bus == bus &&
> +		if (info->segment == segment && info->bus == bus &&
>   		    info->devfn == devfn)
>   			return info;
>   
> @@ -2520,8 +2520,18 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
>   	if (!info)
>   		return NULL;
>   
> -	info->bus = bus;
> -	info->devfn = devfn;
> +	if (!dev_is_real_dma_subdevice(dev)) {
> +		info->bus = bus;
> +		info->devfn = devfn;
> +		info->segment = iommu->segment;
> +	} else {
> +		struct pci_dev *pdev = to_pci_dev(dev);
> +
> +		info->bus = pdev->bus->number;
> +		info->devfn = pdev->devfn;
> +		info->segment = pci_domain_nr(pdev->bus);
> +	}
> +
>   	info->ats_supported = info->pasid_supported = info->pri_supported = 0;
>   	info->ats_enabled = info->pasid_enabled = info->pri_enabled = 0;
>   	info->ats_qdep = 0;
> @@ -2561,7 +2571,8 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
>   
>   	if (!found) {
>   		struct device_domain_info *info2;
> -		info2 = dmar_search_domain_by_dev_info(iommu->segment, bus, devfn);
> +		info2 = dmar_search_domain_by_dev_info(info->segment, info->bus,
> +						       info->devfn);
>   		if (info2) {
>   			found      = info2->domain;
>   			info2->dev = dev;
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 21633ce..4100bd2 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -609,6 +609,7 @@ struct device_domain_info {
>   	struct list_head auxiliary_domains; /* auxiliary domains
>   					     * attached to this device
>   					     */
> +	u32 segment;		/* PCI segment number */
>   	u8 bus;			/* PCI bus number */
>   	u8 devfn;		/* PCI devfn number */
>   	u16 pfsid;		/* SRIOV physical function source ID */
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
