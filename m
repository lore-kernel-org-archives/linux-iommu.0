Return-Path: <SRS0=zJzC=3V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77AF2C33CB7
	for <iommu@archiver.kernel.org>; Sat,  1 Feb 2020 00:06:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4712C20CC7
	for <iommu@archiver.kernel.org>; Sat,  1 Feb 2020 00:06:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4712C20CC7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id DC843878B0;
	Sat,  1 Feb 2020 00:06:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 52XaNZwXoiHt; Sat,  1 Feb 2020 00:06:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id EE0E1875DB;
	Sat,  1 Feb 2020 00:06:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E246EC0178;
	Sat,  1 Feb 2020 00:06:15 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7285CC0171
 for <iommu@lists.linux-foundation.org>; Sat,  1 Feb 2020 00:06:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 59D7086B45
 for <iommu@lists.linux-foundation.org>; Sat,  1 Feb 2020 00:06:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4ir4UpK146bH for <iommu@lists.linux-foundation.org>;
 Sat,  1 Feb 2020 00:06:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 861AD86AD0
 for <iommu@lists.linux-foundation.org>; Sat,  1 Feb 2020 00:06:12 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0736D113E;
 Fri, 31 Jan 2020 16:06:12 -0800 (PST)
Received: from [192.168.1.123] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC1503F68E;
 Fri, 31 Jan 2020 16:06:10 -0800 (PST)
Subject: Re: [PATCH] dma-debug: dynamic allocation of hash table
To: Eric Dumazet <edumazet@google.com>
References: <20200130191049.190569-1-edumazet@google.com>
 <e0a0ffa9-3721-4bac-1c8f-bcbd53d22ba1@arm.com>
 <CANn89i+fRqeSAz9eH8f2ujzBWSLUXw0eTT=tK=eNj8hL71MiFQ@mail.gmail.com>
 <f870ae85-995f-7866-ebbd-95b89ca28dc5@arm.com>
 <CANn89iKfA+yPHiL4R7-jkewwhDgM6jkwhW5o9H=VL9CnyBikhw@mail.gmail.com>
 <62e1ee46-ad9e-988f-a2a3-8fd217e28f24@arm.com>
 <CANn89iKmFMiOStfcRdKXe=mks65dhkXPTawqevY8YwyUbfSjhg@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <6ad5e108-1368-bd1e-0be7-eff02eed1e5c@arm.com>
Date: Sat, 1 Feb 2020 00:06:12 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CANn89iKmFMiOStfcRdKXe=mks65dhkXPTawqevY8YwyUbfSjhg@mail.gmail.com>
Content-Language: en-GB
Cc: Joerg Roedel <jroedel@suse.de>, Eric Dumazet <eric.dumazet@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Geert Uytterhoeven <geert@linux-m68k.org>, Christoph Hellwig <hch@lst.de>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2020-01-31 5:46 pm, Eric Dumazet wrote:
> On Fri, Jan 31, 2020 at 9:43 AM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 31/01/2020 2:42 pm, Eric Dumazet wrote:
>>> On Fri, Jan 31, 2020 at 4:30 AM Robin Murphy <robin.murphy@arm.com> wrote:
>>>>
>>>> ...and when that represents ~5% of the total system RAM it is a *lot*
>>>> less reasonable than even 12KB. As I said, it's great to make a debug
>>>> option more efficient such that what it observes is more representative
>>>> of the non-debug behaviour, but it mustn't come at the cost of making
>>>> the entire option unworkable for other users.
>>>>
>>>
>>> Then I suggest you send a patch to reduce PREALLOC_DMA_DEBUG_ENTRIES
>>> because having 65536 preallocated entries consume 4 MB of memory.
>>
>> ...unless it's overridden on the command-line ;)
>>
>>> Actually this whole attempt to re-implement slab allocations in this
>>> file is suspect.
>>
>> Again that's a matter of expected usage patterns - typically the
>> "reasonable default" or user-defined preallocation should still be
>> enough (as it *had* to be before), and the kind of systems that can
>> sustain so many live mappings as to regularly hit the dynamic expansion
>> path are also likely to have enough memory not to care that later-unused
>> entries never get 'properly' freed back to the kernel (plus as you've
>> observed, many workloads tend to reach a steady state where entries are
>> mostly only transiently free anyway). The reasoning for the exact
>> implementation details is there in the commit logs.
>>
>>> Do not get me wrong, but if you really want to run linux on a 16MB host,
>>> I guess you need to add CONFIG_BASE_SMALL all over the places,
>>> not only in this kernel/dma/debug.c file.
>>
>> Right, nobody's suggesting that defconfig should "just work" on your
>> router/watch/IoT shoelaces/whatever, I'm just saying that tuning any
>> piece of common code for datacenter behemoths, for quality-of-life
>> rather than functional necessity, and leaving no way to adjust it other
>> than hacking the source, would represent an unnecessary degree of
>> short-sightedness that we can and should avoid.
>>
>> Taking a closer look at the code, it appears fairly straightforward to
>> make the hash size variable, and in fact making it self-adjusting
>> doesn't seem too big a jump from there. I'm happy to have a go at that
>> myself if you like.
> 
> 
> Sure, go ahead, I have no plan implementing changes for 20 years old platforms.

