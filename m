From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/4] iommu/tegra: Setup aperture
Date: Tue, 31 Mar 2015 15:35:21 +0200
Message-ID: <20150331133521.GB22683@8bytes.org>
References: <1427450847-17719-1-git-send-email-thierry.reding@gmail.com>
 <1427450847-17719-2-git-send-email-thierry.reding@gmail.com>
 <20150327101935.GB17976@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150327101935.GB17976-AwZRO8vwLAwmlAP/+Wk3EA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Mar 27, 2015 at 11:19:36AM +0100, Thierry Reding wrote:
> I also just realized that this hunk conflicts with the IOMMU domain
> alloc/free series that you sent out yesterday. Were you planning on
> merging that series for 4.1? If so I can regenerate these patches on
> top of your series.

Yes, I just merged the series. But please just base these patches on
plain v4.0-rc6, so I can put them into a seperate branch. I'll try to
solve the conflict then by myself.


	Joerg
