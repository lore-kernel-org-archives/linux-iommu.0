Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF99DC433EF
	for <iommu@archiver.kernel.org>; Thu, 12 May 2022 03:39:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8175883E45;
	Thu, 12 May 2022 03:39:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vyaPx0z8oJQK; Thu, 12 May 2022 03:39:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7305683E2C;
	Thu, 12 May 2022 03:39:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C025C0032;
	Thu, 12 May 2022 03:39:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D31AFC002D
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 03:39:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B3ACE83E35
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 03:39:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gqwozWtHNVWi for <iommu@lists.linux-foundation.org>;
 Thu, 12 May 2022 03:39:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DF4E583E2C
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 03:39:21 +0000 (UTC)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20220512033918epoutp04f2f0abc8b8027b2226e73cc7a1ec98c7~uPm6aacPm0345903459epoutp04f
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 03:39:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20220512033918epoutp04f2f0abc8b8027b2226e73cc7a1ec98c7~uPm6aacPm0345903459epoutp04f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1652326758;
 bh=+wT2r4n3TIMDY8os27KAPUHZaWrqx3jti6oNFiaafgc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UPgg3BwynPxj38DCfywh8oBCtgndIma4ppp1Qi1pQpAl1AhjhHGw8QhkXAlJmrp8T
 +iwOAps3qTcdhDVJnh+WqtgUDwr1k6qI8BcALhRBNPAd26wKcHVKoJMf1W1FLXu+zS
 s/n+XIyXuoZkJbsILFOvdB3cI2AEFSOvUMvCRNA0=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTP id
 20220512033917epcas5p29b0e82b814f01c966c2b7957c72b01bc~uPm5y7ZNG1580715807epcas5p2l;
 Thu, 12 May 2022 03:39:17 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.177]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4KzHZT32dMz4x9Q1; Thu, 12 May
 2022 03:39:13 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
 epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 BE.2E.09827.D518C726; Thu, 12 May 2022 12:39:10 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
 20220511121429epcas5p2d91f585a555e51b1c11e9e02c1b8dc15~uC-c0GfsI1315313153epcas5p2g;
 Wed, 11 May 2022 12:14:29 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20220511121429epsmtrp1d6e1d59945032e59c23b97e22581f223~uC-czKEd80052800528epsmtrp1E;
 Wed, 11 May 2022 12:14:29 +0000 (GMT)
