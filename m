Return-Path: <SRS0=cSHS=77=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3858C433E0
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 01:57:05 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7DB821924
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 01:57:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7DB821924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 87B348741F;
	Thu, 18 Jun 2020 01:57:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u7IZ0hG7BmL1; Thu, 18 Jun 2020 01:57:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CCBE7873E7;
	Thu, 18 Jun 2020 01:57:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B8B76C07FF;
	Thu, 18 Jun 2020 01:57:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5EA2EC016E
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 01:57:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 46C9C883B8
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 01:57:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C1AdGPrqSgAL for <iommu@lists.linux-foundation.org>;
 Thu, 18 Jun 2020 01:57:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 4F47C88390
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 01:57:01 +0000 (UTC)
IronPort-SDR: /R1tVHzzWg2EDb0+ik79jPi3sKUXxkvkAklMR4czClYseSlKeLjQ0cO3J6pSf4LBzkUH3t1JR9
 GNW8Ry19MVcw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2020 18:57:00 -0700
IronPort-SDR: dOpFRBMkm9tZhetjrah4RZrdbrBrTQ1DENH+RqmmXVZMNECe8uXb9mIAE2qN+jizYMbeNJ/pzy
 eF0FnERsZUXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,524,1583222400"; d="scan'208";a="299500534"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by fmsmga004.fm.intel.com with ESMTP; 17 Jun 2020 18:56:58 -0700
Subject: Re: [Regression] Re: [PATCH 18/18] iommu/vt-d: Remove IOVA handling
 code from the non-dma_ops path
To: Alex Williamson <alex.williamson@redhat.com>
References: <20200516062101.29541-1-baolu.lu@linux.intel.com>
 <20200516062101.29541-19-baolu.lu@linux.intel.com>
 <20200617140639.7ed58926@x1.home>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <4548c140-c0db-8e17-d3a7-7dfc5f5ca576@linux.intel.com>
Date: Thu, 18 Jun 2020 09:52:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200617140639.7ed58926@x1.home>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, Tom Murphy <murphyt7@tcd.ie>
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

Hi Alex,

Thanks for the report.

On 6/18/20 4:06 AM, Alex Williamson wrote:
> On Sat, 16 May 2020 14:21:01 +0800
> Lu Baolu<baolu.lu@linux.intel.com>  wrote:
> 
>> From: Tom Murphy<murphyt7@tcd.ie>
>>
>> There's no need for the non-dma_ops path to keep track of IOVAs. The
>> whole point of the non-dma_ops path is that it allows the IOVAs to be
>> handled separately. The IOVA handling code removed in this patch is
>> pointless.
>>
>> Signed-off-by: Tom Murphy<murphyt7@tcd.ie>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel-iommu.c | 95 +++++++++++++------------------------
>>   1 file changed, 32 insertions(+), 63 deletions(-)
> This commit results in a massive increase in memory use from the VT-d
> code.  I have a 16GB system where I reserve 7168 2MB hugespages for VM
> usage (14GB), leaving the host with 2GB.  I can no longer even boot the
> host in this configuration.  Bisecting to this commit, I find that
> reverting this change shows the following memory usage difference
> immediately after boot (no hugepages, nosmp, single user,
> intel_iommu=on iommu=pt):
> 
> @e70b081c6f37:
>               total        used        free      shared  buff/cache   available
> Mem:       16090860     2219372    13673044        1040      198444    13602664
> Swap:       2097148           0     2097148
> 
> reverting e70b081c6f37:
>                total        used        free      shared  buff/cache   available
> Mem:       16090852      101648    15789156        1040      200048    15719572
> Swap:       2097148           0     2097148
> 
> More than 2GB of additional memory used!  There's also a notable stall
> during bootup for this allocation:
> 
> [    9.703360] DMAR: No ATSR found
> [    9.709768] DMAR: dmar0: Using Queued invalidation
> [    9.719370] DMAR: dmar1: Using Queued invalidation
> 
> ### 4+ seconds! ###
> 
> [   14.076387] pci 0000:00:00.0: Adding to iommu group 0
> [   14.086515] pci 0000:00:01.0: Adding to iommu group 1
> [   14.096635] pci 0000:00:02.0: Adding to iommu group 2

Can you please try below changes?

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 887f184b900d..7eb29167e8f9 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2705,7 +2705,9 @@ static int __init si_domain_init(int hw)
                                     end >> agaw_to_width(si_domain->agaw)))
                                 continue;

-                       ret = iommu_domain_identity_map(si_domain, 
start, end);
+                       ret = iommu_domain_identity_map(si_domain,
+                                       mm_to_dma_pfn(start >> PAGE_SHIFT),
+                                       mm_to_dma_pfn(end >> PAGE_SHIFT));
                         if (ret)
                                 return ret;
                 }

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
