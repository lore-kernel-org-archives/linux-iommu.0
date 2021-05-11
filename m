Return-Path: <SRS0=AxcK=KG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0643C43461
	for <iommu@archiver.kernel.org>; Tue, 11 May 2021 09:10:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 708586192B
	for <iommu@archiver.kernel.org>; Tue, 11 May 2021 09:10:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 708586192B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 28887841FD;
	Tue, 11 May 2021 09:10:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r20URT0Mb_gT; Tue, 11 May 2021 09:10:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id CA5A98419A;
	Tue, 11 May 2021 09:10:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A0766C000D;
	Tue, 11 May 2021 09:10:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C42C9C0001
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 09:10:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A317C403D1
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 09:10:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m2ABbHYPmfzC for <iommu@lists.linux-foundation.org>;
 Tue, 11 May 2021 09:10:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1EC84403BC
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 09:10:07 +0000 (UTC)
IronPort-SDR: DmgJ5ERn+Nznk8yiwtAa0B+mnyh4BC3OFlpY1/rJfAn78aVVf0XMMMXVQWvje2UKeG2TQXKD0A
 Je1peLp+zTZw==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="196301082"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; d="scan'208";a="196301082"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2021 02:10:07 -0700
IronPort-SDR: S7hcPfWeHpeAkvDz8veKFTB55Rin6BWBgCIax7w8aN3qurKRZOsYgGFUFFkWKdJZKLmBqW31cc
 exk1Co8TnD3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; d="scan'208";a="624624832"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
 by fmsmga005.fm.intel.com with ESMTP; 11 May 2021 02:10:07 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 11 May 2021 02:10:06 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 11 May 2021 02:10:06 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Tue, 11 May 2021 02:10:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQgOr5FuD7x5DKsHQN6GAcLDy1hhevtcsEADwURfgIykFyGmr20iwF2xzkV3PZ8sj6zOxe4nt72AUZ4SQwE+EVjZKp7w/1A8c/FiyYFKbnCn4z74RryFXWcQkMrCaMloTYWs0dwmg5P7wJ2Btt+RcQ8UcV83I5/2+vCdY93o2/f0TQjb8kQoK6oDF4WiqW/hNJfpGQg7+aln0kSG4n6Eqwu7kcas3f0DVSPWRPtweOhOisYUYGjP9e36VwGDOqw8tlkWgmBOYD1anZTvuwJ3GsDIkIxOqG1PAt9v9LX8OEkBDEmhEXg28fYX5WZnuEoKZJ9JOk017Ovk8oQUv/58AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ry7toOJ219gcXsK/gZLY3pxGSnprkLFqVd1XYoF+5+I=;
 b=its1VW6CmXCVmfkZfrkB9tznWalAXjE+UthZMrMOgKGE9K2/qMivZ5qfTCz2i/zgjTCh6Ap2NvM4zER4q0wYC2mNuVva/T/apqj2TGRaujgPCHBCSzbqNDiXmKOQ0fy+NvJa+XcbdiEoXgwwM0DOEkr6YSInHlgdc2kSOs9zD+7mxME21ftwFiiPxZJdBnqtq1nMQd4GvNMiA5rPlD7ha4Tu6/Mq8do3LKTID03t9l09PfsWbBaK+rlNPjVTgJmTqidlm6Fd2ITLguMnjjNRo6PZcOrtZUTAHUXCBr7lc/zzp4aIffB7fhYhGeyxa3HrMZ0PF2jWtr1Jm6QlmLjI7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ry7toOJ219gcXsK/gZLY3pxGSnprkLFqVd1XYoF+5+I=;
 b=T8GtLyq95awciJXYhHkD4Jzk8KflKR1u2JbYdZxPuPbWwj3vw663VEodFL8nk13M0a8Gj65JNvAd3mo8hpFAc6a/MDNvPYSr+AoBdjLxSwbWxLER0y4VjOqU6ziPI+D81ilnHVmSCHyT3Qo15KdnVEd91dbi6G2OMXYULTJfEz4=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24; Tue, 11 May
 2021 09:10:03 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29%9]) with mapi id 15.20.4108.032; Tue, 11 May 2021
 09:10:03 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and allocation
 APIs
