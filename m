Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E491DF96D
	for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 17:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184542; cv=fail; b=BPmogV37najfcKc7G9BlcnemriHySLCHB2+kdQZf7lUPuLNLWmNpZwJ9glYUpQgRhK9VRIWTm+RZ+BOZHjpu1UywSQ+Zs94qYOpWjKwaXz2H1j+1V72eGbeEZ6t5VMe0gYTypa1G54UPR95OwCPbniEh77NblX2QNvMOLTCjMHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184542; c=relaxed/simple;
	bh=0EbdiPxBaSHL6VKlkiagZ50mqmSK6e2IclCW4WEvMGc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kk9rao2hX+Ts3+cNs3XI8wWYgZTPusdBl2JAftP+5+wWz2Z24X0qKq1ElcD4vqkq00skyKY+lzhV/YDRgKTZo87dDa1O33JA9BgbcZTkYKyFenLeT0pK/iPZlUTpV2TOyYu5ZKIEDhZiCZGV0pYtC6UpRg/99NtMhQjEzov5o9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cL57RDo2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UjWDupf9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cL57RDo2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UjWDupf9"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFBdYH025065;
	Thu, 17 Oct 2024 17:02:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=OxfvhVvT47mGNakhwzgcKBoszKLOMyd8cXhRTTY9CGE=; b=
	cL57RDo2wFSlO4IQweB27f0YuMNP9PGb9trD/5Y3+/Oe6ZDRVDCxEeZu97GZ5bum
	Jq5oXhd8MW+LC1/i9isGp57XON7a4/XWz/5imT4g2UWcCSLk5yks7hgrPM3zpRhQ
	6SEFnX3H1r0uU7gBn4PFZ+dgkZKPDb/+f3ZUT/ibr4pwCPh8WUQxlUzFSj42Vtfm
	Woy9MBHo+qkw36aefsNSCImkxT+fNYSjpEi2AQLMeacrDf6mMNYAFKavb/XKkBHX
	t3A6btp9rqBjdJZsk3X/jbVKfZuumulLEmjoUasnmuxVKtpAJwmCT+1n3bAGvypV
	AXsutvQjfS3oCsmKlr9fnw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427g1aprgg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 17:02:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFxgjU027231;
	Thu, 17 Oct 2024 17:02:17 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjh44b7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 17:02:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XmfQcD/75B+juO8njsGDL5WAaKmNMwHmpytIsDFhCIZDRZjXB742TECzcW5eI5c8RSrEhwc4vD+kk4aFzRGwCxxpg77/GtwBSHdungEyDXofMW+pRVBQ5hhxodsRZKdXEK9NQ2Q+mTgAvNuuEv6vEs7B4ksY1Cwg4bsvkOv15HM/cQbHjTagkYZP+uKHBByl7HqYozMQlIL/xxGe6q/KB+BC139jHf+9spqAqeMq/54dtsjsjXA/Fnjn6Cc6rFGsd5tRDx0ejnP7pnWg4so1m6UsVhvCOibuuaaaWnmRcV670XaBnpEgaK8PFqMx/hZZA1ns+Pa1tfD/YoVuFPZ4ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxfvhVvT47mGNakhwzgcKBoszKLOMyd8cXhRTTY9CGE=;
 b=cE8Xkfc+8j0f90VBCiimi2U/Ypk4b5lxPmkN+hMARNt4OhEj4x6RMi2++5UscfD5S7ElKALcZGXjDwhonELD4uRSzLIltBevH7QvTwBXfO9Wn09/Jgpf3001K7C2e7Ko8sFRrbij2OuHvYxQIYROpOiaimu5QIfL1Ez6SSaKAVbZ5NwdQjQsaQtuX3UZsBT6ydESDCvW0POYlYTOijLTQyYDppKCZzSIDqCC8Fm4/k4HFk7XbYA1Ns30Iia/I9+vGMaHRgCSu224bRVQwNGK0n6QfHX4xgxgLIMfgskZKjQ4NoljnGobU878P7tz6palV7OljxnhJWKEgRiDNXBVZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxfvhVvT47mGNakhwzgcKBoszKLOMyd8cXhRTTY9CGE=;
 b=UjWDupf9MMQrPR4KzMdXXM6xyRSoLl31av0IZy8UX476tcjuZhc9baz/xSIT12j+msiTG9HVCeZH0utCNb743veB81LjLmwCehQQDz+b/fCCk3zcXr17ZfERu2D4Z7GQmG0jEqJJ+awj74E9OPcp7+3pkRcUTV0WxFLmNTS3UWc=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Thu, 17 Oct
 2024 17:02:15 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 17:02:15 +0000
