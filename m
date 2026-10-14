Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980C2568FC7
	for <iommu@lists.linux.dev>; Wed, 14 Oct 2026 18:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792001721; cv=pass; b=TfZtnwT4R1hvDldLnqQq+v3gEQvfuOAmZ+bkT2ZCXR5Q3KcEEVAuBb2a0WYx2bb8CP9nk13dJ0pHpqDHS/oa7vCGy+mEgba20BLdv/QwvfXufWPXEZBxM35ARbe6/sMKwb3B4X61BFW4cH7KhzcRd+LssWQXMv49nDouIRNjhCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792001721; c=relaxed/simple;
	bh=ZDeZDQJcijxdIEcisFFhzJK1uUV77Ej4r8MxO3z/x0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZaBmKT8Z469nXR+fPBmCK55D+Zx21+0zY4chbpGcGufGgFNC1VM1Cd3scnx6vzQtSRJUch3mK/eZjtxqezdDnhpGjG3+OtD3bZFw6mqjrlj7CblRnQIOXf8BCmLwLDvDo3mnHQRlRH0IHk4gjBSajeTUIYDSDH7lYE7I9YDphEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M7oLYk6e; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M7oLYk6e"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e8623790f8so247815ad.0
        for <iommu@lists.linux.dev>; Wed, 14 Oct 2026 11:15:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792001719; cv=none;
        d=google.com; s=arc-20260327;
        b=YvZWoZIMScBkGdScelcZk6Qr7mx8i9On35YnSyUL8FHHxIY+9Xd/gkd4mt14Ulzbll
         dCJWydaGO7XRJQk8FQBOTie4/sRAfBcJp5kkPF6PuiNLlRJBTM7ahI9tgyk5lgF9yllj
         pXG6dQ540KXf5OYj+zGxXGAhOsPVmbBxFownEGScLpIzSNJYnoPqGd63mNmPBAPnz7It
         irxU5PP8e9QINzj1VDdsbpF9Z1zFlNQcnbrCoZECXer64ecRMYRYm0EJBfINsr34O8ut
         SDmI4Mog7tN8nOyz7EzvkSKFjvx8raDhJWv4Z3rlOnbVJqx1+zXIbZFM/+CUzt7dMfvM
         /ceQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ukWxxq7IJoiKFikFQrOXvwgn9jZTFnVv2R6ijBLFQBc=;
        fh=TOH0RSw3b3KYqw6amCFpnNF42QlG4IULyRLM+/rgzhs=;
        b=ZlQ38FOQemcbOD+4sKXC0AizU8t0nnXt6Xw2JifBpFpM/ojtLzrnW1UogO4p1Vc3fY
         5oUmcNyWX+CBjIYskBigRmZQjBQRl7/LwXWesGqXgRorCVaOxg2TNdSFX8gllvfhmal4
         5aPkRxmb06xY0ScuIS2pKIr6tDqNePu0ocmJQenNcdJR65WjMPH/fGElF2/OwNKvm66A
         VjjIyVDCSqMKEdFECgrZjWjOWSClznTNKdAeIW35aRXavdxvEuuFwEzhzszgH4Z+dLuP
         DcpXZQ7yH81v7fIrsrx1AOLRHS2M+OpD0SfipTexXtBhchxqF6yH3giJMr/0DWtxYLwE
         xrKA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792001719; x=1792606519; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ukWxxq7IJoiKFikFQrOXvwgn9jZTFnVv2R6ijBLFQBc=;
        b=M7oLYk6eIJGZ5/iBSgm9STMoCE1bHjlRYRBi1vofgBwsASzFpRaEHa830Cocltc/gV
         F/qhAhdl/ukTyPuvfuWVN4iTipxysjhjSk7jaSwL8cmSwQyJBx7o+jhAdhwPzjBg1RRU
         1dC7W/YBH0ehTMIN8hMsuxVZ0KdNCn/epyJ2P/tbjNAh1XwLmd87scZH2xETxFLG27dB
         W5Cn4lQVQ0jKjf0FdEeP9Xnse4GIuimhjG5eGCy/5vkqEnKpFaaBLjDCBB8ZngBxVFkF
         Wgko2oEbFQjO6jRS4K3jfkK4KDXwKo8CyUkI96e8LLGo+QQe59Dwo2JhkdaEWuWICv0J
         qdkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792001719; x=1792606519;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ukWxxq7IJoiKFikFQrOXvwgn9jZTFnVv2R6ijBLFQBc=;
        b=Nv0P7uYaU36RBGRZAqysAru6fAmLgozbH0Yyb9oOsaPU76a+obhuITGJdJFchKyTe7
         /WAjO+ETLXeQbbRTxdNxotKgEM93d8HOvs/t1UcLwOCfHSkc9F1idUHSxNg7be2Ed2bK
         HXfU7bvVlsgxprrZGoA8O48sPRl1AwLBJGnnj4ea9HYIiD+JMAv48nW5f2hKPAASw85P
         1XZ2M59zJt+5b8jytBjroFvgVOeM7XY0uz3j1ay7jzP8ZsMUPEOIQOaeCD1oh3i/15fV
         sbe1qDLg6d9Yz+SiBn/6ttmqzscx2EZjRsmGgW2C/7kgwk5e892XxnLMF8BGUCykynFF
         nhVg==
