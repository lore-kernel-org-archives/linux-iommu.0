From: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH v8 07/12] iommu/exynos: support for device tree
Date: Thu, 01 Aug 2013 22:14:03 +0900
Message-ID: <003a01ce8eb8$fe946db0$fbbd4910$@samsung.com>
References: <003d01ce89f3$44ec2cf0$cec486d0$@samsung.com>
	<1743111.Ek7FldnHal@flatron>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <1743111.Ek7FldnHal@flatron>
Content-language: ko
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: 'Tomasz Figa' <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: 'Linux Samsung SOC' <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, 'Hyunwoong Kim' <khw0178.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Prathyush' <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Grant Grundler' <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, 'Keyyoung Park' <keyyoung.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Subash Patel' <supash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, 'Linux Kernel' <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, 'Sachin Kamat' <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, 'Linux IOMMU' <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, 'Kukjin Kim' <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Antonios Motakis' <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org, 'Linux ARM Kernel' <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, 'Rahul Sharma' <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

> -----Original Message-----
> From: Tomasz Figa [mailto:tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
> Sent: Saturday, July 27, 2013 11:07 PM
> 
> Hi,
> 
> On Friday 26 of July 2013 20:28:36 Cho KyongHo wrote:
> > This commit adds device tree support for System MMU.
> > This also include the following changes and enhancements:
> >
> > * use managed device helper functions.
> > Simplyfies System MMU device driver.
> >
> > * use only a single clock descriptor.
> > System MMU device descriptor is seperate if it is imposible to make
> > a single clock descriptor to make a device descriptor for a group of
> > System MMUs.
> >
> > * removed dbgname member from sysmmu_drvdata structure.
> > debugging kernel message for a System MMU is distinguisheable with the
> > name of device descroptors.
> >
> > Signed-off-by: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> > ---
> >  drivers/iommu/Kconfig        |    5 +-
> >  drivers/iommu/exynos-iommu.c |  182
> > ++++++++++++++++-------------------------- 2 files changed, 70
> > insertions(+), 117 deletions(-)
> 
> Whenever you introduce or modify (extend) a device tree binding please
> don't forget about reflecting that in documentation
> (Documentation/devicetree/bindings) and CCing devicetree mailing list
> (devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org). Both of these steps are necessary to get any
> device tree stuff merged.
> 

Oh I see.
Thank you for advice.

> Best regards,
> Tomasz
