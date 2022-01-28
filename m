Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4058C43217
	for <iommu@archiver.kernel.org>; Fri, 28 Jan 2022 14:21:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5A56740938;
	Fri, 28 Jan 2022 14:21:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JwQOk5vjHk5e; Fri, 28 Jan 2022 14:21:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F37A240544;
	Fri, 28 Jan 2022 14:21:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C7C1FC001A;
	Fri, 28 Jan 2022 14:21:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BBE79C000B
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 14:21:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9641D4175F
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 14:21:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ziepe.ca
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qO8Am5XvnKwl for <iommu@lists.linux-foundation.org>;
 Fri, 28 Jan 2022 14:21:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B70C441750
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 14:21:41 +0000 (UTC)
Received: by mail-qv1-xf32.google.com with SMTP id k4so5932822qvt.6
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 06:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=makDagrHRlU7vaXpIkbBqsJmR2imX/hQ0vT1IyZGbe8=;
 b=hagW1D3vrAXgmIdAaPuyb0ZYpBBI5GPj5cGf4t4VMPl2Hby0LDAfvZWMHlJD4RNPqz
 udQ6uMwMCSFght7z8OXaOlANPe89fBH+JadGzhs2iy3sYKIgrM8DNT9kykuob784vNJb
 /Y/FgIYpTCK+z7cKXzoYjO1GyqMmNfC0h5hNyGY73VQ5CoPXpXPP9nyVMuQ4vWD+VQga
 0hYXfzvwCLnChzgjp4NqFihb4T9f8dI0raxoWaXnXY+5G5GDrUXCHtUcKwBORYZObA9Y
 YPaqcPq/4bzPj+zORYsBg7/S7b+i2mhRoE+TwNrxyzVcDs3wf6ttmJBlILKVUF4beVAI
 0u4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=makDagrHRlU7vaXpIkbBqsJmR2imX/hQ0vT1IyZGbe8=;
 b=HXaXszMv+5lEM7/u/3Y0EhtKlLpIB+hbFEht+QPAhjRDpFF8qBlu+OpXopyy9sRpKn
 snj8PYgkaJzBIxfRfG/vQnfdwDXUbw8ufoDrDGhaWQr6HQ5G4Jy7wHISL4G4GYNAUtCy
 UCqMoEgOnlJgNQCfMDakEDZi65QPBAnSek2Me82dUrBj1w97ZluZ+7tZwHdbiLcWFvsm
 788TbgrjxiPSaJ9Pkc7RG55lUqM4iuW2H7DM7zByZ+cG+Iy3NUoxOmndtwXcd5Mfyg4O
 /zilAw6sr9FfNZ4llDmMVWKcZzGXLWt7UiJS1P0Y3PU5up0JnikUSL5hC+GxP0qE3p+j
 GeZA==
X-Gm-Message-State: AOAM531vgTtOLjCVPmSOzHlI8oHr1lC0Bwra7+Gi5Zt9s7EiVDbgUqY7
 363sf9NpAZ8FA8OM+Q+T5li4yg==
X-Google-Smtp-Source: ABdhPJw4cx6/r5UFZ4KcHMvTw88cPD84uAemPNZJJIK7lCC9YLt9fXRF4PueHdJDgL+a1AuPlHcoPg==
X-Received: by 2002:a05:6214:519a:: with SMTP id
 kl26mr7027757qvb.68.1643379700472; 
 Fri, 28 Jan 2022 06:21:40 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.129])
 by smtp.gmail.com with ESMTPSA id o4sm3070925qtw.53.2022.01.28.06.21.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jan 2022 06:21:39 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1nDS8A-007UXM-Bu; Fri, 28 Jan 2022 10:21:38 -0400
Date: Fri, 28 Jan 2022 10:21:38 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v5 02/24] mm: remove extra ZONE_DEVICE struct page refcount
Message-ID: <20220128142138.GU8034@ziepe.ca>
References: <20220128002614.6136-1-logang@deltatee.com>
 <20220128002614.6136-3-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220128002614.6136-3-logang@deltatee.com>
Cc: Alex Sierra <alex.sierra@amd.com>, linux-pci@vger.kernel.org,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-nvme@lists.infradead.org,
 Stephen Bates <sbates@raithlin.com>, linux-mm@kvack.org,
 Jason Ekstrand <jason@jlekstrand.net>, Ira Weiny <ira.weiny@intel.com>,
 Christoph Hellwig <hch@lst.de>, Minturn Dave B <dave.b.minturn@intel.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Matthew Wilcox <willy@infradead.org>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Ralph Campbell <rcampbell@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-block@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
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

On Thu, Jan 27, 2022 at 05:25:52PM -0700, Logan Gunthorpe wrote:
> From: Ralph Campbell <rcampbell@nvidia.com>
> 
> ZONE_DEVICE struct pages have an extra reference count that complicates the
> code for put_page() and several places in the kernel that need to check the
> reference count to see that a page is not being used (gup, compaction,
> migration, etc.). Clean up the code so the reference count doesn't need to
> be treated specially for ZONE_DEVICE.
> 
> [logang: dropped no longer used section from mm.h including
>  page_is_devmap_managed, rebased on v5.17-rc1 (possibly poorly)]
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/powerpc/kvm/book3s_hv_uvmem.c     |  2 +-
>  drivers/gpu/drm/nouveau/nouveau_dmem.c |  2 +-
>  fs/dax.c                               |  4 +-
>  include/linux/dax.h                    |  2 +-
>  include/linux/memremap.h               |  7 +--
>  include/linux/mm.h                     | 44 ----------------
>  lib/test_hmm.c                         |  2 +-
>  mm/internal.h                          |  8 +++
>  mm/memcontrol.c                        |  6 +--
>  mm/memremap.c                          | 70 +++++++-------------------
>  mm/migrate.c                           |  5 --
>  mm/page_alloc.c                        |  3 ++
>  mm/swap.c                              | 45 ++---------------
>  13 files changed, 46 insertions(+), 154 deletions(-)

This patch still can't be applied until the FSDAX issues are solved,
right? See my remarks the last time it was posted..

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
