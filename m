Return-Path: <SRS0=xT8t=45=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B689C0044D
	for <iommu@archiver.kernel.org>; Thu, 12 Mar 2020 01:44:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F90320739
	for <iommu@archiver.kernel.org>; Thu, 12 Mar 2020 01:44:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F90320739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0B42888747;
	Thu, 12 Mar 2020 01:44:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nv0aQg393gt5; Thu, 12 Mar 2020 01:44:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 725D387BFF;
	Thu, 12 Mar 2020 01:44:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 593BFC07FF;
	Thu, 12 Mar 2020 01:44:28 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46579C0177
 for <iommu@lists.linux-foundation.org>; Thu, 12 Mar 2020 01:44:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 307D188E60
 for <iommu@lists.linux-foundation.org>; Thu, 12 Mar 2020 01:44:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7Lt1vW7cW7IS for <iommu@lists.linux-foundation.org>;
 Thu, 12 Mar 2020 01:44:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 5E38088E52
 for <iommu@lists.linux-foundation.org>; Thu, 12 Mar 2020 01:44:25 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Mar 2020 18:44:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,543,1574150400"; d="scan'208";a="443763768"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.208.137])
 ([10.254.208.137])
 by fmsmga006.fm.intel.com with ESMTP; 11 Mar 2020 18:44:18 -0700
Subject: Re: [PATCH v2 08/11] iommu/vt-d: Use pci_ats_supported()
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, bhelgaas@google.com,
 will@kernel.org, robh+dt@kernel.org, joro@8bytes.org, sudeep.holla@arm.com,
 linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org
References: <20200311124506.208376-1-jean-philippe@linaro.org>
 <20200311124506.208376-9-jean-philippe@linaro.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <7019230c-3c56-e6db-6704-d73f23fa39b5@linux.intel.com>
Date: Thu, 12 Mar 2020 09:44:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200311124506.208376-9-jean-philippe@linaro.org>
Content-Language: en-US
Cc: mark.rutland@arm.com, frowand.list@gmail.com, corbet@lwn.net,
 rjw@rjwysocki.net, amurray@thegoodpenguin.co.uk, liviu.dudau@arm.com,
 guohanjun@huawei.com, lenb@kernel.org, robin.murphy@arm.com,
 dwmw2@infradead.org
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

Hi Jean,

On 2020/3/11 20:45, Jean-Philippe Brucker wrote:
> The pci_ats_supported() function checks if a device supports ATS and is
> allowed to use it.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>   drivers/iommu/intel-iommu.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 6fa6de2b6ad5..17208280ef5c 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -1454,8 +1454,7 @@ static void iommu_enable_dev_iotlb(struct device_domain_info *info)
>   	    !pci_reset_pri(pdev) && !pci_enable_pri(pdev, 32))
>   		info->pri_enabled = 1;
>   #endif
> -	if (!pdev->untrusted && info->ats_supported &&
> -	    pci_ats_page_aligned(pdev) &&
> +	if (info->ats_supported && pci_ats_page_aligned(pdev) &&
>   	    !pci_enable_ats(pdev, VTD_PAGE_SHIFT)) {
>   		info->ats_enabled = 1;
>   		domain_update_iotlb(info->domain);
> @@ -2611,10 +2610,8 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
>   	if (dev && dev_is_pci(dev)) {
>   		struct pci_dev *pdev = to_pci_dev(info->dev);
>   
> -		if (!pdev->untrusted &&
> -		    !pci_ats_disabled() &&

The pci_ats_disabled() couldn't be replaced by pci_ats_supported(). Even
pci_ats_supported() returns true, user still can disable it. Or move
ats_disabled into pci_ats_supported()?

Best regards,
baolu

> -		    ecap_dev_iotlb_support(iommu->ecap) &&
> -		    pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ATS) &&
> +		if (ecap_dev_iotlb_support(iommu->ecap) &&
> +		    pci_ats_supported(pdev) &&
>   		    dmar_find_matched_atsr_unit(pdev))
>   			info->ats_supported = 1;
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
