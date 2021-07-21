Return-Path: <SRS0=85So=MN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8ABC636C9
	for <iommu@archiver.kernel.org>; Wed, 21 Jul 2021 02:13:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 214C360551
	for <iommu@archiver.kernel.org>; Wed, 21 Jul 2021 02:13:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 214C360551
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DF5D4402DD;
	Wed, 21 Jul 2021 02:13:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WshJTBMhP4vX; Wed, 21 Jul 2021 02:13:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AAAAF400E8;
	Wed, 21 Jul 2021 02:13:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6DCB7C0010;
	Wed, 21 Jul 2021 02:13:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B619C000E
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 02:13:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5F47640139
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 02:13:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iv-x3deZ1kkE for <iommu@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 02:13:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1916640134
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 02:13:38 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10051"; a="191636388"
X-IronPort-AV: E=Sophos;i="5.84,256,1620716400"; d="scan'208";a="191636388"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2021 19:13:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,256,1620716400"; d="scan'208";a="469997269"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmsmga008.fm.intel.com with ESMTP; 20 Jul 2021 19:13:31 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 20 Jul 2021 19:13:30 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 20 Jul 2021 19:13:30 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Tue, 20 Jul 2021 19:13:30 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Tue, 20 Jul 2021 19:13:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lVstmPwKSLgQNWJE/94E8OLQ04VEt3pKh544hFTXOgwgn3dgOsTWnS3UuaIqpK1WFo3o3nZpXi8y7sTpFKamaYZ/5rJsrvXrWsqNFBHOozU8e/xadkBFOW98rniQPWtsmM1yGt2BZb9OC6/Ds9JLuI/A79fix3h+HXQXaTWdaVARKR1nU8/k4TRiJnKsrasxyaHdbZGfiQS7Ix+bE1+VmTFmX49sX4aaUAYLyM/3UyH1+afe4BkAm+rajco43jDtFz7vLPrVOwgGWipwX7hroHXwgMosqw6sL1gRjcOPejLMdsx0h5BjiyJm4JcFUCGP6gRnigF6ClPPVrf8woZrKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2mW7NTubO0Wk3AKDvskvVTz079koITffXfpX19FoAk=;
 b=ixTrm48lpwUzaZ5t//PPH60sJrFMo1HodJOMqPrd21q5HmZPMxw9jfg+KuFDUlM8toJjAlgHw5jhNYGTVTT6n3LRlNTIujEIw43tkDuuEMPpYxDLlDRUwAmAc7FZ0IQs6wbA84XVlijUas2gcVSys6l6XVkrbEAQ3Sdl9A07V3UF7eIGSDwTollvt7Zxh47r9zdtaWYHw98xsGuBjq3dOEpDtPl9gFjiUk9aw/oVC5TLcYtk/MEt3m2hPbtsmPX++gL222ounnPk/l5m0qM1sSRQXvY1hcUzaXbMgxZwn5fjLHy/RFJVBvCkEoDQ86tLYClxagnI3ODcPL7DVYgCeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2mW7NTubO0Wk3AKDvskvVTz079koITffXfpX19FoAk=;
 b=wDll2Kf/BfHeslzex2QxCu+C6qSBcvH75VwiQPRB1Tm0zbtkYeBmTeYzX94l1EhshzxQuZDXn77mC53JNfea5/7djPMPWUomp3jivE9Y4eYKNH1G+cu98EKwLydifQKb+cHKuGCHkhwhIl5Wn8M5gaP5s0Oezp9CJmlZHMgKO/4=
Received: from BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13)
 by BN6PR1101MB2291.namprd11.prod.outlook.com (2603:10b6:405:53::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Wed, 21 Jul
 2021 02:13:23 +0000
Received: from BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::fd4b:cdde:6790:134]) by BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::fd4b:cdde:6790:134%9]) with mapi id 15.20.4331.034; Wed, 21 Jul 2021
 02:13:23 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Shenming Lu <lushenming@huawei.com>
Subject: RE: [RFC v2] /dev/iommu uAPI proposal
Thread-Topic: [RFC v2] /dev/iommu uAPI proposal
Thread-Index: Add0lrMH87IsTsl5Rp6WN1oQU6kGMQEkayMAAADgu8AABbP/AAAAaVlQAAzVHYAAAm93gAAC/CGAAAII8oAAAftjAAABDbYAAAAstAAAAGyhgAAARNiAAAwRJHAAGeRaAADmMRBw
Date: Wed, 21 Jul 2021 02:13:23 +0000
Message-ID: <BN9PR11MB54332CA3CF19835A7B2742688CE39@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <a8edb2c1-9c9c-6204-072c-4f1604b7dace@huawei.com>
 <BN9PR11MB54336D6A8CAE31F951770A428C129@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210715124813.GC543781@nvidia.com> <20210715135757.GC590891@otc-nc-03>
 <20210715152325.GF543781@nvidia.com> <20210715162141.GA593686@otc-nc-03>
 <20210715171826.GG543781@nvidia.com> <20210715174836.GB593686@otc-nc-03>
 <20210715175336.GH543781@nvidia.com> <20210715180545.GD593686@otc-nc-03>
 <20210715181327.GI543781@nvidia.com>
 <BN9PR11MB543337BAEA86708470AC1E0C8C119@BN9PR11MB5433.namprd11.prod.outlook.com>
 <013e240d-f627-3565-aba1-71b2d6f514b4@huawei.com>
