Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB7E1F92A
	for <iommu@lists.linux.dev>; Sun, 29 Jun 2025 05:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751176453; cv=fail; b=Z8zzXt3xoIG1akKawD09yWh06VPEkADzkWXPtYuMiygcsFSj5CCAOiDakdfDTN+v0hbgbu2Qz7806jtCoYthRu7mOhTqpkss0iJ3qnLZtv9J/gvhQhSpfScHpdB37V+uqmuO7/WZ3xMoDKxtsxVDhgK+Yo00rg1ospTrMu0e5UM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751176453; c=relaxed/simple;
	bh=Py7REmUEwG5Yotzr6C+qvZsjkHoVyEuwyfBUXeeTsKY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X4vpaJApwFt2eG/aNRBCLsmnX6c78jFTGxai0TR2epjsSodlh0E+Av5BBATWbayuTBPUxyOiq5ss+mN8z4jckL53Os3Eq389Itc2enMDas6ZQ3IL8cmjiCW30Nm8BqzaNd+ymdt7q8jnzfw3nS+8WbvkReemBa8h8y5Y5209dA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a6Vcv7Z9; arc=fail smtp.client-ip=40.107.244.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a6Vcv7Z9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ee1iRadmOvOYmXlAdHJgitF9LnqXmwnhPRdgAjkcJ5r/m1BzyB4T9jkjNwWYmzG+ERKSQ5SRid+FCdnwY29WKeEem5PCeIX5T7QJmQUz+wAZoSVzkBC6HoyAcQvgP0XdqDSiHdLk2EEdskWoEZ1MXydymGQF+9Ic2QEsM/svExka7bpbAvRDlvlHc5HL216iKdIcM/Opy0ncIXPA+VyXWE3jxrH39aRuyO0GFyJ5qRcf+QN5RRHcpu0vmaoS788hfVRtuEQuqrHx8z5IaR+Kd2RTClIg9c158s7ny8nfMicZbLssyIS+yiFsOeU6fXwZEa/rHn3w24h4lpgiNUOrMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CzUnfsGMnxBOWwmoK+C6VGgcZ0c9DzmurnwgqrGnzDg=;
 b=ufoIbPPkhNy7KdX7mIMS2rNS/2t/XtncbtwvJDMt5o27Os/tL3M+QwfSlCyQXGpyr3M6+84xCEqTsQ9AAWASgu62DRj5tyG4ztDOfYsISyLz2E+FzsxV+z4OLDouB2lSPsLgpcpLxpHVExVtrio+HXa/I6UyLPeXPfy9+Wm99VfYx5vzaDkzDfjLPT809EFu8Sc9hFpRAO0QS4KQY9Lz22JGTfFmcqRsGseSod6PJLDsz7auXYmLC9jJWqWdvZC3wHwGSxixUco4DENMgazlYEz8bPIUsSHDdEdgw3IKLFH447lbr7hU8uomNyjmYxqh7C4/AbTCk3VyuPIOUX4R0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzUnfsGMnxBOWwmoK+C6VGgcZ0c9DzmurnwgqrGnzDg=;
 b=a6Vcv7Z9dmv3nDWAdyETOCUpoxiZTCdQkKJxeIIDT0SLbey2/Y1shVAwCEot6a1mDO8BxR6Ny+GngCVD43XxysrxPCA8FEZSMMsHrjoAJNpDp2yvcK855ZNXiF1wXCaKKZwaE+Bvz4jlATZx5szf/KWQkVpas2KIx9IUR3mEMoQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 BL4PR12MB9724.namprd12.prod.outlook.com (2603:10b6:208:4ed::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.20; Sun, 29 Jun 2025 05:54:09 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8857.022; Sun, 29 Jun 2025
 05:54:09 +0000
Message-ID: <b3500475-f6e8-42fe-85bb-baca2b67d7a6@amd.com>
Date: Sun, 29 Jun 2025 11:24:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/8] Introduce debugfs support in IOMMU
To: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>,
 joro@8bytes.org, suravee.suthikulpanit@amd.com, will@kernel.org,
 robin.murphy@arm.com, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