Heh, I'm fairly confident the 20-year-old drivers are probably 
well-debugged by now anyway - it's the future low-end SoCs for 
Linux-powered IoT shoelaces that I see being a rich vein of new bugs :)

How does this look to start with? (only compile-tested so far, but I'll 
pick it up again properly next week)

Robin.

----->8-----
From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH] dma/debug: Size hash table dynamically

Having a fixed-size hash table fails to scale nicely - making it large
enough to perform well for the mapping behaviour of big network adapters
tends towards unreasonable memory consumption for smaller systems. It's
logical to size the table for the number of expected entries, and doing
so conveniently puts the size/performance tradeoff in the hands of the
user via the "dma_debug_entries" option. The dynamic allocation also
sidesteps the issue of the static array bloating the kernel image on
certain platforms.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
  kernel/dma/debug.c | 31 ++++++++++++++++++++-----------
  1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 2031ed1ad7fa..86a4c68d6ac1 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -27,9 +27,9 @@

  #include <asm/sections.h>

-#define HASH_SIZE       16384ULL
+static int hash_size __read_mostly;
  #define HASH_FN_SHIFT   13
-#define HASH_FN_MASK    (HASH_SIZE - 1)
+#define HASH_FN_MASK    (hash_size - 1)

  #define PREALLOC_DMA_DEBUG_ENTRIES (1 << 16)
  /* If the pool runs out, add this many new entries at once */
@@ -90,7 +90,7 @@ struct hash_bucket {
  };

  /* Hash list to save the allocated dma addresses */
-static struct hash_bucket dma_entry_hash[HASH_SIZE];
+static struct hash_bucket *dma_entry_hash;
  /* List of pre-allocated dma_debug_entry's */
  static LIST_HEAD(free_entries);
  /* Lock for the list above */
@@ -398,7 +398,7 @@ void debug_dma_dump_mappings(struct device *dev)
  {
  	int idx;

-	for (idx = 0; idx < HASH_SIZE; idx++) {
+	for (idx = 0; idx < hash_size; idx++) {
  		struct hash_bucket *bucket = &dma_entry_hash[idx];
  		struct dma_debug_entry *entry;
  		unsigned long flags;
@@ -818,7 +818,7 @@ static int dump_show(struct seq_file *seq, void *v)
  {
  	int idx;

-	for (idx = 0; idx < HASH_SIZE; idx++) {
+	for (idx = 0; idx < hash_size; idx++) {
  		struct hash_bucket *bucket = &dma_entry_hash[idx];
  		struct dma_debug_entry *entry;
  		unsigned long flags;
@@ -862,7 +862,7 @@ static int device_dma_allocations(struct device 
*dev, struct dma_debug_entry **o
  	unsigned long flags;
  	int count = 0, i;

-	for (i = 0; i < HASH_SIZE; ++i) {
+	for (i = 0; i < hash_size; ++i) {
  		spin_lock_irqsave(&dma_entry_hash[i].lock, flags);
  		list_for_each_entry(entry, &dma_entry_hash[i].list, list) {
  			if (entry->dev == dev) {
@@ -934,7 +934,13 @@ static int dma_debug_init(void)
  	if (global_disable)
  		return 0;

-	for (i = 0; i < HASH_SIZE; ++i) {
+	hash_size = roundup_pow_of_two(nr_prealloc_entries) / 16;
+	dma_entry_hash = kvmalloc_array(max(hash_size, 16),
+					sizeof(*dma_entry_hash), GFP_KERNEL);
+	if (!dma_entry_hash)
+		goto out_err;
+
+	for (i = 0; i < hash_size; ++i) {
  		INIT_LIST_HEAD(&dma_entry_hash[i].list);
  		spin_lock_init(&dma_entry_hash[i].lock);
  	}
@@ -950,10 +956,7 @@ static int dma_debug_init(void)
  		pr_warn("%d debug entries requested but only %d allocated\n",
  			nr_prealloc_entries, nr_total_entries);
  	} else {
-		pr_err("debugging out of memory error - disabled\n");
-		global_disable = true;
-
-		return 0;
+		goto out_err;
  	}
  	min_free_entries = num_free_entries;

@@ -961,6 +964,12 @@ static int dma_debug_init(void)

  	pr_info("debugging enabled by kernel config\n");
  	return 0;
+
+out_err:
+	pr_err("debugging out of memory error - disabled\n");
+	global_disable = true;
+
+	return 0;
  }
  core_initcall(dma_debug_init);

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
