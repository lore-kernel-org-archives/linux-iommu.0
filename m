Return-Path: <SRS0=mcPB=OE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D865CC433EF
	for <iommu@archiver.kernel.org>; Tue, 14 Sep 2021 13:39:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3CB261163
	for <iommu@archiver.kernel.org>; Tue, 14 Sep 2021 13:39:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A3CB261163
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 879C3402D3;
	Tue, 14 Sep 2021 13:39:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KBqrNLwnuVso; Tue, 14 Sep 2021 13:39:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4D37B402BE;
	Tue, 14 Sep 2021 13:39:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 29BCDC0011;
	Tue, 14 Sep 2021 13:39:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D3B5C000D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 13:39:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7ABC980D5B
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 13:39:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8rFtiuEzHSq8 for <iommu@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 13:39:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B7B1280DB8
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 13:39:42 +0000 (UTC)
Received: by mail-pg1-x533.google.com with SMTP id s11so12735695pgr.11
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 06:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=04R/nF7ZQn0L4lmwG9K7NZhI1RIoqJtAembHuZpzcoE=;
 b=cXWjfh70bA6/tTG3cRi7I0j1g+p2Lm3CJSGXyCEtns1z4ew1JMJSouaTXxuUkcmAAF
 pD2ztmNCM/EaSPUeDDaq6UxsWFBxK9H35yFnlW25xXgoMBjP2i0pScCK83QZEclf8ecy
 N9PLUvbIXVRHq4/y1x9TK184cTltER/wXcMXRfCw3qyn5rb59Xp4R9JHz9uej2V7BUzJ
 4nbgXuO4P+lxZbUEZEs/1u05P/Zm7T9ezY8W5GtsXzTaY96NJ/PhksjnQl9x9HnadNWx
 cTQCObr34jF7frx/WSelSqFMtM9MhrWIvfcA85EYhYphGuBONqJDe9RZDWb/6vKzX5CK
 TR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=04R/nF7ZQn0L4lmwG9K7NZhI1RIoqJtAembHuZpzcoE=;
 b=bTDBqT3uhr3Oo3iXklryDFacaYD68Z857WMVGt+afxAYYuIRfvdAwBQlb54eMUCC+B
 4qgRUHjlED3rv8yRB6PtqZeopTztf4s7uWAxvUvMl9rH2ZEYSibxMOqgO6Wa86B98N6/
 erZH6hilce0HvgfSnBKZ+bUR5NXhL8bUfKPfSexGvchA+r/uSdfqJOLEHQR3yF4pIHyd
 h/+qqZby+M7GlruhN01fV/WpFeqKhbkceoilBaG8PtSgAzZ1UbLy9Uhz86wYbmbae3Q3
 5/wyiEuABL5yGFQQ8yqe1b13AIGeTIXHxIGls/BctyH4CCB5eJAffqlQlEZ/JDojoPoO
 qicw==
X-Gm-Message-State: AOAM530/jtW8qLU66kVgV1+KYriUyIKi2hhwITo57N3DXZsHa9U+KCs2
 /W7robDzyDkohhd0t2XJ9Fc=
X-Google-Smtp-Source: ABdhPJyVP18hjlg38ErK5oPFLiCLyC2tXuvAHanGQz+Hb5O3TLtyTYhzBvzQ3suhx9t9fxq63nkGDQ==
X-Received: by 2002:a63:7112:: with SMTP id m18mr15630957pgc.93.1631626782143; 
 Tue, 14 Sep 2021 06:39:42 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:7:6ea2:a529:4af3:5057])
 by smtp.gmail.com with ESMTPSA id v13sm10461234pfm.16.2021.09.14.06.39.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Sep 2021 06:39:41 -0700 (PDT)
From: Tianyu Lan <ltykernel@gmail.com>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
 dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, jgross@suse.com,
 sstabellini@kernel.org, joro@8bytes.org, will@kernel.org,
 davem@davemloft.net, kuba@kernel.org, jejb@linux.ibm.com,
 martin.petersen@oracle.com, gregkh@linuxfoundation.org, arnd@arndb.de,
 hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
 brijesh.singh@amd.com, Tianyu.Lan@microsoft.com, thomas.lendacky@amd.com,
 pgonda@google.com, akpm@linux-foundation.org,
 kirill.shutemov@linux.intel.com, rppt@kernel.org, sfr@canb.auug.org.au,
 aneesh.kumar@linux.ibm.com, saravanand@fb.com, krish.sadhukhan@oracle.com,
 xen-devel@lists.xenproject.org, tj@kernel.org, rientjes@google.com,
 michael.h.kelley@microsoft.com
Subject: [PATCH V5 07/12] Drivers: hv: vmbus: Add SNP support for VMbus
 channel initiate message
Date: Tue, 14 Sep 2021 09:39:08 -0400
Message-Id: <20210914133916.1440931-8-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210914133916.1440931-1-ltykernel@gmail.com>
References: <20210914133916.1440931-1-ltykernel@gmail.com>
MIME-Version: 1.0
Cc: linux-arch@vger.kernel.org, parri.andrea@gmail.com,
 linux-hyperv@vger.kernel.org, linux-scsi@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, dave.hansen@intel.com,
 iommu@lists.linux-foundation.org, vkuznets@redhat.com
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

The monitor pages in the CHANNELMSG_INITIATE_CONTACT msg are shared
with host in Isolation VM and so it's necessary to use hvcall to set
them visible to host. In Isolation VM with AMD SEV SNP, the access
address should be in the extra space which is above shared gpa
boundary. So remap these pages into the extra address(pa +
shared_gpa_boundary).

Introduce monitor_pages_original[] in the struct vmbus_connection
to store monitor page virtual address returned by hv_alloc_hyperv_
zeroed_page() and free monitor page via monitor_pages_original in
the vmbus_disconnect(). The monitor_pages[] is to used to access
monitor page and it is initialized to be equal with monitor_pages_
original. The monitor_pages[] will be overridden in the isolation VM
with va of extra address. Introduce monitor_pages_pa[] to store
monitor pages' physical address and use it to populate pa in the
initiate msg.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
Change since v4:
	* Introduce monitor_pages_pa[] to store monitor pages' physical
	  address and use it to populate pa in the initiate msg.
	* Move code of mapping moniter pages in extra address into
	  vmbus_connect().

Change since v3:
	* Rename monitor_pages_va with monitor_pages_original
	* free monitor page via monitor_pages_original and
	  monitor_pages is used to access monitor page.

Change since v1:
        * Not remap monitor pages in the non-SNP isolation VM.
---
 drivers/hv/connection.c   | 90 ++++++++++++++++++++++++++++++++++++---
 drivers/hv/hyperv_vmbus.h |  2 +
 2 files changed, 86 insertions(+), 6 deletions(-)

diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 8820ae68f20f..edd8f7dd169f 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -19,6 +19,8 @@
 #include <linux/vmalloc.h>
 #include <linux/hyperv.h>
 #include <linux/export.h>
+#include <linux/io.h>
+#include <linux/set_memory.h>
 #include <asm/mshyperv.h>
 
 #include "hyperv_vmbus.h"
@@ -102,8 +104,9 @@ int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 version)
 		vmbus_connection.msg_conn_id = VMBUS_MESSAGE_CONNECTION_ID;
 	}
 
