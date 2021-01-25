Return-Path: <SRS0=REuq=G4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2697BC433DB
	for <iommu@archiver.kernel.org>; Mon, 25 Jan 2021 19:32:17 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B164A224DF
	for <iommu@archiver.kernel.org>; Mon, 25 Jan 2021 19:32:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B164A224DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3100086E9E;
	Mon, 25 Jan 2021 19:32:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P6UzNIT+Kata; Mon, 25 Jan 2021 19:32:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9773C873D7;
	Mon, 25 Jan 2021 19:32:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8134CC0FA7;
	Mon, 25 Jan 2021 19:32:14 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F77FC013A
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 19:32:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 2E2672038B
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 19:32:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aTxN4xDMT0jo for <iommu@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 19:32:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 by silver.osuosl.org (Postfix) with ESMTPS id 25D2820379
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 19:32:10 +0000 (UTC)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10PJPBDV001063;
 Mon, 25 Jan 2021 19:32:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=vH9fFLCmRsPxWaFdBrcZdO1/kWwU00frrXZNvPzGruQ=;
 b=jAFx1wqy71vQm1Sdc8vS+5W4NRFwQRgUc/jn/pgMsp8hV+CKVOTj3Dc275i5jRR+Bot3
 qL4zzm2uwh8ktUm6HhJsEhdsYQZKY+0dO2EevdlOVo287nqYro4Esui/13wITtiGUN+4
 a4m8ma/GjaVki/t22QNboqmaS+g0ISTkWpfsOkf0VRE6G0Rd0dPUc6KFkIGcJpUvOJIT
 569l5gOr/Yvnz1uiF1mkBxusZFugRKxYkW/uVd9hxmRjQV99knpFGd3EKZrXL0J/aepM
 kcfNt8hlKMrCUHzBj2up/3NWwUzWrYCgl645LXVQRmu5F9aIsvLOflIz8M6SBIlUup/6 IQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 368brkewbt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 25 Jan 2021 19:32:00 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10PJKfe2103974;
 Mon, 25 Jan 2021 19:32:00 GMT
