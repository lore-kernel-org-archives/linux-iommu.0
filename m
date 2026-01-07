Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010027.outbound.protection.outlook.com [52.101.46.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F536279324
	for <iommu@lists.linux.dev>; Wed,  7 Jan 2026 06:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767768286; cv=fail; b=VP1LsYjIckB3hMH4kg7Ruul2AM3eyi/w0qbinDCsnawFRkxZk1QPj7Q/Q5Uw2tglD0TcFVBs/fGRoyfPko+fz1UNU7zQZK+8kiLGB6rijUGl9shLQTMVgfpzfGRaoUOhBKrodM2Zg5m10KZl5y1QPJR8CPHZfbpYp9DVWM+LOT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767768286; c=relaxed/simple;
	bh=LLlROvYoKfYDKqGIs5V+gfxkYxHDsZQmdIwM2ZcTGgg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QD00pWRZiY4ZIqI+mHvrTbgbz7hyUsktK6wlTAH/99OXY/VZB/NH1H/JvPFTZgG5H8nBzn8nX+7WUMWXkSTdSVB1+CfbEzS5pCyE3KbUeINxIWSPuQKbt87trwCSzwylMbneFP3X1VWa+sjQwq+xA9AZU4U2xfwiY680zzEGBAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ueVYkQ+Y; arc=fail smtp.client-ip=52.101.46.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ueVYkQ+Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q/4rrhOam4bZl3GKfrJj6j+RkJluuyVbuupERVsj965iOL14tpIFyuQjjppB5b9KqdBxjDl9L7YYCzXepKNhKk0xG0vnokS31XgYVtDT4PHg1HH1RerC8FP691n9UyrN2PQG4aFPLBQ2V2loOKZjf/aZQFLeps4zclnxtKg/WxTlnQby0/K38CsK3r4jybliR5FvjYZAxjkXfYclwVHmva2OwT+IWHtE1CTRgojmf/j1Re06esyhUa/Yx/mmEAziVdM4c22x355BRNYG7WxazG1zB43RLYrDH7DTbfWZxtdMPgnAEtePUartbBT2IRRFUIvy2T/v4CIOgllsBzanyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kO5XU+Dy0eTKigpKZ87+OcBHKhy2me7OvPbcCg9U7Rc=;
 b=QzMu0UnkWeaRVtv4K07vr0h+MgUYmbspuzsLwiAYDxu0z3Vlk2U6+4yit+c+aIXvaAPvaOXeiXNKZ9fYSUW+w/SM+Ped3dPkpMN4s2bCJaEgyapSkAXjM5xGsbqIY108QEsO5doeLeMiPyXrOAFUNpo49aCAxA3caxDqTZOrYT8vYDcwhdW2o2vCOl9/WU7UXsOf7Aa+040ARPMmyTQ/ufqzu+d2uI6Yal4A8MC6gWGhD1wQI6f8XyT+GxxLsvjzfp6+hb3HVQfKx4HymAGKXaVEbbaZshxIKH/hV7kQ95fHKWI6TWevQ8wmuelmd6/WHzawTnr1b82jn+Effosjtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kO5XU+Dy0eTKigpKZ87+OcBHKhy2me7OvPbcCg9U7Rc=;
 b=ueVYkQ+YujnuAk9EziyqPorUkh0ZtmGNTiogY7p5UH3PfHTaiz+th3tD53hS3hW0nw7Tkhx+S5rL0av5X2VQE5XX5SOJL42cWJW9Qco8w6qh4uRSASy/q/bGRpDkfP2JIj0wa+sXHpnHoDNJol2hJB3uJZHq+yxVTxRTklscm/TQzjyy1Af0PDtwH+PLn2jnZDx5FNKS/7VSRKC5NYc6FhWImgVQwDfZI4OzVxkV5qeXannLyS3dTme5Uc98Vu9cFCSpVz+A+FJaQMRJ6vJ2CxHStowIeU+20gg0sLNb+p43c+b5vJ4ZwHXNZsKHOmoiVoOT8CUdARvoTGP05GMguA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN5PR12MB9511.namprd12.prod.outlook.com (2603:10b6:408:2a9::14)
 by SA1PR12MB7410.namprd12.prod.outlook.com (2603:10b6:806:2b4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 06:44:41 +0000
Received: from BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c]) by BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c%4]) with mapi id 15.20.9478.004; Wed, 7 Jan 2026
 06:44:40 +0000
