Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22857464
	for <iommu@lists.linux.dev>; Tue, 29 Oct 2024 11:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730202126; cv=none; b=prphYNuVw+wiRyQcXtlPHgAw+80j+brembS2kBLlLHkvJGy7L2F3cEz2L7KgXOJioy4gFAQeh1TUM7VDFzCfBwW7tbF/tPpkrYpeOONNfe2mGP3wj/RedIETtQvEDcgds5P7HhvWk5WxJXMwP0rTtcVUE4Fl+ziN7AuE4lQWBxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730202126; c=relaxed/simple;
	bh=2c4RrWQo0qfgTGo6fjvWdjW9cI3yK8P5ZqQEESqswZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFUONcZ5ZBVHQ6n30AlSsdGyySX0qawBW1Gk5Mdow3yfp8z63Nps1prrHHvXDwOZw/s7gH9nOynxBhaF3LBAAa1IhGMdQ81EXYg2xqDTfAz43U15RUHHIBiyKw033LPqCKkyTBhsQTHgaqYlweLHVmy+N6nzx+JVbayhAQUIWAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=cgBAzH88; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cgBAzH88"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b18da94ba9so313035385a.0
        for <iommu@lists.linux.dev>; Tue, 29 Oct 2024 04:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1730202123; x=1730806923; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rfqr1xmSjvRoYVktxyQkBgXqxH8iduV6ufjGw/Vljmo=;
        b=cgBAzH88c22CXVEpdyLAx/tLwxiGTmkC34zaPeqcfTBI6kTKiGTWIMBn7F010ugUEM
         J+4T8pWBcvaBYnSDhmqHeBrnyp59y/B3wWu4jUTE3fKiJ2VeL3v5lUoQFGj+CYH3HBvJ
         BDyazy0gNeso8bsRXuAiM70xPYNCgDg8QObcVeSZMRtdFYRDwzqijQeAEB50Ed6YIV5X
         v+D6TbnVLZ0Mdin4gHYEBEeuOhkxrhF1R9a6AbWWr159K8JIuodeRpKqTPWJ2CnrPIVC
         QO0Pv+imlzG+sH04lpfYTl3jFD9WPAL6qHvln8pV2DPFgIlfuoaAsXBnLEgldbUq/H6z
         QkrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730202123; x=1730806923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rfqr1xmSjvRoYVktxyQkBgXqxH8iduV6ufjGw/Vljmo=;
        b=ukYEqI5jFzkE+KU6dnTOUzWJjMzGs9yvi3lWNdss+p0wpqbEiEJYtsx0A1t6yQ0t9h
         nALHaQEczryyHnu7BNpYNqgFl7m2Bhc2JL4G/BeqI5VCr/RNxl0yigV0garil9b6oDkz
         HO4Y291Z6pGdRgx7y7sCyN5hly6VwybKerqs8gRs/puNN1IsHlrMc4YXXM+hcYaxtesK
         glAqtMNfiHedgIKVDx+h/W/4CoAMlH9Shq3/F1PnhycSF1VfA2xckBna6yPyobforAPG
         trR3MvrGgZHKEOTt9elPjQlZCAGhEDHEnrip6tmFcWJXf7X+fwV0A69GDKCjaq/LINFE
         oj3Q==
X-Gm-Message-State: AOJu0Yx0cj0VJ3yy14Rh3MLBJB6Ok+YB4120kZVv37XsDRKjC49sBu7u
	pWV6a5AaxuONHDaxTTroWW0krg2drVGbfrQB8oCsEf6b8Ov9V66A1ihPl8qHMb4=
X-Google-Smtp-Source: AGHT+IEaewIW3xngY+XxdSogu+jXe1ZcFyS4HQYK8sv/FdkkTGMz5Hqf+U5c3WUpu3t/AiK/vrfEdg==
X-Received: by 2002:a05:620a:3906:b0:7a9:9f44:3f8 with SMTP id af79cd13be357-7b1a9cc0e73mr251535885a.5.1730202122746;
        Tue, 29 Oct 2024 04:42:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b18d2ab45asm411088085a.66.2024.10.29.04.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 04:42:02 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1t5kbp-00000000nX2-3Aef;
	Tue, 29 Oct 2024 08:42:01 -0300
Date: Tue, 29 Oct 2024 08:42:01 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] iommu: Restore iommu_flush_iotlb_all()
Message-ID: <20241029114201.GH20281@ziepe.ca>
References: <20241029112302.63639-1-joro@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029112302.63639-1-joro@8bytes.org>

On Tue, Oct 29, 2024 at 12:23:02PM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> This patch restores the iommu_flush_iotlb_all() function.
> Commit
> 
> 	69e5a17511f6 ("iommu: Remove useless flush from iommu_create_device_direct_mappings()")
> 
> claims it removed the last call-site, except it did not. There is still
> at least one caller in
> 
> 	drivers/gpu/drm/msm/msm_iommu.c

Yikes, that iss some scary stuff

> so keep the function around until all call-sites are updated.
> 
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Fixes: 69e5a17511f6 ("iommu: Remove useless flush from iommu_create_device_direct_mappings()")
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  include/linux/iommu.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Strange that 0-day didn't flag this in my trees. We really need to get
0-day running on the iommu list too :\

Jason
