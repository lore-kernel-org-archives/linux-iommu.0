Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE0717A2FC
	for <iommu@lists.linux.dev>; Mon, 14 Apr 2025 09:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744623937; cv=fail; b=CqOkPDWrsoJV06EGpQPX2ITk/eNSF4kNBnj7UqC1hZu8OuwBHvcKfgh0qnm06qgVmERMHIUmKlt59nIfewz7XF0S0+PZABMgt/EDIcufTHZ6s4C+S4054F+daXclY67G89m/mddZ7SiuRmaTKKWW4hSQUWEPmg5sXFRxWukpzu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744623937; c=relaxed/simple;
	bh=8xV+3HLKYwCVe0XMpEtxHEZfYPlJ565ez5k9JhjfrqU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HOOqhm27+N0T5t8adgBwje38thFm15iHWn4289UZCxCs4+tRSEcxThvnB/8YXu/gwdnr3NF3RUyJgT9dQLYKuAFNYMterFrqANvtmanV9WqcuRL/y0tC91CYA4D/LpsQlr2K6oEW9G6OizQsBRZ31iDbYmLRUJM5Vg32jkHJ22E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JI+gg1kJ; arc=fail smtp.client-ip=40.107.94.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JI+gg1kJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LTTS/CWSon5oaN9MLpblT5M29YRrJUroPxoA6vbgx3bQZMuQk4QTX81I4wv3ntaNrf3U9wPVU34bdwsY/wOC7JpJ6TxWJPmRcjXkBd6mSAFacEI9CiS8cGGtT6B9GOBByLwV2MlayZ+FEkcFbtOpUs/5ljXOvF1GdPCh8qrqPF4pPufknujR4vqPZq3Ik3tfuP2CYH+fF9Vx4MEd7oqFngfKW0wPX+Fhc4Dw1YYEr0r4tf4uWQxJiVyA4vyzsxAZBurQUNXzL8VHoyCLPARZbnbSLI1MZyckrUfUaZnMg3wkClk7MKn6tiD5YgYUWabPX4J4pd3Wv3dt0HmF6sS8Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5AfJg5MfZxHHuPQjb6EEN+YHotd23vvhg/TcgqQXiLk=;
 b=fY0Uuws27+qfggzGM6M7x2mMVsy3Jfrkoif98SwLo3hMaf+UfFD2veAY0DoV+42XoHZ4Cc33jibEkBpUrRqbxow8DqBK1zEslp6HpAANbY+rm7xPE2cOU00FPHUwfjKl4yaAe9nEgkNVob1YooHtUdev5dtmuPMeUO0PlX4e7bPwfyFrUvdcx/vZAYHm6ket73FBHlmQUjKZvEE7Ubw8wavuZCgwj4CFJIdMNFtJri+8HORhhqYJ5ZRKSoqRQn0Ur2CQ0IoOog+RJDlQHjKhv9ai8mlTMeGlcuR8U5XZEESrpXx2ltwr+2QMc1rOe42YVB3q+hIHKvdyhZL9CoE8Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5AfJg5MfZxHHuPQjb6EEN+YHotd23vvhg/TcgqQXiLk=;
 b=JI+gg1kJsH5TEFgocROE3njQ+PckYS4Ou0B1vaAmYSzF1f2+cGAxaEmhqmzu73x+/b9Fqaal2fwODV2fpQQFP4+Gkw0Z3T7hSwstiVyFBF4X3doXWEBOb83xzHV5pug2zCCwAJIfv1MiyplGhss4fldfCp1JLvWiH19zAVTxPwc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV8PR12MB9082.namprd12.prod.outlook.com (2603:10b6:408:180::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Mon, 14 Apr
 2025 09:45:33 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8632.025; Mon, 14 Apr 2025
 09:45:32 +0000
Message-ID: <4b6f9eb7-7de0-4d0f-b235-fd203f4a8542@amd.com>
Date: Mon, 14 Apr 2025 11:45:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] dma/mapping.c: WARN_ONCE on dma_addressing_limited() being
 true
To: Balbir Singh <balbirs@nvidia.com>, Christoph Hellwig <hch@infradead.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Ingo Molnar <mingo@kernel.org>,
 Kees Cook <kees@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>, Bert Karwatzki <spasswolf@web.de>
References: <20250412094110.3208838-1-balbirs@nvidia.com>
 <Z_yjDsmjjCAMHUrh@infradead.org>
 <22a1216b-4ab4-493e-a1f9-1588840339d8@nvidia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <22a1216b-4ab4-493e-a1f9-1588840339d8@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0215.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV8PR12MB9082:EE_
