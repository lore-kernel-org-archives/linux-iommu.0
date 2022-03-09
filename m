Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62891C433F5
	for <iommu@archiver.kernel.org>; Wed,  9 Mar 2022 17:53:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1444040977;
	Wed,  9 Mar 2022 17:53:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qxXj1pJjsYlS; Wed,  9 Mar 2022 17:53:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 94003415EC;
	Wed,  9 Mar 2022 17:53:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76E86C0012;
	Wed,  9 Mar 2022 17:53:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0FAFC000B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Mar 2022 17:53:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AB90B84315
 for <iommu@lists.linux-foundation.org>; Wed,  9 Mar 2022 17:53:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yVZ0LWQMjA2c for <iommu@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 17:53:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::604])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 45F9D84335
 for <iommu@lists.linux-foundation.org>; Wed,  9 Mar 2022 17:53:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lA8sx9WPGSXHFkSvUqjpj0RL4kMFcUDF/lBvpXP62UyinnwR8pyme7QSMt9mJ9KLhA3xCyo818VmLUpIAbpHzoSuOi2LLklcu1Fo980DFEFPA2kJwhG9I8vxrVKEKD+ihgm4qJ1uWfIRNecP5tckw+0HUvJvovVaSfNKtCwliy0bm4bBl2IpZx6feGzt/33N4Yh041WGLX4f9iYiMtP/85tlMPu7CxTRbbWul487z6s2XSAX/3qdkI2X1u4CBPkdsK5QYA/gRlwOh50z0azp54C5lgcpBqPoKW3rBxo+jgUqOlBpd/sbTE/8cBljwdjFQzpmUFdengk9jS+svGPhXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TofrTrJ1ZTClQ5COXLUNc7YFyHIUQOAI04hI4YgGUDk=;
 b=m7WB330wKkX6C2puprPsMtwOBZE/yRvGiYJGMiJnMym4VbIvMp000FhBGiQ3ecr5fuP0+eK9hcVqN0KTPt5XU3kOOe1H0oKCXxn3Jlw0mN6C4BiF6hhLyHsOpUhh4MTtbaxxk+XpLSK3V1t+tjr6FzM18UjPS5VLgxUAkjwRpmDggyg13jp0gVZvdcQ9sdsP216T9JaX8gZlsq7SmNiY0j7n1G5PAKDYFq3iNVJHz8TkC6w1L3tSoOqVlfQ7Fc0M52O9p8pxrS20exhIqNWGgMoI6GmyARwmCb7y1t0XsLUeZt+Nn5SETohRf8PZMQRmroHqvmqbtpOg9VbF0gSKKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TofrTrJ1ZTClQ5COXLUNc7YFyHIUQOAI04hI4YgGUDk=;
 b=ZQL67fh4EA8T0BkgkXtwW155xtX46XXuhvK+k63wnxIzZj+u4OVA6fcH5xwJjKtTf4AfURF91SEX5+y9Q3MktKqewSuoyT8aZM7jsWU2OSZBi8YWNrG60CE3C0f0p8tkce65+fH8XF8VizWPLh6cqZLbxcFzSimNEQ1Kmqc5/zc=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DM4PR12MB6012.namprd12.prod.outlook.com (2603:10b6:8:6c::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.16; Wed, 9 Mar 2022 17:53:03 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::2877:73e4:31e7:cecf]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::2877:73e4:31e7:cecf%7]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 17:53:03 +0000
To: Robin Murphy <robin.murphy@arm.com>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "corbet@lwn.net" <corbet@lwn.net>,
 "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "bp@alien8.de"
 <bp@alien8.de>, "mingo@redhat.com" <mingo@redhat.com>, "tglx@linutronix.de"
 <tglx@linutronix.de>, "joro@8bytes.org" <joro@8bytes.org>, "Suthikulpanit,
 Suravee" <Suravee.Suthikulpanit@amd.com>, "will@kernel.org"
 <will@kernel.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH] Documentation: x86: add documenation for AMD IOMMU
