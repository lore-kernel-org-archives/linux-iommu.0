Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2215645A
	for <iommu@lists.linux.dev>; Fri, 19 Jan 2024 19:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705694352; cv=none; b=G6pcTnJIewYB5Mi7wWY1D9gKz5/BkhgKHmPz1b9RtOxlXwkgf8hqLnKCyhYc0DGbIEKv8kzjPY1U7qlW+QpG4gd8OdLg8uJ2rBPfJbwZgu6wNr0Zky6iYAEw50gpNMKe7M7SVuVVdjTdWFoWgDFYNJjJ2LRttg/zkyTJLvR7IEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705694352; c=relaxed/simple;
	bh=xnNZJXcNAi7mCErN1mAr+BaVlSLA5MQz0XSFzRH+/+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CdRFSqArl0yW+cwPOCpfTyvrHN/DMcWRROsyrqNRLj+4neCPMeB+xWVljxIv68KHX4aXoccynE0GPaJfQfNHhyLvdGpD+KRJC9F1WQrzk9/WxACDFvoTtfDMKFSny2Jg1WDwiZ8nFZOvkX9wIj2oY3XK4JL/ifyqq+txMzADEtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gBVqpXue; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gBVqpXue"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3bd5c4cffefso1133018b6e.1
        for <iommu@lists.linux.dev>; Fri, 19 Jan 2024 11:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1705694348; x=1706299148; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3WrwIybeYyQ3VbjI/Am7NGr0ilvMnHtQipzPACO9FdE=;
        b=gBVqpXueHCiVdPk1iZJicSfcucqnv3tomRhqBBvBIq30ZK/3PdX0JXVdrlMIs1znOD
         T43d18PgVFgd+2w+Bxy8lBEtxi/nZHxoG2K1Qa4Byh1GpGEAmmVUwnG0pxh1ZygT0hqZ
         vIxr76hFVHf8ASTfVLd5YwR8zNPp1KvAm7dHosuh6QKD3U4cQAJKBmhO8RAAvMq2ZkBv
         rWgxElWVG0Krz6HsgDvo71+Iq+0T6fSVJfDdhgmRsLbsKLl5AA4xMPys9yfku70nnLBL
         BFg61IudRmglobRHrcAexew2vhWVjIh+A4WjqTo4jWYDMoUqY3saOO7p1yEFEjnG/rC1
         yV8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705694348; x=1706299148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WrwIybeYyQ3VbjI/Am7NGr0ilvMnHtQipzPACO9FdE=;
        b=kGiLYe1v6Xu/B3J0O5qNcq2bV5CI8DiBOvypZVLqcYjs97DGJ+jcKYqtX9pz1jnwY3
         jftNmS/6/q25hrDwNP8YmGQWxe4v0o3lnX/RL5T9rFIZ8elzDRHCoxRvHvwdYUbBQwy6
         7pMpeQJiBAQ+q0NOeW6uY4LxkumVNSiyJ9zfFwAu8/hY+SSiMRltTI4S5koQ33XEawbr
         9Pz7kjXbifrKbqARL3fvYkUn1YmpXQF60mFvWbv1MvIGJckybA6M3W7P0+DmvRFdIzOm
         Sx5rCLMGNeo5xgbWMaBb9OJu3VRVA30na4lRT9Fat9AkT3XQGb3oL9WjSOXzAQDjlKqR
         rfOQ==
X-Gm-Message-State: AOJu0YzvKU272QZOIiSKvvIu/4tsuz+GR6lJvU+45Ha5mIYx/YFhdb3l
	Kt/I2qLmv7NCRxG70y2IxPOtj6BTHbhlFbPo7CtBTJNaB4q8rQNhH3/t7K8JY70=
X-Google-Smtp-Source: AGHT+IH98cMlnqESzTMMWJItSaKthQd4MgWK4eUNaKdvP+I9/xbr/MjjOF/PN9nUzaiD3gWpAt8IsQ==
X-Received: by 2002:a05:6870:9726:b0:204:704b:a78c with SMTP id n38-20020a056870972600b00204704ba78cmr314223oaq.51.1705694348706;
        Fri, 19 Jan 2024 11:59:08 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id g7-20020a056870ea0700b00210c1a84708sm834742oap.31.2024.01.19.11.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 11:59:07 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rQv19-005mC9-1r;
	Fri, 19 Jan 2024 15:59:07 -0400
Date: Fri, 19 Jan 2024 15:59:07 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v5 14/17] iommu/amd: Refactor GCR3 table helper functions
Message-ID: <20240119195907.GN50608@ziepe.ca>
References: <20240116165335.6043-1-vasant.hegde@amd.com>
 <20240116165335.6043-15-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116165335.6043-15-vasant.hegde@amd.com>

On Tue, Jan 16, 2024 at 04:53:32PM +0000, Vasant Hegde wrote:

