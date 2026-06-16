Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39813C2774
	for <iommu@lists.linux.dev>; Tue, 16 Jun 2026 04:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781583471; cv=pass; b=CSgPM6V4b3tHGvzCI2T5zR/AppHdFguCblLL/al9X0LBkFLUKKcfqRY/zpbPRAwjMlWMFLWx3P158cLrTpf5MZ6h4o3LUOXuVE9LSDw3S86KnMNRAL9pk6rLqwL2feq5iFIVfZwOq6l0I2VM2DkJGzURXMRtJHJBvB1FApIlxGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781583471; c=relaxed/simple;
	bh=UDM9Y2Thjnqa8K+lbXnfW8bZvgfvx5z0YeGl85VJOIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lzIqb/KdATNu7/MbGMRWpSKd7jb1821BPw6/XK1iB0OmCHzMaoh+DpgvunAP44SEDWI6v3wX5m6YKAr0KtxaeEgpOz0J0WwZKMHWWAylyu+0TsIyEnxNo6bvtLmiANhVx4Yil59LmnGRoGoPfoe9fZts027uItW+4cL6h3c9gdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=saXQfeRV; arc=pass smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="saXQfeRV"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-915b5ce94c7so451497385a.2
        for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 21:17:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781583469; cv=none;
        d=google.com; s=arc-20240605;
        b=Ocu8lp9U2JFWdbjHQe16qV3sKzFyXBD18tjLP+87I0NauWVtUKSzMc7exNOPJuWVwT
         nsSQ4VfnU+e/u2ZNbKHNiGRzoH2mvG0Vgt2VWOVer4lTmdoBjwbtwsrCIcqW2aH+C5u/
         SC96vzQKQqZwj+A+o5qzQ1kqhqnO82BqwVP9F+pelotngtWHbnB/q5P8KAMx8piP+rMx
         TIVOLMxZXiKw7KLQ0iIIlxlZ97rsxVv6bVE6DxR4PzcKxBWvciQiP+mYH1YOVqpx/yyr
         1CzstCsjR5s+GGCAyqOXVsd8sXp0QHpyfqct+z8qGAJSEdh1gBDU0wA9rHKP/9mDNk/v
         fSMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c46bC46uTOFVqkvQFgPWAgxQbVfvX2mDmBYTQGj7PhI=;
        fh=5rJg8z2ZeDXnbFsL3v5qwvkX72vjRzH5yQ+ZwRhjuzg=;
        b=NuDNF1E6SiU1YtV4ugzo/eOhry4srfKpWYXcqXXvcpelGWSO8/zKvhBx+5oxzSLe/w
         eZTEGchhJFdnKmCouYqMenSd9PcaLPWDdvPAqD/4OSzaU8MlL0OP0z8YwdZv4t2mESdC
         EsaaTxSEcv5PY3Kbz32aVIjz44iZCg6cIEr2xt1vJRUsTW9M/mh+Pjq8GMQrooaMkvKF
         pfHhJUQ6a9kHQRE/HEEq6bBN/hPvpEFedSxl7VNiHpXAijfltSTGenTSofSrjLndHtFT
         upANRK9j2boB8x1zsWaDdgNNGB9IUti4OHhYInX9PsCLy8at7XBPy/FRhGmDsTc6ryxn
         1hBg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781583469; x=1782188269; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c46bC46uTOFVqkvQFgPWAgxQbVfvX2mDmBYTQGj7PhI=;
        b=saXQfeRVS7WnbakhwNLF/FPEHLpX6WOMs2//W0rATqr7k94c6LxvdsSBMBei6XGnzn
         25mKNfekV8zGgSYnRXz7ver1OGWAfS/0Wh3ejzeqjgGZTZO7PvCxITFv/Hp8t/b74qSm
         tUYOJPYfH0OgbqH9HS70ubgwf43QY3aNnopNduv2a/FFn883vsm0cWufngwfNk61ZSMf
         RKQQI8GEAfAXp1G4n13FZT2vgt73taldIbj5GWd4w/at5QOalOujmen8KRHrO/6wiyEL
         c2SSpOy01/LRN0smRiU7oiE/p0Np7Dun/nsTDq+CiCeW/E3Czpb4lJIjMkb5OvbJs87w
         sgjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781583469; x=1782188269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c46bC46uTOFVqkvQFgPWAgxQbVfvX2mDmBYTQGj7PhI=;
        b=e3YMCD5giJKRllFFxw3cx10GbcPm6/gEWUAi4hcLbvI024h6jZVxfVJ8Lb7rMBSKY3
         OQI2+BsFe/lPuGJ56h4jTrsVt68Exh0VJUKWqZEiA0Q3pRkpT7vI8747oqjrmYdtEttL
         S652vQEt8sXLrJ4cT44xpymseJAKD0ZFWEEzYSt1KyxaQzk6ADyaDLb7f+U/sy7E1+zA
         m/spjrFinDQAohUj67aOQI/7rIJiQlna8hw6mcbHTlqcitdtNKxLDwzJ7508/QSU8GHd
         zgGgYyj61Kappv3d2X7acTg5eALoWlphzif7DNa0qjvt4NhiVNpgLXrnmtCf4Og/keYD
         539w==