X-MS-Office365-Filtering-Correlation-Id: 9de9d2d3-3ca1-46bc-5086-08dd7b39196f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TzVscGZZRDFtWWRHcldsQ0xhenlCLzl1VjlET0ZIazREdWkvTWFRdGRnSEx4?=
 =?utf-8?B?WlBQSzlQdlNKYktrblNPcVpESjhWc0tLS2ZSZEhETE1oK3dGMWI5K01PVlk2?=
 =?utf-8?B?LzVyU2xqVytvUk1HZ3E2SDNDNEdZeEJsalpvT2ZJMU9iVUc5V2ZSb3k2eVpm?=
 =?utf-8?B?RFg4VmlzelhGSlVhNlJKak5WMm5ENU5GWGNnZERGWXZ0b21BNXByMGhMTjF0?=
 =?utf-8?B?OGxWU3hDNW0rZEpzcjlLdC9mQVBXSTljQm5mMFVOYXdBcE42UENtVWw2eHU2?=
 =?utf-8?B?Q1FIWjZzWXVUM0pWaCszUDVpSzdpdGhPZ3RKZUxGcFVReFROZVpGSmtCZmM3?=
 =?utf-8?B?aWJWUVQxVUlmNG9LTFZ6alY1c3kreUdyUXNqR2lKKzNUVmQrZjZmd1N5Rlgy?=
 =?utf-8?B?MmUrZUgyQ3UrcFlkdWFIdXRzQUNLY3BJWlBpRTVPTHdDd1lQTFhqTitzMUth?=
 =?utf-8?B?Ump3UE0xZ2xVM1VDNFpsUUJPK3FDcWpLRzVGZ2U2eGh4dTBabmMvcnUxcWgy?=
 =?utf-8?B?V1JqRFhJSFd2S08zdHYwTFJiNXJMKy9YOWRObFgrYXNZNTRZSHMyRnRWYzhH?=
 =?utf-8?B?cGJhRTZGemZDdE9XUlhFdjdNWVhsTmU1VTh5NlJXUThtVi90TTJkNWpYNjhX?=
 =?utf-8?B?MW56NHM0Rnc0SDJPVzZ1T3I0Y2ovZVFicWdDNWVaMk5BcFRacUFLNGtWUi9Z?=
 =?utf-8?B?TDA0dTNPd0hVRXB3ZTl1dlAzbWxoRTFsaWVGVk5DZVZpR3BYaFRoRUJ5U0sv?=
 =?utf-8?B?RjZzcDlmb3BWUmRnUkI2ejd6TWZ5MStuZkJUb09NaEV5WU1ORzZtdHR4OTZl?=
 =?utf-8?B?eUdjS25FRjEyRzBRVjR6Z2ZLS21qMGt0TDJ6Y1R2SHZ6dUEyc2x5b3VIY29a?=
 =?utf-8?B?b3I1cW85cDlwRkVuMy9QcWVsTlUxNkRDR2FUUHAweVFIZWVTdThhUzBUQWRN?=
 =?utf-8?B?TXRpb1ZGakc4SnNRMUFIeCtkQ3JudE9hb0VwOVFOOEVqVmdWcERpeGtBb1pL?=
 =?utf-8?B?UDVhVUpVWU5XWG1vUXRqNXgyTUp6MGdBckZGSGlqMXZKOXI1K0JzZ242WXFq?=
 =?utf-8?B?bW9OcmpxU2NqRy9zaHVuQUhMUGlYbktSQ1ZvaFlMWlFQUVhITEpQM090STVX?=
 =?utf-8?B?NEdjOXN3SVMyMENLY0lGMnpSZ3crMVhEa2tsZHM5L2t5aHNqWXBSSHY1amp0?=
 =?utf-8?B?YjkwbjJHamF0UElCdStuWGV5ei9CeXk2SFhTcU84S2I0MlBHc1d0UjJ6elZ5?=
 =?utf-8?B?S1RCWVExVFNGOHRJUG5vR0E5ZVA0NGNXTUtVUUF0bGhxaUZoR1JSQ3h3Z04y?=
 =?utf-8?B?bHU0Y0pFdE1CMnpnTmZheHZnS2VXaFczaVRKMndOTTg1QXgyU0poNlp1NGlo?=
 =?utf-8?B?SnQ1Skc2R24wbGZhZGtDek9oS3Q0N2pTYm5zanluZWEwL0xNbVhRMnNJSHVQ?=
 =?utf-8?B?K2tXMXVaZVk3NytGbWlQU0lDeWliNnFwalk0ZG5laTNYZGFjeGhIN1g2eTRT?=
 =?utf-8?B?OXJJUmg4eEthUGoxZFFIZDloK2szM1lmaHBuUTNSWHZzSWNhV29xcTdOblg4?=
 =?utf-8?B?L0tGOHJwdjJkWlhvTTJOL2pwcndxMi9aVVN3NDBIcWlhQXB5SjdXV0JJZzlY?=
 =?utf-8?B?MlNhWXlUVWdoQi84NUVPTWxIWi82bGJkMWxkVjkxcjM4SXMwZFNnRTlPaTln?=
 =?utf-8?B?WUhXQ1FOYkxmVXpSaG85U2pDTktCZmNML1luSEw5aCtwemZRSHdhNzZUdllG?=
 =?utf-8?B?NTErUmFzbDNHcmx2S3BuM1AvcFpITkQvS1Q5cCt4WUdYU1E2YlZhRVhaMnJn?=
 =?utf-8?B?aWFVSDlQUWszUm51Z0dTODhTVzI5RHJZRkJiTmpCVXM0WTZQWW1LVjNBRXNh?=
 =?utf-8?B?UnRSZUl5QXBzdFVjU2gxTHRnSXRsVUtxb0tWQVVydlFyL2ZrTk5ybWx6NjhK?=
 =?utf-8?Q?5VjqxOgP+Ck=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHErSGJub1BXTVNsdTVwcElzM2cySUtFZDlCOVZWRVI1em5hUXNzQW5uclZ6?=
 =?utf-8?B?YXpwQjdqTFhNQ3JWY3JoU3UvWnJFcUdOSDFvTXE3d0hjWld5cTVXT1BVMENB?=
 =?utf-8?B?cDd6SXFzZlVtOGpuSVI0bVd6SXpINnF5OWxIWE5KOTdZcUZPV0poMVUydDRI?=
 =?utf-8?B?UmFxdFlLcU5oQWhNTXFUK3RJbVhGWWphd0pDSjVDc3p2Wk1sNnNPL3dJNGhU?=
 =?utf-8?B?VnhNMEQveDZGdlZvRFlDcTZ1WnExWDVOcGhpZDhnemhMeE5nLzRXRXZ3anNX?=
 =?utf-8?B?dmFzOEl5ZndvU3R3R3dBU3E1YzFmRUVJL2FMMHd0d1dVZXkxZForb01CQWdV?=
 =?utf-8?B?NjhWQjdKUndoOGk3ak5KcWNIMFNoZGhabkhXamRkSXptZlNJTTFMa0FFN0pu?=
 =?utf-8?B?WDhUemE1VUlMSW83UUJtZHlVTWR6ZndzdTZYNEcxTmtOTk1pczBMaEhFV2l5?=
 =?utf-8?B?TStIU00rQVVxc2hVZ3Y4Q2R5UGFOcHpZcGEvem1vY3NDL1dkWDRHUE5zd2N1?=
 =?utf-8?B?VnBJZVEzM2NHdmNuRkFJa2ZVcDN2YXlnc0NKVzFmSDlsSDZDNThpcTBYNnAv?=
 =?utf-8?B?OWtMOGxadzRrSHZtejE5M1ZhTzFWaUVqblFaMmViQTBwa09CMzBNUUJNL3dR?=
 =?utf-8?B?SVliMXBHdkVvb1hRaE42UitLazdlTVl1Y05RYkVJUnhVeXYwaGx4Vll3ZkFm?=
 =?utf-8?B?WGlMN1FWcVZjVVJpUVp6UDBEaW1Pd1EvTkcwNDNHQzY1ell4RmprSEQ5MDNl?=
 =?utf-8?B?NEVjdG16VjRJMU5JamgrNGlQakFMNnJYTFQ3OXpQMzIyUndpekZhZ2kxakFh?=
 =?utf-8?B?bDdiendQTVowMzVnbHZGZzkwNU55WW9uZlJUMmNIMjFyRDVkdlVsSFJtSEJy?=
 =?utf-8?B?a1J6Z3F3MmJvT1E1enNERXdjMEpNVDJIN2hCYTNKVGt3RU9aRjV2STY3eDdV?=
 =?utf-8?B?bHZjSWhUTmZJNEtWNURWL1hERXUyaHZmT1N6dGJhVHFDK3BjZmt5NHNSQ2dQ?=
 =?utf-8?B?MExtY2FnY3VtbUlxcXZiVWkrNVhjN2NFOCtzZzhlVHp4NXFRb25BZlBHci9u?=
 =?utf-8?B?VW1wQWlBVy8vVTRQNHNZUHNnNCtJSEFGM1V4My9zV2FkTnN1emxrOGp1Z214?=
 =?utf-8?B?NWZVUFQrbEgzOTVaYnY4L0JEUWx2K3VtaWdsQkFYRzNGbi9Hc09FUldTYk5G?=
 =?utf-8?B?bkVPMlJLRTR6czZ5Z2w0WmlLNGM0VlN6ZGpoOERDL2hISHBseTEvQ2lZWkVt?=
 =?utf-8?B?YXFaWVBhQituc1VaMTJ3SWxDWGhqN3loNHp4U1BLR2c4cC9iL2dXOG1HWWdu?=
 =?utf-8?B?c3R1Q3k3WkxRZEZjSXFBSm9DVC9SKzRKN1lVa0hQM2NYOHo4VlFMeEY4bTB2?=
 =?utf-8?B?eGZWOUFIaFRJNVBpaTVFQm9GM293SmhlTDg4RlJYdGRseGN3dVNnSTZyS25h?=
 =?utf-8?B?UXltQjNDRHkyUHpFODZ5cHo0cW4rVnIzTDBmYXZiZkhlaEQ1Vk5kVEVTazA1?=
 =?utf-8?B?MDI0VEV3RzlrZ3BBZVdtY3lKQm55dkVOVS9ETHVxbVRhYjVXTXRSVG9ZR29s?=
 =?utf-8?B?NHpvbjRSSGJsOUNyM2xhd0NUemJ6Vkk2UEpPV3dBY2JoaS91bVpoSFpGbXFU?=
 =?utf-8?B?Rm5kR2ZYOFByMSswRExXSlcyYUl2SFFVTFN5bnBaQjFzR2FDWGRITGhYZlY4?=
 =?utf-8?B?M213TUhmNnRXN0JaNWR4NU9yTi9ESHMvRUZHbmlQazNGUU9HZmFjQk9udjlJ?=
 =?utf-8?B?MGpPQzZZYVBldjh3alkzKytXVG9tQlk0S1cwSUlGQm5MMnpiMG1xcVJMTXF4?=
 =?utf-8?B?MUcyazhKc3UrL1Uyd1dpMWNJUHJHZGpJMXhYZkF1b1YzY0JqcFZKYW5SUzVr?=
 =?utf-8?B?UjArWkpKdzlyMDZia2F3clBqY0xEbWJscDhLNU03b2tic3QzeUV1R1o0S1Mv?=
 =?utf-8?B?d1RLZkNQa0dILyt2WElxSXAyYmN2WUdLYzgzWXdZTlpMSTVabTZVRFdqNE1z?=
 =?utf-8?B?aUI0SGFNUm9zL3JrRytkY3p5NXFNMmt4TXFkWWxYbVlZQnNydVNHZEhIbVZW?=
 =?utf-8?B?Zk5Yc0dzRktEMkRieTUzMzVtYmg2TkxBNjUyRFByejZnNFlRSU5Vc2ZwMmQz?=
 =?utf-8?Q?eyoePx9uvGKiJIiiaF/YyJfbN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9de9d2d3-3ca1-46bc-5086-08dd7b39196f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 09:45:32.9106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xVtF433zvXEpA6V6ziJfnKz8FIwM0my9NeXEsNqP9g6n78zAX04mXPgXP1eH1HrQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9082

