From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 0/5] Qcom smmu-500 TLB invalidation errata for sdm845
Date: Tue, 14 Aug 2018 12:40:09 +0100
Message-ID: <20180814114009.GF28664@arm.com>
References: <20180814105528.20592-1-vivek.gautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180814105528.20592-1-vivek.gautam@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: joro@8bytes.org, andy.gross@linaro.org, robin.murphy@arm.com, bjorn.andersson@linaro.org, iommu@lists.linux-foundation.org, mark.rutland@arm.com, david.brown@linaro.org, tfiga@chromium.org, swboyd@chromium.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, robdclark@gmail.com
List-Id: iommu@lists.linux-foundation.org

Hi Vivek,

On Tue, Aug 14, 2018 at 04:25:23PM +0530, Vivek Gautam wrote:
> Qcom's implementation of arm,mmu-500 on sdm845 has a functional/performance
> errata [1] because of which the TCU cache look ups are stalled during
> invalidation cycle. This is mitigated by serializing all the invalidation
> requests coming to the smmu.

How does this implementation differ from the one supported by qcom_iommu.c?
I notice you're adding firmware hooks here, which we avoided by having the
extra driver. Please help me understand which devices exist, how they
differ, and which drivers are intended to support them!

Also -- you didn't CC all the maintainers for the firmware bits, so adding
Andy here for that, and Rob for the previous question.

Thanks,

Will
