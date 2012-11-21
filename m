From: Kukjin Kim <kgene.kim@samsung.com>
Subject: Re: [PATCH v3 02/12] ARM: EXYNOS: Add clk_ops for gating clocks of
 System MMU
Date: Thu, 22 Nov 2012 00:50:31 +0900
Message-ID: <50ACF847.3070709@samsung.com>
References: <002801cdc7a5$8535f6d0$8fa1e470$%cho@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <002801cdc7a5$8535f6d0$8fa1e470$%cho@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Cho KyongHo <pullip.cho@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 'Joerg Roedel' <joro@8bytes.org>, sw0312.kim@samsung.com, 'Sanghyun Lee' <sanghyun75.lee@samsung.com>, 'Kukjin Kim' <kgene.kim@samsung.com>, 'Subash Patel' <subash.ramaswamy@linaro.org>, prathyush.k@samsung.com, rahul.sharma@samsung.com
List-Id: iommu@lists.linux-foundation.org

On 11/21/12 14:03, Cho KyongHo wrote:
> Touching some System MMU needs its master devices' clock to be enabled
> before. This commit adds clk_ops.set_parent of gating clocks of System
> MMU to ensure gating clocks of System MMU's mater devices are enabled
> when enabling gating clocks of System MMU.
>
> Change-Id: Icd58b12f599e92692c032516331a444f4703ba6b

Same here, we don't need this :-)

> Signed-off-by: KyongHo Cho<pullip.cho@samsung.com>
> ---
>   arch/arm/mach-exynos/clock-exynos5.c | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
>

Looks good to me, and I think, this can be applied independently from 
this series. Will apply with removing 'Change-Id'.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
