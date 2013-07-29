From: Cho KyongHo <pullip.cho@samsung.com>
Subject: RE: [PATCH v8 06/12] ARM: dts: Add description of System MMU of Exynos
 SoCs
Date: Mon, 29 Jul 2013 16:20:28 +0900
Message-ID: <003701ce8c2c$19eff910$4dcfeb30$@samsung.com>
References: <003c01ce89f3$3abc4bc0$b034e340$@samsung.com>
 <CAK9yfHy2btp1W+5-GiVQnkffDnJ-CgqXuAjGktkiKYyf7kKQbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CAK9yfHy2btp1W+5-GiVQnkffDnJ-CgqXuAjGktkiKYyf7kKQbQ@mail.gmail.com>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Sachin Kamat' <sachin.kamat@linaro.org>
Cc: 'Linux ARM Kernel' <linux-arm-kernel@lists.infradead.org>, 'Linux IOMMU' <iommu@lists.linux-foundation.org>, 'Linux Kernel' <linux-kernel@vger.kernel.org>, 'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>, 'Hyunwoong Kim' <khw0178.kim@samsung.com>, 'Joerg Roedel' <joro@8bytes.org>, 'Kukjin Kim' <kgene.kim@samsung.com>, 'Prathyush' <prathyush.k@samsung.com>, 'Rahul Sharma' <rahul.sharma@samsung.com>, 'Subash Patel' <supash.ramaswamy@linaro.org>, 'Keyyoung Park' <keyyoung.park@samsung.com>, 'Grant Grundler' <grundler@chromium.org>, 'Antonios Motakis' <a.motakis@virtualopensystems.com>, kvmarm@lists.cs.columbia.edu
List-Id: iommu@lists.linux-foundation.org

> -----Original Message-----
> From: Sachin Kamat [mailto:sachin.kamat@linaro.org]
> Sent: Monday, July 29, 2013 3:38 PM
> 
> Hi KyongHo,
> 
> On 26 July 2013 16:58, Cho KyongHo <pullip.cho@samsung.com> wrote:
> > Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
> > ---
> >  .../bindings/iommu/samsung,exynos4210-sysmmu.txt   |  103 +++++++
> >  arch/arm/boot/dts/exynos4.dtsi                     |  122 ++++++++
> >  arch/arm/boot/dts/exynos4210.dtsi                  |   25 ++
> >  arch/arm/boot/dts/exynos4x12.dtsi                  |   76 +++++
> >  arch/arm/boot/dts/exynos5250.dtsi                  |  291 ++++++++++++++++++++
> >  5 files changed, 617 insertions(+), 0 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/iommu/samsung,exynos4210-sysmmu.txt
> 
> This patch does not apply on the mainline Linus' tree (3.11-rc2). Please rebase.
> 

OK. I will rebase the next patches on that.

Thank you.

Cho KyongHo. 
> --
> With warm regards,
> Sachin
