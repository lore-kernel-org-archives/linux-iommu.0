Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593142116F2
	for <iommu@lists.linux.dev>; Mon, 19 May 2025 21:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747691496; cv=none; b=WAAZ49TWh+mXOo1CBhq6rfDxl760O8pUAAGLyttYJae/uauC9dy9lYXJSn4F1rg4MHHivEd5+zY6SBxKQeiEytHrH6R8rr+qxlnmS8nSd1UXCIb+P9N7hwQUuVVxrtplabwVGbtSO9/Py8ryfpm1pputIlN2rHUbi6k+dT9DToU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747691496; c=relaxed/simple;
	bh=D+gc71TQ6arDdz5CgOztRV+6NsleF2QKzmZFFkhPPvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sJsJ7EQK8TnR5yaPAJB1WfQnbTKQ882hWDN7bKo5brCoaVGgVi3Dzie1mVb0io7Qyj2FhZXfgfD9ulv4M7AzUTsELyc7RyZ5k68KkA6U8jrT8v1110aQEDnbnEIg9vuvLrjMMPdNDiOaTT7I4u40Hs9edfMrWvEqI8Vq2ADGfv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NoHPojb8; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NoHPojb8"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-85e46f5c50fso465542439f.3
        for <iommu@lists.linux.dev>; Mon, 19 May 2025 14:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747691494; x=1748296294; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPEYHOAa9cIet4iZua5k6szVG47y0INiUwKTR9frvBc=;
        b=NoHPojb80SB5plIhJOiuinBKJQvGGF4Yu2gTPu/yPvzrEel/lYgP9ijSAC+4lQNagi
         BIoJdgjmD9ZIntEDVe1Wonj8cX95gd7L4AOG/1EKns3msPVolJegit9CAZOC5rFHXapW
         eB3A6M7RUhL/W81gMLpbLYnyiNFNKqb6Tsgv5WgAmAZXEbRegy6ZhjugsgrzRFLp5eb5
         ZzUxa0IbXCKoly5Pbr/RA86D3x7BWHg0esBfV8nga2UosrpVkZvpw+pGmTpD/pxWeTRT
         tYhOWYmkp8/SZyIEPQJ8YjaH84Db9S4hAcnXpBOYVlpCPdFfZRS2rSF7j2t/TpUJzVeh
         a8EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747691494; x=1748296294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xPEYHOAa9cIet4iZua5k6szVG47y0INiUwKTR9frvBc=;
        b=Wa3DxYaBJzc89QteV8uOxMIkyjugl5qJPPfnNmLCCpm+wEzxtwGoI8lGFq/ePb2zRz
         Nix4cdyUtEm4CeLvj77Sfp6Q7gG16L5+9nAqDYMbRRzY+icCVZgDKzEZrNUmHO9/sQ78
         ePrkvZI7IMbpbYhZk+zPIpXi8fdLyNNrUyndhhQuhKEo3JPb0RQ0RkU/wP8uQGoCOySN
         TThs8350ZfymQmyknWfGV9p9wGZQ3r1wAwTdAG4vtSW0dDrn4wzK0tdazyST4nrGrO8/
         25Lq9TDJsu9vj5UNTygULQjEIAHfuJxjgVaYdh8FrIBRwOo/X/Lk7gaBYrXTf281elwl
         +z8g==
X-Forwarded-Encrypted: i=1; AJvYcCXGshFclGCb05HB07K5oVbf8U5yXzDgPmQf75KBUNHwvYRntBgauVcJt/C6r3E0rqp//G5Zeg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzqmuI5yFFSA/zSOtdTmbcRJCZWMj20MqE1n5XZOlwCRHIdDvzK
	q8z9JvY4+Vpd9YVFge9TPyDxaOeAm5/iR5qT/QcyfG3H5T4g7njfawq9NmwYY1Lg/mx7qS2fnG6
	C54P/ik2f3n3iCvHJM8IZxZ7Kq1gzZ14=
X-Gm-Gg: ASbGncvxmwCNMEr9dFbuYHHSTO/sKRNsg3JWSStse1F9An7pkjN6Rmm46dHTePUR8yt
	y888q4mtEkNJa7Eg5Ynb9uHZkAJPzGwrofC2DO/+6H98rKZce5AqZ2lwJtnj4ZV+aXPmr6Yzemr
	kG6f9SPRQ/N5XUPb3zdrSvnmP/cEhlVEqKkCVdTI1xb590iiPgIUEYlp6Jdc0ybWI2zRcma5s7B
	uXh8w==
