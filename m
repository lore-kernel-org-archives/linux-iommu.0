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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BCAC10F13
	for <iommu@archiver.kernel.org>; Tue, 16 Apr 2019 11:47:06 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C459B20873
	for <iommu@archiver.kernel.org>; Tue, 16 Apr 2019 11:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cU96DRv2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C459B20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id AC584FF6;
	Tue, 16 Apr 2019 11:47:06 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 64ADFFEC
	for <iommu@lists.linux-foundation.org>;
	Tue, 16 Apr 2019 11:47:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
	[209.85.214.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 19B741C0
	for <iommu@lists.linux-foundation.org>;
	Tue, 16 Apr 2019 11:47:05 +0000 (UTC)
Received: by mail-pl1-f193.google.com with SMTP id d1so10214878plj.8
	for <iommu@lists.linux-foundation.org>;
	Tue, 16 Apr 2019 04:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=naB3KMuHNTCaDD6/Z64EGJGrk7XQ7GW1pzVQ9Q3Vf6s=;
	b=cU96DRv2ov3f6Cd6NK8xcTZ/pxd6ORU1P19E6pQIz3B49Xye1iNecd9iNZibBfJcjQ
	zuIvUPJ+CLar5CQjZRDX3VQ1TZCDeFWlILHsb8dRJWggD00EqzXEkyE8uJG1kMP2eIvp
	n24W6tCY3AanegajVewju3yYDXmhf0X9II/qFV5HCylGUkejdXzo9E/koqfyqUqq8zr9
	mW/ZBFGmtcso0v4QTX5OavZW9KBMU22Tan8pYhZR4Ld+BqKTsHamZTqQU3PDd55gPcFI
	MsgxhBrhXIs5Fh8xdDdB8AJYcTdBC4NqYXVKmPD9APCljql55oe+X1QMkhe2S4UTALoW
	5KAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=naB3KMuHNTCaDD6/Z64EGJGrk7XQ7GW1pzVQ9Q3Vf6s=;
	b=Sg7rPmS+78jot6Bfr8rSem1UbcJt1g/Ce6/yResws2OaPiLBaGvFxq6tihGvgKPEx1
	TYW28zjiLD3g3PP0N6jsM2HYzB72AnyXNH1FlRk1McHqUjjtvcUpaJ8B+maabJzVyFx9
	slIiLnCi4raiy4/W8H8ok69RnZlvYrvI+gCGseIb4YX3e3AXSEt8GLdAlL8Fq16OVY9A
	w2R7pp0x4At5qcqYl22qbY3SO00/b0FlEd6GzJZNTKiSOGTXQD2g/zLxV8nRheb9j+2U
	AKu9VfOLwoPma+VEk1A1TWRsobj6EC1btpNq0sgQY5JLXdWmJ+uLPJkxA184e9yMVbtm
	nYsA==
X-Gm-Message-State: APjAAAXvk450AoHz7XuBakdRp3FmXL/Lofd6nMoJLxI4fiUr/V9wT6YK
	XCdrOeP4vxljputQTeR/E7c=
X-Google-Smtp-Source: APXvYqzDjDcAV7GNAw1BnDNouVWt6jT57KNhFlyZntYAXIOvC1nqtveURqFOLb2rK8ycg0MhFKUzow==
X-Received: by 2002:a17:902:d24:: with SMTP id
	33mr83552990plu.246.1555415224705; 
	Tue, 16 Apr 2019 04:47:04 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([49.207.50.11])
	by smtp.gmail.com with ESMTPSA id
	p6sm55942835pfd.122.2019.04.16.04.46.55
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 16 Apr 2019 04:47:03 -0700 (PDT)
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
Subject: [REBASE PATCH v5 3/9] drivers/firewire/core-iso.c: Convert to use
	vm_map_pages_zero()
Date: Tue, 16 Apr 2019 17:19:44 +0530
Message-Id: <88645f5ea8202784a8baaf389e592aeb8c505e8e.1552921225.git.jrdr.linux@gmail.com>
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

Convert to use vm_map_pages_zero() to map range of kernel memory
to user vma.

This driver has ignored vm_pgoff and mapped the entire pages. We
could later "fix" these drivers to behave according to the normal
vm_pgoff offsetting simply by removing the _zero suffix on the
function name and if that causes regressions, it gives us an easy
way to revert.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/firewire/core-iso.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/firewire/core-iso.c b/drivers/firewire/core-iso.c
index 35e784c..5414eb1 100644
--- a/drivers/firewire/core-iso.c
+++ b/drivers/firewire/core-iso.c
@@ -107,19 +107,8 @@ int fw_iso_buffer_init(struct fw_iso_buffer *buffer, struct fw_card *card,
 int fw_iso_buffer_map_vma(struct fw_iso_buffer *buffer,
 			  struct vm_area_struct *vma)
 {
-	unsigned long uaddr;
-	int i, err;
-
-	uaddr = vma->vm_start;
-	for (i = 0; i < buffer->page_count; i++) {
-		err = vm_insert_page(vma, uaddr, buffer->pages[i]);
-		if (err)
-			return err;
-
-		uaddr += PAGE_SIZE;
-	}
-
-	return 0;
+	return vm_map_pages_zero(vma, buffer->pages,
+					buffer->page_count);
 }
 
 void fw_iso_buffer_destroy(struct fw_iso_buffer *buffer,
-- 
1.9.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
