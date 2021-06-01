Return-Path: <SRS0=UGJ5=K3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4D8C47080
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 18:57:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22ADD611BD
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 18:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22ADD611BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E48B86085A;
	Tue,  1 Jun 2021 18:57:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DELnS60S892S; Tue,  1 Jun 2021 18:57:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8321E608BC;
	Tue,  1 Jun 2021 18:57:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5BCBBC001C;
	Tue,  1 Jun 2021 18:57:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73338C0001
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 18:57:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 50BB783BC3
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 18:57:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=vmware.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KG0XYx_IqzAC for <iommu@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 18:57:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EC13E83CAD
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 18:56:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/9lIcH31nCBzV+eZZ3rUC4DvXcEMeflzu+5fVA1uRiHc6gpKcKYYTtwOWQ2hfPXEV7cc7jUuNrTimNRPQrTPADqu06KoAlqbXs06kCk82kGswJTlIrbJ0FQrfjG8opexAETcjTO+7Mq5wDAEC9u4u+ymu6Lqek+JbCimXnKXycN9ZPN5nlAz5qaxVyVU5hJKTLTFNeFtPjtHTFf0N7/AQsUuNg04OA228GRStsBa7QP3rRfPPeSqstC4MCgzKWJYvkK5L2qERHX/uzqVuBn22w2nZQWFvDh+whenZTDgIuaTQb1ZTNzBVTC42QoVq3e3wuAuQOGW8cTFTUkOweJaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKtvrcT3Rkk/MdnTyOQ+s8ySgeN8DTONfdHWLOefLzQ=;
 b=ej4U4rdrHBcbFxxymLa4iVCZeVSSIN2QLmg3FNHlvGzfOAXDyOqY4VRs0WQUSv6fttG7y2VjMYpUq/KwcpIYJPV8+bOBWbnEChQMWeHGJpTsMh0ZjP8P85lOKZROUp8NfEYRzLbRnnru8Sprnqk1h0cs8OayyEKKOAW+eF08DvtgmYL7EvB1GzRPDMXubfqUbUMxSKV0C7EHNE5hAwTE3d/W/KhKRVyjQpUD+2eJgJOa+z3wa6ER+YeCZ3sv+DFrLfHohtdbeI5tEMOxfyBfAAWvfthEodfOYhgh9iloed4E4+0tbW3VCcEITc71zNxr+cOgMespHE7Xie2eaL1rTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKtvrcT3Rkk/MdnTyOQ+s8ySgeN8DTONfdHWLOefLzQ=;
 b=jvVuiM6TFmLnYGRXxuWGHWwGkZHcdjoubtEvETQCVj8aKA3jrbEIOtKzKn4+ebT1t79ZiMMDLUvMBPuT+mIkuO0KVQELKWGMVlNsDa9po9Eq/CqkrhN9PCfiXyFdq9/gSxQS7o1D9V998AIxPYCJne8pYkLSIoC10kURK7DSWAg=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by BYAPR05MB5333.namprd05.prod.outlook.com (2603:10b6:a03:1e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.12; Tue, 1 Jun
 2021 18:56:57 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::1c28:6a3d:d0d6:42fd]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::1c28:6a3d:d0d6:42fd%3]) with mapi id 15.20.4195.018; Tue, 1 Jun 2021
 18:56:57 +0000
From: Nadav Amit <namit@vmware.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 3/4] iommu/amd: Do not sync on page size changes
Thread-Topic: [PATCH 3/4] iommu/amd: Do not sync on page size changes
Thread-Index: AQHXVv8h/VT5hYiBaUmB/VN59+xv0ar/W4EAgAANS4CAABj+AA==
Date: Tue, 1 Jun 2021 18:56:57 +0000
Message-ID: <46F62EF5-8463-468B-B9D5-30B4F0572491@vmware.com>
References: <20210502070001.1559127-1-namit@vmware.com>
 <20210502070001.1559127-5-namit@vmware.com>
 <f00bd0ce-e4a7-93c6-39ae-db19779b9331@arm.com>
 <F5D25BE7-FA34-4017-AA22-DDAB24F634BC@vmware.com>
 <7e0b4b12-c68a-ff90-5d86-4ab88ddd7991@arm.com>
