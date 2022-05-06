Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D81C433EF
	for <iommu@archiver.kernel.org>; Fri,  6 May 2022 13:54:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1629E40291;
	Fri,  6 May 2022 13:54:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2RRpy5M4usNC; Fri,  6 May 2022 13:54:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F2F8F40025;
	Fri,  6 May 2022 13:54:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4B09C0039;
	Fri,  6 May 2022 13:54:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E45EAC002D
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 13:54:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C480C83265
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 13:54:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sfJYDpEWloMA for <iommu@lists.linux-foundation.org>;
 Fri,  6 May 2022 13:54:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::628])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B527382D75
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 13:54:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X4A/VQqzAFFbNb8iOi7ow1oNwyzhOIHSblOh6glWvl5vlhBaGgOp1zrbWUCXWOPu8G1awmIs3Dq6MedUMtbU/W0pznyrPH5uxSx8eLQmvikbKsioFZfGGPnU3+uI7xnd6S02vW8aQRUAoHUwv6cfsVOVv62lxC/P6g6PqG+vbv1hDRGD7G07cZ1mKNSZBn65Gohsa0GvUWBQVxvVdQ+K5Nvz/A54XYJspp3PJ5kSwD2JKvjIltPsYrSc/KdMwVLN/fUgoR7IG902ffl5283t37gNTg4sqDtsDaOqj9nth/JADTTwK5HehKBcOhQNbwB2ue3a8UIT/GnA0ExxBDEJpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hv5Ad3WPtbM1Qjvgs8CUUL+kNnTS3z64iAr18fKKI1k=;
 b=j+GvEQDJH9NFjARSTXnSOJHH9Uu0Aa2drFUJbsPo82W1WqQSsKrI4+gYIMHnp0VUTX7GjGIgoDee39V4I8+4+SQW4aRmNBtUdzYv7MgPiuSIvrNYexOyPY6nrqeyxWM3sW5Flgvnpg4qEWWf+HiuFpnREzP8MzNgj+T44tZhkI44u6C+WwB5sbEZT6kn0GE6IXEYRtNU2LHUS2eny2QKlF4Huv8D7GSFpmMyxVLddp2BJvzBaIa+fdokrkrvxsZdutUxddMd8GWvv7mjD0EMZ7KmK/zbdQPR+cLEZ1J3o3qVw9XZKz8ct1fI3LF1OSirzWIy64KXL8CceMGftzZsPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hv5Ad3WPtbM1Qjvgs8CUUL+kNnTS3z64iAr18fKKI1k=;
 b=YPZ3mMIsWI7uyGt/nd9gRtC5Uf9T1HMLEJ3gBYPC17VGLjh2DkyLtTVKTQdxjLOQ2hN35u5A3gfRbAGeDhXAjOBBlQnaCJjd0FBoncc2D6e/gRL0P/cigoSfm1eJY9JpZm5pz05JfQXAIw25/Lm2T70wBQk8+sJa7u+Q7HzarJu+iNDT71xZvEDceoneqYBMykLWf932VkAaSrMculuJM9qeL2dwID7aDoke19F0wlSgKGOcVNjG90rHC4gx+g4rtls2D/xrZyE4p3KuSKWeMQ3w2uUyfhRJFt4ICBB1qLjBl4cFaUQY8SRaWtryRJjFeQqyvHi21lbxl0KxpuucfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN8PR12MB3604.namprd12.prod.outlook.com (2603:10b6:408:45::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Fri, 6 May
 2022 13:54:32 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%6]) with mapi id 15.20.5206.028; Fri, 6 May 2022
 13:54:32 +0000
Date: Fri, 6 May 2022 10:54:31 -0300
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2] iommu: iommu_group_claim_dma_owner() must always
 assign a domain
Message-ID: <20220506135431.GC49344@nvidia.com>
References: <0-v2-f62259511ac0+6-iommu_dma_block_jgg@nvidia.com>
 <BN9PR11MB5276504B448C715527AD5F3F8CC29@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220505153320.GS49344@nvidia.com>
 <BN9PR11MB5276476BB203D8D61CA8849C8CC29@BN9PR11MB5276.namprd11.prod.outlook.com>
 <9f6680ed-77b6-8440-078c-623406c823aa@arm.com>
 <20220506131053.GA522325@nvidia.com>
 <27088ae5-05d6-122a-d9de-80e10eecac38@arm.com>
