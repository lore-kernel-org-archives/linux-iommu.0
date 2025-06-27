Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2926C2F1FEA
	for <iommu@lists.linux.dev>; Fri, 27 Jun 2025 07:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751008754; cv=fail; b=Y7mrnji7a9sLPp62oa0DOiKLH+QpmcTxdQi2yXFeNu1oWaTRhh3JPRxUQWfTG9B6OAabnqRlBaelP7PWg+S0qtINFXyMY7e+YLqrp2q5GTgQOO55VZekZJEju263M+3QwvkMMDuIHGCvrJUiqBpZyP2DtoTFGnEsyebfkMMlPCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751008754; c=relaxed/simple;
	bh=OTZRihasDy3jgFtEVJdr+eeOH7zZn7IV0rgZKQhTOSQ=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=pNnO43N/Cx+4RGHMmb5Sxq1En8p8PYeBTSfUe/bcT0C6J9lI0r1G76tmhV6rxj5daacvawTGRqM30V4l8OQ3QtFx44+sbPrQ6LCfhsQYpow6YGPKyFq3mEhhvYqbRIvu5Hx7c1+3+Ed4uw1uCLuZ+rjgUgpJzVu2Dgxia1zOFN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=N58rYj2Q; arc=fail smtp.client-ip=40.107.92.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="N58rYj2Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LwPW9QrTbx7juRBd05qhUOBnLILRENDvwW2iyYUGc/UXj4nHIzEtvMOSLoHb7+Davrow9nEi6rX2aAHDb5TPqokvDqcvg9mBgHVDfEi8irZw15YAGfDfXPzKgNVdJyJx+a4OsZPDwdf+S6jDfX95M/bhh2tv9tPGKccKKYt8p27H2cYOgLWORmVTciYxWWeXH1ulIu1vW+dQts+PYM2qiogdNaRUdeIbRSQmWgloAJyIUteh2/x3nkdDXclaFLAhHjRGCFPx6NkXMnWiMo5lMyM26/Gt3H7GJbzXT1+7PzhE5RsbaxjggNHnLsEjmrn7IlCbryvDGxINTVN1cDvmcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J1Z8n8aAl3ZHMZ48rqbYv5DDN40X8zAOgVlw/5YboVo=;
 b=Fp5dxiop+qcUKghN6B/gd6kAh0hxKOrrEMDi9+Rpyi2XUBUBsbTidRvc8xm+DOji+VGHhVZyNix3skI0aTHd4SJzmC9GuoCe4LuwG+jUSN/W7s9u5aVxG/RwOEfvmUdexcNqW2kCZLBaZYgWV98CnFkK3CAQPYffPbnDEdQzXR9FJ5D5Oq+AAMh8gqVtX8y557wJmFYBWlIZs4BWzAY4S/gXtd9ENS/VpS+/lFQQrT18KUpfF7Pqu+AiGkGyufY8mB2D8JRHiqgTtU1DM/iXKgb88q6EgXXHJbFe4Im+xjnqM+Ob3utFGRCx9ef5gyCwNJ5LwLmQUL4b16orAcRCHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J1Z8n8aAl3ZHMZ48rqbYv5DDN40X8zAOgVlw/5YboVo=;
 b=N58rYj2QMPv7KQDAE8CyQG/XlxQeaj4St6Wv17uRqOYTBkvaVtEFPY0NViCiKmvtbFHCKwLkgk9NVoj8wiwVCc0mTA0kqCRgwhZ1Kn07t3YVQvPbcHHuCcbyARbq8fvsuBbq6PmS+qGZJ6dxMbKYNu8JgDwRY01lfd96TfZ6C2Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CYXPR12MB9385.namprd12.prod.outlook.com (2603:10b6:930:e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.22; Fri, 27 Jun
 2025 07:19:10 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8880.021; Fri, 27 Jun 2025
 07:19:09 +0000
Message-ID: <0482d84e-871b-4522-b94b-29a97c87ff66@amd.com>
Date: Fri, 27 Jun 2025 09:19:05 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Subject: SMMUv3 interrupt handling via custom logic
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 "Stabellini, Stefano" <stefano.stabellini@amd.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 iommu@lists.linux.dev,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "Sarangi, Anirudha" <anirudha.sarangi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:a03:180::16) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CYXPR12MB9385:EE_
X-MS-Office365-Filtering-Correlation-Id: 67fc30b3-b537-48c5-307c-08ddb54ae8e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NnhYMThiamlVNWlWRVdkMUowYy9aR2IyeXphY3NQYWN0TElMNjkybkRqSTU1?=
 =?utf-8?B?amNNQk9wSjFyK3NqZ2tYVEg2Q0hnTExIbk9IaDFzWUVVbmJQOW9IUHlMaXJq?=
 =?utf-8?B?c2VNZXF5N2h4T214YklvK1lQeTV1d1hPSzFsb29uSHVvVWI5cnVNRFRoM1cz?=
 =?utf-8?B?RDM0RGdmaWdNL2lFL3pTZlRFa3ZKbEphQmE2WUhCSFZ1OVZCbFdVZWdmOGhU?=
 =?utf-8?B?Wis0UWlpRGN0SlBvU05nTlZ3M2VnZk5zT1JCUitwWVN2UUlWRXFtUUtGWGJD?=
 =?utf-8?B?SmNhUkYwUDR2bEJISnZXbnBacHF5aUpNbmFsanllVERjeWF6RkdIK1Zwc2t3?=
 =?utf-8?B?UUNHaVJxSHpld0YrMi9TRGk3ajB0NWZyblRRc1FiUUdJeFBNSzVqWGo2Qm1Z?=
 =?utf-8?B?clRlS3hIbDNBQzRNR25SQ3JWbTJhb0FnU3BTcWN2YThBYXhWWEdGeGppVGZS?=
 =?utf-8?B?RlVDaUtDVmFxbzg2QlE5b2hvQm5IK2d3TkVMQzlxL01LMUFaMFViSFk1SmFl?=
 =?utf-8?B?dmt1REdpQWJUUjZUVExwNWQyWVZUV3Z4SDJCaXY5MWhtYkxoMFpsRGJBVEVX?=
 =?utf-8?B?NjJ0L0lpU1BsbWRIU1FjL3dka05uRDVFTEE0OFZWbTlkTkZrUXVObENySkFL?=
 =?utf-8?B?ajBwZHBGd09aTmpodkJkMndwdUQyS3kwT1V6alR2cEFEeUZOVk9oUnJMY3NR?=
 =?utf-8?B?TEdNTmtyTGV5cWpUamsvQVpCb3pYak1NNUVvYWFXTzlnY1NEZVB0bzEvTjRV?=
 =?utf-8?B?NGVIZFdCUmNEaXhUd3Z5aXBVdGJFYzROVGxxV3d3bisyZXdENVFGTTdvZFFH?=
 =?utf-8?B?bVc5S3ZUdVhrbTZvTzVibTZQVWtnNnp1Ky9MV01raldnY05iU1dtUnQyMDRk?=
 =?utf-8?B?YVdENzc0T3U5Sm5DbkxteTBKc2VpUThEK1VWbEFSSE0yUTVCUVMvSmpqcStm?=
 =?utf-8?B?OFZvbFF1aXFHbThYRG9vM2pBN0poUzlPWU1kNDk2UHZlTFFpc3d1bHUxUkZj?=
 =?utf-8?B?L0F0bXVEZFMxUnNoY1hTQVRKb3czdlNKV1dpakt1Ri9LelVwaG1KYjhBaTAw?=
 =?utf-8?B?SDYvYnk1dnIrSTdtOG1scmFRalpUTm05M05od29TaHlnR1dvN1d4aEJ1U2tK?=
 =?utf-8?B?bklVOUxPQm53NGlKSlRWa1R4SlZUT1VJRHBWTHI1WXIvM1RZeTZqWDd6TWs0?=
 =?utf-8?B?dlE2Nkx0dCtqRXE1TTFOZ0tKTUtLZmhoc2JjRUl1TFFVMVBYZ0ZmSkw3MTYz?=
 =?utf-8?B?OEorTDJhbUJNRksxdWltblBTUjFjTmdIZHFNR0tUenkxcnRFR0pZQ1dwNjgy?=
 =?utf-8?B?eTdqYkdDMFpuaWphRXdTK1RpWEJ4cHpVT0JBTjluN1FLNS91cit6aklCMnEw?=
 =?utf-8?B?ZGE1amphd2Ewem9HYVllYktrZ3pIQm1PZGU0N2xtS1lZVVFFNDEyQnAvc0xP?=
 =?utf-8?B?Wk8rUC9vY2F0YmxNOXQxT1JlVVpBMy9QWkpZVVlDTmtOQVlFangxV01hamha?=
 =?utf-8?B?SUNzTEZ0UzJCNFRqM016SWg0eGlKV0hpRmJrZHY4aHFSdHhJWXRsUE40ZExq?=
 =?utf-8?B?U0hFaW9nVjBYemlOZVRQNFZSWmJ3THpHdzFkNUp5VndvbmZDM3E4M1hMejBz?=
 =?utf-8?B?R0VyQXNldStFYXFFZHpvZmVQa0xLdHR4STNwKzJtRWNrSG1WTHNZUHZwYitD?=
 =?utf-8?B?dUlibGU2bElxaGE5V0Y5RVpuQUdGRHBEWEFNbDFNb2wxRHlQWmtYY1lFVTFm?=
 =?utf-8?B?Vi9NcmNEY2hsRkgzVW9EMzdmV1pTODhaejZLMnBaL3p1VTJ6OTZBRldFOW9F?=
 =?utf-8?B?U1dQeXJNQnVwOTdnakpsaWMvMC9MT0NkcXJrVkpaR1BLWGtRNlc5blAva042?=
 =?utf-8?B?Q2ZIZ2lROE5tYkYxZGtUOVBPNzZDM0FEOHRwTldJdzhvTHByWVFXUlJCb0pa?=
 =?utf-8?Q?lw2Lp7XQ348=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YzYxTjVzNUJ4MVZDeDBRUkdDQi9qSHI5MVUydWdVTEFIcUlOaHNYKzV3YS9J?=
 =?utf-8?B?UTJnQmh6dURFQU15TWZBSmY0ZUVUYXlrbkVXRlM5dTdhVVJOc2RjL2g4NTBv?=
 =?utf-8?B?bFhieVk2Y216SXY3U3V4RFUwM0kzWnpLVjU2akdZOE8xdWZCRERNYWZaMGti?=
 =?utf-8?B?cVVFK2RuL1FMWENsSml5RytMcmtkSDljenQyTWRtWDZXaEVqY1dPV3lPeTdy?=
 =?utf-8?B?WVh0RjgxeUJEYks1clhiTmM1NmdkT09QT0JIaDYyU0dZSEFqeTJITmRPZ0da?=
 =?utf-8?B?SUY3OEtEN3Rka2FkQldyTldKSG9hMWwzdWQwdFpxMWNVNUZTdTNzWmhKREt4?=
 =?utf-8?B?V3ZicVBLOWs2L1IwTm0welpmWWhIODRtcFgvTnZOVnh3Znl6aHhoMXNvWFJL?=
 =?utf-8?B?Z3R3WTFlVUluQlQ0R2ZDclJLUkRrUnAwdUY1Q2Z0eVZCazFVTWhkeC9DMDBn?=
 =?utf-8?B?bXBVUmdmOWZjY0k2M21qVkRxQ3FER1pkYTdlbGY5SUlCY1Qrc0VhNi9YMUNW?=
 =?utf-8?B?UVR5R0UxNlE0Szk1VEpmNWtWQ0hKSXRqUStnbGJhbFdrOW5od285S0FlUlBC?=
 =?utf-8?B?MmZlYzhJTzhwT0ZpbG1sSkFQY2hNbFljb0pXa1l0cUtBMG9tZ0p0ZU1Bd0lj?=
 =?utf-8?B?RzJKbDlVK3E4S3kyZUcrRkhlTDBMZHVyZmZmbWovNzRtaEZ0b3lXOUFBd1VF?=
 =?utf-8?B?eEExSGczaUhrRjh0SFFXNTF0Q09NclhZaUc4Y0JkeE9UQXJLc212QkVMYVoz?=
 =?utf-8?B?bjhJRHJxS2c4aXlMOVR0S3ZlSUMzalZFYkkvSTdaWEZCZVNIYUE4WlhSaW10?=
 =?utf-8?B?aXZZRWpBNjk1YmxxNWJFTVY1US9kV1VjTldaR3d2Sm9TbTE0ZVVoN2Y0Q0d2?=
 =?utf-8?B?cEM2djUzN3BVWWxDUllQeFVXNE40YzRiR0tEMWxvcTdYT25zVmxmb3V6cU1v?=
 =?utf-8?B?ZUhqRysyZldOVTA0ckNnM1BrUTEwZDJSMXJ2RVh1NkZyYXdQcUU3Tjk5VXky?=
 =?utf-8?B?NjZEa1dMazNLci84NDhzSDBHNWh4Z3QyV1BiWmZHaVRHZHBrMFFrTWhTaWJX?=
 =?utf-8?B?dE5PbVh1U3RvOWpibi9VdWkvSFdNM25lbElZRm9Hd1NSUGVSYzAzUlY4RjJu?=
 =?utf-8?B?U0R6c3VDUm12bmlkTlZFVWg4ZWdJSjZjdEdNWDJYMmx1WHViNWF3MmVCNk5S?=
 =?utf-8?B?Wk1LYzdzYWRKR1dRMzhwamlqb1JCTzlMdFY3U0JNMUVzSCtMeVhiSjM2Szdh?=
 =?utf-8?B?YlVwTno0aWxtekxSaWErZXMxV0s0TDg5b013WFFGMEZuNGxCY1M5dFJ6RE50?=
 =?utf-8?B?bVB0dlY1ZUN5U29ITk9zazFsUUNqS1BkcDZoMGMzNERpbHh4MHBWQmNPVkRP?=
 =?utf-8?B?b1V0Yko2ajZLNE5YakdSWEpUOG8yUlg0SDZFbTdDcmlnSTlOTEp0NmRZM1I5?=
 =?utf-8?B?dzR2YkUwQkNKbkgvcFRoQVNyVjVyRnBPVHlmS1RXZlNkc2dmV3crVUpxYjFX?=
 =?utf-8?B?dHU1S3FNaXNtT3ZOaVVlR0Z3NUZBUlNZRDRQYkd0NENBdVRKOXRlMTJIQm5K?=
 =?utf-8?B?UkhkdTRVYmpPcGgxVTJkVjVDVCs3L1NUR3RxcGo1dWtvOVdmVTFYMXpsQ2xs?=
 =?utf-8?B?THRGWTQ0Z0N0Q0kxR2o3YjAwWVdPcXM0OTA3eU9hYkp1Y2piTHY3cVdjd3ZE?=
 =?utf-8?B?L0M5dzdjYnp0UHVIWm1ORFh0YVdqV01wdjBCQmFEYVJ6aXljb0hPZ2UxQ0M4?=
 =?utf-8?B?Q091ckYxWmpBaEVEdUZRd2xCM1lhL2wzOXNJSlRhL1NnWmx4Y0pZTjAyV3V0?=
 =?utf-8?B?UU11QWRScjBZUytRdEFjNGhKck41Z2hkSytKa2RmblM3S2FrejRXd29QTWIv?=
 =?utf-8?B?UmpzcktYVElueFlDNjJ2OENVRUplcE5UMTlFVGZXSnRHQmhoUTJ5bFo0WUdP?=
 =?utf-8?B?L1FnQXRJWWx1ZVp4Y2cyK0lQN01mR25DRlViMis2clZzNnVkaUZlNm80WW5N?=
 =?utf-8?B?UGFBWFp6Mm41RmpBbGhWOW04V0plblN3MS9kcTJXTXluMElxVzFPODZFY1Uv?=
 =?utf-8?B?OHpKZWU4YlNWMWw2cnlFeHpaT0ZxU3FoOTg2WjZIUmhaNVhVOWs1VnZFSlE0?=
 =?utf-8?Q?QAqDo2mciwgXh+77Y98ybbdVk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67fc30b3-b537-48c5-307c-08ddb54ae8e3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 07:19:09.8778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A3+UvqdrZ2540QaFhkD2mUqhjC4lTKtv+Yf+t1qkF/zDb2mnzPy1vOVNTF8F0sMe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9385

