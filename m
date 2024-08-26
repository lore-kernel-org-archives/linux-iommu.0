Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D322F78C98
	for <iommu@lists.linux.dev>; Mon, 26 Aug 2024 08:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724662793; cv=fail; b=GCn2z76/SvkOm2s9Fyt+vlwAaXd9XfbXxNjZ4YEAe0DBVf1ELej5vtmu1MXa3s+K7hbRQEjlGhW9LdlK+DSs7zaVED3nNxgh9I8hGxPBgTDUnVAFJxx9fISUW8QjRe0wob0cvLDsBlhsO8wc1GLqydPrJGr7bgQ2tHnCB+3iEMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724662793; c=relaxed/simple;
	bh=Jexj6B0qJIRS0JnxvWVwjhKqG91NzvRBAFgg9A0b5Wk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lKMrFeoR+d+ERXvyRDzraZGYOX+/KROP3bFBd6EcwiBPJfOsV3+2R43MIcRfTuJLRTD8lh8ZtV1syd8k5OdCqYjUzxu7ODKZgWt2RcQM/DCLDzbZYzeCPicvTeyBMCUIQnxhUsiJ63Mr6Ty5toPDYC+bU3f2gEoUMjQevbEQulc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mjiH1x7+; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mjiH1x7+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724662792; x=1756198792;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Jexj6B0qJIRS0JnxvWVwjhKqG91NzvRBAFgg9A0b5Wk=;
  b=mjiH1x7+LP2Al8inry00N2vk4ZRZKnpQC28TNfCZYBPxFnXL7an+itYS
   fmSOmi4ZJN595czEDGwC4CEtyXUN9vHwcQMNNTjpmFpsAxwwgIhJMwunk
   Wrr0pmTAvcFmuBAWcGk6S+TCoabqEP3l5ipE0PXtcfIZFYPwmGT7QqRB1
   bocFxCqWruarT8NH3/CGjE8woul+v06qkXftTD0Zn37pL0KrIa81l/DcS
   0kdZhHgJXu2nYzLqSVhXzdidn15mHhAgdpBOU/k51Var5KLBZcR/dUjUH
   Nv8h5E0bTldU0id2TfXxPizdNM+H5+Df9qbV9hOl/70nOvU6/NchXHmd5
   Q==;
X-CSE-ConnectionGUID: QxVgTuLTSxStRk1G22c7mA==
X-CSE-MsgGUID: KCYf08UTSauDI0liouqmPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="45590236"
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="45590236"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 01:59:51 -0700
X-CSE-ConnectionGUID: E+/1Ehd4TeihlRdESEQzuw==
X-CSE-MsgGUID: xKd+Lo5QQBmucCl60l9Peg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="66779636"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Aug 2024 01:59:51 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 26 Aug 2024 01:59:50 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 26 Aug 2024 01:59:50 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 26 Aug 2024 01:59:50 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 26 Aug 2024 01:59:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KHVtC5LYq7GLyy9VOI7T1id2/emSHwfWneJpEPzVdhOcAobzIX8fIt/W74XuN6ynjCSMLf5l4vpztDymgEtuxLxnj4FotpSMpYOF6ZB5ncsvDEaLQa/L+yfuT9xDaD2s3sOzoy73BosBsCr2dz+4835hQ9J7tzsjcPvPTWgHHurzxDOCDcTEQ+qz14DOD1VdCbHuCx4N5E/zbcqpKbPlmnsowLH2P5wbPV061Pl/gJY4PYcOhKvFQpTljvImQTnIYJfn5/8dN83EIjhTgi3BlGMBh1QBdvVRWUidCHq8rJGLaw7dWZ+9jdv5dGLVi9cFaDr4tJ6Gn2UgTv37VffwYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jexj6B0qJIRS0JnxvWVwjhKqG91NzvRBAFgg9A0b5Wk=;
 b=yYKDjvEUiD1KE5fjNp0+sNIyozXF/dl5cpV/x+aUwosWfN0YYAfy2oL4RS+Uiz1YHWwhoxemPzoelRYezSRLnnR1eVXVW9/8gBwmvPC0XNO1pJV0IMa36wrMMVgE/XuXnxqjUd2+Xl3hsf7JE9ltRlEJNunOqt41yDH3aFcSghgxNxyyU9rplffl2loifGm1g9Kl+IKJzczASw3YApcwh2Dj6hxjplea2n6v4ZQLZRVXM6r48/ujth4OkBVyVFIi+o0h0MuWCuHF3fdMJisOhTpQkGTGtWdCB4HgucaNInP8CYIkC6p/uOQ49uCNZV9f3g5+GeFI2/AOjCbm8adh8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB7062.namprd11.prod.outlook.com (2603:10b6:806:2b3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Mon, 26 Aug
 2024 08:59:47 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%3]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 08:59:47 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC: Vasant Hegde <vasant.hegde@amd.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH 1/5] iommu: Enhance domain allocation code to take
 additional flags
