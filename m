Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36CF19049B
	for <iommu@lists.linux.dev>; Tue,  7 Jan 2025 06:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736229818; cv=fail; b=Hbn60Nv6mrKrXWlWkR/nKFBCg1bbMmNLxlZbpqF+qs55QgWbQ6UIEAAlkgQUzdW5Ljkq2OsIp+KettCoTqLrqvGws60XIfpsjAr41s+L0jbv4CnJBFhCOwUFYWbQzgB6bO8zNPHwSD1TlSvrQLLFxtUaQMX/mhokGvvgw3o7fgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736229818; c=relaxed/simple;
	bh=DEW8yNKO5huPj+HuMzM6qu31faWCKOulkFkUwpGg9K8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YpKlpW0TEkOsG1jK4JMjemSxQsngNd58xUmu5/Rxt2obsWxSIHqIUTZkp+Ifv2kIuhMwV+tkYM6GkuKpbvFOabPy22JK++7McYanzZv4nxm0x9eGFpmxCxNYtRAMR+81mSUzNp2tmgaBG/bVTE3PTAM5ZPYaosmJw3hmT1nEZpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Jf9vfDhk; arc=fail smtp.client-ip=40.107.92.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Jf9vfDhk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FCTO6cSOlrJpFqEuRI9I4o5YzE7gvBtn7p9q4xRLXtiS9QDgzuvRO1mtdDyKXv+HbKxLW/+F3z8SpkYzKkie4LHgp9OBMjgAtU/W2rpYbwHeSkti1kNYI/gKE/suQdeiJT+vZWVkyl88HTAMQ6kCm5jXP4ESvmhDxwD56fw5SFYOd9b7uzuEi2jL7VQN7Eo5tZ5lbdbgAwKSYrIgI5FBVEyND69VuWOMN7MzXz1OqPVA97/rV6ah9G8bYFAL09ckwJePIhMqX2T1HtCGSRekuU96XFS9/ZVCdnqWE+Qs1gooszyh7K/rc7l20inUyyDseiAdtCkIQloNEpStPsfSFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FtyXzzl05btPe8kveOfImHhcWL3IKlNDASnrnlPd2zM=;
 b=HfiXTWJbQNjHDkBhoQMxHhC4Z/3lE4B6HuMwloUQfVrRcQf7kk0hvwx3MXGpg5YTvBMr43KhF2xivSK/1cPE5/hxoIFjM4a1t0ypNDvIM8nFbEwk7NbSnQeT37cVlcaNEruanmsLWaiNYdaJFWHwIIyr+tkwnHFN8SRftwn7KhFGxSKYAr0o9Lw4bvjox3uIhxeIVyGGsBQxpTnEOja3jglUXy9oS9+kbHqZ6oFadGW/+UvpSAQIOuqLh1/prPe1rlKsOrKBrYyKYS+HqUAdE7vm0EUdnM0uOOIrOtcrLN25nI7e06cA50x5Zyn6nbsESyA8JqQYGy7FuWQrKxVl/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FtyXzzl05btPe8kveOfImHhcWL3IKlNDASnrnlPd2zM=;
 b=Jf9vfDhk6EwAjBOdjNgRCYrVjtbhxxuRe+rINbmqWNCimwaPHzKu59bmKyyEa2XHYPwCvr0hz/0vu9gQOqvy+Elckev+WzS5dAWFg6/+awlDmho8d/JmzpMYlDbUo5+5Jbj0edcmxBZ6CYmV5ZGXLhFzYUPxrOFdcxDKYQZQ+94=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5163.namprd12.prod.outlook.com (2603:10b6:408:11c::7)
 by DM6PR12MB4369.namprd12.prod.outlook.com (2603:10b6:5:2a1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 06:03:29 +0000
Received: from BN9PR12MB5163.namprd12.prod.outlook.com
 ([fe80::61ca:6d43:a98d:3b7f]) by BN9PR12MB5163.namprd12.prod.outlook.com
 ([fe80::61ca:6d43:a98d:3b7f%6]) with mapi id 15.20.8314.013; Tue, 7 Jan 2025
 06:03:22 +0000
Message-ID: <35ff7361-f5e6-467e-b027-bb2171d49d4f@amd.com>
Date: Tue, 7 Jan 2025 11:33:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] iommu/amd: Add debugfs support to dump IOMMU
 Capability registers
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: joro@8bytes.org, suravee.suthikulpanit@amd.com, will@kernel.org,
 robin.murphy@arm.com, linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 vasant.hegde@amd.com
