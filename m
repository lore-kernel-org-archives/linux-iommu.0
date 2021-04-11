Return-Path: <SRS0=/53O=JI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA58EC433B4
	for <iommu@archiver.kernel.org>; Sun, 11 Apr 2021 19:37:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77CF6610A7
	for <iommu@archiver.kernel.org>; Sun, 11 Apr 2021 19:37:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77CF6610A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3E01183696;
	Sun, 11 Apr 2021 19:37:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id akySEpHvF1tQ; Sun, 11 Apr 2021 19:36:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 455E7831A2;
	Sun, 11 Apr 2021 19:36:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1D066C000C;
	Sun, 11 Apr 2021 19:36:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 87825C000A
 for <iommu@lists.linux-foundation.org>; Sun, 11 Apr 2021 19:36:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 67DAD83696
 for <iommu@lists.linux-foundation.org>; Sun, 11 Apr 2021 19:36:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id txXtm2-JzVf2 for <iommu@lists.linux-foundation.org>;
 Sun, 11 Apr 2021 19:36:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6DA89831A2
 for <iommu@lists.linux-foundation.org>; Sun, 11 Apr 2021 19:36:49 +0000 (UTC)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13BJaOjr079910;
 Sun, 11 Apr 2021 19:36:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 mime-version; s=corp-2020-01-29;
 bh=dVOoRGgA318xFyHjBB/aoUhdWSpSKw5f2zD32jlfqhs=;
 b=AZZj29/MPys75fSmG9m7F8MLTNP6ZnqwmjxHF26EPy6z3Mfgv263ON83KNiWq9zojnap
 TbqTDQpHKL3ffLClvaC+7F2m6BHTKaoTAlsO1OQH6CY2nHASqkYtLJq6fagYx1Tj5r5m
 oNO/4OMlLEFWx741KZL0cbr317CGcsE2TM3XQMcEiX0AIeD5ozPDD9kzm9+pixkIxVvW
 S3U97HkwHaDt+0+y0BFA5k35fylDZyFSVkmDH/MUg5nNpzbL+09bQ9W94cQQPpxlFSGa
 hC5vS0ceZZUqlWbMALs3oaEAiNv5G4vKWOftysZxeUnCgksckgxlKtb9mFVXveTP+EyJ YA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 37u4nn9uhm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 11 Apr 2021 19:36:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13BJZWDW054145;
 Sun, 11 Apr 2021 19:36:23 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
 by aserp3020.oracle.com with ESMTP id 37unwwjyes-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 11 Apr 2021 19:36:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OcUPOaTtT4I3VqnTh6+OEZ4DJWtve9AnyUVwgqv54nf0iJZ2pGDDTGdF3pShjhVTvPkiN63Nxs6fpNnLRRo5nuvCV7KYBw8rI8kLjHyqrUrGdJoFc7pjLdK72Thcf2pTzB8QjyER120aePxTDZvFvPJUGJ41+H5Pdok+qMrZabfE0cIkG9Ohv1OR9X5abTQPngv0ZLNOsrRsDWuzaFhHCLVPSeisPkxIBAX2CmXeOAkjsx8ZkxTfld3MowcWiQGtZVvgqPKahXToO5L+ZPNRuqlxCzrOQEkdnsGmjkP7eLM16OvBIIWel/fp4HXUhU51RRA0n1j3PGMHh2ABLy2qKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dVOoRGgA318xFyHjBB/aoUhdWSpSKw5f2zD32jlfqhs=;
 b=KghRz37VP6lX/HB60e1NGW4nB7yloWCev4wiKl9ssqNV8CpkQQKGGi6JYW+zIVIOAA6hvv7righqZRTQMJvuVnLE5bohtGr45WXg1tewklEfmPc5iITl7u3qKukyIfmLNWWrY8QIrVWab8DcXStar5sYeAsi1ZP3vDBosGN3tTkIi3eQeBNajJzYlbzgiYOyzkdfEkD+sVtzIrKXelF9y5BMRnlT71rPrOmdnES7TWvs4HabKlk3iI4fbXCH2n08fyUgOKPc7+Z6WBK6OqKoTjNNyHOiDfGEWxjBj41g7BOzHuu6nwII9CezNs1goNhbO8jnrAWXyKm4vny6XXviVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dVOoRGgA318xFyHjBB/aoUhdWSpSKw5f2zD32jlfqhs=;
 b=QJD6J79x5Dx7JwDLb2Ei5Ltnzj05CqdDd+Y+N/SisqDAYXmMm6NlCnyacvbTOgv4liCCXZ/SRYxp+cdpFCKpGnciqTP5dcboP23oxxjgbBoWFVjdBV0hi/EKoaV9ONFMr9kxj3QgwF107D0OJ/OwQgWlLqQSM5H3vHNPPT0OFyA=
