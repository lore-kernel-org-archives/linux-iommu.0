From: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 0/3] AMD IOMMUv2 Performance Counter patches
Date: Tue, 22 Jan 2013 12:48:03 -0500
Message-ID: <20130122174803.GF8365@phenom.dumpdata.com>
References: <1358799658-6236-1-git-send-email-steven.kinney@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1358799658-6236-1-git-send-email-steven.kinney-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Steven L. Kinney" <steven.kinney-5C7GfCeVMHo@public.gmane.org>
Cc: Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Peter Zijlstra <a.p.zijlstra-/NLkJaSkS4VmR6Xm/wNWPw@public.gmane.org>, Myron Stowe <myron.stowe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andi Kleen <ak-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, Arnaldo Carvalho de Melo <acme-f8uhVLnGfZaxAyOMLChx1axOck334EZe@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Cyrill Gorcunov <gorcunov-GEFAQzZX7r8dnm+yROfE0A@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>, Sebastian Andrzej Siewior <sebastian-E0PNVn5OA6ohrxcnuTQ+TQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Jan 21, 2013 at 02:20:55PM -0600, Steven L. Kinney wrote:
> From: "Steven L. Kinney" <steven.kinney-5C7GfCeVMHo@public.gmane.org>
> 
> These patches implement the AMD IOMMUv2.5 Performance Counter functionality
> via custom perf PMU and implement static counting for various IOMMU
> translations.  The patches address three areas of functionality:
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
> For information regarding AMD IOMMU v2.5 PC configuration, see the public
> specification.

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
