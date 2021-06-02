Return-Path: <SRS0=kThj=K4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A84C47093
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 08:58:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E75AC613D6
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 08:58:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E75AC613D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B261F400FE;
	Wed,  2 Jun 2021 08:58:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4LxO-69M39qX; Wed,  2 Jun 2021 08:58:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1C6CD4022B;
	Wed,  2 Jun 2021 08:58:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 967F7C0025;
	Wed,  2 Jun 2021 08:58:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86D72C0001
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 08:57:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 68A6082F0F
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 08:57:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L6U45Rf7DgA6 for <iommu@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 08:57:28 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0534A836A7
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 08:57:27 +0000 (UTC)
Received: from [192.168.1.155] ([95.114.42.59]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MGi6k-1lafIq3Oew-00DpdX; Wed, 02 Jun 2021 10:56:54 +0200
Subject: Re: [RFC] /dev/ioasid uAPI proposal
To: "Tian, Kevin" <kevin.tian@intel.com>, LKML
 <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Lu Baolu <baolu.lu@linux.intel.com>,
 David Woodhouse <dwmw2@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Alex Williamson (alex.williamson@redhat.com)" <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <bb6846bf-bd3c-3802-e0d7-226ec9b33384@metux.net>
Date: Wed, 2 Jun 2021 10:56:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
Content-Language: tl
X-Provags-ID: V03:K1:3Mcq2cb/Ii9ywxMSUXsDQ9pb2+iZexTll119bJZkqKn6n/uAzeX
 vlBuy8gzAJoHwUTbHF/NioLbLGK4SyvZhqUm5yg9cGiQY7V3evXE44KhVXzMiMGt4/Cf+0t
 hvumRBsesWj4xZHsQkSA4vYDmw15qUKwS9PxlgOBBhlXZjg4HB0b/+dgqTxrCfE6CEVuKRJ
 5GqKWS9lwAjodld6KcrWg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3T0vIilwMWM=:yox9K5pXkfYHqVr3zyrSGk
 pGHofGYSVKITUO56tzDTQQeMUlqiezJiY1iU1N2g8mBSjXRkRt+qit8y3/H+qDaEx6FWUD+T8
 2zxEo4s6fiqhOyQpOf/+BHispEZ03VAeISfUlEJKfkbx0+WjuNHEgeVRxX87ighdQNSgPyiqe
 PILXaXDH1s/q3xSA1qZxtRc+TXuVzZSyj1Ao92QnuDLbX4EbtQ319zNW1yhF4uuC7l+1bSrac
 IWdfwXu73ZKzhJCNW4czH/r58AyDTa/vELP2yx2cqMoHiRyhuxLlQtM+EBL3qmroRYzGoYeC9
 oemgnJQKz8baqNs8M8Co5+2EPoSuDqCqpyEAwBU8g1itzuGflXO0f+KsrSjHAnUqF5/0/x3vI
 cqqFbSmyhFiO5UfQcV1zRJpzELKcdxjFCEZYPk9TPz09cIbdBOVqURnwMRB0ODmBHJanmCKKH
 XHmd3gq/QOWATPJVNXYOtnsgmxwIYMdMShNnrfKWSNKuj4YMT0R7JH2ZVa1B/zNfJrgZqwnUo
 GLmx9XbSg7JKS6nsTmdDqY=
X-Mailman-Approved-At: Wed, 02 Jun 2021 08:58:15 +0000
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Kirti Wankhede <kwankhede@nvidia.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Robin Murphy <robin.murphy@arm.com>
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

T24gMjcuMDUuMjEgMDk6NTgsIFRpYW4sIEtldmluIHdyb3RlOgoKSGksCgo+IC9kZXYvaW9hc2lk
IHByb3ZpZGVzIGFuIHVuaWZpZWQgaW50ZXJmYWNlIGZvciBtYW5hZ2luZyBJL08gcGFnZSB0YWJs
ZXMgZm9yCj4gZGV2aWNlcyBhc3NpZ25lZCB0byB1c2Vyc3BhY2UuIERldmljZSBwYXNzdGhyb3Vn
aCBmcmFtZXdvcmtzIChWRklPLCB2RFBBLAo+IGV0Yy4pIGFyZSBleHBlY3RlZCB0byB1c2UgdGhp
cyBpbnRlcmZhY2UgaW5zdGVhZCBvZiBjcmVhdGluZyB0aGVpciBvd24gbG9naWMgdG8KPiBpc29s
YXRlIHVudHJ1c3RlZCBkZXZpY2UgRE1BcyBpbml0aWF0ZWQgYnkgdXNlcnNwYWNlLgoKV2hpbGUg
SSdtIGluIGZhdm91ciBvZiBoYXZpbmcgZ2VuZXJpYyBBUElzIGZvciBnZW5lcmljIHRhc2tzLCBh
cyB3ZWxsIGFzCnVzaW5nIEZEcywgSSB3b25kZXIgd2hldGhlciBpdCBoYXMgdG8gYmUgYSBuZXcg
YW5kIHNlcGFyYXRlIGRldmljZS4KCk5vdyBhcHBsaWNhdGlvbnMgaGF2ZSB0byB1c2UgbXVsdGlw
bGUgQVBJcyBpbiBsb2Nrc3RlcC4gT25lIGNvbnNlcXVlbmNlCm9mIHRoYXQgaXMgb3BlcmF0b3Jz
LCBhcyB3ZWxsIGFzIHByb3Zpc2lvbmluZyBzeXN0ZW1zLCBjb250YWluZXIKaW5mcmFzdHJ1Y3R1
cmVzLCBldGMsIGFsd2F5cyBoYXZlIHRvIGNvbnNpZGVyIG11bHRpcGxlIGRldmljZXMgdG9nZXRo
ZXIuCgpZb3UgY2FuJ3QganVzdCBzYXkgImdpdmUgd29ya2xvYWQgWFkgYWNjZXNzIHRvIGRldmlj
ZSAvZGV2L2ZvbyIgYW55bW9yZS4KTm93IHlvdSBoYXZlIHRvIHRha2UgY2FyZSBhYm91dCBzY2Vu
YXJpb3MgbGlrZSAiaWYgc29tZW9uZSB3YW50cwovZGV2L2ZvbywgaGUgYWxzbyBuZWVkcyAvZGV2
L2JhciIpLiBBbmQgaWYgdGhhdCBoYXBwZW5zIG11bHRpcGxlIHRpbWVzCnRvZ2V0aGVyICgiL2Rl
di9mb28gYW5kIC9kZXYvd3Vyc3QsIGJvdGggcmVxdWlyZSAvZGV2L2JhciksIGxlYWRpbmcgdG8K
c2NlbmFyaW9zIGxpa2UgdGhlIGRldiBub2RlcyBhcmUgYmluZC1tb3VudGVkIHNvbWV3aGVyZSwg
eW91IG5lZWQgdG8KdGFrZSBjYXJlIHRoYXQgYWRkaXRpb25hbCBkZXZpY2VzIGFyZW4ndCBiaW5k
LW1vdW50ZWQgdHdpY2UsIGV0YyAuLi4KCklmIEkgdW5kZXJzdGFuZCB0aGlzIGNvcnJlY3RseSwg
L2Rldi9pb2FzaWQgaXMgYSBraW5kIG9mICJjb21tb24gCnN1cHBsaWVyIiB0byBvdGhlciBBUElz
IC8gZGV2aWNlcy4gV2h5IGNhbid0IHRoZSBmZCBiZSBhY3F1aXJlZCBieSB0aGUKY29uc3VtZXIg
QVBJcyAoZWcuIGt2bSwgdmZpbywgZXRjKSA/CgoKLS1tdHgKCi0tIAotLS0KSGlud2VpczogdW52
ZXJzY2hsw7xzc2VsdGUgRS1NYWlscyBrw7ZubmVuIGxlaWNodCBhYmdlaMO2cnQgdW5kIG1hbmlw
dWxpZXJ0CndlcmRlbiAhIEbDvHIgZWluZSB2ZXJ0cmF1bGljaGUgS29tbXVuaWthdGlvbiBzZW5k
ZW4gU2llIGJpdHRlIGlocmVuCkdQRy9QR1AtU2NobMO8c3NlbCB6dS4KLS0tCkVucmljbyBXZWln
ZWx0LCBtZXR1eCBJVCBjb25zdWx0CkZyZWUgc29mdHdhcmUgYW5kIExpbnV4IGVtYmVkZGVkIGVu
Z2luZWVyaW5nCmluZm9AbWV0dXgubmV0IC0tICs0OS0xNTEtMjc1NjUyODcKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0Cmlv
bW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
