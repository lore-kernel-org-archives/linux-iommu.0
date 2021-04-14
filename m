Return-Path: <SRS0=7Zqx=JL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9597EC4161D
	for <iommu@archiver.kernel.org>; Wed, 14 Apr 2021 14:50:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54A31613CB
	for <iommu@archiver.kernel.org>; Wed, 14 Apr 2021 14:50:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54A31613CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 16115607D6;
	Wed, 14 Apr 2021 14:50:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iJ1ucNjG6qRA; Wed, 14 Apr 2021 14:50:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id CEC0D607C7;
	Wed, 14 Apr 2021 14:50:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F256BC0019;
	Wed, 14 Apr 2021 14:50:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A6362C0018
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 14:50:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 84AD96075B
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 14:50:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oBl_I0ue5ZfC for <iommu@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 14:50:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CC4E460724
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 14:50:30 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id u11so6739475pjr.0
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 07:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CewzcGN2queQHJd+J82WZLFtEsY18cNfiGHIrQj3GfM=;
 b=nOk4uGV2612icoE6KiiMnihVY5JHClv+KaiNAxHeX6msxOQj9xeFgeyXgzuV9Sd7Ij
 3EGstiuG7E5ZaMqZazQ8zFoKTzoT62iMzgmBH+tZh+iYpEEsK600XCCcKCclZh0Y0x/u
 lPI4sDQZdZAMWqD+sOUOmLSztUBF0emqbSbT/bkw4pOBBCkruQo/ok2VzdifznwsKJMs
 ocsgxtRZuZhwa/4H3uMNQQH/MJK+ZGYBL5Une8lbE2Hi2dVG9kDPFVwgbdYojKKilNwO
 hZojnsV4Uidmr/W8cT1MCoZwuTcUd6+620Huo4X0ZKIUTvMpEIF6giQ2Vs7uJP0RlbHX
 V1IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CewzcGN2queQHJd+J82WZLFtEsY18cNfiGHIrQj3GfM=;
 b=rqq5xcZdvRn36qfTXV2S2fUQkLlm7rynCtkPyfVhQ9+NqSfSDkcdR6SM3dBWF6EjfL
 kfd1pUUQTpBs3iWp2LyTknInyItREgTwMSRY1wpNZACuzPAqNrI3b9uOZ5zuDhVOG9cj
 BfMII3F1ZJsCvxiV19G+ORQt8/55QIFsKSvCersLazaPvRKIAUDtfLr6zRw3SDmSROvS
 X0JTLDrL7tpdMgPTt3y+GBVal9Q7mIi/f4SkB3eXJMPGknyQwkcDgqwckRxc7yzBgUzI
 9BiSayHRGzttczS+3LkYntu8+MFY8ea9rRc0knicci3oeXAXv6lOsWJdr4SQiaqtRORE
 NhUg==
X-Gm-Message-State: AOAM533rBhDsw8QRduM9qpsQNuEd4PnN1h81ZS20C89EDCDWaRLKHFhE
 /uxssS8r0hEtyB58fnWsBDw=
X-Google-Smtp-Source: ABdhPJwbB1PldwXbeyiSuCQkyOEtifm++hxPqnW8Qh9Ekcj5s31E29ArK58tbba9T8p/t1IP5sOX7w==
X-Received: by 2002:a17:90a:5306:: with SMTP id
 x6mr4089960pjh.39.1618411830278; 
 Wed, 14 Apr 2021 07:50:30 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:35:ebad:12c1:f579:e332])
 by smtp.gmail.com with ESMTPSA id w67sm17732522pgb.87.2021.04.14.07.50.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Apr 2021 07:50:29 -0700 (PDT)
From: Tianyu Lan <ltykernel@gmail.com>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
 wei.liu@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 x86@kernel.org, hpa@zytor.com, arnd@arndb.de, akpm@linux-foundation.org,
 gregkh@linuxfoundation.org, konrad.wilk@oracle.com, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com, joro@8bytes.org,
 will@kernel.org, davem@davemloft.net, kuba@kernel.org, jejb@linux.ibm.com,
 martin.petersen@oracle.com
Subject: [Resend RFC PATCH V2 06/12] HV/Vmbus: Add SNP support for VMbus
 channel initiate message
Date: Wed, 14 Apr 2021 10:49:39 -0400
Message-Id: <20210414144945.3460554-7-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210414144945.3460554-1-ltykernel@gmail.com>
References: <20210414144945.3460554-1-ltykernel@gmail.com>
MIME-Version: 1.0
Cc: linux-arch@vger.kernel.org, thomas.lendacky@amd.com,
 linux-hyperv@vger.kernel.org, Tianyu Lan <Tianyu.Lan@microsoft.com>,
 linux-scsi@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, brijesh.singh@amd.com, vkuznets@redhat.com,
 sunilmut@microsoft.com
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

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

The physical address of monitor pages in the CHANNELMSG_INITIATE_CONTACT
msg should be in the extra address space for SNP support and these
pages also should be accessed via the extra address space inside Linux
guest and remap the extra address by ioremap function.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 drivers/hv/connection.c   | 62 +++++++++++++++++++++++++++++++++++++++
 drivers/hv/hyperv_vmbus.h |  1 +
 2 files changed, 63 insertions(+)

diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 79bca653dce9..a0be9c11d737 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -101,6 +101,12 @@ int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 version)
 
 	msg->monitor_page1 = virt_to_phys(vmbus_connection.monitor_pages[0]);
 	msg->monitor_page2 = virt_to_phys(vmbus_connection.monitor_pages[1]);
+
+	if (hv_isolation_type_snp()) {
+		msg->monitor_page1 += ms_hyperv.shared_gpa_boundary;
+		msg->monitor_page2 += ms_hyperv.shared_gpa_boundary;
+	}
+
 	msg->target_vcpu = hv_cpu_number_to_vp_number(VMBUS_CONNECT_CPU);
 
 	/*
@@ -145,6 +151,29 @@ int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 version)
 		return -ECONNREFUSED;
 	}
 
+	if (hv_isolation_type_snp()) {
+		vmbus_connection.monitor_pages_va[0]
+			= vmbus_connection.monitor_pages[0];
+		vmbus_connection.monitor_pages[0]
+			= ioremap_cache(msg->monitor_page1, HV_HYP_PAGE_SIZE);
+		if (!vmbus_connection.monitor_pages[0])
+			return -ENOMEM;
+
+		vmbus_connection.monitor_pages_va[1]
+			= vmbus_connection.monitor_pages[1];
+		vmbus_connection.monitor_pages[1]
+			= ioremap_cache(msg->monitor_page2, HV_HYP_PAGE_SIZE);
+		if (!vmbus_connection.monitor_pages[1]) {
+			vunmap(vmbus_connection.monitor_pages[0]);
+			return -ENOMEM;
+		}
+
+		memset(vmbus_connection.monitor_pages[0], 0x00,
+		       HV_HYP_PAGE_SIZE);
+		memset(vmbus_connection.monitor_pages[1], 0x00,
+		       HV_HYP_PAGE_SIZE);
+	}
+
 	return ret;
 }
 
@@ -156,6 +185,7 @@ int vmbus_connect(void)
 	struct vmbus_channel_msginfo *msginfo = NULL;
 	int i, ret = 0;
 	__u32 version;
+	u64 pfn[2];
 
 	/* Initialize the vmbus connection */
 	vmbus_connection.conn_state = CONNECTING;
@@ -213,6 +243,16 @@ int vmbus_connect(void)
 		goto cleanup;
 	}
 
+	if (hv_isolation_type_snp()) {
+		pfn[0] = virt_to_hvpfn(vmbus_connection.monitor_pages[0]);
+		pfn[1] = virt_to_hvpfn(vmbus_connection.monitor_pages[1]);
+		if (hv_mark_gpa_visibility(2, pfn,
+				VMBUS_PAGE_VISIBLE_READ_WRITE)) {
+			ret = -EFAULT;
+			goto cleanup;
+		}
+	}
+
 	msginfo = kzalloc(sizeof(*msginfo) +
 			  sizeof(struct vmbus_channel_initiate_contact),
 			  GFP_KERNEL);
@@ -279,6 +319,8 @@ int vmbus_connect(void)
 
 void vmbus_disconnect(void)
 {
+	u64 pfn[2];
+
 	/*
 	 * First send the unload request to the host.
 	 */
@@ -298,6 +340,26 @@ void vmbus_disconnect(void)
 		vmbus_connection.int_page = NULL;
 	}
 
+	if (hv_isolation_type_snp()) {
+		if (vmbus_connection.monitor_pages_va[0]) {
+			vunmap(vmbus_connection.monitor_pages[0]);
+			vmbus_connection.monitor_pages[0]
+				= vmbus_connection.monitor_pages_va[0];
+			vmbus_connection.monitor_pages_va[0] = NULL;
+		}
+
+		if (vmbus_connection.monitor_pages_va[1]) {
+			vunmap(vmbus_connection.monitor_pages[1]);
+			vmbus_connection.monitor_pages[1]
+				= vmbus_connection.monitor_pages_va[1];
+			vmbus_connection.monitor_pages_va[1] = NULL;
+		}
+
+		pfn[0] = virt_to_hvpfn(vmbus_connection.monitor_pages[0]);
+		pfn[1] = virt_to_hvpfn(vmbus_connection.monitor_pages[1]);
+		hv_mark_gpa_visibility(2, pfn, VMBUS_PAGE_NOT_VISIBLE);
+	}
+
 	hv_free_hyperv_page((unsigned long)vmbus_connection.monitor_pages[0]);
 	hv_free_hyperv_page((unsigned long)vmbus_connection.monitor_pages[1]);
 	vmbus_connection.monitor_pages[0] = NULL;
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 9416e09ebd58..0778add21a9c 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -240,6 +240,7 @@ struct vmbus_connection {
 	 * is child->parent notification
 	 */
 	struct hv_monitor_page *monitor_pages[2];
+	void *monitor_pages_va[2];
 	struct list_head chn_msg_list;
 	spinlock_t channelmsg_lock;
 
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