Content-Disposition: inline
In-Reply-To: <27088ae5-05d6-122a-d9de-80e10eecac38@arm.com>
X-ClientProxiedBy: BL1PR13CA0434.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::19) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 604dc166-9ae8-4fec-0920-08da2f67f28c
X-MS-TrafficTypeDiagnostic: BN8PR12MB3604:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB36040DDEB4F5F7BDEDE617C2C2C59@BN8PR12MB3604.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t+af1kskBN0aMTxnIeGxlQ2Zu0P3AzR0qb7/cw8AVHFaHFel215TJeBlBq2hZlw8bNWM/IiieTcI3E89fdiBg/JgNkvqcIt6ivc+AAMX1PP5gp0+ORQ4VFOrFZJD++N2VijcZIPGRtvCirbIoj67diCgSEBrHs/FNUBHZ5Tfv2Ea+rbUB20FZGHmd8xU/dm10RV7ZQYNAdA0mnCp4hR2WU6Kiu0P46d84fmGor+iX/TXe/ZAcXyOp4nREc0M7Oula40t8/OigX1fY2R+Y3DFtOjVdNoSGlaFXp+Wzksy2EmM9hEJ2jmwmjmP+J/JIJPw9p1vSdTml5eOdvFqYwWVCZTrGO8TqEPv6wuFh3Zk6qfR/XQ5HSnSrerkKZ4U3Zf5kWbIcIcLZzb+0Im4k63iiKBbCJwGYRc77dSyB91A9vYJfZCWVL8jn7UxrCvFyxqUD/0QB09/0CPJCnWmOAl0wIfQRz3Iy5d6a3SZBZ5vQHUcAT5R9FQdYGxfqfYp+7BxA6YM6Lw790KOQbuOAjNGAKgTA7A5Oz4a6jayCkNy7Z0M+qIlU3PzZi+mPSfdLYRXpSzRUbYCdcfcYRZHBpXLO4MYDdNhDBN4FfcgMkE9zqRQ3FL3T75oItpur1iT8a+Nj3XmD1JUT5QKW9DuWnp53Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(83380400001)(38100700002)(6506007)(316002)(66946007)(66556008)(66476007)(54906003)(6916009)(508600001)(6486002)(2906002)(2616005)(1076003)(6512007)(4326008)(26005)(5660300002)(8676002)(8936002)(33656002)(36756003)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0F0S0hrTDZOWmxwTFdKTFd6Z25wVktpYWNBckZNam9GdzBQcTZxUXJtYXFt?=
 =?utf-8?B?R2dUWmdNUjJMb1JQbnZ0UUFldHlqWE0yTU1KU2JxYktISkYyckUyUzJ2M3VX?=
 =?utf-8?B?bFo3bmMxZFNLeDNtR1hrZVc2TmdBV0VVdm5Wa3dYS2dpQjlHb0U0bmk3alRX?=
 =?utf-8?B?aWNGc3NhTHkyUTBibmlUajliTVFHS1Q4SUhua3pNTm13TGc3WElvVDFiNk14?=
 =?utf-8?B?WlJtWURsZGQrVVdFNFNuWHBzODBrc0YxVEdWRDI3d1VLdXZiTHNzbzBtMFBG?=
 =?utf-8?B?ekViQ3lBQVdJcSsvUUdRZ09hbUFmR0JSRE55b2dNK2x3eU9NRGFGTEF4U0RU?=
 =?utf-8?B?VDFoWjlCVjJTRW52OUVxbkh2d2VVY1dxYkNTWWxkck55ZWlud0NwRStDZGpP?=
 =?utf-8?B?bEtYRFl6aVZlUkZ4UURwdGhmcjVqbWg1aGgxV2VFbE9YODliSEFjOHNxK09B?=
 =?utf-8?B?cmdUV2pnZ0JiU1JlcXp5dEcyeTJHWGdHVkRhemdrVVlXa1VsWjlSMCtSSUMv?=
 =?utf-8?B?RkJOVkFOM1YvWVQwOFpnbDhFdkFEc2p1TnlIeHRjcERHY0NUQWxjVnNDeDJh?=
 =?utf-8?B?RGpKREJ6Unh3WFNHbGZyWHczZ1FXUnJsMm9STE9FWDlBYUd5WGplVUxLT3hs?=
 =?utf-8?B?MnZkVTR5TWE0b3Y2Uy96QzhWOTZkYzRQR1VwRnNYSVlaVDhPbm1LYVZJK2hw?=
 =?utf-8?B?WlJNRnJTWUpCV3JIaDh3ODFYc0YvMEFMV3cwK2hEQXQvRWo2NTh5emNTZU92?=
 =?utf-8?B?WVpXK1dOYkRhSytSQlVUNXU5WElETVVyUGgrZEZFNlVmQmF2YW1JV2xhUXJB?=
 =?utf-8?B?dGR2QkIzenk5OWswQXB0OTBLQXhTbTZOMk4zb2I5SnR1bFNxQnIyaER5a2pH?=
 =?utf-8?B?bVF4WGR1TGJ0eUlzVGI0a1NvU3ZnTDUxamJ1L0JLdGE1SXRXZEtaejRaREUy?=
 =?utf-8?B?NWlQdktabXQ0R1I0WGFmT2VzUXlJWnZwVjdRNVQ5dHQxTytHSHB5T3U1U2J6?=
 =?utf-8?B?ZFkvWENxdWhIQTJRRXhEZklmblBMdDQ3cWtmd2t5ZytKS1NMT1NjVjYxTkRx?=
 =?utf-8?B?UFlOcU1pQVpkRitDU1NRUTl0eGN0UmhXejR0NUt2azUzN0NHMTVnbDlCb2Zq?=
 =?utf-8?B?Mk9oelNYVURCSjhDWEVEekM1V1MzUGlDM2RPSmg5Y2FMQWY1K2cyM3N0aVpj?=
 =?utf-8?B?SmZFcXBnVTJFREdYMjRhWG9HOGlDS09tMlNVSGtsQjZqTG01ZEFQcWk2MlRh?=
 =?utf-8?B?UWVRckFPTVNFUjNIVWFRdkpZOUZDMXg0ZDBJYWkwanpUV0xSallrTmM5R3lU?=
 =?utf-8?B?QW1UVlFvRnRIc01JZEloTEFWUGlEQTJEVHRWZk9oS3gyQS9zZGZaQ1JtODBO?=
 =?utf-8?B?eGtBb1N5RTV2dzg4WlFtV2FsRDdvMG1UR3VGNHNaVi93OG53OVBGZXU2Rmkv?=
 =?utf-8?B?THNFQ3lKWUNjdjJucHVqSmNmV2lZRUYvMjRvV2ZPRUVCb211akVYMjN3TVlW?=
 =?utf-8?B?NmhvWlVSbVNoSjFqQW9iMVNaSGduSFEyb000SzFsOUMrOTRaMlZQczFVdFFC?=
 =?utf-8?B?UHFLTHQ3bk5BL2hoNVVFWkVQRnVCb0ptcXBBQXc1UmhsWFlsamY4SXVia2sx?=
 =?utf-8?B?SnhrdmVMbWozdHNQcC9Ib1VOYmlrNVBjckcxemxudVhuK3hUbkJPcmQzakZJ?=
 =?utf-8?B?MExpN0Jpd2Vsb0J1a0VqVDZaTlcxbStOVWJGR1BuaDZoSG5JWEZmWEcvb21t?=
 =?utf-8?B?bG9Wdk8zb2g4dnEwSHpzQVhzUU9wd2ZrRWF1aDQ5dlJITEdybnREV2VQemMx?=
 =?utf-8?B?OWVIYmN2eTBQbmxHaE0yVklMakVJc1RzVFAyOWozVm1XZFBHRFlQM25ubHg2?=
 =?utf-8?B?TEIvaG5nQ3k3TXc3U2VmMmV3bUJkK29xam9UdmYvWUJKRkdHeWoycTIzREZD?=
 =?utf-8?B?b2hwK25uYVZ0U3lVbHp0aks5LzhqWGV3UjNwQzZFbllUMlprelJGUmJXdlVB?=
 =?utf-8?B?UVYrbTB0ZWNBdmlIZllCMm1zMFF6ZDB4REpsNlcvYmV3UEM0RnJOc2RTaG1G?=
 =?utf-8?B?NFlSZ05acWFMYzRGWm96L3ZlRmxMb0ZrdEU1b1NzOXh4cjJGWEtGcUk0OFNH?=
 =?utf-8?B?RU93czlPS2d3TkNBRWVjN0pEaU9IMkNtWUgyKzZDbkZQTkxNZkgyS0FIV0lY?=
 =?utf-8?B?ZEFvV25zb2FqYW4zQi9yTzdOQ3o2Qks1c3YxODVqMjNoYSs4YlJiemduTi9t?=
 =?utf-8?B?OVZBY3IrR2hab1M1aFpBaVlWWklZS1h1aUVyeDM2SXJZZng4K05heGgxZ3d2?=
 =?utf-8?B?OTAxYlRxMEQzcGFxeUttY2JLZlZUdDhvLzVRUTJYYWdFQ2E4MXZ0dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 604dc166-9ae8-4fec-0920-08da2f67f28c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 13:54:32.5153 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2nKwog3HIJ7NPSlYw8eWYbcPCsu0epA64wOG97l8hjSbmGfg0XyBbmAHl5sc0PQi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3604
