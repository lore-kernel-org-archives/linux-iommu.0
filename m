Return-Path: <SRS0=+Hy+=DW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D00C433E7
	for <iommu@archiver.kernel.org>; Thu, 15 Oct 2020 10:15:07 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FA2120BED
	for <iommu@archiver.kernel.org>; Thu, 15 Oct 2020 10:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="rnWEqpgZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FA2120BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 9D46A2E639;
	Thu, 15 Oct 2020 10:15:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cYU+LNOWa9YE; Thu, 15 Oct 2020 10:14:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 222172E61A;
	Thu, 15 Oct 2020 10:14:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4235C07FF;
	Thu, 15 Oct 2020 10:14:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 02C0EC0051
 for <iommu@lists.linux-foundation.org>; Thu, 15 Oct 2020 10:14:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id DD54088527
 for <iommu@lists.linux-foundation.org>; Thu, 15 Oct 2020 10:14:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jxvrfymjKEY5 for <iommu@lists.linux-foundation.org>;
 Thu, 15 Oct 2020 10:14:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id DCE3288177
 for <iommu@lists.linux-foundation.org>; Thu, 15 Oct 2020 10:14:54 +0000 (UTC)
IronPort-SDR: EedO7Ug4d6C8wOlbAkmbvibfZ39mv2YMK9l/9RcxmgkhjJGfKt0zvl953ih/E3FVIYwNH9QCjW
 odk8fT+7VO/g==
X-IronPort-AV: E=McAfee;i="6000,8403,9774"; a="166370268"
X-IronPort-AV: E=Sophos;i="5.77,378,1596524400"; d="scan'208";a="166370268"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2020 03:14:53 -0700
IronPort-SDR: 6265EbTWILi7iPjtgfcrsIvVAHS4mt6IYn9V35cvr1prvirMVHao4Kbub+zBPJIMMhmMCK/OY+
 cPhwl28POspg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,378,1596524400"; d="scan'208";a="521788259"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
 by fmsmga005.fm.intel.com with ESMTP; 15 Oct 2020 03:14:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 15 Oct 2020 03:14:52 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 15 Oct 2020 03:14:51 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 15 Oct 2020 03:14:51 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.50) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 15 Oct 2020 03:14:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kl7W3GRPbZftSXGoUFfydhcyuWx7lxUUzgl/6ko3S/rGb0Zhy2dxUij0O9K/+Bs5u/bxs7ijV69Uqc4X2WJ902l9FpeBB0rihHqnQu9WWNeRn6W+FtfCcxkKN8uvqYLhi/oTg6nYrMIh0F0LvfF5OpWtwLInQ4AnrhPmk2T8tlw+dChapKiMLAq7ekQvguTpBKbIyT92d5zRyC5ygg3EdxeUgkv7C9G2A9ffYe4MwW6qog9MSSfZYdBH6neqVchwyUpez15NNGrO5+yXPT2ZYsWC3RJzSnBfgW9XDhXA4vJqtjvkSAy5rrHs41voii/V1qOinmwpaOlIkPuNh45rjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/oNafQFaPXbusAEi9X8czmD3NU3Yt5uvS8bQoJwnNU=;
 b=eF9JgddF4+iwAJLtzRS7JBA5dcIboQYGzpVeim1YIFq2yY4xO3An4hST05pB+cC9z4Ku3i/Ro6Ja9VpG0SmGAszVi7uAJmROcp0rTILrlhoSPe820TK3HGOO/yE4yN67MlawaXWNRt4domQqqD4COmjSUZjAnBATesMXYU6ESANvPsGe4JP48ZiJ8V7F+FrZge+3cqwgWC5tQLnP6MiQSGJswtm1c0sfRiYZiOoEzhA/VXidt0SwBIxmCi5c6mxG/2hnlO6f3IQvenMmINrjdn9mlVxEm+XC2VgnJBVOgXp0imHXXld5wfy8xrRMM3SOUjMxgb6BUZh48pGvHuh98A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/oNafQFaPXbusAEi9X8czmD3NU3Yt5uvS8bQoJwnNU=;
 b=rnWEqpgZuBGju/Jg4/HAOXJ0YeoeJC3mu2SXxhj8JQryCPWUoxNC9tkasOhofqsOKtYdMVyEihAQqVkNYRCEMAXRb8OgyjAAKAQqH6EfGCm5KYrfxH1tx4Ykq9pOYQ3wAFrrX0lkqyguHuzy86OVFadHm3MxWX/bCd4eLQQyu6A=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM5PR11MB1930.namprd11.prod.outlook.com (2603:10b6:3:106::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.38; Thu, 15 Oct 2020 10:14:45 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::a1ec:ba6b:5057:be2f]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::a1ec:ba6b:5057:be2f%11]) with mapi id 15.20.3477.022; Thu, 15 Oct
 2020 10:14:45 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Jason Wang <jasowang@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>
