Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D259285417;
	Thu,  8 May 2025 17:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746723881; cv=fail; b=LxSbi8pnemobkLKpu4UXI83J1FpnozpCEHaPiZjRQZjNxYq9LfBrlH4ZbMDwGWBf/3Hi/ZJ7ctKybS5CDiUx1+TuvfA5JUIz7GBB8U9JZGsOIHGXbJkibXgfwzfKcFtj7edZTDZF+NxQhBFaTmunJUoD2YtZBuKr54LjSJCmcsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746723881; c=relaxed/simple;
	bh=GPPaPGFPLSj1XoUqV0FBfYXriqDwQ/rtm+02t/WLmU8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r11rIQJCgleRx8gZORF/IWPPKSXckfqhPrmj89Fk9PY2WhuvVvES9MKeNo6uyuaNSPPUaPVWTYRyU7+PRBRGdq6Xh6KS4lci0vrfmKm6Ik8Nex79JpNgh5zDxXmesCOLqPqKqKIPuF5pyhVvM8GtairxNgwi1Km5OxrYR8DF2pQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=j5UjeNUi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KuiQzkFR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j5UjeNUi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KuiQzkFR"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548GWJvs016227;
	Thu, 8 May 2025 17:04:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=2EqqMGmxIBeRwTuj87kYfsG68U5uIAITZuQoNbbc2gc=; b=
	j5UjeNUitfTfynZ5z+tIygJRzJ/zi3t38efkefpCgRuCGzzh3ViMaE39KMjYfBo0
	RFwpDWRj4Wcbjf5npyPpK5LLlUEof7O+it2f53Ypi4o9RG98XqmwY7VEw/1p9K6z
	tg0h2BB9WutVHHGFo2X9GGbXmZmUb9K/byTe1F7AmS7aAqmhLCJMVfu4bRRRJXq1
	ifmUtwisdJrY1bFPdwNm32/FVCd6ds0duWMeYV8ApyNUl+4xKFjGBUu3ee47TgBz
	H/XxGXS12ZzVPVBZWFimrm0BZmHcRB0Th0v81GOIEnsqidnRX6zcdnsZ1pANLl2p
	C0emJCYfRVrrvG6qpYunyw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46h07b82wt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 May 2025 17:04:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 548FUkDC036067;
	Thu, 8 May 2025 17:04:22 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazlp17012053.outbound.protection.outlook.com [40.93.20.53])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9kby5ct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 May 2025 17:04:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j6KIhWpLYn+Rnibd4o312WM7i3b3fqjCUo0BnDE8d4eFV4XOU3dpSiPfJEWD/aw1/J+hrmwr4BPzDY0265vTLMwzM9pruEpxD3xFhilkL0FaSi0JnZPnOzoGvvytp6R/pv7CbW1uW19xxNZR9ALz3/pprrW0xSzasocuSSzDLCCavu8BJEFoOKpuVsUlnUrWJ575oYNXRhozTA/ksmEkCJCNf1VNnWNdx0UTLOqsCM/gCrBlBaPudFg+VwVp2Y34sOxrM9bVMZvMYYh260vPiK5ZIWFTBtY8MSsgnOT9w/m7ZEywWeSMYbQboC3ZExdraZGn1ABVHvZ/Q8f2sh7RSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2EqqMGmxIBeRwTuj87kYfsG68U5uIAITZuQoNbbc2gc=;
 b=lkm3jDMXNwZZPef64gsNZmyvuGa9VaNvqynFXhghIbMyz5cB2M38Qf4TROeYOgkFucCDuCkXgc/doDir/PYMysE1aR1DPS1818DnypACZ3ThrgrPIulOqZwd5SFmxj1CYTEARWSkXJmCwolK2n/ipIiZ4FapUJv0M7SwLFaVDmpfxn1K3MqzPVAaIuXvqFt5m6UxsT/eusNR29gcN64gy6IfN5a5bB+dnz/Q+hsIRG/aYhuuroU9NnGFlhxLp7zz8qLtUD9BpAD1mSW+4lVrBF0SJoDWPXGfUsKTB8gRr3OzUcGn9m62ZkD2iiIvtr4MQu0Fg88f2k+c7eDIAEl7zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2EqqMGmxIBeRwTuj87kYfsG68U5uIAITZuQoNbbc2gc=;
 b=KuiQzkFRn9cTRGn1x1O3zLBhEE3Faz9oBqbK1GnOqBtd1SYS58lVqYy7a3mRPcdxwond1LWtOgYIAkT/FrUWeVQsSOJmZwUCvo6k1T3nEOBjnbNA3ceexd2ZTFG/H6GFPMW3HSSrDDE/UAxNcmmyBAN4qoT/2YhLX6pHbkpALko=
