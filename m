Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.68
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793118799;
	b=eOEghD+S+/LpWHzJ1t7yKX6B5mQvTXv43V0W2MwM6uBCw+q+PYb0CvVXk79Hao0+RxDc
	 rv95Yqeikd4RFW8VC7oFJOkzIJd3b1VxYDyoTap43fjHdwu45Xeg/32BhZ34fCOjnLmxP
	 LDCc6/49JG0cg2Ew7n7405r6wV0QMnO05ogNkQlsgEewl/Arf3MyLiFBAABi4YGvyky3j
	 EKKYoZkq20YsS/16dkxV4Pw0XYxTWI2OJ8NhPP+ug0wawT0DFv+tlbvawtDtGHTnjeqRb
	 eKl/zKJw22djT1jGiqhT01NtyTmO3zZUrtMTmyqktnAH6aVmRr/WFgLbTm98LtgSYeQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118799;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=ZlrRHgf+LfmmKEtQ7PGUmqOVU1FMSCnwVckjiZsu+qw=;
	b=TM65KMzsOdNysV5fC0HGefbjTeuhJ6nr7AUXuSsgywaPwGMEwUUGJ8wdRSZYWOjve+P7
	 /VVCHoAfAIPvPirGeib2C+UdOd9U7bSPyUp+q5Bmg+OM0NZBi4lAaWNHHNTF2J+DwaKGF
	 ICEFvzR4hqc4GK+W8sONXAN2Cr/E6/xAwdBYCgrrgqCMAT9Pr88tWi2JS9Dd4H/wDRI0w
	 cC7CkI3ir9ei5Yilyb/5hwCpWPCF55eKhunDzV503jEx5IOUHPatXYD8bIQSdXbqWSsOG
	 BtMhfC/1AEAGVoIM55tMCgf5eCueSUsyei1oHpTIQLbzOBsc5iPR3b67Wx6nECMYBjw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="Nu/IZgFD";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.68
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012068.outbound.protection.outlook.com [52.101.43.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA96D606A31F
	for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 16:33:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA96D606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Nu/IZgFD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qa7HIPuJQIzIgxrYbYEe7vKXvEDLC/KEEfD2t2+vMd+vAqD13qVNMr1VR+qpmSsgfMhb1Ysf0D7chD8bRipdhuyAslWWE5XVn2LfaJzSq3Zmoepiwpw9mQUdoe52+ejcmjbwZ2nqbFUlTj1pCtYZ040cRMEvwDI6t11oFXjzcVQwdBa7BxcwdErvnmh8Lzue8aJlBbKyDBSbZgU+jUrARPF/f9tBtu+8obPB83TIHoEW6wotknuB7k4NGxHywMX/aCKxvWJmtot2zRURbyqSdKvN37y5o6zBFepK5zcFJe0FLwWk4gOFyTpf/zTJRnu+tDspKfq0KL2yybZ0PMnrIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZlrRHgf+LfmmKEtQ7PGUmqOVU1FMSCnwVckjiZsu+qw=;
 b=a4cgl9o7VlV0IxuVsdXN3XKCwHZrikv7PKI3tfbEh2pRmbI8kHU9MB8DVC6GoqX0FWhTAQB16Kmyj75JBUQA9lfY5+f/6L0WnsUFnYNDmJQ69n932F6kw88j5zd8cYam36nzCZeuzkIMiH3kp7C+1LiJtxdlZpFEPr64Q6u6iNd8+kPNkRVygkOanHhKMWFXyjzUc3z1O7VBWJtXGr4dzie78DbqhrkX7XzT2iuHLyZFxV/Pftuv5g8mkCuHtnBlIJUqRccG7UjcSS+pef2qrKf1BLbQz4lqbr+6/xUTrAKnJvXpThV/C135goiMcr1/r3Ski/MgsrFPc1RtC+lZUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZlrRHgf+LfmmKEtQ7PGUmqOVU1FMSCnwVckjiZsu+qw=;
 b=Nu/IZgFDkvwtA9NKb1NxEoFb9yaj35Xbs50sTcbYRAtGAUaomLt/wuQxluJbejgPGsVd2vzOSvq+mhewy2kxvRgH97UNHK64x6hwj8pJjZ++v5LIJPfDA/G10wDBKwcQZUp5zagSDi0bpSD5oEdn0Jj3Mbte9+EV5l7pbJtTqjw=
Received: from BN9PR03CA0204.namprd03.prod.outlook.com (2603:10b6:408:f9::29)
 by SA0PR12MB7461.namprd12.prod.outlook.com (2603:10b6:806:24b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 16:31:13 +0000
Received: from BN3PEPF00022BC0.namprd04.prod.outlook.com
 (2603:10b6:408:f9:cafe::1f) by BN9PR03CA0204.outlook.office365.com
 (2603:10b6:408:f9::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Tue,
 27 Oct 2026 16:31:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BC0.mail.protection.outlook.com (10.167.248.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 16:31:13 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 11:31:13 -0500
Received: from amd.com (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53 via Frontend
 Transport; Tue, 27 Oct 2026 11:31:09 -0500
Date: Tue, 27 Oct 2026 16:31:05 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<vasant.hegde@amd.com>, <will@kernel.org>, <robin.murphy@arm.com>,
	<seanjc@google.com>, <ashish.kalra@amd.com>, <pbonzini@redhat.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/amd: Clear amd_iommu_snp_en if snp_rmptable_init()
 fails
Message-ID: <gzxyzqziegcdin6vnfpcphnu3m32dpdjdfj3hnbddpjvkdr346@akdnsb4lepbs>
References: <20261023185041.8685-1-dheerajkumar.srivastava@amd.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261023185041.8685-1-dheerajkumar.srivastava@amd.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC0:EE_|SA0PR12MB7461:EE_
X-MS-Office365-Filtering-Correlation-Id: 65de3f34-00c6-4964-ca16-08df3447b760
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|82310400026|23010399003|36860700016|1800799024|261026140227099003|11063799006|56012099006|261021121427099003|261022075727099003|261009223027099003|261022105027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
 895FtW99a3Km/tdF8i9MvC3cazJosDPyqsIbsSI7fw90uKjOA/XkiBeOot0v4PCGtZ1BA+AN9ZyAwDEQlp/M4JZ0rizJz5/P/6pTixeKzaGN1+eaQ44j7lsuq7qGoGp6nGyEkw0iRbjScowI3I9aYPNeAsMVJwx866x/cWRsP98QM51/GNgIe9drjYCVj7nhgYqhonbvqyMtTnavDxh+mwv95Usks6wBv1tknZJ6ETW+hKDIZMUyce8vn6yLRtt1Nb4l19ppyA2rLeiI6ULQf0egw5P/qHiw9SFiMwghG4l6nckPJhvs6k2pf5lgLHd89IvPj3IuLV7NavUfQ9tXPNklgjOcRo3Glz7bOYYec9PV6KiByihJrHbEN8JYhPAXXJzZyOfk3ieoeeqpd1mauXAwHcLIIYjU48Qv/uRO+EAA/mxXSrd7M+AC7uZ6ldY8SWrQ6spr1AN9iUi8dEj3GAImd4IhSFs103GDimKntXFuy+Q26/0poArs/pOExPklJzlkG9hNzuGU3/IpUYEHLh1trZtOVc0EHZ7/vjwdM5CY4siH4XhX6gZXberbtSxwzZI2y9TRAh+zTdf8KkRV/tRiIC5ZT+g1lJvkzgpfxsVyXRc8dGx1ghSQo+3n30yBGDt87gQpLdaBAsRwpG4gneeogWMXBPkY41SDZ6aBLhH1csnD/1igDHLLS/uA8PSOIJxvTa12ZHW0WI8EfP+9Aw==
X-Forefront-Antispam-Report:
 CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(23010399003)(36860700016)(1800799024)(261026140227099003)(11063799006)(56012099006)(261021121427099003)(261022075727099003)(261009223027099003)(261022105027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 bXEGINXxP0cTwLpdRObk93D/2Kl2vtXEQe4H92bSfD8j89xv8p54rnunM3acAbdgTQP9T1euenKC3agyivg0+KrQff+tcl/dafEdqOiJqhDogr9ahL629Kuy+wGL6n6J+pspgHrBKZLgFp+nb54HdtdPDODbBfEyeNkL5vt5s+X9QGc4Am59GTVVsOCJK1cOxvqwd3PJASxCjEoszDj1fARPr9xoI3yOAxO+VEJ1YPpevMnUzSZl1NEcmbnq8y2mTkivFAJfIJCYaVOgyI/+CMBERl3+/kDNA13JiE4ygHWIZqzW+OldoTeWM/RML/+WgAwEcQSemA7CKLYw0EAiILjpZ6mVlJ/eJDYjHhElb6rfTlY8kf12bEvqvHJ4PhILhzxqSmxFzyMb+sjRN5cL1WDDcUmVxKyY5hGGnbv/zzNZvwsv1ctXpR14/13X2XAx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 16:31:13.3358
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65de3f34-00c6-4964-ca16-08df3447b760
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
 BN3PEPF00022BC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7461

On Sat, Oct 24, 2026 at 12:20:41AM +0530, Dheeraj Kumar Srivastava wrote:
> iommu_snp_enable() checks that the IOMMU can support SNP and sets
> amd_iommu_snp_en, then calls snp_rmptable_init() to map the RMP table.
> If that call fails, CC_ATTR_HOST_SEV_SNP is cleared but amd_iommu_snp_en
> is left set. Later IOMMU initialization uses amd_iommu_snp_en to
> configure the IOMMU for SNP, on the assumption that RMP setup succeeded.
> 
> Clear amd_iommu_snp_en along with CC_ATTR_HOST_SEV_SNP.
> 
> Fixes: 409f45387c93 ("x86/sev: Fix broken SNP support with KVM module built-in")

Reviewed-by: Ankit Soni <Ankit.Soni@amd.com>

> Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
> ---
>  drivers/iommu/amd/init.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 8a410d4aa370..d413b1240294 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -3445,6 +3445,7 @@ static __init void iommu_snp_enable(void)
>  	return;
>  
>  disable_snp:
> +	amd_iommu_snp_en = false;
>  	cc_platform_clear(CC_ATTR_HOST_SEV_SNP);
>  #endif
>  }
> -- 
> 2.25.1
> 
