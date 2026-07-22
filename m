Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E35426ECF
	for <iommu@lists.linux.dev>; Wed, 22 Jul 2026 21:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784756506; cv=none; b=kgzH2yNeKLUnYxbYYhqPI9XcB6AdzsNnKBDvyRkl1xYbpEdSir6nIxhiEqfmAPLouGbaQLsHviKM9UUV+sZItJqJsZaDVoxZ64HySfFPdKfgHDrld5GOInpoqoYbr7ML7o6uiMSKGeI1421JuWcgSgIIVYmuOugk3OuACc0RpBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784756506; c=relaxed/simple;
	bh=KYg1d/Q18QmSgMFlBU+F0XpqH393QGRIuPXtd7aOLbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SGF8E+3mJrXhOqbQIhMUM2UnZ8O+byuME5zZoy58MzD0Q4eCjmoq1HcgmyomrYTghkGJh88prreFdeqWyXNwVu71Mr98UoVPpZfsdfX2+CQfX3nzU4a3hCBaOQvC9ABSKcFUjzla2PNfNJntYlke2nnEnlofk72jrN2TJFVJhr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHTotdow; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHTotdow"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 689061F00A3A;
	Wed, 22 Jul 2026 21:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784756504;
	bh=FRbA0qzo4okF76dMGbH9rdJAwvZeBfWtaNb9X9YeL+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PHTotdow13nNgQaphkRaXtb6J62ya4IJINj4ncekz1Sjnjrx0jKX+q4H6UlUHlpJS
	 b7QY6AfuYbfPqMwSE5LJxeO71pNPSfuaBA1YdkZhVH/THUvz117LIAOoHiK52FnuHr
	 GSQjOW8+lvGazNObQwn0JzghgOYyWFkOxkVmV5/lOmb0lvWtCf02T5oH6tj59Ucd28
	 nrutEfZdeKwLAA7V/3r3Hx7wfx8s9Y9RFd7YATn0y8Urys7lAP6S2Ks/3xd/absBag
	 BFNAnKC2S1swwJrFytEKNAlD2I1AO6lmW67tmvb51F2rDIRzjzp+IgNXQLNG01dJ1U
	 LUiXvlp8pA8uA==
Date: Wed, 22 Jul 2026 22:41:40 +0100
From: Will Deacon <will@kernel.org>
To: weimin xiong <xiongwm2026@163.com>
Cc: iommu@lists.linux.dev, baolu.lu@linux.intel.com, dwmw2@infradead.org,
	joro@8bytes.org, robin.murphy@arm.com,
	xiongweimin <xiongweimin@kylinos.cn>
Subject: Re: [PATCH] iommu/vt-d: fix typo in comment
Message-ID: <amE5FKH5dpVE8MHE@willie-the-truck>
References: <20260714032422.201378-1-xiongwm2026@163.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714032422.201378-1-xiongwm2026@163.com>

On Tue, Jul 14, 2026 at 11:24:22AM +0800, weimin xiong wrote:
> From: xiongweimin <xiongweimin@kylinos.cn>
> 
> Correct "assocaition" to "association".
> 
> Signed-off-by: xiongweimin <xiongweimin@kylinos.cn>
> ---
>  drivers/iommu/intel/irq_remapping.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
> index 25c26f706..cc2eca08a 100644
> --- a/drivers/iommu/intel/irq_remapping.c
> +++ b/drivers/iommu/intel/irq_remapping.c
> @@ -953,7 +953,7 @@ static void ir_remove_ioapic_hpet_scope(struct intel_iommu *iommu)
>  }
>  
>  /*
> - * Finds the assocaition between IOAPIC's and its Interrupt-remapping
> + * Finds the association between IOAPIC's and its Interrupt-remapping
>   * hardware unit.

This comment still doesn't make sense, though. Why is it "IOAPIC's"?

Will
