Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE653CC7E3
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 13:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778853272; cv=none; b=t34ifUhHDyVF0AbqcbiuUPEfFDZ8k07JlVhxvZEFUMwknAzR0g5H0ZQmeox5w5Go39m1gtxroW3SM9EQNo5L+qYpq4/Gh98504TOGrcfloHEHJPDCCuq2Y6xSny2qDmKohX+5U8XzUDbWj+l9lTMOnnublHONdF2TYzjPq+p6lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778853272; c=relaxed/simple;
	bh=ogaB8c9WpDZ0HQVoAmC1+/X0xgwqdjj3S/BcAjNZTxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WodOlQstOiSoOR6Y9PYlOku/+u9wuy/oEFYrhri1rVtexRNz0+tNYevePKhXToTSK7NMhsOxTeK4Mi5ijRP/IrQffSyTo9NkToxTfHHzr27a5DaG/1pDegFQN3o932st3TBpQBXaDKE0J0m5A6s6JNZGb/2HsMRhdg5e8uzNl3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=TkpYQEzw; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TkpYQEzw"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-911501a99feso178117685a.2
        for <iommu@lists.linux.dev>; Fri, 15 May 2026 06:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778853269; x=1779458069; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d7sJIQD9tWQIe4BdjnAe96u8pxDyEGA325KU5uwZDdI=;
        b=TkpYQEzw3YSWklE3gUqZTexPd/DQFVAScGPUolbZJpR3haoYv91lhKBlsHtYupbAKg
         6cvYXVbJrmzaWKLeC2Hpfg1Qek4d20cFySaw0XtK6BS/WjwrHacl0HlcGSEA9k3neXef
         xsU2wlKiKYKu/KgChKcGCJdYcyjhgvGWToYH2wSKj5IXJoCYXM0UqjAlM7XBp5Jz6aVp
         NMmwqAhi2UtHMnBw23Usi7j0GP3Ae7V3yC1p3MehyjwZAdsOA5tL/gBv9xNdmdndAoZA
         s9sIR4dPFZiIJOh3CZYl/dSBOLH8Hhjl9kEQ3PgjRMUjuTORwU4EFklx54OaemAMq+su
         ZrVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778853269; x=1779458069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d7sJIQD9tWQIe4BdjnAe96u8pxDyEGA325KU5uwZDdI=;
        b=pXAmZc87BHszBFbDEuhG1LQjb6qunGo2X3m07FkK4jmh1sw91Usw9kvF1JNNXAaw5e
         E6IlHivRwW408cX9uLCih0bP/sIjrlpvyHp4XIMoU9xIHIJXJBFdxSlbc8f1TiA6v9tY
         7sQegRpkiD9C/ysX8N46Yb2T9XYXuqmWWzOE0FAfjL/Ff+8AarJM3RgHJLupSmnjBANf
         YU2ZdliPD+BBe8Trk6JTx4dT6At/XPr54zbmYIqlibQsdn1Xws6RG1K+ErhffX2AH+Wh
         OgRRK63ok5T7Pojoq8ceu0Ki/+coLimf11we+H8wP+uaP8dJ4wrWRzfiuYVNOzL7zLf8
         BZUg==
X-Gm-Message-State: AOJu0Yz5mq7Wzruld/D5pzP0fhiIVKzTl14BIhfQDRBE3PP7dL+rx4oH
	dIGwoMKWJ6Ppx6TNJHYYszdnhL1ZEppv0SkxmAgh2H85waJwTyY+fMvWDNS5ZOTkpzY=
X-Gm-Gg: Acq92OEsFyAmKaCbo4WMl0h9dYQhdnG1B21z6+y2SSW9QntuqAuyAJCiX3K1vDXBRRw
	X+44JqqIdbg/hQygxIaWLFuVpKRcRaHY8PERkTE20GVNKOIZTDPRci5d6Pz/dIhAaZJR04IP6fR
	dZPb05IRNswC3Yj5G8tPyq+R/tGRXy8ShqKqiLo7rQBH6zzU8jTaO3Dmm3HWpQuZXwmh6N/nSU5
	98CJvBEkT4F5GVQ9mZ0tYZ+UPgZuB0YD419/JQ76uFeEt4t3fUku3xUtZnCpWcvzJabZtE5yWBR
	jcjyo6ecoFWwrRLPYiABscW85cErEbCweifOzAWZs4pbq2PuJsKAz+t7Z1xErNHM6Ixt+3uEq3N
	QSh9xKlqEP0uB8P/xE8pydCQ5iMDH5yFogeGq9cKxTXRXwht5CCNb5J2/YMhtQrYiIwTTPA/NGP
	IjT4u7TEdLS2zuEWQvLaGaNLSGTYPISv7mAzs1gQ4Vxe+eAn1ifJdajuZeXsT35TAJu9zlPJpkw
	eFy3RoeqiR7pxyengU5HROC/JM=
X-Received: by 2002:a05:620a:7116:b0:8db:7315:706c with SMTP id af79cd13be357-911d0f4a568mr660861285a.59.1778853269479;
        Fri, 15 May 2026 06:54:29 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bae24879sm589818085a.18.2026.05.15.06.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 06:54:28 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wNszk-00000007TGH-1wJJ;
	Fri, 15 May 2026 10:54:28 -0300
Date: Fri, 15 May 2026 10:54:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
	joro@8bytes.org
Subject: Re: [PATCH 2/3] iommu/io-pgtable-arm: Rework to use the iommu-pages
 API
Message-ID: <20260515135428.GG7702@ziepe.ca>
References: <20260513215203.3852661-1-smostafa@google.com>
 <20260513215203.3852661-3-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513215203.3852661-3-smostafa@google.com>

On Wed, May 13, 2026 at 09:52:02PM +0000, Mostafa Saleh wrote:
> Update the io-pgtable-arm allocator to use the iommu-pages API.
> 
> Replace the DMA API usage from __arm_lpae_alloc_pages() with
> iommu_pages_start_incoherent() and from __arm_lpae_free_pages() with
> iommu_pages_free_incoherent().
> 
> Since the iommu-pages API relies on metadata stored in the struct page
> during iommu_alloc_pages_node_sz(), it cannot be used safely with memory
> allocated via the custom cfg->alloc (which may not be backed by pages).
> So, isolate that logic and keep it as it.
> 
> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  drivers/iommu/io-pgtable-arm.c | 79 ++++++++++++++++++++++++----------
>  1 file changed, 56 insertions(+), 23 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

I feel the setup for incoherent walk for panthor is kind of sketchy,
if you select incoherent walk and pass in a random GPU driver struct
device there are alot of assumptions suddenly to know the dma API is
doing the right thing..

Jason
