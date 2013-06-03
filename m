From: Don Dutile <ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [Qemu-devel] SR-IOV PF reset and QEMU VFs VFIO passthrough
Date: Mon, 03 Jun 2013 17:42:16 -0400
Message-ID: <51AD0DB8.8090109@redhat.com>
References: <20130601121320.GC5157@irqsave.net> <51ACE340.1030406@redhat.com>
	<20130603192958.GB31044@irqsave.net> <51AD02B1.8070503@redhat.com>
	<20130603212723.GG4094@irqsave.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20130603212723.GG4094-J9ArbTHlV+bR7s880joybQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: =?ISO-8859-1?Q?Beno=EEt_Canet?= <benoit.canet-J9ArbTHlV+bR7s880joybQ@public.gmane.org>
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 06/03/2013 05:27 PM, Beno=EEt Canet wrote:
>>> I was asking this because the PF driver should reset the PF while the V=
F are
>>> used by VFIO/QEMU when the PF doesn't respond anymore.
>>>
>> What your VF does while your PF is being reset is PF (&  VF) dependent.
>> A 'good design' would not impact the VF operation, other than to stall i=
t until
>> the PF completed reset.  My experience, though, is that the PF has to be=
 brought
>> up to some level of functionality to share the physical resources with t=
he VFs.
>
> When the PF does an FLR the hardware go back to its default state, the SR=
-IOV
> configuration is gone and the VFs disappears from the bus.
> Then the restore state function of the kernel reset code would bring the =
SR-IOV
> PF configuration back.
>
Ok, now you're a bit mis-led here.
The configuration header for SRIOV is _not_ put back.
Only the std, PCI config header section is put back in place, along with
msi(x), pm-caps.
If the hw wipes out all VF state setup (which it should, IMO), all VF confi=
guration
will be lost in the hw...
*but*, the PCI core will still think the VFs exist (not hot-unplugged, no m=
ore than PF was);
trying to setup the VFs again, will fail (or worse).

> The hardware also have a privately owned SR-IOV related configuration in =
the PF
> configuration space. This configuration is used to configure the VFs reso=
urces.
> (memory)
>
Per the SRIOV spec, yes, but that's in PCIe ext cfg space.
That area of the PCI configuration is not saved or restored by dev-reset.

> Best regards
>
> Beno=EEt Canet
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
