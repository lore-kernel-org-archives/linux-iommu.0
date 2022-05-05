Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDFAFC433EF
	for <iommu@archiver.kernel.org>; Thu,  5 May 2022 23:29:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7C73A60ADE;
	Thu,  5 May 2022 23:29:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k5GuvKP1ZTVX; Thu,  5 May 2022 23:29:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 55CA660BAC;
	Thu,  5 May 2022 23:29:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 20B83C0032;
	Thu,  5 May 2022 23:29:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 96B97C002D
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:29:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8C81760AD7
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:29:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sh07WHu5apzh for <iommu@lists.linux-foundation.org>;
 Thu,  5 May 2022 23:29:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DCA0A60AB7
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651793342; x=1683329342;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=1fuV2scIM3s3g+Sem0EM9HBIo46k9gKUdmJMCLkijiA=;
 b=LIwKpjyZWXO6tmH4CX7eERMf/pJVkX+NvEO27lOWIEJkllFVtHzT9ts6
 t4d4QMmW9c2FDOjgfQJcJcWzni+KFUzIsTdr15eRV1WFdTy0jvFfsP5FC
 YevUIy1rjtwp3HECx+Ui4tSQ+RHtEG6dfKn/LfQHTVQ56ln0OMgXasAdV
 ELBbKssZ5YjudImy6Y7QfI5wcoCMfnc7c6ozttnZNI7k4oy34LJ1Ovc0H
 Z6xQn6ZSAKolbYYTFgAOdBsQ0ifGHyJEDIkluLZB0M+9EujsUrDuSDTDE
 vdl8zrhulZAcHddz2ulaB6wV9tvl0lPW/CTu8uYeRTzeA2eAs2WTFmDz9 g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="293489653"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="293489653"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2022 16:29:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="585629083"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga008.jf.intel.com with ESMTP; 05 May 2022 16:29:01 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 5 May 2022 16:29:01 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 5 May 2022 16:29:01 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 5 May 2022 16:29:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=migVf1k6r1Lxb6x2KeLmKyx1oGSjZzRuWn6ahFDY7C0gMUWJEdeYGxT3FFmtd8tD0llgF+Gc0cbpqp17ST77pxvdeIgsbfk1z/Oe0uXxZKOJ3c/k0eYO76TJEzIdca0iY2PohB+PpdfZW5eKXBHRxsLTp5iJK0w+d9YwR87rbXdhXFB9OLNZDC+CJWVeE7pGgaZJks+cv+b2DR8Bd8qmB9PUEE8M3FRA+ZK9gUif28o4vP5MAwpy4k4RRgQYFw6EXygsYuDA/B8TGKZiZ85GJRnemFzoB0zoEjFg7x9BJIjujJKvyf/KX6D6zwDnJqD9PbAcPdXa7NTUCx17o/WcHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDXy+zkfbcCDNlxy/9DW/bRuT8ih6Men0XUu0pbIQO8=;
 b=Nq+yIV4cUmJRloZhcrxzcoz1dUrnIyazK5dsUVeba7Z3hcY4kjR1FdmkScVUi7fAAVFvEFGDE0jQdLBgJw/vf1A9T6LP0a+Hir+3HqpC5ITo+NNhEtFa78HBkWiRPWnaWGxmmAJ7kBC/XXeWofPIUkvFNylLew/YwHi1vMMdPxxL5B/fp4UO3GWvdBDfFCyaDQXo3fkitJEIqGK7zGtbFPLZRFOBpurqw8XuMeslfXdDkn3ZcomFiNMT8JPIXUqcDSYQeerdvfqsMQGl9qEcz6jC7h/hiDXtW4Raj3ZvBC8oNh9u6v9I66qVpZkr37KRr5xrsEtbUtLFy6dpsGUbPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BYAPR11MB3656.namprd11.prod.outlook.com (2603:10b6:a03:f8::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25; Thu, 5 May
 2022 23:28:59 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb%2]) with mapi id 15.20.5206.027; Thu, 5 May 2022
 23:28:59 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [PATCH v2] iommu: iommu_group_claim_dma_owner() must always
 assign a domain
Thread-Topic: [PATCH v2] iommu: iommu_group_claim_dma_owner() must always
 assign a domain
Thread-Index: AQHYX+ptl9sLL9PiIEu4Iv7dSwQ2Ya0QGJJAgABSfgCAAIIvUA==
Date: Thu, 5 May 2022 23:28:58 +0000
Message-ID: <BN9PR11MB5276476BB203D8D61CA8849C8CC29@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v2-f62259511ac0+6-iommu_dma_block_jgg@nvidia.com>
 <BN9PR11MB5276504B448C715527AD5F3F8CC29@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220505153320.GS49344@nvidia.com>
