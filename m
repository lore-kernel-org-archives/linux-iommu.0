Return-Path: <SRS0=xVSy=SS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B68EC10F13
	for <iommu@archiver.kernel.org>; Tue, 16 Apr 2019 11:47:46 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CECB4218A1
	for <iommu@archiver.kernel.org>; Tue, 16 Apr 2019 11:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXwEOG+W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CECB4218A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A58C7FF6;
	Tue, 16 Apr 2019 11:47:45 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id F0F67FEC
	for <iommu@lists.linux-foundation.org>;
	Tue, 16 Apr 2019 11:47:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
	[209.85.210.194])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 8A3441C0
	for <iommu@lists.linux-foundation.org>;
	Tue, 16 Apr 2019 11:47:43 +0000 (UTC)
Received: by mail-pf1-f194.google.com with SMTP id c8so10273536pfd.10
	for <iommu@lists.linux-foundation.org>;
	Tue, 16 Apr 2019 04:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=36ygGGspzW8ypHYiojY4a19UR4qM+LFcK/AqwiiUnW8=;
	b=LXwEOG+W0ZQnOV2lka03GCK9IgBNrr2lBHro8hNifiyxcZ1ikGgvj2ATkkyJCssND8
	uIPVeiMq3yAZqI2LRlD5+9ATQBkpSshzqQSOoBXRtlcWTYQLKVuuH4kaV4JTlXNkR+jC
	wC5P4kfnmC7ntOMn64m/bYNLTdyS4iMoIxEyoe9RYklbyAWpXNsUv/czOEu/u4O+CNOJ
	r+CoNYaio4w+bxXWIV46A5NDf57dX4MiBRpyE+Fjkp3V8JI4WHUYiIE1A4jZPA3tEpme
	8QQmC2+oUNqGbHI4n/hFz912t+1dDesjfB9zqyhAjR4tOEGZue5u9dsipu1pezIzmEMU
	KkhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=36ygGGspzW8ypHYiojY4a19UR4qM+LFcK/AqwiiUnW8=;
	b=BeLGo4J+eYSmtXQKzJ3kGHsUV9g6CiCmgs05rXRcC6AEcBDudA/OWM2ljmET1ipesi
	+QWykjlOdRbldgUIvHAW5rt+nffmJo32d3BLEhY89ihT8HaB6cNJm0pMYU/WuOiThg04
	3u5siA++TKsb+lrzQMegeyq4VfQJN2WoF+a0qCaL9Zwo0b7/z7p0JJR4t127r/5iFT4i
	/KsGH0o6izBtc1o3C3hyN7NcroyKGXvZ4Atm/+ETz3puAOmOTgg5amEhQS0J2+4AJgUp
	fVUUHJcD3bp4TzIk1E7ArQFY/3en0FqGEJ5tO56f7e2leBJhShRQCx6f1y6KnDSuuX6S
	HQvg==
X-Gm-Message-State: APjAAAXXKAvp0Wrh1MPAE25C25Dn1T6ncsiP+guF9ZJpJFsX4RsHMztI
	FInJZGk0epJ1EcpJaAQEt0c=
X-Google-Smtp-Source: APXvYqye06grMbHjmTb1XwCWWLzi7D/Hr7gyojBySrV/ZCmbi+kTA1CovWh+pYieLteg38xYkWediQ==
X-Received: by 2002:a65:5089:: with SMTP id r9mr75893740pgp.14.1555415263156; 
	Tue, 16 Apr 2019 04:47:43 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([49.207.50.11])
	by smtp.gmail.com with ESMTPSA id
	p6sm55942835pfd.122.2019.04.16.04.47.33
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 16 Apr 2019 04:47:42 -0700 (PDT)
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
Subject: [REBASE PATCH v5 7/9] videobuf2/videobuf2-dma-sg.c: Convert to use
	vm_map_pages()
Date: Tue, 16 Apr 2019 17:19:48 +0530
Message-Id: <a953fe6b3056de1cc6eab654effdd4a22f125375.1552921225.git.jrdr.linux@gmail.com>
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

Convert to use vm_map_pages() to map range of kernel memory
to user vma.

vm_pgoff is treated in V4L2 API as a 'cookie' to select a buffer,
not as a in-buffer offset by design and it always want to mmap a
whole buffer from its beginning.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/media/common/videobuf2/videobuf2-core.c    |  7 +++++++
 .../media/common/videobuf2/videobuf2-dma-contig.c  |  6 ------
 drivers/media/common/videobuf2/videobuf2-dma-sg.c  | 22 ++++++----------------
 3 files changed, 13 insertions(+), 22 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index 70e8c33..ca4577a 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -2175,6 +2175,13 @@ int vb2_mmap(struct vb2_queue *q, struct vm_area_struct *vma)
 		goto unlock;
 	}
 
+	/*
+	 * vm_pgoff is treated in V4L2 API as a 'cookie' to select a buffer,
+	 * not as a in-buffer offset. We always want to mmap a whole buffer
+	 * from its beginning.
+	 */
+	vma->vm_pgoff = 0;
+
 	ret = call_memop(vb, mmap, vb->planes[plane].mem_priv, vma);
 
 unlock:
diff --git a/drivers/media/common/videobuf2/videobuf2-dma-contig.c b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
index aff0ab7..46245c5 100644
--- a/drivers/media/common/videobuf2/videobuf2-dma-contig.c
+++ b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
@@ -186,12 +186,6 @@ static int vb2_dc_mmap(void *buf_priv, struct vm_area_struct *vma)
 		return -EINVAL;
 	}
 
-	/*
-	 * dma_mmap_* uses vm_pgoff as in-buffer offset, but we want to
-	 * map whole buffer
-	 */
-	vma->vm_pgoff = 0;
-
 	ret = dma_mmap_attrs(buf->dev, vma, buf->cookie,
 		buf->dma_addr, buf->size, buf->attrs);
 
diff --git a/drivers/media/common/videobuf2/videobuf2-dma-sg.c b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
index 015e737..d6b8eca 100644
--- a/drivers/media/common/videobuf2/videobuf2-dma-sg.c
+++ b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
@@ -328,28 +328,18 @@ static unsigned int vb2_dma_sg_num_users(void *buf_priv)
 static int vb2_dma_sg_mmap(void *buf_priv, struct vm_area_struct *vma)
 {
 	struct vb2_dma_sg_buf *buf = buf_priv;
-	unsigned long uaddr = vma->vm_start;
-	unsigned long usize = vma->vm_end - vma->vm_start;
-	int i = 0;
+	int err;
 
 	if (!buf) {
 		printk(KERN_ERR "No memory to map\n");
 		return -EINVAL;
 	}
 
-	do {
-		int ret;
-
-		ret = vm_insert_page(vma, uaddr, buf->pages[i++]);
-		if (ret) {
-			printk(KERN_ERR "Remapping memory, error: %d\n", ret);
-			return ret;
-		}
-
-		uaddr += PAGE_SIZE;
-		usize -= PAGE_SIZE;
-	} while (usize > 0);
-
+	err = vm_map_pages(vma, buf->pages, buf->num_pages);
+	if (err) {
+		printk(KERN_ERR "Remapping memory, error: %d\n", err);
+		return err;
+	}
 
 	/*
 	 * Use common vm_area operations to track buffer refcount.
-- 
1.9.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
