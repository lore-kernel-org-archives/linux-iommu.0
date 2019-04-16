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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A947C10F13
	for <iommu@archiver.kernel.org>; Tue, 16 Apr 2019 11:47:25 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 500F020872
	for <iommu@archiver.kernel.org>; Tue, 16 Apr 2019 11:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRbSr4JY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 500F020872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 378A3FEB;
	Tue, 16 Apr 2019 11:47:25 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id BBBCEFE9
	for <iommu@lists.linux-foundation.org>;
	Tue, 16 Apr 2019 11:47:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
	[209.85.214.196])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 6DE696C5
	for <iommu@lists.linux-foundation.org>;
	Tue, 16 Apr 2019 11:47:24 +0000 (UTC)
Received: by mail-pl1-f196.google.com with SMTP id d1so10215292plj.8
	for <iommu@lists.linux-foundation.org>;
	Tue, 16 Apr 2019 04:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=wsI5nOykFSX6S7SyN92+LRaxG3yXSZXxVHkiaYJTa/M=;
	b=DRbSr4JYhMaKQ5p3pSrZNdJX2v94ShwHCZj4JAJ277tZ1wQsiIQl2m3vs4+ZyECEeS
	ypZFAEQ/iRhrJ4cy8tjSf8TINaI7KNT+bZBUhPA2nIMoy+GPcnOzX727oWD/PJNtlrh+
	HyaY9/HNlgDRuGW7rwokX24bptqOXuI9I8zNMxdpFUbLTeIv3TSNs3SkFfabWtME2qqp
	T/IiDWs5sO90ha1GY7nB5d4PNLg62FUtdtcVR8CmHWcINbDhMOvDh/r39YDnRTWFwcPF
	G5IZMu2jRg+rHhl3BtSMwVjwJinoSfvFQCvL2mrSSRqW5pkek6voVHHXMb94dmQpbOpR
	vYSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=wsI5nOykFSX6S7SyN92+LRaxG3yXSZXxVHkiaYJTa/M=;
	b=Ia8orFy3+nabIjyYgZRnGdg5bVfByGt6GcgWSaTLJd0VhpjHQ4GaugRU1SXEqFOFeS
	Eelef4z9swhfg13A7IexpoXyFbdNcQwhCRpknlsCCmFVlZWV8iGuVf8Nk99JmS5C87cY
	caxFhMX6wfYnRPrR7DJf3piqZoUy40ZaWgZOeDV/wgKymHg7zFKPmFwaXaIG/NG6Gpa8
	shkIB6ZdrUUBfJ9RGSy/GxiKRe+t0foSNnZEG7eH+urq3h8RIt91cD5hR8/tY6EpgLmt
	c0vnQr9iNWK5nnzIy0j3+fTqAu4juGOzTmI1mVqjOCvMqcpeA4rrYoHYzRDQfXvssWwX
	zx5A==
X-Gm-Message-State: APjAAAXk4fhWF6XrGfD8lWEJCCJIPbFahqB1T9qiWPga52WGZSMfM0m/
	SCRJQAwAGI3MeBtpZlop6V8=
X-Google-Smtp-Source: APXvYqwD0xz7vCOqB5SDlSiBwryde6J7jA8KbAOcQ8+b3Q+tiiDDskcFLBFNGuxSXVMUW6Tz86k9Zg==
X-Received: by 2002:a17:902:e382:: with SMTP id
	ch2mr79568490plb.94.1555415244031; 
	Tue, 16 Apr 2019 04:47:24 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([49.207.50.11])
	by smtp.gmail.com with ESMTPSA id
	p6sm55942835pfd.122.2019.04.16.04.47.14
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 16 Apr 2019 04:47:23 -0700 (PDT)
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
Subject: [REBASE PATCH v5 5/9] drm/xen/xen_drm_front_gem.c: Convert to use
	vm_map_pages()
Date: Tue, 16 Apr 2019 17:19:46 +0530
Message-Id: <ff8e10ba778d79419c66ee8215bccf01560540fd.1552921225.git.jrdr.linux@gmail.com>
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
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 drivers/gpu/drm/xen/xen_drm_front_gem.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/xen/xen_drm_front_gem.c b/drivers/gpu/drm/xen/xen_drm_front_gem.c
index 28bc501..dd0602d 100644
--- a/drivers/gpu/drm/xen/xen_drm_front_gem.c
+++ b/drivers/gpu/drm/xen/xen_drm_front_gem.c
@@ -224,8 +224,7 @@ struct drm_gem_object *
 static int gem_mmap_obj(struct xen_gem_object *xen_obj,
 			struct vm_area_struct *vma)
 {
-	unsigned long addr = vma->vm_start;
-	int i;
+	int ret;
 
 	/*
 	 * clear the VM_PFNMAP flag that was set by drm_gem_mmap(), and set the
@@ -246,18 +245,11 @@ static int gem_mmap_obj(struct xen_gem_object *xen_obj,
 	 * FIXME: as we insert all the pages now then no .fault handler must
 	 * be called, so don't provide one
 	 */
-	for (i = 0; i < xen_obj->num_pages; i++) {
-		int ret;
-
-		ret = vm_insert_page(vma, addr, xen_obj->pages[i]);
-		if (ret < 0) {
-			DRM_ERROR("Failed to insert pages into vma: %d\n", ret);
-			return ret;
-		}
+	ret = vm_map_pages(vma, xen_obj->pages, xen_obj->num_pages);
+	if (ret < 0)
+		DRM_ERROR("Failed to map pages into vma: %d\n", ret);
 
-		addr += PAGE_SIZE;
-	}
-	return 0;
+	return ret;
 }
 
 int xen_drm_front_gem_mmap(struct file *filp, struct vm_area_struct *vma)
-- 
1.9.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
