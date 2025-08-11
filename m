Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F187F2E266E
	for <iommu@lists.linux.dev>; Mon, 11 Aug 2025 18:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754937092; cv=fail; b=qnNgP8LnypFHDm3M5a2nSTzpgkWMXw50cem0VnB3Xnf4sddcfifTcxfUOq6WWyWX7JPRfGVhboDfCLQDq6+khTjmQHG9QEbJcxf1BimzWxpjxyZ6c6LbEWAWUtb8ABgNeW82L8HrofiE+sWPGfb/5+u4h67qRjPxp6rXBJXGXDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754937092; c=relaxed/simple;
	bh=W7y4EH379mwjdGjYKDQKpbAllPbV+zSDnj8n37dZ1Ow=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d+hgPI/BMg/GpM6yUtyPYLlrYTcNEat7RV2YUotff1rAfONOm3uDctslie35Hmag8EANI9fODZC+h2L+SqZVdSq6ghkoysB9e422oqZpSakwuFF3xgjxWULgtiN5YT5A7VW6jmt0hzupmNZxNgsNSh/Jwa5mULsfTUhnZrVcs/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C31jR0CB; arc=fail smtp.client-ip=40.107.223.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C31jR0CB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MRiDXd6R3rWMbM4e6KNEoLihOqNlc8bhGkZBz8Jsi9gv2doNL11C/yMAwclFV9iJn6XlISJVTxICdrTijdUQQ91cFCLlqqQIFzsZ49GSdbLExK3wctC5xwKJULIFpJ6regwQnsuo4tjoS7xKndGdVOVvUHm33xvOp2KxSMhUeEGOJWS1VBOoLhj8QWXbsbUXW1xeoZXWqWTaOUiYgHyxsiEmqO4X/RGF2GauDCbQiktrh3CiU3ZS7ciOHkjrU559xbKlm4UnoWhlwH8pF034Bx3mRMp/RqkJXi2ohwbRTaUcfx9XWd9214sfhjI4Z6qwPi/05D9HPWWyMoLbfQNmMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+MFSWZmCwc0BBSyJNPtZ+/ZiiA0idXhbTXgc+jzV7I=;
 b=iFjv9QLpkWEnpfJS/81c5ayDyeieliGqe3OBoMuNQ54o+XPsqF83OwroWnuirVhOACx0vUQULbdq5CSbP8iCRaFWAIcs0cL7W4CDHTbgn6QfrHZtagBYYW9o/TqMoXSow74hFw+F4orduGZYZrV2Q0/XbRF6O++8hUpnHQRDIWGsvzURnjtV60f9LbZZMsIZZ9P/82cMWtkw5P7ZD+WSUlZ4jgja1QFynO/oXCqI68RufQhYzYu608+e8oOZCJ44vuE/y/2Nj2odD/UYmUdRt4l1i/shBEPAQMhAY9N5WHlUvAgGYdN10bm9fTCzXboqsvQB091Sg5qk8nb7wTCl9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+MFSWZmCwc0BBSyJNPtZ+/ZiiA0idXhbTXgc+jzV7I=;
 b=C31jR0CB1AQ1WWOU+ayty9PQkeKKdqrlxsHhfwODk3QYA9lnql5Df/AAnN2vOAg5AVlRSPv/guqZlQfzOKDtl2bBy8F+XA0b8qhgH9abWPd6LGURyKV3Iam8yrbgXQjROuqVmA+kxTH8RWM8i20Zyfoh0zU6I1yQQ+5Y7Wb7tFBWVUVTr0L/welg/k6O6bKtK5ppnQ7qbmRiQ2NvHMn1ROlWFkJYNwVtTtH2B187lCaWRDbwZ6zaOZe8xtk9MPox2ELZ2ogVJzNGxeqdVwJbsT0jnphSY80p6BZVUhzpsT3mNMQPGcuIg9Chbh+6O2Z3ixLpkNzGnPGasc2+trxvXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6606.namprd12.prod.outlook.com (2603:10b6:8:d2::20) by
 SJ0PR12MB6688.namprd12.prod.outlook.com (2603:10b6:a03:47d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 18:31:21 +0000
Received: from DS0PR12MB6606.namprd12.prod.outlook.com
 ([fe80::ee84:cbaf:9af1:3f5a]) by DS0PR12MB6606.namprd12.prod.outlook.com
 ([fe80::ee84:cbaf:9af1:3f5a%6]) with mapi id 15.20.9009.016; Mon, 11 Aug 2025
 18:31:20 +0000
Message-ID: <6cbd85bb-66a5-45b8-aa91-f78958833e4b@nvidia.com>
Date: Mon, 11 Aug 2025 13:31:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 1/2] dma/pool: Use vmap() address for memory
 encryption helpers on ARM64
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Steven Price <steven.price@arm.com>, linux-arm-kernel@lists.infradead.org,
 Robin Murphy <robin.murphy@arm.com>, Gavin Shan <gshan@redhat.com>,
 Mike Rapoport <rppt@kernel.org>, Vikram Sethi <vsethi@nvidia.com>,
 Jason Sequeira <jsequeira@nvidia.com>, Dev Jain <dev.jain@arm.com>,
 David Rientjes <rientjes@google.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
