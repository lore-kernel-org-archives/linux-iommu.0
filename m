Return-Path: <SRS0=UfkB=G5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB8DC433E0
	for <iommu@archiver.kernel.org>; Tue, 26 Jan 2021 15:52:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9B712083E
	for <iommu@archiver.kernel.org>; Tue, 26 Jan 2021 15:52:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9B712083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5041F8674D;
	Tue, 26 Jan 2021 15:52:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2uY00VouS0Q9; Tue, 26 Jan 2021 15:52:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C3EED86738;
	Tue, 26 Jan 2021 15:52:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A5229C08A1;
	Tue, 26 Jan 2021 15:52:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C8869C013A
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 15:52:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C20A886749
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 15:52:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HdTEuF-LnsQX for <iommu@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 15:52:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 0FF0D86738
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 15:52:49 +0000 (UTC)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10QFn8f6131472;
 Tue, 26 Jan 2021 15:52:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=MkGBfj82lgrMngHyk0zsflelGEwEAxlsidVGeHdsrnY=;
 b=cYowfipK8FTHdyw2WCRnUEhT2ITmoID2IIZ7GAihR6aXw4Aby+/WKlrojb1TX5oJOlZr
 /PH/1f2fQ8dLOcR5mV3yqQoEXjG/S/epHHQCTQ4Xq+WmGJeLa38mtlNagN2+wI6S5UyI
 QXIYe22suH2i+buY1wbKEi4qJoJabIIG2+E7Hju8iJB0E1YLYUwu9eLCg1J/43qw1yB7
 /C2OgppLJlJOG7kpn3FcjHNOSvBvg45jhcLgTN7WUuvj8Lqq49qt+qayjs+KWVVvIJvt
 Eix6A/+qSHOvjmdsNCCtgy+zEzmZT1CCIAx+rajcHfcKCH6jB6Co3FQUT+AN+kjhbWAU uw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2130.oracle.com with ESMTP id 3689aajv02-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Jan 2021 15:52:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10QFk6St091010;
 Tue, 26 Jan 2021 15:52:38 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
 by userp3030.oracle.com with ESMTP id 368wqwjw30-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Jan 2021 15:52:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkjGuA4/6srbf8r/gOYbmddUzJ3ynjhURyHKLZD9/2/QR2f3DsiDwFNtCy9OkQ0HNYyWswNZJdc38u/GGr36GcW3R5/eeoH35vxZm0o1F2Eu/K+ZNCrYBxZZ+9jxBWQe3yTd0Iv9N7S6jGqGxZeoy7cXvuT70DrEV7HeyqXg83x60JoUOOpq3iOenbk5uAXHpPQOb23zDX98gs0Dtu7zZ0uajxs8SB3zA5LA5qeHc8MRRVPgusj7c4EENb+tPTqrNKYpKLzljR8SNnae1F2UhIfbIUk6AMHhqJVATVc5FWYntqXGzv420dmimO86KJWpX9zep7XwSwCfJuNwJqyybw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MkGBfj82lgrMngHyk0zsflelGEwEAxlsidVGeHdsrnY=;
 b=LVkNP54kbp1/9o0eqOHN9MjcOC1pJD+ZFnD9CIB1i4zoGuoyC0QNEFHFqtROfZ30eKsz0DPOavspIssKAWIAiWbMATxMXPrbodM6r7/hiy53CbBnLnSe/9dpxwTsm+ZSROMQN7VAL8g9mZdMxIPZE3EsO81aSIHYUVpwcCWntBAfp0phlQRiOZdpTaBvp3mUwxx8J46yM2F+13VlJuxvRIRzw7qObjFQYj9hcDUolOlIHBrFRtdI/qOX8qsPf1MhyiCr+LA1lRnQsDbxlJAMJQzkEB9eafapaIYB2fnOPmDEoV0kXY/XnG55jA7PUptwhtjwfKK5uJ1GNVKr8dLOVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MkGBfj82lgrMngHyk0zsflelGEwEAxlsidVGeHdsrnY=;
 b=Ioe1qKq2BTzNMdB0tvIpfZiZVftjk11pDUCWqUJA+OrszPztL5S5OkshuTs0ww/jdNeoK/9oF6vIeoXIJxfHIzirfZrwaZnJZwJ0txumuXkbf0BXCPR+18uMsWiVJHy9gtwpoJLTix5yj8YV+nFpP/xYh/+oy/JqrTbdWZPsbCA=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4510.namprd10.prod.outlook.com (2603:10b6:a03:2d6::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.16; Tue, 26 Jan
 2021 15:52:36 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3784.019; Tue, 26 Jan 2021
 15:52:36 +0000
From: Chuck Lever <chuck.lever@oracle.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [RFT PATCH 0/3] Performance regression noted in v5.11-rc after
 c062db039f40
Thread-Topic: [RFT PATCH 0/3] Performance regression noted in v5.11-rc after
 c062db039f40
Thread-Index: AQHW8sRzvAsRgI4bIEGwtoU2eSt8tao4nH8AgAAfcwCAALSugIAAoF6A
Date: Tue, 26 Jan 2021 15:52:36 +0000
Message-ID: <C70D7EE4-C84C-421C-818A-F13403E99B33@oracle.com>
References: <20210125023858.570175-1-baolu.lu@linux.intel.com>
 <BDAEAC42-15F2-4C75-A28C-8E580F0CFF01@oracle.com>
 <83EE54C6-F654-4D1D-92F7-F442ACEC8D70@oracle.com>
 <7937bfa5-5cb9-0a23-176c-e91e5e9ac962@linux.intel.com>
In-Reply-To: <7937bfa5-5cb9-0a23-176c-e91e5e9ac962@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none; linux.intel.com; dmarc=none action=none header.from=oracle.com; 
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 52232d70-47d3-4cab-4b79-08d8c21266e5
x-ms-traffictypediagnostic: SJ0PR10MB4510:
x-microsoft-antispam-prvs: <SJ0PR10MB4510E0CFF84A776857E59B2693BC9@SJ0PR10MB4510.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SYs0SmviN0vYUD6Unht835a1JPF0+Dw2B+dZUvaN1E+RWdipELTQVnq8R3Gyk53inoNxvwhTrOCNqRg4LlPUYP+WVqS1gmK4d30sss7wzesit2OL4yymujXVhdY5vUFhND+9stpNw2WY0K72BCY9AFo3WefleOkvpt8h4On1sqUaBfeDuu4WOw68u0lg5hwI5gl0tuINlP8kpQyoB5KD6sm6Airk6B8AsoeauecXUUfMLuk2ihlrWVbVyqRjE2hNF2LJWBbRcsFyof2vEpluftCy1+0qwjjetetY1+a1RU1abU0eSumUYJzDzd2IYcxowgrxYHAqtZpy7+CUU7Ba09l50H0C41Wpl5rGU6otaeY9hEfRhw1Ck+KNHxHe2HR9RiPxydK9pcCZ2lcggqkybmrt8+sd/Fsp7sUsijM0D2yCVveRT85wNiXzKp5TmbxtqmCQHM26AwChwtfxjOU5HJ9ZC8/20muowxpa/C4RFYhnSQKduNQK2rx/ced7c+S4gfyrKkcdCZb6+LgVMw5vKoDhb6d+JSI47JBKkqoUpus=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB4688.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(346002)(376002)(39860400002)(396003)(366004)(2906002)(2616005)(71200400001)(30864003)(66946007)(76116006)(54906003)(8936002)(478600001)(83380400001)(966005)(26005)(6486002)(8676002)(6506007)(33656002)(186003)(66446008)(44832011)(86362001)(4326008)(53546011)(6512007)(6916009)(66556008)(316002)(5660300002)(64756008)(36756003)(91956017)(66476007)(98903001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?CszDb3fAd8eZg7HjwFeyM+vfCSH4BCDiUQ35hZInegCGcGIDOvLI/1cKg4MK?=
 =?us-ascii?Q?Y8+1SUa9PO+U20OE9q4dnVikeHigCS8PSAmjmiR4fCZzlvhoFfqhmho/8tfv?=
 =?us-ascii?Q?my2vT9pnYx/oEbD0k5CYOZGlQ1ipKLxl7fvVUMB1Grrw1U2N6nsQlXs0Myx0?=
 =?us-ascii?Q?J4qpL44Jf7X2HK3mdAuXoCWU8h/cjBm6ZpbbeP0/QJEVJ6/NDm9LPTIUCcSG?=
 =?us-ascii?Q?b6cK+U8ibG1nGwAmPRCOXTBWxvLszgnqD0+rBFEmKMhLwdgymNLYZK9Afu8O?=
 =?us-ascii?Q?1AJlH75aZplFVUwckGLhmlymDinaE7HiXMvWbyGranG9X4+c/L3Z8C20R4aD?=
 =?us-ascii?Q?IVBgpSdrKvpL+EPovbCHTHCP/2jod1S12g4R55jCQ68s2km9huYh+Q4AyreJ?=
 =?us-ascii?Q?N8xwpZQvW4iOGg8AzRPdtVkddP73gYAQxmjulRTiOQ/3PIj+JPGu4SvDZsUI?=
 =?us-ascii?Q?iqeR9k9A5DolGvOKEJKbORfxCEL4fFMTGC/z2UHsSebfKrhHZlZxxQjVwJSr?=
 =?us-ascii?Q?FTYwMv6wqlXOd8hYgNCxHaN2faB7jMiNQzz2s7Gtko5NRnWoodv+UNjyRju4?=
 =?us-ascii?Q?ZMmoV+x16NZ2NYoN2TpP7AvwxjidZFAbLbxGywIlRNLyBDrbPWM1b8SbnKVA?=
 =?us-ascii?Q?BMc46AK1w8TI6RQOxhLAAQkdo4iUH8iS8+5+v300yzXxc8EE2qEKp5Hujhq9?=
 =?us-ascii?Q?eerHWBV1IjLJYRofDmZKWEskjVVSzgbl+izq4lGhMvUt6SpjPGFaU9Il8/xj?=
 =?us-ascii?Q?GL2le3Poty3NpYonxCHOaZbnn+elGZcZ58ZvwBbevtA3fe4WwaHpqgs3K2zr?=
 =?us-ascii?Q?Ro0fEaeFJJXF6huOGkwrEW0V03eu7wnYiIf6eL62WaLxcJ4rEEPw7DzBl+9Z?=
 =?us-ascii?Q?JBbKJFT9tx7xPctb58gi70LnBey0AR5acFHks13bF8p2A71qUJHuJg5XjShG?=
 =?us-ascii?Q?/3Rxe83en3+8NvJyIipgrfCuRVnvXCvG1XzcFtUrBvpXe1cVcb34sujg9Hzj?=
 =?us-ascii?Q?TalF9aahT3MX8Zu3pRi1nkpnP6UT1CFomYFitZa2qabfxmBvVU6t80ZlMPGp?=
 =?us-ascii?Q?4eyque/wJzlSs8hNtuVWvDUzTG8yhw=3D=3D?=
x-ms-exchange-transport-forked: True
Content-ID: <29535FC3926DB446B041CD7769122DCB@namprd10.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52232d70-47d3-4cab-4b79-08d8c21266e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2021 15:52:36.3432 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +QyeArX+KM3dEdYp8y6+MPH1DTqXN/SvPf0cqa6YBafAid9EWo7iD0RXiWSfzsvIr0Sd+cNt75ORPlzbjlmSMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4510
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9876
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101260085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9876
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101260085
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



> On Jan 26, 2021, at 1:18 AM, Lu Baolu <baolu.lu@linux.intel.com> wrote:
> 
> On 2021/1/26 3:31, Chuck Lever wrote:
>>> On Jan 25, 2021, at 12:39 PM, Chuck Lever <chuck.lever@oracle.com> wrote:
>>> 
>>> Hello Lu -
>>> 
>>> Many thanks for your prototype.
>>> 
>>> 
>>>> On Jan 24, 2021, at 9:38 PM, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>>> 
>>>> This patch series is only for Request-For-Testing purpose. It aims to
>>>> fix the performance regression reported here.
>>>> 
>>>> https://lore.kernel.org/linux-iommu/D81314ED-5673-44A6-B597-090E3CB83EB0@oracle.com/
>>>> 
>>>> The first two patches are borrowed from here.
>>>> 
>>>> https://lore.kernel.org/linux-iommu/20210107122909.16317-1-yong.wu@mediatek.com/
>>>> 
>>>> Please kindly help to verification.
>>>> 
>>>> Best regards,
>>>> baolu
>>>> 
>>>> Lu Baolu (1):
>>>> iommu/vt-d: Add iotlb_sync_map callback
>>>> 
>>>> Yong Wu (2):
>>>> iommu: Move iotlb_sync_map out from __iommu_map
>>>> iommu: Add iova and size as parameters in iotlb_sync_map
>>>> 
>>>> drivers/iommu/intel/iommu.c | 86 +++++++++++++++++++++++++------------
>>>> drivers/iommu/iommu.c       | 23 +++++++---
>>>> drivers/iommu/tegra-gart.c  |  7 ++-
>>>> include/linux/iommu.h       |  3 +-
>>>> 4 files changed, 83 insertions(+), 36 deletions(-)
>>> 
>>> Here are results with the NFS client at stock v5.11-rc5 and the
>>> NFS server at v5.10, showing the regression I reported earlier.
>>> 
>>> 	Children see throughput for 12 initial writers  = 4534582.00 kB/sec
>>> 	Parent sees throughput for 12 initial writers   = 4458145.56 kB/sec
>>> 	Min throughput per process                      = 373101.59 kB/sec
>>> 	Max throughput per process                      = 382669.50 kB/sec
>>> 	Avg throughput per process                      = 377881.83 kB/sec
>>> 	Min xfer                                        = 1022720.00 kB
>>> 	CPU Utilization: Wall time    2.787    CPU time    1.922    CPU utilization  68.95 %
>>> 
>>> 
>>> 	Children see throughput for 12 rewriters        = 4542003.12 kB/sec
>>> 	Parent sees throughput for 12 rewriters         = 4538024.19 kB/sec
>>> 	Min throughput per process                      = 374672.00 kB/sec
>>> 	Max throughput per process                      = 383983.78 kB/sec
>>> 	Avg throughput per process                      = 378500.26 kB/sec
>>> 	Min xfer                                        = 1022976.00 kB
>>> 	CPU utilization: Wall time    2.733    CPU time    1.947    CPU utilization  71.25 %
>>> 
>>> 
>>> 	Children see throughput for 12 readers          = 4568632.03 kB/sec
>>> 	Parent sees throughput for 12 readers           = 4563672.02 kB/sec
>>> 	Min throughput per process                      = 376727.56 kB/sec
>>> 	Max throughput per process                      = 383783.91 kB/sec
>>> 	Avg throughput per process                      = 380719.34 kB/sec
>>> 	Min xfer                                        = 1029376.00 kB
>>> 	CPU utilization: Wall time    2.733    CPU time    1.898    CPU utilization  69.46 %
>>> 
>>> 
>>> 	Children see throughput for 12 re-readers       = 4610702.78 kB/sec
>>> 	Parent sees throughput for 12 re-readers        = 4606135.66 kB/sec
>>> 	Min throughput per process                      = 381532.78 kB/sec
>>> 	Max throughput per process                      = 387072.53 kB/sec
>>> 	Avg throughput per process                      = 384225.23 kB/sec
>>> 	Min xfer                                        = 1034496.00 kB
>>> 	CPU utilization: Wall time    2.711    CPU time    1.910    CPU utilization  70.45 %
>>> 
>>> Here's the NFS client at v5.11-rc5 with your series applied.
>>> The NFS server remains at v5.10:
>>> 
>>> 	Children see throughput for 12 initial writers  = 4434778.81 kB/sec
>>> 	Parent sees throughput for 12 initial writers   = 4408190.69 kB/sec
>>> 	Min throughput per process                      = 367865.28 kB/sec
>>> 	Max throughput per process                      = 371134.38 kB/sec
>>> 	Avg throughput per process                      = 369564.90 kB/sec
>>> 	Min xfer                                        = 1039360.00 kB
>>> 	CPU Utilization: Wall time    2.842    CPU time    1.904    CPU utilization  66.99 %
>>> 
>>> 
>>> 	Children see throughput for 12 rewriters        = 4476870.69 kB/sec
>>> 	Parent sees throughput for 12 rewriters         = 4471701.48 kB/sec
>>> 	Min throughput per process                      = 370985.34 kB/sec
>>> 	Max throughput per process                      = 374752.28 kB/sec
>>> 	Avg throughput per process                      = 373072.56 kB/sec
>>> 	Min xfer                                        = 1038592.00 kB
>>> 	CPU utilization: Wall time    2.801    CPU time    1.902    CPU utilization  67.91 %
>>> 
>>> 
>>> 	Children see throughput for 12 readers          = 5865268.88 kB/sec
>>> 	Parent sees throughput for 12 readers           = 5854519.73 kB/sec
>>> 	Min throughput per process                      = 487766.81 kB/sec
>>> 	Max throughput per process                      = 489623.88 kB/sec
>>> 	Avg throughput per process                      = 488772.41 kB/sec
>>> 	Min xfer                                        = 1044736.00 kB
>>> 	CPU utilization: Wall time    2.144    CPU time    1.895    CPU utilization  88.41 %
>>> 
>>> 
>>> 	Children see throughput for 12 re-readers       = 5847438.62 kB/sec
>>> 	Parent sees throughput for 12 re-readers        = 5839292.18 kB/sec
>>> 	Min throughput per process                      = 485835.03 kB/sec
>>> 	Max throughput per process                      = 488702.12 kB/sec
>>> 	Avg throughput per process                      = 487286.55 kB/sec
>>> 	Min xfer                                        = 1042688.00 kB
>>> 	CPU utilization: Wall time    2.148    CPU time    1.909    CPU utilization  88.84 %
>>> 
>>> NFS READ throughput is almost fully restored. A normal-looking throughput
>>> result, copied from the previous thread, is:
>>> 
>>> 	Children see throughput for 12 readers 		= 5921370.94 kB/sec
>>> 	Parent sees throughput for 12 readers 		= 5914106.69 kB/sec
>>> 
>>> The NFS WRITE throughput result appears to be unchanged, or slightly
>>> worse than before. I don't have an explanation for this result. I applied
>>> your patches on the NFS server also without noting improvement.
>> Function-boundary tracing shows some interesting results.
>> # trace-cmd record -e rpcrdma -e iommu -p function_graph --max-graph-depth=5 -g dma_map_sg_attrs
>> Some 120KB SGLs are DMA-mapped in a single call to __iommu_map(). Other SGLs of
>> the same size need as many as one __iommu_map() call per SGL element (which
>> would be 30 for a 120KB SGL).
>> In v5.10, intel_map_sg() was structured such that an SGL is always handled with
>> a single call to domain_mapping() and thus always just a single TLB flush.
>> My amateur theorizing suggests that the SGL element coalescing done in
>> __iommu_map_sg() is not working as well as intel_map_sg() used to, which results
>> in more calls to domain_mapping(). Not only does that take longer, but it creates
>> many more DMA maps. Could that also have some impact on device TLB resources?
> 
> It seems that more domain_mapping() calls are not caused by
> __iommu_map_sg() but __iommu_map().
> 
> Can you please test below changes? It call intel_iommu_map() directly
> instead of __iommu_map().
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index f5a236e63ded..660d5744a117 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4916,7 +4916,7 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
> }
> #endif
> 
> -static int intel_iommu_map(struct iommu_domain *domain,
> +int intel_iommu_map(struct iommu_domain *domain,
>                           unsigned long iova, phys_addr_t hpa,
>                           size_t size, int iommu_prot, gfp_t gfp)
> {
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 3d099a31ddca..a1b41fd3fb4e 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -23,8 +23,13 @@
> #include <linux/property.h>
> #include <linux/fsl/mc.h>
> #include <linux/module.h>
> +#include <linux/intel-iommu.h>
> #include <trace/events/iommu.h>
> 
> +extern int intel_iommu_map(struct iommu_domain *domain,
> +                          unsigned long iova, phys_addr_t hpa,
> +                          size_t size, int iommu_prot, gfp_t gfp);
> +
> static struct kset *iommu_group_kset;
> static DEFINE_IDA(iommu_group_ida);
> 
> @@ -2553,8 +2558,7 @@ static size_t __iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
>                phys_addr_t s_phys = sg_phys(sg);
> 
>                if (len && s_phys != start + len) {
> -                       ret = __iommu_map(domain, iova + mapped, start,
> -                                       len, prot, gfp);
> +                       ret = intel_iommu_map(domain, iova + mapped, start, len, prot, gfp);
> 
>                        if (ret)
>                                goto out_err;
> 
> Does it change anything?

I removed yesterday's 3-patch series, and applied the above.
Not a full restoration, but interesting nonetheless.

	Children see throughput for 12 initial writers 	= 4852657.22 kB/sec
	Parent sees throughput for 12 initial writers 	= 4826730.38 kB/sec
	Min throughput per process 			=  403196.09 kB/sec 
	Max throughput per process 			=  406071.47 kB/sec
	Avg throughput per process 			=  404388.10 kB/sec
	Min xfer 					= 1041408.00 kB
	CPU Utilization: Wall time    2.596    CPU time    2.047    CPU utilization  78.84 %


	Children see throughput for 12 rewriters 	= 4853900.22 kB/sec
	Parent sees throughput for 12 rewriters 	= 4848623.31 kB/sec
	Min throughput per process 			=  403380.81 kB/sec 
	Max throughput per process 			=  405478.53 kB/sec
	Avg throughput per process 			=  404491.68 kB/sec
	Min xfer 					= 1042944.00 kB
	CPU utilization: Wall time    2.589    CPU time    2.048    CPU utilization  79.12 %


	Children see throughput for 12 readers 		= 4938124.12 kB/sec
	Parent sees throughput for 12 readers 		= 4932862.08 kB/sec
	Min throughput per process 			=  408768.81 kB/sec 
	Max throughput per process 			=  413879.25 kB/sec
	Avg throughput per process 			=  411510.34 kB/sec
	Min xfer 					= 1036800.00 kB
	CPU utilization: Wall time    2.536    CPU time    1.906    CPU utilization  75.16 %


	Children see throughput for 12 re-readers 	= 4992115.16 kB/sec
	Parent sees throughput for 12 re-readers 	= 4986102.07 kB/sec
	Min throughput per process 			=  411103.00 kB/sec 
	Max throughput per process 			=  420302.97 kB/sec
	Avg throughput per process 			=  416009.60 kB/sec
	Min xfer 					= 1025792.00 kB
	CPU utilization: Wall time    2.497    CPU time    1.887    CPU utilization  75.57 %

NFS WRITE throughput improves significantly. NFS READ throughput
improves somewhat, but not to the degree it did with yesterday's
patch series.

function_graph shows a single intel_iommu_map() is used more
frequently, but the following happens on occasion:

395.678889: funcgraph_entry:                   |  dma_map_sg_attrs() {
395.678889: funcgraph_entry:                   |    iommu_dma_map_sg() {
395.678890: funcgraph_entry:        0.257 us   |      iommu_get_dma_domain();
395.678890: funcgraph_entry:        0.255 us   |      iommu_dma_deferred_attach();
395.678891: funcgraph_entry:                   |      iommu_dma_sync_sg_for_device() {
395.678891: funcgraph_entry:        0.253 us   |        dev_is_untrusted();
395.678891: funcgraph_exit:         0.773 us   |      }
395.678892: funcgraph_entry:        0.250 us   |      dev_is_untrusted();
395.678893: funcgraph_entry:                   |      iommu_dma_alloc_iova() {
395.678893: funcgraph_entry:                   |        alloc_iova_fast() {
395.678893: funcgraph_entry:        0.255 us   |          _raw_spin_lock_irqsave();
395.678894: funcgraph_entry:        0.375 us   |          __lock_text_start();
395.678894: funcgraph_exit:         1.435 us   |        }
395.678895: funcgraph_exit:         2.002 us   |      }
395.678895: funcgraph_entry:        0.252 us   |      dma_info_to_prot();
395.678895: funcgraph_entry:                   |      iommu_map_sg_atomic() {
395.678896: funcgraph_entry:                   |        __iommu_map_sg() {
395.678896: funcgraph_entry:        1.675 us   |          intel_iommu_map();
395.678898: funcgraph_entry:        1.365 us   |          intel_iommu_map();
395.678900: funcgraph_entry:        1.373 us   |          intel_iommu_map();
395.678901: funcgraph_entry:        1.378 us   |          intel_iommu_map();
395.678903: funcgraph_entry:        1.380 us   |          intel_iommu_map();
395.678905: funcgraph_entry:        1.380 us   |          intel_iommu_map();
395.678906: funcgraph_entry:        1.378 us   |          intel_iommu_map();
395.678908: funcgraph_entry:        1.380 us   |          intel_iommu_map();
395.678910: funcgraph_entry:        1.345 us   |          intel_iommu_map();
395.678911: funcgraph_entry:        1.342 us   |          intel_iommu_map();
395.678913: funcgraph_entry:        1.342 us   |          intel_iommu_map();
395.678915: funcgraph_entry:        1.395 us   |          intel_iommu_map();
395.678916: funcgraph_entry:        1.343 us   |          intel_iommu_map();
395.678918: funcgraph_entry:        1.350 us   |          intel_iommu_map();
395.678920: funcgraph_entry:        1.395 us   |          intel_iommu_map();
395.678921: funcgraph_entry:        1.342 us   |          intel_iommu_map();
395.678923: funcgraph_entry:        1.350 us   |          intel_iommu_map();
395.678924: funcgraph_entry:        1.345 us   |          intel_iommu_map();
395.678926: funcgraph_entry:        1.345 us   |          intel_iommu_map();
395.678928: funcgraph_entry:        1.340 us   |          intel_iommu_map();
395.678929: funcgraph_entry:        1.342 us   |          intel_iommu_map();
395.678931: funcgraph_entry:        1.335 us   |          intel_iommu_map();
395.678933: funcgraph_entry:        1.345 us   |          intel_iommu_map();
395.678934: funcgraph_entry:        1.337 us   |          intel_iommu_map();
395.678936: funcgraph_entry:        1.305 us   |          intel_iommu_map();
395.678938: funcgraph_entry:        1.380 us   |          intel_iommu_map();
395.678939: funcgraph_entry:        1.365 us   |          intel_iommu_map();
395.678941: funcgraph_entry:        1.370 us   |          intel_iommu_map();
395.678943: funcgraph_entry:        1.365 us   |          intel_iommu_map();
395.678945: funcgraph_entry:        1.482 us   |          intel_iommu_map();
395.678946: funcgraph_exit:       + 50.753 us  |        }
395.678947: funcgraph_exit:       + 51.348 us  |      }
395.678947: funcgraph_exit:       + 57.975 us  |    }
395.678948: funcgraph_exit:       + 58.700 us  |  }
395.678953: xprtrdma_mr_map:      task:64127@5 mr.id=104 nents=30 122880@0xc5e467fde9380000:0xc0011103 (TO_DEVICE)
395.678953: xprtrdma_chunk_read:  task:64127@5 pos=148 122880@0xc5e467fde9380000:0xc0011103 (more)


--
Chuck Lever



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
