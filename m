Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58972345731
	for <iommu@lists.linux.dev>; Thu, 12 Mar 2026 19:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773343239; cv=pass; b=G5jNg4vFINy9w1ra96Lzm+skAlYik/+kIF2AwYU228mRhR6zdjMrfQqLtw652KWvIkZAWfl/kiIHTiV92y9tCYrh9p3/7ZZQlY8+a1jzp10cbqIEcVEHJ1edcws3FiYyZBTIpN/43MYtVticuHzm1kPSizZ0KXj0OslPvTdUZzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773343239; c=relaxed/simple;
	bh=1p1rVUpubn0TkbbLs6HdRlB08VV4AWv3JGoj6w28fE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=olvcJxeY4+1Xnpik0f1TaTr7N4BOjYpLWoiia1eGWsG1p0X8Zxe/KJVp3Y1MJLUXCdhF3wPFDxrLuo+rTQrUjtuVIlvw5GTTuYcI4vKFj8uxvto7E/OfRYMLvj48LvAbnCLzfpvK3AXlWeZIH5qe8Xj5/fky5OLptf4ULtXXcvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M0rpCsfD; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M0rpCsfD"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-509069a7a7fso110731cf.0
        for <iommu@lists.linux.dev>; Thu, 12 Mar 2026 12:20:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773343237; cv=none;
        d=google.com; s=arc-20240605;
        b=aFwA1cbpPWgPaQJdX2e/2IVVLz0pB0xGrM7QZR2tacgZV9HDn719nbY2CSpOrUO4Bz
         Uf0kBlx6SSZv6mx5bg1cqKm2bXvnfyJylUws5GIM93Q3z+z0Hy42cSVTKKs8RfrMzgfu
         T3ZF+MpaoW6DDYvgF6IqXvmqdQHF+9y5hhlYU2etChxXuUsP6Q88knG46syuY6di4n+0
         sKEbfFGCf2zQcW1GIANDjHM0XK0torwUNfCr88Gb3CCJA+VoO/yXTNy/b3yJj7Lu6RYy
         VpeN4SecEPxnr2mPGaIgzqYtjYMe1t7Vu8exvDtcbcNjTSsfTl9iW3Y4KxTzq7mhoCbQ
         Fiiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U/d2MOOPF3ZMEQNCe2Fd2ZGxbL56o0N2QpQaZWkumCk=;
        fh=Cr9Gz+4KxVp4Ci1moPY7g4WpWFGCr0a9bcVWr63STi0=;
        b=gDvpRzTNvOz01x5OC/Qtrcgr0jW+IYhmtofD8/cMgVClua6PJuoi/o3+uUWZhjyh6Y
         hQ34HV0yczeSZzjfYCSZd4p9oLdBbBMQmTUL0UGT3jsUVrpUwLvSmci8j5pS+85T6ohB
         2N80kFsQbCtkxFeI+CDByoFRftW9H97lDYzeqqF9GqyBE+pv9zjDqj5IG9rWjBr26Lld
         LO5jfp39SUNoADtSHeYqMua61j969Azfji74BwStUOXk9azcTVBlmmhFybWTJR5ThiM7
         eeiE5q5CkrkDlON0d8Fvs6DyVmYws2W0fXvTElpTWdPr756tYcChOr1KFEPsEaCzXh9H
         lSjA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773343237; x=1773948037; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/d2MOOPF3ZMEQNCe2Fd2ZGxbL56o0N2QpQaZWkumCk=;
        b=M0rpCsfDRKPpxkImfzdrG/Qzb+G6b3obfpS0Mj91WSAcki3qji5tbY4+Ehz5kixlGc
         HvNhDrj08C0bMMLQ6ZxbZTbjR/nk1KmYOqzE4WefAI0OOte/3KOPm8V+58Mg0ahy4sU5
         kC86+hE3qThEwaOEs5FKhv9ApOLL25MtUyshvPMSKxHGhWJvFF+nUkilQWBQj7dnrWBo
         kmzN6Ay0B4r0b2S+AhTPJb37eFt+bRx22cMAebSRSCeALaaZexRM/JAZfpT6sgsoE/+v
         Oxkx03FBROJaweE3vg/JCRL7DP6f/rehOdV+UToS+7as77uN0cBKK22jbjCH/Koksa/M
         b3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773343237; x=1773948037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U/d2MOOPF3ZMEQNCe2Fd2ZGxbL56o0N2QpQaZWkumCk=;
        b=m7GhpjlP2PX2L7OcTEUDTJksZDd1pkJ7FnzeJSYfqFzReIugAqSDFSacdEK0/6w2n+
         PpEAa66JSDojgx0yI05Ei4FsIJNK5653u7GG8B+wKL7+P6wM8vZuzMiy7O8nmlMlClIO
         l8AVJZYOttOZ0oYarAgugBoTGnW8iJxeLqbnY4YZ2h4hZMJNelOYx1wvq8ZvJvZIcqHS
         ZB6Pss/ZwXRNlDn4oMu12e34CRpffLkJ1bC8f1yx1k8BQLhL0aCg4ZuCcu+Sz3b15lGt
         n7u8gc04dEMUi/TGP4MLb7aGnssl1oQlSaaQldPgmp/lG6BHLD9zbMOAcaclWiZUh2Mh
         KbGw==
