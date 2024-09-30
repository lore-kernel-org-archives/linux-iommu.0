Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08AD42ABD
	for <iommu@lists.linux.dev>; Mon, 30 Sep 2024 11:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727695116; cv=fail; b=qcNcGqgurfg1vbyoO0ECy0z773dLhZpm0bX/MJuBshvHvDm1uG/d2rp9eWE/u7CF2AWtKbCVCiI6sKWOFcwgc8S4ndXxzHebx7tfAS+ck3H6I0e/rXBMJpVcPx6Lr31naaPkmd7RTg83EBJeO5s/1T8ptndsiMxwQcclWDpLCTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727695116; c=relaxed/simple;
	bh=gHfTziAxfeH4r3sayYFqUyB+l7CwngsEFP1aIj3CFIc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YcGYiBjM8EKdtGwS0iQ29F5VXhclpSgI1rFXU9+N9c12/F3x4m++lNHfibc19V5IUaGbcDqQ1pq8GjRPQCrO8NuofR+EdfiAhBTG6uptmME22pLUH1sO0rwZWM782ok20b0Ql8dU/cCdgrpt6xGan5DmeHggPcAd5M14T55QVCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iqc0ypqs; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iqc0ypqs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727695115; x=1759231115;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gHfTziAxfeH4r3sayYFqUyB+l7CwngsEFP1aIj3CFIc=;
  b=iqc0ypqscykctjFHF5MSgPPneEYBC0fKCoaku0DI06JZBmuTIw0m6+xv
   Mi2l7u/kPEo7B3HKUlmYyaDJrbZV0CTN3FeWS6BBc0OIK7HKD/aai9g93
   YjoqSvSEw84aFechZIpGanmNwxPrPpcYCBflbe+6EubsUM/kKcQgfkIs5
   B/MlurPvQTYjJMDz4ktpvF7aLp0vlX+TtRJgYy0D1+rR4POljlpuwDIar
   nLwqZ+E9Zjqx16jg9vkRsnjZaCmbVuEHSd0TDV1+Vu/nyrc61nC4qkBKj
   qu44DCh6jqkEhkkqJSxWSM+cU9iDs/5Rh2pHCVjdDkzvhJas+N4mEeGYK
   g==;
