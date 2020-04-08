Return-Path: <SRS0=CWSE=5Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E6EC2BB54
	for <iommu@archiver.kernel.org>; Wed,  8 Apr 2020 12:00:01 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3422420747
	for <iommu@archiver.kernel.org>; Wed,  8 Apr 2020 12:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kl7N1DF4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3422420747
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 73C8787916;
	Wed,  8 Apr 2020 12:00:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aXC+9foYlWcW; Wed,  8 Apr 2020 11:59:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A78EA87AFE;
	Wed,  8 Apr 2020 11:59:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91ABBC1AE8;
	Wed,  8 Apr 2020 11:59:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 228D1C0177
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 11:59:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 1F2D785D7E
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 11:59:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qD2rI2_FeoQp for <iommu@lists.linux-foundation.org>;
 Wed,  8 Apr 2020 11:59:57 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id EAF3D85E69
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 11:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=9qK7Dtj+WtgCtPTEhqLHbohMjBZ/bLj4WGsShpTkfgE=; b=kl7N1DF43PAhfE12A2j1vryrvc
 zdzDnoFf7SGt36b10eu+SvwYvzbtO5b2A2z+0AJe0Cg3vSHM+ITvfNQkxgr5fjq9GVOQ35V78ADBe
 Ku4g+ewJmeQS3WruWPb9JUerp36gWxkaLMhWeXcFUsDC5g1tVHCeIGloIxOylUCjlzPz+PtntbNuI
 wJ/WFv08ob5LQgpVwdauDDZi2MCwUdWBH+7YXT+iab6WbbbzQewHz6qlisMCwlRHJl1Fjx4lKjAb8
 wSZjxJYJYNDQ+7SbQwq6YvpwCXlVooaIqaFqYGoSNWUDmKqLybYg6nXxqOTJPkakPn3qnmoQYffc1
 PDsEE2aA==;
Received: from [2001:4bb8:180:5765:65b6:f11e:f109:b151] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jM9Mi-0001ZS-2Q; Wed, 08 Apr 2020 11:59:32 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 x86@kernel.org, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Laura Abbott <labbott@redhat.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>
Subject: [PATCH 01/28] x86/hyperv: use vmalloc_exec for the hypercall page
Date: Wed,  8 Apr 2020 13:58:59 +0200
Message-Id: <20200408115926.1467567-2-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200408115926.1467567-1-hch@lst.de>
References: <20200408115926.1467567-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Christophe Leroy <christophe.leroy@c-s.fr>, linux-arch@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-s390@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, bpf@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

Use the designated helper for allocating executable kernel memory, and
remove the now unused PAGE_KERNEL_RX define.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/hyperv/hv_init.c            | 2 +-
 arch/x86/include/asm/pgtable_types.h | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index b0da5320bcff..5a4b363ba67b 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -355,7 +355,7 @@ void __init hyperv_init(void)
 	guest_id = generate_guest_id(0, LINUX_VERSION_CODE, 0);
 	wrmsrl(HV_X64_MSR_GUEST_OS_ID, guest_id);
 
-	hv_hypercall_pg  = __vmalloc(PAGE_SIZE, GFP_KERNEL, PAGE_KERNEL_RX);
+	hv_hypercall_pg = vmalloc_exec(PAGE_SIZE);
 	if (hv_hypercall_pg == NULL) {
 		wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
 		goto remove_cpuhp_state;
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index b6606fe6cfdf..947867f112ea 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -194,7 +194,6 @@ enum page_cache_mode {
 #define _PAGE_TABLE_NOENC	 (__PP|__RW|_USR|___A|   0|___D|   0|   0)
 #define _PAGE_TABLE		 (__PP|__RW|_USR|___A|   0|___D|   0|   0| _ENC)
 #define __PAGE_KERNEL_RO	 (__PP|   0|   0|___A|__NX|___D|   0|___G)
-#define __PAGE_KERNEL_RX	 (__PP|   0|   0|___A|   0|___D|   0|___G)
 #define __PAGE_KERNEL_NOCACHE	 (__PP|__RW|   0|___A|__NX|___D|   0|___G| __NC)
 #define __PAGE_KERNEL_VVAR	 (__PP|   0|_USR|___A|__NX|___D|   0|___G)
 #define __PAGE_KERNEL_LARGE	 (__PP|__RW|   0|___A|__NX|___D|_PSE|___G)
@@ -220,7 +219,6 @@ enum page_cache_mode {
 #define PAGE_KERNEL_RO		__pgprot_mask(__PAGE_KERNEL_RO         | _ENC)
 #define PAGE_KERNEL_EXEC	__pgprot_mask(__PAGE_KERNEL_EXEC       | _ENC)
 #define PAGE_KERNEL_EXEC_NOENC	__pgprot_mask(__PAGE_KERNEL_EXEC       |    0)
-#define PAGE_KERNEL_RX		__pgprot_mask(__PAGE_KERNEL_RX         | _ENC)
 #define PAGE_KERNEL_NOCACHE	__pgprot_mask(__PAGE_KERNEL_NOCACHE    | _ENC)
 #define PAGE_KERNEL_LARGE	__pgprot_mask(__PAGE_KERNEL_LARGE      | _ENC)
 #define PAGE_KERNEL_LARGE_EXEC	__pgprot_mask(__PAGE_KERNEL_LARGE_EXEC | _ENC)
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
