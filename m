From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] iommu: dmar: make include of x86_init.h conditional
Date: Fri, 20 Oct 2017 13:35:48 +0200
Message-ID: <20171020113604.2974648-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <y2038-bounces@lists.linaro.org>
List-Unsubscribe: <https://lists.linaro.org/mailman/options/y2038>,
 <mailto:y2038-request@lists.linaro.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/y2038/>
List-Post: <mailto:y2038@lists.linaro.org>
List-Help: <mailto:y2038-request@lists.linaro.org?subject=help>
List-Subscribe: <https://lists.linaro.org/mailman/listinfo/y2038>,
 <mailto:y2038-request@lists.linaro.org?subject=subscribe>
Errors-To: y2038-bounces@lists.linaro.org
Sender: "Y2038" <y2038-bounces@lists.linaro.org>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, x86@kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, y2038@lists.linaro.org, Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

VGhlIGRtYXIgZHJpdmVyIGNhbiBiZSB1c2VkIG9uIGJvdGggeDg2IGFuZCBpdGFuaXVtLCBidXQg
b25seQp0aGUgZm9ybWVyIHVzZXMgdGhlIHg4Nl9pbml0IHN0cnVjdHVyZS4gVGhlIG9ubHkgcmVm
ZXJlbmNlIHRvCnRoYXQgc3RydWN0dXJlIGlzIGVuY2xvc2VkIGluIGFuICNpZmRlZiwgYnV0IHRo
ZSBoZWFkZXIgaW5jbHVzaW9uCkkgYWRkZWQgaXMgbm90LgoKQWRkcyBhbm90aGVyICNpZmRlZiB0
byBnZXQgaWE2NCB0byBidWlsZCBhZ2Fpbi4KCkZpeGVzOiAwZjVhMGY0ZjA2MmMgKCJ4ODY6IGRv
bid0IGluY2x1ZGUgYXNtL3g4Nl9pbml0LmggaW4gYXNtL3NldHVwLmgiKQpTaWduZWQtb2ZmLWJ5
OiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPgotLS0KVGhlIGJyb2tlbiBjb21taXQgaXMg
aW4geDg2L3RpbWVycywgcGxlYXNlIGFkZCB0aGlzIG9uZSBvbiB0b3AKLS0tCiBkcml2ZXJzL2lv
bW11L2RtYXIuYyB8IDIgKysKIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2lvbW11L2RtYXIuYyBiL2RyaXZlcnMvaW9tbXUvZG1hci5jCmluZGV4
IGU5MzA0ZDYyNDdlMS4uZWQxZGQxM2UwM2FjIDEwMDY0NAotLS0gYS9kcml2ZXJzL2lvbW11L2Rt
YXIuYworKysgYi9kcml2ZXJzL2lvbW11L2RtYXIuYwpAQCAtNDEsNyArNDEsOSBAQAogI2luY2x1
ZGUgPGxpbnV4L2lvbW11Lmg+CiAjaW5jbHVkZSA8YXNtL2lycV9yZW1hcHBpbmcuaD4KICNpbmNs
dWRlIDxhc20vaW9tbXVfdGFibGUuaD4KKyNpZmRlZiBDT05GSUdfWDg2CiAjaW5jbHVkZSA8YXNt
L3g4Nl9pbml0Lmg+CisjZW5kaWYKIAogI2luY2x1ZGUgImlycV9yZW1hcHBpbmcuaCIKIAotLSAK
Mi45LjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClky
MDM4IG1haWxpbmcgbGlzdApZMjAzOEBsaXN0cy5saW5hcm8ub3JnCmh0dHBzOi8vbGlzdHMubGlu
YXJvLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3kyMDM4Cg==
