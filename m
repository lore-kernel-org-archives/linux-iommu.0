Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC502D060B
	for <iommu@lists.linux.dev>; Tue, 26 Aug 2025 12:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756211817; cv=none; b=BdDi8IeNCpJHxWukMMw4nSZBjdPzXHnIQu6xv50pdkvMb01UX7uBwHUFsMlj+zXdtxtM3oG1YFjsuClYdXe3FQ1Z3a4qMX/m4UMKiL60pRq9tdbMCysh1LSV/ZARQqzTsATkUJZuyhT5impEEQdoGHelS8VOTWvtmrYKtvpiaeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756211817; c=relaxed/simple;
	bh=D8LK1h52u7FTE7jNOV0kzrk9gkDffkqaUwmZGkhUfm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tvprGnks1DN0U0V6d+OtALW0/pHFWNRBIy9at6iXAs22Anb323TINNCOd43cM9kpHsb0KgAa8ibtlzKCK1xzKZN5qdW41xNGnOTXqhWZjyZySK38ny0oMLQq5AJiUQUlcMSalmdhxLQb1jJFyzZWGJNdY795caCqw3Sj5CdFC9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Ueg7p4Hy; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Ueg7p4Hy"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76e2eb6ce24so4325378b3a.3
        for <iommu@lists.linux.dev>; Tue, 26 Aug 2025 05:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1756211815; x=1756816615; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mFuBdDpmjTxJPIC+jvTVeeAVDsVAAyhX1fX5Qkry/n4=;
        b=Ueg7p4Hy/4yymrDRzWltmiMN9f989pgo8ReFP2Aju0rKyTnSTMGPvyNizsVgluIdZ7
         NhDCgMrjZA4bEJfHsXNzkIWL/UFfF+pSVmR6WDADbcXxxR5Nrr7ub3OupRrxCO+NnRQs
         egfM7B+/v4a5mULMZMmwvDcD6LITs93AKqRU8ehgrpVVPY/r6CNM3biX1HkcF6Vvg2/r
         dQfrwODWxu4S1Pja9g/jg25iajrlgiTzb8fLlgTgJAFA40fL34U21FawpgRJ7+qCAaUk
         j6R4tS8OCZ15Q3wXDhJsIOdMoalfpwlqqJbUD/qVfWq2mvMGyHfBVV7Kqs9gdcjp65d6
         DWvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756211815; x=1756816615;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mFuBdDpmjTxJPIC+jvTVeeAVDsVAAyhX1fX5Qkry/n4=;
        b=Xz7VEblTmBd3azX3JE+GbBQQL604Caxu4QENs5s5YZsjvH0+avSPFh38VhR5QqDHWb
         rInghzyHPwDdSOVjCEN9EhRqD8rsaBhTYLCnBsCeNdRgPQzq4RoLSUwIhZNFLvM0euRI
         WTFM5wzF7//zKDR1Luc2jeZcTBhOnXBD2U3CCFiCzq+MkjANpN9aGwXP5z/Jj2XyePaa
         MZc7jlTKiz7yGdmhJrsdtHTOWL7pXUfBn5zANNJnwXX/F+bhshVPasXa6w1GQnZyG2uO
         YpcL+kfmdvUGxOr9/ttJHIUnbtRNVLaCysAMOQtqlhC0adLRlR6lvZPorK96PBM4RCy/
         DxbQ==
X-Gm-Message-State: AOJu0Yza99ynJss5uzYeFhvSWrmiqd2BTo+pVUT2k5PQPHt9hNbYJUw3
	2g5ZBU9RRN35MLE2ItA2c7yKgtfFfyIZn+9aSo19H7vTQize1tjWAvewhiZIH4jtRI4=
