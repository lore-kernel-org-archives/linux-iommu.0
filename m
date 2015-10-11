From: Avi Kivity <avi@scylladb.com>
Subject: Re: [RFC PATCH 2/2] vfio: Include no-iommu mode
Date: Sun, 11 Oct 2015 12:03:17 +0300
Message-ID: <561A25D5.6020906@scylladb.com>
References: <20151009182228.14752.99700.stgit@gimli.home>
 <20151009184110.14752.53531.stgit@gimli.home> <561A19DE.8040302@scylladb.com>
 <20151011115503-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151011115503-mutt-send-email-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, avi@cloudius-systems.com, gleb@scylladb.com, corbet@lwn.net, bruce.richardson@intel.com, linux-kernel@vger.kernel.org, alexander.duyck@gmail.com, gleb@cloudius-systems.com, stephen@networkplumber.org, vladz@cloudius-systems.com, iommu@lists.linux-foundation.org, hjk@hansjkoch.de, gregkh@linuxfoundation.org
List-Id: iommu@lists.linux-foundation.org



On 10/11/2015 11:57 AM, Michael S. Tsirkin wrote:
> On Sun, Oct 11, 2015 at 11:12:14AM +0300, Avi Kivity wrote:
>>>    Mixing no-iommu and secure VFIO is
>>> also unsupported, as are any VFIO IOMMU backends other than the
>>> vfio-noiommu backend.  Furthermore, unsafe group files are relocated
>>> to /dev/vfio-noiommu/.  Upon successful loading in this mode, the
>>> kernel is tainted due to the dummy IOMMU put in place.  Unloading of
>>> the module in this mode is also unsupported and will BUG due to the
>>> lack of support for unregistering an IOMMU for a bus type.
>> I did not see an API for detecting whether memory translation is provided or
>> not.  We can have the caller guess this by looking at the device name, or by
>> requiring the user to specify this, but I think it's cleaner to provide
>> programmatic access to this attribute.
> It seems that caller can just check for VFIO_NOIOMMU_IOMMU.
>
> Isn't this why it's there?

That's just means the capability is there, not that it's active.

But since you must pass the same value to open(), you already know that 
you're using noiommu.

> VFIO_IOMMU_MAP_DMA, VFIO_IOMMU_ENABLE and VFIO_IOMMU_DISABLE
> will probably also fail ...
>

Don't you have to call MAP_DMA to pin the memory?
