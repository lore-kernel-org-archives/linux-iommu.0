Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B50A2170D6
	for <iommu@lists.linux.dev>; Thu, 24 Oct 2024 19:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729797272; cv=fail; b=jgfdK61bakOf6LVZOoMj/8JzQrRYFdMYY24uILpSlcVCwK3kowqSLfuqUs0rSGAhCy88z3OzIZZSOP8VBYJqz8E6YNlrYLehan0oeC1f3+Gxuq+BwVSSNG/hnxuy1jVOEnttBejJuHwUdORJ6Uv3cy4GWvPKp1+9LXqgqDn4+pQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729797272; c=relaxed/simple;
	bh=z4bGRKLPWkC2Zj3sVpEZE+afFCqXnBVtXCKQ1yNTTOk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZMh8lzgENb0+5Onzho7f8O3MkJsgGXcwgVah4yW36yZaJuTzjz5TG0HCK674uEPze6JpmEEiU1aon3scktZ5BdSndm0Q4cmK95ECzAXo798tof91Jpwbr7iwrZFdnQtI87ksKbTetkIKumqMtsCTTfm8Yz92em+BH+io5plzu2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lA1ApvvJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=padwEPkr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lA1ApvvJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="padwEPkr"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49OHmYUi026680;
	Thu, 24 Oct 2024 19:14:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=VWLisVn9jqstKSq7ZPtk0b8P1+w1YMeAK2NUgFKbmHc=; b=
	lA1ApvvJWjGbmXTLSkdPWMYFEcAlBsI2x1AxTAlPrdbKkVfILKPkvxK79nvoumZI
	dMhqi37EmdTBfup4u1FUPqbmsatUOEO6xOTwdKUpikqkmE2tcDaFhW+eBKeAkV4T
	aRQ9xN9ohQo7OMbCdECUhWpFriTuzKshrSuMn47c0ahzRsE4EOOBS5NHrlRl/oH/
	37500yNgNZChTnxF25YRYBk8XkjnD+d5o6CyID58+fKU5RkJKSBUTZUfkzEnWPAb
	yyL5QU5Z4KQEbwjTyW/rvwEqfwuT5a6o2RqOOWJZJV12MbeAAmAdXRCPdqgLSoPY
	GXECNWrQN5bCwCgPsaMeDA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c57qkfpt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 19:14:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49OIeEWX035970;
	Thu, 24 Oct 2024 19:14:26 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2048.outbound.protection.outlook.com [104.47.58.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emh4d8xc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 19:14:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EXWWQvjI+hd2cmRErNQcPFPa4u1w/BbWsG8gSA0PqdlJtcvtwnWmtF79DRX/qoaFY8o0DpggIRKq9jz34L4a9kO2njTLpUjWCCqgU3Egegq3atgiUK5/8yLezMWwdFrWkKn9pZp8rQip6DQUaBvMWUnvsNTpDor3xRQ7XngAkj7SemebB90/Js0hOCeje7ewFSwvU+7rMNdEHhFTuAB6ereVsphIGUqmN/5MY1AVkE0IP7yUsa8jMoeQK9GlWhzwzbHCTcbvn3N3qzXfueY1gUad0nr7YINIMek6T5Nks1LtsLESrkDcHPCbnsKQHzR4DezLd5wjSe0K+gAQAjyF2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VWLisVn9jqstKSq7ZPtk0b8P1+w1YMeAK2NUgFKbmHc=;
 b=bFb0VIMITHmi/rmcSK9HSuvIccgURkUQ0Dia0XglzieNwYmFOMIsQflcw/vF+BQq3kwdE8tXPyFNuz4+5kRWi4znFScUJCIXBkcVvTUDr30KUJnynld0mJkfkK7pv4U/4rU6uNTP/mjpTb+cWj+9cvumzklfYiCknvXEEMllubIeeI7Bz8IcvorugyK50fvv8FeeMNKd8TWl2Vz9nedmZkMy7ibwj/1Uev6XmIYH9OgjPaaG6lDQkGB/wiDOa/SPe8agOcAeDukAgPNyLprXY1iBTpR0YijSKElsKLDADHg/eqnIOpPJaQ7xjoh0UJSRe4o1QwE8cLzrYSPzFYrqLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VWLisVn9jqstKSq7ZPtk0b8P1+w1YMeAK2NUgFKbmHc=;
 b=padwEPkrVLxxzGh8GoWzjYPdzWMc3ts1FtbM41oorRcECaJY+sezo5ilb60v2Q9j8xp1gK+l31CSw8JAEG4d00qZGz6b+oNuAUlf3lN9It/oifKrvJIZGzAzaSPjoQwA0m3yzoTVpYVYgFt8+2FsRLDrftLomECsxjEuB8aaJZE=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by BL3PR10MB6187.namprd10.prod.outlook.com (2603:10b6:208:3be::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Thu, 24 Oct
 2024 19:14:23 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8069.027; Thu, 24 Oct 2024
 19:14:22 +0000
Message-ID: <e5c4a3f6-594f-40f3-8c51-80d5d03e1ffd@oracle.com>
Date: Thu, 24 Oct 2024 15:14:17 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 9/9] iommufd: map file selftest
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, Jason Gunthorpe <jgg@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>
References: <1729783554-56916-1-git-send-email-steven.sistare@oracle.com>
 <1729783554-56916-10-git-send-email-steven.sistare@oracle.com>
 <ZxqXnnANqpeFq7XA@Asurada-Nvidia>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZxqXnnANqpeFq7XA@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL6PEPF00013E0A.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:12) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|BL3PR10MB6187:EE_
