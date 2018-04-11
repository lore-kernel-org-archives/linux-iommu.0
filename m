From: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [VERY RFC 0/2] iommu: optionally skip attaching to a DMA domain
Date: Wed, 11 Apr 2018 19:32:55 -0400
Message-ID: <CAF6AEGvVRPzGO00UqyiD2vBwZn4kDdr8rnBf2Tr4ypS0pRpHLQ@mail.gmail.com>
References: <20180411185510.11594-1-jcrouse@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180411185510.11594-1-jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: freedreno <freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "list-Y9sIeH5OGRo@public.gmane.org:IOMMU DRIVERS <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>,
	Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, " <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 11, 2018 at 2:55 PM, Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
> I've been struggling with a problem for a while and I haven't been able to come
> up with a clean solution. Rob convinced me to stop complaining and do
> _something_ and hopefully this can spur a good discussion.
>
> The scenario is basically this: The MSM GPU wants to manage its own IOMMU
> virtual address space in lieu of using the DMA API to do so. The most important
> reason is that when per-instance pagetables [1] are enabled each file descriptor
> uses its own pagetable which are dynamically switched between contexts. In
> conjunction with this we use a split pagetable scheme to allow global buffers
> be persistently mapped so even a single pagetable has multiple ranges that need
> to be utilized based on buffer type.
>
> Obviously the DMA API isn't suitable for this kind of specialized use. We want
> to push it off to the side, allocate our own domain, and use it directly with
> the IOMMU APIs. In a perfect world we would just not use the DMA API and attach
> our own domain and that would be the end of the story. Unfortunately this is not
> a perfect world.
>
> In order to switch the pagetable from the GPU the SoC has some special wiring so
> that the GPU can reprogram the TTBR0 register in the IOMMU to the appropriate
> value. For a variety of reasons the hardware is hardcoded to only be able to
> access context bank 0 in the SMMU device. Long story short; if the DMA
> domain is allocated during bus enumeration and attached to context bank 0 then
> by the time we get to the driver domain we have long since lost our chance to
> get the context bank we need.
>
> After going back and forth and trying a few possible options it seems like the
> "easiest" solution" is to skip attaching the DMA domain in the first place. But
> we still need to create a default domain and set up the IOMMU groups correctly
> so that when the GPU driver comes along it can attach the device and everything
> will Just Work (TM). Rob suggested that we should use a blacklist of devices
> that choose to not participate so thats what I'm offering as a starting point
> for discussion.

in an ideal world, the dma-mapping layer magic would not be forced on
a driver, but would be an opt-in thing (ie. driver's ->probe() calls
dma_setup_magic_iommu_stuff(dev)), and becomes more of a helper layer
that drivers could opt-in to.. but that changes how things work
significantly at iommu probe time and probably touches a lot of
drivers.  A property in dt would be the easy down-stream solution, but
this is mostly about the driver (but also about how the firmware
works, so maybe dt is not out of bounds?).  The black-list approach is
fairly simple, although maybe a bit of a point-solution.  (Although
the number of drivers this problem applies to might not be much
greater than 1.)

So short version, very interested if anyone has better suggestions.
Because we really need to do *something* here.

BR,
-R

> The first patch in this series allows the specific IOMMU driver to gracefully
> skip attaching a device by returning -ENOSUPP. In that case, the core will
> skip printing error messages and it won't attach the domain to the group but
> it still allows the group to get created so that the IOMMU device is properly
> set up. In arch_setup_dma_ops() the call to iommu_get_domain_for_dev() will
> return NULL and the IOMMU ops won't be set up.
>
> The second patch implements the blacklist in arm-smmu.c based on the compatible
> string of the GPU device and returns -ENOTSUPP.
>
> I tested this with my current per-instance pagetable stack and it does the job
> but I am very much in the market for better ideas.
>
> [1] https://patchwork.freedesktop.org/series/38729/
>
> Jordan Crouse (2):
>   iommu: Gracefully allow drivers to not attach to a default domain
>   iommu/arm-smmu: Add list of devices to opt out of DMA domains
>
>  drivers/iommu/arm-smmu.c | 23 +++++++++++++++++++++++
>  drivers/iommu/iommu.c    | 18 ++++++++++++++----
>  2 files changed, 37 insertions(+), 4 deletions(-)
>
> --
> 2.16.1
>
