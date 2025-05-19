Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77543219A8C
	for <iommu@lists.linux.dev>; Mon, 19 May 2025 22:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747693394; cv=none; b=UwCysCjiml4tMQMhmF7bPfk1o/wMe3uDkVErcC2ClgiCMHAxEng1uUt8d+E2x57OcNScvKkj4nXrFFWu3GZbARlc64gmmjFSoVADSAQf/qlfS1TPwlEtosqtMFqU01PuZLv8aP9m8uzOH5McMJ+Gx1CoJSXjtsetalygbEjG1E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747693394; c=relaxed/simple;
	bh=RYED3sQgGz9EupaD5CYEhvZIMBoQfnY09zAfixeh7p0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qEDzU0bIselx1r7wREzyIcBcVm6g0rWx93rHAnMT4toJTDKl9mR+4ng89b9sPRsDqqQ5jokJ/YVjgk/SkFgBlPg0JPyIRWsPH7rSAvOgS9lGeyqToXUYKfv/YGEI3NdAS28E9J8Z9UiIOb0s1GG1J2q7V36OOZboevGyXEb43vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lLs7TTeh; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLs7TTeh"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-309e54e469cso832225a91.1
        for <iommu@lists.linux.dev>; Mon, 19 May 2025 15:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747693392; x=1748298192; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G22uQtTerCT2IQLmvJfExO7LKRCrhoW6/tlkev0t9aE=;
        b=lLs7TTehUXCxTHRI1rZ5h9fLL5N2st+wfynjFgJZ9WQC+XJCnYxFCcaDSt7qBwSU9w
         nhhHJpzG8KyvhbR5iwvnYFY7H83uU96snwyEaQ+tGaKB9aQmj1xSYtF6Ag/mlvODt70/
         UZeYHAEW+zxAY7rH+Gj8EgTMt65Mb56EJwDXfkBYiowF/5wxvNmuBKrtV740uz5y0XId
         0FqZJ1cJGIOUaMrEJniCWc0NU38vejshsSJgHaNF5wfxVn9PUivZ8lJqcjFeFhSJe3Yn
         fKzmOWIH0Kc1TlKCirOb3pefd2c4fjQ2sxkEnOaXYNJ3PZ5UVangEQ6uLTYf+Pxe8noT
         aVxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747693392; x=1748298192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G22uQtTerCT2IQLmvJfExO7LKRCrhoW6/tlkev0t9aE=;
        b=eWU/fTqsaAtRERJ7fGv/+m7RaPHUUEG3s7WQTLDghLUsFqLvWTzX4pZbeun3GGBf6R
         VXmeVdopIq4o8/2X6KaTJbeKtkRlFBS9jRnLdLpH64aKZ1q2hYGj9fdGV65bS6Bk72sJ
         PREMJrlmOeAVHz1u+Hh9mudSWHYSJEJx02ZXqfMB1NvnxvzSc1VrMxmnyyWxS8k2JFWW
         Uji8yqjsLEuzaYczHSVpJMv8u09cqANA2NIAgiDHdTkjkSyjtDa2WHi57zrwXmiajzCE
         7WCImWW+mr0ICh2jOSw5PzD+ej42JnDUHVgqGYoMnGrMy7mCjec/2/glGky48SpfS4jJ
         er8Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6hH7DProNVU/BHE+mKyNlS8KRNODdZeqMveEfulxI1pUPAycnszeuiqQGjYrvtFu4FJunVQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzR0eNsn2uujqW53FY2QayA8fJh62Jz6vR6GjU/4v/1wKLdCv9d
	VRMvMlONm/2wMeNR1wV2zOxgqzKSuFdw/EnCiwbiOA92VDnD3bqkumHb2VpIu8AezXeZIf829dr
	8vguoVgaMP92x+rIDO5mimn9ILsiQ+1g=
X-Gm-Gg: ASbGncu6k2wtOvErZ8RvCygugYbg2l0h0GEK1OX/lRYtRK2Q7mNq0j6/zBZtFBcs8ei
	RVbM+h17sIOgcfXqqdm7Gux6rgwy2F7CpK5YXWJUTRqf8XJWkF+Qf0CxBhZDXpvv/nmmJyNpqLB
	X+vIV36aU5vvORbCK5ZW/Opeh2hXKMYRGs
X-Google-Smtp-Source: AGHT+IHzzYJdNjGnggVED+WkMWpZnSPWu15906SWYLh7fgSNgz1VKnuTByR3QO+KIJPYuFChXuYVwQZLc03eivgxOW4=
X-Received: by 2002:a17:90b:3e8b:b0:30e:7127:644c with SMTP id
 98e67ed59e1d1-30e7d622f13mr8368159a91.6.1747693391512; Mon, 19 May 2025
 15:23:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250519175348.11924-1-robdclark@gmail.com> <CAPM=9tw183FMOT8uUacqegnb5CREAyr8KbXxO2mCuFK-SmUB1A@mail.gmail.com>
 <CAF6AEGuDTGVq7sw4oVuHb+cOE_DuKbEPO956oddVcsV2boieoQ@mail.gmail.com>
 <CAPM=9twuSfvQ0_NUdRmp0_VtTE_Br7GAysRw+XOoX7BTxUBGYQ@mail.gmail.com> <CAF6AEGs1hNGMMBjZuXoGjxF+JA1AHY_wx=gmqK4z=zShYoR6=w@mail.gmail.com>
