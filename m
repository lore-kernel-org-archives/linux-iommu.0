Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39343D75D3;
	Mon, 28 Sep 2026 10:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790592718; cv=none; b=CQWX0cRDlZeis185c12IpXT/ZtOxSp2Rrop4cLnc+Yfm1CiISgiEJsAFqD0mrzxBq8qgI7GUaxXHAzAsydcjzi4rxMbsEHwJYw/R2N5Fy6RPMUXDUZy4P/fPFEE7aaUimZ+SAAeuxN3uHroXBQMsTnFMtQuczkwBEmeGwAHa6V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790592718; c=relaxed/simple;
	bh=i9iWZp76BWiqX76RjNQSQWSTOTQ6yXB6zMkbMGgnohc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ufqI3p3CxI2QjViJF5iUvxiGqkuRaqbudxDoEf0UOzipDgLCKTgIuo5erEll+DcuSCHoc2uUh9b1Z8c6EifYnCyc1aRtZbcu5zygIxUg3EWdsFi+JVVcXrKwOwFoovrpTHvcYytiiM14mnFfrALItEGHlJo8depjDxhWpLVDAFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Txs5Ny69; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Txs5Ny69"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DBEC1F000FF;
	Mon, 28 Sep 2026 10:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790592716;
	bh=NN3wx/RsUxdRsvMjmcHQPLlgjDCWCOIl0dO7zW0TJIY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Txs5Ny69Ac9Ri4OQsx9iNJZleKBTZjRKoSp3ReMWT5euTFnxnDZ5vQGpmlP3sF3Al
	 lKKnhvvUN2DFBydjsg3XPlbzJyY1F7Dcgmh+GRBk8RMU3sKn2jFQvaGW4CV2lSblPD
	 mkg/mmNzKCn1APoK5P+l73nlg1dOg6bj3i5dgQVwlJ2J4tWquDPBe5bHqoBdSmxdrW
	 KuieIsdCW7MuISXxhWSL+2iUYnF9cQB2/g4akmKV42ff/yEQuDDI5Hm9psembfanoB
	 A0H7cEVzxCXb1klAA4GzGK1/dp3Ibg/tvtVSY2VKETj8uMY8M4HRg4EEK/7u09rb4V
	 ZBFRYSi7hX8IA==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-coco@lists.linux.dev, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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
In-Reply-To: <20260925123918.GI9354@nvidia.com>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
 <20260917140159.1163281-9-aneesh.kumar@kernel.org>
 <179027891417.104879.5995584402952067518.b4-review@b4>
 <yq5acxu1kgmo.fsf@kernel.org> <20260925123918.GI9354@nvidia.com>
Date: Mon, 28 Sep 2026 16:21:47 +0530
Message-ID: <yq5a33utr6m4.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@nvidia.com> writes:

> On Fri, Sep 25, 2026 at 11:38:15AM +0530, Aneesh Kumar K.V wrote:
>> Jason Gunthorpe <jgg@nvidia.com> writes:
>> 
>> >> vIOMMU creation currently dispatches directly through the physical IOMMU
>> >> driver. Some vIOMMU types need an implementation supplied by another
>> >> subsystem, together with private data whose lifetime extends across all
>> >> vIOMMUs using that implementation.
>> >> 
>> >> Introduce a vIOMMU provider that associates implementation operations,
>> >> their module owner and private data. Allow one external provider to
>> >> register for each non-default vIOMMU type.
>> >
>> > This seems much more extensive than I imagined when I proposed this.
>> >
>> > I imagined you'd just have iommufd see there is a TSM attached the pci
>> > device with a function call, and check if that TSM handled the
>> > requested iommu ID.
>> >
>> > No need for a registration system because we already know the only
>> > possible TSM driver that can handle it,
>> >
>> 
>> Agreed, there will be only one vIOMMU provider. But, without a
>> registration mechanism, what would the module dependency look like?
>> 
>> I currently have the TSM driver depending on IOMMUFD. Therefore, the TSM
>> driver needs to tell iommufd which vIOMMU type it provides and register
>> the corresponding provider. IOMMUFD does not call into TSM directly.
>
> Just put the two new ops in:
>
> struct pci_tsm_ops {
> 	size_t (*viommu_get_size)(struct device *dev, enum iommu_viommu_type type);
> 	int (*viommu_init)(struct iommufd_viommu *viommu, struct device *dev,
> 		    struct iommu_domain *parent,
> 		    const struct iommu_user_data *user_data);
> }
>
> And bounce them with a static inline
>
> static inline
> ssize_t pci_tsm_viommu_get_size(struct device *dev, enum iommu_viommu_type type)
> {
> 	const struct pci_tsm_ops *ops;
> 	struct pci_dev *pdev;
>
> 	if (!dev_is_pci(dev))
> 		return -EINVAL;
>
> 	pdev = to_pci_dev(dev);
> 	if (!pdev->tsm)
> 		return -ENODEV;
>
> 	ops = to_pci_tsm_ops(pdev->tsm);
> 	if (!ops->viommu_get_size)
> 		return 0;
> 	return ops->viommu_get_size(dev, type);
> }
>
> No module dependency.
>
> The iommufd side is simple, it just calls this before calling the
> iommu driver. First one to return a size wins and creates the viommu.
>
> We'd want to have a reasonable lifetime model where the the pdev->tsm
> is guarenteed stable while a driver is bound.
>

And the init side will be as below.

bool use_tsm = false;

viommu_size = tsm_viommu_get_size(dev, type);
if (viommu_size) {
	use_tsm = true;
} else {
	viommu_size = iommu_ops->get_viommu_size(dev, type);
	if (!viommu_size)
		return -EOPNOTSUPP;
}


Initialization becomes:


if (use_tsm)
	ret = tsm_viommu_init(viommu, dev, parent, user_data);
else
	ret = iommu_ops->viommu_init(viommu, parent, user_data);


-aneesh
