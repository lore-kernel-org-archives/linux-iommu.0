Return-Path: <SRS0=4FG6=EM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0D1C63697
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 18:20:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF2B4221FA
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 18:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="WEavvMGU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF2B4221FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8D0ED86ACC;
	Fri,  6 Nov 2020 18:20:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EZApNURhaK-J; Fri,  6 Nov 2020 18:20:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CC78786AD0;
	Fri,  6 Nov 2020 18:20:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AFA5FC1AD5;
	Fri,  6 Nov 2020 18:20:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CE097C1AD6
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 18:20:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id AEFAE86C55
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 18:20:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WBjpyU3iDGP3 for <iommu@lists.linux-foundation.org>;
 Fri,  6 Nov 2020 18:20:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 24C3186BF1
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 18:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4c2lQ6ZJoiJD4wddIsh1sqnOjISbk8NdEHLgyMHjsI4=; b=WEavvMGUHHtVS6NthMSIjYgE8G
 m2Shk+887YnWyl84qAu5c5aSnwfmdgsQkwuV6Qk/VTpfpITmSKpZTStz2VoJeuvrgKYFgbkpcC2x9
 +Eygs4xkSnIjwB3jk8TQYbV+xWQY2KzZLECeTap/XHrhF7RfsNefRy2cKKo9kcYj3Hkd43uD6lH8r
 UeDxe01Yy7KFTC7wo/J2Zw1d3VJYZkJMQ5JZSmcYq3a5l1dL0v2dLl8ounQVMEe9onzzakY4UYleu
 immFBl00AOuIB6Gr3JQNUHz9T+DktFRE1Gznw7frT3XHfeD8UYFSjQcgB6Z9ymXrL/hXHs6bQE5SP
 AZUhpu/A==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1kb6LI-0003vN-G2; Fri, 06 Nov 2020 11:20:09 -0700
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20201106170036.18713-1-logang@deltatee.com>
 <20201106170036.18713-15-logang@deltatee.com>
 <20201106172206.GS36674@ziepe.ca>
 <b1e8dfce-d583-bed8-d04d-b7265a54c99f@deltatee.com>
 <20201106174223.GU36674@ziepe.ca>
 <2c2d2815-165e-2ef9-60d6-3ace7ff3aaa5@deltatee.com>
 <20201106180922.GV36674@ziepe.ca>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <09885400-36f8-bc1d-27f0-a8adcf6104d4@deltatee.com>
Date: Fri, 6 Nov 2020 11:20:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201106180922.GV36674@ziepe.ca>
Content-Language: en-US
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: daniel.vetter@ffwll.ch, willy@infradead.org,
 ddutile@redhat.com, jhubbard@nvidia.com, iweiny@intel.com,
 christian.koenig@amd.com, dan.j.williams@intel.com, hch@lst.de,
 sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [RFC PATCH 14/15] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 linux-pci@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Ira Weiny <iweiny@intel.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-block@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Matthew Wilcox <willy@infradead.org>,
 John Hubbard <jhubbard@nvidia.com>, Dan Williams <dan.j.williams@intel.com>,
 Christoph Hellwig <hch@lst.de>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



On 2020-11-06 11:09 a.m., Jason Gunthorpe wrote:
>> Ah, hmm, yes. I guess the pages have to be hooked and returned to the
>> genalloc through free_devmap_managed_page(). 
> 
> That sounds about right, but in this case it doesn't need the VMA
> operations.
> 
>> Seems like it might be doable... but it will complicate things for
>> users that don't want to use the genpool (though no such users exist
>> upstream).
> 
> I would like to use this stuff in RDMA pretty much immediately and the
> genpool is harmful for those cases, so please don't make decisions
> that are tying thing to genpool

I certainly can't make decisions for code that isn't currently upstream.
So you will almost certainly have to make changes for the code you want
to add, as is the standard procedure. I can't and should not export APIs
that you might need that have no upstream users, but you are certainly
free to send patches that create them when you add the use case.

Ultimately, if you aren't using the genpool you will have to implement
your own mmap operation that somehow allocates the pages and your own
page_free hook. The latter can be accommodated for by a patch that
splits off pci_p2pdma_add_resource() into a function that doesn't use
the genpool (I've already seen two independent developers create a
similar patch for this but with no upstream user, they couldn't be taken
upstream).

I also don't expect this to be going upstream in the near term so don't
get too excited about using it.

Logan
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
