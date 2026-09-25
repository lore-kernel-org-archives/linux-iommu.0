Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BB72F28EA;
	Fri, 25 Sep 2026 06:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790316505; cv=none; b=Wd4Shuf9CuhkPyX3yEKYc57hMN980P3/naFIXydpggc4T/dlmnhKbFJKZn2Z7mWWDIQCNcS8A+Cd3shV/NRtgQY8UQE6CqqV5I3Mvku6i9ifJ8/C69b1T0TW6gT/peFfeqCZOQndOROcgN7EI9PcU1/Yjs7iAHqwUVmPTC0hT8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790316505; c=relaxed/simple;
	bh=v7Ng6pbWuhjKtpWvJrwm3MDBqlHea2aWPL1IrJ9RS94=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CGVUOq6/rEMjNDwy0zWPQ2b2RhipbDHAiNKC9IzWPZQzkF6dhTXcpf4CsYTKzaSUt2/Xslq0efhdf9xuRnyhMYF7m0v5pfwloS0eEt4sbdUbJZw57pKz8b/TzpPTr/KCC9LM6dNOjX6nD/e4g8dN8+OfKkO8+1XyhsT62pmhWSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bux6HE00; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bux6HE00"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627991F000FF;
	Fri, 25 Sep 2026 06:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790316503;
	bh=P9RibqlRqnRkot6x6sBrQU1dqouJEKEPTfRSSn/46wY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=bux6HE00tUoGtUMQgmmQV6Vn75v2m5JASXXgDsilWKcTrvosGsteG7GIwS1Jb9E/b
	 gjErOV95yKbqn7m4tkxk3cc//pKNRZcGsHZ+0tSjtiHBeBeWP1xcrSidgxUcFIGb9k
	 mCXejvn721P7fom+/bzaHsh+oeh6yz5gBE0/WlT8kt64rhXC+I9b/oZcP7XpQ0r3a0
	 UYltQquXKGnXryceCvrhkEP0lvPq0r5fo4MUeIjcupfjsFiTorBb9QUh7aF11B9lYW
	 uonZXQU7LCvG2xO2cWJBHexscRDYNQduQGJYLQKo9WZiGtlJyWecetxuVuGBUS/jqq
	 wTj8/m1Z7T87g==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-coco@lists.linux.dev, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v6 08/11] iommufd: Add vIOMMU provider support
In-Reply-To: <179027891417.104879.5995584402952067518.b4-review@b4>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
 <20260917140159.1163281-9-aneesh.kumar@kernel.org>
 <179027891417.104879.5995584402952067518.b4-review@b4>
Date: Fri, 25 Sep 2026 11:38:15 +0530
Message-ID: <yq5acxu1kgmo.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@nvidia.com> writes:

>> vIOMMU creation currently dispatches directly through the physical IOMMU
>> driver. Some vIOMMU types need an implementation supplied by another
>> subsystem, together with private data whose lifetime extends across all
>> vIOMMUs using that implementation.
>> 
>> Introduce a vIOMMU provider that associates implementation operations,
>> their module owner and private data. Allow one external provider to
>> register for each non-default vIOMMU type.
>
> This seems much more extensive than I imagined when I proposed this.
>
> I imagined you'd just have iommufd see there is a TSM attached the pci
> device with a function call, and check if that TSM handled the
> requested iommu ID.
>
> No need for a registration system because we already know the only
> possible TSM driver that can handle it,
>

Agreed, there will be only one vIOMMU provider. But, without a
registration mechanism, what would the module dependency look like?

I currently have the TSM driver depending on IOMMUFD. Therefore, the TSM
driver needs to tell iommufd which vIOMMU type it provides and register
the corresponding provider. IOMMUFD does not call into TSM directly.

-aneesh

