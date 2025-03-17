Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012001.outbound.protection.outlook.com [52.101.71.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF7F27701
	for <iommu@lists.linux.dev>; Mon, 17 Mar 2025 11:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742212519; cv=fail; b=hnPQ1b7XB+RXmcyW9IAAg4neWzfzb8aVHv9wGUf8v7k3+W0aupaIpr2m149K1qED6ejGERWlCcYFDxriGk64rOSKXbAxiqNLLDzEM48gQaufj61h91HFiRzbbc38dytwsRbqvBNK6MHUXXAU1yc3SqENLxKAe6IrXztSCnih1ys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742212519; c=relaxed/simple;
	bh=MFROJB7J5OkcntWDux/pcEuDHYiHotW9YEYL8kqob58=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dU4E3ApiOAinc0T7H8PI5QBB/S3h62uFl6xcsVYtb0vG1qudQ3UxHMKkl+Dwh2RYi3TJ/U3PddECUIlcSuNnqYRnboJ8cvPi+BcPLtBJXGJ4Kn817KGLK/W/vf2N8RQ5D5stg84Vt8jkV0RF2gmv0epQ40r+TYwnUzs+0UB62Hg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=TYV0vIeM; arc=fail smtp.client-ip=52.101.71.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="TYV0vIeM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FmgFjHtnxENbLYvJ0FHma4dskvi+t9NUQ0PKM14zldHrDYk21i/bCOery+Scu7ZBFUCotoZ7FywRLSVFoijLojNQRSLpZUGJTSWFQcTbXDOZimotw0/yt6pFVwd+nAUTS9v7e9F5W8YbrzX4+eKVpvtuwzMlZb3IL2lcBg+OFHaMMJC2VDUErUopV9bm6QF5n90DG3XJNAt1xgo95Ha8pTSJcCLw5kPNzJD6yy8ALyYjFsiEN/WhLhcZhBxxslXiG9qavHesWkxz2tSM8VSz20KBGeli74ib82z9v6RiU5sBJxzD8MKmms/7NMYinDb7GWjylQ9ceLvRnMzExqedmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pEHEoJlC4MXGR1whsd9fJQRIlvioqD8Zqhluv5Y9LII=;
 b=jcMjHaPUgeUMXHoDLu+JekyzYzaaOL8mKHIgjlOPRfDv9m5W2uh7+riy+cRsqIW+MlvDUxAYyy1/b1VtC4Wm8RmyAme1So2+yZBVqC6drBlj9F+wyhBNthxxVALU7NQiQnRtZOlyxnIcU8B4GrM+IQbk+pR838Kc34uxqhM4LavusZw23SvjuEtYWw+lVOK1kHHGfHFgcwN6irbqZZcNG1xP3jYLLfe7sHCksdg3Lu4jJjYCjfoEBR3PnAYbwIeh5jySxcKipDS5sk8/JTAENF9kJOmLP6LAPwHp2Dh3P5sIlg/eUtYpT5x1WGByYj4snepuwVnshwWiDgAYGUeqdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pEHEoJlC4MXGR1whsd9fJQRIlvioqD8Zqhluv5Y9LII=;
 b=TYV0vIeMwe7TprLVq6IdjvZr8IppeXFhN9iB4ytVf4bHg58vVC6FfYWIk509uT81CZqB4aeDKN5PuMJj+aQKg58C5/Cx96GXF0xuHDZ+Eiq4kslgW9fca/GCSSXR+JfngzMd51bCRe4saEAgvp69ajETx7tK9D8/5Y4GP9g6eA8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS8PR04MB7590.eurprd04.prod.outlook.com (2603:10a6:20b:23d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 11:55:13 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 11:55:13 +0000
Message-ID: <7c620745-f218-4361-82c2-ea0efd3cbbe9@cherry.de>
Date: Mon, 17 Mar 2025 12:55:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Rockchip IOMMU fixes
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org
Cc: iommu@lists.linux.dev, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, heiko@sntech.de
References: <cover.1741886382.git.robin.murphy@arm.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <cover.1741886382.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::9) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS8PR04MB7590:EE_
X-MS-Office365-Filtering-Correlation-Id: f0656650-e0ac-404c-6468-08dd654a936c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a0NveThyYjFQWVNoYjR0VUhmWEV0QmFlTkNMRkhEOEh0aFJNeTNKbFBrUjBn?=
 =?utf-8?B?M0pxRWkxUEtlTU1wSnNDdTVXU2JyOUViMkhmOTlRSEdmdVhXZzQ3YW1VRWxK?=
 =?utf-8?B?a1ozcVN6MU1XV1ViZWtTRWJ5Tjg3SE9NTWdyNHFjeGdwV1VJNWFhK3U1eVRP?=
 =?utf-8?B?SkNGdXNOeWNkTGtUbnhVUnJlalJ2YWFDbkc1c0VSOEx4VHEzbEczNXZTVDhl?=
 =?utf-8?B?TTRnL1pBMHd6SGQwV0hPYlVqRms5Ui9TQUdseG5CNUV2SVp2RFVZb1AxNnRH?=
 =?utf-8?B?R2l5SlA0VVlzamlIZmhBZ3dMaEdyOEtXWGJjU2orYmIzdll0d05uRkd4eGlN?=
 =?utf-8?B?RjY1VnJLa0xOTEd3MmhEbzdxd3dnTEZwMktqcTY5aVdoU1l5cGRIZDIzbFBo?=
 =?utf-8?B?dmhPNDhSVUcxYU9Zc3QzaURiMG5qNVluUWhZSitrQjZLZ21nWEpwc3hJQWxx?=
 =?utf-8?B?NFVOR01SL2pCSHA5RUtXd0ZlZU5NZmhmN1RVbS95YlkzZGluZkwwakl1QWsx?=
 =?utf-8?B?K2FkcStmOUhwVHQ1QnE2UDdrbDZrSUc2R1lWOTFNOWNzUTZzN0VoRS91T2Vy?=
 =?utf-8?B?aUJ4UXZMQVYwUU03V1VKMlhjYmc0cVpwZElhY29scUxWdlNJQWRBTDVIL2lL?=
 =?utf-8?B?eFN6cjlUK2laMnZ6MnpxTUxEcFhmWEZ0NG1TK0dTMmsrN1RlZVBRS1pVK0xz?=
 =?utf-8?B?eHlmL05ZRnBjWXJEckRId01KMFdqTkVISlpNcGtzUTB6TXZqdVBmVCthYWdl?=
 =?utf-8?B?U2FkVXN1b3FNUU5mbDdQdzE1elhXb1RGNXREeDlHTy9TV1l5aVRxMmkxZTha?=
 =?utf-8?B?ZmF5QWdIVEFyRzIrZ3lyWTdpbEVlZzVJQTBFaEtZRS9vTlBJYlI5TWVGWDlK?=
 =?utf-8?B?N3hVMGdUSGlaeTBjaElGRFlrbUNxY1BIeXhHdi8zSUFkcStPTXhYTGZUei9S?=
 =?utf-8?B?SjRpMjQ1d1p6STVTWElVc2xydkZDcHh6Q1ZvT09OZTN2NmxRQ3NjaUNqZktU?=
 =?utf-8?B?TzJnNnF4SDEyUWloOFdrQWlyOC9zWkVSVS9HdmZZbFU0M2dDQ2hTdU96UVlv?=
 =?utf-8?B?YkJKKzQ4U2dCeTdaVE5CR0xwdVNCSjlJR0paYmZLT2RLaktTZnhQNmZGaDhW?=
 =?utf-8?B?SnNRMms2NFcvZCtVNGdHQ2RzeFVqY05BcTVpOWR0RWhvYmRLK3ZwSzhsb2xQ?=
 =?utf-8?B?TDB4T1ZsaWpRNXdGWU5PdVR5SFR6WHltSEZrVGdHa0ZjWEVqUGZrSlJnbFZ0?=
 =?utf-8?B?K28zZkJIMVZObUlva0sxM0MvR0pBNC9FbHpXQXRyN01Ydml1REt4VVAzVFVS?=
 =?utf-8?B?QmxSZzNJNDhiQlJKdVYxWk9XZFVmZ0ZoajFrbkRqL1BMSUMzVjl0bnA5SUxn?=
 =?utf-8?B?N0ZTc3ByUTlZd1F4WnVNZjc0WEhTek9xbnh4TUdIZGdUbU85d3Fic0N2cXkv?=
 =?utf-8?B?WHUxZzYwcUNPZVB5Z3ZzWTd2emJ6Qmo4ZGRDdWJjTkwzZE1hUGN4YUEzOThl?=
 =?utf-8?B?SEJhTTNUNkc1Nm1VVW11NzlERnFyeWhYSncwdkJOSlNXS3MvdytYcVFTTXlO?=
 =?utf-8?B?aTU3NWkzSXpkMXpEZG5DcVR3R09GMys1cWQrVGJCaFdHRzY4THAwczBzeVRi?=
 =?utf-8?B?SjZsM1E3Q2pJbHc4ZEdWUzRPM2haSlplZG9Nd0doQWVMTkIxaFpDZ0t2cVUv?=
 =?utf-8?B?UUpKOG1rbkp4MnhhenUxUDRUQXFZNFlMYTNwckVKaGFPdGI2MWhIVWxDbVox?=
 =?utf-8?B?Y2t3cG5tS3RPZ0RSdmdVTTJnZEVVallCcjVrdWNuNzlXU3VlNm1wZFJLTS80?=
 =?utf-8?B?djZvTDJURWpRYmFMcWFrYjBJUWtXZ2c2OGx3MWxMa1M1TDdGV1ZJZmtyQ21P?=
 =?utf-8?Q?1XCHBFRA4Uh2V?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZE82d1k3S3NWUkFnZXZWT3dqZXF2dzdUMVhZRHpCU1ZUUWdMOUNnRWhDRzdF?=
 =?utf-8?B?ZXpveFc4Y3BwSlVTU29tczdZNVVQajZLVm5kYTc5ZHAzRzI3aTdoaWlSRFl6?=
 =?utf-8?B?L2R0dm8zSFpZYlc2SGU2azYvaGFkU2NlNGQzdmlXc052T2RsdTJaTnMzZk5x?=
 =?utf-8?B?Tk1ON0RJeDMwbDhYa2FST1ZWZGhYenNPNlhOKy9SR1lWY21wWUlPVXJkV2R5?=
 =?utf-8?B?ZzRhVXkrcTZhZnowZDV5V2xId0RKUms1bEpOVnJiZWZsc3FDSERpYkZyV3kz?=
 =?utf-8?B?bGhWWFpyR2xaYTJlb2ZPcEw3Ti9EYmlmQmJYZXh5NnZvSlNqekQ3YmQwRlQ0?=
 =?utf-8?B?bmZMMjYrVHlHMWdJMVVEQWZrcDdDL0I3Mmh3RzF0OWRuWXYrT1o4VDNjYS9Z?=
 =?utf-8?B?dXA2WDJLZlFNUXdQVWpFT3lsOENLMFpEMTBxYm9sbEpaNGR6dGtUMlNqRDVM?=
 =?utf-8?B?UC8wNi96ekVWMHNnTzJ3ZjV0ZGFTWUpWWXJSUG4vUjM2MjZGalkxRXRhQ1l5?=
 =?utf-8?B?UjJWTmpucnpTSitjRDlwaGFGZHNZUFptRjQxMGZVcU9DVTVDU1F6UGlKN3hM?=
 =?utf-8?B?YVg1eTB1UnFLbnlmblgzaU82ODgxT1hNWHl6TzJGaUZwOHBSRHdkTFZ5SUVW?=
 =?utf-8?B?MnJCS3F1aHZRWnQzL3BFMjB0RFh0MVd0T3NGQXNJcW1mZ3VydC9kcFVLQjBV?=
 =?utf-8?B?R1lhMEh1UXhwQ3pmcy80S29XSnZPY2NQZXpGbFJuaWowdm1FVVZFcm1XSHR6?=
 =?utf-8?B?V3RYeEh4R2c4R1lTTGNBWmlIaUpjaWJSOGVMcTJRSlRaclE4aHU4cUV5QUow?=
 =?utf-8?B?VDlmZ1RjK3IxZmt4bGNXU2ZzZlhIbmpjeUhOR3o4MkhRL2s1UUFLYnpwKzFk?=
 =?utf-8?B?SkVrRE9CaE91eTdiaEczdklXaFRjMGhGRERlRnU4QUs0UEhmQ1pNT2RkdFdl?=
 =?utf-8?B?UTVQZE9FcERWQWJoVTYrRUswUm1sTjFFalF6WjVIZlZhVVlhbGlHNGd2Tmwv?=
 =?utf-8?B?TXM5dzNzVklZaUlXRVhRSXNoY1duMnllNkgwWnhkTzVjRU5vYlgwSmxnVTlq?=
 =?utf-8?B?b1lzOVVRTnBTeFR6NTBlQ3RTMGUwY2NQZ0c3bjZYVVhnMitXSmE0SStXeXZp?=
 =?utf-8?B?bU1Qdk9ST3pmVzNmbVpON0h5Ly9td1NKaXNvZGZJNWtLajNQYlpjMjdqVk5r?=
 =?utf-8?B?ZzZRQnIrYVVSYkUrSnJhWFQyVE5UUERqL3I0Q24rVU0vUHE0REo1NHRTTUVk?=
 =?utf-8?B?aG9RTVdqZTBwcHQydDdidU9VcFhpR1lESWJPRjgzUVkybisxV3E0b3VYaGpT?=
 =?utf-8?B?blV0cnpFSW9DejdJY0swNW1ocllVRW1UcEdIZzd5dmVJb3dSRWpiZyt0OWd2?=
 =?utf-8?B?SS9FVEltTW5IQXAvR2JiQVk1emhnZUZ4VlBlZVJwVEpyY2tnVFpUaWtkUmdU?=
 =?utf-8?B?UzgxSmRIUC9DeExSa3ZlNDVMdVlPbVN3SEQwUGZZeXMvUjlNTndZYWlNTG1P?=
 =?utf-8?B?K3J0UU1FN2NKZ0RlK1VVRURoZTAvOXg2S0NoY0JHZlpKc0c1ZFNiYjkwTGJD?=
 =?utf-8?B?TkltTVNxazl6MENMUXhHOUhxRUEvVFlYbkVXQ1EyNlFKS3JRSHpORXhkL1JW?=
 =?utf-8?B?c0pYTllvaDZhcWtnaHkvK0p4eVJNOEVKL1Q4NEdId1ppcjFwZTh0bkl0eWdp?=
 =?utf-8?B?U3R1L0tLTlA3T3NMc3E3aG1Dd0c3SFUxK0p2bE5mSG1CQUo0N0l5S2Y5SW1v?=
 =?utf-8?B?a3NTUGIzeEZ5QnM4K3QyOXdmUklSZDZHSU11cUJJYWtNUUxjVVNHeHd6ZXF1?=
 =?utf-8?B?NzVHQ0lka2ljTk1PMnowSHBLeUJWaGhzeVhHcG4vRHJDZHZheXlJd0JiUm56?=
 =?utf-8?B?bCtGckFZWmlDcDV5QmJ4emwwcDFEMkJDWmE5b2Y3V1VHV1dSNGlQbG9qUmQr?=
 =?utf-8?B?KzZIOXl4MjM5b1Zia2ZocldRRzgrb3dKNHd3eVA3dXBvb0ZRK25LWlNFUVhm?=
 =?utf-8?B?ZDljNzNBeitlMTM4MjVINUpkTlpneUExd1NtckJaUS9qL2N6VmNTYkpWajdh?=
 =?utf-8?B?ejRaMjJvck9EMTBJaDBlV3pROHNDV0UxZzJDbTRCZGhpT1dOU2hFMi8zSnls?=
 =?utf-8?B?akZsakNYNVdQU1ZMYVlLRDZHRzVQOE01eUsvSnZGRUpmaDZYOXNYZHFRbkZL?=
 =?utf-8?B?YWc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f0656650-e0ac-404c-6468-08dd654a936c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 11:55:13.4202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sRxCeFhNCrM4LyekZqYUYOconV+jzf5mWA3/J0ge4U8gcII6viimJS3sMBBvKlIxOnNVpwx2mYC/sXNCCRRmPmj0sgH52B6dghEHJDTWwaY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7590

Hi Robin,

On 3/13/25 6:31 PM, Robin Murphy wrote:
> Hi all,
> 
> I was expecting my DT probing change to flush out issues, and it seems
> some weaknesses in rockchip-iommu were the first to show. The first two
> patches here get things working again for me on my RK3399 NanoPC-T4
> (with a console on HDMI exercising the VOP MMU), the 3rd patch just
> finishes the cleanup since I was there and could test it.
> 
> Thanks,
> Robin.
> 
> Robin Murphy (3):
>    iommu/rockchip: Allocate per-device data sensibly
>    iommu/rockchip: Register in a sensible order
>    iommu/rockchip: Retire global dma_dev workaround
> 

Fixes the issue seen on next-20250314 on my RK3588 Tiger Haikou:

"""
[    2.007506] Unable to handle kernel NULL pointer dereference at 
virtual address 0000000000000298
[    2.017346] Mem abort info:
[    2.020465]   ESR = 0x0000000096000004
[    2.024654]   EC = 0x25: DABT (current EL), IL = 32 bits
[    2.030591]   SET = 0, FnV = 0
[    2.033999]   EA = 0, S1PTW = 0
[    2.037506]   FSC = 0x04: level 0 translation fault
[    2.042958] Data abort info:
[    2.046170]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[    2.052302]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[    2.057949]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[    2.063885] [0000000000000298] user address but active_mm is swapper
[    2.070989] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[    2.077994] Modules linked in:
[    2.081405] CPU: 7 UID: 0 PID: 1 Comm: swapper/0 Not tainted 
6.14.0-rc6-next-20250314-dirty #10
[    2.091132] Hardware name: Theobroma Systems RK3588-Q7 SoM on Haikou 
devkit (DT)
[    2.099397] pstate: 00400009 (nzcv daif +PAN -UAO -TCO -DIT -SSBS 
BTYPE=--)
[    2.107179] pc : devm_kmalloc+0x28/0x100
[    2.111568] lr : rk_iommu_of_xlate+0x30/0x90
[    2.116341] sp : ffff800081d0b840
[    2.120040] x29: ffff800081d0b840 x28: 0000000000000000 x27: 
ffff8000815d3e20
[    2.128010] x26: 0000000000000001 x25: ffff8000815d4ed8 x24: 
ffff0001f08e1f60
[    2.135989] x23: 0000000000000000 x22: ffff8000811b3f58 x21: 
0000000000000000
[    2.143966] x20: 0000000000000010 x19: 0000000000000000 x18: 
00000000ffffffff
[    2.151944] x17: ffff0001f14acc00 x16: ffff0001f14aca00 x15: 
ffff0001f148b27c
[    2.159922] x14: ffff800081d0b820 x13: ffff0001f148ba1c x12: 
0101010101010101
[    2.167899] x11: 7f7f7f7f7f7f7f7f x10: 00000000000a2cc8 x9 : 
0000000000000003
[    2.175877] x8 : ffff0001f08e3540 x7 : 0000000000000000 x6 : 
1d150c11f5f38080
[    2.183855] x5 : ffff0001f0278000 x4 : 0000000000000000 x3 : 
ffff800081a77218
[    2.191832] x2 : 0000000000000dc0 x1 : 0000000000000010 x0 : 
0000000000000090
[    2.199812] Call trace:
[    2.202538]  devm_kmalloc+0x28/0x100 (P)
[    2.206924]  rk_iommu_of_xlate+0x30/0x90
[    2.211307]  of_iommu_xlate+0x94/0xc0
[    2.215400]  of_iommu_configure+0x1cc/0x250
[    2.220075]  of_dma_configure_id+0x144/0x24c
[    2.224848]  platform_dma_configure+0x8c/0xb4
[    2.229716]  __iommu_probe_device+0x2e4/0x4a0
[    2.234583]  probe_iommu_group+0x3c/0x68
[    2.238965]  bus_for_each_dev+0x7c/0xe0
[    2.243244]  iommu_device_register+0xd8/0x228
[    2.248111]  rk_iommu_probe+0x204/0x360
[    2.252397]  platform_probe+0x68/0xdc
[    2.256488]  really_probe+0xbc/0x2c0
[    2.260484]  __driver_probe_device+0x78/0x120
[    2.265355]  driver_probe_device+0x3c/0x154
[    2.270032]  __driver_attach+0x90/0x1a0
[    2.274315]  bus_for_each_dev+0x7c/0xe0
[    2.278602]  driver_attach+0x24/0x30
[    2.282599]  bus_add_driver+0xe4/0x208
[    2.286781]  driver_register+0x68/0x130
[    2.291065]  __platform_driver_register+0x24/0x30
[    2.296322]  rk_iommu_driver_init+0x1c/0x28
[    2.300997]  do_one_initcall+0x60/0x1d4
[    2.305283]  kernel_init_freeable+0x210/0x274
[    2.310153]  kernel_init+0x20/0x140
[    2.314051]  ret_from_fork+0x10/0x20
[    2.318048] Code: a90153f3 b1020020 f9001bf7 aa0103f4 (b9429ab7)
[    2.324857] ---[ end trace 0000000000000000 ]---
[    2.330029] Kernel panic - not syncing: Attempted to kill init! 
exitcode=0x0000000b
[    2.338587] SMP: stopping secondary CPUs
[    2.342971] Kernel Offset: disabled
[    2.346862] CPU features: 0x0c00,000000e0,01202650,8200720b
[    2.353089] Memory Limit: none
[    2.356499] ---[ end Kernel panic - not syncing: Attempted to kill 
init! exitcode=0x0000000b ]---
"""

Therefore:

Tested-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
