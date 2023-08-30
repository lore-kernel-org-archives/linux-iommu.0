Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB64920E2
	for <iommu@lists.linux.dev>; Wed, 30 Aug 2023 12:49:24 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-31c615eb6feso4648295f8f.3
        for <iommu@lists.linux.dev>; Wed, 30 Aug 2023 05:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693399763; x=1694004563; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=icItx3AAoUpU7OYRWsoDm1Wmtkp4XHu2/zCUAdAv9gQ=;
        b=mvi6OouLgGBkywCHHJ7cTFi2HSaXmQeokn0NViqu0giVJIUuBObwLv6QwFYYkVJbZH
         tsJhRWqDC3mwTFde/kVPpomN4X2/Ow7yjm1yXrxS7VFmDau7ShNc2J1ff3CA0dALo0KP
         zeOT1/cd0SMlDOtqoPaH9lNI1O15byzFSXS65k7Qpq60phvF+dafe7zA4SiLD7iAoYhQ
         cWpXWvYlc2v1N1rynOcrfmYStSSWgp2Wlb1e3miMjOTmN0SFf3VOrqEm9I4q/hMSAVK4
         oxj4WcHs2usU0qLWEoFwUqHql8x9kE38eYJ/Mve9NqcgiExE6jay01XkMICZaC9U7d3r
         /ugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693399763; x=1694004563;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=icItx3AAoUpU7OYRWsoDm1Wmtkp4XHu2/zCUAdAv9gQ=;
        b=Pi539jlRdCSTpZQwh3ULT2YLFntzO88ozapx2Rm/HKqifOXzzgzdJvoGF+BRIYCMnz
         2oCZtrduGBqTJrjREVxLOJbIs6Bc9K9bPK4cQGYmHxHgKKGvYdTLW4sufji3bQ+Q/pTP
         EYj/7zdzJB3fN9cmORfVnFg8R8VAxKOQNdfjV5OEhvFxKw07BTUBFB9RVDFquxI7zmT9
         WQyj/aRNR//BYEruW4amy3+Kd8R0Np0kEXn69kgryphMp6TfG+4q1bgM6Ljng+66vHv8
         AoQdntEi8w/cYHEpunlew3TPFaLGKBz0bCS7FNkQkUx9mf3RqwKhKgmcPJf7GXVr31eW
         psdA==
X-Gm-Message-State: AOJu0YxaP6UeY0qSyC8QzVG3M6znJsG+wAdf6wty5qerGiIkk+qEWalh
	0mqyI/WdXBKU2b9GbVQatkyxAA==
X-Google-Smtp-Source: AGHT+IFlrU3LzNvhPuoIhYIOnZuXm+ouW+s6lNZGIAycwz4s7bnL1qAxU7DUK56J7UtJR+G7QVKLVA==
X-Received: by 2002:adf:efc7:0:b0:319:6d91:28bf with SMTP id i7-20020adfefc7000000b003196d9128bfmr1741339wrp.60.1693399762716;
        Wed, 30 Aug 2023 05:49:22 -0700 (PDT)
Received: from myrica ([2.220.83.24])
        by smtp.gmail.com with ESMTPSA id n9-20020a5d6609000000b0030647449730sm16542269wru.74.2023.08.30.05.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 05:49:22 -0700 (PDT)
Date: Wed, 30 Aug 2023 13:49:19 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 09/10] iommu: Make iommu_queue_iopf() more generic
Message-ID: <20230830124919.GA2855675@myrica>
References: <20230825023026.132919-1-baolu.lu@linux.intel.com>
 <20230825023026.132919-10-baolu.lu@linux.intel.com>
 <BN9PR11MB52762A33BC9F41AB424915688CE3A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <cbfbe969-1a92-52bf-f00c-3fb89feefd66@linux.intel.com>
 <BN9PR11MB52768891BC89107AD291E45C8CE6A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <a4fc5fa2-a234-286b-e108-7f54a7c70862@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a4fc5fa2-a234-286b-e108-7f54a7c70862@amd.com>

On Wed, Aug 30, 2023 at 04:32:47PM +0530, Vasant Hegde wrote:
> Tian, Baolu,
> 
> On 8/30/2023 1:13 PM, Tian, Kevin wrote:
> >> From: Baolu Lu <baolu.lu@linux.intel.com>
> >> Sent: Saturday, August 26, 2023 4:01 PM
> >>
> >> On 8/25/23 4:17 PM, Tian, Kevin wrote:
> >>>> +
> >>>>   /**
> >>>>    * iopf_queue_flush_dev - Ensure that all queued faults have been
> >>>> processed
> >>>>    * @dev: the endpoint whose faults need to be flushed.
> >>> Presumably we also need a flush callback per domain given now
> >>> the use of workqueue is optional then flush_workqueue() might
> >>> not be sufficient.
> >>>
> >>
> >> The iopf_queue_flush_dev() function flushes all pending faults from the
> >> IOMMU queue for a specific device. It has no means to flush fault queues
> >> out of iommu core.
> >>
> >> The iopf_queue_flush_dev() function is typically called when a domain is
> >> detaching from a PASID. Hence it's necessary to flush the pending faults
> >> from top to bottom. For example, iommufd should flush pending faults in
> >> its fault queues after detaching the domain from the pasid.
> >>
> > 
> > Is there an ordering problem? The last step of intel_svm_drain_prq()
> > in the detaching path issues a set of descriptors to drain page requests
> > and responses in hardware. It cannot complete if not all software queues
> > are drained and it's counter-intuitive to drain a software queue after 
> > the hardware draining has already been completed.
> > 
> > btw just flushing requests is probably insufficient in iommufd case since
> > the responses are received asynchronously. It requires an interface to
> > drain both requests and responses (presumably with timeouts in case
> > of a malicious guest which never responds) in the detach path.
> > 
> > it's not a problem for sva as responses are synchrounsly delivered after
> > handling mm fault. So fine to not touch it in this series but certainly
> > this area needs more work when moving to support iommufd. 😊
> > 
> > btw why is iopf_queue_flush_dev() called only in intel-iommu driver?
> > Isn't it a common requirement for all sva-capable drivers?

It's not needed by the SMMUv3 driver because it doesn't implement PRI yet,
only the Arm-specific stall fault model where DMA transactions are held in
the SMMU while waiting for the OS to handle IOPFs. Since a device driver
must complete all DMA transactions before calling unbind(), with the stall
model there are no pending IOPFs to flush on unbind(). PRI support with
Stop Markers would add a call to iopf_queue_flush_dev() after flushing the
SMMU PRI queue [2].

Moving the flush to the core shouldn't be a problem, as long as the driver
gets a chance to flush the hardware queue first.

Thanks,
Jean

[2] https://jpbrucker.net/git/linux/commit/?h=sva/2020-12-14&id=bba76fb4ec631bec96f98f14a6cd13b2df81e5ce

> 
> I had same question when we did SVA implementation for AMD IOMMU [1]. Currently
> we call queue_flush from remove_dev_pasid() path. Since PASID can be enabled
> without ATS/PRI, I thought its individual drivers responsibility.
> But looking this series, does it make sense to handle queue_flush in core layer?
> 
> [1]
> https://lore.kernel.org/linux-iommu/20230823140415.729050-1-vasant.hegde@amd.com/T/#t
> 
> -Vasant
> 
> 