In-Reply-To: <7e0b4b12-c68a-ff90-5d86-4ab88ddd7991@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=vmware.com;
x-originating-ip: [24.6.216.183]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ebe0944-6a75-4eeb-6bd2-08d9252f07ce
x-ms-traffictypediagnostic: BYAPR05MB5333:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR05MB53335F2CBE52F239D4C37CF0D03E9@BYAPR05MB5333.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OSozYCORupkmWSh9qfzwoDyqDAQo8/DkWj2heQVr2fwdeekT2ELO8+mWBdXn5Ng615KdJXn9ftgFYygBKHEHV6CN0hR993pvQa0qo0ZIBCMVse9fAtr3nTyqi18py84AOmf6E6tf/BSSYW9Hf3lpVNcm8S3VhNuOXKk/DmgDxGBohyiNJ1JoHijrwzDsuUs/A4CKKThf/ahmxIC3G+FZ2P7agC6JG+ygeEISoycukRZuwZAW43YUKblr/UCB+kvSSFT+lK2f8QsLyCC001aDUA8Ob7FTCD2FEEyoM6Lh3SfjbzOYy4QWfVyQGrhGkgtzsm1lJ6ZBQkcRX5bTV5O5a+5JY4ejbjb8REVLY6+G9PcoPiWFbSBRiE31DP4d6u8p3QV4lqNxitHn7HonsLIIUCG3FjZAXxNLrj6uoXBrX0A5F5sx9SIfZxa7zk2lllTbdzhyKmAmq1jeuwIiS1y2HUB5+vIbq6IM8WmLVGIixAqZScCRMFLb2QlacpZvPo7l/IS347R6Ms+36oZ8VNpIqq5P71oD1NYT+wa2um2zW7gDsEUsXrI391pwMvWvS03AMlwKq5iJPDVR8C/YOQUnMegQv1/5U2sVw1Vy0OocHERS4FqLjt+/sayyt0W+08b5enkSgGODHeoSgLfWKI3ezv1yDn0e3OeZQnsBpbFWSBs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR05MB8531.namprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(54906003)(5660300002)(4326008)(2616005)(6506007)(71200400001)(53546011)(26005)(6916009)(8676002)(186003)(122000001)(478600001)(66446008)(66616009)(76116006)(66556008)(99936003)(2906002)(86362001)(6486002)(316002)(83380400001)(107886003)(33656002)(66476007)(66946007)(38100700002)(64756008)(8936002)(6512007)(36756003)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?cVFQdlRxdDM0WTBweVhlY0w1TTZtcnd0NGVhTHNHeWozeEFGNXdsMFFlUWJU?=
 =?utf-8?B?VVllVlRCa3gvMHRMWGpXY2EzTEZRWTZPdjAvVmNzVUhaWGljMHpHUUp0K1Fv?=
 =?utf-8?B?eithTEo3bW50UHUvZG05RUJrZTBTYVJHNUNseTZwa2NkMzFockFScVdlYktw?=
 =?utf-8?B?dFdmUmkzT05sY0VzU1hicnlLUDZRekxYUjNFVzJDMXYwamE4TWkyd2FaQXA0?=
 =?utf-8?B?dElodWh6cTVwZk9HYXVBTTI3RUtGcG9nMk5FeDFRNEpOdHFFRGNVeEVTaWV3?=
 =?utf-8?B?ZlJrb2NWRjBUd0N6MkpIcDFrWVpIUWI3NCtDOHhTZ25wVnUyWm9KTUIySWRu?=
 =?utf-8?B?dW44eUZoakgrMVlibWpJaWtZdXduYnByWVp2RDdqek5iY1FtaGpzdyt0a3Ey?=
 =?utf-8?B?TFBVUlZJaUVPZDhkekpQSXNVTzIyTjRDYlBiR1IzRS9TeWFscUdBWEk0dENn?=
 =?utf-8?B?YXlaWUY4SGZtejhLc09XY0ZkdkZ0aE9HSndRY3BHa2hiNmdRZml2WmljSGo1?=
 =?utf-8?B?elhFTWFqaFBUMU5wZ2paWThXMFZXQVpSeGF3R0NOV0JjQ25yeFNDODBRallB?=
 =?utf-8?B?UmFnbUp3dzlNZmZBbDZrVTRETmhldTB2cGNkTGNOdWU1dXUrcTEwSFpTKzJv?=
 =?utf-8?B?akFYY3hjOWJTcUJBWHUxSnVkT3FYd1NDeENLS2x4YmhRTHJaRjEyTE9QdlZU?=
 =?utf-8?B?c1hWM2ZwcWJMUFQxOHpiRTRRL25odjVuWFRWczc0SS9oS0hpRGgvN00ycW0v?=
 =?utf-8?B?QVU3Qmh6aDUwZzdXTHM3dXd5Wmk1cFg0MEFTMG9aRDdpSHdLQ3VMb0xoMG43?=
 =?utf-8?B?RXphY3FRcFRlamlZMmErYjRORXN4cWsrVllSWE16blNHWXYydDJrSkRGcnd0?=
 =?utf-8?B?VWp5TkdFWjl3c0h3U0NUSms3VW84WWIreGJ6NndBUC82K0ltRU5VSHk5R0sy?=
 =?utf-8?B?N0Fqem10ellBM1F2ckdMU3hVK25PeTdLQldBWitFZFRxZ3hxekJSRTJQT0VU?=
 =?utf-8?B?bWxnZ0R5eXpyVWtTRkJWNGJoRGQ2OFgraHRkOCtLbTVUMVNYR0xpaFJhdW5L?=
 =?utf-8?B?VGdHLzM2ZEd1L0RYVUQzNW1jekNEN09YdnpxUnFwZi85MlIvK3BtMGxrYVVs?=
 =?utf-8?B?emZzQWNuMmN3Rm5jNHVIQmJuUTg2M0lKN2V4dnp1MmlwNE5sZkdLcDVURHBr?=
 =?utf-8?B?b21RMDJxWGYrOHZRZVBQNHZNenhXTkphQmR5R3VYWG5zcHNFTS9zOWE5M1dU?=
 =?utf-8?B?NkpJYUVVTmtKZGUyOWVpeGJHMktpSTRRdlVpbHlJdm9FMjZFRjNHdDgyRzhV?=
 =?utf-8?B?ZHFRQUdRNXhzcUVuR3RpeDBmVHZWRE05QWQxMUdxWmd4MmxIeFRpcGsybEJF?=
 =?utf-8?B?M0hBUUpaZDdJcCtOUG5mLzgzT1VBWWZabkZQdW9paEZ4dDBBRDBleXd1K2kr?=
 =?utf-8?B?M2xqdVEvelJUK1V1QjArQ2FDWkhkUVV6VmxvaUUxc1dOeGsrQm9BbjB1R2dB?=
 =?utf-8?B?N1lWd09tU1pyTzhLaTUrMC9MOC9mS1NXOWNjN05yN2g5bGYwYUFraVZjL21Y?=
 =?utf-8?B?ZWlWcmppRDhLRWNibDFFOUVOUnZCQmNQTGNwaEdCdzNOdGYxMEVYdkFteG9a?=
 =?utf-8?B?Tno5c3lFL3piMkFwQzMrMFdiMDFIclE0eE4xVXRQbmV6LzJWaVoyVXdSYnFN?=
 =?utf-8?B?OFlPZE5rZyt2dEkvOGJ4SFh2eUhKTnh4bjMvd2JrdGFTTG1UMTlqYWUzU3V3?=
 =?utf-8?Q?WGOuz4QBH9VaS6JOI/moUDlTIUZondni+TLzvWK?=
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ebe0944-6a75-4eeb-6bd2-08d9252f07ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2021 18:56:57.3040 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +AZxhCKS5fpmdm/nJOzUuwrgfOjbegZhWpxEzpBwLP7J88/CVrRhWvTXqUOSYfCAY3ZejNsGL7tUrGbUNKnJeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5333
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Will Deacon <will@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jiajun Cao <caojiajun@vmware.com>
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
Content-Type: multipart/mixed; boundary="===============0185239543288261649=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============0185239543288261649==
Content-Language: en-US
Content-Type: multipart/signed;
	boundary="Apple-Mail=_B357E3CE-B050-4CEC-BE04-BB7FB11573D5";
	protocol="application/pgp-signature";
	micalg=pgp-sha256

