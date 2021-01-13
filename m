Return-Path: <SRS0=lzux=GQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A3BC433DB
	for <iommu@archiver.kernel.org>; Wed, 13 Jan 2021 08:10:48 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0A2B23358
	for <iommu@archiver.kernel.org>; Wed, 13 Jan 2021 08:10:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0A2B23358
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4228386072;
	Wed, 13 Jan 2021 08:10:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fNPTHoDnQBpy; Wed, 13 Jan 2021 08:10:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 065E585C50;
	Wed, 13 Jan 2021 08:10:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EB037C088B;
	Wed, 13 Jan 2021 08:10:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36543C013A
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 08:10:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 23E7A84B65
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 08:10:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZT71mMIhUqxG for <iommu@lists.linux-foundation.org>;
 Wed, 13 Jan 2021 08:10:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0D7FE84B55
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 08:10:41 +0000 (UTC)
IronPort-SDR: ujwnbZgN93I8FziCTUd08QSZeM7KHloT11TqpeQdBJOEqsQHM8QLip7LVaFupRNlJEDJf8Dz+R
 1VDsKTbTh9bw==
X-IronPort-AV: E=McAfee;i="6000,8403,9862"; a="165256696"
X-IronPort-AV: E=Sophos;i="5.79,343,1602572400"; d="scan'208";a="165256696"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2021 00:10:40 -0800
IronPort-SDR: Lb2hRura7Oj3miuGrk2s27VCCD9ncATz5Ea1ds/d1iSnLyDYyazYe9JpTfA89CNvN5INj+5UQK
 Zwx8x4HbQKVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,343,1602572400"; d="scan'208";a="348734968"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
 by orsmga003.jf.intel.com with ESMTP; 13 Jan 2021 00:10:40 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 Jan 2021 00:10:39 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 Jan 2021 00:10:39 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 13 Jan 2021 00:10:39 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 13 Jan 2021 00:10:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z87YWOReU8DPtR++8PSVMwCnuhdtD/Cj0sTWPn0FqMxEk/b5PoDxpSEl8bj6wGagBnny4Kf5WoK9ObwMvvVny9+VUbM5s38rRoeYBJv5Xc2YqY/P1UjbS9DxYphUEmI1hpXZYcJPNew0nnRpY3/0F4uxK+d5F3zTZjpbRwxhsbEtXxcup2wdfLCH8upYdV0YpvyqLjjaFE4/YvMmTJEDAcOoGBnuHJp+muvghEd4xG/F2ESkKbY3LyTPclZVd9jAUon2VSfHd2LwGCN+rLbDd7v7n6OXVb2GUouG26rdApsJMkwgvICYBy3ycjgPUFmf6Oas55NZVwHkfaFb9nTp0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/UdMkz+ipXZpfwWCz4B05O/eqtEyRbsgp1hu9VygwaM=;
 b=e8K2pRZX24arD64tTViXzDrOqNISXwMuckJ5KbZgG+Q/+hzIme4L+1rqGN/5kaKzKBSjtkNiEsLS2g0g4T/jUPHPqzpIrYG92nWqddnrNpnobI7DTGvxspRPFgDjwAjYQ/X4rzyS9fIPUwrgITj3fwhbiaRiA3V9Ht5R+u+D+p7WXnN0rpGo8OK9VwrBt/en6th8gHVtyC7OXQyBoU5mn0lODQunOxTXbcGnHk6idP8hY03XyAXoMxVc+kJ7VaiHpv0NBZ6AH3P5dCr3aZTLNNv2x/q6RTQclMA9UmaiOtcZZ/0SeuxhfeeQqR8gREF3iyKgsAckN7jOAsm4IZi6+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/UdMkz+ipXZpfwWCz4B05O/eqtEyRbsgp1hu9VygwaM=;
 b=y8Wgfww4LlkD1qyD6vW6adVFPWLPj/RisTV+r/930Wu6rE+CUqaSo5pTDlhS0Bamv56YHCN2ohQ+xEM237SKd9eWEBeqCgjz2WPHV4uyuBL7SP+QJcZlfSwq9PdsCjfqkbb23Luk3SCbmGqDJHfaJtiRnjnAHraKcYEER+aMco4=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by MW3PR11MB4652.namprd11.prod.outlook.com (2603:10b6:303:5a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Wed, 13 Jan
 2021 08:10:29 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::1d96:5d95:3a17:2419]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::1d96:5d95:3a17:2419%4]) with mapi id 15.20.3763.010; Wed, 13 Jan 2021
 08:10:29 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Jean-Philippe Brucker
 <jean-philippe@linaro.org>
