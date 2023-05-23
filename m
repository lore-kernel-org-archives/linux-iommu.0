Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF574EA1
	for <iommu@lists.linux.dev>; Tue, 23 May 2023 00:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684801039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VTeHVdraaDyLmGTmp7Ytrme6w/+h6Z+q6yjLpuN0RnU=;
	b=becM+nlivtvpA4+0rvg3ouY98fWzSLcVKyQbYTtogU8qgwEMp/ACrtchvrfb3VEHmaeW+Q
	0cM6OL9RjfGBifiekao1iT6apZPjfwyCg7x68wnSdiDzb0PNd4K8qcS5TNa4Jm6SM5BPNw
	zJ45/muZrP9b9MdXUmLK8iQEjGiT4aQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-OtjORQGCOyqPFcfmU6YtHg-1; Mon, 22 May 2023 20:17:16 -0400
X-MC-Unique: OtjORQGCOyqPFcfmU6YtHg-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-623998c0d33so28555496d6.0
        for <iommu@lists.linux.dev>; Mon, 22 May 2023 17:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684801036; x=1687393036;
        h=in-reply-to:content-disposition:mime-version:references:\from
         :message-id:subject:cc:to:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VTeHVdraaDyLmGTmp7Ytrme6w/+h6Z+q6yjLpuN0RnU=;
        b=gU+EpWiccd8tGkUbxSIvPnD09Rv9hJa0f38InVhBq6Zfdt3A0VKdODsmsBBuO+Ti3b
         7Ka6prNRqO9LMyoyh8bPpai3h1Ek3PymBr0ApHO0qdovHh3ZvhET+25XyI0dV+8kDfa2
         1EpJuQ+MysfWe4OAoUhf2JZABjT/9GibhO2JQ5cs+XExupMES3/wlFD2fP54+i1sckCR
         HlVSOv6RwpsMGdpo9Se9nYa0RyPOFKGXXRxeoMfbeKhmK3VQOOJ79GvumjCE6HsxBD2k
         BCFhgjySDtTVTstRYRvkbd6aVZBCcFh5uaPoQULIQ5G5nLMWssKeuP8ULrAiaiyGoqpN
         ORHg==
X-Gm-Message-State: AC+VfDzPr6xUjPCdqq9ogzYEcUVzilcciDNb1DVsyYA3Bj1Ej0NPT8OV
	BbSxYEYwjEvuUes/oB6N2B/sU9tddOtkCwQC3lfJnfaXPgbrXHxqWBSosLC3BweS20yxprjfnG4
	GK7fiQx2PHXlKwb0=
X-Received: by 2002:ad4:5dcd:0:b0:5ef:6103:1475 with SMTP id m13-20020ad45dcd000000b005ef61031475mr19615162qvh.20.1684801036062;
        Mon, 22 May 2023 17:17:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Omec8OxIXzGdyaG2GXBjw0uJnau8rGKkmpAA3GeKRceyP72vusWAP6o3ol0Op1EwAoMrd4w==
X-Received: by 2002:ad4:5dcd:0:b0:5ef:6103:1475 with SMTP id m13-20020ad45dcd000000b005ef61031475mr19615139qvh.20.1684801035816;
        Mon, 22 May 2023 17:17:15 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id pp8-20020a056214138800b0061b62c15351sm2361791qvb.90.2023.05.22.17.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 17:17:15 -0700 (PDT)
From: jsnitsel@redhat.com
Date: Mon, 22 May 2023 17:17:13 -0700
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org, 
	joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com, boris.ostrovsky@oracle.com, 
	jon.grimm@amd.com, santosh.shukla@amd.com, vasant.hegde@amd.com, 
	kishon.vijayabraham@amd.com
Subject: Re: [PATCH v2 4/5] iommu/amd: Do not Invalidate IRT when disable
 IRTE caching
Message-ID: <byrqmwgki5ak5yn74ubvgikeb7ibrzml2lcnnx3qgkyi2omn3x@qyo5q5atbe33>
\From: Jerry Snitselaar <jsnitsel@redhat.com>
References: <20230519005529.28171-1-suravee.suthikulpanit@amd.com>
 <20230519005529.28171-5-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20230519005529.28171-5-suravee.suthikulpanit@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 18, 2023 at 08:55:28PM -0400, Suravee Suthikulpanit wrote:
> With the Interrupt Remapping Table cache disabled, there is no need to
> issue invalidate IRT and wait for its completion. Therefore, add logic
> to bypass the operation.
> 
> Suggested-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Would it be clearer for the summary to be "iommu/amd: Do not
Invalidate IRT when IRTE caching is disabled"?

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
>  drivers/iommu/amd/iommu.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 0c4a2796bb0a..51c2b018433d 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -1273,12 +1273,24 @@ static void amd_iommu_flush_irt_all(struct amd_iommu *iommu)
>  	u32 devid;
>  	u16 last_bdf = iommu->pci_seg->last_bdf;
>  
> +	if (iommu->irtcachedis_enabled)
> +		return;
> +
>  	for (devid = 0; devid <= last_bdf; devid++)
>  		iommu_flush_irt(iommu, devid);
>  
>  	iommu_completion_wait(iommu);
>  }
>  
> +static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
> +{
> +	if (iommu->irtcachedis_enabled)
> +		return;
> +
> +	iommu_flush_irt(iommu, devid);
> +	iommu_completion_wait(iommu);
> +}
> +
>  void iommu_flush_all_caches(struct amd_iommu *iommu)
>  {
>  	if (iommu_feature(iommu, FEATURE_IA)) {
> @@ -3028,8 +3040,7 @@ static int modify_irte_ga(struct amd_iommu *iommu, u16 devid, int index,
>  
>  	raw_spin_unlock_irqrestore(&table->lock, flags);
>  
> -	iommu_flush_irt(iommu, devid);
> -	iommu_completion_wait(iommu);
> +	iommu_flush_irt_and_complete(iommu, devid);
>  
>  	return 0;
>  }
> @@ -3048,8 +3059,7 @@ static int modify_irte(struct amd_iommu *iommu,
>  	table->table[index] = irte->val;
>  	raw_spin_unlock_irqrestore(&table->lock, flags);
>  
> -	iommu_flush_irt(iommu, devid);
> -	iommu_completion_wait(iommu);
> +	iommu_flush_irt_and_complete(iommu, devid);
>  
>  	return 0;
>  }
> @@ -3067,8 +3077,7 @@ static void free_irte(struct amd_iommu *iommu, u16 devid, int index)
>  	iommu->irte_ops->clear_allocated(table, index);
>  	raw_spin_unlock_irqrestore(&table->lock, flags);
>  
> -	iommu_flush_irt(iommu, devid);
> -	iommu_completion_wait(iommu);
> +	iommu_flush_irt_and_complete(iommu, devid);
>  }
>  
>  static void irte_prepare(void *entry,
> -- 
> 2.31.1
> 

