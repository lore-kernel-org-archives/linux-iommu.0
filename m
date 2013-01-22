From: "Kinney, Steven" <Steven.Kinney-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 0/3] AMD IOMMUv2 Performance Counter patches
Date: Tue, 22 Jan 2013 18:26:55 +0000
Message-ID: <57D41218901B4442B4AFF404D21591163BBB25@sausexdag02.amd.com>
References: <1358799658-6236-1-git-send-email-steven.kinney@amd.com>
	<20130122174803.GF8365@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20130122174803.GF8365-6K5HmflnPlqSPmnEAIUT9EEOCMrvLtNR@public.gmane.org>
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
To: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Peter Zijlstra <a.p.zijlstra-/NLkJaSkS4VmR6Xm/wNWPw@public.gmane.org>, Myron Stowe <myron.stowe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andi Kleen <ak-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, Arnaldo Carvalho de Melo <acme-f8uhVLnGfZaxAyOMLChx1axOck334EZe@public.gmane.org>, "H.
	Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Cyrill Gorcunov <gorcunov-GEFAQzZX7r8dnm+yROfE0A@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>, Sebastian Andrzej Siewior <sebastian-E0PNVn5OA6ohrxcnuTQ+TQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Konrad,

                      Thanks for your response.  When writing the driver, at AMD, I am provided an internal IOMMUv2.x specification that may not be out in the public as of yet; I am following up on this and will comment on the availability concerning this version.   Also, I checked the v2.0 of the IOMMU Specification, specifically the following:

MMIO Offset [40-7F][0-F]08h IOMMU Counter Source Register - Table 64: Architectural Counter Input Group : This is the CSource and the format can be found in /sys/bus/event_sources/devices/iommuv2/forrmat/
MMIO Offset [40-7F][0-F]20h IOMMU DeviceID Match Register - For the following three registers, the config value defines the Match and config1 value defines the Mask; see the specification v2.0 for details; also see sys/...../format for details.
MMIO Offset [40-7F][0-F]10h IOMMU PASID Match Register - 
MMIO Offset [40-7F][0-F]18h IOMMU Domain Match Register - 

The one caveat between the v2.0 and v2.5 concerns a slight expansion of the CSource register Input Group, but any event defined within v2.0 will execute properly regarding the driver patch(es) sent to the kernel community.

Please let me know, in any way, how I can better this driver code and I will make it so.  Also, Will have an answer for you regarding AMD IOMMUv2.5 ASAP.

Thanks again for your comments, appreciated.

-----Original Message-----
From: Konrad Rzeszutek Wilk [mailto:konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org] 
Sent: Tuesday, January 22, 2013 11:48 AM
To: Kinney, Steven
Cc: Thomas Gleixner; Ingo Molnar; H. Peter Anvin; x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; Joerg Roedel; Kukjin Kim; Peter Zijlstra; Stephen Warren; Greg Kroah-Hartman; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; Cyrill Gorcunov; Sebastian Andrzej Siewior; Andi Kleen; Paul Mackerras; Arnaldo Carvalho de Melo; Jiri Kosina; Bjorn Helgaas; Myron Stowe; Thomas Renninger
Subject: Re: [PATCH 0/3] AMD IOMMUv2 Performance Counter patches

On Mon, Jan 21, 2013 at 02:20:55PM -0600, Steven L. Kinney wrote:
> From: "Steven L. Kinney" <steven.kinney-5C7GfCeVMHo@public.gmane.org>
> 
> These patches implement the AMD IOMMUv2.5 Performance Counter 
> functionality via custom perf PMU and implement static counting for 
> various IOMMU translations.  The patches address three areas of functionality:
> 
> 1) 	Add a PCI quirk for the enablement of IOMMUv2 EFR PC within a specific
> 	AMD family/model in which BIOS has not enabled.  Based on code 
> 	implemented by Andreas Herrmann at AMD Dresden.
> 2)	Extend the AMD IOMMU initialization to include IOMMUv2 PC enablement
> 	and access to IOMMUv2 counter registers.  For all AMD family/models
> 	that implement IOMMUv2.5 functionality.
> 3)	Code the perf IOMMUv2 PMU to manage IOMMUv2 perf events, which call
> 	the function(s) extending the AMD IOMMU core driver.  For all AMD
> 	family/models that implement IOMMUv2.5 functionality.
> 
> The command-line, to invoke the iommuv2 PMU, is:
> 
> perf stat -e iommuv2/config=[data],config1=[data]/{u,r} [command]
> 
> For information regarding AMD IOMMU v2.5 PC configuration, see the 
> public specification.

Is there a name for it? I see
http://support.amd.com/us/Processor_TechDocs/48882.pdf
but that looks to be for v2.0?
> 
> Steven L. Kinney (3):
>   AMD x86 quirks: Quirk for enabling IOMMUv2 PC feature
>   AMD IOMMUv2 PC resource management hooks
>   AMD IOMMUv2 PC perf PMU implementation
> 
>  arch/x86/kernel/cpu/Makefile                 |    1 +
>  arch/x86/kernel/cpu/perf_event_amd_iommuv2.c |  429 ++++++++++++++++++++++++++
>  arch/x86/kernel/cpu/perf_event_amd_iommuv2.h |   42 +++
>  arch/x86/kernel/quirks.c                     |   17 +
>  drivers/iommu/Kconfig                        |   10 +
>  drivers/iommu/amd_iommu_init.c               |   99 ++++++
>  drivers/iommu/amd_iommu_types.h              |   12 +
>  include/linux/pci_ids.h                      |    2 +
>  8 files changed, 612 insertions(+)
>  create mode 100644 arch/x86/kernel/cpu/perf_event_amd_iommuv2.c
>  create mode 100644 arch/x86/kernel/cpu/perf_event_amd_iommuv2.h
> 
> --
> 1.7.9.5
> 
> 
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
