From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: [PATCH] IOMMU-Tegra: gart: Delete an unnecessary check before the
 function call "vfree"
Date: Fri, 9 Jan 2015 07:58:16 +0100
Message-ID: <559E1B88.5030005@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <530A086E.8010901@users.sourceforge.net>
 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
 <530A72AA.3000601@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
 <530B5FB6.6010207@users.sourceforge.net>
 <alpine.DEB.2.10.1402241710370.2074@hadrien>
 <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net> <54D3A1A9.9040709@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <54D3A1A9.9040709@users.sourceforge.net>
Sender: kernel-janitors-owner@vger.kernel.org
To: Alexandre Courbot <gnurou@gmail.com>, Hiroshi Doyu <hdoyu@nvidia.com>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: iommu@lists.linux-foundation.org

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 5 Feb 2015 17:54:16 +0100
> 
> The vfree() function performs also input parameter validation.
> Thus the test around the call is not needed.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/iommu/tegra-gart.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
> index f722a0c..07a795a 100644
> --- a/drivers/iommu/tegra-gart.c
> +++ b/drivers/iommu/tegra-gart.c
> @@ -404,8 +404,7 @@ static int tegra_gart_remove(struct platform_device *pdev)
>  	struct gart_device *gart = platform_get_drvdata(pdev);
>  
>  	writel(0, gart->regs + GART_CONFIG);
> -	if (gart->savedata)
> -		vfree(gart->savedata);
> +	vfree(gart->savedata);
>  	gart_handle = NULL;
>  	return 0;
>  }
> 

Would you like to integrate this update suggestion
into another source code repository?

Regards,
Markus
