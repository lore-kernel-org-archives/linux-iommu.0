Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D0CC43334
	for <iommu@archiver.kernel.org>; Thu,  2 Jun 2022 16:46:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9E4AD405A3;
	Thu,  2 Jun 2022 16:46:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KVvMoo8kaHs5; Thu,  2 Jun 2022 16:46:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 743F940576;
	Thu,  2 Jun 2022 16:46:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 47DE0C0039;
	Thu,  2 Jun 2022 16:46:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7C954C002D
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jun 2022 16:46:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5CAE9405A3
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jun 2022 16:46:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fG1X-6H73_Xw for <iommu@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 16:46:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3C7C340576
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jun 2022 16:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
 MIME-Version:Date:Message-ID:content-disposition;
 bh=yHMITh+N130iuSnYvU2I4WotSms4ADBqIIhjmWEL4ZQ=; b=O6Xl4kM8MUO00BCgiQ9hWPp+gB
 2m7ZVz8sHNAOQKpiy5iEU/brZWoHl9L3YI08j4vZrZwZONQy6WWyOSXW66i+Zcv9QKlOeesm8TgjQ
 pABnUdHP29eKXg17nEZ/MnWYIcmY/29mOmJme4RbBeYYarSUthGM7iOo3qpUFKlkgq37Ue76GJEjA
 MfSw6YBYC+/0IQghP6E8FIRiZlTGbFFCXvUfzWrCRinU718CfdX6Eh08/4ZrDvJWXnPQwmRp+4WdA
 1qxJEJvrytnpdt9tHqZk0bsYRw6b+C0O39SAOTytYjPcg2eYDgsp57ejuIJbnxeryaQkNoi8uOxrW
 ueUPAsxQ==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200]
 helo=[192.168.0.10]) by ale.deltatee.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <logang@deltatee.com>)
 id 1nwnxQ-00EOAT-Fz; Thu, 02 Jun 2022 10:46:01 -0600
Message-ID: <28824558-4fd5-e054-6c8d-5e045d52f795@deltatee.com>
Date: Thu, 2 Jun 2022 10:45:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-CA
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20220407154717.7695-1-logang@deltatee.com>
 <20220407154717.7695-21-logang@deltatee.com>
 <20220527125501.GD2960187@ziepe.ca>
 <a2590e27-41e8-59dc-3576-b5b8d716a198@deltatee.com>
 <20220527190307.GG2960187@ziepe.ca>
 <d336cfe8-2451-04c3-a2ce-0e8e47afd1e3@deltatee.com>
 <20220602000038.GK2960187@ziepe.ca>
 <400baba7-1cd6-09d4-4de9-2a73f08afc79@deltatee.com>
 <20220602163059.GL2960187@ziepe.ca>
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20220602163059.GL2960187@ziepe.ca>
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: jgg@ziepe.ca, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de,
 dan.j.williams@intel.com, christian.koenig@amd.com, jhubbard@nvidia.com,
 ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch,
 andrzej.jakowski@intel.com, dave.b.minturn@intel.com, jason@jlekstrand.net,
 dave.hansen@linux.intel.com, jianxin.xiong@intel.com, helgaas@kernel.org,
 ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com,
 ckulkarnilinux@gmail.com, rcampbell@nvidia.com, bhelgaas@google.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v6 20/21] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: linux-pci@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-mm@kvack.org, Jason Ekstrand <jason@jlekstrand.net>,
 Ira Weiny <ira.weiny@intel.com>, Christoph Hellwig <hch@lst.de>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Matthew Wilcox <willy@infradead.org>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Ralph Campbell <rcampbell@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-block@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
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




On 2022-06-02 10:30, Jason Gunthorpe wrote:
> On Thu, Jun 02, 2022 at 10:16:10AM -0600, Logan Gunthorpe wrote:
> 
>>> Just stuff the pages into the mmap, and your driver unprobe will
>>> automatically block until all the mmaps are closed - no different than
>>> having an open file descriptor or something.
>>
>> Oh is that what we want?
> 
> Yes, it is the typical case - eg if you have a sysfs file open unbind
> hangs indefinitely. Many drivers can't unbind while they have open file
> descriptors/etc.
> 
> A couple drivers go out of their way to allow unbinding while a live
> userspace exists but this can get complicated. Usually there should be
> a good reason.

This is not my experience. All the drivers I've worked with do not block
unbind with open file descriptors (at least for char devices). I know,
for example, that having a file descriptor open of /dev/nvmeX does not
cause unbinding to block. I figured this was the expectation as the
userspace process doing the unbind won't be able to be interrupted
seeing there's no way to fail on that path. Though, it certainly would
make things a lot easier if the unbind can block indefinitely as it
usually requires some complicated locking.

Do you have an example of this? What mechanisms are developers using to
block unbind with open file descriptors?

Logan
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
