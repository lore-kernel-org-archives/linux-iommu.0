Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4C67B
	for <iommu@lists.linux.dev>; Wed,  8 Mar 2023 07:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678260758; x=1709796758;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KApchjZ9PCL8Iismo6t4kpv+RIajC9TKlkkqBWGsv7I=;
  b=EAHRp2EFo55ssusKnYdIts92pexMYGvRBDvGHaQPkcWITuzKbhYe5li0
   smrIGsTPmEJCVF3AbJ3SlOIdjgwm9BCOEQwiOphoi/03xz5Pnz7Vbpbg9
   anGnjzp5jCFE/PFu93LW0/Sz5CGHXUblsQ7KxjcRjPRCN5/qQOt4hZDNW
   ZeJRclXpDq+KC2gUDcmYFT1Q83OGG0cN6rrwU6DaBdOyix5QLzAaPEOGq
   5EX9LAiPPBI3Zi1CEuUrdn6gy3uFvIgQUXqcG7qOU6PTV58w/DBHPOZLF
   Mdl7+NVrSe4QIuNqwBUjAC0NYPG9cwIShmSo9AmgioW4cA0jub77Z8n/2
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="363721428"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="363721428"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 23:32:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="745812532"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="745812532"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 07 Mar 2023 23:32:34 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 7 Mar 2023 23:32:34 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 7 Mar 2023 23:32:34 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 7 Mar 2023 23:32:34 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 7 Mar 2023 23:32:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JCXodrZcWcgpEO8Z6asSXW3SRZEPmrkGQmOsArD3TNrvIqMWTQSBr0yYSZHXlQeptU+6ChyLWf1bHU4L9Ftr/WggGcLPah/JgGebEJ/xzxtL0pmcrsds/SYWN4mWQ6cT1IntCPnEasD/K0fGZpblNf3lA4hXzG9tB4h9RQalCNasNlJkpHQWWAI5Q4EjeT5Ck1GiEagYFCFQXGtgWTIvaASMUwMWOiqR9Aq62CsuZ/6121L7f8ubYlH8AYHQNGlZx7uf+I2cyjmVdcsC3WUF9A9IBWiaf2ShmR0KNoGHacgcIWVJDps/HqS+YmbcTC5vAllc9KooBUaqL6rZ2483VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/n2NqUdYbqST+c33zoHznzD6fhQHkPse54ViR7LXsI=;
 b=LkZ8hSGu/2p7Df4fJlfOdWCg6Z+Hjwo4WTEJVHZHihcNptP3SQmm89slW2NeSPamZXdtfhVMvED16bdJOTah7rTUN36DcMA034QyQQx+XLAn3BBgg4d8I3w+w0eY5NsLXEmb+4qW0r2bbbA7tJv8ZfYlskEu/b4bnPc8xuC5/EuKkiHSu3aMcXPqosOwZlj55RauNol6J3TP2NeTDiKthyoOEV2IQ2joOtJeOjmyvvj31MWvmr2XmhFhL33vFtvPpz1aBmBE4ZWrktPll8ZhpXuG7xl26NGEek/1Dq8hzMN+5pMw/vkyAhmRqfVBk8Sua/K1djQkfLrcH1qegcWDVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB6720.namprd11.prod.outlook.com (2603:10b6:a03:479::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 8 Mar
 2023 07:32:31 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6156.029; Wed, 8 Mar 2023
 07:32:31 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, Jason Gunthorpe
	<jgg@nvidia.com>
CC: Baolu Lu <baolu.lu@linux.intel.com>, Jean-Philippe Brucker
	<jean-philippe@linaro.org>, LKML <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Joerg Roedel
	<joro@8bytes.org>, Jean-Philippe Brucker <jean-philippe@linaro.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "X86
 Kernel" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>, "H. Peter Anvin"
	<hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, "corbet@lwn.net"
	<corbet@lwn.net>, "vkoul@kernel.org" <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Will Deacon <will@kernel.org>, David Woodhouse
	<dwmw2@infradead.org>, "Raj, Ashok" <ashok.raj@intel.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "Yu, Fenghua" <fenghua.yu@intel.com>, "Jiang, Dave"
	<dave.jiang@intel.com>, Kirill Shutemov <kirill.shutemov@linux.intel.com>
Subject: RE: [PATCH v4 3/6] iommu/sva: Stop using ioasid_set for SVA
Thread-Topic: [PATCH v4 3/6] iommu/sva: Stop using ioasid_set for SVA
Thread-Index: AQHZTJj76eQP8uX72EyfrDQEvPOjua7ndRIAgABHXYCAAJj+AIAAd42AgAAHA4CAADdXgIAGk7qAgADnasA=
Date: Wed, 8 Mar 2023 07:32:31 +0000
Message-ID: <BN9PR11MB5276832C74C9350C510752168CB49@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230301235646.2692846-1-jacob.jun.pan@linux.intel.com>
	<20230301235646.2692846-4-jacob.jun.pan@linux.intel.com>
	<3b7fb4d3-1fe9-a3be-46ad-c271be9f96c7@linux.intel.com>
	<20230302091707.58d59964@jacob-builder>
	<794c7dad-2e62-3afa-ea10-92179b0d1659@linux.intel.com>
	<20230303093235.GB361458@myrica>
	<3b2c6fe9-821f-9b84-acb6-777e8517a0fc@linux.intel.com>
	<ZAHzAa0mnilf0N9K@nvidia.com> <20230307094203.4dc51ff4@jacob-builder>
In-Reply-To: <20230307094203.4dc51ff4@jacob-builder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB6720:EE_
x-ms-office365-filtering-correlation-id: b7e59ad2-5fd8-4d95-4e47-08db1fa7470d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rtaQwTrDpMGuVDfu4cyXRF9Dzioj11+xb6q7rmquI1BHGQ461FdyVFbi/shmiD2jT/wjrvzFKLXXoy9TvEHoYSFxyVDi7mgx1+dAreO4DvMNB/Lf8DKozy29So3Kq0IrsBH9HURMDSFp75cpFwXbAWp/b9eQcINQigp63WgMG4ujSuNNknizJxQ7yA9dkDvEMi45k3DWqgjD8xQkhShb3nxFZ/qwEC02WwduiKThwxFh1M/ogvctdVZ13QHD2FntUiVYnJEqjCk4ZfAt1UPDPjYvB0iuDVb4d7Z/qQWl+B7QfB1LAtdZSM1r7kNF67NkweX8eWMyw2GSB8v1FncuOK1nQ/rBoanCCJ5ibSldN81mv1xQtMvjuBx+cOkrPCyaPT9Yvffsj/BmtocfZWu0U+OJNSasVp+b4TIjZok3IcWaGwPW0h1v/Dht3WFhaBu9V3EiWwhag49+f8lIw0F/EMwRiibVotVZnwasKetRrJElleJ/VpNdRTPOfyq03xMhjlGZ3cuGQMgN6huWPpg4h35Bs1cR1eXzTTFwx235ClIV174XBf9YtuvMkSdDuYKGMZbprnUws09C713E3yPMBQPXJLb1gV94HIPssiDiNE0sMGiQ/nOlzPzegrJinG0hLPfa0+cZnZYnhoqe2zOB96zM/4Sl0gn6RmJSwxSZp3KeWTUfFyePqMicy195ef02YJUtMCfcDRJbC7IfZ9afHw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199018)(76116006)(86362001)(38070700005)(122000001)(82960400001)(38100700002)(33656002)(66446008)(4326008)(64756008)(7696005)(5660300002)(66556008)(7416002)(6506007)(66946007)(8936002)(41300700001)(2906002)(8676002)(66476007)(52536014)(9686003)(186003)(26005)(53546011)(316002)(478600001)(54906003)(55016003)(71200400001)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?i3Qjm84dW4AI83xeZNSOfyy/nJIAmxMXv7Qjlhzr5z2IFmIJ31SsjLUnP2or?=
 =?us-ascii?Q?mY54+1LzUdQtqHGYA5/wvwKOBPxjulTnZCxR+PKjs7OMMkmuv/wvDhnk2i2R?=
 =?us-ascii?Q?mDqU4WW+hHR+qQ+4kDR5gdsQTa7LEMvRnauG1Pq8H/LBZc/zYZOd7F36rm16?=
 =?us-ascii?Q?GLaE3+ZYQlLwbyxHgZaVn+gmg/XI/DMB/CgaEHy5XvLLurUmdUjYBUEC5D9S?=
 =?us-ascii?Q?yosoTvVUOF7/9/ELfjf6SxBmWEwD2XQ0JFR6wR/IQ9YLc5qD281tS2zvPfGO?=
 =?us-ascii?Q?OErGzynGCSLcmS1KQPO9+rA9NkYru8gcsDJg+iTpDxBs3L+3UNP3QvmlD9QZ?=
 =?us-ascii?Q?2QszCBmFIDnl+AICWWNxOqN95IgO+++5G8JwQwBRz/a06MOvM5OOGlYXIlcp?=
 =?us-ascii?Q?K1IT9SDlo3MkwVArbE78DfUnoBY/rLLI1ujGkvceGXotRaplGrlD+pTNToX8?=
 =?us-ascii?Q?7uTlQ8olELTj5XNXZcEju2Bzn8/0tPfnAhZ8oNKWrVw7rPTQ3+uH5NNHyFkB?=
 =?us-ascii?Q?9fGa0rq13tdJFsXhwaxaLzVOeGWVZcAMe1mUvUmIYHb3D42HfFWNsRoqsCSA?=
 =?us-ascii?Q?/IWHwN+Q/m4mF0nX4FjDtM5tOzD8XxGgCN6u1Zt8zEYP7xRbqOd+npQU9DSi?=
 =?us-ascii?Q?tVjDPcH6qT3WNShCuzpz0blC2dRCWZFCOOkL2KWzF7e85s/JohNgUV8waGsf?=
 =?us-ascii?Q?/QZu2Ci3gptXYNBLjb11P4StLHFuM4VsDJN+oaAC3l1THHPFr9KucbV7h2u/?=
 =?us-ascii?Q?Wdc0Wmapzjh9dKwzHBvg4MCLMYEo3ipXzA1vDQ38G+kFi/lwwiTMT55nXGGd?=
 =?us-ascii?Q?2eooo7uCdrsCoy5mq6vt6g56oGHIcwm8vMBe90KTugjuhsvAEdssPIf1V7W0?=
 =?us-ascii?Q?mNeEbzSUSd0Z5vV+BrVehfjLcC4jKKjf2an0w/mX0xuwNfg5ouWNOilgh3qe?=
 =?us-ascii?Q?K1Te0rGwS4XTfI/5hKWZ3jiRVjpZwmM9l5tpOLZ9J4+4d61P5CG7gDLPBa7D?=
 =?us-ascii?Q?ENT4QRBKCfCPb3CKmRlfMmlZcBjlBnqEZ3OfEG/Y/JUjB50yvLy4WYNzvJyf?=
 =?us-ascii?Q?C4jSNacALoR1Kmkn2KIEqBOEMTQlMeW+SK58r1tjKh+PRT4SMRJr75sZv1+k?=
 =?us-ascii?Q?OAdRjtjfqVtuiLVPoqz3QEft3FJAS6Wtljjc1aj9Rho1Icm8AXV3XdNuQZB5?=
 =?us-ascii?Q?nXs1ZcPPCwIyAZezzDd/aKtAzYkiUvRAZYvhXGsqcE9pafCetIQ65w2TVv8r?=
 =?us-ascii?Q?KuFIDqZxE9GKkrnWrUqnJL2Y/1D62F1syy6YuIb0v7tDBIVJGArwVB0loY+t?=
 =?us-ascii?Q?EM1zE6mk5yuo0yfJhhPdmekOf7EHjXeDcdeyx1nYAkrjcWAlsgctNbanczK3?=
 =?us-ascii?Q?CInlCUfyStY5hz0ksqT7HZbkD7G44wCN75VQzYjMhY78RKByUIQHUag0CXfL?=
 =?us-ascii?Q?FR2kGJMymGm9cX1GJujUASoonmvOXnsIhAMyUxznCbZ0zmePj2k7Jh1Ynj0v?=
 =?us-ascii?Q?nWaOoavDIAr5SqhrVnZt4xrd2UI8XnT90NhnSH6lEqGQsMHx8kS5D1rfQSgJ?=
 =?us-ascii?Q?vGRtCQmlHqZPbb24hBkwA7ZxoD9QJfO9jodReGyz?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b7e59ad2-5fd8-4d95-4e47-08db1fa7470d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2023 07:32:31.4955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c8CA4JWWCDEzrzBFM8aplbYnV/wT9ufTsNMhSOKCz7JTN21N0qy6dLCiapfqejnfFtz0Hiwf4KoPcr1aR1DTxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6720
