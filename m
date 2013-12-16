From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCHv7 07/12] iommu/tegra: smmu: register device to iommu dynamically
Date: Mon, 16 Dec 2013 11:46:56 -0700
Message-ID: <52AF4AA0.60006@wwwdotorg.org>
References: <1386835033-4701-1-git-send-email-hdoyu@nvidia.com> <1386835033-4701-8-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1386835033-4701-8-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 12/12/2013 12:57 AM, Hiroshi Doyu wrote:
> platform_devices are registered as IOMMU'able dynamically via
> add_device() and remove_device().

That says {add,remove}_device() ...

> Tegra SMMU can have multiple address spaces(AS). IOMMU'able devices
> can belong to one of them. Multiple IOVA maps are created at boot-up,
> which can be attached to devices later. We reserve 2 of them for
> static assignment, AS[0] for system default, AS[1] for AHB clusters as
> protected domain from others, where there are many traditional
> pheripheral devices like USB, SD/MMC. They should be isolated from
> some smart devices like host1x for system robustness. Even if smart
> devices behaves wrongly, the traditional devices(SD/MMC, USB) wouldn't
> be affected, and the system could continue most likely. DMA API(ARM)
> needs ARM_DMA_USE_IOMMU to be enabled.
> 
> Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
> v6:
> Use smmu_iommu_{bound,unbind}_driver() instead of
> smmu_iommu_{add,del}_device() to register devices to SMMU.

... yet that says it's been changed to {bound,unbind}_driver(). BTW,
what was the reason for this change?
