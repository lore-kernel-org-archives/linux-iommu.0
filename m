Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2053.outbound.protection.outlook.com [40.107.96.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91651BC59
	for <iommu@lists.linux.dev>; Sun, 15 Sep 2024 20:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726432917; cv=fail; b=LUNtBWru/RVD7sJjp6Oeqi6P/rw04rYBC5OjkWA/UXWOuysNb/s/awBZ1HweEdDHkkvCus4eOfZweAJE8S4RQPeFEHho5pvALkeCzPCpLZltGiCH3a0QbjaJoCGZRUeMDheHT6hwtsLPefbZjr4ddcGt9c+gy7EGxrL4QO6pd5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726432917; c=relaxed/simple;
	bh=EhN0cRZ9gQ1fVyM/Len9wbYYSIx94T5jPcZCzZnjxpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GN1HztCTgPTVGPQkO8GjQsEm/CHB5bfmsLlDOf4KuX4RBcDDzIkE83Xo1wV7Yx0ZI4wQRV+w0Tq9YryKl3GWWKdIyXDB4dQaMXiYM520SxusX2Xj+veoRqSu93REGkXmM/UDX3U6geUxdnRD707desI7NgQC97l756zWVWP/tKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=STPq0LLA; arc=fail smtp.client-ip=40.107.96.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="STPq0LLA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qlMue/b2XsRguKOv1uO33OiV3K/7pKzS/gus/HWcLjH+HZyhNWkUbhQmK+pz3hFkYIclQv43sTN6MBE7BwoROBB6tHuuG1/A2Odl+ttkt2LoWJ/z2jJMWUwsSusn9Qx8i5fg+3RiU+bi+8QuDTUQD1oJ5KdmL50UBEqsEZAzWxNFB+8RWfqqNVXQ99cJ20JkhTJwe0hns99SdykG6/tqHMsLX3fCyVbEXq44WI4xBbJc8OWoSqBFLK//Hmmocd5JJS6rReGRmanCobKJqveFKu5IA+u4N5uNH3mANSSIlTqwwQF3IeaCTwF13Pakic6MtQIgtWFmVGZPgcbK3RpwFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMqH92e3dj6xm9tnuj0AmNERuM0bMlJcmPTu7fh2c6s=;
 b=wNyha8CAljwcbUxbMube2ymd8ROWA0mQS2IXqpmAfjxji2C0O+w6q0wZ7XUYInlrw3QIqCjGc0UuK0oXOCdwHnG+pF7ij3hHd+9Wv3PbnUHuDLTIfSsbr13r1YKSJl+qGgKnDOBCFOf2M3UbnGZOvV2qxkYXlqV9daEWjQ1vx/guiPybj5HU7wyMFYCap3MIbwPp4qlYFpnmWS5U73/77ejJZTthzrtVR8S5dn47Ex5abEJx8qq0tlFMNzhO9t9oLKp6eYXP5hZwXjrTBQ0bAgAFtFkrfNWjGE0+kNbPtsNACwHFb1Iav4gnkxTpFhNH/A0GCIfscP8fSiYoSN2Fmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMqH92e3dj6xm9tnuj0AmNERuM0bMlJcmPTu7fh2c6s=;
 b=STPq0LLAAXBx+O8Vj+OXbCiSuOS+VTOIZb2MPjSdj/Xl23rbTeyeEDMSU1h3yCad0GOaLMcDMNL0eDBQlLArpEnDkb60mn25YmIxiAVKoJ8XvEzYZC5ySe910ztwd50uAt+xVlWT4AilgSG8OrAaX4s7HqY9VnRw+GqtTgI06hc6sU4kPM1WK1Hlk9mJIy3Zg3tq6/cw32CZr34YHd4NeD9GhqPVeHreDvDJYD3Pje6e6x1pS1ShKgtcHmJlDYQqN/SDPx5lnSBKF0vUYKgVYBNwoALibbIEqPB7XPLXpwQMo+jv50AU31sEtmLcZXClSZyYdU/45fxwrNmFdDv1hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by IA1PR12MB8287.namprd12.prod.outlook.com (2603:10b6:208:3f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.22; Sun, 15 Sep
 2024 20:41:51 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%5]) with mapi id 15.20.7962.022; Sun, 15 Sep 2024
 20:41:51 +0000
Date: Sun, 15 Sep 2024 17:41:49 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH V1 2/9] iommufd: remove uptr from iopt_alloc_iova
Message-ID: <ZudGjUsw17YDggfz@nvidia.com>
References: <1726319158-283074-1-git-send-email-steven.sistare@oracle.com>
 <1726319158-283074-3-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1726319158-283074-3-git-send-email-steven.sistare@oracle.com>
