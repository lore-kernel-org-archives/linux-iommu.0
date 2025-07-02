Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BAD24418D
	for <iommu@lists.linux.dev>; Wed,  2 Jul 2025 09:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751447652; cv=fail; b=Avm2eCbfGtP37+YuV7ZrnB28i2PEXJ4lyg4JiF7qbAdoMpqiCUrp8Th7QyxbAYMdT4HAJLuhltBEr6Z6NuH18/eY59p7D4rITUnSvbcCEItFjMZxMxRS5O9NiO+neKSnOBmCvUZxfoBcHKlOMNoGHub61pdMzkDaxdQ5pNUtjsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751447652; c=relaxed/simple;
	bh=BOm/KiEy/Xfki5wlSaykoaAtxKnC2YLYo4/ZB4w9gaw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hPmts+03yBIlWyrwwWJcm8SG6PuhyznOSjqJQMFCQ70f75jG70AxwGrxcyy3GE79DyBu/Fi1/PPSLtGF2WKqmz/TQZqAFKq49yKh+jYAmjn/Aa1VQSj8BUUVuww+Obw7WsGRBD+s0h5nBV68i/1zA8j+HjKTj4FN4XoMLlKbwRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jHlhj9HE; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jHlhj9HE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751447651; x=1782983651;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BOm/KiEy/Xfki5wlSaykoaAtxKnC2YLYo4/ZB4w9gaw=;
  b=jHlhj9HEEC8O22McX/MkjCl6Z2OKgFEo14luGw6ZhbJQRB83wVafPMr8
   kv4e+vVT39g0Uf195zTzdNgD9XBDtaqna5PMsnlzr13re/WEGBJ2vDwcr
   iWhp/JNRvzL4yvTtPUu3mzGkIaGVDOMgSfESrA5KMYWTRAgMV2ayICHs5
   SKNXmXQdYxAICwBLjar8AFDauLVFaaO1xXvsyd4fQzsv3ZY1dRL9F4auu
   3sOr/ic5kgH0PLUp/mL6ot5dfMkOS9nrLmKHDGVkD6ZrjHBB6E7qqNiUG
   v9f/2Fsf4VX5XNkUwermDiUNBerllLP1vVYEEZkSm4xRS+sX3SveqtvS3
   A==;
