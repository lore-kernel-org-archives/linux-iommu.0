Return-Path: <SRS0=GV0T=MW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7DDC432BE
	for <iommu@archiver.kernel.org>; Fri, 30 Jul 2021 06:12:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3308C61008
	for <iommu@archiver.kernel.org>; Fri, 30 Jul 2021 06:12:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3308C61008
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E4A2583B99;
	Fri, 30 Jul 2021 06:12:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YH5ZGKWNEsTm; Fri, 30 Jul 2021 06:12:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D264E83B96;
	Fri, 30 Jul 2021 06:12:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B066AC001A;
	Fri, 30 Jul 2021 06:12:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B57BDC000E
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 06:12:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A528D83B98
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 06:12:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uLOatKMuR9NI for <iommu@lists.linux-foundation.org>;
 Fri, 30 Jul 2021 06:12:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ADCD383B96
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 06:12:49 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10060"; a="193316837"
X-IronPort-AV: E=Sophos;i="5.84,281,1620716400"; d="scan'208";a="193316837"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2021 23:12:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,281,1620716400"; d="scan'208";a="465345165"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 29 Jul 2021 23:12:46 -0700
Subject: Re: [PATCH v2 19/24] iommu: Expose DMA domain strictness via sysfs
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org
References: <cover.1627468308.git.robin.murphy@arm.com>
 <dd26592103c7613ef9fdff703d0d2ed2df8305c2.1627468310.git.robin.murphy@arm.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <c9093f55-a88f-d8d7-95e2-8350db3741df@linux.intel.com>
Date: Fri, 30 Jul 2021 14:10:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <dd26592103c7613ef9fdff703d0d2ed2df8305c2.1627468310.git.robin.murphy@arm.com>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, dianders@chromium.org,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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

On 7/28/21 11:58 PM, Robin Murphy wrote:
> The sysfs interface for default domain types exists primarily so users
> can choose the performance/security tradeoff relevant to their own
> workload. As such, the choice between the policies for DMA domains fits
> perfectly as an additional point on that scale - downgrading a
> particular device from a strict default to non-strict may be enough to
> let it reach the desired level of performance, while still retaining
> more peace of mind than with a wide-open identity domain. Now that we've
> abstracted non-strict mode as a distinct type of DMA domain, allow it to
> be chosen through the user interface as well.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   Documentation/ABI/testing/sysfs-kernel-iommu_groups | 2 ++
>   drivers/iommu/iommu.c                               | 2 ++
>   2 files changed, 4 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-kernel-iommu_groups b/Documentation/ABI/testing/sysfs-kernel-iommu_groups
> index eae2f1c1e11e..43ba764ba5b7 100644
> --- a/Documentation/ABI/testing/sysfs-kernel-iommu_groups
> +++ b/Documentation/ABI/testing/sysfs-kernel-iommu_groups
> @@ -42,6 +42,8 @@ Description:	/sys/kernel/iommu_groups/<grp_id>/type shows the type of default
>   		========  ======================================================
>   		DMA       All the DMA transactions from the device in this group
>   		          are translated by the iommu.
> +		DMA-FQ    As above, but using batched invalidation to lazily
> +		          remove translations after use.
>   		identity  All the DMA transactions from the device in this group
>   		          are not translated by the iommu.
>   		auto      Change to the type the device was booted with.
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index eecb5657de69..5a08e0806cbb 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -3265,6 +3265,8 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
>   		req_type = IOMMU_DOMAIN_IDENTITY;
>   	else if (sysfs_streq(buf, "DMA"))
>   		req_type = IOMMU_DOMAIN_DMA;
> +	else if (sysfs_streq(buf, "DMA-FQ"))
> +		req_type = IOMMU_DOMAIN_DMA_FQ;
>   	else if (sysfs_streq(buf, "auto"))
>   		req_type = 0;
>   	else
> 


Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
