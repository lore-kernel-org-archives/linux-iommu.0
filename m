Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B9B20AF7E;
	Mon, 13 Jan 2025 16:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736785557; cv=fail; b=M9nCt9VIGsqeKP8Gjh5D2zdfwkDfoMXChUaw0X6AR4XglF1I890iGCo/zj3esBMbCWsqMYxqJSQ6NYOiOJluBPJ1UB8e6RCLujuO65uX8DAeNYMlkgJem7lXRxSh+FJ3SK4ZDaMqDTb3ekhj1ZBHYTj04Zx8+rRJlO7UwU+DfLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736785557; c=relaxed/simple;
	bh=GGl6f3CTFcODHTSb8RK8KPK/5/4hVaHLUkGDSv57NCU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZXLjMaMB5T3/FqJmr0zOWZ63WqPfccg1v+ye8vZHDcwHTojGftOqchipbjIdtZ52A7GdBpSFk1rFhnU6F3DRc5FjMJJaSu8hxPfRAm/ZFJmPjKbDrW4UHeRpjsaX8LsJCJXwSZiUlRw96jnWqSpgknzNLF3CCAqxuDEd49CzQec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=R+ABqPCy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oU6phwFX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R+ABqPCy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oU6phwFX"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DGO1hb001604;
	Mon, 13 Jan 2025 16:25:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=zkzVQkwMctU2aptvfFyKABPQe0esns55FLeVy0Hpvxg=; b=
	R+ABqPCyRElsq2/qhf5lB3cVNwJl69VVaIytVyldeJV1YIiHjZxSLadr5R1BFoKX
	LYrq8XifQA8VySMEs7c+J/xV1UgC3iO4DF+dFjNk1tcvddM6Oe2cnSast7ywc5vi
	gvhEEa52cngiAS3egd96sWV+jz6LRAgbpl1p/scGDippqCz5DgDtXJTtWAaR/0T/
	ZMQ4MOOIpI4ZXr1mjVwMPWHhrtNElKOKr59vrSDIBMjM/ZyWDud1C30gwRQP9ayO
	MHYfbkgpa1Gr7cXKR5L2eCQCmKu6mjiAHiKv8eAiG8I7iymeP0NyaLsjwNNzQC/s
	mCv0hunzsL38P7Rjdqyduw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443fe2c1v3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jan 2025 16:25:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50DFwB3Y034817;
	Mon, 13 Jan 2025 16:25:40 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 443f3769y9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jan 2025 16:25:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KRPzyRz+4Oj16j3+w+89KaZZSVlHHSBdgmw+VcgpIw9ifr6lQv3uFnddMd7wOk9nzo8LPxuT52KekDOFWL2xCMnl5vunEp/orSoTm6KHxnBcquz1w0QG6l3usET3S6KsjGUAJIDNOlsqXJI+OiGQAzWU5H70ixWNnx6utWMsio1Nl1ZXJEOGzByBmB6gyGQFSJFWU1GtBSS531kNZMeKDTXlk+3c3rMwGfaFFg2kCv/GzrBLV3B01lhfcjEVO9T76pJQxxU9QWaH6NMO+qXNXuNBGy5d/y97oOnLjns/DnbLtdlSLiFBNyDo9wAlmTy52z5EtwRsvyua3h915UDd1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zkzVQkwMctU2aptvfFyKABPQe0esns55FLeVy0Hpvxg=;
 b=jmVjTLrrck/w+fcGax9/z9Et7tZlXSz03CN6yLBOSNlW4yp7NuRFcvRXluvGBdpcCqHSNqdgjuk08g1I+vj/EdX6iLkdfM9iAqZFBjqXuduwKHyxSVRo09isRZ0RL6joJFPJ4puKTGZtrI15auhvpBPwzAbdAPqR/znhmAlyRfvfGrUN4ULkqVpluPsOu9Xrvl881gvOR4/CXp0/GwSqP41TD2JUglmg4A9bjqMZBtKAx5l73IyVDeqRDa44/3kJF8hQFvPcKsm6sIExvrz/dd7mEdyJs/D6pbrYgpxLF+NY5GtclkygYjG1th6jyeqRHScMcBrxtPiXnwAhS5INNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zkzVQkwMctU2aptvfFyKABPQe0esns55FLeVy0Hpvxg=;
 b=oU6phwFXMMCgP3WwWa4VfP18GH21NLqbftspXF5Yb11eu4+AFUxERKSlQ2kPgmQFYZJKQmJnFtANKnG8B7ICr21VP/fSReomdvV4XYSnDVPTSiWivZNQtfAu9mcEYWxD7pqr1WOPBTAkl06DutrJaO2bYzCPN/EXkxjIplQjGqs=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by CY5PR10MB6119.namprd10.prod.outlook.com (2603:10b6:930:35::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Mon, 13 Jan
 2025 16:25:38 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%5]) with mapi id 15.20.8335.015; Mon, 13 Jan 2025
 16:25:38 +0000
