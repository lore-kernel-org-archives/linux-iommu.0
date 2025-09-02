Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBB0299AB5
	for <iommu@lists.linux.dev>; Tue,  2 Sep 2025 13:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756818477; cv=fail; b=dob4MqwCxw42K2/pz8PdUudoYCy0X801y61hLdwtD9YRhh2o+79zTZqexJLnS4zVyvl7Cs22/z4Wvtyo4+C1WmXj6tKbYwjI5I1Pq73p+QzskRB6UHDrbWdg9QHDhufB4jVZ9KP5j4u8dBDYd4oKYpqDiyk/1rA0srFTAPQW/VU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756818477; c=relaxed/simple;
	bh=TrcK1Eo68YfAqO92I6vLkqt9acS/bP0zNGKdD8zcLeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Zg5I5ygwCFbHjHX1egPmnNP/j7XOPhyWUC+vDcV+FlpT49/2URSDm0Nyadpt86GhaLAbALe8XfchivnYi5rmsN2ogxxB2Nsi3pK6uHB9Lu0aghSbol6y96PlkH7dDr2kRkI4gZRvXwCDTWlme+V8q4TYl9iahUqr36xiu1/jbV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RoV9D4tT; arc=fail smtp.client-ip=40.107.93.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RoV9D4tT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L/GVTY5WWuIwL4lU1nZh4XR75nTm0mY8N4YiwOKXxUxECWXzmfadJUw4FMCR8vSdYXajcvyObeyBGs57ncmNkX05RGvy48Z7XZjsXxqSeHCIJzPwWNfNXOOqA6h5/zFi+YuQ9v8JNsnD6PEwYRovGKPvzCiaCjy0ooduaDo1XU0aXu/YJqNAHHnmEpzxD09N7ncS9DzI+wIE2JnDwzf0pAuGaIOuyT8ilp0YVMxe6ebzYVMQYNzi+euEdoKQKsyaC9odO/m8Wxc+ga6on/A6MFRA55Ctu19PVCgY8VyhisMFAq9lBI4tTYM1MVBsRh4Vx6QJk48HCpfF26lBvhLKKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DrJ7ECRgcJNqOGjpzuK/5xl0TvDfIKv9hv47ZbnhMMQ=;
 b=CdpSNehb0dQQNqoD77g0Z3Mgr7GAQVwBAcSy2UtpdeyamZMhiCCEH+UBVd5inoSf6kZ8lFWZG0Eam6aoXY1kM+A7L0AqOUCder8dSA4WtFhqYJC3CH0zKd9873cdluCbnpHxtu5Qi+WiF74UjcuM6b9py/xRz5okHARB1E2sc7htXlBW73A9vWucZpI5AKYzsEhuXW7MAZHCmgQEiE5E4zVAO7shx2mm/tKIIdUMj2kg64MfhimcVR245JfxIvT4AAmTtUCEMjU/TqPEfpX//rVkK/kVZtuRcfT/w563EXOd9awtbpSMKBwBcqMHH4fTLbKMPcmnsKX07yxc9xpWFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DrJ7ECRgcJNqOGjpzuK/5xl0TvDfIKv9hv47ZbnhMMQ=;
 b=RoV9D4tTo1uK0iwtl3IMgsJzXKtyX19si3dfi0JjvQ2r0BpqBycL6lk1fi3pBj/bQUKY9y9wdjbJPI6UfNQDu6qDzD/Gs5bMh9xdy+qpkq6hHPTb8d1Yw424Z9fO7yRNm2ZKEBUXH4LXAh9Y2wOKmOHIrWXF0ghvfz1vUPxxLZoi8tw/7vQ1fgDcZLlyotJDElwbhOZELzHnHZ1KlOfLsxk+mhllMIuA6D1Qp285Ohs/10Dh+As/blbvKUqIykxXhU/lVzvWt1X/HZBQlqaNhQaZBt0zOawXqbo3Dh6IWtKQESnuCRrkal077aNsoLjTp8yEBqFFet64NKlxZPc3Mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB6765.namprd12.prod.outlook.com (2603:10b6:806:26b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 2 Sep
 2025 13:07:51 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 13:07:51 +0000
Date: Tue, 2 Sep 2025 10:07:50 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: nicolinc@nvidia.com, linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	will@kernel.org, joro@8bytes.org, kevin.tian@intel.com,
	jsnitsel@redhat.com, vasant.hegde@amd.com, iommu@lists.linux.dev,
	santosh.shukla@amd.com, sairaj.arunkodilkar@amd.com,
	jon.grimm@amd.com, prashanthpra@google.com, wvw@google.com,
	wnliu@google.com, gptran@google.com, kpsingh@google.com
Subject: Re: [PATCH 4/8] iommu/amd: Introduce struct gcr3_tbl_info.giov
Message-ID: <20250902130750.GG186519@nvidia.com>
References: <20250820113009.5233-1-suravee.suthikulpanit@amd.com>
 <20250820113009.5233-5-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820113009.5233-5-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: YT4P288CA0017.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::28) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB6765:EE_
