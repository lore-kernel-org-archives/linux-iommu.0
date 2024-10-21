Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE6B1F8933
	for <iommu@lists.linux.dev>; Mon, 21 Oct 2024 14:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729519623; cv=fail; b=qSB+i+gK+bkmAPtAJbrP5Ob4+FCTeq480bRMEAXbCSvMVo1wTdlXms6rwXpX2j6KFWxLL92zkuN9q6Nth0mojHtTLXzWOoEFL7WIirbjZE1qbXbuzdGlBhV9Y74ts0aDwd//cc5g0/jw4OZzJ2W6B0bN0lcO7OwSDnTXSFtkqDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729519623; c=relaxed/simple;
	bh=SzhFqrA0rgCZF5XsnM1Irgu1JvWtwcij7e0JDL652Wc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qyGU6B6B+YOR/zxrxUjmbnq/BSkOq02kY9uTuttL/NgIF3KenPNR/GDK23aFMIrEQDM34sadqcnvnatB0M1VSZ6ANloWNw5nfBqi4PLurOd5bR/qa/AedubGZnyyPaUsfUZo35i+6RgL0den1y868vMi469xMvJgybyZT8XwZCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HYPOx6iP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VoW41PeK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HYPOx6iP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VoW41PeK"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49L96dQb026545;
	Mon, 21 Oct 2024 14:06:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=7W4SfY9I+xyYObbqFoLSodsgJRpr7kwbHdMPTvl6xAs=; b=
	HYPOx6iPsCeNwnGDcBvSotIDNocgBZvl8jg1PLyRfNsL2vtMsavAZtIZSX4aVIgI
	t8LLcNeKUWQ6vdJbCcfQCKVNLk0HrIP0oNh8typE/q4mUr65jf6kZNC1ISkWUzqz
	d8QbPikVF4k5FmTzyTLWhX0+L+fxqtsI4P0QCSvdqJtI+c2Yl0sZMrWO3nyhwBn0
	xdWKeTQnUu/7zNkO34pTMN9KdFVLt5f1qyww/24C8tSRW9Et8MlwWqjxT0KorfRT
	VUADaKVW0sBttSh1mWf1L8N1fuQTAbkRRsJ/GpMpum5Vv3x4HUmWVaamtqt2bfCi
	rvj4px8equGKrVvwTB97qA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c55eb5hy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 14:06:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49LDG37b007653;
	Mon, 21 Oct 2024 14:06:53 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42c376cp2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 14:06:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WVsm9ocOXf/xQ+CBfQyfatAOfdHR7XXURsETxBOIfI2g3bOiFR3HJlfc4V9QlE3IUXN0Vs4T30TjQVug8uHkvRrHCQFEqyIvF76TrpCZL5emXdI5UmtddlowepTWeD/rENQDRW6aoyvj2x2gSknRUxHI2SJpiFcJ5BJHksF+H3jiTh7DiB3NCEWAkc4//59GYdzNv5WqqhlQJtE6COX2oJ9i1fAM0E/9/bUxf8c4otwcfezGXp1L/G7TJBn7LRd58aeWsVnv1KSer169a/mD89e3YoD3mkOoEM107dftPjXuWRfIrgovBIMywPqP7CwnQgil0eawQURP+zZo1q+RDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7W4SfY9I+xyYObbqFoLSodsgJRpr7kwbHdMPTvl6xAs=;
 b=ocVqPU8ppHlgRLv9xJlgg8TDbYwBEaVnEngceOQase/Y8dxsSJzIYbwyyL7tu2xr7Vv5dqFijRxq+Gjfc/a0/yLHtb6QJnacnZM+YvhE0S7g7tZAKcVRWgRdXcrH3htwQNpAk0KJXoXxm5LoPQ2CqGRRCuflLrArHx34N+2tPQ53cI3VhdF+3BJEcCrr8jo6XFkuAMR+OuNh7GqZRINBpQZZiOhXTXkov2MVfqibx4uz5Y/PJsgg5eEalxUbxi5RmSKYvGj7qP8Nclswi1TMFB3Qv362mFLmHDY0uYrNPfzgRjOwOYsAxYv0u684fCvml3P1TulJjGw++5MQaquLlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7W4SfY9I+xyYObbqFoLSodsgJRpr7kwbHdMPTvl6xAs=;
 b=VoW41PeKpLYu7oGVNRXdoKco8l06tJUcWka5fjuTfXA4LJ/KvFG6zuc8r5R2soa8MC9iBYPGqv/q+yf1FzFNJe4nZQDykYGY6LVlMwLocIuqk9KRcPgjlaNLW48BGVncx3L2FAb0ao53/96MzCnetPMcfV5j3ULMf/STa0XcyeA=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH7PR10MB7108.namprd10.prod.outlook.com (2603:10b6:510:27e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Mon, 21 Oct
 2024 14:06:49 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 14:06:49 +0000
Message-ID: <561a1712-8613-4f88-ae60-7f12a4b7c244@oracle.com>
Date: Mon, 21 Oct 2024 10:06:44 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 8/9] iommufd: optimize file mapping
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>
References: <20241016130001.GI3559746@nvidia.com>
 <6fdad0c2-8b6a-433e-9405-016aaee40413@oracle.com>
 <20241017192418.GD3559746@nvidia.com>
 <c4574487-346a-427e-a97d-6e1ee366ed1a@oracle.com>
 <20241018001046.GF3559746@nvidia.com>
 <279c7e80-1d72-407e-bfb8-d286760a5e11@oracle.com>
 <20241018160430.GJ3559746@nvidia.com>
 <dc59dc36-027f-42c1-971a-8218c658c5a0@oracle.com>
 <20241018175951.GK3559746@nvidia.com>
 <55027ff1-05cb-4ce9-adad-8dca586a26ac@oracle.com>
 <20241018231011.GL3559746@nvidia.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241018231011.GL3559746@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0104.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::45) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH7PR10MB7108:EE_
