From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v3] iommu: Add driver for Renesas VMSA-compatible IPMMU
Date: Fri, 02 May 2014 21:46:41 +0200
Message-ID: <4429714.XiPXBbktvU@avalon>
References: <1396435657-3922-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <20140409105703.GV13491@8bytes.org> <3961471.IYYJh47THK@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <3961471.IYYJh47THK@avalon>
Sender: linux-sh-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-sh@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On Thursday 17 April 2014 12:14:00 Laurent Pinchart wrote:
> On Wednesday 09 April 2014 12:57:03 Joerg Roedel wrote:
> > On Wed, Apr 09, 2014 at 12:43:57PM +0200, Laurent Pinchart wrote:
> > > On Wednesday 02 April 2014 12:47:37 Laurent Pinchart wrote:
> > > > Signed-off-by: Laurent Pinchart
> > > > <laurent.pinchart+renesas@ideasonboard.com>
> > > > ---
> > > > 
> > > >  drivers/iommu/Kconfig                    |   12 +
> > > >  drivers/iommu/Makefile                   |    1 +
> > > >  drivers/iommu/ipmmu-vmsa.c               | 1070 +++++++++++++++++++++
> > > >  include/linux/platform_data/ipmmu-vmsa.h |   24 +
> > > >  4 files changed, 1107 insertions(+)
> > > >  create mode 100644 drivers/iommu/ipmmu-vmsa.c
> > > >  create mode 100644 include/linux/platform_data/ipmmu-vmsa.h
> > > > 
> > > > Joerg, could you please take this patch in your tree for v3.16 ?
> > > 
> > > Ping ?
> > 
> > I am looking into this when the merge window is over.
> 
> I think it's over now :-)

Ping ?

-- 
Regards,

Laurent Pinchart

