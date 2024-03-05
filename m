Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B358A391
	for <iommu@lists.linux.dev>; Tue,  5 Mar 2024 00:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709597481; cv=none; b=QwySFb8RiF/LeKopwUBOkV+/WdSormDomBeK0lU+xmb0l1q+EFqsHtn3ifRGeVlBl0oSncLD4clCmiRCp6js52Rbob+kacRqnzpEx06GP2gdnTIXpBvD9Y7J9cKXfxPV83aRGhnl6wypHcAD/waL9X3Bwf/5Avw3bZpH1C0czgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709597481; c=relaxed/simple;
	bh=DSsRt61t5Np4ldKKpvMOzPSUqeM8zfjKphlv3ypYwxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=so6aAYGKx8aW2W+WBMno59mPg2cCaEjsyxDDRgLsbOtvqMi0ncP5TspC7PJEUM6P18jRIa74OwAcAzTZoktTULhOuNOC7GREQ273Op6cbXFeDcmMHgsmjZoZBMe6Li/D6wqu1iXhE9MVocAXgrfVhY3m2S7I3ebvmCmAmz/OGqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ZJ8pSa6G; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ZJ8pSa6G"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7810827e54eso385123585a.2
        for <iommu@lists.linux.dev>; Mon, 04 Mar 2024 16:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1709597479; x=1710202279; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WOaegXQ7g5zHiBMMBCeYdt9QnkF/CHSJ9bkjeDO/SPg=;
        b=ZJ8pSa6G0ULxvTAwjaPwfWdElWqwvAFnKl8CmddwCVMnuUolEWp7QHfPR5D/N8dqDu
         g/1CjrLJytYfm60vrKZqPBodzyJnkbcFH26EoilRy0kq8KfXaVqqStlrFJp1yJjdLpo1
         h5vZD+XRF1AWP5D7n8x9nNgqHqDLZm5xHjKZCAMLmauh6QC5M8yS3lQ5lENQdAoQvHKw
         C4fR7L/D+ICqYxNRAGkgyi2Vzg4br5tV7hOUCr/zi4khEqge/LA6BznyEGxREPWoZ2gx
         1oVzTv0L+zYk2jvUySbyCiiEw67qS5ggZQ4XYuAlenmbg3RF32EsdHEALK3nEVyi/Eiw
         Rd+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709597479; x=1710202279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOaegXQ7g5zHiBMMBCeYdt9QnkF/CHSJ9bkjeDO/SPg=;
        b=JAEwQA4hKSMMHCOpl+sGa/EkVAZMmbM14E2OQ+TSUtAY6TZtTbx6KewMdXiCk3zGIX
         yEBBUWRtgf1XCOGMIceNsFpxGsqbNtWtAdTyJIehr+bOA4jvNSj1FLav6jnSlxKimtUV
         G+vmcyxW9WvobKk0mbvGimEJBnLZARkH8luKHRsGuemk1ysSrKHXrXUCvaPOogkuJEuY
         PRCbg3g2mFU/eWsatyhxlWhaIWYT3+1lgRCQogRsS8rdUwENrHxHrjSkPUatACQCcaNR
         MINMOqmZnf/iVkkBnGyS2EDDyvcy+vcbHnMg2UpWuBJ2zc7HnrcCxxGcAs9xV4A44P6k
         gOqQ==
X-Gm-Message-State: AOJu0YzEoxpcBXbsCN/jD+zfvFuLCbkyJzffl5K9kozel0tSWN68Ihrb
	6vSo4PjWg12OmueiVdziWh6VfhgluN/azAnPM6wSJJw3eLF8YFf8cf9s/Tbo35E=
X-Google-Smtp-Source: AGHT+IFVXzK5aP/Uw4zNwCvc7Zq/IPMDKXFBJhk+8/S77MMeuI86W1jy7Mt6n2DoK9BEmU5CVKV11w==
X-Received: by 2002:a05:620a:95a:b0:788:2945:af57 with SMTP id w26-20020a05620a095a00b007882945af57mr340399qkw.13.1709597478794;
        Mon, 04 Mar 2024 16:11:18 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id s22-20020ae9f716000000b00788131dfa04sm3161135qkg.132.2024.03.04.16.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 16:11:18 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rhIOr-00DTKN-JL;
	Mon, 04 Mar 2024 20:11:17 -0400
