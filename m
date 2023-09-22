Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282B943A8B
	for <iommu@lists.linux.dev>; Fri, 22 Sep 2023 18:15:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FgPl0voeR1QKawuCeHGb6QbsFw+mqGSY0yFGkcopYnvV00rG9fQ88Ajh6/3QaT6u3r0XmhJNSJC0k7/9qkw4OSc225koK+R9++QRA0VRzJtszbyoFLJrccecsKhBJO3zYbHLG0IAU7sQaUy6q2/yzdPfDGOmwWU1pEpqqQmBCQfWPAKFdinVBXJY9K7xsiPy0lhOqRTJLoh4FwSay7YsNiTpIaE20nrrbHk2LKUUL0mSgyG7Jakc9f/ISB2Av2hwBwUaq+ldTOwakC2yaXdlaDLumk002At1zhT3y9XNTCHusxYjEGaMcYLViRQQfyPuCwhi4k3P4fFOIyAYj+ppIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=niEFIQLOWSfhqmpx1tJJlzRU4xDWrpcJKTtwFTf/w20=;
 b=TYebqo9V8hDFmw1ieQSbwUX4nN9B6vMq25czge3CPusHxqnSCZyIKN/uk40/NUDGcCAMaXkbVU/d5+okUAt/X0whWw7kvfu75HphIaHyrPer2bEtwKVB7RfJoMQ3bJZYxbcIt4hb7wXZKZddgHTxzOAlcssAZpITZ6HSuOkgT4RiBF4ZgSWZiX/EYwsP4NIu8CTTLD1nTFaPjfuGuXZTzLy3Fw8W1mlKF/wcP6FOraBLuhIscKlOCTrruJm9mCZ2EzKq9GBPgui3X5oYZAMpSZm5xNpwDphwXZ1KLyKXTru+tl2Ush144ldLZ/xMW0XvLYHtQV1fKaNNAqGr6DFdMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=niEFIQLOWSfhqmpx1tJJlzRU4xDWrpcJKTtwFTf/w20=;
 b=1C9YV+blZQtew70TPQKMI2YEOO/p9KzgIZtu622xD+GIbcEqnln8iB/5f8yBnL8RUqGnwr24hz85Nj9FfXWwo38VBw7m5tlNBZ9/iLgpiem8UZIaFhu3YWLyJGncxZKjfM5dW6hA5yhOtS1nw6xiBdVdtXdVvRrUrz6MLJXCAAk=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by IA1PR12MB6116.namprd12.prod.outlook.com (2603:10b6:208:3e8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Fri, 22 Sep
 2023 18:15:14 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a2bb:870f:8aaa:1ba2]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a2bb:870f:8aaa:1ba2%6]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 18:15:14 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "Hegde, Vasant" <Vasant.Hegde@amd.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "joro@8bytes.org" <joro@8bytes.org>, "Suthikulpanit,
 Suravee" <Suravee.Suthikulpanit@amd.com>, "Huang2, Wei" <Wei.Huang2@amd.com>,
	"jsnitsel@redhat.com" <jsnitsel@redhat.com>, "Kuehling, Felix"
	<Felix.Kuehling@amd.com>
Subject: RE: [PATCH v3 1/5] iommu/amd: Remove iommu_v2 module
Thread-Topic: [PATCH v3 1/5] iommu/amd: Remove iommu_v2 module
Thread-Index: AQHZ7G6D8C15gDSmGUyI0hSW7LwfLrAlT/OwgAAC/YCAAA660IAAF7sAgAGvACA=
Date: Fri, 22 Sep 2023 18:15:14 +0000
Message-ID:
 <BL1PR12MB51443F6DC0E724DD02995EDAF7FFA@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230921093140.6162-1-vasant.hegde@amd.com>
 <20230921093140.6162-2-vasant.hegde@amd.com>
 <BL1PR12MB5144C5ADC106D450EA73C511F7F8A@BL1PR12MB5144.namprd12.prod.outlook.com>
 <20230921141415.GN13733@nvidia.com>
 <BL1PR12MB51449627A11B2BDA55B97C8CF7F8A@BL1PR12MB5144.namprd12.prod.outlook.com>
 <20230921163154.GO13733@nvidia.com>
