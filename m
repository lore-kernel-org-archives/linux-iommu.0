Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9187A221DB3
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 07:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777361908; cv=fail; b=X8kycbZjraZvFdN1VZDdE92Zu6XAvVl8WhUBUKERFkvXGvRoESGJABOjr7PZZPH8osQop7mahCeHX3Tfmtx05jcTOxOH97KHCL2nr599erqPhQ9FLxYJSL2ou8AYAbCmHbh7sXLJAWrX2FXvRQ8EZxdZQkpkqgiDdk0DsjXE2cs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777361908; c=relaxed/simple;
	bh=oZI4l74iLdiXMlgyC0odzHFVCyllHFjkbC5+pnjuESQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rMi2ozIifzRCZjjOZisUL0L8IOcRs2BlIUvpVg+efF83IX1H/Dwbio9Grr1co8nAdThWUo/82sGhaZ+7j8NytWVWVISCDv56ZWV2Hh/f0mwxmB21yyDwCyeO7TP1m0aHxu9uP0cMoOLDH7F/QXVHx82vhHWoJ7hyziHBr4d2+I8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GbWl/0uz; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GbWl/0uz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777361907; x=1808897907;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oZI4l74iLdiXMlgyC0odzHFVCyllHFjkbC5+pnjuESQ=;
  b=GbWl/0uziH3h4wzqDqZU9qpvrzv0HP1EI8O/xZP9Fxk3vxC945n2DNCc
   1UlQoWo9jIWnEnIJ+a79nT685shn0+TeB100a6rf+AcSjy7kR1W2eOILc
   2X9U2WjrtAytPIyt+Yb3icVUBlXmsMUVafShPztqFW8hSNETF/BFCzpVr
   JeUC7Yl1uotxJLa1t+WzXNk526rkX51TH/9gWUPWQvDxcE7OuncCI8rVS
   d2fqtFqhDe9wv7YDzDC86DqDyoK8+LHUNVOswmoFblIRmMIeFYiFOMm3K
   daOCefFDK4XwJf1yWEmXOd5o1PyL+31JVuLhzmb6f/OZV2y4a6dc8rTMH
   g==;
X-CSE-ConnectionGUID: bqQq6QWBTBCmS7mlWmMitg==
X-CSE-MsgGUID: Zf6QZIavQWms/DtzjPIPig==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="77966527"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="77966527"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 00:38:21 -0700
X-CSE-ConnectionGUID: NN5PLn5XRI+j1LG0hfDSMQ==
X-CSE-MsgGUID: e3lZUX0URWaOhD5cbHyYXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="238860911"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 00:38:20 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 00:38:19 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 28 Apr 2026 00:38:19 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.70) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 00:38:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mx7mL3v+MtuG97lplBP2ZZcE/x76QsCwxI/x3VDycfUUb2pB3KL+aM3BUuvHkEiHDENLt9+AeL1NM9slmp1ILazV9MHY2xfMSBR68cEP32tXEKHHalx8k19l0yprMjFSYVbtaUMOhFdUREuHxgnG8Uec+j6S4LyVLCrMNrpCoEdKy+GpXnfeaHDJZxQaGbiixJGkL2puw0OrIsflOoAAm5ydIzW3RpCIdSJVQ+PptCI+qT7gKWhaQRk4EDdAL/1JIqviMGy83lcykcGoKdZiAZAmWnhFfZQT6B5INMrqAF5p9Cg49+/dDrRnr6Af47gJFm8MYAC+5C8J+UAJlMQFmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OuLxViR8LGEVRVFx8EpbEyaujM8XmXwlxlZyfurkizI=;
 b=YHgEacZ+CpGnZwY5a45JO19RMolMP6haO/0o9PIDMyo34napFcNcGzhb3pK6cgyf3TJIsUyVuBoGGQcNgWchvZLNhrahMAnuPfDa9RvTZ3EW8/hLAiEBTABk3bCfUTNWYj+sNYJpA1GfoGwEMAWL7TWsOysQmw1CC92NKMpmDo4SH/xtXfxcvit8KAvSW3o8dSpTOjKYRL4aEwiyKJKyA4jT2cAjc/tbqKhFJsRUhcwFhKQ6EbRAQlttmswEkfolECwzG1Kysx32eajZgAnRLkzEyAlqsttXcWsYy+lX0EYplzYy7j4AFIvbubFL/dOxeBDmW5wXn6UYWJXnVNHwzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by SJ0PR11MB6696.namprd11.prod.outlook.com (2603:10b6:a03:44f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 07:38:14 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.20.9870.016; Tue, 28 Apr 2026
 07:38:14 +0000
Message-ID: <dbdd2289-8a0e-40f9-a0b5-842fd861acba@intel.com>
Date: Tue, 28 Apr 2026 15:45:56 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 03/10] iommufd: Allow binding to a noiommu device
To: Jacob Pan <jacob.pan@linux.microsoft.com>, <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Jason Gunthorpe
	<jgg@nvidia.com>, Alex Williamson <alex@shazbot.org>, Joerg Roedel
	<joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, David Matlack
	<dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen
	<nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>
