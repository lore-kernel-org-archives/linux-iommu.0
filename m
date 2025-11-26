Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013005.outbound.protection.outlook.com [52.101.72.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC51D137C52
	for <iommu@lists.linux.dev>; Wed, 26 Nov 2025 01:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764121095; cv=fail; b=pkLh8sO3s07c8eJlMTp5ClWlS1K065buOVSjcsl2bw5+y9ySRUXwIcMq5NRkKCH2xMcZ8srMyl/oE2kIiERAHGZkyyVPtetuhjtr1nCC49W+jsRFs14DM71pVUN4OQ8xlxSl0f1HunZpZi4I4AUmJBIkwDFoM3gNYEn+a6PG+bA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764121095; c=relaxed/simple;
	bh=h4Pd3m6O6qdQDqHDSAC1brLwcH7+xF0izOUad0CCdnQ=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nKtJW/WWU9PLiFMHgM/fHBShM2r/re7xGFt14Abg5YjJLjccXyalRTE1CLB1KCSz70mN+Ywv8pWw5WUZ0Rqb37HKk/qZdpr2MjZrQl5N+3HtS1XqqWUu2UOPoVM9aSUOIAIAGIGbXNvbZu6EExAL0jXxMFqZrEUEHIpQZL6JioM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=GYX1Q4q9; arc=fail smtp.client-ip=52.101.72.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GYX1Q4q9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=crXJJgxXA0PlQFWWn2Pu1a6871MXSjMpG04SvGPkIhxRHl1nv8TX4ea8AFBCAIXMxw2wJuEUl+h6zSKx/Vs5biXP4CcKIe/IwDEKKAItN9/YbDbTsASmhikKpDTGZr32bNdspNdgKSq5PmK2w/AwIv35dyd9oAnEFOiPTmhh+S4iXSKYuAThYQf8Bsm0k6CPzhKldzctTVKpItEHb/cj7YPe2/tWV4zsXf9W+HSWWQJL0Ids0x1tJUXGAhKF92Rcn2e7m5KrrZwxnEcVNgANp0BWOOCXCwCH2iZ6x2j3sE48auEflT+hQgLdUr+QJwLnDQz/pcgdzBBeu3TRigLPAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rnw32KkcqINf4xh85FKQ9+1IU7ySXHMcgULriCaY3VU=;
 b=dh3hH2hOOaf/3pvtmO7dHtuqL1bLiWVItR8H07HvBFwAmdZLZ0S2+dbsSH3HPcJwj56dTU649xv0g7J97QwthlMdi+A2kjTJTWh1h+BvXnSdCslkc72d6LlaDPAFU6mQxNWipCK4RnhNQf4gLFmMyeZnrJtxz/QM3TKqfLkLkfEnFShX9LKhVbX7/Yw9YowGaJ4TKktkLLrTilCLtTdnFklnUbZSq4jdOX2xpTvtkO4U3Y/Ta+rKgirhXzIZxrKIbfYIRFBceYHVboovuqvjY/u46ukn44t0tteogelqzi5ng0Le/JVpb8z8glWqAwZvFKhZyZPli4F4xaMLNw0f6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rnw32KkcqINf4xh85FKQ9+1IU7ySXHMcgULriCaY3VU=;
 b=GYX1Q4q9XXZ/0Yol93vnzmyBke1rUt27YSF54y0b74T6P4h0V+xqFOXGMIt0jrXi5bUF1FW44kSBe3GOryMhIeMiWP6gw8mph09O40h03wb77wpqwRmynvVFvQDYrf+pw/pCrOicpkp2nhH8SR2KZrJ3hm1zSpvYoTwtSDHRbfFkq705++5Gp3VQdDGSF4mQGoR4ZP0Kz5tTaDK8ViRA1ofhxJqIgpLIpjN4giJ3UQaUkh0sXiIdBpotdPhalSUv1iGfWg3DgbtQ0Lw1cuszd/2FceOSbPloIOe3Uk9msTIc7MmMBU420ohbLDH7g4CLhTjl0lcY72bt6gT2yOkaZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by GV1PR04MB9214.eurprd04.prod.outlook.com (2603:10a6:150:29::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Wed, 26 Nov
 2025 01:38:07 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%6]) with mapi id 15.20.9343.016; Wed, 26 Nov 2025
 01:38:06 +0000
