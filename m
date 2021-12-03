Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D5AC433EF
	for <iommu@archiver.kernel.org>; Fri,  3 Dec 2021 19:11:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9ABCA40017;
	Fri,  3 Dec 2021 19:11:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lJ4TfebyLPdC; Fri,  3 Dec 2021 19:11:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A77694013D;
	Fri,  3 Dec 2021 19:11:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 775DAC006E;
	Fri,  3 Dec 2021 19:11:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CABE7C0012
 for <iommu@lists.linux-foundation.org>; Fri,  3 Dec 2021 19:11:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A30794013D
 for <iommu@lists.linux-foundation.org>; Fri,  3 Dec 2021 19:11:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ONgk9FwKwmJB for <iommu@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 19:11:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C3D3940017
 for <iommu@lists.linux-foundation.org>; Fri,  3 Dec 2021 19:11:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WBPW+Q9ypdbz/mPEtjQqV8xRsr+rBlc+UuDyn8iElIVZEKm0iL29QPKr1IYVaKDOoePYI3L73wfxT1ViwE2CdOJfAtFY0BCIi1AdKcYo5+GaA6wWxjbv9esQkhnev3hspQSZxe4qOC2V0aOxVPEsv4dCK2Wn37rZ1gTlhBS+VuEsk1rwixf6SF0tP7q7i9lbVI8NloHqDLm1eE4Cq1tTCH6Pijz8e3kg5jbw8lQYiRdNGm+mflkl1u2KhXBxEj+i3IS0h8YPtoyK8RxAIvsUrVJ7DYUzNu1IMp1Q4N+/WhCalDYRQ6TBuCflSqveTasA5QRWIKP4e/KFi7f8qFzlqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sfmy+MHGUEfiCYS0Rl5GVzq7hAgUj6XvKDuFFGuA6Tg=;
 b=XVmTgNFiepKh0BcJr/A2eXWup80JU1zFl3qTh76kKkN73zclF3but2kRmU+LKEVHLmVAZS2ZHPr11Nqarwc3H4js8bGc1CjVSDpQjKsLgFqQzfS92fzV9Vtd0loJxSF26+NIPMhRfYmULBEtdiRmgZ3WBUsr0FQ/5o6HSZ8koNUwrRETGnjWP1QOctN3Hfgn6VZ9YLGNFmbsYCqTIk6CMpW8GGXyXtmDsBtepNQR9IvZRaCjSUBRsNAgtRjTWPD8b4wKbp9uAWRDBbXyVrtHhgEGLRhrWuFN7hovbjEvXwkRRIAAj7Ng33Q8jjDlPIT4HZykQWxZfkw9jirSJDvH0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sfmy+MHGUEfiCYS0Rl5GVzq7hAgUj6XvKDuFFGuA6Tg=;
 b=IDBkJzq8eV3mhPaBRRf2WQ6oS69/Pkfbpp4hU+7/DrQPoHcQtj5M0hAphz/pCKC4r1NRSQJK4wr9axnTg9uosscX2qw+Z8rRF6SuDNrdZU1SewbBIN3TUdnO7DJU/IOGsA/4uQNtIHlsacR36otf9bpSQMapX116d/CMPEa5UQY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.23; Fri, 3 Dec 2021 19:11:22 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1ddd:71e4:5803:e44a]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1ddd:71e4:5803:e44a%3]) with mapi id 15.20.4734.028; Fri, 3 Dec 2021
 19:11:22 +0000
Subject: Re: [PATCH V3 1/5] Swiotlb: Add Swiotlb bounce buffer remap function
 for HV IVM
To: Tianyu Lan <ltykernel@gmail.com>, kys@microsoft.com,
 haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, jgross@suse.com,
 sstabellini@kernel.org, boris.ostrovsky@oracle.com, joro@8bytes.org,
 will@kernel.org, davem@davemloft.net, kuba@kernel.org, jejb@linux.ibm.com,
 martin.petersen@oracle.com, arnd@arndb.de, hch@infradead.org,
 m.szyprowski@samsung.com, robin.murphy@arm.com, Tianyu.Lan@microsoft.com,
 xen-devel@lists.xenproject.org, michael.h.kelley@microsoft.com
References: <20211201160257.1003912-1-ltykernel@gmail.com>
 <20211201160257.1003912-2-ltykernel@gmail.com>
 <41bb0a87-9fdb-4c67-a903-9e87d092993a@amd.com>
 <e78ba239-2dad-d48f-671e-f76a943052f1@gmail.com>
Message-ID: <06faf04c-dc4a-69fd-0be9-04f57f779ffe@amd.com>
Date: Fri, 3 Dec 2021 13:11:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <e78ba239-2dad-d48f-671e-f76a943052f1@gmail.com>
Content-Language: en-US
X-ClientProxiedBy: SN4PR0801CA0002.namprd08.prod.outlook.com
 (2603:10b6:803:29::12) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
