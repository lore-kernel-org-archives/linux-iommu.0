Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B6E199AB
	for <iommu@lists.linux.dev>; Thu, 21 Sep 2023 15:15:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fN0ilKRau2OqvobLfTuP0ZSyxL6EqIZzJkeT9RimmXdZFzJeznUD0byiHlofO7ls/dQEuBdWInWgLpVrDAQ75nOfsAgIBKVsECi6NswOo+AWeiFrhMaeW1upWs+A002NUoxHeuWsy7Mp37wYH/X9L7+67Qx2qye9SZwJUWeGcUVLcrJ/y+fI/43qA1zMly9wzkg7wosa2jnkWJ2vy/+h/Txg1g69vtKWpdoLcTEgyX77U/mfiz7wo9eOpVqbbxR8yJk/UftanBgu5KLH0+w3PZKQt1UY10XliLx2pIIPWUrUItJ1FqZih/7pCieqH5NtC1+ld1pvrOef5HTkxHBm3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zezc0L6yyanX+4vAT3TcU5NRKdyvNwCT/S2+WWQx1aM=;
 b=YWNBmrnW8r6mOBkkgGXSReuIcKYkUfKdfbsaZI24IOsFr8p59NLKuX0ciz3WWI5mYtj2vVpOoxEWfNcQre5+Fd0EdaVbHfKrMIKvtMq0NO5HHxQ/9QHftNSabuis8fStu5IJTjJUZzN5GrEvFG9Xvhm0Uzweo9wzi1Fj9T+VMCbXk+asLjmEqsycY2HERw4gj+VEtv8uffZpL3LZGO/Hrb4ZSk0r6YGzpNDnwnC9PvklknHx99WpPjSNfrMZRonwdpeTcT2W5txN4XzRZ6hBGiVqXRcgaUhlajLtJRaeKo/4sV0A/Bd1Q48TX4YjVTzV00okKDx015zU88FUz8w0hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zezc0L6yyanX+4vAT3TcU5NRKdyvNwCT/S2+WWQx1aM=;
 b=taZKoqGV2NWoiA5Q3vdTSJCw9gnQwHl3ZHBNxM41h2vpK89helPU3MqUYnvgckLIrntIT/7EIhAkdAyaYlGQcLC8qlOYP97oRZj1ACqvh9ocxWUW2BY+mIF5zO0E4IaLFYaj4OkL20LLf3PomuDPulv07aVpPFtL3wzCmcryJ+o=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SN7PR12MB7346.namprd12.prod.outlook.com (2603:10b6:806:299::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Thu, 21 Sep
 2023 15:15:43 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::629e:e981:228d:3822]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::629e:e981:228d:3822%5]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 15:15:43 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "Hegde, Vasant" <Vasant.Hegde@amd.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "joro@8bytes.org" <joro@8bytes.org>, "Suthikulpanit,
 Suravee" <Suravee.Suthikulpanit@amd.com>, "Huang2, Wei" <Wei.Huang2@amd.com>,
	"jsnitsel@redhat.com" <jsnitsel@redhat.com>, "Kuehling, Felix"
	<Felix.Kuehling@amd.com>
Subject: RE: [PATCH v3 1/5] iommu/amd: Remove iommu_v2 module
Thread-Topic: [PATCH v3 1/5] iommu/amd: Remove iommu_v2 module
Thread-Index: AQHZ7G6D8C15gDSmGUyI0hSW7LwfLrAlT/OwgAAC/YCAAA660A==
Date: Thu, 21 Sep 2023 15:15:42 +0000
Message-ID:
 <BL1PR12MB51449627A11B2BDA55B97C8CF7F8A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230921093140.6162-1-vasant.hegde@amd.com>
 <20230921093140.6162-2-vasant.hegde@amd.com>
 <BL1PR12MB5144C5ADC106D450EA73C511F7F8A@BL1PR12MB5144.namprd12.prod.outlook.com>
 <20230921141415.GN13733@nvidia.com>
