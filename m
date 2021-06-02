Return-Path: <SRS0=kThj=K4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EBA5C47083
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 12:42:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C575C613DC
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 12:42:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C575C613DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8AF3060AAC;
	Wed,  2 Jun 2021 12:42:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B7CraLN1wOFC; Wed,  2 Jun 2021 12:42:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2DF156067D;
	Wed,  2 Jun 2021 12:42:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A1D7C000E;
	Wed,  2 Jun 2021 12:42:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 801A7C0001
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 12:42:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6BA8C40473
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 12:42:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9nLKK6K8k9vP for <iommu@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 12:42:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::60c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 16B7D40456
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 12:42:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iGFR6iCrp/SasabG+JiVnzqMlxY0FXLpfsiTIr72D1QTtLHT2EO7Mk1CEcO+g/UURC3eQUcYC5OWLKcYT7+rCGHHvYXOQ9WNA8Fp9Zd082EQQzICMlSsrr8WRK6B/G53WEpvDBNHQvbr8/m5cppXDKjMswybH3nsHMifRMGNDRIcu3nF4Qeau5LdiUwLHgZQZ2Ah77wXiT39oVxnpdV/SqZVP8gboq+LFK+ejpgg+WDRzvNes7B6A6lwMzd/+j0V4tKFrBGbKnyBJ9/Smozfr+yXlUmh7gtUHSZDOoPqKoYsnz0wVcqYrNQdeUNlyIdFAWRRjsLq6JrFmX764/tCAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MURESkbkVTCGUX5fWbhTmrfUQm4bFedTrJN/uKtGY8c=;
 b=mxKH9mfspfII3T5olrl666N6WgYjeqxWSeefiqGUHo39yy5Wh/XD8pKI/5KZ7NFztB5H7Mt/TQx8EEXRyfaWqRLNwSrII3WfpHeRI1S9i7XDJB2+ixZGY5uOWbzAAsM90vp4VodPyXXvWBke0HvI1j6mcK+wsHN7gCmFy4DKUWUrHQoVnDuFgATGXZ8rJ8TL1jIeMGtrKi6QhmchjLyqGXS/VsEjEnIiLqUOfVGGhKipxGuHkvNq11woRSuPZBXIK/XofSa8j3nswkEEhakw5my3PMK+dBLOoVcKtqRuwHF0rZCkyRnMjuIkNnBPBqqrT0zs6byX2WoNlIZn7AIQQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MURESkbkVTCGUX5fWbhTmrfUQm4bFedTrJN/uKtGY8c=;
 b=erE6JlAkMw13kKkvCj2CkBOuIFGs699kI7rslvMJWHLzfInKxkd7Wf5JEyBsTlMiK6aOoJU1VlKxS1pX28hIwO9hJPPTPcIn7DG59LTuyZzdbC+SLTUGhpxVre8zshRxwVsTW5x8GrDJ5hls1VgeRqd507gYF+iSvf5t+gzbDcrlCEjDub2L9Gv8xa9GFdtgdKbyiXgEn/SYFAkTpXBrhqVuf0hO++wmikmMPXS855LLijtjQg5A0UZ1PASLMrHCzmASQYWL5Iriw9ahSnoa869+2+Ft0aHQh/ChxU1hX2zrXQ3Gua+AlspFpQanzGpydaAli5KJvAXcKUBh8jn8GA==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5401.namprd12.prod.outlook.com (2603:10b6:510:d4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 2 Jun
 2021 12:41:58 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::b0d9:bff5:2fbf:b344]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::b0d9:bff5:2fbf:b344%6]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 12:41:58 +0000
From: Parav Pandit <parav@nvidia.com>
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>, "Tian, Kevin"
 <kevin.tian@intel.com>, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel
 <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>, Lu Baolu
 <baolu.lu@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Alex Williamson
 (alex.williamson@redhat.com)" <alex.williamson@redhat.com>, Jason Wang
 <jasowang@redhat.com>
Subject: RE: [RFC] /dev/ioasid uAPI proposal
Thread-Topic: [RFC] /dev/ioasid uAPI proposal
Thread-Index: AddSzQ970oLnVHLeQca/ysPD8zMJZwDdOxjAAFIuqoAACAmcgA==
Date: Wed, 2 Jun 2021 12:41:58 +0000
Message-ID: <PH0PR12MB5481F4C360C09B8697D3B595DC3D9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <PH0PR12MB5481C1B2249615257A461EEDDC3F9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <06892e6a-02c9-6c25-84eb-6a4b2177b48d@metux.net>
In-Reply-To: <06892e6a-02c9-6c25-84eb-6a4b2177b48d@metux.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: metux.net; dkim=none (message not signed)
 header.d=none;metux.net; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [49.207.220.117]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0f5b561-a867-4257-b96f-08d925c3cfab
