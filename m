Return-Path: <SRS0=J3Yr=GZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E580EC433DB
	for <iommu@archiver.kernel.org>; Fri, 22 Jan 2021 16:18:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7018D23A5C
	for <iommu@archiver.kernel.org>; Fri, 22 Jan 2021 16:18:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7018D23A5C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2FFA186AD2;
	Fri, 22 Jan 2021 16:18:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X-_9WuN0hLkD; Fri, 22 Jan 2021 16:18:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7387486ABB;
	Fri, 22 Jan 2021 16:18:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 64CFEC088B;
	Fri, 22 Jan 2021 16:18:45 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 85F68C013A
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 16:18:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 7257686AC1
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 16:18:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qtP2st5lMrI2 for <iommu@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 16:18:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 8F10986ABB
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 16:18:39 +0000 (UTC)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10MFwtnd084361;
 Fri, 22 Jan 2021 16:18:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=vRAdFPpAKAM4gXBXL5K6TBwaanL02iwbhbQ917HOv8A=;
 b=CaoDTMGFW0bGx4SLk7oiXkHvujgOitx4TRfaixVDzSZ+SDc50oKhqDTiuj6y6p2AZWeT
 4c3OnwSg/mpgU9by5jQ6usRBLJfAAw+1Z0iS/f6R9NScZ+SuzrWa3/bgig91IH2qr4WF
 zciqDiFxMA+KfnEeUAUG1E47tYa2jpEDIs7GnEZ0Di/wByoyKVSMx/PIphm4j19uwnW/
 Dxhk3THSYRLadSQSeGu6heRRXn6Ox/Bua13iecnRKAotrugJgtn1GN/5PgEMGIXqW+Yw
 k31TUtH/5F22j7Y01IQ6RjBGrLmkBq40VtKdccvlPFIjrEP9trW+2V2+BqKqEEdQgapA uw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2130.oracle.com with ESMTP id 3668qrmu43-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Jan 2021 16:18:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10MG0vEl127437;
 Fri, 22 Jan 2021 16:18:23 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
 by aserp3030.oracle.com with ESMTP id 3668r048bw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Jan 2021 16:18:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bFolyo6QJtxhnfqg5FS5K9xvnNca6g8Ar+SULgWpT5HEl1Rak3NUYQ0r/O2RSEL9YcXeFfdrMIRrNfg8h2LrIBWsrC9RUDtitSchLceJZxeyupr1tO1k52T5VLRqmO15iaxNWWkdKBH2WTTSJcwR5joz26LbWa2RgIntIuSkYWuw9D8rACXnY5nC88JBV3/mvuCRA1GifgB/2NFkx+ucIBG1EbTQCfmlHxtlyZNNt/cmra8Gn6bj0Vy5XYC6Aksh2jF5L8ooaikAW4kj8V21bNAf/FGYHM38+ofbcuU97My6fF4hEq4d5TDDg8qVEOOr6RBwF6l++GzOGksLKDxDxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRAdFPpAKAM4gXBXL5K6TBwaanL02iwbhbQ917HOv8A=;
 b=GHGUTlPWUZ15263PdPbaH7gb2SV+P5gURZLjqrZuJY52aySAcz9N29tIOjSdbtoU8GwUVPV/Bdix3Hy24DSUkbwtmRYl2r4WzAPlpN4iQKq6RtwrsLs+Lb2JGbt1nLkNHf6ZEgUM9y1zlhKyQovgx9bRoQz1BAOCVxnLtG0qSi0ipqdsMI8ktnvgSPZben0VGqkNyu7knAcaFRmDUE/3TyDW8FEfBlyaxtnndJdE1J0y09ivzFAsnHKB5qAj4Oyl6lBH+ntWb/+F5qSZGvtfYIlQ9fK9DHN/WMFycLicZwQYaaMm2UbHXT8Q1C9GECVWEMKM8hKa0VYPqWSwsa04iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRAdFPpAKAM4gXBXL5K6TBwaanL02iwbhbQ917HOv8A=;
 b=s8/Gh5F6YOAdaVskW+owFeWZyPonaizrhEOQPGQ3c2GzOYC5RsRQljArBlU8TpfJY69VdCGeb/DQzrltRIbdOcSfWkn3iEfu90/t26ogBdW99UAH0s0r+J5WdQ29p6TNnjrBKJUWfwotBtv00+/tfvsATsuH+6iGxuKC3S+QA+o=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4781.namprd10.prod.outlook.com (2603:10b6:a03:2d0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Fri, 22 Jan
 2021 16:18:21 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3784.015; Fri, 22 Jan 2021
 16:18:21 +0000
From: Chuck Lever <chuck.lever@oracle.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: performance regression noted in v5.11-rc after c062db039f40
Thread-Topic: performance regression noted in v5.11-rc after c062db039f40
Thread-Index: AQHW8CjtBQQTuiJM7EWdlhiEV8dliKoy9RQAgADe/wA=
Date: Fri, 22 Jan 2021 16:18:21 +0000
Message-ID: <3A4451BB-41BD-429B-BE0C-12AE7D03A99B@oracle.com>
References: <D81314ED-5673-44A6-B597-090E3CB83EB0@oracle.com>
 <20210112143819.GA9689@willie-the-truck>
 <607648D8-BF0C-40D6-9B43-2359F45EE74C@oracle.com>
 <e83eed0d-82cd-c9be-cef1-5fe771de975f@arm.com>
 <3568C74A-A587-4464-8840-24F7A93ABA06@oracle.com>
 <990a7c1e-e8c0-a6a8-f057-03b104cebca3@linux.intel.com>
In-Reply-To: <990a7c1e-e8c0-a6a8-f057-03b104cebca3@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none; linux.intel.com; dmarc=none action=none header.from=oracle.com; 
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 00c652a6-9565-4a5b-e826-08d8bef155f2
x-ms-traffictypediagnostic: SJ0PR10MB4781:
x-microsoft-antispam-prvs: <SJ0PR10MB4781776D1718B0C0E68CB52493A00@SJ0PR10MB4781.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sWd6bneeam+/BY79SntL6tSKuR9gTJDGegZp4mJ4fFiY+nO1WHJdG57sucILtyDayBqSmKX0plLRQHpZZIiLobp9MTOzkAaWBK8E7DdCEX7uuYkb4odmIHDkJ4BqiFVrPRK0Qi9vV/xnGd3ZsxrHXAOM8VErs9kcnQV++QDg683QXxsAnjgRcCsqCNZXKCzQ21bYy3GSdxY5jMZS0y88Bj6R3FmAlU+JzE4lcbFfateGeWOHsfQh6o4Bjt0WBucRJ094j+Sk5hoTdRG6u7ZpV7da4HjasTwMULwQ1FSwk4991ikHltdF5VNnfLT8Mu7mBvKUflGB4naoy2uYgQYXtB9kDzFxggExGgLSHaCwFsgPxGFPJPs0HDPOwhJyJvnUXPhP4o2ijX/F8/f9s8OmbzQxerbxSnFNlAb/7n0k8Ge+OII7YVpFNbvBff6COWqxWJDPlKqx7P1wWwNFd0DELIOZBijlKI65+k7NhefxIXxfAmxVp8vedWKGjLBwnX95BqSyaGPEbq9KBYaes+kl7iQwWRzNVR4dEeyjnkCgsFY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB4688.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(39860400002)(136003)(366004)(396003)(376002)(346002)(66476007)(54906003)(86362001)(6512007)(8936002)(966005)(53546011)(478600001)(6486002)(66446008)(44832011)(2906002)(76116006)(91956017)(30864003)(66946007)(6916009)(8676002)(71200400001)(186003)(26005)(33656002)(36756003)(316002)(6506007)(83380400001)(4326008)(66556008)(2616005)(5660300002)(64756008)(98903001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?+tolLIeNKfxZL2a0sOIBgzrRiOtY9zat4pV8fyoN7ryEKV1beavBBwkjvQa6?=
 =?us-ascii?Q?RiaOJh6G/6+4prbzHrZItgv/eqmU7vnj2ZtaF9/SXKTCKjSz5FupOavlHbxg?=
 =?us-ascii?Q?ImaV6+9wdAUlSM4Zmkfs/ltGRZIzPke2GzVJ9CQSLjUsryHcwMK/T/hRJcE0?=
 =?us-ascii?Q?FZ2iXUKw+4IRScOg4CMCbz2p2gyG5u264eRFYdgSf/Wtvuxod5nnX4Nnm3+X?=
 =?us-ascii?Q?cFA2y1HrgNSV3+ch3ARlWZoCYTfU3wkcVexCrWqs3Bo201zV7aK1ntBeE9N/?=
 =?us-ascii?Q?ICFBgcwksuiCnbpdjGllMdvpJGPg0ovBTgnduL1YI1Fc1JvLjUYd4+E+R8Nx?=
 =?us-ascii?Q?YW8HIFHyU1Vq/SZYpwqd1rpD0wAj9gxGscK4LSqmTsNuIGxayq3slg+TUxap?=
 =?us-ascii?Q?+dSFXIM83CpDvDZDR4u+jHtu16SYcNw6d+Yl7hauUMIuTVa3EmWdPnhM3M4M?=
 =?us-ascii?Q?iUy8eCyVjITsCeB8pYtJsj7ZDcpHmceRaC1/+wXYhDxvVHjxwM87eA0lkaKr?=
 =?us-ascii?Q?dcIzlGKG/GF2zUqGuJja0jnoB73cmYiDG8z1AgO4gIoqBuddJ/V0kF/NbSSJ?=
 =?us-ascii?Q?vdqHuSqTgR2ZIQZcvTYLO6XDauqdrgOh9b42MYSyehllM/kDPCLVtykIRTjG?=
 =?us-ascii?Q?QDgG8vjnw9OdGw/RM59w9dLeRXh1Xr402PJV3eGOJw0udid58VHHJXn9nvvw?=
 =?us-ascii?Q?8KoIwaYtS7ApebXKkEFMxb6UWtrB1cdmN4Ix95s/ClzOOuWf/tzm8ZdbhK0X?=
 =?us-ascii?Q?dwAmAooxWUpP+yy91c6OGgl6vIoSgt1FhdgdW5rFL+xXBoo2UU0XK5UP120j?=
 =?us-ascii?Q?fkresOSpEayGDPU4yza9dFAcYLTIJz75m4Ac9vp9pWOSrrt9PBmtlKgfVb5a?=
 =?us-ascii?Q?I0dECkEtQna/UmJmNHTTKlSn7X+h411rMZHUGNlKu2slSXTczOapQiB4+ea/?=
 =?us-ascii?Q?CKRvGNgLqb/JISGXowIbUUm2tt7wSIFWs1DOhSTrI6L1FkxyDWFTHwKa6KSF?=
 =?us-ascii?Q?kIiI?=
x-ms-exchange-transport-forked: True
Content-ID: <368A5C04476E884195256951DFC7134D@namprd10.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00c652a6-9565-4a5b-e826-08d8bef155f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2021 16:18:21.0576 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fA6DI+CsByq+3/n6ErgymPxAek3q0Q3SP6nnm01/aVBGrKxlOqh+zAiwm/4J/94VSxPux32PPNMGpozAxla1yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4781
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9872
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101220088
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9872
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101220088
Cc: "isaacm@codeaurora.org" <isaacm@codeaurora.org>,
 linux-rdma <linux-rdma@vger.kernel.org>,
 "logang@deltatee.com" <logang@deltatee.com>,
 Robin Murphy <robin.murphy@arm.com>, "murphyt7@tcd.ie" <murphyt7@tcd.ie>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>
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



> On Jan 21, 2021, at 10:00 PM, Lu Baolu <baolu.lu@linux.intel.com> wrote:
> 
> +Isaac
> 
> On 1/22/21 3:09 AM, Chuck Lever wrote:
>>> On Jan 18, 2021, at 1:00 PM, Robin Murphy <robin.murphy@arm.com> wrote:
>>> 
>>> On 2021-01-18 16:18, Chuck Lever wrote:
>>>>> On Jan 12, 2021, at 9:38 AM, Will Deacon <will@kernel.org> wrote:
>>>>> 
>>>>> [Expanding cc list to include DMA-IOMMU and intel IOMMU folks]
>>>>> 
>>>>> On Fri, Jan 08, 2021 at 04:18:36PM -0500, Chuck Lever wrote:
>>>>>> Hi-
>>>>>> 
>>>>>> [ Please cc: me on replies, I'm not currently subscribed to
>>>>>> iommu@lists ].
>>>>>> 
>>>>>> I'm running NFS performance tests on InfiniBand using CX-3 Pro cards
>>>>>> at 56Gb/s. The test is iozone on an NFSv3/RDMA mount:
>>>>>> 
>>>>>> /home/cel/bin/iozone -M -+u -i0 -i1 -s1g -r256k -t12 -I
>>>>>> 
>>>>>> For those not familiar with the way storage protocols use RDMA, The
>>>>>> initiator/client sets up memory regions and the target/server uses
>>>>>> RDMA Read and Write to move data out of and into those regions. The
>>>>>> initiator/client uses only RDMA memory registration and invalidation
>>>>>> operations, and the target/server uses RDMA Read and Write.
>>>>>> 
>>>>>> My NFS client is a two-socket 12-core x86_64 system with its I/O MMU
>>>>>> enabled using the kernel command line options "intel_iommu=on
>>>>>> iommu=strict".
>>>>>> 
>>>>>> Recently I've noticed a significant (25-30%) loss in NFS throughput.
>>>>>> I was able to bisect on my client to the following commits.
>>>>>> 
>>>>>> Here's 65f746e8285f ("iommu: Add quirk for Intel graphic devices in
>>>>>> map_sg"). This is about normal for this test.
>>>>>> 
>>>>>> 	Children see throughput for 12 initial writers 	= 4732581.09 kB/sec
>>>>>> 	Parent sees throughput for 12 initial writers 	= 4646810.21 kB/sec
>>>>>> 	Min throughput per process 			=  387764.34 kB/sec
>>>>>> 	Max throughput per process 			=  399655.47 kB/sec
>>>>>> 	Avg throughput per process 			=  394381.76 kB/sec
>>>>>> 	Min xfer 					= 1017344.00 kB
>>>>>> 	CPU Utilization: Wall time    2.671    CPU time    1.974    CPU utilization  73.89 %
>>>>>> 	Children see throughput for 12 rewriters 	= 4837741.94 kB/sec
>>>>>> 	Parent sees throughput for 12 rewriters 	= 4833509.35 kB/sec
>>>>>> 	Min throughput per process 			=  398983.72 kB/sec
>>>>>> 	Max throughput per process 			=  406199.66 kB/sec
>>>>>> 	Avg throughput per process 			=  403145.16 kB/sec
>>>>>> 	Min xfer 					= 1030656.00 kB
>>>>>> 	CPU utilization: Wall time    2.584    CPU time    1.959    CPU utilization  75.82 %
>>>>>> 	Children see throughput for 12 readers 		= 5921370.94 kB/sec
>>>>>> 	Parent sees throughput for 12 readers 		= 5914106.69 kB/sec
>>>>>> 	Min throughput per process 			=  491812.38 kB/sec
>>>>>> 	Max throughput per process 			=  494777.28 kB/sec
>>>>>> 	Avg throughput per process 			=  493447.58 kB/sec
>>>>>> 	Min xfer 					= 1042688.00 kB
>>>>>> 	CPU utilization: Wall time    2.122    CPU time    1.968    CPU utilization  92.75 %
>>>>>> 	Children see throughput for 12 re-readers 	= 5947985.69 kB/sec
>>>>>> 	Parent sees throughput for 12 re-readers 	= 5941348.51 kB/sec
>>>>>> 	Min throughput per process 			=  492805.81 kB/sec
>>>>>> 	Max throughput per process 			=  497280.19 kB/sec
>>>>>> 	Avg throughput per process 			=  495665.47 kB/sec
>>>>>> 	Min xfer 					= 1039360.00 kB
>>>>>> 	CPU utilization: Wall time    2.111    CPU time    1.968    CPU utilization  93.22 %
>>>>>> 
>>>>>> Here's c062db039f40 ("iommu/vt-d: Update domain geometry in
>>>>>> iommu_ops.at(de)tach_dev"). It's losing some steam here.
>>>>>> 
>>>>>> 	Children see throughput for 12 initial writers 	= 4342419.12 kB/sec
>>>>>> 	Parent sees throughput for 12 initial writers 	= 4310612.79 kB/sec
>>>>>> 	Min throughput per process 			=  359299.06 kB/sec
>>>>>> 	Max throughput per process 			=  363866.16 kB/sec
>>>>>> 	Avg throughput per process 			=  361868.26 kB/sec
>>>>>> 	Min xfer 					= 1035520.00 kB
>>>>>> 	CPU Utilization: Wall time    2.902    CPU time    1.951    CPU utilization  67.22 %
>>>>>> 	Children see throughput for 12 rewriters 	= 4408576.66 kB/sec
>>>>>> 	Parent sees throughput for 12 rewriters 	= 4404280.87 kB/sec
>>>>>> 	Min throughput per process 			=  364553.88 kB/sec
>>>>>> 	Max throughput per process 			=  370029.28 kB/sec
>>>>>> 	Avg throughput per process 			=  367381.39 kB/sec
>>>>>> 	Min xfer 					= 1033216.00 kB
>>>>>> 	CPU utilization: Wall time    2.836    CPU time    1.956    CPU utilization  68.97 %
>>>>>> 	Children see throughput for 12 readers 		= 5406879.47 kB/sec
>>>>>> 	Parent sees throughput for 12 readers 		= 5401862.78 kB/sec
>>>>>> 	Min throughput per process 			=  449583.03 kB/sec
>>>>>> 	Max throughput per process 			=  451761.69 kB/sec
>>>>>> 	Avg throughput per process 			=  450573.29 kB/sec
>>>>>> 	Min xfer 					= 1044224.00 kB
>>>>>> 	CPU utilization: Wall time    2.323    CPU time    1.977    CPU utilization  85.12 %
>>>>>> 	Children see throughput for 12 re-readers 	= 5410601.12 kB/sec
>>>>>> 	Parent sees throughput for 12 re-readers 	= 5403504.40 kB/sec
>>>>>> 	Min throughput per process 			=  449918.12 kB/sec
>>>>>> 	Max throughput per process 			=  452489.28 kB/sec
>>>>>> 	Avg throughput per process 			=  450883.43 kB/sec
>>>>>> 	Min xfer 					= 1043456.00 kB
>>>>>> 	CPU utilization: Wall time    2.321    CPU time    1.978    CPU utilization  85.21 %
>>>>>> 
>>>>>> And here's c588072bba6b ("iommu/vt-d: Convert intel iommu driver to
>>>>>> the iommu ops"). Significant throughput loss.
>>>>>> 
>>>>>> 	Children see throughput for 12 initial writers 	= 3812036.91 kB/sec
>>>>>> 	Parent sees throughput for 12 initial writers 	= 3753683.40 kB/sec
>>>>>> 	Min throughput per process 			=  313672.25 kB/sec
>>>>>> 	Max throughput per process 			=  321719.44 kB/sec
>>>>>> 	Avg throughput per process 			=  317669.74 kB/sec
>>>>>> 	Min xfer 					= 1022464.00 kB
>>>>>> 	CPU Utilization: Wall time    3.309    CPU time    1.986    CPU utilization  60.02 %
>>>>>> 	Children see throughput for 12 rewriters 	= 3786831.94 kB/sec
>>>>>> 	Parent sees throughput for 12 rewriters 	= 3783205.58 kB/sec
>>>>>> 	Min throughput per process 			=  313654.44 kB/sec
>>>>>> 	Max throughput per process 			=  317844.50 kB/sec
>>>>>> 	Avg throughput per process 			=  315569.33 kB/sec
>>>>>> 	Min xfer 					= 1035520.00 kB
>>>>>> 	CPU utilization: Wall time    3.302    CPU time    1.945    CPU utilization  58.90 %
>>>>>> 	Children see throughput for 12 readers 		= 4265828.28 kB/sec
>>>>>> 	Parent sees throughput for 12 readers 		= 4261844.88 kB/sec
>>>>>> 	Min throughput per process 			=  352305.00 kB/sec
>>>>>> 	Max throughput per process 			=  357726.22 kB/sec
>>>>>> 	Avg throughput per process 			=  355485.69 kB/sec
>>>>>> 	Min xfer 					= 1032960.00 kB
>>>>>> 	CPU utilization: Wall time    2.934    CPU time    1.942    CPU utilization  66.20 %
>>>>>> 	Children see throughput for 12 re-readers 	= 4220651.19 kB/sec
>>>>>> 	Parent sees throughput for 12 re-readers 	= 4216096.04 kB/sec
>>>>>> 	Min throughput per process 			=  348677.16 kB/sec
>>>>>> 	Max throughput per process 			=  353467.44 kB/sec
>>>>>> 	Avg throughput per process 			=  351720.93 kB/sec
>>>>>> 	Min xfer 					= 1035264.00 kB
>>>>>> 	CPU utilization: Wall time    2.969    CPU time    1.952    CPU utilization  65.74 %
>>>>>> 
>>>>>> The regression appears to be 100% reproducible.
>>>> Any thoughts?
>>>> How about some tools to try or debugging advice? I don't know where to start.
>>> 
>>> I'm not familiar enough with VT-D internals or Infiniband to have a clue why the middle commit makes any difference (the calculation itself is not on a fast path, so AFAICS the worst it could do is change your maximum DMA address size from 48/57 bits to 47/56, and that seems relatively benign).
>>> 
>>> With the last commit, though, at least part of it is likely to be the unfortunate inevitable overhead of the internal indirection through the IOMMU API. There's a coincidental performance-related thread where we've already started pondering some ideas in that area[1] (note that Intel is the last one to the party here; AMD has been using this path for a while, and it's all that arm64 systems have ever known). I'm not sure if there's any difference in the strict invalidation behaviour between the IOMMU API calls and the old intel_dma_ops, but I suppose that might be worth quickly double-checking as well. I guess the main thing would be to do some profiling to see where time is being spent in iommu-dma and intel-iommu vs. just different parts of intel-iommu before, and whether anything in particular stands out beyond the extra call overhead currently incurred by iommu_{map,unmap}.
>> I did a function_graph trace of the above iozone test on a v5.10 NFS
>> client and again on v5.11-rc. There is a substantial timing difference
>> in dma_map_sg_attrs. Each excerpt below is for DMA-mapping a 120KB set
>> of pages that are part of an NFS/RDMA WRITE operation.
>> v5.10:
>> 1072.028308: funcgraph_entry:                   |  dma_map_sg_attrs() {
>> 1072.028308: funcgraph_entry:                   |    intel_map_sg() {
>> 1072.028309: funcgraph_entry:                   |      find_domain() {
>> 1072.028309: funcgraph_entry:        0.280 us   |        get_domain_info();
>> 1072.028310: funcgraph_exit:         0.930 us   |      }
>> 1072.028310: funcgraph_entry:        0.360 us   |      domain_get_iommu();
>> 1072.028311: funcgraph_entry:                   |      intel_alloc_iova() {
>> 1072.028311: funcgraph_entry:                   |        alloc_iova_fast() {
>> 1072.028311: funcgraph_entry:        0.375 us   |          _raw_spin_lock_irqsave();
>> 1072.028312: funcgraph_entry:        0.285 us   |          __lock_text_start();
>> 1072.028313: funcgraph_exit:         1.500 us   |        }
>> 1072.028313: funcgraph_exit:         2.052 us   |      }
>> 1072.028313: funcgraph_entry:                   |      domain_mapping() {
>> 1072.028313: funcgraph_entry:                   |        __domain_mapping() {
>> 1072.028314: funcgraph_entry:        0.350 us   |          pfn_to_dma_pte();
>> 1072.028315: funcgraph_entry:        0.942 us   |          domain_flush_cache();
>> 1072.028316: funcgraph_exit:         2.852 us   |        }
>> 1072.028316: funcgraph_entry:        0.275 us   |        iommu_flush_write_buffer();
>> 1072.028317: funcgraph_exit:         4.213 us   |      }
>> 1072.028318: funcgraph_exit:         9.392 us   |    }
>> 1072.028318: funcgraph_exit:       + 10.073 us  |  }
>> 1072.028323: xprtrdma_mr_map:      mr.id=115 nents=30 122880@0xe476ca03f1180000:0x18011105 (TO_DEVICE)
>> 1072.028323: xprtrdma_chunk_read:  task:63879@5 pos=148 122880@0xe476ca03f1180000:0x18011105 (more)
>> v5.11-rc:
>> 57.602990: funcgraph_entry:                   |  dma_map_sg_attrs() {
>> 57.602990: funcgraph_entry:                   |    iommu_dma_map_sg() {
>> 57.602990: funcgraph_entry:        0.285 us   |      iommu_get_dma_domain();
>> 57.602991: funcgraph_entry:        0.270 us   |      iommu_dma_deferred_attach();
>> 57.602991: funcgraph_entry:                   |      iommu_dma_sync_sg_for_device() {
>> 57.602992: funcgraph_entry:        0.268 us   |        dev_is_untrusted();
>> 57.602992: funcgraph_exit:         0.815 us   |      }
>> 57.602993: funcgraph_entry:        0.267 us   |      dev_is_untrusted();
>> 57.602993: funcgraph_entry:                   |      iommu_dma_alloc_iova() {
>> 57.602994: funcgraph_entry:                   |        alloc_iova_fast() {
>> 57.602994: funcgraph_entry:        0.260 us   |          _raw_spin_lock_irqsave();
>> 57.602995: funcgraph_entry:        0.293 us   |          _raw_spin_lock();
>> 57.602995: funcgraph_entry:        0.273 us   |          _raw_spin_unlock_irqrestore();
>> 57.602996: funcgraph_entry:        1.147 us   |          alloc_iova();
>> 57.602997: funcgraph_exit:         3.370 us   |        }
>> 57.602997: funcgraph_exit:         3.945 us   |      }
>> 57.602998: funcgraph_entry:        0.272 us   |      dma_info_to_prot();
>> 57.602998: funcgraph_entry:                   |      iommu_map_sg_atomic() {
>> 57.602998: funcgraph_entry:                   |        __iommu_map_sg() {
>> 57.602999: funcgraph_entry:        1.733 us   |          __iommu_map();
>> 57.603001: funcgraph_entry:        1.642 us   |          __iommu_map();
>> 57.603003: funcgraph_entry:        1.638 us   |          __iommu_map();
>> 57.603005: funcgraph_entry:        1.645 us   |          __iommu_map();
>> 57.603007: funcgraph_entry:        1.630 us   |          __iommu_map();
>> 57.603009: funcgraph_entry:        1.770 us   |          __iommu_map();
>> 57.603011: funcgraph_entry:        1.730 us   |          __iommu_map();
>> 57.603013: funcgraph_entry:        1.633 us   |          __iommu_map();
>> 57.603015: funcgraph_entry:        1.605 us   |          __iommu_map();
>> 57.603017: funcgraph_entry:        2.847 us   |          __iommu_map();
>> 57.603020: funcgraph_entry:        2.847 us   |          __iommu_map();
>> 57.603024: funcgraph_entry:        2.955 us   |          __iommu_map();
>> 57.603027: funcgraph_entry:        2.928 us   |          __iommu_map();
>> 57.603030: funcgraph_entry:        2.933 us   |          __iommu_map();
>> 57.603034: funcgraph_entry:        2.943 us   |          __iommu_map();
>> 57.603037: funcgraph_entry:        2.928 us   |          __iommu_map();
>> 57.603040: funcgraph_entry:        2.857 us   |          __iommu_map();
>> 57.603044: funcgraph_entry:        2.953 us   |          __iommu_map();
>> 57.603047: funcgraph_entry:        3.023 us   |          __iommu_map();
>> 57.603050: funcgraph_entry:        1.645 us   |          __iommu_map();
>> 57.603052: funcgraph_exit:       + 53.648 us  |        }
>> 57.603052: funcgraph_exit:       + 54.178 us  |      }
>> 57.603053: funcgraph_exit:       + 62.953 us  |    }
>> 57.603053: funcgraph_exit:       + 63.567 us  |  }
>> 57.603059: xprtrdma_mr_map:      task:60@5 mr.id=4 nents=30 122880@0xd79cc0e2f18c0000:0x00010501 (TO_DEVICE)
>> 57.603060: xprtrdma_chunk_read:  task:60@5 pos=148 122880@0xd79cc0e2f18c0000:0x00010501 (more)
> 
> I kind of believe it's due to the indirect calls. This is also reported
> on ARM.
> 
> https://lore.kernel.org/linux-iommu/1610376862-927-1-git-send-email-isaacm@codeaurora.org/
> 
> Maybe we can try changing indirect calls to static ones to verify this
> problem.

I liked the idea of map_sg() enough to try my hand at building a PoC for
Intel, based on Isaac's patch series. It's just a cut-and-paste of the
generic iommu.c code with the indirect calls to ops->map() replaced.

The indirect calls do not seem to be the problem. Calling intel_iommu_map
directly appears to be as costly as calling it indirectly.

However, perhaps there are other ways map_sg() can be beneficial. In
v5.10, __domain_mapping and iommu_flush_write_buffer() appear to be
invoked just once for each large map operation, for example.


Here's a trace of my prototype in operation:

380.620150: funcgraph_entry:                   |  iommu_dma_map_sg() {
380.620150: funcgraph_entry:        0.285 us   |    iommu_get_dma_domain();
380.620150: funcgraph_entry:        0.265 us   |    iommu_dma_deferred_attach();
380.620151: funcgraph_entry:                   |    iommu_dma_sync_sg_for_device() {
380.620151: funcgraph_entry:        0.285 us   |      dev_is_untrusted();
380.620152: funcgraph_exit:         0.860 us   |    }
380.620152: funcgraph_entry:        0.263 us   |    dev_is_untrusted();
380.620153: funcgraph_entry:                   |    iommu_dma_alloc_iova() {
380.620153: funcgraph_entry:                   |      alloc_iova_fast() {
380.620153: funcgraph_entry:        0.268 us   |        _raw_spin_lock_irqsave();
380.620154: funcgraph_entry:        0.275 us   |        _raw_spin_unlock_irqrestore();
380.620155: funcgraph_exit:         1.402 us   |      }
380.620155: funcgraph_exit:         1.955 us   |    }
380.620155: funcgraph_entry:        0.265 us   |    dma_info_to_prot();
380.620156: funcgraph_entry:                   |    iommu_map_sg_atomic() {
380.620156: funcgraph_entry:                   |      __iommu_map_sg() {
380.620156: funcgraph_entry:                   |        intel_iommu_map_sg() {
380.620157: funcgraph_entry:        0.270 us   |          iommu_pgsize();
380.620157: funcgraph_entry:                   |          intel_iommu_map() {
380.620157: funcgraph_entry:        0.970 us   |            __domain_mapping();
380.620159: funcgraph_entry:        0.265 us   |            iommu_flush_write_buffer();
380.620159: funcgraph_exit:         2.322 us   |          }
380.620160: funcgraph_entry:        0.270 us   |          iommu_pgsize();
380.620160: funcgraph_entry:                   |          intel_iommu_map() {
380.620161: funcgraph_entry:        0.957 us   |            __domain_mapping();
380.620162: funcgraph_entry:        0.275 us   |            iommu_flush_write_buffer();
380.620163: funcgraph_exit:         2.315 us   |          }
380.620163: funcgraph_entry:        0.265 us   |          iommu_pgsize();
380.620163: funcgraph_entry:                   |          intel_iommu_map() {
380.620164: funcgraph_entry:        0.940 us   |            __domain_mapping();
380.620165: funcgraph_entry:        0.270 us   |            iommu_flush_write_buffer();
380.620166: funcgraph_exit:         2.295 us   |          }

 ....

380.620247: funcgraph_entry:        0.262 us   |          iommu_pgsize();
380.620248: funcgraph_entry:                   |          intel_iommu_map() {
380.620248: funcgraph_entry:        0.935 us   |            __domain_mapping();
380.620249: funcgraph_entry:        0.305 us   |            iommu_flush_write_buffer();
380.620250: funcgraph_exit:         2.315 us   |          }
380.620250: funcgraph_entry:        0.273 us   |          iommu_pgsize();
380.620251: funcgraph_entry:                   |          intel_iommu_map() {
380.620251: funcgraph_entry:        0.967 us   |            __domain_mapping();
380.620253: funcgraph_entry:        0.265 us   |            iommu_flush_write_buffer();
380.620253: funcgraph_exit:         2.310 us   |          }
380.620254: funcgraph_exit:       + 97.388 us  |        }
380.620254: funcgraph_exit:       + 97.960 us  |      }
380.620254: funcgraph_exit:       + 98.482 us  |    }
380.620255: funcgraph_exit:       ! 105.175 us |  }
380.620260: xprtrdma_mr_map:      task:1607@5 mr.id=126 nents=30 122880@0xf06ee5bbf1920000:0x70011104 (TO_DEVICE)
380.620261: xprtrdma_chunk_read:  task:1607@5 pos=148 122880@0xf06ee5bbf1920000:0x70011104 (more)


--
Chuck Lever



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
