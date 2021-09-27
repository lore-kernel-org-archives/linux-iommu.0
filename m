Return-Path: <SRS0=QBaT=OR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C25C433EF
	for <iommu@archiver.kernel.org>; Mon, 27 Sep 2021 01:12:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9237160F41
	for <iommu@archiver.kernel.org>; Mon, 27 Sep 2021 01:12:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9237160F41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4BFA060737;
	Mon, 27 Sep 2021 01:12:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bvPji1wD1zOs; Mon, 27 Sep 2021 01:12:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1BF766071A;
	Mon, 27 Sep 2021 01:12:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DE08EC000F;
	Mon, 27 Sep 2021 01:12:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 995B9C000D
 for <iommu@lists.linux-foundation.org>; Mon, 27 Sep 2021 01:12:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 746214018A
 for <iommu@lists.linux-foundation.org>; Mon, 27 Sep 2021 01:12:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tGVxtiXQ_ppU for <iommu@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 01:12:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5A12E400BD
 for <iommu@lists.linux-foundation.org>; Mon, 27 Sep 2021 01:12:34 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10119"; a="224415348"
X-IronPort-AV: E=Sophos;i="5.85,325,1624345200"; d="scan'208";a="224415348"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2021 18:12:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,325,1624345200"; d="scan'208";a="615589954"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
 by fmsmga001.fm.intel.com with ESMTP; 26 Sep 2021 18:12:33 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Sun, 26 Sep 2021 18:12:32 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Sun, 26 Sep 2021 18:12:32 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Sun, 26 Sep 2021 18:12:32 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Sun, 26 Sep 2021 18:12:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4o5hOgViEay8kMUW/KlNF/BNA5dY7CzP2tklbckJCNBCw2g3KQJcmwD0+8aYe+2aWvuvKnO4QDiAFjjudz+XMhe0/RnwRdxim8TytE4hsu3Cxxisy7TYmiPbvrlCp1bKhurYSdnZJiR7orMvSVJi4Z6H22Gv28Eu+qnWaF2IUaBqMuPGRRgyUGXKMDXGUsw1VHCeL39gJhAtwTnQ3dxl+N1zsHcvGIsitIvhe/MREQo7Glae90zUk8k0vdc5Wtlg3oU3fgjWn9jstA473NbJSNwCewCURvd381J9LfiuyYhE6nF8RfLu5tPdBuhg3jNIfg5mdui9yPQ6eN1AUByUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=kKFkuJ6xEX1c1SZMLcBhz898ro0shB/3TeEKKifKO2k=;
 b=g1kpLxIiLpnsY2ki0hH5j9aGstKdAt02jFDm5jmcSTTla+mNdU0zU9h/dGw3k/4ADSdjs1Ss3qERgyxVkZg4h9gq/+IgHR3bg4ztKZfjQoWIcMvwYDMuDmyhS6CuPfB6J2Qc6eejZcUBuSCaL/02PdQ/EKniRU1EV6P3ROpeE6kGq3yNxEWMYWt9b3sWQV+UUIP23RaQPwH+BfVyNEi758yE9RlWJyQDsgRheNHwEnGHSMaFFSt/X8Q93Ktl2siozlwox4ems6Gjf1q4C8vr8abVbGn9rcDy7RyNHfH8Z8wcjhAen0WeuFHyH2a4Kn+W2+VnB7GAf2ohAy/jwcBs4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKFkuJ6xEX1c1SZMLcBhz898ro0shB/3TeEKKifKO2k=;
 b=wTByJM+b9rYaGhLGelT/qedH/8vSswmHtmjPS0zBN6GFRc4181oXBUpMYcnDd/IjzWXV/sZgYFkR6ws0n2jD5W1qKaYtoefmdwPExIIIbGCTNiYm2NUXFPPrAQYE3pcZrn3YlZNKIaYC6id7OZskQv25it9oQo8E2v+I/a8Uhtw=
Received: from BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13)
 by BN7PR11MB2753.namprd11.prod.outlook.com (2603:10b6:406:b0::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Mon, 27 Sep
 2021 01:12:30 +0000
Received: from BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df]) by BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df%8]) with mapi id 15.20.4544.021; Mon, 27 Sep 2021
 01:12:30 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>
Subject: RE: [PATCH v2 2/3] iommu/vt-d: Check FL and SL capability sanity in
 scalable mode
Thread-Topic: [PATCH v2 2/3] iommu/vt-d: Check FL and SL capability sanity in
 scalable mode
Thread-Index: AQHXssyKRmq7SSPsJ0uVeb21B0HFDKu3ESWw
Date: Mon, 27 Sep 2021 01:12:30 +0000
Message-ID: <BN9PR11MB54332D919870D61308795C708CA79@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <20210926114535.923263-1-baolu.lu@linux.intel.com>
 <20210926114535.923263-3-baolu.lu@linux.intel.com>
