Return-Path: <SRS0=S+y3=AR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7EBC433E1
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 22:17:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0381E20720
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 22:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="vNzVRDUl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0381E20720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D13E786C8C;
	Mon,  6 Jul 2020 22:17:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xMsV3eL96EuE; Mon,  6 Jul 2020 22:17:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B807486B9E;
	Mon,  6 Jul 2020 22:17:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A9237C0891;
	Mon,  6 Jul 2020 22:17:23 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7019C016F
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 22:17:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 932C486C15
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 22:17:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LQyAOPW04r-f for <iommu@lists.linux-foundation.org>;
 Mon,  6 Jul 2020 22:17:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com
 [209.85.167.68])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id BA59186B9E
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 22:17:21 +0000 (UTC)
Received: by mail-lf1-f68.google.com with SMTP id s16so18119013lfp.12
 for <iommu@lists.linux-foundation.org>; Mon, 06 Jul 2020 15:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=VcTg7znjs5NM9gvezTd2PmxFMdpOTVCMT/3yPB+Qgb4=;
 b=vNzVRDUl4U537XT+jFySQw2TYQYIYbNVvMi2vI75OS8G/oHkzYqETbWDdsyWrqnJvB
 ZDagRVkHhKD8zrtLYJJ8qIXo0AuuWaJckY5WFye6ln6rpJlD+AplVS4Ho5fxKhazVYd+
 WwNgl/fOyzqH2mIWWEgJom7RS2Ys5J/RcL078JbEZFoB+AoMeXlDAL/+dvD25aT6hP7g
 cRY8zFElRYhBxqOzi9A+D7S29ctaddBPIC5OT/Ic4cekOp6Ldlh3Lmc0aMJePc/BbAgT
 305sc89OsH87ksxbW1okc8uaJtthTw6avN9JtPmDdA9CbRbhBy4vF/SiokD2ssfDaKPU
 KjfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=VcTg7znjs5NM9gvezTd2PmxFMdpOTVCMT/3yPB+Qgb4=;
 b=cUbxeStXas4cxeZVdiNUj7FLsmjcZoSI6eUz8T0wmogTOeEWSyxSa/nJRdLsbVQaEL
 3i/VLb1cWbusCJFFdccZ3f/H48N2eDPkcnB0uW3tQEZshZA8SmSxxqOzt4OI2JogBGJA
 9oUdvB/LjyseLjKgfgG7i0q0pTDMVeSPL1WOW4e0YIlgJyyZAS1qnELP2EdJlK1Y/X4w
 nMV30o2hnfaWKMpwyT6tJrJVDBjnQ6CjjnsQEI1FLh8cUZcWa+Mzkc2faxXSSlihZTIz
 R/uAen1ZioFCK2LyruF2ML0heZMCf1WaYPW1g8ga9A8rAclrbES/JGX2mYzU3VVBwz0H
 TV0A==
X-Gm-Message-State: AOAM530Xk0R//D1w7WmT8MZ8k/rzw4K2CSuxmXdBZi5ADX5av+3sxj5t
 PYlK2hjpFAV+6IvllPcmu0tbK6jv4AJ9G+ttQUrFXQ==
X-Google-Smtp-Source: ABdhPJwe3ex8kcVRA0T8G22gfsoP7JF+/rquu8J+b6ju8abD2HlCAo8f1V+eED2pMxSAfWVXjFqnh6BvhytT/R+z9+8=
X-Received: by 2002:a19:435b:: with SMTP id m27mr31417703lfj.40.1594073839263; 
 Mon, 06 Jul 2020 15:17:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200630044943.3425049-2-rajatja@google.com>
 <20200706155815.GA119406@bjorn-Precision-5520>
