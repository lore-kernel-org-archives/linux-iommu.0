Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05146C433EF
	for <iommu@archiver.kernel.org>; Tue, 21 Dec 2021 17:27:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A7C2F40A43;
	Tue, 21 Dec 2021 17:27:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DXzG67LylD-P; Tue, 21 Dec 2021 17:27:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5388440A3A;
	Tue, 21 Dec 2021 17:27:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1FE95C002F;
	Tue, 21 Dec 2021 17:27:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 843F2C0012
 for <iommu@lists.linux-foundation.org>; Tue, 21 Dec 2021 17:27:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5D90B81911
 for <iommu@lists.linux-foundation.org>; Tue, 21 Dec 2021 17:27:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=deltatee.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3IqQ2NY-ZuPJ for <iommu@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 17:27:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D7D9681902
 for <iommu@lists.linux-foundation.org>; Tue, 21 Dec 2021 17:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=tHUZjlzEP3lopTOQQN8mNVWiWWJwS29dSxMFB9HD+A8=; b=BGAK1lUDvyuZ48bEqcCgg4po+X
 NmanPhpAS6+UNAz03pYcDzNhaFu6mxvVL+qqnx53zeLQX6h1PxLDsBp8IULQlncbyQRvfjX79PRX9
 gvGf08CiKgzW2Sj7hkGZNGAo4+HMl1MGmxNHvizb/NiE6kQd8yfGXJ/3dXLgtk53IKoxY4ZDedsfU
 DPyaBVJpdtBflN4LZlAsXbgLCmRJRoBDGMAfmDRTKiT01PhljpgcRRK1n7m1/kODICqJNT8gQZlWb
 9hO76EMgdAOZiU3xTp4NH/AWvbL4YKf/4o7K7oRm5tr5TSQHxlKuC+ozusnGeek8c5BYNcduFKMx3
 t6BHI/9w==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <logang@deltatee.com>)
 id 1mziuv-00AX3M-08; Tue, 21 Dec 2021 10:27:14 -0700
To: Christoph Hellwig <hch@lst.de>
References: <20211117215410.3695-1-logang@deltatee.com>
 <20211117215410.3695-22-logang@deltatee.com> <20211221090648.GE7949@lst.de>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <369770be-c2d1-fcbf-f317-279981707cb9@deltatee.com>
Date: Tue, 21 Dec 2021 10:27:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211221090648.GE7949@lst.de>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: ckulkarnilinux@gmail.com, martin.oliveira@eideticom.com,
 robin.murphy@arm.com, ira.weiny@intel.com, helgaas@kernel.org,
 jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net,
 dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch,
 willy@infradead.org, ddutile@redhat.com, jhubbard@nvidia.com,
 christian.koenig@amd.com, jgg@ziepe.ca, dan.j.williams@intel.com,
 sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v4 21/23] mm: use custom page_free for P2PDMA pages
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
 John Hubbard <jhubbard@nvidia.com>, linux-block@vger.kernel.org,
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



On 2021-12-21 2:06 a.m., Christoph Hellwig wrote:
> On Wed, Nov 17, 2021 at 02:54:08PM -0700, Logan Gunthorpe wrote:
>> When P2PDMA pages are passed to userspace, they will need to be
>> reference counted properly and returned to their genalloc after their
>> reference count returns to 1. This is accomplished with the existing
>> DEV_PAGEMAP_OPS and the .page_free() operation.
>>
>> Change CONFIG_P2PDMA to select CONFIG_DEV_PAGEMAP_OPS and add
>> MEMORY_DEVICE_PCI_P2PDMA to page_is_devmap_managed(),
>> devmap_managed_enable_[put|get]() and free_devmap_managed_page().
> 
> Uuuh.  We are trying hard to kill off this magic free at refcount 1
> behavior in the amdgpu device coherent series.  We really should not
> add more of this.

Ah, ok. I found Ralph's patch that cleans this up and I can try to
rebase this onto it for future postings until it gets merged.

Your other comments I can address for the next time I post this series.

Thanks for the review!

Logan
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
