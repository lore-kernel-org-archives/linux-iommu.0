Return-Path: <SRS0=szPT=AU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9419BC433E1
	for <iommu@archiver.kernel.org>; Thu,  9 Jul 2020 07:16:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D4F220674
	for <iommu@archiver.kernel.org>; Thu,  9 Jul 2020 07:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="su7h2LT0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D4F220674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4D341884E1;
	Thu,  9 Jul 2020 07:16:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MvCd1V3cMEir; Thu,  9 Jul 2020 07:16:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1CA7088146;
	Thu,  9 Jul 2020 07:16:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F3143C077B;
	Thu,  9 Jul 2020 07:16:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4FE9AC016F
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 07:16:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 37DB387A44
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 07:16:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NCT6ARtHtQ6P for <iommu@lists.linux-foundation.org>;
 Thu,  9 Jul 2020 07:16:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C3A78878DF
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 07:16:35 +0000 (UTC)
IronPort-SDR: j/bvhiGg0Kf7UvGb0A64uVP7/UbBhEmgsSf+/mIzztjfpKEieR5Y7nPlu41ArilXwG2CPhaD+V
 rxOfPSEax80g==
X-IronPort-AV: E=McAfee;i="6000,8403,9676"; a="212864405"
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; d="scan'208";a="212864405"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2020 00:16:35 -0700
IronPort-SDR: mEcuIXPpo+CSnr9+iRLdSYH3DhPDGFKphqXGmv/9qu6AHU1/MdC6jsrCgHHkGjSyXX/uWJo5E4
 Ly2Dq+Vp0XRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; d="scan'208";a="297976929"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by orsmga002.jf.intel.com with ESMTP; 09 Jul 2020 00:16:34 -0700
Received: from fmsmsx122.amr.corp.intel.com (10.18.125.37) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 9 Jul 2020 00:16:34 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx122.amr.corp.intel.com (10.18.125.37) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 9 Jul 2020 00:16:34 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 9 Jul 2020 00:16:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHIHxdZRzmr9l6BvUSc48IeVS6fLVbQNHKoxBb8rhEmaCfwC9M8ZK5CmGYmdy6LD/Vb0zbaPsnZJX3mkJJXMXTtQLCHALWQyqGOBaHprv73YqikLQPMSXe0nP6h9ugz5Qq0QsJaVWuERtGFrIfJhuqM1R2MY7KDkYSUavQCczy8Na/0baXDIk1CEiFHo+Ih4tGNdCY29RD2YJav57shzF2HtWBVfHfJzd3KlY0IEu4uigmkSSERygI3s1dpwE541M5fDPoZtlOdX9oQDrxQe3694HUgD0BDp7jX402o/xDJh6bY1VUcTJdMJ0CNciTkbBmoQd7HFgqXeGWCh7IqAZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzDah4G83ePvZ/0nG7MtEK3LcdAJXzIxAOjhRA/YxyQ=;
 b=jF5mGmUZzQkwkvPxE3o8v+H0uz+h3pIekUV/wMjpX7RQwhCMvx7LMPnroyZ4YYkHVtnQs/w94azcSwrOt2cv2ZKfcYyK3ebXt++PWbmcyKrLtdjMslopQltu14OlrKW6/iznCLa4VUb7PiKFXdlc37LVpYAUV2kU5U/ofGReZXNzph4jJkfNAW3Qa4IzEWQun3LEoWl0imkmSSSS4YSZALS8p0/8da8XNxbBeJS0QcH3fWh2z6l3G3UH1EbVhbyib02Q6w8KgoPZ047kO+HaAqsn1gAXq0AjUdc7slfqXMmBP98oAXhTJRuf3mo5jbIHJ4O9YqF14Wnp8gkBPZ6LZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzDah4G83ePvZ/0nG7MtEK3LcdAJXzIxAOjhRA/YxyQ=;
 b=su7h2LT0MyL38ixDn2ARU3AZbQ4A8pBkHHZCWmjYN7PK6gvBAZpqDxO4H82Gmb4pMDxx5D1XodWuV/wMBuQ5ipNfrKAkN7nSzEzvDoN6b92srSgFzE7VAOw6UIu42dJXnEKP6g4QV4Cs1PkTwmbO03Ltrd2xEelw3lwRH4bSUgM=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM6PR11MB4724.namprd11.prod.outlook.com (2603:10b6:5:2ad::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.22; Thu, 9 Jul 2020 07:16:32 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364%10]) with mapi id 15.20.3174.021; Thu, 9 Jul 2020
 07:16:31 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>, Alex Williamson
 <alex.williamson@redhat.com>, "jacob.jun.pan@linux.intel.com"
 <jacob.jun.pan@linux.intel.com>
