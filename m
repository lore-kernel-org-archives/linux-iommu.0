Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C89B14A60C;
	Mon, 13 Jan 2025 12:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736769653; cv=fail; b=oNGV+FTIpE967gRTI/wFnnUgkPE6IB3NMnO1cvA7p1nEyppX888988ZDSq5RNDPID7LwrXJSrA4VYyp5kgPjGMPu9vTSeAai8QHzzWr1gHlhOs5/nII9ngtrXwLr6Vs9WnAdAVyvo7SIin1F+FUAmtow/ojreWzELNgsHkCcQ5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736769653; c=relaxed/simple;
	bh=7TA2BVI2jYGlkI4uXO6ECIM/sB9lAt2IvHnNnOHI7FE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cCZTyUxb/a+GIO0E7LNfclcezAUMUx6wefQm1E+taEVygpY4yc6Pvfnpc28GHsMLRbDUFCMIrqz0TRmTVGj9SpqLX60Y7B8cfMQh8/gRGcle3ooxacq5ub3Jh9IBk5aK4/++y6TAf0mF/n1E8NiyS4HG1IxJ4TWmQRxXpl9ePjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RgtQNSZY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=n1lZ3bGc; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RgtQNSZY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="n1lZ3bGc"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DBBgpH014428;
	Mon, 13 Jan 2025 12:00:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=HiQQz6+GkEYbxxRVZET18WP+8vYlTXaqd5HLOSOseBQ=; b=
	RgtQNSZY92XlIusx9MR/bRr2CE1Paq9wC317RIl+X+9lh2AkJTamGtyDubd88yoR
	Fvx+R49fGh8spx2pEQWA+xnJ21Sbw5sYhLiNQ/3K4G0S8ybfdBxLM9DRS9Hu65cT
	4Mrn7LpS4dr2SGS0+UvaD6h/yQ64c3ljD5lQJ9P29wpvjtdh9vHS+UQgPK95lO9s
	ioYJccmxhnhIyVzni9x+Op5pSLdZTmS9d1+KCxT6yPYT4/yMKFW25LekOfppFD5y
	YsS1TbK3CxZdAZsaFdPJJzwYCYn1IKgf2QWESXx/sg3dyT7DkuGQLIkmg0BSFczM
	h3wdKeugNFYoOYQSVGw0Gg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443gpckgj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jan 2025 12:00:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50DBYqsD020411;
	Mon, 13 Jan 2025 12:00:40 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2048.outbound.protection.outlook.com [104.47.70.48])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 443f3d5mvq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jan 2025 12:00:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QM6xN8lV9Mx7h+ZX8doiF0/yty/mFtlJcmnVCgRppmzNaNHWyslaXllCzGxnA9Qi/V9T2DjlWtHI5MWgRpPnZo8EkhV7t8x20gkrR62DL9hUky5XP6uNGTnIic2HVolXCUvNb7Nbm9Up7icn9WhvJjBHN5MpG+JcYQtJuFI2xFviSIkk1EVerbz7HjqT2lt3urQ1tmHDqmz3ItHoYukyxhCKIcsPB99zH8IKLvFZI/qXmaMmYpVTKUecqcIOGmVRMmFfBhZOuV4o4XhVRCANH521+j5IkcmHF2adkSi8sp3yiBxqMMNvzE4+gVYxw1X10xQOUAKp3LHacOgWQOxjBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HiQQz6+GkEYbxxRVZET18WP+8vYlTXaqd5HLOSOseBQ=;
 b=mhYnp0Wkj75PHdVxJh8AWUyS1NxL3AKiJAzc4wTGnp5iaSpfIjQj4GwefFAFsD++0YEgC4TD2YuQJK+NHldPej3kR73yvlwM9nFFITwp2Lx5lCz1fCn9iM0ZcyB7+GN9NNu5MtrR2FrvAPPaI1SVPj+Fq8hnN3OtXAmd8o/69XVEiHhGF1xXZkJoWxUz2R3uiBS5ne5cjHmEWOTrPkYqsEGK110pEIVwbuMCa1cbWJFhbqactbSFmYKS5wpnAjaAlAwCXxHzF9adv5fsdcGii6aGlTby6D7COgtL5j0VP8ayyJAvLpRirTe6ImO+67GZ0e/B5BXSi8scjgt6fPm+9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HiQQz6+GkEYbxxRVZET18WP+8vYlTXaqd5HLOSOseBQ=;
 b=n1lZ3bGc+GwqEUzITgRRzJEWOyol8tSKdfyU3mZ4yV9dhmKGDRyiEOl78vhv7Md0nt3OKaTPYBsKBlh2Qv57eCJPk1TCIw0Gof1DziU0lLsGAtmvPQM4E567GyNTZIDDYn03g2AQO6113ZbsvebQQKIMSakg8afLEOd9qpahms8=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by MN2PR10MB4301.namprd10.prod.outlook.com (2603:10b6:208:1d9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 12:00:38 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%5]) with mapi id 15.20.8335.015; Mon, 13 Jan 2025
 12:00:38 +0000
