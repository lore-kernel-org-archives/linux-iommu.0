Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3A911CBA
	for <iommu@lists.linux.dev>; Sat,  1 Mar 2025 00:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740789435; cv=none; b=PAAs0y6fI/nBK0DAXGhXyfxUnIcFU0UgfuCGwhgTqap4t84KRS9p3C3cyKk+SmFebioLsCalUsU9VZTedwGFtsgPHtDP6xdkRzmg3+pTgaB7ocJR2FYRep02WDYvttABEk8OY7Qg21iLKyubxdPWdlRr/EF95rdI1HJCl9d0t4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740789435; c=relaxed/simple;
	bh=KWp+JkEQ384C2ZZM2vnmvijKALezyZ2yoZO4XWGrnII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aNF+nkkJx0bg7mlSZNgZ8cGrRwlJFanu0g8rHMJiJ4AvBNElC6F7TbG2yGJKcBuv5I6UJaQfIPIWq6aC9pgdlqF/NwSxvqnfygUCATBCM8h4HDWZSFR9myiWBZK+mH4J6RV4Y8QqkpIL+eUDYm7Uj5DjAeXkKX8gc262x2EzIwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=RhMIZjYI; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="RhMIZjYI"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c0a4b030f2so348832885a.0
        for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 16:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1740789432; x=1741394232; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Td3ECwr3BYX3Fk7gFnUV4jIGzq67kra6+CNEYMgu4U=;
        b=RhMIZjYIkhQ0UlktsjyzQQ9ncqHp44ud/doo8MW609J5zTynWR0Qc7glfMqVrbh5CM
         3x0ytL7dwXrRl0cAhFInrbu0F2GnWHW34YPcR9HaWW5Zb8uuQ6CT8mGViOHyZtHlRcxh
         1SnPyi8WtjwDVd7hMe++DRT5SwpyuZIam8vBJno0WM89xtirEGylwy/7ou/uJhl+Qzq9
         babU2TJiUzWNrjq9lAJ0ljW+YI++fG6EEtycjotpVbEJlzL4Wb3IwC7cXohOK24AKhJV
         8Obwb0wFSZCQX46YQ96VbHDhffhU+lj8EeeKGlBzBJYxW7YVoutWjYuobr4R8LwSeeeu
         AO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740789432; x=1741394232;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Td3ECwr3BYX3Fk7gFnUV4jIGzq67kra6+CNEYMgu4U=;
        b=jGljfusMoEl8rPctDGqNTYPNO4YcGYLhSZkCA5AyF6BssR2bZm5k+dHHC+FTavMec+
         vfq5bwf536jLJinq+7BCS5quev8IPKzFf89hhOSKtl8Y2BOs7Yid/ITr9hdOXWNOQ1SQ
         6UUrtXDuTC1JHMbpnohXlaZCp5Y0mPzZY6KRWN3+b0YRq8iNJE5UljHFoT6w3OOegI0l
         VWImB0I0uffc6Rn/6Yc3knYPAp/0LfbB6Ceu0/yDp5SKlTc7wgD0lYYams46GzK0xzz3
         meq/sXn6tYhgP17ewzJm6eI4wKDIWrHgpz21GqmBsNgBrprpyhsFJAa201dp5rDOwuZ8
         m1qw==
X-Forwarded-Encrypted: i=1; AJvYcCWD0wpwdCf/5W1vzCEO3VssyerZU+gD3CFq276P7l999QSS1o/mvS6HIvngu4m3RB2FgTrPAQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzL+QrK/5mkjmNDfEH5hYgA8bmj7ceOyxz5PFxT9kl5xf9zJ4St
	MvACDK6go1zupjwGV2ANNDwR4RFH/GbgMcqRrB93+RUwkN0TYoSlL9wg7b3e5h4=
