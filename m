Return-Path: <SRS0=A59K=AG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55160C433E0
	for <iommu@archiver.kernel.org>; Thu, 25 Jun 2020 07:07:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2156C20706
	for <iommu@archiver.kernel.org>; Thu, 25 Jun 2020 07:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2156C20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8AD048765E;
	Thu, 25 Jun 2020 07:07:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0MQO2MuxPG8V; Thu, 25 Jun 2020 07:07:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C390E86DAF;
	Thu, 25 Jun 2020 07:07:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A9199C0863;
	Thu, 25 Jun 2020 07:07:37 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 26369C016F
 for <iommu@lists.linux-foundation.org>; Thu, 25 Jun 2020 07:07:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 22C3B854DB
 for <iommu@lists.linux-foundation.org>; Thu, 25 Jun 2020 07:07:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lRwCBxromerv for <iommu@lists.linux-foundation.org>;
 Thu, 25 Jun 2020 07:07:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 5270785462
 for <iommu@lists.linux-foundation.org>; Thu, 25 Jun 2020 07:07:35 +0000 (UTC)
IronPort-SDR: CpvfklLBSJa4G0KcULjPZpEvtcDFEwWh2I/rIE7Ea6citL4HFyvWthT3av2il8bCrigVomAJ3u
 Uo1UWvxkobMg==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="133213893"
X-IronPort-AV: E=Sophos;i="5.75,278,1589266800"; d="scan'208";a="133213893"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2020 00:07:32 -0700
IronPort-SDR: VbikwaFc4A3y6iXRr3/X0tdSVtYk86TFkbXmVtNMfMd/TjS30CV0BxTsNDPGFxAictFFXCoyu4
 9RyqgEGqnypQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,278,1589266800"; d="scan'208";a="263854658"
Received: from yijiangw-mobl1.ccr.corp.intel.com (HELO [10.255.28.52])
 ([10.255.28.52])
 by fmsmga007.fm.intel.com with ESMTP; 25 Jun 2020 00:07:28 -0700
Subject: Re: [PATCH v3 4/5] iommu/uapi: Handle data and argsz filled by users
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <1592931837-58223-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1592931837-58223-5-git-send-email-jacob.jun.pan@linux.intel.com>
 <84491857-4a7e-e669-3cf5-615b010930e4@linux.intel.com>
 <20200624100709.1277f912@jacob-builder>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <1d730edf-277f-17fb-6a44-e6af07b6d43e@linux.intel.com>
Date: Thu, 25 Jun 2020 15:07:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200624100709.1277f912@jacob-builder>
Content-Language: en-US
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>
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

On 2020/6/25 1:07, Jacob Pan wrote:
> On Wed, 24 Jun 2020 14:54:49 +0800
> Lu Baolu<baolu.lu@linux.intel.com>  wrote:
> 
>> Hi Jacob,
>>
>> On 2020/6/24 1:03, Jacob Pan wrote:
>>> IOMMU UAPI data has a user filled argsz field which indicates the
>>> data length comes with the API call. User data is not trusted,
>>> argsz must be validated based on the current kernel data size,
>>> mandatory data size, and feature flags.
>>>
>>> User data may also be extended, results in possible argsz increase.
>>> Backward compatibility is ensured based on size and flags checking.
>>> Details are documented in Documentation/userspace-api/iommu.rst
>>>
>>> This patch adds sanity checks in both IOMMU layer and vendor code,
>>> where VT-d is the only user for now.
>>>
>>> Signed-off-by: Liu Yi L<yi.l.liu@intel.com>
>>> Signed-off-by: Jacob Pan<jacob.jun.pan@linux.intel.com>
>>> ---
>>>    drivers/iommu/intel/svm.c |  3 ++
>>>    drivers/iommu/iommu.c     | 96
>>> ++++++++++++++++++++++++++++++++++++++++++++---
>>> include/linux/iommu.h     |  7 ++-- 3 files changed, 98
>>> insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
>>> index 713b3a218483..237db56878c0 100644
>>> --- a/drivers/iommu/intel/svm.c
>>> +++ b/drivers/iommu/intel/svm.c
>>> @@ -244,6 +244,9 @@ int intel_svm_bind_gpasid(struct iommu_domain
>>> *domain, struct device *dev, data->format !=
>>> IOMMU_PASID_FORMAT_INTEL_VTD) return -EINVAL;
>>>    
>>> +	if (data->argsz != offsetofend(struct
>>> iommu_gpasid_bind_data, vendor.vtd))
>>> +		return -EINVAL;
>> Need to do size check in intel_iommu_sva_invalidate() as well?
>>
> No need. The difference is that there is no
> vendor specific union for intel_iommu_sva_invalidate().
> 
> Generic flags are used to process invalidation data inside
> intel_iommu_sva_invalidate().

Thanks for the explanation. With the nit tweaked,

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
