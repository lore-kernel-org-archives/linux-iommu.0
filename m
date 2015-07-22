From: "Sricharan" <sricharan@codeaurora.org>
Subject: RE: [RFC PATCH 1/4] iommu/arm-smmu: Init driver using IOMMU_OF_DECLARE
Date: Wed, 22 Jul 2015 16:38:52 +0530
Message-ID: <000501d0c46e$ceae9920$6c0bcb60$@codeaurora.org>
References: <1437152005-25092-1-git-send-email-sricharan@codeaurora.org> <1437152005-25092-2-git-send-email-sricharan@codeaurora.org> <20150721150306.GI31095@arm.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20150721150306.GI31095@arm.com>
Content-Language: en-us
Sender: linux-arm-msm-owner@vger.kernel.org
To: 'Will Deacon' <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, mitchelh@codeaurora.org, robin.murphy@arm.com
List-Id: iommu@lists.linux-foundation.org

Hi Will,

> -----Original Message-----
> From: Will Deacon [mailto:will.deacon@arm.com]
> Sent: Tuesday, July 21, 2015 8:33 PM
> To: Sricharan R
> Cc: linux-arm-kernel@lists.infradead.org;
iommu@lists.linux-foundation.org;
> devicetree@vger.kernel.org; linux-arm-msm@vger.kernel.org;
> mitchelh@codeaurora.org; robin.murphy@arm.com
> Subject: Re: [RFC PATCH 1/4] iommu/arm-smmu: Init driver using
> IOMMU_OF_DECLARE
> 
> [adding Robin]
> 
> On Fri, Jul 17, 2015 at 05:53:22PM +0100, Sricharan R wrote:
> > This patch uses IOMMU_OF_DECLARE to register the driver and the
> > iommu_ops. So when master devices of the iommu are registered,
> > of_xlate callback can be used to add the master configurations to the
> > smmu driver.
> 
> I'd really prefer to do this on top of Laurent's series reworking some of
the
> of_xlate code and I think Robin [CC'd] is working on that. That will also
pave
> the way for specifying per-master SMR configuration in the device-tree.

     Ok, understand it. By Rebasing on Laurent's series this patch should
not
     be needed at all, dependencies with clock devices should also be
solved.
     I will rebase this series over there.

Regards,
 Sricharan
