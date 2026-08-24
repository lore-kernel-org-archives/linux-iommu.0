Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9916446C4D0
	for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 16:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787589094; cv=pass; b=ei5gR8LX5qCEjRt7byk96Z+FV14TemSp+hORZanwueAwYGl93XpT9ovcqpyEBedci/M5JRkJOD93MEUXIFqcmZcuHZa1In27QYPTRDPTV12yCEos+am3yX8SDvQyN8at4L77VTCpXSHihnKVLdAf9DE+U7ghoV0RE+wVpEfKfhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787589094; c=relaxed/simple;
	bh=roisqT8iKq+LRB/VLs0WzYDy3i23i29fG7pAUt2iNuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WpbikCcGU8VPJ+JtgL5ErZ910CK1LHsfiADPhFb/L3y46R+d/ejRwailQ0D4BOKwnAymuFMk6630ZngpBoz6o3QUg5G0tabRWXhX445o9oHkSK9MBQ8//SH9yGPP9odA5NvA6UZF2weZmEDD1MkBct+uFwAPLFN1awWDpQC8iA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MiWj5nDK; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MiWj5nDK"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cede6375caso195115ad.0
        for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 09:31:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787589093; cv=none;
        d=google.com; s=arc-20260327;
        b=bj1eYhSJ3rXEciDIAjDAGcsNXKDWnVtQTNxWHmYwyqNCMe+HLvnZfwSqIPpvMT0C+p
         M0AEvhYmclml7O0r6srk+dfgUHXO7+nFOTQ+MEo255ZI815XbY5VxtcUxXelxs3/U0hO
         Vc7s6ccekvt2buRHEDH5uOLK21j3AumQOdjvPEMF1eHsrM8wsJZ3vQ10K9QwW5En1sM3
         +XhOjAXsII4cGGmpI+yXOFasXZTKujv6zUbGrDCLKTJgU8E7zu8fsalBVzGAj/hY5VNo
         /mfJim5FpHFoV8fL/EPWdT9z/qWyVXHT5XS8Qq7P9INao3A5tnHUy11Aur1xmH/qPLFB
         +t+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q6jDXnJz5bszG8pnLHnZK0KeQdaX8tcSfusG1JTMhO0=;
        fh=++clRwV/hMQaauRPQW/FK2oVbXVS4PSGYPJ2n2/Fpkc=;
        b=LP7VVxhrlkbYFAIBGflL2emwC6rI+ujUxFC6/AY1fphA8HsDhOKQ5UVX7kXehtOmPU
         zMmtP9ehC2N7yRfVE9ZWFQcpjGSS4euJjcpKuSS1DteZvITGOuyELl0cCXWfbY41W/ND
         h6ZFEDHJybqMWzLfe9ElvEoebAA85PJ1Q/BkAWXulipmeZYrSzTbV7/Mpk83ugKmNOJW
         lyXMLqsLt3FLunC37mfIRimy9LkwDHOmI5GpnJlOxlOCJOIyll5o4cl0pe9FI6pvrOGD
         NpbEdXsmXcij0gcnKV3BsIUXmEQMejTj4ks5qGoaHAJTM4dMHSwfPM1vKtmpw9yCaB7M
         AzMQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787589093; x=1788193893; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q6jDXnJz5bszG8pnLHnZK0KeQdaX8tcSfusG1JTMhO0=;
        b=MiWj5nDK2fNgG+nHQo1YZx5lRyqVtxkSGj/oZ1NM2j4g/EzJlDCnZYaQphHcKzPnNN
         4SpPANrLNgBtiH2IEDMDfcjOVfy98l5k3OF8pFEBOhDzC8M+vjpQ5OA0VJfMbjuJ44rJ
         WRgHDUIojLftcwGGeiLS0uwh+gankI6LcK/KD2hTvPdER/rb6p+VpdnpFkuQSAHVV9ZC
         dII7/1Lzg5BYiOvF/DBNtcwVzxYXt/9ogrrhUSH7fUrtXq15GAmGp3Iv+E9ZKzPBLHYe
         dm66iQN0BqMCUBfAaH9Pk96f57aWmzPEMzpnkhAdgtLO0K5yWiCnj4tzoZlJXGuR4Dkv
         9S+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787589093; x=1788193893;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q6jDXnJz5bszG8pnLHnZK0KeQdaX8tcSfusG1JTMhO0=;
        b=rrOiMcBgVkB0Z8XqJr67+JSWZuq+QBBVWphuk2bokShWaTZ1hk120HpH8IgBZdZfKU
         xfPpuRmfBP+AyIo50Uy8+ag7UBzTgcZLoZxGLIjnmxYDRliZ9jYhy/T0hIKRT2zwTvyc
         0mQ/1Ft+AoCcchDC4iCM8qy9OOcq84rPRkN3A4GYcNXPS9ZaprV74wGf2Ki36640N4fZ
         lGKqIEDNw7Y7nxr0jN1JEFo3ZZbcwoZQm84CW9c1GptvQeSmRd12w7q15YpHtnlhawCa
         Y2I8nu7BvXfyqbUxyfqH6Y7gC6RxuWN0TKSYMlnmS6iF/S5fUgidKY0MwBzMpTiVyjy+
         lrZg==