CC: <skhawaja@google.com>, <pasha.tatashin@soleen.com>, Will Deacon
	<will@kernel.org>, Baolu Lu <baolu.lu@linux.intel.com>
References: <20260414211412.2729-1-jacob.pan@linux.microsoft.com>
 <20260414211412.2729-4-jacob.pan@linux.microsoft.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260414211412.2729-4-jacob.pan@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0015.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::10) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|SJ0PR11MB6696:EE_
X-MS-Office365-Filtering-Correlation-Id: f612cb8b-a1f9-449a-e7ee-08dea4f91b31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|42112799006|18002099003|56012099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: WctEIDQEhLQuRptDM/1W6IYXv1SuslMx4xjh7Dk24rs1W79xFjWyxBKvtO0qHXXMUFgRPdOTniRvYoLCYTNOKJ+72T5gTPF9oFrJ5N/FNXfwEX3HG+1oeav35apeaqcKwbWbnLvm/n0090vbprmGiCq3QMscdtIjDgLxv/N8AvohUGrc1U/z3LEerWToqc92fgrxXVgJcfYtqajPuPAqo3SOgWYV/gJI0+f+DB4k9pBJsTnr3mbT7xyAjCTF+kywrz0zsnCk6KGs2M5t4uyHCK1Zf5Mb2nFzRt+oD8kQSgAOUIdc62DoOvdGZ8ZPFsOlJ5KVvyjdaTvgvRKiPRU/EfvU9PKqYRvdldZ66AVERzAVwEtY9BND9qeWyjEndCMFUVml50tE0QDaiEM9C1nPIoUqi9yPykvVEM9W03vo/7gOset86H0i7KGIM2TohPOeQ8JepAZ4UmthhNsujMaJ91hV6esLT0vMMpNlrKX8PqDaIJstB0Uge80gzWJTFzPaPC/CJscoiXrNPpWYVJ5uxxtOVZrZRy7VbU1WNDCuVn0buxDIytxIoA2XieUdRw3Xir9CgMOfrPq3DBjEJzWRLVaInQ3nontBCdbsJMBqRI8fZXPvpiBOf7HXCFrweSWORQYwURrQia14MwmZKLo6ZwE/2SnHUMgQYTUlc2dJ1413RuvfsRHNoQCH2kAtRKz8pSZXvDOeD2rKsXpufz3dJCHQuPnCwmFvwnSy4y+n7AxlLRl37h5a7nKixfvNNhl4H1VRV6TrNBRFOBrozS3Yiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8509.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(42112799006)(18002099003)(56012099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1JXL01XemNIckVGQ1J4cjQ5Y05ISDNsR0N6UG1wWDlvbVU2dEpCSnZIMVh5?=
 =?utf-8?B?bnBPZnB2YVVPM2tSTE5xdzU4azZqRWRFYjZaV3Y5OWRRenlDSWJRbm1zR1BS?=
 =?utf-8?B?bGZsWis4amZtM0JSQmdvendoaGdtOW5ydFZUc0xiTXZFcDl4ZkwvRHJhY1Vh?=
 =?utf-8?B?emxNV0dReFNRWHV0RFlsQ3k5VVJ5ZmM4akt1TEJRaDhadmcrVjFUQTcvRER1?=
 =?utf-8?B?UlhGYlBsSUpYa3JudTNGaGVMMytqWSt2Wkt4bTByeXRpWTVBOEFyUENuZUtj?=
 =?utf-8?B?NWFlaUgyV3FjNDlSRXdhSmdSVGdzdUhlSVdGRnhvLzZLVmRseWlCTFNDZ0ZX?=
 =?utf-8?B?emFZbkNVVFZyNllQRlpaeDlZc0d3WFlnV05OOUE5NlBRMW9ybVpSZUtTaHlS?=
 =?utf-8?B?N1ZqU3RCTld6c3dzUDRXMHZlY2Z3SnBsVVAyZnVhRVRhQzNlc0lSU3JlZkZI?=
 =?utf-8?B?OFJ5Mlh2dkE1RWM0U2syU2oyVFJqQmkybUI1MXREYmtRQkpSVjhrZFp3Tklv?=
 =?utf-8?B?S2x2K1JZKy9DYm1EeXRibDd2Z1JkN0w3dTQwWlJJaVRiN01DcFFsWExrSnl0?=
 =?utf-8?B?M2hxcS9Ecitwdk94K1dmMTZCU0dPZFZJNENsclBUdXl2V2FYL3RZNjF1bXYw?=
 =?utf-8?B?MEhQd3JjVTJEUkR1K0R1dlVTY3ZlNUhCeXlYclVWMEdQOG9JM1hpZlBnQlRS?=
 =?utf-8?B?NmVaYnhZZkJkMUZyQmpSeW9hQlgwYUhqQ3dEb2pYUDI5ZVUwZW5IQ1pVZGVo?=
 =?utf-8?B?U0RvdVlBMGJ2MW03akY3MFZuOVVyTVAwaHBNVjdjc0JtbllEMGMvNmNkRkxN?=
 =?utf-8?B?K1R0aFE4NW4vMUlVS1JTTG1Hc0UvWFhBejdiOHUyZ3BaWU1NM0tleDJkUVJM?=
 =?utf-8?B?MTF5UDFodGZ0Y01ZVHo4UHBMQVNzOUptZFVFOGc4NTZkTWtreDlMaEFIQXdr?=
 =?utf-8?B?N28ySnVqL1lidEpvSnNqZ1JkTWhaNmtUM1pid3k1OFpEOEFqK2dYVGpPcHk1?=
 =?utf-8?B?OU5DYlI4UEwvQThnV21iakFscURQUElRcDRqb2VDdW5peUNrbmdrYTV2bFBX?=
 =?utf-8?B?a0tCMkgrS2Fya0lKRTdkRUVNemh2MlZnMkZPeUJjOGsvQ05GM0VDUFY1a2tT?=
 =?utf-8?B?aGdCaS9sa1QwcGRRdDhHK2dzS1ZnNnl4UWZidXNNem5Td1dDNTFRQm9WcnA2?=
 =?utf-8?B?Nlc4dzBjTmowaTNiSytoS09wOHNUTEIxTFltQzBEYlhoMkFOTzk0cG0yd3Bp?=
 =?utf-8?B?MW8xU240YUdXeXRDMFBJZWxpb3pxQkJLTjRkV1RleEdKL1NIdDJFWFJuaHI0?=
 =?utf-8?B?a0RLMWRLbnBaUStHYTFhSFl2OTN6R0R5Q2YxdnM2U1c4QXBIWU5welA5ZE5i?=
 =?utf-8?B?OTRuYVltaHJxdFNaRWhGOUhJazJhR0lmakJnY05ONFZ5K29BNFAva3FGTmty?=
 =?utf-8?B?L3RsNXNIbE8zZlB1ZkFvcDVQZW0wSFk3bnNRQWVrVkg4Y1FkaFpaOURVNXA4?=
 =?utf-8?B?eTYvcU54NlFHdllSK1FJeTRmNTRmajZDd2M0bys2dTlERUd4UW5jNXlTM1I5?=
 =?utf-8?B?M0thbHhueDlRaXIza3N4b09TMnF6OHBRSzlJT25JbGV3dytXZjZjcWpTZG1q?=
 =?utf-8?B?eGNWT0JNU0lPbC90TFRNYVJwWnhvVUsrTGRycjNXU2ViUGlMYUpRUk9JeUh4?=
 =?utf-8?B?MUhyWXYwREw4S2orVzJ1UTlFZUZiZXB4SXAyQXhMUGoyNDhwcFpkRHZsaXJl?=
 =?utf-8?B?ajJwQXN0NmY0RldxUHN4SjRQRkxWZWdqUXduekQ3MzBMT1hYWGhZNmhXYlNF?=
 =?utf-8?B?K3FDcnpoWVJPRndueDUzdVJxM05SWER1N2ZobGNBSUs2aWpITGtpRUZlN1ZT?=
 =?utf-8?B?M0FGbkg5eFZVSmJhSGpaMG8xVktZbUk0OEFpY0tveFl1SEF3bVFyZFJBSG5L?=
 =?utf-8?B?dkFFRG5zSUUrNldsRnVZeEFFcEVzMkdEUWxnYVZNamRLYVRPUzRyaXJDek9I?=
 =?utf-8?B?dVRVQjFobko3M0pYMTRCQktzS2xUVWlvbHQ3OUczZ3pQeVNvRXg2dmZ6OFNJ?=
 =?utf-8?B?SmZjVHVXR21LWDVVYjN3R3FVNmlGVFdBeTdZUzJjVTdTUUFsNXI1aGlPclFN?=
 =?utf-8?B?bndSMlVsNGtZN0RYUGNpdlU3WlZ4cjJaRmRscmNqbFFoelRqTzN3OHQ3OUNU?=
 =?utf-8?B?alNDaTl3T2JVVCtNemNrbElWTWs3RmF0TkVHd2FzNXJHSGg1RXlsNTZNSU1o?=
 =?utf-8?B?d0RwM0hoZEZWdjc3T0pqK2Y2cUtmVk5Db2lYRjM0ek9LRDd6cWJrbmthaUs2?=
 =?utf-8?B?cEd3WFNDbUh5d2F3Y2Jlb01kNFI1Z25oQU5DV05XbFFaeURxb1hQQT09?=
X-Exchange-RoutingPolicyChecked: st2ezdOWjt8MGSMfRq2oHrWNuMeIIEZWL3HAFCremEtp26LScyLmWpCjEu0edGlXtOAckLhj7fx6OCz7OhAq8yi4EKYNVwUz6z0Wp/QLJJZB3aa5AuJGe3Za16O35JYWFiIv9SCeJaI21XMpjbJKI1SFFxgVuzG9OUGHpYcOX18CCtuorZ/ZCeMBEemyj7P6Xmb0JctX5Y6aXARBMo99ZAu1rDr7fb0feNK+jqK4QzEPqhjIUskdBfC7w5tfGz3tmOOI56HjSHcucsR1waoQmNh97wqjm286WGgKl5InM+jjzNr3JmH/zL70bVqPqPGpDoqvRRrYtRkTv5w7eooF0g==
X-MS-Exchange-CrossTenant-Network-Message-Id: f612cb8b-a1f9-449a-e7ee-08dea4f91b31
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 07:38:14.4715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pdncfgBzNblk31mLDrxiMbcfbqqJsJ+NYl46nSvfmdcQamfp7QfrrC4vPuhKa2wBaQ36tkQ8AWBeuT9/h0FMOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6696
X-OriginatorOrg: intel.com

On 4/15/26 05:14, Jacob Pan wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> Allow iommufd to bind devices without an IOMMU (noiommu mode) by creating
> a dummy IOMMU group for such devices and skipping hwpt operations.
> 
> This enables noiommu devices to operate through the same iommufd API as IOMMU-
> capable devices.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> 
> ---
> v4:
>     - handle partially initialized idev w/o igroup (Sashiko)
> v3:
>     - handle new error cases iommufd_device_bind. (Mostafa)
> ---
>   drivers/iommu/iommufd/device.c | 132 +++++++++++++++++++++++----------
>   1 file changed, 93 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index 2f30ea069f66..0283ac39be55 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -23,6 +23,11 @@ struct iommufd_attach {
>   	struct xarray device_array;
>   };
>   
> +static bool is_vfio_noiommu(struct iommufd_device *idev)

perhaps iommufd_device_is_noiommu().

> +{
> +	return !device_iommu_mapped(idev->dev) || !idev->dev->iommu;
> +}
> +
>   static void iommufd_group_release(struct kref *kref)
>   {
>   	struct iommufd_group *igroup =
> @@ -30,9 +35,11 @@ static void iommufd_group_release(struct kref *kref)
>   
>   	WARN_ON(!xa_empty(&igroup->pasid_attach));
>   
> -	xa_cmpxchg(&igroup->ictx->groups, iommu_group_id(igroup->group), igroup,
> -		   NULL, GFP_KERNEL);
> -	iommu_group_put(igroup->group);
> +	if (igroup->group) {
> +		xa_cmpxchg(&igroup->ictx->groups, iommu_group_id(igroup->group),
> +			   igroup, NULL, GFP_KERNEL);
> +		iommu_group_put(igroup->group);
> +	}
>   	mutex_destroy(&igroup->lock);
>   	kfree(igroup);
>   }
> @@ -204,32 +211,19 @@ void iommufd_device_destroy(struct iommufd_object *obj)
>   	struct iommufd_device *idev =
>   		container_of(obj, struct iommufd_device, obj);
>   
> -	iommu_device_release_dma_owner(idev->dev);
> +	if (!idev->igroup)
> +		return;
> +	if (!is_vfio_noiommu(idev))
> +		iommu_device_release_dma_owner(idev->dev);
>   	iommufd_put_group(idev->igroup);
>   	if (!iommufd_selftest_is_mock_dev(idev->dev))
>   		iommufd_ctx_put(idev->ictx);
>   }
>   
> -/**
> - * iommufd_device_bind - Bind a physical device to an iommu fd
> - * @ictx: iommufd file descriptor
> - * @dev: Pointer to a physical device struct
> - * @id: Output ID number to return to userspace for this device
> - *
> - * A successful bind establishes an ownership over the device and returns
> - * struct iommufd_device pointer, otherwise returns error pointer.
> - *
> - * A driver using this API must set driver_managed_dma and must not touch
> - * the device until this routine succeeds and establishes ownership.
> - *
> - * Binding a PCI device places the entire RID under iommufd control.
> - *
> - * The caller must undo this with iommufd_device_unbind()
> - */
> -struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
> -					   struct device *dev, u32 *id)
> +static int iommufd_bind_iommu(struct iommufd_device *idev)
>   {
> -	struct iommufd_device *idev;
> +	struct iommufd_ctx *ictx = idev->ictx;
> +	struct device *dev = idev->dev;
>   	struct iommufd_group *igroup;
>   	int rc;
>   
> @@ -238,11 +232,11 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
>   	 * to restore cache coherency.
>   	 */
>   	if (!device_iommu_capable(dev, IOMMU_CAP_CACHE_COHERENCY))
> -		return ERR_PTR(-EINVAL);
> +		return -EINVAL;
>   
> -	igroup = iommufd_get_group(ictx, dev);
> +	igroup = iommufd_get_group(idev->ictx, dev);

no need as you already have a local ictx.

>   	if (IS_ERR(igroup))
> -		return ERR_CAST(igroup);
> +		return PTR_ERR(igroup);
>   
>   	/*
>   	 * For historical compat with VFIO the insecure interrupt path is
> @@ -268,21 +262,69 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
>   	if (rc)
>   		goto out_group_put;
>   
> +	/* igroup refcount moves into iommufd_device */
> +	idev->igroup = igroup;
> +	return 0;
> +
> +out_group_put:
> +	iommufd_put_group(igroup);
> +	return rc;
> +}
> +
> +/**
> + * iommufd_device_bind - Bind a physical device to an iommu fd
> + * @ictx: iommufd file descriptor
> + * @dev: Pointer to a physical device struct
> + * @id: Output ID number to return to userspace for this device
> + *
> + * A successful bind establishes an ownership over the device and returns
> + * struct iommufd_device pointer, otherwise returns error pointer.
> + *
> + * A driver using this API must set driver_managed_dma and must not touch
> + * the device until this routine succeeds and establishes ownership.
> + *
> + * Binding a PCI device places the entire RID under iommufd control.
> + *
> + * The caller must undo this with iommufd_device_unbind()
> + */
> +struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
> +					   struct device *dev, u32 *id)
> +{
> +	struct iommufd_device *idev;
> +	int rc;
> +
>   	idev = iommufd_object_alloc(ictx, idev, IOMMUFD_OBJ_DEVICE);
> -	if (IS_ERR(idev)) {
> -		rc = PTR_ERR(idev);
> -		goto out_release_owner;
> -	}
> +	if (IS_ERR(idev))
> +		return idev;
> +
>   	idev->ictx = ictx;
> -	if (!iommufd_selftest_is_mock_dev(dev))
> -		iommufd_ctx_get(ictx);
>   	idev->dev = dev;
>   	idev->enforce_cache_coherency =
>   		device_iommu_capable(dev, IOMMU_CAP_ENFORCE_CACHE_COHERENCY);

Functioanlly, it is harmless since device_iommu_capable() returns false
for noiommu device. But conceptually, it is nice to move it to 
iommufd_bind_iommu().

> +
> +	if (!is_vfio_noiommu(idev)) {
> +		rc = iommufd_bind_iommu(idev);
> +		if (rc)
> +			goto err_out;
> +	} else {
> +		struct iommufd_group *igroup;
> +
> +		/*
> +		 * Create a dummy igroup, lots of stuff expects ths igroup to be
> +		 * present, but a NULL igroup->group is OK
> +		 */
> +		igroup = iommufd_alloc_group(ictx, NULL);
> +		if (IS_ERR(igroup)) {
> +			rc = PTR_ERR(igroup);
> +			goto err_out;
> +		}
> +		idev->igroup = igroup;
> +	}
> +
> +	if (!iommufd_selftest_is_mock_dev(dev))
> +		iommufd_ctx_get(ictx);
>   	/* The calling driver is a user until iommufd_device_unbind() */
>   	refcount_inc(&idev->obj.users);
> -	/* igroup refcount moves into iommufd_device */
> -	idev->igroup = igroup;
>   
>   	/*
>   	 * If the caller fails after this success it must call
> @@ -294,11 +336,14 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
>   	*id = idev->obj.id;
>   	return idev;
>   
> -out_release_owner:
> -	iommu_device_release_dma_owner(dev);
> -out_group_put:
> -	iommufd_put_group(igroup);
> +err_out:
> +	/*
> +	 * Be careful that iommufd_device_destroy() can handle partial
> +	 * initialization.
> +	 */

no native speaker. This is a bit strange to me. I think the comment 
wants to highligh that iommufd_device_destroy() can handle partial
initialization. But the above comment seems to warn something...
how about below?

/*
  * iommufd_device_destroy() handles partially initialized idev,
  * so iommufd_object_abort_and_destroy() is safe to call here.
  */

> +	iommufd_object_abort_and_destroy(ictx, &idev->obj);
>   	return ERR_PTR(rc);
> +
>   }
>   EXPORT_SYMBOL_NS_GPL(iommufd_device_bind, "IOMMUFD");
>   
> @@ -512,6 +557,9 @@ static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
>   	struct iommufd_attach_handle *handle;
>   	int rc;
>   
> +	if (is_vfio_noiommu(idev))
> +		return 0;
> +
>   	if (!iommufd_hwpt_compatible_device(hwpt, idev))
>   		return -EINVAL;
>   
> @@ -559,6 +607,9 @@ static void iommufd_hwpt_detach_device(struct iommufd_hw_pagetable *hwpt,
>   {
>   	struct iommufd_attach_handle *handle;
>   
> +	if (is_vfio_noiommu(idev))
> +		return;
> +
>   	handle = iommufd_device_get_attach_handle(idev, pasid);
>   	if (pasid == IOMMU_NO_PASID)
>   		iommu_detach_group_handle(hwpt->domain, idev->igroup->group);
> @@ -577,6 +628,9 @@ static int iommufd_hwpt_replace_device(struct iommufd_device *idev,
>   	struct iommufd_attach_handle *handle, *old_handle;
>   	int rc;
>   
> +	if (is_vfio_noiommu(idev))
> +		return 0;
> +
>   	if (!iommufd_hwpt_compatible_device(hwpt, idev))
>   		return -EINVAL;
>   
> @@ -652,7 +706,7 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
>   		goto err_release_devid;
>   	}
>   
> -	if (attach_resv) {
> +	if (attach_resv && !is_vfio_noiommu(idev)) {

how about the iommufd_hw_pagetable_detach() path? Does it also need to
check noiommu device?

>   		rc = iommufd_device_attach_reserved_iova(idev, hwpt_paging);
>   		if (rc)
>   			goto err_release_devid;

Regards,
Yi Liu