Received: from nam02-cy1-obe.outbound.protection.outlook.com
 (mail-cys01nam02lp2053.outbound.protection.outlook.com [104.47.37.53])
 by aserp3020.oracle.com with ESMTP id 368wpx0vrp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 25 Jan 2021 19:32:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCrfZE1cSgWgmONsWxpd5qlESvsoqDhjlV+OhSkf2W2WWc7y4FPDdf0z4fRwTIdMrYe7Eq8VkXFw29b78UIB2MQ2cFwvXVXQZjEVB3e3HkO0A6+GhOlF/sk/cxN5Iw+PJ1nr4fuKFNJrssnlqrulezZBW1Xy1xeoYYHRhc9TID3j3pDr+mpqs6ZuS+rPkefrJgmavYdMw5OHS3Qgf/8bzloRACn8Nk3Nu9NzlPZgdRoSYYOuhiaxXIuLUPRTUfVVviMfOUaNFRjh3tHuy50co2uOsMfImyDCJEQyJIGVlgQGAnBh/Lt/UxW5N4WIjVG94e5At0cTs2iitThI0ZT/2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vH9fFLCmRsPxWaFdBrcZdO1/kWwU00frrXZNvPzGruQ=;
 b=Ot48zQjI9PiOZjhbUf80Zpy/Pq1oavW/HkdkZcTROdOFgCpBMP1kOpy5X2nDtTm2x8bVp/QJ5DtjYAYkOVrykRPajGLde7YuGyq1+0yZ73FccPNC6ZKYqTpUNDLqeCVrc3Ik2xZEvV6uCfawjHB9FrP7nP4riKY8DgOJko2jErjb3Yt4xEAu1rrRYN5HJOYh++o3DEikIF8tatrHHQL0EOyZ8M4WqTE47ru94B4A9SWY/bFmwJiN4DFweLVeiYGYQoES9zOu3hnWtFcLdy7U6wnsH/GeuWftwoPHaP3k5l2no5G0c4T84aN8IvlvJPgfMG8vW96lREMcEQ+BSqubkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vH9fFLCmRsPxWaFdBrcZdO1/kWwU00frrXZNvPzGruQ=;
 b=n108QwhF+9HW33O2mmE9rn9GyEoFZCWMLSVQ+0IFE43Ls9uPKmE16IS2Hiv5ITKbtEOClaMHtuU4xzZVWVFLTa8ei2vHgF1XvxqyE2TmBX8xYGWqjM3H31QOxPkjwtBSfBrOjRhcmp5IXTKFiwckNtab9sOBCjO/BkKLPTG2dEg=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3672.namprd10.prod.outlook.com (2603:10b6:a03:128::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Mon, 25 Jan
 2021 19:31:58 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3784.019; Mon, 25 Jan 2021
 19:31:58 +0000
From: Chuck Lever <chuck.lever@oracle.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [RFT PATCH 0/3] Performance regression noted in v5.11-rc after
 c062db039f40
Thread-Topic: [RFT PATCH 0/3] Performance regression noted in v5.11-rc after
 c062db039f40
Thread-Index: AQHW8sRzvAsRgI4bIEGwtoU2eSt8tao4nH8AgAAfcwA=
Date: Mon, 25 Jan 2021 19:31:58 +0000
Message-ID: <83EE54C6-F654-4D1D-92F7-F442ACEC8D70@oracle.com>
References: <20210125023858.570175-1-baolu.lu@linux.intel.com>
 <BDAEAC42-15F2-4C75-A28C-8E580F0CFF01@oracle.com>
In-Reply-To: <BDAEAC42-15F2-4C75-A28C-8E580F0CFF01@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none; linux.intel.com; dmarc=none action=none header.from=oracle.com; 
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca712f45-6563-43f5-3c16-08d8c167e1a0
x-ms-traffictypediagnostic: BYAPR10MB3672:
x-microsoft-antispam-prvs: <BYAPR10MB36728B6966D9DE1B2962A3E593BD9@BYAPR10MB3672.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cPJ5pwrH8FExEr22jb8LxVX3Ysuhk4gsBT/C1W4b8ObbSlsZ+4HMIyVKN/NTgdTzpdTp/djVmZA8avQ4LwkIPioeZfDXkoeJZLhr1j9MxWVNA0s5eiJ2c9J6FNkEOC/0lPtpfob9VdvnZARdhAX+PZ/dO7sAY+31vgVYbg0cApad98tfwGJCN4GqF2gsWb1XJOz+3cTsai3ozisaCWrBgCE6Mdza0qE3V0O9SodWwVs9cbpQB+IxHa5jyL3jJVpx5ngnBG6HDsNVmpHZKpdbcO2bS7C1LMex6r/TCxKSP+ghtMaUnfmhAmdE6srsE2J8qGFDklXZR4rKCH5zsx3L7m7zpHDxoluQ+U02nGRMGL4mWFheNf3YZKBL8n6v5Rx20Un5m6r7KmAuyJjwW1BtSxKhr6V+3AVtc2mUISF2+F9hMWjRR3TiNxFOof7/FptmR9UgAOEM9PZ1BSdrEA2qo7b9IxUp8XCZGMMl0JFKQCzqgn+64EhdSHvAFJ1ggSHEzHZUq4kbuIc7XhzIuTtYYT2A0gTElEN7sTGZU8JD1Y0rOKWvwfjx0bULmsrtiUiKLpreQm1lll+nIsn8v8D/h6qZL2WRL1OMFSfUr8Km2WL6WRlnjrrbUlepj7o595WIUz1E51dV8jTfoahDnZsM5r8qEUNIXl1E3t6hM/qXxLM9/iOguaP+vWPt+PsNk3SR
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB4688.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(376002)(346002)(366004)(396003)(136003)(39860400002)(8676002)(5660300002)(53546011)(91956017)(6506007)(66946007)(76116006)(86362001)(6512007)(33656002)(44832011)(966005)(36756003)(478600001)(64756008)(66446008)(66476007)(66556008)(4326008)(54906003)(316002)(2616005)(8936002)(6916009)(71200400001)(186003)(6486002)(2906002)(26005)(83380400001)(98903001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?yPhFcvO5nR/xBA8dVQ+tpIl71bxXeHny2KQU3fWU4M0o3dSXwpEu6NM76CbC?=
 =?us-ascii?Q?JCFb+cnhmlxUsVlXp1YwOjPKuRreUoH0/vcl8y83lVNSjjpEt6gdRVPb+Dzp?=
 =?us-ascii?Q?XMzujg0wQ5Q5WQ8rDC9bS8NlAvHqsp0SovNzhV1w7OMyNgUgFVRp6Ap5srDp?=
 =?us-ascii?Q?K/hU66arA9J6Roh1h9gQ+kcTT231coc6lSnLzx9WuSCcAwb91TVBPlwFzIug?=
 =?us-ascii?Q?cTosTRf+cA69h6t7RozoWU/SAqo9IbtTjI9RK26rHo8AXJrYAfhYRtFaP3oP?=
 =?us-ascii?Q?URWJSGhSnAO+zVRbrwgVyokwr0ij7S4bwo3XRba3usEUq0VZA34q9EtiCdj7?=
 =?us-ascii?Q?A4P0/tykiEkgLFHKwnsEryIBd/GvI7YDk94+fa1Tdq1TLGQ0a4ZWgXN1yrtO?=
 =?us-ascii?Q?GIccOa4I+lEbvWDxgUKF78ligQLew5rqaQdhJDrjWMnuRkpbriWYR13zBuAp?=
 =?us-ascii?Q?J65d/Pgq0YwZKR0l8v2cJZBTOI/Uit9YdjttCSuIQ/e6bTsrXsVkg8OQSEG3?=
 =?us-ascii?Q?xATYtwQDBMIHNometM/biZM66tp6ITFiMIizNc3HwXtWhktoeH0MNIwa5K1R?=
 =?us-ascii?Q?j3CZh+OpybWO4ntcQ16jFFmuR4ZdQUlEYIS+AE69RvaZmyvU1SxHttwdjG6M?=
 =?us-ascii?Q?ulYUNKQmJA6sqfx6c/0KpYAFUxmec4raXDUMe6CZawbdaYGhJhCPTSUUdDcu?=
 =?us-ascii?Q?6dsYAhXVbTnGsEQmorVoHux8J279OMieKvzjoSkDFOA1sSEJ0C4ct1LqUiKI?=
 =?us-ascii?Q?eosQ6r2cHuF6Tqh+a0rcypVocF1ZCBZ/H4rw33k+G8vXhWDndRgto6pmfpFx?=
 =?us-ascii?Q?L2/8Nj2dWtpwB11a0Tm/sacr3z/onu+gmM8pQSZytUN/n7HG+wZEUUWIKY7r?=
 =?us-ascii?Q?hK1Z4MoFkox2WySEoXsM9Scz0cCboYHAPrQVscSCKKrmk87Mtszvj0yqqpKx?=
 =?us-ascii?Q?wlMrlbe5GlVZ05hyBc5cAIJGHcqYHCBtQqql6PeZJpAQWu4/OFkFqJI//LYY?=
 =?us-ascii?Q?ZsOYfgpmEa83xsKJ3qupywGAex7OEUns79pQsXzfysaxeRUUVadQSuENkofu?=
 =?us-ascii?Q?qQhVvt+nhD2Jn+7KpZXkBjKGkpY3FA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-ID: <44768B17D851DA4A9995D7289306704A@namprd10.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca712f45-6563-43f5-3c16-08d8c167e1a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2021 19:31:58.3156 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RG55I9C4o70JNQRd2IL3cpImqFPLow9y80ScbWiSWZ9MWGndR7YYen871AmHb44j5r+z1L9k7Bh4LkRCfc257g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3672
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9875
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 spamscore=0
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101250101
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9875
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101250101
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



> On Jan 25, 2021, at 12:39 PM, Chuck Lever <chuck.lever@oracle.com> wrote:
> 
> Hello Lu -
> 
> Many thanks for your prototype.
> 
> 
>> On Jan 24, 2021, at 9:38 PM, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>> 
>> This patch series is only for Request-For-Testing purpose. It aims to
>> fix the performance regression reported here.
>> 
>> https://lore.kernel.org/linux-iommu/D81314ED-5673-44A6-B597-090E3CB83EB0@oracle.com/
>> 
>> The first two patches are borrowed from here.
>> 
>> https://lore.kernel.org/linux-iommu/20210107122909.16317-1-yong.wu@mediatek.com/
>> 
>> Please kindly help to verification.
>> 
>> Best regards,
>> baolu
>> 
>> Lu Baolu (1):
>> iommu/vt-d: Add iotlb_sync_map callback
>> 
>> Yong Wu (2):
>> iommu: Move iotlb_sync_map out from __iommu_map
>> iommu: Add iova and size as parameters in iotlb_sync_map
>> 
>> drivers/iommu/intel/iommu.c | 86 +++++++++++++++++++++++++------------
>> drivers/iommu/iommu.c       | 23 +++++++---
>> drivers/iommu/tegra-gart.c  |  7 ++-
>> include/linux/iommu.h       |  3 +-
>> 4 files changed, 83 insertions(+), 36 deletions(-)
> 
> Here are results with the NFS client at stock v5.11-rc5 and the
> NFS server at v5.10, showing the regression I reported earlier.
> 
> 	Children see throughput for 12 initial writers  = 4534582.00 kB/sec
> 	Parent sees throughput for 12 initial writers   = 4458145.56 kB/sec
> 	Min throughput per process                      = 373101.59 kB/sec 
> 	Max throughput per process                      = 382669.50 kB/sec
> 	Avg throughput per process                      = 377881.83 kB/sec
> 	Min xfer                                        = 1022720.00 kB
> 	CPU Utilization: Wall time    2.787    CPU time    1.922    CPU utilization  68.95 %
> 
> 
> 	Children see throughput for 12 rewriters        = 4542003.12 kB/sec
> 	Parent sees throughput for 12 rewriters         = 4538024.19 kB/sec
> 	Min throughput per process                      = 374672.00 kB/sec 
> 	Max throughput per process                      = 383983.78 kB/sec
> 	Avg throughput per process                      = 378500.26 kB/sec
> 	Min xfer                                        = 1022976.00 kB
> 	CPU utilization: Wall time    2.733    CPU time    1.947    CPU utilization  71.25 %
> 
> 
> 	Children see throughput for 12 readers          = 4568632.03 kB/sec
> 	Parent sees throughput for 12 readers           = 4563672.02 kB/sec
> 	Min throughput per process                      = 376727.56 kB/sec 
> 	Max throughput per process                      = 383783.91 kB/sec
> 	Avg throughput per process                      = 380719.34 kB/sec
> 	Min xfer                                        = 1029376.00 kB
> 	CPU utilization: Wall time    2.733    CPU time    1.898    CPU utilization  69.46 %
> 
> 
> 	Children see throughput for 12 re-readers       = 4610702.78 kB/sec
> 	Parent sees throughput for 12 re-readers        = 4606135.66 kB/sec
> 	Min throughput per process                      = 381532.78 kB/sec 
> 	Max throughput per process                      = 387072.53 kB/sec
> 	Avg throughput per process                      = 384225.23 kB/sec
> 	Min xfer                                        = 1034496.00 kB
> 	CPU utilization: Wall time    2.711    CPU time    1.910    CPU utilization  70.45 %
> 
> Here's the NFS client at v5.11-rc5 with your series applied.
> The NFS server remains at v5.10:
> 
> 	Children see throughput for 12 initial writers  = 4434778.81 kB/sec
> 	Parent sees throughput for 12 initial writers   = 4408190.69 kB/sec
> 	Min throughput per process                      = 367865.28 kB/sec 
> 	Max throughput per process                      = 371134.38 kB/sec
> 	Avg throughput per process                      = 369564.90 kB/sec
> 	Min xfer                                        = 1039360.00 kB
> 	CPU Utilization: Wall time    2.842    CPU time    1.904    CPU utilization  66.99 %
> 
> 
> 	Children see throughput for 12 rewriters        = 4476870.69 kB/sec
> 	Parent sees throughput for 12 rewriters         = 4471701.48 kB/sec
> 	Min throughput per process                      = 370985.34 kB/sec 
> 	Max throughput per process                      = 374752.28 kB/sec
> 	Avg throughput per process                      = 373072.56 kB/sec
> 	Min xfer                                        = 1038592.00 kB
> 	CPU utilization: Wall time    2.801    CPU time    1.902    CPU utilization  67.91 %
> 
> 
> 	Children see throughput for 12 readers          = 5865268.88 kB/sec
> 	Parent sees throughput for 12 readers           = 5854519.73 kB/sec
> 	Min throughput per process                      = 487766.81 kB/sec 
> 	Max throughput per process                      = 489623.88 kB/sec
> 	Avg throughput per process                      = 488772.41 kB/sec
> 	Min xfer                                        = 1044736.00 kB
> 	CPU utilization: Wall time    2.144    CPU time    1.895    CPU utilization  88.41 %
> 
> 
> 	Children see throughput for 12 re-readers       = 5847438.62 kB/sec
> 	Parent sees throughput for 12 re-readers        = 5839292.18 kB/sec
> 	Min throughput per process                      = 485835.03 kB/sec 
> 	Max throughput per process                      = 488702.12 kB/sec
> 	Avg throughput per process                      = 487286.55 kB/sec
> 	Min xfer                                        = 1042688.00 kB
> 	CPU utilization: Wall time    2.148    CPU time    1.909    CPU utilization  88.84 %
> 
> NFS READ throughput is almost fully restored. A normal-looking throughput
> result, copied from the previous thread, is:
> 
> 	Children see throughput for 12 readers 		= 5921370.94 kB/sec
> 	Parent sees throughput for 12 readers 		= 5914106.69 kB/sec
> 
> The NFS WRITE throughput result appears to be unchanged, or slightly
> worse than before. I don't have an explanation for this result. I applied
> your patches on the NFS server also without noting improvement.

Function-boundary tracing shows some interesting results.

# trace-cmd record -e rpcrdma -e iommu -p function_graph --max-graph-depth=5 -g dma_map_sg_attrs

Some 120KB SGLs are DMA-mapped in a single call to __iommu_map(). Other SGLs of
the same size need as many as one __iommu_map() call per SGL element (which
would be 30 for a 120KB SGL).

In v5.10, intel_map_sg() was structured such that an SGL is always handled with
a single call to domain_mapping() and thus always just a single TLB flush.

My amateur theorizing suggests that the SGL element coalescing done in
__iommu_map_sg() is not working as well as intel_map_sg() used to, which results
in more calls to domain_mapping(). Not only does that take longer, but it creates
many more DMA maps. Could that also have some impact on device TLB resources?


--
Chuck Lever



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
