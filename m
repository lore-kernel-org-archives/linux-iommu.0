Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175461872
	for <iommu@lists.linux.dev>; Fri,  2 Feb 2024 15:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706887063; cv=none; b=kZJvj0CoaXLonz/7r2HEFFSEfdZU02UTjFW0K+NO6PRiY8mh0di4FWXwOnkBsUVhlS7olR0BJI6Ei3oFFzRRNlxJtPvm9sQqDn9S9jQzeI5EDvu0IYm649AySADPqSCrZViTA9WzA7qq3RITJ6q1fE+z4ZEHaxJ/RXo32bNpY6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706887063; c=relaxed/simple;
	bh=OWlLQ9vouatLshPCxfsw92f5stKWigHHvZ4vUeAwWEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SaMrzgqCS/U+jP1Cccc7wUOkpmHsbzcw7IlDZeQa1bVpl1sPahsMrZGPu8buTUM41nwEqeMq/qR3q5JXUCDy9hUE5xwrV3HEOggtu8g5rA1QJKWCaXLr2Jrv6vVx8WjNnukngQCxLCtv+ChGhBdzfuobtrjV0AitfV9xt/Ud2LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=R6eQF/7x; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="R6eQF/7x"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-783e22a16d4so245500785a.0
        for <iommu@lists.linux.dev>; Fri, 02 Feb 2024 07:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1706887060; x=1707491860; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+UIsmd3tMYZto4C+9by9gvac1oOfflqYYlLmAhYvdwI=;
        b=R6eQF/7xF6erls2kwQao9QeZfYwWxecLot+ed7wMY3Y8/db3F/CKWKVlA565W+PjGk
         kEbXiH87dicfPPhi4iIGl1I2H0BtvRpTS0HOrQ7JFtvDDFXRiSL/vwFDNJHN9X8jhTZR
         uPT1LVvn4wUwU7Z9tQMt6MyKWg2eGKfP4ckwI/LwfBl9MrzP2XGSZbLdYLHUNGc/ua8k
         NnTZmklIVwl3pbWJtAODR7IjCKLQlBqDUPrjS0NrFk7rTuiU6VWG557NTRd1mxkmgNJn
         HOIgLFI0c0Lv3PA7ElR/Ziur0iGx1U21Bupb9mQxD1G0C/CXABftx955auy11F4Kq+tB
         xwSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706887060; x=1707491860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+UIsmd3tMYZto4C+9by9gvac1oOfflqYYlLmAhYvdwI=;
        b=K/ZQeYzSI+dYl5661QaMAMuaywhpbwZPYhZzacYfQOz3zrV2DeCQmVeM88kJfKVE2L
         DQT4nBRebbgsgOArSnAWHz2KcmKmbbj30bGzZUbD4sothkF2oiJcZooEC2hhT3iqm5vy
         YlqZqtpM3YIlYGycfUd6icHhHMt5Hh5w4SNRMvBnJ0x6ToQFWxIKBTEtvA9r/Pw6U9Aq
         KzXbp6GcgtBJg4470wzXp739bTt4HKSyYZxRhKU4WHV+gEHElbVIF8pXB3mKKh2pLtoA
         7XWJvhNGPRyYJNeu5Pc7/mzL9dk78dLsPyfbEzcol5RH3AFnVZga9JikYxEhZS6t+YXP
         Edow==
X-Gm-Message-State: AOJu0YymyU7nfAoAveFG5CLTEQsRBcK8FT+HacIPaIYtAf1b4iLLIcya
	2j5UR/DkevIs/SfPuanzjpIX+BP4uDIHgMx+6EHvrhubmwPHHiFOLAb1MyvFQYU=
X-Google-Smtp-Source: AGHT+IH8htGbuJ9nVDGmfGrbGHdd+l6est77g+TDXkp4/gkcIf1IJF0DTBWej6QHkX9D/bhFds9TVA==
X-Received: by 2002:a05:620a:178e:b0:785:3ffa:68a5 with SMTP id ay14-20020a05620a178e00b007853ffa68a5mr4687099qkb.5.1706887059899;
        Fri, 02 Feb 2024 07:17:39 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWUsNAbF0NwQbNOCFPg3Xu0ERFPl/ib7bx6U3XIInxY5MMl9k3ph40F0f0b5mQx4lq+ts4HxcPvwv8lnTMdMXA+dxEg2Q1c8XdUHoZYfYyd3PMR7dp3n9yf25NN+aVMYXuus7ksA1n6Bw9cNEaVi+OAGjPc1b4E5iCJ0Ky3TA9jUheB8FOo/qM=
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id z13-20020a05620a100d00b00783f290c8f2sm749512qkj.9.2024.02.02.07.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 07:17:39 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rVvIQ-00AwAT-KQ;
	Fri, 02 Feb 2024 11:17:38 -0400
Date: Fri, 2 Feb 2024 11:17:38 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v5 11/14] iommu/amd: Add GCR3 [un]initialization function
Message-ID: <20240202151738.GU50608@ziepe.ca>
References: <20240118073339.6978-1-vasant.hegde@amd.com>
 <20240118073339.6978-12-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118073339.6978-12-vasant.hegde@amd.com>

