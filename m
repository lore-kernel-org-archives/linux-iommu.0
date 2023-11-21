Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2662764D
	for <iommu@lists.linux.dev>; Tue, 21 Nov 2023 00:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CeWnDUTI"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5844bc378feso2856013eaf.0
        for <iommu@lists.linux.dev>; Mon, 20 Nov 2023 16:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1700525694; x=1701130494; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cM4nXDiFJOID9V8g8m4rSnX0D2eYIgzoLqQUP7X4x5w=;
        b=CeWnDUTIbkrj3e8sLjnXsLfMGDDhIPmPc6veo3bo7wXTK/nrEMIUgsEUfS0tHnGSD9
         v068Imty/s1nx7q69qqq5S3Z1/Qksaniez8H/Cs3/e1lelSdeaL5oCUIovrDDMnz0y5O
         +cNX9QZ7ZAEf2+xPW6FtESWpl0t5FM2g4ke76k5+HUYBwjQkqpjeOQi24tK8MIRJpsGm
         /Dw4gV9oEeIvV+DriMfJ1GZ1hGj0aS8REaT78aG89vPUhLOTA0G/c+MFhYGmj2KiAU9B
         lLxJFi+oUB8ZPtJSgwkhOBOjaIm0B1kWUL/OxTRB1lQtFqkKbYIZkENGq8TSltbdKr0g
         Hekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700525694; x=1701130494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cM4nXDiFJOID9V8g8m4rSnX0D2eYIgzoLqQUP7X4x5w=;
        b=BjwCC8mxtjWy5eig+yNFOSTHQzaTxDkNjSqGFe08k9OM6Wr86dQGN1q0mohVMe45lF
         BHm7WtFztOxBgAtM5t6IfchQhRCTiXnb7hSZGWa2vYvSMIMls90E/5Xfs3he8LDQ92/U
         DDP/92aI7TWb1xdTJt19sPRwwYG9WCIzSqMIqMX60jrTwSSspZwn4kNFC0Uo16yEQd6h
         23jFElpWFF+JqBCzAJzI+oWPwJg8Ct76PKsPSKBJBMOg1pI5d2ow5LHDgxLkV/iuTPMi
         2nsuNUAvVQ+lYmFrN+iRDbiaQ1kzNpgR51Fa5EP7Pesds9FNirF/SjH7Z2ZA27Ft9JP1
         ZVtw==
X-Gm-Message-State: AOJu0YwgIP8cqEIpDCntWaDMtiAcqlYKkCcEWt89LqJ+WTREgG8xpvPg
	ZOIETlAgiU6Ig1QqCBiMVK6RtQ==
X-Google-Smtp-Source: AGHT+IHCW/gnwvCFARN/IZLYIino35BqbfjASz8DDrzzSvjMWgTO3xenCZoSHE50H7LZjgQneLoOoA==
X-Received: by 2002:a05:6820:1628:b0:581:ed12:98c6 with SMTP id bb40-20020a056820162800b00581ed1298c6mr10069537oob.4.1700525694024;
        Mon, 20 Nov 2023 16:14:54 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id w9-20020a4aaf09000000b005840b5783a1sm1569061oon.43.2023.11.20.16.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 16:14:53 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r5EPk-0019u1-1E;
	Mon, 20 Nov 2023 20:14:52 -0400
Date: Mon, 20 Nov 2023 20:14:52 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Liu, Jing2" <jing2.liu@linux.intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] IOMMUFD: Deliver IO page faults to user space
Message-ID: <20231121001452.GF10140@ziepe.ca>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <20231102124742.GA4634@ziepe.ca>
 <c774e157-9b47-4fb8-80dd-37441c69b43d@linux.intel.com>
 <ZVTObiybC1MYlSam@ziepe.ca>
 <8f24918e-aa57-4160-902a-58d10021246e@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f24918e-aa57-4160-902a-58d10021246e@linux.intel.com>

On Thu, Nov 16, 2023 at 09:42:23AM +0800, Liu, Jing2 wrote:
> Hi Jason,
> 
> On 11/15/2023 9:58 PM, Jason Gunthorpe wrote:
> > On Wed, Nov 15, 2023 at 01:17:06PM +0800, Liu, Jing2 wrote:
> > 
> > > This is the right way to approach it,
> > > 
> > >     I learned that there was discussion about using io_uring to get the
> > >     page fault without
> > > 
> > >     eventfd notification in [1], and I am new at io_uring and studying the
> > >     man page of
> > > 
> > >     liburing, but there're questions in my mind on how can QEMU get the
> > >     coming page fault
> > > 
> > >     with a good performance.
> > > 
> > >     Since both QEMU and Kernel don't know when comes faults, after QEMU
> > >     submits one
> > > 
> > >     read task to io_uring, we want kernel pending until fault comes. While
> > >     based on
> > > 
> > >     hwpt_fault_fops_read() in [patch v2 4/6], it just returns 0 since
> > >     there's now no fault,
> > > 
> > >     thus this round of read completes to CQ but it's not what we want. So
> > >     I'm wondering
> > > 
> > >     how kernel pending on the read until fault comes. Does fops callback
> > >     need special work to
> > Implement a fops with poll support that triggers when a new event is
> > pushed and everything will be fine.
> 
> Does userspace need also setup a POLL flag to let io_uring go into poll, or
> io_uring always try to poll?

io_uring can trigger poll and use other approaches, it is flexible the
driver can scale this in different ways.

Jason
