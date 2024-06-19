Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F4E153BE8
	for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 16:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718814882; cv=fail; b=SGXH/KS+z3mgC/Br2Gi2wdLUEmr9TJJSB+hHvdhmce9yAJbpPStNyRbhelzdcC7iJ9j4beUSZPUNh6gEYws9T4Wu5rXKJ3KwOiM6J/hyszx8ugQp7tHLdr9CBpvB6T8J4o343oOeORFaEOT55o5TqHsC3ZM6nHyGwgfKW+bMcQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718814882; c=relaxed/simple;
	bh=8HAt9a0T5WFAs2xtSqDtRFCNsn0zyLwVd0T5myd/xjg=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=or2PnDkl2/Wq+Q8jhMUWbMzLYMQZ0xIKpxJYR4ufr3uLpk0HBHO63OfIhjRwyksWxbVE18T1d3SLOjQscVaVZxzOOW1cVAfqlumS3icEX9OfaEbFzOzB/60hlHaqWhyG8lXIo8SgA6rYq7oq+VVr4pfdRZ+gCzNOUwViRv9WswI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GbaCgnwB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=z1odYP4k; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GbaCgnwB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="z1odYP4k"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45JFBVce014188;
	Wed, 19 Jun 2024 16:34:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:references:cc:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=FccRaA8+jQv+tjy2kbQo5OAgwMxdrb+/FooHQyW0b0Y=; b=
	GbaCgnwBPBEIXyD305jDFkghtaUUvrJA07jS0Mujidjoxh4nXNBqHeH+GMHQUTj2
	bIYP/15WvcmxEGG3ToHfyWP7NVYx2+i/wzIOM+59LeZcD9RC6d89tXNCHU2bAc2R
	+ApjpHItEBJzKdHaZyJBcdE98M5X07UDhdLQV8NZ1WDLXEBFYnV8dq6xaCduZghi
	Z5r51Xd5hswCpzPv9Ql/cUpPfZa6gabod+rFQLZABfLwsnYGgd/yVwoKbyquIDfH
	dbFv2uMdfIZytdF/KAoACLToQ4Mvkzde7swkqcFvJ9v4IR9xxQM6wihk6PjmyJ6Q
	Ofpe9IEut9zIGyqrLnx+mA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yujc09nq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jun 2024 16:34:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45JEsrsu014937;
	Wed, 19 Jun 2024 16:34:12 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2049.outbound.protection.outlook.com [104.47.70.49])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1dftn6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jun 2024 16:34:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1mncMOOEzMhYxIVmT4OQa31gWtQOAmWixj/7o2gQGNElA0PComzIkPSbx3ozpMQDgfDbuf1fLJeS4CXGBVaEk26UN5d5hMtLir1oTfp/mJ4IB6mr8WO4h3ZGDgoPgl+bC3VzChvep573nTofOhFCDG811YcMw5xmwRMWQPghWsgEt5tpck75Co5qSrkVf+m8THgrRy9TdMg5ErxqxCkQe+vpN9M31Vcibc6tMDm4KaXkbq8TxmEqDlt0mwvmb+DG47o/FZ7mp+BYebrzmUlXHSNtUss8yLOecVQX1zR+YRQ9Ez/x1nu3dyTbL1M4Aqle4yEzJvH1Joj6/K/iQkUuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FccRaA8+jQv+tjy2kbQo5OAgwMxdrb+/FooHQyW0b0Y=;
 b=ZuYuk9qM5zSYi57ENsLf3HkapVXKkaTZ0hm+1Qd+k7zHuKkOIOgFTUgC/Pyl2FpLKfblqaXv/4aTn6AqfJkKKAJfr3TV2wlSDR0ruaL/pakmAL6blrh75dy+27GIubV7/+9RCN0wEUaeex7kV6Ip/623W+PJf6d8FmHgyhAhM+IPCUg4rgcMaxboqJDY5msgY0vigwQu39dQc5b8N4RGOFQVZ9Z4WnSlS3cpxA9zPa2WOUNl2jPmeGt8/ZjUuqs0ZEaf2bYAXIHvZw6aMlFu+WfoIpHg/COQpSflziFz/WGnnIk13ip0q1lo34xPcDaT8sd/lDpdtB8vpvuli8mXtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FccRaA8+jQv+tjy2kbQo5OAgwMxdrb+/FooHQyW0b0Y=;
 b=z1odYP4kLC/NqQvV4FDN4dDMhsPqeiGt2nx131P/uf7MKKfreo+mK/UWRbF2rPIn20okzJo4Ma8Kn5K3aOi21q405thonzRG4U+MOUb8QAK+9jebbeD94wpCskGsK4ZshsB6ztqGiXJz/eIlqdOAuQWUi5kDWBHcMQFtxEzmkkI=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by BY5PR10MB4116.namprd10.prod.outlook.com (2603:10b6:a03:203::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Wed, 19 Jun
 2024 16:34:10 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%4]) with mapi id 15.20.7698.019; Wed, 19 Jun 2024
 16:34:09 +0000
