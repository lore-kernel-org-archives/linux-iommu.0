Return-Path: <SRS0=/c0m=D3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80EE0C4363A
	for <iommu@archiver.kernel.org>; Tue, 20 Oct 2020 14:01:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C385A22200
	for <iommu@archiver.kernel.org>; Tue, 20 Oct 2020 14:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="ZlfrufBt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C385A22200
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 4786D204BB;
	Tue, 20 Oct 2020 14:01:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IL7I1uiSJY-Y; Tue, 20 Oct 2020 14:01:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 51E8922812;
	Tue, 20 Oct 2020 14:01:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44698C0052;
	Tue, 20 Oct 2020 14:01:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 726BEC0051
 for <iommu@lists.linux-foundation.org>; Tue, 20 Oct 2020 14:01:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 541E186CE9
 for <iommu@lists.linux-foundation.org>; Tue, 20 Oct 2020 14:01:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WpYnnFtTVX75 for <iommu@lists.linux-foundation.org>;
 Tue, 20 Oct 2020 14:01:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 64B2486CEB
 for <iommu@lists.linux-foundation.org>; Tue, 20 Oct 2020 14:01:00 +0000 (UTC)
IronPort-SDR: Cw8KQjKJixPOlvOXlch+ysifbj5qXSmVli+H8hsRQ/wpGTIEE4uadt0H5kHwF/7yzWbJhc55p8
 sCF8OV/13VEA==
X-IronPort-AV: E=McAfee;i="6000,8403,9779"; a="167329141"
X-IronPort-AV: E=Sophos;i="5.77,397,1596524400"; d="scan'208";a="167329141"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2020 07:00:58 -0700
IronPort-SDR: iYHO2AKSa3ue0oxC2FyBd6YXH/9P3niWmGxezClwA6umjYvJ1wmtHTT2kvwp4QdaZ6HnDwXbUO
 FYQb2vkFP15A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,397,1596524400"; d="scan'208";a="358530733"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
 by FMSMGA003.fm.intel.com with ESMTP; 20 Oct 2020 07:00:57 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 20 Oct 2020 07:00:57 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 20 Oct 2020 07:00:57 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 20 Oct 2020 07:00:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVqHODQe52I+jvszmZKYK7hilHrfyT9kWpOP9jKfjXJ/F2p/ss9f90Dd7qL9z8qi8sdMoxJAkkIZQQJFEQsz0I8Mjipn0XigubUibst7UmR9f5XqUzRzTQUqbPYvNhjOsMOG25TSbbZSchq/9yvPCSjTzxGWuChC1iKBsUrJaEJvPh3Y4wm2I511mRzDvgwrvY3RSvWHoYpdZJxpjQSJR6kfzoZQzMCvqCh1LWThdQYCCNWEarFydSYA1FizDAXUXF6ffsVV+hT4EoC2TNlv828EhMB7dX37Qx0MSBz6vFH4vlrbBrXC38kn98+wwaG9fj8FChPnINCwpL5zBkJNfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnThXUWFP/7XYaDfv8mNAwTArWJJYp3eXBIuT1WuPU4=;
 b=gF4gomOvw/vJ5GmASFL7frUr9Fmf1NnjsIVWK/V1sCKZz6XTFMI5AiFCcDYvxw52OwoIrr7t9rnjK47goIAV/J/wlBGknwnBtrt+R/1nL7l2KFcU4/DFzvs8hT2it/ZtmyWTYncADBudh4R6Y2iAN8o6RMikJyL2LdXfn3Y7WnXxwEpP1Ho9+HuwErdV2+KFD9d+pydrn41p9tpaHj5Otsnj8lKrbUziyWqOR5KAbGOYG3Su8eE7HYWW5WyKq6/aNhhbxLbFJfMQgqe8bZ4THZYxtVUx7hNLSYDZD8t67OsAgG13U6Ixq+TGnJ8X7NjC0Y2sPsypLt4IwV8e4Fwv6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnThXUWFP/7XYaDfv8mNAwTArWJJYp3eXBIuT1WuPU4=;
 b=ZlfrufBtYVq3F+0ey+87p34AobjChpN3C406U1CXE+lT2MRl/58WTuAH6Ys+rWSHaBC7R+6i7XuF3s2RZwqpoIqZQNHRxPKfrmNrQqi40r5GpBEtNzr2EjrV5ICL6LeXvfVrUR+BtvLWRmgAucDt9pufeucppo7RgqWpVoHR7XA=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM6PR11MB4721.namprd11.prod.outlook.com (2603:10b6:5:2a3::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.27; Tue, 20 Oct 2020 14:00:31 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::a1ec:ba6b:5057:be2f]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::a1ec:ba6b:5057:be2f%11]) with mapi id 15.20.3477.028; Tue, 20 Oct
 2020 14:00:31 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: (proposal) RE: [PATCH v7 00/16] vfio: expose virtual Shared
 Virtual Addressing to VMs
Thread-Topic: (proposal) RE: [PATCH v7 00/16] vfio: expose virtual Shared
 Virtual Addressing to VMs
