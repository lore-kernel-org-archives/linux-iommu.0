Return-Path: <SRS0=55Rd=OL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B76C433EF
	for <iommu@archiver.kernel.org>; Tue, 21 Sep 2021 23:56:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 222A161159
	for <iommu@archiver.kernel.org>; Tue, 21 Sep 2021 23:56:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 222A161159
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D374481AD1;
	Tue, 21 Sep 2021 23:56:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0n8XyRLL_tw3; Tue, 21 Sep 2021 23:56:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A445482969;
	Tue, 21 Sep 2021 23:56:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 781F8C0011;
	Tue, 21 Sep 2021 23:56:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 345B5C000D
 for <iommu@lists.linux-foundation.org>; Tue, 21 Sep 2021 23:56:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 17009606C0
 for <iommu@lists.linux-foundation.org>; Tue, 21 Sep 2021 23:56:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HRbOyVUgAIQN for <iommu@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 23:56:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CE9FC6069A
 for <iommu@lists.linux-foundation.org>; Tue, 21 Sep 2021 23:56:10 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10114"; a="202980228"
X-IronPort-AV: E=Sophos;i="5.85,311,1624345200"; d="scan'208";a="202980228"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2021 16:56:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,311,1624345200"; d="scan'208";a="533499833"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
 by fmsmga004.fm.intel.com with ESMTP; 21 Sep 2021 16:56:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 21 Sep 2021 16:56:09 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Tue, 21 Sep 2021 16:56:09 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Tue, 21 Sep 2021 16:56:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ko6DgvZmzGgZ85QiBibKWZJv8zjFuHaSP6D/IlhncyRhI0+PaQHdhcRo6vxEiojIH+TL6GgbGyOWPdMAsR2EZ9F/+WWaclB4ByLhOlQGpsBvPwCed8hwv7mVgd2utkuaNFEhJhVc5GCN/1TtN+pmUP6VYdDD5+ZWjHDwDhCuN7e+0Ya5WwwdW/5OVkDxsi8eZCpa10yPv0nUCivd9EmIZf3c2Y9DxXbExQ65bmwh0C0wbeYx/dPzFUw7UPZ/5zx642WLpY/R+nrjsiRMdjuL/TgLH5AIAHV4SwoCTQjeETeibj6uhmeo9QVepynEhe/w8WMAsN3poHn3BhHrVQdVhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=YZJCGR+ZAXiL2Kp+7TlxbNkx0Lw5h8j8iwq6vcpm5dY=;
 b=AtBwBmHqBMlS06C8PPg635sY81qkOum5WFjbSZmDkh5Za/lOlvXBchbfcYDk3ii1EVulNwlsrf77/efzf7t9Ic27rBKteGlUUi4rD6E8WKAbEuuq/1ZJAJAU9KxsfeMYfoQl+DoaDkLpvnvxGt3u8DpVGT0Eqc35vaf+ynb4kD2AeD93we9OnOdmust5C4/cQr1ZwAvbcrtOVlLClxnlAqiXOCayKp0ynLKBWreYd5xP4D3hdFKwtFW0KTBy58PVAzVo4KT2aBlZHX7a7U1HshZPmXcezCiBQQ4z615Bu5qNmtjnretmFWsG3Dwu7yNB87KgN50oAJS210XRATxDEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZJCGR+ZAXiL2Kp+7TlxbNkx0Lw5h8j8iwq6vcpm5dY=;
 b=TAYbqBls1LX9dU2HHTL4Bni1my8QxctNbkLB/ebpyO9gnfJmul/Q2+DRkNXwnmMG6ZMj1W7KRLsBbMyWcr51euIhcwHo7e2OLTnUTEhVAKcdVn6DcdFW4wV6W+MW3nfiUzavpEoPgRKt7x6jTkHdJcta5Nt8TlSu6A6kfyAOl+k=
Received: from BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13)
 by BN6PR11MB2018.namprd11.prod.outlook.com (2603:10b6:404:4a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.18; Tue, 21 Sep
 2021 23:56:06 +0000
Received: from BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df]) by BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df%8]) with mapi id 15.20.4523.018; Tue, 21 Sep 2021
 23:56:06 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [RFC 02/20] vfio: Add device class for /dev/vfio/devices
Thread-Topic: [RFC 02/20] vfio: Add device class for /dev/vfio/devices
Thread-Index: AQHXrSFvz6zvm2xHBUaW/Kl+BWVvQauuqGKAgACCWyA=
Date: Tue, 21 Sep 2021 23:56:06 +0000
Message-ID: <BN9PR11MB5433A709ED352FD81DDBF5A68CA19@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-3-yi.l.liu@intel.com>
 <20210921155705.GN327412@nvidia.com>
