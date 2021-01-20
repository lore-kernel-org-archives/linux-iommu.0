Return-Path: <SRS0=mF+O=GX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825B5C433DB
	for <iommu@archiver.kernel.org>; Wed, 20 Jan 2021 12:22:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C0DE221FB
	for <iommu@archiver.kernel.org>; Wed, 20 Jan 2021 12:22:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C0DE221FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9AC37870AF;
	Wed, 20 Jan 2021 12:22:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wRNMXG1NaXdm; Wed, 20 Jan 2021 12:22:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 82D70870A6;
	Wed, 20 Jan 2021 12:22:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 60F59C08A1;
	Wed, 20 Jan 2021 12:22:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37733C013A
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 12:22:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2E8C1848AA
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 12:22:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RarEaHfPJ666 for <iommu@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 12:22:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 8887F85F18
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 12:22:06 +0000 (UTC)
IronPort-SDR: ye0beLgorI9DA3njZou53pAkxXUppUPuqcqECilyMQHEzAv70wPcwBcPViNtLvFpxlJOnpvkFO
 uk0rVO+LiwCQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9869"; a="166758128"
X-IronPort-AV: E=Sophos;i="5.79,361,1602572400"; d="scan'208";a="166758128"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jan 2021 04:22:05 -0800
IronPort-SDR: OeEYx6Pqp4xnivgrLOs8xhzM7PBYhaEEd8xulrR7n6icr7ABqamX1ypW5N1K9sPjwOC17D9Cun
 4vk7kA/gxx8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,361,1602572400"; d="scan'208";a="426877888"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
 by orsmga001.jf.intel.com with ESMTP; 20 Jan 2021 04:22:05 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 20 Jan 2021 04:22:04 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 20 Jan 2021 04:22:04 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 20 Jan 2021 04:22:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kef0dkkjZJu5duG8hm94U8201BEXar9DuFSe9T9Pp2FY+GO1EhDqRuQ9/KCMSjKwUETg3Jc+iGQRKaPWKF127Y/SUvcCYT3kJp7EekP7mWaQ7Q+ZbP37XA/bwx61OSkXkVnnywHErrcNULs7npOxiTdeBjf5tz1KvjzqGc6o7DN+c423++w4HDFQIotgl/BbuxuGwiXxg4QYunMxU4fTV3pc4CcGI95dsBhgkcvVfeC1NC519Lbcl7krEW5y2vVOBRFrf+V/dUuhdP+n0WyALt5SXYIra30NfntdWfqwpKtpkEg1/AV56Bkr7vT6bY0PezeC6yL2phZSWbEJPaF3tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okqZ7vNp8aDh0sj8x2cDLVMCa1ggoKBoOBDk2Dd3M+g=;
 b=LZu/TGljrfAm5flZO3hKO4179IQOl+FfTbs3CDEu5MfHSFZFmIGhbNWv5yt+fDDixl117vixaKAmcS3Ps35F1uyJP70nT8Dgrq/TYOANLD/N6ruH26jJVdbwHiXy3pNjico/mhr0a6DXtomujVg6cRUUA5cYWjoWfTlUhaUl2YkRHtv8ULfYG3wgVo0DD3DjCRr0M2u4ttGyOK8xhgXH6BUVatREjXgC2dhDctDqv+o9UhLAOzhOLoCO5AYJ0rtP58HdTNyGg+Bb8yy1p2lMG8Gc4sVgzbyxsNVvzcfjmyVjbe9HITRre4FTzJJxGqhQZcj2tNR31x6K5a4Mx3cEgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okqZ7vNp8aDh0sj8x2cDLVMCa1ggoKBoOBDk2Dd3M+g=;
 b=yvtELZviqYYjA4Escvd4DxM90593FIwQbnbtAUgK9AgKlSEos/MUH34uQLxBM5prfKeWILIbQU1yaZ9ro5xnoaPN71Csqt5oYyn7jxEWwG3T6MExWQRowa6TN0zEGO1hyE5bcW92+yrmQB1zqP41iXCzJ5pOtN/YIHFN4Rf3ZB0=