Message-ID: <69e11fa5-558f-4fbd-ab3e-e8f3b8197df6@nvidia.com>
Date: Wed, 7 Jan 2026 12:14:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 2/4] iommu/arm-smmu-v3: Add device-tree support for
 CMDQV driver
To: Nicolin Chen <nicolinc@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, thierry.reding@gmail.com,
 vdumpa@nvidia.com, jgg@ziepe.ca, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20251215064819.3345361-1-amhetre@nvidia.com>
 <20251215064819.3345361-3-amhetre@nvidia.com>
 <23df682e-6d08-4827-994e-1bbd89e5c903@nvidia.com>
 <5e9a0ce1-a0ba-4a31-be95-99f349ec6028@nvidia.com>
 <e7d3e95f-a885-4b13-ab4d-bc82793c5396@nvidia.com>
 <aUROk0jRQoLmBRo3@Asurada-Nvidia>
 <b2df8ce6-d336-457a-8169-f2eccec3c12e@nvidia.com>
 <aUWeUapsFo3KZP7i@Asurada-Nvidia>
Content-Language: en-US
From: Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <aUWeUapsFo3KZP7i@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0130.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b1::10) To BN5PR12MB9511.namprd12.prod.outlook.com
 (2603:10b6:408:2a9::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PR12MB9511:EE_|SA1PR12MB7410:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ca5531e-e96d-4579-61dd-08de4db83bc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ckVTQnMzVHR0Q3ppWHVQSmRlRWJiTGh3YlJNTDQ2RC9iM1BBUDhrZTNpcTBn?=
 =?utf-8?B?WVgzZjhjWG5tNkp4TExORTBIc2RsaWtZdUNPVXVSa1RObTNLNHd4aGlCVjdS?=
 =?utf-8?B?eDBOa3E4V3paT05oNW5qQUw0VFNtMjV6c1BIOHVJT3hQaGRYam1LbHRYbzFo?=
 =?utf-8?B?K2NnVEtvYWtLRmhaZjVzVnB1R0dMSkg4MGQ0QURWZ3VWcExiYW9DNUJxMEp2?=
 =?utf-8?B?TjJjWDJmelVsWWlkLy93YUdLNnVrbnp3L05VSEZXQzlwbVBTY3BXd3UrRlky?=
 =?utf-8?B?b25CaWtYTzRFTDFXaCt5M0RuS1A3eGlFaEZwUkwwOVJuRUhEd2gwd3RqaFZo?=
 =?utf-8?B?eERUMTZzb2hVWTRLQXZHdVVLR0gvOCtLT2FyYzM1NU4rNzh0V3JVVnM0Tlpi?=
 =?utf-8?B?Zlo2ZnhOMjRsWjNvNjNaSlpWSEdWKzUydFBrMFJNMkhiMW5JRldCeHo2eDhk?=
 =?utf-8?B?dnhpYVo0VVlKYmFSditqV0dFL2F2c1JKK0tCUExTNCs3NWRtZDVRVDhocnNR?=
 =?utf-8?B?d1RmdEp2b1VuaGNQbEQyM0FmT0QwK2FQeUxYRHRiUDBSOGE0TWxjbXc5WE9Z?=
 =?utf-8?B?elRtcjlrcDhvK0lQbGdMakd5S1dqRGMvbThLbTQ2UG12eXcvbmk3bDlIOHZK?=
 =?utf-8?B?TFVzd1dKeTRjYldJcXdlMGFnNUxaYkNCVTVwWnJVYjU0dG05NkVRVnRlUzJz?=
 =?utf-8?B?b2F6bjJPaTljQUxDMTdNNENuWUI1ajdDMGZIUjBma25UeGgrRGRJa2FSU1VE?=
 =?utf-8?B?ak81dFBROXYvQ3JaaGhsUEwxaXo3WnJPOXNiOHZKN005dnRDeG95ZTY4MElu?=
 =?utf-8?B?VWZrT3FSZDh4c0NZTmVhL1MyVUNIL1FUQ05ld2x1S21McG85QzlLZk1WWElU?=
 =?utf-8?B?eXExN3VKTWNPdnlpZUZSVUMyM2ZRQTZOQ2h4RWlQTCtRUTV1Nk5ZSU1SSjlh?=
 =?utf-8?B?WXlRRTdZNERpaTlvRGttSmltaTVJcmRxRXZuZHArY21jNHB3bGFFVEp3L2xC?=
 =?utf-8?B?ejRrZXBSVGVZSmU3VUJDOThsdDQxRFFkV2VLNHlSK1ZxQm13VG5FTGlSb1l6?=
 =?utf-8?B?WWdyNCsza0tlazBDSWpHMmFqQXh6em5HVDNYZWsrZElXa3hpV0wrN0tITFI3?=
 =?utf-8?B?OG9ueXRmb1Bhd0R1WDFKalh1OElXR1pTK2tFTjBuRU5LYVh2QUVLYzhqMnpP?=
 =?utf-8?B?Y0V0aGJXUGxvQi9tSFk4MG45NkVMZGp2bWhHZHJpT2xoY2t5R0Y5UEdDb2Fz?=
 =?utf-8?B?Ulp5bWNSM3Nka2xGYzlqYTRqTHUrNHRsMVE0NjVMOS96K1lUKzVlTGc3Vkh4?=
 =?utf-8?B?RzJkWWlXcVh4K1FWMy9ZenUvZk5FZHZwTWlUbWJ5SE5Za3duUGt2bGdSdTlP?=
 =?utf-8?B?WE5QY09FZ2IyU2JlMFF6SVZYYWpXdUdaZkFZK0pVcTVvZ1d0bXZ5QzUreTV5?=
 =?utf-8?B?WlR1UGd4TXpveXQyVGRVc0tHMVJaYUVNM3BCd3VJOEllUG1SU1ZBNkFLQmtE?=
 =?utf-8?B?ZWpJZ1JVRm10QVcwSWJBRms4TXA3ZERQTytlSHZKbElGUEtGVFNRbmJYaG1m?=
 =?utf-8?B?TkNObk43ZytTRXFYeWFQRFJSbEZPSmEvNEVPWTltRFZXQXdkQWFjMk1lL05R?=
 =?utf-8?B?WktTZ2hkUmY3M2lVOXNLZWFxM052WDNPeFZ3NlV5QW12WWlmelhiV0M2OWVp?=
 =?utf-8?B?NFFvZy9qYnFUVmpzZGlqZVE1R2tUTU93cXA0MllnWnh4Y1VNYkQxd2dRT0w0?=
 =?utf-8?B?SUhvZ3FRbyt4SXJwTmhrbmQ1b2QxRzN4RUUxSW1hSnEwWUJ3MFo4RnFBd1hU?=
 =?utf-8?B?SWo3UFhPR2NUc1dnUWJFSE1SZzFqYnR0Q0U2dGxjMkRGRy9QNE5WdEhyZVpF?=
 =?utf-8?B?c1BHTndwYTNRSzE5TW44UDEydHI0cGF6amJ2Y2Z3WVhXUVNxcERueUx3MXFz?=
 =?utf-8?Q?s2488NCyufozalbj0tMt6cqnm3TQPS7R?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN5PR12MB9511.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGRUT0I3MTJCTGZ5RTVhbkpsVE1YZTdmU2tUTm9wVnhzK1RlNFg5OVltUDNn?=
 =?utf-8?B?a1NoQ1EraTEzcE82aXpReUt2WFlhMEdneDE0bG1zQktHSDU3ZldyMzRKQTN0?=
 =?utf-8?B?QVhJcStoUG81a0FsUHhJN3NlY3lqRGVkTnpJSzVQTlJYZU10aWNvc0l0Qi84?=
 =?utf-8?B?cVRGbUsxdGR3NVdEY0ZQODA4d3JKRlROVk1YZkV5WGhyWmhLajJicXV6SUhC?=
 =?utf-8?B?anRWN1FnK1I1WTd5R1BsWkZWbnAzZXlvN3ROUUZlRVhnbHdPRUE0T0JLZ1NN?=
 =?utf-8?B?M3ZIdDlBTk1udmxCRWZ4STFxVkZoRWo0RVpwY25tN0JDMHNkQWpIdGNsSUVl?=
 =?utf-8?B?YXljVTJ6aXF6MGRiTzFaYVlCbWh2U2xIVWVkT3JycE9iOE9jYm94eDgyTHNX?=
 =?utf-8?B?NXlXa1B6R3htL2tzQVArb3MrQXlkWUNUQldiY0pDaVZmVW9VVFpUd3U4cCtm?=
 =?utf-8?B?dGJBQlBYMlJnNHVJcXBaTC9wOU53c1NQdGpYQ043YkdWdTN3SHJyb3ZEQzkw?=
 =?utf-8?B?TnZCcTJTeFFxOG9kTzJTSHU3ZW13ay9SU1dtUDNhUjN6T2JxM0M3OG90OGJs?=
 =?utf-8?B?VFRadkg5eC80ejRaWmEwbmtHV0M1SE11YVFCT015RDZEV3RORVB5MUxCOThl?=
 =?utf-8?B?YzVJbXk2SHdPM0hhK1BRRktnM3pJQXhHZ3VJbjFZVFVXM1g4dzcrallCNUlT?=
 =?utf-8?B?RVk2ZitvTkJ1U2NFdHZSRXN2Y1FFKy9YeTR5U0doRkdXa1hhVnNNa1hVajgr?=
 =?utf-8?B?WmZWYmxlM094SzIzZjUrUGE2b2h4KzFYU1g5QjB4QlVKaHpCY0pMSVd4VitH?=
 =?utf-8?B?QWozK2xXdE0vY2ZpaEpwUWZWRjllcXV4MnY1VzhqODVhamNNR1RGTjUrZjEw?=
 =?utf-8?B?dDJnMTNSaTlvWEFiZFB3a3FIUmRocTVkWTNYU1BpVnVqZm1aUHY2alUzT01u?=
 =?utf-8?B?aGxwSXBEUDc3VUtPNUp6SS96cG9xOXVDOEdQRUxtZ2ovYUZNcGtJOU5MemVT?=
 =?utf-8?B?UlVibEtmdDJRbGJlclRabnR5RTQvQ1c2NGhWcjEvQngzdmE5R2JKakZ3eW85?=
 =?utf-8?B?REE1aUp6dm93TmRPT1JjNEJQdXo5Y2lUbVVDWjlHdEZVK3hkWUtGdjNBUmxS?=
 =?utf-8?B?aW5qUnU0QldEYnFrSGE1blN0Y3lqSTZ0bDZaZS83NzBTTDg5QW1UZUpMRlUx?=
 =?utf-8?B?cThuMExCdkZUQ0RzSklaQjRwa2ZVUlBKcEtJajVRWFlnM1laK2lDV0tuNUNN?=
 =?utf-8?B?WFdleGc2Uy9ESlBIbzlhOHFNUU1QUWZ5RjRNaDlBZXg4dGlhMDdqdldtWmVP?=
 =?utf-8?B?eEU0WUxIdEsrZUlONXdkUDNEWWRMUFcvc1pqaXN3NVdTSkhFeWJGM0Fpc21B?=
 =?utf-8?B?WEpqYWpJM1RwbVpJQUs0U2xiakxGcnQyNklsT2tQYkRPSVJQQTlhS0xvYkNI?=
 =?utf-8?B?eTEyb242a1J6MGx5VkNLT1k2cGJmOUlwMFlWWEtsRHJlRHFGUHhHbzRiVG96?=
 =?utf-8?B?cnBFVWJHKzVQdW9Ec1pNQ3VDMURMVDkvU01VdjZ5VkVTeWZDTkluVTViRzhi?=
 =?utf-8?B?VGJvZEx2UVFsRk8xd2JhKzRPV0dPbklQc3R2Qm42MExTb2hoYlg4QTNndTRJ?=
 =?utf-8?B?emNocmZXTCtSekM4Z0twS2Q0cS9NKzNTR2xNWGtTRHd6SER5eTBPWG5UanpK?=
 =?utf-8?B?bFI2eUxpVHg3MnEzVzVmMXRKaWNZbE9xMy9QMGxBRXZvM21tcEZoakNJYSs5?=
 =?utf-8?B?bzduRndxTjREMmJ1Rk01Qi9hbFU1MlUzaXlSRXp5UTh2cW1zb2JNR0dSYUFq?=
 =?utf-8?B?aFR4VDVjdlNjSllEZlFaYmpRTVdJQlVESEcrcmIxRHNHWVd4R1hOZUU4Uklx?=
 =?utf-8?B?RStJVUdTOUEwLzFsbXh3QWhtbUU0Z1ZhaDh4Q2drR3JvRFpvV3FXMlF3MDlL?=
 =?utf-8?B?Y2NoZGQ1b00zSUE5KytWR3FRbmxVQ3lMUXJ3M004NTRValZCWVYzWGU4UDlr?=
 =?utf-8?B?UVJSTEVOZ0RnUytXWCtuZDAwZUNrbVYveFFkeXJlbVhTdGxGQ1RwN2p5THlZ?=
 =?utf-8?B?eTV6T3Z5RW0vWVlpV2N5Vkp2T1BzZFkxKzFVRWFZYUF1VUNiUlk4aTdqWFdB?=
 =?utf-8?B?cE1ldE9PT1M5cXhqcUQrMEZJRG9SL1pwOE8wemxNZGtmT2VyVXBOck4vRDNK?=
 =?utf-8?B?Qnhua0pjYjdVMEZienhtSDdQaEtaYkR0TGxjb3hua2Q1UFJnK3hCaWYwZjFo?=
 =?utf-8?B?bmpzWVp5S1U3Zk55WHRFeGhNNitaNy9pRUtscnlFVVg5VmorUWVTbXhLUDNT?=
 =?utf-8?B?V3dIZTBDdURqNkpjRXpYYndzWHFTSUhFRXBheTV6Qk40WEhmVkhyZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca5531e-e96d-4579-61dd-08de4db83bc3
X-MS-Exchange-CrossTenant-AuthSource: BN5PR12MB9511.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 06:44:40.6186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0VnuISZhZRhaT6AQ763zChIAz/hkFc8pQcxWdPb7CVWF/kHiSRU1MoXotg26FaLlekAwlq90ni34EwX8ezZi2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7410



On 12/20/2025 12:19 AM, Nicolin Chen wrote:
> On Fri, Dec 19, 2025 at 10:48:22AM +0000, Jon Hunter wrote:
>> On 18/12/2025 18:57, Nicolin Chen wrote:
>>> On Thu, Dec 18, 2025 at 08:48:32AM +0000, Jon Hunter wrote:
>>>> On 18/12/2025 06:32, Ashish Mhetre wrote:
>>>>> On 12/18/2025 2:13 AM, Jon Hunter wrote:
>>>>>>> +    smmu->impl_dev = &pdev->dev;
>>>>>>> +    smmu->options |= ARM_SMMU_OPT_TEGRA241_CMDQV;
>>>>>>> +    dev_info(smmu->dev, "found companion CMDQV device: %s\n",
>>>>>>> +         dev_name(smmu->impl_dev));
>>>>>> This seems a bit noisy. dev_dbg?
>>>>>>
>>>>> This info print is similar to what is there in ACPI path as well.
>>>>> It's only a single print per SMMU at boot time. Should I still change
>>>>> it to dev_dbg?
>>>> Yes, I would.
>>> It's really not that bad IMHO, I am not against that though..
>>>
>>> If we have to change that, we'd need another patch changing the
>>> one in the ACPI path as well to keep things aligned.
>> Regardless of what is already present, does not mean we need add more prints
>> to just say everything is OK.
> This is how it looks like for each instance probe():
>
> [    2.709269] arm-smmu-v3 arm-smmu-v3.10.auto: found companion CMDQV device: NVDA200C:00
> [    2.709273] arm-smmu-v3 arm-smmu-v3.10.auto: option mask 0x10
> [    2.709618] arm-smmu-v3 arm-smmu-v3.10.auto: ias 48-bit, oas 48-bit (features 0x001e1fbf)
> [    2.716236] arm-smmu-v3 arm-smmu-v3.10.auto: allocated 524288 entries for cmdq
> [    2.719432] arm-smmu-v3 arm-smmu-v3.10.auto: allocated 524288 entries for evtq
> [    2.725898] arm-smmu-v3 arm-smmu-v3.10.auto: allocated 524288 entries for priq
> [    2.736051] arm-smmu-v3 arm-smmu-v3.10.auto: allocated 524288 entries for vcmdq0
> [    2.742553] arm-smmu-v3 arm-smmu-v3.10.auto: allocated 524288 entries for vcmdq1
> [    2.742586] arm-smmu-v3 arm-smmu-v3.10.auto: msi_domain absent - falling back to wired irqs
> [    2.742759] arm-smmu-v3 arm-smmu-v3.10.auto: no priq irq - PRI will be broken
>
> On a second thought: The CMDQV device has a very unclear naming in
> ACPI path: "NVDA200C:00". So, printing it gives us a hint for any
> later warning/error tagged with "NVDA200C:00".
>
> Now, for DT, it might be okay to not print it. But making the two
> paths asymmetric feels odd. So, is it really worth nitpicking here
> given that each SMMU already prints quite a few lines on probe()?
>
> Nicolin

Hi Jon, Nic,

Shall I keep this print or send a new version removing it?

Thanks,
Ashish Mhetre
