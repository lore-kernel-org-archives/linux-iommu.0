From: Sathya Perla <Sathya.Perla-iH1Dq9VlAzfQT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH v2] iommu/vt-d: Fix broken device issue when using iommu=pt
Date: Mon, 25 Aug 2014 09:32:43 +0000
Message-ID: <8dada92a-19af-4b77-b917-f2d97291abbe@CMEXHTCAS2.ad.emulex.com>
References: <1408949099-18677-1-git-send-email-wangyijing@huawei.com>
	<20140825091531.GG16329@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140825091531.GG16329-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Subramanian Seetharaman <subbu.seetharaman-laKkSmNT4hbQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

> -----Original Message-----
> From: Joerg Roedel [mailto:joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org]
> 
> [Adding the Emulex driver developers to Cc for some input on the device,
>  and why it might use wrong request ids]
> 
> On Mon, Aug 25, 2014 at 02:44:59PM +0800, Yijing Wang wrote:
> > We found some strange devices in HP C7000 and Huawei Storage Server.
> These
> > devices can not be enumerated by OS, but they still did DMA read/write
> > without OS management. Because iommu will not create the DMA
> mapping for
> > these devices, the DMA read/write will be blocked by iommu hardware.

Hi Wang, could you please share the lspci -vvv output and the kernel log too.
Thanks!

> >
> > Eg.
> > in HP C7000:
> >  \-[0000:00]-+-00.0  Intel Corporation Xeon E5/Core i7 DMI2
> >              +-01.0-[11]--
> > 			 +-01.1-[02]--
> > 			 +-02.0-[04]--+-00.0  Emulex Corporation OneConnect
> 10Gb NIC (be3)
> > 	         |            +-00.1  Emulex Corporation OneConnect 10Gb NIC (be3)
> > 	         |            +-00.2  Emulex Corporation OneConnect 10Gb iSCSI
> Initiator (be3)
> > 	         |            \-00.3  Emulex Corporation OneConnect 10Gb iSCSI
> Initiator (be3)
> > 	         +-02.1-[12]--
> > Kernel only found four devices in bus 0x04, but we found following DMA
> errors in dmesg.
> >
> > [ 1438.477262] DRHD: handling fault status reg 402
> > [ 1438.498278] DMAR:[DMA Write] Request device [04:00.4] fault addr
> bdf70000
> > [ 1438.498280] DMAR:[fault reason 02] Present bit in context entry is clear
> > [ 1438.566458] DMAR:[DMA Write] Request device [04:00.5] fault addr
> bdf70000
> > [ 1438.566460] DMAR:[fault reason 02] Present bit in context entry is clear
> > [ 1438.635211] DMAR:[DMA Write] Request device [04:00.6] fault addr
> bdf70000
> > [ 1438.635213] DMAR:[fault reason 02] Present bit in context entry is clear
> > [ 1438.703849] DMAR:[DMA Write] Request device [04:00.7] fault addr
> bdf70000
> > [ 1438.703851] DMAR:[fault reason 02] Present bit in context entry is clear
> >
> > This patch add a kernel boot command parameter
> iommu=pt_force=domain:busnum
> > that based iommu identity mapping and force to create identity for all
> devfn in
> > the specific bus number to fix this issue.
> 
> No! If the device really uses request-ids it shouldn't use please add a
> DMA alias quirk instead. A new kernel parameter will not work out of the
> box for other users of this device.
