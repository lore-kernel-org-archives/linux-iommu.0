Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15462C433F5
	for <iommu@archiver.kernel.org>; Thu, 12 May 2022 03:39:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CDA3D83E49;
	Thu, 12 May 2022 03:39:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GuaPg-8RZqDT; Thu, 12 May 2022 03:39:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9F7B783E2C;
	Thu, 12 May 2022 03:39:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89480C0032;
	Thu, 12 May 2022 03:39:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2DC2BC002D
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 03:39:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0DBF340B6E
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 03:39:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=samsung.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wrsn8wi_6_yM for <iommu@lists.linux-foundation.org>;
 Thu, 12 May 2022 03:39:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 14DAE40585
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 03:39:29 +0000 (UTC)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20220512033926epoutp0347dd693dd5e4fc9f8dfc990493847a5d~uPnCYkjHb2320623206epoutp03V
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 03:39:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20220512033926epoutp0347dd693dd5e4fc9f8dfc990493847a5d~uPnCYkjHb2320623206epoutp03V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1652326766;
 bh=j7H+lYgLrxIwd/UWGDzvCeRAYA20sZX74We4b9F9RWw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Tc3u/bIH/OxEcctZtanwOGle1z0FER8kMaWyCtPCNbPCPAgI8U75uwQWZMOuICr41
 qnQnCzJmtSnVrjudWcgxuds4oqwT1eEbFfk8X/tqrskVL+OYK9ASh+ho/OfTHt5pup
 ThpsAyDdmeFd47YZpvbbdsa99/0Ftt3sxWpEnKj0=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTP id
 20220512033926epcas5p1f24cee324a020438f0c120d6eb214304~uPnCD3MpP0057600576epcas5p1C;
 Thu, 12 May 2022 03:39:26 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.174]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4KzHZf42v4z4x9Pr; Thu, 12 May
 2022 03:39:22 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
 epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
 6A.A6.09762.9618C726; Thu, 12 May 2022 12:39:21 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
 20220511121437epcas5p29d2210065b47346840c9c6ac14b0e585~uC-jtXoHL2858628586epcas5p2y;
 Wed, 11 May 2022 12:14:37 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20220511121437epsmtrp1b387b23b145dd996fa4816ef8f52b71a~uC-jshRt_0052800528epsmtrp1H;
 Wed, 11 May 2022 12:14:37 +0000 (GMT)
