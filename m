Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5287DC433F5
	for <iommu@archiver.kernel.org>; Thu,  9 Dec 2021 01:48:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CD0A2606C4;
	Thu,  9 Dec 2021 01:48:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1VrUK7MldUb5; Thu,  9 Dec 2021 01:48:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C11E36068F;
	Thu,  9 Dec 2021 01:48:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 925B4C002F;
	Thu,  9 Dec 2021 01:48:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EF3CFC0012
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 01:48:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D413D4026E
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 01:48:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5w-YGxT9mOnM for <iommu@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 01:48:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BD42C4010E
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 01:48:14 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="225255413"
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; d="scan'208";a="225255413"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2021 17:48:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; d="scan'208";a="601203212"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by FMSMGA003.fm.intel.com with ESMTP; 08 Dec 2021 17:48:13 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 8 Dec 2021 17:48:13 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 8 Dec 2021 17:48:12 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 8 Dec 2021 17:48:12 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 8 Dec 2021 17:48:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPTDZa22a6E6qHQCPx6wnFdcSyF8OX8SrITEZdwuJ3d1QkD4wqUryHKvSHdeQW2UfbpBgNDiXEdsvpTTcdTXf8CkpDwl3IeF4YUs8hzvdLD5+L8wsfOWfAmfcIv4PI/GqB1C4M6CKaEVffB/v4RLRfzMjpNSvlsqMj8dYmAwTeCLdiZRKI/U/RetCnMWfEnUg+H2OvZMjAvjZIgCd3/rek5I4SQ7EUmjvKCtlOiZfcM9LKpLMxmkes6kL8Ft37DJsL0TWXllcksImBKJgWWJlEKF0X5UzKSA2DYEaoOr+724GHdM0Q84nrcGt9c2UMcUaC8eRDgqNvuDnlLv/H1i0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCeIKVVOMFGDdPO/FJ2IgjkpkbT7+SPRGGltk62aAtM=;
 b=cIpHZb3RwFw4pqsn1qfk/zfHIZtiXAAWg6LfiadKHm+/RxzjrGtfivz8BvRTx+mmSTy7uc9UlCKsjZE0V9tZFF/Osqr+aLPwFrJj0ka1qElIvRfV2uD5vYH/7uPVIwcPX4sVp19moyscuZy7nUkyHQAKkwyQ6CfZZE1P1GpVNZNC6phfHoBuy7NII8M8F0Ysfi7tfi2gAOk5MNXIK1cztJ6gKGWPZSHupm6+LgeTMGxQnXfCeVWTE+4teg+Eye6EK22MRJ7zW6kic8UHZXSzeoWTRfhWfWcD89z6EFwwS11s/D52yrbM/ET9r1PorH0Mp72Cm7J3NRe3Kh8yIyjpwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCeIKVVOMFGDdPO/FJ2IgjkpkbT7+SPRGGltk62aAtM=;
 b=Wo89Q0vz2lV2TL1H8VLMGjJ9ktLZF7ys1bOM7jKD0An8BrgsRYfnr/fKIXQtAN6eL+agQXv8zxyrZk3VFHD85BFzST9RGdbyrhnK2zYSQSxET4u5gW9CNRNkJWUVkrzYarC2cwi46KrsOEU8peWNcoVkbFA+nO0xuvoov8m28nY=
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN8PR11MB3714.namprd11.prod.outlook.com (2603:10b6:408:90::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Thu, 9 Dec
 2021 01:48:09 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04%2]) with mapi id 15.20.4755.016; Thu, 9 Dec 2021
 01:48:09 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "Jiang, Dave" <dave.jiang@intel.com>
Subject: RE: [PATCH 4/4] dmaengine: idxd: Use DMA API for in-kernel DMA with
 PASID
Thread-Topic: [PATCH 4/4] dmaengine: idxd: Use DMA API for in-kernel DMA with
 PASID
Thread-Index: AQHX67qzSUJug20b70uAfG58CL05gawok3UAgAAnooCAACXYAIAAe6NA
Date: Thu, 9 Dec 2021 01:48:09 +0000
Message-ID: <BN9PR11MB527617F8CC015E4F15EDCC9F8C709@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <1638884834-83028-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1638884834-83028-5-git-send-email-jacob.jun.pan@linux.intel.com>
 <20211208131358.GR6385@nvidia.com>
 <1ffc1366-2711-3026-fb09-8f60a260f618@intel.com>
 <20211208175116.GC6385@nvidia.com>