Subject: RE: [PATCH v9 03/10] iommu: Separate IOMMU_DEV_FEAT_IOPF from
 IOMMU_DEV_FEAT_SVA
Thread-Topic: [PATCH v9 03/10] iommu: Separate IOMMU_DEV_FEAT_IOPF from
 IOMMU_DEV_FEAT_SVA
Thread-Index: AQHW5c9iGKyAtZrVV0Gy0IAW1dQ6Vqoja/GAgABPqoCAASY+gIAASexg
Date: Wed, 13 Jan 2021 08:10:28 +0000
Message-ID: <MWHPR11MB18868F53E5A9E0CF9975042B8CA90@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <20210108145217.2254447-1-jean-philippe@linaro.org>
 <20210108145217.2254447-4-jean-philippe@linaro.org>
 <4de8ef03-a2ed-316e-d3e3-6b8474e20113@linux.intel.com>
 <X/1o72DTmzdCMhDz@myrica>
 <c88e5d74-098d-7f1d-a7bb-a89e40fb8fa4@linux.intel.com>
In-Reply-To: <c88e5d74-098d-7f1d-a7bb-a89e40fb8fa4@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.193]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee93cc91-b290-44cb-1e28-08d8b79ab0c4
x-ms-traffictypediagnostic: MW3PR11MB4652:
x-microsoft-antispam-prvs: <MW3PR11MB46523395BA74D8D189C7772C8CA90@MW3PR11MB4652.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I6YtU3vPJ11qovs+2lSx8VmIGAo2DRcr+3dfXUnlIxnyrzjqWsT3DwUkONzgOuKMXhyhbrwEcPhm+1YTDPgQoa3CvUE4rhgiao/vOHKlHMsqgb/Guixwq4WZBvPLwjjfPl+BGcp7WRBG+twUBydBiXekiex6zo9NIlOFnNmxRvoSwe58L8TEfD9I3HLALPu6c3QlkvJVZBZiE9WDeADuSOwsEocgqA5sfnjdWJqgPAISrsoyPcCEn61jVdGkzIM3x75ncpVDBdToJTtWsUM0EvL0OME3jHQYpaRq/BhXk94lZ/XGMMRgP+pL1iiSifhqZxtHXtbyg+/Y/joGjbbCXDzCxrhBn1rjfTDZxt0MF61sI0u7pslVlHvXdKXmCxE2uzvUMlUaYK8HbeVwtXM8ng==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1886.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(396003)(39860400002)(136003)(346002)(6506007)(7416002)(8676002)(83380400001)(4326008)(53546011)(26005)(2906002)(86362001)(186003)(7696005)(52536014)(5660300002)(54906003)(110136005)(33656002)(71200400001)(316002)(9686003)(55016002)(66946007)(66556008)(66446008)(64756008)(76116006)(66476007)(478600001)(8936002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?YS8yVndZQS9hNlpVTHJaaVNZMXVFQW9kWWdLL0UzTjI3dzNvcSs3WCs2VHBi?=
 =?utf-8?B?NW9hT2J5TXZUYS96cEFTRlhYaXYzMUVjVzZ2LzIrNDdSVVJ4VmMrbFhJalkr?=
 =?utf-8?B?UEVYdlFxZW5VeGtkbnBIeVE1aE13djRadkx6YzE1QTJpNlpid2YvTGFpRnVw?=
 =?utf-8?B?S2NVbzFBQlhkbGNId2hESjlrT3NKZFJVM0JnMEtiWGpGd1h2MVpMTU5VMFlo?=
 =?utf-8?B?bVhCVEF4TWYwZWFsN1A4TlNFbEg5OFJSOHRMWEhtTk9URUh4amtraWpIbGNt?=
 =?utf-8?B?bERobWw2dEVETVVrWWJxcmZQZ3h0eVh3Q1E3clBvRzlDbWJrTEEyK1hmRDZD?=
 =?utf-8?B?ZXVXM3B6YkVxNSt4T0pGK0lXdHJWSEhSVXRjVUQ1NDNzVjByQkNiWUlWamRR?=
 =?utf-8?B?S0gxVUxVV2FVNys2RDQyaFY3c3p6dDYyUW1tWS9aSDN4MFhrRHNkZWJQbGtZ?=
 =?utf-8?B?UmhjeGlvZkVtcFpQVXc2UzZ6MVJweXpNdlY5MXZvY0YyTzJXdG85T052MFBW?=
 =?utf-8?B?NURNNklRaExyKzI5UmcxNEFTbXMxT3RYaUJTbzhKS05OeWVsaGE2bDk3ZTE0?=
 =?utf-8?B?akJQM010OWVTRmZBT1RDbDJkNWMyY3UvVk9vR2ZUU2ZVQ21pYU5kcHBVcUx3?=
 =?utf-8?B?VDVhRUNGZXc5OUhNWmRnLzFsdkdvMjdYb0VGdDlGcGlVUUJMZ2JNQ1VwS2NL?=
 =?utf-8?B?QU9SNDFxWHFZdGtOV2kvSko0c3owa3R1VjhtRXhMd0dEanhoVUkwdkFRaGRR?=
 =?utf-8?B?Y1VybEMyTk5KWHFKUmk4M2tPREs5U2ljR1F4OGY0MVRRSUVJUFB2R0N5aURu?=
 =?utf-8?B?R3pzLzNHUm1VS09ZWVRyenFaV1BPdGV1SHo3bTV6cUxxODJPcFM2OFFuRDVQ?=
 =?utf-8?B?cXNVS2lNYVZEclkyZ2Jpd0pYSVAvS3B5dmZpL2RxcTMvdWg4VlMvQk93cDl5?=
 =?utf-8?B?QTd4SUU0MCs1c2JjS0VQZHIzQmR6MUZsbGpUOXlPTzI1RDZKdHJJN0xhaCtu?=
 =?utf-8?B?NEJEZ2dWeVRtR3p2WVJVYjRQb29HWWpHREFRcTFjUHExQjBueFRZQU1Bc3V5?=
 =?utf-8?B?MnJvRzdOd3liaEVuVlNiNUFYMnRUYlpVdHN2Rk95aTdWV1RBVnhZTW12VHRr?=
 =?utf-8?B?S05EdkoyR05mUG5VSWpXbzM3ZEdjb2ZMaW5KUHhVdDcwNjlvK1pFZnVDc09a?=
 =?utf-8?B?bXVuakoyUVNpZ3A1RnhRM1RmZ1RkNEx5VU1JVytyUWFFaGJ1aDZLZ25MNEd6?=
 =?utf-8?B?d3htNVN5My9TMVFDZWM2bWkwSTFRblBBOHFRdlF4OVRKV2tadUpYK3JBcUpr?=
 =?utf-8?Q?+Xxxq9wrRil7o=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee93cc91-b290-44cb-1e28-08d8b79ab0c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2021 08:10:28.9775 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gCGeK+ryDIhTnMQlX3IuotpruNvOQyKCGwdGo1xMGrAyswx4lcJFWjE0JPEAT083DabX6SkXZhbsPiQS7ckHOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4652
X-OriginatorOrg: intel.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "vivek.gautam@arm.com" <vivek.gautam@arm.com>,
 "guohanjun@huawei.com" <guohanjun@huawei.com>,
 "will@kernel.org" <will@kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "lenb@kernel.org" <lenb@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 David Woodhouse <dwmw2@infradead.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "linux-accelerators@lists.ozlabs.org" <linux-accelerators@lists.ozlabs.org>
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

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Wednesday, January 13, 2021 10:50 AM
> 
> Hi Jean,
> 
> On 1/12/21 5:16 PM, Jean-Philippe Brucker wrote:
> > Hi Baolu,
> >
> > On Tue, Jan 12, 2021 at 12:31:23PM +0800, Lu Baolu wrote:
> >> Hi Jean,
> >>
> >> On 1/8/21 10:52 PM, Jean-Philippe Brucker wrote:
> >>> Some devices manage I/O Page Faults (IOPF) themselves instead of
> relying
> >>> on PCIe PRI or Arm SMMU stall. Allow their drivers to enable SVA without
> >>> mandating IOMMU-managed IOPF. The other device drivers now need to
> first
> >>> enable IOMMU_DEV_FEAT_IOPF before enabling
> IOMMU_DEV_FEAT_SVA.
> >>>
> >>> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> >>> ---
> >>> Cc: Arnd Bergmann <arnd@arndb.de>
> >>> Cc: David Woodhouse <dwmw2@infradead.org>
> >>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >>> Cc: Joerg Roedel <joro@8bytes.org>
> >>> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> >>> Cc: Will Deacon <will@kernel.org>
> >>> Cc: Zhangfei Gao <zhangfei.gao@linaro.org>
> >>> Cc: Zhou Wang <wangzhou1@hisilicon.com>
> >>> ---
> >>>    include/linux/iommu.h | 20 +++++++++++++++++---
> >>>    1 file changed, 17 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> >>> index 583c734b2e87..701b2eeb0dc5 100644
> >>> --- a/include/linux/iommu.h
> >>> +++ b/include/linux/iommu.h
> >>> @@ -156,10 +156,24 @@ struct iommu_resv_region {
> >>>    	enum iommu_resv_type	type;
> >>>    };
> >>> -/* Per device IOMMU features */
> >>> +/**
> >>> + * enum iommu_dev_features - Per device IOMMU features
> >>> + * @IOMMU_DEV_FEAT_AUX: Auxiliary domain feature
> >>> + * @IOMMU_DEV_FEAT_SVA: Shared Virtual Addresses
> >>> + * @IOMMU_DEV_FEAT_IOPF: I/O Page Faults such as PRI or Stall.
> Generally using
> >>> + *			 %IOMMU_DEV_FEAT_SVA
> requires %IOMMU_DEV_FEAT_IOPF, but
> >>> + *			 some devices manage I/O Page Faults themselves
> instead
> >>> + *			 of relying on the IOMMU. When supported, this
> feature
> >>> + *			 must be enabled before and disabled after
> >>> + *			 %IOMMU_DEV_FEAT_SVA.
> >>
> >> Is this only for SVA? We may see more scenarios of using IOPF. For
> >> example, when passing through devices to user level, the user's pages
> >> could be managed dynamically instead of being allocated and pinned
> >> statically.
> >
> > Hm, isn't that precisely what SVA does?  I don't understand the
> > difference. That said FEAT_IOPF doesn't have to be only for SVA. It could
> > later be used as a prerequisite some another feature. For special cases
> > device drivers can always use the iommu_register_device_fault_handler()
> > API and handle faults themselves.
> 
>  From the perspective of IOMMU, there is a little difference between
> these two. For SVA, the page table is from CPU side, so IOMMU only needs
> to call handle_mm_fault(); For above pass-through case, the page table
> is from IOMMU side, so the device driver (probably VFIO) needs to
> register a fault handler and call iommu_map/unmap() to serve the page
> faults.
> 
> If we think about the nested mode (or dual-stage translation), it's more
> complicated since the kernel (probably VFIO) handles the second level
> page faults, while the first level page faults need to be delivered to
> user-level guest. Obviously, this hasn't been fully implemented in any
> IOMMU driver.
> 

Thinking more the confusion might come from the fact that we mixed
hardware capability with software capability. IOMMU_FEAT describes
the hardware capability. When FEAT_IOPF is set, it purely means whatever
page faults that are enabled by the software are routed through the IOMMU.
Nothing more. Then the software (IOMMU drivers) may choose to support
only limited faulting scenarios and then evolve to support more complex 
usages gradually. For example, the intel-iommu driver only supports 1st-level
fault (thus SVA) for now, while FEAT_IOPF as a separate feature may give the
impression that 2nd-level faults are also allowed. From this angle once we 
start to separate page fault from SVA, we may also need a way to report 
the software capability (e.g. a set of faulting categories) and also extend
iommu_register_device_fault_handler to allow specifying which 
category is enabled respectively. The example categories could be:

- IOPF_BIND, for page tables which are bound/linked to the IOMMU. 
Apply to bare metal SVA and guest SVA case;
- IOPF_MAP, for page tables which are managed through explicit IOMMU
map interfaces. Apply to removing VFIO pinning restriction;

Both categories can be enabled together in nested translation, with 
additional information provided to differentiate them in fault information.
Using paging/staging level doesn't make much sense as it's IOMMU driver's 
internal knowledge, e.g. VT-d driver plans to use 1st level for GPA if no 
nesting and then turn to 2nd level when nesting is enabled.

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
