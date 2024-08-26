Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E5417279E
	for <iommu@lists.linux.dev>; Mon, 26 Aug 2024 13:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724680798; cv=none; b=FRv9Ps1649mqAwjqWXBXTYoBU/nPbI1qe7AbK3YXYVjs8EepxqFKlWUsrMkbSjYfOnrO33YlGF4is4Yss7XWHVTbmq0lKMJhALoBBKPVL89sfFaXN+Evf7Lo0icLdJB6VLGl4dUfZTl0bttoT0EUiBpRfWDgT7dmOR85FxkUk3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724680798; c=relaxed/simple;
	bh=j9QMxSHy3XpBffR7dfpz47FxtLeot0FNJuV1tI075S0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ksu02B+ZA2jGulWzwR5XHgjqM2M4mXWAUZC9uIw+r5349+shP6tXVwZz2yeuIa/U2CeQ2nKqN8rYWW8hzavaber+dTUndwGc9Ljj2avngBlR90St8w7/uOmpXN/5euYF/GMb2rOHt9h9+ISVyFuXfWBqTANmeItISp5GZNfGRnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=LJkNh0kM; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LJkNh0kM"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5da6865312eso3642983eaf.3
        for <iommu@lists.linux.dev>; Mon, 26 Aug 2024 06:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1724680796; x=1725285596; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X2Xok4Exfr8qUalOltHMuaUnJ+WLJezD0kKoq3dkglM=;
        b=LJkNh0kMkIF1rXn5k2spqhRzK6otOdWFTx9QgtNxQkb0vYU859vyXPWIIXQlgGRWV8
         Ncfwm9sG5Yq12DxY3+Wigq/kFI3nAbH6ZExozm/N8ag0xbHrLRXn6aa7mFLEIt/LhEXZ
         voas6uVbAZe53jbJj91v87CDffkeQZ+4nrQlbVZcn2PiW9bpt8SRS88TxHom4YMfBKPb
         IKQyxuO83wQaGo+hGUn8d/oN7TQQEONSC7RN1InUsMOTITSpI+Y8hU1LAw1H6+gJFDbT
         fNXXrcAUEkwlrCWvCxh3R6JCgCfBgMidUk/KihCA52dBN9gssfqXR5aHAf10FQfSvrbK
         dhoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724680796; x=1725285596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2Xok4Exfr8qUalOltHMuaUnJ+WLJezD0kKoq3dkglM=;
        b=rFsmleKRziPuXMQh8rA5odU0ZS1rpTVWbFHa3k8YWTpCCLRSHhJOIRXGXVF36ca6rN
         DHiZVqK0ieh8lqjiXOF011qxcXcWfpMd7ijgmJbk+hi706ZktEhYYs0fmiKdFQrhULbS
         GdvGhhdWtzqhvWbU1Dvz7FfEX7WoIZHzIlQZwa3yozFf2I9wwHQ1Y+z6vLXoD00PQOOe
         dURxqHfyuhO6cexnNNYAMpZcyGxLrrQKORbPyIr/FEyERa4sVrbGNldKeVMUpFMQbSMk
         eTMmxB9WUP37dOlC5BQaN66WvzR6HvbFNI/H3TlBn54PDkCkkzcSrmFElk1sALYqnKZX
         65Uw==
X-Forwarded-Encrypted: i=1; AJvYcCXHUfny8qcphh7b5IDjR1J1sdwSIBtcMgSN/NlFjXar8Ks4WwWuGtoNII6LaagKliVGZYZ9WA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzzl1mV3/a3feLZcF5PFJfxZHcmfaFUbwVOzIki56KTZCRgSW4h
	zpU1PYVUSkYQ0BQL7sF0m/Bv9XlGYCjei4h4Ln9dZo7QATQDFUr8RV7uZADT5+Y=
X-Google-Smtp-Source: AGHT+IGoxmHIXunyrBa/p1uk2uHzYi1Z/hcWVNZcLQIdjI/t7vu+fCLqkwc8pknHtw/kuTjO+ExxGg==
X-Received: by 2002:a4a:edc7:0:b0:5da:9204:6727 with SMTP id 006d021491bc7-5dcc631afa3mr12061917eaf.6.1724680796380;
        Mon, 26 Aug 2024 06:59:56 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162de8c17sm46261346d6.140.2024.08.26.06.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 06:59:55 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1siaGB-00Bx31-9b;
	Mon, 26 Aug 2024 10:59:55 -0300
Date: Mon, 26 Aug 2024 10:59:55 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Klaus Jensen <its@irrelevant.dk>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Minwoo Im <minwoo.im@samsung.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, Joel Granados <j.granados@samsung.com>,
	Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH RFC PREVIEW 0/6] iommu: enable user space iopfs in
 non-nested and non-svm cases
Message-ID: <20240826135955.GI3468552@ziepe.ca>
References: <20240826-iopf-for-all-v1-0-59174e6a7528@samsung.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826-iopf-for-all-v1-0-59174e6a7528@samsung.com>

On Mon, Aug 26, 2024 at 01:40:26PM +0200, Klaus Jensen wrote:
> This is a Request for Comment series that will hopefully generate
> initial feedback on the use of the iommufd_hwpt_replace_device to
> execute non-nested and non-svm user space IOPFs. Our main motivation is
> to enable user-space driver driven device verification with default
> pasid and without nesting nor SVM.
> 
> What?
>   * Enable IO page fault handling in user space in a non-nested, non-svm
>     and non-virtualised use case.
>   * Removing the relation between IOPF and INTEL_IOMMU_SVM by allowing
>     the user to (de)select the IOPF code through Kconfig.
>   * Create a new file under iommu/intel (prq.c) that contains all the
>     page request queue related logic and is not under intel/svm.c.
>   * Add the IOMMU_HWPT_FAULT_ID_VALID to the valid flags used to create
>     IOMMU_HWPT_ALLOC allocations.
>   * Create a default (zero) pasid handle and insert it to the pasid
>     array within the dev->iommu_group when replacing the old HWPT with
>     an iopf enabled HWPT.
> 
> Why?
>   The PCI ATS Extended Capability allows peripheral devices to
>   participate in the caching of translations when operating under an
>   IOMMU. Further, the ATS Page Request Interface (PRI) Extension allows
>   devices to handle missing mappings. Currently, PRI is mainly used in
>   the context of Shared Virtual Addressing, requiring support for the
>   Process Address Space Identifier (PASID) capability, but other use
>   cases such as enabling user-space driver driven device verification
>   and reducing memory pinning exists. This patchest sets out to enable
>   these use cases.

I definitely expect PRI to work outside PASID and SVA cases, so this
is going in a good direction

>   Supplementary repositories supporting this patchset:
>     1. A user space library libvfn [1] which is used for testing and
>        verification (see examples/iopf.c), and

That's pretty neat, I've been wanting to see some kind of IOMMU test
suite based around a capable widely available device. This is the
closest I've seen..

Jason
