Return-Path: <SRS0=kThj=K4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51B7C47093
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 02:00:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C207613D1
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 02:00:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C207613D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2483F605EB;
	Wed,  2 Jun 2021 02:00:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dbHhaqe7GLCl; Wed,  2 Jun 2021 02:00:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id DF5A6605BA;
	Wed,  2 Jun 2021 02:00:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C7022C000E;
	Wed,  2 Jun 2021 02:00:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D5FBC0001
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 02:00:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2EB688356E
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 02:00:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1qea2xGbxDY8 for <iommu@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 02:00:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1596583498
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 02:00:23 +0000 (UTC)
IronPort-SDR: my66Fn6BOPIyq84pgpkXiW14PdYD+SByU/FfVC/VUIeQLaNTHqQWTEWThYUB2P2s4IWCVd7d+Y
 FqA7tvx7xDGw==
X-IronPort-AV: E=McAfee;i="6200,9189,10002"; a="289309450"
X-IronPort-AV: E=Sophos;i="5.83,241,1616482800"; d="scan'208";a="289309450"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2021 19:00:21 -0700
IronPort-SDR: 25+6Y7LXK47ISarLYi6xRSNGLRyZDrIpUmj0Va5L/K39MmT+HoTUi1rzZURnw17L2UOG4yXjFz
 A9h0h54+CeVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,241,1616482800"; d="scan'208";a="416688240"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
 by orsmga002.jf.intel.com with ESMTP; 01 Jun 2021 19:00:21 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 1 Jun 2021 19:00:21 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Tue, 1 Jun 2021 19:00:21 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Tue, 1 Jun 2021 19:00:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHv4QcdOaBm3FjNskRP6yPUkD9DxdQozs+l2ZiQDWydN1cvPyRgtrS0uzWpO3UP6eHJ/CUOvqUI8rLbEmZC2BQz7qvu5bnxmHVFYAPdoAPYoScB/wDtMauRnj5Le+0lUKKWxRUWbcRbnXUqwuGSpgIVg5Ni1eg8JTZu5Fte6G2JUrRmyoIxrdqv2GNjA9RAh1OXDEd461WBzsrmDXdg3mtebzVX4NZiU7C0xINtUl25qffoH8OGBzpLp4n1TAhOqQ7SUZWrPaDZfaK3sgskrgUQEbUpApuZxdCLgf43s9zjCsIvXlnRrjipN5cRuK3P0wlFQmP6QG3Bre+pWKzr84Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQpX802ARBgYunDY8oTHpKBWLmspJouGHpXDjn9YAb0=;
 b=XQe2grOyi4yva4gsdow/qegTvsZTLhn3fp5BL6CiITaHWgjkzdn3lQ99Flx5Eu8kk4RUuYIKIxFDNBGiUyqfCJkjrYthJptKY5ckhI8e7lJSvei2i/PoGCNEe8o4m2R3QaF5GlD3Zm2pRTA5RMhVaz0ceB5g3miiLIbgq6vp6dl8t3Gl0QTAQw+k+EY9/Nft/sN5DD2feMy7xoBliYa1CxzE+YijCxJmQA/OCHXCFZHcCt4KOzH+3gF9TVNl+JgOZON0/Tk5J0KHCvprfCy1sppEzVyOXyxFdBqj5vyvvPB3wFTeZ35FUdqaQVn06UgqXbKlUUl8G6EhiIqsTrkPWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQpX802ARBgYunDY8oTHpKBWLmspJouGHpXDjn9YAb0=;
 b=SVSpdU4hEcs36vuUNTBRE8kZLgDSVSj/+Z095eHPweKODmpaX7XPTL7/lmcZWAG/H6qkMGNB+vCFy1pKpvkPSU3VlSmCnCAukDFhuLJNP1sEYHhhBV5fpWN4tEPEO/UTXnVWJeHOQtHXP/d5TH4JCCJiUbljd8ZCINeADu5se6U=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by MWHPR1101MB2336.namprd11.prod.outlook.com (2603:10b6:300:75::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 2 Jun
 2021 02:00:17 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::6597:eb05:c507:c6c1]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::6597:eb05:c507:c6c1%12]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 02:00:17 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [RFC] /dev/ioasid uAPI proposal
Thread-Topic: [RFC] /dev/ioasid uAPI proposal
Thread-Index: AddSzQ970oLnVHLeQca/ysPD8zMJZwBLsqGAALCWeVAAFFHFgAAQEjDA
Date: Wed, 2 Jun 2021 02:00:17 +0000
Message-ID: <MWHPR11MB1886DE76EDAA9D7FFDDC7FA28C3D9@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528195839.GO1002214@nvidia.com>
 <MWHPR11MB1886A17F36CF744857C531148C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210601175643.GQ1002214@nvidia.com>
