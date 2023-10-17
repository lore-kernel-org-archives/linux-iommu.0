Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999F143AAF
	for <iommu@lists.linux.dev>; Tue, 17 Oct 2023 14:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QhMWfZlp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697554326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GkcETT//EFaL9Pze2jt5mEPkfaMAWnv0Qv1/ld7Gzfk=;
	b=QhMWfZlpWC8KdVxTynCbYA3ItognDGsdeI+rhcjTlslFczr5BQQfFjSS+P437FC8E71gQ3
	riTkYyNG5cLSr7Isr21XsQNV8bdrasJhmNhEvpFsGhZxMlfqmK+nIPwymcBZMLvYUrX02K
	NZWVnmmzdqe1RbX7Hxw1ggMEG4FDAqc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-sN2Pd7roNZWBwjX95KEp4Q-1; Tue, 17 Oct 2023 10:52:04 -0400
X-MC-Unique: sN2Pd7roNZWBwjX95KEp4Q-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40554735995so44002735e9.1
        for <iommu@lists.linux.dev>; Tue, 17 Oct 2023 07:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697554323; x=1698159123;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GkcETT//EFaL9Pze2jt5mEPkfaMAWnv0Qv1/ld7Gzfk=;
        b=aBxlhakLSKXbOBsLigu0sxjJ43GgaB92rrfGV7naY+8xSuSN0B6iV58S/e7eMKgNgg
         vBGteV/5ePnurzSDVYdR2JJX+ePcjworXawUD82vfQR7+lHr3UnKMzsWYWnwjOE4M3Tb
         NN6i0A0Kx3DLi4lPONKo9ekztkgZkfKIyf4WYF+8cZMogJX9uaV0Wvo05dvFlPoGCaT3
         eKjaqR3KirtSqBs+xO5DOhWhy8sZ1psB/DVE7XPyXpUebLxPR5TOJqnnDZ0eJAcqMRqJ
         eZcIhiEwp5pcRQDvwB4yyKolNg1Bvg+zOsd65bL8VhXUkw4e/4VEF6apYSZ7ZZH1Z0vA
         wNSw==
X-Gm-Message-State: AOJu0Yzda2NoXWgZpm3cs3f1Uej214EmSHa3+5kI5yBjDCz3da3eBqtx
	Q9qRsxx8snYAtyADaNFRqHGshuwVmFoDzAQ7/Td7Z2ZP0SzXR3yqNtgDPH7QzD/X4bklo0oj0kD
	1eNdQ375Cd4hM5Rk=
X-Received: by 2002:a5d:4987:0:b0:32d:8f50:8553 with SMTP id r7-20020a5d4987000000b0032d8f508553mr2129612wrq.55.1697554322936;
        Tue, 17 Oct 2023 07:52:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbtcpK9ZcLxNynF1iY2rO4bpSfkOlVHEomMguJ7XEMTPw/YCqxreMiWzQaPdLtQ4ekkjJrfQ==
X-Received: by 2002:a5d:4987:0:b0:32d:8f50:8553 with SMTP id r7-20020a5d4987000000b0032d8f508553mr2129602wrq.55.1697554322647;
        Tue, 17 Oct 2023 07:52:02 -0700 (PDT)
Received: from starship ([89.237.100.246])
        by smtp.gmail.com with ESMTPSA id h4-20020adfe984000000b003143c9beeaesm1860384wrm.44.2023.10.17.07.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 07:52:02 -0700 (PDT)
Message-ID: <97d106d28e4c3468912a478dba79ab2221109cbd.camel@redhat.com>
Subject: Re: [PATCH] iommu/amd: Do not flush IRTE when only updating isRun
 and destination fields
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Cc: joro@8bytes.org, seanjc@google.com, vasant.hegde@amd.com,
 jon.grimm@amd.com,  santosh.shukla@amd.com, joao.m.martins@oracle.com, 
 alejandro.j.jimenez@oracle.com, boris.ostrovsky@oracle.com
Date: Tue, 17 Oct 2023 17:51:59 +0300
In-Reply-To: <20231017144236.8287-1-suravee.suthikulpanit@amd.com>
References: <20231017144236.8287-1-suravee.suthikulpanit@amd.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

У вт, 2023-10-17 у 09:42 -0500, Suravee Suthikulpanit пише:
> According to the recent update in the AMD IOMMU spec [1], the IsRun and
> Destination fields of the Interrupt Remapping Table Entry (IRTE) are not
> cached by the IOMMU hardware.

Is that true for all AMD hardware that supports AVIC? E.g Zen1/Zen2 hardware?

Is there a chance that this will cause a similar errata to the is_running
errata that Zen2 cpus have?



> 
> Therefore, do not issue the INVALIDATE_INTERRUPT_TABLE command when
> updating IRTE[IsRun] and IRTE[Destination] when IRTE[GuestMode]=1, which
> should help improve IOMMU AVIC/x2AVIC performance.
> 
> References:
> [1] AMD IOMMU Spec Revision (Rev 3.08-PUB)
> (Link: https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/specifications/48882_IOMMU.pdf)

Looks like the link is broken.


Best regards,
	Maxim Levitsky

> 
> Cc: Joao Martins <joao.m.martins@oracle.com>
> Cc: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 089886485895..d63590563d3e 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2970,8 +2970,8 @@ static int alloc_irq_index(struct amd_iommu *iommu, u16 devid, int count,
>  	return index;
>  }
>  
> -static int modify_irte_ga(struct amd_iommu *iommu, u16 devid, int index,
> -			  struct irte_ga *irte)
> +static int __modify_irte_ga(struct amd_iommu *iommu, u16 devid, int index,
> +			    struct irte_ga *irte)
>  {
>  	struct irq_remap_table *table;
>  	struct irte_ga *entry;
> @@ -2998,6 +2998,18 @@ static int modify_irte_ga(struct amd_iommu *iommu, u16 devid, int index,
>  
>  	raw_spin_unlock_irqrestore(&table->lock, flags);
>  
> +	return 0;
> +}
> +
> +static int modify_irte_ga(struct amd_iommu *iommu, u16 devid, int index,
> +			  struct irte_ga *irte)
> +{
> +	bool ret;
> +
> +	ret = __modify_irte_ga(iommu, devid, index, irte);
> +	if (ret)
> +		return ret;
> +
>  	iommu_flush_irt_and_complete(iommu, devid);
>  
>  	return 0;
> @@ -3681,8 +3693,8 @@ int amd_iommu_update_ga(int cpu, bool is_run, void *data)
>  	}
>  	entry->lo.fields_vapic.is_run = is_run;
>  
> -	return modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
> -			      ir_data->irq_2_irte.index, entry);
> +	return __modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
> +				ir_data->irq_2_irte.index, entry);
>  }
>  EXPORT_SYMBOL(amd_iommu_update_ga);
>  #endif


