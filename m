Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794314556;
	b=KXUzwVfnKuXBkea1Ekzkj2TeiJoepA8uu3gfGiV7N3/DXx2Eq5WGCDWj3xaGhC+SN0Yk
	 mWSq4KJANMcpAPtiuabM4Ap9ieOXj6U3PmbFY7rhrb09ZkYRf4Zh3HMmO47LhtRojFq2T
	 +dtI8RW3TJPBGxReaUlmcih1d7w+vou9OvvX11pd9pgj2eFiH+TWzMjh2rH69cXvQQk/k
	 rLUYNERnHjv++XLooasMZ92YRRUa7U0vogYTxOXnSHFaQ3TBMy5meV6RQUM/+KJXvbqYY
	 ezXwJ5KXxYf8J9zZWorvKslUUcYSyjTSzyOsdlmk2qRZkmiTCUteHFfaJUPtSaZ1+5Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794314556;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=10UT92sr+vRIVo9wGLbCQyuS9MFs0Bc9LyaIXMh/H9I=;
	b=Jn96d8ihIo8iGbzqkx1V6fVqdo6szbO5LQ6Bx6v9ktdjuRlXnY8Yzn/tDRShbm1OndBm
	 3D45B8zbiVEdgJcFYoQNwe9rYrPVgU9++y1HgHKUksgMftPAdGoaSyln1HjGvPwt4z6pb
	 1IrAb5fhl5GkToMRLK/oU9tcguE96FBZ+60/GSBgobmhgza0DgHr5HTNpwnwPFjuoQWp5
	 LdKBQykdGti6dpjC2pewnKHE3y4ekbREM8Kdwn3uNaWWClDKgnZz56hEvIlLerqG1Osfv
	 AwcIymW1dKaH7LnODZKSr9jrsbr6xOletzaAI5KNCzmh5dy9EgN+hAnOwyqIvw0rjrQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=scd6oIhE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56401606A321
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 12:42:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56401606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=scd6oIhE
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-91ef011e338so9614556d6.1
        for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 04:42:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794314555; cv=none;
        d=google.com; s=arc-20260327;
        b=raa2RpxEKQW2VL8XGU8JgpxGcucmDPYXl4VeF3Bo4fB5nmz8TDPRQ905UZvgFCgJKW
         0MqPVpXmk49u84snrQz2DyICrHK+v4JfrV//QA7EHQ2qrTkOHgh6wDFj2/YtbHUmHAVJ
         WmHg2es9A24zAV/Wl2NfqEPUyFAFHI6IMshp0Wle8jLeuSqCl6FETK6aFkFhE/6lcMYU
         QS2gZQx+9CGO84dD7gttfbPsIrFIbnR97rVu9cap3osf7u97Pz38ZNx2ThsYxfPhl2Cc
         VKmTscJtqbsSOj1EgXmYMU6tDSwf4WZ7BRACD+f4iPxdjGm+/mjYIrCyXtuOFMc+ez8o
         XMzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=10UT92sr+vRIVo9wGLbCQyuS9MFs0Bc9LyaIXMh/H9I=;
        fh=S1kAMmqiy6Lq7SjoAcy1tqQSahwwwHWLKEwsKVTwu+I=;
        b=LdKrtsJHX/uGkjTfe7PoUU95uAxQ1ZpUYhriSAqa++XitCMB9hf8GFF+1yVW6CKtlZ
         +5SbbdVRiQSiVeG7cHwGgBpEefpJn6oCWAm5oyUQ40mOj3G/DNOvI6K+irsFsg+QSowm
         IierXiCTEpTKrS3y9bUHIwYSPPif51N0ftIcDDie3jbtR5l3LHjb+wbjGHD4V5VC3XVs
         ZlWOK4PAKtR+CUGKTfYDyLk1KWvOFEoHyyOw2Ho7/CFQR89nUnzAW9wpN/nHp10o1hVY
         gcAQe9z4E70fGo3X9WapaUnsj8qN+QE8waLZXEne8RFGQERfQOk3vDrYKyUSKTmXVBRM
         5HDQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794314555; x=1794919355; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=10UT92sr+vRIVo9wGLbCQyuS9MFs0Bc9LyaIXMh/H9I=;
        b=scd6oIhE/6tSXCAeyGzxLBFuDC23JzowlxvoYM6Mg7s4qpQOh9+7bKhpLsWuHMho0H
         C+ePsG39A2j4xPqHCLBYbxg2UFhJPVdX4OvILPdkyPH3DovcL2IXUNsvDZhjMsgPbkYG
         odJm/NiSqGH+UJZxcjaXjJV9PJs/kYb0VC/ZK94Sm9PdXLTaku+JMWWs3yct4rsxYAj9
         HuIBqbh0KKj2fMzPK+tJntDlG9oCC40K+mdAPsLXDOc7VB4/vy9p0H9YFMz1o14lWsxH
         9SSBeD9mBf9GjC1wbBdc/5aNE1XvnCxX9cavSNoLbSsYPMLGZ+hWqrzKxQOLWCeDDSVh
         5MBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794314555; x=1794919355;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=10UT92sr+vRIVo9wGLbCQyuS9MFs0Bc9LyaIXMh/H9I=;
        b=Q8b+fy500dBDgXup2Gybz5+vjrWlpghOf4uqJvaZGv/jTsYMkB7xaHiBSjzwSim0cU
         JjB2CJ3zOnMw5oAS0rWvyR9nURJERcUlVd1Qlltsql0bGY5L5Cxmloa7lUiqdYFzo10z
         RdgdfZgYUKIXu3CZJMIwi5nvJOISPDw0xubBEnYhCJuH84xxmgmVKuWIPchxGMmU7H3e
         h4TRqI0SVCNqQNhDop3KQjv2TEwqqk8ZFbsz++xZI6//Uqn30TWdzO3Afen02i3YOZFV
         6rTMbZFdEXkl/xeZVJh9W9O4GvgTr9MgmKpSkf37nKcLMg1zL7ZKmfGvjsh00ESdwtsm
         O20w==
