Return-Path: <SRS0=o1xy=ZV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBC4C432C3
	for <iommu@archiver.kernel.org>; Fri, 29 Nov 2019 17:27:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 633252176D
	for <iommu@archiver.kernel.org>; Fri, 29 Nov 2019 17:27:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 633252176D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 3E78A2324B;
	Fri, 29 Nov 2019 17:27:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wekgzKCz2Uu6; Fri, 29 Nov 2019 17:27:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id DB3BD1FE41;
	Fri, 29 Nov 2019 17:27:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6A64C1DD9;
	Fri, 29 Nov 2019 17:27:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19A51C0881
 for <iommu@lists.linux-foundation.org>; Fri, 29 Nov 2019 17:27:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0F08087E59
 for <iommu@lists.linux-foundation.org>; Fri, 29 Nov 2019 17:27:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p1orB2erOvMg for <iommu@lists.linux-foundation.org>;
 Fri, 29 Nov 2019 17:27:01 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from ale.deltatee.com (ale.deltatee.com [207.54.116.67])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2018687E38
 for <iommu@lists.linux-foundation.org>; Fri, 29 Nov 2019 17:27:01 +0000 (UTC)
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230]
 helo=[192.168.11.155])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1iak2k-0008Lo-N5; Fri, 29 Nov 2019 10:26:59 -0700
To: James Sewart <jamessewart@arista.com>
References: <20191120193228.GA103670@google.com>
 <6A902F0D-FE98-4760-ADBB-4D5987D866BE@arista.com>
 <20191126173833.GA16069@infradead.org>
 <547214A9-9FD0-4DD5-80E1-1F5A467A0913@arista.com>
 <9c54c5dd-702c-a19b-38ba-55ab73b24729@deltatee.com>
 <435064D4-00F0-47F5-94D2-2C354F6B1206@arista.com>
 <058383d9-69fe-65e3-e410-eebd99840261@deltatee.com>
 <F26CC19F-66C2-466B-AE30-D65E10BA3022@arista.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <d811576e-0f89-2303-a554-2701af5c5647@deltatee.com>
Date: Fri, 29 Nov 2019 10:26:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <F26CC19F-66C2-466B-AE30-D65E10BA3022@arista.com>
Content-Language: en-US
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: helgaas@kernel.org, alex.williamson@redhat.com,
 dima@arista.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, 0x7f454c46@gmail.com, hch@infradead.org,
 linux-pci@vger.kernel.org, jamessewart@arista.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v4 1/2] PCI: Add parameter nr_devfns to pci_add_dma_alias
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Dmitry Safonov <dima@arista.com>, linux-pci@vger.kernel.org,
 Dmitry Safonov <0x7f454c46@gmail.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Bjorn Helgaas <helgaas@kernel.org>
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

