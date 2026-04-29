Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51D9346FA1
	for <iommu@lists.linux.dev>; Wed, 29 Apr 2026 10:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777458990; cv=pass; b=assCZixrHPPylHqt39vQcaJ4lJaplga7FFx6P50eqeWA2OuwfdpzAil3M2UC/mTy5gFGZDynww9EBpNE9gKxzWiRuQAhS07XIOe0yvOtQlDg0JERjyo3NShEWyx7cLnEP5q/zmJdjrwaQk/046hThGbV5i7B7u9YcztdP1/Ycoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777458990; c=relaxed/simple;
	bh=wWsgI55T2IIdII2886fM0Y+D2bDD3d/AayrfFLAVrIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iShSuSlLBUrnfe7VCT4AM4moOLlUuPjv0mDO2sJWTxasfq2DG8EMiII2jNgLv3oquPyJvEHhKLWWptyHxkJ/+G1tkAoBINnhkPyO369UDIACy9Qjx0ekbFHD1J1vpThAFoP2FcWhlySbvdFpHlQimGslzyob55RsMcvs0Gjz7Zc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=T+MYPJcl; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="T+MYPJcl"
ARC-Seal: i=1; a=rsa-sha256; t=1777458968; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=S6Oi1Mhyn7HSEIlQZ9NQ+85YldW92YeyhctFkYS3PpffytOc/8sLu3tr29aehHvNJQTbdTuDI/ZnxBEDviRKULb/2Qh/5lSTlTuMf1sksWN4UcIBl4Jd4rxUkY1R+barhNRu2E8iK3KNTKZ/Z2pIZ4d5/OkvVPDRH+SpPMhxkr8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1777458968; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Xj/9h++E416HVc3sW+ej95YsGS2ZgLD3ML/lfDNu5mw=; 
	b=IILA7pZin3aP6X402//pPOBXAjLFHFCRk9h+dBon5zvUFOcQTyXVIGczlINRmxZuonqXPTHrBacbJKBhR4MYu9gomwBtDtRx8EHdonYr3HQoZ1ur28q8lxNm/rxiGXcYiQjGC1ZT0/rIsz9FdbyS4ma7VNunAzntCB00GZ/hfgw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777458968;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=Xj/9h++E416HVc3sW+ej95YsGS2ZgLD3ML/lfDNu5mw=;
	b=T+MYPJclCboEFY2K75ze4MtY94KGcSs0Ebeb670CPu5Y4If7R5RFZPfLHKoEcvLD
	CUX0ZpNpYQmUi86E94MJeBknmbwTId0QoQEddCUXhC4abLVcq/+hMX2F9x3qxDloMm2
	YBbUKZXfmYErqwF79jT1WoARSFDlyOPqEUzr7fOY=
Received: by mx.zohomail.com with SMTPS id 1777458964961585.9652544116735;
	Wed, 29 Apr 2026 03:36:04 -0700 (PDT)
Date: Wed, 29 Apr 2026 10:35:54 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: hpa@zytor.com, robin.murphy@arm.com, robh@kernel.org,
	wei.liu@kernel.org, mhklinux@outlook.com, muislam@microsoft.com,
	namjain@linux.microsoft.com, magnuskulke@linux.microsoft.com,
	anbelski@linux.microsoft.com, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
	longli@microsoft.com, tglx@kernel.org, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	joro@8bytes.org, will@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, bhelgaas@google.com, arnd@arndb.de
Subject: Re: [PATCH V1 04/13] mshv: Provide a way to get partition id if
 running in a VMM process
Message-ID: <20260429-pristine-unyielding-magpie-1ce6ee@anirudhrb>
References: <20260422023239.1171963-1-mrathor@linux.microsoft.com>
 <20260422023239.1171963-5-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422023239.1171963-5-mrathor@linux.microsoft.com>
X-ZohoMailClient: External

On Tue, Apr 21, 2026 at 07:32:30PM -0700, Mukesh R wrote:
> Many PCI passthru related hypercalls require partition id of the target
> guest. Guests are actually managed by MSHV driver and the partition id
> is only maintained there. Add a field in the partition struct in MSHV
> driver to save the tgid of the VMM process creating the partition,
> and add a function there to retrieve partition id if current process
> is a VMM process.
> 
> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root.h         |  1 +
>  drivers/hv/mshv_root_main.c    | 22 ++++++++++++++++++++++
>  include/asm-generic/mshyperv.h |  5 +++++
>  3 files changed, 28 insertions(+)

Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>

