From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: PCI warning on boot 3.8.0-rc1
Date: Wed, 06 Feb 2013 08:58:41 -0700
Message-ID: <1360166321.11144.638.camel@bling.home>
References: <20130116143853.339dd89b@nehalam.linuxnetplumber.net>
	<CAErSpo5eOE_=Ob2jN7ACy0eJBOa8k36XqCbHnGTCs-wfiy8tiw@mail.gmail.com>
	<20130204103645.38ae2d5e@nehalam.linuxnetplumber.net>
	<1360009684.11144.539.camel@bling.home>
	<1360017684.11144.547.camel@bling.home>
	<20130206074900.02f04e3f@nehalam.linuxnetplumber.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20130206074900.02f04e3f-We1ePj4FEcvRI77zikRAJc56i+j3xesD0e7PPNI6Mm0@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Stephen Hemminger <stephen-OTpzqLSitTUnbdJkjeBofR2eb7JE58TQ@public.gmane.org>
Cc: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, 2013-02-06 at 07:49 -0800, Stephen Hemminger wrote:
> On Mon, 04 Feb 2013 15:41:24 -0700
> Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> 
> > On Mon, 2013-02-04 at 13:28 -0700, Alex Williamson wrote:
> > > On Mon, 2013-02-04 at 10:36 -0800, Stephen Hemminger wrote:
> > > > > I think drivers/pci/search.c is identical between 3.7 and 3.8-rc1.  Is
> > > > > this the first time you've turned on the IOMMU on that box?
> > > > 
> > > > It exists in 3.7 and earlier kernels, just haven't turned on same config.
> > > > 
> > > > > It's the same warning as in this bugzilla:
> > > > > https://bugzilla.kernel.org/show_bug.cgi?id=44881, and there's a patch
> > > > > there at https://bugzilla.kernel.org/show_bug.cgi?id=44881#c11, but
> > > > > it's just a quirk that turns off VT-d if we find certain broken
> > > > > bridges.  It doesn't look like you have any of those (although I don't
> > > > > know what you have at 05:00.0).
> > > > > 
> > > > > Bjorn
> > > > 
> > > > This is a standard ASUS motherboard, and don't want to disable VT-d.
> > > 
> > > Stephen,
> > > 
> > > Can you give the lspci -vvv of device 5:00.0 to see if it's one we've
> > > seen before?  Does the patch below help?
> > > 
> > > Bjorn, I think we need to quirk it somehow.  So far they've all been
> > > PCI-to-PCI bridges attached to root ports where we expect it's actually
> > > a PCIe-to-PCI bridge.  Seems like maybe we could have the same attached
> > > to a downstream port.  The patch below avoids the WARN and gives us a
> > > device, but of course pci_is_pcie reports wrong for this device and may
> > > cause some trickle down breakage.  A more complete option might be to
> > > add a is_pcie flag to the device that can be set independent of
> > > pcie_cap.  We'd need to check all the callers for assumptions, but then
> > > we could put the quirk in one place and hopefully fix everything.
> > > Thoughts?  Thanks,
> > 
> > This latter approach seems like it might be easier than I expected since
> > all the users are so well filtered through the access functions.  A
> > quick look through who uses pci_is_pcie seems like this might be
> > complete, but more eyes are required.  I'll upload this to the bz for
> > those reporters to test as well.  Thoughts?  Thanks,
> > 
> > Alex
> 
> On my hardware this gives:

> [    0.254621] pci_bus 0000:05: busn_res: can not insert [bus 05-ff] under [bus 00-3e] (conflicts with (null) [bus 00-3e])
> [    0.254647] WARNING: Your hardware is broken, device (null) appears to be a
> [    0.254647]  Legacy PCI device attached directly to a PCIe device which is not a
> [    0.254647]  PCIe-to-PCI bridge.  Per section 7.8 of the PCI Express 3.0 spec, the
> [    0.254647]  PCI express capability structure is required for PCI express device
> [    0.254647] functions.
> [    0.254653] pci 0000:05:00.0: [1b21:1080] type 01 class 0x060401

I guess I must be calling pci_name() before it's set.  The warning
message needs some work too, it's mainly meant for hardware vendors with
the hope that they might test Linux and see it before shipping these
broken devices.  Bjorn, does this approach seem worth pursuing?  Thanks,

Alex
