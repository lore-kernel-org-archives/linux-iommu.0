Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0669632D45E
	for <iommu@lists.linux.dev>; Wed,  3 Dec 2025 19:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764790699; cv=fail; b=svzyFk7OT7md82qrAWSs3530T1HvH71eEu85IDd/NqLzYkYtNgKHU7ipOSeChKTpwdI4S3ounGQml9UXajKQkq6Z4Y2xk7QhXDoumjOu5AmUOjWenaUPDPhyi5+ZIBhYtdrffZtkjPwhSFSyLWdWwUFyoeC0KV2wnzaWmQDCsCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764790699; c=relaxed/simple;
	bh=Pqhs6K8pHh3otwE2Bve8jMKVT4PArpOGF35nWUvhxkU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H0wLo6mRjPFWVkCP4/mInAmMQvpzodq2D0DqhSdCLgs8x5NhPNhSMrTLZsxHd6ZYOdbVS80bqSm7ZDW8af1PF8dn2IybYSCXm9Cv8+MIY7AJvwNgZR9qFY98iU7UqJ8i/5Y9LwSdUVk4nEFuJjiu1gl4cSCCR07lrufSgtUkob4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CeXbX4hI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=C1VRFvGd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CeXbX4hI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="C1VRFvGd"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B3IR6PX3433796;
	Wed, 3 Dec 2025 19:38:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ByJS1QXduWGjZETA/cancx6GFQl6i08ksCHEwTtYMLk=; b=
	CeXbX4hIkucPhdwm225nzUcosagYk5Fcd3lFlFLwbdtD7EWxWI76ffAc+7RVb71j
	CPMUNRwt4mHurSlQRETWH7HAEFiyyYjXmjjggcIMfj7n3GtVNm6y5i4krQErGwbf
	ANZYEh9daggiec4rGvVEg5H9NXQQxtV0829lElx0iCeAlNgoc8+fUtSCUWjdbU4L
	1SmlwI8y6BgbUFMADYo0ey29zvsuy+3VKOB9jun8w7g47Yfil0jRB/2DwQHhWlxL
	FjxAcm4qgMOqVFxQcW7XFuIcJJ4nDyYG+ms+w61cLvVfZ+IfHOoF6Y+TwUfkFYVg
	F3SapJN17oSHlQPDySa5QQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aqrvc87wx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Dec 2025 19:38:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5B3JUHJO016556;
	Wed, 3 Dec 2025 19:38:04 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010018.outbound.protection.outlook.com [52.101.56.18])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aqq9avhvm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Dec 2025 19:38:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NsR5qogPCRt8Uu2G/OJt5h+rxwvmlIqkt5bu9gDPkEeu+OiWDPMHYJAy3VzFhn++h2zwhRA0JRxMPvy71fctIwXtmntbYnuTnPI7Qvk8WTvc+8Lx61TKN2lBUJZea6PktFv+YvtMqyTZ3sZMs7zzB5aVyyc59Hb/CAbc9Vkpp2rxFlKJ8rO7EaQ0KIoap7ol5gOvFkrz91QDgv3vP2dg1GXQHc+3u0WHGr0Jmf12G1DsCoH11EEvBNGjqPTXThtGvOOEYYO28jkpdNPoBlIRulGFx+pfxS8ondO0yxCrQkGS7oelnCEC6qAyVHPh2+a0JTl2UTKraCAM4y3A/6peuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ByJS1QXduWGjZETA/cancx6GFQl6i08ksCHEwTtYMLk=;
 b=sFFyGgrXqTE8A+FoqEEcm5bX+bDQKsVhN83dqnveH0jh0bYLUuhJAm7soOpgik9lp9y0ZiK/ksbzQkB8nB+1T1BqC16IQQfhPccIborLwX8o+JbtXYEEYYnqTCQRL/0AWpS+FiKjbQIJ9a3FjNSyi1CTMkg3LnNKB3YLI1aLUqSHTwDA79ACkN4di5TR6a+IAQzoWGFuMmDifmAF+Z+EObQo/FWz1FFOKLSuUJcNtnSjICihwWNbp3gUvTdEuXro6od+iPqlDmWwp7FZylsP6YYL/kLS5OeebwppnwQ/PFtgvEC+ebyhLjAuUaaymhAq9bhuALr2PBS+B8gHhFcPmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ByJS1QXduWGjZETA/cancx6GFQl6i08ksCHEwTtYMLk=;
 b=C1VRFvGdoleeGluS4i6RZgdxeQdDpKbNg76P64Bi4DW2vYtjBjGacOOncY9zGINKig+8DT18yQpvAlcNTl4KAq7UsUArDvEHE7wYGX1Q4wNvnusAvyGB6eT5yPreMyvaT1QukLraPUGFuSTflrDzxHNfccwBYQzQfdorm5WU3yI=
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by CH0PR10MB7484.namprd10.prod.outlook.com (2603:10b6:610:182::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 19:38:01 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%4]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 19:38:01 +0000
Message-ID: <19984e91-5023-4f5d-aa29-5771eb0f42d8@oracle.com>
Date: Wed, 3 Dec 2025 14:37:58 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Seeking help on AMD IOMMU unmap logic
To: Vasant Hegde <vasant.hegde@amd.com>,
        =?UTF-8?B?5byg5YWD54CaIFRpbyBaaGFuZw==?= <tiozhang@didiglobal.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "zyhtheonly@gmail.com" <zyhtheonly@gmail.com>
