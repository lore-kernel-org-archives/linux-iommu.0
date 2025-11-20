Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A865284B25
	for <iommu@lists.linux.dev>; Thu, 20 Nov 2025 10:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763634822; cv=none; b=dDFiH5CSAzHFH9rN5vOvKrL4+Lg1JF2m4V4jpyW3+lHVRZsxpanavEyeSY3mKY/BjzQkXVQcRAaCijztU76AKW2PNA0EW0Rx285vqJDUoTWmqe08tMhR1tlRyb1mHAuXFVIexYlMsiXIjCqC2vp2b1aORGtVtd+ecrMRuVutbVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763634822; c=relaxed/simple;
	bh=AjdaPxI6DEG5+1vMsB/JPo1TIa0f6QgVT+d3jCjWQ7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/B0LHPWqBODmwgfzf/HoRPP1MWqpWRKrWtqugSTuhQ4OYiGumuQczNa7W9gZt2JCKSouAvycAY8ltPiMCNfAXR7gGzar0/CT2kLqzSug52f3kESXjEasgc4Yxqzeiq4w0upjt6f4lq4Ix68t/UtKuBEoLNrHKSIV4Wo0vfuRsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=Xz9a+ZyU; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="Xz9a+ZyU"
Received: from 8bytes.org (p549214ac.dip0.t-ipconnect.de [84.146.20.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 2CD1C5BB50;
	Thu, 20 Nov 2025 11:33:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1763634819;
	bh=AjdaPxI6DEG5+1vMsB/JPo1TIa0f6QgVT+d3jCjWQ7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xz9a+ZyUQV+pslaVD0DmrkL+v/tpgTnj7+m7SLHgZsbJQAw2lY/1ycJzFrEBuNGeq
	 cj9C8EzzXYPbvC+OA6hzIHxZQGCcveb82OfOITkLopPdY0eQ/z7F4PbB9cLuH3Azrz
	 iQZmjS1vnaNe/vMOIw983sJmvUFKSVwvjVR4s6F4UKvxoY66e59IkBQqXnPjHi1txP
	 65/0Hg2ov60GA6GZaov2e7+utviAG8lKcKnJLnysCnbAb+GyBqdxjSXNDWJ/9Q1S19
	 5W1YEbtqcqSIOs95MVFpqXCSsvM1JxCscsqck4+GgP47KP4+tEMky4KtVHLhNuVRmx
	 H49lZAYJYGvhg==
Date: Thu, 20 Nov 2025 11:33:37 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] [PULL REQUEST] Intel IOMMU updates for v6.19
Message-ID: <u2z3cx3kzfxpmlyn5t4ayreqacnhbwu5sdwkaut4oyfxmipoux@otixjk6iv542>
References: <20251119051613.2604261-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119051613.2604261-1-baolu.lu@linux.intel.com>

On Wed, Nov 19, 2025 at 01:16:11PM +0800, Lu Baolu wrote:
> Hi Joerg,
> 
> The following changes have been queued for v6.19-rc1. They are about two
> small and non-critical fixes, including:
> 
>  - Use right invalidation hint in qi_desc_iotlb()
>  - Reduce the scope of INTEL_IOMMU_FLOPPY_WA
> 
> These patches are based on v6.18-rc6. Please consider them for the
> iommu/vt-d branch.
> 
> Best regards,
> baolu
> 
> Aashish Sharma (1):
>   iommu/vt-d: Fix unused invalidation hint in qi_desc_iotlb
> 
> Vineeth Pillai (Google) (1):
>   iommu/vt-d: Set INTEL_IOMMU_FLOPPY_WA depend on BLK_DEV_FD
> 
>  drivers/iommu/intel/Kconfig | 2 +-
>  drivers/iommu/intel/iommu.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied, thanks Baolu.
