Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010036.outbound.protection.outlook.com [52.101.46.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE893BB9EE
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 12:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774873030; cv=fail; b=hpYD4Jl2Ja1HGjTXwW18ecicy3DsF3GXUU4b5AFFJp40b9Y23l+GYD37R7u51QJB8+cd1/ei2mtHid1kFMLRZTHvBPoomfkTfOo7moomw4iNB9so1XVSfBmtTHNqnxPwh1lWplCIRqgGOvCYMVkDaEtEe1uL2cb9I69AwuS64Fo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774873030; c=relaxed/simple;
	bh=ZuJAh9StdT9gZod/9PoYsBZIbYt0HkUIb6IWzh6eWJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MPVDgCu354hkx6JX4381GE+6nH4oClIBZ7A+0KhqqIDGcK6q1/4K0/srnKw9jM7nnZVEtoER/goKaW6KPWXLf679BDh1Iqz2GvA9Ek8CmgBEGtLhiG7Bh5CUT0iWHpW8GdgV2wPIco/oqKCF9DXD414IUvaE9FDitKy+8r7S3Rg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l2eMPNl8; arc=fail smtp.client-ip=52.101.46.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l2eMPNl8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RFt3L23gMBBks9GI1kvUk1QFh9JbCVjkwROL6Bgd60jG3tm7XaCvSURZ5FIxejJvMLStC9K+3mAx6PM5IBO5spjqeaNqutzj7CZbC38m3/tXctHNx5/Ql1uTAvjB1Opn5c/6Qd5/Tpo1oxc2EiVHsp+S+hT4CAIgHnIQbfKK0esuPBv2OKv/aMP0LYy3xAmBhhRfRYRPsm4a0zuMVamCs/tLXXwsrg78/lEej2OKrzXfEgELYqgt3aiHsJ3lyEpAjgmXfWEmlbRgHcKBd+TZpmIC1yApRw9riZHb1GnExH8OPxp/AOdg7w24awuwfYC0czisvzy7d9/mHgsnPiknlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqljIoH0Re+sHYQEw7AbD+tEMv9VHU8owGfHFlHs5mE=;
 b=im9Xg2BpRBMN75P8QFprhGLqsLJ9hmjyoWW1TVbZIjoCrfZ6xmM3qHcBVabfToedXd5ZtnYP3G6A1UDgU4ixWMU+33nIwUnxSOc+iB5Or8iTnR5qcjlroblrd6aXRGdrL36enJcoCgyV8UAwDdQl+zmZi4g8GoPlHHuk9JKhl7JVbIr0t6M1H2l+JSWoKPLWdLMQ5EGAICuVvTlCqn7KHKcaMjJoVV+HC+5wXfizzL+kRBg3G7IDJB8tM1+rluamk2SplDnogB1mZUxcDzSKm7ekprNUio7jY5XEXKiy+8Xxgk+DPLyUbt6eaqmWYKD7RBhyOqgSfyNYmNAVKdrTVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqljIoH0Re+sHYQEw7AbD+tEMv9VHU8owGfHFlHs5mE=;
 b=l2eMPNl8X9gEe2oDiFgHj50obN32esRiv5OevRUwnLwNco/Huq6oCLwOZwR8yjJJzNEZtYOeOqPF0sNIS5tQYPvDvvJyvxA+Sm/02KgKpQbByi2x8lbeXlO9cG91FyV5kCAwSoSsoJEwWivfbo5VKYECeW+V6qre5hh4T1HqpWPtGl68Gu43/Q4bZn/VYjdmhngbxgS5CFjXX+P9/yakQZ7UxpKMMOCj6uOvwBZoSPbmButIMEhlerrZXiI8qrCCbVbuTbgV8lmvOBkVc01iJwXFL+W72wPnH88YOnOYTdICnqPawg09Co2z1T/Cfh1A+svqsVqeclSFAWVrTSUg4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV8PR12MB9714.namprd12.prod.outlook.com (2603:10b6:408:2a0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 12:17:03 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 12:17:03 +0000
Date: Mon, 30 Mar 2026 09:17:01 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
	vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
	sairaj.arunkodilkar@amd.com, jay.chen@amd.com, wvw@google.com,
	wnliu@google.com, dantuluris@google.com, chriscli@google.com,
	kpsingh@google.com
Subject: Re: [PATCH 15/22] iommu/amd: Introduce helper function for updating
 domain ID mapping table
Message-ID: <20260330121701.GF310919@nvidia.com>
References: <20260330084206.9251-1-suravee.suthikulpanit@amd.com>
 <20260330084206.9251-16-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330084206.9251-16-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: IA4P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:558::13) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV8PR12MB9714:EE_
X-MS-Office365-Filtering-Correlation-Id: fec6f723-deb5-41ac-318a-08de8e564019
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ilBEG6+xaORiYQ5gJfrpNFpaGvKPdSbm/wnbWoL3cn/ZFZeVmzU6gyHKoZ4J32Xkl6RdGZYX6B5mjLNr5R2IhNbqT4aXDWvAyCzpzudBuS0EtjugdaBMvGKP/w+UtvtXgN7zSzJXUIIJaYb5fbPTXJrjL69uXAYaTWmYo9O3aX7BZauNZgH3NB2wVWJTeiA/X7QAhm/5r9CBDD2ZcaT3LenFdJ8WkJluuWkI266xVjqKoC6HJqCeAUAhswM7cxRX9sLpyRV0gCoKTc9O/yiY+zAO26W0jZasvnwFiG2n5m9I7OEGloM3d8VRe8HoGjKhl2MM5WTe6j4QtMGbpE/XpQYN8x4501nIWKVe4qjSh+kIv7yV0Bs3SK+gUEahyHkTQxRTc/+qahp8byxuUJ866lT0EY7eDWHHbQxssPe6KFphOShrXUt8CKUP8OjaVFgOkODEwMOeqDVsFCBB9ZtGVFBwPc2ZYm2Kap0T+oEiXuDvee9de+Ed0kU8aXk0AJvSDPycBObAq6cOMQ48SqLiAs+3JxCANSJinla4DHlUbfEzEEHWWx3kFstf29rvXOCkIysOfBEF1Xk8pbjbZ3RcyKrLd5MXnJ6K2ihZkQsD2xlITNb1pZF3WZIzWdnWnUN4pAsKBamyL1o8HZ2w3t5jEt3Wt55fFchkciKEEv47QuWv7RN8zGcr1HTMA51yP0MklENunvuQk0o4zWV3e2VqjWnFj2MaZijGObMzZUkr1kQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9KkpPs1HXNL7GVsY49rTuc3mK7oMmjUMWiAgMlMtEJSkN4qYusnZPAXD6heD?=
 =?us-ascii?Q?z98qNOTlMLy+4u+orx9hcL+RkrJNP8LGIq+oEREoRnpEzTkicp4Wa9ZSvU+X?=
 =?us-ascii?Q?W0+m+EHK5R4rHr4S6cKyifpds9UYp0aBqU8V2NEl0bkBKhLTzRg1bvUyP+vL?=
 =?us-ascii?Q?Q8NswBmtnxdF0TAiN+xwmZKBByaAO/Z/BHz4Lqoq2yMh9TtYgXwZ6KdqoSwt?=
 =?us-ascii?Q?zBt684ZAIbMsAGjuFWXIkj4QZYPs2Go44yZTp2uuPSTKj/TdejtJ7YMP7mUU?=
 =?us-ascii?Q?qlwaaKvRPVwU1TQwfk8Fu/jNOVPYGCdPT8u1VofCjh/pDyZ/uhg81t5VxkAL?=
 =?us-ascii?Q?O7qPuLlvR5VVkCwAtA9hmAxx5iWAa94Hvz95JXYSvNZ3xqKbK3+LJKzAvEq3?=
 =?us-ascii?Q?51GfPYwLaXKcFDLfZBnwIkXRpdqYbzI/OJfveyhZF62Q3HqAcbLejraBgcIA?=
 =?us-ascii?Q?nLNo8Hv0VXO1l8Hleitn+2/BsYcYe9QykXh2XPpWjTwZ/BiDc2e7UkA4JMxC?=
 =?us-ascii?Q?VQLVwe5cQ0S8dMcyu+l0LXNtK7U4ALMP19Vgx5JK89lyqn+UjFY5hJ0ql0oj?=
 =?us-ascii?Q?nh9pIvPz/D00bfUgSI0m8uRU9aTJsrFOx+YXpGSAfrbnXIacJJqo97XF6ls0?=
 =?us-ascii?Q?SPA2UAqAdl5nJITnlCvU9BxGSRUQpxL4fhBL6u0yxc/iaUlS/qI5PRMIKiDX?=
 =?us-ascii?Q?TJG6Dax7jmsiWtU0Fu5SEuLK/CuZJrCMYyzXxuQza6WmTeDq5EmoYqa20wlJ?=
 =?us-ascii?Q?4M438xNO97Y+oOmG8SnaE1SrlrtLxPdLuuG8syOutUHXwC9ByovetWibTqnj?=
 =?us-ascii?Q?n6sYdPMOgEJKuniPyRlToKvVgT2RUI2vEkJKlY7lMCcS1LI+InqnWpUI9wgT?=
 =?us-ascii?Q?KyQwaIb1ft/PcFZyL34LfgeEXox2ae0OPwMwsNTe7Gb1/zXQgCeFKPFcnVnP?=
 =?us-ascii?Q?Qt64DURX/VKp76asIaNkq+icTFVxUTTOFZ2+fLXUiiszkBhgG+w1NDI186jz?=
 =?us-ascii?Q?oV/QCDmNIAFYSNZ7Q9cGlpr4UcIiAW8SQhxlazlLkiGb590qT8gjNZUPYCXJ?=
 =?us-ascii?Q?AL/B07aMoOCbQrNCoyBYBXbtHTih4MeNS7eSKBDDr5Q0kg+bf/YOcHQlD+1f?=
 =?us-ascii?Q?5jWZ4gmxoc8vSKZ+zbZtWsbawVdJOCzzpgCiB66etd7Xb2rnKtqX0qE3OVrY?=
 =?us-ascii?Q?sGFzL98J9FCJeJNb1GkpDwcMmx4XOJZ6eAd4Funjw5Rmxre9M9tamJ9+2jsz?=
 =?us-ascii?Q?uG2WhlIFXVyZ+dirKAx1XEOoseOPGZ/S1Y/Qjnspt0+j9aVhikWGJfp/KX9X?=
 =?us-ascii?Q?BvTADyTABfpIR9VjqoUN8WH3glg8rpm2xvqoV4WIoCXvkUBDpuUG1xAdC/o/?=
 =?us-ascii?Q?SFXE2BJEcqzAjAJSxwQFsNxBokdePIoJ1qgLSMVdHmt5ShhrgrtIJLgV32K7?=
 =?us-ascii?Q?n+WIYY9grIDrrEcboGKxz4YgXL4ZrLk3wtdg+9o1+NTPSnDKTCzjAFIP2F8d?=
 =?us-ascii?Q?U7QlRBlzx687JaFufTL9agsCfFQlJ93pnmn9Dk1eGHIY4pz2aYThylcQ3AwS?=
 =?us-ascii?Q?8JMiPLl3+Vi+kJogh7jOZxDeMdHE63VTXr7bLoWgrnNNbhYo8C/760dXCVnZ?=
 =?us-ascii?Q?ZjNf8d20KqrDWQ0SVnqSXjXEXSNXIHZaZCGCPWzSWSL9zUMr/z4+H4xVMOuG?=
 =?us-ascii?Q?m5HIvPqwGWMn97KZwMhKZWAz4mZ8RJJ7yzLNBVl6PXQWL1js?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fec6f723-deb5-41ac-318a-08de8e564019
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 12:17:03.6463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bAyBMxQm/7KjdL9ROu8QtLxYFJvCA43grTg+0m/VF0/4T4pRCJtzSRr31rNKBK2e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9714

On Mon, Mar 30, 2026 at 08:41:59AM +0000, Suravee Suthikulpanit wrote:
> +int amd_viommu_domain_id_update(struct amd_iommu *iommu, u16 gid,
> +				u16 hdom_id, u16 gdom_id)
> +{
> +	u64 val, tmp1, tmp2;
> +	u8 __iomem *vfctrl = VIOMMU_VFCTRL_MMIO_BASE(iommu, gid);
> +
> +	tmp1 = gdom_id;
> +	tmp1 = ((tmp1 & 0xFFFFULL) << 46);
> +	tmp2 = hdom_id;
> +	tmp2 = ((tmp2 & 0xFFFFULL) << 14);
> +	val = tmp1 | tmp2 | 0x8000000000000001UL;
> +	writeq(val, vfctrl + VIOMMU_VFCTRL_GUEST_DID_MAP_CONTROL1_OFFSET);

Use genmask and field prep. Check all the patches for stuff like this
and fix it..

Jason
