Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795205038;
	b=i0BmYukEgauuSnQ2rvxXFPdT7u0zRRj6L5tC90Rk06B+qxBnJ/9WRE62n+kiBI0y8KQO
	 LOxAPQN4LzyH7ctYNX/5uPXRDfb6b188xrEAXDmoglh4/a5TB2uS86CqhzWeDDm97J9FF
	 7QftucX2tkWj0cPlsPg6sHr6Lmyh4hBYcEv/TcfNIS3ow/ciMKHij+tfr7wLtFZa4MCTK
	 S89aSkqnrkEfrk2Wdvvn1w0f1vr7ZySBI2jx7USQtxT/WZ1cKo+z2glJzTYixulPZya/U
	 HQkAykjC0VBe//xtWfyTlBif3/we9/f2Foro58npb8F4oqapBneVQiCrsGBBgUVWGJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795205038;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=sJNN+wbVdYmGniuurEFfsOta20znKmxlY/TD8nCl7To=;
	b=vO4tjCc0UoKk9qUjVs/adgyXvTBOMdOM9JBq43Q2zR9kYJHWNXsnsWBE4UrUOHkAwg61
	 wiqsf12x7+MjlkTH7Eb4D/JrYY/0CkqFCivCW/2a65xtS4RHjpyLcM0Nt4DAvTqvJxPKl
	 aw1w2E1bP3Hbi559ccYYUCeIuqVtDCs7aRr1LNq+2JN2chrpYQ9RILskqQ3Hja8x3Wm1y
	 9yyBcDQdkFx6j3KPKDoEwvA2ENkP6ze3hz7y/YEaF90ppi+BBw+4VvbIdd66F+J3V65Q5
	 omnZKut3J9enYCyeagCzw7wu9LzwpZWkZzpkMykgTx/gaPvnuZip9icpFBRusoCBO8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SMmmKotl;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0C2606A335
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 20:03:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF0C2606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SMmmKotl
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2f048bc09d7so15425ad.0
        for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 12:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795205037; x=1795809837; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sJNN+wbVdYmGniuurEFfsOta20znKmxlY/TD8nCl7To=;
        b=SMmmKotlztpdvv0XnJaikWI69B3PoESMJCfTWm+RES/Wkfb1HcbyVBQ7XQZcyx31JK
         ZhapGQj7vZ7AG9d1N+/9wpOTr4e8dWWywl/H3BKyI0Tpxoo4LvHkPqMEyiPsXQHYnQfL
         ncrG0btRQF4ArvKLhzBm8toVfvmhK5fqza2yVimhIykbNg47BFYkhKSQV6ArqtrzcaUS
         V1YOkJzmtndXuT5V0AgMX1k75xvgL+V1ufYovuHFVt7LlRJYm3/dI8gknTR+BVupYkvl
         ZPcqA8Lr6R7JYBeFuAeS8idXKgX91YaOqlqg8yU0wLv9Z9w0MYjvuLn2n+a69UzgADxo
         Y8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795205037; x=1795809837;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sJNN+wbVdYmGniuurEFfsOta20znKmxlY/TD8nCl7To=;
        b=WEB33dzhdjyxDeQTX+geVJtGnQP7HqBi6m/vJ8JhjPwyzwOxFDIqMrVRQloJtNYeKp
         kcvaZb42oozS0UPEXq+pGPBld+2pYWTxog7H/ttrDZu6VqES7f0wBZYABtkeBUT+Fzk4
         S2mcyfE4E6cJ3UmU+dCA0zVCVGIDOFlCeL67aah+nMlRmzLSfzUotzY7oR4lKB8K2LTO
         ZFCexPPxzuIBBPRM21KamEl0eIXhhGA2ZhpKTjCDCKqFhKqWG+kuTrXwPIDnKtaY6yCK
         xEHJFXryCQaPW2EMiSvOgFC945hZV7klR7d1qKmUftNLzOA0ioRxhhy3x+LUFytyi4Ev
         Mn5w==
X-Forwarded-Encrypted: i=1; AL+hErENT8mfsHrfPBHByIBa8miaCjkZ1wUU6HSvqpNRsprsswCENfGCcHRzIlmXroX/qycbbV+jWA==@lists.linux.dev
X-Gm-Message-State: APuU4Z9XAqf+KWe0mlHaLdzZWD3wFXQETvGoUUAqkSOZloIpUC49cLpB
	50yHOwD9Q/xhXelf5NQEGDq3jadrH2jE1xzl5frrRC9VRaGhUBhnGPodtlxxW5Hglg==
X-Gm-Gg: AZFdTZe89XvoEhqJ2PTnsDNCGqO2ScBYoBP9e0xlW4brN9MNpc9xm47RGE8ERH7eZVg
	zkKtqQyYB8ttdDmMsZZy+GCd7aLvxP2sZxc/Z6kCtKItu1KIlHUp1hDVTYa1xl0LGBnWfmI/o1C
	sTmpkO9Wg1cq+20y2Rzq+QsDMWiOfB1Vr4nrURSKudIjDI8XlBq8M9kANPTjpTjNPCsKg8YP9T9
	QiKICM/JrlUAf0vRdjnHgLk0+0dEc8NcA1vLj//4TezqhuJ0D0lfZUyv48/71YRDPI8Wwdgid4e
	LzlViZZ2S+dRbAWmSV+5evwLp6KGIAJOHhp+awOurCr04qKrGDGihdhPasmFbWQWkXOdhpbLnMW
	DwNdtgPIAJu4IqELcLwwPyhYXVdwl8tPGMbmzWTT9PUvBDdsARbHkFrj7eO+8kmmc9j2yPQSBE5
	wwj1erV2+WdEaauASgyxBD+2L2n+kyQxthRzhs1ciQCf5po0I9Lp7/ET7WV7dYNpYUEhflmIpB5
	hXNnp9n+izEYIP6ALzmf90QPFivjbzEY/AqYP0xmL5g2zemr3vfOCO7S03OYRQJYKm+7+gKyp5e
	aGV43F69TBmmeG0XybIheGYeoSyGS37OPcJl1VRS+OAF3UrqeDxmZTWBSDJR1uEWLfrXkCpqieW
	MCCa/XV0/a1M/G1VJ8xmtgA==
