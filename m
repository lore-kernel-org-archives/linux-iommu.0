Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FE422A7F9
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 22:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742509832; cv=none; b=FopRf+qiemwM418qAmHi9Ocp4I7dUWBTCZqbKVJDz1xumkGV0za1HSYs7ozfSwkLyM0hE6f8hufIR2FidMMHiyQxBJOH9Zf5N65y2XL6sd/elfnoU+iQgUkzhgKY8o2MNReS7dzV/8ScX4EUduoTOusTiBx/YcrOww6D3AxpU6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742509832; c=relaxed/simple;
	bh=SWl39BeuZVpnezLoVMMzFEWLFgJf5YN0OuAS/kVpyow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=emeJvg4OUbQg8du1dSsZJoznDgVA0jdRjeoXflDq25wAPJt12gBXIp9yRI/fNuD443G/dn+zzfyFTlSP095dma61LQsIwVS/C97+mTQ9xuUgfEmiQcVdY+BsVGQd36ywxEOtk02OXvF0FWuMPeomB4ZyytIgiFQCJSJMoQENMlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TkI4ZCga; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TkI4ZCga"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-438d9c391fcso24225e9.0
        for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 15:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742509828; x=1743114628; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sq+BFCbOg1CAfv0zRTl61EJDfWPVbWglHwa1M7PCE+o=;
        b=TkI4ZCgatpcfxkeDcYDQghJXADGTwCu+JIEkrw9jO8HsTt3Wyd7eDny3bhjEY08MMe
         OQwoKqceav+wiJsEWEPj2g3Z9Jh7AHqao+6BdP3FtBmzHMZ1dZTwSqEA697TZeocwjTP
         w10pQyDcJpSubvgEx43ZQazXfyKrNO4GKc3arUY0MDoydAi4/6iXy+9fL79Jp1gGlY9s
         IjQMQKstMXK5eJ4Ry5CwYg6M8Wd54K5rhR8J79jqJJvPhiQehCEpbimeH00YCEQVypd8
         ujRtwOr1CJWVOgyBwC9viX71EQmTsffZ+2dNGk9Ns4G25x/VnY3zNF7aml7ay3Q7JLm+
         3mmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742509828; x=1743114628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sq+BFCbOg1CAfv0zRTl61EJDfWPVbWglHwa1M7PCE+o=;
        b=ruKbJ6TgnlkycNEFP4/VEXeyVBxP1o4QmRsfTjzVaJbBwY67qqRrVSI8TZJzmeY0xR
         HdulHFWkSrxi0/gtvnoYXNqrPS1i7Y1hZ77P5eXuicBDwKCzQAwM2XbwvZSzfSAZighO
         GXNfATKxnTu+BTMpo/AWA7NZunHshXBfd3iR4OGw4EMCfotnyJyuLOkmlvewAVyreRRZ
         5ZHwB//JDIcVANdv+uWuTh0C6aNWSK1oof2+ufMfzca0OTla018ZiIi/i03v9p2Vrfvu
         lJX2AKL8zjM0qzhdIh3HD8Ni368xibHQGcYghKMfCFLQVmkc+RuWdPVSWFAa1qFglCjt
         2JgA==
X-Forwarded-Encrypted: i=1; AJvYcCV0ze/071SLqDbXMGyf669J3jTdg5ib228LYVghl9UwWwbuX0qnwLwXe8ZDAaZfOkl9p8reSw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy3VttVRW/JRnNWZgoYyXrzNDuho7bETUWyogSWPobVhVaEXRGe
	av6uvn4qa4ztpHpt4Z1S7FaNfShSFMucXtBdv21+d7aDWuEIFHfWccUy1ZlATA==
X-Gm-Gg: ASbGncupj7ca95PVVKUnAtCmtlCUZ1Mt+hsHSmvPhtWGQctE7DrWV+HAvM/VHpl7ILc
	KTSR+AZVHGsXzt0YAcNNHrf2zFe3ESZsWrkvhdtlHceX70pUALvsTcRmZvNHFYrHO8yDJxEsLMr
	rnIkVu2UnZks1Z4dyNbqXC8fo/wDvNzb5R8ILy8C7Ozuig7OEph9Fdkl7XMDkeDM88cTysvtgAD
	IVPk/9X15Po54SLzdPcLX41H0YmS8zEV5zq73DQ5YHSWlVyg0/8Xw2dhPPwlxevqrktyihqNNlG
	6fPTuFFLjdktvR3EkK1b104Zs7eHBDVTxxYoZ7lkoND97j2oz6Qw0MFou0JBJcSqPGb+kMIvhLo
	Wvm6c
X-Google-Smtp-Source: AGHT+IHhexnSTMI08tGdmjH3mDpLODEqqdWVNBpa6Gg7DttiEtVFOZBbNNYD83xvhhHzubz2p1Jimw==
X-Received: by 2002:a7b:cd9a:0:b0:439:8d84:32ff with SMTP id 5b1f17b1804b1-43d515b6448mr123225e9.3.1742509828264;
        Thu, 20 Mar 2025 15:30:28 -0700 (PDT)
Received: from google.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9b3c2csm707468f8f.46.2025.03.20.15.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 15:30:27 -0700 (PDT)
Date: Thu, 20 Mar 2025 22:30:23 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 2/5] iommu/arm-smmu-v3: Add a helper to wait till
 cmdq drains
Message-ID: <Z9yW_4i7mCOVgjsY@google.com>
References: <20250319004254.2547950-1-praan@google.com>
 <20250319004254.2547950-3-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319004254.2547950-3-praan@google.com>

On Wed, Mar 19, 2025 at 12:42:51AM +0000, Pranjal Shrivastava wrote:
> Before we suspend SMMU, we want to ensure that all commands have been
> consumed by the SMMU's command queue, i.e. the cmdq is empty. Add a
> helper function that waits till the cmdq is empty using `queue_empty`.
> 
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 24 +++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 80362d9f293b..f65d9bca0392 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -754,6 +754,30 @@ static int arm_smmu_cmdq_poll_until_sync(struct arm_smmu_device *smmu,
>  	return __arm_smmu_cmdq_poll_until_consumed(smmu, cmdq, llq);
>  }
>  
> +/*
> + * Wait until the SMMU cmdq is empty
> + * Must be called with the cmdq lock held in some capacity.
> + */
> +static int arm_smmu_cmdq_poll_until_empty(struct arm_smmu_device *smmu,
> +					  struct arm_smmu_cmdq *cmdq,
> +					  struct arm_smmu_ll_queue *llq)
> +{
> +	struct arm_smmu_queue_poll qp;
> +	int ret = 0;
> +
> +	queue_poll_init(smmu, &qp);
> +	llq->val = READ_ONCE(cmdq->q.llq.val);
> +	do {
> +		if (queue_empty(llq))
> +			break;
> +
> +		ret = queue_poll(&qp);
> +		llq->cons = readl(cmdq->q.cons_reg);

If the command queue is not empty, that means some other thread is already
polling it, so I guess there is no need to do any MMIO here, just poll
the SW view of prod/cons, something similar to arm_smmu_cmdq_poll_until_not_full()

Thanks,
Mostafa


> +	} while (!ret);
> +
> +	return ret;
> +}
> +
>  static void arm_smmu_cmdq_write_entries(struct arm_smmu_cmdq *cmdq, u64 *cmds,
>  					u32 prod, int n)
>  {
> -- 
> 2.49.0.rc1.451.g8f38331e32-goog
> 
