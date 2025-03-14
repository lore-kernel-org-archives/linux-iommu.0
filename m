Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248673C6BA
	for <iommu@lists.linux.dev>; Fri, 14 Mar 2025 12:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741954658; cv=fail; b=Gd8nBlJ2Jn1I97emnsGsqzr5/OfgG2cdKjhnCjHX0OmWaPTr0LqzMCCYljn+j4yeFSSr0vg6qmdPjaeDi30EWy64GBPz6fpRRDPhpuBp6FuIxzC53dnjCixPupuTTEcUIjUz7lmixMSewfnAHKp01oF83DQkU22txhZggdVFums=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741954658; c=relaxed/simple;
	bh=PouQkWGyJ7oHISGdY80h07etn3SvKXmMMLHjjJjV3kc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i/+LVJj7tgAI/zBD/UhT8VMrwuKJeQ3PPsmN0gHQ22ptfqc17RZMRmKrjhLRVNfOGIDaarjQsHIt8QL9algY3rIqdx02uwWLt8TemAs8rxmzAuf6tOKWJlB6Wokx+hYURj7YRKFG1ZxHRpJPqCxiF1ErIo7bI3nxhUMfSGcsXMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aRaAYYAo; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aRaAYYAo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741954657; x=1773490657;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PouQkWGyJ7oHISGdY80h07etn3SvKXmMMLHjjJjV3kc=;
  b=aRaAYYAoy40DlGhC7ZC8+flHlf/B7aHtrORjmA+Q/f2s3jBIGZYCBsnE
   dxRtQG5mZqLy3A3mT9Q7c4HZov0oBL43LzeJFpZPlmMA+MMS5L4Oyuv3e
   HH9cvbpVLrGlO5slUbNNs5NFq6KSDnRjcJbOtOvu/iNgawyU6Rcu/OWCr
   0MiO3QB0CqrOF9x+8Sy4AyATXonKJQztqvcmkDDx+s/c8HgQDFvlXeGpu
   aDD9CMcUBrRORj5ukriZ24h4pOELI4LxpITIG4mRNlpxON2FP2zQZ6+0g
   YC5gXIq/qsw60gRbGYCIhdW/arPG7be1yFRipqGw7Td5+1OyYcL6rFYN3
   w==;
