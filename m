Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D259146A72
	for <iommu@lists.linux.dev>; Thu,  5 Sep 2024 07:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725521656; cv=none; b=ksmgO6MPZBxEyXyT/+wyTLoa4w8J9Z0KXoLeU2JTezx1Z/VJyyecUI5asLn8kClpskDDKRN39MQv83X+8Q4cOlZqvzBoFRRY8DesCPA/hBuwXYJZZsB2j2gs8g8dfpkGTLBNk8qPQ+Tpz1zQRvZa/XIospK2hxBUHbSMNwwYMnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725521656; c=relaxed/simple;
	bh=uT59ImFqQ7Y96gL4d4c3hTv8eaLL9DUqJoKAMu6eqI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+umsMa/hKeeTTRJLipD80DLpLvh+kh1Jr2QP+xxxfCJPStx+fWfB9XdyW8JGYob+AyjXiizHRFlSOiHvYv9snEB34tcGL/cajbLpB5uk6OJAxuqVD+7fcS2hD5APWXNR0wyJpEKFhfmFbf50+P394FkBlAwlXPLp3+508NNaHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=InOrPXga; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="InOrPXga"
Received: from 8bytes.org (p4ffe1f47.dip0.t-ipconnect.de [79.254.31.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 8FAB4288172;
	Thu,  5 Sep 2024 09:34:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1725521653;
	bh=uT59ImFqQ7Y96gL4d4c3hTv8eaLL9DUqJoKAMu6eqI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=InOrPXgaqOYMZ4M+9WDKSXIJ+7PJrmOiDd3Dx6Hs8ChjHklkHFFtGw0LDEqYuN07X
	 HCI1lpN7JmuO+DdForvhgk9AOMPteUWvPFhwMbwGzXqbK1PU57naZ9gfyExGLol+pp
	 OBBpPxKz0iuDyApjYiaFse0CPyrdwWDefqXuYHP3DCrKTUt48q0E0/orEnWrZsC89J
	 wU/5b1bns3MZWV2ACy3UX5LkIb0N8qYdmqzDZ6V3WTQAQ0f6NXGF7i3nqyGo819IY0
	 2ZIq+cwbnLCcf8C60Pa1uFzcw8fzeDyaqpkJkZhudyBr2BQntmI7SNrNbFM5ygy3nK
	 K85r0NuDkw+dw==
Date: Thu, 5 Sep 2024 09:34:07 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>, linux-doc@vger.kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] iommu/amd: Add kernel parameters to limit V1 page-sizes
Message-ID: <Ztle72HfrjBjlJGa@8bytes.org>
References: <20240905072240.253313-1-joro@8bytes.org>
 <45a3ae40-6e59-43b4-ae57-d159bd2b54df@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45a3ae40-6e59-43b4-ae57-d159bd2b54df@linux.intel.com>

On Thu, Sep 05, 2024 at 03:31:08PM +0800, Baolu Lu wrote:
> Is it possible to consolidate these two into a single
> "iommu.nohugepages=1"?

Generally yes, but that requires to touch all drivers to make the
behavior consistent. We can start this effort on-top of this change, if
desired.

Regards,

	Joerg

