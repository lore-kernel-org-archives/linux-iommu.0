Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345741CAA85
	for <iommu@lists.linux.dev>; Thu, 26 Jun 2025 05:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750914370; cv=none; b=G+fjv/rUMeyKCCdJc6fTAk+OzJX/zP0SckMo3k39oKsh9Qi2wpWkRifJGqcq/e2XP87pyqJTf8MV+JTSiX03zknJ6sRiwO/QhBVH6IsmuUOMtTLG7+oTQTpe7Yqnt6syVbDR36ZTHOrGLelmRGfVzBQNwJZuHmD/ydEAKadBAGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750914370; c=relaxed/simple;
	bh=SlJAuSKpyDkgrbvJ3UERKHC+t9+jkJayQEaDBL/a9TY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HKhYMWypluyyYxQCfvr6O30280eW0kj4VcVrT//Q2oEWKLI+GfKog8qqKfZEw9C4019hAx/kcXzMcre5DTxwJ1NVgrdPsmrzPwoqUmOEkIu9s1f723vzKbKBCjLjsnLj1cXQYw0bn6gCIPSlxni+QtlN8opM+K22hFDvh3lXkuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OfL3QiGM; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OfL3QiGM"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-606b39b19b6so102844a12.1
        for <iommu@lists.linux.dev>; Wed, 25 Jun 2025 22:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750914366; x=1751519166; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UtVCqJAeH13XxyBvl5sUjNns6ovF/jyU+YftL8Si5vI=;
        b=OfL3QiGMoKzeYsCMt8MghA9yIMzmLkyzglg/g4gwkQt5gl3zueXZ5fq9enyQv69uJe
         4R8kGHT3mvCMtQvohSgNVX91jmceoYbtXNhfNFPLfRNuLKBnu4b6YsgTsh8asSD0J1jE
         mM2obw9wRNNZ4J+LudRp1U0778qaMaozx3HaM7XG3+3wjhBmmetVVF7OmDcGggGN4tXR
         57M81G1/Pg73AOYBSqSqdy0C/I45wrxagep3HsSUbbQLZADk7CpYwhHFTXewZ79DGEqK
         0Z5jjMQ8z3HhkdMDKedz376iiy4NqNaYEPxuMKygxqVxX53kfDHM9/8LqHARsmtMfOmF
         cf4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750914366; x=1751519166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UtVCqJAeH13XxyBvl5sUjNns6ovF/jyU+YftL8Si5vI=;
        b=Qw2ObLkdFLYTxYDkEdDjRpleFZSsieyzscdMWAAEps8z2e/Ni4brXBv1x/yu3kqwUQ
         QEnLsYf0OeUsGfgLaru6MKobDrq1HdYtilUbdgdW8EGO2RqXc5vNH7WL+QdK7vFEFe4p
         bxxrprqixRSb3LTBtM4y1YgR8nqFr8Ew6Ku79Rsq56cseVtY6BntIheaT1ClqrYHjB8E
         wU0IFU2oyIEOGBnn5/XI+oZ1sa/I/fsCxyW7NYCSoVVn9Mt/k4gaN8kkDqp3mX67UaaS
         5WSN7hu/PGE7MkIQbJ01hyILD58/dHadgCmyhYEi32dEMoMHeli2ywqgdHgnJOFGAZNc
         KF1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVkf6WhiTaQuEFJBv9hFn0XVoanIE0n7Sflgl0w6hml/ZnkMCcPWe/OS9Ey4LHWvNdKCtKQ4w==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywb+EPKghX7GcAL6RJzUoRZFuYXsRH56ANwZ2giCLilBYkwX8g0
	cuFkrzAvrl59287aAnUmVwk4SwDuwmGQG5SmMNPt+tIDo+wciV8uPDhrxG+8QeiFM9s=
X-Gm-Gg: ASbGncsM+2rNmkbWTc+CtLgPNkvOh7VHkJ3h5YkjoQNuqZuFyPpCNp8Cc76ksXGY9IO
	UhppTGshwAty1FDHrlcFNXUULKidy9f+I4K0O0+3hoiXdMSOGcR9maG2B6MdC8QeVc66BxkAuAr
	f2/PNpmnxZsT90xfXBwZ2LomDeJ2YU6pmAKbqdGAb5EwW0XSCfYr5sQOkHSgEx6/vsyBJ01L9Qf
	4TCzUHP5lNOBGvcRnqvPp2uTU7CFLm9LzhK8F1gY9z47ARdwfcuLmcIICJNpxfGVgLcEO64g6pA
	KD/fQAtjHe/jK7ILGl6Lqg04sQbUc/H4VLSheWHzg9w1vQ==
