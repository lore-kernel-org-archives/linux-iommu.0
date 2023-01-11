Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7821A33D2
	for <iommu@lists.linux.dev>; Wed, 11 Jan 2023 18:23:52 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1673461430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0XdYOxf5IvaZ791CzYFKpi5kuwlt+Hcy+whwpGU2iKA=;
	b=Ae+LlW3Q3ok6fnWD1oXZO6e7mjhEwgy8OG8OT6aa6okKgmmZGi5m4/VhaY7q1wDQlaUQCy
	Sc8RUZgerGHje/p9jr/sAoCBMGiQqKM40DTMujxoL9JvCY9tcN6hFal+54kQYhxnMDFMfe
	f4vGHqHJrYNmbsQmxYrjZ5ixAJ9CDCOmfy2iJ7C99mZWpzwv3KgYq/1253iuh7s50W7z39
	HQVCbPOzkk0D5SjqY20anpfSoNVWK9qFZuE8YbIK8fwlZTxFWzptgKwJZQi+a9dc7lXm2e
	BBLcdtf9wjtjpeGqJxBDDTN3CseX4nfnOqUx+oeVTVMK9hM9IWqBuE6boNIyww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1673461430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0XdYOxf5IvaZ791CzYFKpi5kuwlt+Hcy+whwpGU2iKA=;
	b=0Czc8KM7MVVZOR6h6RaYKGhrxCjjedxX3menb6s4MyXluhbbb2RMzuDUcbd5TYOT18d/ra
	7PAmVwHPUc96CNAg==
To: Jason Gunthorpe <jgg@nvidia.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, Lu
 Baolu <baolu.lu@linux.intel.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, David
 Woodhouse <dwmw2@infradead.org>, Gerald Schaefer
 <gerald.schaefer@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Heiko
 Carstens <hca@linux.ibm.com>, iommu@lists.linux.dev, Joerg Roedel
 <joro@8bytes.org>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, Marc
 Zyngier <maz@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Suravee
 Suthikulpanit <suravee.suthikulpanit@amd.com>, Sven Schnelle
 <svens@linux.ibm.com>, Will Deacon <will@kernel.org>
Cc: Bharat Bhushan <bharat.bhushan@nxp.com>, Christian Borntraeger
 <borntraeger@de.ibm.com>, Eric Auger <eric.auger@redhat.com>, Eric Farman
 <farman@linux.ibm.com>, Kevin Tian <kevin.tian@intel.com>, Marc Zyngier
 <marc.zyngier@arm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, Tomasz
 Nowicki <tomasz.nowicki@caviumnetworks.com>, Will Deacon
 <will.deacon@arm.com>
Subject: Re: [PATCH iommufd v3 7/9] iommu/x86: Replace IOMMU_CAP_INTR_REMAP
 with IRQ_DOMAIN_FLAG_ISOLATED_MSI
In-Reply-To: <7-v3-3313bb5dd3a3+10f11-secure_msi_jgg@nvidia.com>
References: <7-v3-3313bb5dd3a3+10f11-secure_msi_jgg@nvidia.com>
Date: Wed, 11 Jan 2023 19:23:49 +0100
Message-ID: <875yddhqve.ffs@tglx>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jan 05 2023 at 15:33, Jason Gunthorpe wrote:
> On x86 platforms when the HW can support interrupt remapping the iommu
> driver creates an irq_domain for the IR hardware and creates a child MSI
> irq_domain.
>
> When the global irq_remapping_enabled is set, the IR MSI domain is
> assigned to the PCI devices (by intel_irq_remap_add_device(), or
> amd_iommu_set_pci_msi_domain()) making those devices have the isolated MSI
> property.
>
> Due to how interrupt domains work, setting IRQ_DOMAIN_FLAG_ISOLATED_MSI on
> the parent IR domain will cause all struct devices attached to it to
> return true from msi_device_has_isolated_msi(). This replaces the
> IOMMU_CAP_INTR_REMAP flag as all places using IOMMU_CAP_INTR_REMAP also
> call msi_device_has_isolated_msi()
>
> Set the flag and delete the cap.
>
> Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Acked-by: Thomas Gleixner <tglx@linutronix.de>
