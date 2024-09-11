Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9C217A5BD
	for <iommu@lists.linux.dev>; Wed, 11 Sep 2024 11:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726052615; cv=none; b=DlWwd8nTMMeMxwYgNBs7UM95BYXyQRy6B+azYHqi0tu1F6WKiVVV1wfuw1SdJh11CNItGRb0vqhdgaqF9L8fb6aagvuxkfRc9BruGqKz3LvehRxYmOPQ+9hR/2iJdOYJOdJV+NUxMx/u0bx9TfakyZSaEbQKqkKMOCvDV4mUVd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726052615; c=relaxed/simple;
	bh=ORjVOdeptDBmaHaEY2r7GosRGBJcUlHe/3hAQlnOrz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NqSkROfcS50P1SwOqWBqKAJ5tHMXsNvcmLqxhPNdOXTnEtwP//dcaUL1HLsMein8PfcCpEvIHCLzCCHZ2ZOdqPMDZa9ByKS9RW1In2hFcakVPWPIRmOYesW6z47k/ndupWjEnf7YDesGoAufG40z/7Y+844Px8w/RvlxJ4dved4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net; spf=pass smtp.mailfrom=tomeuvizoso.net; dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b=iqERIdyZ; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tomeuvizoso.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b="iqERIdyZ"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e1a9e4fa5aaso6439913276.2
        for <iommu@lists.linux.dev>; Wed, 11 Sep 2024 04:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tomeuvizoso-net.20230601.gappssmtp.com; s=20230601; t=1726052612; x=1726657412; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AxDPM9JMquUGtRkhciAkGUBMtgFCHGxBT/7mvWlerhM=;
        b=iqERIdyZFYNgcqezDu2zjUJ2y1oepQIUoJFYdYp9wXshJ2ZmkfAARXR10rHfMV+oMg
         zE7/wQnFBufiYIlsEfZXJXWo7BnEbYBTdFCjGwU2lUOsW188NwqJX6RwOfx2mhJJ6u+r
         QBE1Gw0/QVg4dV5nr/mV9Uo38rnnFQsQ0XdTtQthOXjRaXoLhVZr+vcaasIDAjs4ROzH
         f714fxxND0xiKSg/AHQull5Bf4qAB+JIjpUTIjYgF11APg3BWyreHZcLhvqJ4nDt4eCt
         0EjOyVCzZSs/CDus7AMCw3v/KlyL0YojgY09Fp7+ra8Bzwj/VHArwXbLI0WuiI/Vs/t8
         O3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726052612; x=1726657412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AxDPM9JMquUGtRkhciAkGUBMtgFCHGxBT/7mvWlerhM=;
        b=F9Zr4cnfp469I+BdqvZPO0jSafoV+zw3FaHqpigwnuHupJb9zeOZibE9mSJ7MpgekD
         OhxBM68DF5FjF9zTqsbsK6Ja6zw/OXFUAmts9skOoFOLnXfsIuTyA5zhR7qpVeWSFnhr
         wqdmdC/jtKiDJQUDRAtQ8pWFQYo/LIzJwsRqVdG5LHuYmf6BpqXb3cd1ZB2tiQ/c2PKf
         IwuQy/eNTHPl9Sihtm+6XIx01lLakjvU/+naOHGMw6Mm8XMnlkGfZFc98yBYYiUAfux7
         j3ymFpoe9YQ3Ygb/Ks6H9DCmr5HBRnF3WeSxCd+YQCuknl/Ox+k7wUoaFjFHQfoNFKvk
         U/ng==
X-Forwarded-Encrypted: i=1; AJvYcCUG3lMQFMBwPim0o8JXAnXPvNpXFlBLLr3ednvMabSMLpVZIQkHzozbkooV3kocdW8MKGV7QA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzp0hFl12kpW/tboyYBfecLXVOP27KthN8DZTZnkLla72Yku3KO
	W3Az9AiX2yCUou1UW+fM6LO3k6yCiPYkNYh8zeuNzFh10MhjVAQx8NqG6NAubjXohdF566AoRqd
	07Cu8EA==
X-Google-Smtp-Source: AGHT+IHmdFJ3bo7Mc/t/cF5rukcdMIpHuMfGIFsWnpwDcL3NAHYKI4LL0nYYx7XE8+efbpBYpfMwiw==
X-Received: by 2002:a05:690c:7011:b0:6ad:deb1:c8e0 with SMTP id 00721157ae682-6db44efaa20mr182444137b3.18.1726052611976;
        Wed, 11 Sep 2024 04:03:31 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6db9646b004sm6588237b3.51.2024.09.11.04.03.30
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 04:03:31 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dff1ccdc17bso6752920276.0
        for <iommu@lists.linux.dev>; Wed, 11 Sep 2024 04:03:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX8H1sonS0NkUmf0R9aXp/2bogfmvifPbXLW/8ixyx+Oe3COQhh9BsG9wfjdCviU3Y1N8zThg==@lists.linux.dev
X-Received: by 2002:a05:6902:2e11:b0:e11:698f:8843 with SMTP id
 3f1490d57ef6-e1d349cf097mr17492302276.44.1726052610124; Wed, 11 Sep 2024
 04:03:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240612-6-10-rocket-v1-0-060e48eea250@tomeuvizoso.net>
 <20240612-6-10-rocket-v1-2-060e48eea250@tomeuvizoso.net> <ffviz6ak6qsn2reg5y35aerzy7wxfx6fzix6xjyminbhfcguus@clszdjakdcjd>
 <CAAObsKCx+r5UuESnrPem1Rb1-BF4i8FVwu6uozWhABOWoq+M4Q@mail.gmail.com>
 <CAAObsKChaBZ2C5ezWsiZ_LoN6R2HFhFA9=UNSRYB6cyeo-jreg@mail.gmail.com> <vmgk4wmlxbsb7lphq2ep3xnxx3mbv6e6lecihtftxoyp5lidvy@mectcwirrlek>
