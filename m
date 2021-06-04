Return-Path: <SRS0=eMD9=K6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87104C07E94
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 09:20:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30A756140B
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 09:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30A756140B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E4F7541585;
	Fri,  4 Jun 2021 09:20:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CHZnQNVp9fWx; Fri,  4 Jun 2021 09:20:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 39B9841589;
	Fri,  4 Jun 2021 09:20:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F25E8C000E;
	Fri,  4 Jun 2021 09:20:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B19DC0001
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 09:20:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3670041589
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 09:20:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AIUoLfIRkUoG for <iommu@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 09:20:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 344CE41585
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 09:20:11 +0000 (UTC)
IronPort-SDR: 2NyO4erD6RcHX8fDovSfbApL54lYIyT2s/Dd8g3SGNf6CWDOI5R3r2iTvv7NsyC5UtGm1nCbPZ
 Vl6se0Eq9yKg==
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="204069303"
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; d="scan'208";a="204069303"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2021 02:19:58 -0700
IronPort-SDR: 49HB0+x6dFzrh4+whbIqw4FcM8DoXlK7+jumT4LcoFOeh7Jb0RTOVUA6sf2e1nAk1m4yhEr9HZ
 9WIKZBd+Z8bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; d="scan'208";a="550472884"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
 by orsmga004.jf.intel.com with ESMTP; 04 Jun 2021 02:19:53 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Fri, 4 Jun 2021 02:19:52 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Fri, 4 Jun 2021 02:19:52 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Fri, 4 Jun 2021 02:19:52 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Fri, 4 Jun 2021 02:19:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5jqBhgK2SlSsQREA5LEGVIahd2LuNRJ8pBIXbj2xFBXAA2RxC0XtKwxPaK3lAMCNxq2te9Ot/0MBT5fYi6/ytcVf2q5xDS2CnhzhGtFancfsFqGazB2D7EX6yCxB6sfc6ooEpXzhamVSFaimqu5H77AfzyFIq/cjalVozsMjHRpQCMZEfT7X3Ccyd2l9Ea1UtLDyCDK7RMRPatMfYvZzWftFclCO4yepm0qZkR1QzfgA8huAo7b/02eN7YeOdzDCOsQbK7gNXQySt14jNYFmqSlYciY05NkPaRXZ+r03sJKftAnW1phF5vp7giPGTHgDkjoXRzrM+9Coyqgx4rFTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O89T1pKTp24E/jkK4JezTlaOGvtQj85ATEtshEeM484=;
 b=gkkAyCv1fbcx14Kq9pX7CMkVAH/9DXqKjby8kT4RTGc1EmAEBQRz7eyOd+Nx/D551HleRccrKzNzedoDG74ZFo0UVl11ULV9E4Dzo0GyyJCk7wkIeyx5CRbAjHU3VHwwjnqTtNX2XSJZfiSX6j6M5mgG/vSyK9nQUzTdeNE4S1SpAZM0Z6VW8AQLzHJtM+Xu4M2wHS2UMX4sZpdJB1GBanvDDBUuLXvb0zi/BumhE9NG9bCUjaA2IQDPzzE4sE4PfcSeR2v944L/C7a3BZLiESEkyykA7PoEi3RK423ru2FXHPFPuzaJ5EnJYDM4z/3Ivq7owrt5jnvJhHZNLFR1CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O89T1pKTp24E/jkK4JezTlaOGvtQj85ATEtshEeM484=;
 b=Alm7yTWxJOxDpxpNv51juUBg4HukwXz5lmtplyPqX3snPMxq3ZCw8LOs9d6vaE/cUYB+0MJ+PgHL2TZp0hZQs3O3a8KTO4fEKMrJWS6C2aLNDd6KhzxqLQ2GDJVlWeVNWm1nGOmlBGMNe6aZnUKbHw5xppaKwmJ8aLEgw0XjykM=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by MWHPR1101MB2302.namprd11.prod.outlook.com (2603:10b6:301:5a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Fri, 4 Jun
 2021 09:19:50 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::6597:eb05:c507:c6c1]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::6597:eb05:c507:c6c1%12]) with mapi id 15.20.4195.023; Fri, 4 Jun 2021
 09:19:50 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>, Jason Gunthorpe
 <jgg@nvidia.com>
Subject: RE: [RFC] /dev/ioasid uAPI proposal
Thread-Topic: [RFC] /dev/ioasid uAPI proposal
Thread-Index: AddSzQ970oLnVHLeQca/ysPD8zMJZwBL2ymAAKTbxpAAKSt7gAAHpf9wAB1YcAAAAm5sgAAA1YgAAADonIAAAEmcgAABzCaAAAHbfwAAAYTsAAAEeLUAAAiRJwAAAHcmwAAUIS4AABDMegAAGmQXIA==
Date: Fri, 4 Jun 2021 09:19:50 +0000
Message-ID: <MWHPR11MB1886C4BC352DDE03B44070C08C3B9@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <20210602111117.026d4a26.alex.williamson@redhat.com>
 <20210602173510.GE1002214@nvidia.com>
 <20210602120111.5e5bcf93.alex.williamson@redhat.com>
 <20210602180925.GH1002214@nvidia.com>
 <20210602130053.615db578.alex.williamson@redhat.com>
 <20210602195404.GI1002214@nvidia.com>
 <20210602143734.72fb4fa4.alex.williamson@redhat.com>
 <20210602224536.GJ1002214@nvidia.com>
 <20210602205054.3505c9c3.alex.williamson@redhat.com>
 <MWHPR11MB1886DC8ECF5D56FE485D13D58C3C9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210603124036.GU1002214@nvidia.com>
 <20210603144136.2b68c5c5.alex.williamson@redhat.com>