In-Reply-To: <20230921141415.GN13733@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b6475c50-f00f-4584-ace4-b8b89b8961bc;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-21T15:06:57Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SN7PR12MB7346:EE_
x-ms-office365-filtering-correlation-id: 8a28d028-7b94-4fec-73ff-08dbbab59f75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 oK/kGeoqW54YVIV+pQJ6y774ZzKOpwLYzeE/BkYNW2yL48b6T3RJ3v5OyirhHNcgZ0wF3obBel+L5PQzDrqcpj+4Ww1hE6P9OEZSVrbVlHcDik6hAg2T44hxTq6oQeqQkvhaBO+HQdADvIn/u97MuhwBxEfMveLvjJRDZUuQVU2wJQmDYSB9n4P9c0rXihBOs5MZfVp8x5flOzFpVms2PRuACpbck3+cvKSLulrRx0CJfdW7FMiCXEpYXU7V3FviUnQhPmDLmIjMkFntOKpr0iugWDDmxC4jb5yerC/TlPia9cBB3G/t8FY8yBYGqTs4rsHOLRKe8GJlkfFThJ6BsxbNIvT3qW7u9Aece3rAQxYcNfHwsPS5ascg11HjgTMbrqVTvzih4KIq/eIvsVvoqZ+F70C/RIelFKH8rCn4ot+IeBiqenX5Xl/YkeS+I9vmQwH4gR1HIozBuWXwB8z40KGgi12q2ge8LM+wSAZ9hEqHlsA27iTothh+N3ELHUu7+md+1IRG7C9qWA8A8IRTrTJMIueWMHhQRh1CXLh33l3znVUY01mrFPU2MVemlMQ7jw7ftDXuI15NxuTCfJ8+E3d+gkPv7us7mDGIXtweP/85SKqpBv73yl/kouIuST4c
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(366004)(136003)(451199024)(1800799009)(186009)(478600001)(64756008)(55016003)(5660300002)(6506007)(53546011)(7696005)(86362001)(54906003)(66476007)(66946007)(38100700002)(66556008)(316002)(76116006)(66446008)(41300700001)(38070700005)(6916009)(71200400001)(9686003)(8936002)(26005)(52536014)(83380400001)(4326008)(122000001)(8676002)(33656002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9TOI+rGiul0SpAVMxG5DQ4wcgr60Y553fOSCMveh6DbARJXzX6Hu3fqAVRPy?=
 =?us-ascii?Q?AzIZASzZNeHlpYKJw89uTuaNp6wFGAAzJbn53rrNtaEKy0/WCF3ZWzbz1qxy?=
 =?us-ascii?Q?LtTVM7hTYWHitpIG8m4Rmxp7al+JvhxjBPK5hRm4FFil1VTs8InBm6DUBmUr?=
 =?us-ascii?Q?Ov8zuoULzorGeKCmJ1fVB/Q6qeTOJ1R6LwwKk6NB345A3j/q4qudlvlZXKQH?=
 =?us-ascii?Q?qLdq0SWCwJZfbpNLAl2x7yWOfji22ByXtuyeBiGnPwOzT2Ps4W0KHlz7BNY9?=
 =?us-ascii?Q?ETNL+ISQf2LGaUGcdbyVcYXTsS/PMYibpEZ0KMlRP1ZCTQM/kOL5sFL9WZ/t?=
 =?us-ascii?Q?//N9eQOGJhQwRqdfwr0xky9+ibt3tpjAIty4bg0D+E6Mp4R1+XQM/fq2beMS?=
 =?us-ascii?Q?7AWq5wvwR1SF1T4ZI75ykGjFtB/T6H7GPkKRcoOVp7GyYxwVsHbMsFi5n5vS?=
 =?us-ascii?Q?BjTlsY68E9K9BzXRNtHj6jd2ox3E8c/nzj36PSizDjbKMqzHHhXG7c/T0o+E?=
 =?us-ascii?Q?QDO/3tGPW1sIr/OcnqEkpKI0eF9Qw13yUzcYGLGrOS4PjxZhJmN+khQMIX+z?=
 =?us-ascii?Q?v6eTeaxrjySnxiqzhpQxxOZXN0QTznxE/RDV4zFfW73JZjkb/df7GnSzGZR5?=
 =?us-ascii?Q?49e5owIU82+WZDPyOW+E99gL7UXMeDnRWJWXPBXaHFBFS/VVPjkxD9ZrLcm6?=
 =?us-ascii?Q?xqvr8sH2NfVQ2deXRyGoJbnBOn+k8GjGD50o/Z4eeKsGl9Zk2DvkKmOXBevQ?=
 =?us-ascii?Q?6ooJnHKyIOT7rK6lfPeFOSAoOp7u9HZOhcCjoGbYn8S+OXq/GmwqHbgyfJrU?=
 =?us-ascii?Q?DZ2WelQifFTir4ZqpnRDfJF1sESBbao0+PgXvi9KjU73PSVb4iQkEGxkI6ox?=
 =?us-ascii?Q?LQ7rYND34J4gJPnVI0KYOejkwn5x4SRUnOMJBtMDoVLyYuq4UPw6IoYaxweC?=
 =?us-ascii?Q?SU/ImR2B5K4GeAQ13FQJ8DxYeITn54GTvi634d1ePzGF48BV7t0Gs13qRvkJ?=
 =?us-ascii?Q?wfIJ9izy4QuRocrWulBA8TxhmEz311AROSiTiYMOEZHwylo3D8EQq+MHAQci?=
 =?us-ascii?Q?RGiI5SNN64RzShIgaerXFKFZcdgWUVSAis3vmfRjQLCrsVOfEyYNCHeB3VaF?=
 =?us-ascii?Q?P6qQcMAHWEwsxZoohIDGBI6BA9xlwlA/dWN4nfSdUOu6AqPEY3+FjxN4Z65J?=
 =?us-ascii?Q?rak8i5pC5QXWMgqRgaVeQKBLxzZLH+GhU3nko4v28KQpE93YvzhfV+mKNzdc?=
 =?us-ascii?Q?QG+EszNL8coG6b4fGYm93mw01OI4eIGtOKNA1EXa2l3lOKZcrNQi4XO3cMzl?=
 =?us-ascii?Q?dv3kY8slKtV35zcOKyKAP9o3o1+AuF/ecDIIuxFLO46UORUUO+bWfuUL1naA?=
 =?us-ascii?Q?X71o0w91qL734DZJVotmavQyaG1URnLyzVLZ+OMTSf42zAY3qEz5Gj9THu4P?=
 =?us-ascii?Q?tPbX4BTilA3y7FO2wyyiuBwWVJwR/Bbn1t3hNE0Tp/Uo9fIC69mrJRUeZdNH?=
 =?us-ascii?Q?s0go+s+THt4GT7yLcpVfCp/LiXo9FFMbtAaHrPawtkGH3QFpCXnYtEi8V9UC?=
 =?us-ascii?Q?GaC/XD/uEYOWWNMhNdc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a28d028-7b94-4fec-73ff-08dbbab59f75
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 15:15:42.9663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Iy5DrkKD76wk4QiR/UKUEL/bzbODBF8UulVoeUAqditWsU1Qj5B4QNRF8IdMWwaalTWmXnzc0wf2QG5cVAdOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7346

[AMD Official Use Only - General]

> -----Original Message-----
> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, September 21, 2023 10:14 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: Hegde, Vasant <Vasant.Hegde@amd.com>; iommu@lists.linux.dev;
> joro@8bytes.org; Suthikulpanit, Suravee <Suravee.Suthikulpanit@amd.com>;
> Huang2, Wei <Wei.Huang2@amd.com>; jsnitsel@redhat.com; Kuehling, Felix
> <Felix.Kuehling@amd.com>
> Subject: Re: [PATCH v3 1/5] iommu/amd: Remove iommu_v2 module
>
> On Thu, Sep 21, 2023 at 02:05:37PM +0000, Deucher, Alexander wrote:
> > [AMD Official Use Only - General]
> >
> > > -----Original Message-----
> > > From: Hegde, Vasant <Vasant.Hegde@amd.com>
> > > Sent: Thursday, September 21, 2023 5:32 AM
> > > To: iommu@lists.linux.dev; joro@8bytes.org
> > > Cc: Suthikulpanit, Suravee <Suravee.Suthikulpanit@amd.com>; Huang2,
> > > Wei <Wei.Huang2@amd.com>; jsnitsel@redhat.com; jgg@ziepe.ca;
> Hegde,
> > > Vasant <Vasant.Hegde@amd.com>; Deucher, Alexander
> > > <Alexander.Deucher@amd.com>; Kuehling, Felix
> > > <Felix.Kuehling@amd.com>; Jason Gunthorpe <jgg@nvidia.com>
> > > Subject: [PATCH v3 1/5] iommu/amd: Remove iommu_v2 module
> > >
> > > AMD GPU driver which was the only in-kernel user of iommu_v2 module
> > > removed dependency on iommu_v2 module.
> > >
> > > Also we are working on adding SVA support in AMD IOMMU driver.
> > > Device drivers are expected to use common SVA framework to enable
> > > device PASID/PRI features.
> > >
> > > Removing iommu_v2 module and then adding SVA simplifies the
> > > development.
> > > Hence remove iommu_v2 module.
> >
> > Does this patch or the following patches make any functional changes
> > for devices?  E.g., devices which supported ATS would have been put
> > into an identity mapping mode previously Is that still retained?
>
> Huh? Why would we ever want to do that?
>
> Policy for the default domain belongs in the iommu subsystem except in
> extreme cases, the AMD driver should not be doing random things like forc=
ing
> identity for ATS capable PCI devices.

I'm just concerned about regressions in random devices due to a change in p=
olicy in the IOMMU driver.  Previously the IOMMU driver would put ATS compa=
tible devices into 1:1 mode.  Also some of the earlier integrated GPUs requ=
ire 1:1 mapping for display from system memory due to hardware limitations.=
  There were also a lot of sbios bugs in the carrizo/raven timeframe becaus=
e windows didn't enable the IOMMU so lots of OEMs had bogus IOMMU ACPI tabl=
es which didn't cause problems when 1:1 mode was used.

Alex