X-CSE-ConnectionGUID: iVn4lKQnQhG49z8l1V1dnA==
X-CSE-MsgGUID: 8srE/RtdSYm1lATzjnYQmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="42273766"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="42273766"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 05:17:36 -0700
X-CSE-ConnectionGUID: xuVyJ7UcQXe43Wh4n3bOjQ==
X-CSE-MsgGUID: i3p6SC6FRW+arEdPe6Zw/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="121312343"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 05:17:36 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 14 Mar 2025 05:17:35 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 14 Mar 2025 05:17:35 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 14 Mar 2025 05:17:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c8o6Yxj/s6gkNSkR+XFx34CMWtHdA6Br8gdnqN2D+svhu05nV5y+VfAWTXaQLMk0tLPxxF0x8zoedNzx96LdK4DwqOjd7jOYtHiINidvis9mBv9DwLWtflQJY5vMHlV3DBKIcbqQrxR/yCWN2boAtghrOfl/XVj4lpAXNjU3US8JV7e4A4cQNrXkdkAXxPsc6u3nd1VQSIduJey+omTyOhQsSMp6VY709yyC6NJYQIYJS/BSsIiOEnlrZxE3ool/UKSy65NsCxifnxN7m728TYb5UFWubMCJANDS15As/YneF0IA6GXlwJjxtb7yO5yEZqwrsfRECHgKxY6bDnh9ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BDjVQHrcPKT4nCOuHio64lt/Likxv3O4xqBoEFxDgeo=;
 b=DEu4f6RrLkkHWNpZSZVF/Qc/K5AizUuAKSzuFvBKmFCnTSAlxiaeALT+lbCXK8z0x2LP6lYfWkuX2LhYOlgt884zsmfbFcwK+GIB9Hbn/+u33GFoR++X0mI13vvI6nXBPRa1vnsYYZiRdkV2w2jXNlFXYaqqZ2T0HoZ98Cu27kNaf/G7k2GOA9tu/nutSmLd1xVZU9fVjpxpS49gqB2JhIlWxNfw3WLVd+INhYJXvdyVXwgFPX/upfPTN9ZIuQkYOc+KhqYP/lIUMzdvBxDWJmDlQeGqSDHa0QYvLgtB4XG5E1Jn6t6e95Y4/+OF9tJa/eheUUxOEkSF19Quz8CraQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CH3PR11MB7817.namprd11.prod.outlook.com (2603:10b6:610:123::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Fri, 14 Mar
 2025 12:17:27 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 12:17:27 +0000
Message-ID: <acfee6be-0aa6-4c35-980c-b80ed2790cac@intel.com>
Date: Fri, 14 Mar 2025 20:22:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Add Secure ATS support
To: Vasant Hegde <vasant.hegde@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC: "Tian, Kevin" <kevin.tian@intel.com>, Robin Murphy <robin.murphy@arm.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>
References: <BN9PR11MB527624C1DED16B3C049D13438CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250226011750.GB5011@ziepe.ca>
 <BN9PR11MB5276B3E410FD336A3062FA5E8CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <4fba254e-ca47-4e7b-baf3-0228d9605c2b@amd.com>
 <BN9PR11MB52763A8885AF1678E05E8B528CCC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <942a1a66-5c18-43e2-886e-df38cb3e7258@intel.com>
 <54db17d7-b150-4579-a33d-f1b5cc8943bc@amd.com>
 <6eb0ec90-5859-4605-8a2e-657f6f711d61@intel.com>
 <825ddadd-6770-46b5-936e-f17988534984@amd.com>
 <13e1e1d8-5870-44ea-a800-e5b25bafd344@intel.com>
 <20250303183801.GW5011@ziepe.ca>
 <391a2333-0373-4cd3-a858-349230bc7c90@amd.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <391a2333-0373-4cd3-a858-349230bc7c90@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::12) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CH3PR11MB7817:EE_
