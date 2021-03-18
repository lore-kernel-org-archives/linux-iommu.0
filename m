Return-Path: <SRS0=56b4=IQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED650C433E0
	for <iommu@archiver.kernel.org>; Thu, 18 Mar 2021 08:43:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B4E864EF9
	for <iommu@archiver.kernel.org>; Thu, 18 Mar 2021 08:43:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B4E864EF9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 49ADF6068A;
	Thu, 18 Mar 2021 08:43:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3qGgbiqevQRm; Thu, 18 Mar 2021 08:43:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0CC1960667;
	Thu, 18 Mar 2021 08:43:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C7FA1C000B;
	Thu, 18 Mar 2021 08:43:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 65552C0001
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 08:43:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 48AB04ED30
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 08:43:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O7MiqMMdzias for <iommu@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 08:43:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CA4ED48F6D
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 08:43:30 +0000 (UTC)
IronPort-SDR: oVD79g8IOSxLi5K2a0MJnta4A4JU9mfc1j/ly4s/b5umNQfesu/KXIV4+McSD8ttoNxOBtSW7+
 bTks/htytb9w==
X-IronPort-AV: E=McAfee;i="6000,8403,9926"; a="250987166"
X-IronPort-AV: E=Sophos;i="5.81,258,1610438400"; d="scan'208";a="250987166"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2021 01:43:29 -0700
IronPort-SDR: cFkGwcFolkl3EJLtkhVlEzwLg42cWVkTt5U+9E2j1KQK8xFOMhSuzcmGPPnC0CilSiXoXVYWWj
 LDmSvdWCy1IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,258,1610438400"; d="scan'208";a="512041486"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
 by fmsmga001.fm.intel.com with ESMTP; 18 Mar 2021 01:43:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 18 Mar 2021 01:43:28 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 18 Mar 2021 01:43:28 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Thu, 18 Mar 2021 01:43:28 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Thu, 18 Mar 2021 01:43:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GN4QFNvu4vGjds8lv8DsNzJiHhq/jU3QTMBZgKA7Y3iffx9cyIonw6oCNkKinK8Kj4uYb9XBf+iRjYVRyUBUF3AlE3G2Woox8TbRobK4DE5CxHyfiz6Eby3LtH9Z2sKVktWgQZHBwfUEZ2nnb9PhXCH0wy3Nf+tzSrqUdSuxeNhQl6FMYfb3sQYWoxKWtg2NybMhvBSwehRM2isGqRXUCIn2ZhJ2Mz76AzmJoPJdV0wwEKnld5I7cDlDY6fE+GhtwPJfJ3jv1QQXWmzALb0smoCtt6W2R2kWG5uEkhqTqdogvxNDohxDvIxY+7Qnjtcb3XBDc1qHuQRQpN7JvG5C5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUzLm9k8Y6nh/qbBEf3hPRVlK28/FiFuBXzrZ4M/h0U=;
 b=bnCq9UpIUPdg1g9QwVc6U6UPFrEE85fQwz2LYu1+27B/l7Z1cK5T0q142XF7mf1zmLkQ39xf8/y0lIYAOWoYKx5K84EScG1uwaB54egs0nD5zvWpdJvikk8GaDTnf9tkVgReZCWBqT4iyrUIx/G18yN47eZ3iVI1oFyZC3J++d+VUZAfBEhkRPmbDG2sUDI6vDaEfRwmRGo0VOHQqGpBPzoROZBL7y2792+RJR1yZlAW/BBh9QbaWzbhthPB27mp85ho/wV1DA9aspG6m3TvGM8NnxFrVy6A/9pe8Ubfo5ydEGxSIcnBaet108WCBzI+US3sdd5wUDp8lrWvS1DSaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUzLm9k8Y6nh/qbBEf3hPRVlK28/FiFuBXzrZ4M/h0U=;
 b=FCDHxWoR70KHrbT3RNPYs/ax0yt48j0lnN+JC0oE8JC1l6hTtfOrhkqvK/uIEDcxGIftF7EZxIq8QhTo8iC//fcnswdoZOSQOfRasA4O3Pm2XXGa32qa0u51ZaLUoPIhvrlQ708ag+c0uUIJIC8os1J/r6yxZyyUmnl3/sqjzoU=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by MWHPR1101MB2222.namprd11.prod.outlook.com (2603:10b6:301:57::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Thu, 18 Mar
 2021 08:43:26 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29%9]) with mapi id 15.20.3955.018; Thu, 18 Mar 2021
 08:43:26 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)"
 <longpeng2@huawei.com>, Nadav Amit <nadav.amit@gmail.com>
