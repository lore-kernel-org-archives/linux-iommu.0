Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE383B19CD
	for <iommu@lists.linux.dev>; Fri, 22 May 2026 13:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779456164; cv=none; b=hmVV693t9bE32sxtFIv0+3Ov+TszeHsGdsgMxshVP/iqAOiGFESES4aASDgEuYQSGqR/0eFP2i9QcpeQXiyaY9/Sqkh3xuIyKJxYxsZJ7aZV7gAOmnUoZQGnBZVcrEfPJXRm3Kt1wIFwal9HSwHDV59XWCRh9GVMt5TIN3b/HrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779456164; c=relaxed/simple;
	bh=iQuBEkHkP60iYe92EnrAsVFZKioHOoQ3fMLBNw/bYhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oCweD91rrsccHJx7S+y5RU5Bgc09kElXymSm+beNNXrmSgFv5tEh8Ut4rFC47r1FY7NWTwADcaXl46KVPI03WgH+rBSjuPGAU15EXqaefyRkwHr0QcS1nSDZwBMTS9B4FvaSDkfo6iUh38TbzO+8nLln4HKR8gZC9Xu7dDPC2ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=KuQeBvmu; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KuQeBvmu"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-910bb291688so877274485a.1
        for <iommu@lists.linux.dev>; Fri, 22 May 2026 06:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779456162; x=1780060962; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iQuBEkHkP60iYe92EnrAsVFZKioHOoQ3fMLBNw/bYhY=;
        b=KuQeBvmuWvM7kAhzjUPlSpFpXBFD2/RtdfGW04AwkWlE7KlatN0xLDxX06ZscJ+4tg
         66ROWKqm0WUDxMHzfC6PJzTzLrJI2wio1Xr22MzU9TKSQrrwdNNyZJy5Kguu8C9Ue8sp
         VwntvmUmXCOH74+gDSq2aVN1ZvCmu99VTZewyzh9bJ2H8V7g5JPwGcKblYWKrhb+po0S
         kjqkw9FrusCwVHfhbraJiw8OMQAxhY2g2Z+gLxH4A/1szKsiErLkVm0wMRn/sjx4kjrN
         jKY17W2KTG6b/R3905hxVlppG6KDswfulrBUdRiqwkbw5hTJcFWD/zj70sDkFlheeiwz
         7cMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779456162; x=1780060962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQuBEkHkP60iYe92EnrAsVFZKioHOoQ3fMLBNw/bYhY=;
        b=Zpjqf/GjNB4ypxAISU7pWVNi4W7Drwrt002ftzYbZXh/4TTrChuOXrST3x1aIgB0eR
         MY6H4px37qF4NggoQvy7PJ6qdnROmDSOuvkKfllaXsMSTr9O2SdMDskab0OkhcO5uzJl
         ka3ZOpMFU7VebNdMymAZ+DoDM4v/bbqiwuV29MbSfaajJCG2u+PMf4V2+dRkveIC9Ttz
         WstjlCr/Z9EQ4ps36V0JdUPgDwPR/uppN6yuW/BJACiTozIikbmmACS3vlgMNVAoEinT
         Rrv5pe72lZMXIpDFsFrX2+nKK57hJpb1nyy9WaAxcZ6RlKJzQonTNy5XODAn7NT3UuWJ
         mYKg==
X-Forwarded-Encrypted: i=1; AFNElJ9/z4eCq/iifzqY10Syv3IF3dLfHMxUbJd0M8klJYDYIQOwECuOOD3EosP9EzI11k+5LXlPOg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwI97gxKLpM4p+TkveaRYxkQviFu3CmHtoxyeM2c1y4HEuAZkww
	w6EgH3u64yTaUBmlTaPb9PP93vGw4LC5uProTJMoMJEROH5qmPQfqPN+8UrwCn/ZX0o=
X-Gm-Gg: Acq92OHyL+LT23qc/wG25ndpOEF8XTsgFCDWGujwNgTWsE2wf2EfkKNigb3W7JHdNKk
	Sk/CO2wQPdYBa3p58W6TWNSLX0PEahq5wTXrbhMAeB6URJPr5l7D0Q4Xpn8X2eiK1zWJ/HUdXpG
	a8vbliHNUVKAk2nQqcdbuuJm4JBGOAwYcZoBk8CC8K6GfBnZGfwGCYRIKOiJCag+cBJfmFn5niB
	67bilaMqm3SCpM6Kqz0kYEsYvf1X+91FvPkIANAa0vyg7NzZZ262LDalNwbmpsGJI7AeYyaVdIM
	Ty6czMI/LfsuAYWrdS40/KOx1Xjz+iedSGSRz7Kv8IZUJVi398HquO0p9NUfk6ZMs3yucxTlegt
	X0aGfNvGpsK7Y8ozG4lViUfw3QQ/QDU0M0S8/AAryTxA0r6u6uZamSPPmkcO14MRKn7W2cHhcVn
	kT27l5sgI2kUGRoE9jjLpP8cAaBjyx5tD7VJzwc1zJBacg1Lby14gH/H9n50f/1ewN9DzqI75ji
	hR9Uw==
X-Received: by 2002:a05:620a:a2da:10b0:914:ba0a:b62 with SMTP id af79cd13be357-914ba0a0df1mr206635885a.49.1779456161602;
        Fri, 22 May 2026 06:22:41 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914bb8c7dc7sm116726285a.6.2026.05.22.06.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 06:22:41 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wQPpo-00000003hPg-2B15;
	Fri, 22 May 2026 10:22:40 -0300
Date: Fri, 22 May 2026 10:22:40 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev,
	linux-media@vger.kernel.org, sumit.semwal@linaro.org,
	benjamin.gaignard@collabora.com, Brian.Starkey@arm.com,
	jstultz@google.com, tjmercier@google.com, christian.koenig@amd.com,
	m.szyprowski@samsung.com, robin.murphy@arm.com, leon@kernel.org,
	sean.anderson@linux.dev, ptesarik@suse.com, catalin.marinas@arm.com,
	suzuki.poulose@arm.com, steven.price@arm.com,
	thomas.lendacky@amd.com, john.allen@amd.com, ashish.kalra@amd.com,
	suravee.suthikulpanit@amd.com, linux-coco@lists.linux.dev
Subject: Re: [PATCH v5 1/2] dma-mapping: introduce DMA_ATTR_CC_SHARED for
 shared memory
Message-ID: <20260522132240.GD7702@ziepe.ca>
References: <4qdizkkoeke3cvkcf35upa7p7ick6s654eqlrizmi7ozkw5eze@tnpk2e34xgwl>
 <yq5awly0d504.fsf@kernel.org>
 <tteiecxfqy4k24wnzvp6ocxnuopyhmqtne2xwh5htwldlbzjnp@o6cbzdlurxld>
 <20260421121004.GA3611611@ziepe.ca>
 <yq5aik9jcpzm.fsf@kernel.org>
 <20260424225514.GE804026@ziepe.ca>
 <20260426130531.GF804026@ziepe.ca>
 <yq5azf1s6aic.fsf@kernel.org>
 <20260521175420.GA7702@ziepe.ca>
 <yq5aqzn45a81.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5aqzn45a81.fsf@kernel.org>

On Fri, May 22, 2026 at 10:09:26AM +0530, Aneesh Kumar K.V wrote:

> Can I convert this as an independent patch with your SOB?

Sure,

Maybe you can ignore it for your series, the intersection of CC and
P2P is non-existant right now. HW doesn't support it. Make the DMA API
follow the design assuming this patch is applied.

Jason
