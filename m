Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794593950;
	b=xvNcVpuTnf5Yoww/irmutPiE/juEXTEmaUxKXh7DCKAL7vFNTixMGRbIPl8QLRYbqvul
	 F2ynlomYIydkZA07BMmxXmJSwuh9kFjcF9b7E8/Hy6SGk7ngvsS1pJxX0GCYqf5ijwTzu
	 BybsGGM3B0sIeqLYT3vZHZCUKYGy52SnJmT4nWlMB12nBImcLOuNT2RBDefphA8j0CyK2
	 lazRaexktWPV5GazqwWA/mdSKqmUEoeay1cpE/INdTZBhe/9Huw9rrgZzxwlVG+nIaQlK
	 Xuzm5lV7lv7wmZBV0b9kDY4gTg7ZCDU38Myx71LGlLeXQJflh+UKlidiXtssTiYqqRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794593950;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=/VIh85zZMfzSY6G83+v5V/TjnRLbNiLly0GYfH3nJNs=;
	b=fHYwkudpLj7j9SFX7Mja3BqPahiuyd5K6ioDuW8XgzyxSDKej63Ve/kiz0Xaw2VNQTKj
	 SGKz9KYq8K1tWhSUtr8+nEJ/h9gearYdtj50YBqTpZAOU1mI2bBtReDVO4kW1VJ2rVh6P
	 5Ft6hFm6NvFdNGIuvzl7Z1kphqQ3PxfrgUZXDoLJdFrc6LFeRyW8djbmhr0BlPxD9YYII
	 U7k7e2iYDTLd+o2LbAf9MccBkye23VQyiYdYeN1lBXUdqI7c5mhdtK+6iO/GMJz9dgiD0
	 j9ElB0h/J3plu9QsNhzgG6f5RUkz+tv1wr0byMTqueZrsoWNeW7OuNT78yFpoY4WyrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TzC7cE78;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D958606A893
	for <iommu@lists.linux.dev>; Fri, 13 Nov 2026 18:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TzC7cE78
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D14A1F000D1
	for <iommu@lists.linux.dev>; Fri, 13 Nov 2026 18:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794593950;
	bh=/VIh85zZMfzSY6G83+v5V/TjnRLbNiLly0GYfH3nJNs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=TzC7cE78kKFl2rFE1ESKez8K3/v6Pqk/6PLrXGyiq2H8nW8RaKll1mNR/hvrBhoAX
	 9WUKboDxL2p3Jax+koelb066IybY3DAyK95vGOnYrQLEWCd8zr9JB2nkLXwMD48oro
	 eBlcvuFHizULDj5hONrf7IDExHONWpvIf77MgXaUD3OXBqfZQ67bfgb2xPq1SoAoJK
	 T3NkAz2AcSCaHe3eo20kPD9U/cE84jkgmN3fcFTb3UIgs2jbLigXSsu2MG4WlwRKQd
	 lN4tR2+CCuZNMvYNucVewMR1jQy7sxt8uriatRDaKQNHlu1Xb8w/7Uzi3R4wDwiNfg
	 QeLT7VoO7hmng==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5bfbc67991cso1213175e87.0
        for <iommu@lists.linux.dev>; Fri, 13 Nov 2026 10:19:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEwktorU2SRTgxfnvc59NfZdVUgeK2oovIscVg7xRlm7adn7iO+72Vg0UMTxDpZEIl6VK7aAw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/LAFY2cm61yQSKalRvcvuIWVt+xrhmkVI1b+yAJJoBIODgN0Tt
	jzWXOQG2R0AyndxwuIxwuZXJr1k/vS2UpCAbHQirg0FslW1o3xg/4bx8SGuckn1I8TosGvfdacY
	Drc/fUx/Sw8zApj+CAyZtO6gc8NDF6ek=
X-Received: by 2002:a05:6512:1310:b0:5bf:cf80:dfd8 with SMTP id
 2adb3069b0e04-5c170a0bb47mr1769832e87.23.1794593948320; Fri, 13 Nov 2026
 10:19:08 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261029163044.3062958-1-Frank.Li@oss.nxp.com>
In-Reply-To: <20261029163044.3062958-1-Frank.Li@oss.nxp.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 13 Nov 2026 19:18:55 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jyuMjh4En_r2TYui+sNbGveJ0Rz1Da39LEK9e-HxHgGA@mail.gmail.com>
X-Gm-Features: AclHuK9_YtJ6aWlSAf9yM8R-lWnFcHYi_anHWoQsLhZYkqzdVHJqxA51shEqA-Y
Message-ID: <CAJZ5v0jyuMjh4En_r2TYui+sNbGveJ0Rz1Da39LEK9e-HxHgGA@mail.gmail.com>
Subject: Re: [PATCH 1/1] PM: runtime: change stub pm_runtime_get_if_active()
 return 1 when !CONFIG_PM