X-CSE-ConnectionGUID: c5Uha2mdRlKCe50J0/KWmg==
X-CSE-MsgGUID: rX9MtLzrQtmvLvCaBzFARw==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="52191620"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="52191620"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 04:18:34 -0700
X-CSE-ConnectionGUID: AexREEdHSvClWTptXHhkow==
X-CSE-MsgGUID: VQBiUBAVRsaYHpiee45QAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="78028372"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Sep 2024 04:18:34 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 04:18:33 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Sep 2024 04:18:33 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 30 Sep 2024 04:18:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pMfhyCbpSKWZAzD8UzeB08L/Ss9wzTt079EvygZ8rPQJjomXsLgKMePTFg1cyBLM3NSbMx3nT9SeUBExreYbffjSUktAHY1YsySpgkZ8ZHQvH4isth1RhcupbVMCIKrtRSGZL4jAXd4UK3VKCRIbsJ3OVZdF2YtQoHyyj7FjXZ+ZJl/WLywUJF7+hXhfIfEbwfopUDtRqYO08exeJmH9GEjsci5rsqpJgnLdO17YaI+3iDxdEXPSIHO24YNFbXU9R4jz5BgY+PqMkSgaKlqNPaSwMSHRC2EovLW+5U003pvlLl+/MZ83ZJn7zi3R1TUBjgnksohzm4W+LwTiz+lgag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1mvxCOrGPyr79ra8eTN1nT60gGLmyg49XoxgOpzbDJY=;
 b=SwRqJc5YafQdu3k1Hm8kUXUFxO9HesmUVn1IOLGR80kxgxFUoNb3VzLpWvegXHM/NbFPfpCJAX1XMf3u+dLrjgXjdlSbFfAue32cRFw8WgvAoMz5bIqFldrNrTZEkIYa1uowIyjI484JArBW+cRUPDKfUWQN2aNzub0+HKnAh2ohkAIeEtsum6RzVyb9/inlNBGZm5GrTIuLWCx425rb23YzobWwoZ9HcTonAV88oD26Gb/QzorxaZfZyPbuXi0+aAyEH8Uah27ahjGh17Xeym/7RxCPcDGoMSVyFdzPFBWr57SFMR3jz0SD2t+Nq8ElTdX1Txn4wgKHJWcHLtmBuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH7PR11MB7451.namprd11.prod.outlook.com (2603:10b6:510:27b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 11:18:31 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 11:18:31 +0000
Message-ID: <aceec535-a726-4fcb-9698-3cabe163c15e@intel.com>
Date: Mon, 30 Sep 2024 19:23:05 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu: Remove iommu_present()
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, Jason Gunthorpe
	<jgg@nvidia.com>
References: <20240930004235.69368-1-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240930004235.69368-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0182.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::20) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH7PR11MB7451:EE_
X-MS-Office365-Filtering-Correlation-Id: 87c898f0-6ba4-4181-2d85-08dce1419d34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b0JqQnB4VWxmaXZIVDlIY3JMSi9YUXZxNUpUcnQ4cEp6T0RFVGlMN1lJWGRW?=
 =?utf-8?B?MDNFY0VHODFZbkhNTlMyZFhBU1VvNnBoV0ZBNDJzUUFQdy9JazA4RlZCb3Ay?=
 =?utf-8?B?WngzelZ2M3VkR2lnVHVncGdpTmxBRW9ZODNJQjBreVBpamhuaU4wRDd2aFk1?=
 =?utf-8?B?TDNCaDNtdkZpaDBBRjhFYndTdEhPMW5kVW04UDdBdW1Vb1pvUk9FRFdFemRG?=
 =?utf-8?B?OHl6Ti9Ub24yWVJEbWdkdmdNdkJqeU5Sd1YzczlpRThSMm9tOHNBc0dNRHpS?=
 =?utf-8?B?OVE3aVB0MXNqRGxUdUIxUVhhVzJ3OEUvdGt0bUZRZGswZ1UxMVFFZk9ydm11?=
 =?utf-8?B?dUFRUG5Fb254NklzMnJ4TzdRT1VJRjRkampaUk9XZXdqWjdwUFZqV1haMWEw?=
 =?utf-8?B?ZmtMMGo3cHZWYXk2V085OVFSQmoyRFlqU2I3SmU4b2c0S3h3YVdXTVd2WFpM?=
 =?utf-8?B?MVVXNjA3K3IrL2UvbDZWYnNiNG1xM0VZc3dhQ0dNRkJ0bU5jc3h6N2p6RUY4?=
 =?utf-8?B?N0hQUFlqU2FWUElaTjk4RVlZOEYzV1lnMTdPK25wUmlFZXZTU2NvVU8ySHJn?=
 =?utf-8?B?Wld4WVlmb2tJNlZBRFRKMXhTVnhjM3VvODZMS0JNdDFBZkFCYjBpTnpDeHdn?=
 =?utf-8?B?MjM5cjQrRDlYWm1PcGRiTkVwRWloeFJYalZIOFpocG5YczhGdy9ubFF1MWVQ?=
 =?utf-8?B?T0dyQk5hSEhSakdmRlVMY0d1ZXh1UHlqVjFmYitDQ2E3ZHFjYkRHcWVvUldy?=
 =?utf-8?B?cUdLUlNId3ZEVFFWaTJ4dGx0YnZ4dVJuNm1FTXhsU082eGN0MGp1OCswYzl2?=
 =?utf-8?B?enRJdndNOWd4OXU5TUFpWTZuYndJdzEvbHVIUE1wdkFkS1IwbkVyOC9iMW9K?=
 =?utf-8?B?aHc2aU9iemxQWk5DY1B4YmJhSnZveEU5bnlwMVdoQ2hQWlJXdDBubEhMTzVo?=
 =?utf-8?B?K3NGUEozTUlLeHJoTEV5dFJHaU55djlVZVRORnorNTB2VlhqMGFsZEM4U0NE?=
 =?utf-8?B?d0J5cFk3YUozWGEyQVVlVCs5Q2EzR3J2Mzg0NG1EdnIvQm1LNjhrenFoUC9v?=
 =?utf-8?B?N2wrZVA2M0U0OFdKaStqZUtRbGVqZFVTZE11Mk00cmV5cjFuL0VsQnFaK081?=
 =?utf-8?B?SnBoalZ6YXl5eGlMMjhpNWo3TmN5a0hvcFNSVWpOMDkxa1AyWlEzN2hOZTUx?=
 =?utf-8?B?TmxvaEJIMklMeGk4czQxc3BkZkFLdUFDQktWR2JDcGtUMjF6T2FpV3lkanJt?=
 =?utf-8?B?cjBmNTNDNndWS3VBakRCWjdScEs3R3dCKy8xU0xTR2xCQUpkQjVWZGhwOG9p?=
 =?utf-8?B?d01sODU0TWgvMmNqS3Z5QzE2TVYzWE10d0gzVmdwNUNjdTRHakgrUEpPcFE2?=
 =?utf-8?B?UTRrZ2ZXN2RIQndVcEpKWkdmR3gyZkFvYUdobkx1ZEZERzhCR2lYM2Jwdm5I?=
 =?utf-8?B?ZWkyeXdHWElUdlZXRTgwNklGc08yZmZLSkllZ0RZWHAwdHV3V1BwSUNMSmV4?=
 =?utf-8?B?enZZRHZQSTNESDZHUWdLTU9MTUZrVVByaFFuN3JoVnBEVk5tZEo0dVVENE4z?=
 =?utf-8?B?YTBLdWZWRGFET1FteGI1L1haUlZydDhFaUcyaE8ybmdGK2dQUFYxdmZ4TzVU?=
 =?utf-8?B?Q3ExQ2wrYVhRRCtJcFlJUDV3S28wTGcvWW9FaTAzU1VTdDNjdnRjTENXd1pC?=
 =?utf-8?B?VDVXdEdLRkUwbEg0SXNldlYybnMzNE56aE1ZUE83ZEYvVHRTT1luSVFRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHJYVVFWMjYzUzM5ZDRSemhISGl6ZG5tS3ROMGF3Q1hoVEdlZFhtZnc2Y2pN?=
 =?utf-8?B?L2VOU253RHdLL1ZCTmljSnVpTkd4eHYrellLSEsrN0NMM0VyNlNVcEJ5U0Zy?=
 =?utf-8?B?R1U3d042dEdzeVFwVTBCeTduMmRYVFNKdi9saWNqbDZOZ1RkRWNhQnN5WmJk?=
 =?utf-8?B?bDN1ZHhYaENRa3NiRDQzTHRVUkFqWVJuVnc4MDZXUTJRZSt6anVPMDRPdTBi?=
 =?utf-8?B?MUlnQ3N4Q2RVT3Njc0FyVlhORnJtWkVJWGJrZlVyZSs1SkMxbVdIemdzbUg5?=
 =?utf-8?B?MVozTnQvSFQwUW9NeFlOQS9qZ0VKZG9zZEdjdCswbkg4bVlXVThTZTVKM015?=
 =?utf-8?B?eU9mRzNUN3p1UjdLTmttbVdtMUtBM0dXR2tpNytGZjMxbEZJcVFDWHZTWEFP?=
 =?utf-8?B?djRGQXB6SkZOMzdmV3ZzbU1hYk0vMWI4YXo3QXBSV2g1cDRzTlN0OUhOemlD?=
 =?utf-8?B?SXNGQ1I0T0lScEprbEh3NFVyUWpVbys4bGpzaHRjZHZYNUNDVDJOa3RQaHlO?=
 =?utf-8?B?NXlHVHBMNVk5bjN2enZTcWNDMHpyWCtKbVBnb3JxSXhUU0JzUUZKWlR2d09O?=
 =?utf-8?B?ZHpkaHdSNDFIelFlYVZ6VTI5QUc1RHg1N0s4Vm9yVGZOUXdiVHBFSWQ1TTlM?=
 =?utf-8?B?Z002b0c5eG5lalcvcnQ5aFo0bTFSK1N4d0xYSWYvcXFLS2hETlp4U1JDZyt0?=
 =?utf-8?B?OW4yQlZTc3hkcndyOVprazJXWk50Z05lWTNwcUovZnJ4ejE5QU1NNDFkcis3?=
 =?utf-8?B?MVd0b1lCZzBRYUJ5M2tkMWFnQm1ydmNtamNWNkZ4OVh5SWtCS01qc0JqbFU1?=
 =?utf-8?B?b3l4c3J1VnVTNTdNanFxMUdsNXlrdU9VS2NlNW0rOW10T01ETXdCOGs0MFpT?=
 =?utf-8?B?dHdIOWRneWZuQitaRENoTkpIUEVheXRrZEFkQzBiVVJnZmkvYlVURHFXMzV0?=
 =?utf-8?B?RFBUaVZNZUQvQzJyTkZwZ0MvVWVCK1lzMnc1V2hGb29hby9kVDUzQkdtL1gr?=
 =?utf-8?B?YU9BUjBkQkVGQ1kxUmRaczRmcjdEZGhxbDhSc3VZdmpRdGs4SnNkd2lOSG5Z?=
 =?utf-8?B?K1JIZWVqRnp1cTFKVGVaeS9iQk94c0RTYzVFcWNFRWpqTzZ0T0Rjd2NwU2lB?=
 =?utf-8?B?dkgwNEhGM0lBcEtZQ0o2eTlEY1pzdEt5a0ZrU2E4TmFwaFFMdjVnL2thNVp6?=
 =?utf-8?B?N1RiRVF4bFhNWGtDb3dsRW1CVlk4b3RPT2NiSnNJbHhBeDVzYzI0M2c3eUpO?=
 =?utf-8?B?Ym9QVnYxYVpOeWFFbjFhUWdaSEt1cHRKN3RGb3QzbVRCUDRoT0l3VzhEWVBz?=
 =?utf-8?B?c0Z0eE9TWDV4a0xiYkVBcXA2NUxzU3ZIZEtOdXROWElSZ0ttaUdCejdRYklt?=
 =?utf-8?B?ZmJkd1dyK1RhbFVVU05yN0I4YTZrZnloS05uR1MydFpHYUdkY1hmbWhTZUpO?=
 =?utf-8?B?THNJbWdjWTJ4ODJGQTJqc092c3MyTHhaOWJ5b2hTeUNveXdZOUhLSjR6SUZr?=
 =?utf-8?B?blgvbFFaLzgrUDhqczFaOUJTdnl1UFhsTWtLajJZQTJLNE5XRTBnZTRrSmdq?=
 =?utf-8?B?OFRQNVZtT0xVZzUrL3JnZ2ltaEtVVzJRMzZRdnZ0U2lLSHd4QTNlUzNRS1lQ?=
 =?utf-8?B?bmZEUEJiUE1ubng5d3VpenBWbWVlcUdXbFVzZzc5ZTlLZTNkVWh3Wit1Wk01?=
 =?utf-8?B?c1RQZEFBZjJQKzQ0SER1UWFib3Q3a3BzeUJNUFRTdEFNc01FU0ZQMmtVZVZB?=
 =?utf-8?B?aDVvdkZ6OTcvMkEyenJuV25JZjRoR01aTVl0d3FOMnVWbzlrajFOcHRmbjhw?=
 =?utf-8?B?YXNPb25uMVNvNm1VNVhPK0QxZFE2Yk1rb1YzbU5FeURiK0dVajNwRmVwQnI5?=
 =?utf-8?B?TTBnYzEycXQ5SnZjeDNYN3ZVZUt3Wkt4dU1ZQkc0UnpUS0dKZ3p4b1VCKzBn?=
 =?utf-8?B?YVY0YTVSWlEyK0V3VnNYaTZPNmk2YVpXU0R2T0loTU84dy9Cclg0dnNxOERn?=
 =?utf-8?B?Nms0b3VEN2syc1oycFZ2MitaVkFoQythYzRhMW10UkQ5YVR1WEFPV2MvWWN0?=
 =?utf-8?B?emE5WFFyMThoMm4yL1Vhb3FrWHhNdml3UmRJWXdjMXlpbWdibFphcWk0amZU?=
 =?utf-8?Q?wXt5O/0DMEueQvt4/EVLD5NtR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c898f0-6ba4-4181-2d85-08dce1419d34
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 11:18:30.9293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JuOB41SC5YhGZ4Cmba5aywXD9tOI6qZXXo9XbkWHONHqRAaP2r2vdoPPLcw6AnfCFqyBaxoLGir89Gi+bqCmAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7451
X-OriginatorOrg: intel.com

