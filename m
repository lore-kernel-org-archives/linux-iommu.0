Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2055.outbound.protection.outlook.com [40.107.95.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E564C78F51
	for <iommu@lists.linux.dev>; Wed, 12 Mar 2025 03:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741750676; cv=fail; b=b2k/q5GT124weyhwWekO6u5r01cgXdaxSTdIWa6TCypHZ1i6nxRIUN9BpZHCbrC9bHRxLGEB/wPaFZShDwzQf8L7iz5qGilXXlpXbc8eF5KeqKgAvEhN13rToVsPeqbbemGjU3U08PBgBrwcviEEO07z00JJ01v3qOlBwM5tkCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741750676; c=relaxed/simple;
	bh=0lKI/TMQawgS7vqh7DfTFfLmo1VLUE+ZZrpwcBRAtao=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=EYPXWJL8qDYr5Zx35yltJ8rOR29xWHvERy84i0J7Vs1pNkD6lDiCI7d4zhlms5j8/gWa/56vGw9QcvX1ZiIc7q8SnPb/xTfBg/COtL+oACfDRdu0rFre6kNsa20VGTHp6f19U7q2jDXoW9nATVRimk/r5C4piLWZ626FN3F8RnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CL1KovJx; arc=fail smtp.client-ip=40.107.95.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CL1KovJx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h13bEGMU1Ti9Yc7ShxMZC+4bXhl/ZdGdq6v/VdFFvXwsv6SZMq6NOoU6BL+m7tHTlaTCIqXCjOdt+BavIuwIrSujsuxUe8Ei6HYIdkM+6/EWcyJDk2aLDZKCaEIW03ekjv1+VOJVTGcMyd6IP1KPVyw6yhVLbK9/FO2MuaOS5tjYYdCaVnSV8JUOPI6yVSpZ8fWw2uiKd0XSx0wbrp7z+XuIL6iJS+qLfcV/fuxgzdiy51J7TkIdKjg6ZINf3qXQ8hIFnk10HdW6FYmTpXFkG1GOLGYAXOSViD7wH+80m+WnoELQOIonHUouyt/etKfXdmz0620FUQ/AmLyLiBB34g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sTVoErwEIaDzHZ5VHsSI2uxwTeQnSRW0a1yIoOwZKmw=;
 b=Dgv4tuasINu2necKwJrxv+5nWn4Y3RAcYsdLEtDrWREwEcRtUSzUc2uKlvk7cdRc4QJCJp/jYy6K1xhvXTHiskbR7NLDuvXYGwEUKHTkgDNm3Z9x2Ewof0FYBIQb9DWV4yoiNoDohaW0/a+SmohILRSGSOgUlsrcGoPPwR5Y5VYSmrro4tSVkeeNv/fmfSeQ6lOJ9P36MnMs4TlEPy1hRTRX8nJ0TM4JMtK7zp+1ATNaQzTyLYLspo6Q+h/6fFmQzsvGd4QB81m1/OL1x+YVU0IxYGyVRHpcQKG7tF/0Q5ivKdBcL8GxAJpAWOyobrBRP+4wd5PiHuS9edbgKnJZpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTVoErwEIaDzHZ5VHsSI2uxwTeQnSRW0a1yIoOwZKmw=;
 b=CL1KovJxyymRCYUp+LQMpajMyFYDJfy5PWXQytBm7kARSxSOSBL8ux3Gcp+OyW0qnqA/FqulI0IC7hYmjkQQNs+lQQnUVrIJvPMgOySuqB4Q4ujAzgGtzCFAAexbU2ThyBD0fBe1405aENattAApd5Zys0suJaTQeyQMTuu4nqronf8C+CpRPdOu4TyX8otlVOoy23aHOxnDmUTasCwbT14PX2jx9ucEF0mPDS4FRTWKiyha9W12PEGOGOWKGUVHF9MS5V1cCyr0mq1TBK5zzJahiDoMBJpBSnHS8E+opWT+Jh2OQIfoufPEgdP6FeHHsXVe+QjtFI4/ZMZ6SbHT6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3997.namprd12.prod.outlook.com (2603:10b6:208:161::11)
 by MW4PR12MB5642.namprd12.prod.outlook.com (2603:10b6:303:187::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 03:37:50 +0000
Received: from MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::d161:329:fdd3:e316]) by MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::d161:329:fdd3:e316%6]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 03:37:50 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Mar 2025 12:37:45 +0900
Message-Id: <D8DZ2XP3AI2Z.76W9FKGRNM92@nvidia.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <benno.lossin@proton.me>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor Gross"
 <tmgross@umich.edu>, "Valentin Obst" <kernel@valentinobst.de>, "open list"
 <linux-kernel@vger.kernel.org>, "Christoph Hellwig" <hch@lst.de>, "Marek
 Szyprowski" <m.szyprowski@samsung.com>, <airlied@redhat.com>, "open
 list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Subject: Re: [PATCH v14 06/11] rust: dma: add dma addressing capabilities
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Abdiel Janulgue" <abdiel.janulgue@gmail.com>,
 <rust-for-linux@vger.kernel.org>, <daniel.almeida@collabora.com>,
 <dakr@kernel.org>, <robin.murphy@arm.com>, <aliceryhl@google.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250311174930.2348813-1-abdiel.janulgue@gmail.com>
 <20250311174930.2348813-7-abdiel.janulgue@gmail.com>