References: <20250811005036.714274-1-sdonthineni@nvidia.com>
 <20250811005036.714274-2-sdonthineni@nvidia.com> <aJonrTrr6nW7qdLI@arm.com>
Content-Language: en-US
From: Shanker Donthineni <sdonthineni@nvidia.com>
In-Reply-To: <aJonrTrr6nW7qdLI@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::11) To DS0PR12MB6606.namprd12.prod.outlook.com
 (2603:10b6:8:d2::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6606:EE_|SJ0PR12MB6688:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a6fb3d6-fb3d-4887-94d7-08ddd905447d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RXFOVlUyOXlwUGlSS3R0cjJmKy9JcTFoaDdmbS9CK2RlVGEveWRVMnhiVERp?=
 =?utf-8?B?dlNKUjFocHBNcU9GY0Nwc0pqS001WE5YS2w5MHRHbTJjempJUmZwTVNXL0Zo?=
 =?utf-8?B?d3NqcjhmcVEwdjQ3a2lJd3hieElGRUF2T3Q1NURaK2szMUJPb3pJazN1cGU4?=
 =?utf-8?B?czMyL0ZPR28xTkk2cDUvYzJXcitReFdISktieEZZREtoTHVSSjZMZTBQVFFo?=
 =?utf-8?B?MVBvSFJsK3pUcFpxdTNqWll6KzlTQXRWeFYyeHNBMnlrcDY3SzhRdm9GUnRq?=
 =?utf-8?B?QTFlRjNlSDlhN05tK3FYZFZ5ODIyUUNFM21vQnpnVW9rdk5uMzNXcVhyYkFj?=
 =?utf-8?B?MFQ2NlIzNDVlYVVKandYay9sSGVBYS8wOTNzU3lEVmxTTjkrT2pvQ1d0VVhi?=
 =?utf-8?B?WEdUTkZuQWVaWEhCdnFjc2taZklVQnpKL09xU1p4MDloekEzbUhTSENtdklM?=
 =?utf-8?B?cTBkeklnTzNvQ2JzV010RjBWcFdGRUtTK2ZmMG9qY2xKY2UwbzJCYjNINzFt?=
 =?utf-8?B?UmtnQTVIRG80dEplc2NQRm85MHJoOVJnVG9vSVQ4OXBJa3NCbkJ1Qi8yWXBP?=
 =?utf-8?B?b1ZTc1liN29pK1BwQU5scWRDa1psODMxU1RWc0JteWpCMlp4bE9VSmo4SFI5?=
 =?utf-8?B?WTBCOGlSWmN3VktNa29IT1dnbG1mOE9laHVIcmlNNzZOSnZyais5NFpHT1Zq?=
 =?utf-8?B?M3FLSGs4V1NsZnFEcXd2OGhUb3JRTmpKOVppMGh1RWlBL2hJZFE2SCtIdjFj?=
 =?utf-8?B?K0xmUEFaUlpyZTJ5aFdLTFU5YlRsdkVzdjMvL3M5aDZNMEdyaFAydHE0TE5a?=
 =?utf-8?B?RC96dnBiZER2UUJ0VGdJMFlQVGRlYlNmWDZHRDMzYWZWY3lrcjlvYTNsd09S?=
 =?utf-8?B?VnYzc2ppSExHem40YnV6eGN5aThrT3JCYnV4eTdFZzRkWDhITDZ4amFydTZm?=
 =?utf-8?B?eWcvYmZYUWI2aENDTi9UdXVLQXFwOEJLa1h6UGR6d1FPcWZ4cFdzSjRCdlJh?=
 =?utf-8?B?cGo4RlNxSTMzZFcvUlYxM2RJMGY3VXZDL2FKbms0OXZEOVlCRXV2eVJDTlN5?=
 =?utf-8?B?S2tSajAxcXY5SUJsZ0U5Y3ljcHdFSndBdXpKOU9wRUpRVndPd1RvUHZic3BD?=
 =?utf-8?B?MkhJbVljQVBpNFppYlFRbU9ld1EyWUo5QjJLQVNUNlJpdXBtRVFJQWJaWVJR?=
 =?utf-8?B?a2R1aVVVOUVYVGhncHVuRUpNSWpFSzgxT04vVnBKZFZJbEJkeEVpeHB1d0U4?=
 =?utf-8?B?MysyU09RS3d2bm9oSDNvRkhaWk5GWDBHTlhJZzRSdEZYajFqVkR1WGMreGVq?=
 =?utf-8?B?YU9PZ1NLeFI5clNUMDYrSm5Ram51ZjFLUS8wZ1hBS1RQRS9CREpZTWlERE16?=
 =?utf-8?B?ZmVuVFB1ZFRIdXp1aHFGY3ZZN05ON3ljK0t6SnlSQWZTS2cxbGVPN1VNb2Jj?=
 =?utf-8?B?RGtoVmRRS2tOaEduVVNlWjZQWlJUY0tXbXRTVldDcVAxR21ISlpLbjlrY1lY?=
 =?utf-8?B?TTlSMHduSEVlbEpGaGJ4YXBsc1Q3RDdkR0w1eW9qNFFjNVVxVWxFUTR0Y1Z0?=
 =?utf-8?B?OHlWMmYweE9zQVAvMUlwWUhmWWhITzFJQ0FEMW5WRG9xdnJJc3VTYjdLdG5E?=
 =?utf-8?B?SVgvMFk4S1YyT1FIeHZZLy9OK3g2bWZadkFZNU1sNnE0RFVUelpzYUZQSGxp?=
 =?utf-8?B?dDFacXhEVUdKWTg3eGQ5Y3ptWld0UGd6bFF5SGpsZHFpbDNaRlB2ODZ5Q0F0?=
 =?utf-8?B?eEhmQS9BMkxqa0RHaFVNUFRXK0tiTitiUU1vL3lkcWlsSHRHYmlGS2g3cWd0?=
 =?utf-8?B?UC9MNWk1OHV5OHBtMlRDeGFCZ3VLZkptcERoU3dPR2pNTEIwam42Si9NQ0dW?=
 =?utf-8?B?YlIweU56aDE0SVBKVEpoZ2p4blpNb2dmMVpPa3ZhaDQxK0daK2tmanBIRzU4?=
 =?utf-8?Q?iFyXPkushrw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6606.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qkh3bUVSSEQrMkNGTzFwdjM0b0xvUGZ3RVBpYk9UdlR4RUtHN0tHaUJFOTFq?=
 =?utf-8?B?b1Rna254NE1JWmNoTEpZTnFzaVQzc2FnRDRKaTBURmJZY1ZGeWU3Tm5TSW14?=
 =?utf-8?B?cXpNUU5aeDR2ZHdwQjFwcUdHRlRaZ00zYzZweVFESmxOQjNxSzlxSW4wR3Vp?=
 =?utf-8?B?S21pcVNEbUR1MjB1WWo5YjFYZ3RBTy8wZ0ZucDRqVFJLcjV2MzBTOEtnMStP?=
 =?utf-8?B?WWJZOVdCUnBKeVM3NElzcUlWaHJ2WWZsSkFZb01SQUZGT1U0clBxWld5TmVF?=
 =?utf-8?B?enhRWmRVNFhYbkVGQXB5M3h2U2UrQ1N6QzFCVUtneWlzODVTbXZEZGdqbFVI?=
 =?utf-8?B?UWpPZG1rWGt5eFhOZ0tsN2lxM2thSkVRTmFCZ3U3WC9zcEQvcnhHV0JOa3VI?=
 =?utf-8?B?K2JqTDdPUUNUUWwzVjJEQzVFcWI3Q0pXUFBRTlliNzl4RnliZ3d3SlBUUWZl?=
 =?utf-8?B?VXVMUEpBbXJwZGJlY0JweWxuYnlIeFpzNDl5VXl6SnNQSkFXN0FwQThUaUdT?=
 =?utf-8?B?RHNPb0xhWWlsVkVYR0RwclM5Nlg2OEtUWmdWRWk1c0p1QUhYRDBtc0d6V29H?=
 =?utf-8?B?OUtpWFN4VjAwUEMrc2xIVlFEQW1BRUR5TGtTYkwyeU95Y0ZzY05qa0xtWXRk?=
 =?utf-8?B?SWdHUjFUTk94WDJtSmlTOEQxS3B2WGwyUEpnSmRqT3Q3UUt2MU5wK0E3TnJy?=
 =?utf-8?B?VzNxWFUxM1c3MFpPc1l0cTdGUFpKaVJPaGRmVVBaLzRrOGN2UUt6dFdhcTlm?=
 =?utf-8?B?MnVpbGNiK01leVJnNjVnaGVMcmgwWEZNS3hlYTVWMWtOVThJU1FkK3RIZmJ6?=
 =?utf-8?B?ZERmL1REYlFaZERWNHl0ZWg4dVI5MmdSQW1FQ3pvUE5TaVJEUTlka2xMbXp1?=
 =?utf-8?B?Q1F4YjNDaFIxakVWayt6dEtVaDE4cXRuOENjaFRFTmwxVFVUME1IZFpTcmw2?=
 =?utf-8?B?SG5qcGV0anA3em8yaDZaUlNjTU4zeXd6aFQ5N2pFK1pQb1l4T3Z0SXhGREla?=
 =?utf-8?B?UkVvVlZpcm16OVd1K3AxWjRZQVVYakVjTDVWbGhQTG0rcE5yd3BZeDVCR1lD?=
 =?utf-8?B?V0ZMbDFMbDVqeEdySmpPZit3RlpTazUzcFJVc0t4cVJMZGN1ak9mNVNkNXR3?=
 =?utf-8?B?Wk5Yc29CWXU0TTAxSHB1TE1YQW9LT0VHTjZ6T3F5b3Q0R2pGTVBIQTBwY092?=
 =?utf-8?B?VkFCRERpNFAvekducVBTdngwdDF4cWtKdVFwcW5oLytJUTFSNjJlYWFvRE84?=
 =?utf-8?B?YVBKSDU4a09PL2dVSk5LVlc1NmlxRDFzWFVrajhUQVVWUUZJbE5vbVVnOC9h?=
 =?utf-8?B?ZnFzN3pOVFZQNlE1VWJXSmFsTmUwNENOL0U2QjhpdjZzOGNpOXdvWEh0SUxN?=
 =?utf-8?B?VWNvcXpONzB0Mk5ETk4rcmx2SVhRUVQ0a25ML2tacTMzdENORitMUW5acjha?=
 =?utf-8?B?am84ME9uTEd1UWZ6eXlZcVFLVE1IcGFCNlJMK2dsWXlab1NyNEVZU0F1Q3NF?=
 =?utf-8?B?MXcreC96dm1Uckh3TmZFT3NPWkwxc3FQS054RTJ0YUtkRm1OdlpjUGlVa0FR?=
 =?utf-8?B?Vnc0N1hqbFh6Nms0WUJwRE9SRHZGd3c1Q01tSC9QNXR1UWQ0OXBMTUFpTWF1?=
 =?utf-8?B?Tzc2cnBYTnFZbFB4bHVzRWo4VDR1cUFpZE9DR2NzWFQvZjgvU1lVelJzVlFW?=
 =?utf-8?B?cS9rcHJJOWhqeEFvRzJnMTgrL2JNOGMwa01VMkJrYko1RzZyU3o3Y2t1VWhC?=
 =?utf-8?B?UnpuZkhYQUhkSG9NNG9aN20zaWRYd3ljVmh2K01FSndpWEdka1JkQ2VDSTdY?=
 =?utf-8?B?UnlKU1dpSDQ0S0pzM2NRcGFEUm1JV1M2bk11T0dYcDJwU2NDU1VVQ1hRYXhM?=
 =?utf-8?B?YzBvc1NDZjcyL2xFL0RSTjBTazdxaWlQZFI4Wk1ielg5ZkFKMHE1ZGkrd1lp?=
 =?utf-8?B?c3lyS2djeC9JQkFOWnkwS0ZkSjU4b1hGdU1IVjBJSDhDTmZvUU9JMHpKWDFk?=
 =?utf-8?B?eUhuWHJqbEhFblhqNktwUXo0SS9wWDZaMXhvOERjSkVKZ3dvVEF4dW9aMVJ4?=
 =?utf-8?B?V20wUUFROE9uNUxRbzhhOTBtUWlqSklOZ0RocS9WOEZueW9ieE9oQ3k2QlNY?=
 =?utf-8?Q?TDq5O6/rkPkU5CpgoqUecSWoN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a6fb3d6-fb3d-4887-94d7-08ddd905447d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6606.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 18:31:20.6456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PXBRTzdvBLuIICcR4QC9Z6OQxgLGQ+7bEYu/kyicICqCafEDs0O0YnbpzaCARnd/f8/+WicbuiEumYg2ZE6vqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6688

Hi Catalin,

On 8/11/25 12:26, Catalin Marinas wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Sun, Aug 10, 2025 at 07:50:34PM -0500, Shanker Donthineni wrote:
>> In atomic_pool_expand(), set_memory_encrypted()/set_memory_decrypted()
>> are currently called with page_to_virt(page). On ARM64 with
>> CONFIG_DMA_DIRECT_REMAP=y, the atomic pool is mapped via vmap(), so
>> page_to_virt(page) does not reference the actual mapped region.
>>
>> Using this incorrect address can cause encryption attribute updates to
>> be applied to the wrong memory region. On ARM64 systems with memory
>> encryption enabled (e.g. CCA), this can lead to data corruption or
>> crashes.
>>
>> Fix this by using the vmap() address ('addr') on ARM64 when invoking
>> the memory encryption helpers, while retaining the existing
>> page_to_virt(page) usage for other architectures.
>>
>> Fixes: 76a19940bd62 ("dma-direct: atomic allocations must come from atomic coherent pools")
>> Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
>> ---
>>   kernel/dma/pool.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
>> index 7b04f7575796b..ba08a301590fd 100644
>> --- a/kernel/dma/pool.c
>> +++ b/kernel/dma/pool.c
>> @@ -81,6 +81,7 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>>   {
>>        unsigned int order;
>>        struct page *page = NULL;
>> +     void *vaddr;
>>        void *addr;
>>        int ret = -ENOMEM;
>>
>> @@ -113,8 +114,8 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>>         * Memory in the atomic DMA pools must be unencrypted, the pools do not
>>         * shrink so no re-encryption occurs in dma_direct_free().
>>         */
>> -     ret = set_memory_decrypted((unsigned long)page_to_virt(page),
>> -                                1 << order);
>> +     vaddr = IS_ENABLED(CONFIG_ARM64) ? addr : page_to_virt(page);
>> +     ret = set_memory_decrypted((unsigned long)vaddr, 1 << order);
> 
> At least with arm CCA, there are two aspects to setting the memory
> encrypted/decrypted: an RMM (realm management monitor) call and setting
> of the attributes of the stage 1 mapping. The RMM call doesn't care
> about the virtual address, only the (intermediate) physical address, so
> having page_to_virt(page) here is fine.
> 
> The second part is setting the (fake) attribute for this mapping (top
> bit of the IPA space). Can we not instead just call:
> 
>          addr = dma_common_contiguous_remap(page, pool_size,
>                                             pgprot_decrypted(pgprot_dmacoherent(PAGE_KERNEL)),
>                                             __builtin_return_address(0));
> 
Thanks for the simple fix, it resolves the crash issue. I’ve
posted the v2 patch and dropped patch 2/2 which was added to
support non-linear memory regions in pageattr.c.

> in the atomic pool code? The advantage is that we keep the
> set_memory_decrypted() call on the linear map so that we change its
> attributes as well.
> 
> I want avoid walking the page tables for vmap regions if possible in the
> arm64 set_memory_* implementation. At some point I was proposing a
> GFP_DECRYPTED flag for allocations but never got around to post a patch
> (and implement vmalloc() support):
> 
> https://lore.kernel.org/linux-arm-kernel/ZmNJdSxSz-sYpVgI@arm.com/
> 
> --
> Catalin
