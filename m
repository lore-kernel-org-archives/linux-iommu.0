Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232CB1DEFF7
	for <iommu@lists.linux.dev>; Thu, 20 Feb 2025 06:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740034634; cv=fail; b=fMRWPw7TNNMPgDCQeAMZNoSVlWRQYA5UW4Bj29JhXSsgNWPsUijevx62SSiK4NHJb5BNTIUKVQLRzEFphSZCBVMoK0J2nJgiM6Px1ega4Wz6++rAo56NBYUpmsX75kPWM3dLaOZvpv7DZLI6ErUnsz0JuRpKzm7a1S5+JE97IXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740034634; c=relaxed/simple;
	bh=JcFldlOKvIepIO/OctUbrbyG1UwBygnYQYAABUAKXi0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k35jAQ1nAbSfzedSE+dGQA7fZKrR1LNezbIT4+UcCnL/mdqrdSXemcH+BGEM7VhPgqSSrLA+fspGegvgkqHnhDxWYm3+4TeTiZKwNgQ7seHmNEIqWQqR3Y3YL70Nhe3lhgZi+34FLEoMr8R7uASthMUdSxrT8hSxPaIrL4Wr6hU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d2nPZYK8; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d2nPZYK8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740034632; x=1771570632;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JcFldlOKvIepIO/OctUbrbyG1UwBygnYQYAABUAKXi0=;
  b=d2nPZYK86Z5B6GibY1aLFgmeFyAT6nZs3ZHkcRHKYTpyRhPAAWBvEHq7
   WFTuZ2Ugy4i6J/K0TEEKxVpOgzAjPBLjMcJh3QkfAj8xxyfkeboxYAV3H
   gxnrWODdNlfMnm0tZPCHqIIk3aATD2qXtIaPIRo2Urjjh9vxuEL4Ap+Je
   3NvMxfwBvWiLNsAxoqn+c5b0b54gvUPQcmWhubcr67qxuoErEg9jcbcaG
   4ezIHyNNqHDgxIYypz1VbjMa4He+k91pDy4rGtwZC0TQwcmD1OLSQLT0R
   fREPFsX6wLMnszcsbH8qoT6LlE2KPR2T+WhS4Lpo7QyH9KUuPX8R8gD1x
   w==;
