Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3E6142E7C
	for <iommu@lists.linux.dev>; Tue, 27 Aug 2024 07:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724742482; cv=none; b=K3ZdpH6i/dZJYQ3oNw5VcR4PWCtVCaqa//X+eLkr/1LZL5YcdvqPADh0oDerBIj+DypbziD0qfg8wIxw4Tw70apwQdBECNyJ/U12gZFqPUQxqf+lQHwHHPxttCVRxLxbaVlZDCfov6GoiH3IKtalQlBdrsCIu12/4pGOjrpR4Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724742482; c=relaxed/simple;
	bh=v3oMDBXISh7mOqH4SIKSXdEp5TdADu27D9kqCT3a+yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sCrJ7UT/zTYAgWAckY5tgFWbym+fGRyGaxFLST9xeibuJZwQhtvJjYofyIyTFEe7KRFUHOCDU0JdNjn4AVRxYfsF6uh6ZeYtKZT2BzLNT4CSGuMSUefGZQjjmQ+zIyXgLLxGXzn2gV2YfoeCmkJUyfUJJPZH59WW1Blylq8mhfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=2FQcnv+v; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="2FQcnv+v"
Received: from 8bytes.org (pd9fe9dd8.dip0.t-ipconnect.de [217.254.157.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id A85CB2842E6;
	Tue, 27 Aug 2024 09:07:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1724742478;
	bh=v3oMDBXISh7mOqH4SIKSXdEp5TdADu27D9kqCT3a+yg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2FQcnv+vR+F+r2tu2zzJ/FaLSxMX8Wrtm3XL2y1wAGjMG8UTNu2seNZBkulvBY2yL
	 4xcvNjWUpk0D3fark/ti4n7SW7hc5YUtifl2pnLxWjtJuo2o/tP8i5zPLaF4iNV4H9
	 kAb9HI+g28PuA/vGNf79jYK+2CVaSEcyCK5piZUOUQ7PfBYNcp8cxorew2YYASzO9h
	 zLDG8XZ2pt3ugMpJMAAqeeJeC4g9qZs+DCY599ENEoNj6VxAzKQEtwVTStJzPyDeoc
	 IGOFASzwVoJE4Bs858UEGdketXr02agbnltPyF3IqJXJFBEpNpo9n32g9i7VEQxnB6
	 RBxcOzTwb8KVA==
Date: Tue, 27 Aug 2024 09:07:57 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jerry Snitselaar <jsnitsel@redhat.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix incorrect domain ID in context flush
 helper
Message-ID: <Zs17TSaW-GW7DYj4@8bytes.org>
References: <20240815124857.70038-1-baolu.lu@linux.intel.com>
 <2h2gyzr3anhcpyiorkrjp3o4cdg7sg2rmrvgzmkxopabdsr3ph@jlhq77xjtcdf>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2h2gyzr3anhcpyiorkrjp3o4cdg7sg2rmrvgzmkxopabdsr3ph@jlhq77xjtcdf>

On Mon, Aug 26, 2024 at 09:15:06AM -0700, Jerry Snitselaar wrote:
> Can this go into a fixes pr for 6.11?

It is already queued for 6.11, will send the PR in the next days.
