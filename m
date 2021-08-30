Return-Path: <SRS0=sxdJ=NV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F28CC432BE
	for <iommu@archiver.kernel.org>; Mon, 30 Aug 2021 19:46:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9392060C3E
	for <iommu@archiver.kernel.org>; Mon, 30 Aug 2021 19:46:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9392060C3E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 52539403B9;
	Mon, 30 Aug 2021 19:46:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dEKMTgzEiCNO; Mon, 30 Aug 2021 19:45:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2EDAA403BD;
	Mon, 30 Aug 2021 19:45:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E5D25C0010;
	Mon, 30 Aug 2021 19:45:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15003C000E
 for <iommu@lists.linux-foundation.org>; Mon, 30 Aug 2021 19:45:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0457B60630
 for <iommu@lists.linux-foundation.org>; Mon, 30 Aug 2021 19:45:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=apertussolutions.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bmbn4kXsTBBQ for <iommu@lists.linux-foundation.org>;
 Mon, 30 Aug 2021 19:45:53 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from sender4-of-o51.zoho.com (sender4-of-o51.zoho.com
 [136.143.188.51])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1C498605CB
 for <iommu@lists.linux-foundation.org>; Mon, 30 Aug 2021 19:45:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1630352726; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=SVHn6COC9v9vBFsLvcEs7dr3HVFNBJTVzni/EkloLN6O5viMtWWj6Tae7tY5LSqMayUip2OwmXpCPBeh8StLC0HSKfA9v4RBf402L+FXbCgqzb5ek2Un8zrhO+eAzSdMcdeXOPemJw94j/P5VzzmH5Uxa160b31YrttEytI+YkI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1630352726;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To;
 bh=yNOkI2F3ECfnM1Ds3LEUzcVyW9YJrCDLxnfkHPWP5Bw=; 
 b=Y4riUrabFYj0b6DV/fDwG8D+TJWGMsTa2KkKjietvIYTinnwsrV9GAJCRxqzHnrmQAfcRZ2FuLSkwDrCU/p37bvCCMZQ4oncVTMXIuTKzyxU8utaz2SI3v/9ouNKMtirvFnmwm6ENL21lsSYR9FooIsZmb4ozkS3rKyJVnLmB00=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=apertussolutions.com;
 spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
 dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1630352726; 
 s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
 h=To:Cc:References:From:Subject:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=yNOkI2F3ECfnM1Ds3LEUzcVyW9YJrCDLxnfkHPWP5Bw=;
 b=mwtop516etIwYk691Qmw9i4ypq0dGhP3x9W2DH2WOOO16HN/YY4Zwhq7sMNSBvs4
 vnNIH2ifuPaAIHNh7/eGtqkGwtt9XfOnfk6d8PK8+GyyoihJP6oOV/oYS8uAh/GP0zK
 75uDRW9iUfKSH0ext6bgxXovU0LJOZdpXPaQsB6U=
Received: from [10.10.1.24] (static-72-81-132-2.bltmmd.fios.verizon.net
 [72.81.132.2]) by mx.zohomail.com
 with SMTPS id 1630352723773366.9884523607444;
 Mon, 30 Aug 2021 12:45:23 -0700 (PDT)
To: Jason Gunthorpe <jgg@ziepe.ca>, Ross Philipson <ross.philipson@oracle.com>
References: <1630070917-9896-1-git-send-email-ross.philipson@oracle.com>
 <1630070917-9896-15-git-send-email-ross.philipson@oracle.com>
 <20210827133011.GJ1200268@ziepe.ca>
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
Subject: Re: [PATCH v4 14/14] tpm: Allow locality 2 to be set when
 initializing the TPM for Secure Launch
Message-ID: <e40a22d6-22f3-3374-01dc-75f14f310c7d@apertussolutions.com>
Date: Mon, 30 Aug 2021 15:45:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210827133011.GJ1200268@ziepe.ca>
Content-Language: en-US
X-ZohoMailClient: External
Cc: linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 luto@amacapital.net, iommu@lists.linux-foundation.org, mingo@redhat.com,
 bp@alien8.de, hpa@zytor.com, kanth.ghatraju@oracle.com,
 linux-integrity@vger.kernel.org, trenchboot-devel@googlegroups.com,
 tglx@linutronix.de
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