X-OriginatorOrg: intel.com

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Wednesday, March 8, 2023 1:42 AM
>=20
> Hi Jason,
>=20
> On Fri, 3 Mar 2023 09:15:45 -0400, Jason Gunthorpe <jgg@nvidia.com>
> wrote:
>=20
> > On Fri, Mar 03, 2023 at 05:57:41PM +0800, Baolu Lu wrote:
> > > On 2023/3/3 17:32, Jean-Philippe Brucker wrote:
> > > > > I suppose the common thing is reserving some kind of special
> > > > > PASIDs.
> > > > Are you planning to use RID_PASID !=3D 0 in VT-d?  Otherwise we cou=
ld
> > > > just communicate min_pasid from the IOMMU driver the same way we
> do
> > > > max_pasid.
> > > >
> > > > Otherwise I guess re-introduce a lighter ioasid_alloc() that the IO=
MMU
> > > > driver calls to reserve PASID0/RID_PASID.
> > >
> > > Yes. We probably will use a non-zero RID_PASID in the future. An
> > > interface to reserve (or allocate) a PASID from iommu_global_pasid_id=
a
> > > should work then.
> >
> > Just allowing the driver to store XA_ZERO_ENTRY would be fine
> >
> So we provide APIs for both?
> 1. alloc a global PASID, returned by this API
> 2. try to reserve a global PASID given by the driver, i.e.
> 	xa_cmpxchg(&iommu_global_pasid_ida.xa, 2, NULL,
> XA_ZERO_ENTRY,
> 			 GFP_KERNEL);
> seems #1 is sufficient.
>=20

No need for both. There will be on-demand allocation on this global
space so a reservation interface doesn't make sense.