On Thu, Jan 18, 2024 at 07:33:36AM +0000, Vasant Hegde wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> These functions are used in PASID to device bind path. In this path
> it checks whether device GCR3 table is setup or not. If not it will
> setup GCR3 table.
> 
> Also in attach device path change default GCR3 table to use MAX
> supported PASIDs. Ideally it should use 1 level PASID table as its
> using PASID zero only. But we don't have support to extend PASID table
> yet. We will fix this later.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h |  3 ++
>  drivers/iommu/amd/iommu.c     | 52 +++++++++++++++++++++++++++++++++--
>  2 files changed, 53 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
> index d5e6315ef9dd..2d099c54b941 100644
> --- a/drivers/iommu/amd/amd_iommu.h
> +++ b/drivers/iommu/amd/amd_iommu.h
> @@ -44,7 +44,10 @@ extern int amd_iommu_guest_ir;
>  extern enum io_pgtable_fmt amd_iommu_pgtable;
>  extern int amd_iommu_gpt_level;
>  
> +/* SVA/PASID */
>  bool amd_iommu_pasid_supported(void);
> +int amd_iommu_gcr3_init(struct iommu_dev_data *dev_data, ioasid_t pasids);
> +void amd_iommu_gcr3_uninit(struct iommu_dev_data *dev_data);
>  
>  /* IOPF */
>  int amd_iommu_iopf_init(struct amd_iommu *iommu);
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 36a5458a7946..6f5900333946 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -93,6 +93,11 @@ static inline bool pdom_is_v2_pgtbl_mode(struct protection_domain *pdom)
>  	return (pdom && (pdom->pd_mode == PD_MODE_V2));
>  }
>  
> +static inline bool pdom_is_in_pt_mode(struct protection_domain *pdom)
> +{
> +	return (pdom->domain.type == IOMMU_DOMAIN_IDENTITY);
> +}

Why? And what about blocking someday?

Just use dev_data->gcr3_info.gcr3_tbl == NULL to indicate if GCR3 is
loaded or not?

>  /*
>   * Allocate per device domain ID when using V2 page table
>   */
> @@ -1837,6 +1842,46 @@ int amd_iommu_clear_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid)
>  	return ret;
>  }
>  
> +int amd_iommu_gcr3_init(struct iommu_dev_data *dev_data, ioasid_t pasids)
> +{
> +	struct protection_domain *pdom = dev_data->domain;
> +	int ret = 0;
> +
> +	lockdep_assert_held(&dev_data->lock);
> +
> +	/*
> +	 * We cannot support PASID w/ existing v1 page table in the same domain
> +	 * since it will be nested. However, existing domain w/ v2 page table
> +	 * can be used for PASID.
> +	 */
> +	if (!pdom_is_v2_pgtbl_mode(pdom) && !pdom_is_in_pt_mode(pdom))
> +		return -EOPNOTSUPP;

Put the test directly in the set dev pasid op and it should be more
like

if (!dev_data->gcr3_info.gcr3_tbl && dev_data->domain->type & _IOMMU_DOMAIN_PAGING)
    return -EINVAL;


And you need the mirroring test in alloc_dev to prevent changing the
RID to things the driver does not yet support, I didn't notice that?

> +	/* Allocate GCR3 table */
> +	if (pdom_is_in_pt_mode(pdom) && dev_data->gcr3_info.gcr3_tbl == NULL) {
> +		ret = setup_gcr3_table(&dev_data->gcr3_info,
> +				       dev_to_node(dev_data->dev), pasids);
> +
> +		/* Update device table */
> +		amd_iommu_dev_update_dte(dev_data, true);
> +	}

This shouldn't be any different from do_attach()

> +
> +	return ret;

success oritened flow please

> +void amd_iommu_gcr3_uninit(struct iommu_dev_data *dev_data)
> +{
> +	lockdep_assert_held(&dev_data->lock);
> +
> +	/* Free GCR3 table */
> +	if (pdom_is_in_pt_mode(dev_data->domain)) {
> +		free_gcr3_table(&dev_data->gcr3_info);
> +
> +		/* Update device table */
> +		amd_iommu_dev_update_dte(dev_data, true);
> +	}
> +}

Is it really worth freeing it?

>  static void set_dte_entry(struct amd_iommu *iommu,
>  			  struct iommu_dev_data *dev_data)
>  {
> @@ -1986,9 +2031,12 @@ static int do_attach(struct iommu_dev_data *dev_data,
>  
>  	/* Init GCR3 table and update device table */
>  	if (domain->pd_mode == PD_MODE_V2) {
> -		/* By default, setup GCR3 table to support single PASID */
> +		/*
> +		 * By default, setup GCR3 table to support MAX PASIDs
> +		 * supported by the IOMMU HW.
> +		 */
>  		ret = setup_gcr3_table(&dev_data->gcr3_info,
> -				       dev_to_node(dev_data->dev), 1);
> +				       dev_to_node(dev_data->dev), -1);

-1 should be dev->iommu->max_pasids, but better would be this specific
device's max pasid size, cached from pci_max_pasids()

Jason
