Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F772C08CE
	for <iommu@lists.linux.dev>; Tue, 15 Jul 2025 05:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752558470; cv=fail; b=XOHnc5TY1UxwA/irHIVQTmkcRCiI/i0Zrm93Gx3Gu7an2qHlus6lyzq11w2fCQT/Ds1+dngFBRyKPfnvsjjzTr2AAG+wGKfOuA+Nn3f7J/xzQnS4pwe1TdCkC00ZrQBcWd8q3PdufZAxof5xn+qZFUt1SxF2ZRtb5WqNxFr5laI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752558470; c=relaxed/simple;
	bh=feowElyk9E6GJlbKVWUgysxaJ7gYNs3g6qzft6JeKgI=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hiXSH9vEUCHYUc2p3nFgtZU1jutPTonODWmUBmICZSGohZXMvI98XqvTTvAiCHpOPlJb4H3B40Bp84aIogGwIKMRzaVW29ZfRTXPxwqOKWDL+n/gdB1967Y9K0Wqew9dgnQaPiG/TXMXEel6DkjyJiibgNcFXw0FX4CYzsalaAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Uw1RQcKE; arc=fail smtp.client-ip=40.107.94.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Uw1RQcKE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KH3ChaaAKXYBTOHvlg27Pvg0qcMJ/fu13HWuCFOOIRXeZMmiGgVy5+B6ApV5c1IXJTpktRZjkYSzZL5BvLd8A2D1QzmPd0iprcTPha669zmvjHmVFiQQwcdtAGh0vzc6vbfe703adjHiNHRDGnOJ6TpvYWMWoQqw139UlCYFAuCnTIzfnKdElvCK43Vkq1PzRAJckt8RSS7z+/Dha2LzUhFug+uRjm8CCRQHK9M9XQe7XPWd8oJbdh2oM4DQqaZgB04kWmy7y8nFhKFy78W84ieugwxKtQvQ74GsmgAmYthdCulBYTS2KNnHDj01CCTYzEiTlWFgSNsPKz3ES6bH/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+zyDP3C12lhp60FPrR7cRwxMRtjEAWNur6OvZMjrXM=;
 b=Gh22t2GlsL+Mbc9G0PBCnF5QXcmXxDR6SA74a+kP4f4yP9PugXkLbg0Vjw9ltYCvxsqo5XyPJHuGOQG0NroFlSYQ/IRm4+7nRIXSr3+F9jDVayTbt+7MJVD4IB8qfx7VfdasPqfw8LIXGmd5htj2Rdh9ZUoaHbFZ3Up0ILk9cX3mkOchMx0hVTpfJTfdsW+TcNs8D6Gq7taTYkN3n4YvnusNYxlvQgXutqGxEZNgbZ7oMeFcRjFgVBE6JBbjbYbVwtD9Q//48uFsPZHjpH4d/cF74qdGeug5c0P15Z0aJ1Xi1LY0vXfvHAr7PWADctGF2bKG+2sgAOkEgY2Ym4CHQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+zyDP3C12lhp60FPrR7cRwxMRtjEAWNur6OvZMjrXM=;
 b=Uw1RQcKEmDYg5GLFu3RLK+UCvibSdJttLZz5alOQowPrMJmJYS2XxfSNncsEOg0k8E/Ud9Zi5lysBkx7/oYtrEBmYFEkvliqDFsgmfvJF4K2t/OKkkVzIK6LyN1XG3CN/dXlkuNk2b5sl1YtQjr/z/Lmq7GVcSaVnnVWX67de3o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SJ0PR12MB8140.namprd12.prod.outlook.com (2603:10b6:a03:4e3::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.32; Tue, 15 Jul 2025 05:47:45 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8901.018; Tue, 15 Jul 2025
 05:47:45 +0000
Message-ID: <242e5925-a0da-43c5-85d2-8796a8e09cca@amd.com>
Date: Tue, 15 Jul 2025 11:17:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/8] Introduce debugfs support in IOMMU
From: Vasant Hegde <vasant.hegde@amd.com>
To: Will Deacon <will@kernel.org>,
 Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>,
 suravee.suthikulpanit@amd.com
Cc: joro@8bytes.org, robin.murphy@arm.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
References: <20250702093804.849-1-dheerajkumar.srivastava@amd.com>
 <aHT1YeC30-ZiyS8p@willie-the-truck>
 <a75aaf31-43e2-4a48-b323-0322f24c3b0c@amd.com>
