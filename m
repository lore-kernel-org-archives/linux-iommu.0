Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA68660BB6
	for <iommu@lists.linux.dev>; Thu,  2 May 2024 16:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714665761; cv=none; b=X7QV33hcrZhEPi/H+pzRvpoksaEAa4LOlqnN40bcJCYX1s75e7EaXrReZVqTux1v1lesAitS9GvEeiu99rDYxKMujKyXHlea75hgbTdjr1m93zW9rQZsp39spw13y5CG06WctAY3qR/EH1vcZpRsunB9OiG+6Pme2cF1Y/Eir28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714665761; c=relaxed/simple;
	bh=4zrGVyY7oeyk5looNBSKhoeZb0nLxyxkhsaMw8NDxgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z+1tALNOdFUWgjd/6AyOr/4kUilPLiyN9s0qZTEt+Hj6ZLOwkjS/08hGQ65QLQhXrUUSqVM+fyVqvVHAt64uPpaAqDiVTHfTc6zyejmgCEukFbOjuCIYwR4oh0QR/IyTU/pXO3QfpC+BCM2lIWKnJAPr1PeIAyQSJtmZ3BYpnKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gd2ZbfCU; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gd2ZbfCU"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-61bed738438so30782997b3.2
        for <iommu@lists.linux.dev>; Thu, 02 May 2024 09:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714665759; x=1715270559; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4zrGVyY7oeyk5looNBSKhoeZb0nLxyxkhsaMw8NDxgQ=;
        b=Gd2ZbfCUCqgfgR5yeqpY3nWJHSlIAJLqUvwN1XxvGQyXScNvMbu+Q5BlGX3NjYPOga
         kmywz7SFClaqkOY2FNKO/ZcFMYOW3YvxoLgiWJC9OQf+GOq3b+N6zJLpyfLdeAiQpjk7
         dbDQNdsA3anYc+/idGDp/HcTzDMT1S4YtA/oPsRYg7IcbW/gcs8w935ezSpDgyfM3TWc
         0FWOlVSaatFX0Vi4WnUSl3F00advVUQHOPvBST1gQoz20gl2lDIaRS5ikhAFj0tuyHUp
         4Y4BM1mlwulPiZoJQhaepSZan8UKpqZXT4H1LvTjDecWCZ+St34aSn7SeI6EIdXWbUT/
         JWJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714665759; x=1715270559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4zrGVyY7oeyk5looNBSKhoeZb0nLxyxkhsaMw8NDxgQ=;
        b=Ol7bRZLeIChDrGXqSOcx1JxkanPUGTEEfNNL6ArmMiovLD76kBb2gk9QW0S++v94gu
         EzU8/aWyZUVMo1eP8HA35zwxZXuB3/zSw9CSWPaIQNhFUEcMLiglZxFOgT8GSmoCSzPL
         AGUzxfn93JgGFiaoiiJ/1X8Yhkt0+boPbIaxjMCU1m/sUOSb5/kB+AsrtFODSCzs/GJt
         nnAxYVKSnvG/iIZrbgHXvw+daSeRwytr/ZStlToWa6BUXihOQKgrZNhNMaNOaLGe4QHy
         psaAkjTRdCeSZmQZP/Is9XF+c8ASWNp0/0En4uQ4W4v1+Jr6trB962GdhSXIChuransS
         oLZA==
X-Forwarded-Encrypted: i=1; AJvYcCVScHzewvfQ4HbitdUfYPTvsgRCpLnm8/rIijpztSXateH5JcoNwT2XzsV2PvFIfDdYhcdi3khdz9MaYTDBElgVsGYZNP0=
X-Gm-Message-State: AOJu0YzCPRw7DVyFPxib3WulxN3rfg0RqCisKBvBYTbgrGQ/RKR0lK9c
	a5F/bLbfuYG2A5jmfy+5iqihN8g6cj4JRusmo6Y1mzUcYY2mxDAB3eCT4vFV3N5qUxdjx9wLwXy
	Z5jSOxNHWBADw7mIkLaSvaehBLBtgdWvZ5y4b
X-Google-Smtp-Source: AGHT+IHVNHQC5SLyOth+ELmjn3kDXf0QPueuFFd/3ftxdlJ3rQVGDzpbXKZBydBreAIgG64UsDFz3vBJjSuJ+Lyf7Tk=
X-Received: by 2002:a5b:70f:0:b0:de6:1a10:11c0 with SMTP id
 g15-20020a5b070f000000b00de61a1011c0mr301803ybq.44.1714665755811; Thu, 02 May
 2024 09:02:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240501201319.586289-1-tjmercier@google.com> <ZjMfl2G377qexhi-@infradead.org>
 <b4b11ebb-4e42-402c-8e9e-48eb57ef34d5@arm.com>
In-Reply-To: <b4b11ebb-4e42-402c-8e9e-48eb57ef34d5@arm.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Thu, 2 May 2024 09:02:23 -0700
Message-ID: <CABdmKX1+MyJCwgbpYaZn5uLdqgfJbv_5iCX_3cmpL1UaqeggEA@mail.gmail.com>
Subject: Re: [PATCH] iommu/dma: Respect SWIOTLB force_bounce
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@infradead.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	isaacmanjarres@google.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 5:50=E2=80=AFAM Robin Murphy <robin.murphy@arm.com> =
wrote:
>
> On 02/05/2024 6:07 am, Christoph Hellwig wrote:
> > On Wed, May 01, 2024 at 08:13:18PM +0000, T.J. Mercier wrote:
> >> iommu_dma_map_page and iommu_dma_map_sg conditionally use SWIOTLB, but
> >> checking if force_bounce is set for the device is not part of that
> >> condition. Check if devices have requested to force SWIOTLB use as par=
t
> >> of deciding to take the existing SWIOTLB paths.
> >
> > This fails to explain why you'd want this somewhat surprising behavior,
> > and why you consider it a bug fix.
>
> Indeed, it's rather intentional that the "swiotlb=3Dforce" argument
> doesn't affect iommu-dma, since that's primarily for weeding out drivers
> making dodgy assumptions about DMA addresses, and iommu-dma is
> inherently even better at that already.
>
> Beyond that I think this change also seems likely to interact badly with
> CC_ATTR_GUEST_MEM_ENCRYPT on x86, where we invoke the SWIOTLB_FORCE flag
> for dma-direct, but expect that an IOMMU can provide a decrypted view
> in-place, thus bouncing in that path would be unnecessarily detrimental.
>
> Thanks,
> Robin.

I encountered this while testing a change to DMA direct which makes
sure that sg_dma_mark_swiotlb is called there like it is here. (Right
now the SG_DMA_SWIOTLB flag is set only if dma_map_sgtable takes the
IOMMU path, but not if SWIOTLB is used on the direct path.) While I
agree IOMMU + force_bounce is an unusual config, I found it equally
surprising that swiotlb=3Dforce wasn't doing what is advertised, or even
giving a warning/error. Since the iommu-dma code is already set up for
conditionally bouncing through SWIOTLB, it looked straightforward to
give what's asked for in the case of swiotlb=3Dforce. If it's
intentional that SWIOTLB options don't affect IOMMU code, then should
we just warn about it here when it's ignored? The presence of a
warning like that would also be a suggestion of, "you probably don't
actually want what you're asking for with this configuration you've
specified".

Thanks,
T.J.
