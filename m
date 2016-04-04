From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 6/6] iommu/arm-smmu: Make use of phandle iterators in
 device-tree parsing
Date: Mon, 4 Apr 2016 16:24:10 +0200
Message-ID: <20160404142410.GG24141@suse.de>
References: <1458669509-7178-1-git-send-email-joro@8bytes.org>
 <1458669509-7178-7-git-send-email-joro@8bytes.org>
 <20160329172216.GM6745@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160329172216.GM6745@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, grant.likely@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On Tue, Mar 29, 2016 at 06:22:16PM +0100, Will Deacon wrote:
> > +
> > +	if (i == 0)
> > +		goto out_put_masters;
> 
> I'm confused by this hunk. If i == 0, then we shouldn't have registered
> any masters and therefore out_put_masters won't have anything to do.

The idea was that there is nothing more to do in the function when it
didn't find any masters and so it can safely skip the rest of the
function.

But the original code doesn't do this either, so it certainly doesn't
belong into this patch. I remove it for the next post.

> In fact, I'm not completely clear on how the of_node refcounting interacts
> with your iterators. Does the iterator put the node after you call the
> "next" function, or does it increment each thing exactly once?

The iterator will put the current node at the following _next call, so
when you want to use each node, you need your own reference.

It works like the pci_dev iterators, so if you break out of the loop you
have to manually put the last node it returned.


	Joerg
