Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F26C2E175F
	for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 19:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772048068; cv=pass; b=JMmjGCUlMsc5eBqZWZ2tmeVknqOGGDIyOShpUWxR2MjcdseokeMoIfKO4KqUTASYtEV51guPRT75NlAE1/VcA9bjFnFVxpFjCC6bdoUDHoX5wlseANxGMKT5q8nN8i16CkrggIqIQRzeAqR/1OvU4N1qXtUkeSXIcT2jrah4ZFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772048068; c=relaxed/simple;
	bh=7Si8z437tvGEJio1pwGBHAqSsYapkryN7R/ntn+VLWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j5zE922ne5REnZX0fqEBHypyjrJ53Dy+LHMOhygytG1WJBNECjugSOj5XPWxVCvkKSEap8h6HtnzROjw0qZu+AH97n3IdzYKP6rsul+1DQiWMdsHcnvDcWV4JH0jxRjBD5PHVPsw0uC+lXv6YIOUi1DJogmv2pr2zsLwdRg32Aw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sIk3AxdV; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sIk3AxdV"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48371d2f661so10445e9.1
        for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 11:34:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772048066; cv=none;
        d=google.com; s=arc-20240605;
        b=F+KYKTDbckAF1lrHclDQXOLGjlQGsW185w0feDlzN4PyryZaASoMjubSDUUuR81dR8
         MlY1ULHkQVU7+8kIBzvyQrpcWQu5XW4ITvzBdWxBeqjMuXy++ANAjKqgbDBLOPb3cMNQ
         B0NLNVoZp637MXfcNn6f/0lFHYkJS/LHnCoMMWGfcc4d6D3IgbaTzTm7bsEYnk0jOqla
         ISuSqP/QGCyTQPHQJF5Zz1OOTdrGFm9vXWr363jUbYDvtv0h9Zi9t5BxGfAFcTDwQxTT
         oeg4pYUA2UCz8piT3K44PDGCSH+zLbMiEwIaP49PCU8wrSRtTSRPvYCi4vUJt/uKgVaj
         3qKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7Si8z437tvGEJio1pwGBHAqSsYapkryN7R/ntn+VLWw=;
        fh=zhfsi6qVyI3N58UWBDqLSjS8aaw9y+blx8rEDm/vXos=;
        b=RgCowUxeXin2TKlyorGNvyCGJhXpJjZYEKPgneeRfRocSJAsvm/f84Vj4yi7es3O2J
         eWxBGME7fkqrptsAikcAUwpRAxkluLcP38imcUvs8RCpsIFJ4VhHHccwsO41kh40h0TQ
         jD8uGwE5XcOvJerluHiliSNTaTRUz5BmPNQx1tbcjGKEqoS6drWNaNFKhex56SVFxT7w
         UKrYuieJcdHAKFjmqQ6b60V2pdBC4mzU6l8axVoduvebP+UMoAEIVZswy3CwdwCdieZI
         jpNwf5utOoUaYFTLgoUA7PfqUkNsLyt6weWe9j0Pv+Qdk/5meyd7zc/ANJRWzm5amVTX
         0pDA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772048066; x=1772652866; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Si8z437tvGEJio1pwGBHAqSsYapkryN7R/ntn+VLWw=;
        b=sIk3AxdV7Kh79nSoOQGJFWMrPixVYbkXgXG6JOp8naFIDDP94jJWU5KMTLQ659qdb+
         juu7dRaBifgu2HT7IYwpQzLrfcjXYnhNHVQaZ84nZzImZSQE0aqemOveW4i+xBI6BVvL
         6iVcdQD8aeY+NiMuFib5JG7M5ytaNHynGSuJvi7pxvjLB2uEi3QTGhRkyz3kpUK2rZQc
         9qVbQtDgZixz2TxgRs67CRsbhvghk3X0qTYkDlnaWR40gLr0R0zpMHh9Kn2I/iLxeiIF
         eVqsmPOclC6LWwSewVy25CpT0oZSZSEWHjEXWf1cuf8axSlseCssCQmJ5ujwH4LeTjV4
         ByJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772048066; x=1772652866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7Si8z437tvGEJio1pwGBHAqSsYapkryN7R/ntn+VLWw=;
        b=orcSKILoIe6X9JAXiCmWDpWpDOcztiMFCEbIxo2rs+At9ZkQCFBjT61NbJHVvGT4zM
         2YMUtEzWpmIK5zIdFg78XSpm7Ky5s0uxQWhNPmX0IJ1NWoC9HjfeQ7xOUTRfGroR1BCt
         ejy6LLb2VqO2aF93bO0P4MNm2UiKnaKByfwnYuJqImc1EyWmaWxIBcA3wK5aZfcHkt6T
         X+CB2kZb97xwN8uD0IsgqMVzYWKFSGnWfdR7IIX33xVlw6ubBWizRkJHTMOIEa0nT8pm
         awzZtCcyJamTialslG8T11pyJaKxhU0CnlrMKGHhgUER0jROBksTMPSXt0pHd5lUOLQe
         s4Hg==
