Return-Path: <SRS0=sMz+=LM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE552C48BDF
	for <iommu@archiver.kernel.org>; Fri, 18 Jun 2021 16:57:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A40361248
	for <iommu@archiver.kernel.org>; Fri, 18 Jun 2021 16:57:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A40361248
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6664E837AC;
	Fri, 18 Jun 2021 16:57:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id znkwEiw_NGAy; Fri, 18 Jun 2021 16:57:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 54BB183720;
	Fri, 18 Jun 2021 16:57:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 37847C000D;
	Fri, 18 Jun 2021 16:57:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BF2A5C000B
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 16:57:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A0211415D6
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 16:57:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SST8WOdCEEWT for <iommu@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 16:57:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8E55C41585
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 16:57:45 +0000 (UTC)
IronPort-SDR: L+PRut72NheUCtU5vY5AVdTCes5MufPBWiQ8PR28C3pbsrjBaMkiKkNOJVjdqZiz1nAza0cvqb
 tL1YD79sS+zQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10019"; a="193899970"
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; d="scan'208";a="193899970"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2021 09:57:44 -0700
IronPort-SDR: S4xW0ZOBDK3iqCbhFoctWjFaGcRZUlpMgbeXbr7XKLKS/mIu4815FG8Qj8JkW/0+Xhus46NOpr
 KmRkVXGWWT2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; d="scan'208";a="405026079"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orsmga006.jf.intel.com with ESMTP; 18 Jun 2021 09:57:43 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Fri, 18 Jun 2021 09:57:42 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Fri, 18 Jun 2021 09:57:42 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Fri, 18 Jun 2021 09:57:42 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Fri, 18 Jun 2021 09:57:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YkFiqbCdhZUHXrP3pVmQkTTZOFp/GDyRVaMI1M0ohJSHW7DcHbJR8Ck1sjexGxfchZOIPokCaF0l8++aHH65trw4cRWklwA1r6WKh23yCjv4upmXFB+Q8yGZKezEGekZwZRQEi2pVd67Z0mfg4rfDFnKKN9ai7BavLFCsfE0tv6dSdjJatS2WnRZ5KBudR4xKlHFB7jyCqRV1hY2YavV8uDetWBCuOOWDDEWC9cNhYWX0Mxt9Sv3LcpNGYsUwL1oqwc6B9rpAI3/Z684OAUr24IjvTSfWtpn8RLz5HCJp7IN3LHyhFFU9clDvW6WFIEYWrOcHrbjcD9bXl+7wFgrXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UV0SbCj1g+zpB3cwOVNetcTJ5x8uM3lW4xH0Z3jY8A8=;
 b=flktnb+rpEsHOTGth/arwX+KVyZ8tGpYDDzcBK2UOQcdKUpKtH564NitOx0pv0I0QY/zwNSN9a+Ms5S5mci22D5eAfOEeiQmzJodYxCXabyJ8JeRwx6sRnHV5hOx+z2uu8Msj+kWeakMTn5/XJp1B6rUO2EbP39chN8WTDAqSIylQuUzYgbleSafQFZOcqyH+MLxlzoxdtsPUO5Cw2/T/2Os32gq8tGyTcmDzyUdQ8nmo30bcvy/vNpcjiIUUAhgCPsuVmQW2cjR8zEUHD3hPHjVcZzVyT5JjVFmedJiNSOfqjFZX0q78VuHVvKTn35WUWKggZbPczB+SMfF76cz0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UV0SbCj1g+zpB3cwOVNetcTJ5x8uM3lW4xH0Z3jY8A8=;
 b=GUT+ykG5MLQoQe8rIgKoJ8lJcGa4274j0TyHKcjwSTyTeKRqC/I4nmp6YLWlVKuOsPyM5tW4Hqv4371vDSqhn07bd8u3t37p3pOcB0zOJZXRLljBaqMblyl66gz2kYdtchGeIgfyV+cd5pPti01aoCqPzCDhAZyHQFNZfo4fQ9M=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by CO1PR11MB4996.namprd11.prod.outlook.com (2603:10b6:303:90::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Fri, 18 Jun
 2021 16:57:40 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::6597:eb05:c507:c6c1]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::6597:eb05:c507:c6c1%12]) with mapi id 15.20.4219.027; Fri, 18 Jun
 2021 16:57:40 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson
 <alex.williamson@redhat.com>
