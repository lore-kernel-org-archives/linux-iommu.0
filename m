Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164AA399
	for <iommu@lists.linux.dev>; Tue, 23 May 2023 00:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684800202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=09PE5mXwg0VZJC96eImbk77DVfIGkrjglKMDBIgjoZU=;
	b=ITMwbQ4nK9ZOiLSQChcp5AI5YKaEXJtuDajgXxwFn2MWfzuZZ2tQ3TYhfF6X01ffFIJiQN
	rZZ/E9SAX6RCHEuNhzXJ9ASlEAZUBv7oqj7SlRHilba1Zk6XrX2Gm7Yar3jsMgPGVgEYfj
	Rakv8xfewIW5DFKZpHyc9CLqMMR+LQ0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-ZLWBUKxTPqmzm9kOlJBzlA-1; Mon, 22 May 2023 20:03:20 -0400
X-MC-Unique: ZLWBUKxTPqmzm9kOlJBzlA-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-3f63f049e92so93140961cf.3
        for <iommu@lists.linux.dev>; Mon, 22 May 2023 17:03:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684800200; x=1687392200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09PE5mXwg0VZJC96eImbk77DVfIGkrjglKMDBIgjoZU=;
        b=kZOVYSoehnFhIoPdcOJpnQD4lx81fAelXW19Op/McaXjDOn/CvYtf8gZJ97s051UCm
         6MSBuPZxDl8zuhqAJluxygXV19seLDKKEsM4UWJ8fO9BLXdG/VO1f1u2AQCf6w8CUek7
         WWcZj7FXnzNnTpr4nFIflw48Ah11g2eIetZPRGTUVeGfQ9Lw0Ak64lsg4hac6w+wEnRv
         2OFlvJGNSy6LJ3COMZ1wtmqNfPqai97ymemvYWW2wXJziA7WRiKVvZ9yAEEexr8HZTEw
         cAk6FHPwE8HLu58O1bjE/BpLdOcudlIOgGCkkly5+d1FZvb9RsUEeJQMYSZoeJFKUE3z
         I5dA==
X-Gm-Message-State: AC+VfDzM5qxFu1EpVzhIDMw9z2lqbgWMACEZrbrwIm/Cqi+MM/atJ2jP
	Za9Fdy/lxHXwyDslXDX+BQSEN5XGM1KERmZXJlEWmN6U9ssGDrSrDo244nSU2XudhqhKK7zsZLI
	zj0mXDcZgA1MvUXY=
X-Received: by 2002:a05:622a:3cf:b0:3e6:2bba:87f3 with SMTP id k15-20020a05622a03cf00b003e62bba87f3mr19299482qtx.47.1684800200216;
        Mon, 22 May 2023 17:03:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7cXJcFCg8wqGN4NZ2TIl0op0gSxJUnt0t8jqr1MVzdIAXS6vttKL0SzjYWlmH8BMqUckzAhQ==
X-Received: by 2002:a05:622a:3cf:b0:3e6:2bba:87f3 with SMTP id k15-20020a05622a03cf00b003e62bba87f3mr19299458qtx.47.1684800199969;
        Mon, 22 May 2023 17:03:19 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id q14-20020a05622a04ce00b003e8160cf93asm2442964qtx.80.2023.05.22.17.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 17:03:19 -0700 (PDT)
Date: Mon, 22 May 2023 17:03:18 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org, 
	joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com, boris.ostrovsky@oracle.com, 
	jon.grimm@amd.com, santosh.shukla@amd.com, vasant.hegde@amd.com, 
	kishon.vijayabraham@amd.com
Subject: Re: [PATCH v2 2/5] iommu/amd: Remove the unused struct
 amd_ir_data.ref
Message-ID: <rlurmw6n6eyyhtnfr6wva6azur2gvgcrdn4mvykr3nvsosj5py@ieaivyv6cqrv>
References: <20230519005529.28171-1-suravee.suthikulpanit@amd.com>
 <20230519005529.28171-3-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20230519005529.28171-3-suravee.suthikulpanit@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 18, 2023 at 08:55:26PM -0400, Suravee Suthikulpanit wrote:
