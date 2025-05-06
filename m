Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7E127FB1D
	for <iommu@lists.linux.dev>; Tue,  6 May 2025 12:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746534075; cv=fail; b=Ur+MmxJ8eFC9mFpSjC8iFBAqLOczcB3ArjSJh3caU9cCdAMQdOBjg3RXOUqK+HmT+gJ1rs847Heucc75UbcTr+SxjlNvYUAfH/VtdYXg0u25G8lt57O1f2Q2VyX6+wT+Fu3nixlP5VRnxVGuPqlAQsmOfNtGbeLvwfQWUQQS9aA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746534075; c=relaxed/simple;
	bh=26FqeUdPCy9+0PmZM35/xyBet6tc73hOkv4bmqW9Ji4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OHsNnI4YBQS+3ASNqk2eekMK93zHDFfoCoiOxxmB/fOf5t7QKXXP993m2nTfy/g0AvSSyyKjZiu67q9FI7cJnxYHUm/IBt//D2hxTgvjEuzraK+ZHo8Q2rOP1HV+yROY3iB24j6LWTSP5oG6UHFQl6Mi8O2OmEfjX31S1IXxIpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZQ/OJSaz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XhcOOKi1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZQ/OJSaz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XhcOOKi1"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 546CKosh002670;
	Tue, 6 May 2025 12:20:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=jkjliIqgXN4CyMr1oBWqo0hUkkiKPSS2pZ3HCfqz600=; b=
	ZQ/OJSazJuKYpg4UHIJxu9ylv2cp7q8KVYVAdzWvlt1O0K4HXX04v98Sm7kt3isb
	NCejKqxa4jS8LTCZbw+nVK+C5zBcnQ6gBB1y1Lt4f7K3AcvcuuSDEgWWRDQzTwwH
	1Hu/ARYmcCbjyCkjEBe8roVMqNUv13uaDf/g9oIeFxOKXn1w2OUiluCta0OG4WZp
	rLVvOgxMJ04dPHF8/vuZ6k8sM2Bc4Yg9p4y2uVp00gzd+SCsQCdYvkVsMT6FuXOw
	Dg+QHhscgOrwc+iOXjEEcCiIrc0ggyeCEdOldViTsFupcc2Z3JI/exZzanhYSA+p
	V8eO4JtLpKl1dp5lpM6oPg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46fhx781r8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 12:20:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 546C2Qve035395;
	Tue, 6 May 2025 12:20:51 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazlp17013059.outbound.protection.outlook.com [40.93.20.59])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46d9kf5vfc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 12:20:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f2IcNIZJGlioIRz0IblEJR9L+06i6WpDsBAT1nFa4QoVMDtw+AchlFoevLjGQ5fIEf22Tgyz7xie1xj/wwHeSJlYS2jOsDUjFK3XWJNIv3Q+LC8JgJQIZOFUOCbeJ+Nafnv6QDua1RaszKwTv8oLAPybTF3AkzeGhkvJslctXExf7SlSiJjAxc1Lg2/IHxarKz7nugulnuVF7Y8/4PFnDNcWI4sloLyuz4kY/pRkkqf+GyT5zg5IqvvnZKUdE/CLfqd4IAY123M2fcRGutewjswzF7+c7Ot+zbq6c/l4kcvZUF8crmG/rPh2cYSvH8poHLkGQFIXOGAoWuiql1tpWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jkjliIqgXN4CyMr1oBWqo0hUkkiKPSS2pZ3HCfqz600=;
 b=stk9P4ot6ls1C983HKKgl7kC/4dzD2paMiCcIKoVrXNDXPO0sftNLLHM4ur5CFqmyZ+xZpJTrYlq2aFWUE88YGpSg1PrmrEtC/dtR0/BBHr97ze1ZuX+9aw/UPZuXaiErr+ALhDVIkxY9BrGOvMydj8q2Uyp+l6g4nPtTLN01KhiHZwl1BJMZH2DWR1t/ECa/AxNed9PPbxTtzLP+QsmrQAA52ErAlnogB9cZMvabnsm1oeLsMrW/odAOZWPM+BTb4N/cF6e0kIOjjHVl3VjW5onN2PNqs2LXZPuGOpqjlgOPBmJatDzGHxVNGujdXOQkvEIaSe2P5MD+1Fv/FBXvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkjliIqgXN4CyMr1oBWqo0hUkkiKPSS2pZ3HCfqz600=;
 b=XhcOOKi1phuQt23G0cy0gyZhnD/cknZ6OiiUPuC/zNL30BqL0UsPZVVEn5DqiGp/k2Eh+GCwFSLWQCHv/O/rM/GeB5XysqcbhQoREouqgXg3R40TWqbqG4XH68HsdhX8kUkNEspqYysfAgC1IV6jviMibsh8sxvSST0eoYwJgCQ=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by IA1PR10MB6266.namprd10.prod.outlook.com (2603:10b6:208:3a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Tue, 6 May
 2025 12:20:45 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 12:20:45 +0000
Message-ID: <fd0dfb53-127f-4529-adf8-db03269d5798@oracle.com>
Date: Tue, 6 May 2025 17:50:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] dma mapping benchmark: add support for dma_map_sg
To: Qinxin Xia <xiaqinxin@huawei.com>, baohua@kernel.org
Cc: yangyicong@huawei.com, hch@lst.de, iommu@lists.linux.dev,
        jonathan.cameron@huawei.com, prime.zeng@huawei.com,
        fanghao11@huawei.com, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