Date: Mon, 4 Mar 2024 20:11:17 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v6 07/15] iommu/amd: Setup GCR3 table in advance if
 domain is SVA capable
Message-ID: <20240305001117.GB9225@ziepe.ca>
References: <20240209112930.63663-1-vasant.hegde@amd.com>
 <20240209112930.63663-8-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209112930.63663-8-vasant.hegde@amd.com>

On Fri, Feb 09, 2024 at 11:29:22AM +0000, Vasant Hegde wrote:
> SVA can be supported if domain is in passthrough mode or paging domain
> with v2 page table. Current code sets up GCR3 table for domain with v2
> page table only. Setup GCR3 table for all SVA capable domains.
> 
>   - Move GCR3 init/destroy to separate function.
> 
>   - Change default GCR3 table to use MAX supported PASIDs. Ideally it
>     should use 1 level PASID table as its using PASID zero only. But we
>     don't have support to extend PASID table yet. We will fix this later.
> 
>   - When domain is configured with passthrough mode, allocate default GCR3
>     table only if device is SVA capable.
> 
> Note that in attach_device() path it will not know whether device will use
> SVA or not. If device is attached to passthrough domain and if it doesn't
> use SVA then GCR3 table will never be used. We will endup wasting memory
> allocated for GCR3 table. This is done to avoid DTE update when
> attaching PASID to device.

It is certainly not elegant, but I can appreciate why you don't want
to tackle the DTE update right now.

> +/*
> + * If domain is SVA capable then initialize GCR3 table. Also if domain is
> + * in v2 page table mode then update GCR3[0].
> + */
> +static int init_gcr3_table(struct iommu_dev_data *dev_data,
> +			   struct protection_domain *pdom)
> +{
> +	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
> +	int max_pasids = dev_data->max_pasids;
> +	int ret = 0;
> +
> +	 /*
> +	  * If domain is in pt mode then setup GCR3 table only if device
> +	  * is PASID capable
> +	  */
> +	if (pdom_is_in_pt_mode(pdom) && !pdev_pasid_supported(dev_data))
> +		return ret;

This logic seems like it would be clearer as:

if (WARN_ON(gcr3_info->gcr3_tbl))
   return -EINVAL;
if (pdom->domain.type == IOMMU_DOMAIN_IDENTITIY)
    max_pasids = dev_data->max_pasids;
else if (pdom_is_v2_pgtbl_mode(pdom))
    max_pasids = min(1, dev_data->pasids);
else
    max_pasids = 0;

if (!max_pasids)
    return 0;

ret = setup_gcr3_table(&dev_data->gcr3_info, iommu, max_pasids)
if (ret)
   return ret;
return 0;

> +static void destroy_gcr3_table(struct iommu_dev_data *dev_data,
> +			       struct protection_domain *pdom)
> +{
> +	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
> +
> +	if (pdom_is_v2_pgtbl_mode(pdom))
> +		update_gcr3(dev_data, 0, 0, false);

This doesn't make alot of sense, we are about to free this table
memory, why zero it and flush? If the DTE still points here we are in
trouble!

Similar comment for storing the gcr3 in init_gcr3_table(), that should
just stay in the caller..

> @@ -2010,10 +2068,8 @@ static void do_detach(struct iommu_dev_data *dev_data)
>  	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
>  
>  	/* Clear GCR3 table */
> -	if (domain->pd_mode == PD_MODE_V2) {
> -		update_gcr3(dev_data, 0, 0, false);
> -		free_gcr3_table(&dev_data->gcr3_info);
> -	}
> +	if (pdom_is_sva_capable(domain))
> +		destroy_gcr3_table(dev_data, domain);

if (dev_data->gcr3_info)
	destroy_gcr3_table(dev_data, domain);

?

Don't really care how we got here..

Anyhow, this looks like the right thing in the big picture, nit picks
aside, so:

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
