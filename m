Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B35918643
	for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 14:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729262113; cv=fail; b=g2VTwCx5BwxOnFVE61CkEmmLYC3pGvVZd0/rRpXqfCzWFKKk+xM0mD0DnKtNGQnxFr5zCMxDBk1VTTyg0CxPXCazE3eKLbaGGDJU7ZJ8KrWWk4iHTnsVOw6Len09FFQNQS5eyobgek4I9RndfwoRnO1MTS2SspGSQBuSN2V8srw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729262113; c=relaxed/simple;
	bh=hSpdfUQ29jzdiaeYzz4/3H1XZwpOLNqMf/ImrflTFzY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Foo2TEddtPJqohD4ngWRxGft2B9YSuN7URsD4LpLSEoNf3Mi60+iG5b4Vcfm2xIB1EgKw+vUyRUCjlPh87tEe2noLUY4dSlMt5oz6rZpNc9OdKkm865N0m8Q+jLRX8szKzdhjUEHv7z/+slVfZiR6ApifMjbu/CCMwc/bobAxgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CCh11yU/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zzuobkBb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CCh11yU/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zzuobkBb"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IEBgMZ005862;
	Fri, 18 Oct 2024 14:35:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=RnSw85vIQ6kobugo5EN/5i5A1joyqyRgLdeB0atnPpk=; b=
	CCh11yU/PpK0EKJegHxFbYrunXHr7gs17yelUe16+Bv3PlPL5uE0G+bQv2k5rJZl
	hBkFAHjg4nbl0EcxoYe0jgS9DidRS2IYNkCIBZMVEMy77vxcK2tqr3QswthqEvwM
	b9r1laqFoVVBM6mOVmGiHPy6vQty8qUIU6u+/8iKVbwZIq+Cd/nH1cdy+9Ulzok/
	3vgxbhfM0QwcPTD0DSQbXtjF0y1DNjgYMHUveMzCh9L0O5sIBf4z7qWEt6jb8hSh
	X7X2mHwUfF6UY2jpQwduybDpFqaECDo+l7EGCa87b+e9zfmy/+I2fpUplqQ3pers
	KkfA+wKv2IBGbJsCsC3GTw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427gq7s0ea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 14:35:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49IE5x64027127;
	Fri, 18 Oct 2024 14:34:45 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjj9myp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 14:34:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FLv9Sw03LthZ7XfcShDBzvNuJJIgjx/9FBUyNQXGfMX7NE+W+oRGwBjjp/RL3asmmHthjMXXvnHEiUhH8+OROZ9F4qcyQA/qa/Jg6EpJrl4pyol0ngJPr7tG4uTN+52EUHXdPFBV9L1FaQO76FgE0c23HRx6n28VEqi7zapgsxnaBbniLXh9MJm3PaCwvk23jRNl2WdDQlF+JmZdNZZPNLH5XwhnZDI+MgI3lVRWCanSkm5WkE32GnnEU4k/cb+aTcynPXDN45SFIjZEfQ98IDHpx7FAT+o0fT4S+W8vrGhym98jF3Nmtvp/MpLXFFoTVbbi1DQ42YL2jHQMG/MOXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RnSw85vIQ6kobugo5EN/5i5A1joyqyRgLdeB0atnPpk=;
 b=A6rHLeqkIE1LVVmnMQTZp0A+SYKYj/+mq0ajmqOsK2lZwncr4LP8945rXA0zxoh16zVK2bgv1XobwjmDLja+5KAZgmDpJnxduBZFBIxxMqaUCjjANllNA94khOtG49vv6ZClz0xKOAOfD3dLNOqoHT/9fga5AftpkKbeoicSemer23W8gF5nM7BU3P0wUFwem6+IMi1dOcwjKDdtIh+ajsKkBY5wFhrJ0hJNK/ufXAKzicjcEWf7n0A277xXv93VUTZe3z0T7bbd3V73veD9EpWrUmtOfvxC6fzlGJLd0anWWpswryvDA26fJTdvMCGDN6GUBj+VtwCq9JfCy/rTGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RnSw85vIQ6kobugo5EN/5i5A1joyqyRgLdeB0atnPpk=;
 b=zzuobkBb+qWmrJr4YLwdK070y+glQP/O+kcCp3pqMReaJFDVBk19DpAzaBtkR0YrULFS9Yuo2y+XWmJzO+bQoNnKqt36sT+HswX4+KaCLaf1dUoE5fy0xBA8o/oF7IICK/aEYOF6SPfOVSYJx/mKaR42kLkvtCCMT8cYNnsnLXk=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SA6PR10MB8160.namprd10.prod.outlook.com (2603:10b6:806:43f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Fri, 18 Oct
 2024 14:34:43 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 14:34:43 +0000
Message-ID: <279c7e80-1d72-407e-bfb8-d286760a5e11@oracle.com>
Date: Fri, 18 Oct 2024 10:34:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 8/9] iommufd: optimize file mapping
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>
References: <1728067700-32092-1-git-send-email-steven.sistare@oracle.com>
 <1728067700-32092-9-git-send-email-steven.sistare@oracle.com>
 <20241016130001.GI3559746@nvidia.com>
 <6fdad0c2-8b6a-433e-9405-016aaee40413@oracle.com>
 <20241017192418.GD3559746@nvidia.com>
 <c4574487-346a-427e-a97d-6e1ee366ed1a@oracle.com>
 <20241018001046.GF3559746@nvidia.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241018001046.GF3559746@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0360.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::36) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SA6PR10MB8160:EE_
