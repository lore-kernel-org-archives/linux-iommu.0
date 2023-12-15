Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1021112E40
	for <iommu@lists.linux.dev>; Fri, 15 Dec 2023 08:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="A4gInUKe"
Received: from 8bytes.org (p4ffe1e67.dip0.t-ipconnect.de [79.254.30.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 121431A230B;
	Fri, 15 Dec 2023 09:07:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1702627632;
	bh=DoLMZzXbG/nWSjrpA3fB74d7qoBKCRr4ZyF52F0eyOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A4gInUKeDrLKf9Y9tGxAqDzDUok/NETBtA5ZDULDobcM2JfCceidpXN+T8+RPivxC
	 dNiTqxRozUciZ1RqVxu5ylyUp5nMkCXD5J8fpudZGEYIWbC/MhxmcTmELSSJDn38hO
	 ZX19amG6Inl0vqpkCbx+24iEbyWlkq+UrxBSNIjTHVDFm0VrDQfEVWPDEpCuxqqlAE
	 DyE9oQE/7IetE179DH8ni/Y+DtrO24AeJklIJaq8+2f7UDDBhH/N73/7BRawyzW099
	 E8acfqEfhl4mXr2bGWjJJIdnX4DVDRz1K2545et/jltidEFKPDW8MEnHCiGQtTzIH4
	 XJPUGmDNS0uOg==
Date: Fri, 15 Dec 2023 09:07:10 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
	error27@gmail.com
Subject: Re: [PATCH] iommu/sva: Fix memory leak in iommu_sva_bind_device()
Message-ID: <ZXwJLi9EnfdLVAHA@8bytes.org>
References: <20231213111450.2487861-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213111450.2487861-1-harshit.m.mogalapalli@oracle.com>

On Wed, Dec 13, 2023 at 03:14:50AM -0800, Harshit Mogalapalli wrote:
>  drivers/iommu/iommu-sva.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied, thanks.
