Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA481DFDBF
	for <iommu@lists.linux.dev>; Tue,  7 Jan 2025 08:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736239864; cv=fail; b=qoy/NFUlXQfMWgw52QEX483udKLVBGJs34dvEyocsBmXBGkCN5rk7Y4sYnvpRWA+jQirM7YsIiOyTcTtuIB9JSVFpTuZR6p2SREPhVcRIPM3vFhZ/DteUefxAn85PgSh8w88kP50DVtnuBwxGNRJVX3sW3s+0Cm/mft59i2IQ7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736239864; c=relaxed/simple;
	bh=DjCN/4kJ1iYhgBLhaBeOcRWyr5wsYoybRjQJrXb8DFc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lu1E4oIKbWDmNZ/UL5kVN+Ms7ml5Gwh++Drt440mt0psxky2D0cYzzRPOtHp6rTj52wz2n72G+Q3RdnqfKE6NmwlSZyhU40dr1h0HH5rRENpIfKtUWTsADHAYl3/x43mTrgwPKd77qQHnrngr+uTxb+VABA0HGS4nwc6pyKtjFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qZNg4jyt; arc=fail smtp.client-ip=40.107.244.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qZNg4jyt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n1Ea8EtDQrKS/8UCmKDuml2yGOZ+vXoZKtvmA+hqZ9z+T7lKYGy3beuK+PKOzfTmvdw5/KhvuE3vLVpySypHcUZ+02U6nWTk/FMLh0mo39MNGczWC3scIEX+9+s/q5XSwLv4SqHtEocinGxh+PZjz8ipUWmY5WxdIzamod6NBie2i6LiJZSHsVbB2q4wIslUExCsdCR6hSu1qlNUYkbBzJ82HYjYYh9JYWtPr0sMccn9A2HERXoiYgc4kiB1nMJdJPvTMpS2+rPDavc8CcZbv668O8ibO92ZY3D/7pPhl+ISgjXOl2NjSPeqnbT9rek39pegFakQgaFCIdxDMC5SKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XjnzhPs2kCfW+0iNMXnpb6vN9pJyLtKS4F9j5yNrdjw=;
 b=UyhCFv7Y5WG3g5J9f6qtiK1o3ntKwqq3XOkYhIqQetZ+0l/tw2xwY4Brv8MBFbv8+uE8Yys7JsjF022zW7nfSAZ3xaUJDVM0u8E9Sy//KaR3Zbi6FMWSc9NSzhHBa5I7hSRNw8WDAdxvWhGVq+P+rL2A3EKCt81iEH6wf6T7TkmAtbyf8iIJH1Ahw0fQhc7IxwYF0fLY2uGDXyo/1VxZFs7HoD1DUGKWTTWDPTPQ0rXK0oUhChmJDjzZWOK3Y2Dx8BgWff9hRDYPrT5SzrUm9bZYBAPyA3SLTVy907IGusvw7ualQKYNusSEB0lrN2nuPoG5wNsrj/eepA8UswHXVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XjnzhPs2kCfW+0iNMXnpb6vN9pJyLtKS4F9j5yNrdjw=;
 b=qZNg4jyt6qhBcb4QloKtnE5QzT8OBJ1iN43rMd7MrHAN2AoUmrvnfv6PQBlwGmELmfLEdOEDwcUGPghyin2PjB5lT+ng/7hzP7fYbTyY7F/bqcz0ITkQGl1/24akmucSD7Vf3eGkOxjhexWt+GaTZln6fas3NhoaDK3C3dI+BMk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5163.namprd12.prod.outlook.com (2603:10b6:408:11c::7)
 by IA1PR12MB7733.namprd12.prod.outlook.com (2603:10b6:208:423::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.16; Tue, 7 Jan
 2025 08:50:55 +0000
Received: from BN9PR12MB5163.namprd12.prod.outlook.com
 ([fe80::61ca:6d43:a98d:3b7f]) by BN9PR12MB5163.namprd12.prod.outlook.com
 ([fe80::61ca:6d43:a98d:3b7f%6]) with mapi id 15.20.8314.013; Tue, 7 Jan 2025
 08:50:55 +0000
Message-ID: <3b8fb87d-8257-44a6-8098-cf2c267087ad@amd.com>
Date: Tue, 7 Jan 2025 14:20:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu/amd: Preserve default DTE fields when updating
 Host Page Table Root
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: joro@8bytes.org, suravee.suthikulpanit@amd.com, vasant.hegde@amd.com,
 will@kernel.org, jgg@nvidia.com, joao.m.martins@oracle.com,
 boris.ostrovsky@oracle.com
References: <20250106191413.3107140-1-alejandro.j.jimenez@oracle.com>
Content-Language: en-US
From: "Srivastava, Dheeraj Kumar" <dheerajkumar.srivastava@amd.com>
In-Reply-To: <20250106191413.3107140-1-alejandro.j.jimenez@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PEPF0000017E.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::4e) To BN9PR12MB5163.namprd12.prod.outlook.com
 (2603:10b6:408:11c::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5163:EE_|IA1PR12MB7733:EE_
X-MS-Office365-Filtering-Correlation-Id: 88a2edc2-b680-40f3-a8fe-08dd2ef865a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QkRQWURLZ3crcTUvTWFEbG9RekRNcmMrckRYNU4vNGFIMVVDTW9maVJ2bFgr?=
 =?utf-8?B?a0dGdnYrb0xyNVZNR0hJc21tSWZiS1hFK0RmVnJjN3dFYlBJUlMzalg0Y3Ir?=
 =?utf-8?B?aEZTb2dmOUUyampTOElHNDZreWEzNVN5WWM4WGk5QmJ2VDBXaFVQc3Fxc1Rv?=
 =?utf-8?B?R0N1RTEyck01WDc3T0c2bU4xb3dyV0N1elVGUDNFNmZmNjYwSWRObjdWVmwy?=
 =?utf-8?B?ZHBBc0htNk8xbGJkT01JVlZud3E4Um9iMm1LejJiS2piT2lOZXlhRWFUcGNr?=
 =?utf-8?B?a3h6QVo2dnVXUDBjMDA2Y3BlemxrRFFicEpzWUpHdytXczdURHg5ejJBUHVK?=
 =?utf-8?B?QVFxV1NQaXE0WWV1dHArNjNEK1BpTmhFb3pZc25ZNmJwYlM3SEVPelJEd0lX?=
 =?utf-8?B?TE5qY0FvY05xcEg0UjlwZHhIM3R6elF4RVZ3K2pOSDhKT2Z6bDJNdjRNWWxR?=
 =?utf-8?B?Vk43aWljOGlrQ1Z4NXQ0S29QMENxRU5TNmlkZHhFb1BKTldydkpaQkhoOER3?=
 =?utf-8?B?c211UE96ZXhBZTdDblIzTlFnMXN0V3dBdlhnVlRLQitsTVhRQWZBK0J4aUNx?=
 =?utf-8?B?NnlERE5pQ2NOWFFKbjBMVlRLUm5RN1FhYTYwQzhab3c5MmpJREUzejQ1YlBS?=
 =?utf-8?B?aWxYWXgvT213SzdEd2RQdkcyTzBNRW1tZmRvaWtOQjZud1U4Tmgwc2NQb3pz?=
 =?utf-8?B?Vk9HelRNU2w2UjNvMlhrWllSWW1GeDNJaXF1Vnk5SkRVMlh1Q0RkWlJsL2Iv?=
 =?utf-8?B?UlUvWmNKNEFraTJkaFlnRWZ1MEQ0L3JhOWlZRGlaaDdvZXVPUmVBeHljMlJs?=
 =?utf-8?B?N3pvTnNpbngyZVN5SWlSYm1LZlhUU1lpNlBwODBhTFhvSkVYK2NVd0RsLzF1?=
 =?utf-8?B?bVhJbEdONWlTOUVkSDdxcEFXbFNGQm8xV0NaS3h2cElNMnE5MzFNZ3pPbGRa?=
 =?utf-8?B?SzRsWmZreDdvVXJkSmtQSEtBc2FrUk95bU50bVpBZ3h3MzNrWDR3K0lYdHY0?=
 =?utf-8?B?NWVVRGtlT2lkMkdUeVc3cGdEV2x5cU53ampLUUJxa1RvQ2NSRFBzTVpyTlgr?=
 =?utf-8?B?d3ArUmkwaGliMXlZTDRuM3RLNVAzTnk1UitZUWpCRm5hQTZITUFFNjRtTlEx?=
 =?utf-8?B?MzVkVUJYR3FQNGJpOXM4b2x6aEM3d2t1MWtzRG9PZWhKSWpyNXhEWDBtVnpB?=
 =?utf-8?B?TXJodk5YdXNhVk9WNGQxbnZia3VOaEJnUEVTVDFZQmw0NmtxemU1TXhMamRG?=
 =?utf-8?B?ekRPOTBMY0wyN1EweVpLL2R1c3VlZXpqV0sxNTk0TnBmSXg2VTF2emJSWDh0?=
 =?utf-8?B?OE83Q2pDRGoxdGluTklkSlB0SU9IbHBTUk1CSDhPRTZNbGFOcGhybXR1Q1Yy?=
 =?utf-8?B?aUZ0Uk5LdG5FUTVHbDJkUFgzMGFzdC9YYnppVE1IVWRTUENKYXQzWTJ6QitU?=
 =?utf-8?B?WWVJMXhDUTdwRWpxY1JiVU56K00yRC9TU1BlT1hFZ0RnSVlVWEJqUlRSbHoz?=
 =?utf-8?B?K09SdDZpZWlvZUJaNGZGNkRWVklJc1FLc1JWc2FHbFBoTVMvLzBzYTRlYXN1?=
 =?utf-8?B?bUlueWh3Snk0eFEzeEhDWE91cER2UjZHY2w2WFZDem9JeDVicG1Cb1UvVVJt?=
 =?utf-8?B?Q3phK0dwbzNXNXpNcVpQMFRBT3haM202U3VyaEFmUHlTZEtMTmY4RC9WVUE0?=
 =?utf-8?B?bVZNZThPWU50YjYyeVRaUGJ1L3IvUU14eHlKRmpWUzg5ZW1iLzVyTXRmNWhQ?=
 =?utf-8?B?Q2hCeC8rYWh1aTIrVHQvNGs2OFVFcnZxaFpEd2lPZisvUVJKQXRaYzV5dy91?=
 =?utf-8?B?RHZQQzdnRm1FWDRrVHA0ZjlPRjZIdmJ2aS9rSTEzeHl2Mkd0S2hQeEE0MTBL?=
 =?utf-8?Q?0HtzsxW5MXw3r?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjhObzZyQTBLM1M3emd6T2FIYzFSSXZHdWF1TDB1VzdSdHJFdzg2NnpYcklY?=
 =?utf-8?B?V1RzL2xjU3YzSkF6MXg1VzNJWDlkTUVTdGhNRjRnUE43K0h0ZENqUmZZY3JH?=
 =?utf-8?B?aExkTDhJclhMOVIvbkpTN0V6dTdVY0ZLd0lvN1JXMDF4c0JkYkxiQjZJMlU4?=
 =?utf-8?B?QlVqaGxDZTdweVpNSXFUVmV3L0hwUFNVdjFiSjZSTG1Xblk4RktzU0JZY0hx?=
 =?utf-8?B?Y2Q3NjZ3c0ZVYVFOOVR1VSt4dG9LbGR1MkFMM25URGtDSFBGN0VTYnlxWGpY?=
 =?utf-8?B?Mk03UXViVnlKbGF4Um8wM3g4M01oR0tma2pBZGJtYlhHaWdQZG9NZkQ1VHFV?=
 =?utf-8?B?RjhMQ1c5eHlsaElPZVR4WHU4aWg1RVNvd3Z0NXEwTmU3WllCNS82WG9SVTVn?=
 =?utf-8?B?YWlRYnl1T2Y2aDN5NStLbHpQZUlUUitGNHJSQjNkOHpKVW1vbExhNkxCVm5a?=
 =?utf-8?B?RFlsbjBrdGZlN1BSNEh6RzgxbFFOVmpyQ3lXU0VXMWZMQ1h6ZDhMWU5BSkpB?=
 =?utf-8?B?bkZjN3AzOGNFWXZaYXo5enZIQlFuRmR6NVJKYTdOTmQyWSt5bHBOSGlDUlF6?=
 =?utf-8?B?QzI1RVJURjlSQ0F5MXVZb0x5a0lhNWQxcnVSclFERWMvVmVmbmYybjBGVUdW?=
 =?utf-8?B?b3pLaTBQR1pvUXZua1JocVBIYXU1MG9GV0V0SXFzeXg0Y0ZOa200QW9xblVo?=
 =?utf-8?B?eWREa1crcjZKYmEyd05ROTF6UFlHMlpDZWd1K1h3dXhjL3BZSDlKVVhyTGxo?=
 =?utf-8?B?MnVqZ3ZuOVBJWlpudVArS1gvQ0lLU1VDc0xkRlZZdW9XMC9laVI1VUt5Nytt?=
 =?utf-8?B?bWJLYWlvdm40ZUdiZjZnVm5pckdwSnVLM09PRUNpVFBCOHpUVi9penNSYmM4?=
 =?utf-8?B?bHdhbk1MaUxQdk0vaVFaa2xXTWFnQUM3S3ltdmp2amwveFNVN2lZVlhGTExP?=
 =?utf-8?B?cFMxb3ZTK2FxUmx5RnVUWlVyb0VDN3FieEp2TUtGdFBkdVRCYlBMNUo2SnBn?=
 =?utf-8?B?M1RRNks1cVVBU3pjdmsxcWtzckgvcy9Tb09RRk1OeE8wdmpDR0JrQ0VIWEdJ?=
 =?utf-8?B?TCtsMFh5ekd5U0NSOHBZZS82bE83bkN0SFhObFNUTEhVL2VrSmJEMldSb2Vm?=
 =?utf-8?B?ZDM1UlEyRmRzOVpYdDR0RkhnT0pJMDZBVmszaytFK2lwZ0I1cTVhbUdFN1Ry?=
 =?utf-8?B?RkhYSjRvRW5RRjZFcDZibm9UM3NIdWVHbndtTEZCdTVCc2VoTDM1NXhoLzdl?=
 =?utf-8?B?a3ZLOC9FUUxHRm9oRGdNTzVNSGZpTU4xRnB2eVNjK29NRmI0V2lDTEludVRr?=
 =?utf-8?B?K0J1c3RZNnEzcVcyOVhmUXp4eEZwMGRBcWY2c3YzblpUakRMeDViZFVMNDFn?=
 =?utf-8?B?aDNKaWlSZUVwazljTzJmdW1wZXhqd2E0cUx4VFZZUCsxMjdNY21PWnBTa3Rt?=
 =?utf-8?B?WEdrOUJhVTBYZ1d2U0JyRnFYZHRMWUt3ZmZOL3JpNEFIR0publMybFF6T0Z6?=
 =?utf-8?B?NHY0SDVqMU9EdEhmZk1mTno2d0dTejBmdnJheXZDdUUvOHJjSVBoMkgzZGVw?=
 =?utf-8?B?U0Y3U3ArNVhRS3g2bDJZcS9oSnF6N2RacUU2cVV6TXp5ZzFiK1hqNmphczRF?=
 =?utf-8?B?SE5NNUFZK1pkUUZVZzc1MXZFdUFzbDZlR0x1bEdwc1VLWlI0cHdjWUI2aXBD?=
 =?utf-8?B?MFlDb1NnZ2xmNTlVZWpSYWVWKzRCcWNsbHFnclhUM2xGMC9rdWdIWWhicWdk?=
 =?utf-8?B?L1czd0RIelFIcDRBOHVuNURabkt3ZFdtTURISExtb3loK2hjekJJK1dOWkh2?=
 =?utf-8?B?QnVhZ2t4WWlaVmdkNVJRdGtXaW0xT3FuektHQjNDdlFOMUt2SFFSQUZ2SjVV?=
 =?utf-8?B?SWdkc3JqR1lTWGVFa3dWc2NNSVNwYldvczl2dXFJS0lkUm11dyt6MXBFd3VV?=
 =?utf-8?B?UFZaT3M0TVprWGY0Wll2Tm5TLzJzVHg4ZnNnRXRya0NlYkZnWTEyb0JCK2lq?=
 =?utf-8?B?RytMaXA1VlhZeVFUS0xjZkhMQnE2Uk8wYjdwRi9mOE45RDJsTDlJQzBVNVND?=
 =?utf-8?B?VjlONk00c0ZuZ0l4cWh6MWJUNlVWanE0cEJvTkFDNkZZM3BmN05IandlSVFN?=
 =?utf-8?Q?U0Okvpsm7DCma42FhrYKnsEZR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88a2edc2-b680-40f3-a8fe-08dd2ef865a0
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 08:50:55.1367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SWI+jm5FOMeLWcTHgNmCMD7tYYmM2CBZskOFwRA5/HTqCJIpajKqW1GrJ+Nktcf6LFNG1qPc6c4P3+K2EtLJeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7733

Hi,

On 1/7/2025 12:44 AM, Alejandro Jimenez wrote:
> When updating the page table root field on the DTE, avoid overwriting any
> bits that are already set. The earlier call to make_clear_dte() writes
> default values that all DTEs must have set (currently DTE[V]), and those
> must be preserved.
> 
> Currently this doesn't cause problems since the page table root update is
> the first field that is set after make_clear_dte() is called, and
> DTE_FLAG_V is set again later along with the permission bits (IR/IW).
> Remove this redundant assignment too.
> 
> Fixes: fd5dff9de4be ("iommu/amd: Modify set_dte_entry() to use 256-bit DTE helpers")
> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

LGTM. Please feel free to add...

Reviewed-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>

Thanks
Dheeraj

> ---
>   drivers/iommu/amd/iommu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 20177e18eb0d..a8c17b602c95 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2052,12 +2052,12 @@ static void set_dte_entry(struct amd_iommu *iommu,
>   	make_clear_dte(dev_data, dte, &new);
>   
>   	if (domain->iop.mode != PAGE_MODE_NONE)
> -		new.data[0] = iommu_virt_to_phys(domain->iop.root);
> +		new.data[0] |= iommu_virt_to_phys(domain->iop.root);
>   
>   	new.data[0] |= (domain->iop.mode & DEV_ENTRY_MODE_MASK)
>   		    << DEV_ENTRY_MODE_SHIFT;
>   
> -	new.data[0] |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_V;
> +	new.data[0] |= DTE_FLAG_IR | DTE_FLAG_IW;
>   
>   	/*
>   	 * When SNP is enabled, we can only support TV=1 with non-zero domain ID.
> 
> base-commit: 1f37ef785d54b27e304c189038697a845259408a

