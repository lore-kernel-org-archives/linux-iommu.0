Return-Path: <SRS0=Ppoz=A4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E47C433F8
	for <iommu@archiver.kernel.org>; Fri, 17 Jul 2020 13:22:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C960B20717
	for <iommu@archiver.kernel.org>; Fri, 17 Jul 2020 13:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="ElP3gj0O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C960B20717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 917FE85691;
	Fri, 17 Jul 2020 13:22:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z9iVJ-Ppt2my; Fri, 17 Jul 2020 13:22:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D18F585580;
	Fri, 17 Jul 2020 13:22:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A1251C07FF;
	Fri, 17 Jul 2020 13:22:29 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 24838C0733
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jul 2020 13:22:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 0CEF120337
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jul 2020 13:22:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZkeJSwZqAAP1 for <iommu@lists.linux-foundation.org>;
 Fri, 17 Jul 2020 13:22:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
 by silver.osuosl.org (Postfix) with ESMTPS id 15A262010C
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jul 2020 13:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
 t=1594992148; x=1626528148;
 h=from:to:cc:date:message-id:references:in-reply-to:
 reply-to:content-id:mime-version:
 content-transfer-encoding:subject;
 bh=BgO2flyjBzkE8GNIF6LpHvlW1izso6zkwI4gdBoH/6k=;
 b=ElP3gj0OB+bNxUNmEatHSZDHATlRmkfvAdMA0Q4cBzBK6l2rKH34Wefz
 fuTx05l1BzG0esOOj58mzKcmNCZ5zhAnZ4EXeFxwVNCApqFmGq8B81MWj
 PO7Uf+9jS/SFquMXRI7OeUsZ19KXRtr2xbfcVh/bxYuDFRZNxhGjcCkVG Y=;
IronPort-SDR: TT+XEaDoeqwPEBoe7P3REWy5+sCE2Bd1XWLbrYwTeYtfuyYuu+aqV1RP/QmVz3S3JgKAMrmjFQ
 XsS77s8a9bpg==
X-IronPort-AV: E=Sophos;i="5.75,362,1589241600"; d="scan'208";a="43901011"
Subject: Re: [PATCH v2 0/3] iommu/amd: I/O VA address limits
Thread-Topic: [PATCH v2 0/3] iommu/amd: I/O VA address limits
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 email-inbound-relay-1e-c7c08562.us-east-1.amazon.com) ([10.43.8.6])
 by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP;
 17 Jul 2020 13:22:26 +0000
Received: from EX13MTAUWC001.ant.amazon.com
 (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
 by email-inbound-relay-1e-c7c08562.us-east-1.amazon.com (Postfix) with ESMTPS
 id BF6FB243822; Fri, 17 Jul 2020 13:22:24 +0000 (UTC)
Received: from EX13D29UWC003.ant.amazon.com (10.43.162.80) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 17 Jul 2020 13:22:23 +0000
Received: from EX13D02EUC001.ant.amazon.com (10.43.164.92) by
 EX13D29UWC003.ant.amazon.com (10.43.162.80) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 17 Jul 2020 13:22:23 +0000
Received: from EX13D02EUC001.ant.amazon.com ([10.43.164.92]) by
 EX13D02EUC001.ant.amazon.com ([10.43.164.92]) with mapi id 15.00.1497.006;
 Fri, 17 Jul 2020 13:22:22 +0000
To: "robin.murphy@arm.com" <robin.murphy@arm.com>, "sebott@amazon.de"
 <sebott@amazon.de>, "joro@8bytes.org" <joro@8bytes.org>
Thread-Index: AQHWXBuXav2u0i93F0iBWeto0xw41akLhkeAgAA8G4A=
Date: Fri, 17 Jul 2020 13:22:21 +0000
Message-ID: <2a04dcca86bdccece6e0109c30fc0262e1bf8829.camel@amazon.de>
References: <20200630093039.GC28824@8bytes.org>
 <20200630224634.319-1-sebott@amazon.de> <20200710123059.GF27672@8bytes.org>
 <751e403f-7095-f761-465b-9e187b423b0b@amazon.de>
 <271d67b2-482e-7a16-8fd7-1f1a6a4bdff2@arm.com>
In-Reply-To: <271d67b2-482e-7a16-8fd7-1f1a6a4bdff2@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.166.33]
Content-ID: <C7D468DC343A33489B74BE90A882F3BB@amazon.com>
MIME-Version: 1.0
Cc: "Serebrin, Benjamin" <serebrin@amazon.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
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
From: "Sironi, Filippo via iommu" <iommu@lists.linux-foundation.org>
Reply-To: "Sironi, Filippo" <sironi@amazon.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Fri, 2020-07-17 at 10:47 +0100, Robin Murphy wrote:
> 
> On 2020-07-17 10:20, Sebastian Ott via iommu wrote:
> > Hello Joerg,
> > 
> > On 2020-07-10 14:31, Joerg Roedel wrote:
> > > On Wed, Jul 01, 2020 at 12:46:31AM +0200, Sebastian Ott wrote:
> > > > The IVRS ACPI table specifies maximum address sizes for I/O
> > > > virtual
> > > > addresses that can be handled by the IOMMUs in the system. Parse
> > > > that
> > > > data from the IVRS header to provide aperture information for
> > > > DMA
> > > > mappings and users of the iommu API.
> > > > 
> > > > Changes for V2:
> > > >   - use limits in iommu_setup_dma_ops()
> > > >   - rebased to current upstream
> > > > 
> > > > Sebastian Ott (3):
> > > >    iommu/amd: Parse supported address sizes from IVRS
> > > >    iommu/amd: Restrict aperture for domains to conform with IVRS
> > > >    iommu/amd: Actually enforce geometry aperture
> > > 
> > > Thanks for the changes. May I ask what the reason for those
> > > changes are?
> > > AFAIK all AMD IOMMU implementations (in hardware) support full
> > > 64bit
> > > address spaces, and the IVRS table might actually be wrong,
> > > limiting the
> > > address space in the worst case to only 32 bit.
> > 
> > It's not the IOMMU, but we've encountered devices that are capable
> > of
> > more than
> > 32- but less than 64- bit IOVA, and there's no way to express that
> > to
> > the IOVA
> > allocator in the PCIe spec. Our solution was to have our platforms
> > express an
> > IVRS entry that says the IOMMU is capable of 48-bit, which these
> > devices
> > can generate.
> > 48 bits is plenty of address space in this generation for the
> > application we have.
> 
> Hmm, for constraints of individual devices, it should really be their
> drivers' job to call dma_set_mask*() with the appropriate value in the
> first place rather than just assuming that 64 means anything >32. If
> it's a case where the device itself technically is 64-bit capable, but
> an upstream bridge is constraining it, then that limit can also be
> described either by dedicated firmware properties (e.g. ACPI _DMA) or
> with a quirk like via_no_dac().
> 
> Robin.

You cannot rely on the device driver only because the device driver
attach might be a generic one like vfio-pci, for instance, that doesn't
have any device specific knowledge.

Filippo





Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
