Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62606433E85
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 13:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783950662; cv=none; b=ViV92MwnK1Josvp4gmQtvIzULyozzYCndmyatCm1x/VhUS1DOBnKgqmqe4X68dM1gZbXJCN4/bH0dYJk7m0HBjKLdU+2Mbyo+LDP/L0bwNnvVnVVSM2x5/e3xx5i/4mlLrMOPKF7lh1JG5CHTkAkKXSZBrGZW+exAOP9A+4Q+2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783950662; c=relaxed/simple;
	bh=3b65f9HscW/yV2xQrFsKLyYDme29l/rrNYv8VEkDzyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GoCGKxEjriZYzaPx6IMh60ICe/UPiKAXxDZ3e4A2JaxNL5uubNexyoJ++seRnAN8p8N5XwOjnwrWweqkVOTJAip2jxLO5P0u7bFkHC09GeRACyIYYG7DpEvix/xJKpe1uHSYcKCtuNo8uZNz58zGS1SqK6bMUlgQqSpKZEqUrz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=K6zyuHjo; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="K6zyuHjo"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92e6a434cabso183553185a.1
        for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 06:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783950660; x=1784555460; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j7BFsAeY/cNxYBhDdt5lEE2McwL0FHxSEO7wsqO2A6c=;
        b=K6zyuHjomKVnR19VPCa1GFiGMR9P0LSvSNeIoMR9CreUSe3Uyw8XcF/IEdjn0XbdR8
         eSRvKzBc8gElcdywx8AzUk4v73FOp3FIERv/kXOG7KSfaUPcSj4V9LglI+F3mRvnO91p
         srl4UX9ofCEwoKUSXuW+wEicPRhwnXJzSSqntk1gKN/VM0soEMnjjOGvMU2XODTjQ06i
         UIhAlaOvkrSoNQ03huSQS+JF3fsJ3MofQLLYwON0nrTbYRpSOwkrsxqKEvP+9C4XaQGi
         wdhgdQiTOqIE6cWvUvyXRPnzgJ5iK7I5E1lNuqFEAh33SRVb3zfJP94OlDbkAY5h1Nmj
         g8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783950660; x=1784555460;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j7BFsAeY/cNxYBhDdt5lEE2McwL0FHxSEO7wsqO2A6c=;
        b=JD/4yBwIxnmDoX0dyi2Of+dhTNurp0o24rLUhymI8WqguMioQ5FFDT2954ix0HCkqW
         JUqCc7nV/T3xN9ah2yQxnsV8xoHf/EKvuAlpNvQvFH6uSrZ1Dxu2pXq8qce06JIP8TeH
         E3DzkT+jeMrblulT65EitpMEV5P3NsXggPJpippHkTXylR8F6sLApi4fdOMF4HQVrdlB
         Y3j9py800kcg1v6+SC86ys9TtRlN04jhKUQ1kT1z4SOZ3vYEu5zDrl6G3x9QWM7QXZqO
         qEYFS6KSZhzRT7kLjmdqbZewSdjR01miOzvG92cPRG+Cn9/toOsywbZp3EIkvcQ3Cxbd
         0TWQ==
X-Forwarded-Encrypted: i=1; AHgh+RoQC/NTGVMeshrKUSOz5hj3Mw0HtxkafXUFmSqwyWL3kYkDbTMv7Tde+exQlp2cumr/8yAxQQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzwxg8mkEpto2HFPEShoh9HG4ow+BRCM3hs/yvJtKNjqV8+scBc
	f/eeOsBSJBENu2qpTRqDeTUgLpV5jvBfiZW7dns3PlY8utkGyk0YelwimoZqPfbOEyc=
X-Gm-Gg: AfdE7cnzCNpwIn3g1YutynHPbZFJspUCH9+Qu/Jeta0CxK2suIQvLeumXwP3h9Pblic
	QwnxnmuRb51hW9e3pQSnM4N0QHoKn7jIC8m4d7oHDtR9ukEvtg8e2J1EdiXL8PwBioT435L798I
	kpVmsD3BHDxcAaB7HmZ5987stzJ3T682fHHAki0Q+BACFaI+TBBS14FfRiksRdfA6iHqIyPLVEl
	OOL0L5vCkRm+Drd+WxRPMb+vXf896Rg7lQt9VNjJ0s5Bt0TbPhm06jrAL9NSk8A8Pd6/xhKyFzl
	UFZ3DwXym+ZOodyJx8CLxMNISyZ9GITxct0SPn7UXKvt50i+Dl9Zij+fcFokJNoely9znlzMKNt
	PhQT3MlHIsHIV73sAXlWozWgQYqhshIbXGhgNC1C2VRz5seUBMJNzfzyqAxqB
X-Received: by 2002:a05:620a:45ab:b0:915:6453:1ae with SMTP id af79cd13be357-92ef2b35176mr930845485a.14.1783950660057;
        Mon, 13 Jul 2026 06:51:00 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d61fb9sm1040677385a.41.2026.07.13.06.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 06:50:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjH3i-0000000DKBL-2vAC;
	Mon, 13 Jul 2026 10:50:58 -0300
Date: Mon, 13 Jul 2026 10:50:58 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Samuel Moelius <sam.moelius@trailofbits.com>
Cc: Kevin Tian <kevin.tian@intel.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"open list:IOMMUFD" <iommu@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] iommu/iommufd: avoid selftest dirty bitmap size wrap
Message-ID: <20260713135058.GA3133966@ziepe.ca>
References: <20260628152331.82122.408afd7b466c.iommufd-test-dirty-bitmap-size-wrap@trailofbits.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628152331.82122.408afd7b466c.iommufd-test-dirty-bitmap-size-wrap@trailofbits.com>

On Sun, Jun 28, 2026 at 03:23:32PM +0000, Samuel Moelius wrote:
> IOMMU_TEST_OP_DIRTY sizes its temporary dirty bitmap from
> length / page_size.  Very large selftest ranges can make the
> DIV_ROUND_UP() additions wrap before allocation, producing a
> zero-length allocation while the later test_bit() loop still walks the
> original number of bits.
> 
> The selftest helper does not need to support unbounded dirty bitmap
> sizes.  Reject requests whose range cap calculation overflows, or whose
> range exceeds SZ_16M pages, before converting the value to bitmap
> allocation and copy sizes.

I suggested to limit either the length or the kvzalloc to around 16M
as a practical limit

> @@ -1686,6 +1687,8 @@ static int iommufd_test_dirty(struct iommufd_ucmd *ucmd, unsigned int mockpt_id,
>  			      u32 flags)
>  {
>  	unsigned long i, max;
> +	unsigned long max_pages = SZ_16M;
> +	unsigned long max_length;
>  	struct iommu_test_cmd *cmd = ucmd->cmd;
>  	struct iommufd_hw_pagetable *hwpt;
>  	struct mock_iommu_domain *mock;
> @@ -1705,6 +1708,15 @@ static int iommufd_test_dirty(struct iommufd_ucmd *ucmd, unsigned int mockpt_id,
>  		goto out_put;
>  	}
>  
> +	if (check_mul_overflow(max_pages, page_size, &max_length)) {
> +		rc = -EOVERFLOW;
> +		goto out_put;
> +	}
> +	if (length > max_length) {
> +		rc = -EOVERFLOW;
> +		goto out_put;
> +	}

This is some huge number, so big that this breaks the logic on 32 bits.

It just needs this:

+       max = length / page_size;
+       if (max > SZ_16M * BITS_PER_BYTE)
+               return -EOVERFLOW;

At the top where it validates the arguments.

I revised this patch and merged it.

Jason
