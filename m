From: =?iso-8859-1?Q?Beno=EEt?= Canet <benoit.canet-J9ArbTHlV+bR7s880joybQ@public.gmane.org>
Subject: Re: [Qemu-devel] SR-IOV PF reset and QEMU VFs VFIO passthrough
Date: Tue, 4 Jun 2013 17:54:22 +0200
Message-ID: <20130604155422.GB5991@irqsave.net>
References: <20130601121320.GC5157@irqsave.net> <51ACE340.1030406@redhat.com>
	<20130603192958.GB31044@irqsave.net> <51AD02B1.8070503@redhat.com>
	<20130603212723.GG4094@irqsave.net> <51AD0DB8.8090109@redhat.com>
	<20130603215855.GC31044@irqsave.net> <51AD12AB.1000903@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <51AD12AB.1000903-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Don Dutile <ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: =?iso-8859-1?Q?Beno=EEt?= Canet <benoit.canet-J9ArbTHlV+bR7s880joybQ@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

> >>Per the SRIOV spec, yes, but that's in PCIe ext cfg space.
> >>That area of the PCI configuration is not saved or restored by dev-rese=
t.
> >
> >Can a callback be added so PF driver can restore this state ?
> >
> As you pointed out, no need to, unless it's a device-specific,
> PCIe cap structure.  the SRIOV caps are re-instated, as you showed above.=
..

I think this is a device specific structure.

It would be annoying only in case of a PF FLR initiated via /sys or somethi=
ng
external to the PF driver because the PF driver could restore this area aft=
er it
initiate an FLR.

Best regards

Beno=EEt Canet
