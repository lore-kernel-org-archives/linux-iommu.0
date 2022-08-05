Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31816623
	for <iommu@lists.linux.dev>; Fri,  5 Aug 2022 06:37:59 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2756TGt1029372;
	Fri, 5 Aug 2022 06:37:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=vZ8JZlN/DxIDqv3NtHnwh5ktyx73cdiRraPMk/KUqps=;
 b=PKaTTsfTgalL+UGc0RO+0/HuDQTh8GriMoVt4QFYPfya2duIy/ODr+V+7PV4AT0xBkym
 +Gh/NNFsLAQDmBBOnHFLPRr+CatRNgcty/1MBf6rPJVJnoulrbvpwI+bw4QWBFnXE81z
 Vg8BWjkDkY1WpT1o9/hGa/WRmtwwCcUUcjsfo44+PlHESaYZ+qFojp7avAwdRA0uM6x/
 xuFG50issSOW3Po3qDeAmfcUImANxIqC0EuW8KyKNxiZzRf0qKdahE9fW71JM3KvwuYS
 WymEXfsKaoBNxpKAws8R24f/n1HJgzx3nZkKTQFsgXG9qIo/g4FZQsjnjQxoUhuqlmu7 oA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmvh9xjkk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Aug 2022 06:37:35 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2751nNmF003017;
	Fri, 5 Aug 2022 06:37:33 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu3535ks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Aug 2022 06:37:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EIKv9s5bbnPcaFGQvNSMt0ApxcBmype4yh7xVLnlL/C63LgtzcLYiaw8H9n8bA+KLRAJG2xnlOoXl9V6yVTLgMhHQyN6A37COT8R4U7YWjuFvq/E5hms5gzGamWXmLkU3QqsrXPiqCWv92rA8KGZPrHZdn4NAfUHVunsAcADFL8u4DuFx95ed1fl6760mCW2CuM3ACDJu1Bj1JJrg5MU9mIdBDZ18tMgoQ4m6Y9WjJOZdTj8MF2oieYSKrEFO/fgaq1SGjQg7dCcBjjUFcqvlHpZbRVKmvQ977gNtzA0sSO48VhkLllelwtnecZXk63CnZ2Z8wVfvIohDOJ+d5a39g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZ8JZlN/DxIDqv3NtHnwh5ktyx73cdiRraPMk/KUqps=;
 b=gjMetP8zlahmWiL6b6FyLZEb2vjY29MM8pR9CiydROUSgi6Tuz2dJOFPnksCVEWlX8ubDRFjyFU+xN91oUhRJ2aHrCbUREYizbPbxTcVm4pXVe0Frnba65/CROvrjAsRXTmdbfFQZrvaeg42ZARDnBui2RZV9/TvM49BcG/x1LTf9HS3cJK7cpRszlAaRxIpL3aPgWH8op7eAF7P7XJmchsORWxfzZZTOFROb2CsQj6uYhem5uvM/glAmESbLNUjDFmGMg39t10L5+XUOd3wpcIemdfsaAihTX3KTxXHJECV5rri8/FXV7Fd3qos/O0fGM/ERg/HTTLle7Dpxko4TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZ8JZlN/DxIDqv3NtHnwh5ktyx73cdiRraPMk/KUqps=;
 b=UyjXXrWHV3qt9BsjcKc2DRPmROHXnGYLooUFtL0YIrsCpCNM5rIinkKg2cId1TI4bF1Rro+E6MtHUoEY6zUfs/5hnhm2y8Slh3ecvNRBaHT9xsfuqfJ2Tge+pSNDq/shv7nwBQpXzIWwcYzwRKRRyzQqRSXITSaquc3vk87fa9Q=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2270.namprd10.prod.outlook.com
 (2603:10b6:301:2e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16; Fri, 5 Aug
 2022 06:37:31 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5504.016; Fri, 5 Aug 2022
 06:37:31 +0000
Date: Fri, 5 Aug 2022 09:37:02 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Suman Anna <s-anna@ti.com>,
        Will Deacon <will@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        iommu@lists.linux.dev, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iommu/omap: fix buffer overflow in debugfs
Message-ID: <20220805063702.GH3438@kadam>
References: <YuvYh1JbE3v+abd5@kili>
 <90a760c4-6e88-07b4-1f20-8b10414e49aa@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90a760c4-6e88-07b4-1f20-8b10414e49aa@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0004.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::9)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e437168b-76da-44ee-40e6-08da76acf8c3
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2270:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	1aF+MIfWaKTtVrpepSIjlsXKZOUx6wZXgH3JTidzyUXFMOXrIfwpF4qh9dtOa198e7LiFcaUPVNl7izPEBvaGHj9Nabzh/eMfTvdgKhsZ9RPUTZf+utUzN0Eemsu5FZKgh75Ue0+2F6+HPWPi8nsOzYaohtyOFsPiiZ3UHnbaDot3rikmFiynFCglrQnTJrTTpYC7IimeV0exdURJnR5tI2S21fX0Wi5kpaVPKLPaalUXqc7KoN6be65bH7f75F2UiV5IQSgoeLX0fjsjDyWyqav09yMpO8taskjKNDnCR65ZumcwbyD0eXRb7eeibWQDeJswgbMB1AbM067WbnQ5R+4YRiNTVHeURx2jOi7Ali+F42ENatJkiya8ppWeayv0MBhQjXR13Ll6ZY5NFVeEU6rKq9B5C7V4eg5Jgq0iXZkBTRcfRqIxgtUVhmmubYgAyls7qOC58/Vx9/g7i4rXqTVqn9ZEfjVf0URrsvllX6abPvHkhU+tB/Rhz/J99QmGM6x59Zf6MF7h4isMk29+F3iLu49V2G9Z+MzZ/ZVSfOQueqRJPDHsVdo9futS0Ie92A89Cwc4996LgUWbiobOVtL1qri11OlgFU816wwZA84LzZCwoDNYDXj9ZXHdah6Tg+ui/l3mn11h8zO6uXfGxpHJIB1LJx397rwGeojflULlfwJu+2rcbtUJXHH/TXFk14aCkQ01odl/l/ZaAW+PhAQZQn2rX6w5LhLHkKNibWThG1BVmxzJr6D7AtzFFy2Vesd835oknup9YnC+hx9GKWFoCmExoOiGT2KaGxXzk0s7XlpJSxBr5BIxcKqBLnx
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(39860400002)(376002)(136003)(346002)(396003)(33716001)(6666004)(2906002)(6512007)(33656002)(83380400001)(316002)(86362001)(41300700001)(66556008)(8676002)(66476007)(6486002)(5660300002)(66946007)(4326008)(478600001)(44832011)(38100700002)(38350700002)(8936002)(186003)(1076003)(6506007)(53546011)(6916009)(52116002)(26005)(9686003)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?2H1YEqsBiMcaZsvRjkkgw8q3IO3jR3Nz9uV0+gp1yMYHkXL69kOy8dY5WA+n?=
 =?us-ascii?Q?uqbnzdcL56+qgmkNMmgC60JCct592zfcVtaVfPkQlQ35eRxJ5wW4oeqqtszd?=
 =?us-ascii?Q?+oplcEjguWXuFjt4gyrsi387rgOh62F5dTWyDc8a+xUTq6UtVnWDsdCE/DPT?=
 =?us-ascii?Q?GRk9nKzDFozyScMUIO8Sw4a3S1Iu7Dbs12ntunq7qzbk7Zb8SXhjThtU8S6t?=
 =?us-ascii?Q?Y0OUWcLuRV+/8KJyyVzPZp47QS75uQlSuhfTOEQAmqHC5WHa/fFkGzQ+Y4KY?=
 =?us-ascii?Q?ceTx6zD9bXOerjSprNwHHqbxZC7qUmzjdarjHj4HWSPrCNkmbkhzhzqv7oUH?=
 =?us-ascii?Q?7FfJVJAiO/fYMiMhdJnjWPEfAkYqnwfK/a0V7ECVvmkvtEo1TkOlmpqOmusS?=
 =?us-ascii?Q?sYFyBG7YDZoLwwNIUmkwPIYheU0SMXz5aQ7fF7iV3VRDYeN46qhmd2hzPP3F?=
 =?us-ascii?Q?I/cdYrModdxjvl+lxvtL+7mI/RuD3mEJ/Zx6+xeXYS7ov0hB74t7RBTFYNH9?=
 =?us-ascii?Q?mVBHAB8+1S/m4su5kkuFZXfGhqjMKvAnI/d3sSI3e53J5tbR+1dfa9QJDcX6?=
 =?us-ascii?Q?SBljIRpWk52Tj3KBGprmx7pzqyPT3JzKbm9xpQZXOkrxE7HDasuVDTb3Jm0T?=
 =?us-ascii?Q?1Tj1scvblDLS6p8IcxnJUhFxOTLQCczlquCZ9k+RDK+RFLbfO/LnASfydJvA?=
 =?us-ascii?Q?mAdEigqc5DhuI4Kyfk7bmnnG3v4zkG60Ecn22v/QwJ0iD4EH0g3GuK/Yt3E4?=
 =?us-ascii?Q?1HpyBlrzwkNaqp8r8+KmS3Kw5RrkTxaokAAlxNKQAKTZBTltL3vtk9sYReQR?=
 =?us-ascii?Q?DVDQmtxEuvxuIUETShxpExILLvgh0yCKeq2tpwoqX89TtJdc6pM7yUU6o22m?=
 =?us-ascii?Q?suS7Owylh/OwfdIrneJovUEx7VEH4BF6H5RPcXtzeZnxgBAGQa6qi+dbzOtq?=
 =?us-ascii?Q?Nr+eFiGXFaovGJePdRZjATcK4xWkKsfgGzayJ7YjS/LAweshZooQJx1WM5to?=
 =?us-ascii?Q?qMmMIgvf1EuVIxXreO9b6WlJ6msMUhpIXIXI5iqbtN2jGkXMubNpX9tFL1Dh?=
 =?us-ascii?Q?XQayA3zmu8pvSAbLjmVOsJXpylJMKPJCI7ny0Qnay9u2Eh8fq/unRIdrKtRY?=
 =?us-ascii?Q?gBuTHhIIFHdmQLJlYi3PaEDnUXRTVItyoUu8w+Mvtrt6ELuJy4brNgwiEB0Y?=
 =?us-ascii?Q?/V1jcGBtgFDaxMoUn29NmFxkVB2WnNnsbKweHCKXTUwhjUtdLwrUZ9ODH/W/?=
 =?us-ascii?Q?Bsl8l3WK5wK75XlKnceD35b+SKy2tssklVMRCwp+6sWbQjnOvN1sQMytyB7o?=
 =?us-ascii?Q?pat3tBUo4n4oo3/vpBvuFoLF7NBJu3yZFTZkmBfJReN0dAI9DAHA1mDqg1D7?=
 =?us-ascii?Q?1iN7F3lws1DnsKsq1sjphKGrKFYU9P3NO9Lotnc2f9R7kzhPmGTrCD6Qvcaa?=
 =?us-ascii?Q?am5UVT6y63OmlUzYiVglpSv8RnqbtPXZjcJZcepAyvkl02IwKI9UavreH03J?=
 =?us-ascii?Q?Z6DpCFJ/7dh0zUB5qDUBn9fYIgsJgXKz1IVF2nzVaO6E492XiXvtmqhtYBm7?=
 =?us-ascii?Q?wyPr5olzzfKYbY9na1ESFciudn9rGPQ8GiNHbJisbdfSqXyzkkgfVAvVKmcb?=
 =?us-ascii?Q?eQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e437168b-76da-44ee-40e6-08da76acf8c3
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 06:37:31.3844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fY/G2c7hvhR34Q+DoeJ4g34S/rKQnfJikEHJz3neeGAeHAB7I1SNm3IInL7gBg2ZFrfWZZqP6vcwDPtQLTRdKAJY45e6boS5JshwfjhwHZo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2270
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-05_01,2022-08-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208050032
X-Proofpoint-ORIG-GUID: -RH_BZsLgRQTpegr89q74UYwSkmU5Opr
X-Proofpoint-GUID: -RH_BZsLgRQTpegr89q74UYwSkmU5Opr

