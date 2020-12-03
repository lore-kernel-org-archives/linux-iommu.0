Return-Path: <SRS0=qXOr=FH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78059C433FE
	for <iommu@archiver.kernel.org>; Thu,  3 Dec 2020 23:01:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B73F5223E8
	for <iommu@archiver.kernel.org>; Thu,  3 Dec 2020 23:01:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B73F5223E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D198C2E35A;
	Thu,  3 Dec 2020 23:01:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CsDNevDo-Q+8; Thu,  3 Dec 2020 23:01:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id EE01C2E2BF;
	Thu,  3 Dec 2020 23:01:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CF014C0FA8;
	Thu,  3 Dec 2020 23:01:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 79DFFC0FA7
 for <iommu@lists.linux-foundation.org>; Thu,  3 Dec 2020 23:01:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6D1C387C01
 for <iommu@lists.linux-foundation.org>; Thu,  3 Dec 2020 23:01:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l5gRMM+s0-l6 for <iommu@lists.linux-foundation.org>;
 Thu,  3 Dec 2020 23:01:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8717D87BC1
 for <iommu@lists.linux-foundation.org>; Thu,  3 Dec 2020 23:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607036491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ehiFjKtpol6KhoGccyyA6Ki5TKdintvVW8RJV4uQ538=;
 b=YcJAeorX9uherFgfnDSj2CRtJGGJnkWdoePBk/R7G/cPAA8fQlth9eyEjvdfntmng00R9B
 ++SZ5d9U6NvsCJfKZF1/gY8Rn4lwLdnC+pNolaNH+3ElrAU7Im7wFHFs3bNyan3yYl+WIZ
 hNHCsAyvd5v8OUeLcBw8TRXJu40yavk=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-Tuz26beKNvyiFRsVayCWwA-1; Thu, 03 Dec 2020 18:01:29 -0500
X-MC-Unique: Tuz26beKNvyiFRsVayCWwA-1
Received: by mail-il1-f197.google.com with SMTP id l2so3357205ilj.2
 for <iommu@lists.linux-foundation.org>; Thu, 03 Dec 2020 15:01:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=ehiFjKtpol6KhoGccyyA6Ki5TKdintvVW8RJV4uQ538=;
 b=nnJQR+Rdhb0BEpPLW/zGfcCOTHPykE5pqNrb2G67MgLLAI6jvlN7FZBhAL1tQx1mfC
 OyZwkN9Tk0w77UDaTh7zVAdkCVKvJMf58zH+pNgtgiGL68eWyorlp4JJfMRcyckowfFL
 H7PalAFKdWuyohMS17CldrUvLlHBkmPTNvxVLpRiI9GEW5iKRZfpKSXBkTHAObYHu3/h
 fFhX0sXve+gFFw3D37E1rv975AvBTlzENpIMH1R2qkP3satNEQo/QijLevxJXjDJg4Go
 w+omoHxqYFNkNCpJZINRl6Z71+XmWJZz5hWz2S22nWgaT/DmykZwP8YYzvD+w7/oaQ5X
 Wetw==
X-Gm-Message-State: AOAM5328r/bZ7z87hMFC9bFOgAyB2oa5gVTJosReJM9f46r9slVt+/cp
 o+iPKcaCSb+nxEefraSlunAcUgs1G/dtMwcanhSa0d9oiN6FxD7WeKHnXsOKZelz1bJVwxB+bT0
 Lbr7BYTmkqkqxlahspRYqU7oy0JJdCw==
X-Received: by 2002:a5e:d717:: with SMTP id v23mr2068322iom.60.1607036489028; 
 Thu, 03 Dec 2020 15:01:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz8/KKawnB+OcLWvg8UtSs2SnTlP08PfE9c+8IttZOqM02cKcbUxabzRJ/bbWxLyiKDXdRZCA==
X-Received: by 2002:a5e:d717:: with SMTP id v23mr2068300iom.60.1607036488815; 
 Thu, 03 Dec 2020 15:01:28 -0800 (PST)
Received: from localhost (c-67-165-232-89.hsd1.co.comcast.net. [67.165.232.89])
 by smtp.gmail.com with ESMTPSA id o12sm379906ilj.55.2020.12.03.15.01.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Dec 2020 15:01:28 -0800 (PST)
Date: Thu, 3 Dec 2020 16:01:27 -0700
From: Al Stone <ahs3@redhat.com>
To: Yinghan Yang <Yinghan.Yang@microsoft.com>
Subject: Re: [EXTERNAL] Re: Question regarding VIOT proposal
Message-ID: <20201203230127.GD4343@redhat.com>
References: <MW2PR2101MB1130313B4AE39B7EAC09349B80EE0@MW2PR2101MB1130.namprd21.prod.outlook.com>
 <20201105134503.GA950007@myrica>
 <MW2PR2101MB113096E822AD835F658808B480EE0@MW2PR2101MB1130.namprd21.prod.outlook.com>
 <20201106135745.GB974750@myrica>
 <MW2PR2101MB11301F2185D1C9016310728E80F21@MW2PR2101MB1130.namprd21.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <MW2PR2101MB11301F2185D1C9016310728E80F21@MW2PR2101MB1130.namprd21.prod.outlook.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ahs3@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Boeuf,
 Sebastien" <sebastien.boeuf@intel.com>,
 Alexander Grest <Alexander.Grest@microsoft.com>
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

