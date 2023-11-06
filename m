Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8BC241FF
	for <iommu@lists.linux.dev>; Mon,  6 Nov 2023 17:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kWyF29Lj"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3b2ea7cca04so3070890b6e.2
        for <iommu@lists.linux.dev>; Mon, 06 Nov 2023 09:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1699291773; x=1699896573; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RyYrivOkwJW+lhkMVRCU+CqUAdrzHFncDNs9O3VP2o0=;
        b=kWyF29LjFQhYXfcwUJ6Do35DRzHxpV9DtH+zIOuBXs7PJ08m/NLgZ2omrTuS6vZuGI
         7EKyC9m5Hl4vQLrk+dcR8ntcmhAjjSt8PdNxRcsDlZcN8Dt1A0IR2z/4BKk44M0tlL3/
         UiQF4/zjYeH40iwI7ab9LP2cchpg+OzLVX58tj5/B70LJfEanoYCvkExHze3sUudfnIf
         bYyrpwfIgOKmHIPCHAy6GKZSl+kTVJcDupxgTvWjTEvxTRfiFxFEnGtPp8i/n3PNTt7X
         AdyWMY0wnT/Zpppps6sqJhid/EX9OL5tfUC7DUDnDXTtrskXcCNhrVti+aon1oIhK9Ol
         iZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699291773; x=1699896573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RyYrivOkwJW+lhkMVRCU+CqUAdrzHFncDNs9O3VP2o0=;
        b=D4nOg2Za35kmrCweQr4UiVtYRbxN4bt03uY+RmeyHkfq7viJm/gPINUqouVqu+UPAX
         QVzTueSYa6SuuDttPduvtdKmf/FEzWBvfaRYAoXdbGToysohv4ypzewCom931cnvCXu6
         v7WqUMTQ0uKqHtgtYxNL83Ct+MX4Eq6ksJ5OevfEtcQO34QBuag73pDJm7yMQNXur9Og
         ENIYHXZp1kP6wEFb7xMlXaIIMLt1B1e4ApoMEb/qy9x00unvaAAbGKD7OS5bxSOAA3he
         ia8QliAA4Bl/Qtq5M6qQY4tqdgEZjES+m+ODrNHX8j9HHhSun489gJBujV1Y4Oy7Ki54
         9jPQ==
X-Gm-Message-State: AOJu0Yz9CzCulHXT9uDFLRg4d1VP9VISqylo3fPwqIAspLEeyKtoxkcC
	VCo972D6wnJas2QL/LszyS83Ig==
X-Google-Smtp-Source: AGHT+IHMw4FzswnzQtwoObQGV1Erx6BWSEr74bc4mXWJhxEGvbZFkN9lxJtDhiSp/A6gYwID9WxPDA==
X-Received: by 2002:a05:6808:1b14:b0:3a7:2390:3583 with SMTP id bx20-20020a0568081b1400b003a723903583mr37803220oib.38.1699291773259;
        Mon, 06 Nov 2023 09:29:33 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id m17-20020a05620a24d100b00774292e636dsm3465530qkn.63.2023.11.06.09.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 09:29:31 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r03Pn-001P8S-7T;
	Mon, 06 Nov 2023 13:29:31 -0400
Date: Mon, 6 Nov 2023 13:29:31 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v3 10/13] iommu/amd: Refactor helper function for
 attaching / detaching device
Message-ID: <20231106172931.GM4634@ziepe.ca>
References: <20231013151652.6008-1-vasant.hegde@amd.com>
 <20231013151652.6008-11-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013151652.6008-11-vasant.hegde@amd.com>

On Fri, Oct 13, 2023 at 03:16:49PM +0000, Vasant Hegde wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> To use the new helper function for setting up GCR3 table.
> 
> If system is booted with V2 page table then setup default GCR3 with
> domain GCR3 pointer. 

Lets stop talking about "booted with V2 page table" - "If the domain
uses the V2 format then setup a GCR3 table in the device to point to it"

> +static int _init_gcr3_tbl(struct iommu_dev_data *dev_data)
> +{
> +	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
> +
> +	/* By default, GCR3 is set to support non-PASID devices. */
> +	gcr3_info->giov = true;

I admit I find it really hard to read the AMD spec here.. In terms of
the SW model what modes are actually supportable by HW?

No PASIDs being used:
 RID domain=IDENTITY - yes [V=0]
 RID domain=BLOCKED - yes [V=1, TV=1, GV=0, mode == 0]
 RID domain=v1 - Yes [V=1, TV=1, GV=0, mode != 0]
 RID domain=v2 - Yes [V=1, TV=0, GV=1, GIOV=1]

Some kind of PASID in use:
 RID domain=v2 & PASID - Yes [V=1, TV=0, GV=1, GIOV=1]
 RID domain=V1 & PASID - No??
 RID domain=IDENTITY & PASID - ?? [V=1, TV=1 GV=1, mode=0, GIOV=0] (Section 2.2.7.1?)
 RID domain=BLOCKED & PASID - ?? [V=1, TV=0, GV=1, GIOV=1 with GCR3 entry 0 being non-valid] 

Did I get it right? If so GIOV should ultimately be deduced based on
what domain the RID has?

Look at how the SMMUv3 stuff ended up. Their STE is the same purpose
as the AMD DTE. There are alot of combinations here, it was hard to
make a code flow that was clean. It turned out pretty good when the
DTE was generated in the ops->attach based on a calculation of exactly
what the current configuration is, because we already know what we are
in alot of detail at that point.

eg we know if we are attaching an identity domain and PASIDs are in
use that a single specific DTE should be created. So just call a
function directly to get the required DTE.

IOW - I'm not sure it really makes logical sense to store giov in
gcr3_info.

> +static int do_attach(struct iommu_dev_data *dev_data,
> +		     struct protection_domain *domain)
>  {
>  	struct amd_iommu *iommu;
> +	int ret = 0;
>  
>  	iommu = get_amd_iommu_from_dev(dev_data->dev);
>  	if (!iommu)
> -		return;
> +		return -EINVAL;

iommu can't be null here, have a dev_data.

>  	dev_data->domain = domain;
> @@ -2080,11 +2103,27 @@ static void do_attach(struct iommu_dev_data *dev_data,
>  	if (domain_id_is_per_dev(domain))
>  		dev_data->domid = domain_id_alloc();

At some point this is the wrong place to put this, the domain ID is
logically associated with the gcr3 table, it should never be used if
there is no gcr table allocated, and it should be freed once the gcr3
table is freed.

> +	/* Init GCR3 table */
> +	if (domain->pd_mode == PD_MODE_V2) {

Is there a case where domain_id_is_per_dev() but we are attaching a v1
table?

Jason