In-Reply-To: <20200706155815.GA119406@bjorn-Precision-5520>
Date: Mon, 6 Jul 2020 15:16:42 -0700
Message-ID: <CACK8Z6GtOH4o6J17YXnesf0VvQSQRTCR011RRD2U7gkrwA8ziQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] PCI: Keep the ACS capability offset in device
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Todd Broch <tbroch@google.com>, linux-pci <linux-pci@vger.kernel.org>,
 "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Diego Rivas <diegorivas@google.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Furquan Shaikh <furquan@google.com>, Raj Ashok <ashok.raj@intel.com>,
 Saravana Kannan <saravanak@google.com>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Christian Kellner <christian@kellner.me>,
 Mattias Nissler <mnissler@google.com>, Jesse Barnes <jsbarnes@google.com>,
 Len Brown <lenb@kernel.org>, Rajat Jain <rajatxjain@gmail.com>,
 Prashant Malani <pmalani@google.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Aaron Durbin <adurbin@google.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Bernie Keany <bernie.keany@intel.com>, Duncan Laurie <dlaurie@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:AMD IOMMU \(AMD-VI\)" <iommu@lists.linux-foundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Oliver O'Halloran <oohall@gmail.com>,
 Benson Leung <bleung@google.com>, David Woodhouse <dwmw2@infradead.org>,
 Alex Levin <levinale@google.com>
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
From: Rajat Jain via iommu <iommu@lists.linux-foundation.org>
Reply-To: Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