X-Forwarded-Encrypted: i=1; AKwUvByzdW4COtlWFDs5am/O5vtWmxzzxgO+9ex1DJZqxUGHFM5t8qc+/HNlXQR+2XeBhfp4jMCeOw==@lists.linux.dev
X-Gm-Message-State: AFq9FYKGPMp8OfAkOQYwKfy0QGQdNSy8Z8LfUX3Vjx3d+NqzxNydipYg
	pR/LinNrup2300G1IvJS0HI5uba3ZQOq14hnn12MeFfPWM+xjuMvxmeXq9LKUcGHkWSHG2gB07c
	V+AzCHPwkPhYz0pIxsDP+hISaqpFREJEgcgdHD/9F
X-Gm-Gg: AYBFou36e1JtMZvUTsNl3Brig83tEpU/zyV8Gc5x4CMFMxhSiq7GAZ3gCWxZcmWuDvD
	mgnnA7DNOcSPTn0ewnRlxJzRkGPwrGGq1aYLk5JygOVeIRD7V3I8NcCJvMdgg48MmBOuU0gzybF
	IS7y5SPO6WrbW828bArXaVCl3KK2rs1Gr3s1rhedm9xvbRKfXUU65VUe2i/UfcW28iOvMvImz0F
	bh0uQKx/XZGHR9kEbXvrE8BqbVIM2hinsQDByifmWf1G8djvE1I7IFWfzDsPXXgvATX4PoMyvkw
	pag1fXGMEaWs+PWx6ZlJRpFX221Cumpaphe+JXf492Zxg5feduVkOsuX
X-Received: by 2002:a17:902:ec86:b0:2e6:1013:ad57 with SMTP id
 d9443c01a7336-2e939d090a3mr4279565ad.12.1792001718105; Wed, 14 Oct 2026
 11:15:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261003212241.3432303-1-lrizzo@google.com> <8584c31e-fd93-4f1a-9929-e71c5d9ccd0f@nvidia.com>
In-Reply-To: <8584c31e-fd93-4f1a-9929-e71c5d9ccd0f@nvidia.com>
From: Luigi Rizzo <lrizzo@google.com>
Date: Wed, 14 Oct 2026 20:14:41 +0200
X-Gm-Features: AclHuK9G3FSCwwu9o-cWYwZA7nUn_K71LEEmvdGinw_0nCstr-Fs63NFljz-hj0
Message-ID: <CAMOZA0JiGhVmc0PXajBzha3cBY-sdc3pz8eLCCbt6=hmsEh65Q@mail.gmail.com>
Subject: Re: [RFC: DMA_PMD 00/22] DMA_PMD: PMD_SIZE-backed IO buffer pools
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Luigi Rizzo <rizzo.unipi@gmail.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, David Hildenbrand <david@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, iommu@lists.linux.dev, netdev@vger.kernel.org, 
	linux-mm@kvack.org, driver-core@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 7:28=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> Hi Luigi,
>
> On 03.10.26 23:22, Luigi Rizzo wrote:
> > Here is a subsystem called DMA_PMD on which I would like feedback on
...
>
> Thanks for the RFC. Here are my notes (some points rephrase what was alre=
ady
> said):
>
> - On CoCo VMs it seems that the only way to opt in the IOMMU optimization=
 is to
>   also opt in the copy avoidance which is not always desirable.
>
> - Having the pool generic opens up more visibility from the untrusted hos=
t
>   side. Having device based pools at least isolates one device's memory f=
rom
>   the rest of the system.
>
> - Also, device driver could help with provisioning just the right amount =
of
>   memory that is needed. And per device control also means that probably
>   you don't need to map everything RW to the IOMMU.

Yes on all three. I am looking into providing more knobs for different leve=
ls
of opt-in and isolation, so users may adjust them according to the
threat models and performance goals.

I am not especially worried about provisioning because the system is
already reasonably adaptive, and leveraging existing caches, the waste
the waste due to allocating 2MB units can be kept relatively small.

As an example, the update I am working on has the following:
- a lean per-cpu cache that can be attached on top of a dma_pmd_pool,
  similar to the one used by the buddy allocator. The dma_pmd_pool will hol=
d
  the 2MB pages, and the caches can buffer smaller sets, reducing the waste=
.
  Useful on the tx side.
- on the receive side, one dma_pmd_pool per device will feed all
  pagepools for that device (typically one per queue).
  The pagepool is already a pretty good cache that does not
  access the allocator often, so once again the waste due to
  partially used pages is minimized.

cheers
luigi
