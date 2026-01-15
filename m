Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012033.outbound.protection.outlook.com [52.101.43.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE0833E36B
	for <iommu@lists.linux.dev>; Thu, 15 Jan 2026 09:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768469079; cv=fail; b=cEOHBj7KRUfju3LmmP+0tvbClGZ1XOt/EdY+4H2WErTH/HlDXCpRQk0Nr5FhxJfOPzCYgeSYBBC1SyZfo2CJqilGWAakyoEHLk42rNZcQgBxeli227nQHL+DBt8UKnV5iKcT3L2m1gkSHStMm74nzfFiWVKgDhPqQbB0vGo88bI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768469079; c=relaxed/simple;
	bh=r6qHPNvg5GBXx3Jf665Q/CiOOToiX9MCOfxLbOuzADs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Zab0iWcNA1vTBZk83yPoPmCiNU6HabAclUPWCA0LGt3I4aHupIgm++Mvzh+UvGqKIvFwE+EMbLQ5S6hYiP8DxNe55cu72pJLXCMF9JJ20895+VoaSg3LP4na/uhJUKoSbLQ0orJGSuDsY6mwnGLVGScjZEh3fmp4BqsgXX4Dy3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kjQ9WJZM; arc=fail smtp.client-ip=52.101.43.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kjQ9WJZM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W7Dt1ca38WXVQvE+8z1P6mfFAOzgznwucc8S+Lipvce9g1QxiPKP7ia+8NNd8OhA5riE4FQAs2yOZyrOfWYZvi3oGSzh69d44mesKhzIA2vgk8o7RgK/wiiaFiEGZxIcjtCWuiNro9j8sI3HmFrI5+VmdrxRT5ZA6KMOvSB/Sd+TpnlZaCCRxOtBJM5H5+RKa5yW+10G7yZeS1sj5VT4ifxi786cTFodFOujaJkXNCzz+DnGPPuQveCBgsJxt2Iggzr1Rzj7MfULkJg31vESvnnuVAuS958BnQwlyRaiA23wdyHetGYdqCjYrO1FvvoUf7d0W9U04w+rDIPQ6de+YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ofIN0dMaGQQ5lGizwwmV1djtVGlsUhfgFh7RtGfuJVQ=;
 b=QuQiFBRsQ3xsMxfOB/5QipSOIWKWOVOd07cyLH2u4/INZFtwu4z0fZJf36nWyjg0g6Q4YRJYov2KSFG7ueciB0WVb+Zo96PWz0KGF29sS9/AHRVgThF+lJKduraG7nLGq2bkZNeN2nwZEGTAEcYO1UQ/giJBmUoDoxYq3QtYnCAgdpZ+RvGVf1Fkvml9RnwhnA60JHNvC55elsVD9mGt/4I3qDPCA4pgwWtHUhk0W+9iizmM6+vnEpJODEc8uIB6TL0RTV3PtJDCMk1Jq5KBYKABFie5qGp0XLWBY7WkCFf3PNGwP1ouFSfqpN6vfCn9WMTTrriHiVMduGpFNIXFOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ofIN0dMaGQQ5lGizwwmV1djtVGlsUhfgFh7RtGfuJVQ=;
 b=kjQ9WJZMq/bn63DPHCgAh/2g6VilPjDOkyvxRLbFzZEybvjKIKJiygMjLYcdZ8XLn5/lwcmGucx76Gs0/zRbwlgv30vE6fOndxRmGuL975CkqlEqp8h13ZkCYXnGley99/vO2eLnjhJuSKeCzaGHkATTuZANvXAjL0BbXXcmbTY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 DS0PR12MB6607.namprd12.prod.outlook.com (2603:10b6:8:d1::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.14; Thu, 15 Jan 2026 09:24:34 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::b5e5:12ea:9815:b7d4]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::b5e5:12ea:9815:b7d4%4]) with mapi id 15.20.9520.003; Thu, 15 Jan 2026
 09:24:34 +0000