Thread-Topic: [PATCH 1/5] iommu: Enhance domain allocation code to take
 additional flags
Thread-Index: AQHa888x7AP+6/rsFk+8O8E7c5w7BbIx552AgACcOoCAALY3gIAA6/4AgAUNv6CAAAoIAIAAAcAA
Date: Mon, 26 Aug 2024 08:59:47 +0000
Message-ID: <BN9PR11MB52760A298E3000770D2FF6F38C8B2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240821133554.7405-1-vasant.hegde@amd.com>
 <20240821133554.7405-2-vasant.hegde@amd.com>
 <20240821163147.GZ3468552@ziepe.ca>
 <689eee1c-4b84-454b-8dc5-a5f35abe1631@linux.intel.com>
 <20240822124307.GC3468552@ziepe.ca>
 <ec556b8e-4a8c-45ed-a3d2-319ef9fdd04f@linux.intel.com>
 <BN9PR11MB5276296DD7C9503378C9227B8C8B2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <7ca97716-fe84-426e-bc73-808f8182ddbf@linux.intel.com>
In-Reply-To: <7ca97716-fe84-426e-bc73-808f8182ddbf@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB7062:EE_
x-ms-office365-filtering-correlation-id: 58b5d61b-dc57-401b-789c-08dcc5ad6fdd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dGIwNlRmc2ZPL0FnbnpXSGQ2S2N3bzNIenVSREY5bkQ4clRZYll4dVJ2MHBB?=
 =?utf-8?B?RkFqZzlKSEkyaDFxZ1BrRDFvR2tjUlhXeTYxR2VWZUdhRDYzOFpTS1RpZnU3?=
 =?utf-8?B?Q0c5NXU0c2JQT1RrMUcvL1duVys1TW5BVkVxOWNoUUt3THpxWHhkOWExVDFF?=
 =?utf-8?B?SUxtZGRweEc0NG9maHVFb1ZibHdDN3NteU41Qy82ODgyeE5rNFFVVnMwRE5x?=
 =?utf-8?B?ZnBGZEZGakJUY3ZlZWVWU2l6N2xoTkd2clFDMnZVekFJZi9xVFhNMDBEZFNO?=
 =?utf-8?B?N2tESEFGdStKUFNBWTVqVWtoNW1hZ0xWUWs3SlZJRU4xUkdYRUNZdDhJQVNC?=
 =?utf-8?B?TTR3clRhY2VxRnJnUW5wYnBHM3lvajlURktlZ3c5TnFML0NySFI0WlIvU3hn?=
 =?utf-8?B?UUlNQ1IzYWQvRGtYc2R4cWdnREpUbjZ5MkhTNm8vVFA2TzJySTBpMUNZSkZu?=
 =?utf-8?B?VlF2WVRpRDYzZVMwT1lsQXcvNHB2MDhMTVV5TTQ3ajFqSC93MVZIR3Y5bzNO?=
 =?utf-8?B?R2xGZEhhNnN4dlRKQzVxRG1DVEUrckUxVCtWMWR4N3lhcjJ3UDAxVzBYSU92?=
 =?utf-8?B?RmRCbGR1UzAxUnRkLy8zTUQ3V2pEdTRhSjNFbEpMeDJ5RERuSHVLaFJFa3FF?=
 =?utf-8?B?anlvK0ZCZWhBdXRPb2N6MGdHVTM3Wjh2QUorbmNGVjVYY3lWQlZlejZBbDhk?=
 =?utf-8?B?dkZPREV5TVhhNTJyVDNMWU4zYzhQNXA5WWZUTitTM1o0V2NRblc3U0Rqdnph?=
 =?utf-8?B?VFRicDRtdHRGQWlDQXl0V2JnWmc1aVN6ZEVBRkpuRmdac3Jld0N3Ty9ZVlJ6?=
 =?utf-8?B?RVlJU3hiMWYvelJTZk4vTytycDJiYkF2c3Q2MVkycDZqcUhWMUhlVDBWNmYv?=
 =?utf-8?B?SmZoeHkvK2hEbDRJTmJjWGsvdnNmc0ZQUmx6bHVHT2hnUG41UXN2UFE1bHEx?=
 =?utf-8?B?SllrR2JkNXo0dUZVUWFoY2w1TnU5RG5KVU5OZlFwcUlKeEpZanNWQ1FSY0ZO?=
 =?utf-8?B?cWxDWUw0ZElPSWhySWxFZTRZY28zajA4ampmQWJWUGFPWGV0clhTdklpT0hU?=
 =?utf-8?B?WW5BZ1MyVVVGeVBnek90M2taUkhkYzU1QThuZnJ6MFZ6aXQ1T3M4OVB6S2ww?=
 =?utf-8?B?aHJ4SE8xb3NYQmxpK2hpZ25QdDNyeUJlQkxFR3hjbHEySW1iQkdIWGtHM3NI?=
 =?utf-8?B?TG5jc240eTF1SnJqK0o4b1p6YzF3ZmhMNlhoRkszNmtsbXRUR051b3o3Vk02?=
 =?utf-8?B?N3ZlcUJnOE0wUldNeXdrdzRDblZlQ2tJNDFHUlFWQXBtMjhXbTQ1ZGxxR2JN?=
 =?utf-8?B?QVY2MTdITTBmQU01ekROMEJ3UmtFVUFoM2lZWkxaUXJacTFZT1Q2R2dNVWs0?=
 =?utf-8?B?UzBVOUQ0WWhxSmNVcWtJQU5tcUw2ZzFGWGZTdUNydUZnZW9kNzZNd3FYUGMw?=
 =?utf-8?B?WndqeGllZlRFSDhWaEw4ZXRlZzUrNm10NXVXQUFYVFQ2cVY5bWsvOW0xVDdJ?=
 =?utf-8?B?K2xLMjNPVTIxTm8rSHlSZm0vMmdyc242Q0NQRiswQU9nbHFsUmlyc3JZSmcy?=
 =?utf-8?B?NVBHT2lsSEVaeHY3VkJqbkRHZ1ZDQ0lIaGtCcXdlSUFWMlJwMTBOY1JPNDFJ?=
 =?utf-8?B?NWpraGZwUE1FcTF3S3VRRTBVTzhGVEtwanVXRlZhQmZqa29adHhrZ0FjcEpw?=
 =?utf-8?B?eXViOFVsSVZ6QUVyTHhPOVJtL09jejUvYXA0NXFTU24yengrS2tBdGlON01F?=
 =?utf-8?B?YlYxdkEwSXM3VHY4cG1TNkFreEhsbGpWakRSUzlUSnNheGR2VTY2MHh1KzNk?=
 =?utf-8?B?S1NXeGNvU1dCWFpCazdiREs5WjVoeUJVWlFlNkM3RVMySTJROXl6MkFJWTlT?=
 =?utf-8?B?bysxT3M1dFBtWW5UK3A0MkZ3WWNnVjVHSktnc3gyaGUvbGc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cUVNY1pTMWpOM0hJeFg3RitYUWk0NEEwbGthTVlLMjI0WEppNkE0T3VUWnRa?=
 =?utf-8?B?K1VHcG53bSs3eHBxaHhiWUVNQnJ0c0hFQVh3R0Jkejc0NnNoMktwVDJmU1p1?=
 =?utf-8?B?THlmcHIyRC83ZUZpd1Q0ZjhnaHdKblpKNW5CbVVwRDRaNi9WRlM4anFHclFY?=
 =?utf-8?B?STVwY1Jnd2N5UHdmdi9PRjVpNW02V1pvUldxYS91dUtSQzRUdzFiMWo1WmZ6?=
 =?utf-8?B?cjV6S1hrLytqUXMreWVHSmJST1dyNWdiSGV1U0todzlhc0NRSU1LdGI1UWxD?=
 =?utf-8?B?bWNvMHFmRStBV3VISzN0Z0RVODAvWWgvL09nWm5QOWR4cGtMYjFBM1FJcm8y?=
 =?utf-8?B?T092bGlFd2RIOThTQ2RQZDRFV0tKdnRlSE1nNlozZzlDK1FBRVlVTVpKai9a?=
 =?utf-8?B?d1ZKYUFxWkdxeTdqWlVROGx5eTVpU2FMMjBpR2VwLytTYlZRYi82QkZ2MzhD?=
 =?utf-8?B?dDJwVkJtR2dTdU5pT3hXQ3lJbzFVQzF4bEZvdGRZUEgvSHc5aWlTRUx4SGRt?=
 =?utf-8?B?ZmwyeUtDNkk0Q0J2RHFCemRzMm1hNHg5S0Uwci9qVUUwb1lnYnhYWFJZMDI4?=
 =?utf-8?B?LzlTUmVUb3Frb0RFMjZhd0Y0bTlsc3JXMmpMVFA3UjEyT1M3UFZ6QXRRbDZq?=
 =?utf-8?B?VWJKMDAraXIxZEZZa0p2RXprZlBBMkJxOEtMb1o5TzRVdnFnOS9nQU8rTGEv?=
 =?utf-8?B?cDlLTm9qaU9VdzBXcVBNTE84T3plVUFYZlZWL0M5MkVjMFgzUGRnckxXMlFr?=
 =?utf-8?B?djljejM4bmFCVExkZVZHUkRXUUl0ZGFYWHpxT29sMjNhUU1EUURITE1FM2g3?=
 =?utf-8?B?T2J1TUYvWHIxc2NqNW95WXZjQlVwd2hZYkRDc01QbmszcmUvbXlMakFBOWVk?=
 =?utf-8?B?d3dLbHJUb08vYWlGZnlMRUt1eHd5M2dZczBrOVdFcTZ6a2JxelFGUWE3aEdV?=
 =?utf-8?B?VUhOQ2xxb2VFOGFsQ2lyRitETzhaQjhzMGZzeGxXMDR3UjQrVXp5Z0MyZ2Rt?=
 =?utf-8?B?bjFoSStuUnhoc29GVjczVkZkRWd2U3ZJZUdSNzhBc1Q3WnFpblpPRXhXRFdz?=
 =?utf-8?B?MnYxUmNOanlsNXVINFhJQVV4bjA5K3hzZ1plV3hiNFZhdUJreTdFRWhlMUdj?=
 =?utf-8?B?TlhYdnVOMjh3YlNENk9aSlVpVU5sRm42V1cwZVMyZ2oxNUxBWUpxZGNXV2pE?=
 =?utf-8?B?dGljQ3lWMnJlTFVXVDc4ZFlnQUZrNkRMcUtnWWJYbThZcmVLcENZc1RsT3Yy?=
 =?utf-8?B?Y0tHVk1tNFFhTzRHVjM0VUZKWU9ZZE56VTVlQ0JRZjhWaVVnMWlTQi9JRE5l?=
 =?utf-8?B?eHQ5N240YlZKNG9RZ1g3dnFsdGd4V0lkUjdBY280UU13OW1GbXloQjlyelRE?=
 =?utf-8?B?STVKMVliMzVlRjh1bDUxSE5KZDBORTZLZjhDbnFkVGpiNGpCK0lnRFVQSkNr?=
 =?utf-8?B?QS9jUHVDSjgwQXI0czgrcnBPc2UwU09yQlNXL0Nkbk5SQlczbGJoWXdCUlFk?=
 =?utf-8?B?dDhyTEZYdjdzYUwyQ1F4cFYrUXJpajNnTWFiekxQYmhaMWF1VjhieGpKbTkx?=
 =?utf-8?B?Y1kvZnJycExDdUhQVW1Ga0svTFd6L2wvZ0lJNkVESzNabTF2M2x5U0NBT0Q0?=
 =?utf-8?B?VjdDYjgzOWdzaVJLZHROZlJLQlJWTUp3WEVFY1ZoOWs2ZnN3WlpXcnVjNld4?=
 =?utf-8?B?NlpIYm4wYXQ5WDJndUtYVXF0U0l0MGhDUXZBUUpIRUhuRSt4c0syaVRyNmZu?=
 =?utf-8?B?VGhKQ1hWR1EwaG9ybnQ1UEo5QnVGZVNLT1FGNUZ3U3l3QVM0M0kxdnNVSDcv?=
 =?utf-8?B?bTErdEVWYVcrQklqMXJDUVFtQUFxbEdqRC8wNWNWVU5Td2k2YmNDNzZwcFJ4?=
 =?utf-8?B?REJpc0lnUmtkN2dmN3d5aXU4ZGFnT0RmQVIycExmMVJFdzFBV0hsSjZteG1y?=
 =?utf-8?B?Qk5RWjNzenh6OWo0aXQxSnphVE5YMWZ5cmZDcjdmOTZVRjFrL3ZrMWEwamhL?=
 =?utf-8?B?U1EyK0JLUVhtbStvSGZFdlVDRzFrM2RxSnVUaHZqanZpNEU5TEJXbkhXMXJI?=
 =?utf-8?B?U3lCNUdrZVFMaVduU1Z0dHFDcVFSUEhvRkdKWTNXcFBIRi9Ubmc0WmE4VCty?=
 =?utf-8?Q?mkzPOxJnweX47H99BSkFEfJG0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58b5d61b-dc57-401b-789c-08dcc5ad6fdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2024 08:59:47.6233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bsDRz1gKsb5yp8tHqL0iaGCY7zm3pYUMWJ2Ufli1nMU09H7MxhndS2eAWpBX4EZYXYYX/vRZwBaR/2cBlTxI/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7062
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBNb25k
YXksIEF1Z3VzdCAyNiwgMjAyNCA0OjM0IFBNDQo+IA0KPiBPbiAyMDI0LzgvMjYgMTY6MDgsIFRp
YW4sIEtldmluIHdyb3RlOg0KPiA+PiBGcm9tOiBCYW9sdSBMdTxiYW9sdS5sdUBsaW51eC5pbnRl
bC5jb20+DQo+ID4+IFNlbnQ6IEZyaWRheSwgQXVndXN0IDIzLCAyMDI0IDEwOjQ4IEFNDQo+ID4+
DQo+ID4+IE9uIDgvMjIvMjQgODo0MyBQTSwgSmFzb24gR3VudGhvcnBlIHdyb3RlOg0KPiA+Pj4g
T24gVGh1LCBBdWcgMjIsIDIwMjQgYXQgMDk6NTA6NTdBTSArMDgwMCwgQmFvbHUgTHUgd3JvdGU6
DQo+ID4+Pj4gT24gOC8yMi8yNCAxMjozMSBBTSwgSmFzb24gR3VudGhvcnBlIHdyb3RlOg0KPiA+
Pj4+Pj4gICAgICBJIHRoaW5rIGluc3RlYWQgb2YgaGF2aW5nIHNlcGFyYXRlIGZ1bmN0aW9uIGl0
IG1heSBiZSBiZXR0ZXIgdG8NCj4gPj4+Pj4+ICAgICAgZW5oYW5jZSBfX2lvbW11X2RvbWFpbl9h
bGxvYygpIHN1Y2ggdGhhdDoNCj4gPj4+Pj4+ICAgICAgICAtIEtlZXAgYmVsb3cgY2hhbmdlcyBm
cm9tIHRoaXMgcGF0Y2gNCj4gPj4+Pj4+ICAgICAgICAgIC0gaW9tbXVfZG9tYWluX2luaXQoKQ0K
PiA+Pj4+Pj4gICAgICAgICAgLSBpb21tdV9nZXRfZG1hX2Nvb2tpZSBjYWxsIGluc2lkZQ0KPiA+
PiBpb21tdV9zZXR1cF9kZWZhdWx0X2RvbWFpbigpDQo+ID4+Pj4+PiAgICAgICAgLSBtb2RpZnkg
X19pb21tdV9kb21haW5fYWxsb2MoKSB0byBhZGRpdGlvbmFsIHBhcmFtIChmbGFncykNCj4gPj4+
Pj4+ICAgICAgICAtIGlvbW11X3BhZ2luZ19kb21haW5fYWxsb2NfZmxhZ3MoKSB3aWxsIGNhbGwN
Cj4gPj4gX19pb21tdV9kb21haW5fYWxsb2MoKQ0KPiA+Pj4+PiBNeSBleHBlY3RhdGlvbiB3YXMg
dG8gYmFzaWNhbGx5IHJlbW92ZSBpb21tdV9kb21haW5fYWxsb2MoKQ0KPiBlbnRpcmVseQ0KPiA+
Pj4+PiBvbmNlIEx1J3Mgd29yayBpcyBtZXJnZWQuDQo+ID4+Pj4+DQo+ID4+Pj4+IEluc3RlYWQg
d2UnZCBoYXZlIHRoZXNlIGRpcmVjdCBBUElzOg0KPiA+Pj4+PiAgICAgIGlvbW11X2RvbWFpbl9h
bGxvY19wYWdpbmdfZmxhZ3MoKQ0KPiA+Pj4+IElzIGl0IHBvc3NpYmxlIHRvIHVzZSBkaWZmZXJl
bnQgZG9tYWluIGFsbG9jYXRpb24gQVBJcyBmb3Iga2VybmVsIERNQQ0KPiA+Pj4+IGFuZCB1c2Vy
LXNwYWNlIERNQT8gUmlnaHQgbm93LCB3ZSBkaWZmZXJlbnRpYXRlIGJldHdlZW4gdGhlc2UgdHdv
DQo+ID4+IHR5cGVzDQo+ID4+Pj4gb2YgZG9tYWlucyB1c2luZyBJT01NVV9ET01BSU5fRE1BIGFu
ZA0KPiA+PiBJT01NVV9ET01BSU5fVU5NQU5BR0VELg0KPiA+Pj4gSSByZWFsbHkgZG9uJ3Qgd2Fu
dCB0byBoYXZlIHN1Y2ggYSBkaXN0aW5jdGlvbi4NCj4gPj4+DQo+ID4+Pj4gSSdtIHRoaW5raW5n
IGFib3V0IHRoaXMgYmVjYXVzZSB0aGUgSW50ZWwgaW9tbXUgZHJpdmVyIGhhcyBhIHNpbWlsYXIN
Cj4gPj4+PiBuZWVkIHRvIEFNRC4gVGhleSBib3RoIHJlY29tbWVuZCB1c2luZyBkaWZmZXJlbnQg
cGFnZSB0YWJsZSBmb3JtYXRzDQo+ID4+IGZvcg0KPiA+Pj4+IElPTU1VX0RPTUFJTl9ETUEgYW5k
IElPTU1VX0RPTUFJTl9VTk1BTkFHRUQsIHdoaWNoIGlzDQo+ID4gV2hlcmUgaXMgc3VjaCByZWNv
bW1lbmRhdGlvbiBjb21pbmcgZnJvbT8NCj4gPg0KPiA+PiBjdXJyZW50bHkgc3RvcHBpbmcNCj4g
Pj4+PiB1cyBmcm9tIGltcGxlbWVudGluZyBkb21haW5fYWxsb2NfcGFnaW5nIGluIHRoZSBJbnRl
bCBpb21tdSBkcml2ZXIuDQo+ID4+PiBXaHk/IFdoYXQgZXhhY3RseSBpcyB0aGUgaXNzdWU/DQo+
ID4+Pg0KPiA+Pj4gSXQgaXMgaW5oZXJuZXRseSB3cm9uZyB0byBiZWhhdmUgZGlmZmVyZW50bHkg
YmFzZWQgb24gRE1BIEFQSSBvciBWRklPLg0KPiA+Pj4gVGhleSBhcmUgbm90IGRpZmZlcmVudCB0
aGluZ3MuDQo+ID4+Pg0KPiA+Pj4gSWYgeW91IGhhdmUgZGlmZmVyZW50IGJlaGF2aW9ycyBhbmQg
ZGlmZmVyZW50IHByb3BlcmllcywgbGlrZSBBTUQncw0KPiA+Pj4gUEFTSUQsIHRoZW4gdGhleSBz
aG91bGQgYmUgZGVzY3JpYmVkIGFuZCBtYXBwZWQgdG8gc29tZSBraW5kIG9mIGZsYWcuDQo+ID4+
Pg0KPiA+Pj4gT3RoZXJ3aXNlIHRoZSBkcml2ZXIgc2hvdWxkIGFsd2F5cyBhbGxvY2F0ZSBhIHBh
Z2luZyBkb21haW4gdGhhdCBnaXZlcw0KPiA+Pj4gdGhlIGhpZ2hlc3QgcGVyZm9ybWFuY2UuDQo+
ID4+IEl0IHJlbGF0ZXMgdG8gSW50ZWwgVlQtZCdzIG5lc3RlZCB0cmFuc2xhdGlvbi4gSW50ZWwg
VlQtZCBoYXMgdHdvIHR5cGVzDQo+ID4+IG9mIHBhZ2UgdGFibGUgZm9ybWF0cyBmb3IgRE1BIHRy
YW5zbGF0aW9uOiBmaXJzdCBsZXZlbCBhbmQgc2Vjb25kIGxldmVsLg0KPiA+PiBJbiBuZXN0ZWQg
dHJhbnNsYXRpb24sIHRoZSBmaXJzdCBsZXZlbCBwYWdlIHRhYmxlIGlzIHVzZWQgZm9yIGZpcnN0
LQ0KPiA+PiBzdGFnZSB0cmFuc2xhdGlvbiwgYW5kIHRoZSBzZWNvbmQgbGV2ZWwgcGFnZSB0YWJs
ZSBpcyB1c2VkIGZvciBzZWNvbmQtDQo+ID4+IHN0YWdlIHRyYW5zbGF0aW9uLg0KPiA+Pg0KPiA+
PiBUaGUgaW9tbXUgZHJpdmVyIGZvciB2SU9NTVUgaW4gdGhlIGd1ZXN0IGtlcm5lbCBtdXN0IHVz
ZSB0aGUgZmlyc3QgbGV2ZWwNCj4gPj4gcGFnZSB0YWJsZSBmb3JtYXQgZm9yIGtlcm5lbCBETUEu
IFRoaXMgcGFnZSB0YWJsZSB3aWxsIHRoZW4gYmUgbmVzdGVkIG9uDQo+ID4+IGEgc2Vjb25kIGxl
dmVsIHBhZ2UgdGFibGUgaW4gdGhlIFZNTSBob3N0IGtlcm5lbC4NCj4gPiBJZiBhICdsZWdhY3kt
b25seScgdklPTU1VIGlzIGV4cG9zZWQgdGhlIGd1ZXN0IGtlcm5lbCB3aWxsIGNlcnRhaW5seQ0K
PiA+IHVzZSB0aGUgMm5kIHN0YWdlIHBhZ2UgdGFibGUuDQo+ID4NCj4gPiBuZXN0ZWQgaXMgYW4g
b3B0aW1pemF0aW9uIG1hbmFnZWFibGUgYnkgVk1NLiBOb3Qgc29tZXRoaW5nIHRoYXQNCj4gPiB0
aGUga2VybmVsIGRyaXZlciBuZWVkcyB0byByZXN0cmljdC4NCj4gPg0KPiA+PiBPdXIgY3VycmVu
dCBkZXNpZ24gdXNlcyB0aGUgZmlyc3QgbGV2ZWwgcGFnZSB0YWJsZSBmb3IgYm90aCB0aGUgaG9z
dCBhbmQNCj4gPj4gZ3Vlc3Qga2VybmVsIGZvciBzaW1wbGljaXR5LiBUaGlzIGlzIHdoeSB3ZSB1
c2UgZGlmZmVyZW50IHBhZ2UgdGFibGUNCj4gPj4gZm9ybWF0cyBmb3IgSU9NTVVfRE9NQUlOX0RN
QSBhbmQgSU9NTVVfRE9NQUlOX1VOTUFOQUdFRC4NCj4gPiBBcyB5b3Ugc2FpZCBpdCdzIHRoZSBj
dXJyZW50ICdkZXNpZ24nLCBub3QgYW4gYXJjaCBsaW1pdGF0aW9uLiDwn5iKDQo+ID4NCj4gPj4g
V2UgY29uc2lkZXJlZCBkZXRlcm1pbmluZyB0aGUgcGFnZSB0YWJsZSBmb3JtYXQgYmFzZWQgb24g
d2hldGhlciB0aGUNCj4gPj4gaW9tbXUgaGFzIGNhY2hpbmcgbW9kZSBjYXBhYmlsaXR5LiBUaGlz
IHdvdWxkIHJlc3VsdCBpbiB0aGUgZmlyc3QgbGV2ZWwNCj4gPj4gcGFnZSB0YWJsZSBmb3JtYXQg
YmVpbmcgdXNlZCBmb3IgZ3Vlc3Qga2VybmVsIERNQSBhbmQgdGhlIHNlY29uZCBsZXZlbA0KPiA+
PiBwYWdlIHRhYmxlIGZvcm1hdCBiZWluZyB1c2VkIGZvciBob3N0IGtlcm5lbCBETUEuIEhvd2V2
ZXIsIHRoaXMNCj4gYXBwcm9hY2gNCj4gPj4gY3JlYXRlcyBhbiBpbmNvbnNpc3RlbmN5IGJldHdl
ZW4gdGhlIGhvc3QgYW5kIGd1ZXN0IGtlcm5lbHMuDQo+ID4gV2h5IHdvdWxkIG9uZSBjYXJlIGFi
b3V0IHN1Y2ggY29uc2lzdGVuY3kgYmV0d2VlbiB0aGUgaG9zdCBhbmQgdGhlDQo+IGd1ZXN0Pw0K
PiA+DQo+ID4gSW4gdGhlIGVuZCB0aGUgaW9tbXUgZHJpdmVyIG5lZWRzIHRvIGRlY2lkZSBiYXNl
ZCBvbiB0aGUgcmVxdWVzdGVkIGh3cHQNCj4gPiB0eXBlIGFuZCBhdmFpbGFibGUgaW9tbXUgY2Fw
IHRvIGRlY2lkZSB0aGUgZm9ybWF0Lg0KPiA+DQo+ID4gZS5nLiBpcyB0aGVyZSBhIHByb2JsZW0g
d2l0aCBhIHNpbXBsZSBwb2xpY3kgYmVsb3c/DQo+ID4NCj4gPiAtIERlZmF1bHQgdXNlIHN0YWdl
LTEgZm9yIGJvdGggRE1BL1VOTUFOQUdFRCwgaWYgbmVzdGluZ19wYXJlbnQgaXMNCj4gPiAgICBu
b3Qgc3BlY2lmaWVkIGFuZCBzdGFnZS0xIGlzIHN1cHBvcnRlZCBieSBodw0KPiA+IC0gT3RoZXJ3
aXNlIHVzZSBzdGFnZS0yDQo+IA0KPiBGaXJzdC1zdGFnZSBoYXMgc29tZSBsaW1pdGF0aW9ucyBm
b3IgYW4gVU5NQU5BR0VEIGRvbWFpbi4gRm9yIGV4YW1wbGUsDQo+IA0KPiAtIE5vIHNlcGFyYXRl
IGNvbnRyb2xzIGZvciB0aGUgQWNjZXNzL0RpcnR5IHBhZ2UgdHJhY2tpbmc7DQoNCllvdSBjYW4g
ZG8gc3cgY29udHJvbCB1cG9uIHdoZXRoZXIgdG8gcHJlLXNldCB0aGUgYS9kIGJpdD8gDQoNCj4g
LSBObyBXcml0ZS1vbmx5IHBlcm1pc3Npb24gc3VwcG9ydDsNCg0KV2hhdCBpcyB0aGUgYWN0dWFs
IHVzYWdlPyBXaGF0IGFib3V0IGEgdklPTU1VIHdoaWNoDQpvbmx5IHN1cHBvcnRzIHN0YWdlLTE/
DQoNCj4gLSBObyBwYWdlLWxldmVsIGNvbnRyb2wgZm9yIGZvcmNpbmcgc25vb3AuDQo+IA0KDQph
Z2FpbiB3ZSBkb24ndCBoYXZlIHN1Y2ggcGFnZS1ncmFudWxhciBzbm9vcCB1c2FnZSBub3cgYW5k
DQppbiBzY2FsYWJsZSBtb2RlIHdlIGFsd2F5cyBzZXQgUEdTTlAgZmllbGQgaW4gdGhlIFBBU0lE
IGVudHJ5DQp3aGljaCBtYWtlcyB0aGUgUFRFIHNub29wIGJpdCB1bnVzZWQuDQoNCmlpcmMgYXJt
IHNtbXUgaXMgdXNpbmcgdGhpcyBwb2xpY3kgdG9vLiBKYXNvbiwgaXMgdGhlcmUgYW55DQpzaW1p
bGFyIGxpbWl0YXRpb25zIGJldHdlZW4gc3RhZ2UtMSB2cy4gc3RhZ2UtMiBhcyBhYm92ZSA/DQo=