In-Reply-To: <20210601175643.GQ1002214@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.143.24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68f6f446-1314-4cab-9abc-08d9256a2b48
x-ms-traffictypediagnostic: MWHPR1101MB2336:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1101MB2336018566CEE7E6216CAA578C3D9@MWHPR1101MB2336.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W/KB65TPmvL+IDBn0DbpylaqkpSzMDggdjDz403jLxvWACNIUhb91rMNIUfOqtYN2nQpbbEsRtSnMMw8/2py4d2vtfg0TqgixO0oXLZDA2uIewsSFKFGp82mYRsO457HloDHPqRcluX4uLR4PgrpLycEUlRWtie8J75+9KKpCboVsSfs6bVDf+ltusLr6CI66T/ZIUriCDMi6vdOe6q9O9BC7r3wUxGxWNsExmGTZOvTBfGWyjDf8uv8N54r8WBAaq1D2pohVJ1+nIUpFXuvV8VKM084Qka8rd1l0EiSjjWe9sTr8ORmgl6QNCYBm1TpA+R8JOI+k+7dENxeGwFZ1oc2fCreZJ4NiXFhDqkxafOMN7dbGggKK/YCFs7bhVNj2FyCnKpagTJ1h3946zc2lEJAtB3krM+i8re/MgAbUHbLoJkZLOgVPjivRslmNpEiZfxVNALJhEiRN1ymX1wKamE8fKAyjiqa80bOIkoQ9JpP/sTTyd9+qwJ9LQcb153auOR4pB576xUacTGgw3y8R3zCph2xFxUd8DCDCbaFE5co74ohClDI59tiNa9mAWjKXr7z4DeNMmxWxX0Tg1Uw7Eu3l6bGuD4prFm0aNwGQnA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1886.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(39860400002)(346002)(396003)(376002)(366004)(26005)(64756008)(52536014)(9686003)(83380400001)(8676002)(76116006)(86362001)(122000001)(5660300002)(7416002)(186003)(66446008)(71200400001)(2906002)(478600001)(4326008)(316002)(55016002)(6916009)(66946007)(7696005)(54906003)(66556008)(8936002)(66476007)(6506007)(38100700002)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?pSp2/x6Bh2RkIO+JNxSHvg7QNwp1ZSpJGEGFVZ7f4Kln1FYhg6p4CP4CWN9f?=
 =?us-ascii?Q?BghYQ6IxW97O814kSuEKi90ifWE/uJgZ4Z0OzeCeCv2avJ88Xt0fBEdO/dW1?=
 =?us-ascii?Q?8+MFyrX2ktktemDb7/qfzozTgbNOY+dfzyZrfAeU7aV63vZQNaf1PE05LuN4?=
 =?us-ascii?Q?d3DIriDNG7K4ikGWSZ3Iv1g1rJeffVj2/sz61aCa6u7CUk8KejIHil6y+tlD?=
 =?us-ascii?Q?gStsfjjcktdmzHTH4fs8Y2esdHJIBYjxqXth51Gi2fHKCP+DtSHSOaK3oxYu?=
 =?us-ascii?Q?o/UD2IQ/efEVHVonQWySyaiXXN/pxhe46TWYOO4m+SoDPCCrdd7poSJZR7cw?=
 =?us-ascii?Q?52qtMoi+wceCjNm9i/OVoRv+GJqz2u5iSYOVqM4zj361J5EKONdgxCNQHxVu?=
 =?us-ascii?Q?kewOAeWg8BZchRtZ6s924lFTvvNuO5/0dl54L1KA6iZvL87ppP87FA/c0aNo?=
 =?us-ascii?Q?AMtsRzlYRJ4NR+Pk9FgCZQecNgVBCyhu5T2rdL92A/CtKjRUhQ9HGXXtWy7s?=
 =?us-ascii?Q?dSvSGdZ80FSrBQ65B5V+t1dEcaAGQdcrNfoP4BbrN1hQ/k1oA64B7yM881uD?=
 =?us-ascii?Q?G/UXYX2pVr32JWXxP1dyGCJMemn0ZCFgWZebVXE/Ygi7purMaH8qXBLSTH36?=
 =?us-ascii?Q?a5CL5j5pbRd1ObX1RNIW7ItMAKAJwg1+WQb3UZ558Y+2foqUesM2KLKSdW3Z?=
 =?us-ascii?Q?XjFpI5Rvut8LGjlTtiNcFMbhDm/HPaO8S9Nt7QZx/CkEXq6XoBtJTgUmB65p?=
 =?us-ascii?Q?0ShE4QXw/V4yk1AGjPpRpaUDRGCiX3mGiK7O9eXYI8F5Gh/4RWsdeRk7oq0j?=
 =?us-ascii?Q?4Jv1K7Ne0Z3FIoybXnlQ/zUIgePv3+Hzu1rgUsqmhr8lCS/e8F1E19MmC5mZ?=
 =?us-ascii?Q?VyzSBNpAb0mr4LxLJTq9FB084G++ds+wIYS9g+l+Z81eTwChTOjQh+vkkw6P?=
 =?us-ascii?Q?eWejt2pyQO0Bl3muvQu/q+k4VhHLCJExWQ5wDnqxtYLlasjaOBkmQ4GuHJNo?=
 =?us-ascii?Q?ATNQOzdF9fdWX3yr5vwjM+imQZCAvagY0DFCogereAoE819Puw9Gqaik/+pQ?=
 =?us-ascii?Q?WzvMK75rwpZySB2GKZiQDXvSwEnYT8NWjKP5DhSA9x1tN5LPdhxaka756Ql5?=
 =?us-ascii?Q?GDYXntrpPC29iOxUbC5yXVpKPRU6ST3l+CcSmvyQWZbeRRTz05Np9TkCu0WK?=
 =?us-ascii?Q?ZZtjEBb/I5G+OxA6LSw2FNhoRs9N4wS1nWjaMi+Hb06/MHHTq1OXKl+7Ch2+?=
 =?us-ascii?Q?KO+QXwxPkzBkUfUZCr47JurhSVQX4CW1qCQa1n7YuWdU7wdCG20R6jjzn02P?=
 =?us-ascii?Q?tydJpFJxt2AIc9ZTUJZPDY3i?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f6f446-1314-4cab-9abc-08d9256a2b48
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2021 02:00:17.1765 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SOX1mjUX/hPNvseLjnf/iHj59y1Pu63v+J2mZYH/C1YHCG6PjUkSOMgRohbDifg5e72TX9IhKK+lhUZeON9jKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2336
X-OriginatorOrg: intel.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Alex Williamson
 \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Robin
 Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 David Gibson <david@gibson.dropbear.id.au>, "Jiang,
 Dave" <dave.jiang@intel.com>, David Woodhouse <dwmw2@infradead.org>,
 Jason Wang <jasowang@redhat.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, June 2, 2021 1:57 AM
