Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD8457871
	for <iommu@lists.linux.dev>; Fri,  1 Dec 2023 20:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Dz/0GVfP"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-67a89ca347aso9203116d6.1
        for <iommu@lists.linux.dev>; Fri, 01 Dec 2023 12:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701462938; x=1702067738; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4AzPgky7GHZqZVCrwDwJ2TCTQsO5U4mu1ovBdK9ibFQ=;
        b=Dz/0GVfPDyzj08tl2fsPdVyk3rPpe+jafHbrfMyrfBH7ouwXY3dEUF0OcDHx6d3a0L
         D98C5eYD5wJaeKDPeq3wQ6md3dEnY+BOIkFoL8IdLgD/x6v1UZByelNEThOODV81crMk
         5UNtrDYMOKj5cppBdqBYdhWvLTiAUfvEPLHgflXD1y+WW3dX+wia6+S+DxRuFYDAiCdV
         +gDc4KELuBcSdn/FQc4+QRyNZhQ2ZhqfZFWEi+ETiETbge8dcT2AkekE0KJJAzHiSqw0
         Nbilti08JWhcsNy58hHq3G8OyoYymae5XhoF2vn7WlvVOByLhKQzB12xhj7EQ35JEI+6
         hL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701462938; x=1702067738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4AzPgky7GHZqZVCrwDwJ2TCTQsO5U4mu1ovBdK9ibFQ=;
        b=jqcWThEQMU10yF/9amWsafCasB7B0y9pPUltreVwPuFpVr4UnBEdRWf6am+HpDKwCW
         HKLxAEczBbhXTvKeOHuyGIe1oduMX74iSUewijQXJ0HZlmyf9mamQY9tqdWDMjDYlME4
         k23hKu6eio1bW6Upsd+Sk5fuSZxk5iv75ASoYqbPRxFNn/2OkK+fzfrbw3noTMHCvHXI
         zwljlw0kY790Thrf4Cb4aaozPmQuG7u3jA8bnbkke/6c4Epw+pu4LtduHkoPptECsaD8
         SY04LCgDChtaG0i+lPJz+pH2hpqjitHm64Aaoy0BX9olTl/T6HldoG37CSA8cRth85Vm
         jacw==
X-Gm-Message-State: AOJu0YxJFjNj4ejut0wuM58Iu8/Urp/v3r3onP5Us9bviZoZnTW43+Zh
	5XguWUEcb1IZlGoYBTX1hsIeqA==
X-Google-Smtp-Source: AGHT+IHOT0XKRw6+rggkJrfEQdv7Iu/MLVn36qFEZE0IsLTSurWkvGpPAL2i4HLowbNDECNd3sEozQ==
X-Received: by 2002:a0c:efc1:0:b0:67a:a721:d761 with SMTP id a1-20020a0cefc1000000b0067aa721d761mr48951qvt.71.1701462937778;
        Fri, 01 Dec 2023 12:35:37 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id y16-20020ac85250000000b00423f1a4f4e9sm1782170qtn.91.2023.12.01.12.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 12:35:37 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r9AEa-006NSu-JR;
	Fri, 01 Dec 2023 16:35:36 -0400
Date: Fri, 1 Dec 2023 16:35:36 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Yan Zhao <yan.y.zhao@intel.com>, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 12/12] iommu: Improve iopf_queue_flush_dev()
Message-ID: <20231201203536.GG1489931@ziepe.ca>
References: <20231115030226.16700-1-baolu.lu@linux.intel.com>
 <20231115030226.16700-13-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115030226.16700-13-baolu.lu@linux.intel.com>

On Wed, Nov 15, 2023 at 11:02:26AM +0800, Lu Baolu wrote:
> The iopf_queue_flush_dev() is called by the iommu driver before releasing
> a PASID. It ensures that all pending faults for this PASID have been
> handled or cancelled, and won't hit the address space that reuses this
> PASID. The driver must make sure that no new fault is added to the queue.

This needs more explanation, why should anyone care?

More importantly, why is *discarding* the right thing to do?
Especially why would we discard a partial page request group?