x-ms-traffictypediagnostic: PH0PR12MB5401:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR12MB54013215A4558E8D46676639DC3D9@PH0PR12MB5401.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hRSitfUtzrNdEx4ENuwftPZMHBiNBsgp3O5TI9ByCgo1TmQMTeVXGDjhgazM/8cdv+ACR7Wu64uuBs+ykdt5x10QbHO/n4WD4GZ2CxG3Zk/Mu8Vx1G9CsFTnc5AB3zhR2kpAqrSsx8mthB/Vq8wKSu7aTz5iU/CURX+cPYIlBHUiA4PCLSswOwVShoAq8RT6qD+G6OpryAY5QZf2zQT9iWJyrwoqfqol+NlwafEDB9FBfjgeupFgiGmu3r+wQe3wkyxy6FwE1kSnikF96O7EbbtNg/ZWIpK+9qp2a5SzxKUwOf8r9lnIIm3HVr/NaZRZtk9wDb4lwQMVNNhGMYClT/cFjbOfgh4uKD7DnsQt9/Z1lk2MUPO2y9jMHGfde+zj5qQyWXxTkMd0kiKa0fwX6VMUxo9IVwKILW7JNxbY/OPOvDZU1NNMiBUPGVwCkzAqge9p5ksSfUUkc//Q91AcWS+Yya9lK+4goo7swKF24Gbgn4mbCSuwhdyvcG9jYwK4bi0CqbD/AtyQFVbBjUFwmv7vLNxEUwUEoPSKOfjPzPLrtpy8bDMxhiaeruYxN+Hf3E4KoGr0svQbiwp3ZCjtfDIH9+gJuGr1MdBtznorsuE54Qa09p9tNBD4w2FUpW/+DaKd3MiLylh70cwcAOd7Ow==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(136003)(396003)(376002)(52536014)(71200400001)(53546011)(54906003)(64756008)(66446008)(110136005)(7696005)(55236004)(4326008)(186003)(9686003)(66946007)(66476007)(26005)(83380400001)(5660300002)(8676002)(7416002)(55016002)(316002)(478600001)(2906002)(76116006)(86362001)(6506007)(33656002)(921005)(122000001)(38100700002)(8936002)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?UC9NcFBzcGE0OFRJSmZzc3duWEloYnFzUU80T3h1ZE5sZmE0WnVXblNzOU0v?=
 =?utf-8?B?dXc3N2ZubHBObUVZY0gwVk1UWUw5cEZaaUNlUjZSbFhQeWV6aXR5OFFGZURE?=
 =?utf-8?B?dzJLVVlUZDliaWpxTk5USXhmVWFZRzZRUzRucmxOWFgyV29XZWlocGpxYllr?=
 =?utf-8?B?K3hwTTZqaXpnN2RXekUxMk11bHZxQncxZFNTQWc1enBVWkx0WVlSelR0Qkw2?=
 =?utf-8?B?ZUJldEVVZUxzMTcrSDBTM3R4WDg3Z2hFc0FYc1BiTWVZZmFzTVZ6SWV5MmRn?=
 =?utf-8?B?amNITXlCaXFCL3Bnb213Q0xEaVVyUFdpRCtrZWdLZXpkR05LaUNHb2RkTVVY?=
 =?utf-8?B?RHRVZ2hkTHNUSUFld3BLM3BKZjkxSzBxdU5uUlRCRVhaSCt4RnErOWQzanhh?=
 =?utf-8?B?MTN2RkJSVTNyV080M01RWFBiRnhoaWd5Y3cvMklKYmFjcUpDMEw5UnozZTRI?=
 =?utf-8?B?dk05TFFoOEVOWW1jM1lUOVo4b3JScStURndNOHlnWWdtTncxWktGeXpEQnJq?=
 =?utf-8?B?WnZvTnY5TGtpcWx5R2g3TW1vT095NXl6VEF6Zk9wVWhPWDdIM0pucnpDdVlh?=
 =?utf-8?B?UmkyZ3UyR1BtUmgrU0lNVWp3aU1IdGc5c3lRT2ZjOFRkV2hKRUlrZldZM0V2?=
 =?utf-8?B?eCtpeHNuQWZOVkJJaWg5aER3aXhsczZGYlJBcTZKRkN5YktHRVJ0UURZM2Q2?=
 =?utf-8?B?enBzakZjaU04YUwxNHlqbG8vUWRQUkg3N1lyMVFiVWRBdDE1VW5HRUxZMjBv?=
 =?utf-8?B?TktqS1k4ckUrYzg1WFpMMlM0cVozVmxwb0RDd2NHUG8rVVhGd0NLTExhT0Ft?=
 =?utf-8?B?YzhRWDc0bEhXZmt3RFhnZ1pRci9sRGdOSnh6U0VBL293RVhFcTVlVDFsblVE?=
 =?utf-8?B?M0pPRk1VZ2k0cDJnVkI0aTNjL3RZaHhzWlhvVUp0eVpOby84eFQ1QUdCL1lr?=
 =?utf-8?B?ZkR2WjVDNUs4QVMvMWlqNDN2MnpzT1ZjOXhwZXBPcW1RMDF1a0ZxOTNMenpa?=
 =?utf-8?B?alJYemllNzRObExJNFE0SzY2TkY0MWlxSjFlbDIvUXMrOUxIeFhsSWFpQys2?=
 =?utf-8?B?R1JIUXBxMHN1dlhmNWxlbURBVXBJSUgyd1pCckt0bnh0R0Q2YlQxNDFnYnNN?=
 =?utf-8?B?MEdERnFxTENXSzlLRml2Tk11ayt4ZzI1a3VkQnpCQzFjTEVXdnNNQTdqQy9h?=
 =?utf-8?B?MkFxeGhwVXZ2Rm5FVmJsSk1LTlhySXZhNGREUElJaWNHZSsyaHZvRWtINmt6?=
 =?utf-8?B?bzc4d0Z3RmMvMVZFdC82RC9HS3I1US9BOXNpdjVUVWpBRjEybGlXazBlbE9a?=
 =?utf-8?B?K1NhQnRWczNaV3NyaUt1MHNadXl3K01sWTJOdCs0TFJaMWpXMmh3MVpQRmJD?=
 =?utf-8?B?STVQa3BadVRhMFhKQVpsTWh4MXNCVGw2NndnbU5DRUpuTGRPckQxMWxacHhv?=
 =?utf-8?B?K01MV3ZGaWxycG5rbGIvQUg2N1dZUk1BTVZ6L1VyK3BNcDlGL21qQlpHV0Jn?=
 =?utf-8?B?L0NwQUN2b3hBVWNpSDdNM1E4cERTN3hEeElkK1dYeUhobDRLSVhBL2xKZm8v?=
 =?utf-8?B?QklNWWZjVWJPR2VWajdaZmNkamFRa3FEakZIRllEM1I3ampFZ1lORnQzM0tm?=
 =?utf-8?B?Ym5CbS9Ra2xBN3R1dlozcXBTY0VhNjQzbWFPaUoxbzR2NzRFK3hyVmVKTTBy?=
 =?utf-8?B?VTY2L0dBRXpVT1M2ZVJON1dTK1c0Q014dUxtMjZOTlVPcjBqNndoUXhwRHEy?=
 =?utf-8?Q?z18fMXUTGjR4b+GAsZCPstvbF7co3cfqllv52Qp?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0f5b561-a867-4257-b96f-08d925c3cfab
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2021 12:41:58.0692 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pPnDCtRf0V+l8kUUG5lRe08kni/t3Bih6Y2+lg+CcjhjeWZaw7x6U1R1gylBz49GpdIYhNvqP51B/O0TIBab9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5401
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Kirti Wankhede <kwankhede@nvidia.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Robin Murphy <robin.murphy@arm.com>
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


