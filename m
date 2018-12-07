From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 2/5] iommu/of: Use device_iommu_mapped()
Date: Fri, 7 Dec 2018 10:31:58 +0100
Message-ID: <20181207093158.GL16835@8bytes.org>
References: <20181204172504.19708-1-joro@8bytes.org>
 <20181204172504.19708-3-joro@8bytes.org>
 <44c82503-bc36-e8de-6932-7c4fd2b597f8@arm.com>
 <20181206153512.GG16835@8bytes.org>
 <42cb32df-5358-f00d-12f5-eb3135ec680a@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <42cb32df-5358-f00d-12f5-eb3135ec680a@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux-foundation.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Dec 06, 2018 at 05:42:16PM +0000, Robin Murphy wrote:
> For sure - although I am now wondering whether "mapped" is perhaps a little
> ambiguous in the naming, since the answer to "can I use the API" is yes even
> when the device may currently be attached to an identity/passthrough domain
> or blocked completely, neither of which involve any "mapping". Maybe simply
> "device_has_iommu()" would convey the intent better?

The name is shorter version of:

	device_is_behind_an_iommu_remapping_its_dma_transactions()
	:)

The name is not perfect, but device_has_iommu() is not better because it
might be considered as a check whether the device itself has an IOMMU
built-in.

In the end an identity-mapping is also still a mapping (if the iommu
needs a page-table for that is an implementation detail), as is a
mapping with no page-table entries at all (blocking). So I think
device_iommu_mapped() is a reasonable choice.

Regards,

	Joerg
