Return-Path: <SRS0=rAFC=PC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14C6C433EF
	for <iommu@archiver.kernel.org>; Thu, 14 Oct 2021 09:12:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E8DA608FE
	for <iommu@archiver.kernel.org>; Thu, 14 Oct 2021 09:12:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5E8DA608FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 18A4E401C0;
	Thu, 14 Oct 2021 09:12:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CFaY-1lwNzas; Thu, 14 Oct 2021 09:12:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 54498401BD;
	Thu, 14 Oct 2021 09:12:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 24F28C000F;
	Thu, 14 Oct 2021 09:12:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D7D97C000D
 for <iommu@lists.linux-foundation.org>; Thu, 14 Oct 2021 09:12:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B364483750
 for <iommu@lists.linux-foundation.org>; Thu, 14 Oct 2021 09:12:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4QMHtY1dtTCl for <iommu@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 09:12:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E1DA98372B
 for <iommu@lists.linux-foundation.org>; Thu, 14 Oct 2021 09:12:05 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10136"; a="225093397"
X-IronPort-AV: E=Sophos;i="5.85,372,1624345200"; d="scan'208";a="225093397"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2021 02:12:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,372,1624345200"; d="scan'208";a="487261679"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmsmga007.fm.intel.com with ESMTP; 14 Oct 2021 02:12:04 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 14 Oct 2021 02:12:04 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Thu, 14 Oct 2021 02:12:03 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Thu, 14 Oct 2021 02:12:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dUYfw38Dju3bnBnshp3D/+rC0zAketCGplTMRcHixaKVKNWYSPm5/zwfSDza8+Cuqq3be1yh3X1JBRsEc4zE72kUmj1xHXZTB7dW4Nysy6RSi4HFbuwPpuNpGsXCCwUIhAlxlJthI9MVO7zkTKteHHlDISGqVCAZDTQQjoLGjs3/Ob+LcjhYU4el5m0pBwdHA9g7OlrVKNf5XXmEbq1S/9ddGiK8KK7kMM8I0hg+9O3oz9ns386g7jspZbrNZ4v9ycbJIuPQrVZU2z9KOzWu1xXE8tzwG3MD7xPHnm74fFmkK2nVhrVrri4HP0GsNWhJ2iBk9BYyTIGe+JLGck+I3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7D8hEONag4p/GSTF8IRi6eV8gUqtCJzFtMjmyi3AsWI=;
 b=i5SY7se6AHQMBYnKLLw+DP9aZ48Yxi1QE43hGESMFXv4Ke8qp/52Wuy1PoNGnwiQJ6vsd6t1XWY1taT29R/V5phF4lQUYYiqVee5W5NjPjxfgOVMpDbHJLkanmk+YVT4wgZ2dovoZJckk4yphnI1DT17P5yxo6Q0u47FkbvJYAnkePOWcXSX+aE7pzOVL0u2OQywIra3vpnamLNWbvMC18M4iUJT4wZ8Fkusu3IZKl1awqgMVMMMSTX+4ftn5s7WPw3bfA7W3apn37rY6BezWE68qoBUkd60YuF68PUoIo4etNlkTTYQ+B3AsUwvE/OEKwQOg/CR7ubhGtQbzoZ6uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7D8hEONag4p/GSTF8IRi6eV8gUqtCJzFtMjmyi3AsWI=;
 b=tKekq5/nexHue9wPz/X+gBH0Zc/sqyJq70Cx0iAAm0niGwmdpf9E1Mer0SzfN/8qlGr01mXJ2aw9pqRSmm4OrIHbcts7o/sOVaN352lz9AqjbhtdX0CD+56AEajNy0eIziNG/PLoVA7+bWpTMIUpg58+aYB7RZf5SUap8WJtEOA=
Received: from BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13)
 by BN6PR11MB4098.namprd11.prod.outlook.com (2603:10b6:405:7f::36)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Thu, 14 Oct
 2021 09:11:58 +0000
Received: from BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df]) by BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df%8]) with mapi id 15.20.4608.016; Thu, 14 Oct 2021
 09:11:58 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [RFC 10/20] iommu/iommufd: Add IOMMU_DEVICE_GET_INFO
Thread-Topic: [RFC 10/20] iommu/iommufd: Add IOMMU_DEVICE_GET_INFO
Thread-Index: AQHXrSGNbNtRgavabUSKJjvt8l12BauwlhaAgAAouwCAACufAIAAEL4QgACKr4CACtdfoIAA3DaAgBUX8GA=
Date: Thu, 14 Oct 2021 09:11:58 +0000
Message-ID: <BN9PR11MB5433530032DC8400B71FCB788CB89@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-11-yi.l.liu@intel.com>
 <20210922152407.1bfa6ff7.alex.williamson@redhat.com>
 <20210922234954.GB964074@nvidia.com>
 <BN9PR11MB5433409DF766AAEF1BB2CF258CA39@BN9PR11MB5433.namprd11.prod.outlook.com>
 <BN9PR11MB54333BDB1E58387FD9999DF18CA39@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210923114219.GG964074@nvidia.com>
 <BN9PR11MB5433519229319BA951CA97638CAA9@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210930222355.GH964074@nvidia.com>
