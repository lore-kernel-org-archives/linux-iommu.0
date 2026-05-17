Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012054.outbound.protection.outlook.com [52.101.53.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EE22E4257
	for <iommu@lists.linux.dev>; Sun, 17 May 2026 17:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779040196; cv=fail; b=UsaR7Gscd4iZcbxeM2bNitedWXu/9vnyvZZXBBvIp+hczqFNDUMJpHnZTFgiLQgvlFty44mU6+7vNCxEaObcdNkRd65bUpaDfRxMVioq7mEw0jNeZyRQ+bsIx91MvNzNZaSbTSnlJ3iJVpo3yNgjNLKT7/pkfZIyKBrgzsazfPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779040196; c=relaxed/simple;
	bh=eQ8TmNOBf2mTReG+gbFkrNh4FVbOYNRet3O79oJpYpo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PiuC6B9W3m6LG/smZ0paEnRox8ywmOo8I3k5CsNOwNzqnQzXREDms/i0eaL1HnSA2XwNlZ5DwCSi2Nys3NEBEWBuk9hWl42tXPLo+wHwF4uF4UvVJOoZCKpEKP5FSJ4FZzpXafBvaSYxA2k1eWTiBIcEhCplOy2xFMTZg3IBAXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=egru8cW3; arc=fail smtp.client-ip=52.101.53.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="egru8cW3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hoNuJ7jmjr7aeO85vmuMZrqyus1GbvQiH0uVkM1GEauQu13nsdWu3AQzNs30P+7P/pv7ZVlE+pB68k5xFtlF/j+yhFzli3l3i1dtpuMB8ESxv47kWwhh6wf+IngSvEvjvkOGp3ueYZGFxqce5Q3W1RG7wMjgCgXrWhj3tRcm6bnEg+zi5jbKst0HRoXQaq4B4mB4+6AqybXUmS6at4EVwsKcF6A+FRXyaRysHoydQe0kRYOSv3RbutYOWUGxvtJrMeAl3dvIYQTpdkGDwlSkh/mY3qQF4LS9EUA1HdcHsANhg9UUqhkN45f5MQY3uQj4jcsA4OIH2t+wXtq/9sJoHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQ8TmNOBf2mTReG+gbFkrNh4FVbOYNRet3O79oJpYpo=;
 b=I3Vm2Aam4gr9Z0dp7vvsHyZMbieJTYz5ZEdh4X084+FJL0tBL0yCJ8sr5W/HQoI1theb2CNIjlmcmQziiX0DgJJH/fqYrXdJsqiGBk50/OQPTo+Xe0aN/evI0HcXNARJUKzo6RKF2wO8ep27VXId2gB23fadnkMk0jva4WWLDftL6UWwnEOx9sW+fLaZ5uVeD4OvVXM6C0nmrX+NgsvjGQZO6Dml82jhiIeMldj7pWnHLXGC3CRfEzMgb80QCG7AB0MzD5W0h154wAaYZsy8CC82zJuIJZlIZWNP2XNCQ3729y3TSKev18D6RpPTOHn5JY4zByce/HddTxKqMTv6uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQ8TmNOBf2mTReG+gbFkrNh4FVbOYNRet3O79oJpYpo=;
 b=egru8cW3uKbWuXhhTnR83lfuAGcx6OURC9FZEKp/lSyW18AIbu2IWcz+XwTVgoUqpg7qJCSL/6Xii7S2w+350H0mvH9moA5lIJhwumquBPSVQuwLq371UIFdAlPcBuEnpklXaQGE2PqnbTtZRmUjxi0PWRTMoK4H2F1OMk02iZY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5754.namprd12.prod.outlook.com (2603:10b6:208:391::20)
 by LV8PR12MB9183.namprd12.prod.outlook.com (2603:10b6:408:193::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Sun, 17 May
 2026 17:49:52 +0000
Received: from BL1PR12MB5754.namprd12.prod.outlook.com
 ([fe80::b080:4c1a:f6e5:4564]) by BL1PR12MB5754.namprd12.prod.outlook.com
 ([fe80::b080:4c1a:f6e5:4564%5]) with mapi id 15.21.0025.016; Sun, 17 May 2026
 17:49:51 +0000
Message-ID: <67ddc0ee-eb21-4bfe-9d12-ceda0005db91@amd.com>
Date: Sun, 17 May 2026 23:19:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] Respect VASIZE for address limits
To: Ankit Soni <Ankit.Soni@amd.com>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>
Cc: suravee.suthikulpanit@amd.com, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, linux-kernel@vger.kernel.org, jgg@ziepe.ca
References: <cover.1776075533.git.Ankit.Soni@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <cover.1776075533.git.Ankit.Soni@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0021.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:179::10) To BL1PR12MB5754.namprd12.prod.outlook.com
 (2603:10b6:208:391::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5754:EE_|LV8PR12MB9183:EE_
X-MS-Office365-Filtering-Correlation-Id: e2b41590-71d9-4f76-2bed-08deb43cb22c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	PASybJYwqQ4XhbJTt8KzMY6qBqwa7p810v8lktD8/UMSZcU4S6ZPHg0NDxkUrjwMyResNNQXg/E2uhROLAhv49dQ/H8FG9klrpVX6FGa5aHtExfnT+tEGkxTf5Kxm1KJVxAh5VNO84Dc/FMZ/6uPuC+jK2LmLq7DBjZao+CLHSNJ43dvQMhQBh5e1RaFOKi8AamkUsU4OJxKEWvBaiozxhETg9oCw2pFR/QDY+sdP9CBj/pekrxoFLYzh9+4XH3RE6yi5QTqw/5Lr9jN+ALRQ7m3s4OZOAyFWLoKGehVqPgK5wVm1nIlEB4C4PqvskPEtpFNUiVYTDVpb1Jys1hLzDyzJa/3CHJOyyGz3cSHwQN85EDa0ExyDeOUcyvNgcHShLKQr75VzZUKQ5XJS/yMdHGPeyser9VVYvt3wXAUiIDjMhaKZ3f/Fap9MaKUit4W3KmaBbWp9xi9DjOqYnabvzcTWx/XMu5+VZfU8zPQxCzmi+2akVqbStz0Yiyoryvcd9Y/Bj2o/V1bFg2BocQE+0g3WEQrkrRXXIJucu9kN5D7n8N9voaLeY3zo1teMk2d78DH9OtWwt8pOuvhiLNynlmqYWMxc4L/zatpFNspCMZ/x8yHrUy0hnjN52DuBeSbEXeQjU6D7tFbL+wnYc6goTxcoc3kYSGh4HA+aOtZwO5MaysnpfEt2O8J6LpVGaaU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5754.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RS8xSnFIby9DdWwxd1hOSjhISUZNS1FnYzRTOGtOV05hQlZveG0zaENTMzlZ?=
 =?utf-8?B?bW8zMHVHNFBBZmkrcFVNZ1RvblJxY2JMVnRqVUlCK25xcEN1QXBaN3h3R1dP?=
 =?utf-8?B?S0ViV3pQYUJRcFdtTElpdmh5ajB1bnJVcHhVZW91RnFrZGVhaEdwU0trZFU2?=
 =?utf-8?B?N2tybmZQcExESFR5UThlUjFmMWQ4UVlZTk0vZk00QmluUWhWNjJoemVZU3ky?=
 =?utf-8?B?UkxENlRWSlcwOEVFZmthZ1ZyQlRXWlZTa1psMmU3Q2QzS3FMUDJhaktSVVRV?=
 =?utf-8?B?YkhjcE9hSFBZSGl2ZktNZ1d5dHMrOU5WaGR0RzZnNE1iUjJsb3RvN3dIc2R6?=
 =?utf-8?B?Q2dydS94bGxNd0dCZUs2L2padDc4TE1LQzIzUlpNSDExZVpIWlNUTUt3cmZp?=
 =?utf-8?B?UzhmY1lTajJ3K2U4UGc4Nk4raCtsWFdVaDh6MG9wRWw2Z3hPZzJMZEZCS3RH?=
 =?utf-8?B?dENudlMxWFFWMnJCSTlkVlQxTlhUWHFUNG5SVnBoZnRXNVB0V1lWZ2Fta3lM?=
 =?utf-8?B?VnZ4RHlCTXJkK3RzRDM0YmNSQ2lSL1lvWUpITFN0ekM4akUzZlR3OGExTWJz?=
 =?utf-8?B?bzVKR2FjQ2o4azRRZEpXcmY0d1V4MEwzcVV2N3Zrd1k4Zm9uVEdpRjdybUI4?=
 =?utf-8?B?RURCSHcxUURwRmkwUU8welBPYUFqOEI0aHpLZExVdmdTVEwwZTZEc3pyQVF0?=
 =?utf-8?B?dmFlQkpWZ3FUOUdxTGNaVzZYZ2JOWi9HWXVPMGZwNXJ4NFhBbzg4cGMyZ2xn?=
 =?utf-8?B?RU14aHJtSmZqZkxiVktGLytIQVBqd3o5T1pDY01WSk1UdGV1Qlk3V3FmNi9l?=
 =?utf-8?B?RllTUWtrWU1zUFh4MUk3dEMybldiSVBraURZMGRvaURhaDc0dnlmTjY4M0hJ?=
 =?utf-8?B?aUpSMERLZ2tzelUrYTVKbFprTEpmYVhBazRDVW5tMGsxNnVNMFNBcHc3MUU0?=
 =?utf-8?B?MWwyQ3lyb3BnMnduanRoeEFwMHR1QlJtMG95Z2w2S1RESGlScHBVVDhGUGQr?=
 =?utf-8?B?SDFlT0NzVDhnbWhvNGQwZVlQcFQ1eWNUQTB5Tm1wQzNPVjk1Sk0wUC9TMW9B?=
 =?utf-8?B?S3ZUVHBveWI5cEtLVlJIYTNrVTBaUDlLY2lDOWpMSmljZy9kS2psSXErd2pC?=
 =?utf-8?B?OHFiSDJrTDNQUllVUktRMkdDUVk2cWVRSDNhSCsxVW5ROUVqbGRsSzVEc213?=
 =?utf-8?B?QjU3R1Rva0dNRWhQWGgyaFowTlNYSG5LeVhJNFFad0ZJeGJISW1Nc3V2NmRo?=
 =?utf-8?B?Q2dnK25IazlFYXNvV2tGUjRZblkyeEZwR1V1T1ZLMnlDczBrdUo3ZmhtRFcx?=
 =?utf-8?B?K2NOcDBWRTRGeGp4ZXp6elpEQTZUa0MxOEFMVGtpOWtGZHVwLzl2R09nL05Q?=
 =?utf-8?B?VTJaeHp1eXBaeWtBeTErcmR4RFZpbFdZL2psbmNUTjNJdGRYdDVnenZSOUxh?=
 =?utf-8?B?eWw5ZUR1bElhVEVldllxcmJpNURPY2FmcDJvQWtXYUtrOFRZeEc3SndmMEEr?=
 =?utf-8?B?OXJFMEhFSk5McTNsN3VGbkRwSVJ2c25xMXRFK2NTbnpGbU85SWN5MVZhWGdD?=
 =?utf-8?B?cU1wcXc3UGVBYm5VbHpNbEdOaDh2U3ZIUGNQc3hobCtDMk9ZRnNpZnc5OTdk?=
 =?utf-8?B?WGFsN3VFczVlbitaOWZGZGx2d1NpR05GU1RXZGxReVc0ck9iMUg3QitIQVBS?=
 =?utf-8?B?YXJRYjdTakswRFlOczBHTEpMTGNWZTY4U3VkWXphRFVCVG5SZnV6UC8xOUNs?=
 =?utf-8?B?V2dBVms4MEx5VTRQSlNHbW5FRnNPOWVPUmVxTzBZazV4bFlpT0RCd0FxdFI1?=
 =?utf-8?B?STJuTnFLTlZ1dEoyc29mRmIrRzN1YjlwN0FGbXdwaXJxVlNUZnR0R1Z2Yi9U?=
 =?utf-8?B?bW9tRGtRM2NkRUVqM3FPTGtmdUcxazdGN1d3ZFBodlZhbGxKZ3BTeExCdmpF?=
 =?utf-8?B?TURFNWV1UDV2YnRNa0NOTzFXNmxqUFRXdCtYMzJQYjBkSiszNlMyS0lyY2VC?=
 =?utf-8?B?L3ZEZFJWYk9DSW53RzBkL2orWXRxdUlrNkQyZURlMGJvZU1HaHFqNGpCZVBj?=
 =?utf-8?B?dUg2K3gzWUNvZ0V1T1pPN1kzUVFOdHNlU003clg5NDBLeG9SZTFuWFRMTVhu?=
 =?utf-8?B?ZnY4OFlQdGEyMnp6eVJ0WU8vQlp0Sm5aWFREZnlKN3V2aEVLY3lUL2FQTXNN?=
 =?utf-8?B?M2JJQTcybEhWSmtlblpKOUFtcVo5STNVZEhXekxyM2JoWEpOa01xTmgzWTRy?=
 =?utf-8?B?RTU5dXovTVFZSWJud0M1U3RQNWgrYVdaQjBWNDNTRlVtaE1GMFZlUzZNQmkx?=
 =?utf-8?B?eHJxeE4zQzhEejFqMFdvaVUzRG9mVENqMEcwTllvVjc2WnhoUzVFUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2b41590-71d9-4f76-2bed-08deb43cb22c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2026 17:49:51.4519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QG5WRoiOPOBLtmmpWJo3OdNjWEyAQzZAYzpE/l2HTok/V9Smmzx4yf7DHPj+kQR43nTJ9BLkCbj1mid+FV/Nwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9183

Joerg,


On 4/13/2026 8:15 PM, Ankit Soni wrote:
> The AMD IOMMU driver was only using EFR[HATS] to derive the VA size,
> ignoring the IVINFO[VASIZE] limit. This could create domains that
> exceed the bounds advertised by hypervisor. With this series, driver
> respects IVINFO[VASIZE] when determining the addressable VA range.


Can you please pick this series? We will address Jerry's comment on PASize
separately.

Thanks
-Vasant


