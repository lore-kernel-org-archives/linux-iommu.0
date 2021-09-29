Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1301DC433F5
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 06:41:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2AAF613CE
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 06:41:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A2AAF613CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6C9C4415F0;
	Wed, 29 Sep 2021 06:41:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j7HrPmhODKpr; Wed, 29 Sep 2021 06:41:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3F968415E4;
	Wed, 29 Sep 2021 06:41:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EB99AC000F;
	Wed, 29 Sep 2021 06:41:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D944C000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 06:41:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E2D84415E5
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 06:41:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M-SPwpTGnvK0 for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 06:41:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7888D415E4
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 06:41:17 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="285887733"
X-IronPort-AV: E=Sophos;i="5.85,331,1624345200"; d="scan'208";a="285887733"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2021 23:41:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,331,1624345200"; d="scan'208";a="456912625"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
 by orsmga002.jf.intel.com with ESMTP; 28 Sep 2021 23:41:16 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 28 Sep 2021 23:41:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Tue, 28 Sep 2021 23:41:16 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Tue, 28 Sep 2021 23:41:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OL5CMsZeCJooeB5E3tTG/0FmAKuBXSUipNvpB0H+lOVZ6BQ5S6be28M4+f6iBF4rQP0LeZZbbdwq/yp2hQpJYtnnB6JFQpyW0uwFQTJqt9yMey3OXXQI68FWdnoB31I+H0gAWS16tnUC4u8fAFrcgyahkH5rxrFATzpTxZeBFUF4jx5jO1Yb2GVPVgbvU7gr3tVA0bzOLR3v7ErzHc0FS1T5oNMmXGWzORJaFs4PulyyYGer90mMSna4np75KGORhO0epi9AWsUJ03gMNUanaVj+xXH1qt+Mf18rWe6/6rxc9SqPyHoKdHob9Pr8cf0VsVIwIUJuzSDIprI6B/k1jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=eaYoZjMBXpPeg1yf/IiaxSIjlhRUwS0aFTel8ODGxN8=;
 b=KuTV3/XxCSjfSMULktWUgzqvl2HJYCE474XMxGp79lKRuIZH47XSdFW8sPP0zLBsirqPPMa8TU6jXfr5W3x8nWdXxaGgxWw3Z8EpIhR/PcbfY72qyf7ecmImKH8uS8ngvCfF1mRCeVJJqMAoQ2IMbzs+ohjeqTSmO4Zwi+HZmptkzRYpFmFLNMSAQfWb8IJoV+hkvQ4EHKySuH+HOnqvzee+XjjLp9U2GJxlOUpq/3oL5BBhig4zo9aZHa7E2zHHrA5D0kPM8lInv46hyW0o9inUB/GBnpx4q7+Gq21yHja5K3UyxUP/Zh/nJeOPGexLrplDViwyU9OsjRbu+8p9rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eaYoZjMBXpPeg1yf/IiaxSIjlhRUwS0aFTel8ODGxN8=;
 b=uWlhsnHgeI1P5xPdE0SglTmw4/yIAN9XAXaZ9MXW287Qo4J1T5HdvLvhFJvT1kdn4PQGJSkw0k5YdD69vYjoArQPTwwLRAzwTtxd0djskc6BYS14Su4HdwNoekuHS15dW2VdUyec/nuQdyboBeZD8eTsx/EuMVfNsmPtu+sWhEM=
Received: from BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13)
 by BN6PR11MB4066.namprd11.prod.outlook.com (2603:10b6:405:82::34)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13; Wed, 29 Sep
 2021 06:41:00 +0000
Received: from BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df]) by BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df%8]) with mapi id 15.20.4544.021; Wed, 29 Sep 2021
 06:41:00 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: David Gibson <david@gibson.dropbear.id.au>, "Liu, Yi L"
 <yi.l.liu@intel.com>
