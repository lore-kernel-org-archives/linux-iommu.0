Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012059.outbound.protection.outlook.com [52.101.48.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4743396E9
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 15:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774884274; cv=fail; b=R05gziHZPvI7CxpdB2tPVtj6PpeLKCShpVgbd2Opndez3NeS/P95tIuWWW1TiN8OUjJ70AkYIfTaFeyy28t9qHSzgx2tTRjg8HGwTAFMLJM2Ga3fbnNpAHPcnw98dGPuELZt0WJnHMSajeBBZmmcQLh/H8KaiPxu/0Wqft1fVjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774884274; c=relaxed/simple;
	bh=idJXxwlQBxUKXguKk8KgQdgAWC2uP6muJwNhaTZUmw4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b1n0hcNJPsjTid8IZwDDHvXIMT153hXQHSOlFjD3RcnUREeRZ7Xqd7QjI7nQUBjj6SjdTgIOtrbRZ/xb9iD37k31DuedVfkrlQlVt3smfD7WFBf5uM9W/yhdl3e1OyjZKC6RGipo2VFKROQ9bmslgTMrWrj8T+2U6vGtf/B4EO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ht79MMqn; arc=fail smtp.client-ip=52.101.48.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ht79MMqn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=feDFeHfN19MGi8IwaQtS27cIYr7I/BSEirFLn0n2TtyQSrcwO6lv5RujB0hC8tYWMq1forl2899hraNjt5zYI9c7n6gOlgi2oAKpGvjc+EBpxmnUfg8J7i9yB69DBuKOQHs5FC6J2fspOTrq1g0NkSCs81TonKMroyV21YmdKDWTYkZmksyBJfPdMNibEv1zRDHCZD6wEG7TV/TCelwkWLs0MhKucrshA/u+yAYHGU1CxzbbrLZMIkCsSuMWEbCRqJt8TQ1O7Qjiu84bMkisvRR85LFHFhuxOrMjYoxytNsiS88Unfh0QOednh9ez6ww+yYcv+7ARAqzPPHj/7JFvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RvxInmicajMwndFWPEMFLc5fUJ7mzzd0WCfIXf+4wGs=;
 b=S12QR0WNF/bfecSOjgo3Nrl7AkUcLdwEqcjlpH8oM9S+cLi2RSTrOyvI9+yTqXyclwz5JGfEN11XBYF3wDItBsOlD1TZ1rTOeLzLQCjVxbWzc7NlK+QchJvm4aX2kSIbTBAxQF7rW5Usx3g8qZghr5swLqZnHnMW6AL6drphzcxs0PnX/ByxBGrGylBDkqAZxhyBU15TWmnz82WMwaQj5DlFFw6uxl81hy/FreRcf/W9zgohpRzXLMzh31ams/HdB7vBoyEK9S+IkPtie3c6QGqEyvVYYAM+ed6pW6r5qRxm44m/Kdd3fgec/8CNvRWI+Zim3L7bgF/ZKdTrQhgYoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvxInmicajMwndFWPEMFLc5fUJ7mzzd0WCfIXf+4wGs=;
 b=Ht79MMqnPClp2Ox4UhZ1FwNciiLrutEQX5QZVBHC9CTaD/5Zo9TuIQAhg6nSwexisD7QrsjDfPQVKMciwxP1u9kMK/w3zP3Rp82CUB+ZTcN0/rzhEiF9aEZIYta8aDPnfjClTv3oy8Cbqu4Bjf6a128ghoxZmKBsZJb2Og9kocc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5754.namprd12.prod.outlook.com (2603:10b6:208:391::20)
 by DM6PR12MB4170.namprd12.prod.outlook.com (2603:10b6:5:219::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 15:24:29 +0000
Received: from BL1PR12MB5754.namprd12.prod.outlook.com
 ([fe80::b080:4c1a:f6e5:4564]) by BL1PR12MB5754.namprd12.prod.outlook.com
 ([fe80::b080:4c1a:f6e5:4564%7]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 15:24:28 +0000
Message-ID: <152a5b57-4956-4f49-85f8-d32ef5f44beb@amd.com>
Date: Mon, 30 Mar 2026 20:53:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] iommu/amd: Use raw spinlock for interrupt
 remapping tables
To: Magnus Kalland <magnus@dolphinics.com>, suravee.suthikulpanit@amd.com,
 joro@8bytes.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: dhsrivas@amd.com
References: <20260225202330.23027-1-magnus@dolphinics.com>
 <20260225202330.23027-2-magnus@dolphinics.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260225202330.23027-2-magnus@dolphinics.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0099.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ac::9) To BL1PR12MB5754.namprd12.prod.outlook.com
 (2603:10b6:208:391::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5754:EE_|DM6PR12MB4170:EE_
X-MS-Office365-Filtering-Correlation-Id: 76849a48-6ab5-40ef-cac6-08de8e706eda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	jnal1f1MORuHQ3ShKcXipvDxv0DO9BX8bYJha6x1bI2a4QAk1ygOEFl1N61EtlzdRyuJVM0FPOcB+8TlIOtahceZjuKQjhlz+qoK4rlVxRmLGKPM9pNE26Ix4lJOzUIgjt6YecLM6rR3SuBvYs8lVIUuuqvpyNdjpspPcr9AGtMtP+BWUB4DL8dRBr0FGs3hR9Wkv0bm8gKJE3tcXC0jVtbzw3rJSNPC6AbHJ5B2woMa44sCDbUIIcXmC01bom79OYXid0f2bQmx49L4VwOxR068zjwgQj2Ws9tgswKNCpjIo5/JDOCkvndoq5z3WsTeySvtxzWEyZLdjstRxn13zQNXHupy5BpIpZDQnsHdnvtHTqtpF0bipkf1rf4+4S6byJCfwH85F0bUsdHJ7LtmupwULw5BBCo8FabRzo+5ZcT6Njtee+qF7/7VDXGLjgXx3xJW+wHg8SjO7ZKBRACoO3mufCwJoX323AemR62wipf2Nt9lCxD70PmCcnSel7hCt7AAQUikO7kdm/PUVKMP1SVES2pmhzmSbRWqYamPMl/ylv66u8rO686J0xX5FraH67SP4BoPElVMuuAaTRhyiPtDMSv5OlZMzGzQ4ihodkVIVzaS7+WuOCWbyWY6s1g4TbWj9lAmgGuUk9+yCvJOYV6HOGorfMlT2MgeH0DaCNmlHMuwUk2t9IAq1IpOv53k0HSmcLzj7AMC2o1mxPMYHRlgqimyx6Kyy7FAZDDoe3M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5754.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWUxcFJ6Qit5eVpCdWFXY2s3ZFJFTHgwOHRYdkZWZ0dxd0ZsZURSWXNLRTFL?=
 =?utf-8?B?RElITHd0ZjZxbVpUeDRCcktCZTFZT3F1cE41VWVIZW1aaHpydFQvRFJzTFRF?=
 =?utf-8?B?bDFYdUZ5dEk1K0dHemQrTVBOakRWd2llQmNzTHpnSzFDN3lHVXBLeTNaS0pG?=
 =?utf-8?B?SVVmNU90S2ZmblpNcHg5QkhEUXlQRjM0K2ROdFRiOFp0ZVBOSUtLQjVYcCty?=
 =?utf-8?B?bE50OVFURVRPelBTQnFOVzFobHdNME5YVEpjL09FeE5HVUo1WXJsdkRKeXIy?=
 =?utf-8?B?NWhGQkM4ZjRGamZpS1lUUktnNldmUDl5WThWbXpQckxYTHJCNkY1YTBiM05U?=
 =?utf-8?B?N3hCUGlud0QxcW8vTjVjQjBLNlE1b2xCYkw1R1J6SDU3OEdBVkw3bUVya0cz?=
 =?utf-8?B?TnVxWlBGZHY3N1YyNXA3VmlPNTIvQ2tBUS9GSTJjbjZ4TkZiN0tNRkswUHZz?=
 =?utf-8?B?VXd5L0JXZnhPSi9xdFVPR0VaeURsR2lGZ2FicENPNlpLWTNYdzZHR1ZEVW9E?=
 =?utf-8?B?SGE0SzFmUXhUZXhaV1ZrREQ4Y0x1bFRiWi92b1QyL2tmSTNBZWtHU1JZckpU?=
 =?utf-8?B?ZXRtUTBQUVlCK1oxaDJDUCtDbGRpc0hqcTJ5eXhXbEk2Qk9kM29IUlR1SHc1?=
 =?utf-8?B?N0wxV1RJVzEraUV5OEJMVDVDVjVkOWs2bHFRTEMzLy9nMzRtQk9TUTlNTUhx?=
 =?utf-8?B?WU1IZS9YWjdhUlBUS3laQTB5OExKSWNrY3FxZldvOTd1b1ZUVW1ZbndzTmE3?=
 =?utf-8?B?WXUxSFh5UmFNVUlDU2F5d3RlMUJvbjZKckdUNWQ4elFwSGhoV2xMK3dFUm1o?=
 =?utf-8?B?SmdBN2JqREVRdnFlK2xINUdsNHhWRTVNRzhLdDVQaEFLQ0NMNzIxK2UzUHAw?=
 =?utf-8?B?VldlYXQ2TFZjWm1VZlhvbkdWNXN5TUdBdGVLYTBYcTdjOCtyVS91R3hKbUwv?=
 =?utf-8?B?U0x2NW5sOU8yMWJzQ0RIL3dIMTVGbWVUaUJIY1FyR3hwa2UrSlRBVXQyMlRS?=
 =?utf-8?B?ekFLUnJCZm1NVVNPbjhPalV1Z1hOejhnVGhZTllDOElPZG5uZUk1bzc1RE5E?=
 =?utf-8?B?UGRIdDBiV09WT2VHUHVRUlBISjBYSmRoMndicjRLV0ZpWEtZK2ZxME5DeGFG?=
 =?utf-8?B?TzBrRnVpb0lCL09oOXVWanczL3RzOGJsaGQ3YVJuNnNYQzF2bXM2RzNBNDUw?=
 =?utf-8?B?aEFNZWdnQVJtMTNiRm40Qkw5S3EvLzh2WmtlOTFZWEg4UUV0d2VXZmM0cENE?=
 =?utf-8?B?elVGUHpVNlZYMTF0WTdzNnNHZmIwNDVSVytwcElzbGhTR2daS2VpT2FFOU1E?=
 =?utf-8?B?WmVwczZnZTJqYjhOYVhnNGkxQ3JKNHcvVUN6WEo3cXhDdHdMKzlSTGdMTE84?=
 =?utf-8?B?emdscVJNZ3BUQzlkY3dwVmFVUXB0ME9tZFlMTVNPWFU1TWlZZUJWSmQ5Y1JU?=
 =?utf-8?B?QXoyWTNvOWJEblEzR0EzTEtVN3VPTEhZbnNBZHBlVTRybE9yMVFxY0daeE9j?=
 =?utf-8?B?MGg4WlVFQkxXU2w2cUZUYy83VllvdThQdytpR3RPRTZtL05MUEY1cC93dHIw?=
 =?utf-8?B?OFZpd2d4SjRYWExyRTZNMlVnNncxcG1paklEMzhhRFA0UlF5OXphV24vcU4w?=
 =?utf-8?B?SmN5bmZLaTRuSms2aE1yR1pnM2k5UW4rbnpnaFNyS1RwMTY3RlIyM3hOYXY4?=
 =?utf-8?B?U2pYVCtFcFdxc0J1SEJIOVhUc1dYTzZMSllqWUlXSlVNbjY3ZU9qcFh5Q1E2?=
 =?utf-8?B?dnovdFpIZjFTUkVFWUYvTTUrd0c5R1FNdEUwNFk3K0Z4RFIvaVFRZlp0NjBB?=
 =?utf-8?B?SE9PWVByVnU5ZTk5NFNVeHd0d1NIR0J0SG5oSmxwbVpTekZwT21Pc1JtdldC?=
 =?utf-8?B?YW9ZQnEwQTRZeXhWdSt3ZGxUM0luUDBVcWxQZHhTdmpmdmlHektLa201ejR5?=
 =?utf-8?B?bEZiNHRtcW5uOVhxaW5XS3JZdDFNSGhWQUUySWUrTmlqYjM1ejVUM0lOVUpB?=
 =?utf-8?B?SDU2RStMUzBETm1sbC9XTlNmM1NYVW9FSFdrUEtvQmlJbmY4OXBWQitReGlK?=
 =?utf-8?B?MlpjTTcyd2UxUi8rOTNkM0V2TkoyU2pDQ21QRzdTUEJITWhhYUUvVDhiRmt6?=
 =?utf-8?B?L1BwZnVSYi9xbXlyelNPZ3Roa0gydmYwcCtzcWlWYjVXampmWE9qVXd5OGdp?=
 =?utf-8?B?OGVpWjF0bW5OSW1mS1dTdXhKNFlISlZWSklhYnBaZ1VUTy9uajhEYlhVUllu?=
 =?utf-8?B?N2VCM2pmdlhXa0pkbHpyNGgvaEg0a1JZaEx3RGRRRGtmUlk1NU9uRnNHOTRi?=
 =?utf-8?B?ZlEwM2lJa2h2akxYVk5lWklNSDNaODNkOWloemVEbER2NlozTDZqUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76849a48-6ab5-40ef-cac6-08de8e706eda
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 15:24:28.5203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /8KTDlqCjeFR+RdvsNW5xcLr4HRFEw7L/+RkXBbkZQttAYmUj9yQyiWPqtC78T5CQANK5E5zgd+VtuBz/m52Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4170

Magnus,


On 2/26/2026 1:53 AM, Magnus Kalland wrote:
> Use raw spinlock for interrupt remapping tables since
> iommu_flush_irt_and_complete is called under a raw spinlock.
> 

I spent sometime going through entire flow. I think we can re-arrange code so
that we can avoid this lock change.

#1 ) alloc_irq_table()
    Remove iommu_flush_dte() from set_remap_table_entry /
set_remap_table_entry_alias
    Once table is updated, at the end of this function we can have a logic to
flush/completion wait.

#2) iommu_flush_irt_and_complete()
  This needs to be reworked to match device_flush_dte()

Makes sense? Did I miss anything?


-Vasant