In-Reply-To: <20210926114535.923263-3-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b1534afe-9fd5-4630-6e8b-08d98153e0c4
x-ms-traffictypediagnostic: BN7PR11MB2753:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR11MB2753D1105511E684E1F35DD18CA79@BN7PR11MB2753.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zMoIJ8xhMpDXANVmhroFM6cRNN24G4Y42+cxxg6CLaKVEBYMrAn1uoRLuGePjenYFNvZnfWuuvN1HdZcO6G4BfghzT9jXwUmCxRjI6vnEMIDRUWJgQXLDydqmkpiM2QcmunPA+xltQdRx25H59Qfjsb+I0gl34AaluW7tlm+HAbpo2jblSnr544Fa05V+gOxDm0T/CKHCOeGi1bkA7v+qiEQDy3hiuK8JxYXss2g+3zLX58CMcSCAKYKJHXjnb70BGEDQ7+qFJlbIU3Q8YCfGJ1zsUgxKhUWgW24+r/XUByfovEqdeQUtddB9D9Ppr1b5smhU2zudm//4y3IYzKXZKzSqGGPuii9e2NbxWlSGB5Sd65qlF7PgQ1IebqAKnl5ypN3FhPmcRQGSXv3Rorox1meGOB9HIATmky8LV2CWTLsgVuMYouNTqjDBfrd6ECCcRHUKx5QV2t3naPbUvkzwtFHWJOLayY9VJSmpJhCH6jYd2jo63+BkGWB5/G2vUMdex45QExs2qcmRfB9SGcipf3kvW9BIKcYziR5+eiEfH6BFqUdNYpmMcVTJA1qg2doqtUc9kTm/XIlo6IUoe2OZ7AdbnID6T0LDamNGtCcR6H6SCBXgxp/jFZpNIZ1g5BxpiUN3368H1wPVneFB2CIEbLTSJ/RUNdghPtCf4qhHKiYM1hRrekQhWoQ5F3G3MoKy9CiGWUZxOOuLzw7O3/78g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5433.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(86362001)(55016002)(38100700002)(71200400001)(8936002)(33656002)(7696005)(26005)(122000001)(83380400001)(9686003)(6506007)(76116006)(110136005)(54906003)(4326008)(5660300002)(316002)(508600001)(66446008)(64756008)(66556008)(38070700005)(8676002)(52536014)(2906002)(66946007)(66476007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EBFRlYPDnGKXju6/ltfrWkFm+beQUH32PIqWRM+nwf/SrXne0B7xbkh/bfg2?=
 =?us-ascii?Q?TAgN2mBjzIHkvKgam3VlPDf+snuFsB0cqTEs3txpxEQZb3/GKgBR2p/AhebV?=
 =?us-ascii?Q?ezu//NjcYjYZA7pcCfEcUdK0JSjpIQYPUOO+bn6+gNktxexZc11PI4bMmgPA?=
 =?us-ascii?Q?EN4eKcXwI1cN9XoCTeJUjghkiJSMMDYrNJKy8CQwqaP1HwKQ18FEungZcS5f?=
 =?us-ascii?Q?/DgVzcIgeUHIaHWXatYmgf5z+GQ+vbz3C/nWjOw6rz3SZgDXXF2bJ4Ayz5a3?=
 =?us-ascii?Q?gGMJ8B2OR1b6ngrBOHbvRXLlnZJVY9zzR5ZUpF5A8eUOHp2ayGoF9dBlWctC?=
 =?us-ascii?Q?Ely73zAisps01v6DRRYci/Hp0KWvUCBcouj5Qjl/LeMxE+OEk/n3ZNfCOHjz?=
 =?us-ascii?Q?+V8zn7JFdpOnYsRsQ+pw4nx7QlfAwuxubQ/DCDjrpVyPmNv+1FQEVuz3WD2X?=
 =?us-ascii?Q?AL61o4pi5yXvj0QrpKIISJsWPcwXuv9bsNdSzgwjPr0X0dWxGbBxEZdyFrC1?=
 =?us-ascii?Q?IEibfKfTgGFgMHN5Ld8ubtpQDbqsSHCUCj2kzvvq4D5981rn+tGxbEdYn1TV?=
 =?us-ascii?Q?S1HE3DMWiRlMulTd/huucdqqJGKFHmB7ZSwQT7Z1I23XNmm47M2wWaOy/h6b?=
 =?us-ascii?Q?QKRWx7edxbLut1APvGh/IzEfZwUWmJh8PL/bQYCJp3AOn7FB5C3+XAUHchc6?=
 =?us-ascii?Q?SIQI6hL3uWTghCwkS7yTRmCGwybW83QIKbKfIlnSSNdW172+1iX4/zyACMQd?=
 =?us-ascii?Q?qRtvY7LK+rmu3w6+oOxMD+yBU6WHSzZZ9lcqHsWzoVfopIC2KWzV+ERaY59N?=
 =?us-ascii?Q?29Q/n3057iDPbY932RfJ2zdaY7CmGx0shdHmHrExPz6kkOXxRN8tjY3oONnd?=
 =?us-ascii?Q?KIvEOLfc/ncuaRQTd71oDhTgThR1iplyEH0oodWkdRt8GljAvF0hmStb2isR?=
 =?us-ascii?Q?of12x/7JlpzhUgez3FA/BWe+Uk/NunOI8CdpSqXRPRja96JxmBjzJBcnnTiv?=
 =?us-ascii?Q?f36uUlWKDtPjQrGd2v8QIONHa/KIixZABePiwHXpgiuufv1yuj6qzwo9MnFP?=
 =?us-ascii?Q?7iqLGXK+dQAwr4laDihXhpd2O0zFfHFG+jsLUX+teURDgcInvVeRlUjprc2R?=
 =?us-ascii?Q?IhtIj5+KivgQDaKDkk/5h7OuA/fwSWal4IYOUEEP5LQtr6rEP1aEmAl6zCOd?=
 =?us-ascii?Q?jbBbRA/IOifNDgnfmWEEUQeb6Fh7DmioPO6Y6d/Pcd8Pg51BxnwWU3lmLQJv?=
 =?us-ascii?Q?hA6YBPWlzJbuEE8mRPmOnVXwlZlRy+houNn11xTGW43FPFxMSDTRlEupKPi4?=
 =?us-ascii?Q?h0Ct9bGJvD+uA34osZrC2Z8w?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1534afe-9fd5-4630-6e8b-08d98153e0c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2021 01:12:30.1958 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ApQJVx0S25xYFJ6xthd0TyqUGNtPPJZkfWW87SygDWPsxa+VZIpJWNLQOnKqNw25qIL3VNV+pfixLreGMH36iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2753
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
> Sent: Sunday, September 26, 2021 7:46 PM
> 
> An iommu domain could be allocated and mapped before it's attached to
> any
> device. This requires that in scalable mode, when the domain is allocated,
> the format (FL or SL) of the page table must be determined. In order to
> achieve this, the platform should support consistent SL or FL capabilities
> on all IOMMU's. This adds a check for this and aborts IOMMU probing if it
> doesn't meet this requirement.

