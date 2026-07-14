Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981F135F615
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 09:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784021736; cv=none; b=sXwMty6P8FwmT2NsL7dp5Ux5glQ/gc/xcnXkQu6ci8gYo+4nOPFJ32DEVg9k03mInJYdsgG0pqEGNZLhvKIxvMPpTezZnUfBBDbUC874WxrXqkSQN8j8Kt8VvFhD5B0LwsXp9T63+fbWmz9tCrs210VYbm6OEJmIzOVhctuzejI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784021736; c=relaxed/simple;
	bh=ThL1lc2C1CByqAkMxga1gs4NxnYeMyI7TMPTnx6GawM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XaspiKEQ0q691m3KKUOuA3zYuJR1D1zPf4g8dbdjmS+5kKn6aKb5VCH3OersOXgCfWZ4skKJAwxgUsrSLlhOGe9oNry6a7U06eFNKlYXJ5M13PtUOOicTVyMosaga3pVJ9RP5gf0y+7j0Qsid79fjAqrgrtILzaAz4+iJMcL3M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hNkxyG62; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hNkxyG62"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cacef7d299so100065ad.1
        for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 02:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784021733; x=1784626533; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vUKlUnNnjTDGTuu1C5RXT6PIBw9dHeOVmZfnMpoGDeI=;
        b=hNkxyG62S0zOtQz0V4vSgLR0ZvUVkInW+AjVPmjwqk3eQJOy1dgsn02W1kUpe7MPxG
         GO92CovfvPb6pF4TolueoF8lavWp9Jvu9XM2V3sLn84srhKRfImtKpbz22ePUS8Gzxj3
         6b07KZVTut0r1r3Mb3b1iGSMRWwPKj41LBn2WIWmcXm9CIEu/Nxsxir8SU610h+7+75H
         smmURfQFjVZljdgqfB/Vy9jB18uDuzTkHkUx6j2vORe3lU3zUfvhApczvc5fq6EP2TsS
         3Nl/k2EZto+Z/FAPQTfYdEIMbADiOEZcYuG6Fh3NTLjU298byMB+1qmlSVn8r+K+WBkw
         8QIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784021733; x=1784626533;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vUKlUnNnjTDGTuu1C5RXT6PIBw9dHeOVmZfnMpoGDeI=;
        b=f5HQWa7iL3Z91+K2uW7tqXqaUGRDIy635p2EACQ24qbFqzh7/lU2mQnfb3D7JG4YmX
         gbvCr85jJoCXOo6PspoHQHbNlJzkmQW4vFSHjFfHFX5VqvEJRcfDos2tFuFEOVF0ERrh
         nGFehzdwj8cpjC8kO2O71I+kofENVIwBUGTzJbB19W4qbZR5qTmj0oNYWeaQCjInmq0i
         mlaKFSeDuOMlbqJGLj1GvtvV3vQt8l8JBFxdaF1tg3VQ8eBwkA8PqCIWDRorSPDp0FeR
         iQ3t4hRcn5VF9I/SKkP6aI/m3NZWMyG9G8eDNGnxCj292nnIZWDp/uYHDLUt/xAEaoaF
         3eTA==
X-Forwarded-Encrypted: i=1; AHgh+Rpbrbho13jIscMesuoW0zjeKIu6qmWSRIV1VjIDRaYVBXS54eA1I93GXQSkDEUhBkd4bIG4Ig==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzj4tPkU2UzTyZ/2ybfKAXbzBwL+oUE5h8tPpbs/D7g+SyltYa9
	0HgE/fCEUOEBjQuyftNNX+9HDoMbt0ubCec/Oc3ZGs7L6anx3kx3+yIz+JA9AHQOzg==
