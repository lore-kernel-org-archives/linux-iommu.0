From: Juhani Rautiainen <jrauti@iki.fi>
Subject: Re: KVM PCI passthrough problems after kernel v4.2
Date: Fri, 13 Nov 2015 06:48:41 +0200
Message-ID: <CAN74MCyW+GrX3cBSS8+JFNv9gaNj=tBgQq5st1_YHY1DwFtH1A@mail.gmail.com>
References: <CAN74MCz9MCoLFh=NDLeUVQvBnUgaVJO_c8uTv1RT2V9sTMZ9yA@mail.gmail.com>
	<1447365623.3946.99.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447365623.3946.99.camel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-kernel@vger.kernel.org, iommu <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>
List-Id: iommu@lists.linux-foundation.org

Hi!

Thanks a lot for the help. I switched to vfio and got NIC working
again. Now I just have to figure out what I have to change to get this
to persist through the host boots. To tell the truth I couldn't quite
parse from that commit message that my device would stop working:).
The error messages in this area are quite uninformative anyway. KVM
could for instance warn for using deprecated method (kernel does it in
many other places). When I did that configuration, I did it using KVM
PCI passthrough pages and the method there was this deprecated method
(and it still was when I switched to Centos7, because I lost my config
through stupid mistake and had to do it all over again). And I thought
that I've been following this area in LKML but somehow missed the
whole deprecation business:).

Thanks,
-Juhani

On Fri, Nov 13, 2015 at 12:00 AM, Alex Williamson
<alex.williamson@redhat.com> wrote:
> On Thu, 2015-11-12 at 23:36 +0200, Juhani Rautiainen wrote:
>> Hi!
>>
>> I've been using KVM PCI passthrough with a dual-port NIC for over a
>> year. I just upgraded to v4.3 from v4.1.4 and PCI passthrough stopped
>> working. I checked with v4.1.9 and it still works there. Version 4.2
>> seems to point after which my system doesn't work. How can I help to
>> narrow down the cause of the problem? I checked the intel-iommu.c and
>> there seem to have been lots of changes between 4.1.9 and 4.2 in
>> drivers/iommu/intel-iommu.c. My motherboard is Asus P8C WS which has
>> Intel C216 chipset. CPU is Intel I5-3470. From v4.2 onwards
>> passthrough fails with:
>>
>> pci-stub 0000:02:00.0: kvm assign device failed ret -22.
>
> This happens when kvm calls iommu_attach_device(), which was changed in
> v4.2 to fail with -EINVAL (-22) when the device is part of a
> non-singleton iommu group.  Legacy kvm device assignment is not iommu
> group aware and has been deprecated for some time.  Have you considered
> using vfio for device assignment instead?
>
> For reference, here's the comment that made this change:
>
> commit 426a273834eae65abcfc7132a21a85b3151e0bce
> Author: Joerg Roedel <jroedel@suse.de>
> Date:   Thu May 28 18:41:30 2015 +0200
>
>     iommu: Limit iommu_attach/detach_device to devices with their own group
>
>     This patch changes the behavior of the iommu_attach_device
>     and iommu_detach_device functions. With this change these
>     functions only work on devices that have their own group.
>     For all other devices the iommu_group_attach/detach
>     functions must be used.
>
>     Signed-off-by: Joerg Roedel <jroedel@suse.de>
>
>



-- 
Juhani Rautiainen                                   jrauti@iki.fi
