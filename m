Return-Path: <SRS0=UfkB=G5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45693C433DB
	for <iommu@archiver.kernel.org>; Tue, 26 Jan 2021 17:35:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFB6520449
	for <iommu@archiver.kernel.org>; Tue, 26 Jan 2021 17:35:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFB6520449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A36EB8703C;
	Tue, 26 Jan 2021 17:35:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FhjYz7keCOUm; Tue, 26 Jan 2021 17:35:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id E345286F6E;
	Tue, 26 Jan 2021 17:35:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C7951C08A1;
	Tue, 26 Jan 2021 17:35:38 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3AEFAC013A
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 17:35:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1E4E78702D
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 17:35:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lA9n5eMeg+xo for <iommu@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 17:35:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 00D3986F6E
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 17:35:35 +0000 (UTC)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10QHXw8J156602;
 Tue, 26 Jan 2021 17:34:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Y9cK8ie3alZQF3YVBANw2YN+wduBudVB+OcwhANB38M=;
 b=Ydqe58wFR+saivMwMMr0iUtRTkQ+isMidkb2Js/u6KlAqJTqRXVOdkwjlpreDIM9z2En
 wfdGFOrHF6Kxlp+ITKM4Q3sLTa44lyhv/5XdZ8/lr/Fci8ipgNtaGJUk7ONZ4ic2WQg9
 kOnEx+/m+bRUji5N5ZXKaQe0Uhoc8jaSyXvwa4JXHp2jtRXCvio2fUJ1T9GMU2gMdvZj
 RZBaWrVi1j1xm8rFXe7NYj5Waho1qTR+1aoJaPqcwkOLUHL9GuxIr5PA8Jp6sIgr5Mx8
 i122LpW5+GsLDnVZMLLraJvM+ubiav6f8e1mzW4FFokM6UvwsDv95ulFuxBRU2g6Dy9t ww== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 368b7qu7wd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Jan 2021 17:34:25 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10QHQWBj188481;
 Tue, 26 Jan 2021 17:32:24 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
 by aserp3020.oracle.com with ESMTP id 368wpy6ffp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Jan 2021 17:32:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hypyxyHtACipGuNBFZSM9gEv7HkNFrw3K5RDEQZRc+G4fgZY/wKhnKJPjCl84Ux3S+8LemmXmsA3xSCehTmq28grEbqCC9h5lf9JS4FDs5hjgAM285pJL0K6xliBMFGl6wPI7TfmnEueDQIrPyI8z0uImaS7ZtXC7XQR0txeU4m+7bN5/jrT6hyTmw2UojY1e2YYpDeIo0Oe3wVhI2IY8QmjngeTAaNLb6toFIfSRPw90ZEkK80TCDtHMHMez7+onYECSK9UsG5yKwjXXOXrodlQ+hEIqUxclhUraoo3j4kI4pouF5JpmmUwIY/ByFvfbjxdKFmuIVzDOXedR9HHWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9cK8ie3alZQF3YVBANw2YN+wduBudVB+OcwhANB38M=;
 b=iONw4PlN81FKnXWVhortxJrgaQEMRdQ1aport3ETff+4qp/g8sOnIhNRWGhS+He9DCJzg3LZ9d+D6oZdClusa4pUasuagRfRIFZFSvLlau8Y2XEB/ngklBGYZHuUmgjHDegxAcd75fyNSsVBLiuRmXZLbxjBu9PAK9j+biuf8681YiQiIt+7ASTEIOO+qyPVQu+PJjSIqaZRAHOq2fODyqbv1pks5/x87QhUCYj2YIvz4zSELofWAIqVgRvkC4PUeE8bc1tdAhFQlDdJWlVIeCsFnpoTwFscjB1xW9rG312ZmbBv9K1G6oVT4REQLP1NSpPiKj+1NShz4QRFOgX/tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9cK8ie3alZQF3YVBANw2YN+wduBudVB+OcwhANB38M=;
 b=CmnQy4YeoTQc9p8ApKqo8XmM+QENqmJ9VdHnyfsE9HJUlMPcxpfZiJgx/0shjsrDiwPoqOCnFQ5ZrvGf6/uBik/gKiMGuWo32sUCTLYzzVVeomFBt+U0c/ZydldS++anDSBQDdXKtPNu3r9d1K9Ah2Js6jm41tqtO/CRTOFLODk=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3333.namprd10.prod.outlook.com (2603:10b6:a03:14e::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.16; Tue, 26 Jan
 2021 17:32:22 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3784.019; Tue, 26 Jan 2021
 17:32:22 +0000
From: Chuck Lever <chuck.lever@oracle.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFT PATCH 0/3] Performance regression noted in v5.11-rc after
 c062db039f40
