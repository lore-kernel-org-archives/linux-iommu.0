Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012017.outbound.protection.outlook.com [40.107.200.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F67E34252B
	for <iommu@lists.linux.dev>; Wed, 12 Aug 2026 05:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786512122; cv=fail; b=LAezLuplH5tQlxS3vDlB+wr27DrGpl/oRueNkk1xlDJD9pDWKBaTaXadu2sAH6+hQXSqoiDR/FvTTqFCc5jK5vFHLlndJLazXiylJwMC6yLF47ij+x9SbAYFM+c/HKXWuuKfm8gQ3aurtgkY6HddELgCkyRWsgxburJqaa31Msc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786512122; c=relaxed/simple;
	bh=xmuXStMnozTQvJIFFWA9AngfFdNbQ2pkZqoMooaim/s=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Misqq/OZfwabwICaKPcMAAwxSTNKHCqGNFMIHq9FWqkRVcQLK3kPNelMxomjrX3CvSmWpDXEcedhRz1r+LUfx5AnjFGZIybKvj9YZFGxUO7d0pWYX7DAhJrHjk+rwkjOGzQIm/hS66y2q53czv16bSs10VU4xTJpa5UwYSpv9NQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2nayREZk; arc=fail smtp.client-ip=40.107.200.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2nayREZk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xq2uju0w7208ByTOqnyRLnIK7yPv87tMqpLDpTAbcBXPmudkGhdvgocVtpzvy3rCZ5sR2cBCnfMfxdZxF+ttw3xlScruO6pPstsUCfY9vkMsG8EOAwMr1aM007WAU+yIfpH5aH+Pq5N3K/26AjqW2D98GVBAJzNA7YfyKpubpu4iP0sq0NiCtFO2nH4g7d5NPNr5OuGShOES3PvoYgTqVozmuz/Nf1rwTqy/TEDhNhXjz8CJGKpOIupHsE4XmKUbQAO5KH/GHfbSj7mOTBLWY/NNAFfaMon5WPMXuvQ3wLyZBIoQ9Q+xgStiEVZJcv3Rfh1XZeBLD9Rwh4jIUBkGiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DntL4RlszvIjSexzEiNSb/iUhSPifX/rafs95O/d+H4=;
 b=IRmrhNs4IrQ6GVHVyup4sxmsjPZ5dGGvtEYdpBVtiQ5H6IA8LaDhc/5L9iR3URJuPnsAjdmTelok9+edKxvCWl0uZzhVrkPVOnQOkTgeZmTrC9GuSz20fpkj8XSL8MPBBWJI/RuZUibZG99cb9yKICcNK7K8atZT0vSiGcGlv93O6ChmDRo9782fzM0KyNbsYnY9Hx8EuzchXfCUruvMOJZoVg3r54UGvSU27sTJMC0h/qFfcpzdrYMihC5hOuDD84rb0kDujgOrEqOJJGRljiXfyTuATC9mRnsEcIZxiLJVt14gA/GSUtROirmO1ie2hF4gDMrvKo3oH7PimSpoKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DntL4RlszvIjSexzEiNSb/iUhSPifX/rafs95O/d+H4=;
 b=2nayREZkUvA1c/oIxoCBRWNUi8lnkXHbRXsdCvFf3JtW8zAXmX3kbyEXB/N7KsXlBXFivuKp8LAsL39EoklpuV3a6dQaNYGNmwXC2dHdqESuyCI8iA6bobqJ6H/8xNR/afYQGrr/RWRejOLLRKW12l3XJ6RmvISz2W9pqeFIVwA=
Received: from BLAPR03CA0056.namprd03.prod.outlook.com (2603:10b6:208:32d::31)
 by LV5PR12MB9803.namprd12.prod.outlook.com (2603:10b6:408:306::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Wed, 12 Aug
 2026 05:21:53 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:208:32d:cafe::4) by BLAPR03CA0056.outlook.office365.com
 (2603:10b6:208:32d::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.12 via Frontend Transport; Wed,
 12 Aug 2026 05:21:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.0 via Frontend Transport; Wed, 12 Aug 2026 05:21:53 +0000
Received: from [10.252.200.247] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 12 Aug
 2026 00:21:44 -0500
Message-ID: <7fe5b9d4-6230-439c-82e0-ea332c2b02ad@amd.com>
Date: Wed, 12 Aug 2026 10:51:41 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>, "H. Peter
 Anvin" <hpa@zytor.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, "Paul E.
 McKenney" <paulmck@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, Eric Biggers <ebiggers@kernel.org>, Feng Tang
	<feng.tang@linux.alibaba.com>, Ingo Molnar <mingo@redhat.com>, Jakub Kicinski
	<kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Li RongQing
	<lirongqing@baidu.com>, Marco Elver <elver@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Randy Dunlap <rdunlap@infradead.org>, Robin Murphy
	<robin.murphy@arm.com>, Shuah Khan <skhan@linuxfoundation.org>, "Suravee
 Suthikulpanit" <suravee.suthikulpanit@amd.com>, Thomas Gleixner
	<tglx@kernel.org>, Vasant Hegde <vasant.hegde@amd.com>, Will Deacon
	<will@kernel.org>, <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <x86@kernel.org>
Subject: Re: [RFC PATCH v3 0/6] Add support for AMD IOMMU GAPPI
Content-Language: en-US
To: Sean Christopherson <seanjc@google.com>
References: <20260713105033.15405-1-sarunkod@amd.com>
 <anpxSbwbYzyJ1SQQ@google.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <anpxSbwbYzyJ1SQQ@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|LV5PR12MB9803:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fb7bcc8-ce57-4d9f-5dbd-08def8319efe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|7416014|23010399003|22082099003|18002099003|13003099007|56012099006|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	U01cQFnK/dofR/mmk80+2VkWAh2WBie0/FIwSUoJk/IZ2Z091P62Ed4Kk8rwpQrrsd6AiImwBJ1FHVdSIe9HRnxIL+JgZIxDMhGAsTWgQi2zMB8F3cgv2JqWPWLUQzxe2oYylc9S7NVOztkg6yOUDbMHFcSr9ROFi+GZW9582+R9+14sZJmUafz+HAEm26ron7Q9sIKwAZNpxLMf3WXmM7ZKaywALb6t/rCyHP8Rk76+QVRNIroR/KSXfzng+GTaePJWEaQNrCIwBOf9c/lCxwnLxOUM/aXGAoxqR02E+dFxsuqYs5g8Fw8RiqpWAF2CPZmvxdgRZtD4ZQdgTOA96kBNzlmIXA7V9Avu+70XBNIKqJY+gNcfvXWyBVjlhsRN0Cmv0TKtfSmeBy/bqkjJ/AsfrsLUmrqlETCYdkOgTnJ6lpgjKXhvKLLMVaS9SNUplF9MDcIaQSky2dZsPSqfr/0d0iN4rHnzMT8ZGG8Uo10d+YZ3MGCMht1IkvwNu4y2l3SQz0m2F6wYQOuDWZVSARgnPrhVO6odbV8/F8oA/g7eT6G8PsjLyVOwRd2tpHoixB20fkCdwzfEhyEcYsjxHCjNZM6I8l65hVQqu2XAmR4FZkqwwMzK0AXlhbmxN65fUXRiv61MCP8OQjOQ/SFW6hsPk/3btXuMkpBlzzNYhCutUmh2bvAUput6wjl9RTsAzKVHHGJbeWipSRTOnB1YzQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(7416014)(23010399003)(22082099003)(18002099003)(13003099007)(56012099006)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5hWZxU9wSjQgOMNnAFArMJ6+qPoGQu0bxuh8qtinqX5POJ/7DExGdnOnwpMaRvBF9qRDtM+0pYk2M1r1BodWKM0taq1Y3u1l0SbiReQqTyNXarruLfQ8bqHSFyp9keYiwv0XYnJFeyVDWH8yMYQjWsyrAwCtd+JNMPZZzu3bIjegDHKq90c70J2j1E5al8Y6hm8nouoobLSBtMbbbZxbCUsj7/BNZudmTrOxrxi/DWM3j8bu5bZ1EfcMN3WMmivoO5bsI71nFACcSITpPtujgNHhCaMuuLKFRxHtG6fipY/iRsIWQxjyBZrfJ6lTz+YPOqEHMQAbltbCCQy70IQEKLAFFCrW4nAuJismdnezqWue8TPh7DqKY/2XqppDtkvqcuTUBiYh/RHq6RrNvrduKzeCEUcL5HJ1K+MSDO9l2xEtWkuyqndsF0VO7+C7pPjc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 05:21:53.7474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fb7bcc8-ce57-4d9f-5dbd-08def8319efe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9803



On 8/11/2026 6:18 AM, Sean Christopherson wrote:
> On Mon, Jul 13, 2026, Sairaj Kodilkar wrote:
>> On newer generations of AMD processors, IOMMU AVIC/x2AVIC guest-mode interrupt
>> remapping can use Guest APIC Physical Processor Interrupt (GAPPI) as an
>> alternative host-notification path when device interrupts target a vCPU that
>> is not running (IRTE[IsRun] = 0).
> 
> Why is this still an RFC?  I mean that in a good way.  I haven't looked at this
> super duper closely, but the patches all look to be in generally good shape.
> I.e. this seems well beyond RFC, unless there's a hard blocker or something,
> e.g. known bugs?

Sorry I forgot to remove RFC while sending the v3, will remove it from
next version onward.

> 
> Another bigger picture comment: I'm very tempted to say this has a hard dependency
> on KVM's irq_test[*] adding support for AMD.  I know it's being worked on, but I
> can't remember who is doing the work, or when it's expected...
> 
> [*] https://lore.kernel.org/all/20260626213534.3866178-1-seanjc@google.com

Sure. I'll look into it and will see if anyone from the AMD is working
on it actively.


Thanks
Sairaj
