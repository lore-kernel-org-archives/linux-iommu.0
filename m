Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC18190
	for <iommu@lists.linux.dev>; Thu, 15 Sep 2022 10:44:48 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28F7ciKC005373;
	Thu, 15 Sep 2022 10:44:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=c3Bao4JjzXShI06ICLyvW6LgqSxqcM4UC/pmHJIkBdg=;
 b=bstttdn4h8mOY3MBVd6Vg2yfrWDfVoKvj+bYCmmyXCrk/RdLKolh9lMWeUV2XP/y8mNc
 5YkSPWJz9TpDwfza6Pb8yyadIyQmkS5XiY9gHVME6bRKCyZjMYK53KUS0WfeajNbdTYB
 6VqnBFep3ysyjAZxLxLGmfgJFgLuruF8hjwL4Oh7O9fJnfZ1RN7A0VdOAy4nGyCBIAUB
 RgKD6fTZXZO/ij0GaGrS0rGWuqZ56ue5pFoVsKeqyA8qVKKimLexFpYCiUxd8gKSN0jT
 /NR5zdB7iSGrPe0X9uYS2RaVELcard1DAyYFEPPqCFdocpX3V0ip3CWmQe9ekgwkUb6H 1Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jjxyccu3f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Sep 2022 10:44:20 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28F7qLmW014475;
	Thu, 15 Sep 2022 10:44:18 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jjym0ym0n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Sep 2022 10:44:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VlCkIH+kh9DCM8EQY1svm/GQRiS2o+byCPdJe7L+ZzpwoTLICjahlB5+/fR7cdE9zE/vWoqEYOVAhg9xXC5luAXCveYgIQJD3vj33UuyFWWhSpHVeM6iANIA6sujeQVDjDgwY6VpYveVYVIfL+cmuuKGzUvgD6isLonYI6ClPHwRH54OZe6gh9Vh79hKkSUjOIEywKuhjY6HAB623ch6GKwVoGgKxGOaFW9KTuZ3Aq1th6myB2jYsb6SEC6XLUpO14Rlahsbfr5D7SVP5QbJ+rlolJnywjbUG31XWMmAp05bFRK2RJmgxpw9pg6dhUPlMcfzpsVVR/ZgljqeyBdIjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3Bao4JjzXShI06ICLyvW6LgqSxqcM4UC/pmHJIkBdg=;
 b=d4aF6xW7T1p8Hz96JfKihzZ5M9zC8Qy8/7tyZYSvQ2zhlxkwCP7OnYwXGTyJ5bwuT5in/Q7G5+J4B3hH4IJFt2ar6oGbZHC/gpiez9cUvbK+sdJR2dxG0fi6TQvq6Hdumtc4FLphwmDgPyS/JXi+s1c4rkFV85z56KkOuvirY57F5k6Wvx1vGCW7Aqb5doocyU85ozWNmgn4BJI+9d5O4UCeXXh8CHLQjoKt94aPIQM6oXxZnTRZnxOKCb5LXOX+sXBF1AdQNI1ul6xJoUrIC4d9EEi5PAZzf7x4aOO7qpUIgg8Xsf2Le1fKTh8eRDxN6PXmzzgJNPCa76r4yYKdFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3Bao4JjzXShI06ICLyvW6LgqSxqcM4UC/pmHJIkBdg=;
 b=vdF02WGLGpoaBPEN0ccWZE+Q/XO4NPbyliIh896dM03NRlAaNLTBkgN0b0HburJ3OeYhm+juwrx7C+7QMzmKgUJLAWt7HHLNVZvBNAHzAIACUivKlHMr/eWV+/b8sJEoUe+trh14+isxhgHui4ueRMsdc9KXrIEpwd3alAbqlVY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH8PR10MB6289.namprd10.prod.outlook.com
 (2603:10b6:510:1c0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 10:44:16 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6%6]) with mapi id 15.20.5632.015; Thu, 15 Sep 2022
 10:44:16 +0000
Date: Thu, 15 Sep 2022 13:44:01 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev
Subject: Re: [bug report] iommu/vt-d: Fix kdump kernels boot failure with
 scalable mode
Message-ID: <YyMB8XxK3qHQtZ4V@kadam>
References: <YyL5Bzy/QfUS5XDa@kili>
 <b9e3f5cd-8888-cfc1-94a6-35ad54cd0122@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9e3f5cd-8888-cfc1-94a6-35ad54cd0122@arm.com>
X-ClientProxiedBy: MR2P264CA0074.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:32::14) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|PH8PR10MB6289:EE_
X-MS-Office365-Filtering-Correlation-Id: 99caf502-9c5b-4de9-e829-08da97073c9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	jigy8qyUN2Gn0PTtfsDjSPu9MuGhKjyloRp3pYiYHhxzNPdeV6GfofheXs8HGepXz6fXELmEnjTkF5iDAluT/oLsctz5z5OOKEkbV2F6KMysrfbbkDVYa3hr4JLnPXvUMwe+v9pdkTcLa5IXu1tbzTSIfmfEA3WBTDCOSlP9eICnI+rDVQSZr2VJeMFjfX3MIU20sjmMKY5v1EMt8H5jDgR8tsdOM10ntx/frmn3zGU4R+kwePUZvnY526k8IAiYYtUlSx3E6tH1In1NG8yt36R5BUa3zmEvYmaKs2qKugEzroJxtuPp4H0qG7PX/1YbY/QC37oqc9B+5c7SbCjn5hK/xBYMoa1UNxZg97rDBy2BMBiSFu/GkyPfeLz83sRlgghIcRODsbFvUAoXGNUc7q1OlOsCpl4UR+z7rmf37HVREkhZSW4zwBhIdtsJdH+4zgmFRGJ7GRN8t0ZeNitptTB4ThNF6KX3QRbZ/u1GfndaDiPHYiTHJ1uINlnU//xgiEAZxS3u9Ald8WO+QiE0dMdX/Jv3wHcXNb/f/CDosPZKlCXB4Hi5/DMbDGH+mHoNLigwPYl4RXNK9tVvDlk44ydHMdq4V+5nisnSvs36cLhMNm1+E+YVZUFbWtFVcfkj6r0xhfqUgurewxTiAGsLuO7gw03N3gR1Tn4jsuEW0MgH8E4SyUaWFfjQQbq1M73FD/thbXQ/OR+/d5E33OyUQg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(39860400002)(366004)(396003)(136003)(346002)(451199015)(8676002)(83380400001)(8936002)(86362001)(186003)(26005)(38100700002)(4326008)(66946007)(66476007)(33716001)(44832011)(41300700001)(6506007)(2906002)(6666004)(478600001)(9686003)(6512007)(66556008)(53546011)(6916009)(5660300002)(6486002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?5ijeQyNwF/6L0CB3n3+qI6f0kbwombvggORs0NyRI6UEEq5MIytRsH+8wWQL?=
 =?us-ascii?Q?mQW+bOl0bRDbBbEaH2M4+8qW73awTO9uR/MD+77ZT+BgPMg2WCFMIrKb1WCh?=
 =?us-ascii?Q?eBWvR3C44atGee8pBWNNHR4wOdH+UZByVoBfXTY+SY0brrAaepNtflYx2Ssi?=
 =?us-ascii?Q?JgkKLAiK/ukjiLLQEpoPpScA1sikIEPrxHurI8l++KqUcd9OY5SIAbfRdu4Z?=
 =?us-ascii?Q?4nt7aEDKFBSBY15qOLmfFBiO2tjYDV7FLUx0EAn++7CCi537R0pKrgNKwxQc?=
 =?us-ascii?Q?Y3nsIJmqWP9wqBMDz2H6eyQ2Ac9t3oH0SOc/ui4jNBzpphVN1h6K6ZM3Sbmd?=
 =?us-ascii?Q?up1S9SsEF7n+d7hcHJEkni6Rj6vacZSRfbZjVp8vw/KD9NvQFmfkm3XOQiA6?=
 =?us-ascii?Q?oR7fw1cTv44zZ67N4xbL6VpbPflZiqX0KVyeF+PJWFub5Rz2ZdtzjJUXIOxr?=
 =?us-ascii?Q?uDjghUC67cXzOpWbM8pFOVbO5/cgO/WMAezXwawy/cfAa0WM0e2Gz4FsPENS?=
 =?us-ascii?Q?Z+YXt21r4tA3I8b1EP6LYvv6gctEwR0WzwS63nTPAe00WwYZuboWWKbUgXSl?=
 =?us-ascii?Q?fER0cdXBsjRrsFKP1DvtaVvm69DzDpV8bU6fGhWTADMwwyt+KWSXlN/lX/+A?=
 =?us-ascii?Q?1fXqYr/jtj+nTFuOkmXIzx1YCqS0d/8CFAdMWe439P033Np7xF4r7X+P1Lo9?=
 =?us-ascii?Q?bUiF4BKWunOltYnM8ikJ4qiiLarMaxOKM7U2UTz9Hl0vn69I+8H4c9KqVDzT?=
 =?us-ascii?Q?PdAG6UIqCvzxfBTEvxYJSzapqAbHhRyNcVGypV0Z2TBNlNTOlOgxrtxZKbUH?=
 =?us-ascii?Q?WEi9rzAgIUyFNYivsbiNS7GIXNINBkLsTn1HqLpQRzxqc8neC5IXKbbPS1g0?=
 =?us-ascii?Q?05Cv3vpIwSjIGXU7JKmDkMbQozyk0A/eiYxYLjGy9vPXIo1WTmXOu2EYj6ku?=
 =?us-ascii?Q?zJNmrQqITuwPjwk3H0zl21sSgLMLeWccPQx4juKi3YBgJYaumtr2PaUbN0qr?=
 =?us-ascii?Q?sQMSuF+pWE0+C1X9Y5CgTyOuWZuZujNoT2tCAm53P95Wd+XjQOWIpiMPmj8a?=
 =?us-ascii?Q?Lqzc5+/Al4m7cKpoGuoZCBSLcDoIxysgvra57mBE0TU5/KP6H1SPDnArCe/M?=
 =?us-ascii?Q?BSguu5Xb6JuzVpyJcGVPUD298Rcf55PZ85AzIAYHI+FRcCPodVDuYbLl0P3h?=
 =?us-ascii?Q?OW9OOERL8a+8YWcYRLLEW6yHGuDoIUScMAQpcGeX69cPjOZ9CPFg0hm2GnqN?=
 =?us-ascii?Q?Z9EPwuYOQY6wom1B3l6XbAgxLNNota1j3LJIj6Pv4T/JvVHcn7VuYYTLRj0u?=
 =?us-ascii?Q?qQ1sBFLnyyTJf991XWuESVM/kyOmtvIaEz9OjwRXXArfANnJCAIGyB7wzRKM?=
 =?us-ascii?Q?qHUfgcDyhUTOzBASR8CQ/wH3HVkxR5lsuTxcJqDJKhUQ8VDbuR0jmJR83JvT?=
 =?us-ascii?Q?2eEvg5Ni2KEtvNAvr6hCMVk0Pu/UYzijCI3APwWMRaUQNLOZoE+1KeK0OryP?=
 =?us-ascii?Q?q8YGP9/LeLhzYcMbKbBMJq8cCVUwtBHJjFGg+4nXkcqn5r3x5SJB+5JOSpg8?=
 =?us-ascii?Q?PBTXnOoPGrfmP3xH0T19SkR6izY8rPsgQXFQZesXhHqMG33zRwgoveBPRoV2?=
 =?us-ascii?Q?8w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99caf502-9c5b-4de9-e829-08da97073c9b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 10:44:16.7980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J/v0hKdY7uFKRCnsTTMHP+E658ajwnnTiZvCcVVD7P4IPRfp7yuhn2Tod245NVfjIZSAMh9xJyq3k/KSHJiBdr7MhlQ09cxRfSSqqPeH8hM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6289
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_06,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2208220000
 definitions=main-2209150059