> 
> On Tue, Jun 01, 2021 at 08:38:00AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Saturday, May 29, 2021 3:59 AM
> > >
> > > On Thu, May 27, 2021 at 07:58:12AM +0000, Tian, Kevin wrote:
> > > >
> > > > 5. Use Cases and Flows
> > > >
> > > > Here assume VFIO will support a new model where every bound device
> > > > is explicitly listed under /dev/vfio thus a device fd can be acquired w/o
> > > > going through legacy container/group interface. For illustration purpose
> > > > those devices are just called dev[1...N]:
> > > >
> > > > 	device_fd[1...N] = open("/dev/vfio/devices/dev[1...N]", mode);
> > > >
> > > > As explained earlier, one IOASID fd is sufficient for all intended use
> cases:
> > > >
> > > > 	ioasid_fd = open("/dev/ioasid", mode);
> > > >
> > > > For simplicity below examples are all made for the virtualization story.
> > > > They are representative and could be easily adapted to a non-
> virtualization
> > > > scenario.
> > >
> > > For others, I don't think this is *strictly* necessary, we can
> > > probably still get to the device_fd using the group_fd and fit in
> > > /dev/ioasid. It does make the rest of this more readable though.
> >
> > Jason, want to confirm here. Per earlier discussion we remain an
> > impression that you want VFIO to be a pure device driver thus
> > container/group are used only for legacy application.
> 
> Let me call this a "nice wish".
> 
> If you get to a point where you hard need this, then identify the hard
> requirement and let's do it, but I wouldn't bloat this already large
> project unnecessarily.
> 

OK, got your point. So let's start by keeping this room. For new
sub-systems like vDPA,  they don't need inventing group fd uAPI
and just leave to their user to meet the group limitation. For existing
sub-system i.e. VFIO, it could keep a stronger group enforcement
uAPI like today. One day, we may revisit it if the simple policy works
well for all other new sub-systems.

> Similarly I wouldn't depend on the group fd existing in this design
> so it could be changed later.

Yes, this is guaranteed. /dev/ioasid uAPI has no group concept.

> 
> > From this comment are you suggesting that VFIO can still keep
> > container/ group concepts and user just deprecates the use of vfio
> > iommu uAPI (e.g. VFIO_SET_IOMMU) by using /dev/ioasid (which has a
> > simple policy that an IOASID will reject cmd if partially-attached
> > group exists)?
> 
> I would say no on the container. /dev/ioasid == the container, having
> two competing objects at once in a single process is just a mess.
> 
> If the group fd can be kept requires charting a path through the
> ioctls where the container is not used and /dev/ioasid is sub'd in
> using the same device FD specific IOCTLs you show here.

yes

> 
> I didn't try to chart this out carefully.
> 
> Also, ultimately, something need to be done about compatability with
> the vfio container fd. It looks clear enough to me that the the VFIO
> container FD is just a single IOASID using a special ioctl interface
> so it would be quite rasonable to harmonize these somehow.

Possibly multiple IOASIDs as VFIO container cay hold incompatible devices
today. Suppose helper functions will be provided for VFIO container to
create IOASID and then use map/unmap to manage its I/O page table.
This is the shim iommu driver concept in previous discussion between
you and Alex.

This can be done at a later stage. Let's focus on /dev/ioasid uAPI, and
bear some code duplication between it and vfio type1 for now. 

> 
> But that is too complicated and far out for me at least to guess on at
> this point..

We're working on a prototype in parallel with this discussion. Based on
this work we'll figure out what's the best way to start with.

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
