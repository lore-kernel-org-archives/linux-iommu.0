Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A231AE846
	for <iommu@lists.linux.dev>; Thu, 29 Aug 2024 19:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724960051; cv=fail; b=uDDd4t5nxCwkZxoCpwPZdWwcrO0O0jbDvNIv1Yweybl4KwXbapW63ast+7ffA9XYIs5jCKKd6oRkpTe3fwli2QYPHwzyov7Rzr5voZLmg5XpxwFctjzQP7vpb+dC71yahbbatpkT8k5JC/cjhYJvFtl9FExJ8nhIiK30dHQue9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724960051; c=relaxed/simple;
	bh=yG/jktytX/TtbL9DbTObIarBZJClo61L5vEfa3lrIF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cNuTHtLmlE6TO/QrrTTjB87PCa0QrlES0o4fGHxk33pjRghQr4Z2SqQ1QnUwjvxeLTeu1vJYOS9jjUolm8t7y0W6MKyd13fd66TlZggwb5VOU6Cxr4tz974L8MGV9Gnet+zqtVYtrfXCMxiro2cBjbaTHhlxUU/4ysakg5vVuTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pgsS2kku; arc=fail smtp.client-ip=40.107.236.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pgsS2kku"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wQGuQdf1LWFHNKWC32GIM23ykEi7K9Heq0n/G63atkP2RaibU86NIzXvQcaZ4rZkRPmBwLGkMUZjGk5o9/lzFqgm8JqOAFbxJ/4rX94cplmXMHn81IQQfciS0Yn6QJ6CYakwnDEeaX3HmyKNdaavFt6qXThqUvEF85zdjQqSShtkyzwEUpIwm8ItA+dztvblWyqvu73eUijsWImyGyid+Tfga6IobRbjTbmRDCbckf2v2bjkpjGoSCGIa5SXMlCIVQ1d1dPr/EZA4GnifvSq7uSU4QKTu4bmHElg0lDrFM+Ngu7XX0GIW7WIm3IOM1+wsTzrX1xuvxVxb3Kndo+YLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wAynEQY+DuIu41b+AjOPfk1wxb8dC1XcOR01qwyEymc=;
 b=lQMU89Uke46q9PIdE9FJGFbzur4ntpVVAVOx3RkKaYoF6phnpralhT332g5AyJOQ+gM9S0LmelhYrIZLXOVdK0GjjMBF2P6V27zlZzaQSJuljUbz4nr7LAy5tiq0/wi/Q0CTcmvQb7VovkiGJnQxHx1JLHjKupiT83AGP6Q60927tPNAcuN1ujB1KGRqqUxlcceBX/vfbfUxnlsmG0yrqTOeWxtcL7u0+2zmLhsMvv1W5u+NObsmYX8KFHGStMaSB9UUA/dUQTvYOFglgmlCWkrrC6Aq4ycIgxB3HHeBWmb4kFgQC5bFKbn+KIl0xjLkPX9bvUfX1PbnuAG22g4ZKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wAynEQY+DuIu41b+AjOPfk1wxb8dC1XcOR01qwyEymc=;
 b=pgsS2kkuK58xXOBlGBWfSqCgqPf2KOkWx1sY7vudM487kZT4b5HpU/cOUeUwyi39H/9SOcLXoMshhdSAZGUX0aowR7zhlXqaxSEHTUuhEE1ypOADyOORy93ZvGzwr053+95XCqsD6AG7fSldD5M7bnhc1T34BP9oDloiaxQoP+WldzIPYohg1eePPFMEFbm/AnGsco/niIBYQPwUHyIJHTrhh3PboYmELJlxtG8hxhktXxqmjsJU8Z9JwnuX8SvC5BTGxajGfQzDZN24/gi/ZvaROhWskhqKzfFUu3r9zBBJDEmp+U/3F+nSGH9Q084D2XWUQPL+VXGuzzBy729+tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by MW3PR12MB4459.namprd12.prod.outlook.com (2603:10b6:303:56::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Thu, 29 Aug
 2024 19:34:03 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 19:34:03 +0000
Date: Thu, 29 Aug 2024 16:34:02 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	robin.murphy@arm.com, vasant.hegde@amd.com, ubizjak@gmail.com,
	jon.grimm@amd.com, santosh.shukla@amd.com, pandoh@google.com,
	kumaranand@google.com
Subject: Re: [PATCH v2 2/5] iommu/amd: Introduce rw_semaphore for Device
 Table Entry (DTE)
Message-ID: <20240829193402.GK3773488@nvidia.com>
References: <20240829180726.5022-1-suravee.suthikulpanit@amd.com>
 <20240829180726.5022-3-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829180726.5022-3-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: BL1PR13CA0420.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::35) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|MW3PR12MB4459:EE_
