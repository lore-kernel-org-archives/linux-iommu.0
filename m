Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48602CCC6;
	Tue, 29 Sep 2026 12:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790685949; cv=none; b=BT3ukaeyKh2KqTim9xgz8TCz21x6t4Kk29w5s/2GStd+/c7cyjqxElzBy5NBH4IaGcnWcaxmHQebj5fsQA4qitiRQWj0unssa1/nB8PgNja6pkGEpO4rUCVYtRmhxx02EwF5Iv2jW4aBLuY5ao8agqiOGJk3Zj0/fjbwDTST+Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790685949; c=relaxed/simple;
	bh=qnm2RhPFRDpTqXj55ishlxNlGXELwe5/rhYz9tjyx94=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pWpFfYRA3m+/z9i8dt8kUsWLAtpKnEXo8UlD4+LfoZdJzmTbwpG1+zywqCUNciaFsf3sVo1/1QshYKOk0qXRV54eS+xGiWdIf+HXGfN0Dxf0IjPgzzcIbXBHNEa4nrsdGsTCL4alIVGyBQ/1n+B8bFU+Yv6F8vApmHiRH2VQGxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=owMivbsp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="owMivbsp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DCFE1F000FF;
	Tue, 29 Sep 2026 12:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790685948;
	bh=+PvuRUjwfVEYB0LlwC45wEHePseY0nNhXaBtNPmKXzE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=owMivbspanebUhaAPh5cLnsyGm9gfA5gdAsPctsT7RupcAB0EIueePVN68Nz9JHtw
	 7cEWSZl/fe2CBgndkqKyWd0Xfn5564xJvM65JPRKvBsMf5q/fGj0k18n4uwOlZeGBa
	 QNCDgcUxE2SOFtZB0pzVHuEN8K0b0hgS3Cy4N+ngaTD65paRc8NUYLU8yk4nbJtwx5
	 QJ/Eu+Wc78RX1K5olW/krnYKow82y3nS7aaDo5f0a3Lu1PkYX5GTBXdEVz4BIhPn+T
	 3kjrkFdc67b4pPIykIk3IHU/Xg9OXqdNOqVS2Qh1NWCus8kqKSbBNLvHidOeiaKIs0
	 PGFcgqImjRs7Q==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
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
Subject: Re: [RFC PATCH v6 08/11] iommufd: Add vIOMMU provider support
In-Reply-To: <20260929121723.GI1616761@nvidia.com>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
 <20260917140159.1163281-9-aneesh.kumar@kernel.org>
 <179027891417.104879.5995584402952067518.b4-review@b4>
 <yq5acxu1kgmo.fsf@kernel.org> <20260925123918.GI9354@nvidia.com>
 <CO1PR11MB483580AB119687B7EC2DD8518C8D2@CO1PR11MB4835.namprd11.prod.outlook.com>
 <yq5atsn8posb.fsf@kernel.org> <20260929121723.GI1616761@nvidia.com>
Date: Tue, 29 Sep 2026 18:15:39 +0530
Message-ID: <yq5aqzicp6oc.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@nvidia.com> writes:

> On Tue, Sep 29, 2026 at 11:44:28AM +0530, Aneesh Kumar K.V wrote:
>
>> tsm_viommu_get_ops() runs with pci_tsm_rwsem held for read and takes a
>> temporary reference on the backend module (the CCA module). This keeps
>> the selected ops callable until vIOMMU initialization completes. iommufd
>> then drops the reference. This does not pin a particular TSM
>> registration or prevent tsm_unregister().
>
> That seems over complicated. Maybe we can't get to the sane locking I
> suggested earlier where TSM module is stable while a driver is bound,
> but we absolutely must have sane locking where we can "pin" the tsm
> for a pdev and it cannot be unregistered for long periods of time,
> such as while a viommu/vdev exists.
>
> That period should start right before getting the ops and continue to
> until the viommu is destroyed.
>
> No hot unplug of tsm modules while things are active.
>


