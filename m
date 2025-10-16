Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5F727732
	for <iommu@lists.linux.dev>; Thu, 16 Oct 2025 07:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760600442; cv=fail; b=indY2+yz7G4pbz6nDXejIt34OAE5cudU5QiDxOssZWkcsEN90h7/IkVK5as/Gni+3uAsukozSYU9viIR5k0RGvIlgNBCSK8ltt6/hWbkjAYsF79v7J4/M0CL3AKwkOFZoFQ7yqgg2RELGjuKO4I/KPOpxAuVx2SNLmV9FCJrtYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760600442; c=relaxed/simple;
	bh=M7vaNtyyEf6FAyGUlZX8jo7Znaix91JAimxLI2RtZFg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N21SZWVFhlcRvax94vqSIy4RZLdJs8c+g3jjcKSchOPuuD7q04FCrSxpHcxfD/RBeFgrJZpmgiGaTLZuPAXwtJfKyCksip55u0U/yLaW2eFiHYH6qSHFb7rx2C6RrHFJghSpbQkg1qQ4lqIEnY7GS1bkpBNRKYMlLFg9f6FMsa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IqSy5I/s; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IqSy5I/s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760600441; x=1792136441;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=M7vaNtyyEf6FAyGUlZX8jo7Znaix91JAimxLI2RtZFg=;
  b=IqSy5I/sV0dNvtmxRaq7zvWBVN0SL74kf7AzFOqSvPfNS2w9UmiJlpiE
   +871uQ1a+ow1zkY73cZcigCcEnE4sqS10Nmt1BgTxBkgm31uwrG5YX5wQ
   wQ0TEJ99n3uoit3X3p8GTXXeAxXbATBVhTYW8CuowgW+A/MxJ/a6CuAuy
   uZHb9sAmjwb2P/nK1DUdbKvr5afE5JMkJGjgyUA5KWCXf9XAfVgYVAPF7
   o2MNXFA8chmMdO6l5FMx6ecILZIb1orhC8Xi6pYz24ujp8jrA5rBFWK6D
   dcrU75IXBFBKJFCBkP3T/5k6PIBlDi8gqY9y/MouNrKFRe9joHfAbKYLh
   g==;
X-CSE-ConnectionGUID: mBsPeOjsSomWyR1HoCkGrw==
X-CSE-MsgGUID: NN9ByzF3QSqpszHN/dDHBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="62825332"
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; 
   d="scan'208";a="62825332"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 00:40:41 -0700
X-CSE-ConnectionGUID: KRjpQjskTNm1HvclLZbDGA==
X-CSE-MsgGUID: qmZaT77ATcOXDE2RRdSulQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; 
   d="scan'208";a="181594395"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 00:40:41 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 00:40:40 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 16 Oct 2025 00:40:40 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.44) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 00:40:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U4oeChFAgj5sAy97UmZppfTFVprjO95qXnYX0fMGTX7zSXZg812A9Ansrk+8QlKToBw7tyzayeH0+3U7PiTpp8sUgrxPC9qxUIkFbEpO7SqpDui0DiLdFcySA07+zqR+vWQ4MCjx4ptK7ZX54XCmEBv/E0BOHl94QMRstt9WQgp4KYKIOXZVc4IAQP99JOmakHIhvcUD6npmfA9yzgojfPSJItwtd900O2mZHh6r2fkGHerEYv4OOl4ezvSBdT0FfltghBN0qJHKLzRb1yfXnNhHkZZy4FHFYRuq+80VP3KSIdHSujOkRS2L6whaQjeoPy7O1arZe0WtqpJQx/+qeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M7vaNtyyEf6FAyGUlZX8jo7Znaix91JAimxLI2RtZFg=;
 b=L4PioXYSsMSnMJdJ96SFfnsWPK0DF8QRf1/SiSDSGI/5AjuKcChoAGqJL8jcTnUzZra2p9BppjGjauvDGrg2rSe2YCK1cXkyt3mjZ72SBt9jlaG4C1kDLayN3neD89JgLmG2Nat8sCVOGvF8F264r/fQ/8KUbxim6F4r0r+ijQQyfb6j0oWJJQA20XAa6kpqO8uKe3Fq1HhH5IpRKLbV+CTfTTWzuJ/DHfkQIEHJ/87EAbkvhdlD2grMVCaW//Iv85OV81c4AarqGmZEULvfcrHZlgrldAh1wnrOSFWDNctvl5oXsYwVOzmjxZtMfbXxIwkJF25P/822GkBLu4aFhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW5PR11MB5787.namprd11.prod.outlook.com (2603:10b6:303:192::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 07:40:31 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.9228.012; Thu, 16 Oct 2025
 07:40:30 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "will@kernel.org"
	<will@kernel.org>, "joro@8bytes.org" <joro@8bytes.org>, "jsnitsel@redhat.com"
	<jsnitsel@redhat.com>, "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "santosh.shukla@amd.com"
	<santosh.shukla@amd.com>, "sairaj.arunkodilkar@amd.com"
	<sairaj.arunkodilkar@amd.com>, "jon.grimm@amd.com" <jon.grimm@amd.com>,
	"Prakash, Prashanth" <prashanthpra@google.com>, "wvw@google.com"
	<wvw@google.com>, "wnliu@google.com" <wnliu@google.com>, "gptran@google.com"
	<gptran@google.com>, "kpsingh@google.com" <kpsingh@google.com>
