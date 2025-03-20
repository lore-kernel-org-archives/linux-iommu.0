Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B666423C9
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 13:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742477842; cv=none; b=KkifpAHuGr8Qg7/HMgqulkdQ2MNwjA2UP9gDUbU8XoYvipCbXs0W3aIuA6pKVTWUIrccLwgoLGwp9Yr0Ro21E2nln6/6hUzsiapau4/NiU7p6olFhSTXTif7xNXFe9i4KtsGmewpo5t6I2/iFB3QFgJ7yb0rdVm39Jrb/7XB2io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742477842; c=relaxed/simple;
	bh=YR+i89cgDJ+s150iYLatiV4MlhOTZxfjkvujDA29uFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ja4s+13wymNuahexKnIJh0GIFu8vVnRpJpt0GHF88qvVEIwhx1/zTyNjCxrqXDHZjOoO5xkkYendCMw2AJd4zmVQSt03hk7PL8/2vid1NSjUi3lSuMZ60x+7H080EoRwA9x+JA3svJ8iHspgxzoREQBMCuGlOV5OZZbhmMWQ5Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fwoqQ5HL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwoqQ5HL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6EEC4CEEF
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 13:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742477842;
	bh=YR+i89cgDJ+s150iYLatiV4MlhOTZxfjkvujDA29uFg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fwoqQ5HLZ1VTIv4pp9u1zn9oOLN3dSG3sx/P/sy41uT7XN3wzeFcPZHv3Aw8TZlGH
	 TgZZBQcKI58BpuyLRalpbDpYyzzo12B46vYImUa+oMchrjfRbAyK6QYG4GBxe68MaA
	 pdwr5VIehWFuGN0jbOvkV9fcBOom77L0n3wIppOdXETVRAjyKuyC8qDbTSUekmqXbG
	 ZXr2sjsoppIhKA2egUYpbGDgz+IAJzkENMUQV0ZVgC/4CXDNyhLDrCBPaTyCrk63jv
	 q8V42/2euTC/kBXP4w/rnvPdP8A5kiA6+UjyRa2Gsu+Slt00EMAdkB37inBkHtPpn9
	 uNxiHg6y/TSwA==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5497e7bf2e0so941366e87.3
        for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 06:37:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWQTnP9ubUTF2ii/1HC3iJHGf5Cm3TQjmIN+i1Msb9h7yOXX/4GEGl3OLE3kgFZSBx7w5Fv1Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywi4M/QIvZ+VfuThY2cURjnfsEyZTW+9IX0YxatmXE/C/IxcIal
	GA2aOE1zKJgVfx6Bq/SRFp+J68p95SW8FQAYZ8uXfIvGvVxjTJ4vgKRKgC++SKvt60KF37SX5Cr
	wKIZQnvB6hCGjbv2CPcqmhJMh2lI=
X-Google-Smtp-Source: AGHT+IH1uSkf2uM+LcoD4uBRdGz5SL3adFWbT+OYTJyNNWdRyQZyb0lE1rVKbKGGzWThpM6glOaALBN3j3flNNCBE0Y=
X-Received: by 2002:a05:6512:e86:b0:549:86c8:113a with SMTP id
 2adb3069b0e04-54acb1b6b01mr3023005e87.15.1742477840456; Thu, 20 Mar 2025
 06:37:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250319150533.37440-2-miko.lenczewski@arm.com> <20250319150533.37440-3-miko.lenczewski@arm.com>
In-Reply-To: <20250319150533.37440-3-miko.lenczewski@arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 20 Mar 2025 14:37:08 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFOofRCiVHxxxBZMGQHRH-ghtqNxgd=uww9D4sr4vvjEQ@mail.gmail.com>
X-Gm-Features: AQ5f1JoXEf-176DDZRbp16VKBYBsy3AsXn6mHxJRtBdSe3bLtcfpofqtWsvZ_8c
Message-ID: <CAMj1kXFOofRCiVHxxxBZMGQHRH-ghtqNxgd=uww9D4sr4vvjEQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] arm64: Add BBM Level 2 cpu feature
To: =?UTF-8?Q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>
Cc: ryan.roberts@arm.com, suzuki.poulose@arm.com, yang@os.amperecomputing.com, 
	corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org, 
	jean-philippe@linaro.org, robin.murphy@arm.com, joro@8bytes.org, 
	akpm@linux-foundation.org, mark.rutland@arm.com, joey.gouly@arm.com, 
	maz@kernel.org, james.morse@arm.com, broonie@kernel.org, 
	oliver.upton@linux.dev, baohua@kernel.org, david@redhat.com, 
	ioworker0@gmail.com, jgg@ziepe.ca, nicolinc@nvidia.com, mshavit@google.com, 
	jsnitsel@redhat.com, smostafa@google.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 19 Mar 2025 at 16:06, Miko=C5=82aj Lenczewski
