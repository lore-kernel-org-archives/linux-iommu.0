Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7303C43334
	for <iommu@archiver.kernel.org>; Thu, 23 Jun 2022 14:57:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1DF6F417D0;
	Thu, 23 Jun 2022 14:57:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1DF6F417D0
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XeRdwAA0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2TvEFx5e27d1; Thu, 23 Jun 2022 14:57:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B8524417B2;
	Thu, 23 Jun 2022 14:57:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B8524417B2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 873ECC0032;
	Thu, 23 Jun 2022 14:57:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C9D23C002D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 14:57:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8E0AF417BB
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 14:57:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8E0AF417BB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tnxT2RJHFxm8 for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 14:57:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BC894417B2
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BC894417B2
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 14:57:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dUWdHi/By6ZAPUlLE4JRyLgIR9PcU+S1EtpRB2u1KrgK88T4EqULHsk869gDJ0CV5Hd2Ro0vmHMgJqj4uxul4xzlko/M3PyCoM48svm1du2QmG/+71kNvK1UAX+5/6DbedmeeYxi2PJzWRJaSaIhF/2X9bHGnjnysfCirnmpxCHEmlFpJEUuU0xhkIUEpa/ClkxtsPScM/sgJa3PQo7lCE+dykL57zEdnBUop1c1fjJpfbIxsbAbbZr/eTfaj9bw//XXrT72ClkLJClmJ17lStrlo8qR9Evew02xm1n5pPdzFdoBoOZUkh/GemBy14jr4r7A7WSQVIEyMeZeo8D/FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKOTNI19SI9S3dCHmFBXBlwYpVg3eIltFyyVgbu5GYg=;
 b=asBvZP1S6qEpNkoWahLFah7fsODKExoaOKDMIfM/Vc3zja99g18sMB2IONFZz3PQcnfTlhU083xQ2gGUr9qSRfp+t2+qin5uFtOCPUsMEBI2fjY2ArGl26cBfxEa3P+8fEiUo1CWOvivfTyegd8L7Fp/MZHp2MMEwbhkHJoOvcqDo9rAUAKgecPTnemub0qK0OUZEo+XZpNl9VbTIopDtmcPghg0Upz8EozHyffFIRvmjNFnAi8vQuGU9km3RCkgErYFY+TSTi0P9Ua/iYqPfvtTv9xvVFEk7EBTPi8i0DZTnntZKumfmKO5cq8juX0B7C4uAYnspRvYPHs95uQj/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKOTNI19SI9S3dCHmFBXBlwYpVg3eIltFyyVgbu5GYg=;
 b=XeRdwAA0RPXWtYsOVjSY1PTn3uQDpHEj4mWqCbKZdppSWeu2SzO0JvDzhfAn7awtmPHuyuY3P7ttVdFXDYCz6b0ZtBkkPeZvofsSSvv2uQ+ERaqXhxlQ+kyiiwA75j/Sgns8rv8NIxLnjWX5lg/TCFDR+uQsuX9vuwAzCDTLj9/gVniU7U57LKyN+ZBC9zB7sfKpzppHQOSZa45NnODxusxE9fG0NahIhpnndrBn87BmLgc/BqECWOwSUjRY6oBErM7Nh4BlOBK8eJsMA5PwFN/s556PXrSK1bi3HMnZQHaCGFqSvUzX0Plgxli59VlwjSWJU9WRa3fRdfxCASti1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH2PR12MB4071.namprd12.prod.outlook.com (2603:10b6:610:7b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.17; Thu, 23 Jun
 2022 14:57:21 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb%3]) with mapi id 15.20.5373.016; Thu, 23 Jun 2022
 14:57:20 +0000
Date: Thu, 23 Jun 2022 11:57:19 -0300
To: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Subject: Re: New IOMMU mailing list coming
Message-ID: <20220623145719.GB4147@nvidia.com>
References: <YqhHHBkvGL74azMg@8bytes.org>
Content-Disposition: inline
In-Reply-To: <YqhHHBkvGL74azMg@8bytes.org>
X-ClientProxiedBy: MN2PR20CA0045.namprd20.prod.outlook.com
 (2603:10b6:208:235::14) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a085271-64c2-4cab-ac51-08da5528ac3e
