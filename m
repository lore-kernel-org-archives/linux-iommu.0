Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B89A189F55
	for <iommu@lists.linux.dev>; Tue, 20 Aug 2024 08:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724141899; cv=fail; b=nLRP7mrI6E5TLq6nnpGox7RFt+FW5o2nBmUK6s9WrFJpuNlDgCYG4qTV567m9NrIYfX3cgNS7VwGe9JZFMTuonoJJFJjIBKgMCIIvOmwR2AqSSL9P0towWsl1T9uy2Gitdpd0q1ljIC2GXL9m3L1w8UKP6nfO0Mva9vqFStjYyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724141899; c=relaxed/simple;
	bh=W/e47ppM4e80945DDep4rymDGLPEbBTv/tduYvlmAoQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uXNPlxIkb5IbLozKSPTYuj/8dYcBCIL9MyEaFOHHGoKeCxrvKpXBIJhX++1iVhLI0mQHxeuNhRERZCxO3d7kK920kMwOWr/jDfhLAfkE6MBNXOA4DIhzfWtRj8zdg8dhV+xWjB+RyPWrHgHvS9h7NA+ihsTw47dLxu2uYdR/Hes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iTgrdrFy; arc=fail smtp.client-ip=40.107.92.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iTgrdrFy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r+Qve94KXLNwDgWMBR7OJutYtnJaZyi1pRAdRc2DR+BV4/PXx9T3001ehjGScEL0MkCjylb6kMTijDF1nFmfWHf0UGye4zfHNf8vLVqioZg3iajaae3ObuzN903ui6ZdfXLkKkHo3/EnwuGI22ZaojZPGB1KQJ2FnrbqVrpayCxJW+XRV6Ul87J1sIvDnGI2OM9Gy70uqv9loU2z/PIDtnxtPLQKRksFHR/GQu/2IGf9NFg+wsNp7mobzTFBnh895xFv1hnR+z20qs6htzbcOM2JIYAi3mMIAbWGXFHCUlehuedJ60BokIe/DtQaHn2HZ9wkhUFFT21Xz0ji4HXaPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vxuKbLeY1fUwadGbTSJBdLVrISKTRqKSH7N//HiC0t0=;
 b=jD0CQ292QJS8DOdoCjH6NCd4FhGdK8rTumAHPOLW+XMmosnzL2QiIDe3CBsbgAIYClBnh34uDzhuZlgLTupncg/+jQajebZsrb08bpNSgPxTyMPU4g1AjrIsUf3TzxnMsdn5svAHCzkclyuo/FfoQ9RsfyjNtly6kowjOrtkJQ5gX8/c2yr2U1qA3XMJoIQxmlvN6a3tZIF1DeGjpTrN5vuq3tMETJbyeP7hI4NFW1l3hCdQHMLuO6Uu9/0+LH0oKfUEFCXhzasoSwrfs+ul8TfNvwedSkRtuX9tf/sn8JVlu0EYJIyamMwrDYK7nwsg1UVLI0OBfCwHYqtwcCqdTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxuKbLeY1fUwadGbTSJBdLVrISKTRqKSH7N//HiC0t0=;
 b=iTgrdrFyX1u8YJ1mJJIBkF83Tv4NB6Xumko4FWqVMgwGSJpgK9H1aKI/WHETFA7AoNB7u6moGLJyX5/tNZqp5voYGZ/xbg34YRrauSZBa2cVJnMfZd7S8YPIibqNYkdYBHsucxL7Q9T7L97ck3Ul9YTBB68ZFmzn29ifH70C1Hs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 MW3PR12MB4489.namprd12.prod.outlook.com (2603:10b6:303:5e::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.21; Tue, 20 Aug 2024 08:18:12 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 08:18:12 +0000
Message-ID: <fc8715e4-fb44-433b-a42a-7804118ebc57@amd.com>
Date: Tue, 20 Aug 2024 13:48:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFCv2] iommu: Add domain type and flag to
 domain_alloc_paging()
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <BN9PR11MB52765C37F5401E9AA7113D748C862@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240813162044.GI1985367@ziepe.ca>
 <BN9PR11MB527654EBEFE7CBDD37B7B4068C872@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240814224045.GC3468552@ziepe.ca>
 <ad009d03-9a38-4b0e-ac90-13bd8ea0b191@amd.com>
 <60778628-2b2c-4671-b1c6-276db3cd42ea@linux.intel.com>
 <20240815134737.GK3468552@ziepe.ca>
 <29a16f7c-6193-4753-b547-74c5bb9363d6@amd.com>
 <20240816183700.GR3468552@ziepe.ca>
 <de10a9ac-be2c-4db2-8870-86aca57fb48e@amd.com>
 <20240819175226.GV3468552@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240819175226.GV3468552@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0128.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::13) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|MW3PR12MB4489:EE_
