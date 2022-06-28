Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B009ACCA47F
	for <iommu@archiver.kernel.org>; Tue, 28 Jun 2022 21:38:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 273E960B2E;
	Tue, 28 Jun 2022 21:38:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 273E960B2E
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=Hl4POJee
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V9Z_8ajdJk6W; Tue, 28 Jun 2022 21:38:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D440760888;
	Tue, 28 Jun 2022 21:38:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D440760888
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7E610C0032;
	Tue, 28 Jun 2022 21:38:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23BB5C002D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 21:38:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 05B394088C
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 21:38:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 05B394088C
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=Hl4POJee
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u-s6wgIzoSBo for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 21:38:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E00E04050F
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E00E04050F
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 21:38:10 +0000 (UTC)
Received: by mail-pg1-x529.google.com with SMTP id s206so4408125pgs.3
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 14:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=WjW+6GW3ETFm2JU8jE79XhUoTv6z3/GSxYftllUP/xs=;
 b=Hl4POJee6IPPulGeCkhFVzmaewHFoLW/+/aEoDQjxUpbODhZ1oymIgaTqZ81qNcby5
 tayUWDYOl9MImX18J8dQD7IqMr+zmUU1bqZHU+pNimB587Iq3zDvd9733Lpd08PJ3ZqN
 hCcDuWiBdimpZlnAS7LXz+VIQLfHxUzeRmXR/DhhOL+83rGT7oCb0qCs+I3LD5qbJUOY
 Z7gwLbNztnnB2BuHaZLhgR2hoazBRvaRufJfP7NUdv99H5O/s5nLD+ERJ1SZjBEJ5o3/
 g1yNYiH51zSIYiit2licB5Pp4Mw6FaB2n5sZmRFysJGeMTkqmhnQmnjN1azWYVr/4Saz
 dDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=WjW+6GW3ETFm2JU8jE79XhUoTv6z3/GSxYftllUP/xs=;
 b=qLNE/RGYoxJGStyO2YtOJhDxNKki9CzMvI0I/5NkFqgmtHtPYuG5JpssIMHp7p6sMJ
 PtnkWRMheM74Nj5y1nT5Tajjq7iU14HkZ9RWClLuBTvKq24ewI04vUtkhRmYIUmwNBbl
 km5Q3MvKcQhkuXoFrSIkPN5dPFZ1pHkiaYNxGUor+zUHgDQOjkO0/YdqU2b3R6GtQi43
 hi+jxc7Z0KoMGdoy9cmjZ48/XrdHb7nRmbEIZEycnI3k2rjg26YpdD5NeDyUZ4EIQdnu
 WS6EJd07o7nOdFqS1owdZ4Jgwd38hTzIO7WU7Hkx+M7NIh/x+C9LpwXpI/YDFA5rzMMe
 +KAA==
X-Gm-Message-State: AJIora8uv2++rKxzwV3OBrQNPzQNf5AK80hgdmSQp/k33wr7r/lxKkN3
 MPyQtY/jPch1imWLCI+34EE=
X-Google-Smtp-Source: AGRyM1sFO6YgYAr9GnaRe8/Ve8aBPD9B79jMLNzzxljl0q+mxUt4Mwk0qg0QIVqzTJY3FgSvSPWrFw==
X-Received: by 2002:a63:3545:0:b0:40c:95f7:d114 with SMTP id
 c66-20020a633545000000b0040c95f7d114mr5443pga.150.1656452290295; 
 Tue, 28 Jun 2022 14:38:10 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:75aa:d6ca:4354:6033?
 ([2001:df0:0:200c:75aa:d6ca:4354:6033])
 by smtp.gmail.com with ESMTPSA id
 b8-20020a170902650800b00168a651316csm9770467plk.270.2022.06.28.14.38.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jun 2022 14:38:09 -0700 (PDT)
