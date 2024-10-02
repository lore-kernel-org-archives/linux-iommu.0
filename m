Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1A51D0F73
	for <iommu@lists.linux.dev>; Wed,  2 Oct 2024 17:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727890003; cv=fail; b=FpQeOmjSdFo7QYdJvgsw2Mopz2D+spDhPEAHC6sprG4HygB5YjgOAgw4P7Afk3gec1S1pZnR3ZjISm5zAsos+sVo3cZlp1Tcw3io0k7QfqXWjxrjgvS/y/X9Y90/IvqPGOB4eD91hWHvB4JSpFpPSB/EGBdZoAOI5wpWH+wh6o8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727890003; c=relaxed/simple;
	bh=6jUr6dx9GXfBrohuoDe6E9a11GiSSDvnyRqubqAzOss=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ADm2CfMjT60U4xxcIDX5qA1cmE49JiLhCYkdaqZjdl2bN2lGUR1DRGIb0TeDAdcZRKTlfiuJiIdjbU/b+xYQej5gj27nIrOMvRq2/4kigM/+Udo31kwQW6yL8euL3YOC4hJP/KcYlCe9dDB1YHIa+XQdQVRjrJdsTcneP4ljqNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CkJznW6b; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yryvGrZ3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CkJznW6b";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yryvGrZ3"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492GMZJQ030643;
	Wed, 2 Oct 2024 17:26:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=l1uemb/oKXXinXybfRvDNkOpKYNr7zLee+IvuUa9WHk=; b=
	CkJznW6bOathdY4i8hoBag5gHFwiUIU26A8VsWuFpV14GBM5JUTOmHR40XpIzqu9
	T+8aiTytap+f0d5D9GrU0mwPqW0rspy5e9Zp9IvXvz2c5aSABcR5v62ZpZrLElUn
	vi4MZnbu/dguA9EacT829+bKaqzNQ0iMDZoVGvuba0ZAZCzqLKcxwi03SVbiZDc9
	mn5712mFNF5mqT+vGogNImgJXxvzgIy+qJoGO75742bcdrpipqWD4kUW+SzDsQPx
	iZcbfrm9wJEyuhdB2Cwf77TtgUENDVk9+eEzcR+j9tkKx0Nni5RPWY8qhY/zTF+B
	7CRT6p5EsltUiTChllmVzw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x87da88c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 17:26:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 492GgAxd028478;
	Wed, 2 Oct 2024 17:26:38 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x889ck1n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 17:26:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cyp+kB1QPxQWKYMRMyM+fSWqxMCNat/XON1uJ4aIMGNcr7gbRdmMJ43NcSSl01OkfOBqHa216eWmWZU1MZsPcH9oK6BiW7hSFfj1I55ZK24MgIdfEDwlgpkmIJRp28V4et/6V9GnUQI+xarlR5pqXtcs+Bjiekw4mj+af186Q1g2Pt+2ruD/V1iZBcBBlrEUvVSroZaEkDhqNeg3vtXkbpDr4jffGua7E5DpOU9BBdDYuzUWLmLHR+rmmf6Muo5XAMHEMYCrap4L+MRoJS60TLIiiyJo4njintFo1g+CwPPuvmPF8gLNQwakXhyO7IWyyTFf2R8ne6/pos5Ea0JMgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1uemb/oKXXinXybfRvDNkOpKYNr7zLee+IvuUa9WHk=;
 b=s3GO+htILbEaDuDjVJuepfJOfR3djgIVX8QmgiU7LsLndUTe51wkTN+Pzp1Cd8N4TjjZ6tAA28QGSlM00nSiAtCRgEh9d7ll7djKCPIvrzVBJ1lNqSzRLrtjyl/poniP3XhKEbhnnNdCNZl+JpwGII32Q2uuh6gX+tecjshaciDYfsRwCYHgCpRwbJRIryCnoyE51SBbr1mD7bEOhcYFECWOkmpIT4ErWM1xd/cj/k6vgIfFpbfE1ivgPRaVutIXhIWwJIhAw8egHwl+t+ar7x+X0q87xUpaJg/Eonkrhx2B04aiGxyl79LLDLA8dlaqKtqbHcD6a0danjjlBW7TUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1uemb/oKXXinXybfRvDNkOpKYNr7zLee+IvuUa9WHk=;
 b=yryvGrZ3TFb0CAiFkt8VqFhqfb6YPgvUIcz7rB6eU8PmzIMTD9OsChsMoglQAcIn8eKcC5ywnC6wlV1ph+b5ht924EIe4/thZ2CCpxgcBOu7Y93lvly79Qsh+Sb08OmqtAEtuqVMfTTa2/RgsfEIKO+iFiXamN7WenjmvoG7EIw=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by IA1PR10MB6712.namprd10.prod.outlook.com (2603:10b6:208:42f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 17:26:34 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 17:26:34 +0000
Message-ID: <a8005da1-6f89-4934-a010-73867b596239@oracle.com>
Date: Wed, 2 Oct 2024 13:26:32 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 8/9] iommufd: optimize file mapping
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>
References: <1727190338-385692-1-git-send-email-steven.sistare@oracle.com>
 <1727190338-385692-9-git-send-email-steven.sistare@oracle.com>
 <20241001210356.GO1365916@nvidia.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241001210356.GO1365916@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0425.namprd03.prod.outlook.com
 (2603:10b6:408:113::10) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|IA1PR10MB6712:EE_