<miko.lenczewski@arm.com> wrote:
>
> The Break-Before-Make cpu feature supports multiple levels (levels 0-2),
> and this commit adds a dedicated BBML2 cpufeature to test against
> support for, as well as a kernel commandline parameter to optionally
> disable BBML2 altogether.
>
> This is a system feature as we might have a big.LITTLE architecture
> where some cores support BBML2 and some don't, but we want all cores to
> be available and BBM to default to level 0 (as opposed to having cores
> without BBML2 not coming online).
>
> To support BBML2 in as wide a range of contexts as we can, we want not
> only the architectural guarantees that BBML2 makes, but additionally
> want BBML2 to not create TLB conflict aborts. Not causing aborts avoids
> us having to prove that no recursive faults can be induced in any path
> that uses BBML2, allowing its use for arbitrary kernel mappings.
> Support detection of such CPUs.
>
> Signed-off-by: Miko=C5=82aj Lenczewski <miko.lenczewski@arm.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  3 +
>  arch/arm64/Kconfig                            | 11 +++
>  arch/arm64/include/asm/cpucaps.h              |  2 +
>  arch/arm64/include/asm/cpufeature.h           |  5 ++
>  arch/arm64/kernel/cpufeature.c                | 68 +++++++++++++++++++
>  arch/arm64/kernel/pi/idreg-override.c         |  2 +
>  arch/arm64/tools/cpucaps                      |  1 +
>  7 files changed, 92 insertions(+)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index fb8752b42ec8..3e4cc917a07e 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -453,6 +453,9 @@
>         arm64.no32bit_el0 [ARM64] Unconditionally disable the execution o=
f
>                         32 bit applications.
>
> +       arm64.nobbml2   [ARM64] Unconditionally disable Break-Before-Make=
 Level
> +                       2 support
> +
>         arm64.nobti     [ARM64] Unconditionally disable Branch Target
>                         Identification support
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 940343beb3d4..49deda2b22ae 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -2057,6 +2057,17 @@ config ARM64_TLB_RANGE
>           The feature introduces new assembly instructions, and they were
>           support when binutils >=3D 2.30.
>
> +config ARM64_BBML2_NOABORT
> +       bool "Enable support for Break-Before-Make Level 2 detection and =
usage"
> +       default y
> +       help
> +         FEAT_BBM provides detection of support levels for break-before-=
make
> +         sequences. If BBM level 2 is supported, some TLB maintenance re=
quirements
> +         can be relaxed to improve performance. We additonally require t=
he
> +         property that the implementation cannot ever raise TLB Conflict=
 Aborts.
> +         Selecting N causes the kernel to fallback to BBM level 0 behavi=
our
> +         even if the system supports BBM level 2.
> +
>  endmenu # "ARMv8.4 architectural features"
>
>  menu "ARMv8.5 architectural features"
> diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cp=
ucaps.h
> index 0b5ca6e0eb09..2d6db33d4e45 100644
> --- a/arch/arm64/include/asm/cpucaps.h
> +++ b/arch/arm64/include/asm/cpucaps.h
> @@ -23,6 +23,8 @@ cpucap_is_possible(const unsigned int cap)
>                 return IS_ENABLED(CONFIG_ARM64_PAN);
>         case ARM64_HAS_EPAN:
>                 return IS_ENABLED(CONFIG_ARM64_EPAN);
> +       case ARM64_HAS_BBML2_NOABORT:
> +               return IS_ENABLED(CONFIG_ARM64_BBML2_NOABORT);
>         case ARM64_SVE:
>                 return IS_ENABLED(CONFIG_ARM64_SVE);
>         case ARM64_SME:
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm=
/cpufeature.h
> index e0e4478f5fb5..108ef3fbbc00 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -866,6 +866,11 @@ static __always_inline bool system_supports_mpam_hcr=
(void)
>         return alternative_has_cap_unlikely(ARM64_MPAM_HCR);
>  }
>
> +static inline bool system_supports_bbml2_noabort(void)
> +{
> +       return alternative_has_cap_unlikely(ARM64_HAS_BBML2_NOABORT);
> +}
> +
>  int do_emulate_mrs(struct pt_regs *regs, u32 sys_reg, u32 rt);
>  bool try_emulate_mrs(struct pt_regs *regs, u32 isn);
>
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeatur=
e.c
> index d561cf3b8ac7..1a4adcda267b 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -2176,6 +2176,67 @@ static bool hvhe_possible(const struct arm64_cpu_c=
apabilities *entry,
>         return arm64_test_sw_feature_override(ARM64_SW_FEATURE_OVERRIDE_H=
VHE);
>  }
>
> +static bool cpu_has_bbml2_noabort(unsigned int cpu_midr)
> +{

We generally start these block comments with just /* on the first line

> +       /* We want to allow usage of bbml2 in as wide a range of kernel c=
ontexts
> +        * as possible. This list is therefore an allow-list of known-goo=
d
> +        * implementations that both support bbml2 and additionally, fulf=
ill the
> +        * extra constraint of never generating TLB conflict aborts when =
using
> +        * the relaxed bbml2 semantics (such aborts make use of bbml2 in =
certain
> +        * kernel contexts difficult to prove safe against recursive abor=
ts).
> +        *
> +        * Note that implementations can only be considered "known-good" =
if their
> +        * implementors attest to the fact that the implementation never =
raises
> +        * TLBI conflict aborts for bbml2 mapping granularity changes.
> +        */
> +       static const struct midr_range supports_bbml2_noabort_list[] =3D =
{
> +               MIDR_REV_RANGE(MIDR_CORTEX_X4, 0, 3, 0xf),
> +               MIDR_REV_RANGE(MIDR_NEOVERSE_V3, 0, 2, 0xf),
> +               {}
> +       };
> +

Why on earth is this needed? Is there nothing in the architecture that
can inform us about this? That seems like a huge oversight to me ...
