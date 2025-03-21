Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1D222B8AC
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 16:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742573604; cv=none; b=MgxM+uW1yfOQnnuj7lE7ll5L7xRvGd87qpBGlJJWWHRdXs5+bqkCa/Y9w1Wh1EtArvzj2xHrB9eofU7tBemY5U31ijfYoLe2so04yvaui549iiXSuI54FjfPTdV3CY9KWTvoR3pSOeu+dWJ+pjG8+0o4v0tVe2O/FG+zqpPkytY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742573604; c=relaxed/simple;
	bh=C4aK4DlSw/wJI3i7YtL8fTLyTEQqGsdWSWsribRkY1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F+8j7ws5sCzBhuuG1sve8veDMLCoM+bp6bxGL/ZAsnIYEwF/3ZqGWeoYU+qyJiCKsOl/xmrsrbhO3A15ki8NmdrRTVVHCK1zoJJlxJ19Seu9taSxzMXItnlR9QWhczrSAv401oHyfm/vPOy003qOsriYkmmmxsmYM4kEAgbq0n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KSVf23oD; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KSVf23oD"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4769e30af66so323131cf.1
        for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 09:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742573601; x=1743178401; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4DB6Et2/ns18QKw/fxCT3wrpCitAogjqJ6rF7Sc/IdI=;
        b=KSVf23oDLZ9Sxhp7jiVlSyK7/oyP9/IV2VB4IOHTxIiGEejoOS/H20rFH2gK7h8HN9
         fpJi8x/QiqJm2d07ldJPG4mDAUjbt1w8+kgqqXYLdA0ULNHpNJlor0OteiAwqSifvHdx
         ZVhU8/rbGvdRvTG5u2JTexaTOnfzD6aUiuIWYv0wDKw75/qw6aaRQkcKBbk+Q7XvKxpz
         FDK2BqYHSZhmmIe651JtIFBL9KqElyTrfRRfXQ76xqPljgT5swVXKrDecV314dvLjc9R
         CTY5GS5SObHND1iSJufogVvlr1DyLdRKcjIu+lVpC6OUdlYP1ORYIlk4lR1joL2nn7sO
         JS5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742573601; x=1743178401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4DB6Et2/ns18QKw/fxCT3wrpCitAogjqJ6rF7Sc/IdI=;
        b=Qjaobx7xIwh3eDh90FoIaqNOPgl5dLSyF2Evi98y3Eh8/PREChaOtrCV5aC63Nzmnh
         /1a1eVbtMWgYrgw3cF1weQP8rRPP1KVVyGFnx/RJOH8mj6AQAFauoOHuFb2r+uZuUVka
         cUvaOzMGqZIBW581vVWucwP5iHOwVMbSYDZbBI3QQ3/oEP2j+abObdCO4wOCPUxh2GBr
         KDhUAXY5BXOlwaaOE70xd0fypWC7FxEJeunnQjo/m9EQpe2IRto7UopOv0OZny4tzH0/
         ITnoaWIKK+tx3OvfdBe6kU1zbSPgUey/VyeVlodPoyST5M33ahsXhkxeWS3o5bgBfCMe
         r/rA==
X-Forwarded-Encrypted: i=1; AJvYcCXGJ6Ph2zD52cL4p7+hlIX/3eNbhSRzkwj3uZHuSk4ovQnzNdBtULv7gC/GgvThl7KAqdpM6Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz/kffmfP2NHLYCGQiqs5TDkBdpTvHuey9E2XPrt9Fp3LkotTwh
	Nq9rPAB4DpbyVTLbPP27eUyfpFLwj9vTiQGw5tIpl+8b7RRTxWCLt6S2WEe99t9lUNABJPe+9XP
	Jik+pqxOuBpwpjcWv5Xjm/vnTj4nKcHSw/vZf
X-Gm-Gg: ASbGncsZxwp0zGwGavDmhquCU3vAPVE15HqU4SSWIa1RRopr13tixCuDIfqa5vTm0tu
	u2VUTFgWN50eDDjjVjxjwQgYnhcdVmdi0klv4dD51V2+1PerNoG+W7VaglyxwCzQl0ZxBwC8KKb
	dVy+Z9NfWTxz/4nHYt1Mn8Vts+rQ==
X-Google-Smtp-Source: AGHT+IFSgyka4WC1voAzOEbVYGRfiKD2rPwZmgBJm5bmCEG2w77v71gm7DM31qNjr/YtvVbNnr/XQWUzc/NWKh6R9Qk=
X-Received: by 2002:a05:622a:4acf:b0:476:d668:fd1c with SMTP id
 d75a77b69052e-4771e0a7e7dmr5053721cf.2.1742573600117; Fri, 21 Mar 2025
 09:13:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250320173931.1583800-1-surenb@google.com> <20250320173931.1583800-3-surenb@google.com>
 <Z9z1w2vHfJrwSgWW@infradead.org>
In-Reply-To: <Z9z1w2vHfJrwSgWW@infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 21 Mar 2025 09:13:09 -0700
X-Gm-Features: AQ5f1Jr9bSIHVG9XyNi5uOulPdcHUxw5kGAy9us8_XrILBTKaK6kzxC5mMI3vcM
Message-ID: <CAJuCfpF=fk3=s3NLkai0GN5twjgY8AyyL1vZn3T+N7E10SgHug@mail.gmail.com>
Subject: Re: [RFC 2/3] mm: introduce GCMA
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@linux-foundation.org, willy@infradead.org, david@redhat.com, 
	vbabka@suse.cz, lorenzo.stoakes@oracle.com, liam.howlett@oracle.com, 
	alexandru.elisei@arm.com, peterx@redhat.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, m.szyprowski@samsung.com, iamjoonsoo.kim@lge.com, 
	mina86@mina86.com, axboe@kernel.dk, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, hbathini@linux.ibm.com, 
	sourabhjain@linux.ibm.com, ritesh.list@gmail.com, aneesh.kumar@kernel.org, 
	bhelgaas@google.com, sj@kernel.org, fvdl@google.com, ziy@nvidia.com, 
	yuzhao@google.com, minchan@kernel.org, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Minchan Kim <minchan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 10:14=E2=80=AFPM Christoph Hellwig <hch@infradead.o=
rg> wrote:
>
> On Thu, Mar 20, 2025 at 10:39:30AM -0700, Suren Baghdasaryan wrote:
> > From: Minchan Kim <minchan@google.com>
> >
> > This patch introduces GCMA (Guaranteed Contiguous Memory Allocator)
> > cleacache backend which reserves some amount of memory at the boot
> > and then donates it to store clean file-backed pages in the cleancache.
> > GCMA aims to guarantee contiguous memory allocation success as well as
> > low and deterministic allocation latency.
> >
> > Notes:
> > Originally, the idea was posted by SeongJae Park and Minchan Kim [1].
> > Later Minchan reworked it to be used in Android as a reference for
> > Android vendors to use [2].
>
> That is not a very good summay.  It needs to explain how you ensure
> that the pages do stay clean forever.

Sure, I'm happy to improve the description. Do you want more details
about how only clean pages end up in the cleancache and how they get
invalidated once the original page gets modified? Or is the concern
that donated pages might be changed by the donor without taking them
away from the cleancache?

>
