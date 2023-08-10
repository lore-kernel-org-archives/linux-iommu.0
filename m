Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6026220E8
	for <iommu@lists.linux.dev>; Thu, 10 Aug 2023 08:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691654703; x=1723190703;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uoSJMMG+FoWbVVWMODeMArFiY94sWYhTupGfGu0Ks+E=;
  b=I9B24OEMr238UfxdXK8jT8P3hygbl+Z7h62lvCPsI1eZ4nHeExypaI3y
   vB1jQbvjXpSqWQ3+VbFU31BlXDqeSFUYWAdciIRyt9mYyIPesRoGcyRJH
   bNC1YRVk+8wKS8arVpA0InEj4mzIIuSYwV99Ca8joo9KECZCOiGgRohPs
   j7/CIJGXBzByZeOS2gRI88xPsE8YMdwTbKvRh83zRzXbCpqv+LG5QkrfC
   8kEKHG7sg7bksZEMiUN9+eH+YD68g21grN0L1fsUshXcn7IYNi3o2GR4S
   fCxhwyrFSbgiOIk1BRstLwpze80/2IwfLOKDILermzZdv1Xe1ePmd26iV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="356298874"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="356298874"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 00:53:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="846278379"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="846278379"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 10 Aug 2023 00:53:00 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 00:53:00 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 00:52:59 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 10 Aug 2023 00:52:59 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 10 Aug 2023 00:52:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZ1VR/LRiHfa7UaRFPSCb0Ym7sXIOJS2BIE0+cyEJI2zZOKMdx5JuthhLrUUdBH+YiaELPL22Uc0K1ZWtFDoemu7DtNXVMPnLP4rXMpNF9BjFVg9ZSFyz1EZqzRuQAep4kuGpWRPTXRk0yw7x/LZWlGr0ntGMXxxHP+mAMVUbc2WaDnFRyl1sM6fm98MHSFU5xdMcL8SQlyIrVb7eQzn8GyYoyO/wSvrzAuzZVAS3dZTj3qKFBKFE0dqzABUNhSNPHVg1iW3QYgk0BSqgvveV64MpxM2pceS49fh61Hy2U0prvPUn+/CoGHkfyTdYnsG+cDurWvZ6iQUVtROhF2GVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uoSJMMG+FoWbVVWMODeMArFiY94sWYhTupGfGu0Ks+E=;
 b=QrIGwK+OUQIE5KTc4gM8vgzUCkGqGqkFK9KsNk+2OgbawwQ6BhlCjImD5DmIh7VcrZ7ZozheFJFCh1OKNjWDF+kZJsqsOwLoNPrHBZyFdXXd8871XM0DbA6eW0bbcnxc4f0tU1I/KLTo8flozk3sR0XRA3XI8/6pbBzsmYnTePQWazcx+DtpeJ0O2YyTPpOIkBDoDQ7Ou0mmIu1KPxWiPHO5npzKMBOo9+/u/f4Uz4NsSJCOzAQLBLiW+iNRhEJpexwHwyzu18RKra6AE8zwBALv5TTfEDe86HTWE+E42fwMLtrQNy5A8IH09wWwNxglYvz0cF+mYJiOovE60ARQ1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA3PR11MB8045.namprd11.prod.outlook.com (2603:10b6:806:2fa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 07:52:52 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed%4]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 07:52:52 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Baolu Lu <baolu.lu@linux.intel.com>, "Zhang, Tina" <tina.zhang@intel.com>,
	Michael Shavit <mshavit@google.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/5] iommu: Call helper function to get assigned pasid
 value
Thread-Topic: [PATCH 2/5] iommu: Call helper function to get assigned pasid
 value
Thread-Index: AQHZyczxCRfFMGhSVk2JCjxjKYlmLq/hG1GAgACeSCCAAC6iAIABQplw
Date: Thu, 10 Aug 2023 07:52:52 +0000
Message-ID: <BN9PR11MB5276A5E619DF6638677DFFA58C13A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230808074944.7825-1-tina.zhang@intel.com>
 <20230808074944.7825-3-tina.zhang@intel.com>
 <f3d8692e-b13d-97ee-2288-c2be1858dcfa@linux.intel.com>
 <BN9PR11MB52767F29A6C11157659D375B8C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZNOH9lPdTnltb9JZ@ziepe.ca>
