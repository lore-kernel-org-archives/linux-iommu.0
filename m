Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF3720300
	for <iommu@lists.linux.dev>; Fri,  9 Feb 2024 10:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707475278; cv=none; b=f0jmsNBWrbpsOvfGlj4k+RLLUFBHN1oeQDu5HnkeWr5zzi/HsuFkvLeN5rESPf6joex0hp9gIBfjbY4xg8HTIYFgP7El9tSr5QJIW6ECzCCGDESzbbKF0RAXlkUa+owdLEBNXBADs4bx7OzpMGvPYtafvs1oUfAEgI11AfWlzsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707475278; c=relaxed/simple;
	bh=d6gy8/NjZ1kcUPe4dpkCQWwxyDVy1kGqH89S5RsS4dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GTK0lPyuFglAku+QrfH9R3TZN3XfSni/NGpAnAfSZ8GDyjzyFCf2ifR99Z+9brHRxa1sNhmCtq+GtAFjMHIVm+PJQzos9rGaIV6ovPFt+H+aIgps2Z8n09fd5uBUPbp9u+7W98t+LiRxx4sZ1omraUGEqLmG3fyk7N+Ws+q3gVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=mLSWLPm1; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="mLSWLPm1"
Received: from 8bytes.org (p4ffe0c3c.dip0.t-ipconnect.de [79.254.12.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id CCB7F1C1CED;
	Fri,  9 Feb 2024 11:41:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1707475274;
	bh=d6gy8/NjZ1kcUPe4dpkCQWwxyDVy1kGqH89S5RsS4dc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mLSWLPm1A1+eZVUF4SZSlMeSMLNBuKCyDTm8I47PyepUWfokeAsgMZqSvmO9fMyEM
	 936HI67FZqiET2ghorip64HJfI8gS7vk19OHI3DIJkw9UZSCPvTPiE4An+a++XkrcN
	 k2Q1ExxhPE/fePbnR90VlQRU1pkTelXApDqOG4AjtgQhIflJP1icTQmk1/SP4ssZME
	 a6K/4D4PPNqTdsJPpftJwC9fMp6jQte0XdeSyJK2097Iy+m4Y/FIwxhabdVeYvc0dp
	 tq0ukdmgq4VWet5QU7AUXkFMEeOAvmHNBUlPvR8osonvN7XypOmyk73nR9EzXwdXCz
	 3TcnZYnpCKw1g==
Date: Fri, 9 Feb 2024 11:41:13 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH 0/6] iommu/amd: Misc cleanup
Message-ID: <ZcYBSVs9yxESPzbx@8bytes.org>
References: <20240118090105.5864-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118090105.5864-1-vasant.hegde@amd.com>

On Thu, Jan 18, 2024 at 09:00:59AM +0000, Vasant Hegde wrote:
> Vasant Hegde (6):
>   iommu/amd: Remove unused PPR_* macros
>   iommu/amd: Remove unused IOVA_* macro
>   iommu/amd: Remove unused APERTURE_* macros
>   iommu/amd: Remove duplicate function declarations from amd_iommu.h
>   iommu/amd: Remove redundant error check in amd_iommu_probe_device()
>   iommu/amd: Remove EXPORT_SYMBOL for perf counter related functions
> 
>  drivers/iommu/amd/amd_iommu.h       | 13 -------------
>  drivers/iommu/amd/amd_iommu_types.h |  7 -------
>  drivers/iommu/amd/init.c            |  3 ---
>  drivers/iommu/amd/iommu.c           |  7 +------
>  4 files changed, 1 insertion(+), 29 deletions(-)

Applied, thanks.