Cc: Will Deacon <will@kernel.org>, "Tian, Kevin" <kevin.tian@intel.com>, "Rodel,
 Jorg" <jroedel@suse.de>, Qian Cai <quic_qiancai@quicinc.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
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

T24gRnJpLCBNYXkgMDYsIDIwMjIgYXQgMDI6MzU6NTBQTSArMDEwMCwgUm9iaW4gTXVycGh5IHdy
b3RlOgoKPiA+IFNvIHlvdSB3YW50IHRvIHNheSAiRE1BIGlzIGFsd2F5cyBtYW5hZ2VkIiB3aGVu
IGF0dGFjaGluZyBhIGRvbWFpbiBvZgo+ID4gdHlwZSBJT01NVV9ET01BSU5fVU5NQU5BR0VEPyA6
KQo+IAo+IFRvdWNow6kgOykgSnVzdCBnb2VzIHRvIGNvbmZpcm0gdGhlIHBvaW50IGFib3ZlIHRo
YXQgY29uZnVzaW9uIGJldHdlZW4KPiBnZW5lcmFsIGNvbmNlcHRzIGFuZCBzcGVjaWZpYyBBUEkg
dGVybXMgaXMgYWxsIHRvbyBlYXN5LiBBbiAidW5tYW5hZ2VkIgo+IGRvbWFpbiBmcm9tIHRoZSBQ
b1Ygb2YgdGhlIEFQSSBqdXN0IG1lYW5zIGl0J3MgbWFuYWdlZCBieSB0aGUgZXh0ZXJuYWwKPiBj
YWxsZXIsIGJ1dCB5b3UncmUgcmlnaHQgdGhhdCB0aGF0J3Mgbm90IG5lY2Vzc2FyaWx5IHNvIG9i
dmlvdXMgZWl0aGVyLgoKWWVhaCwgSSdtIG5vdCBzbyBrZWVuIG9uIHRoZSBuYW1pbmcgdXNlZCBm
b3IgSU9NTVVfRE9NQUlOXyoKCkkgbG9va2VkIGZvciBhIGJpdCBhbmQgY291bGQgbm90IGZpZ3Vy
ZSBvdXQgd2h5IHdlIG5lZWQgdG8gaGF2ZQpJT01NVV9ET01BSU5fRE1BIGVpdGhlci4uIEkgZGlk
bid0IGZpbmQgYW50aGluZyBvYnZpb3VzIGluIHRoZSBpb21tdQpkcml2ZXJzIHRoYXQgbG9va2Vk
IGxpa2UgYSBzcGVjaWFsIGNhc2UgZm9yIHRoaXM/IE1vc3QgZHJpdmVycyB0cmVhdAppdCBpZGVu
dGljYWxseSB0byBVTk1BTkFHRUQgaW4gdGhlaXIgYWxsb2MgZnVuY3Rpb25zCgpPbmx5IG10aywg
YXJtLXNtbXUgYW5kIHNvbWUgb2RkIHN0dWZmIGluIEludGVsIHNlZW1lZCB0byBiZSBzZW5zaXRp
dmU/Cgo+ID4gCS8qCj4gPiAJICogQ2hhbmdpbmcgdGhlIGRvbWFpbiBpcyBkb25lIGJ5IGNhbGxp
bmcgYXR0YWNoX2RldigpIG9uIHRoZSBuZXcKPiA+IAkgKiBkb21haW4uIFRoaXMgc3dpdGNoIGRv
ZXMgbm90IGhhdmUgdG8gYmUgYXRvbWljIGFuZCBETUEgY2FuIGJlCj4gPiAJICogZGlzY2FyZGVk
IGR1cmluZyB0aGUgdHJhbnNpdGlvbi4gRE1BIG11c3QgYWx3YXlzIGJlIHRyYW5zbGF0ZWQgYnkK
PiAKPiBzL2Fsd2F5cyBiZSB0cmFuc2xhdGVkIGJ5L29ubHkgYmUgYWJsZSB0byBhY2Nlc3MvIGFu
ZCB3ZSBoYXZlIGEgZGVhbCA6KQoKRG9uZSwgdGhhbmtzCgpKYXNvbgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVA
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
