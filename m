Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013066.outbound.protection.outlook.com [40.93.201.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAAA3264DA
	for <iommu@lists.linux.dev>; Fri,  5 Jun 2026 14:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780669816; cv=fail; b=h0Nv57wMZn8iTl9iw/I2akcaSy9BsK2zdcTHxQGsso9n6SqWKY7Wzhg7bxUZoAF/YyW70PjQiKaUw0BHvuZhEV8T/40RF940ThQi2UnwSSjVvvMbaM3LllfX88OcHsgKyl731JEnfE3O6pvOCq8Ks9is8eLqPxhJHDGJiNT7a6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780669816; c=relaxed/simple;
	bh=a3eaNx6a/S1mal7CX50eVtkuQAQfKKvEcOluP6bL/EI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pAscSmzSYBe/isGoRJDWIFeGhJTuko15KmLVGUnqCT6RSS7BpVHsnubRtOb/YpeWvEXzDY7G+ZRIoob4BH0zBBWb9AYAjpqKuE2mmucrBJ/13Pm7Coax3QRpVkwQEQ0MIPA1jOq6qvKcYATmhOh6nb16ccZ4KpQz2GXj/BjqHO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L8bpfiu5; arc=fail smtp.client-ip=40.93.201.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L8bpfiu5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NYczLMNgmtbzwNq1yoz9sDNSt7uICcj2y9ioFJnnZLVs2SFmoILou4NeBboH5sPuuzj+L8w5xW/rOf291Fzw/BT7DqQfhxJOkUYBUV8QpoYnOZKbR/pOl/tjJLLJlJHRCZzEZVJF3a8X0txuJWNN1t6moQymvYsPmSSOuctpSNUpWfV1XeH7Cg2X2xrEqTJKN+9bUtdmHF8wCk1xDgAp8QD7mFBPAptXAlX2QqzsmuPSFmIGhklx/Nupvqv6hMZjlDzSbfyE3HRFG8m5+cAsygCAE4QUnzZB3V8E0/ll50ac7JSxZUWUz9KWmXcGA3wChUPI2MFzfr3r8JC3A+8x0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHpHHWNvS7RUCjJHAcGuPkTyBU3ms3HxQhO7xZxyNFQ=;
 b=nHxbyBX+jBa1UFWCJnunm+jCJA9hc1IUXjKrGJc64xGnoKPtvihcvcJd3up/X4oLZWF8XRCv9BIXEBd1fiMJXWPDBf3dR8+2hQAhQsGnxfGZpqocdsCMhBuX4mlWAJZEq5AFWSzHXUM74Uo+6bvdJ+KnjFnPSHedcRQatYKG3XJdmAAHztbb3unFptghfdwVdMcGIpnd+YStsNDBdQWxdvgeBPbYmTADSM0yxHp1KmrcnatWUp0DQVz91LCS8n39YvnrAYFnHui9HiBx93BRpT35LIDXgfKzz3jYDUsfb1s98VQrLTv4no2UEmcmDmzPvYh1FznPTwU57JlYRpg4Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHpHHWNvS7RUCjJHAcGuPkTyBU3ms3HxQhO7xZxyNFQ=;
 b=L8bpfiu5xKkcLxXODHa/Uz6qpsqyz12HQrpz5JZIQOHlOZsaFSa3cmZPCUWzjjcy8ZR4A+g9J1B8Gz5nRWP7nNwBK7s3lUiW0qUiuG/68RH1s7HI4zmVWTHFLM3m4EEFanK6Wz89T6KuzmSAHXKBs3X2QFwkTbY7Qr4vUwwMuNUEIovxz/1deAM6g4PHY97/sLfEvZB8EYLG3/aT1PGjYKUvEBDK0OE3Yl14nJwgX03TtgTmmKAJNi6ENUS3ZgREp6+2FFXZhruOILSz7qWsovEw3JtaZWIVJ2BzlpcLeICyriY1iJRflwDMYtW/DOxi3bGMxkOItsclWsUw2GPNlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY1PR12MB9602.namprd12.prod.outlook.com (2603:10b6:930:107::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 14:30:11 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 14:30:11 +0000
Date: Fri, 5 Jun 2026 11:30:09 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, joro@8bytes.org, baolu.lu@linux.intel.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 0/7] iommufd: Fix bugs in eventq fops_read paths
Message-ID: <20260605143009.GA2685854@nvidia.com>
References: <cover.1780343944.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1780343944.git.nicolinc@nvidia.com>
X-ClientProxiedBy: YT4PR01CA0499.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::12) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY1PR12MB9602:EE_
X-MS-Office365-Filtering-Correlation-Id: 9be3a250-4a9c-4f50-5f34-08dec30ef319
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	jTnlr/86tWLTyZxmSa0iCWGyKV+7KDG2+zcZloNK+FPE7yZuhO25YVOKysTKOPY9qYtbVSkvMYsn1WaQbW5XvVL7MtZjgeobVWz446rSKJYyc/n6WgrzoVUESfMWcHZC/NbW8CehTozy4p2rvEzCawS5nKqiSd2aI8z3+Sa4KvfH6WFySip3JQ1WZupO/+pl8OmVJNsZi/j2cmnmd/tAs/oaYqccBdlACly61SCrzbzEG7EilmLwIZ5JAubHC8TfTyEyoo/I10dFoX8ynFOrMB3UDCDcHBefoQnWp2qCfeDAWOrnHpYK9u/GOV8n5THLjpNh58HyG+00KO7SGLYQYJgwBBnFesfDuQdNRhtjJ43MLAqEo4e5p+IzvCkWEKSRopRZiPK2ouoYk+am/37VAPo+L5X6NitfPVz1F626Db/Z1/tFMpQVe1R5LSfYB3qSK4Hbuqe2S1q0cCgVTqRLHOFrUZHrhjzvD508wirjaQqhzQfbc6tYuCsBK1NDh104KhEZASEljXGlRDqSXHF4EKn9vomfppw0qQBXCIG+p+cF4wNQ19cDC+0Pb47YZzgsrJlWMQLA+/G6+uyx+67c/M/61DzAtm1yV1nHs7g6mC/s+BZV/7xzxHHr0sL71tgxekHjTjTCzZOLkR/Jzo/tKDYH5ux5J9sizvG+ywYj5cs5wHPr4NbWBT8IKu6JTU3z
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UfbZE+yGsbxlSwEH4OI1+6uLW/WX5ca9/CaiZBzBwd/mKeoiXgEqy/0G2/06?=
 =?us-ascii?Q?JLfyPX7ssZK3hJjzAL2OJyrN1QmeU5FeLD8yx/vbaq/31ET9yzb7J2Niyv7k?=
 =?us-ascii?Q?d2IdKztLnInRw6wzD+iV/h1OvKQweyBqVALmCvtwEk0KCbsWnhAYrgOuZ116?=
 =?us-ascii?Q?momf5d3dC3nVb17GIvEjZ+hnNNzX9Uq+NGF+2cLjnpIEHzF+q2JFkOoAkXis?=
 =?us-ascii?Q?C4vu0Ha6OJqjvs2EECVXvAsEWDyJcIRrtnZJ2pDW53PTGuvSMpltJWa9T1cq?=
 =?us-ascii?Q?/cOT6xjGLWA7XtZ7PI44gFmr05U8IkKDPM0YZkOtnjn3LuRCmz2EANNKYwGn?=
 =?us-ascii?Q?67szyD660W3DoebdoTQmm8Haf7CNn2A2UV1YMG83UCEq5IZKUWxM0YJ+Jut/?=
 =?us-ascii?Q?9+Wl2x+ZYO1HHga68+d9AvxRaN+a2f8lg++uO5KTsG6XUYpHI+lAY3mdQiia?=
 =?us-ascii?Q?lBg3+6p4GniQsN73EqdXt6jOzJbUHYEpxQvUNHiIhkf2f+2bgitP7SGyqp33?=
 =?us-ascii?Q?piK8nuPy6IOuD1SGRJoLAMtjNJonHdnWoVxlOnb8CB1t+blPxWMfxLRrtu9r?=
 =?us-ascii?Q?Wt+sbWtHHXzhECgvOGXrH0WaA1EK4X169gl7O47rvXsvS6avVAs6hNGsxOpb?=
 =?us-ascii?Q?jKt/srMy4hWve/sswSc2AO/b98wy3oHN2fblryRVzav7U0mV5cqkfPIZZH8r?=
 =?us-ascii?Q?DCJO81UADH/+JKMfKc+8bPIck4xT2JAGgGpqa18gmlPWOA3vfA5IrHWZjWDf?=
 =?us-ascii?Q?OsoueYeUyJ/QNm3olRtly4gwhrzoP1nk8SxOi9M746xzMHudCfBAorXIyu1i?=
 =?us-ascii?Q?CVF59N14jJcUK3vFSPSdUDVdNY/21t+nnflTNRoHYu82okp8Yn3D1nA8Scde?=
 =?us-ascii?Q?FE5E5ky2C3BAGD+PvvCwNhW4IaKnc625gApnCVgpa2x9tp96WNmwzdTO9ucS?=
 =?us-ascii?Q?y9e97rsgfKIiKLMaCGENZSQJsuv1/ZS+s0z/l2v1IYCAkRaMN8kRIQnx2+ED?=
 =?us-ascii?Q?Jl1zdGPSP75B/y78aQ8jwP5UuR5UXBDW0UKVFdmSE0+OQI+0bsU9RlGt/B0Z?=
 =?us-ascii?Q?RziMzZkmTVl4ldB9aEKxHsirGLw4HvfzslGuTwqbKSsjCdzyMR3gVADmPXbu?=
 =?us-ascii?Q?1Guh574UaIv6MnpbumHZMmUUZc9UTixsjkKglLxIM5N/pTRxjGh75kvxnjeh?=
 =?us-ascii?Q?XTqiUyfH85tF8F2i121r4v1fgaL7Lh0H3QpYDkOPIprPKN0jculkHbYJudtc?=
 =?us-ascii?Q?gbWHFCGaUI5pNDBUgg3dBfJpdvN05xH2Gv/nlJgecHFgvJtVLIZ44B9NbdNm?=
 =?us-ascii?Q?FlSv1wP7HdzcD7KbYM0C25EzyagnpiQW7vuNgUUD+b3fblTthMX2ouOKQsTC?=
 =?us-ascii?Q?zl45kxeP3N5LifqJ9FiQ0AkGP0hgQEhg8g00LzA1YVunuOQ47srtqlP8V6l+?=
 =?us-ascii?Q?xjpwKKhW6mEdhNIpCVKmsnjT6Q/at5PKcis/pXGUJMXVVHaEctyHnOIVJ3Ox?=
 =?us-ascii?Q?4SCmA53bUphxG6Ax4o6+SkOCI6/laCbRVrkgGG9W5wirteO0Rf7kHwrzdrCB?=
 =?us-ascii?Q?QFjrtsi/mccJyoGx+j4rzYut+moeUUDSl9rAVD12g62wWAcG/lJLgFd2WTRU?=
 =?us-ascii?Q?nTp86PyFaPzKpV8Iym+m2RI8ji+8UHinpXCLxzL4p2e9XUvTNAnRFIN4GFzZ?=
 =?us-ascii?Q?yQ/0BjTlDe+rAcMMCSAu+AOgCfGa5M5wmujZw21jlDPNtvFC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be3a250-4a9c-4f50-5f34-08dec30ef319
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 14:30:11.0002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I41B2dO3/n9zTWGfG+RmkAQ0v4VA1qUkJLZlpdo2ikJxXwVVhhq5HAQtSpDMAeBf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9602

On Mon, Jun 01, 2026 at 01:42:31PM -0700, Nicolin Chen wrote:

> Nicolin Chen (7):
>   iommufd: Rewind header length in done if iommufd_veventq_fops_read()
>     fails
>   iommufd: Reject invalid read count in iommufd_veventq_fops_read()
>   iommufd: Propagate allocation failure in
>     iommufd_veventq_deliver_fetch()
>   iommufd: Reject invalid read count in iommufd_fault_fops_read()
>   iommufd: Break the loop on failure in iommufd_fault_fops_read()
>   iommufd: Avoid partial fault group delivery in
>     iommufd_fault_fops_read()
>   iommufd/selftest: Cover invalid read counts on vEVENTQ FD

Applied to for-next

Thanks,
Jason
