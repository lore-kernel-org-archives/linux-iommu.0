Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011016.outbound.protection.outlook.com [40.107.208.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182E32264D3
	for <iommu@lists.linux.dev>; Tue, 28 Oct 2025 09:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761645464; cv=fail; b=FfGaxvRmdteKfe8qjtGHxl6RyQsp0ydRl7RHIFXQFzG9Ck0AL7ZVDosmJGyaixpy8VQAd8tmrb02rd3kUOzMHDe1bxIAXsdoH9dqMTROHQUFUB8uNuwe+e1RVCl9JKDZ8pVpHXgm2x0w3R1Y2Uiged3xJZlcLD57ft/fy8HI8Iw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761645464; c=relaxed/simple;
	bh=kRH/xxuyw7zPpElbOBhHSgGiPbH+rEyRU2Zs9C8T6wU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RacfNo1pzt34bhFOGNizQO91FmWYtdEQJd3SDekJOBpHh4h7zE72055ImQMhi9KYoDQJfakYX+pf5qZ9FoRgbdr8hE9gtA3xtO503PtzJ/qbRBwZG8oVvRmrsPmS7gXPXrZziTRdcXKQumMXYtbNdPk4w5j5oVJJ/GGBep68DOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qh0cGJcx; arc=fail smtp.client-ip=40.107.208.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qh0cGJcx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ov326Nidd82eRNhGMBuDdo1iBzgFAh736vvzZTAf/cWWYOYsIgtAvQsmZePUrXAzJxQjfm7ljHl/ww1TLmIP2SjY75dhL/G/0urF7PBgfVKSpMDkc6bMKyhD8nU3+setSUz/uuUAb1EOa0ahlcxm8PGC+XI352qrAjNecQ/CWQbe/aAXfRtuqOEnN4TZpGQEnV2GiX6OWWlClxvHsCarLru3KnUM39TYQ8TTSkdp7UBzU11MiCIaRO7cq5QIjZPdUf/p/uyQSTAjGOnf1nlqGuvy+exEorrZluQI9Pd0NDd9C+onuL6ZDLQd2BvVFE0xjGbSg70+VZiY1TJ+e1u4hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ofAfSeqDvrLapbZyWS6Fj7aoO8bMduhDmBsb+iha6Sg=;
 b=hiNppjpfTJF1xHysPWeoeS8HaSZ/8gkWjAVDvSI9c54i6qbbeiGRnPjLbdb/x9rBRT9xwFT2FEuqKjvyIwxD+KJdHlk5CgSqwnF4C5PQgol2p9GtpgFVoptvhUrtDjHCpoy7fAvPPwfUKPrA93wfVRLyJ/jpXCrjGjUACa4hW26lEXT6YdDdu4vxuJmwkILfFlVyBQgBVE6FoBJYNI+HZxjrIbqhOp1D4YuqDXItYruX24mntDBBPd4ealbcqvAcPoAW+FaYjEXtt3g8bwEnPx1ZnFj/ezLgJBEnxwsERfchzzl9IA6tETw/ICdv16u6OGJLGFm0SJC9PfaSLUpnHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ofAfSeqDvrLapbZyWS6Fj7aoO8bMduhDmBsb+iha6Sg=;
 b=qh0cGJcxBsYtto3k/XIUKFepKtZCZLrjpoByNGF2g8IHxNy6lEtX21jMKiHAgly0BAIWD7ulfyDqvVtaAoM7CARvdyTCnogUwhlVwjPNO2hmbuf5/Pua/vf2rjmJ9XnUJ1If5/PV63kRrBAG+R+BoQa9phQeWITswO1rq0nD/Tlm6+lVeWt1UW194+xVVlX9LZsu6wmwyRlXEGevOLs+x0hEtSNFqvtLzxKoyG/NGhJHVpEufacL00mcXZMpZFaun6AHPAAj9AGn042h7+dk+lMbDIVooiTI8vrLelGTb+JKDhtU8c5gJM8SYPf8AuzXyQXoVxpn8rSdklzxNKbbzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by MN6PR12MB8592.namprd12.prod.outlook.com (2603:10b6:208:478::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 09:57:39 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251%7]) with mapi id 15.20.9275.011; Tue, 28 Oct 2025
 09:57:38 +0000
Message-ID: <af36aed2-a52c-42ce-839c-96413327af17@nvidia.com>
Date: Tue, 28 Oct 2025 20:57:33 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] iommu/arm-smmu-v3: Add an inline
 arm_smmu_domain_free()
