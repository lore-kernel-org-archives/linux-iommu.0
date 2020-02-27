Return-Path: <SRS0=1PsK=4P=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4B8C4BA06
	for <iommu@archiver.kernel.org>; Thu, 27 Feb 2020 09:01:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF5CC20838
	for <iommu@archiver.kernel.org>; Thu, 27 Feb 2020 09:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=necglobal.onmicrosoft.com header.i=@necglobal.onmicrosoft.com header.b="J+4rDh4H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF5CC20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nec.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1F69A86C40;
	Thu, 27 Feb 2020 09:01:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UN6pyD_eU6WC; Thu, 27 Feb 2020 09:01:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8EB6086C23;
	Thu, 27 Feb 2020 09:01:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 34D78C1D8E;
	Thu, 27 Feb 2020 09:01:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97628C0177
 for <iommu@lists.linux-foundation.org>; Thu, 27 Feb 2020 09:01:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 841108651C
 for <iommu@lists.linux-foundation.org>; Thu, 27 Feb 2020 09:01:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EJoyuly5vozt for <iommu@lists.linux-foundation.org>;
 Thu, 27 Feb 2020 09:01:03 +0000 (UTC)
X-Greylist: delayed 00:33:47 by SQLgrey-1.7.6
Received: from JPN01-OS2-obe.outbound.protection.outlook.com
 (mail-eopbgr1410075.outbound.protection.outlook.com [40.107.141.75])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 6E3E186542
 for <iommu@lists.linux-foundation.org>; Thu, 27 Feb 2020 09:01:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AycAFgVcLgAsrg/Rt7l4wqUY7xeftM4hXOlovWofcj/BH6EUf39lCVgqjfearjQS3xlIJPd0oYlmbQJZVgDy0RTvazzPy6UgQjxAh11bwC+ltK3vCvYGeOxqDyLyt7Tkm1e4K4y9dJsOQR2RhWe6O5E1Fq35zWWJ768KWFiU+cS8QfHiLfzHqP53zOOxkfvnWUusnkPDEqLe1bc2nPkyjEtTroGJEqgT9xHRdF2Y/x5+7seItByd75nGtFCDO0TOljDYZ/IDU1vZFU1BMdFQ6XxD9heh7HqpVrFFO7VXh/SgaS2ACxIMdneA1kydCtL6Og/p5gMly/Yo2bnCKZelpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eyz+/jEL5UbxJFCbhP+cTOY6Kj6BsQhTwhMfpIbZEu4=;
 b=lRHA/iCYl3US99XBOzfVCwWLosotMJ2HBarGYjQSY8bBvWGhbcu1b62IsjOMtuSvKFtMqjL7c1+KUSNUGJL/vS78oRz6IBA4GUfy8JDuLSUYgT86qL5DR2cQlajcMDlf5M8Fg0wpjR0dbKN94xCUqsRjmdFJbjWC3kmip7U7L5jrmTfx+ppyj3Iz5wghvjOrZfZv6ZGMWyMdfKyxxgZRGvbbWbYG81ybuSbGFI3T9oJoISF189fpqA55nxlY7LLD5epDtyerdE0GA9FPwubt4evsWs0dYuB+v0jqq8M0uR2fFF8ApJtwT9WXlMGztmxFCX41WZrpCqpN/Qd8uBqjCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=necglobal.onmicrosoft.com; s=selector1-necglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eyz+/jEL5UbxJFCbhP+cTOY6Kj6BsQhTwhMfpIbZEu4=;
 b=J+4rDh4Hf60KKRUdcphRpXH0mPQcCNeha0xTE/6o9Sj5RG3LvvWnBereOmHVkuvCGzmWjaH+tg0NLF/SeFsVVpllYSUBGDbtUR3Mb1ZP2x/5HbEc9pH3UvMSEtTHfcLqX9J/NVNqI87TidB5CU52CVtii3+t7Kb1yvtFWix98uI=
