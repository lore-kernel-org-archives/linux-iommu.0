From: "Frank Wunderlich" <frank-w@public-files.de>
Subject: Aw: Re: [BUG] "access dev->iommu_fwspec" cause crash on BPI-R2
Date: Tue, 22 Jan 2019 18:11:53 +0100
Message-ID: <trinity-72bd264f-d4e0-444d-ac33-b708a0fc6503-1548177113835@3c-app-gmx-bs21>
References: <trinity-76e7f2ce-27ce-4f3b-809f-7da9a35e5210-1548173349245@3c-app-gmx-bs21>
 <20190122164916.r343pqa2dtopzrxo@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190122164916.r343pqa2dtopzrxo@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, Ryder Lee <ryder.lee@mediatek.com>
List-Id: iommu@lists.linux-foundation.org

Hi,

thanks for quick reply, this seems to fix it

no crash, xserver works, like revert of the commit...pushed the fix to below github-repo

regards Frank


> Gesendet: Dienstag, 22. Januar 2019 um 17:49 Uhr
> Von: "Joerg Roedel" <joro@8bytes.org>
> An: "Frank Wunderlich" <frank-w@public-files.de>
> Cc: "Matthias Brugger" <matthias.bgg@gmail.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, "Ryder Lee" <ryder.lee@mediatek.com>
> Betreff: Re: [BUG] "access dev->iommu_fwspec" cause crash on BPI-R2
>
> Hi Frank,
> 
> thanks for the report!
> 
> On Tue, Jan 22, 2019 at 05:09:09PM +0100, Frank Wunderlich wrote:
> > Hi,
> > 
> > the following Patch breaks hdmi (at least) on Bananapi R2 (mt7623):
> > 
> > a9bf2eec5a6fc01a0a5250eaf0bf61dfd382a78a "iommu/mediatek: Use helper functions to access dev->iommu_fwspec"
> 
> Does the attached diff fix the issue for you?
> 
> Thanks,
> 
> 	Joerg
> 
> diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
> index 6ede4286b835..f60bdb85c4c0 100644
> --- a/drivers/iommu/mtk_iommu_v1.c
> +++ b/drivers/iommu/mtk_iommu_v1.c
> @@ -442,6 +442,10 @@ static int mtk_iommu_add_device(struct device *dev)
>  		iommu_spec.args_count = count;
>  
>  		mtk_iommu_create_mapping(dev, &iommu_spec);
> +
> +		/* dev->iommu_fwspec might have changed */
> +		fwspec = dev_iommu_fwspec_get(dev);
> +
>  		of_node_put(iommu_spec.np);
>  	}
>  
> 