X-MS-Office365-Filtering-Correlation-Id: 99df8089-11cd-4665-2882-08dce3075cf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vk5jWFZudGdYQ0Y4QmR3S28wa3NhaVJ6Nzh6RzFGcld5YnBua1RKY1hpdWE0?=
 =?utf-8?B?VDhBSk1DcVd6SkRkTFZ4SkROVDZxa21ITmVDSktNQXQwZWVpNHN3L2NGZVVl?=
 =?utf-8?B?SGRDd1k1L1lST1hYQ1F2cDZaNHVGWGVYaGpKdWNLTXBTNVBBQTI0dUJENllG?=
 =?utf-8?B?eDBXRGtPT1Zrb3ltanV3NlNyUURtVUM4K0xwN1N0ZlF0NFZJZlNEaHU0U1lM?=
 =?utf-8?B?b2xlZ1ZLZ28vdWFpOUlGcG5ScURkNlYvRExsaGl6cjlkUDJkZitKVUR1S1Bk?=
 =?utf-8?B?WlVYY0lqd0pXbk01SStSNHpFUHdVeGRqdXZtNHlsdUNMTFVyYTQrOHA1VlFL?=
 =?utf-8?B?M1ZKRXdOdHNlQTVXVUlGNENJVGNyOTBBQUVNaDRQQ0loQ1hUS1VHcHBKb1Iz?=
 =?utf-8?B?ZXFjeEVWRlV6WEZ2dmplKzRsV3NEV09HelZ2ZkdhMkovRzRsZ1V2ZDFkbHZP?=
 =?utf-8?B?NDdQcjkwNzUyRUh0Sy9YVkJoM05kUUl0bWpFQ0hjbXFjKzhqb1ZpRk5xNTFq?=
 =?utf-8?B?TmUzRC9pR3YyU1FqYzVXQnlQSHBJMTVZOThPOHcwOFhJNFNDT2xuOE5ML3dz?=
 =?utf-8?B?bUlrRjdoTk44M1IvcmtsR2k0dDkxM09NaFJ0ZkJ5Z3BKMWF5QWtWN0lQVks3?=
 =?utf-8?B?enhNY0R0VnZvTmdmaTJNbmdWY1doemVvRCtrb1pNak5lOWQ3VnFYTC9iSjdJ?=
 =?utf-8?B?WnlKKzFRYVRZL28wK1RXdERaSlgybC8rd09BQ3d0MjFYczJDZkk4N05xRFEx?=
 =?utf-8?B?WWZ3NTMwaXNsMXZlWFV1V0ZzZXdwaUNtQ09JMi9ydTRlNDVFcS9WVC9Pdkhh?=
 =?utf-8?B?ZXhQVmZ1MmlKYnRTWmpWOEdEMWNjRXdzU1lJbFpTTTk2UzdPb0JMcEJaSVdS?=
 =?utf-8?B?ME1qaG55Q2x3bkJKQy9tRkxtNngzdTRsQ29wVkxwL3Jxb1MrYzFhMlpERGl0?=
 =?utf-8?B?cDBOcDJCU3RGUVgwTmx2amxqaExnbEVxTGFuak51aHYvdXVrdVI2QkJlWE9J?=
 =?utf-8?B?dTRXL0MyZDFvTlhiQXpmVGRaWlBTa3hHUzhuRUdRbGlJV3RrVGxtRUpnejZh?=
 =?utf-8?B?L2tBc3BDc2xYQjFocHpRdmMveGVMbE9iVy9tQWlsZk9lU0x4ZFc3M1RSRnd3?=
 =?utf-8?B?QmV0cVExcWF5TmYwNkY4ZUo4czU3NW5mcFFtU2VnNXVDU2UzcDM4RUhEd3JL?=
 =?utf-8?B?T3lUYmg2bmdWcHZ6WUVseW5JaUNtOFlhSk0vVGFmRDM3dUtid2o4dE10dFpy?=
 =?utf-8?B?SWp2RGZjWTc4c1dOYjF0RzhjOVBnUlFyNWpiQ3BDWkZ6Q0I0Tkp4eUFxN2c1?=
 =?utf-8?B?R0pwVm5WOURJNW1VZ1BxZXlXQ0EzOStPbHRpdmtmMWw5emFCRTBsV1NON3Nj?=
 =?utf-8?B?L3JVZlh2ZEZObHc4UHVBaVE4aUd6Y0NWY05vMC9yallVQkZKYXI5WXZOclBL?=
 =?utf-8?B?Ukxqa1d2UEErZEE5bGJEeDVkTVhlQkh1dmUrOVFtbUlPWXF2MmVYdkhjaXRB?=
 =?utf-8?B?MlZZVy9aZDlqc28yb1ZERmdOYW1FRGlGd3BWZEVYWitwbDgydnZKUWFQZEdS?=
 =?utf-8?B?MHNUaEVhNWJ6TXg5eVdXdTZhMUpGUGJzejNBRDlIV0dEaG1vbU12aUdhODZF?=
 =?utf-8?B?R0JtWCt4THQ0MENqVmtJZ2VEeXNzMUhCb3N1N28yZmVMSkhidkJLazN1RE1a?=
 =?utf-8?B?OHp3djhiWDR1eE0xb2JBT3BDVGlxSzE4RDRxSjQxL25hQ2dhL1BvNm1BPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUJtZzRjM0ZHY1ZkRC8xZVhyYnhCRWNPd2V4elhmWGpGNGUrNElQYnJmQldu?=
 =?utf-8?B?ZDhFSFFqR0wzWVBHVERwYlYzeVd4MVFiNlo2QVJheHhUTjVHeXpvTzk5U0Jk?=
 =?utf-8?B?MjZtWGQ2dWZvbmswQ1Q3dDlJMkRFSFVvSWtidHNDMi8wdi9RZWtTaFF4QTRs?=
 =?utf-8?B?Q2Z6eTRjdlpjM1drc0VLTkluTzlweFFqTi9BRkdYV0NjMXEzVnlpY1B3NVph?=
 =?utf-8?B?ZDhINXRLY1VmZjJRZmRHb2p6Q2IvYTdYbDUrTWtSZzJmMzR4UUU0eUZUMGZB?=
 =?utf-8?B?ZVd3ZHRxQ05pV2wvYk9QWklYTHRXSkYvWWdjSCtkZW9DZlJJZUE3MmlPT3Mr?=
 =?utf-8?B?TnE2TnhOTVRvU003YkFLNjRlMHRkdy9uaFJCUEZhQ004amxUQnlhSE0wUFhq?=
 =?utf-8?B?bjNVKzk4RTZWN2M5VWtwUWp2Zk1YcGxaczJnNC92bkN3UUtRUWFibkRNMXIx?=
 =?utf-8?B?NzU4NVpTdjNNVXNTaG15alNUbjlralZYUitFNzhkb1ZjeUdCTEpzZzcxNmhV?=
 =?utf-8?B?cStGRmc4TUQydVhqUmNUa0gyUkcyeitmQVpzRWtianZxcjVRV3I3b0ptd3ZR?=
 =?utf-8?B?dVBQU3NnTHBKNHZnSXlENHd2TlFCWE12Zm5FSVVEa2swdHNMM3hNN29UcHVx?=
 =?utf-8?B?UndpUmZ2L21SYWpnRVd0WTBjZVBZSjdmbEs1WUp3aTlXUEV4cm1nL3gzVzc5?=
 =?utf-8?B?OENKVHZrQUZxTk5RaER0SEo2cFE3aTJyek9TRTFKemQvZ2FKcEhVV1hVaDUv?=
 =?utf-8?B?UVFxMVQzNkdHdHJPckhCZTYxUWJFSFpmdWxvbktjN3ZqbEVrWS91NldXcW42?=
 =?utf-8?B?c3N0NVFRUFdLcWx4VTdNeGYraHBuTXJXWGQ1RFNmOXdkNGtpUXJFYXRhK2RJ?=
 =?utf-8?B?OWV3N2QrUlZFd0I5dmJKak0wNjJjVHFxYzlRam5UNUJaSldQU3Q5WUZVM1Fw?=
 =?utf-8?B?TzdWOUxHSWlCaTFTUEJkanNreU5QR21uV2JCQnNaOENLbmVKc1loajduUEZt?=
 =?utf-8?B?bnZhYUdiV1Z4d3Jkc3ZBRFhPaEZXdnBSREptN3lTZVBac0VBVzNDZDUyQ21D?=
 =?utf-8?B?cis5RXQ5cGIrQkdLYlVYcU9kYWNVOEtWTzc3RlRYcUxMZlB1Q0tJV3h1VEtX?=
 =?utf-8?B?eEdKU01OdzdpLzcxMHVBVjRzaENYTkl5SUVGcStpL2c0ZFAvbTVsek84S1FP?=
 =?utf-8?B?endhbkV2SU1nTTNRSFBhM0NBM2NOYTAwMUdNdFFFTnNjM2Q4bkMxSkFvdzl4?=
 =?utf-8?B?RWtOcDJqYitIc3BCQWFmajQ1Yk52dEkySmVxNnNyZ2cwa05IWmZpcnd4VGV5?=
 =?utf-8?B?MHVDZVhTNm1JWjVGQTR4RWdBamV0Zm1sUWdWQWw1NWN5SUJTSkpPMkdFSmRq?=
 =?utf-8?B?YklMUG9IajRGbVM1a3F1OGRNZ0MzUWg2WXJadkpRbWJ0ZlAzbWdIdWFRRGNE?=
 =?utf-8?B?SzFNdGNvUkVwVTZOdjJhWVZzOEgzTTA2WDZPUGpUTitDaDM1eXdQZDV1U0pP?=
 =?utf-8?B?WStxWUU4bmdjTllVdk5FdUlhWFJYZ2ZScVBDRmp4UzFjYUxBRFhNVWlYalcr?=
 =?utf-8?B?UDdPY0xDYnRoYnBrclVLb3Y4K1BPSnRHcmcxSGdmN1dVQXd0RVdZTWpwbXJY?=
 =?utf-8?B?dmxoMURDTnl4MVIzWlkxSFFhQ3JlUHh5cXFmL2ZMVXU0RWllNmJwVFNnd1FF?=
 =?utf-8?B?c1BWRkZsREUwdUEraDhEc0tpbmJOQVlVcDVPbUR5YVFiMFJmL0FtTE5JeWpN?=
 =?utf-8?B?RktTb0VLVm9nbDRIbXNPc0MxMUFZR3ZuTkNIV0ZnWmhZY2RudHI5dmlOWUhq?=
 =?utf-8?B?Z1NFTTY5dzRTZWRGclBSKzhGM29POE90WlhrUnZ1UlJCd2EyMmlZNWkwQisw?=
 =?utf-8?B?RU5WbHlCVWNydE1XL1ZqZDhaTXJMRCt5eno4N04rM3BLdit1eDJ4N1l1RmJn?=
 =?utf-8?B?K0VKSjY4c2xZY1VGR3FCa1JVWmN1VENzeEpUYzBvdDRqaWEycEpBUHo4TkZa?=
 =?utf-8?B?NEIwUnNKdXgyQmZMVkhrZ3FEdVFDRWhrTDhhQUczbXYrVkl2VHc1RjI0WFZP?=
 =?utf-8?B?S1kycDd3c2R6WEo1MW1kNnlYRXh6ZXN5ZGZuSkw3NUdtUCtHRWprNFBaeFpM?=
 =?utf-8?B?YTNlTyt1MTkvZ3JhOGxZamdBUm53dC9YVW9FSWZNQzRIeHZXVU05Z3d4MW1n?=
 =?utf-8?B?MXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KS0H4pRqL9eTulHFaPOQeFf4xiVn5ek1YPGymLG3TYfrGPGUmrH9Bj0ddmURpjybE0mT2dTmQxYQdhsK8ysdL4PwEa3OwW4t2C00YTW4mz/cGLF+s5Q6qICgzjPWmtLza/LJHkd1hLUKMuQSo7yPfPpt1whmxyeqqoOw1YJ/IGJeSgqY7nvTp1qhXr366Ei1+CAkZxAAQvrx5x9vk5AlUdkSQEs2ssVNbcjUTJx6pSHA9+zHcAFdIuUxY2fvTeddH2yUAku2r4G4JBPVjKXnXQyKKxu971YmIrX2NiLc3Y0w7IUShEnZ2XJ2Ivi1hKVMq7B8HihttdEQacoT80n+yL/eTXMLiN1pnA9D2BPCsEAP4Pha4rYLpluMCwPRMPmbcQg3s/Y+Bm7LHPE2vMPqhmWWdJjiGUomN5CydYYeVCTPeiwZy7iXSAR4LIVX1TUErOGBnE2BsPvSYFVwUyxRMAZ8raoftCG6oM5HeDRIxKNlIlZUdcKSDIua6/JKQ3xCWpJSLWKuJyxscNrMFcFsgtW1398vIuhLoH6izk7XKPBX9VuQR7sPWOpVkeRHaWpMxHLDc9BZwi2VgfT9+oujtPG4BDYsG6nGY98ylZAPqks=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99df8089-11cd-4665-2882-08dce3075cf9
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 17:26:34.5137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: joDTJxK2Ot8ZOA72uVsU+vsqOKlbr/uEAiLQ8rR6PbuqSbzYJbZaMwDHvq/dtrE261ESLGa0f/FZGAvdmBaWnABxJXj3aZh36QWtwm57jTQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6712
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_17,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410020125
X-Proofpoint-GUID: T3PLBukjHmBUNb-ODrH2VRuwc47eFmTF
X-Proofpoint-ORIG-GUID: T3PLBukjHmBUNb-ODrH2VRuwc47eFmTF

