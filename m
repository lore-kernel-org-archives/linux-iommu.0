From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2] PCI: Reset PCIe devices to stop ongoing DMA
Date: Thu, 01 Aug 2013 06:42:14 -0600
Message-ID: <1375360934.31262.156.camel@ul30vt.home>
References: <1368509365-2260-1-git-send-email-indou.takao@jp.fujitsu.com>
	<51F85BCC.2070103@jp.fujitsu.com>
	<CAErSpo4yJ2yqCWv7GT7jWSVd_8SktU=xJXT78m8Vxp_wLA4Fow@mail.gmail.com>
	<1699397.FXoFYIGzbk@vostro.rjw.lan> <51FA015E.10901@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <51FA015E.10901-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Takao Indoh <indou.takao-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org, hbabu-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, bill.sumner-VXdhtT5mjnY@public.gmane.org, ishii.hironobu-+CUm20s59erQFUHtdCDX3A@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, 2013-08-01 at 15:34 +0900, Takao Indoh wrote:
> (2013/08/01 6:23), Rafael J. Wysocki wrote:
> > On Wednesday, July 31, 2013 03:08:03 PM Bjorn Helgaas wrote:
> >> [+cc Rafael, linux-acpi]
> >>
> >> On Tue, Jul 30, 2013 at 6:35 PM, Takao Indoh <indou.takao-+CUm20s59erQFUHtdCDX3A@public.gmane.org> wrote:
> >>
> >>> On x86, currently IOMMU initialization run *after* PCI enumeration, but
> >>> what you are talking about is that it should be changed so that x86
> >>> IOMMU initialization is done *before* PCI enumeration like sparc, right?
> >>
> >> Yes.  I don't know whether or when that initialization order will ever
> >> be changed, but I do think we should avoid building more
> >> infrastructure that depends on the current order.
> >>
> >> Changing the order is a pretty big deal because it's a lot more than
> >> just the IOMMU.  Basically I think we should be enumerating ACPI
> >> devices, including the IOMMU, before PCI devices, but there's a lot of
> >> legacy involved in that area.  Added Rafael in case he has any
> >> thoughts.
> > 
> > Well, actually, I'm not really familiar with IOMMUs, sorry.
> > 
> > I do think that initializing IOMMU before PCI enumeration would be better,
> > however.  At least if the ordering should be the same on all architectures,
> > which I suppose is the case, that's the one I'd choose.
> 
> Ok guys. If x86 IOMMU maintainer also thinks changing order is
> necessary, maybe I need to give up device reset in kdump kernel and
> consider doing it in panic kernel.
> 
> Either way, I need bus reset interface to reset devices. Bjorn, could
> you review the bus reset patches Alex posted yesterday?

I'll post a non-RFC version today, I've made a couple cleanups, tuned
the delays and rolled in the AER version of secondary bus reset.
Thanks,

Alex
