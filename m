From: "Jon Medhurst (Tixy)" <tixy@linaro.org>
Subject: Re: [PATCH] iommu/arm-smmu: add a shortcut when the @dev_node is
 NULL
Date: Wed, 20 Jan 2016 16:00:01 +0000
Message-ID: <1453305601.3417.12.camel@linaro.org>
References: <1452564905-2662-1-git-send-email-shijie.huang@arm.com>
	 <20160120120225.GD18805@8bytes.org>
	 <20160120133401.GA3487@localhost.localdomain> <569F9DCA.3030808@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <569F9DCA.3030808@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Huang Shijie <shijie.huang@arm.com>, Joerg Roedel <joro@8bytes.org>, will.deacon@arm.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Wed, 2016-01-20 at 14:46 +0000, Robin Murphy wrote:
> > Of course, the 0.004014s maybe not accurate enough, it is just an
> > approximate number.
> 
> A mean and standard deviation of at least, say, 5 runs each with and 
> without the patch would be considerably more meaningful (even if
> still 
> far from statistically significant).

It wouldn't surprise me if replacing the proposed change with an 'asm
volatile("nop")' or two also give a boot time delta of several
milliseconds (due to change in cache line alignment of functions). I
don't believe you can reliably measure such minor changes.

It doesn't mean that the proposed change isn't a good addition though,
it obviously results in less code getting executed for the cost of one
or two instructions for a compare and branch. 

-- 
Tixy
