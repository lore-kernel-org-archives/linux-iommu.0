Return-Path: <SRS0=7V87=LJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D183C48BDF
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 18:51:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5EB26128C
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 18:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5EB26128C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id ACC26401E4;
	Tue, 15 Jun 2021 18:51:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fk6w0y5QmxMj; Tue, 15 Jun 2021 18:51:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7D2F9400F3;
	Tue, 15 Jun 2021 18:51:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 51AA4C000D;
	Tue, 15 Jun 2021 18:51:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DCCCBC000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 18:51:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B52E040623
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 18:51:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=vmware.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oMTvUaKVYmni for <iommu@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 18:51:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::61e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2CC8140605
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 18:51:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dD2msnnFtElJYrmqeoawvqL+QLfjZZx8/8bGntNUwiu77ENlOQuH81TNqvPqaWy6kZInkD7ot2Exgo9xL/M5nXmW+o487PBnptpvugiwXbRZFRq0NrAVAx/hO14bWkS2Nh058H7DeuSjakt84/QbscdsF+rbu3Av4fUCPtiwa434QlWgctWGXHeznkwb/X/r4YLn7aFAKRUUinoNRnyxXQXIrjK798A4BcDp+nDEJwtk9eJM5xBDflvYNYgVjZe4Z4m4tuhyXCXUCTADxoc4q5hA1zTMkmJXraMhep8AYOkx5WqTbEM7qC8d8/7pEJCZPDDRFnpoHqklVqRb+uw8vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DvjHjYYwSWyW+VExuN2kLZfssYvoxXm79kV1z26bhy0=;
 b=fKxs8yQc4KDuA24b+vTINVBM9LHnXaElOQI9QV9nR15UnhZWUwDOgIv6IK1FES6w3yPrGOLMWr0gO3rLbCz5VwGqQzk764gopkf9tBeAzDscLMFI++kgMse6uXPr6/73qs4vMzxUTL9AMnjQZGgsM7O/qqKr/UlMuzE8qsy9J/rDj2+s27+YstOZbU9w0W5x+pGb+6Os30mFZPqj3IYel1cmbZczm7pFZYLxtGGQd1SKiEP2W0vl4/e7qHrz6Bl48pB9Iv1wZaLcDW6HWqipzOksKme+dPy3BIsZR83VcrhqkFK8CNxeQp+eMg40JegjZDif+WGPUlqlQJE7RQQJkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DvjHjYYwSWyW+VExuN2kLZfssYvoxXm79kV1z26bhy0=;
 b=h5g7dPeZsDqTh/w72vwC1np55rZb7oBsLXFd7r16z/3pQ/sffA9CQG6z2I9g+zy6h5EnJ+Kw7O6hDo3BT0YkJRwJQ6IyynNYZcBRS0aGjWeNkpwEfcmMIB7NKXNT0Dcyrqz+ap+9gGBtvr6AS5cJF4GgLN7sYvLUJ2p3g7U1cFw=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by BYAPR05MB4887.namprd05.prod.outlook.com (2603:10b6:a03:42::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.12; Tue, 15 Jun
 2021 18:51:09 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::1c28:6a3d:d0d6:42fd]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::1c28:6a3d:d0d6:42fd%3]) with mapi id 15.20.4242.016; Tue, 15 Jun 2021
 18:51:08 +0000
From: Nadav Amit <namit@vmware.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 6/6] iommu/amd: Sync once for scatter-gather operations
Thread-Topic: [PATCH v3 6/6] iommu/amd: Sync once for scatter-gather operations
Thread-Index: AQHXYdkgKs2MbFD4qkq3dIbdm3nnb6sVaxsA
Date: Tue, 15 Jun 2021 18:51:08 +0000
Message-ID: <DA679904-017D-477A-9284-46644D6F9858@vmware.com>
References: <20210607182541.119756-1-namit@vmware.com>
 <20210607182541.119756-7-namit@vmware.com>
 <99671205-134d-7563-63e2-b65c13d5d074@arm.com>
