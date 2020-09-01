Return-Path: <SRS0=Ln9J=CK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514C4C433E7
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 03:14:04 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 201CC20719
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 03:14:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 201CC20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A27731FEB7;
	Tue,  1 Sep 2020 03:14:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JdA1NvZRS+Q0; Tue,  1 Sep 2020 03:14:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id AB2C31FD16;
	Tue,  1 Sep 2020 03:14:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8FE57C088B;
	Tue,  1 Sep 2020 03:14:02 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73A48C0052
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 03:14:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 68CFF1FEB7
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 03:14:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zIymBRK4xFx3 for <iommu@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 03:14:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by silver.osuosl.org (Postfix) with ESMTPS id 534EA1FD16
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 03:14:00 +0000 (UTC)
IronPort-SDR: Nmu8r3YXLmKXLjRjFKresYuRkU3nY21r3RbIlF0WT6aV3d8m/pRYEWcZzO8SwXZAkIyUsFVMU8
 ZE9ajHOt/DCA==
X-IronPort-AV: E=McAfee;i="6000,8403,9730"; a="144842130"
X-IronPort-AV: E=Sophos;i="5.76,377,1592895600"; d="scan'208";a="144842130"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2020 20:13:59 -0700
IronPort-SDR: rKZzeqLAQU40eajfXweGsHc/Gy3SPbdgFm4ssYm5zaESBdwwQ0ic4RbbpCcP6cTvv/TxWfc9zr
 LBKx2j1b4dBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,377,1592895600"; d="scan'208";a="325174443"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by fmsmga004.fm.intel.com with ESMTP; 31 Aug 2020 20:13:55 -0700
Subject: Re: [PATCH v8 7/7] iommu/vt-d: Check UAPI data processed by IOMMU core
To: Jacob Pan <jacob.pan.linux@gmail.com>, iommu@lists.linux-foundation.org,
 LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>
References: <1598898300-65475-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1598898300-65475-8-git-send-email-jacob.jun.pan@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <2b4ee3f0-d0df-9802-14e6-984a790834af@linux.intel.com>
Date: Tue, 1 Sep 2020 11:08:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1598898300-65475-8-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Christoph Hellwig <hch@infradead.org>, David Woodhouse <dwmw2@infradead.org>
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

Hi Jacob,

On 9/1/20 2:25 AM, Jacob Pan wrote:
> IOMMU generic layer already does sanity checks on UAPI data for version
> match and argsz range based on generic information.
> 
> This patch adjusts the following data checking responsibilities:
> - removes the redundant version check from VT-d driver
> - removes the check for vendor specific data size
> - adds check for the use of reserved/undefined flags
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>   drivers/iommu/intel/iommu.c |  3 +--
>   drivers/iommu/intel/svm.c   | 11 +++++++++--
>   include/uapi/linux/iommu.h  |  1 +
>   3 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 43f16f0cebde..a3a0b5c8921d 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -5399,8 +5399,7 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
>   	int ret = 0;
>   	u64 size = 0;
>   
> -	if (!inv_info || !dmar_domain ||
> -	    inv_info->version != IOMMU_CACHE_INVALIDATE_INFO_VERSION_1)
> +	if (!inv_info || !dmar_domain)
>   		return -EINVAL;
>   
>   	if (!dev || !dev_is_pci(dev))
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index 99353d6468fa..0cb9a15f1112 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -284,8 +284,15 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
>   	if (WARN_ON(!iommu) || !data)
>   		return -EINVAL;
>   
> -	if (data->version != IOMMU_GPASID_BIND_VERSION_1 ||
> -	    data->format != IOMMU_PASID_FORMAT_INTEL_VTD)
> +	if (data->format != IOMMU_PASID_FORMAT_INTEL_VTD)
> +		return -EINVAL;
> +
> +	/* IOMMU core ensures argsz is more than the start of the union */
> +	if (data->argsz < offsetofend(struct iommu_gpasid_bind_data, vendor.vtd))
> +		return -EINVAL;
> +
> +	/* Make sure no undefined flags are used in vendor data */
> +	if (data->vendor.vtd.flags & ~(IOMMU_SVA_VTD_GPASID_LAST - 1))
>   		return -EINVAL;
>   
>   	if (!dev_is_pci(dev))
> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> index c64bca5af419..1ebc23df4fbc 100644
> --- a/include/uapi/linux/iommu.h
> +++ b/include/uapi/linux/iommu.h
> @@ -288,6 +288,7 @@ struct iommu_gpasid_bind_data_vtd {
>   #define IOMMU_SVA_VTD_GPASID_PWT	(1 << 3) /* page-level write through */
>   #define IOMMU_SVA_VTD_GPASID_EMTE	(1 << 4) /* extended mem type enable */
>   #define IOMMU_SVA_VTD_GPASID_CD		(1 << 5) /* PASID-level cache disable */
> +#define IOMMU_SVA_VTD_GPASID_LAST	(1 << 6)
>   	__u64 flags;
>   	__u32 pat;
>   	__u32 emt;
> 

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
