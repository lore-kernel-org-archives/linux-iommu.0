Return-Path: <SRS0=SLGw=NE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC5DC432BE
	for <iommu@archiver.kernel.org>; Fri, 13 Aug 2021 17:01:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFC8461158
	for <iommu@archiver.kernel.org>; Fri, 13 Aug 2021 17:01:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AFC8461158
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7C817407C8;
	Fri, 13 Aug 2021 17:01:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BnrCKN3QYtKW; Fri, 13 Aug 2021 17:01:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9E5CE407C2;
	Fri, 13 Aug 2021 17:01:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7B6E1C001A;
	Fri, 13 Aug 2021 17:01:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5959CC000E
 for <iommu@lists.linux-foundation.org>; Fri, 13 Aug 2021 17:01:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3797E402BD
 for <iommu@lists.linux-foundation.org>; Fri, 13 Aug 2021 17:01:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z3VhBQygSB-j for <iommu@lists.linux-foundation.org>;
 Fri, 13 Aug 2021 17:01:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3A7D2402BE
 for <iommu@lists.linux-foundation.org>; Fri, 13 Aug 2021 17:01:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NgPglQ3hh8QXHsCq07WqlCvEBYspDRuTjNvxA7r605JlEfSKClcXnWTfb2KOQLypPsBZflBJ0ZEHNCzErIXg+/zeEQ/gM5d/FXumaPtOxeZPbRhOpOlWGStI1rhEgPXgY+a3tPiQ9Tbybsc75kvOY3PiExZXviJGJ72qiKVzWCIQupQYz1+Ws1VSy3h0zSL7FkxS76laYnAxwdPcXf3bmEUE3YCH/DxMchhgvNTa9BSRLaGgBtgu+usUepSsDlIqAWauXrf6GaB/tH78ovk7+T0RgNZx2flP1ASolbxuJ7XsGTw+EyOcyCpi9ZnKhZ6fdMEVxOB2l0XlkW7tMVLFkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PsmJ+lrGUjWxw5OB9HQtUyacIoyhf/JdHwzsAlQqhUg=;
 b=e1+j+CYtqdl80sjGFVhXbkRRvbxRJa/ME10ntXCmtNA7kMxwCKboKCOrmMzWEikTXrbJp4vUYFQjMafP58laQAKeo3HN2qCRxNjVMKReoS65L4XxfFOVozIsSzPFWrlgkTKw4t8lsgI3oLqUD+tf0hbevywF+hF4qweqmyTqbPIJFxPTT20W7pnLOPkPm7aXCnzox1cvlXK+BF30xi2+ALhKm83+xkPZXIKN/nbOuuSYgObYJcV6hkmIWJ+TC8Bk0QfCYIapJ+xz3nLAPuHYfE3yp7ps3VUD/iorhD863qJKdzOQqJwceFrTU5va1Y0ci35JTAqjHjDa0Qj/qEJsow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PsmJ+lrGUjWxw5OB9HQtUyacIoyhf/JdHwzsAlQqhUg=;
 b=3AaBXuY0j4UKVFy64KSfAHh6ST3vBAtbIXsQh71TnJS4XSzO6owU4oj85hyM3BiqeANzQaDqHPN9w2MmoGMFBL6FZnIvTLXsjO2AzUPDeFteM/pwKNq9dMp9R+TioNE7TG6oB/1ZDC8EQKsh4+TKFchDhA46ze0m8OVAW0Wzwo4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5247.namprd12.prod.outlook.com (2603:10b6:5:39b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Fri, 13 Aug
 2021 17:01:13 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418%6]) with mapi id 15.20.4415.019; Fri, 13 Aug 2021
 17:01:13 +0000
To: linux-kernel@vger.kernel.org, x86@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
 linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-graphics-maintainer@vmware.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, kexec@lists.infradead.org,
 linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 10/12] x86/sev: Remove the now unused mem_encrypt_active()
 function
