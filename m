Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E736A1D86E0
	for <iommu@lists.linux.dev>; Fri, 13 Sep 2024 10:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726224778; cv=none; b=HGfsfLPO5o3k5WLum0Zs63IiNZdWaClMokWbPvjBmx4z0BMzNmOaf1vRfYkkq2n3RwW0eh5P154iiO2zd1GWGAuvRJ3/1P8fQst3W/Xk2UtcAqFDSHq6yPnTKhiuxvfxjHFanFH8swPXUO6yeUQKkbWwplcAV+8omPtTH21oTDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726224778; c=relaxed/simple;
	bh=8nuPxD0KMZzStq3Vcl57U2imZIhTNkGHKt5jWJmv3Zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cdX5dnXnYXMDsM9ISU2PNQWJ2Nw6k2SICRiocyJ653OyW5e2ReoYtj2D6MIGFj7c83HjFX4ITuFYvNhZKbNYwpG2HdN3YSZEWxKgphZuBBb2iD7vx5m1SYL8IwXv8nIrjFhgrRvZr1AHIwZinjUB+3ls4i4OK2kMENAcTSj7kQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=u3WHqgty; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="u3WHqgty"
Received: from 8bytes.org (p4ffe1f47.dip0.t-ipconnect.de [79.254.31.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 53D9C289CFD;
	Fri, 13 Sep 2024 12:52:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1726224767;
	bh=8nuPxD0KMZzStq3Vcl57U2imZIhTNkGHKt5jWJmv3Zs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u3WHqgtygjKZ5l1QGvnZPiGQzZ8Fkf8cj9Teckcla7xmY0CFM2iO3+uKcUKLFovaw
	 sA5SmP6gNbWmlYPa3U5yQQsH+KFLW/illd10SwyVx4uwo4hcDh+ObkBSPqSqG8nVTv
	 rOmJ9/sI+Z3rsykikd4lMWPGCaycBSNUetLNBrTaC9c+QlPYz+at2GG0vvs10KzCHn
	 XTmrRFtb3pOtop1+LHWW0eYVYBzWiRcYOY44sF4/qyqU1I3+3WwYkQtc2CtjPboMWY
	 HutfyIkgJt+DOFhJX3Mo2TD6YZun09NS5jQ7HI4uv0Qd7a4NE8ym4ljrdsLDTe1pbT
	 bbt/CdUV4LPbg==
Date: Fri, 13 Sep 2024 12:52:45 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	kernel-team@android.com
Subject: Re: [GIT PULL] iommu/arm-smmu: Updates for 6.12
Message-ID: <ZuQZfaa3BldIgc-Q@8bytes.org>
References: <20240912125934.GA23244@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912125934.GA23244@willie-the-truck>

Hi Will,

On Thu, Sep 12, 2024 at 01:59:35PM +0100, Will Deacon wrote:
> Please pull these Arm SMMU updates for v6.12. The big new feature is
> support for NVIDIA's virtual command queue implementation for SMMUv3,
> but everything is summarised in the tag.
> 
> ** Please note **: I've already pushed this to the arm/smmu branch for
> -next coverage, but I thought sending a pull request was still useful
> for the records and the signed tag. If you want to recreate the branch,
> please feel free.

To cite "git-pull":

	Already up to date.

So everything already there, will re-create next and prepare the pull
request for Monday.

> See you at LPC!

Yeah, see you next week!

Regards,

	Joerg