X-Forwarded-Encrypted: i=1; AL+hErEYVPLMejZodkfsl0bOuTBjn/Xybhrk4YWt3dCXNW6D+iezZI7Q3CjAJ2iNkJiSLDChZQ2WlQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9JBhv4dLZTtvXOlTE3bJ5JqUHndoHdil/m6J/756Prc+9673+z
	DA8Yat7YjA+nlc/y9BlpyIWlSKZnzridH8b8+ZMWGJCZYTfrKdRPZ7aRKLPc18PaddU1o5dYO+n
	wtK6p087MyNSLN9KOT7B0Z61GleanjYo=
X-Gm-Gg: AYBFou08X8ZuaK0EEFpTOwWPCNbnNvLVCghmZlChTV8vpkjIjzOrtx23S623LlzvOzb
	O/HGkRpnHiI92hfjEEwLzYihbWQpwQLtkW8OYBZ6JPFmy2RbfkwyU2YmU9xGLv9Vmk9ZH9ugcmL
	2huXahnJbywaiFSaAZBWXw7c52qfSMDPLMYEgKH+L8HSCfXoKipZT0OH5iwIEE50msHQuC9O16c
	b48ybLalLj2Qw1sxTJIttzcsBhDzW0W1jw/gEMuB1BB/yFJ1iCrI7YsYL7b/w6Stty9Xw+pdzQG
	b4FMypIQB2ONCHfzDVekTUOZPn/wXeNsTLVYhSnuwzBVN5++9CAt+pds5Y1LgXyjBsamYb/J4j7
	ybkF1La+54zKxJ1ry03O6/ygPs0J8IwyDGXkeqNXncHIuHs/oMyAfBMz9G+f2jq4J03PmlrdvLm
	1vqnXaNQGuBUWFcyplPvkJ
X-Received: by 2002:a05:620a:461f:b0:93e:c12c:f137 with SMTP id
 af79cd13be357-9479f368c54mr360445785a.82.1794314555301; Tue, 10 Nov 2026
 04:42:35 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <CGME20261110094848eucas1p2577d7a3c60643a040e599dfa1bf97f08@eucas1p2.samsung.com>
 <20261110094830.2081847-1-m.szyprowski@samsung.com> <20261110094830.2081847-3-m.szyprowski@samsung.com>
In-Reply-To: <20261110094830.2081847-3-m.szyprowski@samsung.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 10 Nov 2026 04:42:23 -0800
X-Gm-Features: AclHuK-FeNynpA1_RJvncVNma0nOMx7dW4op-Ljg-ln5a78S2ORxIIsRcrITnr8
Message-ID: <CAMo8BfKENmH3rZU5jyCdVOBzRAQ+KBJmVyjEWG97XYxBNaZ=qQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] xtensa: handle highmem pages in arch_dma_prep_coherent()
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@infradead.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Chris Zankel <chris@zankel.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 1:48=E2=80=AFAM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> arch_dma_prep_coherent() performs the cache maintenance on the address
> returned by page_address(). xtensa with CONFIG_HIGHMEM uses
> HASHED_PAGE_VIRTUAL, so page_address() returns NULL for a highmem page
> that is not kmapped, and the cache operation then works on the virtual
> range starting at 0 instead of the buffer, leaving any dirty cache lines
> of the buffer in place.
>
> Highmem pages do reach this function: dma_alloc_contiguous() can return
> a highmem CMA page, which dma_direct_alloc() handles by forcing the remap
> path and calling arch_dma_prep_coherent() on that page before creating
> the uncached mapping.
>
> Fix this by reusing do_cache_op(), which the arch_sync_dma_for_*() hooks
> already use and which maps highmem pages one page at a time with
> kmap_atomic(). For lowmem pages it does a single cache operation over
> the whole range, so the behaviour is unchanged there. A small wrapper
> is needed because __flush_invalidate_dcache_range() is a macro on cores
> with a write-through data cache.
>
> Fixes: 0f665b9e2a6d ("xtensa: use the generic uncached segment support")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/xtensa/kernel/pci-dma.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)

Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>

--=20
Thanks.
-- Max