X-Gm-Message-State: AOJu0YwWPoXCYx8gmqjaWblvBYoT4DGHIK4LTXzWZfnXuRJnzmeGrRUJ
	4fkT5afQnhlo7uaymZXHi1rYpHcMsQjVturZcWtabDaJF67xeVfyvIdiix9VWVx5AW7HugRK6ti
	WIGQgnTAvgH1zTD8iOiAB2+XCcsnIR2TmKpBXebKd
X-Gm-Gg: ATEYQzxHeaHsoDw5tJeLfu/by8/RkkYMfMpLFDgK9YX5HO2ZEUdFWvTYtkhEIGVBPco
	0dIESd4YBbawIW0cZpvAEYXntkId8eX4NURv9BQt2rMRqhLyUybKhnGf+gS7U2CJi/ArCLxcI1T
	xaRVJ1RCjBkrOsFtl8Yl/GgKyMaYELPlW+ozSZWpu7AFSUBhj8Eo52rJZbXy/YNpBt/4/2A/O9B
	9cNJNOA0f4fjy21Kswe0TZmvFL4gslqtwHeYdU1W2oUhefYaIWmcU+ZN3h4YVQRUjkNjUGaVDLD
	W9Ug
X-Received: by 2002:a05:622a:4686:b0:501:4eae:dbfc with SMTP id
 d75a77b69052e-50958572d94mr2072151cf.5.1773343236617; Thu, 12 Mar 2026
 12:20:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260126151157.3418145-1-praan@google.com> <20260126151157.3418145-8-praan@google.com>
In-Reply-To: <20260126151157.3418145-8-praan@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Thu, 12 Mar 2026 12:20:25 -0700
X-Gm-Features: AaiRm51sU67nY4M8rbrrJVuhicK2ddqELsHmFyc8c3Bf0n-SEnG5m97iYoTWHG4
Message-ID: <CAE2F3rCh_FvijhHfv34b9kzrMuTW+H0JgZSY5q-NrBjLbOQ9mw@mail.gmail.com>
Subject: Re: [PATCH v5 07/10] iommu/arm-smmu-v3: Implement pm_runtime & system
 sleep ops
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Ashish Mhetre <amhetre@nvidia.com>, 
	Sairaj Kodilkar <sarunkod@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 7:12=E2=80=AFAM Pranjal Shrivastava <praan@google.c=
om> wrote:
> +static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)

I understand that most or all other IOMMU drivers use __maybe_unused,
but have you considered gating these definitions by an #ifdef
CONFIG_PM instead of using __maybe_unused?

> +{
> +       struct arm_smmu_device *smmu =3D dev_get_drvdata(dev);
> +       int timeout =3D ARM_SMMU_SUSPEND_TIMEOUT_US;
> +       u32 enables;
> +       int ret;
> +
> +       /* Try to suspend the device, wait for in-flight submissions */
> +       do {
> +               if (atomic_cmpxchg(&smmu->nr_cmdq_users, 1, 0) =3D=3D 1)
> +                       break;
> +
> +               udelay(1);

In other situations where we are waiting, e.g. in queue_poll() and
readl_relaxed_poll_timeout(), we use a procedure based on ktime_get().
Consider doing the same here or using queue_poll().

> +       } while (--timeout);
> +
> +       if (!timeout) {
> +               dev_warn(smmu->dev, "SMMU in use, aborting suspend\n");
> +               return -EAGAIN;
> +       }

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.h
> index 50a2513e4425..6a752fe06f54 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -502,11 +502,14 @@ static inline unsigned int arm_smmu_cdtab_l2_idx(un=
signed int ssid)
>
>  /* High-level queue structures */
>  #define ARM_SMMU_POLL_TIMEOUT_US       1000000 /* 1s! */
> +#define ARM_SMMU_SUSPEND_TIMEOUT_US    100     /* 100us! */

Isn't a 100us timeout very short? For the other operations in
arm_smmu_runtime_suspend including arm_smmu_update_gbpa,
arm_smmu_write_reg_sync, arm_smmu_drain_queues and
arm_smmu_device_disable, we allow for a 1 second timeout. Also,
waiting for nr_cmdq_users to become 1 indirectly means we are waiting
for a SYNC command to be consumed for which we allow a 1 second
timeout.

>  #define ARM_SMMU_POLL_SPIN_COUNT       10
>
>  #define MSI_IOVA_BASE                  0x8000000
>  #define MSI_IOVA_LENGTH                        0x100000
>
> +#define RPM_AUTOSUSPEND_DELAY_MS       15

Consider moving this to "iommu/arm-smmu-v3: Enable pm_runtime and
setup devlinks" where it is first used.
