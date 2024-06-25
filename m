Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8191494A8
	for <iommu@lists.linux.dev>; Tue, 25 Jun 2024 11:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719314015; cv=fail; b=aAf3nAz3GnV+c50Zkl16+OQdyOm3moo68lxcok3lMLIeI6KEKVkYgPiDG/1t8eewyw8xPBQJPs3bBL/6BQCPuVlHNtbZDvHnoGSovyVFBOjNeuZDlKoizr8RcFk94KuOlUmW97pbPqwMmHTU6fe331bzsPIg0Xr/xfIHC1FrAEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719314015; c=relaxed/simple;
	bh=EALNiQl6liRivDN8f8XLymFkkQMSDOnucGaPk+ARndQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AB+HmFHcbNByGae+5RHQq2zVc0cdtup7/Ke0pakNMtF8FYvdvPONMNOwuW2X6z5YOMsDskoFD0nCoTSF5iK51gGGP2yG3MD94jUSHdctOZTsUyLPNuaXvG8d9xbThozMapo5tEelSTahnSRkrRS3Y2a2hJiYysvUCehNy0azgDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HwIyYsv2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IF/qrCED; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HwIyYsv2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IF/qrCED"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45P7tXZJ027524;
	Tue, 25 Jun 2024 11:13:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=J04ySHXH1KyuvXOaKfsHhxFKWx2TH7AfV/gPTmi+jg4=; b=
	HwIyYsv20R3DxieHJCHvDqkb2KkoASROSuEdqiF2AZkOqXBOxgCFvZe6K/aHCrH/
	kf9MWRyAL7IQxo/cPhY9HUcUen6RAe3JCKd8HP2alHqRdZ2tvE40/cFdYlf/MetA
	Nh63lkkIUYH1qwVhCO69O41JjRWYRUFNgJ1fu0QvxU2w0+Nu6gjDfCozHQlYgU+C
	CA9Mu1+0vs9XVodHeZhRe10gGjV17ZXoqyne+iDbivAyUoEoNnRbRbnLE7jPfyZG
	BX7jBuBHGjZ5XvHs5AF1c8rpo+gd9Za6mOXxdkxTkYMf5fDSi8yW+pSOTD5le0Rq
	wA/9g/aQHAso+wrgXVeJkA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywnhb0dtm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 11:13:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45PA1fm2037037;
	Tue, 25 Jun 2024 11:13:25 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2042.outbound.protection.outlook.com [104.47.74.42])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn27t6q7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 11:13:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oLHiv+C2TvPUu7bBJsfKk9r/VLsf0JFC3cLsFMeqzlOyrvH5s3ywUhNERlkcu9si/OABE4b9mzlelH4RGHjThAFhnMH9NfNkdrq0a0D3dnw4LRhr1MglIIH7X51X/XY51cFuQXpXd7HR8oGMErvwsShhSm3kfktZpla/Ox7q19QQTLttv5U/vgPuWgLFlzMVx2VpOPvMEqnHV3Roj9OUYI6ozaRh4zAPnGf0TfSFboHCrBUBoB3Qw9gCNA7XGxoEmcALVq1GyjoK7Xx59aY47wTpn+wpl+aJevAGi7F2RLzqdJpzNVk/xC6/Ybs5uae694n43m0ez/XXpmFXP14eSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J04ySHXH1KyuvXOaKfsHhxFKWx2TH7AfV/gPTmi+jg4=;
 b=X5AtPFIKzU7DXJFzejyWJWchEq9Mjpjj1gwEF+AMGHGQN4vg/P2h053t6LIZhHHG0BCRkxvUFRb8fcbvPDixJ2rtrcpnYAkHpMCJB03A0TohrLymG/3+de6UGRnxJYgrpkUutLjeIiwvUXp/3rsaMfuQqbqiIcwHZ+iNr0Myn90fWR8qxjuVLIuGDSvPEI6w+A9tro3JlFScesgOmLdEvnBT457JTKmkuzVjBpVzYUCicYgSrmwymsG882XZpO/M9JmqAIiNQucEfubvtIl4yI2pBr0nco3uxCBffLOFl1+7T1Uj2jLmZ2B9Cp746dVvjl9cLrO6r+PFW9oevxQS7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J04ySHXH1KyuvXOaKfsHhxFKWx2TH7AfV/gPTmi+jg4=;
 b=IF/qrCEDrc7QVFUwsvp/RhqSjjp5IgVP2g1uZZnsBJkjq2k9Z42pN/GLXbvNInmmWCy61v2jVcAd3vVIGvXskMvN7utFJFQnArUfnYxB3FCjVbzUswuSyQ/fMBMNy9ijs7s1dvZrfj6EQQXEkvRHSvdt0QhtaG63Jrpw8oJXEFQ=
