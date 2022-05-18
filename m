Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC808C433FE
	for <iommu@archiver.kernel.org>; Wed, 18 May 2022 06:43:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 57C57611D3;
	Wed, 18 May 2022 06:43:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sRpk3FiGPnTT; Wed, 18 May 2022 06:43:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 346CE611CF;
	Wed, 18 May 2022 06:43:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EFCB5C0039;
	Wed, 18 May 2022 06:43:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BC1E9C002D
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 06:43:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A28AE611CF
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 06:43:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xmYu1b0jXXzJ for <iommu@lists.linux-foundation.org>;
 Wed, 18 May 2022 06:43:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 84C97611C8
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 06:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652856219; x=1684392219;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=9qTYvzKhlcHrIU1CsQee+xTk+1GmejCy5sboiPMyNu8=;
 b=GMI9WgtpN2mwGa3pE7o2Xtgc78t5b154a8omh5BsPnZ9Cz7YljXtUS8A
 vYsMlJfQBnM9zsGWsW0vD7NNk8miq3atIZmapoSBEzEgoBDys1mKBdjmd
 /NZ5XEiUNXfO4kYDIaDwKWJWsspcQaxbgbvWPDandzSlV5IYFFqe1N5X3
 XBc3XdrHL07EgZUjLY9wKh8yLw3t7HqhHBxFRAHZg+Qp1t6B7zZlbTgLc
 6rc7NtjBQ+4FDXoJWxDoW8iGlJKwzZY9W3+4yLPX7/2jbma5Q+9GgRz4f
 tO0SMUdZHp8lNyiDJl7qmVhkSjj1rrd24/Kw9+62us8aa7E0Hv1SaE9Rx g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="357917474"
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; d="scan'208";a="357917474"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 May 2022 23:43:38 -0700
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; d="scan'208";a="545283301"
Received: from lenawanx-mobl.ccr.corp.intel.com (HELO [10.255.28.87])
 ([10.255.28.87])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 May 2022 23:43:35 -0700
Message-ID: <7fcd6f05-2a05-7dd3-3668-c1f45ee5e024@linux.intel.com>
Date: Wed, 18 May 2022 14:43:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/5] iommu: Add blocking_domain_ops field in iommu_ops
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>
References: <20220516015759.2952771-1-baolu.lu@linux.intel.com>
 <20220516015759.2952771-3-baolu.lu@linux.intel.com>
 <8a0fc6cf-f46e-f17e-2b76-099ada1683c3@arm.com>
 <20220516135741.GV1343366@nvidia.com>
 <c8492b29-bc27-ae12-d5c4-9fbbc797e310@linux.intel.com>
 <f971aea9-8ae1-95f8-b10a-cd77e9704dc0@arm.com>
 <20220517131324.GU1343366@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220517131324.GU1343366@nvidia.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Will Deacon <will@kernel.org>
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

On 2022/5/17 21:13, Jason Gunthorpe wrote:
> On Tue, May 17, 2022 at 01:43:03PM +0100, Robin Murphy wrote:
> 
>> FWIW from my point of view I'm happy with having a .detach_dev_pasid op
>> meaning implicitly-blocked access for now.
> 
> If this is the path then lets not call it attach/detach
> please. 'set_dev_pasid' and 'set_dev_blocking_pasid' are clearer
> names.

Sure. And with the blocking domain implemented, the
set_dev_blocking_pasid could be deprecated.

> 
>> On SMMUv3, PASIDs don't mix with our current notion of
>> IOMMU_DOMAIN_IDENTITY (nor the potential one for
>> IOMMU_DOMAIN_BLOCKED), so giving PASIDs functional symmetry with
>> devices would need significantly more work anyway.
> 
> There is no extra work in the driver, beyond SMMU having to implement
> a blocking domain. The blocking domain's set_dev_pasid op simply is
> whatever set_dev_blocking_pasid would have done on the unmanaged
> domain.
> 
> identity doesn't come into this, identity domains should have a NULL
> set_dev_pasid op if the driver can't support using it on a PASID.
> 
> IMHO blocking_domain->ops->set_dev_pasid() is just a more logical name
> than domain->ops->set_dev_blocking_pasid() - especially since VFIO
> would like drivers to implement blocking domain anyhow.

Perhaps implementing blocking domains for intel and smmuv3 iommu drivers
seem to be a more practical start.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
