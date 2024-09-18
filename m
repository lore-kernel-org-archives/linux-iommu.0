Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF9E1BF7E1
	for <iommu@lists.linux.dev>; Wed, 18 Sep 2024 14:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726671215; cv=fail; b=JxjReA4XdQk9dL3u+qlKNvRVnFZxwNI2eXIk6W0dSTSBIBixULV+6e6COk17qqlZANEqyTsk6RrT3zydx0VWwcRUqpV3ckEaEVgojEcggPx03myp1ps1jSKyPwAJqqbBs+WlqF0uXgY0eC3hQcQbMiveEWVXWXhbtY6mAGZfwag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726671215; c=relaxed/simple;
	bh=zcW19FWHaPO/Zr16U8b2R2gTduNrRgh+PYQXaln6Ogs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ev8L034wUIZBANgwC+qeXP+PAdgfIvwVhnMYLRig0ayyQXqsUXF4XSjp9Cq/GI2bjY4/BiO/yaU7lUj33l9lJlfC9AFn4zzLzitgSSn0NQv8qUQST0who2g4TnRMIyim3ryKTPK2G12X0lKh+Pk4N/x1SO2juoSCn+sqT4K3fdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MpVw+8ht; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CHuZw/2h; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MpVw+8ht";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CHuZw/2h"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48IEl05o021362;
	Wed, 18 Sep 2024 14:53:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=AZV2619KUngMz0gpwKH/2Fxx312ypKqtqDlPWeR9MwM=; b=
	MpVw+8htsJdJLJcXRjqEASl18//ANAxHT7f92UFepZpvMG0pO2+ZOfNOUVfvXOaI
	BqW01m0HkwBnfXEJDqnJifxO3A8nLo44XOIUbxjlV66ZRykQOicZbyGhhW1YpC7L
	crDB4INVqEHAnpt45mdbzu6KMi2dfmAq+XVXpOO2g25DeXWpnF30oUmydSSV0maN
	VVBLvG7C2XgN6o4FQ4c9kh9M8RYUgcJmbQ6+GPgy84bLxSNj0aWMdxx5OWEBM+4L
	0v39spUylVqHxj5qbbE0jEx098Q4/uMplvGm4u2Ue+71R3hsCltLS0XTcfaZz+dA
	0lNgOl4VnMw1oKoUaqdpdw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3pdsa0j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Sep 2024 14:53:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48IEOjIH014952;
	Wed, 18 Sep 2024 14:53:30 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41nyg4q2bp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Sep 2024 14:53:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OPOOfOH+RttMY9WL68yZUBAR/QPwo9g0tzi70/yVx2UL1hUlMLeO3B1dP9hFAhFgPFKX3X07pU5S1YU9H5+96SvBHqMRy2ARaoSgDLE7hJYbrOYvzby7Fnfs+uCXIx5WhF1IPNAsdoU5KFrVprrGysmTsyvDglHpgrDbLFF1JyMcs4fsQDTuNS1ZgnEXXBPRI2XP8zhJMnImBQB2vjki884uJt154hHmxOryq04ShZ7mZ7S2odIYd+6TvQI9wTSh1WeQrSlMYY6Cm4ldmEZCsR2sb6b9t99GXfRB7b43SaDoAwNCvIz+HD9QgsWZtVDxc9qTnH5b6zVEC59DETXP0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZV2619KUngMz0gpwKH/2Fxx312ypKqtqDlPWeR9MwM=;
 b=QroCnO66GBJy/Cj2cgVmcAq5Cj/bFVsC6s69lyc/SEANnNOwDvCBCcDW7oLpxTaO97pvNhjdLDjMfZ1Ft0m7QB9L0mRebdy/6TfjRUutQLh1ui1xv9Ky+LB9wh3NeFHQHBa37rSSGDAvw2Y5Vj73lFFRrv6xE+tIds/kCNy1WnqVryKytjcbEq50jeswfwLM1ivvfNT1SHbo/AzTMIYXJHHN/byK50PUlC6vl9SzLTmebKE7Otesxi1czCmDwXK5j5hH+X2oT1wCfMvj/eVcs0DjNv1HPcZpgVFs6CW8J8pwUsX1EKwu2TBtAk+0f7g//z7lRVi1JzMRFsAb8x5UTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZV2619KUngMz0gpwKH/2Fxx312ypKqtqDlPWeR9MwM=;
 b=CHuZw/2h0x5BdOBkfvV9nwxcTA8BTWUtVG/2dUMh0HaO5hKbt7K0tVMNt4nmPUhJeZL1fjinxZina+SjSEdDQDpLzf2GAvZ8+UCOXFjwn5MSg87gUn6mzX5HmX1iwrZkvSGNtoMeRoIArg910Z2wxDNieLD+PaYhkKjKlv6t5qs=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by BY5PR10MB4115.namprd10.prod.outlook.com (2603:10b6:a03:213::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Wed, 18 Sep
 2024 14:53:03 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.7982.012; Wed, 18 Sep 2024
 14:53:03 +0000
Message-ID: <4d9d8863-70ce-48e5-8600-1d487a5de87e@oracle.com>
Date: Wed, 18 Sep 2024 10:52:57 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 0/9] iommu_ioas_map_file
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>
References: <1726319158-283074-1-git-send-email-steven.sistare@oracle.com>
 <ZudD6O0Sc5Xi+JFE@nvidia.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZudD6O0Sc5Xi+JFE@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0379.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::24) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|BY5PR10MB4115:EE_
