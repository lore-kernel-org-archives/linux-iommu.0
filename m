Return-Path: <SRS0=amFV=MT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1BEC4338F
	for <iommu@archiver.kernel.org>; Tue, 27 Jul 2021 04:47:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9759060FE4
	for <iommu@archiver.kernel.org>; Tue, 27 Jul 2021 04:47:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9759060FE4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4D9E882A3B;
	Tue, 27 Jul 2021 04:47:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id koYWhLfjRRS5; Tue, 27 Jul 2021 04:47:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DB9C182B53;
	Tue, 27 Jul 2021 04:47:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1FB6C001A;
	Tue, 27 Jul 2021 04:47:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D4C5BC000E
 for <iommu@lists.linux-foundation.org>; Tue, 27 Jul 2021 04:47:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AE84F82B53
 for <iommu@lists.linux-foundation.org>; Tue, 27 Jul 2021 04:47:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XFWy6TB3-cNB for <iommu@lists.linux-foundation.org>;
 Tue, 27 Jul 2021 04:47:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::61c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0055882A3B
 for <iommu@lists.linux-foundation.org>; Tue, 27 Jul 2021 04:47:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RPlNUfJOZYSTIfu0FD9A5aH7pDmmG9WIWkfxclMLJtArs0w8Had9doCgftV93Qplq4ulGs8sVVt7cnOZ8sUS2XizmeGwLx7obOf0Q6ECiQIKhZZAC6wEM+3WWzzTntn+YwtXifBHlbVvdEIJpZiF9qvF+WzRkWs4Ju5VHWlG4rgekbsDSZFwYQLp9Xq5RHhAXafcDEzz05uIWGSeQOjLlGYlNHfEsn6xamS8YxfIQR5MOsrvgjjk1iJ8H30Cp9SPN3yrWFvPncZqMXjP+snehgyFTIvOHTto4ViA3fOq8BBDvEYVpKvLIoQE+zIU+ZKMj8GGo0+hJf+rhoyXwSLnzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2x/FYkUY2oudA5gRzUmMbA4sAwbFsycibTYKbkbWivw=;
 b=JP2x/9Y2F6ZWyFZvw/AlBOuDKUZv2FNSnPwJXbIywspi0qqRSi5C5D5ueKOrx2acNqGzDgsaWJ+5l78fLpZWxIqu6+91Pu1hQZXH0LC/inxa5op70pua8ms3s4ayCQAEt6i8ik8t5kVkvkmQYG0iTVGlF/zusZ7sHH94rhfe+JK9TneGgZbO/kxfiqCX/KeO1Cjv1xy+nc2L7GWQYsAZtQqzPD2TgBvq14Bn+4+n3dD7rRWeRVCCuKDjIGcTojoVgt2t7X2D8GPhGu+FpJ/pO0j0G/jbyGT+cj5kYbXqZaykDEwYYYPe2EXWtutOJIOFE+sD1YzyUAj1tS/VJoiFbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2x/FYkUY2oudA5gRzUmMbA4sAwbFsycibTYKbkbWivw=;
 b=ufmM19qqvr66cF2oprcYnTlVJ1m7g/1N/Dw9XJBhpsP9FjC/M61wsmWzL/Oh4PcQ/pd2deqvnB/iTMwVquaCo/UKri38rPiwlQTePQjFlJTQia57PxXywJ7s5XmvblVToyQ4XrBmw97WXN/QNHxArVfVzcjncxy3lvEIPjh/fEs=
