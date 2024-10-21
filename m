Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9091D1508
	for <iommu@lists.linux.dev>; Mon, 21 Oct 2024 07:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729495493; cv=fail; b=NblC/6PTHFmV2wuCqPBTVuGP/hXK7KhNr3qkwfr8FVbEZYlBkHqDZCsO3q+O8GJsGS/3THm3n5PNklDqxLxfGLhEKjM5ZZv6nMZDXWPnbewy7l/NSgIal7AsYoxeYj3Bd/mOGCok1EhDCbTxdP2SArs7+ITyu3nqfwvdfb23Gmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729495493; c=relaxed/simple;
	bh=M1ZCYUjugWe8SkYpcwqfocjSg4G5CbmUqeU6uQUuhro=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eFPk8mnGNERgs7y2VzzoFvOvJGLWy0WXw00WJNHZuU3XTgRIxzVcM/eU++Um0U7bLAIa0PvID9btiKps6wr7axaqK6LYqz9PWiY6KTdUXYl0GYqNmDxTBPFPs9SVSQp/Eqk/8cViCTvQZtNLZNjCSQjMUnLPsrwKmtJ+fQ/Q+jI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UkSNMpLP; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UkSNMpLP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729495492; x=1761031492;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=M1ZCYUjugWe8SkYpcwqfocjSg4G5CbmUqeU6uQUuhro=;
  b=UkSNMpLPg8VceqK3NM+RxYSvDrzHd0oDniPvBTelnT2+OtQ020z8yoH9
   0bvOYRAirLkkGONZVgtxziuZyKZUquKYpm1PFhYsI/CK3p+nZvHmQNxL0
   gwl8jKfraRUdYiJHEdOdW434q+AvZ99/H/RPzuOSP6Ph8f7eteCwJ2Qe1
   pL3Js2g0VHWfCnV647zmYxI97iI5vDJInUCio3pB30jS7t8cURQ/NRi2M
   08Hqzr4CimpPYX9xKqpcohyFnKhWKSgxzK0sF7rKI7Di2HYkrQs5fWBlC
   QHVHs9N9a/voIsqscmpQQ8lnZjr1edCleKxfWrm7yuWOIWjGDlBEnQIDU
   Q==;
X-CSE-ConnectionGUID: tyakw/wHRhamk2SnbLA1+A==
X-CSE-MsgGUID: feYDqIwpS1mC1IOVed3G7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11231"; a="28416905"
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="28416905"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 00:24:51 -0700
X-CSE-ConnectionGUID: yI61nFFaRXaKqEeCLFLitA==
X-CSE-MsgGUID: UJKRLTciTEqYXZWpTzdB6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="84038778"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Oct 2024 00:24:50 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 21 Oct 2024 00:24:50 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 21 Oct 2024 00:24:50 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 21 Oct 2024 00:24:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YdQUrDq3WI4WGBc7u3cTBaLVp8JDYtbTX6jH1zgDzjRYqyiTBbQYxJ0Oz+HhcKewg7kZWiHtaRkyhW6FBkk9CPBICQkXiKf9tgYGuhf1nqtrdbhf3ZIY8AtQqRtgIlYSdzO7KvkZEy7Pcfa/xPOWdn1Omw5JW266DMwYxB3TiMkCHGpXIf6P7Dsgq0WDz6Amqzmda6Kv6uOfIbatYty8JaC9A4kmqcu7So2LA/bH4eUrRJ+0J1O9T8JUO8PixUOtYtoVZtCOfsAE/SnUB1Y3I8HbBKx0BAQcq9NK6FGSqUzFA/HZoWycFYHzpVPIes4mQiI7sJhahtFJ+/oJwEUfrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NdG1m84+igDSfaMxIZg4kqUUa1CJqtFrZNz4NqmBM94=;
 b=XrXCHEEK3zCaPNt4qLmfSkXbdPnmcn34Wac9Kbalwfw5UWdl6SsfAoYCg69hSxbUrcKgiQG1qyBZKCRFxxMFJlPMCu1Z1OdOzP2VtA35eN4bTBYdqBG9JefT4Bv7T88lQ5CePkoUO9fEPRzkXk2HNEM7/ElI2KbREhIfx9yjDu+omALOwtotVJg1xsOwXK4f69P5wbapN2g/QCX7afwZcrU0CRJXxTGbluua8Zz8NasfknGv+7+1Mx/LZsVUVzdBTiNiezL1TA7Y5CF0r1Vvmwg5KcZO200uifhJO5F5QeNVQzJ8L0VUslZp8q69owZJBsTbL6iqNabKtY75BEhpFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by MW3PR11MB4618.namprd11.prod.outlook.com (2603:10b6:303:5f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 07:24:47 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.8069.024; Mon, 21 Oct 2024
 07:24:46 +0000
Message-ID: <ecf96e21-c249-417d-9c55-c6a89f8e6d13@intel.com>
Date: Mon, 21 Oct 2024 15:29:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/12] iommu: Refactor __iommu_domain_alloc()
To: Vasant Hegde <vasant.hegde@amd.com>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, <baolu.lu@linux.intel.com>,
	<kevin.tian@intel.com>, <jacob.pan@linux.microsoft.com>, Jason Gunthorpe
	<jgg@nvidia.com>
References: <20241017140137.6028-1-vasant.hegde@amd.com>
 <20241017140137.6028-2-vasant.hegde@amd.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20241017140137.6028-2-vasant.hegde@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0031.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::11) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|MW3PR11MB4618:EE_
X-MS-Office365-Filtering-Correlation-Id: d2be2202-dcc0-4fb2-de91-08dcf1a170fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WjVCWENZeDJ4L01pWnJIM1JoZkpmWFhmR0NZUXUwNXhkRFFxWWtNZDlXZ3gr?=
 =?utf-8?B?Q1ExVEpJenBORHFWcGdGd1JYRW84a1ZZb3hPN2RDM0V5SUtjMDhrWDB5UkdP?=
 =?utf-8?B?VWF3a0dYblJyd0c4MmxhOG9EakQ5SVoyWDZBMzRGUGg4cHFvNmRySk1LdFMz?=
 =?utf-8?B?YjJJVkNXYWd3aFJiNnV2U0IyUWZlVjJvUUNoVjRBQURPOTFqdVA5K3JHb1kr?=
 =?utf-8?B?dTU4TTBKNXhuOUpMNlI4QkpiaS9hZWJFdnZFZm4wajN1Z09IRmxrU0FjZmhM?=
 =?utf-8?B?T0NLbzZuRkkwYTVMai9GUjVSdVRWQkpyTmpadnJPL1B1QjVrT050MkZQM21D?=
 =?utf-8?B?UmV5Ry91enhsT20rSkF4ekkzaWxMTjhIOXJiYTdldVppdkFxdXhzOTVnS3Yx?=
 =?utf-8?B?RHJyRkljRTM3dlpuSHBsZTJUM1lPcVo0OUl5Y3Q3T3RGUzh3ZFNQZ01ueVpF?=
 =?utf-8?B?clkrYXJjbFJFajVhd0prUEczMUdBbDRZWlN6eHdCcTBXY1lVZmtsY0g5Z0xC?=
 =?utf-8?B?WGVONWpTeDNLMUFzL3ErUTBrZGtXcDNqcXhUUUphZVZZRjg5Y3BTdG9YUEhT?=
 =?utf-8?B?ZUdkVkpDSi8wREtOZ3JsK1pMbTMxMjJsb3BJQ1oyQ0NwZmRVVnpEM1c2dGd4?=
 =?utf-8?B?a3JxQ0RmcVVqaEIvNVlzV0pZS0Y5ZlMwR1Z1VW1lelFVTDV1MGpZWTlKTXpZ?=
 =?utf-8?B?MXBXYndsUjcvaTlLTVRDVjRpTVZhZUpCRkJHemJCRVRmeC81SVdlS05ueXdW?=
 =?utf-8?B?aS9jcnBEMlZ3dzA4L1ZNRHVRRnc0ZEZhaUNpNkNPQXVLMmp2bzJwSFFMWkJW?=
 =?utf-8?B?YlNsaklrWi9XQkwrd29OODBJV2NWQTBqKy9uTnJrekNkQkhXQkx0QXRzajZr?=
 =?utf-8?B?c2tXUXRPT3c3RVhUMTI5Um1YVE9vTngrNlhGcDg3R0ZFby9VTktBckZHaXVE?=
 =?utf-8?B?alJRZjQzSGl1QXpoaUx0bGN1T3Y2bFJUOTZhUGdKVEtsaGpXMUFGa3JlNkpC?=
 =?utf-8?B?SlJXVVZrZy9jVTM3eGZxSVRuZW83dmw1cTQ3akg0ZHRCL3QwdjY4NUVrdWNG?=
 =?utf-8?B?dXJtM1BsaEsrUXlTaEU3TFNuV0d4dDNtZkNua1owSklMUWVDeHlFSnRUcVpV?=
 =?utf-8?B?ZVNsU0hubG0zWkN6cXRsMUhaRUt5L1RLb1hnckZqSFJ0V2MxMFFTb25rVU90?=
 =?utf-8?B?SzI3WCtQOEgza0xyMGhPeU13cHBxTmFhaVBxMGd5Ni83NFhRdHhxM0YrYUJP?=
 =?utf-8?B?ZGNlYkt0RTRLSWtNN3FIeXFNUkFFTnpVVi9TdkxiUWppVGVnb2JwcUdKdkp4?=
 =?utf-8?B?d2RXUUJHVHFkR3ZNYVVCM1FqT2F2MWREK21EejJycHNGQmFCNytMdG02NzYy?=
 =?utf-8?B?MlIwQjNRK1ZOV2NjL0xCZDBaS2VKQmdWWU9BNktxRTI0SGxKTCtSTk9JbWx4?=
 =?utf-8?B?UjJnNFlsSVIvV2tVWXVYQ0lXYlJUYld6ZlpVQWw4ZXRSVzRUYVMyNzAza2Vp?=
 =?utf-8?B?MnhFaVR1eWo4dTZCWEEvL0ZHWU9RSlNNaFYraWRQZkxOZ3hZY2p5aEw0K0xu?=
 =?utf-8?B?aGwyUktqVTlTVVZCc05pWG9GQkx2YXk0NmhsYUhTeEg5MmZVdWdmQ1ppRC8v?=
 =?utf-8?B?eDNHOWdzZitjZG5LRFZrbWNrWTZGN0RocWpSSjBrTGRYc0J0Zk9wU3RVNkJN?=
 =?utf-8?B?UXBPcHV3SUQySHpsQ3BQSmNBaUZzdXRndjc1eTNOcmQvWXovRVB6OU0wbjNB?=
 =?utf-8?Q?b/tMwiA3TO8/DdRpKLMO6wyD3V7aXC4PpIdQBmE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkR5K3NWUExsSWdubGQ1OW1NN2UralFWaW1STE1NQ2Nsdk9NTnJhdVFjVWZW?=
 =?utf-8?B?L2dNN1FpU2g2aDZ2a2VaUmErY3V5STJRNi80a3JtQm91N1hCM1VpaXYxOTFK?=
 =?utf-8?B?TVpNTEtJRG0vOFhPTXFpRDQvT0lrdEczTHJvUVlYbTZwOGd5MGpoeWhGYnUx?=
 =?utf-8?B?d2FMUGZ5ZjlzSFVjZDh6d0UzdXZ3WjFGUHZ5bEpDa3hSR3drcjQ3ZkxSUVhB?=
 =?utf-8?B?N3Zva1U5eXN5elg5QkY4M1BqMWpMRlVQakJ6SjU0am1HdDBMNEVrT2cxMGlV?=
 =?utf-8?B?L3QvMkZrNWdydFhzQmN6bTlpZGZ4ZW95dEJPT1luSXlTUHhrVFczR0JycWs2?=
 =?utf-8?B?Vzg2SFRXVEpmOTNXbUN4ZGpEU0loWTErVVJmWHFxMEw0SExxbEhjODc1OSs4?=
 =?utf-8?B?bmppVWxQSmYzWU9obDVqbXViZlJQUDVhWjlHVmJhLytzdklMTlh5OWo5TCs1?=
 =?utf-8?B?RUgwSlRkQTV6QitNVjFteTVDMFNUemNBcDJlMU82eXZzR0EvbzlFQ25lUkJU?=
 =?utf-8?B?NzhVaS9TVVpxbURBZkJzK3B6NW1SL2dqQTQvVzlML2pMdFZIMkU1RnM0WWtm?=
 =?utf-8?B?bHJ2bnNBVDVvNG5QN052Y2tjeTNXM29MbzRLQkFOQmlrdWdodVl2T09lYzFz?=
 =?utf-8?B?UStMM0tGNm9tcjRLK28vaUUvOUhTdldCRFE3WTFCZjNEN0N2THlvUnYxb3ps?=
 =?utf-8?B?dmNjRWI2Rkh4TnZQSENtMDlVbEc5TWI5RWF1UklvMytZTTJsWkM1K2l3SFFN?=
 =?utf-8?B?YzFUQmsxc3I1bVZOcE0vWnZoUDR4cHdodC9CWlp3dmxCVmJjalRHUzl2T3Ex?=
 =?utf-8?B?dHF1c0Q0NWlRenFscDl1R2hjRysvWk5nY2RkRU9vbERhS0F2Y2RhNHhPQVk2?=
 =?utf-8?B?OUpyWVVSRVVYc1dTMkV6NHJMMkRWR1BnMTRBUkFQNFpNOWJlRFdEaEVqV2o2?=
 =?utf-8?B?OEtBYkdGVS9pdE9yRGVGK3hCQ280UENHN21uU2VMTTdlakpLVG1EOW1rc01j?=
 =?utf-8?B?azlGM3ZXaytySjdsS1F0a3lGQUFSMGEzZndMYjhMMW9OamdyemZkSm9wVmpJ?=
 =?utf-8?B?aG1NMXdBejd6MlpKR1d5UzhxbElzSGRHb3B1a2FpYXdBMVJZU2JiMitmZllx?=
 =?utf-8?B?ZzU5ajNXRDcvOXdtdG1iR1ZYajIrUmdhM093SUFiaXhWVFcvQUJiYlZ3L1Fq?=
 =?utf-8?B?c0RLMERkdW1PZksrZTBYQzlPdDhJa3d6V1R0VEp6M2t2UmFEVEwrSTA0TlFE?=
 =?utf-8?B?RUJ1SEp4S1ZZWTVEZ1k5Ym5ybW1acUhtMlV1SjR6UHRPOHpIamlLOHYzWTY3?=
 =?utf-8?B?MTBESXdWOUZ0WmZ0NEN5eTRDbG1peGJteTNBRkk4cFkxM01PNDhDeTgrVDAy?=
 =?utf-8?B?TkxWR3lZbGxxVWt6ZXpRMVNjbGZjVEJDNkluRXlQYkg0aGFqK0N1eWJLUWV1?=
 =?utf-8?B?b1kvUmZHRFV4M3VPTlkvV1RJUFZsYmVod3JDaWN1UUZWalY1TkY1bkV3OXBF?=
 =?utf-8?B?c3Z3QjZkaFVjMGN2Ym5LUU5NSUdjR3BkcnpscGg2N0w2NVVVU000bHlENm5j?=
 =?utf-8?B?OXVYaTFhaE1KWlFpNjhNekgvMTE0Q0RpS2ptMGZacUJ2a3cvcUN4c2RHelRz?=
 =?utf-8?B?MXhrSEpXRnpyUXRFalhGZUhZbDUwSTdQbDEwM3RmQU1Ub1pZbDZBeEdYMG13?=
 =?utf-8?B?YlFmWmlESCtyYkRIUVpWU1FWZFg0cEIzQ2J5TjJmY0ZVQWY2SzlIY3RrY2Rh?=
 =?utf-8?B?YTZSTEVNeGVlOVVNWTRGVzQ4Umhrc3F1aFlwU1lsRGFJd0hzKzhGRUFiUDVY?=
 =?utf-8?B?UlY3K3FBY21yS0ZqRkdCa0tlL0FXOGkxUXB0b2JqdUdKUm1nY1FCL3lzdzgr?=
 =?utf-8?B?K0VzQzNOZDJQbmNJVU15QzMrdlVMNmFNY29WT2NvdHBXbUxQWkV5bjRQdUJB?=
 =?utf-8?B?ODRGN2FnLys4TjRzeklnVDEwM2hqYWNyN0RBUUJnRTFBQytCNFNIMzliN0ZL?=
 =?utf-8?B?UVlyN3doRUNjNXdJM2Z0VTFwVGxWY3lGa1pteDFBdDQzdTJ2ZUVZVG9JZzl0?=
 =?utf-8?B?VERVcGJmREJ4WkE4eVhjdGh2OWpJVWRjb2Z0SkJKSXFRcGJnaUx1WmwrbklK?=
 =?utf-8?Q?SFklE9MiQhnZKWLynfE3M+VxI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d2be2202-dcc0-4fb2-de91-08dcf1a170fb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 07:24:46.8599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w89VPxUb2WbSB3GZll9mj+yO6xH9kiQs0dWJEUWdAmVUQ5ohrR5DceIR+AMXMvXtZ8ha1dK2eLXpvJvznl9bLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4618
