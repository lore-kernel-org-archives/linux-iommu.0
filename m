Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D76148167D
	for <iommu@lists.linux.dev>; Thu,  8 Jan 2026 13:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767879913; cv=pass; b=YUMsD75OQRjzBdO8DuUlSiJLk8/p3lGPovTHRbooKnfYihGWgde5yZ8T0brMVbD/3RqIY1KjpX65CgqHYfTrpArQbURoPXzpqe3/IP//uSHj5zRpiH/yZ1m/i78aRBV6dY+pYbd5RtTQ61NMGD/88JEi6jSRLKxc2AXGiSwxEQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767879913; c=relaxed/simple;
	bh=qyRa40fh8YhmtwCdrRt6pdxxVr6ipd3YcrOg4WQdMeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MD2JKTiLevJMFoSOIsoScK3idIQOyeVedsg6t6hEYbnSLf/04H87jLNKJ8U72rQZtt5sT6KKORdm68QS8lpaUxUdyHZdH9I+MtjnuWGue5yI6Ydawa9tDX9GXWvn/IbJop8xLdcJ9M49oLVrUejNOKUeHW1eXvP5lKZNo31f52o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AJEjF3EL; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AJEjF3EL"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ee147baf7bso962531cf.1
        for <iommu@lists.linux.dev>; Thu, 08 Jan 2026 05:45:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767879904; cv=none;
        d=google.com; s=arc-20240605;
        b=GgBB04QWk8k3JwQLZRJWME905yrTakOLi9bPJBXSulhKMY/Znjrt+rRVBFIYCyKnFf
         yojbP1iCUWON5w/834a5HVyZJGRE5cF0qkRYOafCehZRTijt6Cvo3udrJX+qiQRKhMvK
         hx6SKFF/qR6j5CBuiJTmziCdHvlqBdPmQRso4s2pRvf7OO7VDOkezo5OOfo17Ha92Ohm
         jnYFpv9vhv1M9EZwwxPSkLuvaKUFUuw0K/ABGVfz5HO+fsS7xUS21b6yfjtIBlPAUY9s
         /M+8cDDxB4hcCNfzzLNqVKuWtATgqr0PATp9JGdzcVR/N+xJVKOk/AShLeJjPpkJDAAG
         LARA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qyRa40fh8YhmtwCdrRt6pdxxVr6ipd3YcrOg4WQdMeM=;
        fh=QdQdILWvlLc2hQqnp0n/8wdU4F3LkmOj3Hx2ZzpVSAk=;
        b=ggRQC6b/EHruHeHKFwVrhue8I/JGhAQ5A5t5b+TeNIMAsfKFQy1LFO/x+Vah8B4F+c
         52aqxzEOWjU/LiVgmskEAhoXZfmLv9mSYuzzt1vzlUCPwo/3Ae9pIxtcuuvIT7hjj1e3
         S7jdnkILHu2FKipIcvTI2M5p3PN0ERtmkkCCQOdtl9VK8QroKIBqeymo6xGAr6p2tTF4
         PfuzzK43Qv0m0A2ds6/FyB+3AHIf5EwVXV7YyFsaTIA160GiKe+rfOTnY4E9telmqgo4
         oy+1SOZqZd+ukzlTjRG5tP1BcR87WhzdbNX3jhZj5yI5NnQI/UTP+cY2RngiBVb4G3Td
         beAw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767879904; x=1768484704; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qyRa40fh8YhmtwCdrRt6pdxxVr6ipd3YcrOg4WQdMeM=;
        b=AJEjF3ELgC/NWhmaFbhaIpy4xW0dNuOjUdG+d7xxZud0BOJFTA3Yw+iRnLN9fQw/s+
         umDfuvavAAc7VKFTk8RvZbD2Ll3BNz5ntpJKhvH3ocPOq/2OrHrs93aRYkr7zasBBG0L
         Sqv2ShhTvIkdstlsqYIqBuwaO5NJJHrNCcrh4veSZ8JdFtH4BGh/DOjrU8nzuA9+xPtH
         y6Sq6i0x4VMRbgZ+toKxGtPAWdxB1rQXxkeH8cvbrQSHm87XpdBbeFatnep/tPxI7utj
         nuwA8qLSQBfJukvZ+11WpZW0WIwW21Kg3U+pgbhHGCf2SFaZ+ig+rhSZCHMMYPohyTSS
         w+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767879904; x=1768484704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qyRa40fh8YhmtwCdrRt6pdxxVr6ipd3YcrOg4WQdMeM=;
        b=MDk8nhgytsh1VS9FAm2J9r4GykArm+jizIbbsrPwpKfPTUJBluMfsSEuNcNYpDZIbJ
         W2BUTKSaSc34bCCZJm6Nr6/u75G3l4YeyM2v7vvdHyclhS2RLCzodEkSJ0XLqZRMyO8L
         KI7D+FJ8W0SxfJcWy4KOUHzroArGpFU4HQR3yTdJLReB4qqrgb0Kjb91HVuDyJyy9n1z
         oa1nfyHKH+YbLbKfztUzc/aq16f60UGW7ezg9hqYE/kp1UFfc5liq5iANuDJF/3FsXsa
         n3tr8mVvIpoLWIVTs9S3I0A+I9CoFGqPyPu834UyzFGkTKVqmGkO76jEAQlBj7l97KmE
         RcfQ==
