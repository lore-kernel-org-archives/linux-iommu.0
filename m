Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022107.outbound.protection.outlook.com [52.101.43.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9668F28EA
	for <iommu@lists.linux.dev>; Sat,  1 Mar 2025 02:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740797152; cv=fail; b=g/j7jyt7xWvEYXiD3y1WubE3+vWPfMKrw9ToLnSg0cp26BMlY1BqSk3cgs0NoH9TZbaEe3VvcFBujkrSzvFrj/CxKqhmYn7/aFkZea8kfh7bST1ZAgIimSeiTnEpUswaN05hdqMP0DKr0jBSM5Wm0o6/bdpTHhD3PH/ts6TY4ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740797152; c=relaxed/simple;
	bh=N3B29GXoGiGAPMVGNdO41Emhr7ba9i+VbSr2o7xrN7w=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G0n/hI/crhwfdXHtQDdgO5mr8+v5sxhCrmRsEgvtf761cXOcpxR6NzRyMBKdVYl+9t+mG5eRQWjKBtS9+2Y04QGMTEwLew5PM4B7MdfAAPN/WE2O/eQJV7HmRiZweeqNJJk4jizFrZozKE1IQ3O5AY/f/xGHvtY7phq1jdIh9HY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=m1uTliyN; arc=fail smtp.client-ip=52.101.43.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="m1uTliyN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eIcxoWK+q3uYNyab0Ljfw/7OYi7vYskcvfDwFWF/A4lwDM5lBTXOW4GRhCyWEhqGYE9vQTD6HL2XfvdTjFt4jHpct/3YYdNYZe5IlA3nTIoGf6sIiKM3uThNnG4jlPBFwGVa2QLRJ7eGW6SYoRZs+QBN97jwYEe4UNWG2kKy+FVhmGfKVkFu4ma2lp1oEfNe8gFiqFhK0o/Gaz8qHOL3jNJH8UqkWS93o2eH5ifYnCAbsEpEbleW2tZqv33ukWvyWUujI8Ed9S2a+naiQD+X3m+r5IqHXtFgO4ee7kfrfBcTaX7qbugN8THp0hYIrjTWfpU5PIqd8evJ8nbeOXaEcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3Auh1dinL3PfZj8UOpkN4bujlhOYCzBSa1y7pIZ5X0=;
 b=NZXai2J12our9eEIJirin+PSeGZ2W4jl89Z2NghyMdSLaMZP/Emr2wbTFFjMDl5xOC1IjHKTITPCSro52oWrZXB2tuGFfR1ShBhIpG+6QZRJVP9OXI5eN2o/C2HWhLDIAALUTs8502AiltS9TgFUZfFQMikntgs5pJFiJgn5WsfeMLP5yqZuq4YZ8ZM8Jxr243bO47vNHU3YgPhQ71ItrMJBXU4bdL3KlktxtwvN87l1w64OJSmxStlxaZEE6ZH8RlysiK0KLIfRLxBjooGvaIh0tDrnd4GfjDl2ChjIdIYYqeetoK56vnn/NAE4CkMTb+ybtUfk/diERLrFv5k/hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3Auh1dinL3PfZj8UOpkN4bujlhOYCzBSa1y7pIZ5X0=;
 b=m1uTliyNgy5OMIe92XySz4Inx1zkqsW/pMTwZt377gR2ljcbP2WtzoYPZn70uqoIZt5MwY0LiogX1zfuO+bEVrMItNzV6GXLprlZnAyyDbxW+ezO/HZnoSSm5/o4yQjx/Vft27Igsr5wxagE8PcHrD5eBvb7DkD4Q9cJiytTHKo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 SJ2PR01MB8207.prod.exchangelabs.com (2603:10b6:a03:548::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.20; Sat, 1 Mar 2025 02:45:44 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%2]) with mapi id 15.20.8489.021; Sat, 1 Mar 2025
 02:45:44 +0000