X-MS-Office365-Filtering-Correlation-Id: 09e33d2b-7740-4b44-9e2b-08dcd7f198b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0JXNUxrWEVvVUVXS3NDbUQ0NGc1M28rY2gyV3FJYUVnRi9ZaWg3d2g5Y0RM?=
 =?utf-8?B?YzVld3RIUkd4MFc3MUF6WVJRaGhTTmlwaHd0UVZGMFYyTDNvMy9MK0ZrbGY3?=
 =?utf-8?B?OEJ5bVhWYndwWlZVWk9sOWhrMlQ5ZGp6eEozdzY1bjIwcVFlclgvMTd6bFNL?=
 =?utf-8?B?SXc5K1dnaHJmRTI2ekludVpLMFhjVDZDWFRNMEFtamVYa0dXM1JJQnd4RXVB?=
 =?utf-8?B?ZWd4R1AzOXA1RG9MK3pFeDRLd2E3Z1ZobDVpSUVSOXlkWU5JY0hXc3NKRDlQ?=
 =?utf-8?B?Z2k1Q3R6dStkUUR4RllIdDhjcys5eXZ1TE4wSnhpUDZzSWlRNjNOWnBYZFBh?=
 =?utf-8?B?TEt1WEJUSFhOSlNXaEhwMzh3WG5Vb08yWmxJZEtCNDJiV09BN0hXanpZTk1u?=
 =?utf-8?B?VTdrQjNVb1Q1cGNPKzAxSFVrWGxsbVozVTVWclk5bUFNZUMraW9qL3hXc3Jw?=
 =?utf-8?B?d0NlV1hJemRvUWVaMnllZEdsRU8zSjh5cmdCVnZ5K1RyV0FPTzNVNS8rZkZU?=
 =?utf-8?B?bFIwWnppS3NvbEZNVnZpRjJVN3kzRHJJaTBrVTQ1TlRIR2FWeWJJajdMNHAz?=
 =?utf-8?B?cERkblpXUXMyTWFWTG9uR1BjT1pmMXpoRDdLUGE0d1FoNXBnVjFWNFZCampn?=
 =?utf-8?B?RHk1NndFWkFWYzFBYlB1a0M4d3lPTkErNXp4KytsT2RBRHI2eDhGSG1qTUZy?=
 =?utf-8?B?RW5JdUNWSVpXYXVoQ0ptclRJYVlhYXlQMG1BK1g1Q3ljMGRQVStWaEVISnZG?=
 =?utf-8?B?d1hWWThER2ZYKzVUcmh2TDF3QmR5bkhyN2hiK1QzdThXZ2JSS3hjYXc0TjNO?=
 =?utf-8?B?OUcvbjFYYXE3d0hmVkVjVjdibVdwVHJ2bjZGbDltV2UxcmZQZ1BpRVN4WFhI?=
 =?utf-8?B?N29qRENaNXpveHQ1RFF1bkUxei9IYkV5blJQemdLSU1ZUjZFNlQ0Tk1qWlJy?=
 =?utf-8?B?cjdwdWtEeHJqNVp5V3pQWDFJclNidEJDTUU2akZWN3ZCNm5sSUl1T0lTUjkx?=
 =?utf-8?B?elBTUWtSanhCS3FvaXVCeUFSdUkzTEpnNU0vbVVSVWU0emtGV21NNGZvcnZt?=
 =?utf-8?B?S1BzR05lbHk4RmMrV0VKK1BhbmlOejFXcmVLTDlrVERxcFdWbDREQy83eDha?=
 =?utf-8?B?WGZORFVmMVg1U01QZk1VdG9HZk8wSDFuV1hlSFo2dkQ5TWpjdlFocEhmdjdW?=
 =?utf-8?B?ekFKWWo4b2xnOXhsNUVpbmxRMHFpdWJKcExXOW5GaGxpSXB5UlB3VjhOcEhx?=
 =?utf-8?B?VW1lSE1rYy9RWXRTU0RFd3ZvZ1M0TmZaN1ljd3JIRWVKdFpkMi81Ly9kOGFr?=
 =?utf-8?B?MUlkRDJQRnRmWmxYRXdhQVNNckF0YzVvdERlVWYxMEdWbkhlMCs1MmRJVjhN?=
 =?utf-8?B?VE9KZDFCcjZ6YWpxVkw5ZkpyR2hnRjBTUzB2bFhFc1ZlOFZRUlo2clM4SXc2?=
 =?utf-8?B?eTMzaWE0ajkxUWNqb2N0S0Mva21LNmQ1SnNkWEI3SWlrNG14NTlDZS8vUk05?=
 =?utf-8?B?SEtwTlhvMDluRXZFYXM4NEY4S2FRZm9ZcFM5aHBRN1JRNDM5TEhPUkpUTGpl?=
 =?utf-8?B?NUlsUFpMYXR1MWEyZFhKY0ZnM0F0cDJVemdsYUh5ZjdPU2ZqU1d2akZrNG5n?=
 =?utf-8?B?anZSbHRJQ1Evci9WZCtGRW5YMGN6U0phK2x1ZUhnaXJ4ckhmem1NOXJBTEJ0?=
 =?utf-8?B?YjZtQzh2Zml6a0FLMWltak5NT1V2L2FPU1N1TzdUakhRTDB3K244M0IxcTVt?=
 =?utf-8?B?NHZxVDYwclJFbHpXRHZyT29rUWx4RTM5cThjNjQ1QjVFbXM4R05aaXA1NTJ2?=
 =?utf-8?B?eVNDdXdEQ1V5aVg0ODJ4UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVZYOFhaMDlJZHhobVN6SERLSVZKZzhid2w5TW5QMU95TlVCRmdhMDN0TVFh?=
 =?utf-8?B?QTVpZXNpY1VJY1ZNSTBNRkRFdFJjZ2dGemJrSjU5cHV0ekl5NytzaDl4TVFz?=
 =?utf-8?B?R0RkSDR5YkI1RTJTRkhBYUtDY2JBV0I0dHBsaW1sVlA1aDczS1RxdjdMQTlB?=
 =?utf-8?B?VEMwVXYzOVBNMnE0Slh1SDlmNUZsbTRYcG5wazZyY3AxS1AvVnk2ajVYbVIy?=
 =?utf-8?B?NFdVUFJ6Z0tVWERhQVQycm9WcXJ3eGl3RmM2aW9iZ3ZuU1pKTkV3OWFIa3B1?=
 =?utf-8?B?M1VvTE9QU2h4WTFIMHFwaDZJR0N6SEJYVEllUlNSM1VVN3EyNFNMV2lhVzUv?=
 =?utf-8?B?MjJHK1MwTHYyUjE2Y3JUZTZXb24xNWRXRmNZVU16Rm0za3BxV3Z1VFZQdkgw?=
 =?utf-8?B?TnBTaENUZmdqTU1TL0lVeTdJUUxhSktraUV0a0JkVXF2TThuUk81YkNsNlBw?=
 =?utf-8?B?N1g3bUt3bXZEY1F0YzJWY1NVQW9KRjBEMGZkcG56cE1UNFJ4RzJDbHJQUVNt?=
 =?utf-8?B?cXFMeVRHWnNIUndPd3BTSEFhRTdLcHJ0eFh0aGxtd2dKWjdLQVY1VXhVMmtm?=
 =?utf-8?B?eXh5dFh6SlZkakhuWGhkN216a3ZXTmFBcG1OTzNoM3YzbVpTMXFNRUFnK0tz?=
 =?utf-8?B?cXVJSmUvVmExUE5xd0VKZVpJcU1KclNwU2MybEd1eWxSbjU1T1c3a2lVenU1?=
 =?utf-8?B?U0EzdW9YaTZFcVlBcGNIOTlVVlhhcnRycmhlM0RMNi9SMGZCU1ZOczIycEs0?=
 =?utf-8?B?R0NGREN2WkVLaEg1NGZKLzMxeXo4SzV1ajZmYk1ydU1UcEl2TUNWdUtEcTha?=
 =?utf-8?B?ajZtcGpjWnVFR0xTM2EyWGFtUm40NUhEOWpVNU1FRG5lMFVSdlZmRHBUM0J6?=
 =?utf-8?B?M3BzMmZ5M2x1eEw5Z2RhWHhlNUE0Y2l6RUdVZkRHUFkyUXg1S3RMTVNCaUFw?=
 =?utf-8?B?WEhHaitjMHc2QVlWNlhGY093b1hUZHphVkdBa0VOditENDlseXFKd1pidm15?=
 =?utf-8?B?RHRkdU5jNWZWOWFJckk5RmlyWDR0Rm9tOGQ1QU5rOWFScElCQUtsZHhITk5K?=
 =?utf-8?B?RkpVNGc0L1EzaC9Qc1pTK3NIVGhYZ2JMalRxSTNqelk5YVZRODJLRm1GdGVs?=
 =?utf-8?B?bnVRanZtRTNiWHJJY0MzVXVlaFlTQWh4bWVWbGxkYnNsM1lOMi9nczQvZ2JL?=
 =?utf-8?B?UndvQUtISHh5WFBzQzJZc3BTWnA0N1lYNFRaZVFvOCtnWWNiaFhqMHorajkx?=
 =?utf-8?B?Q1lyV2xxTG55WFRFc2YvMTZmRlJxS3NnbGRxNmk1RnNpZWNEVDZWbDBXb0xx?=
 =?utf-8?B?YTJNOW9rT2gzaTArRzJMVTMrMEE2YzlJaTNXU0gxTXFYSGtQU1dvS2FTdUxt?=
 =?utf-8?B?REZkUVZrZVhuR082WDVtWE9CSFJmZzlRSzBNTG5DUHNhcmVIVTlib1h6WkIy?=
 =?utf-8?B?ZzFpaFFzbms4TS9yWHZsdmVweTU1YnFoU21PTk5OY3MrTnMrdXd1S3M4U1BQ?=
 =?utf-8?B?QStYT3lrRXVkMzl0MkdZU255TldMR1BjSzZsYkNSVDAySTI0RHBqWjd2OC8y?=
 =?utf-8?B?U2dhSjVKSnowbnhiVzdTeThkNEJWZldtYisvWkl6cDNzZEdMVFRkQmhJWmRN?=
 =?utf-8?B?dmpXUVBJbVNBWjU1NHd3dWdweTV5Q3NWYjJQTzFmUXFvdlFZRy8ydUtteC9s?=
 =?utf-8?B?STdnVVdaMi9FeGJ6WjBnU2o0Y3c5VmZaMlVHQmV2bUV0WmVUc2FEUnU3d1JP?=
 =?utf-8?B?cnN1K0FGNFpISHlwRXlaQ0xiVTYvNUVpcmtpMU00MHhHdDNPVURzVTFybmZn?=
 =?utf-8?B?UWs2QzBqSWp4bzBqa1hjT2FtNzFOY1hzNmhGSlFkQTU1RWJOaFpHMzdMeUg3?=
 =?utf-8?B?QzB0bS9Xa08zV1NTbGJZYy80T0QwYjJrWGh0UmNxUDJ5Q2xlNStyaVVHb203?=
 =?utf-8?B?QmowcEhFZkJFZzM1a0Nid0pheUl1UXNmQkdIL0l2dTRBOW0rRTZ3dUhrbXJO?=
 =?utf-8?B?U1ZJTXZ3dmhMbUhLdUdtNW1iK3kySUltZ2RJR2FCaWJwSkRJT1FSUTRpM1pv?=
 =?utf-8?B?MXEzYzRvdGdzTCs0dk0xQyt6SGhhdFE3Zzg1bVN2azdUSFNjb05DRlY1TW9D?=
 =?utf-8?B?Rm5lNU8vRHY1RWFSNEFrZ21nNUJPQ1RJUm4zdDV0UzB5alY4MVh1bVhTMDVC?=
 =?utf-8?B?ZlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BToGbGG68WUHqLcUf7oQ0DxcPDP5KuNTJbpK+EGap0rJsv5IrNsLWtjHZZGYt6aVGrQAYcx9x0YY0z3AdWnqOnWAQvp8XmhASmlSVwHMPp2zZ/ZmJ46in//hW29gag7n5/NRZUFj0njU3Nutr/4gTar46Sa8iI6OzeLSoCT68EhxklZqNp9jECNVzmfWn5nf2dJtVGLtSMg6/6jMWQPfYZw94vZEtXOPxekxSVjLqP155k8edfSwwTX1MLlUl8nzsL4DgyBPiLdb5ZsElFlCHnTqdUQyt/gymr8rvOTRtaWpi1kISrbF6Sk5z9izw9241jjKqKgzbYj3NiDklwEWCI3tpMmxZYq4o8qbYH5IGJuqjZs7C5JrV75B6E9gh+UtZJkpBexZrlqJ1zbfjdQaY4ClH4db7QrBSHZhcmUuYDtX8bRaGGim4pZirDSSoisc921zBVlD7iuYxg11zWmTp93H+9HKaV2/lYkBEjcMG9aUXknF7cr5WmvgrDwkywExazzbsYJeViNftrJzSJe9Ku85ljUsyc8fUN4trw5rOHW4KEOTVEgoOX7oP+QI976UhQNf00onEQa/oLLR88WLQ2CiLTrAmhQEq5NphXeEn04=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e33d2b-7740-4b44-9e2b-08dcd7f198b1
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 14:53:03.0363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YjKM7utSY+j6qSfilLwKfUVuJkqSjYIqkCEadKChv41NUuS1EmP+DqR7B7niwDZPMnXQZwWDARud0t8DEVxFV82OujmveytX/GBMekkJhQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4115
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-18_10,2024-09-18_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409180097
X-Proofpoint-GUID: 1RJSF2mdwYXfrYl2w8pgjZzNYc57qXjW
X-Proofpoint-ORIG-GUID: 1RJSF2mdwYXfrYl2w8pgjZzNYc57qXjW

On 9/15/2024 4:30 PM, Jason Gunthorpe wrote:
> On Sat, Sep 14, 2024 at 06:05:49AM -0700, Steve Sistare wrote:
>> Provide the IOMMU_IOAS_MAP_FILE ioctl, which allows a user to register
>> memory by passing a memfd plus offset and length.  Implement it using
>> the memfd_map_folios KAPI, and the proposed repin_folio_unhugely KAPI.
>> See the individual patches for details.
> 
> Do you want to do this and the other patches as well?
> 
> This seems much easier to understand, and over the long run I expect
> to wrap VFIO in a DMABUF FD as well, so it should work well.

By "other patches", do you mean iommu_ioas_change_process and friends,
with VA manipulation removed?  I will submit that as a separate series
after I submit iommu_ioas_map_file v2.

- Steve

