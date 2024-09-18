Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB511C1ABF
	for <iommu@lists.linux.dev>; Wed, 18 Sep 2024 14:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726671115; cv=fail; b=UWJmk5PWLdUZ8WKffRMTuJdFShfWbjc5wd3yFUcnSh/m5abGJdm7W9WHJB4JxQ+APowfwVWQHemJXmZIX184+1DLyJ4Wk5Kj0vAJFNvWigSQ8JaC2gFABh/kZiMYd8PE09vlaQsTDL1EN2W2/Globtdz5qriG5eHsrG0f2739jQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726671115; c=relaxed/simple;
	bh=N7GQrywbG3PAnH5+/o8F7o4OS2gKqh+BJ7ebAmFaH0A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s20GNnqflRYk3GrIl2b2UJJs75KQ/1POfCibv/2f/yFXUqdXG1vwOV9JKNGqDj6CW1xib7PDZcd0tb5qjwubKbi5MePitOksQOXlw7X/CYH0vX5x7uhkO1i7WMjXXEJnnhpMZQuKQ0dyiPIP2iyRI115W5ataShpLGTpfhJNWdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=END2GEyI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NlG/vAEF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="END2GEyI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NlG/vAEF"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48IEl5Wq027817;
	Wed, 18 Sep 2024 14:51:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=jHmLUmygNrIgczpfrhW5rnwwlpQL8DsCHXXd87u7PIc=; b=
	END2GEyI2ovi/oebhXGsDbsOt+NsqGcXPuDfmjjgn9J39kMkT28rK/4WhFL0SiRJ
	gO5eutcuJfbkDW3MZhTiIVqjCslwbndzndWeZIvkXsZZOdtwXKItfWKph5Jcq5x0
	VQmo8ceardct2zY/hkHBIhBM6ZHXDCJ0LvwoRPo8dBHD3ecBVb7YJmwgfNIiPnmn
	JeRX2MEGeiF/1IfjPdFS3tqL2LdpsSx20SH1gBquzZg0KY2ZpkTA4qlIpbinrlMj
	lZiLoZZfunIfssHnARc15JDqCJ/UcMs5th4u8OvYB8j98vyjG5PIWFUZd4aDgWSs
	0Wlgyrrf/ntPwmMjtYo+DQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3n3hhtg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Sep 2024 14:51:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48IEK9As014976;
	Wed, 18 Sep 2024 14:51:50 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41nyg4q0ru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Sep 2024 14:51:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ipb7lAfi7HRLwPffu4ASv07tT8b3hp5NS8l/5/IhPaBnewB92CFEbyeWmrnonxH1tb9N4hE/sItkwF/Gt3me1N8oNNlVFZxqhY8A6ANI+h95SOYgUHpeiJnDNb0Q9U6msnmyqcr/7l/BDoYdGhPQ3xxOnWPQ2o6awNTL7j7gur36LEWmLw5RQUGjwUIAZNcIsjuf1+UkJMzzqb2PfDGoGlAVaGWmZCCHx6fc7OqVNUQw+Bj8eNXFFoXBkgC1DCS/mIN7Mx1BkgxbjpDyLqk6W/WG/saVHlVFScrgz6qLTOIi4jFZTAR0DhQFEjOQpIXcoCPVvMUca35gYMeZdMHmcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jHmLUmygNrIgczpfrhW5rnwwlpQL8DsCHXXd87u7PIc=;
 b=QxelK4biZKEAekF08k5ynDcxp0oH+Muc9v43UXjUzXaaXLUMXXYAnyqkhtdCflDnw86ANLTr16Rd58/Bn4TzMXLCiKUdc1WJtwkxAp835oQUbJO/3zIV0P8q1+6DWgNprpnFLFV4W7v0+s/2J9ISejq7shx44vKI7wboz2Vtr5DFIkia64Llu+DHrgCXCHXBmg9TNc9jsl4nECDghp7FKcJU8WYHoshmkedHW8TsE107rpKRH13Kn08nKoplBK0RRhpcWzflOTUBBYWBNMdbbbLATRDpkh3klxIiCsfARiQwlKbqI4h6JD+C+QC3ykOIqx/xVTh3i8Yj2EDFlCuZaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHmLUmygNrIgczpfrhW5rnwwlpQL8DsCHXXd87u7PIc=;
 b=NlG/vAEF+u7WuYMCR8f5cUlgHI3RjqzXk1NvwBafCOT9DoX9q2echtyfWWDqyesT6T1zpcSdLxT9PfI3o6zukLvJDlS1CaUvkXFz2ng3MOgUIM78hE4fwCJtkhjfaGpS07CU0rT89zIU6ZvLp7NjOZ87VS7GCk5Se6WejRuOm2A=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CY8PR10MB6825.namprd10.prod.outlook.com (2603:10b6:930:9c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.17; Wed, 18 Sep
 2024 14:51:48 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.7982.012; Wed, 18 Sep 2024
 14:51:48 +0000
Message-ID: <157cc762-be5d-49df-8051-412ef5bcd8f5@oracle.com>
Date: Wed, 18 Sep 2024 10:51:44 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 4/9] iommufd: pfn reader for file mappings
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>
References: <1726319158-283074-1-git-send-email-steven.sistare@oracle.com>
 <1726319158-283074-5-git-send-email-steven.sistare@oracle.com>
 <ZudIu+nvmY1N0CKR@nvidia.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZudIu+nvmY1N0CKR@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::8) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CY8PR10MB6825:EE_
