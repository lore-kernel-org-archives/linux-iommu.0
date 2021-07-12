Return-Path: <SRS0=b5xv=ME=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE676C07E96
	for <iommu@archiver.kernel.org>; Mon, 12 Jul 2021 01:22:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57AF261026
	for <iommu@archiver.kernel.org>; Mon, 12 Jul 2021 01:22:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57AF261026
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 18226824EF;
	Mon, 12 Jul 2021 01:22:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BceB1L9Z5zpS; Mon, 12 Jul 2021 01:22:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A59638089A;
	Mon, 12 Jul 2021 01:22:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79AECC001A;
	Mon, 12 Jul 2021 01:22:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4827DC000E
 for <iommu@lists.linux-foundation.org>; Mon, 12 Jul 2021 01:22:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 219F7401D7
 for <iommu@lists.linux-foundation.org>; Mon, 12 Jul 2021 01:22:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5lv7G2t__dXe for <iommu@lists.linux-foundation.org>;
 Mon, 12 Jul 2021 01:22:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 982F840186
 for <iommu@lists.linux-foundation.org>; Mon, 12 Jul 2021 01:22:18 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10042"; a="295551480"
X-IronPort-AV: E=Sophos;i="5.84,232,1620716400"; d="scan'208";a="295551480"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jul 2021 18:22:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,232,1620716400"; d="scan'208";a="412425274"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orsmga003.jf.intel.com with ESMTP; 11 Jul 2021 18:22:16 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Sun, 11 Jul 2021 18:22:15 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Sun, 11 Jul 2021 18:22:15 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Sun, 11 Jul 2021 18:22:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l3nel6donUs8YkxTvl0T2psFzCsfIKQyz3uVtvafoTqG3dchQrQGVM6uKluwoWGjjMcmLcEU7waEe/IqKUrWmPwHksG2l3J7ll2Ah0Cz6/AAtJV2pQ+Z/8Z6GVGlRKlWFD6YPX8suAKeu4t6OJlQxE2P0Q0I5HWYzPIexhoSTbf8mrCDm79eNjgE/GZKz077LyOp9uoDPM7WviBdQ/nERyTOFYnRcEQO6VyGM0dcyKfXzoO+CSC6Q24mTq16wbhndTkLJF7016O6QJ3N/Ynfgy8n1Abn40gp9NQOUQvoake/hqtxfgackHN4X2wL5oCN1HAEen6iA6hLcRzr1pqfgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4CLfBs8VwUccARizQcCDxQxNQkY7kmUuTuR0m47YGiU=;
 b=kC5i4HY7hAeaFnswCXiuCApz1zfBYQoYkMH6Jzmv3vMpfcrXDe2IuskVzxzNA66yqWtZX3Mzv5wX+BxO5SxKwl/7+r+nBG2cW04LgyMghOYwuBvrT7jA39j9pnJvz4X1CSOxXyoKPVvrd4rvJCl5fFQ3ra1/WyLVn/ikThuwO6tgTt7bvhT4VgG/KX4NaQKnplTgvm+71DEf4KHO9AEZ9/F29j9tEGCuJw7o5J7EdOXRs7EfOvPtTA+ARDpZGwRaxX4FVn4QY0b8kgis1E8f3FBb2SQmC0cHTfSHbGCamqiJW0dhZyVN77nZTLLVZKjs6rFtkU/4ex988VCUsQwNxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4CLfBs8VwUccARizQcCDxQxNQkY7kmUuTuR0m47YGiU=;
 b=gQVCv2TtABku+eCtnZcWH3TWMtwBa1O2DHz0LG3fYtGSHdQCXXZMylpXqw03DukIjO1Bl0gmRb5ZCcCAhKfaEjBzsBvz3JLNfGhFgnMjV3X4KwaMWOrlDFbGX8yUMZEwVCBdxfvZgJrH6sZVYLc1eDUmbowIf4yvKg5RloX/NTM=
Received: from BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13)
 by BN6PR11MB1940.namprd11.prod.outlook.com (2603:10b6:404:104::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Mon, 12 Jul
 2021 01:22:11 +0000
Received: from BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::fd4b:cdde:6790:134]) by BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::fd4b:cdde:6790:134%7]) with mapi id 15.20.4308.026; Mon, 12 Jul 2021
 01:22:11 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: RE: [RFC v2] /dev/iommu uAPI proposal
