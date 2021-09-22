Return-Path: <SRS0=Rn8G=OM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CFEC43217
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 12:55:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C610611CA
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 12:55:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3C610611CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0DCB9613D0;
	Wed, 22 Sep 2021 12:55:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9jX7J19EAk3K; Wed, 22 Sep 2021 12:55:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C3A65613D6;
	Wed, 22 Sep 2021 12:55:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A1093C0011;
	Wed, 22 Sep 2021 12:55:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 43752C000D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 12:55:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3F61E407CB
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 12:55:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KWQbfkoFvMLr for <iommu@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 12:55:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::611])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5A9AA407C7
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 12:55:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NgLsssc8iezayJ1pz7ce7iH8CcP1Pj5kvXvOupyq/0cH79in3080OVd0/8lX9R9WNp7gtp/I+pmhr3ILn2JpO+BGQIFgxQmWoKMAaltECfHS2KYiX4kk475AkQloTPA+ekdYqFl0vPtUNxhD9xhIXi28hAr1EeUxbc9/M0EDrCx2KHTkKq+bLeLCs/Hz00ApSEHbv2dMEGWMjd2Cw28n4vTpeSZV5n+yD9kMFEZD9Bgpp/0wt5AFlfv96liuzEq1V0/UG+NePv8LuSzCKPROwb72dqfNDmbys89mPPAlcz+TDhXjQ8O6Q8FuuSfkeSeGKKI0pWPrDIJEoLNmmJHXew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=swyX46AS4zjJUDJGgiepdvJhI/BdcF8/AmcAhZqUAho=;
 b=nBHinf8jztj4PdIjaJXNOeFQxbarvvOpEpaQDQBMo1QyTzkYsxpya1m9LJTrM8MsfF9YtTcKLW4bDk2f6I+98seTiRvLEGTz0CvTLUVoV0l8mz6BltNtWGbm0CrJXeztz7XaPTSse6v5e0tk7nLKrg2AWb/rNV1PLZMUXJkeKHfJkTZccerQvHerYOV/dnHgSTZVoQspxPEU6Z6Jks/QX0giMKbXePyw/+9uia4hClZAUe36GsJ4VTvp5aTxN+SsZ7cA37JMyADRudMtgcF1XqLXh3ctova73c6j9X/4KAHRbtjYa9BvJJZhhepJhObzvEeIO6HdS58dgRjwYStb5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swyX46AS4zjJUDJGgiepdvJhI/BdcF8/AmcAhZqUAho=;
 b=ZvqInp487K6T9+N5KtFQYIUkv9/Rqq9y2WlymQf4ucciM0Zx/ow+Wq+xrD9wYz24xhpONslpFKzdLJfVfV4aOhxcIxKDwiT25v4BvTzLbWyQrK/TQtGnPSmdA+SjsMz41ZVfkb19ragIuseMiTOwHm/uxfH8r3MM6Oit1e8EynC2+u5ndpOZ7cpKuTsYFmivjahrj4tgwI0RSza4AYmo8AgnNu8bVW8Io6QlLVZhWXS127rYibUwSnxBQB56d94nfxxMnZAzrHZ3qUX/ppKAckbPp6IJEX+TrC4RbGGj5L80AYXDlGvW+NICTAdoYsEc0BXGUpftmEDFsL3ErqrpEA==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5125.namprd12.prod.outlook.com (2603:10b6:208:309::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 22 Sep
 2021 12:55:27 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4544.013; Wed, 22 Sep 2021
 12:55:26 +0000
Date: Wed, 22 Sep 2021 09:55:25 -0300
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC 12/20] iommu/iommufd: Add IOMMU_CHECK_EXTENSION
Message-ID: <20210922125525.GM327412@nvidia.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-13-yi.l.liu@intel.com>
 <20210921174711.GX327412@nvidia.com>
 <BN9PR11MB54334A552C3E606F4394EF298CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <BN9PR11MB54334A552C3E606F4394EF298CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:23a::32) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by
 MN2PR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:23a::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Wed, 22 Sep 2021 12:55:26 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1mT1mX-003xFq-Ma; Wed, 22 Sep 2021 09:55:25 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e0872a9-d248-4e8f-b42f-08d97dc83fb0
