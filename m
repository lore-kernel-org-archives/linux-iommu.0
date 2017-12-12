From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 0/2] iommu/tegra: Add IOMMU group support
Date: Tue, 12 Dec 2017 14:57:26 -0700
Message-ID: <20171212145717.05d49e60@t450s.home>
References: <20171127095055.21486-1-thierry.reding@gmail.com>
        <20171127095343.GA21584@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171127095343.GA21584@ulmo>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, 27 Nov 2017 10:53:43 +0100
Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> On Mon, Nov 27, 2017 at 10:50:53AM +0100, Thierry Reding wrote:
> > From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > 
> > Hi Joerg,
> > 
> > Both patches in this series are built-time dependent and therefore it
> > would be easiest if they went in via the same tree (either the IOMMU
> > tree, or the Tegra tree with your Acked-by on patch 1). Alternatively,
> > I could put patch two in a separate branch and provide a stable tag for
> > you to pull in, in order to resolve the dependency.
> > 
> > Do you have any preference?
> > 
> > Thierry
> > 
> > Thierry Reding (2):
> >   iommu/tegra: Allow devices to be grouped
> >   memory: tegra: Create SMMU display groups  
> 
> I just realized that these are actually in the wrong order. The second
> patch adds the data fields that the first patch uses. Depending on which
> merge strategy you prefer I can reorder when applying or resend in the
> correct order.


Hi Thierry,

Joerg is on paternity leave through the end of the year and I'm
handling the IOMMU tree in the interim.  Given the low traffic on
iommu/tegra-smmu.c, I'm going to suggest we take the merge path through
the Tegra tree and I'll Ack the first patch to help that along.  Please
do the necessary re-order when applying.  Thanks,

Alex
