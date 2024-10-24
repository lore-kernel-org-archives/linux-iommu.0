Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07DF1DFEF
	for <iommu@lists.linux.dev>; Thu, 24 Oct 2024 13:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729775717; cv=none; b=XsLRPyR2aX0/lH2beTYXRAu1KqJAAXmWNXpMkwNm9BoOlxTBScaavNEkTWslHC/OqyTsjKg8zal/FSgbp2cCD7bCw+1aqQAoba+NjlwQyUsDtDtkNaxK9SG2JeK+oC46rPvSwrcoS/aqB94pVCrPmO28bN4M1LoUb9S8pgORi7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729775717; c=relaxed/simple;
	bh=br3NMDBTfacz/koxpdN+l9rWEyn3BmA41k2tgC41Kro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sIJSDx4nXfGkh9kv0qflSV4/RlxwKrfxKJW8bsaQhPWdQNqZE5SoIRsXT3E0ZFqhyKJHIq6tDH0tLVo2CxszUnpR8fZ4AlY8XwipGiPVu65PQtEttoV0yLHSlBc4895BfUPN8PcFWpUTI/QWwRG8PP9Ni/NAu4uBc8+5gjeERus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kowUAknv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kowUAknv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E45EAC4CEC7;
	Thu, 24 Oct 2024 13:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729775717;
	bh=br3NMDBTfacz/koxpdN+l9rWEyn3BmA41k2tgC41Kro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kowUAknv5IYoVGkE6zUvTOT7dHAkUdD8GMukc7VRgam32HiNFb2r3PAeGdl8yo8mS
	 qHHoHHoOwhvpeOJ+N+qL2kwb3ov254v7YoXiaPAXkfywRECDHuEbqPdOPxru/G2nTq
	 LfsFOmEdKGa62r4KlNaJYI7GOIS+IMXXS6/t/5he8+eDvA4lhkdvwl4dGR9SwlW8BN
	 whLiWB4Lg29rLwUlcIPvZ96dsdcaTuEdJ/BDO9tdwQaGGDZADX44FNqtgWA1MynSf2
	 YzUyNTFNMZGxrQqIPv641UwUWwprjWidn9EnYQ5KBenPPwya1DNDhnA8ScsNedfA0b
	 3x8DCnr+AICXg==
Date: Thu, 24 Oct 2024 14:15:12 +0100
From: Will Deacon <will@kernel.org>
To: Pranjal Shrivastava <praan@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 2/3] iommu/arm-smmu-v3: Log better event records
Message-ID: <20241024131511.GH30704@willie-the-truck>
References: <20241018180022.807928-1-praan@google.com>
 <20241018180022.807928-3-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018180022.807928-3-praan@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Oct 18, 2024 at 06:00:21PM +0000, Pranjal Shrivastava wrote:
> Currently, the driver dumps the raw hex for a received event record.
> Improve this by leveraging `struct arm_smmu_event` for event fields
> and log human-readable event records with meaningful information.
> 
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 109 ++++++++++++++++++--
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  13 +++
>  2 files changed, 113 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 2f1108e5de51..4477cf86cb8e 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -83,6 +83,34 @@ static struct arm_smmu_option_prop arm_smmu_options[] = {
>  	{ 0, NULL},
>  };
>  
> +static const char * const event_str[] = {
> +	/* Bad config events */
> +	[EVT_ID_BAD_SID_CONFIG] = "C_BAD_STREAMID",
> +	[EVT_ID_BAD_STE_CONFIG] = "C_BAD_STE",
> +	[EVT_ID_BAD_CD_CONFIG] = "C_BAD_CD",
> +	[EVT_ID_BAD_SSID_CONFIG] = "C_BAD_SUBSTREAMID",
> +	[EVT_ID_STREAM_DISABLED] = "F_STREAM_DISABLED",
> +
> +	/* Bad translation events */
> +	[EVT_ID_TRANSLATION_FAULT] = "F_TRANSLATION",
> +	[EVT_ID_ADDR_SIZE_FAULT] = "F_ADDR_SIZE",
> +	[EVT_ID_ACCESS_FAULT] = "F_ACCESS",
> +	[EVT_ID_PERMISSION_FAULT] = "F_PERMISSION",
> +
> +	/* Bad fetch events */
> +	[EVT_ID_STE_FETCH_FAULT] = "F_STE_FETCH",
> +	[EVT_ID_CD_FETCH_FAULT] = "F_CD_FETCH",
> +	[EVT_ID_VMS_FETCH_FAULT] = "F_VMS_FAULT",
> +	[EVT_ID_MAX] = NULL,
> +};
> +
> +static const char * const event_class_str[] = {
> +	[0] = "CD fetch",
> +	[1] = "Stage 1 translation table fetch",
> +	[2] = "Input address caused fault ",
> +	[3] = "Reserved",
> +};
> +
>  static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
>  				    struct arm_smmu_device *smmu, u32 flags);
>  static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master);
> @@ -1756,6 +1784,60 @@ arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
>  	return rb_entry(node, struct arm_smmu_stream, node)->master;
>  }
>  
> +static void arm_smmu_dump_raw_event(struct arm_smmu_event *event)
> +{
> +	int i;
> +	struct arm_smmu_device *smmu = event->smmu;
> +
> +	dev_err(smmu->dev, "event 0x%02x received: master %s:\n",
> +		event->id, event->master_name);
> +
> +	for (i = 0; i < EVTQ_ENT_DWORDS; ++i)
> +		dev_err(smmu->dev, "\t0x%016llx\n", event->raw[i]);
> +}
> +
> +static void arm_smmu_dump_event(struct arm_smmu_event *evt, struct ratelimit_state *rs)
> +{
> +	struct arm_smmu_device *smmu = evt->smmu;
> +	char title[100] = {0};
> +	char mastr[100] = {0};
> +	char addrs[100] = {0};
> +	char flags[100] = {0};
> +	char other[50] = {0};

I haven't followed previous versions of this series in detail, but
allocating 450 bytes on the stack for this seems excessive to me.

Will
