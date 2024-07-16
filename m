Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493AD433CB;
	Tue, 16 Jul 2024 08:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721117213; cv=fail; b=LvEFQ8F58CaPztJyyHRp2QkraRn2VMUjWkgiunKLN5Idr3EpMFCPxa0ciClqPbNbdHQJ2rFOYggetjHZUhXGHFdZfw+uBm9IcAJ+mbQTIyZMk81MfR8ublMZywFKpQBy7KGs5SxJczs7bf/9REPmQtHe5u0W3tOfutEtHfQf/H8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721117213; c=relaxed/simple;
	bh=upAorxqvJWtRWN/xkpnhiRuqJ9H0QWCuIub0gZ8lBwQ=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gMZHp81g/+An6ZNeTMpMWlVaxg9QVc7nfbOnMzG1qKz6ScdNHMaZJqNoJwgmy+UZCJ64L0MB/LlmEtZih/fld2gxe89J/GpsH9l69Qc79EO/exIaPmRtWV2H+E1z3rMqb3aaNHINvC1bWn99nkprbDt8PQQCEmWDSrJ8iGvj6xg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oo59Mfa6; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oo59Mfa6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721117212; x=1752653212;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=upAorxqvJWtRWN/xkpnhiRuqJ9H0QWCuIub0gZ8lBwQ=;
  b=Oo59Mfa6WYWpwPwkyOX91PdUr64veJjXZbZeZkh/L0ZA7Ls89gb3DcZ2
   hr+XAryO3A1TsRumfvtsSOWCcNhSRKsfPPic3L4fmMnQ2vlpjy+qz1lKq
   ADbdIxIHj7hwNE8CnB7+v+uhixa0mbQ5WDj2OR54nqyoM9UKK67CGiZ04
   UUzSGmbvOo3g3nRlOlCQGEuyYKkPn+VImMy0TPB12WPMvdpOKB8l0Peev
   6NBugNTYHSHKxwzIxc5RfTHw0OgIFsyELPkAvgAwT001uo1ieF+ib52Pf
   RDYVYUdHM68FKQdVXcCTAbqtDL+6M1S0Mdjy9iTHWFzDEzAUJxB9xcVLW
   w==;
X-CSE-ConnectionGUID: zZfiCtukQAKgNxRYoXizNw==
X-CSE-MsgGUID: gIUsy6QURECMomDfvl3lwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="18669235"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="18669235"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 01:06:40 -0700
X-CSE-ConnectionGUID: OuoC8mvHQLu1Dz8U7nLPwA==
X-CSE-MsgGUID: f3c78SciT2iyf/EFaQZ3Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="54177864"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jul 2024 01:06:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 16 Jul 2024 01:06:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 16 Jul 2024 01:06:38 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 16 Jul 2024 01:06:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C/zG+PWjsGHHFiD+mUbsC5QBy34Yg2Lvv/0kSMq7XFY86pWXUQ8/ulQW40vVu9LXcet6UWQyLY6zvdfwfYmBcToyKbKX/nRWWF4B3qPtRKKW7uYsxzSBEWKiH4QzUcY1gimwgUXA7VH8AM1ZSwwahwdKcZwT77fvwyXv7mlTkeMsvUPr8GlZlHg0VVLTc9j8MxexJWZ3fKj6K1b2cjBz3ZVkbFeVkjU8oPSTrDxHIiOsPAyLej8LTdwva/YQEtNQX4+52JM5PwyDm1glUEG4xqm0a4/ZLvcnok7Du3v4pl6X0pkds/V6yiSTONAOs9gC1x+8DmVT3Ui1ifyHaW9pEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJ/jiokmShCmJpLwVdv6TU0hoYcFKTC9PcyQi0GTPlc=;
 b=xWZ2kNP9ypOl3f3Km8k2SGNgAw7NM/H+EmMlYhbX+bwyqOysD6MKGLZ/dPTWXf38SRrnMfz+0YRwF7pkhJjoZKytgdKji0La1CLC0DfybAgJ/JIfwbxhhOWI9IRizWgoXMX26b7U6vLxmt6MkYo5UpK6REKlf3sjOur9aHsa37ZF+1f1mA+ZCkh6Wrwhd8kvL+OqfhMjumjwDnOk3czLZ1BB8CN4jMWX3hQhaqk+0uYz/pYD+EbXkIhQdBdDkVl75P2Wrsx95AteMbWXEJZcU4igGubwSDgJ+FZIPkl8v/kMk/UvW9NXFvptRBs05o2zzZjPHSgOhnMO6KEDQpbW9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW4PR11MB5871.namprd11.prod.outlook.com (2603:10b6:303:188::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.27; Tue, 16 Jul
 2024 08:06:35 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 08:06:35 +0000
Date: Tue, 16 Jul 2024 16:06:24 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <devicetree@vger.kernel.org>,
	<iommu@lists.linux.dev>, <robh@kernel.org>, <saravanak@google.com>,
	<klarasmodin@gmail.com>, <aisheng.dong@nxp.com>, <hch@lst.de>,
	<m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
	<linux-kernel@vger.kernel.org>, <will@kernel.org>, <catalin.marinas@arm.com>,
	<kernel@quicinc.com>, Oreoluwa Babatunde <quic_obabatun@quicinc.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH 3/4] Revert "of: reserved_mem: Use unflatten_devicetree
 APIs to scan reserved memory nodes"
