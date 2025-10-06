Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011003.outbound.protection.outlook.com [52.101.52.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176692D480F
	for <iommu@lists.linux.dev>; Mon,  6 Oct 2025 14:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759761440; cv=fail; b=jrRJJ7B0rc1jQopcClfE4QoeninDTlqIqEdFB/pUXplxDOHxzxiUfV300jcOQ0ADLsvuZ8U84oRVSU7zPTSVFM5t2zX5LWLFv051Lz7yWMl2Frrx1R69UsnzqAUztJGKzk8cNTf2B0kt+u7qCj8LsXGVLW6zZ0bIx0bnaPRuwtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759761440; c=relaxed/simple;
	bh=AQ7Z7JBNf8GCsPAxxSAaSxudhdh4qP0hz9RGLZtqMW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=goyOOukD8PP9XKwYSh+be5BAy7XsX18eqh5RgwG1IgQB8mJ/nF7dtziw3ntuLPbcD5iAHHiXhcFdA4LjWTY2nPk+LYd9LOBEaq4T+U90PoYu4gwyPKbbNrI7QTgWr5lp9nI9mCqPWGJRaBZ3LtfCmYB5y1sGkZSHhnrUDewkbjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e0nqCwjB; arc=fail smtp.client-ip=52.101.52.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e0nqCwjB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XcUUP7lBZUjT13RzUMN5Un2lX0yOjGlVyA1dpvd4Bi7KLz6y+ZNm0QPVe8b+0h711O4ryJIdTaQU7B/tH5pISCz9qS6Z79Oh9CZSN1Hi4vZnOHCOXLHh5j1Ue9+HxlUt34WV0lZ7XcxJFtJAXk1VG++nwvb3cVFl0qUXPTX1EEA9F+86gZGa3Fdg7dDYJ7sTgMSkQqD6IXPMkcnKgrRxPbg+5IjRQz2hUbb59ulFtsTR0Oh5N+IhMQyErTZmJwjnu0M0L1uSW87qpADC43B219iWvUqMqMqW7NGIWtNrgKxxw0NhuS3UmhgoQKD7jiJ4WD7ez4+tnEbamdgXu30muQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1WGPUCLd53bWM5o49PI+1gNtAJoeE0omeTsMGkq9lxo=;
 b=rQyoPwS7JGZycCL6vi+44W3JtTx73ewHO6nTep3V+26X6EIWH0FH2UQ2wi4/GJY+Os5ZYRqfbagIGDU4MM6w1UNyzOIdIGKb/GREuDTlpr/bmwWFKuvb/hx1tCP4gvwXf5w42BOvWAiaEQEvy3rOuwj5egsX9/RiISKXWXdPWLaiTIHjeHu66/gu9IZyFQsIBQzfjCLVW+eP8zj/SyDLlZZ95CSEca1/7zYRitWpxuN4e3bLWYTWHZE+peI+MrlgFQmUqkU0Z8Dw5PspTGnNJJxAPBbZ1pHs3QTO2OrGqJeumgYJi0XOb9K0PC9ZX1luTm7k3gxVryzZk/2nCfQO6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WGPUCLd53bWM5o49PI+1gNtAJoeE0omeTsMGkq9lxo=;
 b=e0nqCwjBFmy9GPhtPuMQ0qEg7oH8SniJx5GJcXtr9lC94ZRJN90gE4cjOa8uMAsbYI3Hmtn3jmLKsVPgAAHWg8cXbGj3R0Cg3tkWAVcOVb6dtomKyboEYw7dJsEW2NWp4Q49kX7gsDaNPZO4Kc0OgF19xcKfrcSO4i+28cNFmo+S+MHD9vt/s+yD7NBbrnqbafzimb76zyMC0Umfl47GZRi11yKBExF/kryJ+Xtf1Q5/MtT3I7YOFQhtE3PgSCC6PB5VCtMRwiolptrgp8iNdQ1AnU5eoMG+dFyd6aDf42DwEkpeb9te/yWwFPMNd+z/Si7PnPcIoqBQl5L3kozX8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by MN2PR12MB4333.namprd12.prod.outlook.com (2603:10b6:208:1d3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 14:37:10 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 14:37:09 +0000
Date: Mon, 6 Oct 2025 11:37:07 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: nicolinc@nvidia.com, linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	will@kernel.org, joro@8bytes.org, kevin.tian@intel.com,
	jsnitsel@redhat.com, vasant.hegde@amd.com, iommu@lists.linux.dev,
	santosh.shukla@amd.com, sairaj.arunkodilkar@amd.com,
	jon.grimm@amd.com, prashanthpra@google.com, wvw@google.com,
	wnliu@google.com, gptran@google.com, kpsingh@google.com,
	joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com
Subject: Re: [PATCH v2 03/12] iommu/amd: Make amd_iommu_pdom_id_free()
 non-static
Message-ID: <20251006143707.GP3360665@nvidia.com>
References: <20251001060954.5030-1-suravee.suthikulpanit@amd.com>
 <20251001060954.5030-4-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001060954.5030-4-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: YT4PR01CA0003.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::7) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|MN2PR12MB4333:EE_
X-MS-Office365-Filtering-Correlation-Id: 82723f24-4b57-413d-014f-08de04e5d4a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yhpCX717N037oRiu8cpxgvAjOtuRWzd8c8Eh9l3Rv/95k7llGikIWSt6Tahu?=
 =?us-ascii?Q?6ZOmrB4nfKd+xOmFz2xHcjY7F4Ma3xHCqLsG606KPNSuAEkIV18fWBljlWUv?=
 =?us-ascii?Q?uAsmYpS9+JQ3U0vcElXI+MPJp7cSJJ6QfzNK70LMyHHT4TJC45b4kubY8VDj?=
 =?us-ascii?Q?JWFs3KM4jQYtRJGhp3mxelfQ17ugdIjMaJgdE5nwqpbD607SWqBiRpIKYGsw?=
 =?us-ascii?Q?E7+PUP1vsuQMtQpmFD9OJWJXEndxScnCkcUlELkldrDqCPdAa7CCh1BIhLjL?=
 =?us-ascii?Q?Q0cD0BFIYAfX38SV/l6F1mm+Xs2u84vVl9L4S7BstR2OKl9KQFOX4ltYmqtz?=
 =?us-ascii?Q?L4zyg8IVNbU0SKUzVwESVOtGmbyJ3LP8J5m2yHIMj3+FDHk0szguPEii4FGb?=
 =?us-ascii?Q?04bSbzQebpLX6cGG8lSbntgqZU21ewPPocdwqGER4MAAsVlVikmbdlU9klA6?=
 =?us-ascii?Q?+EF7onRJL/2dvjrTgTDhU1/BPVfsWaiRD1EFtv7Wlw6pJ+Q5i95RfOMlCvN9?=
 =?us-ascii?Q?ym1PQNinjzzCez1CZ+ep/mrLWy/Fk8uuRbxLxlx7Xq5ga/FEun5YjZ6Q7rgT?=
 =?us-ascii?Q?1PvdElnX7ML+1Z7T8wGsCLxbDHESUAIqBpXUtkQ09u6daRXj+SDtXsE46FoH?=
 =?us-ascii?Q?nIQ+l5p5UxWp3py7YHfjNkVFLJeEUMOd8UJz35/hEjZmsnhA76I4iKNvzCyA?=
 =?us-ascii?Q?cpRmts5k9aOFVaVt51q0+B60QMvHCo+0QLuGSD58s+fMpMgMTy7Dczh5l1xf?=
 =?us-ascii?Q?y0vqROE4P3EoRPGEOdkQB9Jhm0hVr3E2dC8vXOlgjvPiyG/kXroZ11j4Tsfy?=
 =?us-ascii?Q?ejbpCUvXE4U4g/ZpS+mwBkw/9ri8qVBFWnEAVZMfHEBGZQsA3I7cre3+VG8A?=
 =?us-ascii?Q?hoxJ2ibsXrLHXxvMfJhUbTWUtnf0Ai3p8CxgjoKP46IqqpVly7UNq6P/HF5+?=
 =?us-ascii?Q?uA81Td8oG1shhn6ZWT7eFgaaKLEEvUmTH3o2RY8lDon5aS/gKyhoW0ZN5xu+?=
 =?us-ascii?Q?pfEV/i5goh5R8jjs0CS+fW+908qznmWg8TDw0cjPWVyMw+cmuHrvUwHJjKwT?=
 =?us-ascii?Q?tg0KsX19KyLWKaA1ZEbHoCxv6npp5u8i7yN4eu32ELmwZMIcc69D8hSEcRNZ?=
 =?us-ascii?Q?iBgiuzgGhg4sIwFXE4xe3ZLWt8F1akm8iZdCZPa/cO3C7TIdSB4iJkUyvsp8?=
 =?us-ascii?Q?PqVFAGd3GNFcPXKzwyynASlEGC1DrwPh3u/DJ4lsBcotwARP/wwmEV8wI0cw?=
 =?us-ascii?Q?K2WhESa/B7epAgYymLW4BtesRpg8Ddb/ZaSGaNSE6OlJOZlTKM5RqHSDAiK7?=
 =?us-ascii?Q?9A9/yc6ImXZksnUaddhiThp6i0XIwhEI7EOlIhJ4iCMREb9tnG7LTwTh+C1F?=
 =?us-ascii?Q?4dWLOjm7O3Dmr3YKXI1erLE6rm9ixLYdJSX8YceLukgFt+36pKmM9AT+jE/Z?=
 =?us-ascii?Q?hjSF0MFGSFXfQNsq4lyqrZ0dtMuFHdW/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YG+2B2IrdXdqfDJ+dd75SxcauNnwcuszWwyPQ7tpplGhVdFYzp1n9QPGwp4Q?=
 =?us-ascii?Q?5I8K9RBIUwTg6Vl7dBq6nAQVZ4sVA1fLwVPEcoBlF/hMc3Mr2PdcY5X5x6KV?=
 =?us-ascii?Q?YeyJ23H32OCasShRS11rXbm7+QoWVQYBNzcbAaNUKUIyw6QvOigDbkMpSR/Q?=
 =?us-ascii?Q?KeEk7kIxMzyg86Wey4K/cAPjykC6EODK36TFp5CFhgqX1/YByStyJPy3NVYy?=
 =?us-ascii?Q?omyQCPVmMYGz2Za97cRo/GPPXj6fAeAkCDLwzNarKHTN14kuWKfTaZSNP3v5?=
 =?us-ascii?Q?G8/9mx4ZqcuWeucamS2j/Gdg+h/KOkVqsJUgmoOeRmVrxfKgCGsbWkKVmjUN?=
 =?us-ascii?Q?eX8CZpINtD0miGfDCICiZnxbiafnkCj90e9jC+rz7wBemZ9hMWNHIsLM6JmX?=
 =?us-ascii?Q?EGigxSoHMoDIbHsMFeQcx2HuQsFQDY0QSr9lZ9HKGqM1gi/Mu990L9oPadPd?=
 =?us-ascii?Q?9erxUR/tej9ZTZETnM1YVhhcG3qoimJ8w6DXVUBnaVW77kjN8EHP0CqFFV16?=
 =?us-ascii?Q?H3hQmizQPmvLn2QTQtD30TBCbuwDfWSW5tnBWWRZc9Xf9/Kl7tRVCqH3PjvB?=
 =?us-ascii?Q?LKwGvL/434hWPGHtLiStQTCQUeKBOIGSbdWR+GpjvqNMyNBgSFRl1E0HnKda?=
 =?us-ascii?Q?qt9XxY4EYvZQ9jNiFYJct71YYQVm9UGaYJlletwf24M1Bx7E1Dg58YDcYeQ7?=
 =?us-ascii?Q?D/olZNu1EvuBTknQCZRkhKcrxsEqeJQqv52ImopavnQjSgrjYFULVXGfmdN2?=
 =?us-ascii?Q?s72QaCqWPFA0KNLfOWBvoOCXsNS+rEzgAGFoElz52AcfuSgBBl0uI1Xspv4z?=
 =?us-ascii?Q?o77BS+BFaVNI2fm3e4nO8mSnfPFJhbmBUKNrvNiBgM20HbMaSyBCUqXTAhgF?=
 =?us-ascii?Q?g6Ijbs2MZJhuc8WhrwREB3cCa+d/vtqy798CDitkO06rptASbRGkPn4YH2ky?=
 =?us-ascii?Q?YSzipmKCBZjE8H9A4hf42J9JnnP9jwSLR2rM8dbxQSl7CmoDaxTPYSN9fdrk?=
 =?us-ascii?Q?QskqNW1y96M/qDDion1CJaeXMLwELiCsXJYa8VZoA+8mIgaDQkAbRUh6D/49?=
 =?us-ascii?Q?6zI+clJLCba9K8EvifFWGv29X4oB9rv0Qe1TISoUCSt1hIpDkeoRWXJui6or?=
 =?us-ascii?Q?eCS1PF03rvhT9nx6NPwPnntm5dmI8h2GNFji55hHl/c/KaByuw4bA7V6iYwc?=
 =?us-ascii?Q?+ZXkbE8su8sKbR5HQ/b62bVZaei+Sno8RuFRTVz6frMCiJ1biGglUtquCbzG?=
 =?us-ascii?Q?cnb6FkIMuqpJK7gr+ynpam7H/pfBEkmRKyDHgHjzXeBborKVozBYbphTAWMJ?=
 =?us-ascii?Q?cRIEg05lwo3CjZ11+uMdCILDbZ9R59SFksy4TVv1LQqIKYsquQxW08nCuyS7?=
 =?us-ascii?Q?S60pse5RdUDPCYGZmp1OyVRxcD+raJIUr3IrGnUYUo+3cZ6hsEy+Gr+MAbOs?=
 =?us-ascii?Q?rGZ/qDPxI891pKkBhfWjF6y4s52Zfe+lXDXFfiNvXv0egvAB1iVyUMYz2INw?=
 =?us-ascii?Q?f6fXahp4urwDCVr/COn/xVpgRxNlvSMAt3a4/xrhYsOiI5y+AndeHRNqaxfI?=
 =?us-ascii?Q?oOlVif/O0y6DxTaUIdQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82723f24-4b57-413d-014f-08de04e5d4a1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 14:37:09.7141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cg1vSBZ5POjAFGGQTvWKAM9NyFs42WwUAjyNs0/rqSp92gIbeQdvFJojgzM30k3Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4333

On Wed, Oct 01, 2025 at 06:09:45AM +0000, Suravee Suthikulpanit wrote:
> To allow reuse in other files in subsequent patches.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h |  1 +
>  drivers/iommu/amd/iommu.c     | 10 +++++-----
>  2 files changed, 6 insertions(+), 5 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