X-Gm-Gg: AfdE7ck/C+TJKz55dbwW0cgeDy8U09f1ryBDJgu6cdkTPmd7uWVYfTw69HC/EaLbjPh
	wMb7GNSasy7eAFqMaPAJ9CHkHVcIevdSs4TZhKBht47CzS/m0F9QIMagdAgPbFDkpHliHgKlnRA
	zfg00L6hZ6UzMclcQ2Gitzgd26cbYl1uZXuhXnNV7SLbdgT88nHtG/ZV+LyWNkLo8frOYiPt7qk
	bDazVQURcpTiaGfXemiVd7AyXAWMe7fb89CD67Poi1i0CLhqgSBiJ33p0cmAbToGkk+WZ46+z6R
	DSzHB25znA16cEA3vi/LyqfCLTGlRThWcYruZAfvRCr/kBr60zDBvOkMpHYDGtN5fB8fmpDbLf8
	79JujcGgkSqM5v4AV+J/Wxi16heBBbuYMF/1c7CJr10jgrXeff+rc+drOkKd3cojWBRQl/C0mYq
	QGBCnJTH1DQc5CAqYJttRzr/Y96m1LULG2cWtlOBoehcXQ5CIHbw0OCi+nHg==
X-Received: by 2002:a17:903:3884:b0:2c7:df7a:859a with SMTP id d9443c01a7336-2cee1c0873emr4817105ad.15.1784021732237;
        Tue, 14 Jul 2026 02:35:32 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38d302d5982sm4287247a91.2.2026.07.14.02.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 02:35:31 -0700 (PDT)
Date: Tue, 14 Jul 2026 09:35:25 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
	David Woodhouse <dwmw2@infradead.org>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] iommu/arm-smmu-v3-iommufd: Reject unsupported
 bits in invalidation commands
Message-ID: <alYC3bNbXY9l0eVn@google.com>
References: <cover.1783539724.git.nicolinc@nvidia.com>
 <194fec44b30b7b4233d218686cd76d63208932ff.1783539724.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <194fec44b30b7b4233d218686cd76d63208932ff.1783539724.git.nicolinc@nvidia.com>