In-Reply-To: <99671205-134d-7563-63e2-b65c13d5d074@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=vmware.com;
x-originating-ip: [24.6.216.183]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c88aa4d4-d7d0-46e7-38de-08d9302e89e8
x-ms-traffictypediagnostic: BYAPR05MB4887:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR05MB4887A1459EE1FAE942B476DBD0309@BYAPR05MB4887.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:983;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KvGic5d1wkPWD9UbpK2ZE12b+j4pj/w+UDbvuixLryYUnKf9zmyKlF+4/wrwcsCsgV0Irnmvx1Sw94Wb7mTTH7G10Ua3JLD/LH6zBE6CdxKpmkL3DK95Fx+Skva78iufjfmOp4SVI2cOlOiVwyAIutcoXC1ok/cZlgWryFZhNS/dlANhOsd2GuqGkvHX27PdCOQg68oMf8NzjKsoq1m1MvgQophW2n/JkQaoF4UNucl8GxmtaW7pFM1k7One2a7ktK1RQzLWW5KMDFztzlQNah91eeGbk451ZX9zvszHEPijlRpI9lWhEIMWjYar/7GCz0Pv856bVcKjesNZM69JPMXbeH78YU/jVjjTPtQZ/ElUj4Yeb5+aIsJpoJu/49lq6kzIWio6ZtjSTTA2FafHYaleI5VO4TYPVVWuppqbFWQXnoNnwoA4gTqdbb/yUgotMwqqnkSO7ixjsCsJpvWoY/VHVWq8LXCrMmgv2cBXttEgEpcMbmHFV7sObvw5ccNYpAAZikks46p+KrbpbSdMc1vJZ2HTy/dtzgc9R//Tkr3e73ZJdByn6puDc7TMF9Sq6v7HAHy9hdnNsnZNXRG9xcvM3pK/587PRqd4Ye61fplfrV6Nzd22Q/QBoRbI7XrUFHp529TUd7aUljsb1yZFJLsJRd3duCpGhtyNcyrEounN84r0RwKMFGPLprY3tuD2fKfKGW4gZU7KAy3BQsrYS0Ea8qT0a9jAfHBjBi/HEIlPEBTpNuryD0rvAOWaqjl93tIM5MhIqXcVi6chyUMgaxFM8w7kqSlrdDh33CcNHY2RnsxPAYuMyohn4bVOp2Sj
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR05MB8531.namprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(36756003)(86362001)(53546011)(6506007)(6916009)(6512007)(966005)(2616005)(66946007)(8936002)(83380400001)(33656002)(4326008)(316002)(76116006)(64756008)(54906003)(122000001)(71200400001)(478600001)(186003)(66556008)(6486002)(38100700002)(2906002)(26005)(5660300002)(8676002)(66476007)(66446008)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?h37rIZsiCAggnA1K7HymvA6P5KEvnaIp3uVyKghzby4jh7SlXF6TSNJjgAfG?=
 =?us-ascii?Q?Z1cP3p1SapWEpCf1aJ0wODT9Mjznq+346FhI45ukRKRulDHVWH7tX5hdbGtY?=
 =?us-ascii?Q?HXOamv6oG5z5+CxaUZ3FV8hbW2XKKL9xynVNRdZf4nX1+/hiZGXN6rcSuq7u?=
 =?us-ascii?Q?dpFzdTJ6EMHUP9qcTuQcFhKJn6IIFKHat7xH+KIO8SWOU2zGIci5zpHtHvTs?=
 =?us-ascii?Q?Itrbc0BAJjnjRE8daQ4YwA84BcTyxKI9TDJRe/HxgLtj+XB5U6fhWXe27GQ7?=
 =?us-ascii?Q?TbqXUEviW7Lou7k8ke08cjK5Zi8YOzcX63nOSPewwTuvwa9cuyfXqNnuY/fc?=
 =?us-ascii?Q?aQPVjl7dsJBRVzIPgZgLuCIF39JO+D/wyO6/4yg/MNQObe3TrioHeLsIItMi?=
 =?us-ascii?Q?hiiOuOC8yyDw+PxrlTGB69A9u0FAJ0Qe3IBlUwwIQ4YCmTP44FoLRUql3L2Q?=
 =?us-ascii?Q?4aBsz5yabv1Hum28OQvz4/z5YjaLLaTlrZwY1SFNj/wqIaqV28B1+Pul9UzH?=
 =?us-ascii?Q?YL1KS6NTwsL5Z3kn1vnhDrI0RYIXkIq8D65kD32Cunoo6ws96RcVq+tnpleM?=
 =?us-ascii?Q?ZiUyDgwZjnPRYUM4PAYwUrz7dK4AMzNnlz6PlQyQ9oFnSun2t9JU7gZN32uS?=
 =?us-ascii?Q?yQr9mwnKhpoNUz20x4vMtsMOdDBlELNLuEcYRp9u03Aq5Ngr/p37dIIzncBh?=
 =?us-ascii?Q?ZOzuxcbJle/JkPH0HrgLeHSjf5LiX8KC2/Y7eCQrcs+CO3XEkKJHZwz4YBoQ?=
 =?us-ascii?Q?qyjLcnbfo6FlRk3arZqNmJG68p6t0Lb106qryljdy0dBFT+o3BDrvwjCW3G/?=
 =?us-ascii?Q?oJ/qHm0WA24nnUBcWo6Qo4svzfaNehcUo5BQeiJKI8HUaOv7b4z17asL9mQt?=
 =?us-ascii?Q?i6WewFSpGThkNHg5SdebKv97uUj9YzxgFSTGvC5cWbuCEG8ZpEZ7zdneq0kJ?=
 =?us-ascii?Q?/w3fLOvpZwqakbIpkuq6jN4OHay7dkzvZfjHyzNUYN9nXRs9XP5mbXR9UI/5?=
 =?us-ascii?Q?ueKjxa8kv8AmbcsD+ZxskNpnDVeJEBljRMyWNZEfoWA/npLgXryEdZRS+jKC?=
 =?us-ascii?Q?cBnWDT0VxUik5mdPKN1qhuQoxr2XvBcPOKCyfLGkpEpNv7G7qlpgqRYQQ2JI?=
 =?us-ascii?Q?73qSFnAXzxJ9c6P9WV9V5ra9YBIXe3BlhV0R9Zhf1RTedx1lrEoGlK+uKzyP?=
 =?us-ascii?Q?U/FsfCCg7j/ogN+thKaEeTjF2ZOQXmnBdJylRwdCPSshuIKQEKX1avcNLuQv?=
 =?us-ascii?Q?Tpl4WrCT4oc4U5oVIaf1768e3PedlmBtd4ZO630hc8qtexf93T4rpXRaeEdS?=
 =?us-ascii?Q?3IMrc9N4au70deHIjvuIYZ4Z?=