Subject: RE: (proposal) RE: [PATCH v7 00/16] vfio: expose virtual Shared
 Virtual Addressing to VMs
Thread-Topic: (proposal) RE: [PATCH v7 00/16] vfio: expose virtual Shared
 Virtual Addressing to VMs
Thread-Index: AdagceQQLvqwjRCrQOaq1hZ7MgDUUAAt0sKAACmGxcAAPBsbAAAARpcAAAOFkAAAAwCSQA==
Date: Thu, 15 Oct 2020 10:14:44 +0000
Message-ID: <DM5PR11MB143531293E4D65028801FDA1C3020@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <MWHPR11MB1645CFB0C594933E92A844AC8C070@MWHPR11MB1645.namprd11.prod.outlook.com>
 <45faf89a-0a40-2a7a-0a76-d7ba76d0813b@redhat.com>
 <MWHPR11MB1645CF252CF3493F4A9487508C050@MWHPR11MB1645.namprd11.prod.outlook.com>
 <9c10b681-dd7e-2e66-d501-7fcc3ff1207a@redhat.com>
 <MWHPR11MB164501E77BDB0D5AABA8487F8C020@MWHPR11MB1645.namprd11.prod.outlook.com>
 <21a66a96-4263-7df2-3bec-320e6f38a9de@redhat.com>