Message-ID: <142a177f-4e3b-473b-871a-2e929240efef@oracle.com>
Date: Mon, 13 Jan 2025 16:25:29 +0000
Subject: Re: [PATCH] iommu: Fix shift-out-of-bounds in
 iova_bitmap_offset_to_index()
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Qasim Ijaz <qasdev00@gmail.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
References: <Z4O4Du0WN95aP5Qs@qasdev.system>
 <670871da-eae7-4052-abc0-92f90e869790@oracle.com>
 <20250113162230.GH26854@ziepe.ca>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20250113162230.GH26854@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P189CA0069.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::7) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|CY5PR10MB6119:EE_
X-MS-Office365-Filtering-Correlation-Id: cc68f048-6951-4524-a1a0-08dd33eee9fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aHhWZ3k3QjIydHF2eHR1b3o5VnlKTGV5QlAyN1g1WmVvS3QwMkNoWWFzQVYw?=
 =?utf-8?B?QkswSEYzSzVtREtWVzV1cnVTckdCZkk3MmZTNGhWT0pSbytNWGpURWhKQXZP?=
 =?utf-8?B?ZHRoZzVMZU41amFEbkRhelE1M3BVSmlqbnFLejN4eFNsYzdXaUd5WjZYNWh1?=
 =?utf-8?B?TEc5MWRTUTZKRW5wV29JVDlaSWcxVDluK0EyQ1ZEM0xGemZidUNsMXR6RVFt?=
 =?utf-8?B?RkpMZ2svbnVoMjZiWkVMT2hjMU00MmZqcjJ3SU1QTFVFdDJLUXp1TTc5YTQ1?=
 =?utf-8?B?SWNyTlhSVlE2YkhDUUg3bVd1cDZRVW90SnYyQmxwcmRXRS9URTkzR211bmVD?=
 =?utf-8?B?dDhiTTJHTE5YT29RNk1WMFFiOU53aEI3UFo5Sk50WTYzaktQWGNEVmYvS0dx?=
 =?utf-8?B?aFNjYXNEalVINzdpY3NRK0JBQ1NCRkVKTkUwYTRMRVV4R2RaRzNEN2VBTTN6?=
 =?utf-8?B?WDA3cmNqck1WS0YyWEEvQkEzSEVmdEFDb09FSlhKMHhFQ1NuZ3dhcU5tUm1i?=
 =?utf-8?B?ejVOYWZJVjg4TjdLLytmUlR3VUF6eG5UV2FYVGQvRENaNjFsWjJtd25HYXFZ?=
 =?utf-8?B?VFI4Tk10cWZKNi9JTU8rdDNqUTJRdkw4MDN0QlVncjI2c1UySHY3dWxyc1hj?=
 =?utf-8?B?eEhONTVZdzkrdEtVWkpZUnVacWJpd2ZYMTJZdTFDV3lZUkJ5ZzBhZmVVVno4?=
 =?utf-8?B?MWpOU0IxTjlJUm5ycWNtUk96SEhNVHE2Njh3UUNlQlVBUVhzaXBlNWVOMmYz?=
 =?utf-8?B?K3E2U3lkMjlJTUJkMzhiekZPM0JhNnBkY01YSmhtbWxDRjN2UHNuTjNacmUx?=
 =?utf-8?B?Tm9sbHpnUGRFNmRsZ3RQNlRvbkU4ZTJuY3RZYUt5VlBvOFVmVDQzZjFjeUIy?=
 =?utf-8?B?eGNtMlRrYnViWGZOdUNkRnBTRXVrM05UcGlnVjBYMzZUbklCd1hCMXloNXg0?=
 =?utf-8?B?SFlpS1NYREJ6TzZIOWE1YWx0enRHbGlicnRER1JORzhDdnZKMFhmOGhtUlRk?=
 =?utf-8?B?SkZNNGxoQnN1a1NsUS91WFlGU2tNMWF1MFNBbVI0SHBSZnNrQVpNWC9GcTJw?=
 =?utf-8?B?UlV4NHRUbVd1UUtBZkpqenJWUHYyTmJCSzhvUDA4MHVPQnFnWHNXa0RnaXJv?=
 =?utf-8?B?clB0YVRiemtjMEFYMm0ranZUM1JMMjhFakFTYTFhMTEwZGxDSnZtMGxVSTZp?=
 =?utf-8?B?UjRhbnF1MyszNTdXUjhpOGVvZG93b0cvZGVUN2k1dUFrNGI2bThOWjZIenRZ?=
 =?utf-8?B?azhua3daSDZURVoxanA1NEV4L2VNclJxTTZDRHFxRm5xN1A0NWN4aWtzM1JZ?=
 =?utf-8?B?Y3ZUL0JMOUdTTCtjQU14ci9TWWFudmFGVWdRQmlXUFVQbGZDcTYzVmQ5QzdT?=
 =?utf-8?B?c1ZBR3FLcFRiQ0VTVitLWkdEWHkwY3RqZHlwVTBFMmRWUExlYnJxSUsxOUpl?=
 =?utf-8?B?aTdrdTQ1OFFZWUNUZ1NHKzg4b0dHM2ZVR0xLYitYeVcvb2hHSzRudVpCNFI1?=
 =?utf-8?B?dEYxcnZORzVKd0ZOMjdmVUhHTWRxVEYyMUJva0xyaXBvN0pyazFYRWQ0TTFu?=
 =?utf-8?B?YTBpT0ZoZ0cydWo0OXMram9HL0dLcmprZ0dSU0VkcUx3bnFGTzNvUmpVQXFx?=
 =?utf-8?B?YkxLZE5DcWIyc1gxMldLU3hUSzJYYUxzaHYvbmZVc0JkaW9VcXBvZFowVGtD?=
 =?utf-8?B?R3R4VHRrKzdKQXlGZGdiMER0R1l2YythalVmS245aVlQNkNKUkhLRWwrNm5k?=
 =?utf-8?B?RDMrSnZzZ1BGd0loVDF3aERueDdmT1RzQU5FT3ZkYkVRNEtWUTZSV3pjY2JU?=
 =?utf-8?B?ZkZqeEs3TGJ2cHo0NkVrZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5893.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXdObE5ZUytScWd0YlJvckJXM0dpUmh3TUFkWnFmN1g1ekhsQmdOZzRTNlRl?=
 =?utf-8?B?bXplaWd1bFBUQWZjcmJFcTRnOUo4VVc1TkQxVHN2QzkyOGczbTU4QVNSaktT?=
 =?utf-8?B?K20rbG5IbmxrMWlqN2M5RXpSZmdveG1iYWp5djc4TG1KMDZjSWU5a05vdzR2?=
 =?utf-8?B?ak5nVE92eFNmQ25MMHk3UmVKSHN4bERvcmowTkRzOTQ0a2tqYkNRSlpseGRB?=
 =?utf-8?B?cVBZREo3SEFPQTU5SHZXclBzVWJLOTFESEdkbEhOcE1LVDdOUjVuUWMreE5p?=
 =?utf-8?B?cXRpOE1HdEFYU0hrSjJiMlJYMTA0dGNQK2VOZE82Vm16b0NqTUJJNE43ckM5?=
 =?utf-8?B?UmtMd0xvNGxDSFZseGRSK0tNQnZGQ0krOVlsTi9wWVJmbyt3dFpZV0VHcFdK?=
 =?utf-8?B?VXNpWnRqZHBEbnRabE4yM3FxQnRUQm1WbUtTdW1SQ3Voem5zaUp2TUNPbUhK?=
 =?utf-8?B?WFlLRkd6VW9rN0xZL1VTR1hMSjBBTmsxR243OEhSZmRVbVNXM1BKZlNLcGxi?=
 =?utf-8?B?RWNCeUlSREdrK3hRRzB6MEltMGhIa054VnVzYWpSdzNmbGUzZGcxekxNa1E5?=
 =?utf-8?B?eFFNVUFmYnl0YUgySG02RHpYcFdZM3p1aGNrOUU2YVc2YXU5NGFpVkJuQ3Az?=
 =?utf-8?B?Z1MvbVdpd1VON05rRXpLTVQrcmphMUN1OUhxSzNIWitvdHZHN3V6QlJFcUlM?=
 =?utf-8?B?MjVWODR3TkhvYng5ZlJBczZIK2lma3pOeGRwdi9xV3pDZDA4MSsrM0JWRTkw?=
 =?utf-8?B?bngxSmpyem81ZVZTNTVyeVRhbWhFNFB5cWtqSEViUDExWm5vVVoxak5DNkx0?=
 =?utf-8?B?ZFpzL1ViN3pUbzVJV0VaSzRsTkxERXNCc2JaTzRqdzJMR0d4Q3JHR2xTUC8v?=
 =?utf-8?B?Wm5zdEsrODZtOFJ1bXFmcjU5Z3lteS84eUx2NjBXN2xldHg2SEh2T3ZKU2Rw?=
 =?utf-8?B?SWJLTWhQakFMMGFMa1htc20zQUlZYkdROFVsTkgrdmJld1FyN2NZazR0YW8r?=
 =?utf-8?B?WUZvZEx5emxVa3hpQndBSk1hZnF0dS92cmU0SHEzZVR3c1d3SjI1Z1JwRjBD?=
 =?utf-8?B?MHZWSmMrangrRC95dXNvWEluZzFmNm5Na3RUbFQvSjFDcVN0UjhtUWNNMmhE?=
 =?utf-8?B?SzlwVCtnVnhwdm1KUnJnb1Fwc1VxcmEyZ3RHVGNwbzF2QTZQb3BHVjNWK2FD?=
 =?utf-8?B?c0Npb0dNS2FmcGIwakY4Z3FSTTZUVWJWTXF6bzV1U2pVZVdCYVM5cWtzajQr?=
 =?utf-8?B?Znc2aTVhenlvUE5TV25XaGc5cGJKSGZGak95SkRCRHhOaGJCNGxaTUI0NkVX?=
 =?utf-8?B?bldOL1lIektNelFGQ0s3RDJmMTFmMTRUaVRjYlVOMGxXdTdDbHFtaTQxajM5?=
 =?utf-8?B?dEJYeFN2cmJkeE9zZ3A0R1hoZmVOV1h0bGtPNzZiMWpRajM3NnVKSmkrQ3JU?=
 =?utf-8?B?Wk9FcWhDY3lPa3JKdmxEMStTUnZyU0NLdVhBdW1KWFZPaVBlQi9lQys0UGNY?=
 =?utf-8?B?bTd6T0h5eHZCT2NTYzlsdUc1SE1kMGNyMTdHTDFDVzZxMnQvNUU2dmNnNXRK?=
 =?utf-8?B?R1ROdVVuWjNQS2FnNXM1a0xNTWZpN3lDWlNlNFFQVDB2TFVjeEVHdUVhU2pJ?=
 =?utf-8?B?WXNXY3hRenhQVUN4TXZ0TTlXbzNvQnhkWVoxTUpmdVFxNkxtNUxVZW91djh4?=
 =?utf-8?B?ZEhkRXpVNDczYVlwK002bWQ3U2FhSmJ1bk1Ob0FoMVVaMlpXT0dhSVJtYzls?=
 =?utf-8?B?STBMUnp3cDYyV0t6M3hDaTIxUS9EUHBYdHk3RVpISy9nc0xBYk9qb3E4WHNl?=
 =?utf-8?B?LzZxVHVaZE1RUEJpQVZ4RjU5bDUyQUNvVmR6Nk1RMmdKQU1ZWFdmdEYyVkow?=
 =?utf-8?B?R0ZGQkhBMVVnQWIyc3prbTFtN2pCcTV4LzhndGptcFYwdjVoNjVCamxpZVl1?=
 =?utf-8?B?ZTV1cUlheFlaUGRFUENRNFJraU5GdWV3NjB0RXpzM1pSbi9BcU9ZSEdCNmFF?=
 =?utf-8?B?Y2U5N0t3WFViRnNqbDN3bVpSekR3bXpnSDJUZ1E5VnRSaUtqVUMxN25QWG1q?=
 =?utf-8?B?MDVnQ0xyS3RxTURKOG1VOUlJcGZNZUpxdDVQZXpOVWZOS2xWdDNrYmRHMGZU?=
 =?utf-8?B?d3RvVGxZQmhSSkh3M2FqNWRwdXBQNU1TUG83OFBZNmVWelI1Qk05TzhubDJI?=
 =?utf-8?B?bFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5CN/K+zIz7D3eEEyA+C2B3JUlZTNrCR/Mxr8/3BlX/oKgQrvhF5k6NSywLsi4we7JmPoeSTJRtt4si9l10rgUjZG4/uPzFciUIMVBIQPu6EuV/BaUR0QLVT+wNk7wGRXvDSh+9VRYXLxQ47f1Hiv4U2qUt2cNpTupOjiEObqOe5DLH0RQTXReJFpt3ICKRB/bZErTWiIaj+S0LAEQ/uYplAGoaM17UoYb6nA20Ae7wwlgPsZgZeLtAAazIjL3S9ZOsit+wkBlJVGpIsJLSNer5KDSq9NVmd984Bodfjt/E0x7MxRaubHF+bi+Mh1PUz5lNpw6VVPV+EgEqo0ad53wQx8C0KASPmT3i/cBGIDaHIOvue/98WdFqP3JPq2I6A8IKcnxUvUneuWgnuZtY+cak0lqiqKqspFigPmdBNvhdFC078aA3r43JHluJJuBbVVDMcFLGC3+/xKT44eyEcu+zoKFpFgEK+kESIhMEN4O5YxG8ILMlKd1skOzRm9087FrnVYs11ZA8hqdmGAHG2qxr0M2/MLYWX4C/8m/nRdWAUbdqU1M1kFMLp1yi6xnMkOi4jXFYDMD4Lk1PpD2JXfG+3Tb4T6YMK3yI7/dmyTOXo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc68f048-6951-4524-a1a0-08dd33eee9fe
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 16:25:38.0164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W4aBKVumap8x1lLZ+6nXcPikK4EU6K6uiSOHCB1Oq09PVjW2WsFrKO7pN6+yhKpEpQ++ztfTLYXGN13mxHDWBzA6OkXg79HCmpT4A/uvOx0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6119
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-13_06,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501130135
X-Proofpoint-ORIG-GUID: WGt2VTTW3NrDnMIOFDiCS0qL8SN-q21f
X-Proofpoint-GUID: WGt2VTTW3NrDnMIOFDiCS0qL8SN-q21f

