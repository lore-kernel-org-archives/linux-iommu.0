From: Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [RFC][PATCH 2/3] iommu/fsl: Add iommu domain attributes required
	by fsl PAMU driver.
Date: Thu, 20 Sep 2012 08:19:13 -0500
Message-ID: <84F4C3DA-4B61-4D1D-9FB3-B3F520BFE022@kernel.crashing.org>
References: <1348060632-12997-1-git-send-email-b16395@freescale.com>
	<1348060632-12997-3-git-send-email-b16395@freescale.com>
	<6B8A3365-C97E-4742-A0DD-D8FD6BA358EB@kernel.crashing.org>
	<1348099936.22800.21@snotra>
	<C5ECD7A89D1DC44195F34B25E172658D1A49A2@039-SN2MPN1-013.039d.mgd.msft.net>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <C5ECD7A89D1DC44195F34B25E172658D1A49A2-RL0Hj/+nBVDYdknt8GnhQq4g8xLGJsHaLnY5E4hWTkheoWH0uzbU5w@public.gmane.org>
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
Cc: Wood Scott-B07421 <B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


On Sep 20, 2012, at 4:46 AM, Sethi Varun-B16395 wrote:

> 
> 
>> -----Original Message-----
>> From: Wood Scott-B07421
>> Sent: Thursday, September 20, 2012 5:42 AM
>> To: Kumar Gala
>> Cc: Sethi Varun-B16395; joerg.roedel-5C7GfCeVMHo@public.gmane.org; iommu-cunTk1MwBs/ROKNJybVBZg@public.gmane.org
>> foundation.org; linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org; linux-
>> kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Sethi Varun-B16395
>> Subject: Re: [RFC][PATCH 2/3] iommu/fsl: Add iommu domain attributes
>> required by fsl PAMU driver.
>> 
>> On 09/19/2012 08:52:27 AM, Kumar Gala wrote:
>>> 
>>> On Sep 19, 2012, at 8:17 AM, <b16395-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
>>> <b16395-KZfg59tc24xl57MIdRCFDg@public.gmane.org> wrote:
>>> 
>>>> From: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
>>>> 
>>>> Added the following domain attributes required by FSL PAMU driver:
>>>> 1. Subwindows field added to the iommu domain geometry attribute.
>>>> 2. Added new iommu stash attribute, which allows setting of the
>>>>  LIODN specific stash id parameter through IOMMU API.
>>>> 3. Added an attribute for enabling/disabling DMA to a particular
>>>>  memory window.
>>>> 
>>>> Signed-off-by: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
>>>> ---
>>>> include/linux/iommu.h |   30 ++++++++++++++++++++++++++++++
>>>> 1 files changed, 30 insertions(+), 0 deletions(-)
>>>> 
>>>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h index
>>>> 7e83370..eaa40c6 100644
>>>> --- a/include/linux/iommu.h
>>>> +++ b/include/linux/iommu.h
>>>> @@ -44,6 +44,28 @@ struct iommu_domain_geometry {
>>>> 	dma_addr_t aperture_start; /* First address that can be
>>> mapped    */
>>>> 	dma_addr_t aperture_end;   /* Last address that can be
>>> mapped     */
>>>> 	bool force_aperture;       /* DMA only allowed in mappable
>>> range? */
>>>> +
>>>> +	/* The subwindows field indicates number of DMA subwindows
>>> supported
>>>> +	 * by the geometry. Following is the interpretation of
>>>> +	 * values for this field:
>>>> +	 * 0 : This implies that the supported geometry size is 1 MB
>>>> +         * with each subwindow size being 4KB. Thus number of
>>> subwindows
>>>> +	 * being = 1MB/4KB = 256.
>>>> +	 * 1 : Only one DMA window i.e. no subwindows.
>>>> +	 * value other than 0 or 1 would indicate actual number of
>>> subwindows.
>>>> +	 */
>>>> +	u32 subwindows;
>>>> +};
>>>> +
>>>> +/* This attribute corresponds to IOMMUs capable of generating
>>>> + * a stash transaction. A stash transaction is typically a
>>>> + * hardware initiated prefetch of data from memory to cache.
>>>> + * This attribute allows configuring stashig specific parameters
>>>> + * in the IOMMU hardware.
>>>> + */
>>>> +struct iommu_stash_attribute {
>>>> +	u32 	cpu;	/* cpu number */
>>>> +	u32 	cache;	/* cache to stash to: L1,L2,L3 */
>>> 
>>> seems like this should be enum instead of u32 for cache
>>> 
>>> With enum being something like:
>>> 
>>> enum iommu_attr_stash_cache {
>>> 	IOMMU_ATTR_CACHE_L1,
>>> 	IOMMU_ATTR_CACHE_L2,
>>> 	IOMMU_ATTR_CACHE_L3,
>>> };
>> 
>> Don't we want these structs to be usable via some VFIO ioctl?  In that
>> case they need to use fixed size types.
>> 
> Yes, this would be usable via vfio ioctl. But, then the caller should be
> aware of supported stash targets. May be I should add an interface for the caller,
> to query supported stash targets.

Guess the caller probably knows, but thinking we should move the #defines for valid values into this file out of pamu specific files.

- k
