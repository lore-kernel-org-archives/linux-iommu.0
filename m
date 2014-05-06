From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v12 00/31] iommu/exynos: Fixes and Enhancements of System
 MMU driver with DT
Date: Tue, 6 May 2014 19:59:05 +0200
Message-ID: <20140506175904.GB12376@8bytes.org>
References: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
 <26065037.GxQQuIURPg@wuerfel>
 <CAOD6ATqZ5UwRwSKiPDQLrgmX=UUrJVE7ybM_RhXz_CEUjM3W7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOD6ATqZ5UwRwSKiPDQLrgmX=UUrJVE7ybM_RhXz_CEUjM3W7w@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Shaik Ameer Basha <shaik.samsung@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>, Linux DeviceTree <devicetree@vger.kernel.org>, Linux IOMMU <iommu@lists.linux-foundation.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, Prathyush <prathyush.k@samsung.com>, Grant Grundler <grundler@chromium.org>, "supash.ramaswamy" <supash.ramaswamy@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, sunil joshi <joshi@samsung.com>, Sachin Kamat <sachin.kamat@linaro.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Varun Sethi <Varun.Sethi@freescale.com>, Antonios Motakis <a.motakis@virtualopensystems.com>, Cho KyongHo <pullip.cho@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Rahul Sharma <rahul.sharma@samsung.com>
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 30, 2014 at 04:27:10PM +0530, Shaik Ameer Basha wrote:
> This series is going on for quite a long time and most of the patches here
> doesn't depend on dt bindings. As Exynos IOMMU h/w is introducing new versions
> very frequently, maintaining and reviewing all these patches again and
> again is quite a hard job.
> 
> If it is acceptable, I can post one more series with the subset of
> above patches,
> which doesn't depend on dt-bindings. As all the patches which doesn't depend on
> DT bindings are already tested,  I hope merging these subset of patches may help
> in reducing the rework and review effort every time.
> 
> Once we finalize the generic DT bindings for the IOMMU devices, the driver
> can be updated with the proposed DT bindings in mind.

Sounds reasonable to me if the patch subset is self-contained. When
Arnd is OK with that and no one else has objections I can take the
dt-independend parts.


	Joerg
