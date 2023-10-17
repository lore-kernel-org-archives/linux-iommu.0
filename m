Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242422D02E
	for <iommu@lists.linux.dev>; Tue, 17 Oct 2023 16:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="SVcYoJH7"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-41cb9419975so928811cf.2
        for <iommu@lists.linux.dev>; Tue, 17 Oct 2023 09:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1697560419; x=1698165219; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dclroukzLGxz5umscUIIo3X53adAsvRXETE+DNsgCts=;
        b=SVcYoJH7UCjlJeNDZI+L/VX7J4f04rnukYhNDjqo2LrZXnRvGIL4QLj8dcKX7cHJkg
         OWCLhL6Yn6iXwLqZsaW+HBF5GWw9B3cDbRwxlvjiOnH/n2kBrgh4fLScbM9Pj7X3O+GR
         LBQZG7b2PHGpxf+VC7+OA1XhMIHNFPefutJdBHaeKtaYCZXx/deLbQdKOhdI/Le3ANzj
         vw3lJNJaOkx8/nilkI5TZtKoY6PpLsywRsjNvMGh08l0I9OVeAYe1RMAoTnM0B4ycUic
         GLrHkTK4D56eLO3wJiKZvhq87wf/HzKNKgggtjC1sKLDg2TK+auKHEhMkfiR4Cpe62zY
         gMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697560419; x=1698165219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dclroukzLGxz5umscUIIo3X53adAsvRXETE+DNsgCts=;
        b=kuEJGOWFzeWdTrhnVIW7wN3ph0wjmrotR8ipNzVgBnhCsem0kf044WLMU2OWYEUM7K
         NqV9PpP3O4NA0iikjnMcq5Vct739jHYkTS+4cpx3j4jH0rtTSFfmaIAF0xzEAjz0Ctr3
         etgZL3FVhgsHqcXKb1lvnjtoq4+ZNndBdPKpMX5aHzYERG1r9xy47L59QssCMb0YDVfs
         W/F1s1y+wBc4KzAunYmX5YfKKgUUCu8PENRN4lJF+bcPjyGKZ9ze9LSmBlLaUI87RLGD
         Hqe8tSFcRrPvfdznH0+p9ay0XcYGeJ7SQbvtNgUM6G9ewL8D5NMBsk3IY3tOTRMej1PY
         q1Fw==
X-Gm-Message-State: AOJu0Yzmu4d26hIhJBtxLz+HEShLzZJggHEtEFh17ZsMVcQk6DACP6fi
	zHcSmGEY7aAEFSkFpjg1GoxGVw==
X-Google-Smtp-Source: AGHT+IFp6pQb+R36gjUSVSmxooe7mUCxfDZoMHSMV/Fkl6eZO2lM7P03aL913SU6pq4+zRe3xQGgnQ==
X-Received: by 2002:ac8:7c4e:0:b0:418:a14:9c30 with SMTP id o14-20020ac87c4e000000b004180a149c30mr2665362qtv.9.1697560418744;
        Tue, 17 Oct 2023 09:33:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id k2-20020ac81402000000b004199c98f87dsm740615qtj.74.2023.10.17.09.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 09:33:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qsn0j-002sD0-2s;
	Tue, 17 Oct 2023 13:33:37 -0300
Date: Tue, 17 Oct 2023 13:33:37 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zhenhua Huang <quic_zhenhuah@quicinc.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	baolu.lu@linux.intel.com, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, quic_tingweiz@quicinc.com
Subject: Re: [ARM IOMMU] IOMMU framework concurrency issue
Message-ID: <20231017163337.GE282036@ziepe.ca>
References: <e2e20e1c-6450-4ac5-9804-b0000acdf7de@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2e20e1c-6450-4ac5-9804-b0000acdf7de@quicinc.com>

On Tue, Oct 17, 2023 at 07:10:23PM +0800, Zhenhua Huang wrote:
> Dear experts,
> 
> Saw a few crashes in our projects because of concurrency between (1) and
> (2).
> 
> bus notifier or bus_iommu_probe:
> 	__iommu_probe_device
> 		acquire iommu_probe_device_lock only
> 		iommu_init_device()
> 			//touch dev->iommu (1)
> 			dev_iommu_get()
> 			->probe_device()
> 
> Client device probing path:
> of_dma_configure			
> 	of_iommu_configure
> 		//touch dev->iommu  (2)
> 		...
> 
> 
> We already have 01657bc14a39 ("iommu: Avoid races around device probe") and
> the big comment in __iommu_probe_device() refers to adopt device_lock()
> further. Notice your big effort to utilize it, and IMO it can address above
> issue(which protects dev->iommu):

I think something else has gone wrong here, you should not be able to
get to any really_probe() before the iommu side has done its part.

Even with proper device locking the poor device that is racing isn't
going to work properly as the IOMMU won't be guarenteed to be
consistently configured.

This seems like you need to resolve boot time ordering in your
platform? (I don't know exactly how ARM works here though)

eg make sure the iommu driver is fully registered before allowing any
concurrent probes. Once the iommu driver is registered it will be able
to catch the bus notifiers and serialize things properly.

Jason
