Return-Path: <SRS0=nHvM=OY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA5FC433EF
	for <iommu@archiver.kernel.org>; Mon,  4 Oct 2021 20:32:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFDF461165
	for <iommu@archiver.kernel.org>; Mon,  4 Oct 2021 20:32:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AFDF461165
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6760640594;
	Mon,  4 Oct 2021 20:32:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WEvtChVNTROZ; Mon,  4 Oct 2021 20:32:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 39C664056A;
	Mon,  4 Oct 2021 20:32:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0E420C000F;
	Mon,  4 Oct 2021 20:32:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A3EFC000D
 for <iommu@lists.linux-foundation.org>; Mon,  4 Oct 2021 20:32:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ED00040595
 for <iommu@lists.linux-foundation.org>; Mon,  4 Oct 2021 20:32:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P86RVdfwLn_h for <iommu@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 20:32:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A655E4056A
 for <iommu@lists.linux-foundation.org>; Mon,  4 Oct 2021 20:32:20 +0000 (UTC)
Received: by mail-lf1-x134.google.com with SMTP id m3so75881955lfu.2
 for <iommu@lists.linux-foundation.org>; Mon, 04 Oct 2021 13:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=9++LVbb1ZgVmL4thX9K4PQNAQ2NBkN+QYbEP+4ptnH4=;
 b=V84IwbKWTotGIBqNXF2nkUgsADhmRFOGZVunhqZTJ6RtYtB8Z/FiCkaFAxjv3zjmuw
 YXHgph8NGFOvN+GpVeQ1Vcyytw/Kcdded/YAu3rr4U4T6P/A1E8HL4DxrQ4Zfszva0lX
 OYgZ2ZlBiCWJ0NBV6AW6F/y8SK44ZtO+lIj+42T6O9fAb3vJiH2HH6Mhv6quyEx+497l
 eVJAniwQmeIxG6Kv7JS6oZaYeixGmXQwuU0cXWahQ5VUNhvAQd4w9smpv9c/JlqJITHD
 /Xs2LX2tj+2thofc8yzrLgBed7Wpds8pym2PHbUcw2Q7LzsjTVCGzAI6WNkTf06xNqrh
 rIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9++LVbb1ZgVmL4thX9K4PQNAQ2NBkN+QYbEP+4ptnH4=;
 b=uDJqAkdWhkNhnb6Og6y4Qsfz3auAFWI4PETSInnZF8TUipv88ehgx474G39gxZ0Yht
 INPp6UTuaAVhiWBn76a9NRS7L6Ym10UtMTHjLHmoRzJK3emEJ1ifHrnlAhsaTHWpq1vO
 OzqMBfWMCCNTpkgvhLUCQuyN69CceLajBiwyD2VtZhhNkKtT0JBeiQlDMkZBmMtk9iS8
 ssOFoOiexwNN2Hh6q+WRnPKA2ohKwnrtnHXTeuHpYYuSy/MTVp+Hc5IEh8JoXcxasyhN
 kKYXzCyRigFA7auHBntVbhdqeX+63mwepOs3XSIjuCU+fJ+kDYjiu9JD2IxiRY7BLJCW
 vGyg==
X-Gm-Message-State: AOAM533LCHu5cVG7lzlYb9M4cTI09PZX+nPFpPlTJRiLK5IhYZ3ExIn3
 KNvV+5EmcMa6xaWr1QzUsx8=
X-Google-Smtp-Source: ABdhPJy1IMBj+UoXvSNdaYO2FdaApa8G9+VkflvO9WSPaNeDF1mm5hubzT+oIwR97eBUaJ3C9BWfSw==
X-Received: by 2002:a19:4344:: with SMTP id m4mr15742299lfj.155.1633379538372; 
 Mon, 04 Oct 2021 13:32:18 -0700 (PDT)
Received: from [192.168.2.145] (79-139-163-57.dynamic.spd-mgts.ru.
 [79.139.163.57])
 by smtp.googlemail.com with ESMTPSA id j12sm756247lfk.246.2021.10.04.13.32.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Oct 2021 13:32:18 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] iommu: Support identity mappings of
 reserved-memory regions
To: Thierry Reding <thierry.reding@gmail.com>
References: <20210423163234.3651547-1-thierry.reding@gmail.com>
 <95e4c23e-4700-ef7e-d8ae-17693b65e121@gmail.com>
 <YVtUrTdI9kUSScui@orome.fritz.box>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <4f1fadc7-119e-0fad-f597-0cea99cd9095@gmail.com>
Date: Mon, 4 Oct 2021 23:32:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YVtUrTdI9kUSScui@orome.fritz.box>
Content-Language: en-US
Cc: devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-tegra@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>
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

