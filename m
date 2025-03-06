Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E4926E62D
	for <iommu@lists.linux.dev>; Thu,  6 Mar 2025 18:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741285579; cv=none; b=t0t8V80OQKyPPp9PYVF7iYXn0N+tZGgGUfndnf0XQym/WNLk/c/NFz63+Rh+CuTbMEEw2X9U9IQQftR1dHjjEJrUJa4fReUGL2YSSOO8wHDdtTlV4HN25SfFzyIBbtklaEkHSp71nTdlAClO3q+a7UK9moesb8I/4XpQg1xJNNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741285579; c=relaxed/simple;
	bh=A0wvu3n9vFC16f3qlUsNA6dfIvpISQcUDrHPkbUkZ+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qiYyOSK+mlPkAn4C50Ilq8Me885yH+fmzwQupDHkpGleOfZDRv+ZQmQ+r2u0e9fOHAAbgsdy3C2ZvF4JPU62z5YjWGTfU8vyC2CSLS0cqzPyQLbTKbQ3zaO9adMgxeWRXjKIxmLV7LKgOamX6P2Mi0hwj/SLzs7abcFo/mVgh9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=nzYm4u8p; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nzYm4u8p"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6e8f8657f29so6225356d6.3
        for <iommu@lists.linux.dev>; Thu, 06 Mar 2025 10:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1741285576; x=1741890376; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kJmNeR7cBbicmXZ58VNFTx5zHy0Fy/985QYAD/du2Go=;
        b=nzYm4u8pSPDfWc4fWZZfB+AfM6K6wR9dFSoBY91fdYh3HiV9Uht4uPfjaoWoYq0ILf
         V28GBB19GHeB6AU6F2OCMuyjyFC5e2IjvBfEP5Ees6BvXyQPJilmSSh9IilO/ywQnArg
         vYkPO4ch8W8bLMKylxle/EXWnGaj9yTi1dmii5h+KShAmpCi08DslO90xFoxZDBvD6rw
         Hbx3FFUFmNW18VlPRZ3N5TUUKGv9+eIOzqPFNNT7ymsepD1ieG4Cpf2gWcalufBfFwb3
         kJSYpvLd/Uqg5DrqHXjCG0DUaRris4kKhsB7oeFVkoRaN0vXKnhpnD1Dje/b1wkgJ+cb
         kdsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741285576; x=1741890376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJmNeR7cBbicmXZ58VNFTx5zHy0Fy/985QYAD/du2Go=;
        b=rwa0yCNy/pRaZtdWJsxT1MvPhgHFlmhe6zFSqkak634VekfyDfDSPGwHpzhVrG1xNB
         kjLaZY8xs3v9LKfzDk/pxjcUrlICXoHBkg4i++DfxOmpQwPYu2PH2F+8sv53cNmW6KrK
         psm/ij04FW2u+dQ/+9m0cLgypHSl/lc+4u6kDrbVDCDp+JGPtHQARmU4iE8v7/LqVcN4
         ODwCyvJy69N06d1U4697wK5s4VqnQB6VOLTKjPzWWyBIGNtwTgnF/GfK7GsclKM2R83C
         bZuzrIU8IvPpYLXg0J4WEaA3Ydsb8T+mTDGUgK4GXr5Z4s3meCfZteWY16v8QX7hoF6q
         du1A==
X-Forwarded-Encrypted: i=1; AJvYcCXDRx56VUmU4kgNy4aIgF3WajaNBfsNptn3nK60TtwSckKx8qYMruZXSqm5PAgx24jwyfFR3w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy9mLeJMipZGvOCM7oHL0each8d7DiFRxwyNSPgtWeC0ctRTU2I
	ALwpmaTsCCzpCuts1ZN19Ou1G0SYJOCHSzI6amy+sZVuVZlmVaqOgou/flbkz6k=