X-CSE-ConnectionGUID: guHNUMZjRUapbiGgEKMIcg==
X-CSE-MsgGUID: niBiLpzzSUKf5k3tIbHCTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="40514262"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="40514262"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 22:57:12 -0800
X-CSE-ConnectionGUID: 14GeGpb3QEqvkXIh8KfXcw==
X-CSE-MsgGUID: N9ROOaSSRPS8ovGcg5wNvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="119929287"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 22:57:12 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Feb 2025 22:57:11 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 22:57:11 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 22:57:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a7UDzFSnq01GHAnjDl0Mq20yB3g6bea2p7Pz/gZWlS4RjwOgOlg04yIPTM1ElHFlIS+5EcMLGLsPcIeXBKgKq0Lhw1H2/EgxfmO/6tOWp5FMnRTNSXtu+rAR34IvVjSi7CYh8c7/JmsBLXrwp61SE52UmSgAMH92DNIh+iX6Ud78O4qOGD7syZRhpICOIS24qZdrxxP8voF6+JZcjwfZFq1fglgMXG31M0pCySYNdEq8gwLlr8YQclFzCfmo+A7gejPS+DTU8+iJMev7ftJDz1Jkmvz3euKL2f75zbfY4Vq7JWRnMOqXkTfRbW2YdeOR73RPQWNf8D7i/XMHmU4FUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JcFldlOKvIepIO/OctUbrbyG1UwBygnYQYAABUAKXi0=;
 b=jTkTAUUNNRBOQFrRcVBUP+C1BXKY/UsyamdBDFE6iRuiUKyDAzImExHXhXW+P90yn7v7RZYOXFaQ7a1EsMfLS85KiAdlrmYpw7vxZaQit84Ap/ELJ3Lmd5NOIi21iaU0D2sn0AN6JYjVdBmKwuJ/0LoFqM6Y0CJYUpN58jicngTszMXCjpAJAUw7NHna43JV7TQEdVoezC3HlWcUdiNDb4+84QYXp583Tyb5as9MdRG+OfXNiEUy7ot51ijxE2zi6K9pcODlq4TyoWDoPeQHqUrnEZNIoTGTAxjQCPvrt/bqfOz4Y4cyM9z72YjZsuV5rnV7EB+pvFwNisqa5PKJmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM6PR11MB4708.namprd11.prod.outlook.com (2603:10b6:5:28f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 06:57:03 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8466.016; Thu, 20 Feb 2025
 06:57:03 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, Robin Murphy <robin.murphy@arm.com>,
	Baolu Lu <baolu.lu@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"jgg@nvidia.com" <jgg@nvidia.com>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
	"will@kernel.org" <will@kernel.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: RE: [PATCH v6 09/14] iommu/vt-d: Add IOMMU_HWPT_ALLOC_PASID support
Thread-Topic: [PATCH v6 09/14] iommu/vt-d: Add IOMMU_HWPT_ALLOC_PASID support
Thread-Index: AQHbUhnPTImkeHGAuE6mCT9lTVfS6LLzJwYAgAIkjQCAAOGBgIAAOg4AgAAtiwCATQv7gIAAVz2AgAFizQCAAAQXAIAJQwtAgABTwICAAS5QsA==
Date: Thu, 20 Feb 2025 06:57:03 +0000
Message-ID: <BN9PR11MB52761EDDEF9434EEA6FC10398CC42@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20241219132746.16193-1-yi.l.liu@intel.com>
 <20241219132746.16193-10-yi.l.liu@intel.com>
 <f4c1ca6a-4ed5-49a7-b399-dd148cfb16bd@linux.intel.com>
 <acb2bead-1597-4fdd-b949-26eab2e62b0a@intel.com>
 <38e26d9f-0727-4b15-8e1d-03d262c15c8c@linux.intel.com>
 <c10755cb-6966-479b-b68c-9bc022c894d9@intel.com>
 <5c5180cb-9bbe-4fa7-b109-5dad2ca9516a@linux.intel.com>
 <bd1655c6-8b2f-4cfa-adb1-badc00d01811@intel.com>
 <95ab1ac7-f0a8-4b9d-b88e-72ce0d72ca98@arm.com>
 <deb77d13-5722-49fe-a5a7-8ba6bc370763@intel.com>
 <145b2f93-58b3-4484-b6b5-9216d4d21e1d@arm.com>
 <BN9PR11MB5276770D48B7B4C21A2BCB448CC52@BN9PR11MB5276.namprd11.prod.outlook.com>
 <e99759fd-ffcd-41c7-b960-8c4a2858ed46@intel.com>
In-Reply-To: <e99759fd-ffcd-41c7-b960-8c4a2858ed46@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM6PR11MB4708:EE_
x-ms-office365-filtering-correlation-id: a9a76d52-8bed-4a1e-fe96-08dd517bc7f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SGVXRHpXNjZyNzMyVTQ5TjdlUVRHaFNxYTBvUGJCdHpIUGl3TUlKdWU1VW8v?=
 =?utf-8?B?T29sTE5kWW5pTVF3M0RrQ0Q1QVZJVUxoaHlhY1cwaU92L0Q0eklKcWcxaE05?=
 =?utf-8?B?MEErWjFBOVlWaWk4ZDFiK3NlMUNFcUE1UmdOQkVySUZYVXRVMSs5SVkzVWFh?=
 =?utf-8?B?U1JKQTVYdjZvd3gwY2p1SzVWN3RJRXpPdzJGV0FGVU9KeUZ1SlBCRHVCMjd5?=
 =?utf-8?B?bWt3T1N0NytCeUlyRG0zUi9obFpBY2R6WHJRYVQyYU1odFFTeFFTdGZ6SG1V?=
 =?utf-8?B?dmh6K2E0c3ErZ1F2NTJqUmgzT2xoVkZ1NUxqblJvT2JZNHEzK1FyRU5HUDNU?=
 =?utf-8?B?Skc0YXdoTHNGKzdPcm56NllBTW5PQm9tWk80NUZCQ3hlcHgxbGduOTYxQU9Y?=
 =?utf-8?B?dUNGV3RzNmdLc2RZeEpsVWQzYVhDVCtSWko4ZjFmTG9aNzRTY3RBakVCZlg3?=
 =?utf-8?B?WDdLNzZ3RjF2bVlBaTJMZmFqV3dpNTFEeUZKRHhVUGJKSjdQOU5WQVMrQytZ?=
 =?utf-8?B?K2xrYjltc1B0YWZ3S0VSSGxaK2pCQ2pWU0xnMDZjQmo4SGM0emhBRFp0MTdr?=
 =?utf-8?B?Zmx1MzBWeTdsUmV4RkZKalV1WmN3ZERicTc2TWNlNnhySHF4OCtLNzFONDA1?=
 =?utf-8?B?SEd2cEVxTXJzNHR0a1hoOGxDdjBMNUVQSWwvRXozV3krY1pxNDRXQ252UEt5?=
 =?utf-8?B?RE5SU1hlc2pIN3dWRkcvaUlzcnpnWGFYNnVtZ0Q0d1JTbzQ5TEh5dG4zeGV3?=
 =?utf-8?B?Wk05aUtEbEE5dTN0VE1UVEZLYUF1MitMUEgvMm1QY2p4K2NSbXpKOWQzcHVa?=
 =?utf-8?B?RnpXeXM4WHNQTHdTWmEyY2lZOWJPYi9yMTRxU0FOT3R3TUpyc092bkVFa2Ru?=
 =?utf-8?B?eWd2MU9VSnhhS20zdHFmZ2lTL2JBeGs5TXNmcFVqSFBRa2dMOUdUQzQ3VTNB?=
 =?utf-8?B?QlZlbkIyRDM4UHVRc0MrcXFMUDhqNGFkWnN0bmdTMHhaSCswS3phT1BrT1BJ?=
 =?utf-8?B?cCtRbS8xMFc0NGF2ZExpSnJNWjdBdjlFS2lOT3dRalQyMStvUEY1S2UrQlpN?=
 =?utf-8?B?aGI5SEw2d0pCQzhOQUxEVldRcEdrNkEzVE1XR0o5RTYya3Y0VmZvRWp3enIr?=
 =?utf-8?B?T0FwUzRYdDRDVDlmTlJTT3BFU0UxSlBwMnhtcjZCbUZGZXB3U1NUY0RYU0NU?=
 =?utf-8?B?SnZqL2lHOWxKWE1PT0JWNXV3Q1h3dHJheFVteE9vSk5qanVCcVFxL05UaWxy?=
 =?utf-8?B?SGJRZzhnMk5UMzFLaFhGM05hZnc5Y0dtN2J1bU5ROTJVRUFQekY5Tm9Wc3U0?=
 =?utf-8?B?NG9uSGtTcm1IcThxeHphN1Urd1dobldadWRtZnJBNEFSdlp3MVZQU2NMT2pz?=
 =?utf-8?B?TTV6aFdoWkVGaktJM0RHR2pEcHpxY1ZORkJZWDRqc2J0T3MwaG9hc296TGhF?=
 =?utf-8?B?Uml5OGF4UTM3ZHJLNkRtUE5WazBHaXhReU03TFNKS2k0VElWNlYvdkUxb1Y0?=
 =?utf-8?B?VnI0c29JMnFzQmVYOXZ2RGdNS3VoNVUwNS83dVQ0VlNaTFFJUnJDY1FwVnUz?=
 =?utf-8?B?REhseGdOcDZtRVh2bUxsSVM1MVlpQ1JkNnhocURsRklPZk1KdXR0Ynh6NmFu?=
 =?utf-8?B?N2FUdHBkanZTbUphNUFTOEdLcnJyTmdOQ2VkVVdlMWpNOGR2akhGbnBacTFW?=
 =?utf-8?B?YVVyRnBINWQ2YWg1akxzemtiaHNUYm9hcW5VOWZpSDZUV3pqbVZESEgrTmJr?=
 =?utf-8?B?Yk14RVpHbzJTeDBCVVl5dWZWd3dkaWJjZW5mcmg4REcrZEdjWCtnQUVsNGlS?=
 =?utf-8?B?am1ERkN0alF3cnhWRk5WSUtxY3A3MW54eDJyUjlXNzBMbFZBQVFsUUlXNG00?=
 =?utf-8?B?UFZ6Q3l3WEwzcTJwZzVCK3NuWW9aRVNrU1IrSHVoUmF0RVlQckMyV205Sy9J?=
 =?utf-8?Q?HefYTvJdmt0hijY0wuGkZCdcNUhm7stb?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a1QzMFo3WENiNTU1bTIrQUhtNnZicHJ1ZTNGcktYb21jeHpXQ2xUL2RtT2Jo?=
 =?utf-8?B?ell1Z09ROWpUVlcxUnBMYkF3WEZublRuQmxkVmFYR295cSs5Q09IVjRGQzdQ?=
 =?utf-8?B?ZU0wMW9zdnBIY0dGTElwOWRMeklrMCtjckQvYjZDYVhad3VieWtHOGh0WVpu?=
 =?utf-8?B?cXRWbWlLUHhZZE1IZGlIZmhJK0NkcHZabXNqSXYxWElNZlBpS0NZT0JCTVB1?=
 =?utf-8?B?dXRleE9jbmExZmxOdTVUK3h0MXBHbzYxOWNvWG5zN09oSTZZc21ySm5IVzNz?=
 =?utf-8?B?YlQ3bzFmbWpjSm1wd0RKaVNlNWdRQ0IxcGRQSWUyQWVMUEpDVS9VMmx6ZFJj?=
 =?utf-8?B?RVpHNmNhbGxlN0MyTkdlVmphV0IyYWpsb0lHN1RXZmpLVmtqc1pQUGhHcEJh?=
 =?utf-8?B?OEE2bGtsWHZIMHFDRDNId2ZDcUdvNHRzc1QwTllpcUJZYzNBVHNlUUh1QlFx?=
 =?utf-8?B?aWYzZ3BEcjFTRkxaN0FWZW0vZUswek45TlVFUjFuQmRFWm5QZmZ2Y3dzajMv?=
 =?utf-8?B?SkJNVy8yUWNMVndvZTlWRWpSUFhBYkFwR2xJa0pQSkVmTG9HRW5mdmNpdzNZ?=
 =?utf-8?B?VVd3bW9ldWdoeDd2Yyt6ZlU1NXhEUzE2a0dleE0zYk5wUXVRUk8yZXZNd2dS?=
 =?utf-8?B?YnVSNmFoNS9seWMwTmZ0YjFaUVo0R3VuTnAzWWlDOGNxV2F4RGZoTk5nOGk0?=
 =?utf-8?B?K0lhaUJYRzJEV3pZRm8wNmFxRytNNnVlYmxJT0VodWxvY1dnSlhTUCthamxZ?=
 =?utf-8?B?NFh6djZoQ3NDM0JHc015TTFQSXYvRXM0RmxZcEtCYjhteDA1VTY1K1JTK25p?=
 =?utf-8?B?QVRRTUZnUXZGSUpaQWZFbDhtVktZNVQrVVErOU1qT29LRmFRaUlDdlZvUktY?=
 =?utf-8?B?dXl4T1dmNFREeVhzL2hHT25YWlM0bTJQTnkxamNuelFwbkpNT2s0aGN4NWE0?=
 =?utf-8?B?NTBiMkN5UEtrRGJ3N1FoQ0w1UHdvN0UveDlmUHRDby9OYy8zZEtHaEhxcVg1?=
 =?utf-8?B?NWg2YjY0MXB0VGRwYytFZGJQNm5pK1ljWlQzU09yK0JkYi9TOWxEbGtEclZa?=
 =?utf-8?B?WWY3Y0ZISWVSZHprR0VnbTdKR3MrZEQzZCtBZjBDcnVTS2lpelluTE93WkRm?=
 =?utf-8?B?WVpEWGR1V2Q4Qmk1emo1aVZBdHdqWlBDTTZZY0pnTW5FVHQwOXdaTTMrditR?=
 =?utf-8?B?dFFPVGg4cEtoUjEzVlJoOVd4YU9oWVkrd281cDlxVExSd0hVRXB3TklKalBi?=
 =?utf-8?B?MGNmN1JyVkZSSmtPempCMzhHZm4xY0R6QVRHbVMvRmdVclNDMUJRTkVLMUVt?=
 =?utf-8?B?eXhuTnE3RW5VYXFKVWZTV1A5bndyQ3NBT3ljdFEwNm1TM3oyMXBydFV0NjJJ?=
 =?utf-8?B?VzgvVXVJY21rLzkxRkZia2crd0Y2S0g0V3pBOHZpUTFpUWo0R1lUL0ordHR2?=
 =?utf-8?B?TkFRREFZcTBEbjNibnNVQUlSZDZyN1VXWUNoL29CZ2xVU0k1TXhSbVJrUjZp?=
 =?utf-8?B?cXdvZlUxUS8zYlM4Y0tVQ2RDd1paWEhTMnBsOXF3QTZUbVowclp6S3pnZ3Bl?=
 =?utf-8?B?bHdnSEhIMmlHbmxsckgzWE00ZVVQdExZYk0rcG5sZFBvR29kSmh4cFViblVT?=
 =?utf-8?B?dUVqSnhSOCtZS245MEVEZjZ0WEcvbEN2U3BuSFpXSjZSRUJCbDNCdXNpSnQz?=
 =?utf-8?B?bXV2VU81anJ0bWVobi9tVVZUTWhnR0pNT2o1czVvNTA1cE12RmZyOXUrZlpp?=
 =?utf-8?B?Y2JyZk14bzdVSU00b3REWlBtZTZibUtLZVlZU1JmbVBaUUI5UHBCZHlhMU1q?=
 =?utf-8?B?NzhLMWpxOGdIZkhDazJkQzFyTzFYYU5pL29TOVpoK09DcUs5YjhwMENkK0VO?=
 =?utf-8?B?MEhHYUJiVHp0eGU1RUI5OE1RbC9DVFpuTDBrZjZhTW5PclZkSUZ6OUZVNTho?=
 =?utf-8?B?UzRiREZ4ZER6bW9RYXVYcTZRS1A0ZnVPZ3JheE1KZE5XUmsyR0Nja1FOSjd0?=
 =?utf-8?B?akxtTzRtak1XRDhGOFV1ZmFKdk5ZUStpdUZCMnRQOXpIR05pTGZmc3RlMk94?=
 =?utf-8?B?aHBMd0pxdmx0WmQ3c2EzR0VlQW16MTRjWEZkNFJuT3ZvK2dCcUhPUGZxSTRN?=
 =?utf-8?Q?SUzhHi7N4v0i4KjfLuKOn+hde?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a76d52-8bed-4a1e-fe96-08dd517bc7f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 06:57:03.3705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AJx+hqA3Vvcj4oHEnoMw36chyzbLknfwoVqNvH3Chgrwrz8eUziJbyLjauL3bN24tqrHqCiHxmTI8CfrdTHx1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4708
X-OriginatorOrg: intel.com

PiBGcm9tOiBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5
LCBGZWJydWFyeSAxOSwgMjAyNSA4OjUxIFBNDQo+IA0KPiBPbiAyMDI1LzIvMTkgMTY6MDIsIFRp
YW4sIEtldmluIHdyb3RlOg0KPiA+PiBGcm9tOiBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBh
cm0uY29tPg0KPiA+PiBTZW50OiBUaHVyc2RheSwgRmVicnVhcnkgMTMsIDIwMjUgNjoyNSBQTQ0K
PiA+Pg0KPiA+PiBPbiAyMDI1LTAyLTEzIDEwOjEwIGFtLCBZaSBMaXUgd3JvdGU6DQo+ID4+PiBP
biAyMDI1LzIvMTIgMjE6MDAsIFJvYmluIE11cnBoeSB3cm90ZToNCj4gPj4+Pg0KPiA+Pj4+IFl1
cCwgU01NVXYzIGlzIG1vcmUgb3IgbGVzcyBpbiB0aGUgc2FtZSBib2F0IC0gd2UgKmNvdWxkKiBy
ZWFzb25hYmx5DQo+ID4+Pj4gbWFuYWdlIHVucGlubmVkIFMyIGZvciBub24tUENJIGRldmljZXMg
dXNpbmcgdGhlIHN0YWxsIG1vZGVsIHdoZXJlDQo+IHRoZQ0KPiA+Pj4+IEZfVFJBTlNMQVRJT04g
b3IgRl9QRVJNSVNTSU9OIGV2ZW50IHRlbGxzIHVzIGFsbCB3ZSBuZWVkLCBidXQgZm9yDQo+IEFU
Uw0KPiA+Pj4+IGl0J3MgdGhlIHNhbWUgdGhpbmcgd2hlcmUgYnkgdGhlIHRpbWUgdGhlIGZhdWx0
IGhhcyB0YWtlbiBhIHJvdW5kLXRyaXANCj4gPj4+PiB0aHJvdWdoIGFuIEFUUyByZXNwb25zZSBh
bmQgYSBQUkkgcmVxdWVzdCwgd2UndmUgbG9zdCB0aGUgZGV0YWlscyBvZg0KPiA+Pj4+IGV4YWN0
bHkgaG93IGl0IGZhdWx0ZWQgKG9yIGlmIHRoZSBQUkkgcmVxdWVzdCB3YXMgc2VudCBlYWdlcmx5
IHdpdGhvdXQNCj4gPj4+PiBhIHByaW9yIHRyYW5zbGF0aW9uIHJlcXVlc3QsIHRoZW4gd2Ugc2lt
cGx5IGhhdmUgbm8gaWRlYSBhdCBhbGwpLiBUaHVzDQo+ID4+Pj4gdGhlIHByb3NwZWN0aXZlIG1l
Y2hhbmlzbSB3b3VsZCBiZSB0byBpbmplY3QgYSB2aXJ0dWFsIFBSSSwgd2FpdCB1bnRpbA0KPiA+
Pj4+IHdlIHNlZSB0aGUgZ3Vlc3QgaXNzdWUgYSBtYXRjaGluZyBDTURfUFJJX1JFU1AsIHRoZW4g
c25pZmYgdGhlDQo+IElQQS9HUEENCj4gPj4+PiBmb3IgdGhlIGdpdmVuIGlucHV0IGFkZHJlc3Mg
b3V0IG9mIHRoZSBndWVzdCBwYWdldGFibGVzIHRvIHNlZSBpZg0KPiA+Pj4+IHRoZXJlJ3MgYW55
dGhpbmcgdG8gZG8gYXQgUzIgYXMgd2VsbC9pbnN0ZWFkLiBZdWNrLg0KPiA+Pj4NCj4gPj4+IFRo
YW5rcyBmb3IgdGhlIHJlc3BvbnNlLCBSb2Jpbi4gSXQgc2VlbXMgd2UncmUgaW4gdGhlIHNhbWUg
c2l0dWF0aW9uLiA6KA0KPiA+Pj4gT3V0IG9mIGN1cmlvc2l0eSwgd2lsbCB0aGUgdlBSSSByZXNw
b25zZSBwcm92aWRlIHRoZSBJUEEvR1BBIHRvIHRoZQ0KPiA+Pj4gaHlwZXJ2aXNvcj8gSWYgbm90
LCB0aGUgaHlwZXJ2aXNvciB3aWxsIG5lZWQgdG8gZGVyaXZlIGl0IGZyb20gdGhlIEdWQSBvbg0K
PiA+Pj4gaXRzIG93biwgcG9zc2libHkgcmVxdWlyaW5nIHNvZnR3YXJlIHRvIHRyYXZlcnNlIHRo
ZSBndWVzdCBwYWdlIHRhYmxlLg0KPiA+Pg0KPiA+PiBObywgdGhlIFBSSSByZXNwb25zZSBjb21t
YW5kIG9ubHkgY29udGFpbnMgYSBQYWdlIFJlcXVlc3QgR3JvdXAgSW5kZXgsDQo+ID4+IHNvIHRo
ZSBoeXBlcnZpc29yIHdvdWxkIHRoZW4gaGF2ZSB0byBsb29rIHVwIGFsbCB0aGUgb3V0c3RhbmRp
bmcNCj4gPj4gcmVxdWVzdHMgd2l0aCB0aGF0IGluZGV4IHRvIHJldHJpZXZlIHRoZWlyIGlucHV0
IGFkZHJlc3NlcyBhbmQgdGhlbg0KPiA+PiB0cmFuc2xhdGUgdGhlbS4gVGhlIFNNTVUgYXJjaGl0
ZWN0dXJlIGRvZXMgdGVjaG5pY2FsbHkgYWNjb21tb2RhdGUgYQ0KPiA+PiBoYXJkd2FyZS1hc3Np
c3RlZCB0cmFuc2xhdGlvbiBmZWF0dXJlIChBVE9TKSwgYnV0IGl0J3Mgb3B0aW9uYWwgYW5kDQo+
ID4+IHJhcmVseSBpbXBsZW1lbnRlZCAtIGNlcnRhaW5seSBBcm0ncyBpbXBsZW1lbnRhdGlvbnMg
ZG9uJ3QgLSBzbyBpbg0KPiA+PiByZWFsaXR5IHRoYXQgaXMgaW5kZWVkIGEgZ29pbmcgdG8gbWVh
biBzb2Z0d2FyZSB3YWxrcyBhcyB3ZWxsLg0KPiA+Pg0KPiA+DQo+ID4gSW4gY2FzZXMgd2hlcmUg
c29mdHdhcmUgd2Fsa3MgYXJlIGluZXZpdGFibGUsIGl0J3MgcHJvYmFibHkgbW9yZQ0KPiA+IGVm
ZmljaWVudCB0byBkbyB0aGUgd2FsayBlYXJseSB0byBmaWd1cmUgb3V0IHdoZXRoZXIgaXQncyBT
MSBvciBTMg0KPiA+IGZhdWx0ICh0aGVuIG9ubHkgZm9yd2FyZCBzMSBmYXVsdCB0byBndWVzdCks
IHRoYW4gYWx3YXlzIGluamVjdGluZw0KPiA+IGEgdmlydHVhbCBQUkkgdG8gZ3Vlc3QgYW5kIHRo
ZW4gZmlndXJpbmcgb3V0IHdoZXRoZXIgczIgc2hvdWxkIGJlDQo+ID4gZml4ZWQgdG9vIGFmdGVy
IHJlY2VpdmluZyB2UFJJIHJlc3BvbnNlLg0KPiA+DQo+ID4gU29mdHdhcmUgd2Fsa3MgYXJlIGNv
c3RseS4gUHJlZmVyIHRvIG5vdCBzdXBwb3J0aW5nIFMyIGZhdWx0aW5nIGluDQo+ID4gbmVzdGVk
IGNvbmZpZ3VyYXRpb24gdW50aWwgdGhlcmUgaXMgcHJvcGVyIHN1cHBvcnQgZnJvbSBodyB0bw0K
PiA+IHJlcG9ydCB0aGUgbGV2ZWwgKGV2ZW4gYSBzaW1wbGUgaHctY29uZHVjdGVkIHdhbGtpbmcg
aXMgbW9yZQ0KPiA+IGVmZmljaWVudCB0aGFuIGRvaW5nIGl0IGluIHN3KS4NCj4gDQo+IFRoZSBB
TUQgSU9NTVUgc3BlY2lmaWNhdGlvbiBpbmNsdWRlcyBhIGJpdCB0byBpbmRpY2F0ZSB3aGV0aGVy
IHRoZSBQUkkgaXMNCj4gUzIgb3IgUzEuIEhvd2V2ZXIsIHRoZSBBTUQgSU9NTVUgZHJpdmVyIHRy
ZWF0cyBHTj09MCBhcyBhbiBpbnZhbGlkIFBSSS4NCj4gR2l2ZW4gdGhlIGZhY3QsIGxvb2tzIGxp
a2Ugd2UgZG9uJ3QgaGF2ZSBTMiBQUkkgc3VwcG9ydCBpbiBMaW51eCBzbyBmYXIuDQo+IA0KDQp0
aGF0J3MgZm9yIHN1cmUgZ2l2ZW4gd2UgZG9uJ3QgaGF2ZSBzdWNoIHN1cHBvcnQgaW4gY29yZSB5
ZXQuIPCfmIoNCg0Kc28gdGhlIEFNRCBkcml2ZXIgdHJlYXRzIEdOPTAgYXMgYW4gZXJyb3IgZ2l2
ZW4gaXQgc2hvdWxkbid0IGhhcHBlbg0KaW4gc3VwcG9ydGVkIGNvbmZpZ3VyYXRpb25zLg0KDQpJ
ZiBzb21lb25lIHdhbnRzIHRvIHN1cHBvcnQgR049MCB0aGVuIGhlIHdpbGwgbmVlZCB0byBhZGQg
cmVxdWlyZWQNCmxvZ2ljIGluIGlvbW11ZmQvaW9tbXUgYW5kIHRoZW4gdGhlIEFNRCBkcml2ZXIu
IEZvciBub3cgaXQncyBzYWZlDQp0byBleHBsaWNpdGx5IGRpc2FsbG93IFMyIGZhdWx0aW5nIGlu
IG5lc3RpbmcuDQo=