References: <20250506030100.394376-1-xiaqinxin@huawei.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250506030100.394376-1-xiaqinxin@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0077.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::17) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|IA1PR10MB6266:EE_
X-MS-Office365-Filtering-Correlation-Id: daae49ee-a650-48be-9cf2-08dd8c986d17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QU5sMnpRMmlpN251cjVxczVhQmRvVWcvQVBIVlRlNXFPSm0vL0dNbzE3QUpZ?=
 =?utf-8?B?Sm9DdHZBdVRvR29ydFNpZmZTVDVEa2VSdit1OEo4V0gwNDlHdFJoMis0RnlD?=
 =?utf-8?B?MmNmN09zSjNmTjlpUlNxenYxRUlRUCsxQVdUWktxdkFzRjFmaGZaK2NwTDVV?=
 =?utf-8?B?cDJ1MU1XUEFDU2thMERBRk5RVmh2akV4ckxZQi93TDVDSERHRjNxVi9nSnVy?=
 =?utf-8?B?UXBBTHJFNTRSQXA5WjNqcW44ZEN5QUJkVTBMQkdnclRCQy9BUE0wRlQ5Vnhy?=
 =?utf-8?B?Y0oxbkFwa2oxMG53dWhtWk40ZWxyeWJvUGxWaXVQL3k3VklQK2Z2d3pqTUw4?=
 =?utf-8?B?OGkyZU1EUXRRd2VRVUx3SHE1NDk1bnA1Z0hUWUtCMmIvRm1UNG1abmVDNHdp?=
 =?utf-8?B?ckEzVGxwelZxZ0N2MjVQMUpHMnduNktkMDV3YmFQTEFzM3lYd3VZemZwYWxq?=
 =?utf-8?B?ajNDVjVNMDVibkRoOXMxamJ4VC9zbVlZRE9wQzBNR1FJQmJzaVhLWWtRVGM1?=
 =?utf-8?B?aVV3NFNqOWNZRXBsWjFoK2JEQUVlZEFHdi9EaFo5ZnpZcDV1YnUxWHN3cnJ1?=
 =?utf-8?B?V3FlYmZZekhSS1o3OGxtUUFxR0FrK0dhOVZaUjdHRTdXRytHY09wSE5wbExG?=
 =?utf-8?B?MEZoM1dQb0hoUGlYZi9YeC9lbzBUZWtHNTN2em1ybzBJamVsKzVIYWJlcHh1?=
 =?utf-8?B?Q1ZTRXBEek5CMm5kcVBZeFN6amsvSkt4dkI4bUxmSjcrTVRxZEUwcDdjQzlq?=
 =?utf-8?B?L0gxS3QwQytvZjN5MENFZUxodExQRlFTYnRCYU9EUDhaSnFQcVR5a2JXL0Jv?=
 =?utf-8?B?bExqSlRsK09hcVlvV1FmWVBaRmJoKzB1SGhSdnk5RmpPb0MydHhTeDBxSVMw?=
 =?utf-8?B?b1hVTmd2dGhIbFhIVy9VVFhwbDlUdnFadDlKTXhLL2Uvc2didGc0TTFUamxn?=
 =?utf-8?B?c2ZuSUNtYklTcHV3b25ZMlEwRHBDdFlDbnl0T2E1MTlGMXc3aVVvRERGeXpM?=
 =?utf-8?B?ZGhjQks3QS9oRExYMWFqM0lLc2tYM29UTWdZQlRMWUg4U0ZydEdqWW95Q2Vo?=
 =?utf-8?B?Vmx2UFV4SWlXSXBkUHlHWjR5NXhXR2VoM3RobGZNaGRDaHovZGQzajVvT3JN?=
 =?utf-8?B?TmxJS1JxelVkSElvaU9LQS9qVmJ4VlB6NW9UZFFqQWdHNzE5YW9yeXp3Ykk4?=
 =?utf-8?B?aTFTTGU5Q1Mxb0FyWDNLQmtVV1RGMzNkd1U4RGx4VUxmNUxFRm9qNzFDV3N1?=
 =?utf-8?B?ZElLaE5tVFBLb29PRG40eUtvdThEUFZWMG1nNjRYQ2E2RzBROU9BcmR0ZFZU?=
 =?utf-8?B?OXgxcUxlVForYksrMGFxaEU3R0c4dEVuV1pMMnhaeTVBL1VQZ1FiS2hlY0xz?=
 =?utf-8?B?QlBVanFIR3FHVFZaWXJkaTRGdEhmQzVKdm1LOCtQK3FvOFVXSVRGZFdPRVdE?=
 =?utf-8?B?SW1CYjdqT3BkNmFpejVDUmFQUVlaYml6TzY1YUxJVEdqKzBQemNtNlBJcHky?=
 =?utf-8?B?SUk5R1JWNk9KdlV4WWZFYmVEZGlTVFZoR05UUGFRQTV0ZG5pVzB5Y05Jamo4?=
 =?utf-8?B?UFJqU1lBUmtWcytaSEtsUndHSXRER21hUWhEWHlVYUJXeTF5dDdHOVFsRlpk?=
 =?utf-8?B?bWdNODRKZkZieXVMeldXelc4RUdzYmlmamRCaUo3OEQ2TmJZdi83RWlOZGN5?=
 =?utf-8?B?SXN5NHZOd2tYMkFFQXVFZGNFaW92Y014MXBUSmM4Tiszek1XNG1rTWV5dVRJ?=
 =?utf-8?B?dVptL3hjb2ErL2FPK3JFd29FUE9jQUx3YnpHS2R6Y25RdVovZG5aVnVnYndN?=
 =?utf-8?B?RTYzSzVIMzFDc3RlTmFxa3RZRWVhb0w5ZHJicjJ1SWRGME9jSFZ5dGk0blBh?=
 =?utf-8?B?OVhHekRrN3VVWkxualQ3bWtwdGkrUytWUE9wZWx4Z1B0L1dGWXpGRHFOcnlY?=
 =?utf-8?Q?O3cpXLIvzG4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vk9rS2FBMHpzY1A4SnB2aDZNVGFaVHdoQVRwaHhlQW0rNVdMb1BFRE90Wmha?=
 =?utf-8?B?V2dGbWFJZzUrRlRrTHV6Nm1zRE51MHdwMEpBSFg0MVh2dUUraE82am5sNi8w?=
 =?utf-8?B?ZndzUXRTN2xOSitvWTJqS1d1ZEttb3dyWVdQL0ptdXlCVTZtS29ENUw5VmE5?=
 =?utf-8?B?TmFzN2xHSExVVzRHVlZxUUIvVnMrM0hXb0J4S21ZRkxVVE9Ld1lxUGVmVFVI?=
 =?utf-8?B?aDNMU1F5VGhFMmVWU0V2Ui9ZRGtKZHhoZG9lWjBpZU1JRTgveXQxZjM0cTVa?=
 =?utf-8?B?cDJtNXRUbmxqZCtIT1RuK0lHdzBzYng5VzVqWFU0c0wzWmRmQ2kxeVpsTDhn?=
 =?utf-8?B?V2NacHJNbENoNTV2cU90MDhqcFdUUE94MThjczN5WGtSVGZrZXJDMzJzZTNE?=
 =?utf-8?B?RC9ScnZ4cDBVRnBCaTd0a05PSWhYSFg3cGdMY2huYlY2VGM3MHA3cWxJQ3dW?=
 =?utf-8?B?aERscE44cFQvbDNGTDJ3cTJkSTNCUE4xVmF5MjlZa1hnMkhRZW9CS2xrbzdx?=
 =?utf-8?B?YkN1RG00UjVWeVB4VzRvb0tUdGhMT1BsdWtxQ3NBYXRQeS9TYTBBVXJsam9y?=
 =?utf-8?B?U0t6N0Z3aE5yM0JNdXVNTHJzWVU0T2VVT3BpekxZZTY1SVY4UjhUVVA3c3Iv?=
 =?utf-8?B?ZFBuOWl0bDBpbkdISFF3VW4xNHUwcjZBWFgrNk8zOEFtOHlGdG83L0xMSE0v?=
 =?utf-8?B?Rkl3K0hZYjZ6VDU2UmZHRHZXSFZmQnZPTTU5aGExdmV4Vm5UMFVnZFAzejh4?=
 =?utf-8?B?UHV2bVYvMzVpYTdyREN5YnJSVllpb3pNSUFzeGFnd1FiM2traWJRUzl6LzVV?=
 =?utf-8?B?Y21YRkMvRTFnazM4TDZSMmdxbUxxcjZpWDhPendWN2VSUkxlQUR2OUNYVXdR?=
 =?utf-8?B?V3BnRC9MNFRCRHc5VTJCcGg2MGczMElESURKMVk0MlRVVUJPK3RQVlFkR1Fj?=
 =?utf-8?B?TUs5a1lGbVF0ZlBYL3BTWjVZZUpxeWdkamtwYUU4OHFhZ29FeHJEWUxwdU1F?=
 =?utf-8?B?NzRkQWpqKzBlYm9oYWZ4U1VsSVlxTnIwdHhwMzVPTGdkT29sUmpOdGdGZ0xT?=
 =?utf-8?B?L3ZWbUlvNHpCWGdlYzN1OEtqRFJ0WGREL1owWkZYbU1OQVJxSDhwYVFQNFVy?=
 =?utf-8?B?UW8vYWJYNUNKdG84d3NOWjl6U2I1WnJ2ME1ad3BONjZFU0hDMkc2M1hYMmVG?=
 =?utf-8?B?OHJobmtyOWg1dzA3RU9JTU93cWRlRFNxVmNhemNrOEdTalZsRWVKUExqaGFP?=
 =?utf-8?B?UE5BL3Noa2JhQldObXVzVFVmZE5UMkNDd0RTSmFTZCt0b3VCeFBEeit5R096?=
 =?utf-8?B?VVFGcVhkTk11dWMxbDJ6aWdSaFJXTzB2a0I5bjRhVVRVWnBXNTJKeG80cnZr?=
 =?utf-8?B?bEVxVWU3NTNmQityWlUyazZtbWJlcDBlei9GRVRYODNhcEY2ZHFvMEJ0d0FX?=
 =?utf-8?B?V2JHTDh0cEhsbFc5My9hVmNnKys0VmNjSGx6MUZITTc2SEQyZlk1c3gvdHJB?=
 =?utf-8?B?VS9KWGx6UTNCbXlMbmNualZXV3pHcVMweGErM2I5SW1ReGxKaWFWMW1yWE9X?=
 =?utf-8?B?dmtPamd2MHpyUnpIM2I3RXh3UVBjWk51KzBQeTlKU3pPaFhLTE1TKzFKY2dF?=
 =?utf-8?B?YUFnM004S1AzVkU1cHlKalJjUWZWL0hpaFRuSndXTTFUSzArMGNFS0l2dWQ0?=
 =?utf-8?B?a2svV2VTUUhZWFdmcElxaDJadTBHa0FVd1kzSlJWUVpUdFRxY1p4MkdoRi9T?=
 =?utf-8?B?WEM3NmNDVy8wd2twT1ZLb2ltdHlRRE5KNGFaaVlmaURoUDdJam9xQUlDajIw?=
 =?utf-8?B?R3JhZ0s1MjROY1VqZWxqVWszemgwTyswSUR5dzkzOVR1MWEzTnY5ZFlVUlNJ?=
 =?utf-8?B?YmxjZHhsNlFuSmlyblNzeXlaS0h0UEJFQnl4WEduQ2lzZU9aeFIzcmNWU2R3?=
 =?utf-8?B?UnUxOE0vUm9KblVsRGJuVkx5RXhmQk9zN1pINXk5Vm1pVVdweFVrVVdkb2Jh?=
 =?utf-8?B?M3duNFZISHFyK2FOYXZ5Q3gweEJtUERtOFdPTDNIRTJBOUNVaTU3WnlQS2xz?=
 =?utf-8?B?UFU5TTZBdzZ2Z24vZElWMFJTMkovZkxKLzBkUlQxd2RlWm1PU3hJS3JZWEp4?=
 =?utf-8?B?dmxIVjRyT21ZYW9nNGEvd1VuWWNWWTRrdG5hZnpxa1h2RkNrZnNudDBVWS9r?=
 =?utf-8?B?REE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cblW10G56306ASpniBl65b9yEpB8tzwhmPqT4v7IHMmK9txHs2pA4psgAqDwwzQPM3WBzOhCYL//pNDEh7lPRz5TU60PHPwdKHSYVQw4jKZIjxhrVvnC43zE1fu0MCEQLdoHm+jBHwbJcEHIi8yCsrvs3XeXTrjfIKfLkHpDOSjs0phrQo8jFnHlCyll+wWXpJ7L0E5zzouHYXQicAfGm53306HJVj0njxPtGSVFRFbkBNj7nntEo/x+bO0bHsQ0HTtUPv//4ugqV5rwvrAdaM3iQf7I/jxhAdZ9NriwN8OrxisW1JIRudgTiPlZ6JoQ9JL9rOk2OMGYmgOCCvPiwl42gXgPkU6SFoF3PAWWJrocgt/I/Sg0or6aTJsWinjSFcVQR8ijJHvi9rzWipdTZtKIh327DNVkZ9joMAycCxfN5ADKhBvsBz8Bl7DUNLq3vOoewcGIp67nG1N4eTX2eEt6GSQUh7CuMwOr03GyvnTVm0cPN7LkNkEwoWKSrk2M4TEmGQjOdah/JmbDYipoPhTiKrDGUK1Ezlgsyywm4fz837+CKYFlaFZtkFgWB1GCmzMtbCew6r2zZwHX2ja6CNZ8RAGd4EvYVJuAZk9PMss=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daae49ee-a650-48be-9cf2-08dd8c986d17
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 12:20:45.2885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dnL/sn5tHnVBqLA4uaPjxns3L9zNb43HBom9QbEeanrqOVPgU0gnJHu3YXT0RJHmFHxeSBQtYKu7hcMyWvsewq/y08TD+L/f+OCGqOldL6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6266
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_05,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=990 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505060118
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDExOCBTYWx0ZWRfX3Xy0AoIX0qSQ DZkTWKuj+y/2Q5DtnErU99qdxNqjdjEQtIlHqOe1iKekwFAv0o1AtnNL7+gRrtcHPyOPhujnblt zaF7ttTtCYH8oQ1VwI6+yqbuZ1kyD2j3ffcJ7Ujd1fkAoesDldiZmePzp+qqUZdr6EVkdVXRJV0
 ImQVDlhdGYbiOmZlex/N+drBqHWRtWqENQYGZw4WhTP6zhWZCb/fSZSP7NIIxLyBW+HnPl2YpvI I34qBqeHgCmfeeRmjy2onEIi3VhH/4CR2Flsdauv4BiYQEcg4fXCmusQIUuEinUaAA8SKyQkq/W Io8cCVoXwqSOfvgtlmyjLU5FdAsyGDXNLh6FIoPRqa5BShP56QRv9DYM0U/MA0MLDofsWpLsesj
 3DO7jGEa338BxLiqH+BGk6Ch7CrBBBuKePBTIpl5gfn3fwFtUjxDZ1Xl4JJyzWW8YY8dehFQ
