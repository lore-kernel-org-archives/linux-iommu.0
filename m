Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35121FAA;
	Thu, 24 Apr 2025 12:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745497211; cv=fail; b=Nznyf5+nzzMuNTu2DDOTm6b4ngwi9FWm9mwW6VNuYX7CmurpfOEKQpxfBNKkA08V31xQQVmsonjNsUdr71rSo9U6ew2C/aNPVSC0xBAKJ8pUuw41Q4zdtqTnKjjZwRIp8Mkn/TU+hYwj4RJuw8uvZwDyL6n1lo/nxTIk4BG8Mss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745497211; c=relaxed/simple;
	bh=WN48noJpNd8cO8ukLmiGcKPYBI7femqTgHajhdBFPjg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pUBfeEwEHGoFkbbBpPyVFTiG0EMjQVTdVV8bGZ+fO/BfrG2RWphICn3qQ4aGmeOOT3/Q7/NtQQsyi5Fu4/O8HABFh6tCI8782f97zn2xfTJ+oVzcWVO15oHrE3qlD0rjUttocFjX96L8CT/tSGNJzU0Q1WO2fDHQ48s7me+q6r8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mZx46MoI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bM5hOfA8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mZx46MoI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bM5hOfA8"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OCJEJB032334;
	Thu, 24 Apr 2025 12:19:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=0huOLiZwUA7rQHxMMPbwBpFz+uZ4PvgDPzkoI939a8A=; b=
	mZx46MoILvVN6qySYqAjloJPCPHslVWS4AXpAb8OKudWHUS0/3sPjQwGJHsAMhzn
	Gd6q+c3YVOFvg4nIamnKEoQ3LNOujsYpKcWKHN6q+rMzfcyOTxygXSn1gCvJ9dKp
	ouZgdChkPvJrUQPWdZzCl3ffEoOw/TK6j1QaMu80NOPY27XQt4F0x3KOwyYTBFyO
	A4FdPDskUfIrn3xyMQ6cWSLCsFbHgiDBcr5bsbowZuYGM2N3YgRKSKn95SV0v8d/
	nooX442BU96c7NPQnH45BBUDRi8HNVRA3C1qAgW5YUFstbwYH4vsGrpVCiC3+44t
	+g1tLcvQNUrNx7AJqU16Aw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 467mvd023y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 12:19:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53OBHTXj031091;
	Thu, 24 Apr 2025 12:19:53 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazlp17011030.outbound.protection.outlook.com [40.93.13.30])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 466k076b0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 12:19:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HsxbMZgzRdRoxHIuRdSuKs3hjrXquavsrc6VrdwmiAGO3eTd+/1XJtRXCbFkhsNkzRLfnb1N339io3xhNsek4Mf2n7B+6cwI7CJ3HdO4gd8HUf8Gr9Owa1mOERteX4k7Rux2r9/faVYP7BV08b+qoFFfvc/7zGdFcXTcPZgQwIBRo5EFKOhal7mcNpMC7U0cs2LKXAMNrTuG08SJOPzq5YIQSgVj8K7q6ii14/Ih6DBtQZfXAzbQwN476af4RJ37xjeF4iON2I3tb40dBs0Kp0gMomXQpykrtjeRKrB1gs3OmuMxdHIoXCZeMTNWuqg/DtJXYEFavK3eVd1sLDam2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0huOLiZwUA7rQHxMMPbwBpFz+uZ4PvgDPzkoI939a8A=;
 b=g56229E2YzSDwFkTfm8xksN6XIcrbJTp76DxkHsfBzKqVxY2B6wpdYYugfPotWi/TUntbDWOAvHkwFtIbM2xhFbhY5jHaTrtxMDNl+fczWJU27TE866/ycYPZ7I4fReuvekuGkNF7entY0ZjftquW9QFPwmgBTz94stYF0+CqNCtTAnpqkeHeuMTMjeGUdol33kluoRvZExSPQM0lrYG4irRLYgp25IKkLwNOuyDnF5FKUyPyDq9l5jxCaQGvNxp0CNunWT3qNThHlPBI4e4wWYeFkvgdsaePZKF64DGgI4dERpyJ/+DJwvNPh6EnlgxB4/0pVfQq/8zQ4Md9difAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0huOLiZwUA7rQHxMMPbwBpFz+uZ4PvgDPzkoI939a8A=;
 b=bM5hOfA8flEXuXRz3oeqzTZ3pfx+QicIlpRGpwKxZtHY/MZSr0oFbnT9UtT7sJJxeYTpXBWnPQzFMYEOPJho5RpkvldzeZPZFeE1rrXIbveN2ff15y4HwVlP6DHqibyAyS2S8RwzlBEmOPl2eqzS5KzZAPvTf//LZR27IHabC0U=
