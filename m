Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A968426D02
	for <iommu@lists.linux.dev>; Tue, 16 Jun 2026 11:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781608025; cv=none; b=EFip02YxPpB69XYnE7i72JWmuUPouCh7yK/3uroJltgnd78IZSIO73EpjXqqgaEhmEi0OtdpA57oC4KWKaSQ4+fLaWvWJyUwbSyyc7Dg96QZkMpgCIgDnPpIS/mKiZW5pTz2mFQmYph/SFnviW/JEJjni4k8tE3OOZmpfxkdMW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781608025; c=relaxed/simple;
	bh=8L7LN5GWKaXLjw308PhIswoJMOtulW5cOuUEITh9aLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hhg8IhD/8r8O+Riwq+rfryG21Ls7Mhu6ztj7nP2aTl0NQr5n7V5eqEPBfXpsHsXkX1UeHw0VA0HFTd/iHHqXOiajx/Uz5Nh+0NVITbK5QlSOJTWwlB9hwBpV4ibfnNwNsPj2qDDegqboSPn2saCUQc1+h68uCb77MC4VP+w8ag0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CRwXOtLF; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CRwXOtLF"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490b23c828aso34135e9.1
        for <iommu@lists.linux.dev>; Tue, 16 Jun 2026 04:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781608023; x=1782212823; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eJ3fUZ+/EYmTkDXUK4ZNvux/ajtwZf6cg0AECRGmMnI=;
        b=CRwXOtLF/kZh58vZCaOAdZFVIUC/3ZIaiWpJR4OwIN2LUDK4KxumSM8TmWgPkbUwml
         kiIRhyDP2oCF3hchtpOt1imxpYKjqg3hi1cBUE0zNLdYuuwmxxIUVpoDJUuSQs7EE6TT
         zFBENmtv3jMXIRRzpcnWdDsZi1eEICSg5teNwaHW5cjUMQt52n/VrFrfega7/qNRqA/q
         XfdwU7PVb82UX7PGed7eSxb4GDtk1d/Dw7ANDRnEsA2tCTCilwPiZwzLmU9/kyACoqHG
         +kgvxA/Ts7K6WN/xGjpa4yKrloHagG3hfk9fQlsy+P0f1r23pSIU2F42e/EUet5BXN9A
         vPmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781608023; x=1782212823;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eJ3fUZ+/EYmTkDXUK4ZNvux/ajtwZf6cg0AECRGmMnI=;
        b=XtekdHIB9pZ4UAPXQ0Oot/j6MzhIQKpLeGXZO3kM7iYpFMLKgP+FPjoC/2KgKIT5/Q
         y5fdMeSQXnB3zLPZpOkwkuzipP2pnO+Qu4a1bvPlmrA36OYwR+B6RF8jZrjXeef1W47t
         OizhUzoCZI6s43Cw3dkpiAdmmFAzyxjrkXlCPoUFfC1ub6A/jx4Rf+4c+peq3eCDGvf1
         TOKmh/DhEJz4WXwz4wN1gGnKTm3P+AVLLqgb5hL1LaZ6ooIZZPxjByvnVpgfsZ1tapz2
         58eBrSAigW8+bzNXhXpkk9PbxNEWB6L/x3BnsOiQ1Q891byD1jNtx3YBiF6fmiO1SlFP
         FJcg==
X-Forwarded-Encrypted: i=1; AFNElJ8y7hLgWBZOS7kyeOEIqvA6WZKxIqAjuC1Otghi9txzDJpZqOveVfu8gkyWaN8bmv96UHTkcg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzi2cb4LyQbs3ZQuH6AKIpvDJfT1S1+glo6hu3hv6OmlyeAWII5
	pOrdXn+Na5SByqhQ+fEu0lSGoVPX3dEhUyGiOJiUMicKg/OibAG1qVcDqXnogcTVIw==
