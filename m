From: Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v8 03/13] KVM: Define a new interface
	kvm_intr_is_single_vcpu()
Date: Fri, 18 Sep 2015 18:17:29 +0200
Message-ID: <55FC3919.9030204@redhat.com>
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
	<20150918161631.GA27908@potion.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150918161631.GA27908-KfRq7+sF/6zkZJWtSm8s3NvLeJWuRmrY@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Wu, Feng" <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "mtosatti-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <mtosatti-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

CgpPbiAxOC8wOS8yMDE1IDE4OjE2LCBSYWRpbSBLcsSNbcOhxZkgd3JvdGU6Cj4+PiA+PiBPaywg
SSB3YXMgd29uZGVyaW5nIHdoZXRoZXIgdGhpcyB3YXMgdGhlIGNvcnJlY3QgaW50ZXJwcmV0YXRp
b24uICBUaGFua3MhCj4+ID4gCj4+ID4gUGFvbG8sIEkgZG9uJ3QgdGhpbmsgUmFkaW0gY2xhcmlm
eSB5b3VyIGNvbmNlcm4sIHJpZ2h0PyBTaW5jZSBtZGEgaXMgOC1iaXQsIGl0Cj4+ID4gaXMgd3Jv
bmcgd2l0aCBtZGEgPj4gMTYsIHRoaXMgaXMgeW91ciBjb25jZXJuLCByaWdodD8KPiBJbiBjYXNl
IGl0IHdhczogIG1kYSBpcyB1MzIgc28gdGhlIGJpdHNoaWZ0IGlzIGRlZmluZWQgYnkgQy4KPiAo
eEFQSUMgZGVzdGluYXRpb25zIGluIEtWTSdzIHgyQVBJQyBtb2RlIGFyZSBzdG9yZWQgaW4gbG93
ZXN0IDggYml0cyBvZgo+ICBtZGEsIGhlbmNlIHRoZSBjbHVzdGVyIGlzIGFsd2F5cyAwLikKPiAK
PiBPciBhbSBJIHN0aWxsIG1pc3NpbmcgdGhlIHBvaW50PwoKWWVzLCByZW1lbWJlcmluZyB0aGF0
IHRoZSBjbHVzdGVyIGlzIGFsd2F5cyAwIHNvbHZlZCBteSBkb3VidC4KClBhb2xvCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlz
dAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