In-Reply-To: <vmgk4wmlxbsb7lphq2ep3xnxx3mbv6e6lecihtftxoyp5lidvy@mectcwirrlek>
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Wed, 11 Sep 2024 13:03:18 +0200
X-Gmail-Original-Message-ID: <CAAObsKAigVVFWuoATTBWbCEfwg0RRHXa=Ehw2OQJyug6EdCDnA@mail.gmail.com>
Message-ID: <CAAObsKAigVVFWuoATTBWbCEfwg0RRHXa=Ehw2OQJyug6EdCDnA@mail.gmail.com>
Subject: Re: [PATCH 2/9] iommu/rockchip: Attach multiple power domains
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Oded Gabbay <ogabbay@kernel.org>, Tomeu Vizoso <tomeu.vizoso@tomeuvizoso.net>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 11:38=E2=80=AFPM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Hi,
>
> On Thu, Jun 13, 2024 at 11:34:02AM GMT, Tomeu Vizoso wrote:
> > On Thu, Jun 13, 2024 at 11:24=E2=80=AFAM Tomeu Vizoso <tomeu@tomeuvizos=
o.net> wrote:
> > > On Thu, Jun 13, 2024 at 2:05=E2=80=AFAM Sebastian Reichel
> > > <sebastian.reichel@collabora.com> wrote:
> > > > On Wed, Jun 12, 2024 at 03:52:55PM GMT, Tomeu Vizoso wrote:
> > > > > IOMMUs with multiple base addresses can also have multiple power
> > > > > domains.
> > > > >
> > > > > The base framework only takes care of a single power domain, as s=
ome
> > > > > devices will need for these power domains to be powered on in a s=
pecific
> > > > > order.
> > > > >
> > > > > Use a helper function to stablish links in the order in which the=
y are
> > > > > in the DT.
> > > > >
> > > > > This is needed by the IOMMU used by the NPU in the RK3588.
> > > > >
> > > > > Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
> > > > > ---
> > > >
> > > > To me it looks like this is multiple IOMMUs, which should each get
> > > > their own node. I don't see a good reason for merging these
> > > > together.
> > >
> > > I have made quite a few attempts at splitting the IOMMUs and also the
> > > cores, but I wasn't able to get things working stably. The TRM is
> > > really scant about how the 4 IOMMU instances relate to each other, an=
d
> > > what the fourth one is for.
> > >
> > > Given that the vendor driver treats them as a single IOMMU with four
> > > instances and we don't have any information on them, I resigned mysel=
f
> > > to just have them as a single device.
> > >
> > > I would love to be proved wrong though and find a way fo getting
> > > things stably as different devices so they can be powered on and off
> > > as needed. We could save quite some code as well.
> >
> > FWIW, here a few ways how I tried to structure the DT nodes, none of
> > these worked reliably:
> >
> > https://gitlab.freedesktop.org/tomeu/linux/-/blob/6.10-rocket-multiple-=
devices-power/arch/arm64/boot/dts/rockchip/rk3588s.dtsi?ref_type=3Dheads#L1=
163
> > https://gitlab.freedesktop.org/tomeu/linux/-/blob/6.10-rocket-schema-su=
bnodes//arch/arm64/boot/dts/rockchip/rk3588s.dtsi?ref_type=3Dheads#L1162
> > https://gitlab.freedesktop.org/tomeu/linux/-/blob/6.10-rocket-multiple-=
devices//arch/arm64/boot/dts/rockchip/rk3588s.dtsi?ref_type=3Dheads#L1163
> > https://gitlab.freedesktop.org/tomeu/linux/-/blob/6.10-rocket-multiple-=
iommus//arch/arm64/boot/dts/rockchip/rk3588s.dtsi?ref_type=3Dheads#L2669
> >
> > I can very well imagine I missed some way of getting this to work, but
> > for every attempt, the domains, iommus and cores were resumed in
> > different orders that presumably caused problems during concurrent
> > execution fo workloads.
> >
> > So I fell back to what the vendor driver does, which works reliably
> > (but all cores have to be powered on at the same time).
>
> Mh. The "6.10-rocket-multiple-iommus" branch seems wrong. There is
> only one iommu node in that. I would have expected a test with
>
> rknn {
>     // combined device
>
>     iommus =3D <&iommu1>, <&iommu2>, ...;
> };

You are right, I'm afraid I lost those changes...

> Otherwise I think I would go with the schema-subnodes variant. The
> driver can initially walk through the sub-nodes and collect the
> resources into the main device, so on the driver side nothing would
> really change. But that has a couple of advantages:
>
> 1. DT and DT binding are easier to read
> 2. It's similar to e.g. CPU cores each having their own node
> 3. Easy to extend to more cores in the future
> 4. The kernel can easily switch to proper per-core device model when
>    the problem has been identified

You mean having subnodes containing the different resources that a
core uses such as clocks, memory resources, power domain, etc? The
problem with that is that the existing code in the kernel assumes that
those resources are directly within a device node. Or do you suggest
something else?

Thanks,

Tomeu
