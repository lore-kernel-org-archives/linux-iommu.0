Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B9030ACF0
	for <iommu@lists.linux.dev>; Wed, 26 Nov 2025 18:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764181332; cv=none; b=Qh4qq86FH7CSwu58yIQvfnHlQWxSaobNF1SCSJWHhS59hbgLIjwpR7JL6fSQjjxqNWV7WYml0amrw3Edb5EFUXIFmV8O7SrGkmARBpbtkGBN7sa6SKjdBWbVaiZrdiSvTc7pkcBCmis5MrdsI6I5jiUNOfv7mQjlpQyyVFk3saE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764181332; c=relaxed/simple;
	bh=JIffUHW/SybQCLCBlH2E2/WPQRMwm/ANevb672L4zvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0tHjHyrZ+KwP+oMhMxv+CtzUT5KP5wqRXLd0lNqSXzSEsJxBNI/D1YYdM6dwSD98nsup1SI5EoWXUvWVue5kKg23mgdXtIZYyZ7pCM8jEXy2tbWsDI5hgYnUpzDpaKzpRFR6NOpjY+8EQn2BmpA7P5+BnGJN/jxI26LuSbGnRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=onDTpr1P; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="onDTpr1P"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8824a756771so1043836d6.0
        for <iommu@lists.linux.dev>; Wed, 26 Nov 2025 10:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1764181328; x=1764786128; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z/U907VaMhbY9//mqwOrvEDrs07VSJFQJVoQC08LGfc=;
        b=onDTpr1PZvlxJ+DdX+APiwvdGIrUPNlHxTh38LWMmbTazZpd157wmuWWL6vRR4Z6hi
         wTUcgzVcfyOPg6XH6ma49o4kLK4rFXiKiHFyav7cAiVWagUqcThD05N3Z9daKnxx8tF+
         TmMaFwLUYfV71l2CqLOEIBtmC5TvoyuQY1Ru6OSaRHkWd2FIMHvjRW1R8i6z5SmpRzSb
         ydSmIjfKRfCPDeDd5c1Biw+N0r7rl7t9TwMGoQoiKY0Tzl1vqoALV8ZP5DK8yFuL8adp
         tzI0ZOJGebav6rcVjMYW4NTZekOkv+jORXVP8JOiww+KB1GcxOYPRUvVacZ7U5+TOSM9
         uSpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764181328; x=1764786128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z/U907VaMhbY9//mqwOrvEDrs07VSJFQJVoQC08LGfc=;
        b=Pq5BtglrW5I58fukF3WXbW7htgWVLXurDC6WpUnwp4l3KUW0YxD7G6AWOs5NC26e6o
         bJL6tPOvw1BE3UMYDzaZ8u0ClIdWyHNo5zmq93vHWIFo4W+83dY+LpssOkk8s3H9U0MV
         bjnCvMS/8wO3e6H/opTMB/aSI3yWxXh7ZPBu1F7MjUA34I6JnreCoVbK8WrpDT6wCDFq
         xr+uLkSvgBEIfuf3N10ZDbJ2Rf1xg4C0PdmikHtq8VxFnqKCsxoj7AYTgnfJ8AUtb/dA
         cXZjMXZq5Z4sSO0xDbgaL/zE8L6wzW6siKtD6dmaEzIDNYvqEhpWRGkmYlzs8gJAAyZy
         nrjw==
X-Forwarded-Encrypted: i=1; AJvYcCWZSLr3aYssoiLKwebw0bF0ga6AJq5NWp0q0GZ5vvWR41d7b/5L3PxgENqlMWQpD4R+PXW1rQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz3SVC9YTvbX2hx+lvkLo9zniuIa2IhRyT6DcF9w9R+136T4eq9
	XwOscKetyju3XavMatChCA7QMd7nLtId5c+6mzfJ63oBtL9OgMAupuIuL+gUnzpPDTM=
X-Gm-Gg: ASbGnctHEnTKIz6ce70OLEM+/ZiC1cQcQFkOct00rl60murJYEv3zKVKxLiWBiWG2iy
	/pXiQzH4Ibo+i+5XNnp0MVT3WSZA2Ef1ZhQrv25JpJIhRCop7GAOsQWOtIHpx4eZmWeLTTRtTP8
	KWYS/Bu3pAh5RLvFSBreTowRtOv0LJGTeXGhwXkbtBlkg5YKZPOA2C3VL6bc2LFhEFYtCLcGHGJ
	/FvkZUoLgxRj1DRrw7xk/q++2Zk3AL3I7o/tVlmNt+lQmuH2yPjXXwQS44vVd4moUXwTLvyb2n9
	EnVQqWvRXECfSXm3o0R6kEpjDg8VstxJS7CBmaW9XCy0h9eWWmgQTTL45nbQ4V3iuVXk9Ct5apS
	PzRQW4nuWGbP2dPGgmPEvY69vukgnVLiT4i9v4YwWlDEQ/a1wH7jT293ryAPU2aqJjVL84JtPfI
	eWQ3HKn7uIwkN4PVwkXbtpAlsienLh9VLGPyd6hdZr7dk+8yHP9owLkcsy
X-Google-Smtp-Source: AGHT+IGk5aVt2np0F+0SUeq9bR/s3g/04Xibzoz3lycRYe8682b8OGK1SU+6oo6F+0oYAkhKjHiqfA==
X-Received: by 2002:a05:6214:319c:b0:880:4c2b:1c29 with SMTP id 6a1803df08f44-8847c4e0295mr324140726d6.31.1764181327832;
        Wed, 26 Nov 2025 10:22:07 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e46981asm149710776d6.13.2025.11.26.10.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 10:22:07 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vOK9W-0000000349C-2YZJ;
	Wed, 26 Nov 2025 14:22:06 -0400
Date: Wed, 26 Nov 2025 14:22:06 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux IOMMU <iommu@lists.linux.dev>,
	Kevin Tian <kevin.tian@intel.com>,
	Pranjal Shrivastava <praan@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] iommu/arm-smmu-v3-iommufd: Separate vDEVICE allocation
 list
Message-ID: <20251126182206.GB542915@ziepe.ca>
References: <20251126033602.28871-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126033602.28871-2-bagasdotme@gmail.com>

On Wed, Nov 26, 2025 at 10:36:03AM +0700, Bagas Sanjaya wrote:
> Stephen Rothwell reports htmldocs warnings when merging iommufd tree:
> 
> Documentation/userspace-api/iommufd:335: include/uapi/linux/iommufd.h:456: ERROR: Unexpected indentation. [docutils]
> Documentation/userspace-api/iommufd:335: include/uapi/linux/iommufd.h:457: WARNING: Block quote ends without a blank line; unexpected unindent. [docutils]
> 
> Fix them by separating vDEVICE allocation list from preceding paragraph.
> 
> Fixes: 9f0b286fe40130 ("iommu/arm-smmu-v3-iommufd: Allow attaching nested domain for GBPA cases")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/linux-next/20251126125920.207fc959@canb.auug.org.au/
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  include/uapi/linux/iommufd.h | 1 +
>  1 file changed, 1 insertion(+)

Thanks, I squashed this one line

Jason