X-Proofpoint-ORIG-GUID: qT9vrxyeyzZxQJHClZRWVypgqvXG5bat
X-Proofpoint-GUID: qT9vrxyeyzZxQJHClZRWVypgqvXG5bat

On Thu, Sep 15, 2022 at 11:21:36AM +0100, Robin Murphy wrote:
> On 2022-09-15 11:05, Dan Carpenter wrote:
> > Hello Lu Baolu,
> > 
> > The patch 0c5f6c0d8201: "iommu/vt-d: Fix kdump kernels boot failure
> > with scalable mode" from Aug 23, 2022, leads to the following Smatch
> > static checker warning:
> > 
> > drivers/iommu/intel/iommu.c:224 set_context_copied() warn: set_bit() takes a bit number
> > drivers/iommu/intel/iommu.c:230 clear_context_copied() warn: clear_bit() takes a bit number
> > 
> > drivers/iommu/intel/iommu.c
> >      221 static inline void
> >      222 set_context_copied(struct intel_iommu *iommu, u8 bus, u8 devfn)
> >      223 {
> > --> 224         set_bit(((long)bus << 8) | devfn, iommu->copied_tables);
> >      225 }
> > 
> > This is trying to set a mask
> 
> No, it's simply composing a full 16-bit PCI requester ID from its two 8-bit
> components.
> 

Ah...  Okay.  That works then.

> > but it will instead corrupt a bit way out
> > in the middle of your memory.
> 
> 	iommu->copied_tables = bitmap_zalloc(BIT_ULL(16), GFP_KERNEL);
> 
> Again slightly non-obvious, but AFAICS the bitmap is sized appropriately.

Btw, just BIT(16) works until you get above 31.

regards,
dan carpenter

