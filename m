Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2442640DFB7
	for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 23:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774481993; cv=fail; b=nn7NKzjclnbCSIZ1x2owouHIklUZ93LVrd08akSYa3TSXp4/Iidx06fiapqJ1k5e8qCgOF+6FdWGddxdT3A+hqoBRXmg0eS8rx/zjLE6xsHpiz4fuD87UJ1X/nI8brddOSMQE1qzTOywIB6sXjOLXAqvtuNcELsMKH6UASVQl2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774481993; c=relaxed/simple;
	bh=RLQVyIKgTr/LFBLhmV2jTbZMDtkaq8j3t30JYez7rvk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Vx1HRCO71UzpvmDTW3Qzy0QaY2H1kTF4e3YjL9RLMTMOImJE1RqdPL6rMgPr9cmLkPhF4N9bq30S/mFtuBNSCt2mp4dsfj1ndM2D5Ukj4d5vi44tZXiwYRQTk7EwNyHSI5oRTdQZPyUFyPgV3Gu/WotzIXHiOUDH6FK+0Dhr/RA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b+SAG4fK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tDRMJnlj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b+SAG4fK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tDRMJnlj"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PFtwH52525827;
	Wed, 25 Mar 2026 23:39:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=RLQVyIKgTr/LFBLhmV2jTbZMDtkaq8j3t30JYez7rvk=; b=
	b+SAG4fKRq0fhbiRyW1FGp1OV/a8V8Jmyvdx2sA8Qk8Q0apdHDP3QNKItBBtQYJB
	f6X+eYuJDjZj/6zNJNYEsaZmXJATylglLVk52lTDwA+LXiC0cXHFgaJjnBIu68tK
	kt+4FJCWAeuDLUww395G57Crht96qsZeSA9sTAY//nRx6ASnm1ooo8CytdkZhYD8
	11+n3E3t/cjwzCF1v2Sdq41MdfEb2QUhpt3aenuiVV9Mtgja9iWHeeWLbF/2UruT
	EjDG4dce6HhU5fH+PQIbFpVacHXTGB/ugiOuqlJxVDH9ZoddNxpjwXxXw7u52pxG
	ToiDFXircE61PwevlpQUFg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1kvnqe92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 23:39:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62PLSo29028963;
	Wed, 25 Mar 2026 23:39:41 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013032.outbound.protection.outlook.com [40.93.201.32])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4d1hsc5qjr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 23:39:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G4FXHPigpK/4YX1NTGhe7E9vswrD3a/qcI5VbV/B59LakJdEylEQgxIWcktko3+AOwH4Kqii5iTulJCpBGG8KEFLhmEWO33vX0xzTbM3dng2GVG2O3/jrzh1k7PDwZYFoGKN7YfMNA+4DoclhsWNCk2NJsUxZuO2xznjDjV1+2ruVyo084TPHNqhVGAtnyHG/S8Gocj9uu8N3Qk3nnfRrSIfFFcDtxCXyM5VtlWyWlAJ7aQb9X6Y4IGy8sz9lnyJ8eIm0Lj0mY8lJ8lbAG5nbso5r7bYMz0m06DLAwHSm6qtxYGp+NBc8ZvyLjwpJs/cj1RSC25W+mU/XdXd69/AZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLQVyIKgTr/LFBLhmV2jTbZMDtkaq8j3t30JYez7rvk=;
 b=ekCi3e5C+gcKvsOkTYxCd2zlq7SB5JgnYOzMUPjpXTiAB89jc83hHgKZNARe2udzM0fwPkV/exy32i/89ckiX6fXF+vZhmOlqrS2yVkTgiFi4JC9btm++4s4TWCPNhXve12MJWeMriRg3PkVONml08OeLDnkJTmXCsXFlVX95JElmbR4GdTTxRPQkKwSEDd7ZcSf/LwO/xwh5Ifah6fHUlh2WYrMvKxGCpSV/bcsu8uGb+lXg7dtw+RCnabfpGeusWM68xoRNZHfelnTtk+ejlAR8O78eywiVfNsH46Cy9cyJ7tmlenq676k6A57I50UUwAcj9pSZvUhvxT+dv54dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLQVyIKgTr/LFBLhmV2jTbZMDtkaq8j3t30JYez7rvk=;
 b=tDRMJnljpiIHpIXgH0OZ2eeRTN70AnXOMYm8h1tlsePJWt5KkPlXYpB2T0bw6Ziu2evxif6X35QV8tOa6k7P+YgUUnpT0LylNoInmmKyGO9HwWCNC5Y3fXkAHy8O91EWJUca29h1Sg5LC4nudyyA/wgGNr+JlQq+Ijn8mc5gwAY=
