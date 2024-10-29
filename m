Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5661DE3C5
	for <iommu@lists.linux.dev>; Tue, 29 Oct 2024 10:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730196716; cv=none; b=jFFmSAnFVAGzx6XHKyhp82d2QFrMwRPrgEYSL+BBDTulhdCx+baqoJD6vsJSTfZWKbJnxFFc0XQkLqv6/6GdshASWtXGzzVWd9mQxkgk+qWvq1YyfE2OkPSKNuSb6LP0Vwp6f6kgHKycvBxgnLYRudk2VyR5ZqrrbY2WLhhIqYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730196716; c=relaxed/simple;
	bh=7xq27W6IAfQCS9511E7UfL4JHCgdIYB8nKuYRmQWi0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUsRfno0l9Q3iv6hw1eQjV4qhaoWbzr3+6n9VqZncEAienF8t62oclTizts2IhTsyAf4F0arlTVF/72u5DgHUbMDuoMGI3VPmuOucTYEgLsZcG8kTLBYHYELe6lBlEXQMcpYQ8vdwetrR7AFv++ZqZ603oAfC8aElZFntbzmKIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=yJcj8jHw; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="yJcj8jHw"
Received: from 8bytes.org (p549219d2.dip0.t-ipconnect.de [84.146.25.210])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 763112A8D55;
	Tue, 29 Oct 2024 11:11:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1730196712;
	bh=7xq27W6IAfQCS9511E7UfL4JHCgdIYB8nKuYRmQWi0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yJcj8jHw04ODwp/Enah7xoxWov14mL/0BOM8224O6kl4nBj5IX3af/WZg1L7B0ZmP
	 gMafxaGLttbk7OVxkbEGf5kAiU0Kn8BGu2cTfpt0lFYlwc8QuRKEwDooB7A9IbViwk
	 a7Ws5HqxKeo8eEzFqcUNIkFYOnzSlMtTLAtzU13qNf5D35QAjgAruHtgC8978uCSpo
	 W0QBwLF9cElQ4pZmYEmsHy6ZRfCJth4hpdWymD+i0gxaocAl+74K/sjBIYrZnRbe6v
	 39d76qViDvb4maligPNhu9BVbdR4xzP0fsSGqTVzCGLdbv+y6i5p61KtaMmwUHtrA9
	 pnTYvknb2UtMQ==
Date: Tue, 29 Oct 2024 11:11:51 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, will@kernel.org, robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com, jgg@ziepe.ca, yi.l.liu@intel.com,
	baolu.lu@linux.intel.com, kevin.tian@intel.com,
	jacob.pan@linux.microsoft.com, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v5 12/12] iommu: Create __iommu_alloc_identity_domain()
Message-ID: <ZyC05ycHuceILlye@8bytes.org>
References: <20241028093810.5901-1-vasant.hegde@amd.com>
 <20241028093810.5901-13-vasant.hegde@amd.com>
 <ZyCtLXeZxhNHTPbX@8bytes.org>
 <ad8bc41e-e6cc-4a91-8cef-6aaf06703cdd@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad8bc41e-e6cc-4a91-8cef-6aaf06703cdd@amd.com>

Hi Vasant,

On Tue, Oct 29, 2024 at 03:36:41PM +0530, Vasant Hegde wrote:
> In my base (v6.12-rc3) + this series, iommu_domain_alloc() calls above function.
> 
> Looks like you pull Baolu's series which removed iommu_domain_alloc() [1] as
> well. So now there is no user for above function and hit compilation error.
> 
> [1] https://lore.kernel.org/linux-iommu/ZyClPkzekxXKqTFV@8bytes.org/T/#t

I see, that makes sense. Yes, I pulled in Baolus series as well before
this one.

So I added the removal of the function to this patch as well.

Regards,

	Joerg
