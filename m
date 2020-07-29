Return-Path: <SRS0=LOQj=BI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD68C433DF
	for <iommu@archiver.kernel.org>; Wed, 29 Jul 2020 08:32:07 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 711B520838
	for <iommu@archiver.kernel.org>; Wed, 29 Jul 2020 08:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 711B520838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=Huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 393A885A37;
	Wed, 29 Jul 2020 08:32:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id brutIb7IPeBV; Wed, 29 Jul 2020 08:32:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 69EAC85A0E;
	Wed, 29 Jul 2020 08:32:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5BA00C0050;
	Wed, 29 Jul 2020 08:32:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE092C004D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jul 2020 08:32:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A8E3C85A1E
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jul 2020 08:32:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9Plf8YwP7I9K for <iommu@lists.linux-foundation.org>;
 Wed, 29 Jul 2020 08:32:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 8EC6685A0E
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jul 2020 08:32:02 +0000 (UTC)
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
 by Forcepoint Email with ESMTP id 2439AD46260FB3D2AD69;
 Wed, 29 Jul 2020 09:31:58 +0100 (IST)
Received: from localhost (10.52.120.141) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 29 Jul
 2020 09:31:56 +0100
Date: Wed, 29 Jul 2020 09:30:31 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH 04/15] arm64: numa: simplify dummy_numa_init()
Message-ID: <20200729093031.0000316b@Huawei.com>
In-Reply-To: <20200728051153.1590-5-rppt@kernel.org>
References: <20200728051153.1590-1-rppt@kernel.org>
 <20200728051153.1590-5-rppt@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
X-Originating-IP: [10.52.120.141]
X-ClientProxiedBy: lhreml738-chm.china.huawei.com (10.201.108.188) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Cc: linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>, Paul
 Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
 linux-riscv@lists.infradead.org, Will Deacon <will@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-s390@vger.kernel.org,
 linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
 Russell King <linux@armlinux.org.uk>, Mike Rapoport <rppt@linux.ibm.com>,
 clang-built-linux@googlegroups.com, Ingo Molnar <mingo@redhat.com>,
 Christoph Hellwig <hch@lst.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 uclinux-h8-devel@lists.sourceforge.jp, linux-xtensa@linux-xtensa.org,
 openrisc@lists.librecores.org, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Stafford Horne <shorne@gmail.com>, linux-arm-kernel@lists.infradead.org,
 Michal Simek <monstr@monstr.eu>, linux-mm@kvack.org,
 linux-mips@vger.kernel.org, iommu@lists.linux-foundation.org, Palmer
 Dabbelt <palmer@dabbelt.com>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Tue, 28 Jul 2020 08:11:42 +0300
Mike Rapoport <rppt@kernel.org> wrote:

> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> dummy_numa_init() loops over memblock.memory and passes nid=0 to
> numa_add_memblk() which essentially wraps memblock_set_node(). However,
> memblock_set_node() can cope with entire memory span itself, so the loop
> over memblock.memory regions is redundant.
> 
> Replace the loop with a single call to memblock_set_node() to the entire
> memory.

Hi Mike,

I had a similar patch I was going to post shortly so can add a bit more
on the advantages of this one.

Beyond cleaning up, it also fixes an issue with a buggy ACPI firmware in which the SRAT
table covers some but not all of the memory in the EFI memory map.  Stealing bits
from the draft cover letter I had for that...

