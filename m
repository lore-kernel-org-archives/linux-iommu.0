Return-Path: <SRS0=Bvs7=NO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23940C4338F
	for <iommu@archiver.kernel.org>; Mon, 23 Aug 2021 07:45:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96E7261242
	for <iommu@archiver.kernel.org>; Mon, 23 Aug 2021 07:45:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 96E7261242
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5EF4160699;
	Mon, 23 Aug 2021 07:45:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HG0cV4iN_7xU; Mon, 23 Aug 2021 07:45:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2A3496064A;
	Mon, 23 Aug 2021 07:45:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F19B3C0010;
	Mon, 23 Aug 2021 07:45:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 534FCC000E
 for <iommu@lists.linux-foundation.org>; Mon, 23 Aug 2021 07:45:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 35BAF6067F
 for <iommu@lists.linux-foundation.org>; Mon, 23 Aug 2021 07:45:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 92_bDXrCSpyx for <iommu@lists.linux-foundation.org>;
 Mon, 23 Aug 2021 07:45:12 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 57B656064A
 for <iommu@lists.linux-foundation.org>; Mon, 23 Aug 2021 07:45:12 +0000 (UTC)
Received: by mail-il1-x131.google.com with SMTP id i13so5047587ilm.4
 for <iommu@lists.linux-foundation.org>; Mon, 23 Aug 2021 00:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=IlaNENSlWA7O36ThQC1swNGBkoYWjvx5SXQg/rTQMmI=;
 b=v/xf3p30Lok05NM5hFl5e4TCzreiVTbA7dm0nJz7Bf/rS+4kdz0RU6rdoBpuE/Bshr
 W2cwC5Rqg/vXWKdF3VDojkslVRYUpIIV1qOXJTZX6k9PFSBoGRovz6xeO18fgCyEcYvS
 hCv1Jon8C9lNgxDZ9meHG0kI+gMNr3M2A8yONcgxn/hUFoqTirFa2ZhbYcM8YyalIe9x
 khb9sMBSITynIRl1l+Ano9dtDdqXz0TaKK+4P02tlu6/bBFepF8x97BN24XkLkmCbvZ3
 QhrCp8ZUtmoLx/J0Y0tfnF8VtnQ8CkBgf2iVDfJnkPLnMfd/gQ2HaUkLgJubWjp+ggZe
 qzCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=IlaNENSlWA7O36ThQC1swNGBkoYWjvx5SXQg/rTQMmI=;
 b=dWPTuAw50WZYXhifPI/A0+8NJwbqT4Z4I3MLLTPyZZCWzmRe+EEX2NI9vSgIFxvrYN
 75mXIHfeSGGV6NhrQJ8uZUTF5K2WDnOYxs4YbX6iVxImfC3p4RsDL+ULpMefjm2zThgc
 +exogA5f4UJoW9BcErtjb/N+oDFG4RnFHf45mdkxA6nJxM2veHM0Tavuh1bKCoEPiJDM
 sLKUBRoamzKq/lnZFzoDztVL/l4dkS3NzLCTeN5mI9I9LZcqJ9WopILM6BScATUZ/s3n
 gaH6slDya6laQ4HHUPOYWwwOoQkw6YmLVEy09WYJSVY81uZzlumG0oVqJjDFkk0QbBHB
 sI9g==
X-Gm-Message-State: AOAM530UzOdCDWjFAanly0SpAkfqoWVLcet6Nw4Zu2RiOeGBMI7izV3X
 LEyKGpqRqr+aDdVuRWMPpVuZLeb1IVjXv7b72VNK
X-Google-Smtp-Source: ABdhPJypCdtizHYoxZDBKevH2qzGpkSgui7qYBLxMbmXcESyZsC9N17OihZaUrjlMnAjFtHM+k3anHAL8J48FceAkUo=
X-Received: by 2002:a92:7b0c:: with SMTP id w12mr22446677ilc.307.1629704711346; 
 Mon, 23 Aug 2021 00:45:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210818120642.165-1-xieyongji@bytedance.com>
 <20210818120642.165-5-xieyongji@bytedance.com>
 <4470fdac-89fb-1216-78d7-6335c3bfeb22@redhat.com>