Thread-Topic: [PATCH] Documentation: x86: add documenation for AMD IOMMU
Thread-Index: AQHYMx9ywabA70hrekG0GfMv0K3Kk6y16nWAgAFr8yA=
Date: Wed, 9 Mar 2022 17:53:03 +0000
Message-ID: <BL1PR12MB5144723921D4C58804BCBCA0F70A9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220308190453.135068-1-alexander.deucher@amd.com>
 <1cd577e8-1364-ffc5-020c-330378a72c78@arm.com>
In-Reply-To: <1cd577e8-1364-ffc5-020c-330378a72c78@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-03-09T17:51:50Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=0ab7a671-16fc-41cb-b4f6-d5050c9d15f3;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-03-09T17:52:59Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 6b8bd7e7-2cff-4337-b3be-4f884ca658f8
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 188a2c0c-f5cb-4969-231e-08da01f5a8e2
x-ms-traffictypediagnostic: DM4PR12MB6012:EE_
x-microsoft-antispam-prvs: <DM4PR12MB6012451BD816B654EE601FD8F70A9@DM4PR12MB6012.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7jpvr7ftRKgmF+y9YBilMdvGe71EEhH/NQ/y/vmWZFll2zIh0XVG837glvKteuV0tk2zyue16YhtT5sZk2/BxQqVtDrvTT7SDbPEDi+jeMu7g4h3kPyohux8HoNRZtW1bESyPjjU86dJymlewYobXkKdUKk/SQD8BVBk3MU2LF3Cz5Rmgf8AVzvSdBr16v/a5p5YBSzGTmlmo64cegdFoxuX1zirktzFJrWyJHU1E6yf/80XzocMlfz86b46qKhRj5waDvgi/L6Y+yTgMMp4c4DdREhXOD+pBiEGTkLJTp9GYMrqknG94eBa/hrHqNSalYmRUbGvzOWgPmPY0HHcnLeouFPJEEaxIPBbDloqrn36qSCD0wcq8WjtC4xpY48503i5OReCqiCd3z8kwG4Qdo2bAMCsGJdetcVm4Nk9uK3jNcDL96Xq42CS0z5dy7XWxWRP0u1g3ccH4MSUmOx85nvrEIHamSB2Q95wQxcF7T7JDeZlvZNiwpwXRUPGY2UFwt+XuorX3cSbbtP0uh0Xh7mrY6e2t6yFDfCo2P0SXlky/E0OJcBp0xvjjdIUtQVkfOOPVhIFNrN9A5ozj/XQIDlHZLtmEzitMrpheHOHX2nBjQm9OD2gxA7Jb9s6UeLesLe1CHQHLYLqgChd1c9ac7Z8b5++iDWJ74IATSSN9XHZjbtLg2cqL7yReqI745p/wyTkIzNRShXd7H037e0Wtl1KwQ3wSYzyhbOWT9JFSh5+KYfueZNOJZpYfLjMoB5Fb8G+P89cSQ14X3yLs8wWodSAnELqZgrgV4qq1TVDuI7qKmz9B5arG7OmUEXBdo6w
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(84040400005)(110136005)(316002)(55016003)(53546011)(9686003)(508600001)(7696005)(6506007)(71200400001)(83380400001)(76116006)(8936002)(66556008)(66946007)(66446008)(26005)(64756008)(38070700005)(45080400002)(186003)(66476007)(8676002)(86362001)(52536014)(33656002)(921005)(5660300002)(7416002)(122000001)(38100700002)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uwT7Guwbxdx3AwyyzXW1PPoP0ciseuAgo0PkxkMOdLFC5J4Kf0pW7Wb3674D?=
 =?us-ascii?Q?r81UGO/L2fy8FmEeD+usuJ9C/yNw2fz48qIPgWgwYOjFs59LUzMwXBw6YXtI?=
 =?us-ascii?Q?EdxabDoh5nAw9a1aiW4qRnZSZjCbk9dW3dpIf1wRFHPWDS3asI8GElX5RhXy?=
 =?us-ascii?Q?5gNjaBRtUZIlYP9nUqt2WGj0DDYZxWSuXfzuowFEbtKBw6uQ8tUrRx2TNwqt?=
 =?us-ascii?Q?hOBTeYg56l3SjQa5/WIg8j7vbTKp/Nn+jTcXv99XRv3ziA/+7FAzugjJYjpd?=
 =?us-ascii?Q?zi3Yn2Lc3aCW/wsiPcWkMNtStnvWXlfbgAkNbxzlm77JKTQBjuYZZxjfEppu?=
 =?us-ascii?Q?yeajd94iWdDFpkR0FfteIZ9nVPtx+KgQ2BZPD2E9UqiRSG61E+JQwBw+bwM9?=
 =?us-ascii?Q?qi1g/aj87qZIHhgWPHnISgWW9EyLUKnRP7CmUhds6R5L8VwTtEfH0peqwEn8?=
 =?us-ascii?Q?dgYtRJyMVxdQu0SVvmDDHwNa5UbLR8UrDnw7UIy6yErc0WcF/cabzzHR4d9L?=
 =?us-ascii?Q?QNLj1X1y83S6lfgDbT0PcpU9L4aky7lqpg+WDXzK9rYFO3szGT38nAhkLxxb?=
 =?us-ascii?Q?yIzjggkpAH2U26t6bEoOGGaxE9dvb2PzDA3uuM4cFseWShRsiLFP7FXcIvqM?=
 =?us-ascii?Q?9K2HqVBYCmgpJgq4Uh33t66zhNM92EsDvpBMtuwomXsWt6kktGORB/joqgp5?=
 =?us-ascii?Q?+QzXJ5vaeWQEOfa2cRuQX9C/9BTf/nT4qVx0/63Bg5Ry5Nx1XD8h++Stb4Dj?=
 =?us-ascii?Q?tNuFULb4vULuBHgPIlH0MtvxdcrTAkEgPAoYQFMkZUODCDUvICthjQhfjSNL?=
 =?us-ascii?Q?4B4mMKyYwb0Hw5GbIGYyYVtDKZPeshnEJVOF0n/JModStV0foGkKk7JuNhDM?=
 =?us-ascii?Q?I4kfRdxMk8ea4rFscMqOCY3fpBJqcezD0Ii1eL+x8VxFiHzpVO0eA1bzll41?=
 =?us-ascii?Q?nxKR89nQhw2F6m2wUISyOJOWwQUSIP9iOAJofLxZxXoMcn866Vbrjg0dApoL?=
 =?us-ascii?Q?6tZ00haidvaEUp51Lz+8zU1fhfBVWDQ8EbtXvUIU32xtIGryfvO62+b9UfaF?=
 =?us-ascii?Q?jtNVYIqxCV2a1askme3AuM1fB5RH79C0K7QRYIAlDxiy7hrj/tZxJ189mGuh?=
 =?us-ascii?Q?9t0mySVBOkh+kXi7wAX4GSMKUmFpsYkcFU2luSca/W6chKsmUESk3h2ICSHT?=
 =?us-ascii?Q?FClScSZEc+fvTyRjzK2F9/afS/z+6R627ggsImbtglwSvw7oZfstJHlQHeya?=
 =?us-ascii?Q?qztNJCVKXROBxDZXTLZIRwmF64gZJSEfd6dkVO+X8QLYCKVLfc07N4TKkiKd?=
 =?us-ascii?Q?QPlHngGmaSL55upG1aDlo35PCzwtiyAjr4GcHEIW5/UX3le+eOZt+FdoNdDL?=
 =?us-ascii?Q?ZivwmxyStKkyEo5Im+eW7A6lZ8wrXWo8pOI9yFRudM8pOWEnZVhq07+GMwUg?=
 =?us-ascii?Q?c7URGwJcPVCkJLEJpM0vpZcsfTswxoBm8Kqt6x/5iTU1sY1gzb6riRlxKAfu?=
 =?us-ascii?Q?k7Yju5n2/6Tq67HB9T5dADYf9E2qCQhiCLRxacLPUBNO6ufe8Mz6y8bdl5J/?=
 =?us-ascii?Q?qQ5OS0M2sod1OL8TcKPDlCxyGABpB7P0b54WTcnNPqUDkPBb4CFRYlFCo7W5?=
 =?us-ascii?Q?QGVy0puLYws/cbaagAT3REQ=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 188a2c0c-f5cb-4969-231e-08da01f5a8e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2022 17:53:03.4760 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ztdc72vGN022OUx2EwAz3v+a/GOhjk/LE7cABlrFjAipssxTtvi5lFpwrrUc5AFpEgoRk02hl6buODQyUv6j3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6012
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
From: "Deucher, Alexander via iommu" <iommu@lists.linux-foundation.org>
Reply-To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