X-Gm-Gg: ASbGncuYEJsBE6NVGFbyTEmqTJUbMowWNtv4yc43EqdGtiOr6kT1o/tXK37sS+nNddj
	hCGi2TMXz4Xonr1AlkEpDWOQcvVurDjhiP3lCTU/GOjAEto/MKwg66BJ2sab5ebb+6nTAjeJwEM
	F/EsM2S4znabTiLytc9XID//VOFHuyiYoHzMCt06/ruVsRovAz7TLK96/dsyQh7cuUECN2oX4qB
	BCH4gnsIk5f4XFZz3i4+GluwUkP3RsJq7Gnht4aRGyUaSb48SJB1IHg9gcKplQTpS3NZvJX1QyD
	ToVbEt84nF9oowYtOCpk7ASdv1zFNyV/K0U0QATpkwDa7QQbu5L/llYEHCZKEnZ+emOGgw22YF+
	k0jEpZdNhMc8BBoeLyw==
X-Google-Smtp-Source: AGHT+IHdLGu9+NkI+poSobXraQKM371I6DGk+LdkIPbK8ktXY1plTaVgGJ4wX3yHHMcP8NJrRnY4AQ==
X-Received: by 2002:a05:6214:76c:b0:6e8:fde9:5d07 with SMTP id 6a1803df08f44-6e90066a2e7mr783186d6.26.1741285576387;
        Thu, 06 Mar 2025 10:26:16 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f7090c4csm9806836d6.33.2025.03.06.10.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 10:26:15 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tqFvC-00000001eHR-3E6L;
	Thu, 06 Mar 2025 14:26:14 -0400
Date: Thu, 6 Mar 2025 14:26:14 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Alexey Kardashevskiy <aik@amd.com>, x86@kernel.org, kvm@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Christoph Hellwig <hch@lst.de>, Nikunj A Dadhania <nikunj@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Steve Sistare <steven.sistare@oracle.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Dionna Glaze <dionnaglaze@google.com>, Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev, linux-coco@lists.linux.dev,
	Zhi Wang <zhiw@nvidia.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
Subject: Re: [RFC PATCH v2 14/22] iommufd: Add TIO calls
Message-ID: <20250306182614.GF354403@ziepe.ca>
References: <20250218111017.491719-15-aik@amd.com>
 <Z72GmixR6NkzXAl7@yilunxu-OptiPlex-7050>
 <2fe6b3c6-3eed-424d-87f0-34c4e7e1c906@amd.com>
 <Z77xrqLtJfB84dJF@yilunxu-OptiPlex-7050>
 <20250226131202.GH5011@ziepe.ca>
 <Z7/jFhlsBrbrloia@yilunxu-OptiPlex-7050>
 <20250301003711.GR5011@ziepe.ca>
 <Z8U+/0IYyn7XX3ao@yilunxu-OptiPlex-7050>
 <20250305192842.GE354403@ziepe.ca>
 <Z8lE+5OpqZc746mT@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8lE+5OpqZc746mT@yilunxu-OptiPlex-7050>

On Thu, Mar 06, 2025 at 02:47:23PM +0800, Xu Yilun wrote:

> While for AMD:
>         ...
>         b.guest_device_id = guest_rid;  //TDI ID, it is the vBDF
>         b.gctx_paddr = gctx_paddr;      //AMDs CoCo-VM ID
> 
>         ret = sev_tio_do_cmd(SEV_CMD_TIO_TDI_BIND, &b, ...
> 
> 
> Neither of them use vIOMMU ID or any IOMMU info, so the only concern is
> vBDF.

I think that is enough, we should not be putting this in VFIO if it
cannot execute it for AMD :\

> > You could also issue the TSM bind against the idev on the iommufd
> > side..
> 
> But I cannot figure out how idev could ensure no mmap on VFIO, and how
> idev could call dma_buf_move_notify.

I suggest you start out this way from the VFIO. Put the device in a CC
mode which bans the mmap entirely and pass that CC capable as a flag
into iommufd when creating the idev.

If it really needs to be dyanmic a VFIO feature could change the CC
mode and that could call back to iommufd to synchronize if that is
allowed.

Jason
