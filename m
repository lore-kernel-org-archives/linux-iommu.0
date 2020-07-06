Return-Path: <SRS0=S+y3=AR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C7DC433E3
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 23:18:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 760752073E
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 23:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTaYqMbL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 760752073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5F542894BE;
	Mon,  6 Jul 2020 23:18:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7WLYE7XkBcHB; Mon,  6 Jul 2020 23:18:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id BD328894B2;
	Mon,  6 Jul 2020 23:18:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3824C0893;
	Mon,  6 Jul 2020 23:18:52 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 76343C016F
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 23:18:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 64892894BE
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 23:18:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OgJd2-fGKQuY for <iommu@lists.linux-foundation.org>;
 Mon,  6 Jul 2020 23:18:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 91B2A894B2
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 23:18:50 +0000 (UTC)
Received: from localhost (mobile-166-175-191-139.mycingular.net
 [166.175.191.139])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EDBE2205CB;
 Mon,  6 Jul 2020 23:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594077530;
 bh=yaC/st+ngw5Sh4IXqu2ErvTyb0SMPwfqL4dOJPo6D3A=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=bTaYqMbL88uMK3kvbCJf8qkcSU110j4Hlc2k73yEmfzzHiYvXa2NP6Y8ZNfRQpwnL
 6drEEsZORiBloqcgUry8kQyZyf+NHp/oae19Zl6eTDHDBmy9NhZPRPypZBMK6qUGx6
 x6sqtPhq85bUfdqMeYAhV6p248TsOWw60IZQN4fo=
Date: Mon, 6 Jul 2020 18:18:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v2 1/7] PCI: Keep the ACS capability offset in device
Message-ID: <20200706231844.GA168946@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACK8Z6GtOH4o6J17YXnesf0VvQSQRTCR011RRD2U7gkrwA8ziQ@mail.gmail.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gTW9uLCBKdWwgMDYsIDIwMjAgYXQgMDM6MTY6NDJQTSAtMDcwMCwgUmFqYXQgSmFpbiB3cm90
ZToKPiBPbiBNb24sIEp1bCA2LCAyMDIwIGF0IDg6NTggQU0gQmpvcm4gSGVsZ2FhcyA8aGVsZ2Fh
c0BrZXJuZWwub3JnPiB3cm90ZToKPiA+IE9uIE1vbiwgSnVuIDI5LCAyMDIwIGF0IDA5OjQ5OjM3
UE0gLTA3MDAsIFJhamF0IEphaW4gd3JvdGU6Cgo+ID4gPiArc3RhdGljIHZvaWQgcGNpX2VuYWJs
ZV9hY3Moc3RydWN0IHBjaV9kZXYgKmRldik7Cj4gPgo+ID4gSSBkb24ndCB0aGluayB3ZSBuZWVk
IHRoaXMgZm9yd2FyZCBkZWNsYXJhdGlvbiwgZG8gd2U/Cj4gCj4gV2UgbmVlZCBpdCB1bmxlc3Mg
d2UgbW92ZSBpdHMgZGVmaW5pdGlvbiBmdXJ0aGVyIHVwIGluIHRoZSBmaWxlOgo+IAo+IGRyaXZl
cnMvcGNpL3BjaS5jOiBJbiBmdW5jdGlvbiDigJhwY2lfcmVzdG9yZV9zdGF0ZeKAmToKPiBkcml2
ZXJzL3BjaS9wY2kuYzoxNTUxOjI6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5j
dGlvbgo+IOKAmHBjaV9lbmFibGVfYWNz4oCZOyBkaWQgeW91IG1lYW4g4oCYcGNpX2VuYWJsZV9h
dHPigJk/Cj4gWy1XZXJyb3I9aW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dCj4gIDE1NTEg
fCAgcGNpX2VuYWJsZV9hY3MoZGV2KTsKPiAKPiBEbyB5b3Ugd2FudCBtZSB0byBtb3ZlIGl0IHVw
IGluIHRoZSBmaWxlIHNvIHRoYXQgd2UgZG8gbm90IG5lZWQgdGhlCj4gZm9yd2FyZCBkZWNsYXJh
dGlvbj8KClllcywgcGxlYXNlIG1vdmUgaXQuICBNYXliZSBhIHByZWxpbWluYXJ5IHBhdGNoIHRo
YXQgbW92ZXMgaXQgYnV0CmRvZXNuJ3QgY2hhbmdlIGFueXRoaW5nIGVsc2UuCgpJIHRoaW5rIEkg
dGhvdWdodCB5b3UgaGFkIHJlbmFtZWQgdGhlIGZ1bmN0aW9uLCBpbiB3aGljaCBjYXNlIHlvdQpj
b3VsZCB0ZWxsIGZyb20gdGhlIHBhdGNoIGl0c2VsZi4gIEJ1dCBJIHdhcyBtaXN0YWtlbiEKCj4g
PiA+IEBAIC00NjUzLDcgKzQ2NTMsNyBAQCBzdGF0aWMgaW50IHBjaV9xdWlya19pbnRlbF9zcHRf
cGNoX2FjcyhzdHJ1Y3QgcGNpX2RldiAqZGV2LCB1MTYgYWNzX2ZsYWdzKQo+ID4gPiAgICAgICBp
ZiAoIXBjaV9xdWlya19pbnRlbF9zcHRfcGNoX2Fjc19tYXRjaChkZXYpKQo+ID4gPiAgICAgICAg
ICAgICAgIHJldHVybiAtRU5PVFRZOwo+ID4gPgo+ID4gPiAtICAgICBwb3MgPSBwY2lfZmluZF9l
eHRfY2FwYWJpbGl0eShkZXYsIFBDSV9FWFRfQ0FQX0lEX0FDUyk7Cj4gPiA+ICsgICAgIHBvcyA9
IGRldi0+YWNzX2NhcDsKPiA+Cj4gPiBJIGFzc3VtZSB5b3UgdmVyaWZpZWQgdGhhdCBhbGwgdGhl
c2UgcXVpcmtzIGFyZSBGSU5BTCBxdWlya3MsIHNpbmNlCj4gPiBwY2lfaW5pdF9jYXBhYmlsaXRp
ZXMoKSBpcyBjYWxsZWQgYWZ0ZXIgSEVBREVSIHF1aXJrcy4gIEknbGwKPiA+IGRvdWJsZS1jaGVj
ayBiZWZvcmUgYXBwbHlpbmcgdGhpcy4KPiAKPiBOb25lIG9mIHRoZXNlIHF1aXJrcyBhcmUgYXBw
bGllZCB2aWEgREVDTEFSRV9QQ0lfRklYVVBfKigpLiBBbGwgdGhlc2UKPiBxdWlya3MgYXJlIGNh
bGxlZCAoZGlyZWN0bHkgb3IgaW5kaXJlY3RseSkgZnJvbSBlaXRoZXIKPiBwY2lfZW5hYmxlX2Fj
cygpIG9yIHBjaV9hY3NfZW5hYmxlZCgpLAo+IAo+IEVYQ0VQVAo+IAo+IHBjaV9pZHRfYnVzX3F1
aXJrKCkuIFRoYXQgb25lIGlzIGNhbGxlZCBmcm9tCj4gcGNpX2J1c19yZWFkX2Rldl92ZW5kb3Jf
aWQoKSB3aGljaCBzaG91bGQgYmUgY2FsbGVkIG9ubHkgYWZ0ZXIgdGhlCj4gcGFyZW50IGJyaWRn
ZSBoYXMgYmVlbiBhZGRlZCBhbmQgc2V0dXAgY29ycmVjdGx5Lgo+IAo+IFNvIGl0IGxvb2tzIGFs
bCBnb29kIHRvIG1lLgoKR3JlYXQsIHRoYW5rcyBmb3IgY2hlY2tpbmcgdGhhdC4KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0
CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