Message-ID: <6fdad0c2-8b6a-433e-9405-016aaee40413@oracle.com>
Date: Thu, 17 Oct 2024 13:02:14 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 8/9] iommufd: optimize file mapping
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>
References: <1728067700-32092-1-git-send-email-steven.sistare@oracle.com>
 <1728067700-32092-9-git-send-email-steven.sistare@oracle.com>
 <20241016130001.GI3559746@nvidia.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241016130001.GI3559746@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN7PR02CA0026.namprd02.prod.outlook.com
 (2603:10b6:408:20::39) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DM4PR10MB6229:EE_
X-MS-Office365-Filtering-Correlation-Id: 389ae7dc-6b3e-4744-ef03-08dceecd734e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VlMxSjEzbmh0MUhHK1FpcXg5V2d0bXJGQXlxL1dDSGZ2T1FiN3UzVUx2TU9s?=
 =?utf-8?B?dUs0azNZQ3VEb04wR1NpSzRNT2VQdjU1VGh3a3BSWU5QUmZob1R2ZmhxQ3ZT?=
 =?utf-8?B?aDJ3NUFPMlpLU0pycGE4YS9Qdm9GYnkvcVVwQ29SMmVvLzlzZnczdmFKZlRM?=
 =?utf-8?B?OWt2RUp4UkxuODA4TDlQMEhwTVM2M25OWmw2VkFweFFPM0pQSEY4Qmd4VFFu?=
 =?utf-8?B?Mi9vYXgreGxMMVRmQzF0OGF6aW5Yb3hZdzh1dEVFa3VSS0hOZXNJQzhtVGZ3?=
 =?utf-8?B?aElWQlpGVWpFTldrV3JZd3AzVUU1ZW9KdU0wMG5yN0VLTHpvZGZYb0lnd3I1?=
 =?utf-8?B?Z1Q2M3BOL0k4R0tlWkllVS9iVDJQTTBzQ3dhcUtmZENWcTlqTC9wejFGQkhh?=
 =?utf-8?B?TVRNbnhibWdtRDh2WFlOaTgzSTZ5bUlEcEgyek1IZXgwRUpNMnN1c25VRzJN?=
 =?utf-8?B?QzFqUW8vSFN0d2twY3lhUnNZOXdjaEU0eWxoMFlFNm50MUdQc1NwazBoQ1VE?=
 =?utf-8?B?aUtESGlqQXJjWjJJT0VYNmV6RUs2eHF5NU1qSytWZ0RBNi9pOU1jZ1VPa1pp?=
 =?utf-8?B?cS9GWEhVZ2pPdGdrNjVMaDVoMWZYV1ZVdmlvTDZSU2hKanh1L1g0cVlqR1Nn?=
 =?utf-8?B?REJOcUduTU9aUk5QOTJkdGhteWtQMG13N2Jta2JpL2pwcVg1U0NGMEtUWGEz?=
 =?utf-8?B?MHhZU0kybGtOQnVHWFd4dEZ6NXMxTlh5aVpGcGNzRjhWLzY1WmdxSldLcm1k?=
 =?utf-8?B?OHBXZko3STViU3dJNmFmaUN3U3JxREtVZ2hJTjFqdUwvSjlHSTQ2M2MwNGpJ?=
 =?utf-8?B?YUp6S1ZCUWNqL094b1hyZk51MlpnbmxURUJxWDdkeS81ZTRXaGlxbmVDZXEy?=
 =?utf-8?B?QytQa2dFM3FvWXJKbWZqNUcvbXRLdjZKWUdUUjd1aFoySnc2ZVoxUHlDNHhh?=
 =?utf-8?B?WU9rK0FveXFnd3BIRkcrZkt4eXdYWURYYTI1cTVWeld1a2VOT080N2FzNit6?=
 =?utf-8?B?R0x1QTRCVjRWTVNuV2FZbHRyTUoxTm5UaDdRUm1qUTJYWDJaOHAxTVhVSXZa?=
 =?utf-8?B?Y0QrNEl4UkNCNUo1S1dEbEV5WHhveGdqcDR6Y21TSlFkZHhEeGR3THRuUERj?=
 =?utf-8?B?UVVHTWo1djVvc2szdFhtMkJmR0VkM1pHTDNlMTdxSUV4aXA0T3FWVTV2cDc4?=
 =?utf-8?B?RS9vZGFTVzBDUFZPKzdudU5ZdHphMVc1VnBjR0RhVmp1c0Y5bllPbVpPUDd2?=
 =?utf-8?B?bkNFWVhzV3N0RUsxb2lncVB4dS82NlZFc1hteXdFeWRwYWdDR0lkbWZLUVBW?=
 =?utf-8?B?ZUVlRUpzTzZ0cmdSWGVXeUw0V0N1VFlSckNmMGpaQnliZUx1TUpndk1HM2hp?=
 =?utf-8?B?S1lXMng3dU4weTdkZkJRaXVkYW9ycVhENExCMzhraG00SVdNbnNJb0RzcXdE?=
 =?utf-8?B?R3o3UHFDUVp5aUNWamQrUWFWQ3hzek14bEx0UVVmOUh5NWMzbi9TQi9QdU1j?=
 =?utf-8?B?RU12Tk05bWpPQzdFYVhQaGNnR3RvYWZMbUl1bEpoRVNXOHE2R0M1TzRwalBQ?=
 =?utf-8?B?cGtocE9yUW1KMlp3WmNTbWdIUFpsVzIwSGFhbUYreXN4Q00yamo0U0k0Vjdh?=
 =?utf-8?B?UDlFamIvT1c1S2l4c2pDOGszditvWFo4SDJ0OVNCb1o5OGJ2QWs4cnJqa2Z1?=
 =?utf-8?B?K0NMMjVSbG5JT1V1RXRZWENITW9rUTVJYmRBOWhIeE1DZm1aRnJJb3FBMldW?=
 =?utf-8?Q?LgOkUPUAwrwG2l0+eE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MlMwZGxYcndoT01ENUZic3F2THpxTXlnNWIwWWFXelZoRWlueE1SUFlNaXla?=
 =?utf-8?B?ZHJjU3NsdDVBU1pscU53NHdLR3VKYzlRNkx4TWhGK1FZRTNvU1hqNjczRDNy?=
 =?utf-8?B?dm9wSkoxaHhOQUxhSExFUkFUM3J0aUlJSlJWR0lvTFdRK3FjUW5FdVVPem5u?=
 =?utf-8?B?RXd3cUtnTDVlU2J2MWJLSUttY3ZLa0U1OTkrTUZuT2lxajByYWN0Ukl6czYw?=
 =?utf-8?B?TnN5ekVSRzlPYkVxWVJjOE9sL0hXdlU1b3preE82U1lSZk1BaHl0dzhHM3NN?=
 =?utf-8?B?WVdhY2xRRCtVTzBTeU5GZ1h6T2REN0hqQjNXaE8xR1liVlRESUZMbGkydm42?=
 =?utf-8?B?U0Yyei9wK1ZoK2U2YTRmcWJQVGVwdkt4SGZUZUV5TS8zWGNnd0NxbjBsKzdI?=
 =?utf-8?B?d3I5dG4wYWxTWjZtSUtiTkoxSkxjVTQwT2JsV1VGWVFDZWpiMzViUitUMjNM?=
 =?utf-8?B?cUtnL044Z3dpSkYzcUdvdVo0aXNwbkFiVkxUUHpNN1piQXFkNDFMN3EyaDRU?=
 =?utf-8?B?dUVjbTNsYzVoenRTc25RZGxaMmRRdlVlOHhxMHh6T3F6YWxBZ0lHdERMMmpL?=
 =?utf-8?B?VlhtOTFoQkNVY0JtaVhrc1psQUEvTzBTMU9RbThzbG9NRDJTTStpTVBSVUZw?=
 =?utf-8?B?K3NLV2NMZnJDR29iaHV2dm9qejFFTVd1MzJ4MnViL1ZPbGtveVFySlovbFhn?=
 =?utf-8?B?ajZXVURyVVFqSFpqZTVzWnZHOVRJaFY5L2NUT0F1RGNERkV6NnBlMkhmdjlp?=
 =?utf-8?B?cWVFUU1LYkhzY2R1WHpDdU8vRDVxVjRDMCszenJPVUV4SHpwT0g1aVRtVytz?=
 =?utf-8?B?TE5nV2JOQ2JzOVJHcm42SUI4VE55ZzU5STFhMEVQblRFQkd1MjBNN3RlQThq?=
 =?utf-8?B?Rmh2ZnZ0TTQxbjJtbnpER2o4U3pOOG0xdXFmVFAwd2NXM0RMTEo2NDBRLzlK?=
 =?utf-8?B?QjFYa1BsNVZ6RmZUOWhZai9WZ1l6SWgyelA2dy9leEFmcENJS0tKNTVLY2pU?=
 =?utf-8?B?cGNWZFgxWnJFOHBwd2tUTzlYQjRDTHRia2dKMkYzODJ2cnVBYlpLVlFSQUor?=
 =?utf-8?B?OTVYMDJkU0g4K3VEelJYWkY3Q1ZaWjYrd1JONmVISnMzK2g3Y24yckphRHh3?=
 =?utf-8?B?ZWIyTUo3dTZXbjhkN01wRHIyQktNczkwdk14Y1lvMXpZMjJXaGFIYWRWVzNV?=
 =?utf-8?B?UmZvc2tKN1F4bGg0eXJQWnN6Z2wvckE0QnkzYmlOeFE2bmRqRENlZUhPZ0w4?=
 =?utf-8?B?djAvcnJjOS9Fb0NIZHhiNFpMUm9TdnYwMkZSUjFoOWgwMEhBNFF2Z05rTC9G?=
 =?utf-8?B?bnY0bElNV2FJNitaOTZJSFE3ZTNNT0ZxM0FWemZNYXhpVitmejBmY0RRM0xL?=
 =?utf-8?B?bTg1R0RTLzFXWDcwbS9TcFA4R2krRnZac2xPSU9mbWNYOGpUZHZ0WTh6S0py?=
 =?utf-8?B?S3Z3T0tnQUpLNENBS1N4QmFwSllreEpDaXJVeGtjbE5vaDBaRGo5T2gvdlk2?=
 =?utf-8?B?K3VCZ09MdUxyRmdUckxxUUEvcDVMYVAwTFh3Z29ZL3dVbnN6VDdoTzhRbmsv?=
 =?utf-8?B?R1RmQ3FIYlhWaHBvU3Z4WEMraldzN014TUt5R1VNWU5XdlM5MkcyYVNwalBr?=
 =?utf-8?B?K3lJaVlYTE5GYTNJaVdrWjBvQThrcVFSczNpREg4YjlMV01Ialk5eTZiYXRO?=
 =?utf-8?B?K1JlVTMvQXNvNFlqbklyaTZzbHZNYWNERk1aZ1VaUk1JaU4yMFFtbGcwdnRZ?=
 =?utf-8?B?VWJCdjFDTGlnMmN1R3BtTmZMODl0c21idmxUTVpqVk83YW91OHluMjZFK1Fp?=
 =?utf-8?B?bnM5QTdTL1p1SjNpcHpSWm95c3JGVnZoQndlS0VTQlFCbE8vZkd2RXZjdklk?=
 =?utf-8?B?N3pqelJqMyt0OHpRcUU2cGM4NmZVRDBZWFUvTmtsY1dBc0hjZkFNcncyRExF?=
 =?utf-8?B?SWw4d2szK0p6blR0K29KbWR2cVhkaWEybTc0bkppdHlHclZ0OE9WeTU2TldF?=
 =?utf-8?B?c3l4bFJTbFIvdkhqSFpuZjBHZ0xYWXJobHNjSnRLWHJUTmZEUWE2ZURHaEdm?=
 =?utf-8?B?RDZtb3VhbEhJWW1BMS9qb2lBZnNuWE1QOTZqMy8xdEZCRmNkc0ZvejhHKzlC?=
 =?utf-8?B?Wkh6enRkbkNLeHUzQXlqSXZJSVhHRE1Vejc5WER3TTdxVDVPa1gzeTVGcXlY?=
 =?utf-8?B?bGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bykHhMmi0u8ZcDAjNsH5Zlo7bNn6BaR0dlFV8HrVvG5HmpMdm+C6DgCXMEnKS9nAL0eAEnwRDuSCHxUV9JnNYWs6L4w1PQygHGtefSCRs65WWNd9kXzfKoK4OhH9D17p88Gy35+/9VLeGVkW3RoGnmdCoFf6eCme52XyhZa0Z2UusvE41Tjdi9cVqwfFdSm7WZGomx/Mf2n5sJWK3MSEp1QthLT5siI8DWPYSwIqYgD+nrodbZ2kqlAv2ny4yVk4maTfpw6HQNZfyPyge/ICmsFXSKVQWGExWT4dLOSzmWByAWmmed9PWkz/d53rKrqts5d4GXju9yE2fnwHI4QhF6Ph3UYcNtSRRoboc5aZfAJRL+4+eXH5gukGQbzn1p8Rw301CmuQIbvTvb+xphVK+lm4jrUVB5aiPWxUQr54JKtvBvawRgVXdWq9rKaLtRZa0hL1SH16vnbXgO36ZEyJSYrM2+xX1QxJTlGC6yiQGtwkuxfWVAWxA3dXo2V/vNpwBq9nAedmzAXOg5VzRXlN1sJssTfhUIQBGJOiWnpZEl2SAKG/rHehheIa0L9JsIPAJ7X2TSe9GV3K+KmpiejAJSHDMg0QtmZLFf08WfiZ3MU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 389ae7dc-6b3e-4744-ef03-08dceecd734e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 17:02:15.1115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sDpFleVbK8uqUZmAnusQ5utBFMwAHl9UC/4J90g/dlMEPCYP5m82Mjokjzwcyk8mI62n+X7oc439U5X6fVlB1vhOrEsyISTaeNJQojU+tI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6229
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_19,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410170116
X-Proofpoint-GUID: m_Q9_3vcstmmyXAzGj58z-PS-wn2SJHs
X-Proofpoint-ORIG-GUID: m_Q9_3vcstmmyXAzGj58z-PS-wn2SJHs

