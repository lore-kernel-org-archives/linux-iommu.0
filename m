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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73560C433E3
	for <iommu@archiver.kernel.org>; Sat, 22 Aug 2020 07:09:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4259320FC3
	for <iommu@archiver.kernel.org>; Sat, 22 Aug 2020 07:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R53OrZZW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4259320FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 29F8A87FCD;
	Sat, 22 Aug 2020 07:09:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IgorUkwRXtb1; Sat, 22 Aug 2020 07:09:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 48FB688091;
	Sat, 22 Aug 2020 07:09:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C447C088B;
	Sat, 22 Aug 2020 07:09:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 850FEC0051
 for <iommu@lists.linux-foundation.org>; Sat, 22 Aug 2020 04:28:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 74D47887E2
 for <iommu@lists.linux-foundation.org>; Sat, 22 Aug 2020 04:28:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Imbx6p2uNv2G for <iommu@lists.linux-foundation.org>;
 Sat, 22 Aug 2020 04:28:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
 [209.85.214.196])
 by hemlock.osuosl.org (Postfix) with ESMTPS id EFFB9887EF
 for <iommu@lists.linux-foundation.org>; Sat, 22 Aug 2020 04:28:35 +0000 (UTC)
Received: by mail-pl1-f196.google.com with SMTP id z23so1785934plo.8
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 21:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=dtHtIWl6J8kIFWKXyZWws3NaZY5n+Lcb3UuZs+GuLv4=;
 b=R53OrZZWGDIlIq1se/YzOjwMVMXn4r1O33D1gHWELFMDJddknNzoTdyoDOZjJxRSC+
 0BA8PkFUN5wcjq4ZPW5+yV9S8gKYo17gG6reRRjvQ+HdSiL+Fe/hRBEMvq+AYQqzch91
 RABhbEfIDTyk7Bl0wqiPe1T1elJOPCYEyrq8dIhksxYbFMj54FFIFs1+/EfoUXZ3LfQ3
 birdcw54W2pRGqRm7F5VKjAfUxvS58PKB7NuWisieG/zBgiqlFHOri9AMan2sSUFs0oL
 Pq/VUxGQxAWQxKtVlHaFrONvuBcCPxZ/3pkXFse6GnPCcTuwJLVop4SWI1qibS4eth2B
 eXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=dtHtIWl6J8kIFWKXyZWws3NaZY5n+Lcb3UuZs+GuLv4=;
 b=KnqWZq/sM4HPGeW5/7DADzhenPqj/HN/qmHbay37k+7HnXhEKvRm/gHtdxAh4QQ8oB
 JEFX4QXqeEr7Kfvb98kilN27tiK4kkW8We51O1/qJTaQiqRqBK9GtNFmT42k7VwG/P/j
 1x+3r5HfSZf+oH1VGxEgZmW0qUe6Sh1ZPxE0F1s9FBm2xjbWbVMIbNn/i/krWOzK6QVx
 N73SRhTa5gUysF6ZIO2IhBsSG0N/IuqesafjYSElrTzgiiv+P+SNx3rfZqKluC83gKVn
 2uJFBJURmphsrp3MSADcFUlAgmqyU/HQtz9PAWiIfdh5ngmd4qeVSwdVq8DxLGjvMIBo
 Nddg==
X-Gm-Message-State: AOAM532F5Sl+dj2Kge9gshRpt1yFid8OyBYIysErN2cyyOogk06m57F6
 u4kIkVbcIfhn5eqvdpbWeCNUSkae/wNXj9Kv
X-Google-Smtp-Source: ABdhPJw20iJdex84y+BAqAEu6iBpS8k4sg6GOf+cwWHA6VnqRrDPHBAvJkMquof+YQNxHnXJtXlhmA==
X-Received: by 2002:a17:90b:4397:: with SMTP id
 in23mr4651060pjb.102.1598070515318; 
 Fri, 21 Aug 2020 21:28:35 -0700 (PDT)
Received: from jacob-builder.jf.intel.com ([192.55.55.43])
 by smtp.gmail.com with ESMTPSA id q5sm3341582pgi.31.2020.08.21.21.28.34
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Aug 2020 21:28:34 -0700 (PDT)
From: Jacob Pan <jacob.pan.linux@gmail.com>
X-Google-Original-From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "Lu Baolu" <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH v2 9/9] iommu/vt-d: Store guest PASID during bind
Date: Fri, 21 Aug 2020 21:35:18 -0700
Message-Id: <1598070918-21321-10-git-send-email-jacob.jun.pan@linux.intel.com>
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

IOASID core maintains the guest-host mapping in the form of SPID and
IOASID. This patch assigns the guest PASID (if valid) as SPID while
binding guest page table with a host PASID. This mapping will be used
for lookup and notifications.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index d8a5efa75095..4c958b1aec4c 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -406,6 +406,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 		if (data->flags & IOMMU_SVA_GPASID_VAL) {
 			svm->gpasid = data->gpasid;
 			svm->flags |= SVM_FLAG_GUEST_PASID;
+			ioasid_attach_spid(data->hpasid, data->gpasid);
 		}
 		svm->iommu = iommu;
 		/*
@@ -517,6 +518,7 @@ int intel_svm_unbind_gpasid(struct device *dev, int pasid)
 				ioasid_attach_data(pasid, NULL);
 				ioasid_notify(pasid, IOASID_UNBIND,
 					IOASID_NOTIFY_SET);
+				ioasid_attach_spid(pasid, INVALID_IOASID);
 				kfree(svm);
 			}
 		}
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
