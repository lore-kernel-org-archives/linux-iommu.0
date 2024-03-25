Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FDD5B1E8
	for <iommu@lists.linux.dev>; Mon, 25 Mar 2024 21:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711400481; cv=none; b=QVLO/kg6eQAKp1lWxu03sn83gSIDQHnVRKpO/l12Ns7TB1MAc3DBkcTd3QWidLYCG5CPDL4TsV5O7TEj5BryX04OcR0gZ/yP3YXrZ41sY3W3BCg7MXHekNOsI1jd8sWthgQHY5U+pSmyrdBsrkybNRnubaZyTUk29LFt5KgrWPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711400481; c=relaxed/simple;
	bh=ZrvNaSQpio37WJx1/1lHRbAENb/ZzWXOqMOiPrnKiJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HiCMPUZRQtnvlSE8YUCM/mR3O6gBmhBRuOIkhF6TrTlQw8tK6ETXihy6qHlyo+dVDi1VVEm9oLarUArNqwRGtyEsLrpH1GNo6JAOW+H4nzNj//axQZQFUX0vVRL6kQeKNcetLC5MoDAHDCNQaN3dARKVzPypMw6ljcQr6kdPRqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uKAFxkA5; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uKAFxkA5"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4148c09ec6bso5845e9.1
        for <iommu@lists.linux.dev>; Mon, 25 Mar 2024 14:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711400478; x=1712005278; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hYzMTzG76jpXXtR/0jOj7ycyCch1YdLUEqtA0Q2kJns=;
        b=uKAFxkA5tb4X825ygkPmzXF9xf5NiaoPY8SrYVaz5Ad7eLPQNTpoOBUCkFC3L2D7Zw
         MFFEyMen+OOGwH1+dQmSGhSlhDDJuVl/0IJUc18zBDceVaGls+yWcRyFrwCfXsVQKIdr
         j430sTzXjn03Ms5IkFPCh5qW94gtaKsL+fAbOdV/ezDQpUMFIWzc/XFqJAHoUIUIK93c
         8LY5NGXp6rsp4KoEjL4KFz/E36s6K9zIDkg/TsVQaI0iSk3kWyJrPXQ6HT3IoUHwmhIY
         UOHtPesQaHrNqWJ0hLO4aiUiMFl5RqebZz1TbWWJrzWMFldeqMYjmzggwD8S+/7rxObV
         4LWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711400478; x=1712005278;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hYzMTzG76jpXXtR/0jOj7ycyCch1YdLUEqtA0Q2kJns=;
        b=wq+SgTtcQRwNSeU3BQyR9mrySFawc+LQcOZ+C+uvQFH0kdCaxFiG86m5EmNybdpHNG
         6cVrL8GSRXNZjeAZkEMA8VEJKr0GeUvcubkqpvEMhV7xW40kU644ZeCB3AoMMKKuf1zW
         0fY11Tz9fgUI4NnMuBWpr+U35w6WmkSZl3sxwzMGwICF1l2BKtqhuzsELPDlZlcFXHk/
         92RIQ9DRanoXgJZpMDq1riiSvPr1jrd+QlzzjqKtCahB+mzYYhhmr0AViWEJ95fVnst8
         nzjo3INkOj+jc1HNEMexMjqsLQeOr9+V2YUOWU5bPwe0ssAIsX+PBPlVNqz+CaU/6mJI
         P5Aw==
X-Gm-Message-State: AOJu0YyRB2/Vy+Fszt+xb/QjmoKnMONfh7cc37FZ16Dse+tJ93Ro7Ws9
	5kWUk9WzJZB94l8KcItWypaOrgd23FgCEBWCrQ+Z41sPpSoWNoOV4CoOlYVvCw==
X-Google-Smtp-Source: AGHT+IH0RK7M14lG8X+xGmmxWIzwMNfLP7hfCwPVIxCthT5HX5RV8W05k3kUnWTtVb8NaUxXC32pVA==
X-Received: by 2002:a05:600c:1ca5:b0:414:381:ad5f with SMTP id k37-20020a05600c1ca500b004140381ad5fmr15682wms.7.1711400478034;
        Mon, 25 Mar 2024 14:01:18 -0700 (PDT)