Received: from PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 (2603:10b6:518:1::7d4) by IA0PR10MB7667.namprd10.prod.outlook.com
 (2603:10b6:208:48a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Thu, 8 May
 2025 17:04:17 +0000
Received: from PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 ([fe80::dfc3:b0d8:d4e:5c3]) by PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 ([fe80::dfc3:b0d8:d4e:5c3%2]) with mapi id 15.20.8699.026; Thu, 8 May 2025
 17:04:17 +0000
Message-ID: <6c9dfc01-89db-433e-9b7d-41dfb13038cb@oracle.com>
Date: Thu, 8 May 2025 18:04:12 +0100
Subject: Re: [PATCH v2 1/2] iommu/amd: Add HATDis feature support
To: Ankit Soni <Ankit.Soni@amd.com>, iommu@lists.linux.dev
Cc: suravee.suthikulpanit@amd.com, vasant.hegde@amd.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, linux-kernel@vger.kernel.org
References: <cover.1746613368.git.Ankit.Soni@amd.com>
 <a03c8eb9e998445eba8b18a40c53469eeef18a9a.1746613368.git.Ankit.Soni@amd.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <a03c8eb9e998445eba8b18a40c53469eeef18a9a.1746613368.git.Ankit.Soni@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0221.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::17) To PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 (2603:10b6:518:1::7d4)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPFE6F9E2E1D:EE_|IA0PR10MB7667:EE_
