Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB74825F994
	for <iommu@lists.linux.dev>; Fri,  3 Jul 2026 16:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783095760; cv=none; b=PMfPx5/K9vz+N2gZTFuTDwJjPrLlnoWo8U47YsO20RPDErChr6SWCil8rLfQV28nj/mVTQ2WdtkAqrNFU0F9osQSJKnTwgPcYB/bhK+I8AwuhglOJ9VYQ4iPqzc9bxIMsBO4ZHBUo28dd+NuwMSBn/XQFZlct8MnHluseVwo2es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783095760; c=relaxed/simple;
	bh=aSTJpGK41WyhPg/DFuDyB7W70Z5oZCmHl+tJSqPEr34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQ+MVbobIKy1JNB6a8SUaQrLgwd7XfY+sD/Ar4YMQ4157S5PzsWVLMr+1KGApF4oEaCgdFc2z/kOhQxgxFmCr0e+YC0k1gtBWHHSnWyMUUh2ELbAigvtyP1JRFdS6a8LZYIzfQqXCUz+LS5RNGyjrKq2prbS7K2myXkNK+P94rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=M60d/to5; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="M60d/to5"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51c01089e8aso5875651cf.2
        for <iommu@lists.linux.dev>; Fri, 03 Jul 2026 09:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783095757; x=1783700557; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WtYDAcSKBPogYImT0V6Zc6UNBhRbPfbijSs6cr/aWvg=;
        b=M60d/to54y/H6X++C2BXsc7Lw6SAHdlWLHNQZcZO9XN30ydx8ABT+OZjjlAp/ihDrS
         7+x2t4hiW+/de3SvGj/Er8YzT5Nj+Zai9UlkMQ16gUPYnyPChuMSje6F6zAWTKlcUrD3
         JD1kKnqBNPLcJw9tLlBe++1f4Rg4O3r9PIn0jr4yMFHgqAEIn8Yq8gFAmTf7hBe53IGN
         Y7DI2xcunPZaWZq+t1+9u35QXKOsNMql+GwrrFT/EjL2a/h3Rh4Hd3zTcrsGeCEw2S/O
         CDAajVfV4/rG8+b6b/4ZKQJRsDsRgoa0TKZRwQNpYoZD9uMkdqTIoXVa90u7vnL91BgZ
         ygsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783095757; x=1783700557;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WtYDAcSKBPogYImT0V6Zc6UNBhRbPfbijSs6cr/aWvg=;
        b=Xye9WYrVh2JEqt2sFogvKR/kdQ8wI6DmqovG0oBh603Mron6ldE62dEqdb9upXCU+q
         5v1BXmlq6CpciO3EaapDwBdNKJrkVWMmf0xA4uItYiBOgAAH2nrT7kZaevtXAdA6LGcK
         A79d2LY06X3ieFVCMd3MO1cY3048LO3UrdrQpeiAZvUDr2Pw/28fAALYPMmfCeekKK2o
         9Rg6707wWrNVJbH1+9DDyv6HZCaNfVx+0xkm5butUSMWeZ5w728ysWKqFB5gLpgdApug
         63rQV9R50uLBsOzBKrjM8hxvQfVEEe8Bb2pV0qc/9oe5KPrQGB01qwZrERRbcMqfUXBv
         K+HQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Jtol87cjrx1Om/TeQrfcV7ab3ZJTmqdeQ0P/thDa115Ylyzr915rXNCban2vCKUgdRv78Og==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywf1Cu8ol7S0E+Kul4vWSEb4jJ+Ei7TcMdj9RBFvGfapj3zVQ1/
	LnlFa/lgT/IM39/La/oGX2jJX/nyPAXAQxnGKyRRxG/hr9iCRX7DYUjBiAI1Lh5PqYY=
X-Gm-Gg: AfdE7clWXU56YNaBIUNRucnt5O8bWP6NkPB0+uPaQYZTKatmBhv6HwtEN8YhZleD2E5
	nITl5OE8gcU+Mu6BaFJ3Bh9uTQeS1B+hrkDbra6DyEZYAYYYzY97QmLtdm9z1zVrvoNBlQkHX4R
	nbU6v3X/lzeNWtBuF47GnfRS13jFhLkwOSAA7JspziE1A1nGQ+eNQKBJOhblP7atS5pPm8zQZvz
	/c0VWkhhmyTSn7UZJeXj0/wi5KUhBD3suAdRmL+iOE/GqxvFTAQvLzPw0F4QAH+bqSuFwMEuJ19
	cq971DKsL5PdbMJj0Wr7B5rLhTQny7z+roWmFh4NHz6okVrSyhEgXd+fHFNy5QgsgVZCA+6tJtF
	Ixzx5Z1aBrdIpR+RHZ1SjPrXSrN5e3gW7Kk5pZ5UpJbspvrtHorE0e7dagaeSxFc6IlWaHbVMHm
	BMf3CsrDfuvpUPQmDguxqfaVKWRQZmJZrOwr5EfAtzaYm3Jtrf8L5UdW3fSMMIp8SAw02eslpdB
	C0Qiw==
X-Received: by 2002:a05:622a:15:b0:51c:17cd:1fe8 with SMTP id d75a77b69052e-51c4c2c1c37mr3358691cf.33.1783095757387;
        Fri, 03 Jul 2026 09:22:37 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c41d2d688sm20593451cf.17.2026.07.03.09.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 09:22:36 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wfgey-00000008C3v-04o6;
	Fri, 03 Jul 2026 13:22:36 -0300
Date: Fri, 3 Jul 2026 13:22:36 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	iommu@lists.linux.dev, Andi Shyti <andi.shyti@linux.intel.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	=?utf-8?Q?Micha=C5=82?= Grzelak <michal.grzelak@intel.com>,
	Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
	Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
	Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v2 3/3] drivers/iommu: Catch scatterlist length overflows
Message-ID: <20260703162236.GX7525@ziepe.ca>
References: <20260701104437.236979-1-krzysztof.karas@intel.com>
 <20260701104437.236979-4-krzysztof.karas@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701104437.236979-4-krzysztof.karas@intel.com>

On Wed, Jul 01, 2026 at 10:44:37AM +0000, Krzysztof Karas wrote:
> It is possible, when a very large mapping uses a single
> scatterlist, that padding overflows scatterlist's length field.
> This results in:
>  1) silently wrapping the value
>  2) smaller than desired mappings produced by iommu_map_sg
>  3) leaving mapped bytes in memory (no iommu_unmap)
> 
> Address this issue by adding overflow detection for previous
> scatterlist length field.

Urk, this is unfortunate, it means we cannot map certain kinds of
scatterlists? Meaning there is a condition that makes a scatterlist
ill formed?

This seems like something that needs to be more clearly documented and
we need to ensure at least the common scatterlist builders don't hit
it..

> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 9abaec0703ef..c403057577df 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1493,8 +1493,18 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
>  		 *   time through here (i.e. before it has a meaningful value).
>  		 */
>  		if (pad_len && pad_len < s_length - 1) {
> -			prev->length += pad_len;
> -			iova_len += pad_len;
> +			if (overflows_type(prev->length + pad_len, prev->length)) {
> +				/*
> +				 * For large mappings spanning multiple GBs we
> +				 * may not be able to fit all needed padding into
> +				 * sg->length.
> +				 */
> +				ret = -EOVERFLOW;
> +				goto out_restore_sg;
> +			} else {
> +				prev->length += pad_len;
> +				iova_len += pad_len;
> +			}

It is better to use
  check_add_overflow(prev->length, pad_len, &prev->length)

instead of overflows_type()..

Jason
