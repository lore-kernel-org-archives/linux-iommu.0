Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BE41EBFEA
	for <iommu@lists.linux.dev>; Wed, 30 Oct 2024 14:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730297415; cv=fail; b=aiDQ9fAWHkfNUqw+Lpi0fZSkkBKARQeApG00eFaNbKUDYhdkZI8g8jsgSQ6Lino8yxYi2kmzVtRXJM1Iln9gzj6o91hyJ8S68EdQUOKmjhgbEbpZqTp+oNtSJNZ1awHI/Wlj680hSIdhBXa69UGPUQbY/W0VFRiatHqP+7fqa28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730297415; c=relaxed/simple;
	bh=RHvwOJVRVhW1du2goiO7rItk4nM2BO0K/Xkw8xGqGVI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S/rLeiLnuqDa9ADI0vGp8JDj3JXeN0/Rj7gLr5llboEp/Rc/AhP3un0tkpFdpMS08nmNKR/H+NGwnnNRpT2hb4HzYgR1G9vcaYF8fxIlhVo9V8zlYAyHCdlRiE6J72as4H3Fef72gqnINKpaP6UsRpOROqR3QAihkJ+k9bAmbPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j7kNRzcG; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j7kNRzcG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730297414; x=1761833414;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RHvwOJVRVhW1du2goiO7rItk4nM2BO0K/Xkw8xGqGVI=;
  b=j7kNRzcGE1emNFdmZLtKvJDYk1MhKrArwXVezMPnTBx7mtENkNNpOsO3
   YoyEMzE2OIVIPN81hOkJC2ZaXvgwqN2UT0BRkCi0SPpnbNdtYorCY+nWE
   2Gmie/znITmtIaOzX+Z4M370VuKUBhu4HafJ5ZG3Uogtww0DBVmcSvJUd
   kpXZmsu3wN4Y2d2zCRR8/daFe4yFqzTr8yQl0ziQ5+bBaCdWjzCF4YCPu
   AQS005WNlr4NqU5X9slogEGNG8Hd24MKDlnjAgmZBj4Ik8oTwoApQ1a+d
   /Viw30XW+wmrjKIZbtMUfeiVC7XUKCEK4QGt2A4ZtKzYpIQzPbR0jdXRm
   g==;
X-CSE-ConnectionGUID: URbzA/pCRkOjQ2g5Iv+fmg==
X-CSE-MsgGUID: GJi5wdlmQ8e0A2DmnC3zEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="47461581"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="47461581"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 07:10:10 -0700
X-CSE-ConnectionGUID: /PIF/M42SJGI8VX/A7x13Q==
X-CSE-MsgGUID: 9zO1UVZPR8aX/WvQLS2qNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="82634563"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2024 07:10:10 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 30 Oct 2024 07:10:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 30 Oct 2024 07:10:09 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 30 Oct 2024 07:10:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M7alavOXsFKMs50rbLBEnxJTZk4fBEjdL8B8dMDufXKe+BxaXIwaeGfJOWFFia86jFSq1gQ4CEuUhjsllcR1eF6Q+B2GPIN5yCfrq9KiPkmnMj5p1JdGrAjOrIA83mO1NUBj+okF+itekZLc8KC7/qmom+NNA7ETqtM+rKFGvrdeRrOQl8IJxIkYRteNg+RgNi9ojc8+JeYv3QPuDqTzNomLSJT+zh2W5TCuO4E5cLcVSTuQUUUgD2tJ2V5vvVQCzTjQW4O2j6AudFkaOXnNrou5MXNFTkwhUbNPyR8QYwu9bqeuc9rUxrYxJ6liecC1pz9xej6xFPsnBfNA7KjoMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OhTfh8zRGmGWk6p7JilLbk8lMBoz9/5nFCkZQtssf00=;
 b=sc6pEb4i2Tdt6yyWnttssRyMPnzvGzv6ywsX3pgk/1Si5Mt5MtnfW7kIlBbGyEAHgQjq64X0qZUJmnhbwBh0FbZ4h6G9N9vPlFGkbfhurwsNI5PaQg+sdARa2KNHA6+j4XnYhuHAiMusZdB+SH35H7UzFelqa04wQaKG47yznXPi4kVDZb9BvZtHmTOjCUST8hCJHyA6yk3G07wYQBtrXxb64fYnHgmp2oJcXFEizBwF2TaYFS2rIm4gBGmdFu9+yOaQDX7tmi495jQ9rlDE/iRDx2wfDaOdwBFCjaMQVBrL5fTdlWllWisx5fMhVqiMqTkOY/Yvm9sbIso18ITGpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH8PR11MB7023.namprd11.prod.outlook.com (2603:10b6:510:221::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 14:10:03 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 14:10:02 +0000
Message-ID: <b2bedf29-8757-4769-b4b3-064a8157a63c@intel.com>
Date: Wed, 30 Oct 2024 22:14:39 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/12] iommu: Add new flag to explictly request PASID
 capable domain