References: <BB681211-3C97-4915-87D4-42773DEC93CF@didiglobal.com>
 <f1919804-d949-4b1e-be9a-45008ce051c7@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <f1919804-d949-4b1e-be9a-45008ce051c7@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8P220CA0032.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:348::10) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|CH0PR10MB7484:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f56f16c-379e-47a3-8b32-08de32a37882
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c2t3ZzlLeUlTR3JHMW1KRzNMT1o1eVA0NmE0Wjc5Ym4vS3h0bndocEdLSmpj?=
 =?utf-8?B?N09mc1Z0YzMrMXhFZVRFcm5LVFIyOUpGZC81MXJBY2J4M04rUWlIbU1aenJk?=
 =?utf-8?B?K05uQk9ZeGZGM29QdlpxTVZaYnlUa05PVmVXd0NGMkhwVGVlbmF3RkJwb3d5?=
 =?utf-8?B?d0xEWVdjMWJHb2IzWVRlTzBVcU45dHdCZG11bk9rVmIwbkcrQnFSbzJWVi9z?=
 =?utf-8?B?UEJTTkM2YnhDK1lsRWhJUmhmWmE0Q3dYbWluYUFWOEUvakxCc0UvTHZRaG14?=
 =?utf-8?B?K1B2OEFJclZhUDdGUnB6N3g0REhSd1YxK2pEMDllYkZsbGxBaGM2M3VKcWh0?=
 =?utf-8?B?TGRRNGtmQTNPU05KeUJNWjhpOUZLV2lqWkpCNSt5NDJ2QXNmNGpZY2dqM1Q1?=
 =?utf-8?B?UkdlbUtvbXB4Q3Z1K0hvZVBqY212WERlTjhySFpaR1BEZ29JS0pkMy8zTDZp?=
 =?utf-8?B?SW1NaDFxTDUyN0lZQ1ZmWU9rdUR6Q3pxUEdRR1hhbGZGeVRYSjV3cUprRHBU?=
 =?utf-8?B?T1RlUExRVzF3N3R2WXVmSFNIWnB6YkpKRUVnY0d3VldzR3lCQmo2Ym9wRHRO?=
 =?utf-8?B?cEpZNFZuMlRpa3VBRUU4dW5zVGlESXUrWW4rVXRTY0FpejhEQzMyazRzSkhm?=
 =?utf-8?B?ak1XeXVPUlJiVUZQYjlUS0VkdUdpcVpMTkhaQkV3bGx2M2cwUUlHT2ZjT29E?=
 =?utf-8?B?TTZqc0tqWnQzcjU0bzZ2M1RueHJVTkNpRlZqN3lFNi9XZ1BucXE0MG5UZnho?=
 =?utf-8?B?cUIrZCtxY3IxYVJXbXV1a1ppRnp4VWxKeWtqVHRWRGdFdFVQYncvbE14cWVN?=
 =?utf-8?B?dTkxa3g0WmxGaStXWU5TWFdkYjZQWTFacFRBNzJnOG5XRitDUkc1NkpPZmNr?=
 =?utf-8?B?bUVxT1R4WEFIV1NvQVY2UlE4SmE0WGRFN0EvUGV3dWwxK0VmQTVwYUdVbTlV?=
 =?utf-8?B?SnZyUXBJVFBGd0hhRkRlc25pT3FEYXhRZkdxbWswSnNlaGV5V3pteXpXQTRa?=
 =?utf-8?B?Zi8yakx2ZTljQjJTWTRpUnp0d2hyWDRnVC9zTzRKTnNNeXJUTkE5UFptZDJ1?=
 =?utf-8?B?b0huQUVFZW5jb0lDSFAvRWdvemZRNGhxcGhhcThBZ3QrV1VPWTJhUDZDZko5?=
 =?utf-8?B?dG9KekNqVTlMdlkyTEhMYnNyZHFndVMwMzk4NUw4RVJxaUNVTThNZmdlNG1q?=
 =?utf-8?B?b2ZwSmp4RUQvWXVnTDdXWS9mZTRNbHoyREdXK0N6NG9ORnBObDZ4ek91OTRw?=
 =?utf-8?B?blJJc3Rnc21NVmoyb3h0YWVOTkJBdUdWcVI1Rzk1WmlxY3lUNkpvYUp5MWY1?=
 =?utf-8?B?MUtRR3VydFJTSGtEQ0F1MFg1alhZeHpWNDRYVllIaGdWNTIxNThmQkZzTmNt?=
 =?utf-8?B?ZGNsdHJvbXRZNW1GMFR6VUNjaklEWStid0VGWlFvS2lmYVdEb3ZHczJ6VGVu?=
 =?utf-8?B?cTZQdFNHMG5aTk9VQ1VUVFRxajVvZmh2TkNJVnNuN0gwZnJORStrUHdxNlRq?=
 =?utf-8?B?S2NLcGV0WVk5ZWtzSm5ZUU5uN2JRa3FoYUZYNCtldnQzdEdNL1JDWDd4VGJH?=
 =?utf-8?B?YllMMUQxN3h1eEtjemliN2JCWGkrZkFDUWNibHNySzlPUU1OMnpvR3FIdzdu?=
 =?utf-8?B?Tys1ZDNzbCtuakd0QmF6QW4zMXZEVW5TNmMySFVCRGlDQUlkOFY5S1FiM3g4?=
 =?utf-8?B?Y1B6eTBjcWMwRHViSG9EZmVEYU9EeGlqQkd5Y0hrejBFYXk2MFZMS05Tb1RF?=
 =?utf-8?B?SkZLTHVmOFRyNGM4Qi93TCtlRFNNSHREa2hXM2JTVG5BNDFIL25DYTNNak15?=
 =?utf-8?B?dHVNU0FZcWlWcXpuWUhyS0Y5ZmUzYTlVRGY3dEJmQjQzRXhhTWpJMEEvSVZ6?=
 =?utf-8?B?ZjZnYnJJWTlESTVRUVR2T1Nqd0JrNmZJaENSbU96cjJEMXh6cGttT3ZOK2x3?=
 =?utf-8?B?MmhZTDQyUHlhcVdHS2NjRVhQSHFTZFlFVzI1a04yMkdiRkM5cUdGdWllM0p5?=
 =?utf-8?B?dHpWVk9NY05vVWw2RWtNc2dwRlJSTHQ0cDNVOWVIcmxsSTNpWVlpci9qS0xi?=
 =?utf-8?B?aXdZb1lpK3M0NGpBVDF5eVV1KzAzbVYvdDZzdFB3WUl4TldONGN2dk1aM1pm?=
 =?utf-8?B?aG04VEZLc1pmOENGQUJhdzhsL1pQKzUzeXVuMzhWQXIyelVQeGU0L2haYzJG?=
 =?utf-8?B?ckxhY040R3o3anRXVDl0ZkM5Zmh6MXA4ZmZrYWJPVWtyZzBmeWJRNHhtMVZh?=
 =?utf-8?B?SmNLNWxwSllQWWtZYTY2enU3NDdobjhjbGdHRExOTmJ0OFI5ME4vQXc5TGNT?=
 =?utf-8?Q?0YlUw3lQkNdVW1lvx6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5041.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDkxN1lraUc4U0ViVFU2QVhQOTRCcXB1aXJ1MXVxMnJJK0hSKzRlTmJlallP?=
 =?utf-8?B?by9HSjBNZFNMNVpmdk1HcEZQQktIMURVc21hRVAwbHQyeHN5a3Fqd0FhYXV6?=
 =?utf-8?B?WTFMaVlENmVCQjZCWnVXVTBURnhKRVBzMjU5aUhlN0J3Qm5pV2F5SkRwWjRH?=
 =?utf-8?B?cDBabCtyaXoweEw5ckRVMTRUd3EvUUxaV1VPNmJRei84TXhLZ2VmUGhDQ3pm?=
 =?utf-8?B?QzVvdGVYUzh6Rks1bnpRcjkwTW8rNGFZakhKbS9GNnlSN25LaFlZLzdMU3JJ?=
 =?utf-8?B?YjhVeWxLZmV5VXlGT0R2SmVaRXVzMVZTclg2d1V2WGF2ZjhNanF0N05lbHJY?=
 =?utf-8?B?ZDk2dDgyR2dVTUhpUVFNcGZxRmVWWGV2eGFuSzIvS0ZhQXZ0bzYzYk1sZG9B?=
 =?utf-8?B?M3NEVFozNjh6L01PTGo0c0gwblhtL2Y1UG02L3R1L1ZIQXJhTk1QMng4bmk5?=
 =?utf-8?B?Sk1wakJESkR3OCs1eXB0TitNZDBiRm9HNElnbnYwZVNmclRoYWpuOUMyWlpn?=
 =?utf-8?B?RjlRUWVnUE1BTTc3TTgwaTRseVgrWFp6UHFjaGQ2QnhDYUI4MHptbXcwdGhy?=
 =?utf-8?B?eHY1SGlsRlk4T1NLYzY5cUJ6U2ZPMHFBdzI1RWlCYTNhMXpRTlNsUlF4QUdG?=
 =?utf-8?B?QlFTcDE1ZjNvaXMvTGpleE0ycThpZmtrc0hRTmliV2dwSjRIekxTNXZhRlU1?=
 =?utf-8?B?clBpNytUTVVUb1BjSkNnTE55QnVTczFwa2VrN3diRlV2RlRvMGJ6NURsOHhI?=
 =?utf-8?B?Zlhua1REVFF4ZnlSbUtVSU40YUFTalpLZ2Y5dllMNGg3TzlSWVF6ajJSd3dR?=
 =?utf-8?B?MXNCTFNPSVI2OTNtNDNXMEZuKzJyL0VidTZqdG1YdzQ3bHVhZDUycVp6Mzh4?=
 =?utf-8?B?LzRGUmt5Z0sxbTkvLzR2NFZveVI4VEs2cHpIOHEvT1Y5S0krc0JsM25sR1NW?=
 =?utf-8?B?Tkx5dEZwSG1nVEhCSnBWb1NWelFmMW5kb1ZyTVovUHlVeTJIcGV0ZTN5dUVG?=
 =?utf-8?B?M3RwQTdncFpNMkNQcmFsZmg1NDYzRG5kWEViVG8xN1BtdW1ETy9EMnZWWGlx?=
 =?utf-8?B?OWJNUnNaZ3FZZ3RDVkNoelhSczErbFJyb1ZqdFV4T292VC93VkcrZW9TUU9U?=
 =?utf-8?B?cE91MzAwV09XcngvTEhIZTh5cHVYaFdWdFhoSXg3ak44aU5ROHhlUDhSU2NH?=
 =?utf-8?B?VEFTa0VCNVd3N1hQc1hzdE1tWUdkTkdVSGJxNThDdEtuejdaWStrS3RiaWFs?=
 =?utf-8?B?KzEwNVZrY0J1REptS0c2UnM0WVJ3U2w4ajBXeTAwWjdiWVdzZmNNTURZUWtq?=
 =?utf-8?B?ZnJ3ZDNlbXhDaGRGcGloWE54MzB6eG5zb2taejE3eWxDMG5YYkJQYWRHeWE4?=
 =?utf-8?B?YXkySTRZallrQVpYU2RPZW9DbXUwQy9NZ0cyd1Y3a3ZIei9EWUNoM283SVRt?=
 =?utf-8?B?bzFzbGQyeDlWcjZreW1aOG1SMzBkNGZzT0w5Z3N4VUNaUDRBR1VROG92T2pB?=
 =?utf-8?B?L214dmxVMlZOZkxVcXlEVG92byt0amE4emNhb0JhQklBenFwTDRtbTRFUXlH?=
 =?utf-8?B?NjlTNTB2SWkybzNmTUQwQVcwVGxUMVF6VFQ0VG5jcjA4dUgzWTV2S1FIWFhw?=
 =?utf-8?B?bnVWYUtham4xQVBTVmd0WkF5ZGJ5cU5iM29GQ01OaldMa1R4WTZWYWViaDFx?=
 =?utf-8?B?MDNsVkZ1SlNWd2k2Q0dXMUFQRndzekZsUU5ZVnJWd09VSzNQeG4xWkJadXJN?=
 =?utf-8?B?YldiWFpxSWRMZVB3VW9idXBaaFk5RytYMk14ZEVkTk1JeWx2N0hubjZRS29D?=
 =?utf-8?B?TnRIN0tiWUV6cDlwWmZPejI2MWtVV0UrMDYrdUQ4OFB3K2FwSGNSYTRSTmJE?=
 =?utf-8?B?T0k0ejNVaCtPYlpuL01CTE83SVd5TjVLQ0FtdmM3OEpTSHVaZi9vTi9XUzNQ?=
 =?utf-8?B?THp4MWYyYm9tVUZGeHZCVnE5VW9LWTdtMjlaM3VwQ3dLVWZMVUpwL3p0TjRz?=
 =?utf-8?B?MTZXRjYxcVpSYVpzZldhbUwrSmo5OEd3S0RpdlJsU3FuMG5UZ3AvSFFGem1B?=
 =?utf-8?B?QmpUaXJsZGVvMUl0L3kvampJOVRYNHNtd3N4OVA4U3RmUGxYVEZSdnRDcm5j?=
 =?utf-8?B?K3VnUEgrZGs3bmhsNHlwaWNHSmpKQUJEVVpieEl2NGlKZXIzNW9BR0FuS1Nr?=
 =?utf-8?Q?Io5gRMY5Fp/ABeCJ9HnIu7I=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BwVinqqsDxM6s0W9ni+ZuNYaAU5oNN9WB1L/tq+RGrmyGo/qeo6mZUayLaVrUz2a9wmRI3hSbKo2BE2ECnqvWyAymMCeb6Qi+LkJgrUQCccGv9+wXO6PhYYAskDySG40b0zRUx2QOL4LqmE64BAseAPW7Gvs+tXXSwE6YcMuuD3lQ7bcZ6wW9edtLGP3U655F9UrPONiz1WsF3SuOenQH5YWOSGHjXyul3fBoeDfrW1ypwTIK8sxk3SY6yjai4EAs9vPb+HOA3PY0o7smV8Gp+BP0Kudlg3nueiHpthaG2pPdr/TrBgponLPSg3jvtTPtqojUD0o8I1AWg8tarmWevf2qyd9Alo0Ly+y25v4Q44dKcEM8I/Dkfk4q5ecDAO3qZCNVoRwItSyRSjF6JCAUGQ9EbUjDkNxiTz9SkJTdOtaYy0rx6ZzGz0iJRbBjvarj744cb8k3E2e6IiHROHb4WfvilX622b382WCO0885j1p5SxOcch0nE2HXzDhzm24Z2/v615uzPQcnFDjcS0POapZJLEs9+rPWUQ2DPaVwB0PBVakEl6oCUGmmoeSPx1UTduqaExWKOZGH5ZuEUlDLXAGajC8Qn/TdJ6ajlmTp2M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f56f16c-379e-47a3-8b32-08de32a37882
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 19:38:01.7173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TC7Cqbuw+moitYoK8XQENic2fC2n4676Oo1w9qhNAzA7E8STSZ98k0jpCbkX1yeEqiNxJCIhctfgYBm6CMQB+W0j9nSsSjbs8sdcjGMKCuU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7484
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-03_02,2025-12-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512030155
X-Authority-Analysis: v=2.4 cv=ZeYQ98VA c=1 sm=1 tr=0 ts=6930919d cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=zd2uoN0lAAAA:8 a=VwQbUJbxAAAA:8 a=vOPSBe0ug796sZOgeQQA:9 a=lqcHg5cX4UMA:10
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDE1NSBTYWx0ZWRfX3DMUVogrUqVq
 VmRjREXTgGAIv/6Aptpm4cvH08khtAe2Tz8QGa7hejv1KDwY0LpZ4eugGIaMZThb/a7kCGpg4tF
 dzZRsuW8GwgiKKEpeKFgw25yEHCJhEtrWHdohhCfmkRrxDokZcOmn7Pj2A9B0P7gVjz5Sbs9F1s
 hiUw4ygQXQgVN5eTXi/sno9Da7B5+5y7NA/9D67XvimM7DiH89cyeTNsgy6mG4Y5L+6NLOtchUo
 LLO9edJ+t+e0vc7ITqzmMV02WUSA+WwiEJZ0iPoBlydQiEuc/5evHcp4Db68yMBPsOtArKxlEr4
 ukaILRZvB1724H/uWhk/Ki9M2eRtinHSTSkARdpCSKHlCG+hUq1gkG5VTDYAMlpEkvunbaDd7kg
 wU0WHHRmt65vL8GHp98pEZCnfea9oA==