Hi Will and Robin, (+Stefano, Anirudha)

We are using smmu-v3 in our SOC and I would like to ask you for recommendation 
how to handle our interrupt cases.

here is description which we are using

smmu: iommu@ec000000 {
	compatible = "arm,smmu-v3";
	reg = <...>;
	#iommu-cells = <1>;
	interrupt-names = "combined";
	interrupts = <0 169 4>;
};

but it is missing one important detail which just arise that actually there is 
additional HW logic which deals with SMMU interrupts separately.
There is a secure part (global, cmd, event - gerror, cmdq-sync, eventq in DT)
and non secure part (pri, global, cmd, event - priq, gerror, cmdq-sync, eventq 
in DT).
Based on my information all these interrupts should be acked once handled to be 
able to get another one.
The driver itself is able to handle them separately but we didn't create any 
solution to reach custom HW to do it.

I looked at f935448acf46 ("iommu/arm-smmu-v3: Add workaround for Cavium 
ThunderX2 erratum #126") which introduced combined IRQs but it looks like that 
there is no need for additional ACK of that IRQs.

The HW logic itself is handling secure and non secure settings for SMMU that's 
why would be the best to avoid directly mapping it in Linux.

One way to go is to create secondary interrupt controller driver
a) ioremap one with notice about secure part because we are using SMMU only with 
NS world
b) firmware based to tunnel accesses via SMCs and allow only access to limited 
amount of registers

The second way is likely create any hooks in the driver to be able to provide 
additional SOC specific hooks.

I am not quite sure which way would be the best that's why I would like to get 
some recommendation from you.

Stefano: please correct me if any of my description is not accurate.

Thanks,
Michal
