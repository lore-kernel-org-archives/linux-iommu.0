From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v6 0/3] arm64: IOMMU-backed DMA mapping
Date: Tue, 13 Oct 2015 13:12:46 +0100
Message-ID: <561CF53E.7000809@arm.com>
References: <cover.1443718557.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1443718557.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On 01/10/15 20:13, Robin Murphy wrote:
> Hi all,
>
> Here's the latest, and hopefully last, revision of the initial arm64
> IOMMU dma_ops support.
>
> There are a couple of dependencies still currently in -next and the
> intel-iommu tree[0]: "iommu: iova: Move iova cache management to the
> iova library" is necessary for the rename of iova_cache_get(), and
> "iommu/iova: Avoid over-allocating when size-aligned" will be needed
> with some IOMMU drivers to prevent unmapping errors.
>
> Changes from v5[1]:
> - Change __iommu_dma_unmap() from BUG to WARN when things go wrong, and
>    prevent a NULL dereference on double-free.
> - Fix iommu_dma_map_sg() to ensure segments can never inadvertently end
>    mapped across a segment boundary. As a result, we have to lose the
>    segment-merging optimisation from before (I might revisit that if
>    there's some evidence it's really worthwhile, though).
> - Cleaned up the platform device workarounds for config order and
>    default domains, and removed the other hacks. Demanding that the IOMMU
>    drivers assign groups, and support IOMMU_DOMAIN_DMA via the methods
>    provided, keeps things bearable, and the behaviour should now be
>    consistent across all cases.

I realise there was one other point you raised which I never explicitly 
addressed (I had to go off and do some investigation at the time) - the 
domain detach/free in arch_teardown_dma_ops does currently get called if 
the client device driver fails it probe (or asks to defer). This 
prevents us leaking any of our own domains we had to create, and lets us 
start from a clean slate if the device gets re-probed later.

Anyway, what are your thoughts on taking this for 4.4? Since the 
dependencies are now in and we're at -rc5 already, I'm on the verge of 
reposting a self-contained version to go through arm64, as we really 
need to unblock all the follow-on development there (it's a shame that 
of the people I'm aware want this, it's only me and the Mediatek/Chrome 
guys here on the list saying so).

Yes, there's still plenty more to do in the OF/device layer for platform 
device infrastructure as a whole (I hope my last reply[0] helped explain 
why it has to look so upside-down compared to the nice simple x86 PCI 
model), but I can only do it one chunk at a time ;)

Thanks,
Robin.

[0]:http://article.gmane.org/gmane.linux.kernel.iommu/10607

> As a bonus, whilst the underlying of_iommu_configure() code only supports
> platform devices at the moment, I can also say that this has now been
> tested to work for PCI devices too, via some horrible hacks on a Juno r1.
>
> Thanks,
> Robin.
>
> [0]:http://thread.gmane.org/gmane.linux.kernel.iommu/11033
> [1]:http://thread.gmane.org/gmane.linux.kernel.iommu/10439
>
> Robin Murphy (3):
>    iommu: Implement common IOMMU ops for DMA mapping
>    arm64: Add IOMMU dma_ops
>    arm64: Hook up IOMMU dma_ops
>
>   arch/arm64/Kconfig                   |   1 +
>   arch/arm64/include/asm/dma-mapping.h |  15 +-
>   arch/arm64/mm/dma-mapping.c          | 457 ++++++++++++++++++++++++++++++
>   drivers/iommu/Kconfig                |   7 +
>   drivers/iommu/Makefile               |   1 +
>   drivers/iommu/dma-iommu.c            | 524 +++++++++++++++++++++++++++++++++++
>   include/linux/dma-iommu.h            |  85 ++++++
>   include/linux/iommu.h                |   1 +
>   8 files changed, 1083 insertions(+), 8 deletions(-)
>   create mode 100644 drivers/iommu/dma-iommu.c
>   create mode 100644 include/linux/dma-iommu.h
>
