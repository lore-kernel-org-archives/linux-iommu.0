Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D6C74077
	for <iommu@lists.linux.dev>; Mon,  8 Jul 2024 23:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720482338; cv=none; b=qA5JYem4qwgS/ilV61czkTbbeH4DCnzMDQwWpn6m0uFjsL+xaNhjtQCml8FEEi0NJDtCoqzMngWUy1LQ9mfr+B9+Wsd/kC94iMn5GiYvtz3sZtRHQhg+8ZFNY9dXiqDRmfCL071qRogbxJYuuhFK8VpNyfBsiZOikPgMjS4HkvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720482338; c=relaxed/simple;
	bh=WqB5mcEHwiCIHO2AodxjmxYg6envP+/XTNIhdG5D+Gg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q/u8r1FX9hhHjKlTaudxQCqBhp42+3FaE0TXV4KEC4cinCTzZ4gsqgwpvVMXQRxGLfRdpxCx9tTrBUL/c0m/lKE2L1U5TiHkq300xP/dYV0Diu8NWLNBPufDVf205uh1h4V/fOVvEEbsxtaV9rbhr4bptKMTdbQctRBuAEPmfkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qs/zcZI4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qs/zcZI4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D295EC4AF0F
	for <iommu@lists.linux.dev>; Mon,  8 Jul 2024 23:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720482337;
	bh=WqB5mcEHwiCIHO2AodxjmxYg6envP+/XTNIhdG5D+Gg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Qs/zcZI4QGLJGiJy64tsy8MMYvRXyXJdPDctlgPbVTZkl9n61vmplTE6ce7XLfNuv
	 aF0SA98VKqz0ogKbWOezbeWiSajmdo+K1tOVua0vlurvnZGR81SGpUlvXQt7C2TB97
	 wzh2/RlBDKu9WZ7BVX41yi9vx3Phznfpv99QmWemvV7z5nRU6bQQRbPB/Ogr+XZmWr
	 pa1U73IYd7Z0gAQIjdo7OZexbM3mxE1XtM0zo34bqAaIDqteB7ei/silQ9TKUNBLjn
	 BjGvZDtX0WaMQsU0rIvXCw9U/HP5NSO1M4n6h1ZzZlcmveUEwrin9ivRjlc3FDzZUu
	 bBA30jwlLKd0g==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52ea33671ffso4123671e87.3
        for <iommu@lists.linux.dev>; Mon, 08 Jul 2024 16:45:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW+WUjZecxMWVhxQGrZPvGDuX17cEHp5qJmWuxRpATtS6ic0W3mzPIcDdHRCda6v3eq8o1zl6gNncqWKIeKLV6I7b7W4t8=
X-Gm-Message-State: AOJu0YxKeXf6NDQ06TIWJQTNYJ16p2NWa+v+lii6iReOKob6OnFbN+E2
	eHsTUrlxGqMrKm73i5edWf6exAkbgXaCY2AkcYcFQMxzRLV6eJrDe9T7+8nh6UqNFX5qmDxfkW9
	NzaMp4l6MRqF337nfLeW5+OO82w==
X-Google-Smtp-Source: AGHT+IEKV5wyLcV1ycT2TnwArtJJGSVvXo4evQIYo01RZ05YOMAGpPEpsNQdQXNMhV0FFsl4PP9NkeD2EVDivivCbNQ=
X-Received: by 2002:a05:6512:29e:b0:52c:d80e:55a5 with SMTP id
 2adb3069b0e04-52eb99a35d4mr362953e87.41.1720482336134; Mon, 08 Jul 2024
 16:45:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240528223650.619532-1-quic_obabatun@quicinc.com>
 <20240528223650.619532-4-quic_obabatun@quicinc.com> <986361f4-f000-4129-8214-39f2fb4a90da@gmail.com>
 <4905e651-4c37-4fb4-bbc1-af9633013134@gmail.com> <1684910a-54e2-4df5-a076-de9c2de4277b@quicinc.com>
