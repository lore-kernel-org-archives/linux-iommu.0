Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7562AD13
	for <iommu@lists.linux.dev>; Mon,  5 Aug 2024 19:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722884550; cv=fail; b=C+sratRXX6VAS6eEzoBsa9WybObu+pQK8s5ObwWoFlb1RjWuTNbxabBt7JC9Afkx1ucuOgd4TbrG74t6OgPR0vldEEAzI1LBaOH6DvmVQxkmxaDhd6dEU1iygciof2uR9PEthLkvqnEtehtejm3KylULwnXN8XY2tIDLY31fZ2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722884550; c=relaxed/simple;
	bh=EflU0SpEYRWZeYIzXrxlcrLg7K80N7m+BPdlNqZxMPk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JoPYl8Dk4BAcHi1DKrfZuWH16qbd8Rd8DxQldpi2pRfUGGNu121qE1UfptwFk8YLxm61Q8HiYbYGtMvrFhWFc5ozaArnzGAmm1Zf+I6zZ7ugCqr2YWrsuk5p8HtflB201sw0/BwM9l0tpSGTduO91vGP/EeFSYnIotlHPzXTc60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bvcjvZrQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oM2vNvPc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bvcjvZrQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oM2vNvPc"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 475GtWEJ003479;
	Mon, 5 Aug 2024 19:02:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=xaG3fNcfEnGz3bnjo+tR4gTbrVXnSXaH1QxkSDGgP/M=; b=
	bvcjvZrQr8FU7dKfEcAXuam40GTBOYnDW6mPchRfgzoamn63D70kq4dyOXduHcnt
	+fYJUMT9tdkd/tQfB8a9Bhk2EzL41HQDIQRBnPl+2HZ1Vl+fQzy/ryT7m0P2zKt2
	+5qXQHep6xTbm19Eg7Kv9gbb9/SJuvDwf6Ie8ZPy2T4ptE6dOy7YEYc5DxWvwb0w
	T+A588vHgnprXgtxsGh+tLV9O0f3HUt+EPJsI/0IV/EN+TOUVdXNpIZQ3vuVmCIR
	IDzIpyVafHkacL0rZy8b5Q21GqycEI9C5k4G+PqqKLHpPSc+3L42WfK2CpzKVVX9
	KQeiB7fCgiskINv1daUFEQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sce93ct9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Aug 2024 19:02:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 475IOnqj027335;
	Mon, 5 Aug 2024 19:02:26 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40sb0dxwye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Aug 2024 19:02:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tQ/RWmTV+dXXAWO2gGKNrmkoKlwZBgvwGVPn0YIwTfiyCmcDRb7opwfED1vqVyqO3KfN9tBxUn/WqOQxp7QVAtxdb5mwEv1Vs0A6ESkwkV/w4OIbYix3pB+GaJ/Sr8n/jZEIXgElAaaf/dG+GUtrnkkwkRYrSQ3SD+xFD2FOkNeDSs94SZz0eKrdt+EicLHUWNp9QpHe3Wig1ImAY7d+faW2041zhI38SImgzNsRdyK2fHkkFVc/01EfcLHIrBqkrPJ4v7oGdHPhq0XyIU0MxF8D6p9qfcW++778urPPgvw9DXzQ6L0rTd8XG+JbjPoInpZss95p8DfLbeCGSYDhxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xaG3fNcfEnGz3bnjo+tR4gTbrVXnSXaH1QxkSDGgP/M=;
 b=ajl4rAMVGRr1YW4KqT3H5aMNka+g49hZPitgFNIbDCSd26OOoD+NOtSfaq6i3h81m07lsP0v9vohBrachxWfmLIejqba+qfmktcUOIDTYNYQFjsyomyOy3u+qJyO/Y23Gfr99g+AsDz1hQFoKoJt/qMMosKoOymihHbvYRnufzFj2LE5RNRg7TPOAd9bM3Xzy2GnDoD9oOsMmDfO0GSBpCY3Nq5SvlkGBwMIrMIGpB43zwzT9MKYavMX1vMmn0+kLLd1mZHSBSjEWff+U+HFm9EIA5GYEengSP/0/6oGwhHJvbB7oIz0Hd5D+UO8JPLzYEapIakKbZ4KI1xwzKVjxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xaG3fNcfEnGz3bnjo+tR4gTbrVXnSXaH1QxkSDGgP/M=;
 b=oM2vNvPc4Ns+aTaIPDtLsNguIwK9JnnVuyJNbaQ3Z1M+l3jB56FbkSy9SI6gKAMj3CC0Hj8mzC2i7xKULFgT8yDVGGov1xn8lbhL5TNF3i0E0L0cghD+dFHPIZXiczRexed9d5PoPi9Rw0jkKFdZ04RAiuwJ6jaGU7P9/sKJ6NE=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CY5PR10MB6021.namprd10.prod.outlook.com (2603:10b6:930:3f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 19:02:24 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 19:02:24 +0000
Message-ID: <4bb35338-f7a1-46f8-b439-5a3be0ca274d@oracle.com>
Date: Mon, 5 Aug 2024 15:02:22 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 4/4] iommufd: update VA
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>
References: <1721501805-86928-1-git-send-email-steven.sistare@oracle.com>
 <1721501805-86928-6-git-send-email-steven.sistare@oracle.com>
 <20240722155139.GH3371438@nvidia.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240722155139.GH3371438@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR01CA0022.prod.exchangelabs.com (2603:10b6:208:10c::35)
 To IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CY5PR10MB6021:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ddae2f0-1879-436c-d30a-08dcb5812412
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VG9WalhVNDRYd0l0dkdjQmFoZmZRN3p6bDJMWlY5M0dwYmpIV3lkWGk3Y0JV?=
 =?utf-8?B?SVkrcS9iVG9oNklYdDhFS1AyZVVwNFZmcVBrT0kxM3VKdXhlMEFzdkdFczFU?=
 =?utf-8?B?YXNxOUtCZnlpdVJuZkR2UWFzbmhkNXorMjJVRDI1bGJ6aXpqTTVrZUNUNk1Y?=
 =?utf-8?B?M3RESm0xbjVhSndaak9LZnZnNm5lMGd4M0hxK2EzZlN3elNsV2hYczNpWVRi?=
 =?utf-8?B?QjFidHFEMTUxazFDN2tWNWRwU0g5MlFFTVN0NmdKbTZ0Umo5cnZQWXAxQzNp?=
 =?utf-8?B?RHdOV1U3YnRIamM1UFVFeFk3OVFoT2x1MW5UNUFaSFlRTldJWDFDc1ZwMXRP?=
 =?utf-8?B?anJPNXM2aHFPVDF6a09mZWZtVnlQRkJVbzBVZ2pjUnI3YWltc1pycUVtM29W?=
 =?utf-8?B?ZktqZitEUHNTOTZwaHNDTVVFRGJGWXB4VFlUS0NubUttNzZLZkdNcDVPalBE?=
 =?utf-8?B?dnc5U0tmaDRHT3lETnJSNGMzZDFDdng1bUFRM0NZL1VjSlFaMjBTanJ6UkZI?=
 =?utf-8?B?cDBvM29zL3BmU0d3V0wwL1lqSDRnUTJCN0xlMnUvZmdYb0ZqUEVVZTAzaHRF?=
 =?utf-8?B?bE16ekhLSjRBV3UrTk9laHZiZFBhSHlVcWNEMVBpUlkySEhRZytScksxYW1u?=
 =?utf-8?B?dnVPd2lJYVdIR1RiOXR0VVcwdjA5T0hrNHl6M1kyS0s1T3Z1bFVSTlhHRHlh?=
 =?utf-8?B?a2FtVDFiZGdXc211MTRvQndiMldLY1JqMFdrYk8zeVE3ckhVcitweDkyM0RX?=
 =?utf-8?B?SktPOVpkNGtxa1ZFcUlJd01nUVBzZFFsSFcyNzdGbG44RDVSSUVHZ2xrcDBy?=
 =?utf-8?B?L2V4VmxaZ1hOTEdyMFZ4Uk8xcm9KSzJoUHpvaFplOWJKK3NrVTVTNVh6cDE3?=
 =?utf-8?B?ODhXYXB6Sm90dlNoTjlzODRZcmltWmovRmNkREZvZk9EejR1YndTcnJnQ3M2?=
 =?utf-8?B?bmExQ21COEh4cmVGUUIvL3FuY2RUWEFWdTNzRXp6d3lFZDNsWHlTL3JBWE1z?=
 =?utf-8?B?SzkzYlNEbVFkMVpvQ2FWelZ2OWVLTzI2WXVRU2Y3bzE4RFNGTXdVNDN0ZHRH?=
 =?utf-8?B?Z01CWUxsaHByYmNiQXdFQ2wweFprTU1mMTRVYlpMWStXa3A3cys4Vm1uN2tV?=
 =?utf-8?B?TjVqdXVYUHZBRzFWR0QxMUlyV1dDZjBETHc5aWtlRDRXbFFXN2JnemFuMktB?=
 =?utf-8?B?Um1QdmViNzhlQjBpNDVLQzNkRDhmcElVejRveEcvaWpGbTZKVEhuaTBMUzNG?=
 =?utf-8?B?aTBJcXJwWWlRTGh1NTZLcG5za2hiSWRBbHBQdWZzTDlTUG5Zdm1RQ0dGYWp1?=
 =?utf-8?B?bEdQcHU2bWFtZ3hOVExLdmN6U3FwYWY1cmFwc0NTSXFNMGhuQ21oL0FmVExP?=
 =?utf-8?B?b2xXTVFtQld5MW1sYWIrajJHUjBXSXVVTmRqTDZJUFZscVArN2dGazU5SE9O?=
 =?utf-8?B?bFRmYjNuNVZOSk1Gb3EzdG9aNU5zZEx6QjdmUnl5Wk9VVmVBR0xvN1plK012?=
 =?utf-8?B?UCtRK0JHYkVDcjhyb1d1ajlzYzA5VGFIa0JndTFzZ1RGaDVWT295Yk9TK1A2?=
 =?utf-8?B?QlNHSkdQMlpRYzRtSytvUTV2cVNjQVRHeHJhdDkvcjlMWDRaa3V2NTY4ZXZM?=
 =?utf-8?B?S3ZzN2NnQXMvTmpxM3dMLzlYVFdTNncxT2ZPL0UzQmI2ckVDbHBQUUpHL3lq?=
 =?utf-8?B?MmpPVno4SnhPdW9CWnc0NVdBellTdVhnOG9QQmVPdng2OFgrWE00UjJhbFRk?=
 =?utf-8?B?bEVWTWRtR2VDdldnRU1BSkF6RWJwQk9CRVh0N2FlQm1oNUJENUdXZ0gzK0Ev?=
 =?utf-8?B?SDYrRjdIbDIyclFiWXJ0UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXhrQ2hGUXdQdDlxWDQ4ZU1hdDV5OWlaa2Y2bXNuUTRzVzZDRjJsOGhHTStM?=
 =?utf-8?B?SUNDSTU0S0Zlek8zNkZxVWt4VG56Und5TklheVdxd1owTUhzeUJVeDMwK3hu?=
 =?utf-8?B?M0dnS2svQWo5c2puTWlZcnFqaUlKYWw4b0xUa0VyOGtoMkhoS3dDeTZmcXhX?=
 =?utf-8?B?Z3Y5Z1Q3M2JoaDBUNzFCT1ZlT2kyTDBHSlBCYnZxNWt4dlVNTURrODJIcCsr?=
 =?utf-8?B?c3JMQlJHM1VSMk1KZHlTd0piREVJNmY1UHZTbVdFVGhsMEtIMW9oTW1HNXBH?=
 =?utf-8?B?VE9CVmpmbUdSZ284a3BNaWhjZDdrY3RjZ01Ycit5aERGZmNoVllLVFJvNXMy?=
 =?utf-8?B?M25TeWprWFhvdFQvQTY4bTM2c2NrOVFMbXovTVJEcUJLV1pzVDJqMFd1YXpz?=
 =?utf-8?B?MXhmWnNkVm53ZFFINCtob1JmbXRTbXpWSkF4WXRtQ2tYTmVHTTl0dzRFSll5?=
 =?utf-8?B?VHpmMjJqVHVOdUhmUXpjYzZNbFNuUVdTNGJqaHZrbUFxZXlHeXozaWRPUXlw?=
 =?utf-8?B?KzAxQ3M0YWh2aFBDSit5Vjc0TEtkbmViRjhVdjFCb2diYTI0RXlYRExtbnRN?=
 =?utf-8?B?NUpXU3pob3lmakg5YWpldUdvTTVHT0pyb2N6UlUvRk9rS0RFWnVlaXU0c1ZN?=
 =?utf-8?B?VnRnZ1dyQk1xc21GRkVVNUxUOGFOKzNST1g5T2VodDhJNE54UGhBQkZ2bXNv?=
 =?utf-8?B?U2RxSXVrRGJpUFZyNnZnTFBCZDhlMUtidG41c201U2syK2F5cWRDYWtNV1pi?=
 =?utf-8?B?NTVYMkpBdHBpbnJSRms1ZWVPVjhvSWhaT3BRa1cybVdFTUFHYjc0UEd2b2xQ?=
 =?utf-8?B?aGtEOTJkTlU3ek1UNjRkdWkycEY0K1ZNeGcrQjBjbzhtL3RUbUJTSGUxczkx?=
 =?utf-8?B?ZlpHTVJyMkw3Tmd5elZVSGQ0cHk0RWtOSlg2RVRWMG1PTjVkUUxnMDJmbmY4?=
 =?utf-8?B?ZytSYmJPR0RhdDBvdndvVkN6NVlGQnFMWjM1KzZFNUM0dk9kcHVjUTlQUWl3?=
 =?utf-8?B?cE1Dek9ZZnorM3cxc21KSkpTVFRLT3lvbENhK0pZQW9sZDl2NFpWeHVmT1Z5?=
 =?utf-8?B?bXlXNWFnSmd0V3grdEpwdlZSY1AwSGdSQ0ZGQU5GdHp5RkpKRWNIdVFUNEZ2?=
 =?utf-8?B?dXRlQ0xuZFhvZ1hIR2U5WWJ3RUIvcTBkalpOS2o5VDZRMTBBL29xMStQY0lP?=
 =?utf-8?B?N2Q3SWhnU05PN2hzWHFBdm9Qbzg1OFFkT2RNVFBBZi9RTmZTdUk0VU5ZMXdQ?=
 =?utf-8?B?QUkxVXpLWjBuS3NpV243WFF2UEw0NzZ0NUhHLzlyWDFWR0YweTBBM0x4eTVn?=
 =?utf-8?B?d2dvV3J3ZmVlRE5jSEdIVjZSQjRJWEdCWFhaUHVpTjA2Z3BiNkUwOWx3Qnkw?=
 =?utf-8?B?M0VYakxDZWdLTENmS2k4N3VXZU5ldWptd3FySHhXeUE2TEVscjB0WHFVVWpz?=
 =?utf-8?B?a3FDYWN6UlQ2MVFMRVlYTzN3NmRTRDFFeTExYU1sTVhoNnlYQnNBcFZ3Qjk1?=
 =?utf-8?B?dnR4bFBhSGhYM01YQmdTdTU3ZktkT0M2MWxKRm5YUzQyQ0NENjNTbHpSbU5a?=
 =?utf-8?B?bDU3RllpT2NVSGd1R1pBMlBhS3lWamdLNFdiRzVTK2hQMGNKVFBKZFRnVjJB?=
 =?utf-8?B?cThwL00yNG1kSWUycHkzTXFPUkJzdFgxYVoxVWo0alZxS2ZwamQwUkI0Mm4x?=
 =?utf-8?B?VHk5Z21RZkVXd1YvV3c1dVJCeHFBd2NhSFhGam5aVnNDSU1OZnlNT25iRHE5?=
 =?utf-8?B?OFBTbDg1RFFxbS9Cb1BKTm5UcnYySFJpck1Na3UrL28wcmduei9hbURKRG50?=
 =?utf-8?B?UE9ScDNtQUp1T3lhZnloQlRyZlc4TzhCd0gyY2NMNElqOE40U08wUStOZDVs?=
 =?utf-8?B?RktCZ1FDRHhlcnhtcmI4aTJKa2UrK3B4M0c4YUJzck01d010Zk4yK1EzcmMw?=
 =?utf-8?B?ZzAxRnJlZHFKR20rUjBxandlSDF5c2FTMHRHd05HTkl4bjJWK1VtV2pETVVy?=
 =?utf-8?B?cTN3ckZOenhLcnhzN3lVWFBZcUd0SE52UFlmQkVqb3dpS3NXaWJIYVAvZ1BF?=
 =?utf-8?B?R2VIdVpIT0hQaDJ0VmVvV2tRQ2ZZUzJNamFadXJWdVhpcE81T0JXZk5Ra1FL?=
 =?utf-8?B?S0RGYXN0aUxIYlpSdUdUT011ZG11cEtGZUlGUE1DalF4QWFVMXREa3ZkT3c0?=
 =?utf-8?B?d2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PpiSEcMdpdIkKC847xDy2Hy1lcHz1tf/DKmYt8K9Fp7TWBtqxBzeoLyO464C+dxe300Qr/zbeNfbKQ94cvpJw1lkYFAZBzFCZXol8NfBwtkxM+GVxIrRkYI1Ym0fFThP7TLipaEvvBKjzg1xeVSHb+NBU4rrjk+nYQcmvFFgWHtbtmBSpJ/nNONLPipNgTCdXYdvoj7vlsJb1YB49FIEHb0u/dbqMbMQKspveLOYae93+lC6IURfUg87BeGTBqpb+W1AOrWji7dwJIF3MGHU53Va8ioDnWjHljYoNKyGeW45dDLoLcqNl7818IDgiR5RqJK41m82z9zqJd28rYb9TzObAWORbkBL8vdHu+uJcqNH/EYZgKNSpU2znP4xIZ6ki437K7rgQPz5cuCsy/rosVkgQCqpNv4EPUtoDhjtzGLx2/9MfTS8xdMOU+E1OxOk4dhcGBWFMjD0GU25cvrgd9FGPEYpeJvcWsuduCc1BunOaExB1x8qmpZ7FECO4XHlxKk1uRh7gsSQH09MN37zC6VU9TaDzw1futxs3ACQK6R1FcskxZbvNoXU8IpcLgUssd3uxKJ4x5cY5fdO7nuefvjraeVWAD4YzvDFBeGkWpo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ddae2f0-1879-436c-d30a-08dcb5812412
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 19:02:24.1227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5NB/BFV6gNE/HunZjcNFzdLgeG20mw7/1SNTA1/BpDnxDrtqiGJ0nVbAwax5g4hjYgmVK+mY7meeMWt6BlgTrqvka3pbzQe/CPlxKhpv/so=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6021
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-05_07,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408050136
X-Proofpoint-GUID: beUiQj3JprU-UOrfn4bH_JssxYlc_Tm-
X-Proofpoint-ORIG-GUID: beUiQj3JprU-UOrfn4bH_JssxYlc_Tm-

