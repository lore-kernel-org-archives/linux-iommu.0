Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC12819478
	for <iommu@lists.linux.dev>; Wed, 31 Jul 2024 05:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722405513; cv=fail; b=sA+o71dx8fVo0RkeSYbd796yl3QOwHHnjAlqAOz+R4XSCOmTKnHTtWBdWiXQh3RFT3hrqqVMUq5t3WdKqZSGGpxmVq0qvOT1JDl6OYknivdtVZGE8gQJ/1mb5+8/YtVoaDh6qCTcljH7A23qfGd2ZYGcz1eYT5EFzJQDBAxY9ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722405513; c=relaxed/simple;
	bh=yjJpKx5RtBHkwJtS5cjksenoa5nT/N1X1+MwuwC7QHE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c5c7DgNw6synFMbP+n9KytVyToxJ2k/Seqae/TNVRmXS4PRZyEAGEuc0MPorgjosoI/SVcl06H09ftEJS/wQ649IzXDrFWLaEORUQk/HYsLWoA0+kfuADMSCOPUjNnH72HGNXwKmx1NCywvCHe+WAXoh2R42I8R/NiGEb1sQrlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dm8k2kbr; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dm8k2kbr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722405511; x=1753941511;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yjJpKx5RtBHkwJtS5cjksenoa5nT/N1X1+MwuwC7QHE=;
  b=Dm8k2kbr50zr6CKahk8Yj5sFOBUf8BlQoh8Px9E9A2Mu3FW76ZUhGE0t
   s58GQLG/qCRDyAk/d2Qw51yuUwCm6HLlEvfk0s9CdHHwD5oKsp76kLhJ9
   usPvA1Pmva+G/J+oDW5kXCxYTfGWp4Xz9u81IzVyeX2KEjW0/xE8tTMvp
   bXWdmpEZRYf/y6dWaf0HGv9+mgJHIEekzljZMXyFDne13e1j70W0h+uQK
   3//W9ldH3mgEMeYYcv105rbw3aaZPMt9hklbw+EBUOOHBFeVz1MiH+Ima
   g+JKilIKUc0y4Jv2PLAhgtMFKdY6ThLjxBk0RdBRy+p75guJOORHA/EGu
   g==;
X-CSE-ConnectionGUID: Crl41YJQSoSb+XhCJaUU6w==
X-CSE-MsgGUID: LC30qf9USRaX7sx+vY5ulw==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="20419877"
X-IronPort-AV: E=Sophos;i="6.09,250,1716274800"; 
   d="scan'208";a="20419877"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 22:58:31 -0700
X-CSE-ConnectionGUID: Iwbj1P/TQtq5FXtfXYzPyA==
X-CSE-MsgGUID: RqBZbQL3SoiTUBfK1OzChw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,250,1716274800"; 
   d="scan'208";a="59203048"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jul 2024 22:58:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 30 Jul 2024 22:58:28 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 30 Jul 2024 22:58:28 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 30 Jul 2024 22:58:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZLtdBk12CZW0lOUuDUAx/ORVDMfZ8eMfyOhFgaYBDCgKFXZCbN3BrU+MlsxiQ7ONYcK9d81VUcRvc+YAND4+/OQk7Y8mbVNMQ3uKXo8EQAdSQ8UA0etCibyOl3/yGhPGFvh5O9X87IFWWHPYJnPTZacsC5fg0gNAexNe8QAc5EkIBkhG3BJlzxJ5x24aryq0WoXy20rAgkZyA1ZLoC8/CNnWxlcISh1jYIs5SP6M06iqqkA8uTOPcbGCrxwIRA7nh5kETJz2ESthGENuJIo+SpjwZdSFCJuTfSQZvUYIXi0yiaRCRzqqtO73Vu1TmLniEIOvSvpxXZBqPEZIwdUNSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBHECw/lgiGBSFOGEmsC9HXP01qJHLUe6GsoblJ7ozc=;
 b=R18BH9BMeC5R2Ri6KP3BhrC0kxBd3UG7OYP5YwzKb/AnEnqj/52qNH6nRAcxC5tyxNFA46pUMADtrYp2+8EAIqU3WUmSz9ELDQ/pUefCSI0vT9zCuLOI/pwRoBsOI7QM6xncup0+TRxy/FaOgGItOaAlfjzBjD7TSILGSA7gHRLerhFoikFu/d+7eYWPAKUg+GmGnPdZpe+9EXQGU3ouJ0pHqk6Do1HOqZseSye+cALhHLmzWhkMaTMqlB1ItsxN6vH3W6VXAmWRSa7p2HmpxNdK7w/Q2IfWfIzukqgbIrZz+6v6PBch96HzsLmIfusnFon/WuRcX9z3Phx20gqbUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB6473.namprd11.prod.outlook.com (2603:10b6:510:1f3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.30; Wed, 31 Jul
 2024 05:58:26 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%3]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 05:58:26 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, LKML <linux-kernel@vger.kernel.org>, Lu Baolu
	<baolu.lu@linux.intel.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, "Zhang, Tina" <tina.zhang@intel.com>,
	"Kumar, Sanjay K" <sanjay.k.kumar@intel.com>
