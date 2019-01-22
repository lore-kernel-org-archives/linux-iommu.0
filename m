From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu: amd: call free_iova_fast with pfn in map_sg
Date: Tue, 22 Jan 2019 11:57:47 +0100
Message-ID: <20190122105747.qnelpj6xx6gp5dh7@8bytes.org>
References: <20190117192902.15158-1-jsnitsel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190117192902.15158-1-jsnitsel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerry Snitselaar <jsnitsel@redhat.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 17, 2019 at 12:29:02PM -0700, Jerry Snitselaar wrote:
> In the error path of map_sg, free_iova_fast is being called with
> address instead of the pfn. This results in a bad value getting into
> the rcache, and can result in hitting a BUG_ON when
> iova_magazine_free_pfns is called.
> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>

Applied, thanks.