On 10/1/2024 5:03 PM, Jason Gunthorpe wrote:
> On Tue, Sep 24, 2024 at 08:05:37AM -0700, Steve Sistare wrote:
>> @@ -622,6 +630,67 @@ static void batch_from_pages(struct pfn_batch *batch, struct page **pages,
>>   			break;
>>   }
>>   
>> +static void batch_from_folios(struct pfn_batch *batch, struct folio **folios,
>> +			      unsigned long offset, unsigned long npages)
>> +{
>> +	unsigned long nr, pfn, i = 0;
>> +	struct folio *folio;
>> +
>> +	while (npages) {
>> +		folio = folios[i++];
>> +		nr = folio_nr_pages(folio) - offset;
>> +		nr = min_t(unsigned long, nr, npages);
>> +		pfn = page_to_pfn(folio_page(folio, offset));
>> +		batch_add_pfn_num(batch, pfn, nr);
> 
> I think we technically need to cap nr here as well?

Do you mean cap nr at max-unsigned-int and loop over the folio?

>> +		offset = 0;
>> +		npages -= nr;
>> +	}
>> +}
>> +
>> +/*
>> + * Return the folio containing the page which is @start_index pages beyond
>> + * page number @offset in folios[0].  Return the index of that page in
>> + * @offset_out.
>> + */
>> +static struct folio **folios_start(struct folio **folios, unsigned long offset,
>> +				   unsigned long start_index,
>> +				   unsigned long *offset_out)
>> +{
>> +	unsigned long nr = folio_nr_pages(*folios);
>> +
>> +	while (offset + start_index > nr) {
>> +		start_index -= (nr - offset);
>> +		offset = 0;
>> +		folios++;
>> +		nr = folio_nr_pages(*folios);
>> +	}
>> +
>> +	*offset_out = offset + start_index;
>> +	return folios;
>> +}
> 
> Why does this exist? I would expect you'd call memfd_pin_folios with
> the correct offset so that the first folio was the right folio, this
> is how the pin_user_pages path works?

