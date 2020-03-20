Return-Path: <SRS0=tLNU=5F=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7817CC4332B
	for <iommu@archiver.kernel.org>; Fri, 20 Mar 2020 13:45:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4794120722
	for <iommu@archiver.kernel.org>; Fri, 20 Mar 2020 13:45:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4794120722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 18EB487858;
	Fri, 20 Mar 2020 13:45:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C15ww2oVFyFM; Fri, 20 Mar 2020 13:45:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id DC10C87852;
	Fri, 20 Mar 2020 13:45:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CDD0CC089E;
	Fri, 20 Mar 2020 13:45:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1D1FC07FF
 for <iommu@lists.linux-foundation.org>; Fri, 20 Mar 2020 13:45:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A95B98748F
 for <iommu@lists.linux-foundation.org>; Fri, 20 Mar 2020 13:45:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TRoOfxXZc4zY for <iommu@lists.linux-foundation.org>;
 Fri, 20 Mar 2020 13:45:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 3463686E07
 for <iommu@lists.linux-foundation.org>; Fri, 20 Mar 2020 13:45:36 +0000 (UTC)
IronPort-SDR: MjDLlLwtGI0rT0a+ew1bWiN+kB3Kb5/4EA/VCPA7NNM0Yx5BIYHH1+hUPtELYHZwKp7CwERJO5
 QJ4VNhzDR5dQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2020 06:45:29 -0700
IronPort-SDR: XWCIulE6yp6+th/bs8uRmyMAA5ISs6gfuFSfB8z5/OVeQIRotVXpkmp9N/LI2idKxn7gzysC3Y
 cJ1GhGhTDDbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,284,1580803200"; d="scan'208";a="237234057"
Received: from che5-mobl.ccr.corp.intel.com (HELO [10.254.213.15])
 ([10.254.213.15])
 by fmsmga007.fm.intel.com with ESMTP; 20 Mar 2020 06:45:27 -0700
Subject: Re: [PATCH 1/3] iommu/vt-d: Remove redundant IOTLB flush
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
References: <1584678751-43169-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1584678751-43169-2-git-send-email-jacob.jun.pan@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <26ab1917-f087-aafa-e861-6a2478000a6f@linux.intel.com>
Date: Fri, 20 Mar 2020 21:45:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1584678751-43169-2-git-send-email-jacob.jun.pan@linux.intel.com>
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
> IOTLB flush already included in the PASID tear down process. There
> is no need to flush again.

It seems that intel_pasid_tear_down_entry() doesn't flush the pasid
based device TLB?

Best regards,
baolu

> 
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>   drivers/iommu/intel-svm.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> index 8f42d717d8d7..1483f1845762 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -268,10 +268,9 @@ static void intel_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
>   	 * *has* to handle gracefully without affecting other processes.
>   	 */
>   	rcu_read_lock();
> -	list_for_each_entry_rcu(sdev, &svm->devs, list) {
> +	list_for_each_entry_rcu(sdev, &svm->devs, list)
>   		intel_pasid_tear_down_entry(svm->iommu, sdev->dev, svm->pasid);
> -		intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
> -	}
> +
>   	rcu_read_unlock();
>   
>   }
> @@ -731,7 +730,6 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
>   			 * large and has to be physically contiguous. So it's
>   			 * hard to be as defensive as we might like. */
>   			intel_pasid_tear_down_entry(iommu, dev, svm->pasid);
> -			intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
>   			kfree_rcu(sdev, rcu);
>   
>   			if (list_empty(&svm->devs)) {
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