X-MS-Office365-Filtering-Correlation-Id: ea7df8ad-438d-41d7-3ea5-08dcc0f0a1de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YWk0WERvQURKVlRzWGViekExM202NW9MbGNocHNVeDFRR084NUJEaitHbENQ?=
 =?utf-8?B?djNRZWx4d1JXdWh2NFZya1hVSnBaVUhGOGJUcWlZZ3AyS0YyWjVybVJYYUtO?=
 =?utf-8?B?VlhJVzBpU1drNnkvWVE2bWxWQmZ3b3Q2NnJvREt1UHdCMGxscklFZ2ZQZnEx?=
 =?utf-8?B?TmdUVXp1Y21mcTlzRmNCTXZEaTVZSWVrSXBnQnBKQWN4MDNXRGRzdFZ5VVZI?=
 =?utf-8?B?WTNBdTZuNjkyTXhMR1BFVzVuWlY1Z2NDOVhkZnJyRzRHQUV0Mk9DSGZBbzZM?=
 =?utf-8?B?RXY0ejlxcGhDY1AyU21yekdnYVUrTnBCYkxRcU1vVGZES1c4MkNUcUt6ckdS?=
 =?utf-8?B?YXFMd1hjSWlsb1c5cDRiQ2dRZEhpUG1NWDNHVmRNTHpIaTZaQWFIS25MUnhI?=
 =?utf-8?B?aGRIUk1CMjh6R2p2NkFMT01CZllxWHAzdHRiR0hyUjZ6OFdueFczQmloRlg2?=
 =?utf-8?B?TVBBUG5YUVBRWlRYNnJLbjI2cCtKYlR4VXVERmpKaVhOOUpXZTVxVCswZi9F?=
 =?utf-8?B?eitmN1drc21mdURDQ1Jjcndyc1lvbzFpV05UWmV5T0NMUnZLVUcybVJKSy9X?=
 =?utf-8?B?cW5wTGMzRzhaZmpqUEp2L25razVRVlNnYWxlS0ROdk91VDE4Znl5ZFQ0YXhR?=
 =?utf-8?B?ZUV1THVGalF0d2ZWNTZScHphWERjT0JhZGcyZEt5MEIrSTdSL01RTGZrK1Az?=
 =?utf-8?B?YngrVWpjTWViTGdxVWhBN2NoYVRlMm5jd1NMTFBjeWRGbldTOXlCSWZFYWtF?=
 =?utf-8?B?VEI3ekF3SFYrZTB0Y0FoTC9Da3FmUEVMNTVZT3NrbzV1NFdBYlgzYWZ4amJT?=
 =?utf-8?B?Yk9KK1h6UWJobzZERm9ESTVQSjlBYnBUVGJQSjhjRGp2V0V0VXp5Uk4xVEk1?=
 =?utf-8?B?WlZhN2w3NkYvQzRQZTR3V0pkbnZRWnE1RmErbGEvWUV5MjFsZmtqdjR1NytL?=
 =?utf-8?B?NWVaNlBkUU1CTkpxaGVPa01ZNjhmb1l3MjFqb3J3RjBkUVcyUTBDajA4b3Ew?=
 =?utf-8?B?eGNVaitDT1lJY1lMNGk1S2IwTlFZSkJ5QjRXR0t5S2t1QlFvdGM0UC8yK3py?=
 =?utf-8?B?QThxcUt4aXpCTzRYSHoyUExMSUNWVjVLdlVFdEFZNi9XMUxNVVpnb1FUZXpI?=
 =?utf-8?B?d0c2RXhJMHpTSmVhbVgyVGxFY2xSL3VJaEIyNDY4enFNMUoyRTNGWHBUSXF4?=
 =?utf-8?B?UjgwbUtjOFZSTEJXSXNLdU94MDZXVXk0dGxXYnBNRWFZNmV6S2pEdjA1OUhY?=
 =?utf-8?B?UWgrU3o1SmIxUDRKdmphWUR2SGdDTHdHbXFjNU5qUGtsUll5MHBrSWVESGJZ?=
 =?utf-8?B?bURMa093d3Z6d3ZjYlRISXRYdW9kUU9BWERJWWwxUEE5cDh0RVBpMmlwNmJY?=
 =?utf-8?B?R1c5MTRGUzd1U1ZlUUtJUEdwS2FybWkzS0VjdzRLUnpIeGpEMklPSXRFTG43?=
 =?utf-8?B?WXZ2dExhdWg5SkJsblN3NWJVWGFIMktZcTIxNU0wSVdyd3NUZWRyNXJDMkFQ?=
 =?utf-8?B?QTRmemxLRVp4NytNRSt4V21BOUpLRWlTZlNZTW51K1ZvdmFvbDNFSkRpT1Jk?=
 =?utf-8?B?alVpUFJjNm1ZZk1kYjYwdVVLdVZOcmxBL2Z3NURMSUFHMDV2VGJFSW5PYzZo?=
 =?utf-8?B?aFFFQnB3R21iTkpuRlpOYm9sTG0xSGc4clZiUFNSRmNHcTBYb3Z2TWdNSUJM?=
 =?utf-8?B?QXl5QXc2N3BXbnJnVzRqdkxkelJ4cHRzMFdqQTEzWXhkbWZjK2N1V0IyK2hu?=
 =?utf-8?B?ZC9PL0w2WFRoSzVDV0o1bTZFZUNEdWJCbzJyUmF5SHhrNXVGRUNoQnlJRldU?=
 =?utf-8?B?WmJFSW5jWXZQTDBkV2VDQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTQyZDFsdDluVUxnd1VRczhEcFV5dG1XUGRDMVdjVWptUUFqMXliV3lHWENn?=
 =?utf-8?B?eXRmWWpPckJRSGJXeUFvYVhJUEptMWEzVEFUeTNYQXpPMEFiL1NXZzRmV1l1?=
 =?utf-8?B?UWY2eVZLN2VaT0xJMVcwSkl5M1NNNlFMSEg4YnNhSWZhbXI0Zm8yRnVCN1Q2?=
 =?utf-8?B?TUEzSFcvbFRyZ1dLbzBIcTVDM1pGWjlzcFpuMGpUYmk1NW85RmpxWUV0ZVo2?=
 =?utf-8?B?YzExMWg3K3pQeTJDZWxNTnRGaEN6anZWZHlGWmhVSHFEamNCQURQcTduOXJY?=
 =?utf-8?B?bHA1VHh1MExobEIvY2ZBdXpZL3ZKNmQ4MUZkeGwxbmJZNUVwOWNoQ1J5bTJO?=
 =?utf-8?B?dUlyS2FWVjNVR1dDVTNERXB1enBvYmFHcCs0RE5mN1dPLzdPc3JYd1A3VG1p?=
 =?utf-8?B?bnMvNWVLaVpvd3pDWFdRQnhMUkMvTy9QK3lMUjBTTjhLMHN3bU5YTTV2T0sv?=
 =?utf-8?B?V3N3QnJDM2tVM1Ywb292R3BheHdBZFVuYTJ1NGc0OEh1NHJid3o5cVNVZ2NT?=
 =?utf-8?B?OFpvd3FFaXd0a3RZM01pUjRReTJ5V3NHVStFUlowMHV2YUJJTkN1NHZCcE9k?=
 =?utf-8?B?RlcyRS9CK3BsckF4QlU2NWMyU0RSZUJPOTJXZ2ZoVjhvMDhxb1o1UHNhTEZB?=
 =?utf-8?B?VnoyTmZDckl1MDJRMVQrUzhTVnQ2dEN5clhlYmJiTERWWWxxTysxRkREYWgw?=
 =?utf-8?B?K2NKMU1GbWUyd0V4alZvSEp1K1VRcGlvamdxWGVBUm5kOTZKVjRDMFhYWHk3?=
 =?utf-8?B?VlZYa2pXd1RmWk5mcFdTb0prUWxQWCsxVmtBNkh0Q2JxSkpDZ2ZyVXRWa21K?=
 =?utf-8?B?SUluQzBjS2JqeTZEQXp1b1dNaVRDUzc2TUVLVGhWSFZ4NGJPdENDSzNzdWs5?=
 =?utf-8?B?R0IyOEwxYjA1YzM5MWhRS3B0bkxzdThPd3BWZ21FUjVLK01DRmIxZXVJcDBp?=
 =?utf-8?B?M1FiTWtZT1NnTGwxeW5sRHNsM2kwVm1JUFRVQ0NHL3AvWmgrcFZ6WE1wVS9u?=
 =?utf-8?B?bjZmOEJsUDRGWk5GemxuWS8rTTlESk90cUpiYTRVcEtNWU1Lb0ZyZVNDUFg2?=
 =?utf-8?B?R1pYOWM1ZHcwV0hBWUcwWUdsc1RDaU9TemZWbWxJelAwV1RQUVhtN05CRVlo?=
 =?utf-8?B?WkJ2K2I3ZjkrQ1dxL1dIcmFxclVxL0tMZXF3UkJzTGRvREk1UHlMN3FnNWVC?=
 =?utf-8?B?RnR0UmhIVHpOc0hRVHU0TVQvTmtYQnVDYXltUVJsOE1DQ2E1VnY0RmVHRldu?=
 =?utf-8?B?RU8xTGcyK1ZPcGN4dktNMXhOWTBOV1loQ0l1OFhIeVBvM2VFWTR5SE9sajdP?=
 =?utf-8?B?YkxlRW5KRitCN09aVzJ3eG5BQ09GdkpObGI0VTNwWTFHYjZaMStyK0pxOEJS?=
 =?utf-8?B?TmgrU1FpVllYd0ZySlpYQTExOEY1K0VrMW5UaFh5LzlPWVVFRmxKN1BiR3VR?=
 =?utf-8?B?eTAvUjBEdEFwWG5sclIxSHRjWk8yRkl6ZmM1b1J5VlBheGdWbnoyUURDQnhE?=
 =?utf-8?B?SEFQSy9aWHF5VHpIU3diZXNaYmRKNnlpRytaT08xOFNnblk3NFAvVzhiZWtq?=
 =?utf-8?B?aUZ6U3lqZ2dySzhnclBmczhqOFIzdU84ZWVjemZMcXROQlZFOHgybkxOQjFC?=
 =?utf-8?B?Ti8zVlkzazd2aXlhbmx5em9uMGp3NzZoc1cvby95Rk5neWtCRWMvUDdENkdp?=
 =?utf-8?B?ckc2YlU3TTlUc2xaSm5YSnBNOWZMeENVRG1mR3JrMlIzOUh2eVdwWk5ENUh2?=
 =?utf-8?B?VUZaM2tzSXI0dUExMS9YL2FzRmlxVlVlMHJqYncyRnl2bG5xWTgxRmlIdGlI?=
 =?utf-8?B?R1djckhpSm4xL2JrUzdWY0pGdGh2NzNXNi9CWlBublNCYW85aERvNFhacGc0?=
 =?utf-8?B?dmViQXlJTXFzeG10WDgvamxjQkJXSFNPYjNWSER6WmMzazdpNkdpcnViSzRN?=
 =?utf-8?B?eDVtQjQ3ei8zZE51Zk5DcGRBTW1WekxMUUdYWUpoVzJLZzVuZ2lOcHBBMXBu?=
 =?utf-8?B?R29qZkh2Wm1tTFIxeTBTK2o0Sk5tYlV6akhzb3cwUklFRTM2MnJpSjNucmk1?=
 =?utf-8?B?bjZZTEFaR1Fkckkxd0tnbVZweHBFa2ZCWU42dEFmcGhIcitveVVSakZxQ3p6?=
 =?utf-8?Q?uJ38vnMTUtAPjEX7h8HJKlMeL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea7df8ad-438d-41d7-3ea5-08dcc0f0a1de
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 08:18:12.3573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C1JNTyhwYGNG2HI/4+r3aBhh3XbtqvVf79DaW0uSEtef+BIhOE7iF8kMj23RTGrwgk9XiBnuDe9VLj5VKKysqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4489

