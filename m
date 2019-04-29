From: Joerg Roedel <jroedel@suse.de>
Subject: Re: "iommu/amd: Set exclusion range correctly" causes smartpqi
 offline
Date: Mon, 29 Apr 2019 16:23:26 +0200
Message-ID: <20190429142326.GA4678@suse.de>
References: <1556290348.6132.6.camel@lca.pw>
 <20190426152632.GC3173@suse.de>
 <1556294112.6132.7.camel@lca.pw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1556294112.6132.7.camel@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
To: Qian Cai <cai@lca.pw>
Cc: iommu@lists.linux-foundation.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Apr 26, 2019 at 11:55:12AM -0400, Qian Cai wrote:
> https://git.sr.ht/~cai/linux-debug/blob/master/dmesg

Thanks, I can't see any definitions for unity ranges or exclusion ranges
in the IVRS table dump, which makes it even more weird.

Can you please send me the output of

	for f in `ls -1 /sys/kernel/iommu_groups/*/reserved_regions`; do echo "---$f"; cat $f;done

to double-check?

Thanks,

	Joerg