Subject: RE: [PATCH v2] iommu/vt-d: Fix potential lockup if qi_submit_sync
 called with 0 count
Thread-Topic: [PATCH v2] iommu/vt-d: Fix potential lockup if qi_submit_sync
 called with 0 count
Thread-Index: AQHa4TCDEUGPBZaX4EKRjfenNA+p77IQWq5Q
Date: Wed, 31 Jul 2024 05:58:25 +0000
Message-ID: <BN9PR11MB5276FD0AB21F4702175185D98CB12@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240728210059.1964602-1-jacob.jun.pan@linux.intel.com>
In-Reply-To: <20240728210059.1964602-1-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB6473:EE_
x-ms-office365-filtering-correlation-id: 32ff10b6-760a-4b99-99a3-08dcb125cb2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?G3Vh9/45gMz180nMu2mWc0P2ENlbVf4Xb2xBHuzZcFjELeCdSeIB7NzOKV/x?=
 =?us-ascii?Q?52ocxkb15UI4Saq6YmHk/qiBogTGoASKarlSK31zilBSN80cDxQbUYDNIs8t?=
 =?us-ascii?Q?DV/OeCkXo0AoNMS5pkCgQSfZ2BaOlDKCUx9nP0tdnfaDEo/7xDzsdxDVgLLB?=
 =?us-ascii?Q?TExKvDcfyPokcq9owo9TDPrh0Eze5USrdw56Eck1vsG8RKb7uV3XzEKd36m0?=
 =?us-ascii?Q?A6fvjxuePuGC6iBwa+fq6XUTEfHsfOOcPczMf1OSzTX4loNtsqB6HAKtC6b5?=
 =?us-ascii?Q?AELcf5zM1dIRfvbG6TqIJgbicup2rWBnWAJGLTmAYREsq7dBhezaH/zC4eXm?=
 =?us-ascii?Q?3QhSlOQO9ebVJqy+388cgdPHIXH5gbNoL2g+Ew8MA/9FBgx55lghdRMTJ9tU?=
 =?us-ascii?Q?4zT5Uc8LHoZSmgisLmhcPfO4zMK0TYz1mGjQlMMIXDr8uGzNAfh4zcg29juJ?=
 =?us-ascii?Q?MqGo88OO2do8LuIGSt2tBZb5QStM0JHrd/Ro+O8fCMso7FXjDRXXrcuDWN+I?=
 =?us-ascii?Q?Rk04BxvFQpPg44SS/5szWyjdeyiCNV1PSjkWrixFOTfD4XGXg6cVGxBSJgp7?=
 =?us-ascii?Q?nHjn12ET1cDbhDMpN1u+F6M4wFZ6ixc8ogES0S6+OMMq6NSK+NCeZJhin11c?=
 =?us-ascii?Q?j3vf6JfU5lN6hV0zImsGXEBewKcdHaaLK1cf0EPQAMKjop4eVlYTfjfsHBQ+?=
 =?us-ascii?Q?ICicd6S9CwEFPoqdZMFwQtVJlv35LYC1ABPb4IX4YLfaJpMqXjulJ63ps53/?=
 =?us-ascii?Q?zRVUb4c89z0uzxGRXMJ/hF/v/vo1IUQ0RXxFsHU3Inkhyoi2fVNxE6a2boAN?=
 =?us-ascii?Q?fdJBt9wSaoIJyDJzyUOSxxFE+Xv/DWdHDXXmH9EmX6Dsg3QCESkQIjXUcpPy?=
 =?us-ascii?Q?hl5oUzg3fUtKxUk+/v44rBd+YPaYN8lOSitNXE9QB7R1NoHXTknCxgHZJQcm?=
 =?us-ascii?Q?6UW2Jedfmj/FQJXjAElGaoDb9lXT5s4wXkUsGvD76wZWORuNmtrS+X43TDCC?=
 =?us-ascii?Q?qoxCWUh+CigidVe9iIVjBxNlyXhDJ0P1m+BUDJk6ZgB2bxR23uPdLf8h954e?=
 =?us-ascii?Q?upsf9St/XoHaUfBdsSF03kiSJcD7vblltZ9Ue0u22HEiEwtU/AuL77ha2jlZ?=
 =?us-ascii?Q?ZTlxcGFShKZw1xL3sn3AAptHFqMvXgPbyzF7nhiGIgsviCLdpXr0vfR2KaJZ?=
 =?us-ascii?Q?k8HlcorC3aRlWGmzkDCdf2cCPd4JLMsETM0Owe+FEbiGF2O9ASm5RVxpcL2N?=
 =?us-ascii?Q?m7yUf+1KHlrXkMTF+UjtdqKMZxj+kpKnxeAiIP3lAZVbl6/kL5JnD2tTF2EQ?=
 =?us-ascii?Q?oAi/kSe9nh25+5iEQmrYH3VtIPIY7VW+2maabZ2sPIanWGgIv47y/RpEZoVv?=
 =?us-ascii?Q?+XJIlD6iF41H4ZhdUcQ5RdV8x6pOtwBDFtGmo6vPCQtMKK5Naw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZfZRe0432sp4UiTI8Pj3O9Catc7l3jyBApsP+krfGyMDXLecKRjtBSspzVsP?=
 =?us-ascii?Q?u+PeL/QCAhdNyd3KyHxp7yvM9Ke2qIJteUA7Lsoy6PqHant74kPze+KxAIAi?=
 =?us-ascii?Q?X+EAgDuogZ+kfW+53fZmrtKi3mX0tuDijedHVIjMTSt8NA9UHjkXOu7wlv4L?=
 =?us-ascii?Q?99Rs2PCBwwFwoJ4x0QXDmqJtG8jIfDREJyuk3A6/F1ayEcD8JoDkilzwtSdC?=
 =?us-ascii?Q?m6XTBe4wdRTTtNhLvwrQXuqyea5QnYav0enkGWJc57w2qkcvr+AIY5WT6qkx?=
 =?us-ascii?Q?UWIr0mDFVxx9TC0OzLWNCcZNN7R4C9v6oJNYIYYfCrj7atP04wTkZS/HZKbH?=
 =?us-ascii?Q?YVZAXGbF8yBktMds6a/1aB6i9gtFQhtaXVNzr30h19b4aYg88xOf/8YnA/DZ?=
 =?us-ascii?Q?EYeXSB/3fkUTPKtFycPlm8ognaMEuW7qolTXs9LvE2J8x8hSW8Mj4xov8NqZ?=
 =?us-ascii?Q?0EkbzGpfV5C5b4Zti3PVsT7FD64QpUbIzpFVH9Huhi2L0j1yPEW+J7Nm0dVr?=
 =?us-ascii?Q?r3J2NV0n6+px84J7ZDShcCIBLAI8R32qSq9C93PtnRkral0sX+rqJwLMvLr2?=
 =?us-ascii?Q?6w3sishwAOm8yEu9MNVjFYrjUYzPjdp3Xsp3JAWMzGENXKkOeFP/JRiaE7+Y?=
 =?us-ascii?Q?nGvMPidVfjRPKl1o2BdwQgOwhzVtd0JH3bEtbTAy0c1MZVD/lvp4hElz07ol?=
 =?us-ascii?Q?94jlyO9oeLYeQdhEEQ5GRYkXLG/PhS4PA1gQPQ90GVXj9SLTVa7gDNbymdop?=
 =?us-ascii?Q?3EJkgwun7SN90g71Fal97RsJYnl2C6pDks4qeTdLnFB4kR+fS9Y2KmWP+MVb?=
 =?us-ascii?Q?o3qmJbfKOTf+Jf4JVfFv8OMUW7WFnWjtpDJlT9/9KpoR/23wJbMULVaY9nht?=
 =?us-ascii?Q?bnKpCNWu7K0diszS25BVFiSjdvBxicDELsY/QxTXW+6WPYjb4qNpMuiSUeml?=
 =?us-ascii?Q?4X/I6AHZPlmlp01dvbxYFSDePPXglsgGXwqblGaagg0lNo/AL2UW2gtkGK6q?=
 =?us-ascii?Q?JUJdTigHvMbcMasd2ZCGg+5hbne9p+ZXRNn7eA98WO1H1OEaWHPwz39pr9Fw?=
 =?us-ascii?Q?A71jhXNTf4aWvff/OL0h40hTYfb81hGHxLB+288hZatDCzKZ4G0gvlH4hl8y?=
 =?us-ascii?Q?FJEfHUoojNTH+UPMJQrhxL4/5A4j2GkTWJ50jw9wU2m92kFNCCcPoDcstg+4?=
 =?us-ascii?Q?99q6ZYsLTXp6/eLomMig06AUNqGS+rxwjiyMrILNBZJdXuGPAJ7mMln6ZBWc?=
 =?us-ascii?Q?Tykg/sHt8VbvCCQ8GOY958fsWEIFDfGY7+vRE0Q7M2ChQTBZE90I08NOWJza?=
 =?us-ascii?Q?rKC19CfkFTqIDGo0hsQk1TB79hrhS6A2Esiwd+wKpl1KtqfVb6YU8Bk75+2Y?=
 =?us-ascii?Q?ohzEkA69YqQ9eIOJrMoCypo6CAUse+7vVStTzxo4XwREwjUX+pQo11po/5qP?=
 =?us-ascii?Q?6ipfexcEBNkKPC17HPrRKOZAYbex0pe2jYfaRYm/7gSxG7zJ2kzcS9gapBEo?=
 =?us-ascii?Q?pryfMdENuyxNN+wNnqmriUNmz+iA/bvsUUDJqOCqQnb4jLFVYTZpyGzF2sdx?=
 =?us-ascii?Q?Znk7s9Qyi1Hl3njQ8xCzEQSFlO+wTghMvxMPtDUA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 32ff10b6-760a-4b99-99a3-08dcb125cb2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2024 05:58:26.0246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1vCOpIjYmD2tkWSj49I3xINMthALqHTKRyqiTSMdkSt04rXOcq3eOMKRG2yr3eb3yvjB27fMmnuyTw7Oww3/+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6473