In-Reply-To: <ZNOH9lPdTnltb9JZ@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA3PR11MB8045:EE_
x-ms-office365-filtering-correlation-id: 3f109a0b-7058-4182-5349-08db9976cc9d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gU7PfLksOe4Pqs7Tb4EmdAI3HQNKvpI3KWapDfCF8XXJBtJ3xbcn3VWdWtCp8twccVCmAzGxsz7FWJNy7lKwgWnosuKroafQ8dUYjseSMO84iDHoIw4t7jE4O+cNfpK6/L8Ewqalm/HGbee71SuTWrRFPGtzgvnVieU7NAZB52YZ7lhCdEEbwL0BZD/Ec1TtPB/62TyzDIK3xkkLeaVXnh7F8dpJDfyVsQg7OTTvg4Lw9EqN8V8mV6A3vmSQ0oyLqZLFdd/6IcWUFwlspxaGD0XSJrSbx+jvCd5Av4gUgbFCJ/MtFZhTbf12/zkHEYYTNephcfmLwuei2mwnMjsF5ZEA63sasiWhz3PVdugsEroNWhBXT96s1y/c1sEHwtgk7geHwr4x6fWIhXNjsWqXvChdqazgBf7oH1ej53JLmRFIwfRG8P/QpEfnd2tuWUG5l/MXXzcMH+pZ8P6p9ppItN1YsmKA+kvQZ1e/5BQgPC9kCC0fN4DssZMKd2AOot3P777vaKeo5+XDg07HxAfl+KBg/bk5gt0AxkyvVE0AyKtpXQd5B5R11wrJtlPscxnAGXFx7qlgd5Te5ZJncuNUe7Dl7zallif2cVHhpeIKjDbrLjKkUJCueyKk2szAWqXWnkMvWqq19JjFGuMrHAMveWNK7bhKKILTmbxuSbjmXic=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(366004)(346002)(376002)(451199021)(186006)(1800799006)(316002)(8936002)(41300700001)(26005)(66946007)(66446008)(76116006)(8676002)(66476007)(4326008)(64756008)(66556008)(6916009)(82960400001)(52536014)(54906003)(38100700002)(5660300002)(122000001)(9686003)(55016003)(53546011)(6506007)(38070700005)(71200400001)(478600001)(86362001)(2906002)(7696005)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IueTiEtZ/9E6WZwu/ThosVldSxpF9E50cICCnIzSwOG6Ktt3UgTnjB/JpKqp?=
 =?us-ascii?Q?10KbSxhPeuvDVTh/o8eTRIlyocppOs4Z2Dy2mVHexJSeNvGLkSbJhwgRrzud?=
 =?us-ascii?Q?zSOiQZOwQMiykfLE84LW6K7QR+04p4x3Ge8g+aZgRAvw5sRer9BMHeUeFAu5?=
 =?us-ascii?Q?xTQ/pWq8PB3bo2qojhj1kENWjjmbyF2sguMcr0gRAJmc7eXzkVkAb9kh1+RP?=
 =?us-ascii?Q?ju4xxu5I+tE0B/T0frpHUc+0ESqfmhiKv+cO+doaHFjeRYllElzriqahlF9G?=
 =?us-ascii?Q?BK8nsP2CFHS9xGM/9QuIMQ87Pj/9P2VSXGgZuIPkUmJbLiBxVQOfrmwaydQM?=
 =?us-ascii?Q?5aPElRiYiKST1vygXTT+Vqv6JLoO15t6l6RiFcZHO3FAGXEgJnx88AeoIjYI?=
 =?us-ascii?Q?nJ4V6UD4aQt5+S/s3U+yyYmnYk8gNBQs55J+l25MM3oJUmfeODt6tlC+Rq4H?=
 =?us-ascii?Q?ggC3UBnKbwC6UsOAJDuzZvXCM8JG2sZ76G+bWFDLbiCZEuyrNzBHLsnEkM9+?=
 =?us-ascii?Q?JK6xKs+AsXOwghk+g9AbCERqb0RJtOUi60R6tCOfvByDYMA3ycKfdG4Uj2lP?=
 =?us-ascii?Q?2oHm1kWa7Vufr5oxjY9MJRVQgszhTJhfnKSA9y1rbhc5LlLRCeVX3vrVmOhe?=
 =?us-ascii?Q?VAYauO5cf9InalO7vLAAS6mPq2Mk7xBcczssRaYaF/SgUFIjMbogIhcZIvii?=
 =?us-ascii?Q?5/cQKjtf/uueqiu3OrydPaNkY2mJEKM4gSZiqzKhIly/027G0Sq9gwiLpWol?=
 =?us-ascii?Q?OQf0u8juS5ukVljAOu66KR4evlt46EmvqG3qPMdmktUQ196DMMvvITsawWBx?=
 =?us-ascii?Q?ouGRKhybSNU+zV47Wb4OfT6HKdcA8CtAMAIJVdaeC3JqTBeXuzAYpHoWwGMX?=
 =?us-ascii?Q?atbPuUncaBdAHiqI+h8hMnQD7xjbGYuoJP0odhwmKGXKDFj4wBvS5V0/7Fiv?=
 =?us-ascii?Q?PfvWUCCzCdpU59VpVvpKkbCV01qUhl1RHIuBr3zrwVHSsATlaWnnZI1bsmlJ?=
 =?us-ascii?Q?d6Sorkw8de7HeySceTQ5TJsg2HI7E6wL5ijZSl+LCbzaoAUePjzKPgxF3kRL?=
 =?us-ascii?Q?dPwJONA8m4bkLBHR54rZ7bJ1OdML1eG8FEDrTiNa+oU3xLYGGAWqsYx5wnWY?=
 =?us-ascii?Q?wvU2tqAFf4eM2YHgwOJxE6lvrdcj3RVPdX+b2uuoqqn1+aXXj1ErMG+h14Rh?=
 =?us-ascii?Q?loWWOV7yJZjjwrKFLPD0K4xSMc66Uz/0dh6cHbNv+8rY0huLf6b5zwIeVWPw?=
 =?us-ascii?Q?fiyV/2Wvch8NdgY3IsqokXVB0B3RlqyW7wW821zazzUGi7a6o96xo0tN01yK?=
 =?us-ascii?Q?ZYD/aEyHDYvL9BiTV7hzI1TgikFFiTlGMq3ednse2k9FpRj9hhfnIy9bOme0?=
 =?us-ascii?Q?7vvytGvd1tJtJT2+foMrj8HHPEFdg2S0roZLkPN/SrrTyEf5Gh5F27g0UqSL?=
 =?us-ascii?Q?DJZNBm8FTvfxi6lBWA+NKWJjGoezOgpK4R8AKAva44SOEI98T4Euzc1G3rlG?=
 =?us-ascii?Q?w8b/QQR5VeV8+qZwfiaDaXRIG5KSd3TynQ33Hm8OdIePXgcdWwnrsAU96w/c?=
 =?us-ascii?Q?PJLhRDBB1qJ3a6R+DamW4z65W/ZhN6o4vFdXJfYZ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f109a0b-7058-4182-5349-08db9976cc9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2023 07:52:52.0935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z5VNfiuvnBMW4wERvVLFBuNm7EEyrkLRVwqDYGxxm/k5ZVd+iPfy1kz9D/yjSW9vwE1zAlPi13tC3oAZwqynJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8045
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Wednesday, August 9, 2023 8:35 PM
>=20
> On Wed, Aug 09, 2023 at 09:49:16AM +0000, Tian, Kevin wrote:
> > > From: Baolu Lu <baolu.lu@linux.intel.com>
> > > Sent: Wednesday, August 9, 2023 8:22 AM
> > >
> > > On 2023/8/8 15:49, Tina Zhang wrote:
> > > > Use the helper function mm_get_pasid() to get the mm assigned pasid
> > > > value.
> > >
> > > For internal iommu drivers, perhaps we should use another helper.
> > > Something like sva_domain_get_pasid()?
> > >
> > > Suppose that the iommu drivers should have no idea about the "mm".
> > >
> >
> > Aren't all touched functions accept a struct mm_struct pointer?
>=20
> It is wrong for the driver to even ask this question.
>=20
> Domains, regardless of what they are, get attached to PASIDs. Maybe
> many PASIDs, driver doesn't get to care. SVA isn't special. Stop
> making it special.

Agree. I didn't think that far for what this series intends to achieve.

>=20
> The driver should rely on there being exactly one iommu_domain for SVA
> per mm so it can hang the mm_notifier off the iommu_domain

I'm confused. Isn't this series trying to allow multiple domains per mm?

>=20
> But otherwise invalidation for a SVA domain should be *exactly the
> same flow* as invalidation for a paging domain. It iterates over the
> attachments and generates the correct list of PASIDs and ATCs.
>=20
> Jason
