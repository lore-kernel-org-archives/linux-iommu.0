Return-Path: <SRS0=amFV=MT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1268FC4338F
	for <iommu@archiver.kernel.org>; Tue, 27 Jul 2021 14:06:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA11261A84
	for <iommu@archiver.kernel.org>; Tue, 27 Jul 2021 14:06:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AA11261A84
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 75CD882BC4;
	Tue, 27 Jul 2021 14:06:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dWJlxNHCP1V2; Tue, 27 Jul 2021 14:06:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C07C182B75;
	Tue, 27 Jul 2021 14:06:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E22AC0010;
	Tue, 27 Jul 2021 14:06:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 82D73C000E
 for <iommu@lists.linux-foundation.org>; Tue, 27 Jul 2021 14:06:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 77600402C4
 for <iommu@lists.linux-foundation.org>; Tue, 27 Jul 2021 14:06:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9YXGMZlut-nd for <iommu@lists.linux-foundation.org>;
 Tue, 27 Jul 2021 14:05:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0CAD2402C3
 for <iommu@lists.linux-foundation.org>; Tue, 27 Jul 2021 14:05:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CbjA7FR6guOLheWabm/al6l5xZ5pNnn2+h+mx0jKPF8OdC/hR+ZKVOLMQBj3O+/8wzBFTt61FB3f+zCQsThKbIgQcFDsC4UL5DUwBqw6gKByoyKwdmo2S6OLcrzfvk7xeUqEyuIQ5cKPue54st8Y+XFokSeVWDzIJc+UdzeFa/vujc+dcSG5FtVOPDZ1Fe11gxQcRQFC2JuZH5Od7GamBVzuRZBxchKYaycdrOWnEZmSqrwvczJ6MMJNMNCd/o8qt0OQctUPXc+8j8lem6fC012Xm6ztmvfaVaf8sOSbdHFNANSR9QZRAp9JG1CCDqZXhfnzPjPaygaE0eeddVDXFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oy56LNTUKCMfq780MCSf6XraXvAveRezsOdQJG/aMF8=;
 b=JU103x8xHJNWhwn8EuWhoztGn0jNoTLMTQ9FXY+gMKbOdLi/1tW1McQ29zzN6jrF+Oma4dWticXsZS50skSr/baJJoOGeoHzNJ3CU+AjSNZDuEyuMeT0s/yK+MnCPLcvhs3iHUJzPgGVefRsb8+0A3MObMojZaNjUFnaY/2ataatGLvaIAgTJcwAEJsCJyED5GiRF7IKpOPdQ9FkF0tK39pMsicEoVUZV0nUgUvMt1T8Jc2uKgrsN63h3IciOO1Tc+oMo2tluTnUyrZRlJmVFpa1s7NUjlskaff16RQa17IuebmWJnI+n9pRXgRNepoQ7kOj7A2UVStElc9WZiihXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oy56LNTUKCMfq780MCSf6XraXvAveRezsOdQJG/aMF8=;
 b=0E8lkPXN+8Bm7EQX+1KGnOXgTVOpRkjAN4Tqlh091FH92J+8buenP3JwbLEoBnW2p4F0mWIZuQQWxjY7nqWP9ks1J/dTaHGe+dnvwjMdpAQUY7HDf3CdTRkEESBwVUNX40PBquVfejWLQUZ6RBFenaDDzlQCcLiUP8CmfGxqu6k=
Received: from DM8PR12MB5478.namprd12.prod.outlook.com (2603:10b6:8:29::12) by
 DM4PR12MB5325.namprd12.prod.outlook.com (2603:10b6:5:39e::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.18; Tue, 27 Jul 2021 14:05:55 +0000
Received: from DM8PR12MB5478.namprd12.prod.outlook.com
 ([fe80::9dce:d45f:88c7:8a72]) by DM8PR12MB5478.namprd12.prod.outlook.com
 ([fe80::9dce:d45f:88c7:8a72%9]) with mapi id 15.20.4352.031; Tue, 27 Jul 2021
 14:05:55 +0000
To: Robin Murphy <robin.murphy@arm.com>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH] iommu/iova: kmemleak when disable SRIOV.
Thread-Topic: [PATCH] iommu/iova: kmemleak when disable SRIOV.
Thread-Index: AQHXftHncp563ylbik+a4AZQduZFMKtPFoAAgAcppICAAEt+gIAAVxPQ
Date: Tue, 27 Jul 2021 14:05:55 +0000
Message-ID: <DM8PR12MB5478DD7F296EB264848680EEF8E99@DM8PR12MB5478.namprd12.prod.outlook.com>
References: <20210722081629.7863-1-PengJu.Zhou@amd.com>
 <4b59b7ee-5258-a2ca-531c-b1b5d9c064e7@arm.com>
 <DM8PR12MB5478D90255FF1379E44AC51AF8E99@DM8PR12MB5478.namprd12.prod.outlook.com>
 <c86a8861-64b5-92dc-b664-b31402f23db3@arm.com>
