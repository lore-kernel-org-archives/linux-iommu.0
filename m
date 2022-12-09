Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6646FAB
	for <iommu@lists.linux.dev>; Fri,  9 Dec 2022 19:57:36 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1670615854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=80wTTdM3lWcQJcmXIfadK+PcvLcT1z5Yu3sjTQP3wro=;
	b=PqNkUG89F3vCH15uy5iNjLuBHtcX3sfE/pjRJ9C/TgXJRN/AKDG/8pWBgISSFr27lms3Zm
	wB0CYXx3CMO5B2cYP3Q6MxdqQpK7loHrVXkHpW7WcCt4Ibj0qaUahi/RMdXEgn2r+pdSNo
	G/FtW8teP0I8/hjBj5wIRfJIwJHwmdOCW2bLHfzzfPsC9ow765s+tHqpGUcZ8DLPK1IOl3
	moRKoh7Dms8fotzAQ/cVNuDqogMERKCTUJBGKGN+qLu65ExqCV56l6uGBJM2vadBWNTt/r
	+qKsznycSuLUtlAK0m12CHOUcj12hWpp76jw2YK7N5VjDEwKImu/M3/Eo8rs0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1670615854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=80wTTdM3lWcQJcmXIfadK+PcvLcT1z5Yu3sjTQP3wro=;
	b=hgUyw/HxZZ/4scm8iv4e1ZlYgKcOJe1h6eX0PMNhCiABfbaJd6oft4r8ZUir7YwKdWDVwP
	/ZtoHr4L1LzA34BQ==
To: Jason Gunthorpe <jgg@nvidia.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, Lu
 Baolu <baolu.lu@linux.intel.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, David
 Woodhouse <dwmw2@infradead.org>, Gerald Schaefer
 <gerald.schaefer@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Heiko
 Carstens <hca@linux.ibm.com>, iommu@lists.linux.dev, Joerg Roedel
 <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
 linux-s390@vger.kernel.org, Marc Zyngier <maz@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, Suravee Suthikulpanit
 <suravee.suthikulpanit@amd.com>, Sven Schnelle <svens@linux.ibm.com>, Will
 Deacon <will@kernel.org>
Cc: Bharat Bhushan <bharat.bhushan@nxp.com>, Christian Borntraeger
 <borntraeger@de.ibm.com>, Eric Auger <eric.auger@redhat.com>, Eric Farman
 <farman@linux.ibm.com>, Marc Zyngier <marc.zyngier@arm.com>, Matthew
 Rosato <mjrosato@linux.ibm.com>, Tomasz Nowicki
 <tomasz.nowicki@caviumnetworks.com>, Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH iommufd 0/9] Remove IOMMU_CAP_INTR_REMAP
In-Reply-To: <0-v1-9e466539c244+47b5-secure_msi_jgg@nvidia.com>
References: <0-v1-9e466539c244+47b5-secure_msi_jgg@nvidia.com>
Date: Fri, 09 Dec 2022 20:57:33 +0100
Message-ID: <87cz8scpua.ffs@tglx>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Dec 08 2022 at 16:26, Jason Gunthorpe wrote:
> [ This would be for v6.3, the series depends on a bunch of stuff in
> linux-next. I would be happy to merge it through the iommfd tree ]

I'll have a look next week.