Received: from BN7PR11MB2786.namprd11.prod.outlook.com (2603:10b6:406:b3::27)
 by BN6PR11MB2003.namprd11.prod.outlook.com (2603:10b6:404:46::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Wed, 20 Jan
 2021 12:21:59 +0000
Received: from BN7PR11MB2786.namprd11.prod.outlook.com
 ([fe80::2cc6:20a4:2078:d97c]) by BN7PR11MB2786.namprd11.prod.outlook.com
 ([fe80::2cc6:20a4:2078:d97c%7]) with mapi id 15.20.3763.014; Wed, 20 Jan 2021
 12:21:59 +0000
From: "Zhang, Tina" <tina.zhang@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: RE: [PATCH] iommu/vt-d: debugfs: Check irq_remapping_cap before PI
 info dump
Thread-Topic: [PATCH] iommu/vt-d: debugfs: Check irq_remapping_cap before PI
 info dump
Thread-Index: AQHW7kK1GsSaLHtYDUOFkJSsSuVI4qovzSEAgABjSDCAADRMgIAADFTQ
Date: Wed, 20 Jan 2021 12:21:59 +0000
Message-ID: <BN7PR11MB2786D8D26BF0788F5DE6B6FF89A20@BN7PR11MB2786.namprd11.prod.outlook.com>
References: <20210119182526.2927-1-tina.zhang@intel.com>
 <d084772f-6364-34d9-1c89-e1c3d6a35301@linux.intel.com>
 <BN7PR11MB278667C5A166460CE7CBBD4889A20@BN7PR11MB2786.namprd11.prod.outlook.com>
 <9edd348d-71ae-a061-4a98-8267941b449f@linux.intel.com>
In-Reply-To: <9edd348d-71ae-a061-4a98-8267941b449f@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [123.114.188.88]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a54a942b-d794-48b7-5353-08d8bd3dfc67
x-ms-traffictypediagnostic: BN6PR11MB2003:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB2003ABE9507B653A2E0A17E989A20@BN6PR11MB2003.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SrFmTw3fcxPD2nI1f8H6TUcnACs7ppKxQCc+oF5bWA+5IOwPhiZEj8bkDwPNHPKeM7XlOwiWYoPz3Sm9xnxkQzICa5EzSHMpHn2iC194fMg89vRroU3FlTzzMeSOfs8jrDIaEEOdRZhcOwBGvgDYc3yJ9eTTd38D5qtIkdIwSVAVkfOfDGCzYDmJ5SAB2EisQWEigw9+Ld76u0pcxTD8JGWJRoypafq2mjFS4B1idXRYKUj6xxtNQPSZl1QLIVT9YIY5qwCChmHpKI2KhD2XIsoNBgAwf+eSV3byZ62kIEsgqdSdgZm4MezE+fE+1qOU2ufgjBlqA7MRFxRZg47AGQr1KkbsZDi2fDtd8ankaEOBGp1eyFGMeHORjHSnPM0gGmlMm8ink3gKTpLxuNeeiPNH/6pLQT1EPM/VdAny8UNYgFZtVsUw94DaA5PeDjeg
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR11MB2786.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(6506007)(316002)(53546011)(54906003)(8676002)(9686003)(66446008)(66556008)(76116006)(33656002)(26005)(66946007)(66476007)(186003)(55016002)(4326008)(8936002)(478600001)(64756008)(86362001)(6916009)(83380400001)(52536014)(2906002)(71200400001)(5660300002)(7696005)(9126006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?cFV4aEtMaERlS3FkU2dVWjE1WDZGWTZrWGpwN3lJS29qUUtOYnBDak5jUjFI?=
 =?utf-8?B?akptaWVHSDhrejIyV1dqem5sWWxvQXpQdmhKem80by9MTDFZdHVnSG1MY2Iy?=
 =?utf-8?B?Z1ZZNzVIazRpOHRSTk9icWRTTjZrdFQ2S0lSTUkrNTJnT1hLUTI1dGdsSU5m?=
 =?utf-8?B?OFZiMEY3UUtGaitodHlXTk9WYWlzK0lmcnVWU25SQTBtZVQyL1dzMFFzVkVi?=
 =?utf-8?B?eHF2YjBLMFRqN0lBTnd0TDZYZkJMUFdtSkJ3OU92TGN4Qk1JYm8rZDBVY1pp?=
 =?utf-8?B?bzRMWXJla0NGMlNaNmJUbE0vd2p1YXpWK0RWV0kySFdGckh1QWJmdmdZcXRW?=
 =?utf-8?B?MTBrNUpBUWdvUk1VTnZnSERrelVqczBZMVZzcDVsZEwvSENPMVFLclBWUU5w?=
 =?utf-8?B?WitKMTRVTTdNUSthU1hhQlVXVU9KdGJZbmdBd0ttdzNlTXhyRS9ZZE9sbnVa?=
 =?utf-8?B?TFVsWVdrMm5BZmorcDhqZk1hT2N0QnEvUE9JckYxTzl4bFRCVWRMWDlBK2NJ?=
 =?utf-8?B?ZndvN0g3dHduMTkycHNHZXJMekthZmROVVhLODhMa24rQ1hRNGhQS2dQS2VG?=
 =?utf-8?B?RFhrb0FTK2J6UVFOZDFCYVl5djI3WTA5N1k5S0ZKaTNYeEZIb3RxdUkzZHpR?=
 =?utf-8?B?MnhCWUhmd2F6OTVZQ3lFK1p3VGpIeEpEQkx5eGwxbWExelJiTWtaNWxOdi92?=
 =?utf-8?B?T0tYMURQWEgvV0FTZGZaaHg4L0psMW5wa3FKazJRazRIUzNMb1R2RUgzZUQ4?=
 =?utf-8?B?UmVINkFhOU9ZOWwvNDRzclVUb0lZVzNhc3hycVEvUFV5bHdUcXNSc0t4K0F2?=
 =?utf-8?B?NDVzamVIN2wzN0Y5OXRoVUhwMnFaYnVhbWlHeExTM2hGa3NVYW5iTm9ycGFv?=
 =?utf-8?B?SzFyQklRek1oa01zK1VaWVAzejBGcUs5TmpNMXJLbkljVUVhWVlYbFFCVk5w?=
 =?utf-8?B?VmVvbm12SnF2blpsY0Y0am91VWVIeGltdHVlb2hmK2Nlbm1ZMGdOdHpVL3o3?=
 =?utf-8?B?aFZyQWZaeVY1b0daQlFpMlVBdkRHeHNBNkN5VGVhZm9QaG96QWhvNHZqL1Bp?=
 =?utf-8?B?TGtPamhRY2hmSWZCcDdBSUZxaC84dlQwK2tlTjI0OVRxNk0zU0NWZkZTRVZ2?=
 =?utf-8?B?SVZ6cHFuYTdOWWcwS0RIWmxuY1NtNVJ0S2RWaW5selJmb0U1aDAwdDZ3T1dY?=
 =?utf-8?B?VUJTQXRONFFQQUJFNnJUOGVObjRTRktNNzYvR2ZudnpHN1E3Z3VlQWJGb2xo?=
 =?utf-8?B?MGZIYnprTW1ISW1keUMyRVI2bXdpdkpvU093TWt1ZmcweHdZQTFjQzNreGkx?=
 =?utf-8?Q?TPamLGTZPhyhY=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2786.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a54a942b-d794-48b7-5353-08d8bd3dfc67
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2021 12:21:59.6560 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lcLADAKgjba2ackVOAvehhpbE4kJflhfU1aAvNXvOHR+4shfbgb6ZRZNh5wuk4MYZbi2x8ZBmRssafMDGYQeQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB2003
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
> Sent: Wednesday, January 20, 2021 7:37 PM
> To: Zhang, Tina <tina.zhang@intel.com>
> Cc: baolu.lu@linux.intel.com; iommu@lists.linux-foundation.org; Joerg
> Roedel <joro@8bytes.org>; Mehta, Sohil <sohil.mehta@intel.com>; Jacob
> Pan <jacob.jun.pan@linux.intel.com>; Sun, Yi <yi.sun@intel.com>
> Subject: Re: [PATCH] iommu/vt-d: debugfs: Check irq_remapping_cap before
> PI info dump
> 
> On 2021/1/20 16:41, Zhang, Tina wrote:
> >
> >
> >> -----Original Message-----
> >> From: Lu Baolu <baolu.lu@linux.intel.com>
> >> Sent: Wednesday, January 20, 2021 10:35 AM
> >> To: Zhang, Tina <tina.zhang@intel.com>
> >> Cc: baolu.lu@linux.intel.com; iommu@lists.linux-foundation.org; Joerg
> >> Roedel <joro@8bytes.org>; Mehta, Sohil <sohil.mehta@intel.com>; Jacob
> >> Pan <jacob.jun.pan@linux.intel.com>; Sun, Yi <yi.sun@intel.com>
> >> Subject: Re: [PATCH] iommu/vt-d: debugfs: Check irq_remapping_cap
> >> before PI info dump
> >>
> >> On 1/20/21 2:25 AM, Tina Zhang wrote:
> >>> irq_remapping_cap() was introduced to detect whether irq remapping
> >>> supports new features, such as VT-d Posted-Interrupts", according to
> >>> commit 959c870f7305 ("iommu, x86: Provide irq_remapping_cap()
> >> interface").
> >>>
> >>> The VT-d Posted-Interrupts support can be disabled by the command
> >>> line parameter "intremap=nopost".
> >>>
> >>> So, it's better to use irq_remapping_cap() to check if the VT-d
> >>> Posted-Interrupts is enabled before any Posted Interrupt Descriptor
> >>> info dump.
> >>>
> >>> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> >>> Cc: Joerg Roedel <joro@8bytes.org>
> >>> Cc: Sohil Mehta <sohil.mehta@intel.com>
> >>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> >>> Reported-by: Yi Sun <yi.sun@intel.com>
> >>> Signed-off-by: Tina Zhang <tina.zhang@intel.com>
> >>> ---
> >>>    drivers/iommu/intel/debugfs.c | 3 ++-
> >>>    1 file changed, 2 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/iommu/intel/debugfs.c
> >>> b/drivers/iommu/intel/debugfs.c index efea7f02abd9..87a4a76866f4
> >>> 100644
> >>> --- a/drivers/iommu/intel/debugfs.c
> >>> +++ b/drivers/iommu/intel/debugfs.c
> >>> @@ -516,7 +516,8 @@ static int ir_translation_struct_show(struct
> >>> seq_file
> >> *m, void *unused)
> >>>    	seq_puts(m, "****\n\n");
> >>>
> >>>    	for_each_active_iommu(iommu, drhd) {
> >>> -		if (!cap_pi_support(iommu->cap))
> >>> +		if (!irq_remapping_cap(IRQ_POSTING_CAP) ||
> >>> +		    !cap_pi_support(iommu->cap))
> >>
> >> With irq_remapping_cap(IRQ_POSTING_CAP), do you still need
> >> cap_pi_support(iommu->cap)?
> >
> > I guess yes. The "iommu->cap" value comes from the iommu reg. Current
> code seems to use cap_pi_suport() to check if the iommu hardware supports
> PI capability, meanwhile using irq_remapping_cap() to see if the vt-d PI
> support is enabled by user.
> >
> > So, the problem here is if a user explicitly disables the vt-d PI support by
> "intremap=nopost", it would be very confused that the PI descriptor related
> info can still get dump.
> 
> I don't worry about dump hardware data even it's not enabled. But I do care
> that the table is not allocated (due to not enabled) but the code still tries to
> dump it, hence result in some kinds of NULL pointer or wild pointer
> referencing.

Oh, I see.

BR,
Tina
> 
> Best regards,
> baolu
> 
> >
> > Thanks,
> > Tina
> >
> >>
> >>>    			continue;
> >>>
> >>>    		seq_printf(m, "Posted Interrupt supported on
> >> IOMMU: %s\n",
> >>>
> >>
> >> Best regards,
> >> baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
