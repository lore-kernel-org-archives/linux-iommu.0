From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [RFC] iommu: arm-smmu: stall support
Date: Fri, 22 Sep 2017 11:02:05 +0200
Message-ID: <20170922090204.GJ8398@8bytes.org>
References: <20170914194444.32551-1-robdclark@gmail.com>
 <20170919123038.GF8398@8bytes.org>
 <CAF6AEGuutkqjrWk4jagE=p-NwHgxdiPZjjsaFsfwtczK568j+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAF6AEGuutkqjrWk4jagE=p-NwHgxdiPZjjsaFsfwtczK568j+A@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Rob Clark <robdclark@gmail.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Jordan Crouse <jcrouse@codeaurora.org>, Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Sep 19, 2017 at 10:23:43AM -0400, Rob Clark wrote:
> I would like to decide in the IRQ whether or not to queue work or not,
> because when we get a gpu fault, we tend to get 1000's of gpu faults
> all at once (and I really only need to handle the first one).  I
> suppose that could also be achieved by having a special return value
> from the fault handler to say "call me again from a wq"..
> 
> Note that in the drm driver I already have a suitable wq to queue the
> work, so it really doesn't buy me anything to have the iommu driver
> toss things off to a wq for me.  Might be a different situation for
> other drivers (but I guess mostly other drivers are using iommu API
> indirectly via dma-mapping?)

Okay, so since you are the only user for now, we don't need a
work-queue. But I still want the ->resume call-back to be hidden in the
iommu code and not be exposed to users.

We already have per-domain fault-handlers, so the best solution for now
is to call ->resume from report_iommu_fault() when the fault-handler
returns a special value.


Regards,

	Joerg
