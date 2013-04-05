From: Scott Wood <scottwood@freescale.com>
Subject: Re: RFC: vfio API changes needed for powerpc (v3)
Date: Fri, 5 Apr 2013 17:17:25 -0500
Message-ID: <1365200245.17535.13@snotra>
References: <9F6FE96B71CF29479FF1CDC8046E15035A29FB@039-SN1MPN1-003.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Content-Transfer-Encoding: 8BIT
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <9F6FE96B71CF29479FF1CDC8046E15035A29FB@039-SN1MPN1-003.039d.mgd.msft.net>
	(from B08248@freescale.com on Thu Apr  4 17:10:27 2013)
Content-Disposition: inline
Sender: kvm-owner@vger.kernel.org
To: Yoder Stuart-B08248 <B08248@freescale.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Wood Scott-B07421 <B07421@freescale.com>, "agraf@suse.de" <agraf@suse.de>, Bhushan Bharat-R65777 <R65777@freescale.com>, Sethi Varun-B16395 <B16395@freescale.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org

On 04/04/2013 05:10:27 PM, Yoder Stuart-B08248 wrote:
> /*
>  * VFIO_IOMMU_PAMU_UNMAP_MSI_BANK
>  *
>  * Unmaps the MSI bank at the specified iova.
>  * Caller provides struct vfio_pamu_msi_bank_unmap with all fields  
> set.
>  * Operates on VFIO file descriptor (/dev/vfio/vfio).
>  * Return: 0 on success, -errno on failure
>  */
> 
> struct vfio_pamu_msi_bank_unmap {
>         __u32   argsz;
>         __u32   flags;     /* no flags currently */
>         __u64   iova;      /* the iova to be unmapped to */
> };
> #define VFIO_IOMMU_PAMU_UNMAP_MSI_BANK  _IO(VFIO_TYPE, VFIO_BASE + x,
>         struct vfio_pamu_msi_bank_unmap )

What happens if a normal unmap call is done on the MSI iova?  Do we  
need a separate unmap?

-Scott