After we change a translation we may have PRI requests in a
queue. They need to be acknowledged, not discarded. The DMA in the
device should be restarted and the device should observe the new
translation - if it is blocking then it should take a DMA error.

More broadly, we should just let things run their normal course. The
domain to deliver the fault to should be determined very early. If we
get a fault and there is no fault domain currently assigned then just
restart it.

The main reason to fence would be to allow the domain to become freed
as the faults should be holding pointers to it. But I feel there are
simpler options for that then this..

> The SMMUv3 driver doesn't use it because it only implements the
> Arm-specific stall fault model where DMA transactions are held in the SMMU
> while waiting for the OS to handle iopf's. Since a device driver must
> complete all DMA transactions before detaching domain, there are no
> pending iopf's with the stall model. PRI support requires adding a call to
> iopf_queue_flush_dev() after flushing the hardware page fault queue.

This explanation doesn't make much sense, from a device driver
perspective both PRI and stall cause the device to not complete DMAs.

The difference between stall and PRI is fairly small, stall causes an
internal bus to lock up while PRI does not.

> -int iopf_queue_flush_dev(struct device *dev)
> +int iopf_queue_discard_dev_pasid(struct device *dev, ioasid_t pasid)
>  {
>  	struct iommu_fault_param *iopf_param = iopf_get_dev_fault_param(dev);
> +	const struct iommu_ops *ops = dev_iommu_ops(dev);
> +	struct iommu_page_response resp;
> +	struct iopf_fault *iopf, *next;
> +	int ret = 0;
>  
>  	if (!iopf_param)
>  		return -ENODEV;
>  
>  	flush_workqueue(iopf_param->queue->wq);
> +

A naked flush_workqueue like this is really suspicious, it needs a
comment explaining why the queue can't get more work queued at this
point. 

I suppose the driver is expected to stop calling
iommu_report_device_fault() before calling this function, but that
doesn't seem like it is going to be possible. Drivers should be
implementing atomic replace for the PASID updates and in that case
there is no momement when it can say the HW will stop generating PRI.

I'm looking at this code after these patches are applied and it still
seems quite bonkers to me :(

Why do we allocate two copies of the memory on all fault paths?

Why do we have fault->type still that only has one value?

What is serializing iommu_get_domain_for_dev_pasid() in the fault
path? It looks sort of like the plan is to use iopf_param->lock and
ensure domain removal grabs that lock at least after the xarray is
changed - but does that actually happen?

I would suggest, broadly, a flow for iommu_report_device_fault() sort
of:

1) Allocate memory for the evt. Every path except errors needs this,
   so just do it
2) iopf_get_dev_fault_param() should not have locks in it! This is
   fast path now. Use a refcount, atomic compare exchange to allocate,
   and RCU free.
3) Everything runs under the fault_param->lock
4) Check if !IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE, set it aside and then
   exit! This logic is really tortured and confusing
5) Allocate memory and assemble the group
6) Obtain the domain for this group and incr a per-domain counter that a
   fault is pending on that domain
7) Put the *group* into the WQ. Put the *group* on a list in fault_param
   instead of the individual faults
8) Don't linear search a linked list in iommu_page_response()! Pass
   the group in that we got from the WQ that we *know* is still
   active. Ack that passed group.

When freeing a domain wait for the per-domain counter to go to
zero. This ensures that the WQ is flushed out and all the outside
domain references are gone.

When wanting to turn off PRI make sure a non-PRI domain is
attached to everything. Fence against the HW's event queue. No new
iommu_report_device_fault() is possible.

Lock the fault_param->lock and go through every pending group and
respond it. Mark the group memory as invalid so iommu_page_response()
NOP's it. Unlock, fence the HW against queued responses, and turn off
PRI.

An *optimization* would be to lightly flush the domain when changing
the translation. Lock the fault_param->lock and look for groups in the
list with old_domain.  Do the same as for PRI-off: respond to the
group, mark it as NOP. The WQ may still be chewing on something so the
domain free still has to check and wait.

Did I get it right??

Jason
