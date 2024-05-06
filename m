Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54CF1E4A6
	for <iommu@lists.linux.dev>; Mon,  6 May 2024 16:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715013608; cv=none; b=BycZ9eZinYUkKLcZy/OS+SjSV6NSMPkPiBotE+u0H+j1WiXtMslOMdBUqMg8kiFUolx4N666YX+9/w0ikBS7Z0QMSeYp8ryg6uEqX/OVD8H28TujEtx1GL2y7hMf9blz8pgp6n+HHwqiuAgzUX8LlVcnVY8J90rlp6EhuLjeS5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715013608; c=relaxed/simple;
	bh=mbCxyUl0xXnMrCeHULBRH3fDeDz5G+xM5ZK97knxOjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ofJI7MDpHcavZUNavnVhYkrvQPVz+sk4jL70ElE4YWWGoPQQKz3bMi7qcn/aoigGxUB5fqbINl6efwZ4054V0o7x2FEEzb4BhC+mGghVcpYA+lSEZU2V7eP+ODlTl2WM4pg+4JFh557PDV+ZTjrJx12LHqlyMlvNRhh+eeYxR4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vHj3inzW; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vHj3inzW"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dcc71031680so2202492276.2
        for <iommu@lists.linux.dev>; Mon, 06 May 2024 09:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715013606; x=1715618406; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mbCxyUl0xXnMrCeHULBRH3fDeDz5G+xM5ZK97knxOjE=;
        b=vHj3inzW9QDRlV3jQRlgnpoj7bco9eJW+Nc9ZrZ22zAlQic0F7rIlR9C7J1JUWDIo9
         qJtB2gYaGmSsQuMkXi7KX/3QBMCERA/yWSfXTe/JRwH/uMrlBSbeuUBVkDnm5LFIFwKo
         UVVOJSnh8ZEGpWIv5O40ba0da0PrWoKH3LN9N8yCE7r5TmRXRG7bgNxTqV+AhTcMoM3y
         fAjJpZTnST0v/hJLN7cPrL/t9DkSK/i45FbqapYIT7I/BYgeIqi516S+HBuXkwnZB7oY
         ANswMpCawLSavMplkcVP/Ld/yuAxLv1zZxFjJOHUtvQEZwNIrsKyDCPtjuxKQ3fKBq4c
         meBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715013606; x=1715618406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mbCxyUl0xXnMrCeHULBRH3fDeDz5G+xM5ZK97knxOjE=;
        b=Mdu9Fy+2zVfmLUQCHwmNcD3t0Wi+3W6m911plrewS0qaWsTxK6Bkejm7rL5d8LjvPX
         qI8ufkEchuZSLmSI6Yc76OX4RXfcArUtIg/YElpwewycol88xH3bmWORf64LulZ8R7YH
         usEBXWqR1UBYiN8kZjQeik0fOVK+1tEWDgetePi8v8Z/oS9fZGHYy6OdyHPYEn6t1Luj
         jKiNQnogbnJdASeFMfWUMNMWYHhVmTRaTmIWZKGZSA8TnLW2QrnIey7vt/yPJ8gSsLjk
         wJMRPQDVsoMGpu0AbHp4MeLQ5woxWoDhCch8clX8Chzhtaenu6sNGJDEa7mP3CCi6HD9
         TwzQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1zrwlJ2lIzp8Sy+PqBnD9F37beOK462zVDV8t8mPycZUEVSLsCOYolC827SUkl2VgeVx6f4wKoBnRT7ikHYNd/xr9nXk=
X-Gm-Message-State: AOJu0YxLRsbrxM8CZoyjJOBOrezH9w11YYEVoD8vd9iD31SxyvWdPJlq
	moCfyVZC/7tKXD+q+97NDq25v9OZKwe9i09CvwQfBv/iuoIpbHfIwOYsWDDgZuUmDxYBpaMWaiF
	qFLnlWOYTK0Q48sykE3VbhbeZxd6JtR1DOjbCuIQJRGIzqF+Z5gsW
X-Google-Smtp-Source: AGHT+IFBxsahP+oE3FuwfOQp/ah0jhdGLJrVrWFUoON5+ivb9iKV65nJPRyw2KFaPamsQmlgz3oHokti0ORvDc2XNIE=
X-Received: by 2002:a05:6902:2085:b0:de5:9c4b:dd5c with SMTP id
 di5-20020a056902208500b00de59c4bdd5cmr12126324ybb.23.1715013605681; Mon, 06
 May 2024 09:40:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240503183713.1557480-1-tjmercier@google.com>
 <20240506052955.GA4923@lst.de> <CABdmKX1XNTtoPTvfsJRobim8pHdDjPsKx=qVovVZDh5GEbKCfQ@mail.gmail.com>
 <20240506160244.GA16248@lst.de> <CABdmKX1n98+bw+1kewz=wdqq2Nbpaxao_Lx-Gq8oKGNUEP4ytQ@mail.gmail.com>
 <20240506161906.GA17237@lst.de>
In-Reply-To: <20240506161906.GA17237@lst.de>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 6 May 2024 09:39:53 -0700
Message-ID: <CABdmKX3s_HnxciDA3XGM8Qj0kLY8OWENg+ifexrON4VYVbuLsA@mail.gmail.com>
Subject: Re: [PATCH] dma-direct: Set SG_DMA_SWIOTLB flag for dma-direct
To: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	isaacmanjarres@google.com, Catalin Marinas <catalin.marinas@arm.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 9:19=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrote=
:
>
> On Mon, May 06, 2024 at 09:10:40AM -0700, T.J. Mercier wrote:
> > I want to reject mapping a dma_buf for a device if any of the pages
> > that back the buffer require SWIOTLB. AFAICT there's no way to know
> > whether SWIOTLB is used until after calling dma_map_sg, so afterwards
> > I'm trying to check.
>
> You should not check, you simply must handle it by doing the proper
> DMA API based ownership management.

That doesn't really work for uncached buffers. Since the SWIOTLB
bounces are in the sync functions, and avoiding CMO is the point of
uncached buffers, it doesn't make sense to try to map uncached buffers
that would require SWIOTLB. So unless we can get the DMA API to fail
the map in this case (look for DMA_ATTR_SKIP_CPU_SYNC + SWIOTLB?) I'm
not sure how else this should be done.
