Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3B524EA6
	for <iommu@lists.linux.dev>; Tue, 16 May 2023 12:16:25 +0000 (UTC)
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6ab1e0420e8so3487765a34.1
        for <iommu@lists.linux.dev>; Tue, 16 May 2023 05:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684239385; x=1686831385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJTLLzb95iDF+U7TC6zcnoMcQpJeTgiUu6Gi3Heef+s=;
        b=Wvix5cPG/AAnP0NwB2UCmfUq22GVG2ZHMJi56Od5hjUJ99vSAa+2Q73WGyqynUnkuz
         S4Yf6p+c0NKlRcso+cETWYl/LFztPppn/O3UVa82WAUK8r59dSrW6GbBNMz/jGdUYGQ4
         LKgSFrvgiRJCQvdHnYIvSmsBrjjLRjEihRF6xPHg0Hbpg09uPaqVdgMQOf77OucuojRC
         ostCWsSYcaVQoIfijW43hi84igtO4oSOChnUpt444yKtz1scxFpxlnZu7g1J/Q8pCktM
         +BrMFzRDbwHMrv7qu3If/VSQmLHECoYZ/KFTQX0CmfWKjBJ7YPIujCo7+Ir7pn/CEFDH
         qbzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684239385; x=1686831385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vJTLLzb95iDF+U7TC6zcnoMcQpJeTgiUu6Gi3Heef+s=;
        b=S1fI7gyCKlNoIgGSkjq+0/6dG5NG9yORdIZ8qpuEWDqm7cqzl426M36enkS6PzB+Xh
         Z0bg1wqLHKTjfSxBbmLSg2fh0El7Z1RuD+5Ne6aTa/vYjo1KRN9xqtBuj3zBidRYZKXo
         6F/zgvwVvjc5PJM+2AXuppzVhYfMC2T5WO+H52jhzAgh8yZ7dCUauEceIft1ajQCB30y
         gOUf4VayBGznrJ4QO7QUDoWHtti503Qg2u24vBGN33UagSp3ZXn2D8Mm0+Gi/bLFfp40
         jOD2rgK8ztilZgG6Mmai4RuKEaOerGFaYHPGDca+yTxafXyi7QvEHVvF2j+f7NTHl+7n
         YXnQ==
X-Gm-Message-State: AC+VfDxPLDY0yNriKHe2uU0SFayvCkJkAQhluUD99zxdcALiKcP19E4t
	ZTjTWg3GXWzj7C/l4+zv03Vngkk4pLaPw7PZb04=
X-Google-Smtp-Source: ACHHUZ6hCKLE4fpIzovSfFZkpibP/nHCjM5L7XwkUu2hQtjwFHnaOPkuEvb+NOIcYo1h4bvDOQsd9kJUF/kNmbLBR1I=
X-Received: by 2002:a05:6808:1511:b0:395:48a:e694 with SMTP id
 u17-20020a056808151100b00395048ae694mr8079810oiw.6.1684239384975; Tue, 16 May
 2023 05:16:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1684154219.git.robin.murphy@arm.com> <CABr+WTnzNPfOGbAmy-E3pH9U5XR0y2PdVmDd2gtnv67ByEb_0w@mail.gmail.com>
 <11d8adf1-75f5-5728-2139-e32aae6e6c49@arm.com>
In-Reply-To: <11d8adf1-75f5-5728-2139-e32aae6e6c49@arm.com>
From: Nicolas Chauvet <kwizart@gmail.com>
Date: Tue, 16 May 2023 14:16:13 +0200
Message-ID: <CABr+WTm=SehaNVaFym5FM-tpCvh93Ma_xG3xX5PuGt6n9+xh4Q@mail.gmail.com>
Subject: Re: [PATCH 0/4] iommu: tegra-gart cleanups
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, iommu@lists.linux.dev, will@kernel.org, jgg@nvidia.com, 
	digetx@gmail.com, thierry.reding@gmail.com, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 16 mai 2023 =C3=A0 13:45, Robin Murphy <robin.murphy@arm.com> a =C3=
=A9crit :
>
> On 2023-05-16 10:53, Nicolas Chauvet wrote:
...
> > For what it worth, I've tried to test this serie with "grate patches"
> > (1) rebased on top on 6.4-rc2, that would make use of the tegra-gart.
> > That was on PAZ00 (with only 512M of RAM and 96M CMA still allocated).
> > Unfortunately, this lead to the following errors with display problems
> > (no character displayed in lxt-terminal and etc)
>
> Thanks for testing - it's quite possible I've made a silly mistake
> somewhere, but just to double-check, does the same happen with the
> existing driver if you boot with "tegra-gart.gart_debug=3D1" (or at least
> enable the parameter via sysfs before the DRM driver gets going)?

Using echo 1 > /sys/module/tegra_gart/parameters/gart_debug shows the
same messages and the same artefacts (missing refreshed window
content).
Using "echo 0 > /sys/module/tegra_gart/parameters/gart_debug" revert
back to normal...

[ 7661.026139] tegra-mc 7000f000.memory-controller: gart: Page entry is in-=
use
[ 7661.033189] [drm:tegra_bo_gart_map_locked [tegra_drm]] *ERROR*
mapping failed 4294967274 262144
[ 7661.042197] [drm:tegra_bo_gart_map_locked [tegra_drm]] *ERROR*
failed size 262144: -12
[ 7661.589552] tegra-mc 7000f000.memory-controller: gart: Page entry is in-=
use
[ 7661.596690] [drm:tegra_bo_gart_map_locked [tegra_drm]] *ERROR*
mapping failed 4294967274 262144
[ 7661.605865] [drm:tegra_bo_gart_map_locked [tegra_drm]] *ERROR*
failed size 262144: -12
[ 7662.078823] tegra-mc 7000f000.memory-controller: gart: Page entry is in-=
use
[ 7662.085987] [drm:tegra_bo_gart_map_locked [tegra_drm]] *ERROR*
mapping failed 4294967274 262144
[ 7662.095137] [drm:tegra_bo_gart_map_locked [tegra_drm]] *ERROR*
failed size 262144: -12
[ 7662.123677] tegra-mc 7000f000.memory-controller: gart: Page entry is in-=
use
[ 7662.130758] [drm:tegra_bo_gart_map_locked [tegra_drm]] *ERROR*
mapping failed 4294967274 262144
[ 7662.140100] [drm:tegra_bo_gart_map_locked [tegra_drm]] *ERROR*
failed size 262144: -12
