Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B86B8C1A
	for <iommu@lists.linux.dev>; Fri,  8 Mar 2024 17:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709919971; cv=none; b=sgodSb1OunOk8sJo8hQ99DwnO+WB5UFnftQSH0HQ+9hjomfCYqovF8e0WNBFCEFAVYrbZstU3FcltMEqSo8C8PYo6ZN6IkvnZtwgJbkpekDRizIAfgLQOZQh0jxvIucewvV7W8ZasIHZhNFvCFHbQBZaP+EPryb6yyMbuaFrTZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709919971; c=relaxed/simple;
	bh=rK08lC8h70tM+jBp3b7B85bfPjBarpj/C+Yd2hRo22M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1W28u0dtQNm1Ujx/kC/oHO2eM9vOHlz+c3pjchMJjg+Wmttf+ecSxKv9onZOGJmNGndxzMSuaxoKXlQb84K3f6ng5GG9mjF7ic7FSORY5qQ2Oyc0KWLT7j/Q+PzJxyJEi3hjKxE9APPW60M3BvqEVCjZSejJnKqTSJRZJag064=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=OmfJKgK8; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OmfJKgK8"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c2313de2ceso410538b6e.1
        for <iommu@lists.linux.dev>; Fri, 08 Mar 2024 09:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1709919967; x=1710524767; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8ZYf0KQeywWJjZBtMXb+CC74/7IAx0iyjAYpGhr4CHk=;
        b=OmfJKgK8k2HQQnIqFGUJbWKqvxIAu0ClNrnxfE4qJPYnyo33AcKX8OqPYNGthLdHM5
         8sYng62/IvjFDXyXPMpmii+isDGx1yW7cFV2oACHmNt3KdXKfW+vq94r28bDOjR3haP8
         QMd44qrM4rZP6Xa7Eh3YcIedrNg0RStrKltlNGJHnU+rDS3HDEXfrjrCeynTAnD3Zz+t
         tLpou6m2DEBq+UH2hdcRFM2bZX3i+kXGG8G0Yasa2y9XQKFKAGyo4QcdLYKf011DhaXA
         64LWrFk7OCZd26bDTGg4EzXUiS2bn0qVWXmZwwD8rMdGq+WXa8pyjyEHwWY2r2r/m6dG
         un2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709919967; x=1710524767;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ZYf0KQeywWJjZBtMXb+CC74/7IAx0iyjAYpGhr4CHk=;
        b=DOECqoNFh9uHoytDAcHOJ2jszdeuM2EROpdzXWV6d5N1pDzt4nddrmImERjfOG555b
         bzXddsBfgUrn+tjgugCJMfJv3SBGqaMR0hdcwz8I6rDQur4Nzz9bjRSuQbv13KOEbnpE
         AqXPsSAnGenijvv0m1pPxQSz6capQmlbEamg1LoSNlhrpKeMFU8BL3wfhSGV1omhCjUT
         wm22RP12F6C6oqsfpqDnmBEMYRztXFIMSq2MRHjEBi7/DmoYFLmO5rkaisUtCBnxesfa
         cCpOTM+S3YwwQ9SngVvL3/CRr8tBCIy1mA6sfxlAC180aT9mXYmpyk/8YCdD+r4xvQX4
         L3eQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTExrCw/uVVApODWeH1TjpN4e0a68oPNC9rDLq/mpe0FshCcxBfkYfLJT5Q1pBfecX4BtNsVCtjQfFZH2fFnRQEVSxXXk=
X-Gm-Message-State: AOJu0YzNUsl7zU5hzqGdVCpc1iKC35UfXj7SANKBNhkDEEH7UFyxmU3T
	NA9LhwVlt4OYvTPD54QFZnq5e7OxKhWYjozAixeo4atPtNxkuhHMsUZ13kL9Ckk=
X-Google-Smtp-Source: AGHT+IG/7S0/bhrT9Ch0XEq+I93hxTOeDTQg4sBqPyBXTbTrJFkEN75WabLyNMNzEVIsrKpv74Bpcg==
X-Received: by 2002:a05:6808:23d4:b0:3c2:34b4:2b05 with SMTP id bq20-20020a05680823d400b003c234b42b05mr1861100oib.25.1709919967381;
        Fri, 08 Mar 2024 09:46:07 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id bk1-20020a0568081a0100b003c1e577140asm1940100oib.25.2024.03.08.09.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 09:46:06 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rieIH-007YP8-Qj;
	Fri, 08 Mar 2024 13:46:05 -0400
Date: Fri, 8 Mar 2024 13:46:05 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/8] iommu/sva: Use iopf domain attach/detach interface
Message-ID: <20240308174605.GV9225@ziepe.ca>
References: <20240122073903.24406-1-baolu.lu@linux.intel.com>
 <20240122073903.24406-3-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122073903.24406-3-baolu.lu@linux.intel.com>

On Mon, Jan 22, 2024 at 03:38:57PM +0800, Lu Baolu wrote:
> @@ -215,7 +202,23 @@ static struct iopf_group *iopf_group_alloc(struct iommu_fault_param *iopf_param,
>  		group = abort_group;
>  	}
>  
> +	cookie = iopf_pasid_cookie_get(iopf_param->dev, pasid);
> +	if (!cookie && pasid != IOMMU_NO_PASID)
> +		cookie = iopf_pasid_cookie_get(iopf_param->dev, IOMMU_NO_PASID);
> +	if (IS_ERR(cookie) || !cookie) {
> +		/*
> +		 * The PASID of this device was not attached by an I/O-capable
> +		 * domain. Ask the caller to abort handling of this fault.
> +		 * Otherwise, the reference count will be switched to the new
> +		 * iopf group and will be released in iopf_free_group().
> +		 */
> +		kfree(group);
> +		group = abort_group;
> +		cookie = NULL;
> +	}

If this is the main point of the cookie mechansim - why not just have
a refcount inside the domain itself?

I'm really having a hard time making sense of this cookie thing, we
have a lifetime issue on the domain pointer, why is adding another
structure the answer?

I see we also need to stick a pointer in the domain for iommufd to get
back to the hwpt, but that doesn't seem to need such a big system to
accomplish - just add a void *. It would make sense for the domain to
have some optional pointer to a struct for all the fault related data
that becomes allocated when a PRI domain is created..

Also, I thought we'd basically said that domain detatch is supposed to
flush any open PRIs before returning, what happened to that as a
solution to the lifetime problem?

Regardless I think we should split this into two series - improve the PRI
lifetime model for domains and then put iommufd on top of it..

Jason
