From: "joro@8bytes.org" <joro@8bytes.org>
Subject: Re: [PATCH] iommu/amd: Fix IOMMU page flush when detach all devices
 from a domain
Date: Wed, 16 Jan 2019 18:09:36 +0100
Message-ID: <20190116170936.GE4681@8bytes.org>
References: <20190116041546.3541-1-Suravee.Suthikulpanit@amd.com>
 <20190116132648.i5n3hz3k7d2wxbrx@8bytes.org>
 <df209299-8fd1-189c-9c44-b398cf790d1a@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <df209299-8fd1-189c-9c44-b398cf790d1a@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, "Singh, Brijesh" <brijesh.singh@amd.com>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jan 16, 2019 at 02:40:59PM +0000, Suthikulpanit, Suravee wrote:
> Actually, device_flush_dte(alias) should be needed regardless of this patch.
> Are you planning to add this?

Yes, I stumbled over this while writing the diff. I'll submit that as a
separate patch.

Thanks,

	Joerg