Message-ID: <cef8f9eb-88aa-4771-b25b-2cfd1ac2c387@oss.nxp.com>
Date: Wed, 26 Nov 2025 09:37:19 +0800
User-Agent: Mozilla Thunderbird
From: Ye Li <ye.li@oss.nxp.com>
Subject: Re: [PATCH v4] of: reserved_mem: Restructure call site for
 dma_contiguous_early_fixup()
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>, robh@kernel.org,
 robin.murphy@arm.com
Cc: saravanak@google.com, quic_obabatun@quicinc.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, william.zhang@broadcom.com, kernel@oss.qualcomm.com,
 will@kernel.org, djakov@kernel.org, aisheng.dong@nxp.com, joy.zou@nxp.com,
 frank.li@nxp.com, jason.hui.liu@nxp.com
References: <CGME20250806172503eucas1p264d6731c73592fcc380b0dcc21cdeadf@eucas1p2.samsung.com>
 <20250806172421.2748302-1-oreoluwa.babatunde@oss.qualcomm.com>
 <416dbaed-a68f-4edb-a20c-94cb4c53c748@samsung.com>
Content-Language: en-US
In-Reply-To: <416dbaed-a68f-4edb-a20c-94cb4c53c748@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0053.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:3::8)
 To AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|GV1PR04MB9214:EE_