To: Frank.Li@oss.nxp.com
Cc: Frank Li <Frank.Li@nxp.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>, 
	Karol Wachowski <karol.wachowski@linux.intel.com>, Oded Gabbay <ogabbay@kernel.org>, 
	Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, Matthew Brost <matthew.brost@intel.com>, 
	Thomas Hellstrom <thomas.hellstrom@linux.intel.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Alex Elder <elder@kernel.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
	Rob Clark <robin.clark@oss.qualcomm.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Guenter Roeck <linux@roeck-us.net>, 
	Guan-Yu Lin <guanyulin@google.com>, Mathias Nyman <mathias.nyman@linux.intel.com>, 
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	intel-xe@lists.freedesktop.org, linux-hwmon@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-staging@lists.linux.dev, netdev@vger.kernel.org, imx@lists.linux.dev, 
	Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 5:31=E2=80=AFPM <Frank.Li@oss.nxp.com> wrote:
>
> From: Frank Li <Frank.Li@nxp.com>
>
> When CONFIG_PM is not enabled, all devices runtime PM state should be
> treated as active.
>
> __pm_runtime_resume() returns 1 (called by pm_runtime_get()).
> pm_runtime_get_if_active() is the try-and-get version of pm_runtime_get()=
.
> stub pm_runtime_active() also returns true. So pm_runtime_get_if_active()
> should return the same value as the stub pm_runtime_get(), which is 1.
>
> Analysis of all callers and their behavior with old (-EINVAL) vs new (1):
>
> Pattern A: if (!pm_runtime_get_if_active(dev)) -- no impact
>   Both -EINVAL and 1 are non-zero, so !ret is false in both cases.
>   Callers: drivers/accel/ethosu/ethosu_perfmon.c,
>            drivers/gpu/drm/msm/adreno/a6xx_gmu.c,
>            drivers/gpu/drm/msm/msm_perfcntr.c,
>            drivers/gpu/drm/v3d/v3d_mmu.c,
>            drivers/gpu/drm/v3d/v3d_perfmon.c (x4),
>            drivers/media/i2c/gc08a3.c gc05a2.c og0ve1b.c ov6211.c,
>            drivers/media/i2c/ccs/ccs-core.c s5kjn1.c lm3560.c (x2),
>            drivers/media/i2c/s5k3m5.c thp7312.c imx283.c ov64a40.c,
>            drivers/media/pci/intel/ipu6/ipu6-buttress.c,
>            sound/hda/core/device.c
>
> Pattern B: if (!ret) after get -- no impact
>   Both -EINVAL and 1 are non-zero, !ret is false in both cases.
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c (comment says "allow access"
>     in kernels without CONFIG_PM), drivers/pci/pci.c
>
> Pattern C: ret > 0 / ret <=3D 0 / ret !=3D 1 checks -- FIXED
>   drivers/usb/core/offload.c: checks (!=3D 1), old -EINVAL caused
>     -EBUSY even with !CONFIG_PM. Fixed: now returns 1, proceeds.
>   drivers/accel/ivpu/ivpu_job.c: drm_WARN_ON(<=3D 0), old -EINVAL
>     spuriously triggered WARN. Fixed: 1 > 0, no warn.
>   drivers/gpu/drm/i915/intel_runtime_pm.c: checks (<=3D 0), old
>     -EINVAL triggered error path. Fixed: 1 > 0, correct path.
>   drivers/accel/ivpu/ivpu_sysfs.c: (> 0), old skipped freq read.
>     Fixed: proceeds correctly without CONFIG_PM.
>   drivers/gpu/drm/xe/xe_pm.c: wraps (> 0), all xe callers
>     (xe_bo.c, xe_shrinker.c, xe_vsec.c, xe_ggtt.c, xe_guc_ct.c,
>     xe_pxp.c) now correctly treat !CONFIG_PM as active.
>   drivers/net/ipa/ipa_smp2p.c: power_on =3D (> 0), now correctly true.
>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c: (> 0), now correctly
>     executes stall register update.
>   drivers/staging/media/ipu7/ipu7-buttress.c: active (<=3D 0) early
>     return now skipped, correctly proceeds.
>
> Pattern D: explicit -EINVAL check
>   drivers/hwmon/prom21-xhci.c: checks (> 0) then (=3D=3D -EINVAL).
>     Old: took -EINVAL fallback. New: takes (> 0) fast path.
>     Both succeed when CONFIG_PM is disabled; functionally equivalent.
>   drivers/hwmon/eic7700-pvt.c: call is guarded by IS_ENABLED(CONFIG_PM),
>     stub is never reached. No impact.
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

People sent feedback, so I'm wondering if there's going to be a v2 or
does someone else need to take care of this going forward?
