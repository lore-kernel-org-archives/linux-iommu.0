Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1C61635B6
	for <iommu@lists.linux.dev>; Tue,  7 May 2024 15:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715094513; cv=none; b=Re0Ov4wmphHHUGQi+G+et4GWhSmoyRheZL5AWq+Vq2YoJwi4vNmAZvQZXflqBuxvJWkQSAVKPtenJT3F97m8QKQW4UwjT7vEdKqSaW+/XvJ2V6AX+uc1FAyTI0SSslFW4w6ZKrNOhc7aVb3H3PMJf5fS+ZzzpqXYwe/6iHyjm/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715094513; c=relaxed/simple;
	bh=xHoMxy7vndi4tDKntaT+2miBG1wPVvYn45ngD3ZMnRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=it3IlZU5REa62OCKSrK/slpgH4LBGgdJRDWYFwc5sCuj0QPWwWb60/HEaxZGYipUABBG3mygdmV2N41WKiqJLts0qOYd4yE9tjHBMe1miWBKuMJJCFfQTeQhQow/g0CwJ2Atfoon3/xg7mktLWKgE2HMwNXuWSZIWWaD4zLDM1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=cEffmdiU; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cEffmdiU"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e83a2a4f2cso15924065ad.1
        for <iommu@lists.linux.dev>; Tue, 07 May 2024 08:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715094511; x=1715699311; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fND2M9HAUkm4x+oFcQdmy96kdMgurKLsiwDF1oTNZBY=;
        b=cEffmdiUmWbg5e/O0ZI4TxXl3pyaz0S7wrwXPTUZfklufGvKrKwFWmgiMby2VoFlgo
         UgDH1+dbX2raH9NzFg6PmvP9NOK6iha4ZNtbHZWguD6aI+fjqWIz7+KJWPAtPit3R/lp
         ZJNE2l+k7WqdbxSZhJF2U+26cqIC8hDFQH9ST/qx6CCNO2A2nUuFI7KYKu++MxIb4sR7
         Io/HaulrOmVJTg85aiol74L1lgGdp4or7DhiNUdrCUmpsUA3S1Sn93dwFdIhqpNNwN5e
         peGoIrQD0VKDCjo4auw5ktFmAG03XzThsfvPgBT3sn7C/HD2tfQVB8m8nODr22jrrKmE
         rEKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715094511; x=1715699311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fND2M9HAUkm4x+oFcQdmy96kdMgurKLsiwDF1oTNZBY=;
        b=uP9vrgjBJXRdPCZG8xhX+6sFhN+qJN10G10AthrX66ULTeVC5tGeVrV2YGd6A05o2j
         ievVOZNJzrmA8kR4U95m050TXImrevjEizdUxyaiG8JBGx+IHmyqFXACX8r74zoj1twJ
         hW5eS/05P4LKUM6VPV6hVel1PvSuX+wLqhEyexRYtHUrLrqEZSGUg19AMwJjdVi4Azmb
         DDNoiHJ9Oy61Y8/c6b1vn5qxQXm/F2d/fQD9DVBJkeR1YpyLknTn4l3S4JHfkSB4a4RQ
         Y787GW4M0grOCu6dHVf25fliPzcNmpId4lqjG/fhCtiJIo72jCnyLzGttgP2FbyCATkt
         VBMA==
X-Forwarded-Encrypted: i=1; AJvYcCWfFq+l9ou2Run5jToW+z5blhhQd5zwtVVRjfqki4q59Op2s1PNaDixfqXFeNRRsxQbNp4Q211QMKN1sLwHSCcO547LwHs=
X-Gm-Message-State: AOJu0YxjA5tOluBTH+bs2VkQ9csGp5TESaiAGM/wV7q79P4knY6mQViR
	STiJMZQgF6DUgyB3rdxyIfLLpNJARD3JQMQ5qqn7golDTkIq6OJA6nEWXZYiznU=
