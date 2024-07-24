Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9B51C6A3;
	Wed, 24 Jul 2024 10:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721816664; cv=none; b=fBpFyMpIwWYHLo0s8rYgSFwaCjd0x3tju4LGXKLs0M30MntOE/Kwxz71nLnwpzOer1i5fdI1/FFutGj9bfT2T8reSCptcKNrx9biMP+W3FajA9fYLmXr7hWjYnmgpxnWqAQNA4u6aW1nbWxVFCJIzEvNSfz9MwVSOMe9fPD3Fmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721816664; c=relaxed/simple;
	bh=NdEEtdlxWrWnmoVV10NEbeNlCaWT4HNKyf37IWm1m+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cbR4DhjpYPesBFtcDImLe4BM45QdLo4dyfi9vF/co70AS0lu5t7S4z+p98QXjYo2iQYZBgGb5dZofizM0hj0ee7SeVQYbyl1wC5fhrXKb4W6eogw9FNfGzW+49SeJCyylH4MZJZU9hSi57+Dz7JVcF/UUXIxJ4gsjT4Lw6lS63Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmq2g8uO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmq2g8uO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626CFC32782;
	Wed, 24 Jul 2024 10:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721816663;
	bh=NdEEtdlxWrWnmoVV10NEbeNlCaWT4HNKyf37IWm1m+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nmq2g8uOfnIvrbYY7kQAg0Nz2aHK2rTNJMzROzdO9Aj3fGX9shcMNtaNWfM2Sl4WE
	 vJeuNdtOqqJ01JEfMaSWPACKnji1OLT6pztto+TGnrEMi+tg8Cw3i1qfGp6A2koI4b
	 ZE62Ht9q/Wk7jpxAwn9yuNOjw+Kx/h4uIJZc4UeX90RYI0GUzj8Hm6TsKiVjMJK60j
	 3sY3EDBUz/OzZL8tH3BbhC7LLGMnCbttJ+edtJ30g2njJtxiMq3du9VLFi1Otii8YJ
	 O1L/eqmTd8SB4OyagE3uYBJ7NsNeWTKKjNdVIRJeAOJAtwd5XUvJdBZ1nCKrX5lAuU
	 dyrk+nIkVCPag==
Date: Wed, 24 Jul 2024 11:24:17 +0100
From: Will Deacon <will@kernel.org>
To: Kunkun Jiang <jiangkunkun@huawei.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>,
	Michael Shavit <mshavit@google.com>,
	Mostafa Saleh <smostafa@google.com>,
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	wanghaibin.wang@huawei.com, yuzenghui@huawei.com,
	tangnianyao@huawei.com
Subject: Re: [bug report] iommu/arm-smmu-v3: Event cannot be printed in some
 scenarios
Message-ID: <20240724102417.GA27376@willie-the-truck>
References: <6147caf0-b9a0-30ca-795e-a1aa502a5c51@huawei.com>
 <7d5a8b86-6f0d-50ef-1b2f-9907e447c9fc@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d5a8b86-6f0d-50ef-1b2f-9907e447c9fc@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Jul 24, 2024 at 05:22:59PM +0800, Kunkun Jiang wrote:
> On 2024/7/24 9:42, Kunkun Jiang wrote:
> > drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > 1797                 while (!queue_remove_raw(q, evt)) {
> > 1798                         u8 id = FIELD_GET(EVTQ_0_ID, evt[0]);
> > 1799
> > 1800                         ret = arm_smmu_handle_evt(smmu, evt);
> > 1801                         if (!ret || !__ratelimit(&rs))
> > 1802                                 continue;
> > 1803
> > 1804                         dev_info(smmu->dev, "event 0x%02x
> > received:\n", id);
> > 1805                         for (i = 0; i < ARRAY_SIZE(evt); ++i)
> > 1806                                 dev_info(smmu->dev, "\t0x%016llx\n",
> > 1807                                          (unsigned long
> > long)evt[i]);
> > 1808
> > 1809                         cond_resched();
> > 1810                 }
> > 
> > The smmu-v3 driver cannot print event information when "ret" is 0.
> > Unfortunately due to commit 3dfa64aecbaf
> > ("iommu: Make iommu_report_device_fault() return void"), the default
> > return value in arm_smmu_handle_evt() is 0. Maybe a trace should
> > be added here?
> 
> Additional explanation. Background introduction:
> 1.A device(VF) is passthrough(VFIO-PCI) to a VM.
> 2.The SMMU has the stall feature.
> 3.Modified guest device driver to generate an event.
> 
> This event handling process is as follows:
> arm_smmu_evtq_thread
>     ret = arm_smmu_handle_evt
>         iommu_report_device_fault
>             iopf_param = iopf_get_dev_fault_param(dev);
>             // iopf is not enabled.
> // No RESUME will be sent!
>             if (WARN_ON(!iopf_param))
>                 return;
>     if (!ret || !__ratelimit(&rs))
>         continue;
> 
> In this scenario, the io page-fault capability is not enabled.
> There are two problems here:
> 1. The event information is not printed.
> 2. The entire device(PF level) is stalled,not just the current
> VF. This affects other normal VFs.

Oh, so that stall is probably also due to b554e396e51c ("iommu: Make
iopf_group_response() return void"). I agree that we need a way to
propagate error handling back to the driver in the case that
'iopf_param' is NULL, otherwise we're making the unexpected fault
considerably more problematic than it needs to be.

Lu -- can we add the -ENODEV return back in the case that
iommu_report_device_fault() doesn't even find a 'iommu_fault_param' for
the device?

Will
