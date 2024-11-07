Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C083188CC6
	for <iommu@lists.linux.dev>; Thu,  7 Nov 2024 20:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731011033; cv=fail; b=CbIkzowi3LgloZm3If+RrwTZHRn7L0JsADRd5pZ77ojcPAwV1ubgcG2Fg66CVDC89gkdmH1XJn4Usbf+KHIPw6kMbInO04qSTx8kdfajeidJSUfX0xgbH+IbnH8QOlz1I+5JuJvC94XT6kvOZsZfDr+OYoybsM5Bm/ct2Ja4J4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731011033; c=relaxed/simple;
	bh=UYzYZEjCasFD52dC6ZQlW+Apf3//8hYA7X+f6jXfVK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ja2aNdlHCrfOZ/iR/V3BL/t4Wjy8S20NN/jWE/o/3/x7psfWEjDERGi1kStAM93BAeU6JlIY0K5Q8mYM5iZECnJYSlBWzloNVudus++IFoxKK+HXA5Pxuv5Od4/6D2ECQTRJjnDpoBJu/A22hkuvy1bBx0a75tulASrDzfh13OY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JvCrqWC7; arc=fail smtp.client-ip=40.107.223.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JvCrqWC7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZMU5cGFQ2YD0idJCE43TaoM/PUu/LRVJLTG5Ap8UgWWlNFpWMsoIwfhaS3+CeEb3JGFZeK4M5Uum4tQHiulz5n26VyaxJeYALxKfLws/mVuwzpqbtLqK7rCqtZEKnwYcVj2GyBc2vcoMnTTUSYCw9mfDZRdSPgDtZXsqIClhXwEvomeLE1e8xWy26U0tO9qb/cwNDh+23IC4X0w8vLwwJjIjkbm+DtVnupFiSRuonk1BGwERNL2Q4mqXwy686MkR0++WkizhpshJYocV2HNxrv1w1tGqCM2ZO56CBsTkqx8uxKK38yPZE/R1vDPA0zYQ3w6ew6in32U664iZjZIMZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWOF81g/YZzaFwsZ+cGds56986x536gYXC12cGOwJ1s=;
 b=Gz3XkEsQpKnJjd3ce6ZOUsBI1ZtIbQIcO2H4+qPg9cqeljQ0XZohq5tFeMIs0r67o+Fn5oMtWNYiuUyN9sQxb0n/Yt3emMpP4L510de0EGtjuKHtthhZajQkLkOy++CfwxQ1gGuR/1n5mScWO9khTsZqP5BNNIHQ1PqkNECI22ilXOfQIYMqtuxqdIiuBxh6Z1/cILI5a6RoCl+2ao+uB/2KPv3dsvE+kU6ISsnOKkRGqrNtstWSFsYDLz5Z20eunNzm5yCM67nPWNA6m7dp5VSIjCjcWC9Khf7siG9uMfZuMgVfK+5Zi0H3ruKafd6/xWIgxx30BjbNj0K0gn7iYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWOF81g/YZzaFwsZ+cGds56986x536gYXC12cGOwJ1s=;
 b=JvCrqWC7hqUKz60ig8pOCDLMrShI6ATn1TV+CR9Fkwt4WirzRsbln+SjtR8nxEmNVy/BMu5haMAiPkbgJH/boc3dzX7B4UykORO4g/OW/yuqKSrU8Zjs5leYCId9APSXdiy445hYN4UMGXGRNr20HhcGA2ceY7+RN8j5Hjq++J1+A+rzKsIFva8E+7jqdkvs3cgLPggz8hEfxtUC+1ri/wyzZVwTyr+NVaDNjd++vF50hlp3wtjo50SpC7fLJIq/ECh+baJBRwh4m2EzXEZI3X3js5KGlKHPu3pCSgs+AUbE/haB8FMua/tDJgoyCWXaYDi0quBjVyyBY5a8jtsSXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM6PR12MB4299.namprd12.prod.outlook.com (2603:10b6:5:223::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 20:23:45 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 20:23:44 +0000
Date: Thu, 7 Nov 2024 16:23:43 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH V3 2/4] iommufd: Lock all objects
Message-ID: <20241107202343.GE539304@nvidia.com>
References: <1728321203-189608-1-git-send-email-steven.sistare@oracle.com>
 <1728321203-189608-3-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1728321203-189608-3-git-send-email-steven.sistare@oracle.com>
X-ClientProxiedBy: MN0PR02CA0029.namprd02.prod.outlook.com
 (2603:10b6:208:530::32) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM6PR12MB4299:EE_