Received: from BN8PR10MB3571.namprd10.prod.outlook.com (2603:10b6:408:ad::23)
 by BN6PR1001MB2386.namprd10.prod.outlook.com (2603:10b6:405:30::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Sun, 11 Apr
 2021 19:36:20 +0000
Received: from BN8PR10MB3571.namprd10.prod.outlook.com
 ([fe80::6919:5191:f3ad:ff9d]) by BN8PR10MB3571.namprd10.prod.outlook.com
 ([fe80::6919:5191:f3ad:ff9d%7]) with mapi id 15.20.4020.022; Sun, 11 Apr 2021
 19:36:20 +0000
From: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 5.4 v2 1/1] iommu/vt-d: Fix agaw for a supported 48 bit
 guest address width
Thread-Topic: [PATCH 5.4 v2 1/1] iommu/vt-d: Fix agaw for a supported 48 bit
 guest address width
Thread-Index: AQHXK92E2Pb9yfR2lku6DbKUN6XPZ6qpw5SAgAX4kQA=
Date: Sun, 11 Apr 2021 19:36:20 +0000
Message-ID: <E3377E7A-073F-4D9C-92FE-8CC4836343AF@oracle.com>
References: <20210407184030.21683-1-saeed.mirzamohammadi@oracle.com>
 <deca9431-a52a-2818-4493-5a6ffeadccb9@linux.intel.com>
