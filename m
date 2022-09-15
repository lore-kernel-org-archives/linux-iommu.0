Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF2A33C5
	for <iommu@lists.linux.dev>; Thu, 15 Sep 2022 10:06:37 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28F7Tqhc012646;
	Thu, 15 Sep 2022 10:06:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=np09J9CS0uV7VSkVFcDo5RLs6qYfjZ1ZLle11tEu05c=;
 b=DsLHg7vsdk4jP/cvML9K3CopbhZF5cxRlVodOOZ0YWgltpsrjxa+01/rwVzcHZJrdb7n
 czHuLsNOROX7cDJkMXB2dGRw0lLTUBfU0g1cfYivuqNjGmc3fmoV+OFUlv5cW+HdWqzk
 SMM1PtrmuhN8I+Y69YyMJURB6x/qBSxNRnzILQ4ZBc8wN6WNzutKNcGPX5it94n8MGw8
 A5N4x2eDOS5tDBPXXRRJ+aL83fqrOIcdtf5Q90k+RDz3RdT+shtQHLXu7jMTWpi00aej
 d5LMNDiKfjD6FV2GwC6pRB5gZcKdvdQN+oq336t3kBOh5UW+3QdJ3hL4JqyQ4uv5TIb+ 0Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jjxydvt1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Sep 2022 10:06:08 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28F7qMN8002791;
	Thu, 15 Sep 2022 10:06:08 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2041.outbound.protection.outlook.com [104.47.51.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jjyejfv9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Sep 2022 10:06:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bFJWifJvPYVEtObkuuMmLvZJ2GiQJrvx/Iz61F+WYiBDlxT7w7/q8JffOLMBA+nXw9vqpEpYr47he+gir7Tgk5KFjzZfEOE0lSqQSSlDn2WSjb/LGkSx0eTT4+Dk0Ng7tm/dw2JZ3u87a7epyxBWdqm99F50grCN7JYLFbEdjczbWilwQGUHPFnLM2N+qrKTmLHssYfDnpNEtuPWh8dV8TwnCKVQyzmB5vZ1dzJXnZWJWS+4evQfP5XWNiBC+DqYg/B2imOw1/dRcWKsVVSwuU80v8o5wpHwYIzwszXPSTXlKMgIVkILsJQqusPlePWWtuFG5S4NtvNdiHUgHWxj+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=np09J9CS0uV7VSkVFcDo5RLs6qYfjZ1ZLle11tEu05c=;
 b=ekcn3W5HZHDvlC+JRu9xBn773M8i5HcoCxNCuVPLeaxY531z7ZxeYs4pvVC27GDyv5aMo05cwggfIi3vB/56svEhXAfC575INiqt3oF1R7ZAwiqrHsdJgjLxeE7JBlAnAIfHizIIyrklydcnSVbpeiUMoikcJsuIAqDAmAVPluQUJoQJG7Kpkk2ItQEC1KR9c7WHmfjYIQIHfXQHO5krbhOkILReps4BvmlLt3bkZ6w6aLrCqgBSYo5r56FQ4R1UtdY8JsqI12OIl5EY0xK2h3smv6NYSFqvCqmlWLYP21bXcBFbPhXwX+xTWHZyR3ud5tPB5mzYswTAp+pwFDHtRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=np09J9CS0uV7VSkVFcDo5RLs6qYfjZ1ZLle11tEu05c=;
 b=uH8AIIodP7kCByPoWwy6JeCUM9sLhbk9Hp3NK9Z611TjYv5KLE3zObeu2NyC4cntU5vHgrJCqfc8MuCktfmCTULcFUZVWhPqxdFJiUnRZXzrQRd5635MJPtls746S36TRlqu0wJIkSiOiRIRTDrO+VmAKzQa2Xr9E4yd5u74A/w=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MW4PR10MB5811.namprd10.prod.outlook.com
 (2603:10b6:303:18d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 10:06:06 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6%6]) with mapi id 15.20.5632.015; Thu, 15 Sep 2022
 10:06:06 +0000
Date: Thu, 15 Sep 2022 13:05:59 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: baolu.lu@linux.intel.com
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
Subject: [bug report] iommu/vt-d: Fix kdump kernels boot failure with
 scalable mode