Received: from google.com (180.232.140.34.bc.googleusercontent.com. [34.140.232.180])
        by smtp.gmail.com with ESMTPSA id o32-20020a05600c512000b004148a5e3188sm3377606wms.25.2024.03.25.14.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 14:01:17 -0700 (PDT)
Date: Mon, 25 Mar 2024 21:01:13 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Eric Auger <eric.auger@redhat.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Moritz Fischer <mdf@kernel.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>, patches@lists.linux.dev,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v5 04/27] iommu/arm-smmu-v3: Add an ops indirection to
 the STE code
Message-ID: <ZgHmGbZ4mSrbhUI3@google.com>
References: <0-v5-9a37e0c884ce+31e3-smmuv3_newapi_p2_jgg@nvidia.com>
 <4-v5-9a37e0c884ce+31e3-smmuv3_newapi_p2_jgg@nvidia.com>
 <Zf3KgGj4Tfc8ytgi@google.com>
 <20240325141132.GA110546@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240325141132.GA110546@nvidia.com>

On Mon, Mar 25, 2024 at 11:11:32AM -0300, Jason Gunthorpe wrote:
> On Fri, Mar 22, 2024 at 06:14:24PM +0000, Mostafa Saleh wrote:
> > > @@ -1027,57 +1038,55 @@ static void arm_smmu_get_ste_used(const struct arm_smmu_ste *ent,
> > >   * unused_update is an intermediate value of entry that has unused bits set to
> > >   * their new values.
> > >   */
> > > -static u8 arm_smmu_entry_qword_diff(const struct arm_smmu_ste *entry,
> > > -				    const struct arm_smmu_ste *target,
> > > -				    struct arm_smmu_ste *unused_update)
> > > +static u8 arm_smmu_entry_qword_diff(struct arm_smmu_entry_writer *writer,
> > > +				    const __le64 *entry, const __le64 *target,
> > > +				    __le64 *unused_update)
> > >  {
> > > -	struct arm_smmu_ste target_used = {};
> > > -	struct arm_smmu_ste cur_used = {};
> > > +	__le64 target_used[NUM_ENTRY_QWORDS] = {};
> > > +	__le64 cur_used[NUM_ENTRY_QWORDS] = {};
> > This is confusing to me, the function was modified to be generic, so its has
> > args are __le64 * instead of struct arm_smmu_ste *.
> 
> Right
> 
> > But NUM_ENTRY_QWORDS is defined as “(sizeof(struct arm_smmu_ste) / sizeof(u64))”
> > and in the same function writer->ops->num_entry_qwords is used
> > nterchangeably,
> 
> Right
> 
> > I understand that this not a constant and the compiler would complain.
> > But since for any other num_entry_qwords larger than NUM_ENTRY_QWORDS it fails,
> > and we know STEs and CDs both have the same size, we simplify the code and make
> > it a constant everywhere.
> 
> So you say to get rid of num_entry_qwords and just use the constant?

In my opinion, yes, that looks easier to understand, and avoids the MAX
stuff as there is no reason for the extra generalisation.

> > I see in the next patch, that this is redefined to be the max between STE and
> > CD, but again, this hardware and it never changes, so my opinion is to simplify
> > the code, as there is no need to generalize this part.
> 
> Yes, we need a constant.
> 
> It would look like this, it is a little bit simpler:
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index a54062faccde38..d015f41900d802 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -63,9 +63,9 @@ enum arm_smmu_msi_index {
>  	ARM_SMMU_MAX_MSIS,
>  };
>  
> -#define NUM_ENTRY_QWORDS                                                \
> -	(max(sizeof(struct arm_smmu_ste), sizeof(struct arm_smmu_cd)) / \
> -	 sizeof(u64))
> +#define NUM_ENTRY_QWORDS 8
> +static_assert(sizeof(struct arm_smmu_ste) == NUM_ENTRY_QWORDS * sizeof(u64));
> +static_assert(sizeof(struct arm_smmu_cd) == NUM_ENTRY_QWORDS * sizeof(u64));
>  
>  static phys_addr_t arm_smmu_msi_cfg[ARM_SMMU_MAX_MSIS][3] = {
>  	[EVTQ_MSI_INDEX] = {
> @@ -1045,7 +1045,7 @@ static u8 arm_smmu_entry_qword_diff(struct arm_smmu_entry_writer *writer,
>  	writer->ops->get_used(entry, cur_used);
>  	writer->ops->get_used(target, target_used);
>  
> -	for (i = 0; i != writer->ops->num_entry_qwords; i++) {
> +	for (i = 0; i != NUM_ENTRY_QWORDS; i++) {
>  		/*
>  		 * Check that masks are up to date, the make functions are not
>  		 * allowed to set a bit to 1 if the used function doesn't say it
> @@ -1114,7 +1114,6 @@ static bool entry_set(struct arm_smmu_entry_writer *writer, __le64 *entry,
>  void arm_smmu_write_entry(struct arm_smmu_entry_writer *writer, __le64 *entry,
>  			  const __le64 *target)
>  {
> -	unsigned int num_entry_qwords = writer->ops->num_entry_qwords;
>  	__le64 unused_update[NUM_ENTRY_QWORDS];
>  	u8 used_qword_diff;
>  
> @@ -1137,9 +1136,9 @@ void arm_smmu_write_entry(struct arm_smmu_entry_writer *writer, __le64 *entry,
>  		 */
>  		unused_update[critical_qword_index] =
>  			entry[critical_qword_index];
> -		entry_set(writer, entry, unused_update, 0, num_entry_qwords);
> +		entry_set(writer, entry, unused_update, 0, NUM_ENTRY_QWORDS);
>  		entry_set(writer, entry, target, critical_qword_index, 1);
> -		entry_set(writer, entry, target, 0, num_entry_qwords);
> +		entry_set(writer, entry, target, 0, NUM_ENTRY_QWORDS);
>  	} else if (used_qword_diff) {
>  		/*
>  		 * At least two qwords need their inuse bits to be changed. This
> @@ -1148,7 +1147,7 @@ void arm_smmu_write_entry(struct arm_smmu_entry_writer *writer, __le64 *entry,
>  		 */
>  		unused_update[0] = entry[0] & (~writer->ops->v_bit);
>  		entry_set(writer, entry, unused_update, 0, 1);
> -		entry_set(writer, entry, target, 1, num_entry_qwords - 1);
> +		entry_set(writer, entry, target, 1, NUM_ENTRY_QWORDS - 1);
>  		entry_set(writer, entry, target, 0, 1);
>  	} else {
>  		/*
> @@ -1157,7 +1156,7 @@ void arm_smmu_write_entry(struct arm_smmu_entry_writer *writer, __le64 *entry,
>  		 * compute_qword_diff().
>  		 */
>  		WARN_ON_ONCE(
> -			entry_set(writer, entry, target, 0, num_entry_qwords));
> +			entry_set(writer, entry, target, 0, NUM_ENTRY_QWORDS));
>  	}
>  }
>  
> @@ -1272,7 +1271,6 @@ static const struct arm_smmu_entry_writer_ops arm_smmu_cd_writer_ops = {
>  	.sync = arm_smmu_cd_writer_sync_entry,
>  	.get_used = arm_smmu_get_cd_used,
>  	.v_bit = cpu_to_le64(CTXDESC_CD_0_V),
> -	.num_entry_qwords = sizeof(struct arm_smmu_cd) / sizeof(u64),
>  };
>  
>  void arm_smmu_write_cd_entry(struct arm_smmu_master *master, int ssid,
> @@ -1460,7 +1458,6 @@ static const struct arm_smmu_entry_writer_ops arm_smmu_ste_writer_ops = {
>  	.sync = arm_smmu_ste_writer_sync_entry,
>  	.get_used = arm_smmu_get_ste_used,
>  	.v_bit = cpu_to_le64(STRTAB_STE_0_V),
> -	.num_entry_qwords = sizeof(struct arm_smmu_ste) / sizeof(u64),
>  };
>  
>  static void arm_smmu_write_ste(struct arm_smmu_master *master, u32 sid,
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 8ba07b00bf6056..5936dc5f76786a 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -779,7 +779,6 @@ struct arm_smmu_entry_writer {
>  };
>  
>  struct arm_smmu_entry_writer_ops {
> -	unsigned int num_entry_qwords;
>  	__le64 v_bit;
>  	void (*get_used)(const __le64 *entry, __le64 *used);
>  	void (*sync)(struct arm_smmu_entry_writer *writer);
> 

Thanks,
Mostafa