In-Reply-To: <20210921155705.GN327412@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 929ec524-fb3d-4899-a949-08d97d5b60c5
x-ms-traffictypediagnostic: BN6PR11MB2018:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB201814A23D61B188AA9A2AC38CA19@BN6PR11MB2018.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qgVl3NlSL7WULDSbVqMFBmTRXa5tqvhnp8m2MfE0/az2KAzXbvg1LMISL+Lt2haGLKQzESIt9d/tVXZ+M4WwXxnzKeLg0swNyiNdmFqeB7C6kl8QyHQOskG9Z8x/Yfz8gOt/w25NhqabtduV6qYuID1YYshQ59bZlFvfjKMDZFaY0jurAv1gghvyoe7kxLBUuqtxWyfQ9EUH053eX9JKdin+Wwc+hm+S9fmv/H6Slil+pTahFAwEEvWaItB39gMv4onc59ORONM6YNTrq2tnaWPMRtciZ5G+Q/hwbKjwUxSEOlocqCLdevwcE6IfY9+Wm1D2RRiiI+PYIyCR1E3PvCRjRs3bAjeT+DSS1JyQmHTEwRyGqXhfYyuckms5fUGHe6jVTIVlZAEZsV2Fp1CuvXcliBx1Iks+GMEN66/dfThynPSQi8qZksjqKnuLCib7+1HBzUVJzH8nEZgUihnzhpPrdxXUrn/IwBHLOUnluSs5qLstZZjG6tXcq0IenFyfMVW6pZoBl6Ygy7wqjQa3VBbRFkYpSrQZK1jmn0FzrPTsi+6gLrjjjICQAZHEIqM7YNNbQKNnTp/hoRFBx1bzlXh/Tp5gIrAZBgDJgoHuGx/YCtqXEsSfCeEbHEXsuUberDXIZsiK6Vn2YaAxBx+qCSqxIOjkOhidQI841qG3CvCMwHzLBVtH+dLCzy1vfOVLjc8x+/CneYss6qBrKD6mWA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5433.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(55016002)(33656002)(4326008)(508600001)(26005)(122000001)(7696005)(71200400001)(110136005)(38100700002)(5660300002)(66556008)(9686003)(8936002)(186003)(86362001)(54906003)(7416002)(2906002)(66476007)(66446008)(64756008)(6636002)(83380400001)(8676002)(76116006)(316002)(6506007)(52536014)(66946007)(38070700005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7Urv1aMhxGgcWkF8iDxXX/OiYCox1FJ2V/osZL4hbktVMPhtzPObcEnh7Nq2?=
 =?us-ascii?Q?q6Q+qnnGgcEW1PJzKNqQf/rWJHN1rtHFz8iDUJ7nu2ErarNGDcWZlLnVQSuW?=
 =?us-ascii?Q?gN65G5map6GcOIXADBrNKzE4I2BrH5l5nAil7zjiRMFUH7tfZSSjNi8j9PUN?=
 =?us-ascii?Q?bOkZrc4duu28RV2PZyQLNtGt0A4kYW5izGu7DU9Up/UkH8Wwfb9sNQzGdJm4?=
 =?us-ascii?Q?YlcfDkjvVnlxqNMHmvDMOiWeJVNEUu3ul8u7doGgmem52JVYnw5ggSl45l0/?=
 =?us-ascii?Q?T5PhldkeustHw4PNYtzvoEl3Z16AckaYkixzSOW5rk94m20pwO6iFaNOlzPs?=
 =?us-ascii?Q?UH9YdWj1Ktegp9ycCmtTsOsIAB7BBdUdPRDeKcvkSnwwup7Omb2ihyaVF0BC?=
 =?us-ascii?Q?W8j8lQ12EqhYBgvoFyOKsXdq7MS0ErTqjtp26ozOc/uQy36lkprBbn8eyaJw?=
 =?us-ascii?Q?0owGrb16q17R9uSYrjhciyci5HFKKoOqUpjQdRXfcng9hQUrryCKJ0UzPcZ+?=
 =?us-ascii?Q?Oz2s3/c8vMYGBjmSrFYjfNtdLVh7RVVx9yNZIaetgoV9SM/cXr5WinaQ3SGJ?=
 =?us-ascii?Q?3sg/JN0M9SnbflmVerPBac4YFMn/z5qU42yJos3lHagzgyXE8FZV8qxCRgzs?=
 =?us-ascii?Q?TMwaZyBHyO+Fq9xDuY6SYS6M1psdBNGNwcn1WrH6kbNiXM2i6oKGyK2CWIEa?=
 =?us-ascii?Q?Ca5zAohxyiXlEAYg0jVLBj7rvEOpgfShPVbjlagX9YhM/ImHWNEiRUCMSPQR?=
 =?us-ascii?Q?SSMOFk5oMRp1ZDNsY0/oAUvO1NkKmmq+cO/UNKDrUl2LKHwBajC+hzNTLvgN?=
 =?us-ascii?Q?SCym2t5dOp38X+nJfwtiJUOM2pJD8DpPTz/0E5Uqvq7idiWodg1TL9KM/zWb?=
 =?us-ascii?Q?7g17mooZA7RetY5yY8IghsCbY4Zih5NkgU1Hbxu6qXO8wfYtyb4qh968SwRL?=
 =?us-ascii?Q?F6xYBzHOxJgl/DYo6zInlXH8bJbZy+Y4VYQZRpjlNj0WRXE00TDIYL6XVgMr?=
 =?us-ascii?Q?AFl7Bdn6jI3Akobgr1NN9GO6cRTCqEGODxjloos3d+RPhzVMjSr0tjeWQEX8?=
 =?us-ascii?Q?3aVB4TfdSicvtTYHjQHdtxqt+Bk4ARnmNJIsPgULflptl3BV4NePVNHpOm/a?=
 =?us-ascii?Q?dz/6GFCqnbeysNffE1nGc0f9bOoPTLt2Oaki/MxKWiB8JXUH+9NxQ3KWxqfE?=
 =?us-ascii?Q?00fMHG7pqRG9fIQQNTisYop+WSW2cOoBQ+e9W+INmTZtbjx6ldum7EKB+oko?=
 =?us-ascii?Q?pX422O6K1oz3Pib2fDO9BXLlNKHFYfLHq7iYl4TwLt+PDAh37MREJ7WDYbCi?=
 =?us-ascii?Q?oCI=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 929ec524-fb3d-4899-a949-08d97d5b60c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2021 23:56:06.7000 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SfquCW+fxlGZQ7IQXTuItZXV4BDMElcFx2eKb1rs9WoAJ0otHQU2Cn+dyLnqKkSU2TizClh9yGAwF1HAUd6jWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB2018
X-OriginatorOrg: intel.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "parav@mellanox.com" <parav@mellanox.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "lkml@metux.net" <lkml@metux.net>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "Tian,
 Jun J" <jun.j.tian@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lushenming@huawei.com" <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>
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
> Sent: Tuesday, September 21, 2021 11:57 PM
> 
> On Sun, Sep 19, 2021 at 02:38:30PM +0800, Liu Yi L wrote:
> > This patch introduces a new interface (/dev/vfio/devices/$DEVICE) for
> > userspace to directly open a vfio device w/o relying on container/group
> > (/dev/vfio/$GROUP). Anything related to group is now hidden behind
> > iommufd (more specifically in iommu core by this RFC) in a device-centric
> > manner.
> >
> > In case a device is exposed in both legacy and new interfaces (see next
> > patch for how to decide it), this patch also ensures that when the device
> > is already opened via one interface then the other one must be blocked.
> >
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > ---
> >  drivers/vfio/vfio.c  | 228 +++++++++++++++++++++++++++++++++++++++----
> >  include/linux/vfio.h |   2 +
> >  2 files changed, 213 insertions(+), 17 deletions(-)
> 
> > +static int vfio_init_device_class(void)
> > +{
> > +	int ret;
> > +
> > +	mutex_init(&vfio.device_lock);
> > +	idr_init(&vfio.device_idr);
> > +
> > +	/* /dev/vfio/devices/$DEVICE */
> > +	vfio.device_class = class_create(THIS_MODULE, "vfio-device");
> > +	if (IS_ERR(vfio.device_class))
> > +		return PTR_ERR(vfio.device_class);
> > +
> > +	vfio.device_class->devnode = vfio_device_devnode;
> > +
> > +	ret = alloc_chrdev_region(&vfio.device_devt, 0, MINORMASK + 1,
> "vfio-device");
> > +	if (ret)
> > +		goto err_alloc_chrdev;
> > +
> > +	cdev_init(&vfio.device_cdev, &vfio_device_fops);
> > +	ret = cdev_add(&vfio.device_cdev, vfio.device_devt, MINORMASK +
> 1);
> > +	if (ret)
> > +		goto err_cdev_add;
> 
> Huh? This is not how cdevs are used. This patch needs rewriting.
> 
> The struct vfio_device should gain a 'struct device' and 'struct cdev'
> as non-pointer members
> 
> vfio register path should end up doing cdev_device_add() for each
> vfio_device
> 
> vfio_unregister path should do cdev_device_del()
> 
> No idr should be needed, an ida is used to allocate minor numbers
> 
> The struct device release function should trigger a kfree which
> requires some reworking of the callers
> 
> vfio_init_group_dev() should do a device_initialize()
> vfio_uninit_group_dev() should do a device_put()

All above are good suggestions!

> 
> The opened atomic is aweful. A newly created fd should start in a
> state where it has a disabled fops
> 
> The only thing the disabled fops can do is register the device to the
> iommu fd. When successfully registered the device gets the normal fops.
> 
> The registration steps should be done under a normal lock inside the
> vfio_device. If a vfio_device is already registered then further
> registration should fail.
> 
> Getting the device fd via the group fd triggers the same sequence as
> above.
> 

Above works if the group interface is also connected to iommufd, i.e.
making vfio type1 as a shim. In this case we can use the registration
status as the exclusive switch. But if we keep vfio type1 separate as
today, then a new atomic is still necessary. This all depends on how
we want to deal with vfio type1 and iommufd, and possibly what's
discussed here just adds another pound to the shim option...

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