Message-ID: <d003f916-28ca-451a-a2e1-e58c66fc3459@oracle.com>
Date: Wed, 19 Jun 2024 17:34:02 +0100
Subject: Re: [RFC PATCH v2 07/10] iommu/riscv: support nested iommu for
 creating domains owned by userspace
To: Zong Li <zong.li@sifive.com>
References: <20240614142156.29420-1-zong.li@sifive.com>
 <20240614142156.29420-8-zong.li@sifive.com>
Content-Language: en-US
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        tjeznach@rivosinc.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, jgg@ziepe.ca, kevin.tian@intel.com,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-riscv@lists.infradead.org
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20240614142156.29420-8-zong.li@sifive.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0453.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::8) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|BY5PR10MB4116:EE_
X-MS-Office365-Filtering-Correlation-Id: e9aef856-7d78-4127-5863-08dc907da531
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|7416011|376011;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?QVROY0FHRnkxVVMzYzZHYXFSWUFwWmw2YllzNlFJYWZWdWlNcGFuRW51Nnpl?=
 =?utf-8?B?OURtVFViM2FwQ1AzQmU5WEZFVXFPV2pvUm0vNFJCcVZld1YrSitFemVGQU1R?=
 =?utf-8?B?S2J1czBlWUZtTHhaNFdyMWEyMmp0R28rMnF6OE1PaERCYWdlekxEdFFvMjdq?=
 =?utf-8?B?RTZsK1gwWGxWY24rcWJraks0dWgrNnkxTGJTS0VreWxmMHJuaXpPZjViM1JB?=
 =?utf-8?B?OGVvanJiNXRMZTJqS0lFd2ZZMDVibnlncVdiWDdTWHVJb2dCTWhOMWMzcWRY?=
 =?utf-8?B?VlhpbGg1UnhRTGw2ZzZJVFpUMTBuaWZPUFk5cXUwMU5hNXB3ZWQzbE1jTCt5?=
 =?utf-8?B?aGlxNTNkNGp0S0JucGZCL1BnVHhCNk9xOU92UGo4VjVvTGk0cFhPL2dtdXhq?=
 =?utf-8?B?NTlmS0tkZkhQUG5UWkdGcndaeVE3YlVFOUlHOEFaUFNRcy9KblVNSmZURGc0?=
 =?utf-8?B?L0FHcXlNR1ltZjdQdldxd1JlaTV3NW9BSFYxQ1hZT3FnU1dsTXdjVWNhQnBY?=
 =?utf-8?B?OTVKM3pVQXlrQXVNcFh6ZUdlQVZZR3ZMenFzWHprVFJVbWEwcUt6b1ZjSDY3?=
 =?utf-8?B?Qkd0M0YzQ3VmR2VmYXp5VFRCSnJ0QmxsQ3V0dkwvMWUrNGl5bGM2Q2ZEOEZG?=
 =?utf-8?B?aWxxUWJld0tuRzJ1K045VDFvUmo2R0pnUndtV2o3UFFnVmZVYTd6cUJsdmkw?=
 =?utf-8?B?TGcrOFI5LzZwcVVqNDdESjEwcU9NdnlnLzVxeHVBMWlPRXpqSzRNVCtIa1RY?=
 =?utf-8?B?MFZ2NjBYUlpjV21DeXpVanRMVzhpNk1CWExpellTcGgwWUw2U0xlQ3RGSVc4?=
 =?utf-8?B?ZHF0V0g2cks0dmR2OWpsdGd4Z2kwbWZnWXBVRzR4SWZndGtLd1JwM1lUeVMx?=
 =?utf-8?B?Mm44UHByQkt0Yk9Cc3I2YkFtVlF4bGFRenVTSGI3ZHZqb091Y25tTExYUy9T?=
 =?utf-8?B?RitqcTRRVUpPTFh4NkFNN0NXT0lQa1lLMjhuQUwrdTNCeEU5K1JVYVhPdXhB?=
 =?utf-8?B?MXBYQ0Z5ZlVXU3JNcjNVRlhKTlpFV2NxN01pVXdRMXZ1TC9CVHVzT2FlNlBj?=
 =?utf-8?B?ci9uVU1ScEcwYWZaWmxQaXdwb0w4c05tNVFYQnZoTjh2S0pGNXl3YklCb3g0?=
 =?utf-8?B?dHNrSkZ5eG14VjgxQlJxajNiNjFja3A4bm5iK3kzUFYzRFRaak5DV3dGSW12?=
 =?utf-8?B?cDFzNXBzT0ovNFRIV2pRKzcrT3lmS3lUOVBVWnBIRGhickFyS0srdnBNYk8r?=
 =?utf-8?B?SmJucTNCekZacTdQVVVzYnZ2WWJrVTZHRy9JeGZnbEcwR25rS3QveU1VTDVn?=
 =?utf-8?B?Y3phS3ByaU0wNnJ5U3lxenJiOGNXOEUzZ0xHcXlTMWRPSmtWYkVxTzBFd21r?=
 =?utf-8?B?ZVlZb05KbHpNL2N4dmg2LzBLdFNjMkZyWDRDOVNROXBhR2FvVXl2dldTRTBz?=
 =?utf-8?B?VEFUL1hNS1pxSFNHWmYyMUtlT2ZtdFN2Tjk1ZHFucFJ4bndMSjliQ01ieWFu?=
 =?utf-8?B?L0ZTak9RajdyVjIrbW1xM3hOSEhwbGl1NWVsZ0tORUpyTFlKWnRLSWZOb29Y?=
 =?utf-8?B?OUFVZ1lINGIvaEtKS2UrOTFabmk1ZXhPVTJhcUNWUEJaRTRKYUMxN0ltejJT?=
 =?utf-8?B?UEpUcEF3UmZ4dlVmYm5aU2U3dDlzcVlMUm1Jc2t5b0ZMQVNJbVJnU1dDbVYy?=
 =?utf-8?B?K2dXMHY0NUZaTUNjNHZxZTgvNmIxQlBYcFROTjdodWEwZzdMdThqQWRsZjhQ?=
 =?utf-8?Q?Hdp+mm6fNOet5LLRxnZ0EVwpURnuyEuEPr5zT4M?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5893.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(7416011)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dzRUZ0UzQmI1MkZMd05zd1pvQkw5QVhEVzdqM0pIZ0p4dTZTdWsvb1ZqVWRl?=
 =?utf-8?B?SVNuUVJ1QzFsNXNRK3FUTnJERklCVmhKMXIzUzhYTWRuam4rWXRNY2ZiSlQ1?=
 =?utf-8?B?YXc5aFVHVTVnTnh4VkF0V0xmMjZmOWRKYkRZNU1FWks1Ymk5aC91ME9odGRl?=
 =?utf-8?B?TTBnRDBLaHQveS9WWk0xUzhuYWI2Rkd0a1g1VjFLaDRHSGdHV2txRFdoYmQy?=
 =?utf-8?B?T2VSVTRSOUE3SFdVaGh2dWVQTVR1RlQ3Ym9MaHZFZTFoVDdmR3ZBWGk5dVZn?=
 =?utf-8?B?WG1aaUZwaTBHVnkwNzhQWGNMZXViYUlsbVB3QVZCc0F3YTA4T2Rla0NWNldR?=
 =?utf-8?B?bDhUOGozYktVL2tKdjQ1ekhSQjRBdEY2UTRTck1NTFZRM0tTczVMY3YzODlq?=
 =?utf-8?B?Y1VETzB5eWZSU2I3dUwxbzh6VEltSkVoMzdoaFZYU09xQ0ZtTXBYTHd3QWJY?=
 =?utf-8?B?RUFveEh6NHdtY0dqT1FtaXI0RGJGc01pQURGd3NnNExMczdGSDJJdDd6YmxJ?=
 =?utf-8?B?SGhET24rRVQyL0o3OUVWVkRvRjk3c05EUDJ0UW03dXI5b3c1V3NpbXNHdXFs?=
 =?utf-8?B?dHJkSjMzV3BSWlBtZmZnVC9NT0MvVzgxQjN2aEYrbWliQlVBbVhtRVNKMC9K?=
 =?utf-8?B?OVdOZ3RxQ0JqNUhnV2FyOUdMbU5DdEhmSE5kL2JWaGFOQUJLQm9VS0FBNGlw?=
 =?utf-8?B?bHUrSGtmRzYwalloWFljKzFDdmFscFhSRVRZNDdoeGtXMHp1QmJia20zSnBh?=
 =?utf-8?B?TFpvdC9HclVrMkRTWUQ0ZGhIcG9tMld4V0p6VE9ZT1VTL1JJb2R4cGdpa00y?=
 =?utf-8?B?WWlQQTByRzNkUFBPWU1VR0VwK0plL1BFT09wN0xwRkZlaUFKUFMvbVYyeTJY?=
 =?utf-8?B?bFY2bEhtU0RRMkFBblhSaTBMMVVhbzdqRGtQUW90Uit3QjBrQVF2czBJNUpR?=
 =?utf-8?B?TXo2dW4wV1NsZGhDV2ZrUDk2OU5UMlAxVVVnaXRrQno5MnljajdveU9KVjJE?=
 =?utf-8?B?R2ZJUWhkckV1L3JYblg2Y1Q2SjcvcExheGwySkxYdlM3RlNWZ1BNK2ZaM3hR?=
 =?utf-8?B?UnpWMWY2U2o1QVRkcXBRWHdsT2ZzdkFBVGVvbHcwRkZ1N0dPK1pobHFYTEcy?=
 =?utf-8?B?dnNPMEtycWFHYndVckRtWHNmbE4vNmxUcFMxREtJNFVjR0VlY0RyWWZLMjBT?=
 =?utf-8?B?S3lhRjlHSUdnT0QrMkpQcDhHWjFIcGZvZXkrVU5PMzc4NTZidm5DMWZJSmQz?=
 =?utf-8?B?S3VEYkxyYVUvb054VlhwWHBiVzV2dnBGd3paMXFkcExOdENKZ08xdmZDZGla?=
 =?utf-8?B?TW9IZC9uR1V1V3NORmIzVkVWNE5nU3pGWFF1QWVtcytoMG01Z09QMWd0TEFL?=
 =?utf-8?B?Nm9TYzdraDBvZU1kMzVXNUJzcXgwVFZwWFdxMHAvT1F3ZHVicjRxTmpxeXEz?=
 =?utf-8?B?eDRLdFVTN0pJVWpYdmVYYUFjVHpjdlJIZHl6ZVhIQ3ZlZHlSdnNvUG5DVkEy?=
 =?utf-8?B?YXdINDZtZDNabk05azBSUkJyS1RvZzFUdjkyQktjT2FnL3E0RUwrTG4yek40?=
 =?utf-8?B?dzh1Tks2OEFZNW4zaU55L2ZPOE1PV1hwSXRBcFlDT0hYNjVDZ25iejJQU3No?=
 =?utf-8?B?dHg3Vk1oUGtCM0g0ZVNPMTl6RDBrKzBNa2lMUU41VCt1cWRsWnVMZ1gzMVRV?=
 =?utf-8?B?aXE3ZVJRVTlGamwxS2Q0Yk1WVGFaT0pKQXF5Qk0wemRvQjNJeTFmSVBqVkR2?=
 =?utf-8?B?K1pUWUVOUTdPeWhsaWhkRkRRSnNUOUZJOUZ4N0I1dkFDRUxoZGI1bnNiL3gr?=
 =?utf-8?B?cWpEaTdRVkVQMWV2YnQ1eCs5VkRyMWdhREgrZjFOTUI1L2NDakFLc1Z1QlVq?=
 =?utf-8?B?YlRtTGxPd3NMbTFHOXJEZjNtQTYrRmt6MlJPWmsrRWszb0l1ai9Hck9ncEhl?=
 =?utf-8?B?L2UwZGp4SDdWTGFJaUpIVkRUaDZEYnNyVm10V3doaXBOWDBaWHpmR3hiUW12?=
 =?utf-8?B?bUYveVNrbTlNNTMrVFUrSUlQMjJHRjZQaUYyK3kwdzVGY25jZy9PK04yeFM4?=
 =?utf-8?B?ZHZOMzBmcFhaMy9XeHR0OHVsQWNOUVZHNkljSFZXS0o5YVRsbUpEdTR2L0ZO?=
 =?utf-8?B?ZWwydUVEWlJ2M1dZZVBBd1NNaHhuY2N2OUZQV3VlUTVvcGpBZ2ZXNGFmR3dV?=
 =?utf-8?B?ZUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	2r3zi8LN1IzEkhNxjofXGLuPtRPYDRSTjd8mSF0ZwYLR0IkjznbY9MxnDSSAC3s5XpfW/ohTvR/ieN7ZTooQMy8pblOq+9CsC9zI4NXj2K+xsR1sDpSQWtqPPOo2f4lMYvRvNaBOeTNnupyyoJtMun3dOFLdOmPzsq/lmSaa+PXlm4kqvxvdsGUnXtVuJNUVooKsyYwhCavnA/kMuZu1m9t8bGPbOr/QgmcmIFxp0NXtcNUcu5w3hWwUfoiHnUZXmQt/p6sqDKwwETusScltpFq3eicwYybgg5EZchG9c37RTScfs0YdNAGBIX+8YbxVnrkZgOj2dnKjuuUdAb/SawPDm1Xb4ItM1wS3+hdU0omzQhsY6oChwOGgK6SkHhK2JJmgSR88arrrZKr8CIfPBXWbX+E3ocRp4YAQisFSFDYk4+FdLp5uEwHqDyJ1GLy48cZQ/iyNAVJvq5cGbUAM0jEKogiSmvLB4Ltc737Gq5KRjnzrDxu15Kx1GsJA0h/zO8vWw3J8Bsc5ZenIwcg4UXzkveW6XXFhOhvY/i+isZm7ngtJ/sp2D1k1J+bCJtyC55k/kUv0I3lWLr9dX8VyLRcT2n0kdfc7832MvUw2X7E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9aef856-7d78-4127-5863-08dc907da531
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 16:34:09.8963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F+qusgYZUTeyDaHPDjCl1Rth3dSj102ayWbgCsl07SeXJCMo1ppuave+COFrY86yPxIFcyvHTpZuV0fH4P+rq6PHCNDiRP0+Gz4ghEhbtF8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4116
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406190124
X-Proofpoint-ORIG-GUID: MLMP0q0WNs7YQFkg0xscIF97lX_qGVkU
X-Proofpoint-GUID: MLMP0q0WNs7YQFkg0xscIF97lX_qGVkU

On 14/06/2024 15:21, Zong Li wrote:
> +static struct iommu_domain *
> +riscv_iommu_domain_alloc_user(struct device *dev, u32 flags,
> +			      struct iommu_domain *parent,
> +			      const struct iommu_user_data *user_data)
> +{
> +	struct iommu_domain *domain;
> +	struct riscv_iommu_domain *riscv_domain;
> +
> +	/* Allocate stage-1 domain if it has stage-2 parent domain */
> +	if (parent)
> +		return riscv_iommu_domain_alloc_nested(dev, parent, user_data);
> +
> +	if (flags & ~((IOMMU_HWPT_ALLOC_NEST_PARENT | IOMMU_HWPT_ALLOC_DIRTY_TRACKING)))
> +		return ERR_PTR(-EOPNOTSUPP);
> +

IOMMU_HWPT_ALLOC_DIRTY_TRACKING flag check should be dropped if it's not
supported in code (which looks to be the case in your series) e.g.

	if (flags & ~((IOMMU_HWPT_ALLOC_NEST_PARENT)))
		return ERR_PTR(-EOPNOTSUPP);