X-MS-Office365-Filtering-Correlation-Id: cc512027-7205-4df5-db89-08dd8e525dec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enBvM0dhNk9mc2hwSzdCTWplTmc2Z2EwbklaelRuaGdvQWpkK1BhZDFlNFRQ?=
 =?utf-8?B?N2xxbzdQUzBtRkJHeWlMRitSbDVMSWZ4NHBwT1oyVzdJVDU1bHY5TFd1VmVC?=
 =?utf-8?B?bkNQa3FpWU1Kb0RocmMxNGkwdmNlTkVUSElZZnNsZzlvUFJmWDhFclpYdHlO?=
 =?utf-8?B?OUgweW5Lems3UmJ5ZkRCaXgvN25KaEVDdW05U09CcE5wdEJzaHV0TC9xcWxR?=
 =?utf-8?B?MUhLZHJOdTE4T09NOTlXYm4zTDhMTTNQc1BtUzNPcHdWdVVpT2RTT1NRUklv?=
 =?utf-8?B?bkxMb0JzM2RJYVF5aENWcEkrSFdDdUJPNzltMi93UjRZZGRXZm5HMDhTUEhJ?=
 =?utf-8?B?SnZqRXU3YU9TaFJKVCsxZzBJRHpOVjJkcEx2WFdCcGR5clgyZUpGYXlkRlVm?=
 =?utf-8?B?TUJxV2xlcXZqcVVkUE5Xdmh3MG53QkRJWnRJSDlSc0FkeVFHeWVBZzkzNmQ2?=
 =?utf-8?B?dlUyVC9QVGxFVXdoeUVvcjBwdUlhaUgrc3F1UkpvSlVNSnkxVXBtUEMxOEdy?=
 =?utf-8?B?OWNCZHp3Rm1VZDZXQ09ZRjBWZEw3TDYxdE85N2ZsYWdCOGxkRmtCQ1VQcTBw?=
 =?utf-8?B?S29YbW1PQUY4ek5oMnR2QjgzNnIxT3VtT29wRXBza24wTnpJdkw3NXFOUzBC?=
 =?utf-8?B?ZVhPR3ZwaU9ITnFiSSt4Q1hPRURpZXN3cVVBVGpqamFQTGI5Y3VEUVpNWDlh?=
 =?utf-8?B?Y2xVdS85ZDQxUVFRZFlxQTJDR0Q0REVuT1hVUDlqZlVXZXhBSzc4RGZjam5Y?=
 =?utf-8?B?WW82WWNiR2g1TUlKay9vSnVCNUIwKzZ1cy9hYk5QaWREWHdHbktSRUNCdEt3?=
 =?utf-8?B?MjZVUWxrRWI2aWMyMVMrVThPRGdzT1Z2OFRoWGcyZGFHL29DTXU0T2dnYzZM?=
 =?utf-8?B?MTBNMHJOM1pxUlI5RXIyNXhKTU9SbmtMdFFHZHpPVEs4ajRMZHlhWVB1Vldu?=
 =?utf-8?B?cU9GWHN3Q0V2SGpJbmpIeHBmeHh0N1dxdlQvaXJIV3gxQ21xbXNFejFna2hB?=
 =?utf-8?B?b2RjN3R2Rlk0dEdGeXNPaWdBbGw4ZWdMOHRmOUljUFAxN1hyU0g5ZVpEWThO?=
 =?utf-8?B?clJwdnNvWjJCZ2xtaUlYT09tWlhpaVdCcHZsa2pFemgxN29ZSlNhZmFib2Zr?=
 =?utf-8?B?dTZCT2prQXd3bnUzVWZ6elFjUzRnR3h1SnNZRXRJcUFjVU5rYU9RV3I0QnhP?=
 =?utf-8?B?ZUEzRGt3Q0YwS0pZZHBPa0pLTW1RNkFsWFkrMFIxVVBOTG56bXp5c2tVcVVP?=
 =?utf-8?B?RGl5eGl0aGFNTWNPNlNhZFpMb2hPaHBwRFowSGwvVWdINlo5T0tWWWNzU28z?=
 =?utf-8?B?YXhzL1Q5RGtDcTM0UWxRakJOcjBGZUVFcUo5anB2cVE0MGYxaStXaVVrdExt?=
 =?utf-8?B?ZEhRVS84dSsvYVlXUlpZUGkyUWZXQ2ZkUFdmWGttLzBLMkNxTEFKRGNVTVNN?=
 =?utf-8?B?M1lNSSs0NG1HbFE3a1QrdHMvN00zeTVtdm8rS3pPb3hWQUdBM2QwZHMrV3Rp?=
 =?utf-8?B?UHNHaTZUOWU4K0lmdHVGQUh5OW1nNi9kWFNDTmpqR0JpQnR6TTJYRVlsVnlP?=
 =?utf-8?B?MDZVR2p0REJheitrSWwrNy9MSTFkeEJQM0x0MUNTdFQ5ZVErMlZtMTZXeWxr?=
 =?utf-8?B?MEZvLzd3N3VZS2gxR0FBYm1WYmJ1dEVBMzd3WHZnbG5Rd1ppMU5xMDRVdGR4?=
 =?utf-8?B?UVNaUndObTVyWHpibmRpMFE5SmY0T1YwT1NMRWIxVzZHYi9VNnFBb0czTTVt?=
 =?utf-8?B?cjkxMC9xR0JsWGRqSWd0L3lXaGtDSUlkQ2FOcmZyZEtxREZBN2xIdlIvVlJi?=
 =?utf-8?B?UWlJamwrV3BtTytibjJMdGxnWS8xeU1HWEFtTFVGenMwVFY4WTc0UlVoZlhC?=
 =?utf-8?B?M1RUeTFKcWliTGQ3S3k4YnFDUWlRSXZIOGtKUi9SOUMzSVRqamFSTHY2TUY5?=
 =?utf-8?Q?mB6D5PxGN20=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPFE6F9E2E1D.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bm43VFJNKy9SczlrZzhXK3ZvaGRtdDdaZTRpUUlCdW90eXRSbjhDekpGS2hm?=
 =?utf-8?B?QmU2d1FhbWdRbUtOUWlDTWNzYW1USzJyRkl6UkdKbERvMnd4UFhsd3N4WGp0?=
 =?utf-8?B?cUt3Z1BkUlh3cXlaaVNRaDFpdFB6am85MkhBOVRwZ2tpd1Q1cmhOSCtjSSt5?=
 =?utf-8?B?MW1yMmM4aEthaWRsbTJHdnJ3VTMwcGQ2Zzh0OVRjelQrZG8zbDBRMnhrUlEy?=
 =?utf-8?B?ZWlCbVk3L0ZEOUJyQXFTTGZlWS9GNG5UemovVVY3WXpQeTk2WitZR2pIWGtR?=
 =?utf-8?B?TVdQQjB4bWY1U1RrSXJkcTBqSmxGemcrazZIKzlCMS8xYWtGN0tQd3lpcE1W?=
 =?utf-8?B?RURQN0JnUWFRb1N2WU5rbmZ6MXZvUHRBWG56bFNCWTA0cGpoVE1BWFZFZUZW?=
 =?utf-8?B?MmdlbEQ2b3Jndm5BYzI0YTYvOHBIK1NkbHJ4ekRrS09GVDlNWmx0aVJOMDN0?=
 =?utf-8?B?TndkN2F6YkJiWVE0QklacEN3TTZtQjlPaHdHYzZ5Z0xIVVZZV29IT0FwbUxE?=
 =?utf-8?B?bTdpblg2ZUdQQm8zdkp4OGFTcVJkNHpjV1VCcGZnRStnZE10MDJJNkFKU2hi?=
 =?utf-8?B?MS81V1B5U0ZLWGx3NnR3eFVUa3d5eXpvMGp1T3ZlS2g0M3RkcW52YkFxQlpO?=
 =?utf-8?B?L0liaUlQMk95ekFaTlpUdjFxKzRockZUZkxiYUhiT2ZnOTluaTZBeWhlME01?=
 =?utf-8?B?cGx4Q01Ea1dEdlVQOTRjenhJLzBWNzdER1NKNmZ3NkxrZVh3SWx6SUJ2dXp0?=
 =?utf-8?B?RHpmUzJPVUg5dlUrcEJoeHpGRGlzWW5XRG1TSHdYSFBTc1pLZXR4Q0NZSXY5?=
 =?utf-8?B?czRWaWVwOFFCOXhvSFQ4ZE0zeDZab3gwMDF5Kyt3NTZXanpKK0QraGJzSUFm?=
 =?utf-8?B?M3F0c0VQSU9DNmtFRXMyMzBlSnRSelFORk9YdWRVVnllbjROWk1oZ1VlRUNl?=
 =?utf-8?B?ZDhIdmtRVzJUSUZXMjZIN1pkTEtDNm1JbThKNU1pa2g0SG1UMUYrZ2l3WVcx?=
 =?utf-8?B?SWp6YzYwU040SlVnSi9iQ1lQVGdBcWo2VWpSR0xmN2g3NEsxTjQraW5IeG1r?=
 =?utf-8?B?bVl4SXNNWFJaL09PcmtQUGc5bENRVGhILzR3ZmE5c3pOWFpvVWtCbmRXQ3JM?=
 =?utf-8?B?bjQxQkYvWTE4ejQ3NndraC9PUndmRGZIWWhpakNMcmRwQ1pUaGVYSXZ4S01Q?=
 =?utf-8?B?bjRCMHRkNHo0QStFMkNoaHZFb05sTnR0ZU5RMjFwUEhWQXhIREFmZVJQcmRX?=
 =?utf-8?B?SGxXN0NBRk9YL0RPcHFpeGRlU2xCcTlHZWx2N2VpeGVRREtHOFF5VTFFbWZl?=
 =?utf-8?B?SkYxbm9CWnVmZEx3aEhLNnBVVTRiL1laWlpCTHJPQ1o5Y1M5UzREbTN5dVFw?=
 =?utf-8?B?Q0Y1MERqWUFleUdrZHVEa08rZElyQXB4eVhMbTE3L3Ftc0VadDhvd1orRDkw?=
 =?utf-8?B?SzNiL2VEcjJiMTVxQWxSTGtPRmR0L3RUZVBUYzl2WnQ0YWxkRVNtTytSb3dL?=
 =?utf-8?B?THg2Wm96WGU2anMxczlhNUg1L3Q1bEtZaVhMQmNUQnZhWk0vMUo1YW02Uy9L?=
 =?utf-8?B?eWl5Yno1TkZBL1JiWk1aVDFxTTdHcHFieUFYT09yREtSR3dSUXFISzVpV3BW?=
 =?utf-8?B?RzJ3U0VQV1hjb3FMekRhWUVpb2hyUWYzR2xrbVVWSnFMalFNTmU4MXBGcUdC?=
 =?utf-8?B?SENJY2tuVmlWSFAzKzd5VW9maHRNcGpkbCtDMHRCU0Jic0hydHI1MjJQamly?=
 =?utf-8?B?SC96T1RYblYzYUx6WTZyTXp6VW12OGIzVXY1bUI5dG94cE9xOVpQK0JHZkxi?=
 =?utf-8?B?dG9qVFJKTTVlM0NOMllTUDR5dU5QekVGczl1YWdVeHZxQm16TGNhNmxLK3NB?=
 =?utf-8?B?YnpOMHFTdVBTRlpScHZ6MlZwM2VwbnZJaFJaa2lTdTVTOGJtWVlib0hsZ3Zr?=
 =?utf-8?B?MERxTFV3b1k2UmFYZWJ0Ky84djVXenZXZGxiY084NnJEVFdzQk1QczN2VTVo?=
 =?utf-8?B?azloaGdWUXBLZVFSTm9CaDVyTlJoYWZNcGFyRm9yV0k5aStkUndjTjVJdFlM?=
 =?utf-8?B?YkZGWFlxUEQwR25BTURhN3dzOXY1dE5abU4wTEZONW1xYTl5MTBZOHpXU096?=
 =?utf-8?B?N1N1M2wyTkJOTVBCUEdweVZncC9TNkF3elhUbURIM3FTTGlpY2RzTGplSlJt?=
 =?utf-8?B?eWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Jc/XyJ4oaEQ0+aM9GLcx3FLVPTQuhoYAgDJr4ABYRay25sVClt7H+ARDCW5wxmPlmHqWycRCdEXs1nSRdmb8vi1NoEpGv+XkvwJ4oXB1aUISKc8TJgtM3T1PVU7FCjaghJoemLhO2APIA1a9QiE6IYkLWVeMLTmW4coo9s6mlMDyMjQOB+NpWjs8LPSHHMMU/ZKR3YHfiW41XCgmpuFRxkBJbTnC9DVAYeU1ohgpVOr7SPk9ybP/C743PdxU0gCdwiYlq2Wau3DAl5GXR49ytPtZtDDKGaFkeuhJ6RG2pfrkvL9aJ4XC7Qc68VbWpFSuFfRj5mFS55zy3/4BHrWSpih9A9oo5Mjw3wycIrTIFUVZCcgIk8nC4UXDqx6nP1mrKH7k0UFRviUboMKDyPWLkxXwV8aNhdZKArGJA+jiOHexGcxBHCsYysMScoNuvZm9i17tRJhqJlq6IJQpp3GIFAROBf4mS8TY27IJtdFBM4oirJgOqiDWIhkPzmCZ3wUc8JY73yXSubOTP1RX1dn3EZJAauBmoak1UhOmv4egI2NQhfo5Gk6SybFHJ4tFHlonTg7qI1I1nlcG0vjeWj93JtiLQFR6k6hJbYBYfOude+4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc512027-7205-4df5-db89-08dd8e525dec