Message-ID: <YyL5Bzy/QfUS5XDa@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0023.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::10) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|MW4PR10MB5811:EE_
X-MS-Office365-Filtering-Correlation-Id: 02b54ed2-7d00-453a-50ef-08da9701e7b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ohj+LTzRXOlnNRFg6awK5jNGgcBK33zwnYHvyFCU2Ucuiz701a44VD/Ix1Y2Cg9cVY7ZRD75d/0xM5IDPSH5dUnMVa5jmFjFbqsmhmXR/DRoruS1bB2LCTzx2UXrOk70CcRspj5RZNH4JydY8pJf6vA52NZshbNUR0aHz8pkWoWq24wMHVPnxVL3LzCERCI4IXqGsmrpeoetpHsJow7mpSOJPMcmnstu6btYkTR139PVpRuYMuHCs0RG4ZjUTposvbwYsVsXgTA/qzAVjQSIYtIyxdjeljK/LbM1Ob/Mu+5LvEcxpmcm6CkC7jqsK5z+WdlRoHX8adbOtgnZSLo9G43qYj1MEr0zONXV/nhaE14JiIeJ39RW9n8Xs4KOHMDn6F/E8oZ+4Ex4/gDZGwzEI0habTuod+DZqkV/FjUndGXLIfqf+rG69ArmCxYA8VXIVqm64Irgk0IFSf0hwBvgufN1GaH3DkSa2n3dPpnmGpXU9O81DVF9wGieiFyxMqom7+U5EutCdpsG1o+BqT/SJqI0Z75XzBSRHSCh451byMABatQna57C5AIzH2Bgc3X1uZpB1t9rSd2ajLibMqxWcsdGTXPE+tS2chQIhc8RWS+FohoeSba6WgwDX5JvH372s6s/OWVydcb19rhpJadXVOOwIWswu/hq0nOeyQWRbl6mG9J7qURxedhkqsCs014m04NjXeyqCpsHKuLhb4FXIA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(376002)(366004)(396003)(346002)(136003)(451199015)(26005)(8936002)(6666004)(86362001)(2906002)(4744005)(316002)(478600001)(6486002)(6916009)(9686003)(44832011)(4326008)(33716001)(83380400001)(6506007)(38100700002)(8676002)(186003)(66946007)(66476007)(5660300002)(41300700001)(66556008)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ocWTkN5RYGloxLG2m7OLRaGpd7bxj0x24xEfwWDPXiNYUyef3L4tuwJtxgVZ?=
 =?us-ascii?Q?thbL8Sqs+JKbz5R5KN8SrIxbx3DpxE+Vm3sPpZpiYohR4HochmuxEAqlWNds?=
 =?us-ascii?Q?8MZSAaIiqOEpSQAhuZjM77fkyG/5AzzSueuMzOZsNXECrGdCHlAEyh/FyCKX?=
 =?us-ascii?Q?zKJnq3i172qWXv66LdBelorpSsC5zuf1wGalqKKt8W0dvYxgKIvkcAOoNPkV?=
 =?us-ascii?Q?JRmIBRD+yyWRCzsBwUQTNuX3jsWKTiDtisTB2XsfL6bWfKBEfHgnY4b1voIE?=
 =?us-ascii?Q?6IFq2KpsU+eP+VOuKrWIENztYjuHq7n9DTeEnIIe9ugixnHEkOHuN6o22gEa?=
 =?us-ascii?Q?Ge2oYji2uuMsWUJfI7cIZT7dbtfBQ6iFaVSqethrH9+6YgyzngXSVzFqnPx6?=
 =?us-ascii?Q?HBnNR1JBL+DEVzP0NZYwJMVzHkykCCrZZGT07kQmmciJ1pRRPkH/bdbxyJj/?=
 =?us-ascii?Q?9vBYK3Y0RiyLzYP+ZTe8QP3+Jaqe56omtxsfTxk3NUTQ8PnNgkx6xJw8ASwd?=
 =?us-ascii?Q?K8jp6ciIuHeOSlM+i4rIpeVo+j9V41xuKXIM2ue0DCGKmpPDTINTlGlC8fTJ?=
 =?us-ascii?Q?h2oW9Xvza6VzGkRQU5iG/t1lg0UWwpTxSIHH0N+ii9XGXtP7Vc99Y1r7d2PB?=
 =?us-ascii?Q?IIcifrNzN0iuB3RHmdMGkOfyYeXTuyiM7t6f2riN+dfQVm/uhCWcWIl7em4q?=
 =?us-ascii?Q?t71qM3ayPgRi/lsUYLd6okzvoroLAYSQ6GSwbiENJDgXzShklbvIU/RaSeKw?=
 =?us-ascii?Q?UIldFCfUQAPCF7RU5Ny699b4rLj+TeH/bP5QbqEweKTKYs9NGzuOKkvb6Sb3?=
 =?us-ascii?Q?zcmjlkv1SUOzYmoMd7cqyFDazHBc9xMGVrgmR5jnvol7EuhaTXoFqBAbtOYQ?=
 =?us-ascii?Q?FLwAGLfkubKsYp+oK81L/XM4GbHF9rtQtWshqR8h20dPebnhUODIz6MpiZL9?=
 =?us-ascii?Q?htRyN9R24LGzxznlwjcgpHBfMSLeEGApUWkMlEOsKQUwcTKtScyYPTqyTDOH?=
 =?us-ascii?Q?YA9WAOIIdbzt8iUKZ1Xc3r9m87PuitWJriiqYeemplnf4cB9kO8yyERiNjSW?=
 =?us-ascii?Q?MKKB6VXEMA64mCz9YjEcgdeTxaoKYHzhZUf6X3HZC4yF8ioqlvHGMMqysLB2?=
 =?us-ascii?Q?EQruRRry2LiZJhu2jpbazpfXrDI2LvcKGOadlQCsaIVOSHBkbb9HxJO/8DXq?=
 =?us-ascii?Q?jKlyqA8pQd+PVnIO96LgSIWL1dvreUFWbtSuRGUBnfZqfmn7K908133fVTgM?=
 =?us-ascii?Q?8G3Oz5dAMKUNsM8UwzbAn2+CELG/Q9srQZwCcnxRtk4FRDqAR9mkruPH9AqL?=
 =?us-ascii?Q?K0s/z1COn5hyYDCE/hzSPeuhY7LFls85lwvow0P7XRjZHXc+DuV2DSO/9ayZ?=
 =?us-ascii?Q?wLyUdcZ44VZMgSUNEPN+gaGhJv0DbGJWfifjueziJAvpN7Mw9tgEJKxQe/JV?=
 =?us-ascii?Q?gDCaSq0CqBzj3kMG1JrToQY1K0sLRcNIYevramVhftK+0Phh/UPrUeMGEmcp?=
 =?us-ascii?Q?fFZiAEEzCuSR3fJ/uPLbUEu3ol5Bausjx07ezc7lxcHQXkd2iXWmmJlj6llQ?=
 =?us-ascii?Q?iDMectB5BfNsGtU+jjZ7tA4JZfjPu17rEAQCMvDLmCLpZri5PLI69SbbUU5C?=
 =?us-ascii?Q?aQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02b54ed2-7d00-453a-50ef-08da9701e7b2
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 10:06:06.5737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rG6zczAneHXJrbGKAIJnV7BGXzLLRIEv+DEEDtMa+FpjNxX6DrSgB0nWWNEceRXvHzgyplSJi8o3XFq5j9lpG+xZq4XNPcDHwDwqOVrm++g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5811
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_06,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=888
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209150055
X-Proofpoint-ORIG-GUID: IJLFiWngLsrrlz9TbGnky0nzKXhcLail
X-Proofpoint-GUID: IJLFiWngLsrrlz9TbGnky0nzKXhcLail

Hello Lu Baolu,

The patch 0c5f6c0d8201: "iommu/vt-d: Fix kdump kernels boot failure
with scalable mode" from Aug 23, 2022, leads to the following Smatch
static checker warning:

drivers/iommu/intel/iommu.c:224 set_context_copied() warn: set_bit() takes a bit number
drivers/iommu/intel/iommu.c:230 clear_context_copied() warn: clear_bit() takes a bit number

drivers/iommu/intel/iommu.c
    221 static inline void
    222 set_context_copied(struct intel_iommu *iommu, u8 bus, u8 devfn)
    223 {
--> 224         set_bit(((long)bus << 8) | devfn, iommu->copied_tables);
    225 }

This is trying to set a mask but it will instead corrupt a bit way out
in the middle of your memory.  The set_bit function will only set one
bit at a time.  If we want to set bit zero:

	set_bit(0, iommu->copied_tables);

Or if we have a whole page full of bits then we could set the last one:

	set_bit(32767, page);

regards,
dan carpenter