X-Proofpoint-ORIG-GUID: gXJF1_3jrXqX9wuAiIjEvp_XocjazchS
X-Proofpoint-GUID: gXJF1_3jrXqX9wuAiIjEvp_XocjazchS



On 12/2/25 11:48 PM, Vasant Hegde wrote:
> Hi,
> 
> 
> On 12/3/2025 8:19 AM, 张元瀚 Tio Zhang wrote:
>>
>>
>> ﻿> 在 12/3/25 上午10:25，“Vasant Hegde”<vasant.hegde@amd.com <mailto:vasant.hegde@amd.com>> 写入:
>>
>>
>>> Hi,
>>
>>
>>
>>
>>> On 12/2/2025 5:01 PM, 张元瀚 Tio Zhang wrote:
>>>> Hi Vasant,
>>>> Hope all is well!
>>>>
>>>> My machines crash at "BUG_ON(unmapped && !is_power_of_2(unmapped));" in iommu_v1_unmap_page(),
>>>> from vmcore I learn that it is probably caused by adding unmapped to an unexpected value after a NULL pte found.
>>
>>
>>> I am not sure which kernel version you are using. Its very hard to figureout
>>> where you hit this BUG_ON etc. Providing basic details will be helpful.
>>
>> OS: Ubuntu 22.04
>> Kernel: 5.15.0-97-generic
> 
> Hmmm. Its quite old. Can you test with upstream kernel?
> 
> What tests you are running?
> 
> 
>> CPU: AMD EPYC 7643 48-Core Processor
>> CPU Flags:                 fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse
>>                            sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc
>>                            cpuid extd_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16 pcid sse4_1 sse4_2 m
>>                           ovbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a mi
>>                           salignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfct
>>                           r_llc mwaitx cpb cat_l3 cdp_l3 invpcid_single hw_pstate ssbd mba ibrs ibpb stibp vmmcall fsg
>>                           sbase bmi1 avx2 smep bmi2 erms invpcid cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsav
>>                           eopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf x
>>                           saveerptr rdpru wbnoinvd amd_ppin arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flus
>>                           hbyasid decodeassists pausefilter pfthreshold v_vmsave_vmload vgif v_spec_ctrl umip pku ospk
>>                           e vaes vpclmulqdq rdpid overflow_recov succor smca fsrm
>>
>> Dmesg:
>> [21447.107424] kernel BUG at drivers/iommu/amd/io_pgtable.c:485!
>> [21447.113876] invalid opcode: 0000 [#1] SMP NOPTI
>> [21447.118960] CPU: 40 PID: 47841 Comm: kworker/u192:1 Kdump: loaded Tainted: P           OE     5.15.0-97-generic #107
>> [21447.131916] Hardware name:
>> [21447.143105] Workqueue: writeback wb_workfn (flush-259:0)
>> [21447.149024] RIP: 0010:iommu_v1_unmap_page+0xeb/0x120
>> [21447.154535] Code: 03 f3 48 ab 48 8b 45 c8 48 89 c2 49 01 c6 48 f7 da 4c 21 fa 4c 8d 3c 10 4c 39 f3 0f 87 6a ff ff ff 49 8d 46 ff 4c 85 f0 74 02 <0f> 0b 48 8b 45 d0 65 48 2b 04 25 28 00 00 00 75 16 48 83 c4 10 4c
>> [21447.174772] RSP: 0018:ffffa658c0e88b90 EFLAGS: 00010006
>> [21447.180476] RAX: 000000800000bfff RBX: 0000000000040000 RCX: 000000000000001e
>> [21447.188129] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9932f8406258
>> [21447.195814] RBP: ffffa658c0e88bc8 R08: ffffffffaa269f00 R09: 0000000000340000
>> [21447.203466] R10: 0000000000040000 R11: 0000000000000000 R12: ffff9932f8406258
>> [21447.211216] R13: e38e38e38e38e38f R14: 000000800000c000 R15: 0000008000000000
>> [21447.219032] FS:  0000000000000000(0000) GS:ffff9950fd200000(0000) knlGS:0000000000000000
>> [21447.227778] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [21447.234137] CR2: 00007ffc1e1f8408 CR3: 00000001cbd2e006 CR4: 0000000000770ee0
>> [21447.241870] PKRU: 55555554
>> [21447.245015] Call Trace:
>> [21447.247936]  <IRQ>
>> [21447.250482]  ? show_trace_log_lvl+0x1d6/0x2ea
>> [21447.255328]  ? show_trace_log_lvl+0x1d6/0x2ea
>> [21447.260120]  ? amd_iommu_unmap+0x53/0x130
>> [21447.264582]  ? show_regs.part.0+0x23/0x29
>> [21447.269037]  ? __die_body.cold+0x8/0xd
>> [21447.273241]  ? __die+0x2b/0x37
>> [21447.276733]  ? die+0x30/0x60
>> [21447.280123]  ? do_trap+0xbe/0x100
>> [21447.283824]  ? do_error_trap+0x6f/0xb0
>> [21447.288129]  ? iommu_v1_unmap_page+0xeb/0x120
>> [21447.292906]  ? exc_invalid_op+0x53/0x70
>> [21447.297229]  ? iommu_v1_unmap_page+0xeb/0x120
>> [21447.301995]  ? asm_exc_invalid_op+0x1b/0x20
>> [21447.306632]  ? iommu_v1_iova_to_phys+0xa0/0xa0
>> [21447.311520]  ? iommu_v1_unmap_page+0xeb/0x120
>> [21447.316289]  amd_iommu_unmap+0x53/0x130
>> [21447.320664]  __iommu_unmap+0xf9/0x1d0
>> [21447.324703]  iommu_unmap_fast+0xe/0x20
>> [21447.328861]  __iommu_dma_unmap+0x9b/0x140
>> [21447.333266]  iommu_dma_unmap_sg+0x8e/0x110
>> [21447.337746]  dma_unmap_sg_attrs+0x46/0x50
>> [21447.342288]  nvme_unmap_data+0x53/0x100 [nvme]
>> [21447.347096]  nvme_pci_complete_rq+0x84/0xa0 [nvme]
>> [21447.352271]  nvme_process_cq+0x158/0x220 [nvme]
>> [21447.357166]  nvme_irq+0x11/0x20 [nvme]
>> [21447.361265]  __handle_irq_event_percpu+0x42/0x170
>> [21447.366378]  ? task_tick_fair+0x82/0x820
>> [21447.370661]  handle_irq_event+0x59/0xb0
>> [21447.374838]  handle_edge_irq+0x8c/0x230
>> [21447.378998]  __common_interrupt+0x52/0xe0
>> [21447.383313]  common_interrupt+0x45/0xa0
>> [21447.387474]  asm_common_interrupt+0x27/0x40
>>
>> There are other crashes in different driver modules (not only "nvme"),
>> backtrace same at "dma_unmap_sg_attrs" and all above.
>>
>>>>
>>>> 251c4db699ca7b966db7e59e8663a231c96ba454 seems fixed this, with the commit message
>>>> "Also if fetch_pte() returns NULL then return from unmap_mapages()
>>>> instead of trying to continue to unmap remaining pages."
>>>> Could I fix the crash by only applying this part (return when fetch_pte() returns NULL) of the patch?
>>
>>
>>> I wouldn't suggest to apply partial patches unless you know what you are doing
>>> and why its safe to skip certain hunk.
>>
>>
>>
>>>>
>>>> Tracking the mail list, I find
>>>> In original patchset V2, this BUG_ON remained
>>>> https://lore.kernel.org/linux-iommu/20220713053034.12061-4-vasant.hegde@amd.com <mailto:20220713053034.12061-4-vasant.hegde@amd.com> <mailto:20220713053034.12061-4-vasant.hegde@amd.com <mailto:20220713053034.12061-4-vasant.hegde@amd.com>> <mailto:20220713053034.12061-4-vasant.hegde@amd.com <mailto:20220713053034.12061-4-vasant.hegde@amd.com> <mailto:20220713053034.12061-4-vasant.hegde@amd.com <mailto:20220713053034.12061-4-vasant.hegde@amd.com>>>/
>>>> Then in patchset V3, this BUG_ON removed with "and minor fixes to unmap path." described on summary
>>>> https://lore.kernel.org/all/20220825063939.8360-4-vasant.hegde@amd.com <mailto:20220825063939.8360-4-vasant.hegde@amd.com> <mailto:20220825063939.8360-4-vasant.hegde@amd.com <mailto:20220825063939.8360-4-vasant.hegde@amd.com>> <mailto:20220825063939.8360-4-vasant.hegde@amd.com <mailto:20220825063939.8360-4-vasant.hegde@amd.com> <mailto:20220825063939.8360-4-vasant.hegde@amd.com <mailto:20220825063939.8360-4-vasant.hegde@amd.com>>>/
>>>> https://lore.kernel.org/all/20220825063939.8360-7-vasant.hegde@amd.com <mailto:20220825063939.8360-7-vasant.hegde@amd.com> <mailto:20220825063939.8360-7-vasant.hegde@amd.com <mailto:20220825063939.8360-7-vasant.hegde@amd.com>> <mailto:20220825063939.8360-7-vasant.hegde@amd.com <mailto:20220825063939.8360-7-vasant.hegde@amd.com> <mailto:20220825063939.8360-7-vasant.hegde@amd.com <mailto:20220825063939.8360-7-vasant.hegde@amd.com>>>/
>>>> I'm also curious about the details of why this should be fixed? (I know little about IOMMU, from my understanding
>>
>>
>>> You mean BUG_ON ?
>>
>> BUG_ON and the logic of "Also if fetch_pte() returns NULL then return from unmap_mapages()
>> instead of trying to continue to unmap remaining pages." :)
> 
> That's because there is no point in continuing if some unmap fails.
> 
> Wild guess, you may want to backport Commit  1e56310b40fd2e7 as well.
> 

FWIW, recommending this backport was my initial reaction when I read 
that the BUG_ON() on iommu_v1_unmap_page() was being hit.

The original message suggests that the issue is easily reproducible ("my 
machines"), so I wonder what kind of workload/setup can trigger this, 
because the race should be quite rare given that it would only happen 
during a call to increase_address_space().

Alejandro

> -Vasant
> 
> 