X-MS-Office365-Filtering-Correlation-Id: 79f7dade-1b9a-4ca4-8bc0-08de2c8c72b5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|42112799006|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UXRFTkNqRGZiaERGTHBpVmdyNllEb29ZcGd5YWlyOUVuR0ZNenFwMWxYOWZP?=
 =?utf-8?B?MW9FcTJjdWtFT3FQYU04eWJtaDV3UzRFY1lpUnhIQWo5TWl3SEJSU3V1WFQz?=
 =?utf-8?B?ZWI0YzlLMXlDQ08zU1dEUmJLTkp6a0JzY3hIeEJkYTBCdVB1d3k0TlovUzYr?=
 =?utf-8?B?eFdsT0E5WUsvS1VrU3pQMGlLYjdCdFhCbzM0WFdRRmhGNjJ1MW5mbnlUNXBZ?=
 =?utf-8?B?Zmc0enNmQ3JzeUIxb0w0azJqcVQwaE11M3ROUjA2cDJ1WUV1RGVlZHZhdDdo?=
 =?utf-8?B?QXRYeXA4dnpxaXB2aTd4KzY5YWpkb1dtN3l0WmlFTEw0K3piWXo5dVdJWnVP?=
 =?utf-8?B?TjJ3OUtjRXNKcmNNU1JoT3hZcEpDZHBUOEhNb3kzWkRSSm5kYm9MalYvektO?=
 =?utf-8?B?Ym9xYUN0d1dlYnJidEpTaTNxM2JzdzNFN3VkbzNMQTdOUkNVMENOMlYrSzR0?=
 =?utf-8?B?bWVTWUk4QTN1NzZoaWVQWGVFczdIWjQ3ZkRGMHF3YUhNcitGQzVNbmZrVjlu?=
 =?utf-8?B?ZC95czFxQ29OY3pXRkRsUjlraFZTL3FzSEJXSExFVjhGVG5hdVBlRUY4UFZy?=
 =?utf-8?B?MHhNU3FEWHdKMXlwNFlqUmtLU1pFcXplVUJmeGd1Rk1rdWoyeVJpbHhkUmVL?=
 =?utf-8?B?MGxqT285elNWMVovTFg2TEtQeDQ5SGRyRnRRNVFSenRpYy9KMU5PMVB0WU13?=
 =?utf-8?B?Ykx1Ukdhb2ZVSWZrMUs5TVlrZXc5VGhMZ0FPZ21nbnpQeitKWjRkeDRjS3Ex?=
 =?utf-8?B?TDBXREdXMngrNHdMUnp4VmdLdEtUVkw3V2g2VnF6UU9kWCtFeEl4QWVZUjFS?=
 =?utf-8?B?Z0Z2c0c1eUxYUktwWkpBNCs2citQS3Y0alR3ZjlvZU56NndHYi9VZzJnejFw?=
 =?utf-8?B?WmxQR3c4cktvc2QvTnN4UHZKYWhRbUxKUCs5Y3h0d04zMitmMUhrZkVqT0gv?=
 =?utf-8?B?ejVSMVk1V3J1cURmWHVHM1JiQWg2d2UxRmNsaW5WUWlSanFTaG5NN242ei91?=
 =?utf-8?B?aWNHZHhyaGlvUGptT2VDQmFwUE9DQTRsMkd3QzkwS2NwSEJuelZ6L3c5ODlh?=
 =?utf-8?B?ZFBlOVIzdkRDOXRJTy95bHo5aHVHUk43WWZuWDI3TWdraVEvZkNVOUdMblYv?=
 =?utf-8?B?RmhvcmpqZmI1M1FzYXBhcFA3Nk9TNytrNmJUM1FIU2Zhalh3N25XY2p4RWov?=
 =?utf-8?B?NVhRc0lWYytBdlRHWU9Jd05yK0E0dEJIbFpXYmM1OFNMZnZHYUFXK1hJU2x6?=
 =?utf-8?B?VVVLbkphQnk2Y0FrQkhNNFpEWmMwTWYvUjcvbFgyL2tIVncvcElubytSZlJG?=
 =?utf-8?B?Sk84WktYZWIvNGQ5MDdQZFJGbFJmSmVUOUpqWkhpcnc5Y3hDT1JlWHlzVFZT?=
 =?utf-8?B?Y01YWm95aUZuSWxyQWhVaDFYSTUwclIrMThTK3VQeCtTVFBuRFY1QjhZcGhM?=
 =?utf-8?B?cUpOeFgydGhzMjB3L0VDazJiNFJCR29uLzZWUlFDWGpPVjFOL2dFTDBJV3k4?=
 =?utf-8?B?dFRvUGdXY0J4elZQbHV5RTFEcHB2ak1od1JDZDN5N2MyNGt1U1IwbDczSTdE?=
 =?utf-8?B?NnkyVVlWRHFNTVJlTGVvN29DVlo3OVRPbFlJeFpZaUpUdS8wY3pRMnhOWW16?=
 =?utf-8?B?VDBVSWJkWFNxTDRRSDFUaEtIQ1YzTnNiT1RuRTlNOU5aYkRvbGd3K3ZVVFNw?=
 =?utf-8?B?K1NJZmNZZXp6RGozOFI5OEVVeC91dlN0aXlGOUExMTlwcEorNHU0bE44TG40?=
 =?utf-8?B?VW5XeDRKVE45ZmVFdFA1SXJyTVVjdmFXTU52c20vWmRSZ2hmQ0xKT0lsYW5Q?=
 =?utf-8?B?QWNtb3JJeDA3Q1NmT3pzenZDbnMwRkRmbEU0UmN4V21TYWNhQWhLeGtMQllX?=
 =?utf-8?B?VGpOTjh3NmVEZytGd2tCcjhlN0xDSCtYYmdUalFKSmxXQWhLczAwZHc3ekJ2?=
 =?utf-8?Q?UN9imF14Cs0fmp+F1bGU4YchUoBkfOgt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9436.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(42112799006)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXduTFpVVGxoNHFLSHBKYWthM3lUdG9NK21YOFhOdDhjdzBJM3hZNDZkUTF3?=
 =?utf-8?B?dUxHSTRUajdEK1BXUS9EY0dUNWV2WnNaeGdRWC95NEtUS0c4UTR2L29GMi9z?=
 =?utf-8?B?VlNtTndpaHJzWURWODQvYURrRklPUW93UWJJSks3NGNJMVdOaHR3L3hRcFIy?=
 =?utf-8?B?NEk1RDRrUjYrM3U5S3d6UDhOSG9TNHFCN2RXOG9UenZHTG5rTnRidnNJZ29V?=
 =?utf-8?B?RnNnTE5hM0xYVllJb2FuajJrdFhVemE5MjJHaTN1djZvOHZPeXp1K1gveG1o?=
 =?utf-8?B?NS84dGl0aWJlOHpIZi9iOEI1MWF1TTl3WFk4U1RDRmhhSzNhNHIyeFdOdDI0?=
 =?utf-8?B?YUZpU2ZUKy9oZ0dBSGpzOUkxVmF2aitMYkxvRTdRUjZ1ck5rNnQvSGdHV0NR?=
 =?utf-8?B?WWlBcmxpREE5VGtiUm5hUk1EcTErcEJyQVZ5eldXandnQUplcXRCSm1RdDho?=
 =?utf-8?B?QmxoTVNrU011SVVvUW1hc2Fhck94VXFEQmpENFJrNzdtbFNFWGNSdmNvK1RE?=
 =?utf-8?B?V1Ereks1OVFENjZnNlBpald0TDJDSFdGQjEya1RTeG54blNCbXhielJ4Ujls?=
 =?utf-8?B?YklQaXlzVG9YMElJRlRFM1dPdlVOUzVkWml0ZDRyWWRlTlFvV3FGRk9wMDVE?=
 =?utf-8?B?N3NzTGpYZGZTai9wRmhtVTgrNitrLzd1UXExNmlxMGVuR1ZsQkczZVFvVlFE?=
 =?utf-8?B?cTlFZDlTKzJ3ZGlXTzZzUjlad0RuUHJzR21yWEdkTTNZeXFrcXN2UVQ5UDQ3?=
 =?utf-8?B?SGYwbE5SeHJ1MzM0RXE0Z3lVUGtDQnA5K3BmV2JRM05WRGloTndaclJ5QWxk?=
 =?utf-8?B?UHE4NGROTHBWMS9TZldwUW9qMUZyZDR4VURXRnZWQ2xZN0ZkZGQyOFRaMlUx?=
 =?utf-8?B?MzI5VmZlS25DTkNneGxHQnlxVHRVUTV2QXpUNHdKY2E0bExvbjk2d1VhTkdI?=
 =?utf-8?B?aWtwL0lGamtuR2FLczBUbVlLcDlLNXd6Z3FpUHloT0NNT3FrZkN5ak40TTcv?=
 =?utf-8?B?UFQ5emRyVXljYjIrbENBeDhTam1DbUpYa05kTWlUcXdnNjZlM1l1SVVaWGRL?=
 =?utf-8?B?dm5xbFIwaENhUDgrajlzTG9UWXpDUXYxMjVwbzJxTm1PVUVDaVloWTIrOHpG?=
 =?utf-8?B?TWZEVnNRelV6SFpUMXRYTHZvR25ITTBlOEltYjB6d2NLLzRsSmc5b1UyRTNx?=
 =?utf-8?B?MlVZaFVWcElMVkdBWXI3QlVCSEs2Z1M1aWVLMXJqK01sVWJDc1cyU0s5bisv?=
 =?utf-8?B?SThyOWVMNVFqeVN4RTZlWGoyRlBrN0tyQ3ZtNHlKTnY4ZUFMMjNINHpzVU83?=
 =?utf-8?B?Tm84TkxlZkpEc3hSeEZGUERRbys4RlMzcmlPd3NqSitzRXBsdlQ0TjU3RFhp?=
 =?utf-8?B?eUdKOUFzUzgyeERQRmFOZUp0VTZjUHVlNEp3TEJZanpPeG1kdTRrc3hUMndC?=
 =?utf-8?B?SStqaytWcU53QVhTYzIrelhaUkkvZzl2TjNvb2pRQ1R3RktwQjRid1E5QThE?=
 =?utf-8?B?TzZTUEFFYkorRW9qcHZrZS9xQ1pBY2NDL2Y5M1hHbzBGbXBUaWQycTZBbWhy?=
 =?utf-8?B?eU16UEo5OVc0cklqeEtHcVFaN0hOQ2p0QkhzWVJZSTZTU2lJRTBzNzlES2ZQ?=
 =?utf-8?B?TG8rZUx2TjVId1ZoL3dJUldKVjJCc0VYS2JRUTluak80ZDBPR1cvUUtHb3JJ?=
 =?utf-8?B?TkZXVmJweDNKa21UREhIUFFDSkNTWWNBbHBvLzRPektQcFRWbkpuMUJtaWE3?=
 =?utf-8?B?Z09nVUEwL0ZCcXVYYzYzNkFSSmF5ZkZqaHd4dm9yOEdleDZXY3NrVVllVWlI?=
 =?utf-8?B?MC9IT2IyUmVYYllzaGxyZTd2bHpiaDhjeFlHL1JSN0FPb1Z0SXk0cmdhZkFS?=
 =?utf-8?B?RHVXUXpzTTJhV3NQc25Cc2F5T3NJOTc1ZDJFNUZFM0dHMkVWcnpDNE4zNUNr?=
 =?utf-8?B?TmZjcHhDeHd2TEI2dUdnbXVINlJzNERCOVRQeDNsM0tZc2pvSENDMXRDeXAz?=
 =?utf-8?B?OE53YnQzTFRzdzI1MzR2eElHdlBDby94eUU5WmJvUWlUR0xBU3p2YnhxWWFs?=
 =?utf-8?B?a05ISlUrdFZNdDUwS3lKdkgvY0Z4UmFrOXROcmZaRG1KTGNBaXVvVXdXMnRr?=
 =?utf-8?Q?C5wHjATLysB04gBjad2DE0AlO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79f7dade-1b9a-4ca4-8bc0-08de2c8c72b5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 01:38:06.8353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qYPJ9v0LcCe+3WJS3PRWeG4Jdk+2NQ6nkHs1f8sRe+9DbSE6Lz3+/u7QdY6Mz5H5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9214



