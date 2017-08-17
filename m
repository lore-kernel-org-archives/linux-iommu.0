From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 00/13] Introduce IOMMU-API TLB Flushing Interface
Date: Thu, 17 Aug 2017 16:43:08 +0200
Message-ID: <20170817144308.GI16908@8bytes.org>
References: <1502974596-23835-1-git-send-email-joro@8bytes.org>
 <20170817083520.3329c0ff@w520.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170817083520.3329c0ff@w520.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
List-Id: iommu@lists.linux-foundation.org

Hi Alex,

On Thu, Aug 17, 2017 at 08:35:20AM -0600, Alex Williamson wrote:
> Wouldn't it be much more friendly to downstreams and out-of-tree
> drivers to introduce new functions for the async semantics?  ie.
> iommu_map_async(), etc.  The API also seems a little cleaner that
> iommu_map() stands alone, it's synchronous, iommu_map_async() is
> explicitly asynchronous and a _flush() call is needed to finalize it.
> What do you see as the advantage to the approach here?  Thanks,

The reason I did it this way was that I want the iommu_map(),
iommu_unmap(), and iomu_map_sg() functions be considered the _default_
to chose when using the IOMMU-API, because their use is faster than
using the _sync() variants. Or in other words, I want the _sync function
names to imply that they are slower versions of the default ones.


Regards,

	Joerg