X-Gm-Gg: ASbGncsjAOxBmrKzBJKfRL3b4/7P7Gxr9mYSlMqoT3XZAMto+KT9t4i+Z1n99/bKPrJ
	2GjdBGpz9wH8KSjLW0okQpAKZl4JvaDYyO6mB6Kd+T4jtMfrgX3Hd0ZDjkU0UqZKJbo0+1D71Px
	5fg7CXHapQvJwjQA0mAUKNswwQgfKhqQv+McanDG85UEp22LexEq83IbIx2i6K7B2rACW7MyaWg
	mC9gWO31sCuldqLQSyJVrvc72vqNwHtDtlOPZ3hcQopH4ea66ZnGY5yxlUHw+ffhlI9gIYbEHFp
	U2Ei43RZHcPaGenIHEJQOUQJor3z+EjmtWO1xsby9f24haadJiurP+kdK+tUARmsYblV3w8ws4Z
	cg3Q6oJA=
X-Google-Smtp-Source: AGHT+IHTh1g6nVXxG5B7xS4T7Fnw4NLjAQ3OfTl5DHXo//wtjXBmCj82vaaqojPvv0EPFyup1w2yOw==
X-Received: by 2002:a05:6a20:1588:b0:204:432e:5fa4 with SMTP id adf61e73a8af0-24340b5b6ddmr22663293637.23.1756211815043;
        Tue, 26 Aug 2025 05:36:55 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3275933d6a2sm567538a91.23.2025.08.26.05.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 05:36:54 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uqsuz-00000008tQD-0mP5;
	Tue, 26 Aug 2025 09:36:53 -0300
Date: Tue, 26 Aug 2025 09:36:53 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shyam Saini <shyamsaini@linux.microsoft.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, virtualization@lists.linux.dev,
	will@kernel.org, jacob.pan@linux.microsoft.com,
	eric.auger@redhat.com, code@tyhicks.com,
	eahariha@linux.microsoft.com, vijayb@linux.microsoft.com,
	bboscaccy@linux.microsoft.com, robh@kernel.org,
	saravanak@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	lizhi.hou@amd.com, clement.leger@bootlin.com
Subject: Re: [PATCH v3 2/3] iommu/of: fix device tree configuration for PCI
 devices
Message-ID: <20250826123653.GC1899851@ziepe.ca>
References: <20250806215539.1240561-1-shyamsaini@linux.microsoft.com>
 <20250806215539.1240561-3-shyamsaini@linux.microsoft.com>
 <20250808121515.GE377696@ziepe.ca>
 <20250814233018.GA31418@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20250815003958.GE599331@ziepe.ca>
 <20250815023236.GA30997@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20250818155310.GG599331@ziepe.ca>
 <20250826011557.GA2980@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250826011557.GA2980@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Mon, Aug 25, 2025 at 06:15:57PM -0700, Shyam Saini wrote:
> Hi Jason,
> 
> On Mon, Aug 18, 2025 at 12:53:10PM -0300, Jason Gunthorpe wrote:
> > On Thu, Aug 14, 2025 at 07:32:36PM -0700, Shyam Saini wrote:
> > > On Thu, Aug 14, 2025 at 09:39:58PM -0300, Jason Gunthorpe wrote:
> > > > On Thu, Aug 14, 2025 at 04:30:18PM -0700, Shyam Saini wrote:
> > > > > or were you referring to [2]?
> > > > > 
> > > > > In that case, the PCI child node data needs to be parsed, which is
> > > > > currently handled individually by each host controller driver.
> > > > 
> > > > Yes, this looks like it may be what I was thinking of, the pci@1,0
> > > > specifes the BDF effectively
> > > 
> > > In that case, we'll need to parse the child DTS nodes properly
> > > within of_iommu_get_resv_regions(). I'll include this in v4.
> > 
> > Kinda surprised this isn't happening already? It would be good to
> > refer to the original specs and describe how whatetever you propose is
> > aligned there.
> 
> Just to confirm, does the v3 version of this series look good to you?
> If so, I’ll go ahead and respin the series with the iommu_set_sw_msi()
> change and address the other review comments from Jacob.
> 
> Otherwise having pci devices nodes in the fdt or dts needs additional
> handling, let me know your preference :)

I think you need to consult with the DT/OF owners on these questions..

I've forgotton so many of the details here.

But once you settle on whatever the DT representation is it looks like
the right direction to me.

Jason
