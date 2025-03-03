Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F76826138F
	for <iommu@lists.linux.dev>; Tue,  4 Mar 2025 18:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741112213; cv=fail; b=Zvkfwhr2s/Nja9EaVxLY6Ty1uxbagLsZ987IqY+r8qF+F8ezBX1hMclYp9O1QY5Vpcd+htoSOyopibBb8NlaIZATjYKjBVyXT7JzgkiT1Weo3PwIKsB+JQoCwbovQ1+HhfaYHwaC4gaEWYnGx4vG+9Weie6u/mDbZXSKH1W/zWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741112213; c=relaxed/simple;
	bh=PbmkdxNK4rfRsO/a5Auh8nBXee9TNXFVKmEj4GWjfNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qePGhAzbUTjAYugB6HkA3Jpj2U0cOnZSWMmOsW52HU0g7C1dfWr+muA0PiknBBwl529YKV3KXTigyxCmjQAI80eN/+E7TSWChc+11zw70FHcLtuGa0h73apRNPzOxm8ozZvyjhqcWA+ebze9QbijDfJne1JhBcGTMKk73KMstd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=cc.itu.edu.tr; arc=none smtp.client-ip=217.140.110.172; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=fail smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (unknown [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id B8CAC40D51F2
	for <iommu@lists.linux.dev>; Tue,  4 Mar 2025 21:16:50 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dbb4R9MzFx4Y
	for <iommu@lists.linux.dev>; Tue,  4 Mar 2025 17:38:51 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 209B2400C6; Tue,  4 Mar 2025 17:38:50 +0300 (+03)
X-Envelope-From: <linux-kernel+bounces-541285-bozkiru=itu.edu.tr@vger.kernel.org>
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 25953420BE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:41:07 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw2.itu.edu.tr (Postfix) with SMTP id AF9312DCE5
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:41:06 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 755A83B1EEB
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 09:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FE01F1501;
	Mon,  3 Mar 2025 09:40:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECFE1F0E2F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 09:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740994851; cv=none; b=BHYq1VJfmR+xMHkskVWzZq1deJsIIiL4N2h6s59S0RUHKVHFjajs0y6GBggJeDMDyK4hz4pOibRgmj9EjSPVYBfeEyHttjHEtxodgbHqLXPy2ZSEWMvY98F9WInMzvbmyIuy3WfSNOKcbzT5dw/dXTQ2V4OgeovyrmOMkZkCrIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740994851; c=relaxed/simple;
	bh=xJHjaRKydhZZ7SiqrNhR8fRWLsb8uvJalNw0Vd/ti9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqDwsKu4N0v6zmVXf2jRGjKPBDKEffsXuqtzwNQFBfJY65vsrD7mjBzZAoSvx3FZVTMhdzMzT5ad0/lg5SvSjQ1nUQIHEGsuU8PgtzWbT02Aslj3RRWavOLfIUCZdax/gNlE3vROsybzgznjhtbe+aR1Nl1ha97HpDWkbLrm4rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE35F113E;
	Mon,  3 Mar 2025 01:41:02 -0800 (PST)
Received: from e133081.arm.com (unknown [10.57.37.136])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 822EA3F66E;
	Mon,  3 Mar 2025 01:40:45 -0800 (PST)
Date: Mon, 3 Mar 2025 09:40:34 +0000
From: =?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: ryan.roberts@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com,
	will@kernel.org, joro@8bytes.org, jean-philippe@linaro.org,
	mark.rutland@arm.com, joey.gouly@arm.com, oliver.upton@linux.dev,
	james.morse@arm.com, broonie@kernel.org, maz@kernel.org,
	david@redhat.com, akpm@linux-foundation.org, jgg@ziepe.ca,
	nicolinc@nvidia.com, mshavit@google.com, jsnitsel@redhat.com,
	smostafa@google.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH v2 1/4] arm64: Add BBM Level 2 cpu feature
Message-ID: <20250303094022.GA13345@e133081.arm.com>
References: <20250228182403.6269-2-miko.lenczewski@arm.com>
 <20250228182403.6269-3-miko.lenczewski@arm.com>
 <c572a93f-0899-4fc7-9764-d3e76e9fe6d1@os.amperecomputing.com>
 <223a817b-66dd-4182-838f-a186b059fe41@os.amperecomputing.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <223a817b-66dd-4182-838f-a186b059fe41@os.amperecomputing.com>
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dbb4R9MzFx4Y
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741716916.84755@n4VekbD75wsLTNxOs5Y3pQ
X-ITU-MailScanner-SpamCheck: not spam
Message-ID: <20250303094034.6HCrStNWudB002TgFl5TrN1wvTrHvgpL6ZQ386CWigc@z>

On Fri, Feb 28, 2025 at 06:45:38PM -0800, Yang Shi wrote:
>=20
>=20
>=20
> On 2/28/25 5:29 PM, Yang Shi wrote:
> >=20
> >=20
> >=20
> > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > index 940343beb3d4..baae6d458996 100644
> > > --- a/arch/arm64/Kconfig
> > > +++ b/arch/arm64/Kconfig
> > > @@ -2057,6 +2057,17 @@ config ARM64_TLB_RANGE
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The feature introduces n=
ew assembly instructions, and they were
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 support when binutils >=3D=
 2.30.
> > > =C2=A0 +config ARM64_ENABLE_BBML2_NOABORT
> > > +=C2=A0=C2=A0=C2=A0 bool "Enable support for Break-Before-Make Leve=
l 2 detection
> > > and usage"
> > > +=C2=A0=C2=A0=C2=A0 default y
> > > +=C2=A0=C2=A0=C2=A0 help
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FEAT_BBM provides detection of supp=
ort levels for
> > > break-before-make
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sequences. If BBM level 2 is suppor=
ted, some TLB maintenance
> > > requirements
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 can be relaxed to improve performan=
ce. We additonally require the
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 property that the implementation ca=
nnot ever raise TLB
> > > Conflict Aborts.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Selecting N causes the kernel to fa=
llback to BBM level 0
> > > behaviour
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 even if the system supports BBM lev=
el 2.
> > > +
> > > =C2=A0 endmenu # "ARMv8.4 architectural features"
> > > =C2=A0 =C2=A0 menu "ARMv8.5 architectural features"
> > > diff --git a/arch/arm64/include/asm/cpucaps.h
> > > b/arch/arm64/include/asm/cpucaps.h
> > > index 0b5ca6e0eb09..2d6db33d4e45 100644
> > > --- a/arch/arm64/include/asm/cpucaps.h
> > > +++ b/arch/arm64/include/asm/cpucaps.h
> > > @@ -23,6 +23,8 @@ cpucap_is_possible(const unsigned int cap)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return IS_EN=
ABLED(CONFIG_ARM64_PAN);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case ARM64_HAS_EPAN:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return IS_EN=
ABLED(CONFIG_ARM64_EPAN);
> > > +=C2=A0=C2=A0=C2=A0 case ARM64_HAS_BBML2_NOABORT:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return IS_ENABLED(CONFI=
G_ARM64_BBML2_NOABORT);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case ARM64_SVE:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return IS_EN=
ABLED(CONFIG_ARM64_SVE);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case ARM64_SME:
> > > diff --git a/arch/arm64/include/asm/cpufeature.h
> > > b/arch/arm64/include/asm/cpufeature.h
> > > index e0e4478f5fb5..108ef3fbbc00 100644
> > > --- a/arch/arm64/include/asm/cpufeature.h
> > > +++ b/arch/arm64/include/asm/cpufeature.h
> > > @@ -866,6 +866,11 @@ static __always_inline bool
> > > system_supports_mpam_hcr(void)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return alternative_has_cap_unlikely(=
ARM64_MPAM_HCR);
> > > =C2=A0 }
> > > =C2=A0 +static inline bool system_supports_bbml2_noabort(void)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0 return alternative_has_cap_unlikely(ARM64_HAS_B=
BML2_NOABORT);
> > > +}
> >=20
> > Hi Miko,
> >=20
> > I added AmpereOne mdir on top of this patch. I can see BBML2 feature =
is
> > detected via dmesg. But system_supports_bbml2_noabort() returns false=
