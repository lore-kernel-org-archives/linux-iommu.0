Return-Path: <SRS0=KEvp=CA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69B8C433DF
	for <iommu@archiver.kernel.org>; Sat, 22 Aug 2020 07:09:40 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8880D20724
	for <iommu@archiver.kernel.org>; Sat, 22 Aug 2020 07:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6gYU3BQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8880D20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 798C08849F;
	Sat, 22 Aug 2020 07:09:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ngoO4qvQBc76; Sat, 22 Aug 2020 07:09:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0EB61878DB;
	Sat, 22 Aug 2020 07:09:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F084CC089E;
	Sat, 22 Aug 2020 07:09:34 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 96787C0051
 for <iommu@lists.linux-foundation.org>; Sat, 22 Aug 2020 04:28:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 7D7CB23265
 for <iommu@lists.linux-foundation.org>; Sat, 22 Aug 2020 04:28:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q2i-vfyKoMy9 for <iommu@lists.linux-foundation.org>;
 Sat, 22 Aug 2020 04:28:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
 [209.85.215.195])
 by silver.osuosl.org (Postfix) with ESMTPS id 9E15B204ED
 for <iommu@lists.linux-foundation.org>; Sat, 22 Aug 2020 04:28:34 +0000 (UTC)
Received: by mail-pg1-f195.google.com with SMTP id x6so1928326pgx.12
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 21:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=uqBr/lnoyyjrVPbppt18J/CaYj+H3LTptFWomD24EK8=;
 b=k6gYU3BQoMFCaQD+AlH0UdJa7EouME7f09Wr67RQ0UgSnQtksUl9M/XY9lpiDXJEDE
 eqsBxJ21y3hKfagcR87kOSVqxwdBQ6XMKzHOzWNykOAhqOlwThPzkYmJWKfC0xP0o2p7
 r3NbPu7gJKcMUICczwCpP02cNZxiMgTSg/TC5RK3W4eaALSDJi0Zwo3xeIvjxJDnL2lp
 PHada2DmX90mA9176PXGI//LblawMwTjFkvN/t5kWwrBHZ4ZZtQDX6caj/1/3B5dJnpB
 wZf7vueze3b+pmTZbvhWexQxEBZSO6C44UZSgMGZETqAVZ8YKNkd4hNY8J/ogHLEqJ5i
 G5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=uqBr/lnoyyjrVPbppt18J/CaYj+H3LTptFWomD24EK8=;
 b=XD/TN5ayW1zpYHgDrlGCPEhDs7X6UL7jb3SAFOo3pycbcSDaskQms3tGMqJXKoEd7X
 bArGovYEh3sQkBk6+e0YpMyxy4ohteK5gwzy3DvwNEudJE3mlS3a8m4twPOzEfEaLlQH
 vxVC+DyLiLfs12APv974faTGEaf06JL/ymReI6W7iV8RI0PpwL6RyTArtlKhYVC7fwCi
 A74OaSmt4TLR7Bk3WfdEuKPz9yao4iRGfCn55t9JAaKrOsYIxXDb/I2Z5AaLJDZnGlHZ
 Z4RjelYEO6gYbi6zCyDbkrV+z8FtrPF7eRdXvZyyPTqgGJbBlwpaLPwVo4ic91eVkspq
 1ppg==
X-Gm-Message-State: AOAM5304R9gwr9cVrzaqj/vcO/sal0KFdGVk8s1hZ4MNeL3GDFgdct6W
 OX6TVlWdcNzFjFRwufsDPwb6QtzC9elmH4/B
X-Google-Smtp-Source: ABdhPJw+Y9gmCJ//53qiUrfo5XJC0rxQJ+ex61YOdl0PD+gHIbZUDNi4Sx226cKTe4jeWjVgPh0TRg==
X-Received: by 2002:aa7:9ac2:: with SMTP id x2mr4896468pfp.57.1598070513961;
 Fri, 21 Aug 2020 21:28:33 -0700 (PDT)
Received: from jacob-builder.jf.intel.com ([192.55.55.43])
 by smtp.gmail.com with ESMTPSA id q5sm3341582pgi.31.2020.08.21.21.28.32
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Aug 2020 21:28:33 -0700 (PDT)
From: Jacob Pan <jacob.pan.linux@gmail.com>
X-Google-Original-From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "Lu Baolu" <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH v2 8/9] iommu/vt-d: Send IOASID bind/unbind notifications
Date: Fri, 21 Aug 2020 21:35:17 -0700
Message-Id: <1598070918-21321-9-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598070918-21321-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1598070918-21321-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailman-Approved-At: Sat, 22 Aug 2020 07:09:31 +0000
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Wu Hao <hao.wu@intel.com>
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

On Intel Scalable I/O Virtualization (SIOV) enabled platforms with
ENQCMD in use by the guest, KVM must establish a guest-host PASID
translation table prior to the issuing of ENQCMD. PASID translation
table also depends on the IOMMU PASID entry, which is configured during
the guest page table bind time. This patch adds a notification event to
the IOMMU driver such that KVM can be notified when a new guest-host
PASID mapping is established or demolished.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 600e3ae5b656..d8a5efa75095 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -471,6 +471,11 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 	}
 
 	mutex_unlock(&pasid_mutex);
+	/*
+	 * Notify KVM new host-guest PASID bind is ready. KVM will set up
+	 * PASID translation table to support guest ENQCMD.
+	 */
+	ioasid_notify(data->hpasid, IOASID_BIND, IOASID_NOTIFY_SET);
 	return ret;
 }
 
@@ -510,6 +515,8 @@ int intel_svm_unbind_gpasid(struct device *dev, int pasid)
 				 * and perform cleanup.
 				 */
 				ioasid_attach_data(pasid, NULL);
+				ioasid_notify(pasid, IOASID_UNBIND,
+					IOASID_NOTIFY_SET);
 				kfree(svm);
 			}
 		}
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
