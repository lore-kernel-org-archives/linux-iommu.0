From: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH 1/2] debugfs: Allow debugfs_create_dir() to take data
Date: Wed, 15 Aug 2012 06:40:15 -0700
Message-ID: <20120815134015.GA22202@kroah.com>
References: <1344407073-12030-1-git-send-email-hdoyu@nvidia.com>
	<1344407073-12030-2-git-send-email-hdoyu@nvidia.com>
	<20120808133427.GA14417@kroah.com>
	<20120809155624.b781edae9efa7c51faf6c31c@nvidia.com>
	<20120815084008.3d8f4ac20af5dc3372cd7681@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120815084008.3d8f4ac20af5dc3372cd7681-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Aug 15, 2012 at 08:40:08AM +0300, Hiroshi Doyu wrote:
> On Thu, 9 Aug 2012 14:56:24 +0200
> Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> 
> > Hi Greg, Felipe,
> > 
> > On Wed, 8 Aug 2012 15:34:27 +0200
> > Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org> wrote:
> > 
> > > On Wed, Aug 08, 2012 at 09:24:32AM +0300, Hiroshi Doyu wrote:
> > > > Add __debugfs_create_dir(), which takes data passed from caller.
> > > 
> > > Why?
> > > 
> > > > Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > > > ---
> > > >  fs/debugfs/inode.c      |    7 ++++---
> > > >  include/linux/debugfs.h |    9 ++++++++-
> > > >  2 files changed, 12 insertions(+), 4 deletions(-)
> > .....
> > > What are you trying to do here?  This patch doesn't look right at all.
> > 
> > I missed to send the cover letter of this patch series to LKML, which
> > explained the background. I attached that cover letter below. Please
> > read the following explanation too.
> 
> Any chance to get some feedback on this?

I still don't like it, and then there's the basic fact that I'm pretty
sure you broke the build with the patch, but who's noticing little
things like that :)

> I'm also sending another version of patch, which just uses
> debgufs_create_dir() as Felipe suggested, in-reply-to this mail.

I'd prefer not to change debugfs for this, so if you don't do that, I
don't object to your driver-specific patch.

greg k-h