X-Received: by 2002:a17:902:f70e:b0:2eb:19f0:6e2a with SMTP id d9443c01a7336-2f06242bd5dmr601345ad.8.1795205036492;
        Fri, 20 Nov 2026 12:03:56 -0800 (PST)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d63728sm9122188a91.8.2026.11.20.12.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:03:54 -0800 (PST)
Date: Fri, 20 Nov 2026 20:03:51 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Jiahao Xu <xujiahao@cmss.chinamobile.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, David Hildenbrand <david@kernel.org>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, Kevin Tian <kevin.tian@intel.com>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzbot+7666ed2c3d42196bf7e3@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 1/2] mm/gup: add file_is_memfd_compatible() helper
Message-ID: <awCnnKfv64IyriEW@google.com>
References: <20261119163531.788514-1-xujiahao@cmss.chinamobile.com>
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
In-Reply-To: <20261119163531.788514-1-xujiahao@cmss.chinamobile.com>

On Thu, Nov 19, 2026 at 04:35:31PM +0800, Jiahao Xu wrote:
>memfd_pin_folios() accepts only shmem and file-hugetlb files and enforces
>that inline with shmem_file() and is_file_hugepages().  A caller that has
>to know up front whether a file may be handed to memfd_pin_folios()
>cannot use those predicates: since d3710111839d ("mm/shmem: make
>shmem_file() check the file's inode") shmem_file() is an out-of-line
>function in mm/shmem.c which is not exported, so modules cannot call it,
>and is_file_hugepages() on its own is not the same question.
>
>Provide the check as an exported helper next to memfd_pin_folios() and
>use it inside memfd_pin_folios() itself, so that a single place decides
>which files may be pinned.
>
>Signed-off-by: Jiahao Xu <xujiahao@cmss.chinamobile.com>
>---
>v2:
> - Rename memfd_pin_folios_supported() to file_is_memfd_compatible(),
>   suggested by David Hildenbrand: the predicate asks about the file, not
>   about the memfd interface.
>v1: https://lore.kernel.org/all/20261119104417.312237-1-xujiahao@cmss.chinamobile.com/
>---
> include/linux/mm.h |  1 +
> mm/gup.c           | 23 ++++++++++++++++++++++-
> 2 files changed, 23 insertions(+), 1 deletion(-)
>
>diff --git a/include/linux/mm.h b/include/linux/mm.h
>index 040cff643..dffcc0b5a 100644
>--- a/include/linux/mm.h
>+++ b/include/linux/mm.h
>@@ -3600,6 +3600,7 @@ long pin_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
> long memfd_pin_folios(struct file *memfd, loff_t start, loff_t end,
> 		      struct folio **folios, unsigned int max_folios,
> 		      pgoff_t *offset);
>+bool file_is_memfd_compatible(struct file *file);
> int folio_add_pins(struct folio *folio, unsigned int pins);
>
> int get_user_pages_fast(unsigned long start, int nr_pages,
>diff --git a/mm/gup.c b/mm/gup.c
>index 7605da0e0..da8a2c29b 100644
>--- a/mm/gup.c
>+++ b/mm/gup.c
>@@ -3449,6 +3449,27 @@ long pin_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
> }
> EXPORT_SYMBOL(pin_user_pages_unlocked);
>
>+/**
>+ * file_is_memfd_compatible() - check if a file may be used with
>+ *				memfd_pin_folios()
>+ * @file: the file to check
>+ *
>+ * memfd_pin_folios() only accepts files backed by shmem or by hugetlb.
>+ * This is wider than "is a memfd": every shmem file matches, not only the
>+ * unlinked ones memfd_create() produces, and file-hugetlb files are not
>+ * memfds at all.
>+ *
>+ * Callers that have to validate a file before pinning it, or before taking
>+ * a reference to it, can use this helper instead of duplicating the check.
>+ *
>+ * Return: true if @file may be passed to memfd_pin_folios().
>+ */
>+bool file_is_memfd_compatible(struct file *file)
>+{
>+	return shmem_file(file) || is_file_hugepages(file);
>+}
>+EXPORT_SYMBOL_GPL(file_is_memfd_compatible);
>+
> /**
>  * memfd_pin_folios() - pin folios associated with a memfd
>  * @memfd:      the memfd whose folios are to be pinned
>@@ -3493,7 +3514,7 @@ long memfd_pin_folios(struct file *memfd, loff_t start, loff_t end,
> 	if (!memfd)
> 		return -EINVAL;
>
>-	if (!shmem_file(memfd) && !is_file_hugepages(memfd))
>+	if (!file_is_memfd_compatible(memfd))
> 		return -EINVAL;
>
> 	if (end >= i_size_read(file_inode(memfd)))
>-- 
>2.43.0
>
>
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
