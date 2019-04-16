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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C77C282DA
	for <iommu@archiver.kernel.org>; Tue, 16 Apr 2019 11:48:04 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4448E20880
	for <iommu@archiver.kernel.org>; Tue, 16 Apr 2019 11:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlNJmhvP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4448E20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2A7A7FF1;
	Tue, 16 Apr 2019 11:48:04 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E7043FEA
	for <iommu@lists.linux-foundation.org>;
	Tue, 16 Apr 2019 11:48:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
	[209.85.210.196])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A05661C0
	for <iommu@lists.linux-foundation.org>;
	Tue, 16 Apr 2019 11:48:02 +0000 (UTC)
Received: by mail-pf1-f196.google.com with SMTP id 8so10296850pfr.4
	for <iommu@lists.linux-foundation.org>;
	Tue, 16 Apr 2019 04:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=F9hIq6OqtC1SVS2O3U7ZkPoLnNclA70DsapCWy7Q+lE=;
	b=RlNJmhvPVJ3UxKO1l98lIMDXQUnrSkDMLarOhFladUUf3Fd2LaDOG6+U01Z2z+YiG6
	sNYefT86LOIxnqlnmYbZyAcDruQYSCoLZfKjsI5qTBm4ikzvhilXTlPgz8vD0vD1p4zp
	nUgSswnCr91BRUTNAb6b5zyVdAQ+av7Sc02gJFy++x4EdGU7Ba+eVKI/tSv7RiqlDMKy
	SLqyqJH65OUoe0UtHrsN3h68RjIqxVfa3ycMpFEZs+Uo8eJrS3RcKM40edoCs9WmwoYn
	teADUMkiqANnatUpNqvAlG9eQwygGnntxE0k2iDAigCWgYcsyUHjVSZh8cAxSeXbIBT7
	1ERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=F9hIq6OqtC1SVS2O3U7ZkPoLnNclA70DsapCWy7Q+lE=;
	b=ik0CK9Fb3T9jHG8/pIg7xkWgrNmBTgpWyiPfrVhXB0zUrWlLnBKPtfxEDdNwp04FRR
	oFpQlZkNRaiYhbQqg7V13wOXeeNP3iVWbbUYS10wk76j73lD57CUqrQ2T8SwdcehXNwf
	n8bijlbihvWZlhLXLHSjfTu0KaWmcHJwlL6jhaGPB0oB1L1w4F60jwyk16GATEzaT2ju
	u7uC+OOJTASrjWg7wobWXmD3EohPy11VM4Ra3SV+fgiKwOadlJI68TuIXdKAV3sG+jjm
	n5eGLgs+MOpFVJ3AY65aa/c80qBOt2GWdyF87eg/clMJ6j+JFWWTI07Kkh5EBjRoM/rt
	pglw==
X-Gm-Message-State: APjAAAXdAHdXxxG8el/bgVvudHLN0HK7wa/+42P87/wcqXHkgSoUBnXR
	TfJ/Wfrq8rZYMX2REtbLakU=
X-Google-Smtp-Source: APXvYqx2gh4QQGIyXcsK611dByHpjpx+tKjskfqa9rV5hBQis2QAQtHs+h2xQ6nYUrNHQ3rVd4NVTA==
X-Received: by 2002:a63:f115:: with SMTP id f21mr70665089pgi.65.1555415282264; 
	Tue, 16 Apr 2019 04:48:02 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([49.207.50.11])
	by smtp.gmail.com with ESMTPSA id
	p6sm55942835pfd.122.2019.04.16.04.47.53
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 16 Apr 2019 04:48:01 -0700 (PDT)
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
Subject: [REBASE PATCH v5 9/9] xen/privcmd-buf.c: Convert to use
	vm_map_pages_zero()
Date: Tue, 16 Apr 2019 17:19:50 +0530
Message-Id: <acf678e81d554d01a9b590716ac0ccbdcdf71c25.1552921225.git.jrdr.linux@gmail.com>
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

Convert to use vm_map_pages_zero() to map range of kernel
memory to user vma.

This driver has ignored vm_pgoff. We could later "fix" these drivers
to behave according to the normal vm_pgoff offsetting simply by
removing the _zero suffix on the function name and if that causes
regressions, it gives us an easy way to revert.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
 drivers/xen/privcmd-buf.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/xen/privcmd-buf.c b/drivers/xen/privcmd-buf.c
index de01a6d..d02dc43 100644
--- a/drivers/xen/privcmd-buf.c
+++ b/drivers/xen/privcmd-buf.c
@@ -166,12 +166,8 @@ static int privcmd_buf_mmap(struct file *file, struct vm_area_struct *vma)
 	if (vma_priv->n_pages != count)
 		ret = -ENOMEM;
 	else
-		for (i = 0; i < vma_priv->n_pages; i++) {
-			ret = vm_insert_page(vma, vma->vm_start + i * PAGE_SIZE,
-					     vma_priv->pages[i]);
-			if (ret)
-				break;
-		}
+		ret = vm_map_pages_zero(vma, vma_priv->pages,
+						vma_priv->n_pages);
 
 	if (ret)
 		privcmd_buf_vmapriv_free(vma_priv);
-- 
1.9.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
