Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013044.outbound.protection.outlook.com [40.93.201.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE113354AD4
	for <iommu@lists.linux.dev>; Thu, 18 Dec 2025 18:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766080896; cv=fail; b=k5kc4eemlVj9gA3YbTZyo+crat7pH9aMWXxbCRMHt5RCGSCZqiRlEC2QsoW3XqWI14G5WFASyMNU/s/bG0t3UK8IhyqrqEyVKCqUAh/nYZkww7xw8owGla6UGriCdrRWsjweSiM8DEFqzwQKqvUuMBo4CBM+UP7duEAiu1S24M0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766080896; c=relaxed/simple;
	bh=uZoxcxW5gT0bVynrq0xSQ+t4h30etoGSxB01YqjOyPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L2AkZMNhyy5Yqoagg/H0cX+XhzD0XQdQ3ZNesQNpfl8eRgSTMVvtqxOVdU5DlHXCEc9ui5qX9fnMSa3Jp5AOxIFn7de8dKcKkPCx9iVpMgEYE31VEUnWGTcEtxlNlv9M6gdZQbr+9wP0PD8xKQ8X49CcsZMu5YFIw1k5w8Z5W10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z5pw2H1F; arc=fail smtp.client-ip=40.93.201.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z5pw2H1F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hF9bzEdWCos2MZtLKU0vyUX3He0p1z/ob/cx41O9+ufe5QVaCx5g6emLpozDDEfNNe+JgJZ9vEoU9IlAYk+5ScDupTpMZXTg/3VMPkZEOkNn1VZ06hTZuWbg/NhnA1cKJUkWQIN/M5VJZOB/c1fKjhZ5wmjqZVmQyE1/UiP0UPnjsViQPYf969dkZyyx2kO8mV4NGVJ0lY00Y554YaapCcyWRTzRb/7JyAcnqD3to8B5c8987AfoaqyC8wAoNH/FtupomGkmoar0NrOfY7Gqeq7LGFYD7N7WmaY3QjG7U8yThoTRsjDkfamsUbTgMA/S5/fNe37Q3ChdoSeaAaeGsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BCPPILi5GQmN00IAC5hyikq/50xH1xs+aA3/xmXku/M=;
 b=AxfB6KXpAWXVGihK9g5Xr1ZLuCzT9z4TnIUuyrJKbeEASl6cdSzlOxP4WTN7TUCia2mTYmBIQOoj8hBhebQ6bv0opvPHBMdN8HDD9lPS49qfGrFGDGlJ67PyPOsNnBgkJytVt0RO6EvQ7TUbC4biTGchAL0iWu8fjMpPsfpUtlVN519SVmL3rlQhaKVnG5VMxi+Q6Z2BmfZnAnnj9/YL/z6BgQDUDNXfemO0sW12LT0RRtTxgv0ne5k3N37C3Ih7f1lx3Fkhua07K6qVS42vgOE7TlR6aZRqIM5MPIRHZBrKvFnNcSxjxZM7ow2VSH8JXxNH8asho0JV3SjhVckgGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCPPILi5GQmN00IAC5hyikq/50xH1xs+aA3/xmXku/M=;
 b=Z5pw2H1F4kzp+pPjUOGINanrWQze417NRoDH0nwvxGrcSacvJ4IgSQ+UIxvueP0/40+gV3MIEudLksqh9h+jWPsCCGKYF2Ae7unhH6TcXjgqqRZux17JM8nrSPatWDbRPEWREp4g4yy5NHdQbtqHvqKlkqeYWeQFIZs8SXMNRF2nc2AKK59pTX7MI+g3Mwax+CH60eJOaE5lRLnArHJRs9mts1395FkqHJ20IreRu+T/M8c1Fs8HZwsXuJoCjdfbz0tUYspvefJSIvoHdW7qMiEIpa7SQvFt2rwtqyBJegEhgvgDKpEIk+nbIOGkdIbbRiqdF/GJjQ+QMa414ofDNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS5PPFC9877909A.namprd12.prod.outlook.com (2603:10b6:f:fc00::661) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.7; Thu, 18 Dec
 2025 18:01:30 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 18:01:30 +0000
Date: Thu, 18 Dec 2025 14:01:29 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Mostafa Saleh <smostafa@google.com>, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, skolothumtho@nvidia.com,
	praan@google.com, xueshuai@linux.alibaba.com
Subject: Re: [PATCH rc v4 3/4] iommu/arm-smmu-v3: Mark STE EATS safe when
 computing the update sequence
Message-ID: <20251218180129.GA254720@nvidia.com>
References: <cover.1765945258.git.nicolinc@nvidia.com>
 <adf08c3b9f289188aca4fe80e506dca7aa48aa19.1765945258.git.nicolinc@nvidia.com>
 <aUQvAKjVUT1L3N7j@google.com>
 <aUQ6u+s8YbPiLC8Z@Asurada-Nvidia>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aUQ6u+s8YbPiLC8Z@Asurada-Nvidia>
X-ClientProxiedBy: BL0PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:208:91::24) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS5PPFC9877909A:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bc78933-26db-4554-c43a-08de3e5f78e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MGtXclh5b29Yd2FIMGx2SzZyVHlxdlJJSDMrekJWU2FqWnh0aWR2NTJKY29v?=
 =?utf-8?B?V2JnUTVXWFJZL3c1bi9pS0JwUWMzSDM2VFVtclN3dTNsTkpqVWZ6dXBocUJu?=
 =?utf-8?B?YXN4NHM0amh4Nk1Najdkd3hTMXh2Vmowems5dkdvY21wR3hjWDJncWJqSVYw?=
 =?utf-8?B?cjBxQjBtOHVTZ056cVhNOVpWNEdhVC9NRWdYTUloT1VVRlc0UVh5d3E5Z2tv?=
 =?utf-8?B?OU5zNUh6VjFiVzBVaFhvTDdEUWlFVlc2TjZvUExjcWFxZEJkYURkQ3VpTFZY?=
 =?utf-8?B?QnVBblJNcDVTRVd0MzNucUVhSTc5bWtjVUJ1ZE5LeFR2NEZLSzkrVXdQZDFL?=
 =?utf-8?B?ekxyQnF0NWYrTW42bWR6bTVjL056M0RueGd1SFVZcGw1eHpkMWpWK0lRREhB?=
 =?utf-8?B?K0VUMWRqdFpBMjNEMjgzS200MVFzbGp3SGdyOHJtWXZhaXFhanMyeXBCZmNE?=
 =?utf-8?B?c01OY3lXNzdKaU1KZVY1WStxbURJdXgxdmhpZTR3Nk0rRi93cUpWVFRxTmlD?=
 =?utf-8?B?VGw1Qlkwc2IzNlZKUkE0UjRjTVM5UVl0T1hNN0puR09GVnFKT2x5ZjUwOHFv?=
 =?utf-8?B?MU9TS2JNTXpKRmNCd0ZFaVZENWZ3T3lpc2g3cFlzYXhWK0FiMG1VeERja3Uz?=
 =?utf-8?B?MVBRZG85aTBVelNSZHBKRVl6Y2xXVG5SS25lZ3pNQXo1cmRyZmVROWVRdHRF?=
 =?utf-8?B?bUt2M3NwM1NYNVY0bVAvLzg2bFpIb1VSZzczRU82RlhhZkNpOUdoMUwxaUVJ?=
 =?utf-8?B?dWdXSHdrWFNDbUFOcVlBYS8yME1Rb3k4aFQ3RlBlOEZQOE1JUkdTTjN2amsx?=
 =?utf-8?B?RGdsbk1vdE44QjRKWlpiblFsbzZUZit2U2dtNE9MSVlYWHNMSC9tVldPWCs2?=
 =?utf-8?B?eXNsUklhNHltMUxnVmFIekV4SW8xZ3Jyc2tUUWhjSmtNRTFNb3Q5cUJWb3RB?=
 =?utf-8?B?SGZYb2dnQ0lnODJrUmtBZnI5bGdEblU0N1Bwd3Bianc2QWE2TEJFYlM4Ynph?=
 =?utf-8?B?TDZCSmV0amF6RG0raTEwK0xoUGxXdmJWV21xOXpMQUxrVUdxV1pOK21TY3JT?=
 =?utf-8?B?ZmNwRDF3N1hVNlJrb3FlV201R2ZWYWtLRnF5Z1IwdEJUbkMycGRCUVlJNzJ1?=
 =?utf-8?B?UlVTdWlneEVqVU5hc1NHTW54R2J5V3NCMmhqVTloSTlBUWtmMjA0ZWtDYW4w?=
 =?utf-8?B?OG1SNHQyUHFtSHJtRFAxZm1WTGpUN09TbVRBQTYrNmtkWjZOR2E4dEdlcHI4?=
 =?utf-8?B?T3NBZDhkbng5MzlSeFhGNnd5ekUvanR3SVJ3OG9MSUNyV1JJRVA2Z3M0eG1U?=
 =?utf-8?B?SEtlMW1RZ0R3TXpyb3lnYzRwTW1XVU1xanQvblpNTEtrMnZFOWxXS3c0aFFG?=
 =?utf-8?B?czgzU3Z4UC9PbnU1N0NVTWdGQk1BZ0txNTVidDZaelpKWEtDWkY5U2tHcXJD?=
 =?utf-8?B?NjhJa05tdzdxU1V3eVloS2I3MGcwclcrR280WmZBeTArZE56VjErT0hQRmxW?=
 =?utf-8?B?SXJQVmMrRE8wN3pCaWhTT1lWRjlJQU9OTHZJL01pYXJtdTBLTjkwMVYyek0w?=
 =?utf-8?B?VTE5RGs2SDhGVGtCUDdKa2JIZmM4dVR6YndpVWFsejJHQ004cVhnYmUyMG5x?=
 =?utf-8?B?QVpWaGhzaVI1WERaSFdlVjVOUWVWN1FKSW9ETkpPNWswbjl0Qmo2TXBpUWor?=
 =?utf-8?B?VnNCTWY1cTRnMHQwZG96VzcwVWg0VHMrMFlGOGhIMktxeENoSU5OMVVGdDNp?=
 =?utf-8?B?K1FHYmVYa1dNeW1BZ01YMVlHWWRSdEhYT2hyWDFFQkI4YW05aEFQUTFmdmt1?=
 =?utf-8?B?WUZVM3hJMERRTm9ST3l3R2JUUlBrNGovKzhjT1JmSC9jZUh4ZjFpQ25BOHRP?=
 =?utf-8?B?VlNGblRUNUY5RGoyZFFCeUFrbXN5VHhleHlQNGJSRVFMd2VhWWdad0t4VzBx?=
 =?utf-8?Q?pdcA4J3D/IKPrJ6nNkJggi8D6bChq40D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXVaV08vMkdXOWdJWjJSVXZqZGVkOXFRVFV0V3c2WlY1ZU13M0x4M2JDampQ?=
 =?utf-8?B?dk4zVjY3MDZHZStrMElmMWhRZTFBaXIxT21iUEV0Ly9lMkFaUWJsRzZ3SUZG?=
 =?utf-8?B?b3BsWXR1OWN6UGFESXBudnV1WTc4US84QkdaYzRHQ2hvQkdFZkkyQ3F6VzlZ?=
 =?utf-8?B?dnp5ZWRYa3dqTGdmMVk3MzB1bndXL1N4ZEFwdndxNHZHSUtzVE5sMEFSbUVn?=
 =?utf-8?B?UEdpSFRVTmtJVUV2WmgxSFBheTBwRi9iaGkwVHNzZ2F5M0V2clE3QTliQWw4?=
 =?utf-8?B?MFZ0Q2lNZDFJS3NvUElwZm5PWnRnK2dQbHhEbUs2bUZQS0M2bVo2Q0dxUTUr?=
 =?utf-8?B?SUVjTEN0ZVVtdWxKRWlKZ1hqR0lWcnQ4b1hyQmN6cEhnbmM3cWZCdmlqaUw4?=
 =?utf-8?B?bXJMSnpLbEw4eXlzM0RJOHdONnJnQm45Zzl2YWZUQkZSTDB0eFovTXo0ODBG?=
 =?utf-8?B?TU92M0lFRkdaZUY5OTVNREZ0OTgwV0ptUW56SWp0SFROL3g0c0FhSFVNaU5Q?=
 =?utf-8?B?aUlpSld4ZVFGeWdVWk1yZzByTkpVOTg2c3g3UXhNeHVwSzMza2R4aXJFUXNn?=
 =?utf-8?B?RllOQWVoOEorbm9kRkd4YjBRbDU1alA3QmVhaHl6NnBxTEdpK1R5Ti9hS3Zn?=
 =?utf-8?B?U3k1dzNoWTAyNVFrckVvbFQ0bUxVYll1b1dua2ZYQ2g4dlVjQ3RQVUlMVjQx?=
 =?utf-8?B?V1JWWm9EYWVoZkFPbVlFaVg4bWFJZENyZ0pVMXNlbGlJcm9CcVZHV3lCcWtj?=
 =?utf-8?B?NHdubHpnUEFweHNZeUUvK25XSHQxNndvc2J2VC9zT2x3Zmh1c1FrWXhLVEx1?=
 =?utf-8?B?Qzl6eFJobkxSaUVsOEVnVkJRQ0pZeXVBOEJoUC9wU29WaFhJSEU4WUV5TXE1?=
 =?utf-8?B?bXl2R3krdUxmL0dPV0dCUUQ1NFBZbjN2RVYrRnlicXRaRUN1SzJlbE9PcEdR?=
 =?utf-8?B?T3JtcDIra0JSODRDTHJZeFZpbzVRb1BEa2hucWxhQmRMeTkzN2NNOW0rNmxT?=
 =?utf-8?B?TFBXVzhoeGhxZGxuVkNBUzlRZ2w1V3pYYmRQd3JWckRYSklNMFNCcTNRZ245?=
 =?utf-8?B?NlcraGF1Y1V1elNrZzdYakE5Si8vUWErWG5uUUsxcllOaytKOU9HR3cxMGtj?=
 =?utf-8?B?RGo5cEFQK3M3elR0UThTYmJRSlMvMXpybEJBeTkzMW1ac3dNU1NXaXpuVkNC?=
 =?utf-8?B?OGlERjJ0Q01LQlZwdlpVaHpqVTE1UmMzaThtLzduOWV0V0lJNkllQ2Jnanky?=
 =?utf-8?B?MURIYmk3MDFHU1ZTRW82V0dhcTV5dFRjUzdmYkFLRVZJblQ1WTlKOFRDZFgr?=
 =?utf-8?B?ZjB0Wm9zNmk2SDJZM2VFRW92TCtBZHQzT09KWE5xRDExbzR1UTA5V0FjM2Rk?=
 =?utf-8?B?VUd2Z3MvYVhBeExidGIwLzlMNlZ1RXJ0NGIycGdNRit6UlgxMkpoQzZ4M21P?=
 =?utf-8?B?dldYcmp5NDNCaVA4NlRvK011YkFmWUtNYmVjZ0ZwMkRsMDRjVXFuOXNOeitB?=
 =?utf-8?B?TGI3em5nSjVwa0dQVnFSOFJ1ZzdRU1IwSVgybXEyYjRWU3lqQms3M24vcmF0?=
 =?utf-8?B?YXZCL2ZhamVOYTYrYkk3R21JemJxYTF6ZWlLWXVlMzlzeWcwZjlqb2xWYmZS?=
 =?utf-8?B?TXhEUUE4RHhlOEt5QzluNzlVNHoyUDgzaXVqQUEwek41cFFwNW82K0kyaDNs?=
 =?utf-8?B?VHBJeDVMcGFEZHFmdDNYbzk1ZWQrbld1OWxqcjl2UEMzdngvYnBVZWlCUTRh?=
 =?utf-8?B?eXdNU2lpemR2TjRwQnRkVVRkTFhmbTRFMmtuZjJ4dEpoUEtlQy9qeHNwVGlr?=
 =?utf-8?B?Qk1HTW0rVHBpM1ZNbHJ2WkxUd0NES0VUSEN3dUdSazBZTjhzWEdKMHVYeHNy?=
 =?utf-8?B?YnIva2J4TUpQdUlIcy9SRWhxNzJ0RlFoMUxiaE1LRXVRTmYrcmFMSlRzeE9S?=
 =?utf-8?B?UTFtVkFoWmZWUi9ZVGxORXl0alAwbys4MlNMMzVaZjRId0NiQlZoOHZianVI?=
 =?utf-8?B?dEVHVkc1SUI3WVVhbEVHVUpSMHBPVklYajlQRTJSWFFTR0J3QVo2RWJ4R3BE?=
 =?utf-8?B?N0pQZUl3VTFiMzB1ajFkWEZHQmxDa3A5Z1VGQU1tV0ttQ1lQdXVKdEVveFV1?=
 =?utf-8?Q?ZUf4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bc78933-26db-4554-c43a-08de3e5f78e5
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 18:01:30.7457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uIbDf7XTjK4rAQibKm9W3eaNsWJDHXGYcHheHBcyq7rqz/37CBAVwyrtgsc4MTup
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFC9877909A

