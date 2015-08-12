From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 4/5] iommu/msm: Set cacheability attributes without tex
 remap
Date: Wed, 12 Aug 2015 15:53:46 +0100
Message-ID: <20150812145346.GH23540@arm.com>
References: <1439390869-6347-1-git-send-email-sricharan@codeaurora.org>
 <1439390869-6347-5-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1439390869-6347-5-git-send-email-sricharan@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sricharan R <sricharan@codeaurora.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Robin Murphy <Robin.Murphy@arm.com>, "robdclark@gmail.com" <robdclark@gmail.com>, "joro@8bytes.org" <joro@8bytes.org>, "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>, "laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>, "stepanm@codeaurora.org" <stepanm@codeaurora.org>, "treding@nvidia.com" <treding@nvidia.com>
List-Id: iommu@lists.linux-foundation.org

On Wed, Aug 12, 2015 at 03:47:48PM +0100, Sricharan R wrote:
> The cacheablity attributes are set when IOMMU_CACHE property
> is true. So cachebility is set as either noncached (normal)
> or cached (normal WBWA) directly and avoid setting using
> tex remap.

Does this IOMMU support the ARMv7 short descriptor format? If so, would
it work with Yong's patch here:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2015-August/361615.html

I've not gotten around to reviewing the latest version yet, but having
other IOMMUs consolidate on one set of page table code would be a good
thing.

Will
