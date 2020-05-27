Return-Path: <SRS0=MQAj=7J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3E7C433E0
	for <iommu@archiver.kernel.org>; Wed, 27 May 2020 08:40:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A463420723
	for <iommu@archiver.kernel.org>; Wed, 27 May 2020 08:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="yyUl5ute"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A463420723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6B3F887D7F;
	Wed, 27 May 2020 08:40:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0VZlhSYreS07; Wed, 27 May 2020 08:40:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9986F8589A;
	Wed, 27 May 2020 08:40:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6EB9CC0881;
	Wed, 27 May 2020 08:40:56 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3D4C6C016F
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 08:40:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 22F1B878A8
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 08:40:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 83hDDNUfWTJ6 for <iommu@lists.linux-foundation.org>;
 Wed, 27 May 2020 08:40:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by whitealder.osuosl.org (Postfix) with ESMTPS id F1A838589A
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 08:40:53 +0000 (UTC)
IronPort-SDR: a+aodu09A+orP+EcWrqHC3Gh9Llz8S2N2b6KStI6a25cqeaItswJt03EjdSS/CVshfjuiLb0DJ
 F0vdAvt4jS2Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2020 01:40:53 -0700
IronPort-SDR: rDiz9m+iQCJ4hAntoc9Jt2eT4I30mjTKLdal0GI+0WjcmhGaiytJiFacbR9zaQSSsl0NDAWask
 QzKHWWv9YeyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,440,1583222400"; d="scan'208";a="291521996"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
 by fmsmga004.fm.intel.com with ESMTP; 27 May 2020 01:40:53 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 27 May 2020 01:40:52 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 27 May 2020 01:40:52 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 27 May 2020 01:40:52 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.51) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Wed, 27 May 2020 01:40:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3hISDN7RGEO5Cqpap91A9Sjws2hiv6vKYhXr9r14YUkBvljFEa3lJsBbyfxJyQ6xBooe1IwKEv8ZX8XJJ+FyJhVL+L9dXeo506e4chehW8N2NE7uEFHiuODsS24gIKSq1jfFJ53QqttBKHZJ0HQK/ee6K6YIdwNJT9sbDK/CIhPJSb3/3eyPelEYPuwN7Z5Nxm4580ZYQKdnmgGYQUSIwpxAgs/5mCvxic5Bkue9XZvIVRWb4+gGwSbQkVqAK3EHeAj90z8jE3Zu6KwwdxLWb/J9QgtxoSDRXrxSWuw7k6EQ5PgdSPkN4naQUBpb62iwrdPKyLlkgtPcYsxFc5ncw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBr6Cw1ga7HMHMnoqN/nJ4kMb2/82O6sOhOWpXrWRKk=;
 b=cQT+nGWqOZpt91dmM9XY6vFY+jNg7odPRvjg887adWjv30pNC6mhjd+tvXzlh9dlf5xKG20K3OrBbytcUTU3tY0VSevTq1dJXRBE3s1OV/Fuxs4MMRyn5Qp0Uq5tClWBkp19XEUBxVAkdGi15hyWS4ZdfjygLf6TLlcUrghTPqh2IOEwqox5sYuiJ3uEeNkoUNmxaYmOFJo70KQBJ+5WwoAuUMeoOBSBtwdXduE1BfwnyW31IWLktEHBgA7c8EKWSNm1n7J/wLKgNWky0x754nox6yVMQg9ViSgnE/efYFZx+RLPU0au5POy5emvcaaVVqpMtcts5ON+Afbc6uyIow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBr6Cw1ga7HMHMnoqN/nJ4kMb2/82O6sOhOWpXrWRKk=;
 b=yyUl5ute4hQLUwUKdju0NdExONWIMUnn0AWZheTnLYKvNOlWiPDQjIel5sMjdAltoz+AdK5uBsTk1L84zrhpxcAP3megRtFsJXUKGCwgJoLtRseOzdbjmGRb9VxBwIYhYLWYtKmTEcroLLtVcuDtsbFmq/DJSvQAb7MnzC6ekSY=