Is this a must? Looks the requirement comes from how the current code
is implemented. It sets DOMAIN_FLAG_USE_FIRST_LEVEL flag in
alloc_domain. But actually the pgtable is not allocated until the 1st device
is attached. If this understanding is correct, you can also postpone the flag 
setting until pgtable is actually allocated.

of course how to handle inconsistent IOMMU capabilities is another 
orthogonal problem. Addressing it should not be only applied to SL/FL
difference. especially this patch doesn't check consistency. it just
checks that an IOMMU must support either SL or FL which doesn't
match the commit msg here.

> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/cap_audit.h |  1 +
>  drivers/iommu/intel/cap_audit.c | 13 +++++++++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/drivers/iommu/intel/cap_audit.h
> b/drivers/iommu/intel/cap_audit.h
> index 74cfccae0e81..d07b75938961 100644
> --- a/drivers/iommu/intel/cap_audit.h
> +++ b/drivers/iommu/intel/cap_audit.h
> @@ -111,6 +111,7 @@ bool intel_cap_smts_sanity(void);
>  bool intel_cap_pasid_sanity(void);
>  bool intel_cap_nest_sanity(void);
>  bool intel_cap_flts_sanity(void);
> +bool intel_cap_slts_sanity(void);
> 
>  static inline bool scalable_mode_support(void)
>  {
> diff --git a/drivers/iommu/intel/cap_audit.c
> b/drivers/iommu/intel/cap_audit.c
> index b12e421a2f1a..040e4ae0e42b 100644
> --- a/drivers/iommu/intel/cap_audit.c
> +++ b/drivers/iommu/intel/cap_audit.c
> @@ -163,6 +163,14 @@ static int cap_audit_static(struct intel_iommu
> *iommu, enum cap_audit_type type)
>  			check_irq_capabilities(iommu, i);
>  	}
> 
> +	/*
> +	 * If the system is sane to support scalable mode, either SL or FL
> +	 * should be sane.
> +	 */
> +	if (intel_cap_smts_sanity() &&
> +	    !intel_cap_flts_sanity() && !intel_cap_slts_sanity())
> +		return -EFAULT;
> +
>  out:
>  	rcu_read_unlock();
>  	return 0;
> @@ -203,3 +211,8 @@ bool intel_cap_flts_sanity(void)
>  {
>  	return ecap_flts(intel_iommu_ecap_sanity);
>  }
> +
> +bool intel_cap_slts_sanity(void)
> +{
> +	return ecap_slts(intel_iommu_ecap_sanity);
> +}
> --
> 2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
