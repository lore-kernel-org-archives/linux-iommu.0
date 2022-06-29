Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F8BCCA47C
	for <iommu@archiver.kernel.org>; Wed, 29 Jun 2022 16:00:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 379F441A6D;
	Wed, 29 Jun 2022 16:00:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 379F441A6D
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.a=rsa-sha256 header.s=20200525 header.b=iZsQhnlb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pXW4wdqwOOZ2; Wed, 29 Jun 2022 16:00:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B16EC41B2D;
	Wed, 29 Jun 2022 16:00:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B16EC41B2D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6A742C0039;
	Wed, 29 Jun 2022 16:00:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4DCAEC002D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 16:00:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 273C38403C
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 16:00:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 273C38403C
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com
 header.a=rsa-sha256 header.s=20200525 header.b=iZsQhnlb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 02RFVnz1DHod for <iommu@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 16:00:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 04F7680A74
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 04F7680A74
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 16:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
 MIME-Version:Date:Message-ID:content-disposition;
 bh=DB/o3OL3a8p7Pc5UauzdC49YqSJaVUxyZzB2ozvl7YI=; b=iZsQhnlbpW9sXN/GJaS3jAMw+w
 8mn6izIwy085ybj1EKwF9DeEsOt9qyrlLxTvp+P9EVdEEjbQUwL5dVFTMDhjOaBp5PaGks7Gp0vTL
 Pz4wv3iQN06W33bmzngimPEHWIwXW/s9XuLr428TJq/t9Jpay97zThl6gUaoJoo9UCQ2zqUNOyzir
 HCs15GX4eR/A0kDWtJ7SaGXsATfCWkaQvG0flWXjWzNvEQkpGnbcu6afAc4ry10M/XvkH8tpuj6H7
 pV0F7DMjJNZAL9ALRpJtO4Tl1f8+YWZ+iaFmr74pOp+DJyj7fvd7YDPPvJ3gnFshVDAC+8VlO6cQM
 jCOY9fhQ==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200]
 helo=[192.168.0.10]) by ale.deltatee.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <logang@deltatee.com>)
 id 1o6a6s-002RzJ-UG; Wed, 29 Jun 2022 10:00:11 -0600
Message-ID: <99242789-66a6-bbd2-b56a-e47891f4522e@deltatee.com>
Date: Wed, 29 Jun 2022 10:00:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-CA
To: Christoph Hellwig <hch@lst.de>
References: <20220615161233.17527-1-logang@deltatee.com>
 <20220615161233.17527-21-logang@deltatee.com> <20220629064854.GD17576@lst.de>
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20220629064854.GD17576@lst.de>
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: hch@lst.de, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, sbates@raithlin.com,
 dan.j.williams@intel.com, jgg@ziepe.ca, christian.koenig@amd.com,
 jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org,
 daniel.vetter@ffwll.ch, dave.b.minturn@intel.com, jason@jlekstrand.net,
 dave.hansen@linux.intel.com, jianxin.xiong@intel.com, helgaas@kernel.org,
 ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com,
 ckulkarnilinux@gmail.com, rcampbell@nvidia.com, bhelgaas@google.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v7 20/21] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: linux-pci@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-mm@kvack.org, Jason Ekstrand <jason@jlekstrand.net>,
 Ira Weiny <ira.weiny@intel.com>, Minturn Dave B <dave.b.minturn@intel.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Ralph Campbell <rcampbell@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-block@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
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




On 2022-06-29 00:48, Christoph Hellwig wrote:
> On Wed, Jun 15, 2022 at 10:12:32AM -0600, Logan Gunthorpe wrote:
>> A pseudo mount is used to allocate an inode for each PCI device. The
>> inode's address_space is used in the file doing the mmap so that all
>> VMAs are collected and can be unmapped if the PCI device is unbound.
>> After unmapping, the VMAs are iterated through and their pages are
>> put so the device can continue to be unbound. An active flag is used
>> to signal to VMAs not to allocate any further P2P memory once the
>> removal process starts. The flag is synchronized with concurrent
>> access with an RCU lock.
> 
> Can't we come up with a way of doing this without all the pseudo-fs
> garbagage?  I really hate all the overhead for that in the next
> nvme patch as well.

I assume you still want to be able to unmap the VMAs on unbind and not
just hang?

I'll see if I can come up with something to do the a similar thing using
vm_private data or some such.

I was not a fan of the extra code for this either, but I was given to
understand that it was the standard way to collect and cleanup VMAs.

Thanks for the reviews,

Logan
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
