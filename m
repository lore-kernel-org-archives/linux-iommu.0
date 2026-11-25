Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.29
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795630079;
	b=wR9iEQhAdZLwL2Sp6jCqEu9hnHqJ9zJPREil46qBhou9LlVqHv02wt7tWyrfXQqwq4DI
	 WQJ2A3NYi5jHbGjMEkBaHeV+VkNJZ3p1BcviDpptuJxlBHbdRbi26DxLb7IVJjCOqw5E5
	 hTZqII70yECEn8uY0LoaqunQlhydEwWyPc6unsr/8HlrKPdsr8FncZjjxqG4Ez7u9SK1c
	 CCyrtx8W5wleomMpiv0Ag9BGPgfeqjHI+38ZI2BOjOjqO4i44rHNUlDgiSutRT+shMLOz
	 KruLVW0Otz2pp0wGdOyZjDxUjbsLA6qiS/BFIcHLaIhiuWO4DD570xlLt226buDQXoQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795630079;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-ClientProxiedBy:MIME-Version:
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
	bh=7Qh865tZAV39J04d7qqw5PT6lMs5UqCzIs3qRbvWr6k=;
	b=L4sjlrXge/J5sRMpEssVgPJUrmgMwIWzhi9wLTw7F1ZFZzO2vIiqjJddtIYldT6Y+VbU
	 o0eQzf1ZNXIzsiLa0+1z00SdxoLr3exZdaJ1U4wXLbKB4dCcfhEDwp9M8qJ0mQD36pj5O
	 asQWiWQC/chGT2dfJ2C3ZxI7CmuXVgFss6lzQNC4/pf8q8Np/mPbRHZ+VOLcl5Ru8SFYP
	 hi23sREpZ22WjXYbH4FuZTtZMgIMSXiNTMnrzWZa48lIkcgac35VJT5v54mJtWQGVrYgC
	 kmETMUqu9HBrgod/9IfJ84miNyNVO3zudDMLCM9VZCfQe1X2cin9gZkmj+u1YMh0o0g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=CfVA9dsW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.29
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012029.outbound.protection.outlook.com [40.93.195.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEFE606A323;
	Wed, 25 Nov 2026 18:07:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFEFE606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=CfVA9dsW
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IsRM2NaFLjhjQlv+OXBXcUbgPbWZnMFuPe5Eycm8vcCWrvxIAwAnuQprc/VCJhpUa09vaMcVRarZFJbaWdl1uNBVQrVCJuRdl6VZABoL8G3e7khrndq2PPusPhD27e+YFC7mjfDytCs+OAhRaLxtOWxju0bHwcLrfHoJOLt02Y8+Bqo4okvuyL3z2Mtdu/lpJ+Bvi5G6EZY/KJKrSlTIPTo7QAAT9OXxCRPgC4O4SIDeCwn+xrB6uiUgboCW/14pIxnzUL5JYB9V0FVdfpD/t3pLAOpv6rVSXhk9VxfjavZIFjhO44RaDFjLp2Pp0LOv/3BQA2dtbFmaCi3khWit6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Qh865tZAV39J04d7qqw5PT6lMs5UqCzIs3qRbvWr6k=;
 b=viQiyV8CH2I9e79Fajx2+ty4gGrXO2xmZBQV/z96kPimV49E0VueL4ZWqaJElJ8uKYsFqsoVxXxrpyVatJk35c1W7H6quTsEVQAlxhOQyRmIVYXsBQ7OxiEHf4vZbcXQevrCZvDUH9o/ujP/R/6uOg/2dQZPBV1bkE5XkMYPobzSTKJfO85MWjMA/yRXPBEPp4Iru+O9JCFJpZIpuzxgFgBArOiiXoRyMu/0WhkhATuWkVZBG+qbH9zpSXwzRqkktnEPkymKD5fnusYP6c5oxjRodm5jhdhnaoMSXsHR12ml3krgfhevspSt/wnIJuIsCHMGPluKMuF+2N8lTDzFjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Qh865tZAV39J04d7qqw5PT6lMs5UqCzIs3qRbvWr6k=;
 b=CfVA9dsWAPR1x4dvFWdZKiQmhYtCVzzoVETp3yKAUggI4rN0JzdHEbgwcgxQWXyfWf2du+Gd5UhxDFLaQZyh4nbmSg/fnhQxKw7q7h6NGvmxGcbENLGf2MPHs9eBCCF998rXz1hRI/Fs3mHEXZGaCAV3yeSBboyG9/0anqrgdvQ9d084IIzYuvsqvPFizV4y1c/hBh/+lUTfYUbvX2HqIspmZKqId40Cjv07JZgcRkCnvVGFDh1fxvXqMbDsizm424gEsXTdKpqS13VGOx97WnZZqS58xmDpAXuWRl04c8QSKI4xQzEFKed8kQ5KOu8O9bhrDpfRH/A8q+dqViFZDw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14) by DS7PR12MB5815.namprd12.prod.outlook.com
 (2603:10b6:8:77::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Wed, 25 Nov
 2026 18:07:47 +0000
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5]) by LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5%5]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 18:07:47 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 3/7] dma-mapping: Keep DMA memory private for
 capable devices
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, joro@8bytes.org, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, rafael@kernel.org, 
 Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Pranjal Shrivastava <praan@google.com>, Mostafa Saleh <smostafa@google.com>, 
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
 driver-core@lists.linux.dev, Sonang Patel <sonangp@nvidia.com>, 
 Ankit Agrawal <ankita@nvidia.com>, shameerali.kolothum.thodi@huawei.com
