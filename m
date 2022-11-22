Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D2E10FC
	for <iommu@lists.linux.dev>; Tue, 22 Nov 2022 08:37:30 +0000 (UTC)
Received: from 8bytes.org (p200300c27724780086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7724:7800:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 0AB5E2A058F;
	Tue, 22 Nov 2022 09:37:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1669106250;
	bh=ZYzDl8y6Syya/UxGcWjshAT36ptBFYPl3zxcCxHVpg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=axh+7KP0PtvSAGdeHrlXk29FjwKtf2n4p+S3RzNZbpd9AiJXGVhdbqE2/4Uf8Dk/s
	 sNkrUCxAyWT16QoSGSFGlnM81C5NKnR6p4J1QiMIYHd6uU8OkUVbBxtU4g7Iv5dJzO
	 BtsF/wlJRwx6PHQspbi4joIYDy+1L2v86xxR1uTZydVS8twzuAeNrw2pOxKq5ECjFp
	 6VMjbPpP8PL1IGLYC+Zet8gKbYQOP3KudCMA42PtDAvDt3NX1A1Z0uCLzwp46M6Eu9
	 2MTpOK1BmNwATAQSUY3D/CILE6DIk9MQnvx/3i5TwKkc1BpUPQJxmxC9qUbx3bi8h/
	 0Jp5J5RjFq5xw==
Date: Tue, 22 Nov 2022 09:37:28 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Yuan Can <yuancan@huawei.com>
Cc: will@kernel.org, robin.murphy@arm.com, timur@tabi.org,
	alex.williamson@redhat.com, Varun.Sethi@freescale.com,
	iommu@lists.linux.dev
Subject: Re: [PATCH] iommu/fsl_pamu: Fix resource leak in fsl_pamu_probe()
Message-ID: <Y3yKSLllyolauQ0j@8bytes.org>
References: <20221121082022.19091-1-yuancan@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121082022.19091-1-yuancan@huawei.com>

On Mon, Nov 21, 2022 at 08:20:22AM +0000, Yuan Can wrote:
> The fsl_pamu_probe() returns directly when create_csd() failed, leaving
> irq and memories unreleased.
> Fix by jumping to error if create_csd() returns error.
> 
> Fixes: 695093e38c3e ("iommu/fsl: Freescale PAMU driver and iommu implementation.")
> Signed-off-by: Yuan Can <yuancan@huawei.com>
> ---
>  drivers/iommu/fsl_pamu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
