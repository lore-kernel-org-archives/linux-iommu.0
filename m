Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82A418E1A
	for <iommu@lists.linux.dev>; Sat,  5 Apr 2025 01:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743818260; cv=none; b=f5tevnzXjox81xO56CPgkh5rr6hBhB/t4/Vgb349Ue18Lf+JX68+Wg27/jmiTdX4NxQwYCnQa28AVSl/FqdrOh6NbDehTn0TDtR0PK1kVsCZmvT18LmmCIsOu+mZqvMfVuKPmZ3O6tq+K0YyJ7NI+e3QGUH6OWkRTRdThHbN5sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743818260; c=relaxed/simple;
	bh=OAoewxTDbadnGF1GAguojqOu/hTz+6xUWg05jevi4+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MzXQffjwM1xkji66CKhcXWkhkphEiQbps6HuBR6u3tL645Dl8sa+3mHnPJCE0zS+Xrg4/pVSTFDNZ2YTYW477SNxsMOgjVhSrwE/uX2PM9JFGGvneAzKzA/mHMF3uyLYrtJA9hGXlv1fP9Acb2WB+Yqw+vL2Ah+QRcOdQc0MdPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dc8SZ8Oa; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dc8SZ8Oa"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cfe808908so22515e9.0
        for <iommu@lists.linux.dev>; Fri, 04 Apr 2025 18:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743818257; x=1744423057; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OAoewxTDbadnGF1GAguojqOu/hTz+6xUWg05jevi4+Q=;
        b=dc8SZ8OaxU9LQUN6KpwpdhxRgPu0rnBWYFYcD+cGwIq1I9yWUh1LdMXGIXtG0EzThI
         z/cJGpRQrWTqDwDBmTgnaZ4LMoW3KGw2DybOz3dQwsWU1N9MPd7P4hUcYdS19M//ZXKC
         oZbirFm3Yo9S5GMcNxd5tshLm2CIrVnzBJvbgg62zBPYfirrvIRJTED5lKwEs8S6e2pu
         3pOJcyButMvhww8Kw0j/kWPDPd9M1Hx2Og35wpUZjpa9Uh65Y4xNlOHCrT7F+Qj4cej6
         gYarWRNvi4+wufOkvUW2Caitm1rBJO8ZaS7TZiGAfk/KzF9qVx2czN66Df+3AsrTvnyc
         RbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743818257; x=1744423057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OAoewxTDbadnGF1GAguojqOu/hTz+6xUWg05jevi4+Q=;
        b=dsR2uihExb2gYF5rH7rPOOSBrSP80SugN2WWL6e1d5ZrBxYBcieoOFetljWPhnUa35
         LepSYxTUH91kfH7rW4/qp3BDuuh1ml58nLaZ5NYUqF2UdovHsNwsVaGmG+ezBy0m8gcw
         m05yZZEjOLmxSypH23Hw1MGWWThwzpu/wj17fbtsyYPD6obfytzJN+cAlA0FANTLc7/a
         dedXHuzojbaOhn2eLwACG0Lm2qvy9ja18iGpfrXLqVXZLTPSFoCqclxqRteGDQW6XNLY
         vyB1U1ZDALqLCzo44XYtf/hXjwvMholeSIrvfH8rL6FtmObVUKTyTU1/0XzVk1GMSdAH
         YdRw==
X-Forwarded-Encrypted: i=1; AJvYcCU1KlZOAvuGStXzyBy7kirMqHoXBcGx+FWPbioEXAyhfgCyUpo60siYSAWAfg0ZB3EJsA1dbw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywax0wsPMtX9c2NAIH0X7ii1frvxD2SHTm9zlwO3MYmhAehlGVi
	FJd2S+cqzJbCcjWXtQymK2br6fGfVUhRJeeuGnLbCkIEW/dphEQB0qAQJKbKLSUuIuoj2d2JGOk
	1zV+9zkEc8oQNtotMmEjJtM0Hc6SIyOMLn5z8
X-Gm-Gg: ASbGncs6GB+WN0C/TevKaWHhI/7efc6hhiAWtANPZJjdaBVjQb0IDt8fLTAczRFA5UE
	6rON/NCTeykQWW8rWKlKPd3n25DjRUeD9XGi1SGJS+AM+zdN2sgEEdwlkwmLg2K2Ir+2vqFX0o+
	g7I3IUC3HPh8NCfJhAZEAblmkL
X-Google-Smtp-Source: AGHT+IEZgBBuLcDuNWx/jFE8YY2SlwYmrCbwtiJPDyDgjgoOsHULjpV/CWiTVdB4+NcESAdkrCw+xWEHlXEt9xlkY4M=
X-Received: by 2002:a05:600c:3548:b0:43d:409c:6142 with SMTP id
 5b1f17b1804b1-43ee0e84029mr527915e9.0.1743818256732; Fri, 04 Apr 2025
 18:57:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250310-dmem-cgroups-v1-0-2984c1bc9312@kernel.org>
 <f5fdc666-dd72-4a4f-9270-b539a3179382@amd.com> <20250310-eccentric-wonderful-puffin-ddbb26@houat>
 <CAPM=9tzkLXOz=-3eujUbbjMHunR+_5JZ4oQaqNmbrWWF9WZJ0w@mail.gmail.com>
 <e08f10da-b0cd-444b-8e0b-11009b05b161@amd.com> <CAPM=9twgFt43OKqUY0TNopTmibnR_d891xmV=wFM91n604NUCw@mail.gmail.com>
 <5ed87c80-6fe3-4f8c-bb98-ca07f1db8c34@amd.com> <20250403-quick-salamander-of-charisma-cab289@houat>
 <202c3a58-97a3-489c-b3f2-b1fd2735bd19@amd.com>
