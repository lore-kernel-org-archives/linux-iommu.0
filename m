Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF1C43C059
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 12:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777380625; cv=none; b=EwCW2vfACof9HCZm7QU6XijGxuMeXmdrcyrnFXOpgX6/BE/Njue8Ts1Iq7o4ezc9K1cjCdpUEPZA8FuKqxLsE1qQRh8wRepp5TC18D1nCPY6qsTOVdm7dC3j/RDgCrcx/4/+6y1pQn/UGGXKkodi8GvydzoJVD/zN82IPctpKTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777380625; c=relaxed/simple;
	bh=CFt6SaX8lvBwsyPzjjPQPyUBGsOZKHipwWBBIQuAwpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SoXr0Fs4mSdRJmWGvoVAlbz17Cd8rN3S6DOCk5RMFc4Yv+C7iAtF5WsXmB9EdtQMayb+Qk1klPvSo1bI0HWkqjvoWZLIHkn8/x2tWQmybOPt486BDg2KoE48eBu0BgYQVAXnN/R7ML52jSpiuVYJAIMPu0ik8YXOR0VvKwc32UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ipJB+J8Z; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ipJB+J8Z"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8d68f702851so1291753885a.0
        for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 05:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777380619; x=1777985419; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8t5Y74JK09wcmnesHru+6hwOpLCoWPkIfn+Q28jlzBo=;
        b=ipJB+J8ZmF4+8x70M+1vomp6I1trvjhlqmJOdkgz5mGZgeZxBINYH5bQLkOoRVqd8n
         L+BLOFFFO1fdfx4vMbl4Va8NB9UQAdCJjlsXVuHp30GuXRZczbiKF59Hd4KxCMpWYuRY
         Bpia/sQmKrRfBnb2heCIbx3tRXHey6IJ6TXQb9Hi0EKaSQ3V4kkWZDFcrc6ZAhYGg6rQ
         8uytRid3VzVoFNeNuCXoHJZGDa5m6PfS/9BqQMWqEXryfn3fALH9sSz4IJPECb/AFKB/
         zFas1SJTTwPWAIDMoZL6+vdJvWwLsCgRt3h4hKYKxxJjArgvlv95TYgrJaJXTMLwFXke
         /0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777380619; x=1777985419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8t5Y74JK09wcmnesHru+6hwOpLCoWPkIfn+Q28jlzBo=;
        b=aI74gMHwTS/n6qszBs4bNWztZMI1V/idzVLC11c9f26SATJTGRpZ+dDaZrwlE9YnhZ
         6SFY4h3ZMPQU5FKQMWGQkcpJoaC6H3av76Z97c6YFFkW83n60AIvBz8EZipvg64HXB8n
         wFUAOBtb9vATMGhJ/A98SyYBjwPvIXA9OvMyygtqsBmsWp6SHLit/rG2mKVfOVpOozX4
         lu17DUIjH5bZseYmhfE6SC34vHMlEYKhROfZbDH+HhD8nxjWJx3nZrbwY4X1pCq2oiql
         Hs8p8PONZ8uHRjNxvClMKGzGEowkkAHE0NT3LyPRbWh9sQIZUkYZ7bXx1gFia/vWB4IJ
         MaMw==
X-Gm-Message-State: AOJu0Yw3+gz0cErdNq5MVvS0YhtvndtmxzrtEKFhf1lnoys6OzYgTuMB
	cX7L2A585RAulAEE7k+hT+amTqeft1ST0q7QovU/pHm/5MFjCL9g4PTFq0m0GLFdCdc=
