From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 00/15] PCI/iommu: Fix DMA alias problems
Date: Sat, 10 May 2014 07:17:49 -0600
Message-ID: <1399727869.17639.157.camel@ul30vt.home>
References: <20140510121542.5359.qmail@ns.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140510121542.5359.qmail-HzZAx2gCgqrSUeElwK9/Pw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: George Spelvin <linux-gpGsJRJZ3PBBDgjK7y7TUQ@public.gmane.org>
Cc: bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TZC2OdSoraRkg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Sat, 2014-05-10 at 08:15 -0400, George Spelvin wrote:
> Well, chalk up one test failure.
> 
> I'm running a GA-X79-UP4 motherboard with VT-d enabled.
> It has 3x Marvell SATA controllers:
> 05:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9172 SATA 6Gb/s Controller (rev 11)
> 06:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9172 SATA 6Gb/s Controller (rev 11)
> 07:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9172 SATA 6Gb/s Controller (rev 11)

What's the device ID of these devices?

> With Andrew's patch from https://bugzilla.kernel.org/show_bug.cgi?id=42679#c22
> the Marvell SATA ports work.  With your dma-alias branch (rebased onto 3.15-rc5),
> the ports don't work:

The dma-alias branch only has the v1 patchset.  There are several more
Marvell devices included in the quirks in the v2 set.  Please re-test
with this code.  Thanks,

Alex

> -ata7.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
> -dmar: DRHD: handling fault status reg 502
> -dmar: DMAR:[DMA Write] Request device [05:00.1] fault addr fffc0000 
> -DMAR:[fault reason 02] Present bit in context entry is clear
> -dmar: DMAR:[DMA Write] Request device [05:00.1] fault addr fffe0000 
> -DMAR:[fault reason 02] Present bit in context entry is clear
> -dmar: DRHD: handling fault status reg 700
> -dmar: DRHD: handling fault status reg 702
> -dmar: DMAR:[DMA Write] Request device [05:00.1] fault addr fffc0000 
> -DMAR:[fault reason 02] Present bit in context entry is clear
> -dmar: DMAR:[DMA Write] Request device [05:00.1] fault addr fffe0000 
> -DMAR:[fault reason 02] Present bit in context entry is clear
> -dmar: DRHD: handling fault status reg 100
> -ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> -ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> -dmar: DRHD: handling fault status reg 102
> -dmar: DMAR:[DMA Write] Request device [05:00.1] fault addr fffc0000 
> -DMAR:[fault reason 02] Present bit in context entry is clear
> -ata8.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
> -ata8: limiting SATA link speed to 1.5 Gbps
> -ata7.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
> -ata7: limiting SATA link speed to 1.5 Gbps
> -dmar: DRHD: handling fault status reg 202
> -dmar: DMAR:[DMA Write] Request device [05:00.1] fault addr fffc0000 
> -DMAR:[fault reason 02] Present bit in context entry is clear
> -dmar: DMAR:[DMA Write] Request device [05:00.1] fault addr fffe0000 
> -DMAR:[fault reason 02] Present bit in context entry is clear
> -dmar: DRHD: handling fault status reg 400