Thread-Topic: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Thread-Index: AQHXDZub0CDG82VGXUmLEYgvMuPs4KqKkLIAgACg94CAAC72gIAAD04AgAADogCAAErUgIAETQEAgAOaswCAB7C3gIAAhxQwgADYDACAATCSAIAAVGMAgAELsQCAACiXgIAAVBgAgAAaMwCAAAESAIAABy2AgAAgOYCAFdCAgIAAppUAgADsNgCAACqygIAHsmaAgAAzsYCAAAjdgIAAD/yAgAAcQgCAADqggIAAk6nQgABIUACAASsnkIAAYWwAgALs9qCAAdeZgIACip7wgAo7TwCAACbZAIAARiUAgAARxQCAAS/XgIAACnOAgAAiwQCAAL24AIAAVNoAgABEgACAAo33AIADeaeAgAESCjA=
Date: Tue, 11 May 2021 09:10:03 +0000
Message-ID: <MWHPR11MB1886E22D03B14EE0D5725CE08C539@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <20210504180050.GB1370958@nvidia.com>
 <20210504151154.02908c63@jacob-builder> <20210504231530.GE1370958@nvidia.com>
 <20210505102259.044cafdf@jacob-builder> <20210505180023.GJ1370958@nvidia.com>
 <20210505130446.3ee2fccd@jacob-builder> <YJOZhPGheTSlHtQc@myrica>
 <20210506122730.GQ1370958@nvidia.com> <20210506163240.GA9058@otc-nc-03>
 <MWHPR11MB188698FBEE62AF1313E0F7AC8C569@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210510123729.GA1002214@nvidia.com>
