Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92637C433F5
	for <iommu@archiver.kernel.org>; Wed, 11 May 2022 08:43:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2DF4241884;
	Wed, 11 May 2022 08:43:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CzlXhCo6Cqvk; Wed, 11 May 2022 08:43:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E7AEB40908;
	Wed, 11 May 2022 08:43:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B93A2C0032;
	Wed, 11 May 2022 08:43:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DDAB1C002D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 08:43:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B6B7560B5B
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 08:43:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="R8+x1V1L";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="CwTZzCsQ"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S0DbMPh7gKJr for <iommu@lists.linux-foundation.org>;
 Wed, 11 May 2022 08:43:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DD07560B03
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 08:43:06 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24B6I2AK010450;
 Wed, 11 May 2022 08:42:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=+H94JXryVrmoxymAhbIh5qtReTXuE6pNSHxsKpKlcZU=;
 b=R8+x1V1LW9MeTiwhZaLRS7Muq346fVziyS1IH7jYgDeayto6Ev7es0iORAhUh5D8lteH
 eTLirG57mplXWwcpDj1VwGvNe8oGaCdXpCQR3rrY4MEhHAEi7zwQTnM8MN0hG05FtVRO
 baMxTqfNbH8jZd3BOSOxNguIdVrCjvvmfR1Fqc/1PwQg6RJlMTmUui8pclZBOI6H5daC
 3jNB62Xf5Y2nEkQtiK3fcoiVTEJHVTwXMyCxSpae5gkwDYJQuWAAKog59x2VGSly/2hM
 dD7LSWUxeBteTSCP0p9nf7twWYHuAoTuDBxtE3x+vzYZrgSMc0CU5wbqudiQT21cduMN yA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwf6c8v1f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 May 2022 08:42:48 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 24B8feJS038344; Wed, 11 May 2022 08:42:47 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id
 3fwf7abaj1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 May 2022 08:42:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=blFQ++BRp41wW18cSmAkgkIU1mlw1TeMiYKvLkJUCjTyCuUYoM9qb3OhZ+YMVpYlR09vmMFv5l1jT3iVIWzFHbdRAlhcDsAMHwVOkblHevSBBqwrpanagDqlWlpFhM/KMHzKjPY7x16k05S/aVwGZynndlI8+5SWhEq2ruDhh5By3gPfeXlQv6Iif++bw4cr8RIKuxbMqfJaXj3/xhluuOm6PZMJaX/yAvUNLA+p4zSmkqtapu/SsJ1uHGcjDOenHWYWbVWwOXU/9iunEDXq+dB0BGWDuIhky2WxCDesM+vDjKK1OXOLwjxd3iUXRe+Rj0d2MKMrUl/+a+iM6vUKDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+H94JXryVrmoxymAhbIh5qtReTXuE6pNSHxsKpKlcZU=;
 b=FG70rpG8grXk0DY3bEbe3AMn6yOzuETKm+4BUMZCulh+wOrqT1HOBGq7bokgWNzxxYdYrIVLJqDwRZFz6V/UcyU0S4+GIiYDYrH5+oeHgMzMBCkYlNqvdxCmXamcjiz4Yniq4+VnS28atk+M3vMiegCl+JpGOvOkZy3L5xEAWiThCq5MxnL9VNS6jqS7eIOQcpV1Hq36thLmFd7FjAx6Lq7MfNKivSgR3oTkETjhsRtUfLjx5ZX/fT6vcxj56uKnxYbI39kLRkoAktEespRe1lK2mDZzgqAnEHRntjczfmNOdpkV1kCBjnoX/8eP7crBCYgkbXOMxnrocr+moIFPeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+H94JXryVrmoxymAhbIh5qtReTXuE6pNSHxsKpKlcZU=;
 b=CwTZzCsQ+XMnWSsukXoJhT2JwH38vMCLfYWY/Za4VY1NxaM+J2tdxsd7XvPgCoyuCSSYz/bWOCTxIFxKraqR11FEG2FQjUdbdsUgp6ZxnZpAKwKrhmr61SKPdBu4lmRsk1TD+avBdaPASPpE0ULD/UINzydThFVgcG5vAR3tn0I=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM5PR10MB1307.namprd10.prod.outlook.com
 (2603:10b6:3:e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Wed, 11 May
 2022 08:42:45 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba%5]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 08:42:45 +0000
Date: Wed, 11 May 2022 11:42:22 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH 1/4] iommu/mediatek: Use dev_err_probe to mute
 probe_defer err log
Message-ID: <20220511084222.GO4031@kadam>
References: <20220511064920.18455-1-yong.wu@mediatek.com>
 <20220511064920.18455-2-yong.wu@mediatek.com>