X-Forwarded-Encrypted: i=1; AFNElJ/RzhPa30TRjju0ELj5QoTk7K2uPfb8umFm4xcp1yxusGs/drxGEqqAiPmryFWnVJQX3MJXog==@lists.linux.dev
X-Gm-Message-State: AOJu0YyP8RTp0tvVjvX0w4PIf5ESkATMdT1OgOV2kfRRPipWkzbBcDH5
	frg9LON05Bmcvar9Bhcb7bzmb+IiR8qxOxhdsqqVTBUbM8wdXjr8CZF4kBVypt9FHE94005J/eK
	FJBR20bjcRX9ZVwXMdXXVs8wCB+bcLbH9Nfm7LJ6h
X-Gm-Gg: Acq92OGfHEk9y4rebv8J3cy3t/ubDZ+eHaCYCT/aQC18/EyY79W0bUJuGjtNznM6o2K
	WBQrQVR4aLecBdzKfPb69CyMkrXHvyl9TBXvxWjlwA00xuTS6/Nm63Y6tkH3juVXXr533Uoy3vC
	6wE3srzV4Paqj+Pbz/CeRTQIDmO66n2x0LCZD7t5rcSuTHfesX/oGztyRnBNpWvMBLZumQcOEC0
	Rztdads3J8BEq9XwwDx3t8NmywJQQ4Ek6jjFvbRlh4/rXzloAaex1x2Fdx1mhazDRKkmQFSYT2i
	HsORJbQFE6ozbx0bah3UAVpcqkyQgU4G4yguUjTjgP/nons1XQlIL4zFUZEsfoztPTlwNAoCCVl
	z8cN82o1YBCNJC8Z2LhHMme8Jrf8C
X-Received: by 2002:a05:620a:1a07:b0:914:e3dd:17ea with SMTP id
 af79cd13be357-917ee4d8a24mr2288565585a.12.1781583467792; Mon, 15 Jun 2026
 21:17:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260615234220.3946885-1-lrizzo@google.com>
In-Reply-To: <20260615234220.3946885-1-lrizzo@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 15 Jun 2026 21:17:36 -0700
X-Gm-Features: AVVi8CfmRRXK2sLRb18EI2J6HVHIs23OmkonKcsJiFmkB68hhvaCXbcTPeeXIKM
Message-ID: <CANn89iJabdK5rDpZ8NEXY=_hF87dpjqksh4SRruGnZ=pReKTiA@mail.gmail.com>
Subject: Re: [PATCH] swiotlb: avoid double copy with swiotlb on tx socket
To: Luigi Rizzo <lrizzo@google.com>
Cc: rizzo.unipi@gmail.com, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	willemb@google.com, kuniyu@google.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, gregkh@linuxfoundation.org, rafael@kernel.org, 
	akpm@linux-foundation.org, david@kernel.org, netdev@vger.kernel.org, 
	linux-mm@kvack.org, iommu@lists.linux.dev, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 4:42=E2=80=AFPM Luigi Rizzo <lrizzo@google.com> wro=
te:
>
> The use of swiotlb causes an extra data copy on I/O.  For tx sockets,
> especially with greedy senders, this has a high chance of happening in
> the softirq handler for tx network interrupts, creating a significant
> performance bottleneck.
>
> Allow tx sockets to allocate socket buffers directly from the bounce
> buffers. This avoids the second copy and removes the above bottleneck.
> The fraction of swiotlb buffers allowed for this feature is set with
>    /sys/module/swiotlb/parameters/zerocopy_tx_percent

Strange name, because your patch targets the regular tcp sendmsg()
path (with a user -> kernel copy).

Typical high performance RPC libraries use TCP TX zerocopy these days.
They won't benefit from this idea.
Perhaps you should state this in your changelog or documentation.

Also, what is the typical size of the bounce buffers in your guests?

With standard tcp_wmem settings, each TCP flow can consume 4 MB.


> (0 means disabled, 90 is the maximum, to avoid persistent I/O failures).
>
> Implementation:
> - define a new page type to unambiguously identify bounce buffers used
>   as backing storage for socket buffers
> - modify skb_page_frag_refill to perform the modified allocation
> - modify the destructors __free_frozen_pages(), free_unref_folio() to
>   handle those pages and return them to the pool.
>
> The savings are especially visible with fewer queues. In synthetic
> benchmarks, senders with 1-2 queues would cap around 50Gbps with
> conventional swiotlb, and reach over 170Gbps with the feature enabled.

This patch is too large; please split it into smaller functional
units, so that each domain experts
can focus on their part.

I see you test SOCK_ZEROCOPY, but some applications setting this flag
can mix tcp sendmsg() with or without zero-copy.

I also see your patch missed CONFIG_PREEMPT_RT case.
