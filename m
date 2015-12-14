From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 4/4] iommu/vt-d: Do access checks before calling
 handle_mm_fault()
Date: Mon, 14 Dec 2015 15:41:42 +0100
Message-ID: <20151214144142.GG8412@suse.de>
References: <1447773099-2444-1-git-send-email-joro@8bytes.org>
 <1447773099-2444-5-git-send-email-joro@8bytes.org>
 <1448033753.89124.19.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1448033753.89124.19.camel@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Nov 20, 2015 at 03:35:53PM +0000, David Woodhouse wrote:
> Acked-By: David Woodhouse <David.Woodhouse@intel.com>
> 
> As noted, I can't test it right now until I've replaced my test
> hardware. Certainly looks better than the last version though :)

Okay, thanks. I applied the series to the iommu tree. Patch 1 and 4 as
fixes, the others the the x86/amd branch.
