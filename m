Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA57716F0E2
	for <iommu@lists.linux.dev>; Tue, 25 Jun 2024 16:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719334363; cv=fail; b=cjVq+Sz2ZiRxwReRO2b0elDcqPhyQJMwPwib+9cKMMxy1s5zrO2DC18at7R3BcIwJTEx8W1Aw2GNQhWtB1hNHw0RrreesKtexZHsact+l2QiETIvZnrvyt7y/75FUSwb0c4PTfoIjQnLaNGLLWz4mIT5Wdyj93BWhtKa1k9kdFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719334363; c=relaxed/simple;
	bh=A2WVS4AmYh+ugNh2E0IuLw4mnK45AvvESLByY1yEOF0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HI2NiuRTx9lnAFcTwHsx+GeijfWaYT9qTpqwtMgJRyjKTybZETNQzgXEPkUiJFDaeubg7XxmYFq3cWRSj/jpL+6B5JhpZxrpai1TroeBruwURapXihKj2cqFClcd4/0OwFnwRT34TScX3LTOnJJ0RKbUcQXhr82KBRJIYq8Wvfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mRpHpawn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CHtkJxXb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mRpHpawn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CHtkJxXb"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PD3Xc9021049;
	Tue, 25 Jun 2024 16:52:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=yzWX2bUFw9QI1k2GsuD54GpEQELSd75GaLAlLHwWACw=; b=
	mRpHpawnknmtz3ENad/MQ8JmTgFYl6XFV11utzBbXWKUbuFaBvhsjoxnAbZMC//p
	0UdXX8aZl11BwC2qT/vqELt1x/DiV8doNGANxLLtyR/QqmH1QQMAlczLblcv9Tph
	DuAgTD94vEzW9YonQEi4sUA2I6ZlpR7MC2gX0NGVArfaamhegHGoYI8ihV+xeSxV
	YB6F1heoksGhCz7+CWOfL4/1QBqWKImkDYoG9WT36aN+EG2UK9Hb9sdmFEfrcbX1
	60mZ8zeCK8OEeZLartFfDDr+cJnLhZf8qUG139OoRmoGJxSddslyyJKv8l5B+YJN
	WmHELcUm2Nh2D9d1Hsjgew==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywnhb191p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 16:52:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45PGWZK7023390;
	Tue, 25 Jun 2024 16:52:33 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2ec0k6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 16:52:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrPvFWn1YxJOUD9voQ9yw4YGU6roMNsI3N0g/He1ENl47cBc1HlJ2BmlE8lj1Bm/WCeMxu5tsYgWi1g9u8p3nkb7N8iK3MmdjoXMCBOOgp5C+M4nYJGRZB7OG8fTr7AO9wK/bG5dlrPxmtPuKj2UDs2Wpd65Rf68fS2Llfc9ANBCkFSl1ebSILoiCbh/DzJ2dUeAVeKJla0zqp1ly18FCjIAcxElasy6vwvuwXDUzCpzD/ItrhQ9MhRthL+xnJ1/91Os51c3+uroiHNixP9glzeOGKyzZcUOD3L0ysdEctBL3hVOQiNZogxqzm6TanKSo4ltEs5S23JY5OHWbIqn7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzWX2bUFw9QI1k2GsuD54GpEQELSd75GaLAlLHwWACw=;
 b=ax6T0sHLSqoDFwK5dbo8b35g7Mkfk7cX3qnIsqo1vTkoh28JqrOLWNR5JCOW/m71Wh6GFPFqdZ4dhRUt4m9cFD3f2/iC9prNlFV1SdNQSSumCCf0vHhQcKwE1LUuwGTQAm1JpsKv+H8a12Exwm0eUvrElJFRKAIxXmxYNkzS9NVF7eVWVXNGMpB6LK35vLZjiwpWq7CSiSarDhfC68CicFLIRi10Jxjt4MZytSxyeOayhsL1hVQc2Cx56+Qf7XBXNLBgBmun71lIyA9k21QwWNwtb36waKEbKZxmEhqjAkj4yvDWGa9IyIWZ0FXQdKEJt5q6tNuHAIIZ8puaBC5G3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzWX2bUFw9QI1k2GsuD54GpEQELSd75GaLAlLHwWACw=;
 b=CHtkJxXbEddW+Rp1y0KrQhWoa1qRe7jml3y1yis80FaQl7iKH9XRAyFJXV+iINAVv/b/KtNI1I06bjZ15RDilTdo4koLu6WAwWbY2K0djo8Ug5D3HxP/N73SfDLUIueOBe3dahf2iUN6JFdkCjJcbj0TJzP7nl9o6FaSMA6MHlU=
