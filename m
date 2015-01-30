From: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH 16/26] iommu/fsl: Use a device pointer to make lines
	shorter
Date: Fri, 30 Jan 2015 07:46:42 +0000
Message-ID: <BN3PR0301MB121994B2C54285466EE26F97EA310@BN3PR0301MB1219.namprd03.prod.outlook.com>
References: <1422455698-3074-1-git-send-email-Emilian.Medve@Freescale.com>
	<1422455698-3074-17-git-send-email-Emilian.Medve@Freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1422455698-3074-17-git-send-email-Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>
Cc: Emilian Medve <Emilian.Medve-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Emil Medve [mailto:Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org]
> Sent: Wednesday, January 28, 2015 8:05 PM
> To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; jroedel-l3A5Bk7waGM@public.gmane.org;
> Sethi Varun-B16395
> Cc: Medve Emilian-EMMEDVE1
> Subject: [PATCH 16/26] iommu/fsl: Use a device pointer to make lines
> shorter
> 
> Signed-off-by: Emil Medve <Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
> ---
>  drivers/iommu/fsl_pamu.c | 39 ++++++++++++++++++---------------------
>  1 file changed, 18 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c index
> 18a604a..22b72e2 100644
> --- a/drivers/iommu/fsl_pamu.c
> +++ b/drivers/iommu/fsl_pamu.c
> @@ -1002,6 +1002,7 @@ static const struct {
> 
>  static int __init fsl_pamu_probe(struct platform_device *pdev)  {
> +	struct device *dev = &pdev->dev;
>  	void __iomem *pamu_regs = NULL;
>  	struct ccsr_guts __iomem *guts_regs = NULL;
>  	u32 pamubypenr, pamu_counter;
> @@ -1026,16 +1027,16 @@ static int __init fsl_pamu_probe(struct
> platform_device *pdev)
>  	 * NOTE : All PAMUs share the same LIODN tables.
>  	 */
> 
> -	pamu_regs = of_iomap(pdev->dev.of_node, 0);
> +	pamu_regs = of_iomap(dev->of_node, 0);
>  	if (!pamu_regs) {
> -		dev_err(&pdev->dev, "ioremap of PAMU node failed\n");
> +		dev_err(dev, "ioremap of PAMU node failed\n");
>  		return -ENOMEM;
>  	}
> -	of_get_address(pdev->dev.of_node, 0, &size, NULL);
> +	of_get_address(dev->of_node, 0, &size, NULL);
> 
> -	irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
> +	irq = irq_of_parse_and_map(dev->of_node, 0);
>  	if (irq == NO_IRQ) {
> -		dev_warn(&pdev->dev, "no interrupts listed in PAMU
> node\n");
> +		dev_warn(dev, "no interrupts listed in PAMU node\n");
>  		goto error;
>  	}
> 
> @@ -1050,15 +1051,14 @@ static int __init fsl_pamu_probe(struct
> platform_device *pdev)
>  	/* The ISR needs access to the regs, so we won't iounmap them */
>  	ret = request_irq(irq, pamu_av_isr, 0, "pamu", data);
>  	if (ret < 0) {
> -		dev_err(&pdev->dev, "error %i installing ISR for irq %i\n",
> -			ret, irq);
> +		dev_err(dev, "error %i installing ISR for irq %i\n", ret, irq);
>  		goto error;
>  	}
> 
>  	guts_node = of_find_matching_node(NULL, guts_device_ids);
>  	if (!guts_node) {
> -		dev_err(&pdev->dev, "could not find GUTS node %s\n",
> -			pdev->dev.of_node->full_name);
> +		dev_err(dev, "could not find GUTS node %s\n",
> +			dev->of_node->full_name);
>  		ret = -ENODEV;
>  		goto error;
>  	}
> @@ -1066,7 +1066,7 @@ static int __init fsl_pamu_probe(struct
> platform_device *pdev)
>  	guts_regs = of_iomap(guts_node, 0);
>  	of_node_put(guts_node);
>  	if (!guts_regs) {
> -		dev_err(&pdev->dev, "ioremap of GUTS node failed\n");
> +		dev_err(dev, "ioremap of GUTS node failed\n");
>  		ret = -ENODEV;
>  		goto error;
>  	}
> @@ -1086,7 +1086,7 @@ static int __init fsl_pamu_probe(struct
> platform_device *pdev)
> 
>  	p = alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
>  	if (!p) {
> -		dev_err(&pdev->dev, "unable to allocate
> PAACT/SPAACT/OMT block\n");
> +		dev_err(dev, "unable to allocate PAACT/SPAACT/OMT
> block\n");
>  		ret = -ENOMEM;
>  		goto error;
>  	}
> @@ -1096,7 +1096,7 @@ static int __init fsl_pamu_probe(struct
> platform_device *pdev)
> 
>  	/* Make sure the memory is naturally aligned */
>  	if (ppaact_phys & ((PAGE_SIZE << order) - 1)) {
> -		dev_err(&pdev->dev, "PAACT/OMT block is unaligned\n");
> +		dev_err(dev, "PAACT/OMT block is unaligned\n");
>  		ret = -ENOMEM;
>  		goto error;
>  	}
> @@ -1104,8 +1104,7 @@ static int __init fsl_pamu_probe(struct
> platform_device *pdev)
>  	spaact = (void *)ppaact + (PAGE_SIZE << get_order(PAACT_SIZE));
>  	omt = (void *)spaact + (PAGE_SIZE << get_order(SPAACT_SIZE));
> 
> -	dev_dbg(&pdev->dev, "ppaact virt=%p phys=0x%pa\n", ppaact,
> -		&ppaact_phys);
> +	dev_dbg(dev, "ppaact virt=%p phys=0x%pa\n", ppaact,
> &ppaact_phys);
> 
>  	/* Check to see if we need to implement the work-around on this
> SOC */
> 
> @@ -1113,21 +1112,19 @@ static int __init fsl_pamu_probe(struct
> platform_device *pdev)
>  	for (i = 0; i < ARRAY_SIZE(port_id_map); i++) {
>  		if (port_id_map[i].svr == (mfspr(SPRN_SVR) &
> ~SVR_SECURITY)) {
>  			csd_port_id = port_id_map[i].port_id;
> -			dev_dbg(&pdev->dev, "found matching SVR
> %08x\n",
> +			dev_dbg(dev, "found matching SVR %08x\n",
>  				port_id_map[i].svr);
>  			break;
>  		}
>  	}
> 
>  	if (csd_port_id) {
> -		dev_dbg(&pdev->dev, "creating coherency subdomain at
> address "
> -			"%pa, size %zu, port id 0x%08x", &ppaact_phys,
> -			mem_size, csd_port_id);
> +		dev_dbg(dev, "creating coherency subdomain at address
> %pa, size %zu, port id 0x%08x",
> +			&ppaact_phys, mem_size, csd_port_id);
> 
>  		ret = create_csd(ppaact_phys, mem_size, csd_port_id);
>  		if (ret) {
> -			dev_err(&pdev->dev, "could not create coherence "
> -				"subdomain\n");
> +			dev_err(dev, "could not create coherence
> subdomain\n");
>  			return ret;
>  		}
>  	}
> @@ -1138,7 +1135,7 @@ static int __init fsl_pamu_probe(struct
> platform_device *pdev)
>  	spaace_pool = gen_pool_create(ilog2(sizeof(struct paace)), -1);
>  	if (!spaace_pool) {
>  		ret = -ENOMEM;
> -		dev_err(&pdev->dev, "PAMU : failed to allocate spaace gen
> pool\n");
> +		dev_err(dev, "PAMU : failed to allocate spaace gen pool\n");
>  		goto error;
>  	}
> 
> --
> 2.2.2
Acked-by: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
