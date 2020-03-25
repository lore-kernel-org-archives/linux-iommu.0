Return-Path: <SRS0=fUNI=5K=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A185C10DCE
	for <iommu@archiver.kernel.org>; Wed, 25 Mar 2020 00:49:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F00C52072E
	for <iommu@archiver.kernel.org>; Wed, 25 Mar 2020 00:49:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F00C52072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B0F3A20341;
	Wed, 25 Mar 2020 00:49:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uNigkonBntWJ; Wed, 25 Mar 2020 00:49:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 4B6BF20016;
	Wed, 25 Mar 2020 00:49:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D188C1D7C;
	Wed, 25 Mar 2020 00:49:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 299F3C0177
 for <iommu@lists.linux-foundation.org>; Wed, 25 Mar 2020 00:49:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2280685074
 for <iommu@lists.linux-foundation.org>; Wed, 25 Mar 2020 00:49:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fXs7A+wYr4Xn for <iommu@lists.linux-foundation.org>;
 Wed, 25 Mar 2020 00:49:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4DBED84EE9
 for <iommu@lists.linux-foundation.org>; Wed, 25 Mar 2020 00:49:00 +0000 (UTC)
IronPort-SDR: c/0meNiFcBdyHXmilhVjw5p3TnReIRJsQlt/1xrycKEpq+RkZw0G3nDiL7KlSXIjJ59k69GA0F
 yhQ099D7lnFg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2020 17:48:59 -0700
IronPort-SDR: dtHPvsrDTJbb71F/Q2NRkZDgf4EaQFXvvH0YunX2hhXNbctEMRMsmQtQcH+Qd/SLuiVEsk7tQk
 BqFNc4vlY1DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,302,1580803200"; d="scan'208";a="357663286"
Received: from yujietax-mobl1.ccr.corp.intel.com (HELO [10.254.214.161])
 ([10.254.214.161])
 by fmsmga001.fm.intel.com with ESMTP; 24 Mar 2020 17:48:52 -0700
Subject: Re: [PATCH 1/3] iommu/vt-d: Remove redundant IOTLB flush
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <1584678751-43169-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1584678751-43169-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <26ab1917-f087-aafa-e861-6a2478000a6f@linux.intel.com>
 <20200320092047.4a4cf551@jacob-builder>
 <06c9751a-417d-3c32-65af-0788593f811a@linux.intel.com>
 <20200324083125.27b78594@jacob-builder>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <5aff3f99-9f8b-4d61-8c88-8b22a8f7f722@linux.intel.com>
Date: Wed, 25 Mar 2020 08:48:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200324083125.27b78594@jacob-builder>
Content-Language: en-US
Cc: Raj Ashok <ashok.raj@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>
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

On 2020/3/24 23:31, Jacob Pan wrote:
> On Sat, 21 Mar 2020 09:32:45 +0800
> Lu Baolu<baolu.lu@linux.intel.com>  wrote:
> 
>> On 2020/3/21 0:20, Jacob Pan wrote:
>>> On Fri, 20 Mar 2020 21:45:26 +0800
>>> Lu Baolu<baolu.lu@linux.intel.com>  wrote:
>>>    
>>>> On 2020/3/20 12:32, Jacob Pan wrote:
>>>>> IOTLB flush already included in the PASID tear down process. There
>>>>> is no need to flush again.
>>>> It seems that intel_pasid_tear_down_entry() doesn't flush the pasid
>>>> based device TLB?
>>>>   
>>> I saw this code in intel_pasid_tear_down_entry(). Isn't the last
>>> line flush the devtlb? Not in guest of course since the passdown
>>> tlb flush is inclusive.
>>>
>>> 	pasid_cache_invalidation_with_pasid(iommu, did, pasid);
>>> 	iotlb_invalidation_with_pasid(iommu, did, pasid);
>>>
>>> 	/* Device IOTLB doesn't need to be flushed in caching mode.
>>> */ if (!cap_caching_mode(iommu->cap))
>>> 		devtlb_invalidation_with_pasid(iommu, dev, pasid);
>>>    
>> But devtlb_invalidation_with_pasid() doesn't do the right thing, it
>> flushes the device tlb, instead of pasid-based device tlb.
>>
> Hmm, you are right. But the function name is misleading, pasid argument
> is not used, is there a reason why?
> This is used for PASID based device IOTLB flush, right?
> 

Yes. I will fix and put your patch after it.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
