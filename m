Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4723333D6C7
	for <iommu@lists.linux.dev>; Tue, 11 Nov 2025 20:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762893564; cv=none; b=LoSybaJjcv5WMoIOCih9AUq6PA97HWyFpPCuj6GGP/Ww+pgQFn6XP0aHPH3jMcYocXmb9fUxNOO8i+9ZZZiYIX+FAiipLw4jyXLLH/QdkVIoPWCyagvzTSJ2eB5PjuG5enMA+ze9EV1UjSe1uI32W7OPOpviz0Lbvkkx6AFBi58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762893564; c=relaxed/simple;
	bh=u1iRB/FagiRIB7UpPaeARkCuG/fTT+SIP2ZHQ2tbwnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XdlbWts0QLMEO8InbR6U2wtgvlZt6MSP/PKxIV/JGv9qdOLbbSJRla/5ApgouMA5HxQYVitqsFXCefz/1lBjX+U7MHaizWAQhWG8cOXmPF7P12/9zuiG0SUdhyCwAw3jOyzZTCeFixbPre+0gZwAWrTlKbngAuTsJUzhZ6RWMqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qoCPLDGg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qoCPLDGg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02BB2C19423
	for <iommu@lists.linux.dev>; Tue, 11 Nov 2025 20:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762893564;
	bh=u1iRB/FagiRIB7UpPaeARkCuG/fTT+SIP2ZHQ2tbwnw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qoCPLDGg1LXzz9WBccporwV3yJ3NPgCc98O/Akk7D7Z35Tah65r6ZJh2bdqdzHlV3
	 2AM8RdpJhwviP7m1B7sZzomQBrMUjGu4dBUMWa5lxLrjB3hwUZ2o79Oe/FaZBiGotR
	 hvTIOu6VWyAQ21Qau+ajAupiBtfKbzP8AsrDvx0F0re0bktKADC5nVAW9O3R0DmpTv
	 t3sDnL7+sfcMgjKPVQP7bl4E+SqvttThFb2ZLbMuVieH6Erg3nrvgcS1sIfGGF05sp
	 CtazyQLbAZ3KsfrFth3GSg81tuqvrjmw6ta1Ata/ZrEJIlmKMUXnqPM11hIaoWxXmp
	 oRxWPKaSpBusg==
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42b3ac40ae4so41080f8f.0
        for <iommu@lists.linux.dev>; Tue, 11 Nov 2025 12:39:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU0UZldyXxNpjeaVTP51Ye3SKxC1DmHmwzsKcd7lMbdqxTSyWmFkczgieMUaSK/wOpAI7brcQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwkScF3CgKil5kFAqu0HgV3/o0NZD4Wg5ColidZOQZ3woYh5i3a
	Iwc7w/Izub0FeX2C4r88yDMX7Mm/Gytgp36ikmGrgVVzwYtyxvcL14Xs++XMuHN1WcTc4+psqmB
	s6gNdmdxO2DCWr0jCWXpOIpXdPOgsIg==
X-Google-Smtp-Source: AGHT+IGvpEcD3av3nMae+EjmI26O/IovDwBiGXp0LnaaAwRRYnwAtL98IODaAhI4juu7w6dSw+17AGxnVtjXf/0jDGY=
X-Received: by 2002:a05:6000:24c7:b0:40e:31a2:7efe with SMTP id
 ffacd0b85a97d-42b4bb98114mr461806f8f.14.1762893562134; Tue, 11 Nov 2025
 12:39:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1762235099.git.charan.kalla@oss.qualcomm.com>
 <20251107-active-uber-impala-8d9118@kuoka> <49339695-615c-4a89-974c-ecd4ea1b544a@oss.qualcomm.com>
In-Reply-To: <49339695-615c-4a89-974c-ecd4ea1b544a@oss.qualcomm.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 11 Nov 2025 14:39:10 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ7+czY0=98PtpVDJB3XkLA0JumYan=22Y-TXpY1UFRiQ@mail.gmail.com>
X-Gm-Features: AWmQ_bk-Z6Q7oXVD8FEdhINi7jHzcZfPOjZcAWC1Z8NaeO_NPA6fgfgsGYJ6W8Y
Message-ID: <CAL_JsqJ7+czY0=98PtpVDJB3XkLA0JumYan=22Y-TXpY1UFRiQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] of: iommu-map parsing for multi-cell IOMMU
To: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, 
	dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com, 
	bjorn.andersson@oss.qualcomm.com, bod@kernel.org, conor+dt@kernel.org, 
	krzk+dt@kernel.org, saravanak@google.com, prakash.gupta@oss.qualcomm.com, 
	vikash.garodia@oss.qualcomm.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 12:45=E2=80=AFPM Charan Teja Kalla
<charan.kalla@oss.qualcomm.com> wrote:
>
>
>
> On 11/7/2025 1:37 PM, Krzysztof Kozlowski wrote:
> > On Tue, Nov 04, 2025 at 02:20:59PM +0530, Charan Teja Kalla wrote:
> >> The iommu-map property has been defined for the PCIe usecase and has
> >> been hardcoded to assume single cell for IOMMU specification, ignoring
> >> the #iommu-cells completely. Since the initial definition the iommu-ma=
ps
> >> property has been reused for other usecases and we can no longer assum=
e
> >> that the single IOMMU cell properly describes the necessary IOMMU
> >> streams. Expand the iommu-map to take #iommu-cells into account, while
> >> keeping the compatibility with the existing DTs, which assume single
> >> argument.
> >>
> >> Unlike single iommu-cell, it is complex to establish a linear relation
> >> between input 'id' and output specifier for multi iommu-cells. To hand=
le
> >> such cases, rely on arch-specific drivers called through
> >> of_iommu_xlate() from of_iommu layer, aswell it is expected the 'len'
> >> passed is always 1. In the of_iommu layer, the below relation is
> >> established before calling into vendor specific driver:
> >>
> >> a) For platform devices, 'rid' defined in the iommu-map tuple indicate=
s
> >> a function, through a bit position, which is compared against passed
> >> input 'id' that represents a bitmap of functions represented by the
> >> device.
> >>
> >> b) For others, 'rid' is compared against the input 'id' as an integer
> >> value.
> >>
> >> Thus the final representation when #iommu-cells=3Dn is going to be,
> >> iommu-map =3D <rid/functionid IOMMU_phandle cell0 .. celln len>;, wher=
e
> >> len =3D 1.
> >>
> >> The RFC for this patch set is found at [2].
> > So that's a v2 or v3? Then number your patchsets correctly.
>
> Is there any kernel guidelines that patchset should start at V2 after an
> RFC? I do see many patches are follwed by V1 after RFC. Eg: [1] is an
> RFC followed by [2] as V1 -- Or it is the maintainers preference and
> expectations?

RFC and version number are orthogonal. RFC is a condition the patches
are in. You can have "RFC v10", though I'd hope not. RFC is like
'draft' in Gitlab or Github PRs.

Rob
