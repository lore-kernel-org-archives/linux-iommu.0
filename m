From: "Chalamarla, Tirumalesh" <Tirumalesh.Chalamarla@caviumnetworks.com>
Subject: RE: [RFC PATCH v6 04/20] iommu/arm-smmu: add capability
 IOMMU_CAP_INTR_REMAP
Date: Thu, 26 Jun 2014 18:15:37 +0000
Message-ID: <748dccbbd3284521af4659ccbbb11453@BY2PR07MB203.namprd07.prod.outlook.com>
References: <1401987808-23596-1-git-send-email-a.motakis@virtualopensystems.com>
 <1401987808-23596-5-git-send-email-a.motakis@virtualopensystems.com>
 <20140608103129.GC3279@lvm> <20140616145344.GD18986@8bytes.org>
 <20140616151329.GQ16758@arm.com> <20140616152157.GB31771@8bytes.org>
 <20140616152526.GR16758@arm.com> <20140616153832.GC31771@8bytes.org>
 <9353770066894e85809e1e443b71d1cd@BY2PR07MB203.namprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9353770066894e85809e1e443b71d1cd@BY2PR07MB203.namprd07.prod.outlook.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Chalamarla, Tirumalesh" <Tirumalesh.Chalamarla@caviumnetworks.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "stuart.yoder@freescale.com" <stuart.yoder@freescale.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "tech@virtualopensystems.com" <tech@virtualopensystems.com>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>, "moderated list:ARM SMMU DRIVER" <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

When I say emulating ITS, I mean translating guest ITS commands to physical ITS commands  and placing them in physical queue. 

Regards,
Tirumalesh.

-----Original Message-----
From: kvmarm-bounces@lists.cs.columbia.edu [mailto:kvmarm-bounces@lists.cs.columbia.edu] On Behalf Of Chalamarla, Tirumalesh
Sent: Thursday, June 26, 2014 11:08 AM
To: Joerg Roedel; Will Deacon
Cc: kvm@vger.kernel.org; open list; alex.williamson@redhat.com; stuart.yoder@freescale.com; iommu@lists.linux-foundation.org; tech@virtualopensystems.com; kvmarm@lists.cs.columbia.edu; moderated list:ARM SMMU DRIVER
Subject: RE: [RFC PATCH v6 04/20] iommu/arm-smmu: add capability IOMMU_CAP_INTR_REMAP

Forgive me if this discussion is not relative here, but I thought it is.  

How is VFIO restricting devices from writing  to MSI/MSI-X, Is all the vector area is mapped by VFIO to trap the accesses.  I am asking this because we might need to emulate ITS somewhere either in KVM or VFIO to provide direct access to devices.
And I don't see any mentions on that.   I think this flag needs to be set by ITS emulation.

Regards,
Tirumalesh.

-----Original Message-----
From: kvmarm-bounces@lists.cs.columbia.edu [mailto:kvmarm-bounces@lists.cs.columbia.edu] On Behalf Of Joerg Roedel
Sent: Monday, June 16, 2014 8:39 AM
To: Will Deacon
Cc: stuart.yoder@freescale.com; kvm@vger.kernel.org; open list; iommu@lists.linux-foundation.org; alex.williamson@redhat.com; moderated list:ARM SMMU DRIVER; tech@virtualopensystems.com; kvmarm@lists.cs.columbia.edu; Christoffer Dall
Subject: Re: [RFC PATCH v6 04/20] iommu/arm-smmu: add capability IOMMU_CAP_INTR_REMAP

On Mon, Jun 16, 2014 at 04:25:26PM +0100, Will Deacon wrote:
> Ok, thanks. In which case, I think this is really a combined property 
> of the SMMU and the interrupt controller, so we might need some extra 
> code so that the SMMU can check that the interrupt controller for the 
> device is also capable of interrupt remapping.

Right, that this is part of IOMMU code has more or less historic reasons on x86. Interrupt remapping is purely implemented in the IOMMU there, so on ARM some clue-code between interrupt controler and smmu is needed.


	Joerg


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