SGkgQmpvcm4sCgpUaGFua3MgZm9yIHRha2luZyBhIGxvb2suCgpPbiBNb24sIEp1bCA2LCAyMDIw
IGF0IDg6NTggQU0gQmpvcm4gSGVsZ2FhcyA8aGVsZ2Fhc0BrZXJuZWwub3JnPiB3cm90ZToKPgo+
IE9uIE1vbiwgSnVuIDI5LCAyMDIwIGF0IDA5OjQ5OjM3UE0gLTA3MDAsIFJhamF0IEphaW4gd3Jv
dGU6Cj4gPiBDdXJyZW50bHkgdGhpcyBpcyBiZWluZyBsb29rZWQgdXAgYXQgYSBudW1iZXIgb2Yg
cGxhY2VzLiBSZWFkIGFuZCBzdG9yZSBpdAo+ID4gb25jZSBhdCBib290dXAgc28gdGhhdCBpdCBj
YW4gYmUgdXNlZCBieSBhbGwgbGF0ZXIuCj4KPiBXcml0ZSB0aGUgY29tbWl0IGxvZyBzbyBpdCBp
cyBjb21wbGV0ZSBldmVuIHdpdGhvdXQgdGhlIHN1YmplY3QuCj4gUmlnaHQgbm93LCB5b3UgaGF2
ZSB0byByZWFkIHRoZSBzdWJqZWN0IHRvIGtub3cgd2hhdCAidGhpcyIgcmVmZXJzIHRvLgo+Cj4g
VGhlIHN1YmplY3QgaXMgbGlrZSB0aGUgdGl0bGU7IHRoZSBsb2cgaXMgbGlrZSB0aGUgYm9keSBv
ZiBhbiBhcnRpY2xlLgo+IFRoZSB0aXRsZSBpc24ndCAqcGFydCogb2YgdGhlIGFydGljbGUsIHNv
IHRoZSBhcnRpY2xlIGhhcyB0byBtYWtlCj4gc2Vuc2UgYWxsIGJ5IGl0c2VsZi4KCkZpeGVkLgoK
Pgo+ID4gK3N0YXRpYyB2b2lkIHBjaV9lbmFibGVfYWNzKHN0cnVjdCBwY2lfZGV2ICpkZXYpOwo+
Cj4gSSBkb24ndCB0aGluayB3ZSBuZWVkIHRoaXMgZm9yd2FyZCBkZWNsYXJhdGlvbiwgZG8gd2U/
CgpXZSBuZWVkIGl0IHVubGVzcyB3ZSBtb3ZlIGl0cyBkZWZpbml0aW9uIGZ1cnRoZXIgdXAgaW4g
dGhlIGZpbGU6Cgpkcml2ZXJzL3BjaS9wY2kuYzogSW4gZnVuY3Rpb24g4oCYcGNpX3Jlc3RvcmVf
c3RhdGXigJk6CmRyaXZlcnMvcGNpL3BjaS5jOjE1NTE6MjogZXJyb3I6IGltcGxpY2l0IGRlY2xh
cmF0aW9uIG9mIGZ1bmN0aW9uCuKAmHBjaV9lbmFibGVfYWNz4oCZOyBkaWQgeW91IG1lYW4g4oCY
cGNpX2VuYWJsZV9hdHPigJk/ClstV2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9u
XQogMTU1MSB8ICBwY2lfZW5hYmxlX2FjcyhkZXYpOwoKRG8geW91IHdhbnQgbWUgdG8gbW92ZSBp
dCB1cCBpbiB0aGUgZmlsZSBzbyB0aGF0IHdlIGRvIG5vdCBuZWVkIHRoZQpmb3J3YXJkIGRlY2xh
cmF0aW9uPwoKPgo+ID4gQEAgLTQ2NTMsNyArNDY1Myw3IEBAIHN0YXRpYyBpbnQgcGNpX3F1aXJr
X2ludGVsX3NwdF9wY2hfYWNzKHN0cnVjdCBwY2lfZGV2ICpkZXYsIHUxNiBhY3NfZmxhZ3MpCj4g
PiAgICAgICBpZiAoIXBjaV9xdWlya19pbnRlbF9zcHRfcGNoX2Fjc19tYXRjaChkZXYpKQo+ID4g
ICAgICAgICAgICAgICByZXR1cm4gLUVOT1RUWTsKPiA+Cj4gPiAtICAgICBwb3MgPSBwY2lfZmlu
ZF9leHRfY2FwYWJpbGl0eShkZXYsIFBDSV9FWFRfQ0FQX0lEX0FDUyk7Cj4gPiArICAgICBwb3Mg
PSBkZXYtPmFjc19jYXA7Cj4KPiBJIGFzc3VtZSB5b3UgdmVyaWZpZWQgdGhhdCBhbGwgdGhlc2Ug
cXVpcmtzIGFyZSBGSU5BTCBxdWlya3MsIHNpbmNlCj4gcGNpX2luaXRfY2FwYWJpbGl0aWVzKCkg
aXMgY2FsbGVkIGFmdGVyIEhFQURFUiBxdWlya3MuICBJJ2xsCj4gZG91YmxlLWNoZWNrIGJlZm9y
ZSBhcHBseWluZyB0aGlzLgoKTm9uZSBvZiB0aGVzZSBxdWlya3MgYXJlIGFwcGxpZWQgdmlhIERF
Q0xBUkVfUENJX0ZJWFVQXyooKS4gQWxsIHRoZXNlCnF1aXJrcyBhcmUgY2FsbGVkIChkaXJlY3Rs
eSBvciBpbmRpcmVjdGx5KSBmcm9tIGVpdGhlcgpwY2lfZW5hYmxlX2FjcygpIG9yIHBjaV9hY3Nf
ZW5hYmxlZCgpLAoKRVhDRVBUCgpwY2lfaWR0X2J1c19xdWlyaygpLiBUaGF0IG9uZSBpcyBjYWxs
ZWQgZnJvbQpwY2lfYnVzX3JlYWRfZGV2X3ZlbmRvcl9pZCgpIHdoaWNoIHNob3VsZCBiZSBjYWxs
ZWQgb25seSBhZnRlciB0aGUKcGFyZW50IGJyaWRnZSBoYXMgYmVlbiBhZGRlZCBhbmQgc2V0dXAg
Y29ycmVjdGx5LgoKU28gaXQgbG9va3MgYWxsIGdvb2QgdG8gbWUuCgpUaGFua3MsCgpSYWphdAoK
Cgo+Cj4gQmpvcm4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