Received: from MWHPR11MB1645.namprd11.prod.outlook.com (2603:10b6:301:b::12)
 by MWHPR11MB1549.namprd11.prod.outlook.com (2603:10b6:301:c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Wed, 27 May
 2020 08:40:48 +0000
Received: from MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::b441:f6bd:703b:ba41]) by MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::b441:f6bd:703b:ba41%2]) with mapi id 15.20.3021.029; Wed, 27 May 2020
 08:40:47 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Xiang Zheng <zhengxiang9@huawei.com>, Jean-Philippe Brucker
 <jean-philippe@linaro.org>
Subject: RE: [RFC] Use SMMU HTTU for DMA dirty page tracking
Thread-Topic: [RFC] Use SMMU HTTU for DMA dirty page tracking
Thread-Index: AQHWMFylSKWbJMD/rEatnfJX129kWai4sCAAgAKbIaCAADjSgIAAH3UA
Date: Wed, 27 May 2020 08:40:47 +0000
Message-ID: <MWHPR11MB1645AA007D24F2D005794E5C8CB10@MWHPR11MB1645.namprd11.prod.outlook.com>
References: <b926ec0b-fe87-0792-c41d-acad56c656a4@huawei.com>
 <20200522171452.GC3453945@myrica>
 <e68c1158-8573-a477-42ce-48cee510c3ce@huawei.com>
 <MWHPR11MB16454475DA1FF417CEF5A32B8CB10@MWHPR11MB1645.namprd11.prod.outlook.com>
 <897a84ac-0a71-ace7-e05b-3cc9f0b05c28@huawei.com>
In-Reply-To: <897a84ac-0a71-ace7-e05b-3cc9f0b05c28@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.52.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 54b978fa-a516-4527-c039-08d80219a777
x-ms-traffictypediagnostic: MWHPR11MB1549:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB154984600C62C48E0641246C8CB10@MWHPR11MB1549.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04163EF38A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: riX/bWTqtxrInMi3AM8xO+S0KoLDs2U0WCGJ725s+8whEtNtBBclk6PQ4c1BVaQKHur6pVOQPCAHVD8tJEQXBV6+MwIjUU4giw812iYGFt4rUFl7J11oXq3qdLnAvz1a/LnJSNgdhJ4L04NGrvVEzi4WVBv7Fn1GD6ghat1xRKLuTo5v47zQX71pNR11c9vOzcbLCS61Q8neAje9SjhrUoec2uQIcOunkWsU//WgzPpn2LSqpHSVrZlC/1lj0jj19DXqNhg6UIAVVcsFyblqZUMpDe44ee4olWbXmql8EhdCsU7UX8ScHSy/nNg9qENSKMm7lmQBVK8G8Fk2KjU3lc/xE+3EnLjxz46FlvwhuOirbTNLxS3mD2LyAHeSi4qeT2tt668/auL0fP+k7bEENtpAqrvfJo7M0X+FPcZsnvFVwx3L5q4imPZAFezpDKGu9d9oCjQMKZfoKfJMhsXuGA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1645.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(346002)(366004)(376002)(396003)(39860400002)(136003)(26005)(7696005)(66946007)(9686003)(71200400001)(55016002)(2906002)(83380400001)(6506007)(76116006)(53546011)(4326008)(186003)(316002)(8936002)(110136005)(966005)(52536014)(64756008)(8676002)(33656002)(66446008)(54906003)(7416002)(66556008)(5660300002)(86362001)(478600001)(66476007)(14143004);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 6nne222+IwcKCia8xoDVICfFk4wq27ry2W47nuEyGmQX4Q1vGwzK89PaFsE3cBZ8WSgLuYloAmr8cV3wxttS7AM8Mob7rrtcKux3CnPWDm9TDrfiH36oLgrcn+M8UAxqCp2S1yFwlz+SetSm0IRyXMJUiwxTigaV/xiqwcWRaIoeklfsNgie+zHURfTHqpzDtYU92/Of7cXGRZvXV8ywpWRVN7gK5lhseJAJ4Fm/nEznErPEugcBS0OMr78l459Qw81jnFSLZQ/LvcsJJiC4lYn57MXNDEvfn74l+iuO+Af7Z8jFsfshy7hbPS7s7YzkJDMMmmBb4k6htdX5jKGEdraHL0QhbWLkhT/7qXAEGpvViMEgSBb+fKyXvXue4G6KUNM+kqyAET7BCEaaErw/kyDp+5PdE0SZ7uSfvVAiMKV5hIAcvDzx9o6pN6E9NaEhHi6Y2FWtdpyFggYhesC2EImh4GFG4pr2iwJ1fr+ggdEFhxp/TEPRJd/2UYAL7Cwb
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b978fa-a516-4527-c039-08d80219a777
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2020 08:40:47.8266 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v/oJknY8DEN5k305oivWg3BcBvsgPEl8TdsjZdv11jes7t++D5TccvBYslRaWGKr0KkV5S/9EJHcJtCVVrkH8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1549
X-OriginatorOrg: intel.com
Cc: "Zhao, Yan Y" <yan.y.zhao@intel.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, "maz@kernel.org" <maz@kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 James Morse <james.morse@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "prime.zeng@hisilicon.com" <prime.zeng@hisilicon.com>,
 Wang Haibin <wanghaibin.wang@huawei.com>, Will Deacon <will@kernel.org>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
 "julien.thierry.kdev@gmail.com" <julien.thierry.kdev@gmail.com>
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

