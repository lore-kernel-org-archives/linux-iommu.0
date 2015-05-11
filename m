From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu: exynos: tell kmemleak to ignore 2nd level page
 tables
Date: Mon, 11 May 2015 18:50:09 +0200
Message-ID: <20150511165008.GB10216@8bytes.org>
References: <20150509000544.GA29904@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150509000544.GA29904@dtor-ws>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Dmitry Torokhov <dtor@chromium.org>
Cc: Kukjin Kim <kgene@kernel.org>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, Colin Cross <ccross@android.com>, Doug Anderson <dianders@chromium.org>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Fri, May 08, 2015 at 05:05:44PM -0700, Dmitry Torokhov wrote:
> From: Colin Cross <ccross@android.com>
> 
> The pointers to the 2nd level page tables are converted to 1st level
> page table entries, which means kmemleak can't find them and assumes
> they have been leaked.  Call kmemleak_ignore on the 2nd level page
> tables to prevent them from showing up in kmemleak reports.
> 
> Signed-off-by: Colin Cross <ccross@android.com>
> Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
> ---
>  drivers/iommu/exynos-iommu.c | 1 +
>  1 file changed, 1 insertion(+)

Applied to arm/exynos, thanks.
