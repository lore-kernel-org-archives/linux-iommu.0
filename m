Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5DE21373
	for <iommu@lists.linux.dev>; Tue,  7 May 2024 20:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715112459; cv=none; b=ui47KNDHEVHSSFjaPlJybyBh5MyTaqptGjq2s3uL0NOUJYR20cCgNQuCUysF3dYIP4JExU6Zpeo5+QiNVxW678Rc6wEUGGcsXQ/Zndg2z0wxts0tfZC22AqK/8SCG5vhlRWjJg+45Nbdo8TBdzF8fTICAGqOyZB0X+CPBoZZVpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715112459; c=relaxed/simple;
	bh=n/UC63lLAcCezzowRd6HUrb0809BTC3BrdNXURqieAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CII9KkkH2z9haFjJtkQnEimkGa9JmApIIg1S+v3ghqYlD3WtbhtrXSBG109chGqa4UW09MCrMhNbNZ0ZYFBBuWoh69DO7TAfTBNwU/9O5mX8hIbK1AYd7LpYnjfPzWZrdxw8zS9FWhKZpv83kO+YYnPJQE158piHajeVJk5fjkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I1bA4FrP; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I1bA4FrP"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-de8b66d1726so125187276.0
        for <iommu@lists.linux.dev>; Tue, 07 May 2024 13:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715112457; x=1715717257; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/UC63lLAcCezzowRd6HUrb0809BTC3BrdNXURqieAU=;
        b=I1bA4FrPY2zyvqO7PMyzuIZsDEpJ9vWNl6omoo3MeA8IMTEtxSjbUzAmeZOqtzFl7B
         HJurzRezu7YjbOAgSwArF7jBhc/xKP2O6TE0CUbyvmjEnA7Rojt92zzJR92ngCoLnlzn
         UPsrMZyp7x2O9hLQZPyTgSuwwIC7wyAyDC2bVfIoR6mvPCGRLQ8lfrpPR7UE3Q2m0van
         tuweR1gQTSaVg934vr9szsclzHmh0CFzTbO+X8OhTX+TMqHSG8zTTZ+1wr/KVyMvo6gc
         rsdkL9mg6sfUeqxUo+0SMfP5H+m1s12tcH9PMvaQsnHJZFCzSTy8MKpy/HIwxZ8YwofW
         DeWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715112457; x=1715717257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n/UC63lLAcCezzowRd6HUrb0809BTC3BrdNXURqieAU=;
        b=K7h+BlEs1fo1S00fSIO1NbgVUPkYtnFuIWx6GDCCC6Zxzm/R7Y5/tZsiTe+ksNn0vZ
         r52lgguaXG5lX5tdDO6CHR0y7IsA8WQx9ZgmAsd/qmhO5Z4wChpCvKsM4YUyHBw8Sgm3
         2PfhnNM49CIwGGV49NjTHeFmkLSc7RIQx/zqB842+wNlu0O2DCaxyrdk9lR4yevnK7lg
         wOMgCEOCMPxFsBiUVmbQlClIpH8OLbFlK3DCX7Bw5HaQpQNkrASaUXiN+q79PCJtnv3G
         LOkXtCKm6Utr/Ua7C2+/rxsxlHkq3z1tWO8hRXAhEnAPuPXWPEl4ch+0T2Cwhbp0kXSE
         24Yw==
X-Forwarded-Encrypted: i=1; AJvYcCVSjoWOiApDZlbrfOh0hnUnOy+nkiArBo150MLDhOMmFcYnbz2ciIV0o4YLUp1Q8pQwVnVT7p4TuSzxVS7j+S2ypJbQC8E=
X-Gm-Message-State: AOJu0YzLmL0fCyLmtGfhpkKVGVVMdVyaTWv8DLEX6aRMCbw6k4kX8hdK
	rW8R7U0U0D+ZBz1LjSbLUOoqGWMxBnNoUQY8O/4b4l1OjaF9RuEXLQdROKuh2treN6XmiuWrcmy
	2ABxi2dqXuOhMZziCR2CjM2RP88lqUxwlh3qa
X-Google-Smtp-Source: AGHT+IEm/B5M9ij9+hhRe58Bv33yPC7ejrw1gilNago/rHkRrXGwhO7+GslzLf54b+pza6hk37izLWTtVb7zqaBYMVA=
X-Received: by 2002:a25:7481:0:b0:de5:64db:170d with SMTP id
 3f1490d57ef6-deba31e004emr2783330276.7.1715112456532; Tue, 07 May 2024
 13:07:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240503183713.1557480-1-tjmercier@google.com>
 <20240506052955.GA4923@lst.de> <CABdmKX1XNTtoPTvfsJRobim8pHdDjPsKx=qVovVZDh5GEbKCfQ@mail.gmail.com>
 <20240506160244.GA16248@lst.de> <CABdmKX1n98+bw+1kewz=wdqq2Nbpaxao_Lx-Gq8oKGNUEP4ytQ@mail.gmail.com>
 <20240506161906.GA17237@lst.de> <CABdmKX3s_HnxciDA3XGM8Qj0kLY8OWENg+ifexrON4VYVbuLsA@mail.gmail.com>
 <20240507054314.GA31814@lst.de>
In-Reply-To: <20240507054314.GA31814@lst.de>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 7 May 2024 13:07:25 -0700
Message-ID: <CABdmKX3PgcXaRUH3L7OV+POMiMd5L6pEF4fLXYPgfmQUNu_trg@mail.gmail.com>
Subject: Re: [PATCH] dma-direct: Set SG_DMA_SWIOTLB flag for dma-direct
To: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	isaacmanjarres@google.com, Catalin Marinas <catalin.marinas@arm.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 10:43=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Mon, May 06, 2024 at 09:39:53AM -0700, T.J. Mercier wrote:
> > > You should not check, you simply must handle it by doing the proper
> > > DMA API based ownership management.
> >
> > That doesn't really work for uncached buffers.
>
> What uncached buffers?

For example these ones:
https://android.googlesource.com/kernel/common/+/refs/heads/android-mainlin=
e/drivers/dma-buf/heaps/system_heap.c#141

Vendors have their own drivers that also export uncached buffers in a
similar way.