In-Reply-To: <1684910a-54e2-4df5-a076-de9c2de4277b@quicinc.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 8 Jul 2024 17:45:23 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLU6z5huedWcrBkP0utLH3=y-zZa0jen1K_LJfFsTXVBQ@mail.gmail.com>
Message-ID: <CAL_JsqLU6z5huedWcrBkP0utLH3=y-zZa0jen1K_LJfFsTXVBQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] of: reserved_mem: Use unflatten_devicetree APIs to
 scan reserved memory nodes
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Cc: Klara Modin <klarasmodin@gmail.com>, saravanak@google.com, hch@lst.de, 
	m.szyprowski@samsung.com, robin.murphy@arm.com, will@kernel.org, 
	catalin.marinas@arm.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, kernel@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 5:12=E2=80=AFPM Oreoluwa Babatunde
<quic_obabatun@quicinc.com> wrote:
>
>
> On 7/5/2024 8:38 AM, Klara Modin wrote:
> > On 2024-07-05 15:05, Klara Modin wrote:
> >> Hi,
> >>
> >> On 2024-05-29 00:36, Oreoluwa Babatunde wrote:
> >>> The unflatten_devicetree APIs have been setup and are available to be
> >>> used by the time the fdt_init_reserved_mem() function is called.
> >>> Since the unflatten_devicetree APIs are a more efficient way of scann=
ing
> >>> through the DT nodes, switch to using these APIs to facilitate the re=
st
> >>> of the reserved memory processing.
> >>
> >> With this patch series, I've observed significantly less memory availa=
ble to userspace on my Raspberry Pi 1 and 3.
> >>
> >> I see this message on the kernel console:
> >> Jul  4 23:13:49 bonnet kernel: OF: reserved mem: 0x1b000000..0x1efffff=
f (65536 KiB) map non-reusable linux
> >>
> >> where it was previously marked as reusable:
> >> Jul  4 22:23:22 bonnet kernel: OF: reserved mem: 0x1b000000..0x1efffff=
f (65536 KiB) map reusable linux,cma
> >>
> >> If I look at bcm283x.dtsi, it definitely has the reusable property.
> >>
> >> I've below pointed out the snippet I think could be suspicous.
> >>
> >>>
> >>> Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
> >>> ---
> >>>   drivers/of/of_reserved_mem.c    | 93 ++++++++++++++++++++----------=
---
> >>>   include/linux/of_reserved_mem.h |  2 +-
> >>>   kernel/dma/coherent.c           | 10 ++--
> >>>   kernel/dma/contiguous.c         |  8 +--
> >>>   kernel/dma/swiotlb.c            | 10 ++--
> >>>   5 files changed, 72 insertions(+), 51 deletions(-)
> >>>
> >>> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_me=
m.c
> >>> index 113d593ea031..05283cd24c3b 100644
> >>> --- a/drivers/of/of_reserved_mem.c
> >>> +++ b/drivers/of/of_reserved_mem.c
> >
> >>> @@ -447,7 +476,7 @@ static int __init __reserved_mem_alloc_size(unsig=
ned long node, const char *unam
> >>>                  uname, (unsigned long)(size / SZ_1M));
> >>>           return -ENOMEM;
> >>>       }
> >>
> >>
> >>> -    fdt_reserved_mem_save_node(node, uname, base, size);
> >>> +    fdt_reserved_mem_save_node(NULL, uname, base, size);
> >>
> >> This could perhaps be suspicious?
> >>
> >> The above message seems to come from of_init_reserved_mem_node when
> >> called from of_reserved_mem_save_node when called from here. This woul=
d mean that the node is not actually saved to rmem and thus not marked reus=
able?
> >>
> >>
> >>>       return 0;
> >>>   }
> >
> >>
> >> Regards,
> >> Klara Modin
> >
> > Attaching kernel logs of old and new behavior, and my config for refere=
nce.
> Hi Klara,
>
> Thanks for pointing this out. I have uploaded a fix here:
> https://lore.kernel.org/all/20240708230613.448846-1-quic_obabatun@quicinc=
.com/

Sorry, but I'm not taking reverts of half the series. I've dropped it
all for 6.11.

Rob