Content-ID: <335AC7F53DB4BF42A40468975BC9C531@namprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c88aa4d4-d7d0-46e7-38de-08d9302e89e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2021 18:51:08.8936 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mvvv2HorjQNl5YZQBiUdCCq1J2xTnlhUD9Rp3ocAaru55Y6GEuFKV7obhxqFuPaTbZpah2pdXmBqjxy8OogaQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4887
Cc: LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Jiajun Cao <caojiajun@vmware.com>, Will Deacon <will@kernel.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



> On Jun 15, 2021, at 4:25 AM, Robin Murphy <robin.murphy@arm.com> wrote:
> 
> On 2021-06-07 19:25, Nadav Amit wrote:
>> From: Nadav Amit <namit@vmware.com>
>> On virtual machines, software must flush the IOTLB after each page table
>> entry update.
>> The iommu_map_sg() code iterates through the given scatter-gather list
>> and invokes iommu_map() for each element in the scatter-gather list,
>> which calls into the vendor IOMMU driver through iommu_ops callback. As
>> the result, a single sg mapping may lead to multiple IOTLB flushes.
>> Fix this by adding amd_iotlb_sync_map() callback and flushing at this
>> point after all sg mappings we set.
>> This commit is followed and inspired by commit 933fcd01e97e2
>> ("iommu/vt-d: Add iotlb_sync_map callback").
>> Cc: Joerg Roedel <joro@8bytes.org>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Jiajun Cao <caojiajun@vmware.com>
>> Cc: Robin Murphy <robin.murphy@arm.com>
>> Cc: Lu Baolu <baolu.lu@linux.intel.com>
>> Cc: iommu@lists.linux-foundation.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Nadav Amit <namit@vmware.com>
>> ---
>>  drivers/iommu/amd/iommu.c | 15 ++++++++++++---
>>  1 file changed, 12 insertions(+), 3 deletions(-)
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index 128f2e889ced..dd23566f1db8 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -2027,6 +2027,16 @@ static int amd_iommu_attach_device(struct iommu_domain *dom,
>>  	return ret;
>>  }
>>  +static void amd_iommu_iotlb_sync_map(struct iommu_domain *dom,
>> +				     unsigned long iova, size_t size)
>> +{
>> +	struct protection_domain *domain = to_pdomain(dom);
>> +	struct io_pgtable_ops *ops = &domain->iop.iop.ops;
>> +
>> +	if (ops->map)
> 
> Not too critical since you're only moving existing code around, but is ops->map ever not set? Either way the check ends up looking rather out-of-place here :/
> 
> It's not very clear what the original intent was - I do wonder whether it's supposed to be related to PAGE_MODE_NONE, but given that amd_iommu_map() has an explicit check and errors out early in that case, we'd never get here anyway. Possibly something to come back and clean up later?

[ +Suravee ]

According to what I see in the git log, the checks for ops->map (as well as ops->unmap) were relatively recently introduced by Suravee [1] in preparation to AMD IOMMU v2 page tables [2]. Since I do not know what he plans, I prefer not to touch this code.

[1] https://lore.kernel.org/linux-iommu/20200923101442.73157-13-suravee.suthikulpanit@amd.com/
[2] https://lore.kernel.org/linux-iommu/20200923101442.73157-1-suravee.suthikulpanit@amd.com/
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
