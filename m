Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8FD27934D
	for <iommu@lists.linux.dev>; Mon, 28 Apr 2025 16:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745856298; cv=none; b=pbJWuU6DsLdqJOh4BTVtj+Ujwv/MP8xIbAjzD+5xEyq0jxhRnaLwlWCGzUJeOX2Cpr4pSamcrqHoDs+w+5JWpSC/Jd2pJ5vSjYqvRDWqO8pd+ebVOeAz0YJ0MUHydz21rP987q5RwlbaPgHOwwUFCLf78Pg4SNAt5KZOfF1tbSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745856298; c=relaxed/simple;
	bh=7XLdbWmNFskoiToXzoYEkGfsOw/zohiTcP2XkykS74o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F/XluMpxL8UfHcKmc6z7pAbxrFX2wUbDhfS1nb8rH11yTCPLjZmrYZthO4rEhR7OGe7MN9+1PBDknVpyI1ihCrCYfsJJoKeoBBA6GxpNHEKDWPyCEeL8A4KZJcM+w5MNOwQtJAZf/hOu1xdQCy94iqtUpWIp+qPhQhs4appZvkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AM9L7fZu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AM9L7fZu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B65EFC4CEEC
	for <iommu@lists.linux.dev>; Mon, 28 Apr 2025 16:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745856297;
	bh=7XLdbWmNFskoiToXzoYEkGfsOw/zohiTcP2XkykS74o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AM9L7fZuEJv8GJopbMAaCLzul2dtTfFJkqqJ7BqfmbmCyAf10FdcxcWA/Ng3eUspe
	 UKicT9AHwF0xcV/7M0JEceXTD6wy5YgRoC81Xvjy79aPqtv7WHhmosG1kwNnZj+PLQ
	 2VPm3GAdNQ/sMv5301JJTyBVGb6HJCDTMgEfBTGBNwTEG1novG/AMwvccQDP+V02UL
	 6M2s58ruhrpoQeJ4Es/bu5G7f3ZtgwS+SGoA+tcjE4DAcR3OLIp/2evQhbeM4E5aT3
	 EWlDsmGGqb/fAJ8ea7L7+HLZKI31nwe0JS5bb6+xZWMHe17K24pRXJPO1j7sRq1rPL
	 i00uL7SUG/KTQ==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5f624291db6so8628179a12.3
        for <iommu@lists.linux.dev>; Mon, 28 Apr 2025 09:04:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXSLtuoj6K3XXGLcjuzfLVrRZ1vqy7Va3FzoNOFwmHVu3qS3ZAZgzDQQjL8smIsqf7HQQgoxA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwEcOOnepLbBrp+RrMp8cwPN/2lGrlKTXzmhmW3oyLEUAvTQiOI
	5qAyNP4g0U0biLJO8IMyJDZyT7ZgnMUX06VbVZEJBteonKqYvViFRL5d7M+fcE0quXGr7bGaYMc
	f3Rz6Omv1rUg0qcVjk4ItSbHt1A==
X-Google-Smtp-Source: AGHT+IHqyjiiOUZc7O0PTXr4PU21+O3T0XNzhaZ1i8yWNd5TokGg/Wq4TNREu/IzrAIDEiBQ7J/8fcTB66uLEb2Z3jg=
X-Received: by 2002:a05:6402:40c6:b0:5dc:7643:4f3d with SMTP id
 4fb4d7f45d1cf-5f83809e106mr113428a12.1.1745856296286; Mon, 28 Apr 2025
 09:04:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250410144008.475888-1-angelogioacchino.delregno@collabora.com>
 <aAETI0hrOiQZDKh2@8bytes.org> <20250428160227.GA1322286-robh@kernel.org>
In-Reply-To: <20250428160227.GA1322286-robh@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Mon, 28 Apr 2025 11:04:44 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+pE2c3GzdrgRO97Ee=ajOVAMzNtqyujD3PXyNE6Ad9vA@mail.gmail.com>
X-Gm-Features: ATxdqUHw7IfXnRL7JJPy7HyVs4hLK90IaG__j7ETIyndbfex7BJvjd7AGV1APf0
Message-ID: <CAL_Jsq+pE2c3GzdrgRO97Ee=ajOVAMzNtqyujD3PXyNE6Ad9vA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] MediaTek Dimensity 1200 - Add IOMMU support
To: Joerg Roedel <joro@8bytes.org>, yong.wu@mediatek.com
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, will@kernel.org, 
	robin.murphy@arm.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
	matthias.bgg@gmail.com, iommu@lists.linux.dev, 
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 11:02=E2=80=AFAM Rob Herring <robh@kernel.org> wrot=
e:
>
> On Thu, Apr 17, 2025 at 04:41:39PM +0200, Joerg Roedel wrote:
> > On Thu, Apr 10, 2025 at 04:40:06PM +0200, AngeloGioacchino Del Regno wr=
ote:
> > > In preparation for adding basic support for the OnePlus Nord 2 5G
> > > DN2103 smartphone, this series adds support for the IOMMU found in
> > > the MediaTek Dimensity 1200 (MT6893) SoC.
> > >
> > > AngeloGioacchino Del Regno (2):
> > >   dt-bindings: iommu: mediatek: Add binding for MT6893 MM IOMMU
> > >   iommu/mediatek: Add support for Dimensity 1200 MT6893 MM IOMMU
> > >
> > >  .../bindings/iommu/mediatek,iommu.yaml        |   4 +
> > >  drivers/iommu/mtk_iommu.c                     |  37 ++-
> > >  .../memory/mediatek,mt6893-memory-port.h      | 288 ++++++++++++++++=
++
> > >  3 files changed, 318 insertions(+), 11 deletions(-)
> > >  create mode 100644 include/dt-bindings/memory/mediatek,mt6893-memory=
-port.h
> >
> > Applied, thanks.
>
> It looks like you missed the binding change for this.

Actually, upon closer look, the driver's compatible string has a typo.
The period should be a comma.

Rob