Date: Fri, 13 Aug 2021 11:59:29 -0500
Message-Id: <974f50588528f046b98963f6978a13ba4d98b157.1628873970.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1628873970.git.thomas.lendacky@amd.com>
References: <cover.1628873970.git.thomas.lendacky@amd.com>
X-ClientProxiedBy: SA9PR13CA0117.namprd13.prod.outlook.com
 (2603:10b6:806:24::32) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tlendack-t1.amd.com (165.204.77.1) by
 SA9PR13CA0117.namprd13.prod.outlook.com (2603:10b6:806:24::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.11 via Frontend Transport; Fri, 13 Aug 2021 17:01:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 188bd990-3eab-428e-6915-08d95e7bf50c
X-MS-TrafficTypeDiagnostic: DM4PR12MB5247:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5247B7317B19173DD42A61E7ECFA9@DM4PR12MB5247.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CyvY0ibNbFHz5Bw8+mMlMbt8HDez/UJoJxV3Opp8hVRJHuKr6wa7/YTkvnHnZz6kpwO0Q9l5HWunw3gImZkXWWt5TciZH0l8G5z51YAh9r8JKcXMalg8zprXwXgHg/6z/ACNuwXCodXekY2qX5/a3wav9l70PYO+PVcFW4zZGUaNBXRFRC5KDRtN3PXpF6rRZSgjPPrAs9/2ZtB/GuXpvSt0hfYJxxUADpfU6K60jr36OYbYOmVgnquoLjGiZoXY7QF1TlkVvxKOalGcd/Xph/019ZcVl+ZyskmO99hIYpef7f9fX6B6L89p2CotXITSM43KP0EW+h8lC4j6iu49nr3oqPcGYwgfh94InMcRJh+CYdwfykVuhtcpaUtqGa8/o7kmaeFBIus7CaDrVoVHnvVlMhMbaMQS129Osgy3v4kyeKYMJ9A2ziLwRuMDbVgeLzK1d+S9IZRcvSl6VaTgirJKRT8H4PZAf1m0xJXgfOM4VLTVwsQrOtVoSzBY+yhAzq6HH9bM0Fty9EiKJggtxGDxVBzxIPTpUDjwHyK1PfIlKw5Ma2qd2D+b2S/KegdvihARUpJw9NQZICvmKcD053dBEggbRNBJ0WIYZNghdIRr0xQAGcPFk9ATn4hoqndTbqg6TgBv2ryzgRFpDYrn0/rYERwKil1dxRCfLzYg2FSQ9i75gPGzfjGnHdHOlwnKBf36e7DmSg8OcdUtFQiUPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5229.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39860400002)(136003)(376002)(396003)(186003)(956004)(83380400001)(4744005)(2616005)(86362001)(921005)(2906002)(66476007)(5660300002)(7696005)(6486002)(478600001)(8676002)(8936002)(66946007)(7416002)(4326008)(52116002)(66556008)(54906003)(316002)(38350700002)(36756003)(6666004)(26005)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/kIBO3AdsHeL5PmWHLKHGIlWc4XMAXAaqUD28ol4+cj9slrT8RrWdPYagro4?=
 =?us-ascii?Q?mKZ5Is3Ov4P2nGQnhqBTmI33LUy4nHsN17/9di401gEx8zcnBgZ/zRW2m5U3?=
 =?us-ascii?Q?IdHLDpxF52PKUAHQpTAPvZgq3NqkQ4djT3BuX3cbdvLH/w5mDuA/SqgGD31X?=
 =?us-ascii?Q?tSZ31U8rB7BSv0c8hSK/GaUvegdPV+pkXFgjc/MrRjOC/aPHoesVFF0OmtZn?=
 =?us-ascii?Q?+NgC2JS2lN9SsiYcBqyB5gxMxURL4rp3xboJ9XoPrrzKhvYX61O1CuXUbllb?=
 =?us-ascii?Q?MUJQJHDS8p2d9F7QRNEndT47eGfZgwLRapXTShmcDy2f2A103KFFdZDsCgI2?=
 =?us-ascii?Q?T2QE9yevNcgg9WbkK9Dh7yb2nC0c/r6MULE1uK8S6cz2E/eNfIToT/rJa80e?=
 =?us-ascii?Q?R3jHQGWhJD1omIOHLcW+afeJsmx8EgpOKIGM/SLoYIxVqIM9NvWFJ+XydGoZ?=
 =?us-ascii?Q?2dhvuYaGWH1t5i7qqWa3w06Lp5fUs/y0LGOwVtiYS7nvtLSA8ByTNZsgZnq8?=
 =?us-ascii?Q?UDxlu746t0IKnk3qVC7NFNQnu+hx8Endx8kgFdboqcZH7Gc5uNoiixUuRIW8?=
 =?us-ascii?Q?jS9sx9F8um5+8TuXd+HpdbXc19cU3Odiz0Zyv/yDUV2jShTk9oNlH2JLxPzA?=
 =?us-ascii?Q?Dd7xU0/AkN1l5twwYSe5GupbfXg03dhhF9+Fcy/xyfaaBt/ehXNpRp6c4FDM?=
 =?us-ascii?Q?f87GvH5OIv0JgAQLhUSnCCc7hHdKqE2W/D2BMwxDbttYAJ6H5zcMGmiIQ2AA?=
 =?us-ascii?Q?t8+37or6NCjOR5bOhYYzKAb0+p++1KjNZ6Y33bbW0qzMjf415XhZh/7mC1qB?=
 =?us-ascii?Q?YPWZ2p/lQOoTtD5gizYAYBiseWwl1xA7P1rStyhvsLSMZRvCQPAi5dYbYzJH?=
 =?us-ascii?Q?Br486TRbXL5JdOfRl+UQVyFuCvlFy+z1a9zY6OzrrsOchPgu5o90qf4hjQY/?=
 =?us-ascii?Q?cm92UALU/+X2i8AdDJsju5JNUJOBTECdqUjmz/MQNLWYAgMYTFWcBK+xzjiB?=
 =?us-ascii?Q?uaM2aobv7N/Tnag8evizyzcESTuEtoOkMV08kP1VoXKX3CKPuZmxvJwLh1+w?=
 =?us-ascii?Q?BscCHtHOIfCPteSdUw41+sp16ndvZToJDe6e75f4A7Eob5oCNJQkRsX7E3XY?=
 =?us-ascii?Q?E86L/fBHA2t3uEto9usn9d5gt00UiO3TSnNhkJvMLp0Bp6G/jl6jDzvqF4OC?=
 =?us-ascii?Q?MMEr3Sgxy28ZnncMTB1GddjGXsUbOTrn5jkjugXVC2AhQMFweg5Bk/wxXtfv?=
 =?us-ascii?Q?4YrrKJU9Jv9U2U29XWkvAGBgRzEXyeP9j4jia4DKTsn3MMQ41XKSTNR9b/h/?=
 =?us-ascii?Q?d8sI5uHG0uhRV9m9MQGkhV4J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 188bd990-3eab-428e-6915-08d95e7bf50c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 17:01:13.6319 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PTzgG9RxmIifR+f4OJlJeU+tWLiwP7ME3scsXw9ZyFKn+HbF1xNxXM8CnfIyE/OwbbbtUxCiEirtYUwpFyeApg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5247
Cc: Andi Kleen <ak@linux.intel.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Joerg Roedel <jroedel@suse.de>, Brijesh Singh <brijesh.singh@amd.com>,
 Thomas Gleixner <tglx@linutronix.de>
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
From: Tom Lendacky via iommu <iommu@lists.linux-foundation.org>
Reply-To: Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

The mem_encrypt_active() function has been replaced by prot_guest_has(),
so remove the implementation.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Reviewed-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/include/asm/mem_encrypt.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 797146e0cd6b..94c089e9ea69 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -97,11 +97,6 @@ static inline void mem_encrypt_free_decrypted_mem(void) { }
 
 extern char __start_bss_decrypted[], __end_bss_decrypted[], __start_bss_decrypted_unused[];
 
-static inline bool mem_encrypt_active(void)
-{
-	return sme_me_mask;
-}
-
 static inline u64 sme_get_me_mask(void)
 {
 	return sme_me_mask;
-- 
2.32.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
