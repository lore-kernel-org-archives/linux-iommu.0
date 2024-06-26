Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FE7176AAF
	for <iommu@lists.linux.dev>; Wed, 26 Jun 2024 10:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719396853; cv=fail; b=pSYOo3aW4Y7ExLjcHDhNw8IsZr7iqZlBXKbh9As0UDFFKJPAf93dSIhBba/nmClAm03IH53GhX7CgRgI2rFHYz0idIUC473C8xfpKHEuSjaUuS5tUbalrkFjI4G/6ONds6Gxzx8BGg3Xmlu/ijsUfVK1lcda/yEmIq740a4VLFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719396853; c=relaxed/simple;
	bh=ZC4eGkBd75+T1Ggq7rxCmIfD91g92vw4jNgxWGAu4ao=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z38/kfDAUeJs0BUnnMU5OxudHlXfgyhEXoUAJ+UVjQ38ORyHjQvYP7II15ibcUSe1yJP0LEqLSKhjtJ1dNzUJmlfOJjF5vww3ACdgkRO/El+AgmTAbeI8djDGveMNZxXezK28Tix+UuTnzsoUQ57IciGbxpE224HGE5r+wPCS+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cUSr8S0n; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YDhNR0vJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cUSr8S0n";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YDhNR0vJ"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45Q9sLcp004473;
	Wed, 26 Jun 2024 10:14:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=6tgYjyksWEbmdr6hAi++/vBwAx9+BZOIZwlTKrRvX/4=; b=
	cUSr8S0nwYNI3vO5HvuHmX3PdyVhboP9Za5n8Px/eS/FMGhaM0ipKZiljvXJ0zu1
	NI6AUxOA0jipYrUNxIzRitP8XgJ0MaHHXhp04DXOBr5UgiASJ81hn9FBOQItqcwI
	jV/wZjJKsPgodF4fi3KGVaYra8yIPlzOppZiqA2pz1n+/sIXjXsvjDunnEzazD2c
	1bj70D+CJ71aMBiG0VcqVLCuFMfj5oBnWt054zcNwIuSf7qUDot2qJMI612B/rcJ
	kEyIZ8GJCJqkKO4X5eYNgV1x1qctypnyEJGjvAYvU2A+BjD72v7sdkN/siMgWxFz
	hmbVx8Emv8No7h3ywjHy1g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywpg9apaa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jun 2024 10:14:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45Q8BkXo010770;
	Wed, 26 Jun 2024 10:14:02 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2049.outbound.protection.outlook.com [104.47.70.49])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2fb2f0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jun 2024 10:14:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bH2t5oWlX9ygccTLHMhv8o6IjCLK2dDLSy+kpbNJUbdIp9nCrDbH6qwaD5TmwhbJY2idKDskE3Oi578h2JsxKuAbRjZ5Q6ia5g6oVhA5VDLNvN83H1nwbhY4wj/N3wH+HwOFCUUjqPgzN4iVYHm2YE/g9V600BvhEtyLukqHVyp5EVLddpHS0nCqeUyTLB1KHkKgSTQDwXrgrIb9D4RqeHqPWcKfnpuDVb502wYarmtrqHnTvyZhMWciVnoXAHg0T21fZ+zsoGHMiM8txjqrkr4NqtbwLQTRkC7n1Q8Fi6pmY1fJfokIRZQ6+qlcy7cUK8i/3vyFE8pReXdHuVIAYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6tgYjyksWEbmdr6hAi++/vBwAx9+BZOIZwlTKrRvX/4=;
 b=e2YHcg+h3R+XPDceaZ8UDRlyQeQl4tBybUKGEEUhFFJ9u5eIvShsZa4c2YvpoEc1YLgZOYVLyH117ZvECwXbeeBU6va7r9Hubsc94kAy5AVZRu61diYB10dXcldvloLnoDTTP/KjKhjpvzV17W4f4n+t8oXd+BpbDYncDdf+i4br5m62ecfKyPP4WJtAcBT1j9x1DWobT00YI+fcG+2BrdUp7b4aoOax5amex6W3fy8xb1YH+kF8j4Z8QSA6dqY1i4Ezlez8U5lr0rii0zmtqU0NReNRaqA7DoPLjNfYg29JK72SYL/e1uIHNuE3U009KcnSkjEIGKJMb6G5c94nkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tgYjyksWEbmdr6hAi++/vBwAx9+BZOIZwlTKrRvX/4=;
 b=YDhNR0vJjpji7GDAu/Qzo/yL+XNl/MHPXIxciCLY6SINSSs+zdBPen0ZJp2Bm8Vfyzdn90J43YAU4nMbyLQjIu0U7WR+2D8e/KgkPESOWGHScayfpxgWpCi5ETubyx+WRJSA1j7rcO2Z9IA47s/orpHMtMLuZ3A00DP1o4lIkG8=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by DS0PR10MB6945.namprd10.prod.outlook.com (2603:10b6:8:143::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.34; Wed, 26 Jun
 2024 10:14:01 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%5]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 10:14:01 +0000
