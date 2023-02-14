Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482047E
	for <iommu@lists.linux.dev>; Tue, 14 Feb 2023 03:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676345286; x=1707881286;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LL+v03R1Y9oTo/ioHMQy1N6UaBw8BkNFSAmUhXr35bw=;
  b=Trcu1hSuVBvfTqt/CQwbsFmKokSPQcMQb6KykC7QHZTEIdDd+9ixSL4m
   ZDizuZkd1Ja356qMtQNEoQ06xIRXHlGNf6YdKaUvasG716JKBaTH90Lhn
   swSLZ7YSV425gxlJmq0GPLIVdzXl25wvKcedcyJ6khTf3lJjgkS1+WkKY
   RTatBqEFh8YzTeHx8a8r7TboIE88xJDjzTD14hwDBLPLepTgAU55/q0gW
   vuVIwBzjZBBCPjsAziRds00WhzE7OUVJmy1qvsivUsU2W4KtvT9nZphFf
   4D8bv3QxtFpdGNdDgpCTr2ViuI/zRvM42vXdw7jbMyDjiq5D9qiTr38lu
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="332377556"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="332377556"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 19:28:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="914582534"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="914582534"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 13 Feb 2023 19:28:05 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 13 Feb 2023 19:28:04 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 13 Feb 2023 19:28:04 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 13 Feb 2023 19:28:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LeqiWcFAQwI7K/VXSNHN1paJG7SpSTAtumDRgHEAmh40AqqAi53WJzL18kSMOAje1Sx32GF7g2Ly78WZSROKN63ffQbxGrf6Z8UdlA23Df8etwVue5IMN5y2KRzA1ev0rWcTg49g1JCQ17KLPwye3SdumckdvoU2iO6mSWEnUzb/MUZ7QZJt4jGPtixe+zTFfU6V+yvmZvxXhit0XDaYrO/lc6cQHYZEmpS15odDA5EEz5AZhWOamtnqZm6uRMIIjIi+TtdLMVH59J1aBGS7gx8fgVtu27Fzz9tSnv5vPpfRs1I0VDIWw8U1gtjGMTuY2SswIrE2EavIBrikpWPj/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LL+v03R1Y9oTo/ioHMQy1N6UaBw8BkNFSAmUhXr35bw=;
 b=oBm8Fr2E4sSp5v7AJh3I4Op/LqAhz8xC2ArLe99rQr12UVGuHKjbQgGlCkXdw7B78vpr2fOn99kgUA+MoS9Qw1sJCZR8chwY2jutcUqE+JEOEgiKCu7htVEKbCEHmm69Zv3l3Ks+NDaK4yNdpjpdP8mKWNUl3KQXA3GTGuIOXcDMJRPrz3S/W/QMD4NoZPZghs0/+Ywcg/MorDvfmi96nS5gk6GoKSf20J84ad1yCTw3QmzligILujIF0vC0OMXgD1sWB34jfqsu+nS7mbSuJb6NPw6R7mVPHKYhOnNMzMwReL4oHLBAaiUGrpfaMxFxIle2Hju59eA4NsvbF6HMlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB5861.namprd11.prod.outlook.com (2603:10b6:510:133::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Tue, 14 Feb
 2023 03:28:01 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%9]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 03:28:01 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: Eric Auger <eric.auger@redhat.com>, "Yang, Lixiao"
	<lixiao.yang@intel.com>, Matthew Rosato <mjrosato@linux.ibm.com>, "Nicolin
 Chen" <nicolinc@nvidia.com>,
	"syzbot+cb1e0978f6bf46b83a58@syzkaller.appspotmail.com"
	<syzbot+cb1e0978f6bf46b83a58@syzkaller.appspotmail.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>
Subject: RE: [PATCH] iommufd: Make sure to zero vfio_iommu_type1_info before
 copying to user
Thread-Topic: [PATCH] iommufd: Make sure to zero vfio_iommu_type1_info before
 copying to user
