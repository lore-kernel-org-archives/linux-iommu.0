Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAC01C68F
	for <iommu@lists.linux.dev>; Fri,  8 Dec 2023 13:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XqXXC5SC"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-425922f5b89so9153121cf.0
        for <iommu@lists.linux.dev>; Fri, 08 Dec 2023 05:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1702042900; x=1702647700; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YucZctI9OnES6g1Fy1Wtf0Z1+OcLPgAF9qFfV1szyvI=;
        b=XqXXC5SC8Y54dqBHdK722AwJJRnD/2tlRnDXhffI5sYHiP8x25AVyqjnN6Sjgo/Mr1
         A3W+E9A3PGKCdumsNlwBEJHZmU4PCwFqO//jCiQ8Fp8SWnd+omCYEuxTDNCBNGcPh2F1
         v+i1F27QNHrK+LhaxS5lUGTL8LRdzJVjeLdfbdZNQg9FTPsleeQh14IZ+wOK0EeQzSrj
         l5ZNHo8a5560eBDnnJqUPKMaZ2dGlPHs3ExK61kYfY4EzouIDqmKknfmO41LsipRzHRp
         0CMtHzdWL6oH8MrrCSbzvDW/CJ4FvHPMM02Yjh8UDHIX/vpRwPNecvl+y9Yeq3Slg47Y
         AT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702042900; x=1702647700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YucZctI9OnES6g1Fy1Wtf0Z1+OcLPgAF9qFfV1szyvI=;
        b=OF+EwRWNKKf2VIrMCYsqg9t7rnLhQxLH+WP282n25QnQ23d+YVFxhNyVyvhbzM+NTC
         F5BlQ2XI+prZnchbAlxWJuxsKr6QNy/FTTnmLBAmGPHXnMh3mB/Gnp/KLTLt/1QTRhgT
         SZJx1pbeF5HwMz1Qp9C3LVW1cUfktrrEOBNXj12BCgQ19O12kVeA80gYdFA/eoXqcSUQ
         baKgdZiu+fGLZBNmW9xY2TdH9HmuuMQ0kFMfIJjvzBRHlZRW7a7HFuMuKS502j/W5DW0
         8aKGs1kTpZ1qFWABHTBjgY3sqCSr8LxKxgJLH4v+NgxRaXgfBEP8mxTrLaSsVXTrb0pz
         P3rg==
X-Gm-Message-State: AOJu0YxI2vjGXKN8/V2JWUBn4edK2tTUQEJcrMLtaHZaA9vIGRCZHlC6
	gsE/2FVB8tyRQp3IX1+Zpd7gNA==
X-Google-Smtp-Source: AGHT+IHjZ5fbgyGNj4pXddo/yd/fsGP0DpJlldXMV869RcUAC8mCOG4RaDWeA5g67kLmuW+2zDsrMw==
X-Received: by 2002:a05:622a:1708:b0:425:4043:1d77 with SMTP id h8-20020a05622a170800b0042540431d77mr105008qtk.74.1702042900661;
        Fri, 08 Dec 2023 05:41:40 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id cd5-20020a05622a418500b004255fd32eeasm543901qtb.7.2023.12.08.05.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 05:41:40 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rBb6p-00C88X-Fn;
	Fri, 08 Dec 2023 09:41:39 -0400
Date: Fri, 8 Dec 2023 09:41:39 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joel Granados <j.granados@samsung.com>,
	Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] iommufd: Deliver fault messages to user space
Message-ID: <20231208134139.GW1489931@ziepe.ca>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <20231026024930.382898-5-baolu.lu@linux.intel.com>
 <CGME20231207163412eucas1p2fa912b4923031804c27c764e5c8d67e7@eucas1p2.samsung.com>
 <20231207163410.ap3w4faii6wkgwed@localhost>
 <20231207171742.GU1489931@ziepe.ca>
 <c72184d8-693d-43ce-aed9-00a8fc684137@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c72184d8-693d-43ce-aed9-00a8fc684137@linux.intel.com>

On Fri, Dec 08, 2023 at 01:47:35PM +0800, Baolu Lu wrote:
> On 12/8/23 1:17 AM, Jason Gunthorpe wrote:
> > On Thu, Dec 07, 2023 at 05:34:10PM +0100, Joel Granados wrote:
> > > > @@ -58,6 +255,8 @@ static void hw_pagetable_fault_free(struct hw_pgtable_fault *fault)
> > > >   	WARN_ON(!list_empty(&fault->deliver));
> > > >   	WARN_ON(!list_empty(&fault->response));
> > > > +	fput(fault->fault_file);
> > > > +	put_unused_fd(fault->fault_fd);
> > > I have resolved this in a naive way by just not calling the
> > > put_unused_fd function.
> > That is correct.
> > 
> > put_unused_fd() should only be called on error paths prior to the
> > syscall return.
> > 
> > The design of a FD must follow this pattern
> > 
> >   syscall():
> >     fdno = get_unused_fd_flags(O_CLOEXEC);
> >     filep = [..]
> >     // syscall MUST succeed after this statement:
> >     fd_install(fdno, filep);
> >     return 0;
> > 
> >    err:
> >      put_unused_fd(fdno)
> >      return -ERRNO
> 
> Yes. Agreed.
> 
> > 
> > Also the refcounting looks a little strange, the filep reference is
> > consumed by fd_install, so what is that fput pairing with in fault_free?
> 
> fput() pairs with get_unused_fd_flags()? fd_install() does not seem to
> increase any reference.

fd_install() transfers the reference to the fd table and that
reference is put back by the close() system call.

Notice that instantly after fd_install() a concurrent user can free
the filep.

Jason
