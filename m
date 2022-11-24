Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E4B1FC1;
	Thu, 24 Nov 2022 05:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669267422; x=1700803422;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dyvxmoILH13D0No5OQwLpLOqWCJadbNWGV7oV1HJKTI=;
  b=WG1weKQ/2LWKzwiC8Sf8s9MUL1j8KoCdABr+F5VnCal8cN68lbFmTnAN
   p7eOB8FoKtXeGpYg4RCXjRf+yUi/H8HsTc1loxD7r8xl/NsxAUbUaZHm1
   hxH9y8gicfb1OVjKIvEwaf+43750NODpHG7X2l974PnaNjewb5sPxctlx
   Ftp/+IWmS5FihTBYa8v/jWSlxcJCVQd0sDIVDFETqnG6FH51K9FUF3+qV
   IXRJ0XItXZxG8jqpZsqwPELJbd1ZJkU9qRgWf/kKzRAXLkJrQlQYxCuDw
   e/dE6IYVmuYtKmONKpULeZt65NV/a481RN4molfHJzbUMfJIRp1Ir2zVc
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="315369998"
X-IronPort-AV: E=Sophos;i="5.96,189,1665471600"; 
   d="scan'208";a="315369998"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 21:23:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="887218673"
X-IronPort-AV: E=Sophos;i="5.96,189,1665471600"; 
   d="scan'208";a="887218673"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 23 Nov 2022 21:23:40 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 21:23:40 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 23 Nov 2022 21:23:40 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 23 Nov 2022 21:23:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oa5HUj8MJ3SXqqFFMirF5sStF3k00i5ZjGaxAUSXLLrmcdlojrP9KWkPP3UsOV/NWXInXp4B7hLy1byOeTECoCKqYOGyBVL8lDCe6b6QpwP65hyoXc+8B5JUB9lUYlJnCgEVSQVcBf+IPegm6S5hw5btvKsopDtVwxFWybgkCEjwouy7+FUJ1J0DSNu/phmR1oJMY5Rrx2PVsAEBge2YPzOqGr/KXCo6CeEvJSPvpoLtHhflgsMSeKrc60qMBsZZqlGsKpvM9CMnwhrDU8TUG/w0/JwyaCJfEmwHLtSSKQL/Ro4RdSKqqI7QZtn+JplyWRBPCLBP1PiqWV2GMxKKHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qLg8VszfibJWzOkH67oB4/5mx0+nVZcSWdihnrhXsY4=;
 b=du/X3HvXdH7kCtKY6yKJsYDa7cW3kNIAZ5ZdM7950vOeimwaUgAAiT2KFFKO0WXjQZ/fImp3bUuL3f7eRSAgfBhIa1P3Y6sVHEC9ivGaOpqJaIONjOLnamDIDJ8YPzFNV13+5Bp0r4LE1XY6CXtZgNUPRl9kvHs/hiZ2iNvis7gn6We4GhzzvFzD1UShInd4g/CkyefVCm4Pyl9bs7CA6uIGUG5LdUh2zKfJnD2fDRTJoUej2B24daV475saa7jXMe3rNdtUZ3+0F33qZgS5724DYN9UAUJeTWzD+Bgt11iJQEDqVcZkqqALE+I8KxZAiFh5pp19NS30a0iLxyzutA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY5PR11MB6535.namprd11.prod.outlook.com (2603:10b6:930:41::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Thu, 24 Nov
 2022 05:23:34 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde%8]) with mapi id 15.20.5857.018; Thu, 24 Nov 2022
 05:23:34 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, David Woodhouse <dwmw2@infradead.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Joerg Roedel
	<joro@8bytes.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>, Nathan Chancellor
	<nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda
	<ojeda@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Shuah Khan
	<shuah@kernel.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>, Anthony Krowiak
	<akrowiak@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, Bagas
 Sanjaya <bagasdotme@gmail.com>, Lu Baolu <baolu.lu@linux.intel.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>, Cornelia Huck
	<cohuck@redhat.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, David Gibson
	<david@gibson.dropbear.id.au>, Eric Auger <eric.auger@redhat.com>, "Eric
 Farman" <farman@linux.ibm.com>, Jason Wang <jasowang@redhat.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Jason Herne
	<jjherne@linux.ibm.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Yang, Lixiao"
	<lixiao.yang@intel.com>, Matthew Rosato <mjrosato@linux.ibm.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Nicolin Chen <nicolinc@nvidia.com>, Halil Pasic
	<pasic@linux.ibm.com>, Niklas Schnelle <schnelle@linux.ibm.com>, "Shameerali
 Kolothum Thodi" <shameerali.kolothum.thodi@huawei.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
