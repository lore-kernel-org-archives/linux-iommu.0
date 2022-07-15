Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B276B20E0
	for <iommu@lists.linux.dev>; Fri, 15 Jul 2022 08:20:11 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26F4pPBJ032716;
	Fri, 15 Jul 2022 08:20:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=V+PKlGFC4rcQHJeAa2/QTCnNGcr1zkxtmEoramWZogE=;
 b=K9xcqfjGIcSSwvXBC2bkVKWs0ryGDzoxDfzJ4z7r8zN2MGrQdtqefYe41mA/6RKsYwWZ
 6/VTUhfbTgGI8lCA71K0ik2eJTZQRiV5Fys9dVp7LXgkYv10LxfYQLgB6cGly2etSY26
 +f3u0G2r44pG19PUwOf4a4Ct0l1Pb/vl6w/6iZOQPnjVHQ7UY57hKUasSP2V5Io5bVuf
 ANXyGtIyuGj/5BZksW/yEGLpotPBwRx66VhOM2f/z2Qw1Afcz2FFNZI7lhIWvqbxZh8z
 MxWA/83boK/xim3Czk4PPLxpCfPyHvkGxXdo3mhRlT/XEo2gsYp4m8au8dHF1ZfdH+yT EA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71r1er60-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Jul 2022 08:20:02 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26F8Ajnc006183;
	Fri, 15 Jul 2022 08:20:01 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h7046f0nk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Jul 2022 08:20:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HMK2YLgL7bBjIlVohfTNWOVJxDR67bxnoTnblSJtb+hrAHk71erW9/qjw46yJm/Lzj9kJLPE1nOQ/od1ssPNS1tDDrk76IFjWc8Ajje3gkEDd10uJHeFLuxa1+Wd36a+tdStHYBH/yas99YIGdTquSd1zwRxMC2Uhdo1ByDbwm1IIWKFNHWW5crqYs9jZ4TOP2PaP2V0IKmzXa9IDWV08cxuzASIlsGe+2adP0SEeEs7kP7L25DfGFMFbVzBlVgMh5+9Fk0c6HKaBaWiSuQ7AJsC8XXTEieUqY9P767sjPtTXyImn2NWM+z4jO1Zs/HLb9OP5uDeVwykXOXxnewwrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+PKlGFC4rcQHJeAa2/QTCnNGcr1zkxtmEoramWZogE=;
 b=fdjwXFgutaSGwDn8Trewnhujb2Uju19YvsZ9THSAZr14/zrRGdVhbISIm0SltFWJJ38c9HQLO2vZJI0NTdILJ1tHl2ewg1VRMOcTvb3sfYR4Hu1ljl3RLtWnytnGIwfPHWDcR7m4KXLv9hgGUFGS7n1YjpFTAowhvTiDa/VBvkde1BoX6ot/bqPVd80bRCWVbvUHtHhqgPNh3n10ar81D+vWb8nE2Ibxl2YKXZG0/c3h2qMpNOZfZ1O5Pcieqa6PsoffTZVCRdiL5/7VJnbXGluKADEzwvIXLMngOlfRR4VpMBv4Ij0IsXM4vU/TVnRD5aNfOCPlgGm65sIbmnhdrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+PKlGFC4rcQHJeAa2/QTCnNGcr1zkxtmEoramWZogE=;
 b=s7JCdA/4+QLk4lUAEPVdMgCJkIDjHB8JKXvbjrS+eowcl30QinZ9P34ykf6Qt9Y+xTgLkHo5Wpn4sAPg+dYBTFQVNalJIP/pgDQoMv+irxbCkpbj5w96Aao7lcnpo7ZcPsUpb63KIjyTOebjqVN45ngyZdcu60b+h4h38iLduaI=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN8PR10MB3282.namprd10.prod.outlook.com
 (2603:10b6:408:d2::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Fri, 15 Jul
 2022 08:20:00 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5438.014; Fri, 15 Jul 2022
 08:20:00 +0000
Date: Fri, 15 Jul 2022 11:19:50 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Christoph Hellwig <hch@infradead.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] swiotlb: Fix use after free on error handling path
Message-ID: <YtEjJkxyiZouY7d3@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0054.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::23) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 068c6715-03ab-4655-54ae-08da663acf76
X-MS-TrafficTypeDiagnostic: BN8PR10MB3282:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Od2EAJCjTwiPxG+6aiU7eJJQaSSwatH95T3mtDiajGsHzADHB53DOWDZczEbH7LglbQS6cI+zr6TKlMnWBywSOT5PQ6fqQdIavQnrWSDwWrcgUVa6bH1xqkE9ROEUc92ObxvSQx03N9XN0NSq/euniU0KabN7ZcXISBjy9MOdpEaiX+5SR2+1BddNcS/0zvK2A5qOubeKReNxqDEK+zHuz93Tn8gpSCZbfHEKmmxLovq1LocT3J7plcifE1LXzhVuCpmikfFIpuzlgpdh4a5d+ic6GBp4Pr6ye5JncevDlNduDTmpwf8947kGG8fUAVlNRZ7KObYh8/OW1eK/9yqh5BGe/aF+HiZIRLPRBPpa8+5XvYTUvTZu1zFn74aM7G1hBkDMjT6zoau40WyB46TN6mvwO1si5wsBIMM+S4Ozm/FJqj0V7fH9VurutzkLCYMK6YQIlTYbFDyklrIFAZA6bJDosgiUqYT3PMKrtru2e52bpMODZOh4yBgZms3bm5kF0p/+Pwuc67TKCrw1HbOyr7L5IsDmzswhccvqBumcMv0W8ebSkNjCj66UwFDd8b6hSMNrvOcm1o151WYzrnK8h5Bsm+y3PDB1gRSoQ0iCtGsBOeUJWsm+8md5DHddpUiRBaIsa3GS+JHYBtRAZGbEQuu34QU6tW4sqynJPEZvdiV03E+OAGuDVje32pEeLEa5SdHOFbSzvuRcwtdqTUchDSG693uEZQ80bhs068US/vU1HEGD3lsrIgoG3S3KnM7eqC7htsvYvPnMpoPWno2iU5jvYztJGfONmQt4i4JXojNnL5i6wxOrxLMhczynsT9
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(346002)(136003)(366004)(396003)(39860400002)(316002)(6506007)(2906002)(66946007)(44832011)(54906003)(5660300002)(110136005)(26005)(83380400001)(52116002)(66556008)(41300700001)(33716001)(8676002)(6666004)(4326008)(66476007)(478600001)(6486002)(8936002)(4744005)(38350700002)(9686003)(186003)(86362001)(6512007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?DeiSFR6P8yzC8ukYnsehLi5n2qXKeWzdH4SngwCMRPriDnymMt0VnUN4RkTT?=
 =?us-ascii?Q?4SES1XOSt/sViC5wUDOhn1rIDxuK2VvF3q6yESiHdyi/8UMg5GeadXPJJNqu?=
 =?us-ascii?Q?t4VxXGd+40N0ulpPZUgcfw0KO/XBHyXe8ZNepLl25PNP9fTfsiIB9ULXB6Ti?=
 =?us-ascii?Q?g0c1k3kRO+fqdeIZ9cydBR7/xJHp+GDCbM3swVlaQlnLvxF7T9XBBnalsvo9?=
 =?us-ascii?Q?qZADutIDFZi1Evw8URABkkIvVbvJnceCDtiWHk9OQ+leD0FPmWdeNx8WSSxi?=
 =?us-ascii?Q?07eQUkTiuWTpfwnff53bZ8Ov0mUbMMaUmnfLxv9MiF9W+z35RZAH6ydN5BT4?=
 =?us-ascii?Q?jk17IeqVwwAE9g8Hz7pJlrQ3i+JUltU//9F0Ks3oy1lpvEnoWmX5VwWVwZ+C?=
 =?us-ascii?Q?Hr0jfR6/U4eSLTCNQX1+RLh0taEXbv/7c8XCzKpMQSrT0RsickKjofrLitmr?=
 =?us-ascii?Q?9qsZp1ChywZhmWAyvRxgIv87vQT/guwM91j+68B4rx4DwCi6n8BoG8MsT8wQ?=
 =?us-ascii?Q?CZPCANPg4aEfPOa4RAkkhd4CMbFgO9UeKcBD/MI6VcvmOVvFmTEwFp09vp31?=
 =?us-ascii?Q?wi67+GYexAMLyfbDNnNilNXnXq7FGWJ2o2uq1pPGoEUxDy/R5lYtFCO82T+1?=
 =?us-ascii?Q?wINih8MA6PBIN+wLl6t1b3k+Bn46tn1tjyNdZMMe7ZvdXYHHE6xF0Wev+/hv?=
 =?us-ascii?Q?WJj2GNpZoUgVex0MpGOaLExVNjm4coLjtUfMibm1BAeDavAWEs2yLq1oC6i3?=
 =?us-ascii?Q?3y/psg6C8X5JrT6UIJgRPXQWEIwvUqtQO9e2mLex7Ap7WUq3e7dQghzfULUd?=
 =?us-ascii?Q?HATkCIR4XLD0u6QRoHbXwF+SUK7wuSwQADDXCq5dy1ZdJ6P8PeVPbQw9yyKB?=
 =?us-ascii?Q?gw6GlxI2a+3zYjef36EFz8o8le39rrnOvgOXx3Bo9H6Ej9n6fl9O1TvG0XOA?=
 =?us-ascii?Q?D3J/u1ygLycDAyxp9g780ErKdq8u9zHlufLjkro6eMcT6f9EBVk1fh8YZRnJ?=
 =?us-ascii?Q?kH2F0wTQnuT7mFo+9iXSeynXnfL/bshLCX2f35sqAQWwt8m8X8h58fsfuoko?=
 =?us-ascii?Q?BfKkc+zKpSXc9WJ4gQy4vzZ97KyGOOFJyxqkNOUHhWsVOZIM1VSFs8E8Uepg?=
 =?us-ascii?Q?sA9spz+zpQIFMyglcK5bqjrc4BgulhuiytNki03taujyC/EjHKrPPO0sUTUh?=
 =?us-ascii?Q?ZJjv5PSSlGezd9S8fKPB1+dxaCdWiBK/rnRNrR/ooruWuKgHemfEppneOd/Q?=
 =?us-ascii?Q?m5w0XrTP2+AAUsabU4xmFfiaZOhjt5PmIi6CNuVocIWKPumt2X/VI+huXfUC?=
 =?us-ascii?Q?aVDrDUJmKOgYDiOxGGrWsoTVA1hqWmAdOyISpzKRqWD+M+D25ySdUhW44+8k?=
 =?us-ascii?Q?OpAntA19mJnYWmjpcZB3AfVYBWVpDbaL7GjTDGt1DJmxTAdFRbo2sQhMJ+wc?=
 =?us-ascii?Q?X06CWU5+JQDG9pUpX8m3pU0LD+SHR4VxnbjDLO0sE2IWk/wpMc8MGXpSmZUf?=
 =?us-ascii?Q?SIODC697z9P8CVaaASZHqbsIzCL3n8Ecep5SA3dLbgGy7Pugdtgak6GPc7hB?=
 =?us-ascii?Q?Gtwyyg+mwEMCDkimOnmRno0xtk6XiCP0nuJWU0u3LJ+rK9of3jm8a1+s2gh6?=
 =?us-ascii?Q?Ng=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 068c6715-03ab-4655-54ae-08da663acf76
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 08:20:00.2371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gXIABgHYJVIzhALXhf5Dl7uJzkR81u4dC/og3py7WQ3x2Ud8bqhTFTwegwYM9HNs6EyepTX8EurFuDocNDARt5f2XXrXWeSz/TjyX7h9Apo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3282
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-15_03:2022-07-14,2022-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207150035
X-Proofpoint-ORIG-GUID: 3ghk2_kDL2RHEcU2MhPnD91_LP8Ie3yU
X-Proofpoint-GUID: 3ghk2_kDL2RHEcU2MhPnD91_LP8Ie3yU

Don't dereference "mem" after it has been freed.  Flip the
two kfree()s around to address this bug.

Fixes: 26ffb91fa5e0 ("swiotlb: split up the global swiotlb lock")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 kernel/dma/swiotlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index bf2ae98a42b4..78af9e455c59 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -980,8 +980,8 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
 		mem->areas = kcalloc(nareas, sizeof(*mem->areas),
 				GFP_KERNEL);
 		if (!mem->areas) {
-			kfree(mem);
 			kfree(mem->slots);
+			kfree(mem);
 			return -ENOMEM;
 		}
 
-- 
2.35.1

