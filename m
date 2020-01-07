Return-Path: <SRS0=zmEc=24=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1980C32771
	for <iommu@archiver.kernel.org>; Tue,  7 Jan 2020 01:31:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93F7720715
	for <iommu@archiver.kernel.org>; Tue,  7 Jan 2020 01:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EayBkZmT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93F7720715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 316CB8743E;
	Tue,  7 Jan 2020 01:31:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OjEc8xJuX7MO; Tue,  7 Jan 2020 01:31:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7FDAF86E6A;
	Tue,  7 Jan 2020 01:31:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70FF8C1D82;
	Tue,  7 Jan 2020 01:31:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 45D06C0881
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jan 2020 01:31:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2CE8388262
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jan 2020 01:31:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uGQgwvcHfQ2x for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jan 2020 01:31:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 3943A8823A
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jan 2020 01:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578360661;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qqJPNV1DwdFQdrHiCy3GBIYbRnliyAEgRUh4jdEwJgM=;
 b=EayBkZmTwIW0P143F+BT8P3Giewo3f/3tuJ0LjJSnTsxKClGBpVGlTqq4LC2SaiHMpqKJZ
 IzLwa7atK/YyTjM4xaEZwAYLo4aGqI4UyGTfrQ7Ydmp0Tgdc/qXGOqJMNPwsSCQhCG1a2I
 TJnVbnQETLeC5NJTic0n1lSWJHNKmHQ=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-uFCD6AtKOfiSa0yUzfJiZw-1; Mon, 06 Jan 2020 20:30:59 -0500
Received: by mail-yb1-f198.google.com with SMTP id a5so7484018ybc.12
 for <iommu@lists.linux-foundation.org>; Mon, 06 Jan 2020 17:30:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to;
 bh=qqJPNV1DwdFQdrHiCy3GBIYbRnliyAEgRUh4jdEwJgM=;
 b=csMfr3P23liWyvFbUvVqF5su1QfBeMDdKXbBgGyi0YD+MpmZVwf+q4PUCOm4tZ4RSW
 TaqxBBpCo/7SwIl4vI/FvkFlbOZZ3+7sVAZ3RZ4W9kVTXPWwHSbkRCwQmTsYoEu4R2Cj
 yo2IbXPYVTiSHKHH8s1kCfCEH/svODDogK8r7Xb7qvFhfNDrFphk0FE7m41PaXcTCzCy
 mb3ksTyqq/5tjE7gMxLQ6FxDruJVbpwAOEfTVpFnWZRucouNxjJH18VLswsJDVqSXRUR
 grCST0GyCm5wsydi8Upa4izVZUOIDBZgJ+f5tI8++CzFSubaLorkYY9542GqliMFxGgA
 PY8w==
X-Gm-Message-State: APjAAAVi1nYejjd3tdWDP7EvDIn5foADvNatbpk137kOT//2x0JtK3P9
 XYah1D9qjVIEFUXWysd0qR+tfu0Gir8cS8B8NXz2g/3eDVWfiJCNU/bzzqYcbBquKPHbAMae19J
 MKnuYkZZI3YJwwfVh4PzSqHdlE3FdVQ==
X-Received: by 2002:a5b:348:: with SMTP id q8mr23182769ybp.19.1578360658970;
 Mon, 06 Jan 2020 17:30:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqzLpZ4LndBP4SVqdQqHTHLa6wvOrvtXJGy805bpEnqc7EUpjK33pLvY7WFQEvklEyLH+p30+A==
X-Received: by 2002:a5b:348:: with SMTP id q8mr23182753ybp.19.1578360658715;
 Mon, 06 Jan 2020 17:30:58 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
 by smtp.gmail.com with ESMTPSA id s68sm28569419ywg.69.2020.01.06.17.30.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 17:30:57 -0800 (PST)
Date: Mon, 6 Jan 2020 18:30:56 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 22/22] iommu/vt-d: Add a quirk flag for scope mismatched
 devices
Message-ID: <20200107013056.pec2cz5zhazam4ra@cantor>
References: <20200102001823.21976-1-baolu.lu@linux.intel.com>
 <20200102001823.21976-23-baolu.lu@linux.intel.com>
 <CAL1RGDWU=s6nVArvkci1cXyZVw-fvdtcOjuY+9E+rgBi65q=Aw@mail.gmail.com>
 <567f1506-4a13-535b-ce41-aac079941510@linux.intel.com>
 <CAL1RGDVF1icaeEWMe0r0VA8AaxtHGJZ8NHCpvJfT8+1duOUYAQ@mail.gmail.com>
 <20200106170551.ykphn6couhxozrid@cantor>
 <799d7ab1-c496-e3f8-719e-e52fbabb8d1c@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <799d7ab1-c496-e3f8-719e-e52fbabb8d1c@linux.intel.com>
