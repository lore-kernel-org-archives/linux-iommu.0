Return-Path: <SRS0=REuq=G4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6869FC433E0
	for <iommu@archiver.kernel.org>; Mon, 25 Jan 2021 17:41:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE4BE22583
	for <iommu@archiver.kernel.org>; Mon, 25 Jan 2021 17:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE4BE22583
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8AD1D87410;
	Mon, 25 Jan 2021 17:41:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7-lzLytq8lLL; Mon, 25 Jan 2021 17:41:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 23B808681A;
	Mon, 25 Jan 2021 17:41:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A008C0FA7;
	Mon, 25 Jan 2021 17:41:39 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00AADC013A
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 17:41:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E1EEB85DC4
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 17:41:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XQdl-IS1BBpS for <iommu@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 17:41:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id DB5F285D94
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 17:41:35 +0000 (UTC)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10PHegZF190217;
 Mon, 25 Jan 2021 17:41:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=oJptZujb0kO9TTYTX5XRgfag5fL/Hssp8EYRZ83sgdU=;
 b=mnS9FrQ9Nanhk0mVhZxHD8DAzn1X2Bkeb8TWLe4JoPyM21WmLGv1x2ilDzD25lnHNB+W
 I45XKLj55L6xryks41gbkBZVgzi8eSKQKDRIOrBJwBmTiBNO+hSEr9nD2GqCozUEv2XJ
 rn1lD6OMSBwb19+owOc6+Z1j3Z0FjDfsmlyFygKib7MT1m9A+W41f5TH8TXgsrsQ3L5d
 xAiEv8qomnt236KDMJJaKyYonhEAZiyIUbl+qmRyB9zxpRDTRORXWCFH5rn9NRLqFnKt
 ZasyPM3S3+orSs/1SpIihpPlM5F9AwQ6456X0w3jO9l6pE6Eb0TL9BOc1oI9cGhTFtTz 6Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 368brked5e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 25 Jan 2021 17:41:26 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10PHFWS8156207;
 Mon, 25 Jan 2021 17:39:26 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
 by userp3020.oracle.com with ESMTP id 368wjq1kmu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 25 Jan 2021 17:39:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYE+pUMqJ5XJosEcFpsEriFaTH7KA9Ks8XI6iVvZXS778bPPog4dGFqB+qP+pgoZZHnsb2a1q9JgQN/6vLwhky5iwNn7Q0XqT0RLraXyTSKpu1SdQ23N5nofZ2i9hmK1xi1Xv/POwhuFlfI2+iQ0jbZNUEvdfcQX5JzsInoQSoJHMagH4eAPHNJRX8Q8pPgCqDQHP8TRgVf+CeJOx69eDya4WJR1cC9anc34SOGQtM/V++ZeSN3Czeta7NT4rtbWTc8rgVqbhgOkc7mgkjiNVBLy8VcmqzFaTyliwo4jtV3lI3sAIoMgiGwEBxTTBQqDR5DGzzYSyTYHkh1/lSlkpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJptZujb0kO9TTYTX5XRgfag5fL/Hssp8EYRZ83sgdU=;
 b=nF2yFb1cIZ39MrsUpXVFTpRfxWNcMGf3WyV+JUXjNmWYCW0CN4pJSoz4VkxVASE8MqqwavlupyMBpyip42GD8Tb+g90qDFb9igSdhJC2J+K5fJ4WHHnXW7ZJXWcSnkQXFNFk3Ruv98iEEYg0THqAKdC0cKUk+h4zn9J8ANPwM5toajaHEMWNIq5zQ0+C/u1mw07nErliXawZnV+ZUpdsZR5DZnQ9Tf0ekCtUBtX+zU8Gf47hPMzm/cOXx6Hn5FyzHggdRtdPVx3QufiBmVfATwTLdLdX9qz6/5gsGhQ/Z5XIKKkNbIZIHvOrW3biwKkaW8/z+JjbUYw3tGM0JmPOOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJptZujb0kO9TTYTX5XRgfag5fL/Hssp8EYRZ83sgdU=;
 b=iYHmQSQYMfmfERhtNmCyc7tuuizaT1Hcm8M2x0Ru2isI4upGynFRLIWyFwxkjS3gdHmabrf4lmDaBxsQVO7TUHn+9kugaWL3JqiUpV4fQ3+HIvqt5pe7VRLqSLpaesBUh5G1dQkAT9ZzGnoL/OkS4SyENb15gSnJSQmiieOjCGs=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3271.namprd10.prod.outlook.com (2603:10b6:a03:152::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Mon, 25 Jan
 2021 17:39:23 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3784.019; Mon, 25 Jan 2021
 17:39:23 +0000
From: Chuck Lever <chuck.lever@oracle.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [RFT PATCH 0/3] Performance regression noted in v5.11-rc after
 c062db039f40
Thread-Topic: [RFT PATCH 0/3] Performance regression noted in v5.11-rc after
 c062db039f40
Thread-Index: AQHW8sRzvAsRgI4bIEGwtoU2eSt8tao4nH8A
Date: Mon, 25 Jan 2021 17:39:23 +0000
Message-ID: <BDAEAC42-15F2-4C75-A28C-8E580F0CFF01@oracle.com>
References: <20210125023858.570175-1-baolu.lu@linux.intel.com>
In-Reply-To: <20210125023858.570175-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none; linux.intel.com; dmarc=none action=none header.from=oracle.com; 
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: abdef1b0-4de6-44d1-c593-08d8c1582731
x-ms-traffictypediagnostic: BYAPR10MB3271:
x-microsoft-antispam-prvs: <BYAPR10MB3271961652F6D0BD9903384193BD9@BYAPR10MB3271.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uDiWHvxWtJqUbpTqc85M0pMUb7cg6ZwgT1mnkPxgofsiq2hN0mVw7qSz9/u+HOz+odohl9sC+pm++TpHfmp2XTDwKsmEBI0hlAyqhrEJnWqpMpirx36iRLs43Wic5zDzjXsgk/q0Q8KK2rs985GwTL0D5OvZnntsh8ktgBMkHLIPT7r3+cXBewPgxwN9Imj9NAWNpsfMdZG03FUbjcROV7rfekorofRravSUdlcku7fu4JlJKMcIH3fowlolDQ7+xGCKzlh89t+dqBxbCeTp+zfReiW+IiaAlnnTN3AUPjUCIS6GH5m42HuNw5NArNfJcdbERL60QdVq6A13yIL6EuwqAWFPPSHLZ+g40+VzCD6c0OuPr9+Ns9/Vto4GSNdDfZVUp+x0b7m1TUF1j08zytQiaqmEth/a+PEEOSwX4Ab2MWY9aAJIaf1VzTE5+A9ira8CNigWwqCMq6AYVbBgaZReJGAOh2IS/SlER9LdMQJTyRTVnKlHHwuXovXezJhO3PmbkLdWsiNcwmkmbo2kJdIwcXwYF4qywGywFW/iIUE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB4688.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(376002)(396003)(366004)(39860400002)(136003)(186003)(91956017)(76116006)(33656002)(6506007)(53546011)(2616005)(36756003)(8676002)(26005)(66946007)(4326008)(54906003)(66476007)(44832011)(6486002)(2906002)(6512007)(66446008)(66556008)(64756008)(478600001)(6916009)(71200400001)(5660300002)(86362001)(316002)(83380400001)(966005)(8936002)(98903001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?yukOXC/z3kmohgLBtSxJXiPbyGAXVirVOhecYPnSJhrweDefgScIpYoF3jCd?=
 =?us-ascii?Q?B1p0BfhHBEqnyDnWZlWcnvp3WEtftpYmWJym/68+M+2jdwipFEjHvDQI4q6V?=
 =?us-ascii?Q?DOOPQvY5YEPRVvOyT3sliiXN64xDnapsF8VEo0CdXEvB5Io5OBf1hEU05bv/?=
 =?us-ascii?Q?Qul5LQEVTALFOJ3tQwSwczkqp2SilCQ6leCy0xIJkEVHnHCHnTDm70IlquiL?=
 =?us-ascii?Q?BspsvO9lqz8d+10BQ/YBjO65FsBjdtX/VZbIMa8ARGjnU+W+BvZhspXT087t?=
 =?us-ascii?Q?5YUpMYMqKEGxlc3+/WfDYN53xaF+ySJ+WPtAuRmengcruNT+mvSvhNh9Ubeg?=
 =?us-ascii?Q?d0GtWRHc1fcnhMApYRN2/Rsz8tiC+4jHyV/P8XxupfsyeDMzM4FWOLc0fL7x?=
 =?us-ascii?Q?IBFY8yMQuyEoeRLntichw2jd8XClq1YBHx467Ni5zBQjnbJkxj0CsV0GmYPn?=
 =?us-ascii?Q?KK035KK83ZuNxDmZnz63kixIeqsEUm/E4u3HW51lZbJjhhztEyGaL5XS7KBf?=
 =?us-ascii?Q?WtJJAfHQJilnpMYffzFjxoxpQbQU0phmlvX8LbNjP35MA7XwItNbCl394TUa?=
 =?us-ascii?Q?pXFLjgkDJfkGIRbgpijG9Xt+qbUrovCIBj8F4zHjCAiOdXK/MSRHS81vVg3A?=
 =?us-ascii?Q?qxfLiR/We+7fEDuZqYMtozFHicTPnvnhlXoPhKmsomqi9nbGmrFEOizT1ZcD?=
 =?us-ascii?Q?tmp4jFhAM6tRu939CPNEPOV0kPka6gQWVXOYe6CVK6Xm+vculKK0xHm88RBY?=
 =?us-ascii?Q?6vvHptyjPl2k+kJYdd0ntOKY4BvHBT30U8DwrfbckBTRhj0++7MXG9d9tg3l?=
 =?us-ascii?Q?tcSe6S5CuQXb8N8nT9vu3cATgo8hNJ/dQVue61l0DKEl3Gx3H40MsRIlVvWh?=
 =?us-ascii?Q?nWvQeicgyKAeFxgHaSTEu6svmE4r2rpHabIU1VYT5f2avoj1kZSdSkVt1c1V?=
 =?us-ascii?Q?gcwOOaC+G84XKxDKQFC7UIbbLiOJHRiC4MlUygQK3L2uxD+1c37bNBA9FkvB?=
 =?us-ascii?Q?XAIWVEbU0xYKAHcCMCKS9tNZTAezNMPwHTHikvdolne/sjjAGxu9o7/ulu1O?=
 =?us-ascii?Q?seVbCMJHrWNTRvcqyWfvkWT9hKro2g=3D=3D?=
x-ms-exchange-transport-forked: True
Content-ID: <48A8B4D05327B34EB9855F79496D93ED@namprd10.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abdef1b0-4de6-44d1-c593-08d8c1582731
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2021 17:39:23.0467 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uA2oHtg3FnJbrnkrw8bl1DAbUqjRbwgYkE9LjV8BLKgF/XAFfr/FG8OLaArzhNHVc5WvYyWj94eIaULnZ3LHyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3271
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9875
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0
 adultscore=0 mlxscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101250094
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9875
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101250095
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
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

Hello Lu -

Many thanks for your prototype.


> On Jan 24, 2021, at 9:38 PM, Lu Baolu <baolu.lu@linux.intel.com> wrote:
> 
> This patch series is only for Request-For-Testing purpose. It aims to
> fix the performance regression reported here.
> 
> https://lore.kernel.org/linux-iommu/D81314ED-5673-44A6-B597-090E3CB83EB0@oracle.com/
> 
> The first two patches are borrowed from here.
> 
> https://lore.kernel.org/linux-iommu/20210107122909.16317-1-yong.wu@mediatek.com/
> 
> Please kindly help to verification.
> 
> Best regards,
> baolu
> 
> Lu Baolu (1):
>  iommu/vt-d: Add iotlb_sync_map callback
> 
> Yong Wu (2):
>  iommu: Move iotlb_sync_map out from __iommu_map
>  iommu: Add iova and size as parameters in iotlb_sync_map
> 
> drivers/iommu/intel/iommu.c | 86 +++++++++++++++++++++++++------------
> drivers/iommu/iommu.c       | 23 +++++++---
> drivers/iommu/tegra-gart.c  |  7 ++-
> include/linux/iommu.h       |  3 +-
> 4 files changed, 83 insertions(+), 36 deletions(-)

Here are results with the NFS client at stock v5.11-rc5 and the
NFS server at v5.10, showing the regression I reported earlier.

	Children see throughput for 12 initial writers  = 4534582.00 kB/sec
	Parent sees throughput for 12 initial writers   = 4458145.56 kB/sec
	Min throughput per process                      = 373101.59 kB/sec 
	Max throughput per process                      = 382669.50 kB/sec
	Avg throughput per process                      = 377881.83 kB/sec
	Min xfer                                        = 1022720.00 kB
	CPU Utilization: Wall time    2.787    CPU time    1.922    CPU utilization  68.95 %


	Children see throughput for 12 rewriters        = 4542003.12 kB/sec
	Parent sees throughput for 12 rewriters         = 4538024.19 kB/sec
	Min throughput per process                      = 374672.00 kB/sec 
	Max throughput per process                      = 383983.78 kB/sec
	Avg throughput per process                      = 378500.26 kB/sec
	Min xfer                                        = 1022976.00 kB
	CPU utilization: Wall time    2.733    CPU time    1.947    CPU utilization  71.25 %


	Children see throughput for 12 readers          = 4568632.03 kB/sec
	Parent sees throughput for 12 readers           = 4563672.02 kB/sec
	Min throughput per process                      = 376727.56 kB/sec 
	Max throughput per process                      = 383783.91 kB/sec
	Avg throughput per process                      = 380719.34 kB/sec
	Min xfer                                        = 1029376.00 kB
	CPU utilization: Wall time    2.733    CPU time    1.898    CPU utilization  69.46 %


	Children see throughput for 12 re-readers       = 4610702.78 kB/sec
	Parent sees throughput for 12 re-readers        = 4606135.66 kB/sec
	Min throughput per process                      = 381532.78 kB/sec 
	Max throughput per process                      = 387072.53 kB/sec
	Avg throughput per process                      = 384225.23 kB/sec
	Min xfer                                        = 1034496.00 kB
	CPU utilization: Wall time    2.711    CPU time    1.910    CPU utilization  70.45 %

Here's the NFS client at v5.11-rc5 with your series applied.
The NFS server remains at v5.10:

	Children see throughput for 12 initial writers  = 4434778.81 kB/sec
	Parent sees throughput for 12 initial writers   = 4408190.69 kB/sec
	Min throughput per process                      = 367865.28 kB/sec 
	Max throughput per process                      = 371134.38 kB/sec
	Avg throughput per process                      = 369564.90 kB/sec
	Min xfer                                        = 1039360.00 kB
	CPU Utilization: Wall time    2.842    CPU time    1.904    CPU utilization  66.99 %


	Children see throughput for 12 rewriters        = 4476870.69 kB/sec
	Parent sees throughput for 12 rewriters         = 4471701.48 kB/sec
	Min throughput per process                      = 370985.34 kB/sec 
	Max throughput per process                      = 374752.28 kB/sec
	Avg throughput per process                      = 373072.56 kB/sec
	Min xfer                                        = 1038592.00 kB
	CPU utilization: Wall time    2.801    CPU time    1.902    CPU utilization  67.91 %


	Children see throughput for 12 readers          = 5865268.88 kB/sec
	Parent sees throughput for 12 readers           = 5854519.73 kB/sec
	Min throughput per process                      = 487766.81 kB/sec 
	Max throughput per process                      = 489623.88 kB/sec
	Avg throughput per process                      = 488772.41 kB/sec
	Min xfer                                        = 1044736.00 kB
	CPU utilization: Wall time    2.144    CPU time    1.895    CPU utilization  88.41 %


	Children see throughput for 12 re-readers       = 5847438.62 kB/sec
	Parent sees throughput for 12 re-readers        = 5839292.18 kB/sec
	Min throughput per process                      = 485835.03 kB/sec 
	Max throughput per process                      = 488702.12 kB/sec
	Avg throughput per process                      = 487286.55 kB/sec
	Min xfer                                        = 1042688.00 kB
	CPU utilization: Wall time    2.148    CPU time    1.909    CPU utilization  88.84 %

NFS READ throughput is almost fully restored. A normal-looking throughput
result, copied from the previous thread, is:

	Children see throughput for 12 readers 		= 5921370.94 kB/sec
	Parent sees throughput for 12 readers 		= 5914106.69 kB/sec

The NFS WRITE throughput result appears to be unchanged, or slightly
worse than before. I don't have an explanation for this result. I applied
your patches on the NFS server also without noting improvement.


--
Chuck Lever



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
