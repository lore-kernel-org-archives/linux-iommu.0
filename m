From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [v2 1/1] iommu/tegra: smmu: Change SMMU's dependency on
 ARCH_TEGRA
Date: Mon, 4 Feb 2013 20:56:56 +0100
Message-ID: <20130204195655.GB15278@8bytes.org>
References: <1359628988-3678-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1359628988-3678-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 31, 2013 at 12:43:08PM +0200, Hiroshi Doyu wrote:
> Theoretically TEGRA_IOMMU_SMMU depends on ARCH_TEGRA_3x_SOC and
> ARCH_TEGRA_114_SOC only. This patch allows a Tegra20 only kernel to
> enable SMMU(Tegra20 doesn't have a SMMU), which could avoid editing
> this Kconfig entry every time we add a new chip later.
> 
> Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Applied to arm/tegra, thanks.
