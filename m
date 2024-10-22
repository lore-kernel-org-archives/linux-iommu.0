Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A7D19DF9E
	for <iommu@lists.linux.dev>; Tue, 22 Oct 2024 13:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729603643; cv=fail; b=g6W+sAaUGWDmdEkyQRAb2sel6N1ITRG+z5u7jieS8ar1aI/cKf85xzxWILQcmSHE7gteALHw7U/Q+fzpWOWyfz10Wgfcj9EXAMZWw53XtplvOSzVDq/g+IwE5G1JxmEwyoxwkSXR3j4RINtmhl95jNa9toqfI46zS7gXGC3xP/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729603643; c=relaxed/simple;
	bh=sx1rtN9ScbN49wxlv85BXT+dXMrJP/XwmWi488NHYXY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P3sPPqNKOFqm8VNRE5appOGN2qTu6jxFx7e33nBA3Qqzg0UoHRyGi/s7g7gPT+dlUkI5G65w95W7K+Phv69iCf4ehijPG+ayzVvpeC6Nuw8qxhnYpk8v0RW+aGvG/UUzVlo1MWa80ff0mXgFD7mLW1NgtuTXq2xWph+NfnaH2Us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l52+ekFU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jtYgsjfu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l52+ekFU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jtYgsjfu"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MCiKb4022229;
	Tue, 22 Oct 2024 13:27:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=pZajQU0hc2gPR2ZJZXt7AHquej/zwdZxAFlVCr2FBrc=; b=
	l52+ekFU/2z+oCNnfsT0ydl7fxPP5l+Mznlt1ufkBBWc4dKHNuVdJaECgpGJ0uOa
	nU3LL3JFKYHD/8TyO3Eqskt6+fxs6CmMsEItJNHXwP9pmQooasTamDtZV5ZDGoG2
	CeSM+kMSaGaLth66IqQ+WomU0rCj9WcEKJcYNYAM19I9JtB9JgopvAcA6NncM/mw
	+dnCGpyGh1dvzsloXK6POTOrKxnabooBqYE7Q5yWfXMzPKhWy3B8etkSARthr86W
	15UuI43Sd/GJ70etK9cm0IhM/tLct8w083uYEUbueR37vLnDpCB9rLgvvKIp1dbu
	uN5FjYYXpe3g3q/zKrTE2Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ckkqvub1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 13:27:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49MDFq4v012298;
	Tue, 22 Oct 2024 13:27:18 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42c377f778-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 13:27:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F+1bNKix4h+eZTN0hZDxQdk8c2mTZ0m8SQ20HbE/fltW57LIGCVpK+5YboNeccqRJe/BAH3b1avMKUNg2mgIkE2MORJnj4vmczG7UIoN03TqMpbS5LPxECt6Z6enrH40/9E4+cIdFR63ZKCGL9H6cxrbTHsPDnOWDQbZKUBkCVprIM9Zui/gxKiHwRjXUg2r98E2YG1xQVO8QPWNnhCdRx4S7eUKpQyJIaKzb+zjvv0wfTzKj3b1IbQyNBsYqtkmcRalZsz0yxrN+ruyW32FWKnErENU8+YZD48oqJLvahl8csCUxBaPuGr9Owvu6P6iYe7odeTR9cwKyMapFKkkCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZajQU0hc2gPR2ZJZXt7AHquej/zwdZxAFlVCr2FBrc=;
 b=P3IraR1DqOfMGr2TdPiT6ExUE97oJsG0mOeUywuCGShpAgdmu1ad84h3RqwxLLtDslDzilXk9ViorDTAJzH4HN34R1mhCWXPWMixyU/hOXPO9AGqXgyzxKTHTkSrothky2vxc43zDm9XYW0xSk4hIEYa+Eizc5FUt3SruAfdLI0xgTC6dtkN0Cxp/9lngL6zDj6/HjCyXgk8ssKPf1BRxwKrv5f89kl+KUpq1QndS53iw0i8AfnJrkXZq6xKAsx1WmX9s/54ChVK+xYacaZNQy9NxOcksjX2vfRxnqFhLZAwJP0L0Rz9gBDgo0ge9vfWcaJRh8gt1RKVQYldkKotBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZajQU0hc2gPR2ZJZXt7AHquej/zwdZxAFlVCr2FBrc=;
 b=jtYgsjfuT6A35QiPFPSlA3t7YKeHyxNj6g6lcZ967KNNbU+x7Z+unbJQl13e2/cblHLWZLJU6aKrDbkf4CH8fFLzeUTB+BzEOKMpFXYxBqAlouE+N3O/XenLQAj0ttUeTdYUNKcqsZDC4UqxT8aqLgati1UHZcu0vcePxz8cnWY=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by MN6PR10MB8118.namprd10.prod.outlook.com (2603:10b6:208:4fa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 13:27:15 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 13:27:15 +0000
Message-ID: <b5b4343a-cc25-4169-a853-4cfdfa17be18@oracle.com>
Date: Tue, 22 Oct 2024 09:27:11 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 9/9] iommufd: map file selftest
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, Jason Gunthorpe <jgg@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>
References: <1729286856-127844-1-git-send-email-steven.sistare@oracle.com>
 <1729286856-127844-10-git-send-email-steven.sistare@oracle.com>
 <ZxLmfyfXJ2wN72DD@Asurada-Nvidia>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZxLmfyfXJ2wN72DD@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0069.namprd05.prod.outlook.com
 (2603:10b6:a03:332::14) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|MN6PR10MB8118:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f3fa4d9-0e40-414e-a370-08dcf29d3eb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXZ0SDlUelZrYW4xRVdiQkd3N1lzak9SU1c0Q2VwU0xySXFlWmRBMXhmYTFt?=
 =?utf-8?B?MzVmbytvNWlOVjFCNzJidTczM3ljN2dLK2NnSEduOEdXSVRaUVFTVUJuQ2ZZ?=
 =?utf-8?B?VFZwNmcrVW1yb0l5a0VmWSs5Q280bHhSL2NlQlpZZVpYTm1SeGNhYWVZZUtN?=
 =?utf-8?B?bkNEREd2NXVMaWJqMExKNVlGTEtsZmpFZ1VHbUFFaHJnSG56dTltOWhRRlE1?=
 =?utf-8?B?VnNvVUxQdEJkbGJ0UUUyR3RwVnArWFFjVWdQdDBqZDNTVEFKb2FRbFkzb00y?=
 =?utf-8?B?aGMvd0FTSDVGYVFFaEJoRGNtMUc2NFFGZGhua0pRV0c5N2VxMTR1WWp5REkx?=
 =?utf-8?B?cTlTOTBVckE1RXpKb2dlaE9GMHo1dnk5SDBIZFlML3lORk44T1R4WlJNRFZp?=
 =?utf-8?B?WlRvaHAxYXpSS1c2NE9QTWJmdTNhUmROdGNNbEZDUHB2dW84SERGK2p1bnlZ?=
 =?utf-8?B?KzRoMjY3YkJqeFNMUW5lWFd0VG1tNCs4NWh1WUwrbk5rbWVpMk41cFNZbVU4?=
 =?utf-8?B?MnhYY3g4UG55b2tkWWVxQUtwczlWOWVBK2xBV2hka2hJRFRuSnRDTElMVHFz?=
 =?utf-8?B?WE5YbjFEVHl4V3JtL3pYOXRxYnlvMkwyTndFOFJtZ0dqS2JmR25IMWVkNkds?=
 =?utf-8?B?VmNwMEtBQ1k5dGdSV3lxTTZkNzBTTUVpWnp2UUo3UlJjSitjT1JWT0d3Z1Vj?=
 =?utf-8?B?RVpjcDVUVHhDK0h3Mm1QZEx3KzlnWTBPcTdNbGFyci94aEVzampXR29HWWNK?=
 =?utf-8?B?QzNFZGNIellUYnRENGlLa21ENVBBRG5lc2ZCb3lQTDRaTHF0RXdGM203YzFU?=
 =?utf-8?B?aEo5K3I1akZSbjNoOTR5d2M2U1hqTjcwdHN4RmdZaHd6UDdnd0l1SDQ4NklB?=
 =?utf-8?B?d1NQQjJGTmh3QnFndU81b1V2VVJCVU8wK1VtSEFYVlp3aEthL1BrNUNhWlly?=
 =?utf-8?B?RmFQRFVNWXpkeWdGWS9tRnk2ay9CakNzb0JGVUQzNkNxMVMxTFB4RlEwdHNa?=
 =?utf-8?B?c3V0YTJ5RWNZVnNCeFhqSVFGYU8vb0kvMDN0Mk1GT0kreW1Lald4Q1lHMjJS?=
 =?utf-8?B?YU1TaDR6bGZqRmhKSDVvdGlsWjh0clMzUVd6Sml4dm5zbjB0N3E5V2taVWFT?=
 =?utf-8?B?d3QvK0kzZS83Nm5xVDdtUnJ5Y0p5S01Ua0ZxSWdlS0ZYQ254SzNPTkN1OU5j?=
 =?utf-8?B?WlMzeVZJU2ZQbUgyUkgzOCtuTURuTXFJWEpRNVNIZ0VrRXNRc0ptbjYwNWg2?=
 =?utf-8?B?aXg0RHk4c0g0bXloR0hLRUpiQisweU9TUkFOTkNEWHBySnBYa3JRQm03VzRU?=
 =?utf-8?B?dDFQVEVMVnhMZkpQN2cvTmhaRnhMZElzbkVZVXhJcmk1UEtnbzI1dloxZnVs?=
 =?utf-8?B?eXQ3YjlYSWo5ZG9vczFWOGR0YWhJU1UralMxanhTZm5sOXRCNUlZTTZWdjRk?=
 =?utf-8?B?TzBadEhUN3dzeGllRHN4c3ZuWkJDeHlhRWd0WHpxT0FJQXNoOHF6TWRtTy9J?=
 =?utf-8?B?THpQUTBmZEV4SERtTlY0d3VPWlgzL0NEV2s3Q014a2sxMCtLZit1TW9KWUx6?=
 =?utf-8?B?a3lNbEkxSThkS0ZqY05ZSHZDbytUMjdST09FcUpGQUhpYnN3ZFNBempyb0ps?=
 =?utf-8?B?M2hsQW1xZFhicXBPY1JmTEV1aVF6TjUyUjhXV3BqUmNSN0VFL3VQblNuUExG?=
 =?utf-8?B?VG1XNXhWNUQ3eS9oKzdpaEZVOWgxejZMS05QZ1JpTjE1MnFmTnBjS2dlMGUx?=
 =?utf-8?Q?ZNLUdGkQmUr95T/q5U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0lLd1ZBdGMwcWNpYXRoV2k4S3FlZ3BUUEgwTGI3OVlrdkdFUlpPVjJRQ3Js?=
 =?utf-8?B?dkFVZnZqNndiOXFWbHlQWW5JTk5QVEJrVHgxOExBVys0eGpPWkwvVnEzY1Jr?=
 =?utf-8?B?aHNpSFNEeDZqNEpvTVpCK1ZZQVdvbGJBc3laVzRyQlV6T2xwenJkV3NhNVg4?=
 =?utf-8?B?Z3BkWnovOGdZTVBmUm5zT1ZUMW4yUjdIc1lKTUdLb2hMa25mTlBBUXBjRlFG?=
 =?utf-8?B?RUs2MjB3ckFrcURDWXdZbURLSHZpSkRuMDU2am1teUJBdHh3SExZem9TYURa?=
 =?utf-8?B?bU9tNDU5SVZpcEpTOXJjaFo1TnFJYkpTVUJmZSsvU0tGUHRxendSOVNRRXpa?=
 =?utf-8?B?Y0VXOWxxNGhlTlYxTXg2NWxPSDFiT240MWF6RFVCQmxTaW9rWnVVRWN6Mk9l?=
 =?utf-8?B?NFFtV1A4akI5bU9lcmFHMW5zVHNMbUFYeDZRRDhrdkZEMHZBSDhML0RaMUhl?=
 =?utf-8?B?eXlGTmg2eDdkb2gvb1RxWlVHUVZtOXk2TTRFOVhzQ0pUZWpmNUthbTNmdXNh?=
 =?utf-8?B?dDhKOTd0cUt1Zk5VdUsrNk9KeXRCbTVpbWV6b2pkVEJ0WmR0bWF2Q1pkNk41?=
 =?utf-8?B?OVhReTJXZG8wNFV3a2Uzcy9ZYmRSanRFL2ZqYWx1VjNFK2RuUCtHRE85T0Zv?=
 =?utf-8?B?NDJUMWV2Y3BvT0tiZ0ZLNFAvd2dCK0hhbnFhM0ZDSUF2eDJlSHB0MmpSc1Nx?=
 =?utf-8?B?Q1pjSFNwSExTbXBBck5tWER0dlZEZVErYjJJeEp6Zk5LMkltMDJZQWV1VmZF?=
 =?utf-8?B?NjBkam1wd3BoUUkzVXA5WFRHQUpHLzlmOVY0SHNZZWh4bXNUWGpMWHhqVXFq?=
 =?utf-8?B?TThwUG9Md2pRQTBocmJ4c3NpdGRCY3QwOEhYUXFRdFhQNEhSL0ZLakFxU05U?=
 =?utf-8?B?cUNUTUw0NlExRDMxOURIZTJjYlNqNW5uVzF0MUs2REpvYkIrMEp5UHZDMDll?=
 =?utf-8?B?cTBncEZWbW9TK0hGVU1xRy9OcHRaZmxESE1aZXFSN0VpSERUak9lbTBuUUZG?=
 =?utf-8?B?WE5LRWZOTE13Y3M3K1NYN3B0QjEwM1M1K3dsa2tOcjV1NVVRMjUwWWlVU3E2?=
 =?utf-8?B?aUIrR0FRSlkwcWp2dG5OcWJsRjlzY09JU1IrYUw3cDFaQlJsMXBrY1BXUFMx?=
 =?utf-8?B?TjFUcGVacUoycTJPSnZFR2VORlF1SXlUcWlseUs0dDJoMmx5dlhlZkkyZnlk?=
 =?utf-8?B?S1JUNWRtSnRXUEgzU0tHZ3ltWHhPWEtwNHpjUVZ6ejhvZ0NmS2VBQWRENDYz?=
 =?utf-8?B?ZEFtVVBiUUE3UGZKakxYRHY1MlBEWHM5bDc0SU1Ud0ZHSDJjWDZqS1FseUxi?=
 =?utf-8?B?eWtNak4zVG0rc3QxT1k5YmdRNkVkL3o2MmNSeWFUUVBqa2pFNHhiaXZ5dk1L?=
 =?utf-8?B?TEltQThmbllrS055QkJoRHpjaUpxeFlONHFaY1FkR3NJcUVVSHRGZEd1bnhO?=
 =?utf-8?B?MDNwRlVwelEycmM3WWVjM09kaGc1SU9hRmF6dzVraHh6Qlo2bWZoSTNvTzNw?=
 =?utf-8?B?R0NJSUh5UlJPMzl0enN3MzBVVzNDUldtcVBtL1NDckMzMUthckJxVnpBc2kv?=
 =?utf-8?B?ck03Nlh4MUg4U2UxdmxRLzFOR1pLVGc0Vk1hdmZSUDA1RlA2cEk1SGRhcW5y?=
 =?utf-8?B?ci8yRkZzRnNHRXhMWTJLOC92bFRtb3BKTmVXQUhPdVhnangwVnc0ZkJTQnpS?=
 =?utf-8?B?ZVgzdzRrSEE4RXFtSVU0NjZ2bE5NNFpLTWhNUWNHL0REL3BBWnBWak9YcFUr?=
 =?utf-8?B?TVdrSTYzdHVvelRRVXpBM3B4bmhtTkpUN2pwbTdhK251TVFvOXAzdEZTY1Fr?=
 =?utf-8?B?andXTW9nb1R2Sks3TzRjazIvSVlvcjNEWDRHUGs3bW8yb1k4Q1NmbWJmRGZx?=
 =?utf-8?B?V1VBTlpZVWo4SEgyaVVyK1lJaEJvK3pzZDFBUW94andEZGdGaitzZVBOUnkw?=
 =?utf-8?B?a1V2OTZpbjFpQTRTYVJHTnNOLzROMlRSTVZVNS9vSURjUVA5d2hlWXBDb1hK?=
 =?utf-8?B?RXFhaThBS08rZis0T3E4cVFtZnJXZFpBa056RGRUREZJSlBuWWs2VGlRTmVM?=
 =?utf-8?B?aUxrVWFkclhhS0wwaVUwV0FhcFdvSzBzTzFpcnNjSmY3ZGVuYVF0eEM1K01o?=
 =?utf-8?B?UVIydFIrM3pTQjIzK2c1a3poZmZVUjNLYXM1MlNVcHoxRDVYR3gvQm90eTZR?=
 =?utf-8?B?WkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	X+tHjAg4jaG24p1GGzza/+4M1jVVcqZbRvx9mzRXX2eqBfRnwzZEd2FMm5OTDZIWfCDmkn498nfdeXDclwdjb2O3u0zskweGrjzQI0yK/56vvfOxr3noLsT/5tVZ2XRdTxxLbJVCYNSpvdgCAKxxtMBaLbTRkAtSQeZDr/um1L2rG6lJvc2mTBwLIyTmBEpQ8gu+t2mzbNlT25LMtpApdzUObj6Itk9OKVBHSO5ynLoW5NKLQHk8zOnwmd5k0vUo1nUcqfAV9KVbF37rg+hNzC+EAye39d23plznLEeVr/pEtNvYus5e39AAzBnPX1mre7usvG9VeSQGaJrp+k1TvDo4+Eexw++nSkbTIfcfdtjKZV8eMbTIHlfxjiuronvv0MConUMLYtlp5MJfgnNvFgCTjrp3G8iH5akh8ueiaDs5iO8X+UaR9iuflotVhnBzlc41QzaCBohVIOcw2CQ1SnYqJyP5gC/VESnv6OTh3eBWkc/qMuJ54DoV5pJEq80CgOazO8xrA4YC8jatp1mPHfSJIUeJMBwPOqCRYrBjX+06sByUz/fWqxHLrAa96lXpNuRFyjs9LhxS86ZZk5Muvakl73+ncxdlshkEvRykXuE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f3fa4d9-0e40-414e-a370-08dcf29d3eb2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 13:27:15.7370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j11jHmWiz1+tyP3J6hATl5Z+w5c0ar5Kfd5fXSF1nus63wWH6/OiwqwcL6nNZdwgki14FmJDk/T3U2hDbit7RJC3yeWHcghOUJIRE8rL/3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8118
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-22_14,2024-10-22_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410220085
X-Proofpoint-GUID: owMxGKkM-7_WsBrnaOzThh2LxpZsQp7l
X-Proofpoint-ORIG-GUID: owMxGKkM-7_WsBrnaOzThh2LxpZsQp7l

On 10/18/2024 6:51 PM, Nicolin Chen wrote:
> On Fri, Oct 18, 2024 at 02:27:36PM -0700, Steve Sistare wrote:
>>
>> Add test cases to exercise IOMMU_IOAS_MAP_FILE.
> [...]
>> +static int _test_ioctl_ioas_map_file(int fd, unsigned int ioas_id, int mfd,
>> +                                    size_t start, size_t length, __u64 *iova,
>> +                                    unsigned int flags)
>> +{
>> +       struct iommu_ioas_map_file cmd = {
>> +               .size = sizeof(cmd),
>> +               .flags = flags,
>> +               .ioas_id = ioas_id,
>> +               .fd = mfd,
>> +               .start = start,
>> +               .length = length,
>> +       };
>> +       int ret;
>> +
>> +       if (flags & IOMMU_IOAS_MAP_FIXED_IOVA)
>> +               cmd.iova = *iova;
>> +
>> +       ret = ioctl(fd, IOMMU_IOAS_MAP_FILE, &cmd);
> 
> For a new ioctl command, There should a TEST_LENGTH in
> TEST_F(iommufd, cmd_length).

Thanks, I will add this.

> Also, we might need something in iommufd_fail_nth.c too.

Thanks, I'll add a map_file variant of one or more of these cases:

TEST_FAIL_NTH(basic_fail_nth, map_two_domains)
TEST_FAIL_NTH(basic_fail_nth, map_domain)
TEST_FAIL_NTH(basic_fail_nth, basic)

- Steve