> This issue can be easily triggered by having an SRAT table which fails
> to cover all elements of the EFI memory map.
> 
> This firmware error is detected and a warning printed. e.g.
> "NUMA: Warning: invalid memblk node 64 [mem 0x240000000-0x27fffffff]"
> At that point we fall back to dummy_numa_init().
> 
> However, the failed ACPI init has left us with our memblocks all broken
> up as we split them when trying to assign them to NUMA nodes.
> 
> We then iterate over the memblocks and add them to node 0.
> 
> for_each_memblock(memory, mblk) {
> 	ret = numa_add_memblk(0, mblk->base, mblk->base + mblk->size);
> 	if (!ret)
> 		continue;
> 	pr_err("NUMA init failed\n");
> 	return ret;
> }
> 
> numa_add_memblk() calls memblock_set_node() which merges regions that
> were previously split up during the earlier attempt to add them to different
> nodes during parsing of SRAT.
> 
> This means elements are moved in the memblock array and we can end up
> in a different memblock after the call to numa_add_memblk().
> Result is:
> 
> Unable to handle kernel paging request at virtual address 0000000000003a40
> Mem abort info:
>   ESR = 0x96000004
>   EC = 0x25: DABT (current EL), IL = 32 bits
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
> Data abort info:
>   ISV = 0, ISS = 0x00000004
>   CM = 0, WnR = 0
> [0000000000003a40] user address but active_mm is swapper
> Internal error: Oops: 96000004 [#1] PREEMPT SMP
> 
> ...
> 
> Call trace:
>   sparse_init_nid+0x5c/0x2b0
>   sparse_init+0x138/0x170
>   bootmem_init+0x80/0xe0
>   setup_arch+0x2a0/0x5fc
>   start_kernel+0x8c/0x648
> 
> As an illustrative example:
> EFI table has one block of memory.
> memblks[0] = [0...0x2f]  so we start with a single memblock.
> 
> SRAT has
> [0x00...0x0f] in node 0
> [0x10...0x1f] in node 1
> but no entry covering 
> [0x20...0x2f].
> 
> Whilst parsing SRAT the single memblock is broken into 3.
> memblks[0] = [0x00...0x0f] in node 0
> memblks[1] = [0x10...0x1f] in node 1
> memblks[2] = [0x20...0x2f] in node MAX_NUM_NODES (invalid value)
> 
> A sanity check parse then detects the invalid section and acpi_numa_init
> fails.  We then fall back to the dummy path.
> 
> That iterates over the memblocks.  We'll use i an index in the array of memblocks
> 
> i = 0;
> memblks[0] = [0x00...0x0f] set to node0.
>    merge doesn't do anything because the neighbouring memblock is still in node1.
> 
> i = 1
> memblks[1] = [0x10...0x1f] set to node 0.
>    merge combines memblock 0 and 1 to give a new set of memblocks.
> 
> memblks[0] = [0x00..0x1f] in node 0
> memblks[1] = [0x20..0x2f] in node MAX_NUM_NODES.
> 
> i = 2 off the end of the now reduced array of memblocks, so exit the loop.
> (if we restart the loop here everything will be fine).
> 
> Later sparse_init_nid tries to use the node of the second memblock to index
> somethings and boom.


> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  arch/arm64/mm/numa.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
> index aafcee3e3f7e..0cbdbcc885fb 100644
> --- a/arch/arm64/mm/numa.c
> +++ b/arch/arm64/mm/numa.c
> @@ -423,19 +423,16 @@ static int __init numa_init(int (*init_func)(void))
>   */
>  static int __init dummy_numa_init(void)
>  {
> +	phys_addr_t start = memblock_start_of_DRAM();
> +	phys_addr_t end = memblock_end_of_DRAM();
>  	int ret;
> -	struct memblock_region *mblk;
>  
>  	if (numa_off)
>  		pr_info("NUMA disabled\n"); /* Forced off on command line. */
> -	pr_info("Faking a node at [mem %#018Lx-%#018Lx]\n",
> -		memblock_start_of_DRAM(), memblock_end_of_DRAM() - 1);
> -
> -	for_each_memblock(memory, mblk) {
> -		ret = numa_add_memblk(0, mblk->base, mblk->base + mblk->size);
> -		if (!ret)
> -			continue;
> +	pr_info("Faking a node at [mem %#018Lx-%#018Lx]\n", start, end - 1);
>  
> +	ret = numa_add_memblk(0, start, end);
> +	if (ret) {
>  		pr_err("NUMA init failed\n");
>  		return ret;
>  	}


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
