Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FC22556D
	for <iommu@lists.linux.dev>; Thu,  8 Feb 2024 18:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707418131; cv=none; b=oP72rlFIk+c/jSJps2j6/bqEf/yGVjKX6trnMwvssR6b6cv/I+3GXHhejGk4lu3s/COA9jXVV7QbOzBpsDz+sSQdEPdW+tCJmajUunkvVzEv2nZdemH7c2bA92QtT6dOo6s9zR2ribkxe7GrYY17Bwmp3FMlbGUDulEiu4uaLLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707418131; c=relaxed/simple;
	bh=l9B1crtLmC8wr94sgdwoGZm1rqiFKvSV4wQ1AznO9ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FpfDtEtsFcP664JJFF5Wpc3CNHxBuYSjDF3DRYQKGIA5AkAJRb+w04enFYUg/v4x1dcr7cMDH8W4kvSWp7QMdp4D8TsX1b20FHIPPE+iG7vRq4OZc8/FlcGqCaslnmRKj6KMmrX31JDKkNIGp2ccl/85dhCfmIEB4lTMGvqNTa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=YNd+jSHn; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="YNd+jSHn"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3bbd6ea06f5so103346b6e.1
        for <iommu@lists.linux.dev>; Thu, 08 Feb 2024 10:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1707418128; x=1708022928; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ygDu3YQbx1Ne0PocB+h0nvt6wtOoJUNDCVnZeH/e2rg=;
        b=YNd+jSHnNY0CiPL0Wu1wrnODDXkhpP99Awa9ryT/Gagn2ICDuAoJvSxtT2skdhfJpe
         1/RnpfeHG6whpucQjIGKjfz5rfsEwvmo27EssBcuwE+a7EvkrAyeHHp5jfotjXdtw7pX
         zPVAzFTc/0X7f0pEtfS+h3Aj+HYE+Qdt4TSxxh7ByB4MC57GNzSyi7X5UtAJEXBNjxUr
         R94gUOpAOOj5ZYA0hBSmA+jqaPG6PxCnxa5IDvrXrDtDrSpjFAyWzBrGG6syQFRIAJnB
         me2uzSAi9NlX9x1R2kzhiVcoCGJxgsv5XjKHvn7vZ3PMFbUEKXXnRE2zvbP7tZsoc4Et
         5tqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707418128; x=1708022928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygDu3YQbx1Ne0PocB+h0nvt6wtOoJUNDCVnZeH/e2rg=;
        b=JpSOPM2k97UuM7FnCwIehgzqy9H1NaWk7RIToXDw5RdK9QXv0+bD+JLy+3J2dNuyJA
         ttU3lJa1S+zNCO9T7VKbbbhUVlppJrAdqjA+OsX4zZJznDKGyV/tjtHJKmONHNsCJS3G
         e1cGEUHwtARp4StwXfwaw6NFgO0vFnhfojUxT+JCIt/3Cvn2X4ZIH2IUFfmvtmKAR7tB
         IclskJNsyPZh6QRkxR+vMvxvSwhgkUdZJkNbBBTOEvPfeQFpnR/Nl8cmpw2KhhfT4bDk
         DC5nq/zepJJUB+HR5cD+m/dKsr0mWHg+AkSv/4A1Ep1fdW/soO1vLbDdrNjFPsMnoBn0
         P8PQ==
X-Gm-Message-State: AOJu0Yx0x/RmTZcn4URhDZGig89bKGjLkxRs+21mOR0PTsdYGiPThJf9
	DthavbaZwgoQjY7SJRpTxPowr/EH/H+dOdtn2yTw5F0Vv1Y2Fx7dmHMPPdDhJzE=
X-Google-Smtp-Source: AGHT+IHxy7gzmE9dPDC8F9T9CEaV7UqE0w0nlb6lhoVRDluH1ero9UeM9+phpD2kuQ5tdUVnkoRw9A==
X-Received: by 2002:a05:6808:2802:b0:3bf:f53a:cc66 with SMTP id et2-20020a056808280200b003bff53acc66mr983689oib.14.1707418128305;
        Thu, 08 Feb 2024 10:48:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV2jMI7COXOI38WMIrOo1fY1mbJ5wnoQD3EzkVY31IMRaPiwgCG16DQGrXx8xxx5/e616/CZN2e/MiC/NYet+Mz9Y95o0AmzEGdQUWRYGxDsG1HULtpOqU0EILd0fhiLLKRzs2FhyymmBtJNQilv4srxW3LjnWhgFFbFuc/Hjhty+D/W3CdWDk=
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id na23-20020a0568706c1700b002064d200143sm41140oab.12.2024.02.08.10.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 10:48:47 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rY9S3-00Ffu7-13;
	Thu, 08 Feb 2024 14:48:47 -0400
Date: Thu, 8 Feb 2024 14:48:47 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v5 12/14] iommu/amd: Initial SVA support for AMD IOMMU
Message-ID: <20240208184847.GX31743@ziepe.ca>
References: <20240118073339.6978-1-vasant.hegde@amd.com>
 <20240118073339.6978-13-vasant.hegde@amd.com>
 <20240202152524.GA2606743@ziepe.ca>
 <f36ea0af-23db-7653-32e0-0a7b3941f801@amd.com>
 <20240206173457.GH31743@ziepe.ca>
 <0af9b44f-c78a-7e79-5c10-fe8d6e92f5bc@amd.com>
 <20240208174159.GW31743@ziepe.ca>
 <5ce55e42-d158-1675-f906-58b545e2b2b6@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ce55e42-d158-1675-f906-58b545e2b2b6@amd.com>

On Thu, Feb 08, 2024 at 11:53:58PM +0530, Vasant Hegde wrote:
> >> We are doing 1 SVA domain : 1 PASID : N devices model. That means we need to
> >> check all these things while attaching *first* PASID to device. (That's what we
> >> had discussed sometime back when I had all these things in feature_enable(SVA)
> >> path).
> > 
> > I thought I said you 1 PASID is not technically correct, but you could
> > get away it it for a short term. You should be planning to support N
> > PASIDs because that is what the API defines.
> 
> I am describing API in SVA context only. In that flow once we allocate a SVA
> domain for a PASID, then all devices for that PASID is attached to
> same domain.

It is OK to take a shortcut here if it helps, but that is not the API
model. Domains, SVA or not, do not have PASIDs. The only place a PASID
comes is via the set_dev_pasid() argument and any domain should be
attachable to any combination of PASIDs.

So the only place a PASID should be stored is in the elements of the
invalidation tracking list of the domain. When you get that all
completed it should all be uniform and a limitation like this should
go away. But this is fine to hold over for a followup that completes
the PASID support.

> > You just trivially check these conditions at the top of set_dev_pasid, look at
> > what I did for ARM:
> > 
> > 	if (smmu_domain->smmu != master->smmu || pasid == IOMMU_NO_PASID)
> > 		return -EINVAL;
> > 
> > 	if (!master->cd_table.in_ste &&
> > 	    sid_domain->type != IOMMU_DOMAIN_IDENTITY &&
> > 	    sid_domain->type != IOMMU_DOMAIN_BLOCKED)
> > 		return -EINVAL;
> > 
> > For AMD "cd_table in_ste" means that the DTE points to a GCR3 table
> > already. This is trivially tracked in the DTE programming in set_dte
> > because you know if the dte is being configured with a GCR3 or not.
> > 
> > The other cases represent the situations where we know how to upgrade a DTE
> > for those domains to one with a GCR3. Everything else is blocked.
> 
> I got something similar. I have reworked set/remove pasid path completely.
> I will try to post it soon.

Nice!

Jason
