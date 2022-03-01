Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0751C433F5
	for <iommu@archiver.kernel.org>; Tue,  1 Mar 2022 11:43:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 811488128C;
	Tue,  1 Mar 2022 11:43:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N0c3zdKOGvgU; Tue,  1 Mar 2022 11:43:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 76DFF81289;
	Tue,  1 Mar 2022 11:43:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 58392C0077;
	Tue,  1 Mar 2022 11:43:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55E17C001A
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 11:43:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 410ED414E2
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 11:43:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mHYvM0m5uswu for <iommu@lists.linux-foundation.org>;
 Tue,  1 Mar 2022 11:43:41 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 607D34034D
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 11:43:41 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 5C51F68AFE; Tue,  1 Mar 2022 12:43:35 +0100 (CET)
Date: Tue, 1 Mar 2022 12:43:35 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andrew Cooper <Andrew.Cooper3@citrix.com>
Subject: Re: [PATCH 08/12] x86: centralize setting SWIOTLB_FORCE when guest
 memory encryption is enabled
Message-ID: <20220301114335.GA2881@lst.de>
References: <20220301105311.885699-1-hch@lst.de>
 <20220301105311.885699-9-hch@lst.de>
 <8e623a11-d809-4fab-401c-2ce609a9fc14@citrix.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8e623a11-d809-4fab-401c-2ce609a9fc14@citrix.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 "tboot-devel@lists.sourceforge.net" <tboot-devel@lists.sourceforge.net>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 David Woodhouse <dwmw2@infradead.org>, Tom Lendacky <thomas.lendacky@amd.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Juergen Gross <jgross@suse.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gVHVlLCBNYXIgMDEsIDIwMjIgYXQgMTE6Mzk6MjlBTSArMDAwMCwgQW5kcmV3IENvb3BlciB3
cm90ZToKPiBUaGlzIGlzbid0IHJlYWxseSAibXVzdCIuwqAgVGhlIGd1ZXN0IGlzIHBlcmZlY3Rs
eSBjYXBhYmxlIG9mIHNoYXJpbmcKPiBtZW1vcnkgd2l0aCB0aGUgaHlwZXJ2aXNvci4KPiAKPiBJ
dCdzIGp1c3QgdGhhdCBmb3Igbm93LCBib3VuY2UgYnVmZmVyaW5nIGlzIGFsbGVnZWRseSBmYXN0
ZXIsIGFuZCB0aGUKPiBzaW1wbGUgd2F5IG9mIGdldHRpbmcgaXQgd29ya2luZy4KClllYWgsIEkg
Z3Vlc3MgeW91INGJb3VsZCBqdXN0IHNoYXJlL3Vuc2hhcmUgb24gZGVtYW5kLiAgQnV0IGdpdmVu
IHRoYXQKdGhpcyBpc24ndCBpbXBsZW1lbnRlZCBpdCBpcyBhIG11c3QgaW4gdGhlIGN1cnJlbnQg
a2VybmVsLiAgQnV0IGlmCnlvdSB3YW50IGEgZGlmZmVyZW50IHdvcmRpbmcgc3VnZ2VzdCBvbmUg
YW5kIEknbGwgcHV0IGl0IGluLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
aW9tbXU=
