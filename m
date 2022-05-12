Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6A8FC433F5
	for <iommu@archiver.kernel.org>; Thu, 12 May 2022 06:22:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 738D6400B8;
	Thu, 12 May 2022 06:22:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1m7Cd1fjeAfI; Thu, 12 May 2022 06:22:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 67D7B40AD1;
	Thu, 12 May 2022 06:22:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3CC1DC0039;
	Thu, 12 May 2022 06:22:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4402CC002D
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 06:22:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3827D40184
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 06:22:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n6JtluHEK_0q for <iommu@lists.linux-foundation.org>;
 Thu, 12 May 2022 06:22:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 74C254014B
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 06:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652336529; x=1683872529;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=apWNSnw0jq7MMyjF5XJkJ1OhC5LHi+YzksZK3Q5fLSE=;
 b=m4Njk9QW5TOBduWyuEmWPvLe2i3U7koL5giBFOuDzoM5vFRI+dkLuXiT
 rkUmKXopYp+b0dgoWm+M7TN5570wD+tFjF62TvsgA0HLeb5c6/pKpt4zL
 gaOhbeuPBiP48z1U1GNyGqbJZxgN8Ee+yTup782QeVUOUyE+cVi6BHJY9
 nuf0oSrAIefq6Zmk0AvPeDsNDRXK4h4wwLhN9fR3bQmCqOGBH5Rsoo8ZY
 9Xw9I/0eJbz906NC/PDtE8V4PCZ3M48yFriUyPoEC1/Y1IycvM/yhXPw6
 2/42QuTfEOy3FS7ixxzlwQL+1yUplqoFMNxJMtPk/3wbNKKys/BEhZzwi g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="295152021"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; d="scan'208";a="295152021"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2022 23:22:08 -0700
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; d="scan'208";a="594516021"
Received: from hezhu1-mobl1.ccr.corp.intel.com (HELO [10.255.29.168])
 ([10.255.29.168])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2022 23:22:04 -0700
Message-ID: <c75a03db-69c2-0833-d853-b766c4561be4@linux.intel.com>
Date: Thu, 12 May 2022 14:22:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 1/4] iommu/vt-d: Implement domain ops for
 attach_dev_pasid
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20220510210704.3539577-1-jacob.jun.pan@linux.intel.com>
 <20220510210704.3539577-2-jacob.jun.pan@linux.intel.com>
 <20220510232121.GP49344@nvidia.com> <20220510172309.3c4e7512@jacob-builder>
 <20220511115427.GU49344@nvidia.com> <20220511082958.79d5d8ee@jacob-builder>
 <20220511161237.GB49344@nvidia.com> <20220511100216.7615e288@jacob-builder>
 <20220511170025.GF49344@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220511170025.GF49344@nvidia.com>
Cc: vkoul@kernel.org, "Tian, Kevin" <kevin.tian@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 will@kernel.org, Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 dmaengine@vger.kernel.org, robin.murphy@arm.com,
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

Hi Jason,

On 2022/5/12 01:00, Jason Gunthorpe wrote:
>> Consolidate pasid programming into dev_set_pasid() then called by both
>> intel_svm_attach_dev_pasid() and intel_iommu_attach_dev_pasid(), right?
> I was only suggesting that really dev_attach_pasid() op is misnamed,
> it should be called set_dev_pasid() and act like a set, not a paired
> attach/detach - same as the non-PASID ops.

So,

   "set_dev_pasid(domain, device, pasid)" equals to dev_attach_pasid()

and

   "set_dev_pasid(NULL, device, pasid)" equals to dev_detach_pasid()?

do I understand it right?

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
