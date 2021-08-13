Return-Path: <SRS0=SLGw=NE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3371CC4320E
	for <iommu@archiver.kernel.org>; Fri, 13 Aug 2021 17:00:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E24F06112E
	for <iommu@archiver.kernel.org>; Fri, 13 Aug 2021 17:00:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E24F06112E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C29BB60BA8;
	Fri, 13 Aug 2021 17:00:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g690ccoVVWZo; Fri, 13 Aug 2021 17:00:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 79F6360BCA;
	Fri, 13 Aug 2021 17:00:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63C8EC001A;
	Fri, 13 Aug 2021 17:00:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AD9F7C000E
 for <iommu@lists.linux-foundation.org>; Fri, 13 Aug 2021 17:00:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8E881402D2
 for <iommu@lists.linux-foundation.org>; Fri, 13 Aug 2021 17:00:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nrXVQALEkzwL for <iommu@lists.linux-foundation.org>;
 Fri, 13 Aug 2021 17:00:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::612])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0806A4028A
 for <iommu@lists.linux-foundation.org>; Fri, 13 Aug 2021 17:00:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fnVVKSDUTq9Zx77/B3hb0bqVk2jOME4n7dEZ319TRm3LtI2ytMtWHd9Zsw2XmIFILOXeCT3p1Ei+KdXvoWITGlw0eHHnHLtYShsjr15BelK7Na/kwE1ExLCgNnDMDGsmgrc+GZKwKkrpo3SoFev5z/0PaTkRMA+v8Q2qI8dD8JOhe34+L0JcYlc7lvgyJmq9vkCOdQHMlN9WGAr4l8v+NHsmjtf8Yu2xL2B5F/R4fKEPIKQl666w1M+sAp9sCYWrnIFUp3jFrOUytQjRkAwDpWihHv5RoGJ7T6xwFlsAGX9dBZ2OUzlK+jSRoSNcajkxwdWSQOb9sefxEScEy9Uk4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbJsayd3esujUkeClICzAo+GhfoeY9yFc2WWh+yJzf4=;
 b=Zxnb0WZCKFJT1NrB14Zm5ck+BqWSk7g4wXy3DrCt6ad066LfG2WsHL+id7hrrxVZYU4Qdje+xDuajxtFVdI3s3/3rQNBi2VClsz6IkcIiPMO5OOuFUkERhzW+0c886OkhgbxthfA0GPG2i5QdqV6epMiumaCBVYmGTdD4G2FL1MrAkjUW+QoXbLNrKuvwOjsjN7OFBrga0Z7zJlaGKRzRVWD+aKSGwZL2YyBx2epqlboqc8ZBI0HF27fZByQ2V9+jElhz5KjtI1cgWQ0M7kD/tC4i2H2llXWML9nTz8Fbfsg5Q/K/0ytsGMUKQlhO+3b0wcodklB4Xu2cOjcq+20Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbJsayd3esujUkeClICzAo+GhfoeY9yFc2WWh+yJzf4=;
 b=189gDan4187+wg8jIlCEJGrRoMwGGS2O8AdTcwVmm4pQfbdXWPpjPJqB/OyKGFc+xv+2OdqGqrcbBa+nxX370058XVCUDrseRh1WevrGgovBQ/Vdd4ocIUUTogb/U257WoI/9ISOMKDfAkjt727OrvpEfmQ8KipSxpa9un80zXk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5341.namprd12.prod.outlook.com (2603:10b6:5:39e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Fri, 13 Aug
 2021 17:00:30 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418%6]) with mapi id 15.20.4415.019; Fri, 13 Aug 2021
 17:00:30 +0000
To: linux-kernel@vger.kernel.org, x86@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
 linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-graphics-maintainer@vmware.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, kexec@lists.infradead.org,
 linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 05/12] x86/sme: Replace occurrences of sme_active() with
 prot_guest_has()
