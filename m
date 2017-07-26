From: Honghui Zhang <honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] memory: mtk-smi: Use of_device_get_match_data helper
Date: Wed, 26 Jul 2017 20:35:27 +0800
Message-ID: <1501072527.20860.1.camel@mtksdaap41>
References: <1501063150-8778-1-git-send-email-honghui.zhang@mediatek.com>
	<1d31eedd-fdab-bd6f-65b1-c0e8b79a8888@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1d31eedd-fdab-bd6f-65b1-c0e8b79a8888-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: youlin.pei-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, erin.lo-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, 2017-07-26 at 11:36 +0100, Robin Murphy wrote:
> On 26/07/17 10:59, honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org wrote:
> > From: Honghui Zhang <honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > 

> >  	 * for mtk smi gen 1, we need to get the ao(always on) base to config
> >  	 * m4u port, and we need to enable the aync clock for transform the smi
> >  	 * clock into emi clock domain, but for mtk smi gen2, there's no smi ao
> >  	 * base.
> >  	 */
> > -	smi_gen = (enum mtk_smi_gen)of_id->data;
> > -	if (smi_gen == MTK_SMI_GEN1) {
> > +	smi_gen = of_device_get_match_data(dev);
> 
> The data you're retrieving is the exact same thing as of_id->data was,
> i.e. an enum mtk_smi_gen cast to void*, so dereferencing it is not a
> good idea. The first patch was almost right; you just need to keep the
> cast in the assignment to smi_gen.
> 
> Robin.
> 
Hi, Robin, thanks very much.
I will send a new version.

> > +	if (*smi_gen == MTK_SMI_GEN1) {
> >  		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >  		common->smi_ao_base = devm_ioremap_resource(dev, res);
> >  		if (IS_ERR(common->smi_ao_base))
> > 
> 
