From: Szabolcs Fruhwald via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: [PATCH] dcdbas: Fix Intel-IOMMU domain allocation failure
Date: Thu, 24 Jan 2019 12:30:37 -0800
Message-ID: <CAKkQkjD=Hdm-3WbmrrqEj4c5df3LH7sMU960rwqHqF0Gf4CU7A@mail.gmail.com>
References: <20190123230131.42094-1-sfruhwald@google.com>
	<c4e7855966a94b0c999a5f4325a27e90@ausx13mpc120.AMER.DELL.COM>
Reply-To: Szabolcs Fruhwald <sfruhwald-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <c4e7855966a94b0c999a5f4325a27e90-uCoIPMzyhkt0S+eBbY//XQVY21JRvFwKV6yJEvX+wlw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Mario.Limonciello-8PEkshWhKlo@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, platform-driver-x86-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stuart.w.hayes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

(+iommu list for visibility and confirmation of the intended constant
externalization, see 2nd point below)

Hi Mario, Thanks for your comments, see my answers inline below.

On Thu, Jan 24, 2019 at 7:16 AM <Mario.Limonciello-8PEkshWhKlo@public.gmane.org> wrote:
>
> > -----Original Message-----
> > From: platform-driver-x86-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org <platform-driver-x86-
> > owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> On Behalf Of Szabolcs Fruhwald
> > Sent: Wednesday, January 23, 2019 5:02 PM
> > To: Stuart Hayes
> > Cc: platform-driver-x86-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Szabolcs Fruhwald
> > Subject: [PATCH] dcdbas: Fix Intel-IOMMU domain allocation failure
> >
> >
> > [EXTERNAL EMAIL]
> >
> > On Dell systems with intel_iommu enabled, dcdbas platform driver's DMA
> > calls fail with ENOMEM / "DMAR: Allocating domain for dcdbas failed".
>
> As a curiosity was this from manually turning on IOMMU or the automatic IOMMU
> enablement caused by 89a6079df791aeace2044ea93be1b397195824ec?
>

In our case it was manual turn-on. We need to deal with several hw
platforms (preferably with a unified sw configuration) and on one
particular hw platform (R730XD) we had problems even with
intel_iommu=off (no USB). However, we need vt-d / iommu support by
security reasons (preventing dma attacks), rather than by other
aspects, eg virtualization. So we didn't try to completely turn it
off.
These issues came up in the past year as we are in the process of
upgrading to v4 kernels and iommu support (and complexity) has been
significantly improved since v3.

> >
> > This is because the intel-iommu driver only supports PCI bus / devices,
> > therefore it is not (yet) possible to properly allocate and attach iommu
> > group/domain and attach devices with no pci parent devices.
> >
> > This workaround is forcing the intel_iommu implementation to use identity
> > mapping for this device, using the DUMMY_DEVICE_DOMAIN_INFO constant value
> > defined and used in intel-iommu.c.
>
> I would think it makes sense to export this out to a common include that both files can
> use if it's using the same constant value as drivers/iommu/intel-iommu.c
>

Absolutely, I thought so too. But, since the actual need to force
id-mapping comes from the lack of support for non-pci buses
particularly by the intel iommu implementation, it seemed a bit odd to
move this constant into iommu.h. Other platforms' implementations are
usually handling and hooking into other buses, eg platform bus.

However, even these other hw platform iommu implementations are using
ACPI or other (bios related) tables to generate source ids, which
might still be an issue with drivers like dcdbas, with no real device
info in these tables. Not to mention that forcing id-mapping might be
a useful tool in driver developers' hands by other reasons too.
Therefore, I just came to the conclusion that it is indeed useful to
have this constant present in the common iommu header file (but with a
more expressing name).

Especially, as I just found that dcdbas is *not* the first one to
implement this workaround:
https://github.com/torvalds/linux/blob/71f3a82fab1b631ae9cb1feb677f498d4ca5007d/drivers/gpu/drm/i915/selftests/mock_gem_device.c#L154

Let me come up with a v2 patch-set, containing a separate patch
externalizing this constant from intel_iommu.c to iommu.h and making
the above code using it too first, followed by this change in dcdbas.

> At least to me it seems likely that dcdbas is just one of the first drivers that will cause this.
>
> >
> > Signed-off-by: Szabolcs Fruhwald <sfruhwald-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
> > ---
> >  drivers/platform/x86/dcdbas.c | 5 +++++
> >  drivers/platform/x86/dcdbas.h | 2 +-
> >  2 files changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/platform/x86/dcdbas.c b/drivers/platform/x86/dcdbas.c
> > index 88bd7efafe14..a5d6bb1bc590 100644
> > --- a/drivers/platform/x86/dcdbas.c
> > +++ b/drivers/platform/x86/dcdbas.c
> > @@ -652,6 +652,11 @@ static int dcdbas_probe(struct platform_device *dev)
> >
> >       dcdbas_pdev = dev;
> >
> > +     /* Intel-IOMMU workaround: platform-bus unsupported, force ID-mapping
> > */
> > +     #if IS_ENABLED(CONFIG_IOMMU_API) &&
> > defined(CONFIG_INTEL_IOMMU)
> > +             dev->dev.archdata.iommu = INTEL_IOMMU_DUMMY_DOMAIN;
> > +     #endif
> > +
> >       /* Check if ACPI WSMT table specifies protected SMI buffer address */
> >       error = dcdbas_check_wsmt();
> >       if (error < 0)
> > diff --git a/drivers/platform/x86/dcdbas.h b/drivers/platform/x86/dcdbas.h
> > index 52729a494b00..373eb277933a 100644
> > --- a/drivers/platform/x86/dcdbas.h
> > +++ b/drivers/platform/x86/dcdbas.h
> > @@ -54,6 +54,7 @@
> >
> >  #define SMI_CMD_MAGIC                                (0x534D4931)
> >  #define SMM_EPS_SIG                          "$SCB"
> > +#define INTEL_IOMMU_DUMMY_DOMAIN                ((void *)-1)
> >
> >  #define DCDBAS_DEV_ATTR_RW(_name) \
> >       DEVICE_ATTR(_name,0600,_name##_show,_name##_store);
> > @@ -114,4 +115,3 @@ struct smm_eps_table {
> >  } __packed;
> >
> >  #endif /* _DCDBAS_H_ */
> > -
> > --
> > 2.20.1.321.g9e740568ce-goog
>