On Thu, Aug 04, 2022 at 05:31:39PM +0100, Robin Murphy wrote:
> On 04/08/2022 3:32 pm, Dan Carpenter wrote:
> > There are two issues here:
> > 
> > 1) The "len" variable needs to be checked before the very first write.
> >     Otherwise if omap2_iommu_dump_ctx() with "bytes" less than 32 it is a
> >     buffer overflow.
> > 2) The snprintf() function returns the number of bytes that *would* have
> >     been copied if there were enough space.  But we want to know the
> >     number of bytes which were *actually* copied so use scnprintf()
> >     instead.
> > 
> > Fixes: bd4396f09a4a ("iommu/omap: Consolidate OMAP IOMMU modules")
> 
> FWIW I think this has actually been broken since day one back in
> 14e0e6796a0d, but I'm also not inclined to care that much - 2014 is already
> plenty long ago.
> 

I don't know how I didn't see that.  It's like my eyeballs are broken
sometimes.  Possibly it should be:

Fixes: 14e0e6796a0d ("OMAP: iommu: add initial debugfs support")

Althought that's debatable as well...


> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >   drivers/iommu/omap-iommu-debug.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iommu/omap-iommu-debug.c b/drivers/iommu/omap-iommu-debug.c
> > index a99afb5d9011..259f65291d90 100644
> > --- a/drivers/iommu/omap-iommu-debug.c
> > +++ b/drivers/iommu/omap-iommu-debug.c
> > @@ -32,12 +32,12 @@ static inline bool is_omap_iommu_detached(struct omap_iommu *obj)
> >   		ssize_t bytes;						\
> >   		const char *str = "%20s: %08x\n";			\
> >   		const int maxcol = 32;					\
> > -		bytes = snprintf(p, maxcol, str, __stringify(name),	\
> > +		if (len < maxcol)					\
> > +			goto out;					\
> > +		bytes = scnprintf(p, maxcol, str, __stringify(name),	\
> >   				 iommu_read_reg(obj, MMU_##name));	\
> 
> I suppose snprintf is OK in practice since none of the names are anywhere
> near 20 characters long anyway, but I agree it's better to be obviously
> foolproof.

The issue with scnprintf() vs snprintf() is not the 32 character limit.
The issue is the "p - buf" math in omap2_iommu_dump_ctx().  The "p"
variable is past the end of the buffer.  The user decides the size of
the buffer so it's a real bug.

regards,
dan carpenter