Thread-Topic: [RFC v2] /dev/iommu uAPI proposal
Thread-Index: Add0lrMH87IsTsl5Rp6WN1oQU6kGMQAdcmAAAGvGIGA=
Date: Mon, 12 Jul 2021 01:22:11 +0000
Message-ID: <BN9PR11MB54336FB9845649BB2D53022C8C159@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <BN9PR11MB5433B1E4AE5B0480369F97178C189@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210709155052.2881f561.alex.williamson@redhat.com>
In-Reply-To: <20210709155052.2881f561.alex.williamson@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe8ebe52-36fc-4cc2-3fc4-08d944d37978
x-ms-traffictypediagnostic: BN6PR11MB1940:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB1940A094DF9E9A49CBF06CBD8C159@BN6PR11MB1940.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FeotRSy9hohQ+e3xsspSdszKItXCiRCW7FH9ucT381uYZfkmQRzwvZoj+D/QnJqgDPSc5Ixa9vNOZ9VYzCAqGkSiRMxbfT8hwEPJ/2FQOBnHXeBZpi5bbCJQzuGTsqJLPnS/nvbzO6xtOL4GgKuOXeV31uJrSRSOB/S7zjAGrny1KoHIeoAKNESgbis6/+t70VuKKDVvv6vzg8vg2RmGUYQDmEytrPaScDacpPqp8F/CWVAGzvYkUwFF/CJcuhpHAG/s4dCwwFg7lVdzN4Azk4/woX4TsxjWskSrBEl4xvkERlOFLnY+kJ57e+Ljf0NPQX10DvmM5biE1yuDXkbljeLVzovfiza221sgtYWwRlr2w4cWCPs9fiadNuHp5lH19iBLdMsMBVAlfFTq5Bih28wtTwWNciUw2RLu7tvodl3fGUvLZRZJkjMrph3npXKiin6sbL5mnbFjZBES5eeitWhrMl4rTl5F/eoEjKXelNuJZP8IS1WPxZ5tgyY2VwiRM+ig1GZLT7tjRxslY76pJ0/PW0dfN/zt854XtACvYByEOcGTsqrcNs0YFw9s3Xd6PsSSQVz9pzaaabn4D9AnUl4Ula6WnWl6LmFauPcfrV3cBRdNKUQ6xtkqyyMoL8pSSNqik00sBEmIxnDN/WwnlQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5433.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(396003)(376002)(366004)(86362001)(5660300002)(186003)(26005)(6506007)(7696005)(66946007)(52536014)(122000001)(66446008)(66556008)(64756008)(66476007)(71200400001)(33656002)(83380400001)(76116006)(478600001)(55016002)(8676002)(4326008)(9686003)(6916009)(316002)(38100700002)(8936002)(2906002)(7416002)(54906003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eKCJFW9via1Za/3XRVfhQKI5l3dGJxLbgx7vdGlC8Gler3R2q+aeN3/uPUmA?=
 =?us-ascii?Q?hVe6GayPdextnp9CmbdBQUKGXKTB67QMgCLQgKHJVwBaS5qtZnnW2vO7g3DI?=
 =?us-ascii?Q?6xYijiEOM2JuzSvMNF+1RjwWRYtHnVi5WdGo8SB6FcDC1RaQfLryVQ1Erv1l?=
 =?us-ascii?Q?SxPAfVh1mWIfGTfA0chYVx6kJWfBn3JkFjoYKy7lJHxw4xw2VvsiLv19+m2x?=
 =?us-ascii?Q?hYGPmhXBCFMFsLa4uef5a4B1O+EJQYerdSvRg4oP9J8KZhixBj87cGboNaNr?=
 =?us-ascii?Q?4SgVcq2vWxmjkVk397AfXjOaKg0OQdM+84hIR/JD14oq4WYTOdwJQ3uAX6vT?=
 =?us-ascii?Q?8Z324DYOSXAMdA3ZCAblNTgmSeLZLK1z5U6+j3Iw3+VelcRRuENzvFYhXCf3?=
 =?us-ascii?Q?G32bgKEAdAOaT+AmNSjRj3OIDLyYrVfHMGZ36XCj8o/O6ysZepqvkXH9iFh0?=
 =?us-ascii?Q?Ffzuvyyim02TVGOcypd9q1KAzRxkSsw00Plg8w7lUqxM7ux0NtgJtwOnWbbf?=
 =?us-ascii?Q?cLMtwW/QC2yhe4M0rmOSQ8Zymh4H/Nc2glGIG5CIhKt0lYwluxtby8RSYEiz?=
 =?us-ascii?Q?S//aRk7z9uEAf2rpZDkguTHMjUn+qDq70NKNK1WW2TCsnvwxLZYMoE3pMbW6?=
 =?us-ascii?Q?FE0X6T7bp8W/M5ewiFFi6Chrs6SylAvbCtPURzBLiEiA4a9H0YV9K08CbeCD?=
 =?us-ascii?Q?ef69nvF5KSWSJGm8UtymHZq4q/n27lR0kAjtA2kHKNcfSAn1W5wW3cqN+iib?=
 =?us-ascii?Q?mpulrpzBkKSk+jfCt7cnu3k8/f50ymO8wi+BMIRbieYrWYo7NNslOwiEubjW?=
 =?us-ascii?Q?D2GXU3yz5r2g4WxI9NoAw6r/Yqh/4+U1CMHCYSi3cJqaacbX96uzAJ5eB71h?=
 =?us-ascii?Q?/SqCrCU1XV9S4sr0LPzRqJc6RGQ0npasNbo2rk8WhBzvPggxkV1LZtH9+T0S?=
 =?us-ascii?Q?bQOKpujstrTX3IwjzZiaeYP7IyqEB8rexMkME+JIKHlg/mniTUk0lLaqz5jV?=
 =?us-ascii?Q?2tOLF2vRhIKndolmSyXLJg0HXEPnozsxs7vgkONs5sLV0cqS5WfeO4QuId7j?=
 =?us-ascii?Q?nE5sfYPScAi/2JRaqDuhMeNTWhfp3JnOMjZsBr0KvXQAYQphqPRvSZIoWgpB?=
 =?us-ascii?Q?BtYoOvc1r6TasVwBVEAU8nIRNRP0TNEx7T+P4QRVZmtRWllrlqbmvIbaBHlG?=
 =?us-ascii?Q?SaBUFhkOHoO2UfGgptCfRWCMyxWUeRfF1MIVjV93ZfBhptJXx/Kmr3tZOFRB?=
 =?us-ascii?Q?zlR4RUlR2umQYIT7qemw23XU1l7ClWBjL0HR02KHHqY0lNhvMN6jDMH3w6hS?=
 =?us-ascii?Q?PVFcvpcdIgDBinNAB4vHIDH9?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe8ebe52-36fc-4cc2-3fc4-08d944d37978
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2021 01:22:11.4824 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3aNK6iwGMekS9xOWuK80Z/OYFAX5Y7MvP/1HpvKZHYevhdG75WMtNHSgqCHsZbkQToQuXkFKewQoJbe7mZH8Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1940
X-OriginatorOrg: intel.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jason Wang <jasowang@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@nvidia.com>,
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

> From: Alex Williamson <alex.williamson@redhat.com>
> Sent: Saturday, July 10, 2021 5:51 AM
> 
> Hi Kevin,
> 
> A couple first pass comments...
> 
> On Fri, 9 Jul 2021 07:48:44 +0000
> "Tian, Kevin" <kevin.tian@intel.com> wrote:
> > 2.2. /dev/vfio device uAPI
> > ++++++++++++++++++++++++++
> >
> > /*
> >   * Bind a vfio_device to the specified IOMMU fd
> >   *
> >   * The user should provide a device cookie when calling this ioctl. The
> >   * cookie is later used in IOMMU fd for capability query, iotlb invalidation
> >   * and I/O fault handling.
> >   *
> >   * User is not allowed to access the device before the binding operation
> >   * is completed.
> >   *
> >   * Unbind is automatically conducted when device fd is closed.
> >   *
> >   * Input parameters:
> >   *	- iommu_fd;
> >   *	- cookie;
> >   *
> >   * Return: 0 on success, -errno on failure.
> >   */
> > #define VFIO_BIND_IOMMU_FD	_IO(VFIO_TYPE, VFIO_BASE + 22)
> 
> I believe this is an ioctl on the device fd, therefore it should be
> named VFIO_DEVICE_BIND_IOMMU_FD.

make sense.

> 
> >
> >
> > /*
> >   * Report vPASID info to userspace via VFIO_DEVICE_GET_INFO
> >   *
> >   * Add a new device capability. The presence indicates that the user
> >   * is allowed to create multiple I/O address spaces on this device. The
> >   * capability further includes following flags:
> >   *
> >   *	- PASID_DELEGATED, if clear every vPASID must be registered to
> >   *	  the kernel;
> >   *	- PASID_CPU, if set vPASID is allowed to be carried in the CPU
> >   *	  instructions (e.g. ENQCMD);
> >   *	- PASID_CPU_VIRT, if set require vPASID translation in the CPU;
> >   *
> >   * The user must check that all devices with PASID_CPU set have the
> >   * same setting on PASID_CPU_VIRT. If mismatching, it should enable
> >   * vPASID only in one category (all set, or all clear).
> >   *
> >   * When the user enables vPASID on the device with PASID_CPU_VIRT
> >   * set, it must enable vPASID CPU translation via kvm fd before attempting
> >   * to use ENQCMD to submit work items. The command portal is blocked
> >   * by the kernel until the CPU translation is enabled.
> >   */
> > #define VFIO_DEVICE_INFO_CAP_PASID		5
> >
> >
> > /*
> >   * Attach a vfio device to the specified IOASID
> >   *
> >   * Multiple vfio devices can be attached to the same IOASID, and vice
> >   * versa.
> >   *
> >   * User may optionally provide a "virtual PASID" to mark an I/O page
> >   * table on this vfio device, if PASID_DELEGATED is not set in device info.
> >   * Whether the virtual PASID is physically used or converted to another
> >   * kernel-allocated PASID is a policy in the kernel.
> >   *
> >   * Because one device is allowed to bind to multiple IOMMU fd's, the
> >   * user should provide both iommu_fd and ioasid for this attach operation.
> >   *
> >   * Input parameter:
> >   *	- iommu_fd;
> >   *	- ioasid;
> >   *	- flag;
> >   *	- vpasid (if specified);
> >   *
> >   * Return: 0 on success, -errno on failure.
> >   */
> > #define VFIO_ATTACH_IOASID		_IO(VFIO_TYPE, VFIO_BASE +
> 23)
> > #define VFIO_DETACH_IOASID		_IO(VFIO_TYPE, VFIO_BASE +
> 24)
> 
> Likewise, VFIO_DEVICE_{ATTACH,DETACH}_IOASID
> 
> ...
> > 3. Sample structures and helper functions
> > --------------------------------------------------------
> >
> > Three helper functions are provided to support VFIO_BIND_IOMMU_FD:
> >
> > 	struct iommu_ctx *iommu_ctx_fdget(int fd);
> > 	struct iommu_dev *iommu_register_device(struct iommu_ctx *ctx,
> > 		struct device *device, u64 cookie);
> > 	int iommu_unregister_device(struct iommu_dev *dev);
> >
> > An iommu_ctx is created for each fd:
> >
> > 	struct iommu_ctx {
> > 		// a list of allocated IOASID data's
> > 		struct xarray		ioasid_xa;
> >
> > 		// a list of registered devices
> > 		struct xarray		dev_xa;
> > 	};
> >
> > Later some group-tracking fields will be also introduced to support
> > multi-devices group.
> >
> > Each registered device is represented by iommu_dev:
> >
> > 	struct iommu_dev {
> > 		struct iommu_ctx	*ctx;
> > 		// always be the physical device
> > 		struct device 		*device;
> > 		u64			cookie;
> > 		struct kref		kref;
> > 	};
> >
> > A successful binding establishes a security context for the bound
> > device and returns struct iommu_dev pointer to the caller. After this
> > point, the user is allowed to query device capabilities via IOMMU_
> > DEVICE_GET_INFO.
> 
> If we have an initial singleton group only restriction, I assume that
> both iommu_register_device() would fail for any devices that are not in
> a singleton group and vfio would only expose direct device files for
> the devices in singleton groups.  The latter implementation could
> change when multi-device group support is added so that userspace can
> assume that if the vfio device file exists, this interface is available.
> I think this is confirmed further below.