[Public]

> -----Original Message-----
> From: Robin Murphy <robin.murphy@arm.com>
> Sent: Tuesday, March 8, 2022 3:09 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org; corbet@lwn.net;
> hpa@zytor.com; x86@kernel.org; dave.hansen@linux.intel.com;
> bp@alien8.de; mingo@redhat.com; tglx@linutronix.de; joro@8bytes.org;
> Suthikulpanit, Suravee <Suravee.Suthikulpanit@amd.com>; will@kernel.org;
> iommu@lists.linux-foundation.org
> Subject: Re: [PATCH] Documentation: x86: add documenation for AMD
> IOMMU
> 
> On 2022-03-08 19:04, Alex Deucher via iommu wrote:
> > Add preliminary documenation for AMD IOMMU.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   Documentation/x86/amd-iommu.rst   | 85
> +++++++++++++++++++++++++++++++
> >   Documentation/x86/index.rst       |  1 +
> >   Documentation/x86/intel-iommu.rst |  2 +-
> >   3 files changed, 87 insertions(+), 1 deletion(-)
> >   create mode 100644 Documentation/x86/amd-iommu.rst
> >
> > diff --git a/Documentation/x86/amd-iommu.rst
> > b/Documentation/x86/amd-iommu.rst new file mode 100644 index
> > 000000000000..89820140fefa
> > --- /dev/null
> > +++ b/Documentation/x86/amd-iommu.rst
> > @@ -0,0 +1,85 @@
> > +=================
> > +AMD IOMMU Support
> > +=================
> > +
> > +The architecture spec can be obtained from the below location.
> > +
> >
> +https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fw
> ww
> >
> +.amd.com%2Fsystem%2Ffiles%2FTechDocs%2F48882_IOMMU.pdf&amp;da
> ta=04%7C
> >
> +01%7Calexander.deucher%40amd.com%7C3adb51f8c3f1435e0deb08da013f
> 8172%7
> >
> +C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637823669974023501
> %7CUnkn
> >
> +own%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6I
> k1haWw
> >
> +iLCJXVCI6Mn0%3D%7C3000&amp;sdata=9Wq07GM%2BdT9xt%2FCZ3xhue
> %2BrNIe6CnD
> > +cG32kwqosUEZ8%3D&amp;reserved=0
> > +
> > +This guide gives a quick cheat sheet for some basic understanding.
> > +
> > +Some Keywords
> > +
> > +- IVRS - I/O Virtualization Reporting Structure
> > +- IVDB - I/O Virtualization Definition Block
> > +- IVHD - I/O Virtualization Hardware Definition
> > +- IOVA - I/O Virtual Address.
> > +
> > +Basic stuff
> > +-----------
> > +
> > +ACPI enumerates and lists the different DMA engines in the platform,
> > +and device scope relationships between PCI devices and which DMA
> > +engine controls them.
> 
> "DMA engine" typically means a dedicated device for peripheral-to-memory
> or memory-to-memory transfers, or the responsible block within a general
> DMA-capable endpoint. In the context of the original Intel doc from whence I
> see this is copied, this probably should have said "DMAR unit"
> or similar; here I'd suggest picking your favourite vendor-appropriate term
> for "instance of IOMMU translation hardware". Let's not promote confusion
> more than necessary.
> 
> > +
> > +What is IVRS?
> > +-------------
> > +
> > +The architecture defines an ACPI-compatible data structure called an
> > +I/O Virtualization Reporting Structure (IVRS) that is used to convey
> > +information related to I/O virtualization to system software.  The
> > +IVRS describes the configuration and capabilities of the IOMMUs
> > +contained in the platform as well as information about the devices that
> each IOMMU virtualizes.
> > +
> > +The IVRS provides information about the following:
> > +- IOMMUs present in the platform including their capabilities and
> > +proper configuration
> > +- System I/O topology relevant to each IOMMU
> > +- Peripheral devices that cannot be otherwise enumerated
> > +- Memory regions used by SMI/SMM, platform firmware, and platform
> > +hardware. These are generally exclusion ranges to be configured by
> system software.
> > +
> > +How is IOVA generated?
> > +----------------------
> > +
> > +Well behaved drivers call pci_map_*() calls before sending command to
> > +device
> 
> Horribly out-of-date drivers call pci_map_*(). Modern well-behaved drivers
> call dma_map_*() ;)
> 
> > +that needs to perform DMA. Once DMA is completed and mapping is no
> > +longer required, device performs a pci_unmap_*() calls to unmap the
> region.
> > +
> > +The AMD IOMMU driver allocates a virtual address per domain. Each
> > +PCIE device has its own domain (hence protection). Devices under p2p
> > +bridges share the virtual address with all devices under the p2p
> > +bridge due to transaction id aliasing for p2p bridges.
> > +
> > +IOVA generation is pretty generic. We used the same technique as
> > +vmalloc() but these are not global address spaces, but separate for each
> domain.
> > +Different DMA engines may support different number of domains.
> 
> I'm not sure about this whole section, really - IOVA management was entirely
> decoupled from drivers some time ago. If there's value in having some
> overview documentation, then it's probably worth consolidating into a
> common "IOMMU API" doc that can be cross-referenced for a summary of
> domains, groups, and iommu_dma_ops.
> 
> > +
> > +
> > +Fault reporting
> > +---------------
> > +When errors are reported, the DMA engine signals via an interrupt. The
> fault
> 
> Again, here I instinctively read "DMA engine" as being the endpoint
> device *making* the DMA transaction that faulted, and indeed that might
> happen to raise its own error interrupt if it gets an unexpected abort
> back from the IOMMU, which is coincidental to a thoroughly misleading
> degree...