X-Forwarded-Encrypted: i=1; AJvYcCWV4OAH/2b9MLu7GxYY0jNLkCqEv6Nri3vLcbKlVyKMhNjv/McNR7tTvQeZnwdOaeUjzkWSDg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzrWK6krVIw1796ESkD8Squ0TEFgvacuEfPK/0d/tkf8YhkMQdV
	c/N8G4+jfXXaItjqqMAU/WnmENrRep4csGpOSA0xjXOWcCEBKJY0SqHvFt5pS0CuzozG0sZLqXx
	49zcdhDzYpSAFj5iIsi+xsBKj12Dr1REv1EhARg70
X-Gm-Gg: ATEYQzx4bsavhzRoAaDAfeHafX9hQXMmUfai3Q3hbXBOncRf/wPw5YsNPIKNpQ6MBJh
	T+Iyfi7/ZSm9crytB1LeHD8S5Q/S5zjP0AXO2AcSnWrbiO5baSGW1MoWZz3wnlo1iVdwbe843wC
	acC9OtPgCu/nZoTOdWB+0+s5tYbVMlF6vRPVe1GKYQ23LpcrH8pHE8/sCOjJFMvlAakB/cAwuP0
	rm1RZ7Gsz+pZbZFXtRIiyykzV16oLqZXmkrxEsUv0EzyhrsXIwtagP5XZ87fUd/VKb5i974yzeQ
	9891MIc3DFWUDgRkoxOW8CitmVFSjCRlvXwvi1ReJsMPCHjS466WBzYPB9yNTqJ84TqxQQ==
X-Received: by 2002:a7b:c059:0:b0:480:4a7b:228 with SMTP id
 5b1f17b1804b1-483c3195488mr93045e9.1.1772048065599; Wed, 25 Feb 2026 11:34:25
 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260225-dma-buf-heaps-as-modules-v1-0-2109225a090d@kernel.org> <20260225-dma-buf-heaps-as-modules-v1-2-2109225a090d@kernel.org>
In-Reply-To: <20260225-dma-buf-heaps-as-modules-v1-2-2109225a090d@kernel.org>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 25 Feb 2026 11:34:13 -0800
X-Gm-Features: AaiRm51mS0fj4CpzrUrBMi_FPuw0tp6YT-qMjNhlthEAQ04zl32goABU8oOB09E
Message-ID: <CABdmKX06VsekPpwairaWC6JuH6BHMj-NqJj1cYgR=-rd6iY9ZA@mail.gmail.com>
Subject: Re: [PATCH 2/7] mm: cma: Export cma_alloc and cma_release
To: Maxime Ripard <mripard@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 8:42=E2=80=AFAM Maxime Ripard <mripard@kernel.org> =
wrote:
>
> The CMA dma-buf heap uses cma_alloc() and cma_release() to allocate and
> free, respectively, its CMA buffers.
>
> However, these functions are not exported. Since we want to turn the CMA
> heap into a module, let's export them both.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: T.J. Mercier <tjmercier@google.com>