Subject: =?utf-8?B?UkU6IEEgcHJvYmxlbSBvZiBJbnRlbCBJT01NVSBoYXJkd2FyZSDvvJ8=?=
Thread-Topic: =?utf-8?B?QSBwcm9ibGVtIG9mIEludGVsIElPTU1VIGhhcmR3YXJlIO+8nw==?=
Thread-Index: AQHXGuJY/V4R/VN0mE2jjNDTL4ZYXKqHq9kAgABAOICAAJBrAIAA7MAAgAABDOCAAAQ5AIAAADjw
Date: Thu, 18 Mar 2021 08:43:26 +0000
Message-ID: <MWHPR11MB18865CD0C3B7A9CFD73D8E4C8C699@MWHPR11MB1886.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: b997bce8-70e8-4a5a-94f3-08d8e9e9e5c1
x-ms-traffictypediagnostic: MWHPR1101MB2222:
x-microsoft-antispam-prvs: <MWHPR1101MB2222CC4A72187221FDB0A7938C699@MWHPR1101MB2222.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NUtqEfsOiEl4Fv12gw4uvQhYfHqDKEfmwh6nruser41VhHmpWci0309vpwEpT3x0z7QB5ag1kp46p06YNEJypcZFkha8pPO6YyfoT4i0VKnMMTXrqHMtBYcmN4f2QptC5du2CQSm/8lfKTqFr1l4BNJeWxCTov6MSiYMSmREJhixgTMJmiRf0HvpNin5u7538tijoDkxkshyoXW58tEJvaOUmviZuzq0BG9MRbq6GsgUrzYB3ZqVm2nNeUyobcN+ZSylG7t8hA9B6sQoC4dFT5qq1kwvLJVTNn+Cxhby0G44fXBws3Lq+a+EwvfJdnCsNlhP8XdLa1zrWMsBJqFr21MCQIIwUSc6GmBLITfJGJscS5/5bqj6X8KXiJ0WzD54FKUMQ2JgOPzcpMabFg3CLwJUUgDIFz/hWpf/AWI9uKzw+dmL9j98c8+0bIdKL6U5ZVY6Efk2OicXoQxSURPkUiCrj3buCW0mHQc3jdRLNNbzmNlYQflr/v0phuwubXeCo6myWb6fHTDg4yNJgC9oObfHrKyRUkGInis0ZxbaVn8wXzGPRcQ0ZNjqccUhr9KpaYxvwUH+REBxQYMDOxh8hIX5eBCumJst6vNLsGUH4YQzLaqMeGPAgKTqJvNOMlZm
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1886.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(39860400002)(346002)(366004)(376002)(396003)(54906003)(2906002)(316002)(33656002)(76116006)(478600001)(66446008)(6506007)(66556008)(55016002)(86362001)(66476007)(110136005)(8936002)(9686003)(83380400001)(71200400001)(64756008)(4326008)(7696005)(26005)(53546011)(38100700001)(52536014)(66946007)(186003)(5660300002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?VGhVZ1duSkhjUU5SRGhPd0xJZWtyS3RNVlVoVGp6TTc3Z2xJN1dqWU9GWFdn?=
 =?utf-8?B?R21vZGtySGhPTVdpNlpUNFNTeTI4WkxJUno3ZVlZWkNKMysxbFRnaFBHWmc1?=
 =?utf-8?B?UzA0V1lXSTd0b3diUmIxTWJjNThjdUpEWHlHK0JIQUJHWTBmb1lZTTBaa2oz?=
 =?utf-8?B?NDVGS0wyL1EwVlMzbWVSMVhqbTQzZXNnNUoyRVQ5VFQ1a2RjZEdmaUtNb1VM?=
 =?utf-8?B?dUxpbUV2VkNRL085N05sR2lyMWdIZHJqZzc0VUlXT01nMFVjTW92UngyaDZS?=
 =?utf-8?B?U0hXZWgyMFJGeEs1eFhQeUVQRkNtaWxwaEFpcVB4RUYwR1UrN1NwS1pyRm5t?=
 =?utf-8?B?L0UranIwZGRYY2o3RkluL0tDWU1rekVOcWhoNlJFcXd1L0tVQkQ5Q3RYWjl3?=
 =?utf-8?B?U04vUkM1bUFmY201elQwQnpULzhJbVBZclZ6bE1Zd2VSWlpnaS8yMk1TVmR1?=
 =?utf-8?B?SnZBWVFOdkFuQmNyaU93VUpaaGtvZWlZaDhIeXJjaTJiNGZRYVFsR2ZPYlo0?=
 =?utf-8?B?RnZ0Q0dUZy9JUmN1Zmd6L1MxdWEraXZXYytBWnpqa2RxRTl4NnR4YVdENHRp?=
 =?utf-8?B?OUhaREVrTENGbitjZHY1VHFRZWtEV0FneHd6S01yTnVvQWRIa1F1NFdJYVRq?=
 =?utf-8?B?TEVTeUtaU0RMaE1mMXRmRzVGeDlKREh3WkJ6Ly9YRlJ4blVOdVpFYk9aZlJG?=
 =?utf-8?B?ZitieDM1eDd6cld5NzNxYzRmWEo0N2RXNWVzNnFsRGRDN3pHelBiV1ZyT296?=
 =?utf-8?B?WDBWRnMvNnN5UG5TYktObW1ONXpSNTk4U2c5Vm82OHExWVpFcWw4MTVpdWsz?=
 =?utf-8?B?clZSdit6NHBRamphajRCdFZaWU95bGdPOHBpci9OUzNSclFlY3ZSVE5iMmZh?=
 =?utf-8?B?dS9hZEh4cTRRRm9MK2lVWm4yeTlJU3J3UVZibGtvUGdFL3czaXZYWWNQaG9D?=
 =?utf-8?B?ZGZCbmtSOFE5NmMyWi9PQlhKdVc0K2wrQnB6WGVxWm5GSWpZYUdCdDFvZHVL?=
 =?utf-8?B?N2ZZZ0d2U3FnMnM4MnhwVlQzN3lOMlpHNHNBVVVQaHM4YzJtcEU5cnhzV3J2?=
 =?utf-8?B?STFkS3BMMmFkUVM1QnpUQVMwUG50aEEyUlNkakU3UTlqSWhCMnE1VW9kbjVp?=
 =?utf-8?B?YXlTY01LL1J6cHBWazZBdWJPSDN6bFQ2ZENpY0h1U1BtaDhxeUp2SzZzOEJL?=
 =?utf-8?B?UDJoNHdWQUYrV2FDb3ZVRGZkdlM1d0ZWTzR5eG0yUC90VGg5SDdKY2NlS3hj?=
 =?utf-8?B?eXNBZHIwQkxUbVA2K1NYWkh4cXZ1bVdteFlRVks4Y0Z2ZG5EdU0vcjJHZCtP?=
 =?utf-8?B?MENkZG9HNUVGNCtUR0M4bU8walNvWHVKS0VCVHZ3RUFGei9rYXp4SEVjQUk0?=
 =?utf-8?B?STdacmFFcU5EMFM1bW1JWDFjaXIweHR4QnJRVGhoMjUveGN6SE9IR1NFcEo2?=
 =?utf-8?B?bUtCd2Z0bDhGdVRBdzBPbnBLSzRDQ01HQmE0THd1TXVTaktsejEyREo3em9r?=
 =?utf-8?B?T1RmcHRGZ2UxT0pwQis3UGJHbWN1UXM4cmk1MXV1RkxRTUdNWDZRZ1gxWmNv?=
 =?utf-8?B?aWJrZzhJazNHNjdxSkl5Rk12ZDhXcyt0dVhxM0ZWM3NUTEhOZ1QveDZIczAw?=
 =?utf-8?B?RGN1RjhuUklHdzZ4V0FBMlo5WDFBa1E0bnVCS1ZLLzE1RWd3YURjRHIwZFoy?=
 =?utf-8?B?ZGg4OVQ0NXhyYVMvcitYYndXRDhXWGNaMVBJc1p3TVZmRGVVMkJ1NFNMVmZQ?=
 =?utf-8?Q?oGUmyj3Y54le57JWSiVy6HN2VqGHo0M7e19LZwW?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b997bce8-70e8-4a5a-94f3-08d8e9e9e5c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2021 08:43:26.3016 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: izWSRGXvb+VflAL7wNB+hS51oajUQTvFLrDneclrf65/eAUg3gMqRX85nrUUUZIkwz4M+LLY0xoznLlYpfrqBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2222
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
dWN0IERlcHQuKQ0KPiA8bG9uZ3BlbmcyQGh1YXdlaS5jb20+DQo+IA0KPiANCj4gPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IFRpYW4sIEtldmluIFttYWlsdG86a2V2aW4u
dGlhbkBpbnRlbC5jb21dDQo+ID4gU2VudDogVGh1cnNkYXksIE1hcmNoIDE4LCAyMDIxIDQ6Mjcg
UE0NCj4gPiBUbzogTG9uZ3BlbmcgKE1pa2UsIENsb3VkIEluZnJhc3RydWN0dXJlIFNlcnZpY2Ug
UHJvZHVjdCBEZXB0LikNCj4gPiA8bG9uZ3BlbmcyQGh1YXdlaS5jb20+OyBOYWRhdiBBbWl0IDxu
YWRhdi5hbWl0QGdtYWlsLmNvbT4NCj4gPiBDYzogY2hlbmppYXNoYW5nIDxjaGVuamlhc2hhbmdA
aHVhd2VpLmNvbT47IERhdmlkIFdvb2Rob3VzZQ0KPiA+IDxkd213MkBpbmZyYWRlYWQub3JnPjsg
aW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7IExLTUwNCj4gPiA8bGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZz47IGFsZXgud2lsbGlhbXNvbkByZWRoYXQuY29tOyBHb25nbGVpDQo+
IChBcmVpKQ0KPiA+IDxhcmVpLmdvbmdsZWlAaHVhd2VpLmNvbT47IHdpbGxAa2VybmVsLm9yZw0K
PiA+IFN1YmplY3Q6IFJFOiBBIHByb2JsZW0gb2YgSW50ZWwgSU9NTVUgaGFyZHdhcmUg77yfDQo+
ID4NCj4gPiA+IEZyb206IGlvbW11IDxpb21tdS1ib3VuY2VzQGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnPiBPbiBCZWhhbGYgT2YNCj4gPiA+IExvbmdwZW5nIChNaWtlLCBDbG91ZCBJbmZyYXN0
cnVjdHVyZSBTZXJ2aWNlIFByb2R1Y3QgRGVwdC4pDQo+ID4gPg0KPiA+ID4gPiAyLiBDb25zaWRl
ciBlbnN1cmluZyB0aGF0IHRoZSBwcm9ibGVtIGlzIG5vdCBzb21laG93IHJlbGF0ZWQgdG8NCj4g
PiA+ID4gcXVldWVkIGludmFsaWRhdGlvbnMuIFRyeSB0byB1c2UgX19pb21tdV9mbHVzaF9pb3Rs
YigpIGluc3RlYWQgb2YNCj4gPiBxaV9mbHVzaF9pb3RsYigpLg0KPiA+ID4gPg0KPiA+ID4NCj4g
PiA+IEkgdHJpZWQgdG8gZm9yY2UgdG8gdXNlIF9faW9tbXVfZmx1c2hfaW90bGIoKSwgYnV0IG1h
eWJlIHNvbWV0aGluZw0KPiA+ID4gd3JvbmcsIHRoZSBzeXN0ZW0gY3Jhc2hlZCwgc28gSSBwcmVm
ZXIgdG8gbG93ZXIgdGhlIHByaW9yaXR5IG9mIHRoaXMNCj4gb3BlcmF0aW9uLg0KPiA+ID4NCj4g
Pg0KPiA+IFRoZSBWVC1kIHNwZWMgY2xlYXJseSBzYXlzIHRoYXQgcmVnaXN0ZXItYmFzZWQgaW52
YWxpZGF0aW9uIGNhbiBiZSB1c2VkIG9ubHkNCj4gd2hlbg0KPiA+IHF1ZXVlZC1pbnZhbGlkYXRp
b25zIGFyZSBub3QgZW5hYmxlZC4gSW50ZWwtSU9NTVUgZHJpdmVyIGRvZXNuJ3QgcHJvdmlkZQ0K
PiBhbg0KPiA+IG9wdGlvbiB0byBkaXNhYmxlIHF1ZXVlZC1pbnZhbGlkYXRpb24gdGhvdWdoLCB3
aGVuIHRoZSBoYXJkd2FyZSBpcw0KPiBjYXBhYmxlLiBJZiB5b3UNCj4gPiByZWFsbHkgd2FudCB0
byB0cnksIHR3ZWFrIHRoZSBjb2RlIGluIGludGVsX2lvbW11X2luaXRfcWkuDQo+ID4NCj4gDQo+
IEhpIEtldmluLA0KPiANCj4gVGhhbmtzIHRvIHBvaW50IG91dCB0aGlzLiBEbyB5b3UgaGF2ZSBh
bnkgaWRlYXMgYWJvdXQgdGhpcyBwcm9ibGVtID8gSSB0cmllZA0KPiB0byBkZXNjcmlwdCB0aGUg
cHJvYmxlbSBtdWNoIGNsZWFyIGluIG15IHJlcGx5IHRvIEFsZXgsIGhvcGUgeW91IGNvdWxkIGhh
dmUNCj4gYSBsb29rIGlmIHlvdSdyZSBpbnRlcmVzdGVkLg0KPiANCg0KSSBhZ3JlZSB3aXRoIE5h
ZGF2LiBMb29rcyB0aGlzIGltcGxpZXMgc29tZSBzdGFsZSBwYWdpbmcgc3RydWN0dXJlIGNhY2hl
IGVudHJ5DQooZS5nLiBQTUQpIGlzIG5vdCBpbnZhbGlkYXRlZCBwcm9wZXJseS4gSXQncyBiZXR0
ZXIgaWYgQmFvbHUgY2FuIHJlcHJvZHVjZSB0aGlzDQpwcm9ibGVtIGluIGhpcyBsb2NhbCBlbnZp
cm9ubWVudCBhbmQgdGhlbiBkbyBtb3JlIGRlYnVnIHRvIGlkZW50aWZ5IHdoZXRoZXINCml0J3Mg
YSBzb2Z0d2FyZSBvciBoYXJkd2FyZSBkZWZlY3QuDQoNCmJ0dyB3aGF0IGlzIHRoZSBkZXZpY2Ug
dW5kZXIgdGVzdD8gRG9lcyBpdCBzdXBwb3J0IEFUUz8NCg0KVGhhbmtzDQpLZXZpbg0KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBs
aXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
