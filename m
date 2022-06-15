Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4DBFC433EF
	for <iommu@archiver.kernel.org>; Wed, 15 Jun 2022 18:37:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6204082A2E;
	Wed, 15 Jun 2022 18:37:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cw0bxYyG2EBo; Wed, 15 Jun 2022 18:37:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2D108829B1;
	Wed, 15 Jun 2022 18:37:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 03495C0032;
	Wed, 15 Jun 2022 18:37:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A25CC002D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 18:37:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 29197414C5
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 18:37:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=hpe.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7D1-0fTQY4Ey for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 18:37:08 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com
 [148.163.143.35])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DC19B409F0
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 18:37:07 +0000 (UTC)
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
 by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25FHGlT9017477;
 Wed, 15 Jun 2022 18:36:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=d8XMAARgmnvj7xzWvqVtF6dIUJY16r1BmnSQrSMGTqQ=;
 b=iJW9MxtP5ygLHuflc+Z3XqBWp9H4XpEKXScXERkUYnwYMmAY+HE1XAvb41ITd56pXXA3
 V5na3ku1JfXv574YmKGC/M/7mhiWfpc2DBjUKKKqc0wj+juEBqwjKQf1C0hVZ1OexvMJ
 UhW71beZa99rXAHxzfDfIV7j2AIr6Y2vzrywNmuELHxca+PZzGNRHPkXSYS4zfnYNTnh
 PY42uVWWU2XEY8giMLw8NGpPDDAgjVDnhpXnXulwk8nQWdN93PuIlHdPOE0yRKLKOVIb
 QN6d8R1hnBo8oeAA+JvZq0qP9NKn15D6FeZ8kKIGEbNt1k166dqT+2+ZFlnxgWGelNa1 cQ== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
 by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3gqh1ftb8h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jun 2022 18:36:53 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 58A038058C1;
 Wed, 15 Jun 2022 18:36:51 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (unknown [16.231.227.36])
 by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id AAB04803D8C;
 Wed, 15 Jun 2022 18:36:50 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
 id 42142302F481D; Wed, 15 Jun 2022 13:36:50 -0500 (CDT)
From: Steve Wahl <steve.wahl@hpe.com>
To: Joerg Roedel <jroedel@suse.de>, Kyung Min Park <kyung.min.park@intel.com>, 
 Lu Baolu <baolu.lu@linux.intel.com>,
 David Woodhouse <dwmw2@infradead.org>, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, Kevin Tian <kevin.tian@intel.com>,
 Jerry Snitselaar <jsnitsel@redhat.com>
Subject: [PATCH v3] iommu/vt-d: Make DMAR_UNITS_SUPPORTED a config setting
Date: Wed, 15 Jun 2022 13:36:50 -0500
Message-Id: <20220615183650.32075-1-steve.wahl@hpe.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <9d6177ac-802f-eb11-4307-b0e49d8126b5@linux.intel.com>
References: <9d6177ac-802f-eb11-4307-b0e49d8126b5@linux.intel.com>
MIME-Version: 1.0
X-Proofpoint-GUID: 8YzfRBAg7HrDz3A532e43JIerEl_zZPJ
X-Proofpoint-ORIG-GUID: 8YzfRBAg7HrDz3A532e43JIerEl_zZPJ
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-15_15,2022-06-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 impostorscore=0 clxscore=1015 mlxlogscore=999 suspectscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206150069
Cc: Mike Travis <mike.travis@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>,
 linux-kernel@vger.kernel.org, Russ Anderson <russ.anderson@hpe.com>,
 Steve Wahl <steve.wahl@hpe.com>
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

To support up to 64 sockets with 10 DMAR units each (640), make the
value of DMAR_UNITS_SUPPORTED adjustable by a config variable,
CONFIG_DMAR_UNITS_SUPPORTED, and make it's default 1024 when MAXSMP is
set.

If the available hardware exceeds DMAR_UNITS_SUPPORTED (previously set
to MAX_IO_APICS, or 128), it causes these messages: "DMAR: Failed to
allocate seq_id", "DMAR: Parse DMAR table failure.", and "x2apic: IRQ
remapping doesn't support X2APIC mode x2apic disabled"; and the system
fails to boot properly.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---

Note that we could not find a reason for connecting
DMAR_UNITS_SUPPORTED to MAX_IO_APICS as was done previously.  Perhaps
it seemed like the two would continue to match on earlier processors.
There doesn't appear to be kernel code that assumes that the value of
one is related to the other.

v2: Make this value a config option, rather than a fixed constant.  The default
values should match previous configuration except in the MAXSMP case.  Keeping the
value at a power of two was requested by Kevin Tian.

v3: Make the config option dependent upon DMAR_TABLE, as it is not used without this.

 drivers/iommu/intel/Kconfig | 7 +++++++
 include/linux/dmar.h        | 6 +-----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
index 39a06d245f12..07aaebcb581d 100644
--- a/drivers/iommu/intel/Kconfig
+++ b/drivers/iommu/intel/Kconfig
@@ -9,6 +9,13 @@ config DMAR_PERF
 config DMAR_DEBUG
 	bool
 
+config DMAR_UNITS_SUPPORTED
+	int "Number of DMA Remapping Units supported"
+	depends on DMAR_TABLE
+	default 1024 if MAXSMP
+	default 128  if X86_64
+	default 64
+
 config INTEL_IOMMU
 	bool "Support for Intel IOMMU using DMA Remapping Devices"
 	depends on PCI_MSI && ACPI && (X86 || IA64)
diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index 45e903d84733..0c03c1845c23 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -18,11 +18,7 @@
 
 struct acpi_dmar_header;
 
-#ifdef	CONFIG_X86
-# define	DMAR_UNITS_SUPPORTED	MAX_IO_APICS
-#else
-# define	DMAR_UNITS_SUPPORTED	64
-#endif
+#define	DMAR_UNITS_SUPPORTED	CONFIG_DMAR_UNITS_SUPPORTED
 
 /* DMAR Flags */
 #define DMAR_INTR_REMAP		0x1
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
