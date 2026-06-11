Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9561BD9C9
	for <iommu@lists.linux.dev>; Thu, 11 Jun 2026 16:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781195601; cv=none; b=pXf89ofSAratepFp1mf5MviZIkY+KEg1uCqVIPPu6j2KCc0j86pHNAUirpjlyTCxFq5ZhV8vVx8jauYVBxcOsOw0eO5YLUlJfv53ZsDFKHpynqbDVcJNcqN7xuDEF4cS5RMA8vEEuJyKw9SAjHruhps4SMFUX/sfqoa/6LGo+Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781195601; c=relaxed/simple;
	bh=7Rz/uck9FemFjrxC3sfBD1FDGz5n0wMB+PX/5/B2crY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jVKXZUlKJpzC5TvJiJwtmPx+/KXCBTKeQPVTGPXaBRot6i9Elox/RGYphZncScRcafId/NGmK3YWU5q2ugJeb7abE6MSZkj7yqN/OLhMqrJCZcXI5M6DZkL5xGasCN1jdFTgs8RL+AztaX+Wqw65snDfnwruUWovbNTkyeWgrzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Pr/EKjls; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Pr/EKjls"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51761d27612so94821381cf.3
        for <iommu@lists.linux.dev>; Thu, 11 Jun 2026 09:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781195599; x=1781800399; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tf3FfoqnJ9+cjTccQxxTp03MxEBoO3jeV0rLfBYktsU=;
        b=Pr/EKjlsqiVd5I87oAC3n0jALYSDi/8N+EVBZf+wM1Dxn18LVewvMZqecfxygYlDvI
         vUAYgHxeYuz8hY4R5F5+/QFnomJkN1JbNeeM7jzOLYg1bk0ZsK9+plr0boVU6mmM8mBi
         5oAoNq/Is7AAdwBhsLjC/N3fERuFq3ZtpPBhEjBsEEO0P4/eS5ntr9sdzmo6umQGoovP
         WG5a6RqyfEAdZ4k2QU+1dsin40fvc0ZMukQAOV1SWwjo3hD8aY+GCo/zVMzAob3A1f+h
         osQElW3Jbneimw53fTyLAcfoJ1I54GOTa4XWPBTTuSNKiAOvwV80zIppQ0VhZYENOWyp
         HDrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781195599; x=1781800399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tf3FfoqnJ9+cjTccQxxTp03MxEBoO3jeV0rLfBYktsU=;
        b=e5Vg13VAM4kWcN9H1NoDlleoYbMMFVHr/ZpP5q8ODC9LdLNRafS8YEISlibOPXELjV
         GMpJQjT9kdTkWxY4MjDGTd1Yz5NqDk2CSjoYd8X/SRv7E6D8iF1H1keK+Xu9TklKkxmZ
         JIHt59AMusO7BGw7J/QB4C/T4CJt6ubQzSznDC+X8ENaU7UoDAJITxHWxCX6oe5+dhji
         5+XTaG9kC3G7o6H3SaNqFrqjTK5qSMcmOBJRWUREzynrAGKWmMOKZx8aWG9JZPk77LZN
         tY2CVxsyGY2wuXs/uZbcYRR9qW4+JWYwb/MG4egF8jgMMCeQK/NzodzzGnGp3ysrXcdF
         yzKw==
X-Forwarded-Encrypted: i=1; AFNElJ9dYOsw2dcpgfXMLAQ3JC2hwtEfwEAcwAt5S0zxeXmCWJjIlTks5HMLhk37bW7mIvqsXXNsFQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy6qdeLh7rCQCmgYGrzyplsjsaK2XuPf4cISztl8LGTDPVHipsl
	mA4wsfWRKvTNbCudE641pWymxTiVADCPme8Djf87F2hsuigdqRUpWLDxfBYicdG3IDE=
X-Gm-Gg: Acq92OEArhaDVZCvEzmNV74IkdOoJEt0vwdF548i6WeuXGNZcZnbkEZRtOlXDxYMsRD
	oinZMHk91V+3Bbl0O6oe3dc48VjIAic94eaq+3dGI9A1Kn0c66rRNf40CXdWQz5SGK/ZT7MBxD1
	g81pTua+ah+zS+1Fj+d7EZnRdSFCdCFiHYigLbbRbRwyBFDOzzfWvwPhTxx9fgkNKLx8k1SSNHS
	E6+MrRZZvUwez4BpN/b26cbItA50sr5K51f4T/U1+bk6YPFdWE5Y0OVU21AZlBTC8UhrogQIPk9
	cvcnuy59w0D0J1SjVwUy3ttOlWSMCaZqub5H/UP5C7RvtF50FdzeXlf9fMRIyPcw7izwbPB3CTR
	ocZVBJbAl7XP0t+WWE9DCCdIA7yL9M9XzgeN9vx+E+i/9m+a3g7zUHcyjzNCh4P7yb3B3GjkeIM
	kzAyAaxzIpmh119epzVeNC3jd+XNNPKfU4kp1sToibUTs8yPr1d5gQ2uZTYVGoGh05Bxv0kl0JF
	Eyg4w==
X-Received: by 2002:a05:622a:3c6:b0:516:ed02:c85d with SMTP id d75a77b69052e-517edccccf5mr55036161cf.3.1781195598504;
        Thu, 11 Jun 2026 09:33:18 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517ef3ea534sm21939251cf.5.2026.06.11.09.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 09:33:17 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wXiLF-000000066Hg-0vrF;
	Thu, 11 Jun 2026 13:33:17 -0300
Date: Thu, 11 Jun 2026 13:33:17 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Joerg Roedel <joro@8bytes.org>
Cc: "Srivastava, Dheeraj Kumar" <dhsrivas@amd.com>, iommu@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, patches@lists.linux.dev
Subject: Re: [PATCH 0/5] Improve the invalidation path in AMD
Message-ID: <20260611163317.GA1453429@ziepe.ca>
References: <0-v1-a7b77c25974e+115bf-iommupt_inv_amd_jgg@nvidia.com>
 <83b8a0f3-2409-464d-a9e4-59b9eea926cd@amd.com>
 <20260611115611.GE1066031@ziepe.ca>
 <airU7xpucwkZMAo7@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <airU7xpucwkZMAo7@8bytes.org>

On Thu, Jun 11, 2026 at 05:32:27PM +0200, Joerg Roedel wrote:
> On Thu, Jun 11, 2026 at 08:56:11AM -0300, Jason Gunthorpe wrote:
> > Joerg?
> 
> This waits for regression test results from Vasant.

I understood he delegated this to Dheerja and this email from him is
confirming the regression tests?

https://lore.kernel.org/all/83b8a0f3-2409-464d-a9e4-59b9eea926cd@amd.com/

Vasant reviewed it here:

https://lore.kernel.org/all/4cc8368d-3972-47c6-bd60-7fc8b9c7be3e@amd.com/

Jason