Subject: RE: [RFC 08/20] vfio/pci: Add VFIO_DEVICE_BIND_IOMMUFD
Thread-Topic: [RFC 08/20] vfio/pci: Add VFIO_DEVICE_BIND_IOMMUFD
Thread-Index: AQHXrSGD1s8CLHCzb02iYFtNvU/Mhqu6lHYAgAAIGmA=
Date: Wed, 29 Sep 2021 06:41:00 +0000
Message-ID: <BN9PR11MB54331D06D97B4FC975D8D23B8CA99@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-9-yi.l.liu@intel.com> <YVQBFgOa4fQRpwqN@yekko>
In-Reply-To: <YVQBFgOa4fQRpwqN@yekko>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gibson.dropbear.id.au; dkim=none (message not signed)
 header.d=none; gibson.dropbear.id.au;
 dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a84c61f5-6bf3-4299-e227-08d983141a0a
x-ms-traffictypediagnostic: BN6PR11MB4066:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB4066420FF6C121F635EEDF338CA99@BN6PR11MB4066.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fhrWEw7TDMXL0aM5pUJLdIkT3w5HMcE3CkhOIa39A0QhGF54Jd4sIPYburJ8TdS65tMovplGkqS2KesliaH3jJ6GB/YjcjQ3Vel0ANoQTgipgTxCT+Rnx2xIWfXRntmng1ndJlwpRi0dABrpj5Ujrnuk7LFPMewYGcLKeRJpJD8KwX3gyafbsvuGrYYHFj7eXat5TAQpk5z7LUFUTegjqQmQNzgMlWqwJ2/vW/YzIq8vYqrrbxTC0CZEE3Dhy4rtXquXlEV340IZ7yszux9OCdnwlHVtHamgaEs/Uk9H3j4GBbhzC+iVUy0lGJxkJR9NRM65lNpVTJ1mav7OBiG4lPSnd4VDJyONCKzP43FHgauVGgJRE30zeBbT8jdVTT3UT0tyD+nJkislzvhaTfYUmfJUfbUewpT5RCJuuUIJ4wzdGnDvjamidbumBxZ2/AlwH06JSdWBWSBFnpAYbHE7jFDnU/BdjJh8haSnMPjz/tinAoBrHfD2ml0GyGUeRHz8eWCVYx0Nbrs6KfECrirkeGsbdcC9c718t8J9ZhP7QrTXPC1y+JCV6ObQh591PCNvScihCxDwKDaPyhapwQkxWQW80QKz6KMkmXRPNQcNiQqMn9889Ct8/a2i9BqcBgFsY5TJSEFSk79GUcNyb0bEOeZC8tDmyaL+W35UTCn5veKVmg1wpcUf+u2sxRxLKl64Oi6ofTPGrSZ5bOoebPnaZQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5433.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(508600001)(52536014)(26005)(110136005)(7416002)(8936002)(38070700005)(71200400001)(6506007)(122000001)(38100700002)(54906003)(6636002)(7696005)(316002)(5660300002)(2906002)(86362001)(66476007)(76116006)(33656002)(66946007)(66556008)(83380400001)(4326008)(9686003)(8676002)(55016002)(64756008)(66446008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0lXSzltcGpOUTd1Zlhod3ZOL0VEYzRSaGJsRTBROXZhdC9Pd3I2MWFpV0lK?=
 =?utf-8?B?eFhCSUdKeTg0S3VPWWFzYnJkcWt5SHF4THlTVlRpSE1pbUNjNjI5aDZ4em1i?=
 =?utf-8?B?d1NLRjh5L3BmM2JRRmJWcWVJb3BNT0trSXJ3dzJqekJaR1VjU3FSdUJxZ3lT?=
 =?utf-8?B?T0xxMzV4SjlBcDZqbkpwSUNHQWV4UWNzcURGSUZRVGdGRUo5VFBYTW1acFpY?=
 =?utf-8?B?SnRTMVk0dDJMOHdZMkVidld4dWVjNElDRFBta3ViellETk1zQzdQNm5jTmI0?=
 =?utf-8?B?MXFoY3d3NFRvZ2NRQWJnL0h0eGhISjdENllhNnZST1BWVmtrZHhXMTV5UDl0?=
 =?utf-8?B?ZkJyOERuV0c1K1J4WDF6LzNweUJ3dklXUThNZ0pEZlNwdW9TNkM3bFdYdTI0?=
 =?utf-8?B?alZUanJCdithWHhuUEh4ZEc1dVVIcXE2R2ZTVlJ5dHQ4UGE2TUhXZlRoOFFo?=
 =?utf-8?B?eUFoRHFNMklSY2VpSGUzc25qQVZabmhDRXpMVHZOTkxEYk9uZFdlVk1kdTFo?=
 =?utf-8?B?OFBvUGxlRTBzUEpWbXNtUVlDMFh6UFNzZVN2emZrMTZFbDd2MmQzWUliVzMw?=
 =?utf-8?B?R3BjQUZtOGpzWit4NmorazFZTVNUY1VtYW84bEFsc1BOaFJOYThLbnNKUmxD?=
 =?utf-8?B?b3hCRGNhalFTM0d5bm5NTlBjVk4vaGZpdHd1bVBQdnlyaGs4WjVEUDFOMllG?=
 =?utf-8?B?bUY5RVdXUXV2SW8wUDBQUzhlTnNMNUZnSGZlVnRLRlgrT2lrY0NLL1JZekZI?=
 =?utf-8?B?cUp1ZVFyWGFUeWFIcmNjQmE3aU13WkU4ZVNTNm42RUlZeDNOKzNRbGdyL0sv?=
 =?utf-8?B?SlEwc0NQekxzUUpHUDVXazdMRTkrSG5SR3A5UlJza2hZTENiSkFyZGNEbVho?=
 =?utf-8?B?VGNpeDR5ZzRxc2R2M08rK0hVYkdQdlRpWksvNS9XS0lFNDR0WHg0ZS9jNElj?=
 =?utf-8?B?U2dXQjBPb0FKZklNamFLRUpQUWhQU1lmNElPV0RSNkVnUWdodHdFNUNIYmtS?=
 =?utf-8?B?VncrclNVMndBSk5haDlJR1FFZVl4THRPUU1KTGJHM28veU14NGM4VzZIOWI4?=
 =?utf-8?B?VUZTT2VKQ0hKZ0dPRlJURUxWUk1LY1FhM3FUaDRhS0NRVmdweFJMOGVoWi9w?=
 =?utf-8?B?U2g4Zzk3YzN0MVMxTWxhenZIWVp0Yk1EaWY2dm9Ld1MxdVNSZmFTUHdZRjJp?=
 =?utf-8?B?eXBJZzE5VmxwWEtZQ2E1MnE3YldLNGJ3M3pwODVZbmtxcDV4RStPeXdUbGgy?=
 =?utf-8?B?cG5WbTY5U2xFcHBLMDJ3b3FIU0JlQ3JVelZMbWpsYUI1bSsrMnEyZjZxZUd5?=
 =?utf-8?B?UXQ2ZGhGTjZPeHM1Qk9hSGtWK2l3a2plWVg2bHBBYzlVaFU4T3NwMFEyb09I?=
 =?utf-8?B?RUhRT2RzUjNvanVpTzVDTTFtWEZHTGZ3Yyt4bTN0cmhvcENPYUJpWW1GOVl5?=
 =?utf-8?B?bjgwZUFTYVdmbVlQWUc2dmVSb1RqcTZIWFRjSlZtUXZtOC8yeW53dWptcjBP?=
 =?utf-8?B?K25DZnI5RVhoOFV6Uzc0NTc0cy9vajNmcEU3d1lMdHZ0dTFRak52ZjZld3FJ?=
 =?utf-8?B?cGcvVGRwUzdFb1N2ekUrZWNqRGhpQTNmMXoyalRKRnh2d1RnUWlhMUlHeVMw?=
 =?utf-8?B?WGRZUVNMcnNoRU5kekhhR0kwd1M4RFhYUzcxRnFTd1ZTSkFwaStHNk44TFQ1?=
 =?utf-8?B?RmlncGV0N0NoSDdvY0U1Zy92UDEweFJ0NGRBMC8renZxTUhoSjE3N0ovc24y?=
 =?utf-8?Q?3/XZ8cu0zgcWSrcqt7sME/mAhNwRqUiyMQSDGg3?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a84c61f5-6bf3-4299-e227-08d983141a0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2021 06:41:00.7926 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4FoS2aTrivTkKtYmFokt0mBwrOqUhDyREEld4+Zg/iyEgZk6rcTHCClTZwlPA+pdk/lUor1PFUgqgBq+pt4thA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4066
X-OriginatorOrg: intel.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "parav@mellanox.com" <parav@mellanox.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "lkml@metux.net" <lkml@metux.net>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "Tian, Jun J" <jun.j.tian@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lushenming@huawei.com" <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
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

PiBGcm9tOiBEYXZpZCBHaWJzb24gPGRhdmlkQGdpYnNvbi5kcm9wYmVhci5pZC5hdT4NCj4gU2Vu
dDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIgMjksIDIwMjEgMjowMSBQTQ0KPiANCj4gT24gU3VuLCBT
ZXAgMTksIDIwMjEgYXQgMDI6Mzg6MzZQTSArMDgwMCwgTGl1IFlpIEwgd3JvdGU6DQo+ID4gVGhp
cyBwYXRjaCBhZGRzIFZGSU9fREVWSUNFX0JJTkRfSU9NTVVGRCBmb3IgdXNlcnNwYWNlIHRvIGJp
bmQgdGhlDQo+IHZmaW8NCj4gPiBkZXZpY2UgdG8gYW4gaW9tbXVmZC4gTm8gVkZJT19ERVZJQ0Vf
VU5CSU5EX0lPTU1VRkQgaW50ZXJmYWNlIGlzDQo+IHByb3ZpZGVkDQo+ID4gYmVjYXVzZSBpdCdz
IGltcGxpY2l0bHkgZG9uZSB3aGVuIHRoZSBkZXZpY2UgZmQgaXMgY2xvc2VkLg0KPiA+DQo+ID4g
SW4gY29uY2VwdCBhIHZmaW8gZGV2aWNlIGNhbiBiZSBib3VuZCB0byBtdWx0aXBsZSBpb21tdWZk
cywgZWFjaCBob3N0aW5nDQo+ID4gYSBzdWJzZXQgb2YgSS9PIGFkZHJlc3Mgc3BhY2VzIGF0dGFj
aGVkIGJ5IHRoaXMgZGV2aWNlLg0KPiANCj4gSSByZWFsbHkgZmVlbCBsaWtlIHRoaXMgbWFueTwt
Pm1hbnkgbWFwcGluZyBiZXR3ZWVuIGRldmljZXMgaXMgZ29pbmcNCj4gdG8gYmUgc3VwZXItY29u
ZnVzaW5nLCBhbmQgdGhlcmVmb3JlIG1ha2UgaXQgcmVhbGx5IGhhcmQgdG8gYmUNCj4gY29uZmlk
ZW50IHdlIGhhdmUgYWxsIHRoZSBydWxlcyByaWdodCBmb3IgcHJvcGVyIGlzb2xhdGlvbi4NCg0K
QmFzZWQgb24gbmV3IGRpc2N1c3Npb24gb24gZ3JvdXAgb3duZXJzaGlwIHBhcnQgKHBhdGNoMDYp
LCBJIGZlZWwgdGhpcw0KbWFueTwtPm1hbnkgcmVsYXRpb25zaGlwIHdpbGwgZGlzYXBwZWFyLiBU
aGUgY29udGV4dCBmZCAoZWl0aGVyIGNvbnRhaW5lcg0Kb3IgaW9tbXVmZCkgd2lsbCB1bmlxdWVs
eSBtYXJrIHRoZSBvd25lcnNoaXAgb24gYSBwaHlzaWNhbCBkZXZpY2UgYW5kDQppdHMgZ3JvdXAu
IFdpdGggdGhpcyBkZXNpZ24gaXQncyBpbXByYWN0aWNhbCB0byBoYXZlIG9uZSBkZXZpY2UgYm91
bmQNCnRvIG11bHRpcGxlIGlvbW11ZmRzLiBBY3R1YWxseSBJIGRvbid0IHRoaW5rIHRoaXMgaXMg
YSBjb21wZWxsaW5nIHVzYWdlDQppbiByZWFsaXR5LiBUaGUgcHJldmlvdXMgcmF0aW9uYWxlIHdh
cyB0aGF0IG5vIG5lZWQgdG8gaW1wb3NlIHN1Y2ggcmVzdHJpY3Rpb24NCmlmIG5vIHNwZWNpYWwg
cmVhc29uLi4uIGFuZCBub3cgd2UgaGF2ZSBhIHJlYXNvbi4g8J+Yig0KDQpKYXNvbiwgYXJlIHlv
dSBPSyB3aXRoIHRoaXMgc2ltcGxpZmljYXRpb24/DQoNCj4gDQo+IFRoYXQncyB3aHkgSSB3YXMg
c3VnZ2VzdGluZyBhIGNvbmNlcHQgbGlrZSBlbmRwb2ludHMsIHRvIGJyZWFrIHRoaXMNCj4gaW50
byB0d28gbWFueTwtPm9uZSByZWxhdGlvbnNoaXBzLiAgSSdtIG9rIGlmIHRoYXQgaXNuJ3Qgdmlz
aWJsZSBpbg0KPiB0aGUgdXNlciBBUEksIGJ1dCBJIHRoaW5rIHRoaXMgaXMgZ29pbmcgdG8gYmUg
cmVhbGx5IGhhcmQgdG8ga2VlcA0KPiB0cmFjayBvZiBpZiBpdCBpc24ndCBleHBsaWNpdCBzb21l
d2hlcmUgaW4gdGhlIGludGVybmFscy4NCj4gDQoNCkkgdGhpbmsgdGhpcyBlbmRwb2ludCBjb25j
ZXB0IGlzIHJlcHJlc2VudGVkIGJ5IGlvYXNfZGV2aWNlX2luZm8gaW4NCnBhdGNoMTQ6DQoNCisv
Kg0KKyAqIEFuIGlvYXNfZGV2aWNlX2luZm8gb2JqZWN0IGlzIGNyZWF0ZWQgcGVyIGVhY2ggc3Vj
Y2Vzc2Z1bCBhdHRhY2hpbmcNCisgKiByZXF1ZXN0LiBBIGxpc3Qgb2Ygb2JqZWN0cyBhcmUgbWFp
bnRhaW5lZCBwZXIgaW9hcyB3aGVuIHRoZSBhZGRyZXNzDQorICogc3BhY2UgaXMgc2hhcmVkIGJ5
IG11bHRpcGxlIGRldmljZXMuDQorICovDQorc3RydWN0IGlvYXNfZGV2aWNlX2luZm8gew0KKwlz
dHJ1Y3QgaW9tbXVmZF9kZXZpY2UgKmlkZXY7DQorCXN0cnVjdCBsaXN0X2hlYWQgbmV4dDsNCiB9
Ow0KDQpjdXJyZW50bHkgaXQncyAxOjEgbWFwcGluZyBiZWZvcmUgdGhpcyBvYmplY3QgYW5kIGlv
bW11ZmRfZGV2aWNlLCANCmJlY2F1c2Ugbm8gcGFzaWQgc3VwcG9ydCB5ZXQuDQoNCldlIGNhbiBy
ZW5hbWUgaXQgdG8gc3RydWN0IGlvYXNfZW5kcG9pbnQgaWYgaXQgbWFrZXMgeW91IGZlZWwgYmV0
dGVyLg0KDQpUaGFua3MNCktldmluDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vaW9tbXU=
