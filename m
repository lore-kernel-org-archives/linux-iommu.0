Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010030.outbound.protection.outlook.com [52.101.193.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E3E158535
	for <iommu@lists.linux.dev>; Wed, 17 Dec 2025 21:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766006123; cv=fail; b=KRhudDkUl1uCNuLh7BY+U65XnzbC+yHo9oeWYzPs6foKpwqB4GgHFaAhE4CBTnTf4nJD9iilpVf89UvnywEZ82GjEnwoUNI5vpqLSgz7Bj/hKwpULL4jCmNNHKUzXuuwT/fiwT3RG2hAYPRMlJ8hYHS1v+c9gHTvAC6FkZpDsX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766006123; c=relaxed/simple;
	bh=Kix0Bg5WmrY394LR3toCr3NzIZ7H8gZXbnPWA4UONiM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cTa/iHAz5CCQjj5ha+4PqeT3ZwIiYD0CeaY6089DCkTbhOVqwvxZW0NxZQLLLKDre9fsmn68n0NOAB+6cQNtHrSkDqIkRJnrplYijB9Tv9tK3/5JV/8D+HbyaAYa2fyhUubiEUJRGX/9sAmWcU9R8FKC0obUuMU8EIdGpRliP1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uoxeNOGo; arc=fail smtp.client-ip=52.101.193.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uoxeNOGo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RNTfDZMJ6FNBUViabMZvgb2Me6vHVc6a12l169pwD31YpMX3vmqUK8O6g/cYFrd3G0uqhnoFCSjM9GkAwB1pgSIB16vXGjP5Ywu4AIH+v+zG5NU24AUpe58hh0vg6XqIBKDOFPNEvj7HbVejCINCzZqn9fiMsdW5DjCziHY3m7E5JLrtCJ2h82rR1KRi0nACBpROmFUo7zwZN9EjEA8210xgyaU81ZGZlOs+V4NE4w03nkpl8M73YWLpBoJHbtdoNaedeTk1OsohDB56X6MP1+0nDLmRaWM1uxPCwP/1B2PIDy6kbYNT33uGldIRspBQZbaKpf33H5GcKrRsYWqBnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9n4jhjFePTS9/IljxavjRwXAbxRiqON1Ih8K7F1PRpw=;
 b=EKYDTfH23px7qJ5byrBY4Jn5PtW7d7XQiq8i8R+gcEsrIV7BzZ6FAgVtF9Yw9nQmjqyDSAnGNpUDzGXbaLc+d2yiFylwwx6Z+JWZe70lbUcs5rFWaSbyvsS17cA/QcorRQa3Y9qNeB1u2cesB4aDJiXmE69uUrWPwj2BdwB32WGODZ4QEs/SdkBXcjnLZG0YNP1dOBMzSeVARTEZM5ijkmBYy82dsPCotFCfij+eVONsZVmNxhRI9kyqB2aAIKqDPDIAsvZ2rkxRbNhl0vzEAq9rxvX5fEr3M/bq6cHdGBidIauqbItGD8CUH9fZIvB0/UAEo/FDnWn5Cm16ITXbOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9n4jhjFePTS9/IljxavjRwXAbxRiqON1Ih8K7F1PRpw=;
 b=uoxeNOGoB+35d1fot3NNEzIrEsIpIF8Ysy/qGlalDDst8jH3B1H6NniCs7wtSEnECODBa9AobHIWIZdq5ig9wRr/cFFWAimZ5uZrkSvi6V5b7GgFDoti6LSZ2AH9n8RuJgk/19w9gfY7C+ezYLSM8qPqPUPXdBcNbb9PCEqt1HU8KQeXT4x2yWURyXo/G1JVjFCTK4Bw7m4s4s9J+X2XBUGKo0S7CgaadhpXc2xIhX3woC/nRmBj8VJRYfbX28bjcA+MRL+9IX5HoEm8DAJS04kJ4cjAnfGm2fbJb6aDLf2KP9bVw0g0/j9ZthTuoDy1BX/YYBI65YZ6VuZsURz2mA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by CH3PR12MB9341.namprd12.prod.outlook.com (2603:10b6:610:1cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 20:42:37 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%7]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 20:42:37 +0000
Message-ID: <325a9641-a3cb-4137-8cca-99597ca2caa0@nvidia.com>
Date: Wed, 17 Dec 2025 20:42:31 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 4/4] arm64: dts: nvidia: Add nodes for CMDQV
To: Ashish Mhetre <amhetre@nvidia.com>, will@kernel.org,
 robin.murphy@arm.com, joro@8bytes.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nicolinc@nvidia.com
