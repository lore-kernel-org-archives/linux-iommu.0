Return-Path: <SRS0=n6uX=NS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA07C432BE
	for <iommu@archiver.kernel.org>; Fri, 27 Aug 2021 06:59:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F9AF60FC4
	for <iommu@archiver.kernel.org>; Fri, 27 Aug 2021 06:59:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3F9AF60FC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EDBF580C0B;
	Fri, 27 Aug 2021 06:59:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5IPsvB0vPP-3; Fri, 27 Aug 2021 06:59:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C8BDB80B93;
	Fri, 27 Aug 2021 06:59:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8C53FC0010;
	Fri, 27 Aug 2021 06:59:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CAE5DC000E
 for <iommu@lists.linux-foundation.org>; Fri, 27 Aug 2021 06:59:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AC8E04269B
 for <iommu@lists.linux-foundation.org>; Fri, 27 Aug 2021 06:59:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OuaUAYkb4eqw for <iommu@lists.linux-foundation.org>;
 Fri, 27 Aug 2021 06:59:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0CFDA425F9
 for <iommu@lists.linux-foundation.org>; Fri, 27 Aug 2021 06:59:08 +0000 (UTC)
Received: by mail-pj1-x1035.google.com with SMTP id fs6so3891567pjb.4
 for <iommu@lists.linux-foundation.org>; Thu, 26 Aug 2021 23:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Rqn+GrCddwb17438Eb7/acjTBeKWly1ebyK4GCadnFc=;
 b=Ahob/aCaoxGGmBX3uT/2Oo+coR/T1tys8xgPUYlJZHQ+79x1W7tMhNYHihEb3g00Pw
 m+dgL0BLb9DG6XuqQrGIlpqK11vUr+Y2ytYHZ7LdTBFa1tFBJE3STgSjF41FypNGQroh
 EB33JFOQSvpQcvOA/KVG6FqtXl7O0+BT+q4qQg5vtIojCX29E2kJoRY1MRvb3ovAgDbp
 aFXAm0ssP0g7n3TLr2XOHHUaLQbsPjFKeMCjJaff6OnyliY0dDUUm9ACwqxN5BizOny5
 6o6R1k1p3THp4VGKPD1gPgbF9N5SJmHFccehHvyHptaqGZoYeq1bOsTJYfzYeYbXFcTi
 n8+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Rqn+GrCddwb17438Eb7/acjTBeKWly1ebyK4GCadnFc=;
 b=P8qwypAa5pfRjsjLXW6D/zL3tJlXeBOuxvk5zsDB4GPfcNMFcMzISz41BidF7YYKCT
 WHIgpgNmK/1DTvaDzYcXC1f9ea6T1lEQnfX+IAuaPksXgXOG8shDVZe/MzKyneZ8P25C
 XAaGa2qEvF2ybkKa5ao535Ct8GlmoQda96BXNQZqeXjGFYB9vkApjQwVsQvAZwJ3vaEO
 TE6sppzDtYV7Man8fFEBQcsMAW6ve6SvEkAxD4T3L80uerh7xKHiv5RkhZY2+wKL52pX
 cOl/TbrnOt0OBkTqGCm/GUJLpvyblbFZ7J4SKILKFqowRz3vxWJUfQ/t5KTfu9DxS/Ga
 /9IA==
X-Gm-Message-State: AOAM530JVovbqkbRXdB1r94p+iW5Mw1TV9xVNWZle2POB9ujbTEgxmPt
 xtgDLTB4Y6nafRpZ+kCU4ncvvukC01OdOF5Sx6A=
X-Google-Smtp-Source: ABdhPJzbMPfKsiNwRsmJ6wf35o+bM3Vsllxj/xaKs1Zg3gEKi2+LtrBilr6TwQqyx2Jk+YbMtx83ULLwDM5rxvcqh8o=
X-Received: by 2002:a17:902:bb81:b0:12d:a7ec:3d85 with SMTP id
 m1-20020a170902bb8100b0012da7ec3d85mr7349833pls.17.1630047548297; Thu, 26 Aug
 2021 23:59:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210624155526.2775863-1-tientzu@chromium.org>
 <20210624155526.2775863-11-tientzu@chromium.org>
In-Reply-To: <20210624155526.2775863-11-tientzu@chromium.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 27 Aug 2021 09:58:32 +0300
Message-ID: <CAHp75VfVhVGFEQGeUKajrUKmkx_et_KakDDgroC2BrMMhd62yg@mail.gmail.com>
Subject: Re: [PATCH v15 10/12] swiotlb: Add restricted DMA pool initialization
To: Claire Chang <tientzu@chromium.org>
Cc: heikki.krogerus@linux.intel.com, thomas.hellstrom@linux.intel.com,
 peterz@infradead.org, benh@kernel.crashing.org,
 joonas.lahtinen@linux.intel.com, dri-devel@lists.freedesktop.org,
 chris@chris-wilson.co.uk, grant.likely@arm.com, paulus@samba.org,
 Frank Rowand <frowand.list@gmail.com>, mingo@kernel.org,
 sstabellini@kernel.org, Saravana Kannan <saravanak@google.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Christoph Hellwig <hch@lst.de>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, bskeggs@redhat.com,
 linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
 Thierry Reding <treding@nvidia.com>, intel-gfx@lists.freedesktop.org,
 matthew.auld@intel.com, linux-devicetree <devicetree@vger.kernel.org>,
 jxgao@google.com, daniel@ffwll.ch, Will Deacon <will@kernel.org>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 maarten.lankhorst@linux.intel.com, airlied@linux.ie,
 Dan Williams <dan.j.williams@intel.com>, linuxppc-dev@lists.ozlabs.org,
 jani.nikula@linux.intel.com, Rob Herring <robh+dt@kernel.org>,
 rodrigo.vivi@intel.com, bhelgaas@google.com,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Juergen Gross <jgross@suse.com>, Nicolas Boichat <drinkcat@chromium.org>,
 Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 quic_qiancai@quicinc.com, lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Jim Quinlan <james.quinlan@broadcom.com>, xypron.glpk@gmx.de,
 thomas.lendacky@amd.com, Robin Murphy <robin.murphy@arm.com>,
 bauerman@linux.ibm.com
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

