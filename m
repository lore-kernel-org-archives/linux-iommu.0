Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B013E2C726
	for <iommu@lists.linux.dev>; Tue, 16 May 2023 09:53:13 +0000 (UTC)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-54fb3ef9c53so2789927eaf.3
        for <iommu@lists.linux.dev>; Tue, 16 May 2023 02:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684230793; x=1686822793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUyWbDWLzBbwVa1NBzeenGWyMmMD2r29seiz5UsbH5s=;
        b=D/yRNt4MQRyZ0HSzVSkvV/+LSWJfO1P9YchgIq0aqYq5lq95Uz05BhRpR+muzlLGRx
         knRT5R4JbyYdOCBluPeerFZ1y7C7ak614gh3jMNQ0jl9k/qb9IJyJdBb9Q03cSo5Mohl
         64TnQg8QWbqLCBqrokrYuCFhMrDpFkwq3NPlrdzHIhH4VwaxiQG7t+hvU3CEG3gk9FZd
         obSleGPG2bW1wJXBWLm9F62eYK1eOvUYjgDVhggH/4uljhLBtZ+XtfIlHEqgnj37fm8A
         WM0a1rGDD98MP+GM9mw47vJ7ZLvS3JnuwqHMdnamwG1hbdFmRTxFKhvDZnRpFVCtajR6
         E5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684230793; x=1686822793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sUyWbDWLzBbwVa1NBzeenGWyMmMD2r29seiz5UsbH5s=;
        b=Yy+hP0tAKdUSMEHksUjT01gTnfiaGpx4lcgv2kseR2/Euq8t83ntF51UdDZekAGn2x
         vaE03fHcAa4FmyvEGVnq6pgPJjkHpNjaIIIww2BZEIBuEjo7i0Iu2v8Yu+9HLfy52MVZ
         176Jzn9r666s1wRFQ5Zn7leMDkRKIWNt1xc31hPK24h9V4R0uEecddnmPmmJ5Pt66ewh
         +W9azKKRbZrET/nBsFZm2pp3bfED6/C4bGEkx2c+xI1WTgrWs8hlSeTCvrDkck3ecdqa
         Mmuy7yT7skFbxs5r8uMhNlicWxOWF7Q7SYV5lCfYupM8/jOPwqhDH5vkGDVvx5lthfDY
         fiiA==
X-Gm-Message-State: AC+VfDzyq9TB2vLMOq1fHqbJ5f6ZRBwi2L26m+KN/N91GBxZcI05R3DH
	ZNMat+Ea13lkf0/+qezK8NBj739CV05bczAHG18=
X-Google-Smtp-Source: ACHHUZ6qBzkUrqzfZWjjUyTwZDpxczedNsiP925z+88F8yPLQgbrPTp/axsev+vTNGfxAb7ND65H0v0H6XeLLlMFWX8=
X-Received: by 2002:a4a:2a5d:0:b0:54f:6a7a:c6d with SMTP id
 x29-20020a4a2a5d000000b0054f6a7a0c6dmr10042774oox.3.1684230792632; Tue, 16
 May 2023 02:53:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1684154219.git.robin.murphy@arm.com>
In-Reply-To: <cover.1684154219.git.robin.murphy@arm.com>
From: Nicolas Chauvet <kwizart@gmail.com>
Date: Tue, 16 May 2023 11:53:01 +0200
Message-ID: <CABr+WTnzNPfOGbAmy-E3pH9U5XR0y2PdVmDd2gtnv67ByEb_0w@mail.gmail.com>
Subject: Re: [PATCH 0/4] iommu: tegra-gart cleanups
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, iommu@lists.linux.dev, will@kernel.org, jgg@nvidia.com, 
	digetx@gmail.com, thierry.reding@gmail.com, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 15 mai 2023 =C3=A0 14:57, Robin Murphy <robin.murphy@arm.com> a =C3=
=A9crit :
>
> Hi all,
>
> For the sake of discussion, here's my irrational pet project to bring
> the tegra-gart driver right up to date as an example of a
> properly-implemented IOMMU driver for a non-isolated address space. Part
> of that irrationality is that I don't even own any hardware which uses
> this driver, so it's only build-tested :)
>
> Thanks,
> Robin.
>
>
> Robin Murphy (4):
>   iommu/tegra-gart: Add default identity domain support
>   iommu/tegra-gart: Improve domain support
>   iommu/tegra-gart: Generalise domain support
>   iommu: Clean up force_aperture confusion
>
>  drivers/iommu/dma-iommu.c    |  19 ++--
>  drivers/iommu/mtk_iommu_v1.c |   4 +
>  drivers/iommu/sprd-iommu.c   |   1 +
>  drivers/iommu/tegra-gart.c   | 162 +++++++++++++++++++----------------
>  4 files changed, 99 insertions(+), 87 deletions(-)


For what it worth, I've tried to test this serie with "grate patches"
(1) rebased on top on 6.4-rc2, that would make use of the tegra-gart.
That was on PAZ00 (with only 512M of RAM and 96M CMA still allocated).
Unfortunately, this lead to the following errors with display problems
(no character displayed in lxt-terminal and etc)

[  888.691348] tegra-mc 7000f000.memory-controller: gart: Page entry is in-=
use
[  888.698400] [drm:tegra_bo_gart_map_locked [tegra_drm]] *ERROR*
mapping failed 4294967274 262144
[  888.707365] [drm:tegra_bo_gart_map_locked [tegra_drm]] *ERROR*
failed size 262144: -12
[  888.716735] tegra-mc 7000f000.memory-controller: gart: Page entry is in-=
use
[  888.723800] [drm:tegra_bo_gart_map_locked [tegra_drm]] *ERROR*
mapping failed 4294967274 262144
[  888.733156] [drm:tegra_bo_gart_map_locked [tegra_drm]] *ERROR*
failed size 262144: -12
[  889.055247] tegra-mc 7000f000.memory-controller: gart: Page entry is in-=
use
[  889.062296] [drm:tegra_bo_gart_map_locked [tegra_drm]] *ERROR*
mapping failed 4294967274 262144
[  889.071266] [drm:tegra_bo_gart_map_locked [tegra_drm]] *ERROR*
failed size 262144: -12

(1) https://github.com/grate-driver/linux