Thread-Topic: [RFT PATCH 0/3] Performance regression noted in v5.11-rc after
 c062db039f40
Thread-Index: AQHW8sRzvAsRgI4bIEGwtoU2eSt8tao4nH8AgAAfcwCAAViygIAAGDqA
Date: Tue, 26 Jan 2021 17:32:22 +0000
Message-ID: <EFC0FF60-778C-434C-8655-6FB6D44E583E@oracle.com>
References: <20210125023858.570175-1-baolu.lu@linux.intel.com>
 <BDAEAC42-15F2-4C75-A28C-8E580F0CFF01@oracle.com>
 <83EE54C6-F654-4D1D-92F7-F442ACEC8D70@oracle.com>
 <8fd70fb7-6865-1b11-2a16-9bf473004662@arm.com>
In-Reply-To: <8fd70fb7-6865-1b11-2a16-9bf473004662@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 583dc1a1-f49d-4bb4-9477-08d8c22056c6
x-ms-traffictypediagnostic: BYAPR10MB3333:
x-microsoft-antispam-prvs: <BYAPR10MB3333E0E7278A3E421545306793BC9@BYAPR10MB3333.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K6rls5YpwVjBF/cRbOHv1RgPwUiZIPYp66/0miXImXCVz5M/rpoCrcrMl1vS3WbaPbMyV2ioBMdXUmII/dvQKPcCuA8+pvyIL0H9g7049IZpR08njeLxVrqbqRHSizNghGOUvXcMyXY0cbBnSMkGSchVrylCruFFbIDaHhHDayT3vlF4MLnUI2ht1lkTZXf5XwxQEGT/UrI9jWq1h+cft9koIhJ7iirwkEzLaYhT6Yc+n0LcsdMtFR4/L4KxLv2jSEtp7odXxR9eB+i8vEZrSf+VmQ1qzl41PRI5dryzQAlOSu975ChtAC0yvM5WuxIpPr0pPyM2KstsCWYhlMvnTQncj01zp0e8dH1UiRD9WelowSG4Lsket+YtH6XElUzyAbvI9SqSnX8USnHlpi5Zp3wcUGY8q0Y2pxX0s3yq/Pifc/NcTcXNjjRQO8S/Wl+6CXL36kSOVZotgtMbb/e6cMFk/ea/wNDe5R/c5hCylBwfrNQ9SVnMR2a3kTQol3eEUeFYYOR2koc1d60wjjJYfzf+mjZGKteyTuTlS5lQRajIdxlUX9TR7Ss0LXcfLcAL5jjg3g7htBhca7TTU5dxCWwxASuMEJ5qmBi4pdGU/IQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB4688.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(39860400002)(136003)(376002)(366004)(396003)(346002)(54906003)(478600001)(4326008)(66446008)(44832011)(5660300002)(71200400001)(86362001)(36756003)(83380400001)(316002)(91956017)(66946007)(66556008)(64756008)(2616005)(2906002)(8676002)(33656002)(186003)(6486002)(6506007)(76116006)(66476007)(53546011)(26005)(6512007)(8936002)(6916009)(98903001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?dp4CvQ40yJ1JMX5mBVZeBUhfAX+pTt3GtXOvLE7bPoE07AgtCt5ERWXaeOBd?=
 =?us-ascii?Q?KkQNnmwb3+PdEF0twp0M+RPQYZtfP3/3NiG32BRhZrFFvPRR74j4qmhFxzmj?=
 =?us-ascii?Q?lBRbgVHKXgGAbp+DKg2aWnpl2rqT8NjazIbzubKhJwPpsvr8rHGT9Sy+bQ38?=
 =?us-ascii?Q?JAfjrB9IlzFgNQxtFHLODYs6ijhW/hed19RTTg21saieqqvFTW3FN+PCof2w?=
 =?us-ascii?Q?/B+ZK2KpDSNeOKpzzWt6XhiQJkxGcjy6rRKYDQDIC6Yfb1S85bE+IfE23pJ6?=
 =?us-ascii?Q?TE+I43QG04uHvDqoLcFAzdkkPK4/eLLaLQWBPwpYz71118lWyVWwAzVLPcO9?=
 =?us-ascii?Q?r1r2u/ItAjAhDVGj0Pa9l6O0rvC14EfjiWEt19u04FJnVz4gmvo/puwcxL00?=
 =?us-ascii?Q?Ime+vKsk4SEwiheUyrfk6cP4Q1MZD9z+7RaIAFg3VzjBiUVZQa8v1Cp2RbKw?=
 =?us-ascii?Q?f1XXP1f14/uUBuH7hvisFG4Eh18JDm+rSPvoLBg1xKoaRZt8v33XPN7AJq6+?=
 =?us-ascii?Q?m7FQpRpiUU621ahudKMSNvGDogwXiz1P7jr6jTlx7SgcaQ6/KjFA0qJXN7OC?=
 =?us-ascii?Q?1iTwsDys+pS8y7HKneMj59EhDwUmMS5AM5LHmwUwdSyDvBeij5EhvHrORPun?=
 =?us-ascii?Q?XoT0L1Qlp8NMq7pWgdIdwObYkkrdyPIklVbVgLh1L/qo0rQTOu0NPWlL5n8P?=
 =?us-ascii?Q?FmXb+ReNbDvRGbsgbLAIs0i1urQBk/mOvUg3O6hBTDHdw8xInYm14mXH5odP?=
 =?us-ascii?Q?qSHLvWOVG9P2aJtSNvy8dIjxLd6Svuz23Y/SmNCnHH6CKNRRSpE5FEu/4PfP?=
 =?us-ascii?Q?bZtCmXCPA6ZHW8hTuwqBNx9AlaQ9x6ufRVFbrUM56d6kaS5eAtkuipk6oPvk?=
 =?us-ascii?Q?ogcYb4ych6onAd5RnvAkejUoMmz7H4dtRN+8z1DIjxwsVK40dU3xTkAsKXMK?=
 =?us-ascii?Q?dLw2hg7/IGPjh7cGAo3ESjKV69jr0VQzfpY+xxqArMGY6+QW9RLd6tRh47Ay?=
 =?us-ascii?Q?ebE3YuplapnDORqOasmtmkJOTw4ypJpi2KySzJx+x37oiTfdlBeUX0vqe+AI?=
 =?us-ascii?Q?QMk8II1eCZPAp68+8lUsllzfG2zjog=3D=3D?=
x-ms-exchange-transport-forked: True
Content-ID: <89BAB16C6DDC004699C0447CE00D067D@namprd10.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 583dc1a1-f49d-4bb4-9477-08d8c22056c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2021 17:32:22.2874 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zVkHyHsHRMACAXHlvo1Fc3mT8L5uLKSQoAysQ8W/Nrdlkakx1R0V2VjqckmxEvA2NpsfVejYZc98ZH+g4cEP9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3333
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9876
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=804
 mlxscore=0 spamscore=0
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101260090
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9876
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0 phishscore=0
 adultscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101260091
Cc: Will Deacon <will@kernel.org>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Robin-

> On Jan 26, 2021, at 11:05 AM, Robin Murphy <robin.murphy@arm.com> wrote:
> 
> Implementing .iotlb_sync_map means that a single top-level iommu_map()/iommu_map_sg() call should still only invoke a single "TLB flush" (really, any maintenance required for the IOMMU to start using the new mapping) at the end, regardless of how many internal __iommu_map() calls are made to satisfy the overall request. If you're seeing something other than that behaviour (with this series), that implies we've not got things quite right yet.


The flush is expensive, but it's not the only cost. DMA-mapping a 120KB
SGL in a single domain_mapping() call vs. 30 calls is certainly going to
be a detectable difference.

Naively speaking, if there are more DMA mappings to keep track of because
the IOMMU driver isn't coalescing the SGLs the way it did before, that
might trigger TLB thrashing on the NIC.


> Is there any significant difference between how the NFS read and write paths make their DMA API calls and/or get their scatterlists in the first place, that might help shed some light on the curious half-recovery you got?

There isn't a difference in the RPC-over-RDMA code. Client-side DMA mapping
is handled in net/sunrpc/xprtrdma/frwr_ops.c :: frwr_map() which is used for
both I/O directions.

On the server, the RDMA core r/w API is used for mapping and then posting
RDMA Read and Write work requests. That API appears in
drivers/infiniband/core/rw.c , and as far as I understand, the same mapping
functions are used for both I/O directions.

It's possible that the NIC is doing something different for RDMA Read and
RDMA Write, but I don't have much visibility into that. Reads are very
different from Writes, which are posted.


--
Chuck Lever



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
