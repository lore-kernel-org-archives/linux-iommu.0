Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794880715;
	b=fLPYeFhX7hhUWSWG4EGGWOpoUMscBQ8LRPQ/TwZvWdtoG0U0LzbOW49TIUSn2wgzbXQc
	 SUQLjP6JaOWcp7VoYX0wa2s9TmjsjIYD1xI747MYidBv1NVO+QsH0y+y5vUQDg5KLLY/L
	 y190+nHSuypu3RVrFjIAQvDDcYDNDl33vgrCbvIOyC2HSPuXRGJFaR6iYZ60MxixdDm/x
	 oRvfYSrqSxj/VvPR35DMhcdXVsfdDvg6TdA+oRQCpvSejjfj6oPw+6+yKrMM1YiaJGAdd
	 CJhZPDd5MurZjih4cD0a9epHJbKwiT24gnNwL9hSkDOyNh/dRjp3SjEDM3RbG5XUMxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794880715;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=0lQuCGK3lhHseavPhy99usX6S5axUhc+gR6oEzHkYlA=;
	b=jQdv5zq6SIa+PgFYS7pIfpA7uC6U1Yt69uIw3ayi3UcbAp+5FKbpUk3Qu+beSooepxeu
	 krMSb0lN3P7vfjkJpeqRTC0TBMoP7WsRM7uFflKqUgaQxHIhk/g7fRqtF4ciRIefT416Z
	 qAtiozsnnE5m8tItua0mBXxrvZvuI+AQ5lf2L2JSLHZlKwM7Uwjk7Tv7v+MnbPf2IX6Km
	 hK21xPcKOXFY8nWm3/So4XPehwmqiGUjPExJXXnt3WPbPn7gYRrmBf8fYBlUXEtQgZJPV
	 hf9Au1DjnwdLr5qVH+ERolSbsc3f2aHEbCmBvY5A9SxzI7fEJgMmq716xxj1YZJvrHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LcIgGjb0;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543D9606A323
	for <iommu@lists.linux.dev>; Tue, 17 Nov 2026 01:58:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 543D9606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LcIgGjb0
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ed3f563739so31655ad.0
        for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 17:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794880715; x=1795485515; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0lQuCGK3lhHseavPhy99usX6S5axUhc+gR6oEzHkYlA=;
        b=LcIgGjb0Q9vcIui5tjFwpA8FEV7itFGq6qTrggopZXw7gk6OobsLhcvXYLH0t8Ctkm
         Z6xXbAVQbOqcztXOoJ1Z7Y4nUMLv/LgcnkAW5WcyqS/ZJZHCemmPr0MbTAp60YeNzry5
         3KjkauauWf7EsjtyyzWVfSPSmrThiBWWmD+9WdtSfNR1LoWS86ao6qh3GWyNsREl1ghj
         rQOMnxD9ICXJjoHJRSRM5IBJQGReVX1Gam2K/876EA+YEaA7WgvcnZ5orKgGHGVzL1WZ
         QPWppM6bwH7oKHZhxxoHSUgil6QY4w56ioC7QkHGTSx2Z+uLMW4ur4WJqlDMoxMXmPXE
         SPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794880715; x=1795485515;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0lQuCGK3lhHseavPhy99usX6S5axUhc+gR6oEzHkYlA=;
        b=uFRBI8LKeE+4ggIEgDyuD6mzyZZmjN2BY3OqOQIFijtU2WKBHQev/h+m1pYOWHQc+m
         a1Q1+7eHwbHVM+b6l4Dx5tfmZPNl0/LlAxHT5qZRlJCZVHOBgvT/LEQQIWPsAq0moeGv
         iKtFd8ZDWWqG/ok85/ap3rRl3bYWrQCfaSBRZ04gBz7WzLVCE6NW9ymvXp0Indp8NdZV
         z+udSqkMb50s4ZK0ppCfgKauUmhD09SwzqyHWA51ocIipbmRq8S0a7CfZZbwpYPk0YS3
         tjIdsehib52gLp7ZHzQ8IiMFGFxB8nSllVbCL/t8DGZNspU9KfmJ7n8/lqX7eePJ4D5O
         8OkA==
X-Forwarded-Encrypted: i=1; AL+hErG7MKpdC9XStb50me3eEMG0MRdAh55HOnajul9uHKK2XCvP2wafM4ic/+s+WWyrtrYQCFG+fA==@lists.linux.dev
X-Gm-Message-State: APuU4Z9LC7SAxOaHjCong4psf3QVHs3ICdTUjKH+jljLISMLB+w6ZbL2
	NG0BHdDvdoCbgJpRtLjDO3nd31rgmk3Y+dRFACXrmvbWlIlC1WX65OWoaEcR28ztLw==
