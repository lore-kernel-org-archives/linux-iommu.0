Return-Path: <SRS0=mUms=NC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9869AC4338F
	for <iommu@archiver.kernel.org>; Wed, 11 Aug 2021 15:53:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E11E60FC3
	for <iommu@archiver.kernel.org>; Wed, 11 Aug 2021 15:53:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2E11E60FC3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E05E460864;
	Wed, 11 Aug 2021 15:53:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zcs-lQQP3h1q; Wed, 11 Aug 2021 15:53:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8FFD660847;
	Wed, 11 Aug 2021 15:53:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67599C0010;
	Wed, 11 Aug 2021 15:53:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 47712C000E
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 15:53:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2708D83AF4
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 15:53:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NRaJdIdNtbLK for <iommu@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 15:53:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2086.outbound.protection.outlook.com [40.107.101.86])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 44AEE83AEF
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 15:53:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVxXJjaHSdRiohwAE+8zNVbsf3D54dQHusnRJVSSwi4FlpEM6/7A8MLTjQ8ByxSEs8bNYlvTx8hmaWEVY/PCx06TI7GboiiErn4WKFLfuFaOENpCcCoKbgDEBNyP+4K6TkJWZKtdZweUNlb5x2vfuYb8afG0nN2PebS9PhOLj3Bu35Mo65vXIlY76mNIPmZ+V1JivRGDt3ANe1vcYFb14gyJEdwPnbpsKFcHFuzptTMh9gU8rJJXNhYjl4l/puSwUuDPsDr1ZOSmqsJbB7QJPr0J6ZP6BDDixl29W90sgSn96S/iLiQ46pk1n+fKxuPiIngydBdw4ZBLWUHoIRcijg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C49rqTyfz3/bdpRcw7lWMxc9BXCwJJccswQylOwMjKA=;
 b=RAqKTMcfArEHEAUu7QneQjF7TcJn1x6wgtwcpOT/7iy8vqK6M9LMcD8R60lIieMP33wo9ZCzC87YbWZo7klVfW2fzaNraEIE7pFfm8MBO5TNLEpQ3cPZz5MSDNRPzxstu27UnhRB9lrlVGNDxRZqof7ndWT05vKzKhkWgPA7DAVvwHe6FEfPWwfQMareaJD+J/5mps/q+/uxVzGUfjutgkbde6i3wK6gg8IZ2L4tqIaPzdJehcnPvjMzi+8tqc0I4FHkoVUUOm4z0/cfkr8Y6PRAvjlAYPuKAA9NKLB7qdKgGRjB961IQpj5WE+8YKu2n49OL0xYEL7BZC6OxSF4wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C49rqTyfz3/bdpRcw7lWMxc9BXCwJJccswQylOwMjKA=;
 b=0L7NJW1lPcU0elmdj23auZMGESKK2ZOB1uoaFPWc5tkKmv26YZw3humrz816GR/KZ4Mnzjr4NswnpH22OuGrGFsFjX1CDWEcvq6LemIppHbCds9P1Jl74AzeylVmzMiKYwklN43zkQaRRMp+GivmZuKXEvk7g+ELQJMP6PfUs+8=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM8PR12MB5431.namprd12.prod.outlook.com (2603:10b6:8:34::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.16; Wed, 11 Aug 2021 15:52:58 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418%6]) with mapi id 15.20.4415.016; Wed, 11 Aug 2021
 15:52:58 +0000
Subject: Re: [PATCH 07/11] treewide: Replace the use of mem_encrypt_active()
 with prot_guest_has()
To: "Kirill A. Shutemov" <kirill@shutemov.name>
References: <cover.1627424773.git.thomas.lendacky@amd.com>
 <029791b24c6412f9427cfe6ec598156c64395964.1627424774.git.thomas.lendacky@amd.com>
 <166f30d8-9abb-02de-70d8-6e97f44f85df@linux.intel.com>
 <4b885c52-f70a-147e-86bd-c71a8f4ef564@amd.com>
 <20210811121917.ghxi7g4mctuybhbk@box.shutemov.name>
