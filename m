Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3454EC433F5
	for <iommu@archiver.kernel.org>; Fri,  3 Dec 2021 16:03:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E3EEE40282;
	Fri,  3 Dec 2021 16:03:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8x8H-zXUY6bo; Fri,  3 Dec 2021 16:03:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 42AB64027C;
	Fri,  3 Dec 2021 16:03:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 27FDEC001E;
	Fri,  3 Dec 2021 16:03:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9BC07C0012
 for <iommu@lists.linux-foundation.org>; Fri,  3 Dec 2021 16:03:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8A46B80C69
 for <iommu@lists.linux-foundation.org>; Fri,  3 Dec 2021 16:03:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 19obym4pqJOS for <iommu@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 16:03:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id CF0F280C63
 for <iommu@lists.linux-foundation.org>; Fri,  3 Dec 2021 16:03:49 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15C941435;
 Fri,  3 Dec 2021 08:03:49 -0800 (PST)
Received: from [10.57.34.58] (unknown [10.57.34.58])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0810B3F73B;
 Fri,  3 Dec 2021 08:03:46 -0800 (PST)
Message-ID: <7ee55288-209f-8f19-ef69-27e2a5448473@arm.com>
Date: Fri, 3 Dec 2021 16:03:42 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v4 04/14] Documentation/x86: Secure Launch kernel
 documentation
Content-Language: en-GB
To: Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org, 
 x86@kernel.org, iommu@lists.linux-foundation.org,
 linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org
References: <1630070917-9896-1-git-send-email-ross.philipson@oracle.com>
 <1630070917-9896-5-git-send-email-ross.philipson@oracle.com>
 <bd677501-bd65-9648-c8f5-1b90983377b5@arm.com>
 <6713b6b2-3c6d-8318-ee9e-e1746f02a3a5@oracle.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <6713b6b2-3c6d-8318-ee9e-e1746f02a3a5@oracle.com>
