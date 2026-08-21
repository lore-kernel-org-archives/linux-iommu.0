Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010031.outbound.protection.outlook.com [52.101.201.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C0043F4B7
	for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 23:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787354164; cv=fail; b=h5xvA/wrDc7aHQSK7fiGcO/CSsKl+hdLqSBdaj+7S8m3tJsE9PTmRn4DKWE+UC+Rz+/z7SlzSVJUUlvSbKaZeVDBpUNZlIobr5iVm1bxvC5qHItqNm730H19B4Vbxy5Sqx4y79XSOTg9tGbn5jEPlH6g+T2IazNTKztRsMlm3Go=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787354164; c=relaxed/simple;
	bh=yBPi9MlQghMEip+g/aUZYb0sXiVazX1+YDt7S+RSGH0=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=GzSjvDyi07AL5B6Vhv1DlWMFf/qZYL5S172MSc78mE/kD2kdq5gZmLVRm6kkuPeOAR1FKIbfRfFFjOyCgO9Hq/DRYWE5z5E3ybf7n6/xDwQUpuOFpHL2XGaVC7h6nZjkL2p/REA8yYdvrFuY3MEpYLjsAJ+lUDTY2+faRrpfm3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C9NTpnqI; arc=fail smtp.client-ip=52.101.201.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C9NTpnqI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eVcUSjbO0/RRwN/TN4EdbeVFjMxhJ5W4Vp1ygyFNub3l2Q/WvMMgNsHkJval7VVCBFeg85I2gBkK5U25HFsvtIuO8485CM33VHamvm4i5lEg5/7KBSCA9bQX2p8W6sJwOn/jX7Xn8PRWcis4G4Mqdc/PBAvtWX/zHl/Q25dbvgxzS+cxtCGxB01Yb1XM30U2fKRCkqMh+v/gWtLda4ew3r4eIg+hPnFHXhfMfQmzJAISJMeqp45m/6DdAhstSre3La3UxHDEsfc5T05NiaTYFVGQPY/mPGZNhweT+lHp2Ga6epKwZCXk5RB/vEDWHBFu7azYhUwV8E/9NB2mFPgrOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQ5kwbiG89uFPl0HXXue+7Jj2j6gAcL6c8XWow/FJCI=;
 b=TBTYAB5hDLxAeh8u565PZhLswFHh8+GFPWeckVO+7DiboEACsc32yJhiQOzvDXoFn5RAe+e/AQ52kHCbky5LX6CsCLtr1+m4PwD65IRnng+i9hRbK9Yuqxom50/sG6B6MoDclP7A5xYIEhWVFa2c9nTr02Bs5cvpcEoMyLLr7XKuE2HvEZsemm3QXXza3vjvC5NlwFURIlLk17aYVtzva5l8WEz1IQhv+QY52nLSMxhTPrzj7sjX2DaNUPjCPNCK9652fLlT4Y92HBeG+yXYhoArxzQR+5ZNgGsG7CyLp5Y63kfZb54qa2roHVpKZrO+Vc8FO2j+73JTOEXE2bJv9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQ5kwbiG89uFPl0HXXue+7Jj2j6gAcL6c8XWow/FJCI=;
 b=C9NTpnqIYPm13rN7BUVoxdns/qV7MU+l960hhu+RJ/9I95LfWN9O8CBYxSs9oODB2Ft6yP7uz11DUprUC4KBQ/z+gB5gPmpyJ/7DnTd1iZhzhjUidjKuXQuEQ7geUb75kVDJtcNeRlRUk+u1mXDFW7TBethgQ6dZBs/tyI8BelG5tLhVd5Tpu+Aq7xXQpqaNFjodJEfNkRHG1mvO3qqaRefa4zC2zhqiBb4oQcIw6BmL2FPHYGuNOr2XkEc8sgv6jTftaKxKJn2UyKXaDKLFO1SmIBkCkkLOIKb/PML7GmUA4FmApqfDG6DgUC3Th4gBILjHU15qWnUjOhg/0iAwFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BL3PR12MB6402.namprd12.prod.outlook.com (2603:10b6:208:3b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 23:15:29 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 23:15:29 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v9 04/12] iommu/arm-smmu-v3: Destroy vmid_map ida via
 devres
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org, 
 praan@google.com, kevin.tian@intel.com, smostafa@google.com, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, jamien@nvidia.com
In-Reply-To: <8b0978c9376f20519a7b827e7e0789dfd86e3b14.1784663184.git.nicolinc@nvidia.com>
References: <cover.1784663183.git.nicolinc@nvidia.com>
 <8b0978c9376f20519a7b827e7e0789dfd86e3b14.1784663184.git.nicolinc@nvidia.com>
Date: Fri, 21 Aug 2026 20:15:26 -0300
Message-Id: <178735412600.18212.2050664519547226046.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT4PR01CA0235.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::23) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BL3PR12MB6402:EE_
X-MS-Office365-Filtering-Correlation-Id: a0579ea2-4d76-4d93-fc63-08deffda1762
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|22082099003|18002099003|56012099006|10067099003|11063799006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	9lkJM36eutNSideFE3w4lrQNR67ymdYysgvC080Pol8afrusvpnSw+/apGWcCupWPDvKz1UaKfUzcmfwYs5DTKoXsyM5+Rg9FnuefLIaLNKtt9U+IPHJEY15j6XPgdj5mvuTTMjexBCs7BuKpV70fO3Px6O4+PtT2ocXV9wx854Z1m49K2uo18mp3cXop18ZbsRBFXKwVjUqrl08gnl5hZgJECs8524Uu/GWydY234DLLeqt68Blpgusyz4qo/Vnq/fynzBMnUWCCPn92BDwHruzJeyw1Nj4wxRTMWbZyHldm2fcY9joJiFXcYL7GZtTn3O7ySv4ffV1wCToa61AMPUon0Tb/i5fl7r94P1Ma828AxsgzSqFCHKvxSrz2dUCaporAG1T+W4t13ruRQaS10AADwuxZFYuHMrt8WFLN4BQmVcJy4QH9Jknl+U4kFQi09wEPu4vXWmlwUsMaI1K8IsDADM2aSY/9WJ2BPapRvAotqISoVzRnN16+tNfTKtL+5kZtSfpiMI2ZoTpL/yT7hWFv1SxD3CJa1ZcDRF93VohS6XoXbsD4+dZmleKo+7XQ+ni2Uhqw+qUh3CLja9sHowBMyvdY7rjlYs5c1XRcxyrCubL4RL4I0bigeE8vR8jd8Vng4rSXCjT535LYq2mGVvdbOV/+XoddBI+EVbZQzU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VytTdmRSdlQ3R0N5bHZLZ1ZvNGpVUHZBdlZwUlJ4aHYyREY5ekQzWG01VEQ2?=
 =?utf-8?B?WlcyYnl0UnVnVFVsMGJmS0cxUUZhOTk1aWRmdWROejNVTUxVK0w3OUFXTUlo?=
 =?utf-8?B?anZzTEdsYUlKZUZyTTd5aXVGRlkxUFU0VkFHb09BLy9hOEl1bnlnMUxOVlFL?=
 =?utf-8?B?VHIvREoxb3JDM000anVTdGYyWkJwbG9wZzZ0K0Z5VEtCQnZsdmRJamxBZTRq?=
 =?utf-8?B?K1JHczhGSkJHMmxTSkhLSUFUSGo1VlU2WXphbUFXeUN1dDVxbU5DR2V1dmow?=
 =?utf-8?B?S09vN1NaVDFBZFVnUGlIMzFaOFY5NnNONkxvN2d4Wlh0Qm5UODFBNytxZFBN?=
 =?utf-8?B?TVE2N3ZQU1JyTzRhcnVnRWQybzhKOVVPblM2YlJ1RjcxQ1Z0L3p1RXhSR2Zv?=
 =?utf-8?B?UzhpcjJ4VUNmNi82WGZ6REdrTmlrYUhpMkp5alVWVk1ZekE0TlpSaXJhUTNY?=
 =?utf-8?B?TldqRmZwS1E2SXdOdktERTl5ZExrMTUvN1dnNjRlNXE3UXNDNWJPdlpST1lC?=
 =?utf-8?B?ckU3VlY3SDk1dTY2OFJoTzFZOGJvNE5yYXBNcUZINWcrOEVMajJHeE9Kb3RR?=
 =?utf-8?B?VHJQRzM2NzFxZGRWbHV5WjdRd1VscnNreUt1cGVTTlVTV2lKdm5aRU1ta25t?=
 =?utf-8?B?ZDk3UVR0WU8vajdQVFlBdHhTVytZNUZZZ1F1eGJGV3lwaFBDUUJ1bm1xMDJD?=
 =?utf-8?B?S2xyQ2xoSXhnZCtTTTdyLzhJcnoxNG0vaWx2djZ2OVZzYmlhbHlQZGtDS1Yw?=
 =?utf-8?B?bnNpRlZPUVRLZHdsNzdGTmtBQlBONTJpcGgvTVFRK09KZTg4WnRsZ1hHVmVv?=
 =?utf-8?B?cTRZYytwNU8yTHREMnhTZVJQeHlVUVV2ZUpyVGZiWVlDKzJTUDlnNlpURHJI?=
 =?utf-8?B?bzZseU9vOWZpTCtiSldlbHNadTZqcHl3SXVuWGd4SzB3OVNTSk93ekgxdCtR?=
 =?utf-8?B?WnIvOFoyb1FJZCsxMEtHR295NXkyVWJzaG4rS2dhM2JDblpMRHpSdVBmWERN?=
 =?utf-8?B?K0hmUDdyQ3RWd2ZIbHdUQWw5cFBlUUwxQy9ENWRkMGxiZGcwQTZsNDIzVXpz?=
 =?utf-8?B?SnJZcW1xaE1ONlpOa3JvdU4rYUY5TU80RkN4bk9xQzRUQzJycnhVM2IvZDdG?=
 =?utf-8?B?T2ZuYWVxL1RQYk1Oc0VNZlFaeE15Z05peEx4d1MxdEQ2cUJSZmRmV3FDMFov?=
 =?utf-8?B?eUZETFJYSU9DZFBXaWNuTHRFemRkTlRuNDFHS0tHRWEzVHR3eTdja3Z6N0dq?=
 =?utf-8?B?ZlZwSlZwRmh1ejdVT0RvTkM5TDRoYkZ1QXNoV0Z2RGRVVUMwVDRUWFU2bzdu?=
 =?utf-8?B?Tm4ydU84ZkNhV09TZnVsVzNYUXV2SDJpOThIYjY2cU5VNklGNVFHNnlxY1NR?=
 =?utf-8?B?UmtkbzFhNWVqVHpuVUh3RFlGd0cxQXVhV0doVFFickxqam5iRWVxYVpxcURG?=
 =?utf-8?B?ZytoVFljQVlUY05IaEdsQUtLL2dKM3VJMUhNRE9hMlpCem5MMzFzdXlyaURE?=
 =?utf-8?B?dVVDUnVGQXROQTEySDM1c2s5b2FuZkR0S0JyZUZFZGl3bThYTjY2d2Z3VFRw?=
 =?utf-8?B?anpWMEYvSHFVbVpySnRmaDlaVG5mcXN0RTlDRGdMdHhHcE5ZS2wxQk9FNHBG?=
 =?utf-8?B?bkhlejNIcHhsTmVMN3pqZythTDNBaVBONU9vdXdrbHg1VmlxOTk3ZGVPbGdH?=
 =?utf-8?B?cmQyN01zSGZqY0ZFM3VBeHdOOEVSUENNOXpWWk90VWF0UGNiaTcyc21tT3JG?=
 =?utf-8?B?ekZFVitZMnR1c2QyeENPcDhMOGF2SkhUYlJETEZOZW9Hdm5YY2RtTFFCRUU4?=
 =?utf-8?B?WTV5b0JBQ0p2a3ppMG56Skd0STJabklOcG9yNHo1OHZoU3VpajRnMXZ5TllM?=
 =?utf-8?B?alU2MitjQmxKeVlvb2tMckdtTlZES0tZbU9pcE5NZ1FWcjRaWE9hWWVqMG5y?=
 =?utf-8?B?djBENE1GWXY5M1k5dXRSL080Y0ZJVEtDQndmVXZKeEJpU2J0T2JZR3pHUXll?=
 =?utf-8?B?ekdHYVJxSCtodmljanVwSU9vQXRHOHZSWXdyNzVqWitIWlJyRm43OE0yVGs4?=
 =?utf-8?B?ZFJnd1F5VjBwTmJaODcyM2VkTzFYYmRqZW9NNDB4L0JyZmNaZGRSbVZPNHRa?=
 =?utf-8?B?eEZUR2lqcnNpbGl6aUx0SWx3Z3NUOXJaTVNwRDMwZk5BN29ZQ3BUTzhvbnlG?=
 =?utf-8?B?WWtOUUpDd0kxV3ZPZ2EvcHMzM29pcEtSdzI3Mk9lNGZUM1ZnOUFtMzJqRm9N?=
 =?utf-8?B?UzY5bkpSRFhLWldKdkMzRXg5Tllad080SWVJenBPUk45L1V0ZWduK2tKZDhP?=
 =?utf-8?Q?lrBWXP9nV4kgnvXDzC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0579ea2-4d76-4d93-fc63-08deffda1762
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 23:15:29.6349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f+vzaH6UiYkenrMb41paTZnRH8ZjgjjojoMq+nU/6UFPtFpH1kgySVF+bQELmxP1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6402

On Tue, 21 Jul 2026 12:48:13 -0700, Nicolin Chen <nicolinc@nvidia.com> wrote:
> The vmid_map ida is only destroyed in arm_smmu_device_remove(), which does
> not run when the probe fails. This is currently harmless, as the ida stays
> empty until the first S2 domain allocation, which can only happen after a
> successful probe.
> 
> An upcoming change will start reserving the crashed kernel's VMIDs in this
> ida, at the probe time of a kdump kernel. A probe failure would then leak
> the ida's internal allocations.
> 
> [...]

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason
