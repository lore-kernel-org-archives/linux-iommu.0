Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5E67E
	for <iommu@lists.linux.dev>; Tue,  4 Apr 2023 02:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680574541; x=1712110541;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Fb4SfYTKU9CozRj/fLAJIIfDFUoWl1Xm8dJ0bIhlF24=;
  b=NwmGbchE325PUpb1x38O62b3QSDukXjk5pD4FweWZ//7e94UM/GtPFYK
   OF+hC7tMVlci+GlSsb9vmvNbEAZUQIIx9BnH4HZ3z6tBa2Kb/orDVDNqK
   rfFoiMJJTgTRYZIwh0L/qQz1ZaGtTfyFdT7+tpvIrcSwaImYF8ocbABDk
   TmXNmW1McHVRDMINg34cf5VUIc/zatfoyOwXArb0FuV+o9gHMjf20wpNY
   RBtSsrkeTAk7DkRLxRKtKG3m89JZCm2LdWlWFQBkZAzQqFs1/QHYl4mXa
   Xryy9uCyc3rX4KJhV9ABPVO08sbvq0egUMyZW6syeD7HLfAyoV9rQPoDj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="330651835"
X-IronPort-AV: E=Sophos;i="5.98,316,1673942400"; 
   d="scan'208";a="330651835"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 19:15:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="716483859"
X-IronPort-AV: E=Sophos;i="5.98,316,1673942400"; 
   d="scan'208";a="716483859"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 03 Apr 2023 19:15:41 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 3 Apr 2023 19:15:40 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 3 Apr 2023 19:15:40 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 3 Apr 2023 19:15:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+eLPGieEDHlJ8SjI2ewUdHN+DjrY+3j3+sRw4K6thF3s+y+KX5UdoJgjkE/EIsJ5l01DjwGCT5qyl5l/6iwJ+r3M6rfXmE1zOSSGOgG9+58jcjXMaO/oVUY3uY4f0GXL4xvULv5u4MnD3l5UpkzBJqG+J5EVi5UeVbr3lqDGqUcNbTLPuYPpQNiOlEIU0mMhITrh7xAcflGpBtq60JAnTnXzM31+q79L848tS/y5tysHI10EguID7D9hvJX47s+0H2F0WU4UUJQSJGtRxzBitX6hidapW+Q2CdsD1xuCM6zvNfTDZ6g1V4Tzoli/kppsEjljl89fM8UDB4b4FKGAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fb4SfYTKU9CozRj/fLAJIIfDFUoWl1Xm8dJ0bIhlF24=;
 b=WYYQbIW7zyK9y4KKRpqoE2Z7rqr+z8wj0FQ9PZ1+UszVAOkdQYrUXowL3BITaXgJqCCxU9X54mblHWQdskFc+GKrqH1czgcAOnX7O/8CdqyRsfJsVgSQeZOyLTYgTyxnf77DjTY7wVWWU8cw7u7yjPLnrO6ryqw6OGZISd7FsbqccHb1CpIYrRwcokfSnaApjqD0HCFBn0ZQ8J5dIa1gp2qOiE+XWAt7XM1+Y4WIdv94ndaDqkzSrbJeWAGRqn0OrF4C9oRrpJdtkUJGsp1DC9EbamU1h1riiW3eTpPSnbNq48Db/8sSPP1jpmN251nPxRCwlqBkqc8W2/jh9Bci2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB7650.namprd11.prod.outlook.com (2603:10b6:8:149::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Tue, 4 Apr
 2023 02:15:38 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174%8]) with mapi id 15.20.6254.033; Tue, 4 Apr 2023
 02:15:38 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: Robin Murphy <robin.murphy@arm.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "jean-philippe@linaro.org"
	<jean-philippe@linaro.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: RE: Cache Invalidation Solution for Nested IOMMU
Thread-Topic: Cache Invalidation Solution for Nested IOMMU
Thread-Index: AQHZZcP3mH7GyOXUf0KLGMUJbSmHMq8ZN1MQgABujgCAAMMqwA==
Date: Tue, 4 Apr 2023 02:15:38 +0000
Message-ID: <BN9PR11MB527677A2CE0BA99AABE4FA928C939@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <ZCoe3+1q5ZLJsmeC@Asurada-Nvidia>
 <BN9PR11MB5276B2F0CA8D14C0C07CB5EF8C929@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZCrizNMduHUgsg6a@Asurada-Nvidia>