Subject: RE: Plan for /dev/ioasid RFC v2
Thread-Topic: Plan for /dev/ioasid RFC v2
Thread-Index: AddbO/WEUAFl3MPnRsG8exiH8bwEagB7l+uAAACIfoAAAdwYAAADDw6AAAHKgwAAANd4AAAAacwAAAT4QwAAK587AAA0n7GAAAYKlwAADDvuAAAgbLGAAF6lSYAABO0WAAATSRtQAB5ymYAAEyKHQAAmZhSAAAo/ocAAK16TAAAGdqAAACJdiVA=
Date: Fri, 18 Jun 2021 16:57:40 +0000
Message-ID: <MWHPR11MB1886A17124605251DF394E888C0D9@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <20210612012846.GC1002214@nvidia.com>
 <20210612105711.7ac68c83.alex.williamson@redhat.com>
 <20210614140711.GI1002214@nvidia.com>
 <20210614102814.43ada8df.alex.williamson@redhat.com>
 <MWHPR11MB1886239C82D6B66A732830B88C309@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210615101215.4ba67c86.alex.williamson@redhat.com>
 <MWHPR11MB188692A6182B1292FADB3BDB8C0F9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210616133937.59050e1a.alex.williamson@redhat.com>
 <MWHPR11MB18865DF9C50F295820D038798C0E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210617151452.08beadae.alex.williamson@redhat.com>
 <20210618001956.GA1987166@nvidia.com>
