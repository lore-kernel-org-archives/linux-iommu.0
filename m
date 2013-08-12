From: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v9 14/16] iommu/exynos: add support for power management
	subsystems.
Date: Mon, 12 Aug 2013 10:55:01 +0900
Message-ID: <20130812105501.d5c52155b378b5e2f4d4bb53@samsung.com>
References: <003201ce941b$6e5a90e0$4b0fb2a0$@samsung.com>
	<1949492.N82v2nAcIY@flatron>
	<20130809164943.fe4b673e92b3f7680562f29b@samsung.com>
	<3833452.V3JQdooaWE@flatron>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <3833452.V3JQdooaWE@flatron>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Linux Samsung SOC' <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, 'Prathyush' <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Grant Grundler' <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, 'Subash Patel' <supash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, 'Linux Kernel' <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, 'Sachin Kamat' <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, 'Linux IOMMU' <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, 'Kukjin Kim' <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Antonios Motakis' <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org, 'Linux ARM Kernel' <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, 'Rahul Sharma' <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, 09 Aug 2013 10:32:40 +0200, Tomasz Figa wrote:
> On Friday 09 of August 2013 16:49:43 Cho KyongHo wrote:
> > On Fri, 09 Aug 2013 01:03:05 +0200, Tomasz Figa wrote:
> > > Hi KyongHo,
> > > 
> > > nit: Please drop the trailing dot at the end of patch subject.
> > 
> > Oh. I didn't catch that.
> > Thank you.
> > 
> > > On Thursday 08 of August 2013 18:41:17 Cho KyongHo wrote:
> > > > This adds support for Advance Power Management and Runtime Power
> > > > Management.
> > > 
> > > This patch adds support for system-wide and runtime power management.
> > 
> > Ok.
> > 
> > > > Since System MMU is located in the same local power domain of its
> > > > master H/W, System MMU must be initialized before it is working if
> > > > its power domain was ever turned off. TLB invalidation according to
> > > > unmapping on page tables must also be performed while power domain
> > > > is
> > > > turned on.
> > > > 
> > > > This patch ensures that resume and runtime_resume(restore_state)
> > > > functions in this driver is called before the calls to resume and
> > > > runtime_resume callback functions in the drivers of master H/Ws.
> > > > Likewise, suspend and runtime_suspend(save_state) functions in this
> > > > driver is called after the calls to suspend and runtime_suspend in
> > > > the
> > > > drivers of master H/Ws.
> > > > 
> > > > In order to get benefit of this support, the master H/W and its
> > > > System
> > > > MMU must resides in the same power domain in terms of Linux kernel.
> > > > If
> > > > a master H/W does not use generic I/O power domain, its driver must
> > > > call iommu_attach_device() after its local power domain is turned
> > > > on,
> > > > iommu_detach_device before turned off.
> > > 
> > > I don't get the point of this last paragraph. What a power domain can
> > > be in other terms? Is there any other way to support power domains on
> > > Exynos than generic power domains?
> > 
> > I just addressed the case a device driver turns off local power of its
> > device without the help of generic I/O powerdomain.
> 
> Out of curiosity, do we have such cases for Exynos in mainline kernel? 
> IMHO this is what the generic PM core is for and drivers shouldn't care 
> about such low level PM details.

I don't know if there is the case and I also agree with you.

I hope that there is no case that I addressed.
I just mentioned an exceptional case.
The best way is that all device drivers of master H/W of System MMU register
their defvice in a generic i/o powerdomain.

Thank you.

KyongHo.