X-Proofpoint-GUID: A7ihrK9msLQxzGoAwZe6JwDIm8UJdJDt
X-Authority-Analysis: v=2.4 cv=NKjV+16g c=1 sm=1 tr=0 ts=6819fea5 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=YyVXlWMO_t96yycCChEA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13130
X-Proofpoint-ORIG-GUID: A7ihrK9msLQxzGoAwZe6JwDIm8UJdJDt



On 06-05-2025 08:30, Qinxin Xia wrote:
> Modify the framework to adapt to more map modes, add benchmark
> support for dma_map_sg, and add support sg map mode in ioctl.
> 
> The result:
> [root@localhost]# ./dma_map_benchmark -m 1 -g 8 -t 8 -s 30 -d 2
> dma mapping mode: DMA_MAP_SG_MODE
> dma mapping benchmark: threads:8 seconds:30 node:-1 dir:FROM_DEVICE granule/sg_nents: 8
> average map latency(us):1.4 standard deviation:0.3
> average unmap latency(us):1.3 standard deviation:0.3
> [root@localhost]# ./dma_map_benchmark -m 0 -g 8 -t 8 -s 30 -d 2
> dma mapping mode: DMA_MAP_SINGLE_MODE
> dma mapping benchmark: threads:8 seconds:30 node:-1 dir:FROM_DEVICE granule/sg_nents: 8
> average map latency(us):1.0 standard deviation:0.3
> average unmap latency(us):1.3 standard deviation:0.5
> 
> ---
> Changes since V1:
> - Address the comments from Masami, added some comments and changed the unmap type to void.
> - Link: https://urldefense.com/v3/__https://lore.kernel.org/lkml/20250212022718.1995504-1-xiaqinxin@huawei.com/__;!!ACWV5N9M2RV99hQ!PZwCK7yspP9AzXLsodEKNp6_pWU8ir6IKfsJQJIpvfLQdOrNgjLpwNySORdXdT1JJFAbo82SMmIlnnYI3tSpGQ$
> 
> Qinxin Xia (4):
>    dma-mapping: benchmark: Add padding to ensure uABI remained consistent
>    dma mapping benchmark: modify the framework to adapt to more map modes
>    dma-mapping: benchmark: add support for dma_map_sg
>    dma mapping benchmark:add support for dma_map_sg

I noticed the subject lines use both "dma-mapping" and "dma mapping" ?
Could we make them consistent?
> 
>   include/linux/map_benchmark.h                 |  46 +++-
>   kernel/dma/map_benchmark.c                    | 222 ++++++++++++++++--
>   .../testing/selftests/dma/dma_map_benchmark.c |  16 +-
>   3 files changed, 249 insertions(+), 35 deletions(-)
> 
> --
> 2.33.0
> 
> 

Thanks,
Alok
