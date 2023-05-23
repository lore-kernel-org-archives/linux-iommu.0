Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6611841
	for <iommu@lists.linux.dev>; Tue, 23 May 2023 00:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684800174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9Wxa9BdaUiqlXTnGjOyK9/2k5G21kZcdrcwgly0YKkk=;
	b=aOqyx+Aw3LXK2dSrZy7SfXzfvOX9Fo5pUg6mAnzsVylRwhJ+n33/8RVxgyKz6foUK7WA2Q
	F4j5O5zwLph34gwLjp3SQmAcs1XT2FZY3s+k2oucQUOHzy2Q4v7OvzILcEJN/HFp0bL0Vi
	arf0ZLLTu2QVH7vR/qHN0yhvyRHIekg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-V0BiNxf3P1SJGoIMKazKpw-1; Mon, 22 May 2023 20:02:52 -0400
X-MC-Unique: V0BiNxf3P1SJGoIMKazKpw-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7579cc98e5eso869366085a.2
        for <iommu@lists.linux.dev>; Mon, 22 May 2023 17:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684800172; x=1687392172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Wxa9BdaUiqlXTnGjOyK9/2k5G21kZcdrcwgly0YKkk=;
        b=XIufgonqKM7D6OcysmC/uYHTXOBnjctCfR+ZpLOC3VDFbPIDV1DTWUmP0sG23f9iLc
         vDl7CPnPQYyBi/Hcri8OmxSOkCxprLOtNoRZxVUM/7Vyk5ezcD96y7E+ljOM4DayktTq
         55DXkOt4Kz76l/56Wv3U+wHu0aLZ4iQWNV7Zc2J4qzFghG2hfiS1qb8vSi/XFgvKRzH3
         WEm5Od8BTDoATxUsya4vy3pyqCN+MOF/tTgbuIshOPA9/aUtATv6tA6usJIpKa5TDuCx
         wS5rBS/HLVflAcfKCkLcydLOwg+sxYfOta4CrHcta2jRQ/z9vv1oP/TSGO/H9nFZCU3R
         irDQ==
X-Gm-Message-State: AC+VfDzt8XNMS2NEDhTlAPUFlrUG42PYDa/sriJROytqw5h35Ft3zk90
	GxjEEXTU+xBnu3FxEaFKOhkCMRRXriViUYPzhaFiZb9/0KpxnFWmcth6eksG6Ox+YVcmPRNt7ou
	y8we3e9WxrK5RoNM=
X-Received: by 2002:a37:bcd:0:b0:75b:23a1:442 with SMTP id 196-20020a370bcd000000b0075b23a10442mr2368801qkl.8.1684800172262;
        Mon, 22 May 2023 17:02:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7fzIZoakFUWCdm0NW2bhIl82KaiHin9x/8AjhK2bBWyoCTNAQV6Mg1YqMXo2FTa9FggOBd8g==
X-Received: by 2002:a37:bcd:0:b0:75b:23a1:442 with SMTP id 196-20020a370bcd000000b0075b23a10442mr2368783qkl.8.1684800171981;
        Mon, 22 May 2023 17:02:51 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id x25-20020a05620a12b900b007576f08d3a0sm2115151qki.44.2023.05.22.17.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 17:02:51 -0700 (PDT)
Date: Mon, 22 May 2023 17:02:49 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org, 
	joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com, boris.ostrovsky@oracle.com, 
	jon.grimm@amd.com, santosh.shukla@amd.com, vasant.hegde@amd.com, 
	kishon.vijayabraham@amd.com
Subject: Re: [PATCH v2 1/5] iommu/amd: Switch amd_iommu_update_ga() to use
 modify_irte_ga()
Message-ID: <xnnxp67w4a6afoliba4p2wbqc33kus5s5mpmn2jubntdwmwwkk@zcnfdot7og5x>
References: <20230519005529.28171-1-suravee.suthikulpanit@amd.com>
 <20230519005529.28171-2-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20230519005529.28171-2-suravee.suthikulpanit@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 18, 2023 at 08:55:25PM -0400, Suravee Suthikulpanit wrote:
> From: Joao Martins <joao.m.martins@oracle.com>
> 
> The modify_irte_ga() uses cmpxchg_double() to update the IRTE in one shot,
> which is necessary when adding IRTE cache disabling support since
> the driver no longer need to flush the IRT for hardware to take effect.
> 
> Please note that there is a functional change where the IsRun and
> Destination bits of IRTE are now cached in the struct amd_ir_data.entry.
> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
>  drivers/iommu/amd/iommu.c | 38 ++++++++++----------------------------
>  1 file changed, 10 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index ebb155bfef15..4a3a7346ab21 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -3700,44 +3700,26 @@ int amd_iommu_create_irq_domain(struct amd_iommu *iommu)
>  
>  int amd_iommu_update_ga(int cpu, bool is_run, void *data)
>  {
> -	unsigned long flags;
> -	struct amd_iommu *iommu;
> -	struct irq_remap_table *table;
>  	struct amd_ir_data *ir_data = (struct amd_ir_data *)data;
> -	int devid = ir_data->irq_2_irte.devid;
>  	struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
> -	struct irte_ga *ref = (struct irte_ga *) ir_data->ref;
>  
>  	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) ||
> -	    !ref || !entry || !entry->lo.fields_vapic.guest_mode)
> +	    !entry || !entry->lo.fields_vapic.guest_mode)
>  		return 0;
>  
> -	iommu = ir_data->iommu;
> -	if (!iommu)
> -		return -ENODEV;
> -
> -	table = get_irq_table(iommu, devid);
> -	if (!table)
> +	if (!ir_data->iommu)
>  		return -ENODEV;
>  
> -	raw_spin_lock_irqsave(&table->lock, flags);
> -
> -	if (ref->lo.fields_vapic.guest_mode) {
> -		if (cpu >= 0) {
> -			ref->lo.fields_vapic.destination =
> -						APICID_TO_IRTE_DEST_LO(cpu);
> -			ref->hi.fields.destination =
> -						APICID_TO_IRTE_DEST_HI(cpu);
> -		}
> -		ref->lo.fields_vapic.is_run = is_run;
> -		barrier();
> +	if (cpu >= 0) {
> +		entry->lo.fields_vapic.destination =
> +					APICID_TO_IRTE_DEST_LO(cpu);
> +		entry->hi.fields.destination =
> +					APICID_TO_IRTE_DEST_HI(cpu);
>  	}
> +	entry->lo.fields_vapic.is_run = is_run;
>  
> -	raw_spin_unlock_irqrestore(&table->lock, flags);
> -
> -	iommu_flush_irt(iommu, devid);
> -	iommu_completion_wait(iommu);
> -	return 0;
> +	return modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
> +			      ir_data->irq_2_irte.index, entry, ir_data);
>  }
>  EXPORT_SYMBOL(amd_iommu_update_ga);
>  #endif
> -- 
> 2.31.1
> 