Content-Language: en-US
In-Reply-To: <a75aaf31-43e2-4a48-b323-0322f24c3b0c@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0026.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26f::10) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SJ0PR12MB8140:EE_
X-MS-Office365-Filtering-Correlation-Id: a4b0424e-45a4-44e8-4caf-08ddc3631f93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHV2aXQ0aDh1TXk4Wmp6REhkbW1zajk1T0U3YnRNcDFDRUtNK05VNFFpeEdr?=
 =?utf-8?B?NW9OQ0RsZDNLTFgrTVArNWpXcVk4Y1NJZSs5emg4VTBFOURsK1lGL014THVw?=
 =?utf-8?B?MXRleXAwSGpQRUZjOFNKbnVLa2pXTnkvVGo3MnEraGROSzFtQS9YVWRuNzNK?=
 =?utf-8?B?NWZIVVlySG0wbHBFMjJOWWNUaEhwWmNZaStHcnJONW90ejZqNmNOa1ZqK1p4?=
 =?utf-8?B?SFJYdHhuK0M3dVo3KzBqQkh1cENQVkxxdXZWT0VjT3VRMFlwMmwweEhacFpE?=
 =?utf-8?B?ejZZVmtGT01SRFRxS0o3Z2pBT2IxRHNldDArN1JNZ0dqOXVpWEh3Nk5YeEcw?=
 =?utf-8?B?V284bzNjQk45UUtNYlRhOTh0bS9iTlUxQkVIdWVZL3VaUmNiVUZ3UHFOZE9P?=
 =?utf-8?B?emRWa2QvQ3dlUktCaDIzbTk1enU4R3NwTld4MnNhWFZxTFY1VXBoVWplMDdB?=
 =?utf-8?B?blpNOE5oWmdqWjc4Wjk4VFczZy9zZHdnVktramIwZGt1bHR5WG55MFpvbFF3?=
 =?utf-8?B?YWFvMlV0MXU1c0tEWERIN25BNS92RWRFcXRYZHExRHAwZnVoL2Mza0kxa0Uw?=
 =?utf-8?B?YVlpUXZFZkx4TjB5akFzQ3RFSlphYjRwMEYzNEwrNFVmcWJIbmVzTkVhcHN1?=
 =?utf-8?B?TjNSb09wdnFRbjJqMjA3YjQwUUlRaEFzV2N3VllYUEt1WUViTjVoMk43Z2Zq?=
 =?utf-8?B?Nk9rSWxiNnNJd1NscVZCdHpldHNST1owYnpqU09zdVQvR2RaRWFuNEo1L2V1?=
 =?utf-8?B?WVJkU3BSQ1FMU3pZNFMrTHNoMnd1ZUtCSldmdklPQXlDT3RObElTb2NseUZI?=
 =?utf-8?B?ZmdHRVo5WDVjVDg5L2czMUFIVC9MSFJTc0xYT2pqNllWOThmbmhjNXQwdjVG?=
 =?utf-8?B?RFJWYlRCUWx6V3dXMkR5VzYyakJiVW5hTGRrTnBKN2NGdjB6c0MzRFk0eDdp?=
 =?utf-8?B?WXpqSU92SHFFTHdqU2R4RUNYaWg3K1RLYXYvS3pYQWtIbVdpemdmK09ZTVA4?=
 =?utf-8?B?VElHMXo1K0lvalFvbGc5b0VmRzNnTmRhQWhjVGtPTTRlclpVaHAzZGp5cUQ3?=
 =?utf-8?B?RmhEQ0QxdHlnV2t0TUpYZWZwbnh6c2VGTU12cTVXSnhsYU9DK3c1VWdHMkVK?=
 =?utf-8?B?YkJGZG5vUHV3UVRubFMreFUrU3VsUXJUUUFLSStoaVdzNFZuTVFyR1pnSGQ2?=
 =?utf-8?B?QnVnSVRYU1ZhdG81STQ0MW5LMG5rZzhEb1ByMXc2anU2YUR6NDFYcWg0S05C?=
 =?utf-8?B?Ymd2aW8rTmZITTVwY0FzRjZSOTNTUGp4ZzBLTmRtWVZTT0tNODNrY1VEUjFR?=
 =?utf-8?B?M2VCbmg2Z1RNRUJPMmNKM3Y2a1N3RUpvWkwzUFVRb3ZhYjUrWnJrOFVlazAx?=
 =?utf-8?B?aTZIOFNpOENpeFdyblMvZy92NlZnb2FIa1lURUZ6WTJqb0xOVC9Nc3VOK3pl?=
 =?utf-8?B?U1pKd0ZLSW0wTVFjQmNMOFRsdmJXeURHeEM1QmhKT1V4TVFMb21vY0oyZzZU?=
 =?utf-8?B?dDZueXRxSThuN2JzK1ZTcUxkTGN5dDNjYm41STYrbHpmcmJkZ1NsQ04vSERv?=
 =?utf-8?B?UktROEhnaUhiWG5ZRExFYisvNUp5cEw2VG9uUVk4UmhBS0dISzhnTDAvVXZS?=
 =?utf-8?B?V1FIdjcxbHllRHU4R2hEbFJpMkZjZk9ua0t1ZFJ4enBQQmRVOFVmMFFsaStS?=
 =?utf-8?B?NmwvVm14NWdXdFh4WXRsdjRjWFN2U0ROOERtOUxIL1ZJQm5rNXR6SUpuQVpt?=
 =?utf-8?B?K3g4QUQxS294Z01BcEE4MGRYV3d5SGdCdCtRRE4vVGJpQXduMFhpNDlOZzEv?=
 =?utf-8?B?YlR6djNmcXF6NnRZdkJXUjlUc3ZURzdoaFByUTJIaUxXVHNrS1VJSG16ZEZp?=
 =?utf-8?B?M3JFbS9EQ3pROWJYV0JrTko5b21xTDNWTEZTRGpoU3g1eXlJRlZZeU5wdldl?=
 =?utf-8?Q?Hb67h/djoQs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L1JPQ0hDOHFoMkovbmtMUW0vRytEMUI0WmhBTGpSZUF3OVZ4VEFSSGNoVkUv?=
 =?utf-8?B?N1o1V0hOT3FjUHlpZS9QQW95ZGlnbzBGRUw1ckJ6cHVwblBYZlhkYnNzQnhT?=
 =?utf-8?B?WVpab04xQ2ZTbmVOd3JoTTZoUm9QMGl0d2Y0dmNwRmlTOWNndTM5bVBrcWpr?=
 =?utf-8?B?Tmh0YTBRY2tHQ2htalQyaHNyWE9OVlJxWTU1RVhub2lNR2krVE9WVEZpbEZ6?=
 =?utf-8?B?RUZPWlRkVytlUDBMeHN5Vmw3bVF5cDgvTVNmZGNMWXpFV3RaZ3REUzRkVUtI?=
 =?utf-8?B?OC9JS1ZWSUppZWJyZXhZRFhwZDZNeDlrUlYwclNaVENqSTJvd1VVM2RvMHNW?=
 =?utf-8?B?aXNiTVNJSHUyVHZ1NmVtUTRoUUlCYlgzNW1TQXhJdFREWWdCL3R0cGhvQWdl?=
 =?utf-8?B?Y0c0U2ZHVFFwQkJWZFpvcmNuT0N2cFo3Z0xZd3pjOHlvSHYyUzZvNU9YTHAz?=
 =?utf-8?B?c1BEc2ZEYUFZRHAya3JNMmpVWEtMR2hKdjNSWEdUQWphT0dHbGxBajJiVzhL?=
 =?utf-8?B?Zjdmem5iM2RCMldSVERiNjhZRm9pNm1DWUF0SmVkWEhSR3dxLytodUpPWXd1?=
 =?utf-8?B?STBCVmlpRHdacWxKQytsZndqa2I5N3hXdEl4MXVXMjRYVUVIdFNYVFpIOXRP?=
 =?utf-8?B?MTVCY2Frc21CaGVSd3d5S2NNTWVKQ2F0UGxiL3RiczdIOTFWdFhuUzM1Sndz?=
 =?utf-8?B?Z09ZMWMyc1dkTWtzeWZvZkFhYkxxS1VNSENjOWZidlZBbFBTU1FmSXcrWG9Z?=
 =?utf-8?B?WjVBbWI5N2t5T1pTTnM4dEcxbldFRFUwanJ6allWbTl3RXBiZEptUHZ4NzJk?=
 =?utf-8?B?ajdZMUdsRFJjY2xQQWRKSjZJWVJHWmtXNTFYWTV5ZVNmRlJJVFhYMzQ5WjlZ?=
 =?utf-8?B?YkJnRXk0NWlXMUh5QTh1Y3pmbXFFa2ZZUS9EaXBBYzdtcGxkc0hPTkQ2UTJN?=
 =?utf-8?B?dFE5Y2xZQ2w3Mk9CQ1RxQy9QQVVTdm5jT3RBM3dDaCtUaHB0Y09wSVQzVzdH?=
 =?utf-8?B?OER1TTRnSHFiNm9VNHFEM281TTJzV0VYejFvaXUzV0dMWXFRcm5saTJtMHM1?=
 =?utf-8?B?bmdSbkVyOWRXemNKOGpabUdJNGNzbmlLZk01Mms5eCtLOVkyRVBRK2trbk80?=
 =?utf-8?B?RnFaVWhoamd1cHVaSFhOSmVoWk5sQkZEVWJwa2pOdGxyY3VZSmFxMEtrUEpl?=
 =?utf-8?B?RFF1M1dsRWo4K25idzUxdHhDcE8yUnErNVBOQjc0L0ZmNExxenVKa0JSbnhT?=
 =?utf-8?B?MWhwT2J2d3N0cFQ2UXozYlpvTzRucEJ0QUMyekZXSWovaDNLb1BoTzJNYWxt?=
 =?utf-8?B?ZmJNK1ltQmltQjIxeEdZcmRYNksrR1pUSnJUeDFlWTFVc1VYMnBiS0lwUHpa?=
 =?utf-8?B?UnhCVVdNVXRhakZERDViWTBLd1JORzV4eFNKd1puNGk4M2hldnN6MmJxU09a?=
 =?utf-8?B?cFpyY3cvYVFZdC9Jc3I0ZERCVzg2Njd0RWRPSFRoVjRFVDJaYk9tUFo1MnVs?=
 =?utf-8?B?Ylp1bTJrY2JmNi9IUnpJMThLUE96b0c4QWQ4bEVjWTJ0MlRmbkRtSThmT3ZF?=
 =?utf-8?B?SVFka2swQlhQMU0vYlZjUUk5UGw2TG5HWnYyQVlwZkVpeGVUcCsvZzFQY2pT?=
 =?utf-8?B?SGhvOG5tOEhTTDRPb0RoUzRjYUxYSEF5b1hGWXR1bmM2SDN1eXltRHFpbXI0?=
 =?utf-8?B?TUlVWC9WNEt6VjNtQTJxRjE3OUZBVU80akNSOThuZkF2b0FhZEQ1UkpYWHkr?=
 =?utf-8?B?M3kvcGZzekptaVVRSnNPRUJUS0xIMGRheE80RmxMbko4R2RmRU5XNzJ0M3NL?=
 =?utf-8?B?ZmtraTlEeEhxeDhQNldDaHM2eFplelNlZFpqMys5UitzMnYwMHpZa0QwYkpR?=
 =?utf-8?B?b0Y4bWQvRUgwNVR5bG9wcy9wU0NLRXd2eE5OUThCTWk3aVg1VFZ4a3Y0TkV5?=
 =?utf-8?B?djZ5MHYwYkNZR1VFdCtkY3VuOTFLZzU0Tlc4YTh2elg2THpjaFV6dHgvTHYr?=
 =?utf-8?B?YiszWG15WUEyRmRTK0pySzZKSGMvNC95eGZtVVl3TU9xdVlNQ3JVdDBuL21D?=
 =?utf-8?B?RHYvQ1JpbzU1c1VjVHJTOG0wVmRpUGl1NlMrZGg0M052Z2plWkhGM0JsbXBG?=
 =?utf-8?Q?H4QVIH3hi2SGgTH8XwDHlskHg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4b0424e-45a4-44e8-4caf-08ddc3631f93
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 05:47:45.6864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cSj7WiBfMjIRPXBl7PQX2CsF5l1zl/WfD0CoJbvnCFPWz1QXoBVeVN23I8/Y3+/85c5ivVIuwIunR3olp0CV8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8140

Hi Will,

On 7/14/2025 6:24 PM, Vasant Hegde wrote:
> Hi Will,
> 
> On 7/14/2025 5:47 PM, Will Deacon wrote:
>> On Wed, Jul 02, 2025 at 03:07:56PM +0530, Dheeraj Kumar Srivastava wrote:
>>> Introducing debugfs support in AMD/IOMMU driver that will allow
>>> userspace to dump below IOMMU information
>>> 1) MMIO and Capability register per IOMMU
>>> 2) Command buffer
>>> 3) Device table entry
>>> 4) Interrupt remapping table entry
>>
>> Suravee, Vasant -- are you happy with this series now? I'll be closing
>> the IOMMU tree for 6.17 shortly and it would be a shame for this to
>> miss the cut given that it's got to v7 and Dheeraj has been receptive to
>> all the feedback so far.
> 
> Ack. This is mostly ready. Give me a day. I will review/test this series.

I have reviewed/tested this series. It looks good to me. Can you please pick
this series?

For entire series :

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant



