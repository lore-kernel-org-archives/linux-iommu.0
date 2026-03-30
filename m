Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C323290A1
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 22:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774909856; cv=none; b=eItNBiBnT2NJlQYiSGxaNYFEdAjwfV7uGg3Dq5zFmYg4jKUz3GIBNDacx+zUPBryz1uwHfo5xO5YIA3P9xknfE2/8U3aXCX/1EHTCNulTBmATKY9IhkVXt3+g9TiOyCkDuvUcXAjkHEyokl4gx4Die3yFGs1sPrptOjN66a61Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774909856; c=relaxed/simple;
	bh=1xBMZPNh6gPQSVfte56TfHDQQjUttxQo7E6pWxBUiOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFe+GhY3UQuOy/mq7saAtyeJhOxcomp3tSqYB1ZsUEbIkgvfu/YIBHgjXpZ0th9hjzK4g6OnQb/ck8wTlP/5e+xTJ45ZEQHOrPc5DDNplSNKgReEImdX4E9FoW4ytwUeNgRnOtFnjDWMeRQDUBD5Ni7Nd8jPWi7rm0aRu3O/wWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=C1DRrxJ0; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="C1DRrxJ0"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8cfbbf35354so708550685a.0
        for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 15:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1774909844; x=1775514644; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TPgjfuWm74JPHi/nBulPrKzhbkBSUwgKba+pCSQrHm4=;
        b=C1DRrxJ0lB4a96HE5006imPlkspiHeSGjha1mhfsadl/7d2cPhPthMs1QSgVm1aKRd
         7qP7ZMoTbOIT6kifCiQPiTJCN+p9+5NPx/Yhp4F/QbqK8ubG0X4JIVrooQ5mSHVctJ9Y
         8TXwHYQTCeKfdlAL/iDuDj6acEWguZkfrauTPIj8HTkJkRzpgyjzsm+8CLKp1DTM18P6
         eTN109i092eU1OIrZiIf8WSU1p5OzJaFE55ucgoXUp02xBa9pABDX5xyoDy0kjQjlS/s
         aVcZZTfqUZN+GB/ujFgJC2T65+XvNPKYFJ0RAdFybEheH+yJI3816421cTLRvm8XIAaW
         Qfsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774909844; x=1775514644;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TPgjfuWm74JPHi/nBulPrKzhbkBSUwgKba+pCSQrHm4=;
        b=qACt+YRGeE3ESydwztWKwfTVptgcSHabGEXBL0ASb8hPI44UZhuWyzcW3X+G+oC2Wt
         8ky9cCHe0X2s4EbDES7g6cRQpazuYY9YmLi/fjnhpB7k+k4UB2QBG+rVFKG6kZFsa38Z
         D9HmuTrYac6vWwuNuO9NhLbX+is5jsVfjR34sY5uAYZ0pENZ8Juq2mcDh4ihoehsJNMz
         DQN1YusmAPNdL96ue6tkObzAVUGfUhjkPJWf7MBKil+QFnEvuifnVQtVLWqLhnsWprT9
         7PWlcSclmcj+6bIBp95/Lp/cRAexS6P9rdlzg6nSI4D7yWiql7sffHpaeDlU2mXDzVjf
         SEwg==
X-Gm-Message-State: AOJu0YxaTDmIU89anTx2jqMft5PyTQu/1q0JibCohWppVx+NgYMNV2vv
	1uSHgMLeKuQrGs3hSQ6/KbjmCGHSBpVnjYQsv8zvVs+sN1XGc9ONAMYD+wFq1nXJ7ko=
X-Gm-Gg: ATEYQzwrl+Ac1lKqXIxBHixK6sMLvmOuBk+Iv5SmeGuWuvdKvW1GmquUEtbFekI5CKO
	gc0LJ4UAnoz7uF+ThrdJ5Fl1PB4jlnqOValxIq0MK0jQHIWRfD3NgOCvMhmGdXMzf/gIm3zsKVH
	VgSs2q6W5bZnLUgT3QRtpaqRgLHxNptlBVSxha9FoKlzYh2oy+cnpDxtwP7PiDN6UIPkAsALZaV
	SeIF5f0Kq2RYURDiXA4b7GAake53vwMEs7MIQ3/4Z+q4e0tsaJ28q82GzGFOXgYQ8QN4ISZvfJc
	vzuoyBzg6QrO/0wTlVaHzlPr8PJJ00t+qVv5h/Mg8mtZAe5342zaplzkCYLEQyWhWb4/H2215xS
	iqgEYh1BA3bJ7LrX7BRLXd8DfPz68mdgJiIv/HYF3vW12AdQ9N8zpZhQrU2iCzU/YChr5hgB2cI
	Yted3AxK2rwsMV1ZOaCZYExzXMRRsAHIcglUVWrHvCRZ91jymbFMAXVy5/nrlvDqw7o2hIpA==
X-Received: by 2002:a05:622a:40c6:b0:509:1ffc:c538 with SMTP id d75a77b69052e-50ba37f5b1bmr196111651cf.19.1774909844000;
        Mon, 30 Mar 2026 15:30:44 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50bb2e3ed5csm83384511cf.27.2026.03.30.15.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 15:30:42 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w7L86-00000005I9Z-0JYx;
	Mon, 30 Mar 2026 19:30:42 -0300
Date: Mon, 30 Mar 2026 19:30:42 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org,
	maz@kernel.org, suzuki.poulose@arm.com, catalin.marinas@arm.com,
	jiri@resnulli.us, aneesh.kumar@kernel.org
Subject: Re: [RFC PATCH v2 3/5] dma-mapping: Decrypt memory on remap
Message-ID: <20260330223042.GH246076@ziepe.ca>
References: <20260330145043.1586623-1-smostafa@google.com>
 <20260330145043.1586623-4-smostafa@google.com>
 <20260330151900.GC809900@ziepe.ca>
 <acrh26HVqbQ8B6Eu@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acrh26HVqbQ8B6Eu@google.com>

On Mon, Mar 30, 2026 at 08:49:31PM +0000, Mostafa Saleh wrote:

> > The one place we should see a force_dma_unencrypted() is directly
> > before setting the flag.
> 
> I will look more into this, but my main worry would be
> phys_to_dma_direct() and it's callers as I am not sure if is possible to
> preserve the alloction origin in all contexts.

I'd rather have a very small number of places that recover the phys &
flag through some convoluted logic than have it sprinkled all over the
place in ever layer..

The helpers were not helpful, they were much more confusing.

Jason
