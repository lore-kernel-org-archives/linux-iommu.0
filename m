Return-Path: <SRS0=kThj=K4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20701C4708F
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 08:58:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3AEF613AE
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 08:58:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3AEF613AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 90724605C2;
	Wed,  2 Jun 2021 08:58:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pMvCGyage3JH; Wed,  2 Jun 2021 08:58:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 88394606DC;
	Wed,  2 Jun 2021 08:58:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 65743C000E;
	Wed,  2 Jun 2021 08:58:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1C01BC0001
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 08:45:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EEBC483935
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 08:45:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kSa5sDubmRvN for <iommu@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 08:45:09 +0000 (UTC)
X-Greylist: delayed 00:05:34 by SQLgrey-1.8.0
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A00E0838D7
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 08:45:05 +0000 (UTC)
Received: from [192.168.1.155] ([95.114.42.59]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MFsAJ-1lbUtk1PzT-00HQ57; Wed, 02 Jun 2021 10:38:55 +0200
Subject: Re: [RFC] /dev/ioasid uAPI proposal
To: Parav Pandit <parav@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Lu Baolu <baolu.lu@linux.intel.com>,
 David Woodhouse <dwmw2@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Alex Williamson (alex.williamson@redhat.com)" <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <PH0PR12MB5481C1B2249615257A461EEDDC3F9@PH0PR12MB5481.namprd12.prod.outlook.com>
From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <06892e6a-02c9-6c25-84eb-6a4b2177b48d@metux.net>
Date: Wed, 2 Jun 2021 10:38:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481C1B2249615257A461EEDDC3F9@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Language: tl
X-Provags-ID: V03:K1:l+r3sN5SfjQDzPJscBIPShHltDwqwPcayg5WV/CYRoSgPIqQpVf
 nypmndPm+Xcga8629Rm3atqfOUY4jtIpCRBkSvl3tL9FdJLtVCs2fkgZOVCMoIk+e6poH6N
 Lr1tS/QP3jPWg8oSFFvv1qUsaZfJobcxa3TkLpasX1rJQr+iKvnAf+so6R+0G298HvJhAsJ
 ckCAZxKX77S/iFXJir6Vg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9o6QtBDvWdM=:Ms9IhfPCknnQWNsxpF2MXn
 P0jAMZgwgIGi3mTY/UcyXY+tlSR3Ds8heUrozsfmif7rQajdKlb1Os15umCld9E88ck39zUYO
 FP6yQKioZvlalkx8Weg3CJpah3bq9YG3wk/6Wvp/2c/c53OJQ1yTIzcsRz+zTN3tM4QRhvSXD
 GkjUz11DJ+YyKGJVO3+4Ejr2+ypGGi965hL1ytFUI3SnX7RVUE1mHBvWjzaEeD7hpJbVq+Bdc
 vlFRn1XV3tidKLz4fRhq+3EVglM8Dy78eaKPTYol457LmeLKuPFO8Jxxq6AwguuttP1Bfe2IS
 2iPG+3slfiDpvvSE9xqCYdM0CAv6BmfkZTEsA4MXizDxKTqQHuHOrwIOZRidNAJelF1v3GhWv
 te4cTVK5gvgNs+PQ3LTnsFdy3bI8VXffLcFsztdRnWUGXVaC/79tj1zZyRZbNUCPMSilGQ8+I
 lFXLtKDJLfF2NpnxmjYgw8mnuRxuSY5n3xzjC0ZA9Hq40aSWNOBeYcY8jsROdV7TYPUTS03JX
 glKjlrBc/HOXsO8Db9cDKU=
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

T24gMzEuMDUuMjEgMTk6MzcsIFBhcmF2IFBhbmRpdCB3cm90ZToKCj4gSXQgYXBwZWFycyB0aGF0
IHRoaXMgaXMgb25seSB0byBtYWtlIG1hcCBpb2N0bCBmYXN0ZXIgYXBhcnQgZnJvbSBhY2NvdW50
aW5nLgo+IEl0IGRvZXNuJ3QgaGF2ZSBhbnkgaW9hc2lkIGhhbmRsZSBpbnB1dCBlaXRoZXIuCj4g
Cj4gSW4gdGhhdCBjYXNlLCBjYW4gaXQgYmUgYSBuZXcgc3lzdGVtIGNhbGw/IFdoeSBkb2VzIGl0
IGhhdmUgdG8gYmUgdW5kZXIgL2Rldi9pb2FzaWQ/Cj4gRm9yIGV4YW1wbGUgZmV3IHllYXJzIGJh
Y2sgc3VjaCBzeXN0ZW0gY2FsbCBtcGluKCkgdGhvdWdodCB3YXMgcHJvcG9zZWQgaW4gWzFdLgoK
SSdtIHZlcnkgcmVsdWN0YW50IHRvIG1vcmUgc3lzY2FsbCBpbmZsYXRpb24uIFdlIGFscmVhZHkg
aGF2ZSBsb3RzIG9mCnN5c2NhbGxzIHRoYXQgY291bGQgaGF2ZSBiZWVuIGVhc2lseSBkb25lIHZp
YSBkZXZpY2VzIG9yIGZpbGVzeXN0ZW1zCih5ZXMsIHNvbWUgb2YgdGhlbSBhcmUganVzdCBvbGQg
VW5peCByZWxpY3MpLgoKU3lzY2FsbHMgZG9uJ3QgcGxheSB3ZWxsIHcvIG1vZHVsZXMsIGNvbnRh
aW5lcnMsIGRpc3RyaWJ1dGVkIHN5c3RlbXMsCmV0YywgYW5kIG5lZWQgZXh0cmEgbG93LWxldmVs
IGNvZGUgZm9yIG1vc3Qgbm9uLUMgbGFuZ3VhZ2VzIChlZy4Kc2NyaXB0aW5nIGxhbmd1YWdlcyku
CgoKLS1tdHgKCi0tIAotLS0KSGlud2VpczogdW52ZXJzY2hsw7xzc2VsdGUgRS1NYWlscyBrw7Zu
bmVuIGxlaWNodCBhYmdlaMO2cnQgdW5kIG1hbmlwdWxpZXJ0CndlcmRlbiAhIEbDvHIgZWluZSB2
ZXJ0cmF1bGljaGUgS29tbXVuaWthdGlvbiBzZW5kZW4gU2llIGJpdHRlIGlocmVuCkdQRy9QR1At
U2NobMO8c3NlbCB6dS4KLS0tCkVucmljbyBXZWlnZWx0LCBtZXR1eCBJVCBjb25zdWx0CkZyZWUg
c29mdHdhcmUgYW5kIExpbnV4IGVtYmVkZGVkIGVuZ2luZWVyaW5nCmluZm9AbWV0dXgubmV0IC0t
ICs0OS0xNTEtMjc1NjUyODcKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lv
bW11