In-Reply-To: <21a66a96-4263-7df2-3bec-320e6f38a9de@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.217]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 404605e2-454e-48bd-55bb-08d870f323e1
x-ms-traffictypediagnostic: DM5PR11MB1930:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB1930A5518729C81E3EA84FB1C3020@DM5PR11MB1930.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UMKIUYG4kkl5F1g6iA2l20mfMMDvKjnaSAzHefqDtOhww2gw7YXWQ+Wx3GDKcm2eC4MGNNwNW6sHIfSq4xqH34kY25RvnQWrwAetiIcRN+FoFJGa8hBVCdXHkSHYe2U90tNDggyYuyJSEITGkAZ03lONnJgOa7du+n9a8+U+8PfXdmz0jJ51TFMdZ7AKfLOOZltsUlkjvkEcRolBLGVNj5GIR1ZVNw6+IDwKMVccA/9r33Ck9mZ8bzEr47wU1qTy2RJvOmxnYwjpTUQun89J7Rdhhk5fv+LHJwrBL6qzgDhSOaiwpEx6ek+w1hEqB2O5Bes33JgV3X8Gam6MbNKcFIiKDotgGCGViX9Ndt/lFy2NpdovT2GArvXiKm9VAIbWbG4CjHrbdT0syWLmB0AJuN2AWE2eZkU0528V7jEJJxvCcnx/Ta7PEjiCjvvA2KATsahp2ofeWAI9qHu6Y07r8A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(396003)(346002)(136003)(376002)(71200400001)(26005)(7696005)(186003)(66556008)(54906003)(64756008)(66946007)(9686003)(4326008)(66476007)(76116006)(478600001)(966005)(316002)(66446008)(110136005)(86362001)(6506007)(83380400001)(5660300002)(83080400001)(7416002)(30864003)(8676002)(55016002)(8936002)(52536014)(33656002)(2906002)(21314003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 8cUPAIXVF2kP8FD8QsRIBt18ur1HstjqTKBNwoRuPRm3tMrr1ITZTEsaGnRxGe7qYLO7Pnk45cmnhke7nAI/CNCbdlq/kqUE4FygRuZsj18TMqaPd2vi9dToCBugKip8wzAog6wyoqx6TdRkakD7xPvgWJorD+HP6AgYMKGie6874fGqYidrvPIXw8AQgVugSoECg0Fu/JCTEiR0ROVEZVjkxgtqvsaTmTVwgK/oobcGsS8kqsH88StmETHJy6xAMbHD1vB0si2viz6sU9iyzjQfOqwyDwPZHwGNPkVp20C81cPVBIYyZr4N96TnfbP2JKv8H6i6Tbp56CgJXyPaO/cY4ao/Yp4XJZ5lFh+fHy7yk797kIwIeOvPY5nc0aBj1XkSzy0eswF47hiUrQ++mSKzHo9IU3E/XH1+N0lokjsbS4m3CRxfkARzTT4T/PurLDIzgSOSPcQMTv2pAE9mk4piWGyzueDBWU6FlLxAF9Av1d6wE9cb4UDGeCLN6ypdbUbQzmZpCfAKLDvP6YX8IEJrA5Qa3wrZQRMVIl06DbAAnqx+S7VbcVbUy0QWiJ7ZMrsnlcHPsqK8bV4fQ6Rc40ntjE5TewYtJbpsR9Lw2Ttb0Ea3W6vXeTx0oxHB+QQTaB0BzyI0qQFtWo7vnq9uVw==
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 404605e2-454e-48bd-55bb-08d870f323e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2020 10:14:44.9451 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XF5ogRo/WdNbY2+hi92Wr1MhKi9pX8bPnVieaWB46WgMIRGyeew5rMPMkH3rlWg8ZH/xwQIBhkYiB6jKyGL2UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1930
X-OriginatorOrg: intel.com
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "stefanha@gmail.com" <stefanha@gmail.com>, "Tian,
 Jun J" <jun.j.tian@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Sun,
 Yi Y" <yi.y.sun@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, "Wu,
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

> From: Jason Wang <jasowang@redhat.com>
> Sent: Thursday, October 15, 2020 4:41 PM
> 
> 
> On 2020/10/15 ??3:58, Tian, Kevin wrote:
> >> From: Jason Wang <jasowang@redhat.com>
> >> Sent: Thursday, October 15, 2020 2:52 PM
> >>
> >>
> >> On 2020/10/14 ??11:08, Tian, Kevin wrote:
> >>>> From: Jason Wang <jasowang@redhat.com>
> >>>> Sent: Tuesday, October 13, 2020 2:22 PM
> >>>>
> >>>>
> >>>> On 2020/10/12 ??4:38, Tian, Kevin wrote:
> >>>>>> From: Jason Wang <jasowang@redhat.com>
> >>>>>> Sent: Monday, September 14, 2020 12:20 PM
> >>>>>>
> >>>>> [...]
> >>>>>     > If it's possible, I would suggest a generic uAPI instead of
> >>>>> a VFIO
> >>>>>> specific one.
> >>>>>>
> >>>>>> Jason suggest something like /dev/sva. There will be a lot of
> >>>>>> other subsystems that could benefit from this (e.g vDPA).
> >>>>>>
> >>>>>> Have you ever considered this approach?
> >>>>>>
> >>>>> Hi, Jason,
> >>>>>
> >>>>> We did some study on this approach and below is the output. It's a
> >>>>> long writing but I didn't find a way to further abstract w/o
> >>>>> losing necessary context. Sorry about that.
> >>>>>
> >>>>> Overall the real purpose of this series is to enable IOMMU nested
> >>>>> translation capability with vSVA as one major usage, through below
> >>>>> new uAPIs:
> >>>>> 	1) Report/enable IOMMU nested translation capability;
> >>>>> 	2) Allocate/free PASID;
> >>>>> 	3) Bind/unbind guest page table;
> >>>>> 	4) Invalidate IOMMU cache;
> >>>>> 	5) Handle IOMMU page request/response (not in this series);
> >>>>> 1/3/4) is the minimal set for using IOMMU nested translation, with
> >>>>> the other two optional. For example, the guest may enable vSVA on
> >>>>> a device without using PASID. Or, it may bind its gIOVA page table
> >>>>> which doesn't require page fault support. Finally, all operations
> >>>>> can be applied to either physical device or subdevice.
> >>>>>
> >>>>> Then we evaluated each uAPI whether generalizing it is a good
> >>>>> thing both in concept and regarding to complexity.
> >>>>>
> >>>>> First, unlike other uAPIs which are all backed by iommu_ops, PASID
> >>>>> allocation/free is through the IOASID sub-system.
> >>>> A question here, is IOASID expected to be the single management
> >>>> interface for PASID?
> >>> yes
> >>>
> >>>> (I'm asking since there're already vendor specific IDA based PASID
> >>>> allocator e.g amdgpu_pasid_alloc())
> >>> That comes before IOASID core was introduced. I think it should be
> >>> changed to use the new generic interface. Jacob/Jean can better
> >>> comment if other reason exists for this exception.
> >>
> >> If there's no exception it should be fixed.
> >>
> >>
> >>>>>     From this angle
> >>>>> we feel generalizing PASID management does make some sense.
> >>>>> First, PASID is just a number and not related to any device before
> >>>>> it's bound to a page table and IOMMU domain. Second, PASID is a
> >>>>> global resource (at least on Intel VT-d),
> >>>> I think we need a definition of "global" here. It looks to me for
> >>>> vt-d the PASID table is per device.
> >>> PASID table is per device, thus VT-d could support per-device PASIDs
> >>> in concept.
> >>
> >> I think that's the requirement of PCIE spec which said PASID + RID
> >> identifies the process address space ID.
> >>
> >>
> >>>    However on Intel platform we require PASIDs to be managed in
> >>> system-wide (cross host and guest) when combining vSVA, SIOV, SR-IOV
> >>> and ENQCMD together.
> >>
> >> Any reason for such requirement? (I'm not familiar with ENQCMD, but
> >> my understanding is that vSVA, SIOV or SR-IOV doesn't have the
> >> requirement for system-wide PASID).
> > ENQCMD is a new instruction to allow multiple processes submitting
> > workload to one shared workqueue. Each process has an unique PASID
> > saved in a MSR, which is included in the ENQCMD payload to indicate
> > the address space when the CPU sends to the device. As one process
> > might issue ENQCMD to multiple devices, OS-wide PASID allocation is
> > required both in host and guest side.
> >
> > When executing ENQCMD in the guest to a SIOV device, the guest
> > programmed value in the PASID_MSR must be translated to a host PASID
> > value for proper function/isolation as PASID represents the address
> > space. The translation is done through a new VMCS PASID translation
> > structure (per-VM, and 1:1 mapping). From this angle the host PASIDs
> > must be allocated 'globally' cross all assigned devices otherwise it
> > may lead to 1:N mapping when a guest process issues ENQCMD to multiple
> > assigned devices/subdevices.
> >
> > There will be a KVM forum session for this topic btw.
> 
> 
> Thanks for the background. Now I see the restrict comes from ENQCMD.
> 
> 
> >
> >>
> >>> Thus the host creates only one 'global' PASID namespace but do use
> >>> per-device PASID table to assure isolation between devices on Intel
> >>> platforms. But ARM does it differently as Jean explained.
> >>> They have a global namespace for host processes on all host-owned
> >>> devices (same as Intel), but then per-device namespace when a device
> >>> (and its PASID table) is assigned to userspace.
> >>>
> >>>> Another question, is this possible to have two DMAR hardware
> >>>> unit(at least I can see two even in my laptop). In this case, is
> >>>> PASID still a global resource?
> >>> yes
> >>>
> >>>>>     while having separate VFIO/
> >>>>> VDPA allocation interfaces may easily cause confusion in
> >>>>> userspace, e.g. which interface to be used if both VFIO/VDPA devices exist.
> >>>>> Moreover, an unified interface allows centralized control over how
> >>>>> many PASIDs are allowed per process.
> >>>> Yes.
> >>>>
> >>>>
> >>>>> One unclear part with this generalization is about the permission.
> >>>>> Do we open this interface to any process or only to those which
> >>>>> have assigned devices? If the latter, what would be the mechanism
> >>>>> to coordinate between this new interface and specific passthrough
> >>>>> frameworks?
> >>>> I'm not sure, but if you just want a permission, you probably can
> >>>> introduce new capability (CAP_XXX) for this.
> >>>>
> >>>>
> >>>>>     A more tricky case, vSVA support on ARM (Eric/Jean please
> >>>>> correct me) plans to do per-device PASID namespace which is built
> >>>>> on a bind_pasid_table iommu callback to allow guest fully manage
> >>>>> its PASIDs on a given passthrough device.
> >>>> I see, so I think the answer is to prepare for the namespace
> >>>> support from the start. (btw, I don't see how namespace is handled
> >>>> in current IOASID module?)
> >>> The PASID table is based on GPA when nested translation is enabled
> >>> on ARM SMMU. This design implies that the guest manages PASID table
> >>> thus PASIDs instead of going through host-side API on assigned
> >>> device. From this angle we don't need explicit namespace in the host
> >>> API. Just need a way to control how many PASIDs a process is allowed
> >>> to allocate in the global namespace. btw IOASID module already has
> >>> 'set' concept per-process and PASIDs are managed per-set. Then the
> >>> quota control can be easily introduced in the 'set' level.
> >>>
> >>>>>     I'm not sure
> >>>>> how such requirement can be unified w/o involving passthrough
> >>>>> frameworks, or whether ARM could also switch to global PASID
> >>>>> style...
> >>>>>
> >>>>> Second, IOMMU nested translation is a per IOMMU domain capability.
> >>>>> Since IOMMU domains are managed by VFIO/VDPA
> >>>>>     (alloc/free domain, attach/detach device, set/get domain
> >>>>> attribute, etc.), reporting/enabling the nesting capability is an
> >>>>> natural extension to the domain uAPI of existing passthrough frameworks.
> >>>>> Actually, VFIO already includes a nesting enable interface even
> >>>>> before this series. So it doesn't make sense to generalize this
> >>>>> uAPI out.
> >>>> So my understanding is that VFIO already:
> >>>>
> >>>> 1) use multiple fds
> >>>> 2) separate IOMMU ops to a dedicated container fd (type1 iommu)
> >>>> 3) provides API to associated devices/group with a container
> >>>>
> >>>> And all the proposal in this series is to reuse the container fd.
> >>>> It should be possible to replace e.g type1 IOMMU with a unified module.
> >>> yes, this is the alternative option that I raised in the last paragraph.
> >>>
> >>>>> Then the tricky part comes with the remaining operations (3/4/5),
> >>>>> which are all backed by iommu_ops thus effective only within an
> >>>>> IOMMU domain. To generalize them, the first thing is to find a way
> >>>>> to associate the sva_FD (opened through generic /dev/sva) with an
> >>>>> IOMMU domain that is created by VFIO/VDPA. The second thing is to
> >>>>> replicate {domain<->device/subdevice} association in /dev/sva path
> >>>>> because some operations (e.g. page fault) is triggered/handled per
> >>>>> device/subdevice.
> >>>> Is there any reason that the #PF can not be handled via SVA fd?
> >>> using per-device FDs or multiplexing all fault info through one
> >>> sva_FD is just an implementation choice. The key is to mark faults
> >>> per device/ subdevice thus anyway requires a userspace-visible
> >>> handle/tag to represent device/subdevice and the domain/device
> >>> association must be constructed in this new path.
> >>
> >> I don't get why it requires a userspace-visible handle/tag. The
> >> binding between SVA fd and device fd could be done either explicitly
> >> or implicitly. So userspace know which (sub)device that this SVA fd is for.
> >>
> >>
> >>>>>     Therefore, /dev/sva must provide both per- domain and
> >>>>> per-device uAPIs similar to what VFIO/VDPA already does. Moreover,
> >>>>> mapping page fault to subdevice requires pre- registering
> >>>>> subdevice fault data to IOMMU layer when binding guest page table,
> >>>>> while such fault data can be only retrieved from parent driver
> >>>>> through VFIO/VDPA.
> >>>>>
> >>>>> However, we failed to find a good way even at the 1st step about
> >>>>> domain association. The iommu domains are not exposed to the
> >>>>> userspace, and there is no 1:1 mapping between domain and device.
> >>>>> In VFIO, all devices within the same VFIO container share the
> >>>>> address space but they may be organized in multiple IOMMU domains
> >>>>> based on their bus type. How (should we let) the userspace know
> >>>>> the domain information and open an sva_FD for each domain is the
> >>>>> main problem here.
> >>>> The SVA fd is not necessarily opened by userspace. It could be get
> >>>> through subsystem specific uAPIs.
> >>>>
> >>>> E.g for vDPA if a vDPA device contains several vSVA-capable
> >>>> domains, we
> >> can:
> >>>> 1) introduce uAPI for userspace to know the number of vSVA-capable
> >>>> domain
> >>>> 2) introduce e.g VDPA_GET_SVA_FD to get the fd for each
> >>>> vSVA-capable domain
> >>> and also new interface to notify userspace when a domain disappears
> >>> or a device is detached?
> >>
> >> You need to deal with this case even in VFIO, isn't it?
> > No. VFIO doesn't expose domain knowledge to userspace.
> 
> 
> Neither did the above API I think.
> 
> 
> >
> >>
> >>>    Finally looks we are creating a completely set of new subsystem
> >>> specific uAPIs just for generalizing another set of subsystem
> >>> specific uAPIs. Remember after separating PASID mgmt.
> >>> out then most of remaining vSVA uAPIs are simpler wrapper of IOMMU
> >>> API. Replicating them is much easier logic than developing a new
> >>> glue mechanism in each subsystem.
> >>
> >> As discussed, the point is more than just simple generalizing. It's
> >> about the limitation of current uAPI. So I have the following questions:
> >>
> >> Do we want a single PASID to be used by more than one devices?
> > Yes.
> >
> >> If yes, do we want those devices to share I/O page tables?
> > Yes.
> >
> >> If yes, which uAPI is  used to program the shared I/O page tables?
> >>
> > Page table binding needs to be done per-device, so the userspace will
> > use VFIO uAPI for VFIO device and vDPA uAPI for vDPA device.
> 
> 
> Any design considerations for this, I think it should be done per PASID instead
> (consider PASID is a global resource)?

