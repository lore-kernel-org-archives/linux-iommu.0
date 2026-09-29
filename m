Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4248330317;
	Tue, 29 Sep 2026 23:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790723730; cv=none; b=VY26xpnY0r1XpQLHkulgPx2HrhzB8lARv9az0gt/7hgt5pbWkxOYxiD47uFAoFpI9qCNnrffjtaUoyIK093xxVTwpwzo9SMdvjPhqXEGfOB64Fid/QYEy9lQEfdyFJ+LaIgDqMRYZdRn6WqqyqGqRZBuN4AmYEsKk26kBfcmtME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790723730; c=relaxed/simple;
	bh=iwFCjjCK0ZoHGnGUdHuRorHP5xMsXd648CaC1O/m5QA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KLZR45KdoLpC6myujsQPtYnLjF1cCSM3PgHEZFDLSvdN55sGghqByFHH5p8A6ZbLXp5ag+3+VLwg0wSB6GTSejAKjqeg10lwCzpBih7TjMMrOIWBqQzKU/LmsRZKzHEG32UJrB24Ii+CF1n1Lv3NOmDlwb4GUkCN5XKYAOqALTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XTJGUGuX; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XTJGUGuX"
Received: from localhost (unknown [52.148.138.235])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6CBFC20B7168;
	Tue, 29 Sep 2026 16:14:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6CBFC20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790723677;
	bh=SCR8BZy5m3MNNjZFeD4xV7VLw+Wr0Y/lqzbK2ZUbZgE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XTJGUGuXlNb7sFYYsoaeI5eKIAk1S20Lp73ctaC9YVAyQeLetTbsW6W/l2LIbh2Ip
	 zxnkWbw1zzYf5WSfUAulBveJm9Ey73RhYKMTIWsBascnnFHT1/ev9WbNO6yvA8phGi
	 xV79BuDJn7qIBuD6Fk7nlBKIdWK2DmjDKTUQ//8Y=
Date: Tue, 29 Sep 2026 16:15:27 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 linux-coco@lists.linux.dev, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Alexey Kardashevskiy
 <aik@amd.com>, Bjorn Helgaas <helgaas@kernel.org>, Joerg Roedel
 <joro@8bytes.org>, Jonathan Cameron <jic23@kernel.org>, Kevin Tian
 <kevin.tian@intel.com>, Nicolin Chen <nicolinc@nvidia.com>, Samuel Ortiz
 <sameo@rivosinc.com>, Steven Price <steven.price@arm.com>, Suzuki K Poulose
 <Suzuki.Poulose@arm.com>, Will Deacon <will@kernel.org>, Xu Yilun
 <yilun.xu@linux.intel.com>, Shameer Kolothum
 <shameerali.kolothum.thodi@huawei.com>, Paolo Bonzini
 <pbonzini@redhat.com>, jacob.pan@linux.microsoft.com
Subject: Re: [RFC PATCH v6 05/11] iommu: Add a helper to validate a vIOMMU
 parent
Message-ID: <20260929161527.00001275@linux.microsoft.com>
In-Reply-To: <20260929123048.GJ1616761@nvidia.com>
References: <20260925122305.GG9354@nvidia.com>
	<yq5a5wzpr7b9.fsf@kernel.org>
	<20260928121147.GP9354@nvidia.com>
	<yq5azex1peqt.fsf@kernel.org>
	<20260928161738.GB1616761@nvidia.com>
	<20260928110854.00003ff0@linux.microsoft.com>
	<20260928182022.GD1616761@nvidia.com>
	<20260928152402.000079ce@linux.microsoft.com>
	<20260928230328.GE1616761@nvidia.com>
	<20260928225524.00002b85@linux.microsoft.com>
	<20260929123048.GJ1616761@nvidia.com>
Organization: LSG
X-Mailer: Claws Mail 3.21.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Jason,

On Tue, 29 Sep 2026 09:30:48 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, Sep 28, 2026 at 10:55:24PM -0700, Jacob Pan wrote:
> 
> > Also, we don't have a T=0 to T=1 transition, our intended external
> > attach can be transitioned from a blocked domain, not from a paging
> > domain to external.  
> 
> You kind of do, external is close to T=1..
> 
> > > I think you are going to have module dependency issues trying to
> > > get the mshv driver's info into the iommu driver, adding a "TSM"
> > > like driver would resolve that. ie mshv could just provide the
> > > viommu. 
> > I introduced a similar registration interface in hv-common to solve
> > the module dep issue. Will look into if I can leverage the vIOMMU
> > helper here.  
> 
> That doesn't sound so nice..
> 
> If we have to have registrations it is better to have the viommu
> registration that Aneesh drafted than several schemes inside specific
> drivers..
Agreed. Now that the commonality with the TSM provider path is clear, I
will adapt the MSHV support to use the generic vIOMMU provider
registration.
