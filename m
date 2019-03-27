From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 0/3] PCIe Host request to reserve IOVA
Date: Wed, 27 Mar 2019 15:02:21 +0000
Message-ID: <c92e07d7-78b2-d4ec-bf1a-29070a9d4145@arm.com>
References: <1548411231-27549-1-git-send-email-srinath.mannam@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1548411231-27549-1-git-send-email-srinath.mannam-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Srinath Mannam <srinath.mannam-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, poza-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 25/01/2019 10:13, Srinath Mannam wrote:
> Few SOCs have limitation that their PCIe host can't allow few inbound
> address ranges. Allowed inbound address ranges are listed in dma-ranges
> DT property and this address ranges are required to do IOVA mapping.
> Remaining address ranges have to be reserved in IOVA mapping.
> 
> PCIe Host driver of those SOCs has to list all address ranges which have
> to reserve their IOVA address into PCIe host bridge resource entry list.
> IOMMU framework will reserve these IOVAs while initializing IOMMU domain.

FWIW I'm still only interested in solving this problem generically, 
because in principle it's not specific to PCI, for PCI it's certainly 
not specific to iproc, and either way it's not specific to DT. That 
said, I don't care strongly enough to keep pushing back on this 
implementation outright, since it's not something which couldn't be 
cleaned up 'properly' in future.

One general comment I'd make, though, is that AFAIK PCI has a concept of 
inbound windows much more than it has a concept of gaps-between-windows, 
so if the PCI layer is going to track anything it should probably be the 
actual windows, and leave the DMA layer to invert them into the 
reservations it cares about as it consumes the list. That way you can 
also avoid the undocumented requirement for the firmware to keep the 
ranges property sorted in the first place.

Robin.

> 
> This patch set is based on Linux-5.0-rc2.
> 
> Changes from v2:
>    - Patch set rebased to Linux-5.0-rc2
> 
> Changes from v1:
>    - Addressed Oza review comments.
> 
> Srinath Mannam (3):
>    PCI: Add dma-resv window list
>    iommu/dma: Reserve IOVA for PCI host reserve address list
>    PCI: iproc: Add dma reserve resources to host
> 
>   drivers/iommu/dma-iommu.c           |  8 ++++++
>   drivers/pci/controller/pcie-iproc.c | 51 ++++++++++++++++++++++++++++++++++++-
>   drivers/pci/probe.c                 |  3 +++
>   include/linux/pci.h                 |  1 +
>   4 files changed, 62 insertions(+), 1 deletion(-)
> 
