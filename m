Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011005.outbound.protection.outlook.com [52.101.52.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C602FBE1D
	for <iommu@lists.linux.dev>; Fri, 19 Dec 2025 10:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766141319; cv=fail; b=llpRR6OQ2qkHAh9BEyVD6JO55yc5YDo6+XwmRtnpjjvjfLYdWSAnMYKe4IZRN4zSqCDEo/sfV4pGQk795QwonJnL16DCwuquYbovlrgIPRoxP6LERUsfWpOD5VM2v7ifDTNPFMwlnaFKr23QOGdP1qgMZgwTza8Im9j12T8DFr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766141319; c=relaxed/simple;
	bh=xpAovzmi4T5QBIE3rbbc0yaluD3IIXjMER7X3oh0Dug=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XyB6ieHnk/buwuRf1eJ4u7wnNmBSQMvUhiJIfvXAeXHzh06oxR6gvc9J0TjU4aTh90oWOY/jqZtjj2P7Smg+obK8CEpnmrwkaoMHmtAN+K4ITpt71ru2LXTKVNvdQgvX83/jFW1j8iP4hKspeIwOGL2MPvOLRnPRrPukUSRzJb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dzkmaQmm; arc=fail smtp.client-ip=52.101.52.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dzkmaQmm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BIvPoNOlepU5u5QGRB1vWIdHSCYAneYTv2JIEqt4Y86YEofj+2v74moFyb6E50KEbNu/t9yy7z0zq8fmf9Of5kCe4qm0IgfYeJ1aCPKdMJg60zuSiAL1ZZaVEsfVMZ/MkElzFFCuav1HQuF7vnKex5oxo+lNgbdXV14EiQsIVM5XjQsQv8Fcn+/L4WJwOUgw2uOa3I1Q4uc/9DrR7DvjKPy6woXQiy2Ib4nMuxFE/63CBtrC9Es7uCeApv+CIYJOp6mjzIPK4LaXggyqTgBMk7CIrOpgobOblvuNa8+bbPca/cMPqayC6odSRWS6V/AfIa5uCb/zoSWr7xgW5I/w9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QRNHzCgi1r95HgVOzEfRfurnR6YIVPfvaGVTFHJbGn8=;
 b=JhU+fO9ZeSB7Ec5J5zjp0HQkYyerS/7qwqGKHT7oTICUPLEkQniDW9xK6peHkiZu0KHo8XikGyvfliuKwBoz75cWlJWBCpA/YiTvmpSTFj3xCE5a6d6lzMGM2RKxaxykuLMQwP2bY9p1ChppTyqC15sCyC/cMUS80LyFTe7VPMtFNBart1xmuX4Jg2yxqEpX7yMWTCZVdgV1GDkgLeDFXiPejyzpyZD26/ufLhpu/zv5jkruoDrtfq73dxEloYnZ443qD1uNEBu5Kx/1umCAONyrsnazB9Dbd8Te01yxgX9SLLwRGnGbkbVt1ljpO7eLjMwlOUeEZc/pEWiZ3nSGeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRNHzCgi1r95HgVOzEfRfurnR6YIVPfvaGVTFHJbGn8=;
 b=dzkmaQmmx993ohD9xy4INqF5l49uHzQrtEApXrITCV9LMFbBla7btB16Ku8A3n7A1AuHDSE53+zdKyyxry2O0wt1Vbfj8Suly7HfNqCLQDdedE1XfSBTZNNU6ZdClSXxqYEo6XwD9VLwWiZpise374AlWafkGV0Ybs3AhfSF1vqVgXyaiJ/BsK4c/nZHAiZceuZR9FK2C9dAE79fZq+ezQE/yoCsrVlRMWFjM+JBXO8PAXcUyLI7BbfoIemSVG3jkHs40vVBLGBLryE/urNqTYecT0rrj5rflx39EYT8U45HOcB6GnS5yTf2gyG0yFAkIOhJTw1hITOfhWorrJSsCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by PH7PR12MB5973.namprd12.prod.outlook.com (2603:10b6:510:1d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 10:48:30 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%7]) with mapi id 15.20.9434.001; Fri, 19 Dec 2025
 10:48:30 +0000