T24gOC8yNy8yMSA5OjMwIEFNLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6Cj4gT24gRnJpLCBBdWcg
MjcsIDIwMjEgYXQgMDk6Mjg6MzdBTSAtMDQwMCwgUm9zcyBQaGlsaXBzb24gd3JvdGU6Cj4+IFRo
ZSBTZWN1cmUgTGF1bmNoIE1MRSBlbnZpcm9ubWVudCB1c2VzIFBDUnMgdGhhdCBhcmUgb25seSBh
Y2Nlc3NpYmxlIGZyb20KPj4gdGhlIERSVE0gbG9jYWxpdHkgMi4gQnkgZGVmYXVsdCB0aGUgVFBN
IGRyaXZlcnMgYWx3YXlzIGluaXRpYWxpemUgdGhlCj4+IGxvY2FsaXR5IHRvIDAuIFdoZW4gYSBT
ZWN1cmUgTGF1bmNoIGlzIGluIHByb2dyZXNzLCBpbml0aWFsaXplIHRoZQo+PiBsb2NhbGl0eSB0
byAyLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBSb3NzIFBoaWxpcHNvbiA8cm9zcy5waGlsaXBzb25A
b3JhY2xlLmNvbT4KPj4gLS0tCj4+ICBkcml2ZXJzL2NoYXIvdHBtL3RwbS1jaGlwLmMgfCA5ICsr
KysrKysrLQo+PiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQo+IAo+IEdsb2JhbCBzdGF0ZSBsaWtlIHRoaXMgc2VlbXMgcXVpdGUgZGFuZ2Vyb3VzLCBzaG91
bGRuJ3QgdGhlIGxvY2FsaXR5Cj4gYmUgc2VsZWN0ZWQgYmFzZWQgb24gdGhlIFBDUiBiZWluZyBh
Y2Nlc3NlZCwgb3IgcGFzc2VkIGRvd24gZnJvbQo+IGhpZ2hlciB1cCBpbiB0aGUgY2FsbCBjaGFp
bj8KPiAKPiBKYXNvbgo+IAoKSGV5IEphc29uLAoKV2hpbGUgbG9jYWxpdHkgZG9lcyBjb250cm9s
IHdoaWNoIFBDUnMgYXJlIGFjY2Vzc2libGUsIGl0IGlzIG1lYW50IHRvCnJlZmxlY3Qgd2hhdCBj
b21wb25lbnQgdGhhdCBhIFRQTSBjb21tYW5kIGlzIG9yaWdpbmF0aW5nLiBUbyBxdW90ZSB0aGUK
VENHIFNwZWMsICLigJxMb2NhbGl0eeKAnSBpcyBhbiBhc3NlcnRpb24gdG8gdGhlIFRQTSB0aGF0
IGEgY29tbWFuZOKAmXMgc291cmNlCmlzIGFzc29jaWF0ZWQgd2l0aCBhIHBhcnRpY3VsYXIgY29t
cG9uZW50LiBMb2NhbGl0eSBjYW4gYmUgdGhvdWdodCBvZiBhcwphIGhhcmR3YXJlLWJhc2VkIGF1
dGhvcml6YXRpb24uIgoKVGh1cyB3aGVuIHRoZSBTUlRNIGNoYWluLCB0byBpbmNsdWRlIHRoZSBT
dGF0aWMgT1MsIGlzIGluIGNvbnRyb2wsIHRoZQpoYXJkd2FyZSBpcyByZXF1aXJlZCB0byByZXN0
cmljdCBhY2Nlc3MgdG8gb25seSBMb2NhbGl0eSAwLiBPbmNlIGEKRHluYW1pYyBMYXVuY2ggaGFz
IG9jY3VycmVkLCB0aGUgaGFyZHdhcmUgZ3JhbnRzIGFjY2VzcyB0byBMb2NhbGl0eSAxCmFuZCAy
LiBBZ2FpbiB0byByZWZlciB0byB0aGUgVENHIHNwZWMsIHRoZSBkZWZpbml0aW9uIG9mIExvY2Fs
aXR5IDIgaXMsCnRoZSAiRHluYW1pY2FsbHkgTGF1bmNoZWQgT1MgKER5bmFtaWMgT1MpIOKAnHJ1
bnRpbWXigJ0gZW52aXJvbm1lbnQiLgoKV2hlbiBMaW51eCBpcyBzdGFydGVkIGZyb20gdGhlIFNS
VE0sIGl0IGlzIGNvcnJlY3QgZm9yIHRoZSBUUE0gZHJpdmVyIHRvCnNldCB0aGUgbG9jYWxpdHkg
dG8gTG9jYWxpdHkgMCB0byBkZW5vdGUgdGhhdCB0aGUgc291cmNlIGlzIHRoZSBTdGF0aWMKT1Mu
IE5vdyB3aGVuIExpbnV4IGlzIHN0YXJ0ZWQgZnJvbSB0aGUgRFJUTSwgdGhlIFRQTSBkcml2ZXIg
c2hvdWxkIHNldAp0aGUgbG9jYWxpdHkgdG8gTG9jYWxpdHkgMiB0byBkZW5vdGUgdGhhdCBpdCBp
cyB0aGUgInJ1bnRpbWUiIER5bmFtaWMKT1MuIEFzIGZvciB0aGUgZGlmZmVyZW5jZXMgaW4gYWNj
ZXNzLCB3aXRoIExvY2FsaXR5IDAgTGludXggKGJlaW5nIHRoZQpTdGF0aWMgT1MpIGlzIHJlc3Ry
aWN0ZWQgdG8gdGhlIFN0YXRpYyBQQ1JzICgwLTE1KSwgdGhlIERlYnVnIFBDUiAoMTYpLAphbmQg
dGhlIEFwcGxpY2F0aW9uIFBDUiAoMjMpLiBXaGVyZWFzIHdpdGggTG9jYWxpdHkgMiBMaW51eCBu
b3cgYmVpbmcKdGhlIER5bmFtaWMgT1Mgd2lsbCBoYXZlIGFjY2VzcyB0byBhbGwgUENScy4KClRv
IHN1bW1hcml6ZSwgVFBNIGxvY2FsaXR5IHJlYWxseSBpcyBhIGdsb2JhbCBzdGF0ZSB0aGF0IHJl
ZmxlY3RzIHRoZQpjb21wb25lbnQgaW4gY29udHJvbCBvZiB0aGUgcGxhdGZvcm0uIENvbnNpZGVy
aW5nIHRoZSBkZWZpbml0aW9uIG9mCmxvY2FsaXR5LCBzZXR0aW5nIHRoZSBsb2NhbGl0eSB0byBM
b2NhbGl0eSAwIGlzIHNheWluZyB0aGF0IHRoZSBTdGF0aWMKRW52aXJvbm1lbnQgaXMgbm93IGlu
IGNvbnRyb2wuIERvaW5nIHNvIGFmdGVyIHRoZSBEeW5hbWljIEVudmlyb25tZW50CmhhcyBzdGFy
dGVkIHdvdWxkIGJlIGFuIGluYWNjdXJhdGUgc2V0dGluZyBvZiB0aGUgcGxhdGZvcm0gc3RhdGUu
IFRoZQpjb3JyZWN0IHRpbWUgYXQgd2hpY2ggdGhlIGxvY2FsaXR5IHNob3VsZCBjaGFuZ2UgYmFj
ayB0byBMb2NhbGl0eSAwIGlzCmFmdGVyIHRoZSBEeW5hbWljIEVudmlyb25tZW50IGhhcyBiZWVu
IGV4aXRlZC4gT24gSW50ZWwgdGhpcyBjYW4gYmUgZG9uZQpieSBpbnZva2luZyB0aGUgaW5zdHJ1
Y3Rpb24gR0VUU0VDW1NFWElUXS4gSXQgc2hvdWxkIGJlIG5vdGVkIHRoYXQKU2VjdXJlIExhdW5j
aCBhZGRzIHRoZSBjYWxsIHRvIHRoZSBHRVRTRUNbU0VYSVRdIGluc3RydWN0aW9uIGluIHRoZQpr
ZXhlYywgcmVib290LCBhbmQgc2h1dGRvd24gcGF0aHMuCgp2L3IsCmRwcwpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9t
bXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
