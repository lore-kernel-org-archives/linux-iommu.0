Return-Path: <SRS0=3N47=YS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7047BCA9EAF
	for <iommu@archiver.kernel.org>; Fri, 25 Oct 2019 02:56:36 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AFE321929
	for <iommu@archiver.kernel.org>; Fri, 25 Oct 2019 02:56:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AFE321929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 15791D9D;
	Fri, 25 Oct 2019 02:56:26 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7180ED99
	for <iommu@lists.linux-foundation.org>;
	Fri, 25 Oct 2019 02:56:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 150C2896
	for <iommu@lists.linux-foundation.org>;
	Fri, 25 Oct 2019 02:56:24 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
	by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	24 Oct 2019 19:56:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,227,1569308400"; d="scan'208";a="197908623"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
	([10.239.159.136])
	by fmsmga007.fm.intel.com with ESMTP; 24 Oct 2019 19:56:22 -0700
Subject: Re: [PATCH v7 01/11] iommu/vt-d: Cache virtual command capability
	register
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
	iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Alex Williamson <alex.williamson@redhat.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.com>
References: <1571946904-86776-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1571946904-86776-2-git-send-email-jacob.jun.pan@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <6d141036-2160-45de-754f-9b146dac541e@linux.intel.com>
Date: Fri, 25 Oct 2019 10:53:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1571946904-86776-2-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
	Jonathan Cameron <jic23@kernel.org>
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

On 10/25/19 3:54 AM, Jacob Pan wrote:
> Virtual command registers are used in the guest only, to prevent
> vmexit cost, we cache the capability and store it during initialization.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

This patch looks good to me.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
>   drivers/iommu/dmar.c        | 1 +
>   include/linux/intel-iommu.h | 4 ++++
>   2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
> index eecd6a421667..49bb7d76e646 100644
> --- a/drivers/iommu/dmar.c
> +++ b/drivers/iommu/dmar.c
> @@ -950,6 +950,7 @@ static int map_iommu(struct intel_iommu *iommu, u64 phys_addr)
>   		warn_invalid_dmar(phys_addr, " returns all ones");
>   		goto unmap;
>   	}
> +	iommu->vccap = dmar_readq(iommu->reg + DMAR_VCCAP_REG);
>   
>   	/* the registers might be more than one page */
>   	map_size = max_t(int, ecap_max_iotlb_offset(iommu->ecap),
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index ed11ef594378..2e1bed9b7eef 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -186,6 +186,9 @@
>   #define ecap_max_handle_mask(e) ((e >> 20) & 0xf)
>   #define ecap_sc_support(e)	((e >> 7) & 0x1) /* Snooping Control */
>   
> +/* Virtual command interface capabilities */
> +#define vccap_pasid(v)		((v & DMA_VCS_PAS)) /* PASID allocation */
> +
>   /* IOTLB_REG */
>   #define DMA_TLB_FLUSH_GRANU_OFFSET  60
>   #define DMA_TLB_GLOBAL_FLUSH (((u64)1) << 60)
> @@ -520,6 +523,7 @@ struct intel_iommu {
>   	u64		reg_size; /* size of hw register set */
>   	u64		cap;
>   	u64		ecap;
> +	u64		vccap;
>   	u32		gcmd; /* Holds TE, EAFL. Don't need SRTP, SFL, WBF */
>   	raw_spinlock_t	register_lock; /* protect register handling */
>   	int		seq_id;	/* sequence id of the iommu */
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
