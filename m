Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543EB2AEF1
	for <iommu@lists.linux.dev>; Tue, 15 Apr 2025 05:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744694553; cv=fail; b=EA6ESzi2UwDoRJdhuCKVikyAN0CVLzzyyozyDUkH1q5M2Vw/O3dMaBm9rJbuqcCap1udK+ScB08MuLrqvSR/qdRisjKyt0clEzWVY9pDZazC1URGmuTJnoje1tStxdJQ217Gaq9P/sN7LSGajaRIbvMMpv0/IV4Qivwk1+bPTfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744694553; c=relaxed/simple;
	bh=XTacr9T26mBDIhqbRhq75tb9D5JnakLI6Ds0q0+/ycQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d2FGje9uAjguY801+aAOSYMfd4EqeoPmKEsnKEZB+IPdEyS8854RIhAKlQHNdTQJ8YpgxtY/F8Bm7MJL25tNXKFrEtmiuEaBzqApRFa+l5AAYfwaDBMFMRwI2+L4bd1swVkRuFRvc782/Ya0NPgWmFgFz4qeVurVVuKw3Cq7YkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YigtzHpm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=p6eVdWo/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YigtzHpm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="p6eVdWo/"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53ELBqdv013067;
	Tue, 15 Apr 2025 05:22:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Dy2IAg4ZgIu8I4qtboSNyCsT/G6+5pk9wv65mMoLZvY=; b=
	YigtzHpmUxVW/dGx3tZDsyMNrXupB/VEW8Eo/HqVBJaazMpTIpQIPzNGB2H5/dZD
	Q/GEsZeIaVfTgMcD7ZadmdXUWHn+00bCTqnDyAZlEkMPJN+KcCL7jnvkubH+J7v1
	wC9SUFwRtk7n4fyqcCv0RXTproIlcp5zo5PPVnlBCOfIqbI3NpNUqOVfZFTshXZq
	LZOa4ez2VZS8O1W6xwOoC1zXugblWWCKNrMQfU/j3x4JEahd7zowjGN7FcwGrhjk
	tjoTOQIWlUK4qPu3PIcAJMAJ3301Yj7a0aWCog7i5qS+Q+ypPf4yC2B9+jtHHYOm
	cpAyvlNv3AopSUVRyedIww==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4616uf12ws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 05:22:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53F36NWu008599;
	Tue, 15 Apr 2025 05:22:06 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 460d2pg0fb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 05:22:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uy8ZqWiiHWlfiycKnID0zTqxWBet8hcQiD6Z2eYmQUEFngU8aHh6r5GTSER2m12r4clKwNmK6P0im5WGhJYKF2FHndi8uXRV2S/5Y6M3L6vxv4ZG4gnKmW81wdcNvRR0qUS6+vTmU0xoZrEULVB4YN1VfkU2X7h8YEVKYe6ilnSCrNbjhQwT4dAi2qWN2ixVJl+VDQqgdnAmEAKDnuahVD5lUnXsG0syEZsUNt3PcFilFOema8blovFC7iL0didPYmXWipfKSvzFWB35tWJy0FaVMXYEtrwZ6/GQpxSmx/LUgtuxtknMIP6UHunRPwcfUpGqbkwF3cLYjzGZZFox9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dy2IAg4ZgIu8I4qtboSNyCsT/G6+5pk9wv65mMoLZvY=;
 b=XTdkhBsL6YPfJRRx/pr72R0RzEl6bnRiJHmxKjAlq7bRWJ1yE2Z4LN/KzRY8HNYwg3SjKWfTxUTPxXR4xw6VCvygAL/3ZMtqwKGn+QqPdzsEfYc1/PgUJRw+sHh6iTiTddCAshFFxqTSy1YLiafzzNk9isCZvkcHxMO/1ZsCsDe4M/eFj6FV/H9SWHbwbRx8cFiJQdngs0LqsxkvD/GRU8kqkdBPWFIOgErojWZyaAcisu/yd4TiAlIkvS81FHc/CzTszOo/l4zfpE/8wr2DJbVidb9ZF+YKOwUU4nMbJ+cUKnPkWEPMzzHSH4xoG/rXazJOXR4O5YrX+6q1LA1f+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dy2IAg4ZgIu8I4qtboSNyCsT/G6+5pk9wv65mMoLZvY=;
 b=p6eVdWo/f4kYmUvlPtr0EWmfz/1XZyXNVPABZHwFlD/YJrq9FxdSvLlLQQKAv5dWnlkUHeBwOZe5gnfzs9FSXK/2T7hHqkKN1/0+rB+WoG3EymYvk4WZypWC7abJLOW/6n1iCNxWmmcCHV0uR4H8Fm2ZJk6ZpgfRLRXEKoGKKvU=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by DS7PR10MB4880.namprd10.prod.outlook.com (2603:10b6:5:3ac::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 15 Apr
 2025 05:22:04 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.8632.035; Tue, 15 Apr 2025
 05:22:04 +0000
Message-ID: <7d3ac041-9c95-4d17-8069-9ce746a519a0@oracle.com>
Date: Tue, 15 Apr 2025 10:51:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rc] iommu: Fix two issues in iommu_copy_struct_from_user()
To: Nicolin Chen <nicolinc@nvidia.com>, "joro@8bytes.org" <joro@8bytes.org>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>
Cc: "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mochs@nvidia.com" <mochs@nvidia.com>
References: <20250414191635.450472-1-nicolinc@nvidia.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250414191635.450472-1-nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0180.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::18) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|DS7PR10MB4880:EE_
X-MS-Office365-Filtering-Correlation-Id: fe408d11-316b-43a1-b9ab-08dd7bdd7505
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RTI5RFlReThoYnZMZFNLdjQ3N3ZSOEVqRmRFM0NLaHJPbXU3emZyRFVMNzdq?=
 =?utf-8?B?QWdIby9HOWIyaXNVdkExUTIxc1VMVWlQcHRGUjJQdzRRaXZxWFZDNEFJT3ht?=
 =?utf-8?B?U0tHbUx6TEFqYzI1SjczQWhDTEdIZm5NL2pCcmRVemhackFZKzB5bEUxWnZy?=
 =?utf-8?B?MkNXZGdnQWNaTEt6Snd1YVZ4SmticHhUWkJwUUhxenpxcWl2WXBhay9jditM?=
 =?utf-8?B?OVFpSmdUU0MrZ2Z6bFR6MTVreDRvUmxEeFJmZE1BejU4NkxoaUtTVUJRWmpt?=
 =?utf-8?B?d3M2R0dNRnF1MXEwRzNUMTU1RUE1bXYwQm5wTnNhTWp6cEszaGYzMytFVWs4?=
 =?utf-8?B?aERHdG9GQm1BTUd5NkE0enRIVURFbi9MYnNIdEdsNlpNNjVmbUxWSXVVc291?=
 =?utf-8?B?VUtUdE9DTnNoVEJCb3pQczYzM0V6amx1RmtiT1dOS25UNm90U0F2bThBSGt5?=
 =?utf-8?B?Wjk0ZzBLMk00QmgyQS9yZGczb3NTc3k5Z0UzNWZZOGVSMDAzeDJDaytLcmls?=
 =?utf-8?B?blIxL1NMMi93bnVrcU44eW91ODB5R0VwZUxFbXhIVzU2SWFpSXh2TlZuVkxp?=
 =?utf-8?B?NEVUWFB4blpIN1I4emhPN1gxSHFMT0xyNzdGR29ZN2M2bmJKSE5oYzJFTEdh?=
 =?utf-8?B?Z3dVZVJEeWRvaERUaWdZODNFMTFZVUtyekpveno3cVg5M0pUQUpvRHEycnBu?=
 =?utf-8?B?akhZT2NLajNKbldEcURrNzVHbWJFYmF1SmoveFlsaSs1Qk5CN1ZCdGRybHVx?=
 =?utf-8?B?elVTeFBHZVFTdHI5ZHp0TDBZOGZCMzVJQytIVklYcU92bXVHMVlPdXlzekxu?=
 =?utf-8?B?ZTlYMzJXNnY5V0NVWjRWbEVLUWg1NjdwQUNxcDNhK3JvbXltUkhYWmFxNWFt?=
 =?utf-8?B?dzhJbjJrcGdjYlhReHBJT3ZJeDJCNnF1bXAwMFpwMHQ1bTdaaGdlVjFIQU91?=
 =?utf-8?B?R28zcE5QTW51NnIxS3JRY29NeUM4Wm1BVVg0bHhtODZ1SFJkWUJDY2w1c0Nq?=
 =?utf-8?B?dHBOSlZzOGhVanExb0dwZ0tJb2U4QXhNR3R1TVB6TTBZb05yUEVRZytDSmg0?=
 =?utf-8?B?RWo1enUweFVEWk1yU0pKRExFVi9WUlNSa0RFYTVpVHk1d2pYQWJTWUEvWEQ5?=
 =?utf-8?B?YnJXME5SUkJmQjllVS8yTXlXdW1uV1NoWVFibVppTy9vUDlQMGRPaE9kbjFE?=
 =?utf-8?B?VzVUVzhKWGpjeFZLVUUwNk1zVS9IM25XdlBLT1NEUk9Dbkhwd1JldHVVeW9Y?=
 =?utf-8?B?b2Vacmd2WnpndDY3bVhXc1ZGLzQrVnVLbkhkS3YwdVFkMHlGR3BYczE0cmN5?=
 =?utf-8?B?bEFJalB2Nmg5OE9iVitkeGMvc2lKNUVUUW9NVGFDTHRuMXRvYUZ1d2RBcVF2?=
 =?utf-8?B?VVQ1RldFMC9XOGRWZXNkRFRxck5lRmRtQ1B6cDEreS9kZUhiVzh2SytyYlBw?=
 =?utf-8?B?SWQ1dEJjNlZBYWtac0ZSVXFRRHV1VlRxSmtIQ0VNdTNUaXRHQm5wRnhxRGg4?=
 =?utf-8?B?azg2Z3ZYemtyVCtEaE1lUmNUN1BkRFV2UEdMT1gxL0NXNE44VDBIN0UyWFc1?=
 =?utf-8?B?d285cVl3WFFWSkgwTmI4a01oZUxKcWtNQ2NqT1R4bldvMWI4ZmpLcGZQU1o2?=
 =?utf-8?B?NGZBeUlDclRjc2tBZ1ZKMlEzUnlxekJJTTdwckR1N001TDZZQXphVTQ0VzNK?=
 =?utf-8?B?RmFtUFdTeE9XS2J6WWJ6ZkF2czZwYk01TnhzMHRXaEs0bmxZL01qVWYzMUR5?=
 =?utf-8?B?czZ2bkhXc3M3azk4WFJmcXJydkdaY3dRYTR5RUVvM2VQS0lkT1FUYkZFMXg3?=
 =?utf-8?B?L1U0M0w2dm96cTFpRXlQRy9KbDBoRElTUjRQUkVYUVdHUDJEeFRVZHdwU2RU?=
 =?utf-8?B?cEJ6djlkSmI4VGNVSWc4SWdBUFJicmNXd1gzOFM3Tm1VdXZVVDMyN3RBR2du?=
 =?utf-8?Q?plleR0H1asQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzlmLzh6R1VYVEZrd05sZWVlcDdsWmhLT0FicG02QzUzbi9mKzlXUEVBVkNY?=
 =?utf-8?B?TFlpZFJsZ20vb0cxb1pWbFVCZ09hL1RTaFVsdXNGNzQ1TFJvYzRUbWNSaXZz?=
 =?utf-8?B?Q3F0cjRUbUkzRjFpTHdHaTB3cUtSbjRKWGZVcFkvZ2pKbHRya0pqalJoWWlx?=
 =?utf-8?B?ZXJTN09rNDU0djRYdGZiTS9YZW4wU1JGaG1obzJCUlJVZmFBMzZCK2ZQWE85?=
 =?utf-8?B?K2ZPK2hqLzRKb2crRC9HVzdtblg1SkJUaGUvSmVmYzByMFVrbEV0NVc2SkRX?=
 =?utf-8?B?MW5PeXcrRmpPTkVwaVJaeG8xc0J5NlZ5UEJ0MSt5ZnBMQXlLcXRHdHNhQlQw?=
 =?utf-8?B?M2xaM3Fheitoakd2cU16aXNlRVhES3hjSGxsZnlkd241eU15TzBxRXNKRysy?=
 =?utf-8?B?Y1c4MDZsTFVKelp5MUE0dmR2dENKeEdrZllzTndmUERQVE5tRkx0bHpJcllQ?=
 =?utf-8?B?dm5ueDdxcHRxcTdIZUkrOE50cWthNitVT0RBZGhEOVZIeS9qVEtWb1VNOUZJ?=
 =?utf-8?B?VXpLYVh1cis4dG96YTRObW5ERVZkSUtjN1hXa3ZRS2tLNVZKb1FpbGNCdk4w?=
 =?utf-8?B?QnViL0d4SnNoWVBMWnhmcjQ3U0I2RXZsU3lwcys0MFJsRGUrb3A5WTl2aHFS?=
 =?utf-8?B?a3FkTEZpMzlYTlJlT2F5KzBnMkYzQjR4VmRYR0paSUlSd2FybzhweWxxN0R4?=
 =?utf-8?B?QUZjSU9HK0VpRWdEeDY4ai9GVkU4N20xZnlCMGNoaWFPYmh4Mk15TjRXNWdU?=
 =?utf-8?B?N2VLMmk0N2x6ZmNXVi9CNklpbVZralVVTm91LzRaa2NtcHpLbmRZT3B6NEpY?=
 =?utf-8?B?a3FyY0JUQVQ1eVpQNDRvNTRrdWYzb2VWUWo5Zmk5aGlpQlVGYzg0dTc4dTBl?=
 =?utf-8?B?ZnJudThhN0R1Q2NUOUZiU2F2ZnVLamQ1TTkxQjRPeStVNWhkdFk5c084a0hl?=
 =?utf-8?B?bnpmT0gzOUVIUDI5VFNPU2Rrb2dqUWY3dXNrNGZvMHpFbmN1RElaNDRLQXBw?=
 =?utf-8?B?ZCttRS9YbDI1dFJ4bTV0OUtRN1dTcHlRY2NDdjFOWXlaVTJxQnFJYzE2SzVF?=
 =?utf-8?B?dU5pUjI2VjhxS3BRdm5xTFAyN09qeFRSZTFQK0p2N2IySWpaajZBV09DMkI2?=
 =?utf-8?B?UDBNS0JCQ3BndnYyWkFiSFFJOE9OSVM5bGNUL2lRQzlGMW84RDlZNm93ZG9N?=
 =?utf-8?B?QUo4MzVaaVE2Vm92cFZGU3B5amRiWFVYOTd2MUh2YngrYXJ5OXV1TXJPcVRN?=
 =?utf-8?B?OTF5Y2xZVVlnZi9DSGpReCtMZkg4cElaMVNwQ2Q4T29pVThTQWJrZU9MSkdR?=
 =?utf-8?B?RUJxVFpGNlE2OG5ONGtCeW9sY3U1U0RtNk44N2YydlQ4TU1oaTRBaU5IY3I0?=
 =?utf-8?B?YnpKWEdaN2c3RnEvNEl2bmcwRHp3eTlraEo3V25tUXUxK2I0aUtUenJ1c2JO?=
 =?utf-8?B?Kyt6WlYvWFc3dzg5bFh1blhDR29Uc3ZGZjNoSzQ3Vk9GQW0rTVhOVy9SaHkw?=
 =?utf-8?B?Z2pQN1VENXJ1WUdsdk5GSWR4aVRCRUFqRm1nU01pWU5DVE5LQlR2UVBhaU0z?=
 =?utf-8?B?a1hyQURib3gyRkJJb3M3VjZoL3g1OUxjenVucmNsOHdVYlY1Ym9UaTBLMGVl?=
 =?utf-8?B?NzlsdEpGZy95ZC9MbjFDVEZSUTBCTHJDbFhudHpScTFPNmo3Ymg3RzBRNjM1?=
 =?utf-8?B?UFFtcHF3SVY1d0VsNXJRYjAvT1BsOWJFZTN2UmY4c2dUUlIwVVZtVk14TU92?=
 =?utf-8?B?OU5tMXZOaU01ZGlUZ0dtUnd4STg4NGUwYVo3dkEveFNmaUdrWndKMFpzVktF?=
 =?utf-8?B?Mm41cGR2ayt1ODIwd1IvUHhBOElrU3VFdEdZWjZZRjcxSEtkWnBBL290aUNz?=
 =?utf-8?B?VkVxZm1sQVppWkpVSFl2NDVIVGt1NEF4bTJaTUVMaTBXZ0syRGlrN3FnYi9G?=
 =?utf-8?B?Q2E3UDhqUHpTZWlIMk92ejQ2WnduSVh2bTFZTUtXK1JkUEhGb3NPNElGWkFt?=
 =?utf-8?B?RDJkZjlET1Q4UTQwaE1IeWRReGkrK0VzVUtMWkduOGpMMHpVcGw2enRBWVpx?=
 =?utf-8?B?cG41RGY3Qk9Rcnlpd2JYKzBua1o1WWRZb1RQVVBFekp0Tm1tYmZHZ3B0aVdH?=
 =?utf-8?B?WTdFb0NYN1dKUVFrV3QyeEUxUEFkV1IzUWJnQkk5S3I4V3ArQXBwUEJJQmJu?=
 =?utf-8?B?emc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+tOcEK3wWngzfzzTgnZp8A3z7c2OsPD6wqg0nk4qjcwFKEDYrbvpvK++Tiiiu/5CMXWeKHgZoMgL5O7JnUT5Dl0JTCi4XmJk2Rn3mMgdH7wPF5HybejzqLz1OA5LRlQxq72uGa2/Ek+uOsO1PBYQft5FBLViU2fAt+qZ02wlJe6ymTAiRR/EWakHHh0UL6iOS1UCyltqFnpHvf03ixz+XJfGdYaqMtNmJ7JpB8O8H9cftycnzFf2OMVHSJofiPz8S6POOvMwthq9Q3b0nN9hxDB49amUUITrHJ+pM1xWPcb9ANAhCnEJGbL4rBRQ2nSCoRBDdLBv3tFxzfA0hybaRJ7rN104OvViSUzkui0OnDMWftmvx7K7L+VOXD+9GUN0TDfpa8e8QreX7uuWNY//iZyEUskVE3dIOIJOhe4KxnQqdi7gGY2Cta7ZC/t2erpVlMg9L1AT/4s5xXzRFahWs4WngFfxEGzclAuCzPIz0EfohhV7CI2NFADlIsKBmH/VQ74KrEj8nbl6FwE0PRbihdF4Jx6x6Qc5HnOsOuypoaEw1x5xuOJIK57BkQOUk2C6raR7HqFBn2+kixw2IyRco33g+oXd1pRTpfHUZBCYOng=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe408d11-316b-43a1-b9ab-08dd7bdd7505
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 05:22:04.2069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eyjc83fRJlgBZGhwpDPN4A2h1ow/0ukp+2k4uIPoYJn+ochhVgz1lgwNs4lOJVyLRE8yTw0NLpaT8nxEBxALfH2PScl1AtRjzzVLm3oiggY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4880
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504150034
X-Proofpoint-GUID: IxhbwAjC3CuUvmRyi1p1SB-S_0GAjl38
X-Proofpoint-ORIG-GUID: IxhbwAjC3CuUvmRyi1p1SB-S_0GAjl38



On 15-04-2025 00:46, Nicolin Chen wrote:
> Since both issues were copied from iommu_copy_struct_from_user(), fix them
> first in the current header.
> 
> Fixes: e9d36c07bb78 ("iommu: Add iommu_copy_struct_from_user helper")
> Cc:stable@vger.kernel.org
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
> ---
>   include/linux/iommu.h | 8 ++++----

Thanks Nicolin!

Acked-by: Alok Tiwari <alok.a.tiwari@oracle.com>
