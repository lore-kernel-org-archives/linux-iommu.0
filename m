From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 1/1] iommu/tegra: smmu: Fix unsleepable memory allocation
Date: Wed, 27 Jun 2012 10:59:48 -0600
Message-ID: <4FEB3C04.6040606@wwwdotorg.org>
References: <20120627.124628.673793050413876363.hdoyu@nvidia.com> <1340790841-23349-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1340790841-23349-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 06/27/2012 03:54 AM, Hiroshi DOYU wrote:
> allo_pdir() is called in smmu_iommu_domain_init() with spin_lock
> held. memory allocations in it have to be atomic/unsleepable.

Presumably this will cause allocation failures in situations with heavy
memory pressure, rather than triggering swapping. Is it normal for IOMMU
drivers to work that way? If so, I'm fine with it. Otherwise, can the
allocations be performed before the spinlock is taken?