Cc: thierry.reding@gmail.com, vdumpa@nvidia.com, jgg@ziepe.ca,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org
References: <20251215064819.3345361-1-amhetre@nvidia.com>
 <20251215064819.3345361-5-amhetre@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20251215064819.3345361-5-amhetre@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0283.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::14) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|CH3PR12MB9341:EE_
X-MS-Office365-Filtering-Correlation-Id: a7ba8578-9ae4-4987-c63d-08de3dacd074
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUIrZ3pBb2NkKzlaaHVqR042SjgwSGxhK1ViNFAra0ltYmlsQWxFZmV1MHFQ?=
 =?utf-8?B?by9BcnJvYW5MWWhOSlBXYkkvWGlWRGYwVjk2czZ6ZjVBa3l2a2xaMWc2bEVC?=
 =?utf-8?B?YzA3NWlKeWx1c3ArL3ZQWExTZ0lISVJibFZlcEVRUUFSSUk0WDNLeE1kWHZO?=
 =?utf-8?B?ZllCS0JwZFoxeXlEZUx3eEpacml4ZC9KUllEWHUyNnIzdmNaTk5KbE5rU2dU?=
 =?utf-8?B?L1h6d0FMS0gvMGNFcndQUmZmMWNteFc3eElMcDVOZ2F6YmxFNGQ5eHhDSnVD?=
 =?utf-8?B?OWxpVytlRThma0grQXBqd24xTFEwNHFqa2QyODFHMlVsYktBM0tOQmVMM3JS?=
 =?utf-8?B?TExCTktkaG5lQldMaXRuQ0ZtVnJUN09NSXRXM0QxdjRiODRGRXZ2T1RJbWxV?=
 =?utf-8?B?VVJ6YUhTQnVMKzVSTS9NMEw5KzlJVWp2V3lDd25kaG9mZDJGVXltQkF2MnZi?=
 =?utf-8?B?eWFVckFuNVVidlR3aXFNNUkwcnJuVEN2UTYrK2w3bHpEc0Mrc2wrbStIVzRh?=
 =?utf-8?B?SlJrZmpSQUtLc3hadFpvVWtxU2JLU2JKeFJUZGppbCtLRlNnRXBQTTQrOHdk?=
 =?utf-8?B?Uy91M05OazFkaWhQN25jTStQNlFYMFdFVlFNM1ZyczJFV2lnTWNZUmJ3dlhv?=
 =?utf-8?B?UXFEcU9oZHFNbnNvMzhyOFU1M2NMQmVJaTI3bU5pcjJPcGZxNFp4dkUxMjh3?=
 =?utf-8?B?TzhVTzBsYXJoemdhWXRSd3N5K2xORmRJUlVQM1Q2QW1zeGszOXJnWUxSNGZG?=
 =?utf-8?B?NzdBZldldVhSdkdjdDdoc2JhZm9kQXZNYWhmTmY4VmZYZDdONlZXN0FvZHly?=
 =?utf-8?B?alhNbEcrYk1UWXB0bVRCa3M4M3dsekFBN0VoVkh3dkU2dmwyMWF5RCtwNjVP?=
 =?utf-8?B?dktJcVdKZU50dmREbTRFZXFlTmVNV1NFMTVLNFU1NENJQ1ZQV01HdW5BRGUx?=
 =?utf-8?B?U25QbW1KNmsydnlidytWRDYzSVhnY2h1UFBLOGw1QUhQNnAyMTA3WE1lQml3?=
 =?utf-8?B?YXN4NFhqRUU0RHBxcTBsNWxnWUFnWlZkanY4MjJpaU5WQlNxS1Vaczd6YTFa?=
 =?utf-8?B?TEVrOVB5SzdGdC9iUlZLNTQ0VmhRR0h0OWRZM3FMbUNSOHdXb04wcmsrNHI0?=
 =?utf-8?B?TVFxa0JQT1YxdEJnSGVxVElpNStPL0xHbHM2d3VVYlpoOG1BRndxL0sydmU4?=
 =?utf-8?B?a3c0K0pNdVI4K3Z3R3VYeWJiYkx4S1JuYW9mRTBzTUlUYS9ISDNiSFdEalBi?=
 =?utf-8?B?bHArVkcrOHE3NUtaYVR1bDNSelNicjJJY0ZmWFRSMWJoalpoMTBHQUV0Nm8v?=
 =?utf-8?B?TUl3VnBpeDJsNU1PV3Z3U1J5SlZWV3puU3VtNzlNbGVMdStMQ2JSNEdVeHU4?=
 =?utf-8?B?Y1FFNXRhd1dNRTZzakVDZXZaNHFMMnhzVzlDVzhlSDFlaVdyZlhmaFRrNTBG?=
 =?utf-8?B?aTVra0dUYXdqVzMrUWRsT0tHeUhGRkZwdlNNRlpIU0E3SVE1dUN4MzNYQXAv?=
 =?utf-8?B?SDc1dU9XNnM5b0xSbUMzMjVhTTBoVU1ONitCbU90NnhTTDlaWU15SjQ3Zjky?=
 =?utf-8?B?MGdPd0hlTGJtbzhZczVjRXZQVnlmODNKZ1U5akQyT0RRcU4yQ2E0a3hxOFZp?=
 =?utf-8?B?T2NLdGlKcG14NWFXeStTRncyd0N2T1IrTTcrY2pHTHZnNGJsMG1IR3QwVitt?=
 =?utf-8?B?Szl5OTNnZDlta1EvR1JZNytiSVdHaGxLTmpiTThIUEhlL20rcGh0ckFjKzNh?=
 =?utf-8?B?Njk1QVR2STRJQlpGa2NOZjJjOU5LaU50cFhVZkZxaXBlSDA2NFFZcVVRQmtz?=
 =?utf-8?B?VEo5elUvMFcvZTQvSWpjelNPeDU3NVVxWElrWTBNeGNKKzBOSzRkZEo3OXRO?=
 =?utf-8?B?eVlnN3ljQ3hRNFRmckpLYU9PNVA3enhmaHR6Wi9MMjJTR0JxRDRuNkRvb3lq?=
 =?utf-8?Q?gX2Ft4wsLGh37zqF2mAywGfEH3ysOq+z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFA4ajhFdVZyaUFMN05xZ1U3RnBDN2kwWWZoOHp2aGMvclZwdGl4NElaKzlR?=
 =?utf-8?B?bEt5Q1FzbXBUa21UWldZeHZZL1I4STVxTThMKzFtRUVEQ3RNcXQzZm80Vnlm?=
 =?utf-8?B?R29INmx1VmdPVDczc0JZaDZDU25RNFlqL3JVVHlRL3dYQVQ1QkNReU5QV1dN?=
 =?utf-8?B?WXVvVVNzeVd5YjVWcm9acUI1WXF6VUs4aDFuNm91ZXRZeHVWeCtuMmpnOUVn?=
 =?utf-8?B?NXA0djJBRG52d2hUT01kYStRSkM4VXJvNjVocUh5UjJ1SzcydlhRNENvOU55?=
 =?utf-8?B?TGREa3dmeTZMUVh2MEE2OHpRaTVUU2pMTmNZUFNoZW5pREhZd2hNZHRCSmpL?=
 =?utf-8?B?YjVib2FEOEk4dFcrNXZxUmkzMVdWSnZVZ1l1aEZ0eHZKay9LV3RRdGIxQ1U0?=
 =?utf-8?B?cUVZcnlvRU8vSjZmYVRWQUJsdDljUFcraUFQcUlTbjQwekNJWTdLUUdCZ0ZI?=
 =?utf-8?B?dFQrdHRobC9Ka2haSENiUndubXIrRG8rNzUvYUpGYXlpSGlXbjFaRzhGaHoz?=
 =?utf-8?B?Tmc5RUExTDA3OG44ekNqdFpiSGFWTXgybU1JNEJINVc0VklkMFQ3Yi9TRjNw?=
 =?utf-8?B?YWV5V0JReUNxRGFkQUk5c2dMcnIvNUxDTks2UVA1UWZvYitBWHZ6UVZTWGN3?=
 =?utf-8?B?R0NlL1NCcktoc3RXYjJDQnd1NlRGaS9venV1SEdScVhzSlpURDRFM2ZJL1lB?=
 =?utf-8?B?QTVoSFcwdWNKSlVNWFc5TFM5TTdWOGx5V0Y3S01laVhPZm0vclRDVFQzTzdM?=
 =?utf-8?B?c09HVFZOWTJDTktPZjZoS2hCK2tmYW1kT01ZU0VmZGpPR1BLQjJxd2FyZEdT?=
 =?utf-8?B?SCt3dTFoaUNsK0Z4TXZPODk2VzhLaFpPdkhZY1k0aUZ3cE8ySkVqRlNUZVJU?=
 =?utf-8?B?QnpsVWxTLzNTTjlNOTFMdTZCNVJhMWw2N1Z6K3JWNnZqSEQ0dlgxbyt3K01M?=
 =?utf-8?B?Z1FIL041QjNQTDNuNm1Ka1pwRkh2d0UxcWJlSC8rOTljQmhJL0M0SHRlaGpO?=
 =?utf-8?B?eksrQmY0WU02OWZvNGVobEtnbytHd29vVjhUaXR5QW1NdnhVVjFOM3lTNUFa?=
 =?utf-8?B?VkdnS0htZzdJNU8rSktCVG5DcFdFTm5wcm40V1gzeGRxUi9OdHVZRU5oL1h5?=
 =?utf-8?B?WmFHWXRHcElFTnBOZXRQVE1iN1Z4L3plOVFnSTk5SmtzQ0taQVBOZXByQ0lH?=
 =?utf-8?B?cVYzSjZlaDM5VmxsMnZmT3dtdEVaOFpnSHduSjdkRnl4MzVpN20zbWlDL3dV?=
 =?utf-8?B?TC90anVPa1lBS2tJYkFBM0d2d0hGZTU2TlkzbEMveG1heHUvWmF0NGdoZlBM?=
 =?utf-8?B?L2d1ODdFNXJYS1UzVGh6ODdpOFBSekFkOC9vay85dWNMTmlNMmZ1dzY2dk1S?=
 =?utf-8?B?QzBNZ2lhZHZoMGF0UkVMQUF2L3QwbkpKRGVzeE5ZeHVvQlg5NFBaTXRTKy9a?=
 =?utf-8?B?UFZGQUpDbUdUd0gyclB0N253eUEwUzNMQklRbjBOWnR2ZmIvU2lqYmt4ZHJB?=
 =?utf-8?B?c1VkVTRTb0JZUzZrN1RZZlZzdEdNQnlsRDAyVWJDeDNGVjZuQ0pNZGtndnNz?=
 =?utf-8?B?d2gwa3MzU0cyeDhZMEVBajhRa3VEMkRnSUdGQk4zd2x0WGJ0bzdXcmljdWJ3?=
 =?utf-8?B?YmM2WTl4QXNvSVRCQWhUaTJ2RXVEVDd0M0phNlJQZVloTWVaWE45Y2ZWTWs3?=
 =?utf-8?B?eTk4SDE0L0Y5MFBLakp6RkFLVlhUZktQVVQyTlhTQjY1cElyb0ZlaHd4QVFm?=
 =?utf-8?B?OTZWMUx0a0tmQXJmWE1Id2lSZlVGWVJaWjlsM041MUFLdURkVXFQRTdaZ0lR?=
 =?utf-8?B?SitYTzFOL1ZnaFZxVzE0R1hiUDF3cFl1YUdDRzlzRzZZck9GdUVFZHBDeHpk?=
 =?utf-8?B?SGNFTHBWRXhTZGxVU3JISms5K3ZSQnJ5SmUySXBkbktzSlpORTdIcHhsTWF1?=
 =?utf-8?B?QUVPV3hNYnIvK0xZeWR2cXAyOXZaL0tDRzh6ZENXTWZsN1NuSitsZ2xxSThO?=
 =?utf-8?B?bzZ4d0o2WTc0dGNEZDM0RGtObmowRWFLRVFKL2N3RUtwQkpIbThPUFpud0V5?=
 =?utf-8?B?QlZJeHViQ1VCSDJhamhnQ1Z0S3k4Q2czdlR6eGJhdmhiWFFYR1UweVBCd0dt?=
 =?utf-8?B?VUE5N0lvMGJXekx5MW5zUDNYMUVMMUo1dUF6cGtJRWhaOU9NZDIvbVBSdW1o?=
 =?utf-8?Q?9zQ6/4clkUrw7OFMK4ZFCs+n4a9TzssHGc0Y1OGOAxTK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ba8578-9ae4-4987-c63d-08de3dacd074
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 20:42:37.6695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XrjPHUWuTlLlDXlnShar+AqL0t8Ru0Y9cK8lEI2SSkFwRFm9qdJk72Qme6KM+1af/NDzM5ecAaaHCgeU2T23zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9341


