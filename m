Return-Path: <SRS0=BhyV=QD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39366C433FE
	for <iommu@archiver.kernel.org>; Tue, 16 Nov 2021 00:16:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E21666323A
	for <iommu@archiver.kernel.org>; Tue, 16 Nov 2021 00:16:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E21666323A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9C46780DAE;
	Tue, 16 Nov 2021 00:16:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 03GVvQkmLU3Q; Tue, 16 Nov 2021 00:16:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 57A5580DA2;
	Tue, 16 Nov 2021 00:16:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35F71C001E;
	Tue, 16 Nov 2021 00:16:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 99B7EC0012
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 00:16:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 858974017E
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 00:16:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.cz header.b="ulrfLKfX";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=suse.cz header.b="9rQHGclh"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pFc7axsSNqHu for <iommu@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 00:16:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AD4BC40012
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 00:16:40 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0EE092170C;
 Tue, 16 Nov 2021 00:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1637021797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=qMPAWzuBja3HPc266bh9/SxdkyevbbiS70h3IGw63Mk=;
 b=ulrfLKfXF+VgRiEYhh95mz9M2HpbzpPsexbUkpA2iQLF9OwCKp+TVDTyiRG/P9clk1B4eL
 ZUB55wCgtyL0LcerE6krPwc5kQKANldixVRxQ4CxH+F25UR2LzDyry/ifCmFvwPIjSzKej
 bruXu9rmlQV+3w3uJe81ZuZHu8QALzk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1637021797;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=qMPAWzuBja3HPc266bh9/SxdkyevbbiS70h3IGw63Mk=;
 b=9rQHGclhSv3eSlKGqnTWZFd4Iqds4WT5uXr/jYcmxbxdUhLIKlhKMDN1gSREHkpjk7wGlh
 WwztQ35pOVtjWvAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 880A3139DB;
 Tue, 16 Nov 2021 00:16:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id OON5IGT4kmFjXAAAMHmgww
 (envelope-from <vbabka@suse.cz>); Tue, 16 Nov 2021 00:16:36 +0000
From: Vlastimil Babka <vbabka@suse.cz>
To: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
 Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Pekka Enberg <penberg@kernel.org>
Subject: [RFC PATCH 00/32] Separate struct slab from struct page
Date: Tue, 16 Nov 2021 01:15:56 +0100
Message-Id: <20211116001628.24216-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6354; h=from:subject;
 bh=Yv4yTdINqcoqD7G0pRh1MdRj/fEwyrMlw3UnFAcYj7Y=;
 b=owEBbQGS/pANAwAIAeAhynPxiakQAcsmYgBhkvgftiZeNrWVhI+DKUHzPdvji/FLFq5wjFQzaaPr
 g56dz96JATMEAAEIAB0WIQSNS5MBqTXjGL5IXszgIcpz8YmpEAUCYZL4HwAKCRDgIcpz8YmpEDd2CA
 C5VF2fCCrFh+cwzoazBKYOudAHl4b/Ln5DcnL9t00V5H6CRcgWEe+uq7ju+KYaShk/4aDVU6/k4iI/
 i8XUUIcXQBM1hQfAzvivKsbo37IEwmw/yYTJu7P8HI5stLfZ9pYSuNZiMa3tjh7xDXE2lXoboaSisR
 pJ5PEvAxmgTPOKQ0Kn3axIp5C8xS+5lQIoDk10I7DiVwjiPjWgyOnYKXGwxQ10xu6Rs0VTv79x9Fo1
 beM5ueTcBD4P12IyMYNLnjPDHveynUlOqdrB/oS6gcSstu847TOW64xYyb9KBgkhnJG6epdIvJTRMr
 tcE5Bo6jnyrVzSwZc6pgdQjX45G7Ju
X-Developer-Key: i=vbabka@suse.cz; a=openpgp;
 fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
Cc: Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Michal Hocko <mhocko@kernel.org>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Will Deacon <will@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 x86@kernel.org, iommu@lists.linux-foundation.org, kasan-dev@googlegroups.com,
 Ingo Molnar <mingo@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
 Nitin Gupta <ngupta@vflare.org>, Vladimir Davydov <vdavydov.dev@gmail.com>,
 Marco Elver <elver@google.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, cgroups@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Julia Lawall <julia.lawall@inria.fr>,
 Minchan Kim <minchan@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, David Woodhouse <dwmw2@infradead.org>
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

Folks from non-slab subsystems are Cc'd only to patches affecting them, and
this cover letter.

Series also available in git, based on 5.16-rc1:
https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slab-struct_slab-v1r13

Side note: as my SLUB PREEMPT_RT series in 5.15, I would prefer to repeat the
git pull request way of eventually merging this, as it's also not a small
series. Also I wouldn't mind to then continue with a git tree for all slab
patches in general. It was apparently even done that way before:
https://lore.kernel.org/linux-mm/alpine.DEB.2.00.1107221108190.2996@tiger/
What do other slab maintainers think?

Previous version from Matthew Wilcox:
https://lore.kernel.org/all/20211004134650.4031813-1-willy@infradead.org/

LWN coverage of the above:
https://lwn.net/Articles/871982/

This is originally an offshoot of the folio work by Matthew. One of the more
complex parts of the struct page definition is the parts used by the slab
allocators. It would be good for the MM in general if struct slab were its own
data type, and it also helps to prevent tail pages from slipping in anywhere.
As Matthew requested in his proof of concept series, I have taken over the
development of this series, so it's a mix of patches from him (often modified
by me) and my own.

One big difference is the use of coccinelle to perform the less interesting
parts of the conversions automatically and at once, instead of a larger number
of smaller incremental reviewable steps. Thanks to Julia Lawall and Luis
Chamberlain for all their help!

Another notable difference is (based also on review feedback) I don't represent
with a struct slab the large kmalloc allocations which are not really a slab,
but use page allocator directly. When going from an object address to a struct
slab, the code tests first folio slab flag, and only if it's set it converts to
struct slab. This makes the struct slab type stronger.

Finally, although Matthew's version didn't use any of the folio work, the
initial support has been merged meanwhile so my version builds on top of it
where appropriate. This eliminates some of the redundant compound_head() e.g.
when testing the slab flag.

To sum up, after this series, struct page fields used by slab allocators are
moved from struct page to a new struct slab, that uses the same physical
storage. The availability of the fields is further distinguished by the
selected slab allocator implementation. The advantages include:

- Similar to plain folio, if the slab is of order > 0, struct slab always is
guaranteed to be the head page. Additionally it's guaranteed to be an actual
slab page, not a large kmalloc. This removes uncertainty and potential for
bugs.
- It's not possible to accidentally use fields of slab implementation that's
not actually selected.
- Other subsystems cannot use slab's fields in struct page anymore (some
existing non-slab usages had to be adjusted in this series), so slab
implementations have more freedom in rearranging them in the struct slab.

Matthew Wilcox (Oracle) (16):
  mm: Split slab into its own type
  mm: Add account_slab() and unaccount_slab()
  mm: Convert virt_to_cache() to use struct slab
  mm: Convert __ksize() to struct slab
  mm: Use struct slab in kmem_obj_info()
  mm: Convert check_heap_object() to use struct slab
  mm/slub: Convert detached_freelist to use a struct slab
  mm/slub: Convert kfree() to use a struct slab
  mm/slub: Convert print_page_info() to print_slab_info()
  mm/slub: Convert pfmemalloc_match() to take a struct slab
  mm/slob: Convert SLOB to use struct slab
  mm/kasan: Convert to struct slab
  zsmalloc: Stop using slab fields in struct page
  bootmem: Use page->index instead of page->freelist
  iommu: Use put_pages_list
  mm: Remove slab from struct page

Vlastimil Babka (16):
  mm/slab: Dissolve slab_map_pages() in its caller
  mm/slub: Make object_err() static
  mm/slub: Convert __slab_lock() and __slab_unlock() to struct slab
  mm/slub: Convert alloc_slab_page() to return a struct slab
  mm/slub: Convert __free_slab() to use struct slab
  mm/slub: Convert most struct page to struct slab by spatch
  mm/slub: Finish struct page to struct slab conversion
  mm/slab: Convert kmem_getpages() and kmem_freepages() to struct slab
  mm/slab: Convert most struct page to struct slab by spatch
  mm/slab: Finish struct page to struct slab conversion
  mm: Convert struct page to struct slab in functions used by other
    subsystems
  mm/memcg: Convert slab objcgs from struct page to struct slab
  mm/kfence: Convert kfence_guarded_alloc() to struct slab
  mm/sl*b: Differentiate struct slab fields by sl*b implementations
  mm/slub: Simplify struct slab slabs field definition
  mm/slub: Define struct slab fields for CONFIG_SLUB_CPU_PARTIAL only
    when enabled

 arch/x86/mm/init_64.c          |    2 +-
 drivers/iommu/amd/io_pgtable.c |   59 +-
 drivers/iommu/dma-iommu.c      |   11 +-
 drivers/iommu/intel/iommu.c    |   89 +--
 include/linux/bootmem_info.h   |    2 +-
 include/linux/iommu.h          |    3 +-
 include/linux/kasan.h          |    9 +-
 include/linux/memcontrol.h     |   48 --
 include/linux/mm_types.h       |   38 +-
 include/linux/page-flags.h     |   37 -
 include/linux/slab.h           |    8 -
 include/linux/slab_def.h       |   16 +-
 include/linux/slub_def.h       |   29 +-
 mm/bootmem_info.c              |    7 +-
 mm/kasan/common.c              |   25 +-
 mm/kasan/generic.c             |    8 +-
 mm/kasan/kasan.h               |    1 +
 mm/kasan/quarantine.c          |    2 +-
 mm/kasan/report.c              |   12 +-
 mm/kasan/report_tags.c         |   10 +-
 mm/kfence/core.c               |   17 +-
 mm/kfence/kfence_test.c        |    6 +-
 mm/memcontrol.c                |   43 +-
 mm/slab.c                      |  455 ++++++-------
 mm/slab.h                      |  322 ++++++++-
 mm/slab_common.c               |    8 +-
 mm/slob.c                      |   46 +-
 mm/slub.c                      | 1164 ++++++++++++++++----------------
 mm/sparse.c                    |    2 +-
 mm/usercopy.c                  |   13 +-
 mm/zsmalloc.c                  |   18 +-
 31 files changed, 1302 insertions(+), 1208 deletions(-)

-- 
2.33.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