Received: from DM8PR12MB5478.namprd12.prod.outlook.com (2603:10b6:8:29::12) by
 DM4PR12MB5037.namprd12.prod.outlook.com (2603:10b6:5:388::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.25; Tue, 27 Jul 2021 04:46:58 +0000
Received: from DM8PR12MB5478.namprd12.prod.outlook.com
 ([fe80::9dce:d45f:88c7:8a72]) by DM8PR12MB5478.namprd12.prod.outlook.com
 ([fe80::9dce:d45f:88c7:8a72%9]) with mapi id 15.20.4352.031; Tue, 27 Jul 2021
 04:46:58 +0000
To: Robin Murphy <robin.murphy@arm.com>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH] iommu/iova: kmemleak when disable SRIOV.
Thread-Topic: [PATCH] iommu/iova: kmemleak when disable SRIOV.
Thread-Index: AQHXftHncp563ylbik+a4AZQduZFMKtPFoAAgAcppIA=
Date: Tue, 27 Jul 2021 04:46:58 +0000
Message-ID: <DM8PR12MB5478D90255FF1379E44AC51AF8E99@DM8PR12MB5478.namprd12.prod.outlook.com>
References: <20210722081629.7863-1-PengJu.Zhou@amd.com>
 <4b59b7ee-5258-a2ca-531c-b1b5d9c064e7@arm.com>
