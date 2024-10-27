Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79981684A5
	for <iommu@lists.linux.dev>; Sun, 27 Oct 2024 14:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730039929; cv=fail; b=exwH7/29FxU0F6lDvpQtxIdM31O18DTlyMDcoPnz0mB639NxGdPx1/ulFWCtM8sH4q5D5inmSTywwnKzQ9rgGda8NxMuNCXOLtUjVl13gPhZNiTGNUkSBEEt6tzW9dRJ4bor3dvuXDd3y9sy1QZ09+mBFL7snKAXmsrm8nghSZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730039929; c=relaxed/simple;
	bh=TF04ZDJsKtYtTpUcglRtEPauWOOwev287utJvakjeE8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OaOW2lz0n+Q67G7Z+mlsdS2ka9u8JNmOxEgajiDgBLYzLMrFZc8lbYb+KULWmljGw59i2U/KN4A3XLlYdKtEPQapzCzGBXlgvsTZO4Vd0nMy7Aoz3GDImBM/eAjBfeezAff/POQWtHrX+rd9HV5ln3CfnPL6Rz6E3k+M4q1Clls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DISgi++F; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dzua8c8L; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DISgi++F";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dzua8c8L"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49QNu9Rg028165;
	Sun, 27 Oct 2024 14:38:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=2I1BrCM0+PUKi2hjVgNLOettErFxXuvi76ZNC3f1jY0=; b=
	DISgi++Fca/n0WCAWEEnj6/GStB1XCvGAg9/RSJVYe8jpcYfzEoPVH2VgclNpf72
	u1PnKGI2TBFnZVxWSPuWRxdsKjomITklmN2tPpP02VLO2h6hY/dhKKzFh4Ra1kBv
	acBKSmN+zRxvENHHJLTe81sF81pkv7w09fVs6DxpWziHzHsslAan4Mf2iOROahcd
	riZXQWk9xmVYD7t7c7qH1DMc0E5ezlkeSY00KxC9YqIU4xkEK/3sQVfGf5lOO6s9
	vZl2OjYfw7AtSmTRQk0eZOhY4vITfwWwEmb28Pq9Uf0Fy2x3r3ila5Zz0PfCMThM
	STcqcKqGExo3Ns3dJxHtWQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdq9bx7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 27 Oct 2024 14:38:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49RCKItU008838;
	Sun, 27 Oct 2024 14:38:43 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hne71qwu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 27 Oct 2024 14:38:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MZP+9ssBwHCeMPxlO9Hvov0tep3BdrEFVSPUqstx68zkxwAGxBdNOobXVjpUtri0yT+oCXtcJVriNFjAb/QMWV/6fAqFDelqYdgdKpEj/PJZaomJTRwJn0i4kein1CrPiROqA4RABd7ZluwWX3bUw+T6iHIBVzx/okAPcibc039eFUL5gK7AVpa+DS6Jfr2PYcN2uYYyG0EyOd2quOYIIPVzkgEOsULLM4z5tJZjcv4/kdh8yPbVKbdRtK9i82NInRRRHI7qRvGU7ajLWrpAdOW5VZn52wfRIbaGrm1nQJPtYG9IAJIbGlPIqi6X3YnemvNBFiIkpG8VCxCFKaSWqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2I1BrCM0+PUKi2hjVgNLOettErFxXuvi76ZNC3f1jY0=;
 b=taYgha1XBS+pLaOkOb9awW+R/5kjZpDZLIC2myysuNwC6Cv1XdsqH2a86yxfgL5xMtW4ymsoU8bNvpP1Mj9WTy9/T0I7LmohcQFrKmAnCnoX/Q1EU5SuKhfOfJolLMT3+AJOINLExlaojbtlIwsbGDlMJTNXSkagxwjazDDBcjHqlI0Udxhf2eHcHJngVVweEI/5F2igTL/2yY2V4FUdb4DNl3dEUXXTJuwvyB9Rb4Xun1/uGHztesmJJSEZWoHZGZQmPTOUrhY9VD5tp/hCsJojDc3toRy1YlLQyRAy9XswpoXTdermvPUE4SBscvzGdQKX+dNryExgQi8iWCowSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2I1BrCM0+PUKi2hjVgNLOettErFxXuvi76ZNC3f1jY0=;
 b=dzua8c8LJicw3hJljbclbTh6XzOceoIDOlxbwi4LE6Fac9QNoBcvhvUTTYyAYrZuBPc+jxWjpEhKdQx7lgyh0NUfLZWSPY7IFOg/CkD1NfzAamxM5E3EXuukWt7T6QdcaCcueME/R/Rm2m/zX6/qJtpIfWGljhDA5iN/VG4NE2c=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SJ2PR10MB7600.namprd10.prod.outlook.com (2603:10b6:a03:543::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Sun, 27 Oct
 2024 14:38:41 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8093.018; Sun, 27 Oct 2024
 14:38:40 +0000
Message-ID: <2949cc3f-cd0f-4929-b5df-0d0b597e1a2a@oracle.com>
Date: Sun, 27 Oct 2024 10:38:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 9/9] iommufd: map file selftest
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
        Kevin Tian <kevin.tian@intel.com>
