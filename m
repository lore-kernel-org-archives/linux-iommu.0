Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80DA66E8
	for <iommu@lists.linux.dev>; Tue, 13 Sep 2022 19:58:39 +0000 (UTC)
Received: by mail-qt1-f175.google.com with SMTP id b23so4696721qtr.13
        for <iommu@lists.linux.dev>; Tue, 13 Sep 2022 12:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=5WWAAzNcGRX09yf3QcgLeiV4ytIgw0QIAz2zMov/ZDY=;
        b=Yz1mtV6YiuvArbfHbQBXNKT9eLELbvn7bnniGDLD1BumkiBsr2ZDlVa36+Wy8wKT5o
         ryYhGAJx49vUh11TKsorymepYWGSO76xJbhP0rWVGH3ntJ/cZBgl0HG4OoxTwsRCKi5P
         r8fZHkmi9dhCwHqvtScDgQwe7gg6nWmJBlbT6hYOH0ew7iRaIAjSwvoSk6SKm+tRfQu+
         rKZsLcxmkz1cCAli2W9VyR6gyYWGuJOVoZMSgPsY0YmHve5v7DOrmmIyu3LMUZg6pUfw
         lIU/zKc3QMqDUaQMXnCFOtpC/YhN4nYgSjeSX0Y2GgcVNB6wvWWTn+zhjMxvZzDNv7zs
         69cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=5WWAAzNcGRX09yf3QcgLeiV4ytIgw0QIAz2zMov/ZDY=;
        b=t1Nd/vHdIuYSNm+ibKbxYdEq8dAKNa88Vzp/Nbw3XEmxnsxuNdoX7mfKfCLYd++i11
         /sgXqlsnZNjQoorP7t+1bYoQzNUNBziWE1wxLmDMrb17ryL7NEVISz7eITYjH8jVd1cl
         sQthUx+1xgwxvGEcBnyDf8YuTrzlQZSuYpZX3YpukGwkvmtpr50nl0ALFO1Iocuh9sRE
         on+Uw/4vqKdtp85vp5BtnZGU95b+l86Ja1HMQHJetb+37DNA++dSLyUVs8qwzNN0mR5t
         T1V6WifKweodq5gsktqS6ifq2pSft+fXYFlT3dK7rJYzTYKhAaaBeTEKlsUIBtT5DEGp
         2Z6w==
X-Gm-Message-State: ACgBeo2XGJas5S5yi9j6uyA870m4eNSoXz4RnOLzqoqgZxVOKC9atyVc
	goH38kMKB+dYDc/Q6Mhj/Ek=
X-Google-Smtp-Source: AA6agR6JFHHtW1Pd7kJf3d4lhxO33YWLvSfzGCmyAGQLZ1dEkgSuVHnr1X0agG5L8d/cKj0D7xYuZA==
X-Received: by 2002:a05:622a:1998:b0:343:6452:dbd9 with SMTP id u24-20020a05622a199800b003436452dbd9mr30254647qtc.423.1663099118855;
        Tue, 13 Sep 2022 12:58:38 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a29cb00b006b8e049cf08sm276305qkp.2.2022.09.13.12.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 12:58:38 -0700 (PDT)
From: Doug Berger <opendmb@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <songmuchun@bytedance.com>,
	Mike Rapoport <rppt@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Borislav Petkov <bp@suse.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	Oscar Salvador <osalvador@suse.de>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Kees Cook <keescook@chromium.org>,
	- <devicetree-spec@vger.kernel.org>,
	KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
	Mel Gorman <mgorman@suse.de>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mm@kvack.org,
	iommu@lists.linux.dev
Subject: [PATCH 12/21] memblock: introduce MEMBLOCK_MOVABLE flag
Date: Tue, 13 Sep 2022 12:54:59 -0700
Message-Id: <20220913195508.3511038-13-opendmb@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220913195508.3511038-1-opendmb@gmail.com>
References: <20220913195508.3511038-1-opendmb@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MEMBLOCK_MOVABLE flag is introduced to designate a memblock
as only supporting movable allocations by the page allocator.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 include/linux/memblock.h |  8 ++++++++
 mm/memblock.c            | 24 ++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 50ad19662a32..8eb3ca32dfa7 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -47,6 +47,7 @@ enum memblock_flags {
 	MEMBLOCK_MIRROR		= 0x2,	/* mirrored region */
 	MEMBLOCK_NOMAP		= 0x4,	/* don't add to kernel direct mapping */
 	MEMBLOCK_DRIVER_MANAGED = 0x8,	/* always detected via a driver */
+	MEMBLOCK_MOVABLE	= 0x10,	/* designated movable block */
 };
 
 /**
@@ -125,6 +126,8 @@ int memblock_clear_hotplug(phys_addr_t base, phys_addr_t size);
 int memblock_mark_mirror(phys_addr_t base, phys_addr_t size);
 int memblock_mark_nomap(phys_addr_t base, phys_addr_t size);
 int memblock_clear_nomap(phys_addr_t base, phys_addr_t size);
+int memblock_mark_movable(phys_addr_t base, phys_addr_t size);
+int memblock_clear_movable(phys_addr_t base, phys_addr_t size);
 
 void memblock_free_all(void);
 void memblock_free(void *ptr, size_t size);
@@ -265,6 +268,11 @@ static inline bool memblock_is_driver_managed(struct memblock_region *m)
 	return m->flags & MEMBLOCK_DRIVER_MANAGED;
 }
 
+static inline bool memblock_is_movable(struct memblock_region *m)
+{
+	return m->flags & MEMBLOCK_MOVABLE;
+}
+
 int memblock_search_pfn_nid(unsigned long pfn, unsigned long *start_pfn,
 			    unsigned long  *end_pfn);
 void __next_mem_pfn_range(int *idx, int nid, unsigned long *out_start_pfn,
diff --git a/mm/memblock.c b/mm/memblock.c
index b5d3026979fc..5d6a210d98ec 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -979,6 +979,30 @@ int __init_memblock memblock_clear_nomap(phys_addr_t base, phys_addr_t size)
 	return memblock_setclr_flag(base, size, 0, MEMBLOCK_NOMAP);
 }
 
+/**
+ * memblock_mark_movable - Mark designated movable block with MEMBLOCK_MOVABLE.
+ * @base: the base phys addr of the region
+ * @size: the size of the region
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int __init_memblock memblock_mark_movable(phys_addr_t base, phys_addr_t size)
+{
+	return memblock_setclr_flag(base, size, 1, MEMBLOCK_MOVABLE);
+}
+
+/**
+ * memblock_clear_movable - Clear flag MEMBLOCK_MOVABLE for a specified region.
+ * @base: the base phys addr of the region
+ * @size: the size of the region
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int __init_memblock memblock_clear_movable(phys_addr_t base, phys_addr_t size)
+{
+	return memblock_setclr_flag(base, size, 0, MEMBLOCK_MOVABLE);
+}
+
 static bool should_skip_region(struct memblock_type *type,
 			       struct memblock_region *m,
 			       int nid, int flags)
-- 
2.25.1

