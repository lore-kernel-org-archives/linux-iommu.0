Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C249C433EF
	for <iommu@archiver.kernel.org>; Tue,  8 Feb 2022 01:33:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CAC81608B7;
	Tue,  8 Feb 2022 01:33:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T8kNp8mUOOjk; Tue,  8 Feb 2022 01:33:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BB77B60A77;
	Tue,  8 Feb 2022 01:33:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91551C001A;
	Tue,  8 Feb 2022 01:33:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A30BC000B
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 01:33:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E70F2400FF
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 01:33:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wEkM4wEZWIt2 for <iommu@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 01:33:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 00E37400D3
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 01:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644284021; x=1675820021;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=lCvKr8YSZEJVpbrPbtkoNv3VFQvm3GXDNvJCWJ1cbfQ=;
 b=kQULsiBe7AlQ3Nwoc9hEKyLenBGXQqeTYdpmUI+dE7SrebG9CCTgDYw8
 1cVOuweW7WeUO0VJ0sKzbpsSlBNb4eNemTylP/LrwkSqdr1dAyTfp5vhA
 z7cNMwds7SWct+uVyPUbLJ3mhY5IwL5zC0SVg+PrGkTRtr7xugT0wr+9w
 PyxgsVetcj/x5US28CbynJLDY287DHKG2jzemTvMp2DZe/q2ZVRU09iIT
 9zN6vIkhDOz0xUinyW5Fv2KzGHAxpWRumGF5ERk+eI5PcHJ8xLuXO0Z/W
 yoGVEbe0V+YjZDI33UMMy3Do5Q1cBvrC8hI5L4WfXba1kFzitzsiEecjq A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="236252662"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; d="scan'208";a="236252662"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2022 17:33:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; d="scan'208";a="677950229"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 07 Feb 2022 17:33:36 -0800
Message-ID: <40399e95-1ce4-187e-06c1-7cd7b7f4a190@linux.intel.com>
Date: Tue, 8 Feb 2022 09:32:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/7] iommu cleanup and refactoring
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Ben Skeggs <bskeggs@redhat.com>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
References: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Jonathan Hunter <jonathanh@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>
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

On 1/24/22 3:10 PM, Lu Baolu wrote:
> Hi,
> 
> The guest pasid and aux-domain related code are dead code in current
> iommu subtree. As we have reached a consensus that all these features
> should be based on the new iommufd framework (which is under active
> development), the first part of this series removes and cleanups all
> the dead code.
> 
> The second part of this series refactors the iommu_domain by moving all
> domain-specific ops from iommu_ops to a new domain_ops. This makes an
> iommu_domain self-contained and represent the abstraction of an I/O
> translation table in the IOMMU subsystem. With different type of
> iommu_domain providing different set of ops, it's easier to support more
> types of I/O translation tables.
> 
> Please help to review and comment.

Thank you all for the great comments. A new version of this series has
been posted.

https://lore.kernel.org/linux-iommu/20220208012559.1121729-1-baolu.lu@linux.intel.com/

Please check whether I missed anything.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