In-Reply-To: <20230921163154.GO13733@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=53c0a4ec-eb39-42a1-bf58-8191c2215baf;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-09-22T18:14:35Z;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|IA1PR12MB6116:EE_
x-ms-office365-filtering-correlation-id: 855c44df-7bd9-40b2-4942-08dbbb97de40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 mOicY4zd1S+tZLUJ+NEB7kr988iWjbtKQ0yAuixdd7NRqt6ygoL5IBLTtftv0JsezKB1E8jsgKnx7j8xksoD9GOhwkfr/7jzAQBve5F8WhPx5Cgd84Vdf8xg59erbJW//+yPv94BdXbzRPHojjT0YYUEkKBfaz7Iv4t/pDjl8aSDv8U+asV6g3Qguj8dixvfwk/8MDumdJ5562Y4iV+jNQXhHJlmRldPoFQJ7trFHu9i1HIPzwGWNH7rP0WMxMQJ/+JIORx5EIvlRlK8oEuXo0cbU7KXl4vNFQ3LAglZLZTynaRTYplJ4Lp79/hiE1TW6a7bNxohPeRq5vEsl/isMDWhX6I2x5gw1bk71ooiaKtPZBgvYffQCaxToo9W5aouPFO9jqgJUSvz9LTB+emyUDGgt93G4R1Tfj82MGg0glFClCCEkkrn9bAf3HGVCo/bbIIfK19fAl1KnYyndDbI+rtcMyjZL5NyNWU74fRbbd76jcaDI6fAQfziWyE8Qb8C6yCgSjxNCrV/9aTxwxEwgtDE5SrM6u55YCcfilVSWff4lDIUcwbnRLZ6/ih8uVDmOIHfWRJg/QUtAzOQmEGG1WiMi5lQ4PcpKqXbJxBs1zOG08vOHWShuNnSD4KQUZLI
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(136003)(39860400002)(396003)(1800799009)(186009)(451199024)(9686003)(64756008)(55016003)(316002)(38070700005)(26005)(76116006)(66946007)(6916009)(66446008)(54906003)(66556008)(41300700001)(122000001)(66476007)(71200400001)(478600001)(6506007)(53546011)(7696005)(33656002)(38100700002)(2906002)(83380400001)(52536014)(8676002)(8936002)(4326008)(86362001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?D5PWInjN6utV7zkINXaXdEu3SbsjL74kOR5Bbmw5WEEYh9P7sgA4wa8mQN3q?=
 =?us-ascii?Q?b74IoYCzoJllZ/ppC0ncF7xc2Z/OlLxGFnU0PcvV674tBYPIJWYQyZdLpLEI?=
 =?us-ascii?Q?+Xf9e6CAeeunC7F0A8tlQtjuBYMP/xbb0Eq3ztxeMDv7pCmJPGo9OQI8kPl/?=
 =?us-ascii?Q?smkAbkU1bF38vdDyPZ20bKwDbo37g3JtucfgyvU7hnyy2sN0ex0XlycMxllo?=
 =?us-ascii?Q?WLQL6Q6La96R4TIbDcFP8ENEDrUoivu8GQOGn4YNwkJe2Jd8i2SvuycTriE8?=
 =?us-ascii?Q?cixqV+7tO9RteZaAJT1ezI++XPgor5w1o8h+EpToFY+ip/IrGCikGVJi/sHa?=
 =?us-ascii?Q?gvhG3dd5DstPXNvdpfbManGu+mIXN9XUba5lMho2bNwKOoUcw3ZoI9dCdESM?=
 =?us-ascii?Q?S1A1yo7OvcRiK5STx7YKax9/Y+dUKAwTlB4GNDIk8DwUpsgxITqbudDUDiP6?=
 =?us-ascii?Q?sFGlVyJ5nOjde5y8xJdE1OwQG5q4G95a/LEQh9I7BUog0C0ovSE9HWVTvP7L?=
 =?us-ascii?Q?yaiOq3Cht7wuE9HLhXScKMhYpJHByEn99WeX428wDDX8vLdM35TQ6u4kThN1?=
 =?us-ascii?Q?pNFFJTNHmAPjqRZWaECwFFMDx+XQjH/vBwdfLISVD7eiQvpvOoflJ1JaC0yB?=
 =?us-ascii?Q?/1UQUOccoYcw7dkLdow2aIwR47kUpVB9q7U3HUtJ/IaCJMxMWqYNLKzCngRE?=
 =?us-ascii?Q?kj2FF1w1MyzKe24qI6wfMKDS6O2S0YOKcZUhuBefZaM4izH4c9ynSwLAY9/S?=
 =?us-ascii?Q?vBIRYpMk/I78WGqUVnAhFStKsI8XoONkg7hhYeqsy8lhM00cLBKfpTv7pGra?=
 =?us-ascii?Q?N4R92chKKTpPOf3sXrtLsDFIIW8OwhlXEXWWmmWRTzed2Eom2S6p4ONmMX9h?=
 =?us-ascii?Q?jVgj2igi5IGt6SLWqacihbI7osyTRkAOhcmU9UNrWE0LO33suUY9Vt3K7i9h?=
 =?us-ascii?Q?PYh4hWxGKyYTWsuw4JkHMAjv1QplVXWyCKZyfqxUlewHcCldY5aMv+vWovk/?=
 =?us-ascii?Q?yLMvS40fRKSo+DNb3fylPD3uT5kH2G3MEpkxHI+plf9S7qeIzqye94PEmyLA?=
 =?us-ascii?Q?+9JXBX9frlXq47usAozZCEmUrzk8LoSEkK1Esj34YOoAmbW0nzvBmc4Y4DS9?=
 =?us-ascii?Q?nFHNLmpqrdnxgLWew2OwOvnPjtxi++Rcrj+m+cJyEgb7sXuDji7NFOfYYX4x?=
 =?us-ascii?Q?XbFXK8lO1xX2EGyfM7TDaw8XsAKzbphBUjRpg9uHZ85/Img9h2Vk4axSA3ws?=
 =?us-ascii?Q?rtWGblwFv5mZsyWNxYLQSCBGqvd91hm6rBjSSmKnGp8ndwciaiLVsQfFFy/s?=
 =?us-ascii?Q?ohySzE6WM7u1dSs74N0YyBZn02CcUaa7Y3KWIp4hQ2LQ3TGsnzlSXad94tQt?=
 =?us-ascii?Q?f80ZtWF5y5AZDMOLA+4FzKbjR51AQBP3zy1HCGfkHScV0xqSG1P9DxmfhV50?=
 =?us-ascii?Q?Efjh5s10B0Jg2v7daAs5BHNQ5W/Z2Y4UUfMz+++LDZIEakMgLWzpqQUy1tOr?=
 =?us-ascii?Q?2kr7VGD7T8C5e/2MFjP8CGmtpvfJfQWe6/qFSX/Gz3q/XK8oIIicRvewjZJ0?=
 =?us-ascii?Q?SQ5L0+cnDVC16ld/VV8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 855c44df-7bd9-40b2-4942-08dbbb97de40
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 18:15:14.5742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YpC0ueXAqfTagp6sBtazrhHFqBwKGIhgx2gM07Nv/a5fWVaX3txjoNRn8c6PmQSf5U+rzzegPWGuW0kXWUytQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6116

[Public]

> -----Original Message-----
> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, September 21, 2023 12:32 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: Hegde, Vasant <Vasant.Hegde@amd.com>; iommu@lists.linux.dev;
> joro@8bytes.org; Suthikulpanit, Suravee <Suravee.Suthikulpanit@amd.com>;
> Huang2, Wei <Wei.Huang2@amd.com>; jsnitsel@redhat.com; Kuehling, Felix
> <Felix.Kuehling@amd.com>
> Subject: Re: [PATCH v3 1/5] iommu/amd: Remove iommu_v2 module
>
> On Thu, Sep 21, 2023 at 03:15:42PM +0000, Deucher, Alexander wrote:
> > > > Does this patch or the following patches make any functional
> > > > changes for devices?  E.g., devices which supported ATS would have
> > > > been put into an identity mapping mode previously Is that still ret=
ained?
> > >
> > > Huh? Why would we ever want to do that?
> > >
> > > Policy for the default domain belongs in the iommu subsystem except
> > > in extreme cases, the AMD driver should not be doing random things
> > > like forcing identity for ATS capable PCI devices.
> >
> > I'm just concerned about regressions in random devices due to a change
> > in policy in the IOMMU driver.  Previously the IOMMU driver would put
> > ATS compatible devices into 1:1 mode.  Also some of the earlier
> > integrated GPUs require 1:1 mapping for display from system memory due
> > to hardware limitations.  There were also a lot of sbios bugs in the
> > carrizo/raven timeframe because windows didn't enable the IOMMU so
> > lots of OEMs had bogus IOMMU ACPI tables which didn't cause problems
> > when 1:1 mode was used.
>
> That is a fair concern.
>
> But we need to root those out and fix them as narrow quirks. We don't wan=
t a
> driver to have blanket ATS =3D=3D identity configuration, it will harm ot=
her
> legitimate applications.
>
> eg if you want to narrowly quirk integrated GPUs and carrizo/raven that
> would be great.

I'm not opposed to quirks tables for those old systems.

Alex

