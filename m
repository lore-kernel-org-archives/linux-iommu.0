Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01FFFC43217
	for <iommu@archiver.kernel.org>; Mon, 14 Feb 2022 13:58:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8C59A4015E;
	Mon, 14 Feb 2022 13:58:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lVETn8D4IpGN; Mon, 14 Feb 2022 13:58:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1B316400A4;
	Mon, 14 Feb 2022 13:58:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EA4BBC001A;
	Mon, 14 Feb 2022 13:58:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7026EC000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 13:58:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 41D5360655
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 13:58:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9lC1V8EbzVhh for <iommu@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 13:58:41 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9790F60030
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 13:58:41 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id C2B0468BEB; Mon, 14 Feb 2022 14:58:34 +0100 (CET)
Date: Mon, 14 Feb 2022 14:58:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: Tianyu Lan <ltykernel@gmail.com>
Subject: Re: [PATCH V2 1/2] Swiotlb: Add swiotlb_alloc_from_low_pages switch
Message-ID: <20220214135834.GA30150@lst.de>
References: <20220209122302.213882-1-ltykernel@gmail.com>
 <20220209122302.213882-2-ltykernel@gmail.com> <20220214081919.GA18337@lst.de>
 <4f433f07-05be-f81f-43e8-55c3f1af23b3@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4f433f07-05be-f81f-43e8-55c3f1af23b3@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 dave.hansen@linux.intel.com, hpa@zytor.com, kys@microsoft.com,
 Christoph Hellwig <hch@lst.de>, hch@infradead.org, wei.liu@kernel.org,
 sthemmin@microsoft.com, x86@kernel.org, decui@microsoft.com,
 michael.h.kelley@microsoft.com, mingo@redhat.com, parri.andrea@gmail.com,
 thomas.lendacky@amd.com, Tianyu Lan <Tianyu.Lan@microsoft.com>,
 konrad.wilk@oracle.com, haiyangz@microsoft.com, bp@alien8.de,
 tglx@linutronix.de, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, vkuznets@redhat.com, robin.murphy@arm.com
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

T24gTW9uLCBGZWIgMTQsIDIwMjIgYXQgMDc6Mjg6NDBQTSArMDgwMCwgVGlhbnl1IExhbiB3cm90
ZToKPiBPbiAyLzE0LzIwMjIgNDoxOSBQTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4+IEFk
ZGluZyBhIGZ1bmN0aW9uIHRvIHNldCB0aGUgZmxhZyBkb2Vzbid0IHJlYWxseSBjaGFuZ2UgbXVj
aC4gIEFzIFJvYmluCj4+IHBvaW50ZWQgb3V0IGxhc3QgdGltZSB5b3Ugc2hvdWxkIGZpbmUgYSB3
YXkgdG8ganVzdCBjYWxsCj4+IHN3aW90bGJfaW5pdF93aXRoX3RibCBkaXJlY3RseSB3aXRoIHRo
ZSBtZW1vcnkgYWxsb2NhdGVkIHRoZSB3YXkgeW91Cj4+IGxpa2UgaXQuICBPciBnaXZlbiB0aGF0
IHdlIGhhdmUgcXVpdGUgYSBmZXcgb2YgdGhlc2UgdHJ1c3RlZCBoeXBlcnZpc29yCj4+IHNjaGVt
ZXMgbWF5YmUgYWRkIGFuIGFyZ3VtZW50IHRvIHN3aW90bGJfaW5pdCB0aGF0IHNwZWNpZmllcyBo
b3cgdG8KPj4gYWxsb2NhdGUgdGhlIG1lbW9yeS4KPgo+IFRoYW5rcyBmb3IgeW91ciBzdWdnZXN0
aW9uLiBJIHdpbGwgdHJ5IHRoZSBmaXJzdCBhcHByb2FjaCBmaXJzdCBhcHByb2FjaC4KClRha2Ug
YSBsb29rIGF0IHRoZSBTV0lPVExCX0FOWSBmbGFnIGluIHRoaXMgV0lQIGJyYW5jaDoKCiAgIGh0
dHA6Ly9naXQuaW5mcmFkZWFkLm9yZy91c2Vycy9oY2gvbWlzYy5naXQvc2hvcnRsb2cvcmVmcy9o
ZWFkcy9zd2lvdGxiLWluaXQtY2xlYW51cAoKVGhhdCBiZWluZyBzYWlkIEknbSBub3Qgc3VyZSB0
aGF0IGVpdGhlciB0aGlzIGZsYWcgb3IgdGhlIGV4aXN0aW5nIHBvd2VycGMKY29kZSBp0ZUgYWN0
dWFsbHkgdGhlIHJpZ2h0IHRoaW5nIHRvIGRvLiAgV2Ugc3RpbGwgbmVlZCB0aGUgNEcgbGltaXRl
ZApidWZmZXIgdG8gc3VwcG9ydCBkZXZpY2VzIHdpdGggYWRkcmVzc2luZyBsaW1pdGF0aW9ucy4g
IFNvIEkgdGhpbmsgd2UgbmVlZAphbiBhZGRpdGlvbmFsIGlvX3RsYl9tZW0gaW5zdGFuY2UgZm9y
IHRoZSBkZXZpY2VzIHdpdGhvdXQgYWRkcmVzc2luZwpsaW1pdGF0aW9ucyBpbnN0ZWFkLgoKCQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWls
aW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