In-Reply-To: <deca9431-a52a-2818-4493-5a6ffeadccb9@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none; linux.intel.com; dmarc=none action=none header.from=oracle.com; 
x-originating-ip: [184.188.120.221]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf298c5e-9083-4259-5c48-08d8fd211529
x-ms-traffictypediagnostic: BN6PR1001MB2386:
x-microsoft-antispam-prvs: <BN6PR1001MB2386ACE4D9FD14D02E1C524CF1719@BN6PR1001MB2386.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jMhPKVgFiak/j4lFf+jvHYFjQIjxEBfqVTz/9RGTX7HnqX8txb1S06U+tFI7dhp9L2oclOZlw34FseMjOx9SQhk9DQSze5uKjHL627Mf8IkAz+1H9bNgcFKNjudb1MC0/ljlKgtoW87E3d8iFQ0v8Iw4fq3FvwvjphuL/58KZns+WnOGStNSw1FO2aGpHLOumWzVdPa44VkPDOxRh7hqz9KtlgkPhcM8Vpne/j1mhMEG39tloqhEimiSkvQPZPFcIvyqUClXQHr8z3FzwpnPStPHk4gGYTw7Gg7hBfAhYH9Lve4vTuGoToUUG3H0H9wMXg+g1W+r0N99asyA7VKtcF0l9l21/wGcq/SoS7DZ8e6uv7fe04ON1c43MBa0cEF60EHqTBVDdNs/eTx/WGckMCXI87muisNw+9Tx9CQcOlljOcIXeE8Dp65cTcfaYjPe2jaswNwXIp9GwcBV1lk8KsqFpipxfzx8dUAXzF11rJ6sBt0FuuqV2zUvBcXxifASSGwTbYRFBReqjVyFtRi9Un7wOS2pEd72Shotk3LhiE8KXxwdRA6fpi1B0Uyl25bOoOL1OmjWQe96xbXrm2qYL0so+kdDjK8bzS2/W0/jJqvgGgzLTtokEtrpf76yuZQQt7yQB/BItlbM2hJpcvo+pK39/uUn3RSYrJ6+1XA/hJc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR10MB3571.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(396003)(376002)(136003)(346002)(39860400002)(366004)(6506007)(53546011)(478600001)(44832011)(316002)(83380400001)(8676002)(186003)(38100700002)(71200400001)(33656002)(91956017)(2906002)(36756003)(6512007)(86362001)(66556008)(64756008)(66476007)(66446008)(2616005)(26005)(6486002)(76116006)(6916009)(66946007)(8936002)(54906003)(4326008)(5660300002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?N1Poyjnqz0aRyFXmcDL/TFUtZSszTiDsMFaB9d0mFn024uAa2fowYzn0C2Ix?=
 =?us-ascii?Q?EYSMKD1cI/rCMt4s9r8Yaz7CNSHhqGTqvdsPibyoT7I3y9s95DEt8aCxRGdE?=
 =?us-ascii?Q?P8Flxjj+I9+nk5CakywHkG8Dk2/2EaelcSvdTp4938O7em5OUdugWtHa0PTy?=
 =?us-ascii?Q?X4zf7IxRFBXEiht3+zwa3M1403nt211of+IFywSICR99ObOBfPiJ4UF5j7kN?=
 =?us-ascii?Q?ZfiS2IKbcrEAG+4cyLFX6cbnfl6h983NeWWWwHMp4SeQW/J1ybIPrjYOiDPt?=
 =?us-ascii?Q?20sjaGPaF/BMCOZMmEubhlFj5H0it1bY2RnB/uYZL+1X8qqG9s0M7Gbjv03K?=
 =?us-ascii?Q?r3q4R/pfZth0c9Osv/7q05mkwNAhD/15wt0sA8XKxelbIP9phJDzADhMCokF?=
 =?us-ascii?Q?UVug++tReJuKFLBhwJPe9B0GBAl6Ot6GTcQgAD5uDYqTT1TInTynf5R+atdZ?=
 =?us-ascii?Q?SpYUMz6DOHd7ymEBx+4nkDteiCtCeRoRlauYpFpg7ghjhJVzN4qLjx6kVv1B?=
 =?us-ascii?Q?3cO/0qe22kl2gP6C3A1jiKq0NLeOwFiMZkh82EYU9QEGdGDM97Vw+2VUzsr5?=
 =?us-ascii?Q?vJS5bWiuAgSybMOPp1ALm89o1/HNpERFKCNixNYLC6mmMqdoWI6X0uJxkYYw?=
 =?us-ascii?Q?WsHhwAWs9IKmnx6k5BZNDQytX2eFhF1BRoQ4bhJqPrkehhX3PSjYBV7VQg+8?=
 =?us-ascii?Q?8xoMm9j2kTyG/nCpyeG7yhd0Gu3tAcp94VciyZeDdwuGSbgikhsWC2MY8WS5?=
 =?us-ascii?Q?j2jUOlGOahsqIEFoGCQ7CQGOQDaMMobd/vaJltkV23KHaA1+ULhIAD59dUbY?=
 =?us-ascii?Q?kQYAZzpCT0NPwP1yA6kDS2S+Ay+j2oatu+IQiAw6bbkwyGyKzRJir3bEzcgR?=
 =?us-ascii?Q?fK/vBM5ujwfMI3695030lsNK1in7EKw24w8L69azill8Y1lVo8qPfGNVXJcK?=
 =?us-ascii?Q?6WOeXcJ9fNGunViEUFm9YSlTfPIU7rm+2/eo1KHooFkM2ruc4PyQOFP0Pqg2?=
 =?us-ascii?Q?8f1/SKXmWfRPqdxaVrYxfGvQek70mEqmY9d+2rff53Pv4bmO2i7l0PipShqp?=
 =?us-ascii?Q?BdJV9pIrIXMcqpJpVfRjWA3VbmlJC64soLcDqh/J/iJB3W8s/6d+JSQrP8bq?=
 =?us-ascii?Q?yNwRH998j+Yb13eO0Z2BFPiwwXPfvlEAU/E2xhlJclmsg/n5rViJwfF3t0bC?=
 =?us-ascii?Q?vBinIXpSnUBhRiwNmGoA0XPXyRV3258AxjvSbNnbh1VWyi61u+13q6F9tvI1?=
 =?us-ascii?Q?OFHjRv3DvAFCheqnO3DJS5WlXhZsOssWNMCVq9603n5sPOUSx5Hy2nwN54vp?=
 =?us-ascii?Q?K0v9eWIT0UMfVVJfwwX77+ak?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3571.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf298c5e-9083-4259-5c48-08d8fd211529
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2021 19:36:20.1776 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fDEKZCgTTHGAlXDmvx5ZxquFQ5frxjy5/N+oxRU/G4kHiYTGNZEkfNTB7KPrhTg/nQhkEzIu7OvSOb8o8P88x6Lvj3t8IXBhO5KcLsZKof8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2386
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9951
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 suspectscore=0
 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104110152
X-Proofpoint-ORIG-GUID: 7514pZ_vq2V_zzuMVWNJK-wsIHjlR_6h
X-Proofpoint-GUID: 7514pZ_vq2V_zzuMVWNJK-wsIHjlR_6h
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9951
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 spamscore=0 impostorscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104110152
Cc: David Woodhouse <dwmw2@infradead.org>, Camille Lu <camille.lu@hpe.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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
Content-Type: multipart/mixed; boundary="===============6742458032690693094=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============6742458032690693094==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_E3377E7A073F4D9C92FE8CC4836343AForaclecom_"

--_000_E3377E7A073F4D9C92FE8CC4836343AForaclecom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Lu,

Thanks for the review. May I know when do we expect this to be applied to 5=
.4?

Thanks,
Saeed

On Apr 7, 2021, at 5:25 PM, Lu Baolu <baolu.lu@linux.intel.com<mailto:baolu=
.lu@linux.intel.com>> wrote:

On 4/8/21 2:40 AM, Saeed Mirzamohammadi wrote:
The IOMMU driver calculates the guest addressability for a DMA request
based on the value of the mgaw reported from the IOMMU. However, this
is a fused value and as mentioned in the spec, the guest width
should be calculated based on the minimum of supported adjusted guest
address width (SAGAW) and MGAW.
This is from specification:
"Guest addressability for a given DMA request is limited to the
minimum of the value reported through this field and the adjusted
guest address width of the corresponding page-table structure.
(Adjusted guest address widths supported by hardware are reported
through the SAGAW field)."
This causes domain initialization to fail and following
errors appear for EHCI PCI driver:
[    2.486393] ehci-pci 0000:01:00.4: EHCI Host Controller
[    2.486624] ehci-pci 0000:01:00.4: new USB bus registered, assigned bus
number 1
[    2.489127] ehci-pci 0000:01:00.4: DMAR: Allocating domain failed
[    2.489350] ehci-pci 0000:01:00.4: DMAR: 32bit DMA uses non-identity
mapping
[    2.489359] ehci-pci 0000:01:00.4: can't setup: -12
[    2.489531] ehci-pci 0000:01:00.4: USB bus 1 deregistered
[    2.490023] ehci-pci 0000:01:00.4: init 0000:01:00.4 fail, -12
[    2.490358] ehci-pci: probe of 0000:01:00.4 failed with error -12
This issue happens when the value of the sagaw corresponds to a
48-bit agaw. This fix updates the calculation of the agaw based on
the minimum of IOMMU's sagaw value and MGAW.
Signed-off-by: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com<mailto=
:saeed.mirzamohammadi@oracle.com>>
Tested-by: Camille Lu <camille.lu@hpe.com<mailto:camille.lu@hpe.com>>
---
Change in v2:
- Added cap_width to calculate AGAW based on the minimum value of MGAW and =
AGAW.
---
 drivers/iommu/intel-iommu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 953d86ca6d2b..a2a03df97704 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1853,7 +1853,7 @@ static inline int guestwidth_to_adjustwidth(int gaw)
 static int domain_init(struct dmar_domain *domain, struct intel_iommu *iom=
mu,
         int guest_width)
 {
- int adjust_width, agaw;
+ int adjust_width, agaw, cap_width;
  unsigned long sagaw;
  int err;
 @@ -1867,8 +1867,9 @@ static int domain_init(struct dmar_domain *domain, s=
truct intel_iommu *iommu,
  domain_reserve_special_ranges(domain);
    /* calculate AGAW */
- if (guest_width > cap_mgaw(iommu->cap))
- guest_width =3D cap_mgaw(iommu->cap);
+ cap_width =3D min_t(int, cap_mgaw(iommu->cap), agaw_to_width(iommu->agaw)=
);
+ if (guest_width > cap_width)
+ guest_width =3D cap_width;
  domain->gaw =3D guest_width;
  adjust_width =3D guestwidth_to_adjustwidth(guest_width);
  agaw =3D width_to_agaw(adjust_width);

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com<mailto:baolu.lu@linux.intel=
.com>>

Best regards,
baolu


--_000_E3377E7A073F4D9C92FE8CC4836343AForaclecom_
Content-Type: text/html; charset="us-ascii"
Content-ID: <3894A251D3ABE149BADAFC7B4C0B544B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; line-break:=
 after-white-space;" class=3D"">
Hi Lu,
<div class=3D""><br class=3D"">
</div>
<div class=3D"">Thanks for the review. May I know when do we expect this to=
 be applied to 5.4?</div>
<div class=3D""><br class=3D"">
</div>
<div class=3D"">Thanks,</div>
<div class=3D"">Saeed<br class=3D"">
<div class=3D"">
<div><br class=3D"">
<blockquote type=3D"cite" class=3D"">
<div class=3D"">On Apr 7, 2021, at 5:25 PM, Lu Baolu &lt;<a href=3D"mailto:=
baolu.lu@linux.intel.com" class=3D"">baolu.lu@linux.intel.com</a>&gt; wrote=
:</div>
<br class=3D"Apple-interchange-newline">
<div class=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helv=
etica; font-size: 12px; font-style: normal; font-variant-caps: normal; font=
-weight: normal; letter-spacing: normal; text-align: start; text-indent: 0p=
x; text-transform: none; white-space: normal; word-spacing: 0px; -webkit-te=
xt-stroke-width: 0px; text-decoration: none; float: none; display: inline !=
important;" class=3D"">On
 4/8/21 2:40 AM, Saeed Mirzamohammadi wrote:</span><br style=3D"caret-color=
: rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: normal=
; font-variant-caps: normal; font-weight: normal; letter-spacing: normal; t=
ext-align: start; text-indent: 0px; text-transform: none; white-space: norm=
al; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: non=
e;" class=3D"">
<blockquote type=3D"cite" style=3D"font-family: Helvetica; font-size: 12px;=
 font-style: normal; font-variant-caps: normal; font-weight: normal; letter=
-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-=
transform: none; white-space: normal; widows: auto; word-spacing: 0px; -web=
kit-text-size-adjust: auto; -webkit-text-stroke-width: 0px; text-decoration=
: none;" class=3D"">
The IOMMU driver calculates the guest addressability for a DMA request<br c=
lass=3D"">
based on the value of the mgaw reported from the IOMMU. However, this<br cl=
ass=3D"">
is a fused value and as mentioned in the spec, the guest width<br class=3D"=
">
should be calculated based on the minimum of supported adjusted guest<br cl=
ass=3D"">
address width (SAGAW) and MGAW.<br class=3D"">
This is from specification:<br class=3D"">
&quot;Guest addressability for a given DMA request is limited to the<br cla=
ss=3D"">
minimum of the value reported through this field and the adjusted<br class=
=3D"">
guest address width of the corresponding page-table structure.<br class=3D"=
">
(Adjusted guest address widths supported by hardware are reported<br class=
=3D"">
through the SAGAW field).&quot;<br class=3D"">
This causes domain initialization to fail and following<br class=3D"">
errors appear for EHCI PCI driver:<br class=3D"">
[ &nbsp;&nbsp;&nbsp;2.486393] ehci-pci 0000:01:00.4: EHCI Host Controller<b=
r class=3D"">
[ &nbsp;&nbsp;&nbsp;2.486624] ehci-pci 0000:01:00.4: new USB bus registered=
, assigned bus<br class=3D"">
number 1<br class=3D"">
[ &nbsp;&nbsp;&nbsp;2.489127] ehci-pci 0000:01:00.4: DMAR: Allocating domai=
n failed<br class=3D"">
[ &nbsp;&nbsp;&nbsp;2.489350] ehci-pci 0000:01:00.4: DMAR: 32bit DMA uses n=
on-identity<br class=3D"">
mapping<br class=3D"">
[ &nbsp;&nbsp;&nbsp;2.489359] ehci-pci 0000:01:00.4: can't setup: -12<br cl=
ass=3D"">
[ &nbsp;&nbsp;&nbsp;2.489531] ehci-pci 0000:01:00.4: USB bus 1 deregistered=
<br class=3D"">
[ &nbsp;&nbsp;&nbsp;2.490023] ehci-pci 0000:01:00.4: init 0000:01:00.4 fail=
, -12<br class=3D"">
[ &nbsp;&nbsp;&nbsp;2.490358] ehci-pci: probe of 0000:01:00.4 failed with e=
rror -12<br class=3D"">
This issue happens when the value of the sagaw corresponds to a<br class=3D=
"">
48-bit agaw. This fix updates the calculation of the agaw based on<br class=
=3D"">
the minimum of IOMMU's sagaw value and MGAW.<br class=3D"">
Signed-off-by: Saeed Mirzamohammadi &lt;<a href=3D"mailto:saeed.mirzamohamm=
adi@oracle.com" class=3D"">saeed.mirzamohammadi@oracle.com</a>&gt;<br class=
=3D"">
Tested-by: Camille Lu &lt;<a href=3D"mailto:camille.lu@hpe.com" class=3D"">=
camille.lu@hpe.com</a>&gt;<br class=3D"">
---<br class=3D"">
Change in v2:<br class=3D"">
- Added cap_width to calculate AGAW based on the minimum value of MGAW and =
AGAW.<br class=3D"">
---<br class=3D"">
&nbsp;drivers/iommu/intel-iommu.c | 7 ++++---<br class=3D"">
&nbsp;1 file changed, 4 insertions(+), 3 deletions(-)<br class=3D"">
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c<br c=
lass=3D"">
index 953d86ca6d2b..a2a03df97704 100644<br class=3D"">
--- a/drivers/iommu/intel-iommu.c<br class=3D"">
+++ b/drivers/iommu/intel-iommu.c<br class=3D"">
@@ -1853,7 +1853,7 @@ static inline int guestwidth_to_adjustwidth(int gaw)<=
br class=3D"">
&nbsp;static int domain_init(struct dmar_domain *domain, struct intel_iommu=
 *iommu,<br class=3D"">
&nbsp;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><s=
pan class=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span class=
=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;int guest_width)<br class=3D"">
&nbsp;{<br class=3D"">
-<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>int adj=
ust_width, agaw;<br class=3D"">
+<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>int adj=
ust_width, agaw, cap_width;<br class=3D"">
&nbsp;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>un=
signed long sagaw;<br class=3D"">
&nbsp;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>in=
t err;<br class=3D"">
&nbsp;@@ -1867,8 +1867,9 @@ static int domain_init(struct dmar_domain *doma=
in, struct intel_iommu *iommu,<br class=3D"">
&nbsp;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>do=
main_reserve_special_ranges(domain);<br class=3D"">
&nbsp;&nbsp;&nbsp;<span class=3D"Apple-tab-span" style=3D"white-space: pre;=
"> </span>/* calculate AGAW */<br class=3D"">
-<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>if (gue=
st_width &gt; cap_mgaw(iommu-&gt;cap))<br class=3D"">
-<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><span c=
lass=3D"Apple-tab-span" style=3D"white-space: pre;"></span>guest_width =3D =
cap_mgaw(iommu-&gt;cap);<br class=3D"">
+<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>cap_wid=
th =3D min_t(int, cap_mgaw(iommu-&gt;cap), agaw_to_width(iommu-&gt;agaw));<=
br class=3D"">
+<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>if (gue=
st_width &gt; cap_width)<br class=3D"">
+<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><span c=
lass=3D"Apple-tab-span" style=3D"white-space: pre;"></span>guest_width =3D =
cap_width;<br class=3D"">
&nbsp;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>do=
main-&gt;gaw =3D guest_width;<br class=3D"">
&nbsp;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>ad=
just_width =3D guestwidth_to_adjustwidth(guest_width);<br class=3D"">
&nbsp;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>ag=
aw =3D width_to_agaw(adjust_width);<br class=3D"">
</blockquote>
<br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: normal; l=
etter-spacing: normal; text-align: start; text-indent: 0px; text-transform:=
 none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0=
px; text-decoration: none;" class=3D"">
<span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size=
: 12px; font-style: normal; font-variant-caps: normal; font-weight: normal;=
 letter-spacing: normal; text-align: start; text-indent: 0px; text-transfor=
m: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width:=
 0px; text-decoration: none; float: none; display: inline !important;" clas=
s=3D"">Reviewed-by:
 Lu Baolu &lt;</span><a href=3D"mailto:baolu.lu@linux.intel.com" style=3D"f=
ont-family: Helvetica; font-size: 12px; font-style: normal; font-variant-ca=
ps: normal; font-weight: normal; letter-spacing: normal; orphans: auto; tex=
t-align: start; text-indent: 0px; text-transform: none; white-space: normal=
; widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-=
text-stroke-width: 0px;" class=3D"">baolu.lu@linux.intel.com</a><span style=
=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; fon=
t-style: normal; font-variant-caps: normal; font-weight: normal; letter-spa=
cing: normal; text-align: start; text-indent: 0px; text-transform: none; wh=
ite-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-=
decoration: none; float: none; display: inline !important;" class=3D"">&gt;=
</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font=
-size: 12px; font-style: normal; font-variant-caps: normal; font-weight: no=
rmal; letter-spacing: normal; text-align: start; text-indent: 0px; text-tra=
nsform: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-w=
idth: 0px; text-decoration: none;" class=3D"">
<br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: normal; l=
etter-spacing: normal; text-align: start; text-indent: 0px; text-transform:=
 none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0=
px; text-decoration: none;" class=3D"">
<span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size=
: 12px; font-style: normal; font-variant-caps: normal; font-weight: normal;=
 letter-spacing: normal; text-align: start; text-indent: 0px; text-transfor=
m: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width:=
 0px; text-decoration: none; float: none; display: inline !important;" clas=
s=3D"">Best
 regards,</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvet=
ica; font-size: 12px; font-style: normal; font-variant-caps: normal; font-w=
eight: normal; letter-spacing: normal; text-align: start; text-indent: 0px;=
 text-transform: none; white-space: normal; word-spacing: 0px; -webkit-text=
-stroke-width: 0px; text-decoration: none;" class=3D"">
<span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size=
: 12px; font-style: normal; font-variant-caps: normal; font-weight: normal;=
 letter-spacing: normal; text-align: start; text-indent: 0px; text-transfor=
m: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width:=
 0px; text-decoration: none; float: none; display: inline !important;" clas=
s=3D"">baolu</span></div>
</blockquote>
</div>
<br class=3D"">
</div>
</div>
</body>
</html>

--_000_E3377E7A073F4D9C92FE8CC4836343AForaclecom_--

--===============6742458032690693094==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============6742458032690693094==--