--Apple-Mail=_B357E3CE-B050-4CEC-BE04-BB7FB11573D5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On Jun 1, 2021, at 10:27 AM, Robin Murphy <robin.murphy@arm.com> =
wrote:
>=20
> On 2021-06-01 17:39, Nadav Amit wrote:
>>> On Jun 1, 2021, at 8:59 AM, Robin Murphy <robin.murphy@arm.com> =
wrote:
>>>=20
>>> On 2021-05-02 07:59, Nadav Amit wrote:
>>>> From: Nadav Amit <namit@vmware.com>
>>>> Some IOMMU architectures perform invalidations regardless of the =
page
>>>> size. In such architectures there is no need to sync when the page =
size
>>>> changes or to regard pgsize when making interim flush in
>>>> iommu_iotlb_gather_add_page().
>>>> Add a "ignore_gather_pgsize" property for each IOMMU-ops to decide
>>>> whether gather's pgsize is tracked and triggers a flush.
>>>=20
>>> I've objected before[1], and I'll readily object again ;)
>>>=20
>>> I still think it's very silly to add a bunch of indirection all over =
the place to make a helper function not do the main thing it's intended =
to help with. If you only need trivial address gathering then it's far =
simpler to just implement trivial address gathering. I suppose if you =
really want to you could factor out another helper to share the 5 lines =
of code which ended up in mtk-iommu (see commit f21ae3b10084).
>> Thanks, Robin.
>> I read your comments but I cannot fully understand the alternative =
that you propose, although I do understand your objection to the =
indirection =E2=80=9Cignore_gather_pgsize=E2=80=9D. Would it be ok if =
=E2=80=9Cignore_gather_pgsize" was provided as an argument for =
iommu_iotlb_gather_add_page()?
>=20
> No, I mean if iommu_iotlb_gather_add_page() doesn't have the behaviour =
your driver wants, just don't call it. Write or factor out a suitable =
helper that *does* do what you want and call that, or just implement the =
logic directly inline. Indirect argument or not, it just doesn't make =
much sense to have a helper function call which says "do this except =
don't do most of it".
>=20
>> In general, I can live without this patch. It probably would have =
negligent impact on performance anyhow.
>=20
> As I implied, it sounds like your needs are the same as the Mediatek =
driver had, so you could readily factor out a new page-size-agnostic =
gather helper from that. I fully support making the functional change to =
amd-iommu *somehow* - nobody likes unnecessary syncs - just not with =
this particular implementation :)

