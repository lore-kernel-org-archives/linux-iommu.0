From: Luis Henriques <luis.henriques@canonical.com>
Subject: Re: [PATCH 3.4] iommu/amd: Initialize device table after dma_ops
Date: Thu, 28 Feb 2013 22:16:41 +0000
Message-ID: <20130228221641.GB5276@hercules>
References: <1360205128.2615.14.camel@lorien2>
 <1361922545.2720.17.camel@lorien2>
 <1362081120.2822.30.camel@lorien2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1362081120.2822.30.camel@lorien2>
Sender: stable-owner@vger.kernel.org
To: Shuah Khan <shuah.khan@hp.com>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, stable <stable@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, shuahkhan@gmail.com
List-Id: iommu@lists.linux-foundation.org

Hi Shuah,

On Thu, Feb 28, 2013 at 12:52:00PM -0700, Shuah Khan wrote:
> On Tue, 2013-02-26 at 16:49 -0700, Shuah Khan wrote:
> > When dma_ops are initialized the unity mappings are created. The
> > init_device_table_dma() function makes sure DMA from all devices is
> > blocked by default. This opens a short window in time where DMA to
> > unity mapped regions is blocked by the IOMMU. Make sure this does not
> > happen by initializing the device table after dma_ops.
> > 
> > Back-port upstream commit: f528d980c17b8714aedc918ba86e058af914d66b
> > 
> > Signed-off-by: Joerg Roedel <joro@8bytes.org>
> > Signed-off-by: Shuah Khan <shuah.khan@hp.com>
> > CC: stable@vger.kernel.org 3.4
> 
> Please consider this for 3.5 as well.

Thank you, I will queue this for the 3.5 kernel.

Cheers,
--
Luis

> 
> -- Shuah
> > ---
> >  drivers/iommu/amd_iommu_init.c |    9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
> > index ef0ae93..b573f80 100644
> > --- a/drivers/iommu/amd_iommu_init.c
> > +++ b/drivers/iommu/amd_iommu_init.c
> > @@ -1572,8 +1572,6 @@ int __init amd_iommu_init_hardware(void)
> >  	if (amd_iommu_pd_alloc_bitmap == NULL)
> >  		goto free;
> >  
> > -	/* init the device table */
> > -	init_device_table();
> >  
> >  	/*
> >  	 * let all alias entries point to itself
> > @@ -1655,6 +1653,7 @@ out:
> >   */
> >  static int __init amd_iommu_init(void)
> >  {
> > +	struct amd_iommu *iommu;
> >  	int ret = 0;
> >  
> >  	ret = amd_iommu_init_hardware();
> > @@ -1673,6 +1672,12 @@ static int __init amd_iommu_init(void)
> >  	if (ret)
> >  		goto free;
> >  
> > +	/* init the device table */
> > +	init_device_table();
> > +
> > +	for_each_iommu(iommu)
> > +		iommu_flush_all_caches(iommu);
> > +
> >  	amd_iommu_init_api();
> >  
> >  	x86_platform.iommu_shutdown = disable_iommus;
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe stable" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