Exactly. Will elaborate this assumption in next version.

> 
> > For mdev the struct device should be the pointer to the parent device.
> 
> I don't get how iommu_register_device() differentiates an mdev from a
> pdev in this case.

via device cookie.

> 
> ...
> > 4.3. IOASID nesting (software)
> > ++++++++++++++++++++++++++++++
> >
> > Same usage scenario as 4.2, with software-based IOASID nesting
> > available. In this mode it is the kernel instead of user to create the
> > shadow mapping.
> >
> > The flow before guest boots is same as 4.2, except one point. Because
> > giova_ioasid is nested on gpa_ioasid, locked accounting is only
> > conducted for gpa_ioasid which becomes the only root.
> >
> > There could be a case where different gpa_ioasids are created due
> > to incompatible format between dev1/dev2 (e.g. about IOMMU
> > enforce-snoop). In such case the user could further created a dummy
> > IOASID (HVA->HVA) as the root parent for two gpa_ioasids to avoid
> > duplicated accounting. But this scenario is not covered in following
> > flows.
> 
> This use case has been noted several times in the proposal, it probably
> deserves an example.

will do.

> 
> >
> > To save space we only list the steps after boots (i.e. both dev1/dev2
> > have been attached to gpa_ioasid before guest boots):
> >
> > 	/* After boots */
> > 	/* Create GIOVA space nested on GPA space
> > 	 * Both page tables are managed by the kernel
> > 	 */
> > 	alloc_data = {.user_pgtable = false; .parent = gpa_ioasid};
> > 	giova_ioasid = ioctl(iommu_fd, IOMMU_IOASID_ALLOC, &alloc_data);
> 
> So the user would use IOMMU_DEVICE_GET_INFO on the iommu_fd with
> device
> cookie2 after the VFIO_DEVICE_BIND_IOMMU_FD to learn that software
> nesting is supported before proceeding down this path?

