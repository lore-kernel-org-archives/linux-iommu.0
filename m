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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A0AC4727C
	for <iommu@archiver.kernel.org>; Mon, 28 Sep 2020 21:37:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDF7721D46
	for <iommu@archiver.kernel.org>; Mon, 28 Sep 2020 21:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tTP4J0Ia"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDF7721D46
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 886DB86CAC;
	Mon, 28 Sep 2020 21:37:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pPFqfRkwVxoQ; Mon, 28 Sep 2020 21:37:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9F1488707A;
	Mon, 28 Sep 2020 21:37:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 858DAC1AD6;
	Mon, 28 Sep 2020 21:37:05 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 85852C0051
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 21:36:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6354785817
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 21:36:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IbhWHTjqjNoS for <iommu@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 21:36:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com
 [209.85.216.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id BE28684DE6
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 21:36:58 +0000 (UTC)
Received: by mail-pj1-f67.google.com with SMTP id s14so2781705pju.1
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 14:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Gd3yej60dudO/8DXRzuDh/k17amPnxhlwfOMJTioVQM=;
 b=tTP4J0IaMk227Z8asAN85KOSM1A9No6RY5e4LLFeNceqe/24u2KHAriyTcErBdU/B1
 31JrR3t6e3CMvNPvKtmHYn5xeL0W5vprCR+nt/PqLPtlde7HhW2YJ7Ifw4hkewplV1En
 3f1l3EKdbTyvD2l6+wVWCFO6ca8AHad7f2TtYBshmeXQPwFA+jlBxzx9StY2//cJs4fP
 nux79mYcFISBDkY6rB1Z21u41p7ZwLBrP/+/hv826s2RTf3iBTCgiynbv311mURUl3pe
 CcxIbqqZgFAB8feDEaYIjQw7quZqOmnwjXIxwKKC8e9R7eRCr5Zz+sn+EXAOw41VaWRb
 NQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Gd3yej60dudO/8DXRzuDh/k17amPnxhlwfOMJTioVQM=;
 b=eMoF/w1fPqUXJ7V4+hOl1KgHJRx8AsLBnZWv/oP8rvp86ZkJnaXBvtyUqc5t5LHL6c
 PjvGw39ktJlBDbL9I3i+CpdxJwuQHlsUPg2qCFESz+tz1AdG7SZT15xmK620CM315L65
 NmDyV5nWQnnvUNcgCZsBhCxd5xiGN8MvxSKR4/bjQwu7BbW+r9rO5LrokPx6C0XwY6b3
 rI4oYvgvrVr4L230MPhEoMudiCx2hQZz+ydLp+WBLsbw89prE1iGXAREwSOEjUvurxVP
 lPFRbGd8LcHqJ3SdNNsnZkMBE+p/XjZ9JLyOWmtJRHJAT9rRV0DPJqDga8C6ccQkR3z9
 kvdA==
X-Gm-Message-State: AOAM531iqcYWwwoSqpWzmgPteytxNqsm1AzGn0kd/K90P4uuXGZThEch
 0lYf63VVoBwXP13X6Ioa/LQCwKTnU58=
X-Google-Smtp-Source: ABdhPJx9iz0liS3WtMH3HKPteQJgZuhpU2LsqxwnYQPtfa8tQQAV9sXRarVwRsALY0g9GPPWrLoaKQ==
X-Received: by 2002:a17:90b:889:: with SMTP id
 bj9mr1004758pjb.73.1601329018191; 
 Mon, 28 Sep 2020 14:36:58 -0700 (PDT)
Received: from jacob-builder.jf.intel.com (jfdmzpr04-ext.jf.intel.com.
 [134.134.137.73])
 by smtp.gmail.com with ESMTPSA id l11sm2220864pjf.17.2020.09.28.14.36.57
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Sep 2020 14:36:57 -0700 (PDT)
From: Jacob Pan <jacob.pan.linux@gmail.com>
X-Google-Original-From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Lu Baolu" <baolu.lu@linux.intel.com>,
 David Woodhouse <dwmw2@infradead.org>, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v3 13/14] iommu/vt-d: Listen to IOASID notifications
Date: Mon, 28 Sep 2020 14:38:40 -0700
Message-Id: <1601329121-36979-14-git-send-email-jacob.jun.pan@linux.intel.com>
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

On Intel Scalable I/O Virtualization (SIOV) enabled platforms, IOMMU
driver is one of the users of IOASIDs. In normal flow, callers will
perform IOASID allocation, bind, unbind, and free in order. However, for
guest SVA, IOASID free could come before unbind as guest is untrusted.
This patch registers IOASID notification handler such that IOMMU driver
can perform PASID teardown upon receiving an unexpected IOASID free
event.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/svm.c   | 94 ++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/intel-iommu.h |  2 +
 2 files changed, 94 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 39a09a93300e..8f886718df83 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -95,6 +95,90 @@ static inline bool intel_svm_capable(struct intel_iommu *iommu)
 	return iommu->flags & VTD_FLAG_SVM_CAPABLE;
 }
 
