From: Scott Wood <scottwood@freescale.com>
Subject: Re: [RFC][PATCH 0/3] iommu/fsl: Freescale PAMU driver and IOMMU API
 implementation.
Date: Wed, 19 Sep 2012 19:14:02 -0500
Message-ID: <1348100042.22800.22@snotra>
References: <A6B66C5D-71EA-4E9F-8347-7413479BD3FC@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <A6B66C5D-71EA-4E9F-8347-7413479BD3FC@kernel.crashing.org>
	(from galak@kernel.crashing.org on Wed Sep 19 08:49:14 2012)
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Kumar Gala <galak@kernel.crashing.org>
Cc: "<b16395@freescale.com>" <b16395@freescale.com>, joerg.roedel@amd.com, iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Varun Sethi <Varun.Sethi@freescale.com>
List-Id: iommu@lists.linux-foundation.org

On 09/19/2012 08:49:14 AM, Kumar Gala wrote:
> 
> On Sep 19, 2012, at 8:17 AM, <b16395@freescale.com>  
> <b16395@freescale.com> wrote:
> 
> > From: Varun Sethi <Varun.Sethi@freescale.com>
> >
> > This patchset provides the Freescale PAMU (Peripheral Access  
> Management Unit) driver
> > and the corresponding IOMMU API implementation. PAMU is the IOMMU  
> present on Freescale
> > QorIQ platforms. PAMU can authorize memory access, remap the memory  
> address, and remap
> > the I/O transaction type.
> >
> > This set consists of the following patches:
> > 1. Addition of new field in the device (powerpc) archdata structure  
> for storing iommu domain information
> >   pointer. This pointer is stored when the device is attached to a  
> particular iommu domain.
> > 2. Addition of domain attributes required by the PAMU driver IOMMU  
> API.
> > 3. PAMU driver and IOMMU API implementation.
> >
> > Varun Sethi (3):
> >  Store iommu domain information pointer in archdata.
> >  Add iommu domain attributes required by fsl PAMU driver.
> >  FSL PAMU driver and IOMMU API implementation.
> >
> > arch/powerpc/include/asm/device.h |    4 +
> > drivers/iommu/Kconfig             |    7 +
> > drivers/iommu/Makefile            |    1 +
> > drivers/iommu/fsl_pamu.c          | 1033  
> +++++++++++++++++++++++++++++++++++++
> > drivers/iommu/fsl_pamu.h          |  377 ++++++++++++++
> > drivers/iommu/fsl_pamu_domain.c   |  990  
> +++++++++++++++++++++++++++++++++++
> > drivers/iommu/fsl_pamu_domain.h   |   94 ++++
> > drivers/iommu/fsl_pamu_proto.h    |   49 ++
> > include/linux/iommu.h             |   30 ++
> > 9 files changed, 2585 insertions(+), 0 deletions(-)
> > create mode 100644 drivers/iommu/fsl_pamu.c
> > create mode 100644 drivers/iommu/fsl_pamu.h
> > create mode 100644 drivers/iommu/fsl_pamu_domain.c
> > create mode 100644 drivers/iommu/fsl_pamu_domain.h
> > create mode 100644 drivers/iommu/fsl_pamu_proto.h
> 
> I assume that another patch series will add device tree binding spec  
> and update device trees for SoCs with PAMU?

The device trees already have PAMU in them.  A binding would be nice,  
though.

-Scott
