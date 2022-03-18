Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F0FFC433F5
	for <iommu@archiver.kernel.org>; Fri, 18 Mar 2022 20:37:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A288760ABD;
	Fri, 18 Mar 2022 20:37:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rIpmSHf672cu; Fri, 18 Mar 2022 20:37:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 301F56079E;
	Fri, 18 Mar 2022 20:37:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E073EC0012;
	Fri, 18 Mar 2022 20:37:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60486C000B
 for <iommu@lists.linux-foundation.org>; Fri, 18 Mar 2022 20:36:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4E0D360A69
 for <iommu@lists.linux-foundation.org>; Fri, 18 Mar 2022 20:36:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nvnHwU92qnVs for <iommu@lists.linux-foundation.org>;
 Fri, 18 Mar 2022 20:36:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from na01-obe.outbound.protection.outlook.com
 (mail-eus2azlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::2])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 218616079E
 for <iommu@lists.linux-foundation.org>; Fri, 18 Mar 2022 20:36:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OSXf2KmL8JbD7jKqG4Rvtz0pse60CwO/OXVW/aN2BeQtwCgl57mK2HHkIYdwsjmC1CKCFdVn29xRm3o1+MScJUNCrG41XE65KOfTXn92eU+4i0eaMZQvn8Qci4RvgCdDxhvzP2nMbs1i6f37H4F+eJ4AgLA9LGCtqm32ZhWUhBwaKXqa1GbtGE9eoP4qvykhk3fHLrQmVjsUlqCnKu8rqfrTcobfpJdsJxItOPaUMFq+vDXwfJtwUlPF2ouwablZ/6YK9SDzXKwdZePpReWIXyEJKqsPLSFW+O6otUzYVJPyP8tg40a135ymmxbyK81dOQkrfA9A7qZU8SjzZ0rqmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/nPXJjHcEKecEzoPVidNfplBM3Thyjxv1bK6hthw8g=;
 b=Gw8XFBK3bMNP+48VOBLo+fwkekwVgOyFFPrnOof6LUNl7WSwm4kad68QwN5cEJGNn1h1KhiO1OUUpcAUKqbHB4gRzERbxl+KD6k82xVwimbTGAxcqSopk6eCZdvB8tCQ4ptJ8so+t5eOhCf0zmvNhOT4P5hPQDAp7fzXyiE6WJfwZHykyU3xIZ3BJCjpEB/6ic4/cRi3cailB3GDmdchx1zc2e1zDOAE7T9uqXaKAHCwwOroYoN2WUP7rUn0hcFET6bhsCn1cWhGduw4NXvuSdBtpKy/N0ILcAnWcolzOZnYJaX7a+X64hEFtk1Ti6DNYQFgnBzZmJlyOLfb+ciC5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/nPXJjHcEKecEzoPVidNfplBM3Thyjxv1bK6hthw8g=;
 b=FVvZ1HDrfWVkM1T+a/U8jRXbOSncERkTwhnNQRvlwAeBDuGKce384/PYTnK9DXDikGRs4truEGZZHpeYtVTwhRQv2yu7wu7Tf+Jn9UawIV7uy4ouLEfqrhdmPudhbqNlyfnvDDZPUkqKSuaBJqip5+BMii3ug5mmf5fh/tlfI9o=
Received: from BY3PR21MB3033.namprd21.prod.outlook.com (2603:10b6:a03:3b3::5)
 by BYAPR21MB1206.namprd21.prod.outlook.com (2603:10b6:a03:106::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.8; Fri, 18 Mar
 2022 20:36:53 +0000
Received: from BY3PR21MB3033.namprd21.prod.outlook.com
 ([fe80::ed64:ab10:6089:b736]) by BY3PR21MB3033.namprd21.prod.outlook.com
 ([fe80::ed64:ab10:6089:b736%3]) with mapi id 15.20.5102.011; Fri, 18 Mar 2022
 20:36:53 +0000
To: Robin Murphy <robin.murphy@arm.com>, Stephen Hemminger
 <sthemmin@microsoft.com>, KY Srinivasan <kys@microsoft.com>, Haiyang Zhang
 <haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan
 Cui <decui@microsoft.com>, "rafael@kernel.org" <rafael@kernel.org>,
 "lenb@kernel.org" <lenb@kernel.org>, "lorenzo.pieralisi@arm.com"
 <lorenzo.pieralisi@arm.com>, "robh@kernel.org" <robh@kernel.org>,
 "kw@linux.com" <kw@linux.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
 "hch@lst.de" <hch@lst.de>, "m.szyprowski@samsung.com"
 <m.szyprowski@samsung.com>, "linux-acpi@vger.kernel.org"
 <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
 <linux-hyperv@vger.kernel.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH 4/4 RESEND] PCI: hv: Propagate coherence from VMbus device
 to PCI device
