From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v8 03/13] KVM: Define a new interface
	kvm_intr_is_single_vcpu()
Date: Fri, 18 Sep 2015 18:16:32 +0200
Message-ID: <20150918161631.GA27908@potion.brq.redhat.com>
References: <1442393409-2623-1-git-send-email-feng.wu@intel.com>
	<1442393409-2623-4-git-send-email-feng.wu@intel.com>
	<55F934F5.7040605@redhat.com>
	<E959C4978C3B6342920538CF579893F002716FFA@SHSMSX104.ccr.corp.intel.com>
	<55FA8AED.6090700@redhat.com>
	<E959C4978C3B6342920538CF579893F002718968@SHSMSX104.ccr.corp.intel.com>
	<55FACD35.1030602@redhat.com>
	<20150917155821.GB2573@potion.brq.redhat.com>
	<55FAE395.4000008@redhat.com>
	<E959C4978C3B6342920538CF579893F00271A691@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <E959C4978C3B6342920538CF579893F00271A691-0J0gbvR4kTg/UvCtAeCM4rfspsVTdybXVpNB7YpNyf8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Wu, Feng" <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "mtosatti-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <mtosatti-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

MjAxNS0wOS0xNyAyMzoxOCswMDAwLCBXdSwgRmVuZzoKPj4gRnJvbTogUGFvbG8gQm9uemluaSBb
bWFpbHRvOnBib256aW5pQHJlZGhhdC5jb21dCj4+IE9uIDE3LzA5LzIwMTUgMTc6NTgsIFJhZGlt
IEtyxI1tw6HFmSB3cm90ZToKPj4+IHhBUElDIGFkZHJlc3MgYXJlIG9ubHkgOCBiaXQgbG9uZyBz
byB0aGV5IGFsd2F5cyBnZXQgZGVsaXZlcmVkIHRvIHgyQVBJQwo+Pj4gY2x1c3RlciAwLCB3aGVy
ZSBmaXJzdCAxNiBiaXRzIHdvcmsgbGlrZSB4QVBJQyBmbGF0IGxvZ2ljYWwgbW9kZS4KPj4gCj4+
IE9rLCBJIHdhcyB3b25kZXJpbmcgd2hldGhlciB0aGlzIHdhcyB0aGUgY29ycmVjdCBpbnRlcnBy
ZXRhdGlvbi4gIFRoYW5rcyEKPiAKPiBQYW9sbywgSSBkb24ndCB0aGluayBSYWRpbSBjbGFyaWZ5
IHlvdXIgY29uY2VybiwgcmlnaHQ/IFNpbmNlIG1kYSBpcyA4LWJpdCwgaXQKPiBpcyB3cm9uZyB3
aXRoIG1kYSA+PiAxNiwgdGhpcyBpcyB5b3VyIGNvbmNlcm4sIHJpZ2h0PwoKSW4gY2FzZSBpdCB3
YXM6ICBtZGEgaXMgdTMyIHNvIHRoZSBiaXRzaGlmdCBpcyBkZWZpbmVkIGJ5IEMuCih4QVBJQyBk
ZXN0aW5hdGlvbnMgaW4gS1ZNJ3MgeDJBUElDIG1vZGUgYXJlIHN0b3JlZCBpbiBsb3dlc3QgOCBi
aXRzIG9mCiBtZGEsIGhlbmNlIHRoZSBjbHVzdGVyIGlzIGFsd2F5cyAwLikKCk9yIGFtIEkgc3Rp
bGwgbWlzc2luZyB0aGUgcG9pbnQ/Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by9pb21tdQ==
