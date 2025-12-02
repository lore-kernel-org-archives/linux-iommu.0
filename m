Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E272561A2
	for <iommu@lists.linux.dev>; Tue,  2 Dec 2025 15:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764689321; cv=fail; b=j3Ar500H+xA65X8cqQb+JFdaLGd4Amm6mLjzHwidx2Lhf6oJ5U419UQ+VOmaZZwZhK1HXOrfIR2ghnu4CS+SCDB2qEeqAdXnSsABjY7aRUbG5TU51/Q1I43/WVb8cC/6oGhzJIpzMoL4f7vRx2+2r8/8QBuMhWhV5vgDSup4Xwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764689321; c=relaxed/simple;
	bh=BwDe8o7ZMYlx0HOdlJi6MxttgRI+Ywsm0cn6IMgiB/g=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RYNxVJdlxwmRjlVYRltneoot7VGy4lUR98UvHEMl3OtxGuksKRTKA3+OU/YqQqSjJSl1moPZBaWzafjgDz11tu+57jKVaKZNV8KnO8GsPL9d3wK8wtj0RyuMPIV1RgPLwAX9IE1w6V+bUQr9HqbOnrPZM1SOJOU0x67wpakK+RM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FpmXiP0c; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bujHgQgQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FpmXiP0c";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bujHgQgQ"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B2ENEUM378279;
	Tue, 2 Dec 2025 15:28:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=GJqsCBgvmUSeFvUq
	10wVz2x++86dlGZY0hKhQGYHSKA=; b=FpmXiP0cu17ULf1/JNdFZKyIpA+erHEK
	43jlVjtKE8qNtXcJdBYBvEWTijFdLiL42h7a4vvhsq+armAWiIhNm71XFFE4chDD
	J2JClbPWyU3iTNbNQDtQsjl2lh1aSN42oH8jfEhZNZv6blfA/6xhiR6YmUNCmX5u
	P43/EFkciBNhhAK0jFHu62yAfjvFGmAMxDQ47CPRV/VsiK/cz/InYSBHAMNW3x2J
	oSnE7cHrzGMkwLy2zafjMqdl2K5UGAhaQXus8mQ6fRlOZpz0kYoEkmNYnFFJyeAl
	1iJyXyPEtwCN1zu4exNQajZUVNbJio6+aqDmiXgjp9U5RiBvtmIM6A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4as86yb3yu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Dec 2025 15:28:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5B2F1EdE035490;
	Tue, 2 Dec 2025 15:28:35 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010058.outbound.protection.outlook.com [40.93.198.58])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aqq9kgkqf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Dec 2025 15:28:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kmxyjMvhhCE+esfiN0cdiWOYpEM40uastg1D5eEvbYAGamJuPjsEwlo2w4654LK3jyo+6r/NlveoseKh5WQgLu6x1/aTH4YWa2i2vqEq72xpUbWvzMOwjChuvdVYg7W8hzHb+F87f5Gkz9KnyhEMTb+rKPHc7eWIhHg9t74ZuLspeIEH8XaOqivjoNx1VGTn2tKUKCBY/43sWtWk+7d7O0gQHwWvQ8dlnaTTyLU/NWQO12IWF+2GuD/Uo5VH4lsbg8lnlrMjdZkQvQ+0gK3kWLvHv8Wh/AtEYlJOcqzAvzp6dvc963yJIj07skpCMImfF76IXsyiOe0RKYtZQOtwQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJqsCBgvmUSeFvUq10wVz2x++86dlGZY0hKhQGYHSKA=;
 b=Q2yG2b2lmx268ebcLUrqaYvInLvrDeFCgppy8ZjrVWXtrtqrvoRBm3u7kaa1fdPRX7DO+bN8aF+sDhIwcaD8dkpf95cz7pw3s8O+3hI4MTCq1Y72eDZ6HZeGIkzNQOKvAVyNvem6aPltMAJjKqEQQ4Vcv94I6FydEYLNAuObJIsOJoQjzTWW/cSsgLJ7vnXFsqn75R/el5YCs+2DBmcPbYWO6QMrpsSJ0eX08Pq6xjZouIXQpGCDuh69VYVExExAX3sZ8+HUJNk9lFPsgblL+i8jvagk7K8dinjqDY3OmVLUlnLYRQx+7wEbCqxQcT+XK5sn1YyAspTyiQSUMnJOxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJqsCBgvmUSeFvUq10wVz2x++86dlGZY0hKhQGYHSKA=;
 b=bujHgQgQr2OPpvcvR6OlF5VYhop0nZQlS6Co7MHUWz1nPDS1/+u485pxy0wdVx89tUfFTSIzFzQ5V+0QCKDtkFBgTssyRoE7GmSSGX26ugG+4RzJAvqRsaQLNiho1Vy1G2GUJO+nhI8Az2sW6QkJh3eGXIqBvVpbyOEdp0rm/Ag=