In-Reply-To: <20250311174930.2348813-7-abdiel.janulgue@gmail.com>
X-ClientProxiedBy: TYAPR01CA0161.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::29) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3997:EE_|MW4PR12MB5642:EE_
X-MS-Office365-Filtering-Correlation-Id: a3707ec2-5376-4661-fa31-08dd61174339
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NFhHdDhuNmxJdEZRbE1LVHE1TUlDR0Vybjk4dlVkSmxxUFpSV3hzYzdrSVFu?=
 =?utf-8?B?bTFKcGdsRXBHZi9oQ01HVVA4ZHJtc3cxZ2I5NHZjeTNXd0xIaDBtdkhUcmNK?=
 =?utf-8?B?a1lqMk84bVhMVUt1dHZoSW9VaXBsZ2lwVnpIenVKRFJ3SlNKcmpobVZzMXJp?=
 =?utf-8?B?azh1RDIyTjJ2ODM0OFVNdU9zelpUMjM0M1NsT3NxTEdabUhJRi9xZXhCbHpw?=
 =?utf-8?B?VDVjcnZFRmhYTUFuSGhYMUpKQ2I1cThVZWdVMjNCS0xuODlETFJxTHBac1ZL?=
 =?utf-8?B?M3pucENiakN1WXZKVi9LQ016eU5lR2p3cXhOMzZSYkVyaEp6cFFoR292bGtk?=
 =?utf-8?B?U1JTZk0wY2Q4ODJNM20vdDhJM0JDVUh0bGY2TitZMU1ET3gwakVmYVNtZm10?=
 =?utf-8?B?czkyVzNla2tzMVRsdjNQdGorTWgrbzM4U3NzRCtXditpK3BGNGRtRXdYUHkv?=
 =?utf-8?B?WXduK0JvSkljU2h1S0RFdnNGWCtZZ1BqZkI5Y3l0aGFJZHIvMXg5d2FOL3A5?=
 =?utf-8?B?UUZpRzFZSy9tWURKYTFqaldQV0YwZEhzeWhTeWJXY0dkdVZIbzhKRitCTlZJ?=
 =?utf-8?B?anlzQmE1eHNLWUoxUjhOU0hudjMvQkZzRFpid3ZrVVpDZ0hRUlZsb1orditQ?=
 =?utf-8?B?Y0FzTDUxS2doNGFyNHB0aWIrUERySk1KUkkveWd4VlNnQkF0d3BCM0pTZTdO?=
 =?utf-8?B?aXI2bDRMNk8xWWF1dlhTRVBMWm9mNENuV1VCVW4wbFJCdmJ2NXZhUDlSUVBi?=
 =?utf-8?B?QVdOTUtMdTdGcU00WDNLZm9WRmoxU2RXZ3VEbjdOeExMVWpWc01SS01pVFA4?=
 =?utf-8?B?UE9LVlJJSkxzMC9hKytVQ0RKMXgxN0ZjaGlzUldvbWdNYXd1RjZnWlBCY244?=
 =?utf-8?B?eWxBZmY5V1hPYjZ5TXZpRjk2aWpRbWNROVhMd0g3b0pHUUFyWUlYbG02aDNn?=
 =?utf-8?B?OWRvWDlOL3MzRlcxdThUeDNRV254Q1N1dlAreFlmMzlDNjlFVFVOeENlMUx6?=
 =?utf-8?B?Z3RaUSthYTV5eHp0NlFMZzJMMkxFam9ObkJYaVVIb2VpWmVlbE1HS3BhVnpj?=
 =?utf-8?B?Rk1PZ1dMelNiNmtDTGR3WDFFTXM5MkpJMTdrRzh3VzdWTU55VTRBRk00bFZK?=
 =?utf-8?B?SUQ2KzliUkNjd29lMVpHNjRNN0hHWElMUWFvN3JaeFZqOVBieUl6bndHaDNU?=
 =?utf-8?B?VVp5YUIveTB4eGk5cmQ3WG1yWFBnczJjMjJOSXRoVFVDY01aV3o4ak5vRnE3?=
 =?utf-8?B?WjJMK3RNYUZkcGsvZjFuVjBHUW91K2lWK3NlTlBHQ2RyVVlKYnYveXA0M1Na?=
 =?utf-8?B?M1l1eEIxbnhyVytMckI0TUhtY3NUa250WEIvSUR4VUhxZ2xpT0E3cEQvMVZK?=
 =?utf-8?B?S2dPRmRQWFZFRmdPeHI4UlY5Zm1abVltWElCczlHTGpYRTE3czc3STIyRlox?=
 =?utf-8?B?MGx5OVd4K0Zua21YRjZjQUpRNlQyeFlhWmRvSTJyK0NwbXQrbTFYNGZnY3RU?=
 =?utf-8?B?NFdQeURIK1BUbjM5YzdCcHBhYzNjU0ZzTDc2Ym4rKzhLaDVDbDl4NWREZU1U?=
 =?utf-8?B?VzRPVms1bEFaUTJZM2RsR3Robi9LYi9QRVZYRGlqYjNzSzFPU2luME9jSjQr?=
 =?utf-8?B?TEFVNmRBMjF3TmsxTm5PdkNVeDIzYzZzR0dnSk5LVC8zMVdhYTR3RnJ4RUt3?=
 =?utf-8?B?WGpxZVBsZGZhbkNKQkcrOFRkSmxrY1c0N1pvL0VvVUhGVjhZT2hQcmVCZ0dC?=
 =?utf-8?B?Y29oQVl4eGFMUTBuYmpROFN2ZkdocnFvU2M1SlBRczBxK0JiUmZvN1VzdThQ?=
 =?utf-8?B?TkNNSm5BT0oyWFJqTmZqaDBxWUpob3dPUkN6bkZQL0pka0NBZWFPUVEyRlB2?=
 =?utf-8?Q?0MqUsTknJmJop?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3997.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHU3SzZwQ0trMXBuSERRRkF3T3BhVU83akNJNk5NU1NPYVgxTUhtM2ZtVWdt?=
 =?utf-8?B?enRrbDZDVWtCcDZtbTZpZm9zT09iMWk0Y0Vic1cxSml3TnFaS3hqSDBsOXdr?=
 =?utf-8?B?d0s0Zy90cnZ5WWRmRTNoU1MxUlFYNjdId003NXAvZ29GM2hOMFpBdFFkOS9t?=
 =?utf-8?B?cWJnZlBjeWxFUkN3cHNGUHNFby9KeFhvOFZqbkl3OG5aUCtSVk9SNHcvWnNm?=
 =?utf-8?B?WVg4K241aE1QQTRwa25TK3dYMWQwdlBYdEZpNXd3NkkzcFFTS2lVTUg2Rkd5?=
 =?utf-8?B?TWlubFlCczJMY2J1Y0lxZ3VCamRzSG1YWkIxZWRtZ201QWRVVE1senQrVGZT?=
 =?utf-8?B?bnp1MGFuUDliMFZjUS9yWk5hdnJqQTJpKzV1RjVBVXJNZUJoRzZpY2RRT3FQ?=
 =?utf-8?B?ODY4eTBmZ1NFZFRvZDhObE93OVhBeFB0dVd3Q3RGdG9zWXJKNmdyS1p1elR3?=
 =?utf-8?B?QnRRcXVGNWJENWdsWkYyUWRvTlUvdWlWSmV1dmVwVEVKRHF0bHhBcEFlSUIw?=
 =?utf-8?B?QjJYTTVZRy9GMGZaK201OG83S3BVQ1pHNkVucXh3STBRMHFuSmt3MmYxOG9V?=
 =?utf-8?B?d2JiQUJ4S0pNNTV1VTI4OVJiQlBRaE5PS25oVG1RbEpJdGpmQS9XNUU1USsx?=
 =?utf-8?B?Z1ZRWFJabUtTdmd3VktuZjBXRFNnTFJHS0tMNmVwWksxbWlOb1B0cEE2UjQ2?=
 =?utf-8?B?YUFWSGp3TkRwcERBUllnd1NSeE44M1FXL2RRTkxJYWRLZzQ4SHg5YWFsRWZ4?=
 =?utf-8?B?UVNLNHhhUDFqTzJ5UldtNXRxdVY2cGlKb3N3eGsxOHNKTVJObVlpbDYrRjE1?=
 =?utf-8?B?VGViS283Q0tMcWlITTNVVTgxZjk2WFNnMXM1bVNzUmpDNUdqOU1uM2xvclVN?=
 =?utf-8?B?bnVPUG82cnUxNGlMcFV0dll4a1V5QUtqWlNQOHQvUmdubG16YWJ6OVRjZmV2?=
 =?utf-8?B?TXFjemttK3I4WTBldGpncjZDNDF6aTVGS1FEdHNUQmhZRnd4STNpQk93SGNP?=
 =?utf-8?B?VjhnVFVwdkZhVDNsYi8zTGtJdjhYemJUNDBNTHF3RVkxR29yYkZPN1AvVWwv?=
 =?utf-8?B?MXFEaEtvYUREMlYzazZSYTRJWk5TZTNWUUZYK2duSXN4MnVieWpzVWNzbVFT?=
 =?utf-8?B?VFl4Y1Q2TlZWT21OMS9MRDNDZEdoMS9Bck80U1dYM0ZEandpQVdEU3p2SFlh?=
 =?utf-8?B?cFQrYlpqOEplNzg0bFlKVVFXczcvbmtSS2dMTzdpczhYUEthWFdoMzBaZjRw?=
 =?utf-8?B?c1UxV3FETVZMTUNoT1BmN3h2WWJrR1RRb2ZiTWcyUUM1NDhnaEZjOWJFUlRz?=
 =?utf-8?B?RzRXUlFwNC8zSnRFN29mUGE3S3RVNlBaUUN2ME9kcHo1cHVoYnFKMVdLNitP?=
 =?utf-8?B?ZU11aExvWmtrRmFrT3RVQmhTRG1McytaVUZGc0dCRHJjWkhaVVZkcHBGRDJo?=
 =?utf-8?B?TzA4d2pYZ09MdWwxNkJNRExGY2tIUUdxcTZ3NEVxb20wazRQVXpvWWpaaU9i?=
 =?utf-8?B?MVFzSHNrYVZpSnhVKzR4cUIxK2lwSGErMngrTDNJTTRJa2QwSHVtbnh0L0Rw?=
 =?utf-8?B?ako4S2lMNWpFZGZWeXloZEdTeFpRYmxkK2V1K0UyY3A1T3FqTk9SOHFSRVdP?=
 =?utf-8?B?RW5NTGh2bmZmc28xeElGbkdpcy9nWlRLckd5OEdKQ2laRXVSTmFETTl1SmNi?=
 =?utf-8?B?ckpJa3NyYTZ3NFFjbmxoZ04zdThMUU5vb0M5dWwxL3RjekRSM3YzY3R2RTIw?=
 =?utf-8?B?dzRVZEYxdm5BODZIajAvRFByVTM4NVZpZmQySEhHdk1zTFhmWG1GOXdNTmV6?=
 =?utf-8?B?T1VWN0dlVzVBVnNuVHdUTHU0TnNMTjNnRk9VSTZyODdoYzFGZkl2anNGeDN3?=
 =?utf-8?B?RTdlZ2J6a0c4M3d4S25ibHkrMWluTHgvSmlySnM3QUcyNzZEUHVnbkFiS1Ev?=
 =?utf-8?B?MW55d2dOaEg1QzByQ1JuMk8zaktmMWpoYlhCbmtsRUJqc09ZK3laZFBnZ3FF?=
 =?utf-8?B?TUdTSFM4UWtEaGZ6OW1Rb1FueWtaSzFxS3JIQ2FQNUxqb2lHamx2N2dkT0ZL?=
 =?utf-8?B?RmpoS3Y2ZVErNjZLaCtQUGQvTnRpRjNqVG1DWU1abjI4YUMrdzN1Wllvdi9S?=
 =?utf-8?B?cEI5WGR5Umh4d2tGd1NNeFJBUVpEMG82UjRBOVIxcjFGb1RkWmdaOUNhQWx1?=
 =?utf-8?Q?5AqOwmC/5L9EuUpyVNTa6RteDuD67FncdE1/uyq0KoXy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3707ec2-5376-4661-fa31-08dd61174339
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 03:37:50.4740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uBKzeeEXVgabm7pV7/4fu2skbjtOB+l/PRgoxys8A9XpisV97Ij1ZlkHAhK5WJt1th1inpyAy3JTC3mcM/vEyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5642