In-Reply-To: <20210510123729.GA1002214@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.218]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd26b662-8918-4423-01e5-08d9145c9017
x-ms-traffictypediagnostic: CO1PR11MB5089:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB50892A692D625E62F94B74128C539@CO1PR11MB5089.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LPJgvjFztkyy6dyHDFWXgHYbw9fiqBs+SsK0yHHd7SY4HddEUgGpDtwL7okLu3LSfazAH3liQ6xcIGlG6F3vR96ATLXgkvWgi6//LNrE7IjztjWykknL/GZxNnwYsC5WHpQdtO7L8YD2IBTAEpk7pga5GS+DX6P9brjUV/hFytZUhJRrSUytBYGH5E5LY5t5m+dQ15iVZ7+n3b1XFzzfKU4oltGuKRZy2F+zMereOR6qosdrUj9UCES/4DudAJUobVm/8YUykT/6VNdBHoJ1pooAQoMvHapCRCbOUw0QjH2WACSkIoz2xIz6hLAzzOln3I5Zwu9rGWnsEMV5WKuQg41FhrkenxfvvCF/tc0ULZqKk0nDgCkxZ0BUCXjOn6htUd9zJFaU0OmatrYBYKOllbjbCP5Xk4BCVyH3Rr1C7y/LfJTE6lddigJLbQiX8sVq6AUffnJ/MEUMwjtG6pH9d6g9/Tdz1RaUXK0Z34eiLJfBzf5+7TXcnDGFmyJfCNi3oumld12H2E2v7OQWBm+XBhkNWN9i6vjEZhEr8vd7Tm/XXpIIjdiRrIqPsWiUsxeSpURJq53mta7RpX4y6IaiB/UaAfxG3/gPGMBSgpCIAeE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1886.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(346002)(376002)(396003)(39860400002)(366004)(8676002)(7696005)(86362001)(8936002)(122000001)(4326008)(38100700002)(33656002)(64756008)(66476007)(6506007)(52536014)(478600001)(9686003)(186003)(54906003)(6916009)(316002)(66446008)(2906002)(71200400001)(83380400001)(55016002)(5660300002)(76116006)(66946007)(7416002)(26005)(66556008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ku/iVwYE1XaBycwEP02GhUHvkqzYaEK5QVRUTKj6dRKQ51kEuSEo3hJVXMH7?=
 =?us-ascii?Q?SLa9b8Mgxd3EN14jgyKhILtF1U/ChnnWPtPAyeX7saOiW8UiGriTNjYmJjqS?=
 =?us-ascii?Q?8WngqP22gZEG3atoDJlNKeAHWDAf8itRyRnEQYVivTwC8rjgzDc0+RgH81MW?=
 =?us-ascii?Q?mMTzTIBLr896K+9h8ycRwuE0gGPA9uXsFYnV7/+uCKVR+ihe5epWsfLqHQOx?=
 =?us-ascii?Q?cFYs824mOiZeSM+4pZEBwmlnO6gVk/xD3UKfTsmtmjYD4QKmxRmLZlTnRMAJ?=
 =?us-ascii?Q?4WDee3RPAttvk1eQZtFHkG2D8vs4GxQtxjnsYUAFlziI1pFTfk2QLM1VArWc?=
 =?us-ascii?Q?gTN/puq6gu4e4CNHWeDpzSOUEoHJIaFlLEM/ElLg67iIBHWYs7pXqcan2rPy?=
 =?us-ascii?Q?UklgAFEGR/uSthmXijPLga2JdDhG5KVJdohf83mODqaPz2F6lPaO0c85HzSy?=
 =?us-ascii?Q?6UumVZ47BesoWBhaxHag6t1mSoiQpM310PjLRp/uIwSDVnu/rRLj40yJ26/p?=
 =?us-ascii?Q?F5cqb54iK2TEl0qWT/ITTvWD+W6dtnyq1wVrk6p1joD5mCo9/OiXLc+o9nmU?=
 =?us-ascii?Q?NbhdJrnglgzW44D7FxSxDg/F4EyVbuJNW8lLJMiVwtmeLa5Z1Id2fT3WzX/W?=
 =?us-ascii?Q?+lUnUhm2HrzkAvnX0B4lfw/kVow092p4wj6mMWn/dI4Hehx5HzBxiTDcJnYh?=
 =?us-ascii?Q?7BuTtpqKvbuZ6vSwJ1b/4WgatLsv4r53XK0pM0bAIbolx6aNRooq9m4muY6E?=
 =?us-ascii?Q?Fbwh6zPKI6bdS/1xASq7/nq/IMHbwMbQxbtNBDctHwcd1852eyRrAwh7BN2t?=
 =?us-ascii?Q?xqjatjEILGZTka7j/g7GqQ8rfthE+DnWdB0g788qnX8Xcw/VG0yNdxb7G2Br?=
 =?us-ascii?Q?AZDg4FW7IyAyq0jwoqEcWVX+nBlZHN4dYk1PRB93d/epx0Ql5cv8UuCvUgTG?=
 =?us-ascii?Q?QOfqDSzQyK5fcvpBgRkpLpFdhKkaTw5KLdT7r2IaFDodhZn4gUV+Lr3qAMAt?=
 =?us-ascii?Q?Dx+tiS4zyZUofoEko6T4rqb5TnaN69Ba9AOn7cU4T1zf91KB4XxI7xZDUbAH?=
 =?us-ascii?Q?dCqChfrUAYOWmP5Ya1lk4jRg8L0acYLYHVoT/dgMiUaqOqkg7JJycpP+O+c9?=
 =?us-ascii?Q?Q7Lqk1XlskotpoHDnzNUELBp9GUZxYCgwFk39oNTSuzsZaIAKFCHZH23CJbl?=
 =?us-ascii?Q?iMRt8EI7cJKdrA2aYHWfXhWfbjT7Ki1UOwaVi5/+hxYBjrPSnsHKIOxJSMSq?=
 =?us-ascii?Q?b7jJfdlUeLtxCSnY3OPUHPg5Nm8/tlflsWjMn1KSlg7OoainZPz24Ql6o5L2?=
 =?us-ascii?Q?aU5NdNBTxtnU5LebFwZaGmrh?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd26b662-8918-4423-01e5-08d9145c9017
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2021 09:10:03.5340 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N6L/6TSkfPSwP8uSFAEWNHxUSE+XyYpQAaGnfbGKRagBe5TQCZj/sThhS9ulFz/QI9v4KyjnMemgRkYtbgwYgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5089
X-OriginatorOrg: intel.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, David Woodhouse <dwmw2@infradead.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Li Zefan <lizefan@huawei.com>, Alex
 Williamson <alex.williamson@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Tejun Heo <tj@kernel.org>, "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
 Jean-Philippe
 Brucker <jean-philippe@linaro.com>, "Wu, Hao" <hao.wu@intel.com>
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

