Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14154C433F5
	for <iommu@archiver.kernel.org>; Wed, 16 Feb 2022 02:57:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B0F95415EE;
	Wed, 16 Feb 2022 02:57:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tOHUT2S2JQcy; Wed, 16 Feb 2022 02:57:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8825B4156D;
	Wed, 16 Feb 2022 02:57:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6DD6BC001A;
	Wed, 16 Feb 2022 02:57:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 43393C000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Feb 2022 02:57:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2D8D183131
 for <iommu@lists.linux-foundation.org>; Wed, 16 Feb 2022 02:57:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q41xPRa_u53r for <iommu@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 02:57:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8425682803
 for <iommu@lists.linux-foundation.org>; Wed, 16 Feb 2022 02:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644980268; x=1676516268;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=jy/68Jo+rlTOCwXa1YivsLzibuxvincunuTmDdjbiSQ=;
 b=TfARmaRkLiJ3BH14zDyFP+kF6TruWd/Zm+7ObBpx/sKjCHGk1w+jmWlY
 75Itov0+A/B/+cHPMLZIILJ460pqy84yL6QvCU+epeCpIawBgAg+aA8D3
 E0C/TAWRaaJK/4ZGjzF42N1rlgAvDxBw1uSitqqWIcHTatmaKvKCu4uxI
 p5Myl+B1sWjboyum6hBDSVg92ZIqJJpt126POYamaF7iE/xF3wUqwhqAW
 gKaqpxV/Gr/DEN9nEetC9pNjagu/q5P+C/PE6AtiE4Yfc47xNCZsGESBW
 XE/7PUvmDFvHX26F5AOOmiJ9iQZW5eaBhZ19U4ENOiuuC1YrXob7JnOE1 A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="237913871"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; d="scan'208";a="237913871"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Feb 2022 18:57:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; d="scan'208";a="681313261"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 15 Feb 2022 18:57:41 -0800
Message-ID: <04c8042a-9aab-332f-6607-44b60be9f514@linux.intel.com>
Date: Wed, 16 Feb 2022 10:56:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 00/10] iommu cleanup and refactoring
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>
References: <20220214015538.2828933-1-baolu.lu@linux.intel.com>
 <YgpjzNtQlOdq+1AB@8bytes.org>
 <1d817995-f89b-a1de-6aff-9a2bfe91367f@linux.intel.com>
 <YgtvrJ2eIUV+U84u@8bytes.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <YgtvrJ2eIUV+U84u@8bytes.org>
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 David Airlie <airlied@linux.ie>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Christoph Hellwig <hch@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Thierry Reding <thierry.reding@gmail.com>, Ben Skeggs <bskeggs@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Daniel Vetter <daniel@ffwll.ch>,
 Jonathan Hunter <jonathanh@nvidia.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org
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

On 2/15/22 5:17 PM, Joerg Roedel wrote:
> Hi Baolu,
> 
> On Tue, Feb 15, 2022 at 10:05:42AM +0800, Lu Baolu wrote:
>> Do you want me to send a new version with below changes:
>>
>> - Remove WARN_ON() in dev_iommu_ops();
>> - Merge above two patches.
>>
>> Or, you can change above yourself?
> 
> Please make the changes and send a new version. I will apply it to the
> iommu core branch then. The build-tests with this patch-set went well
> and I havn't spotted anything else in my review, so I think it is in
> good shape for linux-next testing.

Sure and done.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
