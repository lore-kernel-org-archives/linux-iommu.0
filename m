Return-Path: <SRS0=dlfR=AT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D967BC433E0
	for <iommu@archiver.kernel.org>; Wed,  8 Jul 2020 08:08:54 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9691320775
	for <iommu@archiver.kernel.org>; Wed,  8 Jul 2020 08:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="hXHnik2V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9691320775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6092D204B4;
	Wed,  8 Jul 2020 08:08:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tz-GbUbBUzzW; Wed,  8 Jul 2020 08:08:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 84E9F20030;
	Wed,  8 Jul 2020 08:08:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6C51AC0893;
	Wed,  8 Jul 2020 08:08:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BA9DBC016F
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 08:08:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A73F4895C6
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 08:08:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6Tq3oGyeDtJO for <iommu@lists.linux-foundation.org>;
 Wed,  8 Jul 2020 08:08:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C0F7589538
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 08:08:51 +0000 (UTC)
IronPort-SDR: Kq3FBdiD3/Gj9Bl2y4+fX8AS4b5yXIrvb7dxt5ATzLvHTM7sGLo0Kis/uftq/WEX1VXBWIVb4W
 Y253eOA0Z2ow==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="127356914"
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; d="scan'208";a="127356914"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2020 01:08:51 -0700
IronPort-SDR: HqExt5Ydq/O2JVGcZl8NU9tduvZ3s/5NI5qHf6mALfhXEQdxZ4Zdzd0qtnjtPctqlY3tvLCzZX
 N1ZN5G/+xNeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; d="scan'208";a="297647597"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by orsmga002.jf.intel.com with ESMTP; 08 Jul 2020 01:08:50 -0700
Received: from fmsmsx151.amr.corp.intel.com (10.18.125.4) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 8 Jul 2020 01:08:50 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 FMSMSX151.amr.corp.intel.com (10.18.125.4) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 8 Jul 2020 01:08:42 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 8 Jul 2020 01:08:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LzL/GSpR3NS4nC6bU0OYsiHOW4cZem33Y2s98HBshKqK1JK800BozaRlvAvU1Kkx8kXSr8FACsfp8qUmBf0ixyo7446pDe931i87PuDfIhSJB+C9VQY+1hbscslBLWYW1t67shJq1ctsKMrTQpBrE5uaq+2cyk9FHBl4UxYF3n0NXSAdiikxoWSCZNCEv7b8AT7Mo0skhPBAlrNa+BA4UgyvTyhmC94zl/9qczm9RsAALVI5adb/WwRi3ZD3PZUmYNoYl2TGFZCoCXUyi9TpbCaMeBBhCNvc58Q4sWtP39G8M7sgqBniXcF13kGdcyZs0s/Q6vToIIN3VLfp7KLfHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2EwgJFRYruhtOGqjRBGUFgbcUCZvP39L4zSBk5l6co=;
 b=HF3X7SUJxaK3VmExW3cYJ2v8pk/sBqVyZZIlYNmlnZfxSJMlsUIor/4MaWm/jOJpkdnYUscvtBG0Fs1p19/PSN0GK+6/Is+SeOdMNSfhogy/ProX7aIc+Qpg+GlRNdxL2dn3NVQjT+ndhuVTcfFXwL7URon+9upclcbhkHjvS8J7CIeSaF7rrSMIHB3ZU7c5mheSnW4NOApB9QIFBahvNKORlLDe5qu8B0XQ157+NavL492PAM3bhHb0Or7JpLBrQ0SocYRDNQUgyso04TfcYxsvubrx1dRxW19GZVRXevzEu+sVXxhMHJw27057Hg4JmiKDIuZM3uj0UdiVjpQ/fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2EwgJFRYruhtOGqjRBGUFgbcUCZvP39L4zSBk5l6co=;
 b=hXHnik2VNN2zcGj3+/PsFU4UtGcTYnJ+7/zmw520QpYPLKfim7OWhToli65JP25kn3d1qBY0YDD5rMlWteuVBr4iucsMKQ9617sg3ftSJ6YWWMyslnpYyxav7eTtp38J+Yj6VHy0ivkxmo1CJBT1ZJxqUy2CGJ1xwztnFnp9soA=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM6PR11MB4530.namprd11.prod.outlook.com (2603:10b6:5:2a4::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.22; Wed, 8 Jul 2020 08:08:40 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364%10]) with mapi id 15.20.3174.021; Wed, 8 Jul 2020
 08:08:40 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Auger Eric <eric.auger@redhat.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>
