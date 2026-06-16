Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390C53D6CC3
	for <iommu@lists.linux.dev>; Tue, 16 Jun 2026 05:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781589161; cv=fail; b=cLzHXM6iJISGXM3cXFfAH5S7j6aclJBW8LS3ljikYEIxkC/N6DXtTPyL6B3cs6J4RunSrvGF3gbKXhrOLs7yP9J0EehQek1XVoxE0HneZ3aptk2lTI4sY+PkJxmZmMUCstf/ynMVAc5u78HLACD5fr+tkXU0wiDAYffVPkj4ZQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781589161; c=relaxed/simple;
	bh=HBFu/cxx45Ta/BXuVQR1UUJoE1WHci+bwRbbi9WWTlI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kdThPEPMfL8fXycz5QLE3SNqVvezhp8kbigSirA4k/RHDcqPlXrn4clkyLu+kN/KyOuaEk7VfKr8zk3CiINN4Ja3r+MilFnzCmkBtVPqoNew5kWvarWWJXUwTnteivhfvLlg0qvg6U17ZuP0MZO4xEqhsJ/SfZ4SDLbocBo2Ll8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d78eOgGw; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d78eOgGw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781589159; x=1813125159;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HBFu/cxx45Ta/BXuVQR1UUJoE1WHci+bwRbbi9WWTlI=;
  b=d78eOgGwnAiwYHSdi/w2RoWbBQVYd0E/QOWnzJqmejbDx04t2UuYry23
   wV7KdatV+s8nLheggd1WXdduTBSvxPZF1mZyiyXIELtjsw+1E9w7oJcir
   R193gSaWi+3fMhwnVgoMBcXyedbPTMDsa7Y6Xa9y1d4ZXQrys31AyyFyF
   strvsQka3Ebt7mC2OKY/EcQUKJ8ZieIlIftHuUM7fHXOIb0PRDUXT4o3I
   X4Y9osteHnZyGFKP3fQN2vY/KXnKQ0qT4pfvyJ6eZFG4agqAk3aBiJv+0
   R+5LWQo7wel38qxouk3U/r1yWvt2OFlNfMmWUslilDOvv4f6Wx3WAsgcF
   A==;
X-CSE-ConnectionGUID: KnI+bx8WSgKpUNR9Mq+Oog==
X-CSE-MsgGUID: jRXsEs5xTtGIsSKdw09hFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="93015397"
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="93015397"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 22:52:38 -0700
X-CSE-ConnectionGUID: a6oER+iNT+ejDdUCVpJ9Pw==
X-CSE-MsgGUID: 3QgaHwOIRAqK7LPORC8dtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="271741824"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 22:52:38 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 15 Jun 2026 22:52:38 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 15 Jun 2026 22:52:38 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.25) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 15 Jun 2026 22:52:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IMzuETbJdz4M46DPzjW2L81hdSRLZy7J7VAFmza5JNCMpUnrpPQrwbA0vTROSUOvTumczF88wkRoqp8Gmo0DLtiq+bGLe6mBGka8ecpMxd8+jw5V3Os4bsiBAR7tEympC6Hb845dbPQXXbCJgkUm4jTExIRb6RA8Sye4DwZIAsqQXqr9R2lwznGqfrnPBzYzaqTe/oWGln/ddqlzjzdSQ5KxB5XoKHW9E4GjO9dTJk+7TFxzjJQsyG3NQ1+8UuUz1xKmUg+Dhf0yDy73xDEoHg0++y5raOZ7gdtkf7f8Wldi9ixUStISCk7GvWPKlHBYcpX4PsInuAVxSZ+ql6BflA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/Xhn0XMMQ/Y1a/+yblUR8HdLAZBmQiLJm/Q3DDrwQ0=;
 b=CtQ1UxV4FOQwIYQvG2n+yAHu5gqkb14fuzbM5lQ4xRhRS1+j3d+q2YvdPlyTEKqrw5wTpDBWf+DmCoCJEvlrdncksI9zc3cv1AT1HS0MuIIcbNlNdMKfL+D2m+9wEYycyqS1u2R4DX2E7aA/gc3ZyGETweuZUACRQEhf0AA41KD1AstR51Q34wt5VyPebdYv8d+w3XMvl+U+tZzWMki+majNdpyEkLjQVEQUNolAYu/cm5t3go8aozskkfNAipADKG2hXf/ob3VVrEpFq7cxGH+yG/TpfLuEA/dQOSSGwsdhtVUj60dYI0g7RtboY4Tp3oXL0/xelKZ8pNNVHx7P0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by IA3PR11MB9181.namprd11.prod.outlook.com (2603:10b6:208:571::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 05:52:33 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 05:52:33 +0000
Message-ID: <58f59f4e-8bce-4c22-bad5-b47cce2b6993@intel.com>
Date: Tue, 16 Jun 2026 14:00:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 5/6] vfio: Enable cdev noiommu mode under iommufd
To: Jacob Pan <jacob.pan@linux.microsoft.com>, <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Jason Gunthorpe
	<jgg@nvidia.com>, Alex Williamson <alex@shazbot.org>, Joerg Roedel
	<joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, David Matlack
	<dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen
	<nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>, Baolu Lu
	<baolu.lu@linux.intel.com>