X-Google-Smtp-Source: AGHT+IE99ykRACFWdx0o3pmeRQlEzYnavDZRoKHfVvO4jPQEJsMrakgeX588ukvMpQUEMFItCF1XdA==
X-Received: by 2002:a17:902:e752:b0:1e5:c0ee:a7f9 with SMTP id p18-20020a170902e75200b001e5c0eea7f9mr15612425plf.14.1715094511569;
        Tue, 07 May 2024 08:08:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d12-20020a170902654c00b001ed9b384b6fsm6325649pln.23.2024.05.07.08.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 08:08:30 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s4MQf-0082xt-Nq;
	Tue, 07 May 2024 12:08:29 -0300
Date: Tue, 7 May 2024 12:08:29 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zong Li <zong.li@sifive.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	tjeznach@rivosinc.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, kevin.tian@intel.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH RFC RESEND 6/6] iommu/riscv: support nested iommu for
 flushing cache
Message-ID: <20240507150829.GJ901876@ziepe.ca>
References: <20240507142600.23844-1-zong.li@sifive.com>
 <20240507142600.23844-7-zong.li@sifive.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507142600.23844-7-zong.li@sifive.com>

On Tue, May 07, 2024 at 10:26:00PM +0800, Zong Li wrote:
> This patch implements cache_invalidate_user operation for the userspace
> to flush the hardware caches for a nested domain through iommufd.
> 
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  drivers/iommu/riscv/iommu.c  | 91 ++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/iommufd.h |  9 ++++
>  2 files changed, 100 insertions(+)
> 
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index 7eda850df475..4dd58fe2242d 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -1522,9 +1522,100 @@ static void riscv_iommu_domain_free_nested(struct iommu_domain *domain)
>  	kfree(riscv_domain);
>  }
>  
> +static int riscv_iommu_fix_user_cmd(struct riscv_iommu_command *cmd,
> +				    unsigned int pscid, unsigned int gscid)
> +{
> +	u32 opcode = FIELD_GET(RISCV_IOMMU_CMD_OPCODE, cmd->dword0);
> +
> +	switch (opcode) {
> +	case RISCV_IOMMU_CMD_IOTINVAL_OPCODE:
> +		u32 func = FIELD_GET(RISCV_IOMMU_CMD_FUNC, cmd->dword0);
> +
> +		if (func != RISCV_IOMMU_CMD_IOTINVAL_FUNC_GVMA &&
> +		    func != RISCV_IOMMU_CMD_IOTINVAL_FUNC_VMA) {
> +			pr_warn("The IOTINVAL function: 0x%x is not supported\n",
> +				func);
> +			return -EOPNOTSUPP;
> +		}
> +
> +		if (func == RISCV_IOMMU_CMD_IOTINVAL_FUNC_GVMA) {
> +			cmd->dword0 &= ~RISCV_IOMMU_CMD_FUNC;
> +			cmd->dword0 |= FIELD_PREP(RISCV_IOMMU_CMD_FUNC,
> +						  RISCV_IOMMU_CMD_IOTINVAL_FUNC_VMA);
> +		}
> +
> +		cmd->dword0 &= ~(RISCV_IOMMU_CMD_IOTINVAL_PSCID |
> +				 RISCV_IOMMU_CMD_IOTINVAL_GSCID);
> +		riscv_iommu_cmd_inval_set_pscid(cmd, pscid);
> +		riscv_iommu_cmd_inval_set_gscid(cmd, gscid);
> +		break;
> +	case RISCV_IOMMU_CMD_IODIR_OPCODE:
> +		/*
> +		 * Ensure the device ID is right. We expect that VMM has
> +		 * transferred the device ID to host's from guest's.
> +		 */
> +		break;
> +	default:
> +		pr_warn("The user command: 0x%x is not supported\n", opcode);
> +		return -EOPNOTSUPP;

No userspace triggerable warnings.

> +static int riscv_iommu_cache_invalidate_user(struct iommu_domain *domain,
> +					     struct iommu_user_data_array *array)
> +{
> +	struct riscv_iommu_domain *riscv_domain = iommu_domain_to_riscv(domain);
> +	struct riscv_iommu_device *iommu;
> +	struct riscv_iommu_bond *bond;
> +	struct riscv_iommu_command cmd;
> +	struct iommu_hwpt_riscv_iommu_invalidate inv_info;
> +	int ret, index;
> +
> +	if (!riscv_domain)
> +		return -EINVAL;
> +
> +	/* Assume attached devices in the domain go through the same IOMMU device */

No, you can't assume that.

Jason