> From: Jason Gunthorpe
> Sent: Monday, May 10, 2021 8:37 PM
> 
[...] 
> > gPASID!=hPASID has a problem when assigning a physical device which
> > supports both shared work queue (ENQCMD with PASID in MSR)
> > and dedicated work queue (PASID in device register) to a guest
> > process which is associated to a gPASID. Say the host kernel has setup
> > the hPASID entry with nested translation though /dev/ioasid. For
> > shared work queue the CPU is configured to translate gPASID in MSR
> > into **hPASID** before the payload goes out to the wire. However
> > for dedicated work queue the device MMIO register is directly mapped
> > to and programmed by the guest, thus containing a **gPASID** value
> > implying DMA requests through this interface will hit IOMMU faults
> > due to invalid gPASID entry. Having gPASID==hPASID is a simple
> > workaround here. mdev doesn't have this problem because the
> > PASID register is in emulated control-path thus can be translated
> > to hPASID manually by mdev driver.
> 
> This all must be explicit too.
> 
> If a PASID is allocated and it is going to be used with ENQCMD then
> everything needs to know it is actually quite different than a PASID
> that was allocated to be used with a normal SRIOV device, for
> instance.
> 
> The former case can accept that the guest PASID is virtualized, while
> the lattter can not.
> 
> This is also why PASID per RID has to be an option. When I assign a
> full SRIOV function to the guest then that entire RID space needs to
> also be assigned to the guest. Upon migration I need to take all the
> physical PASIDs and rebuild them in another hypervisor exactly as is.
> 
> If you force all RIDs into a global PASID pool then normal SRIOV
> migration w/PASID becomes impossible. ie ENQCMD breaks everything else
> that should work.
> 
> This is why you need to sort all this out and why it feels like some
> of the specs here have been mis-designed.
> 
> I'm not sure carving out ranges is really workable for migration.
> 
> I think the real answer is to carve out entire RIDs as being in the
> global pool or not. Then the ENQCMD HW can be bundled together and
> everything else can live in the natural PASID per RID world.
> 

OK. Here is the revised scheme by making it explicitly.

There are three scenarios to be considered:

1) SR-IOV (AMD/ARM):
	- "PASID per RID" with guest-allocated PASIDs;
	- PASID table managed by guest (in GPA space);
	- the entire PASID space delegated to guest;
	- no need to explicitly register guest-allocated PASIDs to host;
	- uAPI for attaching PASID table:

    // set to "PASID per RID"
    ioctl(ioasid_fd, IOASID_SET_HWID_MODE, IOASID_HWID_LOCAL);

    // When Qemu captures a new PASID table through vIOMMU;
    pasidtbl_ioasid = ioctl(ioasid_fd, IOASID_ALLOC);
    ioctl(device_fd, VFIO_ATTACH_IOASID, pasidtbl_ioasid);

    // Set the PASID table to the RID associated with pasidtbl_ioasid;
    ioctl(ioasid_fd, IOASID_SET_PASID_TABLE, pasidtbl_ioasid, gpa_addr);

2) SR-IOV, no ENQCMD (Intel):
	- "PASID per RID" with guest-allocated PASIDs;
	- PASID table managed by host (in HPA space);
	- the entire PASID space delegated to guest too;
	- host must be explicitly notified for guest-allocated PASIDs;
	- uAPI for binding user-allocated PASIDs:

    // set to "PASID per RID"
    ioctl(ioasid_fd, IOASID_SET_HWID_MODE, IOASID_HWID_LOCAL);

    // When Qemu captures a new PASID allocated through vIOMMU;
    pgtbl_ioasid = ioctl(ioasid_fd, IOASID_ALLOC);
    ioctl(device_fd, VFIO_ATTACH_IOASID, pgtbl_ioasid);

    // Tell the kernel to associate pasid to pgtbl_ioasid in internal structure;
    // &pasid being a pointer due to a requirement in scenario-3
    ioctl(ioasid_fd, IOASID_SET_HWID, pgtbl_ioasid, &pasid);

    // Set guest page table to the RID+pasid associated to pgtbl_ioasid
    ioctl(ioasid_fd, IOASID_BIND_PGTABLE, pgtbl_ioasid, gpa_addr);

