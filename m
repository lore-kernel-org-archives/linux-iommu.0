From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Request VFIO inclusion in linux-next
Date: Sun, 01 Jul 2012 22:14:20 -0600
Message-ID: <1341202460.1207.384.camel@bling.home>
References: <1340686552.1207.128.camel@bling.home>
	<20120627123733.GA5449@mwanda> <4FF11855.2060605@ozlabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <4FF11855.2060605-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alexey Kardashevskiy <aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org>
Cc: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, kvm <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, qemu-devel <qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org>, chrisw <chrisw-69jw2NvuJkxg9hUCZPvPmw@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, linux-next-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, David Gibson <david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, 2012-07-02 at 13:41 +1000, Alexey Kardashevskiy wrote:
> On 27/06/12 22:37, Dan Carpenter wrote:
> > On Mon, Jun 25, 2012 at 10:55:52PM -0600, Alex Williamson wrote:
> >> Hi,
> >>
> >> VFIO has been kicking around for well over a year now and has been
> >> posted numerous times for review.  The pre-requirements are finally
> >> available in linux-next (or will be in the 20120626 build) so I'd like
> >> to request a new branch be included in linux-next with a goal of being
> >> accepted into v3.6.
> >>
> > 
> > Could you run Sparse over the driver?
> > http://lwn.net/Articles/205624/
> > 
> > It reports a bunch of endian problems.  Some are definitely bugs
> > like:
> > 	*prev |= cpu_to_le32((u32)epos << 20);
> 
> 
> What is wrong here?

I believe the only thing wrong here was that prev was a u32* instead of
a __le32*.  The new version in my tree has much better endian annotation
after going through all the sparse errors.  The only bug I found in the
cleanup was the handling of rbar.  It was missing the le32_to_cpu as we
copied it out of vconfig.  This is later used with
pci_user_write_config_dword, so it needs to be in native endian.
Thanks,

Alex
