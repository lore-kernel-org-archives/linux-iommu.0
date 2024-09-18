Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E47F1C1AAE
	for <iommu@lists.linux.dev>; Wed, 18 Sep 2024 14:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726671104; cv=fail; b=g+Q1Aq3BynzNPCnuPAkhLitiaCrtVWBPj72ERQs4Zk71inOPiU/7k5Z9OE3QggKX5sa12Z9Gx+Xjrwsb7wwoha9QRrNI10jfekgSE0FCSi+Gzblx4gUhF63U2zeKtdJyIxDBEHbZccJ/+bBAEFm4dL+0dLBGFXFxtvRSmkeNU/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726671104; c=relaxed/simple;
	bh=fwuqFDOvuFgSPmiws926m6KEMJHIG3LbneoBru+RDLo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=idT1FykERBOuYyL2n0FpHQs+DNtzZ43hAjo6u1CbyoWSiBveqfnoCkIOG5wEzsxN31OyxBSQ86hv4FiJzt9FEXgOaH3D0kYBUuNQrw2SVTq1qnwe63foYFBCU+SWtOKXXsTeky2+yFX7Ja3Y0JoiKgyKcpM0GO1eSYowAqdOXGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oZpaHsBB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UYGbJM4y; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oZpaHsBB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UYGbJM4y"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48IElGB8001921;
	Wed, 18 Sep 2024 14:51:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=l1log/yJQwzcdFCsHUIvkuWymwUJ003GFz8+2CSvqRs=; b=
	oZpaHsBB37wblYR0VsaBMn62wCxZrEeWOxa4yqLiy8nz1am2Pq2AvbujaT5pX7NU
	KiEkoKHo6ok9BZuyzFMHqK7ckIkLHW/Ao97ds/dRT+gtemwIFJB6e4/LK1W1w4r8
	bVfI/URnkhTHVDihgfyjZsFChTuR7azozmMGqcE4ol13SYLVJIfptTzN0LvFSVO1
	J7xdm51QGrCtbRLf54T0QYzmaKUFTzF6Vjul/qcpVV04fM/c7hYTxXFfxkfySiWe
	rDAc+5haXAtd8D9rinMZVTMTfRvQ0RHBAGU5m+/nSPJJMlU+o76GN8CxseoVzaz+
	wNxVeB51Oc4QAzAuRqclgg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3sfshsv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Sep 2024 14:51:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48IElxax033968;
	Wed, 18 Sep 2024 14:51:27 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41nycjdp0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Sep 2024 14:51:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bTXqOP4f7baYm2os7aaK44dee4zW7COQRLI1W3q9ulMusLR/IhUm1pA/C47utjbJBbMuLAWdJCTAl/v6RDoElspLiHjdx44SiOv9gQyDW1CjuXt9wkymmBuHPRHXTSgLg51C5XDHueCRwidHctghc7HJUcvd/Yl1jDuRYSKjdDONQPi55+6DuQ1j1WTTk5PeGzJGv3yeZiUHqoRk9nl0Qt4+TYnRijs9KA17UEBaYtmlu0F/LWQrEZyOTat46H3p57A4ysKkocQdqxSW4xgIp4GQamKBbJSOhHvRRJZS4eCbOUbNmCTBE9QqkfwB30qcebZ8JZb7MWpYMTeyzp61Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1log/yJQwzcdFCsHUIvkuWymwUJ003GFz8+2CSvqRs=;
 b=jkdwn2+3M/1NR0IfzIriP97TMiJ2ujWVvfKNurFg2f/1v+3SKMsHR3IU/z2rws5+5jvMaVUnY2Y54EVGwiVd6qK4hOxiIxMaI1Fx+7aeY4AjWdQAj6lSJb73Zr64RFNWKP2PzxTPtK2xh6mRVpW9OVxt2RKKpKXj5TtwGcNkJfxOgwOSlBgs+kWxprEOgAUYl2Y8kLn6JISEXd1yLVMRfi2R/GQg6QfzF6VzG22KBFGPcJdQJtvOeyl4oOORUaYymnmORaGFgGSXsf4SXjhS/U1OrJdrR1+UB/4on7BHmUvm5lCKVx9Oo/9zSXH/QKFdnmHzhco8tZpdy2e55uPCIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1log/yJQwzcdFCsHUIvkuWymwUJ003GFz8+2CSvqRs=;
 b=UYGbJM4ylhb6l3HlWCXsIcHNGt99RXewYdmImkbABYwxgq1FYnM6By2AVfAJstu+JaeSv7yIEIpBXpgQKwiETNEw1m+2H5Wr2EAPQVy1bPM4rNVImA/ldJCjNKUq5PVEzPhviogL5jcAy26lnYPf1H/RV5guiL/7GbtBq7t+P8E=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CY8PR10MB6825.namprd10.prod.outlook.com (2603:10b6:930:9c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.17; Wed, 18 Sep
 2024 14:51:25 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.7982.012; Wed, 18 Sep 2024
 14:51:24 +0000
Message-ID: <98004c8e-f941-480e-b1be-8f6fd925871a@oracle.com>
Date: Wed, 18 Sep 2024 10:51:21 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 1/9] mm/gup: repin_folio_unhugely
To: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
References: <1726319158-283074-1-git-send-email-steven.sistare@oracle.com>
 <1726319158-283074-2-git-send-email-steven.sistare@oracle.com>
 <d25fc25f-34aa-458b-973a-f7de2438b837@oracle.com>
 <6aea6530-9f9c-4a9c-9c9c-2c29e8ae9e9d@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <6aea6530-9f9c-4a9c-9c9c-2c29e8ae9e9d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0964.namprd03.prod.outlook.com
 (2603:10b6:408:109::9) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CY8PR10MB6825:EE_
