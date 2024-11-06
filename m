Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465B01DE2CF
	for <iommu@lists.linux.dev>; Wed,  6 Nov 2024 13:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730899192; cv=fail; b=QQsIyYsui+4zAATzdvFgEZp6EaAKbq5lucjHtZ89Yq3nP56vHLuGh7vII6h+3UItlbyw7DdeSjWrfThX4tmJ/y4aPTG8yKfZFvTQCWrXdHPY7dmjjV9Yp+T5HlVVrvdBCZD2HgbQuCS1V7RRG6W6dUtN1iuPNacypXPnH5f0agk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730899192; c=relaxed/simple;
	bh=N1uWTKwYxe7AuwyeEkC/WkBuvZE3WA4AIKRXHeDlIlU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r7e7EUvAWZDHjEgPtAc4QuwpF+YFyardZXup+n+/XlsbyXxj15DtNXeWh46qz3ePHGFBiTVpachFlVrjt7J3DQy/Ds0phb1ol8u60xvIO/U7PM+ZbviNMkuzoWIoC+yObiMe0TWys4zW/Bpt9lrMs47kk4MCxFZLUu5QoxaUGps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iIMwboob; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KXYhW6+d; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iIMwboob";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KXYhW6+d"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6CiBkh018085;
	Wed, 6 Nov 2024 13:19:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=q/xeN+1TJ9ePcaWVjTCQMkdGJc6MfxEqcq7DZb5QtuU=; b=
	iIMwboob6q4Qe1xSH9o3xmO9s9ddZ/kgIrsRJD6gdt0vLryDhy+vlYPQvqSptgbc
	m3qB518rE3Mxz6cydEtqylIL4kkivg6VumyQOcG4/4EgNP4XucgYz78chd9wN42M
	2O/O6nBUNJssY4/Yv6221p3UF/By9QuGDf5mf5pfteOf3W8vvqdJRHTLrTV5kGgz
	Sz0TdhrtBnqsdjRdTPDYKN92ZoyS15xMW9wreThthD9K0t45uzEDmM6lFDy32hkr
	xwQ0qdyNjpqbGlueMicIr31Zs9qUdiuLk2M35tw5Gqd2wAEQWWK36VPvYFIzyZe0
	XHvZNiEIpPau/CZyC8UR8g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nbpsqrue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Nov 2024 13:19:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6CSf5c005051;
	Wed, 6 Nov 2024 13:19:43 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42p87bwyqp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Nov 2024 13:19:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RMMamc3Gv8pstv7V+qwUZ4OAtLZ2UZ21ETOJLK1FeE/vmNSGmyIJGiTCWxOHQOx9jEDBWkMt9pgCkmWaOlFQcTx9dO83t+AE4WYj+5IfHysm2/jcSMgANhoqrxiW6but3t5B31QkgnjPlFWUhDnJLzB8/MCxjhtfnHrvr2z+8PhsK2SHJENpQgJEe5shjRICyeKSeVTkb+tmv4TZtPVZKRU5fhyYFUdQH6jGBzsqhb3PjmwZn+pLaHc5UHPVvJsxMU0o2ajbgwVdoO8so2AMnGZgagoVckPqFQFAbnzzjEz7yQEmZ1S6nwFgLNJJdWBhIyvmBojIhezadqYKRcE7EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/xeN+1TJ9ePcaWVjTCQMkdGJc6MfxEqcq7DZb5QtuU=;
 b=vdZA2mpOwKmdfQc5xyGGVRCTb3W8MKE4e2zXPCjqnoNGAC/SC9BTHJzCqHDOcnQcD8TWrBU26EmWm6Ydp5JdxvjuLTRU96V3SDSsPC4us7HnZHbyEHExNHZZZq0IddeyBDseoI1Y9mrXishKoosaanRNMbG3ei5gcOJzGZGhzuy+T/2XQL31/oLifUAFhJuS6kvZ6oJdvGiX6XvftEKy+kxHOAE6Pm9p3PcyXaPXA+CzlMaoSVKmkaoDpI/564qHsiPCI5HGvbQWtXSzhME9Em2rK7V2yjtcU7/NiyuarjGViTj5R5g/esUsq3Q3rvxj/H1SCcTNsbdrhjte7Rmrsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/xeN+1TJ9ePcaWVjTCQMkdGJc6MfxEqcq7DZb5QtuU=;
 b=KXYhW6+djOXksMJa6xk5+/xKbyjZzD82loczvn4+f6di0JeEaL01KFmeFlFQZ7Q4E7VCSJHiTZtmHrV1pgdTi8EBObzfG3LJWM64ttkhBBjO86hVpzav6lP7vhfk2afn4k2NXQgmnN8Hd5zhL4C4jReosj2NSMO20Bd3eHuG8HM=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by BLAPR10MB4868.namprd10.prod.outlook.com (2603:10b6:208:333::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 6 Nov
 2024 13:19:40 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 13:19:39 +0000
Message-ID: <2bbfb5fa-20e5-4935-b52d-73b5186c6123@oracle.com>
Date: Wed, 6 Nov 2024 08:19:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 6/9] iommufd: pfn reader for file mappings
To: Alexey Kardashevskiy <aik@amd.com>, iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>
References: <1729861919-234514-1-git-send-email-steven.sistare@oracle.com>
 <1729861919-234514-7-git-send-email-steven.sistare@oracle.com>
 <8f2fadc0-1872-49db-83aa-314352adbb6a@amd.com>
 <7788773d-471d-48ad-9f9c-ddd5671b26e5@amd.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <7788773d-471d-48ad-9f9c-ddd5671b26e5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR02CA0068.namprd02.prod.outlook.com
 (2603:10b6:a03:54::45) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|BLAPR10MB4868:EE_
