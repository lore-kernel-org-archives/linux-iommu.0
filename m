Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C000C433EF
	for <iommu@archiver.kernel.org>; Tue, 25 Jan 2022 03:02:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 04F5641668;
	Tue, 25 Jan 2022 03:02:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id it3Y322qTurA; Tue, 25 Jan 2022 03:02:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B89894159C;
	Tue, 25 Jan 2022 03:02:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7B004C0039;
	Tue, 25 Jan 2022 03:02:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C7F6C002F
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 03:02:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 44DCD4159C
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 03:02:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AhtdezJijZ2w for <iommu@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 03:02:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9DB074159B
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 03:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1643079728; x=1674615728;
 h=cc:subject:to:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=by9ZO+ZTDaK468UmSn4Yi/q3n6O9rPWIIHQ/Z6V2Pus=;
 b=W0U8J8LCqMjVEEgXOET493xZYreInmWwAKv/nmlX1w5NTuH/hFKLs6HC
 v4+vtFmxwFUxnoRapzDqG1FRZuqH9jt4FA63mXXmSkkMpFfIuwxPRUFHP
 UiFT7Sm0VtXGmia4lXf89K9gBavWIL1tLy3HQcxL3gCicSuMygDrGSNpi
 9rYhLwgPHaR0LpoLNOkMI2w4FofKh2EJnzbBePdAstJrdmPJN9+Y7IHMx
 MOBczsrSYPbB2YzLHvoF0HvITPxXtRCg/uA5HaCsxDUrB2DmWcU6YKX2a
 nCk0hlKbyO86D0h0YjlWFFnf1kaXX77vSj/6kPs74Fn1+C0SSE7fX+B5B g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="226182937"
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; d="scan'208";a="226182937"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2022 19:02:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; d="scan'208";a="534531392"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 24 Jan 2022 19:02:03 -0800
Subject: Re: [PATCH 6/7] iommu: Use right way to retrieve iommu_ops
To: Christoph Hellwig <hch@infradead.org>
References: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
 <20220124071103.2097118-7-baolu.lu@linux.intel.com>
 <Ye5yHejpaAnJQYeR@infradead.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <f59b5cf7-0275-b979-1d57-a629fd81450a@linux.intel.com>
Date: Tue, 25 Jan 2022 11:01:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Ye5yHejpaAnJQYeR@infradead.org>
Content-Language: en-US
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 David Airlie <airlied@linux.ie>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
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

On 1/24/22 5:32 PM, Christoph Hellwig wrote:
> On Mon, Jan 24, 2022 at 03:11:01PM +0800, Lu Baolu wrote:
>> The common iommu_ops is hooked to both device and domain. When a helper
>> has both device and domain pointer, the way to get the iommu_ops looks
>> messy in iommu core. This sorts out the way to get iommu_ops. The device
>> related helpers go through device pointer, while the domain related ones
>> go through domain pointer.
> 
> Ugg. This really sounds like we should have a different structures for
> each set of ops?
>

Yes. Do this in the following patch.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
