Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E837541A
	for <iommu@lists.linux.dev>; Tue, 12 Dec 2023 15:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JdPGjtKe"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-77f380d8f6aso342906985a.2
        for <iommu@lists.linux.dev>; Tue, 12 Dec 2023 07:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1702394330; x=1702999130; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1J0E2muSgNl3hAqEUv0GBJG6tt73IDHG5CgFbhTFcMw=;
        b=JdPGjtKeeRnzQqXbap4t4cM0TO3/m7Kip+X5u7k2GFlyI4k7fKm0BNLI40UjaDlkOl
         1bLj3pM2Yz+1ZHxHMMFEynEANaUjEYxXiqTCQn5LyJSc/ZqKGupFUEfbF6s9Hpa+3Gx5
         msP3OCJGQ1rD+0lCpkFlSByDhZIo8fehR9ZMDEajFDk9h20MMtuDNOat7i9y/IYWT4I0
         9Kih/ekH5IGKWShnqP8CTJ+o6SnVuAUebXxSeNrjzoof1OUhZ2Fzs36HUv+VSEg/mJ02
         mQi2kK5TQb313MeHmK7RNqoNMXU35W4JlS3+/EMDSxBHD7XsB80vWr7PzZiXZRxj6bwg
         8rmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702394330; x=1702999130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1J0E2muSgNl3hAqEUv0GBJG6tt73IDHG5CgFbhTFcMw=;
        b=KVwM5lggj4aVGRbzZJfiKe1WDqnPqMiRisxA4doEIbDJEJNxCF/JTSGRvK3/Fk2lIy
         VeQ1qm3mR3l0/+tYXgz6BfUEzRqVi1CM/ITHqnMaaNFwOmj5pUQe60O9ZIGP98D4PHy0
         SkQ+Qokpyx+ONeuD8V7Xe6GmTppIEN+re2tocKlk5TgT7R/IQswLvfPc6kfQ0Rjwmxh9
         MPBxQQfk/EUY3p94d8HqLD03WESJ9ql+sk4fXQwk0KidKy2QeSFvhd9cxPovo3Uf4VYr
         9Wo7aeRTujaTeKoZwIDzlFKEMITHYeMKWbAlIX+PdRTBlOydqAivn0UlWBdp1TOE8OQ3
         QVbA==
X-Gm-Message-State: AOJu0YyRT4jxXkHRAT39p7TF9R1ZuEhwApAqSwHedOPTCmS8M1arit+0
	bfNYOMf15BBjw1dASUBxOcxzQQ==
X-Google-Smtp-Source: AGHT+IFq3Ckq2KVmneMTzmQ2mKKjd0RAxPdbXcCdtNxUscr3KZI+A2xNjS/BTczw0TiEfU7gwIenjQ==
X-Received: by 2002:a05:620a:27c9:b0:77e:fba3:9d05 with SMTP id i9-20020a05620a27c900b0077efba39d05mr7703626qkp.105.1702394330403;
        Tue, 12 Dec 2023 07:18:50 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id w5-20020a05620a148500b0077d65ef6ca9sm3745656qkj.136.2023.12.12.07.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 07:18:50 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rD4X3-00Ck2z-Fd;
	Tue, 12 Dec 2023 11:18:49 -0400
Date: Tue, 12 Dec 2023 11:18:49 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Longfang Liu <liulongfang@huawei.com>,
	Yan Zhao <yan.y.zhao@intel.com>, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 12/12] iommu: Use refcount for fault data access
Message-ID: <20231212151849.GE3013885@ziepe.ca>
References: <20231207064308.313316-1-baolu.lu@linux.intel.com>
 <20231207064308.313316-13-baolu.lu@linux.intel.com>
 <20231211151235.GA1489931@ziepe.ca>
 <62131360-e270-4ea5-92cb-8dd790be8779@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62131360-e270-4ea5-92cb-8dd790be8779@linux.intel.com>

On Tue, Dec 12, 2023 at 11:44:14AM +0800, Baolu Lu wrote:
> > @@ -210,7 +211,8 @@ struct iommu_domain {
> >   	unsigned long pgsize_bitmap;	/* Bitmap of page sizes in use */
> >   	struct iommu_domain_geometry geometry;
> >   	struct iommu_dma_cookie *iova_cookie;
> > -	int (*iopf_handler)(struct iopf_group *group);
> > +	int (*iopf_handler)(struct iommu_fault_param *fault_param,
> > +			    struct iopf_group *group);
> 
> How about folding fault_param into iopf_group?
> 
> iopf_group is the central data around a iopf handling. The iopf_group
> holds the reference count of the device's fault parameter structure
> throughout its entire lifecycle.

Yeah, I think that is the right thing to do

Jason
