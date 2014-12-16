From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v6 6/8] dma-mapping: detect and configure IOMMU in
	of_dma_configure
Date: Tue, 16 Dec 2014 13:08:15 +0100
Message-ID: <2447060.c0PHi7y3cP@wuerfel>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
	<1612493.xCj1Tx0M4k@avalon> <20141215180933.GW20738@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20141215180933.GW20738-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Monday 15 December 2014 18:09:33 Will Deacon wrote:
> > Using a single domain is a bit of a waste of resources in my case, so an 
> > evolution would be to create four domains and assign devices to them based on 
> > a policy. The policy could be fixed (round-robin for instance), or 
> > configurable (possibly through DT, although it's really a policy, not a 
> > hardware description).

I think in case of the ARM SMMU, we concluded that the grouping is indeed
best done in DT, because of there is no good algorithmic way to come
up with a set of bitmasks that make up a proper grouping into domains.
 
> I think having one default domain, which is home to all of the masters that
> don't have any DMA restrictions is a good use of the hardware. That then
> leaves you with three domains to cover VFIO, devices with DMA limitations
> and potentially device isolation (if we had a way to describe that).

Yes, I agree. There are also a number of degrees to which one might want
to enable IOMMUs at boot time:

- force-disable: use swiotlb only and turn off all IOMMUs or program them
  with a static linear mapping if they cannot be disabled in hardware
- soft-enable: use IOMMUs only for devices whose dma-mask does not cover
  all the physical memory. This would provide the highest performance
- force-enable: use the IOMMU for any device that has an 'iommus' property,
  to catch any wild DMA pointer accesses.
- secure-enable: like force-enable, but use as many separate domains as
  possible to provide isolation between devices as well.

	Arnd
