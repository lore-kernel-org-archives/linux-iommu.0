From: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH v7 00/12] iommu/exynos: Fixes and Enhancements of System
	MMU driver with DT
Date: Mon, 15 Jul 2013 21:20:50 +0900
Message-ID: <00a701ce8155$be139240$3a3ab6c0$@samsung.com>
References: <002801ce797b$3d2fbc80$b78f3580$@samsung.com>
	<CANEJEGvajhgzUPG6ppbjwBb4-9TdU9em3T_SejBpz8NCjGHYTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: 
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
To: 'Grant Grundler' <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: 'Linux Samsung SOC' <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, 'Hyunwoong Kim' <khw0178.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Prathyush' <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Keyyoung Park' <keyyoung.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Subash Patel' <supash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, 'Linux Kernel' <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, 'Doug Anderson' <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, 'Linux IOMMU' <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, 'Kukjin Kim' <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Linux ARM Kernel' <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, 'Rahul Sharma' <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

> From: Cho KyongHo [mailto:pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org]
> Sent: Monday, July 15, 2013 8:24 PM
> 
> > From: grundler-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org [mailto:grundler-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org] On Behalf Of Grant Grundler
> > Sent: Friday, July 12, 2013 2:23 AM
> >
> > On Fri, Jul 5, 2013 at 5:29 AM, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> > > The current exynos-iommu(System MMU) driver does not work autonomously
> > > since it is lack of support for power management of peripheral blocks.
> > ...
> > > Patch summary:
> > > [PATCH v7 1/9] iommu/exynos: do not include removed header
> > > [PATCH v7 2/9] iommu/exynos: add missing cache flush for removed page table entries
> > > [PATCH v7 3/9] iommu/exynos: fix page table maintenance
> > > [PATCH v7 4/9] iommu/exynos: allocate lv2 page table from own slab
> > > [PATCH v7 5/9] iommu/exynos: change rwlock to spinlock
> > > [PATCH v7 6/9] clk: exynos5250: add gate clock descriptions of System MMU
> > > [PATCH v7 7/9] ARM: dts: Add description of System MMU of Exynos SoCs
> > > [PATCH v7 8/9] iommu/exynos: support for device tree
> > > [PATCH v7 9/9] iommu/exynos: add bus notifier for registering System MMU
> >
> > Cho,
> > Of the above patches, nearly all have been applied to chromeos-3.8
> > (kernel-next git tree) by Doug Anderson and others.
> >
> > AFAICT, the only ones not applied are:
> >    [v7,3/9] iommu/exynos: fix page table maintenance
> >    [v7,6/9] clk: exynos5250: add gate clock descriptions of System MMU
> > (conflicts in this one)
> >    [v7,7/9] ARM: dts: Add description of System MMU of Exynos SoCs
> > (depends on 6/9)
> >
> > We also already have parts of:
> >    [v7,9/9] iommu/exynos: add bus notifier for registering System MMU
> >
> > Some of those are being further discussed but I've lost track now
> > exactly which ones.
> >
> > I'm telling you about chromeos-3.8 status since the adopted changes
> > have been reviewed (by me and others) are being tested manually here
> > on several different Samsung Exynos platforms (including 5250 which is
> > our "snow" platform). Not sure how you should to mark those patches
> > since they aren't identical to your changes (which apply to post 3.10
> > kernels, not 3.8).  You might consider splitting those patches out
> > from the 4 I've listed above to get that series accepted upstream
> > since the additional review/testing should provide some confidence
> > those patches are good.
> >
> 
> I understand what you are concerning about.
> Have you applied v6 patchset?
> 
> I will try to split the patches and make the changes from v6
> on top of the v6 patcheset.
> 

Actually, as you know, the previous patches include setting a System MMU
as the parent device of its master device in probe() of System MMU.
I asked Greg KH about changing device hierarchy in probe() and he answered
that it is not a good idea because it modifies sysfs even though probe() of
System MMU driver is called before sysfs is constructed.

That's why I uses genpd_pm_ops.
It results in big change in the patches after registering device tree.

I want to ask your opinion about this change :)

> > cheers,
> > grant
> 
> Thank you.
> 
> Cho KyonogHo.
