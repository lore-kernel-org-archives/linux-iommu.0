From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 2/5] dma-mapping: Introduce dma_iommu_detach_device()
	API
Date: Mon, 30 Apr 2018 13:49:48 +0100
Message-ID: <7372c5f4-d19c-bfbf-a39c-acfcd25e03a1@arm.com>
References: <20180425101051.15349-1-thierry.reding@gmail.com>
	<20180425101051.15349-2-thierry.reding@gmail.com>
	<20180425151934.GC16075@infradead.org> <20180426121136.GD11985@ulmo>
	<20180430110231.GF2476@ulmo>
	<e549979d-9f53-a329-da1a-ed5139958762@arm.com>
	<20180430121226.GA6487@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180430121226.GA6487@ulmo>
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
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 30/04/18 13:12, Thierry Reding wrote:
> On Mon, Apr 30, 2018 at 12:41:52PM +0100, Robin Murphy wrote:
>> On 30/04/18 12:02, Thierry Reding wrote:
>>> On Thu, Apr 26, 2018 at 02:11:36PM +0200, Thierry Reding wrote:
>>>> On Wed, Apr 25, 2018 at 08:19:34AM -0700, Christoph Hellwig wrote:
>>>>> On Wed, Apr 25, 2018 at 12:10:48PM +0200, Thierry Reding wrote:
>>>>>> From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>>>>>>
>>>>>> The dma_iommu_detach_device() API can be used by drivers to forcibly
>>>>>> detach a device from an IOMMU that architecture code might have attached
>>>>>> to. This is useful for drivers that need explicit control over the IOMMU
>>>>>> using the IOMMU API directly.
>>>>>
>>>>> Given that no one else implements it making it a generic API seems
>>>>> rather confusing.  For now I'd rename it to
>>>>> arm_dma_iommu_detach_device() and only implement it in arm.
>>>>
>>>> That'd be suboptimal because this code is used on both 32-bit and 64-bit
>>>> ARM. If we make the function 32-bit ARM specific then the driver code
>>>> would need to use an #ifdef to make sure compilation doesn't break on
>>>> 64-bit ARM.
>>>
>>> Do you still want me to make this ARM specific? While I haven't
>>> encountered this issue on 64-bit ARM yet, I think it would happen there
>>> as well, under the right circumstances. I could take a shot at
>>> implementing the equivalent there (which means essentially implementing
>>> it for drivers/iommu/dma-iommu.c and calling that from 64-bit ARM code).
>>
>> It sounds like things are getting a bit backwards here: iommu-dma should
>> have nothing to do with this, since if you've explicitly attached the device
>> to your own IOMMU domain then you're already bypassing everything it knows
>> about and has control over. Arch code calling into iommu-dma to do something
>> which makes arch code not use iommu-dma makes very little sense.
> 
> My understanding is that iommu-dma will set up an IOMMU domain at device
> probe time anyway. So even if attaching to an own IOMMU domain will end
> up bypassing iommu-dma, we'd still want to clear up the IOMMU domain and
> any associated resources, right?

The lifetime of a "proper" IOMMU API default domain is that of the 
iommu_group, so more or less between device_add() and device_del() from 
the perspective of a device in that group. IOW at least one level below 
what that device's driver should be messing with. The domain itself is 
just a little bit of memory and shouldn't have to occupy any hardware 
resources while it's not active (and yes, I know the ARM SMMU driver is 
currently a bit crap in that regard).

Robin.
