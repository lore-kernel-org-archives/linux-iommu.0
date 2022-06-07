Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62957C43334
	for <iommu@archiver.kernel.org>; Tue,  7 Jun 2022 18:38:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 010D7405EC;
	Tue,  7 Jun 2022 18:38:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nh2I6d6Enb0W; Tue,  7 Jun 2022 18:38:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A084C4055A;
	Tue,  7 Jun 2022 18:38:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69605C0032;
	Tue,  7 Jun 2022 18:38:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2C59C002D
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jun 2022 18:38:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8F1BF4157D
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jun 2022 18:38:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=cybernetics.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nW7e3rLHdlL9 for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 18:38:38 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.cybernetics.com (mail.cybernetics.com [173.71.130.66])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D35254155C
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jun 2022 18:38:37 +0000 (UTC)
X-ASG-Debug-ID: 1654627115-1cf43917f3396470001-DtgJuY
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with
 ESMTP id utCa0jEuR0ydfBDR; Tue, 07 Jun 2022 14:38:35 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=cybernetics.com; s=mail; 
 bh=3YvRZ5FOVwCVa3SqPpM62f1HUDXg7koMQw6UwikSy60=;
 h=Content-Transfer-Encoding:Content-Type:Subject:From:Cc:To:Content-Language:
 MIME-Version:Date:Message-ID; b=HWP6kvkGh9cacYSZPz+DzDEx8wo/oHQo8T6bny2R8X0wg
 NDKyaYMuP833zSg3fJzE0aawJ8vBp3xI1k1sCKlxf393i4KfBWzVGQWBeei0Ls0m5zBJEh0fusLPR
 L4zDDqhVYBe1NHAC0s6k/rSu2pmptHitdw4iy92t5hCYv0Vto=
Received: from [10.157.2.224] (HELO [192.168.200.1])
 by cybernetics.com (CommuniGate Pro SMTP 7.1.1)
 with ESMTPS id 11859378; Tue, 07 Jun 2022 14:38:34 -0400
Message-ID: <340ff8ef-9ff5-7175-c234-4132bbdfc5f7@cybernetics.com>
Date: Tue, 7 Jun 2022 14:38:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
From: Tony Battersby <tonyb@cybernetics.com>
Subject: [PATCH v6 00/11] mpt3sas and dmapool scalability
X-ASG-Orig-Subj: [PATCH v6 00/11] mpt3sas and dmapool scalability
X-Barracuda-Connect: UNKNOWN[10.10.4.126]
X-Barracuda-Start-Time: 1654627115
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 3193
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

Note that Keith Busch is also working on improving dmapool scalability,
so for now I would recommend not merging my scalability patches until
Keith's approach can be evaluated.  In the meantime, my patches can
serve as a benchmark comparison.  I also have a number of cleanup
patches in my series that could be useful on their own.

Changes since v5:
1. inline pool_free_page() into dma_pool_destroy() to avoid adding
   unused code
2. convert scnprintf() to sysfs_emit()
3. avoid adding a hole in struct dma_pool
4. fix big O usage in description

References:

v5
https://lore.kernel.org/linux-mm/9b08ab7c-b80b-527d-9adf-7716b0868fbc@cybernetics.com/

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
O(n) complexity, although dma_pool_free() is much worse due to
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
