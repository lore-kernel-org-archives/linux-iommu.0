From: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: DMA_ALIAS_DEVFN issue
Date: Fri, 14 Nov 2014 21:25:55 -0700
Message-ID: <CAErSpo7m9xMy9buOmF==8H_VSkBBqPZD1_OCPYjEz_1Q1n4y0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Allan, Bruce W" <bruce.w.allan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

[+cc Alex, add a subject]

On Fri, Nov 14, 2014 at 6:49 PM, Allan, Bruce W <bruce.w.allan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> Let's try this again as plain text...
>
> For a PCIe device with SR-IOV support enabled (e.g. the PF device ID is 0xf001 at 0000:07:00.0 and the 16 VFs have device ID 0xf002 at 0000:07:01.0 through 0000:07:02.7), if the hardware attempts a DMA read/write of memory that was mapped by the PF devfn but instead uses a requester id of one of the VF devfns (enabled but not yet assigned to a VM) it fails and generates log messages similar to:
>
> [  416.800881] dmar: DRHD: handling fault status reg 2
> [  416.800887] dmar: DMAR:[DMA Read] Request device [07:02.2] fault addr ffff0000
> DMAR:[fault reason 02] Present bit in context entry is clear
>
> Shouldn't a DMA alias quirk that sets the PCI_DEV_FLAGS_DMA_ALIAS_DEVFN flag and dma_alias_devfn to the PF devfn for all VF devfns work-around this issue, or am I misunderstanding what a DMA alias quirk is supposed to do?  If a DMA alias quirk cannot resolve this, what is the most appropriate way to handle this?
>
> Thanks,
> Bruce.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