X-Gm-Gg: AZFdTZeazvJbd3kJpoSWiZnWNdUaZdbK/E589rPDhdlDik+T9KzYpKwDV4IJO5dPuAY
	D7s5WbvbPQxCD55oph7272FDHVtL5gLmBMb10R2y9QPtyQowwKbe+eI3S7nEd46chQRRIADzERz
	I2nSrQgS6camGD8Y2LpQaQY3Dgh60onDxDviQOHkgOnL0AyRuHbJE6vVlWkJv0FVBVqDh5f3C6m
	hJXeEIlhOXPhU6wsuRFjHD+BVMVlZFbQQZaLTTMXk5VUY/PMq56hAPpAQ8uANC80KD+i2V+tsgM
	Vdt0zonEWgkmtTt6nuA5bIJxVfw7UnkbvqSTmch7W9O4h1/uT0WUDqT61xnMFQzsoB5HauWs7NJ
	CTQ9yjxE74F/0D8mmywJCQBO32shsFzCAgnPVXzRTSVqUtRS2FMIGXGaFH/7jqYD9imHdFZo6hK
	+P+IJszxQgxOL4v5oZYiXzLuBqoPGM8OIdKgIpdUFIK0cQaL4P5skzKYnhkWB0ImPurdbr0Z658
	NU50YRxpFNUTc3VEKyNjzDHSiCtOvTxjWMCgS6ds5KK+kNi6xnOVmURW7ZMQE11w1QRu+h42NnY
	cSBEWGxOfsK4xPuD3UhSIecPPyc4rr515M4Zp7mQuTS+sj9ZwvusJLIQHsm4SpgFsDh05spCwLi
	xS4mazuODGB2CkprtpRFWKQVJ7CiSvsexGfnqf9Oo/OU=
X-Received: by 2002:a17:903:2310:b0:2d5:db38:8010 with SMTP id d9443c01a7336-2efdc8414aamr1929805ad.15.1794880714150;
        Mon, 16 Nov 2026 17:58:34 -0800 (PST)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3b3f7ae72sm493783a91.10.2026.11.16.17.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 17:58:33 -0800 (PST)
Date: Tue, 17 Nov 2026 01:58:30 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Jiahao Xu <xujiahao@cmss.chinamobile.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, syzbot+7666ed2c3d42196bf7e3@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] iommufd: only hold references to files
 memfd_pin_folios() can pin
Message-ID: <avu0mxBDmm_nvszH@google.com>
References: <20261117093244.652569-1-xujiahao@cmss.chinamobile.com>
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
In-Reply-To: <20261117093244.652569-1-xujiahao@cmss.chinamobile.com>

On Tue, Nov 17, 2026 at 09:32:44AM +0800, Jiahao Xu wrote:
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
>memfd_pin_folios() already enforces
>
>	if (!shmem_file(memfd) && !is_file_hugepages(memfd))
>		return -EINVAL;
>
>and both predicates are inline helpers, so the same check can run here
>before the reference is handed to iopt_pages.  dma-bufs are unaffected:
>they are taken by the dma_buf_get() branch above and never reach the
>file branch, and iopt_pages holds the dma_buf there, not a struct file.
>
>Fixes: f4986a72d6e4 ("iommufd: Add IOMMU_IOAS_MAP_FILE")
>Reported-by: syzbot+7666ed2c3d42196bf7e3@syzkaller.appspotmail.com
>Closes: https://syzkaller.appspot.com/bug?extid=7666ed2c3d42196bf7e3
>Link: https://lore.kernel.org/all/20261112105945.285526-1-xujiahao@cmss.chinamobile.com/
>Signed-off-by: Jiahao Xu <xujiahao@cmss.chinamobile.com>
>---
>v2:
> - Replace the iommufd_fops blocklist with the allowlist of files that
>   memfd_pin_folios() can pin, as Jason asked for.  This covers a vfio
>   device fd bound to the same iommufd, and any other fd that owns an
>   iommufd_ctx, instead of only the iommufd file itself.
> - dma-buf mappings are untouched: they are taken by the dma_buf_get()
>   branch and iopt_pages holds the dma_buf there, not a struct file.
>
> drivers/iommu/iommufd/io_pagetable.c | 14 ++++++++++++++
> 1 file changed, 14 insertions(+)
>
>diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
>index 5ac736cf5..4d10b2253 100644
>--- a/drivers/iommu/iommufd/io_pagetable.c
>+++ b/drivers/iommu/iommufd/io_pagetable.c
>@@ -15,7 +15,9 @@
> #include <linux/iommu.h>
> #include <linux/iommufd.h>
> #include <linux/lockdep.h>
>+#include <linux/hugetlb.h>
> #include <linux/sched/mm.h>
>+#include <linux/shmem_fs.h>
> #include <linux/slab.h>
> #include <uapi/linux/iommufd.h>
>
>@@ -515,6 +517,18 @@ int iopt_map_file_pages(struct iommufd_ctx *ictx, struct io_pagetable *iopt,
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
>+		if (!shmem_file(file) && !is_file_hugepages(file)) {
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

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>

Thanks,
Sami
