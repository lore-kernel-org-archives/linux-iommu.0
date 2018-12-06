From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 3/4] iommu/of: Don't call iommu_ops->add_device directly
Date: Thu, 6 Dec 2018 17:19:45 +0100
Message-ID: <20181206161945.GK16835@8bytes.org>
References: <20181205143646.4876-1-joro@8bytes.org>
 <20181205143646.4876-4-joro@8bytes.org>
 <41d06767-fe6e-a746-d76a-557259af3034@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <41d06767-fe6e-a746-d76a-557259af3034@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux-foundation.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
List-Id: iommu@lists.linux-foundation.org

On Wed, Dec 05, 2018 at 06:49:26PM +0000, Robin Murphy wrote:
> 	if (ops && dev->bus && !dev->iommu_group)
> 
> What I can't quite remember just now is whether it's actually valid to get
> here with err == 0 but dev->iommu_fwspec->ops == NULL, so it *might* be OK
> to use "!err" instead of "ops" to make things slightly more obvious - I'll
> work through the flow tomorrow to double-check.

Yeah, adding an err == 0 check seems to be the best option here, so that
iommu-drivers don't get confused when we try to add a device that is not
managed by an iommu.


Regards,

	Joerg
