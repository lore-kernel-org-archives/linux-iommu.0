Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F94E1DE4D3
	for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 19:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729193878; cv=fail; b=d73cES4oqAiqLkWo/SzNbqZTT/qVTSu5dJsaHww5v4TkKDlObbZHaWGouqNZTF1EXBZa4zntIzZsyz+EUwMa0SMbRevvGXX22Bl7say2gR00NJGEVd3KCvk3A34GJ349pMXwey5A9qG+Lqm/HbUlmSgWP9l2tz46C1NvyUGA1cA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729193878; c=relaxed/simple;
	bh=JRfH5OKeisftWk72JqJKmyJ1y4ZVpr5VVrU0vo3MdXU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XOThxj2OSrtBDWqp67xpbsW2Yug7MRFMskNud/fGKtddMoN9oIzxNZuHTJM4U+7Znj1JVFBLrtGWJtf3BhUCKFdWyrUzQG8jcBaYKZ4n4CrI+nOHecVBN50eIVT6gRWf3AucJ+wgnpmOeJtCaAyzR0w8Gz5JvDs05CEksSktq+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=P2M8VWaE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lZZxORNE; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P2M8VWaE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lZZxORNE"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFZ9Y9004045;
	Thu, 17 Oct 2024 19:37:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=2IK/CleD78IKbN7h0n+QBy71lBATm5ADoJq5SBZv8Ek=; b=
	P2M8VWaEGxf/NNfqXGxhGnMXeKKolUEktlcsdKxfKngUA4SNTTZ1/yp+HLHmq6zE
	5nFOisdRKEzI37/1DdHUcQbhu4EbHH664EHe/lv4MvCwT8ZyKYCJymf5vEpWma+Z
	VHKVyS2aftf/lEYkn1Lpk+YqAUwHaPcPjXcTmUup7D3ssc/wAstDKO9mgh91HpXl
	9Nss8p6IvjHFw/Sd5550uaBxoZC28G9q5ACiDdnAGRXbvFdyVvsmlJrPJ2B2bqG4
	BBmKo6AhgA6+3nyDSbBdjXQqT78av68k9ymrXmj/8UsHEZuaLntG0LaOn2h+JJ1Z
	hr7WOGkXMaJTJxy+wyiUTg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427g1aq2rh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 19:37:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49HJ5JMS019422;
	Thu, 17 Oct 2024 19:37:54 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fjaq0p5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 19:37:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fYrjaGKMYzGGcSYisom7gorthNrSswQeti5BdpxOkkBNqb7GiYEHw8cL47snp0Cuv65XmJX6nQP+q67i1i3PlT5H/XDqkru8COPhFA05TBhohzIGH99g0oZhK3aedx9i7SosxBEdKYukWy5CggfpYTNeAs+lFzE5Ia9nZU4xnH7Q6jmYCdIxYc07yTMI8Jpse4xmLc7M4/8pMyT7oHFX3DLiO0je64nqNMEWA/RPYbwP10z8WOsaA8pk/Y/kBgmnop8fHUNCv8zoEqMvt+1xWq2yHtuwE41EkoitaZE9JXXgkPI5a1NWCVpRUw0OqLkRM+acJgSrIdVikv1WexojUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2IK/CleD78IKbN7h0n+QBy71lBATm5ADoJq5SBZv8Ek=;
 b=ungph0SNrists1mzkq5q4HQYbPOBna9MtFIea/mZv7YrBUTzwwGDcnWmV4HAlnmkDng70NZSnE5Em5ifrK9SgSfI9wriF5fxXc8x45DTxLRR9LSa3ZAAFxRJ3l/gQ+lvYfE8vXaPgRDwYGQuLJaSgycWYb95toLSdoZQJaKHXHlBzuBdH+EbBm87YIgmxK6mbl/1c60W1PMVd4I2rN4YnUUAo/44DFDBORPp0d+zKdmxLNNMCEow6zCtqPLEFSWzvzDn0eqpVMYcmxk9sJIIfFL1b8VIwPc/ZDdCVgTFaJ59dNIShcprcbKENm/wq0tLjos4yVZt4u2LxSsgY1puVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2IK/CleD78IKbN7h0n+QBy71lBATm5ADoJq5SBZv8Ek=;
 b=lZZxORNELCgJP18brLAIVI7M1uRfwvvKCHEF9sM767uCKqjvR9P/d5Yr4vRTrJBntHw3urZbA7DbdJ/AUrVYzqCdajvh8bMbP82L6wLN7sbkuQgWUV+4dab5fRHo8pcGViJjZFOuC88xgQQ5g5EHOiteTj/hIqkJGpSqMPsZG1Y=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by MN2PR10MB4318.namprd10.prod.outlook.com (2603:10b6:208:1d8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 19:37:52 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 19:37:52 +0000
Message-ID: <c4574487-346a-427e-a97d-6e1ee366ed1a@oracle.com>
Date: Thu, 17 Oct 2024 15:37:49 -0400
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
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241017192418.GD3559746@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0071.namprd03.prod.outlook.com
 (2603:10b6:a03:331::16) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|MN2PR10MB4318:EE_
X-MS-Office365-Filtering-Correlation-Id: cf7c434f-9688-4d29-c008-08dceee33072
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K2VVdGREcmNCeFJidXBZWHhRSlVPYVZjVnAvU3FjalNnNHNvcklPL01OQVlC?=
 =?utf-8?B?N3NUTVFtaTFrWGZqU1hYbDZjWVhDRlo5RmF1NElZckN0dERXMjRTdTJlak11?=
 =?utf-8?B?cEJ1YVh5VW5QOW5XT3FTbjMzaXBXTTZKOE95RURmMkFtQ1NoSGZ3SXRKejIx?=
 =?utf-8?B?WG1DbFBNbzA5eTE4eVBzWU5IOTFtWnhEUjBMdnpUcXd1WnBZTHl1Q0lnWnVh?=
 =?utf-8?B?TUhvS1dpWjdreEJtMloyVXhid3ZCMTg1b3F4NWVTWjk1Q2hIWTVyK0hmQjhV?=
 =?utf-8?B?aUI3Mk90aE1aNW1SNnR6RzlmcyttUDRCYWYzZXVWOEFHdVR2azRacXNyZDM0?=
 =?utf-8?B?Qjg0ejNQckw1YU9lNVl1aUpDU295S1VOVFcxYitVbUt6N1N0eVBNN0ZDTEdR?=
 =?utf-8?B?ZlN2QzdkZVVXV3hYbmIzTTVRUThma1MrMXZtclpvbExRVzBsTmEwaDVVbmVh?=
 =?utf-8?B?WnltYTlWTXVweTlHMEZtU3Z4M1EzMUdDSzlhTTN2UzMxUlEwQ3p3NFhHZTBE?=
 =?utf-8?B?ZG9oU0lCMk9xNjBaUVJKQmlrU0huRUVOM1JodnZwUjhpRTc0cVVxRGpJV08w?=
 =?utf-8?B?cXV4VjBpVnU5ZUhKWldSWTNFbVkxbUFCUjY1NmlaT1JrT3dmMWdkUStDS0Vu?=
 =?utf-8?B?ZHVhNlB4SVl6VElUL3ZWM2dmSEpieHc2azY3QnZOWU10N1A3RmlZcXF0SFdm?=
 =?utf-8?B?LytCcGlUd3dXbXFGZWk5bFNXY2NXVEwwVWhieStmemt2aUtXQjdLUlVSQ0hH?=
 =?utf-8?B?dXdkN3A2cVlKbmZvRGhwVWx3RDdCQjdvcG9iS3dJNW4zSXhNelVjTmhSaThI?=
 =?utf-8?B?cjZyY3VPNlk5NHJJeGs2TEJPUUI0aDJhMzFaYzJCdCtTdTg3eVNsTEJ3WHVK?=
 =?utf-8?B?YVFyZldLRG9tNENkRUI0WnREM0pPUnliaG1ZRjROdFFVSjF0V1B4aVhTbjhB?=
 =?utf-8?B?OXlZNklPZ1NuUERMdlhHZlBmV2ZiQkZNUEg4Q3pjYTkyMGkyVU5xTEl0WFZY?=
 =?utf-8?B?bWtjVGUzUWtwYjNRd0hHcG1Yc3NjUCtuckRleC9XdDdIRW9sYUNyV2NlNU53?=
 =?utf-8?B?WEJBY2xNL3drUzBMWnpvMWxmeUwyMXNHYTNHQm9MRm1xL3d3UUhqMTNISWQ2?=
 =?utf-8?B?eHNTNnd0N29EOVRPU2NHb2hLYUdhWmt1eFVURnkxbEl0QlU2SkJMa0xjOWVq?=
 =?utf-8?B?T3ZMY0xqZkVsb0lYY0QweXpzd3MwSDc2K09POUsxMUI3TmQ5VFM2UHJRTFJl?=
 =?utf-8?B?bTk2QytnU2J4M1J5OFY4aHdxVnVlSnkyT2VQSkJUYlZhUzVZbWJRUjdiMTZG?=
 =?utf-8?B?RE9haVhzcGMyYWZUMSs3TW1PaGo5UmtiT0VhR3JnQ1B1NnNhNXBQVW9hYmdZ?=
 =?utf-8?B?NDh1cTdBQkxiWENYaWZMU3JUQUxBVHozamRNZWY3QmdqWFNnYVJxMWdDZUI2?=
 =?utf-8?B?cUZsZXZWK2dJcWhraEo0ZXR6dlpGMzM2VnhBMENTMWtENUlaNjhMQ0R3OWdC?=
 =?utf-8?B?aWZNVjlCM2xNa0lLRExHbi9rTWg1OFErazRDV1doUlBFWFZLR0J1QUlCWm41?=
 =?utf-8?B?ampOOGxERWh2NGxSZXBRMVRNWkNPR1BZMDU1a3RYaHNEVVNBWGFYYkxHTzBi?=
 =?utf-8?B?MUJ2S3EwcTluNTZWMjRkR2pNZXZnTnduSXc0Wlg2V09hMkRObWZlWnp0N3Zn?=
 =?utf-8?B?TVZuTGRTRWt5czlYUUxWNXRoWUI4MU8zSjdvTlh3YlhQQ0xwODZteElqbW10?=
 =?utf-8?Q?ESMmIBpcZeRGXXc8GvHlgSaJxh9vTOAvgEdO7A3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Yzg4eVBOcjdPZHVDL2pxWktLajVUWG1DakdabytjZGRjQXhOWnN3czR1VXlM?=
 =?utf-8?B?eTFaZGNlNW9IeWptNzV3STVEdTVXRmkzMU50K2lkbjlhM0Q3MTEvZXpmVnRB?=
 =?utf-8?B?RnY4Q1ViOUdFTENrKytheExVWDhVcUhEcHZ2RytMRWRlYXVwYmhHclVmdkVS?=
 =?utf-8?B?QUZnUlphK1hsQjM2N2Y1Mmx2dXM5R1p5T2ZXY2JrSllKdVFZZFd2aHBaOTE0?=
 =?utf-8?B?TlFmQmhUOTlIZ1hFY2tWenMyQnVabWx3a00zeTgxSjdSTS9SNllMSk1DbmNa?=
 =?utf-8?B?cHFWcXM0VnIwaUJObGN2MksvWGQzV1B3VVlFUTVXeDVuM3pWQ0xrR3dMaUNw?=
 =?utf-8?B?bldKTm5mOVlWN0VoZ2l2N3luNmhqQXZTVHVyYVM5R3lXdzJZcG4xM2UzQXNh?=
 =?utf-8?B?VE1STkk4cmNoRkJJVUpaV09acmxoa2g1TjlMWWdsTVc0eStKTWN2WkJHeFU3?=
 =?utf-8?B?MjZKczFNekU2SDArMDgrTzBoZ2Z1RENDLzJLRlBGSTl0N3ZVaTl0czN3NHU5?=
 =?utf-8?B?eWlYRkFlZHNOUm5ZMElOaGcwQlA2N3hNY2pXSFoxWm5JRG02clJKWSs4QnZh?=
 =?utf-8?B?K0ZKSUplcU82bTVEZytyeFBIbWRHSHorSm9PSzZmY2FnOEJXckxQK1p6QTV6?=
 =?utf-8?B?c25KSkl1V0NvcW1OL3NIM2tqM0VacytoWkhZbTZhY0NTVCtRVjg3Nk9LZTBi?=
 =?utf-8?B?Z2JqS1ZqejRmTG4zZEJJMThrN1o2RXVSRlhlbDZHV214VDJDcGxrOVF4STdX?=
 =?utf-8?B?N2JTaWx0M05qKzI4ZFBiOWlhWHZBaXp1djlZWkVMN2g2S2NFMUJtOWtyaUNE?=
 =?utf-8?B?cUdSRDNCWm1OMVRXWFVveHpkZHN6RE9YTWpHMTJMbXBmdjBZdzlnOGxhcngv?=
 =?utf-8?B?R0N3VlB2ZW8wTnZ0WXRSVmFNcU9YVXpacyt4ZzdMalJJSDJxZmdUcXo0WjFh?=
 =?utf-8?B?djFZMHJjS0lMbWFMZStveHB6RWZUVFBXdjlRemhiZ2Myc0Q4Uk42NU1MeGlZ?=
 =?utf-8?B?L0tzYlczcXY4enRXT2I1WW80bXJYcUNTRzhYb2VXbDlRbm01Z0JYM1kyRnhW?=
 =?utf-8?B?aEpZcThaaXZGRno1RlRJZ0hQbGpEM29Gd2hCdkZMZ3dqM1M4bXZXK2swMTBD?=
 =?utf-8?B?aEhpb1gwdGFYbWFrVVc2eXBnWjZNaDlIajc3b1RUOVVselRzL3dVa0ZLRmNa?=
 =?utf-8?B?SGU1eGhwZHZoakxWL1M3MUhDZmt6WEhUNVY4THhyVEdlbGd2M0lpcnFhRnR4?=
 =?utf-8?B?OUt5Ky8xd2MzS1dMT3d6SlRFYjBadFNnZFllQlRkN3l3anR3dWV2K0p3QUtE?=
 =?utf-8?B?ZnYyU2tkYVYrenJuZ2dwbTBELys3QjJNYjNOWTF1ZzJiN1FCUTFZUFh2VjZq?=
 =?utf-8?B?Z3dmanN5elR3SWZraXdDSTJXNm44S1BPcTZiTmpyN0E4RXlLbkdMWFNlOWdm?=
 =?utf-8?B?R2xCamdxeVdaN2FBRmRIVnlpQm54RUdMY05lcEZ5THVBblgyMDVsK29qZlFM?=
 =?utf-8?B?dEpvT1RDWXhWdUNvckFVOTNPYkxaRTkwUTRRWnF4VFFRbk9wU2tOMXptYVV3?=
 =?utf-8?B?VTNUVTZBQzJHeTR6UkNoWVVPYUpRNnhwd1lxQjFRRGdIU2hRVVdZZ2NPZHBw?=
 =?utf-8?B?ejN6UStFMkFrelorRUJvdWdvRHU5b0Vsb2JUQzhtQkREa1lYVDZmV0l2TU9p?=
 =?utf-8?B?ZlBXa1hnVmQyVmZUSTd6UW5QdGdFVmJMYmljS0lzbEx5ckNpNW14a1FYUTJz?=
 =?utf-8?B?QVJaRUNxenRBOFlkcm8wTzZBWXFKZmc4QlFEbSs4c1Y3NWt4UG0wSG9ZdnJj?=
 =?utf-8?B?a1ByYlFYdWIyWm8yVXI3NWlLRll6alJPakx0b2RoK1Vib2NiWXVIQW94RHRm?=
 =?utf-8?B?aHk1bnNmZWlZa2V2NnNBdEtjR2RwblExVE1nR2NZMy9WNWozeGptOXBWcnR6?=
 =?utf-8?B?Y1V4WHRYeXg4clVNYVhBMDIrdm5iL0VwTTI2Y21GcVZXZzBFblFBSTBCZDdE?=
 =?utf-8?B?SmRJVGg2UGhha0c3UkhvK2s2SFNKMHpmbVJLbkR3YWpERVEzTGFIMElDSUpu?=
 =?utf-8?B?YjM0dEIwMW0vblVmVS9rVlQzdTlQRm10ekYvNUpZK0hwdGloamJubkdmbVgv?=
 =?utf-8?B?MjBSeXl4d1dQRnBOTWlKY0dPazFzeFZaUmsxREE0MThKUFBTWWtrMU1WSDM0?=
 =?utf-8?B?a2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+Me7JkR/0agmOOZ47bLuM55n3SUlgknzsmTYBwA2kindmkiJ9Mvsm+fNJNTOPFa9ZtwMkrxayIknZ0iY/IzWtdZP0ywWKHUTDGLPxU6l4kzbD/X4ZDUbeHCsS48Y2kwlh8WRQKAPXiIj1Bpitvo7e/S8Ik5g4h33aOQMqHfkn1gLxLi3VZjHstXVh8qwgdWpd53GIUobbmOX8veNLUCX0dW/uexP10FYEOHyZIAaOY2rwS2sC+mxVNhQtmnpO1VaOCLhhF6/v+YNbcZ0XKNaTNpEE5OGUZMnxYL8urOPlSLKFWL8H0Dt4dkmOHwPwrJU404lt48ayqSDXazqbKpwXtIXVXxpUWdUZQmXxClenX0AVouYiWavXaZ7cAPxPSZip5uM3Dgm8/VtB1HV3epMFO5jod2H5G+yw+nnJWUDBqZ3Dyw2ZAAxi9Fr1uzkZMQ6TbB7ZWq6XrLF+RSzuuug3AgJFfqedI9bx0KTzSISAJDMfqAGHfhIjFIweNznJXHKKAq7aUqaICgkFAgZos+jOHsNCjMeaxIIJHDn18wxteK18+R1pQO8blziivwufV9oWtXNWE+qf/ckDAPWTt/eXY+DF/MneM61TIb37LlUxUM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf7c434f-9688-4d29-c008-08dceee33072
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 19:37:51.9398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tvPpDmlxpxmOEzZnH1kVZbnHWo/b6yVYTEdSMNTFoXt+GZccgJgzJYoMGvEK1/h4M7Pc9Ow4Y/oDOy2nJIQ8Gnr81Wgz7CtGyStL9fnPDtA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4318
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_22,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 phishscore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170131
X-Proofpoint-GUID: CPY8A3mdsZJzdC4IDS_2M5UlC2IXK5ex
X-Proofpoint-ORIG-GUID: CPY8A3mdsZJzdC4IDS_2M5UlC2IXK5ex

On 10/17/2024 3:24 PM, Jason Gunthorpe wrote:
> On Thu, Oct 17, 2024 at 01:02:14PM -0400, Steven Sistare wrote:
> 
>>>> @@ -623,6 +639,67 @@ static void batch_from_pages(struct pfn_batch *batch, struct page **pages,
>>>>    			break;
>>>>    }
>>>> +static void batch_from_folios(struct pfn_batch *batch, struct folio **folios,
>>>> +			      size_t npages)
>>>> +{
>>>> +	struct folio **end = folios + npages;
>>>> +
>>>> +	for (; folios != end; folios++)
>>>> +		if (!batch_add_pfn(batch, page_to_pfn(&folios[0]->page)))
>>>> +			break;
>>>
>>> This function is really weird, why would we have a function adding
>>> only the first page of each item in a list of folios?
>>
>> It is only called when we know that the number of pages in all folios is 1
>> (user->ufolios_huge is false).
> 
> Oh, lets add some comments about this please, and maybe give the
> function a more scary name. batch_from_folios doesn't suggest it does
> something so strange. batch_from_single_page_folios ?
> 
> But, still, *why*? If the folios in the list all have 1 page size then
> why not just add them in the normal way?
> 
> I still didn't quite entirely follow what the ufolios_huge was doing,
> it is what I wanted to look at in an editor..

pin_memfd_pages()
    for (i = 0; i < nfolios; i++) {
         nr = folio_nr_pages(folio);
         if (nr > 1)
             user->ufolios_huge = true;

batch_from_folios is an optimized version of batch_from_folios_huge,
usable when we know that nr==1 for all folios.

But, it is optimized for a sub-optimal case, all small pages.

- Steve

>>>> +static void batch_from_folios_huge(struct pfn_batch *batch,
>>>> +				   struct folio ***folios_p,
>>>> +				   unsigned long *offset_p,
>>>> +				   unsigned long npages)
>>>> +{
>>>> +	unsigned long nr, n, pfn, i = 0;
>>>> +	struct folio *folio, **folios = *folios_p;
>>>> +	unsigned long offset = *offset_p;
>>>
>>> Let's make more use of scope local values please (put folio, pfn, etc
>>> in side the narrowest loop scope)
>>
>> OK.  Some like this, some do not, now I know your preference.
> 
> Yeah, I'm in the camp it is easier to follow
> 
>> I personally like to use local scope and initializers, but dislike when
>> cstyle it forces me to add a blank line after the declarations which disrupts
>> the flow/use of some quantity, eg:
>>    {
>>      long pfn = foo();
>>
>>      bar(pfn);
>>    }
> 
> Yeah, sometimes, maybe don't initialize in those cases?
> 
>>> I would like to see this patch when it is applied but I can't apply
>>> it..
>>
>> I will send you my patched version of pages.c off list.
> 
> include a git link in your next cover letter, that makes it easier
> 
> Jason

