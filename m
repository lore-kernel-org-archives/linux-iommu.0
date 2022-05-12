Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B07F8C433EF
	for <iommu@archiver.kernel.org>; Thu, 12 May 2022 07:07:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4631781987;
	Thu, 12 May 2022 07:07:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pq580deTtUU0; Thu, 12 May 2022 07:07:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0DCC0814B4;
	Thu, 12 May 2022 07:07:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2CE0C0039;
	Thu, 12 May 2022 07:07:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9615EC002D
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 07:07:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7056A60A90
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 07:07:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 50OODBxg4Cyh for <iommu@lists.linux-foundation.org>;
 Thu, 12 May 2022 07:07:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8FC4260736
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 07:07:16 +0000 (UTC)
Received: by mail-pf1-x430.google.com with SMTP id p12so4042954pfn.0
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 00:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=319/RuN0YbUvetJSlx7oakpoNVUE7HqxCIHYWexkjE8=;
 b=qXsG/am9c+VWQf5Ax7DDEiD7YTOX11ziFugMqIwdRFa04Jj1YYM48p/7qXy9lg1y04
 7Jwllemv5olYSyGOq5y1qMoawTD1tcIDB/4uNCZOJ6IwuLaa8V7f6VZbgKJg7luxfPjY
 C08dCjUignSH2HieQeP+e+GnrIBNVZ+rvDQI5OAMmSvKR51oXnvZRcVFBTVa8uIkck51
 pZoUcPsETkTN5K1y+81lXhxwilMfJyJd03m5k1GODCq5SS+uqTGVr+LkoKbWG0pIiYGc
 h5VWxwkz8d0DfmSRM50R41eSTBX4haaF8QIqAsRw45SauOluQ0EUm33nVIuYAsv6cive
 hwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=319/RuN0YbUvetJSlx7oakpoNVUE7HqxCIHYWexkjE8=;
 b=LHHVLEjfZ3tWzdoftKwRz5AR5qMzukqEkjERPSU//crjCy7Vcqd/dbev/Tl5D2EkCa
 MInzVArfFpox8ND1/nGKelBF1HwiblyPNzd/n5Re4kzXB/bHlOQ6OGkj64w/8hhCypn4
 cFQaLKxDeX2e9a4gcf6IKzDwrGGsNCVYo04p4cdU5AoHe0ah4zI5/yWnRaIZrkmUGXrX
 YFlCK3uHtNWwTD6EWYwdLklcoHZI0pZ6j7MRsptzH1uVjhOf64Y1LVe9OW7dfDv+sdn4
 xG7oC9WpJ5k0hW5XQ3Kek6dUTmCs/VdqKLJyRqYloz8FHW8WpZK6LMPdtMI6EAq2rI7I
 ta8Q==
X-Gm-Message-State: AOAM530TYdF9uFmPwVKZ3/7DrzsYY0i5sNUo4LQDu8PKTBdUHA8e9wv3
 HQ1XkA1BFM6k0EFx/BvUv54vyA==
X-Google-Smtp-Source: ABdhPJyOi6aHqIM/y47xJpvmXjwkOxBj1StA3kwlf04wBc+qONTuJ9Djhqk8fbU3a+uSq8FDWzj2kA==
X-Received: by 2002:a63:303:0:b0:3db:5806:c365 with SMTP id
 3-20020a630303000000b003db5806c365mr2525523pgd.302.1652339235992; 
 Thu, 12 May 2022 00:07:15 -0700 (PDT)
Received: from [10.87.0.6] ([94.177.118.16]) by smtp.gmail.com with ESMTPSA id
 p17-20020a63b811000000b003c14af50607sm1112765pge.31.2022.05.12.00.07.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 May 2022 00:07:15 -0700 (PDT)
Subject: Re: [PATCH] vfio: Remove VFIO_TYPE1_NESTING_IOMMU
To: Jason Gunthorpe <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>
References: <0-v1-0093c9b0e345+19-vfio_no_nesting_jgg@nvidia.com>
 <0e2f7cb8-f0d9-8209-6bc2-ca87fff57f1f@arm.com>
 <20220510181327.GM49344@nvidia.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <6c6f3ecb-6339-4093-a15a-fcf95a7c61fb@linaro.org>
Date: Thu, 12 May 2022 15:07:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220510181327.GM49344@nvidia.com>
Content-Language: en-US
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kvm@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Vivek Kumar Gautam <Vivek.Gautam@arm.com>, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