On 15/12/2025 06:48, Ashish Mhetre wrote:
> The Command Queue Virtualization (CMDQV) hardware is part of the
> SMMUv3 implementation on NVIDIA Tegra SoCs. It assists in
> virtualizing the command queue for the SMMU.
> 
> Update SMMU compatible strings to use nvidia,tegra264-smmu to enable
> CMDQV support. Add device tree nodes for the CMDQV hardware and enable
> them on the tegra264-p3834 platform where SMMUs are enabled. Each SMMU
> instance is paired with its corresponding CMDQV instance via the
> nvidia,cmdqv property.
> 
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> ---
>   .../arm64/boot/dts/nvidia/tegra264-p3834.dtsi |  8 +++
>   arch/arm64/boot/dts/nvidia/tegra264.dtsi      | 50 +++++++++++++++++--
>   2 files changed, 53 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi b/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi
> index 06795c82427a..7e2c3e66c2ab 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi
> @@ -23,8 +23,16 @@ iommu@5000000 {
>   			status = "okay";
>   		};
>   
> +		cmdqv@5200000 {
> +			status = "okay";
> +		};
> +
>   		iommu@6000000 {
>   			status = "okay";
>   		};
> +
> +		cmdqv@6200000 {
> +			status = "okay";
> +		};
>   	};
>   };
> diff --git a/arch/arm64/boot/dts/nvidia/tegra264.dtsi b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
> index f137565da804..9eb7058e3149 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra264.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
> @@ -3361,7 +3361,7 @@ bus@8100000000 {
>   			 <0x02 0x00000000 0xd0 0x00000000 0x08 0x80000000>; /* ECAM, prefetchable memory, I/O */
>   
>   		smmu1: iommu@5000000 {
> -			compatible = "arm,smmu-v3";
> +			compatible = "nvidia,tegra264-smmu", "arm,smmu-v3";
>   			reg = <0x00 0x5000000 0x0 0x200000>;
>   			interrupts = <GIC_SPI 12 IRQ_TYPE_EDGE_RISING>,
>   				     <GIC_SPI 13 IRQ_TYPE_EDGE_RISING>;
> @@ -3370,10 +3370,18 @@ smmu1: iommu@5000000 {
>   
>   			#iommu-cells = <1>;
>   			dma-coherent;
> +			nvidia,cmdqv = <&cmdqv1>;
> +		};
> +
> +		cmdqv1: cmdqv@5200000 {
> +			compatible = "nvidia,tegra264-cmdqv";
> +			reg = <0x00 0x5200000 0x0 0x830000>;
> +			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
>   		};
>   
>   		smmu2: iommu@6000000 {
> -			compatible = "arm,smmu-v3";
> +			compatible = "nvidia,tegra264-smmu", "arm,smmu-v3";
>   			reg = <0x00 0x6000000 0x0 0x200000>;
>   			interrupts = <GIC_SPI 1 IRQ_TYPE_EDGE_RISING>,
>   				     <GIC_SPI 2 IRQ_TYPE_EDGE_RISING>;
> @@ -3382,6 +3390,14 @@ smmu2: iommu@6000000 {
>   
>   			#iommu-cells = <1>;
>   			dma-coherent;
> +			nvidia,cmdqv = <&cmdqv2>;
> +		};
> +
> +		cmdqv2: cmdqv@6200000 {
> +			compatible = "nvidia,tegra264-cmdqv";
> +			reg = <0x00 0x6200000 0x0 0x830000>;
> +			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
>   		};
>   
>   		mc: memory-controller@8020000 {
> @@ -3437,7 +3453,7 @@ emc: external-memory-controller@8800000 {
>   		};
>   
>   		smmu0: iommu@a000000 {
> -			compatible = "arm,smmu-v3";
> +			compatible = "nvidia,tegra264-smmu", "arm,smmu-v3";
>   			reg = <0x00 0xa000000 0x0 0x200000>;
>   			interrupts = <GIC_SPI 21 IRQ_TYPE_EDGE_RISING>,
>   				     <GIC_SPI 22 IRQ_TYPE_EDGE_RISING>;
> @@ -3446,10 +3462,18 @@ smmu0: iommu@a000000 {
>   
>   			#iommu-cells = <1>;
>   			dma-coherent;
> +			nvidia,cmdqv = <&cmdqv0>;
> +		};
> +
> +		cmdqv0: cmdqv@a200000 {
> +			compatible = "nvidia,tegra264-cmdqv";
> +			reg = <0x00 0xa200000 0x0 0x830000>;
> +			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
>   		};
>   
>   		smmu4: iommu@b000000 {
> -			compatible = "arm,smmu-v3";
> +			compatible = "nvidia,tegra264-smmu", "arm,smmu-v3";
>   			reg = <0x00 0xb000000 0x0 0x200000>;
>   			interrupts = <GIC_SPI 30 IRQ_TYPE_EDGE_RISING>,
>   				     <GIC_SPI 31 IRQ_TYPE_EDGE_RISING>;
> @@ -3458,6 +3482,14 @@ smmu4: iommu@b000000 {
>   
>   			#iommu-cells = <1>;
>   			dma-coherent;
> +			nvidia,cmdqv = <&cmdqv4>;
> +		};
> +
> +		cmdqv4: cmdqv@b200000 {
> +			compatible = "nvidia,tegra264-cmdqv";
> +			reg = <0x00 0xb200000 0x0 0x830000>;
> +			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
>   		};
>   
>   		i2c14: i2c@c410000 {
> @@ -3690,7 +3722,7 @@ bus@8800000000 {
>   		ranges = <0x00 0x00000000 0x88 0x00000000 0x01 0x00000000>;
>   
>   		smmu3: iommu@6000000 {
> -			compatible = "arm,smmu-v3";
> +			compatible = "nvidia,tegra264-smmu", "arm,smmu-v3";
>   			reg = <0x00 0x6000000 0x0 0x200000>;
>   			interrupts = <GIC_SPI 225 IRQ_TYPE_EDGE_RISING>,
>   				     <GIC_SPI 226 IRQ_TYPE_EDGE_RISING>;
> @@ -3699,6 +3731,14 @@ smmu3: iommu@6000000 {
>   
>   			#iommu-cells = <1>;
>   			dma-coherent;
> +			nvidia,cmdqv = <&cmdqv3>;
> +		};
> +
> +		cmdqv3: cmdqv@6200000 {
> +			compatible = "nvidia,tegra264-cmdqv";
> +			reg = <0x00 0x6200000 0x0 0x830000>;
> +			interrupts = <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
>   		};
>   
>   		hda@90b0000 {

Looks good to me.

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Jon

-- 
nvpublic

