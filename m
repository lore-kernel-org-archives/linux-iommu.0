Return-Path: <SRS0=/T8B=3Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E92C2D0B1
	for <iommu@archiver.kernel.org>; Tue,  4 Feb 2020 09:56:45 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF5C421582
	for <iommu@archiver.kernel.org>; Tue,  4 Feb 2020 09:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="P60K4t5g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF5C421582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id AA4458471C;
	Tue,  4 Feb 2020 09:56:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3TRchqZJRBW0; Tue,  4 Feb 2020 09:56:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 358F984718;
	Tue,  4 Feb 2020 09:56:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2936DC1D81;
	Tue,  4 Feb 2020 09:56:44 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE4A8C0174
 for <iommu@lists.linux-foundation.org>; Tue,  4 Feb 2020 09:56:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B046E8471C
 for <iommu@lists.linux-foundation.org>; Tue,  4 Feb 2020 09:56:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xwBZAX+RMCPi for <iommu@lists.linux-foundation.org>;
 Tue,  4 Feb 2020 09:56:40 +0000 (UTC)
X-Greylist: delayed 00:23:10 by SQLgrey-1.7.6
Received: from mail-yw1-f65.google.com (mail-yw1-f65.google.com
 [209.85.161.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id DAD0D84718
 for <iommu@lists.linux-foundation.org>; Tue,  4 Feb 2020 09:56:39 +0000 (UTC)
Received: by mail-yw1-f65.google.com with SMTP id t141so17007450ywc.11
 for <iommu@lists.linux-foundation.org>; Tue, 04 Feb 2020 01:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=endlessm-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=/LrB1QQcfXPxi0BB+lcewM64zrtrSOEYAcITFbKQ4wI=;
 b=P60K4t5ggLQr/vhZHiXRlNywK69iPHwx590eFL3PWBdM4grhTUdcJtIzcoDprLCWT5
 7m0n41QNkC8//4JfksLTz3YdQUVxEAGSDuZ9j+W1a0nr+VT86k3WY6fHx1FvGidLTTLy
 +w3Et4GwWqW1Y/UOb4tyjt07vAISYdOcsP/ZwOg1V/KnnyOAF5auYXjo5JGMn7+72ZuG
 KOS57j5QABVOvSR/VaJ+0zijMitZCtAji/0qGDGkhMome9LKH3rlcKGXQN1d+0fDdjdr
 11d7hpEYBvM/Pc5HMA4mbzRQuC7Z5V/iFUQep1upy5JLQZhZKX4GTwvjnL9DG9LiIf3K
 gI/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=/LrB1QQcfXPxi0BB+lcewM64zrtrSOEYAcITFbKQ4wI=;
 b=b8/xUuLMA0C2NCuq4a1jeMVxpjkQtXvEBrfBb/+B54RcbY9opbS+pmxEeCy57eLCQt
 S/YyaNt5XROFq6H0WkTBtJf0nQzFC2tFg9mmBqTi2lLh5YsnkRNS3uvEMma8pweC2++l
 Od+oGeOY6oJQZGEv88Ih0cywYk7F07AowYoYOFnjV4oSEIzaYg175FzqYKwrWkED5hg2
 li4Zufkpep/UjG1D7mf4jLin/Fj9JdvP2/SFHdSTVEB+vGphKdHOTGdb4nXAyz1DHzfy
 FkzYeg2N0XVnRTMiSrBQiDf2miFtpoBO92HCphegAGAXuphH5/ZzzYJRlos12PVpdDZi
 ewAg==
X-Gm-Message-State: APjAAAXVSPIgv1T0ubKfYN8KfGaZWshPhEbm2pPkYvVL6Mr+vRY7H3IQ
 Pkm4xVz+FlVIV/0r5JVwEJYRxyS/LeSLPdn62U8BZFCr2qB8IQ==
X-Google-Smtp-Source: APXvYqwgmuBZwg5kpKbNPQPbL9DX7UGf6nqnhW6qNJ300wkY5DIL2j8Eyl5WkLN8NrTTLujLR9GHxiRbWohjJDze1KI=
X-Received: by 2002:ab0:2a0c:: with SMTP id o12mr16324286uar.72.1580808347038; 
 Tue, 04 Feb 2020 01:25:47 -0800 (PST)
MIME-Version: 1.0
References: <20200203091009.196658-1-jian-hong@endlessm.com>
 <aab0948d-c6a3-baa1-7343-f18c936d662d@linux.intel.com>
In-Reply-To: <aab0948d-c6a3-baa1-7343-f18c936d662d@linux.intel.com>
From: Jian-Hong Pan <jian-hong@endlessm.com>
Date: Tue, 4 Feb 2020 17:25:04 +0800
Message-ID: <CAPpJ_edkkWm0DYHB3U8nQPv=z_o-aV4V7RDMuLTXL5N1H6ZYrA@mail.gmail.com>
Subject: Re: [PATCH] iommu/intel-iommu: set as DUMMY_DEVICE_DOMAIN_INFO if no
 IOMMU
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Linux Upstreaming Team <linux@endlessm.com>,
 David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org,
 Linux Kernel <linux-kernel@vger.kernel.org>
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

THUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4g5pa8IDIwMjDlubQy5pyINOaXpSDp
gLHkuowg5LiL5Y2IMjoxMeWvq+mBk++8mgo+Cj4gSGksCj4KPiBPbiAyMDIwLzIvMyAxNzoxMCwg
Smlhbi1Ib25nIFBhbiB3cm90ZToKPiA+IElmIHRoZSBkZXZpY2UgaGFzIG5vIElPTU1VLCBpdCBz
dGlsbCBpbnZva2VzIGlvbW11X25lZWRfbWFwcGluZyBkdXJpbmcKPiA+IGludGVsX2FsbG9jX2Nv
aGVyZW50LiBIb3dldmVyLCBpb21tdV9uZWVkX21hcHBpbmcgY2FuIG9ubHkgY2hlY2sgdGhlCj4g
PiBkZXZpY2UgaXMgRFVNTVlfREVWSUNFX0RPTUFJTl9JTkZPIG9yIG5vdC4gVGhpcyBwYXRjaCBt
YXJrcyB0aGUgZGV2aWNlCj4gPiBpcyBhIERVTU1ZX0RFVklDRV9ET01BSU5fSU5GTyBpZiB0aGUg
ZGV2aWNlIGhhcyBubyBJT01NVS4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBKaWFuLUhvbmcgUGFu
IDxqaWFuLWhvbmdAZW5kbGVzc20uY29tPgo+ID4gLS0tCj4gPiAgIGRyaXZlcnMvaW9tbXUvaW50
ZWwtaW9tbXUuYyB8IDQgKysrLQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pCj4gPgo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW50ZWwt
aW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwtaW9tbXUuYwo+ID4gaW5kZXggMzVhNGEzYWJl
ZGM2Li44NzhiYzk4NmEwMTUgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL2lvbW11L2ludGVsLWlv
bW11LmMKPiA+ICsrKyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwtaW9tbXUuYwo+ID4gQEAgLTU2MTIs
OCArNTYxMiwxMCBAQCBzdGF0aWMgaW50IGludGVsX2lvbW11X2FkZF9kZXZpY2Uoc3RydWN0IGRl
dmljZSAqZGV2KQo+ID4gICAgICAgaW50IHJldDsKPiA+Cj4gPiAgICAgICBpb21tdSA9IGRldmlj
ZV90b19pb21tdShkZXYsICZidXMsICZkZXZmbik7Cj4gPiAtICAgICBpZiAoIWlvbW11KQo+ID4g
KyAgICAgaWYgKCFpb21tdSkgewo+ID4gKyAgICAgICAgICAgICBkZXYtPmFyY2hkYXRhLmlvbW11
ID0gRFVNTVlfREVWSUNFX0RPTUFJTl9JTkZPOwo+Cj4gSXMgdGhpcyBhIERNQSBjYXBhYmxlIGRl
dmljZT8KCkRvIHlvdSBtZWFuIGlzIHRoZSBkZXZpY2UgaW4gRE1BIFJlbWFwcGluZyB0YWJsZT8K
RHVtcCBETUFSIGZyb20gQUNQSSB0YWJsZS4gIFRoZSBkZXZpY2UgaXMgbm90IGluIHRoZSB0YWJs
ZS4KU28sIGl0IGRvZXMgbm90IHN1cHBvcnQgRE1BUiwgSW50ZWwgSU9NTVUuCgpPciwgc2hvdWxk
IGRldmljZV90b19pb21tdSBiZSBpbnZva2VkIGluIGlvbW11X25lZWRfbWFwcGluZyB0byBjaGVj
awpJT01NVSBmZWF0dXJlIGFnYWluPwoKQmVzdCByZWdhcmRzLApKaWFuLUhvbmcgUGFuCgo+IEkg
YW0gYWZyYWlkIHNvbWUgcmVhbCBidWdzIG1pZ2h0IGJlCj4gY292ZXJlZCB1cCBpZiB3ZSBtYXJr
aW5nIHRoZSBkZXZpY2UgYXMgSU9NTVUgZHVtbXkgaGVyZS4KPgo+IEJlc3QgcmVnYXJkcywKPiBi
YW9sdQo+Cj4gPiAgICAgICAgICAgICAgIHJldHVybiAtRU5PREVWOwo+ID4gKyAgICAgfQo+ID4K
PiA+ICAgICAgIGlvbW11X2RldmljZV9saW5rKCZpb21tdS0+aW9tbXUsIGRldik7Cj4gPgo+ID4K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFp
bGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
