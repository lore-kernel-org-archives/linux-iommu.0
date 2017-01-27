From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2 2/3] iommu/ipmmu-vmsa: Increase maximum micro-TLBS to
 48
Date: Fri, 27 Jan 2017 12:47:24 +0100
Message-ID: <20170127114724.GI27598@8bytes.org>
References: <148517158986.13306.314435910710426381.sendpatchset@little-apple>
 <148517162908.13306.2467186615655446796.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <148517162908.13306.2467186615655446796.sendpatchset@little-apple>
Sender: linux-kernel-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: iommu@lists.linux-foundation.org, laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, horms+renesas@verge.net.au
List-Id: iommu@lists.linux-foundation.org

On Mon, Jan 23, 2017 at 08:40:29PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
> 
> Bump up the maximum numbers of micro-TLBS to 48.
> 
> Each IPMMU device instance get micro-TLB assignment via
> the "iommus" property in DT. Older SoCs tend to use a
> maximum number of 32 micro-TLBs per IPMMU instance however
> newer SoCs such as r8a7796 make use of up to 48 micro-TLBs.
> 
> At this point no SoC specific handling is done to validate
> the maximum number of micro-TLBs, and because of that the
> DT information is assumed to be within correct range for
> each particular SoC.
> 
> If needed in the future SoC specific feature flags can be
> added to handle the maximum number of micro-TLBs without
> requiring DT changes, however at this point this does not
> seem necessary.
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>

I get a conflict when applying this to v4.10-rc5. What is this based on,
any patches I missed?


	Joerg