X-MS-Office365-Filtering-Correlation-Id: f05da44c-6584-4d86-75f1-08dcd7f16c29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WnNORWdSUjdOaldJTzIvWUJQWlAzbTdTbzRjZVpPODR3QUxJTXloL0p5aitz?=
 =?utf-8?B?MWoyV2lUQTIxNmNoaXk0OXQxM2p0bE81aFpKeGFTdDgvTFVKOFBDNTRSUllR?=
 =?utf-8?B?ejNldzNocmN1UlhhOEtBOVhjSElIdVltdEc0bU5wQUpmL2dtL3JSMDlWZUZh?=
 =?utf-8?B?MHRLN040ZzlRd2FaQm1DUUl0RHJHVmJKbG5lTjFMc3pvcHkzYXRtaVcvaXJh?=
 =?utf-8?B?N0xnbVR5NHFHMldQT2ZTQ1gwUUExaUlqeXl3akkwbXBwc3huWEc0enRXVkpn?=
 =?utf-8?B?QnQ5N2ErdjR6VGUwMmYyeTNmUER0dVNrOEUvREF5b0FXRWZHcDhVaHlzRDBT?=
 =?utf-8?B?THlndTRMZzdzd2JCUmNnV2lPNVJpQzV4WFM4aHVCdXliV0VES3dMdGEzQ0VC?=
 =?utf-8?B?TE0xcll3SGZNcjJia2RYUXRndlMzSHlSZ2FpV0lXYkF3dXJoNEpPTlZFeDQ5?=
 =?utf-8?B?b3laMFg3b1VjazhwZWJIckhIQU9Ia3B4KzFodDNBRXR1dDhMT1NTamQrb2RW?=
 =?utf-8?B?dHpUQTlBR05WeHo1ZUoxTlBFTS81UnVGQUpsbUlCeFliTk9pRVpnbGNmRjdB?=
 =?utf-8?B?ZXBkQWZ5ZFdHWjhiR2YyeDRnL0thKzFFeUFMZ2FZM3kzNk1Velg3NFZaeWlH?=
 =?utf-8?B?aGJ1ZGFvT0QyM3JOWE5nQkdLNXVwSzM5cHZYbXFPRUZVUk1wTHNEZ2s5NGxU?=
 =?utf-8?B?Z1JQYllkamk1MEsxOC9lbDRpY2pwVmozZ0pWbzU1dEtJNWFhNWttMFRLbnI0?=
 =?utf-8?B?SERzZGZFY1RZVk1iTDVINlR0aG1PQUU4ekY2WEtiZWNYUEp5MGd4eWtNWDZO?=
 =?utf-8?B?eHZpaVdEc2RhTEVpSnIvZG82b2FLVWRwUisvNDJBSHF6WHZQV0s1WTNGTlJT?=
 =?utf-8?B?bjZ3KzQxV1F5bEZLYjJtTWN3OFdYWTNEWkx0ZUFyUS80VXdya3d5Y2tUbUFP?=
 =?utf-8?B?Znh0TzNNelE1RG5nbE9UbStWNkFacmQrTm1pM0Q2QnNDWmx0cFdGcVJab1Ex?=
 =?utf-8?B?SERkQlJRS3FkL3ZCclR1clVldnpRWjdpZVY5c0RwSFJaNWxTMlpNQUptQWhU?=
 =?utf-8?B?eHNZWE9abEI0dzNibDVlTnJLM3VHT2kxQjB6Mng4Y2tueGZLWFhqRDI3MEx2?=
 =?utf-8?B?c01TZVkvZWF5eXJHNXBIWHRlMG5xOXhKeGpDKzdjSGZXZGQ5MXpEQWQzYnNI?=
 =?utf-8?B?b3JsT2R4dThYenBNNk4yQjd5NkJhZ1FGRWgrVzBuZkpGNTZPV00yVDV2Z3Mv?=
 =?utf-8?B?VXVOSElrMzdjT0IxRWZxVjVWSldGRitodzY3TTJlUDVHU2tZU0VuVkd4V0pN?=
 =?utf-8?B?WXV3OGJQSWltcnBLdmU3bThMYjdjV052Umgyc29wWmR2STgvaURrbG5HUHhj?=
 =?utf-8?B?VGNoc1V1NHp0ZGpHR0FML0pWOGRQcHRmRlpMd1ZlUmxXYW43bmZOc2JURGdG?=
 =?utf-8?B?QkpmVHhpS2Y4eDJnVFR4aGFCZTIrL3liZktoSkR4SGNOcWV2V29GZ1RIeW11?=
 =?utf-8?B?RW85dnM2Tlg4dWt3ZFJQWDBNOWJ2aVBRekFhNVVIOE1MN1hLN0lsWUdFQlpp?=
 =?utf-8?B?azloSm1MKzY1ejRPZG5HTDZLNk1YS2N5eXJicURjUEd2T2xaYm5rSHZrNElO?=
 =?utf-8?B?ejk3QVRyYzRWeWFZYmQxM2ZGTEVCQlJDSS9IVE11eTd3R05acjNxSDJVSFp2?=
 =?utf-8?B?NHNSZGZtZXRBeTZSYzJmUC9kQndkaVRrT2tGTXI0bEs1SjF4bXZTRVJmNFg0?=
 =?utf-8?B?dGJMSGlxZnRzWDVSTU1WUEZkUjd2QXNQNkZRUUwwUmhaNE4xRzBLN1hZOHpu?=
 =?utf-8?B?NXVIZXVWZzVJQzJ2TVloUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVowUlhocUdMekErbThhV3VLdStVRENDRmJNd1NTeUxLY3V4aUJwQ3crWjQz?=
 =?utf-8?B?Y0MyRElYemQzWEZIL0thSEU5VGh0SElEN0RpbC9MMVUzRVFDV0VJTDIzRlI3?=
 =?utf-8?B?UE9samcvMVp1ZWpjcFdxT0ZUZ2NwaU5udnBaVVhTbVR3ZlQvaVJ2dEZYeDM1?=
 =?utf-8?B?UXdDMmord01ialFOK1RiMnlwTEZnM1BlZTM3WW5nWU9VU3NxeHNYS2gzaHJm?=
 =?utf-8?B?Mjk5TUpseTRrazM2VlNQQ1BxRUp2U3hhUjRwWEkrZ3MrREo0U0tsOTlITkpk?=
 =?utf-8?B?K1AzY1gzaE93Z1N3ekJkaUdLRzdCbWdWV2JodWF1RExPUUNvTlpPQ1M5Zk5m?=
 =?utf-8?B?bkxSZXFtNFprUHozeWRvWm9paStpeEVLUzRRcVJqdFRWVXltM0dFMkpMemx5?=
 =?utf-8?B?USt4NjN3cmVTQVlBYTlaNG9mc0xDSTQyeG5DM1NRM2pieHBWeXVjTHNXTlA1?=
 =?utf-8?B?enJBc285SkJBQlUvSnJ3NlNnbVlQK1JFMzNPNjkwQWVEcXBBWHVpRUMzaHY1?=
 =?utf-8?B?b0UzdlBRRy8vUWpOMzhGdnh1dUxRem05eTlFMk9ZWmdBd3VTMWFXSHhpWTgv?=
 =?utf-8?B?SU5zcVhXRHk2VUtyOHJpQTZGVEozS0YrYXhsQlpZQUljeEliUG1ITWhwaUZZ?=
 =?utf-8?B?ZWpFajdidHdseUl5dlY2THJLVEx5R28velM3TE41eGdTemxkMXJRUGR1NVlq?=
 =?utf-8?B?VjVaS3RZcW5EVFBGNTFQcWxkQU1lS3pBdjJIU0VlejFkTUsxYkJra2lyclR0?=
 =?utf-8?B?eGRXdGVzTFR5MkxpZEczTFE1cWJ3UmRpQjlYRVY1YW9mdGRGeHNEbnRnT1lD?=
 =?utf-8?B?YnM1V2JSSGEzZFV4RWdKQkZXcHZqZUx6bUd0ejB0V1VzY2wycExGL082V2ZW?=
 =?utf-8?B?eDN1cUV1NHJSNFZYZk11aGpNUjRpMjRSUCtpRjE3VFgxUTg5eXRtSFkvRCsv?=
 =?utf-8?B?a0F0VThVUDBNd1UrWkcyUTAzQmdpbjF0eFFjMklPSmZYU2dHblBMTEZBUnJP?=
 =?utf-8?B?ZG5scXZnZUhHLzh2Zm40Uks3VW5xYkk2NjRiNHhFNXBpZU56VGY3OGtIamNZ?=
 =?utf-8?B?YlVXMUFhWGhyVkdMK2tQK3dKd3hNSUF1dEhDb0Rud2QrMUpmQm9DTklnUVdM?=
 =?utf-8?B?MEhEQUJVRWdGVTlqQWVxL0JEOXNuekFTMjVsVUxBUVhhM2NzYWZnM1FRQzdx?=
 =?utf-8?B?ZElHTXNJVWY4SUJab2NaaHNXcHZMb3Z0cnJCZi82K0NGaVY5c2Q2RzN5Rnda?=
 =?utf-8?B?SUpOZXlyeGovK2luc3VYQUJ6V3JuTUQ5YXJnRU4wWGhHUUp5cHRoQjhIVW0r?=
 =?utf-8?B?dllUNFU4NXhGM2wyaGhnY0R1STNTZ3hZYWQvdnpWUWI1bmpsK2w3RFd3Y291?=
 =?utf-8?B?NUpYOVpPdkg0c09lSVVkVVNvVzNYbWlvMU42aFQ2aG12Y1picUxhUHg0aW8y?=
 =?utf-8?B?WTBNS2RNU292K0tETWdocUNEVCtwTU80WlQ4RDF1V2RHK1A1SVdPaDl6T0R0?=
 =?utf-8?B?QTRzclNPZERqVjdveFpuM1FoY0NvOUtURzFTekN0NmR6T3lhblhjYURzWFZ3?=
 =?utf-8?B?Z2lRR216dlEwQlI1MVcyRVpUL1NsQk9QQ1hZcXluRmdYcVdvLzltZlA2VXhx?=
 =?utf-8?B?OGkyUUxHWFY2THRQaFZ0ZW9qRDl3VGh5elpuVzREemNPKzFoWFMwYjE2SlVv?=
 =?utf-8?B?QkMyaE81UnZLVUh3YjRDemV3QVJCczNsWW9ZejJZMldlQnBzVnd2T1hUT2tE?=
 =?utf-8?B?T293d2hFeXlzcWMwWGtZTmU4SDVqT1p6a1hodlo4Y3BxV2RDa21jcStOTHY4?=
 =?utf-8?B?RnJLSTFYRXk3SHN0aytqWnIzUzhnYVF2TzRqOTBwQXJWNEZYM2Q2bnAvSldk?=
 =?utf-8?B?KzRRMXYxMVdYWUFrblhsdXhHYzBnUi8xdWw1RXB3L0c0MmoyRVNIVmt4Q21w?=
 =?utf-8?B?WEQxZ3R3clpPZEpZeXFLOHNheWUyYUx3R3ZhL2VOeDBOWFk5c1Y2NDhxWmdo?=
 =?utf-8?B?OTJYZDRnWitrcHYyTDRJMEZ6cVRjbXh4czYxYlg0MkNyRjJJWW9QTGJ6SEox?=
 =?utf-8?B?U1pwVjJlMjluQ2NVclRpRWVlR2dJdkM4TXJzR0lFWGlmQVpmRU9PbGM3TmFa?=
 =?utf-8?B?WWVlL1NaY3o0TGZXSzFZemc4Z2UyUUpIaTcvek53a2Zpb09YT2NOUTBFaXdl?=
 =?utf-8?B?TUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	K9uKEd0gYpnKlD62v7uCsgwUOPRVCHzLBS/QXvFEBVgm51lFBSpNVs69AvWXYmOuFoJdoz2S6BqUw9GfPvcJs6g8MPQRX7C92syEvRPBT4z+k5/PKcZkugQfQlyk+NV89E45x8RH3tddS22t8BYIeolDlczAvTwOKkGT8cgC27txwwmGYW+ATf+++al3/F4BC3KAMl+OCSEelR+2VRjzQGAPyAyIQ/muSQoop7CYMnoA8mUVHvFxNnx/hCVMny6IbP9vgWRIRhp026vVWwgTgmrBoc4stCziwDEAEvYxmh9QQDJAN8Z4UaL7nfrvkSdFX6C0Copfj4q4kjlXAPDfBK4dnMzzxY8F8rjhjuVuFN9YeXZJJYHYpoYVxXhaRDjUZ+VeCva/l/cVBuqIQMWavL+OuvQRaONnrOdF1WwNTmW6zebkLckocPe/JsHX7gkFnE9238EO57fcRHZ447aWsZA+CfWyVdY7Gt/ptboPHY8PdK43+4Kg6jDUkLqKdNaNeVGpTjcVxmO0Onnx+E3wIo1/XL8yxnmJ/BxiikGv3fCI7RsJZ5OgKvxpFGRamCwZyUMhmchawk6mm5OfOWzvhvHVkQe5iJl/tZp+D91hRX0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f05da44c-6584-4d86-75f1-08dcd7f16c29
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 14:51:48.3235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N5Qb3/jQVsGRqL7y7wDrmA6PRBNX9C6vOxmgjdjEIFmA9JUM+sfZmV4cnddIt1rx2dnAoR4DG7CG1kchA7ZYIYynxnbhxQs9XyIv+nWhbM4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6825
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-18_10,2024-09-18_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409180096
X-Proofpoint-GUID: ka9jS302X2Jz4buyyugfk7ah-ihS4dYA
X-Proofpoint-ORIG-GUID: ka9jS302X2Jz4buyyugfk7ah-ihS4dYA