On Wed, Jul 08, 2026 at 12:44:16PM -0700, Nicolin Chen wrote:
> The arm_vsmmu_cache_invalidate() op hands a guest's invalidation commands
> to the trusted main command queue after enforcing only the VMID or the SID,
> and passes the rest of the command through to the queue unchanged.
> 
> That lets a guest set bits the host never meant to forward: a reserved or
> undefined bit makes a command malformed; per the Arm SMMUv3 specification,
> in its section 4.1.3 "Command errors", a CERROR_ILL is raised, among other
> cases, when:
> 
>   A valid command opcode is used and a Reserved or undefined field is
>   optionally detected as non-zero, which results in the command being
>   treated as malformed.
> 
> Restrict each opcode to the fields that the driver supports and reject the
> command with -EIO if it sets any other bit, before the command reaches the
> queue. This stops the host from forwarding any bit whose meaning it does
> not control. Document this contract in the uAPI header, so user space must
> take the responsibility to forward valid commands only.
> 
> Some fields and whole opcodes are legal only on an SMMU that implements
> the matching feature, so accept them conditionally:
> 
>  - NUM, SCALE, TG and TTL need FEAT_RANGE_INV.
>  - SCALE bit 25, for values above 31, and TTL == 0b01 with a 16KB TG
>    need SMMU_IDR5.DS. The raw IDR5 that iommufd reports has let a VMM
>    expose DS to its guest all along, so add the minimal ARM_SMMU_FEAT_DS
>    detection and gate the two encodings on it, rather than regress such
>    a VMM by rejecting them unconditionally. Widening the SCALE field
>    does not change what the host emits in the range invalidation path,
>    which now masks its scale value explicitly to keep the pre-existing
>    5-bit truncation.
>  - ASID is limited to asid_bits, since its upper 8 bits are RES0 on an
>    SMMU that only supports 8-bit ASIDs.
>  - ATC_INV needs FEAT_ATS. Per the specification's section 4.5 "ATS and
>    PRI", CMD_ATC_INV is ILLEGAL when:
> 
>      SMMU_IDR0.ATS == 0 and this command is issued on a Non-secure or
>      Secure Command queue.
> 
>  - SSV, SSID and Global need a non-zero ssid_bits. Without it, setting
>    them is not illegal but CONSTRAINED UNPREDICTABLE, which a guest
>    should not be able to provoke. Global also takes effect only when
>    SSV == 1, broadening the invalidation from the one SSID to all the
>    PASIDs of the single device that the SID field addresses.
> 
> Some values inside the accepted fields are Reserved too:
> 
>  - NUM == 0, SCALE == 0 and TTL == 0 together are a Reserved combination
>    and cause a CERROR_ILL.
>  - NUM, SCALE and TTL turn RES0 when TG == 0.
>  - An ATC_INV Size above 52, the invalidate-all span, is permitted to
>    raise a CERROR_ILL.
> 
> Reject these Reserved values the same way. In contrast, an out-of-range
> address or ID value is defined as CONSTRAINED UNPREDICTABLE that would
> be scoped to the guest itself, so it does not deserve a check.
> 
> Fixes: d68beb276ba2 ("iommu/arm-smmu-v3: Support IOMMU_HWPT_INVALIDATE using a VIOMMU object")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   4 +-
>  include/uapi/linux/iommufd.h                  |   4 +-
>  .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 116 ++++++++++++++++--
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |   6 +-
>  4 files changed, 116 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index c909c9a88538b..3c59e62978a13 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -64,6 +64,7 @@ struct arm_vsmmu;
>  
>  #define ARM_SMMU_IDR5			0x14
>  #define IDR5_STALL_MAX			GENMASK(31, 16)
> +#define IDR5_DS				(1 << 7)
>  #define IDR5_GRAN64K			(1 << 6)
>  #define IDR5_GRAN16K			(1 << 5)
>  #define IDR5_GRAN4K			(1 << 4)
> @@ -415,7 +416,7 @@ struct arm_smmu_cmd {
>  
>  #define CMDQ_TLBI_0_NUM			GENMASK_ULL(16, 12)
>  #define CMDQ_TLBI_RANGE_NUM_MAX		31
> -#define CMDQ_TLBI_0_SCALE		GENMASK_ULL(24, 20)
> +#define CMDQ_TLBI_0_SCALE		GENMASK_ULL(25, 20)
>  #define CMDQ_TLBI_0_VMID		GENMASK_ULL(47, 32)
>  #define CMDQ_TLBI_0_ASID		GENMASK_ULL(63, 48)
>  #define CMDQ_TLBI_1_LEAF		(1UL << 0)
> @@ -921,6 +922,7 @@ struct arm_smmu_device {
>  #define ARM_SMMU_FEAT_HD		(1 << 22)
>  #define ARM_SMMU_FEAT_S2FWB		(1 << 23)
>  #define ARM_SMMU_FEAT_BBML2		(1 << 24)
> +#define ARM_SMMU_FEAT_DS		(1 << 25)
>  	u32				features;
>  

This should probably be a separate patch clubbed with the IDR5_DS
detection. Something like "Support IDR5.DS and widen TLBI SCALE field"
(Sorry for being nitpicky, but such distinct commits help track history
better).

>  #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index 0425d452d41ed..691b810ca574f 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -909,7 +909,9 @@ struct iommu_hwpt_vtd_s1_invalidate {
>   *     CMDQ_OP_CFGI_CD
>   *     CMDQ_OP_CFGI_CD_ALL
>   *
> - * -EIO will be returned if the command is not supported.
> + * User space must forward only valid commands: the kernel rejects, with
> + * -EIO, any command carrying an unsupported opcode, an unsupported field,
> + * or a field value that the underlying SMMU hardware does not implement.
>   */
>  struct iommu_viommu_arm_smmuv3_invalidate {
>  	__aligned_le64 cmd[2];
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> index 1e9f7d2de3441..a5cfbc2499034 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> @@ -305,6 +305,26 @@ struct arm_vsmmu_invalidation_cmd {
>  	};
>  };
>  
> +/* Reject the range field values that the spec defines as Reserved */
> +static int arm_vsmmu_validate_range(struct arm_smmu_device *smmu,
> +				    struct arm_vsmmu_invalidation_cmd *cmd)
> +{
> +	bool range = cmd->cmd.data[0] & (CMDQ_TLBI_0_NUM | CMDQ_TLBI_0_SCALE);

Nit: Prefer range = !! (cmd->cmd.data[0] & CMDQ_TLBI ...) for bool.

> +	u8 ttl = FIELD_GET(CMDQ_TLBI_1_TTL, cmd->cmd.data[1]);
> +	u8 tg = FIELD_GET(CMDQ_TLBI_1_TG, cmd->cmd.data[1]);
> +
> +	/* NUM, SCALE and TTL are RES0 when TG == 0 */
> +	if (!tg)
> +		return (range || ttl) ? -EIO : 0;
> +	/* TTL == 0b01 with a 16KB TG requires SMMU_IDR5.DS */
> +	if (tg == 2 && ttl == 1 && !(smmu->features & ARM_SMMU_FEAT_DS))

I agree we must check this but I'm a little confused, How is a user /
VMM depending on the IDR5.DS bit today? The IDR5 is exposed to the user
via hw_info AND in the uAPI documentation block we explicitly mention 
for struct iommu_hw_info_arm_smmuv3 the following valid fields for IDR5:

idr[5]: VAX, GRAN64K, GRAN16K, GRAN4K

Thus, no obedient user should be trying to use the DS bit features today.
Are we aware of any users/VMMs that have been ignoring the documentation
and relying on the raw bit? If so, does this DS protection need to be 
separated into an -rc fix for stable trees?

Regarding this series, since we are formally adding support for the DS 
bit in this series for range invalidations (preferably as a separate 
patch as mentioned above). We should also update the uAPI doc for struct
iommu_hw_info_arm_smmuv3 in include/uapi/linux/iommufd.h? Like:

* idr[5]: VAX, GRAN64K, GRAN16K, GRAN4K, DS

> +		return -EIO;
> +	/* NUM == 0, SCALE == 0 with TTL == 0 is a reserved combination */
> +	if (!range && !ttl)
> +		return -EIO;
> +	return 0;
> +}
> +
>  /*
>   * Convert, in place, the raw invalidation command into an internal format that
>   * can be passed to arm_smmu_cmdq_issue_cmdlist(). Internally commands are
> @@ -315,33 +335,107 @@ struct arm_vsmmu_invalidation_cmd {
>  static int arm_vsmmu_convert_user_cmd(struct arm_vsmmu *vsmmu,
>  				      struct arm_vsmmu_invalidation_cmd *cmd)
>  {
> +	struct arm_smmu_device *smmu = vsmmu->smmu;
> +	u64 allowed[2] = { CMDQ_0_OP };
> +	u64 *data = cmd->cmd.data;
> +
>  	/* Commands are le64 stored in u64 */
> -	cmd->cmd.data[0] = le64_to_cpu(cmd->ucmd.cmd[0]);
> -	cmd->cmd.data[1] = le64_to_cpu(cmd->ucmd.cmd[1]);
> +	data[0] = le64_to_cpu(cmd->ucmd.cmd[0]);
> +	data[1] = le64_to_cpu(cmd->ucmd.cmd[1]);
> +
> +	/* Collect the fields userspace is allowed to set for each opcode */
> +	switch (data[0] & CMDQ_0_OP) {
> +	case CMDQ_OP_TLBI_NH_VA:
> +		/* An SMMU with 8-bit ASIDs treats the upper 8 bits as RES0 */
> +		allowed[0] |= FIELD_PREP(CMDQ_TLBI_0_ASID,
> +					 GENMASK(smmu->asid_bits - 1, 0));
> +		fallthrough;
> +	case CMDQ_OP_TLBI_NH_VAA:
> +		/* NUM/SCALE/TG/TTL are range fields gated on FEAT_RANGE_INV */
> +		if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
> +			if (arm_vsmmu_validate_range(smmu, cmd))
> +				return -EIO;
> +			allowed[0] |= CMDQ_TLBI_0_NUM | CMDQ_TLBI_0_SCALE;
> +			allowed[1] |= CMDQ_TLBI_1_TG | CMDQ_TLBI_1_TTL;
> +			/* SCALE bit 25 (values above 31) is RES0 without DS */
> +			if (!(smmu->features & ARM_SMMU_FEAT_DS))
> +				allowed[0] &= ~FIELD_PREP(CMDQ_TLBI_0_SCALE,
> +							  BIT(5));
> +		}
> +		allowed[0] |= CMDQ_TLBI_0_VMID;
> +		allowed[1] |= CMDQ_TLBI_1_LEAF | CMDQ_TLBI_1_VA_MASK;
> +		break;
> +	case CMDQ_OP_TLBI_NH_ASID:
> +		/* An SMMU with 8-bit ASIDs treats the upper 8 bits as RES0 */
> +		allowed[0] |= FIELD_PREP(CMDQ_TLBI_0_ASID,
> +					 GENMASK(smmu->asid_bits - 1, 0));
> +		fallthrough;
> +	case CMDQ_OP_TLBI_NH_ALL:
> +		allowed[0] |= CMDQ_TLBI_0_VMID;
> +		break;
> +	case CMDQ_OP_ATC_INV:
> +		/* ATC_INV is illegal unless the SMMU implements ATS */
> +		if (!(smmu->features & ARM_SMMU_FEAT_ATS))
> +			return -EIO;
> +		/* A Size above 52 (invalidate-all) may raise a CERROR_ILL */
> +		if (FIELD_GET(CMDQ_ATC_1_SIZE, data[1]) > ATC_INV_SIZE_ALL)
> +			return -EIO;
> +		/*
> +		 * SSV/SSID/Global need substream support. SSID and Global are
> +		 * IGNORED (not RES0) when SSV == 0, so they need no SSV check.
> +		 */
> +		if (smmu->ssid_bits)
> +			allowed[0] |= CMDQ_0_SSV | CMDQ_ATC_0_SSID |
> +				      CMDQ_ATC_0_GLOBAL;
> +		allowed[0] |= CMDQ_ATC_0_SID;
> +		allowed[1] |= CMDQ_ATC_1_SIZE | CMDQ_ATC_1_ADDR_MASK;
> +		break;
> +	case CMDQ_OP_CFGI_CD:
> +		/* No SSV for CFGI_CD; SSID requires substream support */
> +		if (smmu->ssid_bits)
> +			allowed[0] |= CMDQ_CFGI_0_SSID;
> +		allowed[1] |= CMDQ_CFGI_1_LEAF;
> +		fallthrough;
> +	case CMDQ_OP_CFGI_CD_ALL:
> +		allowed[0] |= CMDQ_CFGI_0_SID;
> +		break;
> +	}
> +
> +	/*
> +	 * Reject any other bit, e.g. a RES0 bit or a Secure bit, before the
> +	 * command reaches the trusted main cmdq, so a guest cannot wedge the
> +	 * shared queue for every device with a CERROR_ILL.
> +	 *
> +	 * By contrast, an out-of-range address or ID value does not need a
> +	 * check: the spec defines it as CONSTRAINED UNPREDICTABLE, which is
> +	 * scoped to the guest itself and does not raise a CERROR_ILL.
> +	 */
> +	if ((data[0] & ~allowed[0]) || (data[1] & ~allowed[1]))
> +		return -EIO;
>

Could we split the validation logic into it's own helper function?
That way the helper does arch validation and this function converts the
cmd. That'd make it easier to add new opcodes in the future and improve
readability as well. Something along these lines:

static int arm_vsmmu_validate_user_cmd(struct arm_vsmmu *vsmmu, u64 data[2])
{
    struct arm_smmu_device *smmu = vsmmu->smmu;
    u64 allowed[2] = { CMDQ_0_OP };

    /* Collect the fields userspace is allowed to set for each opcode */
    switch (data[0] & CMDQ_0_OP) {
    case CMDQ_OP_TLBI_NH_VA:
    /* ... (all the allowlist logic) ... */
    }

    /*
     * Reject any other bit, e.g. a RES0 bit or a Secure bit...
     */
    if ((data[0] & ~allowed[0]) || (data[1] & ~allowed[1]))
        return -EIO;

    return 0;
}

static int arm_vsmmu_convert_user_cmd(struct arm_vsmmu *vsmmu,
                      struct arm_vsmmu_invalidation_cmd *cmd)
{
    u64 *data = cmd->cmd.data;
    int ret;

    /* Commands are le64 stored in u64 */
    data[0] = le64_to_cpu(cmd->ucmd.cmd[0]);
    data[1] = le64_to_cpu(cmd->ucmd.cmd[1]);

    ret = arm_vsmmu_validate_user_cmd(vsmmu, data);
    if (ret)
        return ret;

    /* Command Transformation */
    switch (data[0] & CMDQ_0_OP) {
    case CMDQ_OP_TLBI_NSNH_ALL:
    /* ... (VMID/SID patching) ... */
    }

    return 0;
}

Apart from that, the arch checks/allowlisting logic looks good.

> -	switch (cmd->cmd.data[0] & CMDQ_0_OP) {
> +	switch (data[0] & CMDQ_0_OP) {
>  	case CMDQ_OP_TLBI_NSNH_ALL:
>  		/* Convert to NH_ALL */
> -		cmd->cmd.data[0] = CMDQ_OP_TLBI_NH_ALL |
> -			      FIELD_PREP(CMDQ_TLBI_0_VMID, vsmmu->vmid);
> -		cmd->cmd.data[1] = 0;
> +		data[0] = CMDQ_OP_TLBI_NH_ALL |
> +			  FIELD_PREP(CMDQ_TLBI_0_VMID, vsmmu->vmid);
> +		data[1] = 0;
>  		break;
>  	case CMDQ_OP_TLBI_NH_VA:
>  	case CMDQ_OP_TLBI_NH_VAA:
>  	case CMDQ_OP_TLBI_NH_ALL:
>  	case CMDQ_OP_TLBI_NH_ASID:
> -		cmd->cmd.data[0] &= ~CMDQ_TLBI_0_VMID;
> -		cmd->cmd.data[0] |= FIELD_PREP(CMDQ_TLBI_0_VMID, vsmmu->vmid);
> +		data[0] &= ~CMDQ_TLBI_0_VMID;
> +		data[0] |= FIELD_PREP(CMDQ_TLBI_0_VMID, vsmmu->vmid);
>  		break;
>  	case CMDQ_OP_ATC_INV:
>  	case CMDQ_OP_CFGI_CD:
>  	case CMDQ_OP_CFGI_CD_ALL: {
> -		u32 sid, vsid = FIELD_GET(CMDQ_CFGI_0_SID, cmd->cmd.data[0]);
> +		u32 sid, vsid = FIELD_GET(CMDQ_CFGI_0_SID, data[0]);
>  
>  		if (arm_vsmmu_vsid_to_sid(vsmmu, vsid, &sid))
>  			return -EIO;
> -		cmd->cmd.data[0] &= ~CMDQ_CFGI_0_SID;
> -		cmd->cmd.data[0] |= FIELD_PREP(CMDQ_CFGI_0_SID, sid);
> +		data[0] &= ~CMDQ_CFGI_0_SID;
> +		data[0] |= FIELD_PREP(CMDQ_CFGI_0_SID, sid);
>  		break;
>  	}
>  	default:
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index a10affb483a4f..9f121f9f404ea 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2446,9 +2446,10 @@ static void arm_smmu_cmdq_batch_add_range(struct arm_smmu_device *smmu,
>  			/* Determine how many chunks of 2^scale size we have */
>  			num = (num_pages >> scale) & CMDQ_TLBI_RANGE_NUM_MAX;
>  
> +			/* Keep the pre-DS 5-bit truncation when scale > 31 */
>  			cmd->data[0] = orig_data0 |
>  				FIELD_PREP(CMDQ_TLBI_0_NUM, num - 1) |
> -				FIELD_PREP(CMDQ_TLBI_0_SCALE, scale);
> +				FIELD_PREP(CMDQ_TLBI_0_SCALE, scale & 0x1f);
>  
>  			/* range is num * 2^scale * pgsize */
>  			inv_range = num << (scale + tg);
> @@ -5098,6 +5099,9 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>  	/* Maximum number of outstanding stalls */
>  	smmu->evtq.max_stalls = FIELD_GET(IDR5_STALL_MAX, reg);
>  
> +	if (reg & IDR5_DS)
> +		smmu->features |= ARM_SMMU_FEAT_DS;
> +

Same as above, let's break DS support into a separate patch.

>  	/* Page sizes */
>  	if (reg & IDR5_GRAN64K)
>  		smmu->pgsize_bitmap |= SZ_64K | SZ_512M;
> -- 
> 2.43.0
> 
> 

Thanks,
Praan