per device and per PASID. you may have a look from the below arch. PASID
table is per device, the binding of page table are set to PASID table
entry.

"
In VT-d implementation, PASID table is per device and maintained in the host.
Guest PASID table is shadowed in VMM where virtual IOMMU is emulated.

    .-------------.  .---------------------------.
    |   vIOMMU    |  | Guest process CR3, FL only|
    |             |  '---------------------------'
    .----------------/
    | PASID Entry |--- PASID cache flush -
    '-------------'                       |
    |             |                       V
    |             |                CR3 in GPA
    '-------------'
Guest
------| Shadow |--------------------------|--------
      v        v                          v
Host
    .-------------.  .----------------------.
    |   pIOMMU    |  | Bind FL for GVA-GPA  |
    |             |  '----------------------'
    .----------------/  |
    | PASID Entry |     V (Nested xlate)
    '----------------\.------------------------------.
    |             |   |SL for GPA-HPA, default domain|
    |             |   '------------------------------'
    '-------------'
Where:
 - FL = First level/stage one page tables
 - SL = Second level/stage two page tables
"
copied from https://lwn.net/Articles/807506/

> 
> > The binding request is initiated by the virtual IOMMU, when capturing
> > guest attempt of binding page table to a virtual PASID entry for a
> > given device.
> 
> 
> And for L2 page table programming, if PASID is use by both e.g VFIO and
> vDPA, user need to choose one of uAPI to build l2 mappings?

