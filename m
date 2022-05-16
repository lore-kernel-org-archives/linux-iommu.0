Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF2DC433EF
	for <iommu@archiver.kernel.org>; Mon, 16 May 2022 13:43:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3C74361078;
	Mon, 16 May 2022 13:43:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Jw34_S2z9e9l; Mon, 16 May 2022 13:43:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1DC0F60AA5;
	Mon, 16 May 2022 13:43:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E048EC0039;
	Mon, 16 May 2022 13:43:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 56C4DC002D
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 13:43:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 43E05404D5
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 13:43:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MvsZCphbKNbz for <iommu@lists.linux-foundation.org>;
 Mon, 16 May 2022 13:43:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D11DF40180
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 13:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652708630; x=1684244630;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=t+/pLuhuUkhIgbEA+oiikj8Gc7z+OKs/HfsGEDeb13g=;
 b=RZeqL5nWzwLX/FavyEB+aBQWaPLi0xV0p11x6oyhpY8/WQBRIO6jX4J9
 aR1eypOXXLlz7j+EMUZ+mLhphQWfE6noZ1lGShJrZaghj0a76tEKueIo4
 A1lCeuoBtJKL9a7yT2mMHjna7dEuDemTHlbuTr2r3Sux14+UAMx1LoF8L
 pIXcAw2SiXDJwxeYYSjGVA0T+YZMvoW0sKhXjdEINfeAAT/mTh4KwX/AQ
 HyZD86XorFM0fEezwq5SV2NE7g+kQGB/6+9vLHbxZ2p+2dagDbtYVMJNJ
 /HWiBPH/FpQ9W2inyPzwtCkz7HnGM1hzjcMuE3b3BxtQCOt7p/rNfSdpR w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10348"; a="268412613"
X-IronPort-AV: E=Sophos;i="5.91,229,1647327600"; d="scan'208";a="268412613"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2022 06:43:49 -0700
X-IronPort-AV: E=Sophos;i="5.91,229,1647327600"; d="scan'208";a="522451951"
Received: from yanjiepa-mobl.ccr.corp.intel.com (HELO [10.249.192.19])
 ([10.249.192.19])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2022 06:43:45 -0700
Message-ID: <64f49746-1ae7-7516-8e92-06ffb4d5f8e5@linux.intel.com>
Date: Mon, 16 May 2022 21:43:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/5] iommu: Add blocking_domain_ops field in iommu_ops
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Will Deacon <will@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
References: <20220516015759.2952771-1-baolu.lu@linux.intel.com>
 <20220516015759.2952771-3-baolu.lu@linux.intel.com>
 <8a0fc6cf-f46e-f17e-2b76-099ada1683c3@arm.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <8a0fc6cf-f46e-f17e-2b76-099ada1683c3@arm.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>
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

Hi Robin,

On 2022/5/16 19:22, Robin Murphy wrote:
> On 2022-05-16 02:57, Lu Baolu wrote:
>> Each IOMMU driver must provide a blocking domain ops. If the hardware
>> supports detaching domain from device, setting blocking domain equals
>> detaching the existing domain from the deivce. Otherwise, an UNMANAGED
>> domain without any mapping will be used instead.
> 
> Unfortunately that's backwards - most of the implementations of 
> .detach_dev are disabling translation entirely, meaning the device ends 
> up effectively in passthrough rather than blocked. Conversely, at least 
> arm-smmu and arm-smmu-v3 could implement IOMMU_DOMAIN_BLOCKED properly 
> with fault-type S2CRs and STEs respectively, it just needs a bit of 
> wiring up.

Thank you for letting me know this.

This means that we need to add an additional UNMANAGED domain for each
iommu group, although it is not used most of the time. If most IOMMU
drivers could implement real dumb blocking domains, this burden may be
reduced.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
