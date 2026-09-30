Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011068.outbound.protection.outlook.com [40.93.194.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5F719067C
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 13:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790776273; cv=fail; b=FcITxSH7JmWWDIQv9k3t7A29pI6QhipEqgmBXIkItjFdfjFyiwf+gq+DsAgdS+DKR7GVDqfc8crr5GkwoLlSVirSk9i/6MzzAZ/xGm8Q7vM8uG4YVJItBDMViaQEAo+0Waki5pEqOI5ncHz3ickrqDwUYWmBjZf3E/4lyoj8BVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790776273; c=relaxed/simple;
	bh=ltOhaxlk0hfydFoHB/Mfi2cSHwx7ZSugTmXt4cI8qts=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uGhj+gCgza8YjqEnw6cZv0Kfa+ynfydmYVcArLRqm5QaePCfnfzJfNiWAMux/s9tO5DR+0ig1ZFGPJpEAdnBMQJz0zXcDugkq51w8QKRQP39VPB2Oq6ccJlf97aYMnsqL2lDaRXxn0fBlgsKJM5TstdfKGICrYaA5EoWUaa3W3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pSTSzOvU; arc=fail smtp.client-ip=40.93.194.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pSTSzOvU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ys6eooxCpk2S8rEVeoenU02U+K8etKb8hdOvP7VR0Z9PnGPQuCYSCWupcNc63EdAqOzAIRV02tU5D7VxYfWN6W/56Q2ddNALGxL+cU4ppH8IKg2aLynR9A4hyxJCoonsSN7yU6aSgaBsOX/IMyTmWnV6+E5nvcwZqeKUAKdd2rTGAr6bN7nTREhFiUkcvjLDC+iChiJYm7E2v17lBYCq7uHgK5KRuU+e3ENob2edadAH6swKblnbIE85VSW18XMz1LK7AaI9IgQH3nVrAMGr1Dol954JlpWRz8Y2AtnSFf7Go8X6F47Nq4Sdw1hiO9+Xn/POH3Adx3dJ0t7DH5aN1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/y0qI3jnvdjYEkgCQM6tmxUzgOmBG0blMlshJOPCU0=;
 b=VabiZexT/RbPOWdyo5htCgC0R81L0MkABd3KzYDfNdrtrCJWHXdw4rdw5863U3aZcgfhDapzqupmwr9GZHtpJzXKlwM3yrKNy7KFuNO7rXOfyY96NgnDyUMcn/opcTaI1VyDoP2w5IRJQdZcAZfHohw46KEh8sGbRY/+6+2cOeVJ2vaApa/C87rh4DIP+F9JBwTFASnwx8Jm0/WynqbMHQmZ5BnNreTZUpvlW03iaMOtSD9W7oxOpAVCqSMQvkzjWXsP3QWheZ2QDQNYjY3XD+UnOQ7r3QmWIxT4WTg2VxZykfThQQJ1tif9WLea/uB0EFARJnIyE7f6Kgt1SoGKZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/y0qI3jnvdjYEkgCQM6tmxUzgOmBG0blMlshJOPCU0=;
 b=pSTSzOvUuU9YR6cJhtCL8SP8IRo5NVHyPcd/G8VVVrRcresmU/L+QjV1gQNvZAG8NGn3leBWG3+Np35Pm/SV+H7mkbFKvFIl8x8cRY3koKgxs4CG8J68Qfm2q6S2X0Ovna1H5zKbhlfatWferWawiTtQPyWXxPCW7riq9PW3zsE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by CY1PR12MB9560.namprd12.prod.outlook.com (2603:10b6:930:fd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 13:50:57 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 13:50:57 +0000
Message-ID: <9891d6d8-cfbc-4453-97b9-ceca7fb3ea56@amd.com>
Date: Wed, 30 Sep 2026 19:20:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/amd: Make PerfOpt compulsory
To: Mario Limonciello <superm1@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alex Deucher <alexander.deucher@amd.com>, Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux.dev>
References: <20260929013423.2313648-1-superm1@kernel.org>
 <bd707bac-26c1-4330-9e29-a8eaec07745b@amd.com>
 <edae0bd0-e580-45f2-953e-dd117791c488@kernel.org>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <edae0bd0-e580-45f2-953e-dd117791c488@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0036.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:17a::7) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|CY1PR12MB9560:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d6a8ee0-cc1b-4666-9251-08df1ef9da9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	4PH9EvrGoP+WDVtYyxOxsaNDf5DlJYksALBBuZASb6ERtHFxBAjPssiqCMKlriHO7PWaIQ/EolAni7OktqMjgDe3vfiNY502ToveRlQZyCbMHsYeJQft/CtK86Q85iahJGDGzPUGZRvw8sSUp2M9Xd8QnwHZXPG7+/+W/bcbdG3g/g5KjJhzukwTYLn1PwbFZn5xEaOmw6Is2FOCSn6Yhbck7/3SHBvYYhDhKxb/zHrjdjYyLlgAFOqjG+0hOIqb/xYRZr0oPWe8e4WgtUG9uaZMClTNPcmlFpw7UEeRykD6MDf3fTjAiQWC9g7ssI8X1vAzLS7y6V5O4JR5xh3wWSQWZOY1axOkCxJa7MW69zkAMG2PK6d1SFPEfdp+hq1OdF9fYjQ60iYKT4ZbR7NV5ONXi8z6NUvrtmp39Cw/jncxiD9c8mZPgaJMM3NcP5bkZkozRoAF2D+NW5kxflcNyhraTyEl7acfmlcJy1OfXM3hqk0vmGH1lTcolFL5RCGTuhbrnjilPzXZGkVk1eTE0dMXqrSNYn3Fap3TkAFU9J9kYbtGrul4YQO2hW804/8q8uWTAf7QHf2uB+JmF3LMEBUDXUsDBfYqOnTMhdv+D0Y4gKGGXodT/w3h+9dZ6PB4biEgRYpB6IX252+lGLutkhWQAL+yLPtJCknIr5aRcRg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFF6NWd2a3poL1E4ZmFRSFBvd0RZWERQWHBsOWc4UHc4TWlMbURUUFRyUUxD?=
 =?utf-8?B?aEF6VExPUTRlZTc1UWhjUlRmOUJrSEE1aGNQUW0xRm9uVjZVdG5vdysyNk1F?=
 =?utf-8?B?dGxGbG1MY0lacHR1R0lFNzFWcmVjTXp6cGJBOFpiYWNJSFRqcmVOVXNTd2VY?=
 =?utf-8?B?U0MwZnl2WWxYR3V4THJHZXBRODk2MWt1ajB2eVNzS2F3a1VLbXVjVmduSWJq?=
 =?utf-8?B?ZEkzdDlqM2kydFdHVXMzRHF6ZDc1TEc0YWNEWHVzd1Zhbk9aSUcyeFQzYW1D?=
 =?utf-8?B?VjdaVU9LTHZNajErWDdQa214Z0NvaUd3c05NVVhQd08xRnpyektQQUtNNzgx?=
 =?utf-8?B?NkUwTUw0cUN1UU5hWDJnMGgzSk0vdlloQzI4QTY1SGlyVi82Mk9hZ3hqWmNh?=
 =?utf-8?B?aEVrTnJDcEp2NzU0RE0xQTZuZ2tBTWtHNXJteVVpcC94YWlhcHBhcWxuR2tV?=
 =?utf-8?B?VnUrQXFmS3NhZHZqdS9RZDBBTUxjdzFYSnY0UFJrTG51djdlZjg4OStOZVdM?=
 =?utf-8?B?NVZOTnpWbnFHczQvN0JRSG9YaVpmOE01TWk1TWVhMFVCeFAwRERNajRsdU1E?=
 =?utf-8?B?WDBsQVMwSHBTMTA2NzR3ekxxUGEwMUZOeWNxajFIRDlPQUgzT1BrbGR2OHVq?=
 =?utf-8?B?clJvWmw3eS85QmVtMk9RRWFJZG9WOUR6WVYyL1poVE8yaTN2M2hIKzVhYWNW?=
 =?utf-8?B?R0phb2Z6OUpTalB4Yk84YVl2enEzdVFpSUx3eG9qdXdPeEVkVkNXK1NpamFj?=
 =?utf-8?B?dnJuSHpGZzVvUTNOVG8zY0tDa0tJRzJOUDZiR2tyb2RYVEpCZHpJRTZ2SWFz?=
 =?utf-8?B?ekkvWituN1BiNFd1QTNaMHlvTUlrNUxiTE8xLzJ0bFRubjVxNngvWlcvZGVZ?=
 =?utf-8?B?R0tZWG53SDF6bHRGa1RES0FrQ0F3aEtnZjNjbS9EYVVPa3h3dTRVVDBVYmRp?=
 =?utf-8?B?UE1RZDNMVEt6TmNCcGNuY0ZOb2FPMmlrWnRLckFUN25ya0U1eFVOUzdJRkpl?=
 =?utf-8?B?NnZrOWlVVG1BT05xUDM0bk8yUWJRMU52S3B5Um4yYi95U0RtYUFYWWdnR01S?=
 =?utf-8?B?RmxENEpkaVNrKzRzQlFUTmlnaWQ3MGU1UkNCaDQ5Q1JraGZVSCs3c1VGYVls?=
 =?utf-8?B?THBGNVQ3N2RnY2R2S1E2cTFweGZ2SXFEbTRPQTNkRmNrS0Nyc0E4LzZvL1R6?=
 =?utf-8?B?bWxYenhHTGFERkFzd0UyelY0ZlMxZTVaaG03ckcrSEpyUkJmckxvRGhxTnlS?=
 =?utf-8?B?Q0hNMjZVUDBsMkFhZTJENWpWNXB6cFFYVXVmVTF4eGFhbmp4eXZ0UG1TSVN3?=
 =?utf-8?B?bFhMcDNYZFVvcUN1N0JEckdhU2lYQ3dxeDM2dlpvWVJCMjJ1bGRPdWJwdTZm?=
 =?utf-8?B?RGFwQ2Z6NGpLYXdkTGl4dHZHZnh2dUdmYmM0MUtWeW1ZejBuUy9qQWlUL2Ns?=
 =?utf-8?B?U0Q1TkZER0ZwNWVTdmdKTkRRdGt5WHp5VWJXZC9BbE9NelZURmFtNEZuYWxw?=
 =?utf-8?B?RXdTeUozVHA1YS9WNE5WVDc0UzQvTUNWYVhZUzRnd0haVk1GekZ4c2VqNkw1?=
 =?utf-8?B?c0ZWRVp4ZUc4RGE1UGdwdWkzci9UYWx0MGNKWWZXQmVWdlA5d2Jpc3QxSzhz?=
 =?utf-8?B?Z3oyNFozaWo5ei9NdDBId1Ixc0U2VEtsYzZjbHlkQnBpT3haaWpvY1FBQ2hW?=
 =?utf-8?B?ZktZWEJ2Q2dHUWhsSUlwMmNiamJMMnlXVU5lSE4rOEI1VFFuR1lYZm1CdUhV?=
 =?utf-8?B?a1NzZi9iQXkvR0JhYkpFTXg3MC9jZFdCZVR6OUVEZ1l2NHhBdkRHSUUySXVB?=
 =?utf-8?B?L2ZhRENrdGYxZno3emErWHA2ZUs3WE5aWlRrNnpuWjJHT05NeHJOWS8wTi9V?=
 =?utf-8?B?NG5mMUNSM2pUM1hoL0tUQnBxNHZRTDFsRnMzeFR1NEV0NStXc042VGxjdmdu?=
 =?utf-8?B?MkxnN2JvZk5lSmxXckhPU0N2ZTNrZDZCZVIrenRmRnBtTXhsZnk1aXZnMWdC?=
 =?utf-8?B?L0F5ekdiR1RqM0dnWGh1dnhQMG9QMDErRjg3ZlI0U1FVd2hreHB3VldJKzc2?=
 =?utf-8?B?YmdJeEU3bjhyU0dVM0l4ZmJPTkFXZXZOV2phL3N5cXNlMGN5QmgwQUE5eW9N?=
 =?utf-8?B?SWx6eUtMNU52eG9zajFlUHZDWldoeVRkV2g3OU1GOVRwYlNhUkhYNmMyZmNU?=
 =?utf-8?B?amJVSXRNUVRrVVIvRXhHYVN4QmNFLzZJdlhqQXBTWWViM085ZVl5NHpQN0RC?=
 =?utf-8?B?aEZrK04wVTBDdE5xcmdha1JkYjMxNCs4SjRGSDNsNHVkeEg5Z2FnczQ1ay80?=
 =?utf-8?B?aWRYSEUzZDhvMnBkOUV5K05lMTdPNnU3MmNYMXNGNHR0VDJicjBqZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d6a8ee0-cc1b-4666-9251-08df1ef9da9c
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 13:50:57.5174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bauClCMwbCB61E7ysg6Yzq398tyiVGxUzR3On+3CKIgcMH2ouffajJZLmsdyegE7VAWq8BVO6bbjtOgqVszjNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9560



On 9/30/2026 7:09 PM, Mario Limonciello wrote:
> On 9/30/26 04:38, Vasant Hegde wrote:
>> Mario,
>>

.../...

>>> +    u32 old, val, readback;
>>> +
>>> +    if (!check_feature(FEATURE_PERF_OPT))
>>> +        return enable ? -ENODEV : 0;
>>> +
>>> +    old = readl(iommu->mmio_base + MMIO_PERF_OPT_OFFSET);
>>> +    if (old == U32_MAX)
>>> +        return -EIO;
>>> +
>>> +    val = enable ? old | PERF_OPT_EN : old & ~PERF_OPT_EN;
>>> +    if (val != old)
>>> +        writel(val, iommu->mmio_base + MMIO_PERF_OPT_OFFSET);
>>> +    readback = readl(iommu->mmio_base + MMIO_PERF_OPT_OFFSET);
>>> +    if (readback == U32_MAX ||
>>> +        (readback & PERF_OPT_EN) != (val & PERF_OPT_EN)) {
>>> +        dev_err(iommu->iommu.dev, "Failed to set PerfOpt to %d\n", enable);
>>> +        return -EIO;
>>> +    }
>>> +
>>
>> May be check return value before enabling dev_data->perfopt?
> 
> I thought about this.
> 
> Let me know what you think of the approach of clearing the bit in amd_iommu_efr
> on failures within amd_iommu_perfopt_set().

Yeah. It makes sense.

-Vasant

