Return-Path: <SRS0=eGnl=LK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A883DC48BE5
	for <iommu@archiver.kernel.org>; Wed, 16 Jun 2021 00:03:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F6346008E
	for <iommu@archiver.kernel.org>; Wed, 16 Jun 2021 00:03:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F6346008E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 117FC40644;
	Wed, 16 Jun 2021 00:03:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q4qVMHaLwdZB; Wed, 16 Jun 2021 00:03:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9247A4049C;
	Wed, 16 Jun 2021 00:03:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 567D1C000E;
	Wed, 16 Jun 2021 00:03:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89B91C000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 00:02:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7305940602
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 00:02:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1Pn1XcoqewQP for <iommu@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 00:02:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 760CA4049C
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 00:02:57 +0000 (UTC)
IronPort-SDR: Y5f37W7oiS1Uf9sSSrNyEMxBm3wWtoNNs1S5dBFC3f685HQRurY8eeC3SIqQE/KUKSzoQaIBxP
 K90S17zpHVQA==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="203066501"
X-IronPort-AV: E=Sophos;i="5.83,276,1616482800"; d="scan'208";a="203066501"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2021 17:02:55 -0700
IronPort-SDR: iG598vUl0++JcPL0AY6F7Wy4zxfWbG5QD/ePyblkkDHHMOFmfHmrEkYprxNEwtpNQQzs94ozXF
 zWJ2DiBK+y9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,276,1616482800"; d="scan'208";a="637280631"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
 by fmsmga006.fm.intel.com with ESMTP; 15 Jun 2021 17:02:55 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 15 Jun 2021 17:02:54 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 15 Jun 2021 17:02:53 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Tue, 15 Jun 2021 17:02:53 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Tue, 15 Jun 2021 17:02:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jo4Dc036XyV/hICLhecXCTb9jQzaAhSZCb7OpRt47qmZi3EqyfE3KpEVfB2NpxZg5D+AJ3c/SBA2/3km/3u920xi7i836B0Atvp1vCuOPR3Y+ONRCZt3ezFdCHkH9FK6Qt1/X+XsQJvTOSAHL20BIINA825EvvIDyR+uqn1d38HFfX0xUNI8GrVGmVJZ2xQ+TVbl+X2A9A0SYDp/h7xMvndDQF++vWMYzxKGWVlsDtJzeocEZYtfAykpVuL1njEVSVvY36mBfh1inznIzFtmzPNjjDdRTZqYF0/M31ScsYp0xF7d5jAYARZ+E9lgCS9IG15uucSulWDVEo04UMPcNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j68gUsh6pnpYP72F3/d0rfG91gYp2ftLCCIwUDeP790=;
 b=joLFUvUsbTutQXuQHZOWPrcDikD1PIJrF68d21Ydze6a6zYGuVfufluHD7+iPVOItM46uRx2moFY+44ssG+ccxzwlHqp5jWJUGwcM+GCpbY5flpY8Ccg/1yOvjIf/pf8BHpbwQhr9KUpexO074/qt8gp+FXD8j/m9Q0qt7ok5ag8DY406eY3n1O0yKJoL09SvMHd5wimfCEbzMxI+qSUjXVJJRIjUYekzD4toXJcTNhmb7ytNNF4inBJuVOO82rsplFu5gwl5ZT6dejGS/9nizGYWgsJXnOJKW7WKamKpl8i4uMcMFQ7KWR7BZjOmsrgocfaqmX5N0ALACCacamKEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j68gUsh6pnpYP72F3/d0rfG91gYp2ftLCCIwUDeP790=;
 b=gQflc6N/a1sGx0xRtDzhTduxkJjZvjbLZPgI/bH+8O2FXk2DQmmYChMD/T8OPHjVkv1ogZDN9kLI89qW3fzBRoKRzV5EpH2Lx6Z4HXeZct55i44hUVuUbOMSu8UzZN+BvHQoKYLIHWFRhIdoA8vmsfM0IxpuAZLDN/5VAOXM6TE=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by MWHPR1101MB2128.namprd11.prod.outlook.com (2603:10b6:301:55::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Wed, 16 Jun
 2021 00:02:20 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::6597:eb05:c507:c6c1]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::6597:eb05:c507:c6c1%12]) with mapi id 15.20.4219.025; Wed, 16 Jun
 2021 00:02:19 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [RFC] /dev/ioasid uAPI proposal
Thread-Topic: [RFC] /dev/ioasid uAPI proposal
Thread-Index: AddSzQ97BhCb3gd8AUyldaDZ6yOMNABTUTCAAQiuDaAADwOFgAJSmyVgAA0fjwAAEFKEEAAASwWAAAAgcXAAATmRgAAAC9RgAACZuQAAAAd+oA==
Date: Wed, 16 Jun 2021 00:02:19 +0000
Message-ID: <MWHPR11MB1886298A9D202A966F1D4DA68C0F9@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <20210528233649.GB3816344@nvidia.com>
 <MWHPR11MB188621A9D1181A414D5491198C3C9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210603130519.GY1002214@nvidia.com>
 <MWHPR11MB1886BA2258AFD92D5249AC488C309@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210615150630.GS1002214@nvidia.com>
 <MWHPR11MB1886E9553A5054DF7D51F27D8C309@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210615230215.GA1002214@nvidia.com>
 <MWHPR11MB1886A0CAB3AFF424A4A090038C309@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210615234057.GC1002214@nvidia.com>
 <MWHPR11MB1886FD4121F754A6F7C2102A8C309@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210615235928.GD1002214@nvidia.com>
In-Reply-To: <20210615235928.GD1002214@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [101.80.71.101]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a6a79d6-ea2a-479e-d5a9-08d9305a026d
x-ms-traffictypediagnostic: MWHPR1101MB2128:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1101MB2128C9C44EE6559E58E613D08C0F9@MWHPR1101MB2128.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nVNycm3PyjTJVKGWYmaqC77OJxHxTr+R1O174M4zZvA5KDOkipQ9VgMlgPNX2pddKW0k3yRBziNKMKbxkkxuDAs+wwqDZ5/A94hyd/Vlt6XnwYYq8oWbb4+Bh+iAwU8Trd1SVE4qP4KzToVb29YGDARyYf6Dldg+ni1pZI2tSCHxaee5PaRP9QnuDjLax0P6GuewoXmnL9sdbLYi/kkx/2uhSsEdWT4I6mEoyabFkxh9r1s8BLE7zlwtr4fllOa6ShrAgz/wDbdcEHOqt89euBYnA/WKKsA6UOJnQKgCihZXmAqx9vQWWJr9ooFBy5LJA5zyVk9pcMZpWFoDFCKwkrufDSrRhZN0ONcCdmtQpTu36KuzfJr3+tRWviEN+UOZZOrawrsUZYiqk/TvsLpCScb4N6ODNEwIhWMadLFXmsbhntUdx7q5TT18jV/53HVwo3n6FWA1SXd885IUtO5UYIcc7Q/Bcln4wEsysiUiJHsm3rp+Cek62Zi624CZKf3bxzE5Abi1qdpgDnMQ9bjudnUGrnzmbBzZ2gUgFG81nO7CkNXuHkJBLG2Kgo8mD0vylwcHzF0eHn0wZMX28FX4ps4eDJ5CD7b33IAZ36Rn8wA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1886.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(366004)(396003)(39860400002)(136003)(376002)(5660300002)(52536014)(76116006)(9686003)(66946007)(66476007)(55016002)(478600001)(38100700002)(64756008)(122000001)(66556008)(66446008)(6506007)(316002)(2906002)(7696005)(4326008)(33656002)(26005)(8676002)(71200400001)(86362001)(6916009)(54906003)(7416002)(8936002)(186003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?x/JVhxiaCNFDsBzN3ZEjVHF7yjKJZ3iS42S/aDQLGwkkug/ymnvg/OOkM1Af?=
 =?us-ascii?Q?YmBDXtYofF0McXCXtTqhd/pcTnbI74lKnZmcso8bBVXY8lml4ECJOXdw9G9P?=
 =?us-ascii?Q?ppbjWJ+NnwMnOwF+PlBBrJCNLtOyQHhSu9kDx7W/VM/gqpuA2up4BTSu7Q5t?=
 =?us-ascii?Q?agS62DOhijXFEm9xB380j/Eu6pE6spJ95L1YryXsGPiXm0vTN9TADJiZ7gRE?=
 =?us-ascii?Q?CTsupo+r4Tjffy62sv+8v4zDG4oE0eICnKxOaMJ+1zl45xR0FLyVM0d5lZs+?=
 =?us-ascii?Q?wyjxZmZPYViWGBKjalcBU1Jv4FiJQ6rZ75DxrUy9qF7CK92k0HCW3KcaT5x/?=
 =?us-ascii?Q?8KxmzZKx07jSIn7/Bo+kMycOg+1bObVYHzsx/lOEzoMzJI9IFP0kpYZRzZLe?=
 =?us-ascii?Q?5t7VCUJJ8ywIXz9XkBfVCbsNJ/y2bbM7TBPgGAMPKGd6jDMG8MCREuNbbeDX?=
 =?us-ascii?Q?IZKk1HHeBCbrVjckau257f2QYnS2w5S1HUgxjQtChY0J4npWd1qtj8QlYMjy?=
 =?us-ascii?Q?WCuF4htgjc0qoZdyBWtriik0OtuyufxgyD9/BOaOVMvlO5pmqxTotJhPeXcL?=
 =?us-ascii?Q?OTZq12iciVUoypeCT+NZKXRRzebToNUhww36SerIxRyPyYXd9J91Y0qkJtGH?=
 =?us-ascii?Q?0fDoGv1dWGpXHwtf7GAR6ZlJVThiz01CR+l9A0f6YVXKPDAvDAJONv/xN8Eq?=
 =?us-ascii?Q?b8RmQz20LswefYBHkojstQ/FlzXLjRZJIho/U2EHGLiE1kMqTcTZn4jNfhQP?=
 =?us-ascii?Q?n963Lk1VqBbahYRmWVgnsvKQW70GZ/IcxMb2/oAi8zdyCqdHiMopX3DnScDh?=
 =?us-ascii?Q?adfRpNFXe4cNrIEV+nCq7+5ciRc4vPd9Xr+g2FPpcUpbrJdCFdD8pvkiEQ9J?=
 =?us-ascii?Q?51UzLqWZPYbeZtReJqXgmx8KIqKC8nqjFbjVnqlGZ8G9qBNiLKI+HjQGCN56?=
 =?us-ascii?Q?DT4Skf3b1a0Zl9qX3krPwVdf8DD2w0uY15fFj5XMgXlcvP/MsyelVOpjOVhD?=
 =?us-ascii?Q?zthUgrEQ6huoKPulEeLrC53XTVF4/bht2/UyLc/b5XapZHb3DDR2NDePM/Ro?=
 =?us-ascii?Q?H+bLBSJCdWh+6/FEvEwEdyiugznswF3PsGaTlYI5ivNPixnzTBF0XpVMj1HG?=
 =?us-ascii?Q?TKhz/rwremSnx47dUtHRqPP4VHidwrpP/TPRXZSZUOd/3POfvDhMPPN1D/sQ?=
 =?us-ascii?Q?J430hiBETkjHjd8eB06sW1J6bUQPi5VnFbUnUmwJzgFXCxO0cheoL+Jd+A3C?=
 =?us-ascii?Q?4MdEjRDvmH0oINUHaj2hEkOMnyTqT7UUw+IR4ukDqHzQDAnS6WIe2wl0bkud?=
 =?us-ascii?Q?0Dd6SspJhAI5RzbuiSdSHPFi?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a6a79d6-ea2a-479e-d5a9-08d9305a026d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2021 00:02:19.5158 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hH48+eHxUiYbhaAs583sUrS3ygZq+Ds6UhbmxjLyN5lUOWQLQaR4xVfQWobN/ihB4bzhyNefDEENyuJAZrtaIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2128
X-OriginatorOrg: intel.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jonathan
 Corbet <corbet@lwn.net>, David Woodhouse <dwmw2@infradead.org>,
 Jason Wang <jasowang@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>, "Alex Williamson
 \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>, David
 Gibson <david@gibson.dropbear.id.au>
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
> Sent: Wednesday, June 16, 2021 7:59 AM
> 
> On Tue, Jun 15, 2021 at 11:56:28PM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Wednesday, June 16, 2021 7:41 AM
> > >
> > > On Tue, Jun 15, 2021 at 11:09:37PM +0000, Tian, Kevin wrote:
> > >
> > > > which information can you elaborate? This is the area which I'm not
> > > > familiar with thus would appreciate if you can help explain how this
> > > > bus specific information is utilized within the attach function or
> > > > sometime later.
> > >
> > > This is the idea that the device driver needs to specify which bus
> > > specific protocol it uses to issue DMA's when it attaches itself to an
> > > IOASID. For PCI:
> >
> > What about defining some general attributes instead of asking iommu
> > fd to understand those bus specific detail?
> 
> I prefer the API be very clear and intent driven, otherwise things
> just get confused.
> 
> The whole WBINVD/no-snoop discussion I think is proof of that :\
> 
> > from iommu p.o.v there is no difference from last one. In v2 the device
> > driver just needs to communicate the PASID virtualization policy at
> > device binding time,
> 
> I want it documented in the kernel source WTF is happening, because
> otherwise we are going to be completely lost in a few years. And your
> RFC did have device driver specific differences here
> 
> > > The device knows what it is going to do, we need to convey that to the
> > > IOMMU layer so it is prepared properly.
> >
> > Yes, but it's not necessarily to have iommu fd understand bus specific
> > attributes. In the end when /dev/iommu uAPI calls iommu layer interface,
> > it's all bus agnostic.
> 
> Why not? Just put some inline wrappers to translate the bus specific
> language to your generic language if that is what makes the most
> sense.
> 

I can do this. Thanks
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
