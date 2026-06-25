Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455A0288BA
	for <iommu@lists.linux.dev>; Thu, 25 Jun 2026 15:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782402501; cv=none; b=da4Y1CsYR4zcMtMmmykICaS9R0jSs/aLK4/0UZPT3GVoW1oE9PiOcvpDN74+UVKY4gJFuxKqzvQEFg4xZCyhIhIIMM1alZMKo2y2EVrrU26IJqEfS2h3Wzs+3uXCsd6vpDJxhTT2bEuD+ZgTv/0x2puiiELKkxyInTwX/RMJgRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782402501; c=relaxed/simple;
	bh=1+A6gPT4LQUsY2QnTfPNBJkWRgFjnYZMeyYX+1UYPNk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XYtFyNFEoLfSHoB69BgpIWnVaqiaHZf48Pu6tmUx6ADwCjqXWYn9RZKUvptKoGOqEVda+iW959Pp108Gy4oVyZgSUrrhsxQCWEIKQip+iorUNJbberfvanoBzgqG5rmeBQP3MxD4W+vDcJbPJ+7Ki1zKqySwEa5jZtfoWcmpVkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a+ry3h2g; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a+ry3h2g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782402499; x=1813938499;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=1+A6gPT4LQUsY2QnTfPNBJkWRgFjnYZMeyYX+1UYPNk=;
  b=a+ry3h2gauQbE5X9Lx54BNbzH3KW4EpqiEnmW+BSCIitJrvTpeuv1LSs
   o2xPaZfqMnUNDh2bgXbeEGuDMV6Kl/LSTQt3E5LynzPQBqiYZDdzeSwzy
   l9+XBrDJwWWiFH7fuUsIFr6h/rXOfjvy9/Ycf3PgtBS6m5FoDIn7o+iuj
   l42EfuzKG5eb5jhKlKDI8qKIAYUKslAIOvj0fLvLoWWHLjRATUzXvV3WN
   UiCI1cUbjdRYzeyPt840vfa7kaMEOBNglrxpU25fGEG56BEql1Dm+d4Wn
   EYtWyADISQ5fdYuEiA5h/wlZmM9Qm0jerTHjTGfoarnRPbrBBu8+wDC8K
   A==;
X-CSE-ConnectionGUID: eAPrRf8tTQy1GK7V8cwg5g==
X-CSE-MsgGUID: 5Ic1ifR2RgSybD4ZlgojjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="94672791"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="94672791"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 08:48:19 -0700
X-CSE-ConnectionGUID: bnTDR+9oSp2v6LlaA//k7g==
X-CSE-MsgGUID: bsv1XPUrSYWzkAVo2KV/4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="249751034"
Received: from dev-417.igk.intel.com ([10.91.214.181])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 08:48:16 -0700
Date: Thu, 25 Jun 2026 17:48:14 +0200 (CEST)
From: =?ISO-8859-2?Q?Micha=B3_Grzelak?= <michal.grzelak@intel.com>
To: Krzysztof Karas <krzysztof.karas@intel.com>
cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
    iommu@lists.linux.dev, Andi Shyti <andi.shyti@linux.intel.com>, 
    Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
    Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, 
    Sebastian Brzezinka <sebastian.brzezinka@intel.com>, 
    Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH 1/3] drivers/iommu: Unroll unsuccessful mapping
In-Reply-To: <20260625134342.1102921-2-krzysztof.karas@intel.com>
Message-ID: <5016dea0-5710-b0f9-754b-36d0c7325d46@intel.com>
References: <20260625134342.1102921-1-krzysztof.karas@intel.com> <20260625134342.1102921-2-krzysztof.karas@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-886975909-1782402498=:605841"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-886975909-1782402498=:605841
Content-Type: text/plain; format=flowed; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT

Hi Krzysztof,

I'm wondering about changing the prefix of patch's title into
iommu/dma:, but there are commits changing dma-iommu.c having other
prefixes as well; not sure if it matters.

On Thu, 25 Jun 2026, Krzysztof Karas wrote:
> Currently, if iommu maps fewer bytes than requested (iova_len),
> it proceeds to free the iova, but never tries to unmap already
> touched bytes. This behavior may cause memory hogging down the
> line.
>
> Correct that by unmapping before exiting.
>
> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> ---
> drivers/iommu/dma-iommu.c | 10 ++++++++--
> 1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 381b60d9e7ce..c4c058ba07ef 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1515,8 +1515,14 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
> 	 * implementation - it knows better than we do.
> 	 */
> 	ret = iommu_map_sg(domain, iova, sg, nents, prot, GFP_ATOMIC);
> -	if (ret < 0 || ret < iova_len)
> +	if (ret < 0 || ret < iova_len) {
> +		if (ret > 0) {
> +			/* Unmap partially mapped bytes before freeing IOVA */
> +			if (iommu_unmap(domain, iova, ret) != ret)
> +				ret = -EIO;
> +		}
> 		goto out_free_iova;
> +	}

Also thinking whether not to split this into two separate if's,
something like:

ret = iommu_map_sg(domain, iova, sg, nents, prot, GFP_ATOMIC);
if (ret < 0)
 	goto out_free_iova;

if (ret < iova_len) {
 	if (ret > 0) {
 		/* Unmap partially mapped bytes before freeing IOVA */
 		if (iommu_unmap(domain, iova, ret) != ret)
 			ret = -EIO;
 	}

 	goto out_free_iova;
}

But that's probably just a matter of opinion. Whether it applies or not:

Reviewed-by: Micha³ Grzelak <michal.grzelak@intel.com>

BR,
Micha³

>
> 	return __finalise_sg(dev, sg, nents, iova);
>
> @@ -1525,7 +1531,7 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
> out_restore_sg:
> 	__invalidate_sg(sg, nents);
> out:
> -	if (ret != -ENOMEM && ret != -EREMOTEIO)
> +	if (ret != -ENOMEM && ret != -EREMOTEIO && ret != -EIO)
> 		return -EINVAL;
> 	return ret;
> }
> -- 
> 2.34.1
>
>
--8323329-886975909-1782402498=:605841--