CgpPbiAyMDE5LTExLTI5IDEwOjE5IGEubS4sIEphbWVzIFNld2FydCB3cm90ZToKPiAKPiAKPj4g
T24gMjkgTm92IDIwMTksIGF0IDE2OjUwLCBMb2dhbiBHdW50aG9ycGUgPGxvZ2FuZ0BkZWx0YXRl
ZS5jb20+IHdyb3RlOgo+Pgo+Pgo+Pgo+PiBPbiAyMDE5LTExLTI5IDU6NDkgYS5tLiwgSmFtZXMg
U2V3YXJ0IHdyb3RlOgo+Pj4gcGNpX2FkZF9kbWFfYWxpYXMgY2FuIG5vdyBiZSB1c2VkIHRvIGNy
ZWF0ZSBhIGRtYSBhbGlhcyBmb3IgYSByYW5nZSBvZgo+Pj4gZGV2Zm5zLgo+Pj4KPj4+IFNpZ25l
ZC1vZmYtYnk6IEphbWVzIFNld2FydCA8amFtZXNzZXdhcnRAYXJpc3RhLmNvbT4KPj4+IC0tLQo+
Pj4gZHJpdmVycy9wY2kvcGNpLmMgICAgfCAyMyArKysrKysrKysrKysrKysrKystLS0tLQo+Pj4g
ZHJpdmVycy9wY2kvcXVpcmtzLmMgfCAxNCArKysrKysrLS0tLS0tLQo+Pj4gaW5jbHVkZS9saW51
eC9wY2kuaCAgfCAgMiArLQo+Pj4gMyBmaWxlcyBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCAx
MyBkZWxldGlvbnMoLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvcGNpLmMgYi9k
cml2ZXJzL3BjaS9wY2kuYwo+Pj4gaW5kZXggYTk3ZTI1NzFhNTI3Li45YjBlMzQ4MWZlMTcgMTAw
NjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL3BjaS9wY2kuYwo+Pj4gKysrIGIvZHJpdmVycy9wY2kvcGNp
LmMKPj4+IEBAIC01ODU3LDcgKzU4NTcsOCBAQCBpbnQgcGNpX3NldF92Z2Ffc3RhdGUoc3RydWN0
IHBjaV9kZXYgKmRldiwgYm9vbCBkZWNvZGUsCj4+PiAvKioKPj4+ICAqIHBjaV9hZGRfZG1hX2Fs
aWFzIC0gQWRkIGEgRE1BIGRldmZuIGFsaWFzIGZvciBhIGRldmljZQo+Pj4gICogQGRldjogdGhl
IFBDSSBkZXZpY2UgZm9yIHdoaWNoIGFsaWFzIGlzIGFkZGVkCj4+PiAtICogQGRldmZuOiBhbGlh
cyBzbG90IGFuZCBmdW5jdGlvbgo+Pj4gKyAqIEBkZXZmbl9mcm9tOiBhbGlhcyBzbG90IGFuZCBm
dW5jdGlvbgo+Pj4gKyAqIEBucl9kZXZmbnM6IE51bWJlciBvZiBzdWJzZXF1ZW50IGRldmZucyB0
byBhbGlhcwo+Pj4gICoKPj4+ICAqIFRoaXMgaGVscGVyIGVuY29kZXMgYW4gOC1iaXQgZGV2Zm4g
YXMgYSBiaXQgbnVtYmVyIGluIGRtYV9hbGlhc19tYXNrCj4+PiAgKiB3aGljaCBpcyB1c2VkIHRv
IHByb2dyYW0gcGVybWlzc2libGUgYnVzLWRldmZuIHNvdXJjZSBhZGRyZXNzZXMgZm9yIERNQQo+
Pj4gQEAgLTU4NzMsOCArNTg3NCwxNCBAQCBpbnQgcGNpX3NldF92Z2Ffc3RhdGUoc3RydWN0IHBj
aV9kZXYgKmRldiwgYm9vbCBkZWNvZGUsCj4+PiAgKiBjYW5ub3QgYmUgbGVmdCBhcyBhIHVzZXJz
cGFjZSBhY3Rpdml0eSkuICBETUEgYWxpYXNlcyBzaG91bGQgdGhlcmVmb3JlCj4+PiAgKiBiZSBj
b25maWd1cmVkIHZpYSBxdWlya3MsIHN1Y2ggYXMgdGhlIFBDSSBmaXh1cCBoZWFkZXIgcXVpcmsu
Cj4+PiAgKi8KPj4+IC12b2lkIHBjaV9hZGRfZG1hX2FsaWFzKHN0cnVjdCBwY2lfZGV2ICpkZXYs
IHU4IGRldmZuKQo+Pj4gK3ZvaWQgcGNpX2FkZF9kbWFfYWxpYXMoc3RydWN0IHBjaV9kZXYgKmRl
diwgdTggZGV2Zm5fZnJvbSwgdW5zaWduZWQgbnJfZGV2Zm5zKQo+Pj4gewo+Pj4gKwlpbnQgZGV2
Zm5fdG87Cj4+PiArCj4+PiArCWlmIChucl9kZXZmbnMgPiBVOF9NQVgrMSkKPj4+ICsJCW5yX2Rl
dmZucyA9IFU4X01BWCsxOwo+Pgo+PiBXaHkgKzE/IFRoYXQgZG9lc24ndCBzZWVtIHJpZ2h0IHRv
IG1l4oCmLgo+IAo+IFU4X01BWCBpcyB0aGUgbWF4IG51bWJlciBVOCBjYW4gcmVwcmVzZW50KDI1
NSkgYnV0IGlzIG9uZSBsZXNzIHRoYW4gdGhlIG51bWJlciAKPiBvZiB2YWx1ZXMgaXQgY2FuIHJl
cHJlc2VudCgyNTYpLiBkZXZmbnMgY2FuIGJlIDAuMCB0byAxZi43IGluY2x1c2l2ZShJIHRoaW5r
KSAKPiBzbyB0aGUgbnVtYmVyIG9mIHBvc3NpYmxlIGRldmZucyBpcyAyNTYuIFRoaW5raW5nIGFi
b3V0IGl0LCBtYXliZSB0aGUgCj4gemFsbG9jIHNob3VsZCBiZSBVOF9NQVgrMSB0b28/Cj4gCj4g
SSBtaWdodCBiZSB3cm9uZyB0aG91Z2gsIHdoYXQgZG8geW91IHJlY2tvbj8KClJpZ2h0LCB5ZXMs
IGJ1dCBJIGFjdHVhbGx5IHRoaW5rIHRoZSBvcmlnaW5hbCBjb2RlIGlzIHdyb25nLiBJdCdzIG9u
bHkKYWxsb2NhdGluZyBhIGJpdG1hcCB0aGF0IGhvbGRzIDI1NSB2YWx1ZXMgYW5kIHlvdSdyZSB0
cnlpbmcgdG8gaW5zZXJ0CjI1NiBvbmVzIGludG8gdGhhdCBiaXRtYXAuIEl0J3MgcHJvYmFibHkg
b2ssIGJlY2F1c2UgdGhlcmUncyBubyB3YXkgdG8KYWxsb2NhdGUgYW4gb2RkIHNpemVkIGJpdG1h
cCwgYnV0IGl0J3MgcHJvYmFibHkgd29ydGggZml4aW5nIGZvciBjbGFyaXR5LgoKSXQgYWxzbyBs
b29rcyB3cm9uZyBpbiBwY2lfZm9yX2VhY2hfZG1hX2FsaWFzKCkgYXMgd2VsbCwgc28gSSdkIHBy
b2JhYmx5CmZpeCBib3RoIHRob3NlIHVwIGluIGEgc2VwYXJhdGUgcHJlcC1wYXRjaC4KCkxvZ2Fu
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1h
aWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