On 9/15/2024 4:51 PM, Jason Gunthorpe wrote:
> On Sat, Sep 14, 2024 at 06:05:53AM -0700, Steve Sistare wrote:
>> Extend pfn_reader_user to pin file mappings, by calling memfd_pin_folios.
>> Repin at small page granularity and unpack pages into upages[] to mesh
>> with the existing code paths.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   drivers/iommu/iommufd/io_pagetable.h |  5 ++++
>>   drivers/iommu/iommufd/pages.c        | 58 ++++++++++++++++++++++++++++++++----
>>   2 files changed, 57 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/iommu/iommufd/io_pagetable.h b/drivers/iommu/iommufd/io_pagetable.h
>> index 7c4a338..3a28f46 100644
>> --- a/drivers/iommu/iommufd/io_pagetable.h
>> +++ b/drivers/iommu/iommufd/io_pagetable.h
>> @@ -177,6 +177,7 @@ enum {
>>   
>>   enum iopt_address_type {
>>   	IOPT_ADDRESS_USER = 0,
>> +	IOPT_ADDRESS_FILE = 1,
>>   };
>>   
>>   /*
>> @@ -202,6 +203,10 @@ struct iopt_pages {
>>   	enum iopt_address_type type;
>>   	union {
>>   		void __user *uptr;		/* IOPT_ADDRESS_USER */
>> +		struct {			/* IOPT_ADDRESS_FILE */
>> +			struct file *file;
>> +			unsigned long start;
>> +		};
>>   	};
>>   	bool writable:1;
>>   	u8 account_mode;
>> diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
>> index 69822d4..065c28f 100644
>> --- a/drivers/iommu/iommufd/pages.c
>> +++ b/drivers/iommu/iommufd/pages.c
>> @@ -695,6 +695,7 @@ static unsigned long batch_rw(struct pfn_batch *batch, void *data,
>>   struct pfn_reader_user {
>>   	struct page **upages;
>>   	size_t upages_len;
>> +	struct file *file;
>>   	unsigned long upages_start;
>>   	unsigned long upages_end;
>>   	unsigned int gup_flags;
>> @@ -712,6 +713,7 @@ static void pfn_reader_user_init(struct pfn_reader_user *user,
>>   	user->upages_start = 0;
>>   	user->upages_end = 0;
>>   	user->locked = -1;
>> +	user->file = (pages->type == IOPT_ADDRESS_FILE) ? pages->file : NULL;
>>   
>>   	user->gup_flags = FOLL_LONGTERM;
>>   	if (pages->writable)
>> @@ -733,13 +735,54 @@ static void pfn_reader_user_destroy(struct pfn_reader_user *user,
>>   	user->upages = NULL;
>>   }
>>   
>> +static long pin_memfd_pages(struct pfn_reader_user *user,
>> +			    unsigned long start,
>> +			    unsigned long npages)
>> +{
>> +	unsigned long end, nr, i, j, k, npin, nfolios, pgoff, max_folios;
>> +	unsigned long npages_orig = npages;
>> +	struct folio *folio;
>> +	size_t size = npages * sizeof(folio);
>> +	struct folio **folios = temp_kmalloc(&size, NULL, 0);
>> +
>> +	if (!folios)
>> +		return -ENOMEM;
>> +
>> +	k = 0;
>> +	max_folios = size / sizeof(folio);
>> +	end = start + (npages << PAGE_SHIFT) - 1;
>> +
>> +	while (npages > 0) {
>> +		nfolios = memfd_pin_folios(user->file, start, end,
>> +					   folios, max_folios, &pgoff);
>> +		if (nfolios <= 0)
>> +			return nfolios;
>> +
>> +		pgoff >>= PAGE_SHIFT;
>> +		for (i = 0; i < nfolios; i++) {
>> +			folio = folios[i];
>> +			nr = folio_nr_pages(folio);
>> +			npin = min(nr - pgoff, npages);
>> +			repin_folio_unhugely(folio, npin);
>> +			for (j = pgoff; j < pgoff + npin; j++)
>> +				user->upages[k++] = folio_page(folio, j);
>> +			npages -= npin;
>> +			start += npin << PAGE_SHIFT;
>> +			pgoff = 0;
> 
> You should try harder to avoid this loop, the batch already can just
> swallow a full folio, so this would be much better to copy more of the
> code from it's caller and be more fully stand alone. Use only a temp
> folio array and stick that directly into the batch full folio at a
> time.

Yes, I optimize in a later patch as you already saw in the other thread.
I submitted this slow version as an intermediate step to show a working
implementation with less code to review.  I forgot to mention that in the
commit message.

- Steve

> This above will be functionally the same, but alot slower..
> 
> Jason