Subject: RE: [PATCH v3 06/14] vfio/type1: Add VFIO_IOMMU_PASID_REQUEST
 (alloc/free)
Thread-Topic: [PATCH v3 06/14] vfio/type1: Add VFIO_IOMMU_PASID_REQUEST
 (alloc/free)
Thread-Index: AQHWSgRRzB2G/Oy5QEmxCHQWFS0FB6j02KQAgACUCyCAB/5SUIAAxDYAgABLnwCAABmKAIAAAO4wgAAFFYCAAAD78IAASzDw
Date: Thu, 9 Jul 2020 07:16:31 +0000
Message-ID: <DM5PR11MB143584D5A0AAE13E0D2D04B7C3640@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1592988927-48009-1-git-send-email-yi.l.liu@intel.com>
 <1592988927-48009-7-git-send-email-yi.l.liu@intel.com>
 <20200702151832.048b44d1@x1.home>
 <CY4PR11MB1432DD97F44EB8AA5CCC87D8C36A0@CY4PR11MB1432.namprd11.prod.outlook.com>
 <DM5PR11MB1435B159DA10C8301B89A6F0C3670@DM5PR11MB1435.namprd11.prod.outlook.com>
 <20200708135444.4eac48a4@x1.home>
 <DM5PR11MB14358A8797E3C02E50B37FFEC3640@DM5PR11MB1435.namprd11.prod.outlook.com>
 <MWHPR11MB16456D12135AA36BA16CE4208C640@MWHPR11MB1645.namprd11.prod.outlook.com>
 <DM5PR11MB14357DC99EFCDE7E02944E2EC3640@DM5PR11MB1435.namprd11.prod.outlook.com>
 <MWHPR11MB1645F822D9267005AE5BCE528C640@MWHPR11MB1645.namprd11.prod.outlook.com>
 <DM5PR11MB143577F0C21EDB82B82EEB35C3640@DM5PR11MB1435.namprd11.prod.outlook.com>
