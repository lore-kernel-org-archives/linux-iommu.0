From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH v8 07/12] iommu/exynos: support for device tree
Date: Sat, 27 Jul 2013 16:06:40 +0200
Message-ID: <1743111.Ek7FldnHal@flatron>
References: <003d01ce89f3$44ec2cf0$cec486d0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <003d01ce89f3$44ec2cf0$cec486d0$@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Cho KyongHo <pullip.cho@samsung.com>
Cc: 'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>, 'Hyunwoong Kim' <khw0178.kim@samsung.com>, 'Prathyush' <prathyush.k@samsung.com>, 'Grant Grundler' <grundler@chromium.org>, 'Joerg Roedel' <joro@8bytes.org>, 'Keyyoung Park' <keyyoung.park@samsung.com>, 'Subash Patel' <supash.ramaswamy@linaro.org>, 'Linux Kernel' <linux-kernel@vger.kernel.org>, 'Sachin Kamat' <sachin.kamat@linaro.org>, 'Linux IOMMU' <iommu@lists.linux-foundation.org>, 'Kukjin Kim' <kgene.kim@samsung.com>, 'Antonios Motakis' <a.motakis@virtualopensystems.com>, kvmarm@lists.cs.columbia.edu, 'Linux ARM Kernel' <linux-arm-kernel@lists.infradead.org>, 'Rahul Sharma' <rahul.sharma@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Hi,

On Friday 26 of July 2013 20:28:36 Cho KyongHo wrote:
> This commit adds device tree support for System MMU.
> This also include the following changes and enhancements:
> 
> * use managed device helper functions.
> Simplyfies System MMU device driver.
> 
> * use only a single clock descriptor.
> System MMU device descriptor is seperate if it is imposible to make
> a single clock descriptor to make a device descriptor for a group of
> System MMUs.
> 
> * removed dbgname member from sysmmu_drvdata structure.
> debugging kernel message for a System MMU is distinguisheable with the
> name of device descroptors.
> 
> Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
> ---
>  drivers/iommu/Kconfig        |    5 +-
>  drivers/iommu/exynos-iommu.c |  182
> ++++++++++++++++-------------------------- 2 files changed, 70
> insertions(+), 117 deletions(-)

Whenever you introduce or modify (extend) a device tree binding please 
don't forget about reflecting that in documentation 
(Documentation/devicetree/bindings) and CCing devicetree mailing list 
(devicetree@vger.kernel.org). Both of these steps are necessary to get any 
device tree stuff merged.

Best regards,
Tomasz