X-MS-Office365-Filtering-Correlation-Id: 310b4cfe-409b-4333-fdd7-08dcef820177
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YW1qaEpoVFcyVXRyMmlSWlFwNkQ0Q2RXQjBkUnFsVys3SVlWcmRZL0RZQUgy?=
 =?utf-8?B?T1lwZHgreXlsT0JTdzl6a2tYQ1dQdWdQRDBiZW5RMVVTL3A3NDZUZ01EZWZq?=
 =?utf-8?B?L1VXa21JWDdJRFI5eDdJL2xMUlhNSkNVbktZZjdhNVNOTnRBb0VUVUhFT3Bs?=
 =?utf-8?B?a2ZodnZzbGZ3aDF6bnhYbzNIVkZpOTNSR2tPZDVBQ0k1NTg5NzRlSTNOOW9L?=
 =?utf-8?B?dUY5b09FM0cxQStwcmtVaDMzQXNna1NIaUh0WC9veW1FckFwUHRTbm8rNzdW?=
 =?utf-8?B?MVpqbHJScHU4N21KN0VJaGI1VUxQR2hLbXZSUjdEZndpV3l3allrUjRTZG5W?=
 =?utf-8?B?SzUzcHJGSTk3MzlDRnZ3ZS83UnRjWGQzb2g4cFhwMi9McVJLaFpGNlg1RTdx?=
 =?utf-8?B?U3Y3d3FQOERyN2xkYlcrNi9xa2hva0Z6NDJ1WjJlN1c5Nk1TNHNXMHNmakNl?=
 =?utf-8?B?aW80Qlh2cWxNc21sMUp6cmhqVXMwMEplR3dKaWZKcjBCNmFleEg1aTg2M2dK?=
 =?utf-8?B?b3dVZ0lhN1A3bnpYeFpFWEtWUEpLUStER0I4c2J6UTlaa0VKRlh2QjFMZ1ZE?=
 =?utf-8?B?UzEvK0JLcm94eWRMMFIvQVRYamFWdTAwbVpHaEhyZ2oraHFYWEJ0dGt3TXpQ?=
 =?utf-8?B?ZUlmNjhBaUgzQ2dMY1o2ejVFeGdTQXBTYzJ6NUFTV1AzM0MvUWpuMTd0Wjdt?=
 =?utf-8?B?VHV0b21aU3dObnhnQzhlaWkzZEN0anVSYlRwbWg3OFJUNlhwMEs3VE92Mmdl?=
 =?utf-8?B?MTEzN1JEbUJRM3R4UUoxbUxwNStCQjhtdXBtUnBEUXlOYnp3OVdyY2tCTlNh?=
 =?utf-8?B?bkNnaitRdWhtMUZ2d1dub2RnUnNKZ2djdlo1YXdKVDdFNmFkQm5XbERqaWJU?=
 =?utf-8?B?NjJEd2VrZzVkOXY1blRlVHVNZEJyOElvWE0yN3gxSHUyWkdPTys5RTZ2WXJM?=
 =?utf-8?B?bjJqRzc5MjZNZGZRem85ZWw1TVAvYjBzWHozc3ZkaFVYT1p3ZTl4S2NPcEFU?=
 =?utf-8?B?WjZvdUFOZlA0U0RBQlZCWGFhbnVka0s2ZUI1ZERMUVNPdXFIeG5hMkVUaFNk?=
 =?utf-8?B?Ukxjb3MraUttRGVDb3dqUVB3OFhReDYzVmo4VForQmhzalpwaVp4RWYyNHA2?=
 =?utf-8?B?bDJxeUNQeURlRDhRRGpMclZieWNUUjlVZE9IOUJCa0tDaHgyVVFiVXVSYjBR?=
 =?utf-8?B?cWdNUzRqSnlkOHhZT2wrZCtYcGdtS2VPTW1VTkw0dVZOTTBKNWpTQXF3VlhP?=
 =?utf-8?B?SDhDREFTNldQS1ZmaHlibjlIMDBtY3l5MlBhWjgwemI3QVozUUtxUGZxbGVD?=
 =?utf-8?B?UGUwdjd4dXVNREtlTnhtTkpsVlQ5YWh1NVYyaXZ3enlack1GZUxuYnBpb2VG?=
 =?utf-8?B?cDFndHhGbFFGK2pmQ042Tlpwdkpjc1Q1U3U4ZGJGa1ZOTDE3K2p2bGdFV2Z2?=
 =?utf-8?B?ZnZ1L0FDdUxicE9VWDdUYWtaUG1nL0VKdXQ4STBvcjBlaTRwRjZOOVRUY0U2?=
 =?utf-8?B?MnJuNkd2TW44bCt4QVEwdlV0dnJHMFdjRU96bm1HUjBWVUNIaWtBcHdGS29v?=
 =?utf-8?B?RFNlUXpTYVRpcWt5clZlT3lpZVBHT1BrSDB3RHFxdE1kN0dNUTRZamdWaXla?=
 =?utf-8?B?ejBKMVNYZ1FlNlZoVzZ3a08xVitTcEVBYUh6SWxIaWZxR2xMYm5pUkJPazhV?=
 =?utf-8?B?RjZpOWdPeld0UHZaQ25NcDV3OGtmRU50SExqWGhjc0lCamtHcktBRGllY3FJ?=
 =?utf-8?Q?tjzkKdkPl+2I3bs6D6dljer9pfaAzbncwKiKSDK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzlUOTljaU8xTy9MSUpSRjA5djhjZHZoeGkxR0ZaNkJyZklEamR4Mys3WnBn?=
 =?utf-8?B?QVh5dDdXdmRHVmU0aGlxbGZrUFBNQStwK24zNHBZbFZQckg5VnhSeVo3WjRQ?=
 =?utf-8?B?TEtaUUcxOEpLeEg1R3ZOSTVjLzBSTXlqWU1HR2JHRnpaclBJM0hHeFpGQi9o?=
 =?utf-8?B?WGhJY0hSSVlydE5aN05kekpSSzYxcVl6aDY1MlM5VTRNR0lkRVUxTmFwa0Nw?=
 =?utf-8?B?YzNxSCtNcThCM0FDK244WEVHUmVTWlBkVi8va3VXckE2NHQ2NTNaL2JTYTJ0?=
 =?utf-8?B?aGR1cFFMekpyN1M4RWpPSWZwV29oNlVZd1N2OS80cEFQSHBBWTA5bHgyWjlQ?=
 =?utf-8?B?Sjk0cXFnc3U4U3lVcXJkVWdiMjNkWk5vcGRKWHNDYUtuUFNFTUpSd2VKWVNj?=
 =?utf-8?B?Y0xnVVVRZmlwNm0raXJTd1BOZkViUUd1UDlyQTF0a3hqZGMrM0pncnA1TlVy?=
 =?utf-8?B?TmMrOTQrYWgycUxlM0ZEeDN3QmxrSzlBMWZ4bitSTFd2QjN6SFhkT01vV0RZ?=
 =?utf-8?B?OWh0Y1dtMjFsSjJBZUNXaEs3bURmVmNtRmtJOEkyVFl4Rm1uR2tmcFMwcnlw?=
 =?utf-8?B?d3A4TDNwZTc3NWdreEh3Mk83UEljSGtBNEcxM0NxU1lPd1dLYmJ5Zi9veGl6?=
 =?utf-8?B?VSt3K2xkS2UwTTZtS1cyUDk2WDNOWUwraFNCS042LzNRN3RjWm9hNjJXaHBV?=
 =?utf-8?B?ZGlVT2M3cUtuQUx5bGFjK0kveFFYSHI0Nm5MQXBkdDdLNzl3NUgxVjNTeFg2?=
 =?utf-8?B?ZEZsYzlUS1lFRDZUWVl4Y25lRW1kamZNL1JNaFRKeDdQRFoyZWJyaE5VNVNH?=
 =?utf-8?B?aFhSelV5eS93dUIxQS9IVlpWYk1QMmx6U0lrdWRZU1lZMGdXaElWRXdEZVFF?=
 =?utf-8?B?MWorZUxOTCtKZGhiN3g1Qmh2Uk4ramkyNzR2ZUhKZDdZVnA2dXlVd3R5YkpU?=
 =?utf-8?B?OWFVSDJoYlVkMlhMb1FMeEllNkI0SHdxV3NIeGxhYVp0WnBQOVpwWVk3cTFK?=
 =?utf-8?B?K1hLSUZoUE04ZWRBUVVnSkNtUVkxQ3lzZmVtRktwejRTVUFFclA1RCsvSFY3?=
 =?utf-8?B?U09SL1RkUmYwanYyNXU1M2ZMMVR3S1A2aTVNcjRWenkrOHU3QkhJOERhWWpM?=
 =?utf-8?B?RExHV1BoRFR3ZDA0a0lITnBIZ0N0NW5mY3RITGFvWk9FeUhDMUpSZUxYNXFh?=
 =?utf-8?B?S2pyUU1NYjhOVzdHeFhkRWNqQzJ3VXZGSTExNW50Rmt2aGwvUTFZMVc1cnlJ?=
 =?utf-8?B?SWFuZU1icWlMb1VmYUtUQmFDMDNMbHUwQm9leE1DTGpQMXM5SDZxeGE0ZWVj?=
 =?utf-8?B?WFJGVk5yS0RYQ05tUjR4bXlNc0pxeG8wTG9sWGxjVmdkRFdtZnppdXpEU0Jq?=
 =?utf-8?B?OGIzT3NReElYdDluOXZaV2hHT2JSeEM2bDUzUFFuWVhJa1hPT09kODF4YWMw?=
 =?utf-8?B?QS9zYWN4amViZkRVYzM3NU90Z0NFY1B1YndXWklIQXZVWkIrU0NRZmZyMWI0?=
 =?utf-8?B?ckE4Q3I2YnlSN2JiUXRaS1V1STl3T0lINnJBYlBtVUpuWlgyMW1FL0NDd1gr?=
 =?utf-8?B?L2tyeEd4eDZ6ZHB4NFlFQVQrNHRDZTFldkVJYy9RMjZWMFBMWHNsakE4Ylhv?=
 =?utf-8?B?Z0FUYnVFVVFXY0FPb2tMTGFhZHRKTlNIbVF0TUdSKzRvMXBBQWNobjB5eXkx?=
 =?utf-8?B?UDhuTkJabk00M09FK3pVMTNEZnNzQ1Q5UCtzRXp6cjFZR2V6T0xSRkNvU1Ex?=
 =?utf-8?B?WXNVcDdaZFE4bmFla3ZnYWZIb3pzb0gzbkhWMWZxSVovTk05ZFN2T0wwZisr?=
 =?utf-8?B?aldxanAySWdDdjdpQ2VwWUdQTXpGcVh2VkZJV0FNMzAvYW1vSlM5blVJeFJW?=
 =?utf-8?B?VXliUkNrTkQzUEhuSWd6RWJLeGNLek9Mb3VsWmNqNUZnTWZyc013ek1kYVFh?=
 =?utf-8?B?aGR2OUF0VVkwS284T1NobjBPbkdpYy9HQTZLM1p1dk5RVDFNcFBIbG1peDZE?=
 =?utf-8?B?aFV0am9wSGZmWTNEQW9Wc3YvcVdXL3A2c0RjQWYyUzZzR2FBVUhwc2E1SU9s?=
 =?utf-8?B?dkx0cDllNzJNVFJHNU9nTDc0UU1rRTNDL0VFWmVhb0ovOTh1UGIxY2ZUbzlG?=
 =?utf-8?B?ckxYMVU2VnBLeHJFNU53bUd4dGdKOGozK242UHVVUmdFMytGdG82cVc4d01t?=
 =?utf-8?B?Mmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HdwsUJ+7sCpt+0m3FUxYO4j1t/xHmj/quYNupjTSUC5dPhMmj9tmtEUC2LH93duj+GPtUDRTEtJmIo45RhZJ0V0f2u3vYoUwexYmbT9sR5prOzfbIdE+lNZu/FJqNyV1NVarlAcLd5JSHo6X+L4dlPUMLqOkqMBdnItkgwXSBsCcnzLK42xf+2HmXHceSQ3T9zfWUAPG9dyAur9EG217UjtxZvnmHd85kWZzduq5dhpUUDOFc7TY7PlWcZLF1WfhyQYAcdr+8mZiXXk+RBYu3NGI0mbXfs/fHjt9TYH+SeYM6nlQ93696I2tjbgAg7alP1co5SoUlCu33sF4rIFFrwzoG/YgzmzeNfEG7hp8Vq9eOBom/me0LUFjnrlJcyPGOmLRGyrID3KEV7LjGogeCfj3yfwN/eT0Pyei+meV+uB4ExixSLPiZPkDBLblstqfNzdN/aWcPkllilay+bkSiprkNml+eIwLYpt+cOceA6/9+qy53o6CyKZQcbJOImEqKPJYgLyx0+ORvc6xowJF83QlQPNeXag8rNcvGVHjsXe0LIufrUWohwwzuGz2ErQUUVuMyvknQnJcmbGigZYq0rQMITHN1PkUHqc0ycw7XVY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 310b4cfe-409b-4333-fdd7-08dcef820177
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 14:34:43.1231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hj61JhP+KoKmkIjIciesNj2i5trP4EZQ4WSH/hPMURnt4g9sqSEgZ+2NTV9SKyB6M6LDEGgZ2QxemAI75EceISLFL48ssVrQcE/Va+ddeXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8160
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-18_10,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410180093
X-Proofpoint-ORIG-GUID: EWaXE_uMDHbjffwiTfYv9SaJ1dGgkHy7
X-Proofpoint-GUID: EWaXE_uMDHbjffwiTfYv9SaJ1dGgkHy7