X-Google-Smtp-Source: AGHT+IH7GskHnBBBnN3dCWe5+4wA68V6kn1SwK+BKY5czWCCWv4gMQRXKFVR4ovK9isr0sjORC+Rjt5sK8DipW7Cf4U=
X-Received: by 2002:a05:6602:6cce:b0:86a:93c:f5fb with SMTP id
 ca18e2360f4ac-86a231901efmr1968076439f.1.1747691494249; Mon, 19 May 2025
 14:51:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250519175348.11924-1-robdclark@gmail.com> <CAPM=9tw183FMOT8uUacqegnb5CREAyr8KbXxO2mCuFK-SmUB1A@mail.gmail.com>
 <CAF6AEGuDTGVq7sw4oVuHb+cOE_DuKbEPO956oddVcsV2boieoQ@mail.gmail.com> <CAPM=9twuSfvQ0_NUdRmp0_VtTE_Br7GAysRw+XOoX7BTxUBGYQ@mail.gmail.com>
In-Reply-To: <CAPM=9twuSfvQ0_NUdRmp0_VtTE_Br7GAysRw+XOoX7BTxUBGYQ@mail.gmail.com>
From: Rob Clark <robdclark@gmail.com>
Date: Mon, 19 May 2025 14:51:20 -0700
X-Gm-Features: AX0GCFvmTvCANqDHHj2TPhXNkmFs3wC8dEXWRCEtBjip_pfclRDeM3uxGEixFZM
Message-ID: <CAF6AEGs1hNGMMBjZuXoGjxF+JA1AHY_wx=gmqK4z=zShYoR6=w@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] [PATCH v5 00/40] drm/msm: sparse / "VM_BIND" support
To: Dave Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-arm-msm@vger.kernel.org, Connor Abbott <cwabbott0@gmail.com>, 
	Rob Clark <robdclark@chromium.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	=?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Arnd Bergmann <arnd@arndb.de>, =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>, 
	Christopher Snowhill <chris@kode54.net>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Dmitry Baryshkov <lumag@kernel.org>, Eugene Lepshy <fekz115@gmail.com>, 
	"open list:IOMMU SUBSYSTEM" <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Jonathan Marek <jonathan@marek.ca>, Jun Nie <jun.nie@linaro.org>, 
	Kevin Tian <kevin.tian@intel.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	"moderated list:DMA BUFFER SHARING FRAMEWORK:Keyword:bdma_?:buf|fence|resvb" <linaro-mm-sig@lists.linaro.org>, 
	"m oderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:DMA BUFFER SHARING FRAMEWORK:Keyword:bdma_?:buf|fence|resvb" <linux-media@vger.kernel.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Nicolin Chen <nicolinc@nvidia.com>, 
	"Rob Herring (Arm)" <robh@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Sean Paul <sean@poorly.run>, 
	Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 2:45=E2=80=AFPM Dave Airlie <airlied@gmail.com> wro=
te:
>
> On Tue, 20 May 2025 at 07:25, Rob Clark <robdclark@gmail.com> wrote:
> >
> > On Mon, May 19, 2025 at 2:15=E2=80=AFPM Dave Airlie <airlied@gmail.com>=
 wrote:
> > >
> > > On Tue, 20 May 2025 at 03:54, Rob Clark <robdclark@gmail.com> wrote:
> > > >
> > > > From: Rob Clark <robdclark@chromium.org>
> > > >
> > > > Conversion to DRM GPU VA Manager[1], and adding support for Vulkan =
Sparse
> > > > Memory[2] in the form of:
> > > >
> > > > 1. A new VM_BIND submitqueue type for executing VM MSM_SUBMIT_BO_OP=
_MAP/
> > > >    MAP_NULL/UNMAP commands
> > > >
> > > > 2. A new VM_BIND ioctl to allow submitting batches of one or more
> > > >    MAP/MAP_NULL/UNMAP commands to a VM_BIND submitqueue
> > > >
> > > > I did not implement support for synchronous VM_BIND commands.  Sinc=
e
> > > > userspace could just immediately wait for the `SUBMIT` to complete,=
 I don't
> > > > think we need this extra complexity in the kernel.  Synchronous/imm=
ediate
> > > > VM_BIND operations could be implemented with a 2nd VM_BIND submitqu=
eue.
> > >
> > > This seems suboptimal for Vulkan userspaces. non-sparse binds are all
> > > synchronous, you are adding an extra ioctl to wait, or do you manage
> > > these via a different mechanism?
> >
> > Normally it's just an extra in-fence for the SUBMIT ioctl to ensure
> > the binds happen before cmd execution
> >
> > When it comes to UAPI, it's easier to add something later, than to
> > take something away, so I don't see a problem adding synchronous binds
> > later if that proves to be needed.  But I don't think it is.
>
> I'm not 100% sure that is conformant behaviour to the vulkan spec,
>
> Two questions come to mind:
> 1. where is this out fence stored? vulkan being explicit with no
> guarantee of threads doing things, seems like you'd need to use a lock
> in the vulkan driver to store it, esp if multiple threads bind memory.

turnip is protected dev->vm_bind_fence_fd with a u_rwlock

> 2. If it's fine to lazy bind on the hw side, do you also handle the
> case where something is bound and immediately freed, where does the
> fence go then, do you wait for the fence before destroying things?

right no turnip is just relying on the UNMAP/unbind going thru the
same queue.. but I guess it could also use vm_bind_fence_fd as an
in-fence.

BR,
-R
