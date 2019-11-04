Return-Path: <SRS0=uwQI=Y4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC02CA9EB5
	for <iommu@archiver.kernel.org>; Mon,  4 Nov 2019 16:28:49 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 243E020848
	for <iommu@archiver.kernel.org>; Mon,  4 Nov 2019 16:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJDpyd2q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 243E020848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A9F20FC7;
	Mon,  4 Nov 2019 16:28:37 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id EDA40B0B
	for <iommu@lists.linux-foundation.org>;
	Mon,  4 Nov 2019 05:59:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com
	[209.85.214.194])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id F23A75D0
	for <iommu@lists.linux-foundation.org>;
	Mon,  4 Nov 2019 05:59:36 +0000 (UTC)
Received: by mail-pl1-f194.google.com with SMTP id ay6so122879plb.0
	for <iommu@lists.linux-foundation.org>;
	Sun, 03 Nov 2019 21:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=zy/MVb0aYjqgyH6298HXpFaGlCLcvjGqnlnxm7FEfdE=;
	b=aJDpyd2qSypbXEnsPfhRa1txYFFxquuGn/oCqcq4dFt8Zh3kfuwg5OX+tFpyB8/5hF
	XlKMQNQi3CXtEE15M8hGpNqqIEyXJx4uztSRIbNHKZPp7y0GN2nB8Z157CRNGOcABtJW
	OpMJ2rcpd1Qm1Vel8D6hMr/29asFa3QmjxhyVEDr/+MV52+mCaFcvS0JQUtltEALxFzP
	6CNxBBk5dXKgPptrVU5i+aNvT+mGk/NTIwYuY0Np79so59Ej6A2MuWsu6FQcdakEQwSk
	74oEtaVjarfGl+JxDNIgHc8A48UmK6wlMlRDDkwoaSRQAreTCf2SsxFpRVna7R4Aw4Aq
	3p0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=zy/MVb0aYjqgyH6298HXpFaGlCLcvjGqnlnxm7FEfdE=;
	b=Sl16lwL9jWX8LDnVuyI9eF96xUtX9qk5s7e8aPBCyYOt/ZoUSaHVxkhQL8Lbr5TPHL
	TdwPhPH6O+FBi4SRRGDC07ufKrQVb89M6DtBc1ex539DpXh+mBZ0/adZ2+PBolk15mfa
	fu7wJGrwzA2VYO5+qS8XzY/ddpnvuZSFE13JUZrBSymbj8BApU8qM017nfQRemd99Hb+
	l/87pedUcFXZrbipi+3TS3fB1dKMUMSB8HCDt+LRJ/puML/A6IHEFCy8u96Xx4V/trv9
	4M9meHmWvCIhmq5ARu+n/JycO/TFXtu4XrRP0y9eFxQxdlMFaGBWbUI+CgHIbatZaHev
	Pa4g==
X-Gm-Message-State: APjAAAVnqdIr5biLcTGutCLtF0zv0j7aRGD86/uf2H0rw4mxken9Z32w
	f3pidfJg1dbMRpm7LPv5g8E=
X-Google-Smtp-Source: APXvYqzZnJ2V5l/Fizf+P6jLh+7HISpaYB2ZiT19w+2RDlESrN5OGWeL5/WEnpMQsfzUu0/n5JbrHQ==
X-Received: by 2002:a17:902:988d:: with SMTP id
	s13mr25909994plp.335.1572847176253; 
	Sun, 03 Nov 2019 21:59:36 -0800 (PST)
Received: from AHUANG12-1LT7M0.lenovo.com (1-175-125-46.dynamic-ip.hinet.net.
	[1.175.125.46]) by smtp.googlemail.com with ESMTPSA id
	j186sm13069612pfg.161.2019.11.03.21.59.34
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Sun, 03 Nov 2019 21:59:35 -0800 (PST)
From: Adrian Huang <adrianhuang0701@gmail.com>
X-Google-Original-From: Adrian Huang <ahuang12@lenovo.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 1/1] iommu/amd: Fix the overwritten exclusion range with
	multiple IVMDs
Date: Mon,  4 Nov 2019 13:58:52 +0800
Message-Id: <20191104055852.24395-1-ahuang12@lenovo.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Mon, 04 Nov 2019 16:28:36 +0000
Cc: iommu@lists.linux-foundation.org, Adrian Huang <ahuang12@lenovo.com>
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

