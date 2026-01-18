Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF302DB783
	for <iommu@lists.linux.dev>; Sun, 18 Jan 2026 09:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768730224; cv=none; b=bn687dUGv2qlY3TASYCIU8ZOrzVw4ui3nffbLxc7FLvCUHw0gTaf9+HSdhgpclEsXxjMScme9/miXLw5jJi3ZfPCSltVCTqsseu7bL9DTxUFlScPVCpxAxallNng+OESWcKRGs8j5YZE+9nlKhGvmQeL/8PmbOgPKGCy2xEcicw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768730224; c=relaxed/simple;
	bh=NMp1qt6UbE+ghhzKetlXkA50OSaRDWTjBpEgwKY6G6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UVB25H3ozVQaLdJno2Yi5ykc9sSzKlqeWQSUoVO1v+T/1hNbFqlDH98u/YWFhVDjTKr6upG7Q3H5yMXqh/Qke84jqpFA0NnMtoaDJlO5IIxjinYHpV2RVwAWShOzGT15r3zGgmeVtnQ1TTgUkBfSc5iT3F5k/jEry3QtEsbnHXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=RvMqRZel; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="RvMqRZel"
Received: from 8bytes.org (p200300f6af1d960047d77347aeef488f.dip0.t-ipconnect.de [IPv6:2003:f6:af1d:9600:47d7:7347:aeef:488f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id D59095C16D;
	Sun, 18 Jan 2026 10:56:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1768730213;
	bh=NMp1qt6UbE+ghhzKetlXkA50OSaRDWTjBpEgwKY6G6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RvMqRZelX+mCXlRAp2TjYjonPb/aGvFUFQ6LoJgmjt7XQFbV6M3Br5fhUCL9kke+Z
	 otLfVfnhjT28lpN8C0K7JtR0TUfB3lv10Ga7dm7mRhATFZ7Wm7rGMF+y5Dt25R68F0
	 0vpYhpy1yzpx3c2P39CcEzIrKYD895y8sjiRQ2TsQxMsGrYTNcVnBMruDiTabtWHoU
	 UyEwQ5SXPIwi4vZjiA3dfctEP7/0SAyyzJMLGiDBgKCjnOA8KCCM24544bV3lip+fJ
	 CPOoe7hsQEjd5JQIG4oZGrG+seWY/IiUHz5sg2RrjJzQ7GTvLPCC2Z8qj9OtdHiSXb
	 TSNjZQLzb3qqg==
Date: Sun, 18 Jan 2026 10:56:51 +0100
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: jgg@nvidia.com, nicolinc@nvidia.com, linux-kernel@vger.kernel.org, 
	robin.murphy@arm.com, will@kernel.org, kevin.tian@intel.com, jsnitsel@redhat.com, 
	vasant.hegde@amd.com, iommu@lists.linux.dev, santosh.shukla@amd.com, 
	sairaj.arunkodilkar@amd.com, jon.grimm@amd.com, prashanthpra@google.com, wvw@google.com, 
	wnliu@google.com, gptran@google.com, kpsingh@google.com, joao.m.martins@oracle.com, 
	alejandro.j.jimenez@oracle.com
Subject: Re: [PATCH v6 00/13] iommu/amd: Introduce Nested Translation support
Message-ID: <awtsil6exdtraqchd4qbe7ka6aely6bfs5v5ksqkv7i625dgf3@nwalhlk7g46t>
References: <20260115060814.10692-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115060814.10692-1-suravee.suthikulpanit@amd.com>

On Thu, Jan 15, 2026 at 06:08:01AM +0000, Suravee Suthikulpanit wrote:
> Suravee Suthikulpanit (13):
>   iommu/amd: Add support for hw_info for iommu capability query
>   iommu/amd: Rename DEV_DOMID_MASK to DTE_DOMID_MASK
>   iommu/amd: Make amd_iommu_make_clear_dte() non-static inline
>   iommu/amd: Introduce helper function amd_iommu_update_dte()
>   iommufd: Introduce data struct for AMD nested domain allocation
>   iommu/amd: Always enable GCR3TRPMode when supported.
>   iommu/amd: Add support for nest parent domain allocation
>   iommu/amd: Introduce struct amd_iommu_viommu
>   iommu/amd: Add support for nested domain allocation
>   iommu/amd: Introduce gDomID-to-hDomID Mapping and handle parent domain
>     invalidation
>   iommu/amd: Refactor persistent DTE bits programming into
>     amd_iommu_make_clear_dte()
>   iommu/amd: Refactor logic to program the host page table in DTE
>   iommu/amd: Add support for nested domain attach/detach

Applied, thanks Suravee.
