From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: PCI warning on boot 3.8.0-rc1
Date: Mon, 04 Feb 2013 13:36:04 -0700
Message-ID: <1360010164.11144.542.camel@bling.home>
References: <20130116143853.339dd89b@nehalam.linuxnetplumber.net>
	<CAErSpo5eOE_=Ob2jN7ACy0eJBOa8k36XqCbHnGTCs-wfiy8tiw@mail.gmail.com>
	<20130204103645.38ae2d5e@nehalam.linuxnetplumber.net>
	<1360009684.11144.539.camel@bling.home>
	<20130204123041.31e402df@nehalam.linuxnetplumber.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20130204123041.31e402df-We1ePj4FEcvRI77zikRAJc56i+j3xesD0e7PPNI6Mm0@public.gmane.org>
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

On Mon, 2013-02-04 at 12:30 -0800, Stephen Hemminger wrote:
> On Mon, 04 Feb 2013 13:28:04 -0700
> Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> 
> > On Mon, 2013-02-04 at 10:36 -0800, Stephen Hemminger wrote:
> > > > I think drivers/pci/search.c is identical between 3.7 and 3.8-rc1.  Is
> > > > this the first time you've turned on the IOMMU on that box?
> > > 
> > > It exists in 3.7 and earlier kernels, just haven't turned on same config.
> > > 
> > > > It's the same warning as in this bugzilla:
> > > > https://bugzilla.kernel.org/show_bug.cgi?id=44881, and there's a patch
> > > > there at https://bugzilla.kernel.org/show_bug.cgi?id=44881#c11, but
> > > > it's just a quirk that turns off VT-d if we find certain broken
> > > > bridges.  It doesn't look like you have any of those (although I don't
> > > > know what you have at 05:00.0).
> > > > 
> > > > Bjorn
> > > 
> > > This is a standard ASUS motherboard, and don't want to disable VT-d.
> > 
> > Stephen,
> > 
> > Can you give the lspci -vvv of device 5:00.0 to see if it's one we've
> > seen before?  Does the patch below help?
> 
> 
> $ sudo lspci -vvv -s 5:00.0
> 05:00.0 PCI bridge: ASMedia Technology Inc. ASM1083/1085 PCIe to PCI Bridge (rev 03) (prog-if 01 [Subtractive decode])

Someone has even decided to name this one a PCIe-to-PCI bridge despite
it lacking a PCIe capability.  Thanks,

Alex

> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Bus: primary=05, secondary=06, subordinate=06, sec-latency=32
> 	I/O behind bridge: 0000f000-00000fff
> 	Memory behind bridge: fff00000-000fffff
> 	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
> 	Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
> 	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
> 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> 	Capabilities: [c0] Subsystem: ASUSTeK Computer Inc. Device 8489
> 
> 
> > Bjorn, I think we need to quirk it somehow.  So far they've all been
> > PCI-to-PCI bridges attached to root ports where we expect it's actually
> > a PCIe-to-PCI bridge.  Seems like maybe we could have the same attached
> > to a downstream port.  The patch below avoids the WARN and gives us a
> > device, but of course pci_is_pcie reports wrong for this device and may
> > cause some trickle down breakage.  A more complete option might be to
> > add a is_pcie flag to the device that can be set independent of
> > pcie_cap.  We'd need to check all the callers for assumptions, but then
> > we could put the quirk in one place and hopefully fix everything.
> > Thoughts?  Thanks,
> > 
> > Alex
> > 
> > 
> > diff --git a/drivers/pci/search.c b/drivers/pci/search.c
> > index bf969ba..65ae270 100644
> > --- a/drivers/pci/search.c
> > +++ b/drivers/pci/search.c
> > @@ -42,6 +42,15 @@ pci_find_upstream_pcie_bridge(struct pci_dev *pdev)
> >  		}
> >  		/* PCI device should connect to a PCIe bridge */
> >  		if (pci_pcie_type(pdev) != PCI_EXP_TYPE_PCI_BRIDGE) {
> > +			/*
> > +			 * Not all PCIe-to-PCI bridges expose a PCIe
> > +			 * capability.  If we make it to a PCIe root port
> > +			 * and the previous device was a PCI-to-PCI bridge,
> > +			 * assume it was really a PCIe-to-PCI bridge.
> > +			 */
> > +			if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT &&
> > +			    tmp && tmp->hdr_type == PCI_HEADER_TYPE_BRIDGE)
> > +				return tmp;
> >  			/* Busted hardware? */
> >  			WARN_ON_ONCE(1);
> >  			return NULL;
> > 
> > 
> 
