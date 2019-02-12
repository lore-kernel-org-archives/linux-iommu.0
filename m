From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] iommu/ipmmu-vmsa: fix device reference leaks
Date: Tue, 12 Feb 2019 18:47:22 +0200
Message-ID: <20190212164722.GT6279@pendragon.ideasonboard.com>
References: <HK0PR02MB3634F6AE1FAE6B86EF82B291B26C0@HK0PR02MB3634.apcprd02.prod.outlook.com>
 <20190211102414.GZ32526@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190211102414.GZ32526@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "joro@8bytes.org" <joro@8bytes.org>
Cc: wen yang <yellowriver2010@hotmail.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Magnus Damm <damm+renesas@opensource.se>
List-Id: iommu@lists.linux-foundation.org

Hello,

Wen, thank you for the patch.

On Mon, Feb 11, 2019 at 11:24:15AM +0100, joro@8bytes.org wrote:
> Adding a few more people to Cc.
> 
> On Sun, Feb 03, 2019 at 10:27:09AM +0000, wen yang wrote:
> > Make sure to drop the reference to the device taken by
> > of_find_device_by_node() on driver unbind.
> > 
> > Signed-off-by: Wen Yang <yellowriver2010@hotmail.com>
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Cc: iommu@lists.linux-foundation.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  drivers/iommu/ipmmu-vmsa.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> > index 7a4529c..cebf56d 100644
> > --- a/drivers/iommu/ipmmu-vmsa.c
> > +++ b/drivers/iommu/ipmmu-vmsa.c
> > @@ -756,6 +756,9 @@ static int ipmmu_init_platform_device(struct device *dev,
> >  
> >  	fwspec->iommu_priv = platform_get_drvdata(ipmmu_pdev);
> >  
> > +	if (!fwspec->iommu_priv)
> > +		put_device(&ipmmu_pdev->dev);
> > +

This doesn't seem to match the patch's subject, and doesn't seem to fix
the problem.

> >  	return 0;
> >  }
> >  

-- 
Regards,

Laurent Pinchart