In-Reply-To: <4b59b7ee-5258-a2ca-531c-b1b5d9c064e7@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-27T04:46:54Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=e470ad35-4348-42e8-afe7-162be846bacf;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56d40e47-37ea-4e6f-1059-08d950b99128
x-ms-traffictypediagnostic: DM4PR12MB5037:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB503796F5FBB1CCF3931559CCF8E99@DM4PR12MB5037.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s5J6RQhQfEu7AxO1bAqNuHUUoWABVn5DgFqbqu4XnYan6dHN0KuZCbG3/gD2zpwtVLqHxscNRilihu5pDvexe955DLYFl8/5A+Mh1yJ8PLG3Ev+l8mtxrl7lHZgE4eshtXYA/Lv0LRFAbzj/b28A9iS6w+93WuMZKUBOagP6rLuzIXB1X6o67NEXBf3kjBm40I8C6cclWIk1G12TT9qVdZAH/+a38xdmLRyVw2Cc+9aBJxVEISg4IxzPkNHRD8/8l/34CJI6qUfqmhWMUSsoKWiHOBzfG49O2cBTmck511MZiVtZdjRYO/S5Opn7ZnSAvwPsIEJ7lN35xVRo+22mnk4cSoIuQRwjpsUeflmwuDAlzAilQk/9G3iTGD1WcQR47R69/2hMXIxo1v5D9Icgm82IfRtZ4T0Ow3zwXZJN6FH7VIpGHzLrfPXM7dR6n33AjDZ/ROXWQKa6Dg0urkdZ6bYEGO7bBftHS35sQhvscPZxIs/RZKw7E5vq9OfPczbOkZvIzKgJeeex9krhBmFn3pqAczt2lAlvXGdczYVT6TrWVGxL91CTqcQvLABQjO5reT+vuDiKXbcvQ2ubH3ng28e8CPhYnI2yXpuWP/ULy5MWI1051jQMRetQYLn/Tt3qXp6Ql9epb+yh5h4TTnDwdARJli/flr8v2N/0R5qaPVEJig8OxZrJKP+Io5Bemj6U/pC/vokNVKqgXuG8caWn9Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5478.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(376002)(136003)(366004)(55016002)(9686003)(6506007)(8936002)(7696005)(71200400001)(478600001)(26005)(53546011)(2906002)(316002)(66946007)(8676002)(86362001)(110136005)(54906003)(4326008)(38100700002)(83380400001)(5660300002)(76116006)(66556008)(52536014)(122000001)(66476007)(64756008)(186003)(33656002)(66446008)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UnhsUzk2T0ZLWWhkZjJQOG4zVjd6V29ZZHZ6a2U0T0tlZDIrdXdLZXduZ1V5?=
 =?utf-8?B?bHhERUsyWTN1bW9qaitoaFlqeEg2WTdyR3V2TXZpZVdjOCtiaDI2YTAvT05N?=
 =?utf-8?B?YzB1MWgzSXREWVlFRWIzbWpIbnFDS0VtZjJYOWh1VEh2eUNSZlJYSkVUTkhk?=
 =?utf-8?B?dExYWStLM2FMb29Fc2NBMTM0OHdBazVCbTVyVkthN0pTZWFRTVFBZHlMR3Ax?=
 =?utf-8?B?VVRDRlA2WWkyV2lmNjJlVlJtcWZOUFBkUlZqT0dQTW4zR3p1RlBWa28raTNh?=
 =?utf-8?B?N0RhdGpjeEN4cXRlL3hRQXBQaUtmUDlBZUxIMWt0eUJxTUFXOUFIMkdVMzE5?=
 =?utf-8?B?aE5tcW42YWkrajNVdFVMMC9UaHlEczRlbEdQb2wvZ2dCYThCNjlLWFluekNP?=
 =?utf-8?B?Nkh3NXptNzNmRU9DdnFGNGk3MkJoK0V6UUUyV1BTeFd5UG45d1Y5UDhRVXRy?=
 =?utf-8?B?RUYxMDVxV2FqeTJzeGZnNTJZQllQTk1ESGRkaVR0VUF3cTFLQnhkdTk5UWZr?=
 =?utf-8?B?UVZESGVmM0ZHeTNWdG9oVWFzSkx2bldocFIyenU0QkVxYkhMK01RZVdPYzMy?=
 =?utf-8?B?MlAzamN1VFFiQytQbDhoSkRLSmJVMVl5RHc5aUN6bTRPMFp4T1pNS1QvbzJz?=
 =?utf-8?B?Q1JJaFRFMlZNOHlnN0loL0hSY0JURzlreFZiTzl1ZVNXanFwdEpwSEZCN3RF?=
 =?utf-8?B?SnpqVFovLzV3WVRIYWVIMWRRWiszVmM0MUhTdkFqTlF1b2x2bWJsVlhvUlp4?=
 =?utf-8?B?S21YZXJtbmdEV3ppNnBNREoybktLb3BraHFkczEyZ2E4UVdNYjVacTBnN2hx?=
 =?utf-8?B?RGJvT2k5QVJvSmEvL0hpWkhIdWg3WEozY2RKQWdvdUpKUlE4TEVjNWpPcEpP?=
 =?utf-8?B?L2VQay80U1FrOFB3dHE0aDJpbUdmaGxCM2FrK0hEazA1My8wRFluWVczK3d4?=
 =?utf-8?B?S1JHL2hjRDVlZWtXS3VCbzhnYlFkMmRma1NyWk5XMURmc212ODZrdWQ3ZHJ4?=
 =?utf-8?B?VTBJNUNxSnZpR1NUMHpaY05XcUY2a3Z6N0tLWXhHZjRDWFY4SDljUE5hYzlp?=
 =?utf-8?B?M1lqaVBpcERKbmxXeU1ZYzZwb3FEVVNXdDVMK25DRjBuamJpR2F3czFwUU1J?=
 =?utf-8?B?bmJRRUZDYW9YcE5nSmVjK0FBd1VUZ3pEUzNVUVRIYkZZSGkxM2RlM0RDTzBO?=
 =?utf-8?B?WTczUnVCdGJuUWZXbzEwS2F4ejVLS2VXMy9aWjVQejI4N3lHaUNScUllbWJu?=
 =?utf-8?B?VmJQeUVUeGZHWW5xdjU0UGYvTXNRVFppMVRHbFMwQUlUV2JTcWd2TG1OempS?=
 =?utf-8?B?cm5ZbWR3ZmVJOVBUWTcxZVp3SnMvQWJ3THc3Ull4Z0paUmsvdUFZb1luT3RU?=
 =?utf-8?B?YWVIVTU0VERBQXJsQ1RsdC9QN1FYMWZhN01FUGJZSWRlQzFWQWFtSTRBeStj?=
 =?utf-8?B?L3BmZ0JyejNpenF0VjJpMG41VGNiSW5Pc21ISnV6OXBFY3NpMFEvUitzamRP?=
 =?utf-8?B?WmZvQXJBRDkyODhGdzdmcU5Pc3lhZmdNaXV0OURhTVBWYlhzS3BiV25lc2Mz?=
 =?utf-8?B?c2JWbkJxQ0hld05KWFNDNDdmMEptRldmVEQ2amIyU0hzOTdsYmdocml2dEJn?=
 =?utf-8?B?d3Frd2Rkc0FFUHZ2R3FWdkhnLzJsMHVxS0dNN2VGQzJCSmxjL2lJN3pxNmxa?=
 =?utf-8?B?cEtOK2JoV1BiRDJVYW5MZG43d3Q0YUgvMnlKMFBXOTZjaGVCemxNK2ppU2J6?=
 =?utf-8?Q?jXxBsRHclxDOyCwEDh1aqgzIvIiipkOXSCqE4ts?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5478.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56d40e47-37ea-4e6f-1059-08d950b99128
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2021 04:46:58.2208 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V+0OP5iWZt4Rvvq6wC2ney6lwqKsonyYAGnwt6B2ajXtODzeiz6mWlNgNdlRpSguLGyrq9tn3LveCmRabIhsWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5037
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
1. it is not a good manner to free a statically allocated object(in this case, it is iovad->head) dynamically even though the free only occurred when shut down the OS in most cases. 
2. the kmemleak occurred when disable SRIOV(remove a PCIE device), I post the log in the following, in the log, the line:" kmemleak: Found object by alias at 0xffff9221ae647050" means the OS frees a not existing object(iovad->head) which added to RB_TREE in the function init_iova_domain