On Thu, Dec 18, 2025 at 09:32:43AM -0800, Nicolin Chen wrote:
> > > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > index 12a9669bcc83..a3b29ad20a82 100644
> > > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > @@ -1095,6 +1095,15 @@ void arm_smmu_get_ste_update_safe(__le64 *safe_bits)
> > >  	 *  fault records even when MEV == 0.
> > >  	 */
> > >  	safe_bits[1] |= cpu_to_le64(STRTAB_STE_1_MEV);
> > > +
> > > +	/*
> > > +	 * EATS is used to reject and control the ATS behavior of the device. If
> > > +	 * we are changing it away from 0 then we already trust the device to
> > > +	 * use ATS properly and we have sequenced the device's ATS enable in PCI
> > > +	 * config space to prevent it from issuing ATS while we are changing
> > > +	 * EATS.
> > > +	 */
> > 
> > I am not sure about this one, Is it only about trusting the device?

Yes. The purpose of EATS=0 is to prevent the device from using ATS at
all - critically including using translated TLPs eg because it is an
untrusted device and the OS wants to prevent it from attacking the
system with direct access to physical memory.

If the device is trusted then once we disable ATS it must stop issuing
ATS, so the EATS=0 should never trigger a fault.

> > I’d be worried about cases where we switch domains, that means that
> > briefly the HW observers EATS=1 while it was not intended, especially
> > that EATS is in a different DWORD from S2TTB and CDptr. 

Well, no, it means EATS is enabled a little bit earlier or disabled a
little bit later, it doesn't mean it was not intended.

The point is our rules for ATS say that the ATC is empty at this
moment and the device is not permitted to do any ATS fetches because
we won't issue any flushes.

Thus there can be no concurrent ATS traffic and we don't need to
exactly sequence EATS with the translation.

With virtualization the hypervisor is still the exclusive owner of ATS
and guarentees that EATS enable/disable is sequences correctly with
ATC invalidation.

> I think the last line that driver controls pci_enable/disable_ats()
> should justify the whole thing? Are you worried about device still
> doing ATS after pci_disable_ats()?

Exactly right, and we can't worry about that because it says the whole
ATC coherency system is broken.

Jason