X-MC-Unique: uFCD6AtKOfiSa0yUzfJiZw-1
X-Mimecast-Spam-Score: 0
Content-Disposition: inline
Cc: Roland Dreier <roland@purestorage.com>, Jim Yan <jimyan@baidu.com>,
 iommu@lists.linux-foundation.org
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
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gVHVlIEphbiAwNyAyMCwgTHUgQmFvbHUgd3JvdGU6Cj5IaSBKZXJyeSwKPgo+T24gMS83LzIw
IDE6MDUgQU0sIEplcnJ5IFNuaXRzZWxhYXIgd3JvdGU6Cj4+T24gV2VkIEphbiAwMSAyMCwgUm9s
YW5kIERyZWllciB2aWEgaW9tbXUgd3JvdGU6Cj4+Pj5XZSBzYXcgbW9yZSBkZXZpY2VzIHdpdGgg
dGhlIHNhbWUgbWlzbWF0Y2ggcXVpcmsuIFNvIG1haW50YWluaW5nIHRoZW0gaW4KPj4+PmEgcXVp
cmsgdGFibGUgd2lsbCBtYWtlIGl0IG1vcmUgcmVhZGFibGUgYW5kIG1haW50YWluYWJsZS4KPj4+
Cj4+PkkgZ3Vlc3MgSSBkaXNhZ3JlZSBhYm91dCB0aGUgbWFpbnRhaW5hYmxlIHBhcnQsIGdpdmVu
IHRoYXQgdGhpcyBwYXRjaAo+Pj5hbHJlYWR5IHJlZ3Jlc3NlcyBCcm9hZHdlbGwgTlRCLgo+Pj4K
Pj4+SSdtIG5vdCBldmVuIHN1cmUgd2hhdCB0aGUgRE1BUiB0YWJsZSBzYXlzIGFib3V0IE5UQiBv
biBteSBTa3lsYWtlCj4+PnN5c3RlbXMsIGV4YWN0bHkgYmVjYXVzZSB0aGUgZXhpc3RpbmcgY29k
ZSBtZWFucyBJIGRpZCBub3QgaGF2ZSBhbnkKPj4+cHJvYmxlbXMuwqAgQnV0IHdlIG1pZ2h0IG5l
ZWQgdG8gYWRkIGRldmljZSAyMDFDaCB0b28uCj4+Pgo+Pj5NYXliZSB3ZSBkb24ndCBuZWVkIHRo
ZSBtaXNtYXRjaCBjaGVjayBhdCBhbGw/wqAgWW91ciBwYXRjaCBzZXRzIHRoZQo+Pj5xdWlyayBp
ZiBhbnkgcG9zc2libHkgbWlzbWF0Y2hpbmcgZGV2aWNlIGlzIHByZXNlbnQgaW4gdGhlIHN5c3Rl
bSwgc28KPj4+d2UnbGwgaWdub3JlIGFueSBzY29wZSBtaXNtYXRjaCBvbiBhIHN5c3RlbSB3aXRo
LCBzYXksIHRoZSA4MDg2OjIwMjAKPj4+TlZNZSBob3N0IGluIGl0LsKgIFNvIGNvdWxkIHdlIGp1
c3QgZHJvcCB0aGUgY2hlY2sgY29tcGxldGVseSBhbmQgbm90Cj4+PmhhdmUgYSBxdWlyayB0byBk
aXNhYmxlIHRoZSBjaGVjaz8KPj4+Cj4+Pi0gUi4KPj4KPj5JZiB0aGUgY2hlY2sgaXMgcmVtb3Zl
ZCB3aGF0IGhhcHBlbnMgZm9yIGNhc2VzIHdoZXJlIHRoZXJlIGlzIGFuIGFjdHVhbAo+PnByb2Js
ZW0gaW4gdGhlIGRtYXIgdGFibGU/IEkganVzdCB3b3JrZWQgYW4gaXNzdWUgd2l0aCBzb21lIElu
dGVsCj4+cGVvcGxlIHdoZXJlIGEgcHVybGV5IHN5c3RlbSBoYWQgYW4gcm1yciBlbnRyeSBwb2lu
dGluZyB0byBhIGJyaWRnZSBhcwo+PnRoZSBlbmRwb2ludCBkZXZpY2UgaW5zdGVhZCBvZiB0aGUg
cmFpZCBtb2R1bGUgc2l0dGluZyBiZWhpbmQgaXQuCj4KPlRoZSBsYXRlc3Qgc29sdXRpb24gd2Fz
IGhlcmUuIGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDIwLzEvNS8xMDMsIGRvZXMKPnRoaXMgd29y
ayBmb3IgeW91Pwo+Cj5CZXN0IHJlZ2FyZHMsCj5iYW9sdQo+CgpIaSBCYW9sdSwKClRoZXkgcmVz
b2x2ZWQgaXQgYnkgdXBkYXRpbmcgdGhlIHJtcnIgZW50cnkgaW4gdGhlIGRtYXIgdGFibGUgdG8g
YWRkCnRoZSBleHRyYSBwYXRoIG5lZWRlZCBmb3IgaXQgdG8gcG9pbnQgYXQgdGhlIHJhaWQgbW9k
dWxlLiBMb29raW5nCmF0IHRoZSBjb2RlIHRob3VnaCBJIGltYWdpbmUgd2l0aG91dCB0aGUgZmly
bXdhcmUgdXBkYXRlIHRoZXkgd291bGQKc3RpbGwgaGF2ZSB0aGUgcHJvYmxlbSBiZWNhdXNlIElJ
UkMgaXQgd2FzIGEgY29tYm8gb2YgYW4gZW5kcG9pbnQKc2NvcGUgdHlwZSwgYW5kIGEgcGNpIGJy
aWRnZSBoZWFkZXIgc28gdGhhdCBmaXJzdCBjaGVjayB3b3VsZCBmYWlsCmFzIGl0IGRpZCBiZWZv
cmUuIE15IHdvcnJ5IHdhcyBpZiB0aGUgc3VnZ2VzdGlvbiBpcyB0byByZW1vdmUgdGhlCmNoZWNr
IGNvbXBsZXRlbHksIGEgY2FzZSBsaWtlIHRoYXQgd291bGRuJ3QgcmVwb3J0IGFueXRoaW5nIHdy
b25nLgoKSmltJ3MgbGF0ZXN0IHBhdGNoIEkgdGhpbmsgc29sdmVzIHRoZSBpc3N1ZSBmb3Igd2hh
dCBoZSB3YXMgc2VlaW5nCmFuZCB0aGUgTlRCIGNhc2UuCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vaW9tbXU=