X-MS-Office365-Filtering-Correlation-Id: 9db7c92c-0114-4708-0944-08dcfe65ab22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z2NGNkpSUE5mdUE2TG16ZHVFUlVyQm1NbmxZRjBaNmE4bHNyVEhiWUMxT0JZ?=
 =?utf-8?B?NTk2OUdUV0xGaWxwa1ZsbE8renN6dVE5YnVNcHFFQkhxZXZwV3B4MVhuRGor?=
 =?utf-8?B?MjhOV0tCWUR4bEJUbnIrdVVlRjdWS25vbnJ1TUFnL0oyZE1XR3h3S0htSmdQ?=
 =?utf-8?B?elR0ZUVyWlRSa2RScndSWmJLNUNOUlI5aTljbUJtV04zcXcwSjh6M1psUTNT?=
 =?utf-8?B?aCtBNkZoWDZzbXpaYStnbVhFcURUdDF4WHh3eDgvWHN2ZHN3MUg3Sm9PVjNU?=
 =?utf-8?B?VXQ2cTZhcnRpYlFjbG81bjdKcjZyR3dSOUNZTVhGQnExTGhMSzFJR2tVM21t?=
 =?utf-8?B?b2NGRm11dHhIV0FxNk1WVzZmWVFsMExob3ZSV3BFY2NqUU5obGI5bEhjVTMv?=
 =?utf-8?B?QjhJTUIrMXBHekdGd05QSEFtbmpEKzlBZVBxZExxZy9aRkpnSTNYTTFDa1l6?=
 =?utf-8?B?cWxnY3c3MEdEY1Vaa2xKaDBYa3JFd05RejkwdWNqTnVEcHhkTWN1elVYT3pt?=
 =?utf-8?B?N2o2TmpqbjNVTzlaRzFrWUFSTlFzN09BckxTeUdMdHVuRmtwRWlaREh3eEsx?=
 =?utf-8?B?TU9hQ0NKbGxPdWZnTW9zb3pjc0gweDd3Y1lsMzI2clIwUlI3OTdNNkR4NlZj?=
 =?utf-8?B?OGc1cTBxUCtmNUtFRW5kTGg0ZnVlWU9kTnlIWnk2WEZMdU50VTVvUXAvSDhV?=
 =?utf-8?B?MEFLV1dNbEM3cjdJalFndmljTlVjY3JUWG13MmpJSUJDYWZUZFUvZUhOS0l3?=
 =?utf-8?B?WVBGQkp6aDFCV1JJSUxsWEUzTmVCc3hQa0lvSkdxNUhYVWgxWEdYTzZrVTA3?=
 =?utf-8?B?akErVHRVUlVtZzd2MDRLSGlaOUxHWld5VHJkZlhkcWt6VldXeWY1UzBDeW1i?=
 =?utf-8?B?Q1dLcWk2MVIvUzYwdXpDODdsREhUc2FURVZwdlltSmxVV0ZpaHVPemJCU3Ba?=
 =?utf-8?B?TG42dUFRTEFURjI4TWdMNmI1RnhpaFpXMTN3SHFLMjFtN1VxMXVhaWFsOGtN?=
 =?utf-8?B?L1VtUTRXbU52SDB0MjBVZFJUSVg3V0hmeXhnbFpkUjFsT04rY2FkUlFPSmh3?=
 =?utf-8?B?TG14M2lPK0NDVnRWQ0RKZVVEdUQ3WlpER1RFaUdWcmdTZUE1N1NlRzRWdDIw?=
 =?utf-8?B?U1hoSW56NEdma3FJbXZ2MytJNWVIQ1RzcXNQRkxneDRzdlp1YW9jNXloZ2dy?=
 =?utf-8?B?M3hPbzZkKzV4L3NWZzR6cktUYmxNTFZEWDJKajhrbXhSTFJFVlN2NlZSWjBs?=
 =?utf-8?B?MnpucER3b3pTem5NNGNRam44ZE1oRTB0LzhHay9hcG5jWnYydzVsdUxKWEZ3?=
 =?utf-8?B?cjk2NWtLcDVZalRvWk4wdzYybVNJNEVRQzNVUzJoMWUxSzQ3WlFwd09hbkdh?=
 =?utf-8?B?NzlPYTQ5RVpkNktLV3k1UmxXOXh3cXBuMGx6bWhCQWdObDJoNkE5V1FHd0py?=
 =?utf-8?B?QXYvb0IwRTR2cm91RjNmc0hRRjZua2VVTS9xS25nV05velFmRXNDMjhWSitO?=
 =?utf-8?B?bFphQXVBQnE2ZjIvek0vM29BTnllOGxNMkN4WVZKL01uVHp4UkwvODdyOXZO?=
 =?utf-8?B?TXpYTEErVlN0SHkxSnB6TUIrQlFvNGNpcjF0cEoxNFBFbitFVEh1c3JuV3Vs?=
 =?utf-8?B?czFZZ3l3UjN6WWoxTHd5LzNXQU9KYk5ZS3JEbWpGdmV5eWJtVjUzcCtCd0wr?=
 =?utf-8?B?Y3AxVno5VmlhcDBJL3hkcjV3ZHd5ank2K3pCUHhpM1hyZVlqaWkza2lmNThy?=
 =?utf-8?Q?V3VlIhTbbiBx2lRZqwYMvvCBn9Abujfz0qmjo26?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3gyNkJMY0lCazhvYklvak11T05MaDdWeVBCY0krVDFTcEpHdjBRbFlBZnh4?=
 =?utf-8?B?a3lFZ2p6OUtHTHRId0MyT3h0aXRyUk1JcHlBZ3BxQm5Lbi83QWNWQWFSYUUr?=
 =?utf-8?B?MXF6a3FMODJUTHdXSkdYWHBDUTVxMVI5bVk4UXo1bzlwNEJ2VWVIMndoRGNJ?=
 =?utf-8?B?d2JKZFBPVzJlUmlTTGhlVGk4MXZKbS9SeVhGZ0F6dWtWMzFLUzBnY290VjFw?=
 =?utf-8?B?Y1d3WHQ3QUNwZ3FFejQ2TlBjZTVsTWYyZUpoTm10OVdrNnozemJHeFlMbkFO?=
 =?utf-8?B?NE5DbW5NYm1IZmtTZmt5Mk9uNk5ZUzhXNDNVVzY3RE5qb2ZpelBEMGJab29t?=
 =?utf-8?B?YVVhb2NGQXJ5VGNpQnh4QThsTFQzeUZOMzZVTjA4TlpGQUNFN05mb2pKSTFm?=
 =?utf-8?B?MEFDWU53QWo3MGFldmtDWTUydHpJdng1amd4Z0xyUEN6WEJUKzhPck1SS0VZ?=
 =?utf-8?B?bXU2eXozYkFmTnNiQVhsZWpZZzNReDhsQnJPTU0xOEJtT0QxTkZPL002NlU3?=
 =?utf-8?B?ZzlKOC9YTmtManEyQjFQeDN3dElkK0F0RWhQTG9uV1FRMXZWYm9pb05mTWZa?=
 =?utf-8?B?d0Rpa2lpcUs5Q1ExbDBscVVOVkJOOG9pL2RsZ2NBTkd2TVBSWC9WT05sdnVt?=
 =?utf-8?B?L2Z5SWJNMWFoS2FDWFhOcUR3VHlOK3ovUDNFbHdVUU9kNEJsRTVDSWtocWhH?=
 =?utf-8?B?VXhWd09aY2lhWlI5WEJKSnM1SVBpMVV0S2VlUmxhSGNpU0tVdjc4LzhmeERw?=
 =?utf-8?B?UENid2pkOWtMOWpFN1c0MjFrbEhVU1NJM0dVdzFKTUVWQk5NTHREVGRxYXJq?=
 =?utf-8?B?N09wREJxK2ZrSlV0S3I1SEVVWlVONEp3Njd2dERxaCtxMlErNVJjdEo2bEI1?=
 =?utf-8?B?aGk1cHlQb0tGVlNYcFBMMWlQVldISHQwVTFjM0twY3BKMnJ3MzcwOUxIOEtk?=
 =?utf-8?B?bGJMNHNod0ZYOFErM3N1dS9SRFhkeTkyNGlHUU1reG5temNXK2tiaTk1TmtK?=
 =?utf-8?B?Um1rK2c5c2ZOZnJzZ0lHbEtyakJkTmNudk1FTUJpdkZZQjRSU0pDV2syNDBZ?=
 =?utf-8?B?cE45WmlyYWpxN1BrK0h1c1AzUkJTUnJVZEVqSUZRNlBXUzFGUnA4MlQ2Ukwz?=
 =?utf-8?B?TnN3NkdENXg2WmxXZVZ2SldTcEQxbTNac0tpcXoxalBKWkoyUzNmUkxEUXBR?=
 =?utf-8?B?a2F5dGRIVXBvOXZ0SDVCSW5sTzVBTzByclVGYWVkM0hDNkNwb0thdWxLN25G?=
 =?utf-8?B?NXNFL0lmbHBESEhEYXpQRTNWZGtkTWJrdHdLTCtCdUFrUEdUMDkrcFIyb3p2?=
 =?utf-8?B?UlpkRDZlRmJ6ZFhkRWZ1RmwyQmR4a2I1aG4rZTg4OHVrcTRuckh6S05GNEJF?=
 =?utf-8?B?K3F0VGVPY25OVWczSUg3Y2kzc2QxN0NFTW9ncDJ3VXZUUnNkcVo5cHJGZVBU?=
 =?utf-8?B?U25jNFo4NEtDVzZaMk5IYzRJazhUZHVLb1BSYU4ycHFSL2M3YnFJQlh4UVA2?=
 =?utf-8?B?WHlHTjI5VGxpckxHbFNXRStGWE9qSlVqRkRTL0xOYzJOLzB2R3ZqV2tKMGVU?=
 =?utf-8?B?dGkrODZ6UnMrV3NqbmlLcWg3MEh1NnVzekZSc1NJbE53UDhGdHNlTFRZY2FE?=
 =?utf-8?B?NWZKQkZVM2NvU1FpcVBaOXlQRGx5SVY5VTg3SVoxOTZ2NVlrMkJ1TXFDVnU5?=
 =?utf-8?B?eGRSMllRMHB1VkNhNkI4Y1l4UUhHRCsyRkkwK2Nsc1owRFZJRmR0bjJkZHp2?=
 =?utf-8?B?NnJHZHpCbXJIbDBCVWZOSExRS3Z5Nit3RFVGemhxL1EyRUJaYnp3L0hEUjA3?=
 =?utf-8?B?QlNIOGJSWERaNEVoLzRiNE81YlpHQ1NuNHNLUUFPUjJQWS9FMTVJTWZib00x?=
 =?utf-8?B?bGdDZ0l5cDhjcEs3QVZBYmY5QU5xRndLaTZLbjJxVmZYTGlKOHdSWVdTR0hN?=
 =?utf-8?B?QjdHVzFjSnhpUlZpbGtldVhCZjZtcm1JNXVmSURDYzFqbEJWTnRKaXFQTmpU?=
 =?utf-8?B?ZGRiWXY1S3RQUHJueHlEOWJVOUZJSG5xSnRrMjIxcy9obHo3NUtVYll0TTZS?=
 =?utf-8?B?bDJwTmtDWnJTN2ttTVpCVGFZR3pKVkFDbC9TdXRzdlBySDgrWWczcSs2dFdt?=
 =?utf-8?B?N0F2OXArQUh0ZjNSVVA3TUROSTduZVlhYnpRV3FsSklqczgxS2gwcThKdVd6?=
 =?utf-8?B?c3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fW+6Hl0vAUbK+YKdAkOJJ2boTKMb6vxGmq6Q4lTXB4lVbQtWefSnc9i8bQTZCczTh7hxCSRGBDIZpELoFxLZ9eXgA8I5BzUmYgrA/LmYR9tHFbChdLXXEGWdcJaWuhwVuu4oTuSXqVLjEQg3BUWsyV1p0fsMOjTRD7LdUyMZ/yG7ETa0itDYBXqejsP6XODPssKtIsPbB5ZyBXunTo0nslcekmiBNKll7E4gaiquyRkmNzQKlXm1QCY2p9VloHiMI3VfXCNdyfgnUMU+WWENNiQvO09YVd5VABT81Pudxc+1p/H/Q4JbXvhZjGC/Km9NnC/10v2w+ylMdNsNyvl5/uNhphQl3xNMQdrmgii8LefRyqAhJ4gs4UiImCwAvGy5Y7tfOZRoC6Q5bdOaeNBk2NQHaUz6s2WAm3uxVcPBrK3p9ikf+cPm1Gf+LaaczCNXqxjnR7/23nV3+T/2oj3lYlb5q2GCEQp2Mj6IQvhIgUojnlPWKlwETlvD/hgpfCibXcHRzK8fJy9Uqie0eCuP3yVgsCt0M/7QdQu/1e9YuMzKoMFL9Xh1MjUGhS0vNdHFRJ3UsHijmMraVpFmQWgWlmsCb8JimqA5tvu8SJCTdAY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9db7c92c-0114-4708-0944-08dcfe65ab22
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 13:19:39.8451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oJYjTw3tEDjXt0E5cmn1aM/7fJb1oY0hPVWuFGVwhuTQ36e4Rkk3qNJvdjmesDpNnnJdx6ZIVQxjLd7SVd0enI/cadT6PzNRia3dbJEBCYY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4868
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-06_07,2024-11-06_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411060109
X-Proofpoint-ORIG-GUID: WWhM1ajjUrMzauSeJRtYKRxUk3Vd27bH
X-Proofpoint-GUID: WWhM1ajjUrMzauSeJRtYKRxUk3Vd27bH

