Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA8BCC433EF
	for <iommu@archiver.kernel.org>; Tue, 28 Jun 2022 08:53:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7D8C7402A6;
	Tue, 28 Jun 2022 08:53:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7D8C7402A6
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=X3h3YI0i
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V4OAWZHL-Neh; Tue, 28 Jun 2022 08:53:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0687840292;
	Tue, 28 Jun 2022 08:53:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0687840292
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA0D4C002D;
	Tue, 28 Jun 2022 08:53:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 41C72C002D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 08:53:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0639F40541
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 08:53:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0639F40541
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=X3h3YI0i
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ossKizo1qgTK for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 08:53:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BA088404A8
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BA088404A8
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 08:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656406403; x=1687942403;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=j7RBLyOlka1iLMiwFTIdTRDvqa2H8mNDaHkfg+UpypI=;
 b=X3h3YI0ieLr6NySLESocGp74yvfewjm+gkXqXL/rLsmab1NB9LEbS60G
 sJCrghDRD6rrVfnMfzGZu3UN2Wrzg3HGdIrHok1gkd8+4ih1y/KocBGCP
 DB5WqnT9Lz6a5QIA5XrSrAxZU+M70u1xGK/3iJ1hpm243qo2T3AoU5wZ9
 B7g3MGxrK+t6Q5Zuw46M9hObDvnzy9NoPFPPESc4dLyRd8Dr6DAuabSEf
 s+av8LmZQGA9z9896H2cDjlIDfOVTmjbkBJDFbX9PPDI54uUOdvnXlN6K
 ZQZgATAaqbnjesxu6eO0UiE51nrBMd6Eqi4M3lebtIaKGZpQwWX3L1+RY Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="367992514"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; d="scan'208";a="367992514"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2022 01:53:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; d="scan'208";a="717371502"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
 by orsmga004.jf.intel.com with ESMTP; 28 Jun 2022 01:53:22 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 28 Jun 2022 01:53:22 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 28 Jun 2022 01:53:22 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 28 Jun 2022 01:53:22 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 28 Jun 2022 01:52:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hfp+fKAgPinUTc+EboRcvyGeAuUQa6Zub2kaW1qnLgga5r65ZF2ong94C+bw4ywqIgTeFoYKhN06cUTDxKBHosb6KGGObmrGecBw5qSs+mG44eBNG2dJa2E5BEL78T0iN9P5xK/W3dvsym+aqaBb4LrLx7XzW4rRQkAhgs1Hw7Ei13mPF22HisCkV/I44wjVkBwUuyJqD0Ps8/nTf17D4ZbtDK9hVufOfHiMVC0wHRa1mP9L/LYp02jvEYQiNmSj6H5sMjHm2Bk73c8ugJF2fzpYJy/5bkD0PJPoEw5J1KynDA6h2SbhnE8W/AngUZ8QLirbUKDxvSRGQvNi8rt5SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7RBLyOlka1iLMiwFTIdTRDvqa2H8mNDaHkfg+UpypI=;
 b=d5OsYU8qzDVY2NmBSlrWwP0xQV8TsCB2wVrdcGtnvd0E3nrYM4cG+ciMewZk+HfwhXwvMasxiqFQIRN52qZHWt8DrKnBZ4szy7brLMYkk/f63eqdQtB15jSKTJNS0IHdDesmkJZVmrLPpimpSFHyOyFgHDEQ5DOnY6CTgpzLu2SqSYkOel/PQ2UwahQl5QFDHsTYZbGCeFFwgSIrQb5LnXzQGPPwxLFXWES2I8bZ+cbDwdXuxTcpajRWiafRXfBSUbZn8O6DKzYO5aNqEsFa/pdoIAtNr2IkfQ8rg0ZILzbkBvsj0zN2uvggDetbiqPyWgPryabbvprOXRzDGDGH8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH0PR11MB5377.namprd11.prod.outlook.com (2603:10b6:610:b8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Tue, 28 Jun
 2022 08:52:37 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c%2]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 08:52:37 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 "Jason Gunthorpe" <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>, Robin
 Murphy <robin.murphy@arm.com>, Jean-Philippe Brucker
 <jean-philippe@linaro.com>, "Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul
 <vkoul@kernel.org>