Message-ID: <670871da-eae7-4052-abc0-92f90e869790@oracle.com>
Date: Mon, 13 Jan 2025 12:00:29 +0000
Subject: Re: [PATCH] iommu: Fix shift-out-of-bounds in
 iova_bitmap_offset_to_index()
To: Qasim Ijaz <qasdev00@gmail.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
References: <Z4O4Du0WN95aP5Qs@qasdev.system>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <Z4O4Du0WN95aP5Qs@qasdev.system>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAZP264CA0093.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1fb::10) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|MN2PR10MB4301:EE_
X-MS-Office365-Filtering-Correlation-Id: 926b492e-06d4-4681-c8d2-08dd33c9e4d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZnpiWlZLV1I4ZHRzQ2IxUjRTVko0ZEdLUDQySWNORkEzdVR4a3NQYjkvd1R1?=
 =?utf-8?B?UU5teUJrUnVlamY2Y0dpU0xWMVhDSXFjUU1tM0U0bkg3NnVxMlFZN1VJbC9i?=
 =?utf-8?B?ZkdPaVhqZ0ppaWNJajgyNnlrWTFSUXh5bit0bU41dTJ0cEp1NFVZMW5mK2dU?=
 =?utf-8?B?dE9DNDZsQnlHeEtCdmJTbDhXZkJKREhHVWpVL0h6OGhXU2ppN013Y1dhRENo?=
 =?utf-8?B?MktOVndCeFQwWWM5WU5Jc1VNL3YyeU1jOTBiWXdyRTVQamxVM2d2dVc4aVNa?=
 =?utf-8?B?cVB5S2IvUE1IRURCWHFidlJ4cjVRODFpbTd0bk0wbmZ4SVRsZXdWekRjU2Iz?=
 =?utf-8?B?cWVmQ01OR25TbXhQN1BjdEZOSUtEVERrVTRqY2JDUkljeitHUjZjNFJhWVE0?=
 =?utf-8?B?U3NmZWJPWDVnTmhKeFV0cTdiRDYzOHlQUThlckZGeXFVV3NrY1RwZzBBVE84?=
 =?utf-8?B?dXpubjQ4ZllzUVJER0hSeWI5Unh2RXQvOG1iTjNpUC9HTFhtUUNHZGNGd0ZU?=
 =?utf-8?B?TzdkYkJrVDFVekRUOVMvL1U5M0Z0aHYrL0prcWtseFhEY25CVlo5SzZQdkNo?=
 =?utf-8?B?UWtWV0k1ZzZWd2FFcWE4ZXZIZTI4WkNPazY0NDhWUVJhZCtEbUNmNXluT1RP?=
 =?utf-8?B?YVQrTkR1Qzd4Vm5EZm9XYy8rZHRUY3JEeklYMy93czZFN2NIR1pCOXBMSmZU?=
 =?utf-8?B?ZGpHL2dVTkFFdEYzSlQwQWtZSUJxYS9POHd5V0paejg0M2RHRjN2QW1nTnY1?=
 =?utf-8?B?NlJMTFlJN2Z3KzFkQTFZQUpuY2FseTBBcjJRbkhjd3JtaExSN0JhUVN4K1NT?=
 =?utf-8?B?cjhDbVZOZnloK3p0Kzk4NE9Hb2ZjV200cmYvb1E0Y1dwdmNzdWJ2czEyaUlL?=
 =?utf-8?B?WkR6czE1ZStZK0NNTUJ5WDFsTlllYnA3RVRhYUpVUGdMd1hrWmNYc05vQ0RK?=
 =?utf-8?B?YlQ2OTlxdndOWWVVOEc4R2x3bFJ5QWRyM1R1SGlyUnlYV2UrQ2J2emFMbHZw?=
 =?utf-8?B?T0duN0hEaFM0NThidlhPSzZtVEpsckMzM1Q2VTlGZC9wcW42QjBaUUJMMTVJ?=
 =?utf-8?B?OWlVQjJldHppcTUwc0gxbXFEcWQ2djV5QzBxU0htNk5oY045MlJGbERuODBV?=
 =?utf-8?B?YnVUWW5WN0VWd3ZnU1RNK0Q3K21YaWlrdGRpVlQ1NWphblFaRWsxUG81T1k3?=
 =?utf-8?B?RStOdDVwdVhQL0lHM2l4UEtQbDIvRkkrN1NvT3lHdVk5VUpPQXVIeFpYWEdm?=
 =?utf-8?B?ZlF2bkwwU3N6SEExbkNqYTJ3elpoQ2IrRkFIZDZDWWc3YU43Wkt6MTZYeTRz?=
 =?utf-8?B?QlB0ZHQ2ejRrcmpuVkVSczdLY2xVR0JkWEV1dG5hcDJJUXpQU05yczFxSG1y?=
 =?utf-8?B?ejliNVp4YS84RHBXaWZZRTkvcGVheHVtVC9jZjVaTTFCR2NORkswYkhYYURN?=
 =?utf-8?B?UWNrNEFUYVRKc1dvbUY3bXd2MTdsV01iMHlJdE5LRFJNNzFRL05GcXdBRzNL?=
 =?utf-8?B?ZzJHTDRDczZzUEwvSjIydW9hYW5JQkZYdS9XTDkwYVM0Y2tZZWNpZy8zUDlZ?=
 =?utf-8?B?MjU5ejQ5MURBR0JKTHhYb2hIazVTRk4xNGNwa00rMm53Sll2cDNKaytkelgw?=
 =?utf-8?B?Q0prK0NwSE1CQlY1ZzYzenB3a2p1NnNyTm9qTVdWVXRUREY3aGhXT0xwNUY4?=
 =?utf-8?B?MnlZakZiZi9CcjJtU1J2Szd0WWZha2RYRHl1bzVsU1U1aE54M1MxRDRGVG5y?=
 =?utf-8?B?cmdGdlcvSVpMU1RsdzhHQWpGRXFpdVFqT3kyd2laVExna044bk5BSU5uZDBD?=
 =?utf-8?B?RFViUWhjYkdUVUpDYUFrZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5893.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkQ3emEzTUlGOEdjazV1SUtEeFYyNk9qQnZxUmRyeDNOMHV3OS9pWlpmdTdu?=
 =?utf-8?B?MXh0WXhXZmd0dENDbnpKNUJOWUcwQXhVSHd4aUVXRHViK2pVTEFRMXozd3l2?=
 =?utf-8?B?TitZQ2ljRldJOHlvbXZNVWErcS9xNnFiTnpDRnpYNkxMYW4rbGhEK1dMTFdq?=
 =?utf-8?B?eVZ0TVdIWHlRVEYwY253Q0tYYzNUS0l6cys2eWhWNjFsdlg5Nk5JSm41VUVZ?=
 =?utf-8?B?bXovemRNcWM0allkUDFzMktOS21KTDVPa0V4ZnF4OFpYdVB5SnNXRFFkcXNP?=
 =?utf-8?B?c1M5Si95U3FSQ2hSMEszVzRzd0xCaW92WTM5ZlU4b3pVSlUxMjFITHNROTJ1?=
 =?utf-8?B?ZFRHY3gvMmMzaFlqUm83MEQ2dHhVWUlZdTU3ZUZaZEpFRXhBNGF3VklkaFJE?=
 =?utf-8?B?RHRSK3hML05iazgvODRzYks5YVFFMnhhNTZkSTRCbjlyblpCL2RBT0haNGZQ?=
 =?utf-8?B?NFhNT3V1Z1BsSVpqcllkeWxmSXk3S3hrVDlOdWlXRllkdkVQUU8rR2ZvcGJL?=
 =?utf-8?B?dVgrQWRNejZnOWRhYXpYMmhibERYZmxRUFEzSXJaOU1XQmxiVnFidDVJYzVO?=
 =?utf-8?B?T0VXaGRaRThCRDdqK1d6ZnNjSmd0eFBOT3A4T09RanI1MFd6RklXTHVsbXlF?=
 =?utf-8?B?R3ZscGN0MEZsMmptUDg4QXZUVkw2c0tadHlURVl3aEhYSmNER3VkdG9DN2FV?=
 =?utf-8?B?Y3JibndFeHdocm9idHFpTXlaUURFK1RrY0NXTER5d0xZR0RhVS81REkzTHd5?=
 =?utf-8?B?V3JLMTNnM3p0SFEyR3ZXbmc4UVpCMHB1UUlma1BjK2srQTkrT2VrdmtSTVRz?=
 =?utf-8?B?SW9JZUVKOTdUQWpqeldabnNybDIzdFRXeHpDWmpzZXB6RjBuVkYrdzAvN3Rk?=
 =?utf-8?B?L0tHYWpObEZrdXVJb3V0Z3ZBVS9QRUNSbTN3N1VNL1BwRVdWNWo0VDdXMGwx?=
 =?utf-8?B?b0J2MC83MmlHM04wZndJUVpqSkg4cStxZlFWcUpJOHNoQ08zbU1jc1ZUT3Rk?=
 =?utf-8?B?NU5rbnlyc0JuaXBCY2c3SDFhY0Y3WE9FaTlDUDF0NGRvMjVid0hHdGtmTjF5?=
 =?utf-8?B?SDYweXk1NlJMdWlROFE4YlNEYjE5OVdEY0ZjbjFQWVJlak5iWklLb2dMUlRM?=
 =?utf-8?B?MFRyMTVGSExQdmxINWxjTXh3bG1ybzJ0MGpWSDVibHlqVVFMWDh4aTVkTHNn?=
 =?utf-8?B?RStHMDF6Q2E5U2d2RzZQaTJqTnEyQUc0eWlEQVNRNHJkeVVxSnZlckdCM3Vk?=
 =?utf-8?B?UW5rRW82TGJxSjVleml5NW5aZFViQ2NJSzhycUJMd1gvUnBJTWtFYWdxTjhM?=
 =?utf-8?B?REg2ZmU3TkdNWVd3L1U4NWVXemZJSDFHWXdWODNvYmFtWEpxVkh2NGNTRm1G?=
 =?utf-8?B?SWpFWWpFR09taTYvelVvanh2RDQxYkpTOUgyS2FKRkNXN0FpNFgxb2x1Mm5i?=
 =?utf-8?B?TG1yVlNaMmFuT01DVU04amVwU0lkdTZwNFkrMFA3YzBKOGtrN2xoZGJZOWlJ?=
 =?utf-8?B?MWlGMDFlUnJVcTkyaXhhNXMvc0F4N1ZTYkw0dVJaMGhEZ3l4anhFUENNVDdO?=
 =?utf-8?B?cWR2Q1RjYW9sWGZjSHpDb0cxUTVsZjVabVc2RjY4V3oyLzhZelEzdktQSFlK?=
 =?utf-8?B?TkluUnZCNjhLVU9CODMza2pvNEM3bjA2cDg4NXB1c3dTYVhIaFFhYzZ2RWl5?=
 =?utf-8?B?OGpZdGEzQitCaUVqVUlyZmdYS3dLNndGcElpcWdJOUdlUHd6TDB2d3VMVFd3?=
 =?utf-8?B?QUJIVUxOTndDcXJIckVSS1FqblNMTy9CL05Wb2VxUFpnMmRvMzl5QS83MUlE?=
 =?utf-8?B?TFprQkQ5Y3BHUXpyQWZscFJXcmJlZDF2TjVtRU9pRVZYeEcxZFpaMFgxUlpp?=
 =?utf-8?B?Z0lUU1E3ZmtUSThzZzFiWS84T2RvdUd6cm1hdWVWQmZJMkxvbjVNTGhLbHlo?=
 =?utf-8?B?YkFxZGpPc1FYcUx5dCs4S3hzSnl6c09VaFdDMDNvOVZDcXIxKzE1enZoNWdL?=
 =?utf-8?B?MDg4SUhHajluWjZtbjJ4RjZpSCtHNGloSk42dVQ2Y1ZIRHBCNnpGQjRkcktW?=
 =?utf-8?B?Y0c3U0FvdHJLQ0NheHpuK250UzU1V1dYNzZLeDB4R0xwazMwNEQ3OW1Ha3FT?=
 =?utf-8?B?Vko5alhiWDZSSUdkNVQ3WlpXT1ViL2haVWVqUmJlUlhVVVNnM3dPMmRMZjlp?=
 =?utf-8?B?ZXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	R8tgUEt6NJ87arGx6Yy2XeR4pcCv6Pc9hAxDU9Te++bU2yKjmau5ErkdFeObGDwoUY24AnmHaiBLI8Bw9ihmtXR8VKRyhdFOXlzuQx0D5dk7RyjV1FHuxY5jTHaOBe5VD1UHjNA10bsJ1q1vkzxilLCi8QeuGaCbmbCJFp9E4+2Y+KgdITnvZJ99YsrzIhNFviiKN3dNZZH3p7juKsv5ESUIPfThu9DgQsGgUi1O/zUNYp1hspC/S2apqccIRHV61yIZBxWqQVpmFwmqkbWy5yzWTFtuiQsIhNLPKpG0DrFha3yyunOd+WF5LG/oVtSxJcGH5xvgkgrDck+d1g+QRMDpDqC0UMwbbEo7dcvcvihg0rB1i8v/72e0++i0KcBaVlkd6EXb29ZPI8g24Gv/q8OAXXK68sDTvtaxaXylgWrYE8ymbSJ3iNp3C+NHpJFdctU/nYkIPEynS985+JmJcyLPoI1gK1hNmiG5Lc6ehsBym+1BT13aV/oB/7Bm+ms8QtUripb8OAqKOK9Tm8I2+5LUwBoCuZTgXxzrenZZlIl0lW1Qk3tNTFWCAsJKmGaDPE6ClrdwdCpaaF/RKMXSH1zyWNp8j99UG7mOrXm4mfU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 926b492e-06d4-4681-c8d2-08dd33c9e4d9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 12:00:38.0022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZMEg9wLeoVUuowhr1rU0nrNMAUselkpHfiIQRfYMMjFDiizhpS7nRzKFORHp+MX5MzA5fAeyoCmeJtyos8FDByk9FbB37cuwdm2WNkErqJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4301
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-13_04,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 spamscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501130101
X-Proofpoint-GUID: Yww3JtDEAhE1gtzinFYxr6VaG-CU_zEx
X-Proofpoint-ORIG-GUID: Yww3JtDEAhE1gtzinFYxr6VaG-CU_zEx

