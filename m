Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAF0337BB5
	for <iommu@lists.linux.dev>; Wed,  7 Jan 2026 20:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767817696; cv=none; b=FOeUj4DNLizYBsbs9wTVJcwB5r42FpvfzquciECjJMvHyrbvoqHCwF/7bvCOXq4Q+rZDq4ddvjkmicVCDL4iq7FSn/JXGYVgbyE29zNNDytB6g727xQnkJ5ELb3p3W0zTjTR5nQ/vqV/pyO8SGT/M6sgsgnHt0bHK8YcigMY1vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767817696; c=relaxed/simple;
	bh=Pwy+IfpUw29EKdohqqAF88REx1vjQAd1kd9B9jRJpfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ahBYhs+wgX62I7OeVFqEmNM+rYal60Ki67OhDFvVZNyE7ziU4kVLwLmxlqI17eqfBykIge1apgw4HG4NxBOOHgxpJUouCJyjO+HCQfLzEevZHQczxT9aBfecqGWqEeq0MOACnbhC4rA6EzUXwfkDwJ7fca29jQKXluV3vxKRg8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=WEW2TFQX; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WEW2TFQX"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8c0f15e8247so330837485a.3
        for <iommu@lists.linux.dev>; Wed, 07 Jan 2026 12:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1767817694; x=1768422494; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pwy+IfpUw29EKdohqqAF88REx1vjQAd1kd9B9jRJpfw=;
        b=WEW2TFQXAKYPjkrjyUGa3yEH6jtRNPsttChguJinmmahIHPsesJosZ+iDtflE4SzZg
         g8hINKyp4/CJHl7L77ob87/EmZzP5g11H8+qlMXznPsp/vXKyNX4AUKSkum/9mqNJsjb
         hA8gIdO0fjVMkwAWbINLaBtfKPZ1LPFhloQQhCxUF2zvqzPGjWCRFDQSjfGoglRfZ05s
         9JZwabt5vhKJE8o2//GrgVK96K2dezTIiygtesM7owJ8UK1h/qv5zPEMWEYFO+uH4C0B
         e8h4UniEDaJz8VMYEpUIrA3rYYUKjUhAq07bFGR9op2uMQqCSwBGCHAvoef36TTAzUYv
         v7Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767817694; x=1768422494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pwy+IfpUw29EKdohqqAF88REx1vjQAd1kd9B9jRJpfw=;
        b=N5ZyCS/gBDBN2EgHQfoGJs4RAUAQYPHTXk6Gn4DbgyLTXHBYzuEebh+yuLYYFTmz5L
         ZF9G6wZdXFxRjPP1tNr+n9kLlG66gQL5mGHGMFEYy3XZ0YH3tlw6gTgP5/GxpHRGuXhH
         YAjhWwLY4AvIJO8j2N/3y72idx9tTDDrHLTvTKO98Xix3G+Sbm3xytlw9Deonhw2fvHB
         +r/pSpBgmVEtYaQdKg7KToeOyGrXYNRbQpXySzmLlHSwTyboRh8b6QoP0EsJYneQkmqm
         tsuG28g8T7HZAjqxnXVLuArTGY7NqqB2EigAnRTvYNLP35ERNG7eG5usi6KEgeEb2ZTr
         PfMw==
X-Forwarded-Encrypted: i=1; AJvYcCWucSifPlUDWjDtaB4XWVY3IW8kwc9QjLzd5IrqnwdDhVXZcz9JmsU+8WMsASjNLDYvKQpA9w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz9JU+QMVURmF/EHi1/d7NF71uP2X8YXwzTAmkpunyiVjY4korf
	2oh0+jhE24RdDyHw96R9k0XbIsi+DhUZ6euWV8uAP4WUOMuUvxsLnFkYN8KA5+lNFUw=
X-Gm-Gg: AY/fxX4g50gPGMv/XnNp1A95K2zYf2R6PqsmfMJgSVRZqc1j30EtXaZEv1o8edIO5vb
	xZM4V39zg65EWfjdkW41eMA1TmhqIY9OasBwO89xFGYQZ2sAq08xWBkQ4uKkVocB/6WbCdNSuZv
	Rw9EjghxqfDvStEoumb1/J4T3oOztC4xaJ4Sdmx2Cfr2xrHPq8dG+H/CGBqftWXllRGtYMf7rB4
	UGQmh3HaEWs2pINMC/K647kzTHq7Bvw1cfpIpgnMseJUSffx8WlN64KD3kEiCnmSwhDipuny5mM
	5/booDqzRDK0rDslzZhSn3rrIcvJuJ1x8e+Y6moFPECob2jXDNBSig06gJB3Yu/3xltV/ehOwlo
	2jU8LAXDwh+igJZUZr0SS5SZ6Yv/L8WuE6x53FqYkllBY6ytf7W3hobLBZXqe40qsuPjb6kI7sN
	NOIOCDhOGVwUZUOFYKpNJqXm2ziPISZ9qKSvqI3omaB6GZk0z2eaQxHn4NT8TUMEitXDM=
X-Google-Smtp-Source: AGHT+IF1CHjyh/4VwE2Qpy7k+jz5GQV1Ds2jksHNp2vXpQ1aZAbgw8ISXAflbwZAAcJeQ4w7G3k3RQ==
X-Received: by 2002:a05:620a:191a:b0:8a2:4d02:eeb3 with SMTP id af79cd13be357-8c38936c94amr459388985a.11.1767817694411;
        Wed, 07 Jan 2026 12:28:14 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4a6145sm441707785a.5.2026.01.07.12.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 12:28:13 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vda8a-00000002F8Z-2Bdq;
	Wed, 07 Jan 2026 16:28:12 -0400
Date: Wed, 7 Jan 2026 16:28:12 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>
Subject: Re: [PATCH 0/3] iommu/vt-d: Add support to hitless replace IOMMU
 domain
Message-ID: <20260107202812.GD340082@ziepe.ca>
References: <20260107201800.2486137-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107201800.2486137-1-skhawaja@google.com>

On Wed, Jan 07, 2026 at 08:17:57PM +0000, Samiullah Khawaja wrote:
> Intel IOMMU Driver already supports replacing IOMMU domain hitlessly in
> scalable mode.

It does? We were just talking about how it doesn't work because it
makes the PASID entry non-present while loading the new domain.

Jason
