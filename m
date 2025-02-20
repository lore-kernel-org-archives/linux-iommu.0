Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA145223
	for <iommu@lists.linux.dev>; Thu, 20 Feb 2025 03:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740023138; cv=fail; b=ZetZRLjwRySMRYyvVbmp6djbzTnF9ZR1reMP5D8Ko3Inv9RiL+nvfYnwBjvt71nyqCg7lsqwpMaSizfUAc5m+mA+CEcm+N74ot4+5lIO01jWjzaqsf2vV901liHcn2jBwAuRwEkKXRTfilBV2ZzLKVzEzhY+eyJlmJHdJou0lnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740023138; c=relaxed/simple;
	bh=6lPzc35fxGadqmQhdIj33+ruSHjGzU9fnl2Fx3izm0Q=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HPspGU/e0mVCiFIobO8q8jUxgWp0YaIvmP2UcexJup+GGtg/qZpVWLTYU4WLLKyWJaIEb1xiEmWtDj2pcMA7IHXnqWHruUc+IeiCcNl7ZY9R7RzUUKVECoNJJZ4Ymz0laDDUMgdsntezdaxsrW1RvvEG+RQxXdoGrzl1Hx0q40A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f+b3J7Og; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f+b3J7Og"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740023136; x=1771559136;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6lPzc35fxGadqmQhdIj33+ruSHjGzU9fnl2Fx3izm0Q=;
  b=f+b3J7OgnwaLU4GUMpqiHKFj9yc2VuE35iQMnHdmR+as19EIW8roU/E2
   FqmFFlSr0U4EAYi9FmnPgc49ITlsR/AqWZhUT5jAl/lxgMA4/1T7kXnLM
   Eii8XnPcdAplDAILoXLSwYuxjFcAg8h2KbPQUQ86/Smq6qZOyhlP5/hYL
   gM1quFExdj59MCSVb9IjCZaHW1UaPuV1ZZ8GjIwKg0Vv7ka+ZuCAqnTTC
   qDhBw12Xkls/tzV5UhnWrvPjf8ONrwe6tqtt6uldim4oqrb2sORC+pfjh
   KyQqLR/Yjc/rKHMYOdhu94TGAXQA91CGHiodbwwpgEm4gvY+qArSkoLN1
   A==;
X-CSE-ConnectionGUID: ZhR/48PXSSybkb9oI57m2w==
X-CSE-MsgGUID: ++FN3Tz4RrqMVhu+7GWuog==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="66144189"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="66144189"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 19:45:35 -0800
X-CSE-ConnectionGUID: TzQiXSATRhCajo7mTqwegg==
X-CSE-MsgGUID: Dv0upYAlSJ6esgj+RZzKLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="114898208"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 19:45:35 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 19 Feb 2025 19:45:34 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 19 Feb 2025 19:45:34 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 19:45:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x1POQzxWlgUTwhN4OTjVVP2KRlgBHJCS5y48BAO4jQ5/u0PesvurPODod8KLD9HSiviTUvDtu6AdJFWaJ06C6ZVH/QIQq9ZpxxTHclPxu3gy3tn9+HguFul5uKRZnxsa5yQAdulPSxcPmOuB1fw1BSpp9/ovguDGIn3NgHPkqRvUSrGaPeZwQj4Am9n8XMFLmQjCjJjOeEqA/yPjXibkCCa1AO86kXnEeo5D/zxQ6X6qZeXgU9IalJX07z5AbkRDkYSEDuJ0+KOXh/+WMKORKBaZKJxGWKPLAVcjdaHNCXeTfTkBZ0EOMil2TTjlFZrpchdc8zMhLyYiTog8CxCtVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZPTJm1rKf13zDTTrtpmSnP3Jip/ToRyX3TAsrNTe+8=;
 b=HpWkzkq2fTR/zbnjmlhRchcsm53Xovz558UgWcyhYEXBMNPjz4lx/pZaqvHza7p9dAPisoltinUdchpbyDRMlLpoKTYRFQQ1yNj2CJEWwb7KdqbT8wrHu8btK+7B+vCYEgs3nibBiOtoVkHAHOmFo4T5ZrROj/hP/EhPcTg4ixjJFatQiBp/V3D0CVPwCcqJMeaN8ze73aeeuZJ/p64lHLlDq51GOcvHCTEAI6lrgJrw+L43xVVmVLDVLHt+PMjGAloEUPPInLRX99v7QWNTdb7F3mFffLKrmmcldTnTuSmAq35doX0SBW+TIW/fZpfHosGDGKw4/ucOzcAm781U7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH0PR11MB4917.namprd11.prod.outlook.com (2603:10b6:510:32::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 03:45:27 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.8445.013; Thu, 20 Feb 2025
 03:45:27 +0000
Message-ID: <37e0d8d8-5981-445a-b939-11c27411a74b@intel.com>
Date: Thu, 20 Feb 2025 11:50:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] iommu: Make @handle mandatory in
 iommu_{attach|replace}_group_handle()