X-MS-TrafficTypeDiagnostic: BL1PR12MB5125:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB51255E7AD6AB56D3F2FFC1ADC2A29@BL1PR12MB5125.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5HOTISk61gPj1nyOx/WRhNxi4Fwk7cjCY39RDaN9ITB6PCihnfnTWtpgUSiXK7NQZixQx0extfedAO0RRV4eo2KrstZtX7YqDUwDR7UVVKZ9xjkPQSkARVj/OVCSry5Wr4qXo4tNdGlJlkEOQL9ZSPuWTTbcRYJVYjTLgmMfG9t85GGnAPaJFrm2fjvMeu6AWE/QLSaYgWKkagNHQLLniFEnSqkhYz1lpuHLuWdewqN3BWMl07pHtQa2ZYwimzer4jRrJh545doy+iOG/nVN4yVJnw4JyyGY4oybdAYocJWyrOa6WVcI2ng9orJd+8Rz80oobVvsEVuiYY1QVSqkc7TajaGNdqRDvvPDn2Hbs6fcuDQ/MwY51R0yY61nXzJ/f9Jw1grMG6jc9CqIGRQLN95LzLNS12UkxN62fJTA01aZ135OjbrI47Og7LXkBDYoETeGnCX99RfeEFYy124lZ5zAbqGkrxH4zMMbMTmhJVxNmp5XrG7gpUd+fgoo8rSyxhQE/4G9pmuNx48YOOIeggfe6h4c634bsuMgWFocNcxUeWq3LUmzKhgomh+qSGAmrIKczAXQ/p3DXG40rJnAI3X/NatkY8acfp+enof8ji6ipbyqCCYrADfzTs+6szDEC0Cmg2g5/8XUtEPCRXj537PGnyQyJoPtprOxdJSoug4AHpjHBYy3nnTuimDDKzss
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(33656002)(107886003)(8676002)(8936002)(36756003)(186003)(5660300002)(1076003)(38100700002)(4326008)(508600001)(66946007)(66476007)(66556008)(2906002)(9746002)(426003)(7416002)(9786002)(26005)(316002)(86362001)(6916009)(54906003)(2616005)(27376004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2NLbDh5ckpGMWZhbW1TSmFQUnR3cUMyWmt1Q1dXU2pJRXh1bW5haDBQK0NH?=
 =?utf-8?B?NmpuWWN5aE10d3R0bk5FL2hURTg3cnRnN0dva3EzME4yeUdyWDRNV3lOQUlo?=
 =?utf-8?B?amM5NjFtVXREZ1RyVlhTZHZlNHF6UjJGeHJ5NVVQMlBoSnNZMXIxS1ZwU215?=
 =?utf-8?B?NVdlaUZJRnFmUmFHL09SejJpdC9JNkt5Q3owazl6NGg2RExMOVgxVzV0cjBS?=
 =?utf-8?B?U3A2cHRDRW55MUxqTDdBZW00emFuQ09XZEdmdmx5NHVtWi8yR21EV2M4eGht?=
 =?utf-8?B?RlRnOUgrbkpwMHlPajNzdHpBRkw5YzI5VlA0cjRKZ0lUQ1FpUmVUREx0SzNz?=
 =?utf-8?B?WmpEeE1wMmxwcjJqcmltK2FDU2c2KzUxY0V5emxxWTBJL3FqcWhLMTFCVVFW?=
 =?utf-8?B?WjUzTVRSdlZ3MU1FbGcrZTNtY0czaUVxa3dUUmxSK3REUHIvNWNCeXBzSmhW?=
 =?utf-8?B?ZCsrT0hkL2RGRGZPUlNwMHFYNWZkQUhRc0VLOTdGcDZvTXpKRWozbjFJYzJ5?=
 =?utf-8?B?dmhoT0tEYWVhdjhQRjd5QXNUSlBpdzgycDdZWTMrTk1ROG9vRjQrYlJLT01H?=
 =?utf-8?B?L1NHMjBMZmxqbXQycXBYL3QyRWFuTW90ZWZma0d2ZE54anljRUQrNmRXUmlN?=
 =?utf-8?B?WUloSWtQUHNHNUt5d05la2NJZDExQmJiU0lkcWZoc1VHc3hhdUdUUEM4aWtx?=
 =?utf-8?B?amhpRjFjTFBxVWF2UlJ0ZHdOUTdJbmp4bTIzbzFVanRBWTdMUWhrRDAyd3p0?=
 =?utf-8?B?YStKVjhWZlUwbjZkWDZJUEgyMWhtaU5GbEJ5YVpWV3Q3NEV0d0F4MmhvbXJ0?=
 =?utf-8?B?Zm9HSGdiQmhZeTR2TEpjajBjbXQ0Ymt4eERwcFcwRVYyN0hBcE5oaXIvNnd2?=
 =?utf-8?B?R1c4S3hOb0h3VVJkaHhvOFhYM2s4VlJjcjA3NWhXM3VuK1FORFdYa0liM3Rx?=
 =?utf-8?B?bFNHcDIrZnFISldFMUFHMjhRVXFtaU9ubnZTNjdTQ1A4ZEQ0OFZTUVVxU1FI?=
 =?utf-8?B?bms5dnlTdTc4c29CODZpUnlHckdhbzNCcmpTNUxpSkt4Tm9Jd0RTdzM5eWJr?=
 =?utf-8?B?TXk1aTU2TFNjNldxOVlVSzl6NE5rNldJeHg0NisrVUc0aHJyTVYxa25WcU9K?=
 =?utf-8?B?a3BCYk1ubk10b3Y4MHlFbUk5Uy94V0MrcmhCUUFLL3Rqak5iWUlxc1VNMW42?=
 =?utf-8?B?MXNLVVJuT1lCT3NHQ0NWWEw2d1JoZEQvTkltZ2VsK3Q5YXZDcWxnTTUxUlZL?=
 =?utf-8?B?bnd4RE1DdVNqUldYclRPQnM2MW5YMXZjWHRtTDMzVVhpRkt4MUtKRlNldFAv?=
 =?utf-8?B?dHVieFVva2NEQnNSTDZRVVRRcFFXaFQ1RUxiQVBMUFEzU3ZINWd4T2o2aHFw?=
 =?utf-8?B?ZFpzQ05wTkdGODNHYjVpZmFqdUw4TmpGVHBndDJnaGNnZ2FaaGI0MytDYkxu?=
 =?utf-8?B?eWxvMThieCtGNStuclBDT1VIUDQxZ21nRlZGTmJxV1Bpa21tR05EUWNXc1BS?=
 =?utf-8?B?Z3d3ckxjSUJzNlNFSmZnVnBMVWlBdlMxS0VTeTM5SUVONk1mM0dHQ3BZeDRV?=
 =?utf-8?B?czBSZGxrZ0UzV2lneXpUck8wL1NseGJsU0x5TW9KVThReDJzMkZyR3ZSTWtI?=
 =?utf-8?B?MzFZbFFkbzJGQ3F1eWt1QkpOeUkxRm5Ddlh5UjFWV2REM20ycTJIRS9LSkt5?=
 =?utf-8?B?N2JTOFV3T3ROdG55azYrUTlmVUFKOFY1M0ZEUVZqLzdLNVNXN2ZrbWRtQWpn?=
 =?utf-8?Q?+IGTg6MaXM7Txl1lMo5xfApZiBVhNsxYTHRhNz6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e0872a9-d248-4e8f-b42f-08d97dc83fb0
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 12:55:26.8288 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z2IgttDwjzRz+tQfy+5H5zhJEDQLoBclG5Rm7KGx9PmpaWxnZvHANWToJckTR83Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5125
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "parav@mellanox.com" <parav@mellanox.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "lkml@metux.net" <lkml@metux.net>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>, "Tian,
 Jun J" <jun.j.tian@intel.com>,
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
From: Jason Gunthorpe via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gV2VkLCBTZXAgMjIsIDIwMjEgYXQgMDM6NDE6NTBBTSArMDAwMCwgVGlhbiwgS2V2aW4gd3Jv
dGU6Cj4gPiBGcm9tOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPgo+ID4gU2VudDog
V2VkbmVzZGF5LCBTZXB0ZW1iZXIgMjIsIDIwMjEgMTo0NyBBTQo+ID4gCj4gPiBPbiBTdW4sIFNl
cCAxOSwgMjAyMSBhdCAwMjozODo0MFBNICswODAwLCBMaXUgWWkgTCB3cm90ZToKPiA+ID4gQXMg
YWZvcmVtZW50aW9uZWQsIHVzZXJzcGFjZSBzaG91bGQgY2hlY2sgZXh0ZW5zaW9uIGZvciB3aGF0
IGZvcm1hdHMKPiA+ID4gY2FuIGJlIHNwZWNpZmllZCB3aGVuIGFsbG9jYXRpbmcgYW4gSU9BU0lE
LiBUaGlzIHBhdGNoIGFkZHMgc3VjaAo+ID4gPiBpbnRlcmZhY2UgZm9yIHVzZXJzcGFjZS4gSW4g
dGhpcyBSRkMsIGlvbW11ZmQgcmVwb3J0cyBFWFRfTUFQX1RZUEUxVjIKPiA+ID4gc3VwcG9ydCBh
bmQgbm8gbm8tc25vb3Agc3VwcG9ydCB5ZXQuCj4gPiA+Cj4gPiA+IFNpZ25lZC1vZmYtYnk6IExp
dSBZaSBMIDx5aS5sLmxpdUBpbnRlbC5jb20+Cj4gPiA+ICBkcml2ZXJzL2lvbW11L2lvbW11ZmQv
aW9tbXVmZC5jIHwgIDcgKysrKysrKwo+ID4gPiAgaW5jbHVkZS91YXBpL2xpbnV4L2lvbW11Lmgg
ICAgICB8IDI3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKwo+ID4gPiAgMiBmaWxlcyBjaGFu
Z2VkLCAzNCBpbnNlcnRpb25zKCspCj4gPiA+Cj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lv
bW11L2lvbW11ZmQvaW9tbXVmZC5jCj4gPiBiL2RyaXZlcnMvaW9tbXUvaW9tbXVmZC9pb21tdWZk
LmMKPiA+ID4gaW5kZXggNDgzOWYxMjhiMjRhLi5lNDVkNzYzNTllMzQgMTAwNjQ0Cj4gPiA+ICsr
KyBiL2RyaXZlcnMvaW9tbXUvaW9tbXVmZC9pb21tdWZkLmMKPiA+ID4gQEAgLTMwNiw2ICszMDYs
MTMgQEAgc3RhdGljIGxvbmcgaW9tbXVmZF9mb3BzX3VubF9pb2N0bChzdHJ1Y3QgZmlsZQo+ID4g
KmZpbGVwLAo+ID4gPiAgCQlyZXR1cm4gcmV0Owo+ID4gPgo+ID4gPiAgCXN3aXRjaCAoY21kKSB7
Cj4gPiA+ICsJY2FzZSBJT01NVV9DSEVDS19FWFRFTlNJT046Cj4gPiA+ICsJCXN3aXRjaCAoYXJn
KSB7Cj4gPiA+ICsJCWNhc2UgRVhUX01BUF9UWVBFMVYyOgo+ID4gPiArCQkJcmV0dXJuIDE7Cj4g
PiA+ICsJCWRlZmF1bHQ6Cj4gPiA+ICsJCQlyZXR1cm4gMDsKPiA+ID4gKwkJfQo+ID4gPiAgCWNh
c2UgSU9NTVVfREVWSUNFX0dFVF9JTkZPOgo+ID4gPiAgCQlyZXQgPSBpb21tdWZkX2dldF9kZXZp
Y2VfaW5mbyhpY3R4LCBhcmcpOwo+ID4gPiAgCQlicmVhazsKPiA+ID4gZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvdWFwaS9saW51eC9pb21tdS5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L2lvbW11LmgKPiA+
ID4gaW5kZXggNWNiZDMwMGViMGVlLi40OTczMWJlNzEyMTMgMTAwNjQ0Cj4gPiA+ICsrKyBiL2lu
Y2x1ZGUvdWFwaS9saW51eC9pb21tdS5oCj4gPiA+IEBAIC0xNCw2ICsxNCwzMyBAQAo+ID4gPiAg
I2RlZmluZSBJT01NVV9UWVBFCSgnOycpCj4gPiA+ICAjZGVmaW5lIElPTU1VX0JBU0UJMTAwCj4g
PiA+Cj4gPiA+ICsvKgo+ID4gPiArICogSU9NTVVfQ0hFQ0tfRVhURU5TSU9OIC0gX0lPKElPTU1V
X1RZUEUsIElPTU1VX0JBU0UgKyAwKQo+ID4gPiArICoKPiA+ID4gKyAqIENoZWNrIHdoZXRoZXIg
YW4gdUFQSSBleHRlbnNpb24gaXMgc3VwcG9ydGVkLgo+ID4gPiArICoKPiA+ID4gKyAqIEl0J3Mg
dW5saWtlbHkgdGhhdCBhbGwgcGxhbm5lZCBjYXBhYmlsaXRpZXMgaW4gSU9NTVUgZmQgd2lsbCBi
ZSByZWFkeQo+ID4gPiArICogaW4gb25lIGJyZWF0aC4gVXNlciBzaG91bGQgY2hlY2sgd2hpY2gg
dUFQSSBleHRlbnNpb24gaXMgc3VwcG9ydGVkCj4gPiA+ICsgKiBhY2NvcmRpbmcgdG8gaXRzIGlu
dGVuZGVkIHVzYWdlLgo+ID4gPiArICoKPiA+ID4gKyAqIEEgcm91Z2ggbGlzdCBvZiBwb3NzaWJs
ZSBleHRlbnNpb25zIG1heSBpbmNsdWRlOgo+ID4gPiArICoKPiA+ID4gKyAqCS0gRVhUX01BUF9U
WVBFMVYyIGZvciB2ZmlvIHR5cGUxdjIgbWFwIHNlbWFudGljczsKPiA+ID4gKyAqCS0gRVhUX0RN
QV9OT19TTk9PUCBmb3Igbm8tc25vb3AgRE1BIHN1cHBvcnQ7Cj4gPiA+ICsgKgktIEVYVF9NQVBf
TkVXVFlQRSBmb3IgYW4gZW5oYW5jZWQgbWFwIHNlbWFudGljczsKPiA+ID4gKyAqCS0gRVhUX01V
TFRJREVWX0dST1VQIGZvciAxOk4gaW9tbXUgZ3JvdXA7Cj4gPiA+ICsgKgktIEVYVF9JT0FTSURf
TkVTVElORyBmb3Igd2hhdCB0aGUgbmFtZSBzdGFuZHM7Cj4gPiA+ICsgKgktIEVYVF9VU0VSX1BB
R0VfVEFCTEUgZm9yIHVzZXIgbWFuYWdlZCBwYWdlIHRhYmxlOwo+ID4gPiArICoJLSBFWFRfVVNF
Ul9QQVNJRF9UQUJMRSBmb3IgdXNlciBtYW5hZ2VkIFBBU0lEIHRhYmxlOwo+ID4gPiArICoJLSBF
WFRfRElSVFlfVFJBQ0tJTkcgZm9yIHRyYWNraW5nIHBhZ2VzIGRpcnRpZWQgYnkgRE1BOwo+ID4g
PiArICoJLSAuLi4KPiA+ID4gKyAqCj4gPiA+ICsgKiBSZXR1cm46IDAgaWYgbm90IHN1cHBvcnRl
ZCwgMSBpZiBzdXBwb3J0ZWQuCj4gPiA+ICsgKi8KPiA+ID4gKyNkZWZpbmUgRVhUX01BUF9UWVBF
MVYyCQkxCj4gPiA+ICsjZGVmaW5lIEVYVF9ETUFfTk9fU05PT1AJMgo+ID4gPiArI2RlZmluZSBJ
T01NVV9DSEVDS19FWFRFTlNJT04JX0lPKElPTU1VX1RZUEUsCj4gPiBJT01NVV9CQVNFICsgMCkK
PiA+IAo+ID4gSSBnZW5lcmFsbHkgYWR2b2NhdGUgZm9yIGEgJ3RyeSBhbmQgZmFpbCcgYXBwcm9h
Y2ggdG8gZGlzY292ZXJpbmcKPiA+IGNvbXBhdGliaWxpdHkuCj4gPiAKPiA+IElmIHRoYXQgZG9l
c24ndCB3b3JrIGZvciB0aGUgdXNlcnNwYWNlIHRoZW4gYSBxdWVyeSB0byByZXR1cm4gYQo+ID4g
Z2VuZXJpYyBjYXBhYmlsaXR5IGZsYWcgaXMgdGhlIG5leHQgYmVzdCBpZGVhLiBFYWNoIGZsYWcg
c2hvdWxkCj4gPiBjbGVhcmx5IGRlZmluZSB3aGF0ICd0cnkgYW5kIGZhaWwnIGl0IGlzIHRhbGtp
bmcgYWJvdXQKPiAKPiBXZSBkb24ndCBoYXZlIHN0cm9uZyBwcmVmZXJlbmNlIGhlcmUuIEp1c3Qg
Zm9sbG93IHdoYXQgdmZpbyBkb2VzCj4gdG9kYXkuIFNvIEFsZXgncyBvcGluaW9uIGlzIGFwcHJl
Y2lhdGVkIGhlcmUuIPCfmIoKClRoaXMgaXMgYSB1QVBJIGRlc2lnbiwgaXQgc2hvdWxkIGZvbGxv
dyB0aGUgY3VycmVudCBtYWluc3RyZWFtCnRoaW5raW5nIG9uIGhvdyB0byBidWlsZCB0aGVzZSB0
aGluZ3MuIFRoZXJlIGlzIGEgbG90IG9mIG9sZCBzdHVmZiBpbgp2ZmlvIHRoYXQgZG9lc24ndCBt
YXRjaCB0aGUgbW9kZXJuIHRoaW5raW5nLiBJTUhPLgoKPiA+IFRZUEUxVjIgc2VlbXMgbGlrZSBu
b25zZW5zZQo+IAo+IGp1c3QgaW4gY2FzZSBvdGhlciBtYXBwaW5nIHByb3RvY29scyBhcmUgaW50
cm9kdWNlZCBpbiB0aGUgZnV0dXJlCgpXZWxsLCB3ZSBzaG91bGQgbmV2ZXIsIGV2ZXIgZG8gdGhh
dC4gQWxsb3dpbmcgUFBDIGFuZCBldnJ5dGhpbmcgZWxzZQp0byBzcGxpdCBpbiBWRklPIGhhcyBj
cmVhdGVkIGEgY29tcGVsdGUgZGlzYXN0ZXIgaW4gdXNlcnNwYWNlLiBIVwpzcGVjaWZpYyBleHRl
bnNpb25zIHNob3VsZCBiZSBtb2RlbGVkIGFzIGV4dGVuc2lvbnMgbm90IGEgd2hvbGVzYWxlCnJl
cGxhY2VtZW50IG9mIGV2ZXJ5dGhpbmcuCgpJJ2Qgc2F5IHRoaXMgaXMgcGFydCBvZiB0aGUgbW9k
ZXJuIHRoaW5raW5nIG9uIHVBUEkgZGVzaWduLgoKV2hhdCBJIHdhbnQgdG8gc3RyaXZlIGZvciBp
cyB0aGUgYmFzaWMgQVBJIGlzIHVzYWJsZSB3aXRoIGFsbCBIVyAtIGFuZAppcyB3aGF0IHNvbWV0
aGluZyBsaWtlIERQREsgY2FuIGV4Y2x1c2l2ZWx5IHVzZS4KCkFuIGV4dGVuZGVkIEFQSSB3aXRo
IEhXIHNwZWNpZmljIGZhY2V0cyBleGlzdHMgZm9yIHFlbXUgdG8gdXNlIHRvCmJ1aWxkIGEgSFcg
YmFja2VkIGFjY2VsZXJlYXRlZCBhbmQgZmVhdHVyZWZ1bCB2SU9NTVUgZW11bGF0aW9uLgoKVGhl
IG5lZWRzIG9mIHFtZXUgc2hvdWxkIG5vdCB0cnVtcCB0aGUgcmVxdWlyZW1lbnQgZm9yIGEgdW5p
dmVyc2FsCmJhc2ljIEFQSS4KCkVnIGlmIHdlIGNhbid0IGZpZ3VyZSBvdXQgYSBiYXNpYyBBUEkg
dmVyc2lvbiBvZiB0aGUgUFBDIHJhbmdlIGlzc3VlCnRoZW4gdGhhdCBzaG91bGQgYmUgcHVudGVk
IHRvIGEgUFBDIHNwZWNpZmljIEFQSS4KCkphc29uCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby9pb21tdQ==