In-Reply-To: <c86a8861-64b5-92dc-b664-b31402f23db3@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-27T14:05:53Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=621342b8-e7c1-4b5a-a06d-928ecb49d526;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 212df4b5-a26e-428e-d50f-08d95107a700
x-ms-traffictypediagnostic: DM4PR12MB5325:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB5325BB9AFA1C247C1CB762D7F8E99@DM4PR12MB5325.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:741;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5jwd2ylSuoCjQo+DwQOkC/ecihzd7VbtwhUz8HrqzKcxhLQUBjRNQf54RazrU1eBB2a2i0NkqBjiTMbSzWn0ETdnHlCmzmtR5XciYtlmdNCoNuSKCTb3iROkF/3Znq3Xy1dcBpKuQTAolkqcXMmk/cShJAzx+Xls0rS7IQaTs62m3JNkfikbLynPBuTXKcvXRjzEz7Yjg1e5hmD4fRxurKhwJHq7ZXJVuMju+WL+mDz0lmQa6KQsYKVTShAkcxGROA9vGYWVhxPBIoVnRnZkmfnzBeuvX7G2BOnFJ0P+2rPKFXSBjT0aIuhwdtE+InylKpDlouD8s8cvbauEj3y1s+Yab9/PYbBV9A8+NqMHO4mXq/bAPditXuCTwLzWs9fA6UBa92ymvm5lQtuE3r2bIST9WBnhJA2GxuF40F8nMkWgu/s4eVeG7h6VCPJkHJPMtmRwhmSWaUYW4aKnliu4FITAq2kKrRgZHS4p8oA1Z3ohS/nS4woKF16v24iyZrUnuiZeOildvphDn9Fhpa/Gvofq4q6ajM54GlI9Ukv2rgPIRTKRAHY0tuJhhQ0IdSboHSbscSWVJbh3wnPi8saKD0Xo42PN+h2KOIvv9vs0/m4EVyHQyE8D3qFMlxKUzlEb6mMPopn23XX+KFNMvnb2l8MbFXCqof0mdBOAG7boprU8rnUTa2uVCGfoYru2wLc2/4Ef+j1Eo7a4pNwhc2srwA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5478.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(122000001)(7696005)(52536014)(55016002)(38100700002)(5660300002)(33656002)(6506007)(26005)(53546011)(86362001)(4326008)(30864003)(71200400001)(110136005)(54906003)(186003)(76116006)(66556008)(966005)(83380400001)(8936002)(2906002)(478600001)(66446008)(64756008)(66476007)(8676002)(9686003)(316002)(66946007)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dlhIVk1qTnFKR3lMVks0T0ZxUnB0d0tzZ2xZY0FZVnRCcTBJdkdxNVk2YUFp?=
 =?utf-8?B?ZHdPS2JseFlMeTVRZHhtMzlvTlAzUnY1UnUzOTdtTzJtNSszUjF1ZXlLVURp?=
 =?utf-8?B?dmkzMHlxSUF4WUhDWmlpb2ZuNndrZXpIRC8wSjVySW9NclJGVExWdzU0NjJp?=
 =?utf-8?B?dWtyd2QxUm5NMXBNRFgyTmluZ3YrSFpwOEtWNkY0OXBFdUdkVUg3MmtiMkhX?=
 =?utf-8?B?YXd0NG1YM0xVOEc0N3prNnVjVTZ4VzEzUHRLOFdMdnV5dng0eWQwZW81QWht?=
 =?utf-8?B?RisrSlVZU0twd1dubUVDUStoaFJpU0NVblVmTGVRMFFxT01JM1A4cjc4a2sv?=
 =?utf-8?B?ZWs2UDY3ZEltN044T2g3ZkJRc1JTOVltd1Y2THdiUElJWUhmMkE4TnhhemFO?=
 =?utf-8?B?T3lKcW9DS1k1UUxKanFJM0lrTUY0RndWeXEzb3VaNzBUT01tOStDVnYxRm8x?=
 =?utf-8?B?UStJaUJia2hBWU54R09RdG80c3pGZEs3bVBTSmM3MzIzOVNyTGhvZFNjRzFt?=
 =?utf-8?B?Y1JlQTBLUkFvMmMzYmVqd0o5dFNKbTRaS2pMeit3dGg4RmViUzN6WEFTRFg2?=
 =?utf-8?B?UDFPY2JMNHlVSjhoT3psLzlEZ3BydFF4RUlLNUJhY2w4Tit6RlVVUmJZUmdx?=
 =?utf-8?B?ZUFhaWJpSW1MSUtZWGNjUktPRHZCYkJLM0FYNzQ3c0hyQnZZclZYcmJTQmFP?=
 =?utf-8?B?bXRQZmhneGdpYTlyNjdUTEZ0ZFo2T0tiM2RaRSt0aC94QnBaSkRqalFldjU2?=
 =?utf-8?B?aE9ia0grS1RlQjArMXZCdTFEWk04NWFxV1c3cjRJOFJRTDFLbS9BanFZMWU2?=
 =?utf-8?B?dnpzalU4TVFTcFJGYnRUdFRRaFJVaEtkcnZYNDZkRkNPdFRkVElJQlhxV2t2?=
 =?utf-8?B?ejZVbVkydlowYW5VS1lRMzN3RDVLTVh6SXNiSm9WQy9KUTlRQzFTNGk5R2RN?=
 =?utf-8?B?T2did1djaUFSeW5kNFFOb2EvNXNXNFNkYVNRWDhhTFNRSW5aaUNEMjE3SmJw?=
 =?utf-8?B?eEcrbTNjTzNiTVJyTjdhZ3NVNTdGY2JjWTdkdjNSekIvTU5rL2FZWUwzdDNW?=
 =?utf-8?B?OFRLZkYvYk1jNGJZVjNFKzl1TjEvN2E3cDJIc2xOUWNhWGMwL2h4UXE4anNa?=
 =?utf-8?B?ZzB5OVpFZ1RuSk5GbmUxNDdRdytnREpXd1RkRXlMWUM5SWQ5ZTJ3OUJYYzFn?=
 =?utf-8?B?OTRuUGR1N0hwTlF1RXdRVDZsWGxHQ3ZCYVE1cEtkTFYrQ0kzNVZNVzlZbnFH?=
 =?utf-8?B?SmNQS0ZoRjV0VGFBOHg2NnFoVms4WXFLTUpJbXkvZ1Fmd0NKeEltemh2dy9V?=
 =?utf-8?B?VWViZ2J6WWc0ai9lU0hkSDRmMHI4UlBldjIzeHdJdkRqR21YMjRhTDhrZ1dS?=
 =?utf-8?B?cnFpVHcxVTVnVEtjR1JhcUgyOHVUdGxITXk2VEF3alpUc2ptcWtvUmZtUE5B?=
 =?utf-8?B?NEplRUgxT0NHTjlDVVhSdk1LTGtwT282dmR5Nnc4VHBHSllvUUwzMlpOSVcr?=
 =?utf-8?B?c0NZSmRiT045Y1hXQk1ueDhLQldFcTJQUnlEZDU1T3NnWUh5dEUzTkJMK1l5?=
 =?utf-8?B?azlzSlZRcWltdXF6Vkx4L0s4S1FnRXAwQy83eXBsU25sZFpkRUx0cEhkZjFJ?=
 =?utf-8?B?ZG9lVGE5ZjlsNlFDYVdsekZvNmpxT21vMzQyclJjbDJYS09OaEkvc2M4WHor?=
 =?utf-8?B?V28wQTBkYjNHY0FML2JOaEdlaWFydVFkSWlJK3JQSzMrem5XUzBzdFNuY3M3?=
 =?utf-8?Q?FQ/Uk0ihpp+INEq4rxTfPK2gVQI61vtTCogpVqZ?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5478.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 212df4b5-a26e-428e-d50f-08d95107a700
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2021 14:05:55.6712 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tqx+A4l/ocPTnH3kDESpCV3Yw2pck6meq5pthNzvu2O9Xqm9DGrU/FwR3mhaFttCow7+yaAPoyLW03rGhsfxSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5325
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wang,
 Yin" <Yin.Wang@amd.com>, "will@kernel.org" <will@kernel.org>
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
From: "Zhou, Peng Ju via iommu" <iommu@lists.linux-foundation.org>
Reply-To: "Zhou, Peng Ju" <PengJu.Zhou@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

