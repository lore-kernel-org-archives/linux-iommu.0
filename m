Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DAB6D52F
	for <iommu@lists.linux.dev>; Fri,  1 Mar 2024 11:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709293815; cv=none; b=MdYhTIvbqrOiVzCMn0jWxkndTTC/Cs7bAyhbmQgXwu0oS2DQk3hyXJYF77tkxelsNoLQiK5DmrEu4h+kpqst9KTXb1ZCPGZtBIsfssP0VtDErEjAJJXVjU3LI7smUJGT9fVoaKXTRql/hUU64ecCNz/j1ezms1pf+xMImSyqCJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709293815; c=relaxed/simple;
	bh=v8Q6Jl37N2zGR/HpoxxGmiaWTFVZujCX5ASqmiZFrbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=iCUk0KP0+I8HBWkZpWVUtaMhZMt37iPYnD9B9FdnYhiZZHWxD3uX1+ODxAw0STeAbK0F3cIiBty3QptFy779aELWpANFlMSMQoF4Scxab5Ip/avjGMbmy1PhpXT62siCGm7Wz2IDj9mnmeB3thWBpSxXr+Wbi6LvS8qhFIuMcd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UTOQlnpw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UTOQlnpw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709293812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FfXTaDiZwo/oZl8lj7bR+2VUdXCLhRKEwJk47+amUD4=;
	b=UTOQlnpwGej5R/GRVj30k1LJhUw4zbbMmB/uL5YL3TsASdGL/PnzGnP1W+vWSIzOmNGkqs
	rDF5UlukU7apPcaUvtRiphXHmqnSmUI2+q50hpJpzqia1c1IwWLlqIJD3RykjmtQG2FF9T
	heZnv3Cd4z7oNbIes2+28UdELqjlOqo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-OCC5GP8lOC-0RL3yIprfIw-1; Fri, 01 Mar 2024 06:50:11 -0500
X-MC-Unique: OCC5GP8lOC-0RL3yIprfIw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a3ee38c40baso176805266b.0
        for <iommu@lists.linux.dev>; Fri, 01 Mar 2024 03:50:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709293810; x=1709898610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FfXTaDiZwo/oZl8lj7bR+2VUdXCLhRKEwJk47+amUD4=;
        b=ERWPUaeKnZruC+3WM+TUOOFVlAgTMxaCWYzslnQhCHwW7DaRnGrEA98PuN3JVJw/Px
         FWNetfH3nfsJwfwVj6Bzs5rIabdSgc77ZFtWrxkD2PQsof0mvzZ48TmQff3QFCLyhkt+
         ZG4JfSfqDvHcBbkyY2AriXBjIaTt9O+AWfpcnqZq/F71RPdgt3omlAHD/UtqzYR9MXFA
         l2e2OgMJFrPoY8nY9lzTD0G1w48ttBAxv2tVnNo2JGmnvg2T8p4Zjaglzvzm+mmuIhc4
         b16o0naY4XRYCMYimdEsVmC9lpj5WF9sqb5ENXZSNJyiAK5rCLEwbrfZcTHb6VHZQcIN
         jZ+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVcML/TgrNu2d0cjGf9eqFQAmVxhN1aaXbNf4JGvZnsXEyN2rdzsFDq/6S63hCqXG4yGOkirKF9VaPZgP/RxHKbESYRXz4=
X-Gm-Message-State: AOJu0Ywff94r9s8SuK4imlzUOIR9c8WHZ5jls7uRjtMSFduyKSfX2r96
	Cm2BgF39h7WTFxscSO2eKGhMKPUX/59ubNuQ/ZZudHsADesjxQpIA5n6rWoGLTEIY9hBX/jvw6/
	7fVbIJ4y0dbxVSZu/R10wG4xZEiUswY1IQJCqrRI/h+waR60nQSU+
X-Received: by 2002:a17:906:6889:b0:a43:f825:ef52 with SMTP id n9-20020a170906688900b00a43f825ef52mr1165091ejr.28.1709293809870;
        Fri, 01 Mar 2024 03:50:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgSzULUZjY1B+qQ1X+GwdMQFa+cNtdHXqiMvqiMYETfuq7yL9oj929clF85P2IkH9peSUsVw==
X-Received: by 2002:a17:906:6889:b0:a43:f825:ef52 with SMTP id n9-20020a170906688900b00a43f825ef52mr1165062ejr.28.1709293809432;
        Fri, 01 Mar 2024 03:50:09 -0800 (PST)
Received: from redhat.com ([2.52.158.48])
        by smtp.gmail.com with ESMTPSA id cb17-20020a170906a45100b00a43f1feac16sm1627108ejb.88.2024.03.01.03.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 03:50:08 -0800 (PST)
Date: Fri, 1 Mar 2024 06:50:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
	Zelin Deng <zelin.deng@linux.alibaba.com>
Subject: Re: [RFC] dma-mapping: introduce dma_can_skip_unmap()
Message-ID: <20240301064632-mutt-send-email-mst@kernel.org>
References: <20240301071918.64631-1-xuanzhuo@linux.alibaba.com>
 <64be2e23-c526-45d3-bb7b-29e31241bbef@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <64be2e23-c526-45d3-bb7b-29e31241bbef@arm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 01, 2024 at 11:38:25AM +0000, Robin Murphy wrote:
> Not only is this idea not viable, the entire premise seems flawed - the
> reasons for virtio needing to use the DMA API at all are highly likely to be
> the same reasons for it needing to use the DMA API *properly* anyway.

The idea has nothing to do with virtio per se - we are likely not the
only driver that wastes a lot of memory (hot in cache, too) keeping DMA
addresses around for the sole purpose of calling DMA unmap.  On a bunch
of systems unmap is always a nop and we could save some memory if there
was a way to find out. What is proposed is an API extension allowing
that for anyone - not just virtio.

-- 
MST