X-Gm-Message-State: AOJu0YzmkKFmPLAeQ8gCfmX+YJt/9rFREgO1jrl/ExzrMNWDVLeJSikW
	ZD1bEUa2ANb2C/6SjaW4cN6Jztet9m8VMjuoDc201PQ+kSc/jCcAVUWJQILw9yoY0CgggtAu4FM
	Ovwn7rqOA96oqHRUqasaOR+5Yp2KutWfXirrS45tS
X-Gm-Gg: AY/fxX4XvESFZ0QFS+uUaVurJxZgwN+INNQs+NbL/Yv1/AtuRiFFETlaaXYhhZFGXE0
	5jiUoYx1N5C1UbxPt7QYVxVXwApts+I2C9WLgWH3EkI4W5swGNWZSYAf8XYpiVOesOtl9zvh48T
	wcDCdxe+dW/8B/QbdRND1CBEaLto6vNFWVs3SPwu2/ZReZ5ZK6Cfpl8iup6SfSV3zRz3Ee/YmFU
	T4d5GvEFqoN3r76r77uL3GojJxiSfDqhaDD4bQQ+/tHMhGln/qT/Sw2PKT/TDn5sYEmmy0spW+X
	4FM5b63hpJcyzX4KrsSpG24t/5ID6w==
X-Received: by 2002:a05:622a:290:b0:4f1:9c3f:2845 with SMTP id
 d75a77b69052e-4ffc094e8e8mr8332571cf.9.1767879903423; Thu, 08 Jan 2026
 05:45:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260108113846.56179-1-smostafa@google.com> <20260108125934.GB545276@ziepe.ca>
 <CAFgf54ocNybHR_Mp1+i7cff-jkeMUV1QxBCt04jnKxwfwnyUfQ@mail.gmail.com>
In-Reply-To: <CAFgf54ocNybHR_Mp1+i7cff-jkeMUV1QxBCt04jnKxwfwnyUfQ@mail.gmail.com>
From: Mostafa Saleh <smostafa@google.com>
Date: Thu, 8 Jan 2026 13:44:51 +0000
X-Gm-Features: AQt7F2qxCojV-Rkt2Q0oF4yYRt65modgBec2JKi-LjVwHS9mVz_oTorZ1Gh5S3k
Message-ID: <CAFgf54o+YZUyZTszFt-uBW4ZhjrAMsfPFUb9kKTK1uHWdS+++w@mail.gmail.com>
Subject: Re: [PATCH] iommu/io-pgtable-arm: Drop DMA API usage for CMOs
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org, 
	joro@8bytes.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 1:27=E2=80=AFPM Mostafa Saleh <smostafa@google.com> =
wrote:
>
> On Thu, Jan 8, 2026 at 12:59=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wr=
ote:
> >
> > On Thu, Jan 08, 2026 at 11:38:46AM +0000, Mostafa Saleh wrote:
> > > Jason pointed out that the DMA-API calls are not really needed [2].
> > >
> > > Looking more into this. Initially, the io-pgtable API let drivers
> > > do the CMOs using tlb::flush_pgtable() where drivers were using the
> > > DMA API (map/unmap_single) only to do CMOs as the low-level cache
> > > functions won=E2=80=99t be available for modules.
> >
> > This isn't what I ment at all, the iommu-pages.h could do the flush
> > inside itself using the already existing
> > iommu_pages_flush_incoherent() instead of open coding the dma api
> > calls everwhere, and maybe that could directly call the arch function
> > on arm (as x86 does) which would be easier to implement in pkvm's
> > hypervisor.
> >
>
> I see, so basically, we add the check for IOMMU_PAGES_USE_DMA_API in
> iommu_pages_flush_incoherent() with the DMA-API stuff and call it from
> the io-pgtable-arm instead.
>

iommu_pages_flush_incoherent() is also used to flush non-cacheable
pages in generic_pt from flush_writes_*(), so it might not be that
simple; We might need to add a new variant.

Thanks,
Mostafa

> > Then it is reasonable to have a pkvm version of the iommu-pages api
> > for the page table and drive rto use.
> >
>
> That makes sense, I will look it over and send another version if
> Robin is Ok with it.
>
> Thanks,
> Mostafa
>
> > Jason