3) SRIOV, ENQCMD (Intel):
	- "PASID global" with host-allocated PASIDs;
	- PASID table managed by host (in HPA space);
	- all RIDs bound to this ioasid_fd use the global pool;
	- however, exposing global PASID into guest breaks migration;
	- hybrid scheme: split local PASID range and global PASID range;
	- force guest to use only local PASID range (through vIOMMU);
	- for ENQCMD, configure CPU to translate local->global;
	- for non-ENQCMD, setup both local/global pasid entries;
	- uAPI for range split and CPU pasid mapping:

    // set to "PASID global"
    ioctl(ioasid_fd, IOASID_SET_HWID_MODE, IOASID_HWID_GLOBAL);

    // split local/global range, applying to all RIDs in this fd
    // Example: local [0, 1024), global [1024, max)
    // local PASID range is managed by guest and migrated as VM state
    // global PASIDs are re-allocated and mapped to local PASIDs post migration
    ioctl(ioasid_fd, IOASID_HWID_SET_GLOBAL_MIN, 1024);

    // When Qemu captures a new local_pasid allocated through vIOMMU;
    pgtbl_ioasid = ioctl(ioasid_fd, IOASID_ALLOC);
    ioctl(device_fd, VFIO_ATTACH_IOASID, pgtbl_ioasid);

    // Tell the kernel to associate local_pasid to pgtbl_ioasid in internal structure;
    // Due to HWID_GLOBAL, the kernel also allocates a global_pasid from the
    // global pool. From now on, every hwid related operations must be applied
    // to both PASIDs for this page table;
    // global_pasid is returned to userspace in the same field as local_pasid;
    ioctl(ioasid_fd, IOASID_SET_HWID, pgtbl_ioasid, &local_pasid);

    // Qemu then registers local_pasid/global_pasid pair to KVM for setting up
    // CPU PASID translation table;
    ioctl(kvm_fd, KVM_SET_PASID_MAPPING, local_pasid, global_pasid);

    // Set guest page table to the RID+{local_pasid, global_pasid} associated 
    // to pgtbl_ioasid;
    ioctl(ioasid_fd, IOASID_BIND_PGTABLE, pgtbl_ioasid, gpa_addr);

-----
Notes:

I tried to keep common commands in generic format for all scenarios, while
introducing new commands for usage-specific requirement. Everything is
made explicit now. 

The userspace has sufficient information to choose its desired scheme based 
on vIOMMU types and platform information (e.g. whether ENQCMD is exposed 
in virtual CPUID, whether assigned devices support DMWr, etc.). 

Above example assumes one RID per bound page table, because vIOMMU
identifies new guest page tables per-RID. If there are other usages requiring
multiple RIDs per page table, SET_HWID/BIND_PGTABLE could accept
another device_handle parameter to specify which RID is targeted for this
operation.

When considering SIOV/mdev there is no change to above uAPI sequence. 
It's n/a for 1) as SIOV requires PASID table in HPA space, nor does it
cause any change to 3) regarding to the split range scheme. The only
 conceptual change is in 2), where although it's still "PASID per RID" the 
PASIDs must be managed by host because the parent driver also allocates 
PASIDs from per-RID space to mark mdev (RID+PASID). But this difference 
doesn't change the uAPI flow - just treat user-provisioned PASID as 'virtual' 
and then allocate a 'real' PASID at IOASID_SET_HWID. Later always use the 
real one when programming PASID entry (IOASID_BIND_PGTABLE) or device 
PASID register (converted in the mediation path).

If all above can work reasonably, we even don't need the special VCMD 
interface in VT-d for guest to allocate PASIDs from host. Just always let
the guest to manage its PASIDs (with restriction of available local PASIDs),
being a global allocator or per-RID allocator. the vIOMMU side just stick
to the per-RID emulation according to the spec. 

Thanks
Kevin

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
