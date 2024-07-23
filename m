Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED492157467
	for <iommu@lists.linux.dev>; Tue, 23 Jul 2024 16:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721753093; cv=none; b=pFi5OnXaZ0exCRuczM9oO6+zzSh8AbPm8LHa4wq5vwK7oQ6I2Lb0Jf1YLLumqIxM3C1qw3H9xOVYmgK0bRpLDKBP3nNNgiL/YPM8bnHtrm3eLn+XSu4aah7lT75e8O+Pl4JQ++c2uwaVYT3iB9vdaxUme6yku7icHySMqlbVlv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721753093; c=relaxed/simple;
	bh=Ig4E/sGbFfy4CAQniz2Edm1HXv+3iKpjfoqp+zMGzYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ap/x91qG2vwXdy0GEkVbtLrSvXZFhBjymEzzb8XrRXcb1IY0jcfc6KSa4fQeoOHCk2aC3DwZu+rtKgi9RNIsV55FFME/tPmw54+U/FQKn9+6zTB33jEc+DThp9vU+UnKiF0uapYwlYjB/zeHGaIwD4mZ1iUICJqrkJn3Ye0Fh1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=iJVmgSiY; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="iJVmgSiY"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7a17b4eeb50so357067185a.1
        for <iommu@lists.linux.dev>; Tue, 23 Jul 2024 09:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1721753090; x=1722357890; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RpztTR7ckF4gTk/zneDDuYYJyl6CLMKv3lbHaSsOevs=;
        b=iJVmgSiY7i+j2/c4uTXFqJBqIrlJg/D6nr4X21FpZWGfz4hkNpBQL+mWKhXualu+9j
         bVcBHe+sIzhp5t4Q/pPATzK9buCZ8WPn32M1xKc3A7E0G+UW4Hy6WOpPEukEDNE02oJ7
         wPiUukgOdCYkR4zG+aSIKQ+17zbjdjrA187n45xO5UZ3nXNK6fPNsBNtVeXpUC9lSETZ
         6vN+dMgh3ESn6qU1nbeMnOgkeqM8ixKDJfKef//T5v7+ofSps0lzZdwX3ohhQdQEjq1n
         CuMUO3egiEselYT/pfCYpE003KeRgz505sCGT/vlVhpGLKXreiMPFW3oOtgebgfDt4uq
         Zn8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721753090; x=1722357890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RpztTR7ckF4gTk/zneDDuYYJyl6CLMKv3lbHaSsOevs=;
        b=mXtmk9qnG6TsNxotM9MaoA+lqn+a1ctOwNdcJ70tSNsog3KupUcjL7s0pur/uurpVg
         I6ULdxq1AAcp0kIxo2HzB+GoVuHp94NuoROpJ705V42V5X6pSYEXDuYM+ohKOMpW+CxL
         lzm7U648HcNEB0MFeaimEjfn/OlyPLJ6rokjV/G7ABO+ehowwGg8Rci5CF7AA4MGglVv
         JTvZt7GbbAuRbzRXWwPjX4SX0eatWWGpf/kb34xRhJK6jR80X9PY+el3lY5AXH4HxqjB
         JXnUM1j9On90B3gDHNGhpamBcd0C5AnVAlbbr8NPXmMPq3XVSFSFXhKuEJA1k61Klzd9
         twVg==
X-Gm-Message-State: AOJu0YxgsBaOC7nwOcD6hwz1zyBirH6lRucHRYdNgT0KdoY/SeZmpPDY
	1b2O6eeXr/DzicaDRNWF+wL+YhaGqmuXiTRbNeqTh3sYRD4TNXerYZxeweE32Vs=
X-Google-Smtp-Source: AGHT+IFDLtbINzn8TXhwyJmAAH978Mm6cFwCpZA4+PXFa+UmGo3C9tSBVR9LRloxySY1dvsaBVZpYA==
X-Received: by 2002:a05:620a:178c:b0:79f:a82:51b6 with SMTP id af79cd13be357-7a1a654de48mr1244644785a.37.1721753089884;
        Tue, 23 Jul 2024 09:44:49 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a198fbfb7esm487876385a.50.2024.07.23.09.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 09:44:49 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sWId6-004lpY-Qk;
	Tue, 23 Jul 2024 13:44:48 -0300
Date: Tue, 23 Jul 2024 13:44:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH] iommu: Add support to change domain to blocked domain
 via sysfs
Message-ID: <20240723164448.GM14050@ziepe.ca>
References: <20240722115553.6005-1-vasant.hegde@amd.com>
 <20240723130507.GK14050@ziepe.ca>
 <e7a6ce53-c473-44d0-9177-b7dafa5c6aa5@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7a6ce53-c473-44d0-9177-b7dafa5c6aa5@amd.com>

On Tue, Jul 23, 2024 at 10:08:52PM +0530, Vasant Hegde wrote:
> Hi Jason,
> 
> 
> On 7/23/2024 6:35 PM, Jason Gunthorpe wrote:
> > On Mon, Jul 22, 2024 at 11:55:53AM +0000, Vasant Hegde wrote:
> >> Add support to change default domain to 'blocked' domain. This is useful
> >> for debugging.
> > 
> > But how does it work? 
> 
> 1. unload the module
> 2. echo "blocked" > /sys/kernel/iommu_group/<groupid>/type
> 
> > If you set the default domain (aka the domain
> > used by the DMA API) to blocked, then surely no drivers should be
> > bindable too? 
> 
> That's correct.

What prevents binding after being blocked though?

Jason
