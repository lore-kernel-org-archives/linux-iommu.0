Return-Path: <SRS0=Z2AP=ZY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08B0C432C3
	for <iommu@archiver.kernel.org>; Mon,  2 Dec 2019 16:13:43 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AFD720722
	for <iommu@archiver.kernel.org>; Mon,  2 Dec 2019 16:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LpQ+uqbf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AFD720722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 5A00D21532;
	Mon,  2 Dec 2019 16:13:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lE7r1MoTSegC; Mon,  2 Dec 2019 16:13:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6C86C204B9;
	Mon,  2 Dec 2019 16:13:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 584CEC1797;
	Mon,  2 Dec 2019 16:13:41 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0134BC087F
 for <iommu@lists.linux-foundation.org>; Mon,  2 Dec 2019 16:13:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E420E8868E
 for <iommu@lists.linux-foundation.org>; Mon,  2 Dec 2019 16:13:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ExgYCXmYY2hR for <iommu@lists.linux-foundation.org>;
 Mon,  2 Dec 2019 16:13:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id ABF6C88680
 for <iommu@lists.linux-foundation.org>; Mon,  2 Dec 2019 16:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575303217;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y3LXPhEISt/lT7I5COItPrPZAUekStpNeinC0naM/6M=;
 b=LpQ+uqbfSQCbZnFbTlPUpSMODV6k4DaW57k8HXkUqpV2rL7cLqP+mcNm42mxT1r15dR/Le
 Rk6JKZnniLflsuJtZgaOwNUhNq6ETKochDjMXUzuhZsobq+sR+G88W1mB6u4pDg3DqBFOX
 7iHelT23AImXxhsVbtLLe/oxgqAY400=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-hN9Tmt4zNVCMBX2xQwoQrA-1; Mon, 02 Dec 2019 11:13:35 -0500
Received: by mail-pj1-f72.google.com with SMTP id z24so174785pjt.19
 for <iommu@lists.linux-foundation.org>; Mon, 02 Dec 2019 08:13:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:reply-to
 :references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to;
 bh=g9BzGKlaYjl7jGcc4Esh+S3bK6Y7AiEWBjPDqmW8Syo=;
 b=pNI9qvwb1t9zqpDu8CBcM4x2Q9mnkYvsygRBh+zp8HXNTvX9BYepCvj0SsQ1GKSGiz
 JRjIfm1lRoOpJTAleWcGDZVR6lXAlfepWFb5nxgkMtdGWpj4l/xvd0FEttspCvj8xIB3
 8a3XfgE3gmk70Wvj4HXBvnF9l3fjdwDPeN6pUo0H0OUYQwsVoPZHAdXJqH0tTa16t8J/
 6NVuO7wVzONMCq1Nn3o+UXpeGmbzzjiHxzbtv5yKJjPJfr78vaPtQG/yScmSfmP+CgV2
 nD6wlJSxkiW9wZ8TxD0TKHwtP99enrjb2b/Ka4XsICSR+SjL1qXTxaWa9yk6tYvbMkod
 wcDw==
X-Gm-Message-State: APjAAAWo/r4oW3pVjatEBfeCANe6pgPyUR8Gvo15sytNGp0gZkg9TLwI
 hUMgizJq0nXtH5btqO5IIAyszjrXDymHp+ljcbRYi7zz8UVrUAARN8TBEwflFGxcpdRtYArf5cF
 p4o7DNwkeoPPNFCp1qYAsFvi/B1QxRw==
X-Received: by 2002:a63:d047:: with SMTP id s7mr1067931pgi.81.1575303214682;
 Mon, 02 Dec 2019 08:13:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqwf6oTDK7ZIss7qnHDz0PXbekI64gNgaYQodeB+snulP0ElT1I6+zYVPNmR8FGChpdQRD50kg==
X-Received: by 2002:a63:d047:: with SMTP id s7mr1067889pgi.81.1575303214304;
 Mon, 02 Dec 2019 08:13:34 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
 by smtp.gmail.com with ESMTPSA id f10sm34564989pfd.28.2019.12.02.08.13.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2019 08:13:33 -0800 (PST)
