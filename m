Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400D61CBEBC
	for <iommu@lists.linux.dev>; Mon, 21 Oct 2024 17:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729531754; cv=fail; b=mEQCCKl2psJcg0I94LdYjJYmkgp6LFNCa9UbuIItadlM25dJyFiFtRbOYwnDfriL1kQKwOmq2Hxt7Bu68nm7q/knl7HuzpXTCv6tYqkm2NE2wgxo/IplICWwPFCN1jIDOHW372nkfbc/SpDLbPurhu0xLYcholjUdSqGfF5lLfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729531754; c=relaxed/simple;
	bh=iFEebYOmgR3OsnVOKSICVdtZbHnReA/WlgEpWDf8Mow=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oyuUkqtE5rt83T4P3XTnBsiP65x4PeHC9a9jvF54MReTWkFMn7mfU3dA4A6YMrtTq1DimQ2nMO/RVa0kFRR33H2phTPax6TWnpMdUt/eAQ9OEIAbb3LhQI0XAVsJeJ+Uc1jZA8O8jBrkzfPL+Qkuw+sleAbVhWaLLBHfdHtNs8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W24AsZDN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vSoI1dcO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W24AsZDN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vSoI1dcO"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49LHQYJn014418;
	Mon, 21 Oct 2024 17:29:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=XE402FCEUZnk1rkiCbz7tDnbSKhDjK3b6vousqydhA0=; b=
	W24AsZDNQudLMkCA4o+hODr3vTbXVBRuia8lc0Fcz5AMpTWVzf56KhVSGWD9Zy3a
	M04XppuWKp6TKsEWlRsNk1WeeM+Wofn8CKUfAmgB2UligU56cpbV9UhWcJmMKXLA
	SEbW8MEo3feHo4MBHctpU72YX89AB+hvF9UFo1yV6pg7Lw6EXbV9CYCOZAgbQP+8
	mpX4Bk7D3uX7q0DlQFxzR31RVtcEiJvfV7UrGY5v35/mb4UQm2tQhgVsNIhADYP9
	H5TbYcttstxHkurVvxps9iizXW1lw2LHhTMD8JpLm7kxpPzEi/LjfBxDH8G9X/cE
	uSgGKClMjoo5m+VxuB7I+w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ckkqu0nv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 17:29:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49LH12sT011999;
	Mon, 21 Oct 2024 17:29:09 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2040.outbound.protection.outlook.com [104.47.58.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42c376d9px-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 17:29:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rTN3wviJ90oUuofohMkbvvU9VF6SewEgPQBxi91dl0ti36dFsZoPQwgBE9dn78/KFNJXKCS8Pa+J4+i01jD762CCNq7NvpwTjTpU9u0fU4UfaSA271sYVvnlPLS3whfc/7lz2mI/MmxjRRHTFu17Yw0pqd85VQOneH9eHF9cy9/MWcrx5xV64CQrMATq99PlQhw5u9WhA18kblQwQFP9rlS5VC1OGj2hYmO35xMruhSlnA+OZ3VV4PH0HLoIIvxJB62ZqXiVsrwyVFks2LXeAwRDjddwpZ7n0WXWu4Ggpqg7o1EIzygp55nf3j1sS5R833v1Dnv+2ymsBCu0dA3jDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XE402FCEUZnk1rkiCbz7tDnbSKhDjK3b6vousqydhA0=;
 b=lDlaJk1i4L9Y+n6gvjxak3DnawwQiNrnnfnADKlOuqrpZRV8akx8HDMVOyGYknoHgX2vbXKYUwT6fCH5Nki2pvPCqBktBXdsauRoJzY7hPlAKw2gDR58H36Ye3bm8f+FTOlnf0nRtPOpzL0hFzvRoOKxGqCXHas91wdhWIJav4eQWfAKFpevu1QBN6rNenASE/S6duWyuK55ixdIw2EHUvKcjvM4pRdRcy2jmuohqRyHeORYwnaHh927a+Wac4e6pkIE5MCLk6AsmkBwXFnK04QCzJXRWEfWG5gNRIHxbmsj/RUbI1nE+XyFM1i/Wg9WLmZs0c8XVb9VSkrqoF0o7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XE402FCEUZnk1rkiCbz7tDnbSKhDjK3b6vousqydhA0=;
 b=vSoI1dcO9Huk+icXxk9rzDo6Rlhwj0zx8yQZw2arUBW43/fGIMYtRU+mrBRI8qFNO64+dGI6Whye6NQUTWdWNiPj5MF9wnLsFP0BiX/eYG8HaFn/bKfKyWIV1MeGHpdBc8679+OqTFcBigenGe7069c2GJ63/+XGZ1zdX8hPExw=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH0PR10MB5848.namprd10.prod.outlook.com (2603:10b6:510:149::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 17:29:06 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 17:29:06 +0000
Message-ID: <605725fd-d5a7-479c-917c-edaf685e31da@oracle.com>
Date: Mon, 21 Oct 2024 13:29:03 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 8/9] iommufd: optimize file mapping
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>
References: <c4574487-346a-427e-a97d-6e1ee366ed1a@oracle.com>
 <20241018001046.GF3559746@nvidia.com>
 <279c7e80-1d72-407e-bfb8-d286760a5e11@oracle.com>
 <20241018160430.GJ3559746@nvidia.com>
 <dc59dc36-027f-42c1-971a-8218c658c5a0@oracle.com>
 <20241018175951.GK3559746@nvidia.com>
 <55027ff1-05cb-4ce9-adad-8dca586a26ac@oracle.com>
 <20241018231011.GL3559746@nvidia.com>
 <561a1712-8613-4f88-ae60-7f12a4b7c244@oracle.com>
 <9c0f4c03-6373-4263-b389-262f8018ad02@oracle.com>
 <20241021161150.GB13034@nvidia.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241021161150.GB13034@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR0102CA0053.prod.exchangelabs.com
 (2603:10b6:208:25::30) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH0PR10MB5848:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b56d28a-afe1-49e9-5204-08dcf1f5dd57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?clJUWkpQVitaN3ViVW4rc1dPVGJvUUViaWhUcnU2UjF5d1NLVDJja2NuRXRl?=
 =?utf-8?B?QmxtTEFxUHhpUWZuYmJaUnhib2E5Q2VZZ0QxUXlEMTErRThRV01FSmhtVWha?=
 =?utf-8?B?QXAyMnlaNG41WjNXV3NwZHVkTXZ3S3RHbTVCaW9vNTB3c3lSU1o3b1lNbklq?=
 =?utf-8?B?N0lWNVIvemxicDFJZDM1R0xHc2k3UmZNVWE0b0xBT3F0dDN6R01OM2haYzA2?=
 =?utf-8?B?Yks4MWozS2xMQzdGaWxCYUlWRkZaZUUrZVpJWTVBQnJLblZlQ1VmNGVkVTVK?=
 =?utf-8?B?alpXYmdWMkE0YVArN2FUOXRWRWQ5YkFPVGVwQXB6bTh6UUpMd05VWUNHaE0z?=
 =?utf-8?B?UGNiL3llTTkxVWt0R3EvWUpCTmRlaWNTbVN0eFFOSFJkWmtlL0h3ZDNJL2sy?=
 =?utf-8?B?WXFKTUtsU01BLzRHN2FZOS81OVJGMVMxVERSeFByTTJmdFBtTWZjOEEwTjM0?=
 =?utf-8?B?VU9IWUloZW5YZGhwdTZCeGtsK3hLK0ZyazZaSWR6ZGR0TTI0V0p2UVBjK3gv?=
 =?utf-8?B?ZTM3aERoaVBsZ0lTclBRamUzNXlkTEpPTzQzK3Z4UjhmRFVZTUdpQ3RwNjdE?=
 =?utf-8?B?YkZ0M1VZQy9UNGtUeTBqdlViVWJuNWVxUjlYVm5VajBlSGJlUU5PNkJkaGZQ?=
 =?utf-8?B?dzluMHFIc1pxN05LN0wvNTB3emoyZ1BNSmhnMmtPVkZ2S3Q0M1lyeXNiRHVD?=
 =?utf-8?B?ektLUUhLN3k3NGpOTXJYc21iRzkvMUVPZnloUHpYK0M3RkxpOHpaTmpWZFdV?=
 =?utf-8?B?MjZQNDN6K1pFTC9oUTd2eUVrVkU5TExtUkYvQ1pUQlBaMnVWUVJQcy9lRVFO?=
 =?utf-8?B?dld2MVZUYTR0NUN1cDZiL3ZOR1hKWGR5VVVBMDJJUFo1K1lGWW00cFlFUEgz?=
 =?utf-8?B?bDNHZk91ZUF5WU9tRFB1OEVVSnBxQzhFMVlneHdWYzJwOWxKRkRTVVFMcXZj?=
 =?utf-8?B?Qk1JYmYwSjhpS1NGbWQxM3VSK0NNQ0EwdkFQWk0yeXRMd1FjUlZHRzBJOHcy?=
 =?utf-8?B?b2w0Ymc4TzhVZFJ1TGhCRmdmZERudzI3Y1pZWkJQVUhDQ3JUOTZkY1VnT29j?=
 =?utf-8?B?N0tvNFRaVTBDb201ZkRFbG5LNVhUQ1RycmZadXRubnpRbDgxS0ptU2hoaVp5?=
 =?utf-8?B?bWdpaysxU1BvZTJ4Sy9uS2JQQ0xvSHVkSWN1OEU0VXIxMkloWEFPUmRxMVBn?=
 =?utf-8?B?Vk8wdUllcERVaFduZjZ4eHU5RE9ka3poN01HV2V2cjAwVCtFVU5TMkFmNHFU?=
 =?utf-8?B?cWtaeDRPODhZN09XWVpValQrNEtaOGFFY1FnaDNlbHZGZUp5OU1xSGR4OTRz?=
 =?utf-8?B?NDVzc05mZXFzWFpqMmdESWMzaDVyWHhpYmlmazNjdkQ0UzhpOXZsMXJkTlR4?=
 =?utf-8?B?ZUxKWFNVcWJCY2NxSGwxcWZ6OXdLNGd1TVR3NmJCdFhDVDU2aFZjOHJYc1JG?=
 =?utf-8?B?MWdFTnBSYmRXVHNuTmFXSVJlWHlqSVhHalg3UFJPWk9VTk16OEd4QXRYS1VK?=
 =?utf-8?B?OGdUd2lHYjJMOGd6cGVRM3Bzemp1YWYza0wvTGFQUzNHOXZFYUVPZWM2RHRX?=
 =?utf-8?B?cDh3bUJ3bEV0T1ZWK1A3UjhMcFREVUpiWG1jQWNtczl0cUpoRytLUGZCWUZZ?=
 =?utf-8?B?Mzg2bStJcmlyeXNlbGc3VmRvb1BIUmd5UnJvWlNaR0FjSHNMaWVDeXhrYitL?=
 =?utf-8?B?YlY4S3B0RXR0NlpZaXNzSExNVmFBbHRVUWJvL3AvVzh1QzMxa1FIZW5YNW16?=
 =?utf-8?Q?KcHMvJa+PDFlMI9Mpg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SzE5ZmZVSUdvMDMzSUFlNG9QN00rOXBiaG5CVDRwQWlYUEg4UFhkaUVYVkxt?=
 =?utf-8?B?MlBhcVAyZ1JkbW9ZOTJLZWtrZ3djTUZrMjBEaG1qOHBYYUc2TkYxc1hRcFk3?=
 =?utf-8?B?NjlPdk1PRVBqb3lzQnl6bHYvSVRXT01uT0dmYmlDdWkzNGptVU5lMm1pbGdk?=
 =?utf-8?B?WHQwR01XNWtwL3h1NXQrcjZRKzdnL1VNb0tybnQ3dEtpZUNudGswNGZ0S0JS?=
 =?utf-8?B?ekFYWjFPdDdwd0dna0duTUNZUVVaM0NZdENnUEd4K2ZrMC9MbjQrdEtIaDFu?=
 =?utf-8?B?eHJZR3hpTERVWHorcy9kcEtHeHZGcCtTa0dBVXE1M0xyN0JYQkxtVTFXbkJ1?=
 =?utf-8?B?LzVYOUJYeHU4elpSRjhteUhFVzBRNU85VG9za2w0ZzZQcW9WRFlqT3pXSG9t?=
 =?utf-8?B?VXFMVDRnMkNVOWFZT2dmMC9Edkd4YUc1V25CbmhUSWlLaXpSazNqSHhONGYv?=
 =?utf-8?B?eEhtN3JyOHJCbldGVG53NG1icUM0aWlyUFNYZGlzZ0s3TEhCOG9USllHM0ZG?=
 =?utf-8?B?MjFyN2F2R0NHTyt5a0hnNk9XTUlkRGpFNk8zQm9ua1g4QUVTdXFQclNxM24y?=
 =?utf-8?B?ZXNITDhPNXI3ZFZRRHlGaGM5VVJtcENKNkhOUXNwTnRlYXhWaFZRS2FabmFW?=
 =?utf-8?B?MXF5UUQzNUt3Vy8yZ0JSNGp6T2pjeWt1NkFtWHhYaWNJMEJvTWthZ2ZjUWxG?=
 =?utf-8?B?NWg3VUxSWXlrbGc5ZWtJazd3RG56KzNvNDMzbnZjMmY1U0lIbGlER2EzOU1Z?=
 =?utf-8?B?R0ZYRGtTRHZjQTFVcjhrNHRpNW5XYmZxOFdQcHZmY3FEbHJFY3ZDdmY4SVNS?=
 =?utf-8?B?RUpqWVFqeCtlWWo0eU9scklGTWhPM21TSFduSG1jbFdINTkyZlJYSXlDZnJ0?=
 =?utf-8?B?V0d0QjY4Y0QxeHpOQWZqRFhMOXNROHlhOHU1RUZweTEwbVBUQkFydVhLWVFl?=
 =?utf-8?B?RVAyRlBBWUhENmV2dGIyVFNOYTNqQ0ZGdHhkRG5ZRnRBZHZzSVJkbkc0YzdL?=
 =?utf-8?B?MmpubkU5T2lVQlZtRld4Vm52UVlnU2RGdit6R0c5a3RJUFowb0kyaU1zY1Vs?=
 =?utf-8?B?Z3hmQk0zKzlRdmZYdlU2cTRpNGNHWkZFWW90UFdxUTYxcjlWVnRrSTdWQ0pC?=
 =?utf-8?B?bTF1Q2gzWUpBNlFsbC81NHNhbXh2WWtOcms2UG52UW9Ja3VBNjZuTHZ3Yi80?=
 =?utf-8?B?SDVjZlMyQ0dVOTVmbUpGTjNqVUk1amZQdWNsSUlocERHTjdaWUhzUGsxZkU1?=
 =?utf-8?B?Qjg1UHRtR3hwRnRVNnFnSU92ODlSZFlmS0E2c1JRVHJjcXZWU1lBbXJTMnd5?=
 =?utf-8?B?aktmQjJSS0Z3WWdReHE1cHdDcnJxaytlYU9abnJVOEZ0blpsRElEdDgzS3I0?=
 =?utf-8?B?MGtKN3oxSEkyNnhITytzNDdXQ2VyWkFZSjhsT0daWmZkallFSzJTcWtPZWpV?=
 =?utf-8?B?d0NIVlZXZGptSUlHZFFvcVVCMTM3UzN0ZWFRTi9sczRzK3lYVVBwZjh1YXFp?=
 =?utf-8?B?VlVYdG9mbUY4aWRxTVY3dllQbkpaV0EybnpQOHkreTBWZS9TN3BDZnRlQmpD?=
 =?utf-8?B?U3BLY21ncEFxSlJVdFJBK0lYMDdNWHZ2Y3EwaUQ1NDJUVE5JTW5FSllBMjV4?=
 =?utf-8?B?Z2t0K09ndDRyaFZ0SzhBaGVzMHBSKy91c29qdi9sV1hYRzVPZHlMcmtYNzN0?=
 =?utf-8?B?SDZKS1dvaWlCS0NDVG12NkNNU0puYmdqeTJzeEUwWDlqZTQ4NzNlZ0xIanBz?=
 =?utf-8?B?SC9STEQ0dVZ0U2xidFdmc3lQQXhxMTRLKytnQmExK05MRWZwK2p4V0NkNEln?=
 =?utf-8?B?MTZpZ1BZdUJkTHlqNnRpVlp6c0tIM2JZcmNHQ2xzeVVqWHpTQWRSU3lNK3lr?=
 =?utf-8?B?RUtpcU8rSjNyTEs4d0NOYUwzS0dtMXJTdlROaXpadG1RY09SdGY5UzFNTVdi?=
 =?utf-8?B?VHE5cFM4ZzdCME84VHl0RkF4SmRobTRYaDJmUnBuY0VMdGdMKysrSUdpRnpW?=
 =?utf-8?B?V2dWZEhmQmIyVXM2cWk1YmdjVkx6YTN3aHpRSHY2Y0x3SkR1Q054S2hQZ1NS?=
 =?utf-8?B?MElWS0tJSitXL0lUM09rMjBicmRmbDk5T3psVVdzUEFRWHBYejJ5bWR5bjBr?=
 =?utf-8?B?S0tFV0NWU3U3V0k4bjRjZVZpeFNRWnVvbXR5RzBoTEJBY2JKa3lXZFFzbm41?=
 =?utf-8?B?bEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lwbAh3y+TMU0+3Ajjo/XiywB4uMoNi6NcnU2fj0Ox0fMsIG0AFSOOtKsv7fEtrv4PhBlBl9AVYEWw0JnMPFk+2UVfJm9MuXKF+N6tMESNmMJBeYeI+GxVPSR41dj1jjEXxOWMLQf0iA8TNL2gsDmZkDfHoKlz6vEMNdTYs4oy3zwckdp5oXRwLd5OtlbX4Onuh1ZPBHRVrRl6xWNI5WWsa3rEdRXigDd60S+Bb/ORfijlCOQJyFo58QZWtKfzzEthMM9+hGActpg1ta3PJKrw0J32jubTySHgiiOrZOyEYZ6FjoOimOtq3Dafiu7v5uDgoccJxK3h+0q1vEy5n/xjDCULNTQujnnYyUSYBGBwXvHIf0YCSkahIjjWa8I//RaARgsz7/4QY4k4NdwwEHB19n+3cihes+fVxPwyCMCOqstDPYyPu7THvta+5wGuD/exQn/WXVu5l4z9b3GpADAe+NcNi7qbDZLhNBbvO92mTEa0ua1gmPjAEZrFOyG5ueCK+8ViiRhiGIk73acBmosjGcb2G/KScQRVhz5G7NWyZIRLcyjiCCI6SFuN3T7FPswQ5ZftwxQlFNnEb0XoMTLrEzHI+t98X6IEjAbZgQ8tWw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b56d28a-afe1-49e9-5204-08dcf1f5dd57
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 17:29:06.4430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5V/+tZVfH3uvRoLf2VBrHOCTpGPjQ2ZgqOtRua9ykmj7BHk4PP+btHv/Lcusg4NZQhECiCeebqzOXshvwStX+85WYifIuv3sEG/tSOm0QWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5848
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-21_16,2024-10-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410210126
X-Proofpoint-GUID: ooXjja4iF1C948fMUHKp0kP26SNwKp_p
X-Proofpoint-ORIG-GUID: ooXjja4iF1C948fMUHKp0kP26SNwKp_p

On 10/21/2024 12:11 PM, Jason Gunthorpe wrote:
> On Mon, Oct 21, 2024 at 10:29:02AM -0400, Steven Sistare wrote:
> 
>> Despite this I can make one further simplification of the V4 code.  In pin_memfd_pages,
>> if !upages, I can skip folio_add_pins and instead call it from batch_from_folios.  This
>> guarantees that in pfn_reader_release_pins, each folio to be released has only 1 pin,
>> so I can call the existing unpin_folios and delete folios_unpin_partial.
> 
> That sounds pretty good, if the loop in the memfd_pin_folios() can
> just be computing npages then that is a reasonable place to come later
> and optimized by changing the mm code.

OK, I'll post a V5 with that change.  Don't bother reviewing V4.

- Steve
