Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.250.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795426823;
	b=co8+4FVtNapupm+zi2SSHLZOUAtLztvFcmuy+3uW7NA3TwYPmBXaK6GeDG8a/MZG0PDf
	 7MjPtoUh6KLAP8CW01ZUdfSxWdF8GnKpWuGlxggicq8u/9BhUoV0Ke8EPFHwmcge7Hpf7
	 IXUoQvpE4ogF6yCHg2qvEFkxPiMBNSgQ75N8UXnRZAdmdxuDaCimHAdpgw2zmC/142vKr
	 xST5E52YBkuCZBVgtawcKxmQVDBKGjFuxE+NPWKX0E7TAguNtBrB17vvz16SQbnuMSQvJ
	 iMFCjIZr88iFT9vS6Fe71DgxD/3s8l/dUVtHNBsvaoIro4ovyv/myePGt+WCZN82fbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795426823;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=LTDf95qdwRLFA2ctM5WM0AhRXmDQTgYwwKUGT48lXbQ=;
	b=l0j2qvda+1cUT33MEtbwV+xVi18iN1OdajT6ZcsPMkuqNbv9vEFFR6RfkHGov/NT5Hbu
	 txHzfLm38Uw5VH6Cu5ji9uWpqOpJFA3uwySYEZXQMcCNh933jdvviDskHLbIOQlfacO3q
	 qBJJtEuuTfVyXH0YYsSa4pvCK4zQ7iHODUB3PF7J1aG1WhfETRFjkad0mOspeBMyV6Fi6
	 TgUS7lEkCn4QiGLFaAyPHlsGPNZ/FU3ASi/vNXxOTPsyBdoBlGMqXFYopoXCZ3fcN7YU6
	 BB13aiaoUUWNJgagnLW/PsrYbIpLq+oqDdcqQcramyRAOINBCMOA36b+QnunxtxUDIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=8bytes.org;
	spf=pass smtp.mailfrom=8bytes.org;
	arc=none smtp.remote-ip=85.214.250.239
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F73C606A31E
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 09:40:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F73C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p549216fa.dip0.t-ipconnect.de [84.146.22.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 769BA244826;
	Mon, 23 Nov 2026 10:40:21 +0100 (CET)
Date: Mon, 23 Nov 2026 10:40:20 +0100
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jean-Philippe Brucker <jpb@kernel.org>, 
	Yi Liu <yi.l.liu@intel.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] iommu: Fix attach handle publication ordering
Message-ID: <awQJ9aMCtQVDF1j6@8bytes.org>
References: <cover.1793729087.git.nicolinc@nvidia.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793729087.git.nicolinc@nvidia.com>

On Tue, Nov 03, 2026 at 10:06:59AM -0800, Nicolin Chen wrote:
> Nicolin Chen (5):
>   iommu: Unpublish the attach handle before the group detach callback
>   iommu: Unpublish the attach handle before the PASID detach callback
>   iommu: Unpublish the old attach handle before the group replace
>     callback
>   iommu: Unpublish the old attach handle before the PASID replace
>     callback
>   iommu: Reject a same-domain replace in the attach handle APIs
> 
>  drivers/iommu/iommu.c | 88 +++++++++++++++++++++++++++++++------------
>  1 file changed, 63 insertions(+), 25 deletions(-)

Applied, thanks.