On 10/16/2024 9:00 AM, Jason Gunthorpe wrote:
> On Fri, Oct 04, 2024 at 11:48:19AM -0700, Steve Sistare wrote:
> 
>> @@ -347,25 +347,41 @@ static void batch_destroy(struct pfn_batch *batch, void *backup)
>>   		kfree(batch->pfns);
>>   }
>>   
>> -/* true if the pfn was added, false otherwise */
>> -static bool batch_add_pfn(struct pfn_batch *batch, unsigned long pfn)
>> +/* returns the number of pfn's added */
>> +static int batch_add_pfn_num(struct pfn_batch *batch, unsigned long pfn,
>> +			     unsigned long nr)
> 
> This return type is truncating unsigned longs to int..

Thanks, will fix.

>> @@ -623,6 +639,67 @@ static void batch_from_pages(struct pfn_batch *batch, struct page **pages,
>>   			break;
>>   }
>>   
>> +static void batch_from_folios(struct pfn_batch *batch, struct folio **folios,
>> +			      size_t npages)
>> +{
>> +	struct folio **end = folios + npages;
>> +
>> +	for (; folios != end; folios++)
>> +		if (!batch_add_pfn(batch, page_to_pfn(&folios[0]->page)))
>> +			break;
> 
> This function is really weird, why would we have a function adding
> only the first page of each item in a list of folios?

It is only called when we know that the number of pages in all folios is 1
(user->ufolios_huge is false).

>> +static void batch_from_folios_huge(struct pfn_batch *batch,
>> +				   struct folio ***folios_p,
>> +				   unsigned long *offset_p,
>> +				   unsigned long npages)
>> +{
>> +	unsigned long nr, n, pfn, i = 0;
>> +	struct folio *folio, **folios = *folios_p;
>> +	unsigned long offset = *offset_p;
> 
> Let's make more use of scope local values please (put folio, pfn, etc
> in side the narrowest loop scope) 

OK.  Some like this, some do not, now I know your preference.
I personally like to use local scope and initializers, but dislike when
cstyle it forces me to add a blank line after the declarations which disrupts
the flow/use of some quantity, eg:
   {
     long pfn = foo();

     bar(pfn);
   }

> and the style in iommufd avoids more
> than one variable per declaration

OK, I had not realized that.

- Steve

> 
> I would like to see this patch when it is applied but I can't apply
> it..

I will send you my patched version of pages.c off list.

- Steve