X-MS-Exchange-CrossTenant-AuthSource: PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 17:04:17.1763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kJFTAKOOS8DkMegwZmGbZJFTYksPtlprRLGPPqRhpuO7DkFN1X3og8qxF3c/uyMHhp02NUgxy3MH9SQTc4o/Qj8hfA4NtTNUFISN8yAPlAM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7667
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_05,2025-05-08_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505080150
X-Proofpoint-GUID: n9QnofH7mYI2Zp03YqvTuKDZ2XL4dKdt
X-Authority-Analysis: v=2.4 cv=MdFsu4/f c=1 sm=1 tr=0 ts=681ce417 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=zd2uoN0lAAAA:8 a=JyJ91qNRlN8AbF62O9YA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDE0OSBTYWx0ZWRfXy8732PonqzVO du/OQXSDWLmCbpZvR0E4keny7+tZGczx09C+KQqk+gDcvczdzTNkMKex+yFFdRvfmhHAk45S73+ K3rMIO7CfEtCeqtd3GZRHW5c0qgvIHrYFraP2qrqfOSQR3sojf/pfgNrgQAltMkkDyq9JRePn0F
 rRZ03lkO/+63eWGoWy+KSjoC3lg2lU1WIt5YtAUrcq9PW4ovjxGmz4rPWs4ENbig1l0Qs+j8t0f cj9nGSTaCWS08yN5FRDU5NK1ht/4h82fcNtu/2qlC89ar1SPap1geGsT1wSureACZfgeJG0aury MufoAUJ+FRhdceIKpH3gPm/BTjuyVnET8BQLS/81Ufv4waZfxztMW1oEXHgpM/LLI+rEdoLAatT
 8ETNdEyDdG2u9c+MR6MbhzZITw6k4BcK+gfmPDK2cnzV3YsMSD6l6VITmGr1kTKsR6Tj0NMP
