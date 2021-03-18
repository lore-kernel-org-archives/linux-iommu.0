Return-Path: <SRS0=56b4=IQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3A3C433E0
	for <iommu@archiver.kernel.org>; Thu, 18 Mar 2021 08:56:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 575AA64F30
	for <iommu@archiver.kernel.org>; Thu, 18 Mar 2021 08:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 575AA64F30
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ECE7D84189;
	Thu, 18 Mar 2021 08:56:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G0BRtN2WQydK; Thu, 18 Mar 2021 08:56:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id BF5E984176;
	Thu, 18 Mar 2021 08:56:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98176C000B;
	Thu, 18 Mar 2021 08:56:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CBECEC0001
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 08:56:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6989684178
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 08:56:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HYHfZz7d7ntR for <iommu@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 08:56:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8386284176
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 08:56:26 +0000 (UTC)
IronPort-SDR: ptfXiocqB34aYYxjORwb44do7oaAXBEZ1OD0tmiV/KjUqoENRou4KAPtHqu7O34QjPrRFbsQXI
 A5VtUQonpASA==
X-IronPort-AV: E=McAfee;i="6000,8403,9926"; a="189678427"
X-IronPort-AV: E=Sophos;i="5.81,258,1610438400"; d="scan'208";a="189678427"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2021 01:56:24 -0700
IronPort-SDR: qPcyqxkMAl9HNuiYGEJtQcrHSJDZMn+HpRSRHybTPfO7yC3KTitnLKJTT7dlEkBeWHVJCfYzGf
 Ow5NZI58eVog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,258,1610438400"; d="scan'208";a="433749057"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
 by fmsmga004.fm.intel.com with ESMTP; 18 Mar 2021 01:56:20 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 18 Mar 2021 01:56:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Thu, 18 Mar 2021 01:56:20 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.57) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Thu, 18 Mar 2021 01:56:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PHtetM8nt3zcAYWzd6AhFmszmcBCmpLbbAt3ddqH+xOD5gONnR3LTw9I3pJNwc626j3Sqo+ptpXTqLSCPAgc6g+OGLc+66SMCAGg3kXjF98/QHkZCe97eHGT8dRNGQlmzjLVAoMoPskxpk03HaFYt0VaXXIKpIk0Xwnm+KvEQqCy8RsYP3q4UqLurRfIPvcHXHhGYmi2ZfW79B2qaU5MhizkpQb2HwNF7ZsUPjWCivgh893830Gky6jcPviofdxx3Tsi4MdAtkYll9+k4p2qq/f/7jUMp88PA21WkIZGjx1J0L+jU61vAu5ZK77+dCMTbv92nh4NzhQmwS/6xPEZwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nc60O9wLT2PG80oD7UfBPup74TfUNm8ArplUzKhreH0=;
 b=g0IjOiJ03+GO+BmZjaWyP1oq9FK7uMV1Nz76z2C8MUOQggU67pA2ZFLr4NAiUYjrfaagXhzNudKPHJTeX7v51o47yl9rL2tLugotHjmhpocBt/8e47W05uA2xLi5VOLdWRPJ5S+lgcf7MB3MbNmCyivNPjdaoNCpbxsPfm+Hf5LbHABebxnchGuUzvWd2xcF1bvIxKBNcYhrfncOzkotaDLrd/irrd9DvoYhxKiO6TWyAT3jfmuIB2jHl8eGMDySRpkE4Y8WGLLHZHOv7HYbhfAEmi7sBajBZvqF0YUuWG3vzXT25R+BAhi0jlZnNrVJuDHpmpiYY5VnhL1xyrgDCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nc60O9wLT2PG80oD7UfBPup74TfUNm8ArplUzKhreH0=;
 b=qT9AwXwbVh+sMdVIEHdmIBsbC/z53Aa3LRn8Kzq2Aho7FnbslDWlhJ5BsVSb1a3S5pTqxLaNdd3lEWon7kNgC9ffdbGXJP29AIa0vH6zRpaghzwGoFnkHj04/u529o8lFS8DhsB4KzfcBtJ5gp1A/Y87osL9NEdl/+7BQrdXpcc=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by MWHPR11MB1328.namprd11.prod.outlook.com (2603:10b6:300:2b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Thu, 18 Mar
 2021 08:56:10 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29%9]) with mapi id 15.20.3955.018; Thu, 18 Mar 2021
 08:56:10 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)"
 <longpeng2@huawei.com>, Nadav Amit <nadav.amit@gmail.com>