On 8/11/2025 7:07 PM, Marek Szyprowski wrote:
> On 06.08.2025 19:24, Oreoluwa Babatunde wrote:
>> Restructure the call site for dma_contiguous_early_fixup() to
>> where the reserved_mem nodes are being parsed from the DT so that
>> dma_mmu_remap[] is populated before dma_contiguous_remap() is called.
>>
>> Fixes: 8a6e02d0c00e ("of: reserved_mem: Restructure how the reserved memory regions are processed")
>> Signed-off-by: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
>> Tested-by: William Zhang <william.zhang@broadcom.com>
> 
> Thanks, applied to dma-mapping-fixes branch.
> 
> Best regards

Hi Oreoluwa,

We observed this patch causing kernel boot hang on iMX6 (armv7) 
platforms if using "cma=" kernel parameter. It only happens when the 
size assigned in
"cma=" parameter is smaller than cma default size in dts.

For example, we use "cma=96M" in command line and below reserved memory 
node (160M) in dts.

         reserved-memory {
                 #address-cells = <1>;
                 #size-cells = <1>;
                 ranges;

                 linux,cma {
                         compatible = "shared-dma-pool";
                         reusable;
                         size = <0xa000000>;
                         linux,cma-default;
                 };
         };

The root cause is this patch moving the dma_contiguous_early_fixup from 
rmem_cma_setup to __reserved_mem_alloc_size. rmem_cma_setup can skip the 
cma reserved memory if command line has cma parameter. However, the 
__reserved_mem_alloc_size won't do it. So this leads to have two cma 
regions added to dma_mmu_remap, one from dts, the other from command 
line. But the reserved memory of memblock that only records the cma from 
command line is inconsistent with dma_mmu_remap.
The dma_contiguous_remap clears the MMU paging for the region of 
dma_mmu_remap firstly, then create a new mapping by iotable_init. For 
the cma from dts, this causes incorrect memory mapping cleared. Then any 
allocation from memblock in iotable_init hitting to the area will meet 
MMU mapping issue.

 From commit, I don't understand what issue does this patch fix. Can you 
look into the regression and provide a fix patch.

Best regards,
Ye Li


