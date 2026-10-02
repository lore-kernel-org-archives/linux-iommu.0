Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5BA35C6B9;
	Fri,  2 Oct 2026 06:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790921667; cv=none; b=or7wjLRyHOLcTGZugm6u4QqZc8ZD1rzv0Z76Q2Abby5mNB+0wUM4GZyW4PMaMOp9bt8lkJVHGne+EcfXU1pLJdcdEew13WNsWQbnD4nuaq2jTJQlnu60jlydsLi7frrs5kUZT7oBcnuOwLWWr+g/zgZxKdCafl9w8ZbNjj3sGSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790921667; c=relaxed/simple;
	bh=QtN08qlYa49HWuHjUTay01+VAY+sfXTWjLheWdF6L/M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eZXbF1JL5K9yjHvYTs22EHalLhQR4aejfQAcCPg5iOnkUU9iqgq1HcRymf3pZESM1qb6CmrQzrjtib7b4r4g1AhkjVeC4jTEo67RedkkwQjMYlrKRN7ycgbeYQF5D0jL7un0qUlThAIwyHnC4WN9s1zBzeYVm3jtTGhSW+QtL2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e84Fpx2K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e84Fpx2K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31CD31F00898;
	Fri,  2 Oct 2026 06:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790921665;
	bh=bc/twVVXjEu8LvGY2cDqMCBOR2omKMTiiungucTb/r4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=e84Fpx2K7LDcWwK09R8hq/rEbdyXYgQVMY5e9qzplkIMYlzy/sa5mAR5PwNMvcNc8
	 yygJN47QDo27ci7Bjhnv0MZtCaAg1EswLprrAIUSztZCGIxw1XuZtecZ8VlqMvE9Un
	 21vPVreXOhzdKu1Wo65iRU5u9e2AVx2iozRG1udbNqZ/bzl5BGjqAIImLMnodVCjSh
	 mxcK8NCyqBMXYS4YO3mRf3heEhQRRrbJuh/fxcIAy+dF29T+7zFOq7g3iIYQ6DiBHj
	 cSZKd4/TOFl6lY1qyrsgVowg8P2L2Bv8UfFF4bCBnRu7b5eWQMjIgYkk3US45dZAeH
	 yTe5WrNtyrR2A==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Sonang Patel <sonangp@nvidia.com>
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
Subject: Re: [RFC PATCH v6 11/11] PCI/TSM: Add reference-counted contexts
 for vdevice providers
In-Reply-To: <20260928230834.GL163130@ziepe.ca>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
 <20260917140159.1163281-12-aneesh.kumar@kernel.org>
 <arq2Ql3-q9EApe3X@sonangrm.nvidia.com> <20260928230834.GL163130@ziepe.ca>
Date: Fri, 02 Oct 2026 11:44:15 +0530
Message-ID: <yq5av77ktyrs.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Tue, Sep 29, 2026 at 12:17:30AM +0530, Sonang Patel wrote:
>> On Thu, 17 Sep 2026 19:31:59 +0530, Aneesh Kumar K.V (Arm) wrote:
>> > +		if (is_pci_tsm_pf0(pdev)) {
>> > +			if (pci_tsm_disconnect(pdev))
>> > +				pci_warn(pdev, "TSM connection is still in use\n");
>> > +		} else {
>> > +			tsm_remove(pdev->tsm);
>> > +		}
>> 
>> What happens if the PCI device is removed (e.g. sysfs remove, surprise
>> hot-unplug) while the vDEVICE/TDI still exists?
>> Since removal cannot be refused, should the remove path still force
>> the unbind/unlock?
>
> vfio prevents that. It currently will block the sysfs remove until
> vfio is closed.
>


This came up during a Codex review of my patch set. The question is what
happens if function 1 is assigned to the guest and function 0 is then
removed through sysfs. Is that allowed? If so, it could be a problem
because function 1 is not unbound and can continue to be used, while
removing function 0 tears down DOE and IDE via:

	pci_doe_destroy(dev);
	pci_ide_destroy(dev);


>
> If we ever decide to fix that then vfio would have to tear down the
> iommufd vdevice before allowing itself to be destroyed.
>
> We don't need any lifetime nonsense once we are inside an iommufd
> context, its existing locking scheme is very strong already. tsm
> should not be allowed to change while a driver is bound, and basically
> I shouldn't see any refcounting or locking in any of these paths
> stemming from a bound driver context in iommufd.
>

-aneesh