In-Reply-To: <013e240d-f627-3565-aba1-71b2d6f514b4@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b6560f60-da2e-4098-1857-08d94bed1e0f
x-ms-traffictypediagnostic: BN6PR1101MB2291:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR1101MB22913FFA516875D53B6D24D68CE39@BN6PR1101MB2291.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7VKzhULVT9hdpgQAQWj60AIIdNsXkAovXrU7p7XAVE+ixG+eVzGeQPxQ0Eq6v/jPgghcB6c0tGzaGfEtGZZqTVlUtY6qLrmYKubV0shkjFR6qFc7v/PqgA22IWoRbPEE7+YosBkw+mw60ks8V/ajEC3z5YI0w/E0/zUP8TeWy/B7xbkhvUPo5mvbVrb53UarhaX+pxEz0Pfe6GvetlMdyMPRHTysCbitaD4d9Oc0jvnzHx0fG45jQePls+/O5Ae5E9QWal72+yBf/ya/EtqksBllwwGfEBkj/4jYa5rd8D2UE97YrSxp1TeIb/z5iXwpY3JMyw5bvlymNES7vTB4Xd9r3EbO6z2Y4ULu2g9kNoajhPaVDxB8QR97bDogSPhxPMB9A8bjB0iXtS5oSliiM8J9mShamowOYnx+BbXVeXtGdbmZOMWNHY+LLLVyW7nkYlCYGboClFQ76nQ4RGiXS0TSl71X+aYOuAS0xx2flPVuQ6BHFHn4jhjJNgMnjLS0yBSv2l3Jwdm5hHxdN32ZRhh1PqC/pra6mL3gYj1fFYzCEsZkVm9mc2BRys4NMc7NlQDfC5pQLB08midEpE60P5u9yW6Ucd9IXCXjPbA2Jy9wzTRuiX2njd+tJ+/u73yu1+lRMrNRwz25dg1D0F1jToKOtj0+bh697DAI6hPilqItFjVpILTj2oYb4MBywZdgKCIejbWm2lcSqHxHGRHruA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5433.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(396003)(346002)(39860400002)(33656002)(6916009)(38100700002)(54906003)(26005)(71200400001)(66946007)(66476007)(478600001)(7416002)(186003)(316002)(8676002)(52536014)(76116006)(55016002)(53546011)(83380400001)(6506007)(9686003)(66446008)(64756008)(8936002)(7696005)(4326008)(86362001)(5660300002)(66556008)(122000001)(2906002)(38070700004);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?49012AVdhYducYe7s9uGFGgeuettVTQmyGBLjlWrz9JBwQxt664t0WlzKGKH?=
 =?us-ascii?Q?kh6poTWAjqhg5xFIOkPw4VdIt+F0UY4noe7uA0Fms3jilpZJ6zT5xt3eSSZl?=
 =?us-ascii?Q?OHV45NzGzypbrt6geSKTVmPpLrI/a98wIbm/uUw6hSOg9AHF7FmNG98+tUTg?=
 =?us-ascii?Q?7JTbfMJaG+WlVhbjvNe0bnN3gbNMztq2fs879lkmgqGd7kxX7NnVazoK+7iq?=
 =?us-ascii?Q?qeQEzx/R03hMT/ru8wheg+Q32csMjCeeKJPWLesouYB2OKtIflWHroTvChR6?=
 =?us-ascii?Q?AbUYp5Op/AmZODos4AxhWNjscTzjoj0voEPO+c3oF75H4bFdTEj8pJcGhbqN?=
 =?us-ascii?Q?+lIROw3MOxxyQKyr4jusG+R1PVAW00QWn7ykbtVUl6tJ26b63hOw1PF67+z5?=
 =?us-ascii?Q?tkyNbjCJybxH4NeMHnLUM6PuzgfEqd6W+IHz13CHskFepUTBPMnLZPhQGV3E?=
 =?us-ascii?Q?BRCEDRyo3rfxQl66JFQ8wYBS57b+tjpNsi8wVFfZCmZCirzFwEZTf3vLhPCh?=
 =?us-ascii?Q?xTCbLgSvnGCQmBsC3D+xRmS3//pN5eEASiNyjiix8H8tTQ3HjMzQGcmK34BZ?=
 =?us-ascii?Q?0+AiQOhO8TNLGv60cAkp3bJveM1+pW5Z1G8q0FpE3897MuxjY5JSnteqd/uE?=
 =?us-ascii?Q?kS6mYtxfmBQ9d8QbrUyvlNh5lEyWJcK4NafUNlLo7He1cRTDmnICgFsBZvbw?=
 =?us-ascii?Q?RjFP59miqEWVEfKgvDiP+4b0BZ9M4u6hk1+SJ7ml9Jj+WuGK10XyXlxVeNky?=
 =?us-ascii?Q?atz5A3A3YLC367jYa7F/bgI15FCO3xAuesRf3q83PK+PPMgiKYaMnRBy1dRw?=
 =?us-ascii?Q?nMyKcFCMV0kItfsd7Yddo5OqVywlFPcMYECNSB2pKhhTR1UV4h/Ebw/d6rOB?=
 =?us-ascii?Q?y3P2Sudh0hlrkMnO6h8OngKIQHY2ZW055WU+l4IThY5N2ZRA9f5yV5Wq1U3l?=
 =?us-ascii?Q?zv81DIvRdNTXOKLaXZZnf9BwE3x15fTa25tvl6ZHSzSZzjY7+OBVYvDsn75z?=
 =?us-ascii?Q?+Zl5X8Vq4fyIkTQCJiieRQovu+oBrz1ba31kL1t3D0oz3+w8ceAOdbPFQSjC?=
 =?us-ascii?Q?Sq61ZdaHXc9Tc0vH/6NAFIVIIrsuNAD6LHnvt2MXDDAOPdgTQmYy/4XAo6U3?=
 =?us-ascii?Q?TkRC4HQoBQKT3w0LdFAaja+5arFcqZzs5UKmZ1zRBImoYQCBEinb/zAXGcIH?=
 =?us-ascii?Q?Oyr/gaSZijwF1KMSWmt8n6/pefky6BcdIPkIn5IMK3kuMLTZJobshQvCHDj7?=
 =?us-ascii?Q?8iz/l7/9xWomvgeyDId8QKVU3XSG5F8cSnxZEbYZIAB0zADo7FIjxsgDuFP5?=
 =?us-ascii?Q?b4kwzGNUqFEc5PTwlalRoI28?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6560f60-da2e-4098-1857-08d94bed1e0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2021 02:13:23.2258 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5/Gw5+Vx3/zU/r9E7hnkFleX4qUjSoQo/pfEVWX5QTFcVlDtrJVV1gFW6PrChjcCOgq0Hd9ZNOo/GC7pXSltmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2291
