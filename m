From: Joel Schopp <joel.schopp@amd.com>
Subject: Re: [RFC 0/4] VFIO: PLATFORM: Return device tree info for a platform
 device node
Date: Tue, 19 Aug 2014 15:27:24 -0500
Message-ID: <53F3B32C.6080101@amd.com>
References: <1407927740-14993-1-git-send-email-a.motakis@virtualopensystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1407927740-14993-1-git-send-email-a.motakis@virtualopensystems.com>
Sender: kvm-owner@vger.kernel.org
To: Antonios Motakis <a.motakis@virtualopensystems.com>, alex.williamson@redhat.com, kvmarm@lists.cs.columbia.edu, iommu@lists.linux-foundation.org
Cc: tech@virtualopensystems.com, a.rigo@virtualopensystems.com, kvm@vger.kernel.org, christoffer.dall@linaro.org, will.deacon@arm.com, kim.phillips@freescale.com, stuart.yoder@freescale.com, eric.auger@linaro.org, marc.zyngier@arm.com
List-Id: iommu@lists.linux-foundation.org


> This RFC's intention is to show what an interface to access device node
> properties for VFIO_PLATFORM can look like.
>
> If a device tree node corresponding to a platform device bound by VFIO_PLATFORM
> is available, this patch series will allow the user to query the properties
> associated with this device node. This can be useful for userspace drivers
> to automatically query parameters related to the device.
>
> An API to return data from a device's device tree has been proposed before on
> these lists. The API proposed here is slightly different.
>
> Properties to parse from the device tree are not indexed by a numerical id.
> The host system doesn't guarantee any specific ordering for the available
> properties, or that those will remain the same; while this does not happen in
> practice, there is nothing from the host changing the device nodes during
> operation. So properties are accessed by property name.
>
> The type of the property accessed must also be known by the user. Properties
> types implemented in this RFC:
> - VFIO_DEVTREE_ARR_TYPE_STRING (strings sepparated by the null character)
> - VFIO_DEVTREE_ARR_TYPE_U32
> - VFIO_DEVTREE_ARR_TYPE_U16
> - VFIO_DEVTREE_ARR_TYPE_U8
>
> These can all be access by the ioctl VFIO_DEVICE_GET_DEVTREE_INFO. A new ioctl
> was preferred instead of shoehorning the functionality in VFIO_DEVICE_GET_INFO.
> The structure exchanged looks like this:

You'll have to forgive my ignorance on the history.  But with the dtc
tool already supporting a filesystem representation (--in-format=fs),
with the dtc tool source already built into qemu, and having an example
implementation of such an interface in /proc/device-tree/ why is an
ioctl interface preferred over a filesystem interface? 

