Return-Path: <SRS0=r5As=AO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972DEC433E0
	for <iommu@archiver.kernel.org>; Fri,  3 Jul 2020 13:03:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FDC8206B7
	for <iommu@archiver.kernel.org>; Fri,  3 Jul 2020 13:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="dSQbI/Ys"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FDC8206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1FB9987A49;
	Fri,  3 Jul 2020 13:03:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Bk3eJrDKMPEB; Fri,  3 Jul 2020 13:03:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4612887A16;
	Fri,  3 Jul 2020 13:03:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2A145C0888;
	Fri,  3 Jul 2020 13:03:24 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E0ABC0733
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jul 2020 13:03:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 0574420555
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jul 2020 13:03:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C4mhCL3XnJ6g for <iommu@lists.linux-foundation.org>;
 Fri,  3 Jul 2020 13:03:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by silver.osuosl.org (Postfix) with ESMTPS id 13CA6204CE
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jul 2020 13:03:20 +0000 (UTC)
IronPort-SDR: HVPY1vFBAH5JnUBLNIIGrsMGtSvo5RJpZknEMVU8dOM2NMHCePTvj5j7ArohSTR0ScOah2VOe8
 87lXGlBXh+5g==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="135418467"
X-IronPort-AV: E=Sophos;i="5.75,308,1589266800"; d="scan'208";a="135418467"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2020 06:03:19 -0700
IronPort-SDR: Hkut/2puouWGmaAZeY+VYf+5C4xCrnI4e02oVjDsbdNGFqjY56gBbTZgkWGPleEVBQIFHmk2SZ
 lNF4m4M38v7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,308,1589266800"; d="scan'208";a="356768316"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
 by orsmga001.jf.intel.com with ESMTP; 03 Jul 2020 06:03:19 -0700
Received: from orsmsx158.amr.corp.intel.com (10.22.240.20) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 3 Jul 2020 06:03:19 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX158.amr.corp.intel.com (10.22.240.20) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 3 Jul 2020 06:03:19 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 3 Jul 2020 06:03:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dcL+vt2/mPmhNtfN5MW6zEw4/GztupIKlPCkBvS4hns8HVVO554iCe8xMOFyi+dEvxdUNmnu2wx1CUJbvjIYJPZCYbqLvajY/UuviTYTqGXlp/2uda1EVjcrpnPAI5+ff5zm/y6BffNTI+PjflehoXAI5lFPmmXTsolPFoRZE7jXsZ3cDVW5+NSynUfeOxUuqyX7KP/dPP5Dqkv74PA0wqXKSPFvZ0+vGwM61yKMeJCZX4MiLPaGskwMGlJlq2vLBFiLLbPOeFVLA7+p0AphWQ96hkMUhRuCjtrnp7qeMlHtqCZFvIINuUS7MQ/MfzCI1EhApus95oeEMHqg+NWcGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKhlnKumyE+XdOuasc0QNVgkoxoqjbS6zSN0GcsOVvI=;
 b=jlAqtpETkrX8csMiKvwQQeyeNr69o6EVz+igzPRki+ugnDOW9kTozL2bdWVZIDcu+9AJSMMJbJoy1ozK/JNOwBTD2O8+z/16PunIL4pNd/Juw5qFgZMwGDQxM/s+X7f7dJXGyPx6KrBW+She5rOpr/24WxZK/stQ26/maJVh8kfk4jfH5TxRs+VFhgE0ufOvkz1AQEKeKDWWKc5jZxNfgrLL+yoBASmh+AJItjKbWE6xNuMHxbc+xOAPuq/VJuwhaPHsHNW+qiNQ4S/M6QtrKnaNwafNcKn49GcF8P6RoWRhxLwPmmPEhCWuTd+suAZhN0SlLjK2uw31HfLOOwnbGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKhlnKumyE+XdOuasc0QNVgkoxoqjbS6zSN0GcsOVvI=;
 b=dSQbI/YsPMU4zJwKbj0VvSWHGw7V6HgLiG8r5QaUta6ohNhBJ2pbxX2o2gFV6NNvMkX9P+omI1ToMYCdoHER4xsOPAypb5pzQkNOBd2THewhsZUnc/jJzwiNFlTxyYcdrc9p2pXD4A72TmT58Znh98kxMeTkzIMTzQgNEfTDcHQ=