X-MS-Office365-Filtering-Correlation-Id: 3db00d2f-c36c-4257-fec9-08dcf1d99b30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWd3di9mMENpOWN0N0h5bGtQbkZ4NktMQWVoMG9lSlQ1ZnlYbE1ja0NjSFBU?=
 =?utf-8?B?bFhFWm5iZkFJUEV0RGcwZkFRL3RteVoycXVXeitPc0dqRGw0aUtUQlNGdmlX?=
 =?utf-8?B?WEQxSUlHZVNTZ3BPMVZwcjIzYmwrRW00TTFqNEh2ejlXNTA0VFNmUEFiNUNL?=
 =?utf-8?B?bkRaNVhXck0rbjREZmxjN2ZHbmtRdTR1WUlzQzFsTVJKR1BjeWZhNnJXWmRR?=
 =?utf-8?B?czhjVjB6OW9FRUJZRnQ1NXRRWEpjY05MZkcwNllIalZRVEZURmRYR3ZjN3A1?=
 =?utf-8?B?S3lNSGdhSEdBYStIRHBEUjgyQUVPeWx5SW4yZmJCZVk0ZGlPTkVRRE9UZEd6?=
 =?utf-8?B?RTBiR2FicEZMdjdzazJoYVhlcmR5SkVZcmp1SWhXNDMvbXk0M3lEWkowalN1?=
 =?utf-8?B?Umh1d3UzNU51QVhHc0VUTm1mT1VRMEJxTlBXYTNuTk0wMkJaRmpkY3BJTm02?=
 =?utf-8?B?VkVZRENJUlJPWDRveG55dDNUaDV0dzh4bU5MYTR0REEzZ0gzVnNqUzhjOTRH?=
 =?utf-8?B?ajFkTzNYSmJDTFZSQ1JvUlMrT0tXWmlTQzVCL3V3UnNqZ0ZmZHQ4amJVU3ZK?=
 =?utf-8?B?UHhISDREeERkKzBuZXVGYjAycm5UNjNXNGFMMUZ4L2orRHN3R3Q0c2FnWTVz?=
 =?utf-8?B?U2RjYTdIUURvdCsyR0dvNUkxVkV4NEVHYWZsb1hVSHlUWXkxUGt6TEx3Nm5R?=
 =?utf-8?B?SEVONVhWVTNuMDk4SWJ4SytheWtqVkE4dzNlTUZnKy9OT2VpbVdCV0EwNnl5?=
 =?utf-8?B?VHlaWmszS3kwNVlZR3lTbjVUamhySFhjTnI5OFBYcnhvbnhFZlRtaEFCWnRl?=
 =?utf-8?B?aVB4eG9uQzcyYzZwL3RDcXp3U3BIZ0NYVDZma1dadW9LSlFtRjJNdnRNYjVS?=
 =?utf-8?B?OXNDRkhNYU5VbCtsOHJPRSt0WWpUamtmV0c4T2RPQnJFVDdEcjhXaVFzbVFk?=
 =?utf-8?B?ZjBQQW1QZy9sdjVhbHBhVGphTmRicmxmR2k1UmJma1IvS3NYUmIvTDBlWnVT?=
 =?utf-8?B?OFRwdmEyTEZZUjAvY0wzRm5KdzBjRk56ZHVBVVRPYVFHVDAwbGtWR01vMis0?=
 =?utf-8?B?OG1EVjdYV1g1QWxjZ2ZxTGdWTU5RWTRiTVJPaFhtaktxUVNOZVQ2TW9MT2dJ?=
 =?utf-8?B?RFYwaDdTRHlkM1B4V2NMUFQxU1lOZ3lJek1SNm1henU5TXNlSGdzNmRWMFF6?=
 =?utf-8?B?NXJ5dWxhdWRucmhPRGtyZ05LT0xyRHd2TGhMTUVHVzl2VTdvS1pYQ053SUMv?=
 =?utf-8?B?ajR4UTdOM2tYL2lFNm9iVzlxNVJvOFR6RTdoSytSSnZFUnpTalhjdG1vMUVS?=
 =?utf-8?B?eXhVeEY0U3A5L2E2ZTZqaFh1THNVcjJVakg4dHdZS2t0OGMvSStaQ1AvUFZZ?=
 =?utf-8?B?Wk1PeVVVUWczVUQ3RXptb1VQUmkrNHgyQ2xFK3Uxc0tpRDZ2cm90RVRkVnc0?=
 =?utf-8?B?MjFlenQ4MXp1VGZ2c2JUdGZ6cHJKa05haGlMaEdDdFEydGR1bjhsdzU4UnNY?=
 =?utf-8?B?MTJJTUtqeEJ0ckxJVDdzS1QwL2sxMnQ5Z2xyWmFsUTk0T1daOTA5Y2hFTC9t?=
 =?utf-8?B?Q1NRTlpESFBwV3pVSEQ1OWg4MHMvL3FyeTdzTzJsdzNDWnB6VGkvRXV4S2NX?=
 =?utf-8?B?MHNRdHZkQlhMdTh6ZmYzVTFzZkh1WGRTUDE5SHZQZlpLTXh5L3hkVkExZnJk?=
 =?utf-8?B?RnkyRGxCY2JYR2M1amR1V0JxZVRzMW0yUXpCam9VLzV2N1VTNFNzeEpqYlgw?=
 =?utf-8?Q?jwEUW8EGo630P+rvhOD8fwF3aNGD/RNLr10UU5B?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmZxSmZLNnM3UnJFMFZRaWpJQVBDNFJOZW1UTFp0MnY5Um9TQXRBNDdiY2pk?=
 =?utf-8?B?QWVTSmJQR3pMQng5VFRwczNBV0NpeEIvcU55Yk1ENkI5WFc4TTZFLzNYOXRm?=
 =?utf-8?B?UnNXRWhwNmFycUkrNFF1elpwMzFTclkvUWt3R2krRVVmWS9Db1A3Ry9WRGx5?=
 =?utf-8?B?M0JlUHAvRWpoM1JMeCswS0NkcXIra1lQdmU0dWVMczdJMEV3TlNiWDFMd2Jm?=
 =?utf-8?B?Wk55N0ppczVOYTJKeGtkM0xNQm96b1R2N1A0R2R3dHh0amh4MVRpdGt6a1V2?=
 =?utf-8?B?TGMvVGJDSldzK2NDdzQxMnhEVUFOdmFnZEZBSDZIcFRadUR1ek9BQzdHSXBX?=
 =?utf-8?B?OUF6TldBTlVuMUUwWWdqcisrdWFMVndybUlnMWt4UDlHa25yTzVhb1gyN3hT?=
 =?utf-8?B?eTc4YUFPMUVnbEJGL3pER2JmSnp1NVJ3QjR6N21LOElMallqSTVURkNMTHdr?=
 =?utf-8?B?QmRyZmxvUWdUL2FaaWpqbm9tMEJUS1M4YXBXWkgySTUyc1dXWHc1eUtRcEly?=
 =?utf-8?B?cE1pTExOS3lKaTg0cXRRd3NGRkJ0blNnNE9QQm1aWUQvY2o1UE5yUFQrWTB6?=
 =?utf-8?B?eTZTOU9xNitlVFdLY1NlclNPTWJPMU5oaDR6cUJhV3R1eXhXenhzVUR2SCtp?=
 =?utf-8?B?OVgrTnhqYTRyQ2RZM2xQUE56Tk5HdXA4L0s4b2NGQUdPYWJ6UDNOaUt6VnRu?=
 =?utf-8?B?MmZkOEdkdVB1d0Z2dEZOSDlyeG9LR1ludmJEODJ2YXFxVEw2Tm5ZNGIxb3dz?=
 =?utf-8?B?ZTk0RGpKTnRnSEpSNytqWEJQc05DNzNKaW1MYUc5N21jNmM1SFh5MjBTZk44?=
 =?utf-8?B?YlRUTlVRU2tuU1NpYUNXcDRRaXJDZHNFQ2hINGRHSmlLcVAzYzY5MFgvaGox?=
 =?utf-8?B?dTI3aTQ2dWQvWlpGaHdxS0QrUlpkOTd1anBteGdjV2VIVW5MbUZDUG9FVGF2?=
 =?utf-8?B?ZUNkckNlcHhrZWFWbHFZdW1JSnNRY3BNVy84TmtMSkZaSmtsSktKK1U1dmhI?=
 =?utf-8?B?RW9lWXBQY2RwRFNkWDBwcVBtMjB2VnY5amErR1ZsdGF4UmZ1bkQzckt6emJC?=
 =?utf-8?B?M0tzYVNLUFdmN2FFYXZON3ZmZ005b2ZoZE5YUXc2SkJiUGpxdEZ1aElVMEZM?=
 =?utf-8?B?NUE1bVU4TUN1WEdKU2IzVnYwUHIrZ2dXZjRDdm9TNjd1clFsMVlQRGtKQ0RY?=
 =?utf-8?B?cWRoL2NLWU5qYnN4Y1hxa1ZzTXpaVlVuRlV2T0EwL2hiSkdobU1GakxEcmlm?=
 =?utf-8?B?cUFxRXkrVGhMd3FyQlBHNUN6VTA5eEhDL0IwV2RJcXcraWtSdjJoV0I3ZkR1?=
 =?utf-8?B?WHBtTWRGcCs1aVJTY2ZZWTFYcjF2amp1WmhxVjNZV29JRHVaOXQvTGRSNEQ0?=
 =?utf-8?B?dmxoMXE3WXFoZkhkWG9rcDArbHlOaHJaelB6WnY4dUhoTjhEdSt5TDVzemt0?=
 =?utf-8?B?WUJFN0xRdkx1Wm5pY0NZTEdIOENQNmZyY1FtaW9rM0RlUWxuSTVOVy9PanZL?=
 =?utf-8?B?dmNuNll0ZC9rRTRseEtNYUFwQkJPZUUyS2FLNHBSQnk2cWtnUzRQZUNUemZH?=
 =?utf-8?B?NDB4LzQ1NFFCNmZvdDBnU3FyeVJBUmhqaTFWSHo2WDV5NFR2U2s3WmJUeUQz?=
 =?utf-8?B?dG40SVRYT2VqVkFncldEbzdzNyttaERKQlNmRkxUVkJBSjBueVN3cElHVlk4?=
 =?utf-8?B?ZWgxOGtaK054T0hkOGxTTE56bnpJYnZLUjN5NHRlRmp5Qi9LVUQxc0hCdFFt?=
 =?utf-8?B?OUp1VjVFZ0dFL29KZ1BRYm1XSGVuYS9GWTJma3YreHVmdEhYYmZkUnJKak93?=
 =?utf-8?B?T2svZDU2dVIrbmNPU25oekd5ZUZ0ampUZFFFVlc1NUdBVkwwOFFHZHg2cG1V?=
 =?utf-8?B?cTJFL2NIYzdxRThGRG1aWE5pQ2F4NmJrelJGSXBPclNiRlZ6ZzJHRG5JMVJy?=
 =?utf-8?B?RVVLRElxZzQxNFRieVR6N0t3UWJ2U3hVZldWdzBmL0ZQL2hrMUN1U013b1l2?=
 =?utf-8?B?SEJ4TERXZTFwaEFwd2JRTzdOMGhvNVNiSEdkUC8zT2dlcDlLY0tVZ2RxUExV?=
 =?utf-8?B?Z01oam1yZ0pwdFNDejA2V3ZKc0N4RkJxNXZFUVRKZlZtK24reXF3UmtqUmln?=
 =?utf-8?B?RDNCWUZndDEyL1Q4LzdadHRFRTc3blNudmJJcFdUa2trSzJFandsa2pvTmw1?=
 =?utf-8?B?MWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7kgBj8EINiTL3g/eGS+rvucw+RiAgia7oA5crGAaFvNcd0/PT5kwwqru0t/628zQj3vlh7YolcMiaQXC3bXVmp2WRiTBCNSH1PldLQfEx5Y00Hle7fygf6AA7HK1Kl6EXmy9ivRxsHa3OPI7mIsPkUcNuB9kYRASaegZZ9/iTSFsR0B+bbhc3EjCl5D47BrJemWtHD8BZJkl20DYChJy305GTZQ4k/EnQxOLQgIxID52giIvjMOMTjgO1C9Z8RraW7Xrlrl/sDFMwx92Pd6XHRMACP1sjBr1fuMHAAN2tNm9wFBkIkZvWWs0ogOWu6I/3RgVZaccVyG07rO/29HOh+7O0kICBg9LO6vl37x/N80P9jYAFjYjFEWPwRTLwSNu+TSaJH8qHPWsBy0PGOjBjerHkoczj0XmnHYLFNwnPkq2IamEdjR/pok5cXBZUTF78eWZA0vlpMg8LVSnfOcYvU5lS4aODa9hJKlAdzDGQA1PisbqHgY4WcJR2yc97EBbKKIlyiGTYDSnIvnQbEDtgXIBHh8NkSSLjEbsZNxYxHuLMmtmy0uWo7QkQ4QZcZjte7myIGLTHB96NoJnj/H2xWGyHRnr+z/hnf5WM0kSZxE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db00d2f-c36c-4257-fec9-08dcf1d99b30
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 14:06:49.5892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9p4g9h0TlPs74tNXoYQRjqDaBItmj+gvGVwOYW61TLnh+13JWDPVmGYJtohKyY+kQkBm97OXnQwCJn+NuOcjt189rysN4y2JWRIZp7RLRps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7108
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-21_11,2024-10-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410210100
X-Proofpoint-ORIG-GUID: BPRP8gHptdoyhEoEMra3GkxgEFs_dSEA
X-Proofpoint-GUID: BPRP8gHptdoyhEoEMra3GkxgEFs_dSEA