In-Reply-To: <20210603144136.2b68c5c5.alex.williamson@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.142.24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3aa965f3-2773-4ccf-775a-08d92739e7c3
x-ms-traffictypediagnostic: MWHPR1101MB2302:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1101MB23023BC6D29A6C17C96B3F898C3B9@MWHPR1101MB2302.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WJNzGvPSKXafVVd0O3UAESpyiLW1MWY2Q5HCd1449W5RKvKjrPVhL4ae9Byw73SGYjJltBqPsifRPbauL9petaQapquM5SyOOrrzzxkwpoy1ZL8iChCn4oXFSh9UfS5KCaiCznTfpFrobZnRFhbRIvzfLuq9qN6NyzJM0Z2E+H86xpyCsY2hBi0k7s5NiHXEiuE32TP/R88S81fkzvcb4sw8CjSwJy/aaXdUoZMSUulRHNMPBiEwe6CbgL3F34GHnHEhiTeTlFmgKGK805jRjuSFOC6Zg9m4IYAprOX+flbxvbXRk1kIXwWMhzoOx9iqth2AM0iGw3hYn0eU08TNGcSfouR8x3RytPblcXbtCQFJp/M66vuGtKt7hlsjzQG7YRuu9ma9tG0zqFCd/0SKf9hUd+MTjHlQuUqkyzttjXgTOpKwvBTi0o2gZhGjHuOaIxtgdwrch7rSMVmLRLH5317XpgaELQhjTpfgKiNOuu3+mcbR5V9F+TU3eNRnkUr44lHV72wnaOXlVMLjmTYtHR+6PWKuy0fZEoJnl+9SfPbP39liEKKmnKS3uwCGz4/L+Axh6QIUYdFYVu6kA6SoTh615V6jtOsU6T/6ZUnGs38=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1886.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(396003)(39860400002)(366004)(376002)(346002)(136003)(8676002)(186003)(5660300002)(478600001)(26005)(9686003)(4744005)(66446008)(8936002)(66556008)(64756008)(2906002)(52536014)(55016002)(66476007)(38100700002)(122000001)(86362001)(7416002)(4326008)(66946007)(6506007)(316002)(76116006)(7696005)(110136005)(54906003)(83380400001)(71200400001)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: PFoTJ+jPdA3+P/y7UZ55ijedkqaberwGiH7vvWYKfI/5utVu6W3SeQ6bBW01S/OJ0q2yjfF6C3WwOFgHn2G9w7pk8hvHDnK1kBH2UbOTDGbLxZFuCtrogQftgvJXXFqrb+B7qgkxk2HyApWLMF4XA/Pcs8TH3uXXKQpX8Q4cvNSaxwitKwScGDT5X4IlXIOwgnJHkoVLeTSvLurKImsTxkGa2hQN6S2QhEiW5yTG8xK79dzaR1af+Hu2vdo4srBCnFlqaSrrgqh/MAC2y1oVusr6TiOrOLBS6ho5Piywl3eyDhvtNRRzS4D7nW0haQ0UA2yQgwCdNlL/7CdN/UqdeTqh1hsTqYsj9qoOPUz7remWjIvscu+mJ4QTXQI9hvpIa6AE5aiDOKSPsXeLggqczvmcsICt2+LKYSkeA0SPmNdNypdEklaugxBZ2GJxsoxpLEQeb8yjR1EFrPTFlTSKdZD1rWaTAk7tfWC3uWloBUFiExDtC9iPHDagGbOaCMgPBtpGuSSuWY8XmqsGldDg9ntlNJat9t4DgR/BLKEk8EHdwF3uSX3vCP4tjnN9PxlWiHCK5gFzmIJOBwmXzmuTCIidqtP5sgxLFa/gtII6eYZ9k6N+ENZHAcRP9tYMJ3UoxubDZIgJEf3pw4upurWjfLIfUuYxvqIH/7wE7caizFleKp35R9UI1r8bZTKBCgUa9CN9GcussLBmdJNeH109xyvvhamBaCA/hTqH+w9765klkg8ibV2PyoqYC+9TH0W5
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aa965f3-2773-4ccf-775a-08d92739e7c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2021 09:19:50.3162 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kyyHHQAkzqYb3owKVYo+g9U0tfnj98JYRLYXQTw71jDXPffr1kFKwYH34juuESLU+0BfxSixlq9MBPBKS6VK4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2302
X-OriginatorOrg: intel.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 David Woodhouse <dwmw2@infradead.org>, Jason Wang <jasowang@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>, Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>,
 David Gibson <david@gibson.dropbear.id.au>
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

> From: Alex Williamson <alex.williamson@redhat.com>
> Sent: Friday, June 4, 2021 4:42 AM
> 
> > 'qemu --allow-no-snoop' makes more sense to me
> 
> I'd be tempted to attach it to the -device vfio-pci option, it's
> specific drivers for specific devices that are going to want this and
> those devices may not be permanently attached to the VM.  But I see in
> the other thread you're trying to optimize IOMMU page table sharing.
> 
> There's a usability question in either case though and I'm not sure how
> to get around it other than QEMU or the kernel knowing a list of
> devices (explicit IDs or vendor+class) to select per device defaults.
> 

"-device vfio-pci" is a per-device option, which implies that the
no-snoop choice is given to the admin then no need to maintain 
a fixed device list in Qemu?

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