Subject: RE: [PATCH v4 04/15] vfio/type1: Report iommu nesting info to
 userspace
Thread-Topic: [PATCH v4 04/15] vfio/type1: Report iommu nesting info to
 userspace
Thread-Index: AQHWUfUbywl8Q+WBl0+9l/PlGyuXiKj6XuYAgAAkWACAABBDgIABSlsAgAF6DCA=
Date: Wed, 8 Jul 2020 08:08:40 +0000
Message-ID: <DM5PR11MB143531E2B54ED82FB0649F8CC3670@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1593861989-35920-1-git-send-email-yi.l.liu@intel.com>
 <1593861989-35920-5-git-send-email-yi.l.liu@intel.com>
 <d434cbcc-d3b1-d11d-0304-df2d2c93efa0@redhat.com>
 <DM5PR11MB1435290B6CD561EC61027892C3690@DM5PR11MB1435.namprd11.prod.outlook.com>
 <94b4e5d3-8d24-9a55-6bee-ed86f3846996@redhat.com>
 <DM5PR11MB14357A5953EB630A58FF568EC3660@DM5PR11MB1435.namprd11.prod.outlook.com>
In-Reply-To: <DM5PR11MB14357A5953EB630A58FF568EC3660@DM5PR11MB1435.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [117.169.230.114]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e54e2b05-dd4f-4980-2b5e-08d823161ffd
x-ms-traffictypediagnostic: DM6PR11MB4530:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB45308D374E10F3131D9271D8C3670@DM6PR11MB4530.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 04583CED1A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jICB7Yt7OF4AoPe8jBNCHe5nWMCRPjg4zDP4LZgSz4IAK5VG0x6DDi6Up5oCCa7xbCZCWo031R8I45jn44zREMQwKCPXv++qeaeOGb2/61yeeXtX2KMpMaKCJx6KRl74+yWhnmGZNzjXym7W0Iw0peiFSnw9TH04HjIFwnrAcTCp3m6DTXQaxda3WlcNPLZQAWyJW8PlT+6iVW4MKiMI0MEsAnxM6w7/Q/XVU4Ru7Vv5Q16QTIxMy0OPLnI5bZb6x53aEK/1RIAcW9Opi9nDjiupPsrrhDTUf9wA9yNXlyym0Rh525UP6vYTZUvRvD/Fi5JoKEojtTkzsYwhrz/TIRTYIZ5nIM9qSJL4guudTVg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(54906003)(5660300002)(33656002)(71200400001)(478600001)(8676002)(966005)(8936002)(316002)(4326008)(110136005)(45080400002)(2906002)(64756008)(66946007)(76116006)(7416002)(52536014)(66556008)(66476007)(9686003)(66446008)(55016002)(26005)(186003)(7696005)(6506007)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: n5gIFVGpJXTrVpW7Z3F6R9qQkS0X69H0WLTATRaF5L6P4sGLQc4VjewVzx3rFF5/1yZX7+rYYRqLg3H2bStMf3L9jR6gysBOT1ZYPxRYCMD8HvkqKyiWkNOr2iNXmt/ESy1NSa9g/X3/AyocQUWYc3yn0NQcnbOgKRJaCFNwxiNK6RS8+/gmO2MboOXAP8ebAiN6fCjRGXu+fUn4Pmnm8dfd27SJdybERO8bW3LW8IWU3JTLvdlq8MIaLCFA/oWtnxgOlYYsVVfa/gGelKEnhWxC54pRwAKD52hkd64X+EVJABfM5BH/hM29RtSrChYiuAOR0284+f7FaNlcNBPQDdyuoJM+0lOxqQW8atQne2ShKfwSKtgKNLf+/MFfpxcK3/7BoaG/pIVupot+BH/DdEBYri0woZTv9Z/Y5fVZq95BqoL4CGlKfRSrUa+uHruiR1MNKaxFGT184tH0pkdME1a7ngMUdLdhwdD2dqjqDjMvsdGzcoJCyAkfTJGZ+YyO
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e54e2b05-dd4f-4980-2b5e-08d823161ffd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2020 08:08:40.4473 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SzRW2T3KIwwXNxKeRj1mgOO3AjLBwAGqM4TNVqY+Pa9atRZMEms8VfEbmar1E3lfO6I/ear1FiuzGneu+GoZGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4530
X-OriginatorOrg: intel.com
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "stefanha@gmail.com" <stefanha@gmail.com>, "Tian, 
 Jun J" <jun.j.tian@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sun,
 Yi Y" <yi.y.sun@intel.com>, "Wu, Hao" <hao.wu@intel.com>
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

