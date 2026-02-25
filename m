Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C62E2E7635
	for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 19:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772049286; cv=pass; b=J4Hqm7D344+JXf7E8/PS+puFU+R263PXwhP7OruRnVDFPDqnD2sc9LGvdyxepPG86VU3yVHsplE706NLyDtFdO/KP0hOTKfBEnsZZMZzFJCNt8SL9ggxKTM1D5UZ8Wleuh4ojFsEMwCNSp6qOOuXJtI6cQM6ii1rRmC/bA48mk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772049286; c=relaxed/simple;
	bh=5kHOrLDbHDmcLU0mU/NKuQBxgp05tP5/RxjExBXg+n4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JOXVEPeD+esQtz/WzxC5qU2Bt28rfVSNReiGuGR+4p564p2pMWK/f1vFeSJI4o8RhOYvNJTmMrfOo2bTr4BoEPbKMGHFLg1eqmwgFvH8OFbv1CGOdDmWpNBHfJJiZV57kdt+ltuC8iP3AcfuFhILaYIv84o/crFB6U25dvrcX/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mxp+KBTj; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mxp+KBTj"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48371d2f661so12555e9.1
        for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 11:54:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772049284; cv=none;
        d=google.com; s=arc-20240605;
        b=arJrtCmQpiLa+pfULImygNDmuRuuWbLX/JVMut3YOoJpI5rWI+ZrB4MyYW1oM7BNOX
         +ZoExi/pLCirZ+zy39nuVe6E1koxw+3ZLN/6gX/eoX9i8zx1liHUCbGU8SjAXnTU8IRH
         4Hpv145ynPpXXVH1i1TFWS1z7XKo1tiOoTU0rPz72NBG0BPoQUrlvCfKSwXwiVEuh6Tu
         Q5gHzFz/5rcfQToM3EGXrBE6Fo1LLAvepn6uoQVdm3TXPAhOIxbuGbDGTZ4NXFm6e/gX
         AFwTPgHIO4BFWRmaowDF0ChHzcfqTP3Hi7S1aCpDt4eBDN2GFtHzUbLLi7Bnll8/42pq
         TgYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5kHOrLDbHDmcLU0mU/NKuQBxgp05tP5/RxjExBXg+n4=;
        fh=KNEwZk1pHR6+/uURDIizDKuTCXlJNqs3FiYrDvabLbs=;
        b=Mrny53DPfJqBJehxapmbpjgfrUqaufVp1mEe9OVoinwtFXlrFUMxzpRTQsOfZFn99H
         05i/XmFYmvbLAFPknJ0i67uENBmZmxrGdlnRfg2b1DMaPmKxtUJqSAdC8QF8+fCNxOoR
         eL37lD2PW4YveWGWIQGSq/CTjOoeUPhKjFy+ImFWQ1FzcYsN/C32DU7GdP7rUJT0WXRD
         K4eZUKYF4Ju0hznPNlb9DG7idS36M4K5g5ws99nJ/SApuiP7GWwxLoGLyZgwCXWDhf/3
         mhTo9lDPW+dci27r7/BL9hZdURo8jIJfyQzzGJxZrKf7+7D74lgKWYsPaaMhQGeMBEeC
         BoVw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772049284; x=1772654084; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5kHOrLDbHDmcLU0mU/NKuQBxgp05tP5/RxjExBXg+n4=;
        b=Mxp+KBTjH+td5ZsWy9wA4xCo6RxxxolK87G1uv/Q9V+ro3lpRifotY5EueCWFBSEF+
         Gr5OQvkDBs7mDE3iVDje0gqlnsMm2/ka/jeMDc8bgCsIh9SLAErNWp9DHXbQnYWUINyu
         3ZCfnTQeG9h2Lgdk84TY1uo4VWTgSVKQq9TeTbqmI04TfIJ79+K+qWIa7bRI3VBvVUjO
         8NV89uoFO4aGPugEL53Dur58HnbVfUM3AX23cEaDNbR/oUYobO1xAYuxieBlqm0FK16Q
         IvPJMYfX58iE2I+vwIhOYHXSCqfqJuWoZZCwiYceM2cL9PcdJUQe2b/S1ouWAXnwU0cp
         32lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772049284; x=1772654084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5kHOrLDbHDmcLU0mU/NKuQBxgp05tP5/RxjExBXg+n4=;
        b=L973tSrfTNNzQVfwOPy2eNgX3rMS8OTRapj+n6wZJ/eFD/BUyK+4qEXSNgIqS8OhpT
         vONKWTDWDF3A2nD1OKX/nvIfkpjFtIsAaW/bNc/HKcEvIk8pxB3lAyK+A9UZkl+8Xy8v
         HWLVN7kex1oy+ZW8Eki8f3R8TeBzSKqej0GxI2nBronoXey4kd/lZ81eDdkHv/MTPQgN
         hWKUJc87bJ21EJibHLwLo6FjU3lv/EIhlpYYgoJNVzMZcReShNYrdRhhmXyMvWJTfM1j
         uIi3vSPMNMN3Lf8C/fmPWDmiXTziHKT4whdjChDlxPImo8ziBTSo7FfBIFCnme7qpmVn
         hasA==