X-Proofpoint-ORIG-GUID: n9QnofH7mYI2Zp03YqvTuKDZ2XL4dKdt

On 07/05/2025 11:51, Ankit Soni wrote:
> Current AMD IOMMU assumes Host Address Translation (HAT) is always
> supported, and Linux kernel enables this capability by default. However,
> in case of emulated and virtualized IOMMU, this might not be the case.
> For example,current QEMU-emulated AMD vIOMMU does not support host
> translation for VFIO pass-through device, but the interrupt remapping
> support is required for x2APIC (i.e. kvm-msi-ext-dest-id is also not
> supported by the guest OS). This would require the guest kernel to boot
> with guest kernel option iommu=pt to by-pass the initialization of
> host (v1) table.
> 
> The AMD I/O Virtualization Technology (IOMMU) Specification Rev 3.10 [1]
> introduces a new flag 'HATDis' in the IVHD 11h IOMMU attributes to indicate
> that HAT is not supported on a particular IOMMU instance.
> 
> Therefore, modifies the AMD IOMMU driver to detect the new HATDis
> attributes, and disable host translation and switch to use guest
> translation if it is available. Otherwise, the driver will disable DMA
> translation.
> 
> [1] https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/specifications/48882_IOMMU.pdf
> 
> Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Ankit Soni <Ankit.Soni@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h       |  1 +
>  drivers/iommu/amd/amd_iommu_types.h |  6 +++++-
>  drivers/iommu/amd/init.c            | 21 ++++++++++++++++++++-
>  drivers/iommu/amd/iommu.c           | 13 +++++++++++++
>  4 files changed, 39 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
> index 220c598b7e14..bb14c4800dd0 100644
> --- a/drivers/iommu/amd/amd_iommu.h
> +++ b/drivers/iommu/amd/amd_iommu.h
> @@ -43,6 +43,7 @@ extern int amd_iommu_guest_ir;
>  extern enum protection_domain_mode amd_iommu_pgtable;
>  extern int amd_iommu_gpt_level;
>  extern unsigned long amd_iommu_pgsize_bitmap;
> +extern bool amd_iommu_hatdis;
>  
>  /* Protection domain ops */
>  void amd_iommu_init_identity_domain(void);
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 5089b58e528a..284ff4309660 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -460,6 +460,9 @@
>  /* IOMMU Feature Reporting Field (for IVHD type 10h */
>  #define IOMMU_FEAT_GASUP_SHIFT	6
>  
> +/* IOMMU HATDIS for IVHD type 11h and 40h */
> +#define IOMMU_IVHD_ATTR_HATDIS_SHIFT	0
> +
>  /* IOMMU Extended Feature Register (EFR) */
>  #define IOMMU_EFR_XTSUP_SHIFT	2
>  #define IOMMU_EFR_GASUP_SHIFT	7
> @@ -558,7 +561,8 @@ struct amd_io_pgtable {
>  };
>  
>  enum protection_domain_mode {
> -	PD_MODE_V1 = 1,
> +	PD_MODE_NONE,
> +	PD_MODE_V1,
>  	PD_MODE_V2,
>  };
>  
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 14aa0d77df26..cfda9f89fe1d 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -168,6 +168,9 @@ static int amd_iommu_target_ivhd_type;
>  u64 amd_iommu_efr;
>  u64 amd_iommu_efr2;
>  
> +/* Host (v1) page table is not supported*/
> +bool amd_iommu_hatdis;
> +
>  /* SNP is enabled on the system? */
>  bool amd_iommu_snp_en;
>  EXPORT_SYMBOL(amd_iommu_snp_en);
> @@ -1798,6 +1801,11 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
>  		if (h->efr_reg & BIT(IOMMU_EFR_XTSUP_SHIFT))
>  			amd_iommu_xt_mode = IRQ_REMAP_X2APIC_MODE;
>  
> +		if (h->efr_attr & BIT(IOMMU_IVHD_ATTR_HATDIS_SHIFT)) {
> +			pr_warn_once("Host Address Translation is not supported.\n");
> +			amd_iommu_hatdis = true;
> +		}
> +
>  		early_iommu_features_init(iommu, h);
>  
>  		break;
> @@ -2582,7 +2590,7 @@ static void init_device_table_dma(struct amd_iommu_pci_seg *pci_seg)
>  	u32 devid;
>  	struct dev_table_entry *dev_table = pci_seg->dev_table;
>  
> -	if (dev_table == NULL)
> +	if (!dev_table || amd_iommu_pgtable == PD_MODE_NONE)
>  		return;
>  

