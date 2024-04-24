Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1499316D9C5
	for <iommu@lists.linux.dev>; Wed, 24 Apr 2024 23:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714001995; cv=none; b=I8qnAea9Vts0GoI069U/xDQjoqQu60k4l8IBO9RTqe/1NIoVZc2vIEkFWcnxNIPucM+/bekb60lEhlpDHV1h19W2+hPM/HT//drEe7nMo1cjK9CQ431EyLoeVF+9Kbct16L55BjOvbq+DIHajjISKw2XzVLXtA4QLgysUFfkBOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714001995; c=relaxed/simple;
	bh=2O0o98ggkAQaDI7rP6itKxJY1fyhiAPS6wTogNwU5hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7JABcalenCK4mkTl0f67j7HL6FYmEjfnDa1Rqc4cO8Et3How0ROMTVZFW8xfqzSNcz91LG5KxNWyIqLh+Cjwyb1KRqLZaEDDHfG8wNBT6ycwI8laQeqL9Km8kvRNKV7B7nSmvJwJo5akNqhgoIlPnpKEgERCRE6rsNcO2+3JUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=csKtUPbH; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="csKtUPbH"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-232f2b86e4fso192880fac.3
        for <iommu@lists.linux.dev>; Wed, 24 Apr 2024 16:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1714001992; x=1714606792; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pu6etYv5ocPJpDTio+T7Fs2/aD2ssrnDfuoC/AGwC3E=;
        b=csKtUPbHxFdNqoM3kELyvR9DJc++PQPppnxgvNmKw9cSAIHHOAWMtdHvWVhgwpH+/x
         dMoqsnQQzmIgy3dTdf3PCilDMW12Zxaih1V9yM7vG0SwGduVifsLBcu/BMBwGn41dXoV
         PCFWXXhcMXR4PxAahyAlytqlEz0PQmWqUVNo0x0gxdMkogJ+taGiCkVvgPArSSqFJAKw
         CGDCKXyZKfeucy26vtILyr7R69g7nIYDWdBrE1bkzBG40OK4Oe5NC1HBjJphQgCzXTVn
         2wPonpvu8BMq9BGVaL9NT3vT5Ii06vBkheEFKyeVq4vjswdOMYckZatIyc1atww+8UEb
         ZoQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714001992; x=1714606792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pu6etYv5ocPJpDTio+T7Fs2/aD2ssrnDfuoC/AGwC3E=;
        b=hPIO5jhMHlG7DSTJr8vHWU5+X8HNidPs8cYTvE3IvW0Joiw92xiF4Y8WFcQ3w+57Od
         v/PcIgpmsXGStyLpOS2Ou660Pw2WUdACiYekV8XH/DqZZieiJLiKpR/WuIFjAqY+67SS
         NSOc+hJbdnKVRJSx4C2ZzuonOUHllLFgEk+j7Kdnx/AZXxwM38vUgrGFu29PnP/Kk/Kz
         fQA5JFkW2U2NqJZyFStDUolOe36iEs57XriGzbTeXsSKU0H3wjAy+ujDhCHtifLS/Dor
         DErd2yIAWcr/gJgzz9DQ86I8CqsCUUZHXTTbtTPJERxHWqtd6dmQ4izSHjZhzdpDEL2r
         Cx3g==
X-Forwarded-Encrypted: i=1; AJvYcCU6oakHaLI+NOBTduKIdEJzEtn6yxXMo8OZZbyUcACU2LBgTzFmoLp6Tvh6lOMZuoqp1YPU/vouIxhzARPkFHgn1qsvtV8=
X-Gm-Message-State: AOJu0YwJcH6qygl2gz2qKXn5bu46Tzqe2vbKKAVglH/iKCaCM8lkTLKs
	qsBZGPIJX0cdyyhDttAUbUWR4e2LxOsk5VoatboZnYaASRnQ3YrEnXkie4l6TYg=
X-Google-Smtp-Source: AGHT+IFHSoQmOFvkIt4UdS9vVvm/+9LOICy267nTOZxeYgmuzEs2JusAIDrqy2AljxZbMWh+yyg/Lg==
X-Received: by 2002:a05:6870:9602:b0:22e:bc50:3492 with SMTP id d2-20020a056870960200b0022ebc503492mr4335970oaq.47.1714001992183;
        Wed, 24 Apr 2024 16:39:52 -0700 (PDT)
Received: from ziepe.ca ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id pv10-20020a0568709d8a00b0023b50a85913sm78072oab.38.2024.04.24.16.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 16:39:51 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rzmDO-00A1fN-HT;
	Wed, 24 Apr 2024 20:39:50 -0300
Date: Wed, 24 Apr 2024 20:39:50 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Anup Patel <apatel@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Nick Kossifidis <mick@ics.forth.gr>,
	Sebastien Boeuf <seb@rivosinc.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux@rivosinc.com
Subject: Re: [PATCH v2 7/7] iommu/riscv: Paging domain support
Message-ID: <20240424233950.GJ231144@ziepe.ca>
References: <cover.1713456597.git.tjeznach@rivosinc.com>
 <301244bc3ff5da484b46d3fecc931cdad7d2806f.1713456598.git.tjeznach@rivosinc.com>
 <20240419125627.GD223006@ziepe.ca>
 <CAH2o1u5+XD9YN=gdMVtfkyhKoKha0UpwKgOVbCAwOQa+saPfRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2o1u5+XD9YN=gdMVtfkyhKoKha0UpwKgOVbCAwOQa+saPfRw@mail.gmail.com>

On Wed, Apr 24, 2024 at 04:30:45PM -0700, Tomasz Jeznach wrote:
> > > @@ -46,6 +46,10 @@ MODULE_LICENSE("GPL");
> > >  #define dev_to_iommu(dev) \
> > >       container_of((dev)->iommu->iommu_dev, struct riscv_iommu_device, iommu)
> > >
> > > +/* IOMMU PSCID allocation namespace. */
> > > +static DEFINE_IDA(riscv_iommu_pscids);
> > > +#define RISCV_IOMMU_MAX_PSCID                BIT(20)
> > > +
> >
> > You may consider putting this IDA in the riscv_iommu_device() and move
> > the pscid from the domain to the bond?
> >
> 
> I've been considering containing IDA inside riscv_iommu_device at some
> point,  but it made PCSID management more complicated.  In the follow
> up patches it is desired for PSCID to be unique across all IOMMUs in
> the system (within guest's GSCID), as the protection domains might
> (and will) be shared between more than single IOMMU device.

The PCSID isn't scoped under the GSCID? That doesn't sound very good,
it means VM's can't direct issue invalidation with their local view of
the PCSID space?

> > This seems suboptimal, you probably want to copy the new design that
> > Intel is doing where you allocate "bonds" that are already
> > de-duplicated. Ie if I have 10 devices on the same iommu sharing the
> > domain the above will invalidate the PSCID 10 times. It should only be
> > done once.
> >
> > ie add a "bond" for the (iommu,pscid) and refcount that based on how
> > many devices are used. Then another "bond" for the ATS stuff eventually.
> >
> 
> Agree, not perfect to send duplicate invalidations.
> This should improve with follow up patchsets introducing of SVA
> (reusing the same, extended bond structure) and update to send IOTLB
> range invalidations.
> 
> For this change I've decided to go with as simple as possible
> implementation and over-invalidate for domains with multiple devices
> attached. Hope this makes sense.

It is fine as long as you do fix it..

Jason
