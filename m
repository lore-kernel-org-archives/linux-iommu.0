Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013001.outbound.protection.outlook.com [40.93.201.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146732C1788
	for <iommu@lists.linux.dev>; Sun, 17 May 2026 17:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779040070; cv=fail; b=JMOUSBYDeUX5KMiw0Vf2iqO9moL6dCww77SYL7COjoyBLyDm3xolwH3dLmFGeweAqDX0cdaYXboyBLRmbHCAwYix4hF5qRy8VQpkn8z+tmO2OwRdEb5qvS2EYg71KJxD3t2XJgW+wIPP5s46QLwi0P7TL3GisXZB9e7a8u2i2L8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779040070; c=relaxed/simple;
	bh=KyomrTZzWpUbwjs3tIVA6mRB6rQp/Bmc2d/vXAY6be8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ItobG8bugBjXVIQk8BmK2G6UhocsO03a93G6gU/H456tcN1sc+A0fsyWurWfeZVgLPPDTU7m+Xy5MfUohxQ4iWqSddvdpCyYWeYa7Ea8xuJIioo1iWQ3uITlko7tKLKqUPHhBM/wxNVjq4eBJGUY5mKRi34zlUp0rg2Y9ycWkmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NJ62ccSy; arc=fail smtp.client-ip=40.93.201.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NJ62ccSy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lTJKu8GzxAUZ84BRdd3ub8RFXxj/hOwnzUDSQ2wDp81e5AZ0/iHp+k0PDNj0IX6VwJ9b3YwB4IDhRbbpAZgoHDg/4pDukc3twcO1Owbx16bjaNn8d1u5uqQuq7Q2OaTulHlNW+iKORK2o90CaubE8CZTKs+U6cDyjzj3dTrs7hQ2RMspztC9+GkZV57FrDDG7KUg8u/vzceGWLlW2imm5QnXm+OgSN1oKtg9krRE9HA5/V6dm63bW7R3q8Fr4936G6T3tfOiEHyDPaxfsgqgwdiDJBli4YYH8P8H1gTo9uLQEyZYFyyPxGHKrne1m10sbiw74WlydgUxxrmTZL5AqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ijdEHx0tmIomnzxFSUBlqNPkTxKBiP4skC0StNmSUHY=;
 b=Y/W4Hj8AQNOtFPyLsKudr54wz5rlueS2Im7Reiva0oFosczVnVsa5VWcnJqnzSR5dUnsMT8geiXbKWYWfEUTocDLpk7IxBSwG+DsMHSeVjjooL71A+vjAh0e37aW5IvZmfFHuuv6ITuCi+7dB6b9CWplqIoHWeAhiYpEiPRh/CSp009jxQfLggO03sDwIoTlr0c+sILhAV/CqxrZVJRAuq2svKSF87lpbLMyTCpsce1yGw24MLeHE5iO3VuJI/+3YdLKkZ2vdaHXv1j4Lkxt5DWbGkovqVZTUGM1SP1RzbCr+/l/GKwRFs6h41Yqd9OMQmghfOD76/gcVhM75atUJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijdEHx0tmIomnzxFSUBlqNPkTxKBiP4skC0StNmSUHY=;
 b=NJ62ccSyERqvE3WkTmabKnV72ox/xMvOCt27OgC/OSMS+Ga08uYGl20Hu0deqGZxVzBJmik0CeqmpPA8TGJBZmlRG36+5+Ql65s+3St1VRelFdxPZxxN2ObO5SfP2WUQdKkxSx3K99wQ047altOV8j1ue2dOxhLnoBIKzHbJEvA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5754.namprd12.prod.outlook.com (2603:10b6:208:391::20)
 by LV8PR12MB9183.namprd12.prod.outlook.com (2603:10b6:408:193::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Sun, 17 May
 2026 17:47:44 +0000
Received: from BL1PR12MB5754.namprd12.prod.outlook.com
 ([fe80::b080:4c1a:f6e5:4564]) by BL1PR12MB5754.namprd12.prod.outlook.com
 ([fe80::b080:4c1a:f6e5:4564%5]) with mapi id 15.21.0025.016; Sun, 17 May 2026
 17:47:44 +0000
Message-ID: <8d04a56d-4457-4984-9f18-bb4b1992fe38@amd.com>
Date: Sun, 17 May 2026 23:17:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] iommu_pt: add kunit config for 32-bit VA
 (amdv1_cfg_1)
To: Ankit Soni <Ankit.Soni@amd.com>, iommu@lists.linux.dev
Cc: suravee.suthikulpanit@amd.com, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, linux-kernel@vger.kernel.org, jgg@ziepe.ca
References: <cover.1776075533.git.Ankit.Soni@amd.com>
 <2a9b91f957bc6538e86c71da75503fb320fbf30d.1776075533.git.Ankit.Soni@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <2a9b91f957bc6538e86c71da75503fb320fbf30d.1776075533.git.Ankit.Soni@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAXPR01CA0107.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::25) To BL1PR12MB5754.namprd12.prod.outlook.com
 (2603:10b6:208:391::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5754:EE_|LV8PR12MB9183:EE_
X-MS-Office365-Filtering-Correlation-Id: 02c6f013-75fe-404c-02b0-08deb43c6628
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003|4143699003|11063799003;
X-Microsoft-Antispam-Message-Info:
	IhZfjXFDJxA6uy91avuOE+5EDEiHZp4gA7/85cEG8QiibiaFZ7950uHM+D363i2NNVunEQlwAzJ6kUHKTzsBsaBrEujb3Iuo6vLxzMKbuvyYMXWq8G4Tam+BSooUeZbwJLABj45UkMtavYV020qVXLlWSAs5pn1ZFZEX/t0iZKloBm01H2IS0nFQ1DR36sWHcwnJKjLf/NYLgcbTNci+09KVTbZYfky+Gi4OHTcDhJt/7e43U1FgAluChxO7EEtKW+JK3U/nr8MhJ7GV42ybD3q+bt+aInduAwKCy92PLw/9Fl4TJ4MM95Lq0ZYwmFCsB0cjJC8X9SKHUkX63aWxSOiHtfbhr7SMzxaGzd/1u+VnEJB5KN55KjQc596LP8M/vd621RfVBAJZGzDmApb6F1ndKyVmLqnH4XiQOGLVDlIWqGz/0cKoszdQ0xkw6h5P6nBSnQpxcxETTLVpUz7wMvGt0lZl1mBMk8y5MSs42vZbikxGNShY3wJB7JpURKBPrZxMMzBK7PtqFFGkgFKSSSTtWvh63HcXSw5LMdBOGGc9B9I2MbEjxnqe1b2KivUF4736XSNlhkqCFkwRGYoo3oxywdm5k+nOXLagqTkb2JiETDGjFDs8UBqhfH6by2be9KNbBum0QZZFs216ZDe4STIkYtx9xCfvLbsPT6lLnm8kl+gsH+sPAebMlVTkX5Xo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5754.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(4143699003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHNDMVB2aDU2UzZCbTlWa1l4dURBQmlIOC9TYzJ2MHowRVBQTC9OY1hMeGRu?=
 =?utf-8?B?dEFDS09SM0pyRFZSVkUxMU1lZ3EzTWdQVC84WXJwdUN1dnRmVE9yR1IwZmw0?=
 =?utf-8?B?UjEvUkNTdU9Qell2cVBkT3V2MmVIVHFSSHo4WlZpandidTVqaGp1ZFNRdnd6?=
 =?utf-8?B?NzZ3NXUzS00yOHpCUW9yK1hKOCtBem96NkJlZU5VUm1KR2trSlFtbkdLaElM?=
 =?utf-8?B?WVlwOEpSVndhK2hYSjJGbHZTeGJFKzBHc1NvOXBldnZjVHdBczFRVG5ERWho?=
 =?utf-8?B?MlgvbnZ6L0RiT01XRkdpeTUxN2RVYVgybXBGL0gvRGtqKzJzaGdjTitkN2JZ?=
 =?utf-8?B?S0FLTUgxdml4SWRRdkVsRDlqYlBhSVF6ZzhxRGxPRWd5T3NSTjM1M0V2aTk1?=
 =?utf-8?B?Yys5U2NkekcvZHdrYXkyT0JZYU1nK0hWQ2RDMkhxNTRkWS8ySzhyY2dyVXAv?=
 =?utf-8?B?WnZ4aXRqU2VqeXNFM1dxcytuOGdaWlFkNGl3RTFoNFZVUmI4SlA3ZXdiV0Np?=
 =?utf-8?B?TW53ODZweEZMS0JEbm9LcXB3Qnc5UlVTemZHS0lFT1BWdkJSVFdQQU9wdWd6?=
 =?utf-8?B?ODhFaXBtTWFaUk1EdDRmRXBVSmlKa1pJSHdCRzNVQW9OdU1FWktmZUFCTXFr?=
 =?utf-8?B?ZkVmNDlyTWZYUGxsUk9OUFZuOGpzcWp4VGZWdXYzNG5rY1g4aWVaRE1GbHRQ?=
 =?utf-8?B?bU1kRGt3QlRsTWU4d0xKRmEwWGtwSUVsK1F5VzlvSmpnb1VBVFlmZllvdVFk?=
 =?utf-8?B?bUMzekxIOGt0NjJMMU42bDF6M1VVSmpOVzVRUzJMcTlwMm40SlkxckJiZ1k4?=
 =?utf-8?B?RXVaSFBCL0tVbmJDdUVhMjRLQWY0cXhkbTdEYUNXWkVlVXdoOGhuM3UvVlVS?=
 =?utf-8?B?bWZNMnNZMjBDazdJSEpoNzlDTHpiMTRZZTM0UnlDR1NlRXQ0bmFpUjBrUlZi?=
 =?utf-8?B?WHc5QVVoYU5LTHNzaUFqMVc0R2Z1cXdoaXJaWGZYd1pkTVVVVUZPREtHQUpR?=
 =?utf-8?B?RjZTUTIrSnNmZHBpOHpaV05XQ0FyWnRhM0VLSlMxbUt5Zk1iZVBYRXNGZ0hH?=
 =?utf-8?B?dm9HSUZoeGlVQVBYYmJ1NDl4MkplbnkxM05zM1dEcnZvYWRjTkxxR1JTbmgw?=
 =?utf-8?B?KzE3VDBzYmQ2UVRuWDR5SzJTVGowOXV3SURDVEUvVzFyemFPZTlaeStJQzJt?=
 =?utf-8?B?ZVdlSHZ6OVpoN0Vsb0w0R1lQTDRpMWxsMlQrNXM2aWpyU3BTdGR4aDZNQ3BZ?=
 =?utf-8?B?L29UaEZJeGFRcy81SEREUXpwNFdlbUoyUldTNEpDeG1xaWdRVm4wWnhveWhl?=
 =?utf-8?B?ZjFSQ0RiQUdQQjdndzZsZXhQQkQyczkyZ1JZL0RMMjh1ZmkzeU5KN1NnS2Vi?=
 =?utf-8?B?TmVSR0J6UDJsNEVhNEFNM3NGa3lFY3BxazFDd1hBZDdTNEJHcWN0Q1oyTGFm?=
 =?utf-8?B?VG53TGpvS3B0S200OTU1clNXckYvYnRNc1lVSHBjVm5uT2NHR29QZmJ5Nklk?=
 =?utf-8?B?UWcxQVlhbmpXbHZqVStoL2pvNXdIK2lSemVXZDVuaC91eWtJL3RSTGRIYnU1?=
 =?utf-8?B?UW1remZtUjE4UXhIbXlrOEV4RFlVNFlTTXAvZGxkRGcvUnI4SnNSQ0NFc0Va?=
 =?utf-8?B?NjliWXVKU3BtNVByOWl1QnFjNXRwdTAvS2NQclB5dlcyaDJqdENuUFJuc3Ex?=
 =?utf-8?B?SjEySWxmT0szdExvYy80czM0Ulc2RXRWaHVrQTBIUEtJS3cvdTZOcDZITE9K?=
 =?utf-8?B?ajloMkcyZzRkSlMrZ0srY2QyRVlydlRib1FORDM4L2MxUzIreHFKWTB2Nzh4?=
 =?utf-8?B?ZTcxZE41UnFxN1pqTkNxaEhIdlFDMnREdjJMQzE2RVJtc3M2SWVDMldsZHlH?=
 =?utf-8?B?TEZ0NnpsL2ZLRlFjbkV0S2w4QzgwUmVYc09JSjdjbVBqMzIzc0RMMUdpNFg2?=
 =?utf-8?B?a0hZSnlsRnZsWjh3VVZST0JsNzNEaC9yQmUyZVNHRDFnallMMlBYRVNaMjhB?=
 =?utf-8?B?aXJWYkg5ejhNb1pXNGMrR0JBYXFoY1hGSHMrWFZMVnU2MXhwdFdOUmt5bWFD?=
 =?utf-8?B?dTc0TVJMMitYK3hhZUJLamlxanAyMUVGK245Y29YQ1RvMXg0d3g1MTYxSUhX?=
 =?utf-8?B?WXhxdEQ5R2dkMFR5ZFR6QXk0N0I1a0RxVFRhWFhvYTVnSzZ3cm5NWmxaVFJQ?=
 =?utf-8?B?QlNhNDNKclluYUtzN2t3azlJMVpPQjJodzdkQ3pMcGdXVVlsenNUdUEwelho?=
 =?utf-8?B?blRZMzJPaWxaYS95Z0FPOTJwWXc1V21QQnlpYmlvNk5FNThUcUx6U3o5bXNn?=
 =?utf-8?B?VUpudXpwZjZRWjByOHVMMFFTOW8vYnJNbVlNQm82cURqaWYreVBEUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02c6f013-75fe-404c-02b0-08deb43c6628
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2026 17:47:43.9351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YBw6L/pP6Wj7crd5snq7jijIB4vFQLL4gOnwQFHGvggf/4jwH3/tSav1mZQRRclp3o2HMgy8D9poo3+90c06Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9183



On 4/13/2026 8:15 PM, Ankit Soni wrote:
> Add test coverage for small VAs (32‑bit) starting at level 2 by enabling
> the AMDv1 KUnit configuration. This limits level expansion because the
> starting level can accommodate only the maximum virtual address requested.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Ankit Soni <Ankit.Soni@amd.com>

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant

