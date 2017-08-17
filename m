From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 06/13] drm/etnaviv: Use sychronized interface of the
 IOMMU-API
Date: Thu, 17 Aug 2017 16:03:54 +0200
Message-ID: <1502978634.19806.27.camel@pengutronix.de>
References: <1502974596-23835-1-git-send-email-joro@8bytes.org>
         <1502974596-23835-7-git-send-email-joro@8bytes.org>
         <1502976758.19806.25.camel@pengutronix.de> <20170817134539.GJ2853@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170817134539.GJ2853@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <jroedel@suse.de>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Russell King <linux+etnaviv@armlinux.org.uk>, Christian Gmeiner <christian.gmeiner@gmail.com>, David Airlie <airlied@linux.ie>, etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: iommu@lists.linux-foundation.org

Am Donnerstag, den 17.08.2017, 15:45 +0200 schrieb Joerg Roedel:
> Hi Lucas,
> 
> On Thu, Aug 17, 2017 at 03:32:38PM +0200, Lucas Stach wrote:
> > I don't think this is necessary. Etnaviv has managed and batched up TLB
> > flushes from day 1, as they don't happen through the MMU MMIO interface,
> > but through the GPU command stream.
> > 
> > So if my understanding of this series is correct, Etnaviv is just fine
> > with the changed semantics of the unsynchronized map/unmap calls.
> 
> This is not about any TLB on the GPU that could be flushed through the
> GPU command stream, but about the TLB in the IOMMU device. Or is this
> actually the same on this hardware? Which IOMMU-driver is use there?

There is no IOMMU driver in use. Etnaviv just uses part of the IOMMU API
to manage the GPU internal MMU, see
drivers/gpu/drm/etnaviv/etnaviv_iommu.c

Regards,
Lucas
