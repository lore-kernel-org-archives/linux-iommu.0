Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BC03D7D88
	for <iommu@lists.linux.dev>; Thu, 14 May 2026 08:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778745995; cv=pass; b=oclG6ub8k18WFEgSGVOiNhoH8tv2NqoY5BVsBg50lf6R6K/oBwv47HABvcyyIuQ0ysxqyJZxEndF0h+3Io4tJOgg/bIkvTSgRcNS3+JIADgi7vC4T2980Wf9MnvkLn+WdBI6i9qDLOvtJTEKAYLDlE+o3FC7/Otbcnse+kiYE6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778745995; c=relaxed/simple;
	bh=kULtJx0tmeW4GuTbqeswULlbN9hTWpiDyjj2wWWYuV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c4T2/hjhnDe/XxQRi503QB8/bYg5C4msrmVdN7GzeGpJdgCo40YYeF1p/P4hlW+qEpJLrNU8dMPGtZAKpj1B4LUAq6bzkLDL3r6ybFGeGUDcxJOA6snHp1ic6q13OPz2oYiKhl2lph6GHj5Ze4RxvyW3HeiS8UuWZFZ3HNlgLXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qavM5TvW; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qavM5TvW"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50d6b393d60so378891cf.0
        for <iommu@lists.linux.dev>; Thu, 14 May 2026 01:06:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778745993; cv=none;
        d=google.com; s=arc-20240605;
        b=KuXqlHNIGP6TKGCAzoq5dcnn1MjBv9Y64G/pcheOjOr+XMq7uo6yhOjIshpOBflbkt
         O+iTE+aRk06CyCqr5Ol083fLLwyTdsGk943RCtj+3BIRZSVetIPfnIqtLkCQyDFjuX3f
         iPvbbak94sLHMyr1npp7NJjAkpixCuO2piqrM5TAvVi12fz7Jqjc4uYPJ4v1DIUPpl0N
         8xn+UJW1OCsjJNdHNseStKM4lANXgSZCryGTcFY5DKNSlTeXpbH5p68SSWwhhcXs6o2M
         O0WrkcS48CJtNZoOC5JGTt08kTCURN5isSQtAmXKjHBJrfl4JP9it6PGDJE2SJ+cJ+yn
         UvjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QXdd7FnOAYRaLS7B63YJ6ysgGCzM3+RdD/s5lYMWf1I=;
        fh=VD+yHVaqdf5Y9GMP5RWLw+COYQccFhNJtzzpMxSWVQc=;
        b=MniZim3zFBhOYaRJ53i/96RDXoVM/kULxD/S98X/rs+lfB7q11GRGSV8fcswjY2Hci
         G2lYxVSnKYdIeou1NsGszvmS+HX1+RCa4GCLH7Atg9cyrqrvzTYjhyIW6vyRdQElwJia
         0Ti3JLImdETzbwrwr4twq/umiHPaxHUhQhEaW644twPVkHp/6+1Drc3lVGrkvJnhkI+k
         vvo3ndF1v5a15VVXnAxYsSnxSBeKH1gvpip0WEw75rjw9DFywXCNZclx5StO++Cuh7fw
         NBtlWuwKDzN/qWID+oMPX8N7neDPZq67TMsvb2Vv79oWa/uQelk5XdFeu+VzAeKF1D1M
         bjXQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778745993; x=1779350793; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXdd7FnOAYRaLS7B63YJ6ysgGCzM3+RdD/s5lYMWf1I=;
        b=qavM5TvWvaWdy7WubL1SCeyXCQPOwoHZIGQY6toa+71z/VqPwopBO/0YITyCam1hXb
         ua18FY5fRrK6rCPtQBzSTLVobAr+VoDpKpJnwX+u/pJ16IdZtGcXKb1Q7HxCL78HO28R
         C//md1vJg8qOt42Us0SQZAFInDd5WMSnOfnnBM2vVlrhXpYJ6qUNWhfPxq5GOpqgmCI6
         HQ9N5k2uy2xxsDvujGCexyeS7ksSk126E0kj5SVLAHkYDNmTxpdRSdQO5K5iPWkqzrA/
         TG+Ssf0gcndprHybuc0LXHhuPZL2K9TyUhiLPPVhSCrtzmUMkvqQfdLSSfGAsBeMvmM5
         NO1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778745993; x=1779350793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QXdd7FnOAYRaLS7B63YJ6ysgGCzM3+RdD/s5lYMWf1I=;
        b=spDFG2ChekQ1N85WuqhOhH5QpIx8gs8Gp24Kk0ZUlFea25a6F3Uy1TcjfrA5AZxJqp
         25feXz04/IIFtuXvwvc+hi08FkNzfOJMP4FIkhHTg0zfER3VOh0mctoRIueX8jjtMCZ9
         o5Ixk9SSK992hELdiIf9vHRstdNQjb2V3EfIJgK1hOCy21QTYqOHSFvqvaB1V+KUCMxt
         geL7o0ue/htda26GOy55Uz0pmA7KBRed+x0GHdS1zl06mcm5qcReUPsTr3PqMMEjigf4
         jpgnbHFRJ6Oogt7TvRhUM5k52vltnuzIfl0WJfb8GBSnOK+U8/4+5UoAzRh3AlNh+yKu
         xJ8A==
