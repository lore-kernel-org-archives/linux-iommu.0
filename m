Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D692D3ED1
	for <iommu@lists.linux.dev>; Fri, 12 Jun 2026 12:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781268947; cv=none; b=bVv33nwJ2yo9GCSeOAhB3Zo/M/217BicUHRJ+s4kbFylZ29F5ID1+YYBOMFcmiT+Y70F13zeqN212AW18VgtJlyvKr2ceSG/17pP1TengJWQoHpTK0Oq0bhuVtuN1DDztECnmoKxtHTD3Xy9ct9g85hOaVzvn4t24GgoXWO/3ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781268947; c=relaxed/simple;
	bh=f3ToUE8wAxskCtF3xHunKFbgfKv6iVXg7sN0mOPejeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1cu26YGI/chxT9L6rDXtImcCiHR+m6YLPDTg1ebhiFdtlalcT0EaoBx95qRtzqmVhIk2ADawGxkIkLuP1K/68fcUV7maF9/zyNNnLg5eIFhBtNiB2KTdCMA2/8K6EPy+dG61yLQMr/dFRTirxJhxYswZ8sExfHUC0Xzo3X2KcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id AFE361C76A7;
	Fri, 12 Jun 2026 14:55:44 +0200 (CEST)
Date: Fri, 12 Jun 2026 14:55:43 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Ankit Soni <Ankit.Soni@amd.com>
Cc: iommu@lists.linux.dev, Vasant Hegde <vasant.hegde@amd.com>, 
	suravee.suthikulpanit@amd.com, will@kernel.org, robin.murphy@arm.com, 
	linux-kernel@vger.kernel.org, jgg@ziepe.ca
Subject: Re: [PATCH v5 0/4] Respect VASIZE for address limits
Message-ID: <aiwBs36PZPtgV93x@8bytes.org>
References: <cover.1776075533.git.Ankit.Soni@amd.com>
 <67ddc0ee-eb21-4bfe-9d12-ceda0005db91@amd.com>
 <bcho2tyxmlns7r46whim7vetpiquaztlvjemko27rgglfmcutw@gsjs4u2tmc7n>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcho2tyxmlns7r46whim7vetpiquaztlvjemko27rgglfmcutw@gsjs4u2tmc7n>

On Fri, Jun 12, 2026 at 08:46:47AM +0000, Ankit Soni wrote:
> Gentle ping on this series.

In IOMMU tree since May 19.