In-Reply-To: <4470fdac-89fb-1216-78d7-6335c3bfeb22@redhat.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Mon, 23 Aug 2021 15:44:59 +0800
Message-ID: <CACycT3sjeWhUmHSAeniSnMO6Jus_d1p3eO--y0qc9FYP_cDMzQ@mail.gmail.com>
Subject: Re: [PATCH v11 04/12] vdpa: Add reset callback in vdpa_config_ops
To: Jason Wang <jasowang@redhat.com>
Cc: kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christian Brauner <christian.brauner@canonical.com>,
 Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
 Christoph Hellwig <hch@infradead.org>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Liu Xiaodong <xiaodong.liu@intel.com>, linux-fsdevel@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, Stefan Hajnoczi <stefanha@redhat.com>,
 songmuchun@bytedance.com, Jens Axboe <axboe@kernel.dk>,
 He Zhe <zhe.he@windriver.com>, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 bcrl@kvack.org, netdev@vger.kernel.org, Joe Perches <joe@perches.com>,
 Robin Murphy <robin.murphy@arm.com>,
 =?UTF-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>
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

T24gTW9uLCBBdWcgMjMsIDIwMjEgYXQgMjozMSBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPiB3cm90ZToKPgo+Cj4g5ZyoIDIwMjEvOC8xOCDkuIvljYg4OjA2LCBYaWUgWW9uZ2pp
IOWGmemBkzoKPiA+IFRoaXMgYWRkcyBhIG5ldyBjYWxsYmFjayB0byBzdXBwb3J0IGRldmljZSBz
cGVjaWZpYyByZXNldAo+ID4gYmVoYXZpb3IuIFRoZSB2ZHBhIGJ1cyBkcml2ZXIgd2lsbCBjYWxs
IHRoZSByZXNldCBmdW5jdGlvbgo+ID4gaW5zdGVhZCBvZiBzZXR0aW5nIHN0YXR1cyB0byB6ZXJv
IGR1cmluZyByZXNldHRpbmcgaWYgZGV2aWNlCj4gPiBkcml2ZXIgc3VwcG9ydHMgdGhlIG5ldyBj
YWxsYmFjay4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBYaWUgWW9uZ2ppIDx4aWV5b25namlAYnl0
ZWRhbmNlLmNvbT4KPiA+IC0tLQo+ID4gICBkcml2ZXJzL3Zob3N0L3ZkcGEuYyB8ICA5ICsrKysr
KystLQo+ID4gICBpbmNsdWRlL2xpbnV4L3ZkcGEuaCB8IDExICsrKysrKysrKystCj4gPiAgIDIg
ZmlsZXMgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPiA+Cj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92ZHBhLmMgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+
ID4gaW5kZXggYjA3YWExNjFmN2FkLi5iMWM5MWI0ZGIwYmEgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2
ZXJzL3Zob3N0L3ZkcGEuYwo+ID4gKysrIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPiA+IEBAIC0x
NTcsNyArMTU3LDcgQEAgc3RhdGljIGxvbmcgdmhvc3RfdmRwYV9zZXRfc3RhdHVzKHN0cnVjdCB2
aG9zdF92ZHBhICp2LCB1OCBfX3VzZXIgKnN0YXR1c3ApCj4gPiAgICAgICBzdHJ1Y3QgdmRwYV9k
ZXZpY2UgKnZkcGEgPSB2LT52ZHBhOwo+ID4gICAgICAgY29uc3Qgc3RydWN0IHZkcGFfY29uZmln
X29wcyAqb3BzID0gdmRwYS0+Y29uZmlnOwo+ID4gICAgICAgdTggc3RhdHVzLCBzdGF0dXNfb2xk
Owo+ID4gLSAgICAgaW50IG52cXMgPSB2LT5udnFzOwo+ID4gKyAgICAgaW50IHJldCwgbnZxcyA9
IHYtPm52cXM7Cj4gPiAgICAgICB1MTYgaTsKPiA+Cj4gPiAgICAgICBpZiAoY29weV9mcm9tX3Vz
ZXIoJnN0YXR1cywgc3RhdHVzcCwgc2l6ZW9mKHN0YXR1cykpKQo+ID4gQEAgLTE3Miw3ICsxNzIs
MTIgQEAgc3RhdGljIGxvbmcgdmhvc3RfdmRwYV9zZXRfc3RhdHVzKHN0cnVjdCB2aG9zdF92ZHBh
ICp2LCB1OCBfX3VzZXIgKnN0YXR1c3ApCj4gPiAgICAgICBpZiAoc3RhdHVzICE9IDAgJiYgKG9w
cy0+Z2V0X3N0YXR1cyh2ZHBhKSAmIH5zdGF0dXMpICE9IDApCj4gPiAgICAgICAgICAgICAgIHJl
dHVybiAtRUlOVkFMOwo+ID4KPiA+IC0gICAgIG9wcy0+c2V0X3N0YXR1cyh2ZHBhLCBzdGF0dXMp
Owo+ID4gKyAgICAgaWYgKHN0YXR1cyA9PSAwICYmIG9wcy0+cmVzZXQpIHsKPiA+ICsgICAgICAg
ICAgICAgcmV0ID0gb3BzLT5yZXNldCh2ZHBhKTsKPiA+ICsgICAgICAgICAgICAgaWYgKHJldCkK
PiA+ICsgICAgICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Owo+ID4gKyAgICAgfSBlbHNlCj4g
PiArICAgICAgICAgICAgIG9wcy0+c2V0X3N0YXR1cyh2ZHBhLCBzdGF0dXMpOwo+ID4KPiA+ICAg
ICAgIGlmICgoc3RhdHVzICYgVklSVElPX0NPTkZJR19TX0RSSVZFUl9PSykgJiYgIShzdGF0dXNf
b2xkICYgVklSVElPX0NPTkZJR19TX0RSSVZFUl9PSykpCj4gPiAgICAgICAgICAgICAgIGZvciAo
aSA9IDA7IGkgPCBudnFzOyBpKyspCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC92ZHBh
LmggYi9pbmNsdWRlL2xpbnV4L3ZkcGEuaAo+ID4gaW5kZXggOGE2NDVmOGY0NDc2Li5hZjdlYTVh
ZDc5NWYgMTAwNjQ0Cj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3ZkcGEuaAo+ID4gKysrIGIvaW5j
bHVkZS9saW51eC92ZHBhLmgKPiA+IEBAIC0xOTYsNiArMTk2LDkgQEAgc3RydWN0IHZkcGFfaW92
YV9yYW5nZSB7Cj4gPiAgICAqICAgICAgICAgICAgICAgICAgICAgICAgICBAdmRldjogdmRwYSBk
ZXZpY2UKPiA+ICAgICogICAgICAgICAgICAgICAgICAgICAgICAgIFJldHVybnMgdGhlIGlvdmEg
cmFuZ2Ugc3VwcG9ydGVkIGJ5Cj4gPiAgICAqICAgICAgICAgICAgICAgICAgICAgICAgICB0aGUg
ZGV2aWNlLgo+ID4gKyAqIEByZXNldDogICAgICAgICAgICAgICAgICAgUmVzZXQgZGV2aWNlIChv
cHRpb25hbCkKPiA+ICsgKiAgICAgICAgICAgICAgICAgICAgICAgICAgIEB2ZGV2OiB2ZHBhIGRl
dmljZQo+ID4gKyAqICAgICAgICAgICAgICAgICAgICAgICAgICAgUmV0dXJucyBpbnRlZ2VyOiBz
dWNjZXNzICgwKSBvciBlcnJvciAoPCAwKQo+Cj4KPiBJdCBsb29rcyB0byBtZSB3ZSdkIGJldHRl
ciBtYWtlIHRoaXMgbWFuZGF0b3J5LiBUaGlzIGhlbHAgdG8gcmVkdWNlIHRoZQo+IGNvbmZ1c2lv
biBmb3IgdGhlIHBhcmVudCBkcml2ZXIuCj4KCk9LLCB3aWxsIGRvIGl0IGluIG5leHQgdmVyc2lv
bi4KClRoYW5rcywKWW9uZ2ppCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9p
b21tdQ==
