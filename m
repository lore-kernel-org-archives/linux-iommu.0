Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1D21095B
	for <iommu@lists.linux.dev>; Tue, 25 Jun 2024 11:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719313517; cv=fail; b=UKpg0d7YZNcaW64nykTMFojrsMPdusmjh95VyOXoNLXW8dZQ5Ym6nXL/44hWNzgemfGgHC2vDsWhz2A8xC8rULfKSHhUm0mcYU/QoIRXEJHTcqkHK4hG+5TcGFD5smlh65ZDtgSU1EwZO2lcxdwn1MM9mgmAsmpe2xIj5ndnqfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719313517; c=relaxed/simple;
	bh=nZtSqWhKIt3vRIalcd3YXJFJLCZB/fh0FlIy3wATHD8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ih/f/YItiMOVWRBLUE42hh4NU/B+KvYsV4Lw/dXoOfD/XhJ+wdxPbzTC9uVcLog28CQcXRD1eS9Xpt4uTVlPsSX9IJyCU/2DiUYH8ccMXh2lt20P7jnFsZyhCeeYS8xRzsfdc/GCsj1Odel14MczmQxmZRboxFhczuOLZQzrUSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=F2dQo53s; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=k08Io8A4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F2dQo53s";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="k08Io8A4"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45P7tSt0016635;
	Tue, 25 Jun 2024 11:05:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=OQYS7OHytlV7uPQ1r6iRZj4wnONRB4+N5ECS1fCff8Y=; b=
	F2dQo53slx7KGVdYySPm9j1mJX4/pf6sQMAU/cdVUS6NcOCthTEq5BDqflTYpEb2
	cyO+3Ggcu4TkuHrI2mSqGuxM/XIjLHDZPHF9c3idJ2mZMMIH2ZqlMzXcGa7Nvvc8
	Wt5+ahtNUJZ6dU0we6fumzgwGlXDnrSj0aKJx9MA266Lqm0e0SI7YlLmC++7Hycb
	BqItRInXVhFk9t25NzDSvm729xEKTIq5Lepq3EJnJuV82wz36KOO04OYl4eh0as2
	BvV1iOMHk1UZKSdrqmB5PXs8bMqKq+bpnOAZo26kRg6NO+T7DG1lDr+xEX1bMfGi
	+vp1Vn3aGuWigC3vtYnCEg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywnd2gem0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 11:05:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45PAAlXW017811;
	Tue, 25 Jun 2024 11:05:05 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn27bbk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 11:05:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5Af7fX0by17XYXVckVoUkkBE8QUSW/C9a3878qOi/2LDYfu5erD9BVGyTyR5iiKmj/yUuIE3DoAf+JTBWSnuTEN+K0UDdPJ9XCz3JrmMCouXT9M/LYmumx95DPhxA+PxBgguoScfBas+C3WLsIu02uAaKQHLWvKk6LrLtf+rngGxImpfr95p292XsHZHlftz9/TOHKzHZnsfYy7Oeo3UnA8pUHn3Z7SIsnZnSC3KklNa82k9pdOsKRF+/a4lngH1S3nhFS0rjUqduy0CmOIEwkBVcqY3wqYDCXVeDdyK7oZFCTYXiVum5XEvULbcxKmVP6QoJ5omOIg/0JWUVpKqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQYS7OHytlV7uPQ1r6iRZj4wnONRB4+N5ECS1fCff8Y=;
 b=l1Ri1U+1YePZMmXSIZzVkNHKAlWqFsJo7Bhn86ssCzXF0nUkSvAEIKbvDsZnRv/YP1jckKHs6dEr8yiJR+r6Oe1qmXKepCKf2QuZsdBmU1oDE5LQu6ewWpRCcCRZ6LGqXjKwQB7lBu3yWDC1IMmR+qNOuj2BQKvwKNiFf9v2MExPgxCgw6xqzQjRRCqhO9reB955rSCqQD9vi8hlHIsJErhvAd6ilOWgVQUSUq2tiomMMq/9zzyoBNODaylM8B5ec7RktrLvb3kh9tzvVu5gctw6MfxQ7x3zkWOjIif0mbL+HuSPgdEtxMPwhiweHAZSqfDqJaEyhzj/CViwGSIuVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQYS7OHytlV7uPQ1r6iRZj4wnONRB4+N5ECS1fCff8Y=;
 b=k08Io8A4Uylde9rTGOOKEHxCmANnxGibxojIgvvJBxlUeFdPDlUHiOWU7L4lUBpUdS2GPUNYyZ8KXpooh0vo9DatEh4ZEYABe+uE6EwjnWs68OuU3NCv8/tZRJ7QDAGMT/zpRrEYTDvw1/t1GSSB6ljWtIEcXUGC4Is6mxrqywE=
