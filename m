Return-Path: <SRS0=7Zqx=JL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA36CC433ED
	for <iommu@archiver.kernel.org>; Wed, 14 Apr 2021 06:31:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AD19611EE
	for <iommu@archiver.kernel.org>; Wed, 14 Apr 2021 06:31:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AD19611EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E403F400F3;
	Wed, 14 Apr 2021 06:31:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EurqR6nBdL7f; Wed, 14 Apr 2021 06:31:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id CEE44400FA;
	Wed, 14 Apr 2021 06:31:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96A3DC000C;
	Wed, 14 Apr 2021 06:31:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 197E0C000A
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 06:31:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E388E60A4A
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 06:31:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CECAOr5fSF5P for <iommu@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 06:31:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 15097606F1
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 06:31:49 +0000 (UTC)
IronPort-SDR: QAyFMUDwwMzm6Sd5Vh6EqmSr/1N+q6SbGYLK/AGkE4yH9Tj0igdyre0H4E7ppXOY7s0MTr1wys
 X6R1PZ9JDcQQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9953"; a="215067492"
X-IronPort-AV: E=Sophos;i="5.82,221,1613462400"; d="scan'208";a="215067492"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Apr 2021 23:31:49 -0700
IronPort-SDR: jtTk4WrJ1bqaHDp2OMiOJLdZVz7CpNjV6TV1Sg570t5Pli+ReRHeJNydL3jvtdloMOYZwH7tn6
 r2LcAEzJYvOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,221,1613462400"; d="scan'208";a="443703998"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128])
 ([10.239.159.128])
 by fmsmga004.fm.intel.com with ESMTP; 13 Apr 2021 23:31:45 -0700
Subject: Re: [PATCH 2/2] iommu/sva: Remove mm parameter from SVA bind API
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <1617901736-24788-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1617901736-24788-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <YHAoY9+w2ebYZ7VV@myrica> <20210409110305.6b0471d9@jacob-builder>
 <20210413170947.35ba9267@jacob-builder>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <41433d99-e413-f5bf-5279-695dae6c58ba@linux.intel.com>
Date: Wed, 14 Apr 2021 14:22:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210413170947.35ba9267@jacob-builder>
Content-Language: en-US
Cc: vkoul@kernel.org, "Tian, Kevin" <kevin.tian@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Jason Gunthorpe <jgg@nvidia.com>, zhangfei.gao@linaro.org,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
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

On 4/14/21 8:09 AM, Jacob Pan wrote:
> Hi Jean,
> 
> On Fri, 9 Apr 2021 11:03:05 -0700, Jacob Pan
> <jacob.jun.pan@linux.intel.com> wrote:
> 
>>> problems:
>>>
>>> * We don't have a use-case for binding the mm of a remote process (and
>>>    it's supposedly difficult for device drivers to do it securely). So
>>> OK, we remove the mm argument from iommu_sva_bind_device() and use the
>>>    current mm. But the IOMMU driver isn't going to do
>>> get_task_mm(current) every time it needs the mm being bound, it will
>>> take it from iommu_sva_bind_device(). Likewise iommu_sva_alloc_pasid()
>>> shouldn't need to bother with get_task_mm().
>>>
>>> * cgroup accounting for IOASIDs needs to be on the current task.
>>> Removing the mm parameter from iommu_sva_alloc_pasid() doesn't help
>>> with that. Sure it indicates that iommu_sva_alloc_pasid() needs a
>>> specific task context but that's only for cgroup purpose, and I'd
>>> rather pass the cgroup down from iommu_sva_bind_device() anyway (but am
>>> fine with keeping it within ioasid_alloc() for now). Plus it's an
>>> internal helper, easy for us to check that the callers are doing the
>>> right thing.
>> With the above split, we really just have one allocation function:
>> ioasid_alloc(), so it can manage current cgroup accounting within. Would
>> this work?
> After a few attempts, I don't think the split can work better. I will
> restore the mm parameter and add a warning if mm != current->mm.

I still worry about supervisor pasid allocation.

If we use iommu_sva_alloc_pasid() to allocate a supervisor pasid, which
mm should the pasid be set? I've ever thought about passing &init_mm to
iommu_sva_alloc_pasid(). But if you add "mm != current->mm", this seems
not to work. Or do you prefer a separated interface for supervisor pasid
allocation/free?

Best regards,
baolu

> 
> Thanks,
> 
> Jacob
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