Message-ID: <202407161521.ec4d9668-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240708230613.448846-4-quic_obabatun@quicinc.com>
X-ClientProxiedBy: SI2PR01CA0005.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::23) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW4PR11MB5871:EE_
X-MS-Office365-Filtering-Correlation-Id: 9104d6fd-5b75-4ea0-cc8e-08dca56e3634
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LqBpMZcjGFL1V7SC/8O0FSr4hE0RSMbbzdzQIFNcvor5DN3lT6z1YZ7SxrP5?=
 =?us-ascii?Q?0pBaiAm5bXCaF5aU0cvbgWSIjvY81eFoq1gcpvYrarAhRBT64c2ctXaY9c7O?=
 =?us-ascii?Q?K2xUQXhruYXPZC7lj33fLCUOk1M0zA/KM945eWDC354UWf4qZAzbZ53sx0OO?=
 =?us-ascii?Q?IkFTLks0A/Kfko7VASOhPiHl9YMi8vXYQ7LhbVKwfO2ASjTdiVG4swTofpTV?=
 =?us-ascii?Q?SmPI8CGI2WNj21BOo7wYCqKu2/gZgd3iiTHirFLuzJj76jtZlP79Np9MmuM5?=
 =?us-ascii?Q?08YpGuP4RZ7tajEyZt86xrDIGKzTGoVMoK62ahmLmPr7jxXnXhJtk8qCKHY3?=
 =?us-ascii?Q?RJeV14xZeAB3CuISIlXEuNHWVKZJMDWZaIyK9cOtLvy4q83fUoVqpvnWhRML?=
 =?us-ascii?Q?ngkb1wk0LWJBWIcMqkO2h4ICEhxJA9zF5+1+GRz0NbT5t33gM1+BcHWRQVPs?=
 =?us-ascii?Q?bM8vC3pFFaUSkHQlyW6/Vuu+DS6mdOQynvbKzafRiwNshX0Nlmb7wF9BdD/p?=
 =?us-ascii?Q?6XB6XiFMy/TV93nyWcNaKYn1pxO7Sr7rHTwV+wVnryVwQLn2SgMy3Tqqwf5l?=
 =?us-ascii?Q?3TTruJkNRvgH5+/BMvKQoWZpvRX4tnn8iwHSNiIvsg91SZcaajVIYxvWgH95?=
 =?us-ascii?Q?2v4yxSj2Qh+vXUDfjBTuEtMO46kFlGPOgA46kIPAGjwZZw9N2Sl/gi9x17++?=
 =?us-ascii?Q?FFYD+jsbJp/Gr6Cq6xwYc0hWL3rvLtLLeRsCmTjGnlEj7TjX0NYamtOJROX1?=
 =?us-ascii?Q?xNoYZ50iXjyEMeIw0fus4RujABuXyC0DSdUzSMCDZe7yrzHU6w2z2meHOeSl?=
 =?us-ascii?Q?s7dTRFMg6K3PCGvVlOFO5/nOHe5eEMeM9fp5twEVbpN4X3CFktq5flzHjdfJ?=
 =?us-ascii?Q?/JgURAnJvVYykISaSMUeOyqP8bFKlhFidoZ9aYzGlAKLxyrv+ypWfvBXVveM?=
 =?us-ascii?Q?tWs9+WZ0D3bDShAVqzOdCdG9wP1misjSyKO06NACmbWjZNRd1kZ9Ou0eA04p?=
 =?us-ascii?Q?XYXKmPHS0hUIRyLZ3IwpLRGQ5eDNgqHtqEC6mWpth+/eDIKGW6d6XMsejOPL?=
 =?us-ascii?Q?wOJolMEDeXxw/ma2Wws6FH9YS3YUbHItJTeudkOVZzLrmFK2cOQ4Er/uak3Z?=
 =?us-ascii?Q?H5SXy8WamzSb7H5K+Ly9S42yET8jLXJT8C40RuDtred9ZnYyCGKxhqQyUcor?=
 =?us-ascii?Q?YmVBv0VnbWU9RWLhbWkAm5p0VAok5q41TmBfAKw3Vvo+ySciHSmwk+LMtNnv?=
 =?us-ascii?Q?+p52KEv908rBOLiKhPyT2CyWCDAtQixg0pXUv/KnxDcm+Zq2dDjckexIVCTH?=
 =?us-ascii?Q?IRgQxlOtADxdwAoGyzDI2Ejc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DtOmO/CfFCp+KCEzSdC6LgIKJz+3YkjMFnU1oDwyfWKUNM/XgEua6MiWiahp?=
 =?us-ascii?Q?JQczmMAhqb4e619uzkRocfPrwAnfhQO8d4Gg2R4uRkArqR/QsCNAHe2luFgS?=
 =?us-ascii?Q?zq/ZPAs5CJjVkErcwWZUGxqsg0gugHcZes1G/2SDzcWVVIdj+h4mbtXTrdt2?=
 =?us-ascii?Q?Mn/sEXYOmM+qrQgDJioAS+5rd+NRQCondhUFCdrLPaij0W7d2o16phP/OBEn?=
 =?us-ascii?Q?166ObiWb9tdVX66VFYV3vuWWORZTiwFV+iKGyT5ndNZfLK9DWMqrQPzN8dj9?=
 =?us-ascii?Q?zFxnAZnPCNiG2l712Qf3vBlNDj+ieq5XDMWTIk+n2Z1gpUAIE0Kk12tB/573?=
 =?us-ascii?Q?9t5LAPfvr5Gtw4R47N+QRkZUueWjjMqqmw7BBNvwI30Ub2MaQLidACUgjRpn?=
 =?us-ascii?Q?AsbjmUh471wQ5oagkGtczK/nnthS5gVjt1LppWPX7/3WF9ZU99UVc2iQl4TD?=
 =?us-ascii?Q?QhivmSjWCcfbq3/rMdhE5kwwbtfrPLPN3oqWcAoC4SdkN4KNpcZVNho4/KjT?=
 =?us-ascii?Q?SJ2qqlEKkoGZ15/+Oy0Rvz7z88QSC6Ocl1bHBS2qiww7CAeMgYV+N3MeEMBi?=
 =?us-ascii?Q?lNHqCTaYe0v6Zj8EXxuH2pYMOhPo2oYbrZlMBZMSkjfp3oaRKVeVUQbvdCUF?=
 =?us-ascii?Q?+jdB4XOqEWDLAitA0oS4qvUB6sGyUoAdODu3YbpHwyKuZe5p1v8bUVyxOuMi?=
 =?us-ascii?Q?KBC2mgfQ+6LpXnH/1Q1VXsPSkiu3+PwAbZyFtRVxHZK9gKrVr40i1ZQx0Ky/?=
 =?us-ascii?Q?S2vDK2yaSq0FBhQXfe6eqCJKrIfk3M7C3/5tkc0jR+4w93fTnjoi8A+y0Mpr?=
 =?us-ascii?Q?2IoamN3gLBvtZ5nv7X9/ACt7qNZ6Xy81GFeD47QS5Th2SK7EzEdu8K5ZgoRe?=
 =?us-ascii?Q?EUVUQRsKlmaLMMYvQzxYo1GpmvqO70LS1NYbqFX2iNkHOu/wKuy4BTYIxXcy?=
 =?us-ascii?Q?kxFGaRAA6whANoVulFCwsVRkNrNrIs6CmNqGTAbxGnswQGmALVezEjxODkli?=
 =?us-ascii?Q?Lwb1DpmRklSt+dbMZh8fNWOTMyQdoIMK3aB1U/bhgDAgf1F5dpFZumvjSCPP?=
 =?us-ascii?Q?aMEu/UigH4Af3gQwOVgaFIcwUeWjci/L4JBBN/pEIKCIv1IRDepI8OXmPxp+?=
 =?us-ascii?Q?Hc+w5l+m/gfBe9cTiV2mibhfp5PYzQe2WucFY8Ec/cU/WeE2PtMf35uX5ZvK?=
 =?us-ascii?Q?t8vvpUFCYOsEps8WwTzvJAtZg52C5AQkudoiz8vB8Go2396XEta+ZFai+khv?=
 =?us-ascii?Q?oOF83MvNxN5WjOeBa3PcnpvBUiSqAylLzjfvRGTs5MCVFm6XFW5ba2gE+8iK?=
 =?us-ascii?Q?uwyvW94zlhCP0eHXUABlZviM8WVlW9F3D0hHeYXk+1mRu8ZtcIDxqqU+w8ay?=
 =?us-ascii?Q?no2zQmPBelMoGuFTChJ3yHINldwWN4f5VQpTQsprIx3r5z15aur8L+Ri+Lu9?=
 =?us-ascii?Q?78YMHYqXNtCxCC7cwT5HNGJbj5rjRheqttlRDUNDxyErvQuhqcKWBiR/BZc8?=
 =?us-ascii?Q?CKUkI/sRqI487m1iFhMN+fsogVK5gsns1gdjGvb0GM0UYHVnlLcYZyo9pVkB?=
 =?us-ascii?Q?fMGBlCsjRF+ssEQU57DMTdV09OEHMusap5NCZZonfyzxiQDh+4oTb+8zji85?=
 =?us-ascii?Q?qA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9104d6fd-5b75-4ea0-cc8e-08dca56e3634
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 08:06:35.5637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3OIisdBddGUowyUMN4WHMj6IfhN3MdFBRGMk6F6e/GGy7u/KTUD195s8A9/05OVgVKlWrfST2Tb9DPI7E0MbOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5871
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:

