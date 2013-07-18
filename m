From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH v2 22/22] ARM: dma-mapping: Drop GFP_COMP for DMA memory
 allocations
Date: Thu, 18 Jul 2013 14:45:11 -0600
Message-ID: <51E853D7.4070200@wwwdotorg.org>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com> <1373021097-32420-23-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1373021097-32420-23-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 07/05/2013 04:44 AM, Hiroshi Doyu wrote:
> arm_iommu_alloc_attrs wants to split pages after allocation in order
> to reduce the memory footprint. This does not work well with GFP_COMP
> pages, so drop this flag before allocation.
> 
> (ref: ea2e7057c0234cfb8b09467d8f137760d371fc72)

Include the commit description too, so people have a clue what that
commit is.

Presumably this fix can go through the core ARM tree independently from
this series? Or, will this series cause problems if applied without this
patch being applied first?

BTW, I don't see anything in this series that adds the mandatory
properties to DT for all this to work. I assume if I just apply this
series, everything will blow up? If so, it's usual to say "[PATCH RFC"
rather than "[PATCH" in the email subject.
