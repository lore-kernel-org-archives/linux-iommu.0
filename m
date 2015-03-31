From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/4] iommu/tegra-smmu: Add debugfs support
Date: Tue, 31 Mar 2015 17:02:14 +0200
Message-ID: <20150331150214.GE22683@8bytes.org>
References: <1427450847-17719-1-git-send-email-thierry.reding@gmail.com>
 <20150327101539.GA17976@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150327101539.GA17976-AwZRO8vwLAwmlAP/+Wk3EA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Thierry,

On Fri, Mar 27, 2015 at 11:15:41AM +0100, Thierry Reding wrote:
> Another possibility would be for you to ack this patch so that I can
> take it into the same branch as the dependency. The remainder of this
> series doesn't depend on either of the two patches, so they should be
> fine for you to take into your tree.

This solution sounds like the best one. You have my

	Acked-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

on the first patch. I merged patches 2-4 into the arm/tegra branch. As
you noticed there were conflict merging the branch into next. Please
have a look into my solution for that when I pushed it out later today
and let me know if it looks good and still works.


	Joerg
