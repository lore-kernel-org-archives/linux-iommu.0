Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D58B221DA9
	for <iommu@lists.linux.dev>; Mon, 10 Feb 2025 13:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739195488; cv=none; b=Xt9PO2d3Wkedp+XLbJH0BM+HiVewy5L32wCq5qZYhWvvcx4JNewxS9CVusiwSIA9n2hfxuWOIVT7w4a4c58JyhI4emEQycaqf9viOwBYC373MYIw3/NPmCTbgQibk4UmdpSaJCH0xiywjI/I0rWzCFdKiSq1pounOwi1YVK5VXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739195488; c=relaxed/simple;
	bh=rcIs9Ok2vdR0UYl+6SIjCA50EvzA2dPg8nKEpYn/h5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7pSLa9hphSKmqkMOIl7OnmDZ2aJCJ0hM94LDawx65hRLnFPiOABos+vnvzG8FeGd02fUYuYJBkLE2OkdsreJtNXSxIzo4FmVOdeDxcQEk2Kr8uwQMQ60KdEzS6rU9tzNVEYFf0R4qBt+BkW+EVpyMZN5gIPtdDhpjWSTw1i8RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=bwzc8zHk; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="bwzc8zHk"
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 01BB141FE1;
	Mon, 10 Feb 2025 14:51:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1739195486;
	bh=rcIs9Ok2vdR0UYl+6SIjCA50EvzA2dPg8nKEpYn/h5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bwzc8zHk9ZFq13Un1qHdmmevejw9rm22D/mAVNITCmBzsrmmdEAYbksgzfNJ2eQ/c
	 ITOvH4GB9ZRg7OrsUtRkQtiRFj9z2/1a7JQ9lcyDmvGI03n1MFCl8suJTOpwLct8SF
	 qB3YazOvAvH7g9v0dBm8RIM6cBAcqNdZVnl4A7tyJYfIjE1rnpOa826/cq2/7fRuYI
	 FwcF1acza2OUxXQH2c+ZaHydBFF9+YgRxesXbUSoIDliRSqjgqSzkHdTbQC7xdMlND
	 +F0LfegSWoAKe0Td58n4DvWVTP7f3i24AGkeR6bZS91gL/oNi4X2kZDAMufa/KlKsl
	 4PhjmvAhbUISQ==
Date: Mon, 10 Feb 2025 14:51:24 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, suravee.suthikulpanit@amd.com,
	Hamish McIntyre-Bhatty <kernel-bugzilla@regd.hamishmb.com>
Subject: Re: [PATCH] iommu/amd: Expicitly enable CNTRL.EPHEn bit in resume
 path
Message-ID: <Z6oEXFIm7P78GTQg@8bytes.org>
References: <20250127094411.5931-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250127094411.5931-1-vasant.hegde@amd.com>

Applied, thanks Vasant.
