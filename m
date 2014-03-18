From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH v11 10/27] iommu/exynos: use managed device helper
 functions
Date: Wed, 19 Mar 2014 08:59:09 +0900
Message-ID: <001201cf4306$0e16e540$2a44afc0$%han@samsung.com>
References: <20140314140542.f4ded6c50dbd8a1d937bf354@samsung.com>
 <53230404.6070601@samsung.com>
 <20140318193817.3448387b75e109e814b9c025@samsung.com>
 <5328625B.508@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <5328625B.508@samsung.com>
Content-language: ko
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: 'Tomasz Figa' <t.figa@samsung.com>, 'Cho KyongHo' <pullip.cho@samsung.com>
Cc: 'Linux DeviceTree' <devicetree@vger.kernel.org>, 'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>, 'Prathyush' <prathyush.k@samsung.com>, 'Grant Grundler' <grundler@chromium.org>, 'Joerg Roedel' <joro@8bytes.org>, 'Jingoo Han' <jg1.han@samsung.com>, 'Linux Kernel' <linux-kernel@vger.kernel.org>, 'Sachin Kamat' <sachin.kamat@linaro.org>, 'Linux IOMMU' <iommu@lists.linux-foundation.org>, 'Kukjin Kim' <kgene.kim@samsung.com>, 'Sylwester Nawrocki' <s.nawrocki@samsung.com>, 'Varun Sethi' <Varun.Sethi@freescale.com>, 'Antonios Motakis' <a.motakis@virtualopensystems.com>, 'Linux ARM Kernel' <linux-arm-kernel@lists.infradead.org>, 'Rahul Sharma' <rahul.sharma@samsung.com>
List-Id: iommu@lists.linux-foundation.org

On Wednesday, March 19, 2014 12:12 AM, Tomasz Figa wrote:
> On 18.03.2014 11:38, Cho KyongHo wrote:
> > On Fri, 14 Mar 2014 14:28:36 +0100, Tomasz Figa wrote:
> >> On 14.03.2014 06:05, Cho KyongHo wrote:
> >>> This patch uses managed device helper functions in the probe().
> >>>
> >>> Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
> >>> ---
> >>>    drivers/iommu/exynos-iommu.c |   64 +++++++++++++++++-------------------------
> >>>    1 file changed, 26 insertions(+), 38 deletions(-)
> >>>
> >>> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> >>> index 36e6b73..33b424d 100644
> >>> --- a/drivers/iommu/exynos-iommu.c
> >>> +++ b/drivers/iommu/exynos-iommu.c

[.....]

> >>>    	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >>>    	if (!res) {
> >>> -		dev_dbg(dev, "Unable to find IOMEM region\n");
> >>> -		ret = -ENOENT;
> >>> -		goto err_init;
> >>> +		dev_err(dev, "Unable to find IOMEM region\n");
> >>> +		return -ENOENT;
> >>>    	}
> >>
> >> No need to check for error and print message, because
> >> devm_ioremap_resource() already checks the passed resource and handles
> >> error cases.
> >>
> >
> > Yes but devm_ioremap_resource() just tells that the given 'res' is not
> > correct. I think the message in the driver is more informative.
> 
> The common practice used in Linux kernel is to not duplicate such
> messages. It is obvious that devm_ioremap_resource() printing such
> message is related to an IOMEM resource anyway, as you can't used it
> with other types of resources.

+1

I agree with Tomasz Figa's opinion.
These messages have been being removed from Linux kernel.
Thank you.

Best regards,
Jingoo Han