X-MS-TrafficTypeDiagnostic: CH2PR12MB4071:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB407179571EE9A8149E1966FAC2B59@CH2PR12MB4071.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ITCikO7XUyZBdd60gBwEblwLrgnZWHj8gOXghvIa6Jgq6Yh06hLbYieauT25KnKJ1HQL1MiwTWfkxMPujp8rulNZWm5In3AMP2og4YNOyKTFxb6MHa0NM5Jo8Ito5Nmk2t7rmr4BbauUWzliolADnneYxXZNIxVyU+tgQ0+AZR37bF4JRSEoqCGfBc6NE34tN0guNfAinLd/6oAh76jujHB+vjoJdOR36CcLJ95lOc8AOiONvoIHRBffWDF9ZVuFHc+O/RrjiJQxDO8f8h0wmlOcGnoWjE0U3AFnAkds/ARyeBxSvtJGxn1pB/oDUWK5DH9WiRDfI/Dsmr5ItgRXGLp9ZC2DL7gKokBVKGxjA1IPbhLiApvkRdHQq0kJOPxOXIG/c11RPaigu/AIOhal0eecu5phwe+RVtdMbhe8FHatcA00IK9fCuD3chc5jG6tfTiuXasr7N13643DQOwiziE9LnlCe7t0DCc2UdRxtOdC7l4wfxelOJJuRCor4JbgtVKIsUJJQobV/GJhTsoqRrn07tPamhe8DKqqlrWMpFxdHXsVHxkknXU2rVyvmeuAYuz1/FN0hjtsL87b4ugZPUXkcLSdrOoqrpmN0jgP+rJ9d5xrDKFuMUsRgovFpAYngFRMby3A+exgxUyLUYvOBmEg3EkVFUPz/RGUVBNBj4Y+lBa0CHje7EfM6kLAdSXUdYcF8wU1HRcAN9z3oTA+Obko8aGshaWJpOG5KURlN2hhNZp25OlOmEL5ExoM4K4sBokTVXw630iJFMZJuoMGSwY2LCUaVV/g/MGN3MWOm2g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(186003)(41300700001)(33656002)(36756003)(26005)(6512007)(1076003)(4744005)(2616005)(5660300002)(66946007)(316002)(6916009)(6486002)(8676002)(6506007)(478600001)(38100700002)(2906002)(86362001)(66476007)(54906003)(66556008)(8936002)(4326008)(223123001)(130980200001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWNXTVN6eEo5UWkrYUhTelk1TWJTMGJONjloVnR0YmRCdnNJS2V4N2xEY1o4?=
 =?utf-8?B?TVRSSWV0cThtcjBIWmEwQWI1RHp2Slpaa3VRUkUxazJtQTlJMG5tWDQvQlhq?=
 =?utf-8?B?UWlFYXlaR2J3Q20rSnIrR2RBdkY3bjFpeEhhUThlbDRnRHI3U3I5RWZjV2ps?=
 =?utf-8?B?VUZwMjV6NUZRaEt0MTFHWHVyUTFhWDRQZGtNdDFjdEVjdDV6R0ZYOURxNnJm?=
 =?utf-8?B?Zmw1SnFScTY5di9JZjM4OEdidmR5a1dwclF3clphRHN6QmZhaGc5SGZaTHVR?=
 =?utf-8?B?aTBFcHFzZTZ4ZjB2R0xBWHpPRCs5V2grSHJheThwRzgvaGhrSHVaTktja1dH?=
 =?utf-8?B?SDlXT1kwVlJiY2lWZ092WmZPV3c2L2VkVU9PclJtbDlja09VcjdnMjFqOGNY?=
 =?utf-8?B?bi9QSWNHaU5zQW00QWE1MnZXU3JvKzhZeVZPZGszODhiNDh0dEIwQzVCOC9X?=
 =?utf-8?B?R0pNTWhTSlVrREVXMHRjN2M3RHBiM1JMYTREOTNJSjhUYkprMGdmT3dkRzV2?=
 =?utf-8?B?R2h1QThMZFNRSmJSSmZXNXNaVENDL1A3dU1VOXFuMkw1N0Z0dEtIVzBGckZ2?=
 =?utf-8?B?TzdSYlVxbnBRSjR2blUwSXh2L3hRNGtYd09va2pneEtaamNFai92Yi9JUkxr?=
 =?utf-8?B?ZFFIUEkzNXl2REF6NjlxbnRER3pGay9Qcm9pa1pOcjYrNms5YUVkVmNPM1gz?=
 =?utf-8?B?c20rUGphSWJudW5WZFF2Sk14UW1oT0hmSm5oMXl3Rm5iSVlQMkcvcm9aVmpQ?=
 =?utf-8?B?SkRycTBXMUdyd3hkMzdCcityVjVlVmplNGdqNmFnWXloaG5SaDhucU0zU0JG?=
 =?utf-8?B?WjNiV2Roam9xdjlsZVN0TFpSaVhKcGJFN1hrMWFkM1JTVThXVlRocmsxQXJy?=
 =?utf-8?B?NStURmhtc0tZM0t6MXN6WlZIM215WDRNOStWL29Yb1BURjBtRy83UEd3Slll?=
 =?utf-8?B?dm1lVzhXdVRlRURJYUVHMUhmaWhQVDNudWxpQ3FGd2lVMFNzcWVuSlNpQVF4?=
 =?utf-8?B?NysxUm1UVUJ2M0F0d3J0KzEwZW85T2hpZDN3NHJ5dndXK1pHdzhWRlRUdks1?=
 =?utf-8?B?RWV0UXY5L3NwekdlVWg5V2lzNmhzTk5mcFNIZlBZUjE4emYzQVZqWWpDREN4?=
 =?utf-8?B?QTQ2M1kxTzlCV1FVN20rRWRDTW5YOE5PVFdnZFd3dDRUbjNQM2FBTUZuQXls?=
 =?utf-8?B?Wm1BTjZtRjVWdVFHTHVSdFQwZkUvZ0d3MnpkUEc0eGpQNkg3RU9aNVVLS0RR?=
 =?utf-8?B?ZFVRZEZWdndYOTlqbzM2S0hTRkRUZUllakIzWnoya04yVGo2Y3lIUUs5S21a?=
 =?utf-8?B?Si9LQU9OR2tuM2Zmc1RBVXBoc293Y0lyRHg4YkdhWEtkUnNSSUNlNFNhYnND?=
 =?utf-8?B?cTZZSkhnc1kvZ0w3ZXNoSCtUalNEMnQrWkdtOHFjbnFta3VtNE5MaGpQa3Av?=
 =?utf-8?B?ZmhUMWFpK0dZakVNL3NVS0haQTdYTjJ4R1U1K2M1RGkvRjRSd3VWVzFvM1Fh?=
 =?utf-8?B?OEw5bWQ0anE1YVdsbXlld2JldEJDaXZpUk1CNWgzOXpGTXU1RDR1U2dDQndS?=
 =?utf-8?B?MVptdlRvU3RCZThDa1JpUEhlUm1kYk1QRzVMVlY3by9Zcmk2b2VZdDhUOUxU?=
 =?utf-8?B?L2N4akp5d3Y0bEFiZUdnaGRLMnBDNWs0ZTlYOVVUc1ozQTZvTkh1ZEVMbnFH?=
 =?utf-8?B?ZjJqK2ZkbmhKdWJIM2RSdjUvQW5OM1dXNDh6ZGdOUU5kSXF1SkxPall4MytK?=
 =?utf-8?B?Mm4wdTBBMG5QUGMvay8xUDJQdFhxcTIwV3NRY2JFNUwrVjFyYlpFTDluM0tV?=
 =?utf-8?B?QTlSNUJSUitwTVZLY1JKR0o5dTZCTmFLYWJXczM2RG1SbWdTZElnTnkwM1p5?=
 =?utf-8?B?SjNKbENRbnk1NERxUFNJVzMvbVhYZitnaU1uaVF5SEhhK3RBNGx1N3R1VFRR?=
 =?utf-8?B?YThzNGlNZTVWQitrL0g4Q095SGpjaXJmeHVtckZ4eWtlVEd5Y3Y2Uy95ZXY1?=
 =?utf-8?B?N2JnU1Z5Tk1FRDlGSlo2RmlOaGU3aGJ6L2FhRm5xTVd1cy9wZU9wTWJRUFE3?=
 =?utf-8?B?ZjdUSHdRTXdlTVlqcGFBUzlBNXM4a1pNYTZqN1dDNzFJTys4YmoyU29XQkpR?=
 =?utf-8?B?OS8rR2pXaGswSCtGL1ZHaVZwZUVsL1d2bHpoUVU0K2VoaVBtNFhjV1k2ZmxL?=
 =?utf-8?B?SkpVdFpRZGhQM2FRVTBFeHJPcEhhd1J1ejZDajNrcDlETUFLeFUxNGF1aWw1?=
 =?utf-8?B?R2kyVkozNTVFNEFxZkx6NERJVlhRZ0k5bmFWNWpmT2JFaWdDN3BLcDc1NVdG?=
 =?utf-8?B?YnBuNkg2SFJ1Z2VmbGx0WkNJc3BsVW91VGplRmNqdzZOMExGSGIzdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a085271-64c2-4cab-ac51-08da5528ac3e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 14:57:20.6468 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 06n/tucjLMcBAuk93IIvd6nxov/DEZk+e6eM7gzjGB+JBWuv0vrKbScNn8ycXUY9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4071
Cc: robin.murphy@arm.com, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>, Alex Williamson <alex.williamson@redhat.com>
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

T24gVHVlLCBKdW4gMTQsIDIwMjIgYXQgMTA6MzA6MjBBTSArMDIwMCwgSsO2cmcgUsO2ZGVsIHdy
b3RlOgo+IEhpIGFsbCwKPiAKPiBhZnRlciBzZXZlcmFsIHByb2JsZW1zIHdpdGggdGhlIGN1cnJl
bnQgSU9NTVUgbWFpbGluZyBsaXN0IChubyBES0lNCj4gc3VwcG9ydCwgcG9vciBiNCBpbnRlcm9w
ZXJhYmlsaXR5KSB3ZSBoYXZlIGRlY2lkZWQgdG8gbW92ZSB0aGUgSU9NTVUKPiBkZXZlbG9wbWVu
dCBkaXNjdXNzaW9ucyB0byBhIG5ldyBsaXN0IGhvc3RlZCBhdCBsaXN0cy5saW51eC5kZXYuCj4g
Cj4gVGhlIG5ldyBsaXN0IGlzIHVwIGFuZCBydW5uaW5nIGFscmVhZHksIHRvIHN1YnNjcmliZSBw
bGVhc2Ugc2VuZCBhbgo+IGVtYWlsIHRvIGlvbW11K3N1YnNjcmliZUBsaXN0cy5saW51eC5kZXYu
IEl0IGlzIG5vdCB5ZXQgYXJjaGl2ZWQsIGJ1dAo+IHRoZXJlIHdpbGwgYmUgYSBoYXJkIHN3aXRj
aCBiZXR3ZWVuIHRoZSBvbGQgYW5kIHRoZSBuZXcgbGlzdCBvbgo+IAo+IAlKdWx5IDV0aCwgMjAy
Mgo+IAo+IEFmdGVyIHRoYXQgZGF0ZSB0aGUgb2xkIGxpc3Qgd2lsbCBubyBsb25nZXIgd29yayBh
bmQgdGhlIGFyY2hpdmUgd2lsbAo+IHN3aXRjaCB0byB0aGUgbmV3IG1haWxpbmcgbGlzdC4KCk5p
Y2UhIFRoYW5rcyBmb3IgZG9pbmcgaXQKCkphc29uCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby9pb21tdQ==
