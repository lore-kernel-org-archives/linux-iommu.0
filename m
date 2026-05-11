Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3D13988F8
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 07:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778485246; cv=none; b=oyBSN3kopQsIHsASi3FsVHAXpZZWvM2fdMVvYQLa72GrFtTxBkmIVPfoU0bDCbWAr0V5YKcRj7s4DVCZ9c8MojpSLy+Cm1AD3HPJK57KFhrB+eWMWOfTmHbWeSHzB2kRtLUoaOKpYe50Zq1nb2X+PyREy6JggvyME2kymYIQlFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778485246; c=relaxed/simple;
	bh=9FrUoRU49jwOabA/vjapc/59tExWKObeTZLJzDmtwlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=epuLDE1MP8S1SAPD6QbUPsMqFu1cJSL5BeA0qtP4rojYdOH23hQwFLsPpZB7JXCAKXljZcZg1TEJ84KSRR4eCHjXXLwbmskjvjSx5og0tsYxRar8a1vmYX5RrphUIPv1F9sj6E+Ay5P6L23NKwZ32igx4BRWYaV0pjMBPgj/OvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=SRLhmCGJ; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="SRLhmCGJ"
Received: from 8bytes.org (p200300f6af1d9600f5faa5cebd6c042e.dip0.t-ipconnect.de [IPv6:2003:f6:af1d:9600:f5fa:a5ce:bd6c:42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 7101B1C41F2;
	Mon, 11 May 2026 09:40:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1778485241;
	bh=9FrUoRU49jwOabA/vjapc/59tExWKObeTZLJzDmtwlo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SRLhmCGJYwI6a3YUNykAEvhDgv2gSvkJdn5kr6qAzzlFtAtm/iJWWeEk+r5wIvvep
	 rsvyAAIao2aWaSkTOonO0RGLiLcUKkxLIDLqeZg7oQCjnm/grXkJsue/JVx9EF1nF3
	 Yh+8MtZkmokcw4bQaZUanN0ghZhwSxFLyLhEl74bEu8lZIQrSB2nIBBBjyi+rq6Bdc
	 bOqhsif0dsOQgQv6SPZsU1mwTjFjxHaw7a9VUqs82qFISIcSBx4LPZCd/iUkZYOTOq
	 FBCIiPv+v6KbsKKiKlcxHHcC22hKsNMrmhv/EThuneCvGAWByI/lCramGq/szIuWbT
	 PGBBKeoynrRtg==
Date: Mon, 11 May 2026 09:40:40 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: suravee.suthikulpanit@amd.com, vasant.hegde@amd.com
Cc: Wei Wang <wei.w.wang@hotmail.com>, will@kernel.org, 
	robin.murphy@arm.com, thomas.lendacky@amd.com, aik@amd.com, jgg@nvidia.com, 
	kevin.tian@intel.com, xuyongwei@open-hieco.net, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] iommu/amd: Fix and improve SB IOAPIC IVRS
 validation
Message-ID: <ui2oa3gdlq6v3qfsezadn7rxa7osisjmag7us5ufw2k6mn75gr@mzilog72gwf2>
References: <SI2PR01MB4393DCD4BF7E79CB63066D16DC5DA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SI2PR01MB4393DCD4BF7E79CB63066D16DC5DA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>

Suravee, Vasant, could you please have a look at this series?

Thanks,

	Joerg

On Mon, Apr 06, 2026 at 11:40:06PM +0800, Wei Wang wrote:
> The check_ioapic_information() function validates that the Southbridge
> (SB) IOAPIC is correctly listed in the IVRS table before enabling
> Interrupt Remapping (IR). If validation fails, IR is disabled to avoid
> IOMMU dropping interrupts from unmapped devices.
> 
> This series fixes three independent bugs in that function:
> 
> Patch 1 fixes a logic error where successfully detecting the SB IOAPIC
> resets a 'ret' flag that was previously cleared by an unmapped secondary
> (i.e., non-SB) IOAPIC. This causes IR to stay enabled when it should have
> been disabled, leading to localized device hangs.
> 
> Patch 2 fixes a false positive: the SB IOAPIC was identified solely by
> its devid matching the hardcoded value (00:14.0). If a buggy BIOS assigns
> that devid to a secondary IOAPIC in the IVRS while the real SB IOAPIC gets
> a different mapping, the check passes anyway and IR is left enabled. The
> system timer's interrupts then get dropped by the IOMMU, causing a silent
> boot hang. The fix identifies the SB IOAPIC by its APIC ID (the IOAPIC
> that owns GSI 0) before matching its devid.
> 
> Patch 3 removes the hardcoded SB IOAPIC devid entirely and replaces it
> with a dynamic PCI config‑space check. The SB IOAPIC resides in the FCH
> (Fusion Controller Hub / Southbridge), which typically exposes itself as
> an SMBus controller function. For example:
> 
> AMD Genoa:
> 00:14.0 SMBus: Advanced Micro Devices, Inc. FCH SMBus Controller
> 
> Hygon Gen4:
> 00:0b.0 SMBus: Chengdu Haiguang IC Design Co., Ltd. FCH SMBus Controller
> 
> The PCI class code at a given BDF is a stable, specification-defined
> property. Using it to identify an FCH function avoids maintaining
> per-vendor/per-generation hardcoded device IDs that must be updated for
> new platforms, while producing the same safe fallback (IR disabled) if
> the check ever fails.
> 
> Wei Wang (3):
>   iommu/amd: Prevent SB IOAPIC from overriding IVRS validation errors
>   iommu/amd: Fix false positive in SB IOAPIC IVRS validation
>   iommu/amd: Dynamically verify Southbridge IOAPIC via PCI config space
> 
>  drivers/iommu/amd/init.c | 51 ++++++++++++++++++++++++++++++++++------
>  1 file changed, 44 insertions(+), 7 deletions(-)
> 
> 
> base-commit: 2febe6e6ee6e34c7754eff3c4d81aa7b0dcb7979
> -- 
> 2.51.0
> 
