Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FC63C871C
	for <iommu@lists.linux.dev>; Tue, 17 Mar 2026 13:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773752457; cv=none; b=WqIc/qudA3x3POd0EVkJkKTdUuQft000nnn/BWp26Al0LL86BVpqmaR50b3oQ0lT/gMlzXzSMjMVsLJunwTo8E4KAxS4zLPDeEQer878Z1gnh9OWe6oR4qRHZ3LPuabX6g2G2sUwIBF1Vzeo3VQn7DY6NhmoTK2k+MSCGk+awaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773752457; c=relaxed/simple;
	bh=gmLfR916njLdHZWb2MsU/SveLye432mqPSq18AqLBrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fs4RUNOxYbiyAP5kr0kJV2/T72+Dvz1M34l86pTLTcEzOfsOYmhM/o/r4PguZom2kcptFeaOOo7+WuBxMPoMYdcGx3tcCt2sLXQ/tmH7B/g7NsA0WMmX3yxwttnc/NcWray5PT9cfGt2xTH/NJB81xn3hnVySxF/PTR5g+IgTp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=g9VlyfZT; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="g9VlyfZT"
Received: from 8bytes.org (p4ffe051a.dip0.t-ipconnect.de [79.254.5.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 7849B1A52C5;
	Tue, 17 Mar 2026 14:00:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1773752454;
	bh=gmLfR916njLdHZWb2MsU/SveLye432mqPSq18AqLBrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g9VlyfZTiIfxauOzILouemyXWgfBSM4tTh1EeZOAYQ5TlDHfIu+AWRv6HRRUjrS4N
	 0S8P6WEkHuOESVbRlNJMaqTXl2LE2UgfgtddbuEmkk30JEmVNgYQ8yN5puvT5nm3ui
	 tFS6k0m5yWDUVoLota2Pv3YqlZmcwZAaKhbHPrSB4Vh2eDMmEN20V9Ry0JY5l4rSPC
	 9qXVEMngXNEyZA80peUlUZ0Irv/qINTFx4QiXQ4wJXefw+g5gK2NphIe03o2+/OnNm
	 8aTDxXwCiEikpnoMIChSy7rw67Aam2bh/3ZVVZfzhXktIep+p3Alc1wdv4Lhd4WxQQ
	 B0pIcUUUFLcFQ==
Date: Tue, 17 Mar 2026 14:00:53 +0100
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Lizhi Hou <lizhi.hou@amd.com>
Cc: will@kernel.org, robin.murphy@arm.com, yi.l.liu@intel.com, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, baolu.lu@linux.intel.com, 
	vasant.hegde@amd.com
Subject: Re: [PATCH V2] iommu/sva: Fix crash in iommu_sva_unbind_device()
Message-ID: <y4nrr7o5tudkgi3v4swx36l7f4gwejhguz2slhlj6yxctxnwhk@p7q73t56i6ee>
References: <20260305061842.3953885-1-lizhi.hou@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305061842.3953885-1-lizhi.hou@amd.com>

On Wed, Mar 04, 2026 at 10:18:42PM -0800, Lizhi Hou wrote:
> domain->mm->iommu_mm can be freed by iommu_domain_free():
>   iommu_domain_free()
>     mmdrop()
>       __mmdrop()
>         mm_pasid_drop()
> After iommu_domain_free() returns, accessing domain->mm->iommu_mm may
> dereference a freed mm structure, leading to a crash.
> 
> Fix this by moving the code that accesses domain->mm->iommu_mm to before
> the call to iommu_domain_free().
> 
> Fixes: e37d5a2d60a3 ("iommu/sva: invalidate stale IOTLB entries for kernel address space")
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> ---
>  drivers/iommu/iommu-sva.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Applied, thanks.
