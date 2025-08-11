Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76594219A9B
	for <iommu@lists.linux.dev>; Mon, 11 Aug 2025 13:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754917517; cv=fail; b=YjggrvfcfWCOsj0VvLfz1TsfeRVTiOFwedcgdldgwr0saOEE6fe7rhf8Y7y+F11qoMurA4UAOWJtjKgj91iRc4AVSwDw4ZNwmsfvk2AJ+HPMFvrStUkL1pu9dJlV8KJGjfRvx7NOE2iRLVFshgic75JHpXMrvPtGHPdovquAztg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754917517; c=relaxed/simple;
	bh=pdh2/ALE6DXLbuZiRvL2rCpdFy+cMWHWvdwdyONY/8w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NhScnrqxn8FAUf44lgfdO5Zqkr2AoNgX0Q7ALYHjtGBpsIPYjz3uQatCjNtwyLhBXJpa3NWgsWN98q37m1CcJSCAxwa/62x41SZlbpUpGI7jF0DEPBnDztfiUE1NRI3cN5/HXzcAByDsGn6yJFth9QYiMERAlHoi8l/Tp0JPz1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=owTvjA4B; arc=fail smtp.client-ip=40.107.93.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="owTvjA4B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x1zV8o2D7VmBmtykh1H06rG0DcABl9XgEte7zF9ZAHwJIfko/BoY8O494lDVDUFwq+kHBVNisApxEq73cDZLvy80+twDesL45blw926dBsycq5nYd4CEgmpcUKeiluyV+cpnq6vrFDWyqxCGxd1kYkovpb28S1arJKKRVaECuBL8z2BUO8rQ6j8pcDPRhvzqMzauXAPsP9z0QFp8Y9wmfTs3D/G1TOELQiBv+Wt93B5s9lhjv2T9yc+AC59WMpbnfJ5DM+ERIpx/U8hrrPWuPHrWd+Nt30cgd+Fj5C2blot0Q8I5H5HqZqACpb92i23LTG02a55n/9Euo8zGZfsG1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0QsZyseXxN4lwYm3r1RJLzohiAVeCEGgOMW1LF7vbQ=;
 b=Fl0cSsVG8mvrC4kxmR+JIgo3cIVTofEbf10SkI0MrVNTi3fNUW3QHhpsKPfnNDopFJ+U2tOyBffVauqLO8WyY2jMydxE0m7ZdUmCRypvmGRrveGjzaZXkB0/gX3u7Td3BtoROYsBzATnH5hH2lFm+vRfLxTg73BWJ0EPU+iph/xxtjC+J4sHNrviMScTjKapXDnGO41Gnr6qXo+ldm2TL69BkPtsJZ3MSGbh2W6Ldk68iAPqC4lerGk4NuvrHR7MvJe6a1cr3C1lRiOjSiBpTJFP+aKkLg/Hw41LKXb2SwV87N93TEzMqWoR94YPjwmkdKdAJMnIZAH+TogEFmTgfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0QsZyseXxN4lwYm3r1RJLzohiAVeCEGgOMW1LF7vbQ=;
 b=owTvjA4BH7eCoAa0UPTUuSXUPZ144SRR6e38Jc505oyZyjzPfz7ySg6vSEH9CxId7bJf838NSl8OC0qqyIlcB8Vm4KLxRU8HTFmUAPPX5RqTIzShyMUsR3ZRk6iulO6DgJUjWfRfw8pA0EqzXeMsOLYIsqPOAPT/VcCCCOO0GkwqXOyeIY8pDBi/fTtGkgZPaPx378oykNsUJ7F9iNEkvEyNBBYyIG5HCTvmTPdB3MhTdNXJJDvqURDdQCelSQqqGfkHumRuz4iOId12bS45EUvB7y7/TtfRYlhGmPCNfYvfMBrgBTjAyKwEBXgDl2sSW7iPo1wCr1BNKTSeNhNkWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6606.namprd12.prod.outlook.com (2603:10b6:8:d2::20) by
 BY5PR12MB4324.namprd12.prod.outlook.com (2603:10b6:a03:209::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Mon, 11 Aug
 2025 13:05:11 +0000
Received: from DS0PR12MB6606.namprd12.prod.outlook.com
 ([fe80::ee84:cbaf:9af1:3f5a]) by DS0PR12MB6606.namprd12.prod.outlook.com
 ([fe80::ee84:cbaf:9af1:3f5a%6]) with mapi id 15.20.9009.016; Mon, 11 Aug 2025
 13:05:11 +0000
Message-ID: <df91ac56-9240-4ee2-b154-a911c4053dc5@nvidia.com>
Date: Mon, 11 Aug 2025 08:05:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 2/2] arm64: Add encrypt/decrypt support for vmalloc
 regions