X-MS-Office365-Filtering-Correlation-Id: 2db26d94-bd8e-485f-f122-08dcc8618a29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xPsVwlx9SuTlUCs2XXO1Zl+Hi6lk1nTgZjPdwtUeMIeFUIcG3K3YJ0S+IBsP?=
 =?us-ascii?Q?NilX6I5ERcb1ygsJEKdt80mKcGZMM+Mo1W+0d61InqRqbE28iMOBSfVbdhH0?=
 =?us-ascii?Q?sKSX4i0820to15HADj5lV2bNcv3gfgJsr7JIJMukB8pIJeP0Oxgpob/HKOws?=
 =?us-ascii?Q?Ne0lQe0v9NcXAuiHneLif7V464gz1FMy91/Jo4l6RGeJduIlu307bG6BXY2L?=
 =?us-ascii?Q?rjFgzKfz6GBKqBM0ny4KlXZUQkM2PO/OqPR16IUh1TThHk5H5UXXYzzkGyOa?=
 =?us-ascii?Q?CEUkaDREwdBdh/dA3FncwFGKmQT4d9D9sASIbyAUylwAR1CdZRt4SBoL7+2M?=
 =?us-ascii?Q?/y6+66ZmfGanrL/t1W+rT7SbMJ+y2atUWJS/3TCBs6QEJPVJJFEVzmesrXHe?=
 =?us-ascii?Q?4qTL0bxJJMNjfEWlvEHbcLhSqQIfo7H+1FIEG1GAXoNIarHck/J2PSsXXrgb?=
 =?us-ascii?Q?v/hEEGsi6CpOJ3ez8ns4Qz8CuxHqoyE7nG5e+aaKiBC2wX99/D/5FDgJ/ihd?=
 =?us-ascii?Q?ualTgWQI21DF8DOde2PKCOzf1E9DJCYDIWVIOWGFExiZyE9lD3QTBsTa8NQm?=
 =?us-ascii?Q?gZ5TyfUlRHNbQ9BCI/tjLLXUaCQmN7gTEkG03xeiliFp1pIqROisu0YHulmE?=
 =?us-ascii?Q?KA79MIr0KLwJYNRNDzm8aCHJPYsMOKFkmMwHiTmYW5bu/ElPlpA/LFobHwQg?=
 =?us-ascii?Q?VokVsI5bL+HFnl7zk/OnTyFflUthOMeNs5frBaUKZ3M+2Jjl4mF9BM9pS4cR?=
 =?us-ascii?Q?Fi0hzMUntldkm8Y01sjMKdFcqcJnuAZuJ/7a/RhA74BSZcM0WSFOy65eioX3?=
 =?us-ascii?Q?UWsDOyZ9eBn8R9dCg3Jsv0Mg3EqcIa1RHTwWLoFDlKJA+x08xNfpiXvG9ZsH?=
 =?us-ascii?Q?t3thBMWjd+lVfKpBgrIxUSXtI5UVYIcUGofLQHH+weNlv7qlOJ+x5FYAJTUj?=
 =?us-ascii?Q?KdQ3NplbR6JltcxQ615cY11GbmlaRd9se8fKZcfaDldmWNGpKFdYs4UK4gQs?=
 =?us-ascii?Q?9mC5TBcB//K/2J4uR8vRdUDI4yvaNOZHJ+qntSiQ6UlmbHkbSBNIyfwhWDVz?=
 =?us-ascii?Q?UdHrAO3kUIlq2G/M2WhAXPamjAFuQk2m2u1HTTckJ6IpLrMFMd+STpJmIqTx?=
 =?us-ascii?Q?l2FIwhrD2kYYCHVsxQvyujDCRFZ9KpeUfC8JrptSaz1IpEtqJ8NV5Q0lNMwk?=
 =?us-ascii?Q?+hx0KmapHByGCbWFEZs1/MlJq2PYfFxBACngRCfcV1MLRUheCDs9vFK7HRC3?=
 =?us-ascii?Q?u74sRcUjXP0hhpSsBNNLUE3HDWL57Zma7NR65i9so9hWVrYt2duBISdG/ZVn?=
 =?us-ascii?Q?vy+V9G19HqPnIpde6A7AMk59hcFK4PfLFCBhnonKMI0wlA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bBwh5XwbrK18JhmfLJRxVyPbokAyIcTU+/UDRu6lSK1UJtcl0uW7s4XZIxuC?=
 =?us-ascii?Q?I+Ume2HZkyTTdgxbth/6KUsVZAPDlIL41Bga+swonc4c3kTMMgjoQ/HJoHhI?=
 =?us-ascii?Q?lh9rrxTBfG+HI3yntFhNZDq9pd9pk+AXhjqa3FAGuBwYgZq0EdZZcEQ+2OSv?=
 =?us-ascii?Q?+fLlEdz0svHwoXy5xRdLi+hzrwpOWKkEe7/TbWM3K2ivtaZLWFhwxI2LCwx1?=
 =?us-ascii?Q?3bzb+wIFslAf7bT8zJ2GPGOGAfwzx9k6I/GnNuCsNwQqXLLNazzNKreXC6CD?=
 =?us-ascii?Q?mmp/tLc4612jwe1sWFAWa83a6ofbWFP7/Wx6f4aRZcRK3E8O4SCdlXrNKLSc?=
 =?us-ascii?Q?/8B4znogPUhbuaZCCWCxG0Vntihl+NlUKuekzifHB8+/RKki1zQCksYki51f?=
 =?us-ascii?Q?iDBeAnOZtDSzUvrrS+CEXwsC6NjBJEGeDeVLMBCLJ2OCjx3RB+FYg4RtyRdm?=
 =?us-ascii?Q?RPtEmc80kss/ptj6Q0qlo+eiXf8QsgLjhqdBN4gwKYVxHFG8buQhomBV5GAb?=
 =?us-ascii?Q?KDoeSokrdqqvOY/dMspbKhDcnkZcgT+MjSe7JblIZrQjuThL97ZPqStwbZL5?=
 =?us-ascii?Q?0XXZt8n13IHqgFuFnlBxzYbbvq8EDzw0fwr6GLVwUgOOvsMSLl9y1vC32aFl?=
 =?us-ascii?Q?jwDlCbSdGqGsP0GBFhIjwoyWJXNDkvlqTtaSsoXmOMKSV3EfCQsJ2DNbNlmu?=
 =?us-ascii?Q?rrUX4EWIcPAxrja5hQUBVbF5oNGGG5lxvwJBtRslDXWI9pGZ/tyOgS0j1MwF?=
 =?us-ascii?Q?om/YCFr6O1/r0UtUXWjhICPkiCkrwylCxvDyf0wI+HpR2vZjVUAtBXyazDPX?=
 =?us-ascii?Q?nnagF4IKc9isfEtHt6RQ+oIJswaGKqAZtafEXFCl0GEcMEmjsoI0JJGmerbH?=
 =?us-ascii?Q?FQF4qACmGnEJTn9uCuPUZiyTZNf3iZypzL+Ey4i0zALlknCNJOPoJjf5L6N0?=
 =?us-ascii?Q?7Eve3uwnnP07Djx2wH0GtIsz3WPj+/nBl0GBjo2dXpZUlV69fLNZZ5ss+Lk5?=
 =?us-ascii?Q?L6syJllmTeSEzgorHjlwpLN3r7Wv33VkUIJhgBhDmWX+MmKAtuVcyB5JrmEC?=
 =?us-ascii?Q?ZXDJ0hna26j2yCsqacNS5J66IEIeJLohqm8YvjLzN/HcQIljR79po+aHKgAN?=
 =?us-ascii?Q?LgV7y+focxUTtK8HIICVq6HbwEBDP6DlW+mF8PgMnCm+xwwz9cEvaHTIP0gG?=
 =?us-ascii?Q?CnYjfF38it4WGWlfFn4NOQzDFweTirIHdLG1egywuzpNF9saD9B1neZGiTyI?=
 =?us-ascii?Q?BKMdx40WaoCCRceK0Yy2XhKJOfIUB+vXAuCVCQGfnaiQ822ELwNpcUrMHJB7?=
 =?us-ascii?Q?vMw/COOzA41aTof1sJMmRnIDruJpLCuX4S9DAVOl/RX1bdYlYf5a8sBISBD+?=
 =?us-ascii?Q?WauYeLpUY342Saeib8C3IyNUx5WlPFxtDAxQS7VE1gRNGvNWfr8OMDdLy0wo?=
 =?us-ascii?Q?pdOYkayRV5z+UNCkoTQlPXy9CZXf+8mMdTS0lqsnFGbhtefPG1W4J8wgEZ8i?=
 =?us-ascii?Q?B9CUgIdFqSBawJHDXuhcH+A6yDcddjuO84wz1c8ibu0nRPMeoErCzNJqxCnG?=
 =?us-ascii?Q?fwJkxKsCE/OMbZpxyX/dpJvbdES8DVGne4ZEKdbK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db26d94-bd8e-485f-f122-08dcc8618a29
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 19:34:03.6445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y59RYwfT/Sj33r1ut0EnMs4941+ZawlZsnUh8vmtaJOlXF9ZBTeop8g5dBu0Z96H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4459

