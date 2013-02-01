From: Joerg Roedel <joro@8bytes.org>
Subject: Re: IO_PAGE_FAULTs on unity mapped regions during amd_iommu_init()
 in Linux 3.4
Date: Fri, 1 Feb 2013 14:00:35 +0100
Message-ID: <20130201130035.GE25591@8bytes.org>
References: <1359657210.6061.3.camel@lorien2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1359657210.6061.3.camel@lorien2>
Sender: stable-owner@vger.kernel.org
To: Shuah Khan <shuah.khan@hp.com>
Cc: LKML <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>, iommu@lists.linux-foundation.org, shuahkhan@gmail.com
List-Id: iommu@lists.linux-foundation.org

Hi Shuah,

On Thu, Jan 31, 2013 at 11:33:30AM -0700, Shuah Khan wrote:
> Access to these ranges continues to work with no errors until AMD IOMMU
> driver disables and re-enables IOMMU in enable_iommus(). These faults
> don't persist and appear between the enable_iommus() call and before
> amd_iommu_init() gets done printing "AMD-Vi: Lazy IO/TLB flushing
> enabled" message.

Hmm, okay. I had a look into the v3.4 sources. This looks like a race
condition. The IOMMUs are enabled in amd_iommu_init_hardware() but the
unity-mapped regions are created later in amd_iommu_init_dma_ops(). This
leaves a small window where the page-faults happen that you see.

But I am not sure why this doesn't hit on 3.7 and above. The race is
still there. Anyway, definitly something that needs to be fixed.


	Joerg