In-Reply-To: <20220505153320.GS49344@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 49f21f38-602f-4e1c-f59e-08da2eef07d3
x-ms-traffictypediagnostic: BYAPR11MB3656:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BYAPR11MB365694788DC2DC7723FFA9998CC29@BYAPR11MB3656.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 54wGaKPKU7l9ytJqFF6l7MMsdksCqXcZcpaGs1Y0+lSDDul4vHGt4ZGD6R/lzOSU9ROfF8E/dw30mGSQdiI7mOC09WwO2pluZKZf2PijHRhsmxABR0mxD2V+Ge/JNQkfg6MiLxahPsWYJ7HJtFhANYKpJwlEDv1FgwzaCvUe86cbXXi73t+XbzOwMHL4sOknt/fhVrjyhQjbE+KRhxlcQ1sXo7ZA7RBWuFcYk98mPAo1T5y184A392wRuEUzITa3MvStmGrRGys49TbE8h3f1yGD/ZRqz8r92cw3iPTZqFdO8AczTMDkQ7Er5PE/80Y6mdmN0HpgO15lBbuqIlsr/Y417NogHgzFdfHOC0iOoa2Kwmqv7EOuGvfdlDaVEZGc+vMVULdAiXeM3WXTeIzGoqTs8+uQBZvA39HGQLZ+t7FC0YlSUcoTu/kHNORuzopAAXn9uLxoxQeDK2lNbAZYlD/ejkqEpi8zlJ0nNpgtwMOctLO93pC+YbkDbliP/ScKsMHXyEPHstnnI+tHnGEW3HHdMnp/+g0R612kOxgPK93ry/Qrm8Nhe5MlRvKsnjvXpG+Jb1ynCrCQS+apegjFcdHx0ACWA2Coi4hqQP1X9BAkddnZHbSJoP5Fdc/JUX7hboH7ijGscdO3rjCjx2ayc2bIrwgqsrZGCQ2tzQ88jz/Jy/kkG8fZYJ4jyxRN8q1nGlh8pfha8Ykw+2+6aSqyVg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(83380400001)(54906003)(6916009)(186003)(9686003)(86362001)(26005)(316002)(7696005)(52536014)(8676002)(6506007)(508600001)(64756008)(66446008)(76116006)(66946007)(66556008)(66476007)(2906002)(4326008)(8936002)(38070700005)(38100700002)(71200400001)(33656002)(55016003)(5660300002)(122000001)(82960400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OGOu00FpvbY1g9QbnAdTZejYC90OWnrtvInpGBvM1OLobhcOS7Dj8SGgRVTX?=
 =?us-ascii?Q?JFkDAkYOVk0DUcXsVPNOkjccWgWc8B1bB+vMZe/++Dmta75rJNS5vW7xjZZq?=
 =?us-ascii?Q?mZZ/IgL6Un9ZG0PfP1cTQqKZFEpk7PYqTDIUqJjkeVZwTEhsVzPnXSoJan/P?=
 =?us-ascii?Q?fyPdHRALUTvOgBF97mlF8Cm5ET/Psqw7lAWjvQG16KKYiBAraRrQfyHg4pWX?=
 =?us-ascii?Q?h3fk43qWQqErnPHWT1bAvA+XLA4YyeRskADgXwr+lRA8LXNa/4oZw3of0IUf?=
 =?us-ascii?Q?GnvJCRtLxXGUBVq0vGE44H1ETZtbACl50BmvDYDgwwzBphGcTdEtCB7DMn7N?=
 =?us-ascii?Q?sU2cy5vEtD1zAru4oRirKTmMP561cs2yEuDKKKxnUG7y6v6fweiht53VOgrX?=
 =?us-ascii?Q?Un2CfC4LOVXPMGuE+65GlXARrTjPf12YY7RdB3n1DkyCQn0PY0F174AUGbr/?=
 =?us-ascii?Q?7e+dHiv9JNxGvqAJiOEw9jgWk/UkbonuzrPTNtj9DfB8B8fPNhMD7rNs2+Nt?=
 =?us-ascii?Q?IvNSHu58eJsNEuJVgSYaBLC85ptsNTnQjsNn29I/rHt5frViUWFiLPToH4zl?=
 =?us-ascii?Q?HrW9MVJre9DbsZy8b9WdgcdFG4RyN+ZBTAzCP3HZbcUby0oMsc6+h2zSajx2?=
 =?us-ascii?Q?kiSvIcvnGGh0iLgesfVaAKJj5WPwccVc/TNRH7tyqaLETRNrEkEvpsR80lGx?=
 =?us-ascii?Q?Aai29TDDdXRe5Oe+aZd/saR90rKwcMfzMdovQCIzbNK8fq9iDClvdZuHGqHk?=
 =?us-ascii?Q?DFb8CN5zX3Rq7lcdQChLny4EL8KWpDhlks5xTOsOiZfFpBhtweRALLgRqDN/?=
 =?us-ascii?Q?zjpfmu8xg7PFh+Um1xk/6OD2nVE0z3U6wvgb8KESwZmUJv8TjPRE0KkO1VwB?=
 =?us-ascii?Q?o5iDmCL5FVZbuLkXNH82PkD3F+P2wTSbjAFsJuSa3Ah91CgV10jKvFNwWnCN?=
 =?us-ascii?Q?jcpdkzeqzwVMw0bbCi7kryowLppLEcRO0leTRz+ks4Z1fjaaZgN7c/SiwwvJ?=
 =?us-ascii?Q?vwHigOMvaddZum3zkhqJgpq25L1KJ2JORv7pOuhtMlreEgBNhTaJVe9UI/pF?=
 =?us-ascii?Q?OPUrGAYqVCzD+piOX+hM9qsriukV06aNs12il7aIOwCxj0XKennhNlYl+x83?=
 =?us-ascii?Q?A/KPlM5tB6ijzlNH1hZO50lwmMHWzRU4oA5Ael64U1lJWmSX3t8kotEV6j6w?=
 =?us-ascii?Q?5+GiZQa9zGLjfT30Zds5uM7o5FKYhq6gt44k6AXl5X1RfbS+gBPbFhAmYGgT?=
 =?us-ascii?Q?TqNrPQb8Io8156fE3wjCSFeSMJcBq41AMWN+UlP8u6YCP1gKjaC4s9G8N2Zo?=
 =?us-ascii?Q?40K+7nh8fhZci1nSeBJ+wBZJg6OKq1OgOuz5fJS0Dyq5EsHqXVACzHLWYqvu?=
 =?us-ascii?Q?xCQJ9leon9XsYMov6UHNz+UuI38o5nkmc4x5u+oh8u25lh8a3rPXxT+wrpiX?=
 =?us-ascii?Q?n68bmaE7Nndksr2LO0363yX+h73Wv7TNifUdUJEVKOysTdsnUnbfpHK76CCd?=
 =?us-ascii?Q?hMwoiFDbSxsj/zrOTY3aUg7B3inmq143t1DF/+GR/uXUES7YGFOUGzLjHq/Z?=
 =?us-ascii?Q?4acmR26ecq/NwnswE75SCi0EBWiFKNLpFHF5IFjDr6mKJrHsqk1S09lY8lHM?=
 =?us-ascii?Q?p7pGCMPwVQnyYMS2+GmkiROCuC8RBeIxILn6ZtVOY9jpeTXxyNrTWwzexlPQ?=
 =?us-ascii?Q?CZQwAhYjc1AcZHXA4u7gAT2ncFq/tZsXQ5cQSkt2MJ/x6lq/7OgzAzL4OmVJ?=
 =?us-ascii?Q?ZIMrGtGywg=3D=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49f21f38-602f-4e1c-f59e-08da2eef07d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2022 23:28:58.9124 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D0KiT2HvNSmaZgGKcuYLrpjONkEjL/Ye/V2mjxd5xqCYn+N5+VRT7nb0AY2NcbxAsDghe2RKb1/UifRzy+vKnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3656
X-OriginatorOrg: intel.com
Cc: Qian Cai <quic_qiancai@quicinc.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Rodel,
 Jorg" <jroedel@suse.de>, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>
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

> From: Jason Gunthorpe
> Sent: Thursday, May 5, 2022 11:33 PM
> > >  	/*
> > > -	 * If the group has been claimed already, do not re-attach the default
> > > -	 * domain.
> > > +	 * New drivers should support default domains and so the
> > > detach_dev() op
> > > +	 * will never be called. Otherwise the NULL domain indicates the
> > > +	 * translation for the group should be set so it will work with the
> >
> > translation should be 'blocked'?
> 
> No, not blocked.
> 
> > > +	 * platform DMA ops.
> >
> > I didn't get the meaning of the last sentence.
> 
> It is as discussed with Robin, NULL means to return the group back to
> some platform defined translation, and in some cases this means
> returning back to work with the platform's DMA ops - presumably if it
> isn't using the dma api.

This is clearer than the original text.

> 
> > > +	/*
> > > +	 * Changing the domain is done by calling attach on the new domain.
> > > +	 * Drivers should implement this so that DMA is always translated by
> >
> > what does 'this' mean?
> 
> The code below - attach_dev called in a loop for each dev in the group.

Yes.

> 
> > > +	 * either the new, old, or a blocking domain. DMA should never
> >
> > isn't the blocking domain passed in as the new domain?
> 
> Soemtimes. This is a statement about the required
> atomicity. New/old/block are all valid translations during the
> operation. Identity is not.

but new/old/block are not the same type of classifications. A group
has an old domain and a new domain at this transition point, and
both old/new domains have a domain type (dma, unmanged, block,
identity, etc.). Mixing them together only increases confusion here.

> 
> So, I'm going to leave this patch as-is since it has been tested now
> and we need to get the series back into iommu-next ASAP.
> 

Agree. Just hope some improvements on the code comment.

But either way given no more code change:

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