X-MS-Office365-Filtering-Correlation-Id: 3532db14-2713-456e-8ef9-08dcd7f15dd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YlZubXQwa3pLQ3hZVVRXdm40TWlkbFUyV2FjWkxSekZnaHg3STE4RG4waFN2?=
 =?utf-8?B?OXRmcXA3a0NmSHJ2MU9jdDk4a3ZvVUl4L01Kc3ozUDFMNGUzVFh5OGJkWUQz?=
 =?utf-8?B?MGdDZGN2RTBaUVZlV0Y2TXlac20wYkNDeUZTZTYwY0lDQ1ZmRlRia09KckVG?=
 =?utf-8?B?dmRYc3RaWE43bVgyNmJxZ2NiT1pvT0dYbzlURWxvdFoxcjVsRWY2RlRibWdm?=
 =?utf-8?B?NVlDTWpWZlZ5Sjk3NnVndzFUNW00WVBoVStzNjhJUW9Ya1RDYjlUWElpRXBh?=
 =?utf-8?B?OTFsMk9SdkNJY0pIQzVHRXlhMVMzUnRETk5QUWFTK3I4bmdGTzlYSjEwbk8z?=
 =?utf-8?B?OGFqa3RyMVcrR1ZQTDF1SHBFbTNvVlBvQkplQlNybEEwN2VWWmhPbUZKcnRa?=
 =?utf-8?B?TGViT0JDRmJMRU4yYjVHMUdXTlRod1ByOExzcjQxUzg2S0NhUi81VWM1YVF3?=
 =?utf-8?B?dmYzUk90c2tOdEpjK21jTTNWUG1OVUtmUHp6RjUyeTliVkN3Skc2ejVldjFL?=
 =?utf-8?B?Z1J4Y0ZzSy9ONHNQeHkwM2xPTnhRVVRCMXdrd3RxT0V5M2RTRnVzVUhmV3M3?=
 =?utf-8?B?Y3h3ZnNlbWNxbG9kV3NpUXBCOWZCOVN6Qkk3d1BGSmY1cmR6V1BENk9JYjNl?=
 =?utf-8?B?bUhBZkJ5eHdiWEN2aWRobGFGQ0h0aW9Ia3JIVzdwQ1FadWRyU2FzM1VVcTlU?=
 =?utf-8?B?Q0FKbEZzazRvMkdqbE1iOEpmVWU2SS9DQnNUWTZsbXJDbi9wMEViUnhvN3JT?=
 =?utf-8?B?STZRTXRSK09ZQlVndmxSM21ibmFYdVJOMUJybCsra3RURVZQY2txajFrd29Z?=
 =?utf-8?B?WjBwaGgzZzlTMFd0a2EzNW5veXBPZEd4RWhaYmkvSjdOcE4xU2pMaGlnV3dH?=
 =?utf-8?B?OGdqMHI1eEVxdzQrUHNoYm1QOU0xOVE1VDRhMlpmZ1Fab0lZQW1SbE9DbHht?=
 =?utf-8?B?UEV5bjd6Tm9LWkNIZlQzQ3Q1MTNraTlvS1U4YVo5QWIwS1ZobUJndmN6d3ZB?=
 =?utf-8?B?NWxBTDU5YUpKYU1IR1pUWTJUQjF6YnRpMVdzblBJWFByYnp3VUJKZTdwSTRR?=
 =?utf-8?B?cVhUVkNqQkpVekxGeWc2RGNNWDU0dWJyOWtSRTQwTXRtYVpRNE0rT0xjakRT?=
 =?utf-8?B?aFdFWTRQZ3F1dDQxNzdSeVpLb0g0czVBMjk5bWRQV0NXa1phaUdmMHd1RFlm?=
 =?utf-8?B?Szl5YWNvVnRQbGVHSFdINGVhRjVXQ2pTYUZyb25ZUHFiRE1sV0xxTytSUS9y?=
 =?utf-8?B?dUJCYlFhOXNDTVlZeGtMckFsSUgrdXJRb1draWF1V1J2ZFFvMFZ6M3k5UktI?=
 =?utf-8?B?L1h6OE5PbzJncURwRk0yOU1acWVweHZBdWxlY2FZS1BxWEI2QTIyS3NOYzR2?=
 =?utf-8?B?c09ucEZyU2RlVTJXS2lNblFtQlBnQ1ppNHFwU0R4ZDMvUDhPN0paMnlMTWZq?=
 =?utf-8?B?NS9vbHlpbUF5QnB2QmJ0aEdOVjNqMW1rZ0tBaGk4bWFsZnk0djFUVWFEY3N5?=
 =?utf-8?B?SUhHMDJhck1NbEdXdUJySzU2VkZyRnZyd205Uk0xVXZ0ekI2NXAyZUxGa1Ja?=
 =?utf-8?B?M2FJbFpuQXY4aHF4YmxGTW1MSktSN21QaWN2ak5WdUk5UEswR0hmRHFWd05D?=
 =?utf-8?B?ZnRsNCthZ1FpNGpDa2FqaExQK2JyUDdQOTJsU2pMYWdMdjl3RlRmWjF3cFhY?=
 =?utf-8?B?clRua3ZNaC9aejFrWGlXZDF2YWg5S01tZlhzVGNucmljenJMT1dKV0pWMENP?=
 =?utf-8?B?dlJKelRPa3dzWWdvV1pZeVdNYm1lVEFsQm9leEdTU284WWlvek9FNmRzdmVM?=
 =?utf-8?Q?5VKDXoH2Fr759GljRt9XWg14zRm7rxxPEBPWk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1I4YmR5UEVDUWdGTExBMlFUM3p4dzc3M3VQKzFFYVo5bU55VGtpeEJPYytw?=
 =?utf-8?B?dnRaZmg4dmMyWGIwOTlRVmxHMG9IZFpGZDJmMmVPTTJwYXo1dlczaVUydWpM?=
 =?utf-8?B?dEloeW5wdWxId1M5dEVNbldlUURXMDhRNjQ0WUljZCtnS1NrVExRTkllNVRP?=
 =?utf-8?B?OXRncE5QbVpyRVRhMjRtaEJkeDRaaERhSUFQSjQ2UmVIc25KanZWTTNrWGNt?=
 =?utf-8?B?UVlwUGp3eDgyZVVTN1hBYXlObnNjSi9KZVpYb3Q1VVRKb3h2R043M2M1S2Rq?=
 =?utf-8?B?ZEJCVW9scUdVTTBSam15YldkWFRWdnh4UFh3a3pGQnF1cHovWEpLaDJWM2pU?=
 =?utf-8?B?aWpkYStkYzNCZjNzN0pFeVhMU3E2THZEVlFaSXVXU29tN2I1R1pnNUU0Wnpt?=
 =?utf-8?B?eVEzdXJTcDN2bG1DOFpSRGh3UWpEWktKSHJURUYzRmlVcG95SFA1RkJiOXhH?=
 =?utf-8?B?ZThMQkZ2MkwvdUkwUWxJcy9zSkVWS0d1QnBiNDBmektVZWtVRE1LRytWTGxa?=
 =?utf-8?B?Mmw0T3NXeG1pb0UveXRET3pzcTZ2cWFNNkRzWXB1ZFJCOGtZSnhhNzhaUHl0?=
 =?utf-8?B?dWNOTVZGQytOUjhCODBtUXhheWFaUXpycWtQQlYzYS9VWUVFNlBncVpyUXFj?=
 =?utf-8?B?VnVONmlIRHdvZklONGNvSXVhZnBVNXJ6bFYwUUMyU1Z2RjBDdTBXRmh1dlVK?=
 =?utf-8?B?U1YrMHdWaGZhV3FSM2RBOHZkWlJyMUNMNGhuVCs4enhIaTlJOGhhRGpIRlJy?=
 =?utf-8?B?VzhkNS9obDhtTUxVVGM5T1lUdXQ0bW1LZEhUNDZwTFRCQ2l3MFdDc1gwVDZr?=
 =?utf-8?B?KzNNZFlRc1ZQSFUzOFpjSk5Ed2dpUnhJRzY1UG02WlhUM281c2tPNDhUUFZv?=
 =?utf-8?B?TTFEU1o3Y0FHcEZhS0l4UFIvY2pieUxuY3Vzb0tydTlCVTFJYkt1MmNZdnZ4?=
 =?utf-8?B?UCt1V2ROeHh1MGlDc2pZNUErQ2NrRy9obE91ZGh1YzBXY29yNndrNHhWSXcv?=
 =?utf-8?B?SnJJeXcrT0V3RDdEQXQyZW52d3hHVGdZZ0pHQmFzd3gvSkZCekMraWduNlZt?=
 =?utf-8?B?ZTBzMEpsait0T2ZRNjU5ZXd1T2c5dFdqZGFJOTJ0RW9rMytoUFVxYWVOVFZm?=
 =?utf-8?B?N1RTODlMNCtDWVlDd01YNmJUTHdQQWw2dUtDKzAxditHQ1ZKUXZTZnRYQ21J?=
 =?utf-8?B?RnFGOU1GbGsxQ3NlUkJWZ01xOVpSTXd5RDZUa2I3NUtBVkhUOTVtWmpLdDZv?=
 =?utf-8?B?Y2VHRTFmVU1lbE55NGdBRVhEaEE0SmUxdUI1OGZkUkoxYUcrb1loVURUTjN3?=
 =?utf-8?B?blJ2QTB1SGpzeVY4bUxwcEUwd0RWdU9LMkI0UVN1bWk1MisveFF5Z2wzRnF6?=
 =?utf-8?B?cGhCZE1pNlNQcXVQK093M3A0YXFzaEl5TXJkcXRhNnNXZncvNTB0bDhGQnNh?=
 =?utf-8?B?Uis4c1hyaTNxSGhrU0IxSDZrOVp3WkxGY3l5NE5Gb3NUWjZiZXJpZ21ZVVgr?=
 =?utf-8?B?THZ3YlpBZk9wS3J1THM0UkNvRko5SzFiSHBEVmxldVY0bXFmQXdlNEJhWkpU?=
 =?utf-8?B?NlQvL0YycFdrTlpuQm5TU1Znb2JzNjFhUjQvYjcwSi93aFIvTUtoTHhtZDNv?=
 =?utf-8?B?dVFRY2Q5bklHWDJ0VU5STUVWU1pYaCtjblZzL3RXSGFxMEpCdmZjR1ByYUM5?=
 =?utf-8?B?ZUd6ZUc2dXc3czVteTFPNnNCOWV2QVl3U0hhVlhoS3JZeCs3UWlVK0NQUFFG?=
 =?utf-8?B?NjM5VkNDV1UrQWR1TXpnR0RlTEw4cFNMMnRyTWNUNml5dldFeUdRSzFuYW40?=
 =?utf-8?B?dEhPbnpwa3JpWW5sYnhSaFZwcDZBVW1IdXk1OFRacXM4Q1dGNStuaTVIU2xm?=
 =?utf-8?B?bUgrOFV2OExRTER3SStCbDFKRjdVcGMzdTZSclQxdDZyemxhQVdjTkp0Yml5?=
 =?utf-8?B?OG9Cam9RZ1dwMm16eVA3b0x2WWMwR0d0MW1GWkVBOER6emxoTXExV250Tm1M?=
 =?utf-8?B?eUhaakwwck1tSXQ1d2hDYlFVaUxvSnJBQVlXV2RxcFQ4dU5lY3kzclJpM0hV?=
 =?utf-8?B?Wjk5L0ZOdUxhOUJ6aFAxdHUwZStjVEg3elNtaWRiazZHTVVXSWswZFg2R2tJ?=
 =?utf-8?B?cEljaVZTVkZ0dm1Kc2E1M216Snp1VDVYQ1AzSW1LME0rT1BKQzZrc25YMDV4?=
 =?utf-8?B?T0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	amSA+gAL1j54m6bvDr4hyOVkCjXWi0LOOmQeemUiHio9wCKidnCUc3YhYV8JNpSkpPSCxXj4u3yCdpmQZ3PDowVEtNRAlUFRj77X7MkkERZaaWy6R4BmcIc9DdTHxiDu0Wue7Gis6KfwNn8M96XYrMzRwgrVzvpv6tMy5fRfHtk62ZJnY3hl6A/WBKve133Yw4WE2dMMWaNBhcgVsxVyy4S9ovPj5IAuEmnVvrDO1VfteiRJ89x7fbmDmnLIhF2AkqhzeB7lZsQHxZD5PKseVgQCjk1D1MgGY+N4sicxz4XqsT2kcDicNnfGceRQoskkawEjjH8m9MTEOoJlCkc9rgkJFnrxhAEWpThanYt25lDP5HR5DWsUZerDFZOJwjFYm7gp7dMvenHbWfG3lTrItIjwHuhpRUsby/p7WzNBFGkwfXDtRBBeH2YQjz7qufWO7KDfDDBtPD3dc58tkrSXe9+0RcNVGI2HSRZhtdV74xDSLD8GAYints3HbAd52YLXTXJ4fPMm8RxV3sKKleBFe0a9VoSQiP/FkbPwZa/I1ksPacyfq94EgSGDKaLBOqIOjYV9YCTrM7ePgm3U/h2uQZJdFd16WHL/VfGyGBA71y0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3532db14-2713-456e-8ef9-08dcd7f15dd9
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 14:51:24.2208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XozlKDnCcrUiEhZydW8p3VVKehxcrCIlqQiMqJT/Q2qkYnstvSwJeypddGyKv/4nRnPm75VqfSP8xPXkAY/M2D+Gh32P4YxgRwQ9zI9Ys5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6825
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-18_10,2024-09-18_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409180096
X-Proofpoint-GUID: FxU3qLHGL5VhSLvz4pgYEKEJ73OiBbz0
X-Proofpoint-ORIG-GUID: FxU3qLHGL5VhSLvz4pgYEKEJ73OiBbz0

