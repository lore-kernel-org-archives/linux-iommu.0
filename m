Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA3CBC433EF
	for <iommu@archiver.kernel.org>; Tue, 25 Jan 2022 04:44:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 67EEE40204;
	Tue, 25 Jan 2022 04:44:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4hiBEeAGF5K2; Tue, 25 Jan 2022 04:44:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2A01C400FB;
	Tue, 25 Jan 2022 04:44:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 013EFC0039;
	Tue, 25 Jan 2022 04:44:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13C0EC002F
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 04:44:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 00874401DF
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 04:44:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2q56Ax6Q6BC8 for <iommu@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 04:44:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 45BE7400FB
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 04:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1643085873; x=1674621873;
 h=cc:subject:to:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=RHEqwCKoay/aJcjfpJzwezonfNdiVpJz/c7HuPxDFXQ=;
 b=WBvEG9PSMOdnWS2g4cJp3GpUOa1D4VNKp7a2PNMK1xRNiQ5dMG6lIZJ5
 ANLXX7XkMmetusmLBcX2g3/rXX9jrPeYsHqAa6ZIYnjqtJMz89yAAOiWi
 a9hf858at+N2q/G4Ch6RF8zbKxef37flyehPrBFjmQGUG+su8Z6FIr/33
 PLQ8ndUkNRp0YHD8tJLR5ELFV1gCKc3Lbpauh8a156ipJsORXuP+Wo5XK
 JxQJUBeVUNDGpth9KBlZKAdCr5KdYsBLPAHkT04ohhADzHJ257kd6Z12p
 BTe7oQ5mZ34A1HNQTfVhzTNYX7TlZPqZuKXcAgScRkoUfvWQfQaYtiHNY g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="226195053"
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; d="scan'208";a="226195053"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2022 20:44:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; d="scan'208";a="534559345"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 24 Jan 2022 20:44:28 -0800
Subject: Re: [PATCH 7/7] iommu: Add iommu_domain::domain_ops
To: Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>
References: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
 <20220124071103.2097118-8-baolu.lu@linux.intel.com>
 <Ye5zUapC/YcZs7kl@infradead.org> <20220124172418.GE966497@nvidia.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <256b0ae8-47c5-24ac-0ca9-8f0936505656@linux.intel.com>
Date: Tue, 25 Jan 2022 12:43:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220124172418.GE966497@nvidia.com>
Content-Language: en-US
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 David Airlie <airlied@linux.ie>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Thierry Reding <thierry.reding@gmail.com>, Ben Skeggs <bskeggs@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
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

On 1/25/22 1:24 AM, Jason Gunthorpe wrote:
> On Mon, Jan 24, 2022 at 01:37:21AM -0800, Christoph Hellwig wrote:
>> On Mon, Jan 24, 2022 at 03:11:02PM +0800, Lu Baolu wrote:
>>> Add a domain specific callback set, domain_ops, for vendor iommu driver
>>> to provide domain specific operations. Move domain-specific callbacks
>>> from iommu_ops to the domain_ops and hook them when a domain is allocated.
>>
>> Ah, that's what I meant earlier.  Perfect!
>>
>> Nit:  I don't think vendor is the right term here.
> 
> +1 please don't use the confusing 'vendor' in the kernel, if you feel
> you want to write 'vendor' writing 'device driver' is usually a good
> choice..

Sure!

> 
> This whole series is nice, the few small notes aside, thanks for
> making it!

Thank you!

> 
> Jason
> 

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