Subject: RE: [PATCH v5] iommu/amd: Add support for hw_info for iommu
 capability query
Thread-Topic: [PATCH v5] iommu/amd: Add support for hw_info for iommu
 capability query
Thread-Index: AQHcLvCX8WKeHA1XekSUtTetHUftFbTEf1dA
Date: Thu, 16 Oct 2025 07:40:30 +0000
Message-ID: <BN9PR11MB5276E624B7CD6E1D6BA1E12B8CE9A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250926141901.511313-1-suravee.suthikulpanit@amd.com>
In-Reply-To: <20250926141901.511313-1-suravee.suthikulpanit@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW5PR11MB5787:EE_
x-ms-office365-filtering-correlation-id: 1735d551-ffa8-4af2-5fad-08de0c874838
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?dcVrwewIoGSbiRoC49B678aYOBPVrz8fREP2YvsGShFUNbyjzsgOGrl/Phbv?=
 =?us-ascii?Q?l6ip6OqRC4DhfSYeTW6Dsehqn00STDSrNJ/hgor3ycLY4CX5T7jhhcmPdlKi?=
 =?us-ascii?Q?szaEjg9kWp1fiWeJ2i2vMIWl5aIme44dWj9+y7pcneEPC4Pf5L0ZObSvn0k4?=
 =?us-ascii?Q?gZ9oejXrn/4Jzks/KMdilluKWQdJiGS75Ie+KcKXPJXgKSPtD7Ul5jIggvII?=
 =?us-ascii?Q?CNHoKkgJ5IwLefvKNOKZUkyRkZW4m9Ore/il6Lm8sQlDrA/207wqyqXKRM8z?=
 =?us-ascii?Q?3J9GBiuBiHI5shQY7Br0OGHCYmUze1+JMLFNcRKqN/sfuu/2GQ5I8ai5dG+F?=
 =?us-ascii?Q?07+nsA5sTkKrD2xRpa7iOpa62PSId3MfvvfSg1n9hRXfWyqyxPDecllMIgbh?=
 =?us-ascii?Q?ugl4Q71jFivFcpQFN4XyMNlraWwE1EAXjlTlZw6Z1nvpMpdj5LQNBpFYU2uz?=
 =?us-ascii?Q?uEQmebs04Vn5Vu6hSFkDcEUzUP2rkILOoZrbj0EiDEX5y04Q67p66AgHGCYU?=
 =?us-ascii?Q?+AqUcNPPtUBH8+mo5p7DvgFoQtfytIparcCW0rgDe52F6gP4usOgMfAV0vyE?=
 =?us-ascii?Q?nMUdNzM75yK7YDe3def6mTeCoXn9WbaJKArsBqBKuSghl9KcVjXtoM+7ilQ/?=
 =?us-ascii?Q?pgT9DcvYvtlowDS+Lx26OZmdwVTECpr+03N8rSslr4LKGlN4A6yzpLpeCqR3?=
 =?us-ascii?Q?Q1rU/asODRIFGWepvkBSSfdUYqpR+A1OPIto+2XzdSifDxwwBLxl1o0bS9CP?=
 =?us-ascii?Q?Hii6QDgEXlwW5FsrOBLEDZBnuruA4qsBNregXaaX1cdih6dvzGhg2Gv/q+X6?=
 =?us-ascii?Q?KAH5b8klwCND3Cs+MNBj4XPQYNkpR4n99GxyBCxu3poEMvvKa96DwNzNNU35?=
 =?us-ascii?Q?rTjJOqMtWTyuX4q71WnIS8lGi4jAGnNrXwd7jXaS1Az4mj79iSpo28Mus9GS?=
 =?us-ascii?Q?60+0gSgk2Wes8WVCJOp0G+hyWrqz5GR/DMfRI1CQWS7Qyh6EPcYenZfSx6tE?=
 =?us-ascii?Q?r2zx0VUI3uqZgz8qgfTtglvXR1L31kHh29BZy08KiMpQN5Sr0FjWXhUX6Lje?=
 =?us-ascii?Q?pplOtIogNfaQpbccqETftd/knFcL7qzO/Qe0a9fq3okHebRoIv5GpHzgb/7L?=
 =?us-ascii?Q?i0gcHkvV08H9ZYB6TMPpXuWfN9YQ4h+zYeoa97mpo342W5en5eOaMeFbitXU?=
 =?us-ascii?Q?g9wNUORcvVJcXICOSEjlHYllzoX8V9wSPIvEtx7bdtaw8oM4LPXNMDJ+VCk+?=
 =?us-ascii?Q?q07QAwzEvmn19QaDo4g7hep4UoeJ2pMpOSf1ceW9iHNPzYCTiqMrVyzcIKeJ?=
 =?us-ascii?Q?BRVbZ+jt8S4c4h8aSiZG5ddB/wIElI+5L7c1h2nL+0KlDFiov2FRogLIKhca?=
 =?us-ascii?Q?p0nfk8rOK+e+Y4HD6E4ykNN2MqSeqbSxsmsr/poVmx6IDLdP47yOJtLBncce?=
 =?us-ascii?Q?D7KEjfvtxKfzKWWfXl2iK2IG3DstN44EbKGdg3GpzZ7pCVWzW3baQxyjRYYa?=
 =?us-ascii?Q?5J3dZBKQzeG1lAlCGM25X123Hxs9uHSzI7Kf?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J1Moaty31eGuRpOJ3JpDVyeNoEwec42p3Ya2sc4OdpGWr8vhf4+Sk3g/lpBK?=
 =?us-ascii?Q?dmTUG9ZFIyHoxa72RPOO/KlWUPdSMLIrYsHEH6SYO9yopI6jr24LAsvqSPXk?=
 =?us-ascii?Q?zYAFROViZuhvHTUyY9wZxfZyr5CP6OP4rt5qCTQQv21kReOeNsDLL2KAQKJb?=
 =?us-ascii?Q?7wzNzDAKODVB7wcd+b58pnO1Ok6YO/tmguAX9QAyPffb7NR3d5q3KEfToeNB?=
 =?us-ascii?Q?1BxjSA0DSR14hvML0IZcbg9NqqPjdkeHKj6vUt8zRfBcJEnEiAE2SObWY+5p?=
 =?us-ascii?Q?FekTUTE+/25lPPdg+qLGfh7T5s7KZpwar1abaiNRvCfqMgSRlSZ9hn/rfeI9?=
 =?us-ascii?Q?FmNGlhOeFE2G4XAhvYOdsngasLiGrAVpR/MhO/+aoAuv9kKFplJ6mqS+fQQy?=
 =?us-ascii?Q?QQTFCyqpAJDxY4QJiaZzE451LblRKgRFdz8ZeyKHjGx8iVEbxqIsLUyQme/U?=
 =?us-ascii?Q?GVbvT8A8aoFRa4VwyhJ7+cw1+DZViM7JrN3N+FLaMgmH7LhP72hl3Tf78yn1?=
 =?us-ascii?Q?F/Wdbk489rbvxdbH1tVjWj0Aa4oM1FQNs1PybrC64XfW3f7gRM7XiA1iAJBY?=
 =?us-ascii?Q?MaXvdn1CtxULjo2zZTdU7oj5si4/dLptsyESYYwDpVkXCP49+YWbwusgzAQc?=
 =?us-ascii?Q?rl8jWPjl/YWvuYWJevcomJu3MsWmRDacrBRRUHx/9im6WZgx05tu7TP/Lgva?=
 =?us-ascii?Q?F6iloTpEofcMnt+AH8XnSPsHGAXHL2b/RBxOvycmdI/O9zkREr9JCeOtJR8o?=
 =?us-ascii?Q?R60wduX3/nLlDIr9RHLuehGTTyJNFr1iU2WkXYVx0+Zeq8b8hitTWY3CK8zZ?=
 =?us-ascii?Q?xJfhiit5ECt+OG+MUBvyDyMGz7DylrpAhgUsHJsYjUSdNrX0DyS6vwjHu7pW?=
 =?us-ascii?Q?2zlNB7KQVA5lLsjkn66pF7sDtQPfpY6LRqbYRCnFENbQGIYcD+O1Tv7kktSS?=
 =?us-ascii?Q?bVb9SCRX8l4PdIsEhmUgq909lxYvQAiLYGh5opDWbAbl8KD2ZhAQBn/Ni+e7?=
 =?us-ascii?Q?qK7LufTO6etmo+VhsuHkiZB2K1jOJVwA1eh24w4u0mi7mN8iMVMfmWw4rqVI?=
 =?us-ascii?Q?xadqH0PUecT2/NV3+y4VBGvMjQn2YWwrBMB0Yv7hb6UEfPj2YNNtAZg/PV+O?=
 =?us-ascii?Q?XRct0E1ssDr2xhzS5Uw1KkVjI4wBkBIwRD9r5q5n5P0lf81L2diU4jNMGfkq?=
 =?us-ascii?Q?wLokk6DgwYh/fUo8EyoYiBm+dDddClFt3+hkjXLSiwAPssTu8frioeuDeu9a?=
 =?us-ascii?Q?PsFfrWsT7epIXMtjLnzrWF2Ua3tCGpYNCu/hmqGm/PiNC1BRihCN/eFWsO4o?=
 =?us-ascii?Q?aDbVrMkFBnRBhP2+ztdl9dvTVIVqUtwQ2Dfkw7CiYyieWOTyQw5r1JyPmNIp?=
 =?us-ascii?Q?o8BIPcxzxjfna5tKCv6QA1XocUnhx3Nul7nPqUsNV5txZPs2MefGn2owIGWq?=
 =?us-ascii?Q?Xw7fja22xCgqnh0qXRiGjAFu2qnXQU4N8f5E6g3iMKVOH4/UQSGO/9S3sxfF?=
 =?us-ascii?Q?XJ1lEw9P2WZvBgwu4SHzoMWAkLbgjSY0tKUKmVBdhpUXgljZaITHnw+feiYz?=
 =?us-ascii?Q?ZtAvBhIOjySr/tBEpvlkTMv0ksgzU0VWXcaF2WWk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1735d551-ffa8-4af2-5fad-08de0c874838
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 07:40:30.4860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yIr1x9hQSbPgE6s4Lw2hKM3G/5eJbwtNFy1IjKdYLkr93HeygaOlYO9wSIY7wDIFp5sBlVaoav7diG3LirXcTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5787
X-OriginatorOrg: intel.com

> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Sent: Friday, September 26, 2025 10:19 PM
>=20
> +/**
> + * struct iommu_hw_info_amd - AMD IOMMU device info
> + *
> + * @efr : Value of AMD IOMMU Extended Feature Register (EFR)
> + * @efr2: Value of AMD IOMMU Extended Feature 2 Register (EFR2)
> + *
> + * Please See description of these registers in the following sections o=
f
> + * the AMD I/O Virtualization Technology (IOMMU) Specification.
> + * (https://docs.amd.com/v/u/en-US/48882_3.10_PUB)
> + *
> + * - MMIO Offset 0030h IOMMU Extended Feature Register
> + * - MMIO Offset 01A0h IOMMU Extended Feature 2 Register
> + *
> + * Note: The EFR and EFR2 are raw values reported by hardware.
> + * VMM is responsible to determine the appropriate flags to be exposed t=
o
> + * the VM since cetertain features are not currently supported by the ke=
rnel
> + * for HW-vIOMMU.

this hw_info api should work even w/o HW-vIOMMU?

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