Message-ID: <b2df8ce6-d336-457a-8169-f2eccec3c12e@nvidia.com>
Date: Fri, 19 Dec 2025 10:48:22 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 2/4] iommu/arm-smmu-v3: Add device-tree support for
 CMDQV driver
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Ashish Mhetre <amhetre@nvidia.com>, will@kernel.org,
 robin.murphy@arm.com, joro@8bytes.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, thierry.reding@gmail.com, vdumpa@nvidia.com,
 jgg@ziepe.ca, linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org
References: <20251215064819.3345361-1-amhetre@nvidia.com>
 <20251215064819.3345361-3-amhetre@nvidia.com>
 <23df682e-6d08-4827-994e-1bbd89e5c903@nvidia.com>
 <5e9a0ce1-a0ba-4a31-be95-99f349ec6028@nvidia.com>
 <e7d3e95f-a885-4b13-ab4d-bc82793c5396@nvidia.com>
 <aUROk0jRQoLmBRo3@Asurada-Nvidia>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <aUROk0jRQoLmBRo3@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO3P123CA0029.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::19) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|PH7PR12MB5973:EE_
X-MS-Office365-Filtering-Correlation-Id: 60ea24a3-df90-42b4-dac6-08de3eec25c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N3Vzc2hRckxGajZ6MmN6WlpHM204ZTRQWlZiVGJNMUt1VE5jRUxVVWdZcVJN?=
 =?utf-8?B?Ujhtc2Y3b3FQRE5ZVDVya3RTSUhud1FoSXFUVlRsYWhaWGVzeVpzUVB0ZDZU?=
 =?utf-8?B?RGh3WWpVUXNLMklKZVU4S0IzcCtsTWdkUVpIUkNKaUJVeDlEaGRGUXNrZWwv?=
 =?utf-8?B?VnFoN2UzRXdZN2Rjd1A2WFJ2bEFmb2VmRXZoRjRZQmtha013b1ZaT3Eybnd1?=
 =?utf-8?B?WmlGdDh0R2cwckxjSUd5WXVBc3N6Y0FONGxoOElOWjR1cjFQWjFocll6MzdJ?=
 =?utf-8?B?R2FTbm9xSS85UDJGZjZNSStiWkhUQ3BYUEg2ZnpuMDlOcEpUM00zVFFWSHpn?=
 =?utf-8?B?RWUrYkRPZSs5OG9NdUljVnZsRXhzZUlVYzFEb2E3R0Vsb2dlT3d2dHdFa3l0?=
 =?utf-8?B?YXJ6MStSUjJpV3B3L0I4ZUdOT2lyczF0QlY1elhlWmJoajY3bTUzUjltZTZB?=
 =?utf-8?B?K0xLMTBzL0ZsNVpaS29PTTEvN3dUL1lNaU80dll1YWQyKzc2djFOUjUzalRI?=
 =?utf-8?B?TEVSZUdHc1BNVFV3K1hPdkpjYmdmUldKN0xpbmF3QnNZS0NWTTlHNDhzY1Nr?=
 =?utf-8?B?N1U0U0owREVTQ1ZFT002bnpVRFNyNDlEYWtoWXhUOWprZGdDanFyeUFSY2hO?=
 =?utf-8?B?NjFhb1RFUlM1Y1Z6UUVEUVczZTU5c1R3VFRKNDU0U1dtWWEvZGVtRTk3VytZ?=
 =?utf-8?B?VDNxOEQ0cGhzT2drdS9ySjJzOGZ4YlNqZGlXVkpwZFFiVUZYRk1pQ0hEMElM?=
 =?utf-8?B?TnFHV1hvQkNjQUtjVHpmUnlPV2V2VE50NCtxeGNIcUp6Y25mODJTZWVtRWt0?=
 =?utf-8?B?dktEMDNoUW81ZEdrNEFuYVBRTndtY2thSHoybUFqUjdrZFJGM0didWlQdlU0?=
 =?utf-8?B?aC8vUTdOYkEzVW15cXNYN3JCWTJsL0dEby83b2JjbTZkeS9mNkVlbzBYdnMz?=
 =?utf-8?B?OUVKbnp4VWZnVURJOGhpUnBxM1BVWFgzcGpnZkxvRDI3T2ZOTmJ0cEFPODQr?=
 =?utf-8?B?RGRLMTVZdyt0Y1BIVnVmOHNzd3Vqc2tkWktXMmxGOFAxOER4bHpBZlVRUll2?=
 =?utf-8?B?MW1OOTBYSEtPUnI2VjRWd1grbCtnY1FJbEYvN255YW90aGd1cldDVDlBK1Vu?=
 =?utf-8?B?ckpEcVpKUnFSRDBDNURVb3FGZmxDRHBmVkFOdTV1N0FtQVZVUk95LzYvS2d5?=
 =?utf-8?B?Q09iVUpmVHBTQXc4dW8za1Q3bTRYMUFvMElTWXgwZVRodEhWdnc1SVUyQWl0?=
 =?utf-8?B?U1RscGtIcWlaRXdRSVMxVEgwZThkcUxDKzh1MFlzYUNpTlRydWMvVTM1K01S?=
 =?utf-8?B?eDBhSHNCZ3R6TzdNaTJrY3BmWjNjUzFVMFcxRWJZbEtDSzQzcWtCZFZRM1FU?=
 =?utf-8?B?MW43cm54MVliWmErZkc2TlVxYW9VQXZjUis0bk9zbGtsREF2bGxsZlk5dUxQ?=
 =?utf-8?B?RFNZOVd4WlF3NGNKa1QyeU1DRTJLY2NnbmJuZ2VvQ0RGQzZTcmxEa2ZENE5r?=
 =?utf-8?B?ajJDeGswZDFpRkJOMjJpU0Z2c2szUjRWUjRZWlh5clBZdko1ZktETThqVE8z?=
 =?utf-8?B?eWkrS1FDZ0JCTnZOK0UyRlROeWdQemxsc1FiY3F6SDBIakJRSWxtVG1uOXVD?=
 =?utf-8?B?NnZBNnVzRTNJSTdHcnN3UDdLWWV1d0dpWFRsYW5ZZmNDWit0NWt1Nk9NZ0V5?=
 =?utf-8?B?R25uN0E1UGNMODczTVZsamtkR1M4aGFtOE0xNTMrZzZVaXV3ZWQ3d2dXM0xq?=
 =?utf-8?B?OFAwUk1zS2ZSaWc5YU51enphSkhmbERtNmRzMlgxbE9ONG9WZTVKZFNXNDhv?=
 =?utf-8?B?ZmZJc0tlWU9lQTZJQ2hQZVlrV1JGN3N0ekRKeUlLOUZjQmNWREg4UVd1WEky?=
 =?utf-8?B?VGdaMDJKYitSODRMaE95byt4czJkOVg0bFd1eElsbmp4V3FQemt0Qks0WDdq?=
 =?utf-8?Q?C/oLM0Vi/ce0oZ5qS2dycnNo2zMbDi/3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmpCRWtuZG9KSHpPSEZaRmQwVUdHY2FVaXBmckVkRVI1RTh2TWkzV0t5NjVO?=
 =?utf-8?B?VGxlYVkyUVFHcDBrRnAzb1EwblU2c3o1WUthWFd6NlBwbVliaklvbVR2QVpC?=
 =?utf-8?B?UmpjZ25OUE40NllTZnE0ejRMZHNudXZTMVdMVEIxZk9Na0k5SWVIMWNpUklY?=
 =?utf-8?B?ak9WNDZRY1pHeHpHUC81eGFUaTl2dTRXeDVlbTZzbGNQbHZPRmtFWEI5YnFN?=
 =?utf-8?B?ZTBjQ2hQellIOTZ2TXE1NW5aSmRYd09tU1NpT2xDRUwyd1NkcTg0RVpvZjlu?=
 =?utf-8?B?NkVKU0lQNFlwbTVkSkpzMlc5amZ2cG81ZGpDSDNoOUd4VVU5eEhmUjNsRmxV?=
 =?utf-8?B?Z0NqcjlYYTl3dTJKYW9NVDdDdHI4ckdFQzJCTzNrUUhUUkp4NXdyUWQxMG9h?=
 =?utf-8?B?VG5Qb05lK0ljRmlsSjFVS29iYTVFYjhTc2FFTGNtSnNrS1F4M21HcFF2ai8r?=
 =?utf-8?B?YmlNUEdNZlM3NDBiWTdiZTdVRDhKOWNGanoxbTQySy9wRFJlbHlZeGs2Wkc1?=
 =?utf-8?B?b3JyUno0RGs1TjVKeDQzWEtxOWRFZld5SUJLTW5JSEpoK05xUVFuTy8xV2c2?=
 =?utf-8?B?QUtLYTU3blZ3a1Zzd0hFaG9CeWRrQzVpbURMSzdkWFR1OG1vNXVjejRsaUFG?=
 =?utf-8?B?SkVCb1pBSENVS05PSzE3TmE2RG9PTlFqbStsQ1ZMd1lCbks4SjVUdlQrdGpC?=
 =?utf-8?B?Um1CWVJKYXZreGdCZmhadk5UYVE5VWRRNmVsZmVwOC9BN3dRcnU4UTVRRXBH?=
 =?utf-8?B?ZXdIclU4eGdCaHJJakxjRjJEK0p6S0hzS1o0WkpzMGhDOEYyc2RRZngwRW5l?=
 =?utf-8?B?T2w4YmlWNDBDcXBNaUdMbDhaTkFGMXNsR3ZveUZEM0dKQkJVTlk1M08rS3lQ?=
 =?utf-8?B?MmRFT2tNZStEUmhkUDRWWk9tTERkUjdQa0RLMERTRkRrbXpCU0tJeUFEWENZ?=
 =?utf-8?B?My8wQUtrRGV1dVdMRzJTQUxrNmRIMndPVXl2SHhvN3pZS0Y2b2ZzU3ZDa2ND?=
 =?utf-8?B?QWREdVdPVlJVcUN0c01xRVprWVVPUkxBcU9acDJuLzhBZlRTd0N1aW5sUzZH?=
 =?utf-8?B?WE5ISUpTeDh1SzV1SVpXckszQ0NpVXZiRk16Q011ejdLSWRDR0RMeVUzcG95?=
 =?utf-8?B?eGd5Q0JVWFRod0JONjFWenJabDJMTWZOV3VVbXBLaENKZ1libGhkU2xRVzZY?=
 =?utf-8?B?ajUzVnd2OVZISDdTU21lMzFpU0lpNlc2L1NwKzFacStTQTRmVWU5ZTVERzY5?=
 =?utf-8?B?aWJWY3BkYytLZ0pxV3ZpbDc3QTFJSEtNTGNuUHJYU241dVJzbEwvR1hpa2Zh?=
 =?utf-8?B?SGxlQ0EvVDRBL2hpVUVTZ1hFTmQxTEFHelFUbFpZZGRqK3BNZVNrWUJWTmNS?=
 =?utf-8?B?OGlvd3ZtblQvdnlTMTc4NHc2cjZWWFJGb041UnRzRFpxUStxKzRRdnpKQnFC?=
 =?utf-8?B?MEFxS1hKRVFCOVlrYTdEalhZbUNXNklDdHFhcXo2QjhJbysvcGhjUkZyVkFB?=
 =?utf-8?B?V2RsYWFMV0ZqZGtXSk9HWVo4c2RRcHRQU3Y1U3UzNVNmYzBNaERTV1ZkNnM2?=
 =?utf-8?B?ZDFXdlpHajk1MmFza0hjK2RraFREZDE0Z1FkelYyOFlRQ0JLR0w0TGRscjhw?=
 =?utf-8?B?Vko0VWdZQURyTksyaC9PVzFKa0ZNNEVwc1l0N0l2RFhrbGgzeExOdU5ua3hB?=
 =?utf-8?B?V09tZ2JKMkNhMGhhcnQrbHFXSGRkVjRoSU5qaW4zMTdNWVovL2hxU0R0R0JS?=
 =?utf-8?B?N1BSQi9KQU9zYWJnU2YxdDFEMXBzZHYvdmRnck82RC8yaE5mVlVwUUsvTVRF?=
 =?utf-8?B?bXJuNFdzQkUvUVFuME1RUGxLOFJZUnVNNnNNd3U3UHU1Q2VQNldQUTE4MUU3?=
 =?utf-8?B?Q0YyL2Ywc24rZzNZMmF0Q1VlRXZ2UXQyU3RLVDgveFhiNmtJaUtpYkE1bEdO?=
 =?utf-8?B?UEpUcUlaUzI2ejE4MU9qMVNxL2RSclJ5aC9vV1FhbkJUY0RwTG1LMnU3ZEto?=
 =?utf-8?B?c1BtMGsxMm13bTZ3ZWhTQm5leWNwOUNzNTVQYU9WaW5rOFlZcUx3VlowY0JF?=
 =?utf-8?B?MXZRbEV3L3NWeXRSVm5vRkZIelNLTEJxSWxlTk5JOUhYTGVqaWNIMk8wT0d1?=
 =?utf-8?B?VmYydXByQzZ5Tm5TcXJTaGZsb2NPVldIYmp4OGxQNnZJYUdIUVZBSVlmZm1p?=
 =?utf-8?Q?pR9xy9sT4UNkT+Y0Ee4zp7bpmtcFuuuuxVeuQi9rtzid?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60ea24a3-df90-42b4-dac6-08de3eec25c3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 10:48:30.2429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EV7gj4w5Kn6/nyru0Nv4C3InPSQrWs7+DQGLG/9mAVghRE0bbOtRGjsmNgkDi0F4bQYBtHJ3TID0d56LBMjR9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5973


On 18/12/2025 18:57, Nicolin Chen wrote:
> On Thu, Dec 18, 2025 at 08:48:32AM +0000, Jon Hunter wrote:
>> On 18/12/2025 06:32, Ashish Mhetre wrote:
>>> On 12/18/2025 2:13 AM, Jon Hunter wrote:
>>>>> +    smmu->impl_dev = &pdev->dev;
>>>>> +    smmu->options |= ARM_SMMU_OPT_TEGRA241_CMDQV;
>>>>> +    dev_info(smmu->dev, "found companion CMDQV device: %s\n",
>>>>> +         dev_name(smmu->impl_dev));
>>>>
>>>> This seems a bit noisy. dev_dbg?
>>>>
>>>
>>> This info print is similar to what is there in ACPI path as well.
>>> It's only a single print per SMMU at boot time. Should I still change
>>> it to dev_dbg?
>>
>> Yes, I would.
> 
> It's really not that bad IMHO, I am not against that though..
> 
> If we have to change that, we'd need another patch changing the
> one in the ACPI path as well to keep things aligned.

Regardless of what is already present, does not mean we need add more 
prints to just say everything is OK.

Jon

-- 
nvpublic