In-Reply-To: <6618391e4f7809e25400b414be63a8a35ffc9758.1794343501.git.nicolinc@nvidia.com>
References: <cover.1794343501.git.nicolinc@nvidia.com>
 <6618391e4f7809e25400b414be63a8a35ffc9758.1794343501.git.nicolinc@nvidia.com>
Date: Wed, 25 Nov 2026 14:07:45 -0400
Message-Id: <179563006502.253973.9890839835004019669.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT3PR01CA0023.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::28) To LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14)
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
X-MS-TrafficTypeDiagnostic: LY0PR12MB325698:EE_|DS7PR12MB5815:EE_
X-MS-Office365-Filtering-Correlation-Id: e30f4e3c-7481-4091-9096-08df4b1f02bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|7416014|261026140227099003|261021123027099003|261022105027099003|261021135927099003|261028144727099003|11063799006|261102123227099003|56012099006|261021121427099003|4143699003|10067099003|18002099003|22082099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	diZFwFACsNZYhEx8rTJzPw87cXWH+bEmc27DAcjl6DChsla+3DiFgcSfsxmvW1D0MkJW94979GAwJCx1noRMPP35Dh4F0UTjsJeCpckQytbVWLn55jlpLV/eST3owiPc0dJ4GBvUc+V5S7IWgWpFLUMviDaEHfTu8rWi81XprqlIjPOaIrrMg/ySj94iG5xfEys2g1W2J8hksjr/zqVjoOoWO7C05Kb+9g37nnIOORkSbC8FSqfrYZD4w8FZ9/f7BmwGih81xXD7Y59OBjpytX7sL8jhnhGuw4CxSfMcKg9ZQ3llZSO+/eHLxQDRCeDDpPLdC72cZnCK038rFxSwaWH6cK6s2owteeiVUFnz4UCoAd7Bs2vmwIHbzZLZqAJR9JkztjjjRIqxYrDCPxo08Z7+61f3jnyYpgQEq1TOlHApqqUzVgEuesvW27ULtJOJa9f2WvwufvOztkgqKlWEDBsyNSBVlv6t6VNv6XOO+/8fQelHJfY0MkXlcnRbxPEYjg4/mN/6XmoOUG9E3nGReVjwG7DvwOU1dnQ1xY6DAid8tT92snwGOB+fW9KSPybkX2keqWTPyjfB+97bkrfe7b74ZKyVsFj/eUicGVFt19so5hF1DRPN8/iQ9vTuq1VOHQcraw3ekHYLB19Ix5Y94rqtvz/KuwuOF0mXJ5KU/jE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB325698.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(7416014)(261026140227099003)(261021123027099003)(261022105027099003)(261021135927099003)(261028144727099003)(11063799006)(261102123227099003)(56012099006)(261021121427099003)(4143699003)(10067099003)(18002099003)(22082099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SXUyUWlyaGdYdkJOeStta2pmWW1kRVd6NnEwcmxWNUIyTUhWMDMweXlpK2pi?=
 =?utf-8?B?TnkvVWd4TGJEb20rL3VwcXZXK1I3bk1DcFR1d1Q1TGkvbGpMTERIU0I5OU8y?=
 =?utf-8?B?YUR5SXgzNTUyWGIwY2lqdU51bzBPMFRhSTZMcVVhUkVtRjFrdEIzR3NPSEV3?=
 =?utf-8?B?UW02VjNFYVRXWWp6Qkx1TlgzMkd6K1p1cVB6MW9DSk9BUXgrTXFwNksrb0Ft?=
 =?utf-8?B?QzdkSFpuMEdFQUlZWGJiVWFESEVpK3dNMy9mMHg3N0sxekhreHRCMG1GMU9V?=
 =?utf-8?B?U0N4M0FLMjB0Q3prOVFLYUhtNUZLTE54WllaeDZ6eThac3RwNTE2UUFUeVBB?=
 =?utf-8?B?TlorWk5NTG1na1JmMithWjNCSXo1cGRWZEJJZGJhN0FzNG05dlhwc2JpeFVM?=
 =?utf-8?B?UVQwdElORHhpdGlPbWZrUkJFYUVGMHBpa3dlR1Rpb291TEM5cUxadllPalpX?=
 =?utf-8?B?K2l5Q3ZLWU5lMnpCNlpKVG84MG96ekhwMXdiT3VIN21ZVEJmekFLRW5GbXV3?=
 =?utf-8?B?TytxU2diU1I3TTRkRW9qOXVUdDNhU0phb1FEMDBvalNJT21FS2VhTE9sMFBI?=
 =?utf-8?B?UWMzenY3ck1OeEgrRDlKOXNWV29SZDROY3JURklFMnhyOWF1dFdSZWkvYUt5?=
 =?utf-8?B?Y3lwYnFLdDN6VzAzdytWcjc1Mk9WcWtnOFhkTFg3bVgxR0t3SWJCRnR2N3g5?=
 =?utf-8?B?Wmk4V1BHWjQ0dVgwSnozc2dabS9FdTBWbVNMcUNhWVh1VGdGVU01amtPY1hw?=
 =?utf-8?B?ejZueGx3NHU4TXZIQ241anMrZXBLVVFHbGxFVnVqcmlocG9rNUU3WXA3cHdE?=
 =?utf-8?B?UXQwaG9EKzhHMy9qNEd0enhMd0dTS01rejlCTng5a0lpMmVMeEJpdExvalN6?=
 =?utf-8?B?d29OV3VsekFVdVVuSitwbDFJSXZOZ3BkSFBtNzhRcXBwRWRwZW40MXRVRjFh?=
 =?utf-8?B?YzJRK0xJVGtOVEhrN3Z2OUJDRFNzRWdzbUxEK2FDNitZNERnanI3d2F6YTEr?=
 =?utf-8?B?eWY3MXBCR2hzZWdKdHQyUFVydG1HemVvWHB5cFBBYkpScTVMQ01zU1lHWEky?=
 =?utf-8?B?R0VVL3Z3Yk1GRFdGQ21TRVEvNzlJaDZ6UURmWEpXUTROKytxSDBlVHJET2ZW?=
 =?utf-8?B?eVpVLzZGYURIcDd6bkh2ZGluL09YSGN5SGsra2k3TXRqVXp3eko2RjB1WFZl?=
 =?utf-8?B?dnczaGE4c1hrRnhuNFlMc0dHNThPRHJHenFHWEp2RjhZa2poOGZNTTcrbHZE?=
 =?utf-8?B?M1Z4cXBUZWNhcWtrcFp6dFVBT3hLenZCcEk1MEcza3p3S1lRaFBvSkNYQkVo?=
 =?utf-8?B?blJNMGNETnBmRXphWm5LWXN3Yjc4RFNJWktiQ3crZlZLRWFIOW5VakdDYzI1?=
 =?utf-8?B?c1M4NUdiN04venp5aEZLZlg4WnJ6Q0llVEFiNGRNM1kwSkpPcWZhR0Qwellj?=
 =?utf-8?B?YkpycXBwdWZVOEZBcFFYMkxRbWFHeVp1eFEvSHZiWTJ1YU4wYmRVSFh2d1BL?=
 =?utf-8?B?VUR4dU9mUytLa1R0RHRTNGtraGwrSURrTFFsU25qaC8vTmhWSERZUjZNU0hj?=
 =?utf-8?B?eXl0MnNkVWR6M3h3RWt4SlpYMXhIaFc3TlpCZ3NTSUlzTE4wSklDcmhCQTM5?=
 =?utf-8?B?ZWNPSEpsYldwVGxTMWtxeFVzcTd3YXd3WGEwTXlkWkxSSjNYQitmeW1nWDNY?=
 =?utf-8?B?YW9FUTgwV2lOWitYbk41Y0hiaktoUnN4V0h4dFNhanA5MVJOQTd6aHdia2Rr?=
 =?utf-8?B?aVc1V2dCbVJxR2RXd2ZXSTdCVEkrRXI0MGZSNVEvamNiT0lqUGV3UktyZWFz?=
 =?utf-8?B?NzYvK0t2UnFnblJoNEQwby9PdkhBaDJlMjFzQmQ3ZXpFZjJpVHh0eFlwVnU0?=
 =?utf-8?B?WEZNSmFMVXcrOXhWVEFZeUJMZmp0RFZ1alhVeE1SQldMcExTT2Y3cVgycHpn?=
 =?utf-8?B?dDA1bnM1QmIvSDhwSlRsTnZ5L1EwY2N4Y1VKcCtQRmkxOXlvNGFRREQxN2Iw?=
 =?utf-8?B?aXpsNklPOXdTdmtwZHdkYXNXODMrbUEzM0RzcTdtaWRwY0Z6TnlQd0p0bDNK?=
 =?utf-8?B?ZUhxYWtmeU82eE1adVZKSGRHUnY0VGlMRDZhaHM2TlpoYXJqYVFWNDZBYUln?=
 =?utf-8?B?T2pvSVlkd1hFNnlLbTlESVBKcHN6Qzk2b3ErNDIzOGhLTUVRcFU4TVBDWVhU?=
 =?utf-8?B?eWFNSWxLK3Q1VVlvaFh1eEh5THFsWk8wbDljQ05IaTMzR3I2Njd5VDNoakxU?=
 =?utf-8?B?VUdGT1JBbnBndWJhSWlBbSttdWNBRHJGNkFIQmRjTUt1S3FEYVFobGFzR290?=
 =?utf-8?B?NmhCSTgrMGxoYjg3MmM2UGdubzFIdFMyRGJnTVdOL3JIcjhOem5qdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e30f4e3c-7481-4091-9096-08df4b1f02bc
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB325698.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 18:07:47.3396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: POem00u54O5OMCQrSoa+0Qrv9ToT5e44AFyXG509ITdfghUAYV+TYtcU2+JYjE8U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5815

> Architecture code can require devices to use unencrypted memory. This makes
> the DMA API use shared memory for coherent allocations and bounce streaming
> mappings through SWIOTLB.
> 
> A device marked with DEV_FLAG_DMA_CC_PRIVATE is able to reach the private
> memory directly. Add dma_require_unencrypted() that combines the new flag
> with force_dma_unencrypted(), and use it in the generic DMA code. Also use
> "unencrypted" in the local variables that hold its result, to avoid mixing
> the "unencrypted" and "decrypted" terms.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  include/linux/dma-direct.h |  7 ++++++-
>  kernel/dma/direct.c        | 21 +++++++++++----------
>  kernel/dma/mapping.c       |  2 +-
>  kernel/dma/swiotlb.c       |  2 +-
>  4 files changed, 19 insertions(+), 13 deletions(-)

This looks OK to me, when Aneesh made his changes it was intended to
support a change like this, which is why it is so small..

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason
