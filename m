Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249AD2C84C
	for <iommu@lists.linux.dev>; Mon,  6 Nov 2023 17:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BZjtQ42O"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-778a92c06d6so310632585a.2
        for <iommu@lists.linux.dev>; Mon, 06 Nov 2023 09:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1699293298; x=1699898098; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B8apCQAneSac08xJivNELUd5DXFNBcWNk24KA+jvNGQ=;
        b=BZjtQ42OhuIswRBbV2ijyC38ujUqTUqXwz4qDvaCzqrJa/888qJe2xzdilLAA4Q1Uw
         +5Y64EOdH9SB6kCzZNGJGy/37pgPFyXMArXXYsCwyx1nNSx4sH/KlS3+xGs2ea80OH++
         V8OQ4QcQq33NZipaySz1QPLHXDh/gI8cMDXER/GU5ZTpWKzEuyz1xMFivx3s+JPr2QA+
         Sz5P7qR524513QaZFPSahgBoPAx3MernUJh2othW1/QqXWBOAvFQlCQ8NJ5ooFN4ZL0k
         ktDI+2eB/1mX/dYOHU3oA6xwxys8ur+ZimZhG+Hcov61ePjPEAqdVHU/BO7I3suXP8gi
         G4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699293298; x=1699898098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8apCQAneSac08xJivNELUd5DXFNBcWNk24KA+jvNGQ=;
        b=U5QY2zsFydX0kSiqTCzlxCMoWGAGJd7pb46CKCL3HrznFXlJFvgOMNtiUrZ3ivtknA
         f9O3WSpGJnCgXSjTQCpEY4t1HyoFgbYCwZwWAa+9v7JoPNKeByAJig8/8foPl9hOPut8
         +NkEO1uqyDFlOvLcSHlV7y4CKtRqGF2qITUGozrjKjXGY9h1G80vQWTv5PaYeM0Iw9Kr
         PsNgumu2teMUL9r34Zl1wesnOd39LLYEGHd2ZEetYA40uukwmraImHNSCdHF7b+GjF2c
         8JDQNth5ku1PLmuP6YqUcRRXZwCkFYOPrwSq57OEoizYgOZhbu8X3wj7CE9Lwfv2oBCd
         9zgg==
X-Gm-Message-State: AOJu0Yx1rDfuNCvvZAmUQJsFqhxwST/TK8tNx0UD++bNzoGjsOo89WY5
	PpzxP+ttJkx+6GtJ1yJqlNW72A==
X-Google-Smtp-Source: AGHT+IERmPygdun6izFy8QVDftqTooFIEi7AuUog1+r2QQj9NlycdPgYsNG+N+Pmb38mQVv6xNqruA==
X-Received: by 2002:a05:620a:400a:b0:774:9dc7:ce3d with SMTP id h10-20020a05620a400a00b007749dc7ce3dmr32358717qko.12.1699293298012;
        Mon, 06 Nov 2023 09:54:58 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id x12-20020ae9e90c000000b007756c0853a5sm3487248qkf.58.2023.11.06.09.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 09:54:57 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r03oO-001PLz-Oo;
	Mon, 06 Nov 2023 13:54:56 -0400
Date: Mon, 6 Nov 2023 13:54:56 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v3 03/12] iommu/amd: Introduce per device DTE update
 function
Message-ID: <20231106175456.GS4634@ziepe.ca>
References: <20231016104351.5749-1-vasant.hegde@amd.com>
 <20231016104351.5749-4-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016104351.5749-4-vasant.hegde@amd.com>

On Mon, Oct 16, 2023 at 10:43:42AM +0000, Vasant Hegde wrote:

> @@ -1679,6 +1680,24 @@ static void domain_flush_np_cache(struct protection_domain *domain,
>  }
>  
>  
> +/* Update and flush DTE for the given device */
> +void amd_iommu_dev_update_dte(struct iommu_dev_data *dev_data, bool set)
> +{
> +	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev_data->dev);
> +
> +	if (!iommu)
> +		return;

Can't be null

> +	if (set)
> +		set_dte_entry(iommu, dev_data);
> +	else
> +		clear_dte_entry(iommu, dev_data->devid);
> +
> +	clone_aliases(iommu, dev_data->dev);
> +
> +	device_flush_dte(dev_data);

This should take in iommu too..

> +}

Makes sense though

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

My other note was to basically do this:

void amd_iommu_dev_update_dte(struct iommu_dev_data *dev_data, const struct amd_dte *dte)

Where the caller functions would generate the DTE content instead of
having ste_dte_entry try to reverse engineer which caller is calling
it.

Jason
