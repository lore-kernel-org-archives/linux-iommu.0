Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB6F49E129
	for <iommu@lists.linux.dev>; Thu, 10 Sep 2026 22:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789078880; cv=none; b=MeL+8FUieA8f1TKbbf+9BYiJxEBXZNaMNeA0j2YnT8CwNscVVr+zjMgXRJCQvEslkyf3o0c1F91AWSvegdCwW4NpafJ188a/rwaN3DwyXdM+NsgZumJMVk3flhH3uhzPId1VHhwuYUcQfiMlvqwOn/G5GNLABXQHS2Fcrvs+9Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789078880; c=relaxed/simple;
	bh=/6fDhXj7eCL5VmLL0pw1j323a96iS5VhhA/6/Isaf0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lwkv4z7jQ/v4Y5iEQ4HB2dJ0hacV6gGqbNlPmoLzmuSP4TZdByHsp7Nq9qLWaS+2uFaBz+MfjPztYBf+5fE9WKp2dLssSgUKz49Xrsy5URURsvlhA/oXKCIAN6xT230ZjYDqWPO5MBgIkF4dvZTsaOuoor3IrGTsVFlWCJznVVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tip9PTBN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tip9PTBN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 686621F000FF;
	Thu, 10 Sep 2026 22:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789078879;
	bh=hMftyWYO7h32qDbE7ZfNTFDE8JGJslDOC+EQt/xXI4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Tip9PTBNfjEkwOldlmzsr09Tpwe1CnquLUhtDgAoEFHcxhb0wIua4iAjduY5UuSF+
	 yOpr+asDCW6rms6qq1sbwpgR/N5lt64sg6JCwO5IfmZWA+fwENwgiyIEx7kKIrVcwj
	 9nvBWJBdR96bwKC66LB8x6/DHfnclqlpcru2iHeNGko3KclFEzteHEDl15rnGBsEFD
	 udFIImfvhDpE0OAr4AlMlsWoEhIdGaqaufrBD4T0Sjw+uX6EyLN7UCDGyv0QkQsjo8
	 JQ5pxKjryG5ts+Su661Qu7K59g76opmp8SihhRHlDmq/59+fzP5skM8tmjAC/71GIT
	 WmgoY9oTNpOmQ==
Date: Fri, 11 Sep 2026 00:21:15 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	iommu@lists.linux.dev, Andi Shyti <andi.shyti@linux.intel.com>, 
	Robin Murphy <robin.murphy@arm.com>, =?utf-8?Q?Micha=C5=82?= Grzelak <michal.grzelak@intel.com>, 
	Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka <sebastian.brzezinka@intel.com>, 
	Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v6 4/7] iommu/dma: Catch scatterlist length overflows
Message-ID: <aqMrxRny29Kbtkdq@zenone.zhora.eu>
References: <20260902082525.1149367-1-krzysztof.karas@intel.com>
 <20260902082525.1149367-5-krzysztof.karas@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902082525.1149367-5-krzysztof.karas@intel.com>

Hi Krzysztof,

...

> @@ -1477,6 +1477,10 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
>  		sg_dma_len(s) = s_length;
>  		s->offset -= s_iova_off;
>  		s_length = iova_align(iovad, s_length + s_iova_off);
> +		if (overflows_type(s_length, s->length)) {
> +			ret = -EOVERFLOW;

the value of ret here doesn't really matter because it returns
anyway an -EINVAL. We can completely remove this assignment.

> +			goto out_restore_sg;
> +		}
>  		s->length = s_length;
>  
>  		/*
> @@ -1493,7 +1497,18 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
>  		 *   time through here (i.e. before it has a meaningful value).
>  		 */
>  		if (pad_len && pad_len < s_length - 1) {
> -			prev->length += pad_len;
> +			unsigned int new_prev_len;

Please add a blank line here.

> +			/*
> +			 * For large mappings spanning multiple GBs we
> +			 * may not be able to fit all needed padding into
> +			 * sg->length.
> +			 */
> +			if (check_add_overflow(prev->length, pad_len, &new_prev_len)) {
> +				ret = -EOVERFLOW;

same goes here.

Thanks,
Andi

> +				goto out_restore_sg;
> +			}