Thanks for the review Robin.  All good points.  I've fixed them up and also fixed up the Intel documentation.  Will send out v2 shortly.

Thanks,

Alex

> 
> Thanks,
> Robin.
> 
> > +reason and device that caused it with fault reason is printed on console.
> > +
> > +See below for sample.
> > +
> > +
> > +Boot Message Sample
> > +-------------------
> > +
> > +Something like this gets printed indicating presence of the IOMMU.
> > +
> > +	iommu: Default domain type: Translated
> > +	iommu: DMA domain TLB invalidation policy: lazy mode
> > +
> > +
> > +PCI-DMA: Using AMD IOMMU
> > +------------------------
> > +
> > +Fault reporting
> > +^^^^^^^^^^^^^^^
> > +
> > +::
> > +
> > +	AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0007
> address=0xffffc02000 flags=0x0000]
> > +	AMD-Vi: Event logged [IO_PAGE_FAULT device=07:00.0
> domain=0x0007 address=0xffffc02000 flags=0x0000]
> > +
> > diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
> > index f498f1d36cd3..15711134eb68 100644
> > --- a/Documentation/x86/index.rst
> > +++ b/Documentation/x86/index.rst
> > @@ -22,6 +22,7 @@ x86-specific Documentation
> >      mtrr
> >      pat
> >      intel-iommu
> > +   amd-iommu
> >      intel_txt
> >      amd-memory-encryption
> >      pti
> > diff --git a/Documentation/x86/intel-iommu.rst
> b/Documentation/x86/intel-iommu.rst
> > index 099f13d51d5f..4d3391c7bd3f 100644
> > --- a/Documentation/x86/intel-iommu.rst
> > +++ b/Documentation/x86/intel-iommu.rst
> > @@ -1,5 +1,5 @@
> >   ===================
> > -Linux IOMMU Support
> > +Intel IOMMU Support
> >   ===================
> >
> >   The architecture spec can be obtained from the below location.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
