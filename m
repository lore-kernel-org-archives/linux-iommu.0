Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A4018622
	for <iommu@lists.linux.dev>; Wed, 25 Oct 2023 07:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gDkyPPFj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698219204; x=1729755204;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bilahOkRTBOU+xjyMWHPVnqwm9uAyVjF6FyzEX3EA3k=;
  b=gDkyPPFjURXaTSMQ9094g3+rg9Gbh4voCVYhqMJ3hxBcUhz53tHk6nFI
   7CP0UkS/j016Z87ylTVdn/cFj26tMiWRn/Du/Iy06XmKWxN8tnzd9f/H3
   GCYIVbkCg20PNpzQKj7gw7nMDRAwHo/f3sd6VNQwfz36pvLhlUdS+OVwL
   KP2LZ2F4YKVb3T5HDdi5h2M+zZjHBxuzd3ZPzebdZLYnHXkT7nAq3PWi4
   tM3p/z4rd7zbxtueF/O/N1i4RsO7Js9hGvNc+ZcG9bKJcHA/L2h9vdDHk
   F5Vvevaqfift6QVdTrOLWiRfz0gYQsAxHa3WNL4nZX7w3r+yq+yw8esu/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="384465463"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="384465463"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 00:33:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="824570933"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="824570933"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2023 00:33:16 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 25 Oct 2023 00:33:15 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 25 Oct 2023 00:33:15 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 25 Oct 2023 00:33:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ewh8WE/LSat20puGKmfSEWbMAOTnJHNN/f/o9Ai77AmtLjovgspPHhk1GH9bas7dL1+w0N4UFObVGgqc6s7VBO6ln50RhfXpB0I11VL7xZUGB1JGtElTDfuXJXSU1Iaa5w5fiDYSXPdZksvnCg9VpBSGFfILExJ8AXarIgYyRhO0ZLle5KACaZ1ajbsmi/Ki1+Q7U0+3WRxZwbc7i2RqV3pHww45HXDHb4CMHpWPM5D0+NEF4UD4DpyY+nY++ZsVIHX/IcAq2RtjFjZ7UG6RDXJ0dIjg52iLQpz2dtmAiIiOsY76GWS9F78UqZgBSq3n3xcHlfmQYiTYe8zsD5cgHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bilahOkRTBOU+xjyMWHPVnqwm9uAyVjF6FyzEX3EA3k=;
 b=HyfPPZzSxdDsT9HqXKoD8lJbRsyL0dO9l4xSGdbEMWvaj508gdF+TszhJR6hW5SfhFSNg0/Nia4mOdQ1I4UIJdq3oLhhvPNBfLemGBDXSANdmr8991FYusLNGV2XCMDArXMeftN7YbtnpxWTgl+0ZxP1mOglEM74zbGj26MEOQVGUjyKsY/Nc5ECh+OrPN+GlxZtgyh5YNt3BPTWMFWM16w9enwTQ4j+DULEHRKFd7bBTxndY0LOflxaY9IrSlhSrn0ejLpqg1VfaXM/U1oV494GoC+embTtINW2rwY+GCokv12llfOqy6o8Wiv04oy4sftDfFAwt9mtvJhRpNVmdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS7PR11MB7740.namprd11.prod.outlook.com (2603:10b6:8:e0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 07:33:13 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 07:33:12 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
CC: "cohuck@redhat.com" <cohuck@redhat.com>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mjrosato@linux.ibm.com"
	<mjrosato@linux.ibm.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "yi.y.sun@linux.intel.com"
	<yi.y.sun@linux.intel.com>, "peterx@redhat.com" <peterx@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "lulu@redhat.com" <lulu@redhat.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "Martins, Joao"
	<joao.m.martins@oracle.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: RE: [PATCH v7 6/8] iommu/vt-d: Set the nested domain to a device
Thread-Topic: [PATCH v7 6/8] iommu/vt-d: Set the nested domain to a device
Thread-Index: AQHaBozME24rKKicg0u9N4JqTWFPqbBaHdAg
Date: Wed, 25 Oct 2023 07:33:12 +0000
Message-ID: <BN9PR11MB527658FC5A75C1B16DD8A8C18CDEA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231024151412.50046-1-yi.l.liu@intel.com>
 <20231024151412.50046-7-yi.l.liu@intel.com>
In-Reply-To: <20231024151412.50046-7-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS7PR11MB7740:EE_
x-ms-office365-filtering-correlation-id: faa6a9d4-a73c-47da-06a9-08dbd52ca52f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HRUtZZMx27y/B3MurJHsIw2Nk+153NUhyYsHqFwQVuJ1Gs/XXxspU/74cuPzJclYgUW7saaTn9SKHqYxTbK6Rl5c/Js8oKYQVYvguNmrrTb/wZkSNJiNT9UfyUzA/cpdOqyGvXTnpB3w3JLMeZ1KNzp+WLE5FXpTHsoGf7e+3NCx7XSRWZFn+rkqHAkZ9LuPUE8sjasmQ2wsuWjonPuQPxatHtmltHuS2tXBH1SOXfSQdKT6CDY8vqKsbthED1jdFBve4+YIegIGQYVZuSlelCzk+LDkW4E68n13A8T53b6dcNUzvlS1qQZWA0kzQEIBVVJHkK5c7naJEuTtvVlJIV+ULfhylCj3ChUMVcJ0vxjg++GO6cN8OAAm5FwpRMSDWWKEBIjUMWVtAtQCA3MKZAyKKng6D86mdtVuWfBOl3ZXwEWJC5c/iYmftSvhhJUV2N7Qj52io/5RH9lSmCO+UbOYHiXG70mx0F8StFip0Yvs4/5KF1P/j2uphkxrexeMnh/Mcl3vP/K+OZy+JNjVzBzFuMlo+U28lzg9Ode84GiylLJDMxe+QCV1uh6rreTyGbSFzUmSuRFJehEAdNwL0gkBCOeCHvCHab4fBkiEXOJBjyv8wzsGlcG23IkEpv6R
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(366004)(396003)(346002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(110136005)(26005)(478600001)(76116006)(86362001)(6506007)(316002)(7696005)(54906003)(64756008)(66476007)(66446008)(66946007)(66556008)(38100700002)(38070700009)(33656002)(558084003)(52536014)(2906002)(8676002)(122000001)(71200400001)(7416002)(4326008)(8936002)(82960400001)(5660300002)(41300700001)(55016003)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eZWU2IpyYFSrb6IyqNttUBySRClJ1SNhto0w6V5phVOmtfyfdEtEaj6XWZEO?=
 =?us-ascii?Q?SeomIopexpt64Ujjp6gZPE5/ePVr8MBQ/G6nLKQ6Ynv17Dp+CA+RZ5DAJLJr?=
 =?us-ascii?Q?yhyc0033ZFBhfo+0iNa8sr9gE739YWT6jznmx1l8r7iGtDb+URQI58fNtKmx?=
 =?us-ascii?Q?TjyOrLvKTnyH+f7MlOl69txeneZfUASU3nkqttvZNXIRNACSah5fo9+UNqQF?=
 =?us-ascii?Q?Ru/qriijJsf5xDS3e6Pagy9jMqC44H05eg5HfhM2zyH1l6qdowWHWj4bBEj6?=
 =?us-ascii?Q?Sbe/BNEHs5vXwq2A6dG+wOedbLUxFmXhQvF9q0zDeBxe0Rn+UAVmeO/YDkPq?=
 =?us-ascii?Q?TSPlaBvR6YDTdXunVHmlDEjC5xEmgDDrkRtLCB+aoAKH8sO7lqW+Eb9It57x?=
 =?us-ascii?Q?BeL5yb7JkYjT2YAxeET8AjGb4YEEsxj2Rn4zC9evadQdASWSGwGuLIpV6z7K?=
 =?us-ascii?Q?HUUXd9ExZoErDWjmetuNlB1g7M7eOaEEXC7PlSPxtuyJcn4cILDeSRlwMidh?=
 =?us-ascii?Q?tIgVwvn7jnG4hSuxJ0JuHnaxyGu2g/18r5BpUqx3Pj8VH22K7eJOZfIuGjXh?=
 =?us-ascii?Q?+6cMO7xjEok57HZW2Jek6ja1aaQmhSy+38nOpHUDAy3yIbRf6xN0XHYuufu8?=
 =?us-ascii?Q?4z8P3LoqpLxgr6Par3qQ7yEmHRzNgsby6DTxhwl8j+n/2lDL1HDkx2eF1aPX?=
 =?us-ascii?Q?xyeZHFVvRT9ySgetpRZfbn5g9dKRyFzSj19d6RaHojbpEu6pTgUtO6eJo+y4?=
 =?us-ascii?Q?NxhaR612TfgsaPdYPsFbO0zQ7ZF2+fJg9vhgq4EMCS1nG4Kom/bThbZsr1BX?=
 =?us-ascii?Q?bwkXA06QXeXlnzI8CuPQKDPhWfPLMbvox+RbOCxvw5CUA2CXG/Wb8FznyUEB?=
 =?us-ascii?Q?brGL2sLVftoWnPpsOQ0hnrZCqjhgWgwX+NNQfha6ObGpZRM78rT2Vel221ND?=
 =?us-ascii?Q?EbkwQndipmTFI38JPlNhMMG2WjykVzZLwKyE2Aa8uo4P+B4u+2nvVRfUiJie?=
 =?us-ascii?Q?6F2++ffWA/b3tpuIm4ZLOjLfG+UO7gRiu80/YqVfy9p54bX9slu0OGWyyNw+?=
 =?us-ascii?Q?1wO0OI29whT08bASSTfVUgXVJh2smEUEczgnVd1hffS/3Y0jGyWPqCPic2H2?=
 =?us-ascii?Q?yQpUg0olBbY0k8two84tYcAKYk2/8ALxSChh873qARGPDoYfY4c/pdgSVf5r?=
 =?us-ascii?Q?ddh9mQmpv0e1UHOu/SBDRNIbMEOFZPck/5QBYsfJgsf8Spy5Ap3vXy/5CKKi?=
 =?us-ascii?Q?yLjmAA8woTuKAdenVNqYeNEiLYdWbU1LJgaJac6ZLXONxTp8GHGGEggqa53S?=
 =?us-ascii?Q?29rDaZ+8NeUCvRTV1S7uOLHzgzuMZOwJB+nNiB8uDtVWuMfrtcDUQRpnryLo?=
 =?us-ascii?Q?/JAna4eGhXWcxKHlE8y2bnMdVtwByX0sHHgFe6He75i6RQgoWArNLkSqi+pD?=
 =?us-ascii?Q?qcbgKxv7V7vmAsSVLbyV2cDk2I450U3yNXfPApoWKjEBrZbLQDzBbDbaJEDO?=
 =?us-ascii?Q?BIdeTO+CTlRjgM4sYI206tLIOV0BDhhNak/68yodP3+gHpmUeG4Ro6ra1VqU?=
 =?us-ascii?Q?vjhUyJ9jVihk7Alk9ck8tIpsTFZAS8Zc+U+2mib+?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: faa6a9d4-a73c-47da-06a9-08dbd52ca52f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 07:33:12.9290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A18Oylh+HzX5wvY2kNc98eXMs7PCMsC3QRxpHwyz9HlB/exobYDsle1SJ4sz+b9l/jaIti+sbBV/9RPCre1YxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7740
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Tuesday, October 24, 2023 11:14 PM
>=20
> This adds the helper for setting the nested domain to a device hence
> enable nested domain usage on Intel VT-d.
>=20
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
