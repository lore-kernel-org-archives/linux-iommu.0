From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: Request VFIO inclusion in linux-next
Date: Thu, 28 Jun 2012 09:44:08 +0300
Message-ID: <20120628064408.GJ3007@mwanda>
References: <1340686552.1207.128.camel@bling.home>
	<20120627123733.GA5449@mwanda>
	<1340825003.1207.224.camel@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1340825003.1207.224.camel-xdHQ/5r00wBBDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, kvm <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alexey Kardashevskiy <aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, qemu-devel <qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org>, chrisw <chrisw-69jw2NvuJkxg9hUCZPvPmw@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, linux-next-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, David Gibson <david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jun 27, 2012 at 01:23:23PM -0600, Alex Williamson wrote:
> On Wed, 2012-06-27 at 15:37 +0300, Dan Carpenter wrote:
> > On Mon, Jun 25, 2012 at 10:55:52PM -0600, Alex Williamson wrote:
> > > Hi,
> > > 
> > > VFIO has been kicking around for well over a year now and has been
> > > posted numerous times for review.  The pre-requirements are finally
> > > available in linux-next (or will be in the 20120626 build) so I'd like
> > > to request a new branch be included in linux-next with a goal of being
> > > accepted into v3.6.
> > > 
> > 
> > Could you run Sparse over the driver?
> > http://lwn.net/Articles/205624/
> > 
> > It reports a bunch of endian problems.  Some are definitely bugs
> > like:
> > 	*prev |= cpu_to_le32((u32)epos << 20);
> 
> Done.  Mostly just adding annotation, but it did find a bug or two.
> Should be cleaned up in tomorrow's next.  Thanks for the report,
> 

Cool.  I have some Smatch fixes as well.  I've updated them to apply
on top of today's linux-next.

regards,
dan carpenter
