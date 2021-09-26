Return-Path: <SRS0=RzN/=OQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39520C433F5
	for <iommu@archiver.kernel.org>; Sun, 26 Sep 2021 03:01:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5CEA60F9B
	for <iommu@archiver.kernel.org>; Sun, 26 Sep 2021 03:01:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B5CEA60F9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5E421403DB;
	Sun, 26 Sep 2021 03:01:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wAadU37iUSLT; Sun, 26 Sep 2021 03:01:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E3E7F403D0;
	Sun, 26 Sep 2021 03:01:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C7B57C000F;
	Sun, 26 Sep 2021 03:01:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 01E05C000D
 for <iommu@lists.linux-foundation.org>; Sun, 26 Sep 2021 03:01:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CF72960622
 for <iommu@lists.linux-foundation.org>; Sun, 26 Sep 2021 03:01:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yvAupdhEyPv8 for <iommu@lists.linux-foundation.org>;
 Sun, 26 Sep 2021 03:01:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D3036605DB
 for <iommu@lists.linux-foundation.org>; Sun, 26 Sep 2021 03:01:40 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10118"; a="224366103"
X-IronPort-AV: E=Sophos;i="5.85,322,1624345200"; d="scan'208";a="224366103"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2021 20:01:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,322,1624345200"; d="scan'208";a="519701025"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga001.jf.intel.com with ESMTP; 25 Sep 2021 20:01:39 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Sat, 25 Sep 2021 20:01:39 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Sat, 25 Sep 2021 20:01:39 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Sat, 25 Sep 2021 20:01:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8S/rwYjxBoifoW2VLkVXS3Xxd4DgvqnwZy0Y9sdf8L55M50qz4pKceNpZchor02easr1wlvKPJlEEku3Eq+PBMXVMF8KK7mZ7hVM0oxZu0mu/kaW+4BsuxC2J+RUseIyksAqdbupBJDsJlAWCJLyboTQiiAk5HnBINgnM/CNO9vYTfmEnxpXw6zkZh1ENKLhIEDYGbwwtYHz0YF/7K7LhsYFtdRwZifOFr70vhiZ0LZox5788Moxh1eGVolNUYclXEFk9Ts7W/utRwQofZ7aRwkjFfQhW6VC/Oby9sXbEzhzXoIWAeb6aXK9IywPu234AVhJeH25Z+uZVhhD4ks2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=9WNoB5B4BwcM38r3vHQgCLS6IX9JDsAlPJAHYDatKys=;
 b=nfABUpdJowYqpnLHf137cvyyu6r7+xINDA8O2vaFYgXt5nMd+pvckUrLHaq+uI77+wXGDv5aF93FbM9+qLqj7Jg20GL5KWjQzy91Cvi7FYwVbvaVz8+9UPfz8AR70k4dCkMwYdPAkQ98pHabDHmYnEJ9O2DTfP9L7wV62H+TIxAcqjPBf20I8/Bt3p6XrGW+SFWIIaObWKu0Jbxg21zCJDN5zkdtORCTxpkdqM8PQb4+CPt0Y10u4rlcVbHqYGdVtwAo8ORXEkpQtxMh1zoPi+iYfMAfL82KwOQ2nuu1IHLI5dkkUa8Q9OD5faRW8HZPngdPu2ju953vdrcev7A0ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9WNoB5B4BwcM38r3vHQgCLS6IX9JDsAlPJAHYDatKys=;
 b=x6j8mrElNtwQzCyNB6yW2jhpzYMpOeRqllJ/C+K1XPcz1clPnGkOeQ1A91CyaSvzlHsaaSINT5nX+cH66gnI5jStMAAlqGKxRfiHt7bdKwMGd4V20cxM5JXfdmmWKTU2W4ldGujFb+lrqXa454bv2xnax5EW1gzi1nTIhUd3ttw=