Thread-Index: AdagceQQLvqwjRCrQOaq1hZ7MgDUUAAt0sKAACmGxcAAPBsbAAAARpcAAAOFkAAAAwCSQADzeAMAAANpJxAAAu+FgAAAOEXwAAlgCoAAABHqwA==
Date: Tue, 20 Oct 2020 14:00:31 +0000
Message-ID: <DM5PR11MB143591B85490D675F0628890C31F0@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <45faf89a-0a40-2a7a-0a76-d7ba76d0813b@redhat.com>
 <MWHPR11MB1645CF252CF3493F4A9487508C050@MWHPR11MB1645.namprd11.prod.outlook.com>
 <9c10b681-dd7e-2e66-d501-7fcc3ff1207a@redhat.com>
 <MWHPR11MB164501E77BDB0D5AABA8487F8C020@MWHPR11MB1645.namprd11.prod.outlook.com>
 <21a66a96-4263-7df2-3bec-320e6f38a9de@redhat.com>
 <DM5PR11MB143531293E4D65028801FDA1C3020@DM5PR11MB1435.namprd11.prod.outlook.com>
 <a43d47f5-320b-ef60-e2be-a797942ea9f2@redhat.com>
 <DM5PR11MB1435D55CAE858CC8EC2AFA47C31F0@DM5PR11MB1435.namprd11.prod.outlook.com>
 <6e478a9e-2051-c0cd-b6fd-624ff5ef0f53@redhat.com>
 <DM5PR11MB143545475500159AD958F006C31F0@DM5PR11MB1435.namprd11.prod.outlook.com>
 <20201020135439.GH6219@nvidia.com>
In-Reply-To: <20201020135439.GH6219@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [221.220.190.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 52c13d50-c8c2-4ce2-f6ba-08d87500824b
x-ms-traffictypediagnostic: DM6PR11MB4721:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB47216D82873662F484D2C6A3C31F0@DM6PR11MB4721.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WovryCtNoHcrojiTJHJgLqCyRk2i+TSajl6PKFlSR2znxwAwUqLLGfEDIStr08lhg84MZTb9htGmrJmg60CZVsdepKTRiTEMQegWSWJbcrbGtsBNLxMDY9SmErxa3/sH2SDcwDwQHGg+aiGF8FYm7yrpM1nQaQ2HTT/Ur4l2CobbWhuamWvSF6+VdGzKk0UxhVJwq2+0z1jLIoGKKdlIgPC/gKMvSf+bxARGD+8ffmUsmMPkPQA8M2HmO6rN7F6lIv0lPAaDTtpCXf5t8FX3qFFcG9VjNsnZSoZuMDbBgXvIf3eorWKMmUfnlOHrYvj7BvoxTER9R0p44XRsQGCKlw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(346002)(136003)(396003)(376002)(33656002)(7696005)(86362001)(66556008)(64756008)(76116006)(66476007)(6916009)(2906002)(316002)(7416002)(186003)(26005)(52536014)(5660300002)(478600001)(9686003)(4744005)(55016002)(71200400001)(54906003)(66446008)(66946007)(4326008)(6506007)(8936002)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: WiFfvPU1OmCcCZ71M0wMMRCMRdsFjKz403hhxuB5yMda8iPvFa43EDop4GW2F5FGFdM2rYxwZti78QIOKm8OHMF5xtpC3KTf4a+HTHolbbz+Ufv5b3JyYEBSbTQmRopQ6JD+pQ6FrR+wK/rB6CpkK2GucF9GmzaprYlmnCO+TGVPmxbgqKssH4B2beZau6FLIbkeSFbm/n3bR5EfXZo40kkl9cD4FmG5dfZwvxDNLnhVyRLjs+cesgW2uhNYC/4ds/ExYEB5/nuOw19R/v8o36y196JPaFmExChX6yJlidiD8T1zsRcTjqqL08kTiTL3Ynb99HaoJrj8kg4KUTIOgGZ6N93TtM3MfoLPHmc9LNULZrpUwML/Kr/VnJllpGUJwSdscXSHic9/GZnrQ6ZQ5qtb+E+DV8boVf8nkLhdirSCz3sAHWO66I+NDl0eXlkS2vtyHZ8KVf+XL8ppAFBqoskj7XSKylilESnfDS+1IPO8tcnHzFTFK5wiwOiZd35ex8g9UeZBb1iA25kHUVPwhDC9dk11eW8sLNPnPebrOraaBoaOzSfdTW2URbzk/MHnQoUupr9GI1hDMxegCw+FIHtx8bE9X1qf9N/GP44qHW7Da/hyPnfche/7gG2AeLORYWCg3B1PSYMQS3ksDNeUZw==
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c13d50-c8c2-4ce2-f6ba-08d87500824b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2020 14:00:31.7902 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NUNCi9Y6KcCuGR5J4slkHJzrXktfgBBsbJ6crFZIS/+snlZJQpFHUYqYVpXNsIegwYThH/+r8RgGoSwJeM3Qog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4721
X-OriginatorOrg: intel.com
Cc: "Tian, Jun J" <jun.j.tian@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "stefanha@gmail.com" <stefanha@gmail.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Wu,
 Hao" <hao.wu@intel.com>
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
> Sent: Tuesday, October 20, 2020 9:55 PM
> 
> On Tue, Oct 20, 2020 at 09:40:14AM +0000, Liu, Yi L wrote:
> 
> > > See previous discussion with Kevin. If I understand correctly, you expect a
> shared
> > > L2 table if vDPA and VFIO device are using the same PASID.
> >
> > L2 table sharing is not mandatory. The mapping is the same, but no need to
> > assume L2 tables are shared. Especially for VFIO/vDPA devices. Even within
> > a passthru framework, like VFIO, if the attributes of backend IOMMU are not
> > the same, the L2 page table are not shared, but the mapping is the same.
> 
> I think not being able to share the PASID shows exactly why this VFIO
> centric approach is bad.

no, I didn't say PASID is not sharable. My point is sharing L2 page table is
not mandatory.

Regards,
Yi Liu

> Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