Received: from office-ryzen.texastahm.com (67.79.209.213) by
 SN4PR0801CA0002.namprd08.prod.outlook.com (2603:10b6:803:29::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend
 Transport; Fri, 3 Dec 2021 19:11:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92accadf-6adc-4fe8-1ff3-08d9b690b164
X-MS-TrafficTypeDiagnostic: DM8PR12MB5399:
X-Microsoft-Antispam-PRVS: <DM8PR12MB53997ADC847CF6B2F8048AE5EC6A9@DM8PR12MB5399.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FxnKwLtS83nvAhaLzvqADUsfPgwgpLbXVkI3W0oTcJv0WXep7++my1H/dbW32fZPsg7BLO2GJfbotOsdLim8SuPBvAeDGRWk2nE7xJ9hEcM+fSLtEJtVxMTzStQMY/fqXJfZSfHftOm/kXbk4XdMooRXFf/AGVdHekcnK3FLT45g7js9rUQBoW5zJWZPfpS4ermJ3QMh7L9nbQMjaLdpMjfFltGFE27O6ue1XLbLDIvf9qdkM/53ZqdrDTC+SyDzshVHcqFh1SkttAHcblE0bI1irKKmP2xt/Net53FwzZZzb+ex6Lm1T66egw9MZEULbuCu5yC98OfN2bV09OGLARZDo+8AlW5n+CU/NqVAgXgMQUbF9mcS2wPekYhZqDlX17UOYWzuNOKrrlrrpfod6EiW3m5n+acLU/4nUJKpkD/y0fFUvFRHuGv0UO42T7Sww4aKkfym93/d6sLPbhdNTEyI1kz/1czyqGeGnSQNRZRzsua7MB0yfYBCucWsvvpD0CH/yeGY6V85lnWopgPsGY7bH5kpFrRQMpF2fwacCFYnQq1FLnRuNXSGPR8qycLtBE9ElhPyKqrPJM1UmStqLDUulN+g5Krtkf/ACxd599X5v5EH1D/rGABTqVJKWDj6zEaCS/R8MNEFrzEGYUjLrsLWukJ6zvwzoYuMEUeSj+1l/n17IWje5UDakyFy0LU5OFPC9mlpXLYh5ifmAoMfmfNoElUSuEsuMpgMqqQgOCkKeIZQnFu6epOS8x0EDgyHAtIaxEIm3w3BEhqcVLzUfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5229.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(53546011)(6512007)(2616005)(36756003)(31696002)(6506007)(8936002)(26005)(31686004)(7406005)(8676002)(7416002)(38100700002)(66556008)(5660300002)(66476007)(316002)(956004)(86362001)(508600001)(921005)(66946007)(2906002)(186003)(6486002)(45080400002)(4326008)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzdDZjRRbmRZOVVxYWw1K0hPNGRCMzlQSzNBVTdnMHE3SWZLUE9YWUVrdXYx?=
 =?utf-8?B?UEZyQVVLQkNxaHZqL3FsRzhXdTl3NWk1YjFYOGZDbDZWTDN6WE10cnYwMkVR?=
 =?utf-8?B?aFlkMHg0Qkg4VGZtMXNUMmQyWHV3NTRWWjZ3TWdDY3Ywb0FuN1Yraml1clJY?=
 =?utf-8?B?ZjFiU3dGMFUrdUIxUFFZcTNmZFgycXRyK1MwNzBtZ0prdHNtVGJpMDlZZ0Nz?=
 =?utf-8?B?eFBjK2tQTnZvUXdtL0VOV2hwWXJHSkVlMXdNVDA1eHZyaUZZWUdISWViUSt1?=
 =?utf-8?B?ZUZlQlZ1d2FkOW1OdnpKWkVXSmNieXE1TWMxZWtNNkZOMWJnUEpYWktkd1c3?=
 =?utf-8?B?RkxpYVFHQzV3aTBxVkpRK2lEbW1BaTNrWUZUYThRdEhxQTlHcTdtOXNhanoz?=
 =?utf-8?B?ZzN0M2hrQi90UDZ6T2ZYUVdMSVNvcHAxNVdYbU5Mb2Q5c0hPM0RJN3VvTTQz?=
 =?utf-8?B?V0tLQzl0bXB2SWVMNkcwQ1BwcXpYSjJNaEJoeUNyYVpsM3h1VTBnQmZZN0px?=
 =?utf-8?B?bTJwQkNiQmZsNVFjSHpMSXFENzIyLy9iQTJjb0J4alphZzRXUjYxelRPQUdk?=
 =?utf-8?B?VWh4VE5uT3JadFNwYStxUTZKS2tVSk9SbTV3YVZUZWtUa0p1ZkptYk5qcFNF?=
 =?utf-8?B?VjN3d01TNzNwNERrdWtRSUZCV2lNaEIzZDNHZnRIRXJoSXp4UytTMHNpTG1T?=
 =?utf-8?B?K0wzT29KYVBhK2E2ZnFjV2o1S0lmTTMwZDNkUG9Sc1pSblNNWjU1QmFxTDVz?=
 =?utf-8?B?NW5GbGI2UGRIOEQ3NHdLRVNMNm9aQTlPK2Q4SmRWRm9CeGxKeE5qcTJtVVhH?=
 =?utf-8?B?UndXcVZVOFE1ek9FbU94a1piV2J5NnM4YUY3N2JsVjZJQ1JCbFhTMzFVbjFo?=
 =?utf-8?B?MlRBY2tLdG9IZTd0NFBHUGFUMVpTMXNzUUNrSjJmQ1ZYQTA1c2hMN2lDQVZh?=
 =?utf-8?B?NFhnZ1VqV1JGdE1nTy9Gc1FtbVZ0SUpNNXB6U2gvQWxoQXN4UTFCNklUQ2hQ?=
 =?utf-8?B?VWliKzlGRzM4RkxpZUc0SXFkSlpaczdWOHprV1ExMFpKUW13Mm1aQ0tSVlFQ?=
 =?utf-8?B?RXBwVTg1SWFXNmJ5WmlWNFBCQ1YzZzl4WUtzSWl5QzB5OU5abDNETlVGM2FM?=
 =?utf-8?B?endvLy9WR0lUNzAxelJScC83Vll6MDhnRzhVcHZmSXlxRWpyRDhrMG1SSndm?=
 =?utf-8?B?d2tCb3JoR2JoY0Y0Z3VSS1Q4c3VhdDZKTlJQaStocDNJUmRxblhURTA4NmNj?=
 =?utf-8?B?NitzMnlabVdHQW1mekZoRWNzUGdrUEQ1TFNNdmt4TmMyVGptOXlFdHJQK1pi?=
 =?utf-8?B?dHh2NjlmVWFHbWRDVTFSTllNZUorN2kwWDdrak50UlFRY1NEUFBMUktTaTAw?=
 =?utf-8?B?WVhoT1ZxTkhQb1pRMTk0YnBrQWVUSklXdXIwbGE5eWlESDRtMnNqVFUvUlYr?=
 =?utf-8?B?SzJUT2VsUFlBMWI2YnB2dVQ2VzFHRmpnWm1qYnlMNGgwak8xbDRjR1RDanVI?=
 =?utf-8?B?TkJacGxiY09Hak5IVzZpMG8wS0lPZDZVMFJYSG9mVUpXODkyOUQ3MG5kc0ZZ?=
 =?utf-8?B?TkpCaE1xR2pYaEJqUlpRMmxDNEhDNDNaOEtMd2UyUjEyc29URVBZQWZlVFNl?=
 =?utf-8?B?b1R1dW4zQTI2VDZhaUVOd0owNzlaUytKMnFVYnM5UlRBWTlsWUYyNEtGQS9L?=
 =?utf-8?B?RGVBaDAweUxBYnBKeGRHYW8zSzUwUUVhMTd2b1ZoaXM5NWZubk1QY2FZd1pa?=
 =?utf-8?B?dm43KzlJSUlMTkpYdnVrUlpiRlJJcERGeXJxWW90eTFYM01tWXlLSUdadzU4?=
 =?utf-8?B?aHNkdlprZG9IR3RaZE9MekhoM3Z5NHdXWDJ6bU5PRUR5andlaFllZmdpcyto?=
 =?utf-8?B?SGx2cU5YRENaUkllQzJ6NXlJL1hlQkZpZUhrU2lBdm84Um81TGJvQ3VtSzYx?=
 =?utf-8?B?S2tUUmtLdFJIb3VsZkMrVmxXeERiMHA5ZDZ1TGpTMS9iSkJtUUdzU1ZYUWpW?=
 =?utf-8?B?U3p2dk05d25XS3RKTk1PRkNpY1Z0QzY1ZmwvZ0s0M1VPcG9sbWNMSFlsMFZy?=
 =?utf-8?B?TWlvVjk3NHplbW9oY0xzcU9hbXlxeFNXUDJ0bGNnNGl5dmMvdHpoMkRGaTV4?=
 =?utf-8?B?RS8yYTFOZ3IrUXk1Q3BqVW9IUTYrVzRSbGdxMHJSanh4KzNXclphcEtSbnJN?=
 =?utf-8?Q?VgqsU58cgRcU2iV8tTEgFs8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92accadf-6adc-4fe8-1ff3-08d9b690b164
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 19:11:22.0576 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z/wjtckrxKQppp3WLCFKpwtEtvRoebkt7iogo0Vxo4Ee8u//UJxSgedThS8vkFUtBS6/kaDwRBtG+Uu4/S5w4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5399
Cc: linux-arch@vger.kernel.org, parri.andrea@gmail.com,
 linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 linux-scsi@vger.kernel.org, konrad.wilk@oracle.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dave.hansen@intel.com,
 iommu@lists.linux-foundation.org, vkuznets@redhat.com, hch@lst.de
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gMTIvMy8yMSA1OjIwIEFNLCBUaWFueXUgTGFuIHdyb3RlOgo+IE9uIDEyLzIvMjAyMSAxMDo0
MiBQTSwgVG9tIExlbmRhY2t5IHdyb3RlOgo+PiBPbiAxMi8xLzIxIDEwOjAyIEFNLCBUaWFueXUg
TGFuIHdyb3RlOgo+Pj4gRnJvbTogVGlhbnl1IExhbiA8VGlhbnl1LkxhbkBtaWNyb3NvZnQuY29t
Pgo+Pj4KPj4+IEluIElzb2xhdGlvbiBWTSB3aXRoIEFNRCBTRVYsIGJvdW5jZSBidWZmZXIgbmVl
ZHMgdG8gYmUgYWNjZXNzZWQgdmlhCj4+PiBleHRyYSBhZGRyZXNzIHNwYWNlIHdoaWNoIGlzIGFi
b3ZlIHNoYXJlZF9ncGFfYm91bmRhcnkgKEUuRyAzOSBiaXQKPj4+IGFkZHJlc3MgbGluZSkgcmVw
b3J0ZWQgYnkgSHlwZXItViBDUFVJRCBJU09MQVRJT05fQ09ORklHLiBUaGUgYWNjZXNzCj4+PiBw
aHlzaWNhbCBhZGRyZXNzIHdpbGwgYmUgb3JpZ2luYWwgcGh5c2ljYWwgYWRkcmVzcyArIHNoYXJl
ZF9ncGFfYm91bmRhcnkuCj4+PiBUaGUgc2hhcmVkX2dwYV9ib3VuZGFyeSBpbiB0aGUgQU1EIFNF
ViBTTlAgc3BlYyBpcyBjYWxsZWQgdmlydHVhbCB0b3Agb2YKPj4+IG1lbW9yeSh2VE9NKS4gTWVt
b3J5IGFkZHJlc3NlcyBiZWxvdyB2VE9NIGFyZSBhdXRvbWF0aWNhbGx5IHRyZWF0ZWQgYXMKPj4+
IHByaXZhdGUgd2hpbGUgbWVtb3J5IGFib3ZlIHZUT00gaXMgdHJlYXRlZCBhcyBzaGFyZWQuCj4+
Pgo+Pj4gRXhwb3NlIHN3aW90bGJfdW5lbmNyeXB0ZWRfYmFzZSBmb3IgcGxhdGZvcm1zIHRvIHNl
dCB1bmVuY3J5cHRlZAo+Pj4gbWVtb3J5IGJhc2Ugb2Zmc2V0IGFuZCBwbGF0Zm9ybSBjYWxscyBz
d2lvdGxiX3VwZGF0ZV9tZW1fYXR0cmlidXRlcygpCj4+PiB0byByZW1hcCBzd2lvdGxiIG1lbSB0
byB1bmVuY3J5cHRlZCBhZGRyZXNzIHNwYWNlLiBtZW1yZW1hcCgpIGNhbgo+Pj4gbm90IGJlIGNh
bGxlZCBpbiB0aGUgZWFybHkgc3RhZ2UgYW5kIHNvIHB1dCByZW1hcHBpbmcgY29kZSBpbnRvCj4+
PiBzd2lvdGxiX3VwZGF0ZV9tZW1fYXR0cmlidXRlcygpLiBTdG9yZSByZW1hcCBhZGRyZXNzIGFu
ZCB1c2UgaXQgdG8gY29weQo+Pj4gZGF0YSBmcm9tL3RvIHN3aW90bGIgYm91bmNlIGJ1ZmZlci4K
Pj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBUaWFueXUgTGFuIDxUaWFueXUuTGFuQG1pY3Jvc29mdC5j
b20+Cj4+Cj4+IFRoaXMgcGF0Y2ggcmVzdWx0cyBpbiB0aGUgZm9sbG93aW5nIHN0YWNrIHRyYWNl
IGR1cmluZyBhIGJhcmUtbWV0YWwgYm9vdAo+PiBvbiBteSBFUFlDIHN5c3RlbSB3aXRoIFNNRSBh
Y3RpdmUgKGUuZy4gbWVtX2VuY3J5cHQ9b24pOgo+Pgo+PiBbwqDCoMKgIDAuMTIzOTMyXSBCVUc6
IEJhZCBwYWdlIHN0YXRlIGluIHByb2Nlc3Mgc3dhcHBlcsKgIHBmbjoxMDgwMDEKPj4gW8KgwqDC
oCAwLjEyMzk0Ml0gcGFnZTooX19fX3B0cnZhbF9fX18pIHJlZmNvdW50OjAgbWFwY291bnQ6LTEy
OCAKPj4gbWFwcGluZzowMDAwMDAwMDAwMDAwMDAwIGluZGV4OjB4MCBwZm46MHgxMDgwMDEKPj4g
W8KgwqDCoCAwLjEyMzk0Nl0gZmxhZ3M6IDB4MTdmZmZmYzAwMDAwMDAobm9kZT0wfHpvbmU9Mnxs
YXN0Y3B1cGlkPTB4MWZmZmZmKQo+PiBbwqDCoMKgIDAuMTIzOTUyXSByYXc6IDAwMTdmZmZmYzAw
MDAwMDAgZmZmZjg4OTA0ZjJkNWU4MCBmZmZmODg5MDRmMmQ1ZTgwIAo+PiAwMDAwMDAwMDAwMDAw
MDAwCj4+IFvCoMKgwqAgMC4xMjM5NTRdIHJhdzogMDAwMDAwMDAwMDAwMDAwMCAwMDAwMDAwMDAw
MDAwMDAwIDAwMDAwMDAwZmZmZmZmN2YgCj4+IDAwMDAwMDAwMDAwMDAwMDAKPj4gW8KgwqDCoCAw
LjEyMzk1NV0gcGFnZSBkdW1wZWQgYmVjYXVzZTogbm9uemVybyBtYXBjb3VudAo+PiBbwqDCoMKg
IDAuMTIzOTU3XSBNb2R1bGVzIGxpbmtlZCBpbjoKPj4gW8KgwqDCoCAwLjEyMzk2MV0gQ1BVOiAw
IFBJRDogMCBDb21tOiBzd2FwcGVyIE5vdCB0YWludGVkIAo+PiA1LjE2LjAtcmMzLXNvcy1jdXN0
b20gIzIKPj4gW8KgwqDCoCAwLjEyMzk2NF0gSGFyZHdhcmUgbmFtZTogQU1EIENvcnBvcmF0aW9u
Cj4+IFvCoMKgwqAgMC4xMjM5NjddIENhbGwgVHJhY2U6Cj4+IFvCoMKgwqAgMC4xMjM5NzFdwqAg
PFRBU0s+Cj4+IFvCoMKgwqAgMC4xMjM5NzVdwqAgZHVtcF9zdGFja19sdmwrMHg0OC8weDVlCj4+
IFvCoMKgwqAgMC4xMjM5ODVdwqAgYmFkX3BhZ2UuY29sZCsweDY1LzB4OTYKPj4gW8KgwqDCoCAw
LjEyMzk5MF3CoCBfX2ZyZWVfcGFnZXNfb2srMHgzYTgvMHg0MTAKPj4gW8KgwqDCoCAwLjEyMzk5
Nl3CoCBtZW1ibG9ja19mcmVlX2FsbCsweDE3MS8weDFkYwo+PiBbwqDCoMKgIDAuMTI0MDA1XcKg
IG1lbV9pbml0KzB4MWYvMHgxNGIKPj4gW8KgwqDCoCAwLjEyNDAxMV3CoCBzdGFydF9rZXJuZWwr
MHgzYjUvMHg2YTEKPj4gW8KgwqDCoCAwLjEyNDAxNl3CoCBzZWNvbmRhcnlfc3RhcnR1cF82NF9u
b192ZXJpZnkrMHhiMC8weGJiCj4+IFvCoMKgwqAgMC4xMjQwMjJdwqAgPC9UQVNLPgo+Pgo+PiBJ
IHNlZSB+NDAgb2YgdGhlc2UgdHJhY2VzLCBlYWNoIGZvciBkaWZmZXJlbnQgcGZucy4KPj4KPj4g
VGhhbmtzLAo+PiBUb20KPiAKPiBIaSBUb206Cj4gIMKgwqDCoMKgwqAgVGhhbmtzIGZvciB5b3Vy
IHRlc3QuIENvdWxkIHlvdSBoZWxwIHRvIHRlc3QgdGhlIGZvbGxvd2luZyBwYXRjaCAKPiBhbmQg
Y2hlY2sgd2hldGhlciBpdCBjYW4gZml4IHRoZSBpc3N1ZS4KClRoZSBwYXRjaCBpcyBtYW5nbGVk
LiBJcyB0aGUgb25seSBkaWZmZXJlbmNlIHdoZXJlIHNldF9tZW1vcnlfZGVjcnlwdGVkKCkgCmlz
IGNhbGxlZD8KClRoYW5rcywKVG9tCgo+IAo+IAo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4
L3N3aW90bGIuaCBiL2luY2x1ZGUvbGludXgvc3dpb3RsYi5oCj4gaW5kZXggNTY5MjcyODcxMzc1
Li5mNmMzNjM4MjU1ZDUgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS9saW51eC9zd2lvdGxiLmgKPiAr
KysgYi9pbmNsdWRlL2xpbnV4L3N3aW90bGIuaAo+IEBAIC03Myw2ICs3Myw5IEBAIGV4dGVybiBl
bnVtIHN3aW90bGJfZm9yY2Ugc3dpb3RsYl9mb3JjZTsKPiAgwqAgKiBAZW5kOsKgwqDCoMKgwqDC
oCBUaGUgZW5kIGFkZHJlc3Mgb2YgdGhlIHN3aW90bGIgbWVtb3J5IHBvb2wuIFVzZWQgdG8gZG8g
YSAKPiBxdWljawo+ICDCoCAqwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJhbmdlIGNoZWNrIHRv
IHNlZSBpZiB0aGUgbWVtb3J5IHdhcyBpbiBmYWN0IGFsbG9jYXRlZCBieSAKPiB0aGlzCj4gIMKg
ICrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQVBJLgo+ICsgKiBAdmFkZHI6wqDCoMKgwqAgVGhl
IHZhZGRyIG9mIHRoZSBzd2lvdGxiIG1lbW9yeSBwb29sLiBUaGUgc3dpb3RsYiBtZW1vcnkgcG9v
bAo+ICsgKsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtYXkgYmUgcmVtYXBwZWQgaW4gdGhlIG1l
bW9yeSBlbmNyeXB0ZWQgY2FzZSBhbmQgc3RvcmUgCj4gdmlydHVhbAo+ICsgKsKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBhZGRyZXNzIGZvciBib3VuY2UgYnVmZmVyIG9wZXJhdGlvbi4KPiAgwqAg
KiBAbnNsYWJzOsKgwqDCoCBUaGUgbnVtYmVyIG9mIElPIFRMQiBibG9ja3MgKGluIGdyb3VwcyBv
ZiA2NCkgYmV0d2VlbiAKPiBAc3RhcnQgYW5kCj4gIMKgICrCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgQGVuZC4gRm9yIGRlZmF1bHQgc3dpb3RsYiwgdGhpcyBpcyBjb21tYW5kIGxpbmUgCj4gYWRq
dXN0YWJsZSB2aWEKPiAgwqAgKsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzZXR1cF9pb190bGJf
bnBhZ2VzLgo+IEBAIC05Miw2ICs5NSw3IEBAIGV4dGVybiBlbnVtIHN3aW90bGJfZm9yY2Ugc3dp
b3RsYl9mb3JjZTsKPiAgwqBzdHJ1Y3QgaW9fdGxiX21lbSB7Cj4gIMKgwqDCoMKgwqDCoMKgIHBo
eXNfYWRkcl90IHN0YXJ0Owo+ICDCoMKgwqDCoMKgwqDCoCBwaHlzX2FkZHJfdCBlbmQ7Cj4gK8Kg
wqDCoMKgwqDCoCB2b2lkICp2YWRkcjsKPiAgwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgbG9uZyBu
c2xhYnM7Cj4gIMKgwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGxvbmcgdXNlZDsKPiAgwqDCoMKgwqDC
oMKgwqAgdW5zaWduZWQgaW50IGluZGV4Owo+IEBAIC0xODYsNCArMTkwLDYgQEAgc3RhdGljIGlu
bGluZSBib29sIGlzX3N3aW90bGJfZm9yX2FsbG9jKHN0cnVjdCBkZXZpY2UgCj4gKmRldikKPiAg
wqB9Cj4gIMKgI2VuZGlmIC8qIENPTkZJR19ETUFfUkVTVFJJQ1RFRF9QT09MICovCj4gCj4gK2V4
dGVybiBwaHlzX2FkZHJfdCBzd2lvdGxiX3VuZW5jcnlwdGVkX2Jhc2U7Cj4gKwo+ICDCoCNlbmRp
ZiAvKiBfX0xJTlVYX1NXSU9UTEJfSCAqLwo+IGRpZmYgLS1naXQgYS9rZXJuZWwvZG1hL3N3aW90
bGIuYyBiL2tlcm5lbC9kbWEvc3dpb3RsYi5jCj4gaW5kZXggOGU4NDBmYmJlZDdjLi4zNGU2YWRl
NGY3M2MgMTAwNjQ0Cj4gLS0tIGEva2VybmVsL2RtYS9zd2lvdGxiLmMKPiArKysgYi9rZXJuZWwv
ZG1hL3N3aW90bGIuYwo+IEBAIC01MCw2ICs1MCw3IEBACj4gIMKgI2luY2x1ZGUgPGFzbS9pby5o
Pgo+ICDCoCNpbmNsdWRlIDxhc20vZG1hLmg+Cj4gCj4gKyNpbmNsdWRlIDxsaW51eC9pby5oPgo+
ICDCoCNpbmNsdWRlIDxsaW51eC9pbml0Lmg+Cj4gIMKgI2luY2x1ZGUgPGxpbnV4L21lbWJsb2Nr
Lmg+Cj4gIMKgI2luY2x1ZGUgPGxpbnV4L2lvbW11LWhlbHBlci5oPgo+IEBAIC03Miw2ICs3Myw4
IEBAIGVudW0gc3dpb3RsYl9mb3JjZSBzd2lvdGxiX2ZvcmNlOwo+IAo+ICDCoHN0cnVjdCBpb190
bGJfbWVtIGlvX3RsYl9kZWZhdWx0X21lbTsKPiAKPiArcGh5c19hZGRyX3Qgc3dpb3RsYl91bmVu
Y3J5cHRlZF9iYXNlOwo+ICsKPiAgwqAvKgo+ICDCoCAqIE1heCBzZWdtZW50IHRoYXQgd2UgY2Fu
IHByb3ZpZGUgd2hpY2ggKGlmIHBhZ2VzIGFyZSBjb250aW5nb3VzKSB3aWxsCj4gIMKgICogbm90
IGJlIGJvdW5jZWQgKHVubGVzcyBTV0lPVExCX0ZPUkNFIGlzIHNldCkuCj4gQEAgLTE1NSw2ICsx
NTgsMjcgQEAgc3RhdGljIGlubGluZSB1bnNpZ25lZCBsb25nIG5yX3Nsb3RzKHU2NCB2YWwpCj4g
IMKgwqDCoMKgwqDCoMKgIHJldHVybiBESVZfUk9VTkRfVVAodmFsLCBJT19UTEJfU0laRSk7Cj4g
IMKgfQo+IAo+ICsvKgo+ICsgKiBSZW1hcCBzd2lvbHRiIG1lbW9yeSBpbiB0aGUgdW5lbmNyeXB0
ZWQgcGh5c2ljYWwgYWRkcmVzcyBzcGFjZQo+ICsgKiB3aGVuIHN3aW90bGJfdW5lbmNyeXB0ZWRf
YmFzZSBpcyBzZXQuIChlLmcuIGZvciBIeXBlci1WIEFNRCBTRVYtU05QCj4gKyAqIElzb2xhdGlv
biBWTXMpLgo+ICsgKi8KPiArdm9pZCAqc3dpb3RsYl9tZW1fcmVtYXAoc3RydWN0IGlvX3RsYl9t
ZW0gKm1lbSwgdW5zaWduZWQgbG9uZyBieXRlcykKPiArewo+ICvCoMKgwqDCoMKgwqAgdm9pZCAq
dmFkZHIgPSBOVUxMOwo+ICsKPiArwqDCoMKgwqDCoMKgIGlmIChzd2lvdGxiX3VuZW5jcnlwdGVk
X2Jhc2UpIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwaHlzX2FkZHJfdCBwYWRk
ciA9IG1lbS0+c3RhcnQgKyBzd2lvdGxiX3VuZW5jcnlwdGVkX2Jhc2U7Cj4gKwo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZhZGRyID0gbWVtcmVtYXAocGFkZHIsIGJ5dGVzLCBNRU1S
RU1BUF9XQik7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCF2YWRkcikKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcHJfZXJyKCJGYWls
ZWQgdG8gbWFwIHRoZSB1bmVuY3J5cHRlZCBtZW1vcnkgJWxseCAKPiBzaXplICVseC5cbiIsCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgcGFkZHIsIGJ5dGVzKTsKPiArwqDCoMKgwqDCoMKgIH0KPiArCj4gK8KgwqDCoMKgwqDCoCBy
ZXR1cm4gdmFkZHI7Cj4gK30KPiArCj4gIMKgLyoKPiAgwqAgKiBFYXJseSBTV0lPVExCIGFsbG9j
YXRpb24gbWF5IGJlIHRvbyBlYXJseSB0byBhbGxvdyBhbiBhcmNoaXRlY3R1cmUgdG8KPiAgwqAg
KiBwZXJmb3JtIHRoZSBkZXNpcmVkIG9wZXJhdGlvbnMuwqAgVGhpcyBmdW5jdGlvbiBhbGxvd3Mg
dGhlIAo+IGFyY2hpdGVjdHVyZSB0bwo+IEBAIC0xNzIsNyArMTk2LDEyIEBAIHZvaWQgX19pbml0
IHN3aW90bGJfdXBkYXRlX21lbV9hdHRyaWJ1dGVzKHZvaWQpCj4gIMKgwqDCoMKgwqDCoMKgIHZh
ZGRyID0gcGh5c190b192aXJ0KG1lbS0+c3RhcnQpOwo+ICDCoMKgwqDCoMKgwqDCoCBieXRlcyA9
IFBBR0VfQUxJR04obWVtLT5uc2xhYnMgPDwgSU9fVExCX1NISUZUKTsKPiAgwqDCoMKgwqDCoMKg
wqAgc2V0X21lbW9yeV9kZWNyeXB0ZWQoKHVuc2lnbmVkIGxvbmcpdmFkZHIsIGJ5dGVzID4+IFBB
R0VfU0hJRlQpOwo+IC3CoMKgwqDCoMKgwqAgbWVtc2V0KHZhZGRyLCAwLCBieXRlcyk7Cj4gKwo+
ICvCoMKgwqDCoMKgwqAgbWVtLT52YWRkciA9IHN3aW90bGJfbWVtX3JlbWFwKG1lbSwgYnl0ZXMp
Owo+ICvCoMKgwqDCoMKgwqAgaWYgKCFtZW0tPnZhZGRyKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIG1lbS0+dmFkZHIgPSB2YWRkcjsKPiArCj4gK8KgwqDCoMKgwqDCoCBtZW1zZXQo
bWVtLT52YWRkciwgMCwgYnl0ZXMpOwo+ICDCoH0KPiAKPiAgwqBzdGF0aWMgdm9pZCBzd2lvdGxi
X2luaXRfaW9fdGxiX21lbShzdHJ1Y3QgaW9fdGxiX21lbSAqbWVtLCBwaHlzX2FkZHJfdCAKPiBz
dGFydCwKPiBAQCAtMTk2LDcgKzIyNSwxNyBAQCBzdGF0aWMgdm9pZCBzd2lvdGxiX2luaXRfaW9f
dGxiX21lbShzdHJ1Y3QgaW9fdGxiX21lbSAKPiAqbWVtLCBwaHlzX2FkZHJfdCBzdGFydCwKPiAg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1lbS0+c2xvdHNbaV0ub3JpZ19hZGRyID0g
SU5WQUxJRF9QSFlTX0FERFI7Cj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtZW0t
PnNsb3RzW2ldLmFsbG9jX3NpemUgPSAwOwo+ICDCoMKgwqDCoMKgwqDCoCB9Cj4gKwo+ICvCoMKg
wqDCoMKgwqAgLyoKPiArwqDCoMKgwqDCoMKgwqAgKiBJZiBzd2lvdGxiX3VuZW5jcnlwdGVkX2Jh
c2UgaXMgc2V0LCB0aGUgYm91bmNlIGJ1ZmZlciBtZW1vcnkgd2lsbAo+ICvCoMKgwqDCoMKgwqDC
oCAqIGJlIHJlbWFwcGVkIGFuZCBjbGVhcmVkIGluIHN3aW90bGJfdXBkYXRlX21lbV9hdHRyaWJ1
dGVzLgo+ICvCoMKgwqDCoMKgwqDCoCAqLwo+ICvCoMKgwqDCoMKgwqAgaWYgKHN3aW90bGJfdW5l
bmNyeXB0ZWRfYmFzZSkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm47Cj4g
Kwo+ICDCoMKgwqDCoMKgwqDCoCBtZW1zZXQodmFkZHIsIDAsIGJ5dGVzKTsKPiArwqDCoMKgwqDC
oMKgIG1lbS0+dmFkZHIgPSB2YWRkcjsKPiArwqDCoMKgwqDCoMKgIHJldHVybjsKPiAgwqB9Cj4g
Cj4gIMKgaW50IF9faW5pdCBzd2lvdGxiX2luaXRfd2l0aF90YmwoY2hhciAqdGxiLCB1bnNpZ25l
ZCBsb25nIG5zbGFicywgaW50IAo+IHZlcmJvc2UpCj4gQEAgLTM3MSw3ICs0MTAsNyBAQCBzdGF0
aWMgdm9pZCBzd2lvdGxiX2JvdW5jZShzdHJ1Y3QgZGV2aWNlICpkZXYsIAo+IHBoeXNfYWRkcl90
IHRsYl9hZGRyLCBzaXplX3Qgc2l6ZQo+ICDCoMKgwqDCoMKgwqDCoCBwaHlzX2FkZHJfdCBvcmln
X2FkZHIgPSBtZW0tPnNsb3RzW2luZGV4XS5vcmlnX2FkZHI7Cj4gIMKgwqDCoMKgwqDCoMKgIHNp
emVfdCBhbGxvY19zaXplID0gbWVtLT5zbG90c1tpbmRleF0uYWxsb2Nfc2l6ZTsKPiAgwqDCoMKg
wqDCoMKgwqAgdW5zaWduZWQgbG9uZyBwZm4gPSBQRk5fRE9XTihvcmlnX2FkZHIpOwo+IC3CoMKg
wqDCoMKgwqAgdW5zaWduZWQgY2hhciAqdmFkZHIgPSBwaHlzX3RvX3ZpcnQodGxiX2FkZHIpOwo+
ICvCoMKgwqDCoMKgwqAgdW5zaWduZWQgY2hhciAqdmFkZHIgPSBtZW0tPnZhZGRyICsgdGxiX2Fk
ZHIgLSBtZW0tPnN0YXJ0Owo+ICDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBpbnQgdGxiX29mZnNl
dCwgb3JpZ19hZGRyX29mZnNldDsKPiAKPiAgwqDCoMKgwqDCoMKgwqAgaWYgKG9yaWdfYWRkciA9
PSBJTlZBTElEX1BIWVNfQUREUikKPiAKPiAKPiBUaGFua3MuCj4gCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