Received: from MW5PR10MB5876.namprd10.prod.outlook.com (2603:10b6:303:190::16)
 by SA3PR10MB7069.namprd10.prod.outlook.com (2603:10b6:806:315::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Tue, 25 Jun
 2024 16:52:31 +0000
Received: from MW5PR10MB5876.namprd10.prod.outlook.com
 ([fe80::4e4b:84a9:89a9:c43a]) by MW5PR10MB5876.namprd10.prod.outlook.com
 ([fe80::4e4b:84a9:89a9:c43a%6]) with mapi id 15.20.7698.020; Tue, 25 Jun 2024
 16:52:31 +0000
Message-ID: <7d8b11de-4dda-4b14-853c-ee3b966d7f8f@oracle.com>
Date: Tue, 25 Jun 2024 17:52:25 +0100
Subject: Re: [PATCH v1 09/10] iommufd/iova_bitmap: Dynamic pinning on
 iova_bitmap_set()
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, Avihai Horon <avihaih@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
References: <20240621184254.45477-1-joao.m.martins@oracle.com>
 <20240621184254.45477-10-joao.m.martins@oracle.com>
 <BN9PR11MB527647553CC48B598BC79C8F8CD52@BN9PR11MB5276.namprd11.prod.outlook.com>
 <8f2ba561-5f57-4abc-be7f-26f33124a60b@oracle.com>
 <20240625122745.GY2494510@nvidia.com>
 <3f4a80a7-9e17-43e4-9bc4-c1ca056f16fd@oracle.com>
 <20240625153101.GB2494510@nvidia.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20240625153101.GB2494510@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0178.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::47) To MW5PR10MB5876.namprd10.prod.outlook.com
 (2603:10b6:303:190::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5876:EE_|SA3PR10MB7069:EE_
X-MS-Office365-Filtering-Correlation-Id: 7911b51b-c4ed-4ac5-e40b-08dc9537340a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|1800799022;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?QWQ2SWJ1TlpFa2c0VVRyckdVY2ZkUzV1dmtHVTluRmJ2MGJ6NEN3S0FSV1hT?=
 =?utf-8?B?aTdpUHJiMzU2OXBEY3A2cnBtT1dsZFpVQ0luOHRRc0IrajJkMUQwWTEzVGVu?=
 =?utf-8?B?eU5Td0NuWXZEZHo0UzJyY2hkTlUvaUdBbGVzYm9mTkNJLzFqelEyV3g0eEhj?=
 =?utf-8?B?enV4eUR0SEd6bEdBQW9TTjJNRnFaSDRLU1lPQk9QamZRNXBJOURCSEdJcUJa?=
 =?utf-8?B?b3crSVI3b0RadkVCSTFlTGoyVDZXQ0gxTnpzWDc0Z0I3ejZVY0JLMm50aXY3?=
 =?utf-8?B?SGhNMlBEQmxzZy8xM1BXalEwdWR0Tmg3bGdpUUY1SGVGOXpUeUR5WWRxeVVW?=
 =?utf-8?B?M3FSd28wNGltS0tMdnpPZ1ErNnBCUFZIZEJpOGFTZjZzaWFjSHhaazkrS1pT?=
 =?utf-8?B?Y2w3eW5EZmlDWW5MMWNBcXpWNHEyN1VLUExVZ1Nzc3lTNGYydHZPem9IYU16?=
 =?utf-8?B?YWtwMkZ2dXEvcFNzS25JQ0I3UEpPTEhRMzNNRTRlTVFmMHdVM1JYUGlyc1lO?=
 =?utf-8?B?elhmck9jV1E2TWVPdngwazVOR09DZVoxaGMyMG9wa3l6YXJLMFk5Y3prdHVV?=
 =?utf-8?B?ZVJJeU0xYmNGVnNidzArL0RzR3hZdjlMWmFxWGJTRG9yZzJWWXNtek5GQUo3?=
 =?utf-8?B?Z0tZVVpvK1prTGdHdWhFYWNrY2dETXNSV2RWYi90OWJidHFsWDJXNGdaUE9x?=
 =?utf-8?B?a2xmV2E3MTVFRnhPWURzOGdzcFNLNmZmUjhGREJRTGdKOUhxZ1ByN1J3T0hX?=
 =?utf-8?B?L0JZZUZzdStiRmlBTnlFbTFRRWNqR1FrTnMvcHdMZnN1QU8yUVJabW9XbW5Z?=
 =?utf-8?B?NEZJSWY3ZW5UVnNaSlRGQ2QxVnErOThKNTY4UXZMRzdWZXVscnNWSE9KdjVm?=
 =?utf-8?B?ZnhvSGFTcE9BRHpDdnA0cWNtT1RIdU5GWm95b2VBOXBUV2U5S2ExUEdDYmFG?=
 =?utf-8?B?OXlqbWsrUjkzdzFmT2I4SkRJWnhMRHByaXVNM2xGcjJBUkFKeFU3MWpUOVdM?=
 =?utf-8?B?YVBTeXpJWWxVVE95OUNQVjVJcGdCUHpCeXk1R3Y0bXVheW9qd0RNT1plUzU3?=
 =?utf-8?B?ZU9FQzRYZVdtUDA1bXBIOEJab00zYThMWHovUmp0WjJOaTZqR29QbVVyemxQ?=
 =?utf-8?B?cXE2SVVGNkdzdjNCMjNSWVRHWGZ6TDFsd3pzSnhscnlQR3BCMTVYZG8zRDB4?=
 =?utf-8?B?YVlwd0YrcEdFaXBiV0g3K29PYVRTSzJpcEc3NlFkMlBtNitXcHIzV2REVG10?=
 =?utf-8?B?VlBDaUNqS29ocGZZSzZ1cmdlaktaM3B4QjBSaXdUOHh1NHBiUmd1a043Y3VB?=
 =?utf-8?B?UllnYVRncVJlYTlVM1plRUU5VWdDM2VZVEVwaVl5a3dGLzhsaFVmQ3hiZHdu?=
 =?utf-8?B?MjhnRlVGQXI3eTdtNHVDcFhTVFA2ZGVwVTU4dVZ2NEREdnc2SHJwUmJjMHl2?=
 =?utf-8?B?VElleWwvRkM4VDR5K0didm9COWVjTXlNSUdZZjNObHBUSXp1bTZlVlRDTTJq?=
 =?utf-8?B?ekhYc3NscHk2RklldW16cTdPWjRKaWh3b3JCZjRFUWl0MnpBNnBMRy9ucjZs?=
 =?utf-8?B?dXBBR1YvYjVWRW5WM0t3NnVVb29SdjgyN1A4dGNJZW1JRW1XT0VDN3FKTGZz?=
 =?utf-8?B?bnpDR2VKQUl5UDlHS2xZUFl4R1lYdWJaMlloWWszUmt2NjAyMUU3Z1hJQTdr?=
 =?utf-8?B?T3Ixd0tGdkNPblhmY2x1d0U5YXFReE1zVlUyNlVEcjFONVZBNkk0bXMwd1ZJ?=
 =?utf-8?Q?iXW7UxnBRjkdLR/S/0=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5876.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(1800799022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VDNxZVg0cVZVaDFRNDNLUk00cE5QdWxrcE9vY1RsdEtOaC9ORjl3elo5NEhS?=
 =?utf-8?B?MmdQUitkbW5yeVpUUmhjS3d3ajhPazVQTHBHLzIyZUtvR21UL1BKTXVwNUFW?=
 =?utf-8?B?ZnBVRkdueGR2aHRQbGQxQnd1UDNKV3FqR2lXS3RtVkk3Q0tIaWRQTFBnT21r?=
 =?utf-8?B?dnhzNmVFckFaZkYzUlg4Nm5tMUYxS1FUTk5rRlpsbFo2aGtDSWV4ekpQbUYr?=
 =?utf-8?B?YU9hTVQ4RzZMdktvbEpYV00vbU5BWWp0Ti9OWTdTWGtYMzhHQW4wenl0SVpa?=
 =?utf-8?B?UmJVUXNWMTFVYnc2dDZ3bW5meTJaekJCcVpKZzRuQkNONkNJU2l3dFZxNVpR?=
 =?utf-8?B?d0lYZHNHMXkvaU15cW5OcjZKNXVFaXVzTHE3amEwRFd4T1I3bS9FZ2pweWtX?=
 =?utf-8?B?aWluZjRmY3ZzMHRWRnJ2Q3NQL01OcU1nbjZGL3BWZEFqeTJzeGdIQ3IxUTVv?=
 =?utf-8?B?d1ZTM0NBc3hDZ3pXTVM2VjV4SVJYa3oyWHBCZ1VNUExkVEEzSm9hWmF4cTZF?=
 =?utf-8?B?K053Ylc5K1FxSEl2K3hibDd3QlhIeW9NdG5UMTNEQWhsemZmRHB4cHVpTFZC?=
 =?utf-8?B?aDZBMkE2c085eGpWYXg2UTNGWnkyY1hqUHRNQWR2b0RkbmRhSVFzTHY1eTd2?=
 =?utf-8?B?a1BkKzJyOS9pVnA4UE1MNitEMDZTcVNULzBGZmJWQVNaeU8zZG1ENi8xcUtZ?=
 =?utf-8?B?cVdEQ3YreFhTRE1wNFUwbEJiTTliZVp5Y1pPNUpJUFQ0QmJYUzAxVE5pT041?=
 =?utf-8?B?cGFwOXE2L2lWVHVRWldPTDJxTC9YZXRmdnRNYnp2blgvRkNCMm5xd2UrVlBE?=
 =?utf-8?B?SGhrUHJxNllud05xWTgvNjZMMVlka01YZUxtSVFnQVJ6K051LytuT2ZSSVdO?=
 =?utf-8?B?MW9wZjVHRWUrS3hSejBCQVZZd0c2bUo4bkU5K3VidzAzL1d5amNyUDVRamxX?=
 =?utf-8?B?MWE4UTRFYmMvQjhUNzBWU1BhN3U1OWEraW56dWFzS1Z0Q1dPRVloK0NRVnVa?=
 =?utf-8?B?T2U4TGo2NjhnVGM3OGJzSjJ0eHNQZGthNjJ1cjVoZU9YMHRjT2ljeWxlSmUz?=
 =?utf-8?B?VFhlR3BCRWJyMFNPUU0ySi9mbENDWHhPbmRtVTZCZzdUNDd4SzFDTzA3aG9M?=
 =?utf-8?B?NTRzYWJZQzBvTThPM3pSU0JyWDU0SitzZVlTaGRBVTUvdEt1b0xKcW0xM3Vl?=
 =?utf-8?B?amllLytNbDdyZUkzNWVEejd2dEowWjRHUEswaEFPT0VTMDBPclp6VDhmbFR3?=
 =?utf-8?B?Z3FEaWFHK0NQY0pYMFlIcysvUzJCd29SU2ZEMzNjWmE1cEIyT0FKTUJIYWkw?=
 =?utf-8?B?MGNkL0NNOFM5S1dQS1pOYVlOT25zMERKR1gzVi85dDhvcWIzWldBL3hiYjFq?=
 =?utf-8?B?amRwT256dFJNbUF1N3F5R0VSclRvUGFic0xpWnVRUWZ1RlgyNEFpSnptU29K?=
 =?utf-8?B?ZHRmaEdpQll5RnNLSTNTRm5CRkNjcWErOW1EcHU5alJDKzI1VmRKNDJDQ3ZG?=
 =?utf-8?B?THo1bUNEZXRML00zTTFLYSs3U0VIeVZXcGZ4V3Z6U2p0dHFXVDNmWFFNcXRC?=
 =?utf-8?B?cmVqQkdGZEVaYmMxMFo3cklpdDkxU2MxcEdlWDlacGlBMzVnRlhEQ29tSG5X?=
 =?utf-8?B?QWo5RWZpcUREM29tYldUT1dmRVNTTm5KTFlYelNZR3ZwR3hDQ1R0cXpxRFNq?=
 =?utf-8?B?K3U0dkcxTXZSdFdlRmxwYUpIbDZuS2VQRW41S0w1dTBzYjcxLy9Meml0eXNj?=
 =?utf-8?B?amxqTkhMTkpmbnJvblNqdENTVmRSM1ZPamxheDBoY0g4T3d0dUVneW5GWUxU?=
 =?utf-8?B?M3puZDk5S2hrMHhJQ0ZqMUx3WWdLcE9YVldsdFJYZWliMzduNk9WWFRLYzhG?=
 =?utf-8?B?MVp3a0U0M0Q0MWMxS0xXeXN3VzNBRUpnMzZ2ZlFOZkJreGc4UWFwQ3o1UmEr?=
 =?utf-8?B?aldJc2FjSU5rYkQvMFAwTWppaG9FeFFvNU5jN2tiNlhDSi94VDBTSTVUYWN1?=
 =?utf-8?B?ak52REk1eHFYWXIyb2gzMjlMaUo2NVZMVWRGdjFtTnpQWHE0ZmJaeFMzTXpU?=
 =?utf-8?B?VDJTU1ZPUnNHR1RmTGl4czk0SUgzKzBDdVd1aHBuM0h2ckkxQVNEYlZPUVh0?=
 =?utf-8?B?clNnYmJ6Ukd4VnpyOGtwRldIZm9lWXR2cDdIbzNudlJtMHI3V0o1M09zTDFP?=
 =?utf-8?B?cUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	8pEdlg1KrJSI9ekBY0Uq8nEr1MMIehYNt3+FtKCFEXLDuz0rwMk3HjyIgU5mZ2a8Tu5c+esh03QD+lnnfNfLuYwY0BrvtHDGGjN/qM0Tm8g0mucD5979iG5hvHUjKU93qktofrbPgDhEZ/43AkXZxQ2lfI5EwpMTbv+cCrgm9rwHkU3x9odmkdMPCalvcn/nhXTiwIvRsahS8HfrR20DY4Bbtj660VwE+MDtdf38SAFR3/Wae29eGAY0BPO+0FwsF4jmFUQi58xfb+dGYVWyH2numiTCP6V47bMQHrlkv6vFQNX1hdIjvtULfkbYcVa/bTRw/IuuercpFO031dVKEhHUwSDpEs0vuroXOpoboOE6dzGu6v12/V5xX21heh3/5WcUX0b1zxLe5dC5eZVwouct6TFRGFKXUaOJViDZ2wRGAlDtuXpNAgmZY459SKja2WI2k/VG9L47uvulrfYCQpgy1+DQWlv2Z0Gwmh9ob0N2KiWP7Y4vV0cvnYPvy1DsdBxIOuV82f+L9RwpGGjvU0oF4/Rb1jtMM5jXuqKn8/hGUvbyW0KsErvLXC3jBEsDH0aLx5yiRnH55E4St7YwbjrSSTx3WHwpAV0dZ4VFEjA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7911b51b-c4ed-4ac5-e40b-08dc9537340a
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5876.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 16:52:31.1300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tQvsKAUjkzMPmMA3W+ufJlmQAugK0cMtLhX6IhIrVrtcuHaOeKRZQLKX9jL6LzTem0QJc724TJnDN7cup2zUPLqLYVm1eZ3Z1y0c6a4+A5Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7069
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_11,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406250123
X-Proofpoint-GUID: yBDS4FiqMFLxQ_VlLBI6Q3F-QXS_O69P
X-Proofpoint-ORIG-GUID: yBDS4FiqMFLxQ_VlLBI6Q3F-QXS_O69P

On 25/06/2024 16:31, Jason Gunthorpe wrote:
> On Tue, Jun 25, 2024 at 04:27:24PM +0100, Joao Martins wrote:
>> On 25/06/2024 13:27, Jason Gunthorpe wrote:
>>> On Tue, Jun 25, 2024 at 12:13:15PM +0100, Joao Martins wrote:
>>>> On 25/06/2024 04:38, Tian, Kevin wrote:
>>>>>> From: Joao Martins <joao.m.martins@oracle.com>
>>>>>> Sent: Saturday, June 22, 2024 2:43 AM
>>>>>>
>>>>>> Link: https://lore.kernel.org/linux-iommu/6b90f949-48da-4cb3-ad9a-
>>>>>> ed54f1351a9a@oracle.com/
>>>>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>>>>
>>>>> missed a fixed tag?
>>>>
>>>> Technically it is:
>>>>
>>>> Fixes: 2780025e01e2 ("iommufd/iova_bitmap: Handle recording beyond the mapped
>>>> pages")
>>>>
>>>> Though I deliberately didn't add it, because we need the patch afterwards to be
>>>> fully fixed in iova_bitmap_for_each() callers. Not quite sure what to do in
>>>> these cases
>>>
>>> Add the Fixes tag to both is better than not having the tag at all..
>>>
>> Right -- but do I propagate that to all the dependencies? That was sort of what
>> I was wondering. Technically it's patches 6-10 would then get the
>> Fixes tag.
> 
> Well, if the patch actually fixes something, even it is only part of
> something then it should have the tag.
> 
> If it is just refactoring to prepare then no it doesn't.
> 
I'll put it in the last two patches then (i.e. this one and next). This patch
introduces the fix, but the fix gets only in use on the next patch.