On 9/17/2024 8:25 AM, David Hildenbrand wrote:
> On 14.09.24 15:19, Steven Sistare wrote:
>> cc'ing linux-mm for review of this one patch of the series.
>>
>> This proposes a new KAPI function repin_folio_unhugely(), for use in this
>> patch of the iommu_ioas_map_file series:
>>
>>     iommufd: IOMMU_IOAS_MAP_FILE implementation
>>     https://lore.kernel.org/linux-iommu/1726319158-283074-7-git-send-email-steven.sistare@oracle.com
>>
>> - Steve
>>
>> On 9/14/2024 9:05 AM, Steve Sistare wrote:
>>> Export a function that repins a huge-page folio at small-page granularity.
>>> This allows any range of small pages within the folio to be unpinned later.
>>> For example, pages pinned via memfd_pin_folios and modified by
>>> repin_folio_unhugely could be unpinned via unpin_user_page(s).
>>>
>>> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>> ---
>>>    include/linux/mm.h |  1 +
>>>    mm/gup.c           | 18 ++++++++++++++++++
>>>    2 files changed, 19 insertions(+)
>>>
>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>> index 1470736..ba8344f 100644
>>> --- a/include/linux/mm.h
>>> +++ b/include/linux/mm.h
>>> @@ -2514,6 +2514,7 @@ long pin_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
>>>    long memfd_pin_folios(struct file *memfd, loff_t start, loff_t end,
>>>                  struct folio **folios, unsigned int max_folios,
>>>                  pgoff_t *offset);
>>> +void repin_folio_unhugely(struct folio *folio, unsigned long npin);
>>>    int get_user_pages_fast(unsigned long start, int nr_pages,
>>>                unsigned int gup_flags, struct page **pages);
>>> diff --git a/mm/gup.c b/mm/gup.c
>>> index 947881ff..f8f3f2a 100644
>>> --- a/mm/gup.c
>>> +++ b/mm/gup.c
>>> @@ -3720,3 +3720,21 @@ long memfd_pin_folios(struct file *memfd, loff_t start, loff_t end,
>>>        return ret;
>>>    }
>>>    EXPORT_SYMBOL_GPL(memfd_pin_folios);
>>> +
>>> +/**
>>> + * repin_folio_unhugely() - repin a folio at small page granularity
>>> + * @folio: the folio to repin
>>> + * @npin:  the number of pages pinned in the folio
>>> + *
>>> + * Given a huge page folio that is already pinned, and the number of small
> 
> s/huge page folio/large folio/
> 
>>> + * pages that are pinned in it, adjust the pincount to reflect small-page
>>> + * granularity.  Each small page can later be unpinned individually.
>>> + */
>>> +void repin_folio_unhugely(struct folio *folio, unsigned long npin)
>>> +{
>>> +    if (!folio_test_large(folio) || is_huge_zero_folio(folio) || npin == 1)
> 
> Why not the huge zero folio? That looks very odd here.

The zero page is treated specially here and elsewhere, it can never be deleted so
reference fiddling is skipped.

>>> +        return;
>>> +    atomic_add(npin - 1, &folio->_refcount);
>>> +    atomic_add(npin - 1, &folio->_pincount);
>>> +}
>>> +EXPORT_SYMBOL_GPL(repin_folio_unhugely);
> 
> Can we ... find a better name? For example, it's "large" folio not "huge"...
> 
> And repin is really misleading. We are simply adding more pins to an already pinned one ...

Jason suggests a better name in the other thread.

- Steve