Received: from BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13)
 by BN8PR11MB3700.namprd11.prod.outlook.com (2603:10b6:408:89::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Sun, 26 Sep
 2021 03:01:37 +0000
Received: from BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df]) by BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df%8]) with mapi id 15.20.4544.021; Sun, 26 Sep 2021
 03:01:37 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Use second level for GPA->HPA translation
Thread-Topic: [PATCH 1/1] iommu/vt-d: Use second level for GPA->HPA translation
Thread-Index: AQHXsOyCAYyPfoq/mkGWmB+Da+Ps0quygFqAgAMeSoCAAANbgA==
Date: Sun, 26 Sep 2021 03:01:37 +0000
Message-ID: <BN9PR11MB54335B5DCEDD89CD159A3BCD8CA69@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <20210924022931.780963-1-baolu.lu@linux.intel.com>
 <BN9PR11MB54338F4F946F5E9BD3D4D5388CA49@BN9PR11MB5433.namprd11.prod.outlook.com>
 <047dec82-4530-ab93-d8f1-a21405a1d955@linux.intel.com>
In-Reply-To: <047dec82-4530-ab93-d8f1-a21405a1d955@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8129aeff-3d4a-4445-2e4b-08d98099f4ab
x-ms-traffictypediagnostic: BN8PR11MB3700:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR11MB37006004BE3BBE34AA7FFA078CA69@BN8PR11MB3700.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:281;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wnt4tyFPsLk/4PCEE6S8DIyAvMKrf3XCUeW2YYq2XO7RtX5TASAkCCjftBAcLFbjuCeTbTlYq3FIWjWwVBiU+gDmqLs7BjfPVubhacpCQJF6986C7QLW1s5v80dvlVF4l/Dhdxfa9aivjDXSYvat5H1mKmpFGDnMOk04yGCBtpx19YYhTiWg5/LoT3NhBCC0XLfMvGW8OCFdPH0XsfcOsGZLdgt6ke6rWtSqzaceNnxraa8DQW9jp3TtKNlgopFl57qGE6j/vVMOfl32XKtbm9LyKnZqbRroCBlp3sb6AXtHLbUiqMuEeyuA0lGOqJJ2OxjS6CFe/MyNT/emiengSDwlctiPmdu71XrU/0PPhbvmanEqfTdGD8yberduJ+B97Cl97pllqLZnbQ8YsZ4g9LStdnZn0BuDPN+bicRVfD+tF5wmJzM4tOaj8wgjXMK/pfVPX989date+lH6rXceDa2GkxWVr5qajAKoY7MIyKcS2TZgB6sI/tv/EOogYP3524aQqETr9pzKpnJepuENnVlvbiPehILMbihnmWW/DpwjCm3YUU7gK5qdiRjR3KRqzEwdqstWmDasmGFndGJC5zV7BTVAvqrjYxGo+PCmehuiFHnsWk4M8ERvNvsd9tje9g6hbd/WKD8GccV4OykUKsyZL+iSgbTbyDyzCLnhY89jFbAap3KVSoVy3NlgXWrI2nMFluzugODQ3d0v4RGhYA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5433.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(122000001)(8676002)(55016002)(38070700005)(110136005)(186003)(83380400001)(6506007)(8936002)(38100700002)(316002)(2906002)(54906003)(9686003)(7696005)(71200400001)(53546011)(4326008)(26005)(76116006)(508600001)(52536014)(33656002)(66476007)(86362001)(66556008)(64756008)(66946007)(66446008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXpTZEEvOUUyS3h6RHNTVFk2eUZNRXA2M2JXbTBabzlBbE1BTUw0UU9pc0ZH?=
 =?utf-8?B?SEpFQWtrL05lRW1WTGV5RGUwRU0vYWhGekxJQUFXL3dkdHlNR3V1cDllOW54?=
 =?utf-8?B?dGNwK1c4TTFjV0Iwc2U5NmNFbHorQXRwSWRhc3g1eVVWOG1ZR214cUpDZlo5?=
 =?utf-8?B?bFhpM1VZUklyU3dXZndtQ3Q0cmxxeFNyZW9DV1pTVHpyTTRzUCtBU1RRR2ht?=
 =?utf-8?B?ZlVBaW9UQXY5b1JmcU5BYlBLK3hyVTZZcWRhRjdqUkdRMlZteGc2cTRZcldS?=
 =?utf-8?B?Wkd3b3RCanEvNGQxN3hGbzU4UTNyc3daeVFTNFlEWGRnZ0FGWnFma2hjOHVi?=
 =?utf-8?B?a010WWNSQ0ptK0hlWGFJM1l5R1RUM1E1aXNzQU5RbHpqQS96em9LdHRYWjFw?=
 =?utf-8?B?NVhKWCszcTU4K3NZcEtpNzNXTERYMDVETmhjalNqNDNzY280RkFFU3ZwNFRv?=
 =?utf-8?B?THNxdVNwL1NtUjh2aUFUUFV6cEhETmNOZE9wQUdhbjFpR3FURlgwVGo2QnBJ?=
 =?utf-8?B?aDRkVGx3MEg2R3pKZk5TYUJkOFNhMW85aDlQcTVIQmNuRmY1ZVJjMWtBN01E?=
 =?utf-8?B?QzhaK0N5bDVXT1JZMEhzSm5oNStnblkzdGJQbS9PTlI4YkNrV3pvRjV0aHRF?=
 =?utf-8?B?aVdEVjVTcWM3Um9mL2RFUEZDZ29BODdud1ZxT1ltZHQ1NHVrc00rbDRwMXBW?=
 =?utf-8?B?ZlpTRnhmaTIwVVR6ampnV0Q0cGRIU205RkpEQlNWSjBHWUR1WFdBbm5EMXdl?=
 =?utf-8?B?MEsycFJXcVh4VC9jRk9UREg4SWlZbEc0MzhjMFVIS0M2VVJQQ1k2dkFpbGJu?=
 =?utf-8?B?RFBxcmdmVWFtM2U3YVdKRldPaWIzeVhpcmc5bTF5VlRXempqVUtGYTZOMzNp?=
 =?utf-8?B?QlBKUCtNTnl1dHN2cTVlcTFVMVkwSW5ub2loeUNtM1R3ZlU5cmlIakJmMnRl?=
 =?utf-8?B?aEh3TkVsZXV0M3V6Yi9pSWk4MjJyNEZQS1dVL2dEdGczS3Z1ditMWlZqYkJv?=
 =?utf-8?B?NGFNVzdMeHQ4RXlZZTR5V1MzREtmVUFmRVZNSTE1NE0xc0dvV2ExbEVlUFNC?=
 =?utf-8?B?aGlEVHpYUzlCQlMwZU9reUkxMUZlUzNpNGh4YTJpamZuczArK0g5d1BwNEFX?=
 =?utf-8?B?WnRSTlQ4TEdLUFBEcW5LOFVNTlZHUUdSTDJnSWdJZ0Z6RVljeXJVTkx2cXJt?=
 =?utf-8?B?bjlRaHAxTzJCVEVsZzE0cjhIL0pWTnE4STlnYnh4ZXJZRFE1UzF2c3VzVldJ?=
 =?utf-8?B?WDhzS3ZJNnIxbnRhSXdzbVl6aHJiRitjRGcvNWFEZ1ozNlh0cFNVQVczeUtk?=
 =?utf-8?B?Y0RjMHZHZEhSMW1QMmd4Y2xFY0F4T1BTSHV1TDlXK0NBckdPQzZVdHNIWk5B?=
 =?utf-8?B?eFBMRnc5aEdDY1J4alNpR3l1b08rMHNuOUhxOWNPZEduN3ZLR29hNTFMR05D?=
 =?utf-8?B?U21VVFRmUnpaTTRBem1EbTRTV0JyRzdNQW9yOXJtaTBlczlOblIyTVF1bzBW?=
 =?utf-8?B?Z1hMQlVvQVB0WXV3RDYxSFJJelB5ZXFyWEtWenlvZ3lPTGxyczlSTlpkK1cr?=
 =?utf-8?B?OUVtOXExaDRvUjl1dzRDZXFQOUJVcGYrOTYzeEFNUHdQNHB3RWRYZnJadEJU?=
 =?utf-8?B?SklxWVBiM1ZmbitYR21OUlhxOXNWeHRHQlplK1RHdm1pNjNaZk4vSFMwS3Jj?=
 =?utf-8?B?OEtlRkJ1clVXRFNoTHZSTEc2SlZFYmRKOHgvT3RycmxtVURjWkxjUGU3ZnE0?=
 =?utf-8?Q?TpC10ZOs6ga/ShKrQW1YuvAMwYT1t8qIyzdN5lJ?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8129aeff-3d4a-4445-2e4b-08d98099f4ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2021 03:01:37.1562 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uQErT2PG9muIaP3MIH0yWr0i3yqHFbjnIRmNSzoiJyH0fBFlIHfDJt1K46JyJR39H2BdAgkPaDWgEkLUchQOrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3700
X-OriginatorOrg: intel.com
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Raj,
 Ashok" <ashok.raj@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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
> Sent: Sunday, September 26, 2021 10:43 AM
> 
> Hi Kevin,
> 
> Thanks for reviewing my patch.
> 
> On 9/24/21 11:16 AM, Tian, Kevin wrote:
> >> From: Lu Baolu <baolu.lu@linux.intel.com>
> >> Sent: Friday, September 24, 2021 10:30 AM
> >>
> >> The IOMMU VT-d implementation uses the first level for GPA->HPA
> >> translation
> >> by default. Although both the first level and the second level could handle
> >> the DMA translation, they are different in some way. For example, the
> >> second
> >> level translation has separate controls for the Access/Dirty page tracking
> >> and the page-level forcing snoop. With first level translation, there're
> >> no such controls. This uses the second level for GPA->HPA translation so
> >
> > first-level has no page-granular snoop control, but has a global control
> > in pasid entry.
> 
> Agreed. Will add this.
> 
> >
> >> that it could provide a consistent hardware interface for use cases like
> >> dirty page tracking during the VM live migration.
> >>
> >> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> >> ---
> >>   include/linux/intel-iommu.h |  7 ++-----
> >>   drivers/iommu/intel/iommu.c | 21 +++++++++++++--------
> >>   2 files changed, 15 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> >> index 05a65eb155f7..a5fb20702201 100644
> >> --- a/include/linux/intel-iommu.h
> >> +++ b/include/linux/intel-iommu.h
> >> @@ -517,22 +517,19 @@ struct context_entry {
> >>   	u64 hi;
> >>   };
> >>
> >> -/* si_domain contains mulitple devices */
> >> -#define DOMAIN_FLAG_STATIC_IDENTITY		BIT(0)
> >
> > this is a separate cleanup. better mention it in the commit msg or
> > put in another patch.
> 
> Sure.
> 
> >
> >> -
> >>   /*
> >>    * When VT-d works in the scalable mode, it allows DMA translation to
> >>    * happen through either first level or second level page table. This
> >>    * bit marks that the DMA translation for the domain goes through the
> >>    * first level page table, otherwise, it goes through the second level.
> >>    */
> >> -#define DOMAIN_FLAG_USE_FIRST_LEVEL		BIT(1)
> >> +#define DOMAIN_FLAG_USE_FIRST_LEVEL		BIT(0)
> >>
> >>   /*
> >>    * Domain represents a virtual machine which demands iommu nested
> >>    * translation mode support.
> >>    */
> >> -#define DOMAIN_FLAG_NESTING_MODE		BIT(2)
> >> +#define DOMAIN_FLAG_NESTING_MODE		BIT(1)
> >>
> >>   struct dmar_domain {
> >>   	int	nid;			/* node id */
> >> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> >> index d75f59ae28e6..c814fea0522e 100644
> >> --- a/drivers/iommu/intel/iommu.c
> >> +++ b/drivers/iommu/intel/iommu.c
> >> @@ -522,7 +522,7 @@ static inline void free_devinfo_mem(void *vaddr)
> >>
> >>   static inline int domain_type_is_si(struct dmar_domain *domain)
> >>   {
> >> -	return domain->flags & DOMAIN_FLAG_STATIC_IDENTITY;
> >> +	return domain->domain.type == IOMMU_DOMAIN_IDENTITY;
> >>   }
> >>
> >>   static inline bool domain_use_first_level(struct dmar_domain *domain)
> >> @@ -1874,12 +1874,18 @@ static void free_dmar_iommu(struct
> >> intel_iommu *iommu)
> >>    * Check and return whether first level is used by default for
> >>    * DMA translation.
> >>    */
> >> -static bool first_level_by_default(void)
> >> +static bool first_level_by_default(unsigned int type)
> >>   {
> >> -	return scalable_mode_support() && intel_cap_flts_sanity();
> >> +	if (type == IOMMU_DOMAIN_UNMANAGED)
> >> +		return false;
> >> +
> >
> > I think the order is not correct. what about 2nd level is even not
> > present?
> 
> Fair enough. How about
> 
> #1) hardware only capable of first level, return true
> #2) hardware only capable of second level, return false
> 
> (we fail iommu initialization if neither FL nor SL)
> Then, both FL and SL are supported.
> 
> #3) domain is type of UNMANAGED, return false
> #4) otherwise, return true.
> 
> Does this make sense?

sounds good.

> 
> >
> >
> >> +	if (!scalable_mode_support() || !intel_cap_flts_sanity())
> >> +		return false;
> >> +
> >> +	return true;
> >>   }
> >>
> >> -static struct dmar_domain *alloc_domain(int flags)
> >> +static struct dmar_domain *alloc_domain(unsigned int type)
> >>   {
> >>   	struct dmar_domain *domain;
> >>
> >> @@ -1889,8 +1895,7 @@ static struct dmar_domain *alloc_domain(int
> flags)
> >>
> >>   	memset(domain, 0, sizeof(*domain));
> >>   	domain->nid = NUMA_NO_NODE;
> >> -	domain->flags = flags;
> >> -	if (first_level_by_default())
> >> +	if (first_level_by_default(type))
> >>   		domain->flags |= DOMAIN_FLAG_USE_FIRST_LEVEL;
> >>   	domain->has_iotlb_device = false;
> >>   	INIT_LIST_HEAD(&domain->devices);
> >> @@ -2708,7 +2713,7 @@ static int __init si_domain_init(int hw)
> >>   	struct device *dev;
> >>   	int i, nid, ret;
> >>
> >> -	si_domain = alloc_domain(DOMAIN_FLAG_STATIC_IDENTITY);
> >> +	si_domain = alloc_domain(IOMMU_DOMAIN_IDENTITY);
> >>   	if (!si_domain)
> >>   		return -EFAULT;
> >>
> >> @@ -4517,7 +4522,7 @@ static struct iommu_domain
> >> *intel_iommu_domain_alloc(unsigned type)
> >>   	case IOMMU_DOMAIN_DMA:
> >>   	case IOMMU_DOMAIN_DMA_FQ:
> >>   	case IOMMU_DOMAIN_UNMANAGED:
> >> -		dmar_domain = alloc_domain(0);
> >> +		dmar_domain = alloc_domain(type);
> >>   		if (!dmar_domain) {
> >>   			pr_err("Can't allocate dmar_domain\n");
> >>   			return NULL;
> >> --
> >> 2.25.1
> >
> 
> Best regards,
> baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
