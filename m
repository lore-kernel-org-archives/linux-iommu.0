Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795103245;
	b=nYX7+Fk50bbNRYIl4oHEK0u2l7CAhUYerP41+yB09CHSFfkZkxL66BfhsPrmjb1jdC7M
	 rlYugymZDgR3+dcEr2yPf48W7Idoq7eFRJ9/EqOX5rZe7Auy4uuKUqySShsO/KvbSVrF8
	 qlsP1qbdzsFal3ZKyLrJ74caSwwel6bwti16ihIq2O7WiZm5Ku9PPeqdUCdUXO7AtWH/N
	 8zjo1bN8it+RXO7RMwZEn0iaUjp2ZwRlqCR3yu5hwknhyFQAAds7f2Y/geAY+FfhKixwe
	 hAp6qZu81khJVjsr9jjGlXXjfL7SjtpaCZ3e9x/Myk3nTMFelWJQ3LTg77Lb7296cBQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795103245;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=1gRlZFGZmRX4TFopdnQDm5SBcmLNh4WDGvrBti2nJq8=;
	b=j8Su3UiGKzCP1umQoAJJspzVQpAu1N8Uivdl3oBGbQzuXeev9wXNoAvVs552zi9og5Nf
	 mDTGVpYrYDfepo35rmeFvTaclX4fEidINGm3fQfTfsEVmiyRPWeOlsXE/hhvddvvkuJX6
	 6s8QNsiZyQhIVpzzZGfc5/mM1dowCqLDKqlPcN+cyiWPG2zd5NROMPr2K5uFxGtBjcY+y
	 cjUwH1Q85ZXofFEtp5G01kSUXpsU14YC7zrWzRFIAxsIeyVdnypJPL7/xR5wd+Ai5+WGh
	 epiXv6VIiTxlHAZCACT61/zWIEtkRac36q0+ZdX8j+IVgYkwhnSLP4vbcMJO3Vvm/RQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="V/OMnCX2";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.11
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010011.outbound.protection.outlook.com [52.101.46.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3A2606A33C
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 15:47:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C3A2606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=V/OMnCX2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K1GhnnesAHBRkwkJFdquJVFc8IX9K+yDzezAPQK8/aCXlEPiyBsyt2GlyYw1XL/Mj/XjnktvY7uk+5mAPmOQRr9NR1dy9S2h6ffM8jqr2RYUexdyh28Cngl2Cnp0c9doFHGGErZUlWR3UpmS0nMzgD6kl44/yo27lkhrkghhMOsXxwUOeAU5PIN449ryLmzdqzsbmmKTzACNwlMb3sebJS0hMTJZYqez6R5Szl/gXeW05cJoJkRFdbsNh+GA+xmzginAlikxUMmnSBC7+WKZGqixNHnEx0oCBs4sOw2+HIiU53RFurPHKLHY+ecn4TveC72OEEjMIsohhR0vLBlQmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1gRlZFGZmRX4TFopdnQDm5SBcmLNh4WDGvrBti2nJq8=;
 b=gbP2fRZ6RFKhPIzIffwFmlzE5A1dVz5j9AiWJPBdf2TNtUYDtmwZqSagnoOMJKOUQn7PSt6IWVSGJA+7a3+AOeEQrYdrnE6WVOFCQP6QPkHGplCKh1k6lkwo/7512ujKsQkIjPsIisMVJWXfP5/u8teH3+uiADkxAZePYmDBDNWc6cT4rcb+BTRRNtMo+mU6MvxqiMaPrmxJUAV5hlIAx55kxF+7mZUBoga4q7rT3S6muQINLdpycM2M/2xL9oJxwZfkRPowzvSXd4pomBijw7KW/mW4+DCvvLpyGFX38j6fXJ3gT3sa5pbTJU735ggSqMO+sWtxEEi9u3IWqdR26g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gRlZFGZmRX4TFopdnQDm5SBcmLNh4WDGvrBti2nJq8=;
 b=V/OMnCX2JwHSBtJFvgYwdduZbNojHXfnzWjOgj4kq4CKuViaB6pL9jZ4fxlUU6PN5RZZV9EkWfbkeEMVNus16ueJ4y7MgRoZhI2nZyjMxsAvaAqxVhE+StUc+/KR5iRqgULo+Fa1tiWUb6I3V8jvpgZoRgaZwPM54t+Gs3cZeg+Nc0eidi8cSocm7wHXvSbw2NnYOPvLrbziC87N2K2mEHfEsDrEmlgFwe8ZCRjqawaMS2tJVooJtx58WuQYPp497SkMXSnmV2GUaJ2RQ4YAJi4zEvHgI1wogR0JP3KQWEiboosezuITah4Xlzv7OxCguyQWNXIdmZntmK29PD04kw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by SN7PR12MB8002.namprd12.prod.outlook.com
 (2603:10b6:806:34b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Thu, 19 Nov
 2026 15:47:19 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 15:47:19 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jean-Philippe Brucker <jpb@kernel.org>, Tal Zussman <tz2294@columbia.edu>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Jason Gunthorpe <jgg@ziepe.ca>
In-Reply-To: <20261106-iommufd-folio-dirty-v2-0-3f0b0be58c4b@columbia.edu>
References: <20261106-iommufd-folio-dirty-v2-0-3f0b0be58c4b@columbia.edu>
Subject: Re: [PATCH v2 0/2] iommufd: remove the last use of
 set_page_dirty_lock()
Message-Id: <179502823422.3851267.135284689838760820.b4-ty@b4>
Date: Wed, 18 Nov 2026 14:57:14 -0400
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: CH0PR08CA0011.namprd08.prod.outlook.com
 (2603:10b6:610:33::16) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|SN7PR12MB8002:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f51958e-c862-4ccf-478e-08df46546491
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|18002099003|22082099003|261009223027099003|11063799006|56012099006|261028144727099003|261102123227099003|261026140227099003|261026121527099003|261026130827099003|261026135527099003|261022075727099003|261022105027099003|261021135927099003|261021133027099003|261021130227099003|261021123027099003|261021121427099003|261022113327099003|261022115727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	M8/g3SWu2J3GhjGeNiRsxF4Mq9yyx22DBpx90rCfbavMX+U8JVXBLQbrXK19ZhBiY4dfpZAUDQVKILRKSU9vxkgdQnWT5yOXHZBhi2GhAWiIX3g99sCkcLBYgVW+S3GH1sGG2/vkfVJffxM1kZkdJCCLwCjo9rUF3SxWsf63N236pv01RRzfh2rWkrN8qtDZrhrQvWEhp8kEHSAJCReKmBcuShBTjKn3zzef683F0JlkiWOOU7KjpZZsUWrW9NTHysIAbyczOmaVB9HipiaRjjpUte1NkGDFuOBW95fV0EtgsIKS+Af4IJ0xIIb9DJD3pY06r+am9mPsxnm/eiqblSH8P/beA51QVEn9/1D3sf/6KULmLI9u3I20Nd9YAtZ5nZWLFrWnhL3AObZ2HsTn/Hm4AfGWvHPjWuOB0jx9nm6eQ61P47zGKTBaSaybzdR/nPEmRdf2jFrekpIc/USq6uxArg2U5Dr7f0w2bWQ5EBv4y27xdg6uNJkps7PSW3ZQfWk15CzC75KA+PNc/UuRHO8HSXRlHyzhUf2DckBtiOGJ04QlzfQoPfKbIqP8YHhhTnTT4FacTU5oSybwne0U9FNm4qRUXiHhR5fBllArADjXneLJw0F9A6YkgtKWmpN4xb7LDVHLvijWbX0vGB3wwWcILB0hdZUPVGnGDrvyhoc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(18002099003)(22082099003)(261009223027099003)(11063799006)(56012099006)(261028144727099003)(261102123227099003)(261026140227099003)(261026121527099003)(261026130827099003)(261026135527099003)(261022075727099003)(261022105027099003)(261021135927099003)(261021133027099003)(261021130227099003)(261021123027099003)(261021121427099003)(261022113327099003)(261022115727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VTJMV0k4eWVTa2VTN0VOQzBCV2lKbFpBdEliMUpqcWNSMWR2bFlBamsrM2du?=
 =?utf-8?B?d3NTTVUvRWp1UFZtbHJHWStpVFNIaktla1V6NTBJMllFVC9odUY1eXdyWDgx?=
 =?utf-8?B?aThTQXViYmJlWHNoNTNXMk5CWVVnSFI1bkhESFhqSzdlTk9GSExuRkE5ci9M?=
 =?utf-8?B?Y0Q2b1BYS3VRMml1R2lXYm1qdjZ4S3NYQ3ZSbEJGRWVZaTFkUFM2NUVHWity?=
 =?utf-8?B?M2I4N3lUTGlYRkhkSjJBaE9NOFVScTI4K0xlOVdiYmNNejlPYzBJWTRjQkNH?=
 =?utf-8?B?cTdoUk1GanIrVzNNUHpNV3RyTkZGTzJRT2ttM2ptT0U1Ti9iTVhkMHgvQVhp?=
 =?utf-8?B?OHRpK0ZYaS9nVUVIS2FNRGFoKzlFN0djelJiVWdVYUl3VFFBM3hndGFoNlhj?=
 =?utf-8?B?NEx5Z2lDajBnUFFTRWJjZXlhUEZLaEpMOHVValJOWGp5VG0yaWtOZW5SYVJk?=
 =?utf-8?B?dm9lbFM5SklNNEpRM2YycWp4S01nYTlwSEVRQVFpT3JMVVFLV3NUdWttVmNu?=
 =?utf-8?B?RFdsZVBmMmZaYnFBMDVZY2puYXEwNjhxbmVETDFYT09KZzRpZkdRRTZwbVBN?=
 =?utf-8?B?cFVBNTloSFl0S3RNUUVzbHBad2N0NkV6QzMvcWxMVmRuc3lJOGN0K0FMSUFF?=
 =?utf-8?B?VzcvVjlSUDU4L2hYWkxteitVeTdTRHQrN2JMcEN2ZnV1TncwNldoQXBudERH?=
 =?utf-8?B?M1ZkeldXSy9mRDFVamk0V0Z1emlIOU5ZRU1PTHNsZ0d1dDhFUG41K0M2SXJr?=
 =?utf-8?B?LzhabzVPNTU3Wi9qUDlDd1Vld0NLdFdDN2VhL1B0T3BJVUhNUmZDYks1ZkdT?=
 =?utf-8?B?dWJ2RlpiQlI0RVBRQlBIZUNhY04wU0J5aXc1WnF3ejVVMkg2V3dJUDRJeWEw?=
 =?utf-8?B?a21ld1NhbXZ4NVpMc3lXaWtyQWtPV2dCWWd0YUtYeUJVUGhVMU8vMEllaldm?=
 =?utf-8?B?R0RtR1ZCU1gyY2NmUEdnaVVEMDJXNGtKeDQrUUtsN1pDdWhIVExWZGpmRVlU?=
 =?utf-8?B?eHJEVmhxUEI1a0RmdC9kMlBCc2RYeUNFc2NyUUoxZWlOZHNVdXBzZHBnSWZa?=
 =?utf-8?B?S3B6eHVRM0FnWmdsTFVRbkJONVFGdGxxV1lYazNNeXR2dW5TeDRtR25LNkU3?=
 =?utf-8?B?cmNpUitFNmpnUFMvb3lINzkvZFRNWWZ6WGo5bElIR3JNb1V2VGgrMFFjZnJO?=
 =?utf-8?B?cHlmVmdJeVpkenVpbmFremQ0UHozSG9ZODYyOWwrb0ZKemRZMjVsbnVYeGQ5?=
 =?utf-8?B?ZGMxeEU3aDFPUlV6NGsvVEJBL1hHQU9RWnVzYit3eGJRU2hCd3BNc0kyNWVK?=
 =?utf-8?B?SWlJditUMHIya3BobisyZ2JCQzhVTUVBZHFuQnA1MytOUGdIMThEaGhXbTJ1?=
 =?utf-8?B?VzRaM1g0Y2RCdVF2QW8wRm13RnVBdHIwUjZVOGdUOUlEZDV2R3dGM2c4aEZn?=
 =?utf-8?B?Zmx4U3J2L05NRDVmSFpaOEZJVlFqbmhEUjNQaEdWdGhvQ3daWHhPeCs0bkdi?=
 =?utf-8?B?NkQ1b1Y3MXNCL0wwaFlVay9ta0NaZm1RdTVPQ0VEKzVjZ1FFRE1rOGxYdHhY?=
 =?utf-8?B?T3pabEhWZEF5SXYrUGNkUVhYbFBrVnU4aHJNRmloR3B5eC81QnFOQTQzczZr?=
 =?utf-8?B?ZlVJWmxkZzA4L3N1ZDlXV1VJYklaWHA5NnFpcms3QkFBeVRXUG9jNVJjVjlw?=
 =?utf-8?B?VjFSWExad2x1dGw4VlQ4QXkrL2lJNk1Gb0JXTUdnbHBKU1lBRGtTbURjV05F?=
 =?utf-8?B?R0pZdTNXL1NxRnJ3cTFjdG5pNFhlMDh1Z0lWOFF6T2FuNExSMnRWODFpMHNI?=
 =?utf-8?B?VGVlSXphczZtK1NVSDdJRmZRTDBDMTRwK3ROZWpvOS9LR2ZJMTAyd2V5cG01?=
 =?utf-8?B?a3cvY3M3NHI5TlBvdzRSQUMvWFlUTFVZUUkvWU1RUlVSRWQzQVNtcTFBWTEy?=
 =?utf-8?B?NkZEbi9pMGZoYzFFYlVyR2lwaEZJenVKNWUyTUtHSkd3Tm5TTUFhWGVpc3Vt?=
 =?utf-8?B?M1hxK2FKN3hNMUZsbm43QlhJTnhBUFZXTDc1U0E1SGdFSG1wZTRmSUtKaW5H?=
 =?utf-8?B?dHJFN0J5YzdpanRCeEp5ZCtwUDd1cDFtV0p2cUhRQTdZU2FpclJNM0NuSUJ0?=
 =?utf-8?B?L09taXJrOFFlSW1jUkRtQXk0T0FLUkt6QStqMVFtTFhRTXBOKytrSzMzWVV0?=
 =?utf-8?B?TzQycXRaaDFpRzdTYldyWXlwbi9uK2ljdXdQdHZVZWovdzJTU3lxYTgxSnpz?=
 =?utf-8?B?VkpRbURZVTh2STRNQnRYa1BOekZNK0d4cGhiUWczUWdROWJxdEVmaVZ5bkI1?=
 =?utf-8?Q?Iiz3v4mx6rzOirEKQP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f51958e-c862-4ccf-478e-08df46546491
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 15:47:19.2656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /up7ga7icFUwq5EjC6PsoxXqyz0XxitLumxxkt3p8AvbB4AbbzUOIN1b2KCb5Eux
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8002


On Fri, 06 Nov 2026 14:01:18 -0500, Tal Zussman wrote:
> iommufd: remove the last use of set_page_dirty_lock()
> 
> batch_rw() copies to and from pinned user pages one page at a time and
> dirties each with set_page_dirty_lock(). The second patch walks the pfn
> batch a folio at a time with memcpy_to_folio() and memcpy_from_folio()
> and marks each folio dirty once. It removes the last use of
> set_page_dirty_lock() in iommufd.
> 
> [...]

Applied, thanks!

[1/2] iommu: allocate the fwspec before dev->iommu in iommu_fwspec_init()
      https://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git/commit/?id=e2fbca3a6d506e1c9eff9a26293f87a085134854
[2/2] iommufd: copy to and from folios in batch_rw()
      https://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git/commit/?id=db7d2cf9e46c9ec334d9629482d9a6a65672fb69

Best regards,
-- 
Jason

