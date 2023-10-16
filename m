Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32998EEB9
	for <iommu@lists.linux.dev>; Mon, 16 Oct 2023 07:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="G5dSYviZ"
Received: from 8bytes.org (p4ffe149c.dip0.t-ipconnect.de [79.254.20.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id F03D51A45BD;
	Mon, 16 Oct 2023 09:40:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1697442007;
	bh=h/e/6yPFVQLA2sLmpzIiYajHY5aoxkTxJJbFAjwk3l0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G5dSYviZPyVS+YtbD0vWTPYSv3X2XdwI1dwzEcCUq1yU3Sjb3DKKk2Y5YNdIocUGe
	 oNUPNh2eLVn1P737nkeUNjll+ogBOKikEyTmgnYp6X+g7htOnNXxC2+BoWMLJJ3L//
	 ErL3ejWYAQQQM1dU8Qx04dJDvZLqFE5+C/Z1UU0U1aiDq0Ge+WQP/xJ88etFidFhJn
	 ONAz+uGTSIjmaXshxEL8BKW0s+v0gJbuXCvPan/In4ZWWtel7EumNKuX2KFG1+L9x7
	 7xGDJvdK4RDU7aegKyQvh1TW9aXwUPIZdxKxyd9xnJXtQ7i5S7I1N7yobLVI7uYVC9
	 +5EGE9c1uUStA==
Date: Mon, 16 Oct 2023 09:40:05 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, suravee.suthikulpanit@amd.com,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH trivial] iommu/amd: Remove DMA_FQ type from domain
 allocation path
Message-ID: <ZSzo1XSEA3w390j5@8bytes.org>
References: <20231016051305.13091-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016051305.13091-1-vasant.hegde@amd.com>

On Mon, Oct 16, 2023 at 05:13:05AM +0000, Vasant Hegde wrote:
>  drivers/iommu/amd/iommu.c | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks.