X-Gm-Gg: ASbGncu+i2oise5M5QK2eUtyn3gBl2URTO/yo1r59qMJCOLBcjfatl583lKpxLiqfw2
	pQAxQgi4S1trgyvT+5N+QUF+9XZKmLJ0VInm6nUc/DpOQ3bctQHoVp9m8CTv7Yw45pMMim+EBjK
	B2jt1xNlfsJaFV2kdbxZZ3JEfCkiCDz1CR3sZWTA851WXF2CLmMaycN0Z9qq+Ovw9kK+CK/dFkh
	wC0+AL2iJXCe5BCe2xs0pjTo9+niIN6/jKmSqBrxZ6rqr10ytxD1lvHlQ7mmhStOxDSvf1FQn1s
	R135Xon9V0NMXM6DMwyVtTP4Ix6MEZk6IBVRRSTPNa6R/gWfNT4fbmo6HrZAe6C621bBdGvHi56
	NzX6pJujlDnjN0fVj7Q==
X-Google-Smtp-Source: AGHT+IFOn/ksSHuws3wokBJvJa6/sj/LoYkAsoS+wBwh3GzDwSM7WHVrzGwS02MkZWU6Ex8ojjGm5Q==
X-Received: by 2002:a05:620a:4051:b0:7c0:9ac5:7f9e with SMTP id af79cd13be357-7c39c6691eamr774480385a.50.1740789432305;
        Fri, 28 Feb 2025 16:37:12 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c378dac6d3sm310478485a.97.2025.02.28.16.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 16:37:11 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1toAqt-00000000VRk-15Wo;
	Fri, 28 Feb 2025 20:37:11 -0400
Date: Fri, 28 Feb 2025 20:37:11 -0400
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
Message-ID: <20250301003711.GR5011@ziepe.ca>
References: <20250218111017.491719-1-aik@amd.com>
 <20250218111017.491719-15-aik@amd.com>
 <Z72GmixR6NkzXAl7@yilunxu-OptiPlex-7050>
 <2fe6b3c6-3eed-424d-87f0-34c4e7e1c906@amd.com>
 <Z77xrqLtJfB84dJF@yilunxu-OptiPlex-7050>
 <20250226131202.GH5011@ziepe.ca>
 <Z7/jFhlsBrbrloia@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7/jFhlsBrbrloia@yilunxu-OptiPlex-7050>

On Thu, Feb 27, 2025 at 11:59:18AM +0800, Xu Yilun wrote:
> On Wed, Feb 26, 2025 at 09:12:02AM -0400, Jason Gunthorpe wrote:
> > On Wed, Feb 26, 2025 at 06:49:18PM +0800, Xu Yilun wrote:
> > 
> > > E.g. I don't think VFIO driver would expect its MMIO access suddenly
> > > failed without knowing what happened.
> > 
> > What do people expect to happen here anyhow? Do you still intend to
> > mmap any of the MMIO into the hypervisor? No, right? It is all locked
> 
> Not expecting mmap the MMIO, but I switched to another way. VFIO doesn't
> disallow mmap until bind, and if there is mmap on bind, bind failed.
> That's my understanding of your comments.

That seems reasonable

> Another concern is about dma-buf importer (e.g. KVM) mapping the MMIO.
> Recall we are working on the VFIO dma-buf solution, on bind/unbind the
> MMIO accessibility is being changed and importers should be notified to
> remove their mapping beforehand, and rebuild later if possible.
> An immediate requirement for Intel TDX is, KVM should remove secure EPT
> mapping for MMIO before unbind.

dmabuf can do that..

> > > The implementation is basically no difference from:
> > > 
> > > +       vdev = container_of(iommufd_get_object(ucmd->ictx, cmd->vdevice_id,
> > > +                                              IOMMUFD_OBJ_VDEVICE),
> > > 
> > > The real concern is the device owner, VFIO, should initiate the bind.
> > 
> > There is a big different, the above has correct locking, the other
> > does not :)
> 
> Could you elaborate more on that? Any locking problem if we implement
> bind/unbind outside iommufd. Thanks in advance.

You will be unable to access any information iommufd has in the viommu
and vdevice objects. So you will not be able to pass a viommu ID or
vBDF to the secure world unless you enter through an iommufd path, and
use iommufd_get_object() to obtain the required locks.
 
I don't know what the API signatures are for all three platforms to
tell if this is a problem or not.

Jason