commit: 50618d443add4eda4aa94c76fb56e72783c260ae ("[PATCH 3/4] Revert "of: reserved_mem: Use unflatten_devicetree APIs to scan reserved memory nodes"")
url: https://github.com/intel-lab-lkp/linux/commits/Oreoluwa-Babatunde/Revert-of-reserved_mem-Restructure-code-to-call-reserved-mem-init-functions-earlier/20240709-073454
base: https://git.kernel.org/cgit/linux/kernel/git/robh/linux.git for-next
patch subject: [PATCH 3/4] Revert "of: reserved_mem: Use unflatten_devicetree APIs to scan reserved memory nodes"

in testcase: boot

compiler: clang-18
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+---------------------------------------------+------------+------------+
|                                             | 20cf0f8c96 | 50618d443a |
+---------------------------------------------+------------+------------+
| boot_successes                              | 18         | 0          |
| boot_failures                               | 0          | 18         |
| BUG:kernel_NULL_pointer_dereference,address | 0          | 18         |
| Oops                                        | 0          | 18         |
| RIP:fdt_ro_probe                            | 0          | 18         |
| Kernel_panic-not_syncing:Fatal_exception    | 0          | 18         |
+---------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202407161521.ec4d9668-lkp@intel.com


[    0.082892][    T0] BUG: kernel NULL pointer dereference, address: 0000000000000004
[    0.085157][    T0] #PF: supervisor read access in kernel mode
[    0.086877][    T0] #PF: error_code(0x0000) - not-present page
[    0.088532][    T0] PGD 0 P4D 0
[    0.089466][    T0] Oops: Oops: 0000 [#1] PREEMPT
[    0.090747][    T0] CPU: 0 PID: 0 Comm: swapper Tainted: G                T  6.10.0-rc1-00046-g50618d443add #1
[ 0.093729][ T0] RIP: 0010:fdt_ro_probe_ (scripts/dtc/libfdt/libfdt.h:? lib/../scripts/dtc/libfdt/fdt.c:?) 
[ 0.095168][ T0] Code: cc cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 b8 24 59 c7 5e b8 ed ff ff ff 40 f6 c7 07 74 07 31 c9 31 ff 31 d2 c3 <8b> 4f 04 8b 17 0f ca 81 fa 12 01 f2 2f 74 28 b8 f7 ff ff ff 81 fa
All code
========
   0:	cc                   	int3
   1:	cc                   	int3
   2:	cc                   	int3
   3:	cc                   	int3
   4:	cc                   	int3
   5:	cc                   	int3
   6:	cc                   	int3
   7:	cc                   	int3
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	b8 24 59 c7 5e       	mov    $0x5ec75924,%eax
  18:	b8 ed ff ff ff       	mov    $0xffffffed,%eax
  1d:	40 f6 c7 07          	test   $0x7,%dil
  21:	74 07                	je     0x2a
  23:	31 c9                	xor    %ecx,%ecx
  25:	31 ff                	xor    %edi,%edi
  27:	31 d2                	xor    %edx,%edx
  29:	c3                   	ret
  2a:*	8b 4f 04             	mov    0x4(%rdi),%ecx		<-- trapping instruction
  2d:	8b 17                	mov    (%rdi),%edx
  2f:	0f ca                	bswap  %edx
  31:	81 fa 12 01 f2 2f    	cmp    $0x2ff20112,%edx
  37:	74 28                	je     0x61
  39:	b8 f7 ff ff ff       	mov    $0xfffffff7,%eax
  3e:	81                   	.byte 0x81
  3f:	fa                   	cli

Code starting with the faulting instruction
===========================================
   0:	8b 4f 04             	mov    0x4(%rdi),%ecx
   3:	8b 17                	mov    (%rdi),%edx
   5:	0f ca                	bswap  %edx
   7:	81 fa 12 01 f2 2f    	cmp    $0x2ff20112,%edx
   d:	74 28                	je     0x37
   f:	b8 f7 ff ff ff       	mov    $0xfffffff7,%eax
  14:	81                   	.byte 0x81
  15:	fa                   	cli
[    0.100859][    T0] RSP: 0000:ffffffff83e03e28 EFLAGS: 00010046
[    0.102634][    T0] RAX: 00000000ffffffed RBX: 0000000000000000 RCX: 0000000000000000
[    0.104925][    T0] RDX: 0000000000000010 RSI: ffffffff83ae68e5 RDI: 0000000000000000
[    0.107172][    T0] RBP: 0000000000000010 R08: 0000000000000000 R09: 0000000000000000
[    0.109427][    T0] R10: ffff88843fff2200 R11: 0000000000000000 R12: 0000000000000000
[    0.111656][    T0] R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff83ae68e5
[    0.113969][    T0] FS:  0000000000000000(0000) GS:ffffffff83eb3000(0000) knlGS:0000000000000000
[    0.116389][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.118314][    T0] CR2: 0000000000000004 CR3: 0000000003ea3000 CR4: 00000000000000b0
[    0.120569][    T0] Call Trace:
[    0.121512][    T0]  <TASK>
[ 0.122317][ T0] ? __die_body (arch/x86/kernel/dumpstack.c:421) 
[ 0.123615][ T0] ? page_fault_oops (arch/x86/mm/fault.c:711) 
[ 0.125110][ T0] ? console_flush_all (include/linux/rcupdate.h:? include/linux/srcu.h:232 kernel/printk/printk.c:286 kernel/printk/printk.c:2986) 
[ 0.126609][ T0] ? exc_page_fault (arch/x86/include/asm/paravirt.h:687) 
[ 0.127940][ T0] ? asm_exc_page_fault (arch/x86/include/asm/idtentry.h:623) 
[ 0.129365][ T0] ? fdt_ro_probe_ (scripts/dtc/libfdt/libfdt.h:? lib/../scripts/dtc/libfdt/fdt.c:?) 
[ 0.130637][ T0] ? fdt_path_offset_namelen (lib/../scripts/dtc/libfdt/fdt_ro.c:256) 
[ 0.132233][ T0] ? fdt_scan_reserved_mem_reg_nodes (drivers/of/of_reserved_mem.c:?) 
[ 0.134085][ T0] ? fdt_init_reserved_mem (drivers/of/of_reserved_mem.c:550) 
[ 0.135650][ T0] ? x86_flattree_get_config (arch/x86/kernel/devicetree.c:313) 
[ 0.137230][ T0] ? setup_arch (arch/x86/kernel/setup.c:1099) 
[ 0.138552][ T0] ? start_kernel (init/main.c:481 init/main.c:927) 
[ 0.139865][ T0] ? x86_64_start_reservations (??:?) 
[ 0.141519][ T0] ? x86_64_start_kernel (??:?) 
[ 0.142935][ T0] ? common_startup_64 (arch/x86/kernel/head_64.S:421) 
[    0.144349][    T0]  </TASK>
[    0.145232][    T0] Modules linked in:
[    0.146391][    T0] CR2: 0000000000000004
[    0.147628][    T0] ---[ end trace 0000000000000000 ]---
[ 0.149306][ T0] RIP: 0010:fdt_ro_probe_ (scripts/dtc/libfdt/libfdt.h:? lib/../scripts/dtc/libfdt/fdt.c:?) 
[ 0.150885][ T0] Code: cc cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 b8 24 59 c7 5e b8 ed ff ff ff 40 f6 c7 07 74 07 31 c9 31 ff 31 d2 c3 <8b> 4f 04 8b 17 0f ca 81 fa 12 01 f2 2f 74 28 b8 f7 ff ff ff 81 fa
All code
========
   0:	cc                   	int3
   1:	cc                   	int3
   2:	cc                   	int3
   3:	cc                   	int3
   4:	cc                   	int3
   5:	cc                   	int3
   6:	cc                   	int3
   7:	cc                   	int3
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	b8 24 59 c7 5e       	mov    $0x5ec75924,%eax
  18:	b8 ed ff ff ff       	mov    $0xffffffed,%eax
  1d:	40 f6 c7 07          	test   $0x7,%dil
  21:	74 07                	je     0x2a
  23:	31 c9                	xor    %ecx,%ecx
  25:	31 ff                	xor    %edi,%edi
  27:	31 d2                	xor    %edx,%edx
  29:	c3                   	ret
  2a:*	8b 4f 04             	mov    0x4(%rdi),%ecx		<-- trapping instruction
  2d:	8b 17                	mov    (%rdi),%edx
  2f:	0f ca                	bswap  %edx
  31:	81 fa 12 01 f2 2f    	cmp    $0x2ff20112,%edx
  37:	74 28                	je     0x61
  39:	b8 f7 ff ff ff       	mov    $0xfffffff7,%eax
  3e:	81                   	.byte 0x81
  3f:	fa                   	cli

Code starting with the faulting instruction
===========================================
   0:	8b 4f 04             	mov    0x4(%rdi),%ecx
   3:	8b 17                	mov    (%rdi),%edx
   5:	0f ca                	bswap  %edx
   7:	81 fa 12 01 f2 2f    	cmp    $0x2ff20112,%edx
   d:	74 28                	je     0x37
   f:	b8 f7 ff ff ff       	mov    $0xfffffff7,%eax
  14:	81                   	.byte 0x81
  15:	fa                   	cli


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240716/202407161521.ec4d9668-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

