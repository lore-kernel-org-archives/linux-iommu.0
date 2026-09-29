Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBB546F494;
	Tue, 29 Sep 2026 15:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790697550; cv=none; b=E4ycgyWle3g8WZY0eMM7dOIh+hecL+AQDYEAxPl+xPeFGe2fyubF6Ju/FfjoD6SOT40/dIn4vcdgUJt8aaO1RkLoTNWNp8527Zeew+KNaBX4uQLNT1kwR6np3CWSaV86yXmV+XQrJ0JDOLvjoWTl2ljG+Kwu2U0zz2MZeBVEjCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790697550; c=relaxed/simple;
	bh=oNY6pvl62fDrWyXHEGscg+QfWsikrFZUD3qzrdwaKwM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YDYGhHhtKelVsqGSKhu5T6bJ4DZF5O+2S7CBKRtS/gX0/IhCuz/pzPr3FEQKKMeHuVsALNT5CakiGJSiMoHClfUchC6RHlGptOlU1mYKZk+AGNdyeoecbUh70g1Hl3sulHWD4yX38Q7MPdsFePTFw2UUxmIgnTKol777v/Nhymk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPeNPuU3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPeNPuU3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3FD51F000FF;
	Tue, 29 Sep 2026 15:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790697542;
	bh=bk6LzkoYwabfYGJGHc5M32NHw8d6cLNScan2vJ7kpPw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=bPeNPuU3JeMZyxyBG1jcn/LsRS+2SPoB24KIZtG5YPsr9ckxhjOjvsgWMgj6qnw2R
	 CPDdF+buiQgEn9wr7jKmGrKJqoeV1H+HP2+kjWLQ2psOhB4252bK27TRi5eRI69xAk
	 0/+4ksyu1BhfNn9m3aketvMYWQLITtMLhpsyLDBRVL4+2+dR2VYY0VxN583FXabJYW
	 NBBzCE99vAzY2Ixfoj6idCii/5dqali3I1BYBWdHdPT6hyyDwLasdaoSuKgFRErOxI
	 z5xc0+MF4ylFyVo396ExFP87fqfVb2FUZSvb1mEBPlihqkkDMV8XBosBQM0g4nagqe
	 gtURzyAMhlQKQ==
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
In-Reply-To: <20260929130643.GL1616761@nvidia.com>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
 <20260917140159.1163281-9-aneesh.kumar@kernel.org>
 <179027891417.104879.5995584402952067518.b4-review@b4>
 <yq5acxu1kgmo.fsf@kernel.org> <20260925123918.GI9354@nvidia.com>
 <CO1PR11MB483580AB119687B7EC2DD8518C8D2@CO1PR11MB4835.namprd11.prod.outlook.com>
 <yq5atsn8posb.fsf@kernel.org> <20260929121723.GI1616761@nvidia.com>
 <yq5aqzicp6oc.fsf@kernel.org> <20260929130643.GL1616761@nvidia.com>
Date: Tue, 29 Sep 2026 21:28:53 +0530
Message-ID: <yq5ald8koxqa.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@nvidia.com> writes:

