Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2E849E13E
	for <iommu@lists.linux.dev>; Thu, 10 Sep 2026 22:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789079151; cv=none; b=Gex4ol6gotZX+DdfWbjeDlOmzgLNBTswRYX8zX/bY2UEN55fZNqBuSymtt5ROrziFR1667vXCT7PxTUws0WDhbdRRPKRs85pu6s0EpKz1+rQoa1F00SszWQQBULkH6N1ex4wytBr/gzyl/LyizIVg3qV0JS9IVgB1ICyp42+VO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789079151; c=relaxed/simple;
	bh=WBCJnYwlTtoL5xqy3v4I0Fiw65OZmHcMSif25lHyNmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b6bjhMAsSO8UBG1f9L4LHrju5kFTnjNUMHzn7lLaSfze5fEhkuYfYkw2ccORZ5TNct4eHqZa+O1KGf1GMz2WkyD5d+2yTLrLiiUt6+psEtwX5dTcFmRLrqQxZvG0YUweQFEiolZSepH4s1EZG8UWrO6KxzDI3Vgl+hO5eIH3HVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lw0lXS26; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lw0lXS26"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECE481F000FF;
	Thu, 10 Sep 2026 22:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789079150;
	bh=zLCp76C7IaDd/3HXXZHhXNNmT8LOyuAL2jBPJFFL5bw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lw0lXS26SmWr01PVgdMI2cSEuV2iWoftdhxuLIKwlnhwhjMMdbfrCwTDPx8MfDLuZ
	 5Y7P5dq9CyeV1Z0RP5/wuYmY2ynE/PfZ3vsxSRxVFtHGmFu/TbgFKUP5rgg4PaBv/k
	 +TP09/ZuUhlWvZn/Gtbtwmk9R+Zr1zFpK98KloILnL7Ly5PvneRlSKmZFdATH5FGvX
	 RGDx3KX6jwSbUh1WhGhVoTILvLWNiPX1Dack/Lh7PtMfFpFPYfsP2lESsPSU6tausu
	 VoDbIG8NiABNenMKm+OhrO+aaI39aXz8xhCYdUz8kkYr4G09yWilMUunGMr8mrUEj0
	 RkIvXpWHIysPw==
Date: Fri, 11 Sep 2026 00:25:46 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	iommu@lists.linux.dev, Andi Shyti <andi.shyti@linux.intel.com>, 
	Robin Murphy <robin.murphy@arm.com>, =?utf-8?Q?Micha=C5=82?= Grzelak <michal.grzelak@intel.com>, 
	Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka <sebastian.brzezinka@intel.com>, 
	Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v6 4/7] iommu/dma: Catch scatterlist length overflows
Message-ID: <aqMt2sldJO05k5O3@zenone.zhora.eu>
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

one more thing here.

>  drivers/iommu/dma-iommu.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)

Can we send this patch separately? It just complicates things
if added in this series. Besides, pleasee add iommy maintainers
in the Cc list. You can use get_maintainers.pl

Andi
