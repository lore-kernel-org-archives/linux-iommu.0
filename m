Return-Path: <SRS0=4FG6=EM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B3BC5517A
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 17:53:57 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13E7122227
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 17:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="oUbweNGx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13E7122227
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B45432E130;
	Fri,  6 Nov 2020 17:53:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MBodeTggRH1w; Fri,  6 Nov 2020 17:53:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 00B352045A;
	Fri,  6 Nov 2020 17:53:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D9F0EC088B;
	Fri,  6 Nov 2020 17:53:55 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E4111C0889
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 17:53:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DB98287400
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 17:53:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yW2h0VJG5dLp for <iommu@lists.linux-foundation.org>;
 Fri,  6 Nov 2020 17:53:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 62429873FB
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 17:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oqvtFGaVjszB5PFtWzeKmwJF6MYA6lw1F4gIUPtEKvE=; b=oUbweNGxfS2FaKore4Y7MKiNQ4
 fg7zh2TgR0y03Add5nUBDQD4stjB1NKFFrVlgpzQC5fznCUfIGpE/akffcd0NrmPkS/77o3bGqNOw
 Ei1cBrxMlXYTIEwe8u8J3/T0r8arqe8w4l390vQ3orocVyTIzf6z7CZrtej7nyQkhxp3EiA2y+pCs
 ec5qyhMR/l/1TdiqL43zWSiILj0SMtpz8z8LbEIROwb7rpQwVQgIR2tT0Q6FH1Y0AE1K2D+k180Ro
 sQw0YqkiFV6aAHs9Txi/B9Y7KeLuEZiAfw0VfHJZlQOxTnS2f2YIkOWlG9kr2vD0uu72FDyO+wSXj
 C94axUyQ==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1kb5vm-0003Mq-D0; Fri, 06 Nov 2020 10:53:47 -0700
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20201106170036.18713-1-logang@deltatee.com>
 <20201106170036.18713-15-logang@deltatee.com>
 <20201106172206.GS36674@ziepe.ca>
 <b1e8dfce-d583-bed8-d04d-b7265a54c99f@deltatee.com>
 <20201106174223.GU36674@ziepe.ca>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <2c2d2815-165e-2ef9-60d6-3ace7ff3aaa5@deltatee.com>
Date: Fri, 6 Nov 2020 10:53:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201106174223.GU36674@ziepe.ca>
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



On 2020-11-06 10:42 a.m., Jason Gunthorpe wrote:
> On Fri, Nov 06, 2020 at 10:28:00AM -0700, Logan Gunthorpe wrote:
>>
>>
>> On 2020-11-06 10:22 a.m., Jason Gunthorpe wrote:
>>> On Fri, Nov 06, 2020 at 10:00:35AM -0700, Logan Gunthorpe wrote:
>>>> Introduce pci_mmap_p2pmem() which is a helper to allocate and mmap
>>>> a hunk of p2pmem into userspace.
>>>>
>>>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>>>>  drivers/pci/p2pdma.c       | 104 +++++++++++++++++++++++++++++++++++++
>>>>  include/linux/pci-p2pdma.h |   6 +++
>>>>  2 files changed, 110 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
>>>> index 9961e779f430..8eab53ac59ae 100644
>>>> +++ b/drivers/pci/p2pdma.c
>>>> @@ -16,6 +16,7 @@
>>>>  #include <linux/genalloc.h>
>>>>  #include <linux/memremap.h>
>>>>  #include <linux/percpu-refcount.h>
>>>> +#include <linux/pfn_t.h>
>>>>  #include <linux/random.h>
>>>>  #include <linux/seq_buf.h>
>>>>  #include <linux/xarray.h>
>>>> @@ -1055,3 +1056,106 @@ ssize_t pci_p2pdma_enable_show(char *page, struct pci_dev *p2p_dev,
>>>>  	return sprintf(page, "%s\n", pci_name(p2p_dev));
>>>>  }
>>>>  EXPORT_SYMBOL_GPL(pci_p2pdma_enable_show);
>>>> +
>>>> +struct pci_p2pdma_map {
>>>> +	struct kref ref;
>>>> +	struct pci_dev *pdev;
>>>> +	void *kaddr;
>>>> +	size_t len;
>>>> +};
>>>
>>> Why have this at all? Nothing uses it and no vm_operations ops are
>>> implemented?
>>
>> It's necessary to free the allocated p2pmem when the mapping is torn down.
> 
> That's suspicious.. Once in a VMA the lifetime of the page must be
> controlled by the page refcount, it can't be put back into the genpool
> just because the vma was destroed.

Ah, hmm, yes. I guess the pages have to be hooked and returned to the
genalloc through free_devmap_managed_page(). Seems like it might be
doable... but it will complicate things for users that don't want to use
the genpool (though no such users exist upstream).

Logan

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
