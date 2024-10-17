Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C551DE2BB
	for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 17:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184473; cv=fail; b=kVCaP0qPcpzVCeb+o5Gdx9stY3+aEgWt8e1UJz1aBGPT/M8/wqSFz6r2MO/gAArJ36fojFE/ihg9l5CPUNR0oBZbVETGw7wUivErZq9aicU2wObI0fLHtWtfj1gmIjHfnmKMD1AvCDtRnU6rVdr04BmAGyryM76bM2848hx0LL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184473; c=relaxed/simple;
	bh=u/NLt9cb9N9C6cywp1w7agdRskiWYWOARBsK/fj7jA8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eCw7SIwnI908DM4IYDPVxAx6ysi3Rae27+RkblhNd+0Br0Td7F550BsUwDj9lBxIpbJHu5m1HwW/x6qdMOeRmXIuHDy6cxiUgFebLRztm/aFC+W+hPUU32RBbyI7GVFOW9E6Ry4d6x1i+lOd5vAbqj2cVRlBAQwAs3PN3B+oB+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H4FchqvJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hu45Td2u; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H4FchqvJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hu45Td2u"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFBvAg024516;
	Thu, 17 Oct 2024 17:01:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Ig83+H9geap1+ZbBPkgf81AFBHEg8MumOOI45r6sHHM=; b=
	H4FchqvJCfaUUu2ZYUL3qDvd5I02Fs/LBu0JyCt3m4SLV6pnz47idRVP5OE6BEmH
	YjFpCQ2DbsEybLxcso4/CKV7Wz9G09w8kXEiLFugtYAxV2mwFL+U7WHZ2ggGK1Xv
	yXj5OHIgo/ZixACAhgqtb/O6GYfTBxP8dDlr3x9W9CwWYSNl8+bo3hsZZh/vfrZP
	/SfFb5OO5bd+DSqtbZMlDDJWtgLpeExdL72tHBD6ykKaYhh6X5sIc2vMLX7tXs5r
	jfIbPf447m+1algRO1wUHIr4xTN8TuhSxLjzOGENo+u3XjIOe0FZy/94zSJ0yMsC
	dCGpg0+h9ftXGAu3tzQwIQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fhcpj3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 17:01:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49HGxXqf019898;
	Thu, 17 Oct 2024 17:01:08 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fjah6y7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 17:01:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zCPgZXm2+g6hQSBgZrUKHaRAxRWNH5cEoTp4iEfSbGPaW8YyNh6uXRYF9mErztLom+iQQqgDbTNKI4qR9ioeEIGdhgWkAcdxeO72yWbUqH7cnjb9OFRK/zuh8tbrxUShF0vcqdhJpwDqRndKfniMH9gPNSEz4wnPKFJSeHJriKRG3pAhapG0LnZW8BZjI3zNw6YZXzNAPy5pgZUpuSu2mfa/4lQEVRL8tTX3IyQNB7FqRmj1UdmRtlM+KD5zyOAYc3ODxjkFlUXDAXz5G7bbZHlDDat7vqOvPeICdjg5Gk4u7ZYNmYsFpwIyctSnwqAV4AY2t+wXeM6Xi+MprodV2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ig83+H9geap1+ZbBPkgf81AFBHEg8MumOOI45r6sHHM=;
 b=AY9MtCIMV+E1J4laIohxstwOqrlqISTAaOJ6hDgG/eVW1Zm+ScZgsod8VnYWicwzx+MKLTwYMF+7ojb9gNauW4WifiiyTccb4leZx4OOBMZXZunLES9uhOFFUfGCIQJlkhXyFCLs9vA/VVw/h7r+Tc08DfH6s6a0n8LgMmbLoSVw3nFGVV7irbd4CtzvrKlhvUBfm0KO0tem4owrJ7BLS1k0eroNttMQgQRsfYZu342m05GZKf/fhy63GQ+2DfLIpN4YfqV6Jcl6GWrapl10lHRNWbm0cr2GboYV2WRDFPBkHCvoDtZDq5aZC5Tr9ijSdTSeb4RnQdR+tQ7PzQCj9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ig83+H9geap1+ZbBPkgf81AFBHEg8MumOOI45r6sHHM=;
 b=hu45Td2uyEv+wX/wSso1ndP7LushIcYrQgUiNouha5Lfw10q2exxWZX7axCn0Wn1dE8PQSLuKVVTORd4s7/auRICW7NqJPE27pa5pR1FqRsANK2gOhmX4uu1Duj03IA0WNZDxmfs4/PEYygmvCYOrN93TIklYhB47sIvw+RyFyI=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Thu, 17 Oct
 2024 17:01:04 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 17:01:04 +0000
