From: 'Joerg Roedel' <joro@8bytes.org>
Subject: Re: [PATCH v6 00/12] iommu/exynos: Fixes and Enhancements of System
 MMU driver with DT
Date: Fri, 11 Jan 2013 16:52:26 +0100
Message-ID: <20130111155226.GK25591@8bytes.org>
References: <003301cde30b$c584c2d0$508e4870$%cho@samsung.com>
 <032401cde783$485ae1a0$d910a4e0$@samsung.com>
 <20130110171844.GA2650@8bytes.org>
 <027601cdef61$2df576a0$89e063e0$@samsung.com>
 <20130110191207.GI25591@8bytes.org>
 <02ae01cdef69$67d66200$37832600$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <02ae01cdef69$67d66200$37832600$@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: 'Cho KyongHo' <pullip.cho@samsung.com>, 'Linux ARM Kernel' <linux-arm-kernel@lists.infradead.org>, 'Linux IOMMU' <iommu@lists.linux-foundation.org>, 'Linux Kernel' <linux-kernel@vger.kernel.org>, 'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>, 'Hyunwoong Kim' <khw0178.kim@samsung.com>, 'Prathyush' <prathyush.k@samsung.com>, 'Rahul Sharma' <rahul.sharma@samsung.com>, 'Subash Patel' <supash.ramaswamy@linaro.org>
List-Id: iommu@lists.linux-foundation.org

Hi Kukjin,

On Thu, Jan 10, 2013 at 11:33:41AM -0800, Kukjin Kim wrote:
> Sure, keep going on with
> 
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Done that. Applied the patch, some manual work was necessary as the
patch didn't apply cleanly to v3.8-rc3. Please double-check if the
result is correct.

> OK, good. Let me know the name of branch when you set-up it :-)

I pushed the branch to

	git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git arm/exynos

>From there you can pull it into your tree.

Have fun,

     Joerg