To: Nicolin Chen <nicolinc@nvidia.com>
CC: <joro@8bytes.org>, <jgg@nvidia.com>, <kevin.tian@intel.com>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>, <robin.murphy@arm.com>,
	<will@kernel.org>
References: <20250212060540.261436-1-yi.l.liu@intel.com>
 <20250212060540.261436-2-yi.l.liu@intel.com>
 <Z7YLbix1s55dIEWx@Asurada-Nvidia>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <Z7YLbix1s55dIEWx@Asurada-Nvidia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:195::19) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH0PR11MB4917:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eb6fe0b-2f13-4e98-b310-08dd516103c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UDh0WFFTMVppTjVIUzlqQ1JycWdtMlVCMVFodnB6UXlFMUhoT1hxQzhwY3B5?=
 =?utf-8?B?ZzRXSGV3N2R6WTB2UjE4RkZJVHBWd3V3VlFUMXd5MnVnZldRZThzWSttSFRn?=
 =?utf-8?B?MlA1ajV6QjZSdGFiMzhqc0p2N2U5TjhueCtsdmpzbGNhZllvbmxyT2ZXa3BW?=
 =?utf-8?B?MzZuSlJhQlgyQ0tTV2VYTjZMWmRueEhaNGpVWmQ3L0xBTi81L3FyUU4zSXA4?=
 =?utf-8?B?YUNvZkdLVzZTZkcwdHJWa1R3Ykx3YTRrQUYrUWN5MEZDRkNzSmhoVGhpd0xn?=
 =?utf-8?B?aXkydTVOSTZJYmJHR0VmS1ZGOUlwMGF1Z1pQNVdJVFdUT3RvS1lONklRNFV1?=
 =?utf-8?B?WTlVKzJFZEVwYStlaEZBNDl1RXhtc2J6bVJETWJoYWF6ODMwRmU5RmNSdWtp?=
 =?utf-8?B?ZzRkMVhra3R2OXFoNDYzRDI5em94SWdHY2RiS2NrT2JzMGo1UzhpMjBzZFJY?=
 =?utf-8?B?aTlPbEhtQ2FhWURNK0kzQjc1UnV2M3p5WkllUjNjdzRWTUxobjhsSDgzY1Zx?=
 =?utf-8?B?eUg1STBKaDVLNFdUelJNSlBnaVBqNmhQcGFnWHBqa2Fxdm53RC9oTUFUUHYz?=
 =?utf-8?B?Ukx3MnplSzBxRHlHODVEdERSUEs2aGFPajdmdVUyc3ZBV3R5QTRCc3g4eTN1?=
 =?utf-8?B?MjY3d0wxSDA3R3BqakxtT2tmSkFNRGtiMjc1TUg0alg0L28vQzRGRXZLWXpD?=
 =?utf-8?B?WXVCZjIwSFlpSjdNUm9YUGtiR3F3YzZPVHVuZEVuTFBUdVBINlRObS9TRlNZ?=
 =?utf-8?B?YTZ0M0xjenl1Vmt6WlF2Wk1xQlBVaVQ3eTVBQ1prWlZob1Rxc1NaZGN1TDhr?=
 =?utf-8?B?WDgzcHZqVHZTWWpmMWpON3U5RXhLQWZ2K3F1QURTelNHL05DOXFVSnJNMWhN?=
 =?utf-8?B?NU85UGtHYmtrRjFrRjNnekhNdWczMStvYlpQM3V6TlhXaGtEajNyRWtTZnJ6?=
 =?utf-8?B?NWlEWU43YnE2QTdHbmoxL2ROMDA4UVVCK2g5YVNjcG8vWmtiZUdiV0tsQTNu?=
 =?utf-8?B?MDRucVdpK1dVZWRiZEtkSzNWQmFxR1pGTTc3L3lEM0hYNUp5dCt0QTYrTDIy?=
 =?utf-8?B?MW9Fck9OMlNDMldhNUNPb1JjdnFFNU1wWDRZL0Y2dmhRbnpXVmg5ZmRnYU56?=
 =?utf-8?B?ODNpUjVkWk1PS1NHdloxRXMxUVlHV2hNT3ZrcmRlVWE4TXlnQnhXdjhYNVh1?=
 =?utf-8?B?ZVB2QlpURElkTFFoeUJ3aXJOcW1yaVI3dnBaUjBoQmtybm5pSVRyVTNaRk1O?=
 =?utf-8?B?TUlHbGNtMkdLT3EvM2ZUUW92RlNTY2QrdHU0alpiUDIwRFcrYlYxRnFXV0dV?=
 =?utf-8?B?R3RLSXFHa2FTOHBIeVQ5VHM2Mm5yN1pUZjFUUUt1Sm9DRmthKzIvRFpWOG11?=
 =?utf-8?B?S0JhKzdaUWU3dG81OVppY0J5OS9ZdXlaOTBJY0Z5RXkxNjBvUHdUUDNPbXhi?=
 =?utf-8?B?YUR1VURFNm4vdmNxcERpMVRDMW56Tnh5T2dBMUZnMTBud0Q3cmlENjMxNGlt?=
 =?utf-8?B?TGttQUhtYy82UmVXNlZGTHUzN1RzV290MzFXeklOUGxOM0tXUERoSlpoV0RG?=
 =?utf-8?B?THgyWmp2Y1Rtay9sSlhHVVpaVlZBNWtNNWtBeTJTUHEyU1N6OHJUSFhKZzNk?=
 =?utf-8?B?ZTFEMWdvdnc2ZFNJdFBvVFlpdm9NbjVSOXVRYi8xOGcxSFp2dXZOckZTeTV2?=
 =?utf-8?B?WS9LSUVuekJRcTdiWklmL3R1elI1UElqckFxZXl1Q2k2SjhSa2dWSDl5N1N4?=
 =?utf-8?B?K3J1OXRYNzR6T0x3NkpSRFdUdFNoeWhrRUR5N3pPc2NjYjBDSmpJMWZyRmVw?=
 =?utf-8?B?b0NXb0tOVVJ6REw5UUVBbnlORCtlbUJqU0lIRDdVelBsMXozZE80NHBUdmZY?=
 =?utf-8?Q?64GMUPh/miiRN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDVvNHV1UHZNd0hEVm54TklVMkh0clZncTAvRHJzM1h2MGdTaHJxL0N3eTJH?=
 =?utf-8?B?VWtYcFVQYk5PR2ZubGZuUVU4cUloaTdWYkE2T0pralpweXdwZlQzQnNka1dV?=
 =?utf-8?B?K0YwYU5SY2JYMVVCN1FvNkkxSnBCWGNqOVE0MWRnZkJhZGpNK3Z0enkrNXNu?=
 =?utf-8?B?amZwaWVlcUovZ3U4Rm5zRkVOckZtdHhZV0VYV0R4Q2RoSi9MV0VLckt2dTVj?=
 =?utf-8?B?UnlBTVpMVE4vcDk5RnVCQUd2dUxwM1hYOGFhNHBqNTE5Wmpma0ZiZlArRDc5?=
 =?utf-8?B?bTc3ZWJPMTB4aUlSVFFCcS9Lc2FmUS9PRUxJK0NvRFlWclZtK210TFlaMHd5?=
 =?utf-8?B?cnFqUVdiQVhlOGRGWGI2cW41RnU0S2hRd1N0d0JoNGxQVkdNUmJRMHNDaWdI?=
 =?utf-8?B?d1VJY0N6L0dQK0NOTU8rOVFlWUp3YzdUVnNZMkJNUW82dE5JV3hmdTg4ZjNX?=
 =?utf-8?B?Um1TMmlRazFjQzBEVWpWL1hCRzZ3VGFzblFLdTJqcStCR0lxR0FpcU5ETUVh?=
 =?utf-8?B?b1FXOGVOd2JtWURoL1FpYUF1L2pSazh6dGRVK0c4a1RycTNVazZjUGJJc0ZB?=
 =?utf-8?B?VnNIai9ld0VnSkphZndvODhIcmtobGhQaGErS3pLUDFaQWUrWkk5UXkvWFo0?=
 =?utf-8?B?dER4TXVTMFVhNkdPVFN2UXdKTitCTFF1UG1LYXBIdnZFVllVallwdkZqTm5l?=
 =?utf-8?B?OGlFRkZPWW84RWgxek1KOUJiQnpDM3lRNlNobURRblEvWTVtblN5emRPenQy?=
 =?utf-8?B?UDV5a212YmhtdG45UzRnOCtjK1UrSUZ3dDJ4VFZDZnJnKy9CUnVPYkFZeGxj?=
 =?utf-8?B?MzE5ZlRnSWlWWXE2d3ZDZlhhR0E3bFJ0WUQxL0VMSUhWZkpCSlNZMDladmR0?=
 =?utf-8?B?QUNXYWFObGx6YUFWbUZzblptV0Zsc2JudHc4d2hVSGIzbzNDRWhITG5uTGpr?=
 =?utf-8?B?QjZOYk9odDdybW5BT01QdkQraHFOTmFLWmM0WkJxbGVMSTVVTnJaVnVDNHRR?=
 =?utf-8?B?TEZjM1RSRlpMUlhSbWNiOUg3NXVzbDR1bWpkU09pYmJNYlRlVFpNSVhhK3ZN?=
 =?utf-8?B?NXhIUnZXU0lhZTlXdUJ5b05mUVh2eFp6MFVjaW00bE1vV05PS1ZXNERjY2FB?=
 =?utf-8?B?akVJK080QzBHK1RHbnU3TUVTUVBhWXdnZnlkYmdmVFdTNGlQRU9BU3hJVE1j?=
 =?utf-8?B?dkZXK2ZQTzlzV3FQQlBLdThuekovYjlFMkt3SzZscGVPdVMwNTZvRTZrNDhi?=
 =?utf-8?B?TjhPbFZZaitTMUNsbHhOZGllZUdxYjlEcXFNN2QrdE5Ga0tMWmRqVzFCY2g3?=
 =?utf-8?B?UWhxQU5TR1NDQUZZVFcyUjFVUmdvVXF4cnNsb0FnN0dpckNNNmE0MG14cGd5?=
 =?utf-8?B?UGxaSFdqamxIM1JjdzlMV2J6MXN0OUxQbW5VNjU1UW4yRWtsM1dqMVZ1bDBP?=
 =?utf-8?B?bGRDWGdhTkMzUGZrZ1RpbTIyd1hCSDJXWWZ5RHFTZ0ttVU9kOW1lUUp1MlBF?=
 =?utf-8?B?UmdwcG1BdzJGeHhtdHYwNHJiSE9YQkdaN3Blc1NOMytGNytHelFiS0dtWUsw?=
 =?utf-8?B?VG5oTWZiUWIvZzVLWDdXZ3dvM1JWc1NFdFhPcGlaM0VEeWdldkpFZlprbk92?=
 =?utf-8?B?WEIrdzc5M29JOVdGZ1VGeVhmLzR6dFhIaEhoVGUvZXJFZVhvNlBEM0RyR3V1?=
 =?utf-8?B?T0pFdHlBU0xYUEZUTzdEQ2lkRWVna1pxZXBPUFh1SE9SdkhnRTBpcDBmNlZQ?=
 =?utf-8?B?SVphRUhFcE9KWFQ0VGtsQU51c3U3cTZtcTBjWkNiK29VRm9iUTdRUUZrdVl6?=
 =?utf-8?B?QVZGaktXVER0LzR5LzB6K2pHSFNIMDBEWEUvQzlZT01TcFAvQ2ZmMjNPeGxz?=
 =?utf-8?B?VXZrbk5vVTNuSHVnKzJkUlFHVTlWWDNBbTFFZDdpVnBuS0ZDSjRMLzZKandi?=
 =?utf-8?B?bkc3Q212SGxiTU9OakRmTHc2Z29HSGx6a2xkRUdreUF1TjI3MDEvd2tEMVJV?=
 =?utf-8?B?SzlRdUxPUTdvSmpaSmtWanF3OVd4ZlhSSjg2aHBBbXlBdk1NZkJFUk1xL2VG?=
 =?utf-8?B?ZlU3ZUhHMnZhalE1RjFucmNjZTY2UFJWNlR6aU9Cd2kxR2Q5R0NuODd1NnZN?=
 =?utf-8?Q?SC9qSuDXqPBCyK7oGCYaTKfYC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eb6fe0b-2f13-4e98-b310-08dd516103c2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 03:45:27.6616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sAH09IsDVFH09Wfyt/cI6o2puK0RXsBl42MLA4B3RwoEekqBvzIq/aJX9joSXVGktesdPXHC1vcRr4oOizsPbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4917
