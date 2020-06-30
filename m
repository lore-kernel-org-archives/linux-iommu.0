Return-Path: <SRS0=0Jez=AL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C47C433DF
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 03:45:15 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99E00206CB
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 03:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="s4tFRNcw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E00206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 715D486890;
	Tue, 30 Jun 2020 03:45:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NfVllUASvaOg; Tue, 30 Jun 2020 03:45:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B81098687B;
	Tue, 30 Jun 2020 03:45:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A084CC07FF;
	Tue, 30 Jun 2020 03:45:14 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC6B0C016E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 03:45:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E39D42001D
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 03:45:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c4NWkYCGVH06 for <iommu@lists.linux-foundation.org>;
 Tue, 30 Jun 2020 03:45:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by silver.osuosl.org (Postfix) with ESMTPS id D59341FEF0
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 03:45:12 +0000 (UTC)
IronPort-SDR: 1UO75xJlKDKHY00EO10sl+Cg021yMhHLC48Fr2LfHXCD6kN8j6rMlkVb26Zhjc//sG3T9SdLeM
 borTG0J1yrlg==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="145209414"
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; d="scan'208";a="145209414"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2020 20:45:11 -0700
IronPort-SDR: SDPcqvEJjGT8KJ27k18hc1otKI8qTkldfWQj+9pyuq9segpUdfUL45MfeL0ePAuc1QZ1yLWOUH
 YbRwtN4fm1QQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; d="scan'208";a="265006040"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by fmsmga007.fm.intel.com with ESMTP; 29 Jun 2020 20:45:12 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 29 Jun 2020 20:45:11 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 29 Jun 2020 20:45:11 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 29 Jun 2020 20:45:11 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 29 Jun 2020 20:45:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8EKsq9rmdW8Wh5srxi+I9Kv9xfoayQi3X1iot95KYq+aaVvag0YSRezYfiEbXL4fIfCYpdxV9UydGC92wLWHgZoIRl3jbCUsn1B3L1opx0bUezsJZQHby+nHf36SKJyFf4eoyN8OHu/GWWaT4W0l7h79/lyQ9OD740WAhfDs4GpSqBcm4dR/29ejAplf74F5280xbJZE7TGzbvueUJixaz/ReI7YLv1z8VbfOgtEezVZ6Pj+ShdloplysBCh0/P3G/e7P7YeXYx6PCmcbFNFkpWjo8sDkNnDuAvApu+LbAvGdrU9SZ9BekH3LujbLHCczE7BQKcLTe+PwF8cxBYcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xo8LFCLPtF8KBAVRZx44CTeM7yA2A81HGCrnVpdM1oE=;
 b=cIG8YDKDgusyEVBhiKCQfEWDNV3pxPKcHcd+OhJeSAzGNpTAWtbgD98hEdIs5OmJJ74znspYozJNyQ6HYs9Tka421ltYY6QBw8r6SwxihAXERYJRLbIgFyx6aJRs+wwgWvBcGCZghUkg42pfy+yTt/jkfAxC07gzXp0E4WJMGtwuvQ98T01rBQQ0A3AReKf6x4LrsTMyR9NettwWU6x898RP6NjqoUSrLFyMcZA8Bh7NRFlT036OK0ZeTFGxtaMxkspjBrRT2iKidQpvdcGGf2aNaScIHOi58HtHXZgchpYgiqLwF+yQ9ixhLCpI8ksOXCEjzNw7tHW5GQRymYd0SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xo8LFCLPtF8KBAVRZx44CTeM7yA2A81HGCrnVpdM1oE=;
 b=s4tFRNcwWmsMyNkWR8RHXr2UIpaQka5LzHUaYiGOeKaTPyIUTVM4LjyyBShkZWFWR1P19pNY2ht7AERQU+TRi9RX8aUsZvWfDpnbMPGZ7WavTSt2PlwHj4vlHDWk9Lrj4dyd/Ww0Wr7Rz+cL+PfNTEkYlLZaNptv4ZpB4Q5UlPw=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM6PR11MB4724.namprd11.prod.outlook.com (2603:10b6:5:2ad::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.23; Tue, 30 Jun 2020 03:45:09 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::2c3d:98d9:4e81:c86c]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::2c3d:98d9:4e81:c86c%6]) with mapi id 15.20.3131.027; Tue, 30 Jun 2020
 03:45:09 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>, Stefan Hajnoczi <stefanha@gmail.com>
