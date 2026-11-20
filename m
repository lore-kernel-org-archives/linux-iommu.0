Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795167081;
	b=RxrN1Apxj4Iuoz68q+tlZqKValOXk7wRXJCKhG0bLZ3whkA2ocYHMZkBLAbnEX95RrDK
	 kzxT1nOw4uKo0GQKg0Clo+nqgPDZpOnKCp8aaO21k/OxuuDe7rpF7SD4WJTlIJTFPgwuN
	 nchckXVKX/2ZkQANJT3A2zPBY2vuKrIM5uAvRlgrVOi1XVWQBkjWK4lnYSAC6onkNICJi
	 9fVKLfD9JwuHmGfaLT7h1Uz6Ip6GD6u8zA5gfHJeCy8hV94vX4Cln2MT+yZrky8flZO/+
	 aarpGqbxWMp/n5s98VR6OlYPTDcGrA2uL+cL870mdUeQeqN80c1wg7RyzNZqGSgPOfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795167081;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=bm+fmzDzNdr8isbrhqngN9fgikR0ji/6yEcUPTWrUSc=;
	b=TZ5YamDzfEGF6t9lT25IkyfZsSxwWubUI8EvdDicCbbrspzY0AYFN8zWBl84ENjKeUhc
	 wxe+ggkuPvyylXTt7p6tOFdYQaOQ8MJKltRvR3+ukjcfurO5wJoknKd5asTidSUNRbqwk
	 6TMT+KECAbgQsZtFoCGQQabLRMmt5/BW+iB5KgDFUfX1UDlJpwMM0LYoBk+gBEcjUtRgJ
	 DhxWjk88ZCSeS2ew1R2LeKsqYoDVr08epJe8VgEGY/0PUED87jP/wwqRIun1+yJQlxgt3
	 3solGSkZR2rYYOAJBbvGdcI/rjr3IgrxTZjGXomSQ+I5BOf4uVXzlZFKrLpIfbaKDCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XtH8hZT2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9720606A32C;
	Fri, 20 Nov 2026 09:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XtH8hZT2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F321F000D1;
	Fri, 20 Nov 2026 09:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795167080;
	bh=bm+fmzDzNdr8isbrhqngN9fgikR0ji/6yEcUPTWrUSc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=XtH8hZT2dYdT1KrzhYRGEG27GZWawzgVEOX4sOsBPjKdHSse/oexrzM03xNGccN8R
	 yxAx6TgkI+sQVCfY0IteUpk6AQQNN6gRXtKHQq14yybiTfaDiPQ6YrEQNeybodZeNt
	 3nb7DgrTTWFcNv1WcgRJRZml0I3mBe+4Knd2tvnOfzbVPD0BERuikdvJYwly5P5t/s
	 pHKiNztflFXUPJGhFwSt/OFTQyIPubVHN1eFCDhmXjKCVC7XHuISf/FKSHdC/CjcTe
	 /N/oAkOIE8BIhKvKglJmrVc3G++sbwlEMiBFmhMsB53wm0Ma8u7o5vnwbIm5q2uZ+Z
	 gOxst6tEQ8gkA==
Message-ID: <3f23e91b-7616-418f-8f31-c7af667156ee@kernel.org>
Date: Fri, 20 Nov 2026 10:31:13 +0100
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm/gup: add file_is_memfd_compatible() helper
To: Jiahao Xu <xujiahao@cmss.chinamobile.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-mm@kvack.org, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Kevin Tian <kevin.tian@intel.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Samiullah Khawaja <skhawaja@google.com>,
 syzbot+7666ed2c3d42196bf7e3@syzkaller.appspotmail.com
References: <20261119163531.788514-1-xujiahao@cmss.chinamobile.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261119163531.788514-1-xujiahao@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/26 09:35, Jiahao Xu wrote:
> memfd_pin_folios() accepts only shmem and file-hugetlb files and enforces
> that inline with shmem_file() and is_file_hugepages().  A caller that has
> to know up front whether a file may be handed to memfd_pin_folios()
> cannot use those predicates: since d3710111839d ("mm/shmem: make
> shmem_file() check the file's inode") shmem_file() is an out-of-line
> function in mm/shmem.c which is not exported, so modules cannot call it,
> and is_file_hugepages() on its own is not the same question.
> 
> Provide the check as an exported helper next to memfd_pin_folios() and
> use it inside memfd_pin_folios() itself, so that a single place decides
> which files may be pinned.
> 
> Signed-off-by: Jiahao Xu <xujiahao@cmss.chinamobile.com>
> ---
> v2:
>  - Rename memfd_pin_folios_supported() to file_is_memfd_compatible(),
>    suggested by David Hildenbrand: the predicate asks about the file, not
>    about the memfd interface.
> v1: https://lore.kernel.org/all/20261119104417.312237-1-xujiahao@cmss.chinamobile.com/
> ---
>  include/linux/mm.h |  1 +
>  mm/gup.c           | 23 ++++++++++++++++++++++-
>  2 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 040cff643..dffcc0b5a 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3600,6 +3600,7 @@ long pin_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
>  long memfd_pin_folios(struct file *memfd, loff_t start, loff_t end,
>  		      struct folio **folios, unsigned int max_folios,
>  		      pgoff_t *offset);
> +bool file_is_memfd_compatible(struct file *file);
>  int folio_add_pins(struct folio *folio, unsigned int pins);
>  
>  int get_user_pages_fast(unsigned long start, int nr_pages,
> diff --git a/mm/gup.c b/mm/gup.c
> index 7605da0e0..da8a2c29b 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -3449,6 +3449,27 @@ long pin_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
>  }
>  EXPORT_SYMBOL(pin_user_pages_unlocked);
>  
> +/**
> + * file_is_memfd_compatible() - check if a file may be used with
> + *				memfd_pin_folios()
> + * @file: the file to check
> + *
> + * memfd_pin_folios() only accepts files backed by shmem or by hugetlb.
> + * This is wider than "is a memfd": every shmem file matches, not only the
> + * unlinked ones memfd_create() produces, and file-hugetlb files are not
> + * memfds at all.
> + *
> + * Callers that have to validate a file before pinning it, or before taking
> + * a reference to it, can use this helper instead of duplicating the check.
> + *
> + * Return: true if @file may be passed to memfd_pin_folios().
> + */
> +bool file_is_memfd_compatible(struct file *file)
> +{
> +	return shmem_file(file) || is_file_hugepages(file);
> +}
> +EXPORT_SYMBOL_GPL(file_is_memfd_compatible);

Work for me, but maybe others have better naming suggestions.

Acked-by: David Hildenbrand (Arm) <david@kernel.org>

-- 
Cheers,

David
