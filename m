Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 776F0C433EF
	for <iommu@archiver.kernel.org>; Tue, 15 Feb 2022 02:07:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3280A60D51;
	Tue, 15 Feb 2022 02:07:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3kORkqrLxMQq; Tue, 15 Feb 2022 02:07:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 09E1C60AB2;
	Tue, 15 Feb 2022 02:07:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7005C001A;
	Tue, 15 Feb 2022 02:07:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E73BFC000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 02:07:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CA05B40923
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 02:07:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KRpfqwdbLLv0 for <iommu@lists.linux-foundation.org>;
 Tue, 15 Feb 2022 02:07:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0F13440884
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 02:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644890835; x=1676426835;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=dZS7EKMhjasWG4hFq6KS48/STYMyzi5srwau0lAF/g0=;
 b=iSEluP0Zs+ldgElYWe0tA/BCTx6fXrzw3scEg02u15FfkUI1eSsayeES
 szdPL2EtHQ2VcgweDV6UaxIQmV1iRs+bcD36bVSoRmaYw/DmWFKQYEiK1
 vJeCp6B4jC7ho4s6LAw1aEr8FTGnWkm9Ih376aue87tI0EYMJhleQqpnB
 8ZrjznPn7/w4vR3w6OyLf+ZrLbPg+9faGaEnDVaG64IS+diM98c/a2Jtd
 xoWoMx91jruvVoOxD8EzeGGh2gnwudW5zIDVi6SOow5w0Z2WejnpqsPiL
 2E1hfoF2KEhcLfKtboax4IEpxzG2X+UmRbp0pbXbAI7zlqYWL9GZS+iq5 w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="274803341"
X-IronPort-AV: E=Sophos;i="5.88,369,1635231600"; d="scan'208";a="274803341"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Feb 2022 18:07:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,369,1635231600"; d="scan'208";a="680795109"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 14 Feb 2022 18:07:01 -0800
Message-ID: <1d817995-f89b-a1de-6aff-9a2bfe91367f@linux.intel.com>
Date: Tue, 15 Feb 2022 10:05:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 00/10] iommu cleanup and refactoring
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>
References: <20220214015538.2828933-1-baolu.lu@linux.intel.com>
 <YgpjzNtQlOdq+1AB@8bytes.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <YgpjzNtQlOdq+1AB@8bytes.org>
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

Hi Joerg,

On 2/14/22 10:14 PM, Joerg Roedel wrote:
> On Mon, Feb 14, 2022 at 09:55:28AM +0800, Lu Baolu wrote:
>> v3:
>>   - Remove ops check when dev_iommu_ops() is used.
>>   - This version of series is available on github:
>>     https://github.com/LuBaolu/intel-iommu/commits/iommu-domain-ops-v3
>>
>> Lu Baolu (10):
>>    iommu/vt-d: Remove guest pasid related callbacks
>>    iommu: Remove guest pasid related interfaces and definitions
>>    iommu/vt-d: Remove aux-domain related callbacks
>>    iommu: Remove aux-domain related interfaces and iommu_ops
>>    iommu: Remove apply_resv_region
>>    drm/nouveau/device: Get right pgsize_bitmap of iommu_domain
>>    iommu: Use right way to retrieve iommu_ops
>>    iommu: Remove unused argument in is_attach_deferred
>>    iommu: Use dev_iommu_ops() helper
>>    iommu: Split struct iommu_ops
> 
> Really cool, thanks for doing this, Baolu! I am currently running some
> tests on this series to make sure there are no build breakages. And I
> agree with Jason that:
> 
> 	iommu: Use right way to retrieve iommu_ops and
> 	iommu: Use dev_iommu_ops() helper
> 
> can be combined into one patch. Splitting iommu_ops was something I have
> been thinking about for some time, so thanks again for doing this.

You are welcome!

Do you want me to send a new version with below changes:

- Remove WARN_ON() in dev_iommu_ops();
- Merge above two patches.

Or, you can change above yourself?

> 
> Regards,
> 
> 	Joerg

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
