From: "joro@8bytes.org" <joro@8bytes.org>
Subject: Re: [PATCH] iommu/amd: Fix IOMMU page flush when detach all devices
 from a domain
Date: Tue, 22 Jan 2019 11:44:54 +0100
Message-ID: <20190122104454.nke2knuyqiswfh5w@8bytes.org>
References: <20190116041546.3541-1-Suravee.Suthikulpanit@amd.com>
 <20190116132648.i5n3hz3k7d2wxbrx@8bytes.org>
 <60c24182-c58e-0575-b085-c7eebc00c49b@amd.com>
 <20190116170852.GD4681@8bytes.org>
 <0a61c07d-edfe-2738-380d-33d39e40fc0a@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0a61c07d-edfe-2738-380d-33d39e40fc0a@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, "Singh, Brijesh" <brijesh.singh@amd.com>
List-Id: iommu@lists.linux-foundation.org

Hi Suravee,

On Thu, Jan 17, 2019 at 08:44:36AM +0000, Suthikulpanit, Suravee wrote:
> Then, in __domain_flush_pages, we issue command when the dev_iommu[] >= 0.
> This should preserve previous behavior, and only add flushing condition to
> the specific IOMMU in detached state. Please let me know what you think.

I think the whole point why VFIO is detaching all devices first and then
goes into unmapping pages is that there are no flushes needed anymore
when devices are detached.

But when we follow your proposal we would still do IOTLB flushes even
when no devices are attached anymore. So I'd like to avoid this, given
the implications on unmapping performance. We should just flush the
IOMMU TLB at detach time and be done with it.

Makes sense?

Regards,

	Joerg