On 11/5/2024 10:18 PM, Alexey Kardashevskiy wrote:
> On 31/10/24 14:34, Alexey Kardashevskiy wrote:
>> On 26/10/24 00:11, Steve Sistare wrote:
>>> Extend pfn_reader_user to pin file mappings, by calling memfd_pin_folios.
>>> Repin at small page granularity, and fill the batch from folios.  Expand
>>> folios to upages for the iopt_pages_fill path.
>>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>>> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
>>> ---
>>>   drivers/iommu/iommufd/io_pagetable.h |   5 ++
>>>   drivers/iommu/iommufd/pages.c        | 128 ++++++++++++++++++++++++++++++-----
>>>   2 files changed, 116 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/drivers/iommu/iommufd/io_pagetable.h b/drivers/iommu/iommufd/io_pagetable.h
>>> index 8e48266..5ac4eed 100644
>>> --- a/drivers/iommu/iommufd/io_pagetable.h
>>> +++ b/drivers/iommu/iommufd/io_pagetable.h
>>> @@ -177,6 +177,7 @@ enum {
>>>   enum iopt_address_type {
>>>       IOPT_ADDRESS_USER = 0,
>>> +    IOPT_ADDRESS_FILE = 1,
>>>   };
>>>   /*
>>> @@ -202,6 +203,10 @@ struct iopt_pages {
>>>       enum iopt_address_type type;
>>>       union {
>>>           void __user *uptr;        /* IOPT_ADDRESS_USER */
>>> +        struct {            /* IOPT_ADDRESS_FILE */
>>> +            struct file *file;
>>> +            unsigned long start;
>>> +        };
>>>       };
>>>       bool writable:1;
>>>       u8 account_mode;
>>> diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
>>> index aa79504..5f371fa 100644
>>> --- a/drivers/iommu/iommufd/pages.c
>>> +++ b/drivers/iommu/iommufd/pages.c
>>> @@ -752,19 +752,32 @@ struct pfn_reader_user {
>>>        * neither
>>>        */
>>>       int locked;
>>> +
>>> +    /* The following are only valid if file != NULL. */
>>
>>
>> Are "struct page **upages" and "size_t upages_len" still valid in this case? The code (kind of) suggests they are not... Thanks,
> 
> 
> Ping?

Sorry, I don't recall seeing your first email, but others asked this same question
and I answered.  upages and upages_len are still used when file!=NULL for mediated
device access, to point to the pages array returned to the kernel client.  Maybe
"u" for user is not a good description in that case, but changing that and still
using "u"pages elsewhere would complicate the code for little gain in clarity IMO.

> Also does "user" in function names mean "userspace addresses" (as opposite to "file"? 

Yes, except for mdev as noted above.

> If so, the patchset makes many names misleading then. Thanks,

The new stuff I added is prefixed with file.  I left the existing upages names
as is.  That made sense to me, and made the maintainers happy enough to accept it :)

- Steve

>>> +    struct file *file;
>>> +    struct folio **ufolios;
>>> +    size_t ufolios_len;
>>> +    unsigned long ufolios_offset;
>>> +    struct folio **ufolios_next;
>>>   };
>>>   static void pfn_reader_user_init(struct pfn_reader_user *user,
>>>                    struct iopt_pages *pages)
>>>   {
>>>       user->upages = NULL;
>>> +    user->upages_len = 0;
>>>       user->upages_start = 0;
>>>       user->upages_end = 0;
>>>       user->locked = -1;
>>> -
>>>       user->gup_flags = FOLL_LONGTERM;
>>>       if (pages->writable)
>>>           user->gup_flags |= FOLL_WRITE;
>>> +
>>> +    user->file = (pages->type == IOPT_ADDRESS_FILE) ? pages->file : NULL;
>>> +    user->ufolios = NULL;
>>> +    user->ufolios_len = 0;
>>> +    user->ufolios_next = NULL;
>>> +    user->ufolios_offset = 0;
>>>   }
>>>   static void pfn_reader_user_destroy(struct pfn_reader_user *user,
>>> @@ -773,13 +786,67 @@ static void pfn_reader_user_destroy(struct pfn_reader_user *user,
>>>       if (user->locked != -1) {
>>>           if (user->locked)
>>>               mmap_read_unlock(pages->source_mm);
>>> -        if (pages->source_mm != current->mm)
>>> +        if (!user->file && pages->source_mm != current->mm)
>>>               mmput(pages->source_mm);
>>>           user->locked = -1;
>>>       }
>>>       kfree(user->upages);
>>>       user->upages = NULL;
>>> +    kfree(user->ufolios);
>>> +    user->ufolios = NULL;
>>> +}
>>> +
>>> +static long pin_memfd_pages(struct pfn_reader_user *user, unsigned long start,
>>> +                unsigned long npages)
>>> +{
>>> +    unsigned long i;
>>> +    unsigned long offset;
>>> +    unsigned long npages_out = 0;
>>> +    struct page **upages = user->upages;
>>> +    unsigned long end = start + (npages << PAGE_SHIFT) - 1;
>>> +    long nfolios = user->ufolios_len / sizeof(*user->ufolios);
>>> +
>>> +    /*
>>> +     * todo: memfd_pin_folios should return the last pinned offset so
>>> +     * we can compute npages pinned, and avoid looping over folios here
>>> +     * if upages == NULL.
>>> +     */
>>> +    nfolios = memfd_pin_folios(user->file, start, end, user->ufolios,
>>> +                   nfolios, &offset);
>>> +    if (nfolios <= 0)
>>> +        return nfolios;
>>> +
>>> +    offset >>= PAGE_SHIFT;
>>> +    user->ufolios_next = user->ufolios;
>>> +    user->ufolios_offset = offset;
>>> +
>>> +    for (i = 0; i < nfolios; i++) {
>>> +        struct folio *folio = user->ufolios[i];
>>> +        unsigned long nr = folio_nr_pages(folio);
>>> +        unsigned long npin = min(nr - offset, npages);
>>> +
>>> +        npages -= npin;
>>> +        npages_out += npin;
>>> +
>>> +        if (upages) {
>>> +            if (npin == 1) {
>>> +                *upages++ = folio_page(folio, offset);
>>> +            } else {
>>> +                int rc = folio_add_pins(folio, npin - 1);
>>> +
>>> +                if (rc)
>>> +                    return rc;
>>> +
>>> +                while (npin--)
>>> +                    *upages++ = folio_page(folio, offset++);
>>> +            }
>>> +        }
>>> +
>>> +        offset = 0;
>>> +    }
>>> +
>>> +    return npages_out;
>>>   }
>>>   static int pfn_reader_user_pin(struct pfn_reader_user *user,
>>> @@ -788,7 +855,9 @@ static int pfn_reader_user_pin(struct pfn_reader_user *user,
>>>                      unsigned long last_index)
>>>   {
>>>       bool remote_mm = pages->source_mm != current->mm;
>>> -    unsigned long npages;
>>> +    unsigned long npages = last_index - start_index + 1;
>>> +    unsigned long start;
>>> +    unsigned long unum;
>>>       uintptr_t uptr;
>>>       long rc;
>>> @@ -796,40 +865,50 @@ static int pfn_reader_user_pin(struct pfn_reader_user *user,
>>>           WARN_ON(last_index < start_index))
>>>           return -EINVAL;
>>> -    if (!user->upages) {
>>> +    if (!user->file && !user->upages) {
>>>           /* All undone in pfn_reader_destroy() */
>>> -        user->upages_len =
>>> -            (last_index - start_index + 1) * sizeof(*user->upages);
>>> +        user->upages_len = npages * sizeof(*user->upages);
>>>           user->upages = temp_kmalloc(&user->upages_len, NULL, 0);
>>>           if (!user->upages)
>>>               return -ENOMEM;
>>>       }
>>> +    if (user->file && !user->ufolios) {
>>> +        user->ufolios_len = npages * sizeof(*user->ufolios);
>>> +        user->ufolios = temp_kmalloc(&user->ufolios_len, NULL, 0);
>>> +        if (!user->ufolios)
>>> +            return -ENOMEM;
>>> +    }
>>> +
>>>       if (user->locked == -1) {
>>>           /*
>>>            * The majority of usages will run the map task within the mm
>>>            * providing the pages, so we can optimize into
>>>            * get_user_pages_fast()
>>>            */
>>> -        if (remote_mm) {
>>> +        if (!user->file && remote_mm) {
>>>               if (!mmget_not_zero(pages->source_mm))
>>>                   return -EFAULT;
>>>           }
>>>           user->locked = 0;
>>>       }
>>> -    npages = min_t(unsigned long, last_index - start_index + 1,
>>> -               user->upages_len / sizeof(*user->upages));
>>> -
>>> +    unum = user->file ? user->ufolios_len / sizeof(*user->ufolios) :
>>> +                user->upages_len / sizeof(*user->upages);
>>> +    npages = min_t(unsigned long, npages, unum);
>>>       if (iommufd_should_fail())
>>>           return -EFAULT;
>>> -    uptr = (uintptr_t)(pages->uptr + start_index * PAGE_SIZE);
>>> -    if (!remote_mm)
>>> +    if (user->file) {
>>> +        start = pages->start + (start_index * PAGE_SIZE);
>>> +        rc = pin_memfd_pages(user, start, npages);
>>> +    } else if (!remote_mm) {
>>> +        uptr = (uintptr_t)(pages->uptr + start_index * PAGE_SIZE);
>>>           rc = pin_user_pages_fast(uptr, npages, user->gup_flags,
>>>                        user->upages);
>>> -    else {
>>> +    } else {
>>> +        uptr = (uintptr_t)(pages->uptr + start_index * PAGE_SIZE);
>>>           if (!user->locked) {
>>>               mmap_read_lock(pages->source_mm);
>>>               user->locked = 1;
>>> @@ -887,7 +966,8 @@ static int update_mm_locked_vm(struct iopt_pages *pages, unsigned long npages,
>>>           mmap_read_unlock(pages->source_mm);
>>>           user->locked = 0;
>>>           /* If we had the lock then we also have a get */
>>> -    } else if ((!user || !user->upages) &&
>>> +
>>> +    } else if ((!user || (!user->upages && !user->ufolios)) &&
>>>              pages->source_mm != current->mm) {
>>>           if (!mmget_not_zero(pages->source_mm))
>>>               return -EINVAL;
>>> @@ -1068,8 +1148,15 @@ static int pfn_reader_fill_span(struct pfn_reader *pfns)
>>>       npages = user->upages_end - start_index;
>>>       start_index -= user->upages_start;
>>> -    batch_from_pages(&pfns->batch, user->upages + start_index, npages);
>>> -    return 0;
>>> +    rc = 0;
>>> +
>>> +    if (!user->file)
>>> +        batch_from_pages(&pfns->batch, user->upages + start_index,
>>> +                 npages);
>>> +    else
>>> +        rc = batch_from_folios(&pfns->batch, &user->ufolios_next,
>>> +                       &user->ufolios_offset, npages);
>>> +    return rc;
>>>   }
>>>   static bool pfn_reader_done(struct pfn_reader *pfns)
>>> @@ -1151,7 +1238,14 @@ static void pfn_reader_release_pins(struct pfn_reader *pfns)
>>>           unsigned long start_index = pfns->batch_end_index -
>>>                           user->upages_start;
>>> -        unpin_user_pages(user->upages + start_index, npages);
>>> +        if (!user->file) {
>>> +            unpin_user_pages(user->upages + start_index, npages);
>>> +        } else {
>>> +            long n = user->ufolios_len / sizeof(*user->ufolios);
>>> +
>>> +            unpin_folios(user->ufolios_next,
>>> +                     user->ufolios + n - user->ufolios_next);
>>> +        }
>>>           iopt_pages_sub_npinned(pages, npages);
>>>           user->upages_end = pfns->batch_end_index;
>>>       }
>>
> 