Thread-Topic: [PATCH 4/4 RESEND] PCI: hv: Propagate coherence from VMbus
 device to PCI device
Thread-Index: AQHYOhuoZPOAPXCXP0q01eTUICYXTKzD0PMAgADGUgCAAGKTgIAAm9MA
Date: Fri, 18 Mar 2022 20:36:53 +0000
Message-ID: <BY3PR21MB3033B9B260CEA13A5C2DE9ECD7139@BY3PR21MB3033.namprd21.prod.outlook.com>
References: <1647534311-2349-1-git-send-email-mikelley@microsoft.com>
 <1647534311-2349-5-git-send-email-mikelley@microsoft.com>
 <9c52c5a0-163d-e2dd-d95b-9f382e665215@arm.com>
 <PH0PR21MB302533BCD6707DAACC13E64DD7139@PH0PR21MB3025.namprd21.prod.outlook.com>
 <44dd4f16-3f0b-5289-c9a2-fe42341b0231@arm.com>
In-Reply-To: <44dd4f16-3f0b-5289-c9a2-fe42341b0231@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=40410c4c-4fe6-4590-87dd-3a15d3df77b1;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-03-18T20:15:42Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d2d6d12d-f775-4fc1-8e34-08da091f0983
x-ms-traffictypediagnostic: BYAPR21MB1206:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <BYAPR21MB1206D622B9859B5338D183C6D7139@BYAPR21MB1206.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L6FW/WXH+e25DUAJrmk/Nb3idJIq4RxqWwT8risSYHt04BHkpnORL4tikHmxUWBt8alp1c8FeGIQw43LQDG+Wp/bCGDaLRL9m0xR68V1ghZG27JgHdPgV6VTaP+jTmN9kyPQwEf4GUI811k8cGqJitOEi1UomOIYm+JlkG5zWYUeVb439KW9mcrRUJK5fEfDrsChiAukggY5jLZgIcxEVJ+mfRLphYhJGuSChRNNLZCCrmMrt0ZTPYgqQEZfHqvplYJQhKrNT/5zwCpDbDBdEgYdKMmB+3PW7zWzIqaQhox+0wCM0o6eRuOxEhDcN4/+sdONkrO+tkMr4HalrJWKDTIk2VULlkhihMwtrkjJQ9tqINT5X7bpEEub/PfuDl8bWMTT+cOgc1mYa8ZOjFSJ5kG8RT73vOBaQqaOoQ7ly6spHtseINsN2BvO7LPzbI5ZZq8NeTDlvRS+IMkJ6+DxeOOwC72X+gjuPCgfGz88gKmbwFm1AL9osSl0/Z7DnLXl9uaFxRSlVkMt/HzXQ3lcs5nPBkp4d0RNI9cenNipcLVI2e24lDUvIA59Rd3aznURdPUsDqdEFNYIZnxfObrdk8KoJxBZqiBzb5KH0oq8E89d5SqcC87uI8eZJXrP1UUnrYFRuef8pCw7Vz5UvR/hN5EWS7MXs2Kk9SdWa+fKHQLWYYH9SKBVfnQxuIqshKeI94CFgBT/LJXWELyxjavG5Tn3ALLmrBLZMwGTC6hfDF9hGSEpL2zi5/U80VCkklqv8Ym0QL+KeynmSbH0BOwl2w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR21MB3033.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(451199009)(10290500003)(110136005)(316002)(8676002)(186003)(508600001)(7696005)(9686003)(6506007)(71200400001)(26005)(53546011)(66556008)(64756008)(83380400001)(86362001)(5660300002)(52536014)(7416002)(8990500004)(33656002)(55016003)(2906002)(122000001)(38100700002)(82960400001)(82950400001)(921005)(66476007)(66446008)(8936002)(76116006)(38070700005)(66946007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a1lMZ0NMWnp3V2J5dDB3d1NwcXRJYkRWNndTbVA2dGxEL2Y2S0dRK0FxcCt0?=
 =?utf-8?B?UURYNzJhd3pLODFJWEtnbHBzd0lyZmxKNEc4cUlzRnFObmZXbW16eDhFVzdX?=
 =?utf-8?B?RHYyMElMT0ExQnRzWVZGWlQwdzRGQ1MyM2U2blNkQmx5SnhmRUhmRHN6UGFY?=
 =?utf-8?B?eUlEckNmR21OQmNxZENEaVhEUFVCT1Myc2tnbkdvQVUyeEtpSzByQmU1UVRG?=
 =?utf-8?B?WE1DYWJjVUhiSklDb2kydmpHdkFYTGs2UE1KK25qTEVVMFJ5YVhwRDRZUHVr?=
 =?utf-8?B?bGl4aFFSZUk3QlA0VjdYdm9Td0cyWlNpdDQ1aEt4WUo5aFZrMUlEYzBONEJS?=
 =?utf-8?B?d2JteHN4SDU4ZkJNYk9DMDZFS09qNFdBZGEwT1NYRjlZbUs2UnZHSzBTQmxI?=
 =?utf-8?B?eVFIeHAyeVBUM29oNVg1MzZoQlRZdW42Wm4wL0xyczRQUEVJU094L2JnZ2Ft?=
 =?utf-8?B?aWdQeEFsVmZnTGIwUXdtSFBQQ0J4ZzZ0U1VxN3NucGtzREJUUmgzQWMyYXY0?=
 =?utf-8?B?cEJCdGw2K3NGTEcyRlZQdzJMcnNzVi9uWFZ1WDdZMXExbkNIOVZ4aDJSY2Zj?=
 =?utf-8?B?VVJqTm9CdEZlaUxJTHVXMEYxMFRhTlovRTlvb21UN012M2UyMGdXVVNZT0hu?=
 =?utf-8?B?OUJkL2xjcDMrbzJrMno0MUZSaUtDNGkzSTFIakp2Q1pjdmQ4VXZuVHo1YzN2?=
 =?utf-8?B?Z3czRWxLYWxzdS9tS1Y2cTFGU0FPSjN2d0ZWNDRqTjRQamFjeDFnNzVGanRm?=
 =?utf-8?B?U3pib3diNVphYjF6N0NPVTlZUXV3SFJ4K0h4QW9OMmt2cDZvbTF2UU5WTi9B?=
 =?utf-8?B?NWt6aDVtUjlmK1ZyMXNrQjk2TUFKN1YxYjd4dmJHUzUzZm9FL05mb1dhOENX?=
 =?utf-8?B?R01XZm1NbHJUaUVnM2VVWlp5Umk0SGM3dktocGZ4SkZaOThxQnIxWjRXUldo?=
 =?utf-8?B?QXhUSjBzRTRmYmkxNzk2YWRQcWF6NlhWK1h5eW9VVU96ZkZ6d09UemV1T2NL?=
 =?utf-8?B?UEdZOVE0UHo5L1djV2Jpc2dMa1pNVzVnL3pJUDE1WlFRMklSaGVPQUVvZUpL?=
 =?utf-8?B?L1Y0V0tzRkZETFUxeEFNT0tTNDZmSEhvc1dJaktDamh6K2ZQTWlzV1NmcDJJ?=
 =?utf-8?B?dWVBRjY5UjdSSnYwUDA3Rm43eHBob3ZuL3pZdHpPVFA5QXI3V3BNL2VCK1FE?=
 =?utf-8?B?L1hzU1AvS09VV1lYaWR1UFNiY3Yxa1FvZU93WmxoNDhwa2puNnlkUXdHRmlj?=
 =?utf-8?B?Tm5pZHJxdFA4WTFOZFR2c0NQS2J0bzl2c0pnaE9KM2NjRTQyK1ZTMklJMnVq?=
 =?utf-8?B?MHl4Q0NHT3RrR3BJZTBGN3UxNFRhT1NFTkhrYnJIalpjaXVyeVdVL3dTay9n?=
 =?utf-8?B?bDJMM3FOSHN0Rzl4YkYwZExDTlUrOG9XK0VKUVBIUFV6Q3JkQlMxYmNYNHVz?=
 =?utf-8?B?UUl2clpWQis0L0YvZEtiM0YvTGc2MkoxbFFod05ranZuY0lhMlNpUVY0OHo4?=
 =?utf-8?B?WUdKMUdOZGVXSkZSelNVNUorWnZueSs3bXhoNndVOUZFdm5MNTZOSmJDaFpx?=
 =?utf-8?B?ejZUd2t6dUh1R2l2bmhoNmU0blkrZnk4Znh1bVRzOEd4bnQvQWxpVmF0TDVt?=
 =?utf-8?B?YmdhNHowTEQwZ3lhQ2JINDBkL1pSL1p4WnhpbmptQlBpdzlHbThSajFMQ3lE?=
 =?utf-8?B?ZEdNK2w1QWVvYnhhQ3hQdmhtNm9hNCtCYmJxTFQwUzlnUTFFSWlKZ2UxbW5R?=
 =?utf-8?B?Qk42c2FNeWxhdHpCbWhzZnluU3psWlpEZGFsK2UwNDZPWmRtdHl6enYvMUE4?=
 =?utf-8?B?TSsrS1FtZmZqZWlmMHQ1UmxiNllxZGdFbGFNRXdZZ2NOMDAzL0VJdVh3UVh0?=
 =?utf-8?B?RXFzUTR3ZmxjRXNyU2MxRXVXanJkTFhuZWVLSVlQMFd4a2pnbTE3cUdwYmZ5?=
 =?utf-8?B?YTRPSHNTV1p6MXlxNEdrRldJblZuRjV6SzBtd0NMaHg5QWdEYmEycUpQQUFW?=
 =?utf-8?B?Qjd5bmRUQU53PT0=?=
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR21MB3033.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2d6d12d-f775-4fc1-8e34-08da091f0983
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2022 20:36:53.2949 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1fl1xXNFqTRR51G5ATNmZrQUAPKjxB5NJ2Hh3jPSCC8pfo5TChi6xfjdrl3KydfcOxeRRuOGlTRfwyKTnjv5soSz/HB0pBQBtrXT4OdtNck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1206
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
From: "Michael Kelley \(LINUX\) via iommu" <iommu@lists.linux-foundation.org>
Reply-To: "Michael Kelley \(LINUX\)" <mikelley@microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Robin Murphy <robin.murphy@arm.com> Sent: Friday, March 18, 2022 3:58 AM
> 
> On 2022-03-18 05:12, Michael Kelley (LINUX) wrote:
> > From: Robin Murphy <robin.murphy@arm.com> Sent: Thursday, March 17, 2022
> 10:15 AM
> >>
> >> On 2022-03-17 16:25, Michael Kelley via iommu wrote:
> >>> PCI pass-thru devices in a Hyper-V VM are represented as a VMBus
> >>> device and as a PCI device.  The coherence of the VMbus device is
> >>> set based on the VMbus node in ACPI, but the PCI device has no
> >>> ACPI node and defaults to not hardware coherent.  This results
> >>> in extra software coherence management overhead on ARM64 when
> >>> devices are hardware coherent.
> >>>
> >>> Fix this by propagating the coherence of the VMbus device to the
> >>> PCI device.  There's no effect on x86/x64 where devices are
> >>> always hardware coherent.
> >>>
> >>> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> >>> ---
> >>>    drivers/pci/controller/pci-hyperv.c | 17 +++++++++++++----
> >>>    1 file changed, 13 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> >>> index ae0bc2f..14276f5 100644
> >>> --- a/drivers/pci/controller/pci-hyperv.c
> >>> +++ b/drivers/pci/controller/pci-hyperv.c
> >>> @@ -49,6 +49,7 @@
> >>>    #include <linux/refcount.h>
> >>>    #include <linux/irqdomain.h>
> >>>    #include <linux/acpi.h>
> >>> +#include <linux/dma-map-ops.h>
> >>>    #include <asm/mshyperv.h>
> >>>
> >>>    /*
> >>> @@ -2142,9 +2143,9 @@ static void hv_pci_remove_slots(struct hv_pcibus_device
> >> *hbus)
> >>>    }
> >>>
> >>>    /*
> >>> - * Set NUMA node for the devices on the bus
> >>> + * Set NUMA node and DMA coherence for the devices on the bus
> >>>     */
> >>> -static void hv_pci_assign_numa_node(struct hv_pcibus_device *hbus)
> >>> +static void hv_pci_assign_properties(struct hv_pcibus_device *hbus)
> >>>    {
> >>>    	struct pci_dev *dev;
> >>>    	struct pci_bus *bus = hbus->bridge->bus;
> >>> @@ -2167,6 +2168,14 @@ static void hv_pci_assign_numa_node(struct
> >> hv_pcibus_device *hbus)
> >>>    				     numa_map_to_online_node(
> >>>    					     hv_dev->desc.virtual_numa_node));
> >>>
> >>> +		/*
> >>> +		 * On ARM64, propagate the DMA coherence from the VMbus device
> >>> +		 * to the corresponding PCI device. On x86/x64, these calls
> >>> +		 * have no effect because DMA is always hardware coherent.
> >>> +		 */
> >>> +		dev_set_dma_coherent(&dev->dev,
> >>> +			dev_is_dma_coherent(&hbus->hdev->device));
> >>
> >> Eww... if you really have to do this, I'd prefer to see a proper
> >> hv_dma_configure() helper implemented and wired up to
> >> pci_dma_configure(). Although since it's a generic property I guess at
> >> worst pci_dma_configure could perhaps propagate coherency from the host
> >> bridge to its children by itself in the absence of any other firmware
> >> info. And it's built-in so could use arch_setup_dma_ops() like everyone
> >> else.
> >>
> >
> > I'm not seeing an existing mechanism to provide a "helper" or override
> > of pci_dma_configure().   Could you elaborate?  Or is this something
> > that needs to be created?
> 
> I mean something like the diff below (other #includes omitted for
> clarity). Essentially if VMBus has its own way of describing parts of
> the system, then for those parts it's nice if it could fit into the same
> abstractions we use for firmware-based system description.

OK, got it.  Adding the VMbus special case into pci_dma_configure()
would work.  But after investigating further, let me throw out two
other possible solutions as well.

1)  It's easy to make the top-level VMbus node in the DSDT be
the ACPI companion for the pci_host bridge.  The function
pcibios_root_bridge_prepare() will do this if the pci-hyperv.c
driver sets sysdata->parent to that top-level VMbus node.  Then
pci_dma_configure()works as is.  Also, commit 7d40c0f70 that
special cases pcibios_root_bridge_prepare() for Hyper-V becomes
unnecessary.   I've coded this approach and it seems to work, but
I don't know all the implications of making that VMbus node be
the ACPI companion, potentially for multiple pci_host bridges.