X-MS-Office365-Filtering-Correlation-Id: 66611f5d-7aaa-4d01-6b75-08dcf4601177
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WVo3a294VVR3ZytycXJyRy81YkxjOWFNRmUyWWVkRGdvVXlLSGJuT2cwNmZI?=
 =?utf-8?B?d3crR0FPMnZ0Q05CbEtGYnJ3WmZyNjFJYkc3N2J5MkNPeHpwYyt3Y1BiYWJU?=
 =?utf-8?B?NHJnblZxdmdGUEJnSDNSSlVoV1ZYMkxBek10c0RSdnV4TEZKU3ZONVc3Mlla?=
 =?utf-8?B?OXdqYXF1UFY1NUlEa093SjBoa3NpWmgyRjFGL29DWit5ZEhpTGdSdkU3M0o4?=
 =?utf-8?B?ekNlZVhNSmIrY25xT1Exa3BrMW1UMVVScERxQjR0cm1pWmoxcWxIOXlUV3k0?=
 =?utf-8?B?M3V4ZitCY0VsTG1FMkJ2NVdXUTgwaUEwbWFmdEp6VndMdTk2UE5IRmZJNzZM?=
 =?utf-8?B?QXhGdXVFdm5BU3RPYVl2UytEcldCNVFFQ1ZjaXcyV0R5ajRGLzI3ek5DR25R?=
 =?utf-8?B?S2dQeGwyUlcvbXBsQjVMT05QYjhoOFU2dDJkbmpUZTA1aFZMbTRLT2o2Rytl?=
 =?utf-8?B?dkxyTHZLWmxTRC9vTGlPYzd5Vko5c3hWQzNSQm1UZ0VGbE1YL0xnT1Q3NEdL?=
 =?utf-8?B?M0tNbkJhdnJ5MVB3VlQrMVRiTi82U2lPSXJoSWp1Q3I2MmpYN0svaHBuV0pq?=
 =?utf-8?B?aUpNcGpjcFVWMHFDaXFrS2pRaUN2SnU1cGt5RW93R3pEREhmMzJzR0I4TC9E?=
 =?utf-8?B?aVk0N01YU2xjSUxHU3RRTHI1S3BnbFJ5SDNwQjkrTTJEelFMWHFIZnl6MzNh?=
 =?utf-8?B?NUU4cTlhcktNRHB5alk3LzMxblJKQUg4MXZERm1uLzdNMWtiQXJYMkl0cStt?=
 =?utf-8?B?SlRwZWF1OTA3bElrNDh0MFo2TVpZM2hCbzNQelE5Z2pWSkVVcUZTN01oeG10?=
 =?utf-8?B?aHhhTHc5cWpYeHd2NW9TYWc5THMwZElSMUhaTlVoaVgvamc0eGZmYWczbEcz?=
 =?utf-8?B?alcwQnM5VEdzWktPVlI1dTZZSHI0WThQTUQra0tqUlR2UzQ1MTM3Y2w4QVZN?=
 =?utf-8?B?T1NKOG5VQjZxS0twZ3Y3bDk2VnpYMEJYRDFEUTVEVWFsUzU2VlpoK1hjeVB5?=
 =?utf-8?B?NmQ1MmdmbHJwaUN5VnBBOXF4S1BURmNpaUtoMSs4cy9MZnJMZS81d0hQS2xB?=
 =?utf-8?B?UkdZZEpwdWRucFhDM2tKNGhEd0tZZE42T0RDV2N2UmdwUWdIUzd6eHR3bS8x?=
 =?utf-8?B?YXh3TXVRNURVKzFISXY5RmFmcUdjOWl3Z0lEZ2MwU0hHZVRSU2hxMTRJcjhj?=
 =?utf-8?B?MHNmVHNSRnFXOWhjZHFFUUVQK2paZkFMdEZnL3FMdHZLNkNXc1FGSERxSVYy?=
 =?utf-8?B?N1NreFNpZWFEMEdMZjQrcFNmR2RFSlk4NWVtLzJzdEZtRFErd0JEampHRXZB?=
 =?utf-8?B?d1pOcFlYQ1RaaERtT2RBWnJyNHpqQXI4eVJMZmJvN0dLT0NNVE05VE5zQU1O?=
 =?utf-8?B?d1hYWGN2b0J1VXVmSnlzelNFQmM4RFBoR0JjM0JHZnlTdURDKzR1SUxYYlVX?=
 =?utf-8?B?U0kwQk05aDQ4MG5RU081ZDBwT2dEbjMxWllFaTVDcVF3KzM3aUl1L3JwaFNN?=
 =?utf-8?B?QlVQU1pEUEZyWjdSTS9Id1h1VkFqN2hFbWcrR2tMcDB1emhxdjBMZ00weHpN?=
 =?utf-8?B?ZkRkM2VONzFHbEp2SlkzeEJBbGZ5dnF3cUZVMkJGNUZMcFVTMFExc3ZybXJT?=
 =?utf-8?B?UUpiOXgvc3dkUjZuQ1EvL2dTVE5LakVaNG54L1RRNHdpbm5rYUpkZUJyOHBT?=
 =?utf-8?B?bXV3NFRCT0tMR040c3AvbzFpYndoVmVQbmNtbWhxRkM5TFV6RmhKMjdnWVlB?=
 =?utf-8?Q?yxZ/DaP2HJsPNYrrny+Qyr8T6EywjT1o57l6x1O?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmFVa3BOOElQUHBWai84K2YxTVRqUjZJNXZCQ3h1UDR2NktIekxYZER3OWk0?=
 =?utf-8?B?aFRCalZuMGNiRytjenZzNEdSTWdzYmtLbUc2ME51VVYwNlJFbTZoUzYvYlhG?=
 =?utf-8?B?di9TNm9qOXcrYlY2cDNYbjN1eUZ6RzJoRVY2V2JRQ05VWnVpbkdiZDgzNUJy?=
 =?utf-8?B?aGpORFltYlRTd08veDNlSkZoUTdEcVhwTHAzazVsaWN0OVFsR1FYNGhxZ2Vu?=
 =?utf-8?B?R3J6SDhtVUMvUHZ5aGRza0NnaXhSM0h0TEFOckMxeGkyTU5ua3BDbFdYd241?=
 =?utf-8?B?OHZ5RG9HallURlBXOVY1UVhTOC9TKzkxc3NPaVR6WmZndDN2a2hCN1MvQ2FK?=
 =?utf-8?B?MnpvMHZORjBCVU9uaEp3UFBhbVNQOVhVcWdyZWQycTJFVks0ZnpidU16L1F2?=
 =?utf-8?B?V3I4WkVyVldtK2NlS3NSYTRCMUFVNWxoZUVpOEFwSkVuYlo2cG5HNGZPU1lX?=
 =?utf-8?B?aXlzWGxHUmt4NUs3Tk14dGFkZnBaV3ExeUlEK0tLU3ZJZnBTcGlaRkZod3Z5?=
 =?utf-8?B?cW96ZXdDTEIrdTB3aThLUHA0SXMzVzVTbzV5TDBvMWgrZDJNb1lIMFdSa3F0?=
 =?utf-8?B?aHh0TFRleFFCQXYxakdMMzhUTWJTK2k4K2xJMEJuM05zUk5FT2x0RUh4b20z?=
 =?utf-8?B?L21kbG1FWEl5dGJVRFVZWEVLSVpmWkhmZXpSeW9aeUs0ZUo3dzdtaUd6bzVv?=
 =?utf-8?B?eHFtenBJSjBJdVFVVlhGcWgzdWJWRndXUGtWSUVVeXVhMzZ4TXpSYXpzazVz?=
 =?utf-8?B?dFFCZVRnRW9DY25kWWR5TUNjcTROQ0RGdjdkZUc4RVJlOEFUZElHUkN6elpG?=
 =?utf-8?B?V1hrTTZlbkZJVUZmRW5oblorMWM0Y0lwdFA4a0xkUTFxcldMeTVHSVlQZzBo?=
 =?utf-8?B?aUpvalBVY1JweHI2aFY1alhJWHJmQUl2b2NpaWVoQ1JPMVI1ZVp5bExwUE1H?=
 =?utf-8?B?SVJCWlhJQzBxUjRPSG8zakt4K1daQjNtOUh6Ny9XaFptWmhETDhUSDVXQUlJ?=
 =?utf-8?B?N2l2RGFqOFJXcWN6ZEhEK01OVFBrZFF0VlA5SHQ0R2pLL0NLaEVSbXp3TDA1?=
 =?utf-8?B?eVp5ZGZ4ekp0OWxGTGsxUUhDdXhuZDRtQXRhdXNtTjNaZURiZnBzNUUrZExC?=
 =?utf-8?B?L3JFaEVkTWgxT1NteUkvR203K2hheFpseVk3KzRkMDNvcVlCZWtSRzBBVWNE?=
 =?utf-8?B?TnNTZUlsQ0lJT0x3UmRmWlpHbEVIaXlYcFZocDdyNERCMXY0QjlQRnl2VGZj?=
 =?utf-8?B?OHQxb29LeG5CTU1uaXZxOWlnOEdVdDVEb1FmNFRwVTNZTG15ZzBXSFY1ODBF?=
 =?utf-8?B?L081VkRDdThvd1lRRStvRHFudHBMRHROMTV5Y3FRYzB0ekxianFDSG1vSkM4?=
 =?utf-8?B?blZGMTNGaVE5dy8vRzRuT3lqMXZzNGdGSXorNjErSmgvNFhzUkQyMmwwNVRx?=
 =?utf-8?B?bjNESlA0OGFNajNRZ3MxdXNHR1pWalJzbXJOL2IvbVVqY3ZNK213NjFVYTVI?=
 =?utf-8?B?WFZtWDVCbFlkVlV6UjNrZ0l6MHlycjZtWjhUbGNkUUlvaXB3NWRJQ2N3RU5k?=
 =?utf-8?B?eWdBblh6aXFHUU0yTnhNOFBOOVlNZ2M2LzBGcVBPNW1FaVM2YnJxeUd1S0pN?=
 =?utf-8?B?bE5FWkFpRm5lc0lENi9UR2hYM01tTEtFSVpYU1lXTjNkcXZ0S09saXpRRWhM?=
 =?utf-8?B?aGdsUTJPb29XZnVHSmVPZ2ZhbmRqNGxHMmNHc3BOMzlDRXFHcVhTbFdYbFEv?=
 =?utf-8?B?T0hxSStnVzdyTnMwdUxhVmRleUNiaGh2ZWlKM3lOdWUzNkxOcWxkdHllcWFs?=
 =?utf-8?B?VEFpTlNJMXBleHpTL0tocTE0RENEOTlZZCttVExHbWJnU0xQeHVTR3BhMDJZ?=
 =?utf-8?B?VFRvYVJCRGxobGJVaUkwN1ZEQ3Fra0R0ZlNsd29xV2tHWnRtWkl0ZVNnL1VD?=
 =?utf-8?B?RzF5RE1uRFpLOGZiL1pPejkxVWdsQ3dGVTI3Y3kramJsRkUxUHR4enpXdXR6?=
 =?utf-8?B?MTJzU1MzYkZzSGx6T2lha20yd2tzL2RqWEJUTk9sZVljRCtoRFpEdmFvczdo?=
 =?utf-8?B?eVdpd3lMd0RKMzlsREZvSXBEY09qaTNlUEs1NEZyNGNFZE1PQWRZaDhQTjZP?=
 =?utf-8?B?WElPZ2ZwbWxtandpdHJVczVJbVI0eTdrSU5oRU83TDFmRXR3LzdLTEZybkJZ?=
 =?utf-8?B?WFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	h3Aj/cX3+E/RD5Uod9AZJerlUr0Hvg7WBwMij4RO5XSay+EvwYO9a3pmKP45YRI/NVDGV09kKXnX6C9BLMPyQU8ik+6QO291OfVidwx3HCvjJXgqUfbGhKZeAeoXznvTuh6fON9WxHlMIM8mCEGcBFHNFPZguLOBjkRDoa2rpo9BIDsUInrzBAZqRh01Booqez5qbk5AZorLvCJ1xn21NRBNP4l+8nc7QIWbR591N9GpoZxr5rtLbMTAVill4oTUy3hwId5z0AX87iRuh7h+NyCx9Rl00kyqolQOCSBmsN83BgOv7ChpSUlEaVJFqUZo9Z884pnvqfFixE22GpvbFTNitI1tu7rZihFDNiHx1bS7YfI0nAeyMH6Q3qjfRO5duDvilJPIW+ZBDDm5uBJizjtllstiE7jsffSkmbz4P5shO1+1DpmBfQrGtqDK8UEgO1ILwD3Yv7SOQGsJdU/dcX8q8InA3FclJnmgPJuc8OobcgJs0k7ZrE/gAmmCA+AUu6z0GvsCzys5cHKsXayDDR5e+M2b5nQ/Bt4L8abDfgH6vuZTML92wxZG3GsEyQ7ypus+fcl0fBFtyc+7ol/oTmWrZaPB+03oJE3arplpWM0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66611f5d-7aaa-4d01-6b75-08dcf4601177
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 19:14:22.8411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cB31SyxNONoPNq0xL1m3TJj5moRl24xMSgTM7utsXEIBRi6+C75ZmOIMZE+ay349vwpSfGtr9s/NjK13jxRaf69vhA0+/y22z74f0+f1iyU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6187
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-24_17,2024-10-24_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410240157
X-Proofpoint-ORIG-GUID: 5nhlPYWv98jRUxqpLHmznr7gIywGJeAQ
X-Proofpoint-GUID: 5nhlPYWv98jRUxqpLHmznr7gIywGJeAQ

