Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D5C27A12B
	for <iommu@lists.linux.dev>; Fri, 21 Nov 2025 19:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763754232; cv=none; b=cGc2P40lqpgadS/pCye3nwMopPJOz6OWChzyG+c669NQSaUtVN3brP/0xZmdmCCQ27tTJaGsYZO0jjUPGUjMDabmXKk0AXBtLE9Bmmq8bsbOyt3d/64Ec1/OOTeJW9b02Cy3rQpKLn0KtMKSkPi6ikQYscFZr2SMJ7J6HKCmHQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763754232; c=relaxed/simple;
	bh=Vasgf9iDnOBSzRsjeFpKd6WXdPHbFWwhpiKUPv24uSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ry9ED2CIbg5rq60yoWDiNKE1j0BMr9S66aQ9wjoqdD3zqSC8negiizUiNcTBtIGJRdPM8tqWAeN8B55vZLUVdb/61loAdR42Dca6FvvXQ/RrWNTJMzo29XJESbbj50jCYeSNgRgyXK44I8Y+N/pNDMpVVgQhKvNBRINKfLi8FxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=cJBMc5HQ; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cJBMc5HQ"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-88043139c35so22622906d6.0
        for <iommu@lists.linux.dev>; Fri, 21 Nov 2025 11:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763754229; x=1764359029; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+QgWiw8/91FDKWyOytQdo9DdOX1N/C2KE/jXm9rwyZI=;
        b=cJBMc5HQsoAajqXCNMdlHO3kxAOtYGk4On8a/7y33zFcmH7vv/iFUd33mJ7+OSzfA6
         gXQ3tUY7t8whioVQEMPxLEWbP6St69rxYIOam4inODMerDVlBe05+gMbiCuxKDbt9JMG
         K/0stC8jumT5hn2PWc/i06ggIBjTV7JvyOZaSEOtMC51aGvKTVHKJEDg9vLgMSxB+yps
         q86TRlR2CaZvBYXMs4BFekgZe3kFXqKDKMkF0k8pdZSfRk7/xAln0cWCvfbX09kr5yZF
         IennqBHJ0Rjoq38vwicI71gwTk+1sHuSC7kqBT+zqZp5YAQcXyS37gH3xjV2r33oFCB3
         6EcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763754229; x=1764359029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+QgWiw8/91FDKWyOytQdo9DdOX1N/C2KE/jXm9rwyZI=;
        b=eSi3cu9a6UUU77Y4WLhV+iSarsX24aEHf2FITRDh0NYLDvkcWV7uHDF4K5rktdIHAF
         v1qBPrK6I+q15uLTGNDz8BINBB1JsqYZ/YaS0aWiTzebOTRQ2wIPnfYZyIcXVbyXU/Cw
         Mz5NKP6H7dXHkEucmGxbZJ3KCouYPQGaBx/NtlgfV5HJIdxOGKGIxA4Yh/+LiROLiwOC
         bNTTRZUDAERKVJy3Epuur+skFUmSirR131ojNStA9i/2xYR6ELq6ZK0FF23TzzSq3/6b
         Qsg2X/0DlIhTRGf1cT6qsafAnoA6fw92VHzSPnbSv7eWTcz6RC66JzV1+pCtfiwtUOZP
         wmdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjxoMu3kBRVJzDEOo3ZPPuBz4kSYgZK0tgFv69sgLopTCqemvkJiiyg3EpxLCnkZPq69rwmA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywi3OYQfgdRHeDwjxWc6CS28f128EwdxZNCXS7PJ/jSSmoXiBFh
	lE9TPdVTD2b2qr0Rq4zVQbSOXfyOiL8lcCka5bBBb9rnL5l2ujC7n2PEHMwd1acswb+jLLvTSaf
	8IELs
X-Gm-Gg: ASbGncvtzQdB/pbHnSW62uWYozXalaLUB0FEd/Xcd+VgUNOBOWu8q8G82TC0lHbJphp
	5qn9dJ2wusovg60kjeCExGUFZ0cWQ60VAcS722uKgz7upBdoJLcFDOzRUEcjCZwv/I88kFs0DEl
	N9JZjsQV2i+HHsE9AXEi88HOohNxRRdK0DYySO47uQDXK/BBX8gCowoZZ+QuZrR75quuJNtsXet
	AiCDaS69OS5q0vPMXdph5VaKMKkN6BaiXI+o/oRM7wWw09YsAD4dXRZxzWGnsgErt1hZKnA6SqY
	sXw6Pc/86vftpiOWMQlcWkzhpEUbJSN/cHqqyHL/4u7gq9RE3F4iDdpuPIvKLu38L02Te3tBziE
	GOSnTaDOygpRjsnebOIZRtDd2n+KQsYU5/lCkV+UYm+jP/BCfVgpEI2OlKGYjxxv9IVeS0rIxtU
	QgDcoewv3JyCPLDKzlzOzj/sDLnsAitZ4+wFEt7C4RLf3HtgihtuHMNOG+
X-Google-Smtp-Source: AGHT+IGqc8b5OqtPTf0L+qTFhxqvDfLDQaT2MVNMs6H0B2nCSGrUCWV8rdwz0XmyTkzH+nMbULjcjA==
X-Received: by 2002:ad4:5cad:0:b0:880:52d3:9c03 with SMTP id 6a1803df08f44-8847c520c97mr64807786d6.33.1763754229556;
        Fri, 21 Nov 2025 11:43:49 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e5735a8sm45639656d6.41.2025.11.21.11.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 11:43:49 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vMX2q-00000001aRf-2Fb9;
	Fri, 21 Nov 2025 15:43:48 -0400
Date: Fri, 21 Nov 2025 15:43:48 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] iommufd/driver: Fix counter initialization for
 counted_by annotation
Message-ID: <20251121194348.GF233636@ziepe.ca>
References: <aRL7ZFFqM5bRTd2D@kspp>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRL7ZFFqM5bRTd2D@kspp>

On Tue, Nov 11, 2025 at 06:01:24PM +0900, Gustavo A. R. Silva wrote:
> One of the requirements for counted_by annotations is that the counter
> member must be initialized before the first reference to the
> flexible-array member.
> 
> Move the vevent->data_len = data_len; initialization to before the
> first access to flexible array vevent->event_data.
> 
> Cc: stable@vger.kernel.org
> Fixes: e8e1ef9b77a7 ("iommufd/viommu: Add iommufd_viommu_report_event helper")
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/iommu/iommufd/driver.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks

Jason
