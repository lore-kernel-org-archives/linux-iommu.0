Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB1B33BBB1
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 14:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780496318; cv=none; b=jPqYH73tmzJvBcO9gScNbIg9hYrshe0saIK0NIUFvfIKn4AcouuIcipSGJeijKnr5cXIOZCmV67326Eexy6LLGGjZct9POHCgaoHmjzzBAji9kG3CzIj/ysUjwbO8W068ckaK9nKxmNCSnjzIHjfjefqqWxKP/KU86VTIvfJ2Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780496318; c=relaxed/simple;
	bh=19HSiq87LQ5M3NDNUhZpMcP4JTO4FZyLAEClzLpHxTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=no94j09H2zBSB4kWfmf9gXxbtG9s4Odt53RUrfFji3j6Y5FaFDSYQQI2eVm6hjwPdss3a8QkSTl7iwk6UhQNpj5/dNEa32yR70cMVShiI9xGOjndkNYVXIhLP9U7gctQRZ9L5Kurr7RIRmytFFAB7lopwqXdC9DTAXrjU7csmH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tRRjQU7f; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tRRjQU7f"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2bf22c18ad3so95465ad.0
        for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 07:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780496316; x=1781101116; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kwsof3FOeGGtvC3UKgDM6z5+2/dyQFjpckHaTXqEVm8=;
        b=tRRjQU7f15To5vRL0IDdr6uH+nCrZhYIPbS+tSwy/kFp02t7YeGwolr5mr9Cs0rI56
         6d31v9LswdnFN2nudXwI2oaRl3SaP2mfSEP4C2oQx1MftfcLi1UGHALZ+FQB4FXHbAEB
         Si9umxnltgW4ygbpW2wAyi9eLtB3oSxd/cKW5GkcZiT9LHmnQntTJSqTRXBwdDFCg/4I
         PZS6h8lD+e5ziB9A6v2bLKV9BpAZcXCDxhICRLpeU35HUxmfZhA4QU3NkOZoiGqFaE30
         pkFG0hyDA5MvjZFBlzapUqR4nnfP1Ytb6mLkBiLLetgnly37b9Fp+DPfBzihGsY5UM0F
         3sEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780496316; x=1781101116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kwsof3FOeGGtvC3UKgDM6z5+2/dyQFjpckHaTXqEVm8=;
        b=bT4zdJrketmlUeBcKSvoSMYj9r3WrgR1GSXSIijOH8Gu5MF4nU2CcyaYM20FrK0hbj
         PoAD2khVMVJBztVV0e37ry4Rubbqq7oEWFzqJp4N1GlS8WRXmjsvUxE2Bc1cV9lBjB2x
         D540Rh+1p83sKMXB/z9RaGsym7vfvq7x+yeVtIhgpCs7AhNNTH2bmfATWWVRQp5K1Fxq
         C64fKY7my5btFXbTzpT7duTDAJLl179JJq1pdfOMA59JG0rXYazFGXFFweQLaIJMmi/s
         k/VhUkxgzF2W7CsTqx9LtqCi/xL08/UenO9yYM9J/FASmKv+EtFL2yAUIvJOHmjXBXqP
         mu9g==
X-Forwarded-Encrypted: i=1; AFNElJ+BrU4bBgnlOpYbvrpiEMa5aiYbYG1FdRd42ZWWsjcUv/M4O1XADut/w1GOtQVw32SN/HFN0A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyt/Hsf8pHgyKOoI7vb5o358pKo3fKxxq3DDWM50XhhVcZYr2Gh
	I0Mhov3sSxzTMOu/dKok2u9f7ER/Ly7bxR/fwYOUHRsOWU/Y8RP7i019rY0pisWxtA==
X-Gm-Gg: Acq92OEqAS92E3ug/Hpisexv6fBvD+8fLX2W+f0OUZPQWxJJuc+TdJh7WKx1txtq9MR
	FMs35Dm274CrhccugBD8t6NYXR7Y7NLwieWSaXGYrW5WkYAjt1xmITWUD+lqhO4DUfy4EWr+5ug
	RGjKXb8ucif1upAWOMZtsI2YFz77sx5mBo7wyagcciCyjKyPfPTXOVsd6azrnEmx/VY8nEHv0YO
	nRyfo5hbasFFEpbF3XpnPpSI8LIxOC3dX/pJAiub+AiosDltn8VBr2KZGmakx3KOat3EH5OiJM1
	2QIL0FbclOes7mqs1Cr5I2vKV4xxrxUCn1W+yQDAv/GxUaDTYls5Phszoh/UQMfIn2q7Om4/aC2
	LAPrzErM+vjsSxpeF03wJbvRSbH9csOXgrBE8I+CjfgENc4FQQC2h2IugxAJLa0ykD09fquYECv
	IxRlD15H0qElCmvCqwmmQKRJIfYMfkZ+hPWeSd19dhlJYVe1ymlXM0SJozwHN1s6MJZSdcTI4=
X-Received: by 2002:a17:903:1206:b0:2bf:3741:5b76 with SMTP id d9443c01a7336-2c16fa5ec8cmr1523385ad.3.1780496315741;
        Wed, 03 Jun 2026 07:18:35 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36e0a186741sm3188055a91.8.2026.06.03.07.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 07:18:34 -0700 (PDT)
Date: Wed, 3 Jun 2026 14:18:29 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, joro@8bytes.org,
	baolu.lu@linux.intel.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 5/7] iommufd: Break the loop on failure in
 iommufd_fault_fops_read()
Message-ID: <aiA3teBn2FajzwzJ@google.com>
References: <cover.1780343944.git.nicolinc@nvidia.com>
 <336a9b6e44fe66a24199d3be777c405c85c98622.1780343944.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <336a9b6e44fe66a24199d3be777c405c85c98622.1780343944.git.nicolinc@nvidia.com>

On Mon, Jun 01, 2026 at 01:42:36PM -0700, Nicolin Chen wrote:
> On a copy_to_user() failure inside the inner list_for_each_entry, only the
> inner loop breaks; the outer while re-fetches the just-restored fault group
> and retries the failing copy_to_user() forever, spinning the reader at 100%
> CPU with fault->mutex held.
> 
> Check rc after the inner loop and break the outer while as well.
> 
> Fixes: 07838f7fd529 ("iommufd: Add iommufd fault object")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommufd/eventq.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iommu/iommufd/eventq.c b/drivers/iommu/iommufd/eventq.c
> index 613024ca8f1ff..1c010e691f972 100644
> --- a/drivers/iommu/iommufd/eventq.c
> +++ b/drivers/iommu/iommufd/eventq.c
> @@ -168,6 +168,8 @@ static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *buf,
>  			}
>  			done += fault_size;
>  		}
> +		if (rc)
> +			break;
>  	}
>  	mutex_unlock(&fault->mutex);
>  

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