References: <20241126205952.GA2656341@bhelgaas>
Content-Language: en-US
From: "Srivastava, Dheeraj Kumar" <dheerajkumar.srivastava@amd.com>
In-Reply-To: <20241126205952.GA2656341@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0234.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::6) To BN9PR12MB5163.namprd12.prod.outlook.com
 (2603:10b6:408:11c::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5163:EE_|DM6PR12MB4369:EE_
X-MS-Office365-Filtering-Correlation-Id: 51692f10-b297-4703-91ba-08dd2ee0fdee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M1JwVW4zOEpiZUFZVHRxamgwVnVRTjJ5UGpzQkl3UzhIaGdrdEJrdFUrTjNM?=
 =?utf-8?B?b2tCWWY5cnZPbGJFZEd5V0UyL2tmdkd6dWY4Ri9lVzBCdk1PbEZGN1VDZEN3?=
 =?utf-8?B?b3U5ZnFwS0hOajlIcVQ2Ris0ZS8zd29lUUVCcHhQWjJPMDB0TUw4cm9vYU5P?=
 =?utf-8?B?bEZzRWQ2TWxzd2ppZ3ZEQk1jemJvVmpsRVQyTG4yc0sxZlBDV0ZCSkZrbmhY?=
 =?utf-8?B?aElwOUJmK1Z2M2N6aXAwN0c2MkxTb2hvL0VYcUh2dGgzU2xtZWxnQTR0ZjFG?=
 =?utf-8?B?T2czQThsS08reFJNaHhwYThxZEJIeU1qV2IzMG9EN29DNkhMRXMzc3Z0R2Zn?=
 =?utf-8?B?c1JaN0k5SXdZYVd2WG9pNXdUVGUxZ2FkUDBjdDJOMVcyRzczdzZnVGNHbmZX?=
 =?utf-8?B?K0M5OHdlK01xclUxdnZzZjVmZGJzVy9pZVBHK2dsU3ZJeWFUeU5BZjFNRGsw?=
 =?utf-8?B?cnhqN0Rad3NWU1pjNDd5NS9iMGJhczZRVWQzZWU5VjU5N3dvckpEOWNtNEM3?=
 =?utf-8?B?ZzM1cnhiSWZSM1hqRDBXNHRiTFhxcXlQUStxTzg4WXZOdXBha1VXc0JxTEJS?=
 =?utf-8?B?QUhjeldYeS92TDduTDY4VXBJRWRvdDd0V0gvcW05S0xiWWZXOTJxSW9UN2hl?=
 =?utf-8?B?TkhKaVpDdG5na3Vhb2pTUW1ENXR6ZVFUNzdxOFRoN3RER0h4QytkNkNLc3Bw?=
 =?utf-8?B?RzlqVlYvYlY1UDFaNzdkajlhc0tnalE4UXVhQzRIZTk3L29yQndQbHJITWlv?=
 =?utf-8?B?Y3NOejZzZ2l6WEdhTVVxQ21yN1BrMmVJWERITXhhYk1NbTM2ZU5lcitwUXZz?=
 =?utf-8?B?Um1OV2tDWllHSmdDQVF1YkpiMUdLditRWU84TDV3V3FPMlRhYjVYUy9FUE5U?=
 =?utf-8?B?S2o0UEtmRnM2R2p6bzB4VDZoTjJTN3dJejllZitMQU1YZ3VnUXBDR1lRRGov?=
 =?utf-8?B?Y1p2TUZkbVVHYU15Z1BQeXRNR0FrL21KcVphak11eExRQXV2MGt6Y2hWMHRr?=
 =?utf-8?B?dUtBWVgybEJ3aU90UnBITUNpZk9QRWlOeVJiZFZTRkc3R1VveUY5ajNPdjd0?=
 =?utf-8?B?U3E1dGo0TjJKVGtrUXJpK0JrN2xMSUN2VTJHbFdDa3F6cFZPbExlakE1ZUlV?=
 =?utf-8?B?aWVXRTNzM056SHJ6RnJ0VGRQbWRyNEJxL0lOcDF2Y0ZrQTBtL0d5SU93TjB5?=
 =?utf-8?B?RjBydmlNZ3JvdEltUDlQZjJWN2lsRlZxL2p2eHZNUDgxRHY5NDEwMTVudFJL?=
 =?utf-8?B?MEtwYTVwNkRkOUgxQy9CYVdvM2ZBQ0lUR1BVRG56Wk03dXR5SHpGQzV1cmYv?=
 =?utf-8?B?NkFOQ2pwclFHWWhIN0JzQVFSU29RMkRwSVBZUGMwWVczUzJoSlZDUlBtTy91?=
 =?utf-8?B?VWpoREtQU2U3cnlCcUY5bFdTY3BUcCtEbkJqbWhMT2hBS3hlZktadG5TdWlY?=
 =?utf-8?B?aS8vdk1RUFlvOHQwNDlvaVNpVWU3T0kxWDdXYXAyc2w2ZERPaVVtNzIvN2VB?=
 =?utf-8?B?cmthV1hYYStjOC90NUxVcGRnWnZBTCtRR1R1NDNRMmltRWtpNUJZZERQZ2pj?=
 =?utf-8?B?QVp6cWFnenY1SEpheE5LakF5aTd3RyttNkJoeDZFSDNQd0lvWkZRUS9YR3dn?=
 =?utf-8?B?TW9FT1oxMDQ3NDI3Uk01MitRNWVOczJYemR0V0t4eEJCY3FNNWMzYUo4NVhB?=
 =?utf-8?B?T0ZOcnVuWnBqQWlVS3RBM3VOR3lQU3hXdVJxaGFYSmJWV3ZsUlluN0lWdzJB?=
 =?utf-8?B?eTFXU2dZNjVoZ0grQ3ZBamltMVV6VlkzcDN1VDc1NHZkUFBXZm5mQlJqbFVN?=
 =?utf-8?B?VWZicit4M3d3UUtwWTRVUEI2a0VKZDUzR2cyemFnVW11Mk5MNTdTSFhycllo?=
 =?utf-8?Q?i7zS/ZKCD/Fct?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2tXZWFQYWt5aDNxK1lld0hqenI0SEFWT1B5QTBVSGNOQlkyVVJhWVlvNXRr?=
 =?utf-8?B?ejVuWjhHRUkyNS9qc0JsWHg5WnNaNWFWV21LRmF1bWdYN01FR3VtY09VanVR?=
 =?utf-8?B?NVlVTWliSXJtTm1hK2pteDZVMDUyRUxhTk9oOXRlNzRQMW9yZks5VzZIVkVx?=
 =?utf-8?B?cTg5alYzdjlxQmx2aEZLT3oweDNEdUNSckxjQStlY2NoZjNxcjQwd1dtLzRK?=
 =?utf-8?B?TERVd3plbWpIZmcvQ3BuK1FraEUxSGpLWTh0NmlxaytWYXYrNTJ0T1RvOStG?=
 =?utf-8?B?b0JVamFiUVBacGIwWllYeEIzbzBZS3phalBLbHAxTWFpejFmY0ZrZnoyY0RS?=
 =?utf-8?B?S01nZmtLcVBXTjkya1NsWVE2ZXFzWE01UDBoMTBNOGlvakhJSGcyWG9vUzd5?=
 =?utf-8?B?UzliMFNQVENickt5SVNyeHhHZ1hubTBWTk5JSWtHY3I2Ukpxa0FpaWI3Wm1I?=
 =?utf-8?B?djZqMHE3VjRDSUtTL1hpT3ZyRzNsV05qeWFDdGlkUW1NTXZFMll4WXkxR05a?=
 =?utf-8?B?MlZybU8xbm51ZGt5eTBJYVhNWWZ6MFhtbXJxd25oOHNtL0lRVC9mRlM5ak05?=
 =?utf-8?B?WmNNRnpqZnhLTmsreWI2RlpNZ3ZJbkh0TWtYUGFHVVhVVi9IWTFEVmJOWGtz?=
 =?utf-8?B?OTlFbHpBQzYxMDBiMEZuUUVTbTFpK0l5cHZkYUI0YnZrM1krb3dmOVdETmZJ?=
 =?utf-8?B?WXVhZnFqUXRuaEI5RmFSTnZqeC91TmNIeEJXQ0hxZGFFa2hSODlDTGwzRG5T?=
 =?utf-8?B?cktFMTM4QUdXRk1peGZ0U2haTDdnMk9YaEszWlJaaWpSK1hBZFhHVkJrU01h?=
 =?utf-8?B?L205dWt5eTAyT0NBNXl0NDY4OGtoVitOMnhxS0U2Zk1KYkllWWZDK2Z2RGZY?=
 =?utf-8?B?azRCTmQ5eXRzbGRQb1FEK3owS2hQNmhYT1JNMy9LbzRyeSsxQVZLaG5veUFv?=
 =?utf-8?B?VmwrL0VCeTA3YkVJWlVHSHlwb01VWUJVUlVzdy9DK0hNbzc4cTZob2hvNEtD?=
 =?utf-8?B?VkxCYlpZWmNqRmIyb0JmaURLZVVUWWZJVkM0eDFWWEI1QURqdnlHcU9CczR4?=
 =?utf-8?B?Z3BHYThsUjBFV0dsbDlYbHJWY2gyNG43c2s1Z25TZHdOd1VCRXI4Wm1Xbjha?=
 =?utf-8?B?WEZLWVd3N0NpcEp6SE9ER3M5YmVCanVYMU96OFEycGFqMHNPMmtPRkdGa1dz?=
 =?utf-8?B?dlliQ1pldXRNOUVHbGlqRmtPSTBpSWVZeE1lUGswUTBQaW03TFdUeHFKNjRJ?=
 =?utf-8?B?MjFSdERwNFBxUEF3V3pyT2NjRThTOEZUSHJjMmd5c2p3Z21UdENobSs1RnVt?=
 =?utf-8?B?VTVkN1hEZTAvZW00Zll2VHp0aHRpQ20wNlQ0QjZvS29USEp2MFpDdzJxOXRm?=
 =?utf-8?B?VlVCVFhvWXNsQXBGMWNWbmIvNHRwdlZyZmhCVGFNTDNKTnJqSml5cUJKTUVs?=
 =?utf-8?B?Q055WUlPZmpRaGUyMjJhbjkzOUZIQlk3d0gzazF6aUEzS0hMWFE5cGxSaU9z?=
 =?utf-8?B?YThVbTlUMkhZbm9CM3VLZ2VCRW4xR2VKVDJPUkNzakZXNDFnbHNlbUd5NjRk?=
 =?utf-8?B?ZWJmZnYrZmpEZThvdjdUU1BoQW9DYWt3WUxhSjJuQUhkMmtOeU5nVFhXRjc5?=
 =?utf-8?B?TmhrWExXd3dwWkVIODBzOGREdDlKTnhzSkpXOUViM3AyZXRXUVJZcTJFaDhi?=
 =?utf-8?B?VlFCM0RaYTFBa3oxV1RTYmpaY2xqTGJLaVJpNzd0Q0VKZ2xqdnphOVpaNUV2?=
 =?utf-8?B?a0kwMmxscHBLN1cxa1RON3pYWEV1anpKS09mY3RCR0pSSjN0c1VBeDVRNmJN?=
 =?utf-8?B?VFBoaUloa2praFl1N290VDkvRDBCZXF2eFhHT3cvVHhGMlVTK2YyOWZTaHRN?=
 =?utf-8?B?YWlwTVlVZ2NpUnVSdkpONWx3QzVGbGFxb0VPWUI2Ykw5aWRxcjEvREs4b3Q1?=
 =?utf-8?B?ak9iSkJyNUxXTzRGbGhZMWN3c21Bdk9nUEpYYmk5bG12bmtFLzBVVVo1ajkz?=
 =?utf-8?B?anlyUENZbzF5azgzL2hUUmFSc29zdnliakh6ZG9MWEErREJLTS9idmovTGRy?=
 =?utf-8?B?ajZmWDlmMUlBbWhYYnd3Zm93RTRSbjhwTkxkcXFJMXRUd3R0L2lrZG5EVUls?=
 =?utf-8?Q?Zl8qB4hoXotryU/34Sv+VsDyf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51692f10-b297-4703-91ba-08dd2ee0fdee
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 06:03:22.7258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7EVIaZzAdZqRId+F1OEw/pOcsV4Q+PExXQoMyYMzziokqUekXESqx7gR6mONjak83KfM7HW8jWW+/v7YuxBuZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4369

Hi,

On 11/27/2024 2:29 AM, Bjorn Helgaas wrote:
> On Wed, Nov 06, 2024 at 01:16:34PM +0530, Dheeraj Kumar Srivastava wrote:
>> IOMMU Capability registers defines capabilities of IOMMU and information
>> needed for initialising MMIO registers and device table. This is useful
>> to dump these registers for debugging IOMMU related issues.
>>
>> e.g.To get capability registers value for iommu<x>
>>    # echo "0x10" > /sys/kernel/debug/iommu/amd/iommu00/capability
>>    # cat /sys/kernel/debug/iommu/amd/iommu00/capability_dump
> 
> Same comment here.  Why does this need to be so complicated to use?
> Can't you make a single read-only file that contains all the registers
> of interest?
> 

Please do let me know your concerns and views on my comments in the 
previous patch.

With the implemented approach we do need separate files for mmio 
registers and capability registers input/output files as to understand 
if user input is mmio's offset or capability register's offset.

Thanks
Dheeraj

> Bjorn