> From: Xiang Zheng <zhengxiang9@huawei.com>
> Sent: Wednesday, May 27, 2020 2:45 PM
> 
> 
> On 2020/5/27 11:27, Tian, Kevin wrote:
> >> From: Xiang Zheng
> >> Sent: Monday, May 25, 2020 7:34 PM
> >>
> >> [+cc Kirti, Yan, Alex]
> >>
> >> On 2020/5/23 1:14, Jean-Philippe Brucker wrote:
> >>> Hi,
> >>>
> >>> On Tue, May 19, 2020 at 05:42:55PM +0800, Xiang Zheng wrote:
> >>>> Hi all,
> >>>>
> >>>> Is there any plan for enabling SMMU HTTU?
> >>>
> >>> Not outside of SVA, as far as I know.
> >>>
> >>
> >>>> I have seen the patch locates in the SVA series patch, which adds
> >>>> support for HTTU:
> >>>>     https://www.spinics.net/lists/arm-kernel/msg798694.html
> >>>>
> >>>> HTTU reduces the number of access faults on SMMU fault queue
> >>>> (permission faults also benifit from it).
> >>>>
> >>>> Besides reducing the faults, HTTU also helps to track dirty pages for
> >>>> device DMA. Is it feasible to utilize HTTU to get dirty pages on device
> >>>> DMA during VFIO live migration?
> >>>
> >>> As you know there is a VFIO interface for this under discussion:
> >>> https://lore.kernel.org/kvm/1589781397-28368-1-git-send-email-
> >> kwankhede@nvidia.com/
> >>> It doesn't implement an internal API to communicate with the IOMMU
> >> driver
> >>> about dirty pages.
> >
> > We plan to add such API later, e.g. to utilize A/D bit in VT-d 2nd-level
> > page tables (Rev 3.0).
> >
> 
> Thank you, Kevin.
> 
> When will you send this series patches? Maybe(Hope) we can also support
> hardware-based dirty pages tracking via common APIs based on your
> patches. :)

Yan is working with Kirti on basic live migration support now. After that
part is done, we will start working on A/D bit support. Yes, common APIs
are definitely the goal here.

> 
> >>
> >>>
> >>>> If SMMU can track dirty pages, devices are not required to implement
> >>>> additional dirty pages tracking to support VFIO live migration.
> >>>
> >>> It seems feasible, though tracking it in the device might be more
> >>> efficient. I might have misunderstood but I think for live migration of
> >>> the Intel NIC they trap guest accesses to the device and introspect its
> >>> state to figure out which pages it is accessing.
> >
> > Does HTTU implement A/D-like mechanism in SMMU page tables, or just
> > report dirty pages in a log buffer? Either way tracking dirty pages in IOMMU
> > side is generic thus doesn't require device-specific tweak like in Intel NIC.
> >
> 
> Currently HTTU just implement A/D-like mechanism in SMMU page tables.
> We certainly
> expect SMMU can also implement PML-like feature so that we can avoid
> walking the
> whole page table to get the dirty pages.

Is there a link to HTTU introduction?

> 
> By the way, I'm not sure whether HTTU or SLAD can help for mediated deivce.
> 

A/D bit applies to mediated device on VT-d.

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
