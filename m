From: "Kinney, Steven" <Steven.Kinney@amd.com>
Subject: RE: [PATCH 1/1] iommuv2/amd: Enable Performance Counters On Family
 15h Models 10h-1Fh
Date: Thu, 6 Dec 2012 17:07:49 +0000
Message-ID: <57D41218901B4442B4AFF404D215911636E15F@sausexdag02.amd.com>
References: <1354659546-9700-1-git-send-email-steven.kinney@amd.com>
 <20121206103238.GF1806@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121206103238.GF1806@8bytes.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Hiroshi DOYU <hdoyu@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Jiri Kosina <jkosina@suse.cz>, Kukjin Kim <kgene.kim@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

                       I see your point(s).  First, to the second point, I should (and will) add a check to the AMD Family/Model coupled to this change.  Also, I will append the patch(es) to include the perf IOMMU PMU so that this change is put into context.

Thanks for your time and advise.

Best Regards,

Steve

-----Original Message-----
From: Joerg Roedel [mailto:joro@8bytes.org] 
Sent: Thursday, December 06, 2012 4:33 AM
To: Kinney, Steven
Cc: Hiroshi DOYU; Stephen Warren; Jiri Kosina; Kukjin Kim; linux-kernel@vger.kernel.org; iommu@lists.linux-foundation.org
Subject: Re: [PATCH 1/1] iommuv2/amd: Enable Performance Counters On Family 15h Models 10h-1Fh

On Tue, Dec 04, 2012 at 04:19:06PM -0600, Steven Kinney wrote:
>  drivers/iommu/Kconfig           |   10 +++++
>  drivers/iommu/amd_iommu_init.c  |   85 +++++++++++++++++++++++++++++++++++++++
>  drivers/iommu/amd_iommu_types.h |   13 +++++-
>  3 files changed, 107 insertions(+), 1 deletion(-)

So first of all, this patch alone doesn't make sense. You should submit it in a patch-set that enabled IOMMUv2 performance counters for the end-user. This means together with the PMU implementation and tools support.

Further I don't see how this patch is specific to Family 15h Models 10h-1Fh as described in the subject-line.

Any comments on these two points?

Cheers,

	Joerg