To: Robin Murphy <robin.murphy@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Steven Price <steven.price@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: Gavin Shan <gshan@redhat.com>, Mike Rapoport <rppt@kernel.org>,
 Vikram Sethi <vsethi@nvidia.com>, Jason Sequeira <jsequeira@nvidia.com>,
 Dev Jain <dev.jain@arm.com>, David Rientjes <rientjes@google.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev
References: <20250811005036.714274-1-sdonthineni@nvidia.com>
 <20250811005036.714274-3-sdonthineni@nvidia.com>
 <d8048adc-b19a-4d10-83e8-44b9a85c4d48@arm.com>
Content-Language: en-US
From: Shanker Donthineni <sdonthineni@nvidia.com>
In-Reply-To: <d8048adc-b19a-4d10-83e8-44b9a85c4d48@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM5PR08CA0031.namprd08.prod.outlook.com
 (2603:10b6:4:60::20) To DS0PR12MB6606.namprd12.prod.outlook.com
 (2603:10b6:8:d2::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6606:EE_|BY5PR12MB4324:EE_
X-MS-Office365-Filtering-Correlation-Id: ca24223a-ca05-44d7-f991-08ddd8d7b49d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SSt2cUVNZWprNmtpaGdjWDJtU3hJUFU1RE1PVHM3SXBwODduMmxrTjExcDZG?=
 =?utf-8?B?aDJSM2RmNHE5OHFralJJbTRPcGZrcm1XbHRMTE1nL1krSzQvMm1ySzIyZDdD?=
 =?utf-8?B?NUV0LzljR3hzSHdrU3l1eWtDcW80d0RWT3dXRDV6R0pPYVdIbVFwbndmWEJR?=
 =?utf-8?B?U3VaWUhuYXdsNWxJZHE1UlR4VGpNZHJpRkp4amJpeHRiYW5zUzAvdS9TVnha?=
 =?utf-8?B?WHRjL2ZzYzQzUHFqdFhWb2xDMnUrcnU1K1c4d0pMcGl5d1lkTWJ6akpBenFi?=
 =?utf-8?B?RENHbWRrbVc4TFcrazh6T2NQT0xaSGVZc1MzMEFib2RiR0UwTXZlT1RKVFlN?=
 =?utf-8?B?dkxVejROK01od1BJYmNkRFRmazk0cFJEWUM2cTJmMVdNb0o1OVdiK05Ya3lL?=
 =?utf-8?B?NW9oV1BFKzZtRm9BZGlrRzlDMnl1UTk4SmpmeXp3WXhaN2VTU2tIbTRQeitN?=
 =?utf-8?B?aDM4ZWgzRnM5SUNEUEU4TUdzUHpYWXAyUVNuaitTZ0dONkdXODRqVHF3S3Fa?=
 =?utf-8?B?RzBQVGttVTZXMTBqSmoraDhUOFVRTUhycDFheUhqVml6d0tqNXZqWHdFTG1V?=
 =?utf-8?B?cHVGVGVvUDdxRnJuUHliSmdvTEpZTXlxMkxTQVJvYi91S0tTb1F4SkxlYTRo?=
 =?utf-8?B?Q0g5NEJ5RXJDOE12S2N0dGFwaGV0dkpuYVNTNFVubUpQWG5yMmluUE1uU1dX?=
 =?utf-8?B?bXVxbzh5UDJVQ2FuQURNUFVEKzBNbUdWLzVkZWV3dUV2cDNWZ3h3SlRZSUZi?=
 =?utf-8?B?ZnlQRWdPdWlpUVhIQ09na3kxUXF6TzRMVVdyU1lrcmwzQnVzN3ZORXJtQldr?=
 =?utf-8?B?Sm13SnN3L04wYkkzZnFJWlZ1emxKRDFsZlc2MGFCaENtWE1mWEtzNDAzQ2NL?=
 =?utf-8?B?MXBmdlE2MTYvS3lpWHNRaE1nMFRRV0NRRnJnTllHb1Myd2ZPUlBFaTcwNG13?=
 =?utf-8?B?YTFBdlpVYWdsRmRRZkhLeUo5YTJXV2FoS3JELzIwZEg3aDdabTlVdUJKd2Zo?=
 =?utf-8?B?cENDMmRVT2FzQkRvdEpQZStrNDFwbTNrSHFmOVgwVVFKK09RSlgya3NQZ2VR?=
 =?utf-8?B?c1NyQUgwRlNrMlVsSHZiWU9XYlkxdmd2UjhieGU0bUEvNlVSY245TzdtaU9O?=
 =?utf-8?B?bnlIc1pkc0hFdnhtQ21ucllDNVZ2S3dVWStTTmNOeENnelpCaUc4aDVBV1BB?=
 =?utf-8?B?aWRaMm9pV2Z4eVo2U3ZCcXJ5eHpNaHhFMCswSmJhZi9xNHEzUWRmM1BlbXRG?=
 =?utf-8?B?Ymg0Nyt2WUxTOUdWb2pyYW1vN2ZjV0pseTQ1VndEUFlVZTE0cFJxWHFHcjgr?=
 =?utf-8?B?SXJCSmVIcnJKdmJCL0JBUjRFeXpzNnpWbTFjSFNJaGNxZmpTVHQ5R3hKUG84?=
 =?utf-8?B?eS9rZVZNdGwxMHQrTWNEMnF1YldWdFdNNzdHdkM0ank1Zk1VN0lmNm5iZ1Mx?=
 =?utf-8?B?V1lSWUxoMUMvZjc3UFlTakZaK2Q3K0cwanNHNlFpNkpTRHVmc2NDMktGUUxp?=
 =?utf-8?B?MVFqSWcxeUdkZW1yWDRoNnVoM2hjbWlJUitqcXdGTjRPM2JhOEVkaFB0VklB?=
 =?utf-8?B?T3FpZ3VGV1pYb09VK3IvdTJKUFdNbzI3akxyNWhBLzRyMUo0NUFLeE15Ri9C?=
 =?utf-8?B?Ui9vKzZOYktLYlRXeUxNNzBrc0xmUDJidTRaOXBpV2h6OVpZU0NUOG0rc21H?=
 =?utf-8?B?Y1JCUjM2NFh6Z2F3azNDSTZQVDEzNE5aWHZrU2oxTXV2Um9EdjRaOTdRV25x?=
 =?utf-8?B?dXN3Y3d2Vm1DYnZvcDZMSHF3ZWs5ZUtLaFhrbEVaZlhhZUsyNmhPY3JiY21J?=
 =?utf-8?B?THBSY1FxSGJaRFlOTkRvZEZUd0hzeHZmSUlEY0RiYTJCZUtSdm9xMmJxVzFO?=
 =?utf-8?B?U1BWc0xyZ0NpVjN1OTVRbUVmSDZKN2xQb1hKWThWYjRaamcxcjlWcndOT1ZQ?=
 =?utf-8?Q?/ZqMa4WfN+o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6606.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmV6Slhqa3lGaENCQmk0T2ZDTUR0UHZlRzVSdlljT3BPQ09YYmhRRHlSQnlm?=
 =?utf-8?B?MHczeGdjTXBSTmtEajYzZWhzaXRkSHZReHZpV3hHd3RtS3poZUhvTlFrY08y?=
 =?utf-8?B?NjVQTElHL3VzekxLQ0hERFpLbmNBVUNIa21jRWRuMkdUYTJMRzBSUk9NbzBB?=
 =?utf-8?B?RlVaRll6a3VqcHNQTUdKRFlyYktSb004U2YwTEx4cVBkK2lMclZScFM4VnhQ?=
 =?utf-8?B?ZWg4SjJjWGtFOTAxVzQ3SjhaN04rZHBXNTdybFIwUFpvYVp4bVRPK0MxTXFG?=
 =?utf-8?B?SUdGSkpadmhyTjhMMG1Dc3dvZ3hGNmlPdFZocGhEV2VuRzkzK1o0dmtCS0tr?=
 =?utf-8?B?cDJFK1BxTzB6RHRRcW1zUGtFU2NMTmFjZFRJUUNLZFdSc3M3Y0FWakRtSWFq?=
 =?utf-8?B?N1NQNDFjOXRHQVJDVWZUa0VzTTdlQWRtTnhrY1p1V2dhK2FpYWhoMXplNGFH?=
 =?utf-8?B?cWpWekN4YWV6dHh0N1FnOWRIYzVvT1J6Y3hpRDhJYm15aUd2V2hLZlVKMUxn?=
 =?utf-8?B?YXJMOFlWNlEyWVBGditZSklNVVRoY3JFODFZSmJYVkJvdzFYdnBWTkN1WjNu?=
 =?utf-8?B?SlZqUjlZYUtMMkNqOTlzL21PQ3dvNVNvNzZoZzBndnFzNENhb1h6azhvS3Zt?=
 =?utf-8?B?eDZmNVg3YnVCak5xOHpEUEJGblhsS0ZYYzFKVTBsVmk4VTc3MmFENUdlLzFt?=
 =?utf-8?B?MHF1dlF1Z0ExQnZJbXBlU2J1Q0VTeHRWejk0aEY4clVjWDh2dll4SlppNDc1?=
 =?utf-8?B?MlN5eExFWnZHWG1QQlZ4bTNBUk5ZVzFyVG9vYlMyUU45MGt1V3Nnemt3MDkv?=
 =?utf-8?B?ODQxaTUrUStuZG85Q0FyRWdabWtFWTViZWVMV2VFSWdNYjVJc0d5STVJdFdU?=
 =?utf-8?B?L2Z0YTA2dlRNelliMitsV2hOQlFvNi9DcWJhUnU0SUdHQUpxRjBDdlpDR3Bs?=
 =?utf-8?B?YlBiVWh0eHdIbGF5b0kyUk1IYTdCdy80N3BPVGFFRTU0dTZHRWlVUGUxY1BP?=
 =?utf-8?B?N2N6L0RreEgxbGk5TWV6STloaWZ3eldKaThBWWhwMGNMUzdsdC9QMy90Wk1r?=
 =?utf-8?B?RjRLNllFWGxnQUV5RTlzTjRpQWxDVm1VMlJEbTFTY3B5MGZSYU8rbmwxd1VU?=
 =?utf-8?B?ZFBEblR3d1F6aGY4Y0E4a001cXMxNDQ4UjcxRzZCTjRyOHFMSkJpdDFZNnV4?=
 =?utf-8?B?ZGtxR01tVkFTVXc2NnRPUEhrT2NqcENsckEyS2dTZXBjWFlMTTQ1cEJtYTJM?=
 =?utf-8?B?WDVzbHZISllnc0ROVkZ6NUFSQ013eE5WakRhRjlZVk04dzNOK3VvOFZ2T0Rp?=
 =?utf-8?B?d0MwbmJjZjMvRFhPblowMXc1UTloY3MxcDdJbFp5dGZITVFBVDZIRFIyeEZn?=
 =?utf-8?B?WVhKQ1BvZmNVMmN2NFdocFpRZUJJSE5DM3QrR0d0andqbVFsVE5nYjZ4TUZm?=
 =?utf-8?B?VkJjWHNVbTFwT2p5RitEQmdBczZyREN4cXNuY2tHNmpJRFFSYmRDR3NGdlM2?=
 =?utf-8?B?NGYvVDh5TVo1SzhGYllMZHVGUEtwUzV6RUM4Y2xtTXVaYTQ5cWNjRjhXb0VO?=
 =?utf-8?B?VUVNekdJbFVaRlNRYUpLVlorYjRzSm0wOEdNVWJXU2FNVTZaY3dyaVExVDFj?=
 =?utf-8?B?bWlsSWtsR0JVWHBDYk13T1dmNWNzRDNQYjdBY0gzb040VS9RTkFTN1AxVlo5?=
 =?utf-8?B?M2xLYjdrQitnbi9pRnZiSnI4elZpZTZoTGIyeDN6YmM2TFZvY0tKTkx3Lzcx?=
 =?utf-8?B?c0pjR3BoMGw2TEh0bkFqcUNGaThwbmtpRHk0RTZ3NU55MkZDZUoxeDJpNE1m?=
 =?utf-8?B?YkxYVDMvV2RqTWRGV0U4VXhUeEN6Z3hqZUl2bncraVdWL3g2K243bGdzWVBr?=
 =?utf-8?B?eGlZYXhPYjhVemVpQ1lMUHEzUGJZendTZ3FTdElxTzB6bHRlV0NmR3phVkNM?=
 =?utf-8?B?VmkxWW91MUpTcmtSY0wrRjZ1b2h0Uk1MdWsxRFJYaVlKQTNiaW9uRjVMOC9R?=
 =?utf-8?B?WktNSnlWZHVHSlArbEtJK3ZrUVd5eEtZTFNzS2xHRnF0QzB1eHRNNDZXUmkv?=
 =?utf-8?B?NklMWUNKN0lnSzlGajF5U1I2ME5LM3dONUFXSWZhdlU1eVU0cmw5dU14eWJu?=
 =?utf-8?Q?ij5EJ3BLavo4CW3tZZYylvgRz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca24223a-ca05-44d7-f991-08ddd8d7b49d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6606.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 13:05:11.8107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bPQtN8UXja1sHjvHXBf6NeFeZbBfRJsbVe0cCJW2HrdrB9TxijFpv32vk5nb2Y1jFAZE+FsjLaRoYgV2Oj9lSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4324

Hi Robin,

On 8/11/25 07:31, Robin Murphy wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 2025-08-11 1:50 am, Shanker Donthineni wrote:
>> On ARM64 systems with CCA (Confidential Compute Architecture) enabled,
>> the kernel may need to change the encryption attributes of memory
>> regions. The existing implementation of set_memory_encrypted() and
>> set_memory_decrypted() assumes that the input address is part of the
>> linear mapping region '__is_lm_address()', and fails with -EINVAL
>> otherwise.
>>
>> This breaks use cases where the memory region resides in the vmalloc
>> area, which is mapped in non-linear mapping region.
>>
>> This patch introduces a new helper, realm_set_memory(), which detects
>> whether the given address is from a non-linear mapping. If so, it uses
>> vmalloc_to_page() to resolve each page’s physical address and applies
>> attribute changes one page at a time. For the linear address regions,
>> it maintains the existing fast-path.
>>
>> This change ensures that encrypted/decrypted memory attribute updates
>> correctly for all memory regions, including those allocated via vmap(),
>> module allocations, or other vmalloc-backed paths.
>>
>> Call stack of Realm crash, QEMU hypervisor + NVME device (emulated):
>>   ...
>>   Freeing unused kernel memory: 6336K
>>   Run /sbin/init as init process
>>   Internal error: synchronous external abort: 0000000096000250 [#1]  SMP
>>   Modules linked in:
>>   CPU: 0 UID: 0 PID: 64 Comm: lsblk Not tainted 6.15.5 #2 PREEMPT(undef)
>>   Hardware name: linux,dummy-virt (DT)
>>   pstate: 43400005 (nZcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
>>   pc : __pi_memset_generic+0x16c/0x188
>>   lr : dma_alloc_from_pool+0xd0/0x1b8
>>   sp : ffff80008335b350
>>   x29: ffff80008335b350 x28: ffff800083162000 x27: ffff80008335b3c0
>>   x26: ffff80008144f000 x25: ffff8000801a27e8 x24: ffff800081e14000
>>   x23: ffffc1ffc0000000 x22: 0000000000001000 x21: ffff800081458310
>>   x20: 0000000042a40000 x19: ffff00000232fcc0 x18: 0000000000200000
>>   x17: 00000000000120c0 x16: ffff0000795520c0 x15: 0000000000000000
>>   x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
>>   x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
>>   x8 : ffff800083162000 x7 : 0000000000000000 x6 : 000000000000003f
>>   x5 : 0000000000000040 x4 : 0000000000000000 x3 : 0000000000000004
>>   x2 : 0000000000000fc0 x1 : 0000000000000000 x0 : ffff800083162000
>>   Call trace:
>>     __pi_memset_generic+0x16c/0x188 (P)
>>     dma_direct_alloc_from_pool+0xc4/0x230
> 
> But isn't that exactly the case that patch #1 is supposed to have fixed?
>  From a quick scan of set_memory_decrypted() callers I don't see
> anything obvious jumping out - can you clarify who you think needs this
> for reasons other than papering over bugs in the DMA layer?
> 

Patch #1 fixes the passing of the correct mapped address (via vmalloc/vmap),
prevent this specific crash. However, Realm boot still fails because
__set_memory_enc_dec() returns -EINVAL when the requested address is not
part of the linear mapping. Both patches are required to fully resolve the
issue. Patch #2 is to support shared (decrypted) pages in vmalloced regions.

Thanks,
Shanker
