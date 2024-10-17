Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254046BFC0
	for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 06:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729145517; cv=fail; b=b9LsX0ucuEYRxgyeeYAxwD8yuQt5HAhfjNFyM/HsyyuRTeQ/8pjcf7VhKzRTOeaIsd7Of4ySxMt/6bUGLhQbhbSyDdCp21xGrHk/8WfX64GbVGrUz1aB65cihlto75Y1jIOep8haCSyrXW4eOH9e7TyZhrxtf/U1bDUcqDvAFCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729145517; c=relaxed/simple;
	bh=727LbfTKI/EyQn9JNVGU4Ipt9+ZQyIao9WqkRzY8baw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C1xU9H2YrHiWLnoUM+tWIzTt5vdZYslb3sjL7s8yxLVcLfeiDq0x375zvbp7iVH6veR0b3K0bYDivT84OLSbc9urx0X1Agp3Iz/2CYcAAIB8jJTuuVz9H1Mkzo5jrf/CBZedfjt/WU5lUWt/7++lW7Mwsjy/5cp3ZLvAN6aQsJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ApgV115c; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ApgV115c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729145514; x=1760681514;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=727LbfTKI/EyQn9JNVGU4Ipt9+ZQyIao9WqkRzY8baw=;
  b=ApgV115cNNxY6EjcC4fSWEIWSVFyTKjin5rZYY027aeGkZMIh5SRh/SI
   wjbmmw72Dj+fa/F6ywwhC/fsLetonlYhEl20Mo725FZJl2pJJ4BTq+Ohi
   AzjwrhwHpDDTV+h/Q1XTPRmrMmyrFLUxc2TMW5TvMfHBHhW/Dq/eQwqpe
   7VDvpXBWrR1cI1JtFMwkC00blNhZhDsgk1ao7XNxn5QVzIdnkDY33Dynf
   JXqewVBJ+GJnVLANkMlDBNWzGnexCcJUb7DY7ohrb1nwLSp5fdn5ceNwA
   6kGPEfW3xx98HC16W3mqLJjwHcgDksvxisRTJLB4/a4y3hbUstAjlpXJc
   A==;