CC: Saurabh Sengar <ssengar@linux.microsoft.com>, <skhawaja@google.com>,
	<pasha.tatashin@soleen.com>, Will Deacon <will@kernel.org>
References: <20260611172658.3421138-1-jacob.pan@linux.microsoft.com>
 <20260611172658.3421138-6-jacob.pan@linux.microsoft.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260611172658.3421138-6-jacob.pan@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU0P306CA0039.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:29::13) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|IA3PR11MB9181:EE_
X-MS-Office365-Filtering-Correlation-Id: 70f19340-31f9-4e09-d4f3-08decb6b7568
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|42112799006|1800799024|366016|7416014|376014|23010399003|22082099003|18002099003|921020|11063799006|4143699003|3023799007|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: 3Xe5RsLXYx0IaVJR+/Oo8hU+LtWObfEP+6WLjOhDo7PeTLVbxkFfR08zj4/YxiZbSEG4HLS9uLHbeHR7Jrup7njq6uWFl3fRjCMQC38OeRUwyuya/8fop/6IES0MbhqM9IsiQBmsG8Vs0CpipCdo2ff0RXuW2jSAZYqyxqkJWnFlzbEeY4Tc3++6dujoxisagKfCHDrrG4/GMJZIYbSBudDOnz4iAZaQXaAe20rOu3wCLhTowmrNCpG3QbCHcAnGh5+5ro0nI2Q8UVFG2QA3B803XkfdK4GFhn9L7JjuGdpsYswTNGNVSTSBewHH5eUEYu/SK3q0IcjD8f7HcAljRHEtXLI4HtH0RTqqCxU9UwukA0L2oVm20XrAA3qsF0SGgl+NVG6XGj8HehQPC/gSJwwRIRhm5s30kwp7cjHI17jpq/QKwioKIc8PgceXuY+4ikmeFrQzXJM4yJZObEPFyXhJea0EYa7xFIrq5ykDD88qpqDUZ23CWPp6YDB9PBcBZB4s5062xkyiF2+22D9Blh/HKLMeKfX5D8/MYXXD5chtihrtghAXozaQBtJ6SkyCraHAtz1uqRmKLDRVPXTzqDitoAfIapN5fyLrXjpdF661kMQJ/SPKsOdPz5flBKmvYRaiV4bPeXphKONAxOPOc3OR6//Q8g3bMI16F3gPcrMHQNXmrZY115O5C1AgrQU6yuWzrf/LjE0N8if8Ii6/WEH9x9N1bVGPyT2LA6TOvB4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8509.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(42112799006)(1800799024)(366016)(7416014)(376014)(23010399003)(22082099003)(18002099003)(921020)(11063799006)(4143699003)(3023799007)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czc0OWVVVnJpeUZvelJQc2VJaUZXMER0bHdUbzFzaStSd1ZaQUZUUXRkcm1B?=
 =?utf-8?B?UXlkOWhEVEp6RzlRZkVGd2pIS1ViQlc1RWtjSENsdVFWT1Z6dFhhL1EraFhi?=
 =?utf-8?B?YnVXKzNWSFdJYURRL252TGQ4VDMvTGZRcjRkM1dyREVyRlAwZFFOOFlGRzI0?=
 =?utf-8?B?RkljbXVFWGF2SS9YMk5ra3dvamlEYlkxd0QvbndURHZ3bzl5UXJJb29wZ0U3?=
 =?utf-8?B?b0NxMzZUNEFWQjBNMENlYUh5MzFsMlRUWkdBRUgxVjRIYUdOL3NIa0diZUlE?=
 =?utf-8?B?WnNYdXhHK3pVUFU5RFF6c0ViZUJIOFZUVk0rNFhsR2l6MXA0SVUrVHZOci95?=
 =?utf-8?B?bjdjaExHa1JuRC9abzJoOWhadHAxbDRUN1UrUXJycGRjeW9tb2NHZG5qRnRu?=
 =?utf-8?B?cko2dUU4NVd0WFVNQ2E1Uy9oTnBjK0dBaVNoQmlRdWZsanNwb0h2NFJhQU9y?=
 =?utf-8?B?c3c1cjBnSndzNVBON1gyUVA1dFo1YWNKWXZyeTViQXFBRjZwUFZBMm0vSWZC?=
 =?utf-8?B?bVY4OE43WmNOWHNQa0VEZEtRTkZueThmTVl5Q25YejhmczBLdTZSQWFXdHdV?=
 =?utf-8?B?YUNZb0N3VkxtY0pINitYOGZ3dkt4SlhmUWdFSHMydVNnemhxZXhDVjJJR29s?=
 =?utf-8?B?TzNROUZnSnZ2UllBZTB2NnlYRmdQVFo1M0hYUm5qWFN6UWVpRnRUU3V5RTNv?=
 =?utf-8?B?V0xwZHk3YXJQWXlQZzRJOXNLK1V4UTRqdk1EVlcvV05yYi9MWVdNVENGblJ3?=
 =?utf-8?B?R1Z1WE5rTmV6SHFvaWE5WS8zUEc4MHdJK1p6VGdsQU5rR2ZWdzZlekpmek5a?=
 =?utf-8?B?R1Y0bUhSSHNqU3pybzFXcUhiN1N5alJhZUllcjlERXNCWjZNdmF3b1o1d0pD?=
 =?utf-8?B?S002RHlBOGV3MS9IZEtZS1NUZmEzUkJSaisxcCtVcGgvUzJkS2FvWDAvY2lB?=
 =?utf-8?B?dU4xWEZzc09TQ2pXWlhVTmNmbng0Z0M5MDZIWDMrc1ZQZFN0UU4wUG5Xc2xt?=
 =?utf-8?B?YjJyNTk2NTJRMGU2YlZtVzBwcy9DbUNhUUhuNGVCWi9Ob0tRK0FLeno0NG9y?=
 =?utf-8?B?Sk11ZGhJS2JJUlJJQlZiMFVTYjYrRHROZ2lCNDhtbFBwNHNvSk1BcHVPdzJn?=
 =?utf-8?B?VjV0T0JNS1h2VmtYTkZiR2UvbWlrLzVwb05pRlZIcUhJcUx2OUVEZ0g0QWNK?=
 =?utf-8?B?SW9RUzFmamlRWWZwWjdUNWd6amhHOUZZMTZaYlBmdWI0cmpmajVhSVFqckh1?=
 =?utf-8?B?YXdBRDdvUjIvMExwM0NwUk54Zk1tY0NCU0VJejB2K0J2K0VNY2tBUUZDazla?=
 =?utf-8?B?VkFWa0NsTHVZcGpIeXZEcVlTZkJuMkcwaVgxamorbW1xejBNZXF2NEZiZGZr?=
 =?utf-8?B?aUdoSzg3TjdmRHpRN0wzVTJtS1JRckd2czhVeGxzTWhWSDV3cGN3MHA3K2N4?=
 =?utf-8?B?RFhwajR4WlpQd2xQVTRVcUZDZjdDWFlJb2QrQXhiWWYzOE9UVGt1b2RsT2tQ?=
 =?utf-8?B?eDhMS3hFNVZCRFVFUzExWEZrMThqMEU2MU9BalJZMjRSeG9NU3NEK1U4bEdP?=
 =?utf-8?B?ZzFlNjFJZllqdWVEWE1STHVmOFlFbktVZEtvcDdGZW5qdGI4dW83NnJaSHFz?=
 =?utf-8?B?SlAyNzFMcTVyT21EbHVXV0UyMkFXQlhMd05xQzc2anQzRk5EclF3UHpsejlV?=
 =?utf-8?B?NHdHdGVXQVY5cmNUTElab2NScGlpeG0vSmdlbDZOdG5tV3RPcmV2bGRhQzd1?=
 =?utf-8?B?Y3hsMndOblRBWXBSa2ZYOGhmUSt3VzFlYk1SYmFRcVYwVXpIek04V2xxSGxE?=
 =?utf-8?B?aE5WWnlocnZFTm1KbVZmTFIxSFVIdHJmZGpVZjhMS1g1ZU5pV2MvaVAralRy?=
 =?utf-8?B?VkRpTkhwNXBrK1EzVGQ4OEIxNHpJNk1TTlE4MEt2ZlUzV3lacklvek15TW0v?=
 =?utf-8?B?aWZDbk9YTG9DUjZPMTY3T0VjK0I4MmdaTzFxeW4zU1dOamRvZHh5cVdlbmZa?=
 =?utf-8?B?cjVxT0lydWhwOERTeEt3K3dhMS84N21FdFRmV0YzNWhGYzBJMFdiQW4rV3Zm?=
 =?utf-8?B?cVJEemJMOFIyVFdvR2V2RlFGeVp3WjhzWjYyay8wb1ZKODMzcUtteEdNQnJN?=
 =?utf-8?B?QkFyYnBqNzE0UEl3Mm1rVHNnZDhKZFZKeFVOZDAwSklTNTl0eTRRRldGejhy?=
 =?utf-8?B?VHBCeE5udnpLekRtTkt6eVBTL3dNUkV2YXlJNWJMeDd5L3VrTzFXc0VFdEhN?=
 =?utf-8?B?Q0NpcGhOUzZLMFNENHMvcjJ5K2FTZnEvVjExb2pBTkU5dG9SL044SlFtamxS?=
 =?utf-8?B?OWlHT29DemF5UHlmM2d6V2p0NW1MSFpPanlGcXM4K2ZTeStkTk5Gdz09?=
