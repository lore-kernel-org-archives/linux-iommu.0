From: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v11 10/27] iommu/exynos: use managed device helper
	functions
Date: Wed, 19 Mar 2014 17:56:01 +0900
Message-ID: <20140319175601.4e986eddf36d5157ab54bcc1@samsung.com>
References: <20140314140542.f4ded6c50dbd8a1d937bf354@samsung.com>
	<53230404.6070601@samsung.com>
	<20140318193817.3448387b75e109e814b9c025@samsung.com>
	<5328625B.508@samsung.com>
	<001201cf4306$0e16e540$2a44afc0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <001201cf4306$0e16e540$2a44afc0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: 'Linux DeviceTree' <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, 'Linux Samsung SOC' <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, 'Prathyush' <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Grant Grundler' <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, 'Tomasz Figa' <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Linux Kernel' <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, 'Sachin Kamat' <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, 'Linux IOMMU' <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, 'Kukjin Kim' <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Sylwester Nawrocki' <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Varun Sethi' <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, 'Antonios Motakis' <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, 'Linux ARM Kernel' <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, 'Rahul Sharma' <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, 19 Mar 2014 08:59:09 +0900, Jingoo Han wrote:
> On Wednesday, March 19, 2014 12:12 AM, Tomasz Figa wrote:
> > On 18.03.2014 11:38, Cho KyongHo wrote:
> > > On Fri, 14 Mar 2014 14:28:36 +0100, Tomasz Figa wrote:
> > >> On 14.03.2014 06:05, Cho KyongHo wrote:
> > >>> This patch uses managed device helper functions in the probe().
> > >>>
> > >>> Signed-off-by: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> > >>> ---
> > >>>    drivers/iommu/exynos-iommu.c |   64 +++++++++++++++++-------------------------
> > >>>    1 file changed, 26 insertions(+), 38 deletions(-)
> > >>>
> > >>> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> > >>> index 36e6b73..33b424d 100644
> > >>> --- a/drivers/iommu/exynos-iommu.c
> > >>> +++ b/drivers/iommu/exynos-iommu.c
> 
> [.....]
> 
> > >>>    	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > >>>    	if (!res) {
> > >>> -		dev_dbg(dev, "Unable to find IOMEM region\n");
> > >>> -		ret = -ENOENT;
> > >>> -		goto err_init;
> > >>> +		dev_err(dev, "Unable to find IOMEM region\n");
> > >>> +		return -ENOENT;
> > >>>    	}
> > >>
> > >> No need to check for error and print message, because
> > >> devm_ioremap_resource() already checks the passed resource and handles
> > >> error cases.
> > >>
> > >
> > > Yes but devm_ioremap_resource() just tells that the given 'res' is not
> > > correct. I think the message in the driver is more informative.
> > 
> > The common practice used in Linux kernel is to not duplicate such
> > messages. It is obvious that devm_ioremap_resource() printing such
> > message is related to an IOMEM resource anyway, as you can't used it
> > with other types of resources.
> 
> +1
> 
> I agree with Tomasz Figa's opinion.
> These messages have been being removed from Linux kernel.
> Thank you.
> 
Ok.

Thank you for the advice.

Kyong Ho 