On 7/22/2024 11:51 AM, Jason Gunthorpe wrote:
> On Sat, Jul 20, 2024 at 11:56:45AM -0700, Steve Sistare wrote:
>> @@ -458,6 +459,76 @@ static void change_mm(struct iopt_pages *pages)
>>   	free_uid(old_user);
>>   }
>>   
>> +#define MAX_UMAP_ENTRIES 1024
> 
> Only 170 of these fit in a 4k page :\
> 
> Are you worried about the high order allocation this could trigger?

Should I worry?

> I guess the alternative is to load it into a maple tree or simila
> but that is alot of memory allocations.

I define a max to guard against a DOS from userland requesting a huge number
of entries and causing the driver to allocate a huge amount of memory.

The use cases I have seen only have dozens of entries.  Do you have a figure
in mind for the upper bound?

If not, I could just copy_from_user one entry at a time in the loops, and in the
bsearch comparison function, requiring O(N * lg(n)) copy operations.

>> +static int iommufd_get_umap(struct iommu_ioas_change_process *cmd,
>> +			    struct iommu_ioas_userspace_map **p_umap)
>> +{
>> +	int i;
>> +	int len = cmd->n_umap * sizeof(**p_umap);
>> +	struct iommu_ioas_userspace_map *umap = kzalloc(len, GFP_KERNEL);
>> +
>> +	if (!umap)
>> +		return -ENOMEM;
>> +
>> +	if (len > MAX_UMAP_ENTRIES * sizeof(*umap))
>> +		return -E2BIG;
>> +
>> +	if (copy_from_user(umap, u64_to_user_ptr(cmd->umap), len)) {
>> +		kfree(umap);
>> +		return -EFAULT;
>> +	}
> 
> This is memdup_user ?

Sure, will do if I continue to copy the entire array.

>> +struct iommu_ioas_userspace_map {
>> +	__u64 addr_old;		/* old userspace virtual address */
>> +	__u64 addr_new;		/* new userspace virtual address */
>> +	__u64 size;		/* size of the mapping in bytes */
>> +};
> 
> Use __aligned_u64 here as well

OK.

>>   struct iommu_ioas_change_process {
>>   	__u32 size;
>> +	__u32 flags;
>> +	__u32 n_umap;
>> +	__u32 __reserved;
>> +	__aligned_u64 umap;
>>   };
>> -
>>   #define IOMMU_IOAS_CHANGE_PROCESS \
>>   	_IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_CHANGE_PROCESS)
>> -
> 
> These - lines should go in the prior patch

Yes, thanks.

- Steve
