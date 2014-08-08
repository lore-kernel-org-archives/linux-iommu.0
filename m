From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v4 1/1] iommu-api: Add map_sg/unmap_sg functions
Date: Fri, 8 Aug 2014 13:14:02 -0400
Message-ID: <20140808171402.GF13551@laptop.dumpdata.com>
References: <1406854484-3848-1-git-send-email-ohaugan@codeaurora.org>
 <1406854484-3848-2-git-send-email-ohaugan@codeaurora.org>
 <20140805151323.GB19709@laptop.dumpdata.com>
 <53E26127.1040805@codeaurora.org>
 <20140806201740.GW9809@8bytes.org>
 <53E2BA2D.1050007@codeaurora.org>
 <20140807062410.GC17340@ulmo>
 <53E3F538.8030000@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <53E3F538.8030000@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Olav Haugan <ohaugan@codeaurora.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Joerg Roedel <joro@8bytes.org>, linux-arm-msm@vger.kernel.org, will.deacon@arm.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Aug 07, 2014 at 02:52:56PM -0700, Olav Haugan wrote:
> On 8/6/2014 11:24 PM, Thierry Reding wrote:
> > On Wed, Aug 06, 2014 at 04:28:45PM -0700, Olav Haugan wrote:
> >> On 8/6/2014 1:17 PM, Joerg Roedel wrote:
> >>> On Wed, Aug 06, 2014 at 10:08:55AM -0700, Olav Haugan wrote:
> >>>> so you are suggesting that I check in "bus_set_iommu()" whether the
> >>>> driver has set the map_sg/unmap_sg function pointers or not and if not
> >>>> set it to the default? Is bus_set_iommu() the only way drivers can set
> >>>> up the callbacks?
> >>>
> >>> This doesn't work as the iommu_ops are now const. You have to either
> >>> update the iommu drivers individually to point to the default function,
> >>> or you do the check in the API function itself and fall back to the
> >>> default it no call-back is provided.
> >>>
> >>
> >> Ok, then I think it is better to just leave the fallback where it is now
> >> in the function itself.
> > 
> > What Konrad was suggesting is what I also proposed. The idea is to
> > implement a fallback as standalone function, then make all drivers use
> > that by default in the struct iommu_ops that they register. When drivers
> > implement an optimized version they can simply replace the fallback
> > implementation with their own.
> > 
> 
> Ok, I can do that. I misunderstood the point of the fallback. I thought
> the point of the fallback was to catch drivers that forget/neglect to
> implement this callback. If that is not a concern I will update my patch

Nah. We want those drivers to crash and burn so we can see that and
fix it. And by fix I meant it would just point do:

	.map_sg = generic_map_sg,
	.unmap_sg = generic_unmap_sg,

In other words, none of the function ops will have an NULL functions.

> to create a separate function that I will point all existing drivers to.

Excellent!
> 
> Thanks,
> 
> Olav
> 
> -- 
> The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> hosted by The Linux Foundation
