Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D1CC433F5
	for <iommu@archiver.kernel.org>; Sun, 12 Dec 2021 23:28:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B814E42239;
	Sun, 12 Dec 2021 23:28:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0q5uQovI1QZ5; Sun, 12 Dec 2021 23:28:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7E81141EFF;
	Sun, 12 Dec 2021 23:28:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 47487C0012;
	Sun, 12 Dec 2021 23:28:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D6BADC0012
 for <iommu@lists.linux-foundation.org>; Sun, 12 Dec 2021 23:28:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AB84460EDE
 for <iommu@lists.linux-foundation.org>; Sun, 12 Dec 2021 23:28:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ukqs8ry4jDaP for <iommu@lists.linux-foundation.org>;
 Sun, 12 Dec 2021 23:28:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::631])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DD40F6078B
 for <iommu@lists.linux-foundation.org>; Sun, 12 Dec 2021 23:28:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8TkPhBPTzRjTgno7mafcpSY3HGcch+XSmGbUCxrN+Fb6ijkvsWs8UkustpQbNna+QcTASjwGhq1q2JGz5jG4D9idSrEx2dcj18JAtgaQ+yIyJCvm0ZcTBP2xCBWcQB3tl6KrMiIIjbQfv9LX9dDbZ7GxcSKZa+AIoYFL/hOI0i4w95LAX9fD3tMQtGtykKTZF1uyB+YgwAOzOoG7YlRuqlpVoC5NCpubK4EhyrBHpR92UAGqqFfVyM5N+J63gNYYdr5NFJRncYngobV/pm2PT6lpIEMXOMVQIfUyTZma6N2aplpsxuuf9SkOYcfEWAPL4RXPo7UtaDUD5zW/NrXXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zeJJo1tbQoO6wky1sCAjsOVnxXWiJ+2cWKF9ndw66Ec=;
 b=kEnmHNCrrOqPKdfcwsjaXav4fhZn3cbquG34flwNDuEaOO3relWd2YhynUx3eDX8oqinqBDyQb7Ur79cF6E6Ai9bs5/U9KsBEvfeVuUHCHS3gVuG+PL1ZEiCcu2LEqB+QTzTFcJDmpfkIwubC+BsgGuGZoB/18/Jq/aU9kp9l2kHKnHlgFWNb9Aotg/yLY1lgYhmI/N8MhVwU9TbMxqihwltnML4L79XK7Fonc5pgvjklXzppJaEDk10vO4rbXV7Q2RZMhs4d/K8ls2LWcwzZJV6un2xWvtcaiKBIbmflVDQHpVYTk4t+f3uKQgeso6PRLZphVRaxUkZ9k5g/SKYng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zeJJo1tbQoO6wky1sCAjsOVnxXWiJ+2cWKF9ndw66Ec=;
 b=AZ8PQoEKo99j3VBcsS1HHKdilP3FNkWASKScKmdbwLsvGg0PhyXsJcv4+pRRknD5jbLDIGpNw4OIHfMSDj79T8AFABPJlT6pdsc+S6RvdU57dKcf4liqB0DjWDUzh1WVUhyFKG4MfCV0IDNsZhvLGwC5yGhv0F0j2C7I28cr6RV7XHq16mAi6gayGK2IaYWKtjWzVP+wnh6JwaDQkAQYoMljIZ+kYnbcSmWeELny545Rda78ijnWRW/B+h1Nhe471XREsKr9eie3JzWQLf+yyZfZWA1KWZ2CcwJNnMxZqsJpdxxofoqrbFEo9FGWwR3aKAGdqL5Zw5d8XbmA8vyrtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5538.namprd12.prod.outlook.com (2603:10b6:208:1c9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Sun, 12 Dec
 2021 23:28:01 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%7]) with mapi id 15.20.4778.017; Sun, 12 Dec 2021
 23:28:01 +0000
Date: Sun, 12 Dec 2021 19:27:58 -0400
To: Mika =?utf-8?B?UGVudHRpbMOk?= <mika.penttila@nextfour.com>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Message-ID: <20211212232758.GL6385@nvidia.com>
References: <87k0go8432.ffs@tglx>
 <f4cc305b-a329-6d27-9fca-b74ebc9fa0c1@intel.com>
 <878rx480fk.ffs@tglx>
 <BN9PR11MB52765F2EF8420C60FD5945D18C709@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87sfv2yy19.ffs@tglx> <20211209162129.GS6385@nvidia.com>
 <878rwtzfh1.ffs@tglx> <20211209205835.GZ6385@nvidia.com>
 <BN9PR11MB5276599F467AD5EAC935A79E8C719@BN9PR11MB5276.namprd11.prod.outlook.com>
 <3f6d4bd7-8b60-1976-73a4-f5ef7f3dbf27@nextfour.com>
