Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3232836A6
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 07:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777361913; cv=fail; b=O7Y1t+PvKh5ISpDE7zkAO0MkymKIQrmYrsvumtlBb9+J0F4LI/bDKXBT0tjKTAe+suu/hj7+VlAa2Vwqxqe4XWnCbG047QGKxgVngtYVRl7krXUbNR6045AyIrWN3ANpsEZx/ADEbYwMiHDDdBxFNzlx10WDE8HmzFRadL+gSgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777361913; c=relaxed/simple;
	bh=5PKhbvi45+qypNV0cJGGycpdFAsqGUUDUlQkpXuq5Q4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZgTfLB4FUaUx26ri9T5qxCDekCSdkv6N6q0j+6NWffcqM7JH1kbVIywsMt0hl6UAJgNhlD4CfsHdJVmmtKZCm6Ahm7x0AupkAtfpaPwzsVHCC/jP+yFCkhu5w2H7qCSw4LCybSrSLMB9UpXvoa8ksGMDgS2auFjHIGO5uREvnpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lSKVKj0D; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lSKVKj0D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777361911; x=1808897911;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5PKhbvi45+qypNV0cJGGycpdFAsqGUUDUlQkpXuq5Q4=;
  b=lSKVKj0DxDwnwwTQad96sP0TKgA/Pp0lQ4s579+e5CfUNmVjc3jIyVbD
   EuBW/taKERqN/EeUL+PfnBA67rPizrhGKeC23M915SmIitMCxR0JRn4T1
   rP+hjAATfqvG5Zy2GTtMDFksG5oPoFHr93PAPWMrMKhxZZSpWRQ31ex1p
   1c+2fUIxuUR5IefxfxykD8bngU6CpoZ/YrQqJTdIkmSMk9V2yKeCIgXI9
   wSqO9SuOpjtBLUVOCfbT0n/3TUqAXg4nmg4QtXFAj/5zLz4ABKqCwGEic
   8c5Zmnkcy+lscDOvc6jXhVmtrI/wHND+M0K6HLsU0ovuu+mkZIVkPX6Ka
   A==;
X-CSE-ConnectionGUID: QzEMdMpsReGsno9HSk/OCQ==
X-CSE-MsgGUID: Ia5gEFN1QAOb8vIEEF71XQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="95677385"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="95677385"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 00:38:31 -0700
X-CSE-ConnectionGUID: D4C81LmMQS6gsHgcbYbMdw==
X-CSE-MsgGUID: rLudtz20TDKQirCYjaOygw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="234157741"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 00:38:30 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 00:38:29 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 28 Apr 2026 00:38:29 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.44) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 00:38:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qg82cSs45eQZNwMJUGMMEKHEet7gd5UVv9JZ3t8zOQDo2jlezoLCJ/Gcmz7jtKhKN+yb6ZRNK9/iI1dU6rBF8W8d9msJL2VOsgB/n+oLLctRJdUnTm2eGf+fHrY4E/n77qqhhwae9lwGo9YG1ulIKg2Jz/MXc6JCpDYWK+VI7uS8RAkGmCj/zv6/qHJceahfVhMMO8MoTESdACqhkF2Y+CT7hDQ4M8SO7/+DTd/ID/neb7OqJOT4zkwleoKoA/OVmWNJOVjkf7M/5dPPzJ6aaQwCcSnVwMY6LNDv+HvFvaMr5DGet4p2MEI0i2yuRJG5Bbvg2n/9cbXW2x1S3UM/eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GtTGU3cp7n32PQVH6Z+5AKveara06IvtbDhfqYJsSHY=;
 b=SUJJAp2ey8iQa10n7NebvgU0NLfH3zztop1eeTyaCtLyF3l88MUldTSa9cDyH/N083sOlRlMa1jPrjQJ8NPt2aTvlfuJDeEz3dJ54C0/C64yx8iY1ezBjgrjHE5E0yzmtuWnY++mRyDkf6ejEqgkpZAEv6nvajmco01/ipfT6O14xpuaWQikuxSK9N56SLWE2dZI3E9zSKnjPN7HNUrLv8P9cfsGBWYY29BZy9UMsgn0i+qskfCTNkoprpSVuPxto405VQmxG9032DmChs5S9IcESmMXwOEjdc5cLZ8QS0eQymdAgXV4h01V9oU2OEqTub7KTN+kiMZS5lqsP/w3kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by SJ0PR11MB6696.namprd11.prod.outlook.com (2603:10b6:a03:44f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 07:38:19 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.20.9870.016; Tue, 28 Apr 2026
 07:38:19 +0000
Message-ID: <b82b7f9e-befe-4a45-b242-6d6df0e70bd4@intel.com>
Date: Tue, 28 Apr 2026 15:46:02 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 10/10] Documentation: Update VFIO NOIOMMU mode
To: Jacob Pan <jacob.pan@linux.microsoft.com>, <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Jason Gunthorpe
	<jgg@nvidia.com>, Alex Williamson <alex@shazbot.org>, Joerg Roedel
	<joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, David Matlack
	<dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen
	<nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>
