From: Don Dutile <ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [Qemu-devel] SR-IOV PF reset and QEMU VFs VFIO passthrough
Date: Mon, 03 Jun 2013 16:55:13 -0400
Message-ID: <51AD02B1.8070503@redhat.com>
References: <20130601121320.GC5157@irqsave.net> <51ACE340.1030406@redhat.com>
	<20130603192958.GB31044@irqsave.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20130603192958.GB31044-J9ArbTHlV+bR7s880joybQ@public.gmane.org>
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

On 06/03/2013 03:29 PM, Beno=EEt Canet wrote:
>>> to a guest will the consequences of a PF FLR be handled fine by QEMU an=
d the
>>> guest ?
>>>
>> the reset occurs long before the device is passed to the guest.
>
> I was asking this because the PF driver should reset the PF while the VF =
are
> used by VFIO/QEMU when the PF doesn't respond anymore.
>
What your VF does while your PF is being reset is PF (& VF) dependent.
A 'good design' would not impact the VF operation, other than to stall it u=
ntil
the PF completed reset.  My experience, though, is that the PF has to be br=
ought
up to some level of functionality to share the physical resources with the =
VFs.

>> The PF driver doesn't do the config space restore -- it's done in PCI co=
re code.
>>> files used by QEMU disappear and reappear messing the QEMU VFIO passthr=
ough or
>> As stated above, the devices don't disappear from the device tree, so th=
ey don't
>> get removed/added to the /sys(/bus/pci/...) files.
>>
>>> will it goes smoothly ?
>>>
>> it goes smoothly today.... :-/
>
> Happy to read that thanks for the answer.
>
> Best regards
>
> Beno=EEt Canet
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
