From: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2] iommu/vt-d: Fix broken device issue when using iommu=pt
Date: Tue, 26 Aug 2014 10:03:19 +0800
Message-ID: <53FBEAE7.5060500@huawei.com>
References: <1408949099-18677-1-git-send-email-wangyijing@huawei.com>
	<20140825091531.GG16329@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140825091531.GG16329-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Sathya Perla <sathya.perla-laKkSmNT4hbQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Subbu Seetharaman <subbu.seetharaman-laKkSmNT4hbQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 2014/8/25 17:15, Joerg Roedel wrote:
> [Adding the Emulex driver developers to Cc for some input on the device,
>  and why it might use wrong request ids]

Thanks!

> 
> On Mon, Aug 25, 2014 at 02:44:59PM +0800, Yijing Wang wrote:
>> We found some strange devices in HP C7000 and Huawei Storage Server. These
...
>> [ 1438.703851] DMAR:[fault reason 02] Present bit in context entry is clear
>>
>> This patch add a kernel boot command parameter iommu=pt_force=domain:busnum
>> that based iommu identity mapping and force to create identity for all devfn in
>> the specific bus number to fix this issue.
> 
> No! If the device really uses request-ids it shouldn't use please add a
> DMA alias quirk instead. A new kernel parameter will not work out of the
> box for other users of this device.

Hi Joerg, It seems not wrong request id of the physical device.

Because I configured the eth4(pci id is 04:00.1), and the network is good, no problems found.
If eth4(04:00.1) use the wrong request-id, I think network dma should be blocked by IOMMU, but it not.
So I don't know where the request-id 04:00.4/5/6/7 come from. Maybe Sathya can help me to find that. :)


 \-[0000:00]-+-00.0  Intel Corporation Xeon E5/Core i7 DMI2
             +-01.0-[11]--
             +-01.1-[02]--
             +-02.0-[04]--+-00.0  Emulex Corporation OneConnect 10Gb NIC (be3)
             |            +-00.1  Emulex Corporation OneConnect 10Gb NIC (be3)
             |            +-00.2  Emulex Corporation OneConnect 10Gb iSCSI Initiator (be3)
             |            \-00.3  Emulex Corporation OneConnect 10Gb iSCSI Initiator (be3)


> 
> 
> 	Joerg
> 
> 
> .
> 


-- 
Thanks!
Yijing
