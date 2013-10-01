From: Yoder Stuart-B08248 <B08248@freescale.com>
Subject: RE: [PATCH 3/7] Return info for device and its memory regions and
 interrupts
Date: Tue, 1 Oct 2013 19:32:08 +0000
Message-ID: <9F6FE96B71CF29479FF1CDC8046E15036D3803@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1380554923-17818-1-git-send-email-a.motakis@virtualopensystems.com>
	<1380554923-17818-4-git-send-email-a.motakis@virtualopensystems.com>
	<1380562776.2674.177.camel@ul30vt.home>
 <CAG8rG2yPXX9WtmhJqYMNE_3x4RNGkb1BDab8F3Pk8KUhntM9fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAG8rG2yPXX9WtmhJqYMNE_3x4RNGkb1BDab8F3Pk8KUhntM9fg@mail.gmail.com>
Content-Language: en-US
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Antonios Motakis <a.motakis@virtualopensystems.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: kvm-arm <kvmarm@lists.cs.columbia.edu>, Linux IOMMU <iommu@lists.linux-foundation.org>, Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>, KVM devel mailing list <kvm@vger.kernel.org>, Alexander Graf <agraf@suse.de>, VirtualOpenSystems Technical Team <tech@virtualopensystems.com>
List-Id: iommu@lists.linux-foundation.org

> Antonios Motakis wrote
> > Alex Williamson <alex.williamson@redhat.com> wrote:
> > I notice all the open firmware calls here and I'm curious,
> > will all platform devices be making use of open firmware?
> > I don't know if this is synonymous with device tree or not.
> > Thanks,
>
> This VFIO driver will support only devices implemented
> on the device tree. While there can be platform devices
> outside the device tree, I don't think it makes sense
> to support them from the same driver. This is why I
> originally called the driver VFIO_DT, however I renamed
> it to VFIO_PLATFORM after feedback from the first
> RFC. However personally, I still think the VFIO_DT name
> is more appropriate since we don't support all platform
> devices, only those that use the device tree.

But there is no 'device tree' bus.  The bus type we're
dealing with is a platform bus.

vfio for platform devices should be independent of whether
the device was discovered in a device tree or not.
All you're doing is exposing mappable regions and IRQs
to user space and it does not matter where the info originated.

You should be using platform bus structs here not
reparsing device tree nodes.  The struct
platform_device already has resource info in the 
struct:

struct platform_device {
        const char      *name;
        u32             id;
        struct device   dev;
        u32             num_resources;
        struct resource *resource;
};

Stuart