for L2 page table mappings, it's done by VFIO MAP/UNMAP. for vdpa, I guess
it is tlb flush. so you are right. Keeping L1/L2 page table management in
a single uAPI set is also a reason for my current series which extends VFIO
for L1 management.

Regards,
Yi Liu

> Thanks
> 
> 
> >
> > Thanks
> > Kevin
> >
> >>
> >>>>> In the end we just realized that doing such generalization doesn't
> >>>>> really lead to a clear design and instead requires tight coordination
> >>>>> between /dev/sva and VFIO/VDPA for almost every new uAPI
> >>>>> (especially about synchronization when the domain/device
> >>>>> association is changed or when the device/subdevice is being reset/
> >>>>> drained). Finally it may become a usability burden to the userspace
> >>>>> on proper use of the two interfaces on the assigned device.
> >>>>>
> >>>>> Based on above analysis we feel that just generalizing PASID mgmt.
> >>>>> might be a good thing to look at while the remaining operations are
> >>>>> better being VFIO/VDPA specific uAPIs. anyway in concept those are
> >>>>> just a subset of the page table management capabilities that an
> >>>>> IOMMU domain affords. Since all other aspects of the IOMMU domain
> >>>>> is managed by VFIO/VDPA already, continuing this path for new nesting
> >>>>> capability sounds natural. There is another option by generalizing the
> >>>>> entire IOMMU domain management (sort of the entire vfio_iommu_
> >>>>> type1), but it's unclear whether such intrusive change is worthwhile
> >>>>> (especially when VFIO/VDPA already goes different route even in legacy
> >>>>> mapping uAPI: map/unmap vs. IOTLB).
> >>>>>
> >>>>> Thoughts?
> >>>> I'm ok with starting with a unified PASID management and consider the
> >>>> unified vSVA/vIOMMU uAPI later.
> >>>>
> >>> Glad to see that we have consensus here. :)
> >>>
> >>> Thanks
> >>> Kevin

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
