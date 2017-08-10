From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RESEND PATCH 2/4] iommu: arm-smmu: split out register defines
Date: Thu, 10 Aug 2017 18:28:54 +0100
Message-ID: <20170810172853.GE9980@arm.com>
References: <20170809144310.22855-1-robdclark@gmail.com>
 <20170809144310.22855-3-robdclark@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170809144310.22855-3-robdclark@gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Rob Clark <robdclark@gmail.com>
Cc: iommu@lists.linux-foundation.org, linux-arm-msm@vger.kernel.org, Archit Taneja <architt@codeaurora.org>, Rob Herring <robh@kernel.org>, Sricharan <sricharan@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Aug 09, 2017 at 10:43:03AM -0400, Rob Clark wrote:
> I want to re-use some of these for qcom_iommu, which has (roughly) the
> same context-bank registers.
> 
> Signed-off-by: Rob Clark <robdclark@gmail.com>
> ---
>  drivers/iommu/arm-smmu-regs.h | 220 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/iommu/arm-smmu.c      | 211 ++--------------------------------------
>  2 files changed, 229 insertions(+), 202 deletions(-)
>  create mode 100644 drivers/iommu/arm-smmu-regs.h

This looks like a reasonable split, thanks:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
