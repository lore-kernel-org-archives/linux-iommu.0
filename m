From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: usb HC busted?
Date: Thu, 19 Jul 2018 10:57:12 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1807191046180.1308-100000@iolanthe.rowland.org>
References: <f7801c24-fa98-6338-0b26-33a0ac9498bb@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <f7801c24-fa98-6338-0b26-33a0ac9498bb-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
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

On Thu, 19 Jul 2018, Mathias Nyman wrote:

> xhci driver will set up all the endpoints for the new altsetting already in
> usb_hcd_alloc_bandwidth().
> 
> New endpoints will be ready and rings running after this. I don't know the exact
> history behind this, but I assume it is because xhci does all of the steps to
> drop/add, disable/enable endpoints and check bandwidth in a single configure
> endpoint command, that will return errors if there is not enough bandwidth.

That's right; Sarah and I spent some time going over this while she was 
working on it.  But it looks like the approach isn't adequate.

> This command is issued in hcd->driver->check_bandwidth()
> This means that xhci doesn't really do much in hcd->driver->endpoint_disable or
> hcd->driver->endpoint_enable
> 
> It also means that xhci driver assumes rings are empty when
> hcd->driver->check_bandwidth is called. It will bluntly free dropped rings.
> If there are URBs left on a endpoint ring that was dropped+added
> (freed+reallocated) then those URBs will contain pointers to freed ring,
> causing issues when usb_hcd_flush_endpoint() cancels those URBs.
> 
> usb_set_interface()
>    usb_hcd_alloc_bandwidth()
>      hcd->driver->drop_endpoint()
>      hcd->driver->add_endpoint() // allocates new rings
>      hcd->driver->check_bandwidth() // issues configure endpoint command, free rings.
>    usb_disable_interface(iface, true)
>      usb_disable_endpoint()
>        usb_hcd_flush_endpoint() // will access freed ring if URBs found!!
>        usb_hcd_disable_endpoint()
>          hcd->driver->endpoint_disable()  // xhci does nothing
>    usb_enable_interface(iface, true)
>      usb_enable_endpoint(ep_addrss, true) // not really doing much on xhci side.
> 
> As first aid I could try to implement checks that make sure the flushed URBs
> trb pointers really are on the current endpoint ring, and also add some warning
> if we are we are dropping endpoints with URBs still queued.
> 
> But we need to fix this properly as well.
> xhci needs to be more in sync with usb core in usb_set_interface(), currently xhci
> has the altssetting up and running when usb core hasn't event started flushing endpoints.

Absolutely.  The core tries to be compatible with host controller
drivers that either allocate bandwidth as it is requested or else
allocate bandwidth all at once when an altsetting is installed.  

xhci-hcd falls into the second category.  However, this approach
requires the bandwidth verification for the new altsetting to be
performed before the old altsetting has been disabled, and the xHCI
hardware can't do this.

We may need to change the core so that the old endpoints are disabled 
before the bandwidth check is done, instead of after.  Of course, this 
leads to an awkward situation if the check fails -- we'd probably have 
to go back and re-install the old altsetting.

Alan Stern
