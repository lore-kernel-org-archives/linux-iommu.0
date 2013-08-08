From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v8 06/12] ARM: dts: Add description of System MMU of
 Exynos SoCs
Date: Thu, 8 Aug 2013 22:43:43 +0100
Message-ID: <20130808214343.GA19383@mudshark.cambridge.arm.com>
References: <003c01ce89f3$3abc4bc0$b034e340$@samsung.com>
 <003801ce8eb7$d7647f10$862d7d30$@samsung.com>
 <CAL_Jsq+_5GekzXpjWrtKZi2jWuxHSJxkPmVC4zmakfjAYai=eA@mail.gmail.com>
 <5354557.DijgoUKjW2@flatron>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5354557.DijgoUKjW2@flatron>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Rob Herring <robherring2@gmail.com>, Cho KyongHo <pullip.cho@samsung.com>, Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>, Linux IOMMU <iommu@lists.linux-foundation.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, Hyunwoong Kim <khw0178.kim@samsung.com>, Prathyush <prathyush.k@samsung.com>, Grant Grundler <grundler@chromium.org>, Joerg Roedel <joro@8bytes.org>, Keyyoung Park <keyyoung.park@samsung.com>, Subash Patel <supash.ramaswamy@linaro.org>, Sachin Kamat <sachin.kamat@linaro.org>, Antonios Motakis <a.motakis@virtualopensystems.com>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>, Rahul Sharma <rahul.sharma@samsung.com>
List-Id: iommu@lists.linux-foundation.org

On Thu, Aug 08, 2013 at 10:38:10PM +0100, Tomasz Figa wrote:
> On Thursday 08 of August 2013 08:09:49 Rob Herring wrote:
> > On Thu, Aug 1, 2013 at 8:05 AM, Cho KyongHo <pullip.cho@samsung.com> 
> wrote:
> > > Should this align with ARM System MMU bindings?
> > > System MMU in Exynos SoC is different from ARM System MMU.
> > > It does not follows the specifications of ARM System MMU.
> > 
> > I'm not saying the h/w is the same or even the same spec, but how you
> > describe a master to iommu connection needs to be done in the same
> > way. This should be done in the same way for ALL iommu's. And if what
> > is defined does not work for you, then we need to understand that and
> > fix the binding now.
> 
> +1
> 
> All IOMMUs should use a generic IOMMU Device Tree bindings (and in 
> general, the same should be true for all Device Tree bindings).
> 
> This means that if we already have some bindings for IOMMU, then they 
> should be reused if possible or extended if there is anything missing.
> 
> Of course there might be things that such generic bindings can't specify. 
> In this case device-specific properties can be introduced, but this is 
> last resort.

I'm also happy to discuss and/or review bindings in light of what we did for
the ARM SMMU.

Will
