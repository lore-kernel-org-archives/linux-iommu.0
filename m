From: Jonathan Cameron <Jonathan.Cameron-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Preferred method to detect if a device is behind an enabled iommu.
Date: Thu, 1 Feb 2018 10:18:21 +0000
Message-ID: <20180201101821.00006a16@huawei.com>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi All,

We have a crypto accelerator which needs to have a few different settings
depending on whether or not the SMMUv3 is enabled and translating addresses
or not.

https://marc.info/?l=linux-crypto-vger&m=151732626428206&w=2

1) A quirk of the hardware revision means we need to turn some elements
   off if the iommu is enabled.
2) The device has certain cache related settings that means it needs to know
   if it is dealing with VAs or PAs.

Current approach is to see if the iommu_group is set in struct device.

We could fine one instance of another driver doing this and copied that,
(drivers/dma/rcar-dmac.c)
but the precedence is weak enough that confirmation would be good.
So whilst it 'works' the question is whether it is safe in general
and whether there is a better way.

Thanks,

--
Jonathan Cameron
Huawei
