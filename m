From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2 02/10] iommu/ipmmu-vmsa: Cleanup failures of ARM mapping creation or attachment
Date: Wed, 18 Jun 2014 01:20:37 +0200
Message-ID: <5430380.Ocpv7sA44O@avalon>
References: <1400150451-13469-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <9405311.lnqBdrCsyu@avalon> <20140616151142.GE18986@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20140616151142.GE18986@8bytes.org>
Sender: linux-sh-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On Monday 16 June 2014 17:11:42 Joerg Roedel wrote:
> On Mon, May 26, 2014 at 12:08:37PM +0200, Laurent Pinchart wrote:
> > > Skipped this one because it didn't apply. The others are applied.
> > 
> > Thank you. I'll rebase the patch on top of your tree as soon as you
> > publish the related branch and resubmit.
> 
> What happened to this patch?

It looks like it slipped through the cracks :-/ Should I submit it as a fix 
for v3.16 or wait until v3.17 ?

> And how about the other iommu_domain changes requested. Will you submit them
> for 3.17?

I plan to work on that, but I'm not sure whether I'll be able to finish the 
work for v3.17, as I need to concentrate on a DMA engine driver right now, and 
will then need to finish the DT bindings for the IPMMU driver (which may 
result in fixes for some of the iommu_domain-related problems).

-- 
Regards,

Laurent Pinchart