In-Reply-To: <CAF6AEGs1hNGMMBjZuXoGjxF+JA1AHY_wx=gmqK4z=zShYoR6=w@mail.gmail.com>
From: Connor Abbott <cwabbott0@gmail.com>
Date: Mon, 19 May 2025 18:23:00 -0400
X-Gm-Features: AX0GCFuLTqHkTFoflT1PTGQWqYxrqs7RNvsrTX0PlbvFOcOu3Zb_RqPfkkrC9DU
Message-ID: <CACu1E7EJp1fvQZV0=qeAqH97qaeoiaybHqxfYa7hFmi9P048kw@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] [PATCH v5 00/40] drm/msm: sparse / "VM_BIND" support
To: Rob Clark <robdclark@gmail.com>
Cc: Dave Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
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

On Mon, May 19, 2025 at 5:51=E2=80=AFPM Rob Clark <robdclark@gmail.com> wro=
te:
>
> On Mon, May 19, 2025 at 2:45=E2=80=AFPM Dave Airlie <airlied@gmail.com> w=
rote:
> >
> > On Tue, 20 May 2025 at 07:25, Rob Clark <robdclark@gmail.com> wrote:
> > >
> > > On Mon, May 19, 2025 at 2:15=E2=80=AFPM Dave Airlie <airlied@gmail.co=
m> wrote:
> > > >
> > > > On Tue, 20 May 2025 at 03:54, Rob Clark <robdclark@gmail.com> wrote=
:
> > > > >
> > > > > From: Rob Clark <robdclark@chromium.org>
> > > > >
> > > > > Conversion to DRM GPU VA Manager[1], and adding support for Vulka=
n Sparse
> > > > > Memory[2] in the form of:
> > > > >
> > > > > 1. A new VM_BIND submitqueue type for executing VM MSM_SUBMIT_BO_=
OP_MAP/
> > > > >    MAP_NULL/UNMAP commands
> > > > >
> > > > > 2. A new VM_BIND ioctl to allow submitting batches of one or more
> > > > >    MAP/MAP_NULL/UNMAP commands to a VM_BIND submitqueue
> > > > >
> > > > > I did not implement support for synchronous VM_BIND commands.  Si=
nce
> > > > > userspace could just immediately wait for the `SUBMIT` to complet=
e, I don't
> > > > > think we need this extra complexity in the kernel.  Synchronous/i=
mmediate
> > > > > VM_BIND operations could be implemented with a 2nd VM_BIND submit=
queue.
> > > >
> > > > This seems suboptimal for Vulkan userspaces. non-sparse binds are a=
ll
> > > > synchronous, you are adding an extra ioctl to wait, or do you manag=
e
> > > > these via a different mechanism?
> > >
> > > Normally it's just an extra in-fence for the SUBMIT ioctl to ensure
> > > the binds happen before cmd execution
> > >
> > > When it comes to UAPI, it's easier to add something later, than to
> > > take something away, so I don't see a problem adding synchronous bind=
s
> > > later if that proves to be needed.  But I don't think it is.
> >
> > I'm not 100% sure that is conformant behaviour to the vulkan spec,
> >
> > Two questions come to mind:
> > 1. where is this out fence stored? vulkan being explicit with no
> > guarantee of threads doing things, seems like you'd need to use a lock
> > in the vulkan driver to store it, esp if multiple threads bind memory.
>
> turnip is protected dev->vm_bind_fence_fd with a u_rwlock

To add to that, it doesn't really matter the exact order the fence
gets updated because a Vulkan app can't use anything in a submit until
after we return from the turnip function that allocates + binds the BO
and then the Vulkan-level object is returned to the user. We just have
to make sure that the fence is "new enough" when we return the BO. It
doesn't matter if multiple threads are creating/destroying objects,
the thread doing the VkQueueSubmit() must have observed the creation
of all resources used in the submit and will therefore see a new
enough fence.

>
> > 2. If it's fine to lazy bind on the hw side, do you also handle the
> > case where something is bound and immediately freed, where does the
> > fence go then, do you wait for the fence before destroying things?
>
> right no turnip is just relying on the UNMAP/unbind going thru the
> same queue.. but I guess it could also use vm_bind_fence_fd as an
> in-fence.
>
> BR,
> -R

Yeah, we always submit all non-sparse map/unmap on the same queue so
they're always synchronized wrt each other. We destroy the GEM object
right away after submitting the final unmap and rely on the kernel to
hold a reference to the BO in the unmap job.

Connor
