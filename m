From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v3] iommu: Add driver for Renesas VMSA-compatible IPMMU
Date: Wed, 9 Apr 2014 12:57:03 +0200
Message-ID: <20140409105703.GV13491@8bytes.org>
References: <1396435657-3922-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <69859225.EqNRcgoKS0@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <69859225.EqNRcgoKS0@avalon>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: iommu@lists.linux-foundation.org, linux-sh@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Laurent,

On Wed, Apr 09, 2014 at 12:43:57PM +0200, Laurent Pinchart wrote:
> On Wednesday 02 April 2014 12:47:37 Laurent Pinchart wrote:
> > Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> >  drivers/iommu/Kconfig                    |   12 +
> >  drivers/iommu/Makefile                   |    1 +
> >  drivers/iommu/ipmmu-vmsa.c               | 1070 +++++++++++++++++++++++++++
> >  include/linux/platform_data/ipmmu-vmsa.h |   24 +
> >  4 files changed, 1107 insertions(+)
> >  create mode 100644 drivers/iommu/ipmmu-vmsa.c
> >  create mode 100644 include/linux/platform_data/ipmmu-vmsa.h
> > 
> > Joerg, could you please take this patch in your tree for v3.16 ?
> 
> Ping ?

I am looking into this when the merge window is over.


	Joerg