X-MS-Office365-Filtering-Correlation-Id: cc127c60-f927-40fb-5dd3-08dcff6a1400
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OhZ8RvUhdnkwow9G4T0Nik9ys2SVCq0Xxa4ZJhQBuzJbKx9mux2hpZH610Zt?=
 =?us-ascii?Q?z7ykQAck8e4ZjqUiQPV45GS6KnkqsvFmLz67kDN5BNllzOFStw2EC3j1LnRO?=
 =?us-ascii?Q?hP/cl1VABYWxnQYVfkH1mGZrO5oNUUQTEfaTZMbqhRfB1Sxbh/QtGd3cX+kT?=
 =?us-ascii?Q?F5nQTm1vfajgwrCrtI+95opj8tHTqM+8mQOfMupu5YeqOKVdMgIwI1csARcI?=
 =?us-ascii?Q?IomRtwGAGShwrueZx46hv5ftJKwVxg911d7if2SAZndAGZUkmMpd30n9SfXW?=
 =?us-ascii?Q?Wr0LchT8cg8q9hzChEuaDteYtqaGLPlAIrNfl65Jr0c3fSbRlBwoUQoYJRua?=
 =?us-ascii?Q?ljrklz1bTCqPwqpLrVo2mVfjmTf1aFuJiPz2XbnwsVPtYYXHe/6etJgZdffJ?=
 =?us-ascii?Q?5OHT3Q/ooDrnaKxdl/ytil1RbgvjAuO4WwDoOP5bj8rwUyvnfpv5SKdQjso2?=
 =?us-ascii?Q?9gdBxi7/+3UArprLoRZyH2g4MpLQ1MMO9VzxuIei0V+ptc/fbuvGVX6LjRyR?=
 =?us-ascii?Q?vmL+2BlVKdWexVyoi3MgZ82zPiOPH3fuWLKH9CUcIJzprGrt6JB6SvBDIxCn?=
 =?us-ascii?Q?jGOgZvZVGjhGYtyXY63qXZlHuTVSn+j0YRIi6XEpKUUJHaVjRJn21rP3+8Sz?=
 =?us-ascii?Q?SYOB+90PcYLaXzXIN5cpMyQcnLz4xKvdwLR5RISuvX5ELBl/rg4jtx1x1aiP?=
 =?us-ascii?Q?fw8RnsgQKihPOQFj/N9Z5OgKMmPCUhUhfG/oAlPcAsKsfTFJodMykqhz+XCe?=
 =?us-ascii?Q?GPHxUkBcSypA8sm2MHFmqnrSdhJAjWIisdTXoPKPrhFNas5m3NPJcelVpMrk?=
 =?us-ascii?Q?5uc1/ksANg1EX6eZkfHQBvUctMBdQzWIFk8oACxEbL4rVY3s7xQFrxftEZ7C?=
 =?us-ascii?Q?u8cxFIhBjG1CBJGorq+00VANgwRuFaWh3azpdyenIR3dgi3z/dJIq6MHobj7?=
 =?us-ascii?Q?ZU/T3Hw8cBMGkPVqaHq15ohDJuAUCsKyKNXJtj3+hyGzbmuZqsubfLN3BHsB?=
 =?us-ascii?Q?DpLdcwaC3wOTBgl4bKxMDy6AyXDxGpOnPvyaAej1ELEVcABGcMk/KDCmW9sQ?=
 =?us-ascii?Q?E2RGxJmiR2aXjKJnYEIGnvP860aX0qjlnQdClShucTPUXYdctbY8szixtF6k?=
 =?us-ascii?Q?NiTOzejRHkyFGBRqYX3YjMfFvKrWPc0T61zZh+mznVbkiHT9I11y6dMco86Y?=
 =?us-ascii?Q?MQb5TJCQZ7CggAqQlTPof+vWvt/awpvOfw7rXHcWbjButKDN4/Uw4Rifbokp?=
 =?us-ascii?Q?WXpQpKJJEY7437l1j9vj+DbCwRlROKIVp6IJ/kapRmLUEyCZVQkT7a8B75V9?=
 =?us-ascii?Q?te8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TI0FZh6xQ75FozWvzVEtKIl8ZuWnAVPt0lAe0SyfnJSiwceuOuGjmR3IhMi5?=
 =?us-ascii?Q?+U9bZ6wu6Y+1799dJYJeY+O6e/QJmGPD1JOicNMmupBUMCYUnsWjAvR23X/g?=
 =?us-ascii?Q?ZFu0jJ2k56+XNGgUjjIMKSDTPXmUfA+Tjz2nADIh2qmnMPtkqJcrSh97QdUj?=
 =?us-ascii?Q?zcuP2yQFnEqrt01YGwljcwOjN6scySzAIn64g8t1bV6Sp+Z9G1zon/klEckT?=
 =?us-ascii?Q?RZrs+YTSO9ZLdkeMs7e3Va8zJ8t5ereZT+TFp70IkaYIR90HUX5PX+y7lhd9?=
 =?us-ascii?Q?eLLxe0bSuBtOa7mZuHPCFdFUL9UfgGIPX8hB7yjfESkAkUm75oNe4CmYEXlK?=
 =?us-ascii?Q?FNbAnZaUDuUR0zBZ5JIzO7sKslbImGIApTKrARBa4TIjM7PUgnGlab9x0JiU?=
 =?us-ascii?Q?jZ0aolngc71PKRy1THHnEgRD5RqLaFxUa0QgxopTaNVPsalPpVQUuYRWYJvP?=
 =?us-ascii?Q?IvWh2Vn6MM7OV5S5Ue+z/MkMDzyHctVQLckeW/FBerM+I0SIyfvs8XuFbCN9?=
 =?us-ascii?Q?8YcXPDzryfEA10TH6HsG/kwZx1tZoDE/8RRsWFTgD2mqpi0ZCNRkg0sKwfwK?=
 =?us-ascii?Q?/D8iM5jcE/canePfHCknhYrnS8JNr6uaBaYeWyq0/1ZCONIlerAFeBfsk7G1?=
 =?us-ascii?Q?mAc1LcSMdRv6KpH+5DGcL+HfnDaPXW/YvyLTil/mFs0/0rf5ujt0ZdUzMVGZ?=
 =?us-ascii?Q?MVsYOX/8dA6dTnhJ2Ew+UgzOzKJ6Jh21q712E+uS2T5BA/9XnKDsxfUdAhLA?=
 =?us-ascii?Q?BiCufSVwtreXQs/HLBSO47DYbsqLjzTuKmTl5OS72rPwlQNELH4LLVsYNZjF?=
 =?us-ascii?Q?fDVrlp9Qf8tTQffUMHqiejFFlMwXeGdfLBhQ8vGTxsbq+9CDK+bAfAWclGlZ?=
 =?us-ascii?Q?4+ApIIlBFpwNLwYP/jfHC82uKLjjAY8XCeJzHkpd3aW+RPycpToAgV66c/g8?=
 =?us-ascii?Q?wvZ4Pv5/3kYzPL+mW15rxqBeyqhE1oOqevc3sVl4+2RoFFVUnHetFAQ8guPd?=
 =?us-ascii?Q?W+SLaEOo9zjKzTv2UjggiU/MtpVcZnjsUrOma73qoJDYT+l3Mw5SPaoH9baI?=
 =?us-ascii?Q?u7epUHDIfQn3iU0Bxtzyrmnv1bQCz+KNSfx6KqL1+tibl/7Jsb+EM9Y4tWtQ?=
 =?us-ascii?Q?/5D/PwJ9pLmMEQR131QHn3FKEeN0o3FG1V9lyHQLxV9XhLNyTdIjNNg8IuAc?=
 =?us-ascii?Q?+YS5QjHkJwzuovWbDseqQ1XvWSK7wWSZchn6qh6gZGtliSPs5zLHgx33Ylhs?=
 =?us-ascii?Q?h+oirSpTtcZFoXmNDd6O3si3r7H94Vbf8sEod8JuCWmPExknteAUV4/+FW53?=
 =?us-ascii?Q?5a2wFbRaxrU4TDXgvjhoERY4cTRfu61b5w4SR2uYHPrYfqH+bRXC0kAoB1oW?=
 =?us-ascii?Q?/f8hl16hcQULuU+LBOA3dATJyp6rJyI+FpTlEMa26mqHyt1GKwJAwutjWER9?=
 =?us-ascii?Q?7qBiHGhUBru+ap9tRDFkJUwdmkKQrFUEdU2tVf55FGsa4O4ReVvQeWQGyFob?=
 =?us-ascii?Q?OBAxlMeg/RTo0xGhOsDWU2jYTdTfGeh30FujikHItttErpBf3F34L8Yhl4T8?=
 =?us-ascii?Q?ByPSx97x8FM1g8mihwXlaOn9iqBB0qwpMeJQM8hb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc127c60-f927-40fb-5dd3-08dcff6a1400
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 20:23:44.8367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q3hu3HVCWMAz4bEtHvOOtG2NFNFqTrcfr5Us+Xw1A/l8g/j6XteSAxkZMkOemhZm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4299

On Mon, Oct 07, 2024 at 10:13:21AM -0700, Steve Sistare wrote:
> Define helpers to lock and unlock all iommufd_ctx objects.
> This will allow DMA mappings to be updated atomically during live update.
> This code is substantially the same as an initial version provided by
> Jason, plus fixes.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  drivers/iommu/iommufd/ioas.c            | 65 +++++++++++++++++++++++++++++++++
>  drivers/iommu/iommufd/iommufd_private.h |  1 +
>  drivers/iommu/iommufd/main.c            |  1 +
>  3 files changed, 67 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
