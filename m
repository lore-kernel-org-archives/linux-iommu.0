Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B1633D2
	for <iommu@lists.linux.dev>; Wed, 11 Jan 2023 18:22:07 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1673461325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jxIOvx/FOCrvFSWu5Y1mdP4fKAkQqLE1G0W7dNcBaVE=;
	b=tFTGDfgJ9VfFpcWmk4eIX3n8W5MJiSRlNfaUZbeot2kdGccBKC9BCfKn8bLoHX36YwGHjh
	D3zj8bnRuJ/Si4rujs7Zt88o4RNqyt0NUZkzQ3KsGZrPMHS8w5Lai2yJC9jxNi81fo1Q++
	Ydn2oOb+PzHgOeIUzbtOjcl6M7qFCUqZqjWa4QBa7YU6wiP86ri3UZ6Ai1efJO79j6T9qz
	z+TBMVlZHh1cwBMWzjBmGEnxmTm/AS2Ux+EiabpUR91W7qq4ECv6dLHaqxl0UNhnqNKbq3
	j+/ZEOs+eIOW2K68+EAJV6YXdD/CuIXTe8UIavoG/hRacktU4bjXzQ0cMBShgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1673461325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jxIOvx/FOCrvFSWu5Y1mdP4fKAkQqLE1G0W7dNcBaVE=;
	b=a3HiVVOcV1Onqj6bTQon3HiFaq5CKrJFRoRLQHmrHQwjYlib3nw36Pp4wjMnnn0kI9MLiW
	PKFpJ6qzEb62pvAA==
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
Subject: Re: [PATCH iommufd v3 5/9] irq: Remove unused
 irq_domain_check_msi_remap() code
In-Reply-To: <5-v3-3313bb5dd3a3+10f11-secure_msi_jgg@nvidia.com>
References: <5-v3-3313bb5dd3a3+10f11-secure_msi_jgg@nvidia.com>
Date: Wed, 11 Jan 2023 19:22:05 +0100
Message-ID: <87bkn5hqya.ffs@tglx>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jan 05 2023 at 15:33, Jason Gunthorpe wrote:

Prefix: genirq/irqdomain:

git log --online $FILEPATH gives you usually a pretty good hint for the prefix.

Other than that:

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
