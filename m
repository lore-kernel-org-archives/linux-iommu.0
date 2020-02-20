Return-Path: <SRS0=unsG=4I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25082C11D04
	for <iommu@archiver.kernel.org>; Thu, 20 Feb 2020 10:07:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D826F24672
	for <iommu@archiver.kernel.org>; Thu, 20 Feb 2020 10:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="Ny7CPUbc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D826F24672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7B8FE86C34;
	Thu, 20 Feb 2020 10:07:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IRNEyz-pJ7rM; Thu, 20 Feb 2020 10:07:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4995986BCF;
	Thu, 20 Feb 2020 10:07:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 29FC0C1D84;
	Thu, 20 Feb 2020 10:07:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 913D6C013E
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 10:07:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 79FC887B05
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 10:07:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EMI3C0HdPGzg for <iommu@lists.linux-foundation.org>;
 Thu, 20 Feb 2020 10:06:27 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com
 [209.85.210.195])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 92450847E8
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 10:06:12 +0000 (UTC)
Received: by mail-pf1-f195.google.com with SMTP id k29so1667795pfp.13
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 02:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=endlessm-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+obJw+fj0OE9PhzJ9nA1xEObJG/pQhg9sVUStig/7hk=;
 b=Ny7CPUbcRD90FVlc6wGG3LAn3PnF0g5zINoWO9ZNBbMmLvUcMBmh+LAlTAD5IfWtv5
 axKn17NDTwhh2B9LwXZ5YIFI0NXhQNgPVYO0thbdhrvpcMoMeBbiV7AzLiISYfLwfNI9
 isMYFdpGUBdb6wkexRC6pcoeVmGPsB/bTWxApbj4duXgTba9/PoioMc5Us51lXUyE+8U
 XPuFJxUk9ceo7ehdqjcG8UrymYl4CYT+K/PIa8yvvTgLg5SLFvcA+gfcbwj9nCLH6uO0
 fj6nZRQ651fe721bvpxzKRNsi4JSQnHfuqU9mCTC3zfRQUyiDihsYUTpJT1Cu5L2PNbm
 AWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+obJw+fj0OE9PhzJ9nA1xEObJG/pQhg9sVUStig/7hk=;
 b=YPVLe3yVU0NpPm8LTYna2pTXRmlSs/kRo6IsPaozsZKSZaDuks+jv9AX48EhgLM0RM
 1kkY1Lj5iPUzqYOe1chNj3xCk0DgwHftWB3/y6zduev7zW8STaCctf8jG0lkT2vI7wVw
 58nFmwdsiMDn1Q5miw80Ufb6iD3k2AjsRY/tRbWvXx3krcit4EIsFzT1w/Haead5GE+b
 xEC1BAjdBH7xUeTSQW9oSfGroZzIwhp88XADkCDTsvAMPu1lONTf/iEbmalYh+VSGWZg
 7PBxzFYcpxfIpz+jypI8jkTWZlzQ3QCyJS5qrBap9BSK+0lKHR5khz6UaUoBPXPCRabI
 RXGQ==
X-Gm-Message-State: APjAAAVIGb3cNMpGv/gt0MYFq6XlC0zD3/Ai9qJgkGH72lTFFYYb2qW0
 9u9RIH2lMTy78hYLImMjO99tyw==
X-Google-Smtp-Source: APXvYqwzIY93Fc6yUDgObD5zb5RSvKpcU3Yj7IO9JCKS5qj0W6vAymKE7MG2jABQebpGOtOiKfcC0w==
X-Received: by 2002:aa7:8e85:: with SMTP id a5mr31554459pfr.24.1582193172084; 
 Thu, 20 Feb 2020 02:06:12 -0800 (PST)
Received: from limbo.local (123-204-46-122.static.seed.net.tw.
 [123.204.46.122])
 by smtp.gmail.com with ESMTPSA id d4sm2686730pjz.12.2020.02.20.02.06.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2020 02:06:11 -0800 (PST)
From: Daniel Drake <drake@endlessm.com>
To: baolu.lu@linux.intel.com
Subject: Re: [PATCH v4] iommu/vt-d: consider real PCI device when checking if
 mapping is needed
