From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/4] IOMMU group cleanup
Date: Fri, 11 Aug 2017 17:21:25 +0200
Message-ID: <20170811152124.GH30515@8bytes.org>
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

On Fri, Jul 21, 2017 at 01:12:34PM +0100, Robin Murphy wrote:
> Hi all,
> 
> Prompted by some discussion around the questionable usefulness of
> iommu_present() for SoC topologies, I took a look at what was left to
> finish off the intention of making groups mandatory. Turns out it
> wasn't much, so here it is. As well as the general rationalisation
> aspect, between this and the probe-deferral changes in 4.12, we should
> now be able to rely on the presence of a group unambiguously indicating
> whether a given device is associated with an IOMMU or not.
> 
> Robin.
> 
> Robin Murphy (4):
>   iommu/msm: Add iommu_group support
>   iommu/tegra-smmu: Add iommu_group support
>   iommu/tegra-gart: Add iommu_group support
>   iommu: Finish making iommu_group support mandatory

Applied, thanks Robin.
