Return-Path: <SRS0=zuxH=IW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B80C433C1
	for <iommu@archiver.kernel.org>; Wed, 24 Mar 2021 07:35:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 839E5619FD
	for <iommu@archiver.kernel.org>; Wed, 24 Mar 2021 07:35:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 839E5619FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 29446848CC;
	Wed, 24 Mar 2021 07:35:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KF1UeviW3C3F; Wed, 24 Mar 2021 07:35:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 090BE848AC;
	Wed, 24 Mar 2021 07:35:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8DB0C000E;
	Wed, 24 Mar 2021 07:35:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E15BC000A
 for <iommu@lists.linux-foundation.org>; Wed, 24 Mar 2021 07:35:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5B8AD40641
 for <iommu@lists.linux-foundation.org>; Wed, 24 Mar 2021 07:35:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4X8J6a7r4GGm for <iommu@lists.linux-foundation.org>;
 Wed, 24 Mar 2021 07:35:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8C2E84063A
 for <iommu@lists.linux-foundation.org>; Wed, 24 Mar 2021 07:35:20 +0000 (UTC)
IronPort-SDR: QIBYT+/1QM24sYOo0nOv6QGMD4EKoXY03wL6VCjOzBpXlIdXWkmixZ6x1UxqOEJLShuBY2BzWr
 K/N2y+mNOMaw==
X-IronPort-AV: E=McAfee;i="6000,8403,9932"; a="188338473"
X-IronPort-AV: E=Sophos;i="5.81,274,1610438400"; d="scan'208";a="188338473"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2021 00:35:19 -0700
IronPort-SDR: OmnYOMTkXgpKl7T1YTJnYZc69aewVIAzXSe2RtYrSkJaaeTqy5+DhGBfhtogD0+V67ZKn8VQr1
 OEeZ/vz8lX9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,274,1610438400"; d="scan'208";a="435887389"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128])
 ([10.239.159.128])
 by fmsmga004.fm.intel.com with ESMTP; 24 Mar 2021 00:35:14 -0700
Subject: Re: [PATCH 3/5] iommu/vt-d: Remove SVM_FLAG_PRIVATE_PASID
To: Christoph Hellwig <hch@infradead.org>
References: <20210323010600.678627-1-baolu.lu@linux.intel.com>
 <20210323010600.678627-4-baolu.lu@linux.intel.com>
 <20210323173357.GD2463754@infradead.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <6fa292bd-9307-6e29-7968-005e1b8a087d@linux.intel.com>
Date: Wed, 24 Mar 2021 15:25:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210323173357.GD2463754@infradead.org>
Content-Language: en-US
Cc: kevin.tian@intel.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com,
 Will Deacon <will@kernel.org>
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

Hi Christoph,

On 3/24/21 1:33 AM, Christoph Hellwig wrote:
> On Tue, Mar 23, 2021 at 09:05:58AM +0800, Lu Baolu wrote:
>> The SVM_FLAG_PRIVATE_PASID has never been referenced in the tree, and
>> there's no plan to have anything to use it. So cleanup it.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> 
> Looks good,
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thank you!

> 
> But can we take this a little further?  SVM_FLAG_GUEST_PASID is unused
> as well.  SVM_FLAG_GUEST_MODE is only used in drivers/iommu/intel/svm.c,
> and SVM_FLAG_SUPERVISOR_MODE is actually used as an API flag to
> iommu_sva_bind_device.  So IMHO the latter should be elevated to an
> IOMMU API level flag, and then include/linux/intel-svm.h can go away
> entirely or at least be moved to drivers/iommu/intel/.
> 

Sure. I will consider it and make it in separated patches.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
