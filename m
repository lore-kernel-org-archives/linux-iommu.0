Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81592BAF3
	for <iommu@lists.linux.dev>; Fri, 19 Apr 2024 21:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713560848; cv=none; b=sU7FPosvrUAiwJqdfvKCCeTLJUtv48+JsajMBnlm9GO5B2oiMnTj2DiJnXNC/TLKA4IWHn+dnnxYKRkm4mN4J0hwfCarl4MYUYR8vb6HvTK3Li/Ov828q89qc3vXjlpGksX2fHs2s0JRTpKxA8o1CPpkGdiLNFTx+OJh1k1fLEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713560848; c=relaxed/simple;
	bh=zSafTbDer8DxOdKPod5krLtkNnELa3LPcQ3ZbvmwF1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYlE8rQ70jZUQwPiYMUXJgmUvcFBKqYs4hwYCtEVxbpqOtYAK8c0cngGfl+7d/aRs2JuB4vDCkdASnZJCTJjLVjiQreP54T+ASUT8XbK4ox7sJpu1MF8IpMBHmsxicVzyXFc2zaTYsWB/UqGG6MVcijlFTMCdeI/K7bFfndLGDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yZhXvMgY; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yZhXvMgY"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-418820e6effso19705e9.0
        for <iommu@lists.linux.dev>; Fri, 19 Apr 2024 14:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713560844; x=1714165644; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+mFRmA2+vtjCGnJ49FWij0+vJ7sZXnTD59OX7FUL/N8=;
        b=yZhXvMgYpSgCq+XIqOK5fMvHvQ2vlD9Q8iyf8WVEEl84dNVFb2vO9N0z8BWobR5Q8N
         dVBXl8VvgywbwcY9RF3v+AE/vwkv/UkzAKMMm4rRvL045i3Tj1ONW8Rb7pBl4qK4BP5s
         gmKuCa4sJ1kXI8Y40te9Zz5bGNGT3LhwPJ1lHQCfaS6zllF0D347PhLgSOzHVzaWUvgH
         aQRqywVl+8uv7nV2NNeWs047pPiA1v6qU+IyDohQOwBn3C5hxBWPJ+nyKs63GIAnZNRv
         fxV3vK4gh4qOYUHLDCV9jSfEomyWs/5LloiVyipb+DCBhs2DLw3HLc/eCBVB8Ytp7CF9
         T8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713560844; x=1714165644;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+mFRmA2+vtjCGnJ49FWij0+vJ7sZXnTD59OX7FUL/N8=;
        b=ohmGZ5yE75Os6HhvLeUFsdN0St3en1A04nfrclJiJUzRSdvAKpekOciS1y+FqiTN3G
         XYSeMWcsWJZrN0O0OudbLam633szNifciOLaLy3lk5qqKSy00IlbAqxW3tpB2B+2ARdb
         d+Xp/FnduD5JCZyQ0ZbNx0XFRnTvXYGum5DDQ2V7cPAVB3N8FtIupqGivrzUmqTc09AO
         HHz64gr4r/IkVAC6MRGRqAN8zyPG2lz07u0S9MDdc349qHuxmjoixk77C45+bBtg9r5J
         yVCT1/HEVih7ZwQ+YybNm4PH1TqXcC47KnP1GWOhHhoqAbCllN1bOPkKJHBZv8anDapb
         nNtw==
X-Gm-Message-State: AOJu0YxqLPEPILzGUHmuZgxkiuHfL3KjzRHrCG8U6+TKp5BWUqwVANtF
	zHH6B6qf5AeoKrTr1efuR5rvYDahMGJ+zdk38k6Z3VGFxabgme+PzvaywV3u6Q==
X-Google-Smtp-Source: AGHT+IEgmcEf2n6BYNeXMofNMgoEHQ1FVf2q+Yy7Wp6SOBfzoXY702Ztz1K+Qc4eEw/oWXUUf9Df/A==
X-Received: by 2002:a05:600c:4fc7:b0:418:cef2:7575 with SMTP id o7-20020a05600c4fc700b00418cef27575mr53344wmq.0.1713560843921;
        Fri, 19 Apr 2024 14:07:23 -0700 (PDT)
Received: from google.com (180.232.140.34.bc.googleusercontent.com. [34.140.232.180])
        by smtp.gmail.com with ESMTPSA id o28-20020a05600c511c00b0041898fc168bsm11500669wms.36.2024.04.19.14.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 14:07:23 -0700 (PDT)
