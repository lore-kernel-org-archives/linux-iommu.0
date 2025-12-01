Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012004.outbound.protection.outlook.com [40.107.209.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F203321BC
	for <iommu@lists.linux.dev>; Mon,  1 Dec 2025 15:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764604523; cv=fail; b=l4z923l9kBcxAu631xdeQwUWJ6sq7GUTmzZPvIKLhD2vZi2TDWs5rS4EQCeVUvM93kmmM5suSoagbYGefzi9CfD/7adZ2wzYp6eBsmsahIDOqBiXkWle/pTLQdY3hpkbOaGIaPImpKpch/9VeOUmHcxNV9wD+TtdxpjXV/enHMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764604523; c=relaxed/simple;
	bh=HrqILfqVG49nNVIJz9YI0fuaNqxWz/FOzv0LTRflhrU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b2z8aL/UBWvPt7JTQtzeSAXE0t0jnowbouAuDlV4OHYESUHYofAn1Db88J6wA8cE5A9cs8bsVgYr60OZWWDldaRWqO5GVXAsizcMu/sElcNZmCUP886Osf1Y8v6S037v3Sj7C1z5LynM2mDANXVOmYX9PDZs2Fs5hltDLwJj3Hg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P7hfEbUr; arc=fail smtp.client-ip=40.107.209.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P7hfEbUr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WLtNWmmgE7ioxjjBpn404HT3Z/FS49K6ROAczFoerWzVyfj+RgsNIm2ZvIyTYA4oXA5FZpRg3dWx+zOFHwzBlW2OzznRxE3IjfkPuHaR+Anecv/8BUQWe9MOxt4VNPkME+MaseUoFSJPYX++9O9iO5BDJH1K/ypuSi+I5mTEfNTTAyJtVNQKtaTWOPWKvj/CYJNthEgqNXlpwo5VUMWN940nviR7L+l1Bim93N0YxV9wxjhj4PvB540Sf0TnUauCJUFNVUQORoA/7zzw+sWLEGLsdCSH+r56w994l1knXv94QZ4VRu8xJnfOL7gYuyZPqd5E4FM4dZZkn9Fc1GsFmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yVr25F0NjISXNU3qlHu0Tqyh9J2ac+dUkYbk+B2MeRU=;
 b=lEBtSHRJmdc0Ew3qrml1OpO93+F1kZwyDwAhxcFVT4m/n2Hsi6otVy2QXQ29xptFQ1JVt4TEqooquSDuCRHSsawF+h34p7BkMavCiOqnlSGOPMPcWI2s6UZfW16jkzFJ6makB9dxhDQuhl7KdxG1mimlxU/UFTlGQbQjOdphLVoCWy5FqVcwY8kD4sEC8p29Y7wykuntmmiHGSIImLs2KmiNmX5Bi0LV3ebzgevolvRxM5ytOhnEipVIplRpfI4I/TPJ+uZREl9UV71/sspE+WK7qW8HhV4nujsGjd1gl1gvx74n/p3ryhQ3vZ8eeyUmpCGY09JqfKPLHE5DrYpm9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVr25F0NjISXNU3qlHu0Tqyh9J2ac+dUkYbk+B2MeRU=;
 b=P7hfEbUrQpNw3o5OkU964Sg5i7swiHATIguzXXhM9PCqwU/L+VfXlaMfrPzAP0m2m3a5nM8uhgluw6mhBvd1FftS4bzbBoJtmFbE7qXfm3CVDHse88WSNrRI/zPcHIUKe3j9Lu5KENK9L9Li+KTGF3JwovXThUSLkVX3451flSiIbncj8HujUE9yFMni8OWJGQHvflYsyBqrTaN+I/HL8ieEINCpiu5MMkUyo1SSMc9oBELL9VZe5Bl0Oz9RjM1ldIr8ibk+YG70RWrHWtdZ2RYVihAcildv3UK85W3XLD1PK1XOr5XgrcthLLGa/qzQxoWuK22WWhPkF9po4wglZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN5PR12MB9511.namprd12.prod.outlook.com (2603:10b6:408:2a9::14)
 by CH0PR12MB8464.namprd12.prod.outlook.com (2603:10b6:610:184::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 15:55:17 +0000
Received: from BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c]) by BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 15:55:17 +0000
Message-ID: <42dfb0ed-33ef-4fb3-90be-82be77f3f642@nvidia.com>
Date: Mon, 1 Dec 2025 21:25:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/3] iommu/arm-smmu-v3: Add device-tree support for
 CMDQV driver
