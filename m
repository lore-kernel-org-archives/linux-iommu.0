From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [v2 1/1] iommu/tegra: smmu: Change SMMU's dependency on
 ARCH_TEGRA
Date: Mon, 4 Feb 2013 09:27:32 +0100
Message-ID: <20130204.102732.652026294649237107.hdoyu@nvidia.com>
References: <1359628988-3678-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1359628988-3678-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote @ Thu, 31 Jan 2013 11:43:08 +0100:

> Theoretically TEGRA_IOMMU_SMMU depends on ARCH_TEGRA_3x_SOC and
> ARCH_TEGRA_114_SOC only. This patch allows a Tegra20 only kernel to
> enable SMMU(Tegra20 doesn't have a SMMU), which could avoid editing
> this Kconfig entry every time we add a new chip later.

Is there any chance to get this patch merged in v3.9?

Also there's another patch for v3.9:
  [v2 1/1] iommu/tegra: smmu: Change SMMU's dependency on ARCH_TEGRA
  http://lists.linuxfoundation.org/pipermail/iommu/2013-January/005129.html