Received: from DS4PPFD91C619EF.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d4e) by CH3PR10MB6714.namprd10.prod.outlook.com
 (2603:10b6:610:142::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 23:39:37 +0000
Received: from DS4PPFD91C619EF.namprd10.prod.outlook.com
 ([fe80::d255:3853:bca2:c291]) by DS4PPFD91C619EF.namprd10.prod.outlook.com
 ([fe80::d255:3853:bca2:c291%5]) with mapi id 15.20.9723.022; Wed, 25 Mar 2026
 23:39:37 +0000
From: Sherry Yang <sherry.yang@oracle.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "joerg.roedel@amd.com" <joerg.roedel@amd.com>,
        "kevin.tian@intel.com"
	<kevin.tian@intel.com>,
        "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommupt/amdv1: avoid GCOV builds triggering FIELD_PREP
 build failure
Thread-Topic: [PATCH] iommupt/amdv1: avoid GCOV builds triggering FIELD_PREP
 build failure
Thread-Index: AQHcsKtgqEw2u6CwUk62gJ+kGlpwdrWn+CwAgAAJ/4CAAAtEAIAX8nUA
Date: Wed, 25 Mar 2026 23:39:37 +0000
Message-ID: <94D79BCA-138D-4CED-995C-E89EF7635C92@oracle.com>
References: <20260310163136.1179322-1-sherry.yang@oracle.com>
 <20260310164134.GA1410323@nvidia.com>
 <62EB69AA-FA3E-4820-B268-A207CCA6F23A@oracle.com>
 <20260310175740.GB1410323@nvidia.com>
In-Reply-To: <20260310175740.GB1410323@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPFD91C619EF:EE_|CH3PR10MB6714:EE_
x-ms-office365-filtering-correlation-id: 9873f494-568a-4bff-a0cb-08de8ac7c704
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 VpfndvvJ15f7qFdGMryA+ew+YWTsqFLwS4S5REcY238/tRxEqYsr0+1rMIBpggYiCCYc0BzrrOAXBmSUKh0q3FgymBSM+Ig/0ssbDp22HoflDLk+/sBOlS0LU6jqlp4WuH62qltNEECo/qMiu5kN85U8EW5K5862IJExrZk3oAc6EOvOSMQCwCmX/9N1pPjFcC97OCTbksDRFnI1Gta481dwqSBEBP/aQj/A5YWmBmqdpCfmDmOo4ZjQ26XbfvWLGyhM4qr/NNuhx29FPPIFuepwJW8IpuZgSIkJCjYuoRBsbCFb43BAMYRXrDeu1kwhEZck1mYbpgTJe2Cdv/5w0DYy2AW8oIgsqH1K8Xh4gxtgvl0GGyjD5JCm9PhA6vEp1Te/IfvUAU4ZQF/J68zfw6JeNEjhAjHdGBSbk3gS7XoINTk3NtAV7VEj2Is1n47qZ7Rry90+j0thbjHv0KS5tlOnftM1MUGBlRFZvbLniBIPbPN+h8JJyp3w1/WW8D5KyDXEs/IfI8Q8qOCrJZFdC0HrQx4wKcddWjmkiRlOKrjWOlHf/3Ijep1pBg8Q6puIcYifHuKqTFmSZRUc3ARZ7FUwkLTlzAjdl6ffzEU5KQXP63ONHERLWEajXwVfsBOOPBTZcw5FC50affZiuKdTRK5cQqfBO/zhxLqHcBMMLcliRFGvj3YxYWKsVcNQFqJhdSP5p9ebM44YkRa2I0GfGgJNey/nxCrwbjgfllTc3Kdzffniw6xFF7z3P5etWBTxOWWZ2yMaGZehuWZOqxIIXvwAzZWs+nIGsVdkXzmEs2c=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFD91C619EF.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UlRWVklBa1R2K1BxWDlrMlJ4a051NnZzWXRwQnROajZ0WnphZnJJdlYzdkVj?=
 =?utf-8?B?LzFXenovalRFeWNDc2FqRE52MDdGUkhsUnFSVzhodUg5MEkwb3NPN3dFSFdz?=
 =?utf-8?B?NmNvQVd2Z3Y1WFZrMGdkSStKT1VTY0VmNHpFTVFQa3NkempiWjlpNlhjWFJ0?=
 =?utf-8?B?V2Y1S3RnZkxEclFXS01OVTFERlBZR3VSOHNMaEgwV1c4Z2pJdGJiZWR3QUpO?=
 =?utf-8?B?K2ZMbWp6dGlUSEdXek9ubHJrU3N5R25TQXRBOUNVSkNyb1hROFI4TEl3VkNL?=
 =?utf-8?B?LzdtdjY5YjRKcm1QMHowWkF2OG5BQzd0N2ZJN29mREFmMGQ4bmRlRGE5V1JW?=
 =?utf-8?B?ZWhNOUhnVHFNQldXZDllOGhKTHF6UytGK05tdVlyQXVSUUlRbmZUcW4xclhh?=
 =?utf-8?B?ajNvNklCb0NVb3dPeDZTRzhnb2d0UG56UUxObVZyNk5MK1Mvd1VLN3RQRUo4?=
 =?utf-8?B?cmhiY0kvWWNlNC9CQU5YcTdOaWJqVUlRNndmYWtqMmF2bGxyTkQxYWNOUmZ3?=
 =?utf-8?B?Y3A2R0gwN3dlanIyYUZHcTl6c0RsMFczU3NwMTJNUFhCOWlVdng4SmNydUxu?=
 =?utf-8?B?TjNwR0hQbk1PZkJoTENLMnVmWGwyT2JGWDJiVTFWZ3V3aXVienltNlNaWll4?=
 =?utf-8?B?VXFYVnI5Z2hDY3pjVlVFOFA4WGdxaTZCVXZxMHd1cXpsaU5BR3hJNlBaNGd6?=
 =?utf-8?B?c2dITUE4UFRPVTEyWmtnT3RLN1N2ZmM1K0RIcG9yV0ZVWTN3QjZHaTkwc2Fz?=
 =?utf-8?B?MnhnR2c0OFM2NHgyRTNJZkNoNU9XZHZJcncvbUMwRjJocHZNenZFbStXcnY0?=
 =?utf-8?B?czlPK25tZmtta1VOcnFxaDhmSDFiQ3krQjl6MS9HUjhXWnpTZFU3REdRYUZE?=
 =?utf-8?B?UnhTSnFIS3N1UjRuVXZvZkJnMEh5aFVBazI3YjQ1a1VYSExEWlpkMVBuTzcx?=
 =?utf-8?B?M0xDTXZsbGJmUFE5L3IxbXprQUtFY2tpOHlqWmJHZW9rN2Y4NnhhZmRhdkR2?=
 =?utf-8?B?RHUvOExYTmpuazVEa3NrelhwdXdVbmtycDB6ZEx4NTM5R0dGcEJ1L3laMnI5?=
 =?utf-8?B?MXBNVldzczZPVGtSTmhsZFk3UElRZW94b0l2bVhOSERnczVURStRUnppeHFU?=
 =?utf-8?B?TEg4MytpVXpsaitoU2tHdUliNU9HMjBUcEFFRk56RVBWSUJ4QlUzWjNRbitB?=
 =?utf-8?B?SXVuMGZGV08xVE5pWFQzZjVXZmhYUk1YbVhYUVVIQmFpMzR3QVg2cWhNZWtx?=
 =?utf-8?B?NTVEWDJYMGE4TE1Mdlp6dWkycjRzNDdHMTZSTzZjakxYL0RnMVNndjRPekQx?=
 =?utf-8?B?Mm1xTnFoekNoaDhDNWRKenZETHQySTZOVkdid2xscjlmQ2k0eGk1NExwTmhM?=
 =?utf-8?B?NGc5TGcwK29TNTFhVCs0VHljUkthTzF4TGpEbWpCNnR4VVF3U3NtTFlUQUk2?=
 =?utf-8?B?ZFd1MWRvSWVQMWpYMThIYnd2ZzBTMGNwQjFBbGpIM2RMclVTbGtaQW1pYjhn?=
 =?utf-8?B?cmhPdnErd1JpbGVkYTlJa3h1K1BYK1ZyT01XMXdhWDVzYVpGOS8yb2RvVnR5?=
 =?utf-8?B?YXRwb1RSSS9TMms5ekw4UUViRzJlQ0wvakROZCsyM0czZ2Z2QUNyVCtHeWIz?=
 =?utf-8?B?R3JrbGk5ckhKY2pOdS8wOXBCWnpIVld4UGd0S1dwRmpoRnNHQVlGVTZpd055?=
 =?utf-8?B?N0lmNTJVQkVFakloSCtsQzNMQ21LRHlIMmlDQ3h6Q1Q0SXdKOGRtazlCb0ti?=
 =?utf-8?B?NXJydE96bDdBMU83SEZxaFNuNk5YK2g3eFBrbTE1bG5mUDYxeVhNbk56SStx?=
 =?utf-8?B?REZxd3lzL2RxMGpYTnBxRlhEblFOQ0JkOUtCWnNPYjA2eFBrbUc1ZkRQNi9Q?=
 =?utf-8?B?T1g1L1NyejFETHhKOTd2TDZ6WGZyNEErcVI5bnRrdkN3aHNRelNwd2NxeXNQ?=
 =?utf-8?B?YWNkUm93d3E1USthZ0RIVmdQemxlNWloZHFHUWdLZUp0T0xXR000VGx5eEVj?=
 =?utf-8?B?WHNhdk9mZDlTb04rL1B4dXNsUWxLSWNyYUF4dkkxWkJlcDA2R0IwSlBabEIr?=
 =?utf-8?B?Qjk0U2JheWJ6S2cxOGN0ZGV6UUV6WjBYYm4ycjNYNWZsZSs0aW82MTd6ek15?=
 =?utf-8?B?dlJDQWdsbDZIUUJ4VzFCclFZWTVBN3UzTFhqaTVHbmVGYllTbnZRWU1QSUJY?=
 =?utf-8?B?QWMxK0JRS1E0aGpudmVQcFFBeGNMUThuSnlGWkZ1bjlHQjF1ejBvOHJDTFFp?=
 =?utf-8?B?bjVoSjZ4SUQ5VDMzY3RUQ0JYMmNOVEpKUVpHYlMxS1RWS09OMjVPN1Z2U01X?=
 =?utf-8?B?N2l2MzB3TVFha1U1NGZKMGs0dFVmdUVaNlhBVzdEMDlMUHJmRENUUVk4ZStP?=
 =?utf-8?Q?vkWO2ZGe5/R26Exc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D926156770CCBD449810E9B85F8EF3F5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	rl8Qhe3w6yAJQ+NC11qO1ztU1Lg99PCGeOxzXZA9I+vnPLDIp94I7gobxoukg6Dw5jfUrFZMSiMS42Kt6T08eAmpqbnVnclv0cUuJP3aVzGa7Gg7lIVx857yqYGYKw+31rYuI3vSrLjKbH9ZMQqCwegsv7noiKdDwolt7Lpy+DpDMvoZXOdLVR4QqV+4I4fWl0Z2N+n+EC7Ngv2Rk53hHSaHPQ3uIp+5s6OEkECnF/dhRqQx2CZ1Qvb1r0l+hWamg3VMk/aWSf4sE0PSIoOX5MIWNncGYWfTvA8yoNimVmmlfQt+F0wfwKJSF4s7I59jtk4heOYh0t/3bwUUtzaKRw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QpsWLSr7lXeDN20FcIeK9KM/26OigNqWO8J2ZG4p8eYyeqOh2XoWRSnrqcObmjIjEzT+p9LpAxxWAD1KtgTsOdvBYrIJMl5C2nnvbq5UarBNKFC2duE7PaRQeNK7pB6EUdNK/tjBHWAu22KD4d6z69uFloNRSm7mzUCvV2/yx7Lun5qVhGjpFEkIEP0hqqGstHsK3xa9WUwudHgJLXAIY3HzCl7xvtYF6/t8tthlikpN0c97XcEJlsJaAI3fTYYZ97vqu+U3h8/3at2CEsyJP5PDhYQj0E6Q0QY3ua7Wc41hEmrD34GPLJVWBAZdom2Sn4klsxtKMOSpzvigPRg+NlAxqXaLzmo4sVw3Fj1dwInduoB3HdZn78fwTVfSR8yC8uR14btl3fjz+ua2TWQgxtXnOEA0ohdn+6tDZBZQNPUtTm8vj+3HdL3AY9R+k060PRu709ZrKqypJi8jNUXzx+JnGN0t6O5QdkwkiQPOT2lVuw3aKMUBJ8DVUb6y+RJxXnx7EpdoI10lpERVqyB0WpgUdVGc/gvhSeMrBHEu1qNBpBEVoaAUVjXlJDBuV9NjEQUhz/kpllXO5VIdoonEngO147TUoYDQN1JmzCPSUXY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFD91C619EF.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9873f494-568a-4bff-a0cb-08de8ac7c704
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2026 23:39:37.4981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qZhAUpiy1eNhwHdT6g3xj5OVoqetIpSnAzYVVcfyx+2v/cDQgZuKBs0GWI8a4DgeHwJh+6Ie8G5pXOW+fixL1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6714
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_07,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603250176
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDE3NSBTYWx0ZWRfX/S2W+Gouhmyy
 1vfitfnOB6+1ivk2qYbvy76Gd1n8f3886iedCQk0lq3Ai3jT4wqOEAuzMYkCVWpnoAmwh+5y4H4
 dbYUFUNGE48AY0c1KHaPM+0ccBXYPnc7qWQAxtzBVflt+hzzz7Pxrc2FOwayPijvZAkvjdAbh8m
 U/IVcjSrg5xgTM0cA3QFB0NMWJFeY9bw4DjMnkOxTdVii2VeiHeiIi0z0EeUs8OzachmzL5iCSd
 soVeya9d5CDDVH4v8BA/GyTTeImYG5tbzkflgrleI0xP1SgToD/xYArQOhrx0rdYeZLyjxn61FR
 zF7N95wDruyeKRRkPIQVB7voPdo/L5CpHy4nYz6IPOOKoXhYcXcDvAKcJZhUZNzsMp9p5jw55yb
 n0dzenBsqv1HiCNwgooFZxaqJJ3KPCDHRQsZ8eGetYreWbMgtd/ssBNHpJ/TPoVC9Y7BtsyOZV4
 YFO08+yqqnaISmrf8+g==
X-Proofpoint-GUID: QkMQVwrYKX2O4HoCLeFUJh07gCJi0sKY
X-Authority-Analysis: v=2.4 cv=GrtPO01C c=1 sm=1 tr=0 ts=69c4723d b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22
 a=Ikd4Dj_1AAAA:8 a=0-r-3W45E8aYGWUt5XwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: QkMQVwrYKX2O4HoCLeFUJh07gCJi0sKY

DQo+IE9uIE1hciAxMCwgMjAyNiwgYXQgMTA6NTfigK9BTSwgSmFzb24gR3VudGhvcnBlIDxqZ2dA
bnZpZGlhLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBUdWUsIE1hciAxMCwgMjAyNiBhdCAwNToxNzoz
MVBNICswMDAwLCBTaGVycnkgWWFuZyB3cm90ZToNCj4gDQo+PiBVbmZvcnR1bmF0ZWx5LCBJIHJh
biBpbnRvIHRoZSBGSUVMRF9QUkVQIGJ1aWxkIGZhaWx1cmUgd2l0aA0KPj4gOThkNTExMGY5MGFl
ICjigJxpb21tdXB0OiBNYWtlIGl0IGNsZWFyZXIgdG8gdGhlIGNvbXBpbGVyIHRoYXQNCj4+IHB0
cy5sZXZlbCA9PSAwIGZvciBzaW5nbGUgcGFnZeKAnSkgYWxyZWFkeSBtZXJnZWQsIHdoaWNoIG1l
YW5zIGl0DQo+PiBkb2VzbuKAmXQgd29yayBmb3IgbWUuIEkgbm90aWNlZCB5b3UgbWVudGlvbmVk
IGNsYW5nIDE4IGhpdCB0aGUgc2FtZQ0KPj4gaXNzdWUgYW5kIGZpeGVkIGJ5IHRoZSBwYXRjaC4g
V2XigJlyZSB1c2luZyBHQ0MgMTQuMi4xLCBsb29rcyBsaWtlIEdDQw0KPj4gc3RpbGwgY29uc3Rh
bnQtZm9sZHMgdGhlIGNvbnRpZ3VvdXMgYnJhbmNoIGRlc3BpdGUgdGhlIGNoYW5nZSB0bw0KPj4g
cHRzLmxldmVsLg0KPiANCj4gVGhpcyBpcyBhbGwgYSBwZXJmb3JtYW5jZSBwYXRoLCBJJ20gcmVs
dWN0YW50IHRvIGFkZCBtb3JlIGNvZGUgZm9yDQo+IGV2ZXJ5b25lIGp1c3QgdG8gaGlkZSB0aGlu
Z3MgZnJvbSBHQ0MgYnVncy4NCj4gDQo+IE1heWJlIHlvdSBjYW4gcmV3b3JrIHRoaXMgdG8gYmUg
b25seSB3aGVuIGdjb3YgaXMgb24sIG9yIG1heWJlIHlvdSBjYW4NCj4gZml4IGl0IGJ5IGZ1dGhl
ciBlbmhhbmNpbmcgd2hhdCB0aGUgb3RoZXIgY29tbWl0IGRvZXMuIFBlcmhhcHMgYW4NCj4gYWx3
YXlzIGlubGluZSBhbm5vdGF0aW9uIGlzIGFsbCB0aGF0IGlzIG1pc3Npbmc/DQoNCg0KVGhhbmtz
IGZvciB0aGUgcG9pbnRlciDigJQgbWFya2luZyBhbWR2MXB0X2luc3RhbGxfbGVhZl9lbnRyeSgp
IGFzDQpfX2Fsd2F5c19pbmxpbmUgZml4ZXMgdGhlIGdjYy9nY292IGJ1aWxkIGZhaWx1cmUgZm9y
IG1lIHdoaWxlIGtlZXBpbmcNCnRoZSBvcmlnaW5hbCBGSUVMRF9QUkVQKCkgcGF0aCBpbnRhY3Qu
DQoNCklmIHlvdeKAmXJlIGhhcHB5IHdpdGggdGhpcyBhcHByb2FjaCwgSSdsbCBzZW5kIHRoZSBw
YXRjaCBvdXQuDQoNClRoYW5rcywNClNoZXJyeQ0KDQo=