To: Vasant Hegde <vasant.hegde@amd.com>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, <baolu.lu@linux.intel.com>,
	<kevin.tian@intel.com>, <jacob.pan@linux.microsoft.com>
References: <20241028093810.5901-1-vasant.hegde@amd.com>
 <20241028093810.5901-4-vasant.hegde@amd.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20241028093810.5901-4-vasant.hegde@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGAP274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::29)
 To DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH8PR11MB7023:EE_
X-MS-Office365-Filtering-Correlation-Id: 98710a18-9825-40df-f509-08dcf8ec8bf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZGN1U1ZHSkhDTVRhZVVkRkJ5YXNGQ1BIaCtpaEFEUmRVcjdlRHJ1UTM0cFZu?=
 =?utf-8?B?R1lwUVBQVFgvNWxOSDNOUDRaTGJmOEhFazA2VVVCVWZaWUJmeWxwazRFMXg3?=
 =?utf-8?B?MHBPWDlLb2Z5SHRJS0dxU0FPS2FxcDhlZlM2YUVhMnEvZHVhRktDMHcwSkpo?=
 =?utf-8?B?ZDVwaGJxU01oSUxZaGlVTENjL09abVkxb3VobThzMFBkUHhVRnRFcCtPaC9S?=
 =?utf-8?B?WUtENjgvaVlxN1BIazlPSTg1MUhhcTdOQ1ptc2lSekM5bjhKMENUN0lhVi85?=
 =?utf-8?B?bXdYdzZwWlA1S1l6RWVvbEowa0syWkRMM0s1WkJzNVMrTmdLNlk1UjBwdDEy?=
 =?utf-8?B?SW5weEl2ZG01YSs4NjZZd0tET3dnSEZEWFFLeEJwTUFpN29YTVJ4NVlhN3R6?=
 =?utf-8?B?NlR6OHRmLytudjlHeE8vQXRrTjhLaGJXbVhscGYvVGRETzhBWVhqVUNEczZr?=
 =?utf-8?B?akxUMWlpNS9hTmxaOFRpVWR1RGU3RDhVRGh1UEpLQjVHYkpJTk94cjMwckZH?=
 =?utf-8?B?TXVPdnZwMk5KOFBWS293aE1ZeEVYSWlWSDZ1NExTcHlTejdSa2QzditKb09O?=
 =?utf-8?B?ay9iY21ocmFUMWVkRlVKb2F4NmNMNE1GM2FMcTh5VUl6SGpWQmpXV1gwMVJL?=
 =?utf-8?B?SVFqZm8rMFFZQXVtNjJ4cVVxY3FLaDdGUU13Rkk2UWhBNWlKRTE5TWVxalNT?=
 =?utf-8?B?MHVNNWhDcUJJdHpCUzg3WXQydGFLQ0p6MFA4dEo1Q1JsTDlzTVRFd21WTGR2?=
 =?utf-8?B?ZUVhWDdVWnJTOGwyZy85dXhwQjRLcTRvcGMybkdHQU5ZaTBEakR3eWhoUEdF?=
 =?utf-8?B?VDExazBRTXlJcVJEbVNrdStJL1dxOUxWMnJ1dGhEUFhPaTJoc3lUNGdXS000?=
 =?utf-8?B?NzAxejJ2MWdGVUNhdmJtbHoydmpiUzFCVzg1R2p4SjNzOVd2Tk5lYVNlaTdh?=
 =?utf-8?B?TGJSd25qMXFVOUlvT2k1TWRjOWlnK09zMW5OMGNQYzgwMzdjMlZPUFo3UW9H?=
 =?utf-8?B?L1FwbWxSY0Z0UEthckFScUQ3RElJNDBrYi83TFJCNWJNYllrNzNJZWlXY2V6?=
 =?utf-8?B?TzdVWmhhV1d0Q2JiOUV5QndFbFRtVENPb2RubXVkejNyRlpqVkxXTll0SzJv?=
 =?utf-8?B?Q3FiSVd2YVA1MFNHWWxSTllIdnBNVjNTU3d0L2lHWFhBeHVER0hNVDduZXlE?=
 =?utf-8?B?VUdWK2VlemlDNXFxNEJoZkQxcGpoRkNhRmdpUkJvb25hOVFiMW5QVTNKMFZJ?=
 =?utf-8?B?R3pRL3JhWFB5TjdCbmNsUDdxcXk4aUx4aHl4bmsrUlR3cmV6b1RjOEdvMEkv?=
 =?utf-8?B?MkZ0STl0K2tkdzZIU0dQTFBxRUFCT3dlTXFOOUlkRlQ2aGE4RHNVOWRSMkFr?=
 =?utf-8?B?cjE2SVNrS2R0STZVMEpkSHFRSE9tY2t4blFFUkhtSkMvbVlTZFpOdGVDanVP?=
 =?utf-8?B?cFhMKzBWQTRpLzQvQU9KWkxYMUw1czlPOVgvZnpRUkszZHZFUVdaaVhyRDdT?=
 =?utf-8?B?c09peE1GZDZ5Rk0rTlpMZERQbWo1dC9BSDRkVDB4M3dvdnloY1QzSnY3RGh4?=
 =?utf-8?B?M01HU3liMC9ZSHg5ZDZxL3kvSExFbm4rdFpOMUJEYmJjSjdUdVNHS3NDbXp2?=
 =?utf-8?B?MkhTS2pZU3AxMFlITDhKaDR2V3g4UldtT3p5a3pvanpNMU5UZXgva1pKdlAx?=
 =?utf-8?B?TTd1M0c0NHJBREREMGc4T1ZlRVNEeEY4M01EKzl0U2Mrb2FDazNQUXdmSUVB?=
 =?utf-8?Q?22gDm6EikS4ZN22jephNtF6DvQOpiZAOq+RQkbs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0haVlJnbHEyWk1ERkxQZStQWXVCbUFydUJCOW1XSlg0R0xXWVc5UHJMTVVN?=
 =?utf-8?B?Y2ljWVZFYzIzTGRGNzF4QXZTUHpUb3A3azlMNkQvYVczQXBxU0xqRlo5K0s5?=
 =?utf-8?B?aVE3dmxCeEZHZnhQcWQ1QkVmTzNrbEsvRzYyWmp5V3F6aHg4TC9ZaDhXSmtH?=
 =?utf-8?B?N2VqeHdBenVBWnU3ZVNMYmhabTZLNkZZaFlZMUtCd2ZZVW1sQjFUQlNuaXZU?=
 =?utf-8?B?ZFFPNTVZVk5iNlVFSlNRd2dzYkloY0t4VjZqMTlQRTBnYklPRDc0VWhzNWt2?=
 =?utf-8?B?TFYwYmp0RVY4R0xCUW55L0s2REMzd1ErZUtsWXhBSVo1NWpuUVZ5U1hlYkpr?=
 =?utf-8?B?WTRnZHJqUHlKdFNVUS83RnRRZVF1azZaQjNTSSs3aWtxZThwNkdIY2xEVW01?=
 =?utf-8?B?R1hseEpiMUJwQ1Q1Sjh2MWNsTzNWSlZWb05ETzA4ejNNZVhHY0pjdmFGVnNh?=
 =?utf-8?B?d0d3ampQTjNteHlyZWRSWGZ4aTVNcDJiVEhsWUVNWHVsVGVCN3FySUZrU1BE?=
 =?utf-8?B?UVFNVnFsUVBFejlRTEwxMEJDS3VYeXBIWTdRdVJuU0hpRnFzV2NoaVpDVGJW?=
 =?utf-8?B?cEs5VytDMHpLYXh5Ym9QMVJjV2E4RWN1NG1HQm5uVUwwblVReENGM0l5THZy?=
 =?utf-8?B?ZXRqdHFXa0R1ZkhkK2hCVHdQWUJsQUxnVlJnWnBINEQzQ2pZZTMwbFBnWVE5?=
 =?utf-8?B?RUd6MmpzdEtQbzJ4VmswTXpsMEsvZGlDNWF1OW5DUTNhZ2VlR3pZY1dkcTNu?=
 =?utf-8?B?QmJjVUNJZVRRcTBYcHpKV24yMlFFSGRnMDBEWDZ6cm05Z3VBSEpFNVdOOCtv?=
 =?utf-8?B?dG1DSEZhbEhxMnNZTE5QR3pHNjdVRlRkNDd4RGFIbzMwVkNUNDZ0WlpmVUxy?=
 =?utf-8?B?VGtoK1NHS2dGczY5RU43ZFNxbFZrOHhOeFUyTzRhb3d2THNOV1Z5NWNmblBJ?=
 =?utf-8?B?ZzJJc0FBWUpQSjVtTG1XS3R4MEJpbkMzU2E5ZXl6anY2ZDlXU0RSdUhzajZU?=
 =?utf-8?B?a3VVNEhNTnZrVjlHanM0TjIzeFdzaEYwYmNmakVsdW5Rd2RJZUlOcDM1Y09F?=
 =?utf-8?B?Q3RsT1FJRUxBZStROXJWelliMjR5T0o3Tm5rak13WUhhSExVbEV4ekJ4YVRP?=
 =?utf-8?B?SzNacGRIZ3JwQTA2N212OHpWZEVCeEsrQ2FEcHc2VEdPalh2RWJmdTFkUlF0?=
 =?utf-8?B?eTNPc0xNa2hjdi80U3RweEk0QXBUTG1yeU9YdlJLSjJEenVjN2hNQTU0NTMz?=
 =?utf-8?B?NS8zMWZnRjNURjJQRExmdHR5aGxLVUVPSUdDNGx2N0lvU2lyb2xoUDByRFgr?=
 =?utf-8?B?cjB3WWo4eTFiTTY3QUtTck9Jb0M2L0xPWjhSS3Z0RGx4YmJhUGZGN3JkQnJw?=
 =?utf-8?B?ZmpBWmtVd2FScVo3QnhGSzRsMnZjTDljYlZzUWYxeHRFTGtDUHRRUHorbWdR?=
 =?utf-8?B?a3AzZGVNdHlBOWU2VHIwOGZZdHI4a05CZGlYVGhXTmM0L2tGaW9rdm9BSnpl?=
 =?utf-8?B?NGpwQTZyajN2QVdJdm9salhpYlNuckdSSTlrNSt3anpvcWtXUlJiVklTa0Vy?=
 =?utf-8?B?L2NXSzhXaFhvTVdHbThkeEZ4RUxXN3VucVBpT0l4OEwvSzlpSXE2UDNJWG9J?=
 =?utf-8?B?Z1dHNTF5Vjh0MHN5UEliMk15R2lKMm9JZDRuSUxkRGJKa1BWcFZVUkpMd1B4?=
 =?utf-8?B?dTJZMDBoczQzckhxWjZwLzdPMytTTkhPaGJQVERGcWVMUDE2VkFXajVhMytK?=
 =?utf-8?B?UWVFSmgyUHBkWXJPclNFTkxYcFplMmg1SFUvNzY1eGRVTTBJNzR1bCtLNHB5?=
 =?utf-8?B?RVo5bjMwU1pUYlJKNXlIZWpUUnlLbWZ4L25WeE1NUTc4RmYzdDkwakhiSUs2?=
 =?utf-8?B?c0tKMXhKRk1uU1FYUlpJUzRrbGV1TjFFZGVXU2VRS2ltYUNaUTllQXBUZ2Js?=
 =?utf-8?B?RnQ0T1ZHN0dVbk43SnhXcDhqUHQ5T3F1a1B1VzlnVzJKeTlpL0MxbkpVK0pN?=
 =?utf-8?B?NzZDMUc3MzZNZ3VabHJ1eGpjTER3b3phc1owSXBrUlc0MUZZZGUwYmR0a25S?=
 =?utf-8?B?TnhsMnVyZHg4Rk11Qm1GOERhcnJzYmpWZlA3eGN2WjRKVTRnWUUzS25FaHhK?=
 =?utf-8?Q?4z4cE/Ctu5yopw02dLYyrgrhe?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 98710a18-9825-40df-f509-08dcf8ec8bf7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 14:10:02.6885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +l8obKmWyaitwRh4nGzzqcrjob2eAa9HAsp3npqKu6sCrqS45URpBWm4rKoRCH5IjS8weWuodATYboJrDR5ojg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7023