X-Forwarded-Encrypted: i=1; AJvYcCWO1t97h74IrWQYJ5wsEUBvkvDcYrtF9xu2zw3DgKMymNpTaNsdpJ+5XZGfy2LuctSjI7Od7Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyYbLsoZvQjlgcvEfarzGPh6UvR6Fu+50kmnzEKLPCQ/ATws/DW
	xft9HrNaainxpZ0XZ6BiX7e0nsiJ8MjVD6wpzhiuUiRom4vjc2QBPVaLfKGBmKhA+fV7V/kxWPw
	iWVr/Kd7ALiO3DKuRYzL1dYxwmWcgpWDTb6yL3QOM
X-Gm-Gg: ATEYQzwgL1XfqKeMmpXMKv4KypP2qxWuU4I6PqtPbF+cls92lrq+JYCdAqnhfsYRTIR
	y2kANHu8FFJAwmiNa3sRYn345wUrPX3yy7vhpgvtiXopIm4MW72V5qisYERlOiHIBVsvn6bAfPX
	Aa/EtFmaCgCDK/Sveyl+/ERt5vwkJ9Hqpc/y2XzKVE6a/AzD4YRzsU0TU0BJdCydRVZqBwv5HDF
	YsqF06KyW9OU4tWbljpX8IHHUUyOYkSOeZ/dAsPWSJ6xxq0pbbn7r9EtYXp7XeHRM2+8Eg3WmS6
	yCP8ZW5lBOhSvhlG/oMpWnyBWjVetLX0Zp5HFyA5nEfGvtt3WGVfmAmWukSf1u2O8kaa1Q==
X-Received: by 2002:a05:600c:a011:b0:47d:7304:d759 with SMTP id
 5b1f17b1804b1-483c31a1fbfmr90505e9.15.1772049283315; Wed, 25 Feb 2026
 11:54:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260225-dma-buf-heaps-as-modules-v1-0-2109225a090d@kernel.org> <20260225-dma-buf-heaps-as-modules-v1-6-2109225a090d@kernel.org>
In-Reply-To: <20260225-dma-buf-heaps-as-modules-v1-6-2109225a090d@kernel.org>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 25 Feb 2026 11:54:31 -0800
X-Gm-Features: AaiRm51QwXByHIj_4EAMjL0iJavUr_3DqvTRveBK0_qkEAD8H59M0Ces2LdyWWw
Message-ID: <CABdmKX26Q-DXsLEMbvsYbw_JotHpGk3zFDccAJaqir4aSBdt0w@mail.gmail.com>
Subject: Re: [PATCH 6/7] dma-buf: heaps: cma: Turn the heap into a module
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
> Now that all the symbols used by the CMA heap are exported, turning the
> CMA heap into a module becomes pretty easy: we just need to add the
> usual MODULE_* macros, import the proper namespaces and change the
> Kconfig symbol to a tristate.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

It'd be good to add a note that heap modules can't be unloaded (unless
we add more code to verify there are no live heap allocations). With
that:

Reviewed-by: T.J. Mercier <tjmercier@google.com>