The patch I sent out may don't meet IOMMU requirement because I have no knowledge of the background of IOMMU, but this patch can fix this kmemleak.

The kmemleak log on my server:
316613 Jul 19 02:14:20 z-u18 kernel: [  108.967526] pci 0000:83:02.0: Removing from iommu group 108
316614 Jul 19 02:14:20 z-u18 kernel: [  108.969032] kmemleak: Found object by alias at 0xffff9221ae647050
316615 Jul 19 02:14:20 z-u18 kernel: [  108.969037] CPU: 30 PID: 2768 Comm: modprobe Tainted: G           OE     5.11.0 #       12
316616 Jul 19 02:14:20 z-u18 kernel: [  108.969042] Hardware name: Supermicro ...
316617 Jul 19 02:14:20 z-u18 kernel: [  108.969045] Call Trace:
316618 Jul 19 02:14:20 z-u18 kernel: [  108.969049]  dump_stack+0x6d/0x88
316619 Jul 19 02:14:20 z-u18 kernel: [  108.969061]  lookup_object+0x5f/0x70
316620 Jul 19 02:14:20 z-u18 kernel: [  108.969070]  find_and_remove_object+0x29/0x80
316621 Jul 19 02:14:20 z-u18 kernel: [  108.969077]  delete_object_full+0xc/0x20
316622 Jul 19 02:14:20 z-u18 kernel: [  108.969083]  kmem_cache_free+0x22b/0x410
316623 Jul 19 02:14:20 z-u18 kernel: [  108.969097]  free_iova_mem+0x22/0x60
316624 Jul 19 02:14:20 z-u18 kernel: [  108.969103]  put_iova_domain+0x1b5/0x1e0
316625 Jul 19 02:14:20 z-u18 kernel: [  108.969108]  iommu_put_dma_cookie+0x44/0xc0
316626 Jul 19 02:14:20 z-u18 kernel: [  108.969118]  domain_exit+0xba/0xc0
316627 Jul 19 02:14:20 z-u18 kernel: [  108.969123]  iommu_group_release+0x51/0x90
316628 Jul 19 02:14:20 z-u18 kernel: [  108.969129]  kobject_put+0xa7/0x210
316629 Jul 19 02:14:20 z-u18 kernel: [  108.969140]  iommu_release_device+0x41/0x80
316630 Jul 19 02:14:20 z-u18 kernel: [  108.969147]  iommu_bus_notifier+0xa0/0xc0
316631 Jul 19 02:14:20 z-u18 kernel: [  108.969153]  blocking_notifier_call_chain+0x63/0x90
316632 Jul 19 02:14:20 z-u18 kernel: [  108.969162]  device_del+0x29c/0x3f0
316633 Jul 19 02:14:20 z-u18 kernel: [  108.969167]  pci_remove_bus_device+0x77/0x100
316634 Jul 19 02:14:20 z-u18 kernel: [  108.969178]  pci_iov_remove_virtfn+0xbc/0x110
316635 Jul 19 02:14:20 z-u18 kernel: [  108.969187]  sriov_disable+0x2f/0xe0
......
316651 Jul 19 02:14:20 z-u18 kernel: [  108.969629] RIP: 0033:0x7f6d8ec45047
316652 Jul 19 02:14:20 z-u18 kernel: [  108.969634] Code: 73 01 c3 48 8b 0d 41 8e 2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66        2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 11 8e 2c 00 f       7 d8 64 89 01 48
316653 Jul 19 02:14:20 z-u18 kernel: [  108.969638] RSP: 002b:00007ffc18dafc48 EFLAGS: 00000206 ORIG_RAX: 00000000000000b       0
316654 Jul 19 02:14:20 z-u18 kernel: [  108.969645] RAX: ffffffffffffffda RBX: 000055817f00adc0 RCX: 00007f6d8ec45047
316655 Jul 19 02:14:20 z-u18 kernel: [  108.969648] RDX: 0000000000000000 RSI: 0000000000000800 RDI: 000055817f00ae28
316656 Jul 19 02:14:20 z-u18 kernel: [  108.969651] RBP: 000055817f00adc0 R08: 00007ffc18daebf1 R09: 0000000000000000
316657 Jul 19 02:14:20 z-u18 kernel: [  108.969654] R10: 00007f6d8ecc1c40 R11: 0000000000000206 R12: 000055817f00ae28
316658 Jul 19 02:14:20 z-u18 kernel: [  108.969656] R13: 0000000000000001 R14: 000055817f00ae28 R15: 00007ffc18db1030
316659 Jul 19 02:14:20 z-u18 kernel: [  108.969661] kmemleak: Object 0xffff9221ae647000 (size 2048):
316660 Jul 19 02:14:20 z-u18 kernel: [  108.969665] kmemleak:   comm "gpu_init_thread", pid 2687, jiffies 4294911321
316661 Jul 19 02:14:20 z-u18 kernel: [  108.969669] kmemleak:   min_count = 1
316662 Jul 19 02:14:20 z-u18 kernel: [  108.969671] kmemleak:   count = 0
316663 Jul 19 02:14:20 z-u18 kernel: [  108.969672] kmemleak:   flags = 0x1
316664 Jul 19 02:14:20 z-u18 kernel: [  108.969674] kmemleak:   checksum = 0
316665 Jul 19 02:14:20 z-u18 kernel: [  108.969675] kmemleak:   backtrace:
316666 Jul 19 02:14:20 z-u18 kernel: [  108.969677]      cookie_alloc+0x1f/0x60
316667 Jul 19 02:14:20 z-u18 kernel: [  108.969682]      iommu_get_dma_cookie+0x17/0x30
316668 Jul 19 02:14:20 z-u18 kernel: [  108.969685]      intel_iommu_domain_alloc+0xa7/0xe0
316669 Jul 19 02:14:20 z-u18 kernel: [  108.969689]      iommu_group_alloc_default_domain+0x4c/0x160
316670 Jul 19 02:14:20 z-u18 kernel: [  108.969695]      iommu_probe_device+0xff/0x130
316671 Jul 19 02:14:20 z-u18 kernel: [  108.969702]      iommu_bus_notifier+0x7c/0xc0
316672 Jul 19 02:14:20 z-u18 kernel: [  108.969708]      blocking_notifier_call_chain+0x63/0x90
316673 Jul 19 02:14:20 z-u18 kernel: [  108.969713]      device_add+0x3f9/0x860
316674 Jul 19 02:14:20 z-u18 kernel: [  108.969717]      pci_device_add+0x2c3/0x6a0
316675 Jul 19 02:14:20 z-u18 kernel: [  108.969723]      pci_iov_add_virtfn+0x1b1/0x300
316676 Jul 19 02:14:20 z-u18 kernel: [  108.969729]      sriov_enable+0x254/0x410