Date: Fri, 13 Aug 2021 11:59:24 -0500
Message-Id: <c6c38d6253dc78381f9ff0f1823b6ee5ddeefacc.1628873970.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1628873970.git.thomas.lendacky@amd.com>
References: <cover.1628873970.git.thomas.lendacky@amd.com>
X-ClientProxiedBy: SA0PR12CA0001.namprd12.prod.outlook.com
 (2603:10b6:806:6f::6) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tlendack-t1.amd.com (165.204.77.1) by
 SA0PR12CA0001.namprd12.prod.outlook.com (2603:10b6:806:6f::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.14 via Frontend Transport; Fri, 13 Aug 2021 17:00:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 751ea128-7a31-4c68-2727-08d95e7bdafe
X-MS-TrafficTypeDiagnostic: DM4PR12MB5341:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB53417CDB86BEE18B417B6A43ECFA9@DM4PR12MB5341.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: goe8bZX4HkeHHdwe1g++kyc3dX9vCO3ayoqzqa0QDqC6LpUDi/cKX5ktozSgy85Ojd0aPFNz8BlKVUu1NljIG/YTYAOaEXPSG5erD+FwH/YzWZirDe7p5P1k6X2RYI5Ar8lyQAKWLhMU4wfaQWp5SxLGT2VL9QttTUqH7YKDTNgWMW6ecWespZrIblFS2Dn6KuIo9oDvFDrUxHRq/c7+d8xC85tbi2kf2J5eFnFZ2cBTo4mW7uRqAVr12VV2qgfjEGwUF7UXTNQWD5gdnqi/tfXI7NF4+HyWWpeOxePLVJyb8bnXCd3GGyxp4wt3wwSfynVu9zv9qE4b/fnVagVrfBT8UjLE9xDezQjWbwp6b6V7JihVfFwgfKq7lLk5fWZzLCBXjkHTA2dwfNbJocL3VEk7x58+8+Uh4cWD0Ib8FrSaU66BhIh9y6dTO4kZQcscy9LCYVOHJ2MDNkyv2UBsVpOBHIg71JOaG28Rq6IKMZJzHsupmrr+NRLLWnn+ighTEN9LJQQHgFlr9YnR7XDpHBZIf+g6ASld/zTKGI7+sePV2XG9Ng2RwLzynhuomqAsmEpfb4bAWewhbRoLoWWiLHe+2HpwrmNKFuVXV0mEOD9Ntg0RFt1Fj/vdMTuDpBHkjxcjti4SMKSGlTYBm/RhRuNHBYsR4VM1z/Yz8YUUJgkqGS9H5swNSsnm6Y7UhYvROyo+b9SeLsnJFubEPnSStkFVraXx096TM0hCF9pzgIM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5229.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(86362001)(8676002)(2616005)(5660300002)(6666004)(54906003)(36756003)(38100700002)(7696005)(38350700002)(921005)(52116002)(8936002)(2906002)(478600001)(83380400001)(4326008)(186003)(6486002)(7416002)(26005)(956004)(66476007)(66556008)(316002)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mNV9XDi/gVWtpABqzkWClOu+ZDTMK5kgZULs8ZTjjTQThevvFC8uK0smaX8I?=
 =?us-ascii?Q?1j1KgcAJZyZPeeHu7FviHoGlJdxlDUzQ4VRX55+3xgMYlv+DeYraO92wNQRu?=
 =?us-ascii?Q?2N/Q22ZTQBpWZaq7eTi+zAR/Tc7LzFvlSlFOJjl6/PXDUbOrBZ52peT1/XOn?=
 =?us-ascii?Q?DGgK5O8PVlYK0U5MOj5sS4pyVArmwlPN56E7ODxus1WI1SmPg59XgmN+AADr?=
 =?us-ascii?Q?KoIiHgZjVOVTpXwD9LSIC1dJiP8HGzxBAsa5SMeQlpP2dyrWGKgCEkVWj1et?=
 =?us-ascii?Q?OWD3BZvrdaesIAUFOteWlPzdENRkI9VGAOtYjh3cn3FMYjC9MISYwyiDnrom?=
 =?us-ascii?Q?+SGt/E7YzbRPphAWzoXZzUfmnghyANn3OF/hHsLM0pRLpRpdciyyr90BSeYe?=
 =?us-ascii?Q?pfnrJfwtEVkhXfCXJezSyD0JgzVp9I02Ag9KrKU4GSYQnbX/uhcil5+yEaMj?=
 =?us-ascii?Q?ODdZjGmzw2XCGVfeL61t7wf8Da66NiutdJadlv1SchcnjtOPiqEdWAJI+l1x?=
 =?us-ascii?Q?N0awyicwHPsE361v30qYNpgmDMBHVqi8yKiXdQmS9pE2C37LrRIlFxmRWzX4?=
 =?us-ascii?Q?2LEZA9TXN1tBk4o4hjL54y0XNMoLbO5wOB1fG5Ob/WebFMevmeWDin1KwcXj?=
 =?us-ascii?Q?5LChWEO14sB5MEkEPgF6agJdsUfi4+6+wuDcMhKG17+B9BYDL06mK5I6dQvn?=
 =?us-ascii?Q?4S9387mQzWHXcXRlhwDyk0Sz+KVhzPt8TnXwHdjGhOFzRfjs4tguYnlv6ROj?=
 =?us-ascii?Q?ksN+L5u5/0uMnt4RafG6s/Yh2jyk090YyoBln4Osr4AbE/S1lbI7DEP0OCy0?=
 =?us-ascii?Q?5dnVBrw/otYhTMLQwnY92Op4JEFzKVrUgzPfxTwjdYNFt9HakFFdllsb8WCU?=
 =?us-ascii?Q?SDsuz0BnSgvmcXIiINPegImRU0CdyjmN+84NqFvP6YG+P5Qgv8LAeqABodsM?=
 =?us-ascii?Q?ZnZ5pi67ieuIwQIz+asO/KPZucy29Jw0Qrb7WMCvSEGDYwuDxl654oI0vKS7?=
 =?us-ascii?Q?sUMBYz0YKKB/udFndZxF9RtadFWVKbKNKO9mdp1k3sz0Kg7yGPKa5miEYNAf?=
 =?us-ascii?Q?pv1fFrdupXIzkJBs6OxFzxJZevvCHIj953kBZUTANSIzwjM65srfJffU6Lch?=
 =?us-ascii?Q?4eGwt6sZFzi75N1xfPlcQEAzTzPX7E7PJycwR5s5Gqm7EhcrIEx+ynCQH4En?=
 =?us-ascii?Q?e9UtHCFA16tjSYxGbbOg1Q2oYIV5rUJg1MsqZfvH+sYf4BFePZNdq3NfBpur?=
 =?us-ascii?Q?7ILfF+hHIeyIfwjZshtBMKXm52bcVDAtWBdGMmw2DligERgQDnhxeiZzz+So?=
 =?us-ascii?Q?O+JJHGoMjHit4oRL7QhM0SfA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 751ea128-7a31-4c68-2727-08d95e7bdafe
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 17:00:29.8878 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Y0dqX8pqw3xJvEIJ8/VV1WUFy1n95nQYwfRjEBNbAURQk1xhrYE+Zkbc01KzYj3T6v5qk9DEkhFq+N4tShH0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5341
Cc: Andi Kleen <ak@linux.intel.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>,
 Joerg Roedel <jroedel@suse.de>, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Brijesh Singh <brijesh.singh@amd.com>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>
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

Replace occurrences of sme_active() with the more generic prot_guest_has()
using PATTR_HOST_MEM_ENCRYPT, except for in arch/x86/mm/mem_encrypt*.c
where PATTR_SME will be used. If future support is added for other memory
encryption technologies, the use of PATTR_HOST_MEM_ENCRYPT can be
updated, as required, to use PATTR_SME.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Reviewed-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/include/asm/kexec.h         |  2 +-
 arch/x86/include/asm/mem_encrypt.h   |  2 --
 arch/x86/kernel/machine_kexec_64.c   |  3 ++-
 arch/x86/kernel/pci-swiotlb.c        |  9 ++++-----
 arch/x86/kernel/relocate_kernel_64.S |  2 +-
 arch/x86/mm/ioremap.c                |  6 +++---
 arch/x86/mm/mem_encrypt.c            | 10 +++++-----
 arch/x86/mm/mem_encrypt_identity.c   |  3 ++-
 arch/x86/realmode/init.c             |  5 +++--
 drivers/iommu/amd/init.c             |  7 ++++---
 10 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 0a6e34b07017..11b7c06e2828 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -129,7 +129,7 @@ relocate_kernel(unsigned long indirection_page,
 		unsigned long page_list,
 		unsigned long start_address,
 		unsigned int preserve_context,
-		unsigned int sme_active);
+		unsigned int host_mem_enc_active);
 #endif
 
 #define ARCH_HAS_KIMAGE_ARCH
diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index a46d47662772..956338406cec 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -50,7 +50,6 @@ void __init mem_encrypt_free_decrypted_mem(void);
 void __init mem_encrypt_init(void);
 
 void __init sev_es_init_vc_handling(void);
-bool sme_active(void);
 bool sev_active(void);
 bool sev_es_active(void);
 bool amd_prot_guest_has(unsigned int attr);
@@ -76,7 +75,6 @@ static inline void __init sme_encrypt_kernel(struct boot_params *bp) { }
 static inline void __init sme_enable(struct boot_params *bp) { }
 
 static inline void sev_es_init_vc_handling(void) { }
-static inline bool sme_active(void) { return false; }
 static inline bool sev_active(void) { return false; }
 static inline bool sev_es_active(void) { return false; }
 static inline bool amd_prot_guest_has(unsigned int attr) { return false; }
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 131f30fdcfbd..8e7b517ad738 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -17,6 +17,7 @@
 #include <linux/suspend.h>
 #include <linux/vmalloc.h>
 #include <linux/efi.h>
+#include <linux/protected_guest.h>
 
 #include <asm/init.h>
 #include <asm/tlbflush.h>
@@ -358,7 +359,7 @@ void machine_kexec(struct kimage *image)
 				       (unsigned long)page_list,
 				       image->start,
 				       image->preserve_context,