X-ClientProxiedBy: YQBPR0101CA0247.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::29) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|IA1PR12MB8287:EE_
X-MS-Office365-Filtering-Correlation-Id: 996fa0a0-1902-4c39-3684-08dcd5c6d3a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LlAjBcEUImh5rXqQwS0j7GgQHEnvLniDLTuuERcrLOE7Kie9tcYLLWfHEtbS?=
 =?us-ascii?Q?JHSYkFT9QPdo4Mbftirh90PyWjiOBNDWl8cUvWiivIGMZ3UnMCEgrAKJLHQV?=
 =?us-ascii?Q?FdY8fCu4LJng7H4MKpjM9hnLJDKaXr8EC1s4dx6aJm0Rt+RoQDc3FxvoZOEQ?=
 =?us-ascii?Q?zWEgbNLES38oViX9KQ/I8+HwiF97U6KQkH512BtzsVPBsYMRb3/eG784eYi/?=
 =?us-ascii?Q?IKQkrsFiFgkli2Sc7QBQI9y9jdaU8gLqimSaUT+jP3jBVitTWLZsVLyoNbHP?=
 =?us-ascii?Q?AwKGA4VMCSqea4EVbyWr19zxs4Cf6QYaYAu3m3yM2KKWxbU3ayGHXgyUwC72?=
 =?us-ascii?Q?qWfQhiD0g4H84XZifrI98NhGiqh6HGuebgjZwRyfcKiQ93YvtYrFfwhsY2+y?=
 =?us-ascii?Q?POzB736nXeP5XHPPp032atIPtI/zTo3OETYgS8Dj+prTtFup12fhR6pts7+G?=
 =?us-ascii?Q?Q41YE2V6u9LUE4c/FdklVYUZcfd7j1hcb09PC+DpNbw6uS1evrIh3ANeZ9Xs?=
 =?us-ascii?Q?1tDZ6AexjpUGT+/GOUbbaHZUBV7NRBLNjpxmmTp5FyxUbPoW2kq2a/sjSbZg?=
 =?us-ascii?Q?fVG+r2AxeVZVEoFW0XYQP9pWqeURXO4b8R0fL6bgZsMZGdRhdAbeL9Ya+Jdo?=
 =?us-ascii?Q?+oTAkJDbknhC1QUUN0+XQtPk3aGuN3RemPBtiEgcNXEjvLfo8JwYon1RnfFw?=
 =?us-ascii?Q?esPuzO/Po+hrTwMUJfwKLQepu8QKk4zn4WNxU6y1tvoTYfkzyMOZ6tJ130bg?=
 =?us-ascii?Q?rsNMDqt7+NX9aTDo96Ygp4PJjFDH2gBTkbS53Bp60HaH1/FWST7630ykmC60?=
 =?us-ascii?Q?FeY5dd9wK7nabl6j3lHfRE3r8GENSmM8KPeDmHRZEYEM/oyS6IHrBXBIQYT8?=
 =?us-ascii?Q?whMiiAWxfbjyfQa8P0V6Bb3kbqWBjFH8UatWHLkY2baIcHieyghCScKfsxbW?=
 =?us-ascii?Q?gmXdh+bxOU1SaUUykMXiGb6Onudc/SEQgKZAMUReBCAUmzOvAgMbBRD/Bpwc?=
 =?us-ascii?Q?81fyovdUbTsRZKfHGzWwwWisW+6sOqLZotQu7OZ6SVokGkZFadVyl6fpXOC4?=
 =?us-ascii?Q?HPV9+lkiRuWJx+WYORnvqQTyyKvB3A/a+ox8p6WlFDGUBxuQaaxAcxKQ6uDJ?=
 =?us-ascii?Q?uEE6FJMvNtccITDVzwKBQPGPdW8ldMjNscM0KNUvx4CHv7awjCWq0w6jopY9?=
 =?us-ascii?Q?OT2GUuj2hJHAY+aMrCo5jzIm3863aIiTQpxX6ROF/+KyU8QNYiDBCo5n4svW?=
 =?us-ascii?Q?YonKRi+vvfdp44pZVHtIFfrdBlfFB7nGVfY+2CVCqO+O2n7BJhlKaCXRciVm?=
 =?us-ascii?Q?C4Glvzsb1yCwr2RiWpvQY/MxmGYPrJs9wZW+Vh4fAkxwyw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?feWh3vw2JV0V00LPXs4HOqgIrY1CZKx4sKy3Wt3HKwoaozyf8ttMlp7SamH/?=
 =?us-ascii?Q?2cGKoVP/OwQ50VKuZPswi5UmGBitCsQwikIIZnmXxhIYOCDxpIMLlPurtnZC?=
 =?us-ascii?Q?+YfN+CTaAuz3/aQ49Vd84nOhkesGomPLYVxW9OtupYXNIpQnovrC90EWH/E7?=
 =?us-ascii?Q?0onf4XHt1/UvNGvxUtXWn6uHUw6et7gbznC1a/0q1SbJMsofwxcdv9GzXPl3?=
 =?us-ascii?Q?vcni0GVUPr8nKu2LsbF1fNlei6PSYnPpsHhvvTqy9G+TqTY/ZAnWl1dENRnt?=
 =?us-ascii?Q?cBRrGk0QPZSpK1CUfyOq5846zRTwUzo/pvtak/30m6bETAa8HXiynjGCxMQz?=
 =?us-ascii?Q?wJQO1aHyeJ0jtYFZjVFtqjAlGvZ4n2OvzSNzZJyEjLWCxXBNAlwufb5ch3j4?=
 =?us-ascii?Q?rV2Sw5x4O4ZO4FqhmcHTjzIlSfJg11/Aay2JeUleOrIWsluGGVFJo/WuGoPP?=
 =?us-ascii?Q?6pupfQIMnIAx7zL2Ynkuq+5tXbzSoIV0g/Ng2TvbYg4ufiIf5AOd4CLHzDCn?=
 =?us-ascii?Q?CnHdBqgD6aM6XSohIDsjyJaIfk5McIcogsrRiwMxRHe7WKndI1QA3pJQdpn5?=
 =?us-ascii?Q?d4w6C7K1sTukSTcyLeg7sWmn8xnKS7/N/BSpPA9XfWKcHQxO7NwjwtlKpZO2?=
 =?us-ascii?Q?kzojdpVQXLobyfFq6l1AVe6pJfOeMdxSTXT6cYfLoiAv+miQZClUshyYH7ee?=
 =?us-ascii?Q?UGWA83+hvw6TKsg9Hwy3+kK9A9UXLRtaXoKVQnDlKf0dsd89x75k70LGZbjR?=
 =?us-ascii?Q?Bs8SWa/KQmaZbu0LRh9XyaWZnUaINKjIqwl1NXHDYoAq790l4pdexyuswWb1?=
 =?us-ascii?Q?j1KD4JQ2X2xIuySz0FWevo0Hajus73J7K9/ZHVMWy0O3JiIlZpHjECMRELRq?=
 =?us-ascii?Q?+U1lZ7SnS8J9+mKmQl50L1xCvfEfviCLWZk214AU/8izrtYOvdPutF4blxTy?=
 =?us-ascii?Q?Q649GOr4Ej7PQ7pNg2r9pXncb9FhogsX0YxD350uT1jrtpRRzZiUwu1VWLAD?=
 =?us-ascii?Q?IKaG4qUH11dFiQx4w32Vp1ruJTGUV15zX5p0BL8DLdarnjw0q47oAA+E+Mtv?=
 =?us-ascii?Q?JiHmXt9emqSFnEKbk87zmi4fQTGqtp2lo9HEHHQNJhVlOU1xIR2hOtWN7xig?=
 =?us-ascii?Q?B3b7FMItfNmDD1h896gF4QvjvhpH0gEHk+a1iNSmcIv6UEXs6DwGri9UDIn8?=
 =?us-ascii?Q?a6pvh3YKkqDJgu0xcORKPHZ2e8AQSACuVRtEEdfwAd70yFsfitorTpzy+6DG?=
 =?us-ascii?Q?hgKA4Ngz+f8M0vQb/04z+bUElX/Iit1E2xjM8p4CBTflfvJeko09IlySrRVL?=
 =?us-ascii?Q?jzn6hCMnv3lm+NB1jbbbHPGLjWqiiOqp143d5urFAfwFm0kczTsPGWL9WGba?=
 =?us-ascii?Q?u1i3gCI0rMWLXYAGperyiEGHjIedetcVqTuYC95BOffDlMrA0SK5j3xWC3/O?=
 =?us-ascii?Q?4qRUQRjB6XqYDZi1VqQqC9Gy/ZeX+WsnoMvvo9pNVsWNuWsHM7AmtHjg2boH?=
 =?us-ascii?Q?HcNdrhWC2yi7odY42cY6M0ZNBgsrFyCb2izwytC1ztpYS7jyvVHKxO5mlNTi?=
 =?us-ascii?Q?pq73a9AifSsE3imtPTpgAgk2XFg6mmtjoyz80xjD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 996fa0a0-1902-4c39-3684-08dcd5c6d3a1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2024 20:41:51.1453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3gGV/wXA2+kTCK4xf5Qy3yHfqyiLyP5RNg6tG16/n4CoIFWN778h58nswKJfvj6A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8287

On Sat, Sep 14, 2024 at 06:05:51AM -0700, Steve Sistare wrote:
> iopt_alloc_iova takes a uptr argument but only checks for its alignment.
> Pass an offset from start instead to eliminate its dependence on a user
> address.

An offset from start is a meaningfully different thing for this, it
throws away all the information it is trying to extract (is the uptr
huge page aligned)

But that isn't what this does anyhow:

> -		rc = iopt_alloc_iova(
> -			iopt, dst_iova,
> -			(uintptr_t)elm->pages->uptr + elm->start_byte, length);
> +		start = elm->start_byte + (uintptr_t)elm->pages->uptr;
> +		rc = iopt_alloc_iova(iopt, dst_iova, start, length);

It doesn't change anything but rename uptr?

Thats probably OK, as you will want to pass in an offset from the
start of a FD here eventually.

Just the existing uptr logic should stay the same..

Jason