Message-ID: <223a817b-66dd-4182-838f-a186b059fe41@os.amperecomputing.com>
Date: Fri, 28 Feb 2025 18:45:38 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] arm64: Add BBM Level 2 cpu feature
From: Yang Shi <yang@os.amperecomputing.com>
To: =?UTF-8?Q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>,
 ryan.roberts@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com,
 will@kernel.org, joro@8bytes.org, jean-philippe@linaro.org,
 mark.rutland@arm.com, joey.gouly@arm.com, oliver.upton@linux.dev,
 james.morse@arm.com, broonie@kernel.org, maz@kernel.org, david@redhat.com,
 akpm@linux-foundation.org, jgg@ziepe.ca, nicolinc@nvidia.com,
 mshavit@google.com, jsnitsel@redhat.com, smostafa@google.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
References: <20250228182403.6269-2-miko.lenczewski@arm.com>
 <20250228182403.6269-3-miko.lenczewski@arm.com>
 <c572a93f-0899-4fc7-9764-d3e76e9fe6d1@os.amperecomputing.com>
Content-Language: en-US
In-Reply-To: <c572a93f-0899-4fc7-9764-d3e76e9fe6d1@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR17CA0018.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::31) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|SJ2PR01MB8207:EE_
X-MS-Office365-Filtering-Correlation-Id: 23da09cf-6b13-4aee-579f-08dd586b296d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VXFCdnBXeEJqZzYvc2g3Snc2Q202SDFEcUMxME5qcDZlcTc5bk0raXFKK1dh?=
 =?utf-8?B?ZFpMWlo4T1R1TTc4Rm5pNFk0SmtSd3ozWjFaNlNVUDR0ZVhEY0d1YTZHVHZl?=
 =?utf-8?B?WnJVMWwvUGpuYWFpYTBIU2FNcmx2TnpXcjBnS3lUNGl0U0ovaHBtZmVyOHJF?=
 =?utf-8?B?L0ZsRHBQTHJBemNsMW96Z0FwRWhSdnRlUmtZU0kwRndpQ1N2d2RMbmZmd2xt?=
 =?utf-8?B?Umd5Q3RRRzFUMklTdDJVa0c3SDgwbzgxdWp2dSsxWVZ5S05uU2lxVEY2dEFh?=
 =?utf-8?B?NzZodm9EUTR6eHN4MDlOWGxFTjE2U1kwMDRBVUR1QVJoQkFDVG9vMW8vcTVY?=
 =?utf-8?B?QlF0aS9lTEdIM09RSWk4ZDVoUFZaY3JCZng2WFNoZ2l5V3Jva3JvQUtYVjQz?=
 =?utf-8?B?WWJkYm1MYm1PVUo5TnlNUkgyU2taak5hQ3lmUitKV0xqVXhudXBZQzFtQ2VQ?=
 =?utf-8?B?YkczRDBxNzVmTmRNTHNjWVFkc2J4TzNMRGx3ZzFXVEhPbUlTcFhsQklDT3hC?=
 =?utf-8?B?c2FsYi9SZVl0UzJmQVU4cEE4L2xva1ptWE5FUms5bjV5S3JYTlpGeWpTQ1RX?=
 =?utf-8?B?VGtsS3ZlMFU4RWZHT0NZMFlMbTIzRXVMVXgraGI1aXFtTG01MVQ0b1huR3BC?=
 =?utf-8?B?QXlMY01qTElhMUJURHNzMlB2ditmV09xZm5rdW1MWUE4Y3laMUdyRXNWMVlJ?=
 =?utf-8?B?Qm1wNTZsQThxNFJQRnpQZTV1b2cwN0x1bGhXRC8wbnJrSy9kSEtzeFIwWmt0?=
 =?utf-8?B?ZlBFd2hjSTVua2JXeFFUNXF5RThCWHRjQWlveDIvZkw1cUFxUHUrUTBZQS80?=
 =?utf-8?B?bElPYXV2SWRzUThIVUR0UW02NzNqczBVckE3cVdsMElHNUhudlFsbzdmT2N3?=
 =?utf-8?B?YnRtTStQZGEzZzFlYXh3d1hrMGNkSXliOXNjcEl1bkI1WkR1cjdaVzZvbHVQ?=
 =?utf-8?B?djI1aVBYeUFDYjRYZ2c4d1UycVB3UDJXcVZGeGhpS2NqaHBMS0c4VGNqNHV2?=
 =?utf-8?B?dHd1Z1RzemJka29WWXFpZnU2SVJielF0N3BRc1RmaTZGcStTT3hyUHh2SGlZ?=
 =?utf-8?B?QzdEWit1dkdxVGRrdkVQdnhsNXBscTF6UFl2S1ZMZXN2VlJzR1ZZMDhBTjlj?=
 =?utf-8?B?dERQcUVXTzRGNHhWSnJYK0tZenRVcUhvbDV3OWo4NnNnR2s0R0k2MTlDR09R?=
 =?utf-8?B?SVl4MjJOVzlQdzdqRHgzelRZTEhKS2ExTG9uci9BaTV6MW84YVdHYmQ4VWJO?=
 =?utf-8?B?RXFTRXpuQ3BnRk41eHllZVZXZTQwaHBoRVF0QW1wZjZBMTJuLzY1WXdac1Zo?=
 =?utf-8?B?K0NBZzRuTmJpNEQzL2hOTzBZeFZBZUhJc3QvOWJ2NmJsek5BMW55UHg2b2tz?=
 =?utf-8?B?eFFvdXd1SHhCWm55cUphTHh3M09hUVIreFpuVEc5b3F3Y3Qxc2cxQXJTM2Jn?=
 =?utf-8?B?bS9SNlVselhkb0lTTkFuSENxYkMxNmhaUTFIQ2c2TnJ6ckZ0ekhIZnVPTGM5?=
 =?utf-8?B?Q1N6WWcrell6OHRIWjJKTWx6eGNHb1lOQnk4dGtsMjlCZllQcEVOVGNLcUZ4?=
 =?utf-8?B?V0NhVVpBbUw2dmlhczI0aDEvQWJaTDZocEFMYlNYRzdjQXJUd1dKbGpya1Jj?=
 =?utf-8?B?cjV1WUVYam8rbisydzNpNENaMnBrVkFNdlhyejM2OUNRTXB0YnMwYzZiYWRO?=
 =?utf-8?B?K0ZtOFFTV3ZtY3ExMyt1SDlXV1lVenB1VjYyRjRxYndkdlZNT1Y2WUhRcHcr?=
 =?utf-8?B?c01ZdmdzNGdpOTV0bmRKWVlScVVmdzZJa0JBT3RVVUFzNHVNRFdIaFJyL0ww?=
 =?utf-8?B?RWF0QjdLV0ZmbUFDZis2MjZhOHNWakhvMU5WZkdoTU9SVXdxb1NPWW1waSto?=
 =?utf-8?B?MERaS2x1VjVWMWM4d1BQQ3RtUDdrc2lDMmV3V0t0VU56S2ovUkorYzNWS2N4?=
 =?utf-8?Q?4KjWnmOI480=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QjAwV29BUlgxK0hxMEhWM2FmYXpIQ3FRdG9Fd05DczdKWkg1cEEzeCtad1NW?=
 =?utf-8?B?K01KTGpHTTdhU2t5Uml0QkJMR09oZW0rekJhK0JVWHlaczl3elhabExGM0l1?=
 =?utf-8?B?d2lxWkRpd3A0bmszdTNJc2NycmZJRnFGZlVmMGJydy9IVmUzYldIWUR6RXRY?=
 =?utf-8?B?T0kyOTEzTUM4amt5SUNWSkt0NlBrT2VqYm1iSGtoSEN6U1h1eXF4TmJyOG1V?=
 =?utf-8?B?NDNNOWF0bFlsS0lFV2YyZUk0eE15Syt1WjVlUitmK2dDdWJ2Y1k0SzlyN3BD?=
 =?utf-8?B?N0JBKzdzOUQrZnVVam8rY0txZUtzNVhGWDdCdWpJOEhKeFRwR0FxR1czUk5U?=
 =?utf-8?B?SVdYYTNwSy9yZmVvajhaUmhJV3ZrUjRyV2N1bXBTT0s1S0tGQWNVZkdZSWs2?=
 =?utf-8?B?UnZuQkN4M002bEt3VHJidGRJTXVnOVZCb1k1emVIN1BJL0diUUNaSUtwUy9i?=
 =?utf-8?B?MUVyMDdmbXp2WHpYVjExZm5PWGFic2xEQ0xldkxhby9mTi84eFVJRVhYYXVl?=
 =?utf-8?B?SlhEcmpRUno2aDVCTFhvYnZtOXgvaVZDZ21CWmZlckx1MzdFRXJBRUNrZTly?=
 =?utf-8?B?ZEdTeTkrbUt3T2VqMkt2S3d5NEExaHlKWUdNdnIzclFlWDFIK3ZRTEpwTk5k?=
 =?utf-8?B?ak1KczZJWDgvYXVYb2oraEFPUTdzaTZNcVF0SUZtRk1pRVAzYVpDQTVncW5w?=
 =?utf-8?B?WDh0UjVMYWhMZXFHOXpQZGVCaHFIMDlIT3ZJdUJoQm1IbVdmd01qcmV6RUk0?=
 =?utf-8?B?bmZsanhyZ3lLVndyR3BZUjdjbzZDaFpzQmgySDVkSVhsdkxnbjl4aUkycEVC?=
 =?utf-8?B?VHlxSzNaeW1PVndRVHBncUxYQUsvR1NGZVNRd05JU3JwR0Y4eVlFV1hlZ1JY?=
 =?utf-8?B?NDBDeFRLeVMremJUZzBvZTJsdTF3US9IakZCMWRMRlhuZUxVSS9GS0o1Z2t6?=
 =?utf-8?B?aUp0QXJFZ0U1YTdkVUNLWHVJaWN4dHoxWEduNW9taHVTbk43M21RWGNrT09X?=
 =?utf-8?B?WWp3Q1lCUUI5VVh0V3ljNEFMVEtqdUNaWVBPS0l6cFN1SXJTZkgzMkRaZHY5?=
 =?utf-8?B?YmdOWmJ6eDF4a3JxL1NmRm9lRmFCeG5icnVTN3dNcUd2UnE0cDhGeDZybEx2?=
 =?utf-8?B?Zld2OVpRdVlWK1lUYUE3akt0SkMwc0lFTGJWOXp2V0U4V3g3YUx0aVB5Q3Qv?=
 =?utf-8?B?RnAyREZjdFBmRXpKbjJYRDhBVjJxNkFPMFhzYnJzWlZFTGlBVlR1Z2hLazZs?=
 =?utf-8?B?amZwKzZ1QmlmblNYWnhNVnVtRXhxSDhrMDg2L1liMjFFTEJvSWZEMUdrUHlC?=
 =?utf-8?B?MFZkMXV3RUo4c3Z2eGhCWGNoN21aZFF4WXZaQ0UxUmVFbU9YTmRmb3Z4SE5P?=
 =?utf-8?B?TFlmc0ZFSW50QXBCdXMrQ0IwWnVkQ2hEY2RwZWVqcW9OZTJXeE9DSVZwT3Zq?=
 =?utf-8?B?SVVvL3hUZ1RQZUpZNFp4Q0lvZHV1blRGcTROWWEyTUJuQ2FQUmhzT0VaQlgv?=
 =?utf-8?B?RlRVb3NtU29TTEVvVUpGVmo3RzJsOUk1QlRyekl6UVNkTXVWZGkvS1VDdVQ4?=
 =?utf-8?B?NUNYay80bjJYRlM0U0FUOS9jUHZWZEcrOWdxNWRKcS90UjVYbG5HdDdhL05h?=
 =?utf-8?B?NmRsZmEwckMrRUNHMTRlcUMwczhETUk3Qi9OMW1ZWkM5Wlo3emZickVpZnBx?=
 =?utf-8?B?ei9PVEN0WXdVRTNlRXB2TUNGMjV4RE03N3A4UVo0UDRvd3B6SEZRSVlaS3Ju?=
 =?utf-8?B?eWhFODJoS3VsUWlTUXRnckcwZlJDcjVPYVh5RGxuWDA3MFJpQ3lTVTBjUHpM?=
 =?utf-8?B?VXR0eHhQRWwyUU1rZ3UrWHNJS0JiTmV1VDg5eDRzb2RwS1J0Y1FBVXhFaDlZ?=
 =?utf-8?B?L1VQNElpdkdZMGxZQTJwTFQ1OExDSHZEZXhqYUVmMHBNUTNoV1JzdnZsQTZy?=
 =?utf-8?B?NzZ2bnZIL2k3enJwdzJ4QkdBL2w5UnQ4V0R6WHRYYmkzSEhiZHhkby9TVDY0?=
 =?utf-8?B?VGkyV2xHWlFIcmlkSTVyNEF1UGxSalBGSDRRV1AyQVpXTE52WDY1cjZIMHFF?=
 =?utf-8?B?cGVJWmI0YURsbG1hcStqMFZLZ0NqTXZZU1NSQjhUVmJTaitscHNxMWFHOTlF?=
 =?utf-8?B?WnljSDAvbmhRcWlQZHFUdnFTKzd5SS9qdkZSakxKT2p5MmdRUVAvcEZkVFF1?=
 =?utf-8?Q?vg7ftAYdPbGPUhRJUfvjK3Q=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23da09cf-6b13-4aee-579f-08dd586b296d
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2025 02:45:43.8301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bcda/StlLF+wzzK3Dd4Y7wN7MVLwcobqboBxLkpEfZH59RGccX1eXIyTvLPvjPNCYcs60XfufKBfiwSDf2+dEMsBM7SNexXbqNeXpgUtlt8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8207