Hm=E2=80=A6 avoid code duplication I need to extract some common code to =
another function.

Is the following resembles what you had in mind (untested)?

-- >8 --

Subject: [PATCH] iommu: add iommu_iotlb_gather_add_page_ignore_pgsize()

---
 drivers/iommu/mtk_iommu.c |  7 ++---
 include/linux/iommu.h     | 55 ++++++++++++++++++++++++++++++---------
 2 files changed, 44 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index e168a682806a..5890e745bed3 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -520,12 +520,9 @@ static size_t mtk_iommu_unmap(struct iommu_domain =
*domain,
 			      struct iommu_iotlb_gather *gather)
 {
 	struct mtk_iommu_domain *dom =3D to_mtk_domain(domain);
-	unsigned long end =3D iova + size - 1;

-	if (gather->start > iova)
-		gather->start =3D iova;
-	if (gather->end < end)
-		gather->end =3D end;
+	iommu_iotlb_gather_update_range(gather, iova, size);
+
 	return dom->iop->unmap(dom->iop, iova, size, gather);
 }

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 9ca6e6b8084d..037434b6eb4c 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -535,29 +535,58 @@ static inline void iommu_iotlb_sync(struct =
iommu_domain *domain,
 	iommu_iotlb_gather_init(iotlb_gather);
 }

-static inline void iommu_iotlb_gather_add_page(struct iommu_domain =
*domain,
+static inline
+void iommu_iotlb_gather_update_range(struct iommu_iotlb_gather *gather,
+				     unsigned long iova, size_t size)
+{
+	unsigned long start =3D iova, end =3D start + size - 1;
+
+	if (gather->end < end)
+		gather->end =3D end;
+
+	if (gather->start > start)
+		gather->start =3D start;
+
+	gather->pgsize =3D size;
+}
+
+static inline
+bool iommu_iotlb_gather_is_disjoint(struct iommu_iotlb_gather *gather,
+				    unsigned long iova, size_t size)
+{
+	return iova + size < gather->start || iova > gather->end + 1;
+}
+
+static inline
+void iommu_iotlb_gather_add_page_ignore_pgsize(struct iommu_domain =
*domain,
 					       struct iommu_iotlb_gather =
*gather,
 					       unsigned long iova, =
size_t size)
 {
-	unsigned long start =3D iova, end =3D start + size - 1;
+	/*
+	 * Only if the new page is disjoint from the current range, then =
sync
+	 * the TLB so that the gather structure can be rewritten.
+	 */
+	if (iommu_iotlb_gather_is_disjoint(gather, iova, size) && =
gather->pgsize)
+		iommu_iotlb_sync(domain, gather);
+
+	iommu_iotlb_gather_update_range(gather, iova, size);
+}

+static inline void iommu_iotlb_gather_add_page(struct iommu_domain =
*domain,
+					       struct iommu_iotlb_gather =
*gather,
+					       unsigned long iova, =
size_t size)
+{
 	/*
 	 * If the new page is disjoint from the current range or is =
mapped at
 	 * a different granularity, then sync the TLB so that the gather
 	 * structure can be rewritten.
 	 */
-	if (gather->pgsize !=3D size ||
-	    end + 1 < gather->start || start > gather->end + 1) {
-		if (gather->pgsize)
-			iommu_iotlb_sync(domain, gather);
-		gather->pgsize =3D size;
-	}
-
-	if (gather->end < end)
-		gather->end =3D end;
+	if ((gather->pgsize !=3D size ||
+	     iommu_iotlb_gather_is_disjoint(gather, iova, size)) &&
+	    gather->pgsize)
+		iommu_iotlb_sync(domain, gather);

-	if (gather->start > start)
-		gather->start =3D start;
+	iommu_iotlb_gather_update_range(gather, iova, size);
 }

 /* PCI device grouping function */
--
2.25.1

--Apple-Mail=_B357E3CE-B050-4CEC-BE04-BB7FB11573D5
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEESJL3osl5Ymx/w9I1HaAqSabaD1oFAmC2gvgACgkQHaAqSaba
D1rJkQ/+JWJnCMtFtwXQ1fbPf1HQn1pRTUeUlsKCx8wzRIaRYDy/Ocd387H4MluD
LVQ/maYXSmXT60XDRhpG9AAa4z9NBRrvpeFkL+V0AzK0l4Xy0u+vzHJA+d9IRJfv
/FurUSv0A5iARwAzm+rBCYNxig0HpoZ/jSnyrtv4WcTZTbLtaWMGbPG2HgwkDc3w
fZv+cHOwPHZvvdFwXu3kaVEmCAnOz3t169D8DQyikC/ua/YVC5BH+USUWZ/ki9f3
Rir6xQLUM9fpYa5Cmr5M1QpBxU50T8OvjpSna/78kchU5/XCySPlFjgXCpBgpxQd
BJzcKCGhuM7Nsaun1AYTGAzfV7Gu80cRxyqtsQf7SxzTuU7qoSGYjy+FAK6fCOYW
Hk6KTyznXk9EgUy85Waki34fgKb9hTocFPnXYRoxpNGw+ig1gtUxXNeztEh4va7i
+67XNikCE/13ah0QuEXv2tmv3Z1OS5HtK5hvSrmtDIMw9He3v7ot+PjRSLU4epAG
XAm1lyrpiBIW8odasMdhX5zu3jB1OpQ+xanxX3IritosVNAeC3hS+lmrsKoJZmkw
s6orm8Ir0rZnJkoE9WKJ0vJkptaveYCoghZ5cKp+mxOvRlBMN2bPoPn1g0x+itUp
fEJxwkOnaFL/x2DuN9GVlSdOHSTRQhrvBB66FD1GISV+2tM7Mkk=
=tXYN
-----END PGP SIGNATURE-----

--Apple-Mail=_B357E3CE-B050-4CEC-BE04-BB7FB11573D5--

--===============0185239543288261649==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============0185239543288261649==--