Message-ID: <1bad4f41-f030-4963-ba15-19fa0ccfbc70@oracle.com>
Date: Thu, 17 Oct 2024 13:01:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 4/9] iommufd: pfn reader for file mappings
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>
References: <1728067700-32092-1-git-send-email-steven.sistare@oracle.com>
 <1728067700-32092-5-git-send-email-steven.sistare@oracle.com>
 <20241016123716.GF3559746@nvidia.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241016123716.GF3559746@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0007.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::20) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DM4PR10MB6229:EE_
X-MS-Office365-Filtering-Correlation-Id: e231e4a4-fe73-4c16-382b-08dceecd493b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dndIYmo3bnJUdU1mREZxckMxRW1ib1B0MTdNT2Y0cit4R0tFVFIwdWUvVWxH?=
 =?utf-8?B?N09weWk3ekVjOExhVGo5VUJDSFhDNXNZRmIwUEwyRWZ5YlQzVmhiaGhYRUtk?=
 =?utf-8?B?aVdaU0dyaEZSRTBkUHBXRUdibXd2Y2VpQUFzcmdvdVM3bkx5V2dsaEcyR3Zy?=
 =?utf-8?B?eGFWNDAwbkdlaTdzbEwvbS9xdWJaUWlOYWFXQzJzMzZVbXRSbFlmQmVJZkNE?=
 =?utf-8?B?Z25QcS9TK1RuRGcvMGVFVjZnNVRXdC9VKzgyUVEybzVuQ3pad0YxUW5ISDBE?=
 =?utf-8?B?Y29hYzA2bnNkNU1xM2k5QU42QUIrZ0w5UlNYaDVnUHZYaTU0S2UyY0V6OVIr?=
 =?utf-8?B?Y1NMNm5BRjZsZEdSb1JVeE9kK2ZJZlJUTGcyQ1VEWEpxalRyTGRGL3A2a21r?=
 =?utf-8?B?a0gxV0p0WmxVMlIvaSs1YU82SmQwRUdFOU1DQ1kvRmNxUDRCRHY0RTlQNVVk?=
 =?utf-8?B?Skx4ME9Ob1I0V2szUEhyWjJsdXRpMk9pNnRPVi84L2R0UC9IaEYyYU4zQ3Jq?=
 =?utf-8?B?V1laK0ltNEVZTjhrOUhvSG5XcE15eHlZQVhoRXZFY01IWndJT3EzSHcyd0l6?=
 =?utf-8?B?N0tSQmorOENlL09sWjYyem1EbU9YaTJiczY3aHNxczlqRWkxRngrNjgxK1Bj?=
 =?utf-8?B?RFFXaXdiUDlDSGJhUlIyS1JxR2FyZjhVYmM0Uytkeng5T1pNZ1l3V1AweXlN?=
 =?utf-8?B?RTcrcW9oZ1pwTDhxeUFWMmVqbk9SRzBqbW9yQll1TkY5YVJQeTc2UDZlSGFz?=
 =?utf-8?B?UmRZbFFIVmZFOTYxSTFzakgvSW5GTXFMSVpaenpuRDZ0RzF6dGlDbU00dTE0?=
 =?utf-8?B?SGtlTEpNaGJ0WFNPS0hGbUExaExzS3lBMGMwejNZcDltMW5IaWdjSkhwelN6?=
 =?utf-8?B?ZHlHM1hETk9RWndrSDBMdkoxSkpwek1tMzlabU9QZXdpckUwSWpYVFBiNGph?=
 =?utf-8?B?VTUwR1FMbks5MUdOanptOE9yTEFCRXhjbFlxdUFvNUQrU2lZeHhjRlozbXJl?=
 =?utf-8?B?QjhoeHhmSm9OaHVmSVhxRTQwZE53bE01bXZsTEQxSnhhd21DWHdKYkpEVkZR?=
 =?utf-8?B?Y0hmUzR1MGQ1UjNMaGJJV2VHM2JhUmZEWjhDczlqUDVRSXRQVWpoM3F2K3hP?=
 =?utf-8?B?SmJSVmloNUtpNG4reFhURTZBLzZKRXN5RkhMS3FTczE3bEhvZXVBbGcvQlVs?=
 =?utf-8?B?bnhwQjdkREx2ZW5kUFY5VWhFOCszYkxoUXBDc3MvcUJ4eWkyY0NqSnoxY3RE?=
 =?utf-8?B?OXFYdVhNTVU0VkUvT3RHdlNueXRlRjI2dVlFaW1QcVFDSmhTVGloSWlyOFdG?=
 =?utf-8?B?b3RJdHFmZGVlZWFLNmxHdzExMnROZkxnM3JXaTQxSXBuMHVET1J1THVlcmZp?=
 =?utf-8?B?a0p6UkhHb3VIS3N4RnBTbTVBZGNNbkl0TE9RSEhGM2lnMDVIMmNSZXZHOEUv?=
 =?utf-8?B?dlFVbHFJZzRFdFBnSVAxanJYQi9XTFlUMkJOQmZORkVjRjB0VEZqMTNPcnZO?=
 =?utf-8?B?WjgzbjEwRkRUcDMrZ1ZZUy9YM0NpRTluUGU5R054eXVWL3BudG4xc3o4SnRp?=
 =?utf-8?B?cnRRNUdUNWhNVUZWYWtjK0k5Rm52b053YkpWYnpHRzVsMjN4VlhRTlZDNE0y?=
 =?utf-8?B?L3JmSUpPTTdzVEU4MWRFNGt2cERRc2oyWm0vRnp5amFKZGo1Q0VwZFArdzNR?=
 =?utf-8?B?a0FoMHVRdEVYQ0t2eDEzcHJhYmo3ZElYNm44b2x3ZTJCR1NaclpDZmM4R0Vj?=
 =?utf-8?Q?tG7Xpb/JUn271+pNLRpbwckOgejDAMqHFCw1xgF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RkN0aVNzS01DN0FldlBiV2taaC9yeHpkZis0dm51aW44N2NheDNQc21VTkU5?=
 =?utf-8?B?enNzYlE4NExpR1hoaGVJUlo2cWY0L0p6VjhUZ05kSDVDeDhQN3NETGV5dEpo?=
 =?utf-8?B?ZDFvK1NQSFhRakVqK1U5NmpaQ2F6NEoyaGcrTVpUV2JDaEJxVUh1MzJaT0RY?=
 =?utf-8?B?SzlVRnRYUTRVQUNXSnpIRXdia0RzMkE2ZXZZQ1pTL0NSSk9HR2VSa0FGL0Zv?=
 =?utf-8?B?OTFwY0J3STBHZFRvd2M2UEJ3cjhsM1ZSRk9hOEhGcTZld3NGY1JjdWljL3BB?=
 =?utf-8?B?ZjRLMVlhQ0htdUx2Rkw4TmpsUVBGdDhneGdOaElqR01KOUJPZXdoem04NEpK?=
 =?utf-8?B?VDhwYUNmc2FPRmFSZ2doWjhoVHRacy9reHE3eHZLcldNQXUzcXptQlV4cjVn?=
 =?utf-8?B?TVJFYWs4SkUwZmZLY0FVeU14RDFuc21IMHBJcGxoSjA5SkR5amRweldzS2dk?=
 =?utf-8?B?RDdpQjU0bzJVTW5URTk3MFhQeUlXdjFJa2psSENrTUNXRkZNbHNqMkRFckky?=
 =?utf-8?B?bXc5d3FVbkpEMlUvZ2lsZmRyWXd2TDZNaytza0xOWmh5aXZiUWkraUNSdC90?=
 =?utf-8?B?WDFYRndaVDJiL1dwRWNneXZkOU1jT2l0aUx3TW1ZVXUwelJmWUZBeTdSbUth?=
 =?utf-8?B?VGMvNWFxaFVBc25maWUyRW5Wanp2ZGh5Zld1L1FXQ1l5Z1I1bldwRHNDRm8v?=
 =?utf-8?B?aEhhUDVWS0pCVnhZdzVTTmk1bGd4TjhiN1N5eDdsc1V2V0tPc2dtMFJ4U2F3?=
 =?utf-8?B?ZEgrRWNzVjBvMjZQaUFpSWtyWHpxV29nTFd5ZjREZ25xUWJpdGUyZGI1S3lu?=
 =?utf-8?B?ZnVObXp3WFdCN21ubGRkQjBQR05HOG56a1pDT2p6WjY3ZlJBRGtqYlEwZUhL?=
 =?utf-8?B?aVI1L0RkUUxnVU9hQzNHZHo2WEZsSlJPOWthZEdPK3IvVlNHbXZJbnVHZGpX?=
 =?utf-8?B?L1pqOWRKcGVrWkZId0IvRHZXOHFjNlh5WGN1SDNFV2h5cVNORTkvV0wvTkFH?=
 =?utf-8?B?U1gvV0ZXeFNiVm1WRTFKVjI4eldWYklQQzFOL3NYeW5iTTZtUENSeFA4ZnBR?=
 =?utf-8?B?YmRKV2lTZjJvcFJQcVpwR2VObjdoRHczb1FFUzVRZHE0V2UzMDdjeHUwenQz?=
 =?utf-8?B?K1EwOVRlTXNJc1hBZEZqN29RMHh4VU9rN01pMG1sQk9WWmtsbUp2cncwczU0?=
 =?utf-8?B?aWdSQzdBNlhrbnRKcnRvaHpZc0loK2J5SCtpY3BxVnUvRG1DTmpxeWZzTXFN?=
 =?utf-8?B?eHVmWWVDYVd5ckZXdkVxQURMdVZNSVdiaVlQcmFqd2FMNkJvVHByUHB4azBM?=
 =?utf-8?B?akRYbVNaYndLZ1FDMW1FRUxCa1RpczNSeTBSQlRvTjV6bVArWUo0L25IWDgz?=
 =?utf-8?B?amFhbXVySGRNT0V1cmE2Qk12SWkza1Z1YVNxZEZERGxITGErR0RFQlY2eUlE?=
 =?utf-8?B?N0I0MnkvaElsSTMrdS9iVTBmMkI3NEFEcDU5RTRPL0FFYndGend0TlNoeE9a?=
 =?utf-8?B?RUFOd3B1QUZ6Tmhwd1VtVXVTQkJ1Q0Y5aTZaSlZNNU90NkdvV2J3VEpzK0VJ?=
 =?utf-8?B?djh1TFg3TExiZHU0LzVRcjg0WkdyZGFwL2xSalFRNHcyRDlIUTdNUUlqb1Vz?=
 =?utf-8?B?U1VScEpEM2VvcVN5akwwbHpBcmxJK0lJWW43ZjRrSFJrUWpzdHlWUkRVdnBk?=
 =?utf-8?B?T2srUUNKb1p4VjcrTkxTYUMrcFJQQVV0eHozN0FaOHRIcnNscHozbHlWbzhT?=
 =?utf-8?B?WTRtN2JuNnhDYzFVbTBLQXhHcDRDTFZXRGRsRTBZaDVidFRXT3lHREQ5clMv?=
 =?utf-8?B?UDlTb0YvazRaQjFSdEc2cFlzbTRkbmhCWU56Q2daeWszMktWcFp3NzVwbURD?=
 =?utf-8?B?dnh1MGdQTXlkbEduTmIxWWZtMHdEVXpURHhNU1BIQU13eVdYNXZWQU04a1VI?=
 =?utf-8?B?WmxyRGU2Sk9kTjQydVFwZERNa2l5c0N0R1c5U3p0RmQwSUQ4L3AyL3JxYzky?=
 =?utf-8?B?eTMxMWR6OXg4TG9zQ3ZwaVNseVVCbTkxcFhjRFpQV3JKNUtKWXZQUG5NaTBl?=
 =?utf-8?B?eFg3WjZmbFFaKytZaUR1OVZNV2h0Y2ZkZnhPVU9tWVJiZHNEWUlQcHcyb2Ir?=
 =?utf-8?B?aDdadzdTVGV1NEdMdkNUdXhHYmpMT2VuL0pUQ1RFWFdjUUpLMWxVTzY5ZTBu?=
 =?utf-8?B?V3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xZSOuRfF3H2KsF9X/lcM4j0xV+T7liUuOxq7cN/aRSQHjxr4RxO2jw6jOMXWGAuTTUHlXlZtZx5sJjea+DBu/VomH5N+38u8JOIV41YB/CkuVttCs2Ulnv0asK9wq/lKRvABCxmiEdSuIRKOV1Aipgrd+QzBYrY/6HgsqmOA2vcR3FXoM/BjQmRKw4V8+4/jxzO9TnDyxA+nrgZIKlTZQM/80N233M7Ws3b+ay9CVbOcRqaNbi1ddg4qRDcCWgUcdDBtO43yhodODb2nORx9CKqnwx16hLYVl2avWnqmEd4xnCiAlZO0XOMiPg7cALmL+OeZyojw21CkXUloe9YkTiHuRci6ifOkc+0Y1Y4MDfeH94Zzgi0ix1tD2e20sJ03Uu1bN2gQvmrWBGO5XlwQHOF33cS/g/ea5WKjqE2pYpQB5W94B1W1gg5PwDLu666ZhPRyr2HTnlEnWKj63dpOdBa80z0mTfNI2iRD7sNFms8D6SkpRqU0f7AamCUhTKzGQP7/+GMsVQaNYYmiO8S/VMetAI0qKsjRynDRuIIuickoqqhcwziae/frTa5J2JflyfkKlVAN5wDOPmg5zhK4vEaOfIpzQVjvahqxTXPnfaU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e231e4a4-fe73-4c16-382b-08dceecd493b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 17:01:04.6329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7yha8lL7A1gbZ5kfZjEZMWDO6wclQ7XQuHTpZUlGdGjVkaNI0xU5iniQJQRgjRse1nlWcw/ad+hHx/Bi9dVnvLaMp7EL2wcOlF2eo4jIEa0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6229
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_19,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 phishscore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170116
X-Proofpoint-GUID: _D1vQ_rm8oao3Lc9iP4hAGv9er7jAERn
X-Proofpoint-ORIG-GUID: _D1vQ_rm8oao3Lc9iP4hAGv9er7jAERn