X-Gm-Message-State: AOJu0YzuM7Vl/5sQPQ9QkTSM3VeBcb864KnRe73Sy8xaMeQDLlBSqwYa
	2+SigXNMQnLp4I2bIW80Gd9/LLlSxG8GuTWMcAbBD0gECMgXSCL71mWkaqAeWj6dzrH0F0Gz6nb
	VslFDHFCbqUCno9MRKmozCyJl0lKMwgsxYhS6ZGZL
X-Gm-Gg: Acq92OEfYZVj3AYFX7E+dRFARL57t4Op+E/tAp9e3oRLaGrD/3nmp8y/F3cbprSvaIP
	4meMlUcb2CnvBZWfXjziExBg9sSxUAH0/UJA0U+EaI5WPZ+m7sJy7J6ETuIrCZVb93RwNqxY3Tk
	8/dDiwQom9GaFCkIOKpVJL7c/IOFVB8ivzZ8IUB8F+X/yFGJLl/2BsFW0P9HStOUeaa5jsf1zuW
	U3XjFZ4Gzo5ElMh3wAaT1n2Y2oVAwZn1rFQ4YwTIYNsoo6ZkuyiH/CSJ9Z8bCvs1J/w4vXO0cBM
	/EO1C2TZtEDV8QYOdtdmSqc29mzmZLX1WkoF45v6QsTjSWhz
X-Received: by 2002:a05:622a:9007:b0:50e:6360:96e with SMTP id
 d75a77b69052e-516420a4ecdmr12032231cf.0.1778745992401; Thu, 14 May 2026
 01:06:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <20260512090408.794195-4-aneesh.kumar@kernel.org> <agSED6BdSXBhbDYI@google.com>
 <yq5abjeia315.fsf@kernel.org>
In-Reply-To: <yq5abjeia315.fsf@kernel.org>
From: Mostafa Saleh <smostafa@google.com>
Date: Thu, 14 May 2026 09:06:19 +0100
X-Gm-Features: AVHnY4KFUT_Q3ProEjcPRlzXFAyPmNH0RBADajCyGfb0sF72QbGsmq65dFwn1XU
Message-ID: <CAFgf54qB0msUdKakDvh7hp0r5kokPV0vohBxUjkOz7sR1FZNuw@mail.gmail.com>
Subject: Re: [PATCH v4 03/13] dma-pool: track decrypted atomic pools and
 select them via attrs
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Steven Price <steven.price@arm.com>, 
	Suzuki K Poulose <Suzuki.Poulose@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Jiri Pirko <jiri@resnulli.us>, Jason Gunthorpe <jgg@ziepe.ca>, Petr Tesarik <ptesarik@suse.com>, 
	Alexey Kardashevskiy <aik@amd.com>, Dan Williams <dan.j.williams@intel.com>, 
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 8:01=E2=80=AFAM Aneesh Kumar K.V
<aneesh.kumar@kernel.org> wrote:
>
> Mostafa Saleh <smostafa@google.com> writes:
>
> ...
>
> >>  struct page *dma_alloc_from_pool(struct device *dev, size_t size,
> >> -            void **cpu_addr, gfp_t gfp,
> >> +            void **cpu_addr, gfp_t gfp, unsigned long attrs,
> >>              bool (*phys_addr_ok)(struct device *, phys_addr_t, size_t=
))
> >>  {
> >> -    struct gen_pool *pool =3D NULL;
> >> +    struct dma_gen_pool *dma_pool =3D NULL;
> >>      struct page *page;
> >>      bool pool_found =3D false;
> >>
> >> -    while ((pool =3D dma_guess_pool(pool, gfp))) {
> >> +    while ((dma_pool =3D dma_guess_pool(dma_pool, gfp))) {
> >> +
> >> +            if (dma_pool->unencrypted !=3D !!(attrs & DMA_ATTR_CC_SHA=
RED))
> >> +                    continue;
> >> +
> >
> > nit: If we fail to find a matching pool, a slightly misleading message
> > is printed as pool_found =3D false
> >
>
> The message printed is
>
>         WARN(1, "Failed to get suitable pool for %s\n", dev_name(dev));
>
> That is correct, isn=E2=80=99t it? The kernel failed to find a pool with =
the
> correct encryption attribute. For example, the request was for an
> encrypted allocation from the pool, but no encrypted pool was available.
>

Sure, I=E2=80=99d prefer a clearer print in that case, especially since tha=
t=E2=80=99s new code:
=E2=80=9COnly {encrypted/decrypted} pool found for a {encrypted/decrypted} =
alloction=E2=80=9D

But no strong opinion.

Thanks,
Mostafa



> >
> >>              pool_found =3D true;
> >> -            page =3D __dma_alloc_from_pool(dev, size, pool, cpu_addr,
> >> +            page =3D __dma_alloc_from_pool(dev, size, dma_pool->pool,=
 cpu_addr,
> >>                                           phys_addr_ok);
> >>              if (page)
> >>                      return page;
> >> @@ -296,12 +345,14 @@ struct page *dma_alloc_from_pool(struct device *=
dev, size_t size,
>
> -aneesh
