From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 05/12] memory: Add NVIDIA Tegra memory controller
 support
Date: Wed, 12 Nov 2014 16:02:34 +0100
Message-ID: <20141112150233.GW10744@8bytes.org>
References: <1415376063-17205-1-git-send-email-thierry.reding@gmail.com>
 <1415376063-17205-6-git-send-email-thierry.reding@gmail.com>
 <20141112142150.GV10744@8bytes.org>
 <20141112144715.GD26488@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141112144715.GD26488@ulmo>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, David Riley <davidriley-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Nov 12, 2014 at 03:47:16PM +0100, Thierry Reding wrote:
> The SMMU is part of a larger IP block that's also a memory controller.
> Having it in drivers/iommu would mean that we need to provide a
> mechanism to synchronize between the two drivers. They also share a
> number of data tables, so that would need to be shared somehow as well.
> By keeping both in the same directory we don't have to expose any of
> this publicly.

Since these parts are in different files you export the interfaces
anyway through non-static symbols and those dependencys also exist for
other IOMMU drivers. So I prefer this file to live in drivers/iommu.


	Joerg
