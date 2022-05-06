Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CBEFC433F5
	for <iommu@archiver.kernel.org>; Fri,  6 May 2022 09:42:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3389160A7D;
	Fri,  6 May 2022 09:42:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p9OX8vCYE_pb; Fri,  6 May 2022 09:41:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0D0B5606FF;
	Fri,  6 May 2022 09:41:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D76B1C0039;
	Fri,  6 May 2022 09:41:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C6575C002D
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 09:41:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A184483C28
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 09:41:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wNW-hWPNs7OL for <iommu@lists.linux-foundation.org>;
 Fri,  6 May 2022 09:41:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0E69D832FF
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 09:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651830116; x=1683366116;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=9HpIY2d8dSccfuftpwYO1dFMBtQicI/mHMa5Q/2TB3g=;
 b=Mw1SUeOYbu3YiFKo5g3SmfAAGdTPRYhpDsuHkQcso+GU1gksnAoDQriG
 beRC9a77LQmGK8OAvT7MqI7bG7e2Y0u9LalLRTmFi2d1My2RBKMsA6Qwk
 UnP247jgqHjgdwEv2kfWEP/cyazBFbr48KDR0vPFxNilLf4D5La/fjS8+
 QjBOiEyA5rFz47xOcVaFrvxehugXwDK2e1YpWNpZ38xeB0DLLGfkttJDw
 KU8qDYC7jqXeWk655WMFsAlwtWnOLxtL/zZdvVe+8aUQ0E7AWTKPhPiel
 y3AbJY5aYE5z2h+HRRsLy9evyDqUPcBKvINx0y2eJEHkAWERcvR5V77e1 A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="267257139"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="267257139"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2022 02:41:55 -0700
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="735545837"
Received: from sunyanwa-mobl1.ccr.corp.intel.com (HELO [10.255.31.183])
 ([10.255.31.183])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2022 02:41:52 -0700
Message-ID: <2e312943-61de-d4f3-d85d-c1b9e1a62e69@linux.intel.com>
Date: Fri, 6 May 2022 17:41:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2] iommu: iommu_group_claim_dma_owner() must always
 assign a domain
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>
References: <0-v2-f62259511ac0+6-iommu_dma_block_jgg@nvidia.com>
 <BN9PR11MB5276504B448C715527AD5F3F8CC29@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220505153320.GS49344@nvidia.com>
 <1b8bf74a-cafa-822f-8843-0d1caf3f56ac@arm.com>
 <20220505192720.GW49344@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220505192720.GW49344@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Rodel, Jorg" <jroedel@suse.de>,
 Qian Cai <quic_qiancai@quicinc.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
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

On 2022/5/6 03:27, Jason Gunthorpe wrote:
> On Thu, May 05, 2022 at 07:56:59PM +0100, Robin Murphy wrote:
> 
>> Ack to that, there are certainly further improvements to consider once we've
>> got known-working code into a released kernel, but let's not get ahead of
>> ourselves just now.
> Yes please
>   
>> (I'm pretty sure we could get away with a single blocking domain per IOMMU
>> instance, rather than per group, but I deliberately saved that one for later
>> - right now one per group to match default domains is simpler to reason
>> about and less churny in the context of the current ownership patches)
> I noticed this too..
> 
> But I thought the driver can do a better job of this. There is no
> reason it has to allocate memory to return a IOMMU_DOMAIN_BLOCKED
> domain - this struct could be a globally allocated singleton for the
> entire driver and that would be even better memory savings.
> 
> For instance, here is a sketch for the Intel driver based on Baolu's
> remark that intel_iommu_detach_device() establishes a blocking
> behavior already on detach_dev (Baolu if you like it can you make a
> proper patch?):

Yes, I will.

The same scheme could also be applied to identity/sva/block domains.
Perhaps make it after v5.19.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
