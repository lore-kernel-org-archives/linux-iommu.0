Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF704C4332F
	for <iommu@archiver.kernel.org>; Tue, 31 May 2022 18:27:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 807F9408B5;
	Tue, 31 May 2022 18:27:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9SNKI-aMBva3; Tue, 31 May 2022 18:27:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 06D0640912;
	Tue, 31 May 2022 18:27:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28DC2C0081;
	Tue, 31 May 2022 18:27:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 79CE0C0081
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 18:27:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 56B3360B67
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 18:27:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=cybernetics.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yJv6ZvkXBIqU for <iommu@lists.linux-foundation.org>;
 Tue, 31 May 2022 18:26:59 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.cybernetics.com (mail.cybernetics.com [173.71.130.66])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5F23460ACF
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 18:26:59 +0000 (UTC)
X-ASG-Debug-ID: 1654020677-1cf43917f334afa0001-DtgJuY
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with
 ESMTP id wbqVFrYsF9UO9ekk; Tue, 31 May 2022 14:11:17 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=cybernetics.com; s=mail; 
 bh=QvvHI94cjVSZ3vyzLq0aE4IbkuwCS7vLvfKjrgG4UFU=;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:From:Content-Language:
 MIME-Version:Date:Message-ID; b=cdHo3GAMcWDRJ0VGiCWvXlyIXhHwRhAR44nZK//A1tvRT
 d2BjwWd9JShX2dFtLN6fSvPzVQCXgXil9PAdI8Wj2ZmL6SkzZRUPpYY3OSL3k3Ip8B7njnzSJgaZg
 nIQyJjOiw0pjXEOVFlb1XTpA4pOl5WOwRUtj+NTaT5uO9KtoI=
Received: from [10.157.2.224] (HELO [192.168.200.1])
 by cybernetics.com (CommuniGate Pro SMTP 7.1.1)
 with ESMTPS id 11829182; Tue, 31 May 2022 14:11:17 -0400
Message-ID: <9b08ab7c-b80b-527d-9adf-7716b0868fbc@cybernetics.com>
Date: Tue, 31 May 2022 14:11:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
From: Tony Battersby <tonyb@cybernetics.com>
Subject: [PATCH 00/10] mpt3sas and dmapool scalability
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
X-ASG-Orig-Subj: [PATCH 00/10] mpt3sas and dmapool scalability
X-Barracuda-Connect: UNKNOWN[10.10.4.126]
X-Barracuda-Start-Time: 1654020677
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 3968
X-Barracuda-BRTS-Status: 1
Cc: Tony Lindgren <tony@atomide.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Matthew Wilcox <willy@infradead.org>, iommu@lists.linux-foundation.org,
 Keith Busch <kbusch@kernel.org>, kernel-team@fb.com,
 Robin Murphy <robin.murphy@arm.com>
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

This patch series improves dmapool scalability by replacing linear scans
with red-black trees.

History:

In 2018 this patch series made it through 4 versions.  v1 used red-black
trees; v2 - v4 put the dma pool info directly into struct page and used
virt_to_page() to get at it.  v4 made a brief appearance in linux-next,
but it caused problems on non-x86 archs where virt_to_page() doesn't
work with dma_alloc_coherent, so it was reverted.  I was too busy at the
time to repost the red-black tree version, and I forgot about it until
now.  This version is based on the red-black trees of v1, but addressing
all the review comments I got at the time and with additional cleanup
patches.

Note that Keith Busch is also working on improving dmapool scalability,
so for now I would recommend not merging my scalability patches until
Keith's approach can be evaluated.  In the meantime, my patches can
serve as a benchmark comparison.  I also have a number of cleanup
patches in my series that could be useful on their own.

References:

v1
https://lore.kernel.org/linux-mm/73ec1f52-d758-05df-fb6a-41d269e910d0@cybernetics.com/

v2
https://lore.kernel.org/linux-mm/ec701153-fdc9-37f3-c267-f056159b4606@cybernetics.com/

v3
https://lore.kernel.org/linux-mm/d48854ff-995d-228e-8356-54c141c32117@cybernetics.com/

v4
https://lore.kernel.org/linux-mm/88395080-efc1-4e7b-f813-bb90c86d0745@cybernetics.com/

problem caused by virt_to_page()
https://lore.kernel.org/linux-kernel/20181206013054.GI6707@atomide.com/

Keith Busch's dmapool performance enhancements
https://lore.kernel.org/linux-mm/20220428202714.17630-1-kbusch@kernel.org/

Below is my original description of the motivation for these patches.

drivers/scsi/mpt3sas is running into a scalability problem with the
kernel's DMA pool implementation.  With a LSI/Broadcom SAS 9300-8i
12Gb/s HBA and max_sgl_entries=256, during modprobe, mpt3sas does the
equivalent of:

chain_dma_pool = dma_pool_create(size = 128);
for (i = 0; i < 373959; i++)
    {
    dma_addr[i] = dma_pool_alloc(chain_dma_pool);
    }

And at rmmod, system shutdown, or system reboot, mpt3sas does the
equivalent of:

for (i = 0; i < 373959; i++)
    {
    dma_pool_free(chain_dma_pool, dma_addr[i]);
    }
dma_pool_destroy(chain_dma_pool);

With this usage, both dma_pool_alloc() and dma_pool_free() exhibit
O(n^2) complexity, although dma_pool_free() is much worse due to
implementation details.  On my system, the dma_pool_free() loop above
takes about 9 seconds to run.  Note that the problem was even worse
before commit 74522a92bbf0 ("scsi: mpt3sas: Optimize I/O memory
consumption in driver."), where the dma_pool_free() loop could take ~30
seconds.

mpt3sas also has some other DMA pools, but chain_dma_pool is the only
one with so many allocations:

cat /sys/devices/pci0000:80/0000:80:07.0/0000:85:00.0/pools
(manually cleaned up column alignment)
poolinfo - 0.1
reply_post_free_array pool  1      21     192     1
reply_free pool             1      1      41728   1
reply pool                  1      1      1335296 1
sense pool                  1      1      970272  1
chain pool                  373959 386048 128     12064
reply_post_free pool        12     12     166528  12

The patches in this series improve the scalability of the DMA pool
implementation, which significantly reduces the running time of the
DMA alloc/free loops.  With the patches applied, "modprobe mpt3sas",
"rmmod mpt3sas", and system shutdown/reboot with mpt3sas loaded are
significantly faster.  Here are some benchmarks (of DMA alloc/free
only, not the entire modprobe/rmmod):

dma_pool_create() + dma_pool_alloc() loop, size = 128, count = 373959
  original:        350 ms ( 1x)
  dmapool patches:  18 ms (19x)

dma_pool_free() loop + dma_pool_destroy(), size = 128, count = 373959
  original:        8901 ms (   1x)
  dmapool patches:   19 ms ( 477x)


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
