From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v3 0/4] Optimise 64-bit IOVA allocations
Date: Wed, 30 Aug 2017 14:14:16 +0200
Message-ID: <20170830121416.GI19533@8bytes.org>
References: <cover.1503412074.git.robin.murphy@arm.com>
 <633f0432-cab2-7280-555a-7468fc448d2d@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <633f0432-cab2-7280-555a-7468fc448d2d@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nate Watterson <nwatters@codeaurora.org>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, thunder.leizhen@huawei.com, ard.biesheuvel@linaro.org, ray.jui@broadcom.com
List-Id: iommu@lists.linux-foundation.org

Hey Robin, Nate,

On Fri, Aug 25, 2017 at 02:52:41PM -0400, Nate Watterson wrote:
> Tested-by: Nate Watterson <nwatters@codeaurora.org>

If nobody has objections here anymore I would merge these patches when
v4.14-rc1 is released. Given that these changes are a bit more intrusive
and the code is shared between a couple of drivers, I'd like to give it
more testing in linux-next.

Robin, can you rebase these patches to v4.14-rc1 when it is released,
add Nate's Tested-by, and resend them to me please?

Thanks,

	Joerg