Hi Abdiel,

On Wed Mar 12, 2025 at 2:48 AM JST, Abdiel Janulgue wrote:
> From: Danilo Krummrich <dakr@kernel.org>
>
> Implement `dma_set_mask()` and `dma_set_mask_and_coherent()` in the
> `dma::Device` trait.
>
> Those methods are used to inform the kernel about the device's DMA
> addressing capabilities.
>
> Co-developed-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/helpers/dma.c     |  8 ++++++++
>  rust/helpers/helpers.c |  1 +
>  rust/kernel/dma.rs     | 46 +++++++++++++++++++++++++++++++++++++++---
>  3 files changed, 52 insertions(+), 3 deletions(-)
>  create mode 100644 rust/helpers/dma.c
>
> diff --git a/rust/helpers/dma.c b/rust/helpers/dma.c
> new file mode 100644
> index 000000000000..8eb482386f93
> --- /dev/null
> +++ b/rust/helpers/dma.c
> @@ -0,0 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/dma-mapping.h>
> +
> +int rust_helper_dma_set_mask_and_coherent(struct device *dev, u64 mask)
> +{
> +	return dma_set_mask_and_coherent(dev, mask);
> +}
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 0640b7e115be..8f3808c8b7fe 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -13,6 +13,7 @@
>  #include "build_bug.c"
>  #include "cred.c"
>  #include "device.c"
> +#include "dma.c"
>  #include "err.c"
>  #include "fs.c"
>  #include "io.c"
> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
> index 7ff797a7ad18..ac3ec0042327 100644
> --- a/rust/kernel/dma.rs
> +++ b/rust/kernel/dma.rs
> @@ -5,10 +5,10 @@
>  //! C header: [`include/linux/dma-mapping.h`](srctree/include/linux/dma-=
mapping.h)
> =20
>  use crate::{
> -    bindings, build_assert,
> -    device,
> +    bindings, build_assert, device,
>      error::code::*,
>      error::Result,
> +    prelude::*,
>      transmute::{AsBytes, FromBytes},
>      types::ARef,
>  };
> @@ -18,7 +18,35 @@
>  /// The [`Device`] trait should be implemented by bus specific device re=
presentations, where the
>  /// underlying bus has potential support for DMA, such as [`crate::pci::=
Device`] or
>  /// [crate::platform::Device].
> -pub trait Device: AsRef<device::Device> {}
> +pub trait Device: AsRef<device::Device> {
> +    /// Inform the kernel about the device's DMA addressing capabilities=
.
> +    ///
> +    /// Set both the DMA mask and the coherent DMA mask to the same valu=
e.
> +    ///
> +    /// Note that we don't check the return value from the C `dma_set_co=
herent_mask` as the DMA API
> +    /// guarantees that the coherent DMA mask can be set to the same or =
smaller than the streaming
> +    /// DMA mask.
> +    fn dma_set_mask_and_coherent(&mut self, mask: u64) -> Result {
> +        // SAFETY: By the type invariant of `device::Device`, `self.as_r=
ef().as_raw()` is valid.
> +        let ret =3D unsafe { bindings::dma_set_mask_and_coherent(self.as=
_ref().as_raw(), mask) };
> +        if ret !=3D 0 {
> +            Err(Error::from_errno(ret))
> +        } else {
> +            Ok(())
> +        }
> +    }
> +
> +    /// Same as [`Self::dma_set_mask_and_coherent`], but set the mask on=
ly for streaming mappings.
> +    fn dma_set_mask(&mut self, mask: u64) -> Result {
> +        // SAFETY: By the type invariant of `device::Device`, `self.as_r=
ef().as_raw()` is valid.
> +        let ret =3D unsafe { bindings::dma_set_mask(self.as_ref().as_raw=
(), mask) };
> +        if ret !=3D 0 {
> +            Err(Error::from_errno(ret))
> +        } else {
> +            Ok(())
> +        }
> +    }
> +}

I'm not quite sure why this trait is needed.

The default implementations of the methods are not overridden in this
patchset and I don't see any scenario where they would need to be. Why
not do it the simple way by just adding an implementation block for
device::Device?

This also introduces a `&dyn Device` trait object as parameter to the
coherent allocation methods - not a big deal, but still inelegant IMHO.