Message-ID: <12c1f0a3-5f55-4773-bda5-d0831947adbc@amd.com>
Date: Thu, 15 Jan 2026 16:24:23 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/14] iommu/amd: Refactor logic to program the host
 page table in DTE
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, linux-kernel@vger.kernel.org, robin.murphy@arm.com,
 will@kernel.org, joro@8bytes.org, kevin.tian@intel.com, jsnitsel@redhat.com,
 vasant.hegde@amd.com, iommu@lists.linux.dev, santosh.shukla@amd.com,
 sairaj.arunkodilkar@amd.com, jon.grimm@amd.com, prashanthpra@google.com,
 wvw@google.com, wnliu@google.com, gptran@google.com, kpsingh@google.com,
 joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com
References: <20251112182506.7165-1-suravee.suthikulpanit@amd.com>
 <20251112182506.7165-14-suravee.suthikulpanit@amd.com>
 <aRZLUc1hvFXEC/iG@Asurada-Nvidia>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <aRZLUc1hvFXEC/iG@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0164.apcprd04.prod.outlook.com (2603:1096:4::26)
 To DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|DS0PR12MB6607:EE_
X-MS-Office365-Filtering-Correlation-Id: 543cb1fc-6923-4743-c5c4-08de5417e588
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Uzd1OUVtZ3J1T2JlVzYwT1J1SWNMMWg2bkZGeDVweGNtVGhIOFh1SHZnUXhH?=
 =?utf-8?B?anJUWXArWXcvS1piL0lQR2plZklNS1IvVUlLOUNsWUFXYXZhRGRxOGhZYTJ0?=
 =?utf-8?B?MVlRYU1UWE96RzNmNzV0dWFZU1N4U3hsUTRiY2ZpbUU0UXVHSUo3SUhrd1o2?=
 =?utf-8?B?VVd2aStiVGdqbkM1b0tkbnlQNFpOb2ZUOVpad01ML3ovOHQ4Z1VUUFB5aEoz?=
 =?utf-8?B?VkZ3QzAvdktLb1pZVWNLbHFja1lIMnlLb0luTFZlMEtwOWNBOWg2MC96TWI4?=
 =?utf-8?B?WDdMQUtQemhtWkNjaW9aV01iVThJRHQwUnhCd1RXeXdwZTd3bEo0Q1FJTnp1?=
 =?utf-8?B?R1Y4bCt4VFJSU3RVdVdKcGR4RkxFZitvSUp2c3NpdlpQRTB0OStveW5QWVdp?=
 =?utf-8?B?NEJuMjYvQ0VxY3QreG5zeWNXWjRKR1A0bXJlNlBveTZRM09YcjZKL0dQWjJz?=
 =?utf-8?B?T3VDVXRXVm5hVFNEVmhGNmNNWnd4TmVwa3lqS215UEJ0TFNuZTlQRjZ0YUZR?=
 =?utf-8?B?eVRDMkpyRlloZjNFWnl1N0d4TUtWYUt6RUhOcGN2cmlJOVgza01DV2Vqc3JJ?=
 =?utf-8?B?UVNBUVQ0QlREYlo4KzErOHJNNy9XaXVYbEZRV21ZaEdHS2RFd3R2UU5mSmRO?=
 =?utf-8?B?K3RGdHhLRm8vTVo2blpvSTM2eEF0bmJaRG5BOVJzOEJ1QVQ1OHArYTlBNDNV?=
 =?utf-8?B?OGJSbkl4dzRVTjRJcmhpWnk2ekVWMHc5NHIzWEpzamlGeUdTOG1XTDYyK1dk?=
 =?utf-8?B?b1djVnJMMnN5OXozbG5IQTFmcXZzcUVWczZvd2NvMVptWE5zei9ZWVd0OHNV?=
 =?utf-8?B?Sk9samhERFVkYlVsREd2NmZ0a2NpV0hvOVUzaXptWmRCalk5S3dZTWxWSEl6?=
 =?utf-8?B?MVdGRmFMaXMrU1Jjelg5d2tVbW9GZ3QzL25aZzBic3VuL0FaY0hzVEhEcUI4?=
 =?utf-8?B?U1BLTXdkZ0QxZXZtc3lJQ0xTSEdXRmpydVlLWEJUWFBaNWQ0aExQSHBwbWxM?=
 =?utf-8?B?WEVRMVBkSlY1UG02VzBJSHJlTnpnUGt5WHE3Y0MvOG9hTWYwQ3BhaEJWT2hr?=
 =?utf-8?B?NnlBdlBmbElkc0VpSTVIVXcraHpUQkQxQmQ0VlJOVENOSG9JdGtMQlNBK0tY?=
 =?utf-8?B?NTFncDdqOGxpdlA4QU8xakdscm9ER3czRHQxVXBzcFB6UE5XSGtGSjFlOUtp?=
 =?utf-8?B?R2djazhMTGZCdnpXd3hSVVZxamFqSjdBakxpVW8xL2c1aGNoTDFXL3lSRUhR?=
 =?utf-8?B?RTBLMGxsOEowUy9RY2h1aHN3Yjk5TGZ5MmE1SWFoRXBEQzlNU0ozc2pjY1R2?=
 =?utf-8?B?UjhMUWVVRTJJQmRjY0x2UHduMjhWL3V3aDRlMTliTUMyQlU3UTlRNTVPS2ox?=
 =?utf-8?B?cnFUMWxJOHpWNW56WFNrUjFiMHhWdlprZTVtQ0RKS0hEVkF1K1Byd3ExeVNH?=
 =?utf-8?B?Rzg1SEhnYXNwMyttUENJMitpd2J0OWxjN1BUenRtb1F6a2NpbjNIcEVvU2Z5?=
 =?utf-8?B?eGFTUGtzNnV2d1FxNU1iNnh4NUY3dXJ5RyttV0tpWVVzZU0zK09ES0NoNTBl?=
 =?utf-8?B?MVN1SGRVc0JQUVIveFZhYzhja0NWM1JBL2MrTGV2ZjVxWmNGc25jQmJuekF2?=
 =?utf-8?B?bjNpaUl3a2FXVW9OMWwwS2laSnBvMGJORjMrK1IwZ0haQjRKSUxkSkYycWhi?=
 =?utf-8?B?UFdFK0JHS2ZIRmVyS2dkZ21UdlQrS05tekcvZ1RGc2Mvc1pGcjg1aDE2dnE1?=
 =?utf-8?B?ZEUrMm56V0N4Y2NsUU1OaU1ScTdzWmJKVEY2eitFYTQvZTZxUnVocXJpVGJa?=
 =?utf-8?B?eDFVSnBZVlRZaWZpcTdwN3V2UWVxb0V3QXcwNS9WalVpSkNTSUxsaEZNQmd1?=
 =?utf-8?B?M0tOUVZQVGJOTWVSNUVKR252QzlIWnYyWW5FRFBBME1MMkxaOXpPYjlXU3pF?=
 =?utf-8?B?eTlSdWlPczg2MGJ1VXJCQkp6Y1JvakpQdFZybXR4RlBYOTVZUTYwSHp1dzYz?=
 =?utf-8?B?M0p6bG16ME85Vkd5aHFiOUtMRGoxNHBvWjlyQkpmTEIwMDUxOUhFYmFBQXA1?=
 =?utf-8?B?NG5LY1RnSjREZUUxSlRPakVQU0FFMDRRZ3lVdXEzOGpkRXlDbVB0eTZLZDZD?=
 =?utf-8?Q?ybG8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGtERjVpSG0xQktDaVArN2RPNFM1d3pyb2xXS1VVK0pGL0Z2Ym1tSzczLzR3?=
 =?utf-8?B?cGVDM0R4ZXJETjdRRFJPZnBkT0Q5OXE5SGlVNjBlbkREUzRwL09ic2ZTUjdr?=
 =?utf-8?B?NDRLN2tqL2NCbTJoelQzUURxS1dJYjZNQ3grdWNvY3ZxVVYvNDZQZzRkTjJX?=
 =?utf-8?B?cldxZHF3SVJzMDA2eitkbDhyU1plN0lvcTVBVWw5a0pDYXRycE9EVU5PejYy?=
 =?utf-8?B?MFVvSjN5dkZZaUNYcnlNTytJalM3RUtMbVdGQ0ZqZHY4eFB1Vkl2cmFNY24z?=
 =?utf-8?B?ZVM1QU5KK1U3dXNKTXVLLzM1SlBVdk5uMU5DcG9MK01oQUtoazV3a0JlWThl?=
 =?utf-8?B?bzhNOEY2dU1OejdKWUdha25KYXNiUzgzNHNFM0gzV21ZeTFrQ0MyVDQyNlNs?=
 =?utf-8?B?ekZsYUdhcjZrbGRaR2U5MHMrT1l3b1N0b1pHNHd5NE5nUERyZWdmZnFFV0Y3?=
 =?utf-8?B?T2czUnZuOWxxeXh2WkR5V0RScTlXSDRqUDZKZGt5WHE5YUFqbHNFb2loTzUy?=
 =?utf-8?B?bXl5Sklxa3NIb1R5YkJGcGQ3b3kwTDRQbFNYYVZpNVJtUUtEYUxLZ2hnL1FJ?=
 =?utf-8?B?eTJHZU9ydDJoS04xc2xZTitkNFZXMnJaL2dJMXZuNmV2SGpnaGg4NDQ2N2VS?=
 =?utf-8?B?YzVNd1k2elhtQmdWdXdISERQNzBxbm4wcGsxTGdzR3FmY3ZCVFh3VThMM1cv?=
 =?utf-8?B?R1J1YWx3R3JoTmt5cU9aS3NoL0tzRUJoRERGSVgvWE1nTm5FcHk2SDcxL2xy?=
 =?utf-8?B?S3Y1ZHhOaDVBNDhyRVYxY1ZKd1hKZFJkN1hoeXBWOFdQSnpYUnpnK0kxaGk0?=
 =?utf-8?B?Q1ZqQi81QlZSbzlKeHVhRkNHZ0swMlBUWFJmVjdCZVFEUzNPU2UyUkt4OFNF?=
 =?utf-8?B?UmNrZnlQSXNYV0dLWFdiR1lDL05yOGk4bFYva0FkMWk2a3VwaFZIQkI0THlm?=
 =?utf-8?B?Y29ORUxmUGcvdUl3YUZEZkMwZkQweE90d2xxK3JEcmVocUdtekh0cmZPRXA4?=
 =?utf-8?B?TWVlclZ1bjcxeVlYSlRzUmxySi9nbUxWZTlNVFhJMEtzcVpuYWh3M0MybmxG?=
 =?utf-8?B?YmNyUTJpeDVESzNuS0sveUI0cDFURVlXalNaOFBidVlpc0NYbUxra0k3UGdE?=
 =?utf-8?B?KzlPbmNldkx1c3ZFSmJ1OHJDUGE5S2VNNXBhYlg3NXNmTDUyd2NwM3dsdUZB?=
 =?utf-8?B?SXNCY2hvbU1xdWZhelNBalNwZDZ0K3k5dmc2LzBvbHhiNW1pQngybStJenVF?=
 =?utf-8?B?cnlnam9YSW9taW10d1VyaDVRWGxjY1Zxdm9oMGowZW90QlI2dndvUHdXc283?=
 =?utf-8?B?VWh2Y21uYVQzTlAzMmlHanBVUTY0dzJGc3lqUUIzZ2d3Z2NsZVMzWDUvNGUw?=
 =?utf-8?B?aGlMdXQybzhRazgxUkVJNmNsUDVvM05GVVpQSWZyOHk4VzdmZlBpR0s1WURQ?=
 =?utf-8?B?cDRRcCs2ZmozUGd4bDh4c2lKVzRTcWU1QVZVdWZuNFZ0c3dPejRPYTFlL1Bx?=
 =?utf-8?B?N2hZTlRtNkszdGtHaVc3RExSNldBN2U3VlFRNU5NZzJhY2cyV3lKY3BZU21x?=
 =?utf-8?B?NmJYOHlpQ043Lzl0K2Zqa0pERE1yUjJSMXNCS00zVlNWbHZUd3c1UFc5Sk0x?=
 =?utf-8?B?N3F6dmIzTVVUTXhidGZRMUtjeldxNTgzNUd3OU9Fclp2QXVaZjZVVkdhclh4?=
 =?utf-8?B?MGRXdVlxcmxsUVVUSWZSby9zTEZTMGRzSzdqRkM3VTI0UnZJRkRZYnEwZzh6?=
 =?utf-8?B?d1ZJV0pEeldIbURHbi8vSkZoam82bXdQcFVSSWRMbm9wY2huZ2tCUzcxWXNZ?=
 =?utf-8?B?ZWFYV2tLc1JFQTdZOGFJc2pGRFpxQTczK28yWFpFZTFhOWdsRTgwOVJFM0xJ?=
 =?utf-8?B?VUg3czhHZUVtS0lXM1I1NUVQbVFQWnc0UDhDbU5wd3VjWUJtUlVIVys2U2N2?=
 =?utf-8?B?dUtIaFhJTzZXUllyYUhQUTlQWXhwaFRMVFl5aG1hSUgybk15NlBybmMzZ0JV?=
 =?utf-8?B?OGR2QmlqeEN4VmpTQWRUeTlaUnpjT015MkJYNlRza3VRNWRjcGFLS1NPYnRM?=
 =?utf-8?B?SDJ6NThrVHhLTjIveGlPTkFVUTlRNVhLVm9Ic1FwQks5QzZkOUtWa1BYSGRR?=
 =?utf-8?B?UTgxTU9kQit1cy9xZ0plaGNTZTQ4U3hKc0picldTc3FiYzNlMzRadUNEbkli?=
 =?utf-8?B?WFB5UE1RVk1MS1ZVSjVhaXFKZkl5OVFBdlpyelF5ZWk5Vnd3THJjYnkrU2U2?=
 =?utf-8?B?NldMRWpZenN0L2dCSm1FY0h0MkVTY2JGZXl2NUVvNmNyQi9adzdrQzBaa0RZ?=
 =?utf-8?B?ekE0Tm52L2FVaFJkeG5vRjFPZkVvemlIUTlTWUE0bXJQNUVZTGJGQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 543cb1fc-6923-4743-c5c4-08de5417e588
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 09:24:34.8410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hwuzm0F4w37e/GMmP0eJSeDEXdEgzMAv8puAUmEI9nM1pQYhMYtpml1CsXB+S2Ehh8oiECKcZ4eMbNYgXhvEeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6607