> @@ -1738,22 +1744,22 @@ static int get_gcr3_levels(int pasids)
>  	return levels ? (DIV_ROUND_UP(levels, 9) - 1) : levels;
>  }
>  
> -/* Note: This function expects iommu_domain->lock to be held prior calling the function. */
> -static int setup_gcr3_table(struct protection_domain *domain, int pasids)
> +static int setup_gcr3_table(struct gcr3_tbl_info *gcr3_info,
> +			    int nid, int pasids)
>  {
>  	int levels = get_gcr3_levels(pasids);
>  
>  	if (levels > amd_iommu_max_glx_val)
>  		return -EINVAL;
>  
> -	domain->gcr3_tbl = alloc_pgtable_page(domain->nid, GFP_ATOMIC);
> -	if (domain->gcr3_tbl == NULL)
> -		return -ENOMEM;
> +	if (gcr3_info->gcr3_tbl)
> +		return -EBUSY;
>  
> -	domain->glx      = levels;
> -	domain->flags   |= PD_IOMMUV2_MASK;
> +	gcr3_info->gcr3_tbl = alloc_pgtable_page(nid, GFP_KERNEL);
> +	if (gcr3_info->gcr3_tbl == NULL)
> +		return -ENOMEM;
>  
> -	amd_iommu_domain_update(domain);
> +	gcr3_info->glx = levels;

I think this patch should also move the domain_id
allocation/deallocation into setup_gcr3_table()/free_gcr3_table()

But it would really be better to move patch 7 to after the gcr3 layer
is cleaned and seperated from protection_domain so you don't have to
move it in the first place..

It is missing some error handling too

And domain_id_is_per_dev() is pretty redundant once you do that. See below

> @@ -1974,14 +1982,15 @@ static int do_attach(struct iommu_dev_data *dev_data,
>  	/* Init GCR3 table and update device table */
>  	if (domain->pd_mode == PD_MODE_V2) {
>  		/* By default, setup GCR3 table to support single PASID */
> -		ret = setup_gcr3_table(dev_data->domain, 1);
> +		ret = setup_gcr3_table(&dev_data->gcr3_info,
> +				       dev_to_node(dev_data->dev), 1);

IMO it is better to pass the struct amd_iommu * to setup_gcr3_table()
and then it can get the NUMA locality more sensibly via

 dev_to_node(&iommu->dev->dev)

The iommu is the thing that will walk the table and needs the
locality, not the end point device. Locality should flow from
the affiliated amd_iommu always.

Jason

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 256b5507272ff9..fb94ffa269717b 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1769,6 +1769,8 @@ static void free_gcr3_table(struct gcr3_tbl_info *gcr3_info)
 
 	free_page((unsigned long)gcr3_info->gcr3_tbl);
 	gcr3_info->gcr3_tbl = NULL;
+
+	domain_id_free(gcr3_info.domid);
 }
 
 /*
@@ -1788,7 +1790,7 @@ static int get_gcr3_levels(int pasids)
 }
 
 static int setup_gcr3_table(struct gcr3_tbl_info *gcr3_info,
-			    int nid, int pasids)
+			    struct amd_iommu *iommu, int pasids)
 {
 	int levels = get_gcr3_levels(pasids);
 
@@ -1798,12 +1800,19 @@ static int setup_gcr3_table(struct gcr3_tbl_info *gcr3_info,
 	if (gcr3_info->gcr3_tbl)
 		return -EBUSY;
 
-	gcr3_info->gcr3_tbl = alloc_pgtable_page(nid, GFP_KERNEL);
+	gcr3_info->gcr3_tbl = alloc_pgtable_page(
+		iommu ? dev_to_node(&iommu->dev->dev) : 1, GFP_KERNEL);
 	if (gcr3_info->gcr3_tbl == NULL)
 		return -ENOMEM;
 
 	gcr3_info->glx = levels;
 
+	gcr3_info.domid = domain_id_alloc();
+	if (!gcr3_info.domid) {
+		free_page((unsigned long)gcr3_info->gcr3_tbl);
+		return -ENOMEM;
+	}
+
 	return 0;
 }
 
@@ -1902,7 +1911,7 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	struct dev_table_entry *dev_table = get_dev_table(iommu);
 	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
 
-	if (domain_id_is_per_dev(domain))
+	if (gcr3_info && gcr3_info->gcr3_tbl) {
 		domid = dev_data->gcr3_info.domid;
 	else
 		domid = domain->id;
@@ -2018,15 +2027,10 @@ static int do_attach(struct iommu_dev_data *dev_data,
 	domain->dev_iommu[iommu->index] += 1;
 	domain->dev_cnt                 += 1;
 
-	/* Allocate per device domain ID */
-	if (domain_id_is_per_dev(domain))
-		dev_data->gcr3_info.domid = domain_id_alloc();
-
 	/* Init GCR3 table and update device table */
 	if (domain->pd_mode == PD_MODE_V2) {
 		/* By default, setup GCR3 table to support single PASID */
-		ret = setup_gcr3_table(&dev_data->gcr3_info,
-				       dev_to_node(dev_data->dev), 1);
+		ret = setup_gcr3_table(&dev_data->gcr3_info, iommu, 1);
 		if (ret)
 			return ret;
 
@@ -2073,10 +2077,6 @@ static void do_detach(struct iommu_dev_data *dev_data)
 	/* decrease reference counters - needs to happen after the flushes */
 	domain->dev_iommu[iommu->index] -= 1;
 	domain->dev_cnt                 -= 1;
-
-	/* Free per device domain ID */
-	if (domain_id_is_per_dev(domain))
-		domain_id_free(dev_data->gcr3_info.domid);
 }
 
 /*