Content-Disposition: inline
In-Reply-To: <20220511064920.18455-2-yong.wu@mediatek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0027.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::15)
 To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fee73698-11ea-42a2-057b-08da332a385a
X-MS-TrafficTypeDiagnostic: DM5PR10MB1307:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB1307179D7A975196D91424E08EC89@DM5PR10MB1307.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yr5450Cynk2CzefImtmCVCO5QKxgSWFY4/EDxMWxCn1go7XdYjbpFtCSzN1BZdGUDGZUYAwb77x7ag+UVIhS3LtTSoVLDI12xnwNuRzwanonsACe3Xb9kl17F3PM7vhm2SCM++0jfLMT4Bq5Qysd8DgbmAN9/9K1m1/S+KYZ9mnNLhMY+lopzimAkvLLVuf7mCOvfAkRDhPFSwZv+YVrdSMoz0RpljlVYtwWHu0HokODs+ekvW990M4wVcJJz3NZPMVf0xIq/YeWN+1m3dO5EF85pPqGaEzzg0ue5lG7n7YjCQXGvZdkDHr7cw/w0N/V+MdVzwCLNDlHaT+XH9eRE1SpYPL2d6FA9mKCFuZaz/YOIyTxjFH0w2/EJeia6kPR0ltwJjQAbOMT/2IEwmHdsZuRySRwbWSBnkSQNf535RvNRG6g37+EFC7mpRwugcBEARkECPhqYMe5N3+TVRTYhYFx65DF1NH42OGu03+twvrSjdyoeTbnUZuEIUdygfGDziXs4ebS2cFhZPKIAQ+WZRoSn9djgPhlGwJ1WTF3SH0/1ibBvxv81scKbB0817Rj98blJBRgQWGCQI5rawiaT/9PtfedMZWoxCbRWvgR2LP9QxH1vOOdSueXHTNLjnFPMhFXtO4Rja4eNY/1RcIZZ+VLMSWuLaqFwyC6syxOsetaH48x3npAxNtAEL0MZ0h/tvLNp6lqr22a21AXyaZxAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(7916004)(366004)(66946007)(66476007)(66556008)(54906003)(8676002)(6916009)(2906002)(6486002)(86362001)(508600001)(38100700002)(38350700002)(316002)(8936002)(6512007)(4326008)(5660300002)(44832011)(33716001)(1076003)(7416002)(9686003)(4744005)(26005)(186003)(6666004)(33656002)(6506007)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2qCRrVDEaHmynhJmsPysCQUxVSl/oFLJ6fOyiC9+WO/SxfyRwZ0MsJMNj90c?=
 =?us-ascii?Q?+QCbPAkd5iG053WmI2eO9wl7FDnNY5fC5YxTTm2UL86t1uNbUbAqd0fPO/XD?=
 =?us-ascii?Q?Y1y4UeJ00mk1edLoeZgh9xM9v3Ad3zXoECZ17toSHx8PgmNfG8GO3jpZxPss?=
 =?us-ascii?Q?3jd2/jsLTUcfp8d3Ab+erDQVM7JONMpUCv8lCZfi+ZsKo6wp5Ioy4N5OztV4?=
 =?us-ascii?Q?fzAjFheDmRGtbtUoxLIT+SwW7UhzUSlqmbwVMH6VpBwtcPCU530Z4ZgnxwSX?=
 =?us-ascii?Q?K5T1mtlYKMq8SGyFUipFjC03AwlCMCYPbLGg0+MGSCScoj9p4FnklzUfXmuv?=
 =?us-ascii?Q?aVH0gXcg86SANhWN358GG6i1q5bEGIjioqzJRBQXVchdLOhjsDhvSI/aLjLb?=
 =?us-ascii?Q?lEZ6IOhFdxSW0yM4XLASMLenYPVTunQYp0YgSdqYVJXWVwkNNMzoMV3usggL?=
 =?us-ascii?Q?0+eRsKw7BOhW8IChGILd1LfpK7G7h6wxjy7r0px0rTxuLm9jLMvZ0saQEpSO?=
 =?us-ascii?Q?+aWaTw+o/tyrZi7YQw80SchacIE7CvGI4stlWN56ya/kN1YmVo5vJLqZsoMM?=
 =?us-ascii?Q?b2P7aRo1w4RJP4VbG+fQqghcRGAKMlzSpUedFTnF48d4fakQfvEuw/t8fHT3?=
 =?us-ascii?Q?+bGouUhsracuiBFBsAO+mv1jJuXQ9FPI4MVB9+oZHtRSP4IJkq0Y77DRE2xC?=
 =?us-ascii?Q?UdhTPvNkCzVJr1utThmWSG0xlGlGhs83cyQm9uSS7ZDIWifqiCTaVeD2uZpe?=
 =?us-ascii?Q?h6hwPezNVTk8jb7ibckOIPA8OO4VycNu2k59l/L65jhmEpfmiiXhR5Zo+tlY?=
 =?us-ascii?Q?N1Y5zVcVpbu5lg9AWu9RnQokMwMKsRC+t2HIvw4+YNOSpiVw0nvs7En8mmju?=
 =?us-ascii?Q?TVJ/dFfML31vd5dX3deAtmzuuUrUZKzLn91JEnj631KYSeFTYRE9tuBQ/UOg?=
 =?us-ascii?Q?aSNhtlMWApuID8DKDrtmXeuU/RJ+aldOT6+ityXqsYcxkgVFlNXi+Ze3rI4B?=
 =?us-ascii?Q?g8uNg/8x7a2GsdGZrnN9cVROzxpGUgJIhSGTw/ny5ymkNKgxYEhpvYh0bwo8?=
 =?us-ascii?Q?rraYnCGg7v/zcw+fDVMaIMTQx8A1tKg94PW3H8JUjxcNuqnWuwfYd6ZvQS80?=
 =?us-ascii?Q?Ar58L84durAFbVEc9Bt5jXV+y5jx9IPYr6eQcb+ROiAx3KTp6E99tAtVkP0l?=
 =?us-ascii?Q?eorMilxdsKVBzsB0zISuGuGIuO+MxE1nJBVyZK30clqhlyoOdClAJmxd8fBG?=
 =?us-ascii?Q?K3lGJTSAycxNfSSuYZeWwrXazz08F6PA1QGbV/6vcCqJZUWUzeMbIPVS5pVC?=
 =?us-ascii?Q?k2/eI4rYQGIgE8MsIYDGRKbx87/BIbubTFKbRODiHYM0xKcCqvf5jAbLSGdP?=
 =?us-ascii?Q?iv2MnbpYqBKkHzrWHg5soywBi3PPsfhyCq0yzyIbszRQJwthUnuB55Vl4HxS?=
 =?us-ascii?Q?bl89yH1JmeE55UHvlTNJiEJ4UIdrVIjrACU+Trhfe2zzhRk01L8x/HqENZ5M?=
 =?us-ascii?Q?9+FXLSQ+bwbbUTk8dCCtWiSv30SKFZ09M0c8MVMt64KJHK9h1vIGHbH2S/EX?=
 =?us-ascii?Q?m4PUNW+JYUk/u8WMd/VDZK/48rXUQo6egtF6JBQ1/XVoNOBug8BhxUDInPlt?=
 =?us-ascii?Q?mLsk6HK1mi7oVO9reqRzYUpRe0Xgnb4rjD6HiN55axwwX1Uip/cJETQNFEU0?=
 =?us-ascii?Q?0oFFSID8kOVj9y3xTo6O1qt0vl0Mt4a2PVIKn9AP8zkQqSw/8Keg45pX6a5h?=
 =?us-ascii?Q?xEB4ITSrvnDp+7OJ/ufwHW+59zF95jM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fee73698-11ea-42a2-057b-08da332a385a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 08:42:45.8100 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eD9NSfofSwsv9eN4hUmGnZoSsmtVnxhOgQTnI6tG7yK7V7uv/SjE9im7aOr7anlV+J4LRiqE5nxbvRMSu3g8dpmGIgWb2P/rN5ULVQHNJ/U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1307
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486, 18.0.858
 definitions=2022-05-11_02:2022-05-09,
 2022-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=855
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110038
X-Proofpoint-ORIG-GUID: -TNIp_WMlBaQIRmep4cyp2vyXxmy8w-q
X-Proofpoint-GUID: -TNIp_WMlBaQIRmep4cyp2vyXxmy8w-q
Cc: anan.sun@mediatek.com, chengci.xu@mediatek.com, xueqi.zhang@mediatek.com,
 linux-kernel@vger.kernel.org, libo.kang@mediatek.com, yf.wang@mediatek.com,
 Guenter Roeck <groeck@chromium.org>, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 Will Deacon <will@kernel.org>, mingyuan.ma@mediatek.com,
 linux-arm-kernel@lists.infradead.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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

On Wed, May 11, 2022 at 02:49:17PM +0800, Yong Wu wrote:
> Fixes: d2e9a1102cfc ("iommu/mediatek: Contain MM IOMMU flow with the MM TYPE")
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
> The Fixes tag commit-id is from linux-next.

This is fine.  The commit hash will not change unless the maintainer
rebases the tree.

When maintainers rebase their trees it's their responsibility to deal
with the Fixes tags.  Often they just fold the fix into the original
commit so the issue is moot.  Stephen Rothwell checks that Fixes tags
point to a valid commit and there are probably other people who have
checks for that as well.

regards,
dan carpenter

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