Message-ID: <b1edec96-ccb2-49d6-323b-1abc0dc37a50@gmail.com>
Date: Wed, 29 Jun 2022 09:38:00 +1200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 3/3] arch/*/: remove CONFIG_VIRT_TO_BUS
Content-Language: en-US
To: Arnd Bergmann <arnd@kernel.org>
References: <20220617125750.728590-1-arnd@kernel.org>
 <20220617125750.728590-4-arnd@kernel.org>
 <6ba86afe-bf9f-1aca-7af1-d0d348d75ffc@gmail.com>
 <CAMuHMdVewn0OYA9oJfStk0-+vCKAUou+4Mvd5H2kmrSks1p5jg@mail.gmail.com>
 <b4e5a1c9-e375-63fb-ec7c-abb7384a6d59@gmail.com>
 <9289fd82-285c-035f-5355-4d70ce4f87b0@gmail.com>
 <CAK8P3a1ivqYB38c_QTjG8e85ZBnCB6HEa-6LR1HDc8shG1Pwmw@mail.gmail.com>
From: Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <CAK8P3a1ivqYB38c_QTjG8e85ZBnCB6HEa-6LR1HDc8shG1Pwmw@mail.gmail.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, scsi <linux-scsi@vger.kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Christoph Hellwig <hch@infradead.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Jakub Kicinski <kuba@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Denis Efremov <efremov@linux.com>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Khalid Aziz <khalid@gonehiking.org>,
 Miquel van Smoorenburg <mikevs@xs4all.net>,
 Parisc List <linux-parisc@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Matt Wang <wwentao@vmware.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Mark Salyzyn <salyzyn@android.com>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 alpha <linux-alpha@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "Maciej W . Rozycki" <macro@orcam.me.uk>
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

SGkgQXJuZCwKCk9uIDI4LzA2LzIyIDE5OjA4LCBBcm5kIEJlcmdtYW5uIHdyb3RlOgo+IE9uIFR1
ZSwgSnVuIDI4LCAyMDIyIGF0IDU6MjUgQU0gTWljaGFlbCBTY2htaXR6IDxzY2htaXR6bWljQGdt
YWlsLmNvbT4gd3JvdGU6Cj4+IEFtIDI4LjA2LjIwMjIgdW0gMDk6MTIgc2NocmllYiBNaWNoYWVs
IFNjaG1pdHo6Cj4+Cj4+IExlYXZpbmcgdGhlIGJvdW5jZSBidWZmZXIgaGFuZGxpbmcgaW4gcGxh
Y2UsIGFuZCB0YWtpbmcgYSBmZXcgb3RoZXIKPj4gbGliZXJ0aWVzIC0gdGhpcyBpcyB3aGF0IGNv
bnZlcnRpbmcgdGhlIGVhc2llc3QgY2FzZSAoYTMwMDAgU0NTSSkgbWlnaHQKPj4gbG9vayBsaWtl
LiBBbnkgb2J2aW91cyBtaXN0YWtlcz8gVGhlIG12bWUxNDcgZHJpdmVyIHdvdWxkIGJlIHZlcnkK
Pj4gc2ltaWxhciB0byBoYW5kbGUgKGFmdGVyIGNvbnZlcnNpb24gdG8gYSBwbGF0Zm9ybSBkZXZp
Y2UpLgo+Pgo+PiBUaGUgZHJpdmVyIGFsbG9jYXRlcyBib3VuY2UgYnVmZmVycyB1c2luZyBrbWFs
bG9jIGlmIGl0IGhpdHMgYW4KPj4gdW5hbGlnbmVkIGRhdGEgYnVmZmVyIC0gY2FuIHN1Y2ggYnVm
ZmVycyBzdGlsbCBldmVuIGhhcHBlbiB0aGVzZSBkYXlzPwo+PiBJZiBJIHVuZGVyc3RhbmQgZG1h
X21hcF9zaW5nbGUoKSBjb3JyZWN0bHksIHRoZSByZXN1bHRpbmcgZG1hIGhhbmRsZQo+PiB3b3Vs
ZCBiZSBlcXVhbGx5IG1pc2FsaWduZWQ/Cj4+Cj4+IFRvIGFsbG9jYXRlIGEgYm91bmNlIGJ1ZmZl
ciwgd291bGQgaXQgYmUgT0sgdG8gdXNlIGRtYV9hbGxvY19jb2hlcmVudCgpCj4+IGV2ZW4gdGhv
dWdoIEFGQUlVIG1lbW9yeSB1c2VkIGZvciBETUEgYnVmZmVycyBnZW5lcmFsbHkgaXNuJ3QgY29u
c2lzdGVudAo+PiBvbiBtNjhrPwo+IEkgdGhpbmsgaXQgbWFrZXMgc2Vuc2UgdG8gc2tpcCB0aGUg
Ym91bmNlIGJ1ZmZlcmluZyBhcyB5b3UgZG8gaGVyZToKPiB0aGUgb25seSBzdGFuZGFyZGl6ZWQg
d2F5IHdlIGhhdmUgZm9yIGludGVncmF0aW5nIHRoYXQgcGFydCBpcyB0bwo+IHVzZSB0aGUgc3dp
b3RsYiBpbmZyYXN0cnVjdHVyZSwgYnV0IGFzIHlvdSBtZW50aW9uZWQgZWFybGllciB0aGF0Cj4g
cGFydCBpcyBwcm9iYWJseSB0b28gcmVzb3VyY2UtaGVhdnkgaGVyZSBmb3IgQW1pZ2EuCk9LLCBs
ZWF2aW5nIHRoZSBvbGQgY3VzdG9tIGxvZ2ljIGluIHBsYWNlIGFsbG93cyB0byBjb252ZXJ0IHRo
ZSAyNCBiaXQgCkRNQSBkcml2ZXJzIG1vcmUgZWFzaWx5Lgo+Cj4gSSBzZWUgdHdvIG90aGVyIHBy
b2JsZW1zIHdpdGggeW91ciBwYXRjaCB0aG91Z2g6Cj4KPiBhKSB5b3Ugc3RpbGwgZHVwbGljYXRl
IHRoZSBjYWNoZSBoYW5kbGluZzogdGhlIGNhY2hlX2NsZWFyKCkvY2FjaGVfcHVzaCgpCj4gaXMg
c3VwcG9zZWQgdG8gYWxyZWFkeSBiZSBkb25lIGJ5IGRtYV9tYXBfc2luZ2xlKCkgd2hlbiB0aGUg
ZGV2aWNlCj4gaXMgbm90IGNhY2hlLWNvaGVyZW50LgoKVGhhdCdzIG9uZSBvZiB0aGUgJ2xpYmVy
dGllcycgSSBhbGx1ZGVkIHRvLiBUaGUgcmVhc29uIEkgbGVmdCB0aGVzZSBpbiAKaXMgdGhhdCBJ
J20gbm9uZSB0b28gY2VydGFpbiB3aGF0IGRldmljZSBmZWF0dXJlIHRoZSBETUEgQVBJIHVzZXMg
dG8gCmRlY2lkZSBhIGRldmljZSBpc24ndCBjYWNoZS1jb2hlcmVudC4gSWYgaXQncyBkZXYtPmNv
aGVyZW50X2RtYV9tYXNrLCAKdGhlIHdheSBJIHNldCB1cCB0aGUgZGV2aWNlIGluIHRoZSBhMzAw
MCBkcml2ZXIgc2hvdWxkIGxlYXZlIHRoZSAKY29oZXJlbnQgbWFzayB1bmNoYW5nZWQuIEZvciB0
aGUgWm9ycm8gZHJpdmVycywgZGV2aWNlcyBhcmUgc2V0IHVwIHRvIAp1c2UgdGhlIHNhbWUgc3Rv
cmFnZSB0byBzdG9yZSBub3JtYWwgYW5kIGNvaGVyZW50IG1hc2tzIC0gc29tZXRoaW5nIHdlIApt
b3N0IGxpa2VseSB3YW50IHRvIGNoYW5nZS4gSSBuZWVkIHRvIHRoaW5rIGFib3V0IHRoZSByYW1p
ZmljYXRpb25zIG9mIAp0aGF0LgoKTm90ZSB0aGF0IHpvcnJvX2VzcC5jIHVzZXMgZG1hX3N5bmNf
c2luZ2xlX2Zvcl9kZXZpY2UoKSBhbmQgdXNlcyBhIDMyIApiaXQgY29oZXJlbnQgRE1BIG1hc2sg
d2hpY2ggZG9lcyB3b3JrIE9LLiBJIG1pZ2h0wqAgYXNrIEFkcmlhbiB0byB0ZXN0IGEgCmNoYW5n
ZSB0byBvbmx5IHNldCBkZXYtPmRtYV9tYXNrLCBhbmQgZHJvcCB0aGUgCmRtYV9zeW5jX3Npbmds
ZV9mb3JfZGV2aWNlKCkgY2FsbHMgaWYgdGhlcmUncyBhbnkgZG91YnQgb24gdGhpcyBhc3BlY3Qu
Cgo+IGIpIFRoZSBib3VuY2UgYnVmZmVyIGlzIG5ldmVyIG1hcHBlZCBoZXJlLCBpbnN0ZWFkIHlv
dSBoYXZlIHRoZQo+IHZpcnRfdG9fcGh5cygpIGhlcmUsIHdoaWNoIGlzIG5vdCB0aGUgc2FtZS4g
SSB0aGluayB5b3UgbmVlZCB0byBtYXAKPiB0aGUgcG9pbnRlciB0aGF0IGFjdHVhbGx5IGdldHMg
cGFzc2VkIGRvd24gdG8gdGhlIGRldmljZSBhZnRlciBkZWNpZGluZwo+IHRvIHVzZSBhIGJvdWNl
IGJ1ZmZlciBvciBub3QuCgpJIGhhZG4ndCByZWFsaXplZCB0aGF0IEkgY2FuIG1hcCB0aGUgYm91
bmNlIGJ1ZmZlciBqdXN0IGFzIGl0J3MgZG9uZSBmb3IgCnRoZSBTQ3AgZGF0YSBidWZmZXIuIFNo
b3VsZCBoYXZlIGJlZW4gb2J2aW91cywgYnV0IEknbSBzdGlsbCBsZWFybmluZyAKYWJvdXQgdGhl
IERNQSBBUEkuCgpJJ3ZlIHVwZGF0ZWQgdGhlIHBhdGNoIG5vdywgd2lsbCByZS1zZW5kIGFzIHBh
cnQgb2YgYSBjb21wbGV0ZSBzZXJpZXMgCm9uY2UgZG9uZS4KCkNoZWVycywKCiDCoMKgwqAgTWlj
aGFlbAoKCj4KPiAgICAgICBBcm5kCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by9pb21tdQ==