X-AuditID: b6c32a4a-b3bff70000002663-00-627c815d5f70
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 18.0F.11276.5A8AB726; Wed, 11 May 2022 21:14:29 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
 [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20220511121428epsmtip27174326ce33b5a4649137f1123356a2e~uC-bTft4s0270302703epsmtip26;
 Wed, 11 May 2022 12:14:27 +0000 (GMT)
From: Ajay Kumar <ajaykumar.rs@samsung.com>
To: linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com
Subject: [PATCH V2 1/6] dma-mapping: add DMA_ATTR_LOW_ADDRESS attribute
Date: Wed, 11 May 2022 17:45:39 +0530
Message-Id: <20220511121544.5998-2-ajaykumar.rs@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220511121544.5998-1-ajaykumar.rs@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGKsWRmVeSWpSXmKPExsWy7bCmum5cY02Swe+ZjBZfT/xmszjw/iCL
 xYN529gsFuy3tuicvYHdYtPja6wWa4/cZbdYtPULu8XBD09YLVrumDpweTw5OI/JY828NYwe
 O2fdZffYtKqTzWPzknqPyTeWM3r0bVnFGMAelW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pm
 YKhraGlhrqSQl5ibaqvk4hOg65aZA3SdkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUg
 JafApECvODG3uDQvXS8vtcTK0MDAyBSoMCE7o6Gli63gIVfFmYXLmBsYP3J0MXJwSAiYSJz8
 nNjFyMUhJLCbUaK58TlbFyMnkPOJUeLTSj+IxDdGiVVvTrOCJEAaZv1dzgaR2Msoca51E5TT
 wiTx5P4adpAqNgFtiW3Tb7KA2CICLYwSc6fZgxQxC6xklFhyqwOsSFjAXWLDsx6wfSwCqhLT
 2+aDreAVsJH4/34hG8Q6eYnVGw4wg9icArYSk3b8ZQQZJCHwll3i+KNdLBBFLhKTP/2Guk9Y
 4tXxLewQtpTEy/42KLta4tyt/WwQzR2MEh0P10El7CUOXJnDAgoNZgFNifW79CHCshJTT61j
 ArGZBfgken8/YYKI80rsmAdigwJPTWLrCj+IsIzEmYNXoMIeErdvBEICZQKjRMvHO6wTGOVm
 ISxYwMi4ilEytaA4Nz212LTAKC+1HB5pyfm5mxjBCVDLawfjwwcf9A4xMnEwHmKU4GBWEuHd
 31eRJMSbklhZlVqUH19UmpNafIjRFBh+E5mlRJPzgSk4ryTe0MTSwMTMzMzE0tjMUEmc93T6
 hkQhgfTEktTs1NSC1CKYPiYOTqkGptSwx4drzT9EzGsXX3MvZ5lQcebcdxtfcC49/vyg9ZRO
 RvuGBd9ffZlyOHRieElvrlGlJ4eZoJKDJJO7yib5w3abbhw9yprMuKg8NuH23ioz8f9519dM
 09ebpS/0hk3m8dOCrQ+ucr5bGtEyc9mRefdajr5lNkl9PHWnbtez78d8pqixBWyd/H+9hfPS
 Iyp3Ope9vxb1j2+HcNmEE49nBhh/35ym/enKc+XJElNi36uvPJAq9fVrreRRo/z2r8Iluie2
 FbvwZizWfrHx+NKY62bTqwS5o67LbqpJ+honteiU72f29yty55lX29/eu2rLkZ2Zp9xTpBbv
 XWe/QSIxuVOC/5NvMOu6+xvNPaSYz9grsRRnJBpqMRcVJwIAttaZnQkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrALMWRmVeSWpSXmKPExsWy7bCSvO7SFdVJBp1XFSy+nvjNZnHg/UEW
 iwfztrFZLNhvbdE5ewO7xabH11gt1h65y26xaOsXdouDH56wWrTcMXXg8nhycB6Tx5p5axg9
 ds66y+6xaVUnm8fmJfUek28sZ/To27KKMYA9issmJTUnsyy1SN8ugSujoaWLreAhV8WZhcuY
 Gxg/cnQxcnJICJhIzPq7nK2LkYtDSGA3o8TzdTcZIRIyEs93PGWBsIUlVv57zg5R1MQk8WHZ
 ErAiNgFtiW3Tb7KAJEQEuhglrl7dywriMAusZZR41QhRJSzgLrHhWQ8biM0ioCoxvW0+K4jN
 K2Aj8f/9QjaIFfISqzccYAaxOQVsJSbt+AvWKwRUM+fzUeYJjHwLGBlWMUqmFhTnpucWGxYY
 5qWW6xUn5haX5qXrJefnbmIEB6qW5g7G7as+6B1iZOJgPMQowcGsJMK7v68iSYg3JbGyKrUo
 P76oNCe1+BCjNAeLkjjvha6T8UIC6YklqdmpqQWpRTBZJg5OqQamKL2y9fNPzvfvM6lvq/ZV
 DLz+gTvlqFoBS3bjlIAl8bWs5cvmW3IGTWg6VP57faLFSa8lRpWW8t/sRKbM+2t0f35w/STV
 Fd8OmKqu2vi5gFXw5c+gycwmPmY7lWzkF8VJ5WZfL7y7NfqasLGvTYrizEXB2WH9nN9W2zsq
 CYlaPWQSNQ2Jvzhb7PClL/vvatn988ttN2A6J/DD0bnrqrU816Vv0+w+2By9qvbFNqrwyeRt
 0pcnuFzu5ay8Vf76ivUNrRN/v5hWTejwON8f1vj1u7rE36VTzlrnhO3x6GBz2lsRGVTXtsw2
 Re7wxQjZ/im5Z37fKton+LQ05+wtf3v5l9Eh0lPmVW75+/LU2gQlluKMREMt5qLiRACMPfpe
 wwIAAA==
X-CMS-MailID: 20220511121429epcas5p2d91f585a555e51b1c11e9e02c1b8dc15
X-Msg-Generator: CA
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220511121429epcas5p2d91f585a555e51b1c11e9e02c1b8dc15
References: <20220511121544.5998-1-ajaykumar.rs@samsung.com>
 <CGME20220511121429epcas5p2d91f585a555e51b1c11e9e02c1b8dc15@epcas5p2.samsung.com>
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

Some devices require to allocate a special buffer (usually for the
firmware) just at the beginning of the address space to ensure that all
further allocations can be expressed as a positive offset from that
special buffer. When IOMMU is used for managing the DMA address space,
such requirement can be easily fulfilled, simply by enforcing the
'first-fit' IOVA allocation algorithm.

This patch adds a DMA attribute for such case.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
---
 include/linux/dma-mapping.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index dca2b1355bb1..3cbdf857edd1 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -60,6 +60,12 @@
  * at least read-only at lesser-privileged levels).
  */
 #define DMA_ATTR_PRIVILEGED		(1UL << 9)
+/*
+ * DMA_ATTR_LOW_ADDRESS: used to indicate that the buffer should be allocated
+ * at the lowest possible DMA address, usually just at the beginning of the
+ * DMA/IOVA address space ('first-fit' allocation algorithm).
+ */
+#define DMA_ATTR_LOW_ADDRESS		(1UL << 10)
 
 /*
  * A dma_addr_t can hold any valid DMA or bus address for the platform.  It can
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
