Return-Path: <SRS0=qe9F=AK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A38C433E0
	for <iommu@archiver.kernel.org>; Mon, 29 Jun 2020 09:24:58 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA708233F6
	for <iommu@archiver.kernel.org>; Mon, 29 Jun 2020 09:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="rESw7DDb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA708233F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 940C4875BD;
	Mon, 29 Jun 2020 09:24:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8xLx1O-0y5cE; Mon, 29 Jun 2020 09:24:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1941B87589;
	Mon, 29 Jun 2020 09:24:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 058C3C07FF;
	Mon, 29 Jun 2020 09:24:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20B21C016E
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 09:24:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0B747886E8
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 09:24:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QBulfqfNNjQU for <iommu@lists.linux-foundation.org>;
 Mon, 29 Jun 2020 09:24:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A1FA1887D6
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 09:24:54 +0000 (UTC)
IronPort-SDR: 9nGs8i7je4XU5Sf14JGIhub7MRNpuWUJ9B1ZEgD8WY31ZT7S5JbcHRJiUb9e2ylkNqq6hfT6+h
 E6BMUSIHpF+g==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="144996492"
X-IronPort-AV: E=Sophos;i="5.75,294,1589266800"; d="scan'208";a="144996492"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2020 02:24:52 -0700
IronPort-SDR: tI5Ohju9i3K+OadxL2HBTr9fOzcCn+beT76uV7xRaQYyW9I/YuorN5TKT8sBqVJzVUD+8/TSqU
 KHRjoSN9A8Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,294,1589266800"; d="scan'208";a="266156684"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
 by fmsmga008.fm.intel.com with ESMTP; 29 Jun 2020 02:24:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 29 Jun 2020 02:24:53 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 29 Jun 2020 02:24:52 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 29 Jun 2020 02:24:52 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 29 Jun 2020 02:24:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CzOkKJDar7ZVVw4EZ4o11kfys8JauxTJrk1vHIfASW0gAzrxmbl6khyzhdin+iqw509eK3ZeP9twrmfn1KdRMMUi82EpdscYFd2iNUu85ePzmHTypUt/mM+wA8wbUoOr2Fm7LmmTmZW52QDsBKk2lTRGFJoSqLBnpj2/1b6rIdjXLC6dfywV8qgw1KLrrB+gPtlf3FG0O6Jo+TKaIN+2WvPBGI794f0oinQiQca/ZkVYDR4MQ+eKijnyJXtwtOJGecCili0hnQvdLCqkyqJ5do9/X1FWO0MgvlGeoABQG9+An0zH04PooH/baG6bXXvSgsWQ9pGzkUaFpga4LVEaHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRk8u28uye2ch7b4Wxc0y7sbq3f/DByKJkO9iEZUIDk=;
 b=A5B+LeROEw4ByHjoNPKS7TKtA63cJruW5DokNIc/PyxK3cCuFpYIJIeG8SrUyu/RA57YJXhVRaWzH6FLPYJxJyQZsHjBB8BOWlhR6HFBwwtsNASvV2nxZmQyQfIGmF+Ngi4MhRtLdOP9qIAFKVDLNpc/GrYqo7wAEOrXahN3YR8YMc58R77knZWrVjZGG3bxbMKkkP1sSRqOkaMJeYQsgk28ODH0E9sMBc+pZs7SD7x7fwXyaIl16ySMzP95LqVUcZMNdolBLzvvagNmdpLVQgA4MjoHwEANXSsGsboASVryuYo6mkfM0s6yXPDuHQy8owyGrrwJPR5c2tSjVuXErA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRk8u28uye2ch7b4Wxc0y7sbq3f/DByKJkO9iEZUIDk=;
 b=rESw7DDbmfDGzqHa0JuKbp8EcJD4Tb0WkR7NmDJRzoVSQRfY0ZRxGKF75mHJHVDr8G6tQY+6Z5ESelx46EI7z2dtnrCg6unp0X8iLpVFSQ0BPiIYDFHCt1AAk/zf+Lc/CaJZqX+2VAIsSSWphlngsURB4VZ76oF6en/O+R7LUoM=
Received: from CY4PR11MB1432.namprd11.prod.outlook.com (2603:10b6:910:5::22)
 by CY4PR11MB1574.namprd11.prod.outlook.com (2603:10b6:910:f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.25; Mon, 29 Jun
 2020 09:24:51 +0000
Received: from CY4PR11MB1432.namprd11.prod.outlook.com
 ([fe80::b46e:9dcb:b46b:884a]) by CY4PR11MB1432.namprd11.prod.outlook.com
 ([fe80::b46e:9dcb:b46b:884a%4]) with mapi id 15.20.3131.026; Mon, 29 Jun 2020
 09:24:51 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: RE: [PATCH v3 13/14] vfio: Document dual stage control
Thread-Topic: [PATCH v3 13/14] vfio: Document dual stage control
Thread-Index: AQHWSgRSM+uqgdGjpEOT7nvP3+zeDKjvWVIAgAAAwoA=
Date: Mon, 29 Jun 2020 09:24:50 +0000
Message-ID: <CY4PR11MB14322E99A64BC0B2E06CD33CC36E0@CY4PR11MB1432.namprd11.prod.outlook.com>
References: <1592988927-48009-1-git-send-email-yi.l.liu@intel.com>
 <1592988927-48009-14-git-send-email-yi.l.liu@intel.com>
 <20200629092132.GA31392@stefanha-x1.localdomain>
In-Reply-To: <20200629092132.GA31392@stefanha-x1.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cea3d932-ea3b-480e-c016-08d81c0e4677
x-ms-traffictypediagnostic: CY4PR11MB1574:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB157442D535B74B1AAC0C281FC36E0@CY4PR11MB1574.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 044968D9E1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AmcsE1Cv0tmD0bWGatIpr6AXEY+73/1COSqlXY8LFVZdV9vioG4VjIzR+GZWMZQN9dp7Xavf2jqzB3uzH3l4CrdNMSFUi9G4bU9gw7P76S3751vX5+OlVh6FrKHCenfGUbT7U/SWd4MOciFIeRVTjz1J99P3981RW5tkb+cc9Btm5YWsMiHXL4cTxs/8QLDcvgJjsi50nc2ynCM4kU6/2LXcgrxVJkESAtjJw9kpH6uy3YQ7Xy5RQMmDtmy7ZjWnItIT83ZTnABbVDFAcPm5P43ZHkBlXED4rwuKbZtw36VXfCPSugVhcUweYfUAEAwl
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR11MB1432.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(6506007)(9686003)(7416002)(33656002)(55016002)(2906002)(6916009)(66446008)(64756008)(66476007)(66946007)(66556008)(76116006)(4326008)(54906003)(8936002)(26005)(71200400001)(8676002)(86362001)(5660300002)(52536014)(186003)(478600001)(7696005)(316002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: ot80ypviLdqi2cWASLCsQLRJOskY5BSGNYBIRehnxaz+VA90nybLJQMHEDTlbmVH622PIJ6mnO7byc0+AkhZzShX6q60jyb8beZjuOvYxSKtzl974TPblF8yi/OY6XF3hhQeLWr+oECK6yY4luNVwApm7LMh3IXr5GUXIcl7K94ZsTg4xhvFimehTvMVKwz69dwE38E7XpaY5dc6UbWUBdG6rifhu2PKxIqDd0XtliJ3HNetY+//kuxAmcoBVUehZgDNkhh/IsspT9PloJUxIJw9Lr3OZc19InhlzrYCkQViKOzhE38CId4xDGy+C8dp5LzdzbWOKnxAux4VrJJ7yscLey0a1byYSHpI3R4Ln3P5t575VGWosSdYwzckjod0lLWkWE40QkXO9ul5opPHbu2+hcPQL+9MnuG9aKq0z3+3OL7GBM9/SnQqkRr0/MpktvggWPZ0js7g0Pmg4lqi8CQloN7xTH92OwHajKyYWpbXm2nD/XpsfvfDJ7gldLlA
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1432.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cea3d932-ea3b-480e-c016-08d81c0e4677
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2020 09:24:50.8738 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kaMH13DW3Uvu2QUbZdgwyXwcjj5R7CJMtVaDu10oI76uIjyyWqK5YOfhR10xp9HjjZNjFKjfFfiTdiVCYjSANw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1574
X-OriginatorOrg: intel.com
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Sun, Yi Y" <yi.y.sun@intel.com>,
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

> From: Stefan Hajnoczi <stefanha@gmail.com>
> Sent: Monday, June 29, 2020 5:22 PM
> 
> On Wed, Jun 24, 2020 at 01:55:26AM -0700, Liu Yi L wrote:
> > +Details can be found in Documentation/userspace-api/iommu.rst. For
> > +Intel VT-d, each stage 1 page table is bound to host by:
> > +
> > +    nesting_op->flags = VFIO_IOMMU_NESTING_OP_BIND_PGTBL;
> > +    memcpy(&nesting_op->data, &bind_data, sizeof(bind_data));
> > +    ioctl(container->fd, VFIO_IOMMU_NESTING_OP, nesting_op);
> > +
> > +As mentioned above, guest OS may use stage 1 for GIOVA->GPA or GVA->GPA.
> > +GVA->GPA page tables are available when PASID (Process Address Space
> > +GVA->ID)
> > +is exposed to guest. e.g. guest with PASID-capable devices assigned.
> > +For such page table binding, the bind_data should include PASID info,
> > +which is allocated by guest itself or by host. This depends on
> > +hardware vendor e.g. Intel VT-d requires to allocate PASID from host.
> > +This requirement is defined by the Virtual Command Support in VT-d
> > +3.0 spec, guest software running on VT-d should allocate PASID from
> > +host kernel. To allocate PASID from host, user space should +check
> > +the IOMMU_NESTING_FEAT_SYSWIDE_PASID
> 
> s/+check/check/g

got it.

> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

thanks :-)

Regards,
Yi Liu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
