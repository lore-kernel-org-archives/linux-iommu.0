Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083DE1C68F
	for <iommu@lists.linux.dev>; Fri,  8 Dec 2023 13:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="iy5ZjXfy"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-67acdcb3ccdso13022436d6.1
        for <iommu@lists.linux.dev>; Fri, 08 Dec 2023 05:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1702042999; x=1702647799; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5aDtOWyPfn3w5tEvf3D6QXjzQ1IFO5OBYuP3/lTcT5U=;
        b=iy5ZjXfy+sd9gGGJYyc+Yu4WHyMLwGDaMaX0G7GxZ5bfY6o1/TorPbOw1giq0MrZ5p
         SoVGUO1Em7wx6VTG9R2BM2x3zuHo+Pe/iYcVYcwyTngui8tc8vOtCaECFz0mJ/6Bciqd
         +GFVObt05k4lYRyCW8hIjigV3Iid9ikNdqvZWvNr6OkYO/dZLXlOPcGyWVdPXrFBj6ml
         JvWoMzODZ+neKimrGBjzlNQHXFUgPlHf/r6IW88NVjfMHez5xpse/n1vLl9yNEwpp3wh
         IN29kb5fkE6vkHCUgrzxmhQwB8mfs5uzSJtP7WPidehZgzn9djn1tufhPEBx+/f8QSUh
         2dXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702042999; x=1702647799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5aDtOWyPfn3w5tEvf3D6QXjzQ1IFO5OBYuP3/lTcT5U=;
        b=j7meXcNt8j2UY2C+GO2vgNxcMHKrb/aNG3vLOGmPx5XwQgct/b9MNg0hTo3yZBlI6U
         mIA42BaVDuoBf1W/AeBZfMyNS5vB6Ket0SWNvcZI+8pRzJ1BqsmjZrYHaTqnprujB/tt
         TfktCxOi+M59Z6TJMD+X2kKIrDMaCTpwWBIjlesSFYgUQ5QwRKSt9dhN0m59uAs/57Ha
         Uv7vnNSpWSOKkZ+wgDOTHdwoDcrlCMiES9loTZxYTUElp2bI8+s8wWqepQUiBeL1J9FE
         RU7EzvGP+srooa9k5ImSM7SNCY4NHvJIwtaSEuGGu46XoTGrRvjwq4WAjQck92nnR5iv
         MvmQ==
X-Gm-Message-State: AOJu0YydfLF890r59kyfqXWwo+ER3XGnkG62EE5FMlZZ5q9csaZpoRY8
	Q9BgsfHq/f8jce9sCRu765amVAQ/EnQ+ixkFjKo=
X-Google-Smtp-Source: AGHT+IHv12Tb/0Ej5uN/WlXa3rS44BxBF06RODHchs+ChcBQjqI7N5TgNevBZ3fMHu6sl89MwDK8fg==
X-Received: by 2002:a05:6214:e87:b0:67a:a721:b1be with SMTP id hf7-20020a0562140e8700b0067aa721b1bemr5609000qvb.121.1702042998853;
        Fri, 08 Dec 2023 05:43:18 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id a19-20020a0cefd3000000b0067abb3f1ad0sm804745qvt.92.2023.12.08.05.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 05:43:18 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rBb8P-00C89F-TH;
	Fri, 08 Dec 2023 09:43:17 -0400
Date: Fri, 8 Dec 2023 09:43:17 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] IOMMUFD: Deliver IO page faults to user space
Message-ID: <20231208134317.GX1489931@ziepe.ca>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <20231201142427.GJ1394392@ziepe.ca>
 <46c80b4e-9f05-4fb2-a31d-7386a41c895a@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46c80b4e-9f05-4fb2-a31d-7386a41c895a@linux.intel.com>

On Fri, Dec 08, 2023 at 01:57:26PM +0800, Baolu Lu wrote:
> On 12/1/23 10:24 PM, Jason Gunthorpe wrote:
> > On Thu, Oct 26, 2023 at 10:49:24AM +0800, Lu Baolu wrote:
> > > Hi folks,
> > > 
> > > This series implements the functionality of delivering IO page faults to
> > > user space through the IOMMUFD framework for nested translation. Nested
> > > translation is a hardware feature that supports two-stage translation
> > > tables for IOMMU. The second-stage translation table is managed by the
> > > host VMM, while the first-stage translation table is owned by user
> > > space. This allows user space to control the IOMMU mappings for its
> > > devices.
> > > 
> > > When an IO page fault occurs on the first-stage translation table, the
> > > IOMMU hardware can deliver the page fault to user space through the
> > > IOMMUFD framework. User space can then handle the page fault and respond
> > > to the device top-down through the IOMMUFD. This allows user space to
> > > implement its own IO page fault handling policies.
> > > 
> > > User space indicates its capability of handling IO page faults by
> > > setting the IOMMU_HWPT_ALLOC_IOPF_CAPABLE flag when allocating a
> > > hardware page table (HWPT). IOMMUFD will then set up its infrastructure
> > > for page fault delivery. On a successful return of HWPT allocation, the
> > > user can retrieve and respond to page faults by reading and writing to
> > > the file descriptor (FD) returned in out_fault_fd.
> > 
> > This is probably backwards, userspace should allocate the FD with a
> > dedicated ioctl and provide it during domain allocation.
> 
> Introducing a dedicated fault FD for fault handling seems promising. It
> decouples the fault handling from any specific domain. I suppose we need
> different fault fd for recoverable faults (a.k.a. IO page fault) and
> unrecoverable faults. Do I understand you correctly?

I haven't thought that far ahead :) Once you have a generic fault FD
concept it can be sliced in different ways. If there is a technical
need to seperate recoverable/unrecoverable then the FD flavour should
be specified during FD creation. Otherwise just let userspace do
whatever it wants.

Jason