Received: from PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 (2603:10b6:518:1::7d4) by IA0PR10MB6698.namprd10.prod.outlook.com
 (2603:10b6:208:442::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 12:19:49 +0000
Received: from PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 ([fe80::dfc3:b0d8:d4e:5c3]) by PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 ([fe80::dfc3:b0d8:d4e:5c3%2]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 12:19:49 +0000
Message-ID: <596ed125-c995-4e2b-824c-b7929c852754@oracle.com>
Date: Thu, 24 Apr 2025 13:19:43 +0100
Subject: Re: [PATCH 1/2] iommu/amd: Add HATDis feature support
To: Ankit Soni <Ankit.Soni@amd.com>, iommu@lists.linux.dev
Cc: suravee.suthikulpanit@amd.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, linux-kernel@vger.kernel.org,
        Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
        David Woodhouse <dwmw2@infradead.org>
References: <cover.1745389415.git.Ankit.Soni@amd.com>
 <6282a5c349812a311a67a8522dc5e4aabfe3ec3a.1745389415.git.Ankit.Soni@amd.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <6282a5c349812a311a67a8522dc5e4aabfe3ec3a.1745389415.git.Ankit.Soni@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0009.eurprd03.prod.outlook.com
 (2603:10a6:208:14::22) To PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 (2603:10b6:518:1::7d4)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPFE6F9E2E1D:EE_|IA0PR10MB6698:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cd3ea77-8d7b-46d6-9f14-08dd832a4ed8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MXVycUkzYnRUdXJKTlIrVHZoK1h5RDR1OTJ1aWcvelJTMjZKSzVFamVDRlNO?=
 =?utf-8?B?OGZBaDg4d0hyUldHbWxMbkoyMXNkWGduWGpvODZ4VjNlOTBiOFZNOGVUbTlM?=
 =?utf-8?B?ak1MQnVFamZwY05GTklyRXNUWXgzYk0xa1Y4aGpRWGkzR1R3cEIrSlR3WnRL?=
 =?utf-8?B?NW00Y1VjcDgvdXM2eVhUSCs3SStKNTNIbFNKbTM0eHA1UjVza0JKaTFTT2Q1?=
 =?utf-8?B?eE9FcS9KYVNndEZRU2h6dTRwWUV0NE94c2ZRWVV2U0xXOHZWOTNYeC9rcyti?=
 =?utf-8?B?Y0t4WG4rcmhCUkpPN0pTQzFFMlJTckJRT0hQQnNTVTNtTURvUHByY3lUS1B1?=
 =?utf-8?B?VFlacnIwTm9vbjcvckJOOElKWnhXQjNUTUFiSE11NGZjd3NvMk5LNi9YbmtK?=
 =?utf-8?B?NWJXQUkydFpqK3ZYS3RXdmVLTFUrRTJRZDNpQ243bStBek16NkZDbkEydmMv?=
 =?utf-8?B?VXh0b2haR25neGtnNTF6YkQ0TGVROW1OVTVyUHhvRXpYdDJTU2pJYllWOXdT?=
 =?utf-8?B?bFhSczVjWG1rc2k4RzVXd1F3dmhPWWwvb2s1b3J4MGsvL3hLNEtuYUwvVDRv?=
 =?utf-8?B?dnVsTFFIMldsSzdTd0pmMGZoQnJ0VTZwbTFzWDJka2l0ZHBVMkJRVkx4WDZE?=
 =?utf-8?B?UExVNlhQV3FrSFIzV3dDYUNtVjZNbVpLMnl4WnpyUit2SGdiUnpqMkR0U2pS?=
 =?utf-8?B?Qk5LZVMrYWJWMlYwQmx3VUJOYXhxN3g2OTFlRER2MnpZZVBIU1p2KzNhdDFj?=
 =?utf-8?B?SURrdG9QOUY3TnZRdzM4V2NiS3RTaEtWN1NOWkVWZGZwSHZLcW9GMUY0ak9T?=
 =?utf-8?B?MnZSWGorL0NTR0NUU1JYaXp6NithOTRGV2hhYjFCeVJidTFLSGVSV0hOeTBQ?=
 =?utf-8?B?ZDNBTkR6UmRMR2M3d2Y3QUFBclhGeDg3Rmk5aEYzSlRYWHFyaHRwMlYxUExw?=
 =?utf-8?B?YkFqV3YxK1dkYjNzU1NEdHUwWmJ4dTlDVUNZN3ZSaENlRkQrbTNReE5SbVBX?=
 =?utf-8?B?RG1qdUhUVWdheVVNWGdyOFQyeUhiQW16MktEa1hvWXArSWZaUnhaZmhoeGN5?=
 =?utf-8?B?SlZXVEdCK0IydXJTQ1ovbDluV0RVZW1adkRrVFJHZU94MnB1M3kxbzJvanJM?=
 =?utf-8?B?K0phcDNKV1F0aFdqQXJiSTFjR0xzZWEzR1ZzTTc0L2YrYlZFMUtFV2sreXhi?=
 =?utf-8?B?bnF5T2hxdEdHdDZJR3ZrQ2owSVVNWXBOWXArcUppRWdBcHJyREFlVDJSZ1Jl?=
 =?utf-8?B?ODFZbFpHZGlCV3VNeEFTZU9TaXRuUmFNNWF6cGVTcy9Wc09rbVNTV3NFT0dy?=
 =?utf-8?B?bG9UMlFzUVB5blgxd3dnOW9XSUl5MTl0ZE9jamFiNzdkanpJb3NleVFvZ0hU?=
 =?utf-8?B?YS9Wc3Q0bzNqcUhna3V6ZVVMcEs4M1B3VEN6OVp3cGt1N3pYMDg1aTF6NmZp?=
 =?utf-8?B?QUROc3RCNlFsYUdlZGNtV3hORmFuSUNtN2xYaEpLRFpXbWlaRlMvQk15dk1V?=
 =?utf-8?B?VDFZMmViaVZ3SHFzK2JPSVZuQStWWCtBaFh2T1BFVFJZNEI3bkQ2RnJjVEFE?=
 =?utf-8?B?SDFaZUVYS3RWZCtrc2wyY0VWNlRZUGJJUWZPTXNEajQ0aG85MFdtYlRyUVlI?=
 =?utf-8?B?T3dhSktQQyt2QTZOQnNMaGlrenVsRWJWa2x5QlNSQm5Xb2w1MzVHaWRFb0ds?=
 =?utf-8?B?VzBUYnJLQ1VKMmRpc21kY2VtVFBqRUFiVnAvMy8vTURQYnNBWVBPZDEydDg0?=
 =?utf-8?B?RkRtTy9EWnpCVEoyRkoyTGtyallWazV2Ukpwc3lUNnJjZTFXNTVvNlNnQnhw?=
 =?utf-8?B?djdxdjVxT1dHZW4xWFgvWUJwRWNVUEdFbGVHbjkvOHI0UUZzbXBGVCtvUVNo?=
 =?utf-8?B?UWFwczY0azIxSXI2bDQvYlpBS05wV09xeXBqSDFBbStSYWlVczhJejJSbHQ2?=
 =?utf-8?Q?gdDetQJuMXk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPFE6F9E2E1D.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bEhwM1AzSG5CSWZob21WazZmYis1NWRnaVVkMVVKek1qL0M0TzJrSlNnV2xh?=
 =?utf-8?B?Q1RrNkN0T3hzM2FhOU90ZEorcnoySWF4V3h6RGtYTmxwSFE2TmJ2MjQ5ZHdo?=
 =?utf-8?B?c045R3FiREE5ZS9YemJwT2lBYmp2YzZaRmE2ZS90cmlnQ28yZFE5aXBBSWpD?=
 =?utf-8?B?RDFUNTRJT1RxUXdGNElQT05Ga1JtektxZmJmZDgvbGd5RG9VSGZxNG5RTkQ5?=
 =?utf-8?B?Mm9IRzUycFltdFlib2MwSmdzZG1jaGpLQ1F0cFhYWFNkUnN0MmVQQndYWVVl?=
 =?utf-8?B?REdFZGN1T0RKVWFxQVBSak13V1JlSzdNakhOd2g4ZldHZkdLZ2NxOXd5U0ZN?=
 =?utf-8?B?cjNHZE9HbU5PNmc4WXRGcmJPY3N0ckRPS0pVbC9TQjZiZFN1OTBWYndUbitr?=
 =?utf-8?B?OE94ZGlEYTA3RE84TFlYU1B1K21hOUZHRnRLZnZhaEdKK1ZlYnJQV2FDUlJE?=
 =?utf-8?B?eWN5bHhiSUtvTytBdVc3SWRuZk9ldy9saUxmZ0wyN3dXTmw0S2JZRG5Hdnkr?=
 =?utf-8?B?VmRDcGF2S1VETnFFc1lNSERHbmpzbG1XQTFKQStPdUtQRXZOelg5WjNFblQz?=
 =?utf-8?B?ZmtpMVF3Zk1VNWFKMG1jdlMxK3JSbVBTTGdlc1A5cVZWOTFXMkxCR09ZT3h2?=
 =?utf-8?B?V2ZVdE9qRE1kOEs1d044c0dxVEtxQ1c0dlVtT2w0dGZpRlM4bTZKYnhvOEFV?=
 =?utf-8?B?M0hpOGczSVBUaTB0VEpqVW8yQ1JOUFNONGJOSWtiN3l2R0M5Ykp2YzRzRjYz?=
 =?utf-8?B?STdDelQyNnlRblRWbWgvMFFMRzdKbC9HZnVSeC9qaHBKU2M1VmVZQlhraG9M?=
 =?utf-8?B?MWRPeFVrMEdKdmZaYWNLZTRtRUIxNTlMcWdWMEp2TFd5aGlSSE1EckcrYWQx?=
 =?utf-8?B?QVI5d3dUZjBEWUx3T3NESGNuTThyQm5sYjc4UVYyRGVFSm9yRkdtMXp3TTdz?=
 =?utf-8?B?QjlGNTZ1MHRJUkNmRDdGdzFHbkplRnBnT3N0SGFGK0dxRERVUHgrdytYMWE4?=
 =?utf-8?B?S21uNXhXa0pPdkVwaENsdHZ0U1YzbTBVMThheWVhMWdMZk43djNaWWs3eUJL?=
 =?utf-8?B?WmhONjVFdzN2YWtMSnFudTVlOUcyb3J6V01NODlPTjJiWTZXSGZPdE5tTSt1?=
 =?utf-8?B?VGh1ckJjMVhlcXhuSFVBS2lHdzJiZ1VtYnUwdnF6ZmxoblBqdFNYemJCZ1FO?=
 =?utf-8?B?QmJkTUd0VjIvdlNSRG50b1JSZFgrMEExaFVpYWx2Q2dHTXNzcEdGM2NhbVVG?=
 =?utf-8?B?ZzNCalBDcGZwNHhoS1NJcXByMmc4ak9PRmhkejNEU0pXUml6V3BrN2x2L0xJ?=
 =?utf-8?B?VDBLb3J0NEdKM1lsR1RRdHF0b2p0UCtpYVBlTDl3d25WblVoSVl5SlIwSWlt?=
 =?utf-8?B?QlJxVXFzWU1QaTUrRlg1clRmaXJ1UmZ5VEdlbkRmaTlqaTFodyttOWlZNXpz?=
 =?utf-8?B?dEt4WXRCcmdzVGhod1ZqNmExZHBkN2l4S0RNUXNBTU9BZzBML1dvY3Iza0Nu?=
 =?utf-8?B?Z3pGWWk2VGlwWENSTjQ4dllkcW1oMnMxbTc4R0FIRklmOUtuSDdOeXcvdzFK?=
 =?utf-8?B?QzlEUkUwSjB1ZWlONGFTWENZMjQ2Nm5nZjdaN2cyK3VuZ3d6SjJYOXNxSlIw?=
 =?utf-8?B?MHAwNkFMQ3hHR0QvU2I1NGtuaHdhajZZdlpiTnVTWCtxUm5keVRFTFF2dDFV?=
 =?utf-8?B?RTUremNQcnZ2YStwNU1hQWFQQ29GWXJ0UW1YSU5Sa2JvRVltZ01YYktwS2gw?=
 =?utf-8?B?dE84a2FsZ2czR2hGenUrQW5Ob3AvdUJlN1lwMCtqTHo0aEJwYkVFZWt4YlN3?=
 =?utf-8?B?ckxPbTZ3ZTZvTFZNVDE3ektPdTdha3V5eU44U3ZGeE4yUnAxNkpnNmsvZ0JU?=
 =?utf-8?B?OUJsbFR4dzFWbzhJaGptNWFDMjJwWUVRYWVPS3AxMWJnU0p4WHg2MG8wazlF?=
 =?utf-8?B?VGgyNDFHMWF6cnpMZG1FU2RSUUZrMkp6ekVFaGM3R3dXeHZlWlNHNTJiYVFO?=
 =?utf-8?B?S3o1V0x0cFlhY2J4UGRyRldFeHFCME5OSzVPVkgvNWtybGdaWnZURUcyOFo2?=
 =?utf-8?B?UWtZOCtUUlQ2d21XU0NHaWpBVHRZbWUwRDFwT01UdlhKSWZBQjBqL1hRSSt3?=
 =?utf-8?B?MnY0MVlRb253NXlSUmFYSkFUa2krdllrYmZuMit0VEFhZHhzQ3FuT3I1RFhr?=
 =?utf-8?B?RkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6zjaLWSIqyNdsjFJFMtH63rQFoWkJJVCVU/tkmyx+cphcBNPvZjBYhROnUiBzLOj9YTCPOn3QQg/PYZy2bWra4a6kop8vWz97xa8pKDzVnAG5rZAVlLXxP+EOkkm2dVJ285FwX/2JHlEmQGsyVoaOJfLELAH1r3zzgrIqGUtBo0Hqznqvqu4NcdQUQ94LrdNawJ+XTaciuQ4yyffoAkC01T3ugcCx4qyFDYdYVIof+qlqQMNgF2XYVndPysF0vgqK3q+JfwZmksMIZCdoV2nOqIZYHzP1jJ+MOnMkb6Aa3U6aRtgX33kuNL0kDQuu29H8qpSgiwBCQ+7o1YwRSTTDoBB+zhuWlZsCNdFxSIciKfhCsrxWWAGGFkiJoDZTgNOoPtAjXZtylPaoPuNd7aIiSeDXVGnKm6nqFCBtx/e+jGiRAE6r/J6mFQf2e8GMk4RM03b/96ae4XH7t0vLzsRkdaO4ILNHYl3duKDOOG5pYU9ZZJmDdy30N5NaOMR4+ZT7WK/vidRjC2NsYBWGwckB7fbqRMObPl+2N6JxbZb42/GekzIcupjkjuyNpitG/aehNQPetxL1V0vghxRT1UTyu6TbhM0jBDVlM0yRsaqwhE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cd3ea77-8d7b-46d6-9f14-08dd832a4ed8
X-MS-Exchange-CrossTenant-AuthSource: PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 12:19:49.4362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: klhmUaVR0VunjDs7Bli2PN5uH3FGn89TcmNYZEpMxHL3q47UBqCLTvyucWyzQDQv0M1Y9CCtmpRLRqxBavvdHLK6yVC8CXilKy86g7o9eBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6698
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_05,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504240082
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA4MiBTYWx0ZWRfX94rwxJNuaKWD 4RpyTxW69ECAu2DegojdMYjkBefDZquQyvSZyB5+f1b1YFEW0UzAUimFU68hbsgGezfJmoVnMdO ksQDWjbiSwN5D9sCQm7o/3G+SvDsLX1Qy5aNgwJPjBSCrLUe5Q2ZVWjaKnOxj5wZgBBfwwCaCLd
 9/3hixPAxFd5m5bS80vfq4fZI84jptaQRCDpIoq/gSKWVHS9PyhbWB9oL67QzxmmNpx3h12TyM1 b1VBcgCXrH0DFoqC95jOu/PUHoXpkLhjDwu4APOC2vAKXsa7qfHjXVnEyjmq+kxXqHZIAjDuWmT XfybeNO3cqggk9uKav7sDT8s4R8Gp4haRIgclFW9dFeUycYF07QYwPyJGa4Ilfv8TuvjLEsA/GW +I2rnhg5
X-Proofpoint-GUID: cJT89Ob5skcPiWYZbzwfNQmz6INgNNrp
X-Proofpoint-ORIG-GUID: cJT89Ob5skcPiWYZbzwfNQmz6INgNNrp

On 23/04/2025 07:50, Ankit Soni wrote:
> Current AMD IOMMU assumes Host Address Translation (HAT) is always
> supported, and Linux kernel enables this capability by default. However,
> in case of emulated and virtualized IOMMU, this might not be the case.

+Alejandro as he is filling that gap

> For example,current QEMU-emulated AMD vIOMMU does not support host
> translation for VFIO pass-through device, but the interrupt remapping
> support is required for x2APIC (i.e. kvm-msi-ext-dest-id is also not
> supported by the guest OS). This would require the guest kernel to boot
> with guest kernel option iommu=pt to by-pass the initialization of
> host (v1) table.
> 
> The AMD I/O Virtualization Technology (IOMMU) Specification Rev 3.10 [1]>
introduces a new flag 'HATDis' in the IVHD 11h IOMMU attributes to indicate
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
>  drivers/iommu/amd/init.c            | 23 +++++++++++++++++++++--
>  drivers/iommu/amd/iommu.c           | 13 +++++++++++++
>  4 files changed, 40 insertions(+), 3 deletions(-)
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
> index dd9e26b7b718..f71b236c2af2 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -151,7 +151,7 @@ struct ivmd_header {
>  bool amd_iommu_dump;
>  bool amd_iommu_irq_remap __read_mostly;
>  
> -enum protection_domain_mode amd_iommu_pgtable = PD_MODE_V1;
> +enum protection_domain_mode amd_iommu_pgtable = PD_MODE_NONE;
>  /* Guest page table level */
>  int amd_iommu_gpt_level = PAGE_MODE_4_LEVEL;
>  
> @@ -168,6 +168,9 @@ static int amd_iommu_target_ivhd_type;
>  u64 amd_iommu_efr;
>  u64 amd_iommu_efr2;
>  
> +/* dma translation not supported*/
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
>  	for (devid = 0; devid <= pci_seg->last_bdf; ++devid) {
> @@ -3095,6 +3103,17 @@ static int __init early_amd_iommu_init(void)
>  		}
>  	}
>  
> +	if (amd_iommu_hatdis) {
> +		if (amd_iommu_v2_pgtbl_supported())
> +			amd_iommu_pgtable = PD_MODE_V2;
> +	} else if (amd_iommu_pgtable == PD_MODE_NONE)
> +		/*
> +		 * If v1 page table is supported (i.e., amd_iommu_hatdis == 0)
> +		 * and page table type is not specified in command line, then
> +		 * use v1 page table.
> +		 */
> +		amd_iommu_pgtable = PD_MODE_V1;
> +
>  	/* Disable any previously enabled IOMMUs */
>  	if (!is_kdump_kernel() || amd_iommu_disabled)
>  		disable_iommus();
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index be8761bbef0f..0ebc264726da 100644
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
>  	domain->iop.pgtbl.cfg.amd.nid = dev_to_node(dev);
> @@ -2501,6 +2511,9 @@ static inline u64 dma_max_address(enum protection_domain_mode pgtable)
>  
>  static bool amd_iommu_hd_support(struct amd_iommu *iommu)
>  {
> +	if (amd_iommu_hatdis)
> +		return false;
> +
>  	return iommu && (iommu->features & FEATURE_HDSUP);
>  }
>  

It's strange we seem to somehow have host translation disabled, while it
advertises other translation-related features like the normal case.

In any case we should probably follow Intel's example (which does similar thing
to HATSDis) where we only call invoke IOMMU groups
iommu_device_register()/iommu_device_sysfs_add() with DMA translation enabled?
That should simplify most of the patch as those codepaths are not reachable via
kernel/userspace? Unless I am missing something ofc

See also commit c40aaaac10 ("iommu/vt-d: Gracefully handle DMAR units with no
supported address widths"). I am not sure what else is the closest example here
besides intel-iommu equivalent.
