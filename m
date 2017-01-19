From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v8 4/9] iommu/amd: Introduce amd_iommu_get_num_iommus()
Date: Thu, 19 Jan 2017 19:41:47 +0100
Message-ID: <20170119184147.uiqqoyhgiw2poen5@pd.tnic>
References: <1484551416-5440-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1484551416-5440-5-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1484551416-5440-5-git-send-email-Suravee.Suthikulpanit@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, joro@8bytes.org, peterz@infradead.org, mingo@redhat.com
List-Id: iommu@lists.linux-foundation.org

On Mon, Jan 16, 2017 at 01:23:31AM -0600, Suravee Suthikulpanit wrote:
> Introduce amd_iommu_get_num_iommus(), which returns the value of
> amd_iommus_present, then replaces the direct access to the variable
		     ^
		   which

> which is now declared as static.
> 
> This function will also be used by Perf AMD IOMMU driver.
> 
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Joerg Roedel <joro@8bytes.org>
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> ---
>  arch/x86/events/amd/iommu.h     |  2 ++
>  drivers/iommu/amd_iommu.c       |  6 +++---
>  drivers/iommu/amd_iommu_init.c  | 11 +++++++++--
>  drivers/iommu/amd_iommu_proto.h |  1 +
>  drivers/iommu/amd_iommu_types.h |  3 ---
>  5 files changed, 15 insertions(+), 8 deletions(-)

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