Message-ID: <96efb6cf-a41c-420f-9673-2f0b682cac8c@oracle.com>
Date: Wed, 26 Jun 2024 11:13:55 +0100
Subject: Re: [PATCH v1 03/10] iommufd/selftest: Add tests for <= u8 bitmap
 sizes
To: "Tian, Kevin" <kevin.tian@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, Avihai Horon <avihaih@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
References: <20240621184254.45477-1-joao.m.martins@oracle.com>
 <20240621184254.45477-4-joao.m.martins@oracle.com>
 <BN9PR11MB5276C4EFEE9E6E2E8A096F748CD52@BN9PR11MB5276.namprd11.prod.outlook.com>
 <a82fea7e-d76c-4ca3-88be-2a9455f63f9e@oracle.com>
 <BN9PR11MB5276D0EEDBA3F6D7587220478CD62@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <BN9PR11MB5276D0EEDBA3F6D7587220478CD62@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAZP264CA0080.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1fa::11) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|DS0PR10MB6945:EE_
X-MS-Office365-Filtering-Correlation-Id: 89edc1d1-9d72-4e30-71a4-08dc95c8b2e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|1800799022|376012;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?b3gxN3BERkpQQTdRS1Y3UkE3TGdQVGl0ekhEbHVPKzgwZFVnbGRuY1p0V1dK?=
 =?utf-8?B?aTlWSEFFeHVFVThRMWRLbG1Yckl6VEhPWU4wYkZ5S1A4QmtDdnhxclcrb0FG?=
 =?utf-8?B?ZFlsMk1xR1kzRnUzK1dPVTUyeEZVZ1k0QmRiNi8wRmlWNzFaR3BUWC96Qjky?=
 =?utf-8?B?bFRKcS9SdjFvV1hJZmpqQlJpeEQ0OHEwVUZuVFZQbmxhZFdadjlFZU9HMWdD?=
 =?utf-8?B?SGlwN0xIeVA0cjNLYlllOVIvSmNGWUswcnQ4djR1YlYwNnI2SjFMM2Y5dVcx?=
 =?utf-8?B?eDdGK2NOckd3UThDNVlad2tURllYSjVMb0U0UGpLbzNWMnhqb1BWSW94aWIw?=
 =?utf-8?B?YzhwSklEaFgrbzB5cGhEYWlaYk5tYlowcitUcXcvOVpneWJnSlZRelRpWW1X?=
 =?utf-8?B?b0t2dWptL0RweFdpL1BTZUJUeUVydEtkWkNCMUJNaTd1RlV2RDcvblJRVnBN?=
 =?utf-8?B?bUhoak1teDhuRGhuNWY5UkNHTnlMVE5iYS8zb2JUQW5obzY4MTVFMU93Y0tO?=
 =?utf-8?B?SWIwRXNCWGJRV2tuRUF1NmhpUGMxT0hLTktneXhmMjNpeFQrSFp4U3NIL2l2?=
 =?utf-8?B?bGkyYmIxelB0emRkVVloTE9Xd25DSGNSdjBJdGpiUDBsTGhOSFNSUWR2dm1w?=
 =?utf-8?B?azQ1U0prTzQvUXA0WlBEZ0FqRDJZQnZsekhKS1lMK2Q4QmZJMnpXMHVKZmhp?=
 =?utf-8?B?ZHZTblVjd1ZiaHIzQkJjakRWeExlckJJZk5YaUNvbjJqbWp6elJJc0VncXBW?=
 =?utf-8?B?Ny9ic3BOR2hqZ1BjNUx2U2pDYmFvcjZzMXljRm5BVGtYUG5SamtJN0Fsem9D?=
 =?utf-8?B?S3Vqa1RJSXRuM2pZN3I0VUpDRVExSElTR0dDckNUMnVTSVB4SFpuSHRmY21B?=
 =?utf-8?B?QXJQOThSb3pwbGdkS0lndk5KOVI4TzZzUW03NTdWdGdvb1cyVThiOERiYWs5?=
 =?utf-8?B?YWZhdHNONTdLTWtRUURtVGhCN2dSTk1xVEd5aWd5OFhqcTBlNVhvUkJnVDNv?=
 =?utf-8?B?K09GcUVvYk9TK3lQcWtSRWc2U2V3K1dWSGdRY0o5UkN1YXVZU1Q2bytMbXUz?=
 =?utf-8?B?ckl4eW1BMzdHRjRxV2tJUDdaTVVpMjA3Qml1UzNnekNHdFhHN2FXQ2lNbjk2?=
 =?utf-8?B?WnZYYjM4M3Bncm4vWEZYQ1k0WjlWbzI1d0ZDRnBJYTdsTjg0d0JMNHNDREkz?=
 =?utf-8?B?UlpGZVVYTUlPVnZGYjBnL3RacTV0WEk2ejBST0JONnYvSUgyWEtVQzY5RDhO?=
 =?utf-8?B?cWxzcmZtUFBNTnAwbXpxODB3Nm9JVHNTSWJCUVlIOTZSMWJrYzgzUURqeGNm?=
 =?utf-8?B?SjVRNk54QXRnUWNWWlEzUjluenE5WCtmMExkMzEzZitQWEpiclRMRXIwcGV1?=
 =?utf-8?B?elR4bW92TnBHQ0o2ZWhKUmIySHoyU0RNVkxicjVOQTc0Wmc3TXJjN1RUVkY3?=
 =?utf-8?B?MWU3V28raWlBMWRITlpPY0FRd1BSQkNhRXppdzVaK0NjMUJPZUg3YllMWGlY?=
 =?utf-8?B?MXEyd0NVWmdLWTc4OFZrK2lUVndsclYvMG10d095Z2FsRmFMczdJVTdkc0xv?=
 =?utf-8?B?NUNDbnVXenBLNDdXVE9CeEFJaG55U0syR1I1Zk82U25hdG13Q1RNa1dHSzhU?=
 =?utf-8?B?d1ZlMHgyc0hSUjBYU1hqSWd2bTNxZXBwdDBrNjB2RWxmQitRRmpJUWE4VnU1?=
 =?utf-8?B?TU8raGVmUVFrcjdSRjg2VElEc0VUdEVNZG5BTklPZFVuTHVtOVVtWTl0cTlh?=
 =?utf-8?Q?UQIXXJRzWp8SmBDqacLA0+/SpLRNatmGVmTZWgg?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5893.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(1800799022)(376012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?K3dHd3YvdTVGK1pUbklQd04yOHBZbzhWdDVDb3ByUlZkdFNra2xudTZPaDF6?=
 =?utf-8?B?WmV4dEVpczJnOEVoRWJpalFDSC9IV0x3UWh2RVBtYmtycFBGbHRlbk0veHpz?=
 =?utf-8?B?cW5zOXFZdjlEN1l0K3BQOCtoMEMxVGZPZ0o2ZnRoSUpwbEFFdkNBZEM3eVl0?=
 =?utf-8?B?cWJKQ3hjWGRNTWFlQXZoSFJHbmMreEw4OXBndHk4ZTk4a3h1ZTM4aWxaZjgx?=
 =?utf-8?B?QysvK1FYZFpWM2QraUR5WmlXWXlJS3FTRVI5LzRzQVM1N2UvWWsvYzZBamo0?=
 =?utf-8?B?eldEMjJ5MlpkZDlMVFJMbXNCUklDVDRVWUk5MEZFMFM1MkdBbGtHMllFOHFz?=
 =?utf-8?B?VjBUYTF0aDV5MWJjOEs1L1pHR3B6NXJSaWNENDRReGUrVnJYenJ1VUtSRDBQ?=
 =?utf-8?B?c3pFRU5MU0E4eW1ON29SN3V2WnI0SHRCU1ltN0pKZDFRSFVRQUNBYVRJbXdl?=
 =?utf-8?B?NmF5RUluZ0V5R2k4WGE4OHR4WlhSQ0lGNW5RS0orSytsNWF0Z1p0M3pkNlVC?=
 =?utf-8?B?aWl5T2R6eVo1a0VzajdsOHhSTC8zbnVHeHBuUXcvdHNnSkl6QnRaaGZVMWlI?=
 =?utf-8?B?dEVDN3ZnTjRPZU55ajR6cjVrT1lrbDlZMnBiYTlqamNCaFJrQVpjWDIwOWov?=
 =?utf-8?B?OC9waWhwdS9lSXA5SEJ4QUxaS0NRYmE5RncwcHpjay94UjJYdnJnbnJ5ekln?=
 =?utf-8?B?ZVpHUUQ3MUZjQmY1bVdkVy8zT3NhNzRENklETzhyT1l1SjRpNENQeFIySXVt?=
 =?utf-8?B?eGJ3bXZwVzR3UnpVRDQ5RkpRd2dsQno1eGxObks2L1pESEcyTGxJYjNzanhM?=
 =?utf-8?B?RCtsY0V2YmRaY25ZYTkra0Vod3RYbXRKS2ZUOGpmb1k1MytPY01VcWVLdWtY?=
 =?utf-8?B?MTQrUTN4dm15VlpNWjFZQ1VJdlNXSHN2QzI1NHA4NEVJQWZJVWRXK1BnV0Vw?=
 =?utf-8?B?YkdwME81UE1tMWI5Q0lmME5mdmtRUVVtakhLcGRnUndUMzNoVnpDdVZoV1Z6?=
 =?utf-8?B?TnVjMTFOdk9pZTJPeWNCL0xlVzFkVXVSV0dYZm5LSkdwU0xyYnNJZVNoallI?=
 =?utf-8?B?N2hNZkZOTEV5dXRFaXB4OWx6TndkV0NScXl5NHZVbzMvZWgvZFY5SmtpbUVn?=
 =?utf-8?B?Y2hXYVhRdUN4dXlTSENDc2oycVl2TTlkMm15eFFNYU11eTBRelJ6a2hzNFRn?=
 =?utf-8?B?emNJaUNxTThwN1Y2VXkyZis3RDJnT3ZMZWV5OUQ2aVBja256L3cwaTFMOU94?=
 =?utf-8?B?a2RGRmVEVlJCckZUUm5lL1NNODNGQTE5UFd6MW8wUlNmYmRmaE95cWIreldx?=
 =?utf-8?B?TXR1aGFuajNhaFRiUWpDa3pONDdpTThJQ0JVSTNCK1JUbU9hUDFBckpxQi95?=
 =?utf-8?B?S0hBbVRUcllOeTRHanQzak03dWRRVnBvVHFabnR2VThwNEJERUF5WG5MT1g3?=
 =?utf-8?B?TDJud0RoZmUwN1Q2L2RVRmRxemlycW50VGFnNlRQMnMzVWxFWDdGais4TGsw?=
 =?utf-8?B?aTVMTmU4RzZnSjhWYUdKRmJieWNSL3Z4ZVRZVjU2RndzaEprNnhLdVU0N2NN?=
 =?utf-8?B?RTMreVEva2RhUFBLR2pidVlVc0ZGQzJvSkdNR3VxS2RjZThLV1YyTEZsbnFH?=
 =?utf-8?B?c3dOTmFVUUp6ZmN4dXI3dGwvNFJoS3Y2Y3Z2VzJBeWR0dUV3ek1ubnVqemdq?=
 =?utf-8?B?TUNmcmpLRW8yYS9yZTUyN0xGMjBObys5aklPRlUwVktiOHYzNUhhL1NDdFBn?=
 =?utf-8?B?Kzhqc0VERFdvdjlwbUc1QWxBNG1zRE5YNklVVmo5RkxkbW81Ui9Fb2RjU3Y1?=
 =?utf-8?B?UXp4WElGci8vaFN3a2IxQ0xESFE4cU11bDR6S0pWbVRtL0QxRHpjSmJPQ2o0?=
 =?utf-8?B?dlhBZ1NaRXFZL0pYWFc0UFZPREh6MjBPdWNETjc4N2xmL2J4cXhxSktoNDZp?=
 =?utf-8?B?R0luVG1Gc1YrNHFXTElqdjNSaWdkblRqNlI5YWhYYXVMNnkrK21LU1hMM1dv?=
 =?utf-8?B?cXdYL3NNelhRMWNYVjlnM0g0d3RLeXhISWJjOUVlRlpabm13TEJGVE1WeVMz?=
 =?utf-8?B?blMxMUR4d09WSHpnSG1sK3FKM0wxU1VEQ0FaZE90Y1I0NVd4clRVcUxBUnJJ?=
 =?utf-8?B?RDJ1SERKYVYrV3h3VnVsWFpxM2h5WG1GRFczOTZRMU55MmZJMnA3M1o2Mkxx?=
 =?utf-8?B?SGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	xGHxYiFOZ39/SWqrj+gfYJxAKCIbXkFexxU+rDKV7rb3ZUTs+jocP6vaiYfIn9s/m3Dk8rdhUy+G/hDnk6TGEgFH4vpwyrk4NXHtb93Mg4P0quASsfZbabl9ontFLjLYj9Va+dC64/7T14ZN+5FJyP5MknlkGsq3K8tqb9t5GYczuf2g8ku6vc+ZQcRmHhe8W8J5PzrLjJvz//u+OJRrwSAIuGdHjFj8Ht1pOTo9s9WQk04p96+UDatWpJPEVvCXOz8uMyfTvR80b5Rw6B/CX7JmeIj9JGDDvRM2FRYDX/Re+XkyK5OPZPxEZtitC0QNWXc6HFz5jXYvlr4GtQ0MmK11fO5WssRFHiJxhmyMXcGdjf6XL61TOmpRfdrvWlzhKRGZoveK8hAgHi1qxG0ZLvcqHQqXJ4Ec5RUZTraoMYXIEcFKwW1PDD7KBW5/nJfwrSKhIDiPxWWmDJvE0ku8Smqr07WwlBLM2GW5mL8rhrgj8KblfL3PU9tuWqah52Mf9AHKrIETJsmlv01heTznsC0nBTQGoIPKs6966Uebmt3VPkmsaz6SRv72zla7R9633736Wj5Rbzyv1Y1EkB0lXuRFTGdXjaVY6ArzqO2DI4E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89edc1d1-9d72-4e30-71a4-08dc95c8b2e6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 10:14:00.9567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jKKzmv/IE5QT+P8w4RcWySbaBWcaHW6mt6BCDj4L6ByzqZq8hvfTo2jiaoWD3iNtrFg9ueEkgqvwqMnwzwd6rmjACkGBbbXd936Q1RwXOf0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6945
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_04,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406260077
X-Proofpoint-ORIG-GUID: 29nWhxcpSBrkU4RNiRImZShWnBbqHmlf
X-Proofpoint-GUID: 29nWhxcpSBrkU4RNiRImZShWnBbqHmlf

On 26/06/2024 03:33, Tian, Kevin wrote:
>> From: Joao Martins <joao.m.martins@oracle.com>
>> Sent: Tuesday, June 25, 2024 7:05 PM
>>
>> On 25/06/2024 04:33, Tian, Kevin wrote:
>>>> From: Joao Martins <joao.m.martins@oracle.com>
>>>> Sent: Saturday, June 22, 2024 2:43 AM
>>>>
>>>> +FIXTURE_VARIANT_ADD(iommufd_dirty_tracking, domain_dirty8k)
>>>> +{
>>>> +	/* half of an u8 index bitmap */
>>>
>>> the comment implies 16k
>>>
>>
>> Except that in mock tests we are talking about MOCK_PAGE_SIZE which is 2K
>>
>> That's why it's half the size :)
>>
>>>> +	.buffer_size = 8UL * 1024UL,
>>>> +};
>>>> +
>>>> +FIXTURE_VARIANT_ADD(iommufd_dirty_tracking, domain_dirty16k)
>>>> +{
>>>> +	/* one u8 index bitmap */
>>>
>>> the comment implies 32k
>>>
>> Likewise here.
> 
> ah, that's it.
> 
> but then existing calculations are wrong if using 2k page size?
> 

Ugh, literally all tests have sizes are based on 4K page size reporting. It
means we aren't just testing the u32 and 4K bitmap i.e. the 128k iova range
exercises u64 and 256k two u64 and so on 640K would exercise 3 u64 + 1 u32 and
128M would exercise 8K. Thanks for catching it!

Due to the u8 issues, I was planning on switching buffer sizes into "number of
pages/ptes" such that 64k pages are covered equally. Though problem with that is
that with 64k base pages the u64 case is already 4G and we would be allocating a
lot of memory.

> FIXTURE_VARIANT_ADD(iommufd_dirty_tracking, domain_dirty128k)
> {
> 	/* one u32 index bitmap */
> 	.buffer_size = 128UL * 1024UL,
> };
> 
> FIXTURE_VARIANT_ADD(iommufd_dirty_tracking, domain_dirty256k)
> {
> 	/* one u64 index bitmap */
> 	.buffer_size = 256UL * 1024UL,
> };
> 
> ...