Cc: dpsmith@apertussolutions.com, luto@amacapital.net, mingo@redhat.com,
 kanth.ghatraju@oracle.com, hpa@zytor.com, bp@alien8.de, tglx@linutronix.de,
 trenchboot-devel@googlegroups.com
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gMjAyMS0xMi0wMyAxNTo0NywgUm9zcyBQaGlsaXBzb24gd3JvdGU6Cj4gT24gMTIvMi8yMSAx
MjoyNiwgUm9iaW4gTXVycGh5IHdyb3RlOgo+PiBPbiAyMDIxLTA4LTI3IDE0OjI4LCBSb3NzIFBo
aWxpcHNvbiB3cm90ZToKPj4gWy4uLl0KPj4+ICtJT01NVSBDb25maWd1cmF0aW9uCj4+PiArLS0t
LS0tLS0tLS0tLS0tLS0tLQo+Pj4gKwo+Pj4gK1doZW4gZG9pbmcgYSBTZWN1cmUgTGF1bmNoLCB0
aGUgSU9NTVUgc2hvdWxkIGFsd2F5cyBiZSBlbmFibGVkIGFuZAo+Pj4gdGhlIGRyaXZlcnMKPj4+
ICtsb2FkZWQuIEhvd2V2ZXIsIElPTU1VIHBhc3N0aHJvdWdoIG1vZGUgc2hvdWxkIG5ldmVyIGJl
IHVzZWQuIFRoaXMKPj4+IGxlYXZlcyB0aGUKPj4+ICtNTEUgY29tcGxldGVseSBleHBvc2VkIHRv
IERNQSBhZnRlciB0aGUgUE1SJ3MgWzJdXyBhcmUgZGlzYWJsZWQuCj4+PiBGaXJzdCwgSU9NTVUK
Pj4+ICtwYXNzdGhyb3VnaCBzaG91bGQgYmUgZGlzYWJsZWQgYnkgZGVmYXVsdCBpbiB0aGUgYnVp
bGQgY29uZmlndXJhdGlvbjo6Cj4+PiArCj4+PiArwqAgIkRldmljZSBEcml2ZXJzIiAtLT4KPj4+
ICvCoMKgwqDCoMKgICJJT01NVSBIYXJkd2FyZSBTdXBwb3J0IiAtLT4KPj4+ICvCoMKgwqDCoMKg
wqDCoMKgwqAgIklPTU1VIHBhc3N0aHJvdWdoIGJ5IGRlZmF1bHQgWyBdIgo+Pj4gKwo+Pj4gK1Ro
aXMgdW5zZXQgdGhlIEtjb25maWcgdmFsdWUgQ09ORklHX0lPTU1VX0RFRkFVTFRfUEFTU1RIUk9V
R0guCj4+Cj4+IE5vdGUgdGhhdCB0aGUgY29uZmlnIHN0cnVjdHVyZSBoYXMgbm93IGNoYW5nZWQs
IGFuZCBpZiBzZXQsIHBhc3N0aHJvdWdoCj4+IGlzIGRlc2VsZWN0ZWQgYnkgY2hvb3NpbmcgYSBk
aWZmZXJlbnQgZGVmYXVsdCBkb21haW4gdHlwZS4KPiAKPiBUaGFua3MgZm9yIHRoZSBoZWFkcyB1
cC4gV2Ugd2lsbCBoYXZlIHRvIG1vZGlmeSB0aGlzIGZvciBob3cgdGhpbmdzCj4gZXhpc3QgdG9k
YXkuCj4gCj4+Cj4+PiArSW4gYWRkaXRpb24sIHBhc3N0aHJvdWdoIG11c3QgYmUgZGlzYWJsZWQg
b24gdGhlIGtlcm5lbCBjb21tYW5kIGxpbmUKPj4+IHdoZW4gZG9pbmcKPj4+ICthIFNlY3VyZSBM
YXVuY2ggYXMgZm9sbG93czo6Cj4+PiArCj4+PiArwqAgaW9tbXU9bm9wdCBpb21tdS5wYXNzdGhy
b3VnaD0wCj4+Cj4+IFRoaXMgcGFydCBpcyBhIGJpdCBzaWxseSAtIHRob3NlIG9wdGlvbnMgYXJl
IGxpdGVyYWxseSBhbGlhc2VzIGZvciB0aGUKPj4gZXhhY3Qgc2FtZSB0aGluZywgYW5kIGZ1cnRo
ZXJtb3JlIGlmIHRoZSBjb25maWcgaXMgYWxyZWFkeSBzZXQgYXMKPj4gcmVxdWlyZWQgdGhlbiB0
aGUgc29sZSBlZmZlY3QgZWl0aGVyIG9mIHRoZW0gd2lsbCBoYXZlIGlzIHRvIGNhdXNlICIoc2V0
Cj4+IGJ5IGtlcm5lbCBjb21tYW5kIGxpbmUpIiB0byBiZSBwcmludGVkLiBUaGVyZSBpcyBubyB2
YWx1ZSBpbiBleHBsaWNpdGx5Cj4+IG92ZXJyaWRpbmcgdGhlIGRlZmF1bHQgdmFsdWUgd2l0aCB0
aGUgZGVmYXVsdCB2YWx1ZSAtIGlmIGFueW9uZSBjYW4KPj4gYXBwZW5kIGFuIGFkZGl0aW9uYWwg
ImlvbW11LnBhc3N0aHJvdWdoPTEiIChvciAiaW9tbXU9cHQiKSB0byB0aGUgZW5kIG9mCj4+IHRo
ZSBjb21tYW5kIGxpbmUgdGhleSdsbCBzdGlsbCB3aW4uCj4gCj4gSSBmZWVsIGxpa2Ugd2hlbiB3
ZSB3b3JrZWQgb24gdGhpcywgaXQgd2FzIHN0aWxsIGltcG9ydGFudCB0byBzZXQgdGhvc2UKPiB2
YWx1ZXMuIFRoaXMgY291bGQgaGF2ZSBiZWVuIGluIGFuIG9sZGVyIGtlcm5lbCB2ZXJzaW9uLiBX
ZSB3aWxsIGdvIGJhY2sKPiBhbmQgdmVyaWZ5IHdoYXQgeW91IGFyZSBzYXlpbmcgaGVyZSBhbmQg
YWRqdXN0IHRoZSBkb2N1bWVudGF0aW9uCj4gYWNjb3JkaW5nbHkuCj4gCj4gQXMgdG8gYW55b25l
IGp1c3QgYWRkaW5nIHZhbHVlcyB0byB0aGUgY29tbWFuZCBsaW5lLCB0aGF0IGlzIHdoeSB0aGUK
PiBjb21tYW5kIGxpbmUgaXMgcGFydCBvZiB0aGUgRFJUTSBtZWFzdXJlbWVudHMuCgpZZWFoLCBJ
IGhhZCBhIHZhZ3VlIG1lbW9yeSB0aGF0IHRoYXQgd2FzIHRoZSBjYXNlIC0gYmFzaWNhbGx5IGlm
IHlvdSBjYW4gCnRydXN0IHRoZSBjb21tYW5kIGxpbmUgYXMgbXVjaCBhcyB0aGUgY29uZmlnIHRo
ZW4gaXQncyBkZWZpbml0ZWx5IApyZWR1bmRhbnQgdG8gcGFzcyBhbiBvcHRpb24gZm9yIHRoaXMg
KHNlZSBpb21tdV9zdWJzeXNfaW5pdCgpIC0gaXQncyBub3cgCmFsbCBwbHVtYmVkIHRocm91Z2gg
aW9tbXVfZGVmX2RvbWFpbl90eXBlKSwgYW5kIGlmIHlvdSBjYW4ndCB0aGVuIApwYXNzaW5nIHRo
ZW0gaXMgZnV0aWxlIGFueXdheS4KCkNoZWVycywKUm9iaW4uCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby9pb21tdQ==