That is essentially how it works. I decided to take the module reference
here and the tsm_dev reference in viommu_init() to keep the rest of
viommu_alloc() cleaner. That is, we have:

	struct module *owner = NULL;

	ops = tsm_viommu_get_ops(idev->dev, cmd->type, &owner);

	if (!ops) {
		ops = iommu_dev->ops->get_viommu_ops(idev->dev, cmd->type);
                
	rc = ops->viommu_init(viommu, idev->dev,
	if (rc)
		goto out_put_hwpt;

out_put_idev:
	module_put(owner);

The tsm_dev and module details are needed only by tsm_viommu, not by a
generic SMMU driver. For viommu_init() to take ownership of the resources
acquired by get_ops(), I would either need to add a viommu_info argument
to viommu_init(), affecting all IOMMU driver implementations, or make the
error handling conditional and awkward.

What I have now is that get_ops() pins the module, so the CCA module
cannot disappear after get_ops() returns. We retain that reference until
viommu_init() completes, and viommu_init() establishes the long-term
pins internally. This keeps the API simpler.

>
>> CCA vIOMMU initialization takes a tsm_dev reference, keeping the TSM
>> object and its PCI/TSM resources alive until the vIOMMU is
>> destroyed.
>
> iommufd should do this, so long as the viommu object exists the tsm
> for it exists. It should not be inside tsm drivers.
>

That would expose more TSM details to iommufd. The reference must also
be acquired under pci_tsm_rwsem.

/* Pin the current TSM and revalidate the selected vIOMMU operations. */
struct tsm_dev * pci_tsm_viommu_get_tsm_dev(struct pci_dev *pdev,
		enum iommu_viommu_type type,
		const struct iommufd_viommu_ops *expected_ops)
{
	const struct pci_tsm_ops *ops;
	const struct iommufd_viommu_ops *viommu_ops;
	struct tsm_dev *tsm_dev;
	int ret = -ENODEV;

	{
		guard(rwsem_read)(&pci_tsm_rwsem);
		if (!pdev->tsm)
			return ERR_PTR(-ENODEV);
		if (pdev->tsm->tsm_dev->unregistering)
			return ERR_PTR(-ENODEV);
		ops = to_pci_tsm_ops(pdev->tsm);
		if (!ops->viommu_get_ops)
			return ERR_PTR(-ENODEV);
		tsm_dev = pdev->tsm->tsm_dev;
		/* Unlike get_device(), this also keeps PCI/TSM resources active. */
		if (!tsm_try_get(tsm_dev))
			return ERR_PTR(-ENODEV);

		viommu_ops = ops->viommu_get_ops(&pdev->dev, type);
		if (viommu_ops == expected_ops)
			return tsm_dev;
		if (IS_ERR(viommu_ops))
			ret = PTR_ERR(viommu_ops);
	}

	tsm_put(tsm_dev);
	return ERR_PTR(ret);
}
EXPORT_SYMBOL_GPL(pci_tsm_viommu_get_tsm_dev);


>
>> The initialization callback also takes a reference on the CCA module so
>> that the vIOMMU callbacks remain available after iommufd drops the
>> temporary discovery reference described above.
>
> The initial pin should do this since it is the only way to prevent
> unregistration.
>

see above

>
>> For a link TSM-connected device, a vdevice holds a pci_tsm_context
>> reference. The context holds device references and increments PF0's
>> context_users under the PF0 mutex. PCI/TSM disconnect checks that count
>> under the same mutex and returns -EBUSY while contexts remain. The
>> context is released during vdevice teardown. This prevents link
>> disconnect while a vdevice is active without blocking tsm_unregister().
>
> This one seems reasonable, but not sure a mutex is needed on top of a
> a simple refcount scheme.
>

The PF0 mutex is already used by PCI/TSM to serialize some of these
operations. I can double-check whether it is necessary here.

>
>> A new unregistering state is added to tsm_dev. tsm_unregister() sets it,
>> unregisters the class device, and drops the registration reference. New
>> vIOMMU allocations, vdevice contexts, and PCI TSM connect/lock
>> operations reject the TSM once this state is set. Existing users retain
>> their references and can be torn down normally, so tsm_unregister() does
>> not need to wait for them. PCI/TSM teardown occurs when the last active
>> tsm_dev reference is dropped.
>
> This seems over complicated, tsm unregistration should be made
> impossible while it is not able to complete. We shouldn't need the
> complexity of states here when we don't need to support tsm
> hot-unplug.
>
>
> ideally the module refcount handles this and the only way to trigger a
> tsm remove is through module unload, with no sysfs path?
>


I agree. The existing code takes extra care to allow tsm_unregister().
However, if unloading arm-cca-host.ko is the only way to trigger
unregistration, as it currently is, we can avoid this complexity.

-aneesh