On 11/14/2025 4:19 AM, Nicolin Chen wrote:
>> @@ -2097,35 +2115,29 @@ static void set_dte_entry(struct amd_iommu *iommu,
>>
>>.....
>>   
>> -	new.data[0] |= DTE_FLAG_IR | DTE_FLAG_IW;
>> -
>>   	/*
>>   	 * When SNP is enabled, we can only support TV=1 with non-zero domain ID.
>>   	 * This is prevented by the SNP-enable and IOMMU_DOMAIN_IDENTITY check in
>>   	 * do_iommu_domain_alloc().
>>   	 */
>>   	WARN_ON(amd_iommu_snp_en && (domid == 0));
> This, if it's very necessary, can go into individual functions.
> 
> Though I am not sure if it is accurate as it seems to imply that
> IOMMU_DOMAIN_IDENTITY has domid == 0?
> 
> But an IOMMU_DOMAIN_IDENTITY does:
> 	identity_domain.id = amd_iommu_pdom_id_alloc();
> doing:
> 	ida_alloc_range(&pdom_ids, 1, MAX_DOMAIN_ID - 1, GFP_ATOMIC);
> which means it never returns 0.
> 
> Nicolin

After more careful review, I am removing this check for now since it's 
no longer applicable with the more recent code.

Thanks,
Suravee