T24gVGh1LCBKdW4gMjQsIDIwMjEgYXQgNjo1OSBQTSBDbGFpcmUgQ2hhbmcgPHRpZW50enVAY2hy
b21pdW0ub3JnPiB3cm90ZToKPgo+IEFkZCB0aGUgaW5pdGlhbGl6YXRpb24gZnVuY3Rpb24gdG8g
Y3JlYXRlIHJlc3RyaWN0ZWQgRE1BIHBvb2xzIGZyb20KPiBtYXRjaGluZyByZXNlcnZlZC1tZW1v
cnkgbm9kZXMuCj4KPiBSZWdhcmRsZXNzIG9mIHN3aW90bGIgc2V0dGluZywgdGhlIHJlc3RyaWN0
ZWQgRE1BIHBvb2wgaXMgcHJlZmVycmVkIGlmCj4gYXZhaWxhYmxlLgo+Cj4gVGhlIHJlc3RyaWN0
ZWQgRE1BIHBvb2xzIHByb3ZpZGUgYSBiYXNpYyBsZXZlbCBvZiBwcm90ZWN0aW9uIGFnYWluc3Qg
dGhlCj4gRE1BIG92ZXJ3cml0aW5nIGJ1ZmZlciBjb250ZW50cyBhdCB1bmV4cGVjdGVkIHRpbWVz
LiBIb3dldmVyLCB0byBwcm90ZWN0Cj4gYWdhaW5zdCBnZW5lcmFsIGRhdGEgbGVha2FnZSBhbmQg
c3lzdGVtIG1lbW9yeSBjb3JydXB0aW9uLCB0aGUgc3lzdGVtCj4gbmVlZHMgdG8gcHJvdmlkZSBh
IHdheSB0byBsb2NrIGRvd24gdGhlIG1lbW9yeSBhY2Nlc3MsIGUuZy4sIE1QVS4KCgoKCgo+ICtz
dGF0aWMgaW50IHJtZW1fc3dpb3RsYl9kZXZpY2VfaW5pdChzdHJ1Y3QgcmVzZXJ2ZWRfbWVtICpy
bWVtLAo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBkZXZpY2Ug
KmRldikKPiArewo+ICsgICAgICAgc3RydWN0IGlvX3RsYl9tZW0gKm1lbSA9IHJtZW0tPnByaXY7
Cj4gKyAgICAgICB1bnNpZ25lZCBsb25nIG5zbGFicyA9IHJtZW0tPnNpemUgPj4gSU9fVExCX1NI
SUZUOwo+ICsKPiArICAgICAgIC8qCj4gKyAgICAgICAgKiBTaW5jZSBtdWx0aXBsZSBkZXZpY2Vz
IGNhbiBzaGFyZSB0aGUgc2FtZSBwb29sLCB0aGUgcHJpdmF0ZSBkYXRhLAo+ICsgICAgICAgICog
aW9fdGxiX21lbSBzdHJ1Y3QsIHdpbGwgYmUgaW5pdGlhbGl6ZWQgYnkgdGhlIGZpcnN0IGRldmlj
ZSBhdHRhY2hlZAo+ICsgICAgICAgICogdG8gaXQuCj4gKyAgICAgICAgKi8KCj4gKyAgICAgICBp
ZiAoIW1lbSkgewoKQ2FuIGl0IGJlIHJhdGhlcgoKaWYgKG1lbSkKICBnb3RvIG91dF9hc3NpZ247
CgpvciBzbz8KCj4gKyAgICAgICAgICAgICAgIG1lbSA9IGt6YWxsb2Moc3RydWN0X3NpemUobWVt
LCBzbG90cywgbnNsYWJzKSwgR0ZQX0tFUk5FTCk7Cj4gKyAgICAgICAgICAgICAgIGlmICghbWVt
KQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRU5PTUVNOwo+ICsKPiArICAgICAg
ICAgICAgICAgc2V0X21lbW9yeV9kZWNyeXB0ZWQoKHVuc2lnbmVkIGxvbmcpcGh5c190b192aXJ0
KHJtZW0tPmJhc2UpLAo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBybWVt
LT5zaXplID4+IFBBR0VfU0hJRlQpOwoKQmVsb3cgeW91IGFyZSB1c2luZyBhIG1hY3JvIGZyb20g
cGZuLmgsIGJ1dCBub3QgaGVyZSwgSSB0aGluayBpdCdzIFBGTl9ET1dOKCkuCgo+ICsgICAgICAg
ICAgICAgICBzd2lvdGxiX2luaXRfaW9fdGxiX21lbShtZW0sIHJtZW0tPmJhc2UsIG5zbGFicywg
ZmFsc2UpOwo+ICsgICAgICAgICAgICAgICBtZW0tPmZvcmNlX2JvdW5jZSA9IHRydWU7Cj4gKyAg
ICAgICAgICAgICAgIG1lbS0+Zm9yX2FsbG9jID0gdHJ1ZTsKPiArCj4gKyAgICAgICAgICAgICAg
IHJtZW0tPnByaXYgPSBtZW07Cj4gKwo+ICsgICAgICAgICAgICAgICBpZiAoSVNfRU5BQkxFRChD
T05GSUdfREVCVUdfRlMpKSB7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgbWVtLT5kZWJ1Z2Zz
ID0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRlYnVnZnNfY3JlYXRlX2Rpcihy
bWVtLT5uYW1lLCBkZWJ1Z2ZzX2Rpcik7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgc3dpb3Rs
Yl9jcmVhdGVfZGVidWdmc19maWxlcyhtZW0pOwo+ICsgICAgICAgICAgICAgICB9Cj4gKyAgICAg
ICB9Cj4gKwo+ICsgICAgICAgZGV2LT5kbWFfaW9fdGxiX21lbSA9IG1lbTsKPiArCj4gKyAgICAg
ICByZXR1cm4gMDsKPiArfQo+ICsKPiArc3RhdGljIHZvaWQgcm1lbV9zd2lvdGxiX2RldmljZV9y
ZWxlYXNlKHN0cnVjdCByZXNlcnZlZF9tZW0gKnJtZW0sCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHN0cnVjdCBkZXZpY2UgKmRldikKPiArewo+ICsgICAgICAgZGV2
LT5kbWFfaW9fdGxiX21lbSA9IGlvX3RsYl9kZWZhdWx0X21lbTsKPiArfQo+ICsKPiArc3RhdGlj
IGNvbnN0IHN0cnVjdCByZXNlcnZlZF9tZW1fb3BzIHJtZW1fc3dpb3RsYl9vcHMgPSB7Cj4gKyAg
ICAgICAuZGV2aWNlX2luaXQgPSBybWVtX3N3aW90bGJfZGV2aWNlX2luaXQsCj4gKyAgICAgICAu
ZGV2aWNlX3JlbGVhc2UgPSBybWVtX3N3aW90bGJfZGV2aWNlX3JlbGVhc2UsCj4gK307Cj4gKwo+
ICtzdGF0aWMgaW50IF9faW5pdCBybWVtX3N3aW90bGJfc2V0dXAoc3RydWN0IHJlc2VydmVkX21l
bSAqcm1lbSkKPiArewo+ICsgICAgICAgdW5zaWduZWQgbG9uZyBub2RlID0gcm1lbS0+ZmR0X25v
ZGU7Cj4gKwo+ICsgICAgICAgaWYgKG9mX2dldF9mbGF0X2R0X3Byb3Aobm9kZSwgInJldXNhYmxl
IiwgTlVMTCkgfHwKPiArICAgICAgICAgICBvZl9nZXRfZmxhdF9kdF9wcm9wKG5vZGUsICJsaW51
eCxjbWEtZGVmYXVsdCIsIE5VTEwpIHx8Cj4gKyAgICAgICAgICAgb2ZfZ2V0X2ZsYXRfZHRfcHJv
cChub2RlLCAibGludXgsZG1hLWRlZmF1bHQiLCBOVUxMKSB8fAo+ICsgICAgICAgICAgIG9mX2dl
dF9mbGF0X2R0X3Byb3Aobm9kZSwgIm5vLW1hcCIsIE5VTEwpKQo+ICsgICAgICAgICAgICAgICBy
ZXR1cm4gLUVJTlZBTDsKPiArCj4gKyAgICAgICBpZiAoUGFnZUhpZ2hNZW0ocGZuX3RvX3BhZ2Uo
UEhZU19QRk4ocm1lbS0+YmFzZSkpKSkgewo+ICsgICAgICAgICAgICAgICBwcl9lcnIoIlJlc3Ry
aWN0ZWQgRE1BIHBvb2wgbXVzdCBiZSBhY2Nlc3NpYmxlIHdpdGhpbiB0aGUgbGluZWFyIG1hcHBp
bmcuIik7Cj4gKyAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOwo+ICsgICAgICAgfQo+ICsK
PiArICAgICAgIHJtZW0tPm9wcyA9ICZybWVtX3N3aW90bGJfb3BzOwo+ICsgICAgICAgcHJfaW5m
bygiUmVzZXJ2ZWQgbWVtb3J5OiBjcmVhdGVkIHJlc3RyaWN0ZWQgRE1BIHBvb2wgYXQgJXBhLCBz
aXplICVsZCBNaUJcbiIsCj4gKyAgICAgICAgICAgICAgICZybWVtLT5iYXNlLCAodW5zaWduZWQg
bG9uZylybWVtLT5zaXplIC8gU1pfMU0pOwoKT2ggbMOgIGzDoCwgYmVzaWRlcyBleHBsaWNpdCBj
YXN0aW5nIHRoYXQgSSBiZWxpZXZlIGNhbiBiZSBhdm9pZGVkLCAlbGQKIT0gdW5zaWduZWQgbG9u
Zy4gQ2FuIHlvdSBjaGVjayB0aGUgcHJpbnRrLWZvcm1hdHMucnN0IGRvY3VtZW50PwoKPiArICAg
ICAgIHJldHVybiAwOwo+ICt9Cj4gKwo+ICtSRVNFUlZFRE1FTV9PRl9ERUNMQVJFKGRtYSwgInJl
c3RyaWN0ZWQtZG1hLXBvb2wiLCBybWVtX3N3aW90bGJfc2V0dXApOwo+ICAjZW5kaWYgLyogQ09O
RklHX0RNQV9SRVNUUklDVEVEX1BPT0wgKi8KCi0tIApXaXRoIEJlc3QgUmVnYXJkcywKQW5keSBT
aGV2Y2hlbmtvCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
