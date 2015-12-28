From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Don't truncate ttbr if LPAE is not
 enabled
Date: Mon, 28 Dec 2015 17:12:03 +0100
Message-ID: <20151228161203.GC17673@8bytes.org>
References: <1450810866-4716-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1450810866-4716-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>, iommu@lists.linux-foundation.org, linux-sh@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Dec 22, 2015 at 08:01:06PM +0100, Geert Uytterhoeven wrote:
>  static int ipmmu_domain_init_context(struct ipmmu_vmsa_domain *domain)
>  {
> -	phys_addr_t ttbr;
> +	u64 ttbr;
>  	u32 tmp;
>  	int ret;

Didn't apply cleanly to v4.4-rc7, but fixed it up and queued it to
iommu/fixes.
