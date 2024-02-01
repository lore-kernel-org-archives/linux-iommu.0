Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872898528E
	for <iommu@lists.linux.dev>; Thu,  1 Feb 2024 20:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706818813; cv=none; b=LufpCtIEXTqKbdkgbUhfqv/01hS7GZo8ZsESbLJTNMQoB+6pmnHyHdrqUPCYyuL0L2hoG2EP2qlt7iuAbgiJnprHX+kvs/e9YuyvUUKUMomYogCBzPJjVlFSLfN46Z4+N/Ytumm7tehtLxkCGMJQDxdjLg4s3DKjrIq3GlJNdLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706818813; c=relaxed/simple;
	bh=q8dFzp5VH41Wen4eWHMx9j3eY0yawt2Jx2c4SkK7RfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AO4SXeZ+ouPbS2nDNThk8lP8bBkzBEvn+c9y+RtwIG8X2jgcxerJym2eWKkk4svjC3vVVIG7ZGzkXTKa6OdyBCCAfUf+S8Raf8jOQemYaNH1H8WNpr2l27oI4CWRrVaeLmQrlvdaHvJyQW7usp1pm7AeboTR3jEZd4XMse5xFSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=TVl/8ze0; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TVl/8ze0"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-783f0995029so89447785a.1
        for <iommu@lists.linux.dev>; Thu, 01 Feb 2024 12:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1706818810; x=1707423610; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MOe3J4mk5HAMyRKs/P+2cdgtUBUJ+R72degZTedqbco=;
        b=TVl/8ze0lAvv9d5NZuQq5TbBuGiplDAC8/5ysTwlursk5jj1m4jt5R3aM3CC21MbRi
         tkgbozxSDbFrYqFLqYk8Ow1+/HOKIT63dKoIJyaQd1Ma9q2QrjECqFEd+6Iw0nvMghlj
         Qbb13luI27KaNWh5AcZoBbcobnLDoqRGsHGifQL9ivJs6GficJ3sxb23R8+kRCoi1BOp
         grsSFsacafxEfU7Vja5LiTCEIny1YrsoMqLMJmdj6k2FcErzy1pKySW9P1dAvxtMa5Db
         Ne04vEUGnBMUTG/jqVEgsPlq10RS6rS4YzZwk+xElA4azqOlfm5Ae+C48AzNc9IuLiBt
         XvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706818810; x=1707423610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MOe3J4mk5HAMyRKs/P+2cdgtUBUJ+R72degZTedqbco=;
        b=HnKABRI+8k60w9heozAwsYiegQ7kcWk1HmEnPQimLY6s6VCsXkb6g6X/nzpz7bmPoi
         e0fECqN0+yw+dzmw2EOXSsiJTZAD857H8HAXh2L9fq/6cJhl65irRuBRWTXNEkHBGaXH
         gQArUOgtK2ZS6EBEUeZ31nmPhO0W0dyWzSiTvaOO6lw7C5Bb1kV+2DM7yL0snEtp6nQW
         ueX+qUyu6TTxCyZNMFckO4U3fmpBjjNQu/GYOL9r+KRS6ft2nSoLt0kLabGcs0XKLnec
         e1y3Vab4AtT9sMYaE7fSF9+jQjaRLDTPtd3KQiFP5USCnjC5Oo9KaaCe0BPv6uAYLUvu
         i2cQ==
X-Gm-Message-State: AOJu0Yw25Y7yXcx9o4kdWi7/FTmGC6sIyI6K8fyA8YYRKD2m1rGBIP3J
	H7uDFRZWb1hWfnuB+tsSbmvWW3qvL3tWsMz+T6gDVuzTHhnvKG3Hq9A7j0eRmiAr9Y92DEhmWL4
	t
X-Google-Smtp-Source: AGHT+IEsWmrnv8hTE2tFKcZkFUieCkms29yPEENCGgFvxEj4inlJbRwQtw82uRCDB/0SzHx/wFpeAg==
X-Received: by 2002:a05:620a:847:b0:783:bd6c:90cd with SMTP id u7-20020a05620a084700b00783bd6c90cdmr261770qku.19.1706818810076;
        Thu, 01 Feb 2024 12:20:10 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUj8c8BCXUta7J3GKDCKpf3cy2KU0IU3zEdLIX3Yvp9vsxEZ+UvlogRrNb6xeDUzXPU9OXiIK72ovvvZRHFRxTxb0W2qddu9zSOtbIWJgpU66uVphXaLC9UlpNeZr+AKv8lfvqQPi/fiQyXHjAkbK+fABlkboyPOS5n3rYJwgDagwOoUIEv8ok=
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id bs39-20020a05620a472700b00783f82a9376sm107956qkb.16.2024.02.01.12.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 12:20:08 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rVdXb-00AotI-Ow;
	Thu, 01 Feb 2024 16:20:07 -0400
Date: Thu, 1 Feb 2024 16:20:07 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v5 07/14] iommu/amd: Add support for page response
Message-ID: <20240201202007.GR50608@ziepe.ca>
References: <20240118073339.6978-1-vasant.hegde@amd.com>
 <20240118073339.6978-8-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118073339.6978-8-vasant.hegde@amd.com>

On Thu, Jan 18, 2024 at 07:33:32AM +0000, Vasant Hegde wrote:

> diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
> index 1eb0b737afb5..b1751eb495fd 100644
> --- a/drivers/iommu/amd/ppr.c
> +++ b/drivers/iommu/amd/ppr.c
> @@ -148,3 +148,18 @@ void amd_iommu_iopf_uninit(struct amd_iommu *iommu)
>  
>  	raw_spin_unlock_irqrestore(&iommu->lock, flags);
>  }
> +
> +int amd_iommu_page_response(struct device *dev,
> +			    struct iopf_fault *evt,
> +			    struct iommu_page_response *resp)
> +{
> +	struct pci_dev *pdev;
> +
> +	if (!dev || !dev_is_pci(dev))
> +		return -ENODEV;
> +
> +	pdev = to_pci_dev(dev);
> +
> +	return amd_iommu_complete_ppr(pdev, resp->pasid, resp->code,
> +				      resp->grpid);

Converting this to a pci_dev seems pointless? Nothing reaches into the
PCI struct. Why do it?

We don't need sanity checking here on the fast path..

Jason