On 2/28/25 5:29 PM, Yang Shi wrote:
>
>
>
> On 2/28/25 10:24 AM, Mikołaj Lenczewski wrote:
>> The Break-Before-Make cpu feature supports multiple levels (levels 0-2),
>> and this commit adds a dedicated BBML2 cpufeature to test against
>> support for.
>>
>> This is a system feature as we might have a big.LITTLE architecture
>> where some cores support BBML2 and some don't, but we want all cores to
>> be available and BBM to default to level 0 (as opposed to having cores
>> without BBML2 not coming online).
>>
>> To support BBML2 in as wide a range of contexts as we can, we want not
>> only the architectural guarantees that BBML2 makes, but additionally
>> want BBML2 to not create TLB conflict aborts. Not causing aborts avoids
>> us having to prove that no recursive faults can be induced in any path
>> that uses BBML2, allowing its use for arbitrary kernel mappings.
>> Support detection of such CPUs.
>>
>> Signed-off-by: Mikołaj Lenczewski <miko.lenczewski@arm.com>
>> ---
>>   arch/arm64/Kconfig                  | 11 +++++
>>   arch/arm64/include/asm/cpucaps.h    |  2 +
>>   arch/arm64/include/asm/cpufeature.h |  5 +++
>>   arch/arm64/kernel/cpufeature.c      | 69 +++++++++++++++++++++++++++++
>>   arch/arm64/tools/cpucaps            |  1 +
>>   5 files changed, 88 insertions(+)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 940343beb3d4..baae6d458996 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -2057,6 +2057,17 @@ config ARM64_TLB_RANGE
>>         The feature introduces new assembly instructions, and they were
>>         support when binutils >= 2.30.
>>   +config ARM64_ENABLE_BBML2_NOABORT
>> +    bool "Enable support for Break-Before-Make Level 2 detection and 
>> usage"
>> +    default y
>> +    help
>> +      FEAT_BBM provides detection of support levels for 
>> break-before-make
>> +      sequences. If BBM level 2 is supported, some TLB maintenance 
>> requirements
>> +      can be relaxed to improve performance. We additonally require the
>> +      property that the implementation cannot ever raise TLB 
>> Conflict Aborts.
>> +      Selecting N causes the kernel to fallback to BBM level 0 
>> behaviour
>> +      even if the system supports BBM level 2.
>> +
>>   endmenu # "ARMv8.4 architectural features"
>>     menu "ARMv8.5 architectural features"
>> diff --git a/arch/arm64/include/asm/cpucaps.h 
>> b/arch/arm64/include/asm/cpucaps.h
>> index 0b5ca6e0eb09..2d6db33d4e45 100644
>> --- a/arch/arm64/include/asm/cpucaps.h
>> +++ b/arch/arm64/include/asm/cpucaps.h
>> @@ -23,6 +23,8 @@ cpucap_is_possible(const unsigned int cap)
>>           return IS_ENABLED(CONFIG_ARM64_PAN);
>>       case ARM64_HAS_EPAN:
>>           return IS_ENABLED(CONFIG_ARM64_EPAN);
>> +    case ARM64_HAS_BBML2_NOABORT:
>> +        return IS_ENABLED(CONFIG_ARM64_BBML2_NOABORT);
>>       case ARM64_SVE:
>>           return IS_ENABLED(CONFIG_ARM64_SVE);
>>       case ARM64_SME:
>> diff --git a/arch/arm64/include/asm/cpufeature.h 
>> b/arch/arm64/include/asm/cpufeature.h
>> index e0e4478f5fb5..108ef3fbbc00 100644
>> --- a/arch/arm64/include/asm/cpufeature.h
>> +++ b/arch/arm64/include/asm/cpufeature.h
>> @@ -866,6 +866,11 @@ static __always_inline bool 
>> system_supports_mpam_hcr(void)
>>       return alternative_has_cap_unlikely(ARM64_MPAM_HCR);
>>   }
>>   +static inline bool system_supports_bbml2_noabort(void)
>> +{
>> +    return alternative_has_cap_unlikely(ARM64_HAS_BBML2_NOABORT);
>> +}
>
> Hi Miko,
>
> I added AmpereOne mdir on top of this patch. I can see BBML2 feature 
> is detected via dmesg. But system_supports_bbml2_noabort() returns 
> false. The warning in the below debug patch is triggered:
>
> diff --git a/arch/arm64/kernel/cpufeature.c 
> b/arch/arm64/kernel/cpufeature.c
> index faa9094d97dd..a70829ae2bd0 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -3814,6 +3814,9 @@ void __init setup_system_features(void)
>  {
>         setup_system_capabilities();
>
> +       if (!system_supports_bbml2_noabort())
> +               WARN_ON_ONCE(1);
> +
>         kpti_install_ng_mappings();
>
>         sve_setup();
>
> I thought it may be too early. But it seems other system features work 
> well, for example, MPAM. I didn't figure out why. It is weird.

I just figured out the problem It is because the wrong kconfig name is 
used in cpucaps.h. The code is:

+    case ARM64_HAS_BBML2_NOABORT:
+        return IS_ENABLED(CONFIG_ARM64_BBML2_NOABORT);

But the kconfig name actually is:

+config ARM64_ENABLE_BBML2_NOABORT

IMHO, the "ENABLE" in kconfig name sounds unnecessary.

Thanks,
Yang


>
> Thanks,
> Yang
>
>
>> +
>>   int do_emulate_mrs(struct pt_regs *regs, u32 sys_reg, u32 rt);
>>   bool try_emulate_mrs(struct pt_regs *regs, u32 isn);
>>   diff --git a/arch/arm64/kernel/cpufeature.c 
>> b/arch/arm64/kernel/cpufeature.c
>> index d561cf3b8ac7..63f6d356dc77 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -2176,6 +2176,68 @@ static bool hvhe_possible(const struct 
>> arm64_cpu_capabilities *entry,
>>       return 
>> arm64_test_sw_feature_override(ARM64_SW_FEATURE_OVERRIDE_HVHE);
>>   }
>>   +static bool cpu_has_bbml2_noabort(unsigned int cpu_midr)
>> +{
>> +    /* We want to allow usage of bbml2 in as wide a range of kernel 
>> contexts
>> +     * as possible. This list is therefore an allow-list of known-good
>> +     * implementations that both support bbml2 and additionally, 
>> fulfill the
>> +     * extra constraint of never generating TLB conflict aborts when 
>> using
>> +     * the relaxed bbml2 semantics (such aborts make use of bbml2 in 
>> certain
>> +     * kernel contexts difficult to prove safe against recursive 
>> aborts).
>> +     *
>> +     * Note that implementations can only be considered "known-good" 
>> if their
>> +     * implementors attest to the fact that the implementation never 
>> raises
>> +     * TLBI conflict aborts for bbml2 mapping granularity changes.
>> +     */
>> +    static const struct midr_range supports_bbml2_noabort_list[] = {
>> +        MIDR_REV_RANGE(MIDR_CORTEX_X4, 0, 3, 0xf),
>> +        MIDR_REV_RANGE(MIDR_NEOVERSE_V3, 0, 2, 0xf),
>> +        {}
>> +    };
>> +
>> +    return is_midr_in_range_list(cpu_midr, 
>> supports_bbml2_noabort_list);
>> +}
>> +
>> +static inline unsigned int __cpu_read_midr(int cpu)
>> +{
>> +    WARN_ON_ONCE(!cpu_online(cpu));
>> +
>> +    return per_cpu(cpu_data, cpu).reg_midr;
>> +}
>> +
>> +static bool has_bbml2_noabort(const struct arm64_cpu_capabilities 
>> *caps, int scope)
>> +{
>> +    if (!IS_ENABLED(CONFIG_ARM64_ENABLE_BBML2_NOABORT))
>> +        return false;
>> +
>> +    if (scope & SCOPE_SYSTEM) {
>> +        int cpu;
>> +
>> +        /* We are a boot CPU, and must verify that all enumerated boot
>> +         * CPUs have MIDR values within our allowlist. Otherwise, we do
>> +         * not allow the BBML2 feature to avoid potential faults when
>> +         * the insufficient CPUs access memory regions using BBML2
>> +         * semantics.
>> +         */
>> +        for_each_online_cpu(cpu) {
>> +            if (!cpu_has_bbml2_noabort(__cpu_read_midr(cpu)))
>> +                return false;
>> +        }
>> +
>> +        return true;
>> +    } else if (scope & SCOPE_LOCAL_CPU) {
>> +        /* We are a hot-plugged CPU, so only need to check our MIDR.
>> +         * If we have the correct MIDR, but the kernel booted on an
>> +         * insufficient CPU, we will not use BBML2 (this is safe). If
>> +         * we have an incorrect MIDR, but the kernel booted on a
>> +         * sufficient CPU, we will not bring up this CPU.
>> +         */
>> +        return cpu_has_bbml2_noabort(read_cpuid_id());
>> +    }
>> +
>> +    return false;
>> +}
>> +
>>   #ifdef CONFIG_ARM64_PAN
>>   static void cpu_enable_pan(const struct arm64_cpu_capabilities 
>> *__unused)
>>   {
>> @@ -2926,6 +2988,13 @@ static const struct arm64_cpu_capabilities 
>> arm64_features[] = {
>>           .matches = has_cpuid_feature,
>>           ARM64_CPUID_FIELDS(ID_AA64MMFR2_EL1, EVT, IMP)
>>       },
>> +    {
>> +        .desc = "BBM Level 2 without conflict abort",
>> +        .capability = ARM64_HAS_BBML2_NOABORT,
>> +        .type = ARM64_CPUCAP_SYSTEM_FEATURE,
>> +        .matches = has_bbml2_noabort,
>> +        ARM64_CPUID_FIELDS(ID_AA64MMFR2_EL1, BBM, 2)
>> +    },
>>       {
>>           .desc = "52-bit Virtual Addressing for KVM (LPA2)",
>>           .capability = ARM64_HAS_LPA2,
>> diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
>> index 1e65f2fb45bd..b03a375e5507 100644
>> --- a/arch/arm64/tools/cpucaps
>> +++ b/arch/arm64/tools/cpucaps
>> @@ -14,6 +14,7 @@ HAS_ADDRESS_AUTH_ARCH_QARMA5
>>   HAS_ADDRESS_AUTH_IMP_DEF
>>   HAS_AMU_EXTN
>>   HAS_ARMv8_4_TTL
>> +HAS_BBML2_NOABORT
>>   HAS_CACHE_DIC
>>   HAS_CACHE_IDC
>>   HAS_CNP
>