Received: from TYAPR01MB2272.jpnprd01.prod.outlook.com (52.133.179.151) by
 TYAPR01MB2925.jpnprd01.prod.outlook.com (20.177.103.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Thu, 27 Feb 2020 08:27:13 +0000
Received: from TYAPR01MB2272.jpnprd01.prod.outlook.com
 ([fe80::8c79:5c69:8186:fa52]) by TYAPR01MB2272.jpnprd01.prod.outlook.com
 ([fe80::8c79:5c69:8186:fa52%6]) with mapi id 15.20.2772.012; Thu, 27 Feb 2020
 08:27:13 +0000
From: =?iso-2022-jp?B?Tk9NVVJBIEpVTklDSEkoGyRCTG5CPCEhPV8wbBsoQik=?=
 <junichi.nomura@nec.com>
To: Yian Chen <yian.chen@intel.com>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: [PATCH] iommu: Refine VT-d RMRR region check for BIOS reservation
Thread-Topic: [PATCH] iommu: Refine VT-d RMRR region check for BIOS reservation
Thread-Index: AQHV7Ue25iJ7Qz3tjk6iVUnFmiqvCQ==
Date: Thu, 27 Feb 2020 08:27:13 +0000
Message-ID: <920d35e1-c3d0-f943-2925-00dde46c42d5@nec.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=junichi.nomura@nec.com; 
x-originating-ip: [165.225.110.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 88a87008-dfd9-44b1-e182-08d7bb5ed8be
x-ms-traffictypediagnostic: TYAPR01MB2925:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB29257F1F92B5AC1A2693F62783EB0@TYAPR01MB2925.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 03264AEA72
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(199004)(189003)(55236004)(31696002)(4326008)(31686004)(26005)(85182001)(110136005)(2906002)(6506007)(54906003)(186003)(478600001)(86362001)(316002)(36756003)(2616005)(66946007)(66476007)(66446008)(81166006)(66556008)(64756008)(81156014)(76116006)(8676002)(5660300002)(6486002)(71200400001)(6512007)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:TYAPR01MB2925;
 H:TYAPR01MB2272.jpnprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nec.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w6AfYaxLLn4ugiaTpa/8rmxGcsJeVkkutqNcbhB17mtGabgqge14pP4gs64JUOi6OeWPCVUq0RP96/5YeW4CfFl9pUS/orrjiORyVvA5ORPl/peQ1w6dWy5fA+9UJNDVlNOCIB8yEXHvaBV/q3F1F6EV40OijO0sVhpp4fq0vK1kFKqNcUwpC48ngHr48jEFDoCocch3181O6UbCUIV4ABJ9qDQgdZH18bi/5V29PXvtBEkTAL0fwuTAQ2YhBao6ooGr/+w4f3HzmYw+K1o73BB7Lmx7EPJtm+ZWpUgXKFwr8nZaselugUp/uOWAM4/8C7eKGX3th+am2p9rnb8RKDpcSmD4zGQ4Pn8Hy5SwLL4iT9BrYcxYTUDJiBDTxc0Dllt/Q1+2oao7Y3hfn8uUQf9vLNcRl6D/04EtcVbqUQBywQMeKtsunfkiMcQa7Bp6
x-ms-exchange-antispam-messagedata: xF4tCkqNAMMVwW+De4cJdkEiv+KE7++pPw45B4O2L22IkY8sbLGNAVPbLm5X0zm+z4xKhvKHHQgfyhKNy4LOmj1WfOg7PWaZ30zIM9sbPHYTJqLJUnqA3ddxxbec+XbLiq1RKOGrOwLnvD7438Oczw==
Content-ID: <D483F4AD6E4EC549893780DA2DBC6D43@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88a87008-dfd9-44b1-e182-08d7bb5ed8be
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2020 08:27:13.2683 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fB2XU7c9zseXb1zDea5lx4oMsurcKtZF1u/Zcr+VJ7aWY/4kWyyg1xIH/I9VsyMTL5OJnt2itU3DhrdKmIK1Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2925
Cc: "jroedel@suse.de" <jroedel@suse.de>
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

arch_rmrr_sanity_check() was introduced by commit f036c7fa0ab6 ("iommu/vt-d:
Check VT-d RMRR region in BIOS is reported as reserved") to detect RMRR
pointing to the area that might be used by OS as free memory. However the
check was based on E820_TYPE_RESERVED coverage and raised false alarms if
BIOS reported the area as other reservation types.

Example of warning looks like this:

  DMAR: [Firmware Bug]: No firmware reserved region can cover this RMRR [0x00000000a2290000-0x00000000a2292fff], contact BIOS vendor for fixes
  ------------[ cut here ]------------
  Your BIOS is broken; bad RMRR [0x00000000a2290000-0x00000000a2292fff]
  WARNING: CPU: 0 PID: 0 at drivers/iommu/intel-iommu.c:4470 dmar_parse_one_rmrr+0x9a/0x14f
  CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.6.0-rc3-00069-g91ad64a #1
  RIP: 0010:dmar_parse_one_rmrr+0x9a/0x14f
  Code: 00 48 89 c3 e8 f0 a0 03 ff 49 8b 54 24 10 49 8b 74 24 08 48 89 c1 4d 89 e9 49 89 d8 48 c7 c7 10 18 76 a1 31 c0 e8 2f f9 9d fe <0f> 0b 48 8b 3d 46 c4 af ff ba 38 00 00 00 be c0 0d 00 00 e8 67 6a
  RSP: 0000:ffffffffa1a03d68 EFLAGS: 00010286
  RAX: 0000000000000000 RBX: ffffffffa2400004 RCX: ffffffffa1a67708
  RDX: 0000000000000001 RSI: 0000000000000082 RDI: 0000000000000246
  RBP: ffffffffa1a03d80 R08: 000000000000020d R09: 000000000000020d
  R10: 50203b313355203a R11: 726556203b43454e R12: ffffad5f00042180
  R13: ffffffffa14f9258 R14: ffffffffa1a03dc8 R15: ffff9f39fffc0bc0
  FS:  0000000000000000(0000) GS:ffff9f219f600000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: ffff9f39ffdff000 CR3: 000000279f40a001 CR4: 00000000000606b0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  Call Trace:
   dmar_walk_remapping_entries+0xa1/0x1e0
   dmar_table_init+0xda/0x16c
   intel_prepare_irq_remapping+0x3e/0x244
   irq_remapping_prepare+0x1b/0x6d
   enable_IR_x2apic+0x2d/0x16e
   default_setup_apic_routing+0x16/0x75
   apic_intr_mode_init+0xe7/0x10c
   x86_late_time_init+0x24/0x2b
   start_kernel+0x5a7/0x66b
   x86_64_start_reservations+0x24/0x26
   x86_64_start_kernel+0x8a/0x8d
   secondary_startup_64+0xb6/0xc0
  ---[ end trace b61aef72ecd09def ]---

In this case, though, 0x00000000a2290000-0x00000000a2292fff is inside the
area reported as ACPI NVS by BIOS and won't be used as free memory pool:

  BIOS-e820: [mem 0x00000000a067a000-0x00000000a2a79fff] ACPI NVS

Refine the check to detect if any part of the area is reported by BIOS
as OS-usable region.

Fixes: f036c7fa0ab60 ("iommu/vt-d: Check VT-d RMRR region in BIOS is reported as reserved")
Signed-off-by: Jun'ichi Nomura <junichi.nomura@nec.com>
Cc: Yian Chen <yian.chen@intel.com>
Cc: Joerg Roedel <jroedel@suse.de>

diff --git a/arch/x86/include/asm/iommu.h b/arch/x86/include/asm/iommu.h
index bf1ed2d..5629ff2e 100644
--- a/arch/x86/include/asm/iommu.h
+++ b/arch/x86/include/asm/iommu.h
@@ -18,12 +18,15 @@
 	u64 start = rmrr->base_address;
 	u64 end = rmrr->end_address + 1;
 
-	if (e820__mapped_all(start, end, E820_TYPE_RESERVED))
-		return 0;
+	if (e820__mapped_any(start, end, E820_TYPE_RAM) ||
+	    e820__mapped_any(start, end, E820_TYPE_RESERVED_KERN)) {
+		pr_err(FW_BUG "OS usable region overwraps with this RMRR [%#018Lx-%#018Lx], contact BIOS vendor for fixes\n",
+		       start, end - 1);
+		return -EINVAL;
+	}
+
+	return 0;
 
-	pr_err(FW_BUG "No firmware reserved region can cover this RMRR [%#018Lx-%#018Lx], contact BIOS vendor for fixes\n",
-	       start, end - 1);
-	return -EINVAL;
 }
 
 #endif /* _ASM_X86_IOMMU_H */
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
