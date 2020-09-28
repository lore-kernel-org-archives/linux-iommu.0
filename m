Return-Path: <SRS0=rmn6=DF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCDFC47427
	for <iommu@archiver.kernel.org>; Mon, 28 Sep 2020 21:37:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C21F5208FE
	for <iommu@archiver.kernel.org>; Mon, 28 Sep 2020 21:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEPobjZ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C21F5208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A91218707A;
	Mon, 28 Sep 2020 21:37:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ksTd4gcecXjP; Mon, 28 Sep 2020 21:37:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D616D87093;
	Mon, 28 Sep 2020 21:37:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B44F1C0891;
	Mon, 28 Sep 2020 21:37:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D9B66C0051
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 21:37:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 9C3392052E
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 21:37:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J9Gv5iCA9MAa for <iommu@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 21:36:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com
 [209.85.216.66])
 by silver.osuosl.org (Postfix) with ESMTPS id 9B3F520770
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 21:36:59 +0000 (UTC)
Received: by mail-pj1-f66.google.com with SMTP id s14so2781736pju.1
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 14:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=6l6hKSmY3TpoEATBMM/LapAftYRk779XqE24cBia0y0=;
 b=bEPobjZ4DsVmnkD/yvBrB3YsKi8EBvuTvq5iOsiKzT502lySqurkXuu25fn5VcyGoz
 Ifd2WQbnnkC6Zu+FBJkqjbAPbbsuJ8fFUFa+IoiBMivvM5SbKWIf0Y4r1tlc/MT8KrGy
 K3VwL+G5aVYucyJbpQ9UcAf6d7nKYtCu8b4Fkrlal09swQj+YAAnM2Hp3JrtjO+Mv9/e
 BSUxIReu8bTwYpv2lKARoRSspBAH/IblZTnEqIfiltFh6Zfx/keqXjylwcZDeCY67Hdb
 PnvLFALyI5IfVhjtKt/14jApbcMV45GOyPu6CfV+AY3MHFgaZDonKokrWJueqN5J+i/y
 sQIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=6l6hKSmY3TpoEATBMM/LapAftYRk779XqE24cBia0y0=;
 b=fBsQ4xQaslX4XNa6HWJod4RSjtOiwJvd1iyEudYcnKxzeg1JcGX5K9kIGpXbL6UUNA
 J/8CWs2JxXDyrVHY8UaZZV4HzVOFXEMEvaQqPvBqdy6tzfbqlFqKP64s87NKbDsdXbgX
 SGfYOx66fblOsdFr4VGUr2MLE05h4aZ0NjVMliKBRo1nQqDN2iZsuW7mnLB96UNBLL0y
 jj3HaQCgjFnTMufZAjvGRXfRwwawufhgLNmxI4aWwdpyYeiSzJIvlkL3LtGzLTK8XbOa
 BPWt1ajO6T3iqOo3zIYCTyx1ICFPnt4KKeTLoKn3A4PTM2R3P0/2OwY1hq4BDNzBeD3N
 2Brg==
X-Gm-Message-State: AOAM530n2OGoa/Marjq8epKoT+w1O7f9V3NGEzZAtRcxst9N7OcTvj3h
 ThOeNLPE6iNyaOyHew6kjkRiZzWCbzI=
X-Google-Smtp-Source: ABdhPJz92L8+8E+kFywU9N5aOFhYEwv4F+POgIOP/ZuQa6bkCsajxBmrEBosufsPcnIY0lR4NLycpA==
X-Received: by 2002:a17:90a:ed88:: with SMTP id
 k8mr1008318pjy.232.1601329019072; 
 Mon, 28 Sep 2020 14:36:59 -0700 (PDT)
Received: from jacob-builder.jf.intel.com (jfdmzpr04-ext.jf.intel.com.
 [134.134.137.73])
 by smtp.gmail.com with ESMTPSA id l11sm2220864pjf.17.2020.09.28.14.36.58
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Sep 2020 14:36:58 -0700 (PDT)
From: Jacob Pan <jacob.pan.linux@gmail.com>
X-Google-Original-From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Lu Baolu" <baolu.lu@linux.intel.com>,
 David Woodhouse <dwmw2@infradead.org>, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v3 14/14] iommu/vt-d: Store guest PASID during bind
Date: Mon, 28 Sep 2020 14:38:41 -0700
Message-Id: <1601329121-36979-15-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601329121-36979-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1601329121-36979-1-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Raj Ashok <ashok.raj@intel.com>, linux-api@vger.kernel.org,
 Randy Dunlap <rdunlap@infradead.org>, Yi Sun <yi.y.sun@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>, Wu Hao <hao.wu@intel.com>
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

IOASID core maintains the guest-host mapping in the form of SPID and
IOASID. This patch assigns the guest PASID (if valid) as SPID while
binding guest page table with a host PASID. This mapping will be used
for lookup and notifications.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 8f886718df83..e18f8b5af9ba 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -98,6 +98,7 @@ static inline bool intel_svm_capable(struct intel_iommu *iommu)
 static inline void intel_svm_drop_pasid(ioasid_t pasid)
 {
 	ioasid_detach_data(pasid);
+	ioasid_detach_spid(pasid);
 	ioasid_put(NULL, pasid);
 }
 
@@ -425,6 +426,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 		if (data->flags & IOMMU_SVA_GPASID_VAL) {
 			svm->gpasid = data->gpasid;
 			svm->flags |= SVM_FLAG_GUEST_PASID;
+			ioasid_attach_spid(data->hpasid, data->gpasid);
 		}
 		ioasid_attach_data(data->hpasid, svm);
 		ioasid_get(NULL, svm->pasid);
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