Received: from MW5PR10MB5876.namprd10.prod.outlook.com (2603:10b6:303:190::16)
 by PH0PR10MB6959.namprd10.prod.outlook.com (2603:10b6:510:28f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.22; Tue, 25 Jun
 2024 11:05:02 +0000
Received: from MW5PR10MB5876.namprd10.prod.outlook.com
 ([fe80::4e4b:84a9:89a9:c43a]) by MW5PR10MB5876.namprd10.prod.outlook.com
 ([fe80::4e4b:84a9:89a9:c43a%6]) with mapi id 15.20.7698.020; Tue, 25 Jun 2024
 11:05:02 +0000
Message-ID: <a82fea7e-d76c-4ca3-88be-2a9455f63f9e@oracle.com>
Date: Tue, 25 Jun 2024 12:04:55 +0100
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
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <BN9PR11MB5276C4EFEE9E6E2E8A096F748CD52@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAZP264CA0144.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1f8::12) To MW5PR10MB5876.namprd10.prod.outlook.com
 (2603:10b6:303:190::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5876:EE_|PH0PR10MB6959:EE_
X-MS-Office365-Filtering-Correlation-Id: de01a3e9-86fa-48f4-14b6-08dc9506a959
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?aThoV1BvQ2dnekNXakpDT2hGSE1EaDVHWlNEaXZCc3FJcmxXdkd3SW9HWk9Z?=
 =?utf-8?B?RElQR2FVQmx6UnN2RU41R3FtMm9uNWxXcDcwZmVNdUE0R0VLSU51elAyRW5F?=
 =?utf-8?B?TmJhdXNZdWpxUlVGa0FlNHFYaXFxZERuWk5oTGxuM2VsZVVqY0pxWkpvTDg1?=
 =?utf-8?B?V25xNVFDUEl3NjFtWUpFcGdhckVGUUdWU1hjdU5kdDJqMy9hZGV4dmVnTUli?=
 =?utf-8?B?bEF2OTRxZ0JnR21WSHJEWlpzdTNZTDQ3R3lLbkdacTFIQWQ5RHh1bGN0UHJ3?=
 =?utf-8?B?Rk0wc1RSbVUzd2N1UTZ0WVZtTjFmcGF4UU5MaVZTYnlSVUdSRFgwa2ljSHJC?=
 =?utf-8?B?Z2gzZFMrcTFZT2ZpcHJJUE9saE5RTk1OZEpGYVd0ckEvMzhwV3VUbEhYelA3?=
 =?utf-8?B?WElMTUJ1dDBCSHh1MUxpT01sQ1RYaVlSODRBOEl5dS9BRzA0bnlxVXhDNk0z?=
 =?utf-8?B?V012K3Y1QUVzU3RZQlZLVEZFUXFGY3dkSUFHWGhMNzgveHpJaVdiMVIzRlpj?=
 =?utf-8?B?VXZad0J2VEVaUGZja3I3M1M4bURyVmEwMUFsZTFLWE4zYjc4bDBUTWZOUXlW?=
 =?utf-8?B?WS9ndGUwS0hxZERqV01SYmd1UzdTekNPNzArdkdLc2FOZ0ZxaHRpMzRlSktI?=
 =?utf-8?B?bFM4ckx2ajBDcjBvc2FBTXlzSU1QQk45Uk92SXNsYmJ5RVdHejZmdDgwU1NK?=
 =?utf-8?B?UU1tMGhuaUY0dTBBL3VHUC9PVUlKYjk0SnJxaERIUXhqMGxreXJONmdha2Jx?=
 =?utf-8?B?SVFLWENRUllPaWhJa1VMUTJvbnBPejJRZllWUEY0NGhyS1djUkc0ZkZTa2xv?=
 =?utf-8?B?SzQrZnNlZ2RCby9kai9hejNlQ3RHc2lwWkRvRmZMK1RxZmdjKzgrcUtvUUNN?=
 =?utf-8?B?NkRpZjF5MVFVd1VDN0RCZ2o5M1ZSMWxVQmliVWprTnpTZTZ2MmlVSlBzSnVN?=
 =?utf-8?B?Y2JiVk1Dc3Vlc25iamJsc0ZTbFVDd0RzQ0czRi9PcjM1TDJtcTg5MGNQTmdK?=
 =?utf-8?B?SEN0Y2NpMUtQNG5JQ1kweXRyV0R6QnJVZHlkV25XN1BOMW51QkN6OUFVMERz?=
 =?utf-8?B?Q04wQVkvcC9IcTlQK0VZOGFlYkhpbmt0S2Mzb2dybkVOMnRmL0JheEZIY29N?=
 =?utf-8?B?Syt4dm5uQnBwdE1jNUU2TXdNUEMwYUJZc1gxK3J4YWFiWTV0Y1Zvd2V3MDZx?=
 =?utf-8?B?OGE2TlJsRk45ellNaHNPaEs0UjZ6VVBBZjhpSHB3UWlrOGttSXhnNFl5YkZC?=
 =?utf-8?B?MUVHemxoMzBiUDVLeFZ5Q1JSM0VtS0RFQnlCa0RubmR6akZHNlBCT0RGQXcy?=
 =?utf-8?B?QTFxR3V0azlyMkFlSW1NUG1WNytYRllrRGxvMnhTS2Q5WVRoeTlRNVZteWlt?=
 =?utf-8?B?MW5sNFlhMkc4R0VMVjFSejluaExPd1N0Z2lkRXp1dmd6YUlYc0tNaGdpWlV6?=
 =?utf-8?B?aElqY21pSVpUUUoyV3lZOVBLeDR3eVJnbGZKMS93Z0RXRWVwNkZoTnBJZzBL?=
 =?utf-8?B?OWMzdzhFbE02dVc2ZTlrNGRuSFRLZUlhb0JmajJVMXcvT0FKYmUvS3puTmg1?=
 =?utf-8?B?bnNWZ1AxN2FjVFlvaUJQbXhNSzZMemNQT2txQjBQUjJRR2tOcFVSUFR4eXVE?=
 =?utf-8?B?OHdwYWRGUVZ3dm92cXh3ckFka1JyWmVRTS8wRzJPYnlvSXJOajczUzg0Ky9l?=
 =?utf-8?B?NWpjcGNPS29GOS9NVjFMTkJrVEIyVXBjaE1iOWN5ZWJFcEY5SlVBdTlNZzRj?=
 =?utf-8?Q?iy7OIu+bTvmOrBIUxq63Jaxd52+K3hKhohtiXaw?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5876.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TUlUNDl4L3ZzNE9PSXpjQWNtYTV5eDhxRWpOU0xaZnJzZWllNnZIK09mdDkw?=
 =?utf-8?B?U3hHOU1mYWV5THp0UlBieCtFR2RpUHpVZTFwK3NQcnhpTjFmaWVEalRGTHRG?=
 =?utf-8?B?bFVTQjlqNVhLU2ZQSWtYYVRwbm9SMld2R3pPM2RDLzNyQ2JiYjI4OEQ0Tnh6?=
 =?utf-8?B?MkpVeFMxSFZ6ajR4Ym5wSkRlRFJxVmxBQWc1NnJia0JWYXZDRGxQd2V0S0JS?=
 =?utf-8?B?SjljR294Y0pVV0dVSnAyMm15cmdEY1d0bXpLMTBrdlk3em1HdzQ0emRJblFQ?=
 =?utf-8?B?Vyt6dkVRT1NRV1NOdi8rOCtDcTZJWTJYTUJ1c0xRRVhiNFphcWlUaDlDU2Jn?=
 =?utf-8?B?d05UMVdZZVYzUlJOT0RRT3FGWG9ERWl2WVdjODFxekprMUphN2FZKzVJbUV2?=
 =?utf-8?B?bDBtYUsraVFYYlA4TVhJb2hKcCtCNTdGdXBnYmtvM0NOYUZqVVBaSHFKQlZV?=
 =?utf-8?B?eHpseEdlN2ZObWZrSmFZcHpYS2loWjBNaWJ4ZThoZ09qdDROMW1IcjhrZzNF?=
 =?utf-8?B?N29keFowN2ZpUnpZWHJJR1JBQlFqb3pKSC83dDJaTW5tdzlSWHVvZ082ZnZ4?=
 =?utf-8?B?K2FMUm5GUkFGalVIcHJFV3hQRmdWNWMzK2RCc1JLNVBvMzFPNFc5aG9laUpy?=
 =?utf-8?B?bDdNeGo0L1AzSEJFYW03dk9sMVNUM2o1cElqbHVJemd4Q1NVWW5aenJFeHVt?=
 =?utf-8?B?aXo3RXk3aXVHY3E2RHpOR2VhWFd2bjBPVHdWV2t0ektFa1pCN1AzR2gxM3Ar?=
 =?utf-8?B?WE9RWjhtRllPaFhRb0psUHUyY1VrbE5qWGdtTWtxMllUelBPZHhvQlhmdW9Q?=
 =?utf-8?B?bFovbFRzVnV4VWxMdEJnbnBqTldqSnRRY3RoTlJ3OFpIN2QycE1ySjcweXU1?=
 =?utf-8?B?N1pnQkV2SExnUDFWZS8xcTJzaGxVbHhiaE9Ceitaai9NbkZ0Z2MyaUIwc0tF?=
 =?utf-8?B?Y015RExVelVxUCtMcitxT2hqZy9EajA1WnpQRWF3cEx5ckh5RktUSkZKMGlz?=
 =?utf-8?B?NVVuem01TGF3ZUJMTWhqbjQxR0F6aG9XN1lJRm5OSlZuVC82OC9vQndrYkZD?=
 =?utf-8?B?ZkNQa1NCMHN2MzRORDZ3SndVbzNwRy84cUlXUEpwTWdPWVZ4NXExZUJ6R28v?=
 =?utf-8?B?dU52T0k0RzVKWVUvZ3Avd2Y1alJKNUVYZDFubnRWSWdwZmZ1bXFwd1gwVmRp?=
 =?utf-8?B?L05ib1p0Y2ZxRGNRY0RrVGFHVUVyNldMeFVJbGNvNnVpYlFFeTRxcUphd0FW?=
 =?utf-8?B?cHkvVVJlOFpHRytvQzNuQldkMm1IdUpyeWlJZ2MzVnFIOGJFRVFqeUFYRUUr?=
 =?utf-8?B?bmpuekYvNkZSRFV5VHIzdTlSUm9nZkJPN25BRkdoNS9pTXFNQkFveWIrOWxC?=
 =?utf-8?B?OHpWS3VSdVp6MC9CVUhZRzFxTmZOOHp5VUVNa21mcU1XRHBJVkl1bUVWazhG?=
 =?utf-8?B?WitWdEk1eEVHaTFNY0ozTjl2d2svaUNNb0x5RU9rUVFURlh2OVdwM2pkdG9w?=
 =?utf-8?B?SElsZkFIZFZuMHBmeGVnUGpxcFZPV0Yrak9aWEsycDB5d3ZrVXBiRnFhQjc0?=
 =?utf-8?B?cUFCcjVpTC9PajZGclZrNC9vRWxlWUdKNjRlWktnWUwzRmJHcTJsT0VQSVFS?=
 =?utf-8?B?bFhMcUNmd0tzQVpTa25acWE3M2plUTIwbzdDckdmZ3dna0xlYWhTd0ZkbHB6?=
 =?utf-8?B?OUNhUzJvY0M4enhaYy85eXJFZUdqN2wxMnZENC9YQjl3bmhQUWxUN0w5RVFp?=
 =?utf-8?B?REtOSVVodzJWeHVFbUlodGtPelFXZ3BYMWovdml4TWRkYjhFSUlWWmhRL2Zp?=
 =?utf-8?B?WEd2aGIzbTlXeWkyV2pIRHF5TTFqMDFOOG1pZDQybEtsbGgxSnpJVkh5Ullq?=
 =?utf-8?B?dWl3dmZkK05kZ3QyRDVpaTlFZ2Vvd0FoR21VM1RNcWZEQ052MDZZR3dOS0RE?=
 =?utf-8?B?dFBHM0wzeGFPVmhmN2NjSU9sVlJhZUZhL240YlhiOFdJYTAzenFRRjdDTkE5?=
 =?utf-8?B?OUpzbms0S1E1OGxUL0xoVW9sWHhrZXZUNUJJR3dXQ0cyakRKTTgvU0hyVFJp?=
 =?utf-8?B?Z2dWb1E0REVVaGV2NVlVbFRid2FZWVJzZkhsckd3YjYrYzFpUWRPREh3cSt2?=
 =?utf-8?B?VXlLdENRWDRRejhnZTZURG42SWg2eVJxcCtUcVgzZTRjV0tZTmYvclVNVTlo?=
 =?utf-8?B?eHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	XB4mBs7lDipLXS+2qStuAvcgUQzAel+lJQY4gqyOWBH8HxiP/zlS271lqYDWh0VavwA979ZICQLtdb4JZzpVoVF1yPlodJPvaq+aR5dZAX3GddSxB7PUv5FUMJyHkaRod6uRDbeGXkcBEnJkKkVs2eQUMKix9O+NhSGYqYsbR74avCpKqwMjiBnotZrp9XuA3iDY/Y0yQyc9cibQJyBKCOaD5XM/5c327BcRtM7/S24rQ5c0GYpEY/HLXvrokOU9FQDbnHdCA2I5OHrmqFUZLTVbidSstp5Wgb2+LaZfR4Vj8Y/MXrTdTNyvFs9tLKo5t9cDyY+cHfbBRlLAYq5b4izQUS3myFAYb1aRWZicViP5CTRJm8OidPZCEWN0sJGa332AoxGDzwtbdwhXH0JQNm3y8dlcaxXPKMwNnszMEgsBcGnamkyqk1UOuXZXoZkhGDbuqz5Cslxa+Jgh9VX0a96VtoOwQiW2MaYDPq+2hqIygNeuMnkX8Opgcktzpz8q6zsk1CJBjDAAaXvIeNm56FgoZyCBmlK2xbqzV5/nnYLm4OwKdvqIWojqJVjM7W7i0NpzpF/vTeT9giE9xqpZn2dSoaZcZVJNWET1oH6rxUA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de01a3e9-86fa-48f4-14b6-08dc9506a959
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5876.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 11:05:02.5719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wdQ+pKnAWzE8LHY6E/aOi0HnO64pcAE+WmegX0KECVYhLL61gnyxpDhaAcyYZZfA5VJdLnaSY/nvfervxagCUNLUgPREjpRhWxbPSD/uHr8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6959
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_06,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406250081
X-Proofpoint-ORIG-GUID: 6xcVngVRRjBVf6zM_On7h_vL_4ALtNyF
X-Proofpoint-GUID: 6xcVngVRRjBVf6zM_On7h_vL_4ALtNyF

On 25/06/2024 04:33, Tian, Kevin wrote:
>> From: Joao Martins <joao.m.martins@oracle.com>
>> Sent: Saturday, June 22, 2024 2:43 AM
>>
>> +FIXTURE_VARIANT_ADD(iommufd_dirty_tracking, domain_dirty8k)
>> +{
>> +	/* half of an u8 index bitmap */
> 
> the comment implies 16k
> 

Except that in mock tests we are talking about MOCK_PAGE_SIZE which is 2K

That's why it's half the size :)

>> +	.buffer_size = 8UL * 1024UL,
>> +};
>> +
>> +FIXTURE_VARIANT_ADD(iommufd_dirty_tracking, domain_dirty16k)
>> +{
>> +	/* one u8 index bitmap */
> 
> the comment implies 32k
> 
Likewise here.

