Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432C945973
	for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 09:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708507717; cv=none; b=LeUUBHb7E1Q8mKahmext5KiswM4oI/XZJhYAyP1S0tuMeL2v6BlB62hHpF4aRejyhaIaAM8tmODuoRR+3NYvOAxdyTK+NLt1JbS2pznqiyJy62IF05sLTdGcybGYnS5PCOtx3d3O2EP8f1shxPqVBb8zSrhtEXEGStIdv44D/YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708507717; c=relaxed/simple;
	bh=Hq8KJ6FUW+dUn5EF4x4k+Yc0eSHWRUNZYxQmVAAMYJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mo/XZQTQHiYSRLWeOMAnHoBCudeE134z05VwCPJsr9NVDC2h77pJ9Ryi8RME4HBMaYDEeZaRRTsNMtI3eC5bWg0s0QC7FRzIJ883uKK/vRPIGn5E9JaeY61Rnr+bwvUdDvQIuGKXiSuplkzml9bdo5BXWymNonGFd4YUhLbQXEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UaX14ac6; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UaX14ac6"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6084165494eso26935117b3.1
        for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 01:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708507715; x=1709112515; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hq8KJ6FUW+dUn5EF4x4k+Yc0eSHWRUNZYxQmVAAMYJc=;
        b=UaX14ac6LagcMj2sh/495ihZD9p42nUEZ6zD7bTc6lYaxJJr+OBtU0yMvCfa6V3MHT
         TnS1qRg4Iuk56uOGMGRQKm3zTEVXj6GUBiZ/8BAvNC0TwfsM9vBaipWLvTYSUHNmGDJg
         9cZ2Rs4Y7L9V0mqXSaUIgqyozXOtAvLOGxzcKm25Y5SaBrYXz6I8K+cq6i1IS2nqZeww
         lYmYVSjl91byVydvonGdHvH5Wt+IV4vUybl2slrdKK9VLUFyoQxWJWd1es9i2IF+8qgm
         jSv/glpjM2v8EeFkBxhOJOrtm5FkVhoXa7NjlSiTv36Jo/bGFDhPloBIeVb3+a2lclhB
         vY0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708507715; x=1709112515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hq8KJ6FUW+dUn5EF4x4k+Yc0eSHWRUNZYxQmVAAMYJc=;
        b=qzrYa7p1iR2GtItIs+8aH04ZZjIRDJpIZrGm3u+VRx0hebiZdehCQQuxhsx+2FBhFK
         5As+Kqs0R47tuEBTs2rlV2B0XIvvROiVBOjaDB+XJNALjkhzdCh9x80jrndvmPI/tMIV
         +QxFg4QazuMqecTGcNtfjHphCSRnQ3x1GX41fg4W7rgIA2xfumaCCa+tKbekanXWFXRA
         VgummsdtRY1XGWssuDFgSpwgNKuzhX5z1YWRnaf8rw0b1I7ZMUXIDiNRGAZ6AGK9LBi5
         L5lKGi45JGKm2+WTp1KdLBT/mQiRxtrmtziNkm09uK51HwKANJ15ZWttzcDP60TgzcFL
         0I+g==
X-Forwarded-Encrypted: i=1; AJvYcCXsw0MOr8GbSftdm8Fp96K9Gm53dxDLGRKC0EjO7T2c1EKXsXM+S8oaCoPMWUT4Ts9iNl9ZqXVZwG1HUYvOQVLlMLpkgm0=
X-Gm-Message-State: AOJu0YyXLCQiTqgvVqk87l9AwQNaUGxC1FgrKaVaSUVtEVzadUaF4dBq
	CKtBwZY0Xiu0FkDqpdGBRZQ6BBBtZ06ff5+yUmhIk7/+z7IAegN+QxakvSlb1t+yYJgjClbxzos
	fiLdUQ9A5AoVTcOuSI3zV4xaDqgK9WJSngx0g
X-Google-Smtp-Source: AGHT+IFVBpH9fLue/cQ4cgz0WNF2n+3fm/CyQ+oI4lMHOKKC2JD3RQlkGlCDrGZ/wN8PXmrbUnhNrhpJUikMVBqoPdc=
X-Received: by 2002:a0d:e8c7:0:b0:604:dd57:7845 with SMTP id
 r190-20020a0de8c7000000b00604dd577845mr17964155ywe.2.1708507715007; Wed, 21
 Feb 2024 01:28:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240208152808.3712149-1-howardyen@google.com>
 <20240213055426.GA22451@lst.de> <CAJDAHvZGnzKPLaovRcq_Os1Fcixp2o1kY9GFV8VXztrmKahejQ@mail.gmail.com>
 <20240220055241.GA7554@lst.de>
In-Reply-To: <20240220055241.GA7554@lst.de>
From: Howard Yen <howardyen@google.com>
Date: Wed, 21 Feb 2024 17:27:58 +0800
Message-ID: <CAJDAHvbOnAvW5f6oJUnuy2_5-vS7uJc13GQSNX_Nc25GJXSp-Q@mail.gmail.com>
Subject: Re: [PATCH v3] dma-coherent: add support for multi coherent rmems per dev
To: Christoph Hellwig <hch@lst.de>
Cc: m.szyprowski@samsung.com, robin.murphy@arm.com, gregkh@linuxfoundation.org, 
	andriy.shevchenko@linux.intel.com, rafael@kernel.org, broonie@kernel.org, 
	james@equiv.tech, james.clark@arm.com, masahiroy@kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 1:52=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Mon, Feb 19, 2024 at 07:12:18PM +0800, Howard Yen wrote:
> > I tried to upload the patch to support multiple coherent rmems per devi=
ce
> > because in some system, the primary memory space for the device might
> > be limited, so that add multiple coherent rmems support per device to s=
atisfy
> > the scenario.
>
> I'm not sure what the means.
>
> If you have non-trivial patches you really need to explain why you're
> doing in detail as you need to convince maintainers that it is useful.

Thanks for the response, let me explain more.

The reason why I tried to propose this patch is that in the system I'm
working on, where the driver utilizes the coherent reserved memory in
the subsystem for DMA, which has limited memory space as its primary
usage. During the execution of the driver, there is a possibility of
encountering memory depletion scenarios with the primary one.

To address this issue, I tried to create a patch that enables the
coherent reserved memory driver to support multiple coherent reserved
memory regions per device. This modification aims to provide the
driver with the ability to search for memory from a secondary region
if the primary memory is exhausted, and so on.

--
Regards,

Howard