When attaching two Broadcom RAID controllers to a server, the first one
reports the failure during booting (the disks connecting to the RAID
controller cannot be detected):

  megaraid_sas 0000:42:00.0: Init cmd return status FAILED for SCSI host 0
  megaraid_sas 0000:42:00.0: Failed from megasas_init_fw 6376

Root-cause of the issue:
	1) Those two RAID controllers define their own IVMDs with the
	   valid exclusion range, and they are associated with the same
	   IOMMU hardware:

                 Subtable Type : 10 [Hardware Definition Block]
                         Flags : B0
                        Length : 0028
                      DeviceId : 4002

             Capability Offset : 0040
                  Base Address : 00000000B4100000
             PCI Segment Group : 0000
           Virtualization Info : 0000
                      Reserved : 80048F6F

                    Entry Type : 03
                     Device ID : 4008
                  Data Setting : 00

                    Entry Type : 04
                     Device ID : 7FFE
                  Data Setting : 00

                 Subtable Type : 21 [Memory Definition Block]
                         Flags : 08
                        Length : 0020
                      DeviceId : 4200

                Auxiliary Data : 0000
                      Reserved : 0000000000000000
                 Start Address : 000000009F58D000
                 Memory Length : 0000000008040000

                 Subtable Type : 21 [Memory Definition Block]
                         Flags : 08
                        Length : 0020
                      DeviceId : 4300

                Auxiliary Data : 0000
                      Reserved : 0000000000000000
                 Start Address : 000000009754D000
                 Memory Length : 0000000008040000

	2) When set_device_exclusion_range() parses the IVMD of devce id
	   '4200', the exclusion range of the amd_iommu struct becomes:

		iommu->exclusion_start = 0x9F58D000;
		iommu->exclusion_length = 0x8040000;

	3) When parsing the second IVMD (device id '4300') in
	   set_device_exclusion_range(), the exclusion range of the
	   amd_iommu struct becomes:

		iommu->exclusion_start = 0x9754D000;
		iommu->exclusion_length = 0x8040000;

	   This overwrites the first IVMD configuration, which leads to
	   the failure of the first RAID controller.

This patch fixes the issue by using unity map for multiple IVMDs if
those IVMDs define the valid exclusion range (different exclusion range)
and they are associated with the same IOMMU hardware. Note that the first
IVMD still uses the exclusion range.

Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
---
 drivers/iommu/amd_iommu_init.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 568c52317757..d65b548a42f5 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -71,6 +71,8 @@
 #define IVHD_FLAG_ISOC_EN_MASK          0x08
 
 #define IVMD_FLAG_EXCL_RANGE            0x08
+#define IVMD_FLAG_IW                    0x04
+#define IVMD_FLAG_IR                    0x02
 #define IVMD_FLAG_UNITY_MAP             0x01
 
 #define ACPI_DEVFLAG_INITPASS           0x01
@@ -1110,6 +1112,32 @@ static int __init add_early_maps(void)
 	return 0;
 }
 
+static int __init exclusion_range_has_configured(struct amd_iommu *iommu,
+							struct ivmd_header *m)
+{
+	/* Not configure yet. */
+	if (!iommu->exclusion_start) {
+		iommu->exclusion_start = m->range_start;
+		iommu->exclusion_length = m->range_length;
+
+		return 0;
+	}
+
+	if (iommu->exclusion_start == m->range_start &&
+	    iommu->exclusion_length == m->range_length)
+		return 0;
+
+	/*
+	 * The exclusion range of the iommu has been configured
+	 * by the other IVMD, so we need to use unity map for this
+	 * IVMD to avoid the overwritten exclusion range members of the
+	 * amd_iommu structure.
+	 */
+	m->flags = (IVMD_FLAG_IW | IVMD_FLAG_IR | IVMD_FLAG_UNITY_MAP);
+
+	return 1;
+}
+
 /*
  * Reads the device exclusion range from ACPI and initializes the IOMMU with
  * it
@@ -1122,14 +1150,15 @@ static void __init set_device_exclusion_range(u16 devid, struct ivmd_header *m)
 		return;
 
 	if (iommu) {
+		if (exclusion_range_has_configured(iommu, m))
+			return;
+
 		/*
 		 * We only can configure exclusion ranges per IOMMU, not
 		 * per device. But we can enable the exclusion range per
 		 * device. This is done here
 		 */
 		set_dev_entry_bit(devid, DEV_ENTRY_EX);
-		iommu->exclusion_start = m->range_start;
-		iommu->exclusion_length = m->range_length;
 	}
 }
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