On 12/01/2025 12:39, Qasim Ijaz wrote:
> This patch resolves a UBSAN shift-out-of-bounds issue in 

Avoid the 'this patch' e.g. Resolve a UBSAN shift-out-of-bonds (...)

The Subject component part could also be a bit more specific e.g.

iommufd/iova_bitmap: Fix shift-out-of-bounds in iova_bitmap_offset_to_index()

> iova_bitmap_offset_to_index() where shifting the constant "1" (of type int) 
> by bitmap->mapped.pgshift (an unsigned long value) could result in undefined behavior. 
> 
> The constant "1" defaults to a 32-bit "int", and when "pgshift" exceeds 31 (e.g., pgshift = 63)
> the shift operation overflows, as the result cannot be represented in a 32-bit type.
> 
> To resolve this, the constant is updated to "1UL", promoting it to an unsigned long type 
> to match the operand's type.
> 
> Reported-by: syzbot <syzbot+85992ace37d5b7b51635@syzkaller.appspotmail.com>
> Closes: https://syzkaller.appspot.com/bug?extid=85992ace37d5b7b51635
> Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>

With those two nits:

	Reviewed-by: Joao Martins <joao.m.martins@oracle.com>


> ---
>  drivers/iommu/iommufd/iova_bitmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommufd/iova_bitmap.c b/drivers/iommu/iommufd/iova_bitmap.c
> index ab665cf38ef4..39a86a4a1d3a 100644
> --- a/drivers/iommu/iommufd/iova_bitmap.c
> +++ b/drivers/iommu/iommufd/iova_bitmap.c
> @@ -130,7 +130,7 @@ struct iova_bitmap {
>  static unsigned long iova_bitmap_offset_to_index(struct iova_bitmap *bitmap,
>  						 unsigned long iova)
>  {
> -	unsigned long pgsize = 1 << bitmap->mapped.pgshift;
> +	unsigned long pgsize = 1UL << bitmap->mapped.pgshift;
>  
>  	return iova / (BITS_PER_TYPE(*bitmap->bitmap) * pgsize);
>  }