MDQuMTAuMjAyMSAyMjoyMywgVGhpZXJyeSBSZWRpbmcg0L/QuNGI0LXRgjoKPiBPbiBTdW4sIE9j
dCAwMywgMjAyMSBhdCAwNDowOTo1NkFNICswMzAwLCBEbWl0cnkgT3NpcGVua28gd3JvdGU6Cj4+
IDIzLjA0LjIwMjEgMTk6MzIsIFRoaWVycnkgUmVkaW5nINC/0LjRiNC10YI6Cj4+PiBJJ3ZlIG1h
ZGUgY29ycmVzcG9uZGluZyBjaGFuZ2VzIGluIHRoZSBwcm9wcmlldGFyeSBib290bG9hZGVyLCBh
ZGRlZCBhCj4+PiBjb21wYXRpYmlsaXR5IHNoaW0gaW4gVS1Cb290ICh3aGljaCBmb3J3YXJkcyBp
bmZvcm1hdGlvbiBjcmVhdGVkIGJ5IHRoZQo+Pj4gcHJvcHJpZXRhcnkgYm9vdGxvYWRlciB0byB0
aGUga2VybmVsKSBhbmQgdGhlIGF0dGFjaGVkIHBhdGNoZXMgdG8gdGVzdAo+Pj4gdGhpcyBvbiBK
ZXRzb24gVFgxLCBKZXRzb24gVFgyIGFuZCBKZXRzb24gQUdYIFhhdmllci4KPj4KPj4gQ291bGQg
eW91IHBsZWFzZSB0ZWxsIHdoYXQgZG93bnN0cmVhbSBrZXJuZWwgZG9lcyBmb3IgY29waW5nIHdp
dGggdGhlCj4+IGlkZW50aXR5IG1hcHBpbmdzIGluIGNvbmp1bmN0aW9uIHdpdGggdGhlIG9yaWdp
bmFsIHByb3ByaWV0YXJ5IGJvb3Rsb2FkZXI/Cj4+Cj4+IElmIHRoZXJlIGlzIHNvbWUgb3RoZXIg
bWV0aG9kIG9mIHBhc3NpbmcgbWFwcGluZ3MgdG8ga2VybmVsLCBjb3VsZCBpdCBiZQo+PiBzdXBw
b3J0ZWQgYnkgdXBzdHJlYW0/IFB1dHRpbmcgYnVyZGVuIG9uIHVzZXJzIHRvIHVwZ3JhZGUgYm9v
dGxvYWRlcgo+PiBmZWVscyBhIGJpdCBpbmNvbnZlbmllbnQuCj4gCj4gSXQgZGVwZW5kcyBvbiB0
aGUgY2hpcCBnZW5lcmF0aW9uLiBBcyBmYXIgYXMgSSBrbm93IHRoZXJlIGhhdmUgYmVlbgo+IHNl
dmVyYWwgaXRlcmF0aW9ucy4gVGhlIGVhcmxpZXN0IHdhcyB0byBwYXNzIHRoaXMgaW5mb3JtYXRp
b24gdmlhIGEKPiBjb21tYW5kLWxpbmUgb3B0aW9uLCBidXQgbW9yZSByZWNlbnQgdmVyc2lvbnMg
dXNlIGRldmljZSB0cmVlIHRvIHBhc3MKPiB0aGlzIGluZm9ybWF0aW9uIGluIGEgc2ltaWxhciB3
YXkgYXMgZGVzY3JpYmVkIGhlcmUuIEhvd2V2ZXIsIHRoZXNlCj4gdXNlIG5vbi1zdGFuZGFyZCBE
VCBiaW5kaW5ncywgc28gSSBkb24ndCB0aGluayB3ZSBjYW4ganVzdCBpbXBsZW1lbnQKPiB0aGVt
IGFzLWlzLgoKSXMgaXQgcG9zc2libGUgdG8gYm9vdCB1cHN0cmVhbSBrZXJuZWwgd2l0aCB0aGF0
IG9yaWdpbmFsIGJvb3Rsb2FkZXI/CgpJIHJlbWVtYmVyIHNlZWluZyBvdGhlciBwbGF0Zm9ybXMs
IGxpa2UgUUNPTSwgc3VwcG9ydGluZyBkb3duc3RyZWFtCnF1aXJrcyBpbiB1cHN0cmVhbSBrZXJu
ZWwgb24gYSBzaWRlLCBpLmUuIHRoZXkgYXJlIHVuZG9jdW1lbnRlZCwgYnV0IHRoZQphZGRpdGlv
bmFsIHN1cHBvcnQgY29kZSBpcyB0aGVyZS4gVGhhdCBpcyB3aGF0ICJub3JtYWwiIHBlb3BsZSB3
YW50LiBZb3UKc2hvdWxkIGNvbnNpZGVyIGRvaW5nIHRoYXQgZm9yIFRlZ3JhIHRvbywgaWYgcG9z
c2libGUuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlv
bW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
