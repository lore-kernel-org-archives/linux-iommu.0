Return-Path: <SRS0=KfvE=G6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92231C433E0
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 03:01:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C9572064C
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 03:01:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C9572064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BC6E9857E2;
	Wed, 27 Jan 2021 03:01:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s6Z8sQtt2uGc; Wed, 27 Jan 2021 03:01:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 52F6285722;
	Wed, 27 Jan 2021 03:01:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 37963C0FA7;
	Wed, 27 Jan 2021 03:01:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D47CC013A
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 03:01:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4F6A287098
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 03:01:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xoi6QinDU6dH for <iommu@lists.linux-foundation.org>;
 Wed, 27 Jan 2021 03:01:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 by hemlock.osuosl.org (Postfix) with ESMTPS id AB6F286FF0
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 03:01:17 +0000 (UTC)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10R30Jju098279;
 Wed, 27 Jan 2021 03:00:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=6ABED7vdHZIkUumIMHOcPHknXa7e4/F6BvVjGomEpsY=;
 b=yhUYqNbk4/Ecbjxt56Bytxl75eQbMj9vNeuuUVbiTn8GJI1ghtAe3sNLKpZHL1dChFDi
 zy888UkWdmLPHhuak7O3mYRZKJjYKKOd6hf8ChqugzWZ7zVcmgD+HHJLGzS8LB6swEPT
 kguLTasDR0TUJZ18dPV/EsXlGvSXdEzV9UDSnawq0FOFxXLdgojvMqw8+PJUnT8f5vW8
 hjyg4H0SA+7SjAIEaxjLwcRnDmm0w/gu3jIYen+TY03fU2O3RIU5SsvBFSez9ohVTQ0U
 tcnjd4nz45HHIaff4Tv8tcnJBdZYRuqHPpg0MquxOgnGbIUPK1M16fSoXW6sFrKF+ctz OQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2130.oracle.com with ESMTP id 3689aan55c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 Jan 2021 03:00:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10R2oBtx171969;
 Wed, 27 Jan 2021 02:58:29 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
 by userp3030.oracle.com with ESMTP id 368wqx8g2p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 Jan 2021 02:58:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YVxU5jpAUpN1587zTgCHbtzUcDn+6WBDHkX1acA2GY8344dV494aERWll+BZDBRGZVFFHE6nsfA12aV87J40s7HkkAwvicHRD/Nl/VAFgdK0GNIkfU7iK/IMgEFB+23iC5ZgujOk8xy1G9Q+qXJXujlaJKj2UtDpg57QT327JNDxrUKcBwu1V9UK1FUgMbMg+qwEMmaZyb/a7DZL7w96vDJObK3gsJVKW0apgoVzXkVudf2ylt5kUayWIxh74ryU05g8028vz9chH8nV301Qh9MwtJMYHy16M8PmaESSYFLc1vaK3+zLKN0iMXbipAsjlJ6Q4Qsm8WPyxC+uuGdWNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ABED7vdHZIkUumIMHOcPHknXa7e4/F6BvVjGomEpsY=;
 b=lbWTrNfZlyNjIzHbFAzCyriDx8rZJ3dog/C+2N5zWu6shJIlpZW4Eqlk0TYpybHm8QZxn8KjIrYpLDGWyQS/55PQM6Sz3P8bn4P4pQQxJdDYfY1fut7rcMtdOkwYhZOM4OV5q/lg6CVmhLmKVBQRKASAQbYO9Na5iw790GIhahsBCUKtJ3LJ/rBNd75dZSjm1q2XYH4JPqyIAd7Z9BE+wQ++Fg/xuyF3KewuKDlukXrhO2fFjxUZ4gCGhPnjfmUjxNM6Fv0U2X8bf14bETYGZnxQ8q1laJDRvT7/M3uqwIw1WZZLXiD7NbKbB+BX85w3yB7ZBaCHy/7ZttfkdbPEPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ABED7vdHZIkUumIMHOcPHknXa7e4/F6BvVjGomEpsY=;
 b=ad1kcgLIND2Kw4Qea+vLuEXyqeP3qiov9Zzi300awk82P0hOVlwC8PsFMnAKLRljIhY3Kgu6r8dbYN7Ni5lfzaALwYyOaVg0eBWHIGrbDC7P4PBKbnrzhMtBwZlnw6Ghpkmg1y01bwRkUsb3L+qGbAzKpcKgrKvij4JQLE/uqP4=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4049.namprd10.prod.outlook.com (2603:10b6:a03:1b2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Wed, 27 Jan
 2021 02:58:25 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3784.019; Wed, 27 Jan 2021
 02:58:25 +0000
From: Chuck Lever <chuck.lever@oracle.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [RFT PATCH 0/3] Performance regression noted in v5.11-rc after
 c062db039f40
Thread-Topic: [RFT PATCH 0/3] Performance regression noted in v5.11-rc after
 c062db039f40
Thread-Index: AQHW8sRzvAsRgI4bIEGwtoU2eSt8tao4nH8AgAAfcwCAALSugIAAoF6AgACoB4CAABIAAA==
Date: Wed, 27 Jan 2021 02:58:25 +0000
Message-ID: <CE0D9B50-B7CA-41D1-8B34-82AEAD864D74@oracle.com>
References: <20210125023858.570175-1-baolu.lu@linux.intel.com>
 <BDAEAC42-15F2-4C75-A28C-8E580F0CFF01@oracle.com>
 <83EE54C6-F654-4D1D-92F7-F442ACEC8D70@oracle.com>
 <7937bfa5-5cb9-0a23-176c-e91e5e9ac962@linux.intel.com>
 <C70D7EE4-C84C-421C-818A-F13403E99B33@oracle.com>
 <c8bbeb07-92a8-cacf-7106-512aafe02921@linux.intel.com>
In-Reply-To: <c8bbeb07-92a8-cacf-7106-512aafe02921@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none; linux.intel.com; dmarc=none action=none header.from=oracle.com; 
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d7d8404-c7c0-475c-0e78-08d8c26f6a8a
x-ms-traffictypediagnostic: BY5PR10MB4049:
x-microsoft-antispam-prvs: <BY5PR10MB404927AAA95A02B9061465FF93BB9@BY5PR10MB4049.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1sUG7liUTQcFF2vdRYiEmVFKEbbemH5nHwivY/IzvTawCQ831FbvrRnotHwKfj8t6CzsxoC4GjT/zvSC1BkiCbDoBCoCGQNdzPKA+mi040tNQv24cfK0jpFQidT0dA3RsbGmrOt4oJb/2k4rmjqrrI3za9cPy0rUZ6AEjtpAoKH0yITFeFlKnLx7z/fLev9axiyOkWjWrW/txIuXoNmHkYKVOU0m5Wkt0Fb1hiPWuBijARbD1mTyz0dcF9FEfJdAJtVoVyxt447hRNX1dXIKT6eK3Ce4kTVFLpybNqNpwbOiCY5Ea6bREF8AJfEaXrvR/O8l/g007x/AwLLUqMdhyxvzmVd0DqsRwbhILjLHM/0VOIbteSStzAkLMBQP6MGbe1gwcWyC8qvD1HprBbgR0iZQ8OvuiD4rk2jWVKXokm67p9wDMemzBfCwAMK8nv3Hir9E7FmORh8KJ5NLkTTIt63Vd/kbVcvdf9gADqGHvhiS/y19wsikB93qGpc9BqYLki8BXgW3IvnvcEafpxn/wQNxYP6PpTPs0opNzEGdy/w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB4688.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(39860400002)(396003)(376002)(136003)(366004)(346002)(30864003)(53546011)(66556008)(71200400001)(64756008)(5660300002)(4326008)(6486002)(54906003)(26005)(6506007)(186003)(478600001)(966005)(316002)(66476007)(8936002)(66946007)(6916009)(91956017)(2906002)(83380400001)(8676002)(86362001)(36756003)(76116006)(33656002)(6512007)(44832011)(2616005)(66446008)(98903001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?aCMZoKJVB3WL4CnlVx4ZWAOy5wcl0ThdzNKknXay00FglhTkC9a+z7ET8j4w?=
 =?us-ascii?Q?CiwMZUunALysmiMknrCz692U2Pnr62du7zffAaDQtny7jEdm+/ZUqM8Gdo5n?=
 =?us-ascii?Q?xs66GprOydukMjwA2AxauTbmwXk41dvpcPANSEAKqLNRSheDlEiDwAO9uomr?=
 =?us-ascii?Q?g2w+DIExCngM1/0aNAxhP1x1Eq0bUQ4YlskIDB+ebeEY81Ck74DNEeY9p1qc?=
 =?us-ascii?Q?0k9gUwil51i2iqV/rNNPnmfgLEXAl8WDvzyKYDXGx/2+L//u3ht6dr/3xWSM?=
 =?us-ascii?Q?3d9s0jHgIadqWe+W8QrJEGqpOAgwLUXyVOCB27+4MpAfhsjbgm64/TEboocF?=
 =?us-ascii?Q?cp2qI4jr45oXkPX9pJH9vJlAuW89dFUMOHTOfIGnrZMLqCjQUzI+wnwaV/NV?=
 =?us-ascii?Q?ftarowFuLFVTeAjji3iu91vXZ4n7zEQnC96IYE9grAy8bBpPyIVHGN8KiP3b?=
 =?us-ascii?Q?L9YbhTmLQrnxAEmdJZoaUBnDkddZlZ/r34cHevXSkGF8YH+z+QsIKpbLNQrR?=
 =?us-ascii?Q?fQuPGK94X44EhSD00UU90La9Gh9QP+XmywXNKtkVsUdQBMAe8q9OcAFWHuyX?=
 =?us-ascii?Q?fnwieImD+U4qO+ItEJNvUWfLrJA1rdA94XlgUeeLvWIQ2LCdVMGOptkrvL0l?=
 =?us-ascii?Q?bwkP0z/406F8kENnaMN+oS2fOLQPHFnAfXqOLzDxe/4zATUpZdBydqxG/qeE?=
 =?us-ascii?Q?e/aeqzk6W6hNLuJMvRqJUXbqiRtZ82vh2S8ia/3+zAvRK61yh+qLkn+bY06S?=
 =?us-ascii?Q?m3ZvzvN5IDLhiRx+3BiY0Ss9b2EG5Rt4Sq1e14C54Rb3mK8n7CJABkRxJnJC?=
 =?us-ascii?Q?abx9D/eRFEqPziTRoPDwl6viQidLv7U/owjULcARey4BjmJp/KIpEHhUaBKa?=
 =?us-ascii?Q?u8YHMPNJ5+ipsbcyTChE0ekOH7tFxVCKZruMwMRWyxiMsNluBOqJDPEmQ3jv?=
 =?us-ascii?Q?A5SEKScVTgxLDW7vtjgekSNMh1o7qbpMJpR0iszBiO+6eIfYmz2CwrXpwaJh?=
 =?us-ascii?Q?0P/ZBqDJE/XT07D6YiBQAWkhysAWu2YVi76nXAAacMUvG1ImGw6fXmIrUAT+?=
 =?us-ascii?Q?pj9fsORmgEmc3UF7EzBVccniVf8BXQ=3D=3D?=
x-ms-exchange-transport-forked: True
Content-ID: <4DDD7D010B20D749ADAECD1C914F4BB1@namprd10.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d7d8404-c7c0-475c-0e78-08d8c26f6a8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2021 02:58:25.6868 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zcFJ+pF/V7lSuP10j5iOMYieFSdrdiSV1Vn5CwEoamNVaXV3x1bzhTNYd737Fo/l6GEsBNy3nftPbgJA4OBjQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4049
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9876
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101270015
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9876
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101270016
Cc: "isaacm@codeaurora.org" <isaacm@codeaurora.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Will Deacon <will@kernel.org>
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



> On Jan 26, 2021, at 8:53 PM, Lu Baolu <baolu.lu@linux.intel.com> wrote:
> 
> Hi Chuck,
> 
> On 1/26/21 11:52 PM, Chuck Lever wrote:
>>> On Jan 26, 2021, at 1:18 AM, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>> 
>>> On 2021/1/26 3:31, Chuck Lever wrote:
>>>>> On Jan 25, 2021, at 12:39 PM, Chuck Lever <chuck.lever@oracle.com> wrote:
>>>>> 
>>>>> Hello Lu -
>>>>> 
>>>>> Many thanks for your prototype.
>>>>> 
>>>>> 
>>>>>> On Jan 24, 2021, at 9:38 PM, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>>>>> 
>>>>>> This patch series is only for Request-For-Testing purpose. It aims to
>>>>>> fix the performance regression reported here.
>>>>>> 
>>>>>> https://lore.kernel.org/linux-iommu/D81314ED-5673-44A6-B597-090E3CB83EB0@oracle.com/
>>>>>> 
>>>>>> The first two patches are borrowed from here.
>>>>>> 
>>>>>> https://lore.kernel.org/linux-iommu/20210107122909.16317-1-yong.wu@mediatek.com/
>>>>>> 
>>>>>> Please kindly help to verification.
>>>>>> 
>>>>>> Best regards,
>>>>>> baolu
>>>>>> 
>>>>>> Lu Baolu (1):
>>>>>> iommu/vt-d: Add iotlb_sync_map callback
>>>>>> 
>>>>>> Yong Wu (2):
>>>>>> iommu: Move iotlb_sync_map out from __iommu_map
>>>>>> iommu: Add iova and size as parameters in iotlb_sync_map
>>>>>> 
>>>>>> drivers/iommu/intel/iommu.c | 86 +++++++++++++++++++++++++------------
>>>>>> drivers/iommu/iommu.c       | 23 +++++++---
>>>>>> drivers/iommu/tegra-gart.c  |  7 ++-
>>>>>> include/linux/iommu.h       |  3 +-
>>>>>> 4 files changed, 83 insertions(+), 36 deletions(-)
>>>>> 
>>>>> Here are results with the NFS client at stock v5.11-rc5 and the
>>>>> NFS server at v5.10, showing the regression I reported earlier.
>>>>> 
>>>>> 	Children see throughput for 12 initial writers  = 4534582.00 kB/sec
>>>>> 	Parent sees throughput for 12 initial writers   = 4458145.56 kB/sec
>>>>> 	Min throughput per process                      = 373101.59 kB/sec
>>>>> 	Max throughput per process                      = 382669.50 kB/sec
>>>>> 	Avg throughput per process                      = 377881.83 kB/sec
>>>>> 	Min xfer                                        = 1022720.00 kB
>>>>> 	CPU Utilization: Wall time    2.787    CPU time    1.922    CPU utilization  68.95 %
>>>>> 
>>>>> 
>>>>> 	Children see throughput for 12 rewriters        = 4542003.12 kB/sec
>>>>> 	Parent sees throughput for 12 rewriters         = 4538024.19 kB/sec
>>>>> 	Min throughput per process                      = 374672.00 kB/sec
>>>>> 	Max throughput per process                      = 383983.78 kB/sec
>>>>> 	Avg throughput per process                      = 378500.26 kB/sec
>>>>> 	Min xfer                                        = 1022976.00 kB
>>>>> 	CPU utilization: Wall time    2.733    CPU time    1.947    CPU utilization  71.25 %
>>>>> 
>>>>> 
>>>>> 	Children see throughput for 12 readers          = 4568632.03 kB/sec
>>>>> 	Parent sees throughput for 12 readers           = 4563672.02 kB/sec
>>>>> 	Min throughput per process                      = 376727.56 kB/sec
>>>>> 	Max throughput per process                      = 383783.91 kB/sec
>>>>> 	Avg throughput per process                      = 380719.34 kB/sec
>>>>> 	Min xfer                                        = 1029376.00 kB
>>>>> 	CPU utilization: Wall time    2.733    CPU time    1.898    CPU utilization  69.46 %
>>>>> 
>>>>> 
>>>>> 	Children see throughput for 12 re-readers       = 4610702.78 kB/sec
>>>>> 	Parent sees throughput for 12 re-readers        = 4606135.66 kB/sec
>>>>> 	Min throughput per process                      = 381532.78 kB/sec
>>>>> 	Max throughput per process                      = 387072.53 kB/sec
>>>>> 	Avg throughput per process                      = 384225.23 kB/sec
>>>>> 	Min xfer                                        = 1034496.00 kB
>>>>> 	CPU utilization: Wall time    2.711    CPU time    1.910    CPU utilization  70.45 %
>>>>> 
>>>>> Here's the NFS client at v5.11-rc5 with your series applied.
>>>>> The NFS server remains at v5.10:
>>>>> 
>>>>> 	Children see throughput for 12 initial writers  = 4434778.81 kB/sec
>>>>> 	Parent sees throughput for 12 initial writers   = 4408190.69 kB/sec
>>>>> 	Min throughput per process                      = 367865.28 kB/sec
>>>>> 	Max throughput per process                      = 371134.38 kB/sec
>>>>> 	Avg throughput per process                      = 369564.90 kB/sec
>>>>> 	Min xfer                                        = 1039360.00 kB
>>>>> 	CPU Utilization: Wall time    2.842    CPU time    1.904    CPU utilization  66.99 %
>>>>> 
>>>>> 
>>>>> 	Children see throughput for 12 rewriters        = 4476870.69 kB/sec
>>>>> 	Parent sees throughput for 12 rewriters         = 4471701.48 kB/sec
>>>>> 	Min throughput per process                      = 370985.34 kB/sec
>>>>> 	Max throughput per process                      = 374752.28 kB/sec
>>>>> 	Avg throughput per process                      = 373072.56 kB/sec
>>>>> 	Min xfer                                        = 1038592.00 kB
>>>>> 	CPU utilization: Wall time    2.801    CPU time    1.902    CPU utilization  67.91 %
>>>>> 
>>>>> 
>>>>> 	Children see throughput for 12 readers          = 5865268.88 kB/sec
>>>>> 	Parent sees throughput for 12 readers           = 5854519.73 kB/sec
>>>>> 	Min throughput per process                      = 487766.81 kB/sec
>>>>> 	Max throughput per process                      = 489623.88 kB/sec
>>>>> 	Avg throughput per process                      = 488772.41 kB/sec
>>>>> 	Min xfer                                        = 1044736.00 kB
>>>>> 	CPU utilization: Wall time    2.144    CPU time    1.895    CPU utilization  88.41 %
>>>>> 
>>>>> 
>>>>> 	Children see throughput for 12 re-readers       = 5847438.62 kB/sec
>>>>> 	Parent sees throughput for 12 re-readers        = 5839292.18 kB/sec
>>>>> 	Min throughput per process                      = 485835.03 kB/sec
>>>>> 	Max throughput per process                      = 488702.12 kB/sec
>>>>> 	Avg throughput per process                      = 487286.55 kB/sec
>>>>> 	Min xfer                                        = 1042688.00 kB
>>>>> 	CPU utilization: Wall time    2.148    CPU time    1.909    CPU utilization  88.84 %
>>>>> 
>>>>> NFS READ throughput is almost fully restored. A normal-looking throughput
>>>>> result, copied from the previous thread, is:
>>>>> 
>>>>> 	Children see throughput for 12 readers 		= 5921370.94 kB/sec
>>>>> 	Parent sees throughput for 12 readers 		= 5914106.69 kB/sec
>>>>> 
>>>>> The NFS WRITE throughput result appears to be unchanged, or slightly
>>>>> worse than before. I don't have an explanation for this result. I applied
>>>>> your patches on the NFS server also without noting improvement.
>>>> Function-boundary tracing shows some interesting results.
>>>> # trace-cmd record -e rpcrdma -e iommu -p function_graph --max-graph-depth=5 -g dma_map_sg_attrs
>>>> Some 120KB SGLs are DMA-mapped in a single call to __iommu_map(). Other SGLs of
>>>> the same size need as many as one __iommu_map() call per SGL element (which
>>>> would be 30 for a 120KB SGL).
>>>> In v5.10, intel_map_sg() was structured such that an SGL is always handled with
>>>> a single call to domain_mapping() and thus always just a single TLB flush.
>>>> My amateur theorizing suggests that the SGL element coalescing done in
>>>> __iommu_map_sg() is not working as well as intel_map_sg() used to, which results
>>>> in more calls to domain_mapping(). Not only does that take longer, but it creates
>>>> many more DMA maps. Could that also have some impact on device TLB resources?
>>> 
>>> It seems that more domain_mapping() calls are not caused by
>>> __iommu_map_sg() but __iommu_map().
>>> 
>>> Can you please test below changes? It call intel_iommu_map() directly
>>> instead of __iommu_map().
>>> 
>>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>> index f5a236e63ded..660d5744a117 100644
>>> --- a/drivers/iommu/intel/iommu.c
>>> +++ b/drivers/iommu/intel/iommu.c
>>> @@ -4916,7 +4916,7 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
>>> }
>>> #endif
>>> 
>>> -static int intel_iommu_map(struct iommu_domain *domain,
>>> +int intel_iommu_map(struct iommu_domain *domain,
>>>                           unsigned long iova, phys_addr_t hpa,
>>>                           size_t size, int iommu_prot, gfp_t gfp)
>>> {
>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>> index 3d099a31ddca..a1b41fd3fb4e 100644
>>> --- a/drivers/iommu/iommu.c
>>> +++ b/drivers/iommu/iommu.c
>>> @@ -23,8 +23,13 @@
>>> #include <linux/property.h>
>>> #include <linux/fsl/mc.h>
>>> #include <linux/module.h>
>>> +#include <linux/intel-iommu.h>
>>> #include <trace/events/iommu.h>
>>> 
>>> +extern int intel_iommu_map(struct iommu_domain *domain,
>>> +                          unsigned long iova, phys_addr_t hpa,
>>> +                          size_t size, int iommu_prot, gfp_t gfp);
>>> +
>>> static struct kset *iommu_group_kset;
>>> static DEFINE_IDA(iommu_group_ida);
>>> 
>>> @@ -2553,8 +2558,7 @@ static size_t __iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
>>>                phys_addr_t s_phys = sg_phys(sg);
>>> 
>>>                if (len && s_phys != start + len) {
>>> -                       ret = __iommu_map(domain, iova + mapped, start,
>>> -                                       len, prot, gfp);
>>> +                       ret = intel_iommu_map(domain, iova + mapped, start, len, prot, gfp);
>>> 
>>>                        if (ret)
>>>                                goto out_err;
>>> 
>>> Does it change anything?
>> I removed yesterday's 3-patch series, and applied the above.
>> Not a full restoration, but interesting nonetheless.
> 
> Do you mind having a try with all 4 patches?

Much worse. I checked this result several times. I still need to go
look more closely at the patches to see if I merged them together
sensibly.

	Children see throughput for 12 initial writers  = 3890646.38 kB/sec
	Parent sees throughput for 12 initial writers   = 3857201.57 kB/sec
	Min throughput per process                      = 322068.31 kB/sec 
	Max throughput per process                      = 326518.72 kB/sec
	Avg throughput per process                      = 324220.53 kB/sec
	Min xfer                                        = 1034240.00 kB
	CPU Utilization: Wall time    3.239    CPU time    1.959    CPU utilization  60.49 %


	Children see throughput for 12 rewriters        = 3571855.25 kB/sec
	Parent sees throughput for 12 rewriters         = 3568989.90 kB/sec
	Min throughput per process                      = 295413.09 kB/sec 
	Max throughput per process                      = 300169.31 kB/sec
	Avg throughput per process                      = 297654.60 kB/sec
	Min xfer                                        = 1032192.00 kB
	CPU utilization: Wall time    3.495    CPU time    2.017    CPU utilization  57.70 %


	Children see throughput for 12 readers          = 3485583.19 kB/sec
	Parent sees throughput for 12 readers           = 3482811.89 kB/sec
	Min throughput per process                      = 287489.16 kB/sec 
	Max throughput per process                      = 294395.06 kB/sec
	Avg throughput per process                      = 290465.27 kB/sec
	Min xfer                                        = 1024256.00 kB
	CPU utilization: Wall time    3.565    CPU time    1.984    CPU utilization  55.64 %


	Children see throughput for 12 re-readers       = 3427079.94 kB/sec
	Parent sees throughput for 12 re-readers        = 3424836.93 kB/sec
	Min throughput per process                      = 283702.56 kB/sec 
	Max throughput per process                      = 288727.31 kB/sec
	Avg throughput per process                      = 285589.99 kB/sec
	Min xfer                                        = 1030400.00 kB
	CPU utilization: Wall time    3.634    CPU time    1.999    CPU utilization  55.02 %


>> 	Children see throughput for 12 initial writers 	= 4852657.22 kB/sec
>> 	Parent sees throughput for 12 initial writers 	= 4826730.38 kB/sec
>> 	Min throughput per process 			=  403196.09 kB/sec
>> 	Max throughput per process 			=  406071.47 kB/sec
>> 	Avg throughput per process 			=  404388.10 kB/sec
>> 	Min xfer 					= 1041408.00 kB
>> 	CPU Utilization: Wall time    2.596    CPU time    2.047    CPU utilization  78.84 %
>> 	Children see throughput for 12 rewriters 	= 4853900.22 kB/sec
>> 	Parent sees throughput for 12 rewriters 	= 4848623.31 kB/sec
>> 	Min throughput per process 			=  403380.81 kB/sec
>> 	Max throughput per process 			=  405478.53 kB/sec
>> 	Avg throughput per process 			=  404491.68 kB/sec
>> 	Min xfer 					= 1042944.00 kB
>> 	CPU utilization: Wall time    2.589    CPU time    2.048    CPU utilization  79.12 %
>> 	Children see throughput for 12 readers 		= 4938124.12 kB/sec
>> 	Parent sees throughput for 12 readers 		= 4932862.08 kB/sec
>> 	Min throughput per process 			=  408768.81 kB/sec
>> 	Max throughput per process 			=  413879.25 kB/sec
>> 	Avg throughput per process 			=  411510.34 kB/sec
>> 	Min xfer 					= 1036800.00 kB
>> 	CPU utilization: Wall time    2.536    CPU time    1.906    CPU utilization  75.16 %
>> 	Children see throughput for 12 re-readers 	= 4992115.16 kB/sec
>> 	Parent sees throughput for 12 re-readers 	= 4986102.07 kB/sec
>> 	Min throughput per process 			=  411103.00 kB/sec
>> 	Max throughput per process 			=  420302.97 kB/sec
>> 	Avg throughput per process 			=  416009.60 kB/sec
>> 	Min xfer 					= 1025792.00 kB
>> 	CPU utilization: Wall time    2.497    CPU time    1.887    CPU utilization  75.57 %
>> NFS WRITE throughput improves significantly. NFS READ throughput
>> improves somewhat, but not to the degree it did with yesterday's
>> patch series.
>> function_graph shows a single intel_iommu_map() is used more
>> frequently, but the following happens on occasion:
> 
> This is because the pages are not physically contiguous, __iommu_map_sg
> can't coalesce them.

Understood, but why was physical contiguity not a problem for the
intel_map_sg() function removed by commit c588072bba6b ("iommu/vt-d:
Convert intel iommu driver to the iommu ops")? That version of the
function did no such checking, and simply invoked domain_mapping()
once for the entire SGL. Was that not safe to do?

(Feel free to tell me where I'm wrong, I'm really quite a neophyte
with this level of IOMMU detail).


> If there's no full restoration with all four patches, it could be due to
> ping-pongs between iommu core and the vendor iommu driver with indirect
> calls. Hence a possible solution is to add an iommu_ops->map_sg() so
> that all scatter gathered items could be handled in a single function as
> before. This has already proposed by Isaac J. Manjarres.
> 
> https://lore.kernel.org/linux-iommu/1610376862-927-5-git-send-email-isaacm@codeaurora.org/

That was one of the first things I tried. However, Isaac's patches
don't provide an Intel version of .map_sg, so I made one up based on
__iommu_map_sg, which basically copied the physical page checking
mentioned above. It didn't perform very well.

I could try again with a .map_sg that works like the old intel_map_sg()
function, perhaps.


> Best regards,
> baolu
> 
>> 395.678889: funcgraph_entry:                   |  dma_map_sg_attrs() {
>> 395.678889: funcgraph_entry:                   |    iommu_dma_map_sg() {
>> 395.678890: funcgraph_entry:        0.257 us   |      iommu_get_dma_domain();
>> 395.678890: funcgraph_entry:        0.255 us   |      iommu_dma_deferred_attach();
>> 395.678891: funcgraph_entry:                   |      iommu_dma_sync_sg_for_device() {
>> 395.678891: funcgraph_entry:        0.253 us   |        dev_is_untrusted();
>> 395.678891: funcgraph_exit:         0.773 us   |      }
>> 395.678892: funcgraph_entry:        0.250 us   |      dev_is_untrusted();
>> 395.678893: funcgraph_entry:                   |      iommu_dma_alloc_iova() {
>> 395.678893: funcgraph_entry:                   |        alloc_iova_fast() {
>> 395.678893: funcgraph_entry:        0.255 us   |          _raw_spin_lock_irqsave();
>> 395.678894: funcgraph_entry:        0.375 us   |          __lock_text_start();
>> 395.678894: funcgraph_exit:         1.435 us   |        }
>> 395.678895: funcgraph_exit:         2.002 us   |      }
>> 395.678895: funcgraph_entry:        0.252 us   |      dma_info_to_prot();
>> 395.678895: funcgraph_entry:                   |      iommu_map_sg_atomic() {
>> 395.678896: funcgraph_entry:                   |        __iommu_map_sg() {
>> 395.678896: funcgraph_entry:        1.675 us   |          intel_iommu_map();
>> 395.678898: funcgraph_entry:        1.365 us   |          intel_iommu_map();
>> 395.678900: funcgraph_entry:        1.373 us   |          intel_iommu_map();
>> 395.678901: funcgraph_entry:        1.378 us   |          intel_iommu_map();
>> 395.678903: funcgraph_entry:        1.380 us   |          intel_iommu_map();
>> 395.678905: funcgraph_entry:        1.380 us   |          intel_iommu_map();
>> 395.678906: funcgraph_entry:        1.378 us   |          intel_iommu_map();
>> 395.678908: funcgraph_entry:        1.380 us   |          intel_iommu_map();
>> 395.678910: funcgraph_entry:        1.345 us   |          intel_iommu_map();
>> 395.678911: funcgraph_entry:        1.342 us   |          intel_iommu_map();
>> 395.678913: funcgraph_entry:        1.342 us   |          intel_iommu_map();
>> 395.678915: funcgraph_entry:        1.395 us   |          intel_iommu_map();
>> 395.678916: funcgraph_entry:        1.343 us   |          intel_iommu_map();
>> 395.678918: funcgraph_entry:        1.350 us   |          intel_iommu_map();
>> 395.678920: funcgraph_entry:        1.395 us   |          intel_iommu_map();
>> 395.678921: funcgraph_entry:        1.342 us   |          intel_iommu_map();
>> 395.678923: funcgraph_entry:        1.350 us   |          intel_iommu_map();
>> 395.678924: funcgraph_entry:        1.345 us   |          intel_iommu_map();
>> 395.678926: funcgraph_entry:        1.345 us   |          intel_iommu_map();
>> 395.678928: funcgraph_entry:        1.340 us   |          intel_iommu_map();
>> 395.678929: funcgraph_entry:        1.342 us   |          intel_iommu_map();
>> 395.678931: funcgraph_entry:        1.335 us   |          intel_iommu_map();
>> 395.678933: funcgraph_entry:        1.345 us   |          intel_iommu_map();
>> 395.678934: funcgraph_entry:        1.337 us   |          intel_iommu_map();
>> 395.678936: funcgraph_entry:        1.305 us   |          intel_iommu_map();
>> 395.678938: funcgraph_entry:        1.380 us   |          intel_iommu_map();
>> 395.678939: funcgraph_entry:        1.365 us   |          intel_iommu_map();
>> 395.678941: funcgraph_entry:        1.370 us   |          intel_iommu_map();
>> 395.678943: funcgraph_entry:        1.365 us   |          intel_iommu_map();
>> 395.678945: funcgraph_entry:        1.482 us   |          intel_iommu_map();
>> 395.678946: funcgraph_exit:       + 50.753 us  |        }
>> 395.678947: funcgraph_exit:       + 51.348 us  |      }
>> 395.678947: funcgraph_exit:       + 57.975 us  |    }
>> 395.678948: funcgraph_exit:       + 58.700 us  |  }
>> 395.678953: xprtrdma_mr_map:      task:64127@5 mr.id=104 nents=30 122880@0xc5e467fde9380000:0xc0011103 (TO_DEVICE)
>> 395.678953: xprtrdma_chunk_read:  task:64127@5 pos=148 122880@0xc5e467fde9380000:0xc0011103 (more)
>> --
>> Chuck Lever

--
Chuck Lever



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
