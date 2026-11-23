Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795422727;
	b=432wo5AGsltJTtDigOpV6ahADuylGE4y6deIMDBPnGeiqsB/nfnGaxa+3WdG3xbHV0qf
	 oASt6yn9iMxFENU3i8s9og/VeQvE20SnNv+pLq81idCc420PGanb247jwTypkUcuiJ2lW
	 Zo81fydg88yVw/g8pOcsogwM4l2OEB5rJu9R7oSVgsAo9tXn0/Y2qwX/Mudb1ozbsSWcK
	 ipxkKgQnyd7YIrNDQH+iXRf9QDZZL3lg1cPCBir1cL5KAEFRD3X+E+ImcmUXlko3UkVPa
	 NsunAJRX/2ZIv+P+926m1ESMYyh9OLIwPNQjUkWRVyYK5dMkXNY7WOuKQOAsIBy/sSQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795422727;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	bh=cxsL6ud8vrRVDfsymBuhS87Zyb8EaiHiwgkbgVvufNk=;
	b=jvvK0hgBwgPx7sLl5UQ+Qz8F0yDTx8MVHL1xRnZGufPjJ3UpJ6p4ctP9GY2jlGESlg7i
	 jGMvbhTA+h1vulzMf8UuWUfa9i2swCRONTcUSXMFR3vsT3AB06zT7UBHjxb8A8JzwGVmK
	 i+p8zL/cEY54qFbcS7sM+W0dcmsDJwdcpJR3JaOAOoIVkfTWTiK0hcPWQmbnBcRXvPMU/
	 gkIxNG5F3xaLAjdtle/N0JmzBouKGr8Npw8Mqk3llfKao7YB3pWMX/RlHlNW3VdG6QVYx
	 kBpDHBOk6pvHe8RSYsitW+gwWGxntP78XuMCT1VEWIA2+ID/7hoSXw9Uukp7BwXboRQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=rPcCTRPZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.12
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012012.outbound.protection.outlook.com [52.101.43.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4053D606A31E
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 08:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4053D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=rPcCTRPZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3XFeKts36L6VbUN4j90ieQbJ/EKdbaAJkHv6nB4NeoSiOylhe8ZeuRuUJBNOs+pOSkM8ZaE9OXyU1Rhnujhju5EXEbptcGtSb/ti+McFUO+6G8e/zzjNX6aPQL2jVzpBvvsETq+Xy54bh0giVbe3+uIJiKH9x9GcIptTPj2zu7zHYg5a+Mdh6z2ki9p5e5ugQRNSyTkkAK5eEDgxTHL2pMa9+Im1LsOAOGf4zEYoJCpc5855xfpGjSdQ6rhx6zmLLSEc57j6HsqFlgTSetSqmbtd1ljtLUipQOrLo6eGBRqlkRLdnswggjvMUotUbxGmeHyOaSfdhmetcO0TzaEbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxsL6ud8vrRVDfsymBuhS87Zyb8EaiHiwgkbgVvufNk=;
 b=u5XEYWa5aBTajIddeFZwMOzVcYat/bi6duEmgzLmuLu1EK5/AQV3k1tqSGvANFe7uec6DfDrAw7WWTHPWltO2gl+4bR143RNw30H/f31oUP+TrUlEtq/Dtp/f1cd349XyMI6qwjJmeHTorP7BI4F0n8IKGxz8WWsJBH0QzP0WcAYiDnc5L0myHW+LqPzqrwcrJ8AjK3rcbVipWmIfRqfPAqP4IQOqZiuixLPYxgN82XrNoAtWURSqynkLeBheBJCUbJznbpZxmKDTCHl+f0p/Vh36aav5/bCG7SvuKfE4MdvyuGQJKujwBcmO7vvR885HjbVD/kVDPx5iQ6fmXn5SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxsL6ud8vrRVDfsymBuhS87Zyb8EaiHiwgkbgVvufNk=;
 b=rPcCTRPZ2n+t9uWwuQA4dtUUl9afYdhfwbVJ8X/ZvL2OTiuPxL3Vxtp0ARGjRG/jQRC5zRxK3tmepOl+j3NcPzSUFnY3afos/cHVOBDKH3Oh1euPAxRdyWUFp9Ry4SCboRclYwC9sAFQbqLN45wi+fT6wgV/Tso1oFtEQORF7tA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by SA1PR12MB6749.namprd12.prod.outlook.com (2603:10b6:806:255::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 08:32:04 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0639.011; Mon, 23 Nov 2026
 08:32:04 +0000
Message-ID: <943d0fd8-22a0-4f68-a9fe-a2f27d8a3bd3@amd.com>
Date: Mon, 23 Nov 2026 14:01:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Enhance "Command buffer timeout" error message
To: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>,
 joro@8bytes.org, suravee.suthikulpanit@amd.com, will@kernel.org,
 robin.murphy@arm.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20261018124113.910-1-dheerajkumar.srivastava@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20261018124113.910-1-dheerajkumar.srivastava@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0205.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ab::14) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
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
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|SA1PR12MB6749:EE_
X-MS-Office365-Filtering-Correlation-Id: 40486641-7df3-420a-8f23-08df493c407b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|261026121527099003|261026140227099003|261022075727099003|261022105027099003|261028144727099003|261021121427099003|261102123227099003|11063799006|56012099006|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	D0brRvwVK76w7oKxKiIE8HjZBsb7A2o/q/pgXlPeg745T1hXKNfum8VWC9N6/ma84HB+sldGKargsznj8lRBDs8YJxY1hvkexlgAhZ0LBRbwbEzTyVIyq0utkMKZHZTgNGYgHdGAlz3t62FwekOP+J9hAmEWXRC4iCUef5m62rsCqh8m/KSIqAz76guKhBoHQvvNn78rfgTTvrQnqSNe/WbJXtGH9A7Kw93umS6YN3fKRJn2zTJY2EIyhj9Kjgz+Upu7AOF4QXR7hNSLq60nU2KsNZt+O4JrXrUcsOI7coiRThZNydoqF3XxQPk1SfVI9z/1pfBladlZLmgy3ioO7Pl5KoaF1LF6EfIKaVxC3DYFi/fqq/3E8tkf/23XPjjD5c6hvKt90KuXwIKeRMo+XU+aL/yl4OSlh5wHrlryPYEJqP0pJ2wnSoqlzZE+nAtpwz+O/o0nKty5YIesr5KMXYOm5iK/pUJqQ01yXqPrw8oc9YJ5p2s6+f6MmkETSftUB5pmYjjJfwxWDsAPKz/QKnzeTzd47KjSjG02fDWiLHzHneTHXv0m+XYZSkMJiDiTNRepkaDvR3WR91pneBjyLGEpnWk/8bcBnvnoFFPAsZ+2YU43f7mbR16shpcHU6aXSNJJJBnfRVQ2oZsfxiWBQzdlFkSYEdN6eFUqigi5OFo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(261026121527099003)(261026140227099003)(261022075727099003)(261022105027099003)(261028144727099003)(261021121427099003)(261102123227099003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ditxQTBXN01qZHpENVNpcXU1czFrbFZqVFpoeUhqTG10a1ZZa050cFUxT1Np?=
 =?utf-8?B?RWpLWkJnamY0eFNjaFFhUU9Ud284bm9mOFh1QWd1cXFJTU56dC9SUkJnQkcx?=
 =?utf-8?B?TWlDSkU5SlBQNnU3VlB3Qkh3aXN2S1FDQzg0MXdDb1J6Wm92WFQ0eE1XZ0J5?=
 =?utf-8?B?VkpYdHV4SGFzUlFucTJwdGo1WWp1Y0hzMGppYTBMZmVLQ3JFdG1RTHI0RGNx?=
 =?utf-8?B?M0NQUUZJRXV4N2Npa0FBTytOVWJzaUdjVVVKNzYwM1Rrd3g3empwV3RBeGVp?=
 =?utf-8?B?eEpCTU5aVUhwU2xwSm9xcE9INEl6R0s4U1M3U1VQL2V2MGZWY0lzY1p3a2ND?=
 =?utf-8?B?OCtkMTVyU3Q2eTRSQm1Wdno3UTF2d1NEOHA3b2o3VjRKejhFRnB5VzVEWFBU?=
 =?utf-8?B?SkttRE1LcjZWSTczd3VxSlFJd2JuNktOVlhrVXNXUG95Ylc0TTc2TjR5Qkkz?=
 =?utf-8?B?bHNrRVJYQjBEUnA0anJxa1d1TFpLRkdKMnlDZTk5UHJHV2lyUjZLZU5kN1Uv?=
 =?utf-8?B?c2o4UHUzN0pkV3ZGQ0xESnZLaWw2T2NpcmVBOVFHSlFPd0dIZm0zajlHM3lJ?=
 =?utf-8?B?NWZMT1g2QVFwNGpDNjBmWFRpZFZPb3kyeHFOdUJLSFZuMloyNlNCbEk5WHQy?=
 =?utf-8?B?U3pjRWdadkFlL1FNQ2tkRmFob3JaakIxSm5DOWNkY1FFbGd1Mmd2b0dBU1NR?=
 =?utf-8?B?Mk9lREhIamFLa0VtYVJ2cnpTS3M1Q3RFQVc2cy9hNUxiOXREYk5WOUJmV1lq?=
 =?utf-8?B?OTVrUFVGTzJkVzAzRGNDTEtBb1o0Zko1ZGNMTGhSZ2RYcU9NZUJ6OTFBRmNq?=
 =?utf-8?B?T1phektuKzZzdlgyR0lLMElPTWQxSnY3RlQ5OG1JUjdoZ3l4MnZBZEZPaEo0?=
 =?utf-8?B?akN6dVN0OHAyblpycThZTG5jMGtUUmdZWGRZSjRFZEgzd3BERS9nb0tPWlE2?=
 =?utf-8?B?U2lCSkkrWnFTZEZXNG1UTVBsd1Vxb0ZaSytTR0ovMTBsNGFrSy96Ni9DVm9r?=
 =?utf-8?B?RVIrRTFZTkpkV2lZZS9GV0lVZ2ZsRlVrbW1DT0hyYUVSMDFJSzBQYkZEM21r?=
 =?utf-8?B?MDFmaWxnNTFVL3lKcGZRVFI3SXYwVUVia2F1WVpmNWNlbjUzUDJsWjV2aTNZ?=
 =?utf-8?B?OGVWaEJqNWw4ZEZTSHB5SlExM3pxUlY3OHZ4cGFjQS9KNnV4UnJmbmppY1pR?=
 =?utf-8?B?b284M2VodWU1cnBHcExRUlRQZjBUNGFuT0h0ZEExTUxhb1hMemh4Nmwra1Jo?=
 =?utf-8?B?cVNRVTQrd1lSMG9sZjcxVU1hRVFVRlg1Zm9WN3doWHBpS3k0ZGFMdyt1d1lU?=
 =?utf-8?B?YU4yY3lYNEs4NFFDTDJzWlNyc3BJS25LQlpBS2ZmR0hyMmtTMHJSWHRMaUg2?=
 =?utf-8?B?bytuSit6eHR1cXFQMVE4S3N3YWhITElqa3QwYXQzYUhySGVqUUlTWXBhdEpE?=
 =?utf-8?B?a0dOTmJLQ2hmclJHa0hwc0xFeTZINGR6UmorUmVwSlZ1UUZzdXdyWFkzWnM2?=
 =?utf-8?B?azdpQUV3K1phd3lGaW1OamRNdGhDTWFMWXNxc1luNU00NTZFRjA1QmpVS1hE?=
 =?utf-8?B?aDRTa2hPRDREQUhPdU9MaElnVm1jbEM1bksvNjRQdUJXVGg3ZWpoZkk0V1Y2?=
 =?utf-8?B?WVlWdkxqTUFubVBhTHNZd3Y2aDNTOEhrVzFiaFFBOEFzTHZFczZjWTY4Z2pi?=
 =?utf-8?B?bHJXK0l1SVhVVWpKZ1k4R0U0b2hBQzlFdnoyN1ZTbkdRWXRSRXpNajE5TCtX?=
 =?utf-8?B?eWJITVd1dnNUVkgyclNBQ3RnYTFnODNGc3NvVmtRbXZYZjRONnBKZkt5ZzFK?=
 =?utf-8?B?SzhZVmEwMGpHTWtPQThwa2FvU3E3KzdseWhvL013d3VwSG45UVlFRUo3V2FS?=
 =?utf-8?B?clU0Rk95OTZkekplcS9uUVhncVFJSWdaTmdmSE0xdTdsTDJDMFJ5RUl0aTBu?=
 =?utf-8?B?M2tSWjdWSkdYTFpLUVFXaU8zTTFXWE0ram1XOE1tZGpTR1JwN3FCa0pvcC9M?=
 =?utf-8?B?T2hiWXB2dzl5ZXRaTGtKVDVMampSdlpncHRzT0FCOHhESEhEM09nOW1wUHFh?=
 =?utf-8?B?OTZGaWFyNmJmb1VrOVhYdy9rM1prM0d5YVJOZzRhTjdYRG9GcGNYbUNFQTdj?=
 =?utf-8?B?VHVFcFVJeTVwblZpVjEvZ0NwTlpzWDZKMVY4aktVYjZhK2lrYkZxOWZCb0hn?=
 =?utf-8?B?aXUxclZIYjlnM1FjUEhZWFVGUmtHeFpRY2l1akttSEljM1lqSTFpRDFuakc5?=
 =?utf-8?B?VVRKWU9NY3pzd0VueFlZVngwZXRQNjNUdVoxQmEwMS9kb1BGaGM1K3RMdDBz?=
 =?utf-8?Q?aks+jtpNTePJ9kaW35?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40486641-7df3-420a-8f23-08df493c407b
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 08:32:03.9724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tCTZxLZK3W3tTAtvE4u1hJVC9e2EiiYSiQTqup7kNDKEeHj1AdYW2I8cAuGyXmeLduOlWfhLnT24dhhw7ybZEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6749



On 10/18/2026 6:11 PM, Dheeraj Kumar Srivastava wrote:
> Current IOMMU driver prints "Command buffer timeout" error message with
> insufficient information to further debug the issue.
> 
> Enhance the error message as follows:
> 1. Log the IOMMU PCI device ID in the error message.
> 2. With the "amd_iommu_dump=1" kernel command line option, dump the
>    entire command buffer entries, including the Head and Tail offsets.
> 
> Consolidate the timeout logging and the command buffer dump into a
> single helper and use DO_ONCE_LITE() to dump the command buffer only
> once to avoid dmesg spam. While at it, apply the same reporting to the
> completion-wait timeout path as well.
> 
> Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>

Applied, thanks!

-Vasant

