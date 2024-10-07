Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48D71DA617
	for <iommu@lists.linux.dev>; Mon,  7 Oct 2024 16:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728317927; cv=fail; b=ulL93i1xglGnfxAaVeKnIFJ//ZAUBUe44Hr0UtRJtrvGsXBC6nLvpjrSqFn406C7Ohkc4jWn6QVwnPrgLXCB7k1xMz/SUUXW127JfTTave+es5QG71qQNsHntyy7ZDLR/cmNCzj102GpTU8mh9lJCGI/gu2zaXrefi43X7xNyRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728317927; c=relaxed/simple;
	bh=502YczJPXGOJ5Ka6QgewiRGVqZqJYs1MA627/frgvw4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sOlGhBwJtCc5BZ3Q8PrgtvonY7B76ZPWluSjpaY1r+bDwpUN+i46Wi/YpOKMUDcwj+Xd76QjFpndRArU6kqmPJu1WHD+hvES+8MUQ82GhZEyCtz+vQ8fjFcBa9HY2j2mqX3cEfkdxDtgmIoko+oiy7Q5l4yZW7HSOgYvBhcPDGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HSAqPZ5s; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xJNn2GVs; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HSAqPZ5s";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xJNn2GVs"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497FMcE7005083;
	Mon, 7 Oct 2024 16:18:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=aLEKH1oZTzZ4slxcqifoVkVwzwOCYuHKxEayOjGwSZY=; b=
	HSAqPZ5s/nIwV0XzXztNW1YlSIYombvp8iBviqFAxvkrvvsjG6pZ9kb430vtEfJA
	R240Dh64CGaNKwDOi7ijnUbITx3fg/Neu3sF1kxLO+j1MD8MrdMPnjAIP4XSOQ5z
	inWuWqK01Va1w/3UqCmKcexEnOPpZ4XkP+3+YH2rjwCrI5WZdpUScYEVaLbiY6ms
	5LS61PZV0TPQPV5Lb70xyoVAOtldFt2iYeOzwCczK6NNueZsdytmdfEA8F8x2SsG
	qIh9mtNgQ8Mc/uL+C6IQp2IovvXjkZ/PwL35Et35UZSrE9SxNAk8+aoKQYUD80Xk
	sfX6PqWAwaj8BarE0Vz9dw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 422yyv3tu6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Oct 2024 16:18:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 497FiTRa024252;
	Mon, 7 Oct 2024 16:18:42 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2044.outbound.protection.outlook.com [104.47.74.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwc976r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Oct 2024 16:18:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EyT4qmmuKTuqxjuvJDv8aw1CpqufrZwy7WYANBCdvtsH2yuoKseYScjkp+ToX7H9FSEc9XDNIsntTwPixbJpL7UghNypS/1Z+GeVSILXpnTmWoDa53gmrRWx9ZLzNkvfQniWUuHNKWTMsXGBZksWj57gCHZzqukMaZvS+GHjcuNlYYxaeGIg3ek3+3JRdHOtagQiBAPgtX8YTi22vT9d1/WM3oMy0i8knuuXig5C5At1mH4Dpi2D73YhjUH+bBdmAyRC5+qEaOPfajrKcOFA79ovN76SE6Fi1fmodk8HAYtArt6hjfYT8ds2ULmsbhammFhLBlyy2qc8kzzPKnfkwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLEKH1oZTzZ4slxcqifoVkVwzwOCYuHKxEayOjGwSZY=;
 b=ykx6IO6feCKVJwjkMMV11+tRh/pFu3vTeEDSLk1WBFrNPNwNS3tS6X7mcLZ7tfNkhT4A5rXMABChlGc3/0JRZOvwG6PyUN36Y6YI6y/1KczHHsgfcwGriE9JzlQHUWfSmFBE8f1HhOoge4uhKwZYiMlHuGd+CPrDcvlXsda0FdlMWusXOkoqHKBS7mcgNt+3SUW422DwhOqUPQyGgbEGYPj1dG3t5mPWCsEXmGSBz2ZO9DddkSmCSlEiH/v4DvM+rDdRDPyPN9reqJImYscSlX9Mr+Jv6v0saRvUG4nYvFiLraAy9FBwdajvo9PUJMJdgbIRaMu5jaQWESdIYX/K1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLEKH1oZTzZ4slxcqifoVkVwzwOCYuHKxEayOjGwSZY=;
 b=xJNn2GVsDA2WsY7qeCPPIblcisBi/uIEkquMf4/yzNLwzqi230wkoZPB/rCeq1Y14rFlhRu6fbEICWqIC9URrY+uX2YcTpLLQYDAYDXeZ4NwiysJdj7nxbO7WoYDntIq0FjPyTuQpvAZ6vCxb4DV52xNkhOQwbE1E9IS5zOvWrY=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by BLAPR10MB4979.namprd10.prod.outlook.com (2603:10b6:208:30d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Mon, 7 Oct
 2024 16:18:40 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 16:18:40 +0000
Message-ID: <62312948-e733-408a-a42e-7235dcfcb0a6@oracle.com>
Date: Mon, 7 Oct 2024 12:18:37 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/4] iommufd: Lock all objects
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Kevin Tian <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>, iommu@lists.linux.dev
References: <1727358828-97791-1-git-send-email-steven.sistare@oracle.com>
 <1727358828-97791-3-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1727358828-97791-3-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0424.namprd03.prod.outlook.com
 (2603:10b6:408:113::9) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|BLAPR10MB4979:EE_
X-MS-Office365-Filtering-Correlation-Id: 2583a6a8-0c76-4bb1-60be-08dce6ebb49c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Tmx3R2gzK3A0NndEQkRFenZxZmVHRkJNK3BGUmk1V2htcStyS2tVTXBwWkdO?=
 =?utf-8?B?OHBtVjFrSHNRSlBrVkpETlRhdUdNOVYvSWgwTVhkSGhnWUgzZHJyQzRPS1hI?=
 =?utf-8?B?K1p0MkpSdDBTR0dqMDBrcUhBOTRzTlhoeWU4SVlGU1FQRUlVOGdONWx4WEw5?=
 =?utf-8?B?NG9yT1R3ZDJVYjlFR3JWR29HK290WmZ4dHNhcVdPODNZTm95dklQRjhuTGk5?=
 =?utf-8?B?M3liVTRHKzZ3SnVvSHNLbHUrL3U1eWhXYTJtNWc2NmpIRFJFTGd2YWxrbEJr?=
 =?utf-8?B?WVB5YU5pY2FzWjZZMVNFWm9SeU1ucGwyam9FRUFqNUs3TkU5ZityMjkwM1pZ?=
 =?utf-8?B?SnJpMjJOcE5Icmh2Z3hBOWJwSS9POHZNN01vcWg5NGhJN3ZXSkZmK1lkOVRt?=
 =?utf-8?B?THdlKzJGOSs5ay96RFJMU3NWaXFlUjRWRkRVNVpTc0VMV21BQ1VCNGFKKzVk?=
 =?utf-8?B?dGlzMmMzL1dHY1I3L0ZsQ1gxZWFuUU93anI4WlBjRURPV1l5cGVxelIrdGtQ?=
 =?utf-8?B?UG1xSXBWQlJrTzBwTzNSMTRIOC9Kd0hEUmxnOGNzS0xNZE8zQ3hFclpUZTQx?=
 =?utf-8?B?NFE1QTlGeC9obWNzQVJCN0NtbEJ4aVluUDhhNDVMUUpGejNsS1N6VHFScTVR?=
 =?utf-8?B?eG5aMGhyWXNYREVjR0kvV2Z3ZHRLbUtIV0xLN3FLdFdndFJ6RkRWRkIreE4y?=
 =?utf-8?B?STdlZ3FPZXJwQUwxRlQvUEY3cHJIQ3hzcmd3RTY1dzdhTnJkb0xXcjY5bkhW?=
 =?utf-8?B?ZmRmNzE3SXE1VXBYdmNBU3pOc25SWFlYVkhSQnJnMlpDRm9uV29aR3dzQ0J0?=
 =?utf-8?B?NlhNRmNJQVJJTTRYM0hpU1N6NytBTHRqQjl5eXBwaGxXeDJvU2c0cE1oQXBM?=
 =?utf-8?B?cGxVVGFkMmRSM0pWOG1BL2pvWWlJdVdaR2tQQzEvMEVWZ3d2M2pFOStZcEhH?=
 =?utf-8?B?dkxKVWxmaEJURnZvQW40aFl1SHBBRlhQQjNxVlhyU1lQVXFTTDZkUFdOVXRs?=
 =?utf-8?B?YUN0VWs1dHpPdEdEWnRqTkJQd21uNEkvOUVHSjhRd2hRK2tIMWVKWjUxTEk3?=
 =?utf-8?B?dTgxcGN1TlRFbmp0N09ubHphRnNrZXRKbzJjM3VCbnZsdHpid0c4R0NVNlA2?=
 =?utf-8?B?VExUZ3o1Wi96VnZHb1NWQ0lXQjJIeGlrdS95RDEzTm5kQ1BKOHJ5UUdKWDRk?=
 =?utf-8?B?UWN1YXNvb1ppNkhNRXVxWm5lUkVxc3FqbHh3ak8zVEQ4MHE2Z29CYVpRWnhv?=
 =?utf-8?B?V2JJamVHNXozNk5DVFBmdzdpcVhDa2tOUFM2Tm1iSWVOZHlwU0tYenVGTWtL?=
 =?utf-8?B?NlBwSVFLa0hMUzFwL1EyMktNcGdkR2lRWk5SQXN1SGRpRzZSdFBnRG9GNG9F?=
 =?utf-8?B?aXdhUDVOSjgrR04ycW1QUXRPS3l3ZlhFUWo3ZXgxNnlMRjY0cU5DQXNxZ0pm?=
 =?utf-8?B?eUl1eWxnYWZ6RWRjUEZuUHFLRm85b2E4Z21xcSt1bUFLbEVqMGdtZU55WDFO?=
 =?utf-8?B?TlRtK2MvMjVuM3NUbEIxcHp4eWtKYUZRZVVia3VOZHhWcTd1OVRsRk0vaEla?=
 =?utf-8?B?UnZRd1QrRXFmUmVEZjBHaGN2QnJPUnl5Wk85eW1GNmpMTDZta29Bd2lHMmgz?=
 =?utf-8?B?R2VZSmdvZXRuRm5tUXVXNit0NmVUaXY2R0xJY2w2aHBLN0N6TlNpVTA3L2RW?=
 =?utf-8?B?cElBUlk2YklWV2Mvam9ZVHAvamR3UkxSMVdHZHAxN053bmM0R3ZRejNnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWVzNWpZaDgraHRWUldIeGIvV2p3YnZtN1VCZXN3R2ZyK2d6anB1K0JqM3ZQ?=
 =?utf-8?B?eHNsanR2K1BweGJNYjh5Y1RTRlVOV2NmZFdFNEtXbnZ3bloyellibDZWWTJP?=
 =?utf-8?B?YnNpZmVTUDZXRmp2dVNrQTBkbWRzRjEwVk5pb0hqRnNEVHZ0b2J0VU5TcVBt?=
 =?utf-8?B?TkpMeEt5SGIwaUFKbDFpUjRycTlIQlAxTHdrajJodklFSUIrN2FjVWFWYmdl?=
 =?utf-8?B?d2U5QThFYWlRQ3A0LzluVS8wNWdYY1diTjVaOUFQQVBUdTFtbmxEOTl3d3RS?=
 =?utf-8?B?YW9Fb3VZWWVuZVpaNjNqMkxFRGJ5b283M0VsOTVURURSeFJmK3ZhWVdEcEk0?=
 =?utf-8?B?cy9OQm1lWGRZRHJWVmpCMzlwdjJndlJ0c09JeEFQVDM4SDZhRTFPNWNYRTZq?=
 =?utf-8?B?U3gwcXJNc3kzU29zR3ZobUFBK1JLcUhNREJ0eE1iVzR6OGkyb2VZRTJmOGdh?=
 =?utf-8?B?SjN0STdKcnlRMXRoa2w3ZXQ5UU93eW1jMWowY3Vubll1RGlQZWEzT09VanJW?=
 =?utf-8?B?Z0s1Y2t5S1FINFVoZHhFMnhET3FYTGxFcXFHbmJVVkJnZ0NTeFhzSmdhM1lv?=
 =?utf-8?B?N0UrWVczUDFRYVYwcXBFVGtSTU11dmZRLzJnanNZa01KRksrc2cvcElaV1lF?=
 =?utf-8?B?eDRYSys4RitVMC9zT01SM1V3UVM5UjNaam93SHpHcmtmZm94T1ZmaE1OVEJH?=
 =?utf-8?B?dnhqVmM1UVBIdmlHRm16SlhFTXRZMW5TTndzREtXZHVrLzJiYWtTTFdwSmx2?=
 =?utf-8?B?eVZrY0hsWEZ4UUxCMGZEL1htWm1kSzA0Qkk4RittWHdzdHo2bTQvVnBLc2lx?=
 =?utf-8?B?WCtwekJqcDRjbnY5Ni9CbDFMUmI3SE9iMWlOdnVlbStkNFViMVV6RDh4MFJy?=
 =?utf-8?B?M3dFQzE3UitKcW9PZlYvNFdTYWFRSm40UWppY0R1MkYwQm5XcjRwUlIzU1kx?=
 =?utf-8?B?TTZOamd1RE9QWVdmQmI5bnQvMXNpTmdERlZEL1dFN2RDRk9FUURieFVhOWR1?=
 =?utf-8?B?c3NZYncwZC9wdmlJZjZ6b1Zxek8xcmd2dG12cFlZdzY1akl4RTJta3RXcmpX?=
 =?utf-8?B?eVM2NlROMVlEK0VnZXNhTjNYZFpXWjlrY1ZxRmFISHV3Zm1lWFA0T2Nwd2Ro?=
 =?utf-8?B?azFSZVE2by8vM3d0cDNjM2xmbFcrdytrWmdwRWhBUDVDNGhKL2NIcXN3eS9s?=
 =?utf-8?B?RlNYa3h4dlpqemU2SDBvZ1pvajJtdVc4OU40WEE1YUNHNG9oTmFHY3NSejZS?=
 =?utf-8?B?VGpEMlR6Ymx4Rm4za2labEcvZHZ3YkxUdTFoUnNvZThSdkFrSEVjbFQ2SUVC?=
 =?utf-8?B?UDZqWnQ0anROcUQybVdnL00vTXdWVVpSWVRCcUNpTHg0WDhXa2FyWHZVSXJE?=
 =?utf-8?B?clVIR1RvNFdnTUdUMm1DY29MMHVOV1BxK00wajdhZDlubkY1VDJ3REJnb2pH?=
 =?utf-8?B?c3lOR0lHaUUzVVByK0RpVGc2ZEVyYjhHSk1vRCtlMmRsQzhMTmhQckl2bzlh?=
 =?utf-8?B?ZnpRL0ZKOUdDRms4NjA0UXVPaWhKZTlVQ3crb05ZOTVXMzJpTnQ5WUNzdHhh?=
 =?utf-8?B?S0lxa2FCbXlnMkVsQi9OdHR0ejZSZFA3TkNRSWtDYzdVbjhWNkJndlZiaDBK?=
 =?utf-8?B?UzZSb0NacXQ5T0FoOFRYdzVsTGdNM3FuVTI1V1FGYmNuQ2hIeXVnMU9PS1hO?=
 =?utf-8?B?YjF6azdzUkdMMm81dU5CNmNVOVhwYk4zVXZUMlJKQmdGNkFmT3ZXQThXZlpB?=
 =?utf-8?B?NmV5OGFqSWFobU9UelpPSXZQckRyUE13UjdaTGxpdG5pSUFpa3UrOG1oMUZy?=
 =?utf-8?B?ZGErOUd4UENLNzhqRmcrYXJpRFA3ZTBKWjRsbHVJV1Jwak45ZjJXRkhJM2xN?=
 =?utf-8?B?SzFjSlJTeHZTWjYwcjlLRzVPZWRtMks0Rm9JanNXMC9CVTNXU3hrNjNsRFZE?=
 =?utf-8?B?Y09pM05lWkZvTmdLSUJhdG5jdXdPZWZjOWlIWkgxbkhWM05hT28rbnQwR2o3?=
 =?utf-8?B?bGhEZ2RLRmQ0RkFkSitMQ1p5Q0NCUVNQTTAvNXFOYXpIMVl1QXNSbXpIM2ZM?=
 =?utf-8?B?aHF2VVp4TEJIMzZDeGtUU3hJcEFYN0ttUTJzVFZVWTMvcVBRaUFwbGxmdEdP?=
 =?utf-8?B?Uk1BWXZKWTY2UHZuY1ZSaHdDcithQ0JNdm5vNVM1emNlWXk4WkRZZlozQXgx?=
 =?utf-8?B?eGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jRhOO5cIbpgHVJLt2YFdeLkBjZXEGOuNhwWsCxpTtB5PO2hMlYo3GAaEB8HHtenhvkyvpYbRQCkYC90ponshQfhXm1jXLyPANEBT7Iq0TfU5ny6Ty6tIgz62LJk+JOlNFIqCb3YRHA+v/7BiJNtExuQ8LPp1sph2VxJMMO45Mbo1SIVlXclxCqg14v2p4D6PisfCsF2bEPr4dHJkSv0QWzFuqH+IKniE/QUyKiyajAcwfrY49apXPoAeL3KsGczCifnZiVnrDUU9Q9ZC6OjaWxGCnuc0F8dF5bNSsWkr3EtafHdxzxk8tOiZoH4m/d1z4S5zNtnfQ0/TKP5Zu+7AEd/DVKZz9gj+qWF0WL7k3xvp4FP5hyH42szZKXysuUqP6DnBFm4Yu//iQ9bK6/l13jf66g3LPywoL3QqcSMOcdjxLU9zL/DexOLpMl30fslNpd+LMmUFAMBmZWUCX0j1whMCXZRQj8kS5CJu4zSJ19ieiafsuwm7WuucmcqSD53sV0AADUnwopavcD/13K8fNbJoOnSk5iiO9zmkKd8iaK7HqM8NcjBXmJL5dVrCvKtuSS12InhOt83EXQUFhtZp20qfd1EHNGisHCxy/fb+RGg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2583a6a8-0c76-4bb1-60be-08dce6ebb49c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 16:18:40.2894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9oyM8ARXWhNgh6J28dHck72ro/yE/RdeRE797buAQslnH2Yn+0bJ9SJyCHIaWoUcF93/D/quxGU3s8+zwIyGFFwjqyspMuDNtVZK3ghJt5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4979
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_08,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410070115
X-Proofpoint-GUID: mIhv0F5nW8ryByAcQZFGaw9UzlPibTav
X-Proofpoint-ORIG-GUID: mIhv0F5nW8ryByAcQZFGaw9UzlPibTav

Hi Jason,
   Any comment on this patch before I sent V3?
There will be only a few changes in V3  in iommufd_take_all_iova_rwsem:
   * delete lockdep_on/off
   * replace
       down_write(&ioas->iopt.iova_rwsem);
     with
       down_write_nest_lock(&ioas->iopt.iova_rwsem,
                            &ictx->ioas_creation_lock);

- Steve

On 9/26/2024 9:53 AM, Steve Sistare wrote:
> Define helpers to lock and unlock all iommufd_ctx objects.
> This will allow DMA mappings to be updated atomically during live update.
> This code is substantially the same as an initial version provided by
> Jason, plus fixes.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   drivers/iommu/iommufd/ioas.c            | 67 +++++++++++++++++++++++++++++++++
>   drivers/iommu/iommufd/iommufd_private.h |  1 +
>   drivers/iommu/iommufd/main.c            |  1 +
>   3 files changed, 69 insertions(+)
> 
> diff --git a/drivers/iommu/iommufd/ioas.c b/drivers/iommu/iommufd/ioas.c
> index 2d25ba0..8eb869d 100644
> --- a/drivers/iommu/iommufd/ioas.c
> +++ b/drivers/iommu/iommufd/ioas.c
> @@ -52,7 +52,10 @@ int iommufd_ioas_alloc_ioctl(struct iommufd_ucmd *ucmd)
>   	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
>   	if (rc)
>   		goto out_table;
> +
> +	down_read(&ucmd->ictx->ioas_creation_lock);
>   	iommufd_object_finalize(ucmd->ictx, &ioas->obj);
> +	up_read(&ucmd->ictx->ioas_creation_lock);
>   	return 0;
>   
>   out_table:
> @@ -370,6 +373,70 @@ int iommufd_ioas_unmap(struct iommufd_ucmd *ucmd)
>   	return rc;
>   }
>   
> +static void iommufd_release_all_iova_rwsem(struct iommufd_ctx *ictx,
> +				      struct xarray *ioas_list)
> +{
> +	struct iommufd_ioas *ioas;
> +	unsigned long index;
> +
> +	xa_for_each(ioas_list, index, ioas) {
> +		up_write(&ioas->iopt.iova_rwsem);
> +		refcount_dec(&ioas->obj.users);
> +	}
> +	up_write(&ictx->ioas_creation_lock);
> +	xa_destroy(ioas_list);
> +}
> +
> +static int iommufd_take_all_iova_rwsem(struct iommufd_ctx *ictx,
> +				       struct xarray *ioas_list)
> +{
> +	struct iommufd_object *obj;
> +	unsigned long index;
> +	int rc;
> +
> +	/*
> +	 * This is very ugly, it is done instead of adding a lock around
> +	 * pages->source_mm, which is a performance path for mdev, we just
> +	 * obtain the write side of all the iova_rwsems which also protects the
> +	 * pages->source_*. Due to copies we can't know which IOAS could read
> +	 * from the pages, so we just lock everything. This is the only place
> +	 * locks are nested and they are uniformly taken in ID order.
> +	 *
> +	 * ioas_creation_lock prevents new IOAS from being installed in the
> +	 * xarray while we do this, and also prevents more than one thread from
> +	 * holding nested locks.
> +	 */
> +	down_write(&ictx->ioas_creation_lock);
> +	xa_lock(&ictx->objects);
> +	lockdep_off();
> +	xa_for_each(&ictx->objects, index, obj) {
> +		struct iommufd_ioas *ioas;
> +
> +		if (!obj || obj->type != IOMMUFD_OBJ_IOAS)
> +			continue;
> +
> +		if (!refcount_inc_not_zero(&obj->users))
> +			continue;
> +
> +		xa_unlock(&ictx->objects);
> +
> +		ioas = container_of(obj, struct iommufd_ioas, obj);
> +		down_write(&ioas->iopt.iova_rwsem);
> +
> +		rc = xa_err(xa_store(ioas_list, index, ioas, GFP_KERNEL));
> +		if (rc) {
> +			lockdep_on();
> +			iommufd_release_all_iova_rwsem(ictx, ioas_list);
> +			return rc;
> +		}
> +
> +		xa_lock(&ictx->objects);
> +	}
> +	lockdep_on();
> +	xa_unlock(&ictx->objects);
> +	return 0;
> +}
> +
>   int iommufd_option_rlimit_mode(struct iommu_option *cmd,
>   			       struct iommufd_ctx *ictx)
>   {
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index 0ebb5bd..06a52f2 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -23,6 +23,7 @@ struct iommufd_ctx {
>   	struct xarray objects;
>   	struct xarray groups;
>   	wait_queue_head_t destroy_wait;
> +	struct rw_semaphore ioas_creation_lock;
>   
>   	u8 account_mode;
>   	/* Compatibility with VFIO no iommu */
> diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
> index 5f77ce6..13ec031 100644
> --- a/drivers/iommu/iommufd/main.c
> +++ b/drivers/iommu/iommufd/main.c
> @@ -248,6 +248,7 @@ static int iommufd_fops_open(struct inode *inode, struct file *filp)
>   		pr_info_once("IOMMUFD is providing /dev/vfio/vfio, not VFIO.\n");
>   	}
>   
> +	init_rwsem(&ictx->ioas_creation_lock);
>   	xa_init_flags(&ictx->objects, XA_FLAGS_ALLOC1 | XA_FLAGS_ACCOUNT);
>   	xa_init(&ictx->groups);
>   	ictx->file = filp;