X-OriginatorOrg: intel.com

On 2024/10/28 17:38, Vasant Hegde wrote:
> @@ -359,11 +359,19 @@ struct iommu_vfio_ioas {
>    *                                   enforced on device attachment
>    * @IOMMU_HWPT_FAULT_ID_VALID: The fault_id field of hwpt allocation data is
>    *                             valid.
> + * @IOMMU_HWPT_ALLOC_PASID: Requests a domain that can be used with PASID. The
> + *                          domain can be attached to any PASID on the device.
> + *                          Any domain attached to the non-PASID part of the
> + *                          device must also be flaged, otherwise attaching a
> + *                          PASID will blocked.
> + *                          If IOMMU does not support PASID it will return
> + *                          error (-EOPNOTSUPP).

Good to see this flag got applied. As prior suggestion[1], my iommufd pasid
series [2] needs to ensure all domains attached to a pasid-capable device
be flagged with IOMMU_HWPT_ALLOC_PASID. I have three opens as below:

1) Should we allocate the auto_domains with IOMMU_HWPT_ALLOC_PASID?
    Such domains are allocated when attaching RID to ioas. If we don't
    do it, it means userspace is not allowed to attach RID to ioas if
    the userspace wants to use pasid. If we do it, any cons from AMD p.o.v.?

2) Should the RID attach/replace path mandate pasid compatible domain
    if the device is pasid capable (say dev->iommu->max_pasids > 0)?
    This seems to be the only way for the RID path as iommufd cannot know
    if pasid is used or not in the time of attaching RID to domains.

3) We lack of a lock across RID and PASID attach/replace path within
    iommufd. So it is uneasy to sync between the two paths. e.g. we need
    to check if RID is attached to a pasid compatible domain or not in the
    PASID attach/replace path. Any suggestions?
    Or this is over-engineering since 2) would enforce the RID
    attach/replace path, so the pasid attach/replace path can rely on it
    without checking the attached domain of RID? The pasid path just
    needs to check if the domain to be attached is allocated with the
    IOMMU_HWPT_ALLOC_PASID or not and also check if device is pasid capable.

Please feel free to correct me.

[1] 
https://lore.kernel.org/linux-iommu/5a6c2676-256a-4fa5-b9a0-e433d4e933c9@intel.com/
[2] 
https://lore.kernel.org/linux-iommu/20240912131255.13305-7-yi.l.liu@intel.com/

-- 
Regards,
Yi Liu
