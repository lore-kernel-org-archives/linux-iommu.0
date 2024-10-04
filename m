Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A321B4F21
	for <iommu@lists.linux.dev>; Fri,  4 Oct 2024 18:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728067937; cv=fail; b=mlL4SuvtkhmbesgnpYEiOZhjxyBjEThgusAA8r4jCKagBakuYlgxtUNLzevJPMa1UyqodgSagLwZpqnCQkJ9kssUGoTTCKrCqx9SXFDY9V/M7hFE1dxEcitc1CDIoNUp3N4yzeB8pBXlBGRz0BZvxbCShEIPhd39wLKYmdiyYsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728067937; c=relaxed/simple;
	bh=A7zQB/M5yKlGX6hXYgVbulp+7qRUXa1GmSFbEE0UoYQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LaQ3XcDd1ySqQBGaXAbsY94Cl9xBdcMedKXTLm5kW7Loc69dJjgOgeN1jSRH+ORcHI1c2RtiS3E2RNLd7VZfqg1f7Gckn0rfIoBfepIQwLlC7k2woCr+GjkNGTT9WyOA6zkl7ufO08CJgYMziOjIWxaveylTLIp/AAdWGi4imjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hM/ayi4A; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PgCG1GKw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hM/ayi4A";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PgCG1GKw"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 494HfbN2030393;
	Fri, 4 Oct 2024 18:52:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=HRxDaGE1YkvOeqIWwSGXgxnabyvdJanPWCIhTMdGIns=; b=
	hM/ayi4AfakBsqv6u4W6Prj6ThEYgQ2yRxeWjnFhEWUmSZviglpLD/ZIVHukN4hL
	+aEscKJ2Z9uh1NXTD/WJcMow3CuCbWBKH2mlhBAQOF8X8sXPA6F5+qq3lItfV44c
	QOuDJC7UL/xjmYBTV0poT79YMTUsKeCBvcIaZln1ASz9mx6r2q1NczHwZslGk9MU
	cWdWwnlT27dS1L/QY6fM5yAUu4et1prUzVtm9JqmUUnehjnIYmiZm5uwtE5tBt6U
	DmTuU5fE3B8Bh/iFQQMTf1TJPGkbO06FX0IS+Tqe3XBL9rGfIlkyVu2o+uA/3W8y
	v+gkhRaNeautCrOQCQ8XeA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42204b29wb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 18:52:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 494In9ve037249;
	Fri, 4 Oct 2024 18:52:07 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422055f13d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 18:52:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wdK67EB51OLYHDCQstHb9/OUEKmm9qsXb416zCGPyQkbcgWyITP6TZXVUGZqX00BQkrRtUB9cMobO7Me17clWA0QMI2m3axUqs7t3P5x1zKvJ9nW1wgbMbLVa4/DiTrN15KQbfDGrNsFQAKdx1nDHINY0CEsELojL2/r6yqWk3QPB5GCGpn0Iq8b9XCFPQIW+i1pHNfA4XBxq+yDGfSXDEriVWR4LuJpAiBMILdeb0fgM1dCxnskeQp9fCZxOwSpCWlUl2+5m3n1z6ty04xzr4Fey0rtdam74RUiNUY03kALo0C0bNOlN59ldsdcx7TX8A+yKpAXcIEz6s6IXTsq/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HRxDaGE1YkvOeqIWwSGXgxnabyvdJanPWCIhTMdGIns=;
 b=G2gBXq2CU9xJvbrq/Rl5EBiR+qBqy7to4givVAoopNOfb1ANXCc9Z4OeoLpL/bkUEwwN+JkcX/eGOjijiaK+Jf+jC46No7qvJEkUkSDqcYVe68O/BevWOOA4Gt0NjsYud7vhWinwQCNi+MeOgkfYDtpxVe2oYnxkjAsS1KIRbsIBjnOZAcoLpqXMB7B9pprkIC9dJoz2TNqsxaRLt84C5mtZyX9fRPNCASTaVe0qmLtA3RPd0VezvfmvCXoT0F0ge9AH3XRsYRWPkRA8WlN+BfcRlgaomu7iW1TlIkhQ0IjO7QWl2m3ozMp59yuxwvp5ihU/iIz2pJHON1yghaLe0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRxDaGE1YkvOeqIWwSGXgxnabyvdJanPWCIhTMdGIns=;
 b=PgCG1GKwCCwbx5fVAZoWbMFf98wSmfekAZLAIhVjwz2bitErSkuosUqo0+45mU0BPzwTxX/uq2CxrB4xmZOO1lcXMkr2E//7mgfqArbfPnDesSioFEg9fm5OTa1SmCFUSc6UJTRPl3SybylWKdP5nx1xgfQO4pvGcKp1wx1/0Z0=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by MN2PR10MB4368.namprd10.prod.outlook.com (2603:10b6:208:1d6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 18:52:05 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 18:52:05 +0000