X-CSE-ConnectionGUID: UqtZCcNnR/SsGB6FpcOFbg==
X-CSE-MsgGUID: GJLqE52qS02eEfLatMbFqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39738680"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39738680"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 23:11:54 -0700
X-CSE-ConnectionGUID: JUogwn0DQaqA7TqPNrJxDw==
X-CSE-MsgGUID: TNiedv1GQu+yuOUGeLG3bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="109253297"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2024 23:11:53 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 16 Oct 2024 23:11:53 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 16 Oct 2024 23:11:52 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 16 Oct 2024 23:11:52 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Oct 2024 23:11:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KtNigQGlAnqA9Xa/W+2AlvrzxWpvmxMgFCOlrfEiA09Xv64pS2GyjQau0TsJJiTNngf3/pjazx2/encv3VfkdqccrBBKAWb5MUEXBF7Chz5WCxfn9hMRgd6rbcackAIanJdyebZRklB3ZJDyS3bff6wT65jsFpCzOyHalKlAKEViSPtLjPE74D/JNQ1Nufx+OzTR9ujs0+/tfhmxBXqIuRpz70ml1zixOTU+Q+VUjwEDPzctRSBZ6tws9J2a4NsmrkrrMoEkQMlv1rX/AvH6yuKPB1Dh2j0F9zw9f96JBQA8Np3KywCcCvE7Vftw9iL2hisK9Wf00GIjMp12nGxofQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pou0K7ojdHkJ8vNsmemzBDh6SQgc3DWAk9avRiGvwxw=;
 b=jbQnhZGrNCI8ajb6mhOT1C6KjZJj+0OWxg8PVl1klurmfAKOEwkIDoVLYGy58DH8zjwjYx9eI85JA1b+55eHbmwLeVrcNnNGADWDK8nlefjw/q1RPurJ8UL+ltknSR1hInyJzV1Pp9ZSRnjKDpZQSbJYbxk1ZPUU9JDfu8MWsgcX43orl6yUuqKR259iQO2KQ1dYA/NR8UE3YkH7nxkzESWtrx9LKlzHZx7taEC/LP0WmdhKBlWVISpK8SX7fZwTzx7xmtxqGIrOCmKs8Bfm9LhPgd1x8M/KVrIVlyhgabG4n1RaDYS18jUgHJj7PwKSLTc+kZcdRedjEibqRDkLCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA3PR11MB8002.namprd11.prod.outlook.com (2603:10b6:806:2f6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.21; Thu, 17 Oct
 2024 06:11:50 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 06:11:50 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Vasant Hegde <vasant.hegde@amd.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>
Subject: RE: [PATCH v2 6/8] iommu/amd: Enhance domain_alloc_user() to allocate
 PASID capable domain
Thread-Topic: [PATCH v2 6/8] iommu/amd: Enhance domain_alloc_user() to
 allocate PASID capable domain
Thread-Index: AQHbBDRtoHcOryrM5kW9RdA/OpHZ/rKHsUPwgABFHACAAOvccIAA1YoAgAD2pIA=
Date: Thu, 17 Oct 2024 06:11:50 +0000
Message-ID: <BN9PR11MB5276A8F6DFDB1DDBAFD9A0AA8C472@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240911101911.6269-1-vasant.hegde@amd.com>
 <20240911101911.6269-7-vasant.hegde@amd.com>
 <BN9PR11MB5276124F430867613D7117E88C452@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20241015124018.GG1825128@ziepe.ca>
 <BN9PR11MB52769DE1B3AED678713550D18C462@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20241016152846.GC4020792@ziepe.ca>
In-Reply-To: <20241016152846.GC4020792@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA3PR11MB8002:EE_
x-ms-office365-filtering-correlation-id: b64cccf3-6798-402c-b8f3-08dcee7296d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?rha/OWUxCYDq9luqDiMxzZCVV0CSFSpZS34yVALDcAFZJJqTP20jLlC9Hcsb?=
 =?us-ascii?Q?LdrKc8K6aV4WcoDPGo2PRnHlKfTo9ueLI2KyD4aD9vzewNvi4xzG4RGsw5dy?=
 =?us-ascii?Q?6RcOJ46bVM48Vv0Y8ndtHM4G2jYrajN6ozmuDHZUGvV0KfOBnidCi9eadfDE?=
 =?us-ascii?Q?rYHGJhO7iaOnayoCoACrItDJbbvGPyTh2eVPia0D0iQ7TSq9r3x7BTNh2PAq?=
 =?us-ascii?Q?ptK4pxVpzK//k/T/8+CPrL4tCIMydwLzIfSytY4H8dQYkaPRVZ4TaDQ4Voij?=
 =?us-ascii?Q?LdbMJ/cVwTDAhuJiUQ2litzW0MUCo/0VeFVRw8svNVaJbpCISJBR/6nWXc16?=
 =?us-ascii?Q?pekH7/GKNaPODfDX43nDbOvRzH/XWdXVaDrBrpJict8V0cKRvAb5xCIQvmy6?=
 =?us-ascii?Q?lnrSY1u4RzXmHAosssb2IN5/Fp+ZLHjbhS6KmgAQd2llYGPRS/lzZz/VFapP?=
 =?us-ascii?Q?z+yOzIHHCmW0LT6GLzAxNQXtXsh/5NcoDEs4oPGnZV2Qp8IbQ2JV60fW3Ato?=
 =?us-ascii?Q?+pEOs3O1H8JecSsYspH3X68uiJzKfH0/e4COlhFpmXi1NfsZOaivaULFhM1+?=
 =?us-ascii?Q?tGtL+nB7upuTXKHABlxTU4Y9I4gc1AtNWiMX4nNaDbWT7jPtS16WfddEthRj?=
 =?us-ascii?Q?RF/b1JmIs2UH4kMjyjmVzhtbR0PfuZT+Fwre6zqG9qeomRz/mIMT4bqCFxjf?=
 =?us-ascii?Q?X8/+uOGSPrJEEHojldr1bT08cR58dYftHjkDEjGbwc5eTpPZdVcs0YWV5p/z?=
 =?us-ascii?Q?B3cRHLtPxzM/rMVjkhxOjad58C62PuiV14KTHB3Kq+O9VU2DbQeyx8C9se+/?=
 =?us-ascii?Q?LIr2INI8NJhdtWESSxQjXm385w3sNSAW+8gMeVRmttUJr4OTVt1MZkez9Z/F?=
 =?us-ascii?Q?ckL8uxqYBaOG/1O3qV7mLzPNbFQAmwUhOZD41gCm2HzQCb078Oj4NpsAHEba?=
 =?us-ascii?Q?NshBEzGKjbab/YhkfyvTvWlwQuSSiw83R9IS/MnynlFTpgaV+Px9Nb7WWftg?=
 =?us-ascii?Q?kg1/gp+P2K+LNpl+3SffCIKoLINmyrF14gTBu/W8uupKHBaPdRz77d7sGn/O?=
 =?us-ascii?Q?vh5L9ja3U0pNQEbOj7Amwq3uJi10gITK5NUEgRMRYrni7W4vvYGb9aiZ7FyR?=
 =?us-ascii?Q?CbKnJDZCmJDI1qnhsFluAvxsjw9uIC0GpZmo99Z647JKRdkZRHMnRSd/N7CQ?=
 =?us-ascii?Q?oE03zKqcKPOh5Zc2+XFVOL7ZrEp7OMaVB8HqnwyGSP4hDEY2QTDLBSBjx56f?=
 =?us-ascii?Q?Zim2vjY+5YmNAzpTs3pSzNahU7iLYRvTXXc2n39EkFEQFfjknwvwZR3gOVvH?=
 =?us-ascii?Q?+ZhZ3+vD8cKglyICi2DYaDBRhEY9VGMdZphjlVihkFz4xTL4XgIAV7yIhz5i?=
 =?us-ascii?Q?yYGmol0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ssmXup6JsAQWNar4U1XdjMVojuUc2FLNUobhAyOLE1oI0iqPDF4qB17Qqn3+?=
 =?us-ascii?Q?rpGwDaHFXfHrBvcQKJimWL+QgCbPZFUgKacuAoeyj0LR7XR2n3f20ziuj7BX?=
 =?us-ascii?Q?y3rE9MRM78k1yiU9sdeM2fpxDLLBJo61F1sxjb0rkT++BAizR6p4/YcrNTk1?=
 =?us-ascii?Q?sV0bGO86gWl5BXSPmtNA6ys+9loIcCSI4zzlNTCX2J9lx3qjpnf3+W5pyp7H?=
 =?us-ascii?Q?qGdtcCbPdZDmLtBSHjXaS1AXeW4yNJM/EttlcaoS6UmS1bdWvhc+64g131wi?=
 =?us-ascii?Q?cKX0Jq+JdzdG7B3hG5Zqi+n83BFAeOfOqOt1U+hr3vqRLJG1HWgEIQkIQyer?=
 =?us-ascii?Q?V5m8gh0kvzDvNgerNwnP4t0FRDq9a2Juv2/Mgq2Qb4FVlsTUN2ekpzrpSxpA?=
 =?us-ascii?Q?B2l3rDiwNikIGsVWfdav5DtIRA8tBpyse6emwx7GqD0SV2NcX/8ojiiEgLFf?=
 =?us-ascii?Q?t8FiNm4SlgqaTgX16FXSBDtHILXmShWHebIVFASzO6HImiDeG6waPNFn3SZ7?=
 =?us-ascii?Q?qMGOW0QJ28nfPvk4yYRy+aFvhES1zwRyaTz5v6EdEyqBsfYQjaRQ6f0stRA5?=
 =?us-ascii?Q?7R4GSuwM+DbUsUIA6s5m0+6ijeUhzo5G3a4usJtTkkkIayYP5oQaSpXBbDWp?=
 =?us-ascii?Q?03mvTOol5Ms+bWORlcnK61KpI830VB6uW435+TQWJ5NOrD3+cN9aV0bVw/ls?=
 =?us-ascii?Q?Lwwm99QXYk7U//5EkG2PZaEmW9jduFCi2W0mnedBP+i4QU/q9LfhodvkcAyN?=
 =?us-ascii?Q?aPVPDdGjq/RlsL7sMjUfyrMnN836h53f4jWwZLmWqWbBkGVus91z6Fb1t/ix?=
 =?us-ascii?Q?s5aFSgo6GOHmcrzZ3uSqDvnZ1UUyIhB+jUiMg7FLJJPuvNPzIQ0xKOjjtVet?=
 =?us-ascii?Q?GjyPeZUQeQzTQOz3tWYGgTJGKJDeHevuJylwdEDppYBHAq5bq+q7I7SmryUk?=
 =?us-ascii?Q?7gahyRV2a6KLgZgep3ZCEMUZEl2i5AidIzZhfyrf/xFfrEvrOuFuFGJij4uC?=
 =?us-ascii?Q?RJaRqV9ZkeJjcKLnNyGgMeX5raFzP8r4uxuRlgY98pjGUuCE4F1dy08ZQU/3?=
 =?us-ascii?Q?Wl/XU6cS4/tGwhdXuwWmLc5h5nlFio1Jd1zDlhi+RYU/kOIgqJrZ2t8oNYbT?=
 =?us-ascii?Q?22etsgplrTA8Zdfxc+XuBdSIYac8MokP+HgN7htO5FrttdWbPYavNxB7OoI0?=
 =?us-ascii?Q?WFCeNCIcliH53u0pB2+95OzoX76gqahOhOGj1xx6WoBxv6xCoMX4+MbnaXe5?=
 =?us-ascii?Q?Qef6zi3Ha9yeYcoQhrwbaTtd/dGW04XvuYY5G8S87weJ1KfvtGBhVCZKTwuo?=
 =?us-ascii?Q?Hd1ytDQNrilmVAk2ZHaaPrzj7gczoKukeg0wPbHr1RJGjDV4UHvufuoGVamR?=
 =?us-ascii?Q?CbogTiFo9OxeuvOa7zLM0jNxSTJw6xvYx1n8OQ9ZsdvoULHiX2rscouqcVJ5?=
 =?us-ascii?Q?/lwnXOezREMLMH2rTBR2yicuP5rM9KXVIu9g77awe1zApeiv0iGCjhMcLHBH?=
 =?us-ascii?Q?S2TwARMKKvIcbiJJiflTMdS0Qpk8MsU6M3G5HPzKdjloQD5OQ7FD3aPRDlaa?=
 =?us-ascii?Q?O1qL/EDJ9w+xzNfR33D7hgKDAu6DTh+yphWQoX6p?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b64cccf3-6798-402c-b8f3-08dcee7296d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2024 06:11:50.3219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q9pQOxYuDZ+Q7iZvfuZ6tJlV8Bn8xa6wK6u1JYbvgbHsc+PD9OmN6bjCPBxyG22OYixAUhNcCRgTqIC0a6VeeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8002
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Wednesday, October 16, 2024 11:29 PM
>=20
> On Wed, Oct 16, 2024 at 02:48:04AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@ziepe.ca>
> > > Sent: Tuesday, October 15, 2024 8:40 PM
> > >
> > > On Tue, Oct 15, 2024 at 08:41:48AM +0000, Tian, Kevin wrote:
> > >
> > > > > -	return do_iommu_domain_alloc(type, dev, flags,
> AMD_IOMMU_V1);
> > > > > +	/* Allocate v2 page table if IOMMU and device supports
> PASID. */
> > > > > +	if (flags & IOMMU_HWPT_ALLOC_PASID) {
> > > > > +		if (!amd_iommu_pasid_supported() ||
> > > > > +		    !pdev_pasid_supported(dev_data))
> > > > > +			return ERR_PTR(-EINVAL);
> > > >
> > > > Just check the iommu capability here? IMHO it's a sane case to firs=
t
> > > > create a PASID-compatible domain for a device which doesn't support
> > > > PASID and then attach the domain to a PASID-capable device later.
> > >
> > > The point of this series is to allow AMD to select the v1 format as
> > > often as possible because v1 has better performance than v2
> >
> > If the user wants better performance then it should not set the flag.
>=20
> Well, I do tend to agree with that, you mean remove the
> pdev_pasid_supported() ?
>=20

yes
