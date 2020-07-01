Return-Path: <SRS0=cxdO=AM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11ABC433DF
	for <iommu@archiver.kernel.org>; Wed,  1 Jul 2020 01:13:24 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D6A420771
	for <iommu@archiver.kernel.org>; Wed,  1 Jul 2020 01:13:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D6A420771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 5FA7123100;
	Wed,  1 Jul 2020 01:13:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aMBTO8UEZQI6; Wed,  1 Jul 2020 01:13:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 3706F2043D;
	Wed,  1 Jul 2020 01:13:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1B655C0865;
	Wed,  1 Jul 2020 01:13:22 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 45360C016E
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 01:13:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 26E9123100
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 01:13:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vQR1RA2rw3Kz for <iommu@lists.linux-foundation.org>;
 Wed,  1 Jul 2020 01:13:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by silver.osuosl.org (Postfix) with ESMTPS id 4BA8C2043D
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 01:13:19 +0000 (UTC)
IronPort-SDR: jdMmUrt+4hiT1mMj43vkxS1hQ/Ntb/B/j+/uI2mcb4lWt+PR5Q2U6IS527J4eCe9RQAKhhaNSL
 6YuZW9S+JuOw==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="134722511"
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; d="scan'208";a="134722511"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2020 18:13:18 -0700
IronPort-SDR: VYutfgbgIMZ4TlUzjptdoaJK09UCLU0LpY58EUhXvHnExS3Abyc/b6W5GdCU77qEG0dhRCk1VD
 uZSl05yHkGJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; d="scan'208";a="265263416"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by fmsmga007.fm.intel.com with ESMTP; 30 Jun 2020 18:13:15 -0700
Subject: Re: [PATCH v2 4/7] iommu/vt-d: Handle non-page aligned address
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
References: <1593551258-39854-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1593551258-39854-5-git-send-email-jacob.jun.pan@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <5543656c-9b38-5fe6-7372-9a61a1269b5d@linux.intel.com>
Date: Wed, 1 Jul 2020 09:08:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1593551258-39854-5-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>
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

On 7/1/20 5:07 AM, Jacob Pan wrote:
> From: Liu Yi L <yi.l.liu@intel.com>
> 
> Address information for device TLB invalidation comes from userspace
> when device is directly assigned to a guest with vIOMMU support.
> VT-d requires page aligned address. This patch checks and enforce
> address to be page aligned, otherwise reserved bits can be set in the
> invalidation descriptor. Unrecoverable fault will be reported due to
> non-zero value in the reserved bits.
> 
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Fixes: 61a06a16e36d8 ("iommu/vt-d: Support flushing more translation 
cache types")
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
>   drivers/iommu/intel/dmar.c | 20 ++++++++++++++++++--
>   1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index d9f973fa1190..3899f3161071 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -1455,9 +1455,25 @@ void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid, u16 pfsid,
>   	 * Max Invs Pending (MIP) is set to 0 for now until we have DIT in
>   	 * ECAP.
>   	 */
> -	desc.qw1 |= addr & ~mask;
> -	if (size_order)
> +	if (addr & ~VTD_PAGE_MASK)
> +		pr_warn_ratelimited("Invalidate non-page aligned address %llx\n", addr);
> +
> +	/* Take page address */
> +	desc.qw1 |= QI_DEV_EIOTLB_ADDR(addr);
> +
> +	if (size_order) {
> +		/*
> +		 * Existing 0s in address below size_order may be the least
> +		 * significant bit, we must set them to 1s to avoid having
> +		 * smaller size than desired.
> +		 */
> +		desc.qw1 |= GENMASK_ULL(size_order + VTD_PAGE_SHIFT,
> +					VTD_PAGE_SHIFT);
> +		/* Clear size_order bit to indicate size */
> +		desc.qw1 &= ~mask;
> +		/* Set the S bit to indicate flushing more than 1 page */
>   		desc.qw1 |= QI_DEV_EIOTLB_SIZE;
> +	}
>   
>   	qi_submit_sync(iommu, &desc, 1, 0);
>   }
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
