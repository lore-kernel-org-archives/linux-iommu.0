Return-Path: <SRS0=ODk1=W2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BA4C3A59B
	for <iommu@archiver.kernel.org>; Fri, 30 Aug 2019 13:47:40 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E2C422CE9
	for <iommu@archiver.kernel.org>; Fri, 30 Aug 2019 13:47:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E2C422CE9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 33B78615E;
	Fri, 30 Aug 2019 13:47:40 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 94D906130
	for <iommu@lists.linux-foundation.org>;
	Fri, 30 Aug 2019 13:46:09 +0000 (UTC)
X-Greylist: delayed 00:06:13 by SQLgrey-1.7.6
Received: from eu-smtp-delivery-151.mimecast.com
	(eu-smtp-delivery-151.mimecast.com [207.82.80.151])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 172767DB
	for <iommu@lists.linux-foundation.org>;
	Fri, 30 Aug 2019 13:46:07 +0000 (UTC)
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
	TLS) by relay.mimecast.com with ESMTP id
	uk-mta-210-F1QPlVPsMbqytrDM-jSL6w-1; Fri, 30 Aug 2019 14:39:52 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
	AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft
	SMTP Server (TLS) id 15.0.1347.2; Fri, 30 Aug 2019 14:39:51 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
	AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id
	15.00.1347.000; Fri, 30 Aug 2019 14:39:51 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Lu Baolu' <baolu.lu@linux.intel.com>, David Woodhouse
	<dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>
Subject: RE: [PATCH v8 7/7] iommu/vt-d: Use bounce buffer for untrusted devices
Thread-Topic: [PATCH v8 7/7] iommu/vt-d: Use bounce buffer for untrusted
	devices
Thread-Index: AQHVXwNAt0TkSHwjwEWfpppIl7udg6cTsWfA
Date: Fri, 30 Aug 2019 13:39:51 +0000
Message-ID: <4dee1bcef8474ebb95a7826a58bb72aa@AcuMS.aculab.com>
References: <20190830071718.16613-1-baolu.lu@linux.intel.com>
	<20190830071718.16613-8-baolu.lu@linux.intel.com>
In-Reply-To: <20190830071718.16613-8-baolu.lu@linux.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: F1QPlVPsMbqytrDM-jSL6w-1
X-Mimecast-Spam-Score: 0
Cc: Juergen Gross <jgross@suse.com>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	"ashok.raj@intel.com" <ashok.raj@intel.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	"alan.cox@intel.com" <alan.cox@intel.com>,
	Jonathan Corbet <corbet@lwn.net>, Robin
	Murphy <robin.murphy@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"pengfei.xu@intel.com" <pengfei.xu@intel.com>, Ingo
	Molnar <mingo@redhat.com>,
	"jacob.jun.pan@intel.com" <jacob.jun.pan@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Boris
	Ostrovsky <boris.ostrovsky@oracle.com>,
	"mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

From: Lu Baolu
> Sent: 30 August 2019 08:17

> The Intel VT-d hardware uses paging for DMA remapping.
> The minimum mapped window is a page size. The device
> drivers may map buffers not filling the whole IOMMU
> window. This allows the device to access to possibly
> unrelated memory and a malicious device could exploit
> this to perform DMA attacks. To address this, the
> Intel IOMMU driver will use bounce pages for those
> buffers which don't fill whole IOMMU pages.

Won't this completely kill performance?

I'd expect to see something for dma_alloc_coherent() (etc)
that tries to give the driver page sized buffers.

Either that or the driver could allocate page sized buffers
even though it only passes fragments of these buffers to
the dma functions (to avoid excessive cache invalidates).

Since you have to trust the driver, why not actually trust it?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
