Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7C4276D3B
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 09:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740734621; cv=none; b=Kmp3kMVVk90rV73btkIbWBQFwi8+DrPkRyzAV/vXeoItlb2KtSCIn0ALyHhEHBQKG1smdjULti+TI+biMPsAvnGQObev+VI7w6ZDNGHoZW3kU11b5wrSGqGnd+WRJTP8G4yXyjkT1aywskaN9O0NCN4yfe8KtLDKCi086Rlm+nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740734621; c=relaxed/simple;
	bh=Wq1jceTV2eRH+JKb2Wwjxp20n4bN6GJHQFBv3Yj7PKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJCJr+EjIKXQ+3NZGIKmPRiEoL1tpM1mBmFqurBlmrPaS14tsbT3etggEpmjU7Pan8E+lpLSRt65E2Uoo9+CaZqyZkwSsC/CgJX+dtd5KUzeyzXODLQjkjO0R9oGrNIWtuhAgt+AjS7ZD7+uWB47HghtjgEvhm8j2jxMyNtL7Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=yzVpySXK; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="yzVpySXK"
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 644F043FBE;
	Fri, 28 Feb 2025 10:23:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1740734612;
	bh=Wq1jceTV2eRH+JKb2Wwjxp20n4bN6GJHQFBv3Yj7PKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yzVpySXKfW9QnEE8oQ++ZQo0bf5bKucyfwceArrzEtI/RWlrfDvYj53xFCVzF08L+
	 UXRPIZvT+VPzo4A32FKusNktvfQevcObR9vQblgmqyr16kwztyhYqNhUSZkYN7oLAR
	 vY21FDPh+6cLwk9c3jsEmuHEfoXgLJFqJoB3rFBd3JTIf3MqFLOce3xuxe4AKT5Xo0
	 1mIBoaG6ZIK/pD8gaWhCwWVrBcgsinhx0CQ5esF5ET8axE98rKdBHHPlFTjVENtpWb
	 l3q3Go1vhG9AD06vN5+JfHxWcv1s/IO9Z6+yMlZgscIUUtTV/oeLkOMj4VoF6TCm5i
	 GNrPV6/awMMdw==
Date: Fri, 28 Feb 2025 10:23:31 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Yi Liu <yi.l.liu@intel.com>, kevin.tian@intel.com,
	baolu.lu@linux.intel.com, iommu@lists.linux.dev,
	robin.murphy@arm.com, nicolinc@nvidia.com, will@kernel.org
Subject: Re: [PATCH v2 0/4] Misc iommu_attach_handle enhancements in iommu
 core
Message-ID: <Z8GAk9LbU431zBNv@8bytes.org>
References: <20250221143335.49874-1-yi.l.liu@intel.com>
 <20250225001317.GI520155@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225001317.GI520155@nvidia.com>

On Mon, Feb 24, 2025 at 08:13:17PM -0400, Jason Gunthorpe wrote:
> Joerg, this also needs some of the iommufd patches on my tree, I can
> pick it up and send you a PR with this and the MSI stuff. OK?

Sounds good. V3 seems to be posted now.

Regards,

	Joerg