On 10/24/2024 2:53 PM, Nicolin Chen wrote:
> On Thu, Oct 24, 2024 at 08:25:54AM -0700, Steve Sistare wrote:
>> +static void
>> +test_basic_file(struct __test_metadata *_metadata,
>> +               struct _test_data_iommufd_mock_domain *self,
>> +               const struct _fixture_variant_iommufd_mock_domain *variant)
>> +{
>> +       size_t buf_size = self->mmap_buf_size;
>> +       uint8_t *buf;
>> +       __u64 iova;
>> +       int mfd_tmp;
>> +       int prot = PROT_READ | PROT_WRITE;
>> +
>> +       /* Simple one page map */
>> +       test_ioctl_ioas_map_file(mfd, 0, PAGE_SIZE, &iova);
>> +       check_mock_iova(mfd_buffer, iova, PAGE_SIZE);
>> +
>> +       buf = memfd_mmap(buf_size, prot, MAP_SHARED, &mfd_tmp);
>> +       ASSERT_NE(MAP_FAILED, buf);
>> +
>> +       /* EFAULT half way through mapping */
>> +       ASSERT_EQ(0, munmap(buf + buf_size / 2, buf_size / 2));
>> +       test_err_ioctl_ioas_map_file(EFAULT, 0, buf_size, &iova);
>> +
>> +       /* EFAULT on first page */
>> +       ASSERT_EQ(0, munmap(buf, buf_size / 2));
>> +       test_err_ioctl_ioas_map_file(EFAULT, 0, buf_size, &iova);
> 
> I am seeing build errors:
> 
>    CC       iommufd
> iommufd.c: In function ‘test_basic_file’:
> iommufd.c:1529:64: error: macro "test_err_ioctl_ioas_map_file" requires 5 arguments, but only 4 given
>   1529 |         test_err_ioctl_ioas_map_file(EFAULT, 0, buf_size, &iova);
>        |                                                                ^
> In file included from iommufd.c:11:
> iommufd_utils.h:636: note: macro "test_err_ioctl_ioas_map_file" defined here
>    636 | #define test_err_ioctl_ioas_map_file(_errno, mfd, start, length, iova_p)     \
>        |
> iommufd.c:1529:9: error: ‘test_err_ioctl_ioas_map_file’ undeclared (first use in this function); did you mean ‘_test_ioctl_ioas_map_file’?
>   1529 |         test_err_ioctl_ioas_map_file(EFAULT, 0, buf_size, &iova);
>        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>        |         _test_ioctl_ioas_map_file
> iommufd.c:1529:9: note: each undeclared identifier is reported only once for each function it appears in
> iommufd.c:1533:64: error: macro "test_err_ioctl_ioas_map_file" requires 5 arguments, but only 4 given
>   1533 |         test_err_ioctl_ioas_map_file(EFAULT, 0, buf_size, &iova);
>        |                                                                ^
> In file included from iommufd.c:11:
> iommufd_utils.h:636: note: macro "test_err_ioctl_ioas_map_file" defined here
>    636 | #define test_err_ioctl_ioas_map_file(_errno, mfd, start, length, iova_p)     \
>        |
> 
> Can you check?

Good grief :(  Multiple times I squashed clang style and white space changes and rebuilt
and retested before posting, but I screwed up somewhere.

Should I repost the whole series, or just this patch?

- Steve