Received: from IA1PR10MB8212.namprd10.prod.outlook.com (2603:10b6:208:463::20)
 by DM6PR10MB4361.namprd10.prod.outlook.com (2603:10b6:5:211::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Tue, 2 Dec
 2025 15:28:15 +0000
Received: from IA1PR10MB8212.namprd10.prod.outlook.com
 ([fe80::ee8a:bd21:f1cb:c79a]) by IA1PR10MB8212.namprd10.prod.outlook.com
 ([fe80::ee8a:bd21:f1cb:c79a%3]) with mapi id 15.20.9388.003; Tue, 2 Dec 2025
 15:28:15 +0000
From: Dave Kleikamp <dave.kleikamp@oracle.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] dma/pool: eliminate alloc_pages warning in atomic_pool_expand
Date: Tue,  2 Dec 2025 09:28:10 -0600
Message-ID: <20251202152810.142370-1-dave.kleikamp@oracle.com>
X-Mailer: git-send-email 2.52.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR20CA0027.namprd20.prod.outlook.com
 (2603:10b6:610:58::37) To IA1PR10MB8212.namprd10.prod.outlook.com
 (2603:10b6:208:463::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB8212:EE_|DM6PR10MB4361:EE_
X-MS-Office365-Filtering-Correlation-Id: 118cbb36-63f5-46e8-0786-08de31b7694f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fTTtD5t4IW80BPS48tzHBwcw1QOi1aDOjQ2HsV/sXXnnBbWuK2FOdpbbjz98?=
 =?us-ascii?Q?xxE2lpAaaPhf8aVUIwseTsCH2WG3ag9lIA2/e3UrJIFt49qkIZXP4o3nXN3u?=
 =?us-ascii?Q?8BPw92Y2+0P05YeWHBA2cTtCrKX2Hk5+mO0oWB+2AcOKwhLkV7d9aE9tG1w8?=
 =?us-ascii?Q?XnLlvRgywx1rpiH3VxuNNzwcOonFce1RIahYSTn2MJCNH9+hPl2Z8Ka188TS?=
 =?us-ascii?Q?J4E8pA4mIqkCFU8a4ORoPQwUWQ+R4/5IBkIq6erUmiBtQwCo8qJ3NlbkUIWX?=
 =?us-ascii?Q?BEbIiAjdB2jooLqOe6sx0m+Dfscd+v8gEa7g9ySqcN/+twON/okHl5Rgg0AN?=
 =?us-ascii?Q?bq0wJgZ8wWl9PXXTAyQte1xH8y17D3pcoY/l0ifSeGy/sK1psdXdWOQp0ZKY?=
 =?us-ascii?Q?dNAwt977Dn/ut+NtZlNs/yC7Y2RGjFhC5LD+HoS3OCZawp9B2W3tDPC6Gbi1?=
 =?us-ascii?Q?nX80C2X8HjYpqaLugFFpVloVoIP86fScWGiy6gZIhv8cb9SA6YKcYO13FX2j?=
 =?us-ascii?Q?WYYAr6cICkAg+Y8+uBfzEPokOypu3G6R2oNHwSSRaDVU1niCwhR8TMLYmiYv?=
 =?us-ascii?Q?ppTPEW+musBRU78/lW0vrKBfmrDY5C/b9n9UhHPq54kTJeUuZj67PyE1RbjX?=
 =?us-ascii?Q?+CtFDaju032+N6niXUcAs2VmoeYMFF1Fz7T1q8PQnpyyKUHMhdOk6vtqIHgh?=
 =?us-ascii?Q?PmssTkfZ2jEidq5tC0Pfbd9QeQD9fqoH7jwRBCmlMEqlyHb1XuaUfO8VLzkr?=
 =?us-ascii?Q?pEb7jKDsqMD2flqi3/uZeqbm5bzwSd1WuAN8ltsY2dgrFWZ2COuLZAf9OtXV?=
 =?us-ascii?Q?NdcFYHntQGnMOtNp7YHlxQTIMgTZiUZG9iXT7zIJE8kiiSPHh2bkp2NoWFv2?=
 =?us-ascii?Q?OMkDjhLYqBF2MlAFIH0xnGLMf8TJ2+DfFSMxm6YyNo4rL98DbAkt6YyvOiHg?=
 =?us-ascii?Q?YJ8WWJO5lJD/bwVmGo9W6GT2WAGVfQLjK+gKT1A38lKZVgyM516jpKLl+awy?=
 =?us-ascii?Q?Sp9PgnBw1b4cvdYAL5aSBO5Do8k3JPB33W8UaW948D3u8DGBEKhXfqXqTTK3?=
 =?us-ascii?Q?qtHZ9/bkNeh8oLO9P3N31rYwBzOEOLZznclzr8vZxFn5LG9mQmGC04a9O4vB?=
 =?us-ascii?Q?LDnd7pAvM5bDGTOZGoRgOCch/H/JCLyLe64EWyH49CeWQqirnBy4H1Cn8NvI?=
 =?us-ascii?Q?RYajEQfN7HeshOUT0Vr5ZV0nkrz4pYsau9QuMC3yJvdfvlsQId9S77WBFmz1?=
 =?us-ascii?Q?yDEY3ICyjMwr8TzGIuNjSyTg2Hhw4DzKsj1uXq/qkFjW3QGhTTOkAbeKLGF4?=
 =?us-ascii?Q?bxkncNxrFIFsqzw+ndJjpd4pPFAqQHHBAY+mjCTjOmjPqhVS43ZjTsq63CiT?=
 =?us-ascii?Q?m9MX1YXL6vu9OW+6aSmitevNDCgo7VEfOMOmXpkBsos78XPrihPR8NbTiZSg?=
 =?us-ascii?Q?B2CN9Z2kt+fNxWCVLSFjgGfaL7pPcDpW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB8212.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4pSaTYRd2n5aoF0z2U3v9aA2KQMCKhs6fjUWshHX+94TD38QzU0xlTCFGmV/?=
 =?us-ascii?Q?cS47WRkNw7iopTrgb+VqROkRAH0W42oZGHAWkPeSuKqYhCLoTv2ztIVMc4FE?=
 =?us-ascii?Q?CYRXd9Dq3h9cZPz/m7OcQtQ6Q0OxmUTNuA+jhYatYnjm2blgACazJfjXxg7G?=
 =?us-ascii?Q?hAVFbckyqL81g6GAX9m1oUE8tFICdc0U3yEgJ0yUn+EnZI+MEWh9IvuF+rAk?=
 =?us-ascii?Q?gEmGt3wYldAjGjVAncGI1nElufZVcTw95bC9hkBgB15hdnkilhVqZJMqB11L?=
 =?us-ascii?Q?dqrs51NvtEJ7e4n+QiRw+Tfaqs4Xh38nnA3k/lq4tcHYGRJ1OYmlVM7doiSo?=
 =?us-ascii?Q?4Jmv0UhCdCZcLjCRE4HSh4kkL2fvBJEOscWJ0ZBMZHIEeVM07pGAlvhZcoe7?=
 =?us-ascii?Q?a7Nbf38dUYvZidaO+lUwy4E6GLyAQfiQ2IiyLbZmYb1X9ogId054etT3nKtN?=
 =?us-ascii?Q?HdocMO2RObbFokkQot+6T3/iDI4bJfa1nxB00Z3iEvt6H3V7VENuOo/a2Po6?=
 =?us-ascii?Q?HBiMp75VQQ532goy2WaRF3k6RFGE8OQjT136d3hVgwPc3MppaoXYm4WPwsHe?=
 =?us-ascii?Q?YbH8GZuzDxnF6xBjNnKhDqbUcKMJJXp9Pu+642J5avwdygC/y5wUYoo6lz4f?=
 =?us-ascii?Q?3e8eYF/t0IntVEGXUQHioJ736DEyKbCReW9hZhe0CzPTFkTERyjGGt0rQTET?=
 =?us-ascii?Q?Jh9vO5f+BIlF/rrrcONAzjMtVWdpU1yvZ+vcDqmOSYhoclc7/W+F5KTE/4lq?=
 =?us-ascii?Q?l0JIbgwApMz2yh4FyxbQa1dNK6zPHLQ3oCvlBUZsPCJ+KhtbqKnujQlMon8/?=
 =?us-ascii?Q?VhzZkbo3ELkslQ2BrPgxoo7W9BM6As7mJUwYiJRr/e48UhlFDMEDohuQPGX+?=
 =?us-ascii?Q?s1Wl61yQQVHtCrTkeDmoaHb0RIf4M2Cle7dabSc2HBDkkg2c0eFwPF5WHvHy?=
 =?us-ascii?Q?5+hEZB6d8gjGlXimY34VfNb9JT0AP+b5+hMbYTZbcGIHyATLPnpe4xJhSxuO?=
 =?us-ascii?Q?PAJCk9HH/O0arfxOB5j5BFNiobYXbBDxMKxgG0DOMql4zH8U7eL7bDSYTL2F?=
 =?us-ascii?Q?MbikiyGQArWiQnpwPnvY9Pt4a1ZLmMnAC/BYd968hJqlqvAha/iVeHReDii6?=
 =?us-ascii?Q?NKOiyPUmcZzROLafqGo8UgdHZ5tv8dShf/3GDIiahpACIYQijah1cTKzJwNO?=
 =?us-ascii?Q?oFMGBovGc4DCO83d151q4hH3m5rErBJDxau4FKuUA1nyJjz6xBsA9aW3VApv?=
 =?us-ascii?Q?strKEk/AMBN8xFdaameghXVZ1vpqlAugaq3EJ+lMNfHSLuqoOLwmVjFDAyb+?=
 =?us-ascii?Q?GvQzEsJIlGh3V8JtfuX7p+uvMW1cnuCmgpQNJliUwEslZu6uDLbHn4j3bV4i?=
 =?us-ascii?Q?jJzJOTRKnnKrZBwkPdhmDoLid7MyJ+VGszhffUlQhgrfn3SJ4djWMDv6K2dz?=
 =?us-ascii?Q?RFOaboS7lvrn86JtohB+AFvXIkD07mfBhaCevmn72vNQITA7ZIYmWpVjuNqO?=
 =?us-ascii?Q?kcxSjBovfuSyOeG1DsLHGu6pdopqqdNxjEnkddcZX94BTVuH/2xTua8PgeDm?=
 =?us-ascii?Q?9C8P1FsamDJUng61MCA47xq9S4VTU0apqkI9vol5onCpUq478BwoamdHmztW?=
 =?us-ascii?Q?rw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	A1VBThj2m9JCJDbfRt1EKVx8FFj9K3fGOQOzd1g9QVBIB4mx+s1djVN9t5/ibUsyjBuLYcjevCO/GxNu8xs17/l4J1qTfc0Obp6xtQtr2TP9TrkecS3rHNh/wZUHxJ2fIlx6IYIgFsYIk+C0e931F/siQNO/j3rov1BQfx3G+8j2XMOKHUJRo3lXfFRz8QD+aA8EkDWxmshuMsPr4dQ5GeGhl4LVbyyJz2SRqU2oMtTRFen2BWcnTE78iHp7lYL0OUofijln7oZ/LK5/MPhmCwiHJczcy8ctZ4FwLokR/CPHLIxER/HqA2ANQx6iVWYYqhn5ELYZP+zrLon/A7OMU5pgKrhMsMBk4Y0vXOpCvaypIST0gJ/0rSp15PrrHzfEzvdyvV+85wlURVLfLRUlfV6V4IG4QL1SQCOHO/CrKb97eInSFG74wZ6AP19Zeyu7t77BtN3TwaRFX7vEjpUVU6MZG1bf+1Yo+949lb9GPPfohLppeTcB4m4VbUXUkF3XV9WBvTmJOpsWMTTfI6hVlRC0bHPZ1p12jpIk8niLw7DLPpYD4mqOBdKeNHTb68ePCH5Gvv9VSoEnN1rioyqvyegwZne7ZPHaALAUlyBB7BM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 118cbb36-63f5-46e8-0786-08de31b7694f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB8212.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 15:28:14.9733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UCvl/kGsI3DcKg/78/I6X0WDfABLrZEPhbfg8l0QsfdOlCpfqawyDT4AcgAVrwYG9bpeIipGRgZsXGecjlqkLEmOJ8HABFUCFIOsmgRLSKg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4361
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512020124
X-Proofpoint-GUID: XF5sq3mXURBOtIAprzCxAstOavVjzKqt
X-Authority-Analysis: v=2.4 cv=AaW83nXG c=1 sm=1 tr=0 ts=692f05a4 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=3JnTE43WGW9PXCFblGcA:9 cc=ntf awl=host:13642
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAyMDEyNCBTYWx0ZWRfX96yTxtxyHzh3
 Xq77Tn9FIBFC4FS5c7wGZhSydUybPFIlq6/98nPobIYM1yM6ci8eRvDu85XHUuVkyAFJMkIQmPu
 UInAV+WxmscieUzLC/1kVNSMJK3cgfKZqTlxZDihMSn/OkFwJHhvHfcz3Vq5A7/QUxP70vU9zMW
 s/O76byIDvh85UO7bALsiN6qp9ndaCBHgtcRMlut3g9nTR50Cldd9MJbewfo2GoJ22IeaSpvoFv
 kmokGHg8f6yQQaoZRcGEpsePhaCcChEjbkBrA8pB9nTlN4zP/JydcpA/6zcb29KpDQnjTmoh0E4
 byEU/J5SXM7oI2iNkp3WHL4g7nbW8LlGDRSDchAohHGUEw1BdWPRW8gfI+tC+gXyewQq9THGwwb
 gr3mj9e4dQKIhBsdv610VDCgG9Z7VWA1Oal663BexxCcuOvlCvI=
X-Proofpoint-ORIG-GUID: XF5sq3mXURBOtIAprzCxAstOavVjzKqt

atomic_pool_expand iterately tries the allocation while decrementing the
page order. There is no need to issue a warning if an attempted
allocation fails.

Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
---
 kernel/dma/pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index ee45dee33d49..26392badc36b 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -93,7 +93,7 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
 			page = dma_alloc_from_contiguous(NULL, 1 << order,
 							 order, false);
 		if (!page)
-			page = alloc_pages(gfp, order);
+			page = alloc_pages(gfp | __GFP_NOWARN, order);
 	} while (!page && order-- > 0);
 	if (!page)
 		goto out;
-- 
2.52.0

