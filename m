From: Alexey Kardashevskiy <aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org>
Subject: Re: [PATCH 1/6 v8] iommu/fsl: Store iommu domain information pointer
	in archdata.
Date: Fri, 01 Mar 2013 12:24:55 +1100
Message-ID: <51300367.6080300@ozlabs.ru>
References: <1361191939-21260-1-git-send-email-Varun.Sethi@freescale.com>
	<1361191939-21260-2-git-send-email-Varun.Sethi@freescale.com>
	<20130227113045.GH26252@8bytes.org>
	<C5ECD7A89D1DC44195F34B25E172658D3C26F6@039-SN2MPN1-013.039d.mgd.msft.net>
	<BAB98EA5-5324-4FB2-97C2-A28A96C569DC@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <BAB98EA5-5324-4FB2-97C2-A28A96C569DC-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Cc: Wood Scott-B07421 <B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org list" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Yoder Stuart-B08248 <B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org list" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, David Gibson <david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi!

On POWERNV we use only the part of IOMMU API which handles devices and 
groups. We do not use IOMMU domains as VFIO containers do everything we 
need for VFIO and we do not implement iommu_ops as it is not very relevant 
to our architecture (does not give dma window properties, etc).

So your work does not overlap with my work :)


On 01/03/13 02:51, Kumar Gala wrote:
>
> On Feb 27, 2013, at 6:04 AM, Sethi Varun-B16395 wrote:
>
>> Hi Kumar,Ben,
>> I am implementing the Freescale PAMU (IOMMU) driver using the Linux IOMMU API. In this particular patch, I have added a new field to dev_archdata structure to store the dma domain information.
>> This field is updated whenever we attach a device to an iommu domain.
>>
>> Regards
>> Varun
>
> Would be good to see if this overlaps with Alexey's work for IOMMU driver for powernv.
>
> - k
>
>>
>>> -----Original Message-----
>>> From: Joerg Roedel [mailto:joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org]
>>> Sent: Wednesday, February 27, 2013 5:01 PM
>>> To: Sethi Varun-B16395
>>> Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org;
>>> linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Wood Scott-B07421; Yoder Stuart-B08248
>>> Subject: Re: [PATCH 1/6 v8] iommu/fsl: Store iommu domain information
>>> pointer in archdata.
>>>
>>> On Mon, Feb 18, 2013 at 06:22:14PM +0530, Varun Sethi wrote:
>>>> Add a new field in the device (powerpc) archdata structure for storing
>>>> iommu domain information pointer. This pointer is stored when the
>>>> device is attached to a particular domain.
>>>>
>>>>
>>>> Signed-off-by: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
>>>> ---
>>>> - no change.
>>>> arch/powerpc/include/asm/device.h |    4 ++++
>>>> 1 files changed, 4 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/arch/powerpc/include/asm/device.h
>>>> b/arch/powerpc/include/asm/device.h
>>>> index 77e97dd..6dc79fe 100644
>>>> --- a/arch/powerpc/include/asm/device.h
>>>> +++ b/arch/powerpc/include/asm/device.h
>>>> @@ -28,6 +28,10 @@ struct dev_archdata {
>>>> 		void		*iommu_table_base;
>>>> 	} dma_data;
>>>>
>>>> +	/* IOMMU domain information pointer. This would be set
>>>> +	 * when this device is attached to an iommu_domain.
>>>> +	 */
>>>> +	void			*iommu_domain;
>>>
>>> Please Cc the PowerPC Maintainers on this, so that they can have a look
>>> at it. This also must be put this into an #ifdef CONFIG_IOMMU_API.


-- 
Alexey	
