From: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 0/4] Remove dead code
Date: Thu, 20 Feb 2014 18:30:15 -0700
Message-ID: <CAErSpo7z9-gTGLHT8gOGC-KHek-kzNBtWVMWQEU8DWn3PekmTw@mail.gmail.com>
References: <20140218205925.11014.14973.stgit@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140218205925.11014.14973.stgit-1RhO1Y9PlrlHTL0Zs8A6p5iNqAH0jzoTYJqu5kTmcBRl57MIdRCFDg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "e1000-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <e1000-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Sudeep Dutt <sudeep.dutt-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Hemminger <stephen-OTpzqLSitTUnbdJkjeBofR2eb7JE58TQ@public.gmane.org>, "open list:INTEL IOMMU (VT-d)" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Tomas Winkler <tomas.winkler-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Aaron F Brown <aaron.f.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Arjan van de Ven <arjan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Feb 18, 2014 at 1:59 PM, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org> wrote:
> This is v2 of my rework of part of Stephen's patch [1].  My v1 posting,
> with a little discussion, is here [2].
>
> This removes SR-IOV migration support, which seems to be unused.
>
> Changes since v1:
>   - Drop the removal of MMIO exclusivity.
>   - Add a few includes of <linux/irqreturn.h>.  The SR-IOV migration
>     support included irqreturn.h via linux/pci.h, and a few drivers relied
>     on that.  So this v2 series updates those drivers to include
>     irqreturn.h directly.
>
> Unless there's objection, I'd like to merge all these through my PCI tree
> for v3.15.

I applied these to my pci/dead-code branch, which is now in -next, for v3.15.

> Bjorn
>
> [1] http://lkml.kernel.org/r/20131227132710.7190647c-We1ePj4FEcvRI77zikRAJc56i+j3xesD0e7PPNI6Mm0@public.gmane.org
> [2] https://lkml.kernel.org/r/20140130192011.25426.45702.stgit-1RhO1Y9PlrlHTL0Zs8A6p5iNqAH0jzoTYJqu5kTmcBRl57MIdRCFDg@public.gmane.org
>
> ---
>
> Bjorn Helgaas (4):
>       misc: mic: Add include of <linux/irqreturn.h>
>       mei: Add include of <linux/irqreturn.h>
>       iommu/amd: Add include of <linux/irqreturn.h>
>       PCI: Remove unused SR-IOV VF Migration support
>
>
>  Documentation/PCI/pci-iov-howto.txt |    4 -
>  drivers/iommu/amd_iommu_types.h     |    1
>  drivers/misc/mei/hw-me.h            |    1
>  drivers/misc/mic/card/mic_device.h  |    1
>  drivers/misc/mic/host/mic_device.h  |    1
>  drivers/pci/iov.c                   |  119 -----------------------------------
>  drivers/pci/pci.h                   |    4 -
>  include/linux/pci.h                 |    4 -
>  8 files changed, 4 insertions(+), 131 deletions(-)