Message-ID: <0a819549-e481-c004-7da8-82ba427b13ce@amd.com>
Date: Wed, 11 Aug 2021 10:52:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210811121917.ghxi7g4mctuybhbk@box.shutemov.name>
Content-Language: en-US
X-ClientProxiedBy: SN1PR12CA0061.namprd12.prod.outlook.com
 (2603:10b6:802:20::32) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.241] (165.204.77.1) by
 SN1PR12CA0061.namprd12.prod.outlook.com (2603:10b6:802:20::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.16 via Frontend Transport; Wed, 11 Aug 2021 15:52:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e687563-770c-45e3-d65c-08d95ce0175c
X-MS-TrafficTypeDiagnostic: DM8PR12MB5431:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB543199BEF36F29E3840ABFD6ECF89@DM8PR12MB5431.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lIs6pFyzfEbI1sSDg110Vyq4ekjEacZhpksNjWqlRVa3iscvvqsWl0yYG/1eyCmYp76Raq8v57Gb/CVJw3Azw8HEQVoEaq5Thx2vbGcOq+o252Owo5UvK6qWL25Zrxi8PuOD3hkirYlIuN16HwHgscJSl1gkfhWWJ+tgIjOCuy9IPlRr/w0GuiLta5pf3Pa5xgeet6tYJ4Bl0qidOz5Dg/DeXaiHaslXYoShv4gf36GqOZjt7OVBHL0CcUKLLE5BX9vEjcLs9L8xzJ3LIZNbgD6sF4TiQc1NVgI2If0QT0apr4XF7PVFWbuBKbMWORwiq/k3DVPSMmRvQJ0Sj4ajUMUfiYed3phlTw0ma14v/MLar3DXPEMPkoraDDkVTFqJCmqlLNaCMiJ7KWn4G7ABOiaOw/PtDkREBrgfp7y1pXpmiTAxJ37f8nv7FTSaIqwOQYle7zjdxABeFkOUGiKVWHAIV3VwjsPtva/gytPiDXBngieb9pNTfqjqslUcpbquE5VNNfzrQpo/mAUPWTCW7/Hu8mXZISL0/1jRU1di2XEp2fpD8BMclqx6M8wtgBunrnc/I0MFR3YU0rkTsHRNeKbOzP5toHxiiXBWgQ3YTYCUDO+cUAajBP/GCFAyXDaEU46ApzPiWI8GMXC3jj1A8O5dVEWbP8I9AF4Irnk5vptD4uwvHRigvbpgHaUrIYn47H+vNKBD29pKWeFXdsPc2Ndusema059/N0MezM6QHA4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5229.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(26005)(2616005)(66476007)(66556008)(478600001)(38100700002)(186003)(66946007)(36756003)(54906003)(31696002)(6486002)(8676002)(8936002)(7406005)(4326008)(316002)(6916009)(2906002)(86362001)(7416002)(5660300002)(31686004)(83380400001)(956004)(53546011)(16576012)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REY0eis4c2JROTJ4U0pDcCs5UWZGaVA1c2RGRkNPVm1JakVBWHRjRUt0aWpO?=
 =?utf-8?B?RHBlQkppQklNUWJVSEptUWtuc0xLaDlDRW13TUhlWjdBRDd2T29YQWZxOUNx?=
 =?utf-8?B?d2Q5VlBTYzVYVWYxMUd1eTlpajIyUlJqdlluL0pFMW8veDg0YlNqZDkvUGh0?=
 =?utf-8?B?S2d4aHFCS3pMUDJPS2trYitORnRkNTJ0ZWZrV3ZUR3FVcXBZUWVwcjV0djYw?=
 =?utf-8?B?M1dvRWxodmZOeGhXak1ZYXgyMms1YjZUUDMvbFNxeFRkY0NsUC8vNDVGMDA2?=
 =?utf-8?B?TjhaYnRvUUhnZEcvbkh5RHl0Y2N5L1pQZ0IzNzZLYTBDeEdHNXVueWJIQzRx?=
 =?utf-8?B?a1lFd1h0QnVnM0h2SC9HTFpZMXorMnZtNkdKZHREb0dFbzZyZXNOd29vVkx4?=
 =?utf-8?B?ZTFpTVgwV2NKcU50bTFsbjlJT1UwMTFsdnZlYkw1QzJrQ3YxTm96ZHZXZk5E?=
 =?utf-8?B?bU93UThGNmwzVGRGdFFiTURIS2xBcTJkQ1MwOUlTSGwwbDZIU0QrTzBHZVBx?=
 =?utf-8?B?WmhDZVZ3ZlNLcGt1Ujdsd0VRd0RwQVFHdjBIL09vOGtGMHZiMHpNNnVQc2Z3?=
 =?utf-8?B?R0NFVi9XVDNqWHlja01PMVdSdjA4cWVEVWtJKzdpV2JkUzJOZURRSmNTbnA3?=
 =?utf-8?B?RlVlT0xpQ2FNRkpQUUhNMHUyRHkrcENpSk55LzFWTTEzMGxQSlRNL3dBYVl1?=
 =?utf-8?B?ZjZTY09yb1AwMXI3T3dMT1lnakhscUVkYXl3WUNZOEJ4c3NFUjhMbDdKTE11?=
 =?utf-8?B?YU1oT1FVaGZiNGUvL29nRzM0RWE1Ujl5RXpwL2VwRVJtczl3Q2xLQldwdlQ0?=
 =?utf-8?B?L0wwU25xQjQ2NUVubDVZbUZIRUpUUks2MUUrKzBWZ1Vzak1KYk04V3hybTZM?=
 =?utf-8?B?RXZEQnNhMmtXTHE4Sm1LVjFlT3J2UFFuYVVGVXRxS3R4MUQzeHdLdGZYQk5F?=
 =?utf-8?B?YUk4ZFRaVUJVKzBCS0xTek56YzZRVzMrbndMb0RNYituWUZWMlJVZFc5bW00?=
 =?utf-8?B?WFBDRTJzMGZ1K0Vka0FxRng3QURCSjFLVkhoczF4dElOWWFrdjdUVm5Uekox?=
 =?utf-8?B?Sm5tbmRXUDNSUmdRWHNKdTNIS1ZhUDdCOS8zS2d5dlpSNzJ2Y2JYR2czdTFU?=
 =?utf-8?B?KytSTHByeEtQVEhtVXZHcFN4STQyaXRzbmFqSnYzbFdMeGVCdjgyd2VIOU1H?=
 =?utf-8?B?cjJJVjVXZUZCeWRTcnM3TFVHZHloYkRCQXFKcTBrTEtqbUtGeEMxYWl1YzlE?=
 =?utf-8?B?bUdocE55ZERNRGNXc2s2eGFxTVNaZEhEaldVbkRNMkZVODB5NjlHM1FKOEJ1?=
 =?utf-8?B?dDZ5eGpMMUFaOWZWV2NsMWRPMkhUN1Y3ZHZpNHdKcEVNZXVZRzM1UFhpcTQx?=
 =?utf-8?B?SFlhbUhOZGsvTmRoK2paWWZpUkNOSVl2T0JoUUxkMGlYUFlrV3dkcGw2VDZC?=
 =?utf-8?B?b0kxN2p5TUx4SVJIQmFxWnpmaURudU9RaU1MZW1uY1BqSitLR1FoZUtud0NC?=
 =?utf-8?B?Zkc2d1UvLzZ5YnZBQlhrem9iVnVOWkVMV3BTTmJTY01qdkxMNXRrYTVNMDhK?=
 =?utf-8?B?NHBMZGdWQU96b3pIamxYMGE0bk4wUjdTS1RiR2dnbTMyU3JpdXZlMS8wcTNa?=
 =?utf-8?B?Ykk3NGYvaFFEb1ROUTV2YUhsVDYxWUJhTkxBc2NWdEF6QXNxaTBoSXovSnEy?=
 =?utf-8?B?RkN6Y1ZCUEJTcTNOdmV6ZXRhZ3lGTlJUSUh6K0dwK3lrUnkxcENHZUpYY2s1?=
 =?utf-8?Q?ypRlcF5FeAfEhWsnoICXRzLomNBmaC1bm+lcTDj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e687563-770c-45e3-d65c-08d95ce0175c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2021 15:52:58.7420 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 584esTti7o/5qkD1Os1NRjUfCdW4Sj5anUfUsR50eGnvfwGD5aGvUGjrOq3sJcZZ9e+qkr0NVlAYoU1YOAdy5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5431
Cc: linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>,
 kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, dri-devel@lists.freedesktop.org,
 platform-driver-x86@vger.kernel.org, Will Deacon <will@kernel.org>,
 linux-s390@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
 amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
 Ingo Molnar <mingo@redhat.com>, linux-graphics-maintainer@vmware.com,
 Dave Young <dyoung@redhat.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Daniel Vetter <daniel@ffwll.ch>,
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gOC8xMS8yMSA3OjE5IEFNLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3JvdGU6Cj4gT24gVHVlLCBB
dWcgMTAsIDIwMjEgYXQgMDI6NDg6NTRQTSAtMDUwMCwgVG9tIExlbmRhY2t5IHdyb3RlOgo+PiBP
biA4LzEwLzIxIDE6NDUgUE0sIEt1cHB1c3dhbXksIFNhdGh5YW5hcmF5YW5hbiB3cm90ZToKPj4+
Cj4+Pgo+Pj4gT24gNy8yNy8yMSAzOjI2IFBNLCBUb20gTGVuZGFja3kgd3JvdGU6Cj4+Pj4gZGlm
ZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9oZWFkNjQuYyBiL2FyY2gveDg2L2tlcm5lbC9oZWFk
NjQuYwo+Pj4+IGluZGV4IGRlMDE5MDNjMzczNS4uY2FmZWQ2NDU2ZDQ1IDEwMDY0NAo+Pj4+IC0t
LSBhL2FyY2gveDg2L2tlcm5lbC9oZWFkNjQuYwo+Pj4+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9o
ZWFkNjQuYwo+Pj4+IEBAIC0xOSw3ICsxOSw3IEBACj4+Pj4gwqAgI2luY2x1ZGUgPGxpbnV4L3N0
YXJ0X2tlcm5lbC5oPgo+Pj4+IMKgICNpbmNsdWRlIDxsaW51eC9pby5oPgo+Pj4+IMKgICNpbmNs
dWRlIDxsaW51eC9tZW1ibG9jay5oPgo+Pj4+IC0jaW5jbHVkZSA8bGludXgvbWVtX2VuY3J5cHQu
aD4KPj4+PiArI2luY2x1ZGUgPGxpbnV4L3Byb3RlY3RlZF9ndWVzdC5oPgo+Pj4+IMKgICNpbmNs
dWRlIDxsaW51eC9wZ3RhYmxlLmg+Cj4+Pj4gwqAgwqAgI2luY2x1ZGUgPGFzbS9wcm9jZXNzb3Iu
aD4KPj4+PiBAQCAtMjg1LDcgKzI4NSw3IEBAIHVuc2lnbmVkIGxvbmcgX19oZWFkIF9fc3RhcnR1
cF82NCh1bnNpZ25lZCBsb25nCj4+Pj4gcGh5c2FkZHIsCj4+Pj4gwqDCoMKgwqDCoMKgICogdGhl
cmUgaXMgbm8gbmVlZCB0byB6ZXJvIGl0IGFmdGVyIGNoYW5naW5nIHRoZSBtZW1vcnkgZW5jcnlw
dGlvbgo+Pj4+IMKgwqDCoMKgwqDCoCAqIGF0dHJpYnV0ZS4KPj4+PiDCoMKgwqDCoMKgwqAgKi8K
Pj4+PiAtwqDCoMKgIGlmIChtZW1fZW5jcnlwdF9hY3RpdmUoKSkgewo+Pj4+ICvCoMKgwqAgaWYg
KHByb3RfZ3Vlc3RfaGFzKFBBVFRSX01FTV9FTkNSWVBUKSkgewo+Pj4+IMKgwqDCoMKgwqDCoMKg
wqDCoCB2YWRkciA9ICh1bnNpZ25lZCBsb25nKV9fc3RhcnRfYnNzX2RlY3J5cHRlZDsKPj4+PiDC
oMKgwqDCoMKgwqDCoMKgwqAgdmFkZHJfZW5kID0gKHVuc2lnbmVkIGxvbmcpX19lbmRfYnNzX2Rl
Y3J5cHRlZDsKPj4+Cj4+Pgo+Pj4gU2luY2UgdGhpcyBjaGFuZ2UgaXMgc3BlY2lmaWMgdG8gQU1E
LCBjYW4geW91IHJlcGxhY2UgUEFUVFJfTUVNX0VOQ1JZUFQgd2l0aAo+Pj4gcHJvdF9ndWVzdF9o
YXMoUEFUVFJfU01FKSB8fCBwcm90X2d1ZXN0X2hhcyhQQVRUUl9TRVYpLiBJdCBpcyBub3QgdXNl
ZCBpbgo+Pj4gVERYLgo+Pgo+PiBUaGlzIGlzIGEgZGlyZWN0IHJlcGxhY2VtZW50IGZvciBub3cu
Cj4gCj4gV2l0aCBjdXJyZW50IGltcGxlbWVudGF0aW9uIG9mIHByb3RfZ3Vlc3RfaGFzKCkgZm9y
IFREWCBpdCBicmVha3MgYm9vdCBmb3IKPiBtZS4KPiAKPiBMb29raW5nIGF0IGNvZGUgYWdhaW5z
LCBub3cgSSAqdGhpbmsqIHRoZSByZWFzb24gaXMgYWNjZXNzaW5nIGEgZ2xvYmFsCj4gdmFyaWFi
bGUgZnJvbSBfX3N0YXJ0dXBfNjQoKSBpbnNpZGUgVERYIHZlcnNpb24gb2YgcHJvdF9ndWVzdF9o
YXMoKS4KPiAKPiBfX3N0YXJ0dXBfNjQoKSBpcyBzcGVjaWFsLiBJZiB5b3UgYWNjZXNzIGFueSBn
bG9iYWwgdmFyaWFibGUgeW91IG5lZWQgdG8KPiB1c2UgZml4dXBfcG9pbnRlcigpLiBTZWUgY29t
bWVudCBiZWZvcmUgX19zdGFydHVwXzY0KCkuCj4gCj4gSSdtIG5vdCBzdXJlIGhvdyB5b3UgZ2V0
IGF3YXkgd2l0aCBhY2Nlc3Npbmcgc21lX21lX21hc2sgZGlyZWN0bHkgZnJvbQo+IHRoZXJlLiBB
bnkgY2x1ZXM/IE1heWJlIGp1c3QgYSBsdWNrIGFuZCBjb21wbGllciBnZW5lcmF0ZXMgY29kZSBq
dXN0IHJpZ2h0Cj4gZm9yIHlvdXIgY2FzZSwgSSBkb25uby4KCkhtbS4uLiB5ZWFoLCBjb3VsZCBi
ZSB0aGF0IHRoZSBjb21waWxlciBpcyB1c2luZyByaXAtcmVsYXRpdmUgYWRkcmVzc2luZwpmb3Ig
aXQgYmVjYXVzZSBpdCBsaXZlcyBpbiB0aGUgLmRhdGEgc2VjdGlvbj8KCkZvciB0aGUgc3RhdGlj
IHZhcmlhYmxlcyBpbiBtZW1fZW5jcnlwdF9pZGVudGl0eS5jIEkgZGlkIGFuIGFzc2VtYmxlciBy
aXAKcmVsYXRpdmUgTEVBLCBidXQgcHJvYmFibHkgY291bGQgaGF2ZSBwYXNzZWQgcGh5c2FkZHIg
dG8gc21lX2VuYWJsZSgpIGFuZAp1c2VkIGEgZml4dXBfcG9pbnRlcigpIHN0eWxlIGZ1bmN0aW9u
LCBpbnN0ZWFkLgoKPiAKPiBBIHNlcGFyYXRlIHBvaW50IGlzIHRoYXQgVERYIHZlcnNpb24gb2Yg
cHJvdF9ndWVzdF9oYXMoKSByZWxpZXMgb24KPiBjcHVfZmVhdHVyZV9lbmFibGVkKCkgd2hpY2gg
aXMgbm90IHJlYWR5IGF0IHRoaXMgcG9pbnQuCgpEb2VzIFREWCBoYXZlIHRvIGRvIGFueXRoaW5n
IHNwZWNpYWwgdG8gbWFrZSBtZW1vcnkgYWJsZSB0byBiZSBzaGFyZWQgd2l0aAp0aGUgaHlwZXJ2
aXNvcj8gIFlvdSBtaWdodCBoYXZlIHRvIHVzZSBzb21ldGhpbmcgdGhhdCBpcyBhdmFpbGFibGUg
ZWFybGllcgp0aGFuIGNwdV9mZWF0dXJlX2VuYWJsZWQoKSBpbiB0aGF0IGNhc2UgKHNob3VsZCB5
b3UgZXZlbnR1YWxseSBzdXBwb3J0Cmt2bWNsb2NrKS4KCj4gCj4gSSB0aGluayBfX2Jzc19kZWNy
eXB0ZWQgZml4dXAgaGFzIHRvIGJlIGRvbmUgaWYgc21lX21lX21hc2sgaXMgbm9uLXplcm8uCj4g
T3IganVzdCBkbyBpdCB1bmNvZGl0aW9uYWxseSBiZWNhdXNlIGl0J3MgTk9QIGZvciBzbWVfbWVf
bWFzayA9PSAwLgoKRm9yIFNOUCwgd2UnbGwgaGF2ZSB0byBhZGRpdGlvbmFsbHkgY2FsbCB0aGUg
SFYgdG8gdXBkYXRlIHRoZSBSTVAgdG8gbWFrZQp0aGUgbWVtb3J5IHNoYXJlZC4gQnV0IHRoYXQg
Y291bGQgYWxzbyBiZSBkb25lIHVuY29uZGl0aW9uYWxseSBzaW5jZSB0aGUKZWFybHlfc25wX3Nl
dF9tZW1vcnlfc2hhcmVkKCkgcm91dGluZSB3aWxsIGNoZWNrIGZvciBTTlAgYmVmb3JlIGRvaW5n
CmFueXRoaW5nLgoKVGhhbmtzLApUb20KCj4gCj4+IEkgdGhpbmsgdGhlIGNoYW5nZSB5b3UncmUg
cmVxdWVzdGluZwo+PiBzaG91bGQgYmUgZG9uZSBhcyBwYXJ0IG9mIHRoZSBURFggc3VwcG9ydCBw
YXRjaGVzIHNvIGl0J3MgY2xlYXIgd2h5IGl0IGlzCj4+IGJlaW5nIGNoYW5nZWQuCj4+Cj4+IEJ1
dCwgd291bGRuJ3QgVERYIHN0aWxsIG5lZWQgdG8gZG8gc29tZXRoaW5nIHdpdGggdGhpcyBzaGFy
ZWQvdW5lbmNyeXB0ZWQKPj4gYXJlYSwgdGhvdWdoPyBPciBzaW5jZSBpdCBpcyBzaGFyZWQsIHRo
ZXJlJ3MgYWN0dWFsbHkgbm90aGluZyB5b3UgbmVlZCB0bwo+PiBkbyAodGhlIGJzcyBkZWNycHl0
ZWQgc2VjdGlvbiBleGlzdHMgZXZlbiBpZiBDT05GSUdfQU1EX01FTV9FTkNSWVBUIGlzIG5vdAo+
PiBjb25maWd1cmVkKT8KPiAKPiBBRkFJQ1MsIG9ubHkga3ZtY2xvY2sgdXNlcyBfX2Jzc19kZWNy
eXB0ZWQuIFdlIGRvbid0IGVuYWJsZSBrdm1jbG9jayBpbgo+IFREWCBhdCB0aGUgbW9tZW50LiBJ
dCBtYXkgY2hhbmdlIGluIHRoZSBmdXR1cmUuCj4gCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby9pb21tdQ==