Subject: RE: [PATCH v3 02/14] iommu: Report domain nesting info
Thread-Topic: [PATCH v3 02/14] iommu: Report domain nesting info
Thread-Index: AQHWSgRQVmc9Qp+Xi0mQEumzIJrE0qjvWjsAgAAviUCAAObAgIAAF5Ww
Date: Tue, 30 Jun 2020 03:45:09 +0000
Message-ID: <DM5PR11MB143588FBD3E160B974D7E8BDC36F0@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1592988927-48009-1-git-send-email-yi.l.liu@intel.com>
 <1592988927-48009-3-git-send-email-yi.l.liu@intel.com>
 <20200629092448.GB31392@stefanha-x1.localdomain>
 <DM5PR11MB1435FC14F2E8AC075DE41205C36E0@DM5PR11MB1435.namprd11.prod.outlook.com>
 <MWHPR11MB1645B09EBDC76514ADC897A68C6F0@MWHPR11MB1645.namprd11.prod.outlook.com>
In-Reply-To: <MWHPR11MB1645B09EBDC76514ADC897A68C6F0@MWHPR11MB1645.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.102.204.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 76f2a4b1-0a33-4558-bdef-08d81ca7fc64
x-ms-traffictypediagnostic: DM6PR11MB4724:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB472462687AF54C1FFEAFC95AC36F0@DM6PR11MB4724.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0450A714CB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bMvEyngG+3yII4GcvSmqyWgdhrc8K1wJCw3ddl/KIYVZMv8ruEeR9VpJUKfiBY97Yj7PMHf4PP76NPWgQc4nbEru5r1HBQdQURs0uupDbRcsr3s7T+QWSXjM66vZkfqJFPo2J69oFlJEAf+k4INp6NgaxsmgV9DZVu9XUwBt0WPgqSGAg9WURsxGgdCPRY7XpX4xNSpcqVB64KUiBeTUN7RKs4zYqeuRuEdF9UZrEup6indqf1pnUvOS0sOKr+czAnuyJdh5FdjwXvp2kIdTqRDafQ0uJP00d23yEc6hpYLcytkCy/a9EH8faufNX8B1zqjvQNKn3YYbMqxlhrtsdw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(376002)(346002)(366004)(39860400002)(66556008)(64756008)(66446008)(66476007)(83380400001)(76116006)(66946007)(86362001)(5660300002)(55016002)(4326008)(9686003)(33656002)(52536014)(316002)(110136005)(54906003)(8676002)(186003)(6506007)(26005)(2906002)(7696005)(8936002)(71200400001)(478600001)(7416002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: hosVh63789Bizc4borH0rYuvrtES/Q3vtv3BR5kkWa/zRJR1cAYaZVo3eRvSK0BH9jDDlegy0OCfQg3esuqzoitONgMhnXABkspCppVQMCajmfDmMrxnjH0Hpa2+Ke8FdIEylBFmUby8TF6cUBlUC/ketmT5hlUxd7AqmikFQq74/sLEmNoepZjouTZaLqNlSqrAMWGqBW2NN36Rf5GJj8G6h2C/hvXDc7JYvIMx0bSv0yuUGcx8mhihuEV2uW+QYUWIUp5bbdhOXVRIdM9K90dhaG5RbyVrw2U+6lCuKY50uStXNSRSFX1hHQ2AnFtpd7QVKhsaZquDJfFMI62LBp8B8KKc+pdDsysSr0xN52K01Sb/r/q3Y7OIudYB2u0OFHEBjv9lCWaWPuIUqGSZZiPnydkwWgWmgA8d9ZRu7E4ypsTcZz6l2HZyF/O57fdwa9rEMrhoeFqRfYZaLY1Y9+IvLIxc2KNNcR8KaAbElR8sFaxh/Iiy+KsvtitxQG+P
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76f2a4b1-0a33-4558-bdef-08d81ca7fc64
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2020 03:45:09.0582 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y6YHQqzUdE6TKQ0v9xi5nP0igDAxNgOj3DMsMhg07a9zolLTZmlr8DMXISOPx91+wOtVl1KmEmujUu86FmiGFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4724
X-OriginatorOrg: intel.com
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Sun, Yi Y" <yi.y.sun@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Wu,
 Hao" <hao.wu@intel.com>, "Tian, Jun J" <jun.j.tian@intel.com>
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

> From: Tian, Kevin <kevin.tian@intel.com>
> Sent: Tuesday, June 30, 2020 10:01 AM
>
> > From: Liu, Yi L <yi.l.liu@intel.com>
> > Sent: Monday, June 29, 2020 8:23 PM
> >
> > Hi Stefan,
> >
> > > From: Stefan Hajnoczi <stefanha@gmail.com>
> > > Sent: Monday, June 29, 2020 5:25 PM
> > >
> > > On Wed, Jun 24, 2020 at 01:55:15AM -0700, Liu Yi L wrote:
> > > > +/*
> > > > + * struct iommu_nesting_info - Information for nesting-capable IOMMU.
> > > > + *				user space should check it before using
> > > > + *				nesting capability.
> > > > + *
> > > > + * @size:	size of the whole structure
> > > > + * @format:	PASID table entry format, the same definition with
> > > > + *		@format of struct iommu_gpasid_bind_data.
> > > > + * @features:	supported nesting features.
> > > > + * @flags:	currently reserved for future extension.
> > > > + * @data:	vendor specific cap info.
> > > > + *
> > > > + * +---------------+----------------------------------------------------+
> > > > + * | feature       |  Notes                                             |
> > > > + *
> > >
> > +===============+===============================================
> > ====
> > > =+
> > > > + * | SYSWIDE_PASID |  Kernel manages PASID in system wide, PASIDs
> > used  |
> > > > + * |               |  in the system should be allocated by host kernel  |
> > > > + * +---------------+----------------------------------------------------+
> > > > + * | BIND_PGTBL    |  bind page tables to host PASID, the PASID could   |
> > > > + * |               |  either be a host PASID passed in bind request or  |
> > > > + * |               |  default PASIDs (e.g. default PASID of aux-domain) |
> > > > + * +---------------+----------------------------------------------------+
> > > > + * | CACHE_INVLD   |  mandatory feature for nesting capable IOMMU
> > |
> > > > + * +---------------+----------------------------------------------------+
> > >
> > > This feature description is vague about what CACHE_INVLD does and how
> > to
> > > use it. If I understand correctly, the presence of this feature means
> > > that VFIO_IOMMU_NESTING_OP_CACHE_INVLD must be used?
> > >
> > > The same kind of clarification could be done for SYSWIDE_PASID and
> > > BIND_PGTBL too.
> >
> > For SYSWIDE_PASID and BIND_PGTBL, yes, presence of the feature bit
> > means must use. So the two are requirements to user space if it wants
> > to setup nesting. While for CACHE_INVLD, it's kind of availability
> > here. How about removing CACHE_INVLD as presence of BIND_PGTBL should
> > indicates support of CACHE_INVLD?
> >
> 
> So far this assumption is correct but it may not be true when thinking forward.
> For example, a vendor might find a way to allow the owner of 1st-level page
> table to directly invalidate cache w/o going through host IOMMU driver. From
> this angle I feel explicitly reporting this capability is more robust.

I see. explicitly require 1st-level page table owner to do cache invalidation after
modifying page table is fair to me.

> Regarding to the description, what about below?
> 
> --
> SYSWIDE_PASID: PASIDs are managed in system-wide, instead of per device.
> When a device is assigned to userspace or VM, proper uAPI (provided by
> userspace driver framework, e.g. VFIO) must be used to allocate/free PASIDs
> for the assigned device.
> 
> BIND_PGTBL: The owner of the first-level/stage-1 page table must explicitly
> bind the page table to associated PASID (either the one specified in bind
> request or the default PASID of the iommu domain), through VFIO_IOMMU
> _NESTING_OP
> 
> CACHE_INVLD: The owner of the first-level/stage-1 page table must
> explicitly invalidate the IOMMU cache through VFIO_IOMMU_NESTING_OP,
> according to vendor-specific requirement when changing the page table.
> --

thanks for the statements, will apply.

Regards,
Yi Liu

> Thanks
> Kevin
> 
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
