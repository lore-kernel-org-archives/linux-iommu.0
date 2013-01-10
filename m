From: 'Joerg Roedel' <joro@8bytes.org>
Subject: Re: [PATCH v6 00/12] iommu/exynos: Fixes and Enhancements of System
 MMU driver with DT
Date: Thu, 10 Jan 2013 20:12:08 +0100
Message-ID: <20130110191207.GI25591@8bytes.org>
References: <003301cde30b$c584c2d0$508e4870$%cho@samsung.com>
 <032401cde783$485ae1a0$d910a4e0$@samsung.com>
 <20130110171844.GA2650@8bytes.org>
 <027601cdef61$2df576a0$89e063e0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <027601cdef61$2df576a0$89e063e0$@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: 'Cho KyongHo' <pullip.cho@samsung.com>, 'Linux ARM Kernel' <linux-arm-kernel@lists.infradead.org>, 'Linux IOMMU' <iommu@lists.linux-foundation.org>, 'Linux Kernel' <linux-kernel@vger.kernel.org>, 'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>, 'Hyunwoong Kim' <khw0178.kim@samsung.com>, 'Prathyush' <prathyush.k@samsung.com>, 'Rahul Sharma' <rahul.sharma@samsung.com>, 'Subash Patel' <supash.ramaswamy@linaro.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 10, 2013 at 10:34:48AM -0800, Kukjin Kim wrote:
> Hmm, I think, just one [7/12] patch does matter so if you could create topic
> branch and apply [7/12] patch firstly before other drivers/ changes would be
> better to me. It's OK on both trees if I just _merge_ the first [7/12]
> commit in the topic branch you provided for exynos-iommu. But you know, you
> don't have to rebase it once I merge it in Samsung tree.
> 
> How about?

Sounds good. Should I take the patch directly from this post? I would
add your Acked-by then and make it the base for the arm/exynos branch.
Once the branch is set-up, as usual it will not be rebased.


	Joerg
