From: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v2 5/9] drm/amdkfd: use helper pci_dev_id
Date: Thu, 25 Apr 2019 06:57:58 +0000
Message-ID: <60b20405-8876-5e9d-0a81-b3df4ee6a87a@amd.com>
References: <2e1f9a57-6d08-d017-24da-3e6b97fa2449@gmail.com>
 <50613002-d5a2-2522-b183-4ab156686fce@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <50613002-d5a2-2522-b183-4ab156686fce-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Content-ID: <F36A8201B3B6F94F8F611443161D8B87-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Realtek linux nic maintainers <nic_swsd-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Giuseppe Cavallaro <peppe.cavallaro-qxv4g6HH51o@public.gmane.org>, Alexandre Torgue <alexandre.torgue-qxv4g6HH51o@public.gmane.org>, Jose Abreu <joabreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Benson Leung <bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>
Cc: "open list:8169 10/100/1000 GIGABIT
 ETHERNET DRIVER" <netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "open list:AMD IOMMU (AMD-VI)" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "open list:AMD KFD" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "open
 list:PCI SUBSYSTEM" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "moderated list:ARM/STM32
 ARCHITECTURE" <linux-stm32-XDFAJ8BFU24N7RejjzZ/Li2xQDfSxrLKVpNB7YpNyf8@public.gmane.org>, "moderated
 list:ARM/STM32 ARCHITECTURE" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

QW0gMjQuMDQuMTkgdW0gMjE6MTQgc2NocmllYiBIZWluZXIgS2FsbHdlaXQ6DQo+IFVzZSBuZXcg
aGVscGVyIHBjaV9kZXZfaWQoKSB0byBzaW1wbGlmeSB0aGUgY29kZS4NCj4NCj4gU2lnbmVkLW9m
Zi1ieTogSGVpbmVyIEthbGx3ZWl0IDxoa2FsbHdlaXQxQGdtYWlsLmNvbT4NCg0KQWNrZWQtYnk6
IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCg0KPiAtLS0NCj4g
ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfdG9wb2xvZ3kuYyB8IDMgKy0tDQo+ICAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3RvcG9sb2d5LmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfdG9wb2xvZ3kuYw0KPiBpbmRleCAyY2IwOWUwODgu
Ljc2OWRiYzdiZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2Zk
X3RvcG9sb2d5LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3RvcG9s
b2d5LmMNCj4gQEAgLTEyNzIsOCArMTI3Miw3IEBAIGludCBrZmRfdG9wb2xvZ3lfYWRkX2Rldmlj
ZShzdHJ1Y3Qga2ZkX2RldiAqZ3B1KQ0KPiAgIA0KPiAgIAlkZXYtPm5vZGVfcHJvcHMudmVuZG9y
X2lkID0gZ3B1LT5wZGV2LT52ZW5kb3I7DQo+ICAgCWRldi0+bm9kZV9wcm9wcy5kZXZpY2VfaWQg
PSBncHUtPnBkZXYtPmRldmljZTsNCj4gLQlkZXYtPm5vZGVfcHJvcHMubG9jYXRpb25faWQgPSBQ
Q0lfREVWSUQoZ3B1LT5wZGV2LT5idXMtPm51bWJlciwNCj4gLQkJZ3B1LT5wZGV2LT5kZXZmbik7
DQo+ICsJZGV2LT5ub2RlX3Byb3BzLmxvY2F0aW9uX2lkID0gcGNpX2Rldl9pZChncHUtPnBkZXYp
Ow0KPiAgIAlkZXYtPm5vZGVfcHJvcHMubWF4X2VuZ2luZV9jbGtfZmNvbXB1dGUgPQ0KPiAgIAkJ
YW1kZ3B1X2FtZGtmZF9nZXRfbWF4X2VuZ2luZV9jbG9ja19pbl9taHooZGV2LT5ncHUtPmtnZCk7
DQo+ICAgCWRldi0+bm9kZV9wcm9wcy5tYXhfZW5naW5lX2Nsa19jY29tcHV0ZSA9DQoNCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
