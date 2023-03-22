Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E0F3C0C
	for <iommu@lists.linux.dev>; Wed, 22 Mar 2023 14:32:55 +0000 (UTC)
Received: from mail02.huawei.com (unknown [172.18.147.228])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4PhW0V4Rc2z9xFqs
	for <iommu@lists.linux.dev>; Wed, 22 Mar 2023 22:23:06 +0800 (CST)
Received: from [10.48.154.5] (unknown [10.48.154.5])
	by APP1 (Coremail) with SMTP id LxC2BwDnbwuBERtkBea9AQ--.53096S2;
	Wed, 22 Mar 2023 15:32:41 +0100 (CET)
Message-ID: <972d7b71-d126-0a00-2772-030c12f35e0e@huaweicloud.com>
Date: Wed, 22 Mar 2023 15:32:30 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/1] swiotlb: Track and report io_tlb_used high water mark
 in debugfs
Content-Language: en-US
To: Michael Kelley <mikelley@microsoft.com>, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com, decui@microsoft.com,
 tiala@microsoft.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <1677516106-85971-1-git-send-email-mikelley@microsoft.com>
From: Petr Tesarik <petrtesarik@huaweicloud.com>
In-Reply-To: <1677516106-85971-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:LxC2BwDnbwuBERtkBea9AQ--.53096S2
X-Coremail-Antispam: 1UD129KBjvdXoWruF47CF48CF4fCrykJry3CFg_yoWDAFg_ur
	Z2gwsrJw47Ar42qr4xtF4rCrsIg3y7Wry8X34fJ3yftw4DX398Gas7Kry09FyUGayfGrn5
	JwnxtryakFy7ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbzkYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267
	AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected

Hi,

On 2/27/2023 5:41 PM, Michael Kelley wrote:
> swiotlb currently reports the total number of slabs and the instantaneous
> in-use slabs in debugfs. But with increased usage of swiotlb for all I/O
> in Confidential Computing (coco) VMs, it has become difficult to know
> how much memory to allocate for swiotlb bounce buffers, either via the
> automatic algorithm in the kernel or by specifying a value on the
> kernel boot line. The current automatic algorithm generously allocates
> swiotlb bounce buffer memory, and may be wasting significant memory in
> many use cases.

I like the idea. Tracking and exposing the high watermark is definitely a step in the right direction. I would also appreciate an indicator of fragmentation, but that can be implemented later.

However, you apparently have a scenario where swiotlb is used intensely. Are you able to measure swiotlb performance? If yes, can you suggest a suitable method? I'm asking for my work on making swiotlb more flexible (able to grow and shrink).

Petr T

