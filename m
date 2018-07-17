From: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: usb HC busted?
Date: Tue, 17 Jul 2018 17:52:59 +0200
Message-ID: <20180717155259.GB2416@kroah.com>
References: <20180717120411.GB28592@kroah.com>
	<Pine.LNX.4.44L0.1807171029310.1689-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1807171029310.1689-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Mathias Nyman <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Mathias Nyman <mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, lukaszx.szulc-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jul 17, 2018 at 10:31:38AM -0400, Alan Stern wrote:
> On Tue, 17 Jul 2018, Greg KH wrote:
> 
> > > From: Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > > Date: Tue, 10 Jul 2018 09:50:00 +0100
> > > Subject: [PATCH] hacky solution to mem-corruption
> > > 
> > > Signed-off-by: Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > > ---
> > >  drivers/usb/core/message.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
> > > index 7cd4ec33dbf4..7fdf7a27611d 100644
> > > --- a/drivers/usb/core/message.c
> > > +++ b/drivers/usb/core/message.c
> > > @@ -1398,7 +1398,8 @@ int usb_set_interface(struct usb_device *dev, int interface, int alternate)
> > >  		remove_intf_ep_devs(iface);
> > >  		usb_remove_sysfs_intf_files(iface);
> > >  	}
> > > -	usb_disable_interface(dev, iface, true);
> > > +	if (!(iface->cur_altsetting && alt))
> > > +		usb_disable_interface(dev, iface, true);
> > 
> > 
> > 
> > This feels like a "correct" patch anyway, why would a driver keep
> > calling set_interface to an interface that it was already set to?
> > 
> > But can't we check for this higher up in the function?  This hack will
> > just not disable an interface but it will do all of the other stuff
> > being asked for.  Does the patch below also solve this for you?  It's
> > not a good solution of course, but it might work around the problem a
> > bit better.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> > diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
> > index 1a15392326fc..0f718f1a1ca3 100644
> > --- a/drivers/usb/core/message.c
> > +++ b/drivers/usb/core/message.c
> > @@ -1376,6 +1376,14 @@ int usb_set_interface(struct usb_device *dev, int interface, int alternate)
> >  		return -EINVAL;
> >  	}
> >  
> > +	if (iface->cur_altsetting == alt) {
> > +		/*
> > +		 * foolish bluetooth stack, don't try to set a setting you are
> > +		 * already set to...
> > +		 */
> > +		return 0;
> > +	}
> > +
> >  	/* Make sure we have enough bandwidth for this alternate interface.
> >  	 * Remove the current alt setting and add the new alt setting.
> >  	 */
> 
> No, neither of these is right.  It's possible to use 
> usb_set_interface() as a kind of "soft" reset.  Even when the new 
> altsetting is specified to be the same as the current one, we still 
> have to tell the lower-layer drivers and hardware about it.

You are right, it's a hacky soft reset, I was just trying to figure out
what the bluetooth driver was trying to do.  I wouldn't expect it to be
calling that function a lot, but I guess it does :(

thanks,

greg k-h
