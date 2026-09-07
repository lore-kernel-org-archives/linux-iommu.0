Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE484B8DF2
	for <iommu@lists.linux.dev>; Mon,  7 Sep 2026 12:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788785434; cv=none; b=iQTfARsPhtp7atfYzNvKW8sHbl1qM6zWoTlxECn/I9JsHdTaUBQLTkhplqAQFSq05/zc4lWfsgydSpQsbFzlXgDfsKFdT1z7wFnULGhCM4q9ipWHmzt7zVZ/f//Wu84dZjeuu2kz3DOtabasG9UwB4YxRW0gR4fMnB8t+g8KIg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788785434; c=relaxed/simple;
	bh=1AB6UHg6tRNeprax3JELxtbaZXhxA89QUDyqZpDplDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qyM1g+jssKMeG7QhTs8y3Uyg3jQ/w93gcvSHuXomqdokMPAkt+hu5KBiUKFFiQH272X+dSUI3oFx2y652Vipaf3Gk6K80L4D3eS/DHD9/BC++kWGsleFG9FZXyklongB1TBFaFSzy6DqCsKuqlPMMmLFXrdKvWa0mo1ehcxXJUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af085a0015db8e28914752a6.dip0.t-ipconnect.de [IPv6:2003:f6:af08:5a00:15db:8e28:9147:52a6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 2565D209F7F;
	Mon,  7 Sep 2026 14:50:31 +0200 (CEST)
Date: Mon, 7 Sep 2026 14:50:30 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, will@kernel.org, robin.murphy@arm.com, 
	suravee.suthikulpanit@amd.com, Andreas Juch <andreas@juch.cc>
Subject: Re: [PATCH rc] iommu/amd: Fix premature break in init_iommu_one()
 again
Message-ID: <ap6zBdVkaPBKGgtK@8bytes.org>
References: <20260824062907.4926-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824062907.4926-1-vasant.hegde@amd.com>

On Mon, Aug 24, 2026 at 06:29:07AM +0000, Vasant Hegde wrote:
> Commit 283d245468a2 ("iommu/amd: Fix premature break in
> init_iommu_one()") unintentionally broke older platforms - such as
> the ASRockRack B550D4-4L - where the BIOS advertises incorrect IOMMU
> features.
> 
> Move the HATDis check ahead of the GASup check, and re-introduce the
> break inside the GASup check to restore correct behavior on affected
> platforms.
> 
> This is a short-term fix to resolve the regression. Longer term, we
> should rework how EFRs are tracked and prioritize the MMIO-advertised
> EFR over the one reported via IVRS. That requires more extensive
> changes and will be addressed separately.
> 
> Fixes: 283d245468a2 ("iommu/amd: Fix premature break in init_iommu_one()")
> Reported-by: Andreas Juch <andreas@juch.cc>
> Closes: https://lore.kernel.org/linux-iommu/07b2d390-f7a0-47e2-bc2c-eb0853acf52e@juch.cc/
> Tested-by: Andreas Juch <andreas@juch.cc>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/init.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Queued for -rc, thanks.
