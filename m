From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v6 6/8] dma-mapping: detect and configure IOMMU in
	of_dma_configure
Date: Wed, 17 Dec 2014 12:09:49 +0000
Message-ID: <20141217120948.GB870@arm.com>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
	<1612493.xCj1Tx0M4k@avalon> <20141215180933.GW20738@arm.com>
	<2447060.c0PHi7y3cP@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2447060.c0PHi7y3cP@wuerfel>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Dec 16, 2014 at 12:08:15PM +0000, Arnd Bergmann wrote:
> On Monday 15 December 2014 18:09:33 Will Deacon wrote:
> > > Using a single domain is a bit of a waste of resources in my case, so an 
> > > evolution would be to create four domains and assign devices to them based on 
> > > a policy. The policy could be fixed (round-robin for instance), or 
> > > configurable (possibly through DT, although it's really a policy, not a 
> > > hardware description).
> 
> I think in case of the ARM SMMU, we concluded that the grouping is indeed
> best done in DT, because of there is no good algorithmic way to come
> up with a set of bitmasks that make up a proper grouping into domains.

I think that's a slightly different case. The `grouping' in the DT, is on a
per-master basis where a master may have a set of StreamIDs, which can be
expressed in a more efficient (per-IOMMU) manner that cannot easily be
determined at runtime.

For iommu_group creation, that could be done in the of code by treating the
master IDs as bus IDs on a per-IOMMU bus; when a new device is probed, we
can look at the set of devices with intersecting IDs and create a group
containing those. This is similar to walking a PCI topology to establish DMA
aliases.

The problem with all of this is how we distinguish the different ID formats
in the `iommus' device-tree property. For the ARM SMMU, we could have:

  (1) [easy case] A device has a list of StreamIDs

  (2) A device has a list of SMR mask/value pairs

  (3) A (bus) device has a range translation for a downstream bus (e.g.
      a PCI host controller which needs to convert RequesterID to StreamID).

>From the SMMU driver's perspective, they will all look like of_xlate calls
unless we augment the generic IOMMU bindings with extra properties to
identify the format. It also makes it difficult to pick a sensible value for
#iommu-cells, as it depends on the format.

Will