On 10/18/2024 7:10 PM, Jason Gunthorpe wrote:
> On Fri, Oct 18, 2024 at 02:10:26PM -0400, Steven Sistare wrote:
> 
>>>>> But why is that such a problem? The ufolios_offset already handles a
>>>>> partial folio.
>>>>>
>>>>> If the batch fills you leave ufolios_next alone and adjust
>>>>> ufolios_offset. The next iteration does exactly the same as the first
>>>>> iteration and takes the partial folio.
>>>>>
>>>>> The refcount has to be handled carefully as the the portion that has
>>>>> been put in the batch needs to be refcounted at 4k and the remainder
>>>>> remain a single ref, but that just means adjusting the refcount after
>>>>> putting it in the batch.
>>>>>
>>>>> It seems like it just works naturally and avoids the double loop
>>>>
>>>> Yes, I can squash the nested loop in batch_from_folios_huge.  (I was off
>>>> point because I thought you were suggesting something else).
>>>>
>>>> Do you want me to delete ufolios_huge and its special cases?
>>>
>>> I think yes, if you can get to one loop then it would be a degradation
>>> to sweep the folio list an extra time just to figure out ufolios_huge.
>>
>> So now I'm confused again and don't know which "double loops" you want me
>> to eliminate. There is still a loop in pin_memfd_pages.  It calls folio_add_pins,
>> which I could push to batch_from_folios_huge, but it also counts and returns
>> pages.
> 
> This is the one I was looking at, yes..
> 
>> It must do the count because the caller calls
>> iopt_pages_add_npinned().
> 
> Ah, this is what I was trying to get to, if there was some reason why
> this loop and this pages calculation was needed..
> 
> So, to fix that up you'd need to adjust the memfd_pin_folios() to also
> return back the end va of what it returned - it calls it start_idx
> internally. Then that can directly give the npages for add_npinned
> with simple math and the loop in pin_memfd_pages can go away.
> 
> Then you have a single loop in the batch_from_folios(), which
> is what I am thinking about.
> 
> What do you think?

Yes, this would eliminate the extra loop in pin_memfd_pages for the !upages
case.  However, we still need all of that code when upages must be filled,
so pin_memfd_pages does not get any simpler.

But, we cannot change the signature of the exported function memfd_pin_folios.
It would have been nice if the end parameter was an inout.

- Steve