In-Reply-To: <20211208175116.GC6385@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.200.16
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf187dcd-d786-4b04-7500-08d9bab5f433
x-ms-traffictypediagnostic: BN8PR11MB3714:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <BN8PR11MB37147B6E978BB471526574C68C709@BN8PR11MB3714.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NcRxqxtDhj6jFWqg1bTWQOqvXecqiq2r4XG9UpIodJqOmlMxd+kB3tFNDlBUbXA+IjMYpPCGl9Sc12SVXvUNFkuKaHIWlQ9KloHIHZTRMa5TtdyIGuwzzipMGNPsXlBLcRSKKe2QKs/O9h8VM94tFB/MpKays/Y1EGW1plMAXwIaNNNRYYVB999tmRtpLTbkVjKbmBC4/KBbrYMx7elZSuu4C0IIecWDEJ6vpTXvgTQGXpJ1UAdYNu3E87krCb9n7vcd/lC4fAWdA6C/vYXNOkVSOglrW8IT+9oNnooEVju+jglQJzlukqkEaEUA5nvWvCV8IIa+i1KLR1XvxBNc0eFaZ8SYYa6hYateOEnlyfuHjgcUpNSlQ/pPQlcf5+1rQ/AZemeEr4BZwb2AuDG1VIX/cz1KPgBk9sA2u14we5uB5f3zEoUS8Uw/noQe5ML8Idwz32GklumKWD0YRi2AfG3fpLO0ta2kHauKASd5qGK1GYFOXlmqOcpYTB+Z3ieGLWyh4zWe/av30vlDtPEONRJWHvVz2+YVT2ls2XloSk+uUX727kDjSNcpAKQWAOPr41+/RfNxQQXOIpe7APAGddzSIwzb9/R36JYrt8f1OzDu+OOJjTixOxJ0DOOKGmnLVx5L8JNc5BtZ316AggK4K6E8gz2Ap+ITxMbPxI+ylPR+ycy2hgpvKzz+yISN6as3XGO3D5IrtrWnl9TvtnsNvA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(66556008)(66446008)(8676002)(7416002)(6506007)(33656002)(508600001)(66476007)(9686003)(38070700005)(66946007)(76116006)(26005)(55016003)(64756008)(4326008)(110136005)(2906002)(186003)(6636002)(86362001)(82960400001)(8936002)(52536014)(54906003)(38100700002)(83380400001)(71200400001)(5660300002)(7696005)(122000001)(316002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eXV9FWNhNXEMTXNV/IRi8NIuJpCPkimLTzmLQq4QZH+nADNmU2EQj/uBWxCC?=
 =?us-ascii?Q?rb8/YL3LJmbfv1v6LwmCigbGgXl5DXQ3eL1YyKL2EDFG4sBfFv+Vj49HC61N?=
 =?us-ascii?Q?wDFNgz1vsgfmR03myBg2rXLSynAt18k1VepnJrlPfEjKhG8OQll0xqZhw6s1?=
 =?us-ascii?Q?CVOMMWL66ahZeo5Tt3v+gTGiSwSvT5yqDGmzu7lhqVCCdkbq+4r2bvc4wngl?=
 =?us-ascii?Q?MP7+bn/5JoSJKNO9QXUdkEIz8kQnyhKfcK5ZZCWTpNmn4y4zOrpGN64d8ER3?=
 =?us-ascii?Q?1VtMTqL/G49EOKgX/rVVK+Z3ZMf2XQPefxc9dp5n/a4wByb6J8MUpQNA43st?=
 =?us-ascii?Q?0ykqQQrxVzH63UjqJZ1CUGlUiLbkynCMCk3V/Xfkksm1Hw/CwnKMl3z6N3OA?=
 =?us-ascii?Q?md3/L8zgegXo7XwgenwgyvgA71aFHEy3ZkEkbatlmlThGRGPRPFGw7XPgLH2?=
 =?us-ascii?Q?oTphJMSeOBItLLI1Cgzq2CEbS6w3Kcee1JdKPZ4mp+IPIz2EmjV+ZWLYKMqC?=
 =?us-ascii?Q?kupiofr06f8ZGIREuL8oyuXRr9r2A4ey27feHwa/1awJn9d4FAitq6E2T2qn?=
 =?us-ascii?Q?EQ3MbMndWaGz4LJQwI4dpLj4RlTUoUP4kPpSaEVMjk8vbjxECPozAWNt376R?=
 =?us-ascii?Q?urW34adURLjG0mm1kTh14+5yaLvZpFma/B7spgE9T+qToW/+RBBrYboXN0n+?=
 =?us-ascii?Q?mhq9a3C/1CibPk7GwS6bjWkh7z66oPZsURiO0EyqFv0wCBaDKggYQpAWkqmv?=
 =?us-ascii?Q?eBmMBhOAFI/crNfq3/Q7KkYbgP+0oMXHCUxLCMAcd1NN6ir5UWHriR1JATWj?=
 =?us-ascii?Q?cL/9GpmjVFhCc63XlVjL2idqAMuGelQXX5deyNAFf1w5iQbrJZ+Q3lLSsbfF?=
 =?us-ascii?Q?NWo/efgOw58ik/j1951FxKqWoJe6Ep56Hx8COrlFxoE/aD0KxWnq0Cos6i1O?=
 =?us-ascii?Q?1k+ogDx2Unh7fdGy9YhaIC1iCEd6XmL7UuCPfF5HrQ1+D3eTg2SJEomV6gSU?=
 =?us-ascii?Q?XrLqYmH+TasokMbL35ss/kQa5zlLuyb5qrob6YtnUkwXx4E0qbzZ0yPc2lpD?=
 =?us-ascii?Q?GHg56ReulxXRy5HMPMf0SlE4kBfUVP68gBzXoU+Vi/1jG0JhaqThPvRZnWk/?=
 =?us-ascii?Q?G/rgyh4/4mr/1NPBi+JBdMwEfRhRvclSfq+r5eqaWaFAFBvkUpJH7s3t2UyR?=
 =?us-ascii?Q?eDScI+xkbo9q7UXdHAvy7FUGNiU8yBC5HUSQtzWKKoqultPlZfVoCI+YFZeM?=
 =?us-ascii?Q?97QnefY7hf5G5L1azl8CLGNAURXibinm6/H6Yk2KmXWfzWKo3p1hh6qBmbN8?=
 =?us-ascii?Q?wYb8eJXxdkA1RLXqKdkUvEE5OOqcOtCYot9HqfKs774XxGpwxWS3J3LGWpjO?=
 =?us-ascii?Q?NyZT3xkE97TGVJt3gr4OVjZ8UWsgKWroYsu0DCTzuxpkjrpSim7iYMtWIHFB?=
 =?us-ascii?Q?JOv81jxubevDB5fVDxnnDcREnrHLJy6KuR6tKJXjX/7ifKVTnu3r8jwNmKv1?=
 =?us-ascii?Q?g+fIqRng49fXH1qqO1gvfh/yDbNTbSlDfn9j/ES5NfDs235Gvn7QcFSEU8kJ?=
 =?us-ascii?Q?fgky9PjW3zB7IyP22sUay5FtbLw6JFomb5O2zJZMfCUqu7bAtprtM514MX4y?=
 =?us-ascii?Q?YXZ4CKqjN/MsqC0iccq8jK4=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf187dcd-d786-4b04-7500-08d9bab5f433
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2021 01:48:09.7002 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mqlh/sXRexRg9Y9QOjzOcQG7GOzdi5D4ZO1izT/XIb0EEKDOxogytDgs8mr5StZIdhVL0nLkwNkAdvNtKhFo9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3714
X-OriginatorOrg: intel.com
Cc: "Raj, Ashok" <ashok.raj@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Kumar,
 Sanjay K" <sanjay.k.kumar@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Luck,
 Tony" <tony.luck@intel.com>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
 Barry Song <21cnbao@gmail.com>, "Williams, Dan
 J" <dan.j.williams@intel.com>, Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "Zanussi, Tom" <tom.zanussi@intel.com>
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
> Sent: Thursday, December 9, 2021 1:51 AM
> 
> > > > +	/*
> > > > +	 * Try to enable both in-kernel and user DMA request with PASID.
> > > > +	 * PASID is supported unless both user and kernel PASID are
> > > > +	 * supported. Do not fail probe here in that idxd can still be
> > > > +	 * used w/o PASID or IOMMU.
> > > > +	 */
> > > > +	if (iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) ||
> > > > +		idxd_enable_system_pasid(idxd)) {
> > > > +		dev_warn(dev, "Failed to enable PASID\n");
> > > > +	} else {
> > > > +		set_bit(IDXD_FLAG_PASID_ENABLED, &idxd->flags);
> > > >   	}
> > > Huh? How can the driver keep going if PASID isn't supported? I thought
> > > the whole point of this was because the device cannot do DMA without
> > > PASID at all?
> >
> > There are 2 types of WQ supported with the DSA devices. A dedicated WQ
> type
> > and a shared WQ type. The dedicated WQ type can support DMA with and
> without
> > PASID. The shared wq type must have a PASID to operate. The driver can
> > support dedicated WQ only without PASID usage when there is no PASID
> > support.
> 
> Can you add to the cover letter why does the kernel require to use the
> shared WQ?
> 
> Jason

Two reasons:

On native the shared WQ is useful when the kernel wants to offload
some memory operations (e.g. page-zeroing) to DSA. When #CPUs are
more than #WQs, this allows per-cpu lock-less submissions using
ENQCMD(PASID, payload) instruction.

In guest the virtual DSA HW may only contain a WQ in shared mode
(unchangeable by the guest) when the host admin wants to share
the limited WQ resource among many VMs. Then there is no choice
in guest regardless whether it's for user or kernel controlled DMA.

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