In-Reply-To: <20210618001956.GA1987166@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.142.30]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 507a175a-4a08-444f-8071-08d9327a2f20
x-ms-traffictypediagnostic: CO1PR11MB4996:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB4996D44C081074EB50E902B38C0D9@CO1PR11MB4996.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g2DbI/XqO3lX77bsF1XjBHMuoMT7bOcpCeKqFOYy3d5e8iCFfyUvxovBKoN0LP3CmEP/WI0lqsevSZw4z9UuoWIWCYV68vR6d26UvsS3fHkmZjyKJrT42FhvMdUTUh44WjuXcxzm0JwYdIObdCFnEQfNV7gmE1xGwSPfJjpQlNXbEUfNBKJX0/j76SJYQbBgLNSnSI0ZdCymfE1nJMHcFFwyo+egoBfVSGgcePKOZkxKEZCVhj6TuDXWoLm76kzgvwbZw5WtH5LQoByT7miFASZUYGMbmvyjyGcX0ZLZH+V4XJswqsy7cDeN09z+TaHeTxNIlp/1LqQR/7/E3TvVfioKUOHoX8lDzttSsSPOWjILsTsUov0m93Qp/71fNMt60IkhA3XB10oSSAE/Kjbul0ZQGOIubMzYsUNCLFygzxZRlXKdJC9LBktE+fgkx3Kk9I/KKXSbRWbnIR6nKxZXSEOfE+OQST5ETSTRaV14BOFZaQlAgYOty0VdO/KPMlfiF+7CLMNMrEVQP9Uogmulp3tmMhbukawN8T56Z6azh6f5GBhOnQjrvWoPp5fIGOFy4R10Y3nUcBldLlX1n9WZe0LtYvyAxfC0aL3Tey6o074=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1886.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(39860400002)(346002)(396003)(376002)(366004)(136003)(54906003)(186003)(5660300002)(7696005)(8936002)(316002)(478600001)(33656002)(76116006)(66476007)(64756008)(52536014)(26005)(66946007)(66556008)(110136005)(6506007)(7416002)(38100700002)(66446008)(71200400001)(122000001)(8676002)(2906002)(55016002)(9686003)(83380400001)(86362001)(4326008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EDnJRwnxBBD5n9jfO3P98kfqqB2t7xkd/E4XNNfKcQUOblyfXlWPCe99P30S?=
 =?us-ascii?Q?wRg1tX/EawREgNXRVAmv6LycdACZf4RKYABVWTW76qJ1gEaqtbrcDTN/WiaZ?=
 =?us-ascii?Q?gVi7AlNU7GOzB7HbBKFIIoehHE8IZSeEqmX7NpYTEepbgQ2rA0Ht/qKz8EYX?=
 =?us-ascii?Q?y7bE9FKqukG5kQ7lEuCBp601PlSFGPvzx/kp632kuoOUE3l0LapoRAqIIxK7?=
 =?us-ascii?Q?R6O0IN4ja3E7UV1ZeB3P6bJbzxW7urAdT35SUP28f9TKOBTZ4801dNrkEj1P?=
 =?us-ascii?Q?sc9aVu1y8w/lus5zVpmVZq5oO6k2k5qvl7QoQWZdmLmLHyu6246zcm8Aea/i?=
 =?us-ascii?Q?3MPqzghiA8+qKy3pq7tx3bsydmioL8SgZHvI+yExL5yFyO4bLMuVBnz33u/W?=
 =?us-ascii?Q?oaXqFhVO/wbXkSDK4Xw/2hiAwaBDssyVcCwSjZYSENKWr7AC9TOscIAiWD9M?=
 =?us-ascii?Q?Z70KHaTDNl21ZzZyd4hWC0rwKA+ixbUbJ19ZkIxA2LhO3mRYFTShL2Axq1o+?=
 =?us-ascii?Q?rhwaPuOh6brxxCNY2GDUWn41CplP9b57jHOdS9IzEkE6+6XDM35eeFKldABn?=
 =?us-ascii?Q?OLWHxHkDXAxDcisNWg8rotFfWhg6FlpvO5b/k6oX+TRXVQDE1vMyko9vH4L9?=
 =?us-ascii?Q?B2lqtq9r0HeikAemoADJuR7UM2QvyP21njGawnOciHhVXagrhz7AmvVkBG8d?=
 =?us-ascii?Q?NTs9nCxQfURZO81lcL+6bhjawsMIVapIswokD0eUprdZH9IlX/5gAWU9xsCz?=
 =?us-ascii?Q?Iy1k5S1wFK2Q9TuR50AnlV66aRMpGic+Mn2fxyqxj2kahRBVsppAUHoGWXpK?=
 =?us-ascii?Q?Gvm/fTnNWKNl0wIW4nA2TfLerILzHPEk00iYIqEW5SaCAfXSeilP2iY+cfTQ?=
 =?us-ascii?Q?bT/YWkH+aPdGYx/gfD27r9DkGbGdGcyyp7QyzTdv01wnahxbRJwgi6/YoCnv?=
 =?us-ascii?Q?z5tzN5gmwGTVHIvEAW71fVt2q7NfipXMTCwGApVtAxYN7vHKkXQW/7YJE7Ad?=
 =?us-ascii?Q?JwmMu3sXkfeuvc/NRroxWGPi1xRq7K3uHOJ3pzGIrY1czsPqCRxFGdeTBww6?=
 =?us-ascii?Q?cCHocy7e/L9IKXXcWZ1FMGmsfmCIDpXLhBzx3KsIeqyoNreODn333g0oL0ZX?=
 =?us-ascii?Q?ocD1r0gRrN7y9z1/qiKoDsFjFFEo5ix6ldp8Hs72uOzfLNHsHm2+upbYl/LU?=
 =?us-ascii?Q?QHTcDZ7F9udPzmPmDCM0b4iIyRwVqw1Tk0FQ+ZJiVacUCu6VEOhVvR2Iaeys?=
 =?us-ascii?Q?K/9QUFFf6zUeu0AU2MUccLGh2yrJMoW50soBHHl02WdkgevUK0iwF5kUIMLb?=
 =?us-ascii?Q?kamCKB4jH//IgZx0r3coiXEH?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 507a175a-4a08-444f-8071-08d9327a2f20
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2021 16:57:40.5994 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LyqFdgzAzbWAZaridupLavRE/CC07D4l4Qr1hX7TA6RtUjm++221JPaqxOIHEh4MppMXJzwUFlUL7aUXKvE6rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4996
X-OriginatorOrg: intel.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jason Wang <jasowang@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, 
 Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 "parav@mellanox.com" <parav@mellanox.com>, "Enrico Weigelt,
 metux IT consult" <lkml@metux.net>, David Gibson <david@gibson.dropbear.id.au>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Shenming Lu <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>
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

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, June 18, 2021 8:20 AM
> 
> On Thu, Jun 17, 2021 at 03:14:52PM -0600, Alex Williamson wrote:
> 
> > I've referred to this as a limitation of type1, that we can't put
> > devices within the same group into different address spaces, such as
> > behind separate vRoot-Ports in a vIOMMU config, but really, who cares?
> > As isolation support improves we see fewer multi-device groups, this
> > scenario becomes the exception.  Buy better hardware to use the devices
> > independently.
> 
> This is basically my thinking too, but my conclusion is that we should
> not continue to make groups central to the API.
> 
> As I've explained to David this is actually causing functional
> problems and mess - and I don't see a clean way to keep groups central
> but still have the device in control of what is happening. We need
> this device <-> iommu connection to be direct to robustly model all
> the things that are in the RFC.
> 
> To keep groups central someone needs to sketch out how to solve
> today's mdev SW page table and mdev PASID issues in a clean
> way. Device centric is my suggestion on how to make it clean, but I
> haven't heard an alternative??
> 
> So, I view the purpose of this discussion to scope out what a
> device-centric world looks like and then if we can securely fit in the
> legacy non-isolated world on top of that clean future oriented
> API. Then decide if it is work worth doing or not.
> 
> To my mind it looks like it is not so bad, granted not every detail is
> clear, and no code has be sketched, but I don't see a big scary
> blocker emerging. An extra ioctl or two, some special logic that
> activates for >1 device groups that looks a lot like VFIO's current
> logic..
> 
> At some level I would be perfectly fine if we made the group FD part
> of the API for >1 device groups - except that complexifies every user
> space implementation to deal with that. It doesn't feel like a good
> trade off.
> 

Would it be an acceptable tradeoff by leaving >1 device groups 
supported only via legacy VFIO (which is anyway kept for backward 
compatibility), if we think such scenario is being deprecated over 
time (thus little value to add new features on it)? Then all new 
sub-systems including vdpa and new vfio only support singleton 
device group via /dev/iommu...

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
