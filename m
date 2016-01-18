From: "Lawrynowicz, Jacek" <jacek.lawrynowicz-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] iommu/vt-d: Add support for multiple DMA aliases
Date: Mon, 18 Jan 2016 12:00:38 +0000
Message-ID: <36D38C1F74839847A52A484C31F3E51A62122902@irsmsx105.ger.corp.intel.com>
References: <1452518415-97637-1-git-send-email-jacek.lawrynowicz@intel.com>
	<1452720505.88154.71.camel@infradead.org>
	<CAErSpo5zVXk8XCjhMvwa3OxmDpDYx5gTH7FpWREwGVJB2UR6_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAErSpo5zVXk8XCjhMvwa3OxmDpDYx5gTH7FpWREwGVJB2UR6_Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: "iommu-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org" <iommu-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org>, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

> -----Original Message-----
> From: Bjorn Helgaas [mailto:bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org]
> Sent: Friday, January 15, 2016 7:23 PM
> To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
> Cc: Lawrynowicz, Jacek <jacek.lawrynowicz-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>;
> iommu-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org; Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> Subject: Re: [PATCH] iommu/vt-d: Add support for multiple DMA aliases
> 
> On Wed, Jan 13, 2016 at 1:28 PM, David Woodhouse
> <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org> wrote:
> > On Mon, 2016-01-11 at 14:20 +0100, Jacek Lawrynowicz wrote:
> >> This patch solves IOMMU support issues with PCIe non-transparent
> >> bridges that use Requester ID look-up tables (LUT), e.g. PEX8733.
> >> Before exiting the bridge, packet's RID is rewritten according to LUT
> >> programmed by a driver. Modified packets are then passed to a
> >> destination bus and processed upstream. The problem is that such
> >> packets seem to come from non-existent nodes that are hidden behind
> >> NTB and are not discoverable by a destination node, so IOMMU discards
> >> them. Adding DMA alias for a given LUT entry allows IOMMU to create a
> >> proper mapping that enables inter-node communication.
> >>
> >> The current DMA alias implementation supports only single alias, so
> >> it's not possible to connect more than two nodes when IOMMU is
> >> enabled. This implementation enables all possible aliases on a given
> >> bus (256) that are stored in a bitset. Alias devfn is directly
> >> translated to a bit number. The bitset is not allocated for devices
> >> that have no need for DMA aliases.
> >>
> >> More details can be found in following article:
> >>
> http://www.plxtech.com/files/pdf/technical/expresslane/RTC_Enabling%2
> >> 0MulitHostSystemDesigns.pdf
> >>
> >> Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> >
> > Acked-by: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> >
> > Strictly speaking, this is more in PCI code than IOMMU code. And it
> > doesn't actually touch the Intel VT-d code at all; the subject is a
> > bit misleading.
> >
> > But I'm happy enough to add it to my intel-iommu tree if nobody else
> > picks it up. Bjorn?
> 
> Jacek, would you mind posting this to linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, please?

Sure, no problem.

--
Jacek Lawrynowicz
Intel Technology Poland sp. z o.o.
KRS 101882 - ul. Slowackiego 173, 80-298 Gdansk
