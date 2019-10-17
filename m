Return-Path: <SRS0=zJQD=YK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECECECE599
	for <iommu@archiver.kernel.org>; Thu, 17 Oct 2019 02:34:12 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D617021925
	for <iommu@archiver.kernel.org>; Thu, 17 Oct 2019 02:34:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D617021925
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 707BFB59;
	Thu, 17 Oct 2019 02:34:11 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id EECB3ACC;
	Thu, 17 Oct 2019 02:34:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A388713A;
	Thu, 17 Oct 2019 02:34:09 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ED16410DCC97;
	Thu, 17 Oct 2019 02:34:07 +0000 (UTC)
Received: from [10.72.12.185] (ovpn-12-185.pek2.redhat.com [10.72.12.185])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 138295D9DC;
	Thu, 17 Oct 2019 02:34:00 +0000 (UTC)
Subject: Re: [PATCH 2/2] virtio_ring: Use DMA API if memory is encrypted
To: Christoph Hellwig <hch@lst.de>, Ram Pai <linuxram@us.ibm.com>
References: <1570843519-8696-1-git-send-email-linuxram@us.ibm.com>
	<1570843519-8696-2-git-send-email-linuxram@us.ibm.com>
	<1570843519-8696-3-git-send-email-linuxram@us.ibm.com>
	<20191015073501.GA32345@lst.de>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <398dce4b-9290-0b14-28b1-e521331ec309@redhat.com>
Date: Thu, 17 Oct 2019 10:33:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191015073501.GA32345@lst.de>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
	(mx1.redhat.com [10.5.110.64]);
	Thu, 17 Oct 2019 02:34:08 +0000 (UTC)
Cc: andmike@us.ibm.com, sukadev@linux.vnet.ibm.com, mdroth@linux.vnet.ibm.com,
	b.zolnierkie@samsung.com, benh@kernel.crashing.org,
	aik@linux.ibm.com, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, paulus@ozlabs.org,
	iommu@lists.linux-foundation.org, paul.burton@mips.com,
	mpe@ellerman.id.au, robin.murphy@arm.com,
	linuxppc-dev@lists.ozlabs.org, david@gibson.dropbear.id.au
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Ck9uIDIwMTkvMTAvMTUg5LiL5Y2IMzozNSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4gT24g
RnJpLCBPY3QgMTEsIDIwMTkgYXQgMDY6MjU6MTlQTSAtMDcwMCwgUmFtIFBhaSB3cm90ZToKPj4g
RnJvbTogVGhpYWdvIEp1bmcgQmF1ZXJtYW5uIDxiYXVlcm1hbkBsaW51eC5pYm0uY29tPgo+Pgo+
PiBOb3JtYWxseSwgdmlydGlvIGVuYWJsZXMgRE1BIEFQSSB3aXRoIFZJUlRJT19GX0lPTU1VX1BM
QVRGT1JNLCB3aGljaCBtdXN0Cj4+IGJlIHNldCBieSBib3RoIGRldmljZSBhbmQgZ3Vlc3QgZHJp
dmVyLiBIb3dldmVyLCBhcyBhIGhhY2ssIHdoZW4gRE1BIEFQSQo+PiByZXR1cm5zIHBoeXNpY2Fs
IGFkZHJlc3NlcywgZ3Vlc3QgZHJpdmVyIGNhbiB1c2UgdGhlIERNQSBBUEk7IGV2ZW4gdGhvdWdo
Cj4+IGRldmljZSBkb2VzIG5vdCBzZXQgVklSVElPX0ZfSU9NTVVfUExBVEZPUk0gYW5kIGp1c3Qg
dXNlcyBwaHlzaWNhbAo+PiBhZGRyZXNzZXMuCj4gU29ycnksIGJ1dCB0aGlzIGlzIGEgY29tcGxl
dGUgYnVsbHNoaXQgaGFjay4gIERyaXZlciBtdXN0IGFsd2F5cyB1c2UKPiB0aGUgRE1BIEFQSSBp
ZiB0aGV5IGRvIERNQSwgYW5kIGlmIHZpcnRpbyBkZXZpY2VzIHVzZSBwaHlzaWNhbCBhZGRyZXNz
ZXMKPiB0aGF0IG5lZWRzIHRvIGJlIHJldHVybmVkIHRocm91Z2ggdGhlIHBsYXRmb3JtIGZpcm13
YXJlIGludGVyZmFjZXMgZm9yCj4gdGhlIGRtYSBzZXR1cC4gIElmIHlvdSBkb24ndCBkbyB0aGF0
IHlldCAod2hpY2ggYmFzZWQgb24gcHJldmlvdXMKPiBpbmZvcm1hdGlvbnMgeW91IGRvbid0KSwg
eW91IG5lZWQgdG8gZml4IGl0LCBhbmQgd2UgY2FuIHRoZW4gcXVpcmsKPiBvbGQgaW1wbGVtZW50
YXRpb25zIHRoYXQgYWxyZWFkeSBhcmUgb3V0IGluIHRoZSBmaWVsZC4KPgo+IEluIG90aGVyIHdv
cmRzOiB3ZSBmaW5hbGx5IG5lZWQgdG8gZml4IHRoYXQgdmlydGlvIG1lc3MgYW5kIG5vdCBwaWxl
Cj4gaGFja3Mgb24gdG9wIG9mIGhhY2tzLgoKCkkgYWdyZWUsIHRoZSBvbmx5IHJlYXNvbiBmb3Ig
SU9NTVVfUExBVEZPUk0gaXMgdG8gbWFrZSBzdXJlIGd1ZXN0IHdvcmtzIApmb3Igc29tZSBvbGQg
YW5kIGJ1Z2d5IHFlbXUgd2hlbiB2SU9NTVUgaXMgZW5hYmxlZCB3aGljaCBzZWVtcyB1c2VsZXNz
IAoobm90ZSB3ZSBkb24ndCBldmVuIHN1cHBvcnQgdklPTU1VIG1pZ3JhdGlvbiBpbiB0aGF0IGNh
c2UpLgoKVGhhbmtzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
