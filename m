From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: 4.19-rc3: IOMMU PT warnings: WARNING: CPU: 0 PID: 1 at
	mm/page_alloc.c:4065 __alloc_pages_slowpath+0xb7b/0xcd0
Date: Mon, 10 Sep 2018 14:26:30 +0100
Message-ID: <e3f0e78a-3e3d-aae7-2588-599184dee534@arm.com>
References: <alpine.LRH.2.21.1809101111040.31938@math.ut.ee>
	<20180910132304.GA20244@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180910132304.GA20244-jcswGhMUV9g@public.gmane.org>
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
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Meelis Roos <mroos-Y27EyoLml9s@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Linux Kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 10/09/18 14:23, Christoph Hellwig wrote:
> On Mon, Sep 10, 2018 at 11:16:12AM +0300, Meelis Roos wrote:
>> In 4.19-rc1, I found that to keep Intel integrated graphics working when
>> VT-d is on, I need to have IOMMU passthough on or GPU init would fail
>> with DMAR error and the screen would display static gibberish. So I
>> turned IOMMU PT on by default in kernel config. It worked, also in rc2.
>>
>> Now with rc3, it still works but I get some warning splats in dmesg
>> about IOMMU passthrough:
> 
> Any chance you could bisect this down to a specific commit?  For
> a start it might be worth if it is reproducable with:
> 
>     git://git.infradead.org/users/hch/dma-mapping.git dma-mapping-4.19-2
> 
> which were the only dma-mapping changes post -rc2.

Given the __alloc_pages_slowpath() warning, this looks like it's 
probably stemming from the oversized PASID table issue which a few other 
folks have hit too. I think this patch is the most up-to-date fix:

https://www.mail-archive.com/iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org/msg25639.html

Robin.