We need folios_start for the case where the 'if' branch below is not taken,
so the folio was pinned by a previous call to pfn_reader_fill_span,
so the requested start_index for the current call does not necessarily
fall in the first folio of user->ufolios.

pfn_reader_fill_span()
     if (start_index >= pfns->user.upages_end)
         rc = pfn_reader_user_pin(&pfns->user, pfns->pages, start_index,

    ...
    folios = folios_start(user->ufolios, user->ufolios_offset,
                          start_index, &offset);
    batch_from_folios(&pfns->batch, folios, offset, npages);

>> +static void folios_unpin_partial(struct folio **folios, unsigned long offset,
>> +				 unsigned long npages)
>> +{
>> +	unsigned long nr, j, i = 0;
>> +	struct folio *folio;
>> +
>> +	while (npages) {
>> +		folio = folios[i++];
>> +		nr = folio_nr_pages(folio);
>> +		if (offset == 0 && nr < npages) {
>> +			unpin_folio(folio);
>> +		} else {
>> +			nr = min_t(unsigned long, npages, nr - offset);
>> +			for (j = 0; j < nr; j++)
>> +				unpin_user_page(folio_page(folio, offset + j));
> 
> Don't loop, we have unpin_user_pages() for this

Cannot call it, I do not have a pages[] array in hand.

- Steve
