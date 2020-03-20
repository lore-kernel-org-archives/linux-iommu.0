Return-Path: <SRS0=tLNU=5F=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4779CC4332E
	for <iommu@archiver.kernel.org>; Fri, 20 Mar 2020 13:49:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1904220722
	for <iommu@archiver.kernel.org>; Fri, 20 Mar 2020 13:49:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1904220722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E5B3B874AA;
	Fri, 20 Mar 2020 13:49:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2a7uxLIQY3PQ; Fri, 20 Mar 2020 13:49:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 611AB87475;
	Fri, 20 Mar 2020 13:49:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59390C089E;
	Fri, 20 Mar 2020 13:49:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D868C07FF
 for <iommu@lists.linux-foundation.org>; Fri, 20 Mar 2020 13:49:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 36A2D87F00
 for <iommu@lists.linux-foundation.org>; Fri, 20 Mar 2020 13:49:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mUARGVEauIRJ for <iommu@lists.linux-foundation.org>;
 Fri, 20 Mar 2020 13:49:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 6E7FA87EF8
 for <iommu@lists.linux-foundation.org>; Fri, 20 Mar 2020 13:49:21 +0000 (UTC)
IronPort-SDR: /HWem8Wh0fwrEd4qC+aMXvroW1dod5XBIHRZEq2Yvfx5mTOVlbvqiEF/6y8KwBkU5hLwEekknB
 Iy2d3+CAfjEA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2020 06:49:20 -0700
IronPort-SDR: sx8ITNZSnTwMSq0Hf11ksubXWWL+gSxYwn3+ZlxE2Xk3nIRX2yipZAer6kDd320RKO3JbYmLJG
 XLeN3VLsdtBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,284,1580803200"; d="scan'208";a="237234433"
Received: from che5-mobl.ccr.corp.intel.com (HELO [10.254.213.15])
 ([10.254.213.15])
 by fmsmga007.fm.intel.com with ESMTP; 20 Mar 2020 06:49:18 -0700
Subject: Re: [PATCH 2/3] iommu/vt-d: Fix mm reference leak
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
References: <1584678751-43169-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1584678751-43169-3-git-send-email-jacob.jun.pan@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <75592c19-309f-2626-68c9-1e74232be28e@linux.intel.com>
Date: Fri, 20 Mar 2020 21:49:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1584678751-43169-3-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
Cc: Raj Ashok <ashok.raj@intel.com>
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

On 2020/3/20 12:32, Jacob Pan wrote:
> Move canonical address check before mmget_not_zero() to avoid mm
> reference leak.
> 
> Fixes: 9d8c3af31607 ("iommu/vt-d: IOMMU Page Request needs to check if
> address is canonical.")
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
>   drivers/iommu/intel-svm.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> index 1483f1845762..56253c59ca10 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -861,14 +861,15 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>   		 * any faults on kernel addresses. */
>   		if (!svm->mm)
>   			goto bad_req;
> -		/* If the mm is already defunct, don't handle faults. */
> -		if (!mmget_not_zero(svm->mm))
> -			goto bad_req;
>   
>   		/* If address is not canonical, return invalid response */
>   		if (!is_canonical_address(address))
>   			goto bad_req;
>   
> +		/* If the mm is already defunct, don't handle faults. */
> +		if (!mmget_not_zero(svm->mm))
> +			goto bad_req;
> +
>   		down_read(&svm->mm->mmap_sem);
>   		vma = find_extend_vma(svm->mm, address);
>   		if (!vma || address < vma->vm_start)
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
