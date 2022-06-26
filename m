Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE69C433EF
	for <iommu@archiver.kernel.org>; Sun, 26 Jun 2022 01:15:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A0BC24051E;
	Sun, 26 Jun 2022 01:15:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A0BC24051E
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OeYlqAWP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ocrg6PyzYxah; Sun, 26 Jun 2022 01:15:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7235640235;
	Sun, 26 Jun 2022 01:15:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7235640235
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3A540C0039;
	Sun, 26 Jun 2022 01:15:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7BCA5C002D
 for <iommu@lists.linux-foundation.org>; Sun, 26 Jun 2022 01:15:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 41F5F60FE1
 for <iommu@lists.linux-foundation.org>; Sun, 26 Jun 2022 01:15:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 41F5F60FE1
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=OeYlqAWP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yxlvDrnMhGhJ for <iommu@lists.linux-foundation.org>;
 Sun, 26 Jun 2022 01:15:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 45F9D60FDD
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 45F9D60FDD
 for <iommu@lists.linux-foundation.org>; Sun, 26 Jun 2022 01:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656206151; x=1687742151;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=kWtrTWhVygy80koAHRds8cQZJGpxEZcR9U+1akiF+8M=;
 b=OeYlqAWP6DGWx37fNIyCpjLwnMDR8RWYuCBsVuhzgaogjrrsRhlbM/Mm
 3I+tBQyx68seVFSYfa4+bv7aIHMnZWrt4D4CNvFr11dPRqgmy3jylurvv
 RbTru7gVVh/oEs7CZBLHJ8vEiNrUQ0LNU9I/ZmukG8pVTiRxAyOdrK9rt
 OJX2E9e+qrpKukMnwS9Yds64c8OqOySuhH940zit1SYERRNk4HkIagtgn
 u9eQE0RG0I/F2awJt6x6LbUDjFiliCO6Q1LFz3Fyx2DFAFO9t3AFfAYal
 ZLk8WF648CX7Y/hK0dgxDZHpYTD/8uI1kipPLMFLixTt/+NW+knqB+Q6j Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10389"; a="342921031"
X-IronPort-AV: E=Sophos;i="5.92,223,1650956400"; d="scan'208";a="342921031"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2022 18:15:48 -0700
X-IronPort-AV: E=Sophos;i="5.92,223,1650956400"; d="scan'208";a="645839129"
Received: from jzhu26-mobl1.ccr.corp.intel.com (HELO [10.249.168.26])
 ([10.249.168.26])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2022 18:15:44 -0700
Message-ID: <068df2f5-1e14-8249-ac14-55864e6a4488@linux.intel.com>
Date: Sun, 26 Jun 2022 09:15:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v9 00/11] iommu: SVA and IOPF refactoring
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
References: <20220621144353.17547-1-baolu.lu@linux.intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220621144353.17547-1-baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>
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

Hi folks,

On 2022/6/21 22:43, Lu Baolu wrote:
> Hi folks,
> 
> The former part of this series refactors the IOMMU SVA code by assigning
> an SVA type of iommu_domain to a shared virtual address and replacing
> sva_bind/unbind iommu ops with set/block_dev_pasid domain ops.
> 
> The latter part changes the existing I/O page fault handling framework
> from only serving SVA to a generic one. Any driver or component could
> handle the I/O page faults for its domain in its own way by installing
> an I/O page fault handler.
> 
> This series has been functionally tested on an x86 machine and compile
> tested for all architectures.
> 
> This series is also available on github:
> [2]https://github.com/LuBaolu/intel-iommu/commits/iommu-sva-refactoring-v9
> 
> Please review and suggest.

Just a gentle ping on this series.

Do you have further inputs? I am trying to see if we can merge this
series for v5.20. The drivers also depend on it to enable their kernel
DMA with PASID.

Sorry to disturb you.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
