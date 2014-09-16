From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC PATCH v3 0/7] Introduce automatic DMA configuration for
 IOMMU masters
Date: Tue, 16 Sep 2014 12:40:27 +0100
Message-ID: <541821AB.8040403@arm.com>
References: <1410539695-29128-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1410539695-29128-1-git-send-email-will.deacon@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Will Deacon <will.deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Cc: "jroedel@suse.de" <jroedel@suse.de>, "arnd@arndb.de" <arnd@arndb.de>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>, "Varun.Sethi@freescale.com" <Varun.Sethi@freescale.com>, "hdoyu@nvidia.com" <hdoyu@nvidia.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On 12/09/14 17:34, Will Deacon wrote:
> Hi all,
>
> Here is version three of the RFC I've previously posted here:
>
>    RFCv1: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-August/283023.html
>    RFCv2: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/283752.html
>
> Changes since RFCv2 include:
>
>    - Put the iommu_ops in iommu_data so of_iommu_configure can avoid using
>      the bus_type
>    - Initialise the offset and DMA masks on the dev in of_dma_configure
>      instead of in the arch callback (as this would cause a regression on
>      some architectures)
>    - Added deconfigure/teardown code based on ref counting the iommu_dma_mapping
>    - A bunch of small fixes (_OF_DECLARE,  some code shuffling, fix multiple
>      IOMMU parsing)
>
> All feedback welcome. Hopefully this is now at a point where people can
> start looking to port dma-mapping and/or IOMMU drivers to it.
>

What about AMBA devices? Playing with this on Juno and wondering why my 
PL330 doesn't get any of_xlate callbacks, I see that 
of_amba_device_create doesn't call of_dma_configure or anything from 
that path. It's easy to work around by removing the arm,primecell 
compatible, but that feels pretty dirty.

Robin.

> Cheers,
>
> Will
>
> --->8
>
> Will Deacon (7):
>    iommu: provide early initialisation hook for IOMMU drivers
>    dma-mapping: replace set_arch_dma_coherent_ops with arch_setup_dma_ops
>    iommu: add new iommu_ops callback for adding an OF device
>    iommu: provide helper function to configure an IOMMU for an of master
>    dma-mapping: detect and configure IOMMU in of_dma_configure
>    arm: call iommu_init before of_platform_populate
>    arm: dma-mapping: plumb our iommu mapping ops into arch_setup_dma_ops
>
>   arch/arm/include/asm/dma-mapping.h |  9 ++--
>   arch/arm/kernel/setup.c            |  2 +
>   arch/arm/mm/dma-mapping.c          | 68 ++++++++++++++++++++++++++----
>   drivers/iommu/Kconfig              |  2 +-
>   drivers/iommu/of_iommu.c           | 84 ++++++++++++++++++++++++++++++++++++++
>   drivers/of/platform.c              | 53 +++++++++++++-----------
>   include/asm-generic/vmlinux.lds.h  |  2 +
>   include/linux/dma-mapping.h        | 21 +++++++---
>   include/linux/iommu.h              | 15 +++++++
>   include/linux/of_iommu.h           | 35 ++++++++++++++++
>   10 files changed, 247 insertions(+), 44 deletions(-)
>
