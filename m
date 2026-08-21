Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012004.outbound.protection.outlook.com [40.107.200.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59393B14AE;
	Fri, 21 Aug 2026 07:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787298147; cv=fail; b=m/S6ha5oitI/IM/Li6CLHPBL7AvIsVvtpPWQkrvHe9B7wcFsbtFrbU1JLc7wQcDzM37GYvnId8fEqdRDsRTw9iuj1376OsznAWjgJIJoukWshz15LPzgYereVtmhvjLP5yxOITuewS+d8e+sNyQ4wwdAtb8UH1Mkre2sTCxtnsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787298147; c=relaxed/simple;
	bh=PJCRVHApZHveJ76wjdZrgK3DByjrK4BkWNFQaoXngT0=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uMfSgop4a3VF86jCfDvvoebfLype1cM33nycj03T/vVr4i/mxr3LR/0yJLpqZgkY7fbYyNr4crcZ15gAE2GLO7GSBpo1BFzLhVn1GSh+w1TlMiATkGdQX0IiRFmjR5ftr4hcfTYU1aYkGfqS9NO9mlOTjWC6r3NKAOpbtHXj7rM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RZ1duILE; arc=fail smtp.client-ip=40.107.200.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RZ1duILE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CENHbLlDn94qOkVRo7z91Kmxqj2lmJbQhf2yjrJzd7d6tc3FW/bdbKKTKFC8OeTbhzqeutAO6TWiRAEmF7C2xFF79UrFxnAg+f3CVkKGu1o1WsGCWqb0fmZRMmRpdc4akhneLVEqi8t9lTuFSUI2symcaFToiShO+1ymSTafWEO9ws4yt07xym9svxCf+Ydx1mqwffyB8v92XeQJW8tuva+i2H+vvpH1fPWIIfCpPEAWYwHriHDaTBarkTldBrbr6JRDTUa+7kjibowiyPjCaZH/70o+5ek/K6PvhHmnXON0jR8t1+5ITpMpPyt2cHHt2cxdNxR8rEWdLxsi0PrJQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1rDINs1+0wmkoYdroIDXAJ+qCzT33MFEsT1bdGlBeM=;
 b=aMgqCIOPiETpcuTPalhoF/9s7G+r9JRHL48VJHD0wXGgATOCa10NlimnYyCCRCGvKTw59RtyLzCzFLnH+EKMSYyXOpMU5mrKUpNjdh6GoIT88ptgBjjoUwQ3c7hYZhAcEU/5eLrOQyb0D02zLjC3Fl01iS4BhPHySA3/Ahq0T8ZtHYFDnisJF4xdafvssnmYG4NdTSkCZG1JpmhX98ARPJLjkA/b1ppSXfhZstgxk3+3ttbi+3j+YqDNyB7kKdPb+Cw+PH/QwOrEriQI8j+Dh+/WCNyyNCtOwl921cW14UzafvWNPhpYmzTE9fliNJcL1Rg9sE9cpdKoiIADUVMDmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1rDINs1+0wmkoYdroIDXAJ+qCzT33MFEsT1bdGlBeM=;
 b=RZ1duILE8JVVeDRZNjsfaivFhXDfH38ezSwVJb6rYgqM6Pjoujp4FiBLaXZVm37npJy2gGYzQk+Ih+MgdNOp1LhM4Z+RwlY3FHOHnp2wI1KZa9ALs/JvCf2fQ53+/gcKPzac9zsKpm36XsWqkxj1Aj42tXWpXXitvwDLy4bnZEs=
Received: from BN9PR03CA0797.namprd03.prod.outlook.com (2603:10b6:408:13f::22)
 by DS2PR12MB9752.namprd12.prod.outlook.com (2603:10b6:8:270::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 07:42:06 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:408:13f:cafe::21) by BN9PR03CA0797.outlook.office365.com
 (2603:10b6:408:13f::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 07:42:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 07:42:05 +0000
Received: from [10.85.45.224] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 02:41:55 -0500
Message-ID: <ed990d4c-0ffe-46b3-867b-87bbb8a0de37@amd.com>
Date: Fri, 21 Aug 2026 13:11:53 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>
Subject: Re: [PATCH v4 7/7] iommu/amd: Provide kernel command line option to
 enable GAPPI
To: Randy Dunlap <rdunlap@infradead.org>, "Borislav Petkov (AMD)"
	<bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, "Joerg Roedel (AMD)"
	<joro@8bytes.org>, "Paul E. McKenney" <paulmck@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Breno Leitao <leitao@debian.org>, "Christian
 Brauner" <brauner@kernel.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, Eric Biggers <ebiggers@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>, "Jonathan
 Corbet" <corbet@lwn.net>, Kiryl Shutsemau <kas@kernel.org>, Li RongQing
	<lirongqing@baidu.com>, Marco Elver <elver@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Robin
 Murphy" <robin.murphy@arm.com>, Sean Christopherson <seanjc@google.com>,
	"Shuah Khan" <skhan@linuxfoundation.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Thomas Gleixner <tglx@kernel.org>, "Vasant
 Hegde" <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	<iommu@lists.linux.dev>, <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <x86@kernel.org>
References: <20260821055611.27138-1-sarunkod@amd.com>
 <20260821055611.27138-8-sarunkod@amd.com>
 <352a7732-86e7-437a-9e2e-e1e117bbe95a@infradead.org>
From: Sairaj Kodilkar <sarunkod@amd.com>
Content-Language: en-US
In-Reply-To: <352a7732-86e7-437a-9e2e-e1e117bbe95a@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|DS2PR12MB9752:EE_
X-MS-Office365-Filtering-Correlation-Id: 433f2de1-0ac5-461d-8a91-08deff57b280
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|1800799024|7416014|376014|82310400026|921020|56012099006|3023799007|11063799006|4143699003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	5vGf3JvtcSgSNlThikC3Fv+n+nPz/QzTbzLwiS2oKH6q+vqkw05PmmF7A4YaIwoBhKF1Z4fs6pQZGMFVrYhhAr+4adD5cDarBTf9aT7wfmlsiOj+D2fznBr4SfiP4zvz907cTpWRI2hYMqjA/xL2XcRBiABKeg0G/hJsxFCOMvAx9B+m1seT9uVoVRwNBar7rLAb+whGZxgWGcwk2cKBbyD4Fr/B5q49L4lzYTO8OqcEO2Sc30D2hoVWwtSDUOaT+QaSyEEYK/Ol+2/MJPzuN6FqLkNwVMWa5q56Pwp4+lYsMGdMLfXeebQg1etjyiXfK5gdXdezQYvHNOrdAK7q4ZfyA+IuKt+MMFuLdh1YzbpBDp+H2jtSeBE9LVXRDg42HJAxWWPa/ajYb2vR/FmwtfsTJmIoy5+3V/3MWafXVzUoNXRNqdLZz6upLxN01x4mLEG2uokfQ2Erusk0nNkMLBKA+ZtqGl/alddWjqF2GM63WUbgjoTmwIbQXuAmLGr6V/pACi8lOVw8beQZPGtYQ6K+QSMQvhyBx++8WD4rBrW+X6xRO5nCVDH92KJNHnKptNauEW5SPwWfkYFuig0bD+VAVdMTipOILm77OaLJXA4hhjAY2hh6EXi2YZ13OwHy/UKklzGI3U0Z3PDRDuJzodxc/Sx3+W8ChscE8SKjtxZHYPQ8Tu2Scqv9iX2wCzzqU/HNUoci7LyBZNdUv2qhMkh0hBHf8FXIWK68znJnh0gUHrwXxpELfluFdBrFc6Lp
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(1800799024)(7416014)(376014)(82310400026)(921020)(56012099006)(3023799007)(11063799006)(4143699003)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uZSJmLPGpFRisg96X7ElX15sgK4oavgu7R15k/pyBRCV5NYIMYfABq2p5RXiIu+q3qkplS9l33jOQOWG7LWd04YN+IBiCg/OdR/RK88maNDwZZHAZP/n2aVYrwRBr6t559l6ISGodYaE4i7AlbuhO9jyymKDatFv3Bf0/uEy13dZ5PQxfpDBTXAa4bup4uhN2wnHCMlXbZRBI5h1ixUA5H2WMSsmTOLTFiBFKZYIY24bMtznY40PbP2kgYUUs5KtMycTWKV/7fJnekTtfcHwYTSvwRk5JavOP9T8ZDviVM1/RwD4c/lhkmm4LXpNkCYJRm98zl+rmgNEsUUua+GTbIaJQoTgdcjciqZidmXbPaJcg2aAFZqB+aTqPEio+lnScbN6lLcPQ6kW0LZYXbI6A6eiN73lEPEIR2wNSjQgYb/9McAa5wuO0gs7+Xas+OiC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 07:42:05.4749
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 433f2de1-0ac5-461d-8a91-08deff57b280
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9752



On 8/21/2026 11:43 AM, Randy Dunlap wrote:
> 
> 
> On 8/20/26 10:56 PM, Sairaj Kodilkar wrote:
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 97007f4f69d4..7bea1bbaa0e0 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -455,7 +455,8 @@ Kernel parameters
>>  				          to 4 KiB.
>>  			v2_pgsizes_only - Limit page-sizes used for v1 page-tables
>>  				          to 4KiB/2Mib/1GiB.
>> -
>> +			gappi           - Use GAPPI instead of GALOG for vCPU
>> +				          wakeup notification.
> 
> Is GALOG documented somewhere? Should it be?
> I can't find it...

Its not documented. Maybe we can add small documentation in
arch/x86/iommu.rst

Thanks
Sairaj

> 
> thanks.

