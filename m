From: Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH 1/4 v2] iommu/fsl: Store iommu domain information pointer
	in archdata.
Date: Wed, 28 Nov 2012 11:35:28 -0600
Message-ID: <93330D7F-0A5A-4C42-A10C-92D6C7694D44@kernel.crashing.org>
References: <1353419697-31269-1-git-send-email-Varun.Sethi@freescale.com>
	<1353419697-31269-2-git-send-email-Varun.Sethi@freescale.com>
	<C5ECD7A89D1DC44195F34B25E172658D29AE62@039-SN2MPN1-013.039d.mgd.msft.net>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <C5ECD7A89D1DC44195F34B25E172658D29AE62-RL0Hj/+nBVDYdknt8GnhQq4g8xLGJsHaLnY5E4hWTkheoWH0uzbU5w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sethi Varun-B16395 <B16395-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Wood Scott-B07421 <B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Tabi Timur-B04825 <B04825-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


On Nov 25, 2012, at 11:33 PM, Sethi Varun-B16395 wrote:

> Hi Kumar,
> Can you please apply this patch.
> 
> Regards
> Varun

Was waiting on the others to apply this all together.  (ie getting an Ack from Joerg, and follow comments from Timur to be resolved)

- k

> 
>> -----Original Message-----
>> From: Sethi Varun-B16395
>> Sent: Tuesday, November 20, 2012 7:25 PM
>> To: joerg.roedel-5C7GfCeVMHo@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linuxppc-
>> dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Wood Scott-B07421;
>> Tabi Timur-B04825
>> Cc: Sethi Varun-B16395
>> Subject: [PATCH 1/4 v2] iommu/fsl: Store iommu domain information pointer
>> in archdata.
>> 
>> Add a new field in the device (powerpc) archdata structure for storing
>> iommu domain information pointer. This pointer is stored when the device
>> is attached to a particular domain.
>> 
>> Signed-off-by: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
>> ---
>> arch/powerpc/include/asm/device.h |    4 ++++
>> 1 files changed, 4 insertions(+), 0 deletions(-)
>> 
>> diff --git a/arch/powerpc/include/asm/device.h
>> b/arch/powerpc/include/asm/device.h
>> index 77e97dd..6dc79fe 100644
>> --- a/arch/powerpc/include/asm/device.h
>> +++ b/arch/powerpc/include/asm/device.h
>> @@ -28,6 +28,10 @@ struct dev_archdata {
>> 		void		*iommu_table_base;
>> 	} dma_data;
>> 
>> +	/* IOMMU domain information pointer. This would be set
>> +	 * when this device is attached to an iommu_domain.
>> +	 */
>> +	void			*iommu_domain;
>> #ifdef CONFIG_SWIOTLB
>> 	dma_addr_t		max_direct_dma_addr;
>> #endif
>> --
>> 1.7.4.1
> 
