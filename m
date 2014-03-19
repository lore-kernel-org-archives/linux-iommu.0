From: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v11 19/27] iommu/exynos: add support for power management
	subsystems.
Date: Wed, 19 Mar 2014 18:07:57 +0900
Message-ID: <20140319180757.a1552386b81e698914d4bcc6@samsung.com>
References: <20140314141028.4b0b62d895905988ab5dda88@samsung.com>
	<53232959.7020306@samsung.com>
	<20140318202320.a3101304bbc51cc9f169cdaa@samsung.com>
	<53286730.1060807@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <53286730.1060807-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
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
Cc: Linux DeviceTree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linux Samsung SOC <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Prathyush <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Linux ARM Kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Rahul Sharma <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, 18 Mar 2014 16:33:04 +0100, Tomasz Figa wrote:
> On 18.03.2014 12:23, Cho KyongHo wrote:
> > On Fri, 14 Mar 2014 17:07:53 +0100, Tomasz Figa wrote:
> >> Hi KyongHo,
> >>
> >> On 14.03.2014 06:10, Cho KyongHo wrote:
> 
> [snip]
> 
> >>> @@ -677,11 +679,40 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
> >>>    	platform_set_drvdata(pdev, data);
> >>>
> >>>    	pm_runtime_enable(dev);
> >>> +	data->runtime_active = !pm_runtime_enabled(dev);
> >>
> >> Hmm, this seems to be a bit misleading. The field is named
> >> runtime_active, but the assignment makes it true if PM runtime is _not_
> >> enabled (i.e. inactive). Is this correct?
> >>
> >
> > I agree that it may lead misunderstood.
> > data->runtime_active actually indicates if electric power is asserted
> > to the System MMU. pm_runtime_enable() call must enable runtime pm
> > for the given device. If runtime pm is not enabled although pm_runtime_enable()
> > is called, CONFIG_PM_RUNTIME is not configured.
> >
> > Actually, it is replacible with
> > if (IS_ENABLED(CONFIG_PM_RUNTIME))
> >      data->runtime_active = true;
> 
> I would keep it as !pm_runtime_enabled(dev), but rename the field to 
> something more meaningful, like data->is_powered_on.
> 

That is good idea.

thanks for advice.

KyongHo.
