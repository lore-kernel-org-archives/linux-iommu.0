Return-Path: <SRS0=03l9=BB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1CBC433E0
	for <iommu@archiver.kernel.org>; Wed, 22 Jul 2020 12:35:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58E872065D
	for <iommu@archiver.kernel.org>; Wed, 22 Jul 2020 12:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="AJceUhmx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58E872065D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1F47187FF7;
	Wed, 22 Jul 2020 12:35:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oPoEEhYM1I2i; Wed, 22 Jul 2020 12:35:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id EEC8087FCF;
	Wed, 22 Jul 2020 12:35:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DF75FC004E;
	Wed, 22 Jul 2020 12:35:17 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B921C004C
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jul 2020 12:35:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 7218420481
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jul 2020 12:35:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IUWGiBmkSTjl for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jul 2020 12:35:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com
 [207.171.190.10])
 by silver.osuosl.org (Postfix) with ESMTPS id 8FFDE203BA
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jul 2020 12:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
 t=1595421316; x=1626957316;
 h=from:to:cc:date:message-id:references:in-reply-to:
 reply-to:content-id:mime-version:
 content-transfer-encoding:subject;
 bh=Z03UXcQUVvrE2eJoxhiCxRP+QF+/R7+vXwyxgaq6uEg=;
 b=AJceUhmxqsx4b7AAY5uFAPcQ+OXPc9t0W4wAKZEMSxatLHAWN2vOp8pJ
 hHqUDdPe3QniaC2zjdNkmVUXNXFHNj/IIhxw3ipK9nwpvvQmfQ2WB378w
 P49aWzysAH8ntvlmEr2qHu8QRIcgpKZvYKgYoqvWp3uQfuVpE+tUZL7K1 8=;
IronPort-SDR: HwDcmI5L0gx2CzFCQCtJrZPPEu0dnEY5yDpnnSI6oR46SnMCO/ePbsa0EN2AmxyQYAbs87hLMl
 uargoRou8org==
X-IronPort-AV: E=Sophos;i="5.75,381,1589241600"; d="scan'208";a="60677145"
Subject: Re: [PATCH v2 0/3] iommu/amd: I/O VA address limits
Thread-Topic: [PATCH v2 0/3] iommu/amd: I/O VA address limits
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO
 email-inbound-relay-1e-c7c08562.us-east-1.amazon.com) ([10.47.23.38])
 by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP;
 22 Jul 2020 12:35:02 +0000
Received: from EX13MTAUWA001.ant.amazon.com
 (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
 by email-inbound-relay-1e-c7c08562.us-east-1.amazon.com (Postfix) with ESMTPS
 id 6EEC4241805; Wed, 22 Jul 2020 12:35:00 +0000 (UTC)
Received: from EX13D29UWA003.ant.amazon.com (10.43.160.253) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 22 Jul 2020 12:34:59 +0000
Received: from EX13D02EUC001.ant.amazon.com (10.43.164.92) by
 EX13D29UWA003.ant.amazon.com (10.43.160.253) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 22 Jul 2020 12:34:58 +0000
Received: from EX13D02EUC001.ant.amazon.com ([10.43.164.92]) by
 EX13D02EUC001.ant.amazon.com ([10.43.164.92]) with mapi id 15.00.1497.006;
 Wed, 22 Jul 2020 12:34:57 +0000
To: "joro@8bytes.org" <joro@8bytes.org>
Thread-Index: AQHWXBuXav2u0i93F0iBWeto0xw41akLhkeAgAA8G4CAABTYgIAACtQAgAeqZACAAARZAA==
Date: Wed, 22 Jul 2020 12:34:57 +0000
Message-ID: <88c26491f2e429380028e9c04755965bc3f0341a.camel@amazon.de>
References: <20200630093039.GC28824@8bytes.org>
 <20200630224634.319-1-sebott@amazon.de> <20200710123059.GF27672@8bytes.org>
 <751e403f-7095-f761-465b-9e187b423b0b@amazon.de>
 <271d67b2-482e-7a16-8fd7-1f1a6a4bdff2@arm.com>
 <2a04dcca86bdccece6e0109c30fc0262e1bf8829.camel@amazon.de>
 <004a060f-823d-af4e-a34d-1ff029faa40f@arm.com>
 <715c45b76f49b732e5f20157945d2ae262654602.camel@amazon.de>
 <20200722121922.GY27672@8bytes.org>
In-Reply-To: <20200722121922.GY27672@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.166.118]
Content-ID: <AA0F01C48BA5344486432F7216457794@amazon.com>
MIME-Version: 1.0
Cc: "Serebrin, Benjamin" <serebrin@amazon.com>,
 "sebott@amazon.de" <sebott@amazon.de>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
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

On Wed, 2020-07-22 at 14:19 +0200, joro@8bytes.org wrote:
> 
> On Fri, Jul 17, 2020 at 03:15:43PM +0000, Sironi, Filippo wrote:
> > I don't believe that we want to trust a userspace driver here, this
> > may
> > result in hosts becoming unstable because devices are asked to do
> > things
> > they aren't meant to do (e.g., DMA beyond 48 bits).
> 
> How is the hosts stability affected when a device is programmed with
> handles outside of its DMA mask?

I wouldn't be surprised if a PCIe device raises a PCIe SERR if it is
asked to do DMA beyond its abilities.

> Anyway, someone needs to know how to use the device in the end, and
> this
> entity also needs to know the DMA mask of the device and pass it down
> to
> path to the dma-iommu code.
> 
> Regards,
> 
>         Joerg

I agree, device drivers should do the right thing and if we have generic
device drivers they may need "quirks" based on VID:DID to do the right
thing.

Still, I believe that the VFIO case is special because the device driver
is effectively in userspace I really think that trusting userspace isn't
quite correct (and we can keep discussing on this front).

I think that this discussion is orthogonal wrt the spirit of the
patches. They are actually adding a few bits to the AMD IOMMU driver
(and propagating them to the right places) to implement a portion of the
specification that wasn't implemented, i.e., relying on the IVRS table.
These patches are valuable independently on the content of the IVRS
table, be it 32, 48, or 64 bits.

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
