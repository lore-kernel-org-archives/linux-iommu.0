Return-Path: <SRS0=kZfo=MF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198C9C11F6C
	for <iommu@archiver.kernel.org>; Tue, 13 Jul 2021 08:47:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BADEF613AB
	for <iommu@archiver.kernel.org>; Tue, 13 Jul 2021 08:47:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BADEF613AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 914D06088D;
	Tue, 13 Jul 2021 08:47:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id naFFiaetqHP6; Tue, 13 Jul 2021 08:47:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 83C126086C;
	Tue, 13 Jul 2021 08:47:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6352FC0022;
	Tue, 13 Jul 2021 08:47:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23B13C000E
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 08:47:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3695481BC2
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 08:47:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hgj_r4NyGUaM for <iommu@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 08:47:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AAF7882B1B
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 08:47:45 +0000 (UTC)
Received: by mail-pg1-x531.google.com with SMTP id u14so20984423pga.11
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 01:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=duCG4IP24crSQcX/Hc+dmtkejh6EvJA1HRc0A4ISBjM=;
 b=jhEklg55ncTgryEBNVp2R8QmbT0mSSZ9Jbx/vRWE7VCj3bWE2z2dIOjal3v7V87F+w
 KXfQDIBXqy11zkoXvndvUbGlVPDEiXSl+fAQR2u1kh3sE66g/ycHI3ytjUjkQxSBJH/g
 AZxHQhTacxVYFFdIyyjgze0ilCXCS/jDuumV2MlbMyoRI0UfccSBvPIQYWOGLs4/8MSa
 /LKjYT2XeUKg2HCwHW37u9JbUA9UywMRQY5Oh21L5F5yKxW5N31AISgPj+ldmzvcwtCe
 E1Q/Vl13UyWPfsgrfUc5jX89w8ETwn8bjbTAF+M6GLaU7IxUmlm0UT8g4Vzjxqr6Yp/e
 wF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=duCG4IP24crSQcX/Hc+dmtkejh6EvJA1HRc0A4ISBjM=;
 b=Ue1iXBRetmMSuH7/dW/b+C63kSI/koMMr2tvocdkmbH651wL264a3POyNZMYr3XmZT
 FWwso4ViBFc7VuMjMBtKT8T+7zNAPb/F1bMDGwmYPxTuuqGYIHI7RYRwB43pbUraJn4n
 yn84cJyaG4MxDL7nda2C6+/yVK40FSlppgUA41HTfjFCkr29AssAJipUd2HyRU4qb0NK
 oam9VJEkC3aIhyKoHGq3vhWsOdXucXLnHSq8ZswdbmLuvoQxiz2squyVk2QsS2Gz3m4q
 bZet25pzLGSQahQCyC92HNxdqdvllSPNADh7nmurybGh0O4f/6sPxI0xQn8pGEgvHbye
 7b3g==
X-Gm-Message-State: AOAM533BQCA9o5r1KVmBGWuFQSOspLvPjd4GM1Y/ADKcutuQX0n+roBx
 XVicdkDIkaAfeYcMckh9enJb
X-Google-Smtp-Source: ABdhPJzUKtRs1AySsyiLpLF85eJbibtFpTyQ7lV4V3lGutdi9feZAXM7KOxrD2p11DbuRgxCB1AMmQ==
X-Received: by 2002:a62:ee16:0:b029:2fe:ffcf:775a with SMTP id
 e22-20020a62ee160000b02902feffcf775amr3339041pfi.59.1626166065181; 
 Tue, 13 Jul 2021 01:47:45 -0700 (PDT)
Received: from localhost ([139.177.225.253])
 by smtp.gmail.com with ESMTPSA id b22sm17658102pfi.181.2021.07.13.01.47.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jul 2021 01:47:44 -0700 (PDT)
From: Xie Yongji <xieyongji@bytedance.com>
To: mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
 sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
 christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com, joro@8bytes.org, gregkh@linuxfoundation.org,
 zhe.he@windriver.com, xiaodong.liu@intel.com
Subject: [PATCH v9 06/17] vhost-vdpa: Handle the failure of vdpa_reset()
Date: Tue, 13 Jul 2021 16:46:45 +0800
Message-Id: <20210713084656.232-7-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210713084656.232-1-xieyongji@bytedance.com>
References: <20210713084656.232-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 songmuchun@bytedance.com, linux-fsdevel@vger.kernel.org
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

The vdpa_reset() may fail now. This adds check to its return
value and fail the vhost_vdpa_open().

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/vhost/vdpa.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 62b6d911c57d..8615756306ec 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -116,12 +116,13 @@ static void vhost_vdpa_unsetup_vq_irq(struct vhost_vdpa *v, u16 qid)
 	irq_bypass_unregister_producer(&vq->call_ctx.producer);
 }
 
-static void vhost_vdpa_reset(struct vhost_vdpa *v)
+static int vhost_vdpa_reset(struct vhost_vdpa *v)
 {
 	struct vdpa_device *vdpa = v->vdpa;
 
-	vdpa_reset(vdpa);
 	v->in_batch = 0;
+
+	return vdpa_reset(vdpa);
 }
 
 static long vhost_vdpa_get_device_id(struct vhost_vdpa *v, u8 __user *argp)
@@ -871,7 +872,9 @@ static int vhost_vdpa_open(struct inode *inode, struct file *filep)
 		return -EBUSY;
 
 	nvqs = v->nvqs;
-	vhost_vdpa_reset(v);
+	r = vhost_vdpa_reset(v);
+	if (r)
+		goto err;
 
 	vqs = kmalloc_array(nvqs, sizeof(*vqs), GFP_KERNEL);
 	if (!vqs) {
-- 
2.11.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