+static inline void intel_svm_drop_pasid(ioasid_t pasid)
+{
+	ioasid_detach_data(pasid);
+	ioasid_put(NULL, pasid);
+}
+
+static DEFINE_MUTEX(pasid_mutex);
+#define pasid_lock_held() lock_is_held(&pasid_mutex.dep_map)
+
+static void intel_svm_free_async_fn(struct work_struct *work)
+{
+	struct intel_svm *svm = container_of(work, struct intel_svm, work);
+	struct intel_svm_dev *sdev;
+
+	/*
+	 * Unbind all devices associated with this PASID which is
+	 * being freed by other users such as VFIO.
+	 */
+	mutex_lock(&pasid_mutex);
+	list_for_each_entry_rcu(sdev, &svm->devs, list, pasid_lock_held()) {
+		/* Does not poison forward pointer */
+		list_del_rcu(&sdev->list);
+		spin_lock(&svm->iommu->lock);
+		intel_pasid_tear_down_entry(svm->iommu, sdev->dev,
+					svm->pasid, true);
+		spin_unlock(&svm->iommu->lock);
+		kfree_rcu(sdev, rcu);
+	}
+	/*
+	 * We may not be the last user to drop the reference but since
+	 * the PASID is in FREE_PENDING state, no one can get new reference.
+	 * Therefore, we can safely free the private data svm.
+	 */
+	intel_svm_drop_pasid(svm->pasid);
+	/*
+	 * Free before unbind can only happen with host PASIDs used for
+	 * guest SVM. We get here because ioasid_free is called with
+	 * outstanding references. So we need to drop the reference
+	 * such that the PASID can be reclaimed. unbind_gpasid() after this
+	 * will not result in dropping refcount since the private data is
+	 * already detached.
+	 */
+	kfree(svm);
+
+	mutex_unlock(&pasid_mutex);
+}
+
+
+static int pasid_status_change(struct notifier_block *nb,
+				unsigned long code, void *data)
+{
+	struct ioasid_nb_args *args = (struct ioasid_nb_args *)data;
+	struct intel_svm *svm = (struct intel_svm *)args->pdata;
+	int ret = NOTIFY_DONE;
+
+	if (code == IOASID_NOTIFY_FREE) {
+		/*
+		 * If PASID UNBIND happens before FREE, private data of the
+		 * IOASID should be NULL, then we don't need to do anything.
+		 */
+		if (!svm)
+			goto done;
+		if (args->id != svm->pasid) {
+			pr_warn("Notify PASID does not match data %d : %d\n",
+				args->id, svm->pasid);
+			goto done;
+		}
+		schedule_work(&svm->work);
+		return NOTIFY_OK;
+	}
+done:
+	return ret;
+}
+
+static struct notifier_block pasid_nb = {
+	.notifier_call = pasid_status_change,
+};
+
+void intel_svm_add_pasid_notifier(void)
+{
+	/* Listen to all PASIDs, not specific to a set */
+	ioasid_register_notifier(NULL, &pasid_nb);
+}
+
 void intel_svm_check(struct intel_iommu *iommu)
 {
 	if (!pasid_supported(iommu))
@@ -221,7 +305,6 @@ static const struct mmu_notifier_ops intel_mmuops = {
 	.invalidate_range = intel_invalidate_range,
 };
 
-static DEFINE_MUTEX(pasid_mutex);
 static LIST_HEAD(global_svm_list);
 
 #define for_each_svm_dev(sdev, svm, d)			\
@@ -344,6 +427,13 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 			svm->flags |= SVM_FLAG_GUEST_PASID;
 		}
 		ioasid_attach_data(data->hpasid, svm);
+		ioasid_get(NULL, svm->pasid);
+		svm->iommu = iommu;
+		/*
+		 * Set up cleanup async work in case IOASID core notify us PASID
+		 * is freed before unbind.
+		 */
+		INIT_WORK(&svm->work, intel_svm_free_async_fn);
 		INIT_LIST_HEAD_RCU(&svm->devs);
 	}
 	sdev = kzalloc(sizeof(*sdev), GFP_KERNEL);
@@ -437,7 +527,7 @@ int intel_svm_unbind_gpasid(struct device *dev, int pasid)
 				 * the unbind, IOMMU driver will get notified
 				 * and perform cleanup.
 				 */
-				ioasid_detach_data(pasid);
+				intel_svm_drop_pasid(pasid);
 				kfree(svm);
 			}
 		}
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index b1ed2f25f7c0..d36038e6ae0b 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -744,6 +744,7 @@ void intel_svm_unbind(struct iommu_sva *handle);
 int intel_svm_get_pasid(struct iommu_sva *handle);
 int intel_svm_page_response(struct device *dev, struct iommu_fault_event *evt,
 			    struct iommu_page_response *msg);
+void intel_svm_add_pasid_notifier(void);
 
 struct svm_dev_ops;
 
@@ -770,6 +771,7 @@ struct intel_svm {
 	int gpasid; /* In case that guest PASID is different from host PASID */
 	struct list_head devs;
 	struct list_head list;
+	struct work_struct work; /* For deferred clean up */
 };
 #else
 static inline void intel_svm_check(struct intel_iommu *iommu) {}
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
