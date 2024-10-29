Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FBA7DA82
	for <iommu@lists.linux.dev>; Tue, 29 Oct 2024 09:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730194738; cv=none; b=ENShE5qgdMU5Jzc3PUrIcw8iE/gK5mc6TcWUvTCnVZq+zYtNnO6ndCws8C9SiZVBy6eGZI4IX3FLvw22dRf3f6W18/d49hbYcsqaAwuY4HJ/pa0eP/AVMpJGy2f0bFY+bOmCqsvi4TED4UmtXzZhnbDLCgEttGRooxd3UxRywes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730194738; c=relaxed/simple;
	bh=BZb6fTyjIZAIHtPzoDPItVmjc5lLtdOHZLvrah0OvTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cz4+6O0vElszdYxXcFRWDEpN9DkPB50NdaXu7QXMrq8b3D+CwbmWYvWHLgGYwgj5hhyt1MZcwncQLOd26kdXwFK+UPM18RPcD2QREFJaAhmAdWfpyN51ho2a1tvl4tsUdmqcrYlpRWD5b3jMxay/rHWCGh1WGIcU4ef6D8QU1U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=8k90T9U2; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="8k90T9U2"
Received: from 8bytes.org (p549219d2.dip0.t-ipconnect.de [84.146.25.210])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id C3F192A8D55;
	Tue, 29 Oct 2024 10:38:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1730194734;
	bh=BZb6fTyjIZAIHtPzoDPItVmjc5lLtdOHZLvrah0OvTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=8k90T9U2jRVFB/jqMFAU1lSkjobFEE4xFNUugVOQjDuwBad8C35+N129hS7qCIp4/
	 IK0uNPWaPRN3uT+G16ZmaW+KprzHLqVSJZLRI3ptWH4tnk9MoSPtPSC6jgEMu/xWYU
	 tw0XWMw0ybtMGLHCgJqI4hipimVs81g6str7WWtYj4LeWpmiM5InDBOsQpZKuXfb+I
	 +imG5eLz+Wc5f684o5gcGVlXOn9JrFnmkpk6YoTlP/xyNah6H7d8z+mDPMgJHOUEYI
	 NbFpLJK5ZZF4l5ZCBHa/rnKus/Mfw1RLKBbHZ+zIsQVVHbAPTa7hs/KNJn5VuibwJ6
	 8CwcBFiGZ1n/g==
Date: Tue, 29 Oct 2024 10:38:53 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, will@kernel.org, robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com, jgg@ziepe.ca, yi.l.liu@intel.com,
	baolu.lu@linux.intel.com, kevin.tian@intel.com,
	jacob.pan@linux.microsoft.com, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v5 12/12] iommu: Create __iommu_alloc_identity_domain()
Message-ID: <ZyCtLXeZxhNHTPbX@8bytes.org>
References: <20241028093810.5901-1-vasant.hegde@amd.com>
 <20241028093810.5901-13-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028093810.5901-13-vasant.hegde@amd.com>

On Mon, Oct 28, 2024 at 09:38:10AM +0000, Vasant Hegde wrote:
> Consolidate all the code to create an IDENTITY domain into one
> function. This removes the legacy __iommu_domain_alloc() path from all
> paths, and preps it for final removal.

I get a compile error here because the static __iommu_domain_alloc() is
now unused. Any reason this patch does not remove it?

Regards,

	Joerg