Thread-Index: AQHZP7gAyBsdiz71z0OT7Gp4MbldKK7NyRUQ
Date: Tue, 14 Feb 2023 03:28:01 +0000
Message-ID: <BN9PR11MB52764DCB79C6CB65FDB9FCDC8CA29@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-a74499ece799+1a-iommufd_get_info_leak_jgg@nvidia.com>
In-Reply-To: <0-v1-a74499ece799+1a-iommufd_get_info_leak_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB5861:EE_
x-ms-office365-filtering-correlation-id: 0b628f11-788a-44f2-d671-08db0e3b79fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3gN3eLHKwG30bt0z2gSdvmG/K3SP4y0CHMMtsimalr95m7e29nUR+TfRHZXYuswwZSiydlZkxboLeiAby7qcph9dIGe4Gw5hJn0BEOtXFdaqGGPQecmK06H4w3n1tEhGDj22f2SqKeAgZKs635B1oMVBEH10PW6ShUdk+Hzrk+vQwVkTFtmWXQpcnGjYPCiB7QTAfNgJRJsM530i3dOUhiAmi9rITJM7XZTiQG5RIWh6jhQz1FqRvb7C6k1T3sTkZkZ7BdZve43aZoID4qvvo34h6DiIRUTMTxFmrrQ7pFJKKbEbSV9jNxPVaPF+28WTBsVGiTIasg5ezZpIeHeqhQbZrltjOlDa4AdlLIdrFbWvJOICvOZ6xwB/X+DdNi8qsI3lSTyqF9gi+4ple9/YiLezopksik/AS8D/RhOYWGJGVEVNh7mTKt+Dg0RKEFti0abOJVhMgzwSlKTw3uYwS4rkruX+PCeeuN4uLCBXJzGrto3HB8qEeCZHzHEtMRPybSct8RSvrSFa1Q8yz0ICPU4A/wxCNXD8wcgNwQg1trW96/cEo2aJUGNUPjJ1agsgczyPGH5K7cUoG2SXDjlZUMfGmETppplNlSB3/6ADB5dPxpT5w1Nla7YBcbq2+jJiv9lqz1TXRcld++87X+vgNvFucNyrm268kTOJxAVDXmz5cnXR9yEojECNV3Ht6GJTIohHpsB9INi0/2wArIbmnw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(366004)(376002)(136003)(396003)(39860400002)(451199018)(55016003)(4744005)(2906002)(478600001)(33656002)(107886003)(6506007)(9686003)(26005)(186003)(7696005)(82960400001)(71200400001)(86362001)(122000001)(4326008)(38100700002)(38070700005)(8676002)(66946007)(52536014)(41300700001)(66446008)(64756008)(8936002)(66556008)(5660300002)(66476007)(54906003)(316002)(110136005)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f5nhZmT9F0chiiYp4s6hak+/tyrpllII01Ja5//5Yoz1smp1IymEpDOOADxL?=
 =?us-ascii?Q?TXlwRNgseVvb8zrY9/LJooB0jg3SRoTJPOakQe2pIHMrSK5ydGIVA//h51gK?=
 =?us-ascii?Q?4YUb95v2F+d2DSvmmpLk1Y6rBq8YZT9cYV1VjNdwkk53ddAV7cisimD/vhxv?=
 =?us-ascii?Q?OwdpNaez35V79cHnYBXvvR15NvdVgNra9oLon6W0Aq7rRK9ElHvpcjSBFRRK?=
 =?us-ascii?Q?vE6/KP9mqy8vppjd4VbCtV+D6GArQtmISMbiXjn0xJkkEZ2dBC2ZZO15Rnz/?=
 =?us-ascii?Q?WiaPG9hDU9WYRX/5ZC1XqVRddPj58Bx0wZBbmTyDMRsc/cDg5An4+5WyJtKP?=
 =?us-ascii?Q?6V6rTItEbvpv1coHD7XOH5vIinnJuLVgYiQ20fIjDFumXPzV70GriqXZW5aZ?=
 =?us-ascii?Q?luLNUwScnxKe5oeiEmWxro4rbOOScraTRL4ZT5WOoAG51JgGqtHFxagW2WlO?=
 =?us-ascii?Q?B0IeMn9eNPtj9OuVwH8rwmcQAhsecrWW7+gCWRfZJyNK/rurUgFFLS8DWvxb?=
 =?us-ascii?Q?TD1Nxmh2coB5rbT869hN284Xi79VVZ8j5Vma1+vIVDFDrkYwJeWsaRu6UM/x?=
 =?us-ascii?Q?HB2y+qv1OPHGpmIt4Sat18B9A+0G0k/8tBjtLdJEudCbtoZDj2Ug7kykbgKA?=
 =?us-ascii?Q?N4dg6v/Z1vjH1NI1S23F4pP19ROIFunAvQRhOD8bBwW1EaIXZcQ/6fzcB1cV?=
 =?us-ascii?Q?WOFZ2ai5a95VCeq9M6J9ykpw7UvNjmF+PNFPQhZUtQzDlZHcowkLzlMrNQiX?=
 =?us-ascii?Q?WNmwxRoettiOZHc5qMQn0yUtMWvU02+Wzu+MsCrCkndIWZeW0KZ+jBIxVrp9?=
 =?us-ascii?Q?fhqpvMV8s3jK8b7nKIs749Al49ysJUMgojGgcz0ooJEeawyXK3wkE+9MEZUw?=
 =?us-ascii?Q?UhJxoGyCTemo9PvP1+n01RrtzVbLW3nZNtZVRWvtn1FKTxQQwESutplEr+Qs?=
 =?us-ascii?Q?0fXfiIU//mK51U9VlAR+CSJiI/lnM3tRhxfzg4jfWNCDT613lsDTJGQJfJPU?=
 =?us-ascii?Q?GUq0RrWe5sNMS+iXmlXkeT5oYV+JZ6sf8FiZe/57IQdY3XLEgSnf/kJEWqEC?=
 =?us-ascii?Q?5i5Y9kriWezi//O7nDp+lRBKwRj/41YL9exJsMPJVoiRL6LT7TMQI5DvXBtX?=
 =?us-ascii?Q?lB3qsAbF9iaqXu8IE5TkB25lyitqWbejJP68XXqMtwfo3bLUlIki1I09hjVe?=
 =?us-ascii?Q?jsj0ZbzhNeIZmmnb/kEaeWpnv7t6TuG8kxyc8VMOzhJrXKS5EnUJ3Lc8nrOK?=
 =?us-ascii?Q?MhzXHux/Vv3jwQZSKVBcVFjWzTcR7t2AFzpRBkp87kOBRrHc01dXAuzHPDIG?=
 =?us-ascii?Q?S3JGQc9wTdRigXDJP7Jj7mvTmVLml1fT2STkllhRthNAV3+qQ9srIn2iKetK?=
 =?us-ascii?Q?m68qfJFW9ov66oDh/o6DhgiMQrCtyTrATM8KwnAyS73n9F2cWLxVtxheF5BF?=
 =?us-ascii?Q?DKvCbW3Rrf+83lrTWBqu8iE1t7IsIxgTYwYxX8/M2OdLWGCvfuk53/I9Cin5?=
 =?us-ascii?Q?if7fqG7wNE43jcGBauvNd+dSe86Trtw3wkjcr/9by/oh+hhXQy1E/2w+sq43?=
 =?us-ascii?Q?sBBCtHHPdwDwQOZV14X2dXl23Nsp8S7n+ClkRr0R?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b628f11-788a-44f2-d671-08db0e3b79fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2023 03:28:01.5282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hikTrOxq+FB+oCa1zfevif03OV5gpbJAhBFUJXoYVRJTPskJxvu5uamSi5Z2x0LKc9hpTpfaQq+JHl9kHZXclw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5861
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Monday, February 13, 2023 10:32 PM
>=20
> Missed a zero initialization here. Most of the struct is filled with
> a copy_from_user(), however minsz for that copy is smaller than the
> actual struct by 8 bytes, thus we don't fill the padding.
>=20
> Cc: stable@vger.kernel.org # 6.1+
> Fixes: d624d6652a65 ("iommufd: vfio container FD ioctl compatibility")
> Reported-by: syzbot+cb1e0978f6bf46b83a58@syzkaller.appspotmail.com
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
