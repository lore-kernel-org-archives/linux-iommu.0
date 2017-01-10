From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v7 19/19] iommu/arm-smmu: Do not advertise
 IOMMU_CAP_INTR_REMAP anymore
Date: Tue, 10 Jan 2017 14:17:48 +0000
Message-ID: <20170110141748.GD27365@arm.com>
References: <1483969570-3154-1-git-send-email-eric.auger@redhat.com>
 <1483969570-3154-20-git-send-email-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1483969570-3154-20-git-send-email-eric.auger@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, christoffer.dall@linaro.org, marc.zyngier@arm.com, robin.murphy@arm.com, alex.williamson@redhat.com, joro@8bytes.org, tglx@linutronix.de, jason@lakedaemon.net, linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, drjones@redhat.com, linux-kernel@vger.kernel.org, pranav.sawargaonkar@gmail.com, iommu@lists.linux-foundation.org, punit.agrawal@arm.com, diana.craciun@nxp.com, gpkulkarni@gmail.com, shankerd@codeaurora.org, bharat.bhushan@nxp.com, geethasowjanya.akula@gmail.com
List-Id: iommu@lists.linux-foundation.org

On Mon, Jan 09, 2017 at 01:46:10PM +0000, Eric Auger wrote:
> IOMMU_CAP_INTR_REMAP has been advertised in arm-smmu(-v3) although
> on ARM this property is not attached to the IOMMU but rather is
> implemented in the MSI controller (GICv3 ITS).
> 
> Now vfio_iommu_type1 checks MSI remapping capability at MSI controller
> level, let's correct this.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  drivers/iommu/arm-smmu-v3.c | 2 --
>  drivers/iommu/arm-smmu.c    | 2 --
>  2 files changed, 4 deletions(-)

Dependent on the previous two VFIO patches:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
