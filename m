Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736B8221576
	for <iommu@lists.linux.dev>; Mon, 19 May 2025 21:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747689913; cv=none; b=oPJ207ubHg1eyPkL/9Lc8l+1FXX749/5n28J4foRud0ygZ+hccDaYk/KMy2mh8QNPShfH1sLPChlwxLeg1Yp19jiJ5wgy6apkmCH9tIOhwgW9wmD+sWMNX2c76MkO8SxTZ8xVBQGRypbYYFE71PzCNzsyTshLYCPTkm1ROVVMDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747689913; c=relaxed/simple;
	bh=CZ691peLINPSUAyU3kO729Ie7ID8c0016wN9NHPkQps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TXyEM5gwxATiprjoMlAUcVU52MPccTag/ynW5Qjo302qWb7vbD8t/YNb2e/4I6uP03byy2g4n0hKlDA0O0f6AuYwJd/ulZcFtNYq+9HdR8tJZW7Yxe06yvZDQLjQXPk59cIv6ZYOKjrPG0pYLSO4EZIDTS5FYKKN6YAsnQUheRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KpUYq4uI; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpUYq4uI"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-8644aa73dfcso166520839f.0
        for <iommu@lists.linux.dev>; Mon, 19 May 2025 14:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747689911; x=1748294711; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x4mHlbF3wl/qb51JPbWQ5yBWuZWdTliQjQN9iEmdGIg=;
        b=KpUYq4uIfZcH4QOC4WPz0ARfb1Q5OCu22x5mBDMqmwj6ZrhttZ1dz/T720ZMpn2ejL
         TDw2CFkZno9V9vEat4Tgy8EIflg/5EfbGIc+o6WKhRpY5pQ94X3892nPdCxEdea0t+NU
         ro/IbxiSg0w4J3+qbaW2i2FjS6kEJg5xzrvP8Z4YamuiDwYuEJAp4hcDC6C062SGK518
         V5JOteIjoVelFoBTOgrJEPVGEYjbFK8CB79e35BRDkUzcMoJ2VGmx7DAPb3/H4lbQ5cT
         ejk6jP3Qr51Txy+MvQ4eycfj9fb2FSlqsHL0eWljwxBF/MIz+3SUTHUFEtjjiLH5pE2t
         K+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747689911; x=1748294711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x4mHlbF3wl/qb51JPbWQ5yBWuZWdTliQjQN9iEmdGIg=;
        b=Phk8CANmnxDI+YwFGKTRKAOezEu4Puq3rkbwDOoznooVdFFHX/9kNVqvpXscKYNpOv
         ON8+GjBPrruwCizYnerFo1gAZVym0gNpTRi0TsGFkyPEn7Cz1MQSe/B37SeVuW/GHaIH
         i20GUrd5610e+RCkyRI11f9PCSgjvK9aNBcQpZwc+j+WycQsT0IjiYjtukk8CU+RdBVe
         lv8T0Az0jZLsy16fmZMj4j3mwUFzxbZSvCUNvRRGA8L1STxTpF2dbXm8Igos7msMMcdg
         BxUa37HlCgyWVzh8hA854a872rr/1BrKKjIyXalO8iKmusZs9P6WLzjfE1Gd0MKdo7WJ
         yihg==
X-Forwarded-Encrypted: i=1; AJvYcCVBC3HvR9aqHOyDBz2go4Ww3U+w5i+j6esjwG/HdyDdOEVNOVzDvuuT02UKH9HqKDsXDGLmQQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw4fBpH+2UW2SKV14no/J2nX0Dm0Wre6ZKaIaSb0rvdT4FL3ltY
	s9N08yFpazoqiIJQloQy9FuoDX8ePYDGkYkPjPRKRyKXzdd7dDUKo1J6qlKPVMo6vqR+GDPJFAQ
	JJ0BAqisBC7Yg+SxAg5Z0Iab9XqBvEdY=
X-Gm-Gg: ASbGncv6+/seA4I2A2MBn+eBpkaWi8lBGV40ZB7pAPTWZPDES5U+xwGpVS6WMiGcPMQ
	o3+5yLTwT2AHIbfNGfMX2/AdLI/Z/EyNDyzv4Vcpa3b5wLGzkbket0yViucqvzisqYEsO4EOQ0J
	PJWSwitI2Aa/7aAPFONYBJrubulARV/w9hUSzAxl/Puu0FYIMRUsfiHpTPAyy7RoIjQJHeKynz/
	ATOXw==
X-Google-Smtp-Source: AGHT+IEpXnbxrm+y9gNaRiUJIS+Wr3A9qyJLNZQ6jRp+M8ohLE3gUy60b6QHqU0uVa09nwBcd4Z4m6UiuBOEBYIoxLA=
X-Received: by 2002:a05:6602:4802:b0:864:48eb:30fd with SMTP id
 ca18e2360f4ac-86a23227308mr1602924239f.11.1747689911296; Mon, 19 May 2025
 14:25:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250519175348.11924-1-robdclark@gmail.com> <CAPM=9tw183FMOT8uUacqegnb5CREAyr8KbXxO2mCuFK-SmUB1A@mail.gmail.com>
In-Reply-To: <CAPM=9tw183FMOT8uUacqegnb5CREAyr8KbXxO2mCuFK-SmUB1A@mail.gmail.com>
From: Rob Clark <robdclark@gmail.com>
Date: Mon, 19 May 2025 14:24:58 -0700
X-Gm-Features: AX0GCFspyxeD68pvp-yDVVZyGDsNu-QeNUAbWG4ptcBy1923782_er28qi-T_4E
Message-ID: <CAF6AEGuDTGVq7sw4oVuHb+cOE_DuKbEPO956oddVcsV2boieoQ@mail.gmail.com>
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

On Mon, May 19, 2025 at 2:15=E2=80=AFPM Dave Airlie <airlied@gmail.com> wro=
te:
>
> On Tue, 20 May 2025 at 03:54, Rob Clark <robdclark@gmail.com> wrote:
> >
> > From: Rob Clark <robdclark@chromium.org>
> >
> > Conversion to DRM GPU VA Manager[1], and adding support for Vulkan Spar=
se
> > Memory[2] in the form of:
> >
> > 1. A new VM_BIND submitqueue type for executing VM MSM_SUBMIT_BO_OP_MAP=
/
> >    MAP_NULL/UNMAP commands
> >
> > 2. A new VM_BIND ioctl to allow submitting batches of one or more
> >    MAP/MAP_NULL/UNMAP commands to a VM_BIND submitqueue
> >
> > I did not implement support for synchronous VM_BIND commands.  Since
> > userspace could just immediately wait for the `SUBMIT` to complete, I d=
on't
> > think we need this extra complexity in the kernel.  Synchronous/immedia=
te
> > VM_BIND operations could be implemented with a 2nd VM_BIND submitqueue.
>
> This seems suboptimal for Vulkan userspaces. non-sparse binds are all
> synchronous, you are adding an extra ioctl to wait, or do you manage
> these via a different mechanism?

Normally it's just an extra in-fence for the SUBMIT ioctl to ensure
the binds happen before cmd execution

When it comes to UAPI, it's easier to add something later, than to
take something away, so I don't see a problem adding synchronous binds
later if that proves to be needed.  But I don't think it is.

BR,
-R
