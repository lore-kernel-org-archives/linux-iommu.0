From: "joro@8bytes.org" <joro@8bytes.org>
Subject: Re: [PATCH] iommu/amd: Fix IOMMU page flush when detach all devices
 from a domain
Date: Wed, 16 Jan 2019 18:08:52 +0100
Message-ID: <20190116170852.GD4681@8bytes.org>
References: <20190116041546.3541-1-Suravee.Suthikulpanit@amd.com>
 <20190116132648.i5n3hz3k7d2wxbrx@8bytes.org>
 <60c24182-c58e-0575-b085-c7eebc00c49b@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <60c24182-c58e-0575-b085-c7eebc00c49b@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, "Singh, Brijesh" <brijesh.singh@amd.com>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jan 16, 2019 at 02:08:55PM +0000, Suthikulpanit, Suravee wrote:
> Actually, I am not sure how we would be missing the flush on the last device.
> In my test, I am seeing the flush command being issued correctly during
> vfio_unmap_unpin(), which is after all devices are detached.
> Although, I might be missing your point here. Could you please elaborate?

Okay, you are right, the patch effectivly adds an unconditional flush of
the domain on all iommus when the last device is detached. So it is
correct in that regard. But that code path is also used in the
iommu_unmap() path.

The problem now is, that with your change we send flush commands to all
IOMMUs in the unmap path when no device is attached to the domain.
This will hurt performance there, no?

Regards,

	Joerg
