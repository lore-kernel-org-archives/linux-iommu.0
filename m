Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36E020125F
	for <iommu@lists.linux.dev>; Tue, 12 Nov 2024 15:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731427076; cv=none; b=W0D8ehAXx7o4DoYcyNAx3HCOp8YDeQMvhrKS//f4XT109TcgBeazjRNlPmh3i8XZvgHdrSE3DNj0SlQGQie1dk27bX5vfvyqLGVp/RA8QG6tZ1BPJM3mQemr3s/n4qx5whu2+xj2L25mGArG2J7rBaMjvnKDTjeA4KwTHGlEZ1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731427076; c=relaxed/simple;
	bh=xcV5aO8dDT6Bs99PMcY0mZnf3cBIhNXhkkKn6XfKDc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2ypoh3NiI0GbacWfRoP9cyRYXiRFEAs70LmLyNtTVcWEM6ELTIKRF9Xs9/rcW7nkehUplRfNzEDNerH54VDCJHLiE/U8yr51XgtCZQrROAKUZZ/CzR+nFO4Q1xYwzK6krE938p3Uf+QsIldIuliso2Nj+IDjLWZ05ryynJzrFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJ3RTisR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJ3RTisR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57781C4CECD;
	Tue, 12 Nov 2024 15:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731427076;
	bh=xcV5aO8dDT6Bs99PMcY0mZnf3cBIhNXhkkKn6XfKDc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PJ3RTisRVF+zCRCxLTEWfl/lJB2uMheSYI7+nmqZvoAlREmIJwdEnm1P6wdwd0piC
	 rMYmBDQSHPcES2A16wTw2fdWOcKwgJM+HHCfWuycyd0ufFKOlp17R3x9ZizXTd+LZe
	 p7V7JJQkqnmSGfW/BXXsvEq5GFDoCDPLot0MdRHz/8R5sskqLvyE+RufH8C25asPq+
	 Xk5hAqQ2BxHtESKXrVmh5Hy+k+R7XgzHTzn3G7I7nKyL3Nw0A+Afo0r3qLZ+BmJCMx
	 PXVFFqjou7rKrPhC8I1iGqRQ1fnWqjbRHxM9xgItrW/JVENqrRAFa8vvLT71I9m2/9
	 4BBAjNIYw+WMA==
Date: Tue, 12 Nov 2024 15:57:52 +0000
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2.5/3] iommu/arm-smmu-v3: Undo SMMU enable on probe
 failure
Message-ID: <20241112155750.GC21479@willie-the-truck>
References: <cover.1731088789.git.robin.murphy@arm.com>
 <0812e9f61234cbcdc5cab7de307e1c9a8e3c9498.1731422868.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0812e9f61234cbcdc5cab7de307e1c9a8e3c9498.1731422868.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Nov 12, 2024 at 02:49:59PM +0000, Robin Murphy wrote:
> If SMMU probe fails afer arm_smmu_device_reset(), we leave the SMMU
> enabled with an empty Stream Table, silently blocking all DMA. This
> proves rather annoying for debugging said probe failure, so let's handle
> it a bit better by putting the SMMU back into (more or less) the same
> state as if it hadn't probed at all.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 7908fca962fe..566d66e9c91e 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -4640,6 +4640,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>  	iommu_device_sysfs_remove(&smmu->iommu);
>  free_iopf:
>  	iopf_queue_free(smmu->evtq.iopf);
> +	arm_smmu_device_disable(smmu);
>  	return ret;
>  }

Heh, this is starting to look an awful lot like arm_smmu_device_remove()...

Will