X-Gm-Gg: AeBDievgoOd9hxrB121nUyJnDxcFuEOebgy4War6wIDNI1FK31ZyIM5DK9yGehPDJWi
	/on8dwYyFEhMXo/3zFK9R9BhDruBa32WdgnTJgcjBPGHOTfWcGD2uO+EjlfnuTELUv7Ttb04tx0
	vkxPOCdeRDcUdxQ3onucmYtvpm1DJ50ZWfFTRIQFjxUmm3fYSSRUMFUgICN0PCfteCNfTqZLJcT
	wepuJT+ag79P16fSAsEapFG7nXod3BeaLb/CW12q60lobTslAfQT2j+AS+DShkzOycy6zQHq/8g
	795989Ji2VEGinE5RxiAtGYHlpXi2cfjg4xTqeUko9qAeLqlIw3bP/QzDM2/dUGcNuChmz0JLY6
	qb5cSSV+EwZhR5HgGHMwSeIJX+GHHyfAbupB++m0iyETmPtPi97gVRMlk1urnOHD+JABTnWrqWd
	9QabMPxv2/GmanMdiEmisUX+Na7SlRLI2xz9bydFhD49k4GbQRe430Fdyfg14ZK4lu9Zolx6Xsw
	q7Xqtmtttyz5q/EKqSuvhon5rQ=
X-Received: by 2002:a05:620a:4688:b0:8ed:2b66:9eb2 with SMTP id af79cd13be357-8f7d734683dmr403211385a.15.1777380619112;
        Tue, 28 Apr 2026 05:50:19 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f7c51af6dbsm182444485a.20.2026.04.28.05.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 05:50:16 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wHhtH-0000000AWMo-3Ut3;
	Tue, 28 Apr 2026 09:50:15 -0300
Date: Tue, 28 Apr 2026 09:50:15 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Jonathan Cameron <jic23@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Will Deacon <will@kernel.org>, Xu Yilun <yilun.xu@linux.intel.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 1/4] iommufd/device: Associate a kvm pointer to
 iommufd_device
Message-ID: <20260428125015.GB849557@ziepe.ca>
References: <20260427061005.901854-1-aneesh.kumar@kernel.org>
 <20260427061005.901854-2-aneesh.kumar@kernel.org>
 <20260427135906.GB740385@ziepe.ca>
 <yq5afr4f1egv.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5afr4f1egv.fsf@kernel.org>

On Tue, Apr 28, 2026 at 05:31:04PM +0530, Aneesh Kumar K.V wrote:
> > I thought we were trying to get away from struct kvm?
> >
> > https://lore.kernel.org/all/adf29Rn7q9Db0hxc@google.com/
> >
> > Ie this should be a 'struct file *kvm_fd'
> >
> > ?
> >
> > Though I am wondering how practical it is to do this at this moment :\
> >
> 
> Should we also switch 
> 
> modified   drivers/vfio/vfio.h
> @@ -22,8 +22,8 @@ struct vfio_device_file {
>  
>  	u8 access_granted;
>  	u32 devid; /* only valid when iommufd is valid */
> -	spinlock_t kvm_ref_lock; /* protect kvm field */
> -	struct kvm *kvm;
> +	spinlock_t kvm_ref_lock; /* protect kvm_file */
> +	struct file *kvm_file;
>  	struct iommufd_ctx *iommufd; /* protected by struct vfio_device_set::lock */
>  };
>  
> @@ -88,7 +88,7 @@ struct vfio_group {
>  #endif
>  	enum vfio_group_type		type;
>  	struct mutex			group_lock;
> -	struct kvm			*kvm;
> +	struct file			*kvm_file;
>  	struct file			*opened_file;
>  	struct blocking_notifier_head	notifier;
>  	struct iommufd_ctx		*iommufd;

Ideally, yes everything outside kvm should just use the struct file
and there should be quite narrow places where you do some kvm
operation on it.
 
> ie,
> KVM_CREATE_DEVICE with KVM_DEV_TYPE_VFIO still use kvm->users_count,
> KVM_DEV_VFIO_FILE_ADD -> will switch to get_file(kvm->_file);
> and VFIO_DEVICE_BIND_IOMMUFD -> will switch to get_file(df->kvm_file)
> 
> > Maybe ask Paolo how his series is going?

I thought the above is what Paolo's series was going after?

Jason
