Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2049.outbound.protection.outlook.com [40.107.95.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FC57E3
	for <iommu@lists.linux.dev>; Thu,  8 Dec 2022 14:35:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3DPZJrTXvxWcpmK4te3SGA2OSg4TDEGWMySiXdE7gj8FSgTs7AGStdViRWBKH72F532VZrWdREZ7mULxec97to0iUNcMhT3rgLjD/IWSwwsJISA9Gm12lDUemjidEWqG33r12pVvUk10LnScafsSJhB0CWwRdn8QGCLsIakLLvYZ73s8KZUg3AaSOTlEGvwq0wBLHlt/FR2vSYuUwsyg78brYrIyag2j7gkI46ML7Nn0TAlVykfFO+G5VhbuoN9j45oLQmt2RP3ITVlUAp/e0DrVlyArMJwNxDQtSqO2W1SHZrmWf4Of8lfddPgVSaKVXLqHUfH0q1qobKFTsm15w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=matqjUByBTHEV4/KFm/7q7OJZFd/FNmuNat/AEWIKDY=;
 b=G/O4DJ4fJD3tj48vH21KiaiMHNOXCXjNVMV1XbnJ4hUfsdgX2OaYJYwCsxzqBFKWfaH/qkyQ3PRQit7qZfCbQOF7CqimX+aGNEi/W50TrFA0qICaZaR7b9N51t9G3Ebk+FE8LO7beSpJCzK5N9ssGGOMLgTZ3+FUYQuIhD8G98cFPuY3Y2RcTx19AOsOlx9jBD+a6defhpghN9wju9GVqCCmQMkfegHnc7WFPp7Q0crw+f1g9cwZciCtxBVn5PyGhLVR/TdvaFbUjs/4dYPRZGackL/WXqM3YIsK6+D6XeZej346GOlO+MOXjm77Ggi3MMbxhtQTUPXVTApFWcAt9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=matqjUByBTHEV4/KFm/7q7OJZFd/FNmuNat/AEWIKDY=;
 b=X2S6MEZ/gz/Po7Y4hvdR22kW1lUpuVN9NMdstI8P8tqxVGCnu15zZvlcSOg0IqXOuxz2AmF2LqlRMKeQgHkcy99zc7tWIfPjQUTZ2S59aNI7dcHPbJK2uT2tYE/bO0YncrEEJS5s5rfU2IoaH+URPy57dtq7eBYs9aI5BNwamsnaWCY+g8YYmPrJtC0NVI5Y/ugqXVqyLIlE2IlKYZJtuFaKgF/MZPkrMB279/NJoisueg+HWLePRWEkaqLi5MItI889PxC7PZab9KUSHEDz5EQbRvyncVQ+MAS/u158WHU+8aUYHiEXMcdwayNWiXv4OnfxAsk0q7cOy0TWokAhXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5061.namprd12.prod.outlook.com (2603:10b6:208:310::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16; Thu, 8 Dec
 2022 14:35:47 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 14:35:47 +0000
Date: Thu, 8 Dec 2022 10:35:46 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: iommu@lists.linux.dev, Binbin Wu <binbin.wu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Lixiao Yang <lixiao.yang@intel.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 3/3] iommufd: Change the order of MSI setup
Message-ID: <Y5H2Qmz2bCXYHLA1@nvidia.com>
References: <3-v1-0362a1a1c034+98-iommufd_fixes1_jgg@nvidia.com>
 <148ee0ee-769e-201f-f918-5c3705225aeb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <148ee0ee-769e-201f-f918-5c3705225aeb@redhat.com>
X-ClientProxiedBy: MN2PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:208:c0::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5061:EE_
X-MS-Office365-Filtering-Correlation-Id: 91e3f4ee-4af7-41f9-a1af-08dad9297ecf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iHc4o8Gj2gq9RloS4jd8cQvwIwbWXyItXxw9vcHkVRLsAcmWqEWxu106N15cW8lNzC41GoT9C2j2XR4od2X0ezQex2homnROS2UIZuNWNAU7r9oey+4jTX5pDDq+/PP5A/0M6nlt7G/FKSewUA1p0b3KE7T2lzLO0nnhJxhgaQrZr5oWUh6CtAp2AX0SHYZVO8sRwY/V0m9G3o/9d38q3GtYTIMz79PtMEsZf/Xf0qxXfjQcbibmSTzwKinbIkKrX+ABTjHLSuepqkwk9mp+bI4aeXdU3VwNlukWSzHNmuXcKU3q4+58mJqNMZWL1gM8sbbSYx5DFXpSYku5f3y9HEwV3sc6jNuRcLESPOMOp62cAtIXDjnJ/6sHCRWqFDI8Z+Mf0yksBIyKCmyU+xrsxnFHenIaBx3QlrHirJg8fcQlgXJQuInLQ/huznj71TO7o56UVQGcpdHDVbWU9mAZ3TOv1m4eo0PTT8CJzoo7jwgZPb1jyNNh1SoUxtw62Ds2Ksrjf/D3LQ/WP9Sjj04pJvkMYOoRmXVCKyLhVcpLLEnVzvHyRn5Sv8otslLWzir4O4PXBo/qCeGm9r8zDz7sdFJ3nBem/3Xh6mKiGAr++J4EgqrvnpG4ECqMVl7t9ihH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(451199015)(38100700002)(2906002)(26005)(54906003)(36756003)(8936002)(83380400001)(316002)(6916009)(6512007)(6506007)(478600001)(5660300002)(186003)(2616005)(86362001)(4326008)(41300700001)(8676002)(6486002)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3EvbmJOalVQSk1pNkx6L2NmWEtsR0hCNVVMNnVmbVV6ZDRBbU1laHBHZWxw?=
 =?utf-8?B?cHU2Ly9PKzdLYzRjc1ZEOUIzc0dxcVpSZ245dVp1cnFQTXNscFVPWk84VmtL?=
 =?utf-8?B?WTZGNXQrYnJ0K0lMUW0yUXhmdDdLR0Y0SzMwWXhVZjZLM084c2x1ODlVMGpK?=
 =?utf-8?B?Zm1wbGtudHVJUUNEVFdjVEczL2pCSk9KcnppMnFScmFQbG1sdlZpcTloeEZE?=
 =?utf-8?B?aTRrUC9zN3BzWXNRb09rUER1aldkcVJtVnVsQWE1YUZILzFmcFRYRmRXZCs3?=
 =?utf-8?B?M0hocWM2QkVZRjFLM1czN0Jmd05GTU81TlhUZFJCZVFyalFyaXkwQ2hJVTRE?=
 =?utf-8?B?RUR4Uy84bVF3YzlFM0gwYURVdmhRVWxMdXdtamphSldnY2lJQ1JJdDhVcVgz?=
 =?utf-8?B?emRCYTRBWmVQK1NqQU16Z3hydHptVGlTNGkrdURvcUxCZnhrS1JBR0RzRmtw?=
 =?utf-8?B?eW5nUUpBRUxqcmJFVTNHUDl0SWRXS0o0aWhXR1BtcmpKdVpCUzJiQjVKcS9m?=
 =?utf-8?B?Ni81aHJGR0FXMkJkZVlHRUlFb2tHdkROTGREVVRVU2RRVVJHTmx6TXdKMVNz?=
 =?utf-8?B?VHNsQy80akFxRnBWTkF3NmVMNFVJMmorejRQNEZOcEQvQUFSOVZ3c2s2MVRi?=
 =?utf-8?B?RFVnTVBaaU1yV1ZoK2lKdkowa2U3QkNpS2NtcXo1NmJmblNWWDZKWjRPZWlT?=
 =?utf-8?B?UWZUUGc0aThqWUNqVmJhWkFWeEk3SGtIdDFEcVBDYWZ4ZkpkZE9qMXphRWZM?=
 =?utf-8?B?N2QrMkdOVHRRbUVtYWY3cFp5LzZZeHNsMklpQWFhWGhLY0RTN0tzbUwza1Fv?=
 =?utf-8?B?MXNJeG5aVzFRbkVua1lDZTQwRkJjaVVIbVo5RGo4TFZoV2grUDRlOVl0ZHR3?=
 =?utf-8?B?MnpIVTVaNUVWVTcyUzdUbU1WQjJHcHlxbmVpZ2xrYUdFOUMvK2s1NnVCZS83?=
 =?utf-8?B?ZEJBdFBXaFRQMkdMYTJsT2pTYlVocEMwRnpKazB5cG05T3VVamZwVzJIdnQw?=
 =?utf-8?B?OU9TbXdLQ0RFamNIai9HTUwvSmZMMTEwd2gvU09LaWdhUnZHRFJLWkZNUlcz?=
 =?utf-8?B?WG1XNC9mOHc1RWR4Z0RldXJHcXZDbm0vaE5MMUlNTFRUcE8ySnFYVzlXS0dD?=
 =?utf-8?B?SnIrK3g2TEF3b29sc1V1akxNRThQNHRJZzZUbGxwbzNUSHlkY2MwSXkrbGRD?=
 =?utf-8?B?MDVrNFovY3JBa2R2anZKaTZkZVQ0S3QwendFb1VBK3A5VGpLbU9aOEVKcExO?=
 =?utf-8?B?SksvNTY2RkFXWWg5bjV4ODlwRlpjYnluRm5tc2wzN3V5NWorMVV3cVB6aDJU?=
 =?utf-8?B?TkJMbnh0YXI3Z0VtdzlHa0lpNmlHT0pLV0s5WXVIcVdHVitpeGlSaFlBbm5Z?=
 =?utf-8?B?YklGeE4yd081MHVXcHRhUWtydXpDakgxYkVUQk5GZW1RdWwxVy9xRncyeE9y?=
 =?utf-8?B?MWhqMnhUYi9iR1kwekFzVmxlbjFJOThvWmRRTWl6ejBsK0xJaXNhTVRUWGFh?=
 =?utf-8?B?Z2E2NUFkY1MxaWgvTWY4N0l4MjRTeXZySzh5Y3k4Z3ptQkVLL21uaDRlSU0r?=
 =?utf-8?B?eUFZK2pHY20zTEI3TmJLQStTRDJlUlFTeXVobHNrNXNYSWhMV0NKTk1KRzRs?=
 =?utf-8?B?WEMrb0JwYndjeGN6cXRmMFh2azNHS1psTXMwOUt6MktRNTc4RzRXanVoQUxQ?=
 =?utf-8?B?RnRqaE5IY0hYU08wcnA1VGUycjg3SEw0YXRreVltS2RIMnVxM3dNQ096Nm55?=
 =?utf-8?B?dit1RVg5YVJYV0lpNnc2VGs4MFlUcVNyUWMxWlQrTm5WQ1pvUC93MFZsQXBT?=
 =?utf-8?B?TE9NdnVDMUxscDVHM3VqQU4vWCtQQ2t3LzF4NXJXT2t1Nmw5R1Y4YzEyWVlr?=
 =?utf-8?B?MzZWY1N0OE1QUy9WSFI4Ull3MXg4Q3F0V0U0RTFMbWd2MkRoU3hCb1o4UU9k?=
 =?utf-8?B?eHRrNlpack5vL1lMUUVEZDcvMGFaaDBIRVA5Z0hHa3RvME5mcWg3OXNkQWI0?=
 =?utf-8?B?b0tHb2IySndiNzg0aEducmVPZlhnY0VLdEdLb0NqYlF2d0dwZVhId3c3cGFm?=
 =?utf-8?B?V2lBSXhoR3pxQjNIVHN6MWttRmI5eHRqSlBRYVFlRUFhcXRQSzQxRmV1QkVi?=
 =?utf-8?Q?TCCo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e3f4ee-4af7-41f9-a1af-08dad9297ecf
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 14:35:47.2331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: snAXK0VZxk7d4AhKXDx6XJVk6328dAlC0auDktBV5GQRaqr1Dbj5kqMbYTZI0/1V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5061

On Thu, Dec 08, 2022 at 03:18:49PM +0100, Eric Auger wrote:
> > -	dev_warn(
> > -		idev->dev,
> > -		"MSI interrupt window cannot be isolated by the IOMMU, this platform is insecure. Use the \"allow_unsafe_interrupts\" module parameter to override\n");
> > +		dev_warn(
> > +			idev->dev,
> > +			"MSI interrupt window cannot be isolated by the IOMMU, this platform is insecure. Use the \"allow_unsafe_interrupts\" module parameter to override\n");

> I really prefer the legacy VFIO warning message: "No interrupt remapping
> support.  Use ...". IRQ remapping is the feature that is actually
> checked. MSI interrupt window sounds confusing: is it the MSI doorbell
> or the range of addresses that correspond to MSI addresses.

Well, that is true for x86 processors, but it is not what it is
called on ARM. I wanted something more neutral, but am not fussed
about it.

And I suppose "by the IOMMU" is not really acurate either.

How about

"MSI interrupts are not secure, they cannot be isolated by the
platform. Check that platform features like interrupt remapping are
enabled. Use the \"allow_unsafe_interrupts\" module parameter to override\n"

?

Thanks,
Jason
