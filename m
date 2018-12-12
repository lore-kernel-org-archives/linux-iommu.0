From: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH 6/9] iommu/mediatek: Use helper functions to access
 dev->iommu_fwspec
Date: Wed, 12 Dec 2018 21:40:20 +0800
Message-ID: <1544622020.7367.2.camel@mhfsdcap03>
References: <20181211121910.5604-1-joro@8bytes.org>
         <20181211121910.5604-7-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181211121910.5604-7-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Joerg Roedel <jroedel@suse.de>, Sudeep Holla <sudeep.holla@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Robin Murphy <robin.murphy@arm.com>
List-Id: iommu@lists.linux-foundation.org

On Tue, 2018-12-11 at 13:19 +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Use the new helpers dev_iommu_fwspec_get()/set() to access
> the dev->iommu_fwspec pointer. This makes it easier to move
> that pointer later into another struct.
> 
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/iommu/mtk_iommu.c    | 21 ++++++++++++---------
>  drivers/iommu/mtk_iommu_v1.c | 28 ++++++++++++++++------------
>  2 files changed, 28 insertions(+), 21 deletions(-)

Tested-by: Yong Wu <yong.wu@mediatek.com>
