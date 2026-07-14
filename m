Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DBF3E274B
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 12:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784032713; cv=none; b=n5S+b4gK528OtaqbelmsFWiTBs5BGXkaDiwl5QzK+faXycsba6SYPqGAuPwYISB/peHNJBr/XAjyzbt4t9m0ibutkyDdJvOrj+Sf5miUE99yLUG+MOmbXvtrLoeubyNSdwZ0JDrqQrmkStd1CjAYUshFwAIaCQFYJLWsaYeovbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784032713; c=relaxed/simple;
	bh=8TqqkY3IBsbzBVYw+q3ktkE/39IeQWw7Bw8XDmzpVyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BezqEoTFtFRWyefvnlbDON8P4xISLryx7yQDv1w5CCyVAR65nEH3V1xDDbI2a5ueC2hxcN8gKwddHrxxNTWf4/UvvRmhbVIuqP+lkl466MdSkJWTcJqlCUJyI0JNOlDt9vToVYK8c2hUW14ZrSlsYkoO+B5vqzDTxdznKk1nuWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=UW/IRRja; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UW/IRRja"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c01089e8aso6871091cf.2
        for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 05:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1784032708; x=1784637508; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DxC8uHlWMD2PYfvhPMzueM09X2E4SQiFlwC0qjYAtc8=;
        b=UW/IRRjak+tmu7vHvZozUtgwRtm0wIcrMPXb9USofdCpANOnt/qNHzpP+zZChHbhvs
         CNCYjIuNd4/eKKPoY2GkoMC6w2l2UI3XjW5ybw6siATM0QM+mHbM4CY/SUDuMNcE9Qzs
         9yThNnsN+TpHZl9vJlELnGD3np38ueSV+G7aWqR+69pejna3Ml5QH0ABUdjh58obs4ji
         x9b3At2DlenJmeyDC20Ridy+PQd1C4ac0FyclkAccRyftcw/a0EEAWMeNeZ3SXRlz/o3
         CRplyblQ//03cAGaNEfj6SeW4uDHFVZXDr8Ga0brEqmVQuKolcGZvIqEu+JBjzsLOrmA
         wDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784032708; x=1784637508;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DxC8uHlWMD2PYfvhPMzueM09X2E4SQiFlwC0qjYAtc8=;
        b=IoWMdEITdYdBbevWCmMuU/mTC8uiDO12gx/tw8QKn0O/yz9FCTjgWzgfOLVNpPqWas
         ekOWvJHu60L/SsLhQKYaPpnMpXxcu2m1RQM0RNEEUHQjjRZ/MhA8xllZ8C167zLDDHn1
         dqqOJpS7KR4wYtUG9IjVlL38+41EaN/ezD2s3N+enfXnBjQOl+1O3R/5P3gb2h0IUiUa
         Vj8c7gn4cerMbpWMHyyOTlaJt9U4dppBHE8+i1rnUzZgDyGi4FMejvDqS1sL2qO+PZRL
         1SV6tepjoS/Q6XU2Xnz2/Im2Pt0iAGVawFLLBYv2LuMQvoi8+TJBY0kO9U6tVQzN394+
         pH+Q==
X-Gm-Message-State: AOJu0Yw02Bg8RCMtQ+4hF7DHGs0BXm14eS3DFsoGaXW9EHoUlxBfQ9mJ
	1xiugrez1fzzA+LoFPZCmPQK+zj6AV25thMrezo3TMtG+3DnB+Q+LBcjbTmxjY3OnvFeUVYT7pn
	IfyEX
X-Gm-Gg: AfdE7cm6DR4mr35GkFBp/TMhuRsya0E0ixoXDY0DZ0sD4EgTTem7+F3AKkMa4z9t0dg
	AjQSuoxsBJp0uPYhVu8or867MP5QbColzC5lcSGAtv6dBz1B2IRovC9XmjjtIRB+nmRElPXAtAv
	ACcEoZagYcEdMSowgvGbfXCxDOpe+A2HcwiwifuKknCNGwSqGlIW+iZctJOUOmsvCwkIPDSeVR+
	OlA35FrEQOL842cc4jdjrYt54p4NzkkSwaLTGBfmBTFe+ZQb4XYlHE9OjoSPCFcwBvZuPBLC6yE
	7kFV1N75s2i4GUfyHpcHWJ6fiO2HcjfEO9EHyg7AaZqNhHI+jZBGC8dL9Kegc+Lz9has1fkQ3eg
	fW0watzz6wVDpKQrsdczr5qYOjSaHsW4KaBZvorNbm3bXGj8/D/WgwTSI8L87Gk2QkRa+YM4=
X-Received: by 2002:ac8:5d4f:0:b0:51c:164b:b241 with SMTP id d75a77b69052e-51cbf05b77cmr128588831cf.13.1784032708276;
        Tue, 14 Jul 2026 05:38:28 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caaf611e5sm110460461cf.23.2026.07.14.05.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 05:38:27 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjcP5-0000000FSx8-15jL;
	Tue, 14 Jul 2026 09:38:27 -0300
Date: Tue, 14 Jul 2026 09:38:27 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: weimin xiong <15927021679@163.com>
Cc: iommu@lists.linux.dev, kevin.tian@intel.com, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com,
	xiongweimin <xiongweimin@kylinos.cn>
Subject: Re: [PATCH] iommufd: fix grammar and spelling in comments
Message-ID: <20260714123827.GI3133966@ziepe.ca>
References: <20260714024440.188358-1-15927021679@163.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714024440.188358-1-15927021679@163.com>

On Tue, Jul 14, 2026 at 10:44:40AM +0800, weimin xiong wrote:
> From: xiongweimin <xiongweimin@kylinos.cn>
> 
> Correct detach kdoc ("device/pasid from"), article use before
> IOMMUFD_OBJ_*, and "propogated" -> "propagated".
> 
> Signed-off-by: xiongweimin <xiongweimin@kylinos.cn>
> ---
>  drivers/iommu/iommufd/device.c       | 6 +++---
>  drivers/iommu/iommufd/io_pagetable.c | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)

Applied thanks

Jason
