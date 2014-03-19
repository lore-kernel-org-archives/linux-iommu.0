From: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v11 13/27] iommu/exynos: support for device tree
Date: Wed, 19 Mar 2014 18:06:28 +0900
Message-ID: <20140319180628.5eecd7347c24f1e697aaaa6a@samsung.com>
References: <20140314140935.e0652b58ce16591b54d0e10b@samsung.com>
	<53230695.9080606@samsung.com>
	<20140318195210.14c953a70498f634032f35b7@samsung.com>
	<53286557.6070808@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <53286557.6070808-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Linux DeviceTree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Samsung SOC <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Prathyush <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, Linux ARM Kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Rahul Sharma <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, 18 Mar 2014 16:25:11 +0100, Tomasz Figa wrote:
> On 18.03.2014 11:52, Cho KyongHo wrote:
> > On Fri, 14 Mar 2014 14:39:33 +0100, Tomasz Figa wrote:
> >>> @@ -557,11 +558,23 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
> >>>    	return 0;
> >>>    }
> >>>
> >>> -static struct platform_driver exynos_sysmmu_driver = {
> >>> -	.probe		= exynos_sysmmu_probe,
> >>> -	.driver		= {
> >>> +#ifdef CONFIG_OF
> >>> +static struct of_device_id sysmmu_of_match[] __initconst = {
> >>> +	{ .compatible	= "samsung,sysmmu-v1", },
> >>> +	{ .compatible	= "samsung,sysmmu-v2", },
> >>> +	{ .compatible	= "samsung,sysmmu-v3.1", },
> >>> +	{ .compatible	= "samsung,sysmmu-v3.2", },
> >>> +	{ .compatible	= "samsung,sysmmu-v3.3", },
> >>
> >> Do you need all these compatible strings? I mean, are there any
> >> implementation differences that can't be identified by reading IP
> >> registers, such as REG_MMU_VERSION?
> >>
> >
> > Unfortunately, there is a SoC which overrides REG_MMU_VERSION with
> > a value for RTL designers and it is not related to System MMU
> > versions.
> 
> OK.
> 
> What about having a generic compatible string for Samsung SysMMU then, 
> but an additional property that can override the version to account for 
> such brokenness? If not provided, the version would be read from 
> REG_MMU_VERSION.
> 

Yes it is one of possible idea.
Let me think what better way is.

Thank you.

KyongHo
