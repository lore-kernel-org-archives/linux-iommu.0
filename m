Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FF528F0
	for <iommu@lists.linux.dev>; Tue, 14 Feb 2023 06:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676355249; x=1707891249;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iwGG1Tyi8ySrgKSFlcokLS/PHYdoYxknXgJCeyx964A=;
  b=TbwfCpBiHXjwqwK5TsE545Toa6Pk3yqsjzGRleTWv4HfEZonfbfllIot
   1U0h7GJQ8K0ZaWblU5QcHk/bhSwa+hfzqAu7IVn7FMASUmSOBghp+UJdy
   vm5MC1CPoQOrFK3RH+BfIEhR2NltNggW/JT4lb3ogAaIg3kHqvgfHwYUO
   PsXbusBXdvDoFv5zK+abY/2ldwPYyqCZlSVwkyzhhv50M/uwBbDZ4Q1eE
   rKg9OI0fjEgXq9cuzf2pTadNOFZSrYmg1a9aJl2U2/utYo//YkQltAnf2
   OQA9HjhRvC5EtrtTWvLiaR5twFXzQpOr2viMwQkrUFoFLVYRYeP/5nkXe
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="319119894"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="319119894"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 22:14:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="669054019"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="669054019"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 13 Feb 2023 22:14:09 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 13 Feb 2023 22:14:08 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 13 Feb 2023 22:14:08 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 13 Feb 2023 22:14:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WhqOsLcYe9v3NKDQTxw9tFDDcinMRhmrmK+daKwqeThl389la2Vx2WDQzV8UDlUcuLxSt+sxsoKYmm5TluH5UpxokLPg7CJPsOIe1ZGZkr79BOvN40+qQpBSU0uGlQgUo4+623+GG+/WtkW8UAwMFp8Rx/45m12uc0xjapAOPgHiUChQlkS65Stw1kMxJ9ZhQwYxxj92Oq0IA0saeheTFTTinnUNXWwUZ8C7Tzf3nwqF3vUEZWFVyz6n+LWnlUjxc2sflYQb8Xuuemd13YlnFBfmgyBeNZFsr5h13j6a7ru0Ba+MFjSo9V3nDDddzZiCIxsZFrbaOrx8dxXE/9AwIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJpabytU21PJkJ32robNmIQ70Hf1OTrij0uVgNanZ/c=;
 b=N6Orl8UPc26bhgp3mprmX/JakMFiem5A3IFEsC+6Q1sVkWOdTt/urDq7dfu+698GtRoJeC1YgWPz2/AxQbHkTNU/++p1oCus3xqxSqReTe5sn6EB+xhR97Qhsg/6oxABydlEmemvudJhmSbD7Lj25ae6kyvPhm55jwzWbCT08Kz21EyoF+k71+e9Kfa57NmW7sV0WG5LcLu+QUjFKe1y3dlg9woQbOBcLYHwdC0bkxfFrFANnvc3ZcnAdqexPZfRuMVa1TVUP65x+FCnYT7OkVGpg9xWn2OPOTGoE1urt9DH5PUG0A71WzbS2uouY+dff5OWjOhFYXjYtsgFrZqXSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB6664.namprd11.prod.outlook.com (2603:10b6:806:258::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 06:14:07 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%9]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 06:14:07 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: "Yang, Lixiao" <lixiao.yang@intel.com>, Matthew Rosato
	<mjrosato@linux.ibm.com>, Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>
Subject: RE: [PATCH 4/4] iommufd: Simplify the lifecycle of a hwpt
Thread-Topic: [PATCH 4/4] iommufd: Simplify the lifecycle of a hwpt
Thread-Index: AQHZP9VsBWJcznnu8E22uq2hHhkC/67N9YRA
Date: Tue, 14 Feb 2023 06:14:07 +0000
Message-ID: <BN9PR11MB5276D5B247C1F93A5FEB46838CA29@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-4336b5cb2fe4+1d7-iommufd_hwpt_jgg@nvidia.com>
 <4-v1-4336b5cb2fe4+1d7-iommufd_hwpt_jgg@nvidia.com>
