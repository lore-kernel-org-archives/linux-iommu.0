Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B84F3A75A3
	for <iommu@lists.linux.dev>; Wed,  8 Jul 2026 21:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783545504; cv=none; b=LvoFpl7Po/SsezBQM4JaZtW+2Nj1PYWmQc/EkY2aMu3u1IHMq5NCZmAshakCzUfDv4hlHRw1u/pWxIKL5z2GXIKnQ99mCKPug/ZW5NQXJciF6toDdC8+n4A0zZOmtjYRZ1WlLMztQLinTFzPbWu1KDaPjb6hLvR5GqLQoqlEMEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783545504; c=relaxed/simple;
	bh=/yf86s+VjDN6zg68B/grd6BOMs4viFCbAkNex3o3AKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NGDhd/j+cH8YdYjp5HWi+iPs2efB0aYcOWV1X7u13QbXHauL17dR0N/E/xFJlaMLLb95gi0bgVBOUZpgOaEHIikw5HJjV2xanrO0LbQi9l3UlD5AiJs0MiT6c5509qapiLVrAfVg2qyMmNvk3168NC0CfrlcPv/+CZG3KuitsEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ij1oKLvn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ij1oKLvn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5BC1F0155A
	for <iommu@lists.linux.dev>; Wed,  8 Jul 2026 21:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783545503;
	bh=XHlK26iT5OTlGmvdsQr6aTlcJ71q9tfgFUQl/PoXZWA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ij1oKLvneDuoMo7g4aa7tnzEGSduqP/POFTYHBdxBZ815qZpk9LFbDgsAo0yCt8IU
	 7IVs6w+zLmWUyetjrgBlg1w5iqaPlbRALMaZO8JW7hqU/1gvwTbxJwp4KOcWeGc63v
	 75V4WotUCt8Dobg79gGG87lQ7nK03BdYhKAKjhYHR6XGEIrP/JoGdtP22AbbDvdmY9
	 B/6r+YzOxZx43W7v+wiSMS40iikcKhYr6dIVP5FmzwUS2uq8+P91iQ4y6rs3YT1Lct
	 RdWSXHuhozPhfIOsKn2saEE2M5xJTpuQM3JnOsppmQRmSqllqe3+hlGwET7HA3MA1T
	 EVcF2gcOddPww==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c15d111ca99so112650366b.0
        for <iommu@lists.linux.dev>; Wed, 08 Jul 2026 14:18:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RovPnNnqTtVlIo136yQQz5m129CacEGUQxCms3LVgLePfyoQt0uW9hCyqozhY1rzUX0tcBe/Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyb+k24syTQvNv5KXnCM3mnNWk7FlAHFBTZb+TakJjc9DUZ0pS8
	Wwr68UQmk2k5jKsB+gfxo9gp0f8pGxyvILtvmSh5VXXXN+2iSHldOfV/w8zuXHjusPAKltwhJwq
	ZNZNPF3vizyYmkYD8cKDx9K67BM184w==
X-Received: by 2002:a17:907:a286:b0:c15:b6bd:cbb8 with SMTP id
 a640c23a62f3a-c15ce121a12mr190425566b.50.1783545501322; Wed, 08 Jul 2026
 14:18:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260701-tegra-vpr-v3-0-d80f7b871bb4@nvidia.com>
 <20260701-tegra-vpr-v3-1-d80f7b871bb4@nvidia.com> <178293558945.1610040.13281502080616690110.robh@kernel.org>
 <akZde-8lFvf8rPji@orome>
