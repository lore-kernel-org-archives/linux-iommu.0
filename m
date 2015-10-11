From: Avi Kivity <avi@scylladb.com>
Subject: Re: [RFC PATCH 2/2] vfio: Include no-iommu mode
Date: Sun, 11 Oct 2015 11:12:14 +0300
Message-ID: <561A19DE.8040302@scylladb.com>
References: <20151009182228.14752.99700.stgit@gimli.home>
 <20151009184110.14752.53531.stgit@gimli.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151009184110.14752.53531.stgit@gimli.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>
Cc: avi@cloudius-systems.com, gleb@scylladb.com, corbet@lwn.net, bruce.richardson@intel.com, mst@redhat.com, linux-kernel@vger.kernel.org, alexander.duyck@gmail.com, gleb@cloudius-systems.com, stephen@networkplumber.org, vladz@cloudius-systems.com, iommu@lists.linux-foundation.org, hjk@hansjkoch.de, gregkh@linuxfoundation.org
List-Id: iommu@lists.linux-foundation.org



On 10/09/2015 09:41 PM, Alex Williamson wrote:
> There is really no way to safely give a user full access to a PCI
> without an IOMMU to protect the host from errant DMA.  There is also
> no way to provide DMA translation, for use cases such as devices
> assignment to virtual machines.  However, there are still those users
> that want userspace drivers under those conditions.  The UIO driver
> exists for this use case, but does not provide the degree of device
> access and programming that VFIO has.  In an effort to avoid code
> duplication, this introduces a No-IOMMU mode for VFIO.
>
> This mode requires enabling CONFIG_VFIO_NOIOMMU and loading the vfio
> module with the option "enable_unsafe_pci_noiommu_mode".  This should
> make it very clear that this mode is not safe.  In this mode, there is
> no support for unprivileged users, CAP_SYS_ADMIN is required for
> access to the necessary dev files.

CAP_SYS_RAWIO seems a better match (in particular, it allows access to 
/dev/mem, which is the same thing).

>    Mixing no-iommu and secure VFIO is
> also unsupported, as are any VFIO IOMMU backends other than the
> vfio-noiommu backend.  Furthermore, unsafe group files are relocated
> to /dev/vfio-noiommu/.  Upon successful loading in this mode, the
> kernel is tainted due to the dummy IOMMU put in place.  Unloading of
> the module in this mode is also unsupported and will BUG due to the
> lack of support for unregistering an IOMMU for a bus type.

I did not see an API for detecting whether memory translation is 
provided or not.  We can have the caller guess this by looking at the 
device name, or by requiring the user to specify this, but I think it's 
cleaner to provide programmatic access to this attribute.