X-AuditID: b6c32a4b-213ff70000002622-40-627c81690c8c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 79.0F.11276.CA8AB726; Wed, 11 May 2022 21:14:36 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
 [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20220511121435epsmtip2552daaded7e433543c05e9341576f16d~uC-iNLKKW0495704957epsmtip26;
 Wed, 11 May 2022 12:14:35 +0000 (GMT)
From: Ajay Kumar <ajaykumar.rs@samsung.com>
To: linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com
Subject: [PATCH V2 3/6] iommu: iova: add support for 'first-fit' algorithm
Date: Wed, 11 May 2022 17:45:41 +0530
Message-Id: <20220511121544.5998-4-ajaykumar.rs@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220511121544.5998-1-ajaykumar.rs@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJKsWRmVeSWpSXmKPExsWy7bCmhm5mY02SwcEODouvJ36zWRx4f5DF
 4sG8bWwWC/ZbW3TO3sBusenxNVaLtUfuslss2vqF3eLghyesFi13TB24PJ4cnMfksWbeGkaP
 nbPusntsWtXJ5rF5Sb3H5BvLGT36tqxiDGCPyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUz
 MNQ1tLQwV1LIS8xNtVVy8QnQdcvMAbpOSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQ
 klNgUqBXnJhbXJqXrpeXWmJlaGBgZApUmJCdcX7pQ5aCD3IVJ5qXMjYwbpbsYuTkkBAwkXj+
 4gNzFyMXh5DAbkaJSYd/sUA4nxiBMr+hnG+MEkt2rmaFabnauBYqsZdRYtbr/ewQTguTRNPr
 K+wgVWwC2hLbpt9kAbFFBFoYJeZOswcpYhZYCTTqVgdYkbCAl0Tr8kdMIDaLgKrEmY7JYCt4
 BWwk+q9/YIFYJy+xesMBZhCbU8BWYtKOv4wggyQE3rJLTJu1GarIRWL6mWnsELawxKvjW6Bs
 KYmX/W1QdrXEuVv72SCaOxglOh6ug0rYSxy4MgdoEAfQeZoS63fpQ4RlJaaeWgd2HLMAn0Tv
 7ydMEHFeiR3zQGwOIFtNYusKP4iwjMSZg1egSjwk1q5uZ4KEygRGiV29R1gnMMrNQtiwgJFx
 FaNkakFxbnpqsWmBcV5qOTzekvNzNzGC06CW9w7GRw8+6B1iZOJgPMQowcGsJMK7v68iSYg3
 JbGyKrUoP76oNCe1+BCjKTAAJzJLiSbnAxNxXkm8oYmlgYmZmZmJpbGZoZI476n0DYlCAumJ
 JanZqakFqUUwfUwcnFINTNGvfLvZGDOvqOXs6NmtdvIsmx+TwToPjysnQrQZX9xZJrnow8Nv
 Cn/Dmv7u+HClsK0zdkLBqTVNMTs+vZeQnGFyuOF1tmaZyPtrV6QeZ3j2OnO3p93PFGZe9MZs
 9tqNF9NOf9lu82rfzW9uq2LuTVxeflnI6Ufmg0unF2e82S+a2Sue7xGZdcqyMt+m/2uag9/S
 Hc+f6E6cYFV+6Lx5x7ysxAmppev+rLL/qFC68PXXjF8d/HWrhV1S/m69bXm95N5JYEJeP6Um
 PuLpeVWTqNcnFau2XZ31dKJeZ9zdJ7PE5TvWzTiz4sETl6bQUK2ft55fWlhb8S7Z+sNCkYr3
 4oYd8c6fXd8fjhBx2ug494wSS3FGoqEWc1FxIgB6OQQCDAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrALMWRmVeSWpSXmKPExsWy7bCSvO6aFdVJBmearCy+nvjNZnHg/UEW
 iwfztrFZLNhvbdE5ewO7xabH11gt1h65y26xaOsXdouDH56wWrTcMXXg8nhycB6Tx5p5axg9
 ds66y+6xaVUnm8fmJfUek28sZ/To27KKMYA9issmJTUnsyy1SN8ugSvj/NKHLAUf5CpONC9l
 bGDcLNnFyMkhIWAicbVxLUsXIxeHkMBuRomVFz6wQSRkJJ7veMoCYQtLrPz3nB2iqIlJYvnS
 E2AJNgFtiW3Tb4J1iwh0MUpcvbqXFcRhFljLKPGqcQkjSJWwgJdE6/JHTCA2i4CqxJmOyawg
 Nq+AjUT/9Q9QK+QlVm84wAxicwrYSkza8ResVwioZs7no8wTGPkWMDKsYpRMLSjOTc8tNiww
 zEst1ytOzC0uzUvXS87P3cQIDlQtzR2M21d90DvEyMTBeIhRgoNZSYR3f19FkhBvSmJlVWpR
 fnxRaU5q8SFGaQ4WJXHeC10n44UE0hNLUrNTUwtSi2CyTBycUg1M27SetzzTalC8a313HX/8
 KcnPvY6ttV565QtqmNtZPx6fNvFLw8zLdzqUz8gfsFtz83iLEsMv6QSDH5YHjiy+NlXUTMFb
 8rHjytb8BbF9J3ec+je3tWrH7lhHlRX+d7VYpklqbzANP863xDBcxe9P36QFr+4aOG1v6N3E
 PDvuZtdMIeaWwNJodRUmA3HLf3MkndTkjpwJmn9B9NJbrmMtC+tvTd/EH/WmuTfE03Vb+sfS
 aKHao+/m7M9W/SrTePGUy/57QRuvXK38Iff6VIeR8ny9snnPo+wiy68sEHyle6jluXJa7rOi
 c1c3GZ0Nnf/jf+N7UUummyqp+sw+svXX5wjVM/lMXbp16+7H35WOK7EUZyQaajEXFScCAAiJ
 x1bDAgAA
X-CMS-MailID: 20220511121437epcas5p29d2210065b47346840c9c6ac14b0e585
X-Msg-Generator: CA
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220511121437epcas5p29d2210065b47346840c9c6ac14b0e585
References: <20220511121544.5998-1-ajaykumar.rs@samsung.com>
 <CGME20220511121437epcas5p29d2210065b47346840c9c6ac14b0e585@epcas5p2.samsung.com>
Cc: pankaj.dubey@samsung.com, alim.akhtar@samsung.com
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Marek Szyprowski <m.szyprowski@samsung.com>

Add support for the 'first-fit' allocation algorithm. It will be used for
the special case of implementing DMA_ATTR_LOW_ADDRESS, so this path
doesn't use IOVA cache.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
---
 drivers/iommu/iova.c | 78 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/iova.h |  2 ++
 2 files changed, 80 insertions(+)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index ae0fe0a6714e..89f9338f83a3 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -231,6 +231,59 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 	return -ENOMEM;
 }
 
+static unsigned long
+__iova_get_aligned_start(unsigned long start, unsigned long size)
+{
+	unsigned long mask = __roundup_pow_of_two(size) - 1;
+
+	return (start + mask) & ~mask;
+}
+
+static int __alloc_and_insert_iova_range_forward(struct iova_domain *iovad,
+			unsigned long size, unsigned long limit_pfn,
+			struct iova *new)
+{
+	struct rb_node *curr;
+	unsigned long flags;
+	unsigned long start, limit;
+
+	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
+
+	curr = rb_first(&iovad->rbroot);
+	limit = limit_pfn;
+	start = __iova_get_aligned_start(iovad->start_pfn, size);
+
+	while (curr) {
+		struct iova *curr_iova = rb_entry(curr, struct iova, node);
+		struct rb_node *next = rb_next(curr);
+
+		start = __iova_get_aligned_start(curr_iova->pfn_hi + 1, size);
+		if (next) {
+			struct iova *next_iova = rb_entry(next, struct iova, node);
+			limit = next_iova->pfn_lo - 1;
+		} else {
+			limit = limit_pfn;
+		}
+
+		if ((start + size) <= limit)
+			break;	/* found a free slot */
+		curr = next;
+	}
+
+	if (!curr && start + size > limit) {
+		spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
+		return -ENOMEM;
+	}
+
+	new->pfn_lo = start;
+	new->pfn_hi = new->pfn_lo + size - 1;
+	iova_insert_rbtree(&iovad->rbroot, new, curr);
+
+	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
+
+	return 0;
+}
+
 static struct kmem_cache *iova_cache;
 static unsigned int iova_cache_users;
 static DEFINE_MUTEX(iova_cache_mutex);
@@ -420,6 +473,31 @@ free_iova(struct iova_domain *iovad, unsigned long pfn)
 }
 EXPORT_SYMBOL_GPL(free_iova);
 
+/**
+ * alloc_iova_first_fit - allocates an iova from the beginning of address space
+ * @iovad: - iova domain in question
+ * @size: - size of page frames to allocate
+ * @limit_pfn: - max limit address
+ * Returns a pfn the allocated iova starts at or IOVA_BAD_ADDR in the case
+ * of a failure.
+ */
+unsigned long
+alloc_iova_first_fit(struct iova_domain *iovad, unsigned long size,
+		     unsigned long limit_pfn)
+{
+	struct iova *new_iova = alloc_iova_mem();
+
+	if (!new_iova)
+		return IOVA_BAD_ADDR;
+
+	if (__alloc_and_insert_iova_range_forward(iovad, size, limit_pfn, new_iova)) {
+		free_iova_mem(new_iova);
+		return IOVA_BAD_ADDR;
+	}
+	return new_iova->pfn_lo;
+}
+EXPORT_SYMBOL_GPL(alloc_iova_first_fit);
+
 /**
  * alloc_iova_fast - allocates an iova from rcache
  * @iovad: - iova domain in question
diff --git a/include/linux/iova.h b/include/linux/iova.h
index 46b5b10c532b..45ed6d41490a 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -89,6 +89,8 @@ void free_iova_fast(struct iova_domain *iovad, unsigned long pfn,
 		    unsigned long size);
 unsigned long alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
 			      unsigned long limit_pfn, bool flush_rcache);
+unsigned long alloc_iova_first_fit(struct iova_domain *iovad, unsigned long size,
+				   unsigned long limit_pfn);
 struct iova *reserve_iova(struct iova_domain *iovad, unsigned long pfn_lo,
 	unsigned long pfn_hi);
 void init_iova_domain(struct iova_domain *iovad, unsigned long granule,
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