-	msg->monitor_page1 = virt_to_phys(vmbus_connection.monitor_pages[0]);
-	msg->monitor_page2 = virt_to_phys(vmbus_connection.monitor_pages[1]);
+	msg->monitor_page1 = vmbus_connection.monitor_pages_pa[0];
+	msg->monitor_page2 = vmbus_connection.monitor_pages_pa[1];
+
 	msg->target_vcpu = hv_cpu_number_to_vp_number(VMBUS_CONNECT_CPU);
 
 	/*
@@ -216,6 +219,65 @@ int vmbus_connect(void)
 		goto cleanup;
 	}
 
+	vmbus_connection.monitor_pages_original[0]
+		= vmbus_connection.monitor_pages[0];
+	vmbus_connection.monitor_pages_original[1]
+		= vmbus_connection.monitor_pages[1];
+	vmbus_connection.monitor_pages_pa[0]
+		= virt_to_phys(vmbus_connection.monitor_pages[0]);
+	vmbus_connection.monitor_pages_pa[1]
+		= virt_to_phys(vmbus_connection.monitor_pages[1]);
+
+	if (hv_is_isolation_supported()) {
+		vmbus_connection.monitor_pages_pa[0] +=
+			ms_hyperv.shared_gpa_boundary;
+		vmbus_connection.monitor_pages_pa[1] +=
+			ms_hyperv.shared_gpa_boundary;
+
+		ret = set_memory_decrypted((unsigned long)
+					   vmbus_connection.monitor_pages[0],
+					   1);
+		ret |= set_memory_decrypted((unsigned long)
+					    vmbus_connection.monitor_pages[1],
+					    1);
+		if (ret)
+			goto cleanup;
+
+		/*
+		 * Isolation VM with AMD SNP needs to access monitor page via
+		 * address space above shared gpa boundary.
+		 */
+		if (hv_isolation_type_snp()) {
+			vmbus_connection.monitor_pages[0]
+				= memremap(vmbus_connection.monitor_pages_pa[0],
+					   HV_HYP_PAGE_SIZE,
+					   MEMREMAP_WB);
+			if (!vmbus_connection.monitor_pages[0]) {
+				ret = -ENOMEM;
+				goto cleanup;
+			}
+
+			vmbus_connection.monitor_pages[1]
+				= memremap(vmbus_connection.monitor_pages_pa[1],
+					   HV_HYP_PAGE_SIZE,
+					   MEMREMAP_WB);
+			if (!vmbus_connection.monitor_pages[1]) {
+				ret = -ENOMEM;
+				goto cleanup;
+			}
+		}
+
+		/*
+		 * Set memory host visibility hvcall smears memory
+		 * and so zero monitor pages here.
+		 */
+		memset(vmbus_connection.monitor_pages[0], 0x00,
+		       HV_HYP_PAGE_SIZE);
+		memset(vmbus_connection.monitor_pages[1], 0x00,
+		       HV_HYP_PAGE_SIZE);
+
+	}
+
 	msginfo = kzalloc(sizeof(*msginfo) +
 			  sizeof(struct vmbus_channel_initiate_contact),
 			  GFP_KERNEL);
@@ -303,10 +365,26 @@ void vmbus_disconnect(void)
 		vmbus_connection.int_page = NULL;
 	}
 
-	hv_free_hyperv_page((unsigned long)vmbus_connection.monitor_pages[0]);
-	hv_free_hyperv_page((unsigned long)vmbus_connection.monitor_pages[1]);
-	vmbus_connection.monitor_pages[0] = NULL;
-	vmbus_connection.monitor_pages[1] = NULL;
+	if (hv_is_isolation_supported()) {
+		memunmap(vmbus_connection.monitor_pages[0]);
+		memunmap(vmbus_connection.monitor_pages[1]);
+
+		set_memory_encrypted((unsigned long)
+			vmbus_connection.monitor_pages_original[0],
+			1);
+		set_memory_encrypted((unsigned long)
+			vmbus_connection.monitor_pages_original[1],
+			1);
+	}
+
+	hv_free_hyperv_page((unsigned long)
+		vmbus_connection.monitor_pages_original[0]);
+	hv_free_hyperv_page((unsigned long)
+		vmbus_connection.monitor_pages_original[1]);
+	vmbus_connection.monitor_pages_original[0] =
+		vmbus_connection.monitor_pages[0] = NULL;
+	vmbus_connection.monitor_pages_original[1] =
+		vmbus_connection.monitor_pages[1] = NULL;
 }
 
 /*
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 42f3d9d123a1..560cba916d1d 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -240,6 +240,8 @@ struct vmbus_connection {
 	 * is child->parent notification
 	 */
 	struct hv_monitor_page *monitor_pages[2];
+	void *monitor_pages_original[2];
+	unsigned long monitor_pages_pa[2];
 	struct list_head chn_msg_list;
 	spinlock_t channelmsg_lock;
 
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
