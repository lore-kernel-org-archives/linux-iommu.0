From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: Reparenting a platform device
Date: Fri, 06 Apr 2012 10:37:31 -0600
Message-ID: <4F7F1BCB.7070608@wwwdotorg.org>
References: <20120405084258.GA19798@avionic-0098.adnet.avionic-design.de>
	<4F7DBCEE.9080400@wwwdotorg.org>
	<20120405162318.GA10628@avionic-0098.adnet.avionic-design.de>
	<20120405180805.GB11601@avionic-0098.adnet.avionic-design.de>
	<4F7DF0B3.4050500@wwwdotorg.org>
	<20120406072014.GA14250@avionic-0098.mockup.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20120406072014.GA14250-RM9K5IK7kjIQXX3q8xo1gnVAuStQJXxyR5q1nwbD4aMs9pC9oP6+/A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 04/06/2012 01:20 AM, Thierry Reding wrote:
> * Stephen Warren wrote:
>> I must admit I'm not at all familiar with the IOMMU APIs, but isn't the
>> IOMMU driver/subsystem itself what is managing all the allocations and
>> handing them out to clients? And client drivers do things like asking
>> for N pages of memory mapped into their aperture? If that is true, I'm
>> not sure what the purpose is of the intermediate device you propose.
>> Sorry for being somewhat clueless.
> 
> That was my impression too at first. But it seems like all the IOMMU
> subsystem does is map individual pages. So you pass it a physical address of
> a page along with the IO virtual address to map it to. That's at least the
> way it is handled for Tegra 2 GART (and from a quick look also by the Tegra 3
> SMMU). For the SMMU the situation may be different because it may not have a
> fixed aperture that needs to contain the IO virtual addresses, though I must
> admit I haven't looked at Tegra 3 in enough detail to judge this.
> 
> So this intermediate device would be purely an allocator for the GART
> aperture and handle the actual mapping via the IOMMU. This would probably be
> really simple and is in fact now done in the DRM driver. The nice thing if
> this would be a separate device is that it would be easy to make it a child
> of the IOMMU and wouldn't be as counter-intuitive as making the DRM device
> the IOMMU's child.

OK, I see.

I'll defer to Hiroshi here; he's far more familiar with all this than I am.

My only comment is that I'd be surprised to see any kind of memory
allocator represented as a driver (as opposed to a utility module) since
it's not really representing an actual hardware block.
