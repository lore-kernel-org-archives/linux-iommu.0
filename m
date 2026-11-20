Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795205060;
	b=ZmfEyRvjb4aqRhsYCKvULlWgxyTXBXOetQ38v8pEI+XaPB4D5aphZl2kixIC6eTVhlx7
	 E68JInIIDgeZ+BysWRBmW5Lggc/AvLMwnWJsWNZW2s6FsxvV7/LFiPijCW1+MwY76QMnr
	 H+yUaachn+WLHfD0Gq6QLX3LyOLfPsEkIZ7BLRUOA2QLl2d3+IqAyBh0BTPk8L9wZvHLL
	 fCSxGJxggYInmb+Fr2F/bGDg/lNuzxredJvSH2hev9dIFxuIOZlU+WHV/aHyq7Su1awWo
	 LbyDtgCK4mBa+oGcl6gfX5QOipuhoBr+INz78el/Xq28PMn6ZT667oAt8QbUZGvS+VQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795205060;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=sbS+kHys+ZROW4VWeSHfOuIQU9MpFrnjpn+wgap+dRo=;
	b=Sf7S3N2cOaUOnWx9VDRZ0FP3EfH6dmeu2+HpVzfUzSVTFZ+QguPJj1qTXlPDVpvdWQJM
	 6LuYsybOqDR3iunxE7/sFE4hA5OPw4QCjX84MuQHO+XQ5x8p4CuikWyf0FBq1x+HUGOWC
	 Xe0J3wHXQ/DCWKvadQck4LkAWPhUrdf1gZJ4Uc08GkZ6qnsYUFHB8Y0Fkl1zW84GHHkq9
	 qI2oN0CP5CUJAEbmJIUwc5lNXi95P9NMZBYIYx7RCeXMNMwnG4NPA+YMfFHb0jROkOyL4
	 PwMygBlhBJGErKeXjvJ5Qiq0YhjuNNy6jj3noN0bAB98/Guw3thWTBRVtUsZ2xk7GQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="Fvqp/Edj";
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893B4606A6E5
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 20:04:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 893B4606A6E5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Fvqp/Edj
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ee254f6eefso15005ad.0
        for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 12:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795205059; x=1795809859; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sbS+kHys+ZROW4VWeSHfOuIQU9MpFrnjpn+wgap+dRo=;
        b=Fvqp/EdjS/sVpZc4HDWCz5Nmhlm2pSSw16gfirmA87zUGt0NmsZG3uI9YaL1BpibLq
         UYjPUBHM6aYS/bxWijMrCiPACl9e4LtXYEMmaJLQoltH2ijVfos08iJ74QDsjLVeRFFU
         PIFxrRjAqTGfNHncMmWQ6loe62VS8vFa+/tZL1glp4+/cyqCrx3/CbLllOLFWwrkl5ay
         57CaCqLn7jWVBTeUzxfTg/zrTJWFGHn2stDqPdxx6POwpow9nWnLBPhFz31dKFAXedu0
         H61N/mRXGCC0wNYXzQmbAf/ipwUeqj0SE2Ufr4ilMmsZbBPXW9LgxNsI4lxL40o/4fsk
         eE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795205059; x=1795809859;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sbS+kHys+ZROW4VWeSHfOuIQU9MpFrnjpn+wgap+dRo=;
        b=CBczew5ZMEYfiaBKz1gALghV3Sm6yW3T6hgx83fi3GoOVsvyCJ1SQqWhZeJpLVqASq
         IK3iEIMdrIHv7/3Ea32/MCR13k47btisQdWQGcEJsom+THLNtqO70IX8a25AcRoXtq1j
         OcHuEufKpvvE+YOQdjZEYIQYUekmIZl39Tgp4QjIy/zKSAu48DnwtM8OjDinycJ78fmC
         oY/cDxk+jhJSoXqvLiGRWwHiz01rKH27fYMdFz3siVFLuGQhdl/Bo7ArGeZ/4KgNOhEg
         8cO6Z6CwT+WukollXmNXmcHriqAIEIsILYwgqfJLXlfqz5k4/R1DpiJc7RFOxAC3uP/h
         XXKg==
X-Forwarded-Encrypted: i=1; AL+hErGqgKjksB5Sfo2PHd/6UHBEweAOT1QJ7MiwoiOPiIDvEBDKzngpLR3Th9vggVjRJyjq7lv6dw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+LLV/Qlp40HOvMtqyUvwXCJC7Kuxco40znNJ6OkleSp5bX/n04
	EJzp1BAlhA96p9xfbPzP//qPCGHZekrOuLHjGNUldMwpXdEW7Q3MdpLBWVWVSNzmwQ==
X-Gm-Gg: AZFdTZdUyWAP2WSWAMXxnj7ehnpmGCy6ypuVKyG5GMn1/UP153jDCG6mXGefaQcDAD4
	jFZL2Nd8GTyupdZFpnwuOxjGyqhbmYLmw+7SP7gAlSXrnNRvIDbFY6FRe6lt3ZL/CfTRf9plRsu
	9W0bu28RUyC55NPMgFk9f/wimXKEpWO/maY9IsCFR5k4yyCN/7+C5DKJCfPLaiAOMwXRT4GXxO2
	CXYv1+b/TPSgAxEq1ClTmh1QqviMU3qNBO4kfp9EaBRGShE1EOoo1BQ0hwNJRd9UiKYZwAMshVO
	qlYbBb0CAniydS30OttQRfZcGi24XOrU8Nrh9cjhQ81jrPGZ4YAruyZ29k+Vu+z0dbRiArmrNvE
	vdXn+DHLOlmMfDNdPsTFzFZ4UGbYUINM4OQXDlI+yb4T6gkJqDRc3xheCe/0Pi9BXqKfbJTyKIO
	4vj08y249jRIV8jnfwVfequ9K+Z0vi7moK+rE2knXf4G/92th8JJULBYuExukz42SMBI3GtEvRD
	Q+6nbXyjiOSMa2+zTbR+F39zPauTbe4fNkqP/rXvN6+pkDgtQCcdnilROr2tS8eYMD2jUKSyn9k
	V2GSmiQ1aV7GeT5kX8U6rpsTzp2+XCjGwKCvNtwL/R0N2aJfdpROBmnB3QybXSaZ7/9TjG0kSs4
	v/Bw3PXI9IaSoLaYOTL+mew==