-				       sme_active());
+				       prot_guest_has(PATTR_HOST_MEM_ENCRYPT));
 
 #ifdef CONFIG_KEXEC_JUMP
 	if (image->preserve_context)
diff --git a/arch/x86/kernel/pci-swiotlb.c b/arch/x86/kernel/pci-swiotlb.c
index c2cfa5e7c152..bd9a9cfbc9a2 100644
--- a/arch/x86/kernel/pci-swiotlb.c
+++ b/arch/x86/kernel/pci-swiotlb.c
@@ -6,7 +6,7 @@
 #include <linux/swiotlb.h>
 #include <linux/memblock.h>
 #include <linux/dma-direct.h>
-#include <linux/mem_encrypt.h>
+#include <linux/protected_guest.h>
 
 #include <asm/iommu.h>
 #include <asm/swiotlb.h>
@@ -45,11 +45,10 @@ int __init pci_swiotlb_detect_4gb(void)
 		swiotlb = 1;
 
 	/*
-	 * If SME is active then swiotlb will be set to 1 so that bounce
-	 * buffers are allocated and used for devices that do not support
-	 * the addressing range required for the encryption mask.
+	 * Set swiotlb to 1 so that bounce buffers are allocated and used for
+	 * devices that can't support DMA to encrypted memory.
 	 */
-	if (sme_active())
+	if (prot_guest_has(PATTR_HOST_MEM_ENCRYPT))
 		swiotlb = 1;
 
 	return swiotlb;
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index c53271aebb64..c8fe74a28143 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -47,7 +47,7 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	 * %rsi page_list
 	 * %rdx start address
 	 * %rcx preserve_context
-	 * %r8  sme_active
+	 * %r8  host_mem_enc_active
 	 */
 
 	/* Save the CPU context, used for jumping back */
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index ccff76cedd8f..583afd54c7e1 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -14,7 +14,7 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/mmiotrace.h>
-#include <linux/mem_encrypt.h>
+#include <linux/protected_guest.h>
 #include <linux/efi.h>
 #include <linux/pgtable.h>
 
