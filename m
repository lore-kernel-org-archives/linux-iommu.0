From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Subject: Re: [RESEND PATCH v2 2/6] PCI: Set PCI_BUS_FLAGS_MSI_REMAP if MSI
 controller enables IRQ remapping
Date: Mon, 6 Jun 2016 16:21:35 +0800
Message-ID: <201606060821.u568JFxu010784@mx0a-001b2d01.pphosted.com>
References: <201606060406.lSpseFnO%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <201606060406.lSpseFnO%fengguang.wu@intel.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: kbuild test robot <lkp@intel.com>
Cc: kevin.tian@intel.com, nikunj@linux.vnet.ibm.com, kvm@vger.kernel.org, eric.auger@linaro.org, aik@ozlabs.ru, linux-pci@vger.kernel.org, joro@8bytes.org, will.deacon@arm.com, gwshan@linux.vnet.ibm.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, warrier@linux.vnet.ibm.com, alex.williamson@redhat.com, David.Laight@ACULAB.COM, paulus@samba.org, zhong@linux.vnet.ibm.com, alistair@popple.id.au, bhelgaas@google.com, linuxppc-dev@lists.ozlabs.org, kbuild-all@01.org
List-Id: iommu@lists.linux-foundation.org

T24gMjAxNi82LzYgNDoxMCwga2J1aWxkIHRlc3Qgcm9ib3Qgd3JvdGU6Cgo+IEhpLAo+Cj4gW2F1
dG8gYnVpbGQgdGVzdCBFUlJPUiBvbiB2ZmlvL25leHRdCj4gW2Fsc28gYnVpbGQgdGVzdCBFUlJP
UiBvbiB2NC43LXJjMSBuZXh0LTIwMTYwNjAzXQo+IFtjYW5ub3QgYXBwbHkgdG8gcGNpL25leHRd
Cj4gW2lmIHlvdXIgcGF0Y2ggaXMgYXBwbGllZCB0byB0aGUgd3JvbmcgZ2l0IHRyZWUsIHBsZWFz
ZSBkcm9wIHVzIGEgbm90ZSB0byBoZWxwIGltcHJvdmUgdGhlIHN5c3RlbV0KPgo+IHVybDogICAg
aHR0cHM6Ly9naXRodWIuY29tLzBkYXktY2kvbGludXgvY29tbWl0cy9Zb25namktWGllL1BDSS1B
ZGQtYS1uZXctUENJX0JVU19GTEFHU19NU0lfUkVNQVAtZmxhZy8yMDE2MDUzMC0yMTUzNDgKPiBi
YXNlOiAgIGh0dHBzOi8vZ2l0aHViLmNvbS9hd2lsbGlhbS9saW51eC12ZmlvLmdpdCBuZXh0Cj4g
Y29uZmlnOiBhcm0tc2ExMTAwIChhdHRhY2hlZCBhcyAuY29uZmlnKQo+IGNvbXBpbGVyOiBhcm0t
bGludXgtZ251ZWFiaS1nY2MgKERlYmlhbiA1LjMuMS04KSA1LjMuMSAyMDE2MDIwNQo+IHJlcHJv
ZHVjZToKPiAgICAgICAgICB3Z2V0IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvY2dpdC9saW51eC9r
ZXJuZWwvZ2l0L3dmZy9sa3AtdGVzdHMuZ2l0L3BsYWluL3NiaW4vbWFrZS5jcm9zcyAtTyB+L2Jp
bi9tYWtlLmNyb3NzCj4gICAgICAgICAgY2htb2QgK3ggfi9iaW4vbWFrZS5jcm9zcwo+ICAgICAg
ICAgICMgc2F2ZSB0aGUgYXR0YWNoZWQgLmNvbmZpZyB0byBsaW51eCBidWlsZCB0cmVlCj4gICAg
ICAgICAgbWFrZS5jcm9zcyBBUkNIPWFybQo+Cj4gQWxsIGVycm9ycyAobmV3IG9uZXMgcHJlZml4
ZWQgYnkgPj4pOgo+Cj4gICAgIGRyaXZlcnMvYnVpbHQtaW4ubzogSW4gZnVuY3Rpb24gYHBjaV9z
ZXRfYnVzX21zaV9kb21haW4nOgo+Pj4gYXJtX3BtdS5jOigudGV4dCsweDVjNTgpOiB1bmRlZmlu
ZWQgcmVmZXJlbmNlIHRvIGBwY2lfYnVzX21zaV9pc29sYXRlZCcKClNvcnJ5IGZvciB0aGlzIGZh
dWx0LiBJIHdpbGwgZml4IGl0IGluIG5leHQgdmVyc2lvbi4gIFRoZSAKcGNpX2J1c19tc2lfaXNv
bGF0ZWQoKSBzaG91bGQgbm90CmRlcGVuZCBvbiBDT05GSUdfUENJX01TSSwgSSB3b3VsZCBtb3Zl
IHRoaXMgZnVuY3Rpb24gZnJvbSAKZHJpdmVycy9wY2kvbXNpLmMgdG8KZHJpdmVycy9wY2kvcHJv
YmUuYy4KClRoYW5rcywKWW9uZ2ppCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpMaW51eHBwYy1kZXYgbWFpbGluZyBsaXN0CkxpbnV4cHBjLWRldkBsaXN0
cy5vemxhYnMub3JnCmh0dHBzOi8vbGlzdHMub3psYWJzLm9yZy9saXN0aW5mby9saW51eHBwYy1k
ZXY=