Content-Disposition: inline
In-Reply-To: <3f6d4bd7-8b60-1976-73a4-f5ef7f3dbf27@nextfour.com>
X-ClientProxiedBy: BY3PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::10) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16894ac3-9985-4889-e13a-08d9bdc709d8
X-MS-TrafficTypeDiagnostic: BL0PR12MB5538:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB55385843E582801961193810C2739@BL0PR12MB5538.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HNEOyrH5uPc6d0FYYVNRo36RDEOojF8VA9sT4SKq5SEDWuQcEmhj71LQqGt9qm5U9uU8/TzsktxQvpDq45729d5Dds/K7UaOOZZ1SQ8/SA+ilFL/71nNJCWuKGRZ2OFGOtcw4EmvR+98NzVJu+g2RFTn8IdyESvJUw28mHVlwaLLSjlv6d2Q2VymWe7tGoJjXZy1I5bP3NcXu7uGa/9rOGYM2+fnIn4/el3QDuB2+jNU11JHKpCBB9MmiLrzbNF8CJvshkbFvRLw1o+JbZYXTZf6ZaCpobyQ2D7tnJHAJ90w4y9lzInpfpBemUzors5M01DLehcKOyPr2KXeScHzOoF2R4SAhXz2mjrWQkoW3IeQRHoBBEQhzx4yse1cyG5sI7gjaHLMTNrkPZIPq3FsdelLXxdihmd+Ig0bHPDtC6qjtQ7deAU0Ef7liFibpxNuvU1EvbkN8F7zDpuyA6eXC8N6rKHvmiBDi3mHbF8RhOd3nDytNk4EGL7wjU4amrj+yl6IAf9TTpbcGtS/bAq24mixg+t8/iUc/Dmg8HNuuNq6nHW3nuDc0GJfAlSD9uf1Rft7/PQPMdWgkHh4yTBtJIcHzPR4u5fWb+rHn9vDen6UadztNogOy8QYAdMgNqRA4jJDgflrLqG7RLNJltAfzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6916009)(36756003)(316002)(4326008)(7416002)(5660300002)(54906003)(66946007)(8936002)(6666004)(66556008)(8676002)(1076003)(2906002)(66476007)(508600001)(33656002)(26005)(6486002)(38100700002)(83380400001)(186003)(6506007)(86362001)(2616005)(6512007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUdoZzhEU054L2xYZ0VJSm82WjNhaXNjZTRINlhZUHVtTmhqYlFWSVUzNWps?=
 =?utf-8?B?bVczL3Q3V0Q1d2tzeG92WWpRWVBld3p1M210UkN6ejV2aFhlWXViL3krN2o3?=
 =?utf-8?B?RFFYOWlHZlY2Nk1kYllWbDRYWjdJZnhPSENxd1E5RXJXYzdWWFFPMkw3aWU1?=
 =?utf-8?B?bDhxSnZwWmE0YS9nSHd6R2ppaFU0b3JISk53M3ZoSEtkYkFJenhJY3IzQ1dr?=
 =?utf-8?B?VDJkNVQ5QmJjaWFWRng5QXBlQXdQc25xV1M5c3R6RkR2UmY0bFJINEtHVW1K?=
 =?utf-8?B?anBoaUQzWEVETGZXblYrR2t0aWk4VUpxMU54ajhWelNZcFNkWDJHdWwwUTlE?=
 =?utf-8?B?QVV5bWFzQzhsVkJIV2FFS3hBTVFkSWVOdC9WZ2NBRE1CREFham9CTmxZQ2li?=
 =?utf-8?B?aTdtZGJnMXU2WmVPLytzenZ6b1liYlJTbWpwcm1mZjhib1U2YzR5YUVtVC9U?=
 =?utf-8?B?clVybkV2WWpiaWRPUHYwRXpmd2M0YkZLUitYazVXT2xKZ1ZkdUdOdU9vQy9K?=
 =?utf-8?B?eU9mOTQwKzlkL01yYXFMWlVCalVzVXN2NVU1WWpkdG0wTGpZNDBGbjZzVTU4?=
 =?utf-8?B?Q0dRSnpNZFc3bVRUZW9Ndm9TeG84MHVKOWdqL1dma1hOT0txejRqbUhGVUtl?=
 =?utf-8?B?c2pValR3T1Z3bStSbGFjbW93aGxzcHE4aFdpZjBEaEdlTVV2R29jSmY0MEVK?=
 =?utf-8?B?emlpekJCTkpsQWpXb1BwaFlpM2hQeE5yZGN2NUh1OHFoLyt2djl5eGcrdUdq?=
 =?utf-8?B?cm1SN2RQNExadWxSRGlIbkhyNDZIZVhvdzhLUWMwYU52TUlkdUdKNXNkVGRz?=
 =?utf-8?B?Yis1ZTV2SUIweUNiK1BWVVlFbDhmZ21RZy9Wc010eE9sV1VTMnlBcUovMzBt?=
 =?utf-8?B?bEowVXowcFVoSmhsZFYrQ2ErNWplNWEybGJjRTVIbGVkcHZ2cFREQUw4RUw5?=
 =?utf-8?B?emVDcWpwZjRHaFkxOTV2d2t5U21BUm9PM0p2UU8vMzNtdUlTUGtGeVJFaTBU?=
 =?utf-8?B?OVQ3UVc3emN2aXBjbUNldHl2ejIzQkZUejBHTk9rMG5ReTk2WjV4UFZvL09s?=
 =?utf-8?B?WjVrSGsyUWQvenBNOUwxQXhuU3YySS8zalRRNGNJbGZxdEY5R3BILzl1NllB?=
 =?utf-8?B?MVhnSytDVXJJWUVUM1BJUXhUQzZDa2pOZkxxSSswR2tpYzVtRTY5QkRsbUVX?=
 =?utf-8?B?WHBERkx2Zk5HU3pMc2JzWUpVakptQzFrUVpPYmpQTHJKUm1uQlNsQjlqdnNj?=
 =?utf-8?B?Vk03eWNEeWJmbjFhc1FjVkZ1MlE0ZjFIQ09UcGlzTk50L1IxVnBzSDlUejFM?=
 =?utf-8?B?WVFjZDQwTUFGWGlucm9TYndpNURnVGVxcHg1UHhPSUJMbWxhSUJZQW9jM1dU?=
 =?utf-8?B?cmxCdm85NmQrSTBHc1pPS3l0VklWYXdlbldnbCtKOFl3bnlXMlE2NEFGamlR?=
 =?utf-8?B?ZWIyM0hJYlhpdXdia3R3alRoTWpUN3E4aHVDSCtvNE1VMVM0KzZjQmE0bEVu?=
 =?utf-8?B?Y3MzcVZmaWJWR2E0a0Y3OGtIQmJRUFc2RFh6RmNxVTB6bm83M3QwMUtsc2NO?=
 =?utf-8?B?YkFoZ01DTWhYZWorV0FiQ3VpZ3VkRXRlSHhmNE9FNndzUEllREhReFVKM3dS?=
 =?utf-8?B?S3Q2T2ZYVWlOa3ZLQ3NZekVmbXc2RkNyV2ZIQVVBRFBBdGluUDB1cGNQUTEr?=
 =?utf-8?B?WDZsMExFV3ZocHlYWDBMeExINkJhVlVjSEN5QzNReHNFNzVsMWpPNFBTNEQ0?=
 =?utf-8?B?ZzduN1plbzFtTm1Ncm5JbnZNUkpwb01jYTNoL2cvUUN6ZlBmYWVoZTBWS1gz?=
 =?utf-8?B?ZElXelNvZjRGUEQvNUpkNytDQnpyS2duQzA4MmJUZXdFUU1mclgvbDk0VEV3?=
 =?utf-8?B?TlhGZHUwTTFIU0Q0ekhXeEN3RVlmeHRFVWpsYkVMQTZORFZDVDIwandJU2ZX?=
 =?utf-8?B?SlEwQmtCajExWGxscHh0WWlwOTR5eHloMC9lWFUrNDJrTkh1MGh2S0RlcXVw?=
 =?utf-8?B?RWdHN2lnS05XbVNZcWFjOEN2VUpZR1pIMkJOZnhrVUhieWhZYlhHNFlpRDFR?=
 =?utf-8?B?THRtSlFCcUZORnZTZVNRQVo5a3d5WS9SZ2s4VFUvWUlCY2o2MkF2K3NTSEVj?=
 =?utf-8?Q?/cDQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16894ac3-9985-4889-e13a-08d9bdc709d8
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2021 23:28:01.4423 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ax/OJ08AZALj2IHd774FgQp1WEUTVa4YFbpoHYNNoRLiHeKPzk0Rijm+++xZYSNr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5538
Cc: Allen Hubbe <allenbh@gmail.com>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "x86@kernel.org" <x86@kernel.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marc Zygnier <maz@kernel.org>,
 Heiko Carstens <hca@linux.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>, Joerg Roedel <jroedel@suse.de>,
 Bjorn Helgaas <helgaas@kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
 Thomas Gleixner <tglx@linutronix.de>, Logan Gunthorpe <logang@deltatee.com>,
 "Dey, Megha" <megha.dey@intel.com>
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
From: Jason Gunthorpe via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gU3VuLCBEZWMgMTIsIDIwMjEgYXQgMDg6NDQ6NDZBTSArMDIwMCwgTWlrYSBQZW50dGlsw6Qg
d3JvdGU6Cgo+ID4gLyoKPiA+ICAgKiBUaGUgTVNJWCBtYXBwYWJsZSBjYXBhYmlsaXR5IGluZm9y
bXMgdGhhdCBNU0lYIGRhdGEgb2YgYSBCQVIgY2FuIGJlIG1tYXBwZWQKPiA+ICAgKiB3aGljaCBh
bGxvd3MgZGlyZWN0IGFjY2VzcyB0byBub24tTVNJWCByZWdpc3RlcnMgd2hpY2ggaGFwcGVuZWQg
dG8gYmUgd2l0aGluCj4gPiAgICogdGhlIHNhbWUgc3lzdGVtIHBhZ2UuCj4gPiAgICoKPiA+ICAg
KiBFdmVuIHRob3VnaCB0aGUgdXNlcnNwYWNlIGdldHMgZGlyZWN0IGFjY2VzcyB0byB0aGUgTVNJ
WCBkYXRhLCB0aGUgZXhpc3RpbmcKPiA+ICAgKiBWRklPX0RFVklDRV9TRVRfSVJRUyBpbnRlcmZh
Y2UgbXVzdCBzdGlsbCBiZSB1c2VkIGZvciBNU0lYIGNvbmZpZ3VyYXRpb24uCj4gPiAgICovCj4g
PiAjZGVmaW5lIFZGSU9fUkVHSU9OX0lORk9fQ0FQX01TSVhfTUFQUEFCTEUgICAgICAzCj4gPiAK
PiA+IElJUkMgdGhpcyB3YXMgaW50cm9kdWNlZCBmb3IgUFBDIHdoZW4gYSBkZXZpY2UgaGFzIE1T
SS1YIGluIHRoZSBzYW1lIEJBUiBhcwo+ID4gb3RoZXIgTU1JTyByZWdpc3RlcnMuIFRyYXBwaW5n
IE1TSS1YIGxlYWRzIHRvIHBlcmZvcm1hbmNlIGRvd25ncmFkZSBvbgo+ID4gYWNjZXNzZXMgdG8g
YWRqYWNlbnQgcmVnaXN0ZXJzLiBNU0ktWCBjYW4gYmUgbWFwcGVkIGJ5IHVzZXJzcGFjZSBiZWNh
dXNlCj4gPiBQUEMgYWxyZWFkeSB1c2VzIGEgaHlwZXJjYWxsIG1lY2hhbmlzbSBmb3IgaW50ZXJy
dXB0LiBUaG91Z2ggdW5jbGVhciBhYm91dAo+ID4gdGhlIGRldGFpbCBpdCBzb3VuZHMgYSBzaW1p
bGFyIHVzYWdlIGFzIHByb3Bvc2VkIGhlcmUuCj4gPiAKPiA+IFRoYW5rcwo+ID4gS2V2aW4KPgo+
IEkgc2VlwqAgVkZJT19SRUdJT05fSU5GT19DQVBfTVNJWF9NQVBQQUJMRSBpcyBhbHdheXMgc2V0
IHNvIGlmIG1zaXggdGFibGUgaXMKPiBpbiBpdHMgb3duIGJhciwgcWVtdSBuZXZlciB0cmFwcy9l
bXVsYXRlcyB0aGUgYWNjZXNzLiAKCkl0IGlzIHNvbWUgYmFja3dhcmRzIGNvbXBhdCwgdGhlIGtl
cm5lbCBhbHdheXMgc2V0cyBpdCB0byBpbmRpY2F0ZSBhCm5ldyBrZXJuZWwsIHRoYXQgZG9lc24n
dCBtZWFuIHFlbXUgZG9lc24ndCB0cmFwLgoKQXMgdGhlIGNvbW1lbnQgc2F5cywgIiJWRklPX0RF
VklDRV9TRVRfSVJRUyBpbnRlcmZhY2UgbXVzdCBzdGlsbCBiZQp1c2VkIGZvciBNU0lYIGNvbmZp
Z3VyYXRpb24iIiBzbyB0aGVyZSBpcyBubyB3YXkgcWVtdSBjYW4gbWVldCB0aGF0CndpdGhvdXQg
ZWl0aGVyIHRyYXBwaW5nIHRoZSBNU0kgcGFnZSBvciB1c2luZyBhIHNwZWNpYWwgaHlwZXJjYWxs
CihwcGMpCgpKYXNvbgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