X-MS-Office365-Filtering-Correlation-Id: 6860f57e-05e4-4fac-4b13-08ddea21b8d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?klcmKXDQbe6wCIqMicg9HgqoPE9KpAeh2fOATLHZfyOuCxVSFUfQJObbl1EU?=
 =?us-ascii?Q?O1C12FLYPkdWYdTCXHlEM11GuTfGRe/6OiEwNHgtBLnZAfbneQtbpbRAk/CR?=
 =?us-ascii?Q?wLifhT5IoBpZQWjT6m7PO+n2fzjEGSVtnVwhjyslXuE2PuVYbaxXmvaL/DKH?=
 =?us-ascii?Q?H98HnL9uVad7QCKnlait83r2GvGh9mkovAaBqCtZcJGtvhVHWPECRDT1v3FK?=
 =?us-ascii?Q?VLxeYTPmQSM9bwmqbgHk1xKVo8t6FxloaS5tEd4p7RB5kIM9TgZwjlv6av1N?=
 =?us-ascii?Q?oYDDGV5OhE1tzqQS+XpEi0u/o5s7xV75gmIiyUhmkWpiRLbUcKsaACdq4664?=
 =?us-ascii?Q?e5Js9I8AVQwtB2xS3Rn+2jgwudNwQOhJ5IipTXM0gJlj7DUXGh5flv7MyaYe?=
 =?us-ascii?Q?46VclvJZ/FSU/5o52fOYa3V8IJhy0dAcWtNSW/4/0+RfPtTXeXPF8TKsV1aV?=
 =?us-ascii?Q?PovCPVcy+9kJefNUXztArhao9TZBEBH+sTLURT1fMQjX08FPuu21aYd4tIh4?=
 =?us-ascii?Q?1PeUJIj70uW4PDTZIsDDomiwyb+4ej1FGmXd82gmAxPCqdX1suVVj/b85TmD?=
 =?us-ascii?Q?agZMEAw9VDnJsmzyJBQKp9wCnJMkx+Jjx4/22XC5uSw6DpdWDoene+RrnSNP?=
 =?us-ascii?Q?iS1YbHTghKkUtKwF8VqgntChHzvqTEYjlcnNWOi1eIOakQY3+0I21UzHjGhq?=
 =?us-ascii?Q?pZQhwqOpe3bw+j/VxtFGS86bqEyJ3v0+EBpV+YLaw82wmaabYDQFeVFv+LTt?=
 =?us-ascii?Q?tsqOFYzgDuowKe/WIJ/BDqw4hEjmt8zNetHmmTIgOLCMMhjXa28QhJybUIyq?=
 =?us-ascii?Q?njCizkXDRcMtt2mn7SfKctq2mNB9OKaHQAzwum026CSjTK8yWxS3TInSICZb?=
 =?us-ascii?Q?63D8zcbZlWaZyBNLw+JrHkLe80CI+XJCrLsjsWUD4u2e6ZP7eqeCAs6vAuMC?=
 =?us-ascii?Q?3VtKQuMa7rbKUDdIT/FFb4237Cq9T+u8lRCvigVoZ3CoJNozMvUnxEx0r3JV?=
 =?us-ascii?Q?qlFGZr1HsEbASlYR16jqA+gppHhiPdQFmiOm5vS/49eFOg8IBvbJNr/4jQI2?=
 =?us-ascii?Q?HfEejTLamuJcPF00QFUMavps2d/zr4bXuqmiabdXALflhbxAXVuJvhqc9RVR?=
 =?us-ascii?Q?rtC3QAnXXMflNbT15XCEfjwjaTuWwqe8MzWKsZEyJSm9MXADlB0yTpcjJWA8?=
 =?us-ascii?Q?cbb+uO4ldKL9LzXFGOGEu05DhM/4mmEDJZvsIlAVfPPSK6gHsxgBtTSpQeFz?=
 =?us-ascii?Q?TnOKNDVFtN6t04wJiyL2t4Ow8tlj8e0WSuI9LWlefyCkY4Wfs9gM/SWcyijq?=
 =?us-ascii?Q?/tnLRX1z2E/YkpBQMTyhyzaMugszOql9M47xUSTjhtWnUz2qBsmY6xv/stlF?=
 =?us-ascii?Q?xTI784qWQMO1AZnRUtC1OUKpdYSUmrMctVfiFigLvYGWB8rUSbE6V2S5BNT0?=
 =?us-ascii?Q?yOge+qXm4VA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PyIlL9r5ZwTpHpQp87Pijo4Ld5FIKpzR7pjn9ukzqu2bplAVA/rmOWPOqSKj?=
 =?us-ascii?Q?FCjPAQEpDrzKcf2Iuah2Oh8QpODI6JvQDTTJGVyU5PD37fW7hg+A4HdVSQ7P?=
 =?us-ascii?Q?eU0sdiVM1ykPzzMBTOUQlT87lvX1gujQm33goLp2BsiWMUxncgfjNahF2SR5?=
 =?us-ascii?Q?PoG9rJ9VmwjNvtkS17lJcEolJ+wkkdyN2rtrDflC79UYQVuVn4ZCIn1zOtjB?=
 =?us-ascii?Q?D51dgWgXVnLGjxJnX/nuFF5YVFA1k3KdfjzNmhsxga1VCqErLf7id6l5qC47?=
 =?us-ascii?Q?QguOp5XLbrixEMY18+hXWp60LlRDrTCShSiqV3v0eCyU6ynvTWb/LzMCSC7V?=
 =?us-ascii?Q?u10KHhGzSQRRXAhGlA8pIgXhheeTnVqEUtc3NjCrmrpq3ygfOj1eKGolkC4M?=
 =?us-ascii?Q?EDDcA3yRnmfOjZ5/SfVoUnzV3nK9r/o72qdqd2N5OcBP9xZtRNfsEJLJeasA?=
 =?us-ascii?Q?2Ies8Yb6ZJOsna7H50Y4uzS0pdXZKS8wMsGkhrJ1LUtq/aoGLBQH9xJeGrs+?=
 =?us-ascii?Q?dq8h1Bf97+entTFbrFjpLSyf0TGi2+Wsqy8vdYq2UtZtIP2DckYXiJTSjmwG?=
 =?us-ascii?Q?OK1JVMZYzDu+bRS1VG8lJlNB6q0pkp0EaKRR4jOLAEHj3J3NTnTfgpNE7d8A?=
 =?us-ascii?Q?w7A2eg+SyiqdOiVBJ8LZk0i8uw3WI/vS4MtOCXCFh9eJzJQqAVF5vWYazGpF?=
 =?us-ascii?Q?1Mnd1ZmqzOHNmMJosQeFIiznMB51e3XqOWZfchlW7lcsoXdiKOOstlUDMijj?=
 =?us-ascii?Q?3tInvvTRzziaqk8Dwd44keq4q85oKqNVtxMRsZkSMFw3i5qQHs6sQblea/Zq?=
 =?us-ascii?Q?0+/an1pumhEq5WR2wdEztZ+p0VVs+VE7wZ3o5QM360irkL8rXqM5ts9GXboy?=
 =?us-ascii?Q?N8552f71VmZnTTzhB30/Sd1b6sYKQBoMFTSEAKUdgq5ItgSxRalM6UF46DJG?=
 =?us-ascii?Q?A6BK7l6Lik/RyC3VZPQjEr7xIUq+wssZbMIvTCRUjeePHTXqivjaop1tyAI1?=
 =?us-ascii?Q?dBzBLtukVVRGd2vreM3rVMOEqM7HM8IQvtQQKRHBzA986BNUdFr6hSbTo+f1?=
 =?us-ascii?Q?d+8B8r5wVDNC18jXlKXKPredB6+G4NkCy3xJJjhmirH7+Wn+fqDKSrXeVkUS?=
 =?us-ascii?Q?WV0Htf8WEBCoT6b/COH554Cxsjr3hw1StUIb2Er7tseeSYnaU3poYrIO/dl2?=
 =?us-ascii?Q?lmsAAnoGJd0i2pRf5h0MP4ZBboXWMk7/ZBM4Q+pwrRJFb6dhCLU2pamGholq?=
 =?us-ascii?Q?sflj0Fnx4pkpz9BCtG+AlT1svICgDahwVPwiqfbKYUwgRwaWC6+oR+8qIGNp?=
 =?us-ascii?Q?mzrwONexR9peDW2agIkn7cgN2BVpCSF5yXNsfQTzJrJ4wkOA4M6RGksL2RJl?=
 =?us-ascii?Q?PMWGq59ZVEXujtXL/ClJa8R/yLDZBgNgyO423oxGnczbfFebbRt51G3jEwRa?=
 =?us-ascii?Q?COsITyO9WKAVgNuBixV7c/goLsgvm/jcjMKrOx+U8v/IYlUNwJI4Csd7L4aE?=
 =?us-ascii?Q?xvRbMHNglYReKCWsHAHKl1ztW6rWYbaNI+V/XNhRiSIePneluDDcgbP3nFTH?=
 =?us-ascii?Q?8Fl6FeKk6Jkpe8ir0SY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6860f57e-05e4-4fac-4b13-08ddea21b8d6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 13:07:51.4690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4GtgJ7yVcJBTOsljJsLL3EItuce9QR4aF+7/sMg/KzsG3hLCd0dJE4QNjHoLtIM5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6765

On Wed, Aug 20, 2025 at 11:30:05AM +0000, Suravee Suthikulpanit wrote:

> @@ -2036,7 +2037,7 @@ static void set_dte_gcr3_table(struct amd_iommu *iommu,
>  	target->data[0] |= DTE_FLAG_GV |
>  			   FIELD_PREP(DTE_GLX, gcr3_info->glx) |
>  			   FIELD_PREP(DTE_GCR3_14_12, gcr3 >> 12);
> -	if (pdom_is_v2_pgtbl_mode(dev_data->domain))
> +	if (gcr3_info->giov)
>  		target->data[0] |= DTE_FLAG_GIOV;
>  
>  	target->data[1] |= FIELD_PREP(DTE_GCR3_30_15, gcr3 >> 15) |

Can we please fix this properly as I've asked many times now and given
sample code :\

Building the DTE for nested should be done with a more natural
connection to the provided vDTE fragment, not by trying to squeeze it
through this existing function by re-using gcr3_info.

Jason
