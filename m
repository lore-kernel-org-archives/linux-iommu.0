Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62B81A270
	for <iommu@lists.linux.dev>; Fri,  7 Jun 2024 17:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717782998; cv=none; b=DDlxChbqXeAP3Bl+4vKi1B+qLn3Qn7twc+Fgt+/pG3AKKM72uhSZhs2S8jDSipXkERmOTQBqgFSQSmdYU3aM2Jt94lPuFW3fePw56ryPlLNUX6KfnmUUh6UDrG5OKMTlY9UYvTyKWbC1qlisQj3IuMrB2WBXXcOmCRRdbS+kkf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717782998; c=relaxed/simple;
	bh=de1isALUI6uoVRsEqbYmJH4cywJUZMBwIdGsDgR0zjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=G4sxyHQelmxBAW7HQ/yxpVqTYmZznaNTEG+tnU6X9EFlEsn8t+HhSD1WAL+SDUrwFvzD5HxC9PylkYB4z847VCNI/GBsJvNcStJUhiRhoFPCZyejWk2qNYkThxHF6Y2f4Ev7yrv+tas9Zl1pA0jAIheDJ4OvKgQm+djWe8yw9aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wz8OJoi3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wz8OJoi3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717782995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6Dq823qS5qbYnbhJH0kaG14MNgIq+VaZmSgwk/Jjr1s=;
	b=Wz8OJoi3HsLRdFumF/2i4qeusGe8ERWnAnZ5H/T6SIUIALfLhCoMJQdUBsJaPA9XPq2uUC
	QZutRHPnylAohD6cGcq2tT2zLIpFKkTZyW65YZhRI4jJFEb1mRk3MCynO1MEbs0E1jbVzu
	5dJHY1cfLfcfOHY1AVNy5YhWQ4NEhWM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-L6rxXjEhO5eDGh_BfPrPtg-1; Fri, 07 Jun 2024 13:56:34 -0400
X-MC-Unique: L6rxXjEhO5eDGh_BfPrPtg-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-795505d8e46so25150385a.1
        for <iommu@lists.linux.dev>; Fri, 07 Jun 2024 10:56:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717782994; x=1718387794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Dq823qS5qbYnbhJH0kaG14MNgIq+VaZmSgwk/Jjr1s=;
        b=jjftGKbeCsg5VzCbHX9YI6y8HGOUdVav0R18TkBHlzcxprz2B73CQ+sJlDIbumkWBh
         MzD//3yUL0WJWHiL+AYYWU0JjQicoX4iPiUboBuswLvV5rItb8W0IdrXFVxEZZYwHTCo
         sA9bt1GqCvT2uxwz2h7373azaGRqmwo06nQY6lE7ogKjg0AUvb+FmGzIhKhWn2K97B0W
         WVNMptz5YkRL20TNqSrujVvRKQnPcJUyYqgl+0uBCP1jcHl1dWVaRiJqQE7TWZ09sw8P
         P0uPZGZxvE7MK/oRQkPPpZy3Y3gjuEBV3lBoo2AHaOk+E3zVjWEjCYbUV0MdHN6jm2TL
         KSlg==
X-Forwarded-Encrypted: i=1; AJvYcCWKNoZMJhmhLPtT7CvN/rb4okhhtELaJ/JlzMBdwD6q1AMILF82q+S2guPyX4evzjw4oC3hV4pPqmaIyktiqYwA5/Asj+M=
X-Gm-Message-State: AOJu0YwXZZoVKcGjw9PTnnua/rC9ny2uxVeu6CmecnLPUC71yWAzKdkb
	CgLDWDBbmG2HpaZELcWx9FpGbLsBqNm8V37cm+m9kXwtGv2Fo9pAUt6z6bOWRe7kINjyVbkWfwd
	ubPfpeA1v1aaoVgdsIYfkMilN0Tbb5ZrIVgt10pDFYJPSdSIa/slm
X-Received: by 2002:a37:e103:0:b0:794:f1f1:804 with SMTP id af79cd13be357-7953c5dc121mr272158085a.52.1717782993888;
        Fri, 07 Jun 2024 10:56:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1jqy09tN4euwVTk1IC+LnZ5WNN+yf+ukRKckgihHaDLqr+dOdWB86hB+p4Vk6oqdI0p2AkQ==
X-Received: by 2002:a37:e103:0:b0:794:f1f1:804 with SMTP id af79cd13be357-7953c5dc121mr272156285a.52.1717782993550;
        Fri, 07 Jun 2024 10:56:33 -0700 (PDT)
Received: from localhost (ip98-179-76-110.ph.ph.cox.net. [98.179.76.110])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-795330b1f12sm188416785a.95.2024.06.07.10.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 10:56:32 -0700 (PDT)
Date: Fri, 7 Jun 2024 10:56:31 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Yi Zhang <yi.zhang@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>, 
	Vasant Hegde <vasant.hegde@amd.com>, Baolu Lu <baolu.lu@linux.intel.com>, 
	Dimitri Sivanich <sivanich@hpe.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	David Wang <00107082@163.com>, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, Steve Wahl <steve.wahl@hpe.com>, 
	Russ Anderson <russ.anderson@hpe.com>
Subject: Re: [PATCH] iommu/amd: Fix panic accessing amd_iommu_enable_faulting
Message-ID: <lsahbfrt26ysjzgg6p6ezcrf525b25d7nnuqxgis5k6g3zsnzt@qsmzecwdjnen>
References: <ZljHE/R4KLzGU6vx@hpe.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ZljHE/R4KLzGU6vx@hpe.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 30, 2024 at 01:36:03PM GMT, Dimitri Sivanich wrote:
> This fixes a bug introduced by commit d74169ceb0d2 ("iommu/vt-d: Allocate
> DMAR fault interrupts locally").  The panic happens when
> amd_iommu_enable_faulting is called from CPUHP_AP_ONLINE_DYN context.
> 
> Fixes: d74169ceb0d2 ("iommu/vt-d: Allocate DMAR fault interrupts locally")
> Signed-off-by: Dimitri Sivanich <sivanich@hpe.com>
> Tested-by: Yi Zhang <yi.zhang@redhat.com>
> ---
>  drivers/iommu/amd/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index a18e74878f68..b02b959d12af 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -3353,7 +3353,7 @@ int amd_iommu_reenable(int mode)
>  	return 0;
>  }
>  
> -int __init amd_iommu_enable_faulting(unsigned int cpu)
> +int amd_iommu_enable_faulting(unsigned int cpu)
>  {
>  	/* We enable MSI later when PCI is initialized */
>  	return 0;
> -- 
> 2.35.3

Joerg,

Can this get pulled in for the next batch of fixes?

Regards,
Jerry

