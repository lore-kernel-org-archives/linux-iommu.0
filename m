Return-Path: <SRS0=mF+O=GX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A146C433DB
	for <iommu@archiver.kernel.org>; Wed, 20 Jan 2021 08:41:43 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2097225AA
	for <iommu@archiver.kernel.org>; Wed, 20 Jan 2021 08:41:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2097225AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4E310865CD;
	Wed, 20 Jan 2021 08:41:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z9ly2wBr11wx; Wed, 20 Jan 2021 08:41:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 81471861E6;
	Wed, 20 Jan 2021 08:41:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A079C08A1;
	Wed, 20 Jan 2021 08:41:41 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46962C013A
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 08:41:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 32DE885D92
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 08:41:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mORnGnSEZgz2 for <iommu@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 08:41:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 3E0A284922
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 08:41:39 +0000 (UTC)
IronPort-SDR: tFzucKoA3tjsrOEskuoksZvY7KB8zKTFdO3gFuoAExu33ulLAm6Qu9RUWOnuwnfuJW0Emk0egr
 Zr7u9HVAwJxw==
X-IronPort-AV: E=McAfee;i="6000,8403,9869"; a="175564474"
X-IronPort-AV: E=Sophos;i="5.79,360,1602572400"; d="scan'208";a="175564474"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jan 2021 00:41:38 -0800
IronPort-SDR: eVeQak58dLFu5tTrM2T2PAhYJghRA+i9slBo55vRe10oVmmj3c/YIdRsiaHRtpdv35Ru1vBbw+
 zK4MRfvQbgOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,360,1602572400"; d="scan'208";a="570052954"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orsmga005.jf.intel.com with ESMTP; 20 Jan 2021 00:41:37 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 20 Jan 2021 00:41:36 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 20 Jan 2021 00:41:36 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 20 Jan 2021 00:41:36 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 20 Jan 2021 00:41:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jaVr3WJVKfvixQpETY7fMDnIklMTs0JnvPGeNF1r5s3U3bG1GJnLimPO1NZA4Ue41yV0v7HgESZByqrR4Fk0SSNIr+w25Q0o0z9cv/8QkWXSqNtKM3MrQIt4TkDcwXJW35T/1m+ji7oVZKOeujRMBeyUOQ2hk7aLGfBQNDOPejYecIOqOBHBl/rhhahyoyXDUko+c2h23sE6R0jCPdDHw+++7ZqJTWG5pMCbJBMZvRyM05PYX+l1Sty5Z6/1XqRDbIqNUIFyuz4WTQYFs2GR3ENV12BwlIWKXhynRD+2cSks9NkkMzGtFGpAP7brwEDFjSaKULkF8EQtQgBAifSmIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8RAP7gidH1FAc0xurYKVQ8JmhMf4dppnSzzXbZgOLBU=;
 b=V47GC6dwt2UgWwvFM/9mENzawZBHTef2a5Qgqy5kHJ0CHqHjLmV00sz5bmuf+t90PhS5/BDrgWzfDK6GP2Aq80H32xT0R69Oznc9dtlt8vHSr0XVHgTV3u8FP9nKPzpE8T5I7V7NVI/E253baa35Sp1qcPOex/8+3W9mwLPhuJ1HGBX0HIWd3NeSYhuMG6P0sfCM3zxZSVm06IT21i9EOykpalkZr6swqBgjc1JBpzurE8EC/I1G30mQwFGEcz+vT7CQhEjcVSsFgye8C1sGZCQ+j4NVURWCPsDWRcnxbczoOTs3/ofPCtJtBa7m9bsydjWhgZBoMoqM0sdFwXaECg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8RAP7gidH1FAc0xurYKVQ8JmhMf4dppnSzzXbZgOLBU=;
 b=eYTWqkwyVPPBYlCcqX/BlxaBc7yS+PmqL4i1ca9+sRjHe/pg1gAVyMnVkTg0ps2NA/V58+UTWVefEQa38mAI7PnfeqLRyAE7yz6LB/ylg5ThnlB24pB+YCQ2ABHt2BMg5j9sdYzQiUFUw6NAsP8PHkCbHtEsUtY0Kv7I93TGL/A=