SGksIEphc29uCgpPbiAyMDIyLzUvMTEg5LiK5Y2IMjoxMywgSmFzb24gR3VudGhvcnBlIHZpYSBp
b21tdSB3cm90ZToKPiBPbiBUdWUsIE1heSAxMCwgMjAyMiBhdCAwNjo1MjowNlBNICswMTAwLCBS
b2JpbiBNdXJwaHkgd3JvdGU6Cj4+IE9uIDIwMjItMDUtMTAgMTc6NTUsIEphc29uIEd1bnRob3Jw
ZSB2aWEgaW9tbXUgd3JvdGU6Cj4+PiBUaGlzIGNvbnRyb2wgY2F1c2VzIHRoZSBBUk0gU01NVSBk
cml2ZXJzIHRvIGNob29zZSBhIHN0YWdlIDIKPj4+IGltcGxlbWVudGF0aW9uIGZvciB0aGUgSU8g
cGFnZXRhYmxlICh2cyB0aGUgc3RhZ2UgMSB1c3VhbCBkZWZhdWx0KSwKPj4+IGhvd2V2ZXIgdGhp
cyBjaG9pY2UgaGFzIG5vIHZpc2libGUgaW1wYWN0IHRvIHRoZSBWRklPIHVzZXIuIEZ1cnRoZXIg
cWVtdQo+Pj4gbmV2ZXIgaW1wbGVtZW50ZWQgdGhpcyBhbmQgbm8gb3RoZXIgdXNlcnNwYWNlIHVz
ZXIgaXMga25vd24uCj4+Pgo+Pj4gVGhlIG9yaWdpbmFsIGRlc2NyaXB0aW9uIGluIGNvbW1pdCBm
NWM5ZWNlYmFmMmEgKCJ2ZmlvL2lvbW11X3R5cGUxOiBhZGQKPj4+IG5ldyBWRklPX1RZUEUxX05F
U1RJTkdfSU9NTVUgSU9NTVUgdHlwZSIpIHN1Z2dlc3RlZCB0aGlzIHdhcyB0byAicHJvdmlkZQo+
Pj4gU01NVSB0cmFuc2xhdGlvbiBzZXJ2aWNlcyB0byB0aGUgZ3Vlc3Qgb3BlcmF0aW5nIHN5c3Rl
bSIgaG93ZXZlciB0aGUgcmVzdAo+Pj4gb2YgdGhlIEFQSSB0byBzZXQgdGhlIGd1ZXN0IHRhYmxl
IHBvaW50ZXIgZm9yIHRoZSBzdGFnZSAxIHdhcyBuZXZlcgo+Pj4gY29tcGxldGVkLCBvciBhdCBs
ZWFzdCBuZXZlciB1cHN0cmVhbWVkLCByZW5kZXJpbmcgdGhpcyBwYXJ0IHVzZWxlc3MgZGVhZAo+
Pj4gY29kZS4KPj4+Cj4+PiBTaW5jZSB0aGUgY3VycmVudCBwYXRjaGVzIHRvIGVuYWJsZSBuZXN0
ZWQgdHJhbnNsYXRpb24sIGFrYSB1c2Vyc3BhY2UgcGFnZQo+Pj4gdGFibGVzLCByZWx5IG9uIGlv
bW11ZmQgYW5kIHdpbGwgbm90IHVzZSB0aGUgZW5hYmxlX25lc3RpbmcoKQo+Pj4gaW9tbXVfZG9t
YWluX29wLCByZW1vdmUgdGhpcyBpbmZyYXN0cnVjdHVyZS4gSG93ZXZlciwgZG9uJ3QgY3V0IHRv
byBkZWVwCj4+PiBpbnRvIHRoZSBTTU1VIGRyaXZlcnMgZm9yIG5vdyBleHBlY3RpbmcgdGhlIGlv
bW11ZmQgd29yayB0byBwaWNrIGl0IHVwIC0KPj4+IHdlIHN0aWxsIG5lZWQgdG8gY3JlYXRlIFMy
IElPIHBhZ2UgdGFibGVzLgo+Pj4KPj4+IFJlbW92ZSBWRklPX1RZUEUxX05FU1RJTkdfSU9NTVUg
YW5kIGV2ZXJ5dGhpbmcgdW5kZXIgaXQgaW5jbHVkaW5nIHRoZQo+Pj4gZW5hYmxlX25lc3Rpbmcg
aW9tbXVfZG9tYWluX29wLgo+Pj4KPj4+IEp1c3QgaW4tY2FzZSB0aGVyZSBpcyBzb21lIHVzZXJz
cGFjZSB1c2luZyB0aGlzIGNvbnRpbnVlIHRvIHRyZWF0Cj4+PiByZXF1ZXN0aW5nIGl0IGFzIGEg
Tk9QLCBidXQgZG8gbm90IGFkdmVydGlzZSBzdXBwb3J0IGFueSBtb3JlLgo+PiBJIGFzc3VtZSB0
aGUgbmVzdGVkIHRyYW5zbGF0aW9uL2d1ZXN0IFNWQSBwYXRjaGVzIHRoYXQgRXJpYyBhbmQgVml2
ZWsgd2VyZQo+PiB3b3JraW5nIG9uIHByZS1JT01NVUZEIG1hZGUgdXNlIG9mIHRoaXMsIGFuZCBn
aXZlbiB0aGF0IHRoZXkgZ290IHF1aXRlIGZhcgo+PiBhbG9uZywgSSB3b3VsZG4ndCBiZSB0b28g
c3VycHJpc2VkIGlmIHNvbWUgZWFnZXIgY2xvdWQgdmVuZG9ycyBtaWdodCBoYXZlCj4+IGV2ZW4g
ZGVwbG95ZWQgc29tZXRoaW5nIGJhc2VkIG9uIHRoZSBwYXRjaGVzIG9mZiB0aGUgbGlzdC4KPiBX
aXRoIHVwc3RyZWFtIHRoZXJlIGlzIG5vIHdheSB0byBtYWtlIHVzZSBvZiB0aGlzIGZsYWcsIGlm
IHNvbWVvbmUgaXMKPiB1c2luZyBpdCB0aGV5IGhhdmUgb3RoZXIgb3V0IG9mIHRyZWUga2VybmVs
LCB2ZmlvLCBrdm0gYW5kIHFlbXUKPiBwYXRjaGVzIHRvIG1ha2UgaXQgYWxsIHdvcmsuCj4KPiBZ
b3UgY2FuIHNlZSBob3cgbXVjaCBpcyBzdGlsbCBuZWVkZWQgaW4gRXJpYydzIHRyZWU6Cj4KPiBo
dHRwczovL2dpdGh1Yi5jb20vZWF1Z2VyL2xpbnV4L2NvbW1pdHMvdjUuMTUtcmM3LW5lc3RlZC12
MTYKPgo+PiBJIGNhbid0IGhlbHAgZmVlbGluZyBhIGxpdHRsZSB3YXJ5IGFib3V0IHJlbW92aW5n
IHRoaXMgdW50aWwgSU9NTVVGRAo+PiBjYW4gYWN0dWFsbHkgb2ZmZXIgYSBmdW5jdGlvbmFsIHJl
cGxhY2VtZW50IC0gaXMgaXQgaW4gdGhlIHdheSBvZgo+PiBhbnl0aGluZyB1cGNvbWluZz8KPiAg
RnJvbSBhbiB1cHN0cmVhbSBwZXJzcGVjdGl2ZSBpZiBzb21lb25lIGhhcyBhIHBhdGNoZWQga2Vy
bmVsIHRvCj4gY29tcGxldGUgdGhlIGZlYXR1cmUsIHRoZW4gdGhleSBjYW4gcGF0Y2ggdGhpcyBw
YXJ0IGluIGFzIHdlbGwsIHdlCj4gc2hvdWxkIG5vdCBjYXJyeSBkZWFkIGNvZGUgbGlrZSB0aGlz
IGluIHRoZSBrZXJuZWwgYW5kIGluIHRoZSB1YXBpLgo+Cj4gSXQgaXMgbm90IGRpcmVjdGx5IGlu
IHRoZSB3YXksIGJ1dCB0aGlzIG5lZWRzIHRvIGdldCBkb25lIGF0IHNvbWUKPiBwb2ludCwgSSdk
IHJhdGhlciBqdXN0IGdldCBpdCBvdXQgb2YgdGhlIHdheS4KCldlIGFyZSB1c2luZyB0aGlzIGlu
dGVyZmFjZSBmb3IgbmVzdGVkIG1vZGUuCgpJcyB0aGUgcmVwbGFjaW5nIHBhdGNoIHJlYWR5PwpD
YW4gd2UgcmVtb3ZlIHRoaXMgdW50aWwgc3VibWl0dGluZyB0aGUgbmV3IG9uZT8KClRoYW5rcwoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFp
bGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