X-OriginatorOrg: intel.com

On 2025/2/20 00:48, Nicolin Chen wrote:
> On Tue, Feb 11, 2025 at 10:05:36PM -0800, Yi Liu wrote:
>> Caller of the two APIs always provide a valid handle, make @handle as
>> mandatory parameter.
>>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> 
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> 
> A side note here:
> 
>> @@ -3511,8 +3511,10 @@ int iommu_attach_group_handle(struct iommu_domain *domain,
>>   {
>>   	int ret;
>>   
>> -	if (handle)
>> -		handle->domain = domain;
>> +	if (!handle)
>> +		return -EINVAL;
>> +
>> +	handle->domain = domain;
>>   
>>   	mutex_lock(&group->mutex);
>>   	ret = xa_insert(&group->pasid_array, IOMMU_NO_PASID, handle, GFP_KERNEL);
>> @@ -3568,16 +3570,15 @@ int iommu_replace_group_handle(struct iommu_group *group,
>>   	void *curr;
>>   	int ret;
>>   
>> -	if (!new_domain)
>> +	if (!new_domain || !handle)
>>   		return -EINVAL;
>>   
>> +	handle->domain = new_domain;
>> +
>>   	mutex_lock(&group->mutex);
> 
> So, we don't have the mutex fencing the handle->domain, since an
> attach handle is always a newly allocated one in the caller, and
> there won't be any potential race occurring to it.
> 
> Yet, this feels like an implication, which we should have stated
> explicitly in the kdocs of these two functions?
> 
hmmm. I can just move it under mutex. :)

-- 
Regards,
Yi Liu
