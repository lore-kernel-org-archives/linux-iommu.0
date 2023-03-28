Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E81EBB
	for <iommu@lists.linux.dev>; Tue, 28 Mar 2023 07:21:42 +0000 (UTC)
Received: from mail02.huawei.com (unknown [172.18.147.228])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Pm18w36d2z9xqx4
	for <iommu@lists.linux.dev>; Tue, 28 Mar 2023 15:12:32 +0800 (CST)
Received: from [10.48.131.174] (unknown [10.48.131.174])
	by APP2 (Coremail) with SMTP id GxC2BwCXamFplSJkH5LUAQ--.63553S2;
	Tue, 28 Mar 2023 08:21:23 +0100 (CET)
Message-ID: <f42723f3-6dda-037d-3dd2-dc60ac0dcc3d@huaweicloud.com>
Date: Tue, 28 Mar 2023 09:21:10 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
From: Petr Tesarik <petrtesarik@huaweicloud.com>
Subject: Re: [RFC v1 1/4] dma-mapping: introduce the DMA_ATTR_MAY_SLEEP
 attribute
To: Christoph Hellwig <hch@lst.de>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Borislav Petkov <bp@suse.de>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Kim Phillips <kim.phillips@amd.com>,
 "Steven Rostedt (Google)" <rostedt@goodmis.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
 Roberto Sassu <roberto.sassu@huawei.com>, petr@tesarici.cz
References: <cover.1679309810.git.petr.tesarik.ext@huawei.com>
 <ea0646e0e63380bb8595fbac81c23aeca30feae9.1679309810.git.petr.tesarik.ext@huawei.com>
 <20230328035725.GA25506@lst.de>
Content-Language: en-US
In-Reply-To: <20230328035725.GA25506@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:GxC2BwCXamFplSJkH5LUAQ--.63553S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr4fJr1UWFWfCFWrZw4rAFb_yoW8GFyUpF
	s3tFy7trs8tF4FvasrZw4DZF9Y9a1xJrWru3Wjvwn3urn8uFsFkry2yFW2934DJrnrJ3yS
	vrZFk345Z34UC37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
	WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU13rcDUUUUU==
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected

On 3/28/2023 5:57 AM, Christoph Hellwig wrote:
> On Mon, Mar 20, 2023 at 01:28:13PM +0100, Petr Tesarik wrote:
>> From: Petr Tesarik <petr.tesarik.ext@huawei.com>
>>
>> Introduce a DMA attribute to tell the DMA-mapping subsystem that
>> the operation is allowed to sleep.
>>
>> This patch merely adds the flag, which is not used for anything at
>> the moment. It should be used by users who can sleep (e.g. dma-buf
>> ioctls) to allow page reclaim and/or allocations from CMA.
> 
> So what drivers would call this?  As-is it doesn't have any users in
> the series.

Yes, I removed one patch from the RFC series to reduce the Cc list while
I wasn't sure if the proposal would be considered at all.

The full series in my local tree added it to the implementation of
DRM_IOCTL_PRIME_FD_TO_HANDLE:

diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
index f924b8b4ab6b..f32e12445570 100644
--- a/drivers/gpu/drm/drm_prime.c
+++ b/drivers/gpu/drm/drm_prime.c
@@ -635,7 +635,7 @@ struct sg_table *drm_gem_map_dma_buf(struct
dma_buf_attachment *attach,
 		return sgt;

 	ret = dma_map_sgtable(attach->dev, sgt, dir,
-			      DMA_ATTR_SKIP_CPU_SYNC);
+			      DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MAY_SLEEP);
 	if (ret) {
 		sg_free_table(sgt);
 		kfree(sgt);

I also noticed a similar place in udmabuf, but since I don't have a use
case ATM, I haven't added the flag there (yet).

Petr T