Jason,



On 8/19/2024 11:22 PM, Jason Gunthorpe wrote:
> On Mon, Aug 19, 2024 at 01:57:11PM +0530, Vasant Hegde wrote:
>> Jason,
>>
>>
>> On 8/17/2024 12:07 AM, Jason Gunthorpe wrote:
>>> On Fri, Aug 16, 2024 at 01:47:52PM +0530, Vasant Hegde wrote:
>>>> Jason,
>>>>
>>>>
>>>> On 8/15/2024 7:17 PM, Jason Gunthorpe wrote:
>>>>> On Thu, Aug 15, 2024 at 12:59:13PM +0800, Baolu Lu wrote:
>>>>>> I suppose that this also includes converting paging domain to user
>>>>>> domain allocation in VFIO (ideally vhost-vdpa as well), right?
>>>>>
>>>>> Another thought is to add a flag to iommu_paging_domain_alloc()..
>>>>>
>>>>> Maybe like the below. The small duplication with
>>>>> __iommu_domain_alloc() would go away when iommu_domain_alloc() finally
>>>>> goes, then we'd be able to directly call iommu_paging_domain_alloc().
>>>>
>>>> This will work. But we have to define NO_PASID flag and pass it from vfio.
>>>
>>> flags = 0 means NO_PASID
>>>
>>> I didn't show it but the dma api domain's allocation path would have
>>> to specify IOMMU_HWPT_ALLOC_PASID to make it work.
>>
>>
>> That's fine. Then in your patch we have to prioritize domain_alloc_user() over
>> domain_alloc_paging. Change will look something like below (paste the code path
>> that's changing).
>>
>>
>> 2037 struct iommu_domain *iommu_paging_domain_alloc_flags(struct device *dev,
>> 2038                                                      unsigned int flags)
>> 2039 {
>> 2040         const struct iommu_ops *ops = dev_iommu_ops(dev);
>> 2041         struct iommu_domain *domain;
>> 2042
>> 2043         if (!dev_has_iommu(dev))
>> 2044                 return ERR_PTR(-ENODEV);
>> 2045
>> 2046         if (ops->domain_alloc_user)
>> 2047                 domain = ops->domain_alloc_user(dev, flags, NULL, NULL);
> 
> I mean to make it explicit that the DMA API is requesting PASID:

Sure. I think we are in good shape to get the proper patch.
Will post the patch soon.

-Vasant


> 
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1589,8 +1589,18 @@ EXPORT_SYMBOL_GPL(fsl_mc_device_group);
>  static struct iommu_domain *
>  __iommu_group_alloc_default_domain(struct iommu_group *group, int req_type)
>  {
> +       struct device *dev = iommu_group_first_dev(group);
> +
>         if (group->default_domain && group->default_domain->type == req_type)
>                 return group->default_domain;
> +
> +       /*
> +        * When allocating the DMA API domain assume that the driver is going to
> +        * use PASID and make sure the RID's domain is PASID compatible.
> +        */
> +       if (req_type & __IOMMU_DOMAIN_PAGING)
> +               return iommu_paging_domain_alloc_flags(
> +                       dev, dev->iommu->max_pasids ? IOMMUFD_HWPT_PASID : 0);
>         return __iommu_group_domain_alloc(group, req_type);
>  }
> 
> Jason