In-Reply-To: <20210930222355.GH964074@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10e0c449-8fb3-45ec-fd18-08d98ef2ad11
x-ms-traffictypediagnostic: BN6PR11MB4098:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB4098D8A1C2CAF9C0E4C1BF658CB89@BN6PR11MB4098.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bMrdHY6K7HzfsHBSejP3mL7/P9ksubnGnahtdjB1516/L/8z+pi0iU8pZmPHeujSuWln25hSjvf900UnExsKE56K6i6PNQt/qFbFT41IVJMEoQzbFSxC44SgfqcQPGFkytnMPUJzyL8pGee9Ibc+ee05NBAY1gkqCvMYMzxrvhv/BinocUhAAcpXR/H/hPGFoVe/dHkkYsJNbpyzMT3FcEV6YBOHypkdHcNRl8D69RpqlE82O5FG98z/5BTB2crsIxRIuf3k9SjbhgtVoYc2jik994N0NpnMmNFM+pdmjSRXFhwXS9WIEer3rzBpWkD390S5RPhZQzDnOU8Wsxy/Aryxx2EMdabgujeoZghSuqiHYrRXCHmVEyTEHQDsW0qUK8e9DG6pXOnXYOUW5GpY/U8XZIMwRPWi8eO5edGdmGYQmFSPbmzT2DkEcpzJO8j8xJ0noTmMsonm16sO1mWPtDWAeE0xFZCUVoh/duHvk1X/y1J43JMvgrl7BemElpLqFGHZY/S7ItZ2eXDK4NSrAByu8cyHA7k93MklzfPKdLP56gmZ+/azznR+nhv4OTaWPJSKl1MqgRM4DQbNm/46LaIxYoXwxJvT1x5erHBiGKcGJUPE7sgNDOC9xRPk1c0GzTDCf4MbLaGrlATyl50kggfN7Y3iWYVxLt8T+roqp8eQvvfxvu7H62iHpVhegXsIM+k1/olRIMFwxmi+DhLiOg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5433.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(86362001)(26005)(5660300002)(7416002)(66946007)(76116006)(64756008)(66556008)(8676002)(122000001)(38100700002)(4326008)(66446008)(71200400001)(83380400001)(186003)(66476007)(54906003)(8936002)(33656002)(38070700005)(316002)(52536014)(6506007)(55016002)(508600001)(9686003)(6916009)(2906002)(7696005)(82960400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZrxYpPMbk7jjYlRoQsa7jEg2oly+MH3YIXsg4H6i5o2knwCpKVuQc9NZ9a89?=
 =?us-ascii?Q?iU/Bk7LCXK3tEBIkk9059gqvbZtgI6unaaD/AFnaL5tTuZVnmf9JaqX/0oFI?=
 =?us-ascii?Q?Lkk6c4AnB1mfDd3Js50zTweSj+FVFFeFdWwhSGvFD7woiM9CegqLwWJoJYgy?=
 =?us-ascii?Q?WXvGDdwoI1/r67gErJDBzXP72ukrGkoR5D9iCIhABoY0iUWSa/rntVH6D2c0?=
 =?us-ascii?Q?WM8iI74dG9kPPfjBUP5m9TEqVUB5TLMHh8TM8Ul0LMttmWQLoUBdqopyNI5+?=
 =?us-ascii?Q?wX3kVVoIQjMIho74t4JPmjtClwinAGdHVoQxo8d+WSZZbr3PHjrU7c1NlGnj?=
 =?us-ascii?Q?X6Bw86qgXIlGkOOd0mRJqE4gaazQ6LJTGlJuTuL+AdWJyixpTk1XE9eSCVJG?=
 =?us-ascii?Q?tW32bNJ3TfsqoH0bJjl64Wp55Z8JaNEj3Nw18pz6LaYdcq9yQnX0D1KJG/5k?=
 =?us-ascii?Q?CoC1n+3FG36f+BwIF5jcBBVg/fQ4+o3SNMAhCw32MLR65yCqouvHzOLVR2qE?=
 =?us-ascii?Q?9jimbtk0kt6zulfZakcIYJBl1qRADeQxqI/4QidTa1WjQjUVqSC94PlPzi22?=
 =?us-ascii?Q?It9bU7oqj8QknBpNxIsSI7FbbRPTEZW518dsXb2y0pbiItgK/oFTGr8DEc3L?=
 =?us-ascii?Q?icYNbqiMSm/kWROWVKoriT29gxwsEMF9Q/AT+YFB0/Xfg0y5XqSeQaWgYKzA?=
 =?us-ascii?Q?N7YUlYToxs/cqW4q+RiIJm4QeZoRsc0kjcgRamZG9XCqQjGyDyN64Nl2CKQ7?=
 =?us-ascii?Q?/877ix2swqK65+8BvuKjiBYgJjxvEqb04AREbNZHrjowPSzwwwvgw8TMyDME?=
 =?us-ascii?Q?kTcTA1nTJ3Dcp+FwYORnN77qvuDB44e928R91w+6chFjlZ+4ZU/6DH5QzP21?=
 =?us-ascii?Q?gtOVJthq50eXIXd3zQnqL2U7LSogsFAmOCEqau0brDRDKg+KDLxWjh8NK5a1?=
 =?us-ascii?Q?DVKFWor0PkHnnB8drjNfbmYa6BUzzlQ8KG9LIxgJrKlLkL6caEKHLbChOS1B?=
 =?us-ascii?Q?1dPBWYiwimyAPYUP+YL2VYMzKquHeZu6y5aZk0knWkG3uNiWSAlK6JDZcvoR?=
 =?us-ascii?Q?1Y7DgtTPrccK+WGavUCCn8BGEHWztQ8HIj/X8aqhHiRAFAkRHrwCB9ztI7FN?=
 =?us-ascii?Q?sCBZkmygB0Y74q6kuXyDkkB+a6B3WEqTY2ypS7aAHmpyERTLZvrNrgamUUvl?=
 =?us-ascii?Q?l/cFV3zWY/Txp12pApqlBJR+SiIxLmlYSs4WCabITTCBUT9rymSD48BHTPnd?=
 =?us-ascii?Q?U6Bi/wDQqSAbo1/24RXISbp5YwbJHnYdFi2qgj7pbQPKLrod/sy6aAYwazPs?=
 =?us-ascii?Q?+UcWG+nf9mgGr5oo7AaSgfHN?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10e0c449-8fb3-45ec-fd18-08d98ef2ad11
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2021 09:11:58.5158 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qSXYe5elpSpGoMtF5pUJBgg2WThqWiDwVYF+k0kzgrc1uuka34KhFhDodfh/ltu/UXcyxiBwukROvxztEN0pFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4098
X-OriginatorOrg: intel.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "parav@mellanox.com" <parav@mellanox.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "lkml@metux.net" <lkml@metux.net>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>, "Tian,
 Jun J" <jun.j.tian@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lushenming@huawei.com" <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
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
> Sent: Friday, October 1, 2021 6:24 AM
> 
> On Thu, Sep 30, 2021 at 09:35:45AM +0000, Tian, Kevin wrote:
> 
> > > The Intel functional issue is that Intel blocks the cache maintaince
> > > ops from the VM and the VM has no way to self-discover that the cache
> > > maintaince ops don't work.
> >
> > the VM doesn't need to know whether the maintenance ops
> > actually works.
> 
> Which is the whole problem.
> 
> Intel has a design where the device driver tells the device to issue
> non-cachable TLPs.
> 
> The driver is supposed to know if it can issue the cache maintaince
> instructions - if it can then it should ask the device to issue
> no-snoop TLPs.
> 
> For instance the same PCI driver on non-x86 should never ask the
> device to issue no-snoop TLPs because it has no idea how to restore
> cache coherence on eg ARM.
> 
> Do you see the issue? This configuration where the hypervisor silently
> make wbsync a NOP breaks the x86 architecture because the guest has no
> idea it can no longer use no-snoop features.

Thanks for explanation. But I still have one puzzle about the 'break'
part.

If hypervisor makes wbinvd a NOP then it will also set enforce_snoop
bit in PTE to convert non-snoop packet to snoop. No function in the guest
is broken, just the performance may lag.

If performance matters then hypervisor configures IOMMU to allow
non-snoop packet and then emulate wbinvd properly.

The contract between vfio and kvm is to convey above requirement
on how wbinvd is handled.

But in both cases cache maintenance instructions are available from 
guest p.o.v and no coherency semantics would be violated.

> 
> Using the IOMMU to forcibly prevent the device from issuing no-snoop
> makes this whole issue of the broken wbsync moot.

it's not prevent issuing. Instead, IOMMU converts non-snoop request
to snoop.

> 
> It is important to be really clear on what this is about - this is not
> some idealized nice iommu feature - it is working around alot of
> backwards compatability baggage that is probably completely unique to
> x86.
> 
> > > Other arches don't seem to have this specific problem...
> >
> > I think the key is whether other archs allow driver to decide DMA
> > coherency and indirectly the underlying I/O page table format.
> > If yes, then I don't see a reason why such decision should not be
> > given to userspace for passthrough case.
> 
> The choice all comes down to if the other arches have cache
> maintenance instructions in the VM that *don't work*
> 

Looks vfio always sets IOMMU_CACHE on all platforms as long as
iommu supports it (true on all platforms except intel iommu which
is dedicated for GPU):

vfio_iommu_type1_attach_group()
{
	...
	if (iommu_capable(bus, IOMMU_CAP_CACHE_COHERENCY))
		domain->prot |= IOMMU_CACHE;
	...
}

Should above be set according to whether a device is coherent?

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
