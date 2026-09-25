Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9094947424F;
	Fri, 25 Sep 2026 08:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790325010; cv=none; b=YAeR0XP3JLTSD99kX46N4QVCA8sKm0Cl3rGu/F9BdpbhZSdyCfZqbFBHgbYbFaaggU//aoCmYbNBqzAMmErHgWTQtCw2O9YytCkMLxYvptI2B7WEZz0IT7JbyqTO4KALlGpKKPdM4uhQE91+URFCFUA/7BtlhgPAj4nAeLwJpDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790325010; c=relaxed/simple;
	bh=xhM1NDChH2yBawOA0vUao/tE6p8o+ERW0qsYwP7gEQs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c/jtVqPSP6iTWX9jaNA9fCEw/PK0tKktxMDXBxvbKpxeRXmDEAOcbhYb5x/6vYv4YUC4jHreW70gPlLDoGMABfyHRRhxliCssFaWLNzy6jhDO4Z8mNrvqEr9J22tSfO+Nprq/t5TxLcbteVscerKOeCeQc9Pex+67+c8z3XiqpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVdxndEl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVdxndEl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E55B21F000FF;
	Fri, 25 Sep 2026 08:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790325008;
	bh=rglxVdnrltiFTbNqP4P/NgQosnzKQgmbqN8xvLDEm5M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=fVdxndEl6qmzTqWiM+UdhtVle1tOzfNzhtqYqX6biLR6O9LkSVLrLL4fiz4t2Gfko
	 hfZNSJ21zU1sLc98URdnvGYobn06NAZjhwWSePtelR0L4tiO9/EE0om9S0p+57eYc1
	 9tCVPfbvQf+Th/NPPGsyab75An5lOoIUZPPcSOtMo1xKdDjILWHIC2zA8ozC9Gt1r2
	 ZhvyoszTGd8Dl8yskVHqZawRy2PvZhMg4V9oViW3hhRB8A6vqI2VCMaVYyCD+Hsfso
	 3ZYyxrpD7kTkczqkCgGBVDU2hyEeBkCJWxdzL+W8+E5saCWFRZZF490FasuuMZLkWj
	 8b3Rs+YTxE0Ww==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: "Tian, Kevin" <kevin.tian@intel.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: RE: [RFC PATCH v6 00/11] iommufd: Infrastructure for vIOMMU
 creation for confidential guests and guest TSM requests
In-Reply-To: <CO1PR11MB48358E3116CC6CF34E6437658C812@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
 <CO1PR11MB48358E3116CC6CF34E6437658C812@CO1PR11MB4835.namprd11.prod.outlook.com>
Date: Fri, 25 Sep 2026 13:59:59 +0530
Message-ID: <yq5a33uxka2g.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

"Tian, Kevin" <kevin.tian@intel.com> writes:

>> From: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>> Sent: Thursday, September 17, 2026 10:02 PM
>> 
>> This series adds the IOMMUFD and PCI/TSM infrastructure required for device
>> assignment. It introduces an IOMMUFD-owned vIOMMU provider registry and
>> the
>> IOMMU_VDEVICE_TSM_REQ ioctl.
>> 
>> The series adds a vIOMMU provider abstraction that allows a subsystem
>> other than the physical IOMMU driver to implement a vIOMMU type. It groups
>> the vIOMMU operations with their module owner and private data, and makes
>> that implementation discoverable during vIOMMU allocation.
>> 
>> External providers are selected by exact vIOMMU type. When no provider
>> matches, vIOMMU creation falls back to the physical IOMMU driver. Once a
>> provider matches, its result is authoritative and failures do not trigger
>> fallback.
>> 
>
> I wonder whether this abstraction is necessary.
>
> The underlying IOMMU driver still needs to understand this vIOMMU type
> to check vendor-specific compatibility and provide the relevant hardware
> parameters.
>

There is an iommu_ops callback, viommu_get_params, that can be used to
check compatibility and return hardware parameters.

> There may also be further vendor-specific interactions between
> the IOMMU and TSM drivers.
>

This is an important point. Can you identify those interactions so we
can determine whether an iommu_ops callback is the right abstraction?

> In that case, the abstraction risks becoming
> little more than a connection between two vendor-specific drivers, while
> making it harder to maintain a clear scope for its operations.
>
> Would it be simpler to provide helper APIs and let the IOMMU driver use
> its own interface to delegate vIOMMU operations to the TSM driver? 
>

Does this mean that the vIOMMU would be created by iommufd, with
the TSM driver registering callbacks that iommufd invokes for
TSM-related operations?

> From iommufd's perspective, the vIOMMU type and its operations would
> still be handled by the IOMMU driver.

-aneesh