Date: Mon, 2 Dec 2019 09:13:32 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux-foundation.org,
 Joerg Roedel <joro@8bytes.org>
Subject: Re: dmar pte read access not set error messages on hp dl388 gen8
 systems
Message-ID: <20191202161332.ctc3y5cvdgqwnz7l@cantor>
References: <20191202063422.3lyfoerkejig4num@cantor>
 <702d8a8a-88de-bffb-911e-9eb9a6a7845d@linux.intel.com>
 <20191202071406.jpq5qobbtnwhktlc@cantor>
MIME-Version: 1.0
In-Reply-To: <20191202071406.jpq5qobbtnwhktlc@cantor>
X-MC-Unique: hN9Tmt4zNVCMBX2xQwoQrA-1
X-Mimecast-Spam-Score: 0
Content-Disposition: inline
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

T24gTW9uIERlYyAwMiAxOSwgSmVycnkgU25pdHNlbGFhciB3cm90ZToKPk9uIE1vbiBEZWMgMDIg
MTksIEx1IEJhb2x1IHdyb3RlOgo+PkhpLAo+Pgo+Pk9uIDEyLzIvMTkgMjozNCBQTSwgSmVycnkg
U25pdHNlbGFhciB3cm90ZToKPj4+V2UgYXJlIHNlZWluZyBETUFSIFBURSByZWFkIGFjY2VzcyBu
b3Qgc2V0IGVycm9ycyB3aGVuIGJvb3RpbmcgYQo+Pj5rZXJuZWwgd2l0aCBkZWZhdWx0IHBhc3N0
aHJvdWdoLCBib3RoIHdpdGggYSB0ZXN0IGtlcm5lbCBhbmQgd2l0aAo+Pj5hIDUuNC4wIGtlcm5l
bC4gUHJldmlvdXNseSB3ZSB3b3VsZCBzZWUgYSBudW1iZXIgb2YgaWRlbnRpdHkgbWFwcGluZ3MK
Pj4+YmVpbmcgc2V0IHJlbGF0ZWQgdG8gdGhlIHJtcnJzLCBhbmQgbm93IHRoZXkgYXJlbid0IHNl
ZW4gYW5kIHdlIGdldAo+Pj50aGUgZG1hciBwdGUgZXJyb3JzIGFzIGRldmljZXMgdG91Y2ggdGhv
c2UgcmVnaW9ucy4gRnJvbSB3aGF0IEkgY2FuIHRlbGwKPj4+Y3VycmVudGx5IGRmNGYzYzYwM2Fl
YiAoImlvbW11L3Z0LWQ6IFJlbW92ZSBzdGF0aWMgaWRlbnRpdHkgbWFwIGNvZGUiKQo+Pj5yZW1v
dmVkIHRoZSBiaXQgb2YgY29kZSBpbiBpbml0X2RtYXJzIHRoYXQgdXNlZCB0byBzZXQgdXAgdGhv
c2UKPj4+bWFwcGluZ3M6Cj4+Pgo+Pj4twqDCoMKgwqDCoMKgIC8qCj4+Pi3CoMKgwqDCoMKgwqDC
oCAqIEZvciBlYWNoIHJtcnIKPj4+LcKgwqDCoMKgwqDCoMKgICrCoMKgIGZvciBlYWNoIGRldiBh
dHRhY2hlZCB0byBybXJyCj4+Pi3CoMKgwqDCoMKgwqDCoCAqwqDCoCBkbwo+Pj4twqDCoMKgwqDC
oMKgwqAgKsKgwqDCoMKgIGxvY2F0ZSBkcmhkIGZvciBkZXYsIGFsbG9jIGRvbWFpbiBmb3IgZGV2
Cj4+Pi3CoMKgwqDCoMKgwqDCoCAqwqDCoMKgwqAgYWxsb2NhdGUgZnJlZSBkb21haW4KPj4+LcKg
wqDCoMKgwqDCoMKgICrCoMKgwqDCoCBhbGxvY2F0ZSBwYWdlIHRhYmxlIGVudHJpZXMgZm9yIHJt
cnIKPj4+LcKgwqDCoMKgwqDCoMKgICrCoMKgwqDCoCBpZiBjb250ZXh0IG5vdCBhbGxvY2F0ZWQg
Zm9yIGJ1cwo+Pj4twqDCoMKgwqDCoMKgwqAgKsKgwqDCoMKgwqDCoMKgwqDCoMKgIGFsbG9jYXRl
IGFuZCBpbml0IGNvbnRleHQKPj4+LcKgwqDCoMKgwqDCoMKgICrCoMKgwqDCoMKgwqDCoMKgwqDC
oCBzZXQgcHJlc2VudCBpbiByb290IHRhYmxlIGZvciB0aGlzIGJ1cwo+Pj4twqDCoMKgwqDCoMKg
wqAgKsKgwqDCoMKgIGluaXQgY29udGV4dCB3aXRoIGRvbWFpbiwgdHJhbnNsYXRpb24gZXRjCj4+
Pi3CoMKgwqDCoMKgwqDCoCAqwqDCoMKgIGVuZGZvcgo+Pj4twqDCoMKgwqDCoMKgwqAgKiBlbmRm
b3IKPj4+LcKgwqDCoMKgwqDCoMKgICovCj4+Pi3CoMKgwqDCoMKgwqAgcHJfaW5mbygiU2V0dGlu
ZyBSTVJSOlxuIik7Cj4+Pi3CoMKgwqDCoMKgwqAgZm9yX2VhY2hfcm1ycl91bml0cyhybXJyKSB7
Cj4+Pi3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIHNvbWUgQklPUyBsaXN0cyBub24t
ZXhpc3QgZGV2aWNlcyBpbiBETUFSIHRhYmxlLiAqLwo+Pj4twqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBmb3JfZWFjaF9hY3RpdmVfZGV2X3Njb3BlKHJtcnItPmRldmljZXMsIHJtcnItPmRl
dmljZXNfY250LAo+Pj4twqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaSwgZGV2KSB7Cj4+Pi3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSBpb21tdV9wcmVw
YXJlX3JtcnJfZGV2KHJtcnIsIGRldik7Cj4+Pi3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBpZiAocmV0KQo+Pj4twqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHByX2VycigiTWFwcGluZyByZXNlcnZl
ZCByZWdpb24gZmFpbGVkXG4iKTsKPj4+LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+
Pj4twqDCoMKgwqDCoMKgIH0KPj4+Cj4+PnNpX2RvbWFpbl9pbml0IG5vdyBoYXMgY29kZSB0aGF0
IHNldHMgaWRlbnRpdHkgbWFwcyBmb3IgZGV2aWNlcyBpbiAKPj4+cm1ycnMsIGJ1dAo+Pj5vbmx5
IGZvciBjZXJ0YWluIGRldmljZXMuCj4+Cj4+T24gd2hpY2ggZGV2aWNlLCBhcmUgeW91IHNlZWlu
ZyB0aGlzIGVycm9yPyBJcyBpdCBhIHJtcnIgbG9ja2VkIGRldmljZT8KPj4KPj5CZXN0IHJlZ2Fy
ZHMsCj4+YmFvbHUKPj4KPgo+QWxtb3N0IGFsbCBvZiB0aGUgbWVzc2FnZXMgYXJlIGZvciB0aGUg
aWxvLCBidXQgdGhlcmUgYWxzbyBpcyBhIG1lc3NhZ2UgZm9yCj50aGUgc21hcnQgYXJyYXkgcmFp
ZCBidXMgY29udHJvbGxlci4KPgoKQWxzbyBzZWVpbmcgaXQgd2l0aCBhIGRsMzgwIGdlbjkgc3lz
dGVtLCB3aGVyZSB0aGUgcmFpZCBidXMgY29udHJvbGxlcgppcyBnZXR0aW5nIHRoZSBlcnJvci4K
Cj4+Pgo+Pj5XaXRoIGlvbW11PW5vcHQsIHRoZSBzeXN0ZW0gYm9vdHMgdXAgd2l0aG91dCBpc3N1
ZS4KPj4+Cj4+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
