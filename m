From: 'Joerg Roedel' <joro@8bytes.org>
Subject: Re: [PATCH 2/2] iommu/exynos: Follow kernel coding style for
 __sysmmu_enable return type
Date: Wed, 14 Aug 2013 15:15:49 +0200
Message-ID: <20130814131547.GA5889@8bytes.org>
References: <1374766502-14823-1-git-send-email-a.motakis@virtualopensystems.com>
 <1374766502-14823-2-git-send-email-a.motakis@virtualopensystems.com>
 <003101ce89ed$52317330$f6945990$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <003101ce89ed$52317330$f6945990$@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Cho KyongHo <pullip.cho@samsung.com>
Cc: 'Antonios Motakis' <a.motakis@virtualopensystems.com>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, kvmarm@lists.cs.columbia.edu, 'Sachin Kamat' <sachin.kamat@linaro.org>, 'Varun Sethi' <Varun.Sethi@freescale.com>, 'open list' <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

KyongHo,

On Fri, Jul 26, 2013 at 07:46:01PM +0900, Cho KyongHo wrote:
> __sysmmu_enable() must return 1 if it is called with the same page table.
> I have fixed it exynos_iommu_attach_device() to always return zero on success
> in the next patchset which I will post today.
> 
> Thank you.

When you are fine with these patches please put them on-top of your
patch-set when you re-submit. I will take them from there then.


	Joerg
