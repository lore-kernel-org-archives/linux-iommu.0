Return-Path: <SRS0=Mf8z=KM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B69C43470
	for <iommu@archiver.kernel.org>; Mon, 17 May 2021 10:02:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45AC361029
	for <iommu@archiver.kernel.org>; Mon, 17 May 2021 10:02:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45AC361029
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D45CF608C1;
	Mon, 17 May 2021 10:02:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ouv3rusoSrYO; Mon, 17 May 2021 10:02:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0B72F608DC;
	Mon, 17 May 2021 10:01:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A02C5C0028;
	Mon, 17 May 2021 10:01:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 09B68C0001
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 09:56:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 067994019A
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 09:56:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UPwUuQxFjruA for <iommu@lists.linux-foundation.org>;
 Mon, 17 May 2021 09:56:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7C02F400F4
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 09:56:16 +0000 (UTC)
Received: by mail-pl1-x633.google.com with SMTP id p6so2827901plr.11
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 02:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=z7/sgPn1niIyplx/MCCBp/NxUC1m49ShQY4FddeicFg=;
 b=VtwX03C0ISBBYjMp9XrXXlg71h/dLD+Iw0BunstvVMTQaRODx4ebdUoHqalwuhZLrr
 c6dwQDJogEeD8IEYI5BVoSc848OKx+OElBQio9tTZdwuqKQ0c7pwHtONHQSD07vEDGtY
 HN+viIpqfyoeqR4A27UylxzodLAKfRlI/f+XLIm363PsM6oqelH6yU9zb92L1sJwUSq7
 abxZhuME3e0rEDw0VLQtTiSVtO+eqRv2k1gs0aSRfId3eS75sHzQWNeLdSh2x86GyLUO
 mNu7bb5U26Dzx7s112VDNFcaoK/enWL+0vWA8YXtLtU2B5IfIOdx+soCEqxWkBtw/wkI
 SfFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=z7/sgPn1niIyplx/MCCBp/NxUC1m49ShQY4FddeicFg=;
 b=HyH+iWsYhP3arz9x8+VV5l8q/OaG26TIjhaSzmrxibflXWbxoZbRbUI+XyYrZNbn+g
 QaHvO5dnnMhKkBHYK7xs0Th5/5iOrP9LpEfN2e9GVI05W4jEQChaDaunNarQPcOwMDcf
 ljjsePwyCvjY3ppvwarrhSuFtBy0ngkYkr5EMSt1K/xi8WbI5ehfhqKcrNPqMMwB/+1f
 3YLOUFJYvKFGT19huzjYbxaGC3n6tI2vNy/CViW0buz4ThJYT8AJXooMN+0YZ2we/t7O
 odXYjamSPBLBGU0mzdNQpXJvah8wPVUhXzunYxGSklISiTpoHuL6H6srMEkOHjmQ5uji
 lVPw==
X-Gm-Message-State: AOAM530VxlPwQ2SOW7poa4HWP6uztlZr00cMuvHMW+z7ES1vKuV0XwRG
 Bp20aKs82DoP4GJI3wK/E6dn
X-Google-Smtp-Source: ABdhPJxaWd2Kn5/peSswOCwRKMHxtXfg5xbq6uIlNzE6im+gipuz3QFRX9Bwo9Y9e12+QeRiGNwVIQ==
X-Received: by 2002:a17:90b:1992:: with SMTP id
 mv18mr9044020pjb.137.1621245376019; 
 Mon, 17 May 2021 02:56:16 -0700 (PDT)
Received: from localhost ([139.177.225.253])
 by smtp.gmail.com with ESMTPSA id s184sm10234381pgc.29.2021.05.17.02.56.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 May 2021 02:56:15 -0700 (PDT)
From: Xie Yongji <xieyongji@bytedance.com>
To: mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
 sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
 christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com, joro@8bytes.org
Subject: [PATCH v7 05/12] virtio_scsi: Add validation for residual bytes from
 response
Date: Mon, 17 May 2021 17:55:06 +0800
Message-Id: <20210517095513.850-6-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517095513.850-1-xieyongji@bytedance.com>
References: <20210517095513.850-1-xieyongji@bytedance.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 17 May 2021 10:01:55 +0000
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 linux-fsdevel@vger.kernel.org
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

This ensures that the residual bytes in response (might come
from an untrusted device) will not exceed the data buffer length.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/scsi/virtio_scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index efcaf0674c8d..ad7d8cecec32 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -97,7 +97,7 @@ static inline struct Scsi_Host *virtio_scsi_host(struct virtio_device *vdev)
 static void virtscsi_compute_resid(struct scsi_cmnd *sc, u32 resid)
 {
 	if (resid)
-		scsi_set_resid(sc, resid);
+		scsi_set_resid(sc, min(resid, scsi_bufflen(sc)));
 }
 
 /*
-- 
2.11.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
