From: Cho KyongHo <pullip.cho@samsung.com>
Subject: Re: [PATCH 2/2] iommu/exynos: Follow kernel coding style for
 __sysmmu_enable return type
Date: Fri, 16 Aug 2013 20:21:51 +0900
Message-ID: <20130816202151.b47fae1e9ed249d06baa37d1@samsung.com>
References: <1374766502-14823-1-git-send-email-a.motakis@virtualopensystems.com>
 <1374766502-14823-2-git-send-email-a.motakis@virtualopensystems.com>
 <003101ce89ed$52317330$f6945990$@samsung.com>
 <20130814131547.GA5889@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20130814131547.GA5889@8bytes.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Joerg Roedel' <joro@8bytes.org>
Cc: 'Antonios Motakis' <a.motakis@virtualopensystems.com>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, kvmarm@lists.cs.columbia.edu, 'Sachin Kamat' <sachin.kamat@linaro.org>, 'Varun Sethi' <Varun.Sethi@freescale.com>, 'open list' <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, 14 Aug 2013 15:15:49 +0200, 'Joerg Roedel' wrote:
> KyongHo,
> 
> On Fri, Jul 26, 2013 at 07:46:01PM +0900, Cho KyongHo wrote:
> > __sysmmu_enable() must return 1 if it is called with the same page table.
> > I have fixed it exynos_iommu_attach_device() to always return zero on success
> > in the next patchset which I will post today.
> > 
> > Thank you.
> 
> When you are fine with these patches please put them on-top of your
> patch-set when you re-submit. I will take them from there then.
> 

Ok.

Antonios,

Would you mind
if I submit your 2 patches on top of my patches with your signed-off?

KyongHo.

> 
> 	Joerg
> 
> 
