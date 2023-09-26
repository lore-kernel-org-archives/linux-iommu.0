Received: from wnew4-smtp.messagingengine.com (wnew4-smtp.messagingengine.com [64.147.123.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9391338BC8;
	Tue, 26 Sep 2023 18:49:49 +0000 (UTC)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailnew.west.internal (Postfix) with ESMTP id CC8572B001CA;
	Tue, 26 Sep 2023 14:49:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 26 Sep 2023 14:49:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1695754186; x=1695757786; bh=0L
	1PD+J2hFF8IKoDu/MxIMXd7klBa9ifKTbkZPpjaR0=; b=uKO9ejLNJ7Zmi8z7Dg
	SOqdFdZRPTeaskHX/lo6oOGnDLyHKoDR5D+BQ1F1diF74CmSwwLI1OIyII36Ar37
	ZbbJ+DR+0UBN3u8cJpDq1zpSt7FeYDg6Gq8Y3Epz1Xj1wga+hwx6aP0n7TrPQpdm
	YYvSvjr62MqVtocgvhLNcuOimmgwhwQkFEjbvo5BSkzcbDc4JF0UkCuTFUNfChda
	6/vcAREJ/ju+OQyiZ+U6fSz7DtEq0aASSO8gTJNaWN7Bw25a/iAkSodqHF1kt+0t
	y7aAhLMKgkaotrw/5YBhB34K0NUcLcZbnuwyknXoE8DoNQGa0A4sD/r2gvAwOf3y
	c+0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=i449149f6.fm2; t=1695754186; x=1695757786; bh=0L1
	PD+J2hFF8IKoDu/MxIMXd7klBa9ifKTbkZPpjaR0=; b=C7gC5alTUJ0K6c73X+E
	96mUJAjtwBzBQMMjA0NUEEk4TGRQujJmO8SId3+VLUxTuoXzSlVsl9+A5zzcD7FF
	ws2CMwJns2nrL0s4hvE95tCVw9YgaWg/QNFPLDwhRodQiGl0II8woXPsCLJILThJ
	AlX1Dzdq47CQa8nlXsSHdB68f/rE0yuQDJHRW1HPHS7yRYi/WcI2VKBCkq/Jh69E
	t+DA27tDqb+q3EybpyWc4rbpu5+AuukB3OVknAopMbDuK3f2I8heXk7nASPKLhIa
	7H3GOs8ZG/vZeGI+JBDj2tioh07lvTRAjQMkgc5377KjLKNfBHF8dy6SUsa7dl8x
	2OQ==
X-ME-Sender: <xms:xycTZUzwfNLOLgbjNoD9mgIFhXCCzF32VGpVMyAoa8Om11gk-g4yrA>
    <xme:xycTZYS0HJVwmlKXTUmW4-WacaP52EQxKlNIkBokdMSsACMBdQuwKMtGTRQ-DG1tz
    qchmoIi6IJfvNHkeWc>
X-ME-Received: <xmr:xycTZWXMdyBPL2N0ZWflVdJrk4GSuuZVyC_xnZ5OIxXOgDj4KXXUZdhyiuqd7b6dwAMt0r3rVRLO4RWi0rUdvjhgMpla480TtA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtddtgddutdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomheplfgrnhhn
    vgcuifhruhhnrghuuceojhgrnhhnvgesjhgrnhhnrghurdhnvghtqeenucggtffrrghtth
    gvrhhnpeegueegvddtgfehuedutdevieehgeefteejteetvdegueelhfdtieeujeeugeeh
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjrg
    hnnhgvsehjrghnnhgruhdrnhgvth
X-ME-Proxy: <xmx:xycTZSgxpLyMQ5FoHEAsxvJRJgLLR6A4nxo0OoflqRmd3imSwIb71Q>
    <xmx:xycTZWCiNhOXGeyHNENvh6BYx5O3d5e1q5uyhZ9mKpMX4RQHMPdnuA>
    <xmx:xycTZTL_i7U69W6caDFFPlmhVNf0Vz76_NpixOMLXp-jYv4WGHY7Vw>
    <xmx:yScTZcSrh-wY715vb6CW-PI06FXBHXnuqDKdaIakZ7sYr0p_2B7znZa7IHQ>
Feedback-ID: i449149f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Sep 2023 14:49:43 -0400 (EDT)
Date: Tue, 26 Sep 2023 20:49:41 +0200
From: Janne Grunau <janne@jannau.net>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	Hector Martin <marcan@marcan.st>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Sven Peter <sven@svenpeter.dev>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 5/8] iommu/dart: Use static global identity domains
Message-ID: <ZRMnxQvYErphUs1M@robin>
References: <0-v1-8060f06462cc+c0a39-dart_paging_jgg@nvidia.com>
 <5-v1-8060f06462cc+c0a39-dart_paging_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5-v1-8060f06462cc+c0a39-dart_paging_jgg@nvidia.com>

Hej,

On Fri, Sep 22, 2023 at 02:07:56PM -0300, Jason Gunthorpe wrote:
> Move to the new static global for identity domains. Move the identity
> specific code to apple_dart_attach_dev_identity().
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/apple-dart.c | 41 ++++++++++++++++++++++++++++----------
>  1 file changed, 30 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
> index 6bc2ad2207c3da..424f779ccc34df 100644
> --- a/drivers/iommu/apple-dart.c
> +++ b/drivers/iommu/apple-dart.c
> @@ -658,11 +658,7 @@ static int apple_dart_attach_dev(struct iommu_domain *domain,
>  	struct apple_dart_master_cfg *cfg = dev_iommu_priv_get(dev);
>  	struct apple_dart_domain *dart_domain = to_dart_domain(domain);
>  
> -	if (cfg->stream_maps[0].dart->force_bypass &&
> -	    domain->type != IOMMU_DOMAIN_IDENTITY)
> -		return -EINVAL;
> -	if (!cfg->stream_maps[0].dart->supports_bypass &&
> -	    domain->type == IOMMU_DOMAIN_IDENTITY)
> +	if (cfg->stream_maps[0].dart->force_bypass)
>  		return -EINVAL;
>  
>  	ret = apple_dart_finalize_domain(domain, cfg);
> @@ -683,15 +679,37 @@ static int apple_dart_attach_dev(struct iommu_domain *domain,
>  		for_each_stream_map(i, cfg, stream_map)
>  			apple_dart_hw_disable_dma(stream_map);
>  		break;
> -	case IOMMU_DOMAIN_IDENTITY:
> -		for_each_stream_map(i, cfg, stream_map)
> -			apple_dart_hw_enable_bypass(stream_map);
> -		break;
> +	default:
> +		return -EINVAL;
>  	}
>  
>  	return ret;
>  }
>  
> +static int apple_dart_attach_dev_identity(struct iommu_domain *domain,
> +					  struct device *dev)
> +{
> +	struct apple_dart_master_cfg *cfg = dev_iommu_priv_get(dev);
> +	struct apple_dart_stream_map *stream_map;
> +	int i;
> +
> +	if (!cfg->stream_maps[0].dart->supports_bypass)
> +		return -EINVAL;
> +
> +	for_each_stream_map(i, cfg, stream_map)
> +		apple_dart_hw_enable_bypass(stream_map);
> +	return 0;
> +}
> +
> +static const struct iommu_domain_ops apple_dart_identity_ops = {
> +	.attach_dev = apple_dart_attach_dev_identity,
> +};
> +
> +static struct iommu_domain apple_dart_identity_domain = {
> +	.type = IOMMU_DOMAIN_IDENTITY,
> +	.ops = &apple_dart_identity_ops,
> +};
> +
>  static struct iommu_device *apple_dart_probe_device(struct device *dev)
>  {
>  	struct apple_dart_master_cfg *cfg = dev_iommu_priv_get(dev);
> @@ -722,7 +740,7 @@ static struct iommu_domain *apple_dart_domain_alloc(unsigned int type)
>  	struct apple_dart_domain *dart_domain;
>  
>  	if (type != IOMMU_DOMAIN_DMA && type != IOMMU_DOMAIN_UNMANAGED &&
> -	    type != IOMMU_DOMAIN_IDENTITY && type != IOMMU_DOMAIN_BLOCKED)
> +	    type != IOMMU_DOMAIN_BLOCKED)
>  		return NULL;
>  
>  	dart_domain = kzalloc(sizeof(*dart_domain), GFP_KERNEL);
> @@ -732,7 +750,7 @@ static struct iommu_domain *apple_dart_domain_alloc(unsigned int type)
>  	mutex_init(&dart_domain->init_lock);
>  
>  	/* no need to allocate pgtbl_ops or do any other finalization steps */
> -	if (type == IOMMU_DOMAIN_IDENTITY || type == IOMMU_DOMAIN_BLOCKED)
> +	if (type == IOMMU_DOMAIN_BLOCKED)
>  		dart_domain->finalized = true;
>  
>  	return &dart_domain->domain;
> @@ -947,6 +965,7 @@ static void apple_dart_get_resv_regions(struct device *dev,
>  }
>  
>  static const struct iommu_ops apple_dart_iommu_ops = {
> +	.identity_domain = &apple_dart_identity_domain,
>  	.domain_alloc = apple_dart_domain_alloc,
>  	.probe_device = apple_dart_probe_device,
>  	.release_device = apple_dart_release_device,

Reviewed-by: Janne Grunau <j@jannau.net>

best reagrds,
Janne