References: <1729861919-234514-1-git-send-email-steven.sistare@oracle.com>
 <1729861919-234514-10-git-send-email-steven.sistare@oracle.com>
 <ZxvPhQZOBR7g56eh@Asurada-Nvidia>
 <2c7edd3b-61c7-4012-b825-4972c0efcec5@oracle.com>
 <Zxvl7J0mWkKPS4GD@Asurada-Nvidia> <20241025235849.GL6956@nvidia.com>
 <37483959-3ff1-44fb-b3f5-f1c0859de1ef@oracle.com>
 <1af8d6b6-6640-4299-b279-eaf943707664@oracle.com>
 <Zx12sBalOPZBlZOm@Asurada-Nvidia>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Zx12sBalOPZBlZOm@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR20CA0040.namprd20.prod.outlook.com
 (2603:10b6:208:235::9) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SJ2PR10MB7600:EE_
X-MS-Office365-Filtering-Correlation-Id: 73d2d934-5569-4c81-d1f2-08dcf6950cec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MHE0WXN6cHd2bWdRMXNrcEZWS0tPaFVWQ2dZL1JNWjRHUXBiR3B6bkY5Y2dP?=
 =?utf-8?B?YUs2THZBdXBwd1ROellUcUtQNXRFSGN5ajJDa2V4VVFMWStleWU3V2RST2g0?=
 =?utf-8?B?T0pHUWkrZndCTmpGMFVtK01kNHlrUzIzZFZwZThMNkVLbVA4NVZEbmV1Q09q?=
 =?utf-8?B?NDdKT1A5cXJ4MHE4Y2J3TG5lakpVZ20xMzZkQXNFUWZiOFNUT25QVWd0U2h3?=
 =?utf-8?B?MGlaSnBySHkwYUZRK0hlSjFvNVpqb1ZLUmM2YlAvNE90bzlKdytkdy9STVVD?=
 =?utf-8?B?NzZReHFTWVFLL01IMm9ZTm1pWkRRQzhFdG1IVWRGeVNEbEwwdXUvbTZ4UmJs?=
 =?utf-8?B?Um5TY0lIUTFmM0ZWNjFWVVVSbGNMbGpGKys3ZlhmRGxudGNPMGxvSzR6WGpY?=
 =?utf-8?B?S0VTdWdCQmNJZ2R6QUFSbEVXWXdZSm9tS0R2ckRZZHQ2Z1dKOW45L1ZNQytZ?=
 =?utf-8?B?S0x3RDZkQ1lwaDRzZGx1M0hKQWQzREc5MXhXcUdHdlNiYmxvUEJ3Z3ZVL21U?=
 =?utf-8?B?OHpVdnNkNFJOUGlJUEp6Qm5NR2FmajFFOEEwV21DRFliZDFONUpKdThwMDdw?=
 =?utf-8?B?WEUzQkQyT3ZnVFA0SFY5MnVrL0RQTzRUdytpYWVySEdJVVdmaDhxM2gydnVo?=
 =?utf-8?B?REsyV0hpdzdJR1RCNDVrN3ArTU16eUptcVNXMEY3amJLZnNJWHR1Y0JFK2Ny?=
 =?utf-8?B?RkZVUjM3a3hRZklsNFc5Z284b21KeWFEUU5pbzJKcmZxOWs1bFFyRHplY0hs?=
 =?utf-8?B?VExIN0pOa0dmQXQ2cndvY2pPV3VqOEtxdHN4Nllxc3NINmZYWkJUR1d2Y2t1?=
 =?utf-8?B?VnZJUmV3a2hSWVl4L1hGWDJxWVdGUnhDZFhZeEFTakxhNSs4enNMaDBPSGRy?=
 =?utf-8?B?QmJSOWdNU3lnVllEcVFOQVJ2UUFtRTN1YVg0cHl1VFV4c0IyTDdXdVR6Q0d0?=
 =?utf-8?B?YUpHK0tDNDRzM2RjTlNTL2NJOUJDalkwVXdwbTY3eEVjZk9xdENsMXRoU1J5?=
 =?utf-8?B?czR2eTNxc2JmNUgzYURxU3dOR3Nmb0lqZ09HQVNHL2VHRUVJTENURHF4ZHFN?=
 =?utf-8?B?Sm1ZT0JkOUg3bmxsbDR3cWdOekx3L2VMS1l1aEZ1eWZ5VTRTU2x6eDVsQW5N?=
 =?utf-8?B?aEdSNi9EWDJXZUVYRC9LbWREZy9DYVMzbkc5L2ZzeGxsRXgySXFtdVl3d05K?=
 =?utf-8?B?bjR1eXBDWFFkSGowSnZnc0Zqc2V3Sk16ZUtwTDdCbzJFMFlWOW9QdGswd3pS?=
 =?utf-8?B?SjlBNVZrTWRYMUsyeCticENmZm85aWtqM3I3bXVWSVNrd2RnY1BoYnRta1Rv?=
 =?utf-8?B?cVBxeE0rMjJ0UVNORDV2dFZRTUZwM3k2QXY4cEJnWmxVeDRwcXBhcVZiSlFR?=
 =?utf-8?B?dUlOZVlyYjUva0FuMjZFQ1pVZW5yYi9WWGdQTWdHTWZJRFFvODFyOEdTNW0v?=
 =?utf-8?B?NStTR2Q2MzNkU0NxdFZaU3lhdWtURzRML3Rya2JySkNPNEpCTTA1Zm9HK0tO?=
 =?utf-8?B?bDJ3WnlBSmcrV2ZmbTgrbEIzam9raEEzUnVWZmNEdGdCOXJFb2hBRWVqdzRG?=
 =?utf-8?B?b3N1T1J2WmlYLzFmMy9YS21YODFqVGJ5L3dMWUg3eDNPNnRwVmtLOFJLN1RQ?=
 =?utf-8?B?UkRqQTJPMEVnU2JURnE0VERiRjU5cklYcG1nRnIvMFZqdEZDSTVKZEk4UU1F?=
 =?utf-8?B?Y0RZNytjSkhqOFBwV0NFZGJwT0hZU2I5Vzl6U29XRnVCcWRoN2JhRnpwWFNZ?=
 =?utf-8?Q?eY0quNqmJkpnyJ+rB4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eld3WnJZbEozenJFU1YyTFpEa29MQk10NnJJRWZsMWI5V05qOTA5NGhza0Vl?=
 =?utf-8?B?MTJDdTEySWFRWWdjQmhnTFloaFFETGxnUE5uZ2JjZ2xnL1JUTzc1TnJxZGRj?=
 =?utf-8?B?MUlseU5YWkpuT2gxSGRJRG1pNmRDVFltSlA3bjBkTGFoVlh1Ynptd2ZXK1RP?=
 =?utf-8?B?TlBTTmFZUlo2QkV2RkN3YkRQS1gzeDBaYk9HRVNsYmc5OFNyb0k1amdndEhC?=
 =?utf-8?B?QzZnQm0xeW4vM2gwMmRCaVZlMTAzSTZsazE2UVdNLy95TlFXTUxDbWhoSHB0?=
 =?utf-8?B?bk92Mk9XVWtoeGxaT092blhNRmVvTGpUdktFc3gzVHhMbHF1M3dyWFgwLzgv?=
 =?utf-8?B?NkhYQkx4a3FpOU45cnlzaEJ1QUhlWnY3dHU2ZlRjcEZBRWdKK01IdVN4S2px?=
 =?utf-8?B?ZndmaW5SNWt2N25jbGFjczFjb21vTVlzNzdaQTZ0UGNIa3l1UDRINXhLVjNE?=
 =?utf-8?B?T01KVkVOSlBiVzNuWm5WeHV3QVdVdDMxQzFGc0xPd2RIQUNwYk9TUUNGUDVX?=
 =?utf-8?B?dDBVQVRnVUozK050VTFsMzlpOUMreVBpZlFtcXFFWVNDUTFXeFF3RUllem5n?=
 =?utf-8?B?VWZXdDRmcW1Zei9GZGMxWUFqMVpsQVRhOVNXUWEwS0hHRTRRdVVjRTJheHly?=
 =?utf-8?B?S0FIT1RLM2lFVVFneFZGazQxZEJHMDRyYnIwNU5pcFNiK1R6OTNWT2p5d3Ur?=
 =?utf-8?B?WElsYlgzYWxOT0JaWjZjVDNRd1grZVpxclRPV05iWHhVblJlamhuSFFYd1ZT?=
 =?utf-8?B?ZFdOeUF0UndqWFBrTll5Zm9ub056V3FPcG9ydzhpU1U3UUZ4Qm5hc3hoV3NV?=
 =?utf-8?B?UlFnUDdrb1dZeTRza09XVUlHY1lNYkwwMTU2NU9hcEo1T2h5em8wMHFXdG1O?=
 =?utf-8?B?OGdLemVrSFhFOVE1cFVkeXJmVENuQlIyalowMXpQWk4yVGUxdzhaaUp0Rjk1?=
 =?utf-8?B?Y01uaENHRlRzZmsvTHJOS3R6YkpZUjRkMTUwWmRiWEtkaWRHQkFWa2tkNzVh?=
 =?utf-8?B?bHNLR3dhc2k5SGtNVHBTbVFHWnlnTFQwbXhDZGtPckVRTktEYWdLZTYvWk1k?=
 =?utf-8?B?RmNONzBwOU9BM3FmN2F6M1drOStycThIY1JNN1htVnBXY3RnRzNoNzBxZVV4?=
 =?utf-8?B?VFQ5NU9mYXlHa2pyU0FqbUtiU3hGd29Ta3ZWRlVocXhuQjB5M0N2TDJJcC91?=
 =?utf-8?B?enI4SkNQaGJ6akJWb09KemVmdlkzb0xEWC9LTWw1VWRCOGtoOHhnWGxrR3cw?=
 =?utf-8?B?OG9IclRjYzRLSnNMRy9seTR2aU1xVytmWmRuQUVBdGxEZWl4emdnaXR0cnVC?=
 =?utf-8?B?V0RKOHE0dFdHZGc0cnMwNzhBd2JqdGRPR0cyL053QTY0N05yY21adVh5WWo5?=
 =?utf-8?B?WHUrQUIwcEdHVDZHK0NGSVU5OFVxMkF2ZGZMRWtLRzV0Y2xyZGw2RXNjZzdZ?=
 =?utf-8?B?dUNqNk5sRFpiWW5jV2xReFlOYWxzNVo4N3RHRzFOMVU4dzJPbVVnZnUwOCtn?=
 =?utf-8?B?UFB4dnBYNkl5eEVoM21RVXFMSThYM2cxK3JBY0VIc3R2R3pvOC9DbHVPcC9X?=
 =?utf-8?B?VjMrWVpmUFErY1VZcmR0Q1pzcU1JM3prVlhwUENvbm9Db3lJb1hxU1NiVHdn?=
 =?utf-8?B?TWltTGQyTHY1ZEp2Zkp1MDJqY2lYNVR2bEY1Rm9pajZOSjZ4YjJHMHkxeTZK?=
 =?utf-8?B?WW1tSWRVS3JHdkptZ2dpTVhmMkoxNU1WUjE0dTZMN2pvU1RpNXF6VlptdlZ4?=
 =?utf-8?B?akdING1xNkhzRUVVcGJIcHVnT0dtWEhVOUdzamJLNkxyUS9TQU0xOHhudCtL?=
 =?utf-8?B?WU8xRUNWYWRTYUw3ckk0UWxuQ0ladW5lbXpya1huTmdBV3JDOVJNSU11aC9I?=
 =?utf-8?B?djdaL0pySTNpcGtTelA2T09XNXNDenNMSVdLd1Q3SjRwc0N2WVpjT2psV3Vv?=
 =?utf-8?B?c3F5NHV6cnZxM3ozcmRtelBrK0h1T3ZsYUxXNU9Ja2dTcUp3c3MxNlhXSFNT?=
 =?utf-8?B?aTl4TEtXcEVpUU81U3lHNFVhVVZiUWd5a2YwMEZhM2hENmdaamFEdHVsN1RP?=
 =?utf-8?B?Y0ZSMGpCY3EwMDBNZGQxUFQzWkRNQkZpZVo1Wi9Ub1ZjaEtrd2ZwZGR0NFI4?=
 =?utf-8?B?aWxteUJ0S2VOb2xIMGxvWWh6QzFjVFdoNjBlVXZ3T2VqSWZ5VVRha1NJYzRB?=
 =?utf-8?B?K1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/AhOC+9+j06HCOllQrqPf2G66AA0LlL9ew4u8P2JR2S1DPkgEURLX7mRh481jiGLpQQEOHjaU8gLITxgouwTgoMaWQGnE4q2of+aIX37GtgFym9guRqdohEzwU5myaDz6aF2msnb8Tl4G0jw21XNygDEU5srqr5mWJB77wzZHPkZPX8Mqo0EuI2PtASneW7uOQC4eithaKOImaw1k33Yu2P8DxvSuph0XbQNZLFjlngE8JYNzL8LkAk7k8mVDo+W1YG/U6pnXmhRmqFz/R28PY1q2y58wfGZkIlB+V/fBYXZi6kGYsK6m0PN3SHfmDZh9m5yei08VbgxOyRD5zk98ps/6/kpzkk5L73xbgVfNUhRG8XucsAM93QgybBkjY4SCNp755IkEY9204SdhKkzFtPvhMlUdd75qzC0t+KhxtPK5Dr0ONq9sO5O1DCq7XmBPzNzpUzoGlxyCEw+jpbBdveOhqHYRhN0vCJDQ0rLFTE3GuM9orJaD3oINMqbBm+nMxKEOZNmqeJl07w+EtTh8u66GfMpuapF2ZYBd/aL4Rc0QriPcO9lA/Ayf3BfVrcwiTP0igyW4Z1KWRJhw9fZNfIVSDInaFikiuoZddCq1yA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73d2d934-5569-4c81-d1f2-08dcf6950cec
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2024 14:38:40.8633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EIAoLvhoWapZnpdnr7JBkKeNC11O6XDv/hNOihN1vDiVSfmHeWyDN9OiMJb4GpL2TQJF5eFm7DgdyqEK5j3CqjTJb3fTs1MvURwziwihsTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7600
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-27_02,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410270128
X-Proofpoint-GUID: pYS0f05WB5HXSIiQaPAJYkCWFtuH9Oge
X-Proofpoint-ORIG-GUID: pYS0f05WB5HXSIiQaPAJYkCWFtuH9Oge

On 10/26/2024 7:09 PM, Nicolin Chen wrote:
> On Sat, Oct 26, 2024 at 03:16:36PM -0400, Steven Sistare wrote:
>> On 10/26/2024 3:13 PM, Steven Sistare wrote:
>>> On 10/25/2024 7:58 PM, Jason Gunthorpe wrote:
>>>> On Fri, Oct 25, 2024 at 11:39:40AM -0700, Nicolin Chen wrote:
>>>>
>>>>>> I will try to reproduce your failures.
>>>>>> What is your base commit?
>>>>>
>>>>> I was using the for-next tree (rc1) from:
>>>>> git git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git
>>>>>
>>>>> And it was failing, so I guess rc1 is missing something for memfd.
>>>>> So, it should be a false alarm.
>>>>
>>>> Oh, that's exciting. So I will have to base it on a rc that works so
>>>> bisection works :\
>>>
>>> I'll test builds on arm to identify the minimum requirement.
>>
>> BTW this is likely an arm-specific issue, because I have been using
>> for-next rc1 on x86, and all tests pass.
> 
> I did a clean build today. And it passes with for-next tree.
> 
> Looks like something wrong with my yesterday's build. Sorry.

No problem.  Thanks for letting me know.

- Steve