To: Robin Murphy <robin.murphy@arm.com>, will@kernel.org, joro@8bytes.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, nicolinc@nvidia.com
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com, vdumpa@nvidia.com,
 jgg@ziepe.ca, linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org
References: <20251125071659.3048659-1-amhetre@nvidia.com>
 <20251125071659.3048659-2-amhetre@nvidia.com>
 <b0f94951-2896-49a2-ac19-b885903067ad@arm.com>
Content-Language: en-US
From: Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <b0f94951-2896-49a2-ac19-b885903067ad@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0094.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a8::17) To BN5PR12MB9511.namprd12.prod.outlook.com
 (2603:10b6:408:2a9::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PR12MB9511:EE_|CH0PR12MB8464:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b0a7ad3-bbc0-4b78-e5c2-08de30f20624
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bVJ4RldqMGdQcnZDYk9FVTBlazYvZkpOK2Z3bkZJek82QUlUT083eXExc2p2?=
 =?utf-8?B?NHdlWVdJN29KT2dzREx1MjRiVVRtbmNwQzgzRU4xMCthWUN6SHRoUlhOb3NG?=
 =?utf-8?B?UlhrWVZpSi84ODlvMERzeGljNW5HOXZLeDNZeWFsb0hYRkp3bWgwV09pc3pL?=
 =?utf-8?B?bkhsQmxFK0JFVUpGZ0lKWkZidzdVVS84d3JXZHRMU2ZvSGFjdUE3ODg4NHpV?=
 =?utf-8?B?Vm4zSHYvQXhQV2g1L1Nyb0ZOR3F4MXNpblJVWStuRy9VWEdwYW9tUGYyaU1Y?=
 =?utf-8?B?OGIrdVNvNnBPc1FTM3VtQ0l6UyttYkpndU9NSEJFNm1PaG40elRaWlkzamw2?=
 =?utf-8?B?dThxSWJUK1E4QmtpUW1uLzVna2NkNlNWd2RHVmx4VUZTd3gwNG1KYTF1cTRa?=
 =?utf-8?B?N2lTT3pRYXo2Vzl2WlpoK1E4WmxvNjMwcHlTczZvZGxBaUYzdFdJV0UxZW9E?=
 =?utf-8?B?bmJJMkVQOEFqSllNTXZSdU4weU9PRDJnTzVKWkVjNlNMQnNHTDZTQVNUY3di?=
 =?utf-8?B?ZVNmNlZKeG43TnR3TlhXc1N1anFUVlZQeDFlaTdOaGRTVjNMd0JBcC9PeE8r?=
 =?utf-8?B?R2JKSTFFdXI0VWJ2NGlhQ3ZQMldVOENMcUJzK2JEWmxJU3hucGN1cFFFTk9t?=
 =?utf-8?B?RXJnYzNQa3dKejBkV0VuZ1djSmJseTRzelE1MXl1THFhN3E4TDZLNFhSak95?=
 =?utf-8?B?Sjd4Y00zRFdjdmRRamRqK3ZlbUtzUWxRS1Q2V05aU1V2eThCclVOeHJBQkFK?=
 =?utf-8?B?WEs1QVRzeVdFazc4UHJpejBZQjdZM0JHSXdIQjd3ZHRXbjluQU5naXV4cTJU?=
 =?utf-8?B?UVpwUGdOVFU3c2RjNVhtQUxXei82eEpPYXJvd1ZjSWhySGdOMGZWSjE4RzZt?=
 =?utf-8?B?WWljWGFub0JkT0NFTVpNdEhWOWJqYTdNZHlXY0JtZ3J0U0RJYzVkRFc0RzJH?=
 =?utf-8?B?Y25XY3JiQ1IrNCtzZHp5MGNKOU5LMVR0UWJUTTQ3RWxDKzBaNDlKbU5VSnNz?=
 =?utf-8?B?c1F2UkIrUzJSd1kvSHhjNkNFWXQxUmI0KzhQV1dtRWZuTllqK2pFRk9raStU?=
 =?utf-8?B?QmQrQnFqWXl0NWI5Yll2VlNiRGNwQ29XZ2krMFpKRjlpRVJhWUdTK2lhelQ5?=
 =?utf-8?B?bWh4TGVtM0N4Q0xnVEdLTjg4bWdiRCsvelJwa1JEblA4cHl0YzdmMVE2dnN0?=
 =?utf-8?B?bSt5UG1OWXNVT0NiZ3cvaHVjNXFKWTkyNXU1bmliRm8xREM4alU3SExBdlo5?=
 =?utf-8?B?ZlNsV2pJSzdYSGlYMzNOVVRmTzROY3hWaHlLQlVQZU9GRi9LZGxNV2JSSmVC?=
 =?utf-8?B?V3VZRzdrc1ovTk1WbkwvQ0UyOEx3QWJodE9JdDdRbngyRzNEalh1am5mVDVp?=
 =?utf-8?B?OWh0emFsRVRRWjB4eERzVkN4V2Z4VnMzcGdyMCtpSEswU1lFaGJONkgySG5I?=
 =?utf-8?B?RUZiYTlEN1VRMENpaGdXNDF2a1hjL2h3Z1RadXgxcTNLVEhLckpJY2NrTjhl?=
 =?utf-8?B?UkNYUFlZVmIwZHM4QnpHN2EzZWZZWnJmMUJMOXR5Q3QwS05IeVhOR3JDekdL?=
 =?utf-8?B?dEE3Snd6aUdtclFXa3dRYWtaa2cvY3dZRCt5dWVJOUNZdlVvOGFnd1ZoeXcw?=
 =?utf-8?B?V2VweTNDS1Awd2diUGhCSDZieVFEVysybXM3TnUvVTVmMGtrSzNGY3FjRjF0?=
 =?utf-8?B?bmxzbFdya2ZsSXBpSHkvUnN2OXRETlorUXFEY2UxNWxzeEQ5dTQxRFpHR3lj?=
 =?utf-8?B?RkZGSlJTL2lFWGtwZWZ2M0FabTRUNm03a0pTT2dRWGJqVU50MUZSU085WmQ4?=
 =?utf-8?B?MzVCaW1aZVI3d0lPL2dTZUx2cWZGYUE2Z01jRThvMEpkcndneVhMQ0YrQk9F?=
 =?utf-8?B?bjVpdzBuMXBrQ2Z1ZEVMV1JpRWtwTHUreGlqS0txVlBEbGQzWW1JNFZlVnJu?=
 =?utf-8?Q?W1kAu5RYCq7TPOs+9JIT31kc7pLck9LF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN5PR12MB9511.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjhzaGNCMm9wOW5sTjlZOUdjY2Vmamo3eHNsK2VaN0MvZEFkOGY2SHpMVEx6?=
 =?utf-8?B?SkJiM0tZSVJkVzNNUElISEsvdk9VQzVvNDVkOU5XcGRSY0ZGVmhEK3ZYMCs1?=
 =?utf-8?B?b1NpM1lsbWxGTUR3RW4rKzlwTnNyV2o3Q1A4YW56ellEaUN3Q2lvVWNOdnFk?=
 =?utf-8?B?NHZSS1ViRE5tdWhERVRReW9qejdJZGJzYml5OG1idUVndDI1Yjc2ZFVYT2xZ?=
 =?utf-8?B?WGM5cFN3aWlKUnFPOUFTMm5RNnJKbG9xM1haaTRrWGpXSFNkSXFLM0tlOGpn?=
 =?utf-8?B?c1dYdmQ0QlZLUEVlQzRmK055WTNjSXJZazZVVjZ1MlpabGpnczdKdjh2K1lE?=
 =?utf-8?B?V0k5S3BvMDF6N0ttTGZCYW00TDdLa1VNVnhPanRlUWFsckNENmVZazFHTG1F?=
 =?utf-8?B?cUt4SEVrTGhGdlVhYmc4dG5QMzFVMkt4cEI2bGR4RFlDMS9uVTQvdmpDWENM?=
 =?utf-8?B?dDhEZzRXei9nS0MxN3lLUVZrT1ZYOEQyM3U2R0Fwa2NJRHJyb25LakNMZE1u?=
 =?utf-8?B?YWpUZklXcUh0aWhqTURIazhRVHppQ1dXNm5yREk2b3QyRHNEQUJPN3p6bTVW?=
 =?utf-8?B?NUhZUjhmQmlGS3VoZjQ3eU10Q1JTb3BBNnlDQ2FHT0V5U2pWcS9lMkRWUzli?=
 =?utf-8?B?M1FsQ2NSN0w0VnJBTUNKeXdpck5oQTlLbDlMN25PcDFlOWp3a2NSWGZ1MVVZ?=
 =?utf-8?B?dEZhelNoczVQakNvd1ZxUEQvRGg0cSt3TXZjM1dWT1B1Y3R3Smwra1d3TWZB?=
 =?utf-8?B?TG55UUdVQmZNLy9GYWxLeEVIcUgyUFp2UmUza1QwU0t1OGt2NHg5K0pGakZR?=
 =?utf-8?B?NXptWmhqejRsTE83dHgveWNkOGw1VjFxMkJOYWxoYkJ4UHVQVkRydldqTE5E?=
 =?utf-8?B?Q0xQQklqR0t2M1kvTjZqZ1dwZWR4TTZZcC8yaDU1NFlJN0gzMnp5RnhyMWx5?=
 =?utf-8?B?UWJDL3p0SHNoNnYwbUJOdlEyNVphQ1pGN2JIdGN2eElaM01uNHduc1UzbXVX?=
 =?utf-8?B?VFVTSks5ZmY2UFNoWnhHbDExTXZITW85TVFkNm5zZHNhN3RuR0VZd0UyWldT?=
 =?utf-8?B?M1k1MHRkbG1jNVg1Y0dXNG9TR0VsZFJBYlAvYTg2alJWa2JQaXdkckNuK0ov?=
 =?utf-8?B?THlPK3JKQkdaV3BFaDFhejRWbzU5U0E5bW5RZkJXaFFWUVFvVXpWNTAzMHJG?=
 =?utf-8?B?T0lWMlJ4VzJ1dm4xYzFDWHZOOVJMRlZxWmVlUkRHN2ZFMGsveUFZT3hDYmd3?=
 =?utf-8?B?cFVYcUZ5WFdQcjEvNWxkbUNvNGR0N3ZtM21uMFVWaGNma0JrRjhTWC9rbkJu?=
 =?utf-8?B?Zkt2bW40QlBlaE9EeDNzUm1JYklXUzg2b0pSdkpEdEZlQ1lDNWtCMjVPcnp0?=
 =?utf-8?B?SGpDUE8waHpHTjVHQkExYUU0Zm9ZVis0bFBnVmFaVTVSMmdDeGJHS3JVeTNG?=
 =?utf-8?B?Nk1mNVhYOEczSzRZOGVNNTRzSTJpVDBtSW9JSHJxU3FYR2drZFhpOXBwYW9k?=
 =?utf-8?B?OVM0VkpLVURKUnpBbElsTUlpbXRpSkYvaW9pcmU1dGZ6OUVOOTdmZVN2UnlN?=
 =?utf-8?B?SHJJQ2VrRXo2WmZndDI4Y1J4TmhlSVZFd0ZrdW1mdUozanloeDJMTXhEVkJu?=
 =?utf-8?B?K2lhRi9sL1gzbThkL1FDZ1B4OHozUjFoWVNvZXFrUTZudjZIUDRuYmp3eitC?=
 =?utf-8?B?K1Q2eU1mWVByanIwLzJlaDNGQWlIZ2Z1d2QvNGZqSkp6VjZnREFST2N0WG02?=
 =?utf-8?B?anRpWXZJZVJ1RThoY0Q4Y0ZESk9oQW5HcjlmcStPVnRUekRRVDlYbEJud3hi?=
 =?utf-8?B?WTBUVG1HWXcvY1hZSjc3UFdDRU9saXBjQzRrT0pMY2xUZnIzZnd6MXZ2Myt1?=
 =?utf-8?B?VXloa2s4eDNsWDRUTldqWVI1cE9RVTJTZ3M0SVVzV0g5YjlQRFdFQkRPcmcx?=
 =?utf-8?B?cS9vRzErNEVCb1VJc2habS82cU1zZkNvUkZJbXRwbW1VN2JmZ3dvZDg5QzVO?=
 =?utf-8?B?Z1FxUWlCdVN4ZlBhTnNoVzdpL1hKbTk1S0J6UmdJY0NMV2VqeUczU2VTUzhJ?=
 =?utf-8?B?VkhKMWVLclZuSFRINnRWMW9OVzZuWlk3WG81ZE5wL2ZzczJTTC9TMldSMVA5?=
 =?utf-8?Q?dr+2P+EWJLcmT65XjVNs7LB+w?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b0a7ad3-bbc0-4b78-e5c2-08de30f20624
X-MS-Exchange-CrossTenant-AuthSource: BN5PR12MB9511.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 15:55:17.7645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h3UPvrL1k/Cqv+wmcWXavglwB3bhsYVK2cy2pOkx2HyofF7jxcRUknvu8uhIuho6Bm/HPFqNnTmYSdsfyI2ejQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8464


On 11/25/2025 10:55 PM, Robin Murphy wrote:
> External email: Use caution opening links or attachments
>
>
> On 2025-11-25 7:16 am, Ashish Mhetre wrote:
>> Add device tree support to the CMDQV driver to enable usage on Tegra264
>> SoCs. The implementation parses the nvidia,cmdqv phandle from the SMMU
>> device tree node to associate each SMMU with its corresponding CMDQV
>> instance.
>>
>> Update the dependency from Kconfig as the driver now supports both
>> ACPI and device tree initialization through conditional compilation.
>>
>> Add nvidia,tegra264-smmu to the arm-smmu-v3 device tree match table to
>> enable device tree based probing on Nvidia Tegra264 platforms and
>> restrict CMDQV usage to other vendors.
>>
>> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
>> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
>> ---
>>   drivers/iommu/arm/Kconfig                     |  2 +-
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 32 ++++++++++++++
>>   .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 43 ++++++++++++++++++-
>>   3 files changed, 75 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iommu/arm/Kconfig b/drivers/iommu/arm/Kconfig
>> index ef42bbe07dbe..168ada9c3d68 100644
>> --- a/drivers/iommu/arm/Kconfig
>> +++ b/drivers/iommu/arm/Kconfig
>> @@ -121,7 +121,7 @@ config ARM_SMMU_V3_KUNIT_TEST
>>
>>   config TEGRA241_CMDQV
>>       bool "NVIDIA Tegra241 CMDQ-V extension support for ARM SMMUv3"
>> -     depends on ACPI
>> +     depends on OF || ACPI
>
> This now does nothing, since ARM_SMMU_V3 depends on ARM64 which already
> implies at least OF anyway.
>

Acknowledged, I will remove the dependency.

>>       help
>>         Support for NVIDIA CMDQ-Virtualization extension for ARM 
>> SMMUv3. The
>>         CMDQ-V extension is similar to v3.3 ECMDQ for multi command 
>> queues
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c 
>> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index a33fbd12a0dd..2eec7cd4f3de 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -4530,6 +4530,34 @@ static int arm_smmu_device_hw_probe(struct 
>> arm_smmu_device *smmu)
>>       return 0;
>>   }
>>
>> +#ifdef CONFIG_TEGRA241_CMDQV
>> +static void tegra_cmdqv_dt_probe(struct device_node *smmu_node,
>> +                              struct arm_smmu_device *smmu)
>> +{
>> +     struct platform_device *pdev;
>> +     struct device_node *np;
>> +
>> +     np = of_parse_phandle(smmu_node, "nvidia,cmdqv", 0);
>> +     if (!np)
>> +             return;
>> +
>> +     pdev = of_find_device_by_node(np);
>> +     of_node_put(np);
>> +     if (!pdev)
>> +             return;
>> +
>
> You need to drop the reference on the platform device too.
>

Yes, I will fix this in next revision.

>> +     smmu->impl_dev = &pdev->dev;
>> +     smmu->options |= ARM_SMMU_OPT_TEGRA241_CMDQV;
>> +     dev_info(smmu->dev, "found companion CMDQV device: %s\n",
>> +              dev_name(smmu->impl_dev));
>> +}
>> +#else
>> +static void tegra_cmdqv_dt_probe(struct device_node *smmu_node,
>> +                              struct arm_smmu_device *smmu)
>> +{
>> +}
>> +#endif
>> +
>>   #ifdef CONFIG_ACPI
>>   #ifdef CONFIG_TEGRA241_CMDQV
>>   static void acpi_smmu_dsdt_probe_tegra241_cmdqv(struct 
>> acpi_iort_node *node,
>> @@ -4634,6 +4662,9 @@ static int arm_smmu_device_dt_probe(struct 
>> platform_device *pdev,
>>       if (of_dma_is_coherent(dev->of_node))
>>               smmu->features |= ARM_SMMU_FEAT_COHERENCY;
>>
>> +     if (of_device_is_compatible(dev->of_node, "nvidia,tegra264-smmu"))
>> +             tegra_cmdqv_dt_probe(dev->of_node, smmu);
>> +
>>       return ret;
>>   }
>>
>> @@ -4867,6 +4898,7 @@ static void arm_smmu_device_shutdown(struct 
>> platform_device *pdev)
>>
>>   static const struct of_device_id arm_smmu_of_match[] = {
>>       { .compatible = "arm,smmu-v3", },
>> +     { .compatible = "nvidia,tegra264-smmu", },
>
> Since you're not using match data, this is pointless, as anything with
> this compatible must still also match the generic compatible anyway.
>

Sure, I'll remove "nvidia,tegra264-smmu" in next version.

> Thanks,
> Robin.
>
>>       { },
>>   };
>>   MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c 
>> b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
>> index 378104cd395e..2608bf6518b4 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
>> @@ -11,6 +11,8 @@
>>   #include <linux/iommufd.h>
>>   #include <linux/iopoll.h>
>>   #include <uapi/linux/iommufd.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/platform_device.h>
>>
>>   #include <acpi/acpixf.h>
>>
>> @@ -917,6 +919,26 @@ tegra241_cmdqv_find_acpi_resource(struct device 
>> *dev, int *irq)
>>       return res;
>>   }
>>
>> +static struct resource *
>> +tegra241_cmdqv_find_dt_resource(struct device *dev, int *irq)
>> +{
>> +     struct platform_device *pdev = to_platform_device(dev);
>> +     struct resource *res;
>> +
>> +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +     if (!res) {
>> +             dev_err(dev, "no memory resource found for CMDQV\n");
>> +             return NULL;
>> +     }
>> +
>> +     if (irq)
>> +             *irq = platform_get_irq_optional(pdev, 0);
>> +     if (!irq || *irq <= 0)
>> +             dev_warn(dev, "no interrupt. errors will not be 
>> reported\n");
>> +
>> +     return res;
>> +}
>> +
>>   static int tegra241_cmdqv_init_structures(struct arm_smmu_device 
>> *smmu)
>>   {
>>       struct tegra241_cmdqv *cmdqv =
>> @@ -1048,11 +1070,14 @@ struct arm_smmu_device 
>> *tegra241_cmdqv_probe(struct arm_smmu_device *smmu)
>>
>>       if (!smmu->dev->of_node)
>>               res = tegra241_cmdqv_find_acpi_resource(smmu->impl_dev, 
>> &irq);
>> +     else
>> +             res = tegra241_cmdqv_find_dt_resource(smmu->impl_dev, 
>> &irq);
>>       if (!res)
>>               goto out_fallback;
>>
>>       new_smmu = __tegra241_cmdqv_probe(smmu, res, irq);
>> -     kfree(res);
>> +     if (!smmu->dev->of_node)
>> +             kfree(res);
>>
>>       if (new_smmu)
>>               return new_smmu;
>> @@ -1346,4 +1371,20 @@ tegra241_cmdqv_init_vintf_user(struct 
>> arm_vsmmu *vsmmu,
>>       return ret;
>>   }
>>
>> +static const struct of_device_id tegra241_cmdqv_of_match[] = {
>> +     { .compatible = "nvidia,tegra264-cmdqv" },
>> +     { /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(of, tegra241_cmdqv_of_match);
>> +
>> +static struct platform_driver tegra241_cmdqv_driver = {
>> +     .driver = {
>> +             .name = "tegra241-cmdqv",
>> +             .of_match_table = tegra241_cmdqv_of_match,
>> +     },
>> +};
>> +module_platform_driver(tegra241_cmdqv_driver);
>> +
>> +MODULE_DESCRIPTION("NVIDIA Tegra241 Command Queue Virtualization 
>> Driver");
>> +MODULE_LICENSE("GPL");
>>   MODULE_IMPORT_NS("IOMMUFD");