X-Gm-Gg: Acq92OHvI+nV6wXx2dWScqD8EVnDJVDaO3M7lGCe3SY9KJgrZkfh15jck70zd/DDNrA
	Hu+htFfQSdaatniGcSTmJpFgsegHb53bRgsW6CcIgTQMoJv1s3VHdC1JHtRMxwlkkkLuZTj6IeX
	XuNX/2AZY2Ey2HMrvy45mnsjrl37UKt6WKOoU+lYoLgXX7xh5einwjzN9DTE9/hjE/n7gdi6aCi
	vjaIWi6d2AYTVSkHt+jZ5idU3ZD5tDv9rPV9WF95ts0J5iJFFBDYcacnkMhYJtTz8loqeUGpjyx
	DJCyJbRFl8FNctaov44KM1ufCSHvAPT/nv6peu+0p/IeZH2w0+QvFWTB077SvTZkQUxHMiCtte5
	kz9ox8Akydz/fMDaiillD+j58XGDvEaIq8hxiR3e4K1H3ihN+hsm1bHx5uDo72TVLBAw5mPndZc
	vHasUXsxTINQRSaQvPNUbCHrHrMzPUiihUfvWJCQuhzmprnbfBOJAbA0xiPvu5hw==
X-Received: by 2002:a05:600c:c059:10b0:48a:5aa3:ac1e with SMTP id 5b1f17b1804b1-4923088e313mr879485e9.3.1781608022038;
        Tue, 16 Jun 2026 04:07:02 -0700 (PDT)
Received: from google.com (140.240.76.34.bc.googleusercontent.com. [34.76.240.140])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26393asm46289637f8f.5.2026.06.16.04.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 04:07:01 -0700 (PDT)
Date: Tue, 16 Jun 2026 11:06:57 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Luigi Rizzo <lrizzo@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, rizzo.unipi@gmail.com,
	m.szyprowski@samsung.com, robin.murphy@arm.com, willemb@google.com,
	kuniyu@google.com, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, gregkh@linuxfoundation.org, rafael@kernel.org,
	akpm@linux-foundation.org, david@kernel.org, netdev@vger.kernel.org,
	linux-mm@kvack.org, iommu@lists.linux.dev,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] swiotlb: avoid double copy with swiotlb on tx socket
Message-ID: <ajEuUZMgS_NRmDcp@google.com>
References: <20260615234220.3946885-1-lrizzo@google.com>
 <20260615172535.080cf94f@kernel.org>
 <CAMOZA0KAHKsvA9yRcdrjG13S+=rJhw-Cvnw2WdLjGGY0azG0kw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMOZA0KAHKsvA9yRcdrjG13S+=rJhw-Cvnw2WdLjGGY0azG0kw@mail.gmail.com>

On Tue, Jun 16, 2026 at 02:33:52AM +0200, Luigi Rizzo wrote:
> On Tue, Jun 16, 2026 at 2:25 AM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Mon, 15 Jun 2026 23:42:20 +0000 Luigi Rizzo wrote:
> > > The use of swiotlb causes an extra data copy on I/O.  For tx sockets,
> > > especially with greedy senders, this has a high chance of happening in
> > > the softirq handler for tx network interrupts, creating a significant
> > > performance bottleneck.
> >
> > What's the use case? I associate swiotlb with debug / testing mostly,
> > so it'd be useful for people like me to explain why you care.
> 
> Ah sorry, I forgot to mention.
> swiotlb is used in guest kernels for confidential computing VMs.
> Ordinary memory pages are encrypted and the host or devices
> have no way to decrypt them, so the kernel must use
> unencrypted bounce buffers to exchange data with I/O devices.

I started looking into the same problem recently, to reduce the
bouncing in protected KVM (pKVM) confidential guests.
My first attempt was to update dma_direct_map_phys() to skip
bouncing and do inline memory decryption (for pKVM that is a hypercall
which updates the stage-2 page tables), however, that was really slow
compared to the memcpy in bouncing even for massive pages.
My conclusion was similar that we need to solve this at construction
by making this memory allocated from a pre-decrypted pool (which
does not have to be part of the SWIOTLB)
My initial idea was to teach some of the kernel subsystems (SKB,
BLK, SLAB) about "CoCo allocators" that allocate decrypted memory,
as this is not a net specific problem.

I am still looking into this, I was planning to bring this up in the
upcoming LPC.
I will give this patch a try. However, I believe that we need a more
generalised concept for CoCo pre-decrypted allocators in the kernel.

Thanks,
Mostafa

> 
> cheers
> luigi
> 
