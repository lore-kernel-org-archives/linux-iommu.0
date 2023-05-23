Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0F1EA1
	for <iommu@lists.linux.dev>; Tue, 23 May 2023 00:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684801340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mIt6VPJ0y1Ndcra7Hh8sY5ZEea4UepRZahWsTnGZ1jA=;
	b=XlMa2Ahbvm9b2obv1ujooFWjmGKwSOh1IZE2QD+2V4YOEMc6Rd79d+aScszXw6Q2Ri6ukd
	irSZFr/B0sP9q6RBvjbjRq6o4F05qjKoBXhMuVegRXbkEvLflJvczPbiPFOs/iNdrnoEPr
	DExo2LW/SDkbMj5RG4Wk0gvbyAeE9qA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-sWpHwLv7Ogiywsb-RIqG7Q-1; Mon, 22 May 2023 20:22:18 -0400
X-MC-Unique: sWpHwLv7Ogiywsb-RIqG7Q-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-3f6ab996ea3so27432181cf.2
        for <iommu@lists.linux.dev>; Mon, 22 May 2023 17:22:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684801338; x=1687393338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mIt6VPJ0y1Ndcra7Hh8sY5ZEea4UepRZahWsTnGZ1jA=;
        b=fL2dpuWdG9MZKfbWzfJCHYYTEQD+VpjhIqkxqDyv2JXxHqqB9MFshLAFVQWiaPHHP5
         vonN+nC/9OJP5Dsh8kPakk6LSBNnU68bJEbT/dpdFoJhh9WYmqIUshph4yzGgUWFaAa1
         8BjN7GaSJZt2tmg4u4/uJsvTOsf7dxTtVB8p6PTR+ze6xQkpOgdafRN8DgFr4nyfvbls
         21JpbPecJZVku30uaPbBhmC19i4N/uYqT5NXUrIanyVkVqOzdtbXnr82iwq0OEpOQ3ja
         fRPIpnH8OlkLmfQzKs++nt4/QOY46iwxHnIseexim3wPZwypTJSAQdBLAd6mOolbJ4UG
         LmCQ==
X-Gm-Message-State: AC+VfDy+e3mjsFObp7jqWFR3fL3FzODq5C6NoQ1r0/Ivj9lORKuIvvZ3
	ZU3tRqtcmx8WAVsYutVrMyhpHthhw7fJFboT7ldf1Wa9Yc6qBLKiXKDv7Z52StXJObz3otCAK1P
	lfwNLFfJc8BoLN6s=
X-Received: by 2002:ac8:5a4d:0:b0:3f3:90a8:6906 with SMTP id o13-20020ac85a4d000000b003f390a86906mr21456786qta.17.1684801338228;
        Mon, 22 May 2023 17:22:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5IHiuUF7WdKpoLIxcdAp2dC2ynXUmyRziuKbBWWi+UBwpzPzyZMNVkTqxG2kw8j9yrr4iA/A==
X-Received: by 2002:ac8:5a4d:0:b0:3f3:90a8:6906 with SMTP id o13-20020ac85a4d000000b003f390a86906mr21456779qta.17.1684801337984;
        Mon, 22 May 2023 17:22:17 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id x7-20020a05622a000700b003bf9f9f1844sm2480249qtw.71.2023.05.22.17.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 17:22:17 -0700 (PDT)
Date: Mon, 22 May 2023 17:22:16 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org, 
	joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com, boris.ostrovsky@oracle.com, 
	jon.grimm@amd.com, santosh.shukla@amd.com, vasant.hegde@amd.com, 
	kishon.vijayabraham@amd.com
Subject: Re: [PATCH v2 5/5] iommu/amd: Improving Interrupt Remapping Table
 Invalidation
