Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736F1155757
	for <iommu@lists.linux.dev>; Mon,  6 May 2024 16:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715011273; cv=none; b=FiVQE9nrWw/AY+UXtc3TIFN6Vze+0hwpDivRfwF/abvGLIHhQ4UHFLpjxmVoTKeOrxr67W3QYETPREmvzX+jCBIhfmzYC4GeaW1XWkVXO80QKPgOZMGf2p8Xak9vZKVbmYc3+HpYZUb+jsR1OrxLPSe3XAlNgFAirn4wicd8mzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715011273; c=relaxed/simple;
	bh=/8X2gnEiS07MSb4K2ujaIaVEy+MjBkGptcmS2MVFUUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DmSYl+QMuK/sDFe3jDMyAoYpQl5WNf9d58kn0+hUImUKozRfGdOjPgJNDJzTkRz5Xveo8F5KWgILfqDfyxC6vTtI128xtBFoNo93lwbvpBZgdBGPIVWftm8SUoyG88H6tCYJ5rSOOLwjMMw/PJfnmMXBfYN+RZ1tfqZurJ9PBDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=clVL6ING; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="clVL6ING"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-61816fc256dso20777507b3.0
        for <iommu@lists.linux.dev>; Mon, 06 May 2024 09:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715011271; x=1715616071; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sE9GPEEi4QiW/KNtAtOnI6oG/6EjA9xFbSRzbj2009Y=;
        b=clVL6ING4++awbXJUy/RwcjMkB4ale0NhhmhzdIAnGI7bm2prpvFsjImfWL/Cteg8s
         S6uG6GKyl5U8WJpTWMKVtI7xIbqAAcrYFg7hX+t4+MXlNZO+ye3s+z9IK9hnd3b9GThf
         L3g7nT44wTctoqPtURwKdCaHvhlkBaPRcLF60Li5KWzEAvxFOIBGNYzZSkoZluHHzPBi
         Wcf6FTmThqwTIkE9hV291kzmrn00G5AzzXH/eJOrxlqWOBDATnrwtYjGdFbrGjO5xb5e
         UTqLzzUh2h94+cSjH7aYuVujDEhN8iDhZt6GRMDXm38YDK81L0ZIpScrRhXE5l5583U9
         EkRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715011271; x=1715616071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sE9GPEEi4QiW/KNtAtOnI6oG/6EjA9xFbSRzbj2009Y=;
        b=Cov+j3U7OsdctvWzFdMwy8lCLZLa6ftmFlhCIrRK3HAjfp4zilJWemqayelJzOUz/3
         0fOTIM26oxs0avaJQ8djuc41FeZABBwa4VD13+2NTRluaTEeou/7rbVeRxkZ9cFYQAKO
         KFgNFHkZVuETEoCO97qaGd3ru50tLDUh9oLtAJoqXXlL4wcTrzB9aS8Ye/HDyNQ7Kq/y
         jaLON5fEA7RCGxvxlwbvQvRbfb3wlgUSpzEFhDuH9BK0fsxttC7A8ckneRC0fz0ECyR3
         BxQSLl5BKcyJhOnNCCj0/Nur/0SpZ3+WI2JCdDfkBC4og3NOS/qmHnRlkracUyQqK4jm
         Ku7A==
X-Forwarded-Encrypted: i=1; AJvYcCV/zIymK8FSTExKg8ScCgdJ18BaNkRJ8iHeTgYSIa+/+/xeid4dFgEBrjlYvpy00r7SFnOawW4kgK9OqzSYPoVXV6i42Q4=
X-Gm-Message-State: AOJu0YzocrOeTlT0/OctgR6Hx5WY6tT4w3xjDSyKl4gNd29e0aT36Iuy
	DWgWwksK6/1rBcJpnkW7P2W65G7fIqJHd0+z+nIhKzvmzNsTHzmizcq5pectyXdXMSeAEM1mpzH
	S72wf/DxzmmEwAfMhHwJkz6gdnbfUottzvR3a
X-Google-Smtp-Source: AGHT+IG8HH5pkx30Vizp/TXJUP3BkqxJAP2OHSMcx+YHDtQcvmWbDHRVh1Gs07OExx6zhgjFxd8AIqm6lMkRRE3SQ6E=
X-Received: by 2002:a25:698d:0:b0:de5:4c3a:5ab6 with SMTP id
 e135-20020a25698d000000b00de54c3a5ab6mr9641262ybc.3.1715011270989; Mon, 06
 May 2024 09:01:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240503183713.1557480-1-tjmercier@google.com> <20240506052955.GA4923@lst.de>
In-Reply-To: <20240506052955.GA4923@lst.de>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 6 May 2024 09:00:59 -0700
Message-ID: <CABdmKX1XNTtoPTvfsJRobim8pHdDjPsKx=qVovVZDh5GEbKCfQ@mail.gmail.com>
Subject: Re: [PATCH] dma-direct: Set SG_DMA_SWIOTLB flag for dma-direct
To: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	isaacmanjarres@google.com, Catalin Marinas <catalin.marinas@arm.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 5, 2024 at 10:29=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Fri, May 03, 2024 at 06:37:12PM +0000, T.J. Mercier wrote:
> > As of commit 861370f49ce4 ("iommu/dma: force bouncing if the size is
> > not cacheline-aligned") sg_dma_mark_swiotlb is called when
> > dma_map_sgtable takes the IOMMU path and uses SWIOTLB for some portion
> > of a scatterlist. It is never set for the direct path, so drivers
> > cannot always rely on sg_dma_is_swiotlb to return correctly after
> > calling dma_map_sgtable. Fix this by calling sg_dma_mark_swiotlb in the
> > direct path like it is in the IOMMU path.
>
> I don't think this is the right thing to do.  Despite it's name
> sg_dma_mark_swiotlb really is dma-iommu specific, and doesn't make sense
> in context of dma-direct.  If anything we need to find a better name
> for the flag.
>

Oh, that's disappointing. I'm looking for a way to quickly check if
any addresses point at a SWIOTLB buffer without doing a potentially
expensive call to iommu_iova_to_phys. Since it's meant to be dma-iommu
only I guess I could use sg_dma_is_swiotlb if iommu_get_domain_for_dev
returns a domain, and is_swiotlb_buffer otherwise for dma-direct, but
it'd be nice to have just one way to check which it looked like the
SG_DMA_SWIOTLB flag could be used for.