---------------------------------------------------------------------- 
BW
Pengju Zhou




> -----Original Message-----
> From: Robin Murphy <robin.murphy@arm.com>
> Sent: Thursday, July 22, 2021 10:59 PM
> To: Zhou, Peng Ju <PengJu.Zhou@amd.com>; iommu@lists.linux-
> foundation.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Yin
> <Yin.Wang@amd.com>; will@kernel.org
> Subject: Re: [PATCH] iommu/iova: kmemleak when disable SRIOV.
> 
> On 2021-07-22 09:16, Peng Ju Zhou via iommu wrote:
> > the object iova->head allocated statically when enable SRIOV but freed
> > dynamically when disable SRIOV which causing kmemleak.
> > changing the allocation from statically to dynamically.
> 
> Thanks for the glimpse into the kind of weird and wonderful things people are
> doing to the IOVA allocator out-of-tree (the "holes" list sounds like an idea I
> also thought about a long time ago), but judging by the context this patch is
> clearly of no use to mainline ;)
> 
> Robin.
> 
> > Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
> > ---
> >   drivers/iommu/iova.c | 15 ++++++++-------
> >   include/linux/iova.h |  4 ++--
> >   2 files changed, 10 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c index
> > 2371524796d3..505881d8d97f 100644
> > --- a/drivers/iommu/iova.c
> > +++ b/drivers/iommu/iova.c
> > @@ -26,6 +26,8 @@ static void free_iova_rcaches(struct iova_domain
> *iovad);
> >   static void fq_destroy_all_entries(struct iova_domain *iovad);
> >   static void fq_flush_timeout(struct timer_list *t);
> >   static void free_global_cached_iovas(struct iova_domain *iovad);
> > +static inline struct iova *alloc_and_init_iova(unsigned long pfn_lo,
> > +					       unsigned long pfn_hi);
> >
> >   void
> >   init_iova_domain(struct iova_domain *iovad, unsigned long granule,
> > @@ -47,17 +49,16 @@ init_iova_domain(struct iova_domain *iovad,
> > unsigned long granule,
> >
> >   	INIT_LIST_HEAD(&iovad->holes);
> >
> > -	iovad->head.pfn_lo = 0;
> > -	iovad->head.pfn_hi = start_pfn;
> > -	rb_link_node(&iovad->head.node, NULL, &iovad->rbroot.rb_node);
> > -	rb_insert_color(&iovad->head.node, &iovad->rbroot);
> > -	list_add(&iovad->head.hole, &iovad->holes);
> > +	iovad->head = alloc_and_init_iova(0, start_pfn);
> > +	rb_link_node(&iovad->head->node, NULL, &iovad->rbroot.rb_node);
> > +	rb_insert_color(&iovad->head->node, &iovad->rbroot);
> > +	list_add(&iovad->head->hole, &iovad->holes);
> >
> >   	iovad->tail.pfn_lo = IOVA_ANCHOR;
> >   	iovad->tail.pfn_hi = IOVA_ANCHOR;
> >   	rb_link_node(&iovad->tail.node,
> > -		     &iovad->head.node,
> > -		     &iovad->head.node.rb_right);
> > +		     &iovad->head->node,
> > +		     &iovad->head->node.rb_right);
> >   	rb_insert_color(&iovad->tail.node, &iovad->rbroot);
> >
> >   	init_iova_rcaches(iovad);
> > diff --git a/include/linux/iova.h b/include/linux/iova.h index
> > 076eb6cfc613..553905ef41fe 100644
> > --- a/include/linux/iova.h
> > +++ b/include/linux/iova.h
> > @@ -81,7 +81,7 @@ struct iova_domain {
> >   						   have been finished */
> >
> >   	struct list_head holes;
> > -	struct iova	head, tail;		/* rbtree lookup anchors */
> > +	struct iova	*head, tail;		/* rbtree lookup anchors */
> >   	struct iova_rcache rcaches[IOVA_RANGE_CACHE_MAX_SIZE];	/*
> IOVA range caches */
> >
> >   	iova_flush_cb	flush_cb;	/* Call-Back function to flush IOMMU
> > @@ -252,7 +252,7 @@ static inline void free_cpu_cached_iovas(unsigned
> > int cpu,
> >
> >   static inline unsigned long iovad_start_pfn(struct iova_domain *iovad)
> >   {
> > -	return iovad->head.pfn_hi;
> > +	return iovad->head->pfn_hi;
> >   }
> >
> >   #endif
> >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