X-CSE-ConnectionGUID: dLJ/c8ExRLS3Yhwuqz7lOQ==
X-CSE-MsgGUID: sKL6V1nNRaC83Ak7DlVXxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="64333165"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="64333165"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 02:14:02 -0700
X-CSE-ConnectionGUID: lsBwKQP1RkK07Giysz9Uxw==
X-CSE-MsgGUID: 6IYVDm8zSpKEM6C0AEMWFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="154505386"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 02:13:56 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 02:13:53 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 2 Jul 2025 02:13:53 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.87)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 02:13:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tq9r0d9HijV8t19eqnfuZcigUHk0vc2fERuifz7HyZODxqOGmh2MtU1t7xS7nNmYryY0ghjILFYeX5frgkecr23egpXqr8xIviKTf3usi7ELlIq8Qu0UMlDLxMaacHIJZrv8WelzP4opNb3HujTXHT1LTJ0+xh8pLa0B5D2kejNiwylqCfSfISqjKzPi5mtF82CfluDgK8XNuRG6tt4klFYrc5FzF67UWoMVdn+Tx4RyagYW3h+pwQRfq+IkKprGraHBfBZCNwi4wNQSyjtBMmHM3Nn9p2Q8NF7LxN/+nCH0J7BOOLHiGxjkvzbb0rI42J+BK0H4vRT317P7zYJeCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FRig8S7m9fBBxSoFs9Mn9FHbx97rCkH94gqf+v04hO0=;
 b=DTZC6FaYDiOEiv8yigipwSbNddXl0ILoSq6rILBABUmPLq2jOVyo3z9LWn7focUre2ausg77hLTehjHf+c31t4NSguwjxaQYNZpK5JIEWDPg/IDkNmjvnMEMxeHlgDxCTJTYEk4J+mhmcLo3CvIYcPnSH7PGD7NN+1fBCQei/wYRBrlN1NnPEh3pUfkpZxtrUexZagdKhkiS/fsAkeAtqklJ3y3J6r0khieqF1AuBDwHEsv4A50XnGsjbKWyLG9lKjoGuG7DZTURVwlKlcn00gkGxuNzwMj6XDISyKCufCmlmfvWxNZHiN4Nlaj9RPfc5nKcFbisWxuE455MEjThug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA3PR11MB7653.namprd11.prod.outlook.com (2603:10b6:806:306::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Wed, 2 Jul
 2025 09:13:50 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8880.029; Wed, 2 Jul 2025
 09:13:50 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: "will@kernel.org" <will@kernel.org>, "aneesh.kumar@kernel.org"
	<aneesh.kumar@kernel.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>, "aik@amd.com" <aik@amd.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "Xu, Yilun" <yilun.xu@intel.com>
Subject: RE: [PATCH v3 2/5] iommufd: Destroy vdevice on idevice destroy
Thread-Topic: [PATCH v3 2/5] iommufd: Destroy vdevice on idevice destroy
Thread-Index: AQHb5xYEfELQkUiNkEe0HWCoTdGXH7QbQMYwgABBzACAAEwAgIABNaOAgAAwqoCAAO2bgIAAcaJA
Date: Wed, 2 Jul 2025 09:13:50 +0000
Message-ID: <BN9PR11MB52769790C63FFCDC711E80DB8C40A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250627033809.1730752-1-yilun.xu@linux.intel.com>
 <20250627033809.1730752-3-yilun.xu@linux.intel.com>
 <BL1PR11MB52712CE938B57E41C34580908C46A@BL1PR11MB5271.namprd11.prod.outlook.com>
 <aGJkitx6wjfQ888t@yilunxu-OptiPlex-7050> <20250630145051.GY167785@nvidia.com>
 <aGOoCa3BkV7KrwVz@yilunxu-OptiPlex-7050> <20250701121315.GD167785@nvidia.com>
 <aGSYLVmV17g832Ta@yilunxu-OptiPlex-7050>
In-Reply-To: <aGSYLVmV17g832Ta@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA3PR11MB7653:EE_
x-ms-office365-filtering-correlation-id: 1b4d2e97-4fb1-4025-9372-08ddb948c22d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Y9HXV/2v6Ux0YWnTOc+t7nhfrdEEkcRJ1OBc6tLFJHW2UkEv4U6bpBeI7hCc?=
 =?us-ascii?Q?zWAdXGgTOwVUkgcXW8DgyiK20JbmZkp6dhqHRPQEDKAgtDdVwtHTf2EwFnim?=
 =?us-ascii?Q?+F8F7jhttE7nlBeryUO3ecy/zXS2yxiZG2m6x4XaucMDM+Zdc25CStK1CRGm?=
 =?us-ascii?Q?m4c6YZcCNjv8Xb3ptw3Vv/ebzQrHzWSjQenI/U09j96eqhktzMAJ8SQEAeAt?=
 =?us-ascii?Q?ic8NgYc/Ue/HJK9BTMT/E0qS+1e098QbYGWwwxusF4L+wA/J3B/91BJVSbi9?=
 =?us-ascii?Q?kypg7sfq4tMHnWyDuMwJURP1gkt3ak5GCVxpB6ph8Nx48ubRCf8LySPak8px?=
 =?us-ascii?Q?KTPlgGyrgZER+oiQp0EParv9GCipDfe8i1vNhoPjAM1DhoRTtsM9ToL7U7m4?=
 =?us-ascii?Q?KomZm5xOvGtWkmhK2S1oHf9o6asnybjfbEz7kk90T6MAIaY0OXFrn0sB8tlK?=
 =?us-ascii?Q?Ssc2TY5A1Z3BKszw48Eq+nEu3Gwl7rFVqLX32qr8ys3niiZW/45X2LXsY8kN?=
 =?us-ascii?Q?xulaVzH4griVF6NKKsJaknzpTVgja6yIlaIF5nEaSMgQs/JIe4ZJNxX+grJ6?=
 =?us-ascii?Q?OL2QYB9V+yCMlLDUEuko42qX/wtOrvQMZNuTBf+awE0BgJ6+ukdhFUhSWmQn?=
 =?us-ascii?Q?tszEtAvqy7NeDnictiOVMt2C8qbzfcPmsMrNNMwzWP5f0JrOZR2dSFitAJlu?=
 =?us-ascii?Q?7Qgy1xHfsVfoNNrdqvgRTqUucS6qQZx52lCs9KvgkG3YB+1vNoUgyJVc02nF?=
 =?us-ascii?Q?S5pHWkX7wEVOvdLBnjmCTTHCZacjv7SxDg/LU2yiMPNBxqFQPNIzxfWqzDlQ?=
 =?us-ascii?Q?EAcd3HJEi8RuqVyKG5qVwABxUlXNWsqLOL3bA7xqOZz7e5ZNWtoL+4LiGcsR?=
 =?us-ascii?Q?w4gAY0CNS/Sv25nGGWuSsQAlYSOmddaJFT4ZnC4gwXjCRAY9gkgmdHQ2azDo?=
 =?us-ascii?Q?+d9xeohiNxd1vwevbM5qxZDv5huTRCU5ph16zLvPhsCnENNeiH3td06Mp23H?=
 =?us-ascii?Q?sM/aUOg6dQhNKtkbZ53/nRcbPBI+1ZL5V4tJLOKG47hRj+mo0GM3eoDOTenV?=
 =?us-ascii?Q?ciO36mWUhVuQ7n6E9EJjaeU0Di2MC7GAFAy+4nZAKd9VEZ42qDJsP3RV7XEQ?=
 =?us-ascii?Q?3AxuX4B8fGLZn+7ha//QyVkcOBYogkCw5prPmAOFIDYPe65NgAIZPu8GWMqc?=
 =?us-ascii?Q?3rwQJFe97tS7jiFfIij9NkUMCeuLFiaShekt2QJNqdwdnh1UB5vlogbXVU+/?=
 =?us-ascii?Q?slAtr8Cil6vzsPUhWsIBOLEMoJbmJsXzlKB3bgyuncRlsg5fqrg28aSXpzpj?=
 =?us-ascii?Q?hng5MrD4ZByB+UY2/MsVsg1bt9ctuUt2xZzUSxKlr9wCr8XNhUAnqjPJShpB?=
 =?us-ascii?Q?zfyU8lS1bsFm/nUr/TEQva3A0orIYiadSP5pr00yQI3+B93bhh2vxdfoY5uI?=
 =?us-ascii?Q?Iayva0KatjkbJc9qxJ80qt7NNYfcveDFSFHNrLfK1XeT4ADlxzoV7UOMZHbm?=
 =?us-ascii?Q?YxmzlN1AG7HSgYY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b4HfK9PiJgJc9r73mVuXcHo7eF1FB1hsVTYKd/hjcZK6Vf1+ksRd7FMw444g?=
 =?us-ascii?Q?7SxBI6ExHwH/OQfNSfKGQNk+uLl9EWuV1VuDjsgWuCGv2Z9vmAHPTNEd3Ri+?=
 =?us-ascii?Q?kss9NcutCBPP6kKy5Ir3rbDEkFuj9mkwD1WnGY3QSNgciwbeAwPsu+WE3hdc?=
 =?us-ascii?Q?kIbcNW5M7yVxRhuYQYE1yJdqw+pCmel4a/NUv/88TxQdGqmRCnz+IJ7vojcj?=
 =?us-ascii?Q?/9QrrmK6eZWz96lEz+grc6MNdmb3zhMeuOQvilu1Yo9kcOnRJdhwLOqb3hNR?=
 =?us-ascii?Q?zopqnn5I03QqlEozaIcx+qey3jeP6CRj/74D3yPAjusp174ckttaHcLa/Rz5?=
 =?us-ascii?Q?3hmpeXakM+ocbvPFrrZ+Y207B4cm+oCNYyzMY6Qo8rE1uBpTQoBXb3tdEXVy?=
 =?us-ascii?Q?QAKksP7pBtA5lkDyphEDtLuvQ5/1rqqGfTJHQ5tYepnCBsrIpTX6NoP0ff2u?=
 =?us-ascii?Q?UsHPq6qDa0w9LhSLsM8SgZSLUzx6jVfsZ3iH/bhGWysXombbvHNP7PwX2RJX?=
 =?us-ascii?Q?xKCQYZZrVSSLNWfQb7PnVkTQf7I127BMMKHyieT7qNdDikq17SpjoaoU2LPF?=
 =?us-ascii?Q?Ck4kQcERbfnqcQdOaY5on68udhm58QhoOEScXf5MK+kxsAn7UVwxIurqfpgX?=
 =?us-ascii?Q?vRHbQ1katIsb72G45cQzWLvRcqVR3ezLsLI0Z1aKD6msJt4iaNJStzRTZZVc?=
 =?us-ascii?Q?xTLZsikvZwWqzyuQPISuadL4+asNAFM4e8q8/QP2I3/Aqai2KtDgKf07EkM3?=
 =?us-ascii?Q?7KmOMW0Yd4gukuoHrAIoO0PbFzs70fsc1oebg/1P0T9Sduhl9PY7YOU0MaDJ?=
 =?us-ascii?Q?uQ0399yi7p0L3vKVhSGBv22SYN8Gb50RfNJzsq14udbEnp79K9wwVzWkqBB/?=
 =?us-ascii?Q?rlNRAK2zhKHMHFAGIIc7u6yhJjEoTSKYnNrn1QSgxuUVbkaB0GSlCR7dG2k8?=
 =?us-ascii?Q?52IWybzvmrojSb4Jg49OX2U7+w//LPs1mW2yKhSjc3T5DVCB+eeEVhLZj/IG?=
 =?us-ascii?Q?XH5hchrxJe0g1yj3UMStob0oqVCrwXf40GnaxsiTm+O5fFp/Hlf1U5Ruerdy?=
 =?us-ascii?Q?YJfIB6uBDAU2Nwc9TSl3ma3ujG6Fx5JY5U0XvyNCeXE60mCVwvrKSGrW6TMX?=
 =?us-ascii?Q?AiJ/cteDSNf03DmtvVxo9brTH22m9vEasafFyc9gzjf4msbeM59gAII7ZIye?=
 =?us-ascii?Q?H9w1Fphkh+UeFIylPOtFCvKd9+vbrxs1oMD19ZEqKtqXLUMMnVPACAhdy3ye?=
 =?us-ascii?Q?g1NeE2q00hbqJV78BmvK9CtUTQyeguaKs/10KglAzravlMUfJiOAGPsG3cnP?=
 =?us-ascii?Q?haWK8tXNauRTDrzBG4uEjRSMLbQD2qc8ZUKQ2m3xaZ6s2zyAjqA1a5ViYk7v?=
 =?us-ascii?Q?tCX4pIVPklrOo9veMo2XE4Uvk85zzt2yOdLC97nkHWLzL3Ln3ZqsQVh4gdba?=
 =?us-ascii?Q?DpkiqLBHMgndTBmlzbleGFUChFSpstQedATbbbd/l0x/xUgkZZcf0ActLRvy?=
 =?us-ascii?Q?ihULgUwUDUsbcpt15guzsCyhf5Oa0XjCKcIoKnz50HeO45d3AQYJKfoD6BcT?=
 =?us-ascii?Q?6JjutmMXsKTvjGkjfEPGr+1tiidFY9AvQRrDe5N3?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b4d2e97-4fb1-4025-9372-08ddb948c22d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2025 09:13:50.2389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ttWIgjSAXaWTLRC0lK1etIKE/Am4HGQwTpTNT4ckWZpDIJco4d7B7Zv0az7P7jiTx33HX27z5kKm+m9mrZYCSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7653
X-OriginatorOrg: intel.com

> From: Xu Yilun <yilun.xu@linux.intel.com>
> Sent: Wednesday, July 2, 2025 10:24 AM
>=20
> On Tue, Jul 01, 2025 at 09:13:15AM -0300, Jason Gunthorpe wrote:
> > On Tue, Jul 01, 2025 at 05:19:05PM +0800, Xu Yilun wrote:
> > > On Mon, Jun 30, 2025 at 11:50:51AM -0300, Jason Gunthorpe wrote:
> > > > On Mon, Jun 30, 2025 at 06:18:50PM +0800, Xu Yilun wrote:
> > > >
> > > > > I need to reconsider this, seems we need a dedicated vdev lock to
> > > > > synchronize concurrent vdev abort/destroy.
> > > >
> > > > It is not possible to be concurrent
> > > >
> > > > destroy is only called once after it is no longer possible to call
> > > > abort.
> > >
> > > I'm almost about to drop the "abort twice" idea. [1]
> > >
> > > [1]: https://lore.kernel.org/linux-
> iommu/20250625123832.GF167785@nvidia.com/
> > >
> > > See from the flow below,
> > >
> > >   T1. iommufd_device_unbind(idev)
> > > 	iommufd_device_destroy(obj)
> > > 		mutex_lock(&idev->igroup->lock)
> > >  		iommufd_vdevice_abort(idev->vdev.obj)
> > > 		mutex_unlock(&idev->igroup->lock)
> > > 	kfree(obj)
> > >
> > >   T2. iommufd_destroy(vdev_id)
> > > 	iommufd_vdevice_destroy(obj)
> > > 		mutex_lock(&vdev->idev->igroup->lock)
> > > 		iommufd_vdevice_abort(obj);
> > > 		mutex_unlock(&vdev->idev->igroup->lock)
> > > 	kfree(obj)
> > >
> > > iommufd_vdevice_destroy() will access idev->igroup->lock, but it is
> > > possible the idev is already freed at that time:
> > >
> > >                                             iommufd_destroy(vdev_id)
> > >                                             iommufd_vdevice_destroy(o=
bj)
> > >   iommufd_device_unbind(idev)
> > >   iommufd_device_destroy(obj)
> > >   mutex_lock(&idev->igroup->lock)
> > >                                             mutex_lock(&vdev->idev->i=
group->lock) (wait)
> > >   iommufd_vdevice_abort(idev->vdev.obj)
> > >   mutex_unlock(&idev->igroup->lock)
> > >   kfree(obj)
> > >                                             mutex_lock(&vdev->idev->i=
group->lock) (PANIC)
> > >                                             iommufd_vdevice_abort(obj=
)
> > >                                             ...
> >
> > Yes, you can't touch idev inside the destroy function at all, under
> > any version. idev is only valid if you have a refcount on vdev.
> >
> > But why are you touching this lock? Arrange things so abort doesn't
> > touch the idev??
>=20
> idev has a pointer idev->vdev to track the vdev's lifecycle.
> idev->igroup->lock protects the pointer. At the end of
> iommufd_vdevice_destroy() this pointer should be NULLed so that idev
> knows vdev is really destroyed.
>=20
> I haven't found a safer way for vdev to sync up its validness with idev
> w/o touching idev.
>=20
> I was thinking of using vdev->idev and some vdev lock for tracking
> instead. Then iommufd_vdevice_abort() doesn't touch idev. But it is
> still the same, just switch to put idev in risk:
>=20
>=20
>                                                iommufd_destroy(vdev_id)
>                                                iommufd_vdevice_destroy(ob=
j)
>   iommufd_device_unbind(idev)
>   iommufd_device_destroy(obj)
>                                                mutex_lock(&vdev->some_loc=
k)
>   mutex_lock(&idev->vdev->some_lock) (wait)

panic could happen here, between acquiring idev->vdev and
mutex(vdev->some_lock) as vdev might be destroyed/freed=20
in-between.

>                                                iommufd_vdevice_abort(obj)
>                                                mutex_unlock(&vdev->some_l=
ock)
>                                                kfree(obj)
>   mutex_lock(&idev->vdev->some_lock) (PANIC)
>   iommufd_vdevice_abort(idev->vdev.obj)
>   ...
>=20

I cannot find a safe way either, except using certain global lock.

but comparing to that I'd prefer to the original wait approach...