X-MS-Office365-Filtering-Correlation-Id: eb6c5a00-ee6a-4cd9-0fe2-08dd62f22f63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N1pLbE8yNFFrQVl4b1djNHpTc0w2SThNTTgrNUg5azNCMTZLMVFtZmlxTjEx?=
 =?utf-8?B?bFdZZkpvNDNXVWY5bjVGb2JpaWlpRzZ0aGR0cGJLU2dYbHJCV0cxMEhRcTRn?=
 =?utf-8?B?Q1BUZ3Z3K3VtWEVpYkw1NE1aWjYrN2pCOWNyMWNURGwrVVZBU1JNaHVWbzVZ?=
 =?utf-8?B?cUErd25TZHlTc2l1aThPU2dFb2txZ0cveHR6Y0YzME1USWxWTmZYUGI4SWow?=
 =?utf-8?B?c3pxSjN5OVh3QjYxTE1pZnlZVzVKU3dLNXQ2WktTdVlqTGpsSjVyMFJySTNn?=
 =?utf-8?B?V0FiTzJNZjdsOUJYZURPZ0RCUTQ5bkNxcS9jN2tIOWNFS1QrTm5MMk5UTWRQ?=
 =?utf-8?B?OUpjZ3ZLeWw0N1lja2RoaXBDeVRwV2krU2ZWWXhHZVI1YnV2NTJnbkhSTElw?=
 =?utf-8?B?OUI0dXFCUzdzL2Z0LzNnM3A3Q2l4Y0ZucHpDeDBLYXV0UHlFWGFON3FlOXor?=
 =?utf-8?B?cWZkbGZTTjBBOTZ1UHJlak41WGtWMVhIMFYxdGU3UERtaEl2Q1VPaE9QYi9j?=
 =?utf-8?B?aHRGV042NnFFUm9WTHplcWh4bFVKTHAvb1V6YVkxMVcrcU56UkNjOGo4ZkZR?=
 =?utf-8?B?MVF2Y3hkR3VOUEZka3FOMjVKc2ZMZ3Q5RE14SENLS0w0WkJ5VWJtZVAyMjU3?=
 =?utf-8?B?RGNKbEJkUDdNdVYySUNKblVycFNaRkRJZ2NOOFY1RmNlTkM0T2RzMkRwK0JJ?=
 =?utf-8?B?eGRQVzhFYVRiYzB1YlM3Y2s5cjJIQnJ2ZTFHd2xkVHJoNmJrK1FaWkhWRkRk?=
 =?utf-8?B?RklqOERJWXVHSFZmZzgxdmw3T2M0bktwWk42Z1hYZkNkK0ZHMnp6MVVPektn?=
 =?utf-8?B?NzM3dUJ3VldtYXlPcG9aRmI5K3BzTE5VeXRmd3lPMzE0cGdvei9QUjVSVktU?=
 =?utf-8?B?NitmMWduL0pMTWRpVWFHL0dBRWU2aStsbzFxZ3JQcmJRdXJxb3ltK040RVVV?=
 =?utf-8?B?TTlHMnR2bithUHJ3SndVUjRtdVBrNjVmakNpMFlidStURTlZQzVTcENodm1u?=
 =?utf-8?B?Ty95SmhueGw3aEM2RUhMcG9BNnY2Sm5weDhQUU5WSDFMMzE0RFhEbnU1S3B2?=
 =?utf-8?B?Vk9GNFRoUkdpR3VVaFVjNUZmeHoxZEMzYW1iTGJHK09IN0lMUHdBc3YyZUF3?=
 =?utf-8?B?VzBiZWxvWmlFUWZ6SFpCcE0zZ3V4R09UOTNSTVI0RTJoM0ZVckFMenJncWtq?=
 =?utf-8?B?ejFFRXdjQXVNV1BUS002M0lseVM3UmhqYjc0U2pOUDFySlBhS3Q1MnAvSDZJ?=
 =?utf-8?B?dVZTSlNaWDM5bytxNzU3UUcxb3hNMHJKS2NtU3piS2htZlNaYnBOZ2FqNkpL?=
 =?utf-8?B?cFpwSTZidXp5bkxycHZaSTl6Yzg1ZC8zOW9CWElhbVBWRFBsK3N2U2lxV0Fr?=
 =?utf-8?B?WlNwVUQydmQ3VGVLaTc0WmhNNGp2U0RobllCckdvVVduc0pkR09nZUtpOGI5?=
 =?utf-8?B?ZU1mY2MzL2YzSWg2UjI0d3lGVTVLZ3FkbE1lU0pTS1N0QnNPTkhxQmRMc1Q1?=
 =?utf-8?B?Z0FRSjBnMHAwZURMU0pkc1JWZlZwQ0Zldmp2Njk2RTcvYmZRQTF1Y2ZxL3NN?=
 =?utf-8?B?TVN1UlJrWUl5WFV4T3YvamxOaVMwMy9qcUdPbzk0SHhqUXltcEJzUC80RnpY?=
 =?utf-8?B?L2NQcHRQN01oYmFuQkNKekl6dWI1ckFXTWZUdG00WUlMaEpTcHFMY1UrNDVP?=
 =?utf-8?B?bG5Fajk5T3preTRVd2cydnB5WEZZdy9JemxkZ01Pb1dnQ1hJVU5NRmkxRlBU?=
 =?utf-8?B?a2hEOWpYczRtVWxCYWg2T2FuRUsyNlZzOGhQOGtsekZrcnRNUmFraDhmT2JS?=
 =?utf-8?B?Nnl3ZFRJcG52Z2g4M2pLbnI5MWdBWFI1NldqRnpna0hUandHK0tVdjkwcHBS?=
 =?utf-8?Q?SxbOMbAHYBEBR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1A4TTBJb29qeWNxU21jQnBGdGlFcjdKRVJTUTZYMldhWk1oZC9DMFBCRzM2?=
 =?utf-8?B?T1R2ZTZ3SEEzbGlwNm4wVHBRTUx2WU9QWkVOblRlaDlEV3hRblEyL2dJdC92?=
 =?utf-8?B?RDVMQitJZDc5Mjd6RWxqMmhsOFkrSmJpM0pDTStrOEFnY28wSUt3dGZNRTdH?=
 =?utf-8?B?dkVJWmpEb2lOb3N5ck9qSG92MHZuOG1xUm9iTENSKy8vSTR6VTNKT3NZODZO?=
 =?utf-8?B?Z0U1ZUJyRFg5R0wvQlJvZzlRZkFrL3YwUTRkMlZwVG1iMDVzT1Y2L3JSenBh?=
 =?utf-8?B?ZjI3TVIwS21uSHA5QXd0YVY5bVk2L1QrUFhaSWtIb1Bzc3Nub0M2U3hGb1Fh?=
 =?utf-8?B?QmFVYmlzSWhHdTl4aXZPT1lLMU4vekpHZHBsUTVlNEUrY0JVMFcxSU1ZMXl4?=
 =?utf-8?B?bWN0RW8vTG9nQmVTUkkzanhnaTdTOEhqQ1h5NTVCUW1Mcnd6QUxYRFFmd2t2?=
 =?utf-8?B?cFpZMG9xOWRyK25lZy9VUjJqdDc2VENRbHRsZGNVNXU5NlkyUTYzZ3ZUc0xE?=
 =?utf-8?B?QlcwcFlQRWJRZml0MjU2ZTIrRzdUTTVmbUNLUlM1NGJDUythUmM5c0FyaW1G?=
 =?utf-8?B?T3NiVG1MbXArV2RtbWUrQ1ZoUjBIdTRBbFhkaHZFeGk4cHVSN0NmRGJMZ0xK?=
 =?utf-8?B?RGVQcVBxTmdVbFlTcWF6aTZGdW5XRHIxNFhuKzVMcTdFTjhUTUJ1MUpyNzVU?=
 =?utf-8?B?eU1KL3BzWEc4cWpxWjVpZm11RG9WMTVRY3hhQVJiOUl1TXFWUTdPeWJMUFI5?=
 =?utf-8?B?UlAvK0xmc2l4Z3RpckEvQWlOL1VFS0hudUJ6NzUrSlpMYk1RRFBqMlhhSklO?=
 =?utf-8?B?QWRSM3FLMHR6dGMvZG1naThJTUo4VXlSZHloM1NNdGJZMjhFTURabHFKN0RH?=
 =?utf-8?B?c1BwRld2VTVnNUZjaVFWQ1FtTnpxZWJqNkdDNlR2MDMwbkpERXBrWEQyVXNq?=
 =?utf-8?B?d3diZUFteHMrRG0vVzJjOGg4NFo2alg5d2hmY3JlcytEdVRmSWRZSmZBZmJQ?=
 =?utf-8?B?R0tYMXNmNWlYZDFHcm95dU0xUTc0N2VXRUxvc3dGTC81ejlCblAwbGtRczJU?=
 =?utf-8?B?cy9GSTJsR1A4Y21vZlA5SWdBT0FTVGVrMkE2ZXU5QkVPdVl2VEJMSThtS2sv?=
 =?utf-8?B?OXY4S3dmNERvYTBYTTQraHN4YnZWUW94ZHJIVkd1VmhJcGdhRWgxSE1qS2V0?=
 =?utf-8?B?SjlLQ0N4WGNhV3Vnc2ZNU2NNQkh6bm9Tb1BRTVFnZkNTSW5oaTJ4Y001UklR?=
 =?utf-8?B?WGs4bkxvdFNIK2Qxbkh1VHZNR1lXMFJ6b1k4TmY2WWFpLy9jZjQrclV4dWlL?=
 =?utf-8?B?aFVHcE1USk5BM0NJTisvVjBzNmhDUzhOSzdjckFGcVk3SE85K1B1bjR4RUZQ?=
 =?utf-8?B?UTZiV1J1U3FuUUw4bGZhTjA3OHpVS1QyamQ5WnVPT2RLSXRyang2aTBOUTNS?=
 =?utf-8?B?QjJzWkNqKzR5VzdWakMvVmJCakE2K2Jka0FkU3Rlai9Lb0cvUUVBTFZSOEhM?=
 =?utf-8?B?YVM3L2pFbGd4eGhlZDhlVWtsMjhqTmVtM2M5RE9aQXdmbCttakxOdEdYSEZD?=
 =?utf-8?B?YzhMVGIzWW11UzV6UFBlYW9uRyszSjQ2TFpYMm9ETzZrT1JkOUFFeWRQekZp?=
 =?utf-8?B?aElSWnV4bmRQNHNXWU8xcFRKcXRGZGg4ZktldkQ2WG9qWnlZMXFCWEVLdHEv?=
 =?utf-8?B?anlUblZsb1ExVnJ6cGl4R0swS3RPeVA5dXhRYnB1a0VIbjlPZ0ZsdkczaWxk?=
 =?utf-8?B?ZXYxNlJEb0s0LzdVdEtONjkrY09lYlZETlp5K0VOYk4xeGJRbWEyRlFnaUEv?=
 =?utf-8?B?Y0tHTW5hWHJnQW83d0NaWURDN09sUTZBc2VzRkJMMVFiUVYrWmpwTEFwOTI5?=
 =?utf-8?B?VVc0VDdWNVhreXFBWDRRSWFySWM0SGxYblJMQkdGUWxmeXYxeXBZWXUyd0M4?=
 =?utf-8?B?bFR5RUhyNmZLNzNyUUFxem1CYTNxVzF6Mml2KzBjeHpSVjdTbUh2bm95Mitt?=
 =?utf-8?B?UFF3YUF5NEljOWNpMkJXeEhxdzJzTEpML0xaSEZ6NUVBWnFYVWFLb1BNbE5u?=
 =?utf-8?B?cmlvQUZkVEJzeDFOYVdjV3VoTEVyUk9RZUMydTMwNXM2aXREbzE5K0FJSm13?=
 =?utf-8?Q?4Y/hNSOwn+zTBww1paA7zB0Ue?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eb6c5a00-ee6a-4cd9-0fe2-08dd62f22f63
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 12:17:27.6181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WZTmhnkH48j3WgyJOjI7l3gqeTRT8vo6dYtkG8aoBOh4HsRVQWMUuIDYdl9r4BGfG2D3L6Kvb+oAiH/qib4s/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7817
X-OriginatorOrg: intel.com

