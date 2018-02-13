From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu: Do not return error code for APIs with size_t
 return type
Date: Tue, 13 Feb 2018 19:33:14 +0100
Message-ID: <20180213183313.cu7nsjauuhvorzg2@8bytes.org>
References: <1517827553-81034-1-git-send-email-suravee.suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1517827553-81034-1-git-send-email-suravee.suthikulpanit@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, jroedel@suse.de, alex.williamson@redhat.com
List-Id: iommu@lists.linux-foundation.org

On Mon, Feb 05, 2018 at 05:45:53AM -0500, Suravee Suthikulpanit wrote:
> Currently, iommu_unmap, iommu_unmap_fast and iommu_map_sg return
> size_t.  However, some of the return values are error codes (< 0),
> which can be misinterpreted as large size. Therefore, returning size 0
> instead to signify failure to map/unmap.
> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
> 
> Note: This issue was previously discussed here (https://lkml.org/lkml/2018/1/30/873).
> 
>  drivers/iommu/amd_iommu.c |  2 +-
>  drivers/iommu/iommu.c     |  6 +++---
>  include/linux/iommu.h     | 14 +++++++-------
>  3 files changed, 11 insertions(+), 11 deletions(-)

Yeah, I am not happy with this, but the alternatives aren't any
better... So I applied this one. Thanks!


	Joerg