Message-ID: <sxyc5b2ifguf7r3krewwp4o42uzqlkhvshhc4m2nhkumedgy5s@r2arntwzmmpa>
References: <20230519005529.28171-1-suravee.suthikulpanit@amd.com>
 <20230519005529.28171-6-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20230519005529.28171-6-suravee.suthikulpanit@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 18, 2023 at 08:55:29PM -0400, Suravee Suthikulpanit wrote:
> Invalidating Interrupt Remapping Table (IRT) requires, the AMD IOMMU driver
> to issue INVALIDATE_INTERRUPT_TABLE and COMPLETION_WAIT commands.
> Currently, the driver issues the two commands separately, which requires
> calling raw_spin_lock_irqsave() twice. In addition, the COMPLETION_WAIT
> could potentially be interleaved with other commands causing delay of
> the COMPLETION_WAIT command.
> 
> Therefore, combine issuing of the two commands in one spin-lock, and
> changing struct amd_iommu.cmd_sem_val to use atomic64 to minimize
> locking.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
>  drivers/iommu/amd/amd_iommu_types.h |  2 +-
>  drivers/iommu/amd/init.c            |  2 +-
>  drivers/iommu/amd/iommu.c           | 27 ++++++++++++++++++++++-----
>  3 files changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 486a052e37ca..2fa65da2a9a5 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -744,7 +744,7 @@ struct amd_iommu {
>  
>  	u32 flags;
>  	volatile u64 *cmd_sem;
> -	u64 cmd_sem_val;
> +	atomic64_t cmd_sem_val;
>  
>  #ifdef CONFIG_AMD_IOMMU_DEBUGFS
>  	/* DebugFS Info */
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index fc0392d706db..16737819f79a 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -1750,7 +1750,7 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
>  	iommu->pci_seg = pci_seg;
>  
>  	raw_spin_lock_init(&iommu->lock);
> -	iommu->cmd_sem_val = 0;
> +	atomic64_set(&iommu->cmd_sem_val, 0);
>  
>  	/* Add IOMMU to internal data structures */
>  	list_add_tail(&iommu->list, &amd_iommu_list);
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 51c2b018433d..57ae4a8072d3 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -1182,11 +1182,11 @@ static int iommu_completion_wait(struct amd_iommu *iommu)
>  	if (!iommu->need_sync)
>  		return 0;
>  
> -	raw_spin_lock_irqsave(&iommu->lock, flags);
> -
> -	data = ++iommu->cmd_sem_val;
> +	data = atomic64_add_return(1, &iommu->cmd_sem_val);
>  	build_completion_wait(&cmd, iommu, data);
>  
> +	raw_spin_lock_irqsave(&iommu->lock, flags);
> +
>  	ret = __iommu_queue_command_sync(iommu, &cmd, false);
>  	if (ret)
>  		goto out_unlock;
> @@ -1284,11 +1284,28 @@ static void amd_iommu_flush_irt_all(struct amd_iommu *iommu)
>  
>  static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
>  {
> +	int ret;
> +	u64 data;
> +	unsigned long flags;
> +	struct iommu_cmd cmd, cmd2;
> +
>  	if (iommu->irtcachedis_enabled)
>  		return;
>  
> -	iommu_flush_irt(iommu, devid);
> -	iommu_completion_wait(iommu);
> +	build_inv_irt(&cmd, devid);
> +	data = atomic64_add_return(1, &iommu->cmd_sem_val);
> +	build_completion_wait(&cmd2, iommu, data);
> +
> +	raw_spin_lock_irqsave(&iommu->lock, flags);
> +	ret = __iommu_queue_command_sync(iommu, &cmd, true);
> +	if (ret)
> +		goto out;
> +	ret = __iommu_queue_command_sync(iommu, &cmd2, false);
> +	if (ret)
> +		goto out;
> +	wait_on_sem(iommu, data);
> +out:
> +	raw_spin_unlock_irqrestore(&iommu->lock, flags);
>  }
>  
>  void iommu_flush_all_caches(struct amd_iommu *iommu)
> -- 
> 2.31.1
> 

