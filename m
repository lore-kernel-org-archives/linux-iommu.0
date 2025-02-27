Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A2122A814
	for <iommu@lists.linux.dev>; Thu, 27 Feb 2025 20:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740688740; cv=none; b=VxL0nYcDc/MmHIQ93WhgYAOcCFYU82dKmT6xHuHvQKG5zAXQn58LTocOmCgDsvycVKRre/HQBIcZfV/H3ONWvDRC/lFidR8VudI2+gZfWYDxmlKndEeDdIejtVnYdeA7Rv+FYuN0VqF82QoEtF0iyNlWbdifK4z4lm2ceq/6S1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740688740; c=relaxed/simple;
	bh=tMLyfjj+PLIq74mmCTMG+2Qq5ezLhFjkwAJEJM30sx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKKXETLalegS7KlmoUnCl4ZY9CmJ0Tku8zo35PTAbjp9sv64Y1FxAXS21V2epl8HGTojyf6FGPan10C4PdphKvKAilUcPDIH+3tAprQksYPAuiXXzLz7Y0G9uuLlNp6i5ThYgfrRJC7uOq5wCFqDtdyobr2ajKAikidsPpMcyUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ZJ7iLV8U; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ZJ7iLV8U"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-474bc1aaf5fso2026101cf.0
        for <iommu@lists.linux.dev>; Thu, 27 Feb 2025 12:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1740688738; x=1741293538; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A8/Qt7Vv2+DDRlyzFkpTUnydrm+Dq5juNVKCyJPPEsk=;
        b=ZJ7iLV8UXlfZgVNa0lkzZOe5So48qq1gOHI/TydubvX2UM8f7M80utATSRRpc/nFDb
         HHv1c1cO0Upvqo8xC7Chtssn4nLKWIeWcY8sMc3ZjtGymsRlopVsAExgneQIU+ja2ErI
         0XyNlAg+jyb9qoypjxbTlpHiFaNUz7bXQhwAlV8RtEw0ikou6NoWsk2GhX1QlNLDfBoH
         br8jV1QBRhk3r7U62yxEQ41m1G6fhc5aCDSj5dhMTF0l3hCFHELaGo/1TwHi4oiKpO/1
         MNAV1omvfwSQVhk4rAEFtH1f1nXa8H6tpyaZyItP1T7l4unXmagWlTPvgcH9wWkHU1vu
         wg3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740688738; x=1741293538;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8/Qt7Vv2+DDRlyzFkpTUnydrm+Dq5juNVKCyJPPEsk=;
        b=qGQce4/iFmdpBCq33lm4gvoH/rS07QahyVEl4K8/2vjM4PUyBxA5r5j3j7J9qOYm50
         IPVkbMcDGOS+g3xA9OMIxTgBMvZ21J/9tEPcBeiDErs4T8qeUCQbFiwD5P9JQn+cr4DS
         OCuH41oi540WFxr7FfwyKxEDrARu/Wcl5u4gFTPZ2UOAdpGnaSTeDtmVF7PdWyM/bjKm
         EJGAYSMw4cZE2mcm+zLeRP5O307DdZxWDOQkNokhFxa3vCOVfNnXjVJh4BRdqTfgi0bj
         gDc+qHmcpQ+qZ/hrBXJjdC1FURmbwFj/OfU1pRkCtrJfrOTZK4MUJKPSC1zs/Alzw4Jx
         rzYA==
X-Forwarded-Encrypted: i=1; AJvYcCUGp+9kl1NvF1IOtK8urjWILz0W43Y7W0sS80oME+y+B2YxUY6GXmIpfT1zfTOTLi9Rrh3TTw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywy40s5I9nVGkt1njPVnyR1WFHXmtFtmzoHTXNK/nzZCwmqtxzk
	iQOD4I1yQa2Tl6Dw6WKeHThkOXi3+3cvJewpwOnRIN0RK7Y2+c/1LSAkUCH+Bl8=
X-Gm-Gg: ASbGncvvrfO5h2s4DGRX6PTZwlXg57lDdRZAG9bCAKOSYu3tQs9saEXQY2jGAucyxP7
	gmKhesw67poJhJYGLBz/zWCSKmGRoRZGaoQANncma7ICBo5As1xYuYxAV1SWTLRsqhqwob45RN+
	92IrJh4H27YUTzqhJ4fx9DQVsYMNT5q8+NXURCabWKC5fQIxX+5s/2S+215r4WLznmwspGUBDt7
	6wLyA9Rmu0s5kwjIObxtnWQtf0Lt6K3ZH8QMWYZbzt4w3kxRoBWQhlCYjfeeXSjxyoyICNLylKV
	S/J1ApB6U3Qx9OEeBpir/aTztoggs60V9XxhnyAU7g0QVeTUPsoZZUf4lyRntBkt3JCVKlBVQ10
	=
X-Google-Smtp-Source: AGHT+IH9h5nIeqRBN4A62EgPqAGrwp4q9RWIx3Ok1zBoIEmHHWXkJ71RN3O4VBV+synHi7sJ/BjH/Q==
X-Received: by 2002:ac8:5e11:0:b0:472:165e:91d4 with SMTP id d75a77b69052e-474bc0848aemr8752981cf.13.1740688737797;
        Thu, 27 Feb 2025 12:38:57 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4746b5eed4fsm15111101cf.31.2025.02.27.12.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 12:38:56 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tnkel-00000000K3V-3Gtf;
	Thu, 27 Feb 2025 16:38:55 -0400
Date: Thu, 27 Feb 2025 16:38:55 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ethan Zhao <etzhao1900@gmail.com>
Cc: Ethan Zhao <haifeng.zhao@linux.intel.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Yunhui Cui <cuiyunhui@bytedance.com>, dwmw2@infradead.org,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu/vt-d: fix system hang on reboot -f
Message-ID: <20250227203855.GI5011@ziepe.ca>
References: <20250225064831.63348-1-cuiyunhui@bytedance.com>
 <0691a295-0883-47b3-84a6-47d9a94af69a@linux.intel.com>
 <c059fb19-9e03-426c-a06a-41f46a07b30a@linux.intel.com>
 <20250225142610.GB545008@ziepe.ca>
 <888f41b7-dac6-4faf-9f71-4d7bea050e41@linux.intel.com>
 <33c4755d-6a0f-4734-88e0-84f0de67b652@linux.intel.com>
 <83039906-77f7-4318-94bf-4c98bb3f0e32@linux.intel.com>
 <20250226130423.GF5011@ziepe.ca>
 <f29818dc-a0a7-46c4-b541-1b469a6b3304@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f29818dc-a0a7-46c4-b541-1b469a6b3304@gmail.com>

On Thu, Feb 27, 2025 at 08:40:31AM +0800, Ethan Zhao wrote:
> 
> On 2/26/2025 9:04 PM, Jason Gunthorpe wrote:
> > On Wed, Feb 26, 2025 at 01:55:28PM +0800, Ethan Zhao wrote:
> > > > Provided the system does not respond to those events when this function
> > > > is called, it's fine to remove the lock.
> > > I agree.
> > I think it is running the destruction of the iommu far too late in the
> > process. IMHO it should be done after all the drivers have been
> > shutdown, before the CPUs go single threaded.
> 
> Hmm... so far it is fine, the iommu_shutdown only has a little work to
> do, disable the translation, the PMR disabling is just backward compatible,
> was deprecated already. if we move it to one position where all CPUs are
> cycling, we don't know what kind of user-land tasks left there (i.e. reboot -f
> case), it would be hard to full-fill the requirement of Intel VT-d, no ongoing
> transaction there on hardware when issue the translation disabling command.

There is no guarentee device dma is halted anyhow at this point either.

Jason