In-Reply-To: <4-v1-4336b5cb2fe4+1d7-iommufd_hwpt_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB6664:EE_
x-ms-office365-filtering-correlation-id: fb2a7008-e079-4b81-f9ab-08db0e52adf9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FBQoSh0xM5dGPeGzhui+pgT97PzmFjQz/WleXuhCqFJxi7HALgxF1U6qx0Ln2dY/0PN9Nwf8YyS9/LPTp+DwSXmLw881/zG5qN7PXGqbkMsj7mon6Oa/ZjS1bWuUXZjkR3QCqaTCVhKU1PWTs43b7SzUnt44vd2ZOMT1Pwg971e/PUSoTAXXIDBH3RluV0f5fZMNJvE13EJ02agKMKpZU5T+f5bmExNRYkAjkfHiHmy1+ib23F8lYN4QSOpUdpW9mrWgn2/c7uevGrcKwY9GYiA3SjflzX91YO7gFex5QCJhiszVvs3S+KCoiT9VrV00igLWIvGX4cH1wz6qEYS9iXO9DYxtzieHTyuTr17ZNrG5ffCKMhxR24UVDk/LTPw99Ts7h6qguSYhejqOio1gznZxX7pXMlhYnCLDBeLa94VGquFOU24MvhU0G0E5j/a3HxJf/VDq0LBdK12DjsVLEoVJQVeRedUVWc9WoFzEWnEOG6n9a2zv62yPak+XV0MeM4D8z2FnaxnrIRt+01AAYf8bKePhuYavn7i4BKia4iRHor2HksI1V3PmIqZKgx01cddmRIsDSiBayWdDie06sO2J5bn9LXXpn8Y6VH5DC9ae5lGIxgVZFV+4xpTAK3/bHE7SV/xtpKJ1EUo6RkWyGM9sXhUoqrpeIDx+oGrlb4PssXYJDyqKFinHw/jNfcF9+wR3TpIuQrP9r68MjlySWg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(346002)(136003)(376002)(396003)(451199018)(86362001)(33656002)(38070700005)(55016003)(71200400001)(66556008)(66476007)(64756008)(66946007)(66446008)(8676002)(110136005)(316002)(76116006)(6506007)(54906003)(26005)(186003)(9686003)(7696005)(478600001)(107886003)(2906002)(122000001)(4326008)(38100700002)(52536014)(8936002)(41300700001)(5660300002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eSvzmsNU13cm4Ke0SobNL8PSShLHFAQbTcCnCFxswbnXkOsABG/osd2hkj/k?=
 =?us-ascii?Q?FNMnpTHXSc1SmopXUHjal4D2oMa7ov9OulyCslU/Youj2ArrNdKpudhYWhUx?=
 =?us-ascii?Q?b5vBKZdVTEr+6+6mJeIPMsw7YLKXG1c1srgPQwqwljf6xv2v11SXwoF3iUAW?=
 =?us-ascii?Q?yJtYwx+UUr7j7b9LSSc9P0imOMfjVPRvhFnOl9pBLBMpMGA7i+3bXl7JMGuw?=
 =?us-ascii?Q?+0ssJb+lJmlylBQCtAqvGxEHUtsb4bRg4xMgwu44MvAcB4T7AmaIUhrglIIW?=
 =?us-ascii?Q?bpOKRywGBjvC+MjvLeUYuQ8SjRh10WT3rAwo+2QlYej8yVKKa/Q8pzSKByhd?=
 =?us-ascii?Q?COyuveXVp8/DmvcaONZztEjbvGY8WdzSTjgRpEfaOrppzW1t6QQOvIGWoFu1?=
 =?us-ascii?Q?qhh1eC5KJ4BC6JtKfEspSZicDw8m2Yv6gO2Y0nVgc/hKUdCHNwxvRoVkbskX?=
 =?us-ascii?Q?nvSxmNs2O4UPfFIQAKqDXBlmlKyZ5843E/pEF2FwvupDaoN/pC9P4QGgKVue?=
 =?us-ascii?Q?qeQW4MK2W1UYEq/2EMeInAjq0pph8FDSoMTl0lsY+bXs7y6Wxr3vNpWnRMO2?=
 =?us-ascii?Q?nOZ3Dgklq9M530TugGYhwv/TfYSMW1N7Zla3e3av+jCWcMcsRMvuoIK24eyh?=
 =?us-ascii?Q?z4kBDvU4RfYS22LfCqQOGJgEB0WLZwg67usFubJWQrzPCtyWq8q3OLYxT7+q?=
 =?us-ascii?Q?nhIAycNYWCVK13j2/lRlCS5Wh5ZILC+lROsugIkTNLDkrihactOHTY8BX6YU?=
 =?us-ascii?Q?hRX9yn5qO1Z0I05jUoifFgOoQ4CpaH0HCvARYtJpoAS8XXxa3atGbn3DrOgW?=
 =?us-ascii?Q?fwnGDAM9A1DZxwgfbjOpFTnAHHB8tZELEldFrWgd5Emhe20qk28d1w+UGt/L?=
 =?us-ascii?Q?4VBQ8NgiUfoZTyONhV+sUEEqAaBgiMAdofmLkSu6jwKA2LWRksCQ6hnUGZtK?=
 =?us-ascii?Q?AE1OdOmvIQ42vb2blqccE5GZjikT+DYvQ3QKuGciUb7dPiTgDZP8+knECEaS?=
 =?us-ascii?Q?Vzluu2orIyzvNNE8CmvyQiAopLo0KDTtZa9Mx7x/Bn4F69ZGqn1FCJolxGUu?=
 =?us-ascii?Q?BUgwe62JiPdu9iB9njGc1R7aVTHYLsHT115gzqFgQNRnYwX0kl/CkGafnPtF?=
 =?us-ascii?Q?Jfu2vgQ4XkwTXIoyv3NB3rXeHjjNqta6yp71qVjM02Tz0lThST7VpaJSsNuf?=
 =?us-ascii?Q?0uPwo+SYrgCYc3HyvI8+mUSjswo0yktpEq4JoNcBQso92HmmdcOCKXG79r12?=
 =?us-ascii?Q?8OFgg0MYShHjoLbkymF9HeXaCxTKVF+sJZW60VghBToMSlCRGC5lKGCN2b6A?=
 =?us-ascii?Q?5xJSBf0oWbA32fkGjd870sWy/MKb232BDjDBPmYO2VZi0YdyN0EhJm6wIDGy?=
 =?us-ascii?Q?YETK+zEHrrfQdp7xOfYPo+9jt6bbJoOoepyFX+VJpqfftuE8nWmBmZwSxfLd?=
 =?us-ascii?Q?GmufNakqH4pHb7NRae4tgIOzINKiZmo/zqccDTCUytULhsve+0jmWHMgF0cQ?=
 =?us-ascii?Q?Ts6LDxrZD9DBTVEHvQc69wcKnnx316R2FqsQwUzWzM4S65U2tqVLez502CJz?=
 =?us-ascii?Q?+8xuOw/CwKer5/SXWF+MjfJMLMuEFmWUKBWo5NsK?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fb2a7008-e079-4b81-f9ab-08db0e52adf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2023 06:14:07.1536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5KF/c6RQz2vcHEAYwkZh8BWF8H5ZLOkm0TVXLIcFRd7HyoWdcw6MyR74NHY46LLq8lO7R+RhQylFt6SRC03/Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6664
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, February 14, 2023 2:03 AM
>=20
> The HWPT is connected to the ioas when it is finished being created and
> should remain connected until it is destroyed.
>=20
> Instead of trying to disconnect the HWPT manually during
> iommufd_device_detach() simply use the object reference counting
> mechanism
> and free it when the refcount reaches 0.
>=20
> This means the ioas->hwpt_list can have an item with a 0 refcount during
> races, a prior patch made sure this is safe.
>=20
> Add a new API iommufd_hw_pagetable_finalize() to formalize this contract.

Can you add a few words how you expect this to be called in manually
created hwpt case? the new API requires it to be called after
iopt_table_add_domain() which is part of iommufd_device_do_attach()
now. Do you intend to move iopt_table_add_domain() into hwpt
creation path so this finalize API is also called there or leave it as toda=
y
which means again need to track first device in the group to finalize?
=20
> @@ -10,9 +10,18 @@ void iommufd_hw_pagetable_destroy(struct
> iommufd_object *obj)
>  {
>  	struct iommufd_hw_pagetable *hwpt =3D
>  		container_of(obj, struct iommufd_hw_pagetable, obj);
> +	bool finalize_done;
>=20

'finalized'
