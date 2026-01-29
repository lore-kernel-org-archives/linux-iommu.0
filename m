Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275992FD69B
	for <iommu@lists.linux.dev>; Thu, 29 Jan 2026 18:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769712250; cv=pass; b=QGsaEFpi1Gagm5QYNLDabWxs018dNgSBABXarssWE82TYYQDMho3+bGKGxthXPK/DPtbp1Egqnu2mES+akDA3+ee8MHeOp7wrhCwQ8+Awl7zdkZTdDbQxQd2ETx2ql1wiYwUwRuuMbNtbM9/5yzkg1v4SpZ5B+3RLHZxTS7jI74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769712250; c=relaxed/simple;
	bh=xu6QKWa2VrrO/ETFJ5Q94/TaxSWV3sUOkwG0HAw1r4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ya2hppJDIyib9ttn0z+LcbuJvWxZkMNMlZiirSHZKU/i1AbRbsXJ+6spBYd3F5Prutl/vT43HVVw0dS1G9+Zhcpm8+1EcGNSk8ImvzniLLDthLwBpYTrWFiXJxyxT2MHlF7nz/SBFOIhF3TJy781MhVzY1vSQ5CYAr+I87BFOfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D1YlQZbw; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D1YlQZbw"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47ee730612dso2795e9.0
        for <iommu@lists.linux.dev>; Thu, 29 Jan 2026 10:44:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769712246; cv=none;
        d=google.com; s=arc-20240605;
        b=dO93NAB+oRnK02TKcq6eowYyslfOq8djqpKC6HAMt3o40NjWM/OI3bfxgP+zuwok4H
         1WOyf987IuPtbn4yMRD2ZYtemMXMsOByXh5ZSJP0vWXo6hn61Fqdqggkok6lAGWRl9sf
         0nF0S2OoV4iGezu8Nr6miPnTXeHJk17uV0ZryoD/5lZl19UGMalF841REmXse7J2R5kS
         8YAPrNtSjGXjB/rsspFFipctFp9trFPdWSDYTUn5YXRXax4Vt8Vh/JkKiHd1Xolxl9Yd
         za/EgNs9sdpPC8sD93CI4akFmBjneOiNyn4zvjR4S9yWTTtnbsCAAXnA0nW++JJ1Qv7E
         m1ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VHqrx5KU7HYyV270Kfn/itvfXfA+XmbftJv0jlKWTcw=;
        fh=EmyQ50WLClZsI/tSXi5sxOuDh19EMzVGXkz1UIFuE6c=;
        b=MXgjF2rQgwZm5gQ79IAqPBHSKDksixMOKj2lIBZxVxYCR7o4O6B9fzTwgzS5eB0xLe
         89UzpzDiIjtRJj1KzNZ0/a75Rj1bq3DI6cMQnwgp9WYszknAsoa19Y6JEb/LvXvgh4W/
         BpVarqgdgNYXGlqk6W/HdQxk4f5b7Y4g1EfEQYiYfWMD0KZH2RwSi3+QtyDsbMGfmsPv
         YJ+eHKjx3C8pzB7LVlcw6YG3DvTllj2zbZJc218mxV2s6InguPqlJWk7SsWIV47SElw7
         7Jad1hOh9qJGmlPt9Ovhgr/MtvHwuyB8H6xrC2PXltJh/x/8g79eWRECI5iLbn9XYpIe
         +/UA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769712246; x=1770317046; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VHqrx5KU7HYyV270Kfn/itvfXfA+XmbftJv0jlKWTcw=;
        b=D1YlQZbwRTRaA/Z836/ZkuGrkSbXeOwoz7km/QMT+cvMoaOpTiTFW2dXzl3uIq0pii
         WwHr0MGY5fBUkIWx6BgP4zkeZOGUhX3piV50WUb7JyabyN6AQJNk56dmSsSz/YSvX0wU
         xaUwqqZ+WycrxGc8KY+jynvGQGP2HwalKNImQno1pyP2usizRG1RaYPGsgzPJwc3luLU
         l/sfz8WGlGMc51FE+C3Io5B654WFL4FYl02sMm02OHBrMRG9Hlv/PPsRywhZESa5+ztl
         EdorZKfd2NYSQ+hSWRFPmy6u9BGqwCjHRNKMBpI0oYeYx7LYhKANU25l4ePNJDW2fqca
         Vy7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769712246; x=1770317046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VHqrx5KU7HYyV270Kfn/itvfXfA+XmbftJv0jlKWTcw=;
        b=H+KV6ks1sCONLTBZPU/iQtafYNIpQCl6rMmpBr0BhWbIbssDK1h77PBu+XYxIILgGX
         ItLBq+3fooBbSrqyNe6ULC/SPr9793c7dz5WFOSECMji/RNcf0ouKUqUE6KYccccjJqE
         JrW4sQor1IJEgaLAqn0T0dc738uQJbFS3ihf6g12qNe+DKMmr75FErRdOvqONwa9WNYJ
         tNrWohAGbhFLs7dRwQZj6YMfKEbRSqkUYFq4qEyKg2AF+uHIcHZv4GFaXGofObCsi3o0
         sgEXHvRYGmUCq6fmvtLQhkzwGmbR4lKpzI/rcdA13dX8g6AF3y8CHHeQXegCM4btvUwj
         Ygcw==