Eric asked if we will to have data strcut other than struct iommu_nesting_info
type in the struct vfio_iommu_type1_info_cap_nesting @info[] field. I'm not
quit sure on it. I guess the answer may be not as VFIO's nesting support should
based on IOMMU UAPI. how about your opinion?

+#define VFIO_IOMMU_TYPE1_INFO_CAP_NESTING  3
+
+/*
+ * Reporting nesting info to user space.
+ *
+ * @info:	the nesting info provided by IOMMU driver. Today
+ *		it is expected to be a struct iommu_nesting_info
+ *		data.
+ */
+struct vfio_iommu_type1_info_cap_nesting {
+	struct	vfio_info_cap_header header;
+	__u32	flags;
+	__u32	padding;
+	__u8	info[];
+};

https://lore.kernel.org/linux-iommu/DM5PR11MB1435290B6CD561EC61027892C3690@DM5PR11MB1435.namprd11.prod.outlook.com/

Regards,
Yi Liu

> From: Liu, Yi L
> Sent: Tuesday, July 7, 2020 5:32 PM
> 
[...]
> > >
> > >>> +
> > >>> +/*
> > >>> + * Reporting nesting info to user space.
> > >>> + *
> > >>> + * @info:	the nesting info provided by IOMMU driver. Today
> > >>> + *		it is expected to be a struct iommu_nesting_info
> > >>> + *		data.
> > >> Is it expected to change?
> > >
> > > honestly, I'm not quite sure on it. I did considered to embed struct
> > > iommu_nesting_info here instead of using info[]. but I hesitated as
> > > using info[] may leave more flexibility on this struct. how about
> > > your opinion? perhaps it's fine to embed the struct
> > > iommu_nesting_info here as long as VFIO is setup nesting based on
> > > IOMMU UAPI.
> > >
> > >>> + */
> > >>> +struct vfio_iommu_type1_info_cap_nesting {
> > >>> +	struct	vfio_info_cap_header header;
> > >>> +	__u32	flags;
> > >> You may document flags.
> > >
> > > sure. it's reserved for future.
> > >
> > > Regards,
> > > Yi Liu
> > >
> > >>> +	__u32	padding;
> > >>> +	__u8	info[];
> > >>> +};
> > >>> +
> > >>>  #define VFIO_IOMMU_GET_INFO _IO(VFIO_TYPE, VFIO_BASE + 12)
> > >>>
> > >>>  /**
> > >>>
> > >> Thanks
> > >>
> > >> Eric
> > >

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
