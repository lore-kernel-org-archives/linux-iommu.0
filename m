Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1CB1C43334
	for <iommu@archiver.kernel.org>; Thu,  2 Jun 2022 17:19:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7A73C4198A;
	Thu,  2 Jun 2022 17:19:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DOotX86WN1EJ; Thu,  2 Jun 2022 17:19:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B8932418ED;
	Thu,  2 Jun 2022 17:19:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71B5BC0032;
	Thu,  2 Jun 2022 17:19:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8E15C002D
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jun 2022 17:19:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D0BAD60B64
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jun 2022 17:19:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ziepe.ca
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PoE6rZEzlrs1 for <iommu@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 17:19:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E8A2D60B51
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jun 2022 17:19:17 +0000 (UTC)
Received: by mail-qv1-xf33.google.com with SMTP id s10so824019qvt.8
 for <iommu@lists.linux-foundation.org>; Thu, 02 Jun 2022 10:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=s4YbZJYHvK3nVAxdvdm+/MuYfvjkcChJJ4+lAokhsws=;
 b=oY3UkNUXzvT4gdwz2capbciaRVMUwQe4uTXMNLZq5rB+SzgWV5Y9KoY1sDKwk8gWEZ
 3+Q6uw1zQKFy/Unx4HtSstHVhLVkyZWxIMc80Ov1HAVUKCwD358EREeYDHhZDZ8k2MZs
 bhOn53kb4QxCMIITNdm+0c1NDnpndPfQjTJuD8TnE5Uv3cFfjqWJqQft0Z4nj9YH3uBX
 nPBbjR1L9pvnoVrAHHIKs0Q9BrMid/o8PxXfUbP6XGG/0m5N+an4nPqyjM2uURiJ8hW5
 nebfcv+yWDiGXnYLe+dR4uJdRKeLgQOn7tZfDT3mAn3r317E5qS4d++iGATXbWfBN5kK
 ZpSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=s4YbZJYHvK3nVAxdvdm+/MuYfvjkcChJJ4+lAokhsws=;
 b=hqDz2RDS0VhRb7p+EnEyTvBaiJZe/TWTUG1Q68prIt4ufGvyAvCXw+w8+V6gLrVAYc
 7GJE59Z3LtRP1vlO1UfjAlHgf8Xcj47qNH6kNZPWhAWTOot9VoogiOvwuz4002m+Yhh5
 5HQtrbETrch5q8lQlqwRqoehftywSfXkoKgqxuF014pxe8RAG+uJiddtWnZa+Vep8hWC
 6WUL1EAvhh+XFdz3S3GPVG+iWwPEQhp/WjOJbmAPe19E0AP+mNDtcfli7KissMa70Zcb
 SzTgxcGh/mEpZYjX7xXgMSkb692lYCN8xM/JwwCXCkxROt815Dx/cHNxj6a79oLzhZwy
 OnlA==
X-Gm-Message-State: AOAM530gDtmFWMLSHzGQx2X/5IQynP+BKdng2x3sY3yMul2ESV3A1mxc
 4DZ83TnzKeFuWttOOJWHFplo8g==
X-Google-Smtp-Source: ABdhPJyTeRjkxp4FkIVBkBdxqYlIi1Ql4U5vaRWOEfB4UJA8nUT6ExwG7uYWv1AjNIltcvnn29cQ7w==
X-Received: by 2002:ad4:5b81:0:b0:465:ded8:780 with SMTP id
 1-20020ad45b81000000b00465ded80780mr6281647qvp.119.1654190356566; 
 Thu, 02 Jun 2022 10:19:16 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.129]) by smtp.gmail.com with ESMTPSA id
 p200-20020a3742d1000000b0069fc13ce1e7sm3510487qka.24.2022.06.02.10.18.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jun 2022 10:18:55 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1nwoSV-00GUM1-QB; Thu, 02 Jun 2022 14:18:07 -0300
Date: Thu, 2 Jun 2022 14:18:07 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v6 20/21] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
Message-ID: <20220602171807.GM2960187@ziepe.ca>
References: <20220407154717.7695-1-logang@deltatee.com>
 <20220407154717.7695-21-logang@deltatee.com>
 <20220527125501.GD2960187@ziepe.ca>
 <a2590e27-41e8-59dc-3576-b5b8d716a198@deltatee.com>
 <20220527190307.GG2960187@ziepe.ca>
 <d336cfe8-2451-04c3-a2ce-0e8e47afd1e3@deltatee.com>
 <20220602000038.GK2960187@ziepe.ca>
 <400baba7-1cd6-09d4-4de9-2a73f08afc79@deltatee.com>
 <20220602163059.GL2960187@ziepe.ca>
 <28824558-4fd5-e054-6c8d-5e045d52f795@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <28824558-4fd5-e054-6c8d-5e045d52f795@deltatee.com>
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
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
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

On Thu, Jun 02, 2022 at 10:45:55AM -0600, Logan Gunthorpe wrote:
> 
> 
> 
> On 2022-06-02 10:30, Jason Gunthorpe wrote:
> > On Thu, Jun 02, 2022 at 10:16:10AM -0600, Logan Gunthorpe wrote:
> > 
> >>> Just stuff the pages into the mmap, and your driver unprobe will
> >>> automatically block until all the mmaps are closed - no different than
> >>> having an open file descriptor or something.
> >>
> >> Oh is that what we want?
> > 
> > Yes, it is the typical case - eg if you have a sysfs file open unbind
> > hangs indefinitely. Many drivers can't unbind while they have open file
> > descriptors/etc.
> > 
> > A couple drivers go out of their way to allow unbinding while a live
> > userspace exists but this can get complicated. Usually there should be
> > a good reason.
> 
> This is not my experience. All the drivers I've worked with do not block
> unbind with open file descriptors (at least for char devices). I know,
> for example, that having a file descriptor open of /dev/nvmeX does not
> cause unbinding to block.

So there are lots of bugs in the kernel, and I've seen many drivers
that think calling cdev_device_del() is all they need to do - and then
happily allow cdev ioctl's/etc on a de-initialized driver struct.

Drivers that do take care of this usually have to put a lock around
all their fops to serialize against unbind. RDMA uses SRCU, iirc TPM
used a rwlock. But this is tricky and hurts fops performance.

I don't know what nvme did to protect against this, I didn't notice
an obvious lock.

> I figured this was the expectation as the userspace process doing
> the unbind won't be able to be interrupted seeing there's no way to
> fail on that path. Though, it certainly would make things a lot
> easier if the unbind can block indefinitely as it usually requires
> some complicated locking.

As I said, this is what sysfs does today and I don't see that ever
changing. If you userspace has a sysfs file open then the driver
unbind hangs until the file is closed.

So, doing as bad as sysfs seems like a reasonable baseline to me.

> Do you have an example of this? What mechanisms are developers using to
> block unbind with open file descriptors?

Sysfs maintains a refcount with a bias that is basically a fancied
rwlock. Most places use some kind of refcount triggering a
completion. Sleep on the completion until refcount is 0 on unbind kind
of thing.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