Subject: RE: [PATCH v5 15/19] iommufd: vfio container FD ioctl compatibility
Thread-Topic: [PATCH v5 15/19] iommufd: vfio container FD ioctl compatibility
Thread-Index: AQHY+f/RLyRZNBfk70CFqNn2m/63jq5D/xhwgADQB4CABvLRUIAAwfGAgAERTmA=
Date: Thu, 24 Nov 2022 05:23:34 +0000
Message-ID: <BN9PR11MB527681752311540329E94D218C0F9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
 <15-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
 <BN9PR11MB5276B0219008568A30F5A4738C099@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y3ejMSTWvJuELQ7K@nvidia.com>
 <BN9PR11MB5276939555C1460EFBFD15A68C0C9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y34aD4TheDlxTGbt@nvidia.com>
In-Reply-To: <Y34aD4TheDlxTGbt@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY5PR11MB6535:EE_
x-ms-office365-filtering-correlation-id: c75cf6b3-a6c2-4c38-aaf5-08dacddc0850
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yu2sDC/XpgVg5Q/MVcZkWP1RkgC52TckIp9hMV82jKCTnn48nR5yKZxkzWdndHgsRYDVmroyryeMOFLpfVvkLUT+eRbNCrpqX9dhnbehhiv83UAPTqbo210hAdQoAF/pWh2usgvOrsxDtngKZC+iM+SNDCA4Ii2ShJmYmjWixXdQX/uKPGwSyN2wPYRf/iKz5jbxE2dcg+CoWyyn2W5N3lw9dw5TinmWCjrRrxxgjqmTnV+GlFVcM6+1YGRyruKd22UKtZwOFL7iSxiTNmyxCspXy8gGIQZ2FMgyH7LcHSp3YQKvKzXooZzZURBxHbcgRus/z1n1SqIo1Hd+2KtvtIPsRhUIFuwmDzcDGJVzVxcYUR3JwMs6jjBH5J5pSDWUxGeoR2zETsBvkOaZOyuv5UuxxDXG6V5/pCJc7VODPbppHnAKAH0QVUlXyaIiywOu0EgaHHwS/KTGrK/XDTcS16TVyPWFIKYbAJuo79O2A/V1PCy3doYUFwyINLn7YEWl9wkaBrG5+LBOvftSfSt+6W2UDgtpGJfWq3RtTP1obgyd5ZEa2GM7CVoe0MEtPDSUFNq3v1iJFYyjRPjmgsHBueKYKw+hi0+4RDKUehqgiX+VCL6Y3KDlzi/FuxdXsLeBlCsSgL5u9m8ASjWo15Vb2CkgwiJys2GxFrrxNJuSPi/gNc3I+F1rTi6q68IiXxNK28oGQHDf0cUi2AlzV2dhQQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(396003)(346002)(376002)(366004)(451199015)(71200400001)(7696005)(6506007)(478600001)(64756008)(9686003)(66556008)(66946007)(76116006)(66476007)(26005)(66446008)(38070700005)(4326008)(8676002)(41300700001)(316002)(186003)(8936002)(52536014)(6916009)(54906003)(2906002)(7416002)(82960400001)(86362001)(7406005)(5660300002)(38100700002)(33656002)(122000001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JGqGaNs2DCjdV4cHL7O/ltHykwAhRu+aP4sQL/fJ6CHM/noMdgxZBS2EkYSa?=
 =?us-ascii?Q?X2T1uyhTqDWvjCrKBsJXXF8ucSss7/kIlGyRGbvp/DbJ1gwr67+PSI7PUoc+?=
 =?us-ascii?Q?GGMokP2L1PPhbo4/az3svayPbRNSNeN7jV3GVQBKiObCf2iGqtX+9xSKVk7o?=
 =?us-ascii?Q?9G0nvgYaTE5VvAmn6brqRyjboYv1kv6MIzomGqrmj61fFgyf7ggH4usGr2cS?=
 =?us-ascii?Q?IKXWmvTAeFGqYFqplkv/exvgdlWU109coEHR2RydGlDUq0lBc/896iH+DBFC?=
 =?us-ascii?Q?PGFHyOdSljJS/OhbWvUug4EHnxekefgI9vtpMMRLE/yd4ND0QxYioF1hEmlJ?=
 =?us-ascii?Q?N0Qx6YyDqhjIWH+acRZEoB8TmkgR4eXYYl5C0DYgrHawc6l6QJR7O+XCy9Ko?=
 =?us-ascii?Q?E5x/Lil2UOuSyefTW0RtrczL8qwyqwlQbw/bl9LcL074cX+oqZwIxagSthCF?=
 =?us-ascii?Q?QdmBfEyY0xzF1cQAbWPckYjHnEodPsDHThPOi3mQGQNa5jTB1JuJwsHInxoI?=
 =?us-ascii?Q?G3uhU9DTFnShQdhC3XkxZuibO6MrnBwTT29HNmxZWQR+Iqj4YKq8E0oQtlTr?=
 =?us-ascii?Q?xkY7dhvefQNbnMLkIDhsJCeKrS6aoFZCHSFFegIDXTK4RmLnLUZvIceMc/Bi?=
 =?us-ascii?Q?FqpNU50ElZnb8EmcugZFJ+LqVYB47NoRwlxBanZ3Q1K5K1W4JZlRZLCGJARu?=
 =?us-ascii?Q?KfLvT//z0uu0IHoFs13ZwZW9wN/8MO4Krc8tGqeiy5odFQGpLSNZImvO6DQU?=
 =?us-ascii?Q?S8JaonZ3vQX0bpjcfGiIC512cmXY38CuuD5B58RyLWOfxvym08FW7CApA4jj?=
 =?us-ascii?Q?5hmsVN+k5RaA3vPRk7/0oswCmDMxnK1OkGe5v9PaemvR/KxBLJLG6BsHfHJO?=
 =?us-ascii?Q?lN55g8oBi1AoJgMPuDGJRVHSiwULitYYBLrB4Pdd8iWeopK7CiWiug9v5Zxa?=
 =?us-ascii?Q?MUae6u2iheqR2nrv3R3+AAG1QdNPazzc1aElnRn2fiFdkVZdEEl+5zmEsWTF?=
 =?us-ascii?Q?mJL2s2rpDm8vEcnnHLcUArxY/6B1sFxz1Ad0/tTnYa8F3VvfTLw5QFnnd2WN?=
 =?us-ascii?Q?iS6MZAriAjgOalGNl/fz5wiLlcl1gsSifkYpN+8ZQN3sZhqMCwoYJTwreB0y?=
 =?us-ascii?Q?MuWSZX9ZTzRJ9q08WCaz81y4+wIC5kKIlcgtsip1IdaLKY6WI0iD09V4166J?=
 =?us-ascii?Q?3oSJIiyOqZKQ5IcVgS1y1obvEtb0oVLRnYvsN+fmh0ifmO/B/WPzBIqIsPsM?=
 =?us-ascii?Q?QVPjErmE7a7Fg/u6gvA3sL921LaaG6QckMpKZk5nfr38wGZdfXfU5JaTznQz?=
 =?us-ascii?Q?Bf3PKyOqniJgelm5LD8d4N8YU+Sc+P5JHrPNfw33SRnq2Xz474zrvsxL/JcS?=
 =?us-ascii?Q?8BwBrlC43uZBDBAOEXYLoLENbTRBOcQFLFzna0reX4P0EDkwSI+uC4s3TjyX?=
 =?us-ascii?Q?/oA3Yr7dZRSKUqrhv7DiUbu9fRryad08khA1d2ww4Dr/aYgyp1Z/8EsSCGd+?=
 =?us-ascii?Q?ugYLneN8tzxZVnRyIkfZw2x/72tCIk9tXCZ3BMx5DMzffkoXuEABqPZrhejo?=
 =?us-ascii?Q?RBggkXNhUfBajZ8075XwYV0L4vacMbkomt+HbHOS?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c75cf6b3-a6c2-4c38-aaf5-08dacddc0850
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2022 05:23:34.1881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CI91q535zDnB4Gd2OIbK/dzQyw7q3Lg1oVISwzp5Jo1wU5/a5V5kSEL3dO/JF3L5mcAxLanTZhBVTEZUwKg3nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6535
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, November 23, 2022 9:03 PM
>=20
> On Wed, Nov 23, 2022 at 01:33:22AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Friday, November 18, 2022 11:22 PM
> > >
> > > On Fri, Nov 18, 2022 at 02:58:49AM +0000, Tian, Kevin wrote:
> > > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > > Sent: Thursday, November 17, 2022 5:01 AM
> > > > > index ca28a135b9675f..2fdff04000b326 100644
> > > > > --- a/drivers/iommu/iommufd/Makefile
> > > > > +++ b/drivers/iommu/iommufd/Makefile
> > > > > @@ -5,6 +5,7 @@ iommufd-y :=3D \
> > > > >  	io_pagetable.o \
> > > > >  	ioas.o \
> > > > >  	main.o \
> > > > > -	pages.o
> > > > > +	pages.o \
> > > > > +	vfio_compat.o
> > > > >
> > > >
> > > > move vfio_compat out of core? it's not required if VFIO
> > > > is not configured.
> > >
> > > We can, but I don't know if we should. Compat ioctls are part of
> > > /dev/iommu, and technically have nothing to do with VFIO. A native
> > > iommufd application using VDPA could use them, if it wanted, for
> > > instance.
> > >
> >
> > I'm not sure whether that requires further VDPA support. Be safe
> > I'd like VDPA to explicitly select vfio_compact when that new
> > mixed scheme is supported.
>=20
> It doesn't make any sense. The ioctls provided by the "vfio container"
> FD are entirely up to IOMMUFD, it doesn't matter what the consuming
> subsystem is. Just think of them as alternatives to the existing
> map/unmap iommfd provides in its native mode.
>=20
> If you want to disable them is a decision that is driven more by
> eliminating the code from the kernel because you know your userspace
> doesn't use those ioctls - which has nothing to do if vfio is compiled
> in or not.

if this can be compiled out then there is a dependency imposed by
vfio when vfio container is off.

but this is a small issue which I won't insist, so:

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