On 10/16/2024 8:37 AM, Jason Gunthorpe wrote:
> On Fri, Oct 04, 2024 at 11:48:15AM -0700, Steve Sistare wrote:
> 
>> +static long pin_memfd_pages(struct pfn_reader_user *user, unsigned long start,
>> +			    unsigned long npages)
>> +{
>> +	unsigned long end, nr, i, j, npin, offset, npages_out;
>> +	long nfolios;
>> +	int rc;
>> +	struct folio *folio;
>> +	struct page **upages = user->upages;
>> +
>> +	nfolios = user->ufolios_len / sizeof(*user->ufolios);
>> +	end = start + (npages << PAGE_SHIFT) - 1;
>> +
>> +	nfolios = memfd_pin_folios(user->file, start, end, user->ufolios,
>> +				   nfolios, &offset);
>> +	if (nfolios <= 0)
>> +		return nfolios;
>> +
>> +	offset >>= PAGE_SHIFT;
>> +	npages_out = 0;
>> +
>> +	for (i = 0; i < nfolios; i++) {
>> +		folio = user->ufolios[i];
>> +		nr = folio_nr_pages(folio);
>> +		npin = min(nr - offset, npages);
> 
> What happens if all the folios don't fit into the upages array once
> expanded? It looks like they are leaked?
> 
> I suppose the later patch gets this all sane, but I wonder if we need
> this inbetween step?

Yup, I missed the leak if a folio is only partially converted to pages.
The optimization patch does get it right.  I'll squash them and reduce its
size by making a separate patch for the new subroutines batch_add_pfn_num etc.

- Steve