Message-ID: <53b4b083-f238-432f-a59c-61d20d03511f@oracle.com>
Date: Fri, 4 Oct 2024 14:52:00 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/9] mm/gup: folio_add_pins
To: linux-mm@kvack.org
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
References: <1728067700-32092-1-git-send-email-steven.sistare@oracle.com>
 <1728067700-32092-2-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1728067700-32092-2-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR02CA0054.namprd02.prod.outlook.com
 (2603:10b6:408:e5::29) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|MN2PR10MB4368:EE_
X-MS-Office365-Filtering-Correlation-Id: 10cd0b13-0d01-4a54-30fd-08dce4a5a3e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QVZKUXlxZWthNi9yM2d4Z3JGSnl6WEtPeGNoQXJZQi85aFpEbFMzYmhOS1o3?=
 =?utf-8?B?ZGhMUlQ1QllNa2N3N1RhMWhRT0lUc3FXMjNUaEhhckJ0UzJZbTRNMkR5Tkt3?=
 =?utf-8?B?Mlk1TU5XVElXVnRyRjV6WkZaZHFvVU1VV08xVzRoWDlMVHZkWFhmU0tGREpz?=
 =?utf-8?B?WkhLbjJQT3hVMXo0REF5clROUHZiV01xNUpPZ1ovRTdQV2NWbkp1amlUWEtp?=
 =?utf-8?B?RXZxeFNyM1lZRU0zQkw0TjJPNlNSUnhJZDZnVnVZTDg1M1hDVmoyWms4RjRt?=
 =?utf-8?B?V3RUUmNYd1RheDlGSFYzbW94QkQwbUJVTGNDVkFMbXhyK2lNa3pGZlNVUlUx?=
 =?utf-8?B?Y1dWR2ZEVHNSN1BQdWNuYVNJM29yS2RCYnFyQ2o5UnBocXRoLzB4cUkzVXln?=
 =?utf-8?B?alkrdW9FTlBxdlg0N0dFYkJLb0k3V0x2Q2phZGMvQnZ2Rjl3T3VzM0FaVmxt?=
 =?utf-8?B?VGFQNzhHcEtseUNxYjZqc2VYN01kWXpOdnVlSFRpMjU5TCt3VERiMVRZZ0Fp?=
 =?utf-8?B?WE5vT1BmUHVXWTB4Nzg1MWF6Nm1aVjlFQlFBejlaOW1tTDdlOExUQWdESjNl?=
 =?utf-8?B?RDk2em5kZG41V0E1cDZjNkYvYWhkQUJTMDJkVGx4aEFmZWJVU0NmZ3V3T0pn?=
 =?utf-8?B?R0hsRzlQWU8waUlSSzlqWldkd2VVdUJjdCtZaURwWk1PUGhRVU9ocUJ4ZXBl?=
 =?utf-8?B?TEtqVmRUUXdyZnZ1RG1YWVpWbnY2Z1Q4ekdwZFFvRDFkOXhrMjY3V0N6S2JG?=
 =?utf-8?B?cjFYeWFHNnlKWEt0SFBJWWZKSWVSRWRxZWpQMU1GSWJxaWlmZDhraGorRkpV?=
 =?utf-8?B?Zk9adGVXMDJUT2pUc25uR053OE5ZVWpLbm9jM0pTd0dmYS9YODB3SG1GVklt?=
 =?utf-8?B?SEJtV29OOTMyYVl6NGxBVEtNMHcyWGhhL3lQVThSTDk4eVNrNHVwRDBEanVl?=
 =?utf-8?B?cTlmVW5zUzlPdlZ6V3prWTJicFFjZUtGb2c2RGRvdFZORUJDVmpJTzhJVlJL?=
 =?utf-8?B?d1Q0S1c4WkNaSWlwUmJVUXRVamRlL3U2VFd4Rnl2UDNwMzlpeEtna1VrYTJR?=
 =?utf-8?B?Zlk0ZHRYVy9nZUhDMXhkNUR0eVUwalpqWi9EdHpKeWtQV3FNckxaRXpXdjdX?=
 =?utf-8?B?QWVIc1dqTFdnd1JYQmJjTHROWEZ4Q3oxd3RBTDU3UnFNVmEwVjZiWm1xdXZQ?=
 =?utf-8?B?bkNNaEYrWml5VmF4SGNoUkVJMmEweFphbEkwWGcrak01TFI1VDdGMU1EaVVN?=
 =?utf-8?B?UHpiSDFOQ2FoYkY3SURINHROeGxuRSttT0ZYWnBvblRRTWxYQWFybTVzSXNU?=
 =?utf-8?B?cG5INXhwa3hwWEtDMER3RmRQaWxscXNrQ2JVVmtzK3I5R3NtYlRxeHBQaE16?=
 =?utf-8?B?czFqR2c1dEpVWmpUM3o0RVZDSGx5RnhuMzJWQXBWVVRHblI2YUtMWVFRZ2ts?=
 =?utf-8?B?UERnNkpPc2RUcnZ3ZytuZ3IvbWVoR3ZnQnRTT2tHcnVwc3IySEhtNlhPLzhr?=
 =?utf-8?B?Rlkxdlh2WDhERWxuWmx0Wk82bWd5UW5wTDN3Z2pWVFlyT2srREFPVDNXcElO?=
 =?utf-8?B?WVdwTFhKaVA0aEtKOGFVMkFnRHV1bWhyQ0w0UEhBMnViYlR6bTZscHpXeXBB?=
 =?utf-8?B?cWV2Q255dlVhMkdVWkwrYURpMGRObGU4Z2F3WnIwVmxlOGxjKytHSGh6L3Z6?=
 =?utf-8?B?L3VZV0ZKemVNbEhyWUVLeHFkRWNuOE0yd0l0UytIZ1RkUDAvV0Q1dlRRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHZIcERna2JxWGk5OGg0MWp3a0ZrTWFEOE5Kd2ZCWlowYU0xdW55VUxhcjYy?=
 =?utf-8?B?Sy92RDVWL3M0TU55a1FGT2IzQWJtbDBTWDUwQ2k4NFdhMFhzZCtQTzRCRGVi?=
 =?utf-8?B?QzluL050ZlZkZk1GZ24vQlRJYVJ1N2trZnk2dGthdERTWXRLelYwcnkyU01h?=
 =?utf-8?B?RVFmSHRxYmlFSkl2TXhLeXVPcXlZeVBWWis2cnFkK1VZSUNONWl1TFB2dzRK?=
 =?utf-8?B?NC9lakszTVl6TzdkNERuYkpBS0FmdXdVYnA2ODlrOEtScHVRa3Exc25EUVgz?=
 =?utf-8?B?RmtHb28vMFpOSDBwVVEzZ1U2elRkaGt2bmFzcDc2OWF4Um4rYzRRVkdvNFhD?=
 =?utf-8?B?b2t4emo5RkYwaXFMNVZ3dFM2OU1WWUlNUGs1dm9zRHhaV1lsSG1JLy9nRExq?=
 =?utf-8?B?VG9TN0d6TnpnRnZIY3hkZVJDa0IrdXZaQUZ3Q2s3RGcwcHhuZU03QURXdFhw?=
 =?utf-8?B?cldUNzFpc1pmdFdlNGdYdEYwRDRXMVFXTHlENHdyVVRrc3BOMmx4SXVpcU8y?=
 =?utf-8?B?VlNRVXNVTWF0RkpDUUVzdnM5M2ZNY0ZrQ01yU05jUCtFMG9tcE5uVG5JUXJn?=
 =?utf-8?B?SVhxdEFGQVVQbmVkM2swaSt6aGQyZmRmNmMwUWJ6UEd5QThacXpwSXY3VEcw?=
 =?utf-8?B?eUhrSGV1QUl2TGtDeDJwendzTnRvZWNnUmNtYnB0MU4yWUVKaExyRE1jUm01?=
 =?utf-8?B?VXB5WHBUYnBvbzF3TFI1SDdlQ1hHSThvTDFmelFRU015cjlUWHN4WDFsVGRx?=
 =?utf-8?B?VUhuVy90NDRpcldyZGw5UGd4RXlaMUNHTlRNdnRkZkZVYy9xTDhsZjdHY29j?=
 =?utf-8?B?VkpUTGl4NnQ4MjBiYVBIT0tmQ3BCNGhQaStNNVNqZmVaRHhXelhyM0xUV0V3?=
 =?utf-8?B?Y2tweW8wZ0krZjNlaCtHL0JmYmFvZ3dpNWs3Y3lWV1Z1ci9SOVRyRXEyc3pk?=
 =?utf-8?B?UVlDRFhwd0FkZmJUdHQ0aHpHa1ZWeFJtNGl3VU5TVXY0T0RxdzhRM052dmNS?=
 =?utf-8?B?cTFIWFBEeDN0dnVoam83c2phY0NoWFN1SkhkMTAvMWVHcVZkSmFsakdObitq?=
 =?utf-8?B?MlBDTFFva2RsTk5WT0FnMUhwQnNSNVp2VXdKbnh0Q2JtWkpSNms4YVI2OWNU?=
 =?utf-8?B?WDA3aXhkQWI2ZkJWNkZOQmZNOG5YcUpHK1Qwa0FQUmp6STB1QWgyRlBtZG55?=
 =?utf-8?B?ZWV5WE96TTVpVUdmMmt0a1FBY0t5OXFJRVRBWnp1b1VWT1ByUU04MTNZdndC?=
 =?utf-8?B?cFY5SEh2V2lySFQ4em0ybGtnMHRYY2dWdkkzVGZWWTdHemhsMVFGdk5zSHFo?=
 =?utf-8?B?SGtQQ0VoeVlxb28ydlIxZjFYUlJoS3lSS1VZd21HY3FJbGYwU1psdTRUR2RC?=
 =?utf-8?B?YS9wSVVLYmNET2JkUGdScUtWSkZoYVU4MVlGQk85Tmk5Z1N4d25VUTdrVWg5?=
 =?utf-8?B?ek82WHdLd3FJMEIrNk5NNHlReVdLbFNhNWplT3EyYStQVjJjOTlXcjIvNXZr?=
 =?utf-8?B?eVBoRTF5REg3Z1Q1NHozd1R5UUw0NVZEa1JYS2xKK09aSC9NSkxveW5IS1Jr?=
 =?utf-8?B?czJmMlora2o3TVZhSXIzUW4wQXdKeU9IN1pTMVFRQXRiRG1zRUEyZUNCMFZT?=
 =?utf-8?B?S2xwNVRYdHNiWUlxTVdoRWFkaFRleHp3NU1jbUJESkJVUlViR2ZmTWg0a3l3?=
 =?utf-8?B?YnJwOHpJekhiSzNxU25RVGRYSWs4SjRnbm96SmgwVENTSlFCNmhQZkZhMHpt?=
 =?utf-8?B?dGRXcXkwSHhpUnlmOWpmWnR6WlFlY0N3eUwxd0tEenAwSGtybTdWZ0xIQXB1?=
 =?utf-8?B?dlFxNk03cGNKdHQvMnZBdUJlY3VqNm02bVNYeDVObnhRcG5FVTZWa2lQMnF6?=
 =?utf-8?B?OGJRbDRFY2JZWU5SSFd1U2x5TjluTGY4d0M3VHdUZEhRM2xBMmxVOXlGMkVN?=
 =?utf-8?B?OVRGRkMwb3NzeEwzRDFySUNBQlQwb3Y1eHNPei9ycGxpVjkxNm8yRk1DUyt4?=
 =?utf-8?B?ZEE1MnZ3M3R6NjQ4ODFNdWRnZWZhNmdFcDMzNjlKWEV3VjlyaDhabVFrdUtm?=
 =?utf-8?B?N21JaUlBb0NFUk5nWVJlL1FVZldsSmxRdmJiUkl3NjQ2dXN3RUFyYkcxTDVG?=
 =?utf-8?B?M0hkRjhrUkx2NnltNEtvMGkzNUtBc2RCNkZsTGJNdFZ0YjhpcXJWdWZvVk9S?=
 =?utf-8?B?Tnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZdUUu8lcxcBsylwv+8NuzuMLH+FdT+iizZqw05rz/O8Ll2dMbLzSWyEouw7aGP44PwDCsAje7endSfPKPhhiWgJRvyUAm4rTBG7YEVS0qNfpi3/fPx3i++Vq0PEI9SOQgdcvIwfREYw4tLxKx0oiaOHWN7b58m4aNFKX7otgWgOZlbsGjZDm7+2tb4j+7AbC9d/vfOafvB+gWqdgb35q2g56NnoCTUZAJabaG4riW6TA3MNob463JCebTwXb74mLFO2affgD7a8axalrlLugwPl6f+1MJC2kpNLsVOQDUBJnaZ666pNXWHblBTNrZ7bq25SYUakynW7OAVSMuWrevW3ULldp19jlFBtU6M869x2pFjgtQUpYdO9U7BdJV9brj1zNXMoU7eoS2avmaphHoB8tc6cSx/NzVW0z3uzoV0qFBXgc4ZRfWtB/6qJrBdeqWndl/mfIDyNttenNQVO45a/N2+iCpaVDTmV73+Cy7+WCaJRYtjK5hjqn9gY5RQv9h/VAKfKImeZFKFa24L1VB3kk1zZk3Z5wy/JVdmZaxh4dKXfmLBYBLRrLXmpp9IixakOOozjLYb+KtOO5FHMKrZRMMri5LrZcz1ZMeoeT1N4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10cd0b13-0d01-4a54-30fd-08dce4a5a3e6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 18:52:05.1711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UsbFkh1zmSPCG29wqfFb+syM5iAY0dp9izdj9lCEr5sHN/XYCxN4BTaOhVy+e4EZsipWYH1Tr03BvAnUnqit74rNstDu45VLx7RnhqnpO0s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4368
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-04_16,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 bulkscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410040129
X-Proofpoint-ORIG-GUID: GxbanJ6-TKflIRKMFJ3aoyIBhvyPzJTO
X-Proofpoint-GUID: GxbanJ6-TKflIRKMFJ3aoyIBhvyPzJTO