On 13/01/2025 16:22, Jason Gunthorpe wrote:
> On Mon, Jan 13, 2025 at 12:00:29PM +0000, Joao Martins wrote:
>> On 12/01/2025 12:39, Qasim Ijaz wrote:
>>> This patch resolves a UBSAN shift-out-of-bounds issue in 
>>
>> Avoid the 'this patch' e.g. Resolve a UBSAN shift-out-of-bonds (...)
>>
>> The Subject component part could also be a bit more specific e.g.
>>
>> iommufd/iova_bitmap: Fix shift-out-of-bounds in iova_bitmap_offset_to_index()
>>
>>> iova_bitmap_offset_to_index() where shifting the constant "1" (of type int) 
>>> by bitmap->mapped.pgshift (an unsigned long value) could result in undefined behavior. 
>>>
>>> The constant "1" defaults to a 32-bit "int", and when "pgshift" exceeds 31 (e.g., pgshift = 63)
>>> the shift operation overflows, as the result cannot be represented in a 32-bit type.
>>>
>>> To resolve this, the constant is updated to "1UL", promoting it to an unsigned long type 
>>> to match the operand's type.
>>>
>>> Reported-by: syzbot <syzbot+85992ace37d5b7b51635@syzkaller.appspotmail.com>
>>> Closes: https://syzkaller.appspot.com/bug?extid=85992ace37d5b7b51635
>>> Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
>>
>> With those two nits:
>>
>> 	Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
> 
> It needs a fixes line too

It should be

Fixes: 495c06d82ba ("vfio: Add an IOVA bitmap support")

  Joao
