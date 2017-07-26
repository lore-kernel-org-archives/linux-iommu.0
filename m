From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/4] IOMMU group cleanup
Date: Wed, 26 Jul 2017 13:12:23 +0200
Message-ID: <20170726111223.GO15833@8bytes.org>
References: <cover.1500637633.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <cover.1500637633.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, architt-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On Fri, Jul 21, 2017 at 01:12:34PM +0100, Robin Murphy wrote:
> Robin Murphy (4):
>   iommu/msm: Add iommu_group support
>   iommu/tegra-smmu: Add iommu_group support
>   iommu/tegra-gart: Add iommu_group support
>   iommu: Finish making iommu_group support mandatory
> 
>  drivers/iommu/iommu.c      | 19 ++++---------------
>  drivers/iommu/msm_iommu.c  | 15 ++++++++++++++-
>  drivers/iommu/tegra-gart.c | 19 +++++++++++++++++++
>  drivers/iommu/tegra-smmu.c |  9 +++++++++
>  4 files changed, 46 insertions(+), 16 deletions(-)

Thanks for this series, much appreciated! I'll wait for the testing
results and apply them when all looks good.


Thanks,

	Joerg