References: <20250604163647.1439-1-dheerajkumar.srivastava@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20250604163647.1439-1-dheerajkumar.srivastava@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0126.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b2::9) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|BL4PR12MB9724:EE_
X-MS-Office365-Filtering-Correlation-Id: a8df3887-db49-442c-86ff-08ddb6d15da6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a3RXWUNWbDA0c1YxNUdIcThyMWJHT3FwUEVGcXByV0o1ZUd1TXg2QlE5ZDVW?=
 =?utf-8?B?Vy9tNmI0RlZ3QmV4cW9XaEViYXk2UCtmeHZtdWJhK0JwTnZOVmxRRDdIUlBa?=
 =?utf-8?B?UnlRcWNVbUVDdWpzTTI3M3Z4aFplL3h3WVU5a0VhY2ExK0xtSW52QnJKUmpl?=
 =?utf-8?B?V0FVcVA4d0FYbzBZb3ZyeThQbU04VE1OLzVsSFZ3a0ZHTThiQzBzdUkrcnJu?=
 =?utf-8?B?WmV1cWJ6MkdvSTZIa3BNWmtnZlBLMmJIYnlzOUtKdnRLUzlPckthVDJCSG9q?=
 =?utf-8?B?MzhWUHk0elZMZnpNY2t5NTJjcmI5L3BGMFhoODRLdllzNDRsUEcwYmxNRmph?=
 =?utf-8?B?SThDM2pvQThsSWpUSk04WGI0RlpuZUtxZjZiMFl6Y01yL3l2K3dXMlZiWTdO?=
 =?utf-8?B?TEZ4VEhKQUE4NzZmQmx1eWNDa1g1M2NuU250dzU4ZVJXRU1PeVBGREpOMlpq?=
 =?utf-8?B?Q3A3cGNVMExRWW9Kb2MyaVFMS1Y1ZXd3alo1K2VvS3V6RnUycnNCaEJaVzZE?=
 =?utf-8?B?ZDE1QWgrUDgxQXFGS3NNTGJuNUQ2VGF2SjJZTHZFZDBYTStoUU9PdDJXYmcy?=
 =?utf-8?B?R1Y2UVZncGhUdnlTTC8yZGNEbncwdjlTVnJrUEtybHJjUmtOTFRiQlRqRUhz?=
 =?utf-8?B?QTVtbUJ4L2w3RTlVbXdkTTVwa3pDUUZzNHZrQXZBek9BRGZxNXFNcGF6RFd3?=
 =?utf-8?B?TVorcWsrVEc2c0dEQmM2MkFEcTVDVis2a0FzdGNVUno3bVQ3cmk2ek9lcDdk?=
 =?utf-8?B?d1NYc3JQdkludWs3clEzUFBqVW9KYzdscTFYYTFUVE5tZE9qS3RNMGNRaDJN?=
 =?utf-8?B?UTllTmowTG9pbG5oL2JNU1ROWUlZNGV6UFBLSjRUeG1wQzVZSkVQT0JpYVl6?=
 =?utf-8?B?UTN6ejlKQzRaZFltVngzWWVYZkE2YjI4TmZweG50TlNjQTc4dXNyd05zaG9X?=
 =?utf-8?B?Y09oS0N0NExhdG03TitvLzVjcE03d0tmcXdaVXNmOVJHVDYxZHhwZkxXaGdy?=
 =?utf-8?B?UVV5K2VaVHZFVlFYVnFEUUx2SkdubEx6NzRXM1B4Ky83Qm1PcHpHYldJK0hi?=
 =?utf-8?B?UHJaZTJUd0NsbGs3VnpMSm5hRDNyTlI1Wks3QVo3bnpGeUcyYWlsRUQzbFJq?=
 =?utf-8?B?RFhMdTY2b0dqQkxtR3B5cFd3MkVvWFM4WnRUeDdPZm9JM0JJa241L2hzYjEz?=
 =?utf-8?B?amVlU21FRVZ0SU8xcUQ0MmIyekJqcnl1dldRZWZhc1dRc0RBaC81RnBsMExk?=
 =?utf-8?B?MTVmV1lBdXNJM2NjcFUxSGFIVDNSV1FGMFhrZVA4a3AzSStDUjFIMmVYNVg3?=
 =?utf-8?B?N1JaM2JLVk1wNEZpUFVDZXFLS1ovRVNFRVlSVmRPTWhKeWdZTXFaeTl5dTBm?=
 =?utf-8?B?WkpSRUtmbTBPL2RyTWVvK1dEY0hGZDg2cW5VeUFkWDE4TjhRVS82S2poakNh?=
 =?utf-8?B?a3phVXNUTW1SQTU5RDJXMnVJZmxGVG9VRHZheVk4SkkrcjhuSnJPMjB6M3pV?=
 =?utf-8?B?bEpKQXc5TFpmYmFKeWVXdVBTUXUrUmo1MUhBejd4cnlqQ25pVVJrNzB5OCtY?=
 =?utf-8?B?TjhpRFlpYVlHSTIvaUZ2OHM1RGpYWEtqdytmZ1o0SGV0dnR3eXo5Y1lkaHNU?=
 =?utf-8?B?d0RKZlRKSlFQL3R5OFFFRmVST0FhcWM0dG11dTJxU1BRdG0xVkNabmhJeUJm?=
 =?utf-8?B?N09oSHlLbjFYL1lPYkZpQ3NMMnRZNXRiemNkRTJoN2IvNmg1NUVFZ2lGd1hO?=
 =?utf-8?B?NlhjVXA5T3NVeXhNclBvdXE3eWRZZDFzbGdlczI5d08vclcwYVRXOGJrRUo2?=
 =?utf-8?B?eTBiY0YwdXVReEdYRXNrSk1rTXVJVWswZW90UUhGb0txdE1aTkp4RWxjR2J6?=
 =?utf-8?B?dW5hUTNIZ1BuZ0JvMXZwMWhoMGE4RHVTNytWL09oVnJvYWpZSVEyd0pKUXVa?=
 =?utf-8?Q?xoF3IEKlMic=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2VzU01ObFVZYzFESXNrNnhjVkh6d01JeGphTlBSQXc0WEVDNk1aenhQcjRz?=
 =?utf-8?B?NTgraUhoM1NpbVlWOU8rdDB5VzZBcWJaRUs5cHp2TkJGY3lNMndJSDBieUZY?=
 =?utf-8?B?SDBweWZDVjBpNmswVk54eUxWUmMzU1RxVm5nVXhPcTkzNUwydkp5VFl2VUVk?=
 =?utf-8?B?WEtOeGlFQmlLNXFwdVhSUk1qRW1XZXpkamlqQ3l4VDVZTHVmbGNnSCt2VXNi?=
 =?utf-8?B?c05LMkcwU2I5U1JTeGZyeE9OSDdGZndwVzFtbkxBMmFrbnZCcEdnM2VtNGZm?=
 =?utf-8?B?amZuQk4wR0FWOVhyS2NwWWpJRkRCOSs1MEsvRmZZVEJPU0h1WEpKZkZMMktY?=
 =?utf-8?B?Qm0yRmtJd1U4WnBvU1RuRnVnYWVjU0cxcEZxNnRCN3BXM0FFMXBhZzlHZnQ0?=
 =?utf-8?B?ZnRORVdpUnBvaUNqNnJVb00yVmF3SkdCaW5XMitFTkRnRkpYK0FZVzM2NmtK?=
 =?utf-8?B?SFVnOFJIdEVPaCtpUm9rUnBBai85ZzFVaGxTYVVua0pENFg4UHZERWhzVTM1?=
 =?utf-8?B?ek9QcjBmeUxNaG5CMVpJTm5zV1U3V09BTjRQbHFCZWs0Tk55V1FyK2lTRXlY?=
 =?utf-8?B?OE5ldWxLODlpbnRaK3RWbDVpdGpPT0hHZkNFL0Q5NnA3VWE5T09hbVg1UGpN?=
 =?utf-8?B?cUc4TWhhZ2pWTkJpcGMzRklLdElhVDcyZ3l0M3paVmdOUVF3WHFWK1pYbm1h?=
 =?utf-8?B?TVMxTzBRMkQvSjFobkI2a1lHOGpmcE5MY3ZWQitHblpwWG0wODFRUys0bnFD?=
 =?utf-8?B?UWQvTWdkeTdVbEpyOFZRVkJZNTY0eTZIZnFZZVlqeWlhbWNoY0ZpRm1tL1NL?=
 =?utf-8?B?WW1TakEwMWM2eFVMbGNkWFRSNkMyWHA2M012Z29SenpCV1hITmxPUmwzMWJh?=
 =?utf-8?B?TnJUOXBhKzNqSGVKRzIxckI1NW1Ea3hpQmpEZGVPUURDUlJzZkU2cWQyNkdw?=
 =?utf-8?B?M2F3eHV3RjVsVFdlY3RIcmJpdEl3R2ZiYm96dXFXZWcveGQ3MmtCa0trQVVD?=
 =?utf-8?B?akwvZThtYVlFb1I4Yjl3b001dmNxWWlsUHcxalZEQWhxc1pIK0dGU3JYY3JH?=
 =?utf-8?B?VXFqUlVvREFPNkMxN2hUVEZsbTlZcGE4Q0tEeko3MHB3aDVlRG01VXBVWDd1?=
 =?utf-8?B?N0orc2txMEg0R0RCTnZuRG0zaU52RG84TFY1M3pnbUpYQWJZelR4Z0VmVTB5?=
 =?utf-8?B?MDVhMXUrN0VrdVlPZE11SVJzeEZlQWFEelFJeldNV3pESXR1d05oa2Ixci9R?=
 =?utf-8?B?cVp6S2Z1c0J2cTVaMEZOVUVtN0dtZjhMVm5CZ1JWOHRyRFArb3UvV3BjYXgy?=
 =?utf-8?B?aVhWSlpob0IrMGJnWno1RlAwY3pUSWxNMlpiK1RFUEs5YmlQdDA0YU9KdzFa?=
 =?utf-8?B?Zk5UZkVoZWJrRXVmUytqOXZIL3p2NVRlYWx3ZCtsNjZobVowTDRyL3FXR0xk?=
 =?utf-8?B?T01ybmFyWjhtTndmLzBDcnVIbmMzcjM0NHRuSms2dTliNnBaTU4yeTRyOHR1?=
 =?utf-8?B?L0RHdUx1Tk5QZFl2eHdjMGZRUEQ4ZmJTNHdZUy9zcW9hMkxIditGazVzc1BT?=
 =?utf-8?B?T0F5MW5rNjh5WUhtSHVsMWtzdStpUjFMbDY0bmJEajg5cXVWaUs5d1YxZHlj?=
 =?utf-8?B?WXczMVBQMmJLMnFDMTVMblViQkFNbytPbDZidGVNaTRGQ0VzL2w0MjVONzds?=
 =?utf-8?B?UENacGRncjlaSWRlWU1la2NKcWN0RVkrMlEvQ0s4a2NzQkhmNHlrSWV4QjY5?=
 =?utf-8?B?RG9lRG82U24yZ3E1UXlXRmhJL2dOZG1xUUNpZ1ZWUXZFcjQ1NDRqOWtVSjVJ?=
 =?utf-8?B?SmJtOXBlajZTVm9ISnh6TVNxTnFYZjlEYVFnMEZHM1NkNXFtMWltSHVYNFc3?=
 =?utf-8?B?ZTl3RThjTzQxeWdpeHJUVm9oZnpOdmxqaGNOVFExa2pDVW9pczFta0VZUlFT?=
 =?utf-8?B?Y2NXZENPOFhQYWRHNStEU1U1M2ozQ2xuZ1BzRUk0aHo1cmRSM2JuZ1lvd0F6?=
 =?utf-8?B?ek8wR1V6VlpWU00zZzJXYXBZcFp6czFrUVRoVFdUUjhOcmtvS3pSYmVMSVp2?=
 =?utf-8?B?QkVkelduQ2dadTIwaHFrSktZOUUxOUFObm9iQ0NQWTJ0RFhXM1JWdXBsOUZm?=
 =?utf-8?Q?b+MyxnW+pTVMuc3qCKnm7t26u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8df3887-db49-442c-86ff-08ddb6d15da6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2025 05:54:09.4572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ytf1pE4MJ+pRsuklFQNqac3xrexY9nJwQgc/CxN2crOIxNTAmyNvQ7Kfn0BwdRgzE6mLSSA8GtI0AI5r3DiFpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9724

Dheeraj,


On 6/4/2025 10:06 PM, Dheeraj Kumar Srivastava wrote:
> Introducing debugfs support in AMD/IOMMU driver that will allow
> userspace to dump below IOMMU information
> 1) MMIO and Capability register per IOMMU
> 2) Command buffer
> 3) Device table entry
> 4) Interrupt remapping table entry
> 

Overall this series looks good to me. I have done some level of testing and its
all fine. I still have few minor comments. Please address them.

-Vasant





