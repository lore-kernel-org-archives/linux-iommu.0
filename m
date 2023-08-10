Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C90862A
	for <iommu@lists.linux.dev>; Thu, 10 Aug 2023 18:46:29 +0000 (UTC)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-76ca7b4782cso92847385a.0
        for <iommu@lists.linux.dev>; Thu, 10 Aug 2023 11:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691693188; x=1692297988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CsoST8P+iWgWsPf7zElyRhjW/tMFYzbMLrZME8gLp0k=;
        b=ZQuJWn0VK80YzZIuNKmUCDAUJyL23bBqNMH3chTgGERDaScHJ91A/4qUj8OER1DJp3
         FTo0SenhTP9f/Wp1KasdzdKIhxmg0nFDABfMdgEzvxjclYa5EpNPrHD+Fq5yVnYA6lPz
         mGROrMGyzjOAWo9EX119rHRhiiyuzHCXYkPf40rGTGxKnA9YyTFhz2l0o1Rk+AgTWNje
         iF/aRV5gcTGfo+6WSKoByrBFOIwP9vBi1ICE4ZW4GsLKkimFA40XrquhIXCZB3nzMzDL
         EIK6wmZchjpDYxB7Gg4LoL0g0sBdlwUW4j5ZZgoIV33NPrhIugEVVP23j+1bqa2AYUoT
         ESLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691693188; x=1692297988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CsoST8P+iWgWsPf7zElyRhjW/tMFYzbMLrZME8gLp0k=;
        b=RHvpZCzR8lUAVKWGL5iJkzdThIORvtesYXJUc/Devfp8TZonVA8CfFbr9tMc3J4RHM
         sfsynP1hhiI+Q33A+A1GDiPBn4iwu2kj575/Flu/lvLfqrEwKxBBLKcZZRwysctr7OWo
         PcW8UA+vZ+086T1fLu1D/GcUWc9JOGfh8CXnIBSrzy4MXL0t6Zb8PUwrvconV1fZvye8
         SYvoJUn/Qq/iiKf3FdojAxgS6fnb97tinW2oJKGnki4kXES+c/BByaMPavZ5qGtkQliH
         T1EeTyLStEXLlxMfghGuvMnIGrsn/NIdGw72+ZWcSCtFcPuBs6YBcbiaCXXvUcHL1HBt
         /+3A==
X-Gm-Message-State: AOJu0YxxyEzRjk8+8jPu7AA3gtT3nKHFlHRFhE44dU4uFwhGJVQcmqN9
	PNW+igdvY4fq5VYIBEKGxiywsw==
X-Google-Smtp-Source: AGHT+IET1W3e6hO+x22N7pS0nUJ4fA6rmvxXCmowFm1HbIzbrqrYGlj1RXiVnna0iMsgpBXs2XE+ug==
X-Received: by 2002:a05:620a:28c1:b0:765:7a1e:a456 with SMTP id l1-20020a05620a28c100b007657a1ea456mr3504767qkp.54.1691693188098;
        Thu, 10 Aug 2023 11:46:28 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id i15-20020a05620a074f00b0076c60b95b87sm671044qki.96.2023.08.10.11.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 11:46:27 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qUAfy-005IYu-Qe;
	Thu, 10 Aug 2023 15:46:26 -0300
Date: Thu, 10 Aug 2023 15:46:26 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/12] iommu: Make dev->fault_param static
Message-ID: <ZNUwgjJ+2GHf2MOW@ziepe.ca>
References: <20230727054837.147050-1-baolu.lu@linux.intel.com>
 <20230727054837.147050-7-baolu.lu@linux.intel.com>
 <ZNUqV5Mte2AsVa1L@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNUqV5Mte2AsVa1L@ziepe.ca>

On Thu, Aug 10, 2023 at 03:20:07PM -0300, Jason Gunthorpe wrote:
> On Thu, Jul 27, 2023 at 01:48:31PM +0800, Lu Baolu wrote:
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index 4ba3bb692993..3e4ff984aa85 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -302,7 +302,15 @@ static int dev_iommu_get(struct device *dev)
> >  		return -ENOMEM;
> >  
> >  	mutex_init(&param->lock);
> > +	param->fault_param = kzalloc(sizeof(*param->fault_param), GFP_KERNEL);
> > +	if (!param->fault_param) {
> > +		kfree(param);
> > +		return -ENOMEM;
> > +	}
> > +	mutex_init(&param->fault_param->lock);
> > +	INIT_LIST_HEAD(&param->fault_param->faults);
> >  	dev->iommu = param;
> 
> This allocation seems pointless?
> 
> If we always allocate the fault param then just don't make it a
> pointer in the first place.
> 
> The appeal of allocation would be to save a few bytes in the common
> case that the driver doesn't support faulting.
> 
> Which means the driver needs to make some call to enable faulting for
> a device. In this case I'd continue to lazy free on release like this
> patch does.

For instance allocate the fault_param in iopf_queue_add_device() which
is the only thing that needs it.

Actually probably just merge struct iopf_device_param and
iommu_fault_param ?

When you call iopf_queue_add_device() it enables page faulting mode,
does 1 additional allocation for all additional required per-device
memory and thats it.

Jason
