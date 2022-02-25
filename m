Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C359CC433F5
	for <iommu@archiver.kernel.org>; Fri, 25 Feb 2022 01:54:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 51FF182A95;
	Fri, 25 Feb 2022 01:54:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZHAT6O2iPxHs; Fri, 25 Feb 2022 01:54:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3A9B782A3B;
	Fri, 25 Feb 2022 01:54:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0B2DEC0021;
	Fri, 25 Feb 2022 01:54:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 863F6C0011
 for <iommu@lists.linux-foundation.org>; Fri, 25 Feb 2022 01:54:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6E2AA40C21
 for <iommu@lists.linux-foundation.org>; Fri, 25 Feb 2022 01:54:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6eloPvDiSXiE for <iommu@lists.linux-foundation.org>;
 Fri, 25 Feb 2022 01:54:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 562754010C
 for <iommu@lists.linux-foundation.org>; Fri, 25 Feb 2022 01:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1645754080; x=1677290080;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=mUtNdgA9eIG3EQUM/FNY38W2dgxVgh4wTcxODYjZ4f4=;
 b=kAtvNCIOlIpm4+yUdTvd01CxOmzRoxxK2qt4+SR3QCUmthZVq3VjAI8D
 S6+GN9svIe+bNH7jsIOfsSAHPg+aFwuJr8X9aRFSIzsAzDejzTEHEs9GR
 Ad90Gz0P3zhrFkaEgfnHQxjbdTe+l748zVTmMj6tWEbCvoQqtRSCU70eV
 9Ys2sKbkZOSfudsGu7s+6GIKMajp0JNXCKe0Rb8Ur7XkRBOR/3fm0LTFQ
 a96GK3loQrXR7rowmHzRzkBgaAqeQdtjFKlie3Seb9VH1PADJCnh4Yn8t
 XfDr6rmJ37V9GKgzL4bb3W6KlYqraCvivtSgu+K2amcbiuTJeVBGm+J6/ A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="338833854"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; d="scan'208";a="338833854"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2022 17:54:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; d="scan'208";a="533385060"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga007.jf.intel.com with ESMTP; 24 Feb 2022 17:54:35 -0800
Message-ID: <ed5c4e45-e25e-59a7-d3e2-ba414f161dd1@linux.intel.com>
Date: Fri, 25 Feb 2022 09:53:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 09/11] iommu/vt-d: Remove commented code
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220214025704.3184654-1-baolu.lu@linux.intel.com>
 <20220214025704.3184654-10-baolu.lu@linux.intel.com>
 <20220224130945.GL6413@nvidia.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220224130945.GL6413@nvidia.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

On 2/24/22 9:09 PM, Jason Gunthorpe wrote:
> On Mon, Feb 14, 2022 at 10:57:02AM +0800, Lu Baolu wrote:
>> This removes unnecessary commented code.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/iommu.c | 10 +---------
>>   1 file changed, 1 insertion(+), 9 deletions(-)
> 
> Assuming you don't want to uncomment it

I planned to postpone the decision as I need time to check the details
in the VT-d spec and talk to the architecture experts if needed.

> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Jason

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
