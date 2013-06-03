From: =?iso-8859-1?Q?Beno=EEt?= Canet <benoit.canet-J9ArbTHlV+bR7s880joybQ@public.gmane.org>
Subject: Re: [Qemu-devel] SR-IOV PF reset and QEMU VFs VFIO passthrough
Date: Mon, 3 Jun 2013 23:27:23 +0200
Message-ID: <20130603212723.GG4094@irqsave.net>
References: <20130601121320.GC5157@irqsave.net> <51ACE340.1030406@redhat.com>
	<20130603192958.GB31044@irqsave.net> <51AD02B1.8070503@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <51AD02B1.8070503-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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

> >I was asking this because the PF driver should reset the PF while the VF=
 are
> >used by VFIO/QEMU when the PF doesn't respond anymore.
> >
> What your VF does while your PF is being reset is PF (& VF) dependent.
> A 'good design' would not impact the VF operation, other than to stall it=
 until
> the PF completed reset.  My experience, though, is that the PF has to be =
brought
> up to some level of functionality to share the physical resources with th=
e VFs.

When the PF does an FLR the hardware go back to its default state, the SR-I=
OV
configuration is gone and the VFs disappears from the bus.
Then the restore state function of the kernel reset code would bring the SR=
-IOV
PF configuration back.

The hardware also have a privately owned SR-IOV related configuration in th=
e PF
configuration space. This configuration is used to configure the VFs resour=
ces.
(memory)

Best regards

Beno=EEt Canet
