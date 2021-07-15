Return-Path: <SRS0=9Lhb=MH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69046C47E48
	for <iommu@archiver.kernel.org>; Thu, 15 Jul 2021 07:39:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1696D61362
	for <iommu@archiver.kernel.org>; Thu, 15 Jul 2021 07:39:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1696D61362
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CDF2883D3F;
	Thu, 15 Jul 2021 07:39:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CoaA7veGHdoQ; Thu, 15 Jul 2021 07:39:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AA2C183C8A;
	Thu, 15 Jul 2021 07:39:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 74BAAC001A;
	Thu, 15 Jul 2021 07:39:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F017AC000E
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 07:39:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D8A6883D04
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 07:39:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NZH6hP4mukA9 for <iommu@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 07:39:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1558083C8A
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 07:39:51 +0000 (UTC)
Received: by mail-lf1-x133.google.com with SMTP id x25so8201962lfu.13
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 00:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=RbV1qy6tsLWfKrDuSsvc9bUACKfeR7Oc9sX7ozt1Vx0=;
 b=DLguvjWEMocTkdw1rblF0HMFSj1ky99nS7jKdXxcdsmfL5WNLppbK2a5L62XX7xpsU
 KEAP2P0+N6TYxa8X5G2v/a6subexhIk6QcKhffawY5rVpEeJ/JFyAFDDI/qo7pK6tVoV
 1pzXW3DX6bVdPzr6qJWa1AOHBSgfnGJKsis9mISoD7CMkttMkkBVJNdIYq+fn3JvACyK
 APZY+c579zDSUj7wTOA7ccCGu6iTZ6wi+hRorumUhXfY4IAMGie4l7IPFSyxOhyota72
 +RyQcWGfyszpsRdPe8UksD/iwFTivOa6I8587sKl68G8gmfoBlR3sQQ/bDG1DqBrps2N
 ZCbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=RbV1qy6tsLWfKrDuSsvc9bUACKfeR7Oc9sX7ozt1Vx0=;
 b=Sy3sauY/R17ClEKICJ95VgwmRPe+TNp4qrXELw80XqoqKLUpR8pBHLHpj+uIzwxrqk
 /qCTiw16tQW7j/aiSo2f6caYzTBD6wBPeH+YkzErto2d9OUT4S/rfPkkmZ3r2P+USXMS
 /adzufxZdmAdNZjmbjMwCPRVfap9qvRDXxv87YThPdKV//vjf7hNoZiHmMnLlMa+rVFI
 wcIbpydp/qVIjfGekYNqzZ9EdPx32giFJGL639eYfIID4v/4xVDJY9fGNiD83ga/8L81
 IJRAtxxWGpHr6AascMEVZQbe3UzYpDuSTJAbSuKXxUKkJ8b4agSLtLV5hmxETvgLNQqN
 1wnw==
X-Gm-Message-State: AOAM532nWIZhDaEs8+E93Tq6lVdhOstbApnoPFHt28RJBmZTmntwaC0C
 eltuj1GY/FqkNXnK3O82uCx25VsPhz42DCoW5K4=
X-Google-Smtp-Source: ABdhPJzctcCKvkmJCdAvVZwAE6A94bEK5hPH90lNgU/YTADVTWx+ppiFHflOJl1Ygu8geOZO+p5upB7wdV/pJibMWgA=
X-Received: by 2002:a19:c1d5:: with SMTP id r204mr2381718lff.594.1626334788911; 
 Thu, 15 Jul 2021 00:39:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210616154436.GA7619@lst.de>
 <20210622133414.132754-1-rm.skakun@gmail.com>
 <YO4si0to/XYximwM@fedora>
In-Reply-To: <YO4si0to/XYximwM@fedora>
From: Roman Skakun <rm.skakun@gmail.com>
Date: Thu, 15 Jul 2021 10:39:38 +0300
Message-ID: <CADu_u-OMx6Pj4DQDoOsdh6aNAzYys-+R=o+OzHYtLm=nECgkyQ@mail.gmail.com>
Subject: Re: [PATCH v2] dma-mapping: use vmalloc_to_page for vmalloc addresses
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Andrii Anisov <andrii_anisov@epam.com>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 linux-kernel@vger.kernel.org,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 iommu@lists.linux-foundation.org, Roman Skakun <roman_skakun@epam.com>,
 xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Volodymyr Babchuk <volodymyr_babchuk@epam.com>
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