Am 14.04.25 um 10:25 schrieb Balbir Singh:
> On 4/14/25 15:54, Christoph Hellwig wrote:
>> On Sat, Apr 12, 2025 at 07:41:10PM +1000, Balbir Singh wrote:
>>> In the debug and resolution of an issue involving forced use of bounce
>>> buffers, 7170130e4c72 ("x86/mm/init: Handle the special case of device
>>> private pages in add_pages(), to not increase max_pfn and trigger
>>> dma_addressing_limited() bounce buffers"). It would have been easier
>>> to debug the issue if dma_addressing_limited() had a warning about a
>>> device not being able to address all of memory and thus forcing all
>>> accesses through a bounce buffer. Please see[2].
>>>
>>> A warning would have let the user of the system know that in their
>>> particular case, use_dma32 is set due to the addressing limitation
>>> and this would impact performance of the driver in use.
>>>
>>> Implement a WARN_ONCE() to point to the potential use of bounce buffers
>>> when we hit the condition. When swiotlb is used,
>>> dma_addressing_limited() is used to determine the size of maximum dma
>>> buffer size in dma_direct_max_mapping_size(). The warning could be
>>> triggered in that check as well.
>> dma_addressing_limited is a perfectly expected condition, and returns
>> true for many devices and still plenty system configuation.  A kernel
>> warning with a stacktrace is not acceptable for that.  A simple one-line
>> dev_info might be ok, but could still be rather spammy on many systems.
>>
> Thanks for the review!
>
> I'll convert it to a dev_info(). We can remove it, if it causes confusion
> or users complain about it?

I would even say that this should be only debugging level.

As Christoph explained it is perfectly normal for device to not be able to address everything in the system. So even an info print sounds like to much.

But I totally agree that it is interesting for debugging, that issue was really hard to nail down.

Regards,
Christian.

>
> Balbir

