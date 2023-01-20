Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DFFBD3E
	for <iommu@lists.linux.dev>; Fri, 20 Jan 2023 09:42:39 +0000 (UTC)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id B1A78262AAF;
	Fri, 20 Jan 2023 10:42:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1674207758;
	bh=AxvLserjHePoULY2jhyau9FVv0QQcDxxMY4MWDasHdM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ALggVwHX9UO5pPw9VaDzbw5dtfoZU0pyBE7/3a9ssHBlM9mRN3wgsV57Nzm+Tlpj3
	 8/A8iCEKZjuTD+41hIFgoOAKDca/etI5shPOvIJrbo+CP+6mtyiGPX6KyJgakZYXGg
	 g6ebnIu90CrVPvtvJT757bIqu08QXsxcgFLENHX8pXUq5LRAzADnI1JfHmquH2hYtK
	 BsmIB1AlHnCrGKW+iM/yI1z725D8B+72OLW67Hfwm3dZcN7d7o2HDEFihIfMTAbPw9
	 XHOb4JUrX69e+1kMjy9H5SA1opTqIcXq0/Wr7vuWCVfyPQy/QYYeesOVxmzffZdThp
	 MRpD4qILus5Pg==
Date: Fri, 20 Jan 2023 10:42:37 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, suravee.suthikulpanit@amd.com,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v2] iommu/amd: Do not clear event/ppr log buffer when snp
 is enabled
Message-ID: <Y8piDWhq7uNqFrqo@8bytes.org>
References: <20230117044038.5728-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117044038.5728-1-vasant.hegde@amd.com>

On Tue, Jan 17, 2023 at 04:40:38AM +0000, Vasant Hegde wrote:
>  drivers/iommu/amd/iommu.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)

Applied, thanks Vasant and Tom.