In-Reply-To: <akZde-8lFvf8rPji@orome>
From: Rob Herring <robh@kernel.org>
Date: Wed, 8 Jul 2026 16:18:10 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJCMm-oL35COx=agY+mwRUMMnRvbUgzPr5Hy9uvcPk0Dg@mail.gmail.com>
X-Gm-Features: AUfX_mz5rhGcrunDpACqiF1Zhx-HBPPyHD0sxMJJ0YCYlPmg5dj7i6HAGao9icM
Message-ID: <CAL_JsqJCMm-oL35COx=agY+mwRUMMnRvbUgzPr5Hy9uvcPk0Dg@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] dt-bindings: reserved-memory: Document Tegra VPR
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	dri-devel@lists.freedesktop.org, David Hildenbrand <david@kernel.org>, 
	Yury Norov <yury.norov@gmail.com>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-trace-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	linux-mm@kvack.org, Russell King <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, David Airlie <airlied@gmail.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
	linaro-mm-sig@lists.linaro.org, Heiko Carstens <hca@linux.ibm.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Thierry Reding <treding@nvidia.com>, 
	Maxime Ripard <mripard@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	John Stultz <jstultz@google.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Brian Starkey <Brian.Starkey@arm.com>, 
	Mikko Perttunen <mperttunen@nvidia.com>, Michal Hocko <mhocko@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Sowjanya Komatineni <skomatineni@nvidia.com>, Suren Baghdasaryan <surenb@google.com>, 
	linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, 
	devicetree@vger.kernel.org, "Liam R. Howlett" <liam@infradead.org>, 
	linux-tegra@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Lorenzo Stoakes <ljs@kernel.org>, "T.J. Mercier" <tjmercier@google.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, iommu@lists.linux.dev, 
	Mike Rapoport <rppt@kernel.org>, Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 2, 2026 at 7:58=E2=80=AFAM Thierry Reding <thierry.reding@kerne=
l.org> wrote:
>
> On Wed, Jul 01, 2026 at 02:53:10PM -0500, Rob Herring (Arm) wrote:
> >
> > On Wed, 01 Jul 2026 18:08:12 +0200, Thierry Reding wrote:
> > > From: Thierry Reding <treding@nvidia.com>
> > >
> > > The Video Protection Region (VPR) found on NVIDIA Tegra chips is a
> > > region of memory that is protected from CPU accesses. It is used to
> > > decode and play back DRM protected content.
> > >
> > > It is a standard reserved memory region that can exist in two forms:
> > > static VPR where the base address and size are fixed (uses the "reg"
> > > property to describe the memory) and a resizable VPR where only the
> > > size is known upfront and the OS can allocate it wherever it can be
> > > accomodated.
> > >
> > > Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> > > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > > ---
> > > Changes in v2:
> > > - add examples for fixed and resizable VPR
> > > ---
> > >  .../nvidia,tegra-video-protection-region.yaml      | 76 ++++++++++++=
++++++++++
> > >  1 file changed, 76 insertions(+)
> > >
> >
> > My bot found errors running 'make dt_binding_check' on your patch:
> >
> > yamllint warnings/errors:
> >
> > dtschema/dtc warnings/errors:
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings=
/reserved-memory/nvidia,tegra-video-protection-region.example.dtb: protecte=
d@2a8000000 (nvidia,tegra-video-protection-region): reg: [[2, 2818572288], =
[0, 1879048192]] is too long
> >       from schema $id: http://devicetree.org/schemas/reserved-memory/nv=
idia,tegra-video-protection-region.yaml
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings=
/reserved-memory/nvidia,tegra-video-protection-region.example.dtb: protecte=
d@2a8000000 (nvidia,tegra-video-protection-region): Unevaluated properties =
are not allowed ('no-map', 'reg' were unexpected)
> >       from schema $id: http://devicetree.org/schemas/reserved-memory/nv=
idia,tegra-video-protection-region.yaml
>
> Any ideas why that second error shows up? It turns out that it goes away
> when the first one is fixed (which admittedly is a stupid mistake), but
> I spent quite a bit of time looking for a fix before realizing that it's
> only a side-effect of the first.

If a property fails validation in a referenced schema, then everything
in that referenced schema is considered not evaluated. So then
unevaluatedProperties is applied to the properties only in the
referenced schema. That's why 'no-map' is also unevaluated. Just a
quirk of how json-schema works...

Rob
