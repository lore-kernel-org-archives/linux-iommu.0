Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D29F1DFD80
	for <iommu@lists.linux.dev>; Tue, 29 Oct 2024 10:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730196914; cv=none; b=Xy6jYaWCA9yVSKPEmOLwu5/BAVeKjchojJopgO4h1a++ySl27NXSXglMHELmfeBOvXqpWt/wfF+12gSrvN0QZzahK+EfFeQiDLeFNcMqEIuvU6adVq/5eXT4tCn88dtUYm2NQtcD7pAZqYQpNFsLaDL/EDzRbILTmS+2YnGx9DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730196914; c=relaxed/simple;
	bh=ZUOAS+qT35k1FosvY6R4FURr/NKZC8Gv4cWBEpphGAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BgikvgCeh5muEi1oXPFi8snKK7+GefvwcYg7jo+lohK1qYC4riVrKKlWLNl/B0cHA9ipJVvYH09+hpqsLsgvz7MeIZGy1tq2rh8qEokTzux2vu+WpWQPI6XeBmRqkqfWs+1r58cNBaR/t8W1V4BrBVOl95Fe8YjoFnYrEY4tYso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=JhrdWUCQ; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="JhrdWUCQ"
Received: from 8bytes.org (p549219d2.dip0.t-ipconnect.de [84.146.25.210])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id D0D942A8D41;
	Tue, 29 Oct 2024 11:15:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1730196910;
	bh=ZUOAS+qT35k1FosvY6R4FURr/NKZC8Gv4cWBEpphGAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JhrdWUCQVKfLYrVWfqQj5ske6HqQVA+WPQhRcAMUN2rz1lJ1S1ediIy4lXlBJropL
	 mximCOah08laoqsE0tjvoBizqEME7iu+e31iRhFSGwD1JD/53zAc7wx6C9/gov9kMd
	 i/loTtI+qXoA+BWzz2maODHmFSZjo1ZL6vuS+Chy20ViYnt0pzEJWKw8NLdaiil7VK
	 636P/mIV/y3KaDBQf/XZDNSyXkI0YbFqk0Bft0KbUVuZhIR76k0PueeM020HS1LNVV
	 Rjm0zVvcEEB9x6CCtvYzV02djeNkj/bu7HdbY3XlNHO9Xh4OYCmTWXwd4azXx1y3xf
	 zuyP/tyCIcnPQ==
Date: Tue, 29 Oct 2024 11:15:09 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, will@kernel.org, robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com, jgg@ziepe.ca
Subject: Re: [PATCH v4 00/12] iommu/amd: Improve domain allocator and device
 attach code path
Message-ID: <ZyC1rZJrMqYYebRL@8bytes.org>
References: <20241028113148.5774-1-vasant.hegde@amd.com>
 <ZyCni2HHjXqivNwl@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyCni2HHjXqivNwl@8bytes.org>

On Tue, Oct 29, 2024 at 10:14:52AM +0100, Joerg Roedel wrote:
> Applied, thanks.

I have to take that back, this series heavily conflicts with the changes
in the core branch. I think I resolved everything, but it looks pretty
messy.

Can you please rebase this series on-top of the latest core branch (I just
pushed the core branch only) and re-send? Backporters of these changes
will be very grateful.

Thanks,

	Joerg