T24gMDMgRGVjIDIwMjAgMjI6MjEsIFlpbmdoYW4gWWFuZyB3cm90ZToKPiBIaSBKZWFuLAo+IAo+
IEknbSBzb3JyeSBmb3IgdGhlIGRlbGF5ZWQgcmVzcG9uc2UuIEkgdGhpbmsgdGhlIG5ldyAiUENJ
IHJhbmdlIG5vZGUiIGRlc2NyaXB0aW9uIG1ha2VzIHNlbnNlLiBDb3VsZCB5b3UgcGxlYXNlIG1h
a2UgdGhpcyBjaGFuZ2UgaW4gdGhlIHByb3Bvc2FsPwo+IAo+IE90aGVyIHRoYW4gdGhhdCwgdGhl
IHByb3Bvc2FsIGxvb2tzIGdvb2QgdG8gZ28uCj4gCj4gVGhhbmtzLAo+IFlpbmdoYW4KCkplYW4s
IHdlcmUgeW91IGdvaW5nIHRvIHVwZGF0ZSB5b3VyIGV4aXN0aW5nIGRvYyBmaXJzdD8gIElmIHlv
dQpkbyB0aGF0LCB0aGVuIEkgY2FuIGN1dCBhbmQgcGFzdGUgdGhlIGNoYW5nZXMgaW50byB0aGUg
ZXhpc3RpbmcKQVNXRyBwcm9wb3NhbC4gIE9yIGRvIHlvdSBuZWVkIHRvIHNlbmQgb3V0IGFuIFJG
QyB0byB0aGUgbWFpbGluZwpsaXN0IGZpcnN0IGFuZCBmaW5hbGl6ZSBpdCB0aGVyZT8KClRoYW5r
cyBmb3IgYWxsIHRoZSBoZWxwLgoKPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+IEZyb206
IEplYW4tUGhpbGlwcGUgQnJ1Y2tlciA8amVhbi1waGlsaXBwZUBsaW5hcm8ub3JnPiAKPiBTZW50
OiBGcmlkYXksIE5vdmVtYmVyIDYsIDIwMjAgNTo1OCBBTQo+IFRvOiBZaW5naGFuIFlhbmcgPFlp
bmdoYW4uWWFuZ0BtaWNyb3NvZnQuY29tPgo+IENjOiBpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZzsgQWxleGFuZGVyIEdyZXN0IDxBbGV4YW5kZXIuR3Jlc3RAbWljcm9zb2Z0LmNvbT47
IGVyaWMuYXVnZXJAcmVkaGF0LmNvbTsgam9yb0A4Ynl0ZXMub3JnOyBrZXZpbi50aWFuQGludGVs
LmNvbTsgbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbTsgbXN0QHJlZGhhdC5jb207IEJvZXVmLCBT
ZWJhc3RpZW4gPHNlYmFzdGllbi5ib2V1ZkBpbnRlbC5jb20+OyBhaHMzQHJlZGhhdC5jb20KPiBT
dWJqZWN0OiBSZTogW0VYVEVSTkFMXSBSZTogUXVlc3Rpb24gcmVnYXJkaW5nIFZJT1QgcHJvcG9z
YWwKPiAKPiBIaSBZaW5naGFuLAo+IAo+IE9uIFRodSwgTm92IDA1LCAyMDIwIGF0IDEwOjA1OjI4
UE0gKzAwMDAsIFlpbmdoYW4gWWFuZyB3cm90ZToKPiA+IFRoYW5rIHlvdSBmb3IgdGhlIGNsYXJp
ZmljYXRpb25zLiBJbiBjYXNlcyB3aGVyZSBhIGxhcmdlIHJhbmdlIG9mICBQQ0kgc2VnbWVudHMg
bWF5IGJlIGFzc2lnbmVkIHRvIGd1ZXN0LCB3b3VsZCBpdCBtYWtlIHNlbnNlIHRvIGRlc2NyaWJl
IHRoaXMgY29uZmlndXJhdGlvbiBhcyBiYXNlICsgY291bnQuIEN1cnJlbnRseSwgb25lIHdvdWxk
IGhhdmUgdG8gZGVzY3JpYmUgdGhlbSBpbmRpdmlkdWFsbHkuIAo+IAo+IFllcywgSSd2ZSBiZWVu
IHdvbmRlcmluZyB3aGV0aGVyIHRoYXQgd291bGQgYmUgdXNlZnVsLiBJdCB3b3VsZCBhbHNvIGFs
bG93IGhvdHBsdWdnaW5nIG5ldyBzZWdtZW50cywgaWYgdGhhdCdzIGV2ZXIgbmVlZGVkLiBJdCBy
ZXF1aXJlcyBjaGFuZ2luZyB0aGUgZW51bWVyYXRpb24gcnVsZSB0aGF0IGRlcml2ZXMgYW4gZW5k
cG9pbnQgSUQgZnJvbSBzZWdtZW50ICsgQkRGIG51bWJlci4KPiAKPiBGaXJzdCwgd2hlbiBkZXNj
cmliaW5nIGEgcmFuZ2Ugb2Ygc2VnbWVudHMsIGFyZSBCRkQgc3RhcnQgYW5kIGVuZCBzdGlsbCB2
YWxpZD8gIERvIHRoZXkgb25seSBhcHBseSB0byBmaXJzdCBhbmQgbGFzdCBzZWdtZW50IHJlc3Bl
Y3RpdmVseT8gIFRvIGtlZXAgdGhpbmdzIHNpbXBsZSBJIHRoaW5rIEJERiBzdGFydC9lbmQgc2hv
dWxkIGtlZXAgdGhlIHNhbWUgbWVhbmluZzoKPiB2YWxpZCByZWdhcmRsZXNzIG9mIHNlZ21lbnQg
cmFuZ2UsIGFuZCBhcHBseSB0byBhbGwgc2VnbWVudHMgaW4gdGhlIHJhbmdlLgo+IAo+IFNvIHRo
ZSBuZXcgUENJIFJhbmdlIG5vZGUgY291bGQgYmU6Cj4gCj4gRmllbGQgICAgICAgICAgICAgICAg
ICAgTGVuZ3RoICBPZmZzZXQgIERlc2NyaXB0aW9uCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+
IFR5cGUgICAgICAgICAgICAgICAgICAgIDEgICAgICAgMCAgICAgICAxIOKAkyBQQ0kgcmFuZ2UK
PiBSZXNlcnZlZCAgICAgICAgICAgICAgICAxICAgICAgIDEgICAgICAgMC4KPiBMZW5ndGggICAg
ICAgICAgICAgICAgICAyICAgICAgIDIgICAgICAgTGVuZ3RoIG9mIHRoZSBub2RlIGluIGJ5dGVz
Lgo+IEVuZHBvaW50IHN0YXJ0ICAgICAgICAgIDQgICAgICAgNCAgICAgICBGaXJzdCBlbmRwb2lu
dCBJRC4KPiBQQ0kgU2VnbWVudCBzdGFydCAgICAgICAyICAgICAgIDggICAgICAgRmlyc3QgUENJ
IFNlZ21lbnQgbnVtYmVyIGluIHRoZSByYW5nZS4KPiBQQ0kgU2VnbWVudCBlbmQgICAgICAgICAy
ICAgICAgIDEwICAgICAgTGFzdCBQQ0kgU2VnbWVudCBudW1iZXIgaW4gdGhlIHJhbmdlLgo+IFBD
SSBCREYgc3RhcnQgICAgICAgICAgIDIgICAgICAgMTIgICAgICBGaXJzdCBCdXMtRGV2aWNlLUZ1
bmN0aW9uIG51bWJlciBpbiB0aGUgcmFuZ2UuCj4gUENJIEJERiBlbmQgICAgICAgICAgICAgMiAg
ICAgICAxNCAgICAgIExhc3QgQnVzLURldmljZS1GdW5jdGlvbiBudW1iZXIgaW4gdGhlIHJhbmdl
Lgo+IE91dHB1dCBub2RlICAgICAgICAgICAgIDIgICAgICAgMTYgICAgICBPZmZzZXQgZnJvbSB0
aGUgc3RhcnQgb2YgdGhlIHRhYmxlIHRvIHRoZSBuZXh0IHRyYW5zbGF0aW9uIGVsZW1lbnQuCj4g
UmVzZXJ2ZWQgICAgICAgICAgICAgICAgNiAgICAgICAxOCAgICAgIDAuCj4gCj4gQSBQQ0kgZGV2
aWNlIGlzIGFmZmVjdGVkIGJ5IHRoZSBub2RlIGlmIGl0cyBzZWdtZW50IGlzIGluIFtTZWdtZW50
IHN0YXJ0LCBTZWdtZW50IGVuZF0sIGFuZCBpZiBpdHMgQkRGIGlzIGluIFtCUEYgc3RhcnQsIEJE
RiBlbmRdLiBJdHMgZW5kcG9pbnQgSUQgd2lsbCBiZToKPiAKPiAgICAgKChTZWdtZW50IC0gU2Vn
bWVudCBzdGFydCkgPDwgMTYpICsgQkRGIC0gQkRGIHN0YXJ0ICsgRW5kcG9pbnQgc3RhcnQKPiAK
PiBEb2VzIHRoYXQgc291bmQgT0s/Cj4gCj4gVGhhbmtzLAo+IEplYW4KPiAKCi0tIApjaWFvLAph
bAotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpBbCBTdG9uZQpTb2Z0d2FyZSBF
bmdpbmVlcgpSZWQgSGF0LCBJbmMuCmFoczNAcmVkaGF0LmNvbQotLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lv
bW11
