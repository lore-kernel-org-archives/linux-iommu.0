Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012054.outbound.protection.outlook.com [52.103.66.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944253CD8C3
	for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 11:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774437821; cv=fail; b=LapDYJshdlW7rv9l2wxTsHtA2BBAMUBpu156tduM4yG+8c7LW/vhu+pBVe4nGsSesIgwKXbkn+YtJV2MzAvEDcR0vEcYTONfVLK32sqyGkft8AKm2J0zNAId4wj8NNgc6Pyk2+wOZwalDjqa6kjtmIQJsrIzpKxYBdE2/E2gTLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774437821; c=relaxed/simple;
	bh=8pWh6PaCF+ff04hYu2wQKkVKCqMzIM2htQm4HWipWBg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iOuc7+dhx8nxW5BiO62OPKCFE5/38+FHyoXCA4pfDLp3MESV0X2HzAtRrEaNVDU50B9zxAK8Tkwu27wzx0JYoLy+ZJlEqO9/Mk9geE2tQhzdTC9PgjLILgfNmJW2SDKMOe8J8QOU2lpqJnlnOeBvL0owSfQPzr9WDulpLBXJiMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=nIjKFZ0s; arc=fail smtp.client-ip=52.103.66.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="nIjKFZ0s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tf4NhRRvIE7upd6AK9YoJvaPWgsr+Hf6kDKyAs0vCnb7vTmWfgU7qoYEIAPdtAKs+TiWmyLMkEKGb9sozd7esGxfM6cc+iJCE5chcPkm09HOXGMWHrKE0DXfqZ0PJec/7VxfKRj/ZdO4PlpwkOhymwGirJJVgmUJg0egt4/d+F09oS1DvM6ifOMsC18IIDsRpWTZnaApD4pJigKRfjVXhwtMGb4KSg1cu+kh1rrsoIEXyTeSr3mn3Z5koQfiRhhitUq5hh2cff05Gyogc9VjZNSyzlRP6zrCFth5aF3fB2eHD9VU8lnDy4yoH6XyJtIoWW3JOdV2Vs2oc8BWXmDffw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afQaSxBWAcXIAMO81hZFct9mDl1q2TjtY+/c1sYtmeM=;
 b=fQKJtC/cdCXCIni/LkKBDqRzGix6JZPsZB2ocadHm/kA+HJWeg+Rp5JYNtrYwnaROSVnXkTw7PmIOrbImD/IeMU9I7CK9LVJBM0fS+J+OEXcj3Wjo2Qkhofd4ayaVhg8yzjHAuBCFqk6rMVZI2NIJh4+p2KZzD7OFw5ZwQ4YYiAAlW2BZ6leK/rgdZDZ5/arJCgbDCdKTvtOTP7HRa5CituQ8W3SJsFgp/xbyYUFHxqHDD8Gxop5a5u5c1iq+k+xLZk/uyOAiCjHp/DUwje/+NLVrYfDnqF0imr5JdG22VGSEWY9xJHBlwiMfEjfF0wLXsjRBAVe4Yy4JbX9EQJhfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afQaSxBWAcXIAMO81hZFct9mDl1q2TjtY+/c1sYtmeM=;
 b=nIjKFZ0sle4q5qMe1Fo8cdqRaKdYmkgdxurC1+tOvYzFpmOWaQ/GykFukHoo3SxJb6yq/2DpDwb6yLbgTuy0YKdxBtrBI+QHZV417sKlsQSt4DYmy+N7NJr8Ypg7J/VFW2zUCLKqunoe0FvP+1V7EI8c2xAOcFKYbdnDtBEdFBQNo0syCHFdzopgm30qERMzGilR2j+e7noXySGdq8TgIqx/sqnY2zAQogIk4aiF7PAObaYAysk4PEJCmylOyrciDxqtf3cYEmSfxLc11NGtkQutXKO0n1vQTi45YnY/dfqGnlVXYCMCnUzUmgiVczLEtkjaPpiWyT+F3irwx/Ghag==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SEZPR01MB4456.apcprd01.prod.exchangelabs.com
 (2603:1096:101:73::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 11:23:35 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 11:23:35 +0000
Message-ID:
 <SI2PR01MB439392D470CAB8EAB472839EDC49A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Date: Wed, 25 Mar 2026 19:23:29 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] iommu/amd: Recognize Hygon southbridge IOAPIC for
 interrupt remapping
To: Pu Wen <pu_wen@foxmail.com>, joro@8bytes.org,
 suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
 vasant.hegde@amd.com, aik@amd.com, jgg@nvidia.com, kevin.tian@intel.com,
 xuyongwei@open-hieco.net
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <SI2PR01MB43930F54C5B058A26D768C5FDC49A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <tencent_EA83212045B49C785F5B55047CD670E8FB0A@qq.com>
Content-Language: en-US
From: Wei Wang <wei.w.wang@hotmail.com>
In-Reply-To: <tencent_EA83212045B49C785F5B55047CD670E8FB0A@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0053.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:3::8)
 To SI2PR01MB4393.apcprd01.prod.exchangelabs.com (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <7d297235-97f6-42dd-8cf0-7d487d1df18a@hotmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SEZPR01MB4456:EE_
X-MS-Office365-Filtering-Correlation-Id: a5d27012-ebbd-46bf-23f9-08de8a60f402
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|37011999003|6090799003|23021999003|15080799012|5072599009|461199028|12121999013|8060799015|7042599007|51005399006|19110799012|440099028|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M24zR2p0bUV2UHN6S243c3VSZVp1dFFob2lrdkZPUGFnVmFhVlcxMkZLRHIr?=
 =?utf-8?B?UVI1bG92cThTS2RKekUyUmZjRVliVFRRbmdzOXF5ZklNVWxDMFc3UVRXYW9L?=
 =?utf-8?B?YkhTTm9SZHFUcVlCUEdlYmQ1aG9HbTFnQWg0MVhQRWpGejhaVzhkeFdUVy9M?=
 =?utf-8?B?VENrQ0s0VFhVcDV0U1MxWTBCaFBUUU1qTm5lZDZyUHkvNFlVNlVPcmJXbU1l?=
 =?utf-8?B?ZUptcFdvMCtBOC9hN3RHcmtJdW8wS1N4SGtDRm0zaUxPOS9hRHZHLzI0dWRn?=
 =?utf-8?B?eWFnNVZuYlN1bWxKVVRlNTBwK1NoaCt3SndiWkd6RDFvZCtBbjBncnFtODJI?=
 =?utf-8?B?UXpmVHZGV21EYzd6ZEVldmlFNkdmNkFkKzN6RTNUWGtJV3FzY1EzSi9EVGNr?=
 =?utf-8?B?azZhMWJRMUFDWmhBN1AyVlVnSldpc3ZxcWpsSTJWejgremhkbEtnMWRFTHRE?=
 =?utf-8?B?STliTXZVRDRGemsxaXBYOGRrbm9pQk91cXBEZlQ2cHNCeGQ5T1N0OXhiK2Jr?=
 =?utf-8?B?WnBhWlVPOHpnc0lKVHpZdS82VGYwak5peXRSZE03RFhvTmpGc3kwSTVOUldK?=
 =?utf-8?B?WVd4OVVWb2tCaHh3V0NNOFRJMmpxNTZFU1NyaStETUYvZzV3bzgvZ0hHU2pm?=
 =?utf-8?B?ckZlbitIRzRRTHJzbWN3dzdZSTlCWWd6UGtDeFcyNmtNWTBZU09VS3VOQ3FX?=
 =?utf-8?B?Z0xieVBCbnYzaUgwZ1pKV1NFQ2dTcFFVcHdZOEZBMFdvVHY0d2VuajUrbnNa?=
 =?utf-8?B?eFRZNk9Zc3NmYmZ6WHFQelZpNWdXRlV0L2hXdUcySG8weDBYdTdTbWRVN0tv?=
 =?utf-8?B?VFU1bFFNdC83UDZTWllWcmJWUDR1VFZMUTVmSHdNcjM5bC9jbmdQY2RSWm9j?=
 =?utf-8?B?eHdMeEJuQ2lveGgyaGwvazg4dVp0NWNWTUxVaW9NVjN0VWtRVXRYRUUxcm1C?=
 =?utf-8?B?S1hqNzkzN1IyNTV5SFcrK2VHN1VLNC9zSDc1VllKR1lTVkE5cmI5M3A3SG8v?=
 =?utf-8?B?aG41OFBLZ2tQVXE4UEt6dWlLaVdldStRUWF2aU0zUk53MXZ5RWp5d2RldkFF?=
 =?utf-8?B?NUNuSWloNFQ2aGhXME1pbEdBT0Y4V1NMRC9yTFExdEtSYXErallDUnl5eTNT?=
 =?utf-8?B?WWFDZUlkM0Vaa2h0dEh5bWJRR1lGeUpZRDUvb1pvTXhvdFd2UFNSZ3VkcmhX?=
 =?utf-8?B?WFhncnFoNVJQY29rNXBkVzBPK3g2cTllWTZCYUZ6cFZKRCtZbUhxSEFPbkY2?=
 =?utf-8?B?ZFVFRU05dEpWNW44bUNsZEYxNkw5S0tPNHVhME1zaXVCcndVUFF6UG0yMXlH?=
 =?utf-8?B?a2UzcFFtc0Y1WVZXaU1JUThTZ1N3T3Y5d2VBRG1Kam1BRHgwSXlxNTJ4RVd5?=
 =?utf-8?B?eDBqVy9DUVI0T0E9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UkN3bUd0QXpnYWI4UC9naHZoQnJwVGlDOGExQlM4RUVrbnpFNEFSNFB5czQ2?=
 =?utf-8?B?ZWxGT3IyNks5Wjc4U0wrbVdKcm8vUHBEQS9YM0ZpcDhidXhYOHg4TzFGemdS?=
 =?utf-8?B?VXE1bEgxUU9FN2FrMU1pdUFQaXlMR1ZTb1F4TXR6NllJS3BFenZaQnhBcU1W?=
 =?utf-8?B?SjFiYUUrcnVQcW9MY1Q3aHBqVlRpWVV6OHNueU0vcnRtNmZLUDFRM25kT2lj?=
 =?utf-8?B?ODkvTVNuUlBaQU1uQmhFTHFZV25tdGwraW5kbHlScW1IU3ZQbUpkWDNUVjNi?=
 =?utf-8?B?WTNQUUFLbkpTb0h6dFVxb0dNOE83R0wxYU81V0pYaUtRV01Dd3lCNnRleFpG?=
 =?utf-8?B?VXBDb0hSK2sycmE1a1hNUVNxMVdiZlZlTlV0a0piK1FIUjhSTUNwdnBBNzhp?=
 =?utf-8?B?WTBDZ3JEdWJjMmsxMlhJL1BEcGVGQ3ZlbmF5MGhwVEIxN1dTREhmS0tNd2NM?=
 =?utf-8?B?SDBmUEpBTUhmYTgyemUwZG5FUllFb3g2dXV2bGNWbjBRNW01L3NMRGFtQ2RC?=
 =?utf-8?B?RTMyV2Z5N05wNGd2Wml2Nld6bjA0ZERuTGNBRlhqYjlYRUdhY2x0OUQyTHdL?=
 =?utf-8?B?b3Ric2xxVWdXWUc3dWZlbU1NdHBSRjNTY1lEOUJaMGxPZzlsdkY4NFhIZG95?=
 =?utf-8?B?dDJKZ0wvRlVkTEo0aGJWdU1zaGVUN0diQmh6aklOOUhTb2plUHpyTFF3STN3?=
 =?utf-8?B?YkxyRUlWSzhnQXFycDJkc2hGNEZRZitQZCtOZUxZS29IUkFSbVdGd0psbkdz?=
 =?utf-8?B?V3ZHdHlHN0VKMVBBV2NWV3MrM0JZRmlwZWNMSndOdm9yVURWd0hFcWpoaWk2?=
 =?utf-8?B?SGJHTjBtcHlxOGpUTE40ZzNkNC8xT3llV3p6K3FML1ozR3BENlFvWUtOZ3VC?=
 =?utf-8?B?amJ3bW5QcmJwRElUNXF6U2pzOXBiV0owNndQTWZ4bC8zbnIrdzM1bVBUQ0tI?=
 =?utf-8?B?djVnN3RtUDJzZnozN3ZpYm4rTzd1TzBqbUphRDVQZlowZjhsNFIzaWJYZVNY?=
 =?utf-8?B?RE4wNkpFMHdSWlhyYnN4Q1UvNTdmalBMMXZsSkpsUWhTZ216dEh3dVRRczRR?=
 =?utf-8?B?MG9BUXNNdjhCMnZCRFJwU0NLLzg3LzJCZWQ5S3M0RFo1eXBUWFp0TkJPU25E?=
 =?utf-8?B?SXZkc0JGT3ZOdnVEVXMyN245N296QnVzdlY1NkNKTVpMbUtrMjhDSEZUcTF4?=
 =?utf-8?B?TXJOd1UvWGgzQ0dPWVJsZldONUVPdVQrS3VYTUMrZ280L2tYd2RpdjVodzFK?=
 =?utf-8?B?Vmw3ekJHUjBtblY5S1JVQ1lHaVVrd0NkT3NiejVvdm5UVVdNQ3JvVWg2RGVB?=
 =?utf-8?B?Q2R1cGZVcmdBeGg0SzJ2bTc5eVpqQUFRNEhTQ3JqbFY3Qm9QTXlndHdiMmtQ?=
 =?utf-8?B?S01OSVJzTFRmUjQwTXNaYWdFMzNQdlhGMXhJdVBMM0c0RTY0VnZ6MkJPQVpP?=
 =?utf-8?B?OWhITXN2dmhmb0tDeWdQUXBRMEFXRWM5YUZ3QzAzTWhOK3ROc2RGUThsS0FV?=
 =?utf-8?B?R0JUMXR4S21lUU5KUkFoTDhZSzUxTTc2U0xZb1RnNFg1UERpVmhYamF1V28z?=
 =?utf-8?B?R2pENnNqUy9NOXd1TnBZckNkRGozVTlqUXpxT0NFd3dGalNQaStIejhjeU9P?=
 =?utf-8?B?QndVMGJyU2YxdXZBZ01ET3FuSVFoRUZKTDZhTXpmYUJEZFB5Mk5XWlZ0Z2pC?=
 =?utf-8?B?Q0ZvcmlTd1ZvTmY4ZXpXMEFNc1FDNno3dXBDSUVjRkJTa2o5K1pTUnRGZGtB?=
 =?utf-8?B?STQ1bVFwSGM4RXgrYVlFR3JCTERqeHc5bjlJZi82Y3JwTytSSU1jcXlOTkxE?=
 =?utf-8?B?aVR0UUgxQk5scHM3Qm04eEMraTd3cWwzaUNtSWhyY3VMRnBid3VnclcyOU9k?=
 =?utf-8?Q?ldmRCVQJ41Ob2?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a5d27012-ebbd-46bf-23f9-08de8a60f402
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 11:23:35.8109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB4456

On 3/25/26 6:54 PM, Pu Wen wrote:
> On 2026/3/25 17:39, Wei Wang wrote:
>> Hygon systems use the AMD IOMMU driver but newer Hygon platforms report
>> the southbridge IOAPIC at a different PCI device (00:0b.0), whereas AMD
>> systems use device 00:14.0.
> ......
>> +/* SB IOAPIC device IDs */
>> +#define IOAPIC_SB_DEVID_AMD    ((0x00 << 8) | PCI_DEVFN(0x14, 0))
>> +#define IOAPIC_SB_DEVID_HYGON    ((0x00 << 8) | PCI_DEVFN(0x0b, 0))
> These macro definitions is not accurate, old Hygon processor also use
> device 0x14, as you mentioned device 0xb is only for 'newer Hygon 
> platforms'.
>

Yes, I noticed that. I mentioned this in the commit log:

Older Hygon systems still use the original AMD device ID (00:14.0) while
newer systems use 00:0b.0, so a strict CPU vendor check is insufficient.

That is also why the code uses the logical OR:
if (devid == IOAPIC_SB_DEVID_AMD || devid == IOAPIC_SB_DEVID_HYGON)

