Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46777101FD
	for <iommu@lists.linux.dev>; Wed, 16 Aug 2023 11:36:28 +0000 (UTC)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-58c656824c1so12064367b3.1
        for <iommu@lists.linux.dev>; Wed, 16 Aug 2023 04:36:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692185788; x=1692790588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r9gJbFseA01i0krgU46+q3/Jf0P3rLnLM6Eq8Alo05E=;
        b=i2iuhEalDrygG23GzKq2XpuPmFTdUsN5T7oWOfbFj5XVybBHbhFLntEd1iyJc/2v/o
         UMgaI1QFw9bQAeic9nkfJTakhhiP+dpGUpODc4Omc53vTfCdo9tJSmIkDysGiHJSZRVH
         mOhJVIBkdIHn+ZDj4iRKxFR0Skg1gTgMRNorkaVvnhoRmUsB3Mw3MKtWGg6+1O107SR0
         5G4Cd1YvT9pgisXsQm69g/7a4Rd5fRQQXyFEsviaot9kJh2SdiAJEfssjz1a2WVGXJQZ
         KectuEoOBapxmG0p+NnBGnRuhC810Tt6iQ/2oyl7N0Ji6/sq6ZWTWMT8zEb0v3F86srY
         5ecg==
X-Gm-Message-State: AOJu0YxhQTd/g7NT13iS3HjcSsPo44CfYy3sVbK7xM08gvwjUPwqX0hy
	SM/6zvcuLDkcAZuiheBKRswhvj1LvS6mHw==
X-Google-Smtp-Source: AGHT+IFI/1LRoh8ex+gCq3yAkobAlPK1UNqwSstLeF8sfmh8lHGbk6rxLzj4oJhBHAROmWCdM2cRiw==
X-Received: by 2002:a0d:ebc5:0:b0:589:fcb2:d57f with SMTP id u188-20020a0debc5000000b00589fcb2d57fmr2686762ywe.37.1692185787880;
        Wed, 16 Aug 2023 04:36:27 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id k6-20020a0dfa06000000b005732b228a83sm3912464ywf.140.2023.08.16.04.36.27
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 04:36:27 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-ccc462deca6so6252621276.0
        for <iommu@lists.linux.dev>; Wed, 16 Aug 2023 04:36:27 -0700 (PDT)
X-Received: by 2002:a25:da02:0:b0:d07:3fb6:c00d with SMTP id
 n2-20020a25da02000000b00d073fb6c00dmr2398620ybf.12.1692185787100; Wed, 16 Aug
 2023 04:36:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0f8ac07472f4161c71247742acb2303f9cf91396.1692113438.git.geert+renesas@glider.be>
 <2e076cb5-1e31-10b2-9f33-79a825ac9c11@arm.com>
In-Reply-To: <2e076cb5-1e31-10b2-9f33-79a825ac9c11@arm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 16 Aug 2023 13:36:15 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVTNP8YyUCvA_LxH1uHWPrF6oLK6gmo4f998nSCXha59g@mail.gmail.com>
Message-ID: <CAMuHMdVTNP8YyUCvA_LxH1uHWPrF6oLK6gmo4f998nSCXha59g@mail.gmail.com>
Subject: Re: [PATCH] perf: ARM_SMMU_V3_PMU should depend on ARM_SMMU_V3
To: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Vincent Whitchurch <vincent.whitchurch@axis.com>, 
	Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Robin,

On Wed, Aug 16, 2023 at 1:23=E2=80=AFPM Robin Murphy <robin.murphy@arm.com>=
 wrote:
> On 2023-08-15 16:36, Geert Uytterhoeven wrote:
> > There is no point in monitoring transactions passing through the SMMU
> > when ARM Ltd. System MMU Version 3 (SMMUv3) Support is disabled.
> > Hence replace the dependency on ARM64 by a dependency on ARM_SMMU_V3
> > (which implies the former).
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > This caught my eye after commit 7c3f204e544dfa37 ("perf/smmuv3: Remove
> > build dependency on ACPI") in arm64/for-next/core.
> >
> > Perhaps my understanding is wrong? Is there anything to monitor when
> > ARM_SMMU_V3=3Dn?
>
> Yes, at least TBU event 1 still counts bypass transactions even when the
> SMMU is disabled, so PMCGs can be useful as basic traffic monitors in
> their own right. Plus the original design intent was that PMCGs may also
> be implemented by other things that interact with the SMMU, like
> ATS-capable PCIe root complexes, or devices with their own internal
> TLBs, thus they could potentially count any manner of
> implementation-defined events that aren't necessarily related to SMMU
> translation.

Thanks for the explanation!
Hereby I withdraw my patch.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