X-OriginatorOrg: intel.com

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Monday, July 29, 2024 5:01 AM
>=20
> From: Sanjay K Kumar <sanjay.k.kumar@intel.com>
>=20
> If qi_submit_sync() is invoked with 0 invalidation descriptors (for
> instance, for DMA draining purposes), we can run into a bug where a
> submitting thread fails to detect the completion of invalidation_wait.
> Subsequently, this led to a soft lockup. Currently, there is no impact
> by this bug on the existing users because no callers are submitting
> invalidations with 0 descriptors. This fix will enable future users
> (such as DMA drain) calling qi_submit_sync() with 0 count.
>=20
> Suppose thread T1 invokes qi_submit_sync() with non-zero descriptors,
> while
> concurrently, thread T2 calls qi_submit_sync() with zero descriptors. Bot=
h
> threads then enter a while loop, waiting for their respective descriptors
> to complete. T1 detects its completion (i.e., T1's invalidation_wait stat=
us
> changes to QI_DONE by HW) and proceeds to call reclaim_free_desc() to
> reclaim all descriptors, potentially including adjacent ones of other
> threads that are also marked as QI_DONE.
>=20
> During this time, while T2 is waiting to acquire the qi->q_lock, the IOMM=
U
> hardware may complete the invalidation for T2, setting its status to
> QI_DONE. However, if T1's execution of reclaim_free_desc() frees T2's
> invalidation_wait descriptor and changes its status to QI_FREE, T2 will
> not observe the QI_DONE status for its invalidation_wait and will
> indefinitely remain stuck.
>=20
> This soft lockup does not occur when only non-zero descriptors are
> submitted.In such cases, invalidation descriptors are interspersed among
> wait descriptors with the status QI_IN_USE, acting as barriers. These
> barriers prevent the reclaim code from mistakenly freeing descriptors
> belonging to other submitters.
>=20
> Considered the following example timeline:
> 	T1			T2
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 	ID1
> 	WD1
> 	while(WD1!=3DQI_DONE)
> 	unlock
> 				lock
> 	WD1=3DQI_DONE*		WD2
> 				while(WD2!=3DQI_DONE)
> 				unlock
> 	lock
> 	WD1=3D=3DQI_DONE?
> 	ID1=3DQI_DONE		WD2=3DDONE*
> 	reclaim()
> 	ID1=3DFREE
> 	WD1=3DFREE
> 	WD2=3DFREE
> 	unlock
> 				soft lockup! T2 never sees QI_DONE in WD2
>=20
> Where:
> ID =3D invalidation descriptor
> WD =3D wait descriptor
> * Written by hardware
>=20
> The root of the problem is that the descriptor status QI_DONE flag is use=
d
> for two conflicting purposes:
> 1. signal a descriptor is ready for reclaim (to be freed)
> 2. signal by the hardware that a wait descriptor is complete
>=20
> The solution (in this patch) is state separation by using QI_FREE flag
> for #1.
>=20
> Once a thread's invalidation descriptors are complete, their status would
> be set to QI_FREE. The reclaim_free_desc() function would then only
> free descriptors marked as QI_FREE instead of those marked as
> QI_DONE. This change ensures that T2 (from the previous example) will
> correctly observe the completion of its invalidation_wait (marked as
> QI_DONE).
>=20
> Signed-off-by: Sanjay K Kumar <sanjay.k.kumar@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>=20

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
