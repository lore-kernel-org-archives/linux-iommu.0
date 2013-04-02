From: Stuart Yoder <b08248@gmail.com>
Subject: Re: RFC: vfio API changes needed for powerpc
Date: Tue, 2 Apr 2013 15:38:42 -0500
Message-ID: <CALRxmdDdZ49A4jJinqu9FKwtF3uRMrGS-hWotZ5jaghvAWnTDQ@mail.gmail.com>
References: <9F6FE96B71CF29479FF1CDC8046E15035A0F13@039-SN1MPN1-003.039d.mgd.msft.net>
	<1364931564.24520.16@snotra>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1364931564.24520.16@snotra>
Sender: kvm-owner@vger.kernel.org
To: Scott Wood <scottwood@freescale.com>
Cc: Yoder Stuart-B08248 <B08248@freescale.com>, Wood Scott-B07421 <B07421@freescale.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "agraf@suse.de" <agraf@suse.de>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Bhushan Bharat-R65777 <R65777@freescale.com>
List-Id: iommu@lists.linux-foundation.org

On Tue, Apr 2, 2013 at 2:39 PM, Scott Wood <scottwood@freescale.com> wrote:
> On 04/02/2013 12:32:00 PM, Yoder Stuart-B08248 wrote:
>>
>> Alex,
>>
>> We are in the process of implementing vfio-pci support for the Freescale
>> IOMMU (PAMU).  It is an aperture/window-based IOMMU and is quite different
>> than x86, and will involve creating a 'type 2' vfio implementation.
>>
>> For each device's DMA mappings, PAMU has an overall aperture and a number
>> of windows.  All sizes and window counts must be power of 2.  To
>> illustrate,
>> below is a mapping for a 256MB guest, including guest memory (backed by
>> 64MB huge pages) and some windows for MSIs:
>>
>>     Total aperture: 512MB
>>     # of windows: 8
>>
>>     win gphys/
>>     #   iova        phys          size
>>     --- ----        ----          ----
>>     0   0x00000000  0xX_XX000000  64MB
>>     1   0x04000000  0xX_XX000000  64MB
>>     2   0x08000000  0xX_XX000000  64MB
>>     3   0x0C000000  0xX_XX000000  64MB
>>     4   0x10000000  0xf_fe044000  4KB    // msi bank 1
>>     5   0x14000000  0xf_fe045000  4KB    // msi bank 2
>>     6   0x18000000  0xf_fe046000  4KB    // msi bank 3
>>     7            -             -  disabled
>>
>> There are a couple of updates needed to the vfio user->kernel interface
>> that we would like your feedback on.
>>
>> 1.  IOMMU geometry
>>
>>    The kernel IOMMU driver now has an interface (see domain_set_attr,
>>    domain_get_attr) that lets us set the domain geometry using
>>    "attributes".
>>
>>    We want to expose that to user space, so envision needing a couple
>>    of new ioctls to do this:
>>         VFIO_IOMMU_SET_ATTR
>>         VFIO_IOMMU_GET_ATTR
>
>
> Note that this means attributes need to be updated for user-API
> appropriateness, such as using fixed-size types.
>
>
>> 2.   MSI window mappings
>>
>>    The more problematic question is how to deal with MSIs.  We need to
>>    create mappings for up to 3 MSI banks that a device may need to target
>>    to generate interrupts.  The Linux MSI driver can allocate MSIs from
>>    the 3 banks any way it wants, and currently user space has no way of
>>    knowing which bank may be used for a given device.
>>
>>    There are 3 options we have discussed and would like your direction:
>>
>>    A.  Implicit mappings -- with this approach user space would not
>>        explicitly map MSIs.  User space would be required to set the
>>        geometry so that there are 3 unused windows (the last 3 windows)
>
>
> Where does userspace get the number "3" from?  E.g. on newer chips there are
> 4 MSI banks.  Maybe future chips have even more.

Ok, then make the number 4.   The chance of more MSI banks in future chips
is nil, and if it ever happened user space could adjust.  Also,
practically speaking since memory is typically allocate in powers of
2 way you need to approximately double the window geometry anyway.

>>    B.  Explicit mapping using DMA map flags.  The idea is that a new
>>        flag to DMA map (VFIO_DMA_MAP_FLAG_MSI) would mean that
>>        a mapping is to be created for the supplied iova.  No vaddr
>>        is given though.  So in the above example there would be a
>>        a dma map at 0x10000000 for 24KB (and no vaddr).
>
>
> A single 24 KiB mapping wouldn't work (and why 24KB? What if only one MSI
> group is involved in this VFIO group?  What if four MSI groups are
> involved?).  You'd need to either have a naturally aligned, power-of-two
> sized mapping that covers exactly the pages you want to map and no more, or
> you'd need to create a separate mapping for each MSI bank, and due to PAMU
> subwindow alignment restrictions these mappings could not be contiguous in
> iova-space.

You're right, a single 24KB mapping wouldn't work--  in the case of 3 MSI banks
perhaps we could just do one 64MB*3 mapping to identify which windows
are used for MSIs.

If only one MSI bank was involved the kernel could get clever and only enable
the banks actually needed.

Stuart