My suggestion in the past in the past has been to do:

if (!amd_iommu_hatdis || amd_iommu_pgtable != PD_MODE_NONE) {
	ret = iommu_device_sysfs_add(...)
	if (ret)
		return ret;
}

if (!amd_iommu_hatdis || amd_iommu_pgtable != PD_MODE_NONE)
	iommu_device_register(&iommu->iommu, &amd_iommu_ops, NULL);

Also as a to simplify the attach/probe path i.e. remove the chunks in
amd_iommu_probe_device/init_device_table_dma.

Or is it that the generation of an ILLEGAL_DEVICE_TABLE_ENTRY event means we
still need to be careful here?

>  	for (devid = 0; devid <= pci_seg->last_bdf; ++devid) {
> @@ -3095,6 +3103,17 @@ static int __init early_amd_iommu_init(void)
>  		}
>  	}
>  
> +	if (amd_iommu_hatdis) {
> +		/*
> +		 * Host (v1) page table is not available. Attempt to use
> +		 * Guest (v2) page table.
> +		 */
> +		if (amd_iommu_v2_pgtbl_supported())
> +			amd_iommu_pgtable = PD_MODE_V2;
> +		else
> +			amd_iommu_pgtable = PD_MODE_NONE;
> +	}
> +
>  	/* Disable any previously enabled IOMMUs */
>  	if (!is_kdump_kernel() || amd_iommu_disabled)
>  		disable_iommus();
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index f34209b08b4c..4e9a57377b8c 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2393,6 +2393,13 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
>  					     pci_max_pasids(to_pci_dev(dev)));
>  	}
>  
> +	if (amd_iommu_pgtable == PD_MODE_NONE) {
> +		pr_warn_once("%s: DMA translation not supported by iommu.\n",
> +			     __func__);
> +		iommu_dev = ERR_PTR(-ENODEV);
> +		goto out_err;
> +	}
> +

Strange place to put it after all the initialization has been done. Shouldn't it
be at the top of the function?

>  out_err:
>  
>  	iommu_completion_wait(iommu);
> @@ -2480,6 +2487,9 @@ static int pdom_setup_pgtable(struct protection_domain *domain,
>  	case PD_MODE_V2:
>  		fmt = AMD_IOMMU_V2;
>  		break;
> +	case PD_MODE_NONE:
> +		WARN_ON_ONCE(1);
> +		return -EPERM;
>  	}
>  
>  	domain->iop.pgtbl.cfg.amd.nid = dev_to_node(dev);> @@ -2501,6 +2511,9 @@
static inline u64 dma_max_address(enum protection_domain_mode pgtable)
>  
>  static bool amd_iommu_hd_support(struct amd_iommu *iommu)
>  {
> +	if (amd_iommu_hatdis)
> +		return false;
> +
>  	return iommu && (iommu->features & FEATURE_HDSUP);
>  }
>  

If there's no IOMMU group, how can we allocate a paging domain with dirty
support for host/v1 pgtable? I don't think you need this part?
