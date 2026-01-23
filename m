Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011009.outbound.protection.outlook.com [52.101.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B14C1B808
	for <iommu@lists.linux.dev>; Fri, 23 Jan 2026 13:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769176567; cv=fail; b=hr79SHw6Fncf4gqiZeCWDGX8eAnDiAI3yttipMibHBuguFzTxCTyIReLcCcYE8/lanUzzE7fPdML0vGrC05SYkKZWW8hx//f2NT3UwsAGpZ8Uk80OgbGXKCx7bvbJRLL9meh7kglXCFHRsWgaLnyIyv8+h3VS0zGvpSnA/a8Jlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769176567; c=relaxed/simple;
	bh=LLzzYcon0izXFYK0rpMWK3dzut8YdEmreceqkp0y/10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Cn1liqNiHLc7PfGho20rEXh7gXmOyLqwwhsWZFSyP/SxcaO/Zrl/KnQHPP164NOcIp5O77g1yVO639mZlTozz7n7BEFrdclt7CXemxhjZ6K4+fsFPG9mWXHyjxgX8YNyirWkNzUJJs+Q8xyjSL0cD2nSTfDHdxbh4qOBZFybm+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PlJhUI/b; arc=fail smtp.client-ip=52.101.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PlJhUI/b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ys2jAp1WaTNbjzjuGqfFQauCiic5T6r64n88fUEDdc8LhdxWyp8Ugfa1tJEecLQaHTIkqZrhfKedJAQCxv8mwcaBauB6uS7ep4/s/tFiOZwp/em/jLt3+Db94LfrH1TBmVKDiyB3P9U//MWw7Kd/wlJn4hhY3rW6dT1/jTR9NVQPrlPP9Rg5MBBpd0vs9fEAfhsFngExFhaw43pUPOGA8gNQ/BL3v1ubtbDqgsL5ToWu+zXMIIOI+X5/1B2icBH2s97Dwrp8oGRBYqrbu6T3p8fOWU44TZCJzaZM/USCwiJ92B7j51FuzFlN8ZKi9ZgpvzMFqiD3+wrQdJhcd3SrPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZFcaVJGQZ2VFUDpvaxPboe86gU97N8pZ+x4A3YM8ql4=;
 b=diAmd4RKdsBcuPEh7ePDSxExSW9Ye/q/D90VSAqlKJYpgQXXjVcDwbEx+u0dmBO8SdQXXLTyNMOMSvXwjzEoXlcjUFuy16j2ZW1GH0WymqkZtLtzLASvrQ3xS1DV33hrZJtq4HMfkf1s74FnSbtnFeKi2Pmlwa83+yXJU70JYN0d2/156FgAZ5PaQR5RB19GYS1VMHinXgz0zdkO43DGgH2ZxA5Px8X00Ktg58WY3zF3x34ulXwTPnSpkw3ZAwijO4zv0CaYl0Lt9r4OR8moCa9y9KQIG2jZI7jI+xrsG74KCCyU2mNJlt74VNsRybmgM+iZaeSx5V9QEGd8cYK0EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZFcaVJGQZ2VFUDpvaxPboe86gU97N8pZ+x4A3YM8ql4=;
 b=PlJhUI/bGUWDPcduSa5cU3rSEf616++0Zn4hxgPB0IiKmw2zxg0sSslX0fyqOl1guVxREoJjNsXkJ1Hlj2stnEt3dO1SumAO1eZVyl3PSXD3xOa9+7P4xapIOiwh8H3rfgM69mMlzEdBdM42b+ZR4wbl7Mq9/7ZLtN6NeVUpRNg+frC8ysoDJBg9T1PYhIq1blyP9CU/TgJ8bdYPCT0bDr7LAz8HV357r8f6HX6bXzCHyXmhbRtC/1dGdaQ/9SrosTHIX+7ZAHJjMDhtyVyoQH1FOyRFKs+JMt6r7nCxFcnmKBNjzpg60J7q7M2Al5iL3dJt3q6w1DZoeVvm/p16IQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB7592.namprd12.prod.outlook.com (2603:10b6:208:428::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 13:56:01 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 13:56:01 +0000
Date: Fri, 23 Jan 2026 09:56:00 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
	jean-philippe@linaro.org, robin.murphy@arm.com, joro@8bytes.org,
	balbirs@nvidia.com, miko.lenczewski@arm.com, peterz@infradead.org,
	kevin.tian@intel.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 6/7] iommu/arm-smmu-v3: Add arm_smmu_invs based
 arm_smmu_domain_inv_range()
Message-ID: <20260123135600.GX1134360@nvidia.com>
References: <cover.1766174731.git.nicolinc@nvidia.com>
 <06999367d001283744fd98eb7c1823afd516ce84.1766174731.git.nicolinc@nvidia.com>
 <aXND9YJTwm6om689@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXND9YJTwm6om689@google.com>
X-ClientProxiedBy: BL6PEPF00013E01.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:1c) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB7592:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cf97281-a894-4ba0-d9bf-08de5a872481
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|3613699012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9/uzpiCMKlWrzFEIEC5YK3/re5E38n72mpvQkf1CnxGDpHvc06eJQaswEBJZ?=
 =?us-ascii?Q?YxoBHoALAemz9rH4VBAlH+wfi+JYApiF8hxzRUFw0Nf1pqyMnSVrSYLPRQ/9?=
 =?us-ascii?Q?C2CTMmyFsWyjCd++C2ja34tfvIMCv8RWiyLtoUjiKK4+5eV6QtHR2r3OUIbN?=
 =?us-ascii?Q?BY1JcPdij5EiI2FoHtbFiWXLATdw/tPhTSwjFvSg4VkZb6ak4zcdrzanLywx?=
 =?us-ascii?Q?Un7+T7szaiJWzZMt8/ovyrttCL3EFtoyTXlHKWgnhSyuHrqOPk+h4171xjXy?=
 =?us-ascii?Q?3vBeRSJmYDNF2JV0AHVEt6p4Y94VVdFyenkKkfUW291nI5FYXtafrR/Uwfdm?=
 =?us-ascii?Q?d3qo9Qr4edkp9BtX8rELLlVVPa9ShnxriQrL13UQg1IK7kFtcwj6OcB2HloR?=
 =?us-ascii?Q?7cuXB8lKzMgbMBoI8G7yjoxk1Aq3NlMPKfss4jJk5v0NZl0CKDGBmgTF3V/z?=
 =?us-ascii?Q?df6t7vACvbzkzwPCvgRje9jotetvxww+rakNqRTxjH0X1rIfbGNXwnd0AWXH?=
 =?us-ascii?Q?XgG/XTVwtYMr2HcvfliiGxzAticV0lw+Z0LUzzah91t2gPKtZa84VdOu99TU?=
 =?us-ascii?Q?yv/gTLzQV7xvo/Y1PuvUwBJwE16V8mJkoLSstyOIoHqOL15fpI5W+EYSnkXz?=
 =?us-ascii?Q?CKRBL98eo8UcUeITJ7eFRhYUgA57z1+dG4ttBmtdky+x0YMjdApQfJ78Pb98?=
 =?us-ascii?Q?sgIxiJlKLgIJ7MkfHZSpUSDVIzws2QPFVnnof/yCEZ0P5Oq+7Pq6MiPLJHV+?=
 =?us-ascii?Q?kZqZwCjXmfh2u9enHRJqmURqdSGHrykUOPXk1GVZ7WyW+6MYHaVG4QATgoGN?=
 =?us-ascii?Q?AEYGKLwnv7q9BHKhH+2530+boVG4fJfGC7yIEn14DMpis3A9jnJZfxdGXkl+?=
 =?us-ascii?Q?76Z/dXlK8M6v8Ql1EYc8XaCX6YY3kUUlgY0RiU4Lxx2pll13kW2eXhkQ3pKE?=
 =?us-ascii?Q?8Q0Zw6Y/SDAh+bZYG6kbevUuTs0OD2jZwvItxNoE8X26pE+I1pUAvNlTbA+o?=
 =?us-ascii?Q?uLJCogAzlo4jCT0aqsjMQvMfUM4+rlGQkI647daA3ioXkSYHMn7qrUrqxGLr?=
 =?us-ascii?Q?sx6BviKbpIiD8f9OL7K3mbgYDC24Cn2hSLFMet77avwquM2HEyf5B2GRZuUb?=
 =?us-ascii?Q?dyHql38eQZZKbQx+Z1oydQe8NAVGbRONG2Q7nfLgyKbbbmNEGtLsS3BllLea?=
 =?us-ascii?Q?19927Ae4ETbZ388pLK23Ab3klIrGjXKiOrPC78FA46i3Z1b7RLI4Xs29+LrZ?=
 =?us-ascii?Q?Evgvc27a2YyqK2G2IIq6RlaK5ENJy2sH+7Y6XQZ+PWJSUIWJNTHpByPoP/Qx?=
 =?us-ascii?Q?puWC4JcNfvsulqRDFCIhgyPVRdQErAVWE5nmUbHoI1s11ysx2ElE59x+rbqy?=
 =?us-ascii?Q?0aDQo1we5E7sPDaOLjgyc2trz3cIwjJJflygxlr9JGob1kKSIJ9UKQV5lVZY?=
 =?us-ascii?Q?kidL48gSjyJ2Iwj2v5lNc3aCG5BKU4efC0FLy9mQfp/iBjt+z/Vif82j1Jeg?=
 =?us-ascii?Q?3zmdAUMU0E1LIE4C/RQ2smqBGMxP2850vnRwsei/KQ8mEm0jHJlgjoTOBKMB?=
 =?us-ascii?Q?NheR5DyfJIFCHZNRLqKckZhdtNOhtDjLmYpr91jybmZC9VcjMcBNs9maq95g?=
 =?us-ascii?Q?yjNDCFEoP4ROicbxVioOdis=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(3613699012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EkY5TzKzb+bfCJh9RuKL9CZr8UIVwkDvgXnWOC2pvH/U9SyRv5ds4jADzMP3?=
 =?us-ascii?Q?qMaBAtlqHk9F4WglTy6bBJLH5KUiIZ2wkoTH3oFH5iiJkvqskbhore5B1Z3/?=
 =?us-ascii?Q?cb5qUb97tVcNpKKohcCdu9Y/uGnni+dXDjeC0HAuYtWhzs+Q2F11kEwoirRY?=
 =?us-ascii?Q?ahh5csstVBBh7oqo0c6GP0KzwUAbg4ohaXKc6Zxju8HTV0/ziHeJtwFfoyrb?=
 =?us-ascii?Q?vSfSZdPn2nw1zhKt2K5o82fbqEyPVt0zfTiSpQsLBd3i5zWhyXhgxPfbQ7Pp?=
 =?us-ascii?Q?Uub/7WOSzYgkN+JLBjOQmdWErA+/blJsrONg2OJKjpY60TB8fxPGDcfPrpp7?=
 =?us-ascii?Q?hiJh+I1PY8smJP1YIsa9AGMfcbGlFlzpX98e6j4ba7WC9arhKiZpf2bjAKnv?=
 =?us-ascii?Q?/oCMtTBVngLQhc3ABcjGqgk+ouXnLtLhe4FZHSeQcMAOnvR0Pps+BLAPwSas?=
 =?us-ascii?Q?5G3ZgkjZrUH8/+McTCQ883f2KnNMYjMLEmansQ0tbQ5gxY5DGb5rdiKPR2g1?=
 =?us-ascii?Q?FQhGZcoxPfO7GJ5Yb6/ks/ZEO+LDHLWKUjWBUTKIjUE4NZZcqKZEP5FB1cnY?=
 =?us-ascii?Q?mObUSA6LB2bGc832eVA2Yme5zcc+w14JW+hFcxeMW/BBnzh5JuK9Vo6tyuXB?=
 =?us-ascii?Q?OMY23f8GrVReA7ajnYP+Fh75SqOWVFKBEUVRycay3WJf8+TRet4/wvKXZYRK?=
 =?us-ascii?Q?kcoLnfkB4weCPudvmYzoTKeC4PxfTVOg4gy1XN03QHoYrNI09kkydST7p1xx?=
 =?us-ascii?Q?3mXvoz1qc1Iv1+wQKmXIz5ioe2F4NHTxI+f0F18EQXPJ0vvnFe9xAs2PqhGW?=
 =?us-ascii?Q?FTHGBYwtkafOXvVNhmQ8cWn+vMRYqQKnDukHmFkTXY5vRMRer9CmxaS5u9bu?=
 =?us-ascii?Q?bru3Z0qy16GyTIIeeZO2gNqb2eOVGzYwndQ6hWBMTmbloWjbV9w0ALSe2l9s?=
 =?us-ascii?Q?56P/ARSU7hMjCHQOu7jjzc/6VoTho8iPxtnMZOJOSHA4eaKKblwvzWutmHQS?=
 =?us-ascii?Q?06yUYyBY2qvbx3oI8jD8h8y9cjkMOvwFzbPYBB6k3WU7BKURaIuhNQsy9zJx?=
 =?us-ascii?Q?ZH5Moh6DiQ5Hwl9UoCn2tBp9iUVLLHZQtQfCZ7sz5qg/+W3++6quA+jkGSx8?=
 =?us-ascii?Q?A/46W6ZQQQXOoDUH9IuRrNWZAPddFKcRJDmKCssBcSlxIhiXXbMmIwCNjOU8?=
 =?us-ascii?Q?tAuGiFSyAtDsTdaDKEarWCtjWt9DiOi+QhO6ut/t1ZB2iXKd4o2NdZK+yau/?=
 =?us-ascii?Q?aJj5FBACQf7ZrANBWON6ZZ01ezZ18v2NBgGVD9KyDNPIr27WiBuXuiLRZtiQ?=
 =?us-ascii?Q?fUn+pKgmAz5t2AqLDlYgzxwGXIFoHQgcISdl8IzbALL266yH4Psmlye+BpFU?=
 =?us-ascii?Q?Aw/kOcFZ4ISWvRwDdeWRj9q80PIsxRdJh6KDCh0WEBqpPNvv4o+bpmsz3lY8?=
 =?us-ascii?Q?UOqEWfJkLe1WgSyZI/0p98phlumP0V8ThdYPqIgMUeWh5tB16e9WlMC2teBk?=
 =?us-ascii?Q?XpCRdCbR7VEpWwrJRBZCjIwPF7imYLQ1vsrNUSnYFhskq9KcwmismE8YTS6H?=
 =?us-ascii?Q?0x9+IT5iZ/T3I05OEFQizLENqApv5kCv4k6pPOxfi9TimWuIbV75zEzEhNq1?=
 =?us-ascii?Q?37ogzVmCIWu0FMCX4DazMFBB+YM5r3rjo8mo6EUNJwfqAurnNLum4A74DmhN?=
 =?us-ascii?Q?GyjQDRUZVhRGkloBdE0gpTG6QOx9fR2pmwre/leoLgITVhbDybScb3BjRzET?=
 =?us-ascii?Q?D4fxaKfZzA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cf97281-a894-4ba0-d9bf-08de5a872481
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 13:56:01.5094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hrrbyCTkHm8G23bs4+hTwD65xkByXor2eM6SycumXnAV05PdXOIQtOH8tNL7LgcH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7592

On Fri, Jan 23, 2026 at 09:48:37AM +0000, Pranjal Shrivastava wrote:

> For INV_TYPE_S1_ASID, the new code loops and checks size_too_big 
> via arm_smmu_inv_to_cmdq_batch. However, for INV_TYPE_ATS, it issues
> a single command for the entire range. While this matches the current
> driver, are we confident arm_smmu_atc_inv_to_cmd handles all massive
> sizes correctly without needing a similar loop or "too big" fallback?

At the PCI level ATS invalidations accept an arbitary byte range, so
all ranges should be converted into a single CMDQ command and pushed
as a single TLP.

The issue the "too big" stuff is solving is for the IOTLB itself which
can require an invalidation rage to be exploded into many smaller
commands.

Jason
