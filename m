From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2] iommu/arm-smmu: Break insecure users by disabling
 bypass by default
Date: Thu, 4 Apr 2019 16:00:05 +0100
Message-ID: <20190404145957.GA25912@fuggles.cambridge.arm.com>
References: <20190301192017.39770-1-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190301192017.39770-1-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Douglas Anderson <dianders@chromium.org>
Cc: Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, linux-arm-msm@vger.kernel.org, Vivek Gautam <vivek.gautam@codeaurora.org>, Rob Clark <robdclark@gmail.com>, evgreen@chromium.org, tfiga@chromium.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Mar 01, 2019 at 11:20:17AM -0800, Douglas Anderson wrote:
> If you're bisecting why your peripherals stopped working, it's
> probably this CL.  Specifically if you see this in your dmesg:
>   Unexpected global fault, this could be serious
> ...then it's almost certainly this CL.
> 
> Running your IOMMU-enabled peripherals with the IOMMU in bypass mode
> is insecure and effectively disables the protection they provide.
> There are few reasons to allow unmatched stream bypass, and even fewer
> good ones.
> 
> This patch starts the transition over to make it much harder to run
> your system insecurely.  Expected steps:
> 
> 1. By default disable bypass (so anyone insecure will notice) but make
>    it easy for someone to re-enable bypass with just a KConfig change.
>    That's this patch.
> 
> 2. After people have had a little time to come to grips with the fact
>    that they need to set their IOMMUs properly and have had time to
>    dig into how to do this, the KConfig will be eliminated and bypass
>    will simply be disabled.  Folks who are truly upset and still
>    haven't fixed their system can either figure out how to add
>    'arm-smmu.disable_bypass=n' to their command line or revert the
>    patch in their own private kernel.  Of course these folks will be
>    less secure.
> 
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
> Changes in v2:
> - Flipped default to 'yes' and changed comments a lot.
> 
>  drivers/iommu/Kconfig    | 25 +++++++++++++++++++++++++
>  drivers/iommu/arm-smmu.c |  3 ++-
>  2 files changed, 27 insertions(+), 1 deletion(-)

Cheers, I'll pick this one up for 5.2.

Will