X-OriginatorOrg: intel.com
Cc: Jean-Philippe
 Brucker <jean-philippe@linaro.org>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, David Woodhouse <dwmw2@infradead.org>,
 Jason Wang <jasowang@redhat.com>,
 "Alex Williamson \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Kirti Wankhede <kwankhede@nvidia.com>,
 "Enrico Weigelt, metux IT consult" <lkml@metux.net>, Jason
 Gunthorpe <jgg@nvidia.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "wanghaibin.wang@huawei.com" <wanghaibin.wang@huawei.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Robin Murphy <robin.murphy@arm.com>, "parav@mellanox.com" <parav@mellanox.com>
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

> From: Shenming Lu
> Sent: Friday, July 16, 2021 8:20 PM
> 
> On 2021/7/16 9:20, Tian, Kevin wrote:
>  > To summarize, for vIOMMU we can work with the spec owner to
> > define a proper interface to feedback such restriction into the guest
> > if necessary. For the kernel part, it's clear that IOMMU fd should
> > disallow two devices attached to a single [RID] or [RID, PASID] slot
> > in the first place.
> >
> > Then the next question is how to communicate such restriction
> > to the userspace. It sounds like a group, but different in concept.
> > An iommu group describes the minimal isolation boundary thus all
> > devices in the group can be only assigned to a single user. But this
> > case is opposite - the two mdevs (both support ENQCMD submission)
> > with the same parent have problem when assigned to a single VM
> > (in this case vPASID is vm-wide translated thus a same pPASID will be
> > used cross both mdevs) while they instead work pretty well when
> > assigned to different VMs (completely different vPASID spaces thus
> > different pPASIDs).
> >
> > One thought is to have vfio device driver deal with it. In this proposal
> > it is the vfio device driver to define the PASID virtualization policy and
> > report it to userspace via VFIO_DEVICE_GET_INFO. The driver understands
> > the restriction thus could just hide the vPASID capability when the user
> > calls GET_INFO on the 2nd mdev in above scenario. In this way the
> > user even doesn't need to know such restriction at all and both mdevs
> > can be assigned to a single VM w/o any problem.
> >
> 
> The restriction only probably happens when two mdevs are assigned to one
> VM,
> how could the vfio device driver get to know this info to accurately hide
> the vPASID capability for the 2nd mdev when VFIO_DEVICE_GET_INFO?
> There is no
> need to do this in other cases.
> 

I suppose the driver can detect it via whether two mdevs are opened by a
single process.

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
