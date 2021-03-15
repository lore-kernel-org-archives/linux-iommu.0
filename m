Return-Path: <SRS0=3mOG=IN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CEEC433E0
	for <iommu@archiver.kernel.org>; Mon, 15 Mar 2021 00:39:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98E0E64E6B
	for <iommu@archiver.kernel.org>; Mon, 15 Mar 2021 00:39:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98E0E64E6B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 59B9F4018C;
	Mon, 15 Mar 2021 00:39:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2SKwCPUz9R1h; Mon, 15 Mar 2021 00:39:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4EC5540179;
	Mon, 15 Mar 2021 00:39:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2AE27C000B;
	Mon, 15 Mar 2021 00:39:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27282C0001
 for <iommu@lists.linux-foundation.org>; Mon, 15 Mar 2021 00:39:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0ECCA82B51
 for <iommu@lists.linux-foundation.org>; Mon, 15 Mar 2021 00:39:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oVyhcQ5XMr3P for <iommu@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 00:39:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F034C82B3E
 for <iommu@lists.linux-foundation.org>; Mon, 15 Mar 2021 00:39:34 +0000 (UTC)
IronPort-SDR: 1Dtr4ssHUaVNaYoqs9SziE8GTonI9yBGCOw4co7SGtsfmL8GDdh8iM++SNBFpuJNy7h+dzxPp1
 Kyu+3IpflMxg==
X-IronPort-AV: E=McAfee;i="6000,8403,9923"; a="176150413"
X-IronPort-AV: E=Sophos;i="5.81,249,1610438400"; d="scan'208";a="176150413"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Mar 2021 17:39:30 -0700
IronPort-SDR: vKnhhgjxnJ+IojiaywWi+NrhZHUSIurGvg4QlS6j5JsRBzmRCfdRPZWLcT/YhhWWFGssislb1a
 3m5yEJwx+hDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,249,1610438400"; d="scan'208";a="432516352"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128])
 ([10.239.159.128])
 by fmsmga004.fm.intel.com with ESMTP; 14 Mar 2021 17:39:26 -0700
Subject: Re: [PATCH] iommu/vt-d: Disable SVM when ATS/PRI/PASID are not
 enabled in the device
To: Kyung Min Park <kyung.min.park@intel.com>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20210314201534.918-1-kyung.min.park@intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <2c02519d-d23b-92d6-9638-36632c06d517@linux.intel.com>
Date: Mon, 15 Mar 2021 08:30:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210314201534.918-1-kyung.min.park@intel.com>
Content-Language: en-US
Cc: ravi.v.shankar@intel.com, ashok.raj@intel.com, dwmw2@infradead.org,
 will@kernel.org
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

On 3/15/21 4:15 AM, Kyung Min Park wrote:
> Currently, the Intel VT-d supports Shared Virtual Memory (SVM) only when
> IO page fault is supported. Otherwise, shared memory pages can not be
> swapped out and need to be pinned. The device needs the Address Translation
> Service (ATS), Page Request Interface (PRI) and Process Address Space
> Identifier (PASID) capabilities to be enabled to support IO page fault.
> 
> Disable SVM when ATS, PRI and PASID are not enabled in the device.
> 
> Signed-off-by: Kyung Min Park <kyung.min.park@intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index ee0932307d64..956a02eb40b4 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -5380,6 +5380,9 @@ intel_iommu_dev_enable_feat(struct device *dev, enum iommu_dev_features feat)
>   		if (!info)
>   			return -EINVAL;
>   
> +		if (!info->pasid_enabled || !info->pri_enabled || !info->ats_enabled)
> +			return -EINVAL;
> +
>   		if (info->iommu->flags & VTD_FLAG_SVM_CAPABLE)
>   			return 0;
>   	}
> 

Thanks for the patch.

Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
