Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A4E33D2
	for <iommu@lists.linux.dev>; Wed, 11 Jan 2023 18:23:11 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1673461389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/vMqcs3d/mQXSbj2yIxtSqUpEXzHA4uoYUEBxosyu6A=;
	b=pIQg6pyY0w4XO9bR3CcnGPeNxLEQwXr4ATdOnewL1XufZswdlaNB1lX+AbKqpIKO096KRz
	kwkwNyDReRag2iZxJEYqBt2tQgC4hWu2mXJA8YDaj2hdW274/vZqkNf4JTPqzeCtyP/35P
	ImWjaqQNgB2l2P2/b/wEiovvdgAlJGMfFDKDN4mS2ZuS16OxPbb1euTx2ptE7KQC602Sc2
	3Nb3QC+yMaGb+90nl1RtbEG84uHfdXAxgOUFgFs3aqIZ8O6wiIcaoMU3lFGN9mrrblwr/J
	uNCXznRa0l6Glxuzs5i4l6T/oJgZc9uv4KL9/4jt3MwWbytk4+c6TqQHWBmmDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1673461389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/vMqcs3d/mQXSbj2yIxtSqUpEXzHA4uoYUEBxosyu6A=;
	b=u1oEAJ2Vkn4Rr+vY8LJ8BhU1HHgnxfpu5AoG7tZW6UaUez7wwrqIeoDg+4fWAj36ZmcHp6
	LKrS0zoKjBPZKYDQ==
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
Subject: Re: [PATCH iommufd v3 6/9] irq: Rename IRQ_DOMAIN_MSI_REMAP to
 IRQ_DOMAIN_ISOLATED_MSI
In-Reply-To: <6-v3-3313bb5dd3a3+10f11-secure_msi_jgg@nvidia.com>
References: <6-v3-3313bb5dd3a3+10f11-secure_msi_jgg@nvidia.com>
Date: Wed, 11 Jan 2023 19:23:08 +0100
Message-ID: <878ri9hqwj.ffs@tglx>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jan 05 2023 at 15:33, Jason Gunthorpe wrote:

Comment about prefix allplies here as well...

Other than that:

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