X-Received: by 2002:a17:903:1a2f:b0:2df:42af:2f9f with SMTP id d9443c01a7336-2f06244fc41mr646965ad.1.1795205058450;
        Fri, 20 Nov 2026 12:04:18 -0800 (PST)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03ee84294sm18409345ad.9.2026.11.20.12.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:04:17 -0800 (PST)
Date: Fri, 20 Nov 2026 20:04:14 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Jiahao Xu <xujiahao@cmss.chinamobile.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, David Hildenbrand <david@kernel.org>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, Kevin Tian <kevin.tian@intel.com>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzbot+7666ed2c3d42196bf7e3@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 2/2] iommufd: only hold references to files
 memfd_pin_folios() can pin
Message-ID: <awCntbf8pgcBZcg2@google.com>
References: <20261119163531.788514-1-xujiahao@cmss.chinamobile.com>
 <20261119163531.788514-1-xujiahao@cmss.chinamobile.com>
 <20261119163531.315791-1-xujiahao@cmss.chinamobile.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261119163531.315791-1-xujiahao@cmss.chinamobile.com>

On Thu, Nov 19, 2026 at 04:35:31PM +0800, Jiahao Xu wrote:
>iopt_map_file_pages() stores a reference to the file passed to
>IOMMU_IOAS_MAP_FILE in the iopt_pages of the new mapping:
>
>	iopt_map_file_pages()
>	  iopt_alloc_file_pages()
>	    pages->file = get_file(file)
>
>iopt_release_pages() drops that reference only when the iopt_pages is
>destroyed, which for a file mapping happens while the iommufd file is
>being torn down.  Nothing restricts which file can be passed, so
>userspace can map the iommufd file itself, or a vfio device fd bound to
>the same iommufd, both of which own an iommufd_ctx reference.  The
>reference graph then contains a cycle and the file, the iopt_pages, the
>IOAS and the iommufd_ctx are all leaked; kmemleak reports it as
>"memory leak in path_openat" with the holder taken through
>iopt_map_file_pages().
>
>Reverse the test instead of trying to enumerate the files that own an
>iommufd_ctx: accept only the files that memfd_pin_folios() is able to
>pin, which is exactly the set of files the mapping can be built from.
>file_is_memfd_compatible() reports that set, so the same test can run
>here before the reference is handed to iopt_pages.  dma-bufs are
>unaffected: they are taken by the dma_buf_get() branch above and never
>reach the file branch, and iopt_pages holds the dma_buf there, not a
>struct file.
>
>Fixes: f4986a72d6e4 ("iommufd: Add IOMMU_IOAS_MAP_FILE")
>Reported-by: syzbot+7666ed2c3d42196bf7e3@syzkaller.appspotmail.com
>Closes: https://syzkaller.appspot.com/bug?extid=7666ed2c3d42196bf7e3
>Signed-off-by: Jiahao Xu <xujiahao@cmss.chinamobile.com>
>---
>v2:
> - Call an exported mm helper instead of shmem_file(): shmem_file()
>   became an out-of-line function in mm/shmem.c that is not exported, so
>   calling it from iommufd.ko failed at modpost with "symbol 'shmem_file'
>   undefined!".  Reported by Jason Gunthorpe.
> - Use file_is_memfd_compatible(), renamed from
>   memfd_pin_folios_supported() as suggested by David Hildenbrand.
>v1: https://lore.kernel.org/all/20261119104417.459962-1-xujiahao@cmss.chinamobile.com/
>---
> drivers/iommu/iommufd/io_pagetable.c | 12 ++++++++++++
> 1 file changed, 12 insertions(+)
>
>diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
>index 5ac736cf5..c9aad275f 100644
>--- a/drivers/iommu/iommufd/io_pagetable.c
>+++ b/drivers/iommu/iommufd/io_pagetable.c
>@@ -515,6 +515,18 @@ int iopt_map_file_pages(struct iommufd_ctx *ictx, struct io_pagetable *iopt,
> 		if (!file)
> 			return -EBADF;
>
>+		/*
>+		 * iopt_pages keeps a reference to the file until the mapping is
>+		 * destroyed, so only accept the files memfd_pin_folios() is able
>+		 * to pin.  Any other fd, in particular one that itself owns an
>+		 * iommufd_ctx (iommufd, vfio, ...), would put the file into a
>+		 * reference cycle with this iommufd and never be released.
>+		 */
>+		if (!file_is_memfd_compatible(file)) {
>+			fput(file);
>+			return -EINVAL;
>+		}
>+
> 		pages = iopt_alloc_file_pages(file, start_byte, start, length,
> 					      iommu_prot & IOMMU_WRITE);
> 		fput(file);
>-- 
>2.43.0
>
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