X-Forwarded-Encrypted: i=1; AJvYcCX6OXKmKHSZeE3mEv9gt2Pq3p7P8oR298f298LhrgO+JeYMLcR2GSn4cRil6YdGuFdkg8KdQw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzMJ9fhM+SpxA2uHqACjYE047+nq4rXxTOKyMh0ARlcZ6+4LU2k
	+uuziNOfPMjMctyDosXGpUJ9DjI4/X5EGWNH4gOWIVlaW7St036gc1IBu29j/nRPohHUkFSxr8j
	Q7k3go+gQDRF/MdZp21vpxnCzFmvDpIUTvZ5uiY4R
X-Gm-Gg: AZuq6aLIM9IcxcgSy2o/LXSs4k50c/rAliSX+4wx5aBfQp3WqpOPfZGErCdUkFj3AIi
	dTgPjq8NfIKpgi/ja2XGMmhE+MoTZ9n9z0P//iuyq34DAlHBbrZkOtQ3bdesTADvrVaCtdLXfZi
	NImlcsB529rkxkSjlU/4FJ7wFx2xIwaRkwwtrCYfCrRtRhItFeSCNWiBLjKWgXlEOVHhgn977Dk
	O4WQDlazSRv2QpyYVZtBSWxL8oeqM8miQm7JRItqF0qZeM3yBGythLMsZ9yL0QqdHiyq/+DLKTX
	7Hrvy9eZAciVE96aYn/KeLngvEcjREGHtgDIxeGlXZubW3zjyg7gWYBmpQ==
X-Received: by 2002:a05:600c:4345:b0:477:563a:135c with SMTP id
 5b1f17b1804b1-482db235943mr27045e9.0.1769712245651; Thu, 29 Jan 2026 10:44:05
 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260129181317.2429196-1-sdonthineni@nvidia.com>
In-Reply-To: <20260129181317.2429196-1-sdonthineni@nvidia.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Thu, 29 Jan 2026 10:43:53 -0800
X-Gm-Features: AZwV_QhM9P42YctYmxAmppXU6sV1dsIac5P24Bs35wkYfY9nYN5E3PzGu_gkScA
Message-ID: <CABdmKX1PVDy3TtrvNb_pnM89AHzWLBg3itbhp5RFgVt5Q-KQ0A@mail.gmail.com>
Subject: Re: [PATCH] dma: contiguous: Check return value of dma_contiguous_reserve_area()
To: Shanker Donthineni <sdonthineni@nvidia.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Maxime Ripard <mripard@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Sumit Semwal <sumit.semwal@linaro.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2026 at 10:14=E2=80=AFAM Shanker Donthineni
<sdonthineni@nvidia.com> wrote:
>
> Commit 8f1fc1bf1a3d ("dma: contiguous: Reserve default CMA heap")
> introduced a bug where dma_heap_cma_register_heap() is called with
> a NULL pointer when dma_contiguous_reserve_area() fails to reserve
> the CMA area.
>
> When dma_contiguous_reserve_area() fails, dma_contiguous_default_area
> remains NULL (initialized as a global variable), but the code doesn't
> check the return value and proceeds to call dma_heap_cma_register_heap()
> with this NULL pointer.
>
> Later during boot, add_cma_heaps() iterates through the dma_areas[]
> array and attempts to register heaps. When it encounters the NULL
> pointer stored by the earlier call, it crashes in __add_cma_heap()
> -> dma_heap_add() when trying to dereference the NULL CMA pointer.
>
> The crash manifests as:
>   Unable to handle kernel NULL pointer dereference at virtual address
>   0000000000000038
>   ...
>   Call trace:
>    dma_heap_add+0x40/0x2b0
>    __add_cma_heap+0x80/0xe0
>    add_cma_heaps+0x64/0xb0
>    do_one_initcall+0x60/0x318
>    kernel_init_freeable+0x260/0x2f0
>    kernel_init+0x2c/0x168
>    ret_from_fork+0x10/0x20
>
> Fix this by checking the return value of dma_contiguous_reserve_area()
> and only calling dma_heap_cma_register_heap() when the reservation
> succeeds.
>
> Fixes: 8f1fc1bf1a3d ("dma: contiguous: Reserve default CMA heap")
> Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>

Might be good to add a pr_warn when dma_contiguous_reserve_area fails,
since we won't get the pr_warn for a dma_heap_cma_register_heap
failure when we return early.

Either way:
Reviewed-by: T.J. Mercier <tjmercier@google.com>