X-Forwarded-Encrypted: i=1; AHgh+RoXX6j2QWEBhZo/MtHu44j+/K6IzGRe+EvuOcRkojW6QaRGNJ3sCscaPYYERSacQ3ydNnTBcw==@lists.linux.dev
X-Gm-Message-State: AFuF++kDdq+4u/Rx2FaiR/8yjLnuF3yjyTEUyKpy0biW3qxSWdvKx57g
	98MxJtnfhmeCSTpEAvPhwO4OMBbQOUAdXeiTq1BoeG8nR/lKYuB1opwgKCtfSQD2we1WYSs1QZC
	CaVMJcWqLWduwQ5gtW1wye59bL4vNqAD6srwtUT9e
X-Gm-Gg: AR+sD11sCIn+V/57Ts9j7UGA6RZKX9VJhQEPlwZ7mk1Cnp46mwksWXU4Mz7vM787yq/
	ACkJvzf5FfdSKNYbSsDi7BcRbDoE0oryTKAWWhLSwiBMBHQagFX3i88rd/WLf62rU5Vv4uLgA2q
	LhVzbtyjrhay89XKcCFRt8HFkxYVvqt+izuDOLReG9ZJkxYDnuMW2Mb1wlG1rYg2VuByUOTINIs
	CyJ8Rk67h/+kNcwQ9lJ0Pf5AdcoPl4WbojkDOI0zowHkZ2Wqv5qtHze4Fq+wW1/5ArAisECOnnw
	fwF7aUtFwDnweN8YkBMjhrymGkDhHb8ZCtsTrNMPsmD4ag==
X-Received: by 2002:a17:903:3c4b:b0:2d5:db3d:1a45 with SMTP id
 d9443c01a7336-2d66ffd7057mr11511785ad.18.1787589091990; Mon, 24 Aug 2026
 09:31:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260615234220.3946885-1-lrizzo@google.com> <20260824152932.1583506-1-lrizzo@google.com>
 <20260824152932.1583506-3-lrizzo@google.com> <a826c7cb-5e77-4c21-a649-d40a9f0ef564@arm.com>
In-Reply-To: <a826c7cb-5e77-4c21-a649-d40a9f0ef564@arm.com>
From: Luigi Rizzo <lrizzo@google.com>
Date: Mon, 24 Aug 2026 18:30:55 +0200
X-Gm-Features: AcwNN1XmT87hJkoGkp9jcEKvjnY9kL9lu9ePxKQtYVAUZgS8n1wQenRujPZyI_4
Message-ID: <CAMOZA0JstwiwoWFuFjpoC1W12ir2b=SrWPO9i9tto1rOksKGgQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] swiotlb/mm: Implement SWIOTLB nocopy page allocator
To: Robin Murphy <robin.murphy@arm.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Luigi Rizzo <rizzo.unipi@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dragos Tatulea <dtatulea@nvidia.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, netdev@vger.kernel.org, 
	linux-mm@kvack.org, iommu@lists.linux.dev, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 6:06=E2=80=AFPM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 2026-08-24 4:29 pm, Luigi Rizzo wrote:
> > Introduce swiotlb_alloc_pages() and swiotlb_free_pages() to allocate
> > and release compound pages directly from the default SWIOTLB pool.
>
> Huh? The sole intended purpose of SWIOTLB is for bounce-buffering data
> which already exists in some other memory that is unsuitable for DMA for
> whatever reason. If you want to allocate directly from some kind of
> pre-shared DMA page pool to avoid bounce-buffering, set up some kind of
> pre-shared DMA page pool and allocate from that in a manner which can
> avoid bouncing entirely (see DMA_ATTR_CC_SHARED). The idea of getting as
> far as calling swiotlb_bounce() to then have a special case saying "haha
> not really" seems entirely absurd. Don't hack stuff into the SWIOTLB
> code which has no business being there.

Ah I see DMA_ATTR_CC_SHARED did not exist when I implemented the
swiotlb allocator. Cool, one less piece, it should be possible to replace
this chunk witth the DMA_ATTR_CC_SHARED.

The other pieces are still relevant though ?

- use these dma-able pages for page pool allocations (small)
- [PATCH v2 3/5] net/swiotlb: Track bounce device per socket
  or one would have to unconditionally allocate from that pool,
  even for e.g. local sockets
- divert socket allocations for eligible sockets to a DMA-able pool

cheers
Luigi
