Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B24F412BED;
	Tue, 29 Sep 2026 06:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790662479; cv=none; b=Qhi31eeSf1GF3JZYZOcdS9O1qTNaL/7v4zCd/dAl1goOAGqDLKqjRgDenfvY8ACDVS4NAC9l3dNE/JjSiwG2XEgnIi2glraqbT/FVP4PVukcXP34lflofxDcNtfH3a8z7qlkl5TG+hVT97MKD7xIM0eqMMMRuNQeom1Up1FP6Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790662479; c=relaxed/simple;
	bh=9FOm1hsU1F7DEyf3uIn1iw+r0e3hRWK/OXHvv0ln8I0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oO8ZcaSnNTU6zc9YFD7veXramrw13qHh7eo+eCs+YoLAWnNcVoMjIkKQlWI4JBdJOugKtnJ58TJ9v2gXqAHaWihUwqh5LPtmUfh3yHUwFBJcDshSEp3mBD2O+pfy5/WVh9mwCbZ35TUdomx+7hzCfy5xnue90Ug60TK6zJ9y+pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CzGsEqqf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CzGsEqqf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C5A1F00893;
	Tue, 29 Sep 2026 06:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790662478;
	bh=D2SKz5oRd07NFB+3pvOPloPlMrPv7ay9F7/upJBv6vg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=CzGsEqqfk+j7TD73Ex/mFObBthaDRP0hl9m4HqSErs1VY/PyA7t4H/a22meHXk34a
	 oYVpj3KaqrhYbKS+GsD+slYWCwL3cvYsz/W4+BC+OmXI6HsuIJ8IJ0Xwx5nAQzyC1c
	 tYhg8VCDAvaOxSMMJtLDRN0/zgDQW2c84nRHv/jafR/pftpUjP0vDCgM4o7NlqsL/W
	 KcbrrUwQcf2YO0QHdaiaw7UpK8cHdA2zfqHb0NBM96ucKBwOKxlO7cMYwR3u8dY2qZ
	 ps0F5YChxAFPyNb4KxNbH4m1JL+ukzeQAI6vfOgPvqo7D56cg/wpNdkYSXrRD11ZIu
	 T2rIj2PYI+FTw==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: "Tian, Kevin" <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Cc: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
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
Subject: RE: [RFC PATCH v6 08/11] iommufd: Add vIOMMU provider support
In-Reply-To: <CO1PR11MB483580AB119687B7EC2DD8518C8D2@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
 <20260917140159.1163281-9-aneesh.kumar@kernel.org>
 <179027891417.104879.5995584402952067518.b4-review@b4>
 <yq5acxu1kgmo.fsf@kernel.org> <20260925123918.GI9354@nvidia.com>
 <CO1PR11MB483580AB119687B7EC2DD8518C8D2@CO1PR11MB4835.namprd11.prod.outlook.com>
Date: Tue, 29 Sep 2026 11:44:28 +0530
Message-ID: <yq5atsn8posb.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

"Tian, Kevin" <kevin.tian@intel.com> writes:

>> From: Jason Gunthorpe <jgg@nvidia.com>
>> Sent: Friday, September 25, 2026 8:39 PM
>> 
>> On Fri, Sep 25, 2026 at 11:38:15AM +0530, Aneesh Kumar K.V wrote:
>> > Jason Gunthorpe <jgg@nvidia.com> writes:
>> >

 [ ... 26 lines skipped ... ] 

>> 
>> Just put the two new ops in:
>> 
>> struct pci_tsm_ops {
>> 	size_t (*viommu_get_size)(struct device *dev, enum
>> iommu_viommu_type type);
>> 	int (*viommu_init)(struct iommufd_viommu *viommu, struct device
>> *dev,
>> 		    struct iommu_domain *parent,
>> 		    const struct iommu_user_data *user_data);
>> }
>> 
>> And bounce them with a static inline
>> 
>> static inline
>> ssize_t pci_tsm_viommu_get_size(struct device *dev, enum
>> iommu_viommu_type type)
>> {
>> 	const struct pci_tsm_ops *ops;
>> 	struct pci_dev *pdev;
>> 
>> 	if (!dev_is_pci(dev))
>> 		return -EINVAL;
>> 
>> 	pdev = to_pci_dev(dev);
>> 	if (!pdev->tsm)
>> 		return -ENODEV;
>> 
>> 	ops = to_pci_tsm_ops(pdev->tsm);
>> 	if (!ops->viommu_get_size)
>> 		return 0;
>> 	return ops->viommu_get_size(dev, type);
>> }
>> 
>> No module dependency.
>> 
>> The iommufd side is simple, it just calls this before calling the
>> iommu driver. First one to return a size wins and creates the viommu.
>> 
>> We'd want to have a reasonable lifetime model where the the pdev->tsm
>> is guarenteed stable while a driver is bound.
>> 
>
> +1

I am looking into implementing this as follows:

tsm_viommu_get_ops() runs with pci_tsm_rwsem held for read and takes a
temporary reference on the backend module (the CCA module). This keeps
the selected ops callable until vIOMMU initialization completes. iommufd
then drops the reference. This does not pin a particular TSM
registration or prevent tsm_unregister().

CCA vIOMMU initialization takes a tsm_dev reference, keeping the TSM
object and its PCI/TSM resources alive until the vIOMMU is destroyed.
The initialization callback also takes a reference on the CCA module so
that the vIOMMU callbacks remain available after iommufd drops the
temporary discovery reference described above.

For a link TSM-connected device, a vdevice holds a pci_tsm_context
reference. The context holds device references and increments PF0's
context_users under the PF0 mutex. PCI/TSM disconnect checks that count
under the same mutex and returns -EBUSY while contexts remain. The
context is released during vdevice teardown. This prevents link
disconnect while a vdevice is active without blocking tsm_unregister().

A new unregistering state is added to tsm_dev. tsm_unregister() sets it,
unregisters the class device, and drops the registration reference. New
vIOMMU allocations, vdevice contexts, and PCI TSM connect/lock
operations reject the TSM once this state is set. Existing users retain
their references and can be torn down normally, so tsm_unregister() does
not need to wait for them. PCI/TSM teardown occurs when the last active
tsm_dev reference is dropped.

-aneesh
