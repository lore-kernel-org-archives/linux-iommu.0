From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: usb HC busted?
Date: Fri, 20 Jul 2018 10:09:25 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1807201006580.1512-100000@iolanthe.rowland.org>
References: <f8cfa055-cfd8-db66-a386-72bf904e17cd@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <f8cfa055-cfd8-db66-a386-72bf904e17cd-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Mathias Nyman <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Mathias Nyman <mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, lukaszx.szulc-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, 20 Jul 2018, Mathias Nyman wrote:

> >> But we need to fix this properly as well.
> >> xhci needs to be more in sync with usb core in usb_set_interface(), currently xhci
> >> has the altssetting up and running when usb core hasn't event started flushing endpoints.
> > 
> > Absolutely.  The core tries to be compatible with host controller
> > drivers that either allocate bandwidth as it is requested or else
> > allocate bandwidth all at once when an altsetting is installed.
> > 
> > xhci-hcd falls into the second category.  However, this approach
> > requires the bandwidth verification for the new altsetting to be
> > performed before the old altsetting has been disabled, and the xHCI
> > hardware can't do this.
> > 
> > We may need to change the core so that the old endpoints are disabled
> > before the bandwidth check is done, instead of after.  Of course, this
> > leads to an awkward situation if the check fails -- we'd probably have
> > to go back and re-install the old altsetting.
> 
> That would help xhci a lot.
> 
> If we want to avoid the awkward altsetting re-install after bandwidth failure
> then adding a extra endpoint flush before checking the bandwidth would already help a lot.
> 
> The endpoint disabling can then be remain after bandwidth checking.
> Does that work for other host controllers?

As far as I know, the other host controller drivers don't really care 
how this is done.  xHCI is the only technology where the hardware has 
to verify the bandwidth requirements.  (Maybe some other SuperSpeed 
controller design also cares, but if so then this change is unlikely to 
hurt.)

Alan Stern
