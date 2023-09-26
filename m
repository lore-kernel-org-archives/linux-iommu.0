Received: from wnew4-smtp.messagingengine.com (wnew4-smtp.messagingengine.com [64.147.123.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEDC30FB5;
	Tue, 26 Sep 2023 19:06:41 +0000 (UTC)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailnew.west.internal (Postfix) with ESMTP id 70E242B00139;
	Tue, 26 Sep 2023 15:06:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 26 Sep 2023 15:06:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1695755198; x=1695758798; bh=AV
	RKiN4lLhcIV6PX9BT4wVMTmeUToD+TCFVS7tzYNF0=; b=Jpq56vyBk4FoeEbNSC
	XG+sjb7A6B7u0H8aZ5q0K3zQCrDkXK4i+i32IHm17jrJK/x6RLQWCIqG2chxPsDD
	3/3mex03iw/EY0k0Ll7QlzQ58BQaI6PPOI1bwegmMuuhnGlUHXm1GhUEfpgFTBZ+
	h0nFYGeOTJ//2ABcUhI7MgLocQVTrg/oSl9okGfhJkxXMhCMU69SGVodlWsc7MfV
	mZrF1yyiTggdNB3f+ByoeUSCicJFDhDAeTf0rpVrcF0TJ3oMqywnrQV5O5CrQrLd
	fESU6ROqdgFy6LbxpVSbFGVe2MfDcuTwoE5ITPyRtBbNaP6wyhSJrTGoi4hAtXvN
	aVIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=i47b949f6.fm2; t=1695755198; x=1695758798; bh=AVR
	KiN4lLhcIV6PX9BT4wVMTmeUToD+TCFVS7tzYNF0=; b=PTP1YtquchzwhEnSrq3
	BKok4Q521qmAmppY/LizS6Goe4O5R460Gx6vOQX95p5jsH5pBFkx35riGMB8ctFa
	1wA61aZt1wkXDSqbwjDad4Nn7YUTLNd0gVRGoMZbpKpGu5uBIHl1DE2jFRIT4kJV
	s5QZCpPj+hKZ1SawGwy19BWw5YRAP+LZ3JiBa/5ZAEO/Du2FLOSK3r4sXHxLeygC
	5mQcOleGQ8RrcQ3AP/1I8fbudv/X2gXDja8kxA6qbBwhLhGKQVy+dsJapgqhc+2+
	/KEdjFnlw/Ndhw/fFH+UPfLSXzix5O3OrpTg92MPkCCv75iolan25mpb7a78amNT
	g9w==
X-ME-Sender: <xms:vSsTZRVRHgo1Yd200vedUdfkCutslfvRcRlisltjXNuLr7mcJKRZdA>
    <xme:vSsTZRmAE8mjF_cUjxKWdMocmpyj5w6D7P22JhKt409uEjw73VtvMpgFcNJtFrkmR
    J9z7lVRXY3vOId08lo>
X-ME-Received: <xmr:vSsTZdZY0N5uVhesNV8JrI91Bx2I65LBlIOpW4GSTGc5I7L9I6_aa66F4yqFJlkw7UAufUxqi9ma0y63ApFkq1mMAN-o0mGYiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtddtgddutdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomheplfgrnhhn
    vgcuifhruhhnrghuuceojhesjhgrnhhnrghurdhnvghtqeenucggtffrrghtthgvrhhnpe
    fgvdffveelgedujeeffeehheekheelheefgfejffeftedugeethfeuudefheefteenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjrghnnhgvse
    hjrghnnhgruhdrnhgvth
X-ME-Proxy: <xmx:vSsTZUWDsczTfFCnejPKypK86gmbdzd9G2YyVER4NgtcxirXAV38ew>
    <xmx:vSsTZbmmZLmXdwoxK1-6n2QbkCV2VWUpNWu5HVZPkfiQUxrtVkyQaw>
    <xmx:vSsTZRfPF_8735bxBilUlWysMRoS-DJLnM50o-OoZvfqh1PParaotw>
    <xmx:visTZTksmzOSMPJzW5cnGtZyMXEeg4IvpGcjfaUrQ1_JYrTA_qrX94RAao0>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Sep 2023 15:06:37 -0400 (EDT)
Date: Tue, 26 Sep 2023 21:06:36 +0200
From: Janne Grunau <j@jannau.net>
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
Subject: Re: [PATCH 7/8] iommu/dart: Convert to domain_alloc_paging()
Message-ID: <ZRMrvJ4ZVibVQLNS@robin>
References: <0-v1-8060f06462cc+c0a39-dart_paging_jgg@nvidia.com>
 <7-v1-8060f06462cc+c0a39-dart_paging_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7-v1-8060f06462cc+c0a39-dart_paging_jgg@nvidia.com>

On Fri, Sep 22, 2023 at 02:07:58PM -0300, Jason Gunthorpe wrote:
> Since the IDENTITY and BLOCKED behaviors were moved to global statics all
> that remains is the paging domain. Rename to
> apple_dart_attach_dev_paging() and remove the left over cruft.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/apple-dart.c | 33 +++++++++++----------------------
>  1 file changed, 11 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
> index 376f4c5461e8f7..62efe0aa056f60 100644
> --- a/drivers/iommu/apple-dart.c
> +++ b/drivers/iommu/apple-dart.c
> @@ -650,8 +650,8 @@ static int apple_dart_domain_add_streams(struct apple_dart_domain *domain,
>  				      true);
>  }
>  
> -static int apple_dart_attach_dev(struct iommu_domain *domain,
> -				 struct device *dev)
> +static int apple_dart_attach_dev_paging(struct iommu_domain *domain,
> +					struct device *dev)
>  {
>  	int ret, i;
>  	struct apple_dart_stream_map *stream_map;
> @@ -665,21 +665,13 @@ static int apple_dart_attach_dev(struct iommu_domain *domain,
>  	if (ret)
>  		return ret;
>  
> -	switch (domain->type) {
> -	case IOMMU_DOMAIN_DMA:
> -	case IOMMU_DOMAIN_UNMANAGED:
> -		ret = apple_dart_domain_add_streams(dart_domain, cfg);
> -		if (ret)
> -			return ret;
> +	ret = apple_dart_domain_add_streams(dart_domain, cfg);
> +	if (ret)
> +		return ret;
>  
> -		for_each_stream_map(i, cfg, stream_map)
> -			apple_dart_setup_translation(dart_domain, stream_map);
> -		break;
> -	default:
> -		return -EINVAL;
> -	}
> -
> -	return ret;
> +	for_each_stream_map(i, cfg, stream_map)
> +		apple_dart_setup_translation(dart_domain, stream_map);
> +	return 0;
>  }
>  
>  static int apple_dart_attach_dev_identity(struct iommu_domain *domain,
> @@ -755,13 +747,10 @@ static void apple_dart_release_device(struct device *dev)
>  	kfree(cfg);
>  }
>  
> -static struct iommu_domain *apple_dart_domain_alloc(unsigned int type)
> +static struct iommu_domain *apple_dart_domain_alloc_paging(struct device *dev)
>  {
>  	struct apple_dart_domain *dart_domain;
>  
> -	if (type != IOMMU_DOMAIN_DMA && type != IOMMU_DOMAIN_UNMANAGED)
> -		return NULL;
> -
>  	dart_domain = kzalloc(sizeof(*dart_domain), GFP_KERNEL);
>  	if (!dart_domain)
>  		return NULL;
> @@ -982,7 +971,7 @@ static void apple_dart_get_resv_regions(struct device *dev,
>  static const struct iommu_ops apple_dart_iommu_ops = {
>  	.identity_domain = &apple_dart_identity_domain,
>  	.blocked_domain = &apple_dart_blocked_domain,
> -	.domain_alloc = apple_dart_domain_alloc,
> +	.domain_alloc_paging = apple_dart_domain_alloc_paging,
>  	.probe_device = apple_dart_probe_device,
>  	.release_device = apple_dart_release_device,
>  	.device_group = apple_dart_device_group,
> @@ -992,7 +981,7 @@ static const struct iommu_ops apple_dart_iommu_ops = {
>  	.pgsize_bitmap = -1UL, /* Restricted during dart probe */
>  	.owner = THIS_MODULE,
>  	.default_domain_ops = &(const struct iommu_domain_ops) {
> -		.attach_dev	= apple_dart_attach_dev,
> +		.attach_dev	= apple_dart_attach_dev_paging,
>  		.map_pages	= apple_dart_map_pages,
>  		.unmap_pages	= apple_dart_unmap_pages,
>  		.flush_iotlb_all = apple_dart_flush_iotlb_all,
> -- 
> 2.42.0

Reviewed-by: Janne Grunau <j@jannau.net>

best regards
Janne
