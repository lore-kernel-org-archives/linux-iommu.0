From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] iommu: Remove unused Renesas IPMMU/IPMMUI driver
Date: Mon, 7 Dec 2015 15:24:01 +0900
Message-ID: <20151207062400.GD22834@verge.net.au>
References: <1449244736-22949-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1449244736-22949-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Joerg Roedel <joro@8bytes.org>, Magnus Damm <magnus.damm@gmail.com>, iommu@lists.linux-foundation.org, linux-sh@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Dec 04, 2015 at 04:58:56PM +0100, Geert Uytterhoeven wrote:
> As of commit 44d88c754e57a6d9 ("ARM: shmobile: Remove legacy SoC code
> for R-Mobile A1"), the Renesas IPMMU/IPMMUI driver is no longer used.
> In theory it could still be used on SH-Mobile AG5 and R-Mobile A1 SoCs,
> but that requires adding DT support to the driver, which is not
> planned.
> 
> Remove the driver, it can be resurrected from git history when needed.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