On 2025/3/4 18:15, Vasant Hegde wrote:
> Jason,
> 
> 
> On 3/4/2025 12:08 AM, Jason Gunthorpe wrote:
>> On Sun, Mar 02, 2025 at 04:10:46PM +0800, Yi Liu wrote:
>>> I'm also thinking about the impact of such a knob. How should we define
>>> this knob. Should we allow it to disable/enable ATS? Especially in runtime.
>>> e.g. if the device is identified to be ATS untrusted by the admin, while
>>> the hw does not support SATS, it seems reasonable to disable ATS for
>>> such device. This might change the driver behavior on ATS enabling. Intel
>>> iommu driver enables ATS as long as it's available in the probe_device()
>>> op. What about AMD and ARM?
>>
>> ARM enables ATS when a PAGING translation is set on the RID or any
>> PASID is used. Otherwise it is off, eg for RID = IDENTITY
>>
>> This seems like a reasonable thing to do to me..
>>
>>> On the other hand, we may just define the knob as sats required or not.
>>> This is just a knob to let kernel know if the iommu driver needs to enable
>>> sats or not. While leave the ATS enabling policy unchanged. This means
>>> we need to probe the sats capability of iommu hw before creating the knob
>>> in sysfs.
>>
>> If we add some ATS control knob then maybe it should be able to
>> disable/enable normal ATS as well?
> 
> Yes. If we are dong knob then we should support normal ATS as well.
> 
>>
>>   never
>>   always
>>   paging-only
>>   secure-always
>>   secure-paging-only
> 
> Why not just expose supported modes (No ATS, ATS, Secure ATS) per group and
> allow admin to select within supported modes?  We may have to add more logic in
> sysfs store/show code path. But user will know what is supported and what they
> can pick.
> 
> Also sysfs knob needs new domain ops to communicate changes to indivisual
> driver. Like in store path
>    - validate the input
>    - make sure driver is unbond so that its safe to modify the
>    - New ops to communicate to indivisual driver
> 	 something like ops->set_ats_mode(dev, mode)

Perhaps marking it in the core level is enough. Any domain that is going to
be used for this device should respect it. e.g. if admin change it to be
requiring SATS, then the default_domain should be reallocated with a flag
to indicate it.

-- 
Regards,
Yi Liu
