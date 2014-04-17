From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH v3] iommu: Add driver for Renesas VMSA-compatible IPMMU
Date: Thu, 17 Apr 2014 12:14 +0200
Message-ID: <3961471.IYYJh47THK@avalon>
References: <1396435657-3922-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<69859225.EqNRcgoKS0@avalon> <20140409105703.GV13491@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140409105703.GV13491-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On Wednesday 09 April 2014 12:57:03 Joerg Roedel wrote:
> On Wed, Apr 09, 2014 at 12:43:57PM +0200, Laurent Pinchart wrote:
> > On Wednesday 02 April 2014 12:47:37 Laurent Pinchart wrote:
> > > Signed-off-by: Laurent Pinchart
> > > <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> > > ---
> > > 
> > >  drivers/iommu/Kconfig                    |   12 +
> > >  drivers/iommu/Makefile                   |    1 +
> > >  drivers/iommu/ipmmu-vmsa.c               | 1070 +++++++++++++++++++++++
> > >  include/linux/platform_data/ipmmu-vmsa.h |   24 +
> > >  4 files changed, 1107 insertions(+)
> > >  create mode 100644 drivers/iommu/ipmmu-vmsa.c
> > >  create mode 100644 include/linux/platform_data/ipmmu-vmsa.h
> > > 
> > > Joerg, could you please take this patch in your tree for v3.16 ?
> > 
> > Ping ?
> 
> I am looking into this when the merge window is over.

I think it's over now :-)

-- 
Regards,

Laurent Pinchart