X-Google-Smtp-Source: AGHT+IGL+2QsRWwulNb9W8gpCcvsfj+qYhvE5q/YlnOTjKxvi2e+r0wusCertjz9fW8rlZ/Gl3vWfw==
X-Received: by 2002:a05:6402:5114:b0:60c:3cca:6515 with SMTP id 4fb4d7f45d1cf-60c4dbc656dmr1619383a12.4.1750914366035;
        Wed, 25 Jun 2025 22:06:06 -0700 (PDT)
Received: from mordecai.tesarici.cz ([213.235.133.108])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c2f196fa7sm3318565a12.2.2025.06.25.22.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 22:06:05 -0700 (PDT)
Date: Thu, 26 Jun 2025 07:06:02 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
 <robin.murphy@arm.com
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Morton <akpm@linux-foundation.org>, Leon Romanovsky
 <leon@kernel.org>, Keith Busch <kbusch@kernel.org>, Caleb Sander Mateos
 <csander@purestorage.com>, Sagi Grimberg <sagi@grimberg.me>, Jens Axboe
 <axboe@kernel.dk>, John Garry <john.g.garry@oracle.com>, "open
 list:DOCUMENTATION" <linux-doc@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>, "open list:MEMORY MANAGEMENT"
 <linux-mm@kvack.org>, iommu@lists.linux.dev
Subject: Re: [PATCH 7/8] docs: dma-api: update streaming DMA API physical
 address constraints
Message-ID: <20250626070602.3d42b607@mordecai.tesarici.cz>
In-Reply-To: <aFynHWAYtKPFT55P@archie.me>
References: <20250624133923.1140421-1-ptesarik@suse.com>
	<20250624133923.1140421-8-ptesarik@suse.com>
	<aFynHWAYtKPFT55P@archie.me>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Jun 2025 08:49:17 +0700
Bagas Sanjaya <bagasdotme@gmail.com> wrote:

> On Tue, Jun 24, 2025 at 03:39:22PM +0200, Petr Tesarik wrote:
> > diff --git a/Documentation/core-api/dma-api.rst b/Documentation/core-api/dma-api.rst
> > index cd432996949c..65132ec88104 100644
> > --- a/Documentation/core-api/dma-api.rst
> > +++ b/Documentation/core-api/dma-api.rst
> > @@ -210,18 +210,12 @@ DMA_BIDIRECTIONAL	direction isn't known
> >  	this API should be obtained from sources which guarantee it to be
> >  	physically contiguous (like kmalloc).
> >  
> > -	Further, the DMA address of the memory must be within the dma_mask of
> > -	the device.  To ensure that the memory allocated by kmalloc is within
> > -	the dma_mask, the driver may specify various platform-dependent flags
> > -	to restrict the DMA address range of the allocation (e.g., on x86,
> > -	GFP_DMA guarantees to be within the first 16MB of available DMA
> > -	addresses, as required by ISA devices).
> > -
> > -	Note also that the above constraints on physical contiguity and
> > -	dma_mask may not apply if the platform has an IOMMU (a device which
> > -	maps an I/O DMA address to a physical memory address).  However, to be
> > -	portable, device driver writers may *not* assume that such an IOMMU
> > -	exists.
> > +	Mapping may also fail if the memory is not within the DMA mask of the
> > +	device.  However, this constraint does not apply if the platform has
> > +	an IOMMU (a device which maps an I/O DMA address to a physical memory
> > +	address), or the kernel is configured with SWIOTLB (bounce buffers).
> > +	It is reasonable to assume that at least one of these mechanisms
> > +	allows streaming DMA to any physical address.

Now I realize this last sentence may be contentious...

@Marek, @Robin Do you agree that device drivers should not be concerned
about the physical address of a buffer passed to the streaming DMA API?

I mean, are there any real-world systems with:
  * some RAM that is not DMA-addressable,
  * no IOMMU,
  * CONFIG_SWIOTLB is not set?

FWIW if _I_ received a bug report that a device driver fails to submit
I/O on such a system, I would politely explain the reporter that their
kernel is misconfigured, and they should enable CONFIG_SWIOTLB.

Just my two cents,
Petr T

> >  .. warning::
> >    
> 
> LGTM, thanks!
> 
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

Thank you for the review, Bagas.
