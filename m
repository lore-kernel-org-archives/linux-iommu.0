Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E663388E55
	for <iommu@lists.linux.dev>; Mon, 10 Aug 2026 07:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786348520; cv=none; b=QF57yozSwXndGHerrKQRD1ZJR7CxDXXppxpJHzINbiZRR13WsQbCoPuoCND3R+L+PaV1gVj4b86dvizWovAGPd4NUrRjGIzBUdwTIjmoOiAWFzrPGm6t/ZaYPsjSVlgEGtYX8z62SAB4ZkfQwISqgmBzvGhJzrNcSWixZEvGCfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786348520; c=relaxed/simple;
	bh=QlYycvLsx0ZaSk5laa9k0o37Fapth3//EHqtZYv35p0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6DWKwtkvlBNt26UdCWlTzUZ4uW0aOECx9SwMCIavusvoCYjn8FUytKandFQWJPg4oqVe2JdbX7KJOua94WkK+hhRhuSAM/AHMBzw5f5ixzNMrYV3Ka7pOMMBU3aTh0hBTr2JBFcO6NvtbKJ4x6cSv+ABnLC8+3+JEWmxO0vWr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 8FCA3206A2E;
	Mon, 10 Aug 2026 09:55:17 +0200 (CEST)
Date: Mon, 10 Aug 2026 09:55:16 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, will@kernel.org, robin.murphy@arm.com, 
	suravee.suthikulpanit@amd.com
Subject: Re: [PATCH 0/5] iommu/amd: PRI related cleanup and fixes
Message-ID: <anmDjtzU643WcHnG@8bytes.org>
References: <20260727053907.7622-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727053907.7622-1-vasant.hegde@amd.com>

On Mon, Jul 27, 2026 at 05:39:02AM +0000, Vasant Hegde wrote:
> Vasant Hegde (5):
>   iommu/amd: Fix incorrect device ID in invalid PASID error message
>   iommu/amd: Introduce PPR_TAG_LAST_PAGE() macro
>   iommu/amd: Fix missing CMD_COMPLETE_PPR response for invalid PPR requests
>   iommu/amd: Rate limit INVALID_PPR_REQUEST error logging
>   iommu/amd: Fix GN bit setting in COMPLETE_PPR_REQUEST command

Does not apply to amd/amd-vi branch, please rebase and send for inclusion into
7.3.