X-Exchange-RoutingPolicyChecked: o6uZyJUsls3LHHYCjVWdA/bY4OK2izR5VZs2WrYxVu+Ee3cyHRLAdhEsxtAyY9ahWiHb0x2BblPGlVg4epZ/m//aXbO7EsycgUjE/nFyoe3Wl7Cz88ku+s/Hi4Mmn7gSp3B84TqJ2+7sBPs+c5V17zs4hBEoJZ4o197LZBRfFrq+8xB0QABd4qyLHDKMzgnOMK56mYJkMWgMUkx/GmKekn0cX+dqSy3zfwkinXp4krqDqKK5sTMTgxCCT0CFbLjY23zgvzmqKJr4PRFU473wuRpqCBbr5Iixg9PBdSg0e5BFieHgM7TFImH4y5nBIR3xLA6nME4CMHVUfnkwkvhpmw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 70f19340-31f9-4e09-d4f3-08decb6b7568
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 05:52:32.8672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6dRhgqn8tJBjEGC1OBZ0tQUzNJlOHexxRiQ4Ws5w82eOD53KosnQwBSqTG36SbbFxOfbI57F3xy49bVmjKrMFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9181
X-OriginatorOrg: intel.com

On 6/12/26 01:26, Jacob Pan wrote:
> Now that devices under noiommu mode can bind with IOMMUFD and perform
> IOAS operations, lift restrictions on cdev from VFIO side.
> Use cases are documented in Documentation/driver-api/vfio.rst
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> ---
> v9:
>    - Leave device->device.devt unset for no-IOMMU dev so cdev_device_add()
>      registers only the struct device and does not expose an unsupported
>      cdev. (Alex, Sashiko)
>    - Hold registration while checking cdev no-IOMMU access (Sashiko)
> v8:
>    - Fix warning message (Kevin)
> v7:
>    - Avoid treating emulated device as noiommu device (Sashiko)
>    - Keep platforms w/ GENERIC_ATOMIC64 to use VFIO group noiommu as
>      before (Sashiko)
>    - Restore order of group & cdev init for noiommu (Yi)
>    - Consolidate noiommu helper for cdev & group (Yi)
> v6:
>    - Revert back to unified VFIO_NOIOMMU Kconfig for both cdev and group.
>      Use Kconfig dependency to restrict usages and avoid null group
>      checks. (Alex & Yi)
>    - Add CAP_SYS_RAWIO checks for cdev open to maintain security parity
>      with the group noiommu path. (Alex)
> v5:
>     - Add Kconfig VFIO_CDEV_NOIOMMU to select IOMMUFD_NOIOMMU
>       and its dependencies
>     - Add comment to explain vfio_noiommu conditional definition (Alex)
>     - Removed early return for group noiommu in bind/unbind
>     - Use consistent wording referring to VFIO noiommu mode (Kevin)
>     - Update unsafe_noiommu Kconfig help text (Kevin)
>     - Change dev_warn to dev_info for noiommu enabling msg (Kevin)
> v4:
>     - Remove early return in iommufd_bind for noiommu (Alex)
> v3:
>     - Consolidate into fewer patches
> v2:
>     - removed unnecessary device->noiommu set in
>       iommufd_vfio_compat_ioas_get_id()
> ---
>   drivers/vfio/Kconfig       |  7 ++++---
>   drivers/vfio/device_cdev.c |  9 +++++++++
>   drivers/vfio/iommufd.c     | 12 ++++++++----
>   drivers/vfio/vfio.h        | 23 +++++++++--------------
>   drivers/vfio/vfio_main.c   | 26 +++++++++++++++++++++++++-
>   include/linux/vfio.h       |  1 +
>   6 files changed, 56 insertions(+), 22 deletions(-)

LGTM.

Reviewed-by: Yi Liu <yi.l.liu@intel.com>
