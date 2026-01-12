Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011042.outbound.protection.outlook.com [52.101.52.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A301306496
	for <iommu@lists.linux.dev>; Mon, 12 Jan 2026 05:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768194766; cv=fail; b=Y0jjClZjn+88B5mKc5s24N5py0+Ooa+rvfM5iR5Wl/+8TFw9LXAn8CZ0MdOCcH8ayjGtyjfgatxCG5ZTsZR8ue3LSGF63nqdDH9L7Cxfb3rmOAaYKVYQYkhA9vrYBA8yoKveTDpbJbU3ZXfqOSE0/4yrAZF2+vWa7oKohvUiZBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768194766; c=relaxed/simple;
	bh=kFdnNzxG2T0EpPsx16YLjM7evfq13L8/w5O6G7/jxW4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fFneRWgblPDR3RIuvyP4TlkV02ufYcNXKV4zDi2c/Dgvk6PVPkk15Zg0JFnmqlenEcGPmADcDXMnaKIxx71Yg1NBexCk240Xm1kEkEaCg+jUH5TNxXp6uV9OCnW3QFnq8gWk6NRJZibI1OflEItP8VODuFrkFAFZRf7Ia45qrW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xBTmtJuS; arc=fail smtp.client-ip=52.101.52.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xBTmtJuS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oEfxh4NGNfhYKDzh+sQpcZdztZK54o05D55BlPIfz0k4QEli+QGjQ6AlJu4A1p1EgGiye9NGr7TsiUfYAL0DQtQLyRudkot0EwsBfuDieJY/n3olbwepHEcC2qBGWqeeHJ5kpZhc3GjI8XMETNQZULU4KLWCgNKLU+EqOCwvBfUQ7GTQ+L5Q7z+FrlQHX9pgQI09fpOpiEEpntARzzbozd2uAe7v7ON9meqPUO71b/h+C20wJ98zOOomOBUDiLox/+JrJFEhwaTl1YKa7FYhKn87ByXHsAjn/1n0EGTIKzQO+2froBuEgHfeiBwSrw4RhfV7DRGyC4sVYfLwejPqJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yv4S/chkjFD5SdEmL7CjtnqdodzeOeMAXGq4Py6Ybvo=;
 b=Vb07O/ZDNMsOeRSLQycufid5nwpS/Ac8IVwgqkkoFKLi5807JJFpQxXw/lyRyXy2a/gqc0zHggD1kbWH6sfKDRN0x0zail50O/YfZEelUqlF/PJk5JjpmNUjnalvZ2KM5Lp+/++HPxJY+i8IetcaD240HMpvWx1BdvFN5QPdUwScOEKoUgAJYOMzxFGEmMu4hSgVyYng83Yh/+gbKpel8KPKlqrZxmx2GevDwMaCY+ntb37vIh937EOnX0cz40Q1hiFXDvtx5UmxUoU9eGAurTwiUCDNKvoywq2/0zpcQqQSxWb2qAElaOsHXELMVrj+T13G4uCld1mfrcVwFrN5ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yv4S/chkjFD5SdEmL7CjtnqdodzeOeMAXGq4Py6Ybvo=;
 b=xBTmtJuSVMCeIsVjnIwJVgNkobWLLrA9P37FB2DKFeKOSubpv90DWurOKPOBPPb1lY7MTyvYSOQxcV8hMH1wD4i7RIoqmgAoLNgQd6qKVSdOMo9FLBGB/XXY9AErAcLRYe2Xmfc0YQJSPWnhSBf5VNpS7dh6GemN01j51XdbVpQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1SPRMB0013.namprd12.prod.outlook.com (2603:10b6:806:22b::6)
 by IA0PR12MB7751.namprd12.prod.outlook.com (2603:10b6:208:430::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Mon, 12 Jan
 2026 05:12:42 +0000
Received: from SA1SPRMB0013.namprd12.prod.outlook.com
 ([fe80::fc4:fa00:c2d9:456a]) by SA1SPRMB0013.namprd12.prod.outlook.com
 ([fe80::fc4:fa00:c2d9:456a%5]) with mapi id 15.20.9499.003; Mon, 12 Jan 2026
 05:12:42 +0000
Message-ID: <561ab88a-ba97-41d8-ad6a-8656a2e2b1d5@amd.com>
Date: Mon, 12 Jan 2026 10:42:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu: amd: Fix uninitialized dev_data on probe failure
To: =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
 Rakuram Eswaran <rakuram.e96@gmail.com>
Cc: will@kernel.org, suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
 dan.carpenter@linaro.org, iommu@lists.linux.dev, lkp@intel.com,
 linux-kernel@vger.kernel.org
References: <20251221173416.132656-1-rakuram.e96@gmail.com>
 <ube32gksp3noozdql3bm7stqsmjlijlvldsidhy6js4ub5fhdv@zmhsfnwgjltw>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ube32gksp3noozdql3bm7stqsmjlijlvldsidhy6js4ub5fhdv@zmhsfnwgjltw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0236.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::20) To SA1SPRMB0013.namprd12.prod.outlook.com
 (2603:10b6:806:22b::6)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1SPRMB0013:EE_|IA0PR12MB7751:EE_
X-MS-Office365-Filtering-Correlation-Id: e23416f2-a0bf-4973-de13-08de519936ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aHYvUElBbm9yQk9sdWl6eE1NWC81R0FuQlFUT09MK0tWVUZqcDNjVzIzQ2ZD?=
 =?utf-8?B?NDB0Z0ZvSm1CSHVEejlGT0ZwRWNUbVA5SlU3ZkdlUmxaVXBONk02YlduZWFW?=
 =?utf-8?B?a1hyL2pVakNFRHkzR0hIdDBibW1USXFpQ3JFckpzNk10VTJxc1ZtLzJjbXcx?=
 =?utf-8?B?UlZCRklqaWhqWVF2bGRvUmNtYmdqV0xreW1BdklFUi83Uy9CSmt3NXpZb2or?=
 =?utf-8?B?SWdsTnlKKzIwUXBGTjJYcnYybndWY3RTOHExUk5haHZuVUc2WENZMWNFSVlI?=
 =?utf-8?B?L2VKNHJaQUNramNFMTNQNkNhL0Z0TDl6VWI0cE9INUxkS0RoNExCblFBZ250?=
 =?utf-8?B?dkt4U0lFSitCbkVuRGRSRTlPTU90YjlldVpWT1Y4MGxsKzV5S0N1bURRQmxS?=
 =?utf-8?B?NWhvTzliOHVXZTRXS3RLbzMyMkJPUDRoa004dWtRbjh3cDFxRUVweDZsb21y?=
 =?utf-8?B?RXlsbFVmWjZ6WGxCNlU1ZDV6NlA5a3cvQ0tCTk1jelhhZnNqTDBleVFZb3Fq?=
 =?utf-8?B?NWtlbk1XY2FMSlh3eDNGRi9HZitETTY4Q015OHNndUZkTEhpTmJrS2VLQlk0?=
 =?utf-8?B?SEMwSVBVeVNCdVdUQU5XUDc0WmNDaXl1R0ZYWDE5WWltbXRJem1Tb0lqYTU2?=
 =?utf-8?B?RGxmK0RZejVWRHZ1OFpuWWlpa0l3bnhRU29pYXFQdmVLRCtaL1pxSzdrZ3ZC?=
 =?utf-8?B?S2VVSFM4ZDUreGJITEpaT2d2QkNXc1FORFI4VThDd1M5S3NOVzkxMnZkeGgv?=
 =?utf-8?B?cjg2MFEyN1hBRVJTNGZiYjg2WCtwNGF3aEUxdjc2TDdEcGxYblpmeEoxblAy?=
 =?utf-8?B?YmpUT2YwQW16cjUzbXA0S0x0YlNUN1BYbVJpRnhoc2hpNjVxeWdncERSb0NT?=
 =?utf-8?B?V0ZtQnQzVGZSc1lxZGRaSFJBK0FKSlg3dzJvZjFNWTNmcVh6bUhqdnBZdFRw?=
 =?utf-8?B?UFNvcm5UWW5COU94eG1ocUttdGQ3U0ZmeEEwNVM5eTdHWHhKZERncnV0K2N5?=
 =?utf-8?B?eHlhYll3STA2dnFicmIxVEVSb3RXMVlrWCtLL1Q4aEhwTUVlTEZpbUVmS3BC?=
 =?utf-8?B?eDdlVEJtQVN0LzEyK1FnMEpVNWNjWDZ1UTBiTkVYVGhmWDZWc2FFZGo0MEVS?=
 =?utf-8?B?MnRKSWhhMEllcmpoSlNVeWdnSE5sRjluRE83TzFKeU9ybzRNbldRelU0eXE4?=
 =?utf-8?B?SnVsK0Jmdk5GWW8rSVlWZWFiOHBwZmlkcGVCaFBPVkZrbXdUWlhiVmphcWtG?=
 =?utf-8?B?VTE4MVV5K2czZ2pJRVdlcU1CTVBWL1YvU3E2SjJlWC9Cc3ZpVURvZ1E3TDdJ?=
 =?utf-8?B?U0dINXFnMWZYVjhoeXZmb1FKQjdUWVNXT24rVkd1OGh0b0w2K1R2RTdQQncw?=
 =?utf-8?B?WmRmaDZJUU53RUxWMkhCd0JlSFJubDgxL1Y0cFdpWHk0T1N0a0VDOXBWb1dO?=
 =?utf-8?B?dGZWY2g3RXYxanJra3U1ZnVLUmJ2QllwSjR5SDFnbDlpVUpCTkpFUDc1cWpX?=
 =?utf-8?B?Qmk5UUJsdjZ6bHlTdk42Wm50RmU3aFpzbXM1MkVTNkxtd01CN2VhdExNbmlh?=
 =?utf-8?B?UWpTQXZOWEt0UklQcm1JNU1SSUh6ZHNRbDZsck9leW9tWXpGMmVNdFQyWVM1?=
 =?utf-8?B?S3ZMVHdGdDhXcUR5NDlHWkFrWXBBUC9IM0hMMUhnUDZlbERrdmRVRnlmN0th?=
 =?utf-8?B?OTF1QlJGUnFBaiswVXVTZ29wR3RMeWdXU0NFcXdwczY2L0trbGVHSXovaW11?=
 =?utf-8?B?TjZzN2VuMFZMTk1Iak5mOG9BcEczSUk5dys5dG1CR3cwSVhtM3pMaytONW41?=
 =?utf-8?B?MGlHbkFzMndhbEJEUXFKbkJXOEtlYTJZVHJicFNQeElBVWZ4ajR1LzBMMDNC?=
 =?utf-8?B?Tlo5RnlVaHI1dDdYLzhvVWMzdlBNcG5GN3ZPOTdXUW8rSTJocENIdmVNZTFl?=
 =?utf-8?Q?hYY7qsdMz+YbLGWOY3sJ8iOiOYKc3lwc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1SPRMB0013.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dXBoYkM3ZUpvOGMycTEzdnIrcFVVaEFNUTcvMmN2MEVIUGVpbHlVeGNlZVhl?=
 =?utf-8?B?RnRwMzViRnFXV01NMUdpMnI5TjMwbFJLQmgrblhiamZKbUlCWENXTk41V2tU?=
 =?utf-8?B?M2Y2K2ZFb3dydGV1UzhyeEU3ZmE3NEx3SHBZbDJJK1pwMHlDUlRJSTdlQjI1?=
 =?utf-8?B?VVAvaXZaaldzQ1FHdmEzdzZNMmJvNjVNZjRqTWRyeUIwZm5aWENCU29sS1ly?=
 =?utf-8?B?aUpUTzkyQXZ3RGVvbzZkVXlOUjh2cmJnTUs2K3hZQTI1TnpsSVhNRHJNZ21W?=
 =?utf-8?B?N01zUzlPRGZYTVI0Z1c5TFBXaWtueENuQnVLQ2owek9JZHp1UzBuMXgxbkIv?=
 =?utf-8?B?b0Q1ZlJta1Ric2xnK0lmNlRxamFPQzNaY041SjhDdWxXK0lFTXpUY2IwUFVY?=
 =?utf-8?B?c0RVQ3lrTVNWZFJhYm1USmFPSVpSRWJsLzZvcVdEa2JVUkhFMUZoSGl2WFMr?=
 =?utf-8?B?TysvMVE2K2ViR280VEgyMmhaV2dkRDdwQTE2dVZNY0hYT1dJQi85cnQxSmhp?=
 =?utf-8?B?M2FkZG52RTNPMTZ2K2NqcGJYWktlcGlpM09hNmZiU29yWndRdjVkOE5ZZHdH?=
 =?utf-8?B?MExOekxqOVRKY1V2eEJvc1lVTHFDWWxVc0NxQWNURFdZdEUwL1BORXAwZWp0?=
 =?utf-8?B?V2hMbm1JNHZVNHoyaloveHRORzI0elp6ak16VzhacVlENWVXYk1JWW40bkMz?=
 =?utf-8?B?QWdQd1IreFh0eFIwcEI3eG1kOEw5azFKcGJEcXRIRUlnRHBTdzNOU1REZGZn?=
 =?utf-8?B?RzY2UVR4TzJ5NGNNZGZuaC8zK3kxOU9ia0tKWEZSOHR0VkQ2b3FZZUFVQTZS?=
 =?utf-8?B?OEdUL3ZHekVuMFROK3ZIQXJEMmVYSnM4YUpDVUIycnc2K0MyU2dBT0kxZEpX?=
 =?utf-8?B?aVdweWUrd1lvR0NLR3lSWWVzbWRFSEVlM2xzOGJ3cW9JZEpxR2NWWjFBKytR?=
 =?utf-8?B?SkNZUDBabXFFSlZjVmhFM2xOdlBXWU5uY1lSN1ZUSlN1QTAraGxsSFZRZkdC?=
 =?utf-8?B?NmFWd3liNkV5ZHZxRGoxQmdodm9PSjNaYU1nUExqQkFkajJEaDhOc25LWjU4?=
 =?utf-8?B?dlY4R0hEc3pqeENVQUMzeEpicTQxU0VtbWhXNDl1RXVQUE0yK04rZWJZdTUz?=
 =?utf-8?B?bzUraEVYMlNKVUNJL04ycGM0SWFoQXc3SDI4czc5WTZLdHBBRzVJekJBV2Q5?=
 =?utf-8?B?bGlmUlI3QkMycU5YQ2Y5bU9Pb0xOSDdTRXZyN2VRZ3hnaWhBbHRaTk1oVzhQ?=
 =?utf-8?B?T0lUZWpCWEhqR3MzVExZRXlLTndDdUxGZWY5UmhRa3k1UVVKa3pCYnoxanFl?=
 =?utf-8?B?bzAvMFJTR2xsVzRWSzB1blVZUGxZRUEzclFiOUdvUXdCWko0WDNGd2xYR2sv?=
 =?utf-8?B?ZGx6bnJuT05jVlU4aFdWNGJ1Mk41bk5ZMzlSV2RLSzYyL1BNVkVmN1NGMUtH?=
 =?utf-8?B?U0E1dUxiU1BJSXRmWVJGNHRFZmFuUHlTMDFTaU1mc2tpMDJJaVdSNEVJVEth?=
 =?utf-8?B?STdrd0h0RHc2NmY0OG93YW56b0lWOE9ZSWM0cXlQSURWOXlOZGc3UDRjVnls?=
 =?utf-8?B?U0lxZkNTWTBWeUV3Wm5LQnVNWnZjVThVN1BMYkt6T1BhZ3h3aGc2RThObzhm?=
 =?utf-8?B?MnBhKy82UjNueDVIZzVjbllGRlFFM1BvL2hsZlFnRXNPcVlBMXlUOHMxN1NP?=
 =?utf-8?B?SUloNS9VSXRndnB4alB3cGIvWC9tYWVCS3FsZ2J5eURINWxIeHltcTBIemtE?=
 =?utf-8?B?aEp1Y0JheTYzbjRndmo4K1FSTHhoUnZaMzN0WXExRkQvNDhCaU9TUU5oQ2Yw?=
 =?utf-8?B?WktncThud2x4UDZ1dmwxSUd1NE5sd0FnSnZ5VlZhSUt2ZTVTNllsN0t1aWNh?=
 =?utf-8?B?R0ViWVZSellpMm04WmR5MEpXRzN3SmdlTXBGVER1UGViaXBISkFFVUlFYTUy?=
 =?utf-8?B?QVZLSWluRlNwWE4wZkdvU051RjhiMlBGQ0xXaHNiWmF0eUpoc3dValpCOUFP?=
 =?utf-8?B?OVVGNWh1eVBuUGRpVkw2MGxhVklPV1RhdE82dFJrZzlkdTBZeWFCYXBPSXNJ?=
 =?utf-8?B?aXVMZlR0RnNqaldQZmxZREEwLzkrVTI4cEVGQVR2SGFtTGQ3cTNJdTc5YWlU?=
 =?utf-8?B?MVVwd0pBNFdkRXdiNUpzTndzTUg2MENCSVRWU2VaYjlqcjJzbmExSVV3T05H?=
 =?utf-8?B?a3d5TXl6T1FrTG1NQXhJVkJEVmdpZU0wbUd2SWZzdGNTbzcwT252eVB1Z2p5?=
 =?utf-8?B?dTVKenZ6Mk1tTGkzY3RBODFnYmFRN01tWnRsQXF2UllYbWpxdE96anc2czFw?=
 =?utf-8?B?bXpSSnc0NVp1Yndzd3AzN1QxamlJTlgwYTIvdlU0T2hvTFFTc0xQdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e23416f2-a0bf-4973-de13-08de519936ba
X-MS-Exchange-CrossTenant-AuthSource: SA1SPRMB0013.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 05:12:42.6189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j9SuxNSYkuuStcOriNjrGV79rXKLd5MXQbERiwGT5FtGqhnr/yCm5F2GnA+40M8XjFyoPJ63m5gQp8uuMMks4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7751

On 1/10/2026 3:39 PM, JÃ¶rg RÃ¶del wrote:
> On Sun, Dec 21, 2025 at 11:04:16PM +0530, Rakuram Eswaran wrote:
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index 5d45795c367a..075125f0f52b 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -2426,7 +2426,7 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
>>  		dev_err(dev, "Failed to initialize - trying to proceed anyway\n");
>>  		iommu_dev = ERR_PTR(ret);
>>  		iommu_ignore_device(iommu, dev);
>> -		goto out_err;
>> +		return iommu_dev;
>>  	}
> 
> This is not the right fix. It makes the function omit further initialization
> steps which are needed event when iommu_init_device() fails (which it only does
> on out-of-memory).
> 
> The right fix is to initialize dev_data to NULL and check for that value before
> dereferencing it further down to keep the current logic.

Ack. I think this function needs rewrite. PCIe device capability
check/enablement is scattered between this one and iommu_init_device(). I will
fix it as part of other PASID related fixes/cleanups.

I think for now below fix is good enough.

@Rakuram, @Joerg, let me know if you want me to send proper patch?


Fixes: 19e5cc156c ("iommu/amd: Enable support for up to 2K interrupts per function")

---
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index e46a63c85337..87bba1d31a6c 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2983,8 +2983,6 @@ static struct iommu_device *amd_iommu_probe_device(struct
device *dev)
 		goto out_err;
 	}

-out_err:
-
 	iommu_completion_wait(iommu);

 	if (FEATURE_NUM_INT_REMAP_SUP_2K(amd_iommu_efr2))
@@ -2995,6 +2993,7 @@ static struct iommu_device *amd_iommu_probe_device(struct
device *dev)
 	if (dev_is_pci(dev))
 		pci_prepare_ats(to_pci_dev(dev), PAGE_SHIFT);

+out_err:
 	return iommu_dev;
 }



-Vasant
