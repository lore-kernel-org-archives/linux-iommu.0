Return-Path: <SRS0=xVSy=SS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD293C10F14
	for <iommu@archiver.kernel.org>; Tue, 16 Apr 2019 11:46:57 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E4DE2087C
	for <iommu@archiver.kernel.org>; Tue, 16 Apr 2019 11:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oeEcKFpL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E4DE2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 74CC9FF1;
	Tue, 16 Apr 2019 11:46:57 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id CA5F2FE9
	for <iommu@lists.linux-foundation.org>;
	Tue, 16 Apr 2019 11:46:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com
	[209.85.210.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 80F776C5
	for <iommu@lists.linux-foundation.org>;
	Tue, 16 Apr 2019 11:46:55 +0000 (UTC)
Received: by mail-pf1-f195.google.com with SMTP id 188so10280996pfd.8
	for <iommu@lists.linux-foundation.org>;
	Tue, 16 Apr 2019 04:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=cNyFM0J2DfW9voxw9FzV7E7Y/LrzsWkGDKLqwe0d5pk=;
	b=oeEcKFpL3vmK9+DpAkDM2pqJ4cwz8D1E2liXXkVcMS/mCROTNxreZ3tJiZU7AMhYGa
	jdvIuxFSG51quKMSoG7eGUWo0OFVjsfwlsv0j6QgATWKo4Y/zRlxt4YEDfEpCBvwBcDU
	oLh7KOdm3sUnBXGsWZumlJIoubWl0FlACsdqSTDMD22x9YueAbdJduUdqxf+Fzo+qE4b
	G/2XochB6n9yIyfIIw7vwaFhmKiDJzF2ILx3ft6jONO/3Tp5olQ3mZrspX0N7+OtxUzw
	L3gftE9ttJboi/nhCsZ8IHvh1byiu+1G+2wjx/i6t9Le5dXmn/WMY4e9g4nRHdsI6qmW
	KGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=cNyFM0J2DfW9voxw9FzV7E7Y/LrzsWkGDKLqwe0d5pk=;
	b=R5oFEyrbMHe1P78yCc/hoXsJoYBayKN2aGTVfLAdDelwVZFQ1Ymu6hYnWI2ebU6cXM
	YIAdYflPHhq+PefXPA8V1Wz12EFe9dM6+gwYS7dZSlngFGrM6zReKn7awQBF9Pm16hTK
	9XPt1G8LO5iI9XWMzQRq5hGpwOI2Xy/KYm3d/QeazWiRHjHiS9JNs9KMduKvtEvHG7y1
	DhIT8igYZ2EZt1FyGBgobQicaN2RPaGFFiMQTdCgbVYfJDyvBg3jPKuMzdW/fW78VTm3
	9cmeQ7R1D37XtZ99kEp9GRToz8pybHidqRMiKRAuxTU6pCudo9BTlN8TAKUkkGhVJWR1
	6E2w==
X-Gm-Message-State: APjAAAUPkrxt5/o0ZRv0VW24XxtqnBYslmQUPlRLQrMlj0Xhsen9y1as
	7M2dqLcFSs9RGNfp0jnKbVw=
X-Google-Smtp-Source: APXvYqzT/G52JjPlhhzDjlzXSHHg4UNZ4b12u0OW4Mw/nQ9ugBF4FdGP/KIWXfE/EW5Pz1mzLpMj5g==
X-Received: by 2002:a62:6ec6:: with SMTP id j189mr346760pfc.195.1555415215118; 
	Tue, 16 Apr 2019 04:46:55 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([49.207.50.11])
	by smtp.gmail.com with ESMTPSA id
	p6sm55942835pfd.122.2019.04.16.04.46.45
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 16 Apr 2019 04:46:54 -0700 (PDT)
From: Souptick Joarder <jrdr.linux@gmail.com>
To: akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
	kirill.shutemov@linux.intel.com, vbabka@suse.cz, riel@surriel.com,
	sfr@canb.auug.org.au, rppt@linux.vnet.ibm.com, peterz@infradead.org,
	linux@armlinux.org.uk, robin.murphy@arm.com, iamjoonsoo.kim@lge.com,
	treding@nvidia.com, keescook@chromium.org, m.szyprowski@samsung.com,
	stefanr@s5r6.in-berlin.de, hjc@rock-chips.com, heiko@sntech.de,
	airlied@linux.ie, oleksandr_andrushchenko@epam.com, joro@8bytes.org,
	pawel@osciak.com, kyungmin.park@samsung.com, mchehab@kernel.org,
	boris.ostrovsky@oracle.com, jgross@suse.com
Subject: [REBASE PATCH v5 2/9] arm: mm: dma-mapping: Convert to use
	vm_map_pages()
Date: Tue, 16 Apr 2019 17:19:43 +0530
Message-Id: <936e5e107c746a7310e3a3c471188ca3ac8f9754.1552921225.git.jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1552921225.git.jrdr.linux@gmail.com>
References: <cover.1552921225.git.jrdr.linux@gmail.com>
In-Reply-To: <cover.1552921225.git.jrdr.linux@gmail.com>
References: <cover.1552921225.git.jrdr.linux@gmail.com>
Cc: linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, xen-devel@lists.xen.org,
	linux-mm@kvack.org, iommu@lists.linux-foundation.org,
	Souptick Joarder <jrdr.linux@gmail.com>,
	linux1394-devel@lists.sourceforge.net,
	linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Convert to use vm_map_pages() to map range of kernel
memory to user vma.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 arch/arm/mm/dma-mapping.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index f1e2922..de7c76e 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1575,31 +1575,21 @@ static int __arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma
 		    void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		    unsigned long attrs)
 {
-	unsigned long uaddr = vma->vm_start;
-	unsigned long usize = vma->vm_end - vma->vm_start;
 	struct page **pages = __iommu_get_pages(cpu_addr, attrs);
 	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	unsigned long off = vma->vm_pgoff;
+	int err;
 
 	if (!pages)
 		return -ENXIO;
 
-	if (off >= nr_pages || (usize >> PAGE_SHIFT) > nr_pages - off)
+	if (vma->vm_pgoff >= nr_pages)
 		return -ENXIO;
 
-	pages += off;
-
-	do {
-		int ret = vm_insert_page(vma, uaddr, *pages++);
-		if (ret) {
-			pr_err("Remapping memory failed: %d\n", ret);
-			return ret;
-		}
-		uaddr += PAGE_SIZE;
-		usize -= PAGE_SIZE;
-	} while (usize > 0);
+	err = vm_map_pages(vma, pages, nr_pages);
+	if (err)
+		pr_err("Remapping memory failed: %d\n", err);
 
-	return 0;
+	return err;
 }
 static int arm_iommu_mmap_attrs(struct device *dev,
 		struct vm_area_struct *vma, void *cpu_addr,
-- 
1.9.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
