Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E49537FB
	for <iommu@lists.linux.dev>; Fri, 12 Apr 2024 10:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712916824; cv=none; b=Xt4EomsN4T2QKBzH3DdU+VeCrqTwZB50FymiXVB87nMQcARt/+kP5Pm0+Ob5qQ6YgMB4pMy74rDHpOL+iH2wxWPr5Oyw43rBoUWbNreob/Qz0QP4RdvZHyr4+O0SrGfHAMZNBkJNIJ71T2LUm/h4ku2SbOd2awVpLaaxG7svoSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712916824; c=relaxed/simple;
	bh=+n374FdR57rIZQoNm7OSjRaasxN02aqZSMv2jYZ0hUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fpgdCNZVFAaXPgBpxZlD/D56Cdz1qup5JfH1l9DNRWCog69aZb7RSaRIkzKnPzRdixYWkR8105YnNNWlgqKHI/JUxYCSVVtFEAosMXHZ7ZAU2u91WOsRjDqOkjpfvJDsO6q2OWx0gnYHg4k3Y7F1l6GXwutR0mxdQlK6OqlNdbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=5udpUn9S; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="5udpUn9S"
Received: from 8bytes.org (p4ffe0bdf.dip0.t-ipconnect.de [79.254.11.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id A8897281A38;
	Fri, 12 Apr 2024 12:13:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1712916821;
	bh=+n374FdR57rIZQoNm7OSjRaasxN02aqZSMv2jYZ0hUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=5udpUn9SWpmJK4qyTedten30ay53utOypueFhii2F7VoXMWKO2bTjvy+uvXcxruDs
	 W1SbFiHY3VcSYiKJACrRrYIY55Dta3NX7JFKDrgHsWPlcytoeVxcx201f6VO6ZD7+n
	 Uj0rYV02SvYCKP6HENEuZcHzEgBJARuFKaSj9+dKN2VL3jJg/XRyAZi4KxlkG7rfas
	 hX1n2g1blx5ZO9cJsNfHs2uXzu/jffHhRMWwwZ7ZMg6xaqIVV4u9Yf5UdFSj5Sv9eR
	 rGsBN/zTOobu4GdopA3upWglvpCX1RjG7lms3Ytgv4oGNiUBGUWe4uBESWbrU7Z2a4
	 Ec/rvbGiiasOA==
Date: Fri, 12 Apr 2024 12:13:40 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Yi Liu <yi.l.liu@intel.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, baolu.lu@linux.intel.com,
	alex.williamson@redhat.com, robin.murphy@arm.com,
	eric.auger@redhat.com, nicolinc@nvidia.com, kvm@vger.kernel.org,
	chao.p.peng@linux.intel.com, iommu@lists.linux.dev,
	zhenzhong.duan@intel.com, jacob.jun.pan@intel.com
Subject: Re: [PATCH v2 0/2] Two enhancements to
 iommu_at[de]tach_device_pasid()
Message-ID: <ZhkJVPNqNnGsh_97@8bytes.org>
References: <20240328122958.83332-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328122958.83332-1-yi.l.liu@intel.com>

On Thu, Mar 28, 2024 at 05:29:56AM -0700, Yi Liu wrote:
> Yi Liu (2):
>   iommu: Undo pasid attachment only for the devices that have succeeded
>   iommu: Pass domain to remove_dev_pasid() op
> 
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  9 ++-----
>  drivers/iommu/intel/iommu.c                 | 11 +++-----
>  drivers/iommu/iommu.c                       | 28 ++++++++++++++-------
>  include/linux/iommu.h                       |  3 ++-
>  4 files changed, 26 insertions(+), 25 deletions(-)

Applied, thanks.