Date: Fri, 19 Apr 2024 21:07:19 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Eric Auger <eric.auger@redhat.com>, Moritz Fischer <mdf@kernel.org>,
	Moritz Fischer <moritzf@google.com>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>, patches@lists.linux.dev,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v7 2/9] iommu/arm-smmu-v3: Make CD programming use
 arm_smmu_write_entry()
Message-ID: <ZiLdB6nVg9S65Q1G@google.com>
References: <0-v7-cb149db3a320+3b5-smmuv3_newapi_p2_jgg@nvidia.com>
 <2-v7-cb149db3a320+3b5-smmuv3_newapi_p2_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2-v7-cb149db3a320+3b5-smmuv3_newapi_p2_jgg@nvidia.com>

Hi Jason,

On Tue, Apr 16, 2024 at 04:28:13PM -0300, Jason Gunthorpe wrote:
> CD table entries and STE's have the same essential programming sequence,
> just with different types.
> 
> Have arm_smmu_write_ctx_desc() generate a target CD and call
> arm_smmu_write_entry() to do the programming. Due to the way the target CD
> is generated by modifying the existing CD this alone is not enough for the
> CD callers to be freed of the ordering requirements.
> 
> The following patches will make the rest of the CD flow mirror the STE
> flow with precise CD contents generated in all cases.
> 
> Signed-off-by: Michael Shavit <mshavit@google.com>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Tested-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Reviewed-by: Moritz Fischer <moritzf@google.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 94 ++++++++++++++++-----
>  1 file changed, 74 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index bf105e914d38b1..3983de90c2fa01 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -56,6 +56,7 @@ struct arm_smmu_entry_writer_ops {
>  
>  #define NUM_ENTRY_QWORDS 8
>  static_assert(sizeof(struct arm_smmu_ste) == NUM_ENTRY_QWORDS * sizeof(u64));
> +static_assert(sizeof(struct arm_smmu_cd) == NUM_ENTRY_QWORDS * sizeof(u64));
>  
>  static phys_addr_t arm_smmu_msi_cfg[ARM_SMMU_MAX_MSIS][3] = {
>  	[EVTQ_MSI_INDEX] = {
> @@ -1231,6 +1232,67 @@ static struct arm_smmu_cd *arm_smmu_get_cd_ptr(struct arm_smmu_master *master,
>  	return &l1_desc->l2ptr[idx];
>  }
>  
> +struct arm_smmu_cd_writer {
> +	struct arm_smmu_entry_writer writer;
> +	unsigned int ssid;
> +};
> +
> +static void arm_smmu_get_cd_used(const __le64 *ent, __le64 *used_bits)
> +{
> +	used_bits[0] = cpu_to_le64(CTXDESC_CD_0_V);
> +	if (!(ent[0] & cpu_to_le64(CTXDESC_CD_0_V)))
> +		return;
> +	memset(used_bits, 0xFF, sizeof(struct arm_smmu_cd));
> +
> +	/* EPD0 means T0SZ/TG0/IR0/OR0/SH0/TTB0 are IGNORED */
> +	if (ent[0] & cpu_to_le64(CTXDESC_CD_0_TCR_EPD0)) {
> +		used_bits[0] &= ~cpu_to_le64(
> +			CTXDESC_CD_0_TCR_T0SZ | CTXDESC_CD_0_TCR_TG0 |
> +			CTXDESC_CD_0_TCR_IRGN0 | CTXDESC_CD_0_TCR_ORGN0 |
> +			CTXDESC_CD_0_TCR_SH0);
> +		used_bits[1] &= ~cpu_to_le64(CTXDESC_CD_1_TTB0_MASK);
> +	}
> +}
> +
> +static void arm_smmu_cd_writer_sync_entry(struct arm_smmu_entry_writer *writer)
> +{
> +	struct arm_smmu_cd_writer *cd_writer =
> +		container_of(writer, struct arm_smmu_cd_writer, writer);
> +
> +	arm_smmu_sync_cd(writer->master, cd_writer->ssid, true);
> +}
> +
> +static const struct arm_smmu_entry_writer_ops arm_smmu_cd_writer_ops = {
> +	.sync = arm_smmu_cd_writer_sync_entry,
> +	.get_used = arm_smmu_get_cd_used,
> +	.v_bit = cpu_to_le64(CTXDESC_CD_0_V),
> +};
> +
> +static void arm_smmu_write_cd_entry(struct arm_smmu_master *master, int ssid,
> +				    struct arm_smmu_cd *cdptr,
> +				    const struct arm_smmu_cd *target)
> +{
> +	struct arm_smmu_cd_writer cd_writer = {
> +		.writer = {
> +			.ops = &arm_smmu_cd_writer_ops,
> +			.master = master,
> +		},
> +		.ssid = ssid,
> +	};
> +
> +	arm_smmu_write_entry(&cd_writer.writer, cdptr->data, target->data);
> +}
> +
> +static void arm_smmu_clean_cd_entry(struct arm_smmu_cd *target)
> +{
> +	struct arm_smmu_cd used = {};
> +	int i;
> +
> +	arm_smmu_get_cd_used(target->data, used.data);
> +	for (i = 0; i != ARRAY_SIZE(target->data); i++)
> +		target->data[i] &= used.data[i];
> +}
> +
>  int arm_smmu_write_ctx_desc(struct arm_smmu_master *master, int ssid,
>  			    struct arm_smmu_ctx_desc *cd)
>  {
> @@ -1247,17 +1309,20 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_master *master, int ssid,
>  	 */
>  	u64 val;
>  	bool cd_live;
> -	struct arm_smmu_cd *cdptr;
> +	struct arm_smmu_cd target;
> +	struct arm_smmu_cd *cdptr = &target;
> +	struct arm_smmu_cd *cd_table_entry;
>  	struct arm_smmu_ctx_desc_cfg *cd_table = &master->cd_table;
>  	struct arm_smmu_device *smmu = master->smmu;
>  
>  	if (WARN_ON(ssid >= (1 << cd_table->s1cdmax)))
>  		return -E2BIG;
>  
> -	cdptr = arm_smmu_get_cd_ptr(master, ssid);
> -	if (!cdptr)
> +	cd_table_entry = arm_smmu_get_cd_ptr(master, ssid);
> +	if (!cd_table_entry)
>  		return -ENOMEM;
>  
> +	target = *cd_table_entry;

As this changes the logic where all CD manipulation is not on the actual
CD, I believe a comment would be helpful here.

>  	val = le64_to_cpu(cdptr->data[0]);
>  	cd_live = !!(val & CTXDESC_CD_0_V);
>  
> @@ -1279,13 +1344,6 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_master *master, int ssid,
>  		cdptr->data[2] = 0;
>  		cdptr->data[3] = cpu_to_le64(cd->mair);
>  
> -		/*
> -		 * STE may be live, and the SMMU might read dwords of this CD in any
> -		 * order. Ensure that it observes valid values before reading
> -		 * V=1.
> -		 */
> -		arm_smmu_sync_cd(master, ssid, true);
> -
>  		val = cd->tcr |
>  #ifdef __BIG_ENDIAN
>  			CTXDESC_CD_0_ENDI |
> @@ -1299,18 +1357,14 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_master *master, int ssid,
>  		if (cd_table->stall_enabled)
>  			val |= CTXDESC_CD_0_S;
>  	}
> -
> +	cdptr->data[0] = cpu_to_le64(val);
>  	/*
> -	 * The SMMU accesses 64-bit values atomically. See IHI0070Ca 3.21.3
> -	 * "Configuration structures and configuration invalidation completion"
> -	 *
> -	 *   The size of single-copy atomic reads made by the SMMU is
> -	 *   IMPLEMENTATION DEFINED but must be at least 64 bits. Any single
> -	 *   field within an aligned 64-bit span of a structure can be altered
> -	 *   without first making the structure invalid.
> +	 * Since the above is updating the CD entry based on the current value
> +	 * without zeroing unused bits it needs fixing before being passed to
> +	 * the programming logic.
>  	 */
> -	WRITE_ONCE(cdptr->data[0], cpu_to_le64(val));
> -	arm_smmu_sync_cd(master, ssid, true);
> +	arm_smmu_clean_cd_entry(&target);

I am not sure I understand the logic here, is that only needed for entry[0]
As I see the other entries are set and not reused.

If so, I think it’d be better to make that clear, also as used_bits are always 0xff
for all cases, I believe the EPD0 logic should be integrated in populating the CD so
it is correct by construction, as this looks like a hack to me.

Thanks,
Mostafa

> +	arm_smmu_write_cd_entry(master, ssid, cd_table_entry, &target);
>  	return 0;
>  }
>  
> -- 
> 2.43.2
> 
