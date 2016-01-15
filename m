From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: IOMMU, DMA and legacy PCI board
Date: Fri, 15 Jan 2016 09:14:27 -0700
Message-ID: <1452874467.14628.129.camel@redhat.com>
References: <n7b3vt$ra8$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <n7b3vt$ra8$1@ger.gmane.org>
Sender: kvm-owner@vger.kernel.org
To: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>, kvm@vger.kernel.org
Cc: iommu <iommu@lists.linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, 2016-01-15 at 18:41 +0300, Matwey V. Kornilov wrote:
> Hello,
>=20
> I am sorry, if I am asking this in a wrong place. I have an legacy
> custom PCI board, which requires contiguous DMA memory region (about =
4
> MB) and does not support scatter/gather.
>=20
> As contiguous DMA region cannot be allocated with the guaranty,
> currently, the issue is solved by using mem=3D kernel command line
> argument and using 'hidden memory' within first 3GB of RAM.
>=20
> Happily, I have the kernel module source codes.
> I am not quite familiar with the internals of IOMMU. The question is =
the
> following. Is it possible to use IOMMU to emulate contiguous DMA regi=
on
> consisted of smaller chunks on the other side?
> If it is possible in theory, how could my PCI device driver use exist=
ing
> kernel API to implement this?


Your question is really better directed to the iommu list (cc'd) since
you don't appear to be doing anything KVM related. =C2=A0It sounds like=
 what
you want is the contiguous memory allocator (cma), see:

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/inc=
lude/linux/dma-contiguous.h

I believe if you specify the size of the available cma using the cma=3D
boot option then the driver can use the standard DMA API
dma_alloc_coherent(). =C2=A0If you want to be more in control of the ad=
dress
space for the device you can use the IOMMU API which would give you
control to dynamically add buffers to a contiguous address space for
your device. =C2=A0cma does not require an iommu, the IOMMU API does.
Thanks,

Alex