X-OriginatorOrg: intel.com

On 2024/10/17 22:01, Vasant Hegde wrote:
> From: Jason Gunthorpe <jgg@ziepe.ca>
> 
> Following patch will introduce iommu_paging_domain_alloc_flags() API.
> Hence move domain init code to separate function so that it can be
> resued.

A nit: s/resued/reused/

> 
> Also move iommu_get_dma_cookie() setup iommu_setup_default_domain() as
> its required in DMA API mode only.

a nit: s/its/it's/

Otherwise, LGTM.

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> 
> Signed-off-by: Jason Gunthorpe <jgg@ziepe.ca>
> [Split the patch and added description - Vasant]
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> ---
>   drivers/iommu/iommu.c | 46 +++++++++++++++++++++++--------------------
>   1 file changed, 25 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 83c8e617a2c5..811748bec4b0 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1934,6 +1934,22 @@ void iommu_set_fault_handler(struct iommu_domain *domain,
>   }
>   EXPORT_SYMBOL_GPL(iommu_set_fault_handler);
>   
> +static void iommu_domain_init(struct iommu_domain *domain, unsigned int type,
> +			      const struct iommu_ops *ops)
> +{
> +	domain->type = type;
> +	domain->owner = ops;
> +	if (!domain->ops)
> +		domain->ops = ops->default_domain_ops;
> +
> +	/*
> +	 * If not already set, assume all sizes by default; the driver
> +	 * may override this later
> +	 */
> +	if (!domain->pgsize_bitmap)
> +		domain->pgsize_bitmap = ops->pgsize_bitmap;
> +}
> +
>   static struct iommu_domain *__iommu_domain_alloc(const struct iommu_ops *ops,
>   						 struct device *dev,
>   						 unsigned int type)
> @@ -1962,27 +1978,7 @@ static struct iommu_domain *__iommu_domain_alloc(const struct iommu_ops *ops,
>   	if (!domain)
>   		return ERR_PTR(-ENOMEM);
>   
> -	domain->type = type;
> -	domain->owner = ops;
> -	/*
> -	 * If not already set, assume all sizes by default; the driver
> -	 * may override this later
> -	 */
> -	if (!domain->pgsize_bitmap)
> -		domain->pgsize_bitmap = ops->pgsize_bitmap;
> -
> -	if (!domain->ops)
> -		domain->ops = ops->default_domain_ops;
> -
> -	if (iommu_is_dma_domain(domain)) {
> -		int rc;
> -
> -		rc = iommu_get_dma_cookie(domain);
> -		if (rc) {
> -			iommu_domain_free(domain);
> -			return ERR_PTR(rc);
> -		}
> -	}
> +	iommu_domain_init(domain, type, ops);
>   	return domain;
>   }
>   
> @@ -2965,6 +2961,14 @@ static int iommu_setup_default_domain(struct iommu_group *group,
>   	if (group->default_domain == dom)
>   		return 0;
>   
> +	if (iommu_is_dma_domain(dom)) {
> +		ret = iommu_get_dma_cookie(dom);
> +		if (ret) {
> +			iommu_domain_free(dom);
> +			return ret;
> +		}
> +	}
> +
>   	/*
>   	 * IOMMU_RESV_DIRECT and IOMMU_RESV_DIRECT_RELAXABLE regions must be
>   	 * mapped before their device is attached, in order to guarantee

-- 
Regards,
Yi Liu