Subject: =?utf-8?B?UkU6IEEgcHJvYmxlbSBvZiBJbnRlbCBJT01NVSBoYXJkd2FyZSDvvJ8=?=
Thread-Topic: =?utf-8?B?QSBwcm9ibGVtIG9mIEludGVsIElPTU1VIGhhcmR3YXJlIO+8nw==?=
Thread-Index: AQHXGuJY/V4R/VN0mE2jjNDTL4ZYXKqHq9kAgABAOICAAJBrAIAA7MAAgAABDOCAAAQ5AIAAA1+w
Date: Thu, 18 Mar 2021 08:56:10 +0000
Message-ID: <MWHPR11MB18861A144C085677931922018C699@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <670baaf8-4ff8-4e84-4be3-030b95ab5a5e@huawei.com>
 <FB4E11A5-84D4-4DAF-889E-FAA1BCD2E66F@gmail.com>
 <6a218e7fe42d41489d02f0b4e3ad2756@huawei.com>
 <98DB71EF-FF98-4509-85EC-26FF50825A58@gmail.com>
 <4d1c3bc0418e48b1b9d44799d65ea375@huawei.com>
 <MWHPR11MB18860801196A9319EBD96AF68C699@MWHPR11MB1886.namprd11.prod.outlook.com>
 <d7bb4ab26b8542c698926b7a0a3fc12c@huawei.com>