In-Reply-To: <202c3a58-97a3-489c-b3f2-b1fd2735bd19@amd.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Fri, 4 Apr 2025 18:57:25 -0700
X-Gm-Features: ATxdqUG3Y0HIBufABo7xowgVhlloVVBpkM4JhVkK9QLhPMspK9dsEIobBZzLpG8
Message-ID: <CABdmKX2LhrcyDM0r1tytt2vKLuCLGsxZaGHgN+u1hUmEMXuGtw@mail.gmail.com>
Subject: Re: [PATCH RFC 00/12] dma: Enable dmem cgroup tracking
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Maxime Ripard <mripard@kernel.org>, Dave Airlie <airlied@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, Tomasz Figa <tfiga@chromium.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Ben Woodard <woodard@redhat.com>, 
	Hans Verkuil <hverkuil@xs4all.nl>, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 4, 2025 at 1:47=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
> Hi Maxime,
>
> Am 03.04.25 um 17:47 schrieb Maxime Ripard:
> > On Thu, Apr 03, 2025 at 09:39:52AM +0200, Christian K=C3=B6nig wrote:
> >>> For the UMA GPU case where there is no device memory or eviction
> >>> problem, perhaps a configurable option to just say account memory in
> >>> memcg for all allocations done by this process, and state yes you can
> >>> work around it with allocation servers or whatever but the behaviour
> >>> for well behaved things is at least somewhat defined.
> >> We can have that as a workaround, but I think we should approach that
> >> differently.
> >>
> >> With upcoming CXL even coherent device memory is exposed to the core
> >> OS as NUMA memory with just a high latency.
> >>
> >> So both in the CXL and UMA case it actually doesn't make sense to
> >> allocate the memory through the driver interfaces any more. With
> >> AMDGPU for example we are just replicating mbind()/madvise() within
> >> the driver.
> >>
> >> Instead what the DRM subsystem should aim for is to allocate memory
> >> using the normal core OS functionality and then import it into the
> >> driver.
> >>
> >> AMD, NVidia and Intel have HMM working for quite a while now but it
> >> has some limitations, especially on the performance side.
> >>
> >> So for AMDGPU we are currently evaluating udmabuf as alternative. That
> >> seems to be working fine with different NUMA nodes, is perfectly memcg
> >> accounted and gives you a DMA-buf which can be imported everywhere.
> >>
> >> The only show stopper might be the allocation performance, but even if
> >> that's the case I think the ongoing folio work will properly resolve
> >> that.
> > I mean, no, the showstopper to that is that using udmabuf has the
> > assumption that you have an IOMMU for every device doing DMA, which is
> > absolutely not true on !x86 platforms.
> >
> > It might be true for all GPUs, but it certainly isn't for display
> > controllers, and it's not either for codecs, ISPs, and cameras.
> >
> > And then there's the other assumption that all memory is under the
> > memory allocator control, which isn't the case on most recent platforms
> > either.
> >
> > We *need* to take CMA into account there, all the carved-out, device
> > specific memory regions, and the memory regions that aren't even under
> > Linux supervision like protected memory that is typically handled by th=
e
> > firmware and all you get is a dma-buf.
> >
> > Saying that it's how you want to workaround it on AMD is absolutely
> > fine, but DRM as a whole should certainly not aim for that, because it
> > can't.
>
> A bunch of good points you bring up here but it sounds like you misunders=
tood me a bit.
>
> I'm certainly *not* saying that we should push for udmabuf for everything=
, that is clearly use case specific.
>
> For use cases like CMA or protected carve-out the question what to do doe=
sn't even arise in the first place.
>
> When you have CMA which dynamically steals memory from the core OS then o=
f course it should be accounted to memcg.
>
> When you have carve-out which the core OS memory management doesn't even =
know about then it should certainly be handled by dmem.
>
> The problematic use cases are the one where a buffer can sometimes be bac=
ked by system memory and sometime by something special. For this we don't h=
ave a good approach what to do since every approach seems to have a draw ba=
ck for some use case.

This reminds me of memory.memsw in cgroup v1, where both resident and
swapped memory show up under the same memcg counter. In this dmem
scenario it's similar but across two different cgroup controllers
instead of two different types of system memory under the same
controller.

memsw doesn't exist in v2, and users are asking for it back. [1] I
tend to agree that a combined counter is useful as I don't see a great
way to apply meaningful limits to individual counters (or individual
controller limits in the dmem+memcg case) when multiple cgroups are
involved and eviction can cause memory to be transferred from one
place to another. Sorry I'm not really offering a solution to this,
but I feel like only transferring the charge between cgroups is a
partial solution since the enforcement by the kernel is independent
for each controller. So yeah as Dave and Sima said for accounting I
guess it works, and maybe that's good enough if you have userspace
enforcement that's smart enough to look in all the different places.
But then there are the folks asking for kernel enforcement. Maybe just
accounting as best we can is a good place to start?

[1] https://lore.kernel.org/all/20250319064148.774406-5-jingxiangzeng.cas@g=
mail.com/