Received: from CY4PR11MB1432.namprd11.prod.outlook.com (2603:10b6:910:5::22)
 by CY4PR11MB1783.namprd11.prod.outlook.com (2603:10b6:903:11d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Fri, 3 Jul
 2020 13:03:17 +0000
Received: from CY4PR11MB1432.namprd11.prod.outlook.com
 ([fe80::b46e:9dcb:b46b:884a]) by CY4PR11MB1432.namprd11.prod.outlook.com
 ([fe80::b46e:9dcb:b46b:884a%4]) with mapi id 15.20.3153.027; Fri, 3 Jul 2020
 13:03:17 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: RE: [PATCH v3 03/14] vfio/type1: Report iommu nesting info to
 userspace
Thread-Topic: [PATCH v3 03/14] vfio/type1: Report iommu nesting info to
 userspace
Thread-Index: AQHWSgRR9wDstDmC00qnq2+G1pK7Waj0rAKAgACc8/CAAJYLUA==
Date: Fri, 3 Jul 2020 13:03:17 +0000
Message-ID: <CY4PR11MB1432BFE42BF336EE8C99CEC9C36A0@CY4PR11MB1432.namprd11.prod.outlook.com>
References: <1592988927-48009-1-git-send-email-yi.l.liu@intel.com>
 <1592988927-48009-4-git-send-email-yi.l.liu@intel.com>
 <20200702123847.384e7460@x1.home>
 <CY4PR11MB14320E069DF2C75131A94DB3C36A0@CY4PR11MB1432.namprd11.prod.outlook.com>
In-Reply-To: <CY4PR11MB14320E069DF2C75131A94DB3C36A0@CY4PR11MB1432.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5358174e-9f99-42ab-9070-08d81f5173ff
x-ms-traffictypediagnostic: CY4PR11MB1783:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB178333A2FB19723F43572D86C36A0@CY4PR11MB1783.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 045315E1EE
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VkGHvO6BW1CrC9Tg4LHFPZxmQm7QJWuyhHENVVpy1kB06MSEog+XsAYvGUgdUgJ+LKupucbHNgiYazssp1EO2yVBBnripub8ooE2Gg60Xj43Csb4iH4CvcG+LT2w71iTOVxPnVwa+yk/fNFJ6atmM493y/07JL0uCub8FRaMA2ubZnxSu5KtLJEHWO3E8cxGN/PMDt0enSYEP4xMlYlCbePZuLWychZH23LP+GrBjeGOxcLphB+dVrguvcbbkHV/UDdBYgmO8o4TeQEZcjz0UNgAAVrjpxn0TMO7wq/LXMYZfc28GcDuwjPBDjjPGJHqapOSvW6g8+ncYxxSQcelbA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR11MB1432.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(26005)(6506007)(66946007)(52536014)(5660300002)(71200400001)(66446008)(66556008)(66476007)(64756008)(7696005)(478600001)(6916009)(86362001)(4326008)(186003)(76116006)(54906003)(33656002)(9686003)(7416002)(2940100002)(2906002)(8936002)(8676002)(55016002)(316002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: yaxWodvcaZ0lXIoAUlhQbJBNaUr7T+q/lYjZ/pGUy4sBg7fQM4smAForQR3H+zLa3QudelbMkDTq5ZKFjRV/CixeiaO8Ub58EFLWSUeDXDrEf1dKPvDBCHdSmYNNngeITuOp9SyI73p3d/TBZSrXpUJbsJ0pmpJyATsLQxIQocmkyWcvd2yoyVmR2KahzTweewaQp6sckDIOR1lmYJisaZz4RP0h+CwIR8oBRkPhfywpjA/7WvOP934xUbiRRoP3n80nLIGipY/J5hm1Lb3h25yNy57ZyDo1Lk7OCwfQkIfhNgFLiJm5TjhOwo4nUFdel5/uoTGn7Cadr+Np4WbP84m6P/W4MdK5Trec6dmurEOv5y+jGb6f2WgCCYZn+MRTp+rtC4yzAJR7F0oceLe/AM35+VE9NQv8rCAuah0kcH9Pan79oAe14J61+E/VVW0mASt67gqXEOTRFAb5tVlyi4us2erzZvWXhGw5GxulEbvQ7izDqtRPsmePFtwx6tA7
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1432.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5358174e-9f99-42ab-9070-08d81f5173ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2020 13:03:17.0736 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RN1XwZlXINNoJt6T04Juvq4U11YfTXFGBH6A7QEQWvfovkqjFGNJdYVo1oGnTFZVpHHfbj1JrkhDn9xdqRxXCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1783
X-OriginatorOrg: intel.com
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
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

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Friday, July 3, 2020 2:06 PM
[...]
> > > +#define VFIO_IOMMU_TYPE1_INFO_CAP_NESTING  3
> > > +
> > > +struct vfio_iommu_type1_info_cap_nesting {
> > > +	struct	vfio_info_cap_header header;
> > > +	__u32	flags;
> >
> > I think there's an alignment issue here for a uapi.  The header field
> > is 8-bytes total and info[] should start at an 8-byte alignment to
> > allow data[] within info to have 8-byte alignment.  This could lead to
> > the structure having a compiler dependent size and offsets.  We should
> > add a 4-byte reserved field here to resolve.
> 
> got it. or how about defining the flags as __u64?
> 
> >
> > > +	__u8	info[];
> > > +};
> >
> > This should have a lot more description around it, a user could not
> > infer that info[] is including a struct iommu_nesting_info from the
> > information provided here.
> > Thanks,
> 
> sure. BTW. do you think it is necessary to add a flag to indicate the info[] is a
> struct iommu_nesting_info? or as a start, it's not necessary to do it.

seems like I misunderstood your comment. Does below description suits
your comment?

/*
 * Reporting nesting info to user space.
 *
 * @info:       the nesting info provided by IOMMU driver. Today
 *              it is expected to be a struct iommu_nesting_info
 *              data.
 */
struct vfio_iommu_type1_info_cap_nesting {
        struct  vfio_info_cap_header header;
        __u32   flags;
        __u32   padding;
        __u8    info[];
};

Thanks,
Yi Liu

> Regards,
> Yi Liu
> 
> > Alex
> >
> > > +
> > >  #define VFIO_IOMMU_GET_INFO _IO(VFIO_TYPE, VFIO_BASE + 12)
> > >
> > >  /**

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