In-Reply-To: <d7bb4ab26b8542c698926b7a0a3fc12c@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [101.88.226.48]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ff8ba82-b8b0-42ce-9d69-08d8e9ebad35
x-ms-traffictypediagnostic: MWHPR11MB1328:
x-microsoft-antispam-prvs: <MWHPR11MB132808E1EB6FFBE788FFA5218C699@MWHPR11MB1328.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bGwYkyI5722xwIW3KZvddfh0+K7aZvT3UGLNTk70wNtnlyWPbvl7J7UoFI46a+Mp0oZcse3MXdcXhSZPPrZ0TJdy8l9L/X6NCB18qHk25zhMQ7tbtE59LWcg8KJpp9CypyGYYoLwc2t5jDlBRC/uk9OxkRleGzqZKC4QNqcQX86INu6zHRjERLkjWGbTIX2J4KuTN66b/69yODL4xF/5q9rrZDLksXzlEB336NCdhImoxsaHxlgQdePyPsp6+Bbve5nAdMa7CFQ4YWUKRDTCy85RrqlR6NqJaRRT8GOT7PA/AqS78itQWdyL2D6UJSNbHzGJyuriudl/jiI++dbmCycYUh4rZIRTwjeNuROFvLElVpPNc5T+W8NiPgNq+5B9Hik8blLbgb8ZN3YeUR6xh1+uLPALh3R9VNT6qYzwhZLe2i0d2GVLE6E8Ou8lfTSVDk7UFACR2BMwpsz15ZhqYvZa3qUCfZrHxoG1NOnsuheLTjf8e9+z3gceu+DaPVC50OBgD7ud/HXuiFO1HKoDueN9Kwi1yMgVfAH7+VY0BaHbDXbj4TnpzzMWwsZjR/1c3KNm+lXKnE3A3ohU+ZntjKNNMOOkERB8YW7j4H/8dvtFE416f0ibglHoHagnjcqF
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1886.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(376002)(346002)(366004)(396003)(136003)(39860400002)(55016002)(54906003)(71200400001)(186003)(110136005)(316002)(4326008)(9686003)(33656002)(8936002)(64756008)(86362001)(66476007)(478600001)(83380400001)(26005)(5660300002)(52536014)(7696005)(66946007)(66556008)(53546011)(76116006)(66446008)(6506007)(2906002)(38100700001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?Zm5wZEZtTkdteDZSQ1pWa0tSaElSU2QxQ2NzckpwN2EyRG1pbWZUWlRPTmkw?=
 =?utf-8?B?RVZSQnVtcGZ1dGZ3NkJVQzVoTGxCRFZiSTFIUTNaekM0bUZWQ1BKK1ZTK2hD?=
 =?utf-8?B?d0hkSEZGelJrN2N0S1cvbjVSUmJqaVdrTEJZRjJLeHRHV3E1VnIycUliQmRy?=
 =?utf-8?B?OFExclllem5SSVJaSFgwRE42OVBhS1d0TFVHOE92dDFaODZ4MHc5WldWc1pJ?=
 =?utf-8?B?ZGt1V25ITHhDbTU2dG5WZU9WOHQ0QVlQSnVya1NWRUlnWSt2ampUeVdDUTkv?=
 =?utf-8?B?azNQTVpVNU9ENUlQMXRUMGVJSlZHSmNJMDBqeEJodk1zUi91OVltM3p3QTRm?=
 =?utf-8?B?cWFYY1BiY1Q5cUc4M2hwZEJVYURyTGtjYS9pZit4WGxpTHY5eFdqMkc0bWly?=
 =?utf-8?B?azUxUEZSUitCRlh2aGlQY2t3V0FSSXMrSi8xdXRtTndFbGF2L2VEWnlQSG5o?=
 =?utf-8?B?eU94bFB5MzcwQTc5MTVWQUJFZVlZWE5uK0FId29wZE5uOEFWNjZMQ054WHZ3?=
 =?utf-8?B?b01PdWxqQ2o5VWd2bVoyU2d3eVVaTFU2YmhzLzRkVXIraFluY2ozb3AySnhh?=
 =?utf-8?B?SWgvRzBZOURBSkNiUlZ2ck5lMlJ6RnZKNjNYdWlnOEU2Uy9uK0NXeGFtb1F3?=
 =?utf-8?B?V2ZkNXpHMzU4dlNienNaMVZEOGYwTFo3c2U4QVZodG85NGJmbGdrV3BISm4z?=
 =?utf-8?B?dXdTbk13RElsUnpVUDdORnp5MFNlWEtmcmlFQWJkTkVpMlkwWElYL1FzaHNT?=
 =?utf-8?B?NXkzckNEOFB6NEVRemcwWUFSM3dBUDdoNG81dWZqd2ZMTEVEcEhCZTFybFBU?=
 =?utf-8?B?a1c5NlU0QkRRMEtEajQ0V1luYTdrT3dnZDJyNDd5TkFmSzRPUGlFa3JNb3Fr?=
 =?utf-8?B?ZU85MU1yRmlVUzR4QWtqWVJjMEFYUDZPUXpBYmVKNGJhczFFOVFVVjdUekdD?=
 =?utf-8?B?alFGenMvWnRtVlYySXBtREdlWHFCanVsUlZXRjJBOUNjRHAxcWpPT0ZkdS9n?=
 =?utf-8?B?a0ROblhqejUra3lBV2NJdlZ4TW14MklLTzc3SXcyUHlWN2cwZW1OKytrK1N2?=
 =?utf-8?B?bzFZWUdOV0J6S0ZJd1FEUUFSQmZNc0NqYm1yekpycDhxdWJkVWlpQ1lxbkJH?=
 =?utf-8?B?ZVpFWXpZd3REZGdQeTdIWmhGcWJMY1lGakpjendhSll1MDZZRlRXWXZxMnpX?=
 =?utf-8?B?aTMyMUx3NHAxVll4R1NOck16TlpPUEh5d25GVGlTWmNiYjFpUkg1R3lmYTd6?=
 =?utf-8?B?d0pVbGd5VE1xa0J5UVhIY2Z0eUJ3U2VuZkZveXAxOWdPdHJQbUtyWUgzeFdz?=
 =?utf-8?B?TXBJdTkzSHRkZXR0cmorZm1zSEZQOXQvRExZS3B4cktId2NEWW1VMm56ZHhs?=
 =?utf-8?B?elllUXI1RWxuc2xTUGZyNFErc2dTei85bDVTTzk0TkFPbldlY2FoUjBYTFRs?=
 =?utf-8?B?aEhaeG1xZFBWd1pNaXB6bUF4bEtaTm9JVWkrREVKblBLdHdPWkhzKytENnZo?=
 =?utf-8?B?c1l0clFoQ3E3Rk84NTVjZU5WZHoyaXBMTVlFekdmNzkzK2lIclNrUy9vd1o0?=
 =?utf-8?B?VWkvNUJmd0R4UDR3RzRFRGNZSHFKbFEyV2FFSjFxcDAvc2tJK1pFSnRwZ0NR?=
 =?utf-8?B?SDZsY1BsWjF1L1N4aVdWSnBPYVBjVVZyb2daUjJVRlFhWFBmdGpwdnF4aEl5?=
 =?utf-8?B?MVZvKzBkK1hpZnpKS0ZPMmxGYVYrc0ZrblNvMEEzcDk0K3hrdWo0V0pmTjBu?=
 =?utf-8?Q?DORw20DawegcGE9xtH8KUnqxK21NDwJWusDr5R0?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff8ba82-b8b0-42ce-9d69-08d8e9ebad35
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2021 08:56:10.4274 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Eufk9x6NAb+7vyTL0rQkX+PmtDjnopXFB0ZgdLqy6JTXfKzL6MgvyFV6hpYo2BNIjjYxxCpE5PTdvnCiTk4tPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1328
X-OriginatorOrg: intel.com
Cc: chenjiashang <chenjiashang@huawei.com>, "will@kernel.org" <will@kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 David Woodhouse <dwmw2@infradead.org>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

PiBGcm9tOiBMb25ncGVuZyAoTWlrZSwgQ2xvdWQgSW5mcmFzdHJ1Y3R1cmUgU2VydmljZSBQcm9k
dWN0IERlcHQuKQ0KPiA8bG9uZ3BlbmcyQGh1YXdlaS5jb20+DQo+IA0KPiA+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogVGlhbiwgS2V2aW4gW21haWx0bzprZXZpbi50aWFu
QGludGVsLmNvbV0NCj4gPiBTZW50OiBUaHVyc2RheSwgTWFyY2ggMTgsIDIwMjEgNDoyNyBQTQ0K
PiA+IFRvOiBMb25ncGVuZyAoTWlrZSwgQ2xvdWQgSW5mcmFzdHJ1Y3R1cmUgU2VydmljZSBQcm9k
dWN0IERlcHQuKQ0KPiA+IDxsb25ncGVuZzJAaHVhd2VpLmNvbT47IE5hZGF2IEFtaXQgPG5hZGF2
LmFtaXRAZ21haWwuY29tPg0KPiA+IENjOiBjaGVuamlhc2hhbmcgPGNoZW5qaWFzaGFuZ0BodWF3
ZWkuY29tPjsgRGF2aWQgV29vZGhvdXNlDQo+ID4gPGR3bXcyQGluZnJhZGVhZC5vcmc+OyBpb21t
dUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZzsgTEtNTA0KPiA+IDxsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnPjsgYWxleC53aWxsaWFtc29uQHJlZGhhdC5jb207IEdvbmdsZWkNCj4gKEFy
ZWkpDQo+ID4gPGFyZWkuZ29uZ2xlaUBodWF3ZWkuY29tPjsgd2lsbEBrZXJuZWwub3JnDQo+ID4g
U3ViamVjdDogUkU6IEEgcHJvYmxlbSBvZiBJbnRlbCBJT01NVSBoYXJkd2FyZSDvvJ8NCj4gPg0K
PiA+ID4gRnJvbTogaW9tbXUgPGlvbW11LWJvdW5jZXNAbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmc+IE9uIEJlaGFsZiBPZg0KPiA+ID4gTG9uZ3BlbmcgKE1pa2UsIENsb3VkIEluZnJhc3RydWN0
dXJlIFNlcnZpY2UgUHJvZHVjdCBEZXB0LikNCj4gPiA+DQo+ID4gPiA+IDIuIENvbnNpZGVyIGVu
c3VyaW5nIHRoYXQgdGhlIHByb2JsZW0gaXMgbm90IHNvbWVob3cgcmVsYXRlZCB0bw0KPiA+ID4g
PiBxdWV1ZWQgaW52YWxpZGF0aW9ucy4gVHJ5IHRvIHVzZSBfX2lvbW11X2ZsdXNoX2lvdGxiKCkg
aW5zdGVhZCBvZg0KPiA+IHFpX2ZsdXNoX2lvdGxiKCkuDQo+ID4gPiA+DQo+ID4gPg0KPiA+ID4g
SSB0cmllZCB0byBmb3JjZSB0byB1c2UgX19pb21tdV9mbHVzaF9pb3RsYigpLCBidXQgbWF5YmUg
c29tZXRoaW5nDQo+ID4gPiB3cm9uZywgdGhlIHN5c3RlbSBjcmFzaGVkLCBzbyBJIHByZWZlciB0
byBsb3dlciB0aGUgcHJpb3JpdHkgb2YgdGhpcw0KPiBvcGVyYXRpb24uDQo+ID4gPg0KPiA+DQo+
ID4gVGhlIFZULWQgc3BlYyBjbGVhcmx5IHNheXMgdGhhdCByZWdpc3Rlci1iYXNlZCBpbnZhbGlk
YXRpb24gY2FuIGJlIHVzZWQgb25seQ0KPiB3aGVuDQo+ID4gcXVldWVkLWludmFsaWRhdGlvbnMg
YXJlIG5vdCBlbmFibGVkLiBJbnRlbC1JT01NVSBkcml2ZXIgZG9lc24ndCBwcm92aWRlDQo+IGFu
DQo+ID4gb3B0aW9uIHRvIGRpc2FibGUgcXVldWVkLWludmFsaWRhdGlvbiB0aG91Z2gsIHdoZW4g
dGhlIGhhcmR3YXJlIGlzDQo+IGNhcGFibGUuIElmIHlvdQ0KPiA+IHJlYWxseSB3YW50IHRvIHRy
eSwgdHdlYWsgdGhlIGNvZGUgaW4gaW50ZWxfaW9tbXVfaW5pdF9xaS4NCj4gPg0KPiANCj4gSGkg
S2V2aW4sDQo+IA0KPiBUaGFua3MgdG8gcG9pbnQgb3V0IHRoaXMuIERvIHlvdSBoYXZlIGFueSBp
ZGVhcyBhYm91dCB0aGlzIHByb2JsZW0gPyBJIHRyaWVkDQo+IHRvIGRlc2NyaXB0IHRoZSBwcm9i
bGVtIG11Y2ggY2xlYXIgaW4gbXkgcmVwbHkgdG8gQWxleCwgaG9wZSB5b3UgY291bGQgaGF2ZQ0K
PiBhIGxvb2sgaWYgeW91J3JlIGludGVyZXN0ZWQuDQo+IA0KDQpidHcgSSBzYXcgeW91IHVzZWQg
NC4xOCBrZXJuZWwgaW4gdGhpcyB0ZXN0LiBXaGF0IGFib3V0IGxhdGVzdCBrZXJuZWw/DQoNCkFs
c28gb25lIHdheSB0byBzZXBhcmF0ZSBzdy9odyBidWcgaXMgdG8gdHJhY2UgdGhlIGxvdyBsZXZl
bCBpbnRlcmZhY2UgKGUuZy4sDQpxaV9mbHVzaF9pb3RsYikgd2hpY2ggYWN0dWFsbHkgc2VuZHMg
aW52YWxpZGF0aW9uIGRlc2NyaXB0b3JzIHRvIHRoZSBJT01NVQ0KaGFyZHdhcmUuIENoZWNrIHRo
ZSB3aW5kb3cgYmV0d2VlbiBiKSBhbmQgYykgYW5kIHNlZSB3aGV0aGVyIHRoZQ0Kc29mdHdhcmUg
ZG9lcyB0aGUgcmlnaHQgdGhpbmcgYXMgZXhwZWN0ZWQgdGhlcmUuIA0KDQpUaGFua3MNCktldmlu
DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBt
YWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
