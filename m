Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6134C46A0
	for <iommu@lists.linux.dev>; Tue,  5 Mar 2024 00:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709599378; cv=none; b=Ujtz3O2Q87L9Y2ccT96GUo2Q/wUn49ji4nU28aUP0rOl3QcNIRCq5dGDH3SriEurPU93O3jtXMx9v6r3f/wmOg/CtrmadRDdBqY3VoVA7x6OYuiSoMIY0gcgbPYI+7PFIazjxe7IGxUSCe4vNe4wnRMEgGg6c0AkngXujIh/VnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709599378; c=relaxed/simple;
	bh=MziMln0/x+/xCAokzHsHc6gZIklCEHGRl7qzswABxnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kkLO2vxovslueZ4jUFeUw7TNZi7EU7ROZEvu00Ow+1+KTNkSZu9nH+0XN95+dMuQIAfKQHRFDpkCjCZnPIM030jiTxp/gCBLBX3nQM/3L+gD5+03PYKj3syzSM0sdbXu/mYwVdoPIYDBkSMOKbJKsbfHIClnHY4J9fBqBlJ2T+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=dx6pBe0L; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dx6pBe0L"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-690578e13c4so18747546d6.1
        for <iommu@lists.linux.dev>; Mon, 04 Mar 2024 16:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1709599375; x=1710204175; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=07NafigSH79AeKnUyKDPr8ajVSq53UxnAzdoD2er6SA=;
        b=dx6pBe0LC6Ul9dJyIu4U3AopK6Fh7klwYNsDp4upNxR2wlgLtkfYjInnw64rtykF7v
         HTDV1frgm71BByTI9rzWLlDGdJtF2/RYxr6hYPTDGuWPOSo2+dP2tpz2IB+eg7UCVII0
         7az6mStnACT9KYK0N8FpehZFjVP3toS9lsF+wtVUFxC20l0bawhq5WjMei9jRH7+OIwZ
         8q0hcGRJDJR3xtbFw5h8JhiXdsvEvTrPCfA+A+fNNGQMU2izE98hO/QWpJaENQUs3Fb4
         GGXsUk73nqHrSgxfJkcUYv0FwSEzGu3Uf1cDQ0/GJqty34uwxLJGaAI4wKE9QsKgDLzI
         3Crw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709599375; x=1710204175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=07NafigSH79AeKnUyKDPr8ajVSq53UxnAzdoD2er6SA=;
        b=dg3YFtJ72uFjTt/mFlRVXAWD9HUYocf79f9uYe11/5yV1bM9LyNVgOWxH9+zviwlPH
         1kvIzdnCVs2ENfuoo4eNmfUHW4u4MMPX0I6OTpIo6BV2/4+Ap4kG0kMSDoVyJ4vGxLE5
         GEDTDmAt9Ge9RRIYh2zldHnqoDYWoiEORrid6TOb0LyTj8p185uVi63Spo1EA61L3kKH
         UxYGukNM3AV/lUwWHn7nCzv+f52cdE33G9c5g1csGDHK469XX+4hB0rtTnZGzYDlMC8H
         xHYpXPKY0OkiKRvtNH7pk5ylTWNTyhWFN1dBN4il4Mt/Bj0ix8OICMTR61PncqoGXkMX
         Nvsw==
X-Gm-Message-State: AOJu0YyQMgkCRjgNbld4A1WwIWTUN6W3yWeI8Pl/lmALY6g2YhCMA4jJ
	xWOpz385qj5tA36CnoiG8FiENJQ2Gx4KHs53N7gwai6J96v58jkbrXJ8oeIkpuM=
X-Google-Smtp-Source: AGHT+IHWOm2Pw30/JQyroczNQQxVjMxwEvTgHmykfELxTS3qndsXPshmpqR8g4l9kYJN0C1+djzVyw==
X-Received: by 2002:a05:6214:104d:b0:68f:2b9b:2809 with SMTP id l13-20020a056214104d00b0068f2b9b2809mr485221qvr.54.1709599375392;
        Mon, 04 Mar 2024 16:42:55 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id lr10-20020a0562145bca00b0068d191dfa9fsm5628223qvb.94.2024.03.04.16.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 16:42:55 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rhItS-00DaOe-G8;
	Mon, 04 Mar 2024 20:42:54 -0400
Date: Mon, 4 Mar 2024 20:42:54 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v6 12/15] iommu/amd: Add support for enable/disable IOPF
Message-ID: <20240305004254.GG9225@ziepe.ca>
References: <20240209112930.63663-1-vasant.hegde@amd.com>
 <20240209112930.63663-13-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209112930.63663-13-vasant.hegde@amd.com>

On Fri, Feb 09, 2024 at 11:29:27AM +0000, Vasant Hegde wrote:
> diff --git a/drivers/iommu/amd/Kconfig b/drivers/iommu/amd/Kconfig
> index 443b2c13c37b..d563f6d496ca 100644
> --- a/drivers/iommu/amd/Kconfig
> +++ b/drivers/iommu/amd/Kconfig
> @@ -10,6 +10,7 @@ config AMD_IOMMU
>  	select IOMMU_API
>  	select IOMMU_IOVA
>  	select IOMMU_IO_PGTABLE
> +	select IOMMU_IOPF

Makes me wonder if the previous patches actually compile fully?

> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 0fa172e0583d..21cc6654410f 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2058,12 +2058,22 @@ static int do_attach(struct iommu_dev_data *dev_data,
>  		if (ret)
>  			return ret;
>  
> -		if (pdev)
> +		if (pdev) {
>  			pdev_enable_caps(pdev);
> +
> +			/*
> +			 * Device can continue to function even if IOPF
> +			 * enablement failed. Hence in error path just
> +			 * disable device PRI support.
> +			 */
> +			if (amd_iommu_iopf_add_device(iommu, dev_data))
> +				pdev_disable_cap_pri(pdev);
> +		}
>  	} else if (pdev) {
>  		pdev_enable_cap_ats(pdev);
>  	}
>  
> +
>  	/* Update device table */

Extra whitespace

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

I already remarked about enabling PRI in the wrong spot..

Jason