[AMD Official Use Only]

Hi Robin
The patch which add "head" :

commit 48a64dd561a53fb809e3f2210faf5dd442cfc56d
Author: Chris Wilson <chris@chris-wilson.co.uk>
Date:   Sat Jan 16 11:10:35 2021 +0000

    iommu/iova: Use bottom-up allocation for DMA32

    Since DMA32 allocations are currently allocated top-down from the 4G
    boundary, this causes fragmentation and reduces the maximise allocation
    size. On some systems, the dma address space may be extremely
    constrained by PCIe windows, requiring a stronger anti-fragmentation
    strategy.

    Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/2929
    Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>


---------------------------------------------------------------------- 
BW
Pengju Zhou



> -----Original Message-----
> From: Robin Murphy <robin.murphy@arm.com>
> Sent: Tuesday, July 27, 2021 4:52 PM
> To: Zhou, Peng Ju <PengJu.Zhou@amd.com>; iommu@lists.linux-
> foundation.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Yin
> <Yin.Wang@amd.com>; will@kernel.org
> Subject: Re: [PATCH] iommu/iova: kmemleak when disable SRIOV.
> 
> On 2021-07-27 05:46, Zhou, Peng Ju wrote:
> > [AMD Official Use Only]
> >
> > Hi Robin
> > 1. it is not a good manner to free a statically allocated object(in this case, it
> is iovad->head) dynamically even though the free only occurred when shut
> down the OS in most cases.
> > 2. the kmemleak occurred when disable SRIOV(remove a PCIE device), I
> > post the log in the following, in the log, the line:" kmemleak: Found
> > object by alias at 0xffff9221ae647050" means the OS frees a not
> > existing object(iovad->head) which added to RB_TREE in the function
> > init_iova_domain
> 
> Sure, it was apparent enough what the bug was; my point is that the bug
> does not exist in mainline. This is the current mainline definition of struct
> iova_domain:
> 
> 
> /* holds all the iova translations for a domain */ struct iova_domain {
> 	spinlock_t	iova_rbtree_lock; /* Lock to protect update of rbtree
> */
> 	struct rb_root	rbroot;		/* iova domain rbtree root */
> 	struct rb_node	*cached_node;	/* Save last alloced node */
> 	struct rb_node	*cached32_node; /* Save last 32-bit alloced node */
> 	unsigned long	granule;	/* pfn granularity for this domain */
> 	unsigned long	start_pfn;	/* Lower limit for this domain */
> 	unsigned long	dma_32bit_pfn;
> 	unsigned long	max32_alloc_size; /* Size of last failed allocation */
> 	struct iova_fq __percpu *fq;	/* Flush Queue */
> 
> 	atomic64_t	fq_flush_start_cnt;	/* Number of TLB flushes
> that
> 						   have been started */
> 
> 	atomic64_t	fq_flush_finish_cnt;	/* Number of TLB flushes
> that
> 						   have been finished */
> 
> 	struct iova	anchor;		/* rbtree lookup anchor */
> 	struct iova_rcache rcaches[IOVA_RANGE_CACHE_MAX_SIZE];	/*
> IOVA range caches */
> 
> 	iova_flush_cb	flush_cb;	/* Call-Back function to flush IOMMU
> 					   TLBs */
> 
> 	iova_entry_dtor entry_dtor;	/* IOMMU driver specific destructor
> for
> 					   iova entry */
> 
> 	struct timer_list fq_timer;		/* Timer to regularily empty
> the
> 						   flush-queues */
> 	atomic_t fq_timer_on;			/* 1 when timer is active, 0
> 						   when not */
> 	struct hlist_node	cpuhp_dead;
> };
> 
> 
> Please point to where "head" exists either way ;)
> 
> The mainline code already has a special case to avoid trying to free the
> statically-allocated "anchor" node. Whoever modified your kernel has
> apparently failed to preserve the equivalent behaviour.
> 
> Robin.
> 
> > The patch I sent out may don't meet IOMMU requirement because I have
> no knowledge of the background of IOMMU, but this patch can fix this
> kmemleak.
> >
> > The kmemleak log on my server:
> > 316613 Jul 19 02:14:20 z-u18 kernel: [  108.967526] pci 0000:83:02.0:
> > Removing from iommu group 108
> > 316614 Jul 19 02:14:20 z-u18 kernel: [  108.969032] kmemleak: Found
> object by alias at 0xffff9221ae647050
> > 316615 Jul 19 02:14:20 z-u18 kernel: [  108.969037] CPU: 30 PID: 2768
> Comm: modprobe Tainted: G           OE     5.11.0 #       12
> > 316616 Jul 19 02:14:20 z-u18 kernel: [  108.969042] Hardware name:
> Supermicro ...
> > 316617 Jul 19 02:14:20 z-u18 kernel: [  108.969045] Call Trace:
> > 316618 Jul 19 02:14:20 z-u18 kernel: [  108.969049]
> > dump_stack+0x6d/0x88
> > 316619 Jul 19 02:14:20 z-u18 kernel: [  108.969061]
> > lookup_object+0x5f/0x70
> > 316620 Jul 19 02:14:20 z-u18 kernel: [  108.969070]
> > find_and_remove_object+0x29/0x80
> > 316621 Jul 19 02:14:20 z-u18 kernel: [  108.969077]
> > delete_object_full+0xc/0x20
> > 316622 Jul 19 02:14:20 z-u18 kernel: [  108.969083]
> > kmem_cache_free+0x22b/0x410
> > 316623 Jul 19 02:14:20 z-u18 kernel: [  108.969097]
> > free_iova_mem+0x22/0x60
> > 316624 Jul 19 02:14:20 z-u18 kernel: [  108.969103]
> > put_iova_domain+0x1b5/0x1e0
> > 316625 Jul 19 02:14:20 z-u18 kernel: [  108.969108]
> > iommu_put_dma_cookie+0x44/0xc0
> > 316626 Jul 19 02:14:20 z-u18 kernel: [  108.969118]
> > domain_exit+0xba/0xc0
> > 316627 Jul 19 02:14:20 z-u18 kernel: [  108.969123]
> > iommu_group_release+0x51/0x90
> > 316628 Jul 19 02:14:20 z-u18 kernel: [  108.969129]
> > kobject_put+0xa7/0x210
> > 316629 Jul 19 02:14:20 z-u18 kernel: [  108.969140]
> > iommu_release_device+0x41/0x80
> > 316630 Jul 19 02:14:20 z-u18 kernel: [  108.969147]
> > iommu_bus_notifier+0xa0/0xc0
> > 316631 Jul 19 02:14:20 z-u18 kernel: [  108.969153]
> > blocking_notifier_call_chain+0x63/0x90
> > 316632 Jul 19 02:14:20 z-u18 kernel: [  108.969162]
> > device_del+0x29c/0x3f0
> > 316633 Jul 19 02:14:20 z-u18 kernel: [  108.969167]
> > pci_remove_bus_device+0x77/0x100
> > 316634 Jul 19 02:14:20 z-u18 kernel: [  108.969178]
> > pci_iov_remove_virtfn+0xbc/0x110
> > 316635 Jul 19 02:14:20 z-u18 kernel: [  108.969187]
> > sriov_disable+0x2f/0xe0 ......
> > 316651 Jul 19 02:14:20 z-u18 kernel: [  108.969629] RIP:
> 0033:0x7f6d8ec45047
> > 316652 Jul 19 02:14:20 z-u18 kernel: [  108.969634] Code: 73 01 c3 48 8b
> 0d 41 8e 2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66        2e 0f 1f 84 00 00 00 00
> 00 0f 1f 44 00 00 b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d
> 11 8e 2c 00 f       7 d8 64 89 01 48
> > 316653 Jul 19 02:14:20 z-u18 kernel: [  108.969638] RSP:
> 002b:00007ffc18dafc48 EFLAGS: 00000206 ORIG_RAX: 00000000000000b
> 0
> > 316654 Jul 19 02:14:20 z-u18 kernel: [  108.969645] RAX:
> > ffffffffffffffda RBX: 000055817f00adc0 RCX: 00007f6d8ec45047
> > 316655 Jul 19 02:14:20 z-u18 kernel: [  108.969648] RDX:
> > 0000000000000000 RSI: 0000000000000800 RDI: 000055817f00ae28
> > 316656 Jul 19 02:14:20 z-u18 kernel: [  108.969651] RBP:
> > 000055817f00adc0 R08: 00007ffc18daebf1 R09: 0000000000000000
> > 316657 Jul 19 02:14:20 z-u18 kernel: [  108.969654] R10:
> > 00007f6d8ecc1c40 R11: 0000000000000206 R12: 000055817f00ae28
> > 316658 Jul 19 02:14:20 z-u18 kernel: [  108.969656] R13:
> > 0000000000000001 R14: 000055817f00ae28 R15: 00007ffc18db1030
> > 316659 Jul 19 02:14:20 z-u18 kernel: [  108.969661] kmemleak: Object
> 0xffff9221ae647000 (size 2048):
> > 316660 Jul 19 02:14:20 z-u18 kernel: [  108.969665] kmemleak:   comm
> "gpu_init_thread", pid 2687, jiffies 4294911321
> > 316661 Jul 19 02:14:20 z-u18 kernel: [  108.969669] kmemleak:
> min_count = 1
> > 316662 Jul 19 02:14:20 z-u18 kernel: [  108.969671] kmemleak:   count = 0
> > 316663 Jul 19 02:14:20 z-u18 kernel: [  108.969672] kmemleak:   flags =
> 0x1
> > 316664 Jul 19 02:14:20 z-u18 kernel: [  108.969674] kmemleak:   checksum
> = 0
> > 316665 Jul 19 02:14:20 z-u18 kernel: [  108.969675] kmemleak:   backtrace:
> > 316666 Jul 19 02:14:20 z-u18 kernel: [  108.969677]
> cookie_alloc+0x1f/0x60
> > 316667 Jul 19 02:14:20 z-u18 kernel: [  108.969682]
> iommu_get_dma_cookie+0x17/0x30
> > 316668 Jul 19 02:14:20 z-u18 kernel: [  108.969685]
> intel_iommu_domain_alloc+0xa7/0xe0
> > 316669 Jul 19 02:14:20 z-u18 kernel: [  108.969689]
> iommu_group_alloc_default_domain+0x4c/0x160
> > 316670 Jul 19 02:14:20 z-u18 kernel: [  108.969695]
> iommu_probe_device+0xff/0x130
> > 316671 Jul 19 02:14:20 z-u18 kernel: [  108.969702]
> iommu_bus_notifier+0x7c/0xc0
> > 316672 Jul 19 02:14:20 z-u18 kernel: [  108.969708]
> blocking_notifier_call_chain+0x63/0x90
> > 316673 Jul 19 02:14:20 z-u18 kernel: [  108.969713]
> device_add+0x3f9/0x860
> > 316674 Jul 19 02:14:20 z-u18 kernel: [  108.969717]
> pci_device_add+0x2c3/0x6a0
> > 316675 Jul 19 02:14:20 z-u18 kernel: [  108.969723]
> pci_iov_add_virtfn+0x1b1/0x300
> > 316676 Jul 19 02:14:20 z-u18 kernel: [  108.969729]
> sriov_enable+0x254/0x410
> >
> >
> > ----------------------------------------------------------------------
> > BW
> > Pengju Zhou
> >
> >
> >
> >
> >> -----Original Message-----
> >> From: Robin Murphy <robin.murphy@arm.com>
> >> Sent: Thursday, July 22, 2021 10:59 PM
> >> To: Zhou, Peng Ju <PengJu.Zhou@amd.com>; iommu@lists.linux-
> >> foundation.org
> >> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Yin
> >> <Yin.Wang@amd.com>; will@kernel.org
> >> Subject: Re: [PATCH] iommu/iova: kmemleak when disable SRIOV.
> >>
> >> On 2021-07-22 09:16, Peng Ju Zhou via iommu wrote:
> >>> the object iova->head allocated statically when enable SRIOV but
> >>> freed dynamically when disable SRIOV which causing kmemleak.
> >>> changing the allocation from statically to dynamically.
> >>
> >> Thanks for the glimpse into the kind of weird and wonderful things
> >> people are doing to the IOVA allocator out-of-tree (the "holes" list
> >> sounds like an idea I also thought about a long time ago), but
> >> judging by the context this patch is clearly of no use to mainline ;)
> >>
> >> Robin.
> >>
> >>> Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
> >>> ---
> >>>    drivers/iommu/iova.c | 15 ++++++++-------
> >>>    include/linux/iova.h |  4 ++--
> >>>    2 files changed, 10 insertions(+), 9 deletions(-)
> >>>
> >>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c index
> >>> 2371524796d3..505881d8d97f 100644
> >>> --- a/drivers/iommu/iova.c
> >>> +++ b/drivers/iommu/iova.c
> >>> @@ -26,6 +26,8 @@ static void free_iova_rcaches(struct iova_domain
> >> *iovad);
> >>>    static void fq_destroy_all_entries(struct iova_domain *iovad);
> >>>    static void fq_flush_timeout(struct timer_list *t);
> >>>    static void free_global_cached_iovas(struct iova_domain *iovad);
> >>> +static inline struct iova *alloc_and_init_iova(unsigned long pfn_lo,
> >>> +					       unsigned long pfn_hi);
> >>>
> >>>    void
> >>>    init_iova_domain(struct iova_domain *iovad, unsigned long
> >>> granule, @@ -47,17 +49,16 @@ init_iova_domain(struct iova_domain
> >>> *iovad, unsigned long granule,
> >>>
> >>>    	INIT_LIST_HEAD(&iovad->holes);
> >>>
> >>> -	iovad->head.pfn_lo = 0;
> >>> -	iovad->head.pfn_hi = start_pfn;
> >>> -	rb_link_node(&iovad->head.node, NULL, &iovad->rbroot.rb_node);
> >>> -	rb_insert_color(&iovad->head.node, &iovad->rbroot);
> >>> -	list_add(&iovad->head.hole, &iovad->holes);
> >>> +	iovad->head = alloc_and_init_iova(0, start_pfn);
> >>> +	rb_link_node(&iovad->head->node, NULL, &iovad->rbroot.rb_node);
> >>> +	rb_insert_color(&iovad->head->node, &iovad->rbroot);
> >>> +	list_add(&iovad->head->hole, &iovad->holes);
> >>>
> >>>    	iovad->tail.pfn_lo = IOVA_ANCHOR;
> >>>    	iovad->tail.pfn_hi = IOVA_ANCHOR;
> >>>    	rb_link_node(&iovad->tail.node,
> >>> -		     &iovad->head.node,
> >>> -		     &iovad->head.node.rb_right);
> >>> +		     &iovad->head->node,
> >>> +		     &iovad->head->node.rb_right);
> >>>    	rb_insert_color(&iovad->tail.node, &iovad->rbroot);
> >>>
> >>>    	init_iova_rcaches(iovad);
> >>> diff --git a/include/linux/iova.h b/include/linux/iova.h index
> >>> 076eb6cfc613..553905ef41fe 100644
> >>> --- a/include/linux/iova.h
> >>> +++ b/include/linux/iova.h
> >>> @@ -81,7 +81,7 @@ struct iova_domain {
> >>>    						   have been finished */
> >>>
> >>>    	struct list_head holes;
> >>> -	struct iova	head, tail;		/* rbtree lookup anchors */
> >>> +	struct iova	*head, tail;		/* rbtree lookup anchors */
> >>>    	struct iova_rcache rcaches[IOVA_RANGE_CACHE_MAX_SIZE];	/*
> >> IOVA range caches */
> >>>
> >>>    	iova_flush_cb	flush_cb;	/* Call-Back function to flush IOMMU
> >>> @@ -252,7 +252,7 @@ static inline void
> >>> free_cpu_cached_iovas(unsigned int cpu,
> >>>
> >>>    static inline unsigned long iovad_start_pfn(struct iova_domain *iovad)
> >>>    {
> >>> -	return iovad->head.pfn_hi;
> >>> +	return iovad->head->pfn_hi;
> >>>    }
> >>>
> >>>    #endif
> >>>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