Received: from BN7PR11MB2786.namprd11.prod.outlook.com (2603:10b6:406:b3::27)
 by BN6PR1101MB2321.namprd11.prod.outlook.com (2603:10b6:404:91::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Wed, 20 Jan
 2021 08:41:33 +0000
Received: from BN7PR11MB2786.namprd11.prod.outlook.com
 ([fe80::2cc6:20a4:2078:d97c]) by BN7PR11MB2786.namprd11.prod.outlook.com
 ([fe80::2cc6:20a4:2078:d97c%7]) with mapi id 15.20.3763.014; Wed, 20 Jan 2021
 08:41:33 +0000
From: "Zhang, Tina" <tina.zhang@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: RE: [PATCH] iommu/vt-d: debugfs: Check irq_remapping_cap before PI
 info dump
Thread-Topic: [PATCH] iommu/vt-d: debugfs: Check irq_remapping_cap before PI
 info dump
Thread-Index: AQHW7kK1GsSaLHtYDUOFkJSsSuVI4qovzSEAgABjSDA=
Date: Wed, 20 Jan 2021 08:41:33 +0000
Message-ID: <BN7PR11MB278667C5A166460CE7CBBD4889A20@BN7PR11MB2786.namprd11.prod.outlook.com>
References: <20210119182526.2927-1-tina.zhang@intel.com>
 <d084772f-6364-34d9-1c89-e1c3d6a35301@linux.intel.com>
In-Reply-To: <d084772f-6364-34d9-1c89-e1c3d6a35301@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.202]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27bd1b7d-4d44-4237-db5a-08d8bd1f30c7
x-ms-traffictypediagnostic: BN6PR1101MB2321:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR1101MB23215D93362F630B1E9360BA89A29@BN6PR1101MB2321.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PKcmebVd/qxsXAQLDTdMXwHqPfk73D504hYhLCzy287LAIqQrl39M0AMrqAN04joTLMflb6SSXoBCd5dkkqPWKenVXHC9oZfehm5K2jk0u+Gy/SBbwX4dcV6tHGUMVdYtNGqKlxNQej45/cQ7dPhQdZUO8XEz/4+nQVZgw7jzCLNUACAp5StHAyxZBXbMWFzWkr8q2U2ztgEc8j8fsa8FIN0uyPGRUOv7PT2oNW4lxgR0Mfcddv8j0QDQJyIqpAhfYlFnEa3XfAFFgmlMWjc8w3ymUNbTxP3sSaDBWo2rVbpg/BBm9V1arKyzbiy5mp3bzJzJfOjtlkZz6hBNsMcDIeISKPyd/+8+aaMZ5cLINcliWCqroBp/GXhUG0+lth+8opogcF4AMibbHby+CrcQA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR11MB2786.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(86362001)(26005)(71200400001)(83380400001)(316002)(55016002)(8936002)(52536014)(6506007)(8676002)(66446008)(64756008)(9686003)(53546011)(6916009)(66556008)(186003)(66476007)(2906002)(66946007)(5660300002)(76116006)(4326008)(54906003)(478600001)(33656002)(7696005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?RjdrN1AxTUhTWEtDbGZCcmhiL1RKYjZ0WEZ3UHJoMytpY2tGYnk2ZmkrSDFB?=
 =?utf-8?B?VE9KRnQ1V1lDWkxvUHlMUXhhM3BpUzI0NzJpWlQwOFRsZFpYSU43eFc2ckt0?=
 =?utf-8?B?S2VMaG9TSE9qcEllWGNLNjc4VWNxamFNWE1JWnI1VE9wbWRvN01hNWN4MWFk?=
 =?utf-8?B?YkdVdGJ2Z0F2YkRCMkw3VG1LOUQ2NXBiM2M0VnFJSk1tdzhNUm5sOThZOFg2?=
 =?utf-8?B?MklPVC91ZThaRy9uUFUvNzNiZ2lrbE5jYy85dmNpMGFXVFdDck8vOW1NL3gz?=
 =?utf-8?B?SllGeWZ2dWZJZ0g0dnEzMVl0TGk5ZzdEQVd0cHMvV2hwRmdMa25EN3djMEt5?=
 =?utf-8?B?UXpHL2pBRGhiTXlkU1psZ05FcnVDMEhtdmVYd3FWZUpUeTdPUUdPcmNZMTEz?=
 =?utf-8?B?Wk9zSjBXNXJTQ1dYUUprU0Y4Nmh1KzhkNCsvZmtvVEZZbDYreG1xRjRJdU5i?=
 =?utf-8?B?VlJBOXJGa0ZNZXRTRHJPaHhlemNGWUhiSlFYVDUrRVN5K0tVMjlsWlhIeGpB?=
 =?utf-8?B?Y3BjSXRuVy92MnpIQTJRclRXWGxETzV5QXJvbENrbkVhclpSRFJHOURNbDg1?=
 =?utf-8?B?RGV2UlN3TE9lanh1RlFxc1crQ1VrMnJvSGtqeXpVaTRUNmFvOXc5TlhnQzhs?=
 =?utf-8?B?WE1wWW5EMitpQ2tTLytidi9uYUpLQVlPTXV0RS82a3BUOHdpaHJ6cDk0UEFO?=
 =?utf-8?B?NFpkWkkrcFVRQld3YUZHZENVZklWSEFXWExtUm9WVHBEMERMc0F5QTk5K083?=
 =?utf-8?B?TGRub2VKcmYwSmw4ZmM1Y1Q5eVRTY0JHSXNIbHJaMy9HVlc5N1J3c3hialJW?=
 =?utf-8?B?bnpHdmlOZlBmTmNyTTE4alZvOURpbE04dEtpRUZ1bnBiZEhOU3lRc3dva1Vr?=
 =?utf-8?B?bFJlNGxVZnM4c3JSTGh6L0Z0VW9IeG9jSXFWekV1UjYrVmp4aG1iTlo2RVRh?=
 =?utf-8?B?L3ZDVzV0VG5rRVVKVkJvbEFhc3ZvZjdJQmhRUVZoWVlKTGNqejErR1VPQkN4?=
 =?utf-8?B?cFlKM21XclNlOHdHdGZEVE5PNDJOdUVNNW41ekRxY1FjTm4xY3NEdFY4Tjh5?=
 =?utf-8?B?bGZvME1mc3Y0cTRqT3ByY1kvUEJkc2dFS0UwRzE1QTkwUkVpM2dZdWNuL0Jm?=
 =?utf-8?B?WFNkRGgvMVI1MkRPTWRPWGdkQW1Pa0pvMUlBZ3RkblQ1R1IzSnQxUUkzMkhB?=
 =?utf-8?B?RXU3Q3lHWG5jcEtnYXlhUlF1cWlJTzg4NTNuWXVILzl3RmdHV3dWdTMycWFR?=
 =?utf-8?B?ck5ydjhpN3hTbXRUSHBLTXcvR0swQmJnMlVxWGhHTGdpclNqRGY4aFJRdThE?=
 =?utf-8?Q?G06ReZBv6NCr4=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2786.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27bd1b7d-4d44-4237-db5a-08d8bd1f30c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2021 08:41:33.2265 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9M6MjgG8Owk30tSTtcrESjOBaZAJ5Thu07EAIn8RzpFwagxExy7amKSV/WQ3Fr/K1TIT6QQBtMcscdOsJvFfjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2321
X-OriginatorOrg: intel.com
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Sun,
 Yi" <yi.sun@intel.com>
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



> -----Original Message-----
> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Wednesday, January 20, 2021 10:35 AM
> To: Zhang, Tina <tina.zhang@intel.com>
> Cc: baolu.lu@linux.intel.com; iommu@lists.linux-foundation.org; Joerg
> Roedel <joro@8bytes.org>; Mehta, Sohil <sohil.mehta@intel.com>; Jacob
> Pan <jacob.jun.pan@linux.intel.com>; Sun, Yi <yi.sun@intel.com>
> Subject: Re: [PATCH] iommu/vt-d: debugfs: Check irq_remapping_cap before
> PI info dump
> 
> On 1/20/21 2:25 AM, Tina Zhang wrote:
> > irq_remapping_cap() was introduced to detect whether irq remapping
> > supports new features, such as VT-d Posted-Interrupts", according to
> > commit 959c870f7305 ("iommu, x86: Provide irq_remapping_cap()
> interface").
> >
> > The VT-d Posted-Interrupts support can be disabled by the command line
> > parameter "intremap=nopost".
> >
> > So, it's better to use irq_remapping_cap() to check if the VT-d
> > Posted-Interrupts is enabled before any Posted Interrupt Descriptor
> > info dump.
> >
> > Cc: Lu Baolu <baolu.lu@linux.intel.com>
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Cc: Sohil Mehta <sohil.mehta@intel.com>
> > Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Reported-by: Yi Sun <yi.sun@intel.com>
> > Signed-off-by: Tina Zhang <tina.zhang@intel.com>
> > ---
> >   drivers/iommu/intel/debugfs.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/intel/debugfs.c
> > b/drivers/iommu/intel/debugfs.c index efea7f02abd9..87a4a76866f4
> > 100644
> > --- a/drivers/iommu/intel/debugfs.c
> > +++ b/drivers/iommu/intel/debugfs.c
> > @@ -516,7 +516,8 @@ static int ir_translation_struct_show(struct seq_file
> *m, void *unused)
> >   	seq_puts(m, "****\n\n");
> >
> >   	for_each_active_iommu(iommu, drhd) {
> > -		if (!cap_pi_support(iommu->cap))
> > +		if (!irq_remapping_cap(IRQ_POSTING_CAP) ||
> > +		    !cap_pi_support(iommu->cap))
> 
> With irq_remapping_cap(IRQ_POSTING_CAP), do you still need
> cap_pi_support(iommu->cap)?

I guess yes. The "iommu->cap" value comes from the iommu reg. Current code seems to use cap_pi_suport() to check if the iommu hardware supports PI capability, meanwhile using irq_remapping_cap() to see if the vt-d PI support is enabled by user.

So, the problem here is if a user explicitly disables the vt-d PI support by "intremap=nopost", it would be very confused that the PI descriptor related info can still get dump.

Thanks,
Tina

> 
> >   			continue;
> >
> >   		seq_printf(m, "Posted Interrupt supported on
> IOMMU: %s\n",
> >
> 
> Best regards,
> baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