> From: Enrico Weigelt, metux IT consult <lkml@metux.net>
> Sent: Wednesday, June 2, 2021 2:09 PM
> 
> On 31.05.21 19:37, Parav Pandit wrote:
> 
> > It appears that this is only to make map ioctl faster apart from accounting.
> > It doesn't have any ioasid handle input either.
> >
> > In that case, can it be a new system call? Why does it have to be under
> /dev/ioasid?
> > For example few years back such system call mpin() thought was proposed
> in [1].
> 
> I'm very reluctant to more syscall inflation. We already have lots of syscalls
> that could have been easily done via devices or filesystems (yes, some of
> them are just old Unix relics).
> 
> Syscalls don't play well w/ modules, containers, distributed systems, etc, and
> need extra low-level code for most non-C languages (eg.
> scripting languages).

Likely, but as per my understanding, this ioctl() is a wrapper to device agnostic code as,

 {
   atomic_inc(mm->pinned_vm);
   pin_user_pages();
}

And mm must got to hold the reference to it, so that these pages cannot be munmap() or freed.

And second reason I think (I could be wrong) is that, second level page table for a PASID, should be same as what process CR3 has used.
Essentially iommu page table and mmu page table should be pointing to same page table entry.
If they are different, than even if the guest CPU has accessed the pages, device access via IOMMU will result in an expensive page faults.

So assuming both cr3 and pasid table entry points to same page table, I fail to understand for the need of extra refcount and hence driver specific ioctl().
Though I do not have strong objection to the ioctl(). But want to know what it will and will_not do.
Io uring fs has similar ioctl() doing io_sqe_buffer_register(), pinning the memory.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