In-Reply-To: <DM5PR11MB143577F0C21EDB82B82EEB35C3640@DM5PR11MB1435.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [117.169.230.114]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23d46618-6e4b-474a-a195-08d823d80199
x-ms-traffictypediagnostic: DM6PR11MB4724:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB4724E5ADD8953A15A670A0BBC3640@DM6PR11MB4724.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y/nYPKYhx+yaWUMQ56GeEQsyaI5q25OoZBDyeEzyboze7nJM0LQAqZEyHrn7tQDcqN9jG6KQ8ZHMCWGWGBwpFzt9tsRa8bhqNdxVQSLouwzNuz7uYkQ9aFCpjiSPswNRxQUguGvd0WZpCtZkNyStoHYgvyCbJIecYZXBuZq4l+cvU9AdJuJdt3pH6YNSR6bTT/34aMh65ctS0lhAnfqehUy2Vscuff+OGYiQBJ7ZMiwqTi5fld8MvuBJd0TKX+Yy5nv1wBevLdce3I33qYBgfV8qlVzzcdKkwbcZHx63yFuzP+P2PeeSGBEJ6frq5uyR+iE5FV3BlRvjw8ltve7we1E0Qe3VLham5k1YeWQSEbWp8ibbmDmdffilukowqPqFFYoB35qTap2L3S3xJ65Hvg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(376002)(136003)(39860400002)(346002)(478600001)(26005)(4326008)(966005)(86362001)(7696005)(2906002)(186003)(6506007)(83380400001)(52536014)(2940100002)(8936002)(8676002)(5660300002)(316002)(66946007)(66476007)(64756008)(110136005)(76116006)(66556008)(33656002)(9686003)(71200400001)(66446008)(55016002)(54906003)(7416002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: RJ1u42vVOC6cs2OZRhSFSN47Ha0FKYO1zZc9hKCBq1DUfTvInhbltm1OYoqaY9lODXxU6fMe1DmdtnYcHwy/cPzhlyzr4IH70Mu/dWrSNuLHbP1Mqb1f/QUhCtF3nEXCMiRrvdoLRt/9vlhsjxb6S2NSXqiHxsQGCDUCR++EutDT+XCsHWs87C4VFgyXFCpHvKwhxmAPmF4l4ynwEFUABpf0bDsVF3jBY3OD/lVZu1ulKtNyjEqpXw5vD7DIq+lhhZKnyrTF6fbp4WSQt1G3xlvJ9lS1RjdLwIWbSOaE+HZUWUCFBMFaqNaqWQYzWhebF3PA/xcAz9jsNTF7mYqEEsQigy1G9Vag6eXPH6t5zYPVd7gF1HtqN6LjYLYyVOIT2Li1W4rUGqUEtyl1cWG+eQmTXu98fGLWC+AtAMxa5As5mi3WXJgate2P25Mrr+M/Ok5UWVuIsU5JE/AB9nVCnoGU3CcxJKSfNgG/PffGLroxCGdXPpwoYBwKLamFOAJl
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d46618-6e4b-474a-a195-08d823d80199
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2020 07:16:31.8129 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K+jZcsbDhFY0n1/ReFi1dMlCgDsHrnJPYfhPYfxJRgCWm4n5Miy/lhu151mvt3HlHrgkE5kQm4qBux+WGbuDPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4724
X-OriginatorOrg: intel.com
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sun,
 Yi Y" <yi.y.sun@intel.com>, "Wu, Hao" <hao.wu@intel.com>, "Tian,
 Jun J" <jun.j.tian@intel.com>
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

Hi Alex,

After more thinking, looks like adding a r-b tree is still not enough to
solve the potential problem for free a range of PASID in one ioctl. If
caller gives [0, MAX_UNIT] in the free request, kernel anyhow should
loop all the PASIDs and search in the r-b tree. Even VFIO can track the
smallest/largest allocated PASID, and limit the free range to an accurate
range, it is still no efficient. For example, user has allocated two PASIDs
( 1 and 999), and user gives the [0, MAX_UNIT] range in free request. VFIO
will limit the free range to be [1, 999], but still needs to loop PASID 1 -
999, and search in r-b tree.

So I'm wondering can we fall back to prior proposal which only free one
PASID for a free request. how about your opinion?

https://lore.kernel.org/linux-iommu/20200416084031.7266ad40@w520.home/

Regards,
Yi Liu

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, July 9, 2020 10:26 AM
> 
> Hi Kevin,
> 
> > From: Tian, Kevin <kevin.tian@intel.com>
> > Sent: Thursday, July 9, 2020 10:18 AM
> >
> > > From: Liu, Yi L <yi.l.liu@intel.com>
> > > Sent: Thursday, July 9, 2020 10:08 AM
> > >
> > > Hi Kevin,
> > >
> > > > From: Tian, Kevin <kevin.tian@intel.com>
> > > > Sent: Thursday, July 9, 2020 9:57 AM
> > > >
> > > > > From: Liu, Yi L <yi.l.liu@intel.com>
> > > > > Sent: Thursday, July 9, 2020 8:32 AM
> > > > >
> > > > > Hi Alex,
> > > > >
> > > > > > Alex Williamson <alex.williamson@redhat.com>
> > > > > > Sent: Thursday, July 9, 2020 3:55 AM
> > > > > >
> > > > > > On Wed, 8 Jul 2020 08:16:16 +0000 "Liu, Yi L"
> > > > > > <yi.l.liu@intel.com> wrote:
> > > > > >
> > > > > > > Hi Alex,
> > > > > > >
> > > > > > > > From: Liu, Yi L < yi.l.liu@intel.com>
> > > > > > > > Sent: Friday, July 3, 2020 2:28 PM
> > > > > > > >
> > > > > > > > Hi Alex,
> > > > > > > >
> > > > > > > > > From: Alex Williamson <alex.williamson@redhat.com>
> > > > > > > > > Sent: Friday, July 3, 2020 5:19 AM
> > > > > > > > >
> > > > > > > > > On Wed, 24 Jun 2020 01:55:19 -0700 Liu Yi L
> > > > > > > > > <yi.l.liu@intel.com> wrote:
> > > > > > > > >
> > > > > > > > > > This patch allows user space to request PASID
> > > > > > > > > > allocation/free,
> > > e.g.
> > > > > > > > > > when serving the request from the guest.
> > > > > > > > > >
> > > > > > > > > > PASIDs that are not freed by userspace are
> > > > > > > > > > automatically freed
> > > > > when
> > > > > > > > > > the IOASID set is destroyed when process exits.
> > > > > > > [...]
> > > > > > > > > > +static int vfio_iommu_type1_pasid_request(struct
> > > > > > > > > > +vfio_iommu
> > > > > *iommu,
> > > > > > > > > > +					  unsigned long arg) {
> > > > > > > > > > +	struct vfio_iommu_type1_pasid_request req;
> > > > > > > > > > +	unsigned long minsz;
> > > > > > > > > > +
> > > > > > > > > > +	minsz = offsetofend(struct
> > vfio_iommu_type1_pasid_request,
> > > > > > range);
> > > > > > > > > > +
> > > > > > > > > > +	if (copy_from_user(&req, (void __user *)arg, minsz))
> > > > > > > > > > +		return -EFAULT;
> > > > > > > > > > +
> > > > > > > > > > +	if (req.argsz < minsz || (req.flags &
> > > > > > ~VFIO_PASID_REQUEST_MASK))
> > > > > > > > > > +		return -EINVAL;
> > > > > > > > > > +
> > > > > > > > > > +	if (req.range.min > req.range.max)
> > > > > > > > >
> > > > > > > > > Is it exploitable that a user can spin the kernel for a
> > > > > > > > > long time in the case of a free by calling this with [0,
> > > > > > > > > MAX_UINT] regardless of their
> > > > > > actual
> > > > > > > > allocations?
> > > > > > > >
> > > > > > > > IOASID can ensure that user can only free the PASIDs
> > > > > > > > allocated to the
> > > > > user.
> > > > > > but
> > > > > > > > it's true, kernel needs to loop all the PASIDs within the
> > > > > > > > range provided by user.
> > > > > > it
> > > > > > > > may take a long time. is there anything we can do? one
> > > > > > > > thing may limit
> > > > > the
> > > > > > range
> > > > > > > > provided by user?
> > > > > > >
> > > > > > > thought about it more, we have per-VM pasid quota (say
> > > > > > > 1000), so even if user passed down [0, MAX_UNIT], kernel
> > > > > > > will only loop the
> > > > > > > 1000 pasids at most. do you think we still need to do something on it?
> > > > > >
> > > > > > How do you figure that?  vfio_iommu_type1_pasid_request()
> > > > > > accepts the user's min/max so long as (max > min) and passes
> > > > > > that to vfio_iommu_type1_pasid_free(), then to
> > > > > > vfio_pasid_free_range() which loops as:
> > > > > >
> > > > > > 	ioasid_t pasid = min;
> > > > > > 	for (; pasid <= max; pasid++)
> > > > > > 		ioasid_free(pasid);
> > > > > >
> > > > > > A user might only be able to allocate 1000 pasids, but
> > > > > > apparently they can ask to free all they want.
> > > > > >
> > > > > > It's also not obvious to me that calling ioasid_free() is only
> > > > > > allowing the user to free their own passid.  Does it?  It
> > > > > > would be a pretty
> > > >
> > > > Agree. I thought ioasid_free should at least carry a token since
> > > > the user
> > > space is
> > > > only allowed to manage PASIDs in its own set...
> > > >
> > > > > > gaping hole if a user could free arbitrary pasids.  A r-b tree
> > > > > > of passids might help both for security and to bound spinning in a loop.
> > > > >
> > > > > oh, yes. BTW. instead of r-b tree in VFIO, maybe we can add an
> > > > > ioasid_set parameter for ioasid_free(), thus to prevent the user
> > > > > from freeing PASIDs that doesn't belong to it. I remember Jacob
> > > > > mentioned it
> > > before.
> > > > >
> > > >
> > > > check current ioasid_free:
> > > >
> > > >         spin_lock(&ioasid_allocator_lock);
> > > >         ioasid_data = xa_load(&active_allocator->xa, ioasid);
> > > >         if (!ioasid_data) {
> > > >                 pr_err("Trying to free unknown IOASID %u\n", ioasid);
> > > >                 goto exit_unlock;
> > > >         }
> > > >
> > > > Allow an user to trigger above lock paths with MAX_UINT times
> > > > might still
> > > be bad.
> > >
> > > yeah, how about the below two options:
> > >
> > > - comparing the max - min with the quota before calling ioasid_free().
> > >   If max - min > current quota of the user, then should fail it. If
> > >   max - min < quota, then call ioasid_free() one by one. still trigger
> > >   the above lock path with quota times.
> >
> > This is definitely wrong. [min, max] is about the range of the PASID
> > value, while quota is about the number of allocated PASIDs. It's a bit
> > weird to mix two together.
> 
> got it.
> 
> > btw what is the main purpose of allowing batch PASID free requests?
> > Can we just simplify to allow one PASID in each free just like how is
> > it done in allocation path?
> 
> it's an intention to reuse the [min, max] range as allocation path. currently, we
> don't have such request as far as I can see.
> 
> > >
> > > - pass the max and min to ioasid_free(), let ioasid_free() decide. should
> > >   be able to avoid trigger the lock multiple times, and ioasid has have a
> > >   track on how may PASIDs have been allocated, if max - min is larger than
> > >   the allocated number, should fail anyway.
> >
> > What about Alex's r-b tree suggestion? Is there any downside in you mind?
> 
> no downside, I was just wanting to reuse the tracks in ioasid_set. I can add a r-b
> for allocated PASIDs and find the PASIDs in the r-b tree only do free for the
> PASIDs found in r-b tree, others in the range would be ignored.
> does it look good?
> 
> Regards,
> Yi Liu
> 
> > Thanks,
> > Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
