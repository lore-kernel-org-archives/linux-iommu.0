Return-Path: <SRS0=SOau=JM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9B4C433B4
	for <iommu@archiver.kernel.org>; Thu, 15 Apr 2021 05:43:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22652611CD
	for <iommu@archiver.kernel.org>; Thu, 15 Apr 2021 05:43:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22652611CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CEEB440669;
	Thu, 15 Apr 2021 05:43:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8aMyOumYr_bX; Thu, 15 Apr 2021 05:43:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id D0A7040664;
	Thu, 15 Apr 2021 05:43:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9BAC2C000C;
	Thu, 15 Apr 2021 05:43:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DEB67C000A
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 05:43:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C2DC38430F
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 05:43:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aF-b7a2uAEEl for <iommu@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 05:43:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 611B684136
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 05:43:06 +0000 (UTC)
IronPort-SDR: 0g5gZXLqttXUOINa4lc8aWhgI36qwzUIsvEbL8T9W60j8J07SUs/IWhlx5karbrMi2bnHdIHQM
 3rLHKvyFASFA==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="174897164"
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; d="scan'208";a="174897164"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2021 22:43:05 -0700
IronPort-SDR: qEktfdrmGT45qn1aebxUB/pJx/fKbBwcm0+niphEjWBJrJDcuLrO5f66T2wQ+beTfa0wFwnYSB
 426qxLrFMI5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; d="scan'208";a="444065380"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128])
 ([10.239.159.128])
 by fmsmga004.fm.intel.com with ESMTP; 14 Apr 2021 22:43:02 -0700
Subject: Re: [PATCH 2/2] iommu/sva: Remove mm parameter from SVA bind API
To: Jason Gunthorpe <jgg@nvidia.com>
References: <1617901736-24788-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1617901736-24788-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <YHAoY9+w2ebYZ7VV@myrica> <20210409110305.6b0471d9@jacob-builder>
 <20210413170947.35ba9267@jacob-builder>
 <41433d99-e413-f5bf-5279-695dae6c58ba@linux.intel.com>
 <20210414112602.GA1370958@nvidia.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <eb700675-f698-62e5-bbab-3d199ff58dcb@linux.intel.com>
Date: Thu, 15 Apr 2021 13:33:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210414112602.GA1370958@nvidia.com>
Content-Language: en-US
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Raj Ashok <ashok.raj@intel.com>, vkoul@kernel.org,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 zhangfei.gao@linaro.org, Jean-Philippe Brucker <jean-philippe@linaro.com>
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

Hi Jason,

On 4/14/21 7:26 PM, Jason Gunthorpe wrote:
> On Wed, Apr 14, 2021 at 02:22:09PM +0800, Lu Baolu wrote:
> 
>> I still worry about supervisor pasid allocation.
>>
>> If we use iommu_sva_alloc_pasid() to allocate a supervisor pasid, which
>> mm should the pasid be set? I've ever thought about passing &init_mm to
>> iommu_sva_alloc_pasid(). But if you add "mm != current->mm", this seems
>> not to work. Or do you prefer a separated interface for supervisor pasid
>> allocation/free?
> 
> Without a mm_struct it is not SVA, so don't use SVA APIs for whatever
> a 'supervisor pasid' is

The supervisor PASID has its mm_struct. The only difference is that the
device will set priv=1 in its DMA transactions with the PASID.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
