From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 2/5] iommu/of: Use device_iommu_mapped()
Date: Thu, 6 Dec 2018 16:35:12 +0100
Message-ID: <20181206153512.GG16835@8bytes.org>
References: <20181204172504.19708-1-joro@8bytes.org>
 <20181204172504.19708-3-joro@8bytes.org>
 <44c82503-bc36-e8de-6932-7c4fd2b597f8@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <44c82503-bc36-e8de-6932-7c4fd2b597f8@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux-foundation.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On Wed, Dec 05, 2018 at 05:17:54PM +0000, Robin Murphy wrote:
> FWIW, this check (and its ACPI equivalent in patch #3) is specifically
> asking "has .add_device() already been called?", rather than the more
> general "is this device managed by an IOMMU?" (to which the exact answer at
> this point is "yes, provided we return successfully from here").
> 
> I have no objection to the change as-is - especially if that usage is within
> the intended scope of this API - I just wanted to call it out in case you're
> also planning to introduce something else which would be even more
> appropriate for that.

Yes, the purpose of the device_iommu_mapped() functions is to check
whether the device has been initialized by the IOMMU driver that handles
it, if any.

So it answers the question: Can I use the device in an IOMMU-API call?
And it is more readable than the dev->iommu_group checks everywhere :)

Regards,

	Joerg
