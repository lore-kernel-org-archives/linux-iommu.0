Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A6349643
	for <iommu@lists.linux.dev>; Mon, 24 Jun 2024 20:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719262328; cv=none; b=c1d7tJpEzBcEI/wrATdpDo0aINGmRVJhZL+PBxTg3s14jYadpiulm2/MnsW0C43cL9ci8zSPoy0y2MWiPQsVwCu8zC7psx7rrf3RNVYpXcZFW9FH+OtpG3Y1oAR4p34GkSmS7IHheyMN+F6ESYIOglSj8IUy1ggle/3Bh2tenb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719262328; c=relaxed/simple;
	bh=4wYnYKBF4yjT/FHb+JBtII+1Z9Wvz8Num1xTnp9STyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=kmo4kDcSqykBCo+sXwEIk5vMttiIQZDtAFmyKTBf9MyusZYXfLXdRUTohxZoMxydDXm6kwD7dZuNkyeXIB940EvjLU1GXK+saC3tLnreIQK5XWdxbry5oiOgGWD2ZIWZt/i/5FmknyFJOWqw64YLTHnqMemF3SIBT0CQsCOyodk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TQXu14CA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TQXu14CA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719262325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R+SxFeQgxYEfRt/DxWLY+pylpQxDzaNqFiJEm3jfDys=;
	b=TQXu14CAkX8wg2IU2o6VLcYwyc31hliuAGhkrJ9aU4stU/OgZ88lQONadQeUyUIzH2y/ox
	pR7r3w+BVcpCkXi1I5hXp4QQUc4yoCKGsVg79BB9q7p3vu8+gFg4CkuxXB1PWK+MY8ieof
	sZKDmdJMa1cUc4daB+n3EPJCyM2OLtk=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-jRRnfW7_ONaqz2yIH5rT7A-1; Mon, 24 Jun 2024 16:52:03 -0400
X-MC-Unique: jRRnfW7_ONaqz2yIH5rT7A-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-25cb2c198ceso8275789fac.0
        for <iommu@lists.linux.dev>; Mon, 24 Jun 2024 13:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719262323; x=1719867123;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R+SxFeQgxYEfRt/DxWLY+pylpQxDzaNqFiJEm3jfDys=;
        b=d/sUWqhOktx1KzdEeh7V0+xjVUJuwCdb07XzwUmZ8TcJ9swCbdPfXZcyFyB6aHhHdV
         hclpGZtaYQ9scBzGp1UmZkQpOiVDKLb29v3ZQEKWtSaNwgqmq5qdNvAKnmKdUJtAjK8z
         GyJ5yeLXf13trXe6gOCuc4945DkESwMo+4+T9gL7hLjtscFSAK2lhFBQc/jsnLvfTXk1
         RYvHfjO19UI5CnOFD4CkKNTx9WyFhhuqyQUW4F2jAgpHVvCDbSR5ex3J56IkCZTN4hdd
         a6l8Lp4czRHdICj0xRmVeR9FdIYaWADxcD9JiCaHKtsMvxLpqfUgF8rhBpq32GKcTb+j
         n3rg==
X-Gm-Message-State: AOJu0Yyr1bIyb8+LUObaKCo9j05ADlZRkv/piQdA62qu5jkT9xsgUyGj
	AUkCj4jRcHVp8Euea+f7qpxncmUQl+mDx8x1Uthfl/JvbyaCWm8nPGRZkdIV0F9/JoegYlQNbPU
	SOitAXUrqrS3iJGdkz4Kv50yvAfNjUlrbSD0ZjEaAntxyCwWZQmM3
X-Received: by 2002:a05:6870:c14e:b0:259:8b4e:e71a with SMTP id 586e51a60fabf-25cfcf34d87mr7235068fac.46.1719262323201;
        Mon, 24 Jun 2024 13:52:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFR2E+VmtRxhRjWRyO2+wTv5YcfQuI/gC4k4rTQSFS1CRFfBNg1iFJ4Q265ABl4Vu/9hpv2UA==
X-Received: by 2002:a05:6870:c14e:b0:259:8b4e:e71a with SMTP id 586e51a60fabf-25cfcf34d87mr7235054fac.46.1719262322938;
        Mon, 24 Jun 2024 13:52:02 -0700 (PDT)
Received: from localhost (ip98-179-76-110.ph.ph.cox.net. [98.179.76.110])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bce93479bsm341814585a.113.2024.06.24.13.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 13:52:02 -0700 (PDT)
Date: Mon, 24 Jun 2024 13:52:00 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com, 
	=?utf-8?B?QsWCYcW8ZWogU3pjenlnaWXFgg==?= <spaz16@wp.pl>
Subject: Re: [PATCH rc] iommu/amd: Fix GT feature enablement again
Message-ID: <jvmjccjobcmsd2xq24x62ovrdwl6gzpwq5bkh5jwbsl4pfb2h5@jyhpbl6oveed>
References: <20240621101533.20216-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240621101533.20216-1-vasant.hegde@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Jun 21, 2024 at 10:15:33AM GMT, Vasant Hegde wrote:
> Current code configures GCR3 even when device is attached to identity
> domain. So that we can support SVA with identity domain. This means in
> attach device path it updates Guest Translation related bits in DTE.
> 
> Commit de111f6b4f6a ("iommu/amd: Enable Guest Translation after reading
> IOMMU feature register") missed to enable Control[GT] bit in resume
> path. Its causing certain laptop to fail to resume after suspend.
> 
> This is because we have inconsistency between between control register
> (GT is disabled) and DTE (where we have enabled guest translation related
> bits) in resume path. And IOMMU hardware throws ILLEGAL_DEV_TABLE_ENTRY.
> 
> Fix it by enabling GT bit in resume path.
> 
> Reported-by: Błażej Szczygieł <spaz16@wp.pl>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218975
> Fixes: de111f6b4f6a ("iommu/amd: Enable Guest Translation after reading IOMMU feature register")
> Tested-by: Błażej Szczygieł <spaz16@wp.pl>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
>  drivers/iommu/amd/init.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 161248067776..c89d85b54a1a 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -2743,6 +2743,7 @@ static void early_enable_iommu(struct amd_iommu *iommu)
>  	iommu_enable_command_buffer(iommu);
>  	iommu_enable_event_buffer(iommu);
>  	iommu_set_exclusion_range(iommu);
> +	iommu_enable_gt(iommu);
>  	iommu_enable_ga(iommu);
>  	iommu_enable_xt(iommu);
>  	iommu_enable_irtcachedis(iommu);
> -- 
> 2.31.1
> 