In-Reply-To: <ZCrizNMduHUgsg6a@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB7650:EE_
x-ms-office365-filtering-correlation-id: 10f5c187-b9dc-4ca5-95e3-08db34b27bbc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kBksoFBECiEAAHHRiNcF/iiq/sK+TcgsaD7C9oQ2yV2+qnX4nP4OWUGM6adexImMunrQgWaPKzCSx8c4ww3Coj1pQKW2GYb9qjXp7XTmLQy8hRWDSdZ6mLk312irUvrLWI3pLS0P3Bq5OZYq99hfc22JK/mdUurXfm+JCPp6nj5B2rWQL4kqTQMFj8gwjj+3L75pGgEZ9+UkNnSzZH3pGvQdlYeJZCxq0nByNzR81a4XVw16i3vrwjjydBEGCC7xU2ZHr1lO//R+9IKAbIqO1mPkt9bfH7J7owqYeb/P5dfOBKnkwBurnXvELdgMRnIe0o/KcFilp3sZRPIt+LH7tG0jRE68gn91YYYNwWXZo7xAhhVVpUoO3oFyNFUYi+rncpM5hCt47daDgusoxnGKDM6hCFOU7Va3Q24mk7Fa18NWvV78/Fss4f1CvsRfuo5df0BErM62usmwsOkcXxrBoA1HejeY+HcaWZ+IsWaF0e9BmBoj6cQ2833sfxj2dclZoakNFtDCr9sUHSuuKUHZgJqvJzwWnVyCZfGxrRhyBD7XdiqGLIyPtLXI/mNb05YXI+7TwqI47FVeYcetHL1qKw05b/ij2Neb5QUoULWuEzCEMKU8IOobeDLkpYYsRtZU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(346002)(396003)(39860400002)(376002)(451199021)(71200400001)(2906002)(55016003)(186003)(33656002)(26005)(6506007)(9686003)(7696005)(122000001)(5660300002)(8936002)(38100700002)(54906003)(82960400001)(4326008)(76116006)(66946007)(64756008)(8676002)(66446008)(38070700005)(66556008)(52536014)(66476007)(6916009)(41300700001)(316002)(86362001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3P3JSbPVg1O8WjW2zDcJetuxgz4omHaORE8hVuQLGVBRrfNzp57QEG1quMdK?=
 =?us-ascii?Q?R/I7c0FlQX8ukTxtSu/pSMPOYchxdeLRIJW9RMtVXlzeBuef3S+x0U7zcIYd?=
 =?us-ascii?Q?XWW3emY/2/QiOxuAVzvRzX3awzhFPRNE1s59knCrYnF0zy9PwJEwITzMHwe/?=
 =?us-ascii?Q?JODOnv2zKrjlp3rsybjMBIaYwlX3SVMUrSo4CbAdWO/+fLpPnLyzvnZ6f9MJ?=
 =?us-ascii?Q?cKV4gJC+2B3dAJ0q+m3w6FnmY56ZMt0khRQPVRPoMabo4b49rxva0gSXIFzl?=
 =?us-ascii?Q?61cJK+u51rYwY89Q3O1aDXE5KrvcAO+F/nPFjrKj/qb0zND+/60rZy/kRUvY?=
 =?us-ascii?Q?bK6X1bQf4DcK7g87UnJDgI+W6olOSz3BuA62Qcg1CMPwhtAzXu+KOVjNKLs/?=
 =?us-ascii?Q?FUN0U6XkB5fGYTmI2ybMaJWvdFTQ/whWDpILLA6WiFG45cvhMUMYjlQUAgqK?=
 =?us-ascii?Q?0biqu3jSP3ZlcrhFDVQyB+Ng4hUBSaG1QfLt5vtMSCHhX7p2K2K4slIVavSF?=
 =?us-ascii?Q?Q6Pi/RD3cKnr4D59j0fUfa624vGQWuOsL4jMgieVlPTssTt//lT+vgQM39YU?=
 =?us-ascii?Q?LKG7ONyawRfiFbcXjm2ItcGtR9kGOndMO2M0al9GtC2xgxQQVCrnJeMyXdGd?=
 =?us-ascii?Q?5yMdfIGQM2ArFONsxPP1uLCcugznkvSnZai9PvDw4NFsGMrtlWBEh9Xoyjvl?=
 =?us-ascii?Q?cax3L0UFCwgpfAZOTPzA0dBytkMKXA6FFGlbWXS4DrB6z1YReFmwnGsuAXol?=
 =?us-ascii?Q?vfPFtqHXMsNDMvFSch61CNhlqDKnf7W4+QWhOo3xwvdsQkfK3xwYwzQ9NjFd?=
 =?us-ascii?Q?emzQAw3hkWL1eufGI/iC8FCballGTtdxGNCzmWytnn8tvO71t05g66yBky0D?=
 =?us-ascii?Q?W3ZTTRMMfvxKig6bqPof0OfNvtuGKciRdI3/y6Zm8Jb4i24v69V9dmz/4Cb5?=
 =?us-ascii?Q?rxEWPYgcJJpmUqvIJJJgp9UH+6TfVMwlxZdPKKvfhRckNreURZIg3EdrUC+4?=
 =?us-ascii?Q?2P/qqBzM6qcPVJr/mjD2GvwmuYS6OyJ+1D126tzhNKtdD4nW+Hd62tvOCrny?=
 =?us-ascii?Q?4R3OLjgX36pZT3uQuOpBxnIN2j1LYtL4h0KGRNsg5y1yER3GC6w9WVYELx6y?=
 =?us-ascii?Q?bdYWhg1TXiqBGevENuS1O+I9m9E7l4U3QSID770kgetCQhBrrYewmCz+a2bG?=
 =?us-ascii?Q?PnCV360D9PTxmGV47Wiwp+yo7FUK1/WrcMVRefAQE7FBw7OxXfaOVw58S2mQ?=
 =?us-ascii?Q?rpnXuLW/g1vTWqwLjysr2dcIeuQecB40Ngo3DkUM0pt07Vd6sUCoEPj44D/X?=
 =?us-ascii?Q?E7iTeNrBSlqXfLGV54jefv0zxJs8Iq+MJZjpiusUN8hoXumk1wfW8SPj7u92?=
 =?us-ascii?Q?EMv6EiEfuA2FnyJeCuX5yTwoYsMms8NssDiieKihdyxokeMIyLweGqTylJ/a?=
 =?us-ascii?Q?BfeUvPUR3snFW69fulCa3qiL8dYQkZZM393TIJNRH4AwMQJ37nQJ+uzBfT0H?=
 =?us-ascii?Q?lv7ZMkJmyDOXOOqJUK+d0n5z+RB8GpFRoUEo95EsaleVAI9H1KUQsoO0HlVP?=
 =?us-ascii?Q?8Wa2Kj9PNuwd44sn1fI6zRRG2ciClI7qkqWuQkcf?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 10f5c187-b9dc-4ca5-95e3-08db34b27bbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2023 02:15:38.7702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aiBupC1xOj6xit966MnvgdEg0kmoTIgLNNoiiD8yDVAbMbpItdD0xnYokr+Zag7ObkDy2rFT9GtfVpcqw/YiSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7650
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Monday, April 3, 2023 10:30 PM
>=20
> On Mon, Apr 03, 2023 at 08:00:12AM +0000, Tian, Kevin wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Monday, April 3, 2023 8:34 AM
> > >
> > > The new set_rid/unset_rid ioctls and the mmap interface would be
> > > essential for VCMDQ support that we'd like to achieve at the end
> > > of this journey. So, personally I'd like to see it can be used at
> > > this stage, by the generic SMMUv3 (and potentially VT-d) too.
> > >
> >
> > We talked earlier that there could be multiple VCMDQ's when the
> > guest is assigned multiple devices behind different SMMU's. How
> > does the mmap interface per iommufd work in that scenario?
>=20
> Trying to documenting that each IOMMUFD object can possibly have
> a shared page, the mmap interface takes the index of an IOMMUFD
> object ID. So, either a pt_id(S1) or a dev_id should be able to
> identify which physical SMMU, I think.

Are all allowed cmds in VCMDQ per hwpt? If not then building the
mmap interface per hwpt object is not correct. We may want explicit
VCMDQ object in that case.

and devices behind different SMMU's may be attached to a same
hwpt. In that case the number of VCMDQ associated to a hwpt is
also dynamic.

But if just talking about batching for emulated smmu then having
the user to pass a big buffer makes more sense.

>=20
> > and looks this is different from the requirement of having a
> > software short path in kernel to reduce the invalidation overhead
> > for emulated vIOMMUs. In this case the invalidation queue is
> > in guest memory then instead we want a registration cmd here.
>=20
> Yes for the first part. There are certain difficulties of doing
> a short path, such as host kernel replacing the host queue that
> the actual HW ran on, with a guest TLBI queue. So, my draft is
> more about batching.
>=20
> For the last part, what's that "registration cmd" to do? In my
> draft, the hypervisor dispatch all invalidation commands to the
> guest TLBI queue (or call it user queue), which is transparent
> to the guest OS.
>=20

registration means the user to pass the buffer to the kernel.

If we want to support kernel short path, then we want the host
smmu driver to directly read cmd out of guest TLBI queue.
