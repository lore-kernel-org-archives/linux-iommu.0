Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891F22555C
	for <iommu@lists.linux.dev>; Thu,  4 Jan 2024 16:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="UMOsr+vz"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-42831bbf750so3392241cf.3
        for <iommu@lists.linux.dev>; Thu, 04 Jan 2024 08:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1704385819; x=1704990619; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aj4IIq0tzuh1/OdFywt45Ed5fBVp3SK/t71RwP6JXSw=;
        b=UMOsr+vzGh2wBytMI1Hc8VxYu/Ci0OrzqHetgojOrYP+Ijp/zsm04AljeP+ayM1wtF
         txfavvIVaNaGPb0GqP8yGkyN/HWhDJ9jZltZH4vRb5jOTcnjIN+RhMImlDmXOZ+JD30L
         Z1ysf8NoqNUgoEERikOK4Uzrw4y4szUbbVeK+NSE7n7u5Qewz078oIs5uyE51UETHi6C
         HFwzzGeb/+uX1XNwm9rwG9oo504/TpTvQCb4jJRez81ynVNiH8Xqj3hgEdES3knhSkFf
         54AmBdik3olqlfi2QB9QOEESV50GESYCLl3oOlejla/VzfG/IXzUuTPO3bYDneeVg2Jl
         GhxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704385819; x=1704990619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aj4IIq0tzuh1/OdFywt45Ed5fBVp3SK/t71RwP6JXSw=;
        b=qv/SbglaBZ9I592dmu1gk06r+ucPMSgQ1oWTe5kZcIh/GK9YdW0XJAzbYp6VVaRzfp
         PhVCWSoJINA8LEHIHkxh+vcJJ/8ErdkU4l4+SylvwsHne69/NPS4vChlbVKW82pM4yQ5
         u0HxFljGvpJmBQSayZaU8lPtPOq89y6n9cn6tdiA7UBWS72VS94e3V9CcFy0B0RFEjVi
         9B2E5AfOdOULrh/UsJoYRCZqaro4/sEBXn8cZ8EwGGXMvBFDOvP1cjINqELzXxGkV9zj
         HDYMPKFbwckkBZ6lPI/AhSUtKGX2PiZaDUCT2ui/cGe7QrO/lrDG5IR8eEfXzJUR3gUQ
         xVAg==
X-Gm-Message-State: AOJu0YxzyTfBwI5nnuqToUM90LS7nyqePM583Ly0TCOhYzt+/k7E/Mup
	J+cHm88//Qs/5GXTxSn6y+b0/ukoTFQ5ttP34/6dhnS4dJ0bDA==
X-Google-Smtp-Source: AGHT+IHbmPwv6z7KPbpI44YRa4bYQfIXyvmSunk5ru1UyVqC5KptkTXxtDOkWoeYljsAtoXlTJC88ShSxszX3+BvyHo=
X-Received: by 2002:ac8:5cce:0:b0:428:3602:4ad8 with SMTP id
 s14-20020ac85cce000000b0042836024ad8mr839527qta.60.1704385819426; Thu, 04 Jan
 2024 08:30:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231226200205.562565-1-pasha.tatashin@soleen.com> <eqkpplwwyeqqd356ka3g6isaoboe62zrii77krsb7zwzmvdusr@5i3lzfhpt2xe>
In-Reply-To: <eqkpplwwyeqqd356ka3g6isaoboe62zrii77krsb7zwzmvdusr@5i3lzfhpt2xe>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 4 Jan 2024 11:29:43 -0500
Message-ID: <CA+CK2bBE1bQuqZy3cbWiv8V3vJ8YNJZRayp6Wv-j2_9i37XT4g@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] IOMMU memory observability
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: akpm@linux-foundation.org, alim.akhtar@samsung.com, alyssa@rosenzweig.io, 
	asahi@lists.linux.dev, baolu.lu@linux.intel.com, bhelgaas@google.com, 
	cgroups@vger.kernel.org, corbet@lwn.net, david@redhat.com, 
	dwmw2@infradead.org, hannes@cmpxchg.org, heiko@sntech.de, 
	iommu@lists.linux.dev, jernej.skrabec@gmail.com, jonathanh@nvidia.com, 
	joro@8bytes.org, krzysztof.kozlowski@linaro.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-rockchip@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-tegra@vger.kernel.org, lizefan.x@bytedance.com, marcan@marcan.st, 
	mhiramat@kernel.org, m.szyprowski@samsung.com, paulmck@kernel.org, 
	rdunlap@infradead.org, robin.murphy@arm.com, samuel@sholland.org, 
	suravee.suthikulpanit@amd.com, sven@svenpeter.dev, thierry.reding@gmail.com, 
	tj@kernel.org, tomas.mudrunka@gmail.com, vdumpa@nvidia.com, wens@csie.org, 
	will@kernel.org, yu-cheng.yu@intel.com, rientjes@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 10:31=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> Hello.
>
> On Tue, Dec 26, 2023 at 08:01:55PM +0000, Pasha Tatashin <pasha.tatashin@=
soleen.com> wrote:
> > This patch series solves this problem by adding both observability to
> > all pages that are allocated by IOMMU, and also accountability, so
> > admins can limit the amount if via cgroups.
>
> Maybe this is a mismatch in vocabulary what you mean by the verb
> "limit". But I don't see in the patchset that the offending pages would
> be allocated with GFP_ACCOUNT. So the result is that the pages are
> accounted (you can view the amount in memory.stat) but they are not
> subject to memcg limits.
>
> Is that what you intend?

Hi Michal,

Thank you for taking a look at this. The two patches [1] [2] which add
GFP_KERNEL_ACCOUNT were sent separate from this series at request of
reviewers:

Pasha

[1] https://lore.kernel.org/linux-mm/20231226182827.294158-1-pasha.tatashin=
@soleen.com
[2] https://lore.kernel.org/linux-mm/20231130200900.2320829-1-pasha.tatashi=
n@soleen.com

>
>
> Regards,
> Michal