2)  Since there's no vIOMMU and we don't know how it will be
described if there should be one in the future, it's a bit premature
to try to set things up "correctly" now to handle it.  A simple
approach is to set  dma_default_coherent to true if the top-level
VMbus node in the DSDT indicates coherent.  No other changes are
needed.  If there's a vIOMMU at some later time, then we add the
use of arch_setup_dma_ops() for each device.

Any thoughts on these two approaches vs. adding the VMbus
special case into pci_dma_configure()?  My preference would be
to avoid adding that special case if one of the other two approaches
is reasonable.

Michael

> 
> Cheers,
> Robin.
> 
> ----->8-----
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 588588cfda48..7d92ccad1569 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -20,6 +20,7 @@
>   #include <linux/of_device.h>
>   #include <linux/acpi.h>
>   #include <linux/dma-map-ops.h>
> +#include <linux/hyperv.h>
>   #include "pci.h"
>   #include "pcie/portdrv.h"
> 
> @@ -1602,6 +1603,8 @@ static int pci_dma_configure(struct device *dev)
>   		struct acpi_device *adev = to_acpi_device_node(bridge->fwnode);
> 
>   		ret = acpi_dma_configure(dev, acpi_get_dma_attr(adev));
> +	} else if (is_vmbus_dev(bridge)) {
> +		ret = hv_dma_configure(dev, device_get_dma_attr(bridge));
>   	}
> 
>   	pci_put_host_bridge_device(bridge);
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index f565a8938836..d1d4dd3d5a3a 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -1764,4 +1764,19 @@ static inline unsigned long virt_to_hvpfn(void *addr)
>   #define HVPFN_DOWN(x)	((x) >> HV_HYP_PAGE_SHIFT)
>   #define page_to_hvpfn(page)	(page_to_pfn(page) *
> NR_HV_HYP_PAGES_IN_PAGE)
> 
> +static inline bool is_vmbus_dev(struct device *dev)
> +{
> +	/*
> +	 * dev->bus == &hv_bus would break when the caller is built-in
> +	 * and CONFIG_HYPERV=m, so look for it by name instead.
> +	 */
> +	return !strcmp(dev->bus->name, "vmbus");
> +}
> +
> +static inline int hv_dma_configure(struct device *dev, enum
> dev_dma_attr attr)
> +{
> +	arch_setup_dma_ops(dev, 0, 0, NULL, attr == DEV_DMA_COHERENT);
> +	return 0;
> +}
> +
>   #endif /* _HYPERV_H */
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
