From: Federico Vaga <federico.vaga-VIMSii5OdOuonA0d6jMUrA@public.gmane.org>
Subject: IOMMU - DMA debugging
Date: Wed, 12 Jul 2017 09:11:32 +0200
Message-ID: <1807773.bRUB8Ke59R@harkonnen>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hello,

kernel version 4.4.x

I'm facing an issue with the INTEL IOMMU driver and DMA mapping. I have an 
Ethernet driver that uses `dma_alloc_coherent()` to allocate and map some 
memory for DMA transfers.

The driver uses the DMA API as described in the documentation and I was 
expecting the IOMMU to be transparent, but apparently it is not. When the 
IOMMU is disabled the driver works fine, but when `intel_iommu=on|pt` then it 
does not work

I enabled the iommu events in ftrace at boot time; a weird thing that I 
noticed is that I do not see any map/unmap event in ftrace while I was 
expecting to have some of them.

How can be debugged this kind of issue? Where should I look for troubles 
(BIOS, Linux kernel, the ethernet driver, the ethernet device, PCI bridges)? 

Following the typical errors when `intel_iommu=on|pt`

Thank you



[...]
[ 1156.858606] DMAR: DRHD: handling fault status reg 302
[ 1156.864249] DMAR: DMAR:[DMA Read] Request device [02:00.0] fault addr 
3febf0
[ 1156.864249] DMAR:[fault reason 06] PTE Read access is not set
[ 1189.179531] DMAR: DRHD: handling fault status reg 402
[ 1189.185182] DMAR: DMAR:[DMA Write] Request device [02:00.0] fault addr 
6d9c7
[ 1189.185182] DMAR:[fault reason 05] PTE Write access is not set
[ 1196.313544] DMAR: DRHD: handling fault status reg 502
[ 1196.319194] DMAR: DMAR:[DMA Write] Request device [02:00.0] fault addr 
657bb
[ 1196.319194] DMAR:[fault reason 05] PTE Write access is not set
[ 1230.607870] DMAR: DRHD: handling fault status reg 602
[ 1230.613520] DMAR: DMAR:[DMA Write] Request device [02:00.0] fault addr 
16cfe
[ 1230.613520] DMAR:[fault reason 05] PTE Write access is not set
[ 1236.314332] DMAR: DRHD: handling fault status reg 702
[ 1236.319983] DMAR: DMAR:[DMA Write] Request device [02:00.0] fault addr 
6e59e
[ 1236.319983] DMAR:[fault reason 05] PTE Write access is not set
[ 1246.314521] DMAR: DRHD: handling fault status reg 2
[ 1246.319979] DMAR: DMAR:[DMA Write] Request device [02:00.0] fault addr 
7e59f
[ 1246.319979] DMAR:[fault reason 05] PTE Write access is not set
[ 1261.169485] DMAR: DRHD: handling fault status reg 102
[ 1261.175135] DMAR: DMAR:[DMA Write] Request device [02:00.0] fault addr 
7ddee
[ 1261.175135] DMAR:[fault reason 05] PTE Write access is not set
[ 1272.640611] DMAR: DRHD: handling fault status reg 202
[ 1272.646261] DMAR: DMAR:[DMA Write] Request device [02:00.0] fault addr 
7bbee
[ 1272.646261] DMAR:[fault reason 05] PTE Write access is not set

-- 
Federico Vaga
http://www.federicovaga.it/
