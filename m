Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3111FB4
	for <iommu@lists.linux.dev>; Sat, 14 Sep 2024 13:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726320127; cv=fail; b=u6F12NQzo3bBJWFCwCf/DUHOLeLVYivLV/otXVy3dCTiGAEZxLnNgnfbZ+bfdnBl+W4SEb4OLlei7DEaRfOjx+5c31OHZC7KybFwlBizhWULCKKAnHVaVxq+d5nloLoO+soStkPjJ79XRGzzXBlhaaRVZBrft8MjrGylH9P91fk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726320127; c=relaxed/simple;
	bh=45q20yByabSkAZRmKCi1XskSD0uYarkUAu++pOPfekM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rzREKccvQb/3ydM0TcfINknaa9KMSIQ31cY9ogo9CVvRcNnCZtwAYECcrRwnu7/sCBzO5XtqLR6qQ/d/NECp3aI402jj2IToXP6t/QlZtiDVMG4Dz1q1CYLuGhIWhViNpK4FOhCFFCZHGJJEWLguHlwVsfMl3eQWJibr70YDnRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dxhrvc4i; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UlxU+q9o; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dxhrvc4i";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UlxU+q9o"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48EABXKD030783;
	Sat, 14 Sep 2024 13:22:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=1A9LMu3raV2MGAmj7c1e22/GCvpCiFC+wGaAQ/TZ3v4=; b=
	dxhrvc4ibonOTK7rU88Rj+nnM1syaT3u4LqtDwKl7l7WHTtwdvKlsTIeHdTvWSjw
	UhhbN+xjDYbzkfafaeOuAJoz0bjzgWNdaNm6FvwG/R3s/R+ToMt8BIYLAolvaopF
	BgZcysMKKvypmSC8/D1RsytTj/me7ihHyFueC8T3T87V6UNzD7ox+1M8EHNRvOR/
	4lQYc0dWc8Tn64u07lYKDPGgjTRcXGHGE93NjEWbl+TGlaAcQtfOVlbeAmMqWel2
	DK11eyUGH0XpGzmkO8poZzFhwe7tywjGQqMPoSQbMZVWq+tDdEUMj71cn49Pq5L5
	iEve0DvZnp+QzYs3ozoIkg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3rjre48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 14 Sep 2024 13:22:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48ED9eH0000852;
	Sat, 14 Sep 2024 13:22:01 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41n0x6jvmg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 14 Sep 2024 13:22:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQqho6SLOSvkkaO9JdQkijeri52Zx3J4TffCWlGMzEjy+1rKI/jpOditOkkCA8ApZ/25MjfP36yqJ+62/2LRUKO5EVLUHSqW2siFu5R8H82mGGQcc0zCVQTWL3OlXa6OzRsa8JmzMwUB66Hfye+qKCeuNwMyGd8QcJUuxrNiTBKJvvwS2isSMxljpY6ID52f9PnuHmYhXmt+5IZFr/uxyFPMXxwXZMwBMo4onk2dKFhl6gSZ2wbpZqq2f9scd9InUgFJq6gvNaWG1GdGrETOUHwUHtCkXoliFQ+KvAmEFnKi6dlCuSXu3vsZ784Z8UQQtni8O6+tiAVq+mN3pIJI+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1A9LMu3raV2MGAmj7c1e22/GCvpCiFC+wGaAQ/TZ3v4=;
 b=IIgZw8TKNuzTpC+AjgID2fNfcRDwcRPjUFTdV1NCOBc6yL3g6Un1jK6M9Iile06KQ5Z+ecTQaLx0O2atT6xueNiSP03rwZl/LK2uMoApFc3WAeb1NJQfe6DLdLlUcU6DGsUfjejGNte42z8DYXtEIDjS5qbabsVQls9zEDuErT3MdrMVfuIWUmcptOH/qpawzudwHqbUSYjRT2MCiNRGTz3BQ3OPeunVAaGJioW1CzSOV/OHpWjx8D3R5KB+9JBJaUdqqnIEkwuBCUoy1PDz6dd4yQRtV46r0XrA5y0Ec1cqXCYeViJF0simAY32cCMgyl+5w1rpj910lS1lpJh4Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1A9LMu3raV2MGAmj7c1e22/GCvpCiFC+wGaAQ/TZ3v4=;
 b=UlxU+q9oPkrOG+ptl4jK0RJZGC4PZU7owrz9H6xeUhzEq9gYMH1B/XlupH8MmbrvUby8oCUsRAd5AQA4iEFCRwDcL8xmLh3PlYR/PBV5NEk+3dstEKli3nlTEkltr40+3mnN+K6OvyTIoIUXOBt4GgHXMNED57iEekdpb3sd68g=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SA3PR10MB7000.namprd10.prod.outlook.com (2603:10b6:806:316::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.10; Sat, 14 Sep
 2024 13:21:58 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.7982.008; Sat, 14 Sep 2024
 13:21:56 +0000
Message-ID: <74936c15-7373-4427-a851-3e450f41456c@oracle.com>
Date: Sat, 14 Sep 2024 09:21:51 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 0/9] iommu_ioas_map_file
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>
References: <1726319158-283074-1-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1726319158-283074-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:208:c0::16) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SA3PR10MB7000:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cc20018-4adb-47fe-805d-08dcd4c034e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEI3TkMzN1R0TlY4NVhkZmhFajFZeHB5MTJ6akt3QmhaRVgxZmFqY1ZMWkFN?=
 =?utf-8?B?bnZTYmdVTEYyRnlpK09ZbGtxOWZhVDlmSzVadTY2Qk1Zckl6R1k3MjlzVTNX?=
 =?utf-8?B?L25FZHd3WWVBSk9pS3Fxd3NNeFg2QWZjLzdxb1ZaSStCeGVTby82YVErS28z?=
 =?utf-8?B?RzZTV0V6aXFQOFVTQmtGQlFnd1JKczNJRGJ3RUVRaC96d1hvTkNaRzNxdExC?=
 =?utf-8?B?M1hna0U5cDN3MThTY0RMdkVleGxhMjkyRzFJeHhiR3FiWVlicHlrc2lPQ1dF?=
 =?utf-8?B?ZTV0endzVFZjR2xUMnF0YjkxUHdCT2xTaGdmZ0dPN0N3ejdHZ3lNZWs4Rjg4?=
 =?utf-8?B?YTRHdWQzOUV5WDA4SDNSWmpsSUcxZDZOUGx0UjZxcEFJOHlOditVUE4xQTZD?=
 =?utf-8?B?YnpPdmozNDRSWTB5ckp3ZzA1TzY3ZXBJbGt1cXJ4ZDZZU1lxdS9sMUFseGJV?=
 =?utf-8?B?emtON241Q0tJbkRWb1VGdHhJVk1DSFMyb1BGYU9Ca1h6SEJaRCtRZXpnNjlZ?=
 =?utf-8?B?UGNYdWM4bVVBdzlsOHRQSFVTVWRqU0JVOEpsSVBQdnk4K1B5OFZKZkkrZUVT?=
 =?utf-8?B?cVllT1JhdktQdE1HRE1pblJucCtwY3FVVEdzK2EvS1lOY2JEWXBsMlZHcElR?=
 =?utf-8?B?VE1KWFY5NzlyQlFlVEt2LzI4aXZFcjJyaDVxUXlWWXpXMUUzL2d2L2RUMC9C?=
 =?utf-8?B?aElCaHlOZWgrb0t0TVRtYzBlSklEd2VXNFk5bmJLWHRKcEptTWFKNnRUZEhr?=
 =?utf-8?B?YjZjNFd6SUxVSGF4YlpMdzQ2VmhLdlBJNXV1dmhCM2pCZVEzTndpYXM2MU8r?=
 =?utf-8?B?VFZyRHZlYjhmRzRpRUhibTV1Sis5TVpkRVMvbDRGU3hJK3c4S0FXejZtS3Ar?=
 =?utf-8?B?OG1rUW44ekZEQ3o2ZndwVVFNVHZ0VW9CUGgraHBuY3RhNUw4ZWozZHAvR3Ra?=
 =?utf-8?B?SmwzL0hSc1kzVGhFblFLcWFXNnpLZ1dvQTd5UUxONTBKNnU1OGlCckpVc1Vk?=
 =?utf-8?B?YmRkeHJQUUMvUEpVUEh1enhENFhSSjJWMnNHcWIvZGVWZmp2UmxSZDJ3OXlZ?=
 =?utf-8?B?NFZ3bnhoaDFRcHFnRnJIUzRSOG5WWk4zM1YyaW1Ra0JjRGZIYXJ4dHY2R29S?=
 =?utf-8?B?VW9mcTNUbnVCaDdxc2tJZWFjQzdPRWNuTzd6Q2tmZUNwQ0M0eklmcW1wK1N4?=
 =?utf-8?B?bWhPRllvQU9rTVZYb3I4alNma1pudmxHVWJ6NldzOUI0LzZsSElHVmlmRVMy?=
 =?utf-8?B?bURWWFI0UUpxYzhmYXlST3d6SjRxb0x6K21qcmtwUXFURDJJQU51MFpPRjdx?=
 =?utf-8?B?UVlWM003VWtHdWRtUlFJdk92aWNna1loLy9hWnpIZ1h4dFVrVGZ2clJ6Ykxp?=
 =?utf-8?B?bjVPa1d5dFRkbVFjQU5KNVFFK2tETVc0aEhCclNKbGgwS1E3eGNQcFMrTnI3?=
 =?utf-8?B?V1J5NVFXUEtQSlc1cEN0WUhKSEZPYkVEVyswYWRQNTJzc3FoRlNvc0Mwb2ow?=
 =?utf-8?B?STBqdVFtcWpvYXkvSUY0R0VqVWVISFFDVUxpVUQ0amhZL0JMYlZzVm9ZZzU1?=
 =?utf-8?B?clh2UUc0bmZ6NkpTQVprOUhyMFVKcmE1dnpqclM5SFJBQlRJYVRBOGlFZHdh?=
 =?utf-8?B?d1IyakpnMlJPNVZDZTF2cW5MOE5FVnZwYlVtRGE2STIwZUxGUUU0RXJYWEt4?=
 =?utf-8?B?SDh0czdFUmlSV0RaNEJHb1lHN0pqYmIxMjJnK2xzbVk5RnRDQ0FVaUV6NTRo?=
 =?utf-8?B?YWtab0xUbjl2Q0pHdHBJN0FiK1JGZTBhb3dMaU5wU1hUZEZBVnUrWUZTcjA1?=
 =?utf-8?B?V2Urb1pRV1UySXJRMzBZQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEpweEVIeU5aWUtUZm1BWVh3cmJKS3AwZ1J3c1gyMHRTV25NT1NrSTlHb09Y?=
 =?utf-8?B?WUk2TVkvbkRZditlb0RsWVRhT1RMU3lyWU9tQlBpZVloQmdaWEZzWnpZRFFh?=
 =?utf-8?B?S0F6MzFwUzNGaGducnphUTdhN1FSQU13aXhhdDM4eWZ2NzJhQUROWDRXWlR4?=
 =?utf-8?B?VCsvbW9EV0RVZFZnbnd5VW42ZnlSRUxYdFh0ckdQaG9DUWpwOE9DNUxraXhU?=
 =?utf-8?B?SVV0V3dJZXpDWU5Fb2gxVGU5OWoyWEpNdEMyQlZqdVFpeU53UXg5SzE3L2pQ?=
 =?utf-8?B?Sjg3NzZ0V0wzeFVKL05HUVpRbEdYeXB2SXQvelBZYmJoN3ByaFFPZDhEbUJP?=
 =?utf-8?B?Z1pJZndYckVuZDR3Z2Vodk9OM0RtbkdGNmpmTXZlblZvTkVJY2dPRStVN2Jx?=
 =?utf-8?B?TFdWN3RkblJtOEVyZTNOc2dGcCtSRFNCdEx1TVljYm9GZGtCWUM1Y1Z4QjFI?=
 =?utf-8?B?ZlZhaFNmUjNyYWtNdytjUTVKV2dteHRlZEcwdU43ODNvM2pJRVBMMUtlajZQ?=
 =?utf-8?B?bmdiQkpYaFc0K01mWlh0STJTVnBtZUJhbFNrOTBjNk1tSVhOYUVxMGxRZHRN?=
 =?utf-8?B?Y0tQRnowUDVLSERSYjFGYVVnOUpCenU5VTFKMFVjQ084Z0tVQzdvb3FUckxB?=
 =?utf-8?B?dUpYVG9CL0dpdFRBellLZEZqYjh6RGFxOFo1U2N4TmRPc3FjK1JUSGVMcTRO?=
 =?utf-8?B?R21FUkVyVGtOQnI1OVpTK21Ba3FtZWRESVlRRGZwb1RtaU15VG1Ma2lyaHhn?=
 =?utf-8?B?cXpzcVhYZExwMGFlK3MrSndrYXpVRUJnRU1WK3k0TG1HOVZ5NlA5ZGplYTlX?=
 =?utf-8?B?bHJTcnhDUnFXVGgwOVdFLzFlSHNyazJHWWttQ3ZLTEZqUEhqTC9tOThLRFNj?=
 =?utf-8?B?dGc0SGhuZG8zM0dNQW4wZG1tVHNVY1BHUUZpdHJJR0JrdGkzMkdPL2pnTFpQ?=
 =?utf-8?B?WHcrK1BNdzgyZGpvRzk2bFZ4SWlHdmZ6ZlVRMDViYUx0YUpQN2oyUmNrbE8w?=
 =?utf-8?B?ZG56eFFKN2hOSXc4UFdwQ0NNYlJuaHZrZHVZdUYzS1F3MzV4WkE1TXcvZDJT?=
 =?utf-8?B?R01hZ2FTdi9HTm9pQVBhT2NnV2NYMXk2UU5pTldMSitZM09IRnV6Y3NldEQ2?=
 =?utf-8?B?MDNEV0Fnb3A4MHdFTVN3anRUbmpsRERrRW9JZmF1aG93VTNXYitSY2dQYjE3?=
 =?utf-8?B?elppbzBTQVptSzlaMm42VnU3OFE0ZjBXWUFlc1hoU2pub2ZpREIyZ3NGekRQ?=
 =?utf-8?B?QkdMNzVHeVk2bVNyQlZJbmlEK0VVRUd2NFRFM1daQkxHZnhqcm1NeEROWXN6?=
 =?utf-8?B?cThyMDQ4eGY3TVczeURsdG9URloxMkdwRlBkZEZjOFVWN1lWQ0NyWTNac2J1?=
 =?utf-8?B?eUxQZ091Yk5NUi9rWittaDNDczBFQ0ZxdlYvaWtJVzRlbzRXVUlEcnlNQzE2?=
 =?utf-8?B?c2VGcGZRQ1RLeVRXQVo0V2tJUE85WmZpeG5pOGNJSVI3YWRwZGl5bno0eDNT?=
 =?utf-8?B?ckJpT3hqbUl2SWtqKyt1N3d0T3QzeTYzYklWMEhiTU0wOER4Q2FSQ2w2Q1Ey?=
 =?utf-8?B?VHg0WnJHQTYvdGEyWllkaG1seUFGc0JISnFrSG8wTzg3QkJNdzBGSlRHYmU0?=
 =?utf-8?B?a3Nuc1I4b01yd2hHZzg3VWZNVkM3dUlhUlVVSXcxQWNqZytJWUJpWWNyMjRr?=
 =?utf-8?B?ZkpGQXhYMU1JZHpuUGg0YU9DWXlvOUF6d2M0NVV1OVkvUEFyRHVYSWQ0MVc5?=
 =?utf-8?B?M3lNbE5zbm5LNXJzQlNCVHQ5VnJISXA3WlBUKzdzQktIQ3BnOU5pUEpMVWJZ?=
 =?utf-8?B?cUJ3WXUyU0x5WDY1cVpWR3p3TzRISkxkU2cvQno0RGFGdmhhODQ2NWsyb21Y?=
 =?utf-8?B?SU5ZZ3lnL0x1T3NYeUpRRGkvempRSnh3ckZqd254eHBtcXU4TE1BdWdCQnJY?=
 =?utf-8?B?OWM1cTFybHQ2TFRwbTlzdVAyOG5FbHVBY1Q2TURxUUVTbmU5WFBVNnRZaGtU?=
 =?utf-8?B?cXBFZ0d5Y0VIV1lrQVgwR0dxYUg0RFdtY3hZS3kzTU9lMTBRaVl2ck9sSitn?=
 =?utf-8?B?K2dSekZBbmZkcjQ4b29YMExackVkWjZUYUtwQ3JVS1M2UEV5WEFwTERzVlla?=
 =?utf-8?B?bDlObXlESndFYzFQZzFrSmlwek1UWlBzdmNMMVE4YlNyRytOR0EwbTlJN0FB?=
 =?utf-8?B?TXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FENgW8A3SfuIs7kLZQer1Ta2xa0MixqJ/cMDi0C9gYscmKQbRIPzyl03qNb4yc0DNwNgSBX1tc8jGetl/U6BI0fwoFa3foZA1g5dfq3uW+e2i1nXuRWRn4dspzX07eaLqYcN6wKf+pbg7QnZJsjkONmnUISK3SDNYPdOibKCUeDcmor7JMuioRxUMfn+v1WJg9Z7uT2EaCaUBfjPhibRW6sx6raL38+c0NjD/eVr0/FKtuHaoI0TKohtvyFkgt9dKPU/2erIDT9VtOdte+ibLN8R0bcrVddwxUMq4yke0jWZ92Qdw2LuB7DPpXA6YvXhQXdR5P7al4M9wBqapTWzruXSa5tjCsW6y2T4Iidpwfz3NOXy5N4xxOK8RuxtrIJjP2RT5gUQrmsNA89XTcEFZe0wam/ui6uUowSuH/k/17w9pF07/SekRMe+jJNHLTTgXphISDucN8qtvQbid6Ay5BX0uU6R2PDkEEWzBQ2b3qUMuNQ797RTUAWs9/iQziEVipa4ZdIMgjdnXjL+/CFCcUzFvIxjGoc1Ekv8P2XgHw3Qzmi7YXLO8y7GzXoYOHpDuTbL+6+nLZu0qllq0LdeOb2/R5AdOtlmNosAamCUSIQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cc20018-4adb-47fe-805d-08dcd4c034e3
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2024 13:21:56.6846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s7Y045n/tuvoTlDyWaYU0T5eeI9jeWMGZK1+rk7gVdwIEE8nd6cltB8Q6t7/rOHN54wRH1QsI91QR7YY1jHkN4uQ4W1tif42dN+NX49uUpM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7000
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-14_09,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=846
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409140094
X-Proofpoint-ORIG-GUID: N0u-xaxbjbxNiqNA32uv4TGzMZ27yKmi
X-Proofpoint-GUID: N0u-xaxbjbxNiqNA32uv4TGzMZ27yKmi

I forgot to give credit, this ioctl was suggested by Jason.

- Steve

On 9/14/2024 9:05 AM, Steve Sistare wrote:
> Provide the IOMMU_IOAS_MAP_FILE ioctl, which allows a user to register
> memory by passing a memfd plus offset and length.  Implement it using
> the memfd_map_folios KAPI, and the proposed repin_folio_unhugely KAPI.
> See the individual patches for details.
> 
> Steve Sistare (9):
>    mm/gup: repin_folio_unhugely
>    iommufd: remove uptr from iopt_alloc_iova
>    iommufd: generalize iopt_pages address
>    iommufd: pfn reader for file mappings
>    iommufd: IOMMU_IOAS_MAP_FILE interface
>    iommufd: IOMMU_IOAS_MAP_FILE implementation
>    iommufd: file mappings for mdev
>    iommufd: replace upages_len
>    iommufd: optimize file mapping
> 
>   drivers/iommu/iommufd/io_pagetable.c    | 102 +++++++++++-----
>   drivers/iommu/iommufd/io_pagetable.h    |  20 ++-
>   drivers/iommu/iommufd/ioas.c            |  43 +++++++
>   drivers/iommu/iommufd/iommufd_private.h |   6 +
>   drivers/iommu/iommufd/main.c            |   2 +
>   drivers/iommu/iommufd/pages.c           | 210 ++++++++++++++++++++++++++------
>   include/linux/mm.h                      |   1 +
>   include/uapi/linux/iommufd.h            |  22 ++++
>   mm/gup.c                                |  18 +++
>   9 files changed, 354 insertions(+), 70 deletions(-)
> 
