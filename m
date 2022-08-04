Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DA02585
	for <iommu@lists.linux.dev>; Thu,  4 Aug 2022 14:33:11 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 274EX1jI011525;
	Thu, 4 Aug 2022 14:33:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=l9tsDn/7vecr9CSopV2QkgVcdWPTNwcz6FdAYEmkOJc=;
 b=RzfAOWuPiEI43V5X9OywaONmlNv+Z8BFgobS7VtorW3QdqxpcakP2KFquDUg4CHpX9Zi
 tBIp+3GX+dD8+t50McaNeQYqBMa/1s8/mTzgS5r/ciL1vU+8eUs94dAsX1wSxuLtoC/m
 lh0vSCMYKpJ75hx0yNqYYChq6eaAjuvnX2lSumNhfu2HGQrGC/J6kTxVBG6t+VkHr+xU
 ae21Tv/eqEz4uHPHr5/c9syIomG357Bp+2RD8NQmPhT8l0u520v6UMSARTRuwEbMDxhd
 MaUJARu796QkeatEFIm05JyEVXSGsLC0G3eGpnj/MVMrZXpLPzqM/7+p1CBFXPj2YEZ7 Ww== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmv8sd3tw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Aug 2022 14:33:00 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 274CD1tA030906;
	Thu, 4 Aug 2022 14:32:53 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu34bmk0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Aug 2022 14:32:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vuhp52KhFL0btcFHUQlim+on6VRT0sORhKtG77KdgOITjUf95ikv6Sg6Ggap7ifxxk2AflEwENtYiXOUfR1eqVWR+WCcB7bBOukf6S4qrc+NbToLz1PWQeTwXtka4Fsx8AhZUzBd8DfhHcYpQmlnPq69YYFrkp0kqrCJekk57585ZX0NP/LBG17WiAKq2QnCGu4oQRKeMTvJpk5qrYebcynU1Tuxekx2yDnWyYtLPnh//DLkeHz2ig2kuF/sxBfpunfXp9vnRsrlCpdMAqznWXcZcqfC7HBMV4a/4dHckCXd+Pavu68anxh6kLra+RbbUlJ4KXxUQIt6Proxoo+Kxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l9tsDn/7vecr9CSopV2QkgVcdWPTNwcz6FdAYEmkOJc=;
 b=ROWtGoukhtFyZBtZVGmcc3dT7bSO7I5HYnhDzIwIVhOWPKI3fqmsKvwEXOpM64Jk6GHxybomYJ9JW3EJFRoHY5dUrMfzHIi/CK63M+HS8kX0UGri6GnqybO7k/PyrymGWLU4catxStSaB6QAGjrHMS/09syqWkYjlCNfL3OZ/86PVvfZdG/LA7L1dPh6U1Eh5F0NBcURp0o5du3AzO9QO3c/yh1wA/IP79zxbz+RJvgmwtd+F4WLV4UtQwUvNDbyjrZdeDPTCvvMabLo8z+mcjAxoRS9VWs/ea/VlJD63FQAYgqVTWb+xOGcxlrEsFteOZfm7doIPvkLoAkc2EJ4xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9tsDn/7vecr9CSopV2QkgVcdWPTNwcz6FdAYEmkOJc=;
 b=fx/ap1ZbGiBJZF2YWqbV6joz6khhOiN8vEOqv+un7xBGFBhgyTvWpBqE/atSVX5nQUAZQXy7hgKE5Tq/kdaSUV7sexETx4GVH0C8+X/lMv1Gugm+Dd/szgeY3Z+CtDIwai/Xy8eAudswBFxdDBoDGIKED2XyqpttJu8qKVaNZFw=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1967.namprd10.prod.outlook.com
 (2603:10b6:300:10b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.15; Thu, 4 Aug
 2022 14:32:51 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5504.014; Thu, 4 Aug 2022
 14:32:51 +0000
Date: Thu, 4 Aug 2022 17:32:39 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Joerg Roedel <joro@8bytes.org>, Suman Anna <s-anna@ti.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        iommu@lists.linux.dev, kernel-janitors@vger.kernel.org
Subject: [PATCH] iommu/omap: fix buffer overflow in debugfs
Message-ID: <YuvYh1JbE3v+abd5@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0104.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::19) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94f6648f-beb5-4d86-e740-08da762635b9
X-MS-TrafficTypeDiagnostic: MWHPR10MB1967:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	xASMYaQZ5cbaNAzUer8geFKawIHyc8P7ovTnAuDQTS1Jh8ptOE9bYQVmUk+lhUU6oLLy33ZJKbhm98SEfCbyIdYc+m8l4K45Y00aoKi4s0gFWqwForE551wldX2Gfu8AanTPg9dU1spP53bUVJNfHPRBhVMqeq4DqtP6tFd4lxM+4s2K70BGaPvtrFA27ae0esJA6KY/RxBpObatH+MlY/poki48SfTNIgbQXmPaKMV9dL7Db3Si4NPnI65o62RH/8WsvoGt7cLxnI6YrtzDDL+uqJqRt5c2v9V6fVZ3OP6w+wC/dL1TjMrRLiouISWP6Mlkh/HlUWHY8OyQVQgp+RSOxv/2Xcv6vdHwXo8FcyXIxuKSRrt7Ek698YV4h9lj7MLTzV55931ZRCMq1w7twrbU57yiY40T8Aj3ggf1XTXo/zlp1f6oau8BXyHFRRCgPKJAEYwzgsEfhx28zlkRPxylnX6jVvukh3oVOj3t27YB5GO3vto1B98+SgNlbDltCx4lSfLnxTGS0sFqmz/12qZuM3yBTMBg6BFUH0QZ7TgX1VPzO+7y2wF94QVSTe5rY0IbFKuEJufSSaw02ZCNj9F0zQeKDzdmJTi16f/SR/YpIlUMABjHWuQnUT4cE3aba7bQ0aA9Ye5+klAgKs8iAHQW+lWx1WfRzB8K1vq8K0kr3e3BPxRy78wZOuLhrm/JhJADnW2qfu6eyLaP+IpWsZDTlL2tLspycVsuSeCBOJ5IVYVR+dmd2HwRKHUeTNXkbSu3C0hMvnjqynu24geuTg7FwFxhkdmaGPSNu332Jg2O9gSjDxf9jMJld4pFNrkHFPN013n6Tm+qCxJqobYAgw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(136003)(376002)(366004)(396003)(346002)(110136005)(54906003)(44832011)(83380400001)(33716001)(38100700002)(52116002)(316002)(186003)(6506007)(38350700002)(2906002)(5660300002)(9686003)(6666004)(26005)(478600001)(6512007)(66946007)(6486002)(66556008)(66476007)(4326008)(8676002)(8936002)(86362001)(41300700001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?eRwOizB3FKQzRXM5sZ9NQdsUo4P3j+etAZWSOFppIk9aMSonxxp1yOplpdJM?=
 =?us-ascii?Q?ex1zAq1l1jn03/FxcHMaz6+RuzHtrrVqAz08h+kiO5IIjAmlvp2exShbutO8?=
 =?us-ascii?Q?G2Uf2RXxYKEmJl3f/1nnYZudN2bz7d6M6xpXWeVXW9blkVFUrmLheJDq50pv?=
 =?us-ascii?Q?9GvBjZUm+FpPcg7a1tGY58Mg9dzHOKYg1RN/9h6qHSg8OQtQR2+0fcl6v1gN?=
 =?us-ascii?Q?UpPkV4B+cvIW0V2vK4PCCUsRLL+8vRGnUOh7cNbdJ3TvOybb0tScpmLCo0dr?=
 =?us-ascii?Q?vCD//jzJsHHmRYQRjINBumeJqp/jkprYLlNK1PcT2I/MNxAYna+Ies+ymX9C?=
 =?us-ascii?Q?tx1LNFnN/LSxeW7Jsbnfa9BwEIzlG9mmnvNLs+q9yZYSKla9muwRKKObGhDv?=
 =?us-ascii?Q?bU28ZSgSy2e3vSe0FlLis/0pJockcmF1u22jHnOtnBUVw8UOiNMTGVEmo8l+?=
 =?us-ascii?Q?Sgxb/B9cQNkMuRK4UtRQ1CILbHzpiEA7tzNbLFdPJB6Jqn67UBeO+hFLhSmX?=
 =?us-ascii?Q?p6EySo28YVuM1iAfazVstfDHoOnd+OkKHc39IR0pMHV3B6orQ2KupNN4JXZf?=
 =?us-ascii?Q?RBkOz2UydVn2jBkknu9oD/rkNOASB8L7/Ncl+E4tS1ntIMhmWmck8TUdzBKX?=
 =?us-ascii?Q?JJ6ZHTYdHXNVVRpNKb6Z5TVRs4bwOHDgDFqJk5yeP4QysVE2yN8133/JaGQX?=
 =?us-ascii?Q?5Vw0sE5nH5BBaeiZFaA7TVgpFU1ylEiN6tEaM9KvwR/QgRCfChswyh/IX17o?=
 =?us-ascii?Q?Ze+AeplDaKFduVL+0Obp/5t1dQoavKB0D7pFE68ql3cDYOgTa286USj8cUfE?=
 =?us-ascii?Q?iMhP2h9IYEHHLyGaT+TqC58kgCOexc9gbTjhM4ztUFbqJOpjhmxGuQUo1ypp?=
 =?us-ascii?Q?/9yM/YUpVZsJnNET82ly8RoVcCawLq5gqQiHVBPJAxCAu79Uk2ZNSC4pauGn?=
 =?us-ascii?Q?HdQRRNuzZPbOBZqTVGeGcKxyo0VPHBLxwryYLxHs0l2BjdNn12JoFuDCseUu?=
 =?us-ascii?Q?uFQz8QnJAcUILZd51INyWQdshOjja+j0VfMDNA5FMI7eaUOZXdNcWkHCnXjh?=
 =?us-ascii?Q?95mVN9V1xA1Px30v8iI/pAz//Eh/6efAivBhXqHPZ0bU0bVYOqZj8fqf761x?=
 =?us-ascii?Q?pJT8cpwQ4vFVNOgaUKjiPnvXIcXYD6PHgMcRxzwF4TtALzKHpIC4fNrmnVmW?=
 =?us-ascii?Q?YqCZKqn9ZLFvnWiGOIx1/OAXG6InDJ0N4kC00B/FqnrJASvogR1J22wsoM/u?=
 =?us-ascii?Q?p/n53x1CmYYObNvldFk5n8SKl6FOT/gvXCyaXNliGjy6bvDEZCc7nhqRVsye?=
 =?us-ascii?Q?7pML3S/sqIzPdpy3u302IYXqWuT6H6nlk+tKlmkE3ooNrr/fWeL+hQcIiTeh?=
 =?us-ascii?Q?v/2VaggawZay/HjygIMafM5mmx0iRyih/hOIpqga0LL4yN0nQ4vLnEGrPQb6?=
 =?us-ascii?Q?ZSIAHh4afef97D/0dCWuD5ioEXVWOHCpovcpNlbVErUmfOZQR6WuIytFSP/Y?=
 =?us-ascii?Q?xsbhgyZ5D6/UpPlhjgImMI16ln5YLizn/4ld0YKal0rLdndUhhiGDQMrsjj0?=
 =?us-ascii?Q?lzVPzhVwS3u7yFzphT9h+v3Ekvm6gu1QhqWfPgwBuS+QO5Pz/J2bM7oOiTT4?=
 =?us-ascii?Q?sg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94f6648f-beb5-4d86-e740-08da762635b9
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 14:32:51.2306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yfln/q6U6jWgtzq6OQV9lFNaCsKH0X44NeuuxbsmTTSDdCE4aFEyRm4syn0VGEZuuf10uVYwJSZJZay2y7bXQNmRzH4EK0FhHEio60rIUW4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1967
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-04_03,2022-08-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208040064
X-Proofpoint-GUID: GOVUhtfs92gr2DCTzrMaUzwCEDyS0KzK
X-Proofpoint-ORIG-GUID: GOVUhtfs92gr2DCTzrMaUzwCEDyS0KzK

There are two issues here:

1) The "len" variable needs to be checked before the very first write.
   Otherwise if omap2_iommu_dump_ctx() with "bytes" less than 32 it is a
   buffer overflow.
2) The snprintf() function returns the number of bytes that *would* have
   been copied if there were enough space.  But we want to know the
   number of bytes which were *actually* copied so use scnprintf()
   instead.

Fixes: bd4396f09a4a ("iommu/omap: Consolidate OMAP IOMMU modules")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/iommu/omap-iommu-debug.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/omap-iommu-debug.c b/drivers/iommu/omap-iommu-debug.c
index a99afb5d9011..259f65291d90 100644
--- a/drivers/iommu/omap-iommu-debug.c
+++ b/drivers/iommu/omap-iommu-debug.c
@@ -32,12 +32,12 @@ static inline bool is_omap_iommu_detached(struct omap_iommu *obj)
 		ssize_t bytes;						\
 		const char *str = "%20s: %08x\n";			\
 		const int maxcol = 32;					\
-		bytes = snprintf(p, maxcol, str, __stringify(name),	\
+		if (len < maxcol)					\
+			goto out;					\
+		bytes = scnprintf(p, maxcol, str, __stringify(name),	\
 				 iommu_read_reg(obj, MMU_##name));	\
 		p += bytes;						\
 		len -= bytes;						\
-		if (len < maxcol)					\
-			goto out;					\
 	} while (0)
 
 static ssize_t
-- 
2.35.1