To: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org, jgg@nvidia.com
Cc: jean-philippe@linaro.org, robin.murphy@arm.com, joro@8bytes.org,
 miko.lenczewski@arm.com, peterz@infradead.org, kevin.tian@intel.com,
 praan@google.com, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1761590851.git.nicolinc@nvidia.com>
 <a4febbb5533127a20f61796e1afc21bc4a132203.1761590851.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <a4febbb5533127a20f61796e1afc21bc4a132203.1761590851.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::22) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|MN6PR12MB8592:EE_
X-MS-Office365-Filtering-Correlation-Id: 86d9de64-377d-49e5-e923-08de16086d5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|10070799003|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qk1seFZ0Z0s4M1NVVUI5MGIwUFhBUXMvbkt5ME53WWZuRGJmZzNJaFh3bE5w?=
 =?utf-8?B?Sjlzdk5IOWtuc0lPVVN0bjRYMEVuaXJnUndrRDdnUkpBQVpOcDMzU3B5U0tV?=
 =?utf-8?B?YWJpL2h5VWN1K2kzRlVsUGZOMk5mNVlPcjY4Zmp0V28rdjlpMVZpdENqL3A1?=
 =?utf-8?B?VEd6OUpxT0FMVEY3YmsrV3lWL2pndkFIMTA5MlpZN1ZlT2pPUVhpZzlPYm1w?=
 =?utf-8?B?RnBlUG43YlZqOG9EUmN5VWFSV0JNWlZMTzhGdEZkdTRhWThVWXFpUDA5WGJj?=
 =?utf-8?B?STZtSldaQXNQSG15WW9Vd1pndkFqaGgrTTBwa1hwcCtjc2sxMjRXQTB0YnNU?=
 =?utf-8?B?K1ZUVzlxR1N0Z2svZ2N5WHYyVXNpYi9pVUNaaklvN0w3U1JzRTRLZnlnaTdG?=
 =?utf-8?B?NmtWSmQyRVZ4YXNZdzJPa0wydXQwcUIyRzNBYXA4SS9Dd3ZRVHhMWHBYa0RW?=
 =?utf-8?B?QkNEV0E0ZnFybVoxUVRYLzRST0FISU1mU01KU2NBVW1tOGV1NzRHZ2NTUHEy?=
 =?utf-8?B?K1VBbGxBTC9kRW9oYm5LRjUvU2o4QVhlSFZaUzBLdXJ3R1BFU3p2Ylg4KzFX?=
 =?utf-8?B?ZVo2b1EvMFkvNEtuaklCU0IvMVJEeFRsTCtqOVF3U214Wmk1QTRZRnVEQjRV?=
 =?utf-8?B?UW9HeGJGR3MxUkNiMmdjeklGeWFnUTVacHY1ZVhDdXp5NEx4b0IyckZGQWt5?=
 =?utf-8?B?NzVGVlRJTzJKMUpOQ2thWGYvWGl3ckZKbUI4Nm9nb3dMUXEyMUptQmpobTBk?=
 =?utf-8?B?bG5HSFhpejVMMzMzSGZDK1hhSHFEc2pIcS9kQ1FydWYyWk1uZHkwdWpRUUs4?=
 =?utf-8?B?NGh6blU3Q2dLUDNBRHp5b1RFWElVQnN4UWVmOGV4UTdxcWlRTUZ2azVFQlN1?=
 =?utf-8?B?V3ExSmFudUFNNHQ0N0RHTXF5Smd3Qm1pZ0NYemZRdkRWVVlqUWg3UTFqb0VO?=
 =?utf-8?B?MkJ0ZnJkUjZ3SFR3THJLNGRISnJjU1BGTDdKWk5MTmpqRE14eG01bVl5Nkly?=
 =?utf-8?B?NExVa2F6R0RqSWxrdjVVWTdhU1JqME83cDhOYmhldmhTVXpLTlpRWU9GZDlO?=
 =?utf-8?B?ckdVOGVSZTJpVkpkTWFSZ1Q5MlpPdEpMaFV4UitvM2dVaHFwVmxzazZraTFD?=
 =?utf-8?B?UC9YR2syYy9MdFIyQXJSRTVlU25EaUtkNy9VakY1cS9TMUxtbGZpckRVRi93?=
 =?utf-8?B?WmFERlZmN3dNbU1aV01wNDZHcUpXRnRYNFM3YytQRjlLSmlQMmFhRlpPKzRN?=
 =?utf-8?B?ZmZhQVhsbmRJZG90VThzSk1wdm9ndXJCWUg5TTViV2JvSVJtUS93N3Izbnll?=
 =?utf-8?B?Q2o4U1d0WWtHbS9hTHBsajhuaG1oTXpJTVZSRnE3ZlVMOC94aWYzSEp4VXNn?=
 =?utf-8?B?T3IxaHlwYlJQVnJ4eFpzQm1NQjJDL2F0aE9tbHdrMEovS1l0VlcrUEM0bmxu?=
 =?utf-8?B?SGkvem00UlVFTndwZlVORmtienBaKzlHQ21IZGZ1VGF5eWczSUo2UFBjYTZv?=
 =?utf-8?B?K0tsdTJEamFNZmc4MHFoNytLdzBZZFFkMW01NzNZaXR2cVpyOGlUOGFJUEVj?=
 =?utf-8?B?cEtnRkZCcGpOQ09CR3RyN3Q3VU1QWFlJV2t1SExmVC9mM0h0UDVWQTRkaGFO?=
 =?utf-8?B?aUhNY3RPV0hwelpuWFBBMnhFbURyM2RDeU9YUENlQ2VYSDJvcE1weWUxWUVU?=
 =?utf-8?B?elRQcjZjc09HMFlrNkNJdTA2UEF2UnFOdlI2Z1QrdFlJcXFWQU9hdVdlZEpu?=
 =?utf-8?B?VkhWK1hWL2o3eTZRaWtTaGg2b2ZsZHArRkNHWTZTSUJtczd2MXh6cXJreFdG?=
 =?utf-8?B?QXBFRHlKcVBSMUI3azRJMGJKNXUzRURDYnZTcnpnM2pRcWZIYmJNS1FYdVBm?=
 =?utf-8?B?TUtBME1aaUlpUDhQQm83d1RLUTdlbG9ZOW1FeDRmZHVZdmNHd3dxUElIbnBM?=
 =?utf-8?Q?6x1H+DosQmL9HPDEqSFqsG60wM8bgmO4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(10070799003)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEdZWUt6YVJmZDdmM3dPSHltblVaR043dUUwK0RNd3FSUTRiL0Y0NDc3eWU3?=
 =?utf-8?B?MmVZNTFjTXdNSXFKaUY3VCsxRExTTUp6ekdvRmlDbWhPRFRRTzZXb2pRWTNv?=
 =?utf-8?B?QUF4cnRrY2RSSWx2V0pZbGVtQkhlUEdNR0ZxVzB0WG12c1Qzd0U4VUNxSllw?=
 =?utf-8?B?UzFzMGRtUkxCV2VTNUlabGltYmtHMjBmM3lIVkZlUDZ6cEdxU1RqSWpVeHI1?=
 =?utf-8?B?M3h0ckE1MkZSQmRMVGUxZVRhQ1lsUytXc2J0cWphNGtwMC9naXF3NnI1MjJ4?=
 =?utf-8?B?cjJTT05IS25BY0xBME9JZjhoenZkU2Zhc2Ixa1REN25HeFZZRUpyS0RqV0pZ?=
 =?utf-8?B?RjF2VnVGRy94WjI0ZHgyckRCTkwrWVZzY1d3QzdKSFcwYkIvRkZNd1cwR3Nn?=
 =?utf-8?B?c050c1R4bkxWemdCcFN6Lzk0d3VHKzVGdE11VEdwOWNCMEFISkZBaGFJMnhj?=
 =?utf-8?B?bXAzNW9HWk5xUkRxbGZ0YTdSUFR1UXhWelM4emd4SWZmTEhYMENvRFdHd2oy?=
 =?utf-8?B?OGdhbERSM01aZm1wRVNLaDVNcXVrWEg4d2tsdzloSzBNTTIrM250TkNLdGJs?=
 =?utf-8?B?dFJpd3ZhTVVJeTZhUythQjBJaWdvM0lLM1RXQktHdXUvdFQ2amhxOFd3U2sx?=
 =?utf-8?B?eEIwTDBWQjlDbTdzdDhQL3REU29waFJ3N2FCNXV1TGt5TUVBYnFUa3c2TTBU?=
 =?utf-8?B?OU1FZTNzSlAvSlE4Vm1jcDFpVFBSclQ0R2VQWmpiZzlkQkZSVWhna1c0T0Zl?=
 =?utf-8?B?dzViQ2pLTEtoOUxtSmF2Rnh5cUhJU0RIL3F3NXFvN0w4bndIWmxwQ3lGVkZC?=
 =?utf-8?B?bkJSMWZQVVVrWlM1dGVCVzRLS3pGSVkwdzVveVFpQ2ZwRTd1cnhaeFVWUERB?=
 =?utf-8?B?NTV2TCt6b2I1WXdCbmZ6cDJna0RoMGt2ZWhNNXBUNk1ubGFNeFIwaTFuanJ6?=
 =?utf-8?B?cjBubkdjamNSaW5QQTVKeXJaZTlaN3VaWnlzd1dxSFVydlUvVERQRlJBRWxH?=
 =?utf-8?B?R1ZQMi9MNWxjZ3hFbDBiWDZ1Zk15eFo3YzNaU280WWtoOHpKM0RJSU9xY0sz?=
 =?utf-8?B?RGJhRUtwQ3l6NVJPWFdCaTd0UmtpMFcrT1doM3M5MFpLZEcrYVFSWlZ6Zk5n?=
 =?utf-8?B?N1J1VXoxTXlna2VoMjl1dTRjYXR5dk1vZVpFV2FjM0t3R29DTnA0bTZ3UVpi?=
 =?utf-8?B?dmdHOGhLYTFCbGtVNHJxcjg5ekNoUlU4aHFGMnk0Y3RTTVdyNksvT0ljZVhu?=
 =?utf-8?B?RzVqN2FNK2dzT0VzZ0RzMjR0eHNldG1iRmhGYS9FaEV1cUttamE3K09EZVRu?=
 =?utf-8?B?Uzc0Z0gvZkk2TE9QSDZFSE43MkZaU1F6dEpqck4xU0ZwZXh4ZGF1V2VBK3ZN?=
 =?utf-8?B?VGUzQmFBT1JnTEhaWXgyREd6aG5VaFBXUWhucks0K01CdjZiN0VCZ0NwcVVk?=
 =?utf-8?B?MUJhb2YvVzBKdXJsalEvQ0tiamxMWjU2dWxEY3YrelN4d0hKTkRRWlA1ZFBl?=
 =?utf-8?B?RXgrR25BWnRiVmY1MGZtdUU0TFlZZGowOHVJWjVLcVlETmFpKzJLa201SGJi?=
 =?utf-8?B?dUZZVUpaZVQxUVhOUVdtNXFEVFhoQ1dOOUYrZC9jekFkYlJTSkttbHJGYzBk?=
 =?utf-8?B?N1pxeEx6amFaQXl4a2lGSXBXL2FPSkczK0lBQUNRUFl1cGlIc21EYkxLWkxw?=
 =?utf-8?B?TDhHby9Za2tZdmJ0U0puV0F4dHdpeWlQVWRyZ3dlQkVJRE5yTEhLQjBZTHM4?=
 =?utf-8?B?c1E5bkFPS3hnMnhucUpFcm0wY0FMNyszRlV3b3ZOVWtyZ2IxQW9xRXdaTVdY?=
 =?utf-8?B?c1pJZzVpSEJXVElZQ0dOeFRjNy93RVNPTDVFQnlpMWFXdUJRZGMxZ3lyYzRj?=
 =?utf-8?B?b3Z4aE0yMk1GZm4vLzQ3L2E5UmVPSkJKMm5mVE9ZNlFoVjlwRmVaNFJiOHpT?=
 =?utf-8?B?cUFyUDRCdS9RZU90RSt4WmJZVjlrQnV4aFpOTktUQzFRdkxkNURCYUhsYXJh?=
 =?utf-8?B?K294RkViMm9uSHJvQTRDeXdBa3pDeFNJNHA3T3F1cWlhblBycUYyMU5Sa3pY?=
 =?utf-8?B?Sk0zNXQ0amsrczhzUlRkNWhEN0VXTWRkVE1ZajlhcXIvWUk2bGNVUUs5OTVy?=
 =?utf-8?B?WXBPc0IyUWIvOHFaVHpOUmZJS2JXcHZCUmpyZzVIdmNlbzhyNFdVZUk0ZE9o?=
 =?utf-8?Q?FXtuk1fvqd375oLN/2dkGULeFEILysRhSgM/D+EG5417?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86d9de64-377d-49e5-e923-08de16086d5a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 09:57:38.5182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VqzbqKs14x9PpEC6Dw3bbnSst1ROozSHqmJhrRl+a/DR9Al+pIMBJ3hL2TqryPChGuE6UKejjVJhv/N+lzkYIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8592

On 10/28/25 05:54, Nicolin Chen wrote:
> There will be a bit more things to free than smmu_domain itself. So keep a
> simple inline function in the header to share aross files.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---

Acked-by: Balbir Singh <balbirs@nvidia.com>
