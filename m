Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A492EC4332F
	for <iommu@archiver.kernel.org>; Fri, 10 Dec 2021 22:19:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 67A0961B4A;
	Fri, 10 Dec 2021 22:19:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lCyJpfAQq8Pe; Fri, 10 Dec 2021 22:19:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 558A561B4D;
	Fri, 10 Dec 2021 22:19:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 318EBC0071;
	Fri, 10 Dec 2021 22:19:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 394E0C0072
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 22:19:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 353B961B4A
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 22:19:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tZSaDmYI2zQO for <iommu@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 22:19:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4F42561B60
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 22:19:24 +0000 (UTC)
Message-ID: <20211210221814.720998720@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1639174762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=Y/E/KkLUpd9rNPfDA/zqSwkvkNwtu0uG/q7moMbC6t8=;
 b=Q1loFyA5IlQ3aytzC+w8agXNpV+7qVzWLLt7gFAxD1uipRckq4A63ZDFlRGCLHiD1WXBCo
 w0KWYnAWbGzEZr/4SWaOTeEwWKw1e6hopGrKVSpqVp8bGWUD/cv86yFjYBjUcnEWdvHY3D
 rgx+tAv/GXM3Dr6QCsae7PjKT265v4cKhrWCbRIUXyRZCJMPv6JLxGPJrWrAjiLYk/CNRO
 jYnVtNkau0JyAHELKfNmrLSzDJz7ygURO1IyC5xhunTeJMWngrOu1RR1+HfWrbASO2qYnr
 hwv0O1X8uqWQklUq1DIP73U0V3zNDPJE2TlYjxuEWKoOXEF+hR4iuFZes26TAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1639174762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=Y/E/KkLUpd9rNPfDA/zqSwkvkNwtu0uG/q7moMbC6t8=;
 b=6NW6+PSI7SpPEo0Bw1CpABwRumr4UbWMvCiNUQ1PxVZXboG1DTempdK99XRytho0lXor9m
 bf7Awa33UAb9FuCg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V3 25/35] powerpc/pseries/msi: Let core code check for
 contiguous entries
References: <20211210221642.869015045@linutronix.de>
MIME-Version: 1.0
Date: Fri, 10 Dec 2021 23:19:22 +0100 (CET)
Cc: Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>,
 Stuart Yoder <stuyoder@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Jassi Brar <jassisinghbrar@gmail.com>,
 Sinan Kaya <okaya@kernel.org>, iommu@lists.linux-foundation.org,
 Peter Ujfalusi <peter.ujfalusi@gmail.com>, Bjorn Helgaas <helgaas@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Jason Gunthorpe <jgg@nvidia.com>,
 linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
 Kevin Tian <kevin.tian@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Robin Murphy <robin.murphy@arm.com>,
 Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater <clg@kaod.org>,
 Santosh Shilimkar <ssantosh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Megha Dey <megha.dey@intel.com>, Juergen Gross <jgross@suse.com>,
 Tero Kristo <kristo@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vkoul@kernel.org>,
 Marc Zygnier <maz@kernel.org>, dmaengine@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
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

RnJvbTogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+CgpTZXQgdGhlIGRvbWFp
biBpbmZvIGZsYWcgYW5kIHJlbW92ZSB0aGUgY2hlY2suCgpTaWduZWQtb2ZmLWJ5OiBUaG9tYXMg
R2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4KUmV2aWV3ZWQtYnk6IEdyZWcgS3JvYWgtSGFy
dG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+CkNjOiBNaWNoYWVsIEVsbGVybWFuIDxt
cGVAZWxsZXJtYW4uaWQuYXU+CkNjOiBCZW5qYW1pbiBIZXJyZW5zY2htaWR0IDxiZW5oQGtlcm5l
bC5jcmFzaGluZy5vcmc+CkNjOiAiQ8OpZHJpYyBMZSBHb2F0ZXIiIDxjbGdAa2FvZC5vcmc+CkNj
OiBsaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZwoKLS0tClYyOiBSZW1vdmUgaXQgY29tcGxl
dGVseSAtIENlZHJpYwotLS0KIGFyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvcHNlcmllcy9tc2kuYyB8
ICAgMzMgKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwg
OCBpbnNlcnRpb25zKCspLCAyNSBkZWxldGlvbnMoLSkKCi0tLSBhL2FyY2gvcG93ZXJwYy9wbGF0
Zm9ybXMvcHNlcmllcy9tc2kuYworKysgYi9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zL3BzZXJpZXMv
bXNpLmMKQEAgLTMyMSwyNyArMzIxLDYgQEAgc3RhdGljIGludCBtc2lfcXVvdGFfZm9yX2Rldmlj
ZShzdHJ1Y3QgcAogCXJldHVybiByZXF1ZXN0OwogfQogCi1zdGF0aWMgaW50IGNoZWNrX21zaXhf
ZW50cmllcyhzdHJ1Y3QgcGNpX2RldiAqcGRldikKLXsKLQlzdHJ1Y3QgbXNpX2Rlc2MgKmVudHJ5
OwotCWludCBleHBlY3RlZDsKLQotCS8qIFRoZXJlJ3Mgbm8gd2F5IGZvciB1cyB0byBleHByZXNz
IHRvIGZpcm13YXJlIHRoYXQgd2Ugd2FudAotCSAqIGEgZGlzY29udGlndW91cywgb3Igbm9uLXpl
cm8gYmFzZWQsIHJhbmdlIG9mIE1TSS1YIGVudHJpZXMuCi0JICogU28gd2UgbXVzdCByZWplY3Qg
c3VjaCByZXF1ZXN0cy4gKi8KLQotCWV4cGVjdGVkID0gMDsKLQlmb3JfZWFjaF9wY2lfbXNpX2Vu
dHJ5KGVudHJ5LCBwZGV2KSB7Ci0JCWlmIChlbnRyeS0+bXNpX2luZGV4ICE9IGV4cGVjdGVkKSB7
Ci0JCQlwcl9kZWJ1ZygicnRhc19tc2k6IGJhZCBNU0ktWCBlbnRyaWVzLlxuIik7Ci0JCQlyZXR1
cm4gLUVJTlZBTDsKLQkJfQotCQlleHBlY3RlZCsrOwotCX0KLQotCXJldHVybiAwOwotfQotCiBz
dGF0aWMgdm9pZCBydGFzX2hhY2tfMzJiaXRfbXNpX2dlbjIoc3RydWN0IHBjaV9kZXYgKnBkZXYp
CiB7CiAJdTMyIGFkZHJfaGksIGFkZHJfbG87CkBAIC0zODAsOSArMzU5LDYgQEAgc3RhdGljIGlu
dCBydGFzX3ByZXBhcmVfbXNpX2lycXMoc3RydWN0CiAJaWYgKHF1b3RhICYmIHF1b3RhIDwgbnZl
YykKIAkJcmV0dXJuIHF1b3RhOwogCi0JaWYgKHR5cGUgPT0gUENJX0NBUF9JRF9NU0lYICYmIGNo
ZWNrX21zaXhfZW50cmllcyhwZGV2KSkKLQkJcmV0dXJuIC1FSU5WQUw7Ci0KIAkvKgogCSAqIEZp
cm13YXJlIGN1cnJlbnRseSByZWZ1c2UgYW55IG5vbiBwb3dlciBvZiB0d28gYWxsb2NhdGlvbgog
CSAqIHNvIHdlIHJvdW5kIHVwIGlmIHRoZSBxdW90YSB3aWxsIGFsbG93IGl0LgpAQCAtNTI5LDkg
KzUwNSwxNiBAQCBzdGF0aWMgc3RydWN0IGlycV9jaGlwIHBzZXJpZXNfcGNpX21zaV9pCiAJLmly
cV93cml0ZV9tc2lfbXNnCT0gcHNlcmllc19tc2lfd3JpdGVfbXNnLAogfTsKIAorCisvKgorICog
U2V0IE1TSV9GTEFHX01TSVhfQ09OVElHVU9VUyBhcyB0aGVyZSBpcyBubyB3YXkgdG8gZXhwcmVz
cyB0bworICogZmlybXdhcmUgdG8gcmVxdWVzdCBhIGRpc2NvbnRpZ3VvdXMgb3Igbm9uLXplcm8g
YmFzZWQgcmFuZ2Ugb2YKKyAqIE1TSS1YIGVudHJpZXMuIENvcmUgY29kZSB3aWxsIHJlamVjdCBz
dWNoIHNldHVwIGF0dGVtcHRzLgorICovCiBzdGF0aWMgc3RydWN0IG1zaV9kb21haW5faW5mbyBw
c2VyaWVzX21zaV9kb21haW5faW5mbyA9IHsKIAkuZmxhZ3MgPSAoTVNJX0ZMQUdfVVNFX0RFRl9E
T01fT1BTIHwgTVNJX0ZMQUdfVVNFX0RFRl9DSElQX09QUyB8Ci0JCSAgTVNJX0ZMQUdfTVVMVElf
UENJX01TSSAgfCBNU0lfRkxBR19QQ0lfTVNJWCksCisJCSAgTVNJX0ZMQUdfTVVMVElfUENJX01T
SSAgfCBNU0lfRkxBR19QQ0lfTVNJWCB8CisJCSAgTVNJX0ZMQUdfTVNJWF9DT05USUdVT1VTKSwK
IAkub3BzICAgPSAmcHNlcmllc19wY2lfbXNpX2RvbWFpbl9vcHMsCiAJLmNoaXAgID0gJnBzZXJp
ZXNfcGNpX21zaV9pcnFfY2hpcCwKIH07CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vaW9tbXU=
