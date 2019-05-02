Return-Path: <SRS0=NDwq=TC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4E1C43219
	for <iommu@archiver.kernel.org>; Thu,  2 May 2019 10:01:46 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B10692075E
	for <iommu@archiver.kernel.org>; Thu,  2 May 2019 10:01:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B10692075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 699AF304A;
	Thu,  2 May 2019 10:01:46 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 783DB3047
	for <iommu@lists.linux-foundation.org>;
	Thu,  2 May 2019 10:01:12 +0000 (UTC)
X-Greylist: delayed 00:06:12 by SQLgrey-1.7.6
Received: from eu-smtp-delivery-151.mimecast.com
	(eu-smtp-delivery-151.mimecast.com [207.82.80.151])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 9DA298D
	for <iommu@lists.linux-foundation.org>;
	Thu,  2 May 2019 10:01:11 +0000 (UTC)
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
	TLS) by relay.mimecast.com with ESMTP id
	uk-mta-130-Ng2ipl1kM4iX0CK2opXBrA-1; Thu, 02 May 2019 10:54:50 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
	(fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2;
	Thu, 2 May 2019 10:54:50 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
	AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id
	15.00.1347.000; Thu, 2 May 2019 10:54:50 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Srinath Mannam' <srinath.mannam@broadcom.com>, Bjorn Helgaas
	<helgaas@kernel.org>
Subject: RE: [PATCH v4 0/3] PCIe Host request to reserve IOVA
Thread-Topic: [PATCH v4 0/3] PCIe Host request to reserve IOVA
Thread-Index: AQHVADHM3KBPKKWjuUy35ge+uHQL0KZXmYKw
Date: Thu, 2 May 2019 09:54:50 +0000
Message-ID: <7c44526aebb6403890bab8e252c16375@AcuMS.aculab.com>
References: <1555038815-31916-1-git-send-email-srinath.mannam@broadcom.com>
	<20190501113038.GA7961@e121166-lin.cambridge.arm.com>
	<20190501125530.GA15590@google.com>
	<CABe79T5w4hb572KHUhyrwAN7+Xxnz2jF9OGLpfTmAdHuLuO2Fw@mail.gmail.com>
In-Reply-To: <CABe79T5w4hb572KHUhyrwAN7+Xxnz2jF9OGLpfTmAdHuLuO2Fw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: Ng2ipl1kM4iX0CK2opXBrA-1
X-Mimecast-Spam-Score: 0
Cc: "poza@codeaurora.org" <poza@codeaurora.org>, Ray Jui <rjui@broadcom.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190502095450.qBYeShVuK97YThhOxYu_i3IrhEmpV2ip9_QTm7cmgf0@z>

From: Srinath Mannam
> Sent: 01 May 2019 16:23
...
> > > On Fri, Apr 12, 2019 at 08:43:32AM +0530, Srinath Mannam wrote:
> > > > Few SOCs have limitation that their PCIe host can't allow few inbound
> > > > address ranges. Allowed inbound address ranges are listed in dma-ranges
> > > > DT property and this address ranges are required to do IOVA mapping.
> > > > Remaining address ranges have to be reserved in IOVA mapping.

You probably want to fix the english in the first sentence.
The sense is reversed.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