cc mm folks.

On 10/4/2024 2:48 PM, Steve Sistare wrote:
> Export a function that adds pins to an already-pinned huge-page folio.
> This allows any range of small pages within the folio to be unpinned later.
> For example, pages pinned via memfd_pin_folios and modified by
> folio_add_pins could be unpinned via unpin_user_page(s).
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   include/linux/mm.h |  1 +
>   mm/gup.c           | 24 ++++++++++++++++++++++++
>   2 files changed, 25 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 13bff7c..70d5293 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2521,6 +2521,7 @@ long pin_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
>   long memfd_pin_folios(struct file *memfd, loff_t start, loff_t end,
>   		      struct folio **folios, unsigned int max_folios,
>   		      pgoff_t *offset);
> +int folio_add_pins(struct folio *folio, unsigned int pins);
>   
>   int get_user_pages_fast(unsigned long start, int nr_pages,
>   			unsigned int gup_flags, struct page **pages);
> diff --git a/mm/gup.c b/mm/gup.c
> index fcd602b..11c5f27 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -3733,3 +3733,27 @@ long memfd_pin_folios(struct file *memfd, loff_t start, loff_t end,
>   	return ret;
>   }
>   EXPORT_SYMBOL_GPL(memfd_pin_folios);
> +
> +/**
> + * folio_add_pins() - add pins to an already-pinned folio
> + * @folio: the folio to add more pins to
> + * @pins: number of pins to add
> + *
> + * Try to add more pins to an already-pinned folio. The semantics
> + * of the pin (e.g., FOLL_WRITE) follow any existing pin and cannot
> + * be changed.
> + *
> + * This function is helpful when having obtained a pin on a large folio
> + * using memfd_pin_folios(), but wanting to logically unpin parts
> + * (e.g., individual pages) of the folio later, for example, using
> + * unpin_user_page_range_dirty_lock().
> + *
> + * This is not the right interface to initially pin a folio.
> + */
> +int folio_add_pins(struct folio *folio, unsigned int pins)
> +{
> +	VM_WARN_ON_ONCE(!folio_maybe_dma_pinned(folio));
> +
> +	return try_grab_folio(folio, pins, FOLL_PIN);
> +}
> +EXPORT_SYMBOL_GPL(folio_add_pins);