> On Tue, Sep 29, 2026 at 06:15:39PM +0530, Aneesh Kumar K.V wrote:
>> Jason Gunthorpe <jgg@nvidia.com> writes:
>> 
>> > On Tue, Sep 29, 2026 at 11:44:28AM +0530, Aneesh Kumar K.V wrote:
>> >
>> >> tsm_viommu_get_ops() runs with pci_tsm_rwsem held for read and takes a
>> >> temporary reference on the backend module (the CCA module). This keeps
>> >> the selected ops callable until vIOMMU initialization completes. iommufd
>> >> then drops the reference. This does not pin a particular TSM
>> >> registration or prevent tsm_unregister().
>> >
>> > That seems over complicated. Maybe we can't get to the sane locking I
>> > suggested earlier where TSM module is stable while a driver is bound,
>> > but we absolutely must have sane locking where we can "pin" the tsm
>> > for a pdev and it cannot be unregistered for long periods of time,
>> > such as while a viommu/vdev exists.
>> >
>> > That period should start right before getting the ops and continue to
>> > until the viommu is destroyed.
>> >
>> > No hot unplug of tsm modules while things are active.
>> >
>> 
>> 
>> That is essentially how it works. I decided to take the module reference
>> here and the tsm_dev reference in viommu_init() to keep the rest of
>> viommu_alloc() cleaner. That is, we have:
>> 
>> 	struct module *owner = NULL;
>> 
>> 	ops = tsm_viommu_get_ops(idev->dev, cmd->type, &owner);
>> 
>> 	if (!ops) {
>> 		ops = iommu_dev->ops->get_viommu_ops(idev->dev, cmd->type);
>>                 
>> 	rc = ops->viommu_init(viommu, idev->dev,
>> 	if (rc)
>> 		goto out_put_hwpt;
>> 
>> out_put_idev:
>> 	module_put(owner);
>
> if we have a get_ops we need a put_ops()..
>
>> The tsm_dev and module details are needed only by tsm_viommu, not by a
>> generic SMMU driver. For viommu_init() to take ownership of the resources
>> acquired by get_ops(), I would either need to add a viommu_info argument
>> to viommu_init(), affecting all IOMMU driver implementations, or make the
>> error handling conditional and awkward.
>
> Just don't, iommufd can hold the tsm ops if it knows it created the
> viommu through tsm.
>
>
>> >> CCA vIOMMU initialization takes a tsm_dev reference, keeping the TSM
>> >> object and its PCI/TSM resources alive until the vIOMMU is
>> >> destroyed.
>> >
>> > iommufd should do this, so long as the viommu object exists the tsm
>> > for it exists. It should not be inside tsm drivers.
>> >
>> 
>> That would expose more TSM details to iommufd. The reference must also
>> be acquired under pci_tsm_rwsem.
>
> That seems like overkill.
>
>> /* Pin the current TSM and revalidate the selected vIOMMU operations. */
>> struct tsm_dev * pci_tsm_viommu_get_tsm_dev(struct pci_dev *pdev,
>> 		enum iommu_viommu_type type,
>> 		const struct iommufd_viommu_ops *expected_ops)
>> {
>> 	const struct pci_tsm_ops *ops;
>> 	const struct iommufd_viommu_ops *viommu_ops;
>> 	struct tsm_dev *tsm_dev;
>> 	int ret = -ENODEV;
>> 
>> 	{
>> 		guard(rwsem_read)(&pci_tsm_rwsem);
>> 		if (!pdev->tsm)
>> 			return ERR_PTR(-ENODEV);
>> 		if (pdev->tsm->tsm_dev->unregistering)
>> 			return ERR_PTR(-ENODEV);
>> 		ops = to_pci_tsm_ops(pdev->tsm);
>> 		if (!ops->viommu_get_ops)
>> 			return ERR_PTR(-ENODEV);
>> 		tsm_dev = pdev->tsm->tsm_dev;
>> 		/* Unlike get_device(), this also keeps PCI/TSM resources active. */
>> 		if (!tsm_try_get(tsm_dev))
>> 			return ERR_PTR(-ENODEV);
>
> This is way too complicated for what should be a very simple scheme :(
>
> rcu_read_lock()
> tsm = rcu_derference(pdev->tsm);
> if (!tsm)
>    return NULL;
> /* Prevent the module from unloading which must be the only way to
>    trigger unregister */
> if (!try_module_get(tsm->ops->module))
>    return NULL;
> rcu_read_unlock()
>
> And this should be exposed to iommufd..
>
> viommu_create:
>  tsm = tsm_get_device(pdev)
>  tsm_get_viommu_ops(tsm,...)
>  [..]
>
> viommu_destroy:
>   tsm_put_device(tsm)
>
> No lock, no registering FSM, just RCU free the pdev->tsm memory and do
> that module unload rcu synchronize during module unload. No hand of of
> the lifecylce to other layers.
>
> Hold the module get in iommufd inside the iommufd viommu object.
>
> It is simple and easy to understand.
>


Switching pdev->tsm to an RCU-protected pointer requires broader changes
to the existing TSM code. To move this series forward, I will continue
protecting it with pci_tsm_rwsem in the next revision, as that requires
fewer changes. We can revisit an RCU conversion later if needed?

With this approach, viommu_alloc() will do:
	struct tsm_dev *tsm_dev = NULL;


	tsm_dev = tsm_get_device(idev->dev);
	ops = tsm_dev ? tsm_viommu_get_ops(tsm_dev, idev->dev, cmd->type) : NULL;
	if (!ops) {
                tsm_dev = NULL;
		ops = iommu_dev->ops->get_viommu_ops(idev->dev, cmd->type);
        }

	viommu = (struct iommufd_viommu *)_iommufd_object_alloc_ucmd(
	viommu->tsm_dev = tsm_dev;
	tsm_dev = NULL;

	rc = ops->viommu_init(viommu, idev->dev,....)

....
	if (tsm_dev)
		tsm_put_device(tsm_dev);


void iommufd_viommu_destroy(struct iommufd_object *obj)
{
..
	if (viommu->tsm_dev)
		tsm_put_device(viommu->tsm_dev);
...
}

struct tsm_dev *pci_tsm_get_device(struct pci_dev *pdev)
{
	const struct pci_tsm_ops *ops;
	struct tsm_dev *tsm_dev;

	guard(rwsem_read)(&pci_tsm_rwsem);
	if (!pdev->tsm)
		return NULL;

	tsm_dev = pdev->tsm->tsm_dev;

	ops = tsm_dev->pci_ops;
	if (!try_module_get(ops->owner)) // arm-cca-host
		return ERR_PTR(-ENODEV);
	if (!tsm_try_get(tsm_dev)) {
		module_put(ops->owner);
		return ERR_PTR(-ENODEV);
	}
	return tsm_dev;
}

>
>> 		viommu_ops = ops->viommu_get_ops(&pdev->dev, type);
>> 		if (viommu_ops == expected_ops)
>> 			return tsm_dev;
>> 		if (IS_ERR(viommu_ops))
>> 			ret = PTR_ERR(viommu_ops);
>> 	}
>
>
> This should just be try_module_get and a touch of RCU.
>
>> > ideally the module refcount handles this and the only way to trigger a
>> > tsm remove is through module unload, with no sysfs path?
>> 
>> I agree. The existing code takes extra care to allow tsm_unregister().
>> However, if unloading arm-cca-host.ko is the only way to trigger
>> unregistration, as it currently is, we can avoid this complexity.
>
> I've been badly traumitized by hot unplug races, bugs and deadlock,
> let's not introduce anything like this here, there is no need.
>

Are you suggesting setting suppress_bind_attrs = true for the
arm-cca-host driver?

The driver model otherwise allows the driver to be unbound. For example,
what happens when arm-rmi device is unbound from the arm-cca-host
driver? We need to support tsm_unregister() in that case. I am also not
sure whether there are other paths that can call tsm_unregister().
Currently, we register the cleanup callback via

	tsm_dev = tsm_register(&sdev->dev, &cca_link_pci_ops);

	ret = devm_add_action_or_reset(&sdev->dev, cca_link_tsm_remove, tsm_dev);
	if (ret)

-aneesh