CC: <skhawaja@google.com>, <pasha.tatashin@soleen.com>, Will Deacon
	<will@kernel.org>, Baolu Lu <baolu.lu@linux.intel.com>
References: <20260414211412.2729-1-jacob.pan@linux.microsoft.com>
 <20260414211412.2729-11-jacob.pan@linux.microsoft.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260414211412.2729-11-jacob.pan@linux.microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: df6ab604-9fd8-4422-fbe9-08dea4f91e2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|42112799006|18002099003|56012099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: yE4CFaRX1OYpZz2carUvKSrtieyieCPpZIma1lf5FuGC+E/hs0JwOiQdhBSSN2DrrDxKtZGvmDbhCwLMKyC3PTpujKvutVAkOIhQtFCvgXqkGKGmBgVOv3IjQ+mQq133lWbduStdshoMfcgHo1TjFGmqHaDI0ZlyPqqgyhGeFzcr5rovXW1Z92shSoXzXpAQ3E9O8qocgBG+GzTzYnXxkJHyxdEzjQyPyzQEazEL6Gpg7P+RpP3cRtl4QW2NAi5jAwRumdh5ae8Q/ec9Z6hYjrLoDOsI5Aq6xvaVthxCnUHSKiTbhFrYkhDi1qg/EGzlNbwtejgXBCVjzck732E5S9iXyHp4kSbMQFI5VEzFkX538Ju3V59TzfdKbFNuuExD32YKHw5WE421UkCK5UcOqJTEKPMOzSgRpmGc1+kBN/9tSWMRAF4fKQ3RThn0csMqRAnenJtZzLdfMPULbYaT58FTag0rPiLbN/lThQLJLdYTdh02fONY2FXdwEeStjf8qoSfEtvZPDfdfv3lIcYA4KPS5RBQVddy+GbtYMKBItANg8EdKcF0mZPFzQrkwesW4fyjTPvPwzQHvNYDXICuE4HA2OpsyfXN4i9HUpFC9z9p9EUrU+Pk/eMCkBRpgVSb8UFXgpSw0bl3nTDt1hSCGv5UDF79RJz8RudwITi+MNKU7C924fdVIqvLDE9LlEoTOQxB2jOZdX7BUUdwIrvi0H0pEepjrPx7hqIF7mKoQwBb/SnrKDozkIaf/a8cGmrifJdfaYoxJk17vlhxpEHkNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8509.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(42112799006)(18002099003)(56012099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVNOckRKeUFIaENJRmFXKzZnbkRSd0lMKy8wZitpS2lGdHFWNjB0Q2RYQXI1?=
 =?utf-8?B?dktFUFovU0Qzb3h5dzM0SDRmS1R4M1g3bUhFMkdjbUp2WkUrU0FRcFN4VWhO?=
 =?utf-8?B?dmFPQVhQZDNKRFRrZzAwMUh4YSt5NEQ3QzBVSHBmL2RCc1dMZnpteDZGV1Vn?=
 =?utf-8?B?elp2ZEs5N2dFZW8zVFpGTlNPckxnTnJsVGtmS1AyT2FPZ0pKWnRXM0hOY0ZC?=
 =?utf-8?B?LzZHV2t4MmhNRy9lbVRDTGp0bjQ5L3hpQi9TWWUxVEZzekRWZjJzNDdYWVBV?=
 =?utf-8?B?V2FWem96TmRpWDhOMXJJWTVmbDlsUjc2RHRpdGdEaTV3Rk8rVU51ZTdCUDB0?=
 =?utf-8?B?Z0xqWWJITnhwQXVPZjJ5YTNJWS9nci9LQUhQdW4vUjFFUlYzYzlrdzBiZnFP?=
 =?utf-8?B?YkNsMlpvTEhxd1JVM0JXUmpOcnlEaE9QYW5PRVVEZlAyQWd0SGNkV0s2cVVH?=
 =?utf-8?B?M2RjelJLYlkyUXRQMmFmOVVCK3ExRWgyakNrRGk4cDNiU29wZEhPZlUxQWxV?=
 =?utf-8?B?K3IzSyt5ZkQ1dXZMaFdwT2tuQUZ4YzdwSEUvUWJXbTE5ZEdKb3lpSktYampj?=
 =?utf-8?B?NS9PcmlhSzQ2cTlqKzFING1ueUhDb3VUL0o1enhkRDJUS0c5OW54N1Q2TWpR?=
 =?utf-8?B?QXJGOHBFRjdKdytUKzNBNFplM0FYSWdxM3pORVl4KzRhcHpuaytIWVlQRFVv?=
 =?utf-8?B?UWJKaUVENFVac3kybzB2RzFyLzUyWExNVHBZSk5PNHhDdnpVT0RCWDI4cWtI?=
 =?utf-8?B?c0laOTNrQ1pjYmYxUHVxMDBiNzRyRVhOK1lKM0kzSXpNRWJBM0I1SVcxSzRL?=
 =?utf-8?B?ZExoZTFOM2ZnOTdwdXRRUDZMclhtTEhKTnNZZmcrdW1kSW5ia0xOMTlrVFU4?=
 =?utf-8?B?OUZOdVhOSGpJVFdQOU8xdmVjbW5zUUR1N1RzWjN5THhDdzBBcE56MTc4SzNO?=
 =?utf-8?B?MS9vM1BYZDN5TEJkZk05QlZYV3dXaUV5ZnBrV0g5d0xjUXdlOXFGWEV2K1Ra?=
 =?utf-8?B?UUV3eC9zUUVOOFNRaVRRS0dLR3hQdWo1SnVob2prazNQQVpWRE52VnJYL0s4?=
 =?utf-8?B?bVJROW9qVmZUQ3R4bGVvV2pMYWhRZU03Z3FvS2FVcWNMRklkZXNMd25sdHdh?=
 =?utf-8?B?M2RJdWloV1BVMXgxOFlLcHFzZzhjNzIyaS8xUmtqMjZ6cGx5aFFsV0srTGhj?=
 =?utf-8?B?enJJY0duR01XMEZRWUVESTAyUWwrMjUvYWN6OUFETkFFdmZRdXRzQVJhU0p5?=
 =?utf-8?B?N0VsaXlWaDc5QmkvYTFaWnRaNVArRFpCL2VsQ1V4NU1VSkdUc05EMXB0ZllV?=
 =?utf-8?B?Y2g4TndlWEFjUGVYZ0lJbjU2Z1lXZEExQjZNMFIraUtnS3p5OWxSVDQ4ckZO?=
 =?utf-8?B?V1hoYnVmOGNBOGFjY0MzMXd3WVN5TVQ3MFRyS1hsNU5rRXMzNHZiSTZlMzRQ?=
 =?utf-8?B?TndHQTgrMjZBWHhValJlQVB0Tzg4QTNvVVhObkxudnQ1Qzd0VWVKenBSNVVR?=
 =?utf-8?B?cVBKVlNibXl1UkdKRGhjNGpIbVdmcXBnNkdRTmhkK1VSSTkzSGZOdm9iTGJi?=
 =?utf-8?B?SWcvd2syNEtBU3doT0tmZWZnRkprY2dGQ2I4OXZ0clIzVkw4RWk4TUdqc3lC?=
 =?utf-8?B?Rmx6eGRJT1p1ZFJVbUQ0bGZGa1ZQenRpVHlFa2Z5Wm5GRXNwNG9OamdZUmhV?=
 =?utf-8?B?QjIyOTRlcWY2N0RWV3VLSlJpakJybGMvTjdFcVgwZnRPOGpzOVFaV04vcGc4?=
 =?utf-8?B?WHFlMXRyaVRPaEQvWS9KOXJvVHNmUW9SSkhocmZKWHI2SThvcjRGR3NWalJx?=
 =?utf-8?B?Sms1b0RPK0VmOWx2WUZCWGxYZHFIM0ZNMUpGVitKUkRZTjhpL25Db3p4c3ZY?=
 =?utf-8?B?NjdvNTkxVTVwYVFrVDliVE5McHd0QjVSbFg3bTl2dXJ6MEkzeTZwUkNOTXRC?=
 =?utf-8?B?SUxyaWd3WXo3aEIzQXlPZHg2UFBDdXRsMHUrazhpSEFCT2Q5MTBlZFJOWVNE?=
 =?utf-8?B?Wjh6aVZWTm41aVhOSVlSMGd2dWJtazhsK2ZZK1lEdGk3VWRBOHRScFVCSDFn?=
 =?utf-8?B?MXFLeXlmcStNRFBxMFpOSFhFa1pwSHgySHF1cFprd2ZWZEtlMGZUemo1eGhp?=
 =?utf-8?B?bk9nR1JKZTZ4S1pLdzVud1dpaWkzTEpwd2hya2ZTTUJ2NDkwL1lyU3dsWVdQ?=
 =?utf-8?B?cVo4UFhxNVNydTdJd2YyNkNOZGE2ejRQZytOQVpnN1Q2eUZ0Nk4rdEM2RnRv?=
 =?utf-8?B?akZrZkEzV0IyTURKbHZraU01Q054NVdienh4Rk1aMDdCcHpYTnRDSEVoYUpB?=
 =?utf-8?B?VGYzVllnMlJ2N2dKa216dld4Sm9vazBiMnFPV1ludHFobFMwUk1Ldz09?=
X-Exchange-RoutingPolicyChecked: qKOIrG8dOCiwRbERdlmC52w+IjF+m7skPiHiqK7892f1H7KYEmdrju9yO1g/FgtEMKw9ZexxE+9+cc+32HltxhXNikTBdB0KjBrt4wzX6+U9a9u5JxbEpaxkT3HTupaDzmNELveoBLgGM9tXIizCC6RTBFDaIDFy57ku99tuUnaPcG5jat56eUPJA/M7Eq7WGVrVTOka6QMfx9oLRvhvozdwWuql0yiZHU+mC5MCoykvRSWqTTCfpeEBAT4zCCfoMlzYov/TtYrOvhGCe6/7cpnJM5q3j0sOPbJYEOKFqnOa8BCYUsIqlZDD8e7ToWDXrGymerUlSV8kEMYMqCEx9A==
X-MS-Exchange-CrossTenant-Network-Message-Id: df6ab604-9fd8-4422-fbe9-08dea4f91e2e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 07:38:19.6514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MWGt3kf0/AFzaY8tKNi0W4+h6UI7RTK9TeRMKdvaKvFzMmPFhbAgRsfcmnWxgt88SZINRGoj1skF5dJ5rHJlHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6696
X-OriginatorOrg: intel.com

On 4/15/26 05:14, Jacob Pan wrote:
> Document the NOIOMMU mode with newly added cdev support under iommufd.
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> ---
>   Documentation/driver-api/vfio.rst | 45 +++++++++++++++++++++++++++++--
>   1 file changed, 43 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/driver-api/vfio.rst b/Documentation/driver-api/vfio.rst
> index 2a21a42c9386..da6f77414c3b 100644
> --- a/Documentation/driver-api/vfio.rst
> +++ b/Documentation/driver-api/vfio.rst
> @@ -275,8 +275,6 @@ in a VFIO group.
>   With CONFIG_VFIO_DEVICE_CDEV=y the user can now acquire a device fd
>   by directly opening a character device /dev/vfio/devices/vfioX where
>   "X" is the number allocated uniquely by VFIO for registered devices.
> -cdev interface does not support noiommu devices, so user should use
> -the legacy group interface if noiommu is wanted.
>   
>   The cdev only works with IOMMUFD.  Both VFIO drivers and applications
>   must adapt to the new cdev security model which requires using
> @@ -370,6 +368,49 @@ IOMMUFD IOAS/HWPT to enable userspace DMA::
>   
>   	/* Other device operations as stated in "VFIO Usage Example" */
>   
> +VFIO NOIOMMU mode
> +-------------------------------------------------------------------------------
> +VFIO also supports a no-IOMMU mode, intended for usages where unsafe DMA can
> +be performed by userspace drivers w/o physical IOMMU protection. This mode
> +is controlled by the parameter:
> +
> +/sys/module/vfio/parameters/enable_unsafe_noiommu_mode
> +
> +Upon enabling this mode, with an assigned device, the user will be presented
> +with a VFIO group and device file, e.g.::
> +
> +  /dev/vfio/
> +  |-- devices
> +  |   `-- noiommu-vfio0	/* VFIO device cdev */
> +  |-- noiommu-0		/* VFIO group */
> +  `-- vfio
> +
> +The capabilities vary depending on the device programming interface and kernel
> +configuration used. The following table summarizes the differences:
> +
> ++-------------------+---------------------+----------------------+
> +| Feature           | VFIO group          | VFIO device cdev     |
> ++===================+=====================+======================+
> +| VFIO device UAPI  | Yes                 | Yes                  |
> ++-------------------+---------------------+----------------------+
> +| VFIO container    | No                  | No                   |
> ++-------------------+---------------------+----------------------+
> +| IOMMUFD IOAS      | No                  | Yes*                 |
> ++-------------------+---------------------+----------------------+
> +
> +Note that the VFIO container case includes IOMMUFD provided VFIO compatibility
> +interfaces when either CONFIG_VFIO_CONTAINER or CONFIG_IOMMUFD_VFIO_CONTAINER is
> +enabled.
> +
> +* IOMMUFD UAPI is available for VFIO device cdev to pin and map user memory with
> +  the ability to retrieve physical addresses for DMA command submission.
> +
> +A new IOMMUFD ioctl IOMMU_IOAS_GET_PA is added to retrieve the physical address
> +for a given user virtual address. Note that IOMMU_IOAS_MAP_FIXED_IOVA flag is
> +ignored in no-IOMMU mode since there is no physical DMA remapping hardware.

not quite get this. Does it mean the the iova field is not used when
invoking IOMMU_IOAS_MAP ioctl? Hence the iova will be allocated by
iommufd and returned to userspace? Also, how does kernel know it should
ignore IOMMU_IOAS_MAP_FIXED_IOVA flag?

Regards,
Yi Liu

> +tools/testing/selftests/vfio/vfio_iommufd_noiommu_test.c provides an example of
> +using this ioctl in no-IOMMU mode.
> +
>   VFIO User API
>   -------------------------------------------------------------------------------
>   

