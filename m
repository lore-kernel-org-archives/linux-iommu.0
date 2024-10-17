Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCAF1DDC38
	for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 13:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729172045; cv=none; b=kUTi1T/JWiK3jKdg6VsUvEgG8J47zj3MRZG1cm9UrQsHemKmIYlzbfnVHK0R7NZq8jiAU2ljxjkRwAY240KjeFNhC7LNBSzGsW5lwEe+vvfJTnxq9zQZDwTnJqRmsmqo8FRfLW3dbqeh8xPQU0pF9y30dThPU6mMp6Qa7IlkJf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729172045; c=relaxed/simple;
	bh=Mf1+JT43Tz+BYr79VW5jSRDJ9xhw9gx53AcA4MX2gFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I30T7YjKkdfv0MXA/CmqO2cpHcqOPMefoCy4+6TyWTL3pSW7yBzQ9CqtVHwax8rDAiXg++0euoBhUaqwoIe2dSoQQfsvBQSl4fN5k94bdNGl7UxvtNvZp3Bji3QAcRIh8h+49LqXKki+O+K+n0Wq5cUgGnx6kqtGINTTuZhIBBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Gr5SZDPo; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Gr5SZDPo"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6cbd005d0f9so7298976d6.3
        for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 06:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1729172040; x=1729776840; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nhYC6aE9rxWcbW+HhvuG7wAba1HRaFUilEckgNlG688=;
        b=Gr5SZDPoFZq5uqhywZfw59Zy/TTyxpMGxzDwrFmjt5oap8NgslQvCAH6vHq3mYX/e5
         MoClkzn0RzhND3RZJUjp0z6ut6A7Lz+Wxhcq0KXcdSItVz30YnORTlVvFKRGlYJmH109
         mvA0rs3ePf+t5gNLZZwAvvgglkRWCwayI6w3kUcJI1faPXjMHpEvtDUNC8gIM1tvu3Jj
         76Kd3zaqMab95oYTaEN+0fSNUpj1ZnDj7yDlHpgvmymHJFvUMQplowzx6Al+1nAqprql
         cumZrqCxL7g4PznLGiSi97D1OTQ4WMZgxldgzyell4EYLEQmf2YhZmBtWUBs6YfnrVv5
         Ypmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729172040; x=1729776840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhYC6aE9rxWcbW+HhvuG7wAba1HRaFUilEckgNlG688=;
        b=fxiGXOvvqk7PkM2wCdSFmNN9LbQ8S6+doa9CgABy8umCBW8h59nvvQBao2yJU2jarU
         sgQ1QE0qblu530YVcrBBW91fF9lIjOM/Ln3SrYgCson94tXu1cQ5A2NLUduf5Fr+UmMO
         nUND/6SJVQzA4/WQtcomvtN35EbVZ2pUNPE0HzBvF7LTH40uv+XKjb4wv2mDSIdVbAra
         T4MC3OCCYl71IbkwoZyCxyo2HPgvczLhHEO3zFXZALO84lWuGy5nM7ZLq6Gxx1/m5Ar6
         OD/LKEHAe9ax5/ZqSb0ksPOYp/M922us4TcVBOXlvPrjv1ChwWxRdKR8C0HLvtkMEKLT
         BB8Q==
X-Gm-Message-State: AOJu0Yy4PduURjG+TAEYHfzI2cZgX3L+trx3/iEqf7WlT56hiholjadq
	2auCtVoSFq7gLSGDiLD3TjbTgvnPuErAV08mm+tTO4+0Zf9SnVth5893lPFVYFg=
X-Google-Smtp-Source: AGHT+IHjK33Flh6x59v5CCbcGhO4fuSlfhp4upUczXxrtL0vH1TuNfxkfaTb+53hqvq+QYRtf7iYCA==
X-Received: by 2002:a05:6214:5884:b0:6cb:e662:c59a with SMTP id 6a1803df08f44-6cbf9cb325emr255480736d6.11.1729172040411;
        Thu, 17 Oct 2024 06:34:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc2298feb2sm28001916d6.144.2024.10.17.06.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 06:34:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t1Qdb-003xx3-In;
	Thu, 17 Oct 2024 10:33:59 -0300
Date: Thu, 17 Oct 2024 10:33:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
	Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v3 08/10] iommu/amd: Convert dev_data lock from spinlock
 to mutex
Message-ID: <20241017133359.GR4020792@ziepe.ca>
References: <20241016053501.97497-1-vasant.hegde@amd.com>
 <20241016053501.97497-9-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016053501.97497-9-vasant.hegde@amd.com>

On Wed, Oct 16, 2024 at 05:34:59AM +0000, Vasant Hegde wrote:
> Currently in attach device path it takes dev_data->spinlock. But as per
> design attach device path can sleep. Also if device is PRI capable then
> it adds device to IOMMU fault handler queue which takes mutex. Hence
> currently PRI enablement is done outside dev_data lock.
> 
> Covert dev_data lock from spinlock to mutex so that it follows the
> design and also PRI enablement can be done properly.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> Reviewed-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/iommu/amd/amd_iommu_types.h |  2 +-
>  drivers/iommu/amd/iommu.c           | 14 +++++++-------
>  2 files changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

But let's still aspire to removing this lock and using the group
mutex.

Jason