yes. If this capability is not available, the user should fall back to the
flow in 4.2, i.e. generating shadow mappings in userspace.

> 
> >
> > 	/* Attach dev2 to the new address space (child)
> > 	 * Note dev2 is still attached to gpa_ioasid (parent)
> > 	 */
> > 	at_data = { .fd = iommu_fd; .ioasid = giova_ioasid};
> > 	ioctl(device_fd2, VFIO_ATTACH_IOASID, &at_data);
> >
> > 	/* Setup a GIOVA [0x2000] ->GPA [0x1000] mapping for giova_ioasid,
> > 	 * based on the vIOMMU page table. The kernel is responsible for
> > 	 * creating the shadow mapping GIOVA [0x2000] -> HVA [0x40001000]
> > 	 * by walking the parent's I/O page table to find out GPA [0x1000] ->
> > 	 * HVA [0x40001000].
> > 	 */
> > 	dma_map = {
> > 		.ioasid	= giova_ioasid;
> > 		.iova	= 0x2000;	// GIOVA
> > 		.vaddr	= 0x1000;	// GPA
> > 		.size	= 4KB;
> > 	};
> > 	ioctl(iommu_fd, IOMMU_MAP_DMA, &dma_map);
> >
> > 4.4. IOASID nesting (hardware)
> > ++++++++++++++++++++++++++++++
> >
> > Same usage scenario as 4.2, with hardware-based IOASID nesting
> > available. In this mode the I/O page table is managed by userspace
> > thus an invalidation interface is used for the user to request iotlb
> > invalidation.
> >
> > 	/* After boots */
> > 	/* Create GIOVA space nested on GPA space.
> > 	 * Claim it's an user-managed I/O page table.
> > 	 */
> > 	alloc_data = {
> > 		.user_pgtable	= true;
> > 		.parent		= gpa_ioasid;
> > 		.addr		= giova_pgtable;
> > 		// and format information;
> > 	};
> > 	giova_ioasid = ioctl(iommu_fd, IOMMU_IOASID_ALLOC, &alloc_data);
> >
> > 	/* Attach dev2 to the new address space (child)
> > 	 * Note dev2 is still attached to gpa_ioasid (parent)
> > 	 */
> > 	at_data = { .fd = iommu_fd; .ioasid = giova_ioasid};
> > 	ioctl(device_fd2, VFIO_ATTACH_IOASID, &at_data);
> >
> > 	/* Invalidate IOTLB when required */
> > 	inv_data = {
> > 		.ioasid	= giova_ioasid;
> > 		// granular/cache type information
> > 	};
> > 	ioctl(iommu_fd, IOMMU_INVALIDATE_CACHE, &inv_data);
> >
> > 	/* See 4.6 for I/O page fault handling */
> >
> > 4.5. Guest SVA (vSVA)
> > +++++++++++++++++++++
> >
> > After boots the guest further creates a GVA address spaces (vpasid1) on
> > dev1. Dev2 is not affected (still attached to giova_ioasid).
> >
> > As explained in section 1.4, the user should check the PASID capability
> > exposed via VFIO_DEVICE_GET_INFO and follow the required uAPI
> > semantics when doing the attaching call:
> 
> And this characteristic lives in VFIO_DEVICE_GET_INFO rather than
> IOMMU_DEVICE_GET_INFO because this is a characteristic known by the
> vfio device driver rather than the system IOMMU, right?  Thanks,
> 

yes. 

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
