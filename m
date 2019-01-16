From: "joro@8bytes.org" <joro@8bytes.org>
Subject: Re: [PATCH] iommu/amd: Mark translation invalid during device detach
Date: Wed, 16 Jan 2019 14:03:34 +0100
Message-ID: <20190116130334.svrjkyr3dnfcj3u6@8bytes.org>
References: <20190116041432.3484-1-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190116041432.3484-1-Suravee.Suthikulpanit@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, "Singh, Brijesh" <brijesh.singh@amd.com>
List-Id: iommu@lists.linux-foundation.org

Hi Suravee,

On Wed, Jan 16, 2019 at 04:15:10AM +0000, Suthikulpanit, Suravee wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> When a device switches domain, IOMMU driver detach device from the old
> domain, and attach device to the new domain. During this period
> the host table root pointer is not set, which means DMA translation
> should be marked as invalid (clear TV bit).
> 
> So, clear the TV bit when detach the device. The TV bit will be set
> again when attaching device to the new domain.

Is there a specific problem with setting the TV bit?

Note that the update will clear all other fields in the first 128 bits
of the DTE, which means that IR, IW and Mode are all set to 0. This
effectivly blocks all DMA requests from the device, which is by design.

Regards,

	Joerg