Subject: RE: [PATCH v9 07/11] iommu/sva: Refactoring
 iommu_sva_bind/unbind_device()
Thread-Topic: [PATCH v9 07/11] iommu/sva: Refactoring
 iommu_sva_bind/unbind_device()
Thread-Index: AQHYhX4BFOtH7b1yFE6Yv4ZQbmv7RK1jDeuggAFN6ICAADFm8A==
Date: Tue, 28 Jun 2022 08:52:37 +0000
Message-ID: <BN9PR11MB5276EBFC3D990EA8EDEDF8C38CB89@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220621144353.17547-1-baolu.lu@linux.intel.com>
 <20220621144353.17547-8-baolu.lu@linux.intel.com>
 <BN9PR11MB5276297FAEB8C9774AABAD208CB99@BN9PR11MB5276.namprd11.prod.outlook.com>
 <543603e3-9d08-59ee-01f2-8dd6e7c73a15@linux.intel.com>
In-Reply-To: <543603e3-9d08-59ee-01f2-8dd6e7c73a15@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 996dc67b-4a5a-4487-2838-08da58e38d1e
x-ms-traffictypediagnostic: CH0PR11MB5377:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zrzVwjXleT65KtdmSwcvRZLgEYaZKv4nLae10E8y5pU1NqWFUBiQjavLEcrm5pQ/Wt5BLANEq5qMutd+arvchWD+roF0WXThFK9JhmI1hlQ5FSlWTrgA7Jwzwdy4VqShc4FBuhQB6TC4xUDEh3866EPfCd7qSE4OQ5zSZ6ruI0ObPbZHbnD58AeGLOw5Iv/DLYiirBUpd/OI2VgjZsYzcUSL1f2QttTkauGFIxQhJJ2QCNHVbrn0JwaaMGoSebRrJUzmbQaWVe/GX4F5QE3MJY8VBUfceghXr1xSdpgobj/+z68RqB8zngoCyI7n5dZpy1IAYKu5Mmdz0pRLSu+vcI19QQqrSYSgnaaoXfH9XlFO19jOiD66g88ZZYe5pmbfRSg0l+R4Qp2nzTi4huUQeSxL5wbgbdQ6mO4i2vpwz5B6oDt0uf+xdJLC0x8u7mqGPtGI/5jRCuQCBAlSB0Eq1npCtt+8imxnOArRpBz9IN8QBMYnTDlHrVJtBgIaeg+XiyyByjsztzRVCG5hhcUoWBD608eRanElphvSuFPgpREBZ6INa8qeN2StUfk9pVaRDflHM00MwvRZhglOlMA0nVsTYJiReQ1zf8yw1UjTzsnUU6hDP16F/Kh98Hv2+DWa8AFuEj44vBxAN6iNGokDSKSCAelO3BJXb7so1ibN8V5eV+fsWHb4jnj8di79qttwBYLrwQ/r/lZmMXQSGkzrUI7EGXSvwoBvqif/uAlj9xMPpK3nErLKucySNFKdcbO034te0POL+2YczxlMpOA6qk4QGgpR8fLuLlY/QVG3gDOrBiqyo/yxjM8MB3/n/kul
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(39860400002)(346002)(396003)(136003)(366004)(376002)(8936002)(7696005)(2906002)(6506007)(86362001)(26005)(38070700005)(9686003)(5660300002)(38100700002)(66476007)(478600001)(7416002)(41300700001)(122000001)(33656002)(52536014)(921005)(82960400001)(110136005)(76116006)(66556008)(66446008)(64756008)(55016003)(8676002)(66946007)(316002)(71200400001)(54906003)(4326008)(186003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bnhyZk9naDcvZFJMRVZxOFEwU0wrV3pGYUs4K2ZpZWU5U3hWbEE1VUJLZ2Ni?=
 =?utf-8?B?MHJsMnF4WVN3bzV4US9MNGlTV0I1NTBzSC96alhCT0ZnbEpRbkl6Z3Y4QkxE?=
 =?utf-8?B?S2VZeWtsc3NVZ0RJRG9JN0c4MGhGb1lUcS9TWk9tSnRTZ2pnaWFlcG1YU0Jn?=
 =?utf-8?B?Qk85TzRRNmhmdkY3bUpYZ0xZVDh1MENncW5sTGVIQjkxbXFjOC9oZkhLdXQ0?=
 =?utf-8?B?a3VoQ2t1aE00K1EvbHJWajY0ZXhIaDZaMTdxV2l6ZkMxRDJBb2pUdkxZQ3Bh?=
 =?utf-8?B?OFl3YlFFS1FvdmtpUlc4Yk1aOURhMG1YaXA0blpTdndrODdabERVN1lLWkhR?=
 =?utf-8?B?bU1JTFRIcytyWXpGenFURUtqdmM4K2NkS0JQd0dhUWtoTU1HY2lvZEV2OU1S?=
 =?utf-8?B?T3E4NTBtTlBYZzhPWGwzaFRKR09zL3JMY0JPRzVaTXZVQ1lpeGhyOHQrVXMw?=
 =?utf-8?B?eXVHQWlmV3MvZTVpbERFOGt6YWZ4NEVxcUd0MWVpSVpnUUJWcjZybm1iSk1o?=
 =?utf-8?B?OEpmSTVCSnBsZWxvMkwyV2FuVkQ0TFVBcTNDNU5EUm0rQjFDWmJHVENPQkhl?=
 =?utf-8?B?a1hZMFFWZzVPRTNteVZxOGxiTm1FQjRIbVNSR0RnZ21KaXhLRUpFSldsSlEr?=
 =?utf-8?B?Y2YvTkJ5eGwzOEhEeXZxTytLY1FiNENPaFh3dFBQZm1mQklERzdJMHZyZG95?=
 =?utf-8?B?T21DWCtBaHV5b0F5RmRYRld3TUVLRXpHRjVlY2RHbWFCNGluNlBnS25WUnAv?=
 =?utf-8?B?YUlEeVdYRFVsL3VhNklUZnJsU3FuMFBJU1A4cFBmMmZ6bWJTY1BLMzAvOTBm?=
 =?utf-8?B?Z1ppcXFLL3huS1ZmZTF5WStTVktScVE0QXJLRk1JTDZ0SUFpdmQ0ZkJLYnhS?=
 =?utf-8?B?MzMydmlCdEJoNHhjN05FUTAyUzFwRXpJMGlIdmhwU3VWM2JlckZ1a2dab3lw?=
 =?utf-8?B?SXdyUnhYUGsxRnkzR0FudU8vS0ZtVDUxdHV1SmVpdzJ2V01yeExJZmgvV1BY?=
 =?utf-8?B?VkVTN2hoaVdRMDRYZDYyRUc1V0ZvdSs3R1pvRS9lbmhySG95a1hLYnZKUzNR?=
 =?utf-8?B?dHVSajg2bW83MUQ0QUFjNHZCWGFlbHRhT1dIeGlYcHB5OTdNU0hLQ1Y3RmE5?=
 =?utf-8?B?RVMydGN3U1IvZkdzalpFNzllY3JIeXY3cTB0RkZaNEFOeVdsTkxrcnFlRUZT?=
 =?utf-8?B?dUtkYXdKd0R1MFdZbmRBeUJMZjU3OHZ4cXNCdHFsZkdYM081ZmMzUHluREsv?=
 =?utf-8?B?OVlIdnIvRDhBckdzNWVNS1k5cXRnSU9PVjBlbitzQ3FGeUUrMWp1UFN3L0o0?=
 =?utf-8?B?aUFxZWtYOFZiZ3pXcGVzeitSc080bGtLWHlscTZCei9WVzM5U2RuQXhhVFMz?=
 =?utf-8?B?RzZDa1hEVUxIU0NBOXUyUEh2YkRWVG5iTU9CZGQxYVp5Vm16b2xrcVFzdWpZ?=
 =?utf-8?B?WitGVS9EODYrUElhM1pHYzc1dEh3VHJheXViVEhlN0FyMDVueEtWMk9mcFhJ?=
 =?utf-8?B?dEVtR2VCUkZ3eXJNRmE3YThmdnZpSDdqZWFIaFVVL1NFejIxM1VBbWVERWZF?=
 =?utf-8?B?T1h2bEw2Wks1amhydnpveHJHVWtlRGZRckNWSEVMNGpwUHVLQlhBL3dkcExT?=
 =?utf-8?B?WGo5elQxbkx6MGxaK3plVGxORHFLV2daRFd3N3lpdTRZR2hUcGw2R2lMMEE4?=
 =?utf-8?B?WlVIQnR2bEpuSm9OMUx2RjB1STd6L2lSKzkrMzhYU0xmZXFocVlwZmxYMWE1?=
 =?utf-8?B?VUFXS2k0T2szVklGamNtOWtWTi9RZnpIQUtYaVlFbTEyTHJsMEJOejNHeUVF?=
 =?utf-8?B?ZDhwODV2OEZibWJPQU9wRU02ckhpTDVjbUIzWk9UNnV3Z1BRam9TdTk0SHZN?=
 =?utf-8?B?M1hVbTBuRG1VRXVJT1Z3bUgrL2NKSWhMZkFvQmg3N3R3UHR4Z3VFaC9mNXJS?=
 =?utf-8?B?TVNlZngyOHZYVlJsb2RBNSs4UldyZ1RLZnlzTW8wWUhjRzViWUE0b3ppNEFv?=
 =?utf-8?B?aXFENlZkbWtPRkpIOWRUWWgzcUFyNzlPRE5uR0hLazd6WjMvWFZzdmhqbjIx?=
 =?utf-8?B?dHlQU2xMengzRVpzUmd2RDRWMzV6NllJS3FQSVNhdk01SWllVTBrVmhLdTVL?=
 =?utf-8?Q?vwFPra5jHVvnNeb6gqsYbLQJN?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 996dc67b-4a5a-4487-2838-08da58e38d1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2022 08:52:37.4105 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eSUZoy6kycn6yvImfrhoQLLNEfUaTGwWN2QLlddxfv7nhgtI8PAnGUJivswM8n02WxlNJVF3o31M5W1m9Ow0cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5377
X-OriginatorOrg: intel.com
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>
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

> From: Baolu Lu <baolu.lu@linux.intel.com>
> Sent: Tuesday, June 28, 2022 1:54 PM
> >> +u32 iommu_sva_get_pasid(struct iommu_sva *handle)
> >> +{
> >> +	struct iommu_domain *domain =
> >> +			container_of(handle, struct iommu_domain, bond);
> >> +
> >> +	return domain->mm->pasid;
> >> +}
> >> +EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
> >
> > Looks this is only used by unbind_device. Just open code it.
> 
> It's part of current IOMMU/SVA interfaces for the device drivers, and
> has been used in various drivers.
> 
> $ git grep iommu_sva_get_pasid
> drivers/dma/idxd/cdev.c:                pasid = iommu_sva_get_pasid(sva);
> drivers/iommu/iommu-sva-lib.c:  ioasid_t pasid =
> iommu_sva_get_pasid(handle);
> drivers/iommu/iommu-sva-lib.c:u32 iommu_sva_get_pasid(struct
> iommu_sva
> *handle)
> drivers/iommu/iommu-sva-
> lib.c:EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
> drivers/misc/uacce/uacce.c:     pasid = iommu_sva_get_pasid(handle);
> include/linux/iommu.h:u32 iommu_sva_get_pasid(struct iommu_sva
> *handle);
> include/linux/iommu.h:static inline u32 iommu_sva_get_pasid(struct
> iommu_sva *handle)
> 
> Or, I missed anything?
> 

Forget it. I thought it's a new function introduced in this series. :/
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