PiBUaGlzIGxvb2tzIGxpa2UgaXQgd2Fzbid0IHBpY2tlZCB1cD8gU2hvdWxkIGl0IGdvIGluIHJj
MT8KCkhpLCBLb25yYWQhCgpUaGlzIGxvb2tzIGxpa2UgYW4gdW5hbWJpZ3VvdXMgYnVnLCBhbmQg
c2hvdWxkIGJlIGluIHJjMS4KCkNoZWVycyEKCtGB0YAsIDE0INC40Y7Quy4gMjAyMSDQsy4g0LIg
MDM6MTUsIEtvbnJhZCBSemVzenV0ZWsgV2lsayA8a29ucmFkLndpbGtAb3JhY2xlLmNvbT46Cj4K
PiBPbiBUdWUsIEp1biAyMiwgMjAyMSBhdCAwNDozNDoxNFBNICswMzAwLCBSb21hbiBTa2FrdW4g
d3JvdGU6Cj4gPiBUaGlzIGNvbW1pdCBpcyBkZWRpY2F0ZWQgdG8gZml4IGluY29ycmVjdCBjb252
ZXJzaW9uIGZyb20KPiA+IGNwdV9hZGRyIHRvIHBhZ2UgYWRkcmVzcyBpbiBjYXNlcyB3aGVuIHdl
IGdldCB2aXJ0dWFsCj4gPiBhZGRyZXNzIHdoaWNoIGFsbG9jYXRlZCBpbiB0aGUgdm1hbGxvYyBy
YW5nZS4KPiA+IEFzIHRoZSByZXN1bHQsIHZpcnRfdG9fcGFnZSgpIGNhbm5vdCBjb252ZXJ0IHRo
aXMgYWRkcmVzcwo+ID4gcHJvcGVybHkgYW5kIHJldHVybiBpbmNvcnJlY3QgcGFnZSBhZGRyZXNz
Lgo+ID4KPiA+IE5lZWQgdG8gZGV0ZWN0IHN1Y2ggY2FzZXMgYW5kIG9idGFpbnMgdGhlIHBhZ2Ug
YWRkcmVzcyB1c2luZwo+ID4gdm1hbGxvY190b19wYWdlKCkgaW5zdGVhZC4KPiA+Cj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBSb21hbiBTa2FrdW4gPHJvbWFuX3NrYWt1bkBlcGFtLmNvbT4KPiA+IFJldmll
d2VkLWJ5OiBBbmRyaWkgQW5pc292IDxhbmRyaWlfYW5pc292QGVwYW0uY29tPgo+ID4gLS0tCj4g
PiBIZXkhCj4gPiBUaGFua3MgZm9yIHN1Z2dlc3Rpb25zLCBDaHJpc3RvcGghCj4gPiBJIHVwZGF0
ZWQgdGhlIHBhdGNoIGFjY29yZGluZyB0byB5b3VyIGFkdmljZS4KPiA+IEJ1dCwgSSdtIHNvIHN1
cnByaXNlZCBiZWNhdXNlIG5vYm9keSBjYXRjaGVzIHRoaXMgcHJvYmxlbQo+ID4gaW4gdGhlIGNv
bW1vbiBjb2RlIGJlZm9yZS4gSXQgbG9va3MgYSBiaXQgc3RyYW5nZSBhcyBmb3IgbWUuCj4KPiBU
aGlzIGxvb2tzIGxpa2UgaXQgd2Fzbid0IHBpY2tlZCB1cD8gU2hvdWxkIGl0IGdvIGluIHJjMT8K
PiA+Cj4gPgo+ID4gIGtlcm5lbC9kbWEvb3BzX2hlbHBlcnMuYyB8IDEyICsrKysrKysrKystLQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+ID4K
PiA+IGRpZmYgLS1naXQgYS9rZXJuZWwvZG1hL29wc19oZWxwZXJzLmMgYi9rZXJuZWwvZG1hL29w
c19oZWxwZXJzLmMKPiA+IGluZGV4IDkxMGFlNjljYWU3Ny4uNzgyNzI4ZDhhMzkzIDEwMDY0NAo+
ID4gLS0tIGEva2VybmVsL2RtYS9vcHNfaGVscGVycy5jCj4gPiArKysgYi9rZXJuZWwvZG1hL29w
c19oZWxwZXJzLmMKPiA+IEBAIC01LDYgKzUsMTQgQEAKPiA+ICAgKi8KPiA+ICAjaW5jbHVkZSA8
bGludXgvZG1hLW1hcC1vcHMuaD4KPiA+Cj4gPiArc3RhdGljIHN0cnVjdCBwYWdlICpjcHVfYWRk
cl90b19wYWdlKHZvaWQgKmNwdV9hZGRyKQo+ID4gK3sKPiA+ICsgICAgIGlmIChpc192bWFsbG9j
X2FkZHIoY3B1X2FkZHIpKQo+ID4gKyAgICAgICAgICAgICByZXR1cm4gdm1hbGxvY190b19wYWdl
KGNwdV9hZGRyKTsKPiA+ICsgICAgIGVsc2UKPiA+ICsgICAgICAgICAgICAgcmV0dXJuIHZpcnRf
dG9fcGFnZShjcHVfYWRkcik7Cj4gPiArfQo+ID4gKwo+ID4gIC8qCj4gPiAgICogQ3JlYXRlIHNj
YXR0ZXItbGlzdCBmb3IgdGhlIGFscmVhZHkgYWxsb2NhdGVkIERNQSBidWZmZXIuCj4gPiAgICov
Cj4gPiBAQCAtMTIsNyArMjAsNyBAQCBpbnQgZG1hX2NvbW1vbl9nZXRfc2d0YWJsZShzdHJ1Y3Qg
ZGV2aWNlICpkZXYsIHN0cnVjdCBzZ190YWJsZSAqc2d0LAo+ID4gICAgICAgICAgICAgICAgdm9p
ZCAqY3B1X2FkZHIsIGRtYV9hZGRyX3QgZG1hX2FkZHIsIHNpemVfdCBzaXplLAo+ID4gICAgICAg
ICAgICAgICAgdW5zaWduZWQgbG9uZyBhdHRycykKPiA+ICB7Cj4gPiAtICAgICBzdHJ1Y3QgcGFn
ZSAqcGFnZSA9IHZpcnRfdG9fcGFnZShjcHVfYWRkcik7Cj4gPiArICAgICBzdHJ1Y3QgcGFnZSAq
cGFnZSA9IGNwdV9hZGRyX3RvX3BhZ2UoY3B1X2FkZHIpOwo+ID4gICAgICAgaW50IHJldDsKPiA+
Cj4gPiAgICAgICByZXQgPSBzZ19hbGxvY190YWJsZShzZ3QsIDEsIEdGUF9LRVJORUwpOwo+ID4g
QEAgLTQzLDcgKzUxLDcgQEAgaW50IGRtYV9jb21tb25fbW1hcChzdHJ1Y3QgZGV2aWNlICpkZXYs
IHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hLAo+ID4gICAgICAgICAgICAgICByZXR1cm4gLUVO
WElPOwo+ID4KPiA+ICAgICAgIHJldHVybiByZW1hcF9wZm5fcmFuZ2Uodm1hLCB2bWEtPnZtX3N0
YXJ0LAo+ID4gLSAgICAgICAgICAgICAgICAgICAgIHBhZ2VfdG9fcGZuKHZpcnRfdG9fcGFnZShj
cHVfYWRkcikpICsgdm1hLT52bV9wZ29mZiwKPiA+ICsgICAgICAgICAgICAgICAgICAgICBwYWdl
X3RvX3BmbihjcHVfYWRkcl90b19wYWdlKGNwdV9hZGRyKSkgKyB2bWEtPnZtX3Bnb2ZmLAo+ID4g
ICAgICAgICAgICAgICAgICAgICAgIHVzZXJfY291bnQgPDwgUEFHRV9TSElGVCwgdm1hLT52bV9w
YWdlX3Byb3QpOwo+ID4gICNlbHNlCj4gPiAgICAgICByZXR1cm4gLUVOWElPOwo+ID4gLS0KPiA+
IDIuMjUuMQo+ID4KCgoKLS0gCkJlc3QgUmVnYXJkcywgUm9tYW4uCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