On 2024/9/30 08:42, Lu Baolu wrote:
> The last callsite of iommu_present() is removed by commit <45c690aea8ee>
> ("drm/tegra: Use iommu_paging_domain_alloc()"). Remove it to avoid dead
> code.
> 
> Fixes: 45c690aea8ee ("drm/tegra: Use iommu_paging_domain_alloc()")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> ---

just curious, why a fix tag here. It is not a bug. is it?

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

>   include/linux/iommu.h |  6 ------
>   drivers/iommu/iommu.c | 25 -------------------------
>   2 files changed, 31 deletions(-)
> 
> Change log:
> - Originally posted here
>    https://lore.kernel.org/r/20240610085555.88197-21-baolu.lu@linux.intel.com
>    After several patches in that series were merged, this patch is
>    targeted for 6.12-rc.
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index bd722f473635..62d1b85c80d3 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -785,7 +785,6 @@ static inline void iommu_iotlb_gather_init(struct iommu_iotlb_gather *gather)
>   }
>   
>   extern int bus_iommu_probe(const struct bus_type *bus);
> -extern bool iommu_present(const struct bus_type *bus);
>   extern bool device_iommu_capable(struct device *dev, enum iommu_cap cap);
>   extern bool iommu_group_has_isolated_msi(struct iommu_group *group);
>   extern struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus);
> @@ -1081,11 +1080,6 @@ struct iommu_iotlb_gather {};
>   struct iommu_dirty_bitmap {};
>   struct iommu_dirty_ops {};
>   
> -static inline bool iommu_present(const struct bus_type *bus)
> -{
> -	return false;
> -}
> -
>   static inline bool device_iommu_capable(struct device *dev, enum iommu_cap cap)
>   {
>   	return false;
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 83c8e617a2c5..7bfd2caaf33b 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1840,31 +1840,6 @@ int bus_iommu_probe(const struct bus_type *bus)
>   	return 0;
>   }
>   
> -/**
> - * iommu_present() - make platform-specific assumptions about an IOMMU
> - * @bus: bus to check
> - *
> - * Do not use this function. You want device_iommu_mapped() instead.
> - *
> - * Return: true if some IOMMU is present and aware of devices on the given bus;
> - * in general it may not be the only IOMMU, and it may not have anything to do
> - * with whatever device you are ultimately interested in.
> - */
> -bool iommu_present(const struct bus_type *bus)
> -{
> -	bool ret = false;
> -
> -	for (int i = 0; i < ARRAY_SIZE(iommu_buses); i++) {
> -		if (iommu_buses[i] == bus) {
> -			spin_lock(&iommu_device_lock);
> -			ret = !list_empty(&iommu_device_list);
> -			spin_unlock(&iommu_device_lock);
> -		}
> -	}
> -	return ret;
> -}
> -EXPORT_SYMBOL_GPL(iommu_present);
> -
>   /**
>    * device_iommu_capable() - check for a general IOMMU capability
>    * @dev: device to which the capability would be relevant, if available

-- 
Regards,
Yi Liu