Date: Thu, 20 Feb 2020 18:06:07 +0800
Message-Id: <20200220100607.9044-1-drake@endlessm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <CAD8Lp47Bhv_58-Z+a+JFS9rTZW58_rWvE8N+XVtX7mmB-Tj55A@mail.gmail.com>
References: <CAD8Lp47Bhv_58-Z+a+JFS9rTZW58_rWvE8N+XVtX7mmB-Tj55A@mail.gmail.com>
MIME-Version: 1.0
Cc: bhelgaas@google.com, linux@endlessm.com, iommu@lists.linux-foundation.org,
 dwmw2@infradead.org, jonathan.derrick@intel.com
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

PiBPbiBXZWQsIEZlYiAxOSwgMjAyMCBhdCAxMTo0MCBBTSBMdSBCYW9sdSA8YmFvbHUubHVAbGlu
dXguaW50ZWwuY29tPiB3cm90ZToKPiA+IFdpdGggcmVzcGVjdCwgdGhpcyBpcyBwcm9ibGVtYXRp
Y2FsLiBUaGUgcGFyZW50IGFuZCBhbGwgc3ViZGV2aWNlcyBzaGFyZQo+ID4gYSBzaW5nbGUgdHJh
bnNsYXRpb24gZW50cnkuIFRoZSBETUEgbWFzayBzaG91bGQgYmUgY29uc2lzdGVudC4KPiA+Cj4g
PiBPdGhlcndpc2UsIGZvciBleGFtcGxlLCBzdWJkZXZpY2UgQSBoYXMgNjQtYml0IERNQSBjYXBh
YmlsaXR5IGFuZCB1c2VzCj4gPiBhbiBpZGVudGl0eSBkb21haW4gZm9yIERNQSB0cmFuc2xhdGlv
bi4gV2hpbGUgc3ViZGV2aWNlIEIgaGFzIDMyLWJpdCBETUEKPiA+IGNhcGFiaWxpdHkgYW5kIGlz
IGZvcmNlZCB0byBzd2l0Y2ggdG8gRE1BIGRvbWFpbi4gU3ViZGV2aWNlIEEgd2lsbCBiZQo+ID4g
aW1wYWN0ZWQgd2l0aG91dCBhbnkgbm90aWZpY2F0aW9uLgoKTG9va2luZyBjbG9zZXIsIHRoaXMg
cHJvYmxlbWF0aWMgY29kZXBhdGggbWF5IGFscmVhZHkgYmUgaGFwcGVuaW5nIGZvciBWTUQsCnVu
ZGVyIGludGVsX2lvbW11X2FkZF9kZXZpY2UoKS4gQ29uc2lkZXIgdGhpcyBmdW5jdGlvbiBydW5u
aW5nIGZvciBhIFZNRApzdWJkZXZpY2UsIHdlIGhpdDoKCsKgIMKgIGRvbWFpbiA9IGlvbW11X2dl
dF9kb21haW5fZm9yX2RldihkZXYpOwoKSSBjYW4ndCBxdWl0ZSBncmFzcCB0aGUgY29kZSBmbG93
IGhlcmUsIGJ1dCBkb21haW4tPnR5cGUgbm93IGFsd2F5cyBzZWVtcwp0byByZXR1cm4gdGhlIGRv
bWFpbiB0eXBlIG9mIHRoZSByZWFsIERNQSBkZXZpY2UsIHdoaWNoIHNlZW1zIGxpa2UgcHJldHR5
CnJlYXNvbmFibGUgYmVoYXZpb3VyLgoKwqAgwqAgaWYgKGRvbWFpbi0+dHlwZSA9PSBJT01NVV9E
T01BSU5fRE1BKSB7CgphbmQgYXMgZGV0YWlsZWQgaW4gcHJldmlvdXMgbWFpbHMsIHRoZSByZWFs
IFZNRCBkZXZpY2Ugc2VlbXMgdG8gYmUgaW4gYSBETUEKZG9tYWluIGJ5IGRlZmF1bHQsIHNvIHdl
IGNvbnRpbnVlLgoKwqAgwqAgwqAgwqAgaWYgKGRldmljZV9kZWZfZG9tYWluX3R5cGUoZGV2KSA9
PSBJT01NVV9ET01BSU5fSURFTlRJVFkpIHsKCk5vdyB3ZSBjaGVja2VkIHRoZSBkZWZhdWx0IGRv
bWFpbiB0eXBlIG9mIHRoZSBzdWJkZXZpY2UuIFRoaXMgc2VlbXMgcmF0aGVyCmxpa2VseSB0byBy
ZXR1cm4gSURFTlRJVFkgYmVjYXVzZSB0aGF0J3MgZWZmZWN0aXZlbHkgdGhlIGRlZmF1bHQgdHlw
ZS4uLgoKwqAgwqAgwqAgwqAgwqAgwqAgcmV0ID0gaW9tbXVfcmVxdWVzdF9kbV9mb3JfZGV2KGRl
dik7CsKgIMKgIMKgIMKgIMKgIMKgIGlmIChyZXQpIHsKwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
ZG1hcl9yZW1vdmVfb25lX2Rldl9pbmZvKGRldik7CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGRt
YXJfZG9tYWluLT5mbGFncyB8PSBET01BSU5fRkxBR19MT1NFX0NISUxEUkVOOwrCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBkb21haW5fYWRkX2Rldl9pbmZvKHNpX2RvbWFpbiwgZGV2KTsKwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgZGV2X2luZm8oZGV2LArCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCJEZXZpY2UgdXNlcyBhIHByaXZhdGUgaWRlbnRpdHkgZG9tYWluLlxuIik7CsKgIMKg
IMKgIMKgIMKgIMKgIH0KwqAgwqAgwqAgwqAgfQoKYW5kIG5vdyB3ZSdyZSBkb2luZyB0aGUgYmFk
IHN0dWZmIHRoYXQgTHUgcG9pbnRlZCBvdXQ6IHdlIG9ubHkgaGF2ZSBvbmUKbWFwcGluZyBzaGFy
ZWQgZm9yIGFsbCB0aGUgc3ViZGV2aWNlcywgc28gaWYgd2UgZW5kIHVwIGNoYW5naW5nIGl0IGZv
ciBvbmUKc3ViZGV2aWNlLCB3ZSdyZSBsaWtlbHkgdG8gYmUgYnJlYWtpbmcgYW5vdGhlci4KSW4g
dGhpcyBjYXNlIGlvbW11X3JlcXVlc3RfZG1fZm9yX2RldigpIHJldHVybnMgLUVCVVNZIHdpdGhv
dXQgZG9pbmcgYW55dGhpbmcKYW5kIHRoZSBmb2xsb3dpbmcgcHJpdmF0ZSBpZGVudGl0eSBjb2Rl
IGZvcnR1bmF0ZWx5IHNlZW1zIHRvIGhhdmUgbm8KY29uc2VxdWVudGlhbCBlZmZlY3RzIC0gdGhl
IHJlYWwgRE1BIGRldmljZSBjb250aW51ZXMgdG8gb3BlcmF0ZSBpbiB0aGUgRE1BCmRvbWFpbiwg
YW5kIGFsbCBzdWJkZXZpY2UgRE1BIHJlcXVlc3RzIGdvIHRocm91Z2ggdGhlIERNQSBtYXBwaW5n
IGNvZGVwYXRoLgpUaGF0J3MgcHJvYmFibHkgd2h5IFZNRCBhcHBlYXJzIHRvIGJlIHdvcmtpbmcg
ZmluZSBhbnl3YXksIGJ1dCB0aGlzIHNlZW1zCmZyYWdpbGUuCgpUaGUgZm9sbG93aW5nIGNoYW5n
ZXMgZW5mb3JjZSB0aGF0IHRoZSByZWFsIERNQSBkZXZpY2UgaXMgaW4gdGhlIERNQSBkb21haW4s
CmFuZCBhdm9pZCB0aGUgaW50ZWxfaW9tbXVfYWRkX2RldmljZSgpIGNvZGVwYXRocyB0aGF0IHdv
dWxkIHRyeSB0byBjaGFuZ2UKaXQgdG8gYSBkaWZmZXJlbnQgZG9tYWluIHR5cGUuIExldCBtZSBr
bm93IGlmIEknbSBvbiB0aGUgcmlnaHQgbGluZXMuLi4KLS0tCiBkcml2ZXJzL2lvbW11L2ludGVs
LWlvbW11LmMgICAgICAgICAgICAgICB8IDE2ICsrKysrKysrKysrKysrKysKIGRyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvaW50ZWwtbnZtZS1yZW1hcC5jIHwgIDYgKysrKysrCiAyIGZpbGVzIGNoYW5n
ZWQsIDIyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2ludGVsLWlv
bW11LmMgYi9kcml2ZXJzL2lvbW11L2ludGVsLWlvbW11LmMKaW5kZXggOTY0NGE1YjNlMGFlLi44
ODcyYjhkMTc4MGQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaW9tbXUvaW50ZWwtaW9tbXUuYworKysg
Yi9kcml2ZXJzL2lvbW11L2ludGVsLWlvbW11LmMKQEAgLTI5MTEsNiArMjkxMSw5IEBAIHN0YXRp
YyBpbnQgZGV2aWNlX2RlZl9kb21haW5fdHlwZShzdHJ1Y3QgZGV2aWNlICpkZXYpCiAJaWYgKGRl
dl9pc19wY2koZGV2KSkgewogCQlzdHJ1Y3QgcGNpX2RldiAqcGRldiA9IHRvX3BjaV9kZXYoZGV2
KTsKIAorCQlpZiAocGNpX3JlYWxfZG1hX2RldihwZGV2KSAhPSBwZGV2KQorCQkJcmV0dXJuIElP
TU1VX0RPTUFJTl9ETUE7CisKIAkJaWYgKGRldmljZV9pc19ybXJyX2xvY2tlZChkZXYpKQogCQkJ
cmV0dXJuIElPTU1VX0RPTUFJTl9ETUE7CiAKQEAgLTU1ODAsNiArNTU4Myw3IEBAIHN0YXRpYyBi
b29sIGludGVsX2lvbW11X2NhcGFibGUoZW51bSBpb21tdV9jYXAgY2FwKQogCiBzdGF0aWMgaW50
IGludGVsX2lvbW11X2FkZF9kZXZpY2Uoc3RydWN0IGRldmljZSAqZGV2KQogeworCXN0cnVjdCBk
ZXZpY2UgKnJlYWxfZGV2ID0gZGV2OwogCXN0cnVjdCBkbWFyX2RvbWFpbiAqZG1hcl9kb21haW47
CiAJc3RydWN0IGlvbW11X2RvbWFpbiAqZG9tYWluOwogCXN0cnVjdCBpbnRlbF9pb21tdSAqaW9t
bXU7CkBAIC01NTkxLDYgKzU1OTUsMTcgQEAgc3RhdGljIGludCBpbnRlbF9pb21tdV9hZGRfZGV2
aWNlKHN0cnVjdCBkZXZpY2UgKmRldikKIAlpZiAoIWlvbW11KQogCQlyZXR1cm4gLUVOT0RFVjsK
IAorCWlmIChkZXZfaXNfcGNpKGRldikpCisJCXJlYWxfZGV2ID0gJnBjaV9yZWFsX2RtYV9kZXYo
dG9fcGNpX2RldihkZXYpKS0+ZGV2OworCisJaWYgKHJlYWxfZGV2ICE9IGRldikgeworCQlkb21h
aW4gPSBpb21tdV9nZXRfZG9tYWluX2Zvcl9kZXYocmVhbF9kZXYpOworCQlpZiAoZG9tYWluLT50
eXBlICE9IElPTU1VX0RPTUFJTl9ETUEpIHsKKwkJCWRldl9lcnIoZGV2LCAiUmVhbCBETUEgZGV2
aWNlIG5vdCBpbiBETUEgZG9tYWluOyBjYW4ndCBoYW5kbGUgRE1BXG4iKTsKKwkJCXJldHVybiAt
RU5PREVWOworCQl9CisJfQorCiAJaW9tbXVfZGV2aWNlX2xpbmsoJmlvbW11LT5pb21tdSwgZGV2
KTsKIAogCWlmICh0cmFuc2xhdGlvbl9wcmVfZW5hYmxlZChpb21tdSkpCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9t
bXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
