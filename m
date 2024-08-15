Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B4A7DA7D
	for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 13:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730395; cv=none; b=eXkv25ImsBe4NRqzkND/yoJKHE/y8463jWV2w71wrwcutPb6Kqvj1q4b4MWTw9oweplrkZ3wENdY+nUxcs+nkUBcmIqCpPD9y5IHhZ1a9aJZzrTLuUU6/OKX5Gr4kyEzM/E8CjPmKwDA+C02THf1b0PFEOE7imQVHt0xth0cPZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730395; c=relaxed/simple;
	bh=i3+GFw9Kb+1vg/wagAiTI6DAAGXtT4Of6H280gyIteg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GyckU3lzSWHOt8j7Ot+NnbFfy8t/HgGaNvebUprhBN9+qfTFd18RfXZ5Hbefw6KDfmbss43N7BwTHjtHufJMhqTN7aaanFMFtE1cUgByQR5eXYF+wsnpErNq4cDRJZJQvQbBl6A0GAs8Sybzi+8wvtsxct0QJXBl6/LY6I/67iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=j044yQpi; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="j044yQpi"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6bf775d1bdfso2203576d6.1
        for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 06:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1723730393; x=1724335193; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RvUa6R9Ngwkz+XHKPZK7VQ65M31ZGD3yUkDY22gLioE=;
        b=j044yQpihfutdN1rJQhoS1Iu2ERBCosIHsc3Pi7IeIm/zugc/Opml4yYGXCPzIFeA+
         h7CL9CJWsZL3FLZkrN85josGsqtSmB0f3NGB0NdHX/9alxt5VFbc8eszmtkTu9LWbFPy
         NZvWuI1TwoqfDQ/59X5cckTJDrMVXDE56Z8cMXm627VEnTMqdA6rGTwCDRAG1JgXdhEJ
         ZmFEsAi4272HayS/4dz32VvJ8YO7F0rKauZCEf3NVcAZtiHrwvZUqy2/SvJRG7Rr3wTU
         mJ+bKdwyEPzuF5Xv64CAOOUkYlMT+i35uElfP7ZXXWZikDCSEYtPiQlYaRdR2tclPWh8
         ww3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723730393; x=1724335193;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RvUa6R9Ngwkz+XHKPZK7VQ65M31ZGD3yUkDY22gLioE=;
        b=inPQIc4liY13fGvNLsx4M+4d3g3EGngukEhGIFllUvglQ2cHi5+8oVaOejeL38SASp
         8xIsZdWRrC1AcaNnv6dmzMwkZ9hvrS+4Te4YoFBMVjcJ5QUvMQX2wq+4DOoveOBCG4fw
         AAqyBTTmmM+iUnJTdUZxI3wY2L4Q/1lsbcQyd14S9xka3ObYyBPoSirMAX9eD7OqNzWB
         kaHxbtN7zqBj8C2roCN5iqHVnuUTUPDrrN4b8oFJQvjrZ9MN0GmTknY0sqKobPg3IZlq
         zIHUTkig74KDUlOmMv/mCxvZhRG/x2fW/gU9RbFBNpWcOjwWLYgJcbYljs+2RVU0B6ds
         UTqQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8xauergjNIPFmWpewpj2z3kQTAwJUz7nK3o8VSn5cuik5J0FvRvuqYQLso+uyuih86zlMYnTTV1m7FHVb7R/KVvLV9ns=
X-Gm-Message-State: AOJu0Yxh4qtMBf90Xna5svRtfJl7oPg/FMLeBnlhNOYUTpwQkFRACCXc
	Bj+kwAICfRaVn9Ld6YmI2J4HwETKhxs72hHkkSs3RQPSkw7WMdftqtPSftXUHfY=
X-Google-Smtp-Source: AGHT+IGoyA/8Iq/P+2JCZgm5EBJMl53zENEDiocnjbraFpHg4YpT96fqlFsiW0Tns/OdsqGyBH6Y+Q==
X-Received: by 2002:a05:6214:3202:b0:6bf:7acb:ff4 with SMTP id 6a1803df08f44-6bf7acb1aa3mr5666206d6.52.1723730393194;
        Thu, 15 Aug 2024 06:59:53 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fef3124sm6542716d6.123.2024.08.15.06.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 06:59:52 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1seb15-003IAo-L0;
	Thu, 15 Aug 2024 10:59:51 -0300
Date: Thu, 15 Aug 2024 10:59:51 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Mostafa Saleh <smostafa@google.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	will@kernel.org, joro@8bytes.org, jean-philippe@linaro.org,
	nicolinc@nvidia.com, mshavit@google.com
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Match Stall behaviour for S2
Message-ID: <20240815135951.GM3468552@ziepe.ca>
References: <20240814145633.2565126-1-smostafa@google.com>
 <20240814155151.GB3468552@ziepe.ca>
 <Zr3m4YCY7Ape3R6y@google.com>
 <91d6574d-c67e-484c-ad96-91c9fd3d0c43@arm.com>
 <Zr30BjAcVDKJPv3B@google.com>
 <20240815125919.GH3468552@ziepe.ca>
 <43290d6c-004d-423c-822c-7b2558badcee@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43290d6c-004d-423c-822c-7b2558badcee@arm.com>

On Thu, Aug 15, 2024 at 02:41:52PM +0100, Robin Murphy wrote:

> Unfortunately we can't do that, because there *are* RCiEP devices whose data
> interfaces are native AMBA, and thus for whom stalling is not actually a
> protocol violation as it would be on a real PCIe transport layer;
> correspondingly, it's *because* they are not true PCIe devices that they
> can't support ATS, and thus need stall support in order to do SVA, so things
> should still work out OK in practice.

I wondered if that would be the case.

Looks like if we want to do anything then arm_smmu_ats_supported()
would be the right place.

> >          if (dev_is_pci(dev)) {
> > 
> > Though I have no idea how the GPU driver that wants to use this
> > works - it doesn't seem to be intree :\
> 
> It's not a GPU: drivers/crypto/hisilicon/zip/

Ohhhh.. so it goes through uacce, I see.

Jason