Received: from MW5PR10MB5876.namprd10.prod.outlook.com (2603:10b6:303:190::16)
 by BN0PR10MB4840.namprd10.prod.outlook.com (2603:10b6:408:12b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 11:13:23 +0000
Received: from MW5PR10MB5876.namprd10.prod.outlook.com
 ([fe80::4e4b:84a9:89a9:c43a]) by MW5PR10MB5876.namprd10.prod.outlook.com
 ([fe80::4e4b:84a9:89a9:c43a%6]) with mapi id 15.20.7698.020; Tue, 25 Jun 2024
 11:13:22 +0000
Message-ID: <8f2ba561-5f57-4abc-be7f-26f33124a60b@oracle.com>
Date: Tue, 25 Jun 2024 12:13:15 +0100
Subject: Re: [PATCH v1 09/10] iommufd/iova_bitmap: Dynamic pinning on
 iova_bitmap_set()
To: "Tian, Kevin" <kevin.tian@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, Avihai Horon <avihaih@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
References: <20240621184254.45477-1-joao.m.martins@oracle.com>
 <20240621184254.45477-10-joao.m.martins@oracle.com>
 <BN9PR11MB527647553CC48B598BC79C8F8CD52@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <BN9PR11MB527647553CC48B598BC79C8F8CD52@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAZP264CA0045.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1fc::14) To MW5PR10MB5876.namprd10.prod.outlook.com
 (2603:10b6:303:190::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5876:EE_|BN0PR10MB4840:EE_
X-MS-Office365-Filtering-Correlation-Id: b4c5d85a-64c2-402d-dd61-08dc9507d393
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dVBOUkt2MXNiRjBlbVFGb3c1VHVRa2ZCbmx0K3hZc3hkSGs4eDR1WE1jS0F6?=
 =?utf-8?B?bVlaLzJZa1RVVzhuaVZsMC83VXlEUlRmbEtrV3NVQmN0MDhraEpyMjJtZnhx?=
 =?utf-8?B?bkxiTVYzZmtKbDVwei9QYSt0bTJkc1piV3Z1blp5WDFPZnlCbzZhM1VHTTVQ?=
 =?utf-8?B?ZzhidGwzbm0zNjlFaUxCL0pIcVVjUjg2SkptZlNISUNLSU1jaGFtRXorQVVU?=
 =?utf-8?B?NEpEM1hITXJVTHBybG9sQk9LQTlxbkxsSzJmWHFmUEhvZThncExYZ2NLdkpH?=
 =?utf-8?B?RzBUbEp5QlBSWHpJYUNIV3FyMlNaYUlvdm1jTWROaDRsS3dqWHJXLzQva0Zw?=
 =?utf-8?B?Y2oxbjRHQkJKTTBqSjErdFZYTUVGSWZCemVOa3NOTzhoUXAzNWhrMzZCMDMz?=
 =?utf-8?B?eFFIZWg5Q0FtRW5Vb3ZSM2xrbjF1NGZHSkVrdldjUFVLakYxeTJVbUhVanJQ?=
 =?utf-8?B?OWt6SnlEaUdkYU0xUGhnWmxYWjJlTE9WRFYvSEd2K3ZRcGhjbkQ4emphMWR3?=
 =?utf-8?B?VE9YWXJmRE1YL3R0NEdVbzY3QjMxdDkzNmhiRnZwVWpZc25KdkhHVDZCb2Qz?=
 =?utf-8?B?WnB1aTBpYVAvNllqclE5NGs1ODE4SkdxekJDNnhkZkFQdWViVUNUM1NUd3RU?=
 =?utf-8?B?SW9BK3VtVWg5ek56NWQ3ck9KWEcwaytWNUtrWm93QVFuMFhEUm5zbmVldVJN?=
 =?utf-8?B?MWZnNDRUeE01Qk9VQTkrU3ZqYnZUQkNTZkM4UTJpWWhqNGQzanpLYU1PbmFK?=
 =?utf-8?B?V3cwQXBlbHA0Z29wZC9rMVRaTUlDNUJZSklucFZyWGhpdnNtSGhVRXhFYzZm?=
 =?utf-8?B?ZFhrR2J4RlhJM0xqdzVSdmh5U0VhYnlPYXk4RFdFcUNpZkJVZEJ4SUlUYzdu?=
 =?utf-8?B?OTlpQklNSnZHVkVrYXl2ZVFjTXhKZ25HbmcxbE5pRlR2YVhFTmhESXVRYVo1?=
 =?utf-8?B?ZERZMkdJUGdMbWl4NlZtanVpMSt2U3lwSmptdEJ0RVZwVzgwQklKM1BBbkpq?=
 =?utf-8?B?NzhKWk9TODBUcGxad051Nk9RekNleENFR052QkFTUGdCT3RRS0RNQXV6VEpC?=
 =?utf-8?B?dnNHQUltR0NtRGxEdUJqREtTSEFtdDhYOUJHckFLdzBhMEFrYzdOaUxHQVh1?=
 =?utf-8?B?VlRydFQyRXp3NW5HbkZ4bWlacHlRVkVsMHIxRzFjeHpYTGJDQ1lvK0E3Y2Y3?=
 =?utf-8?B?SWhmd1RYN1FwVDZaNFFNOGUrb1lEVm42dlJQUnFkYmNWTlNYS1NRcndaRHdy?=
 =?utf-8?B?TjhvUTJFYkFLRzZlY0VZNWI4Y3NjSzZOV0tzN1JNUUZuMWcycTlLMUVnNklx?=
 =?utf-8?B?ckJVdFF2dERpZk5ab3VWSkYxQVhkVG03eitCbjcxZkVBUDRMcUgyMUZXc3lD?=
 =?utf-8?B?bTBLMGJ0N2Q1VllRaktkRjFFL3pGalNWMkF5ZTluc0xIQnpnWFdLWjZPcllB?=
 =?utf-8?B?eDFPakVLTXJ6M1k0b0IwV0RpUmkxY2lDTWNKclk0bnQxQXFhQnY5eGhFZ29E?=
 =?utf-8?B?cGdVK1hHZmxrNlFOVHhrNDJzRWw4QnVJMTJ1NDEwN3ZvSlpMZDYxTGNNaStO?=
 =?utf-8?B?WjdyMnUwU2FIYWxldGcvbWdnMXcvVUgwSzVIUVJJY0NDbDhHYWxLRk14TDVB?=
 =?utf-8?B?TXJ6ZkdlM01adjBpSUxaSUpDaENsZTVZaTYyQ3R5NEE4Qm14djM3bDdaNzIx?=
 =?utf-8?Q?Y0rnPKDIJX9VFW3JhgTm?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5876.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dnZSU3l4VWdiRWE1S3d4NmYwOHBGOERUWklXQmxLb1FZdXE2WWowbXJTNElL?=
 =?utf-8?B?VmpSbDZFclladk9MR0ZZZ1pkTEZuUEpDa3k4b2FxZVh4YTdlSGdlczhiT2h5?=
 =?utf-8?B?d2dac09BYmxHTkd3N1B2N0lsOFh3WWxEYUhVWXRCUitCOXhKM3gwcHBQS3Y4?=
 =?utf-8?B?UndUYlM2cDUvL0ppTXJXcDl5RUpNUFYxd21Ocm85SWFvb1hSWEZXQlJWUmNJ?=
 =?utf-8?B?V3hiM2VDdUNRdkV0WlBaR0twTklKeWVWajY0eWE4eHlURGk3ak5CZ2psbDY3?=
 =?utf-8?B?QUtJV0UyTFlHcWFwNFp3Y0FvQ1lQNHBxYjJ6WkhhR1d2WGdxK0t4bFgrTE1M?=
 =?utf-8?B?Qy9sd1g1dVFONk9QMGFmU3NjMUJCZkNHdEFRemQ5bXQzM2JndUJZZnN2RW1F?=
 =?utf-8?B?K0hMYkNnWk9Od0gyK0EvdFNTeHJGZjVmMEY2dW42a2lDTjA4b3JEd3lWeGJ6?=
 =?utf-8?B?NWZDM1FYcmhGWC9zVWFPbGxFaEJnWG55UG1kY3NhU0dkbERKbEdkWmtnbHRY?=
 =?utf-8?B?ZEFBcDBZUFJUd2ZZMFB6QmNYWGlZclZjY0hNdENyR2Q4NjVEUzdrQUExNmV6?=
 =?utf-8?B?cFVWTGswV0NEUWtZbEtoTHZ1a1QzUHpjeEwwalVFNzRBU1VNdGYwUWFiWEpD?=
 =?utf-8?B?aTJzTk85ZWRjRDBULy85OWIzUUpHVEsvektUNWZORGNxT1A1N0htV2UrcXU5?=
 =?utf-8?B?VGNDZE92bFZQUitHMzNIYjY0QmNVeXp6aFZvRGJsZHF3SjFWWjh1SVlwU3pr?=
 =?utf-8?B?QzZMRG50YXVsdUJ5SmJnYTh5VDZHTHhabVFlSjJhRkh6dTAvdDV6djFJUmFB?=
 =?utf-8?B?ekw4UUdoTTVJUEJNR1lFUk0ySER1aTV3S1llODdlMlI2am1CMVVmbFUrQ0p3?=
 =?utf-8?B?QTZqNUlkMXhzaFN0UHA5dDdlQ3lXSUJyZk1KekJnM3gxYWQzelF6SW56M0hp?=
 =?utf-8?B?aTlvb1FOUFA0VXExWjZwc2tlYmRsanJBWjh0SDRSMXZFTlZhVHpHcHBhbDhG?=
 =?utf-8?B?dndlYi9peWU0QVVMTmtURHVUSU9pY0dnQUF4ekZyY0NTZnFIV09ib281bkJy?=
 =?utf-8?B?MmhZbUhnbjV4VklOODM0QkJ0OHNSV1FvdCtRVTR6bU1Wc3Y4SWhqcFc4RU5J?=
 =?utf-8?B?aHFuMEV4ZlVpajlMSnBpWnZRekpNa1RlakFxN2RmQS9WQ3p6RW9SVmF2STh0?=
 =?utf-8?B?UlJqelRSU2ZvZTM2bVpZc3RBTUJ4TUZ0Smpxa3JsTXlsRjVlUTVBV2F1Njhw?=
 =?utf-8?B?WkZsTitQSFFHSmgwM2FsbWF4VVUzOWhDYUhUaDBFL2FqeDJxbkRVb3RxbE5r?=
 =?utf-8?B?TGM4ZmYyZHNuR0NYVGNLOEViY3RzQ2hKNklmaGZOcmlKMW9VeXNKcUdQQzdS?=
 =?utf-8?B?TXViaTA5bXZQaEV1aXZ4Z1NDVWlCQWxNVW1XWW04OFl2TkpUOXNWcE5rWHBy?=
 =?utf-8?B?aXM1MUhPeFdDZnZxUjczZ1VnMUxwb0hocnV4ZzdUM2poRDJKbTdlRitBRGhM?=
 =?utf-8?B?NlhSVUc0aklnUWJWcmp4dWpGYlNiWk9tdTE3TmtnMGxZVnJnTHFxZkNyNnJX?=
 =?utf-8?B?Q2JNamFhOW1TS0xnaEF2ZTNSYmNla0FMaHN6bit4SnNDSEN6OEV1WGhoaEhr?=
 =?utf-8?B?anpoYjY5NU8yM2V4YzFwNDh0MHk0TlhzVXNhNUpPRnhxQUpzQ3VxZ011T0JP?=
 =?utf-8?B?RWNaSkI0Uk4zZlY0ZlRNdWFYWnlEWi9OV0pJcXpQeFo3bG9sRCt5Tmc2cWh3?=
 =?utf-8?B?eGhUUW0wd2t3OG1iVFJaczBWa1dlQmp4WXlXRFQ1dXpkYkpjN2NRamp3MWxo?=
 =?utf-8?B?M05RTmJSNXBWMU9GMlhhaTNXbWovcTlDTVhVbTdiVnhNUUo0YmE3SFRqNllQ?=
 =?utf-8?B?b0g0Y21KZHE0OHN0Y2xPTUtwUlZOK0pYaXpaNHdzc09KQ2czUmczL0tBdXFh?=
 =?utf-8?B?dEFJVUJKY3gvWEhSMFlpQUlaU3diTnJpTTVLRlNiVytYS0N0amFYMGJ1T2Yy?=
 =?utf-8?B?N3orN1U4QWQ1V01SWjNTdTlKV0tOMnJsTGk5Y2RLSHNtemdOaXFwYzJPT3hv?=
 =?utf-8?B?cE5Fb25vWmliTWR2aGdTT2pVKzY2RzhPdmRZRnlEaXl0bFdTaU9LS1pubENX?=
 =?utf-8?B?Yml2R3MrTE9MaHNoLzRGaDcvM3kxb1VFTnNOUGttSmc0aGdnaU00cDdTQlNh?=
 =?utf-8?B?OVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	rT94qg/V4y4i+VBwr8h9XjKKXXRnA4EjcumTFZ2fYFm4dT81TpQIKkDICbm3bARG6QtQrboNl9XojAkY8VjvKGnNfj56A8jH8mB0oKje0/la5AEON5JunLhMHqwV/VYqbgxOKo/Kww6mi0sXCehj75erywJ0hm3RehKtuuy/fI7/8mMsfwCI263C5dELT0lDAL8pFbA2zbFJneouH1KICwZZKqm2onm/XCyjhGLc+ixTnNnnPz4ki6HzamHmDscVVUoYsR+AxvLRzO0ZBqrOwpgbxJYhEWN4LXaJd2i3/uW7IyjCXVn8vf+kcYvBaBH5803y7x99QZh9FOZT0BKLvCUD9eGXg8Tt1v2ioFcYi/aqvpmqGc5FrY4d+jqO4jUobb93p9WH7fN+Nz9gqbQnAgm8A4REfRa0yROuvSQII2GEUUzQBjcpxeyKjj1WihSq3J8/Ynb+eG4AmUNmVcnY+2eojxKDlKy09jLzCerQoatr/sBts3VmergUm0cXcLm4+6gOqc4OBxfAmu7jDRq5nVbaynafwr0OsRnGFIj93G0xXuCeEmzqKLT383iR4SfFZvU00rTRCkQTdcdRf4wi9cS6CFqxzogFa2GAQlUQ6rQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4c5d85a-64c2-402d-dd61-08dc9507d393
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5876.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 11:13:22.9409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FGiZcCesw8ipjLuRywsVMaS2S1xxrdV4PyUbq3D1AqdYTRRyvgcsKvuDBG+kOW3PRfBF33A1FykPLztahOS9srZzT6IfrYQhm7OAv9uLPo0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4840
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_06,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406250082
X-Proofpoint-GUID: On_jej05VRE-q5OjPDyZKi6PGQjtxxfF
X-Proofpoint-ORIG-GUID: On_jej05VRE-q5OjPDyZKi6PGQjtxxfF

On 25/06/2024 04:38, Tian, Kevin wrote:
>> From: Joao Martins <joao.m.martins@oracle.com>
>> Sent: Saturday, June 22, 2024 2:43 AM
>>
>> Link: https://lore.kernel.org/linux-iommu/6b90f949-48da-4cb3-ad9a-
>> ed54f1351a9a@oracle.com/
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> 
> missed a fixed tag?

Technically it is:

Fixes: 2780025e01e2 ("iommufd/iova_bitmap: Handle recording beyond the mapped
pages")

Though I deliberately didn't add it, because we need the patch afterwards to be
fully fixed in iova_bitmap_for_each() callers. Not quite sure what to do in
these cases
