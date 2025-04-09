Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563512690CF
	for <iommu@lists.linux.dev>; Wed,  9 Apr 2025 15:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744213478; cv=none; b=HaOsZQirq7FmsIWIlroAc4l/FY6nSG1RA31Ame5D5w5Q7RsRKIfVJF+lCq22/RX2gdBIPQfxlpEdJPujeTdAYn714r5EPoFsxBx9fcTLepOx+fUmf3DaYf26dtaTDNgRRya864KlgDZu82VCE2d5wuVBHRUhsfQO1g1VSYqdXTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744213478; c=relaxed/simple;
	bh=qYREGvtJjd5TJ9Nfnq3n+/uQZIwjHAzTbMhhJZ8bxtk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZyvWhl+3eIy9NopL6PXzk8sA4Pd7dRQMclyyky9mPv4H3dru9Oj7YrN2GUJ5jRyP2pmrMYFzygs6H/dnn9MTh14k6Xb+4a1eG17shm0f4+DA6ZZHv6uFlq38OLb57p+Ld0qcdHR8lOYgFTSuMSl01/pd/KxSDrwH1Q6lB1UQ6RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=pZTLeuZ1; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="pZTLeuZ1"
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 95F4C22544D;
	Wed,  9 Apr 2025 17:44:31 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1744213471; bh=tUXY0pcf31Nt1pAHcBHzpdWKoN0ie9ydJgZq/X/mo6Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pZTLeuZ1Zc9LZncPbifJhBPUc2B4DnP+y86jbDboDGfPhXnBJfi7izJ0WsgirQIiE
	 gjqqYDGD+sKcS+RMGBXP1UaueHZ3DcllN+nc464LJjyes9p5ebaKgodRnWQ5amWMPh
	 NRggdCvzAMKxosBukp5+BQyOnzkFqqppOR8RNkEkZxgUKiKtona16jDJ3+Oc7GxlgV
	 MJqjejVouh+ndDhxNZlLhlFUxgsqYV8pmKcg/ttugEyzelE3mqViSmr34YUlTC92hq
	 HmRK7nekHeKlSpR1ePVBfryeRE1dXSlKKuqFv5ACPq1dP0+W+dAjJnOHghjb7H3q9Q
	 aGVqdAOSEHH5w==
Date: Wed, 9 Apr 2025 17:44:30 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: iommu@lists.linux.dev
Cc: Petr Tesarik <ptesarik@suse.com>, David Woodhouse <dwmw2@infradead.org>,
 Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will
 Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Tom Murphy
 <murphyt7@tcd.ie>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/vt-d: Remove an unnecessary call set_dma_ops()
Message-ID: <20250409174430.00ff4a09@meshulam.tesarici.cz>
In-Reply-To: <20250403165605.278541-1-ptesarik@suse.com>
References: <20250403165605.278541-1-ptesarik@suse.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  3 Apr 2025 18:56:05 +0200
Petr Tesarik <ptesarik@suse.com> wrote:

> Do not touch per-device DMA ops when the driver has been converted to use
> the dma-iommu API.
> 
> Fixes: c588072bba6b ("iommu/vt-d: Convert intel iommu driver to the iommu ops")
> Signed-off-by: Petr Tesarik <ptesarik@suse.com>

Does anyone agree? Or see any issues?

Petr T

> ---
>  drivers/iommu/intel/iommu.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index bf1f0c814348..b7e500451d4f 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -3789,7 +3789,6 @@ static void intel_iommu_release_device(struct device *dev)
>  	intel_pasid_free_table(dev);
>  	intel_iommu_debugfs_remove_dev(info);
>  	kfree(info);
> -	set_dma_ops(dev, NULL);
>  }
>  
>  static void intel_iommu_get_resv_regions(struct device *device,