On Thu, Aug 29, 2024 at 06:07:23PM +0000, Suravee Suthikulpanit wrote:

> -static void clear_dte_entry(struct amd_iommu *iommu, u16 devid)
> +static void clear_dte_entry(struct amd_iommu *iommu, struct iommu_dev_data *dev_data)
>  {
> +	u16 devid = dev_data->devid;
>  	struct dev_table_entry *dev_table = get_dev_table(iommu);
>  
> +	down_write(&dev_data->dte_sem);
> +
>  	/* remove entry from the device table seen by the hardware */
>  	dev_table[devid].data[0]  = DTE_FLAG_V;

The rest of this function doesn't seem very good either:

	/* remove entry from the device table seen by the hardware */
	dev_table[devid].data[0]  = DTE_FLAG_V;

	if (!amd_iommu_snp_en)
		dev_table[devid].data[0] |= DTE_FLAG_TV;

	dev_table[devid].data[1] &= DTE_FLAG_MASK;

This should also cmpxchg the whole 128 bit quantity, you don't want
the HW to see a tear on HostPageTableRootPtr.

Which is back to my other point. Don't edit the DTE in place.

There is no such thing as 'clear' in the iommu domain API. The DTE is
either PAGING, BLOCKED or IDENTITY, and any write to it should be
writing an entire DTE for that target.

I guess clear is actually trying to set the DTE to BLOCKING?

Also no need to get the lock here because you don't touch 128 bit
quanta [1] which holds the IRQ stuff that is racey. This is already
locked by the iommu core group lock.

Jason