> Since the amd_iommu_update_ga() has been switched to use the
> modify_irte_ga() helper function to update the IRTE, the parameter
> is no longer needed.
> 
> Suggested-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
>  drivers/iommu/amd/amd_iommu_types.h |  1 -
>  drivers/iommu/amd/iommu.c           | 17 +++++++----------
>  2 files changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 3d684190b4d5..a0ff1e852efc 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -993,7 +993,6 @@ struct amd_ir_data {
>  	struct irq_2_irte irq_2_irte;
>  	struct msi_msg msi_entry;
>  	void *entry;    /* Pointer to union irte or struct irte_ga */
> -	void *ref;      /* Pointer to the actual irte */
>  
>  	/**
>  	 * Store information for activate/de-activate
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 4a3a7346ab21..0c4a2796bb0a 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2999,7 +2999,7 @@ static int alloc_irq_index(struct amd_iommu *iommu, u16 devid, int count,
>  }
>  
>  static int modify_irte_ga(struct amd_iommu *iommu, u16 devid, int index,
> -			  struct irte_ga *irte, struct amd_ir_data *data)
> +			  struct irte_ga *irte)
>  {
>  	bool ret;
>  	struct irq_remap_table *table;
> @@ -3026,9 +3026,6 @@ static int modify_irte_ga(struct amd_iommu *iommu, u16 devid, int index,
>  	 */
>  	WARN_ON(!ret);
>  
> -	if (data)
> -		data->ref = entry;
> -
>  	raw_spin_unlock_irqrestore(&table->lock, flags);
>  
>  	iommu_flush_irt(iommu, devid);
> @@ -3117,7 +3114,7 @@ static void irte_ga_activate(struct amd_iommu *iommu, void *entry, u16 devid, u1
>  	struct irte_ga *irte = (struct irte_ga *) entry;
>  
>  	irte->lo.fields_remap.valid = 1;
> -	modify_irte_ga(iommu, devid, index, irte, NULL);
> +	modify_irte_ga(iommu, devid, index, irte);
>  }
>  
>  static void irte_deactivate(struct amd_iommu *iommu, void *entry, u16 devid, u16 index)
> @@ -3133,7 +3130,7 @@ static void irte_ga_deactivate(struct amd_iommu *iommu, void *entry, u16 devid,
>  	struct irte_ga *irte = (struct irte_ga *) entry;
>  
>  	irte->lo.fields_remap.valid = 0;
> -	modify_irte_ga(iommu, devid, index, irte, NULL);
> +	modify_irte_ga(iommu, devid, index, irte);
>  }
>  
>  static void irte_set_affinity(struct amd_iommu *iommu, void *entry, u16 devid, u16 index,
> @@ -3157,7 +3154,7 @@ static void irte_ga_set_affinity(struct amd_iommu *iommu, void *entry, u16 devid
>  					APICID_TO_IRTE_DEST_LO(dest_apicid);
>  		irte->hi.fields.destination =
>  					APICID_TO_IRTE_DEST_HI(dest_apicid);
> -		modify_irte_ga(iommu, devid, index, irte, NULL);
> +		modify_irte_ga(iommu, devid, index, irte);
>  	}
>  }
>  
> @@ -3508,7 +3505,7 @@ int amd_iommu_activate_guest_mode(void *data)
>  	entry->lo.fields_vapic.ga_tag      = ir_data->ga_tag;
>  
>  	return modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
> -			      ir_data->irq_2_irte.index, entry, ir_data);
> +			      ir_data->irq_2_irte.index, entry);
>  }
>  EXPORT_SYMBOL(amd_iommu_activate_guest_mode);
>  
> @@ -3538,7 +3535,7 @@ int amd_iommu_deactivate_guest_mode(void *data)
>  				APICID_TO_IRTE_DEST_HI(cfg->dest_apicid);
>  
>  	return modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
> -			      ir_data->irq_2_irte.index, entry, ir_data);
> +			      ir_data->irq_2_irte.index, entry);
>  }
>  EXPORT_SYMBOL(amd_iommu_deactivate_guest_mode);
>  
> @@ -3719,7 +3716,7 @@ int amd_iommu_update_ga(int cpu, bool is_run, void *data)
>  	entry->lo.fields_vapic.is_run = is_run;
>  
>  	return modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
> -			      ir_data->irq_2_irte.index, entry, ir_data);
> +			      ir_data->irq_2_irte.index, entry);
>  }
>  EXPORT_SYMBOL(amd_iommu_update_ga);
>  #endif
> -- 
> 2.31.1
> 