On 10/17/2024 8:10 PM, Jason Gunthorpe wrote:
> On Thu, Oct 17, 2024 at 03:37:49PM -0400, Steven Sistare wrote:
>> On 10/17/2024 3:24 PM, Jason Gunthorpe wrote:
>>> On Thu, Oct 17, 2024 at 01:02:14PM -0400, Steven Sistare wrote:
>>>
>>>>>> @@ -623,6 +639,67 @@ static void batch_from_pages(struct pfn_batch *batch, struct page **pages,
>>>>>>     			break;
>>>>>>     }
>>>>>> +static void batch_from_folios(struct pfn_batch *batch, struct folio **folios,
>>>>>> +			      size_t npages)
>>>>>> +{
>>>>>> +	struct folio **end = folios + npages;
>>>>>> +
>>>>>> +	for (; folios != end; folios++)
>>>>>> +		if (!batch_add_pfn(batch, page_to_pfn(&folios[0]->page)))
>>>>>> +			break;
>>>>>
>>>>> This function is really weird, why would we have a function adding
>>>>> only the first page of each item in a list of folios?
>>>>
>>>> It is only called when we know that the number of pages in all folios is 1
>>>> (user->ufolios_huge is false).
>>>
>>> Oh, lets add some comments about this please, and maybe give the
>>> function a more scary name. batch_from_folios doesn't suggest it does
>>> something so strange. batch_from_single_page_folios ?
>>>
>>> But, still, *why*? If the folios in the list all have 1 page size then
>>> why not just add them in the normal way?
>>>
>>> I still didn't quite entirely follow what the ufolios_huge was doing,
>>> it is what I wanted to look at in an editor..
>>
>> pin_memfd_pages()
>>     for (i = 0; i < nfolios; i++) {
>>          nr = folio_nr_pages(folio);
>>          if (nr > 1)
>>              user->ufolios_huge = true;
>>
>> batch_from_folios is an optimized version of batch_from_folios_huge,
>> usable when we know that nr==1 for all folios.
> 
> I see..
> 
> This seems to be a side effect of processing the folio list twice,
> once in pin_memfd_pages() which figures out how big it is in terms of
> pages, then again when filling the batch
> 
> If the list was iterated only once during the batch fill then there
> wouldn't be any value in having two paths.
> 
> This seems to be like this largely because the upages_start/end are
> counting in pages instead of ulist items.
> 
> Do you think that is necessary, or could things be done so it index
> based and there is only one loop?
> 
> 
> Ie instead of things like:
> 
> 		batch_from_folios_huge(&pfns->batch, &user->ufolios_next,
> 				       &user->ufolios_offset, npages);
> 
> Where npages is the total number of pages inside the folio list, it
> would be nfolios.

The problem is that a batch may reach capacity after accepting only part
of a folio, a condition I forced in testing by reducing array_size and
MAX_NPFNS. We need to track which folio is partial and what is the next index
to use in the folio.  That is ufolios_next and ufolios_offset.

I could delete the ufolios_huge optimization entirely, and always call
batch_from_folios_huge, which I would rename to batch_from_folios.
And always call folios_unpin_partial in pfn_reader_release_pins.
It would cost a few more cycles per iteration for nr==1 folios, but the
code would be simpler.  Your call.

- Steve