@@ -703,7 +703,7 @@ bool arch_memremap_can_ram_remap(resource_size_t phys_addr, unsigned long size,
 	if (flags & MEMREMAP_DEC)
 		return false;
 
-	if (sme_active()) {
+	if (prot_guest_has(PATTR_HOST_MEM_ENCRYPT)) {
 		if (memremap_is_setup_data(phys_addr, size) ||
 		    memremap_is_efi_data(phys_addr, size))
 			return false;
@@ -729,7 +729,7 @@ pgprot_t __init early_memremap_pgprot_adjust(resource_size_t phys_addr,
 
 	encrypted_prot = true;
 
-	if (sme_active()) {
+	if (prot_guest_has(PATTR_HOST_MEM_ENCRYPT)) {
 		if (early_memremap_is_setup_data(phys_addr, size) ||
 		    memremap_is_efi_data(phys_addr, size))
 			encrypted_prot = false;
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index edc67ddf065d..5635ca9a1fbe 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -144,7 +144,7 @@ void __init sme_unmap_bootdata(char *real_mode_data)
 	struct boot_params *boot_data;
 	unsigned long cmdline_paddr;
 
-	if (!sme_active())
+	if (!amd_prot_guest_has(PATTR_SME))
 		return;
 
 	/* Get the command line address before unmapping the real_mode_data */
@@ -164,7 +164,7 @@ void __init sme_map_bootdata(char *real_mode_data)
 	struct boot_params *boot_data;
 	unsigned long cmdline_paddr;
 
-	if (!sme_active())
+	if (!amd_prot_guest_has(PATTR_SME))
 		return;
 
 	__sme_early_map_unmap_mem(real_mode_data, sizeof(boot_params), true);
@@ -378,7 +378,7 @@ bool sev_active(void)
 	return sev_status & MSR_AMD64_SEV_ENABLED;
 }
 
-bool sme_active(void)
+static bool sme_active(void)
 {
 	return sme_me_mask && !sev_active();
 }
@@ -428,7 +428,7 @@ bool force_dma_unencrypted(struct device *dev)
 	 * device does not support DMA to addresses that include the
 	 * encryption mask.
 	 */
-	if (sme_active()) {
+	if (amd_prot_guest_has(PATTR_SME)) {
 		u64 dma_enc_mask = DMA_BIT_MASK(__ffs64(sme_me_mask));
 		u64 dma_dev_mask = min_not_zero(dev->coherent_dma_mask,
 						dev->bus_dma_limit);
@@ -469,7 +469,7 @@ static void print_mem_encrypt_feature_info(void)
 	pr_info("AMD Memory Encryption Features active:");
 
 	/* Secure Memory Encryption */
-	if (sme_active()) {
+	if (amd_prot_guest_has(PATTR_SME)) {
 		/*
 		 * SME is mutually exclusive with any of the SEV
 		 * features below.
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 470b20208430..088c8ab7dcc1 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -30,6 +30,7 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/mem_encrypt.h>
+#include <linux/protected_guest.h>
 
 #include <asm/setup.h>
 #include <asm/sections.h>
@@ -287,7 +288,7 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
 	unsigned long pgtable_area_len;
 	unsigned long decrypted_base;
 
-	if (!sme_active())
+	if (!prot_guest_has(PATTR_SME))
 		return;
 
 	/*
diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index 6534c92d0f83..2109ae569c67 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -3,6 +3,7 @@
 #include <linux/slab.h>
 #include <linux/memblock.h>
 #include <linux/mem_encrypt.h>
+#include <linux/protected_guest.h>
 #include <linux/pgtable.h>
 
 #include <asm/set_memory.h>
@@ -44,7 +45,7 @@ void __init reserve_real_mode(void)
 static void sme_sev_setup_real_mode(struct trampoline_header *th)
 {
 #ifdef CONFIG_AMD_MEM_ENCRYPT
-	if (sme_active())
+	if (prot_guest_has(PATTR_HOST_MEM_ENCRYPT))
 		th->flags |= TH_FLAGS_SME_ACTIVE;
 
 	if (sev_es_active()) {
@@ -81,7 +82,7 @@ static void __init setup_real_mode(void)
 	 * decrypted memory in order to bring up other processors
 	 * successfully. This is not needed for SEV.
 	 */
-	if (sme_active())
+	if (prot_guest_has(PATTR_HOST_MEM_ENCRYPT))
 		set_memory_decrypted((unsigned long)base, size >> PAGE_SHIFT);
 
 	memcpy(base, real_mode_blob, size);
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 46280e6e1535..05e770e3e631 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -20,7 +20,7 @@
 #include <linux/amd-iommu.h>
 #include <linux/export.h>
 #include <linux/kmemleak.h>
-#include <linux/mem_encrypt.h>
+#include <linux/protected_guest.h>
 #include <asm/pci-direct.h>
 #include <asm/iommu.h>
 #include <asm/apic.h>
@@ -965,7 +965,7 @@ static bool copy_device_table(void)
 		pr_err("The address of old device table is above 4G, not trustworthy!\n");
 		return false;
 	}
-	old_devtb = (sme_active() && is_kdump_kernel())
+	old_devtb = (prot_guest_has(PATTR_HOST_MEM_ENCRYPT) && is_kdump_kernel())
 		    ? (__force void *)ioremap_encrypted(old_devtb_phys,
 							dev_table_size)
 		    : memremap(old_devtb_phys, dev_table_size, MEMREMAP_WB);
@@ -3022,7 +3022,8 @@ static int __init amd_iommu_init(void)
 
 static bool amd_iommu_sme_check(void)
 {
-	if (!sme_active() || (boot_cpu_data.x86 != 0x17))
+	if (!prot_guest_has(PATTR_HOST_MEM_ENCRYPT) ||
+	    (boot_cpu_data.x86 != 0x17))
 		return true;
 
 	/* For Fam17h, a specific level of support is required */
-- 
2.32.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
